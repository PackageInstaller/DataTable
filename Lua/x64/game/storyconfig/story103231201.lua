return {
	Play323121001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 323121001
		arg_1_1.duration_ = 6.3

		local var_1_0 = {
			zh = 5.433,
			ja = 6.3
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
				arg_1_0:Play323121002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "ST2005"

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
				local var_4_5 = arg_1_1.bgs_.ST2005

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
					if iter_4_0 ~= "ST2005" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = 0

			if var_4_16 < arg_1_1.time_ and arg_1_1.time_ <= var_4_16 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_17 = 0.3

			if arg_1_1.time_ >= var_4_16 + var_4_17 and arg_1_1.time_ < var_4_16 + var_4_17 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_18 = 0

			if var_4_18 < arg_1_1.time_ and arg_1_1.time_ <= var_4_18 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_19 = 2

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

			local var_4_24 = "10170ui_story"

			if arg_1_1.actors_[var_4_24] == nil then
				local var_4_25 = Asset.Load("Char/" .. "10170ui_story")

				if not isNil(var_4_25) then
					local var_4_26 = Object.Instantiate(Asset.Load("Char/" .. "10170ui_story"), arg_1_1.stage_.transform)

					var_4_26.name = var_4_24
					var_4_26.transform.localPosition = Vector3.New(0, 100, 0)
					arg_1_1.actors_[var_4_24] = var_4_26

					local var_4_27 = var_4_26:GetComponentInChildren(typeof(CharacterEffect))

					var_4_27.enabled = true

					local var_4_28 = GameObjectTools.GetOrAddComponent(var_4_26, typeof(DynamicBoneHelper))

					if var_4_28 then
						var_4_28:EnableDynamicBone(false)
					end

					arg_1_1:ShowWeapon(var_4_27.transform, false)

					arg_1_1.var_[var_4_24 .. "Animator"] = var_4_27.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_1_1.var_[var_4_24 .. "Animator"].applyRootMotion = true
					arg_1_1.var_[var_4_24 .. "LipSync"] = var_4_27.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_4_29 = arg_1_1.actors_["10170ui_story"]
			local var_4_30 = 0

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 and not isNil(var_4_29) and arg_1_1.var_.characterEffect10170ui_story == nil then
				arg_1_1.var_.characterEffect10170ui_story = var_4_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_31 = 0.200000002980232

			if var_4_30 <= arg_1_1.time_ and arg_1_1.time_ < var_4_30 + var_4_31 and not isNil(var_4_29) then
				local var_4_32 = (arg_1_1.time_ - var_4_30) / var_4_31

				if arg_1_1.var_.characterEffect10170ui_story and not isNil(var_4_29) then
					arg_1_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= var_4_30 + var_4_31 and arg_1_1.time_ < var_4_30 + var_4_31 + arg_4_0 and not isNil(var_4_29) and arg_1_1.var_.characterEffect10170ui_story then
				arg_1_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_4_33 = 0
			local var_4_34 = 0.3

			if var_4_33 < arg_1_1.time_ and arg_1_1.time_ <= var_4_33 + arg_4_0 then
				local var_4_35 = "play"
				local var_4_36 = "music"

				arg_1_1:AudioAction(var_4_35, var_4_36, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_37 = ""
				local var_4_38 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_38 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_38 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_38

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_38
						arg_1_1.bgmTxt2_.text = var_4_38
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

			local var_4_39 = 0.433333333333333
			local var_4_40 = 1

			if var_4_39 < arg_1_1.time_ and arg_1_1.time_ <= var_4_39 + arg_4_0 then
				local var_4_41 = "play"
				local var_4_42 = "music"

				arg_1_1:AudioAction(var_4_41, var_4_42, "bgm_activity_4_8_story_mountain_kunlun", "bgm_activity_4_8_story_mountain_kunlun", "bgm_activity_4_8_story_mountain_kunlun.awb")

				local var_4_43 = ""
				local var_4_44 = manager.audio:GetAudioName("bgm_activity_4_8_story_mountain_kunlun", "bgm_activity_4_8_story_mountain_kunlun")

				if var_4_44 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_44 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_44

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_44
						arg_1_1.bgmTxt2_.text = var_4_44
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

			local var_4_45 = 0.166666666666667
			local var_4_46 = 1

			if var_4_45 < arg_1_1.time_ and arg_1_1.time_ <= var_4_45 + arg_4_0 then
				local var_4_47 = "play"
				local var_4_48 = "effect"

				arg_1_1:AudioAction(var_4_47, var_4_48, "se_story_148", "se_story_148_amb_ice_cave", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_49 = 2
			local var_4_50 = 0.325

			if var_4_49 < arg_1_1.time_ and arg_1_1.time_ <= var_4_49 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_51 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_51:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_51:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_51:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_52 = arg_1_1:FormatText(StoryNameCfg[1450].name)

				arg_1_1.leftNameTxt_.text = var_4_52

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10170")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_53 = arg_1_1:GetWordFromCfg(323121001)
				local var_4_54 = arg_1_1:FormatText(var_4_53.content)

				arg_1_1.text_.text = var_4_54

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_55 = 13
				local var_4_56 = utf8.len(var_4_54)
				local var_4_57 = var_4_55 <= 0 and var_4_50 or var_4_50 * (var_4_56 / var_4_55)

				if var_4_57 > 0 and var_4_50 < var_4_57 then
					arg_1_1.talkMaxDuration = var_4_57
					var_4_49 = var_4_49 + 0.3

					if var_4_57 + var_4_49 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_57 + var_4_49
					end
				end

				arg_1_1.text_.text = var_4_54
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323121", "323121001", "story_v_out_323121.awb") ~= 0 then
					local var_4_58 = manager.audio:GetVoiceLength("story_v_out_323121", "323121001", "story_v_out_323121.awb") / 1000

					if var_4_58 + var_4_49 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_58 + var_4_49
					end

					if var_4_53.prefab_name ~= "" and arg_1_1.actors_[var_4_53.prefab_name] ~= nil then
						local var_4_59 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_53.prefab_name].transform, "story_v_out_323121", "323121001", "story_v_out_323121.awb")

						arg_1_1:RecordAudio("323121001", var_4_59)
						arg_1_1:RecordAudio("323121001", var_4_59)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_323121", "323121001", "story_v_out_323121.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_323121", "323121001", "story_v_out_323121.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_60 = var_4_49 + 0.3
			local var_4_61 = math.max(var_4_50, arg_1_1.talkMaxDuration)

			if var_4_60 <= arg_1_1.time_ and arg_1_1.time_ < var_4_60 + var_4_61 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_60) / var_4_61

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_60 + var_4_61 and arg_1_1.time_ < var_4_60 + var_4_61 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play323121002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 323121002
		arg_9_1.duration_ = 3.6

		local var_9_0 = {
			zh = 2.466,
			ja = 3.6
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
				arg_9_0:Play323121003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = arg_9_1.actors_["10170ui_story"]
			local var_12_1 = 0

			if var_12_1 < arg_9_1.time_ and arg_9_1.time_ <= var_12_1 + arg_12_0 and not isNil(var_12_0) and arg_9_1.var_.characterEffect10170ui_story == nil then
				arg_9_1.var_.characterEffect10170ui_story = var_12_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_2 = 0.200000002980232

			if var_12_1 <= arg_9_1.time_ and arg_9_1.time_ < var_12_1 + var_12_2 and not isNil(var_12_0) then
				local var_12_3 = (arg_9_1.time_ - var_12_1) / var_12_2

				if arg_9_1.var_.characterEffect10170ui_story and not isNil(var_12_0) then
					local var_12_4 = Mathf.Lerp(0, 0.5, var_12_3)

					arg_9_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_9_1.var_.characterEffect10170ui_story.fillRatio = var_12_4
				end
			end

			if arg_9_1.time_ >= var_12_1 + var_12_2 and arg_9_1.time_ < var_12_1 + var_12_2 + arg_12_0 and not isNil(var_12_0) and arg_9_1.var_.characterEffect10170ui_story then
				local var_12_5 = 0.5

				arg_9_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_9_1.var_.characterEffect10170ui_story.fillRatio = var_12_5
			end

			local var_12_6 = 0
			local var_12_7 = 0.25

			if var_12_6 < arg_9_1.time_ and arg_9_1.time_ <= var_12_6 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_8 = arg_9_1:FormatText(StoryNameCfg[1454].name)

				arg_9_1.leftNameTxt_.text = var_12_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, true)
				arg_9_1.iconController_:SetSelectedState("hero")

				arg_9_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10169")

				arg_9_1.callingController_:SetSelectedState("normal")

				arg_9_1.keyicon_.color = Color.New(1, 1, 1)
				arg_9_1.icon_.color = Color.New(1, 1, 1)

				local var_12_9 = arg_9_1:GetWordFromCfg(323121002)
				local var_12_10 = arg_9_1:FormatText(var_12_9.content)

				arg_9_1.text_.text = var_12_10

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_11 = 10
				local var_12_12 = utf8.len(var_12_10)
				local var_12_13 = var_12_11 <= 0 and var_12_7 or var_12_7 * (var_12_12 / var_12_11)

				if var_12_13 > 0 and var_12_7 < var_12_13 then
					arg_9_1.talkMaxDuration = var_12_13

					if var_12_13 + var_12_6 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_13 + var_12_6
					end
				end

				arg_9_1.text_.text = var_12_10
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323121", "323121002", "story_v_out_323121.awb") ~= 0 then
					local var_12_14 = manager.audio:GetVoiceLength("story_v_out_323121", "323121002", "story_v_out_323121.awb") / 1000

					if var_12_14 + var_12_6 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_14 + var_12_6
					end

					if var_12_9.prefab_name ~= "" and arg_9_1.actors_[var_12_9.prefab_name] ~= nil then
						local var_12_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_9.prefab_name].transform, "story_v_out_323121", "323121002", "story_v_out_323121.awb")

						arg_9_1:RecordAudio("323121002", var_12_15)
						arg_9_1:RecordAudio("323121002", var_12_15)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_323121", "323121002", "story_v_out_323121.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_323121", "323121002", "story_v_out_323121.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_16 = math.max(var_12_7, arg_9_1.talkMaxDuration)

			if var_12_6 <= arg_9_1.time_ and arg_9_1.time_ < var_12_6 + var_12_16 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_6) / var_12_16

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_6 + var_12_16 and arg_9_1.time_ < var_12_6 + var_12_16 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play323121003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 323121003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play323121004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0
			local var_16_1 = 1.4

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

				local var_16_2 = arg_13_1:GetWordFromCfg(323121003)
				local var_16_3 = arg_13_1:FormatText(var_16_2.content)

				arg_13_1.text_.text = var_16_3

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_4 = 56
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
	Play323121004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 323121004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play323121005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0
			local var_20_1 = 1.2

			if var_20_0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_0 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, false)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_2 = arg_17_1:GetWordFromCfg(323121004)
				local var_20_3 = arg_17_1:FormatText(var_20_2.content)

				arg_17_1.text_.text = var_20_3

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_4 = 48
				local var_20_5 = utf8.len(var_20_3)
				local var_20_6 = var_20_4 <= 0 and var_20_1 or var_20_1 * (var_20_5 / var_20_4)

				if var_20_6 > 0 and var_20_1 < var_20_6 then
					arg_17_1.talkMaxDuration = var_20_6

					if var_20_6 + var_20_0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_6 + var_20_0
					end
				end

				arg_17_1.text_.text = var_20_3
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_7 = math.max(var_20_1, arg_17_1.talkMaxDuration)

			if var_20_0 <= arg_17_1.time_ and arg_17_1.time_ < var_20_0 + var_20_7 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_0) / var_20_7

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_0 + var_20_7 and arg_17_1.time_ < var_20_0 + var_20_7 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play323121005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 323121005
		arg_21_1.duration_ = 1.9

		local var_21_0 = {
			zh = 1.5,
			ja = 1.9
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
				arg_21_0:Play323121006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0
			local var_24_1 = 0.125

			if var_24_0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_0 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_2 = arg_21_1:FormatText(StoryNameCfg[1454].name)

				arg_21_1.leftNameTxt_.text = var_24_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, true)
				arg_21_1.iconController_:SetSelectedState("hero")

				arg_21_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10169")

				arg_21_1.callingController_:SetSelectedState("normal")

				arg_21_1.keyicon_.color = Color.New(1, 1, 1)
				arg_21_1.icon_.color = Color.New(1, 1, 1)

				local var_24_3 = arg_21_1:GetWordFromCfg(323121005)
				local var_24_4 = arg_21_1:FormatText(var_24_3.content)

				arg_21_1.text_.text = var_24_4

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_5 = 5
				local var_24_6 = utf8.len(var_24_4)
				local var_24_7 = var_24_5 <= 0 and var_24_1 or var_24_1 * (var_24_6 / var_24_5)

				if var_24_7 > 0 and var_24_1 < var_24_7 then
					arg_21_1.talkMaxDuration = var_24_7

					if var_24_7 + var_24_0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_7 + var_24_0
					end
				end

				arg_21_1.text_.text = var_24_4
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323121", "323121005", "story_v_out_323121.awb") ~= 0 then
					local var_24_8 = manager.audio:GetVoiceLength("story_v_out_323121", "323121005", "story_v_out_323121.awb") / 1000

					if var_24_8 + var_24_0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_8 + var_24_0
					end

					if var_24_3.prefab_name ~= "" and arg_21_1.actors_[var_24_3.prefab_name] ~= nil then
						local var_24_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_3.prefab_name].transform, "story_v_out_323121", "323121005", "story_v_out_323121.awb")

						arg_21_1:RecordAudio("323121005", var_24_9)
						arg_21_1:RecordAudio("323121005", var_24_9)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_323121", "323121005", "story_v_out_323121.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_323121", "323121005", "story_v_out_323121.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_10 = math.max(var_24_1, arg_21_1.talkMaxDuration)

			if var_24_0 <= arg_21_1.time_ and arg_21_1.time_ < var_24_0 + var_24_10 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_0) / var_24_10

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_0 + var_24_10 and arg_21_1.time_ < var_24_0 + var_24_10 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play323121006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 323121006
		arg_25_1.duration_ = 2

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play323121007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = arg_25_1.actors_["10170ui_story"].transform
			local var_28_1 = 0

			if var_28_1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 then
				arg_25_1.var_.moveOldPos10170ui_story = var_28_0.localPosition

				local var_28_2 = GameObjectTools.GetOrAddComponent(var_28_0.gameObject, typeof(DynamicBoneHelper))

				if var_28_2 then
					var_28_2:EnableDynamicBone(false)
				end
			end

			local var_28_3 = 0.001

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_3 then
				local var_28_4 = (arg_25_1.time_ - var_28_1) / var_28_3
				local var_28_5 = Vector3.New(0, -1.03, -6.05)

				var_28_0.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos10170ui_story, var_28_5, var_28_4)

				local var_28_6 = manager.ui.mainCamera.transform.position - var_28_0.position

				var_28_0.forward = Vector3.New(var_28_6.x, var_28_6.y, var_28_6.z)

				local var_28_7 = var_28_0.localEulerAngles

				var_28_7.z = 0
				var_28_7.x = 0
				var_28_0.localEulerAngles = var_28_7
			end

			if arg_25_1.time_ >= var_28_1 + var_28_3 and arg_25_1.time_ < var_28_1 + var_28_3 + arg_28_0 then
				var_28_0.localPosition = Vector3.New(0, -1.03, -6.05)

				local var_28_8 = manager.ui.mainCamera.transform.position - var_28_0.position

				var_28_0.forward = Vector3.New(var_28_8.x, var_28_8.y, var_28_8.z)

				local var_28_9 = var_28_0.localEulerAngles

				var_28_9.z = 0
				var_28_9.x = 0
				var_28_0.localEulerAngles = var_28_9

				local var_28_10 = GameObjectTools.GetOrAddComponent(var_28_0.gameObject, typeof(DynamicBoneHelper))

				if var_28_10 then
					var_28_10:EnableDynamicBone(true)
				end
			end

			local var_28_11 = arg_25_1.actors_["10170ui_story"]
			local var_28_12 = 0

			if var_28_12 < arg_25_1.time_ and arg_25_1.time_ <= var_28_12 + arg_28_0 and not isNil(var_28_11) and arg_25_1.var_.characterEffect10170ui_story == nil then
				arg_25_1.var_.characterEffect10170ui_story = var_28_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_13 = 0.200000002980232

			if var_28_12 <= arg_25_1.time_ and arg_25_1.time_ < var_28_12 + var_28_13 and not isNil(var_28_11) then
				local var_28_14 = (arg_25_1.time_ - var_28_12) / var_28_13

				if arg_25_1.var_.characterEffect10170ui_story and not isNil(var_28_11) then
					arg_25_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= var_28_12 + var_28_13 and arg_25_1.time_ < var_28_12 + var_28_13 + arg_28_0 and not isNil(var_28_11) and arg_25_1.var_.characterEffect10170ui_story then
				arg_25_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_28_15 = 0

			if var_28_15 < arg_25_1.time_ and arg_25_1.time_ <= var_28_15 + arg_28_0 then
				arg_25_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/story10170/story10170action/10170action1_1")
			end

			local var_28_16 = 0

			if var_28_16 < arg_25_1.time_ and arg_25_1.time_ <= var_28_16 + arg_28_0 then
				arg_25_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_28_17 = 0
			local var_28_18 = 0.15

			if var_28_17 < arg_25_1.time_ and arg_25_1.time_ <= var_28_17 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_19 = arg_25_1:FormatText(StoryNameCfg[1450].name)

				arg_25_1.leftNameTxt_.text = var_28_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_20 = arg_25_1:GetWordFromCfg(323121006)
				local var_28_21 = arg_25_1:FormatText(var_28_20.content)

				arg_25_1.text_.text = var_28_21

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_22 = 6
				local var_28_23 = utf8.len(var_28_21)
				local var_28_24 = var_28_22 <= 0 and var_28_18 or var_28_18 * (var_28_23 / var_28_22)

				if var_28_24 > 0 and var_28_18 < var_28_24 then
					arg_25_1.talkMaxDuration = var_28_24

					if var_28_24 + var_28_17 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_24 + var_28_17
					end
				end

				arg_25_1.text_.text = var_28_21
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323121", "323121006", "story_v_out_323121.awb") ~= 0 then
					local var_28_25 = manager.audio:GetVoiceLength("story_v_out_323121", "323121006", "story_v_out_323121.awb") / 1000

					if var_28_25 + var_28_17 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_25 + var_28_17
					end

					if var_28_20.prefab_name ~= "" and arg_25_1.actors_[var_28_20.prefab_name] ~= nil then
						local var_28_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_20.prefab_name].transform, "story_v_out_323121", "323121006", "story_v_out_323121.awb")

						arg_25_1:RecordAudio("323121006", var_28_26)
						arg_25_1:RecordAudio("323121006", var_28_26)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_323121", "323121006", "story_v_out_323121.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_323121", "323121006", "story_v_out_323121.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_27 = math.max(var_28_18, arg_25_1.talkMaxDuration)

			if var_28_17 <= arg_25_1.time_ and arg_25_1.time_ < var_28_17 + var_28_27 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_17) / var_28_27

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_17 + var_28_27 and arg_25_1.time_ < var_28_17 + var_28_27 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_25_1:InitPlayNodeList()
	end,
	Play323121007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 323121007
		arg_29_1.duration_ = 7.43

		local var_29_0 = {
			zh = 4.3,
			ja = 7.433
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
				arg_29_0:Play323121008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = arg_29_1.actors_["10170ui_story"]
			local var_32_1 = 0

			if var_32_1 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.characterEffect10170ui_story == nil then
				arg_29_1.var_.characterEffect10170ui_story = var_32_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_2 = 0.200000002980232

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_2 and not isNil(var_32_0) then
				local var_32_3 = (arg_29_1.time_ - var_32_1) / var_32_2

				if arg_29_1.var_.characterEffect10170ui_story and not isNil(var_32_0) then
					local var_32_4 = Mathf.Lerp(0, 0.5, var_32_3)

					arg_29_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_29_1.var_.characterEffect10170ui_story.fillRatio = var_32_4
				end
			end

			if arg_29_1.time_ >= var_32_1 + var_32_2 and arg_29_1.time_ < var_32_1 + var_32_2 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.characterEffect10170ui_story then
				local var_32_5 = 0.5

				arg_29_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_29_1.var_.characterEffect10170ui_story.fillRatio = var_32_5
			end

			local var_32_6 = 0
			local var_32_7 = 0.575

			if var_32_6 < arg_29_1.time_ and arg_29_1.time_ <= var_32_6 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_8 = arg_29_1:FormatText(StoryNameCfg[1454].name)

				arg_29_1.leftNameTxt_.text = var_32_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, true)
				arg_29_1.iconController_:SetSelectedState("hero")

				arg_29_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10169")

				arg_29_1.callingController_:SetSelectedState("normal")

				arg_29_1.keyicon_.color = Color.New(1, 1, 1)
				arg_29_1.icon_.color = Color.New(1, 1, 1)

				local var_32_9 = arg_29_1:GetWordFromCfg(323121007)
				local var_32_10 = arg_29_1:FormatText(var_32_9.content)

				arg_29_1.text_.text = var_32_10

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_11 = 23
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

				if manager.audio:GetVoiceLength("story_v_out_323121", "323121007", "story_v_out_323121.awb") ~= 0 then
					local var_32_14 = manager.audio:GetVoiceLength("story_v_out_323121", "323121007", "story_v_out_323121.awb") / 1000

					if var_32_14 + var_32_6 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_14 + var_32_6
					end

					if var_32_9.prefab_name ~= "" and arg_29_1.actors_[var_32_9.prefab_name] ~= nil then
						local var_32_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_9.prefab_name].transform, "story_v_out_323121", "323121007", "story_v_out_323121.awb")

						arg_29_1:RecordAudio("323121007", var_32_15)
						arg_29_1:RecordAudio("323121007", var_32_15)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_323121", "323121007", "story_v_out_323121.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_323121", "323121007", "story_v_out_323121.awb")
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
	Play323121008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 323121008
		arg_33_1.duration_ = 15.37

		local var_33_0 = {
			zh = 8.033,
			ja = 15.366
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
				arg_33_0:Play323121009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 0
			local var_36_1 = 0.85

			if var_36_0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_0 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_2 = arg_33_1:FormatText(StoryNameCfg[1454].name)

				arg_33_1.leftNameTxt_.text = var_36_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, true)
				arg_33_1.iconController_:SetSelectedState("hero")

				arg_33_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10169")

				arg_33_1.callingController_:SetSelectedState("normal")

				arg_33_1.keyicon_.color = Color.New(1, 1, 1)
				arg_33_1.icon_.color = Color.New(1, 1, 1)

				local var_36_3 = arg_33_1:GetWordFromCfg(323121008)
				local var_36_4 = arg_33_1:FormatText(var_36_3.content)

				arg_33_1.text_.text = var_36_4

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_5 = 34
				local var_36_6 = utf8.len(var_36_4)
				local var_36_7 = var_36_5 <= 0 and var_36_1 or var_36_1 * (var_36_6 / var_36_5)

				if var_36_7 > 0 and var_36_1 < var_36_7 then
					arg_33_1.talkMaxDuration = var_36_7

					if var_36_7 + var_36_0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_7 + var_36_0
					end
				end

				arg_33_1.text_.text = var_36_4
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323121", "323121008", "story_v_out_323121.awb") ~= 0 then
					local var_36_8 = manager.audio:GetVoiceLength("story_v_out_323121", "323121008", "story_v_out_323121.awb") / 1000

					if var_36_8 + var_36_0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_8 + var_36_0
					end

					if var_36_3.prefab_name ~= "" and arg_33_1.actors_[var_36_3.prefab_name] ~= nil then
						local var_36_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_3.prefab_name].transform, "story_v_out_323121", "323121008", "story_v_out_323121.awb")

						arg_33_1:RecordAudio("323121008", var_36_9)
						arg_33_1:RecordAudio("323121008", var_36_9)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_323121", "323121008", "story_v_out_323121.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_323121", "323121008", "story_v_out_323121.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_10 = math.max(var_36_1, arg_33_1.talkMaxDuration)

			if var_36_0 <= arg_33_1.time_ and arg_33_1.time_ < var_36_0 + var_36_10 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_0) / var_36_10

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_0 + var_36_10 and arg_33_1.time_ < var_36_0 + var_36_10 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play323121009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 323121009
		arg_37_1.duration_ = 4.07

		local var_37_0 = {
			zh = 4.066,
			ja = 3.466
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
				arg_37_0:Play323121010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = arg_37_1.actors_["10170ui_story"]
			local var_40_1 = 0

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.characterEffect10170ui_story == nil then
				arg_37_1.var_.characterEffect10170ui_story = var_40_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_2 = 0.200000002980232

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_2 and not isNil(var_40_0) then
				local var_40_3 = (arg_37_1.time_ - var_40_1) / var_40_2

				if arg_37_1.var_.characterEffect10170ui_story and not isNil(var_40_0) then
					arg_37_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_37_1.time_ >= var_40_1 + var_40_2 and arg_37_1.time_ < var_40_1 + var_40_2 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.characterEffect10170ui_story then
				arg_37_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_40_4 = 0

			if var_40_4 < arg_37_1.time_ and arg_37_1.time_ <= var_40_4 + arg_40_0 then
				arg_37_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_40_5 = 0

			if var_40_5 < arg_37_1.time_ and arg_37_1.time_ <= var_40_5 + arg_40_0 then
				arg_37_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/story10170/story10170action/10170action30_1")
			end

			local var_40_6 = 0
			local var_40_7 = 0.45

			if var_40_6 < arg_37_1.time_ and arg_37_1.time_ <= var_40_6 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_8 = arg_37_1:FormatText(StoryNameCfg[1450].name)

				arg_37_1.leftNameTxt_.text = var_40_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_9 = arg_37_1:GetWordFromCfg(323121009)
				local var_40_10 = arg_37_1:FormatText(var_40_9.content)

				arg_37_1.text_.text = var_40_10

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_11 = 18
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

				if manager.audio:GetVoiceLength("story_v_out_323121", "323121009", "story_v_out_323121.awb") ~= 0 then
					local var_40_14 = manager.audio:GetVoiceLength("story_v_out_323121", "323121009", "story_v_out_323121.awb") / 1000

					if var_40_14 + var_40_6 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_14 + var_40_6
					end

					if var_40_9.prefab_name ~= "" and arg_37_1.actors_[var_40_9.prefab_name] ~= nil then
						local var_40_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_9.prefab_name].transform, "story_v_out_323121", "323121009", "story_v_out_323121.awb")

						arg_37_1:RecordAudio("323121009", var_40_15)
						arg_37_1:RecordAudio("323121009", var_40_15)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_323121", "323121009", "story_v_out_323121.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_323121", "323121009", "story_v_out_323121.awb")
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
	Play323121010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 323121010
		arg_41_1.duration_ = 5.13

		local var_41_0 = {
			zh = 2.366,
			ja = 5.133
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
				arg_41_0:Play323121011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = arg_41_1.actors_["10170ui_story"]
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect10170ui_story == nil then
				arg_41_1.var_.characterEffect10170ui_story = var_44_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_2 = 0.200000002980232

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_2 and not isNil(var_44_0) then
				local var_44_3 = (arg_41_1.time_ - var_44_1) / var_44_2

				if arg_41_1.var_.characterEffect10170ui_story and not isNil(var_44_0) then
					local var_44_4 = Mathf.Lerp(0, 0.5, var_44_3)

					arg_41_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_41_1.var_.characterEffect10170ui_story.fillRatio = var_44_4
				end
			end

			if arg_41_1.time_ >= var_44_1 + var_44_2 and arg_41_1.time_ < var_44_1 + var_44_2 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect10170ui_story then
				local var_44_5 = 0.5

				arg_41_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_41_1.var_.characterEffect10170ui_story.fillRatio = var_44_5
			end

			local var_44_6 = 0
			local var_44_7 = 0.25

			if var_44_6 < arg_41_1.time_ and arg_41_1.time_ <= var_44_6 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_8 = arg_41_1:FormatText(StoryNameCfg[1454].name)

				arg_41_1.leftNameTxt_.text = var_44_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, true)
				arg_41_1.iconController_:SetSelectedState("hero")

				arg_41_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10169")

				arg_41_1.callingController_:SetSelectedState("normal")

				arg_41_1.keyicon_.color = Color.New(1, 1, 1)
				arg_41_1.icon_.color = Color.New(1, 1, 1)

				local var_44_9 = arg_41_1:GetWordFromCfg(323121010)
				local var_44_10 = arg_41_1:FormatText(var_44_9.content)

				arg_41_1.text_.text = var_44_10

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_11 = 10
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

				if manager.audio:GetVoiceLength("story_v_out_323121", "323121010", "story_v_out_323121.awb") ~= 0 then
					local var_44_14 = manager.audio:GetVoiceLength("story_v_out_323121", "323121010", "story_v_out_323121.awb") / 1000

					if var_44_14 + var_44_6 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_14 + var_44_6
					end

					if var_44_9.prefab_name ~= "" and arg_41_1.actors_[var_44_9.prefab_name] ~= nil then
						local var_44_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_9.prefab_name].transform, "story_v_out_323121", "323121010", "story_v_out_323121.awb")

						arg_41_1:RecordAudio("323121010", var_44_15)
						arg_41_1:RecordAudio("323121010", var_44_15)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_323121", "323121010", "story_v_out_323121.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_323121", "323121010", "story_v_out_323121.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_16 = math.max(var_44_7, arg_41_1.talkMaxDuration)

			if var_44_6 <= arg_41_1.time_ and arg_41_1.time_ < var_44_6 + var_44_16 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_6) / var_44_16

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_6 + var_44_16 and arg_41_1.time_ < var_44_6 + var_44_16 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play323121011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 323121011
		arg_45_1.duration_ = 1.87

		local var_45_0 = {
			zh = 1.4,
			ja = 1.866
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
				arg_45_0:Play323121012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = arg_45_1.actors_["10170ui_story"]
			local var_48_1 = 0

			if var_48_1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.characterEffect10170ui_story == nil then
				arg_45_1.var_.characterEffect10170ui_story = var_48_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_2 = 0.200000002980232

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_2 and not isNil(var_48_0) then
				local var_48_3 = (arg_45_1.time_ - var_48_1) / var_48_2

				if arg_45_1.var_.characterEffect10170ui_story and not isNil(var_48_0) then
					arg_45_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_45_1.time_ >= var_48_1 + var_48_2 and arg_45_1.time_ < var_48_1 + var_48_2 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.characterEffect10170ui_story then
				arg_45_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_48_4 = 0
			local var_48_5 = 0.125

			if var_48_4 < arg_45_1.time_ and arg_45_1.time_ <= var_48_4 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_6 = arg_45_1:FormatText(StoryNameCfg[1450].name)

				arg_45_1.leftNameTxt_.text = var_48_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_7 = arg_45_1:GetWordFromCfg(323121011)
				local var_48_8 = arg_45_1:FormatText(var_48_7.content)

				arg_45_1.text_.text = var_48_8

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_9 = 5
				local var_48_10 = utf8.len(var_48_8)
				local var_48_11 = var_48_9 <= 0 and var_48_5 or var_48_5 * (var_48_10 / var_48_9)

				if var_48_11 > 0 and var_48_5 < var_48_11 then
					arg_45_1.talkMaxDuration = var_48_11

					if var_48_11 + var_48_4 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_11 + var_48_4
					end
				end

				arg_45_1.text_.text = var_48_8
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323121", "323121011", "story_v_out_323121.awb") ~= 0 then
					local var_48_12 = manager.audio:GetVoiceLength("story_v_out_323121", "323121011", "story_v_out_323121.awb") / 1000

					if var_48_12 + var_48_4 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_12 + var_48_4
					end

					if var_48_7.prefab_name ~= "" and arg_45_1.actors_[var_48_7.prefab_name] ~= nil then
						local var_48_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_7.prefab_name].transform, "story_v_out_323121", "323121011", "story_v_out_323121.awb")

						arg_45_1:RecordAudio("323121011", var_48_13)
						arg_45_1:RecordAudio("323121011", var_48_13)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_323121", "323121011", "story_v_out_323121.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_323121", "323121011", "story_v_out_323121.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_14 = math.max(var_48_5, arg_45_1.talkMaxDuration)

			if var_48_4 <= arg_45_1.time_ and arg_45_1.time_ < var_48_4 + var_48_14 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_4) / var_48_14

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_4 + var_48_14 and arg_45_1.time_ < var_48_4 + var_48_14 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play323121012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 323121012
		arg_49_1.duration_ = 2.83

		local var_49_0 = {
			zh = 2.266,
			ja = 2.833
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
				arg_49_0:Play323121013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = arg_49_1.actors_["10170ui_story"]
			local var_52_1 = 0

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.characterEffect10170ui_story == nil then
				arg_49_1.var_.characterEffect10170ui_story = var_52_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_2 = 0.200000002980232

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_2 and not isNil(var_52_0) then
				local var_52_3 = (arg_49_1.time_ - var_52_1) / var_52_2

				if arg_49_1.var_.characterEffect10170ui_story and not isNil(var_52_0) then
					local var_52_4 = Mathf.Lerp(0, 0.5, var_52_3)

					arg_49_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_49_1.var_.characterEffect10170ui_story.fillRatio = var_52_4
				end
			end

			if arg_49_1.time_ >= var_52_1 + var_52_2 and arg_49_1.time_ < var_52_1 + var_52_2 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.characterEffect10170ui_story then
				local var_52_5 = 0.5

				arg_49_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_49_1.var_.characterEffect10170ui_story.fillRatio = var_52_5
			end

			local var_52_6 = 0
			local var_52_7 = 0.225

			if var_52_6 < arg_49_1.time_ and arg_49_1.time_ <= var_52_6 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_8 = arg_49_1:FormatText(StoryNameCfg[1454].name)

				arg_49_1.leftNameTxt_.text = var_52_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, true)
				arg_49_1.iconController_:SetSelectedState("hero")

				arg_49_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10169")

				arg_49_1.callingController_:SetSelectedState("normal")

				arg_49_1.keyicon_.color = Color.New(1, 1, 1)
				arg_49_1.icon_.color = Color.New(1, 1, 1)

				local var_52_9 = arg_49_1:GetWordFromCfg(323121012)
				local var_52_10 = arg_49_1:FormatText(var_52_9.content)

				arg_49_1.text_.text = var_52_10

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_11 = 9
				local var_52_12 = utf8.len(var_52_10)
				local var_52_13 = var_52_11 <= 0 and var_52_7 or var_52_7 * (var_52_12 / var_52_11)

				if var_52_13 > 0 and var_52_7 < var_52_13 then
					arg_49_1.talkMaxDuration = var_52_13

					if var_52_13 + var_52_6 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_13 + var_52_6
					end
				end

				arg_49_1.text_.text = var_52_10
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323121", "323121012", "story_v_out_323121.awb") ~= 0 then
					local var_52_14 = manager.audio:GetVoiceLength("story_v_out_323121", "323121012", "story_v_out_323121.awb") / 1000

					if var_52_14 + var_52_6 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_14 + var_52_6
					end

					if var_52_9.prefab_name ~= "" and arg_49_1.actors_[var_52_9.prefab_name] ~= nil then
						local var_52_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_9.prefab_name].transform, "story_v_out_323121", "323121012", "story_v_out_323121.awb")

						arg_49_1:RecordAudio("323121012", var_52_15)
						arg_49_1:RecordAudio("323121012", var_52_15)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_323121", "323121012", "story_v_out_323121.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_323121", "323121012", "story_v_out_323121.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_16 = math.max(var_52_7, arg_49_1.talkMaxDuration)

			if var_52_6 <= arg_49_1.time_ and arg_49_1.time_ < var_52_6 + var_52_16 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_6) / var_52_16

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_6 + var_52_16 and arg_49_1.time_ < var_52_6 + var_52_16 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play323121013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 323121013
		arg_53_1.duration_ = 5.43

		local var_53_0 = {
			zh = 3.3,
			ja = 5.433
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
				arg_53_0:Play323121014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = arg_53_1.actors_["10170ui_story"]
			local var_56_1 = 0

			if var_56_1 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 and not isNil(var_56_0) and arg_53_1.var_.characterEffect10170ui_story == nil then
				arg_53_1.var_.characterEffect10170ui_story = var_56_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_2 = 0.200000002980232

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_2 and not isNil(var_56_0) then
				local var_56_3 = (arg_53_1.time_ - var_56_1) / var_56_2

				if arg_53_1.var_.characterEffect10170ui_story and not isNil(var_56_0) then
					arg_53_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_53_1.time_ >= var_56_1 + var_56_2 and arg_53_1.time_ < var_56_1 + var_56_2 + arg_56_0 and not isNil(var_56_0) and arg_53_1.var_.characterEffect10170ui_story then
				arg_53_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_56_4 = 0

			if var_56_4 < arg_53_1.time_ and arg_53_1.time_ <= var_56_4 + arg_56_0 then
				arg_53_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_56_5 = 0

			if var_56_5 < arg_53_1.time_ and arg_53_1.time_ <= var_56_5 + arg_56_0 then
				arg_53_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/story10170/story10170action/10170action30_2")
			end

			local var_56_6 = 0
			local var_56_7 = 0.3

			if var_56_6 < arg_53_1.time_ and arg_53_1.time_ <= var_56_6 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_8 = arg_53_1:FormatText(StoryNameCfg[1450].name)

				arg_53_1.leftNameTxt_.text = var_56_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_9 = arg_53_1:GetWordFromCfg(323121013)
				local var_56_10 = arg_53_1:FormatText(var_56_9.content)

				arg_53_1.text_.text = var_56_10

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_11 = 12
				local var_56_12 = utf8.len(var_56_10)
				local var_56_13 = var_56_11 <= 0 and var_56_7 or var_56_7 * (var_56_12 / var_56_11)

				if var_56_13 > 0 and var_56_7 < var_56_13 then
					arg_53_1.talkMaxDuration = var_56_13

					if var_56_13 + var_56_6 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_13 + var_56_6
					end
				end

				arg_53_1.text_.text = var_56_10
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323121", "323121013", "story_v_out_323121.awb") ~= 0 then
					local var_56_14 = manager.audio:GetVoiceLength("story_v_out_323121", "323121013", "story_v_out_323121.awb") / 1000

					if var_56_14 + var_56_6 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_14 + var_56_6
					end

					if var_56_9.prefab_name ~= "" and arg_53_1.actors_[var_56_9.prefab_name] ~= nil then
						local var_56_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_9.prefab_name].transform, "story_v_out_323121", "323121013", "story_v_out_323121.awb")

						arg_53_1:RecordAudio("323121013", var_56_15)
						arg_53_1:RecordAudio("323121013", var_56_15)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_323121", "323121013", "story_v_out_323121.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_323121", "323121013", "story_v_out_323121.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_16 = math.max(var_56_7, arg_53_1.talkMaxDuration)

			if var_56_6 <= arg_53_1.time_ and arg_53_1.time_ < var_56_6 + var_56_16 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_6) / var_56_16

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_6 + var_56_16 and arg_53_1.time_ < var_56_6 + var_56_16 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play323121014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 323121014
		arg_57_1.duration_ = 11

		local var_57_0 = {
			zh = 7.833,
			ja = 11
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
				arg_57_0:Play323121015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = arg_57_1.actors_["10170ui_story"]
			local var_60_1 = 0

			if var_60_1 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 and not isNil(var_60_0) and arg_57_1.var_.characterEffect10170ui_story == nil then
				arg_57_1.var_.characterEffect10170ui_story = var_60_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_2 = 0.200000002980232

			if var_60_1 <= arg_57_1.time_ and arg_57_1.time_ < var_60_1 + var_60_2 and not isNil(var_60_0) then
				local var_60_3 = (arg_57_1.time_ - var_60_1) / var_60_2

				if arg_57_1.var_.characterEffect10170ui_story and not isNil(var_60_0) then
					local var_60_4 = Mathf.Lerp(0, 0.5, var_60_3)

					arg_57_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_57_1.var_.characterEffect10170ui_story.fillRatio = var_60_4
				end
			end

			if arg_57_1.time_ >= var_60_1 + var_60_2 and arg_57_1.time_ < var_60_1 + var_60_2 + arg_60_0 and not isNil(var_60_0) and arg_57_1.var_.characterEffect10170ui_story then
				local var_60_5 = 0.5

				arg_57_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_57_1.var_.characterEffect10170ui_story.fillRatio = var_60_5
			end

			local var_60_6 = 0
			local var_60_7 = 0.7

			if var_60_6 < arg_57_1.time_ and arg_57_1.time_ <= var_60_6 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_8 = arg_57_1:FormatText(StoryNameCfg[1454].name)

				arg_57_1.leftNameTxt_.text = var_60_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, true)
				arg_57_1.iconController_:SetSelectedState("hero")

				arg_57_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10169")

				arg_57_1.callingController_:SetSelectedState("normal")

				arg_57_1.keyicon_.color = Color.New(1, 1, 1)
				arg_57_1.icon_.color = Color.New(1, 1, 1)

				local var_60_9 = arg_57_1:GetWordFromCfg(323121014)
				local var_60_10 = arg_57_1:FormatText(var_60_9.content)

				arg_57_1.text_.text = var_60_10

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_11 = 28
				local var_60_12 = utf8.len(var_60_10)
				local var_60_13 = var_60_11 <= 0 and var_60_7 or var_60_7 * (var_60_12 / var_60_11)

				if var_60_13 > 0 and var_60_7 < var_60_13 then
					arg_57_1.talkMaxDuration = var_60_13

					if var_60_13 + var_60_6 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_13 + var_60_6
					end
				end

				arg_57_1.text_.text = var_60_10
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323121", "323121014", "story_v_out_323121.awb") ~= 0 then
					local var_60_14 = manager.audio:GetVoiceLength("story_v_out_323121", "323121014", "story_v_out_323121.awb") / 1000

					if var_60_14 + var_60_6 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_14 + var_60_6
					end

					if var_60_9.prefab_name ~= "" and arg_57_1.actors_[var_60_9.prefab_name] ~= nil then
						local var_60_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_9.prefab_name].transform, "story_v_out_323121", "323121014", "story_v_out_323121.awb")

						arg_57_1:RecordAudio("323121014", var_60_15)
						arg_57_1:RecordAudio("323121014", var_60_15)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_323121", "323121014", "story_v_out_323121.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_323121", "323121014", "story_v_out_323121.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_16 = math.max(var_60_7, arg_57_1.talkMaxDuration)

			if var_60_6 <= arg_57_1.time_ and arg_57_1.time_ < var_60_6 + var_60_16 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_6) / var_60_16

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_6 + var_60_16 and arg_57_1.time_ < var_60_6 + var_60_16 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play323121015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 323121015
		arg_61_1.duration_ = 3.8

		local var_61_0 = {
			zh = 2.866,
			ja = 3.8
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
				arg_61_0:Play323121016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = arg_61_1.actors_["10170ui_story"]
			local var_64_1 = 0

			if var_64_1 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 and not isNil(var_64_0) and arg_61_1.var_.characterEffect10170ui_story == nil then
				arg_61_1.var_.characterEffect10170ui_story = var_64_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_2 = 0.200000002980232

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_2 and not isNil(var_64_0) then
				local var_64_3 = (arg_61_1.time_ - var_64_1) / var_64_2

				if arg_61_1.var_.characterEffect10170ui_story and not isNil(var_64_0) then
					arg_61_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_61_1.time_ >= var_64_1 + var_64_2 and arg_61_1.time_ < var_64_1 + var_64_2 + arg_64_0 and not isNil(var_64_0) and arg_61_1.var_.characterEffect10170ui_story then
				arg_61_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_64_4 = 0
			local var_64_5 = 0.3

			if var_64_4 < arg_61_1.time_ and arg_61_1.time_ <= var_64_4 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_6 = arg_61_1:FormatText(StoryNameCfg[1450].name)

				arg_61_1.leftNameTxt_.text = var_64_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_7 = arg_61_1:GetWordFromCfg(323121015)
				local var_64_8 = arg_61_1:FormatText(var_64_7.content)

				arg_61_1.text_.text = var_64_8

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_9 = 12
				local var_64_10 = utf8.len(var_64_8)
				local var_64_11 = var_64_9 <= 0 and var_64_5 or var_64_5 * (var_64_10 / var_64_9)

				if var_64_11 > 0 and var_64_5 < var_64_11 then
					arg_61_1.talkMaxDuration = var_64_11

					if var_64_11 + var_64_4 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_11 + var_64_4
					end
				end

				arg_61_1.text_.text = var_64_8
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323121", "323121015", "story_v_out_323121.awb") ~= 0 then
					local var_64_12 = manager.audio:GetVoiceLength("story_v_out_323121", "323121015", "story_v_out_323121.awb") / 1000

					if var_64_12 + var_64_4 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_12 + var_64_4
					end

					if var_64_7.prefab_name ~= "" and arg_61_1.actors_[var_64_7.prefab_name] ~= nil then
						local var_64_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_7.prefab_name].transform, "story_v_out_323121", "323121015", "story_v_out_323121.awb")

						arg_61_1:RecordAudio("323121015", var_64_13)
						arg_61_1:RecordAudio("323121015", var_64_13)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_323121", "323121015", "story_v_out_323121.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_323121", "323121015", "story_v_out_323121.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_14 = math.max(var_64_5, arg_61_1.talkMaxDuration)

			if var_64_4 <= arg_61_1.time_ and arg_61_1.time_ < var_64_4 + var_64_14 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_4) / var_64_14

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_4 + var_64_14 and arg_61_1.time_ < var_64_4 + var_64_14 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play323121016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 323121016
		arg_65_1.duration_ = 15.9

		local var_65_0 = {
			zh = 8.266,
			ja = 15.9
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
				arg_65_0:Play323121017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = arg_65_1.actors_["10170ui_story"]
			local var_68_1 = 0

			if var_68_1 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.characterEffect10170ui_story == nil then
				arg_65_1.var_.characterEffect10170ui_story = var_68_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_2 = 0.200000002980232

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_2 and not isNil(var_68_0) then
				local var_68_3 = (arg_65_1.time_ - var_68_1) / var_68_2

				if arg_65_1.var_.characterEffect10170ui_story and not isNil(var_68_0) then
					local var_68_4 = Mathf.Lerp(0, 0.5, var_68_3)

					arg_65_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_65_1.var_.characterEffect10170ui_story.fillRatio = var_68_4
				end
			end

			if arg_65_1.time_ >= var_68_1 + var_68_2 and arg_65_1.time_ < var_68_1 + var_68_2 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.characterEffect10170ui_story then
				local var_68_5 = 0.5

				arg_65_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_65_1.var_.characterEffect10170ui_story.fillRatio = var_68_5
			end

			local var_68_6 = 0
			local var_68_7 = 0.8

			if var_68_6 < arg_65_1.time_ and arg_65_1.time_ <= var_68_6 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_8 = arg_65_1:FormatText(StoryNameCfg[1454].name)

				arg_65_1.leftNameTxt_.text = var_68_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, true)
				arg_65_1.iconController_:SetSelectedState("hero")

				arg_65_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10169")

				arg_65_1.callingController_:SetSelectedState("normal")

				arg_65_1.keyicon_.color = Color.New(1, 1, 1)
				arg_65_1.icon_.color = Color.New(1, 1, 1)

				local var_68_9 = arg_65_1:GetWordFromCfg(323121016)
				local var_68_10 = arg_65_1:FormatText(var_68_9.content)

				arg_65_1.text_.text = var_68_10

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_11 = 32
				local var_68_12 = utf8.len(var_68_10)
				local var_68_13 = var_68_11 <= 0 and var_68_7 or var_68_7 * (var_68_12 / var_68_11)

				if var_68_13 > 0 and var_68_7 < var_68_13 then
					arg_65_1.talkMaxDuration = var_68_13

					if var_68_13 + var_68_6 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_13 + var_68_6
					end
				end

				arg_65_1.text_.text = var_68_10
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323121", "323121016", "story_v_out_323121.awb") ~= 0 then
					local var_68_14 = manager.audio:GetVoiceLength("story_v_out_323121", "323121016", "story_v_out_323121.awb") / 1000

					if var_68_14 + var_68_6 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_14 + var_68_6
					end

					if var_68_9.prefab_name ~= "" and arg_65_1.actors_[var_68_9.prefab_name] ~= nil then
						local var_68_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_9.prefab_name].transform, "story_v_out_323121", "323121016", "story_v_out_323121.awb")

						arg_65_1:RecordAudio("323121016", var_68_15)
						arg_65_1:RecordAudio("323121016", var_68_15)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_323121", "323121016", "story_v_out_323121.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_323121", "323121016", "story_v_out_323121.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_16 = math.max(var_68_7, arg_65_1.talkMaxDuration)

			if var_68_6 <= arg_65_1.time_ and arg_65_1.time_ < var_68_6 + var_68_16 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_6) / var_68_16

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_6 + var_68_16 and arg_65_1.time_ < var_68_6 + var_68_16 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play323121017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 323121017
		arg_69_1.duration_ = 2

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play323121018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = arg_69_1.actors_["10170ui_story"]
			local var_72_1 = 0

			if var_72_1 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 and not isNil(var_72_0) and arg_69_1.var_.characterEffect10170ui_story == nil then
				arg_69_1.var_.characterEffect10170ui_story = var_72_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_2 = 0.200000002980232

			if var_72_1 <= arg_69_1.time_ and arg_69_1.time_ < var_72_1 + var_72_2 and not isNil(var_72_0) then
				local var_72_3 = (arg_69_1.time_ - var_72_1) / var_72_2

				if arg_69_1.var_.characterEffect10170ui_story and not isNil(var_72_0) then
					arg_69_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_69_1.time_ >= var_72_1 + var_72_2 and arg_69_1.time_ < var_72_1 + var_72_2 + arg_72_0 and not isNil(var_72_0) and arg_69_1.var_.characterEffect10170ui_story then
				arg_69_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_72_4 = 0

			if var_72_4 < arg_69_1.time_ and arg_69_1.time_ <= var_72_4 + arg_72_0 then
				arg_69_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_72_5 = 0

			if var_72_5 < arg_69_1.time_ and arg_69_1.time_ <= var_72_5 + arg_72_0 then
				arg_69_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/story10170/story10170action/10170action2_1")
			end

			local var_72_6 = 0
			local var_72_7 = 0.175

			if var_72_6 < arg_69_1.time_ and arg_69_1.time_ <= var_72_6 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_8 = arg_69_1:FormatText(StoryNameCfg[1450].name)

				arg_69_1.leftNameTxt_.text = var_72_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_9 = arg_69_1:GetWordFromCfg(323121017)
				local var_72_10 = arg_69_1:FormatText(var_72_9.content)

				arg_69_1.text_.text = var_72_10

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_11 = 7
				local var_72_12 = utf8.len(var_72_10)
				local var_72_13 = var_72_11 <= 0 and var_72_7 or var_72_7 * (var_72_12 / var_72_11)

				if var_72_13 > 0 and var_72_7 < var_72_13 then
					arg_69_1.talkMaxDuration = var_72_13

					if var_72_13 + var_72_6 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_13 + var_72_6
					end
				end

				arg_69_1.text_.text = var_72_10
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323121", "323121017", "story_v_out_323121.awb") ~= 0 then
					local var_72_14 = manager.audio:GetVoiceLength("story_v_out_323121", "323121017", "story_v_out_323121.awb") / 1000

					if var_72_14 + var_72_6 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_14 + var_72_6
					end

					if var_72_9.prefab_name ~= "" and arg_69_1.actors_[var_72_9.prefab_name] ~= nil then
						local var_72_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_9.prefab_name].transform, "story_v_out_323121", "323121017", "story_v_out_323121.awb")

						arg_69_1:RecordAudio("323121017", var_72_15)
						arg_69_1:RecordAudio("323121017", var_72_15)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_323121", "323121017", "story_v_out_323121.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_323121", "323121017", "story_v_out_323121.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_16 = math.max(var_72_7, arg_69_1.talkMaxDuration)

			if var_72_6 <= arg_69_1.time_ and arg_69_1.time_ < var_72_6 + var_72_16 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_6) / var_72_16

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_6 + var_72_16 and arg_69_1.time_ < var_72_6 + var_72_16 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play323121018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 323121018
		arg_73_1.duration_ = 5

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play323121019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = arg_73_1.actors_["10170ui_story"]
			local var_76_1 = 0

			if var_76_1 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 and not isNil(var_76_0) and arg_73_1.var_.characterEffect10170ui_story == nil then
				arg_73_1.var_.characterEffect10170ui_story = var_76_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_2 = 0.200000002980232

			if var_76_1 <= arg_73_1.time_ and arg_73_1.time_ < var_76_1 + var_76_2 and not isNil(var_76_0) then
				local var_76_3 = (arg_73_1.time_ - var_76_1) / var_76_2

				if arg_73_1.var_.characterEffect10170ui_story and not isNil(var_76_0) then
					local var_76_4 = Mathf.Lerp(0, 0.5, var_76_3)

					arg_73_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_73_1.var_.characterEffect10170ui_story.fillRatio = var_76_4
				end
			end

			if arg_73_1.time_ >= var_76_1 + var_76_2 and arg_73_1.time_ < var_76_1 + var_76_2 + arg_76_0 and not isNil(var_76_0) and arg_73_1.var_.characterEffect10170ui_story then
				local var_76_5 = 0.5

				arg_73_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_73_1.var_.characterEffect10170ui_story.fillRatio = var_76_5
			end

			local var_76_6 = 0
			local var_76_7 = 0.425

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

				arg_73_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_73_1.callingController_:SetSelectedState("normal")

				arg_73_1.keyicon_.color = Color.New(1, 1, 1)
				arg_73_1.icon_.color = Color.New(1, 1, 1)

				local var_76_9 = arg_73_1:GetWordFromCfg(323121018)
				local var_76_10 = arg_73_1:FormatText(var_76_9.content)

				arg_73_1.text_.text = var_76_10

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_11 = 17
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
	Play323121019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 323121019
		arg_77_1.duration_ = 2.23

		local var_77_0 = {
			zh = 1.933,
			ja = 2.233
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
				arg_77_0:Play323121020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = 0
			local var_80_1 = 0.225

			if var_80_0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_0 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				local var_80_2 = arg_77_1:FormatText(StoryNameCfg[1454].name)

				arg_77_1.leftNameTxt_.text = var_80_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, true)
				arg_77_1.iconController_:SetSelectedState("hero")

				arg_77_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10169")

				arg_77_1.callingController_:SetSelectedState("normal")

				arg_77_1.keyicon_.color = Color.New(1, 1, 1)
				arg_77_1.icon_.color = Color.New(1, 1, 1)

				local var_80_3 = arg_77_1:GetWordFromCfg(323121019)
				local var_80_4 = arg_77_1:FormatText(var_80_3.content)

				arg_77_1.text_.text = var_80_4

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_5 = 9
				local var_80_6 = utf8.len(var_80_4)
				local var_80_7 = var_80_5 <= 0 and var_80_1 or var_80_1 * (var_80_6 / var_80_5)

				if var_80_7 > 0 and var_80_1 < var_80_7 then
					arg_77_1.talkMaxDuration = var_80_7

					if var_80_7 + var_80_0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_7 + var_80_0
					end
				end

				arg_77_1.text_.text = var_80_4
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323121", "323121019", "story_v_out_323121.awb") ~= 0 then
					local var_80_8 = manager.audio:GetVoiceLength("story_v_out_323121", "323121019", "story_v_out_323121.awb") / 1000

					if var_80_8 + var_80_0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_8 + var_80_0
					end

					if var_80_3.prefab_name ~= "" and arg_77_1.actors_[var_80_3.prefab_name] ~= nil then
						local var_80_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_3.prefab_name].transform, "story_v_out_323121", "323121019", "story_v_out_323121.awb")

						arg_77_1:RecordAudio("323121019", var_80_9)
						arg_77_1:RecordAudio("323121019", var_80_9)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_323121", "323121019", "story_v_out_323121.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_323121", "323121019", "story_v_out_323121.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_10 = math.max(var_80_1, arg_77_1.talkMaxDuration)

			if var_80_0 <= arg_77_1.time_ and arg_77_1.time_ < var_80_0 + var_80_10 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_0) / var_80_10

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_0 + var_80_10 and arg_77_1.time_ < var_80_0 + var_80_10 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play323121020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 323121020
		arg_81_1.duration_ = 1.6

		local var_81_0 = {
			zh = 1.3,
			ja = 1.6
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
				arg_81_0:Play323121021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = arg_81_1.actors_["10170ui_story"]
			local var_84_1 = 0

			if var_84_1 < arg_81_1.time_ and arg_81_1.time_ <= var_84_1 + arg_84_0 and not isNil(var_84_0) and arg_81_1.var_.characterEffect10170ui_story == nil then
				arg_81_1.var_.characterEffect10170ui_story = var_84_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_2 = 0.200000002980232

			if var_84_1 <= arg_81_1.time_ and arg_81_1.time_ < var_84_1 + var_84_2 and not isNil(var_84_0) then
				local var_84_3 = (arg_81_1.time_ - var_84_1) / var_84_2

				if arg_81_1.var_.characterEffect10170ui_story and not isNil(var_84_0) then
					arg_81_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_81_1.time_ >= var_84_1 + var_84_2 and arg_81_1.time_ < var_84_1 + var_84_2 + arg_84_0 and not isNil(var_84_0) and arg_81_1.var_.characterEffect10170ui_story then
				arg_81_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_84_4 = 0
			local var_84_5 = 0.1

			if var_84_4 < arg_81_1.time_ and arg_81_1.time_ <= var_84_4 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				local var_84_6 = arg_81_1:FormatText(StoryNameCfg[1450].name)

				arg_81_1.leftNameTxt_.text = var_84_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_7 = arg_81_1:GetWordFromCfg(323121020)
				local var_84_8 = arg_81_1:FormatText(var_84_7.content)

				arg_81_1.text_.text = var_84_8

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_9 = 4
				local var_84_10 = utf8.len(var_84_8)
				local var_84_11 = var_84_9 <= 0 and var_84_5 or var_84_5 * (var_84_10 / var_84_9)

				if var_84_11 > 0 and var_84_5 < var_84_11 then
					arg_81_1.talkMaxDuration = var_84_11

					if var_84_11 + var_84_4 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_11 + var_84_4
					end
				end

				arg_81_1.text_.text = var_84_8
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323121", "323121020", "story_v_out_323121.awb") ~= 0 then
					local var_84_12 = manager.audio:GetVoiceLength("story_v_out_323121", "323121020", "story_v_out_323121.awb") / 1000

					if var_84_12 + var_84_4 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_12 + var_84_4
					end

					if var_84_7.prefab_name ~= "" and arg_81_1.actors_[var_84_7.prefab_name] ~= nil then
						local var_84_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_7.prefab_name].transform, "story_v_out_323121", "323121020", "story_v_out_323121.awb")

						arg_81_1:RecordAudio("323121020", var_84_13)
						arg_81_1:RecordAudio("323121020", var_84_13)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_323121", "323121020", "story_v_out_323121.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_323121", "323121020", "story_v_out_323121.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_14 = math.max(var_84_5, arg_81_1.talkMaxDuration)

			if var_84_4 <= arg_81_1.time_ and arg_81_1.time_ < var_84_4 + var_84_14 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_4) / var_84_14

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_4 + var_84_14 and arg_81_1.time_ < var_84_4 + var_84_14 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play323121021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 323121021
		arg_85_1.duration_ = 5.4

		local var_85_0 = {
			zh = 4.233,
			ja = 5.4
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
				arg_85_0:Play323121022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = arg_85_1.actors_["10170ui_story"].transform
			local var_88_1 = 0

			if var_88_1 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 then
				arg_85_1.var_.moveOldPos10170ui_story = var_88_0.localPosition

				local var_88_2 = GameObjectTools.GetOrAddComponent(var_88_0.gameObject, typeof(DynamicBoneHelper))

				if var_88_2 then
					var_88_2:EnableDynamicBone(false)
				end
			end

			local var_88_3 = 0.001

			if var_88_1 <= arg_85_1.time_ and arg_85_1.time_ < var_88_1 + var_88_3 then
				local var_88_4 = (arg_85_1.time_ - var_88_1) / var_88_3
				local var_88_5 = Vector3.New(-0.7, -1.03, -6.05)

				var_88_0.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos10170ui_story, var_88_5, var_88_4)

				local var_88_6 = manager.ui.mainCamera.transform.position - var_88_0.position

				var_88_0.forward = Vector3.New(var_88_6.x, var_88_6.y, var_88_6.z)

				local var_88_7 = var_88_0.localEulerAngles

				var_88_7.z = 0
				var_88_7.x = 0
				var_88_0.localEulerAngles = var_88_7
			end

			if arg_85_1.time_ >= var_88_1 + var_88_3 and arg_85_1.time_ < var_88_1 + var_88_3 + arg_88_0 then
				var_88_0.localPosition = Vector3.New(-0.7, -1.03, -6.05)

				local var_88_8 = manager.ui.mainCamera.transform.position - var_88_0.position

				var_88_0.forward = Vector3.New(var_88_8.x, var_88_8.y, var_88_8.z)

				local var_88_9 = var_88_0.localEulerAngles

				var_88_9.z = 0
				var_88_9.x = 0
				var_88_0.localEulerAngles = var_88_9

				local var_88_10 = GameObjectTools.GetOrAddComponent(var_88_0.gameObject, typeof(DynamicBoneHelper))

				if var_88_10 then
					var_88_10:EnableDynamicBone(true)
				end
			end

			local var_88_11 = "1053ui_story"

			if arg_85_1.actors_[var_88_11] == nil then
				local var_88_12 = Asset.Load("Char/" .. "1053ui_story")

				if not isNil(var_88_12) then
					local var_88_13 = Object.Instantiate(Asset.Load("Char/" .. "1053ui_story"), arg_85_1.stage_.transform)

					var_88_13.name = var_88_11
					var_88_13.transform.localPosition = Vector3.New(0, 100, 0)
					arg_85_1.actors_[var_88_11] = var_88_13

					local var_88_14 = var_88_13:GetComponentInChildren(typeof(CharacterEffect))

					var_88_14.enabled = true

					local var_88_15 = GameObjectTools.GetOrAddComponent(var_88_13, typeof(DynamicBoneHelper))

					if var_88_15 then
						var_88_15:EnableDynamicBone(false)
					end

					arg_85_1:ShowWeapon(var_88_14.transform, false)

					arg_85_1.var_[var_88_11 .. "Animator"] = var_88_14.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_85_1.var_[var_88_11 .. "Animator"].applyRootMotion = true
					arg_85_1.var_[var_88_11 .. "LipSync"] = var_88_14.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_88_16 = arg_85_1.actors_["1053ui_story"].transform
			local var_88_17 = 0

			if var_88_17 < arg_85_1.time_ and arg_85_1.time_ <= var_88_17 + arg_88_0 then
				arg_85_1.var_.moveOldPos1053ui_story = var_88_16.localPosition

				local var_88_18 = GameObjectTools.GetOrAddComponent(var_88_16.gameObject, typeof(DynamicBoneHelper))

				if var_88_18 then
					var_88_18:EnableDynamicBone(false)
				end
			end

			local var_88_19 = 0.001

			if var_88_17 <= arg_85_1.time_ and arg_85_1.time_ < var_88_17 + var_88_19 then
				local var_88_20 = (arg_85_1.time_ - var_88_17) / var_88_19
				local var_88_21 = Vector3.New(0.7, -1.08, -6)

				var_88_16.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos1053ui_story, var_88_21, var_88_20)

				local var_88_22 = manager.ui.mainCamera.transform.position - var_88_16.position

				var_88_16.forward = Vector3.New(var_88_22.x, var_88_22.y, var_88_22.z)

				local var_88_23 = var_88_16.localEulerAngles

				var_88_23.z = 0
				var_88_23.x = 0
				var_88_16.localEulerAngles = var_88_23
			end

			if arg_85_1.time_ >= var_88_17 + var_88_19 and arg_85_1.time_ < var_88_17 + var_88_19 + arg_88_0 then
				var_88_16.localPosition = Vector3.New(0.7, -1.08, -6)

				local var_88_24 = manager.ui.mainCamera.transform.position - var_88_16.position

				var_88_16.forward = Vector3.New(var_88_24.x, var_88_24.y, var_88_24.z)

				local var_88_25 = var_88_16.localEulerAngles

				var_88_25.z = 0
				var_88_25.x = 0
				var_88_16.localEulerAngles = var_88_25

				local var_88_26 = GameObjectTools.GetOrAddComponent(var_88_16.gameObject, typeof(DynamicBoneHelper))

				if var_88_26 then
					var_88_26:EnableDynamicBone(true)
				end
			end

			local var_88_27 = arg_85_1.actors_["1053ui_story"]
			local var_88_28 = 0

			if var_88_28 < arg_85_1.time_ and arg_85_1.time_ <= var_88_28 + arg_88_0 and not isNil(var_88_27) and arg_85_1.var_.characterEffect1053ui_story == nil then
				arg_85_1.var_.characterEffect1053ui_story = var_88_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_29 = 0.200000002980232

			if var_88_28 <= arg_85_1.time_ and arg_85_1.time_ < var_88_28 + var_88_29 and not isNil(var_88_27) then
				local var_88_30 = (arg_85_1.time_ - var_88_28) / var_88_29

				if arg_85_1.var_.characterEffect1053ui_story and not isNil(var_88_27) then
					arg_85_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_85_1.time_ >= var_88_28 + var_88_29 and arg_85_1.time_ < var_88_28 + var_88_29 + arg_88_0 and not isNil(var_88_27) and arg_85_1.var_.characterEffect1053ui_story then
				arg_85_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_88_31 = arg_85_1.actors_["10170ui_story"]
			local var_88_32 = 0

			if var_88_32 < arg_85_1.time_ and arg_85_1.time_ <= var_88_32 + arg_88_0 and not isNil(var_88_31) and arg_85_1.var_.characterEffect10170ui_story == nil then
				arg_85_1.var_.characterEffect10170ui_story = var_88_31:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_33 = 0.200000002980232

			if var_88_32 <= arg_85_1.time_ and arg_85_1.time_ < var_88_32 + var_88_33 and not isNil(var_88_31) then
				local var_88_34 = (arg_85_1.time_ - var_88_32) / var_88_33

				if arg_85_1.var_.characterEffect10170ui_story and not isNil(var_88_31) then
					local var_88_35 = Mathf.Lerp(0, 0.5, var_88_34)

					arg_85_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_85_1.var_.characterEffect10170ui_story.fillRatio = var_88_35
				end
			end

			if arg_85_1.time_ >= var_88_32 + var_88_33 and arg_85_1.time_ < var_88_32 + var_88_33 + arg_88_0 and not isNil(var_88_31) and arg_85_1.var_.characterEffect10170ui_story then
				local var_88_36 = 0.5

				arg_85_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_85_1.var_.characterEffect10170ui_story.fillRatio = var_88_36
			end

			local var_88_37 = 0

			if var_88_37 < arg_85_1.time_ and arg_85_1.time_ <= var_88_37 + arg_88_0 then
				arg_85_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053action/1053action2_1")
			end

			local var_88_38 = 0

			if var_88_38 < arg_85_1.time_ and arg_85_1.time_ <= var_88_38 + arg_88_0 then
				arg_85_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_88_39 = 0
			local var_88_40 = 0.4

			if var_88_39 < arg_85_1.time_ and arg_85_1.time_ <= var_88_39 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				local var_88_41 = arg_85_1:FormatText(StoryNameCfg[1453].name)

				arg_85_1.leftNameTxt_.text = var_88_41

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_42 = arg_85_1:GetWordFromCfg(323121021)
				local var_88_43 = arg_85_1:FormatText(var_88_42.content)

				arg_85_1.text_.text = var_88_43

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_44 = 16
				local var_88_45 = utf8.len(var_88_43)
				local var_88_46 = var_88_44 <= 0 and var_88_40 or var_88_40 * (var_88_45 / var_88_44)

				if var_88_46 > 0 and var_88_40 < var_88_46 then
					arg_85_1.talkMaxDuration = var_88_46

					if var_88_46 + var_88_39 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_46 + var_88_39
					end
				end

				arg_85_1.text_.text = var_88_43
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323121", "323121021", "story_v_out_323121.awb") ~= 0 then
					local var_88_47 = manager.audio:GetVoiceLength("story_v_out_323121", "323121021", "story_v_out_323121.awb") / 1000

					if var_88_47 + var_88_39 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_47 + var_88_39
					end

					if var_88_42.prefab_name ~= "" and arg_85_1.actors_[var_88_42.prefab_name] ~= nil then
						local var_88_48 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_42.prefab_name].transform, "story_v_out_323121", "323121021", "story_v_out_323121.awb")

						arg_85_1:RecordAudio("323121021", var_88_48)
						arg_85_1:RecordAudio("323121021", var_88_48)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_323121", "323121021", "story_v_out_323121.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_323121", "323121021", "story_v_out_323121.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_49 = math.max(var_88_40, arg_85_1.talkMaxDuration)

			if var_88_39 <= arg_85_1.time_ and arg_85_1.time_ < var_88_39 + var_88_49 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_39) / var_88_49

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_39 + var_88_49 and arg_85_1.time_ < var_88_39 + var_88_49 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_85_1:InitPlayNodeList()
	end,
	Play323121022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 323121022
		arg_89_1.duration_ = 4.4

		local var_89_0 = {
			zh = 1.999999999999,
			ja = 4.4
		}
		local var_89_1 = manager.audio:GetLocalizationFlag()

		if var_89_0[var_89_1] ~= nil then
			arg_89_1.duration_ = var_89_0[var_89_1]
		end

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play323121023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = arg_89_1.actors_["10170ui_story"]
			local var_92_1 = 0

			if var_92_1 < arg_89_1.time_ and arg_89_1.time_ <= var_92_1 + arg_92_0 and not isNil(var_92_0) and arg_89_1.var_.characterEffect10170ui_story == nil then
				arg_89_1.var_.characterEffect10170ui_story = var_92_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_2 = 0.200000002980232

			if var_92_1 <= arg_89_1.time_ and arg_89_1.time_ < var_92_1 + var_92_2 and not isNil(var_92_0) then
				local var_92_3 = (arg_89_1.time_ - var_92_1) / var_92_2

				if arg_89_1.var_.characterEffect10170ui_story and not isNil(var_92_0) then
					arg_89_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_89_1.time_ >= var_92_1 + var_92_2 and arg_89_1.time_ < var_92_1 + var_92_2 + arg_92_0 and not isNil(var_92_0) and arg_89_1.var_.characterEffect10170ui_story then
				arg_89_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_92_4 = arg_89_1.actors_["1053ui_story"]
			local var_92_5 = 0

			if var_92_5 < arg_89_1.time_ and arg_89_1.time_ <= var_92_5 + arg_92_0 and not isNil(var_92_4) and arg_89_1.var_.characterEffect1053ui_story == nil then
				arg_89_1.var_.characterEffect1053ui_story = var_92_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_6 = 0.200000002980232

			if var_92_5 <= arg_89_1.time_ and arg_89_1.time_ < var_92_5 + var_92_6 and not isNil(var_92_4) then
				local var_92_7 = (arg_89_1.time_ - var_92_5) / var_92_6

				if arg_89_1.var_.characterEffect1053ui_story and not isNil(var_92_4) then
					local var_92_8 = Mathf.Lerp(0, 0.5, var_92_7)

					arg_89_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_89_1.var_.characterEffect1053ui_story.fillRatio = var_92_8
				end
			end

			if arg_89_1.time_ >= var_92_5 + var_92_6 and arg_89_1.time_ < var_92_5 + var_92_6 + arg_92_0 and not isNil(var_92_4) and arg_89_1.var_.characterEffect1053ui_story then
				local var_92_9 = 0.5

				arg_89_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_89_1.var_.characterEffect1053ui_story.fillRatio = var_92_9
			end

			local var_92_10 = 0

			if var_92_10 < arg_89_1.time_ and arg_89_1.time_ <= var_92_10 + arg_92_0 then
				arg_89_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_92_11 = 0

			if var_92_11 < arg_89_1.time_ and arg_89_1.time_ <= var_92_11 + arg_92_0 then
				arg_89_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/story10170/story10170action/10170action2_2")
			end

			local var_92_12 = 0
			local var_92_13 = 0.25

			if var_92_12 < arg_89_1.time_ and arg_89_1.time_ <= var_92_12 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				local var_92_14 = arg_89_1:FormatText(StoryNameCfg[1450].name)

				arg_89_1.leftNameTxt_.text = var_92_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_15 = arg_89_1:GetWordFromCfg(323121022)
				local var_92_16 = arg_89_1:FormatText(var_92_15.content)

				arg_89_1.text_.text = var_92_16

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_17 = 10
				local var_92_18 = utf8.len(var_92_16)
				local var_92_19 = var_92_17 <= 0 and var_92_13 or var_92_13 * (var_92_18 / var_92_17)

				if var_92_19 > 0 and var_92_13 < var_92_19 then
					arg_89_1.talkMaxDuration = var_92_19

					if var_92_19 + var_92_12 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_19 + var_92_12
					end
				end

				arg_89_1.text_.text = var_92_16
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323121", "323121022", "story_v_out_323121.awb") ~= 0 then
					local var_92_20 = manager.audio:GetVoiceLength("story_v_out_323121", "323121022", "story_v_out_323121.awb") / 1000

					if var_92_20 + var_92_12 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_20 + var_92_12
					end

					if var_92_15.prefab_name ~= "" and arg_89_1.actors_[var_92_15.prefab_name] ~= nil then
						local var_92_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_15.prefab_name].transform, "story_v_out_323121", "323121022", "story_v_out_323121.awb")

						arg_89_1:RecordAudio("323121022", var_92_21)
						arg_89_1:RecordAudio("323121022", var_92_21)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_323121", "323121022", "story_v_out_323121.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_323121", "323121022", "story_v_out_323121.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_22 = math.max(var_92_13, arg_89_1.talkMaxDuration)

			if var_92_12 <= arg_89_1.time_ and arg_89_1.time_ < var_92_12 + var_92_22 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_12) / var_92_22

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_12 + var_92_22 and arg_89_1.time_ < var_92_12 + var_92_22 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play323121023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 323121023
		arg_93_1.duration_ = 6.57

		local var_93_0 = {
			zh = 3.933,
			ja = 6.566
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
				arg_93_0:Play323121024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = arg_93_1.actors_["10170ui_story"]
			local var_96_1 = 0

			if var_96_1 < arg_93_1.time_ and arg_93_1.time_ <= var_96_1 + arg_96_0 and not isNil(var_96_0) and arg_93_1.var_.characterEffect10170ui_story == nil then
				arg_93_1.var_.characterEffect10170ui_story = var_96_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_2 = 0.200000002980232

			if var_96_1 <= arg_93_1.time_ and arg_93_1.time_ < var_96_1 + var_96_2 and not isNil(var_96_0) then
				local var_96_3 = (arg_93_1.time_ - var_96_1) / var_96_2

				if arg_93_1.var_.characterEffect10170ui_story and not isNil(var_96_0) then
					local var_96_4 = Mathf.Lerp(0, 0.5, var_96_3)

					arg_93_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_93_1.var_.characterEffect10170ui_story.fillRatio = var_96_4
				end
			end

			if arg_93_1.time_ >= var_96_1 + var_96_2 and arg_93_1.time_ < var_96_1 + var_96_2 + arg_96_0 and not isNil(var_96_0) and arg_93_1.var_.characterEffect10170ui_story then
				local var_96_5 = 0.5

				arg_93_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_93_1.var_.characterEffect10170ui_story.fillRatio = var_96_5
			end

			local var_96_6 = 0
			local var_96_7 = 0.425

			if var_96_6 < arg_93_1.time_ and arg_93_1.time_ <= var_96_6 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				local var_96_8 = arg_93_1:FormatText(StoryNameCfg[1454].name)

				arg_93_1.leftNameTxt_.text = var_96_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, true)
				arg_93_1.iconController_:SetSelectedState("hero")

				arg_93_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10169")

				arg_93_1.callingController_:SetSelectedState("normal")

				arg_93_1.keyicon_.color = Color.New(1, 1, 1)
				arg_93_1.icon_.color = Color.New(1, 1, 1)

				local var_96_9 = arg_93_1:GetWordFromCfg(323121023)
				local var_96_10 = arg_93_1:FormatText(var_96_9.content)

				arg_93_1.text_.text = var_96_10

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_11 = 17
				local var_96_12 = utf8.len(var_96_10)
				local var_96_13 = var_96_11 <= 0 and var_96_7 or var_96_7 * (var_96_12 / var_96_11)

				if var_96_13 > 0 and var_96_7 < var_96_13 then
					arg_93_1.talkMaxDuration = var_96_13

					if var_96_13 + var_96_6 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_13 + var_96_6
					end
				end

				arg_93_1.text_.text = var_96_10
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323121", "323121023", "story_v_out_323121.awb") ~= 0 then
					local var_96_14 = manager.audio:GetVoiceLength("story_v_out_323121", "323121023", "story_v_out_323121.awb") / 1000

					if var_96_14 + var_96_6 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_14 + var_96_6
					end

					if var_96_9.prefab_name ~= "" and arg_93_1.actors_[var_96_9.prefab_name] ~= nil then
						local var_96_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_9.prefab_name].transform, "story_v_out_323121", "323121023", "story_v_out_323121.awb")

						arg_93_1:RecordAudio("323121023", var_96_15)
						arg_93_1:RecordAudio("323121023", var_96_15)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_323121", "323121023", "story_v_out_323121.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_323121", "323121023", "story_v_out_323121.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_16 = math.max(var_96_7, arg_93_1.talkMaxDuration)

			if var_96_6 <= arg_93_1.time_ and arg_93_1.time_ < var_96_6 + var_96_16 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_6) / var_96_16

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_6 + var_96_16 and arg_93_1.time_ < var_96_6 + var_96_16 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play323121024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 323121024
		arg_97_1.duration_ = 22.07

		local var_97_0 = {
			zh = 13.7,
			ja = 22.066
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
				arg_97_0:Play323121025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = 0
			local var_100_1 = 1.175

			if var_100_0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_0 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				local var_100_2 = arg_97_1:FormatText(StoryNameCfg[1454].name)

				arg_97_1.leftNameTxt_.text = var_100_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, true)
				arg_97_1.iconController_:SetSelectedState("hero")

				arg_97_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10169")

				arg_97_1.callingController_:SetSelectedState("normal")

				arg_97_1.keyicon_.color = Color.New(1, 1, 1)
				arg_97_1.icon_.color = Color.New(1, 1, 1)

				local var_100_3 = arg_97_1:GetWordFromCfg(323121024)
				local var_100_4 = arg_97_1:FormatText(var_100_3.content)

				arg_97_1.text_.text = var_100_4

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_5 = 47
				local var_100_6 = utf8.len(var_100_4)
				local var_100_7 = var_100_5 <= 0 and var_100_1 or var_100_1 * (var_100_6 / var_100_5)

				if var_100_7 > 0 and var_100_1 < var_100_7 then
					arg_97_1.talkMaxDuration = var_100_7

					if var_100_7 + var_100_0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_7 + var_100_0
					end
				end

				arg_97_1.text_.text = var_100_4
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323121", "323121024", "story_v_out_323121.awb") ~= 0 then
					local var_100_8 = manager.audio:GetVoiceLength("story_v_out_323121", "323121024", "story_v_out_323121.awb") / 1000

					if var_100_8 + var_100_0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_8 + var_100_0
					end

					if var_100_3.prefab_name ~= "" and arg_97_1.actors_[var_100_3.prefab_name] ~= nil then
						local var_100_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_3.prefab_name].transform, "story_v_out_323121", "323121024", "story_v_out_323121.awb")

						arg_97_1:RecordAudio("323121024", var_100_9)
						arg_97_1:RecordAudio("323121024", var_100_9)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_323121", "323121024", "story_v_out_323121.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_323121", "323121024", "story_v_out_323121.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_10 = math.max(var_100_1, arg_97_1.talkMaxDuration)

			if var_100_0 <= arg_97_1.time_ and arg_97_1.time_ < var_100_0 + var_100_10 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_0) / var_100_10

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_0 + var_100_10 and arg_97_1.time_ < var_100_0 + var_100_10 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play323121025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 323121025
		arg_101_1.duration_ = 1.13

		local var_101_0 = {
			zh = 1.1,
			ja = 1.133
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
				arg_101_0:Play323121026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = arg_101_1.actors_["10170ui_story"]
			local var_104_1 = 0

			if var_104_1 < arg_101_1.time_ and arg_101_1.time_ <= var_104_1 + arg_104_0 and not isNil(var_104_0) and arg_101_1.var_.characterEffect10170ui_story == nil then
				arg_101_1.var_.characterEffect10170ui_story = var_104_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_2 = 0.200000002980232

			if var_104_1 <= arg_101_1.time_ and arg_101_1.time_ < var_104_1 + var_104_2 and not isNil(var_104_0) then
				local var_104_3 = (arg_101_1.time_ - var_104_1) / var_104_2

				if arg_101_1.var_.characterEffect10170ui_story and not isNil(var_104_0) then
					arg_101_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_101_1.time_ >= var_104_1 + var_104_2 and arg_101_1.time_ < var_104_1 + var_104_2 + arg_104_0 and not isNil(var_104_0) and arg_101_1.var_.characterEffect10170ui_story then
				arg_101_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_104_4 = 0
			local var_104_5 = 0.075

			if var_104_4 < arg_101_1.time_ and arg_101_1.time_ <= var_104_4 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				local var_104_6 = arg_101_1:FormatText(StoryNameCfg[1450].name)

				arg_101_1.leftNameTxt_.text = var_104_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_7 = arg_101_1:GetWordFromCfg(323121025)
				local var_104_8 = arg_101_1:FormatText(var_104_7.content)

				arg_101_1.text_.text = var_104_8

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_9 = 3
				local var_104_10 = utf8.len(var_104_8)
				local var_104_11 = var_104_9 <= 0 and var_104_5 or var_104_5 * (var_104_10 / var_104_9)

				if var_104_11 > 0 and var_104_5 < var_104_11 then
					arg_101_1.talkMaxDuration = var_104_11

					if var_104_11 + var_104_4 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_11 + var_104_4
					end
				end

				arg_101_1.text_.text = var_104_8
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323121", "323121025", "story_v_out_323121.awb") ~= 0 then
					local var_104_12 = manager.audio:GetVoiceLength("story_v_out_323121", "323121025", "story_v_out_323121.awb") / 1000

					if var_104_12 + var_104_4 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_12 + var_104_4
					end

					if var_104_7.prefab_name ~= "" and arg_101_1.actors_[var_104_7.prefab_name] ~= nil then
						local var_104_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_7.prefab_name].transform, "story_v_out_323121", "323121025", "story_v_out_323121.awb")

						arg_101_1:RecordAudio("323121025", var_104_13)
						arg_101_1:RecordAudio("323121025", var_104_13)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_323121", "323121025", "story_v_out_323121.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_323121", "323121025", "story_v_out_323121.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_14 = math.max(var_104_5, arg_101_1.talkMaxDuration)

			if var_104_4 <= arg_101_1.time_ and arg_101_1.time_ < var_104_4 + var_104_14 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_4) / var_104_14

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_4 + var_104_14 and arg_101_1.time_ < var_104_4 + var_104_14 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play323121026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 323121026
		arg_105_1.duration_ = 1.9

		local var_105_0 = {
			zh = 1.3,
			ja = 1.9
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
				arg_105_0:Play323121027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = arg_105_1.actors_["10170ui_story"]
			local var_108_1 = 0

			if var_108_1 < arg_105_1.time_ and arg_105_1.time_ <= var_108_1 + arg_108_0 and not isNil(var_108_0) and arg_105_1.var_.characterEffect10170ui_story == nil then
				arg_105_1.var_.characterEffect10170ui_story = var_108_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_2 = 0.200000002980232

			if var_108_1 <= arg_105_1.time_ and arg_105_1.time_ < var_108_1 + var_108_2 and not isNil(var_108_0) then
				local var_108_3 = (arg_105_1.time_ - var_108_1) / var_108_2

				if arg_105_1.var_.characterEffect10170ui_story and not isNil(var_108_0) then
					local var_108_4 = Mathf.Lerp(0, 0.5, var_108_3)

					arg_105_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_105_1.var_.characterEffect10170ui_story.fillRatio = var_108_4
				end
			end

			if arg_105_1.time_ >= var_108_1 + var_108_2 and arg_105_1.time_ < var_108_1 + var_108_2 + arg_108_0 and not isNil(var_108_0) and arg_105_1.var_.characterEffect10170ui_story then
				local var_108_5 = 0.5

				arg_105_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_105_1.var_.characterEffect10170ui_story.fillRatio = var_108_5
			end

			local var_108_6 = 0
			local var_108_7 = 0.075

			if var_108_6 < arg_105_1.time_ and arg_105_1.time_ <= var_108_6 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				local var_108_8 = arg_105_1:FormatText(StoryNameCfg[1454].name)

				arg_105_1.leftNameTxt_.text = var_108_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, true)
				arg_105_1.iconController_:SetSelectedState("hero")

				arg_105_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10169")

				arg_105_1.callingController_:SetSelectedState("normal")

				arg_105_1.keyicon_.color = Color.New(1, 1, 1)
				arg_105_1.icon_.color = Color.New(1, 1, 1)

				local var_108_9 = arg_105_1:GetWordFromCfg(323121026)
				local var_108_10 = arg_105_1:FormatText(var_108_9.content)

				arg_105_1.text_.text = var_108_10

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_11 = 3
				local var_108_12 = utf8.len(var_108_10)
				local var_108_13 = var_108_11 <= 0 and var_108_7 or var_108_7 * (var_108_12 / var_108_11)

				if var_108_13 > 0 and var_108_7 < var_108_13 then
					arg_105_1.talkMaxDuration = var_108_13

					if var_108_13 + var_108_6 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_13 + var_108_6
					end
				end

				arg_105_1.text_.text = var_108_10
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323121", "323121026", "story_v_out_323121.awb") ~= 0 then
					local var_108_14 = manager.audio:GetVoiceLength("story_v_out_323121", "323121026", "story_v_out_323121.awb") / 1000

					if var_108_14 + var_108_6 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_14 + var_108_6
					end

					if var_108_9.prefab_name ~= "" and arg_105_1.actors_[var_108_9.prefab_name] ~= nil then
						local var_108_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_9.prefab_name].transform, "story_v_out_323121", "323121026", "story_v_out_323121.awb")

						arg_105_1:RecordAudio("323121026", var_108_15)
						arg_105_1:RecordAudio("323121026", var_108_15)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_323121", "323121026", "story_v_out_323121.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_323121", "323121026", "story_v_out_323121.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_16 = math.max(var_108_7, arg_105_1.talkMaxDuration)

			if var_108_6 <= arg_105_1.time_ and arg_105_1.time_ < var_108_6 + var_108_16 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_6) / var_108_16

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_6 + var_108_16 and arg_105_1.time_ < var_108_6 + var_108_16 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play323121027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 323121027
		arg_109_1.duration_ = 5

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play323121028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = arg_109_1.actors_["10170ui_story"].transform
			local var_112_1 = 0

			if var_112_1 < arg_109_1.time_ and arg_109_1.time_ <= var_112_1 + arg_112_0 then
				arg_109_1.var_.moveOldPos10170ui_story = var_112_0.localPosition

				local var_112_2 = GameObjectTools.GetOrAddComponent(var_112_0.gameObject, typeof(DynamicBoneHelper))

				if var_112_2 then
					var_112_2:EnableDynamicBone(false)
				end
			end

			local var_112_3 = 0.001

			if var_112_1 <= arg_109_1.time_ and arg_109_1.time_ < var_112_1 + var_112_3 then
				local var_112_4 = (arg_109_1.time_ - var_112_1) / var_112_3
				local var_112_5 = Vector3.New(0, 100, 0)

				var_112_0.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos10170ui_story, var_112_5, var_112_4)

				local var_112_6 = manager.ui.mainCamera.transform.position - var_112_0.position

				var_112_0.forward = Vector3.New(var_112_6.x, var_112_6.y, var_112_6.z)

				local var_112_7 = var_112_0.localEulerAngles

				var_112_7.z = 0
				var_112_7.x = 0
				var_112_0.localEulerAngles = var_112_7
			end

			if arg_109_1.time_ >= var_112_1 + var_112_3 and arg_109_1.time_ < var_112_1 + var_112_3 + arg_112_0 then
				var_112_0.localPosition = Vector3.New(0, 100, 0)

				local var_112_8 = manager.ui.mainCamera.transform.position - var_112_0.position

				var_112_0.forward = Vector3.New(var_112_8.x, var_112_8.y, var_112_8.z)

				local var_112_9 = var_112_0.localEulerAngles

				var_112_9.z = 0
				var_112_9.x = 0
				var_112_0.localEulerAngles = var_112_9

				local var_112_10 = GameObjectTools.GetOrAddComponent(var_112_0.gameObject, typeof(DynamicBoneHelper))

				if var_112_10 then
					var_112_10:EnableDynamicBone(true)
				end
			end

			local var_112_11 = arg_109_1.actors_["1053ui_story"].transform
			local var_112_12 = 0

			if var_112_12 < arg_109_1.time_ and arg_109_1.time_ <= var_112_12 + arg_112_0 then
				arg_109_1.var_.moveOldPos1053ui_story = var_112_11.localPosition

				local var_112_13 = GameObjectTools.GetOrAddComponent(var_112_11.gameObject, typeof(DynamicBoneHelper))

				if var_112_13 then
					var_112_13:EnableDynamicBone(false)
				end
			end

			local var_112_14 = 0.001

			if var_112_12 <= arg_109_1.time_ and arg_109_1.time_ < var_112_12 + var_112_14 then
				local var_112_15 = (arg_109_1.time_ - var_112_12) / var_112_14
				local var_112_16 = Vector3.New(0, 100, 0)

				var_112_11.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos1053ui_story, var_112_16, var_112_15)

				local var_112_17 = manager.ui.mainCamera.transform.position - var_112_11.position

				var_112_11.forward = Vector3.New(var_112_17.x, var_112_17.y, var_112_17.z)

				local var_112_18 = var_112_11.localEulerAngles

				var_112_18.z = 0
				var_112_18.x = 0
				var_112_11.localEulerAngles = var_112_18
			end

			if arg_109_1.time_ >= var_112_12 + var_112_14 and arg_109_1.time_ < var_112_12 + var_112_14 + arg_112_0 then
				var_112_11.localPosition = Vector3.New(0, 100, 0)

				local var_112_19 = manager.ui.mainCamera.transform.position - var_112_11.position

				var_112_11.forward = Vector3.New(var_112_19.x, var_112_19.y, var_112_19.z)

				local var_112_20 = var_112_11.localEulerAngles

				var_112_20.z = 0
				var_112_20.x = 0
				var_112_11.localEulerAngles = var_112_20

				local var_112_21 = GameObjectTools.GetOrAddComponent(var_112_11.gameObject, typeof(DynamicBoneHelper))

				if var_112_21 then
					var_112_21:EnableDynamicBone(true)
				end
			end

			local var_112_22 = 0
			local var_112_23 = 0.775

			if var_112_22 < arg_109_1.time_ and arg_109_1.time_ <= var_112_22 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, false)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_24 = arg_109_1:GetWordFromCfg(323121027)
				local var_112_25 = arg_109_1:FormatText(var_112_24.content)

				arg_109_1.text_.text = var_112_25

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_26 = 31
				local var_112_27 = utf8.len(var_112_25)
				local var_112_28 = var_112_26 <= 0 and var_112_23 or var_112_23 * (var_112_27 / var_112_26)

				if var_112_28 > 0 and var_112_23 < var_112_28 then
					arg_109_1.talkMaxDuration = var_112_28

					if var_112_28 + var_112_22 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_28 + var_112_22
					end
				end

				arg_109_1.text_.text = var_112_25
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)
				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_29 = math.max(var_112_23, arg_109_1.talkMaxDuration)

			if var_112_22 <= arg_109_1.time_ and arg_109_1.time_ < var_112_22 + var_112_29 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_22) / var_112_29

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_22 + var_112_29 and arg_109_1.time_ < var_112_22 + var_112_29 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_109_1:InitPlayNodeList()
	end,
	Play323121028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 323121028
		arg_113_1.duration_ = 9.13

		local var_113_0 = {
			zh = 5.7,
			ja = 9.133
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
				arg_113_0:Play323121029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = arg_113_1.actors_["1053ui_story"].transform
			local var_116_1 = 0

			if var_116_1 < arg_113_1.time_ and arg_113_1.time_ <= var_116_1 + arg_116_0 then
				arg_113_1.var_.moveOldPos1053ui_story = var_116_0.localPosition

				local var_116_2 = GameObjectTools.GetOrAddComponent(var_116_0.gameObject, typeof(DynamicBoneHelper))

				if var_116_2 then
					var_116_2:EnableDynamicBone(false)
				end
			end

			local var_116_3 = 0.001

			if var_116_1 <= arg_113_1.time_ and arg_113_1.time_ < var_116_1 + var_116_3 then
				local var_116_4 = (arg_113_1.time_ - var_116_1) / var_116_3
				local var_116_5 = Vector3.New(0, -1.08, -6)

				var_116_0.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos1053ui_story, var_116_5, var_116_4)

				local var_116_6 = manager.ui.mainCamera.transform.position - var_116_0.position

				var_116_0.forward = Vector3.New(var_116_6.x, var_116_6.y, var_116_6.z)

				local var_116_7 = var_116_0.localEulerAngles

				var_116_7.z = 0
				var_116_7.x = 0
				var_116_0.localEulerAngles = var_116_7
			end

			if arg_113_1.time_ >= var_116_1 + var_116_3 and arg_113_1.time_ < var_116_1 + var_116_3 + arg_116_0 then
				var_116_0.localPosition = Vector3.New(0, -1.08, -6)

				local var_116_8 = manager.ui.mainCamera.transform.position - var_116_0.position

				var_116_0.forward = Vector3.New(var_116_8.x, var_116_8.y, var_116_8.z)

				local var_116_9 = var_116_0.localEulerAngles

				var_116_9.z = 0
				var_116_9.x = 0
				var_116_0.localEulerAngles = var_116_9

				local var_116_10 = GameObjectTools.GetOrAddComponent(var_116_0.gameObject, typeof(DynamicBoneHelper))

				if var_116_10 then
					var_116_10:EnableDynamicBone(true)
				end
			end

			local var_116_11 = arg_113_1.actors_["1053ui_story"]
			local var_116_12 = 0

			if var_116_12 < arg_113_1.time_ and arg_113_1.time_ <= var_116_12 + arg_116_0 and not isNil(var_116_11) and arg_113_1.var_.characterEffect1053ui_story == nil then
				arg_113_1.var_.characterEffect1053ui_story = var_116_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_13 = 0.200000002980232

			if var_116_12 <= arg_113_1.time_ and arg_113_1.time_ < var_116_12 + var_116_13 and not isNil(var_116_11) then
				local var_116_14 = (arg_113_1.time_ - var_116_12) / var_116_13

				if arg_113_1.var_.characterEffect1053ui_story and not isNil(var_116_11) then
					arg_113_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_113_1.time_ >= var_116_12 + var_116_13 and arg_113_1.time_ < var_116_12 + var_116_13 + arg_116_0 and not isNil(var_116_11) and arg_113_1.var_.characterEffect1053ui_story then
				arg_113_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_116_15 = 0

			if var_116_15 < arg_113_1.time_ and arg_113_1.time_ <= var_116_15 + arg_116_0 then
				arg_113_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053action/1053action2_2")
			end

			local var_116_16 = 0

			if var_116_16 < arg_113_1.time_ and arg_113_1.time_ <= var_116_16 + arg_116_0 then
				arg_113_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_116_17 = 0
			local var_116_18 = 0.65

			if var_116_17 < arg_113_1.time_ and arg_113_1.time_ <= var_116_17 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				local var_116_19 = arg_113_1:FormatText(StoryNameCfg[1453].name)

				arg_113_1.leftNameTxt_.text = var_116_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_20 = arg_113_1:GetWordFromCfg(323121028)
				local var_116_21 = arg_113_1:FormatText(var_116_20.content)

				arg_113_1.text_.text = var_116_21

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_22 = 26
				local var_116_23 = utf8.len(var_116_21)
				local var_116_24 = var_116_22 <= 0 and var_116_18 or var_116_18 * (var_116_23 / var_116_22)

				if var_116_24 > 0 and var_116_18 < var_116_24 then
					arg_113_1.talkMaxDuration = var_116_24

					if var_116_24 + var_116_17 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_24 + var_116_17
					end
				end

				arg_113_1.text_.text = var_116_21
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323121", "323121028", "story_v_out_323121.awb") ~= 0 then
					local var_116_25 = manager.audio:GetVoiceLength("story_v_out_323121", "323121028", "story_v_out_323121.awb") / 1000

					if var_116_25 + var_116_17 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_25 + var_116_17
					end

					if var_116_20.prefab_name ~= "" and arg_113_1.actors_[var_116_20.prefab_name] ~= nil then
						local var_116_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_20.prefab_name].transform, "story_v_out_323121", "323121028", "story_v_out_323121.awb")

						arg_113_1:RecordAudio("323121028", var_116_26)
						arg_113_1:RecordAudio("323121028", var_116_26)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_323121", "323121028", "story_v_out_323121.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_323121", "323121028", "story_v_out_323121.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_27 = math.max(var_116_18, arg_113_1.talkMaxDuration)

			if var_116_17 <= arg_113_1.time_ and arg_113_1.time_ < var_116_17 + var_116_27 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_17) / var_116_27

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_17 + var_116_27 and arg_113_1.time_ < var_116_17 + var_116_27 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_113_1:InitPlayNodeList()
	end,
	Play323121029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 323121029
		arg_117_1.duration_ = 11.9

		local var_117_0 = {
			zh = 7.8,
			ja = 11.9
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
				arg_117_0:Play323121030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = 0
			local var_120_1 = 0.825

			if var_120_0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_0 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				local var_120_2 = arg_117_1:FormatText(StoryNameCfg[1453].name)

				arg_117_1.leftNameTxt_.text = var_120_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_3 = arg_117_1:GetWordFromCfg(323121029)
				local var_120_4 = arg_117_1:FormatText(var_120_3.content)

				arg_117_1.text_.text = var_120_4

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_5 = 33
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

				if manager.audio:GetVoiceLength("story_v_out_323121", "323121029", "story_v_out_323121.awb") ~= 0 then
					local var_120_8 = manager.audio:GetVoiceLength("story_v_out_323121", "323121029", "story_v_out_323121.awb") / 1000

					if var_120_8 + var_120_0 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_8 + var_120_0
					end

					if var_120_3.prefab_name ~= "" and arg_117_1.actors_[var_120_3.prefab_name] ~= nil then
						local var_120_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_3.prefab_name].transform, "story_v_out_323121", "323121029", "story_v_out_323121.awb")

						arg_117_1:RecordAudio("323121029", var_120_9)
						arg_117_1:RecordAudio("323121029", var_120_9)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_323121", "323121029", "story_v_out_323121.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_323121", "323121029", "story_v_out_323121.awb")
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
	Play323121030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 323121030
		arg_121_1.duration_ = 6.1

		local var_121_0 = {
			zh = 3.366,
			ja = 6.1
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
				arg_121_0:Play323121031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = 0
			local var_124_1 = 0.35

			if var_124_0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_0 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				local var_124_2 = arg_121_1:FormatText(StoryNameCfg[1453].name)

				arg_121_1.leftNameTxt_.text = var_124_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_3 = arg_121_1:GetWordFromCfg(323121030)
				local var_124_4 = arg_121_1:FormatText(var_124_3.content)

				arg_121_1.text_.text = var_124_4

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_5 = 14
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

				if manager.audio:GetVoiceLength("story_v_out_323121", "323121030", "story_v_out_323121.awb") ~= 0 then
					local var_124_8 = manager.audio:GetVoiceLength("story_v_out_323121", "323121030", "story_v_out_323121.awb") / 1000

					if var_124_8 + var_124_0 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_8 + var_124_0
					end

					if var_124_3.prefab_name ~= "" and arg_121_1.actors_[var_124_3.prefab_name] ~= nil then
						local var_124_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_3.prefab_name].transform, "story_v_out_323121", "323121030", "story_v_out_323121.awb")

						arg_121_1:RecordAudio("323121030", var_124_9)
						arg_121_1:RecordAudio("323121030", var_124_9)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_323121", "323121030", "story_v_out_323121.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_323121", "323121030", "story_v_out_323121.awb")
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
	Play323121031 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 323121031
		arg_125_1.duration_ = 20.13

		local var_125_0 = {
			zh = 11.6,
			ja = 20.133
		}
		local var_125_1 = manager.audio:GetLocalizationFlag()

		if var_125_0[var_125_1] ~= nil then
			arg_125_1.duration_ = var_125_0[var_125_1]
		end

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play323121032(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = arg_125_1.actors_["1053ui_story"]
			local var_128_1 = 0

			if var_128_1 < arg_125_1.time_ and arg_125_1.time_ <= var_128_1 + arg_128_0 and not isNil(var_128_0) and arg_125_1.var_.characterEffect1053ui_story == nil then
				arg_125_1.var_.characterEffect1053ui_story = var_128_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_2 = 0.200000002980232

			if var_128_1 <= arg_125_1.time_ and arg_125_1.time_ < var_128_1 + var_128_2 and not isNil(var_128_0) then
				local var_128_3 = (arg_125_1.time_ - var_128_1) / var_128_2

				if arg_125_1.var_.characterEffect1053ui_story and not isNil(var_128_0) then
					local var_128_4 = Mathf.Lerp(0, 0.5, var_128_3)

					arg_125_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_125_1.var_.characterEffect1053ui_story.fillRatio = var_128_4
				end
			end

			if arg_125_1.time_ >= var_128_1 + var_128_2 and arg_125_1.time_ < var_128_1 + var_128_2 + arg_128_0 and not isNil(var_128_0) and arg_125_1.var_.characterEffect1053ui_story then
				local var_128_5 = 0.5

				arg_125_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_125_1.var_.characterEffect1053ui_story.fillRatio = var_128_5
			end

			local var_128_6 = 0
			local var_128_7 = 1.175

			if var_128_6 < arg_125_1.time_ and arg_125_1.time_ <= var_128_6 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				local var_128_8 = arg_125_1:FormatText(StoryNameCfg[1454].name)

				arg_125_1.leftNameTxt_.text = var_128_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, true)
				arg_125_1.iconController_:SetSelectedState("hero")

				arg_125_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10169")

				arg_125_1.callingController_:SetSelectedState("normal")

				arg_125_1.keyicon_.color = Color.New(1, 1, 1)
				arg_125_1.icon_.color = Color.New(1, 1, 1)

				local var_128_9 = arg_125_1:GetWordFromCfg(323121031)
				local var_128_10 = arg_125_1:FormatText(var_128_9.content)

				arg_125_1.text_.text = var_128_10

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_11 = 47
				local var_128_12 = utf8.len(var_128_10)
				local var_128_13 = var_128_11 <= 0 and var_128_7 or var_128_7 * (var_128_12 / var_128_11)

				if var_128_13 > 0 and var_128_7 < var_128_13 then
					arg_125_1.talkMaxDuration = var_128_13

					if var_128_13 + var_128_6 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_13 + var_128_6
					end
				end

				arg_125_1.text_.text = var_128_10
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323121", "323121031", "story_v_out_323121.awb") ~= 0 then
					local var_128_14 = manager.audio:GetVoiceLength("story_v_out_323121", "323121031", "story_v_out_323121.awb") / 1000

					if var_128_14 + var_128_6 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_14 + var_128_6
					end

					if var_128_9.prefab_name ~= "" and arg_125_1.actors_[var_128_9.prefab_name] ~= nil then
						local var_128_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_9.prefab_name].transform, "story_v_out_323121", "323121031", "story_v_out_323121.awb")

						arg_125_1:RecordAudio("323121031", var_128_15)
						arg_125_1:RecordAudio("323121031", var_128_15)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_323121", "323121031", "story_v_out_323121.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_323121", "323121031", "story_v_out_323121.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_16 = math.max(var_128_7, arg_125_1.talkMaxDuration)

			if var_128_6 <= arg_125_1.time_ and arg_125_1.time_ < var_128_6 + var_128_16 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_6) / var_128_16

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_6 + var_128_16 and arg_125_1.time_ < var_128_6 + var_128_16 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play323121032 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 323121032
		arg_129_1.duration_ = 16.97

		local var_129_0 = {
			zh = 9.6,
			ja = 16.966
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
				arg_129_0:Play323121033(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = 0
			local var_132_1 = 0.875

			if var_132_0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_0 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				local var_132_2 = arg_129_1:FormatText(StoryNameCfg[1454].name)

				arg_129_1.leftNameTxt_.text = var_132_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, true)
				arg_129_1.iconController_:SetSelectedState("hero")

				arg_129_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10169")

				arg_129_1.callingController_:SetSelectedState("normal")

				arg_129_1.keyicon_.color = Color.New(1, 1, 1)
				arg_129_1.icon_.color = Color.New(1, 1, 1)

				local var_132_3 = arg_129_1:GetWordFromCfg(323121032)
				local var_132_4 = arg_129_1:FormatText(var_132_3.content)

				arg_129_1.text_.text = var_132_4

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_5 = 35
				local var_132_6 = utf8.len(var_132_4)
				local var_132_7 = var_132_5 <= 0 and var_132_1 or var_132_1 * (var_132_6 / var_132_5)

				if var_132_7 > 0 and var_132_1 < var_132_7 then
					arg_129_1.talkMaxDuration = var_132_7

					if var_132_7 + var_132_0 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_7 + var_132_0
					end
				end

				arg_129_1.text_.text = var_132_4
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323121", "323121032", "story_v_out_323121.awb") ~= 0 then
					local var_132_8 = manager.audio:GetVoiceLength("story_v_out_323121", "323121032", "story_v_out_323121.awb") / 1000

					if var_132_8 + var_132_0 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_8 + var_132_0
					end

					if var_132_3.prefab_name ~= "" and arg_129_1.actors_[var_132_3.prefab_name] ~= nil then
						local var_132_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_3.prefab_name].transform, "story_v_out_323121", "323121032", "story_v_out_323121.awb")

						arg_129_1:RecordAudio("323121032", var_132_9)
						arg_129_1:RecordAudio("323121032", var_132_9)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_323121", "323121032", "story_v_out_323121.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_323121", "323121032", "story_v_out_323121.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_10 = math.max(var_132_1, arg_129_1.talkMaxDuration)

			if var_132_0 <= arg_129_1.time_ and arg_129_1.time_ < var_132_0 + var_132_10 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_0) / var_132_10

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_0 + var_132_10 and arg_129_1.time_ < var_132_0 + var_132_10 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play323121033 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 323121033
		arg_133_1.duration_ = 4.1

		local var_133_0 = {
			zh = 2.733,
			ja = 4.1
		}
		local var_133_1 = manager.audio:GetLocalizationFlag()

		if var_133_0[var_133_1] ~= nil then
			arg_133_1.duration_ = var_133_0[var_133_1]
		end

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play323121034(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = arg_133_1.actors_["1053ui_story"].transform
			local var_136_1 = 0

			if var_136_1 < arg_133_1.time_ and arg_133_1.time_ <= var_136_1 + arg_136_0 then
				arg_133_1.var_.moveOldPos1053ui_story = var_136_0.localPosition

				local var_136_2 = GameObjectTools.GetOrAddComponent(var_136_0.gameObject, typeof(DynamicBoneHelper))

				if var_136_2 then
					var_136_2:EnableDynamicBone(false)
				end
			end

			local var_136_3 = 0.001

			if var_136_1 <= arg_133_1.time_ and arg_133_1.time_ < var_136_1 + var_136_3 then
				local var_136_4 = (arg_133_1.time_ - var_136_1) / var_136_3
				local var_136_5 = Vector3.New(0, 100, 0)

				var_136_0.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos1053ui_story, var_136_5, var_136_4)

				local var_136_6 = manager.ui.mainCamera.transform.position - var_136_0.position

				var_136_0.forward = Vector3.New(var_136_6.x, var_136_6.y, var_136_6.z)

				local var_136_7 = var_136_0.localEulerAngles

				var_136_7.z = 0
				var_136_7.x = 0
				var_136_0.localEulerAngles = var_136_7
			end

			if arg_133_1.time_ >= var_136_1 + var_136_3 and arg_133_1.time_ < var_136_1 + var_136_3 + arg_136_0 then
				var_136_0.localPosition = Vector3.New(0, 100, 0)

				local var_136_8 = manager.ui.mainCamera.transform.position - var_136_0.position

				var_136_0.forward = Vector3.New(var_136_8.x, var_136_8.y, var_136_8.z)

				local var_136_9 = var_136_0.localEulerAngles

				var_136_9.z = 0
				var_136_9.x = 0
				var_136_0.localEulerAngles = var_136_9

				local var_136_10 = GameObjectTools.GetOrAddComponent(var_136_0.gameObject, typeof(DynamicBoneHelper))

				if var_136_10 then
					var_136_10:EnableDynamicBone(true)
				end
			end

			local var_136_11 = arg_133_1.actors_["10170ui_story"].transform
			local var_136_12 = 0

			if var_136_12 < arg_133_1.time_ and arg_133_1.time_ <= var_136_12 + arg_136_0 then
				arg_133_1.var_.moveOldPos10170ui_story = var_136_11.localPosition

				local var_136_13 = GameObjectTools.GetOrAddComponent(var_136_11.gameObject, typeof(DynamicBoneHelper))

				if var_136_13 then
					var_136_13:EnableDynamicBone(false)
				end
			end

			local var_136_14 = 0.001

			if var_136_12 <= arg_133_1.time_ and arg_133_1.time_ < var_136_12 + var_136_14 then
				local var_136_15 = (arg_133_1.time_ - var_136_12) / var_136_14
				local var_136_16 = Vector3.New(0, -1.03, -6.05)

				var_136_11.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos10170ui_story, var_136_16, var_136_15)

				local var_136_17 = manager.ui.mainCamera.transform.position - var_136_11.position

				var_136_11.forward = Vector3.New(var_136_17.x, var_136_17.y, var_136_17.z)

				local var_136_18 = var_136_11.localEulerAngles

				var_136_18.z = 0
				var_136_18.x = 0
				var_136_11.localEulerAngles = var_136_18
			end

			if arg_133_1.time_ >= var_136_12 + var_136_14 and arg_133_1.time_ < var_136_12 + var_136_14 + arg_136_0 then
				var_136_11.localPosition = Vector3.New(0, -1.03, -6.05)

				local var_136_19 = manager.ui.mainCamera.transform.position - var_136_11.position

				var_136_11.forward = Vector3.New(var_136_19.x, var_136_19.y, var_136_19.z)

				local var_136_20 = var_136_11.localEulerAngles

				var_136_20.z = 0
				var_136_20.x = 0
				var_136_11.localEulerAngles = var_136_20

				local var_136_21 = GameObjectTools.GetOrAddComponent(var_136_11.gameObject, typeof(DynamicBoneHelper))

				if var_136_21 then
					var_136_21:EnableDynamicBone(true)
				end
			end

			local var_136_22 = arg_133_1.actors_["10170ui_story"]
			local var_136_23 = 0

			if var_136_23 < arg_133_1.time_ and arg_133_1.time_ <= var_136_23 + arg_136_0 and not isNil(var_136_22) and arg_133_1.var_.characterEffect10170ui_story == nil then
				arg_133_1.var_.characterEffect10170ui_story = var_136_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_24 = 0.200000002980232

			if var_136_23 <= arg_133_1.time_ and arg_133_1.time_ < var_136_23 + var_136_24 and not isNil(var_136_22) then
				local var_136_25 = (arg_133_1.time_ - var_136_23) / var_136_24

				if arg_133_1.var_.characterEffect10170ui_story and not isNil(var_136_22) then
					arg_133_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_133_1.time_ >= var_136_23 + var_136_24 and arg_133_1.time_ < var_136_23 + var_136_24 + arg_136_0 and not isNil(var_136_22) and arg_133_1.var_.characterEffect10170ui_story then
				arg_133_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_136_26 = 0

			if var_136_26 < arg_133_1.time_ and arg_133_1.time_ <= var_136_26 + arg_136_0 then
				arg_133_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_136_27 = 0

			if var_136_27 < arg_133_1.time_ and arg_133_1.time_ <= var_136_27 + arg_136_0 then
				arg_133_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/story10170/story10170action/10170action1_1")
			end

			local var_136_28 = 0
			local var_136_29 = 0.375

			if var_136_28 < arg_133_1.time_ and arg_133_1.time_ <= var_136_28 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				local var_136_30 = arg_133_1:FormatText(StoryNameCfg[1450].name)

				arg_133_1.leftNameTxt_.text = var_136_30

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_31 = arg_133_1:GetWordFromCfg(323121033)
				local var_136_32 = arg_133_1:FormatText(var_136_31.content)

				arg_133_1.text_.text = var_136_32

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_33 = 15
				local var_136_34 = utf8.len(var_136_32)
				local var_136_35 = var_136_33 <= 0 and var_136_29 or var_136_29 * (var_136_34 / var_136_33)

				if var_136_35 > 0 and var_136_29 < var_136_35 then
					arg_133_1.talkMaxDuration = var_136_35

					if var_136_35 + var_136_28 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_35 + var_136_28
					end
				end

				arg_133_1.text_.text = var_136_32
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323121", "323121033", "story_v_out_323121.awb") ~= 0 then
					local var_136_36 = manager.audio:GetVoiceLength("story_v_out_323121", "323121033", "story_v_out_323121.awb") / 1000

					if var_136_36 + var_136_28 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_36 + var_136_28
					end

					if var_136_31.prefab_name ~= "" and arg_133_1.actors_[var_136_31.prefab_name] ~= nil then
						local var_136_37 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_31.prefab_name].transform, "story_v_out_323121", "323121033", "story_v_out_323121.awb")

						arg_133_1:RecordAudio("323121033", var_136_37)
						arg_133_1:RecordAudio("323121033", var_136_37)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_323121", "323121033", "story_v_out_323121.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_323121", "323121033", "story_v_out_323121.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_38 = math.max(var_136_29, arg_133_1.talkMaxDuration)

			if var_136_28 <= arg_133_1.time_ and arg_133_1.time_ < var_136_28 + var_136_38 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_28) / var_136_38

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_28 + var_136_38 and arg_133_1.time_ < var_136_28 + var_136_38 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_133_1:InitPlayNodeList()
	end,
	Play323121034 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 323121034
		arg_137_1.duration_ = 4.4

		local var_137_0 = {
			zh = 2.7,
			ja = 4.4
		}
		local var_137_1 = manager.audio:GetLocalizationFlag()

		if var_137_0[var_137_1] ~= nil then
			arg_137_1.duration_ = var_137_0[var_137_1]
		end

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play323121035(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = arg_137_1.actors_["10170ui_story"]
			local var_140_1 = 0

			if var_140_1 < arg_137_1.time_ and arg_137_1.time_ <= var_140_1 + arg_140_0 and not isNil(var_140_0) and arg_137_1.var_.characterEffect10170ui_story == nil then
				arg_137_1.var_.characterEffect10170ui_story = var_140_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_2 = 0.200000002980232

			if var_140_1 <= arg_137_1.time_ and arg_137_1.time_ < var_140_1 + var_140_2 and not isNil(var_140_0) then
				local var_140_3 = (arg_137_1.time_ - var_140_1) / var_140_2

				if arg_137_1.var_.characterEffect10170ui_story and not isNil(var_140_0) then
					local var_140_4 = Mathf.Lerp(0, 0.5, var_140_3)

					arg_137_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_137_1.var_.characterEffect10170ui_story.fillRatio = var_140_4
				end
			end

			if arg_137_1.time_ >= var_140_1 + var_140_2 and arg_137_1.time_ < var_140_1 + var_140_2 + arg_140_0 and not isNil(var_140_0) and arg_137_1.var_.characterEffect10170ui_story then
				local var_140_5 = 0.5

				arg_137_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_137_1.var_.characterEffect10170ui_story.fillRatio = var_140_5
			end

			local var_140_6 = 0
			local var_140_7 = 0.25

			if var_140_6 < arg_137_1.time_ and arg_137_1.time_ <= var_140_6 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				local var_140_8 = arg_137_1:FormatText(StoryNameCfg[1454].name)

				arg_137_1.leftNameTxt_.text = var_140_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, true)
				arg_137_1.iconController_:SetSelectedState("hero")

				arg_137_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10169")

				arg_137_1.callingController_:SetSelectedState("normal")

				arg_137_1.keyicon_.color = Color.New(1, 1, 1)
				arg_137_1.icon_.color = Color.New(1, 1, 1)

				local var_140_9 = arg_137_1:GetWordFromCfg(323121034)
				local var_140_10 = arg_137_1:FormatText(var_140_9.content)

				arg_137_1.text_.text = var_140_10

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_11 = 10
				local var_140_12 = utf8.len(var_140_10)
				local var_140_13 = var_140_11 <= 0 and var_140_7 or var_140_7 * (var_140_12 / var_140_11)

				if var_140_13 > 0 and var_140_7 < var_140_13 then
					arg_137_1.talkMaxDuration = var_140_13

					if var_140_13 + var_140_6 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_13 + var_140_6
					end
				end

				arg_137_1.text_.text = var_140_10
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323121", "323121034", "story_v_out_323121.awb") ~= 0 then
					local var_140_14 = manager.audio:GetVoiceLength("story_v_out_323121", "323121034", "story_v_out_323121.awb") / 1000

					if var_140_14 + var_140_6 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_14 + var_140_6
					end

					if var_140_9.prefab_name ~= "" and arg_137_1.actors_[var_140_9.prefab_name] ~= nil then
						local var_140_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_9.prefab_name].transform, "story_v_out_323121", "323121034", "story_v_out_323121.awb")

						arg_137_1:RecordAudio("323121034", var_140_15)
						arg_137_1:RecordAudio("323121034", var_140_15)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_323121", "323121034", "story_v_out_323121.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_323121", "323121034", "story_v_out_323121.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_16 = math.max(var_140_7, arg_137_1.talkMaxDuration)

			if var_140_6 <= arg_137_1.time_ and arg_137_1.time_ < var_140_6 + var_140_16 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_6) / var_140_16

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_6 + var_140_16 and arg_137_1.time_ < var_140_6 + var_140_16 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play323121035 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 323121035
		arg_141_1.duration_ = 4.43

		local var_141_0 = {
			zh = 2.633,
			ja = 4.433
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
				arg_141_0:Play323121036(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = arg_141_1.actors_["10170ui_story"]
			local var_144_1 = 0

			if var_144_1 < arg_141_1.time_ and arg_141_1.time_ <= var_144_1 + arg_144_0 and not isNil(var_144_0) and arg_141_1.var_.characterEffect10170ui_story == nil then
				arg_141_1.var_.characterEffect10170ui_story = var_144_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_2 = 0.200000002980232

			if var_144_1 <= arg_141_1.time_ and arg_141_1.time_ < var_144_1 + var_144_2 and not isNil(var_144_0) then
				local var_144_3 = (arg_141_1.time_ - var_144_1) / var_144_2

				if arg_141_1.var_.characterEffect10170ui_story and not isNil(var_144_0) then
					arg_141_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_141_1.time_ >= var_144_1 + var_144_2 and arg_141_1.time_ < var_144_1 + var_144_2 + arg_144_0 and not isNil(var_144_0) and arg_141_1.var_.characterEffect10170ui_story then
				arg_141_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_144_4 = 0

			if var_144_4 < arg_141_1.time_ and arg_141_1.time_ <= var_144_4 + arg_144_0 then
				arg_141_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_144_5 = 0

			if var_144_5 < arg_141_1.time_ and arg_141_1.time_ <= var_144_5 + arg_144_0 then
				arg_141_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/story10170/story10170action/10170action31_1")
			end

			local var_144_6 = 0
			local var_144_7 = 0.25

			if var_144_6 < arg_141_1.time_ and arg_141_1.time_ <= var_144_6 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				local var_144_8 = arg_141_1:FormatText(StoryNameCfg[1450].name)

				arg_141_1.leftNameTxt_.text = var_144_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_9 = arg_141_1:GetWordFromCfg(323121035)
				local var_144_10 = arg_141_1:FormatText(var_144_9.content)

				arg_141_1.text_.text = var_144_10

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_11 = 10
				local var_144_12 = utf8.len(var_144_10)
				local var_144_13 = var_144_11 <= 0 and var_144_7 or var_144_7 * (var_144_12 / var_144_11)

				if var_144_13 > 0 and var_144_7 < var_144_13 then
					arg_141_1.talkMaxDuration = var_144_13

					if var_144_13 + var_144_6 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_13 + var_144_6
					end
				end

				arg_141_1.text_.text = var_144_10
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323121", "323121035", "story_v_out_323121.awb") ~= 0 then
					local var_144_14 = manager.audio:GetVoiceLength("story_v_out_323121", "323121035", "story_v_out_323121.awb") / 1000

					if var_144_14 + var_144_6 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_14 + var_144_6
					end

					if var_144_9.prefab_name ~= "" and arg_141_1.actors_[var_144_9.prefab_name] ~= nil then
						local var_144_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_9.prefab_name].transform, "story_v_out_323121", "323121035", "story_v_out_323121.awb")

						arg_141_1:RecordAudio("323121035", var_144_15)
						arg_141_1:RecordAudio("323121035", var_144_15)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_323121", "323121035", "story_v_out_323121.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_323121", "323121035", "story_v_out_323121.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_16 = math.max(var_144_7, arg_141_1.talkMaxDuration)

			if var_144_6 <= arg_141_1.time_ and arg_141_1.time_ < var_144_6 + var_144_16 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_6) / var_144_16

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_6 + var_144_16 and arg_141_1.time_ < var_144_6 + var_144_16 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play323121036 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 323121036
		arg_145_1.duration_ = 5

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play323121037(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = arg_145_1.actors_["10170ui_story"]
			local var_148_1 = 0

			if var_148_1 < arg_145_1.time_ and arg_145_1.time_ <= var_148_1 + arg_148_0 and not isNil(var_148_0) and arg_145_1.var_.characterEffect10170ui_story == nil then
				arg_145_1.var_.characterEffect10170ui_story = var_148_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_2 = 0.200000002980232

			if var_148_1 <= arg_145_1.time_ and arg_145_1.time_ < var_148_1 + var_148_2 and not isNil(var_148_0) then
				local var_148_3 = (arg_145_1.time_ - var_148_1) / var_148_2

				if arg_145_1.var_.characterEffect10170ui_story and not isNil(var_148_0) then
					local var_148_4 = Mathf.Lerp(0, 0.5, var_148_3)

					arg_145_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_145_1.var_.characterEffect10170ui_story.fillRatio = var_148_4
				end
			end

			if arg_145_1.time_ >= var_148_1 + var_148_2 and arg_145_1.time_ < var_148_1 + var_148_2 + arg_148_0 and not isNil(var_148_0) and arg_145_1.var_.characterEffect10170ui_story then
				local var_148_5 = 0.5

				arg_145_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_145_1.var_.characterEffect10170ui_story.fillRatio = var_148_5
			end

			local var_148_6 = arg_145_1.actors_["10170ui_story"].transform
			local var_148_7 = 0

			if var_148_7 < arg_145_1.time_ and arg_145_1.time_ <= var_148_7 + arg_148_0 then
				arg_145_1.var_.moveOldPos10170ui_story = var_148_6.localPosition

				local var_148_8 = GameObjectTools.GetOrAddComponent(var_148_6.gameObject, typeof(DynamicBoneHelper))

				if var_148_8 then
					var_148_8:EnableDynamicBone(false)
				end
			end

			local var_148_9 = 0.001

			if var_148_7 <= arg_145_1.time_ and arg_145_1.time_ < var_148_7 + var_148_9 then
				local var_148_10 = (arg_145_1.time_ - var_148_7) / var_148_9
				local var_148_11 = Vector3.New(0, 100, 0)

				var_148_6.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos10170ui_story, var_148_11, var_148_10)

				local var_148_12 = manager.ui.mainCamera.transform.position - var_148_6.position

				var_148_6.forward = Vector3.New(var_148_12.x, var_148_12.y, var_148_12.z)

				local var_148_13 = var_148_6.localEulerAngles

				var_148_13.z = 0
				var_148_13.x = 0
				var_148_6.localEulerAngles = var_148_13
			end

			if arg_145_1.time_ >= var_148_7 + var_148_9 and arg_145_1.time_ < var_148_7 + var_148_9 + arg_148_0 then
				var_148_6.localPosition = Vector3.New(0, 100, 0)

				local var_148_14 = manager.ui.mainCamera.transform.position - var_148_6.position

				var_148_6.forward = Vector3.New(var_148_14.x, var_148_14.y, var_148_14.z)

				local var_148_15 = var_148_6.localEulerAngles

				var_148_15.z = 0
				var_148_15.x = 0
				var_148_6.localEulerAngles = var_148_15

				local var_148_16 = GameObjectTools.GetOrAddComponent(var_148_6.gameObject, typeof(DynamicBoneHelper))

				if var_148_16 then
					var_148_16:EnableDynamicBone(true)
				end
			end

			local var_148_17 = 0
			local var_148_18 = 1.725

			if var_148_17 < arg_145_1.time_ and arg_145_1.time_ <= var_148_17 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, false)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_19 = arg_145_1:GetWordFromCfg(323121036)
				local var_148_20 = arg_145_1:FormatText(var_148_19.content)

				arg_145_1.text_.text = var_148_20

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_21 = 69
				local var_148_22 = utf8.len(var_148_20)
				local var_148_23 = var_148_21 <= 0 and var_148_18 or var_148_18 * (var_148_22 / var_148_21)

				if var_148_23 > 0 and var_148_18 < var_148_23 then
					arg_145_1.talkMaxDuration = var_148_23

					if var_148_23 + var_148_17 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_23 + var_148_17
					end
				end

				arg_145_1.text_.text = var_148_20
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)
				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_24 = math.max(var_148_18, arg_145_1.talkMaxDuration)

			if var_148_17 <= arg_145_1.time_ and arg_145_1.time_ < var_148_17 + var_148_24 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_17) / var_148_24

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_17 + var_148_24 and arg_145_1.time_ < var_148_17 + var_148_24 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_145_1:InitPlayNodeList()
	end,
	Play323121037 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 323121037
		arg_149_1.duration_ = 5

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play323121038(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = 0
			local var_152_1 = 0.875

			if var_152_0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_0 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, false)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_2 = arg_149_1:GetWordFromCfg(323121037)
				local var_152_3 = arg_149_1:FormatText(var_152_2.content)

				arg_149_1.text_.text = var_152_3

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_4 = 35
				local var_152_5 = utf8.len(var_152_3)
				local var_152_6 = var_152_4 <= 0 and var_152_1 or var_152_1 * (var_152_5 / var_152_4)

				if var_152_6 > 0 and var_152_1 < var_152_6 then
					arg_149_1.talkMaxDuration = var_152_6

					if var_152_6 + var_152_0 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_6 + var_152_0
					end
				end

				arg_149_1.text_.text = var_152_3
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)
				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_7 = math.max(var_152_1, arg_149_1.talkMaxDuration)

			if var_152_0 <= arg_149_1.time_ and arg_149_1.time_ < var_152_0 + var_152_7 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_0) / var_152_7

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_0 + var_152_7 and arg_149_1.time_ < var_152_0 + var_152_7 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play323121038 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 323121038
		arg_153_1.duration_ = 8.43

		local var_153_0 = {
			zh = 5.333,
			ja = 8.433
		}
		local var_153_1 = manager.audio:GetLocalizationFlag()

		if var_153_0[var_153_1] ~= nil then
			arg_153_1.duration_ = var_153_0[var_153_1]
		end

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play323121039(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = arg_153_1.actors_["10170ui_story"]
			local var_156_1 = 0

			if var_156_1 < arg_153_1.time_ and arg_153_1.time_ <= var_156_1 + arg_156_0 and not isNil(var_156_0) and arg_153_1.var_.characterEffect10170ui_story == nil then
				arg_153_1.var_.characterEffect10170ui_story = var_156_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_2 = 0.200000002980232

			if var_156_1 <= arg_153_1.time_ and arg_153_1.time_ < var_156_1 + var_156_2 and not isNil(var_156_0) then
				local var_156_3 = (arg_153_1.time_ - var_156_1) / var_156_2

				if arg_153_1.var_.characterEffect10170ui_story and not isNil(var_156_0) then
					arg_153_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_153_1.time_ >= var_156_1 + var_156_2 and arg_153_1.time_ < var_156_1 + var_156_2 + arg_156_0 and not isNil(var_156_0) and arg_153_1.var_.characterEffect10170ui_story then
				arg_153_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_156_4 = 0

			if var_156_4 < arg_153_1.time_ and arg_153_1.time_ <= var_156_4 + arg_156_0 then
				arg_153_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/story10170/story10170action/10170action31_2")
			end

			local var_156_5 = arg_153_1.actors_["10170ui_story"].transform
			local var_156_6 = 0

			if var_156_6 < arg_153_1.time_ and arg_153_1.time_ <= var_156_6 + arg_156_0 then
				arg_153_1.var_.moveOldPos10170ui_story = var_156_5.localPosition

				local var_156_7 = GameObjectTools.GetOrAddComponent(var_156_5.gameObject, typeof(DynamicBoneHelper))

				if var_156_7 then
					var_156_7:EnableDynamicBone(false)
				end
			end

			local var_156_8 = 0.001

			if var_156_6 <= arg_153_1.time_ and arg_153_1.time_ < var_156_6 + var_156_8 then
				local var_156_9 = (arg_153_1.time_ - var_156_6) / var_156_8
				local var_156_10 = Vector3.New(0, -1.03, -6.05)

				var_156_5.localPosition = Vector3.Lerp(arg_153_1.var_.moveOldPos10170ui_story, var_156_10, var_156_9)

				local var_156_11 = manager.ui.mainCamera.transform.position - var_156_5.position

				var_156_5.forward = Vector3.New(var_156_11.x, var_156_11.y, var_156_11.z)

				local var_156_12 = var_156_5.localEulerAngles

				var_156_12.z = 0
				var_156_12.x = 0
				var_156_5.localEulerAngles = var_156_12
			end

			if arg_153_1.time_ >= var_156_6 + var_156_8 and arg_153_1.time_ < var_156_6 + var_156_8 + arg_156_0 then
				var_156_5.localPosition = Vector3.New(0, -1.03, -6.05)

				local var_156_13 = manager.ui.mainCamera.transform.position - var_156_5.position

				var_156_5.forward = Vector3.New(var_156_13.x, var_156_13.y, var_156_13.z)

				local var_156_14 = var_156_5.localEulerAngles

				var_156_14.z = 0
				var_156_14.x = 0
				var_156_5.localEulerAngles = var_156_14

				local var_156_15 = GameObjectTools.GetOrAddComponent(var_156_5.gameObject, typeof(DynamicBoneHelper))

				if var_156_15 then
					var_156_15:EnableDynamicBone(true)
				end
			end

			local var_156_16 = 0
			local var_156_17 = 0.625

			if var_156_16 < arg_153_1.time_ and arg_153_1.time_ <= var_156_16 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				local var_156_18 = arg_153_1:FormatText(StoryNameCfg[1450].name)

				arg_153_1.leftNameTxt_.text = var_156_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_19 = arg_153_1:GetWordFromCfg(323121038)
				local var_156_20 = arg_153_1:FormatText(var_156_19.content)

				arg_153_1.text_.text = var_156_20

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_21 = 25
				local var_156_22 = utf8.len(var_156_20)
				local var_156_23 = var_156_21 <= 0 and var_156_17 or var_156_17 * (var_156_22 / var_156_21)

				if var_156_23 > 0 and var_156_17 < var_156_23 then
					arg_153_1.talkMaxDuration = var_156_23

					if var_156_23 + var_156_16 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_23 + var_156_16
					end
				end

				arg_153_1.text_.text = var_156_20
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323121", "323121038", "story_v_out_323121.awb") ~= 0 then
					local var_156_24 = manager.audio:GetVoiceLength("story_v_out_323121", "323121038", "story_v_out_323121.awb") / 1000

					if var_156_24 + var_156_16 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_24 + var_156_16
					end

					if var_156_19.prefab_name ~= "" and arg_153_1.actors_[var_156_19.prefab_name] ~= nil then
						local var_156_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_19.prefab_name].transform, "story_v_out_323121", "323121038", "story_v_out_323121.awb")

						arg_153_1:RecordAudio("323121038", var_156_25)
						arg_153_1:RecordAudio("323121038", var_156_25)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_323121", "323121038", "story_v_out_323121.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_323121", "323121038", "story_v_out_323121.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_26 = math.max(var_156_17, arg_153_1.talkMaxDuration)

			if var_156_16 <= arg_153_1.time_ and arg_153_1.time_ < var_156_16 + var_156_26 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_16) / var_156_26

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_16 + var_156_26 and arg_153_1.time_ < var_156_16 + var_156_26 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_153_1:InitPlayNodeList()
	end,
	Play323121039 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 323121039
		arg_157_1.duration_ = 5

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play323121040(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = arg_157_1.actors_["10170ui_story"]
			local var_160_1 = 0

			if var_160_1 < arg_157_1.time_ and arg_157_1.time_ <= var_160_1 + arg_160_0 and not isNil(var_160_0) and arg_157_1.var_.characterEffect10170ui_story == nil then
				arg_157_1.var_.characterEffect10170ui_story = var_160_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_2 = 0.200000002980232

			if var_160_1 <= arg_157_1.time_ and arg_157_1.time_ < var_160_1 + var_160_2 and not isNil(var_160_0) then
				local var_160_3 = (arg_157_1.time_ - var_160_1) / var_160_2

				if arg_157_1.var_.characterEffect10170ui_story and not isNil(var_160_0) then
					local var_160_4 = Mathf.Lerp(0, 0.5, var_160_3)

					arg_157_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_157_1.var_.characterEffect10170ui_story.fillRatio = var_160_4
				end
			end

			if arg_157_1.time_ >= var_160_1 + var_160_2 and arg_157_1.time_ < var_160_1 + var_160_2 + arg_160_0 and not isNil(var_160_0) and arg_157_1.var_.characterEffect10170ui_story then
				local var_160_5 = 0.5

				arg_157_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_157_1.var_.characterEffect10170ui_story.fillRatio = var_160_5
			end

			local var_160_6 = 0
			local var_160_7 = 0.05

			if var_160_6 < arg_157_1.time_ and arg_157_1.time_ <= var_160_6 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				local var_160_8 = arg_157_1:FormatText(StoryNameCfg[7].name)

				arg_157_1.leftNameTxt_.text = var_160_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, true)
				arg_157_1.iconController_:SetSelectedState("hero")

				arg_157_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_157_1.callingController_:SetSelectedState("normal")

				arg_157_1.keyicon_.color = Color.New(1, 1, 1)
				arg_157_1.icon_.color = Color.New(1, 1, 1)

				local var_160_9 = arg_157_1:GetWordFromCfg(323121039)
				local var_160_10 = arg_157_1:FormatText(var_160_9.content)

				arg_157_1.text_.text = var_160_10

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_11 = 2
				local var_160_12 = utf8.len(var_160_10)
				local var_160_13 = var_160_11 <= 0 and var_160_7 or var_160_7 * (var_160_12 / var_160_11)

				if var_160_13 > 0 and var_160_7 < var_160_13 then
					arg_157_1.talkMaxDuration = var_160_13

					if var_160_13 + var_160_6 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_13 + var_160_6
					end
				end

				arg_157_1.text_.text = var_160_10
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)
				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_14 = math.max(var_160_7, arg_157_1.talkMaxDuration)

			if var_160_6 <= arg_157_1.time_ and arg_157_1.time_ < var_160_6 + var_160_14 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_6) / var_160_14

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_6 + var_160_14 and arg_157_1.time_ < var_160_6 + var_160_14 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play323121040 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 323121040
		arg_161_1.duration_ = 8.87

		local var_161_0 = {
			zh = 3.933,
			ja = 8.866
		}
		local var_161_1 = manager.audio:GetLocalizationFlag()

		if var_161_0[var_161_1] ~= nil then
			arg_161_1.duration_ = var_161_0[var_161_1]
		end

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play323121041(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = arg_161_1.actors_["1053ui_story"].transform
			local var_164_1 = 0

			if var_164_1 < arg_161_1.time_ and arg_161_1.time_ <= var_164_1 + arg_164_0 then
				arg_161_1.var_.moveOldPos1053ui_story = var_164_0.localPosition

				local var_164_2 = GameObjectTools.GetOrAddComponent(var_164_0.gameObject, typeof(DynamicBoneHelper))

				if var_164_2 then
					var_164_2:EnableDynamicBone(false)
				end
			end

			local var_164_3 = 0.001

			if var_164_1 <= arg_161_1.time_ and arg_161_1.time_ < var_164_1 + var_164_3 then
				local var_164_4 = (arg_161_1.time_ - var_164_1) / var_164_3
				local var_164_5 = Vector3.New(0.7, -1.08, -6)

				var_164_0.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos1053ui_story, var_164_5, var_164_4)

				local var_164_6 = manager.ui.mainCamera.transform.position - var_164_0.position

				var_164_0.forward = Vector3.New(var_164_6.x, var_164_6.y, var_164_6.z)

				local var_164_7 = var_164_0.localEulerAngles

				var_164_7.z = 0
				var_164_7.x = 0
				var_164_0.localEulerAngles = var_164_7
			end

			if arg_161_1.time_ >= var_164_1 + var_164_3 and arg_161_1.time_ < var_164_1 + var_164_3 + arg_164_0 then
				var_164_0.localPosition = Vector3.New(0.7, -1.08, -6)

				local var_164_8 = manager.ui.mainCamera.transform.position - var_164_0.position

				var_164_0.forward = Vector3.New(var_164_8.x, var_164_8.y, var_164_8.z)

				local var_164_9 = var_164_0.localEulerAngles

				var_164_9.z = 0
				var_164_9.x = 0
				var_164_0.localEulerAngles = var_164_9

				local var_164_10 = GameObjectTools.GetOrAddComponent(var_164_0.gameObject, typeof(DynamicBoneHelper))

				if var_164_10 then
					var_164_10:EnableDynamicBone(true)
				end
			end

			local var_164_11 = arg_161_1.actors_["10170ui_story"].transform
			local var_164_12 = 0

			if var_164_12 < arg_161_1.time_ and arg_161_1.time_ <= var_164_12 + arg_164_0 then
				arg_161_1.var_.moveOldPos10170ui_story = var_164_11.localPosition

				local var_164_13 = GameObjectTools.GetOrAddComponent(var_164_11.gameObject, typeof(DynamicBoneHelper))

				if var_164_13 then
					var_164_13:EnableDynamicBone(false)
				end
			end

			local var_164_14 = 0.001

			if var_164_12 <= arg_161_1.time_ and arg_161_1.time_ < var_164_12 + var_164_14 then
				local var_164_15 = (arg_161_1.time_ - var_164_12) / var_164_14
				local var_164_16 = Vector3.New(-0.7, -1.03, -6.05)

				var_164_11.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos10170ui_story, var_164_16, var_164_15)

				local var_164_17 = manager.ui.mainCamera.transform.position - var_164_11.position

				var_164_11.forward = Vector3.New(var_164_17.x, var_164_17.y, var_164_17.z)

				local var_164_18 = var_164_11.localEulerAngles

				var_164_18.z = 0
				var_164_18.x = 0
				var_164_11.localEulerAngles = var_164_18
			end

			if arg_161_1.time_ >= var_164_12 + var_164_14 and arg_161_1.time_ < var_164_12 + var_164_14 + arg_164_0 then
				var_164_11.localPosition = Vector3.New(-0.7, -1.03, -6.05)

				local var_164_19 = manager.ui.mainCamera.transform.position - var_164_11.position

				var_164_11.forward = Vector3.New(var_164_19.x, var_164_19.y, var_164_19.z)

				local var_164_20 = var_164_11.localEulerAngles

				var_164_20.z = 0
				var_164_20.x = 0
				var_164_11.localEulerAngles = var_164_20

				local var_164_21 = GameObjectTools.GetOrAddComponent(var_164_11.gameObject, typeof(DynamicBoneHelper))

				if var_164_21 then
					var_164_21:EnableDynamicBone(true)
				end
			end

			local var_164_22 = arg_161_1.actors_["1053ui_story"]
			local var_164_23 = 0

			if var_164_23 < arg_161_1.time_ and arg_161_1.time_ <= var_164_23 + arg_164_0 and not isNil(var_164_22) and arg_161_1.var_.characterEffect1053ui_story == nil then
				arg_161_1.var_.characterEffect1053ui_story = var_164_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_24 = 0.200000002980232

			if var_164_23 <= arg_161_1.time_ and arg_161_1.time_ < var_164_23 + var_164_24 and not isNil(var_164_22) then
				local var_164_25 = (arg_161_1.time_ - var_164_23) / var_164_24

				if arg_161_1.var_.characterEffect1053ui_story and not isNil(var_164_22) then
					arg_161_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_161_1.time_ >= var_164_23 + var_164_24 and arg_161_1.time_ < var_164_23 + var_164_24 + arg_164_0 and not isNil(var_164_22) and arg_161_1.var_.characterEffect1053ui_story then
				arg_161_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_164_26 = 0

			if var_164_26 < arg_161_1.time_ and arg_161_1.time_ <= var_164_26 + arg_164_0 then
				arg_161_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053action/1053action3_1")
			end

			local var_164_27 = 0

			if var_164_27 < arg_161_1.time_ and arg_161_1.time_ <= var_164_27 + arg_164_0 then
				arg_161_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_164_28 = 0
			local var_164_29 = 0.425

			if var_164_28 < arg_161_1.time_ and arg_161_1.time_ <= var_164_28 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				local var_164_30 = arg_161_1:FormatText(StoryNameCfg[1453].name)

				arg_161_1.leftNameTxt_.text = var_164_30

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_31 = arg_161_1:GetWordFromCfg(323121040)
				local var_164_32 = arg_161_1:FormatText(var_164_31.content)

				arg_161_1.text_.text = var_164_32

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_33 = 17
				local var_164_34 = utf8.len(var_164_32)
				local var_164_35 = var_164_33 <= 0 and var_164_29 or var_164_29 * (var_164_34 / var_164_33)

				if var_164_35 > 0 and var_164_29 < var_164_35 then
					arg_161_1.talkMaxDuration = var_164_35

					if var_164_35 + var_164_28 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_35 + var_164_28
					end
				end

				arg_161_1.text_.text = var_164_32
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323121", "323121040", "story_v_out_323121.awb") ~= 0 then
					local var_164_36 = manager.audio:GetVoiceLength("story_v_out_323121", "323121040", "story_v_out_323121.awb") / 1000

					if var_164_36 + var_164_28 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_36 + var_164_28
					end

					if var_164_31.prefab_name ~= "" and arg_161_1.actors_[var_164_31.prefab_name] ~= nil then
						local var_164_37 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_31.prefab_name].transform, "story_v_out_323121", "323121040", "story_v_out_323121.awb")

						arg_161_1:RecordAudio("323121040", var_164_37)
						arg_161_1:RecordAudio("323121040", var_164_37)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_323121", "323121040", "story_v_out_323121.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_323121", "323121040", "story_v_out_323121.awb")
				end

				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_38 = math.max(var_164_29, arg_161_1.talkMaxDuration)

			if var_164_28 <= arg_161_1.time_ and arg_161_1.time_ < var_164_28 + var_164_38 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_28) / var_164_38

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_28 + var_164_38 and arg_161_1.time_ < var_164_28 + var_164_38 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_161_1:InitPlayNodeList()
	end,
	Play323121041 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 323121041
		arg_165_1.duration_ = 9.63

		local var_165_0 = {
			zh = 7.866,
			ja = 9.633
		}
		local var_165_1 = manager.audio:GetLocalizationFlag()

		if var_165_0[var_165_1] ~= nil then
			arg_165_1.duration_ = var_165_0[var_165_1]
		end

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play323121042(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = arg_165_1.actors_["10170ui_story"]
			local var_168_1 = 0

			if var_168_1 < arg_165_1.time_ and arg_165_1.time_ <= var_168_1 + arg_168_0 and not isNil(var_168_0) and arg_165_1.var_.characterEffect10170ui_story == nil then
				arg_165_1.var_.characterEffect10170ui_story = var_168_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_2 = 0.200000002980232

			if var_168_1 <= arg_165_1.time_ and arg_165_1.time_ < var_168_1 + var_168_2 and not isNil(var_168_0) then
				local var_168_3 = (arg_165_1.time_ - var_168_1) / var_168_2

				if arg_165_1.var_.characterEffect10170ui_story and not isNil(var_168_0) then
					arg_165_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_165_1.time_ >= var_168_1 + var_168_2 and arg_165_1.time_ < var_168_1 + var_168_2 + arg_168_0 and not isNil(var_168_0) and arg_165_1.var_.characterEffect10170ui_story then
				arg_165_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_168_4 = arg_165_1.actors_["1053ui_story"]
			local var_168_5 = 0

			if var_168_5 < arg_165_1.time_ and arg_165_1.time_ <= var_168_5 + arg_168_0 and not isNil(var_168_4) and arg_165_1.var_.characterEffect1053ui_story == nil then
				arg_165_1.var_.characterEffect1053ui_story = var_168_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_6 = 0.200000002980232

			if var_168_5 <= arg_165_1.time_ and arg_165_1.time_ < var_168_5 + var_168_6 and not isNil(var_168_4) then
				local var_168_7 = (arg_165_1.time_ - var_168_5) / var_168_6

				if arg_165_1.var_.characterEffect1053ui_story and not isNil(var_168_4) then
					local var_168_8 = Mathf.Lerp(0, 0.5, var_168_7)

					arg_165_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_165_1.var_.characterEffect1053ui_story.fillRatio = var_168_8
				end
			end

			if arg_165_1.time_ >= var_168_5 + var_168_6 and arg_165_1.time_ < var_168_5 + var_168_6 + arg_168_0 and not isNil(var_168_4) and arg_165_1.var_.characterEffect1053ui_story then
				local var_168_9 = 0.5

				arg_165_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_165_1.var_.characterEffect1053ui_story.fillRatio = var_168_9
			end

			local var_168_10 = 0

			if var_168_10 < arg_165_1.time_ and arg_165_1.time_ <= var_168_10 + arg_168_0 then
				arg_165_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_168_11 = 0

			if var_168_11 < arg_165_1.time_ and arg_165_1.time_ <= var_168_11 + arg_168_0 then
				arg_165_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/story10170/story10170action/10170action2_1")
			end

			local var_168_12 = 0
			local var_168_13 = 0.8

			if var_168_12 < arg_165_1.time_ and arg_165_1.time_ <= var_168_12 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				local var_168_14 = arg_165_1:FormatText(StoryNameCfg[1450].name)

				arg_165_1.leftNameTxt_.text = var_168_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_15 = arg_165_1:GetWordFromCfg(323121041)
				local var_168_16 = arg_165_1:FormatText(var_168_15.content)

				arg_165_1.text_.text = var_168_16

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_17 = 32
				local var_168_18 = utf8.len(var_168_16)
				local var_168_19 = var_168_17 <= 0 and var_168_13 or var_168_13 * (var_168_18 / var_168_17)

				if var_168_19 > 0 and var_168_13 < var_168_19 then
					arg_165_1.talkMaxDuration = var_168_19

					if var_168_19 + var_168_12 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_19 + var_168_12
					end
				end

				arg_165_1.text_.text = var_168_16
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323121", "323121041", "story_v_out_323121.awb") ~= 0 then
					local var_168_20 = manager.audio:GetVoiceLength("story_v_out_323121", "323121041", "story_v_out_323121.awb") / 1000

					if var_168_20 + var_168_12 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_20 + var_168_12
					end

					if var_168_15.prefab_name ~= "" and arg_165_1.actors_[var_168_15.prefab_name] ~= nil then
						local var_168_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_15.prefab_name].transform, "story_v_out_323121", "323121041", "story_v_out_323121.awb")

						arg_165_1:RecordAudio("323121041", var_168_21)
						arg_165_1:RecordAudio("323121041", var_168_21)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_323121", "323121041", "story_v_out_323121.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_323121", "323121041", "story_v_out_323121.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_22 = math.max(var_168_13, arg_165_1.talkMaxDuration)

			if var_168_12 <= arg_165_1.time_ and arg_165_1.time_ < var_168_12 + var_168_22 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_12) / var_168_22

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_12 + var_168_22 and arg_165_1.time_ < var_168_12 + var_168_22 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play323121042 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 323121042
		arg_169_1.duration_ = 5

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play323121043(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = arg_169_1.actors_["10170ui_story"]
			local var_172_1 = 0

			if var_172_1 < arg_169_1.time_ and arg_169_1.time_ <= var_172_1 + arg_172_0 and not isNil(var_172_0) and arg_169_1.var_.characterEffect10170ui_story == nil then
				arg_169_1.var_.characterEffect10170ui_story = var_172_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_2 = 0.200000002980232

			if var_172_1 <= arg_169_1.time_ and arg_169_1.time_ < var_172_1 + var_172_2 and not isNil(var_172_0) then
				local var_172_3 = (arg_169_1.time_ - var_172_1) / var_172_2

				if arg_169_1.var_.characterEffect10170ui_story and not isNil(var_172_0) then
					local var_172_4 = Mathf.Lerp(0, 0.5, var_172_3)

					arg_169_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_169_1.var_.characterEffect10170ui_story.fillRatio = var_172_4
				end
			end

			if arg_169_1.time_ >= var_172_1 + var_172_2 and arg_169_1.time_ < var_172_1 + var_172_2 + arg_172_0 and not isNil(var_172_0) and arg_169_1.var_.characterEffect10170ui_story then
				local var_172_5 = 0.5

				arg_169_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_169_1.var_.characterEffect10170ui_story.fillRatio = var_172_5
			end

			local var_172_6 = 0
			local var_172_7 = 1.025

			if var_172_6 < arg_169_1.time_ and arg_169_1.time_ <= var_172_6 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, false)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_8 = arg_169_1:GetWordFromCfg(323121042)
				local var_172_9 = arg_169_1:FormatText(var_172_8.content)

				arg_169_1.text_.text = var_172_9

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_10 = 41
				local var_172_11 = utf8.len(var_172_9)
				local var_172_12 = var_172_10 <= 0 and var_172_7 or var_172_7 * (var_172_11 / var_172_10)

				if var_172_12 > 0 and var_172_7 < var_172_12 then
					arg_169_1.talkMaxDuration = var_172_12

					if var_172_12 + var_172_6 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_12 + var_172_6
					end
				end

				arg_169_1.text_.text = var_172_9
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)
				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_13 = math.max(var_172_7, arg_169_1.talkMaxDuration)

			if var_172_6 <= arg_169_1.time_ and arg_169_1.time_ < var_172_6 + var_172_13 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_6) / var_172_13

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_6 + var_172_13 and arg_169_1.time_ < var_172_6 + var_172_13 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play323121043 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 323121043
		arg_173_1.duration_ = 5

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play323121044(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = 0
			local var_176_1 = 1.8

			if var_176_0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_0 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, false)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_2 = arg_173_1:GetWordFromCfg(323121043)
				local var_176_3 = arg_173_1:FormatText(var_176_2.content)

				arg_173_1.text_.text = var_176_3

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_4 = 72
				local var_176_5 = utf8.len(var_176_3)
				local var_176_6 = var_176_4 <= 0 and var_176_1 or var_176_1 * (var_176_5 / var_176_4)

				if var_176_6 > 0 and var_176_1 < var_176_6 then
					arg_173_1.talkMaxDuration = var_176_6

					if var_176_6 + var_176_0 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_6 + var_176_0
					end
				end

				arg_173_1.text_.text = var_176_3
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)
				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_7 = math.max(var_176_1, arg_173_1.talkMaxDuration)

			if var_176_0 <= arg_173_1.time_ and arg_173_1.time_ < var_176_0 + var_176_7 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_0) / var_176_7

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_0 + var_176_7 and arg_173_1.time_ < var_176_0 + var_176_7 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play323121044 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 323121044
		arg_177_1.duration_ = 9.53

		local var_177_0 = {
			zh = 7.5,
			ja = 9.533
		}
		local var_177_1 = manager.audio:GetLocalizationFlag()

		if var_177_0[var_177_1] ~= nil then
			arg_177_1.duration_ = var_177_0[var_177_1]
		end

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play323121045(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = arg_177_1.actors_["1053ui_story"]
			local var_180_1 = 0

			if var_180_1 < arg_177_1.time_ and arg_177_1.time_ <= var_180_1 + arg_180_0 and not isNil(var_180_0) and arg_177_1.var_.characterEffect1053ui_story == nil then
				arg_177_1.var_.characterEffect1053ui_story = var_180_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_2 = 0.200000002980232

			if var_180_1 <= arg_177_1.time_ and arg_177_1.time_ < var_180_1 + var_180_2 and not isNil(var_180_0) then
				local var_180_3 = (arg_177_1.time_ - var_180_1) / var_180_2

				if arg_177_1.var_.characterEffect1053ui_story and not isNil(var_180_0) then
					arg_177_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_177_1.time_ >= var_180_1 + var_180_2 and arg_177_1.time_ < var_180_1 + var_180_2 + arg_180_0 and not isNil(var_180_0) and arg_177_1.var_.characterEffect1053ui_story then
				arg_177_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_180_4 = 0

			if var_180_4 < arg_177_1.time_ and arg_177_1.time_ <= var_180_4 + arg_180_0 then
				arg_177_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053actionlink/1053action434")
			end

			local var_180_5 = 0

			if var_180_5 < arg_177_1.time_ and arg_177_1.time_ <= var_180_5 + arg_180_0 then
				arg_177_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_180_6 = 0
			local var_180_7 = 1.05

			if var_180_6 < arg_177_1.time_ and arg_177_1.time_ <= var_180_6 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				local var_180_8 = arg_177_1:FormatText(StoryNameCfg[1453].name)

				arg_177_1.leftNameTxt_.text = var_180_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_9 = arg_177_1:GetWordFromCfg(323121044)
				local var_180_10 = arg_177_1:FormatText(var_180_9.content)

				arg_177_1.text_.text = var_180_10

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_11 = 42
				local var_180_12 = utf8.len(var_180_10)
				local var_180_13 = var_180_11 <= 0 and var_180_7 or var_180_7 * (var_180_12 / var_180_11)

				if var_180_13 > 0 and var_180_7 < var_180_13 then
					arg_177_1.talkMaxDuration = var_180_13

					if var_180_13 + var_180_6 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_13 + var_180_6
					end
				end

				arg_177_1.text_.text = var_180_10
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323121", "323121044", "story_v_out_323121.awb") ~= 0 then
					local var_180_14 = manager.audio:GetVoiceLength("story_v_out_323121", "323121044", "story_v_out_323121.awb") / 1000

					if var_180_14 + var_180_6 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_14 + var_180_6
					end

					if var_180_9.prefab_name ~= "" and arg_177_1.actors_[var_180_9.prefab_name] ~= nil then
						local var_180_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_9.prefab_name].transform, "story_v_out_323121", "323121044", "story_v_out_323121.awb")

						arg_177_1:RecordAudio("323121044", var_180_15)
						arg_177_1:RecordAudio("323121044", var_180_15)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_323121", "323121044", "story_v_out_323121.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_323121", "323121044", "story_v_out_323121.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_16 = math.max(var_180_7, arg_177_1.talkMaxDuration)

			if var_180_6 <= arg_177_1.time_ and arg_177_1.time_ < var_180_6 + var_180_16 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_6) / var_180_16

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_6 + var_180_16 and arg_177_1.time_ < var_180_6 + var_180_16 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {}

		arg_177_1:InitPlayNodeList()
	end,
	Play323121045 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 323121045
		arg_181_1.duration_ = 3.03

		local var_181_0 = {
			zh = 2.433,
			ja = 3.033
		}
		local var_181_1 = manager.audio:GetLocalizationFlag()

		if var_181_0[var_181_1] ~= nil then
			arg_181_1.duration_ = var_181_0[var_181_1]
		end

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play323121046(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = arg_181_1.actors_["10170ui_story"]
			local var_184_1 = 0

			if var_184_1 < arg_181_1.time_ and arg_181_1.time_ <= var_184_1 + arg_184_0 and not isNil(var_184_0) and arg_181_1.var_.characterEffect10170ui_story == nil then
				arg_181_1.var_.characterEffect10170ui_story = var_184_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_2 = 0.200000002980232

			if var_184_1 <= arg_181_1.time_ and arg_181_1.time_ < var_184_1 + var_184_2 and not isNil(var_184_0) then
				local var_184_3 = (arg_181_1.time_ - var_184_1) / var_184_2

				if arg_181_1.var_.characterEffect10170ui_story and not isNil(var_184_0) then
					arg_181_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_181_1.time_ >= var_184_1 + var_184_2 and arg_181_1.time_ < var_184_1 + var_184_2 + arg_184_0 and not isNil(var_184_0) and arg_181_1.var_.characterEffect10170ui_story then
				arg_181_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_184_4 = arg_181_1.actors_["1053ui_story"]
			local var_184_5 = 0

			if var_184_5 < arg_181_1.time_ and arg_181_1.time_ <= var_184_5 + arg_184_0 and not isNil(var_184_4) and arg_181_1.var_.characterEffect1053ui_story == nil then
				arg_181_1.var_.characterEffect1053ui_story = var_184_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_6 = 0.200000002980232

			if var_184_5 <= arg_181_1.time_ and arg_181_1.time_ < var_184_5 + var_184_6 and not isNil(var_184_4) then
				local var_184_7 = (arg_181_1.time_ - var_184_5) / var_184_6

				if arg_181_1.var_.characterEffect1053ui_story and not isNil(var_184_4) then
					local var_184_8 = Mathf.Lerp(0, 0.5, var_184_7)

					arg_181_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_181_1.var_.characterEffect1053ui_story.fillRatio = var_184_8
				end
			end

			if arg_181_1.time_ >= var_184_5 + var_184_6 and arg_181_1.time_ < var_184_5 + var_184_6 + arg_184_0 and not isNil(var_184_4) and arg_181_1.var_.characterEffect1053ui_story then
				local var_184_9 = 0.5

				arg_181_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_181_1.var_.characterEffect1053ui_story.fillRatio = var_184_9
			end

			local var_184_10 = 0
			local var_184_11 = 0.225

			if var_184_10 < arg_181_1.time_ and arg_181_1.time_ <= var_184_10 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				local var_184_12 = arg_181_1:FormatText(StoryNameCfg[1450].name)

				arg_181_1.leftNameTxt_.text = var_184_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_13 = arg_181_1:GetWordFromCfg(323121045)
				local var_184_14 = arg_181_1:FormatText(var_184_13.content)

				arg_181_1.text_.text = var_184_14

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_15 = 9
				local var_184_16 = utf8.len(var_184_14)
				local var_184_17 = var_184_15 <= 0 and var_184_11 or var_184_11 * (var_184_16 / var_184_15)

				if var_184_17 > 0 and var_184_11 < var_184_17 then
					arg_181_1.talkMaxDuration = var_184_17

					if var_184_17 + var_184_10 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_17 + var_184_10
					end
				end

				arg_181_1.text_.text = var_184_14
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323121", "323121045", "story_v_out_323121.awb") ~= 0 then
					local var_184_18 = manager.audio:GetVoiceLength("story_v_out_323121", "323121045", "story_v_out_323121.awb") / 1000

					if var_184_18 + var_184_10 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_18 + var_184_10
					end

					if var_184_13.prefab_name ~= "" and arg_181_1.actors_[var_184_13.prefab_name] ~= nil then
						local var_184_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_13.prefab_name].transform, "story_v_out_323121", "323121045", "story_v_out_323121.awb")

						arg_181_1:RecordAudio("323121045", var_184_19)
						arg_181_1:RecordAudio("323121045", var_184_19)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_323121", "323121045", "story_v_out_323121.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_323121", "323121045", "story_v_out_323121.awb")
				end

				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_20 = math.max(var_184_11, arg_181_1.talkMaxDuration)

			if var_184_10 <= arg_181_1.time_ and arg_181_1.time_ < var_184_10 + var_184_20 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_10) / var_184_20

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_10 + var_184_20 and arg_181_1.time_ < var_184_10 + var_184_20 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play323121046 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 323121046
		arg_185_1.duration_ = 8.2

		local var_185_0 = {
			zh = 5.133,
			ja = 8.2
		}
		local var_185_1 = manager.audio:GetLocalizationFlag()

		if var_185_0[var_185_1] ~= nil then
			arg_185_1.duration_ = var_185_0[var_185_1]
		end

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play323121047(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = arg_185_1.actors_["1053ui_story"]
			local var_188_1 = 0

			if var_188_1 < arg_185_1.time_ and arg_185_1.time_ <= var_188_1 + arg_188_0 and not isNil(var_188_0) and arg_185_1.var_.characterEffect1053ui_story == nil then
				arg_185_1.var_.characterEffect1053ui_story = var_188_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_188_2 = 0.200000002980232

			if var_188_1 <= arg_185_1.time_ and arg_185_1.time_ < var_188_1 + var_188_2 and not isNil(var_188_0) then
				local var_188_3 = (arg_185_1.time_ - var_188_1) / var_188_2

				if arg_185_1.var_.characterEffect1053ui_story and not isNil(var_188_0) then
					arg_185_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_185_1.time_ >= var_188_1 + var_188_2 and arg_185_1.time_ < var_188_1 + var_188_2 + arg_188_0 and not isNil(var_188_0) and arg_185_1.var_.characterEffect1053ui_story then
				arg_185_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_188_4 = arg_185_1.actors_["10170ui_story"]
			local var_188_5 = 0

			if var_188_5 < arg_185_1.time_ and arg_185_1.time_ <= var_188_5 + arg_188_0 and not isNil(var_188_4) and arg_185_1.var_.characterEffect10170ui_story == nil then
				arg_185_1.var_.characterEffect10170ui_story = var_188_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_188_6 = 0.200000002980232

			if var_188_5 <= arg_185_1.time_ and arg_185_1.time_ < var_188_5 + var_188_6 and not isNil(var_188_4) then
				local var_188_7 = (arg_185_1.time_ - var_188_5) / var_188_6

				if arg_185_1.var_.characterEffect10170ui_story and not isNil(var_188_4) then
					local var_188_8 = Mathf.Lerp(0, 0.5, var_188_7)

					arg_185_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_185_1.var_.characterEffect10170ui_story.fillRatio = var_188_8
				end
			end

			if arg_185_1.time_ >= var_188_5 + var_188_6 and arg_185_1.time_ < var_188_5 + var_188_6 + arg_188_0 and not isNil(var_188_4) and arg_185_1.var_.characterEffect10170ui_story then
				local var_188_9 = 0.5

				arg_185_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_185_1.var_.characterEffect10170ui_story.fillRatio = var_188_9
			end

			local var_188_10 = 0

			if var_188_10 < arg_185_1.time_ and arg_185_1.time_ <= var_188_10 + arg_188_0 then
				arg_185_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053action/1053action4_2")
			end

			local var_188_11 = 0

			if var_188_11 < arg_185_1.time_ and arg_185_1.time_ <= var_188_11 + arg_188_0 then
				arg_185_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_188_12 = 0
			local var_188_13 = 0.55

			if var_188_12 < arg_185_1.time_ and arg_185_1.time_ <= var_188_12 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				local var_188_14 = arg_185_1:FormatText(StoryNameCfg[1453].name)

				arg_185_1.leftNameTxt_.text = var_188_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_15 = arg_185_1:GetWordFromCfg(323121046)
				local var_188_16 = arg_185_1:FormatText(var_188_15.content)

				arg_185_1.text_.text = var_188_16

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_17 = 22
				local var_188_18 = utf8.len(var_188_16)
				local var_188_19 = var_188_17 <= 0 and var_188_13 or var_188_13 * (var_188_18 / var_188_17)

				if var_188_19 > 0 and var_188_13 < var_188_19 then
					arg_185_1.talkMaxDuration = var_188_19

					if var_188_19 + var_188_12 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_19 + var_188_12
					end
				end

				arg_185_1.text_.text = var_188_16
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323121", "323121046", "story_v_out_323121.awb") ~= 0 then
					local var_188_20 = manager.audio:GetVoiceLength("story_v_out_323121", "323121046", "story_v_out_323121.awb") / 1000

					if var_188_20 + var_188_12 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_20 + var_188_12
					end

					if var_188_15.prefab_name ~= "" and arg_185_1.actors_[var_188_15.prefab_name] ~= nil then
						local var_188_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_15.prefab_name].transform, "story_v_out_323121", "323121046", "story_v_out_323121.awb")

						arg_185_1:RecordAudio("323121046", var_188_21)
						arg_185_1:RecordAudio("323121046", var_188_21)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_323121", "323121046", "story_v_out_323121.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_323121", "323121046", "story_v_out_323121.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_22 = math.max(var_188_13, arg_185_1.talkMaxDuration)

			if var_188_12 <= arg_185_1.time_ and arg_185_1.time_ < var_188_12 + var_188_22 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_12) / var_188_22

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_12 + var_188_22 and arg_185_1.time_ < var_188_12 + var_188_22 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play323121047 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 323121047
		arg_189_1.duration_ = 2.47

		local var_189_0 = {
			zh = 2.466,
			ja = 2.433
		}
		local var_189_1 = manager.audio:GetLocalizationFlag()

		if var_189_0[var_189_1] ~= nil then
			arg_189_1.duration_ = var_189_0[var_189_1]
		end

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play323121048(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = arg_189_1.actors_["10170ui_story"]
			local var_192_1 = 0

			if var_192_1 < arg_189_1.time_ and arg_189_1.time_ <= var_192_1 + arg_192_0 and not isNil(var_192_0) and arg_189_1.var_.characterEffect10170ui_story == nil then
				arg_189_1.var_.characterEffect10170ui_story = var_192_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_192_2 = 0.200000002980232

			if var_192_1 <= arg_189_1.time_ and arg_189_1.time_ < var_192_1 + var_192_2 and not isNil(var_192_0) then
				local var_192_3 = (arg_189_1.time_ - var_192_1) / var_192_2

				if arg_189_1.var_.characterEffect10170ui_story and not isNil(var_192_0) then
					arg_189_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_189_1.time_ >= var_192_1 + var_192_2 and arg_189_1.time_ < var_192_1 + var_192_2 + arg_192_0 and not isNil(var_192_0) and arg_189_1.var_.characterEffect10170ui_story then
				arg_189_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_192_4 = arg_189_1.actors_["1053ui_story"]
			local var_192_5 = 0

			if var_192_5 < arg_189_1.time_ and arg_189_1.time_ <= var_192_5 + arg_192_0 and not isNil(var_192_4) and arg_189_1.var_.characterEffect1053ui_story == nil then
				arg_189_1.var_.characterEffect1053ui_story = var_192_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_192_6 = 0.200000002980232

			if var_192_5 <= arg_189_1.time_ and arg_189_1.time_ < var_192_5 + var_192_6 and not isNil(var_192_4) then
				local var_192_7 = (arg_189_1.time_ - var_192_5) / var_192_6

				if arg_189_1.var_.characterEffect1053ui_story and not isNil(var_192_4) then
					local var_192_8 = Mathf.Lerp(0, 0.5, var_192_7)

					arg_189_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_189_1.var_.characterEffect1053ui_story.fillRatio = var_192_8
				end
			end

			if arg_189_1.time_ >= var_192_5 + var_192_6 and arg_189_1.time_ < var_192_5 + var_192_6 + arg_192_0 and not isNil(var_192_4) and arg_189_1.var_.characterEffect1053ui_story then
				local var_192_9 = 0.5

				arg_189_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_189_1.var_.characterEffect1053ui_story.fillRatio = var_192_9
			end

			local var_192_10 = 0

			if var_192_10 < arg_189_1.time_ and arg_189_1.time_ <= var_192_10 + arg_192_0 then
				arg_189_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_192_11 = 0

			if var_192_11 < arg_189_1.time_ and arg_189_1.time_ <= var_192_11 + arg_192_0 then
				arg_189_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/story10170/story10170action/10170action2_2")
			end

			local var_192_12 = 0
			local var_192_13 = 0.225

			if var_192_12 < arg_189_1.time_ and arg_189_1.time_ <= var_192_12 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				local var_192_14 = arg_189_1:FormatText(StoryNameCfg[1450].name)

				arg_189_1.leftNameTxt_.text = var_192_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_15 = arg_189_1:GetWordFromCfg(323121047)
				local var_192_16 = arg_189_1:FormatText(var_192_15.content)

				arg_189_1.text_.text = var_192_16

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_17 = 9
				local var_192_18 = utf8.len(var_192_16)
				local var_192_19 = var_192_17 <= 0 and var_192_13 or var_192_13 * (var_192_18 / var_192_17)

				if var_192_19 > 0 and var_192_13 < var_192_19 then
					arg_189_1.talkMaxDuration = var_192_19

					if var_192_19 + var_192_12 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_19 + var_192_12
					end
				end

				arg_189_1.text_.text = var_192_16
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323121", "323121047", "story_v_out_323121.awb") ~= 0 then
					local var_192_20 = manager.audio:GetVoiceLength("story_v_out_323121", "323121047", "story_v_out_323121.awb") / 1000

					if var_192_20 + var_192_12 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_20 + var_192_12
					end

					if var_192_15.prefab_name ~= "" and arg_189_1.actors_[var_192_15.prefab_name] ~= nil then
						local var_192_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_15.prefab_name].transform, "story_v_out_323121", "323121047", "story_v_out_323121.awb")

						arg_189_1:RecordAudio("323121047", var_192_21)
						arg_189_1:RecordAudio("323121047", var_192_21)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_323121", "323121047", "story_v_out_323121.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_323121", "323121047", "story_v_out_323121.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_22 = math.max(var_192_13, arg_189_1.talkMaxDuration)

			if var_192_12 <= arg_189_1.time_ and arg_189_1.time_ < var_192_12 + var_192_22 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_12) / var_192_22

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_12 + var_192_22 and arg_189_1.time_ < var_192_12 + var_192_22 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {}

		arg_189_1:InitPlayNodeList()
	end,
	Play323121048 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 323121048
		arg_193_1.duration_ = 5

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play323121049(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = arg_193_1.actors_["10170ui_story"]
			local var_196_1 = 0

			if var_196_1 < arg_193_1.time_ and arg_193_1.time_ <= var_196_1 + arg_196_0 and not isNil(var_196_0) and arg_193_1.var_.characterEffect10170ui_story == nil then
				arg_193_1.var_.characterEffect10170ui_story = var_196_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_196_2 = 0.200000002980232

			if var_196_1 <= arg_193_1.time_ and arg_193_1.time_ < var_196_1 + var_196_2 and not isNil(var_196_0) then
				local var_196_3 = (arg_193_1.time_ - var_196_1) / var_196_2

				if arg_193_1.var_.characterEffect10170ui_story and not isNil(var_196_0) then
					local var_196_4 = Mathf.Lerp(0, 0.5, var_196_3)

					arg_193_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_193_1.var_.characterEffect10170ui_story.fillRatio = var_196_4
				end
			end

			if arg_193_1.time_ >= var_196_1 + var_196_2 and arg_193_1.time_ < var_196_1 + var_196_2 + arg_196_0 and not isNil(var_196_0) and arg_193_1.var_.characterEffect10170ui_story then
				local var_196_5 = 0.5

				arg_193_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_193_1.var_.characterEffect10170ui_story.fillRatio = var_196_5
			end

			local var_196_6 = 0
			local var_196_7 = 0.25

			if var_196_6 < arg_193_1.time_ and arg_193_1.time_ <= var_196_6 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				local var_196_8 = arg_193_1:FormatText(StoryNameCfg[7].name)

				arg_193_1.leftNameTxt_.text = var_196_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, true)
				arg_193_1.iconController_:SetSelectedState("hero")

				arg_193_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_193_1.callingController_:SetSelectedState("normal")

				arg_193_1.keyicon_.color = Color.New(1, 1, 1)
				arg_193_1.icon_.color = Color.New(1, 1, 1)

				local var_196_9 = arg_193_1:GetWordFromCfg(323121048)
				local var_196_10 = arg_193_1:FormatText(var_196_9.content)

				arg_193_1.text_.text = var_196_10

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_11 = 10
				local var_196_12 = utf8.len(var_196_10)
				local var_196_13 = var_196_11 <= 0 and var_196_7 or var_196_7 * (var_196_12 / var_196_11)

				if var_196_13 > 0 and var_196_7 < var_196_13 then
					arg_193_1.talkMaxDuration = var_196_13

					if var_196_13 + var_196_6 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_13 + var_196_6
					end
				end

				arg_193_1.text_.text = var_196_10
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)
				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_14 = math.max(var_196_7, arg_193_1.talkMaxDuration)

			if var_196_6 <= arg_193_1.time_ and arg_193_1.time_ < var_196_6 + var_196_14 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_6) / var_196_14

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_6 + var_196_14 and arg_193_1.time_ < var_196_6 + var_196_14 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	Play323121049 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 323121049
		arg_197_1.duration_ = 5

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play323121050(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = arg_197_1.actors_["10170ui_story"].transform
			local var_200_1 = 0

			if var_200_1 < arg_197_1.time_ and arg_197_1.time_ <= var_200_1 + arg_200_0 then
				arg_197_1.var_.moveOldPos10170ui_story = var_200_0.localPosition

				local var_200_2 = GameObjectTools.GetOrAddComponent(var_200_0.gameObject, typeof(DynamicBoneHelper))

				if var_200_2 then
					var_200_2:EnableDynamicBone(false)
				end
			end

			local var_200_3 = 0.001

			if var_200_1 <= arg_197_1.time_ and arg_197_1.time_ < var_200_1 + var_200_3 then
				local var_200_4 = (arg_197_1.time_ - var_200_1) / var_200_3
				local var_200_5 = Vector3.New(0, 100, 0)

				var_200_0.localPosition = Vector3.Lerp(arg_197_1.var_.moveOldPos10170ui_story, var_200_5, var_200_4)

				local var_200_6 = manager.ui.mainCamera.transform.position - var_200_0.position

				var_200_0.forward = Vector3.New(var_200_6.x, var_200_6.y, var_200_6.z)

				local var_200_7 = var_200_0.localEulerAngles

				var_200_7.z = 0
				var_200_7.x = 0
				var_200_0.localEulerAngles = var_200_7
			end

			if arg_197_1.time_ >= var_200_1 + var_200_3 and arg_197_1.time_ < var_200_1 + var_200_3 + arg_200_0 then
				var_200_0.localPosition = Vector3.New(0, 100, 0)

				local var_200_8 = manager.ui.mainCamera.transform.position - var_200_0.position

				var_200_0.forward = Vector3.New(var_200_8.x, var_200_8.y, var_200_8.z)

				local var_200_9 = var_200_0.localEulerAngles

				var_200_9.z = 0
				var_200_9.x = 0
				var_200_0.localEulerAngles = var_200_9

				local var_200_10 = GameObjectTools.GetOrAddComponent(var_200_0.gameObject, typeof(DynamicBoneHelper))

				if var_200_10 then
					var_200_10:EnableDynamicBone(true)
				end
			end

			local var_200_11 = arg_197_1.actors_["1053ui_story"].transform
			local var_200_12 = 0

			if var_200_12 < arg_197_1.time_ and arg_197_1.time_ <= var_200_12 + arg_200_0 then
				arg_197_1.var_.moveOldPos1053ui_story = var_200_11.localPosition

				local var_200_13 = GameObjectTools.GetOrAddComponent(var_200_11.gameObject, typeof(DynamicBoneHelper))

				if var_200_13 then
					var_200_13:EnableDynamicBone(false)
				end
			end

			local var_200_14 = 0.001

			if var_200_12 <= arg_197_1.time_ and arg_197_1.time_ < var_200_12 + var_200_14 then
				local var_200_15 = (arg_197_1.time_ - var_200_12) / var_200_14
				local var_200_16 = Vector3.New(0, 100, 0)

				var_200_11.localPosition = Vector3.Lerp(arg_197_1.var_.moveOldPos1053ui_story, var_200_16, var_200_15)

				local var_200_17 = manager.ui.mainCamera.transform.position - var_200_11.position

				var_200_11.forward = Vector3.New(var_200_17.x, var_200_17.y, var_200_17.z)

				local var_200_18 = var_200_11.localEulerAngles

				var_200_18.z = 0
				var_200_18.x = 0
				var_200_11.localEulerAngles = var_200_18
			end

			if arg_197_1.time_ >= var_200_12 + var_200_14 and arg_197_1.time_ < var_200_12 + var_200_14 + arg_200_0 then
				var_200_11.localPosition = Vector3.New(0, 100, 0)

				local var_200_19 = manager.ui.mainCamera.transform.position - var_200_11.position

				var_200_11.forward = Vector3.New(var_200_19.x, var_200_19.y, var_200_19.z)

				local var_200_20 = var_200_11.localEulerAngles

				var_200_20.z = 0
				var_200_20.x = 0
				var_200_11.localEulerAngles = var_200_20

				local var_200_21 = GameObjectTools.GetOrAddComponent(var_200_11.gameObject, typeof(DynamicBoneHelper))

				if var_200_21 then
					var_200_21:EnableDynamicBone(true)
				end
			end

			local var_200_22 = 0
			local var_200_23 = 1.6

			if var_200_22 < arg_197_1.time_ and arg_197_1.time_ <= var_200_22 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, false)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_24 = arg_197_1:GetWordFromCfg(323121049)
				local var_200_25 = arg_197_1:FormatText(var_200_24.content)

				arg_197_1.text_.text = var_200_25

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_26 = 64
				local var_200_27 = utf8.len(var_200_25)
				local var_200_28 = var_200_26 <= 0 and var_200_23 or var_200_23 * (var_200_27 / var_200_26)

				if var_200_28 > 0 and var_200_23 < var_200_28 then
					arg_197_1.talkMaxDuration = var_200_28

					if var_200_28 + var_200_22 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_28 + var_200_22
					end
				end

				arg_197_1.text_.text = var_200_25
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)
				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_29 = math.max(var_200_23, arg_197_1.talkMaxDuration)

			if var_200_22 <= arg_197_1.time_ and arg_197_1.time_ < var_200_22 + var_200_29 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_22) / var_200_29

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_22 + var_200_29 and arg_197_1.time_ < var_200_22 + var_200_29 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_197_1:InitPlayNodeList()
	end,
	Play323121050 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 323121050
		arg_201_1.duration_ = 5

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play323121051(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = 0
			local var_204_1 = 0.775

			if var_204_0 < arg_201_1.time_ and arg_201_1.time_ <= var_204_0 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, false)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_2 = arg_201_1:GetWordFromCfg(323121050)
				local var_204_3 = arg_201_1:FormatText(var_204_2.content)

				arg_201_1.text_.text = var_204_3

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_4 = 31
				local var_204_5 = utf8.len(var_204_3)
				local var_204_6 = var_204_4 <= 0 and var_204_1 or var_204_1 * (var_204_5 / var_204_4)

				if var_204_6 > 0 and var_204_1 < var_204_6 then
					arg_201_1.talkMaxDuration = var_204_6

					if var_204_6 + var_204_0 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_6 + var_204_0
					end
				end

				arg_201_1.text_.text = var_204_3
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)
				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_7 = math.max(var_204_1, arg_201_1.talkMaxDuration)

			if var_204_0 <= arg_201_1.time_ and arg_201_1.time_ < var_204_0 + var_204_7 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_0) / var_204_7

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_0 + var_204_7 and arg_201_1.time_ < var_204_0 + var_204_7 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {}

		arg_201_1:InitPlayNodeList()
	end,
	Play323121051 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 323121051
		arg_205_1.duration_ = 5

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play323121052(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = 0
			local var_208_1 = 0.6

			if var_208_0 < arg_205_1.time_ and arg_205_1.time_ <= var_208_0 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				local var_208_2 = arg_205_1:FormatText(StoryNameCfg[7].name)

				arg_205_1.leftNameTxt_.text = var_208_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, true)
				arg_205_1.iconController_:SetSelectedState("hero")

				arg_205_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_205_1.callingController_:SetSelectedState("normal")

				arg_205_1.keyicon_.color = Color.New(1, 1, 1)
				arg_205_1.icon_.color = Color.New(1, 1, 1)

				local var_208_3 = arg_205_1:GetWordFromCfg(323121051)
				local var_208_4 = arg_205_1:FormatText(var_208_3.content)

				arg_205_1.text_.text = var_208_4

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_5 = 24
				local var_208_6 = utf8.len(var_208_4)
				local var_208_7 = var_208_5 <= 0 and var_208_1 or var_208_1 * (var_208_6 / var_208_5)

				if var_208_7 > 0 and var_208_1 < var_208_7 then
					arg_205_1.talkMaxDuration = var_208_7

					if var_208_7 + var_208_0 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_7 + var_208_0
					end
				end

				arg_205_1.text_.text = var_208_4
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)
				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_8 = math.max(var_208_1, arg_205_1.talkMaxDuration)

			if var_208_0 <= arg_205_1.time_ and arg_205_1.time_ < var_208_0 + var_208_8 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_0) / var_208_8

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_0 + var_208_8 and arg_205_1.time_ < var_208_0 + var_208_8 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {}

		arg_205_1:InitPlayNodeList()
	end,
	Play323121052 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 323121052
		arg_209_1.duration_ = 5

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play323121053(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = 0
			local var_212_1 = 1.225

			if var_212_0 < arg_209_1.time_ and arg_209_1.time_ <= var_212_0 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				local var_212_2 = arg_209_1:FormatText(StoryNameCfg[7].name)

				arg_209_1.leftNameTxt_.text = var_212_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, true)
				arg_209_1.iconController_:SetSelectedState("hero")

				arg_209_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_209_1.callingController_:SetSelectedState("normal")

				arg_209_1.keyicon_.color = Color.New(1, 1, 1)
				arg_209_1.icon_.color = Color.New(1, 1, 1)

				local var_212_3 = arg_209_1:GetWordFromCfg(323121052)
				local var_212_4 = arg_209_1:FormatText(var_212_3.content)

				arg_209_1.text_.text = var_212_4

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_5 = 49
				local var_212_6 = utf8.len(var_212_4)
				local var_212_7 = var_212_5 <= 0 and var_212_1 or var_212_1 * (var_212_6 / var_212_5)

				if var_212_7 > 0 and var_212_1 < var_212_7 then
					arg_209_1.talkMaxDuration = var_212_7

					if var_212_7 + var_212_0 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_7 + var_212_0
					end
				end

				arg_209_1.text_.text = var_212_4
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)
				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_8 = math.max(var_212_1, arg_209_1.talkMaxDuration)

			if var_212_0 <= arg_209_1.time_ and arg_209_1.time_ < var_212_0 + var_212_8 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_0) / var_212_8

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_0 + var_212_8 and arg_209_1.time_ < var_212_0 + var_212_8 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {}

		arg_209_1:InitPlayNodeList()
	end,
	Play323121053 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 323121053
		arg_213_1.duration_ = 2.97

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play323121054(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = arg_213_1.actors_["10170ui_story"].transform
			local var_216_1 = 0

			if var_216_1 < arg_213_1.time_ and arg_213_1.time_ <= var_216_1 + arg_216_0 then
				arg_213_1.var_.moveOldPos10170ui_story = var_216_0.localPosition

				local var_216_2 = GameObjectTools.GetOrAddComponent(var_216_0.gameObject, typeof(DynamicBoneHelper))

				if var_216_2 then
					var_216_2:EnableDynamicBone(false)
				end
			end

			local var_216_3 = 0.001

			if var_216_1 <= arg_213_1.time_ and arg_213_1.time_ < var_216_1 + var_216_3 then
				local var_216_4 = (arg_213_1.time_ - var_216_1) / var_216_3
				local var_216_5 = Vector3.New(0, -1.03, -6.05)

				var_216_0.localPosition = Vector3.Lerp(arg_213_1.var_.moveOldPos10170ui_story, var_216_5, var_216_4)

				local var_216_6 = manager.ui.mainCamera.transform.position - var_216_0.position

				var_216_0.forward = Vector3.New(var_216_6.x, var_216_6.y, var_216_6.z)

				local var_216_7 = var_216_0.localEulerAngles

				var_216_7.z = 0
				var_216_7.x = 0
				var_216_0.localEulerAngles = var_216_7
			end

			if arg_213_1.time_ >= var_216_1 + var_216_3 and arg_213_1.time_ < var_216_1 + var_216_3 + arg_216_0 then
				var_216_0.localPosition = Vector3.New(0, -1.03, -6.05)

				local var_216_8 = manager.ui.mainCamera.transform.position - var_216_0.position

				var_216_0.forward = Vector3.New(var_216_8.x, var_216_8.y, var_216_8.z)

				local var_216_9 = var_216_0.localEulerAngles

				var_216_9.z = 0
				var_216_9.x = 0
				var_216_0.localEulerAngles = var_216_9

				local var_216_10 = GameObjectTools.GetOrAddComponent(var_216_0.gameObject, typeof(DynamicBoneHelper))

				if var_216_10 then
					var_216_10:EnableDynamicBone(true)
				end
			end

			local var_216_11 = arg_213_1.actors_["10170ui_story"]
			local var_216_12 = 0

			if var_216_12 < arg_213_1.time_ and arg_213_1.time_ <= var_216_12 + arg_216_0 and not isNil(var_216_11) and arg_213_1.var_.characterEffect10170ui_story == nil then
				arg_213_1.var_.characterEffect10170ui_story = var_216_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_216_13 = 0.200000002980232

			if var_216_12 <= arg_213_1.time_ and arg_213_1.time_ < var_216_12 + var_216_13 and not isNil(var_216_11) then
				local var_216_14 = (arg_213_1.time_ - var_216_12) / var_216_13

				if arg_213_1.var_.characterEffect10170ui_story and not isNil(var_216_11) then
					arg_213_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_213_1.time_ >= var_216_12 + var_216_13 and arg_213_1.time_ < var_216_12 + var_216_13 + arg_216_0 and not isNil(var_216_11) and arg_213_1.var_.characterEffect10170ui_story then
				arg_213_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_216_15 = 0

			if var_216_15 < arg_213_1.time_ and arg_213_1.time_ <= var_216_15 + arg_216_0 then
				arg_213_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/story10170/story10170action/10170action1_1")
			end

			local var_216_16 = 0

			if var_216_16 < arg_213_1.time_ and arg_213_1.time_ <= var_216_16 + arg_216_0 then
				arg_213_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_216_17 = 0
			local var_216_18 = 0.25

			if var_216_17 < arg_213_1.time_ and arg_213_1.time_ <= var_216_17 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				local var_216_19 = arg_213_1:FormatText(StoryNameCfg[1450].name)

				arg_213_1.leftNameTxt_.text = var_216_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_20 = arg_213_1:GetWordFromCfg(323121053)
				local var_216_21 = arg_213_1:FormatText(var_216_20.content)

				arg_213_1.text_.text = var_216_21

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_22 = 10
				local var_216_23 = utf8.len(var_216_21)
				local var_216_24 = var_216_22 <= 0 and var_216_18 or var_216_18 * (var_216_23 / var_216_22)

				if var_216_24 > 0 and var_216_18 < var_216_24 then
					arg_213_1.talkMaxDuration = var_216_24

					if var_216_24 + var_216_17 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_24 + var_216_17
					end
				end

				arg_213_1.text_.text = var_216_21
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323121", "323121053", "story_v_out_323121.awb") ~= 0 then
					local var_216_25 = manager.audio:GetVoiceLength("story_v_out_323121", "323121053", "story_v_out_323121.awb") / 1000

					if var_216_25 + var_216_17 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_25 + var_216_17
					end

					if var_216_20.prefab_name ~= "" and arg_213_1.actors_[var_216_20.prefab_name] ~= nil then
						local var_216_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_20.prefab_name].transform, "story_v_out_323121", "323121053", "story_v_out_323121.awb")

						arg_213_1:RecordAudio("323121053", var_216_26)
						arg_213_1:RecordAudio("323121053", var_216_26)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_out_323121", "323121053", "story_v_out_323121.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_out_323121", "323121053", "story_v_out_323121.awb")
				end

				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_27 = math.max(var_216_18, arg_213_1.talkMaxDuration)

			if var_216_17 <= arg_213_1.time_ and arg_213_1.time_ < var_216_17 + var_216_27 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_17) / var_216_27

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_17 + var_216_27 and arg_213_1.time_ < var_216_17 + var_216_27 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_213_1:InitPlayNodeList()
	end,
	Play323121054 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 323121054
		arg_217_1.duration_ = 5

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play323121055(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = arg_217_1.actors_["10170ui_story"]
			local var_220_1 = 0

			if var_220_1 < arg_217_1.time_ and arg_217_1.time_ <= var_220_1 + arg_220_0 and not isNil(var_220_0) and arg_217_1.var_.characterEffect10170ui_story == nil then
				arg_217_1.var_.characterEffect10170ui_story = var_220_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_220_2 = 0.200000002980232

			if var_220_1 <= arg_217_1.time_ and arg_217_1.time_ < var_220_1 + var_220_2 and not isNil(var_220_0) then
				local var_220_3 = (arg_217_1.time_ - var_220_1) / var_220_2

				if arg_217_1.var_.characterEffect10170ui_story and not isNil(var_220_0) then
					local var_220_4 = Mathf.Lerp(0, 0.5, var_220_3)

					arg_217_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_217_1.var_.characterEffect10170ui_story.fillRatio = var_220_4
				end
			end

			if arg_217_1.time_ >= var_220_1 + var_220_2 and arg_217_1.time_ < var_220_1 + var_220_2 + arg_220_0 and not isNil(var_220_0) and arg_217_1.var_.characterEffect10170ui_story then
				local var_220_5 = 0.5

				arg_217_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_217_1.var_.characterEffect10170ui_story.fillRatio = var_220_5
			end

			local var_220_6 = 0
			local var_220_7 = 0.65

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

				arg_217_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_217_1.callingController_:SetSelectedState("normal")

				arg_217_1.keyicon_.color = Color.New(1, 1, 1)
				arg_217_1.icon_.color = Color.New(1, 1, 1)

				local var_220_9 = arg_217_1:GetWordFromCfg(323121054)
				local var_220_10 = arg_217_1:FormatText(var_220_9.content)

				arg_217_1.text_.text = var_220_10

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_11 = 26
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
	Play323121055 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 323121055
		arg_221_1.duration_ = 5

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play323121056(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_0 = arg_221_1.actors_["10170ui_story"].transform
			local var_224_1 = 0

			if var_224_1 < arg_221_1.time_ and arg_221_1.time_ <= var_224_1 + arg_224_0 then
				arg_221_1.var_.moveOldPos10170ui_story = var_224_0.localPosition

				local var_224_2 = GameObjectTools.GetOrAddComponent(var_224_0.gameObject, typeof(DynamicBoneHelper))

				if var_224_2 then
					var_224_2:EnableDynamicBone(false)
				end
			end

			local var_224_3 = 0.001

			if var_224_1 <= arg_221_1.time_ and arg_221_1.time_ < var_224_1 + var_224_3 then
				local var_224_4 = (arg_221_1.time_ - var_224_1) / var_224_3
				local var_224_5 = Vector3.New(0, 100, 0)

				var_224_0.localPosition = Vector3.Lerp(arg_221_1.var_.moveOldPos10170ui_story, var_224_5, var_224_4)

				local var_224_6 = manager.ui.mainCamera.transform.position - var_224_0.position

				var_224_0.forward = Vector3.New(var_224_6.x, var_224_6.y, var_224_6.z)

				local var_224_7 = var_224_0.localEulerAngles

				var_224_7.z = 0
				var_224_7.x = 0
				var_224_0.localEulerAngles = var_224_7
			end

			if arg_221_1.time_ >= var_224_1 + var_224_3 and arg_221_1.time_ < var_224_1 + var_224_3 + arg_224_0 then
				var_224_0.localPosition = Vector3.New(0, 100, 0)

				local var_224_8 = manager.ui.mainCamera.transform.position - var_224_0.position

				var_224_0.forward = Vector3.New(var_224_8.x, var_224_8.y, var_224_8.z)

				local var_224_9 = var_224_0.localEulerAngles

				var_224_9.z = 0
				var_224_9.x = 0
				var_224_0.localEulerAngles = var_224_9

				local var_224_10 = GameObjectTools.GetOrAddComponent(var_224_0.gameObject, typeof(DynamicBoneHelper))

				if var_224_10 then
					var_224_10:EnableDynamicBone(true)
				end
			end

			local var_224_11 = 0
			local var_224_12 = 1.15

			if var_224_11 < arg_221_1.time_ and arg_221_1.time_ <= var_224_11 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, false)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_13 = arg_221_1:GetWordFromCfg(323121055)
				local var_224_14 = arg_221_1:FormatText(var_224_13.content)

				arg_221_1.text_.text = var_224_14

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_15 = 46
				local var_224_16 = utf8.len(var_224_14)
				local var_224_17 = var_224_15 <= 0 and var_224_12 or var_224_12 * (var_224_16 / var_224_15)

				if var_224_17 > 0 and var_224_12 < var_224_17 then
					arg_221_1.talkMaxDuration = var_224_17

					if var_224_17 + var_224_11 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_17 + var_224_11
					end
				end

				arg_221_1.text_.text = var_224_14
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)
				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_18 = math.max(var_224_12, arg_221_1.talkMaxDuration)

			if var_224_11 <= arg_221_1.time_ and arg_221_1.time_ < var_224_11 + var_224_18 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_11) / var_224_18

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_11 + var_224_18 and arg_221_1.time_ < var_224_11 + var_224_18 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_221_1:InitPlayNodeList()
	end,
	Play323121056 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 323121056
		arg_225_1.duration_ = 5

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play323121057(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = 0
			local var_228_1 = 1.275

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

				arg_225_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_225_1.callingController_:SetSelectedState("normal")

				arg_225_1.keyicon_.color = Color.New(1, 1, 1)
				arg_225_1.icon_.color = Color.New(1, 1, 1)

				local var_228_3 = arg_225_1:GetWordFromCfg(323121056)
				local var_228_4 = arg_225_1:FormatText(var_228_3.content)

				arg_225_1.text_.text = var_228_4

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_5 = 51
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
	Play323121057 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 323121057
		arg_229_1.duration_ = 5

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play323121058(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = 0
			local var_232_1 = 0.85

			if var_232_0 < arg_229_1.time_ and arg_229_1.time_ <= var_232_0 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				local var_232_2 = arg_229_1:FormatText(StoryNameCfg[7].name)

				arg_229_1.leftNameTxt_.text = var_232_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, true)
				arg_229_1.iconController_:SetSelectedState("hero")

				arg_229_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_229_1.callingController_:SetSelectedState("normal")

				arg_229_1.keyicon_.color = Color.New(1, 1, 1)
				arg_229_1.icon_.color = Color.New(1, 1, 1)

				local var_232_3 = arg_229_1:GetWordFromCfg(323121057)
				local var_232_4 = arg_229_1:FormatText(var_232_3.content)

				arg_229_1.text_.text = var_232_4

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_5 = 34
				local var_232_6 = utf8.len(var_232_4)
				local var_232_7 = var_232_5 <= 0 and var_232_1 or var_232_1 * (var_232_6 / var_232_5)

				if var_232_7 > 0 and var_232_1 < var_232_7 then
					arg_229_1.talkMaxDuration = var_232_7

					if var_232_7 + var_232_0 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_7 + var_232_0
					end
				end

				arg_229_1.text_.text = var_232_4
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)
				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_8 = math.max(var_232_1, arg_229_1.talkMaxDuration)

			if var_232_0 <= arg_229_1.time_ and arg_229_1.time_ < var_232_0 + var_232_8 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_0) / var_232_8

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_0 + var_232_8 and arg_229_1.time_ < var_232_0 + var_232_8 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {}

		arg_229_1:InitPlayNodeList()
	end,
	Play323121058 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 323121058
		arg_233_1.duration_ = 2

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play323121059(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			local var_236_0 = arg_233_1.actors_["10170ui_story"].transform
			local var_236_1 = 0

			if var_236_1 < arg_233_1.time_ and arg_233_1.time_ <= var_236_1 + arg_236_0 then
				arg_233_1.var_.moveOldPos10170ui_story = var_236_0.localPosition

				local var_236_2 = GameObjectTools.GetOrAddComponent(var_236_0.gameObject, typeof(DynamicBoneHelper))

				if var_236_2 then
					var_236_2:EnableDynamicBone(false)
				end
			end

			local var_236_3 = 0.001

			if var_236_1 <= arg_233_1.time_ and arg_233_1.time_ < var_236_1 + var_236_3 then
				local var_236_4 = (arg_233_1.time_ - var_236_1) / var_236_3
				local var_236_5 = Vector3.New(0, -1.03, -6.05)

				var_236_0.localPosition = Vector3.Lerp(arg_233_1.var_.moveOldPos10170ui_story, var_236_5, var_236_4)

				local var_236_6 = manager.ui.mainCamera.transform.position - var_236_0.position

				var_236_0.forward = Vector3.New(var_236_6.x, var_236_6.y, var_236_6.z)

				local var_236_7 = var_236_0.localEulerAngles

				var_236_7.z = 0
				var_236_7.x = 0
				var_236_0.localEulerAngles = var_236_7
			end

			if arg_233_1.time_ >= var_236_1 + var_236_3 and arg_233_1.time_ < var_236_1 + var_236_3 + arg_236_0 then
				var_236_0.localPosition = Vector3.New(0, -1.03, -6.05)

				local var_236_8 = manager.ui.mainCamera.transform.position - var_236_0.position

				var_236_0.forward = Vector3.New(var_236_8.x, var_236_8.y, var_236_8.z)

				local var_236_9 = var_236_0.localEulerAngles

				var_236_9.z = 0
				var_236_9.x = 0
				var_236_0.localEulerAngles = var_236_9

				local var_236_10 = GameObjectTools.GetOrAddComponent(var_236_0.gameObject, typeof(DynamicBoneHelper))

				if var_236_10 then
					var_236_10:EnableDynamicBone(true)
				end
			end

			local var_236_11 = arg_233_1.actors_["10170ui_story"]
			local var_236_12 = 0

			if var_236_12 < arg_233_1.time_ and arg_233_1.time_ <= var_236_12 + arg_236_0 and not isNil(var_236_11) and arg_233_1.var_.characterEffect10170ui_story == nil then
				arg_233_1.var_.characterEffect10170ui_story = var_236_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_236_13 = 0.200000002980232

			if var_236_12 <= arg_233_1.time_ and arg_233_1.time_ < var_236_12 + var_236_13 and not isNil(var_236_11) then
				local var_236_14 = (arg_233_1.time_ - var_236_12) / var_236_13

				if arg_233_1.var_.characterEffect10170ui_story and not isNil(var_236_11) then
					arg_233_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_233_1.time_ >= var_236_12 + var_236_13 and arg_233_1.time_ < var_236_12 + var_236_13 + arg_236_0 and not isNil(var_236_11) and arg_233_1.var_.characterEffect10170ui_story then
				arg_233_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_236_15 = 0

			if var_236_15 < arg_233_1.time_ and arg_233_1.time_ <= var_236_15 + arg_236_0 then
				arg_233_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_236_16 = 0

			if var_236_16 < arg_233_1.time_ and arg_233_1.time_ <= var_236_16 + arg_236_0 then
				arg_233_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/story10170/story10170action/10170action29_1")
			end

			local var_236_17 = 0
			local var_236_18 = 0.1

			if var_236_17 < arg_233_1.time_ and arg_233_1.time_ <= var_236_17 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				local var_236_19 = arg_233_1:FormatText(StoryNameCfg[1450].name)

				arg_233_1.leftNameTxt_.text = var_236_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_20 = arg_233_1:GetWordFromCfg(323121058)
				local var_236_21 = arg_233_1:FormatText(var_236_20.content)

				arg_233_1.text_.text = var_236_21

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_22 = 4
				local var_236_23 = utf8.len(var_236_21)
				local var_236_24 = var_236_22 <= 0 and var_236_18 or var_236_18 * (var_236_23 / var_236_22)

				if var_236_24 > 0 and var_236_18 < var_236_24 then
					arg_233_1.talkMaxDuration = var_236_24

					if var_236_24 + var_236_17 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_24 + var_236_17
					end
				end

				arg_233_1.text_.text = var_236_21
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323121", "323121058", "story_v_out_323121.awb") ~= 0 then
					local var_236_25 = manager.audio:GetVoiceLength("story_v_out_323121", "323121058", "story_v_out_323121.awb") / 1000

					if var_236_25 + var_236_17 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_25 + var_236_17
					end

					if var_236_20.prefab_name ~= "" and arg_233_1.actors_[var_236_20.prefab_name] ~= nil then
						local var_236_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_233_1.actors_[var_236_20.prefab_name].transform, "story_v_out_323121", "323121058", "story_v_out_323121.awb")

						arg_233_1:RecordAudio("323121058", var_236_26)
						arg_233_1:RecordAudio("323121058", var_236_26)
					else
						arg_233_1:AudioAction("play", "voice", "story_v_out_323121", "323121058", "story_v_out_323121.awb")
					end

					arg_233_1:RecordHistoryTalkVoice("story_v_out_323121", "323121058", "story_v_out_323121.awb")
				end

				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_27 = math.max(var_236_18, arg_233_1.talkMaxDuration)

			if var_236_17 <= arg_233_1.time_ and arg_233_1.time_ < var_236_17 + var_236_27 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_17) / var_236_27

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_17 + var_236_27 and arg_233_1.time_ < var_236_17 + var_236_27 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_233_1:InitPlayNodeList()
	end,
	Play323121059 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 323121059
		arg_237_1.duration_ = 5

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play323121060(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			local var_240_0 = arg_237_1.actors_["10170ui_story"].transform
			local var_240_1 = 0

			if var_240_1 < arg_237_1.time_ and arg_237_1.time_ <= var_240_1 + arg_240_0 then
				arg_237_1.var_.moveOldPos10170ui_story = var_240_0.localPosition

				local var_240_2 = GameObjectTools.GetOrAddComponent(var_240_0.gameObject, typeof(DynamicBoneHelper))

				if var_240_2 then
					var_240_2:EnableDynamicBone(false)
				end
			end

			local var_240_3 = 0.001

			if var_240_1 <= arg_237_1.time_ and arg_237_1.time_ < var_240_1 + var_240_3 then
				local var_240_4 = (arg_237_1.time_ - var_240_1) / var_240_3
				local var_240_5 = Vector3.New(0, 100, 0)

				var_240_0.localPosition = Vector3.Lerp(arg_237_1.var_.moveOldPos10170ui_story, var_240_5, var_240_4)

				local var_240_6 = manager.ui.mainCamera.transform.position - var_240_0.position

				var_240_0.forward = Vector3.New(var_240_6.x, var_240_6.y, var_240_6.z)

				local var_240_7 = var_240_0.localEulerAngles

				var_240_7.z = 0
				var_240_7.x = 0
				var_240_0.localEulerAngles = var_240_7
			end

			if arg_237_1.time_ >= var_240_1 + var_240_3 and arg_237_1.time_ < var_240_1 + var_240_3 + arg_240_0 then
				var_240_0.localPosition = Vector3.New(0, 100, 0)

				local var_240_8 = manager.ui.mainCamera.transform.position - var_240_0.position

				var_240_0.forward = Vector3.New(var_240_8.x, var_240_8.y, var_240_8.z)

				local var_240_9 = var_240_0.localEulerAngles

				var_240_9.z = 0
				var_240_9.x = 0
				var_240_0.localEulerAngles = var_240_9

				local var_240_10 = GameObjectTools.GetOrAddComponent(var_240_0.gameObject, typeof(DynamicBoneHelper))

				if var_240_10 then
					var_240_10:EnableDynamicBone(true)
				end
			end

			local var_240_11 = arg_237_1.actors_["10170ui_story"]
			local var_240_12 = 0

			if var_240_12 < arg_237_1.time_ and arg_237_1.time_ <= var_240_12 + arg_240_0 and not isNil(var_240_11) and arg_237_1.var_.characterEffect10170ui_story == nil then
				arg_237_1.var_.characterEffect10170ui_story = var_240_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_240_13 = 0.200000002980232

			if var_240_12 <= arg_237_1.time_ and arg_237_1.time_ < var_240_12 + var_240_13 and not isNil(var_240_11) then
				local var_240_14 = (arg_237_1.time_ - var_240_12) / var_240_13

				if arg_237_1.var_.characterEffect10170ui_story and not isNil(var_240_11) then
					local var_240_15 = Mathf.Lerp(0, 0.5, var_240_14)

					arg_237_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_237_1.var_.characterEffect10170ui_story.fillRatio = var_240_15
				end
			end

			if arg_237_1.time_ >= var_240_12 + var_240_13 and arg_237_1.time_ < var_240_12 + var_240_13 + arg_240_0 and not isNil(var_240_11) and arg_237_1.var_.characterEffect10170ui_story then
				local var_240_16 = 0.5

				arg_237_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_237_1.var_.characterEffect10170ui_story.fillRatio = var_240_16
			end

			local var_240_17 = 0
			local var_240_18 = 1.35

			if var_240_17 < arg_237_1.time_ and arg_237_1.time_ <= var_240_17 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, false)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_19 = arg_237_1:GetWordFromCfg(323121059)
				local var_240_20 = arg_237_1:FormatText(var_240_19.content)

				arg_237_1.text_.text = var_240_20

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_21 = 54
				local var_240_22 = utf8.len(var_240_20)
				local var_240_23 = var_240_21 <= 0 and var_240_18 or var_240_18 * (var_240_22 / var_240_21)

				if var_240_23 > 0 and var_240_18 < var_240_23 then
					arg_237_1.talkMaxDuration = var_240_23

					if var_240_23 + var_240_17 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_23 + var_240_17
					end
				end

				arg_237_1.text_.text = var_240_20
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)
				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_24 = math.max(var_240_18, arg_237_1.talkMaxDuration)

			if var_240_17 <= arg_237_1.time_ and arg_237_1.time_ < var_240_17 + var_240_24 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_17) / var_240_24

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_17 + var_240_24 and arg_237_1.time_ < var_240_17 + var_240_24 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_237_1:InitPlayNodeList()
	end,
	Play323121060 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 323121060
		arg_241_1.duration_ = 12.1

		local var_241_0 = {
			zh = 7.8,
			ja = 12.1
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
				arg_241_0:Play323121061(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			local var_244_0 = arg_241_1.actors_["10170ui_story"].transform
			local var_244_1 = 0

			if var_244_1 < arg_241_1.time_ and arg_241_1.time_ <= var_244_1 + arg_244_0 then
				arg_241_1.var_.moveOldPos10170ui_story = var_244_0.localPosition

				local var_244_2 = GameObjectTools.GetOrAddComponent(var_244_0.gameObject, typeof(DynamicBoneHelper))

				if var_244_2 then
					var_244_2:EnableDynamicBone(false)
				end
			end

			local var_244_3 = 0.001

			if var_244_1 <= arg_241_1.time_ and arg_241_1.time_ < var_244_1 + var_244_3 then
				local var_244_4 = (arg_241_1.time_ - var_244_1) / var_244_3
				local var_244_5 = Vector3.New(0, -1.03, -6.05)

				var_244_0.localPosition = Vector3.Lerp(arg_241_1.var_.moveOldPos10170ui_story, var_244_5, var_244_4)

				local var_244_6 = manager.ui.mainCamera.transform.position - var_244_0.position

				var_244_0.forward = Vector3.New(var_244_6.x, var_244_6.y, var_244_6.z)

				local var_244_7 = var_244_0.localEulerAngles

				var_244_7.z = 0
				var_244_7.x = 0
				var_244_0.localEulerAngles = var_244_7
			end

			if arg_241_1.time_ >= var_244_1 + var_244_3 and arg_241_1.time_ < var_244_1 + var_244_3 + arg_244_0 then
				var_244_0.localPosition = Vector3.New(0, -1.03, -6.05)

				local var_244_8 = manager.ui.mainCamera.transform.position - var_244_0.position

				var_244_0.forward = Vector3.New(var_244_8.x, var_244_8.y, var_244_8.z)

				local var_244_9 = var_244_0.localEulerAngles

				var_244_9.z = 0
				var_244_9.x = 0
				var_244_0.localEulerAngles = var_244_9

				local var_244_10 = GameObjectTools.GetOrAddComponent(var_244_0.gameObject, typeof(DynamicBoneHelper))

				if var_244_10 then
					var_244_10:EnableDynamicBone(true)
				end
			end

			local var_244_11 = arg_241_1.actors_["10170ui_story"]
			local var_244_12 = 0

			if var_244_12 < arg_241_1.time_ and arg_241_1.time_ <= var_244_12 + arg_244_0 and not isNil(var_244_11) and arg_241_1.var_.characterEffect10170ui_story == nil then
				arg_241_1.var_.characterEffect10170ui_story = var_244_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_244_13 = 0.200000002980232

			if var_244_12 <= arg_241_1.time_ and arg_241_1.time_ < var_244_12 + var_244_13 and not isNil(var_244_11) then
				local var_244_14 = (arg_241_1.time_ - var_244_12) / var_244_13

				if arg_241_1.var_.characterEffect10170ui_story and not isNil(var_244_11) then
					arg_241_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_241_1.time_ >= var_244_12 + var_244_13 and arg_241_1.time_ < var_244_12 + var_244_13 + arg_244_0 and not isNil(var_244_11) and arg_241_1.var_.characterEffect10170ui_story then
				arg_241_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_244_15 = 0

			if var_244_15 < arg_241_1.time_ and arg_241_1.time_ <= var_244_15 + arg_244_0 then
				arg_241_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_244_16 = 0

			if var_244_16 < arg_241_1.time_ and arg_241_1.time_ <= var_244_16 + arg_244_0 then
				arg_241_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/story10170/story10170action/10170action29_2")
			end

			local var_244_17 = 0
			local var_244_18 = 0.75

			if var_244_17 < arg_241_1.time_ and arg_241_1.time_ <= var_244_17 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				local var_244_19 = arg_241_1:FormatText(StoryNameCfg[1450].name)

				arg_241_1.leftNameTxt_.text = var_244_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_20 = arg_241_1:GetWordFromCfg(323121060)
				local var_244_21 = arg_241_1:FormatText(var_244_20.content)

				arg_241_1.text_.text = var_244_21

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_22 = 30
				local var_244_23 = utf8.len(var_244_21)
				local var_244_24 = var_244_22 <= 0 and var_244_18 or var_244_18 * (var_244_23 / var_244_22)

				if var_244_24 > 0 and var_244_18 < var_244_24 then
					arg_241_1.talkMaxDuration = var_244_24

					if var_244_24 + var_244_17 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_24 + var_244_17
					end
				end

				arg_241_1.text_.text = var_244_21
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323121", "323121060", "story_v_out_323121.awb") ~= 0 then
					local var_244_25 = manager.audio:GetVoiceLength("story_v_out_323121", "323121060", "story_v_out_323121.awb") / 1000

					if var_244_25 + var_244_17 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_25 + var_244_17
					end

					if var_244_20.prefab_name ~= "" and arg_241_1.actors_[var_244_20.prefab_name] ~= nil then
						local var_244_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_241_1.actors_[var_244_20.prefab_name].transform, "story_v_out_323121", "323121060", "story_v_out_323121.awb")

						arg_241_1:RecordAudio("323121060", var_244_26)
						arg_241_1:RecordAudio("323121060", var_244_26)
					else
						arg_241_1:AudioAction("play", "voice", "story_v_out_323121", "323121060", "story_v_out_323121.awb")
					end

					arg_241_1:RecordHistoryTalkVoice("story_v_out_323121", "323121060", "story_v_out_323121.awb")
				end

				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_27 = math.max(var_244_18, arg_241_1.talkMaxDuration)

			if var_244_17 <= arg_241_1.time_ and arg_241_1.time_ < var_244_17 + var_244_27 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_17) / var_244_27

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_17 + var_244_27 and arg_241_1.time_ < var_244_17 + var_244_27 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_241_1:InitPlayNodeList()
	end,
	Play323121061 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 323121061
		arg_245_1.duration_ = 5

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play323121062(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			local var_248_0 = arg_245_1.actors_["10170ui_story"]
			local var_248_1 = 0

			if var_248_1 < arg_245_1.time_ and arg_245_1.time_ <= var_248_1 + arg_248_0 and not isNil(var_248_0) and arg_245_1.var_.characterEffect10170ui_story == nil then
				arg_245_1.var_.characterEffect10170ui_story = var_248_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_248_2 = 0.200000002980232

			if var_248_1 <= arg_245_1.time_ and arg_245_1.time_ < var_248_1 + var_248_2 and not isNil(var_248_0) then
				local var_248_3 = (arg_245_1.time_ - var_248_1) / var_248_2

				if arg_245_1.var_.characterEffect10170ui_story and not isNil(var_248_0) then
					local var_248_4 = Mathf.Lerp(0, 0.5, var_248_3)

					arg_245_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_245_1.var_.characterEffect10170ui_story.fillRatio = var_248_4
				end
			end

			if arg_245_1.time_ >= var_248_1 + var_248_2 and arg_245_1.time_ < var_248_1 + var_248_2 + arg_248_0 and not isNil(var_248_0) and arg_245_1.var_.characterEffect10170ui_story then
				local var_248_5 = 0.5

				arg_245_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_245_1.var_.characterEffect10170ui_story.fillRatio = var_248_5
			end

			local var_248_6 = 0
			local var_248_7 = 0.775

			if var_248_6 < arg_245_1.time_ and arg_245_1.time_ <= var_248_6 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, true)

				local var_248_8 = arg_245_1:FormatText(StoryNameCfg[7].name)

				arg_245_1.leftNameTxt_.text = var_248_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, true)
				arg_245_1.iconController_:SetSelectedState("hero")

				arg_245_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_245_1.callingController_:SetSelectedState("normal")

				arg_245_1.keyicon_.color = Color.New(1, 1, 1)
				arg_245_1.icon_.color = Color.New(1, 1, 1)

				local var_248_9 = arg_245_1:GetWordFromCfg(323121061)
				local var_248_10 = arg_245_1:FormatText(var_248_9.content)

				arg_245_1.text_.text = var_248_10

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_11 = 31
				local var_248_12 = utf8.len(var_248_10)
				local var_248_13 = var_248_11 <= 0 and var_248_7 or var_248_7 * (var_248_12 / var_248_11)

				if var_248_13 > 0 and var_248_7 < var_248_13 then
					arg_245_1.talkMaxDuration = var_248_13

					if var_248_13 + var_248_6 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_13 + var_248_6
					end
				end

				arg_245_1.text_.text = var_248_10
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)
				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_14 = math.max(var_248_7, arg_245_1.talkMaxDuration)

			if var_248_6 <= arg_245_1.time_ and arg_245_1.time_ < var_248_6 + var_248_14 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_6) / var_248_14

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_6 + var_248_14 and arg_245_1.time_ < var_248_6 + var_248_14 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {}

		arg_245_1:InitPlayNodeList()
	end,
	Play323121062 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 323121062
		arg_249_1.duration_ = 4.07

		local var_249_0 = {
			zh = 3.133,
			ja = 4.066
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
				arg_249_0:Play323121063(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			local var_252_0 = arg_249_1.actors_["10170ui_story"]
			local var_252_1 = 0

			if var_252_1 < arg_249_1.time_ and arg_249_1.time_ <= var_252_1 + arg_252_0 and not isNil(var_252_0) and arg_249_1.var_.characterEffect10170ui_story == nil then
				arg_249_1.var_.characterEffect10170ui_story = var_252_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_252_2 = 0.200000002980232

			if var_252_1 <= arg_249_1.time_ and arg_249_1.time_ < var_252_1 + var_252_2 and not isNil(var_252_0) then
				local var_252_3 = (arg_249_1.time_ - var_252_1) / var_252_2

				if arg_249_1.var_.characterEffect10170ui_story and not isNil(var_252_0) then
					arg_249_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_249_1.time_ >= var_252_1 + var_252_2 and arg_249_1.time_ < var_252_1 + var_252_2 + arg_252_0 and not isNil(var_252_0) and arg_249_1.var_.characterEffect10170ui_story then
				arg_249_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_252_4 = 0
			local var_252_5 = 0.325

			if var_252_4 < arg_249_1.time_ and arg_249_1.time_ <= var_252_4 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				local var_252_6 = arg_249_1:FormatText(StoryNameCfg[1450].name)

				arg_249_1.leftNameTxt_.text = var_252_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_7 = arg_249_1:GetWordFromCfg(323121062)
				local var_252_8 = arg_249_1:FormatText(var_252_7.content)

				arg_249_1.text_.text = var_252_8

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_9 = 13
				local var_252_10 = utf8.len(var_252_8)
				local var_252_11 = var_252_9 <= 0 and var_252_5 or var_252_5 * (var_252_10 / var_252_9)

				if var_252_11 > 0 and var_252_5 < var_252_11 then
					arg_249_1.talkMaxDuration = var_252_11

					if var_252_11 + var_252_4 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_11 + var_252_4
					end
				end

				arg_249_1.text_.text = var_252_8
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323121", "323121062", "story_v_out_323121.awb") ~= 0 then
					local var_252_12 = manager.audio:GetVoiceLength("story_v_out_323121", "323121062", "story_v_out_323121.awb") / 1000

					if var_252_12 + var_252_4 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_12 + var_252_4
					end

					if var_252_7.prefab_name ~= "" and arg_249_1.actors_[var_252_7.prefab_name] ~= nil then
						local var_252_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_249_1.actors_[var_252_7.prefab_name].transform, "story_v_out_323121", "323121062", "story_v_out_323121.awb")

						arg_249_1:RecordAudio("323121062", var_252_13)
						arg_249_1:RecordAudio("323121062", var_252_13)
					else
						arg_249_1:AudioAction("play", "voice", "story_v_out_323121", "323121062", "story_v_out_323121.awb")
					end

					arg_249_1:RecordHistoryTalkVoice("story_v_out_323121", "323121062", "story_v_out_323121.awb")
				end

				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_14 = math.max(var_252_5, arg_249_1.talkMaxDuration)

			if var_252_4 <= arg_249_1.time_ and arg_249_1.time_ < var_252_4 + var_252_14 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_4) / var_252_14

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_4 + var_252_14 and arg_249_1.time_ < var_252_4 + var_252_14 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {}

		arg_249_1:InitPlayNodeList()
	end,
	Play323121063 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 323121063
		arg_253_1.duration_ = 6.43

		local var_253_0 = {
			zh = 5.2,
			ja = 6.433
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
				arg_253_0:Play323121064(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			local var_256_0 = arg_253_1.actors_["10170ui_story"]
			local var_256_1 = 0

			if var_256_1 < arg_253_1.time_ and arg_253_1.time_ <= var_256_1 + arg_256_0 and not isNil(var_256_0) and arg_253_1.var_.characterEffect10170ui_story == nil then
				arg_253_1.var_.characterEffect10170ui_story = var_256_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_256_2 = 0.200000002980232

			if var_256_1 <= arg_253_1.time_ and arg_253_1.time_ < var_256_1 + var_256_2 and not isNil(var_256_0) then
				local var_256_3 = (arg_253_1.time_ - var_256_1) / var_256_2

				if arg_253_1.var_.characterEffect10170ui_story and not isNil(var_256_0) then
					local var_256_4 = Mathf.Lerp(0, 0.5, var_256_3)

					arg_253_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_253_1.var_.characterEffect10170ui_story.fillRatio = var_256_4
				end
			end

			if arg_253_1.time_ >= var_256_1 + var_256_2 and arg_253_1.time_ < var_256_1 + var_256_2 + arg_256_0 and not isNil(var_256_0) and arg_253_1.var_.characterEffect10170ui_story then
				local var_256_5 = 0.5

				arg_253_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_253_1.var_.characterEffect10170ui_story.fillRatio = var_256_5
			end

			local var_256_6 = 0
			local var_256_7 = 0.525

			if var_256_6 < arg_253_1.time_ and arg_253_1.time_ <= var_256_6 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				local var_256_8 = arg_253_1:FormatText(StoryNameCfg[1454].name)

				arg_253_1.leftNameTxt_.text = var_256_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, true)
				arg_253_1.iconController_:SetSelectedState("hero")

				arg_253_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10169")

				arg_253_1.callingController_:SetSelectedState("normal")

				arg_253_1.keyicon_.color = Color.New(1, 1, 1)
				arg_253_1.icon_.color = Color.New(1, 1, 1)

				local var_256_9 = arg_253_1:GetWordFromCfg(323121063)
				local var_256_10 = arg_253_1:FormatText(var_256_9.content)

				arg_253_1.text_.text = var_256_10

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_11 = 21
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

				if manager.audio:GetVoiceLength("story_v_out_323121", "323121063", "story_v_out_323121.awb") ~= 0 then
					local var_256_14 = manager.audio:GetVoiceLength("story_v_out_323121", "323121063", "story_v_out_323121.awb") / 1000

					if var_256_14 + var_256_6 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_14 + var_256_6
					end

					if var_256_9.prefab_name ~= "" and arg_253_1.actors_[var_256_9.prefab_name] ~= nil then
						local var_256_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_253_1.actors_[var_256_9.prefab_name].transform, "story_v_out_323121", "323121063", "story_v_out_323121.awb")

						arg_253_1:RecordAudio("323121063", var_256_15)
						arg_253_1:RecordAudio("323121063", var_256_15)
					else
						arg_253_1:AudioAction("play", "voice", "story_v_out_323121", "323121063", "story_v_out_323121.awb")
					end

					arg_253_1:RecordHistoryTalkVoice("story_v_out_323121", "323121063", "story_v_out_323121.awb")
				end

				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_16 = math.max(var_256_7, arg_253_1.talkMaxDuration)

			if var_256_6 <= arg_253_1.time_ and arg_253_1.time_ < var_256_6 + var_256_16 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_6) / var_256_16

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_6 + var_256_16 and arg_253_1.time_ < var_256_6 + var_256_16 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {}

		arg_253_1:InitPlayNodeList()
	end,
	Play323121064 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 323121064
		arg_257_1.duration_ = 8.4

		local var_257_0 = {
			zh = 4.7,
			ja = 8.4
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
				arg_257_0:Play323121065(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			local var_260_0 = arg_257_1.actors_["10170ui_story"]
			local var_260_1 = 0

			if var_260_1 < arg_257_1.time_ and arg_257_1.time_ <= var_260_1 + arg_260_0 and not isNil(var_260_0) and arg_257_1.var_.characterEffect10170ui_story == nil then
				arg_257_1.var_.characterEffect10170ui_story = var_260_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_260_2 = 0.200000002980232

			if var_260_1 <= arg_257_1.time_ and arg_257_1.time_ < var_260_1 + var_260_2 and not isNil(var_260_0) then
				local var_260_3 = (arg_257_1.time_ - var_260_1) / var_260_2

				if arg_257_1.var_.characterEffect10170ui_story and not isNil(var_260_0) then
					arg_257_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_257_1.time_ >= var_260_1 + var_260_2 and arg_257_1.time_ < var_260_1 + var_260_2 + arg_260_0 and not isNil(var_260_0) and arg_257_1.var_.characterEffect10170ui_story then
				arg_257_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_260_4 = 0
			local var_260_5 = 0.4

			if var_260_4 < arg_257_1.time_ and arg_257_1.time_ <= var_260_4 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				local var_260_6 = arg_257_1:FormatText(StoryNameCfg[1450].name)

				arg_257_1.leftNameTxt_.text = var_260_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_7 = arg_257_1:GetWordFromCfg(323121064)
				local var_260_8 = arg_257_1:FormatText(var_260_7.content)

				arg_257_1.text_.text = var_260_8

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_9 = 16
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

				if manager.audio:GetVoiceLength("story_v_out_323121", "323121064", "story_v_out_323121.awb") ~= 0 then
					local var_260_12 = manager.audio:GetVoiceLength("story_v_out_323121", "323121064", "story_v_out_323121.awb") / 1000

					if var_260_12 + var_260_4 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_12 + var_260_4
					end

					if var_260_7.prefab_name ~= "" and arg_257_1.actors_[var_260_7.prefab_name] ~= nil then
						local var_260_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_257_1.actors_[var_260_7.prefab_name].transform, "story_v_out_323121", "323121064", "story_v_out_323121.awb")

						arg_257_1:RecordAudio("323121064", var_260_13)
						arg_257_1:RecordAudio("323121064", var_260_13)
					else
						arg_257_1:AudioAction("play", "voice", "story_v_out_323121", "323121064", "story_v_out_323121.awb")
					end

					arg_257_1:RecordHistoryTalkVoice("story_v_out_323121", "323121064", "story_v_out_323121.awb")
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
	Play323121065 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 323121065
		arg_261_1.duration_ = 2.33

		local var_261_0 = {
			zh = 1.366,
			ja = 2.333
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
				arg_261_0:Play323121066(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			local var_264_0 = arg_261_1.actors_["10170ui_story"]
			local var_264_1 = 0

			if var_264_1 < arg_261_1.time_ and arg_261_1.time_ <= var_264_1 + arg_264_0 and not isNil(var_264_0) and arg_261_1.var_.characterEffect10170ui_story == nil then
				arg_261_1.var_.characterEffect10170ui_story = var_264_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_264_2 = 0.200000002980232

			if var_264_1 <= arg_261_1.time_ and arg_261_1.time_ < var_264_1 + var_264_2 and not isNil(var_264_0) then
				local var_264_3 = (arg_261_1.time_ - var_264_1) / var_264_2

				if arg_261_1.var_.characterEffect10170ui_story and not isNil(var_264_0) then
					local var_264_4 = Mathf.Lerp(0, 0.5, var_264_3)

					arg_261_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_261_1.var_.characterEffect10170ui_story.fillRatio = var_264_4
				end
			end

			if arg_261_1.time_ >= var_264_1 + var_264_2 and arg_261_1.time_ < var_264_1 + var_264_2 + arg_264_0 and not isNil(var_264_0) and arg_261_1.var_.characterEffect10170ui_story then
				local var_264_5 = 0.5

				arg_261_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_261_1.var_.characterEffect10170ui_story.fillRatio = var_264_5
			end

			local var_264_6 = 0
			local var_264_7 = 0.075

			if var_264_6 < arg_261_1.time_ and arg_261_1.time_ <= var_264_6 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				local var_264_8 = arg_261_1:FormatText(StoryNameCfg[1454].name)

				arg_261_1.leftNameTxt_.text = var_264_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, true)
				arg_261_1.iconController_:SetSelectedState("hero")

				arg_261_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10169")

				arg_261_1.callingController_:SetSelectedState("normal")

				arg_261_1.keyicon_.color = Color.New(1, 1, 1)
				arg_261_1.icon_.color = Color.New(1, 1, 1)

				local var_264_9 = arg_261_1:GetWordFromCfg(323121065)
				local var_264_10 = arg_261_1:FormatText(var_264_9.content)

				arg_261_1.text_.text = var_264_10

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_11 = 3
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

				if manager.audio:GetVoiceLength("story_v_out_323121", "323121065", "story_v_out_323121.awb") ~= 0 then
					local var_264_14 = manager.audio:GetVoiceLength("story_v_out_323121", "323121065", "story_v_out_323121.awb") / 1000

					if var_264_14 + var_264_6 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_14 + var_264_6
					end

					if var_264_9.prefab_name ~= "" and arg_261_1.actors_[var_264_9.prefab_name] ~= nil then
						local var_264_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_261_1.actors_[var_264_9.prefab_name].transform, "story_v_out_323121", "323121065", "story_v_out_323121.awb")

						arg_261_1:RecordAudio("323121065", var_264_15)
						arg_261_1:RecordAudio("323121065", var_264_15)
					else
						arg_261_1:AudioAction("play", "voice", "story_v_out_323121", "323121065", "story_v_out_323121.awb")
					end

					arg_261_1:RecordHistoryTalkVoice("story_v_out_323121", "323121065", "story_v_out_323121.awb")
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
	Play323121066 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 323121066
		arg_265_1.duration_ = 5

		SetActive(arg_265_1.tipsGo_, false)

		function arg_265_1.onSingleLineFinish_()
			arg_265_1.onSingleLineUpdate_ = nil
			arg_265_1.onSingleLineFinish_ = nil
			arg_265_1.state_ = "waiting"
		end

		function arg_265_1.playNext_(arg_267_0)
			if arg_267_0 == 1 then
				arg_265_0:Play323121067(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			local var_268_0 = 0
			local var_268_1 = 0.425

			if var_268_0 < arg_265_1.time_ and arg_265_1.time_ <= var_268_0 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				local var_268_2 = arg_265_1:FormatText(StoryNameCfg[7].name)

				arg_265_1.leftNameTxt_.text = var_268_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, true)
				arg_265_1.iconController_:SetSelectedState("hero")

				arg_265_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_265_1.callingController_:SetSelectedState("normal")

				arg_265_1.keyicon_.color = Color.New(1, 1, 1)
				arg_265_1.icon_.color = Color.New(1, 1, 1)

				local var_268_3 = arg_265_1:GetWordFromCfg(323121066)
				local var_268_4 = arg_265_1:FormatText(var_268_3.content)

				arg_265_1.text_.text = var_268_4

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_5 = 17
				local var_268_6 = utf8.len(var_268_4)
				local var_268_7 = var_268_5 <= 0 and var_268_1 or var_268_1 * (var_268_6 / var_268_5)

				if var_268_7 > 0 and var_268_1 < var_268_7 then
					arg_265_1.talkMaxDuration = var_268_7

					if var_268_7 + var_268_0 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_7 + var_268_0
					end
				end

				arg_265_1.text_.text = var_268_4
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)
				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_8 = math.max(var_268_1, arg_265_1.talkMaxDuration)

			if var_268_0 <= arg_265_1.time_ and arg_265_1.time_ < var_268_0 + var_268_8 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_0) / var_268_8

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_0 + var_268_8 and arg_265_1.time_ < var_268_0 + var_268_8 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {}

		arg_265_1:InitPlayNodeList()
	end,
	Play323121067 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 323121067
		arg_269_1.duration_ = 2.3

		local var_269_0 = {
			zh = 1.999999999999,
			ja = 2.3
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
				arg_269_0:Play323121068(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			local var_272_0 = arg_269_1.actors_["1053ui_story"].transform
			local var_272_1 = 0

			if var_272_1 < arg_269_1.time_ and arg_269_1.time_ <= var_272_1 + arg_272_0 then
				arg_269_1.var_.moveOldPos1053ui_story = var_272_0.localPosition

				local var_272_2 = GameObjectTools.GetOrAddComponent(var_272_0.gameObject, typeof(DynamicBoneHelper))

				if var_272_2 then
					var_272_2:EnableDynamicBone(false)
				end
			end

			local var_272_3 = 0.001

			if var_272_1 <= arg_269_1.time_ and arg_269_1.time_ < var_272_1 + var_272_3 then
				local var_272_4 = (arg_269_1.time_ - var_272_1) / var_272_3
				local var_272_5 = Vector3.New(0, -1.08, -6)

				var_272_0.localPosition = Vector3.Lerp(arg_269_1.var_.moveOldPos1053ui_story, var_272_5, var_272_4)

				local var_272_6 = manager.ui.mainCamera.transform.position - var_272_0.position

				var_272_0.forward = Vector3.New(var_272_6.x, var_272_6.y, var_272_6.z)

				local var_272_7 = var_272_0.localEulerAngles

				var_272_7.z = 0
				var_272_7.x = 0
				var_272_0.localEulerAngles = var_272_7
			end

			if arg_269_1.time_ >= var_272_1 + var_272_3 and arg_269_1.time_ < var_272_1 + var_272_3 + arg_272_0 then
				var_272_0.localPosition = Vector3.New(0, -1.08, -6)

				local var_272_8 = manager.ui.mainCamera.transform.position - var_272_0.position

				var_272_0.forward = Vector3.New(var_272_8.x, var_272_8.y, var_272_8.z)

				local var_272_9 = var_272_0.localEulerAngles

				var_272_9.z = 0
				var_272_9.x = 0
				var_272_0.localEulerAngles = var_272_9

				local var_272_10 = GameObjectTools.GetOrAddComponent(var_272_0.gameObject, typeof(DynamicBoneHelper))

				if var_272_10 then
					var_272_10:EnableDynamicBone(true)
				end
			end

			local var_272_11 = arg_269_1.actors_["1053ui_story"]
			local var_272_12 = 0

			if var_272_12 < arg_269_1.time_ and arg_269_1.time_ <= var_272_12 + arg_272_0 and not isNil(var_272_11) and arg_269_1.var_.characterEffect1053ui_story == nil then
				arg_269_1.var_.characterEffect1053ui_story = var_272_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_272_13 = 0.200000002980232

			if var_272_12 <= arg_269_1.time_ and arg_269_1.time_ < var_272_12 + var_272_13 and not isNil(var_272_11) then
				local var_272_14 = (arg_269_1.time_ - var_272_12) / var_272_13

				if arg_269_1.var_.characterEffect1053ui_story and not isNil(var_272_11) then
					arg_269_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_269_1.time_ >= var_272_12 + var_272_13 and arg_269_1.time_ < var_272_12 + var_272_13 + arg_272_0 and not isNil(var_272_11) and arg_269_1.var_.characterEffect1053ui_story then
				arg_269_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_272_15 = 0

			if var_272_15 < arg_269_1.time_ and arg_269_1.time_ <= var_272_15 + arg_272_0 then
				arg_269_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053action/1053action1_1")
			end

			local var_272_16 = 0

			if var_272_16 < arg_269_1.time_ and arg_269_1.time_ <= var_272_16 + arg_272_0 then
				arg_269_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_272_17 = arg_269_1.actors_["10170ui_story"].transform
			local var_272_18 = 0

			if var_272_18 < arg_269_1.time_ and arg_269_1.time_ <= var_272_18 + arg_272_0 then
				arg_269_1.var_.moveOldPos10170ui_story = var_272_17.localPosition

				local var_272_19 = GameObjectTools.GetOrAddComponent(var_272_17.gameObject, typeof(DynamicBoneHelper))

				if var_272_19 then
					var_272_19:EnableDynamicBone(false)
				end
			end

			local var_272_20 = 0.001

			if var_272_18 <= arg_269_1.time_ and arg_269_1.time_ < var_272_18 + var_272_20 then
				local var_272_21 = (arg_269_1.time_ - var_272_18) / var_272_20
				local var_272_22 = Vector3.New(0, 100, 0)

				var_272_17.localPosition = Vector3.Lerp(arg_269_1.var_.moveOldPos10170ui_story, var_272_22, var_272_21)

				local var_272_23 = manager.ui.mainCamera.transform.position - var_272_17.position

				var_272_17.forward = Vector3.New(var_272_23.x, var_272_23.y, var_272_23.z)

				local var_272_24 = var_272_17.localEulerAngles

				var_272_24.z = 0
				var_272_24.x = 0
				var_272_17.localEulerAngles = var_272_24
			end

			if arg_269_1.time_ >= var_272_18 + var_272_20 and arg_269_1.time_ < var_272_18 + var_272_20 + arg_272_0 then
				var_272_17.localPosition = Vector3.New(0, 100, 0)

				local var_272_25 = manager.ui.mainCamera.transform.position - var_272_17.position

				var_272_17.forward = Vector3.New(var_272_25.x, var_272_25.y, var_272_25.z)

				local var_272_26 = var_272_17.localEulerAngles

				var_272_26.z = 0
				var_272_26.x = 0
				var_272_17.localEulerAngles = var_272_26

				local var_272_27 = GameObjectTools.GetOrAddComponent(var_272_17.gameObject, typeof(DynamicBoneHelper))

				if var_272_27 then
					var_272_27:EnableDynamicBone(true)
				end
			end

			local var_272_28 = 0
			local var_272_29 = 0.125

			if var_272_28 < arg_269_1.time_ and arg_269_1.time_ <= var_272_28 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				local var_272_30 = arg_269_1:FormatText(StoryNameCfg[1453].name)

				arg_269_1.leftNameTxt_.text = var_272_30

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_31 = arg_269_1:GetWordFromCfg(323121067)
				local var_272_32 = arg_269_1:FormatText(var_272_31.content)

				arg_269_1.text_.text = var_272_32

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_33 = 5
				local var_272_34 = utf8.len(var_272_32)
				local var_272_35 = var_272_33 <= 0 and var_272_29 or var_272_29 * (var_272_34 / var_272_33)

				if var_272_35 > 0 and var_272_29 < var_272_35 then
					arg_269_1.talkMaxDuration = var_272_35

					if var_272_35 + var_272_28 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_35 + var_272_28
					end
				end

				arg_269_1.text_.text = var_272_32
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323121", "323121067", "story_v_out_323121.awb") ~= 0 then
					local var_272_36 = manager.audio:GetVoiceLength("story_v_out_323121", "323121067", "story_v_out_323121.awb") / 1000

					if var_272_36 + var_272_28 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_36 + var_272_28
					end

					if var_272_31.prefab_name ~= "" and arg_269_1.actors_[var_272_31.prefab_name] ~= nil then
						local var_272_37 = LuaForUtil.PlayVoiceWithCriLipsync(arg_269_1.actors_[var_272_31.prefab_name].transform, "story_v_out_323121", "323121067", "story_v_out_323121.awb")

						arg_269_1:RecordAudio("323121067", var_272_37)
						arg_269_1:RecordAudio("323121067", var_272_37)
					else
						arg_269_1:AudioAction("play", "voice", "story_v_out_323121", "323121067", "story_v_out_323121.awb")
					end

					arg_269_1:RecordHistoryTalkVoice("story_v_out_323121", "323121067", "story_v_out_323121.awb")
				end

				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_38 = math.max(var_272_29, arg_269_1.talkMaxDuration)

			if var_272_28 <= arg_269_1.time_ and arg_269_1.time_ < var_272_28 + var_272_38 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_28) / var_272_38

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_28 + var_272_38 and arg_269_1.time_ < var_272_28 + var_272_38 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_269_1:InitPlayNodeList()
	end,
	Play323121068 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 323121068
		arg_273_1.duration_ = 5

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play323121069(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			local var_276_0 = arg_273_1.actors_["1053ui_story"]
			local var_276_1 = 0

			if var_276_1 < arg_273_1.time_ and arg_273_1.time_ <= var_276_1 + arg_276_0 and not isNil(var_276_0) and arg_273_1.var_.characterEffect1053ui_story == nil then
				arg_273_1.var_.characterEffect1053ui_story = var_276_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_276_2 = 0.200000002980232

			if var_276_1 <= arg_273_1.time_ and arg_273_1.time_ < var_276_1 + var_276_2 and not isNil(var_276_0) then
				local var_276_3 = (arg_273_1.time_ - var_276_1) / var_276_2

				if arg_273_1.var_.characterEffect1053ui_story and not isNil(var_276_0) then
					local var_276_4 = Mathf.Lerp(0, 0.5, var_276_3)

					arg_273_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_273_1.var_.characterEffect1053ui_story.fillRatio = var_276_4
				end
			end

			if arg_273_1.time_ >= var_276_1 + var_276_2 and arg_273_1.time_ < var_276_1 + var_276_2 + arg_276_0 and not isNil(var_276_0) and arg_273_1.var_.characterEffect1053ui_story then
				local var_276_5 = 0.5

				arg_273_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_273_1.var_.characterEffect1053ui_story.fillRatio = var_276_5
			end

			local var_276_6 = 0
			local var_276_7 = 0.925

			if var_276_6 < arg_273_1.time_ and arg_273_1.time_ <= var_276_6 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, true)

				local var_276_8 = arg_273_1:FormatText(StoryNameCfg[7].name)

				arg_273_1.leftNameTxt_.text = var_276_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, true)
				arg_273_1.iconController_:SetSelectedState("hero")

				arg_273_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_273_1.callingController_:SetSelectedState("normal")

				arg_273_1.keyicon_.color = Color.New(1, 1, 1)
				arg_273_1.icon_.color = Color.New(1, 1, 1)

				local var_276_9 = arg_273_1:GetWordFromCfg(323121068)
				local var_276_10 = arg_273_1:FormatText(var_276_9.content)

				arg_273_1.text_.text = var_276_10

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_11 = 37
				local var_276_12 = utf8.len(var_276_10)
				local var_276_13 = var_276_11 <= 0 and var_276_7 or var_276_7 * (var_276_12 / var_276_11)

				if var_276_13 > 0 and var_276_7 < var_276_13 then
					arg_273_1.talkMaxDuration = var_276_13

					if var_276_13 + var_276_6 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_13 + var_276_6
					end
				end

				arg_273_1.text_.text = var_276_10
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)
				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_14 = math.max(var_276_7, arg_273_1.talkMaxDuration)

			if var_276_6 <= arg_273_1.time_ and arg_273_1.time_ < var_276_6 + var_276_14 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_6) / var_276_14

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_6 + var_276_14 and arg_273_1.time_ < var_276_6 + var_276_14 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {}

		arg_273_1:InitPlayNodeList()
	end,
	Play323121069 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 323121069
		arg_277_1.duration_ = 4.3

		local var_277_0 = {
			zh = 4.3,
			ja = 4.266
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
				arg_277_0:Play323121070(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			local var_280_0 = arg_277_1.actors_["1053ui_story"]
			local var_280_1 = 0

			if var_280_1 < arg_277_1.time_ and arg_277_1.time_ <= var_280_1 + arg_280_0 and not isNil(var_280_0) and arg_277_1.var_.characterEffect1053ui_story == nil then
				arg_277_1.var_.characterEffect1053ui_story = var_280_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_280_2 = 0.200000002980232

			if var_280_1 <= arg_277_1.time_ and arg_277_1.time_ < var_280_1 + var_280_2 and not isNil(var_280_0) then
				local var_280_3 = (arg_277_1.time_ - var_280_1) / var_280_2

				if arg_277_1.var_.characterEffect1053ui_story and not isNil(var_280_0) then
					arg_277_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_277_1.time_ >= var_280_1 + var_280_2 and arg_277_1.time_ < var_280_1 + var_280_2 + arg_280_0 and not isNil(var_280_0) and arg_277_1.var_.characterEffect1053ui_story then
				arg_277_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_280_4 = 0

			if var_280_4 < arg_277_1.time_ and arg_277_1.time_ <= var_280_4 + arg_280_0 then
				arg_277_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053action/1053action5_1")
			end

			local var_280_5 = 0

			if var_280_5 < arg_277_1.time_ and arg_277_1.time_ <= var_280_5 + arg_280_0 then
				arg_277_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_280_6 = 0
			local var_280_7 = 0.35

			if var_280_6 < arg_277_1.time_ and arg_277_1.time_ <= var_280_6 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				local var_280_8 = arg_277_1:FormatText(StoryNameCfg[1453].name)

				arg_277_1.leftNameTxt_.text = var_280_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_9 = arg_277_1:GetWordFromCfg(323121069)
				local var_280_10 = arg_277_1:FormatText(var_280_9.content)

				arg_277_1.text_.text = var_280_10

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_11 = 14
				local var_280_12 = utf8.len(var_280_10)
				local var_280_13 = var_280_11 <= 0 and var_280_7 or var_280_7 * (var_280_12 / var_280_11)

				if var_280_13 > 0 and var_280_7 < var_280_13 then
					arg_277_1.talkMaxDuration = var_280_13

					if var_280_13 + var_280_6 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_13 + var_280_6
					end
				end

				arg_277_1.text_.text = var_280_10
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323121", "323121069", "story_v_out_323121.awb") ~= 0 then
					local var_280_14 = manager.audio:GetVoiceLength("story_v_out_323121", "323121069", "story_v_out_323121.awb") / 1000

					if var_280_14 + var_280_6 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_14 + var_280_6
					end

					if var_280_9.prefab_name ~= "" and arg_277_1.actors_[var_280_9.prefab_name] ~= nil then
						local var_280_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_277_1.actors_[var_280_9.prefab_name].transform, "story_v_out_323121", "323121069", "story_v_out_323121.awb")

						arg_277_1:RecordAudio("323121069", var_280_15)
						arg_277_1:RecordAudio("323121069", var_280_15)
					else
						arg_277_1:AudioAction("play", "voice", "story_v_out_323121", "323121069", "story_v_out_323121.awb")
					end

					arg_277_1:RecordHistoryTalkVoice("story_v_out_323121", "323121069", "story_v_out_323121.awb")
				end

				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_16 = math.max(var_280_7, arg_277_1.talkMaxDuration)

			if var_280_6 <= arg_277_1.time_ and arg_277_1.time_ < var_280_6 + var_280_16 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_6) / var_280_16

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_6 + var_280_16 and arg_277_1.time_ < var_280_6 + var_280_16 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {}

		arg_277_1:InitPlayNodeList()
	end,
	Play323121070 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 323121070
		arg_281_1.duration_ = 5

		SetActive(arg_281_1.tipsGo_, false)

		function arg_281_1.onSingleLineFinish_()
			arg_281_1.onSingleLineUpdate_ = nil
			arg_281_1.onSingleLineFinish_ = nil
			arg_281_1.state_ = "waiting"
		end

		function arg_281_1.playNext_(arg_283_0)
			if arg_283_0 == 1 then
				arg_281_0:Play323121071(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			local var_284_0 = arg_281_1.actors_["1053ui_story"]
			local var_284_1 = 0

			if var_284_1 < arg_281_1.time_ and arg_281_1.time_ <= var_284_1 + arg_284_0 and not isNil(var_284_0) and arg_281_1.var_.characterEffect1053ui_story == nil then
				arg_281_1.var_.characterEffect1053ui_story = var_284_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_284_2 = 0.200000002980232

			if var_284_1 <= arg_281_1.time_ and arg_281_1.time_ < var_284_1 + var_284_2 and not isNil(var_284_0) then
				local var_284_3 = (arg_281_1.time_ - var_284_1) / var_284_2

				if arg_281_1.var_.characterEffect1053ui_story and not isNil(var_284_0) then
					local var_284_4 = Mathf.Lerp(0, 0.5, var_284_3)

					arg_281_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_281_1.var_.characterEffect1053ui_story.fillRatio = var_284_4
				end
			end

			if arg_281_1.time_ >= var_284_1 + var_284_2 and arg_281_1.time_ < var_284_1 + var_284_2 + arg_284_0 and not isNil(var_284_0) and arg_281_1.var_.characterEffect1053ui_story then
				local var_284_5 = 0.5

				arg_281_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_281_1.var_.characterEffect1053ui_story.fillRatio = var_284_5
			end

			local var_284_6 = 0
			local var_284_7 = 1.6

			if var_284_6 < arg_281_1.time_ and arg_281_1.time_ <= var_284_6 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, false)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_8 = arg_281_1:GetWordFromCfg(323121070)
				local var_284_9 = arg_281_1:FormatText(var_284_8.content)

				arg_281_1.text_.text = var_284_9

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_10 = 64
				local var_284_11 = utf8.len(var_284_9)
				local var_284_12 = var_284_10 <= 0 and var_284_7 or var_284_7 * (var_284_11 / var_284_10)

				if var_284_12 > 0 and var_284_7 < var_284_12 then
					arg_281_1.talkMaxDuration = var_284_12

					if var_284_12 + var_284_6 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_12 + var_284_6
					end
				end

				arg_281_1.text_.text = var_284_9
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)
				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_13 = math.max(var_284_7, arg_281_1.talkMaxDuration)

			if var_284_6 <= arg_281_1.time_ and arg_281_1.time_ < var_284_6 + var_284_13 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_6) / var_284_13

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_6 + var_284_13 and arg_281_1.time_ < var_284_6 + var_284_13 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {}

		arg_281_1:InitPlayNodeList()
	end,
	Play323121071 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 323121071
		arg_285_1.duration_ = 5

		SetActive(arg_285_1.tipsGo_, false)

		function arg_285_1.onSingleLineFinish_()
			arg_285_1.onSingleLineUpdate_ = nil
			arg_285_1.onSingleLineFinish_ = nil
			arg_285_1.state_ = "waiting"
		end

		function arg_285_1.playNext_(arg_287_0)
			if arg_287_0 == 1 then
				arg_285_0:Play323121072(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			local var_288_0 = 0
			local var_288_1 = 1.05

			if var_288_0 < arg_285_1.time_ and arg_285_1.time_ <= var_288_0 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, false)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_2 = arg_285_1:GetWordFromCfg(323121071)
				local var_288_3 = arg_285_1:FormatText(var_288_2.content)

				arg_285_1.text_.text = var_288_3

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_4 = 42
				local var_288_5 = utf8.len(var_288_3)
				local var_288_6 = var_288_4 <= 0 and var_288_1 or var_288_1 * (var_288_5 / var_288_4)

				if var_288_6 > 0 and var_288_1 < var_288_6 then
					arg_285_1.talkMaxDuration = var_288_6

					if var_288_6 + var_288_0 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_6 + var_288_0
					end
				end

				arg_285_1.text_.text = var_288_3
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)
				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_7 = math.max(var_288_1, arg_285_1.talkMaxDuration)

			if var_288_0 <= arg_285_1.time_ and arg_285_1.time_ < var_288_0 + var_288_7 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_0) / var_288_7

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_0 + var_288_7 and arg_285_1.time_ < var_288_0 + var_288_7 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {}

		arg_285_1:InitPlayNodeList()
	end,
	Play323121072 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 323121072
		arg_289_1.duration_ = 12.67

		local var_289_0 = {
			zh = 11.666,
			ja = 12.666
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
				arg_289_0:Play323121073(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			local var_292_0 = "ST12"

			if arg_289_1.bgs_[var_292_0] == nil then
				local var_292_1 = Object.Instantiate(arg_289_1.paintGo_)

				var_292_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_292_0)
				var_292_1.name = var_292_0
				var_292_1.transform.parent = arg_289_1.stage_.transform
				var_292_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_289_1.bgs_[var_292_0] = var_292_1
			end

			local var_292_2 = 1.4

			if var_292_2 < arg_289_1.time_ and arg_289_1.time_ <= var_292_2 + arg_292_0 then
				local var_292_3 = manager.ui.mainCamera.transform.localPosition
				local var_292_4 = Vector3.New(0, 0, 10) + Vector3.New(var_292_3.x, var_292_3.y, 0)
				local var_292_5 = arg_289_1.bgs_.ST12

				var_292_5.transform.localPosition = var_292_4
				var_292_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_292_6 = var_292_5:GetComponent("SpriteRenderer")

				if var_292_6 and var_292_6.sprite then
					local var_292_7 = (var_292_5.transform.localPosition - var_292_3).z
					local var_292_8 = manager.ui.mainCameraCom_
					local var_292_9 = 2 * var_292_7 * Mathf.Tan(var_292_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_292_10 = var_292_9 * var_292_8.aspect
					local var_292_11 = var_292_6.sprite.bounds.size.x
					local var_292_12 = var_292_6.sprite.bounds.size.y
					local var_292_13 = var_292_10 / var_292_11
					local var_292_14 = var_292_9 / var_292_12
					local var_292_15 = var_292_14 < var_292_13 and var_292_13 or var_292_14

					var_292_5.transform.localScale = Vector3.New(var_292_15, var_292_15, 0)
				end

				for iter_292_0, iter_292_1 in pairs(arg_289_1.bgs_) do
					if iter_292_0 ~= "ST12" then
						iter_292_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_292_16 = 0

			if var_292_16 < arg_289_1.time_ and arg_289_1.time_ <= var_292_16 + arg_292_0 then
				arg_289_1.allBtn_.enabled = false
			end

			local var_292_17 = 0.3

			if arg_289_1.time_ >= var_292_16 + var_292_17 and arg_289_1.time_ < var_292_16 + var_292_17 + arg_292_0 then
				arg_289_1.allBtn_.enabled = true
			end

			local var_292_18 = 0

			if var_292_18 < arg_289_1.time_ and arg_289_1.time_ <= var_292_18 + arg_292_0 then
				arg_289_1.mask_.enabled = true
				arg_289_1.mask_.raycastTarget = true

				arg_289_1:SetGaussion(false)
			end

			local var_292_19 = 1.4

			if var_292_18 <= arg_289_1.time_ and arg_289_1.time_ < var_292_18 + var_292_19 then
				local var_292_20 = (arg_289_1.time_ - var_292_18) / var_292_19
				local var_292_21 = Color.New(0, 0, 0)

				var_292_21.a = Mathf.Lerp(0, 1, var_292_20)
				arg_289_1.mask_.color = var_292_21
			end

			if arg_289_1.time_ >= var_292_18 + var_292_19 and arg_289_1.time_ < var_292_18 + var_292_19 + arg_292_0 then
				local var_292_22 = Color.New(0, 0, 0)

				var_292_22.a = 1
				arg_289_1.mask_.color = var_292_22
			end

			local var_292_23 = 1.4

			if var_292_23 < arg_289_1.time_ and arg_289_1.time_ <= var_292_23 + arg_292_0 then
				arg_289_1.mask_.enabled = true
				arg_289_1.mask_.raycastTarget = true

				arg_289_1:SetGaussion(false)
			end

			local var_292_24 = 1.7666666696469

			if var_292_23 <= arg_289_1.time_ and arg_289_1.time_ < var_292_23 + var_292_24 then
				local var_292_25 = (arg_289_1.time_ - var_292_23) / var_292_24
				local var_292_26 = Color.New(0, 0, 0)

				var_292_26.a = Mathf.Lerp(1, 0, var_292_25)
				arg_289_1.mask_.color = var_292_26
			end

			if arg_289_1.time_ >= var_292_23 + var_292_24 and arg_289_1.time_ < var_292_23 + var_292_24 + arg_292_0 then
				local var_292_27 = Color.New(0, 0, 0)
				local var_292_28 = 0

				arg_289_1.mask_.enabled = false
				var_292_27.a = var_292_28
				arg_289_1.mask_.color = var_292_27
			end

			local var_292_29 = arg_289_1.actors_["1053ui_story"].transform
			local var_292_30 = 1.4

			if var_292_30 < arg_289_1.time_ and arg_289_1.time_ <= var_292_30 + arg_292_0 then
				arg_289_1.var_.moveOldPos1053ui_story = var_292_29.localPosition

				local var_292_31 = GameObjectTools.GetOrAddComponent(var_292_29.gameObject, typeof(DynamicBoneHelper))

				if var_292_31 then
					var_292_31:EnableDynamicBone(false)
				end
			end

			local var_292_32 = 0.001

			if var_292_30 <= arg_289_1.time_ and arg_289_1.time_ < var_292_30 + var_292_32 then
				local var_292_33 = (arg_289_1.time_ - var_292_30) / var_292_32
				local var_292_34 = Vector3.New(0, 100, 0)

				var_292_29.localPosition = Vector3.Lerp(arg_289_1.var_.moveOldPos1053ui_story, var_292_34, var_292_33)

				local var_292_35 = manager.ui.mainCamera.transform.position - var_292_29.position

				var_292_29.forward = Vector3.New(var_292_35.x, var_292_35.y, var_292_35.z)

				local var_292_36 = var_292_29.localEulerAngles

				var_292_36.z = 0
				var_292_36.x = 0
				var_292_29.localEulerAngles = var_292_36
			end

			if arg_289_1.time_ >= var_292_30 + var_292_32 and arg_289_1.time_ < var_292_30 + var_292_32 + arg_292_0 then
				var_292_29.localPosition = Vector3.New(0, 100, 0)

				local var_292_37 = manager.ui.mainCamera.transform.position - var_292_29.position

				var_292_29.forward = Vector3.New(var_292_37.x, var_292_37.y, var_292_37.z)

				local var_292_38 = var_292_29.localEulerAngles

				var_292_38.z = 0
				var_292_38.x = 0
				var_292_29.localEulerAngles = var_292_38

				local var_292_39 = GameObjectTools.GetOrAddComponent(var_292_29.gameObject, typeof(DynamicBoneHelper))

				if var_292_39 then
					var_292_39:EnableDynamicBone(true)
				end
			end

			local var_292_40 = "1019ui_story"

			if arg_289_1.actors_[var_292_40] == nil then
				local var_292_41 = Asset.Load("Char/" .. "1019ui_story")

				if not isNil(var_292_41) then
					local var_292_42 = Object.Instantiate(Asset.Load("Char/" .. "1019ui_story"), arg_289_1.stage_.transform)

					var_292_42.name = var_292_40
					var_292_42.transform.localPosition = Vector3.New(0, 100, 0)
					arg_289_1.actors_[var_292_40] = var_292_42

					local var_292_43 = var_292_42:GetComponentInChildren(typeof(CharacterEffect))

					var_292_43.enabled = true

					local var_292_44 = GameObjectTools.GetOrAddComponent(var_292_42, typeof(DynamicBoneHelper))

					if var_292_44 then
						var_292_44:EnableDynamicBone(false)
					end

					arg_289_1:ShowWeapon(var_292_43.transform, false)

					arg_289_1.var_[var_292_40 .. "Animator"] = var_292_43.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_289_1.var_[var_292_40 .. "Animator"].applyRootMotion = true
					arg_289_1.var_[var_292_40 .. "LipSync"] = var_292_43.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_292_45 = arg_289_1.actors_["1019ui_story"].transform
			local var_292_46 = 2.96666666666667

			if var_292_46 < arg_289_1.time_ and arg_289_1.time_ <= var_292_46 + arg_292_0 then
				arg_289_1.var_.moveOldPos1019ui_story = var_292_45.localPosition
			end

			local var_292_47 = 0.001

			if var_292_46 <= arg_289_1.time_ and arg_289_1.time_ < var_292_46 + var_292_47 then
				local var_292_48 = (arg_289_1.time_ - var_292_46) / var_292_47
				local var_292_49 = Vector3.New(-0.2, -1.08, -5.9)

				var_292_45.localPosition = Vector3.Lerp(arg_289_1.var_.moveOldPos1019ui_story, var_292_49, var_292_48)

				local var_292_50 = manager.ui.mainCamera.transform.position - var_292_45.position

				var_292_45.forward = Vector3.New(var_292_50.x, var_292_50.y, var_292_50.z)

				local var_292_51 = var_292_45.localEulerAngles

				var_292_51.z = 0
				var_292_51.x = 0
				var_292_45.localEulerAngles = var_292_51
			end

			if arg_289_1.time_ >= var_292_46 + var_292_47 and arg_289_1.time_ < var_292_46 + var_292_47 + arg_292_0 then
				var_292_45.localPosition = Vector3.New(-0.2, -1.08, -5.9)

				local var_292_52 = manager.ui.mainCamera.transform.position - var_292_45.position

				var_292_45.forward = Vector3.New(var_292_52.x, var_292_52.y, var_292_52.z)

				local var_292_53 = var_292_45.localEulerAngles

				var_292_53.z = 0
				var_292_53.x = 0
				var_292_45.localEulerAngles = var_292_53
			end

			local var_292_54 = arg_289_1.actors_["1019ui_story"]
			local var_292_55 = 2.96666666666667

			if var_292_55 < arg_289_1.time_ and arg_289_1.time_ <= var_292_55 + arg_292_0 and not isNil(var_292_54) and arg_289_1.var_.characterEffect1019ui_story == nil then
				arg_289_1.var_.characterEffect1019ui_story = var_292_54:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_292_56 = 0.200000002980232

			if var_292_55 <= arg_289_1.time_ and arg_289_1.time_ < var_292_55 + var_292_56 and not isNil(var_292_54) then
				local var_292_57 = (arg_289_1.time_ - var_292_55) / var_292_56

				if arg_289_1.var_.characterEffect1019ui_story and not isNil(var_292_54) then
					arg_289_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_289_1.time_ >= var_292_55 + var_292_56 and arg_289_1.time_ < var_292_55 + var_292_56 + arg_292_0 and not isNil(var_292_54) and arg_289_1.var_.characterEffect1019ui_story then
				arg_289_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_292_58 = 2.96666666666667

			if var_292_58 < arg_289_1.time_ and arg_289_1.time_ <= var_292_58 + arg_292_0 then
				arg_289_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action2_1")
			end

			local var_292_59 = 2.96666666666667

			if var_292_59 < arg_289_1.time_ and arg_289_1.time_ <= var_292_59 + arg_292_0 then
				arg_289_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_292_60 = 1.4

			arg_289_1.isInRecall_ = false

			if var_292_60 < arg_289_1.time_ and arg_289_1.time_ <= var_292_60 + arg_292_0 then
				arg_289_1.screenFilterGo_:SetActive(true)

				arg_289_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile.asset")

				for iter_292_2, iter_292_3 in pairs(arg_289_1.actors_) do
					local var_292_61 = iter_292_3:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_292_4, iter_292_5 in ipairs(var_292_61) do
						if iter_292_5.color.r > 0.51 then
							iter_292_5.color = Color.New(1, 1, 1)
						else
							iter_292_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_292_62 = 0.0166666666666667

			if var_292_60 <= arg_289_1.time_ and arg_289_1.time_ < var_292_60 + var_292_62 then
				local var_292_63 = (arg_289_1.time_ - var_292_60) / var_292_62

				arg_289_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, var_292_63)
			end

			if arg_289_1.time_ >= var_292_60 + var_292_62 and arg_289_1.time_ < var_292_60 + var_292_62 + arg_292_0 then
				arg_289_1.screenFilterEffect_.weight = 1
			end

			local var_292_64 = 0.166666666666667
			local var_292_65 = 1

			if var_292_64 < arg_289_1.time_ and arg_289_1.time_ <= var_292_64 + arg_292_0 then
				local var_292_66 = "stop"
				local var_292_67 = "effect"

				arg_289_1:AudioAction(var_292_66, var_292_67, "se_story_148", "se_story_148_amb_ice_cave", "")
			end

			local var_292_68 = 1.16666666666667
			local var_292_69 = 1

			if var_292_68 < arg_289_1.time_ and arg_289_1.time_ <= var_292_68 + arg_292_0 then
				local var_292_70 = "play"
				local var_292_71 = "effect"

				arg_289_1:AudioAction(var_292_70, var_292_71, "se_story_121_04", "se_story_121_04_officeambience_loop", "")
			end

			if arg_289_1.frameCnt_ <= 1 then
				arg_289_1.dialog_:SetActive(false)
			end

			local var_292_72 = 3.4
			local var_292_73 = 0.875

			if var_292_72 < arg_289_1.time_ and arg_289_1.time_ <= var_292_72 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0

				arg_289_1.dialog_:SetActive(true)

				arg_289_1.dialogCg_.alpha = 0

				local var_292_74 = LeanTween.value(arg_289_1.dialog_, 0, 1, 0.3)

				var_292_74:setOnUpdate(LuaHelper.FloatAction(function(arg_293_0)
					arg_289_1.dialogCg_.alpha = arg_293_0
				end))
				var_292_74:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_289_1.dialog_)
					var_292_74:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_289_1.duration_ = arg_289_1.duration_ + 0.3

				SetActive(arg_289_1.leftNameGo_, true)

				local var_292_75 = arg_289_1:FormatText(StoryNameCfg[13].name)

				arg_289_1.leftNameTxt_.text = var_292_75

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, false)
				arg_289_1.callingController_:SetSelectedState("normal")

				local var_292_76 = arg_289_1:GetWordFromCfg(323121072)
				local var_292_77 = arg_289_1:FormatText(var_292_76.content)

				arg_289_1.text_.text = var_292_77

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_78 = 35
				local var_292_79 = utf8.len(var_292_77)
				local var_292_80 = var_292_78 <= 0 and var_292_73 or var_292_73 * (var_292_79 / var_292_78)

				if var_292_80 > 0 and var_292_73 < var_292_80 then
					arg_289_1.talkMaxDuration = var_292_80
					var_292_72 = var_292_72 + 0.3

					if var_292_80 + var_292_72 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_80 + var_292_72
					end
				end

				arg_289_1.text_.text = var_292_77
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323121", "323121072", "story_v_out_323121.awb") ~= 0 then
					local var_292_81 = manager.audio:GetVoiceLength("story_v_out_323121", "323121072", "story_v_out_323121.awb") / 1000

					if var_292_81 + var_292_72 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_81 + var_292_72
					end

					if var_292_76.prefab_name ~= "" and arg_289_1.actors_[var_292_76.prefab_name] ~= nil then
						local var_292_82 = LuaForUtil.PlayVoiceWithCriLipsync(arg_289_1.actors_[var_292_76.prefab_name].transform, "story_v_out_323121", "323121072", "story_v_out_323121.awb")

						arg_289_1:RecordAudio("323121072", var_292_82)
						arg_289_1:RecordAudio("323121072", var_292_82)
					else
						arg_289_1:AudioAction("play", "voice", "story_v_out_323121", "323121072", "story_v_out_323121.awb")
					end

					arg_289_1:RecordHistoryTalkVoice("story_v_out_323121", "323121072", "story_v_out_323121.awb")
				end

				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_83 = var_292_72 + 0.3
			local var_292_84 = math.max(var_292_73, arg_289_1.talkMaxDuration)

			if var_292_83 <= arg_289_1.time_ and arg_289_1.time_ < var_292_83 + var_292_84 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - var_292_83) / var_292_84

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= var_292_83 + var_292_84 and arg_289_1.time_ < var_292_83 + var_292_84 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 1.4,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2.96666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_289_1:InitPlayNodeList()
	end,
	Play323121073 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 323121073
		arg_295_1.duration_ = 5

		SetActive(arg_295_1.tipsGo_, false)

		function arg_295_1.onSingleLineFinish_()
			arg_295_1.onSingleLineUpdate_ = nil
			arg_295_1.onSingleLineFinish_ = nil
			arg_295_1.state_ = "waiting"
		end

		function arg_295_1.playNext_(arg_297_0)
			if arg_297_0 == 1 then
				arg_295_0:Play323121074(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			local var_298_0 = arg_295_1.actors_["1019ui_story"]
			local var_298_1 = 0

			if var_298_1 < arg_295_1.time_ and arg_295_1.time_ <= var_298_1 + arg_298_0 and not isNil(var_298_0) and arg_295_1.var_.characterEffect1019ui_story == nil then
				arg_295_1.var_.characterEffect1019ui_story = var_298_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_298_2 = 0.200000002980232

			if var_298_1 <= arg_295_1.time_ and arg_295_1.time_ < var_298_1 + var_298_2 and not isNil(var_298_0) then
				local var_298_3 = (arg_295_1.time_ - var_298_1) / var_298_2

				if arg_295_1.var_.characterEffect1019ui_story and not isNil(var_298_0) then
					local var_298_4 = Mathf.Lerp(0, 0.5, var_298_3)

					arg_295_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_295_1.var_.characterEffect1019ui_story.fillRatio = var_298_4
				end
			end

			if arg_295_1.time_ >= var_298_1 + var_298_2 and arg_295_1.time_ < var_298_1 + var_298_2 + arg_298_0 and not isNil(var_298_0) and arg_295_1.var_.characterEffect1019ui_story then
				local var_298_5 = 0.5

				arg_295_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_295_1.var_.characterEffect1019ui_story.fillRatio = var_298_5
			end

			local var_298_6 = 0
			local var_298_7 = 0.375

			if var_298_6 < arg_295_1.time_ and arg_295_1.time_ <= var_298_6 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, true)

				local var_298_8 = arg_295_1:FormatText(StoryNameCfg[7].name)

				arg_295_1.leftNameTxt_.text = var_298_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_295_1.leftNameTxt_.transform)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1.leftNameTxt_.text)
				SetActive(arg_295_1.iconTrs_.gameObject, true)
				arg_295_1.iconController_:SetSelectedState("hero")

				arg_295_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_295_1.callingController_:SetSelectedState("normal")

				arg_295_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_295_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_298_9 = arg_295_1:GetWordFromCfg(323121073)
				local var_298_10 = arg_295_1:FormatText(var_298_9.content)

				arg_295_1.text_.text = var_298_10

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_11 = 15
				local var_298_12 = utf8.len(var_298_10)
				local var_298_13 = var_298_11 <= 0 and var_298_7 or var_298_7 * (var_298_12 / var_298_11)

				if var_298_13 > 0 and var_298_7 < var_298_13 then
					arg_295_1.talkMaxDuration = var_298_13

					if var_298_13 + var_298_6 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_13 + var_298_6
					end
				end

				arg_295_1.text_.text = var_298_10
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)
				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_14 = math.max(var_298_7, arg_295_1.talkMaxDuration)

			if var_298_6 <= arg_295_1.time_ and arg_295_1.time_ < var_298_6 + var_298_14 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - var_298_6) / var_298_14

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= var_298_6 + var_298_14 and arg_295_1.time_ < var_298_6 + var_298_14 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {}

		arg_295_1:InitPlayNodeList()
	end,
	Play323121074 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 323121074
		arg_299_1.duration_ = 5.9

		local var_299_0 = {
			zh = 4.133,
			ja = 5.9
		}
		local var_299_1 = manager.audio:GetLocalizationFlag()

		if var_299_0[var_299_1] ~= nil then
			arg_299_1.duration_ = var_299_0[var_299_1]
		end

		SetActive(arg_299_1.tipsGo_, false)

		function arg_299_1.onSingleLineFinish_()
			arg_299_1.onSingleLineUpdate_ = nil
			arg_299_1.onSingleLineFinish_ = nil
			arg_299_1.state_ = "waiting"
		end

		function arg_299_1.playNext_(arg_301_0)
			if arg_301_0 == 1 then
				arg_299_0:Play323121075(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			local var_302_0 = arg_299_1.actors_["1019ui_story"]
			local var_302_1 = 0

			if var_302_1 < arg_299_1.time_ and arg_299_1.time_ <= var_302_1 + arg_302_0 and not isNil(var_302_0) and arg_299_1.var_.characterEffect1019ui_story == nil then
				arg_299_1.var_.characterEffect1019ui_story = var_302_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_302_2 = 0.200000002980232

			if var_302_1 <= arg_299_1.time_ and arg_299_1.time_ < var_302_1 + var_302_2 and not isNil(var_302_0) then
				local var_302_3 = (arg_299_1.time_ - var_302_1) / var_302_2

				if arg_299_1.var_.characterEffect1019ui_story and not isNil(var_302_0) then
					arg_299_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_299_1.time_ >= var_302_1 + var_302_2 and arg_299_1.time_ < var_302_1 + var_302_2 + arg_302_0 and not isNil(var_302_0) and arg_299_1.var_.characterEffect1019ui_story then
				arg_299_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_302_4 = 0

			if var_302_4 < arg_299_1.time_ and arg_299_1.time_ <= var_302_4 + arg_302_0 then
				arg_299_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action2_2")
			end

			local var_302_5 = 0

			if var_302_5 < arg_299_1.time_ and arg_299_1.time_ <= var_302_5 + arg_302_0 then
				arg_299_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_302_6 = 0
			local var_302_7 = 0.525

			if var_302_6 < arg_299_1.time_ and arg_299_1.time_ <= var_302_6 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0
				arg_299_1.dialogCg_.alpha = 1

				arg_299_1.dialog_:SetActive(true)
				SetActive(arg_299_1.leftNameGo_, true)

				local var_302_8 = arg_299_1:FormatText(StoryNameCfg[13].name)

				arg_299_1.leftNameTxt_.text = var_302_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_299_1.leftNameTxt_.transform)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1.leftNameTxt_.text)
				SetActive(arg_299_1.iconTrs_.gameObject, false)
				arg_299_1.callingController_:SetSelectedState("normal")

				local var_302_9 = arg_299_1:GetWordFromCfg(323121074)
				local var_302_10 = arg_299_1:FormatText(var_302_9.content)

				arg_299_1.text_.text = var_302_10

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_11 = 21
				local var_302_12 = utf8.len(var_302_10)
				local var_302_13 = var_302_11 <= 0 and var_302_7 or var_302_7 * (var_302_12 / var_302_11)

				if var_302_13 > 0 and var_302_7 < var_302_13 then
					arg_299_1.talkMaxDuration = var_302_13

					if var_302_13 + var_302_6 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_13 + var_302_6
					end
				end

				arg_299_1.text_.text = var_302_10
				arg_299_1.typewritter.percent = 0

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323121", "323121074", "story_v_out_323121.awb") ~= 0 then
					local var_302_14 = manager.audio:GetVoiceLength("story_v_out_323121", "323121074", "story_v_out_323121.awb") / 1000

					if var_302_14 + var_302_6 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_14 + var_302_6
					end

					if var_302_9.prefab_name ~= "" and arg_299_1.actors_[var_302_9.prefab_name] ~= nil then
						local var_302_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_299_1.actors_[var_302_9.prefab_name].transform, "story_v_out_323121", "323121074", "story_v_out_323121.awb")

						arg_299_1:RecordAudio("323121074", var_302_15)
						arg_299_1:RecordAudio("323121074", var_302_15)
					else
						arg_299_1:AudioAction("play", "voice", "story_v_out_323121", "323121074", "story_v_out_323121.awb")
					end

					arg_299_1:RecordHistoryTalkVoice("story_v_out_323121", "323121074", "story_v_out_323121.awb")
				end

				arg_299_1:RecordContent(arg_299_1.text_.text)
			end

			local var_302_16 = math.max(var_302_7, arg_299_1.talkMaxDuration)

			if var_302_6 <= arg_299_1.time_ and arg_299_1.time_ < var_302_6 + var_302_16 then
				arg_299_1.typewritter.percent = (arg_299_1.time_ - var_302_6) / var_302_16

				arg_299_1.typewritter:SetDirty()
			end

			if arg_299_1.time_ >= var_302_6 + var_302_16 and arg_299_1.time_ < var_302_6 + var_302_16 + arg_302_0 then
				arg_299_1.typewritter.percent = 1

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(true)
			end
		end

		arg_299_1.nodeConfigList_ = {}

		arg_299_1:InitPlayNodeList()
	end,
	Play323121075 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 323121075
		arg_303_1.duration_ = 15.53

		local var_303_0 = {
			zh = 11.0663333333333,
			ja = 15.5333333333333
		}
		local var_303_1 = manager.audio:GetLocalizationFlag()

		if var_303_0[var_303_1] ~= nil then
			arg_303_1.duration_ = var_303_0[var_303_1]
		end

		SetActive(arg_303_1.tipsGo_, false)

		function arg_303_1.onSingleLineFinish_()
			arg_303_1.onSingleLineUpdate_ = nil
			arg_303_1.onSingleLineFinish_ = nil
			arg_303_1.state_ = "waiting"
		end

		function arg_303_1.playNext_(arg_305_0)
			if arg_305_0 == 1 then
				arg_303_0:Play323121076(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			local var_306_0 = 2

			if var_306_0 < arg_303_1.time_ and arg_303_1.time_ <= var_306_0 + arg_306_0 then
				local var_306_1 = manager.ui.mainCamera.transform.localPosition
				local var_306_2 = Vector3.New(0, 0, 10) + Vector3.New(var_306_1.x, var_306_1.y, 0)
				local var_306_3 = arg_303_1.bgs_.ST2005

				var_306_3.transform.localPosition = var_306_2
				var_306_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_306_4 = var_306_3:GetComponent("SpriteRenderer")

				if var_306_4 and var_306_4.sprite then
					local var_306_5 = (var_306_3.transform.localPosition - var_306_1).z
					local var_306_6 = manager.ui.mainCameraCom_
					local var_306_7 = 2 * var_306_5 * Mathf.Tan(var_306_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_306_8 = var_306_7 * var_306_6.aspect
					local var_306_9 = var_306_4.sprite.bounds.size.x
					local var_306_10 = var_306_4.sprite.bounds.size.y
					local var_306_11 = var_306_8 / var_306_9
					local var_306_12 = var_306_7 / var_306_10
					local var_306_13 = var_306_12 < var_306_11 and var_306_11 or var_306_12

					var_306_3.transform.localScale = Vector3.New(var_306_13, var_306_13, 0)
				end

				for iter_306_0, iter_306_1 in pairs(arg_303_1.bgs_) do
					if iter_306_0 ~= "ST2005" then
						iter_306_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_306_14 = 0

			if var_306_14 < arg_303_1.time_ and arg_303_1.time_ <= var_306_14 + arg_306_0 then
				arg_303_1.allBtn_.enabled = false
			end

			local var_306_15 = 0.3

			if arg_303_1.time_ >= var_306_14 + var_306_15 and arg_303_1.time_ < var_306_14 + var_306_15 + arg_306_0 then
				arg_303_1.allBtn_.enabled = true
			end

			local var_306_16 = 0

			if var_306_16 < arg_303_1.time_ and arg_303_1.time_ <= var_306_16 + arg_306_0 then
				arg_303_1.mask_.enabled = true
				arg_303_1.mask_.raycastTarget = true

				arg_303_1:SetGaussion(false)
			end

			local var_306_17 = 2

			if var_306_16 <= arg_303_1.time_ and arg_303_1.time_ < var_306_16 + var_306_17 then
				local var_306_18 = (arg_303_1.time_ - var_306_16) / var_306_17
				local var_306_19 = Color.New(0, 0, 0)

				var_306_19.a = Mathf.Lerp(0, 1, var_306_18)
				arg_303_1.mask_.color = var_306_19
			end

			if arg_303_1.time_ >= var_306_16 + var_306_17 and arg_303_1.time_ < var_306_16 + var_306_17 + arg_306_0 then
				local var_306_20 = Color.New(0, 0, 0)

				var_306_20.a = 1
				arg_303_1.mask_.color = var_306_20
			end

			local var_306_21 = 2

			if var_306_21 < arg_303_1.time_ and arg_303_1.time_ <= var_306_21 + arg_306_0 then
				arg_303_1.mask_.enabled = true
				arg_303_1.mask_.raycastTarget = true

				arg_303_1:SetGaussion(false)
			end

			local var_306_22 = 1.63333333631357

			if var_306_21 <= arg_303_1.time_ and arg_303_1.time_ < var_306_21 + var_306_22 then
				local var_306_23 = (arg_303_1.time_ - var_306_21) / var_306_22
				local var_306_24 = Color.New(0, 0, 0)

				var_306_24.a = Mathf.Lerp(1, 0, var_306_23)
				arg_303_1.mask_.color = var_306_24
			end

			if arg_303_1.time_ >= var_306_21 + var_306_22 and arg_303_1.time_ < var_306_21 + var_306_22 + arg_306_0 then
				local var_306_25 = Color.New(0, 0, 0)
				local var_306_26 = 0

				arg_303_1.mask_.enabled = false
				var_306_25.a = var_306_26
				arg_303_1.mask_.color = var_306_25
			end

			local var_306_27 = arg_303_1.actors_["1019ui_story"].transform
			local var_306_28 = 2

			if var_306_28 < arg_303_1.time_ and arg_303_1.time_ <= var_306_28 + arg_306_0 then
				arg_303_1.var_.moveOldPos1019ui_story = var_306_27.localPosition
			end

			local var_306_29 = 0.001

			if var_306_28 <= arg_303_1.time_ and arg_303_1.time_ < var_306_28 + var_306_29 then
				local var_306_30 = (arg_303_1.time_ - var_306_28) / var_306_29
				local var_306_31 = Vector3.New(0, 100, 0)

				var_306_27.localPosition = Vector3.Lerp(arg_303_1.var_.moveOldPos1019ui_story, var_306_31, var_306_30)

				local var_306_32 = manager.ui.mainCamera.transform.position - var_306_27.position

				var_306_27.forward = Vector3.New(var_306_32.x, var_306_32.y, var_306_32.z)

				local var_306_33 = var_306_27.localEulerAngles

				var_306_33.z = 0
				var_306_33.x = 0
				var_306_27.localEulerAngles = var_306_33
			end

			if arg_303_1.time_ >= var_306_28 + var_306_29 and arg_303_1.time_ < var_306_28 + var_306_29 + arg_306_0 then
				var_306_27.localPosition = Vector3.New(0, 100, 0)

				local var_306_34 = manager.ui.mainCamera.transform.position - var_306_27.position

				var_306_27.forward = Vector3.New(var_306_34.x, var_306_34.y, var_306_34.z)

				local var_306_35 = var_306_27.localEulerAngles

				var_306_35.z = 0
				var_306_35.x = 0
				var_306_27.localEulerAngles = var_306_35
			end

			local var_306_36 = arg_303_1.actors_["1053ui_story"].transform
			local var_306_37 = 3.43333333333333

			if var_306_37 < arg_303_1.time_ and arg_303_1.time_ <= var_306_37 + arg_306_0 then
				arg_303_1.var_.moveOldPos1053ui_story = var_306_36.localPosition

				local var_306_38 = GameObjectTools.GetOrAddComponent(var_306_36.gameObject, typeof(DynamicBoneHelper))

				if var_306_38 then
					var_306_38:EnableDynamicBone(false)
				end
			end

			local var_306_39 = 0.001

			if var_306_37 <= arg_303_1.time_ and arg_303_1.time_ < var_306_37 + var_306_39 then
				local var_306_40 = (arg_303_1.time_ - var_306_37) / var_306_39
				local var_306_41 = Vector3.New(0, -1.08, -6)

				var_306_36.localPosition = Vector3.Lerp(arg_303_1.var_.moveOldPos1053ui_story, var_306_41, var_306_40)

				local var_306_42 = manager.ui.mainCamera.transform.position - var_306_36.position

				var_306_36.forward = Vector3.New(var_306_42.x, var_306_42.y, var_306_42.z)

				local var_306_43 = var_306_36.localEulerAngles

				var_306_43.z = 0
				var_306_43.x = 0
				var_306_36.localEulerAngles = var_306_43
			end

			if arg_303_1.time_ >= var_306_37 + var_306_39 and arg_303_1.time_ < var_306_37 + var_306_39 + arg_306_0 then
				var_306_36.localPosition = Vector3.New(0, -1.08, -6)

				local var_306_44 = manager.ui.mainCamera.transform.position - var_306_36.position

				var_306_36.forward = Vector3.New(var_306_44.x, var_306_44.y, var_306_44.z)

				local var_306_45 = var_306_36.localEulerAngles

				var_306_45.z = 0
				var_306_45.x = 0
				var_306_36.localEulerAngles = var_306_45

				local var_306_46 = GameObjectTools.GetOrAddComponent(var_306_36.gameObject, typeof(DynamicBoneHelper))

				if var_306_46 then
					var_306_46:EnableDynamicBone(true)
				end
			end

			local var_306_47 = arg_303_1.actors_["1053ui_story"]
			local var_306_48 = 3.43333333333333

			if var_306_48 < arg_303_1.time_ and arg_303_1.time_ <= var_306_48 + arg_306_0 and not isNil(var_306_47) and arg_303_1.var_.characterEffect1053ui_story == nil then
				arg_303_1.var_.characterEffect1053ui_story = var_306_47:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_306_49 = 0.200000002980232

			if var_306_48 <= arg_303_1.time_ and arg_303_1.time_ < var_306_48 + var_306_49 and not isNil(var_306_47) then
				local var_306_50 = (arg_303_1.time_ - var_306_48) / var_306_49

				if arg_303_1.var_.characterEffect1053ui_story and not isNil(var_306_47) then
					arg_303_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_303_1.time_ >= var_306_48 + var_306_49 and arg_303_1.time_ < var_306_48 + var_306_49 + arg_306_0 and not isNil(var_306_47) and arg_303_1.var_.characterEffect1053ui_story then
				arg_303_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_306_51 = arg_303_1.actors_["1019ui_story"]
			local var_306_52 = 3.43333333333333

			if var_306_52 < arg_303_1.time_ and arg_303_1.time_ <= var_306_52 + arg_306_0 and not isNil(var_306_51) and arg_303_1.var_.characterEffect1019ui_story == nil then
				arg_303_1.var_.characterEffect1019ui_story = var_306_51:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_306_53 = 0.200000002980232

			if var_306_52 <= arg_303_1.time_ and arg_303_1.time_ < var_306_52 + var_306_53 and not isNil(var_306_51) then
				local var_306_54 = (arg_303_1.time_ - var_306_52) / var_306_53

				if arg_303_1.var_.characterEffect1019ui_story and not isNil(var_306_51) then
					local var_306_55 = Mathf.Lerp(0, 0.5, var_306_54)

					arg_303_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_303_1.var_.characterEffect1019ui_story.fillRatio = var_306_55
				end
			end

			if arg_303_1.time_ >= var_306_52 + var_306_53 and arg_303_1.time_ < var_306_52 + var_306_53 + arg_306_0 and not isNil(var_306_51) and arg_303_1.var_.characterEffect1019ui_story then
				local var_306_56 = 0.5

				arg_303_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_303_1.var_.characterEffect1019ui_story.fillRatio = var_306_56
			end

			local var_306_57 = 3.43333333333333

			if var_306_57 < arg_303_1.time_ and arg_303_1.time_ <= var_306_57 + arg_306_0 then
				arg_303_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053action/1053action5_2")
			end

			local var_306_58 = 3.43333333333333

			if var_306_58 < arg_303_1.time_ and arg_303_1.time_ <= var_306_58 + arg_306_0 then
				arg_303_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_306_59 = 2.01666666666667

			arg_303_1.isInRecall_ = false

			if var_306_59 < arg_303_1.time_ and arg_303_1.time_ <= var_306_59 + arg_306_0 then
				arg_303_1.screenFilterGo_:SetActive(false)

				for iter_306_2, iter_306_3 in pairs(arg_303_1.actors_) do
					local var_306_60 = iter_306_3:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_306_4, iter_306_5 in ipairs(var_306_60) do
						if iter_306_5.color.r > 0.51 then
							iter_306_5.color = Color.New(1, 1, 1)
						else
							iter_306_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_306_61 = 0.0166666666666667

			if var_306_59 <= arg_303_1.time_ and arg_303_1.time_ < var_306_59 + var_306_61 then
				local var_306_62 = (arg_303_1.time_ - var_306_59) / var_306_61

				arg_303_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, var_306_62)
			end

			if arg_303_1.time_ >= var_306_59 + var_306_61 and arg_303_1.time_ < var_306_59 + var_306_61 + arg_306_0 then
				arg_303_1.screenFilterEffect_.weight = 0
			end

			local var_306_63 = 0.233333333333333
			local var_306_64 = 1

			if var_306_63 < arg_303_1.time_ and arg_303_1.time_ <= var_306_63 + arg_306_0 then
				local var_306_65 = "stop"
				local var_306_66 = "effect"

				arg_303_1:AudioAction(var_306_65, var_306_66, "se_story_121_04", "se_story_121_04_officeambience_loop", "")
			end

			local var_306_67 = 1.63333333333333
			local var_306_68 = 1

			if var_306_67 < arg_303_1.time_ and arg_303_1.time_ <= var_306_67 + arg_306_0 then
				local var_306_69 = "play"
				local var_306_70 = "effect"

				arg_303_1:AudioAction(var_306_69, var_306_70, "se_story_148", "se_story_148_amb_ice_cave", "")
			end

			if arg_303_1.frameCnt_ <= 1 then
				arg_303_1.dialog_:SetActive(false)
			end

			local var_306_71 = 3.53333333333333
			local var_306_72 = 0.925

			if var_306_71 < arg_303_1.time_ and arg_303_1.time_ <= var_306_71 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0

				arg_303_1.dialog_:SetActive(true)

				arg_303_1.dialogCg_.alpha = 0

				local var_306_73 = LeanTween.value(arg_303_1.dialog_, 0, 1, 0.3)

				var_306_73:setOnUpdate(LuaHelper.FloatAction(function(arg_307_0)
					arg_303_1.dialogCg_.alpha = arg_307_0
				end))
				var_306_73:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_303_1.dialog_)
					var_306_73:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_303_1.duration_ = arg_303_1.duration_ + 0.3

				SetActive(arg_303_1.leftNameGo_, true)

				local var_306_74 = arg_303_1:FormatText(StoryNameCfg[1453].name)

				arg_303_1.leftNameTxt_.text = var_306_74

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_303_1.leftNameTxt_.transform)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1.leftNameTxt_.text)
				SetActive(arg_303_1.iconTrs_.gameObject, false)
				arg_303_1.callingController_:SetSelectedState("normal")

				local var_306_75 = arg_303_1:GetWordFromCfg(323121075)
				local var_306_76 = arg_303_1:FormatText(var_306_75.content)

				arg_303_1.text_.text = var_306_76

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_77 = 37
				local var_306_78 = utf8.len(var_306_76)
				local var_306_79 = var_306_77 <= 0 and var_306_72 or var_306_72 * (var_306_78 / var_306_77)

				if var_306_79 > 0 and var_306_72 < var_306_79 then
					arg_303_1.talkMaxDuration = var_306_79
					var_306_71 = var_306_71 + 0.3

					if var_306_79 + var_306_71 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_79 + var_306_71
					end
				end

				arg_303_1.text_.text = var_306_76
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323121", "323121075", "story_v_out_323121.awb") ~= 0 then
					local var_306_80 = manager.audio:GetVoiceLength("story_v_out_323121", "323121075", "story_v_out_323121.awb") / 1000

					if var_306_80 + var_306_71 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_80 + var_306_71
					end

					if var_306_75.prefab_name ~= "" and arg_303_1.actors_[var_306_75.prefab_name] ~= nil then
						local var_306_81 = LuaForUtil.PlayVoiceWithCriLipsync(arg_303_1.actors_[var_306_75.prefab_name].transform, "story_v_out_323121", "323121075", "story_v_out_323121.awb")

						arg_303_1:RecordAudio("323121075", var_306_81)
						arg_303_1:RecordAudio("323121075", var_306_81)
					else
						arg_303_1:AudioAction("play", "voice", "story_v_out_323121", "323121075", "story_v_out_323121.awb")
					end

					arg_303_1:RecordHistoryTalkVoice("story_v_out_323121", "323121075", "story_v_out_323121.awb")
				end

				arg_303_1:RecordContent(arg_303_1.text_.text)
			end

			local var_306_82 = var_306_71 + 0.3
			local var_306_83 = math.max(var_306_72, arg_303_1.talkMaxDuration)

			if var_306_82 <= arg_303_1.time_ and arg_303_1.time_ < var_306_82 + var_306_83 then
				arg_303_1.typewritter.percent = (arg_303_1.time_ - var_306_82) / var_306_83

				arg_303_1.typewritter:SetDirty()
			end

			if arg_303_1.time_ >= var_306_82 + var_306_83 and arg_303_1.time_ < var_306_82 + var_306_83 + arg_306_0 then
				arg_303_1.typewritter.percent = 1

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(true)
			end
		end

		arg_303_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0333333333333332,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.43333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_303_1:InitPlayNodeList()
	end,
	Play323121076 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 323121076
		arg_309_1.duration_ = 5

		SetActive(arg_309_1.tipsGo_, false)

		function arg_309_1.onSingleLineFinish_()
			arg_309_1.onSingleLineUpdate_ = nil
			arg_309_1.onSingleLineFinish_ = nil
			arg_309_1.state_ = "waiting"
		end

		function arg_309_1.playNext_(arg_311_0)
			if arg_311_0 == 1 then
				arg_309_0:Play323121077(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			local var_312_0 = arg_309_1.actors_["1053ui_story"]
			local var_312_1 = 0

			if var_312_1 < arg_309_1.time_ and arg_309_1.time_ <= var_312_1 + arg_312_0 and not isNil(var_312_0) and arg_309_1.var_.characterEffect1053ui_story == nil then
				arg_309_1.var_.characterEffect1053ui_story = var_312_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_312_2 = 0.200000002980232

			if var_312_1 <= arg_309_1.time_ and arg_309_1.time_ < var_312_1 + var_312_2 and not isNil(var_312_0) then
				local var_312_3 = (arg_309_1.time_ - var_312_1) / var_312_2

				if arg_309_1.var_.characterEffect1053ui_story and not isNil(var_312_0) then
					local var_312_4 = Mathf.Lerp(0, 0.5, var_312_3)

					arg_309_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_309_1.var_.characterEffect1053ui_story.fillRatio = var_312_4
				end
			end

			if arg_309_1.time_ >= var_312_1 + var_312_2 and arg_309_1.time_ < var_312_1 + var_312_2 + arg_312_0 and not isNil(var_312_0) and arg_309_1.var_.characterEffect1053ui_story then
				local var_312_5 = 0.5

				arg_309_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_309_1.var_.characterEffect1053ui_story.fillRatio = var_312_5
			end

			local var_312_6 = 0
			local var_312_7 = 0.875

			if var_312_6 < arg_309_1.time_ and arg_309_1.time_ <= var_312_6 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, true)

				local var_312_8 = arg_309_1:FormatText(StoryNameCfg[7].name)

				arg_309_1.leftNameTxt_.text = var_312_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_309_1.leftNameTxt_.transform)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1.leftNameTxt_.text)
				SetActive(arg_309_1.iconTrs_.gameObject, true)
				arg_309_1.iconController_:SetSelectedState("hero")

				arg_309_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_309_1.callingController_:SetSelectedState("normal")

				arg_309_1.keyicon_.color = Color.New(1, 1, 1)
				arg_309_1.icon_.color = Color.New(1, 1, 1)

				local var_312_9 = arg_309_1:GetWordFromCfg(323121076)
				local var_312_10 = arg_309_1:FormatText(var_312_9.content)

				arg_309_1.text_.text = var_312_10

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_11 = 35
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
				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_14 = math.max(var_312_7, arg_309_1.talkMaxDuration)

			if var_312_6 <= arg_309_1.time_ and arg_309_1.time_ < var_312_6 + var_312_14 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - var_312_6) / var_312_14

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= var_312_6 + var_312_14 and arg_309_1.time_ < var_312_6 + var_312_14 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {}

		arg_309_1:InitPlayNodeList()
	end,
	Play323121077 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 323121077
		arg_313_1.duration_ = 13.6

		local var_313_0 = {
			zh = 9.933,
			ja = 13.6
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
				arg_313_0:Play323121078(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			local var_316_0 = arg_313_1.actors_["1053ui_story"]
			local var_316_1 = 0

			if var_316_1 < arg_313_1.time_ and arg_313_1.time_ <= var_316_1 + arg_316_0 and not isNil(var_316_0) and arg_313_1.var_.characterEffect1053ui_story == nil then
				arg_313_1.var_.characterEffect1053ui_story = var_316_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_316_2 = 0.200000002980232

			if var_316_1 <= arg_313_1.time_ and arg_313_1.time_ < var_316_1 + var_316_2 and not isNil(var_316_0) then
				local var_316_3 = (arg_313_1.time_ - var_316_1) / var_316_2

				if arg_313_1.var_.characterEffect1053ui_story and not isNil(var_316_0) then
					arg_313_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_313_1.time_ >= var_316_1 + var_316_2 and arg_313_1.time_ < var_316_1 + var_316_2 + arg_316_0 and not isNil(var_316_0) and arg_313_1.var_.characterEffect1053ui_story then
				arg_313_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_316_4 = 0
			local var_316_5 = 1.1

			if var_316_4 < arg_313_1.time_ and arg_313_1.time_ <= var_316_4 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, true)

				local var_316_6 = arg_313_1:FormatText(StoryNameCfg[1453].name)

				arg_313_1.leftNameTxt_.text = var_316_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_313_1.leftNameTxt_.transform)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1.leftNameTxt_.text)
				SetActive(arg_313_1.iconTrs_.gameObject, false)
				arg_313_1.callingController_:SetSelectedState("normal")

				local var_316_7 = arg_313_1:GetWordFromCfg(323121077)
				local var_316_8 = arg_313_1:FormatText(var_316_7.content)

				arg_313_1.text_.text = var_316_8

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_9 = 44
				local var_316_10 = utf8.len(var_316_8)
				local var_316_11 = var_316_9 <= 0 and var_316_5 or var_316_5 * (var_316_10 / var_316_9)

				if var_316_11 > 0 and var_316_5 < var_316_11 then
					arg_313_1.talkMaxDuration = var_316_11

					if var_316_11 + var_316_4 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_11 + var_316_4
					end
				end

				arg_313_1.text_.text = var_316_8
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323121", "323121077", "story_v_out_323121.awb") ~= 0 then
					local var_316_12 = manager.audio:GetVoiceLength("story_v_out_323121", "323121077", "story_v_out_323121.awb") / 1000

					if var_316_12 + var_316_4 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_12 + var_316_4
					end

					if var_316_7.prefab_name ~= "" and arg_313_1.actors_[var_316_7.prefab_name] ~= nil then
						local var_316_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_313_1.actors_[var_316_7.prefab_name].transform, "story_v_out_323121", "323121077", "story_v_out_323121.awb")

						arg_313_1:RecordAudio("323121077", var_316_13)
						arg_313_1:RecordAudio("323121077", var_316_13)
					else
						arg_313_1:AudioAction("play", "voice", "story_v_out_323121", "323121077", "story_v_out_323121.awb")
					end

					arg_313_1:RecordHistoryTalkVoice("story_v_out_323121", "323121077", "story_v_out_323121.awb")
				end

				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_14 = math.max(var_316_5, arg_313_1.talkMaxDuration)

			if var_316_4 <= arg_313_1.time_ and arg_313_1.time_ < var_316_4 + var_316_14 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_4) / var_316_14

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_4 + var_316_14 and arg_313_1.time_ < var_316_4 + var_316_14 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {}

		arg_313_1:InitPlayNodeList()
	end,
	Play323121078 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 323121078
		arg_317_1.duration_ = 6.57

		local var_317_0 = {
			zh = 4.7,
			ja = 6.566
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
				arg_317_0:Play323121079(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			local var_320_0 = arg_317_1.actors_["1053ui_story"].transform
			local var_320_1 = 0

			if var_320_1 < arg_317_1.time_ and arg_317_1.time_ <= var_320_1 + arg_320_0 then
				arg_317_1.var_.moveOldPos1053ui_story = var_320_0.localPosition

				local var_320_2 = GameObjectTools.GetOrAddComponent(var_320_0.gameObject, typeof(DynamicBoneHelper))

				if var_320_2 then
					var_320_2:EnableDynamicBone(false)
				end
			end

			local var_320_3 = 0.001

			if var_320_1 <= arg_317_1.time_ and arg_317_1.time_ < var_320_1 + var_320_3 then
				local var_320_4 = (arg_317_1.time_ - var_320_1) / var_320_3
				local var_320_5 = Vector3.New(0, 100, 0)

				var_320_0.localPosition = Vector3.Lerp(arg_317_1.var_.moveOldPos1053ui_story, var_320_5, var_320_4)

				local var_320_6 = manager.ui.mainCamera.transform.position - var_320_0.position

				var_320_0.forward = Vector3.New(var_320_6.x, var_320_6.y, var_320_6.z)

				local var_320_7 = var_320_0.localEulerAngles

				var_320_7.z = 0
				var_320_7.x = 0
				var_320_0.localEulerAngles = var_320_7
			end

			if arg_317_1.time_ >= var_320_1 + var_320_3 and arg_317_1.time_ < var_320_1 + var_320_3 + arg_320_0 then
				var_320_0.localPosition = Vector3.New(0, 100, 0)

				local var_320_8 = manager.ui.mainCamera.transform.position - var_320_0.position

				var_320_0.forward = Vector3.New(var_320_8.x, var_320_8.y, var_320_8.z)

				local var_320_9 = var_320_0.localEulerAngles

				var_320_9.z = 0
				var_320_9.x = 0
				var_320_0.localEulerAngles = var_320_9

				local var_320_10 = GameObjectTools.GetOrAddComponent(var_320_0.gameObject, typeof(DynamicBoneHelper))

				if var_320_10 then
					var_320_10:EnableDynamicBone(true)
				end
			end

			local var_320_11 = arg_317_1.actors_["10170ui_story"].transform
			local var_320_12 = 0

			if var_320_12 < arg_317_1.time_ and arg_317_1.time_ <= var_320_12 + arg_320_0 then
				arg_317_1.var_.moveOldPos10170ui_story = var_320_11.localPosition

				local var_320_13 = GameObjectTools.GetOrAddComponent(var_320_11.gameObject, typeof(DynamicBoneHelper))

				if var_320_13 then
					var_320_13:EnableDynamicBone(false)
				end
			end

			local var_320_14 = 0.001

			if var_320_12 <= arg_317_1.time_ and arg_317_1.time_ < var_320_12 + var_320_14 then
				local var_320_15 = (arg_317_1.time_ - var_320_12) / var_320_14
				local var_320_16 = Vector3.New(0, -1.03, -6.05)

				var_320_11.localPosition = Vector3.Lerp(arg_317_1.var_.moveOldPos10170ui_story, var_320_16, var_320_15)

				local var_320_17 = manager.ui.mainCamera.transform.position - var_320_11.position

				var_320_11.forward = Vector3.New(var_320_17.x, var_320_17.y, var_320_17.z)

				local var_320_18 = var_320_11.localEulerAngles

				var_320_18.z = 0
				var_320_18.x = 0
				var_320_11.localEulerAngles = var_320_18
			end

			if arg_317_1.time_ >= var_320_12 + var_320_14 and arg_317_1.time_ < var_320_12 + var_320_14 + arg_320_0 then
				var_320_11.localPosition = Vector3.New(0, -1.03, -6.05)

				local var_320_19 = manager.ui.mainCamera.transform.position - var_320_11.position

				var_320_11.forward = Vector3.New(var_320_19.x, var_320_19.y, var_320_19.z)

				local var_320_20 = var_320_11.localEulerAngles

				var_320_20.z = 0
				var_320_20.x = 0
				var_320_11.localEulerAngles = var_320_20

				local var_320_21 = GameObjectTools.GetOrAddComponent(var_320_11.gameObject, typeof(DynamicBoneHelper))

				if var_320_21 then
					var_320_21:EnableDynamicBone(true)
				end
			end

			local var_320_22 = arg_317_1.actors_["10170ui_story"]
			local var_320_23 = 0

			if var_320_23 < arg_317_1.time_ and arg_317_1.time_ <= var_320_23 + arg_320_0 and not isNil(var_320_22) and arg_317_1.var_.characterEffect10170ui_story == nil then
				arg_317_1.var_.characterEffect10170ui_story = var_320_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_320_24 = 0.200000002980232

			if var_320_23 <= arg_317_1.time_ and arg_317_1.time_ < var_320_23 + var_320_24 and not isNil(var_320_22) then
				local var_320_25 = (arg_317_1.time_ - var_320_23) / var_320_24

				if arg_317_1.var_.characterEffect10170ui_story and not isNil(var_320_22) then
					arg_317_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_317_1.time_ >= var_320_23 + var_320_24 and arg_317_1.time_ < var_320_23 + var_320_24 + arg_320_0 and not isNil(var_320_22) and arg_317_1.var_.characterEffect10170ui_story then
				arg_317_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_320_26 = arg_317_1.actors_["1053ui_story"]
			local var_320_27 = 0

			if var_320_27 < arg_317_1.time_ and arg_317_1.time_ <= var_320_27 + arg_320_0 and not isNil(var_320_26) and arg_317_1.var_.characterEffect1053ui_story == nil then
				arg_317_1.var_.characterEffect1053ui_story = var_320_26:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_320_28 = 0.200000002980232

			if var_320_27 <= arg_317_1.time_ and arg_317_1.time_ < var_320_27 + var_320_28 and not isNil(var_320_26) then
				local var_320_29 = (arg_317_1.time_ - var_320_27) / var_320_28

				if arg_317_1.var_.characterEffect1053ui_story and not isNil(var_320_26) then
					local var_320_30 = Mathf.Lerp(0, 0.5, var_320_29)

					arg_317_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_317_1.var_.characterEffect1053ui_story.fillRatio = var_320_30
				end
			end

			if arg_317_1.time_ >= var_320_27 + var_320_28 and arg_317_1.time_ < var_320_27 + var_320_28 + arg_320_0 and not isNil(var_320_26) and arg_317_1.var_.characterEffect1053ui_story then
				local var_320_31 = 0.5

				arg_317_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_317_1.var_.characterEffect1053ui_story.fillRatio = var_320_31
			end

			local var_320_32 = 0

			if var_320_32 < arg_317_1.time_ and arg_317_1.time_ <= var_320_32 + arg_320_0 then
				arg_317_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_320_33 = 0

			if var_320_33 < arg_317_1.time_ and arg_317_1.time_ <= var_320_33 + arg_320_0 then
				arg_317_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/story10170/story10170action/10170action15_1")
			end

			local var_320_34 = 0
			local var_320_35 = 0.4

			if var_320_34 < arg_317_1.time_ and arg_317_1.time_ <= var_320_34 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, true)

				local var_320_36 = arg_317_1:FormatText(StoryNameCfg[1450].name)

				arg_317_1.leftNameTxt_.text = var_320_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_317_1.leftNameTxt_.transform)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1.leftNameTxt_.text)
				SetActive(arg_317_1.iconTrs_.gameObject, false)
				arg_317_1.callingController_:SetSelectedState("normal")

				local var_320_37 = arg_317_1:GetWordFromCfg(323121078)
				local var_320_38 = arg_317_1:FormatText(var_320_37.content)

				arg_317_1.text_.text = var_320_38

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_39 = 16
				local var_320_40 = utf8.len(var_320_38)
				local var_320_41 = var_320_39 <= 0 and var_320_35 or var_320_35 * (var_320_40 / var_320_39)

				if var_320_41 > 0 and var_320_35 < var_320_41 then
					arg_317_1.talkMaxDuration = var_320_41

					if var_320_41 + var_320_34 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_41 + var_320_34
					end
				end

				arg_317_1.text_.text = var_320_38
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323121", "323121078", "story_v_out_323121.awb") ~= 0 then
					local var_320_42 = manager.audio:GetVoiceLength("story_v_out_323121", "323121078", "story_v_out_323121.awb") / 1000

					if var_320_42 + var_320_34 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_42 + var_320_34
					end

					if var_320_37.prefab_name ~= "" and arg_317_1.actors_[var_320_37.prefab_name] ~= nil then
						local var_320_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_317_1.actors_[var_320_37.prefab_name].transform, "story_v_out_323121", "323121078", "story_v_out_323121.awb")

						arg_317_1:RecordAudio("323121078", var_320_43)
						arg_317_1:RecordAudio("323121078", var_320_43)
					else
						arg_317_1:AudioAction("play", "voice", "story_v_out_323121", "323121078", "story_v_out_323121.awb")
					end

					arg_317_1:RecordHistoryTalkVoice("story_v_out_323121", "323121078", "story_v_out_323121.awb")
				end

				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_44 = math.max(var_320_35, arg_317_1.talkMaxDuration)

			if var_320_34 <= arg_317_1.time_ and arg_317_1.time_ < var_320_34 + var_320_44 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - var_320_34) / var_320_44

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= var_320_34 + var_320_44 and arg_317_1.time_ < var_320_34 + var_320_44 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_317_1:InitPlayNodeList()
	end,
	Play323121079 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 323121079
		arg_321_1.duration_ = 5

		SetActive(arg_321_1.tipsGo_, false)

		function arg_321_1.onSingleLineFinish_()
			arg_321_1.onSingleLineUpdate_ = nil
			arg_321_1.onSingleLineFinish_ = nil
			arg_321_1.state_ = "waiting"
		end

		function arg_321_1.playNext_(arg_323_0)
			if arg_323_0 == 1 then
				arg_321_0:Play323121080(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			local var_324_0 = arg_321_1.actors_["10170ui_story"].transform
			local var_324_1 = 0

			if var_324_1 < arg_321_1.time_ and arg_321_1.time_ <= var_324_1 + arg_324_0 then
				arg_321_1.var_.moveOldPos10170ui_story = var_324_0.localPosition

				local var_324_2 = GameObjectTools.GetOrAddComponent(var_324_0.gameObject, typeof(DynamicBoneHelper))

				if var_324_2 then
					var_324_2:EnableDynamicBone(false)
				end
			end

			local var_324_3 = 0.001

			if var_324_1 <= arg_321_1.time_ and arg_321_1.time_ < var_324_1 + var_324_3 then
				local var_324_4 = (arg_321_1.time_ - var_324_1) / var_324_3
				local var_324_5 = Vector3.New(0, 100, 0)

				var_324_0.localPosition = Vector3.Lerp(arg_321_1.var_.moveOldPos10170ui_story, var_324_5, var_324_4)

				local var_324_6 = manager.ui.mainCamera.transform.position - var_324_0.position

				var_324_0.forward = Vector3.New(var_324_6.x, var_324_6.y, var_324_6.z)

				local var_324_7 = var_324_0.localEulerAngles

				var_324_7.z = 0
				var_324_7.x = 0
				var_324_0.localEulerAngles = var_324_7
			end

			if arg_321_1.time_ >= var_324_1 + var_324_3 and arg_321_1.time_ < var_324_1 + var_324_3 + arg_324_0 then
				var_324_0.localPosition = Vector3.New(0, 100, 0)

				local var_324_8 = manager.ui.mainCamera.transform.position - var_324_0.position

				var_324_0.forward = Vector3.New(var_324_8.x, var_324_8.y, var_324_8.z)

				local var_324_9 = var_324_0.localEulerAngles

				var_324_9.z = 0
				var_324_9.x = 0
				var_324_0.localEulerAngles = var_324_9

				local var_324_10 = GameObjectTools.GetOrAddComponent(var_324_0.gameObject, typeof(DynamicBoneHelper))

				if var_324_10 then
					var_324_10:EnableDynamicBone(true)
				end
			end

			local var_324_11 = arg_321_1.actors_["10170ui_story"]
			local var_324_12 = 0

			if var_324_12 < arg_321_1.time_ and arg_321_1.time_ <= var_324_12 + arg_324_0 and not isNil(var_324_11) and arg_321_1.var_.characterEffect10170ui_story == nil then
				arg_321_1.var_.characterEffect10170ui_story = var_324_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_324_13 = 0.200000002980232

			if var_324_12 <= arg_321_1.time_ and arg_321_1.time_ < var_324_12 + var_324_13 and not isNil(var_324_11) then
				local var_324_14 = (arg_321_1.time_ - var_324_12) / var_324_13

				if arg_321_1.var_.characterEffect10170ui_story and not isNil(var_324_11) then
					local var_324_15 = Mathf.Lerp(0, 0.5, var_324_14)

					arg_321_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_321_1.var_.characterEffect10170ui_story.fillRatio = var_324_15
				end
			end

			if arg_321_1.time_ >= var_324_12 + var_324_13 and arg_321_1.time_ < var_324_12 + var_324_13 + arg_324_0 and not isNil(var_324_11) and arg_321_1.var_.characterEffect10170ui_story then
				local var_324_16 = 0.5

				arg_321_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_321_1.var_.characterEffect10170ui_story.fillRatio = var_324_16
			end

			local var_324_17 = 0
			local var_324_18 = 1.8

			if var_324_17 < arg_321_1.time_ and arg_321_1.time_ <= var_324_17 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, false)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_321_1.iconTrs_.gameObject, false)
				arg_321_1.callingController_:SetSelectedState("normal")

				local var_324_19 = arg_321_1:GetWordFromCfg(323121079)
				local var_324_20 = arg_321_1:FormatText(var_324_19.content)

				arg_321_1.text_.text = var_324_20

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_21 = 72
				local var_324_22 = utf8.len(var_324_20)
				local var_324_23 = var_324_21 <= 0 and var_324_18 or var_324_18 * (var_324_22 / var_324_21)

				if var_324_23 > 0 and var_324_18 < var_324_23 then
					arg_321_1.talkMaxDuration = var_324_23

					if var_324_23 + var_324_17 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_23 + var_324_17
					end
				end

				arg_321_1.text_.text = var_324_20
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)
				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_24 = math.max(var_324_18, arg_321_1.talkMaxDuration)

			if var_324_17 <= arg_321_1.time_ and arg_321_1.time_ < var_324_17 + var_324_24 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - var_324_17) / var_324_24

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= var_324_17 + var_324_24 and arg_321_1.time_ < var_324_17 + var_324_24 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_321_1:InitPlayNodeList()
	end,
	Play323121080 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 323121080
		arg_325_1.duration_ = 5

		SetActive(arg_325_1.tipsGo_, false)

		function arg_325_1.onSingleLineFinish_()
			arg_325_1.onSingleLineUpdate_ = nil
			arg_325_1.onSingleLineFinish_ = nil
			arg_325_1.state_ = "waiting"
		end

		function arg_325_1.playNext_(arg_327_0)
			if arg_327_0 == 1 then
				arg_325_0:Play323121081(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			local var_328_0 = 0
			local var_328_1 = 0.525

			if var_328_0 < arg_325_1.time_ and arg_325_1.time_ <= var_328_0 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0
				arg_325_1.dialogCg_.alpha = 1

				arg_325_1.dialog_:SetActive(true)
				SetActive(arg_325_1.leftNameGo_, false)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_325_1.iconTrs_.gameObject, false)
				arg_325_1.callingController_:SetSelectedState("normal")

				local var_328_2 = arg_325_1:GetWordFromCfg(323121080)
				local var_328_3 = arg_325_1:FormatText(var_328_2.content)

				arg_325_1.text_.text = var_328_3

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_4 = 21
				local var_328_5 = utf8.len(var_328_3)
				local var_328_6 = var_328_4 <= 0 and var_328_1 or var_328_1 * (var_328_5 / var_328_4)

				if var_328_6 > 0 and var_328_1 < var_328_6 then
					arg_325_1.talkMaxDuration = var_328_6

					if var_328_6 + var_328_0 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_6 + var_328_0
					end
				end

				arg_325_1.text_.text = var_328_3
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)
				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_7 = math.max(var_328_1, arg_325_1.talkMaxDuration)

			if var_328_0 <= arg_325_1.time_ and arg_325_1.time_ < var_328_0 + var_328_7 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - var_328_0) / var_328_7

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= var_328_0 + var_328_7 and arg_325_1.time_ < var_328_0 + var_328_7 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {}

		arg_325_1:InitPlayNodeList()
	end,
	Play323121081 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 323121081
		arg_329_1.duration_ = 5

		SetActive(arg_329_1.tipsGo_, false)

		function arg_329_1.onSingleLineFinish_()
			arg_329_1.onSingleLineUpdate_ = nil
			arg_329_1.onSingleLineFinish_ = nil
			arg_329_1.state_ = "waiting"
		end

		function arg_329_1.playNext_(arg_331_0)
			if arg_331_0 == 1 then
				arg_329_0:Play323121082(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			local var_332_0 = 0
			local var_332_1 = 0.1

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

				arg_329_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_329_1.callingController_:SetSelectedState("normal")

				arg_329_1.keyicon_.color = Color.New(1, 1, 1)
				arg_329_1.icon_.color = Color.New(1, 1, 1)

				local var_332_3 = arg_329_1:GetWordFromCfg(323121081)
				local var_332_4 = arg_329_1:FormatText(var_332_3.content)

				arg_329_1.text_.text = var_332_4

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_5 = 4
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
	Play323121082 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 323121082
		arg_333_1.duration_ = 2

		SetActive(arg_333_1.tipsGo_, false)

		function arg_333_1.onSingleLineFinish_()
			arg_333_1.onSingleLineUpdate_ = nil
			arg_333_1.onSingleLineFinish_ = nil
			arg_333_1.state_ = "waiting"
		end

		function arg_333_1.playNext_(arg_335_0)
			if arg_335_0 == 1 then
				arg_333_0:Play323121083(arg_333_1)
			end
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			local var_336_0 = arg_333_1.actors_["10170ui_story"].transform
			local var_336_1 = 0

			if var_336_1 < arg_333_1.time_ and arg_333_1.time_ <= var_336_1 + arg_336_0 then
				arg_333_1.var_.moveOldPos10170ui_story = var_336_0.localPosition

				local var_336_2 = GameObjectTools.GetOrAddComponent(var_336_0.gameObject, typeof(DynamicBoneHelper))

				if var_336_2 then
					var_336_2:EnableDynamicBone(false)
				end
			end

			local var_336_3 = 0.001

			if var_336_1 <= arg_333_1.time_ and arg_333_1.time_ < var_336_1 + var_336_3 then
				local var_336_4 = (arg_333_1.time_ - var_336_1) / var_336_3
				local var_336_5 = Vector3.New(0, -1.03, -6.05)

				var_336_0.localPosition = Vector3.Lerp(arg_333_1.var_.moveOldPos10170ui_story, var_336_5, var_336_4)

				local var_336_6 = manager.ui.mainCamera.transform.position - var_336_0.position

				var_336_0.forward = Vector3.New(var_336_6.x, var_336_6.y, var_336_6.z)

				local var_336_7 = var_336_0.localEulerAngles

				var_336_7.z = 0
				var_336_7.x = 0
				var_336_0.localEulerAngles = var_336_7
			end

			if arg_333_1.time_ >= var_336_1 + var_336_3 and arg_333_1.time_ < var_336_1 + var_336_3 + arg_336_0 then
				var_336_0.localPosition = Vector3.New(0, -1.03, -6.05)

				local var_336_8 = manager.ui.mainCamera.transform.position - var_336_0.position

				var_336_0.forward = Vector3.New(var_336_8.x, var_336_8.y, var_336_8.z)

				local var_336_9 = var_336_0.localEulerAngles

				var_336_9.z = 0
				var_336_9.x = 0
				var_336_0.localEulerAngles = var_336_9

				local var_336_10 = GameObjectTools.GetOrAddComponent(var_336_0.gameObject, typeof(DynamicBoneHelper))

				if var_336_10 then
					var_336_10:EnableDynamicBone(true)
				end
			end

			local var_336_11 = 0

			if var_336_11 < arg_333_1.time_ and arg_333_1.time_ <= var_336_11 + arg_336_0 then
				arg_333_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_336_12 = 0

			if var_336_12 < arg_333_1.time_ and arg_333_1.time_ <= var_336_12 + arg_336_0 then
				arg_333_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/story10170/story10170action/10170action15_2")
			end

			local var_336_13 = arg_333_1.actors_["10170ui_story"]
			local var_336_14 = 0

			if var_336_14 < arg_333_1.time_ and arg_333_1.time_ <= var_336_14 + arg_336_0 and not isNil(var_336_13) and arg_333_1.var_.characterEffect10170ui_story == nil then
				arg_333_1.var_.characterEffect10170ui_story = var_336_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_336_15 = 0.200000002980232

			if var_336_14 <= arg_333_1.time_ and arg_333_1.time_ < var_336_14 + var_336_15 and not isNil(var_336_13) then
				local var_336_16 = (arg_333_1.time_ - var_336_14) / var_336_15

				if arg_333_1.var_.characterEffect10170ui_story and not isNil(var_336_13) then
					arg_333_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_333_1.time_ >= var_336_14 + var_336_15 and arg_333_1.time_ < var_336_14 + var_336_15 + arg_336_0 and not isNil(var_336_13) and arg_333_1.var_.characterEffect10170ui_story then
				arg_333_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_336_17 = 0
			local var_336_18 = 0.125

			if var_336_17 < arg_333_1.time_ and arg_333_1.time_ <= var_336_17 + arg_336_0 then
				arg_333_1.talkMaxDuration = 0
				arg_333_1.dialogCg_.alpha = 1

				arg_333_1.dialog_:SetActive(true)
				SetActive(arg_333_1.leftNameGo_, true)

				local var_336_19 = arg_333_1:FormatText(StoryNameCfg[1450].name)

				arg_333_1.leftNameTxt_.text = var_336_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_333_1.leftNameTxt_.transform)

				arg_333_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_333_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_333_1:RecordName(arg_333_1.leftNameTxt_.text)
				SetActive(arg_333_1.iconTrs_.gameObject, false)
				arg_333_1.callingController_:SetSelectedState("normal")

				local var_336_20 = arg_333_1:GetWordFromCfg(323121082)
				local var_336_21 = arg_333_1:FormatText(var_336_20.content)

				arg_333_1.text_.text = var_336_21

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_22 = 5
				local var_336_23 = utf8.len(var_336_21)
				local var_336_24 = var_336_22 <= 0 and var_336_18 or var_336_18 * (var_336_23 / var_336_22)

				if var_336_24 > 0 and var_336_18 < var_336_24 then
					arg_333_1.talkMaxDuration = var_336_24

					if var_336_24 + var_336_17 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_24 + var_336_17
					end
				end

				arg_333_1.text_.text = var_336_21
				arg_333_1.typewritter.percent = 0

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323121", "323121082", "story_v_out_323121.awb") ~= 0 then
					local var_336_25 = manager.audio:GetVoiceLength("story_v_out_323121", "323121082", "story_v_out_323121.awb") / 1000

					if var_336_25 + var_336_17 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_25 + var_336_17
					end

					if var_336_20.prefab_name ~= "" and arg_333_1.actors_[var_336_20.prefab_name] ~= nil then
						local var_336_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_333_1.actors_[var_336_20.prefab_name].transform, "story_v_out_323121", "323121082", "story_v_out_323121.awb")

						arg_333_1:RecordAudio("323121082", var_336_26)
						arg_333_1:RecordAudio("323121082", var_336_26)
					else
						arg_333_1:AudioAction("play", "voice", "story_v_out_323121", "323121082", "story_v_out_323121.awb")
					end

					arg_333_1:RecordHistoryTalkVoice("story_v_out_323121", "323121082", "story_v_out_323121.awb")
				end

				arg_333_1:RecordContent(arg_333_1.text_.text)
			end

			local var_336_27 = math.max(var_336_18, arg_333_1.talkMaxDuration)

			if var_336_17 <= arg_333_1.time_ and arg_333_1.time_ < var_336_17 + var_336_27 then
				arg_333_1.typewritter.percent = (arg_333_1.time_ - var_336_17) / var_336_27

				arg_333_1.typewritter:SetDirty()
			end

			if arg_333_1.time_ >= var_336_17 + var_336_27 and arg_333_1.time_ < var_336_17 + var_336_27 + arg_336_0 then
				arg_333_1.typewritter.percent = 1

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(true)
			end
		end

		arg_333_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_333_1:InitPlayNodeList()
	end,
	Play323121083 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 323121083
		arg_337_1.duration_ = 5

		SetActive(arg_337_1.tipsGo_, false)

		function arg_337_1.onSingleLineFinish_()
			arg_337_1.onSingleLineUpdate_ = nil
			arg_337_1.onSingleLineFinish_ = nil
			arg_337_1.state_ = "waiting"
		end

		function arg_337_1.playNext_(arg_339_0)
			if arg_339_0 == 1 then
				arg_337_0:Play323121084(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			local var_340_0 = arg_337_1.actors_["10170ui_story"]
			local var_340_1 = 0

			if var_340_1 < arg_337_1.time_ and arg_337_1.time_ <= var_340_1 + arg_340_0 and not isNil(var_340_0) and arg_337_1.var_.characterEffect10170ui_story == nil then
				arg_337_1.var_.characterEffect10170ui_story = var_340_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_340_2 = 0.200000002980232

			if var_340_1 <= arg_337_1.time_ and arg_337_1.time_ < var_340_1 + var_340_2 and not isNil(var_340_0) then
				local var_340_3 = (arg_337_1.time_ - var_340_1) / var_340_2

				if arg_337_1.var_.characterEffect10170ui_story and not isNil(var_340_0) then
					local var_340_4 = Mathf.Lerp(0, 0.5, var_340_3)

					arg_337_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_337_1.var_.characterEffect10170ui_story.fillRatio = var_340_4
				end
			end

			if arg_337_1.time_ >= var_340_1 + var_340_2 and arg_337_1.time_ < var_340_1 + var_340_2 + arg_340_0 and not isNil(var_340_0) and arg_337_1.var_.characterEffect10170ui_story then
				local var_340_5 = 0.5

				arg_337_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_337_1.var_.characterEffect10170ui_story.fillRatio = var_340_5
			end

			local var_340_6 = 0
			local var_340_7 = 0.325

			if var_340_6 < arg_337_1.time_ and arg_337_1.time_ <= var_340_6 + arg_340_0 then
				arg_337_1.talkMaxDuration = 0
				arg_337_1.dialogCg_.alpha = 1

				arg_337_1.dialog_:SetActive(true)
				SetActive(arg_337_1.leftNameGo_, true)

				local var_340_8 = arg_337_1:FormatText(StoryNameCfg[7].name)

				arg_337_1.leftNameTxt_.text = var_340_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_337_1.leftNameTxt_.transform)

				arg_337_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_337_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_337_1:RecordName(arg_337_1.leftNameTxt_.text)
				SetActive(arg_337_1.iconTrs_.gameObject, true)
				arg_337_1.iconController_:SetSelectedState("hero")

				arg_337_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_337_1.callingController_:SetSelectedState("normal")

				arg_337_1.keyicon_.color = Color.New(1, 1, 1)
				arg_337_1.icon_.color = Color.New(1, 1, 1)

				local var_340_9 = arg_337_1:GetWordFromCfg(323121083)
				local var_340_10 = arg_337_1:FormatText(var_340_9.content)

				arg_337_1.text_.text = var_340_10

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_11 = 13
				local var_340_12 = utf8.len(var_340_10)
				local var_340_13 = var_340_11 <= 0 and var_340_7 or var_340_7 * (var_340_12 / var_340_11)

				if var_340_13 > 0 and var_340_7 < var_340_13 then
					arg_337_1.talkMaxDuration = var_340_13

					if var_340_13 + var_340_6 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_13 + var_340_6
					end
				end

				arg_337_1.text_.text = var_340_10
				arg_337_1.typewritter.percent = 0

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(false)
				arg_337_1:RecordContent(arg_337_1.text_.text)
			end

			local var_340_14 = math.max(var_340_7, arg_337_1.talkMaxDuration)

			if var_340_6 <= arg_337_1.time_ and arg_337_1.time_ < var_340_6 + var_340_14 then
				arg_337_1.typewritter.percent = (arg_337_1.time_ - var_340_6) / var_340_14

				arg_337_1.typewritter:SetDirty()
			end

			if arg_337_1.time_ >= var_340_6 + var_340_14 and arg_337_1.time_ < var_340_6 + var_340_14 + arg_340_0 then
				arg_337_1.typewritter.percent = 1

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(true)
			end
		end

		arg_337_1.nodeConfigList_ = {}

		arg_337_1:InitPlayNodeList()
	end,
	Play323121084 = function(arg_341_0, arg_341_1)
		arg_341_1.time_ = 0
		arg_341_1.frameCnt_ = 0
		arg_341_1.state_ = "playing"
		arg_341_1.curTalkId_ = 323121084
		arg_341_1.duration_ = 5

		SetActive(arg_341_1.tipsGo_, false)

		function arg_341_1.onSingleLineFinish_()
			arg_341_1.onSingleLineUpdate_ = nil
			arg_341_1.onSingleLineFinish_ = nil
			arg_341_1.state_ = "waiting"
		end

		function arg_341_1.playNext_(arg_343_0)
			if arg_343_0 == 1 then
				arg_341_0:Play323121085(arg_341_1)
			end
		end

		function arg_341_1.onSingleLineUpdate_(arg_344_0)
			local var_344_0 = arg_341_1.actors_["10170ui_story"].transform
			local var_344_1 = 0

			if var_344_1 < arg_341_1.time_ and arg_341_1.time_ <= var_344_1 + arg_344_0 then
				arg_341_1.var_.moveOldPos10170ui_story = var_344_0.localPosition

				local var_344_2 = GameObjectTools.GetOrAddComponent(var_344_0.gameObject, typeof(DynamicBoneHelper))

				if var_344_2 then
					var_344_2:EnableDynamicBone(false)
				end
			end

			local var_344_3 = 0.001

			if var_344_1 <= arg_341_1.time_ and arg_341_1.time_ < var_344_1 + var_344_3 then
				local var_344_4 = (arg_341_1.time_ - var_344_1) / var_344_3
				local var_344_5 = Vector3.New(0, 100, 0)

				var_344_0.localPosition = Vector3.Lerp(arg_341_1.var_.moveOldPos10170ui_story, var_344_5, var_344_4)

				local var_344_6 = manager.ui.mainCamera.transform.position - var_344_0.position

				var_344_0.forward = Vector3.New(var_344_6.x, var_344_6.y, var_344_6.z)

				local var_344_7 = var_344_0.localEulerAngles

				var_344_7.z = 0
				var_344_7.x = 0
				var_344_0.localEulerAngles = var_344_7
			end

			if arg_341_1.time_ >= var_344_1 + var_344_3 and arg_341_1.time_ < var_344_1 + var_344_3 + arg_344_0 then
				var_344_0.localPosition = Vector3.New(0, 100, 0)

				local var_344_8 = manager.ui.mainCamera.transform.position - var_344_0.position

				var_344_0.forward = Vector3.New(var_344_8.x, var_344_8.y, var_344_8.z)

				local var_344_9 = var_344_0.localEulerAngles

				var_344_9.z = 0
				var_344_9.x = 0
				var_344_0.localEulerAngles = var_344_9

				local var_344_10 = GameObjectTools.GetOrAddComponent(var_344_0.gameObject, typeof(DynamicBoneHelper))

				if var_344_10 then
					var_344_10:EnableDynamicBone(true)
				end
			end

			local var_344_11 = 0
			local var_344_12 = 1.325

			if var_344_11 < arg_341_1.time_ and arg_341_1.time_ <= var_344_11 + arg_344_0 then
				arg_341_1.talkMaxDuration = 0
				arg_341_1.dialogCg_.alpha = 1

				arg_341_1.dialog_:SetActive(true)
				SetActive(arg_341_1.leftNameGo_, false)

				arg_341_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_341_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_341_1:RecordName(arg_341_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_341_1.iconTrs_.gameObject, false)
				arg_341_1.callingController_:SetSelectedState("normal")

				local var_344_13 = arg_341_1:GetWordFromCfg(323121084)
				local var_344_14 = arg_341_1:FormatText(var_344_13.content)

				arg_341_1.text_.text = var_344_14

				LuaForUtil.ClearLinePrefixSymbol(arg_341_1.text_)

				local var_344_15 = 53
				local var_344_16 = utf8.len(var_344_14)
				local var_344_17 = var_344_15 <= 0 and var_344_12 or var_344_12 * (var_344_16 / var_344_15)

				if var_344_17 > 0 and var_344_12 < var_344_17 then
					arg_341_1.talkMaxDuration = var_344_17

					if var_344_17 + var_344_11 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_17 + var_344_11
					end
				end

				arg_341_1.text_.text = var_344_14
				arg_341_1.typewritter.percent = 0

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(false)
				arg_341_1:RecordContent(arg_341_1.text_.text)
			end

			local var_344_18 = math.max(var_344_12, arg_341_1.talkMaxDuration)

			if var_344_11 <= arg_341_1.time_ and arg_341_1.time_ < var_344_11 + var_344_18 then
				arg_341_1.typewritter.percent = (arg_341_1.time_ - var_344_11) / var_344_18

				arg_341_1.typewritter:SetDirty()
			end

			if arg_341_1.time_ >= var_344_11 + var_344_18 and arg_341_1.time_ < var_344_11 + var_344_18 + arg_344_0 then
				arg_341_1.typewritter.percent = 1

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(true)
			end
		end

		arg_341_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_341_1:InitPlayNodeList()
	end,
	Play323121085 = function(arg_345_0, arg_345_1)
		arg_345_1.time_ = 0
		arg_345_1.frameCnt_ = 0
		arg_345_1.state_ = "playing"
		arg_345_1.curTalkId_ = 323121085
		arg_345_1.duration_ = 6.5

		local var_345_0 = {
			zh = 4.999999999999,
			ja = 6.5
		}
		local var_345_1 = manager.audio:GetLocalizationFlag()

		if var_345_0[var_345_1] ~= nil then
			arg_345_1.duration_ = var_345_0[var_345_1]
		end

		SetActive(arg_345_1.tipsGo_, false)

		function arg_345_1.onSingleLineFinish_()
			arg_345_1.onSingleLineUpdate_ = nil
			arg_345_1.onSingleLineFinish_ = nil
			arg_345_1.state_ = "waiting"
		end

		function arg_345_1.playNext_(arg_347_0)
			if arg_347_0 == 1 then
				arg_345_0:Play323121086(arg_345_1)
			end
		end

		function arg_345_1.onSingleLineUpdate_(arg_348_0)
			local var_348_0 = arg_345_1.actors_["1019ui_story"].transform
			local var_348_1 = 0

			if var_348_1 < arg_345_1.time_ and arg_345_1.time_ <= var_348_1 + arg_348_0 then
				arg_345_1.var_.moveOldPos1019ui_story = var_348_0.localPosition
			end

			local var_348_2 = 0.001

			if var_348_1 <= arg_345_1.time_ and arg_345_1.time_ < var_348_1 + var_348_2 then
				local var_348_3 = (arg_345_1.time_ - var_348_1) / var_348_2
				local var_348_4 = Vector3.New(-0.2, -1.08, -5.9)

				var_348_0.localPosition = Vector3.Lerp(arg_345_1.var_.moveOldPos1019ui_story, var_348_4, var_348_3)

				local var_348_5 = manager.ui.mainCamera.transform.position - var_348_0.position

				var_348_0.forward = Vector3.New(var_348_5.x, var_348_5.y, var_348_5.z)

				local var_348_6 = var_348_0.localEulerAngles

				var_348_6.z = 0
				var_348_6.x = 0
				var_348_0.localEulerAngles = var_348_6
			end

			if arg_345_1.time_ >= var_348_1 + var_348_2 and arg_345_1.time_ < var_348_1 + var_348_2 + arg_348_0 then
				var_348_0.localPosition = Vector3.New(-0.2, -1.08, -5.9)

				local var_348_7 = manager.ui.mainCamera.transform.position - var_348_0.position

				var_348_0.forward = Vector3.New(var_348_7.x, var_348_7.y, var_348_7.z)

				local var_348_8 = var_348_0.localEulerAngles

				var_348_8.z = 0
				var_348_8.x = 0
				var_348_0.localEulerAngles = var_348_8
			end

			local var_348_9 = arg_345_1.actors_["1019ui_story"]
			local var_348_10 = 0

			if var_348_10 < arg_345_1.time_ and arg_345_1.time_ <= var_348_10 + arg_348_0 and not isNil(var_348_9) and arg_345_1.var_.characterEffect1019ui_story == nil then
				arg_345_1.var_.characterEffect1019ui_story = var_348_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_348_11 = 0.200000002980232

			if var_348_10 <= arg_345_1.time_ and arg_345_1.time_ < var_348_10 + var_348_11 and not isNil(var_348_9) then
				local var_348_12 = (arg_345_1.time_ - var_348_10) / var_348_11

				if arg_345_1.var_.characterEffect1019ui_story and not isNil(var_348_9) then
					arg_345_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_345_1.time_ >= var_348_10 + var_348_11 and arg_345_1.time_ < var_348_10 + var_348_11 + arg_348_0 and not isNil(var_348_9) and arg_345_1.var_.characterEffect1019ui_story then
				arg_345_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_348_13 = 0

			if var_348_13 < arg_345_1.time_ and arg_345_1.time_ <= var_348_13 + arg_348_0 then
				arg_345_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action6_1")
			end

			local var_348_14 = 0

			if var_348_14 < arg_345_1.time_ and arg_345_1.time_ <= var_348_14 + arg_348_0 then
				arg_345_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_348_15 = arg_345_1.actors_["1019ui_story"]
			local var_348_16 = 0

			if var_348_16 < arg_345_1.time_ and arg_345_1.time_ <= var_348_16 + arg_348_0 then
				if arg_345_1.var_.characterEffect1019ui_story == nil then
					arg_345_1.var_.characterEffect1019ui_story = var_348_15:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_348_17 = arg_345_1.var_.characterEffect1019ui_story

				var_348_17.imageEffect:turnOff()

				var_348_17.interferenceEffect.enabled = true
				var_348_17.interferenceEffect.noise = 0.001
				var_348_17.interferenceEffect.simTimeScale = 1
				var_348_17.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			local var_348_18 = arg_345_1.actors_["1019ui_story"]
			local var_348_19 = 0
			local var_348_20 = 5

			if var_348_19 < arg_345_1.time_ and arg_345_1.time_ <= var_348_19 + arg_348_0 then
				if arg_345_1.var_.characterEffect1019ui_story == nil then
					arg_345_1.var_.characterEffect1019ui_story = var_348_18:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_345_1.var_.characterEffect1019ui_story.imageEffect:turnOn(false)
			end

			local var_348_21 = 0
			local var_348_22 = 0.35

			if var_348_21 < arg_345_1.time_ and arg_345_1.time_ <= var_348_21 + arg_348_0 then
				arg_345_1.talkMaxDuration = 0
				arg_345_1.dialogCg_.alpha = 1

				arg_345_1.dialog_:SetActive(true)
				SetActive(arg_345_1.leftNameGo_, true)

				local var_348_23 = arg_345_1:FormatText(StoryNameCfg[13].name)

				arg_345_1.leftNameTxt_.text = var_348_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_345_1.leftNameTxt_.transform)

				arg_345_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_345_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_345_1:RecordName(arg_345_1.leftNameTxt_.text)
				SetActive(arg_345_1.iconTrs_.gameObject, false)
				arg_345_1.callingController_:SetSelectedState("normal")

				local var_348_24 = arg_345_1:GetWordFromCfg(323121085)
				local var_348_25 = arg_345_1:FormatText(var_348_24.content)

				arg_345_1.text_.text = var_348_25

				LuaForUtil.ClearLinePrefixSymbol(arg_345_1.text_)

				local var_348_26 = 14
				local var_348_27 = utf8.len(var_348_25)
				local var_348_28 = var_348_26 <= 0 and var_348_22 or var_348_22 * (var_348_27 / var_348_26)

				if var_348_28 > 0 and var_348_22 < var_348_28 then
					arg_345_1.talkMaxDuration = var_348_28

					if var_348_28 + var_348_21 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_28 + var_348_21
					end
				end

				arg_345_1.text_.text = var_348_25
				arg_345_1.typewritter.percent = 0

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323121", "323121085", "story_v_out_323121.awb") ~= 0 then
					local var_348_29 = manager.audio:GetVoiceLength("story_v_out_323121", "323121085", "story_v_out_323121.awb") / 1000

					if var_348_29 + var_348_21 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_29 + var_348_21
					end

					if var_348_24.prefab_name ~= "" and arg_345_1.actors_[var_348_24.prefab_name] ~= nil then
						local var_348_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_345_1.actors_[var_348_24.prefab_name].transform, "story_v_out_323121", "323121085", "story_v_out_323121.awb")

						arg_345_1:RecordAudio("323121085", var_348_30)
						arg_345_1:RecordAudio("323121085", var_348_30)
					else
						arg_345_1:AudioAction("play", "voice", "story_v_out_323121", "323121085", "story_v_out_323121.awb")
					end

					arg_345_1:RecordHistoryTalkVoice("story_v_out_323121", "323121085", "story_v_out_323121.awb")
				end

				arg_345_1:RecordContent(arg_345_1.text_.text)
			end

			local var_348_31 = math.max(var_348_22, arg_345_1.talkMaxDuration)

			if var_348_21 <= arg_345_1.time_ and arg_345_1.time_ < var_348_21 + var_348_31 then
				arg_345_1.typewritter.percent = (arg_345_1.time_ - var_348_21) / var_348_31

				arg_345_1.typewritter:SetDirty()
			end

			if arg_345_1.time_ >= var_348_21 + var_348_31 and arg_345_1.time_ < var_348_21 + var_348_31 + arg_348_0 then
				arg_345_1.typewritter.percent = 1

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(true)
			end
		end

		arg_345_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_345_1:InitPlayNodeList()
	end,
	Play323121086 = function(arg_349_0, arg_349_1)
		arg_349_1.time_ = 0
		arg_349_1.frameCnt_ = 0
		arg_349_1.state_ = "playing"
		arg_349_1.curTalkId_ = 323121086
		arg_349_1.duration_ = 5

		SetActive(arg_349_1.tipsGo_, false)

		function arg_349_1.onSingleLineFinish_()
			arg_349_1.onSingleLineUpdate_ = nil
			arg_349_1.onSingleLineFinish_ = nil
			arg_349_1.state_ = "waiting"
		end

		function arg_349_1.playNext_(arg_351_0)
			if arg_351_0 == 1 then
				arg_349_0:Play323121087(arg_349_1)
			end
		end

		function arg_349_1.onSingleLineUpdate_(arg_352_0)
			local var_352_0 = arg_349_1.actors_["1019ui_story"]
			local var_352_1 = 0

			if var_352_1 < arg_349_1.time_ and arg_349_1.time_ <= var_352_1 + arg_352_0 and not isNil(var_352_0) and arg_349_1.var_.characterEffect1019ui_story == nil then
				arg_349_1.var_.characterEffect1019ui_story = var_352_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_352_2 = 0.200000002980232

			if var_352_1 <= arg_349_1.time_ and arg_349_1.time_ < var_352_1 + var_352_2 and not isNil(var_352_0) then
				local var_352_3 = (arg_349_1.time_ - var_352_1) / var_352_2

				if arg_349_1.var_.characterEffect1019ui_story and not isNil(var_352_0) then
					local var_352_4 = Mathf.Lerp(0, 0.5, var_352_3)

					arg_349_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_349_1.var_.characterEffect1019ui_story.fillRatio = var_352_4
				end
			end

			if arg_349_1.time_ >= var_352_1 + var_352_2 and arg_349_1.time_ < var_352_1 + var_352_2 + arg_352_0 and not isNil(var_352_0) and arg_349_1.var_.characterEffect1019ui_story then
				local var_352_5 = 0.5

				arg_349_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_349_1.var_.characterEffect1019ui_story.fillRatio = var_352_5
			end

			local var_352_6 = 0
			local var_352_7 = 0.5

			if var_352_6 < arg_349_1.time_ and arg_349_1.time_ <= var_352_6 + arg_352_0 then
				arg_349_1.talkMaxDuration = 0
				arg_349_1.dialogCg_.alpha = 1

				arg_349_1.dialog_:SetActive(true)
				SetActive(arg_349_1.leftNameGo_, true)

				local var_352_8 = arg_349_1:FormatText(StoryNameCfg[7].name)

				arg_349_1.leftNameTxt_.text = var_352_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_349_1.leftNameTxt_.transform)

				arg_349_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_349_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_349_1:RecordName(arg_349_1.leftNameTxt_.text)
				SetActive(arg_349_1.iconTrs_.gameObject, true)
				arg_349_1.iconController_:SetSelectedState("hero")

				arg_349_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_349_1.callingController_:SetSelectedState("normal")

				arg_349_1.keyicon_.color = Color.New(1, 1, 1)
				arg_349_1.icon_.color = Color.New(1, 1, 1)

				local var_352_9 = arg_349_1:GetWordFromCfg(323121086)
				local var_352_10 = arg_349_1:FormatText(var_352_9.content)

				arg_349_1.text_.text = var_352_10

				LuaForUtil.ClearLinePrefixSymbol(arg_349_1.text_)

				local var_352_11 = 20
				local var_352_12 = utf8.len(var_352_10)
				local var_352_13 = var_352_11 <= 0 and var_352_7 or var_352_7 * (var_352_12 / var_352_11)

				if var_352_13 > 0 and var_352_7 < var_352_13 then
					arg_349_1.talkMaxDuration = var_352_13

					if var_352_13 + var_352_6 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_13 + var_352_6
					end
				end

				arg_349_1.text_.text = var_352_10
				arg_349_1.typewritter.percent = 0

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(false)
				arg_349_1:RecordContent(arg_349_1.text_.text)
			end

			local var_352_14 = math.max(var_352_7, arg_349_1.talkMaxDuration)

			if var_352_6 <= arg_349_1.time_ and arg_349_1.time_ < var_352_6 + var_352_14 then
				arg_349_1.typewritter.percent = (arg_349_1.time_ - var_352_6) / var_352_14

				arg_349_1.typewritter:SetDirty()
			end

			if arg_349_1.time_ >= var_352_6 + var_352_14 and arg_349_1.time_ < var_352_6 + var_352_14 + arg_352_0 then
				arg_349_1.typewritter.percent = 1

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(true)
			end
		end

		arg_349_1.nodeConfigList_ = {}

		arg_349_1:InitPlayNodeList()
	end,
	Play323121087 = function(arg_353_0, arg_353_1)
		arg_353_1.time_ = 0
		arg_353_1.frameCnt_ = 0
		arg_353_1.state_ = "playing"
		arg_353_1.curTalkId_ = 323121087
		arg_353_1.duration_ = 4.83

		local var_353_0 = {
			zh = 2.866,
			ja = 4.833
		}
		local var_353_1 = manager.audio:GetLocalizationFlag()

		if var_353_0[var_353_1] ~= nil then
			arg_353_1.duration_ = var_353_0[var_353_1]
		end

		SetActive(arg_353_1.tipsGo_, false)

		function arg_353_1.onSingleLineFinish_()
			arg_353_1.onSingleLineUpdate_ = nil
			arg_353_1.onSingleLineFinish_ = nil
			arg_353_1.state_ = "waiting"
		end

		function arg_353_1.playNext_(arg_355_0)
			if arg_355_0 == 1 then
				arg_353_0:Play323121088(arg_353_1)
			end
		end

		function arg_353_1.onSingleLineUpdate_(arg_356_0)
			local var_356_0 = arg_353_1.actors_["1019ui_story"]
			local var_356_1 = 0

			if var_356_1 < arg_353_1.time_ and arg_353_1.time_ <= var_356_1 + arg_356_0 and not isNil(var_356_0) and arg_353_1.var_.characterEffect1019ui_story == nil then
				arg_353_1.var_.characterEffect1019ui_story = var_356_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_356_2 = 0.200000002980232

			if var_356_1 <= arg_353_1.time_ and arg_353_1.time_ < var_356_1 + var_356_2 and not isNil(var_356_0) then
				local var_356_3 = (arg_353_1.time_ - var_356_1) / var_356_2

				if arg_353_1.var_.characterEffect1019ui_story and not isNil(var_356_0) then
					arg_353_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_353_1.time_ >= var_356_1 + var_356_2 and arg_353_1.time_ < var_356_1 + var_356_2 + arg_356_0 and not isNil(var_356_0) and arg_353_1.var_.characterEffect1019ui_story then
				arg_353_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_356_4 = 0
			local var_356_5 = 0.375

			if var_356_4 < arg_353_1.time_ and arg_353_1.time_ <= var_356_4 + arg_356_0 then
				arg_353_1.talkMaxDuration = 0
				arg_353_1.dialogCg_.alpha = 1

				arg_353_1.dialog_:SetActive(true)
				SetActive(arg_353_1.leftNameGo_, true)

				local var_356_6 = arg_353_1:FormatText(StoryNameCfg[13].name)

				arg_353_1.leftNameTxt_.text = var_356_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_353_1.leftNameTxt_.transform)

				arg_353_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_353_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_353_1:RecordName(arg_353_1.leftNameTxt_.text)
				SetActive(arg_353_1.iconTrs_.gameObject, false)
				arg_353_1.callingController_:SetSelectedState("normal")

				local var_356_7 = arg_353_1:GetWordFromCfg(323121087)
				local var_356_8 = arg_353_1:FormatText(var_356_7.content)

				arg_353_1.text_.text = var_356_8

				LuaForUtil.ClearLinePrefixSymbol(arg_353_1.text_)

				local var_356_9 = 15
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

				if manager.audio:GetVoiceLength("story_v_out_323121", "323121087", "story_v_out_323121.awb") ~= 0 then
					local var_356_12 = manager.audio:GetVoiceLength("story_v_out_323121", "323121087", "story_v_out_323121.awb") / 1000

					if var_356_12 + var_356_4 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_12 + var_356_4
					end

					if var_356_7.prefab_name ~= "" and arg_353_1.actors_[var_356_7.prefab_name] ~= nil then
						local var_356_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_353_1.actors_[var_356_7.prefab_name].transform, "story_v_out_323121", "323121087", "story_v_out_323121.awb")

						arg_353_1:RecordAudio("323121087", var_356_13)
						arg_353_1:RecordAudio("323121087", var_356_13)
					else
						arg_353_1:AudioAction("play", "voice", "story_v_out_323121", "323121087", "story_v_out_323121.awb")
					end

					arg_353_1:RecordHistoryTalkVoice("story_v_out_323121", "323121087", "story_v_out_323121.awb")
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
	Play323121088 = function(arg_357_0, arg_357_1)
		arg_357_1.time_ = 0
		arg_357_1.frameCnt_ = 0
		arg_357_1.state_ = "playing"
		arg_357_1.curTalkId_ = 323121088
		arg_357_1.duration_ = 5

		SetActive(arg_357_1.tipsGo_, false)

		function arg_357_1.onSingleLineFinish_()
			arg_357_1.onSingleLineUpdate_ = nil
			arg_357_1.onSingleLineFinish_ = nil
			arg_357_1.state_ = "waiting"
		end

		function arg_357_1.playNext_(arg_359_0)
			if arg_359_0 == 1 then
				arg_357_0:Play323121089(arg_357_1)
			end
		end

		function arg_357_1.onSingleLineUpdate_(arg_360_0)
			local var_360_0 = arg_357_1.actors_["1019ui_story"]
			local var_360_1 = 0

			if var_360_1 < arg_357_1.time_ and arg_357_1.time_ <= var_360_1 + arg_360_0 and not isNil(var_360_0) and arg_357_1.var_.characterEffect1019ui_story == nil then
				arg_357_1.var_.characterEffect1019ui_story = var_360_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_360_2 = 0.200000002980232

			if var_360_1 <= arg_357_1.time_ and arg_357_1.time_ < var_360_1 + var_360_2 and not isNil(var_360_0) then
				local var_360_3 = (arg_357_1.time_ - var_360_1) / var_360_2

				if arg_357_1.var_.characterEffect1019ui_story and not isNil(var_360_0) then
					local var_360_4 = Mathf.Lerp(0, 0.5, var_360_3)

					arg_357_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_357_1.var_.characterEffect1019ui_story.fillRatio = var_360_4
				end
			end

			if arg_357_1.time_ >= var_360_1 + var_360_2 and arg_357_1.time_ < var_360_1 + var_360_2 + arg_360_0 and not isNil(var_360_0) and arg_357_1.var_.characterEffect1019ui_story then
				local var_360_5 = 0.5

				arg_357_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_357_1.var_.characterEffect1019ui_story.fillRatio = var_360_5
			end

			local var_360_6 = 0
			local var_360_7 = 0.675

			if var_360_6 < arg_357_1.time_ and arg_357_1.time_ <= var_360_6 + arg_360_0 then
				arg_357_1.talkMaxDuration = 0
				arg_357_1.dialogCg_.alpha = 1

				arg_357_1.dialog_:SetActive(true)
				SetActive(arg_357_1.leftNameGo_, true)

				local var_360_8 = arg_357_1:FormatText(StoryNameCfg[7].name)

				arg_357_1.leftNameTxt_.text = var_360_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_357_1.leftNameTxt_.transform)

				arg_357_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_357_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_357_1:RecordName(arg_357_1.leftNameTxt_.text)
				SetActive(arg_357_1.iconTrs_.gameObject, true)
				arg_357_1.iconController_:SetSelectedState("hero")

				arg_357_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_357_1.callingController_:SetSelectedState("normal")

				arg_357_1.keyicon_.color = Color.New(1, 1, 1)
				arg_357_1.icon_.color = Color.New(1, 1, 1)

				local var_360_9 = arg_357_1:GetWordFromCfg(323121088)
				local var_360_10 = arg_357_1:FormatText(var_360_9.content)

				arg_357_1.text_.text = var_360_10

				LuaForUtil.ClearLinePrefixSymbol(arg_357_1.text_)

				local var_360_11 = 27
				local var_360_12 = utf8.len(var_360_10)
				local var_360_13 = var_360_11 <= 0 and var_360_7 or var_360_7 * (var_360_12 / var_360_11)

				if var_360_13 > 0 and var_360_7 < var_360_13 then
					arg_357_1.talkMaxDuration = var_360_13

					if var_360_13 + var_360_6 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_13 + var_360_6
					end
				end

				arg_357_1.text_.text = var_360_10
				arg_357_1.typewritter.percent = 0

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(false)
				arg_357_1:RecordContent(arg_357_1.text_.text)
			end

			local var_360_14 = math.max(var_360_7, arg_357_1.talkMaxDuration)

			if var_360_6 <= arg_357_1.time_ and arg_357_1.time_ < var_360_6 + var_360_14 then
				arg_357_1.typewritter.percent = (arg_357_1.time_ - var_360_6) / var_360_14

				arg_357_1.typewritter:SetDirty()
			end

			if arg_357_1.time_ >= var_360_6 + var_360_14 and arg_357_1.time_ < var_360_6 + var_360_14 + arg_360_0 then
				arg_357_1.typewritter.percent = 1

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(true)
			end
		end

		arg_357_1.nodeConfigList_ = {}

		arg_357_1:InitPlayNodeList()
	end,
	Play323121089 = function(arg_361_0, arg_361_1)
		arg_361_1.time_ = 0
		arg_361_1.frameCnt_ = 0
		arg_361_1.state_ = "playing"
		arg_361_1.curTalkId_ = 323121089
		arg_361_1.duration_ = 3.3

		local var_361_0 = {
			zh = 2,
			ja = 3.3
		}
		local var_361_1 = manager.audio:GetLocalizationFlag()

		if var_361_0[var_361_1] ~= nil then
			arg_361_1.duration_ = var_361_0[var_361_1]
		end

		SetActive(arg_361_1.tipsGo_, false)

		function arg_361_1.onSingleLineFinish_()
			arg_361_1.onSingleLineUpdate_ = nil
			arg_361_1.onSingleLineFinish_ = nil
			arg_361_1.state_ = "waiting"
		end

		function arg_361_1.playNext_(arg_363_0)
			if arg_363_0 == 1 then
				arg_361_0:Play323121090(arg_361_1)
			end
		end

		function arg_361_1.onSingleLineUpdate_(arg_364_0)
			local var_364_0 = arg_361_1.actors_["1019ui_story"]
			local var_364_1 = 0

			if var_364_1 < arg_361_1.time_ and arg_361_1.time_ <= var_364_1 + arg_364_0 and not isNil(var_364_0) and arg_361_1.var_.characterEffect1019ui_story == nil then
				arg_361_1.var_.characterEffect1019ui_story = var_364_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_364_2 = 0.200000002980232

			if var_364_1 <= arg_361_1.time_ and arg_361_1.time_ < var_364_1 + var_364_2 and not isNil(var_364_0) then
				local var_364_3 = (arg_361_1.time_ - var_364_1) / var_364_2

				if arg_361_1.var_.characterEffect1019ui_story and not isNil(var_364_0) then
					arg_361_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_361_1.time_ >= var_364_1 + var_364_2 and arg_361_1.time_ < var_364_1 + var_364_2 + arg_364_0 and not isNil(var_364_0) and arg_361_1.var_.characterEffect1019ui_story then
				arg_361_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_364_4 = 0

			if var_364_4 < arg_361_1.time_ and arg_361_1.time_ <= var_364_4 + arg_364_0 then
				arg_361_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action465")
			end

			local var_364_5 = 0

			if var_364_5 < arg_361_1.time_ and arg_361_1.time_ <= var_364_5 + arg_364_0 then
				arg_361_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_364_6 = 0
			local var_364_7 = 0.275

			if var_364_6 < arg_361_1.time_ and arg_361_1.time_ <= var_364_6 + arg_364_0 then
				arg_361_1.talkMaxDuration = 0
				arg_361_1.dialogCg_.alpha = 1

				arg_361_1.dialog_:SetActive(true)
				SetActive(arg_361_1.leftNameGo_, true)

				local var_364_8 = arg_361_1:FormatText(StoryNameCfg[13].name)

				arg_361_1.leftNameTxt_.text = var_364_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_361_1.leftNameTxt_.transform)

				arg_361_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_361_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_361_1:RecordName(arg_361_1.leftNameTxt_.text)
				SetActive(arg_361_1.iconTrs_.gameObject, false)
				arg_361_1.callingController_:SetSelectedState("normal")

				local var_364_9 = arg_361_1:GetWordFromCfg(323121089)
				local var_364_10 = arg_361_1:FormatText(var_364_9.content)

				arg_361_1.text_.text = var_364_10

				LuaForUtil.ClearLinePrefixSymbol(arg_361_1.text_)

				local var_364_11 = 11
				local var_364_12 = utf8.len(var_364_10)
				local var_364_13 = var_364_11 <= 0 and var_364_7 or var_364_7 * (var_364_12 / var_364_11)

				if var_364_13 > 0 and var_364_7 < var_364_13 then
					arg_361_1.talkMaxDuration = var_364_13

					if var_364_13 + var_364_6 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_13 + var_364_6
					end
				end

				arg_361_1.text_.text = var_364_10
				arg_361_1.typewritter.percent = 0

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323121", "323121089", "story_v_out_323121.awb") ~= 0 then
					local var_364_14 = manager.audio:GetVoiceLength("story_v_out_323121", "323121089", "story_v_out_323121.awb") / 1000

					if var_364_14 + var_364_6 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_14 + var_364_6
					end

					if var_364_9.prefab_name ~= "" and arg_361_1.actors_[var_364_9.prefab_name] ~= nil then
						local var_364_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_361_1.actors_[var_364_9.prefab_name].transform, "story_v_out_323121", "323121089", "story_v_out_323121.awb")

						arg_361_1:RecordAudio("323121089", var_364_15)
						arg_361_1:RecordAudio("323121089", var_364_15)
					else
						arg_361_1:AudioAction("play", "voice", "story_v_out_323121", "323121089", "story_v_out_323121.awb")
					end

					arg_361_1:RecordHistoryTalkVoice("story_v_out_323121", "323121089", "story_v_out_323121.awb")
				end

				arg_361_1:RecordContent(arg_361_1.text_.text)
			end

			local var_364_16 = math.max(var_364_7, arg_361_1.talkMaxDuration)

			if var_364_6 <= arg_361_1.time_ and arg_361_1.time_ < var_364_6 + var_364_16 then
				arg_361_1.typewritter.percent = (arg_361_1.time_ - var_364_6) / var_364_16

				arg_361_1.typewritter:SetDirty()
			end

			if arg_361_1.time_ >= var_364_6 + var_364_16 and arg_361_1.time_ < var_364_6 + var_364_16 + arg_364_0 then
				arg_361_1.typewritter.percent = 1

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(true)
			end
		end

		arg_361_1.nodeConfigList_ = {}

		arg_361_1:InitPlayNodeList()
	end,
	Play323121090 = function(arg_365_0, arg_365_1)
		arg_365_1.time_ = 0
		arg_365_1.frameCnt_ = 0
		arg_365_1.state_ = "playing"
		arg_365_1.curTalkId_ = 323121090
		arg_365_1.duration_ = 5

		SetActive(arg_365_1.tipsGo_, false)

		function arg_365_1.onSingleLineFinish_()
			arg_365_1.onSingleLineUpdate_ = nil
			arg_365_1.onSingleLineFinish_ = nil
			arg_365_1.state_ = "waiting"
		end

		function arg_365_1.playNext_(arg_367_0)
			if arg_367_0 == 1 then
				arg_365_0:Play323121091(arg_365_1)
			end
		end

		function arg_365_1.onSingleLineUpdate_(arg_368_0)
			local var_368_0 = arg_365_1.actors_["1019ui_story"].transform
			local var_368_1 = 0

			if var_368_1 < arg_365_1.time_ and arg_365_1.time_ <= var_368_1 + arg_368_0 then
				arg_365_1.var_.moveOldPos1019ui_story = var_368_0.localPosition
			end

			local var_368_2 = 0.001

			if var_368_1 <= arg_365_1.time_ and arg_365_1.time_ < var_368_1 + var_368_2 then
				local var_368_3 = (arg_365_1.time_ - var_368_1) / var_368_2
				local var_368_4 = Vector3.New(0, 100, 0)

				var_368_0.localPosition = Vector3.Lerp(arg_365_1.var_.moveOldPos1019ui_story, var_368_4, var_368_3)

				local var_368_5 = manager.ui.mainCamera.transform.position - var_368_0.position

				var_368_0.forward = Vector3.New(var_368_5.x, var_368_5.y, var_368_5.z)

				local var_368_6 = var_368_0.localEulerAngles

				var_368_6.z = 0
				var_368_6.x = 0
				var_368_0.localEulerAngles = var_368_6
			end

			if arg_365_1.time_ >= var_368_1 + var_368_2 and arg_365_1.time_ < var_368_1 + var_368_2 + arg_368_0 then
				var_368_0.localPosition = Vector3.New(0, 100, 0)

				local var_368_7 = manager.ui.mainCamera.transform.position - var_368_0.position

				var_368_0.forward = Vector3.New(var_368_7.x, var_368_7.y, var_368_7.z)

				local var_368_8 = var_368_0.localEulerAngles

				var_368_8.z = 0
				var_368_8.x = 0
				var_368_0.localEulerAngles = var_368_8
			end

			local var_368_9 = arg_365_1.actors_["1019ui_story"]
			local var_368_10 = 0

			if var_368_10 < arg_365_1.time_ and arg_365_1.time_ <= var_368_10 + arg_368_0 and not isNil(var_368_9) and arg_365_1.var_.characterEffect1019ui_story == nil then
				arg_365_1.var_.characterEffect1019ui_story = var_368_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_368_11 = 0.200000002980232

			if var_368_10 <= arg_365_1.time_ and arg_365_1.time_ < var_368_10 + var_368_11 and not isNil(var_368_9) then
				local var_368_12 = (arg_365_1.time_ - var_368_10) / var_368_11

				if arg_365_1.var_.characterEffect1019ui_story and not isNil(var_368_9) then
					local var_368_13 = Mathf.Lerp(0, 0.5, var_368_12)

					arg_365_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_365_1.var_.characterEffect1019ui_story.fillRatio = var_368_13
				end
			end

			if arg_365_1.time_ >= var_368_10 + var_368_11 and arg_365_1.time_ < var_368_10 + var_368_11 + arg_368_0 and not isNil(var_368_9) and arg_365_1.var_.characterEffect1019ui_story then
				local var_368_14 = 0.5

				arg_365_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_365_1.var_.characterEffect1019ui_story.fillRatio = var_368_14
			end

			local var_368_15 = 0
			local var_368_16 = 1.525

			if var_368_15 < arg_365_1.time_ and arg_365_1.time_ <= var_368_15 + arg_368_0 then
				arg_365_1.talkMaxDuration = 0
				arg_365_1.dialogCg_.alpha = 1

				arg_365_1.dialog_:SetActive(true)
				SetActive(arg_365_1.leftNameGo_, false)

				arg_365_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_365_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_365_1:RecordName(arg_365_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_365_1.iconTrs_.gameObject, false)
				arg_365_1.callingController_:SetSelectedState("normal")

				local var_368_17 = arg_365_1:GetWordFromCfg(323121090)
				local var_368_18 = arg_365_1:FormatText(var_368_17.content)

				arg_365_1.text_.text = var_368_18

				LuaForUtil.ClearLinePrefixSymbol(arg_365_1.text_)

				local var_368_19 = 41
				local var_368_20 = utf8.len(var_368_18)
				local var_368_21 = var_368_19 <= 0 and var_368_16 or var_368_16 * (var_368_20 / var_368_19)

				if var_368_21 > 0 and var_368_16 < var_368_21 then
					arg_365_1.talkMaxDuration = var_368_21

					if var_368_21 + var_368_15 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_21 + var_368_15
					end
				end

				arg_365_1.text_.text = var_368_18
				arg_365_1.typewritter.percent = 0

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(false)
				arg_365_1:RecordContent(arg_365_1.text_.text)
			end

			local var_368_22 = math.max(var_368_16, arg_365_1.talkMaxDuration)

			if var_368_15 <= arg_365_1.time_ and arg_365_1.time_ < var_368_15 + var_368_22 then
				arg_365_1.typewritter.percent = (arg_365_1.time_ - var_368_15) / var_368_22

				arg_365_1.typewritter:SetDirty()
			end

			if arg_365_1.time_ >= var_368_15 + var_368_22 and arg_365_1.time_ < var_368_15 + var_368_22 + arg_368_0 then
				arg_365_1.typewritter.percent = 1

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(true)
			end
		end

		arg_365_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_365_1:InitPlayNodeList()
	end,
	Play323121091 = function(arg_369_0, arg_369_1)
		arg_369_1.time_ = 0
		arg_369_1.frameCnt_ = 0
		arg_369_1.state_ = "playing"
		arg_369_1.curTalkId_ = 323121091
		arg_369_1.duration_ = 13.7

		local var_369_0 = {
			zh = 7.366,
			ja = 13.7
		}
		local var_369_1 = manager.audio:GetLocalizationFlag()

		if var_369_0[var_369_1] ~= nil then
			arg_369_1.duration_ = var_369_0[var_369_1]
		end

		SetActive(arg_369_1.tipsGo_, false)

		function arg_369_1.onSingleLineFinish_()
			arg_369_1.onSingleLineUpdate_ = nil
			arg_369_1.onSingleLineFinish_ = nil
			arg_369_1.state_ = "waiting"
		end

		function arg_369_1.playNext_(arg_371_0)
			if arg_371_0 == 1 then
				arg_369_0:Play323121092(arg_369_1)
			end
		end

		function arg_369_1.onSingleLineUpdate_(arg_372_0)
			local var_372_0 = arg_369_1.actors_["1019ui_story"]
			local var_372_1 = 0

			if var_372_1 < arg_369_1.time_ and arg_369_1.time_ <= var_372_1 + arg_372_0 and not isNil(var_372_0) and arg_369_1.var_.characterEffect1019ui_story == nil then
				arg_369_1.var_.characterEffect1019ui_story = var_372_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_372_2 = 0.200000002980232

			if var_372_1 <= arg_369_1.time_ and arg_369_1.time_ < var_372_1 + var_372_2 and not isNil(var_372_0) then
				local var_372_3 = (arg_369_1.time_ - var_372_1) / var_372_2

				if arg_369_1.var_.characterEffect1019ui_story and not isNil(var_372_0) then
					arg_369_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_369_1.time_ >= var_372_1 + var_372_2 and arg_369_1.time_ < var_372_1 + var_372_2 + arg_372_0 and not isNil(var_372_0) and arg_369_1.var_.characterEffect1019ui_story then
				arg_369_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_372_4 = arg_369_1.actors_["1019ui_story"].transform
			local var_372_5 = 0

			if var_372_5 < arg_369_1.time_ and arg_369_1.time_ <= var_372_5 + arg_372_0 then
				arg_369_1.var_.moveOldPos1019ui_story = var_372_4.localPosition
			end

			local var_372_6 = 0.001

			if var_372_5 <= arg_369_1.time_ and arg_369_1.time_ < var_372_5 + var_372_6 then
				local var_372_7 = (arg_369_1.time_ - var_372_5) / var_372_6
				local var_372_8 = Vector3.New(-0.2, -1.08, -5.9)

				var_372_4.localPosition = Vector3.Lerp(arg_369_1.var_.moveOldPos1019ui_story, var_372_8, var_372_7)

				local var_372_9 = manager.ui.mainCamera.transform.position - var_372_4.position

				var_372_4.forward = Vector3.New(var_372_9.x, var_372_9.y, var_372_9.z)

				local var_372_10 = var_372_4.localEulerAngles

				var_372_10.z = 0
				var_372_10.x = 0
				var_372_4.localEulerAngles = var_372_10
			end

			if arg_369_1.time_ >= var_372_5 + var_372_6 and arg_369_1.time_ < var_372_5 + var_372_6 + arg_372_0 then
				var_372_4.localPosition = Vector3.New(-0.2, -1.08, -5.9)

				local var_372_11 = manager.ui.mainCamera.transform.position - var_372_4.position

				var_372_4.forward = Vector3.New(var_372_11.x, var_372_11.y, var_372_11.z)

				local var_372_12 = var_372_4.localEulerAngles

				var_372_12.z = 0
				var_372_12.x = 0
				var_372_4.localEulerAngles = var_372_12
			end

			local var_372_13 = 0
			local var_372_14 = 0.8

			if var_372_13 < arg_369_1.time_ and arg_369_1.time_ <= var_372_13 + arg_372_0 then
				arg_369_1.talkMaxDuration = 0
				arg_369_1.dialogCg_.alpha = 1

				arg_369_1.dialog_:SetActive(true)
				SetActive(arg_369_1.leftNameGo_, true)

				local var_372_15 = arg_369_1:FormatText(StoryNameCfg[13].name)

				arg_369_1.leftNameTxt_.text = var_372_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_369_1.leftNameTxt_.transform)

				arg_369_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_369_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_369_1:RecordName(arg_369_1.leftNameTxt_.text)
				SetActive(arg_369_1.iconTrs_.gameObject, false)
				arg_369_1.callingController_:SetSelectedState("normal")

				local var_372_16 = arg_369_1:GetWordFromCfg(323121091)
				local var_372_17 = arg_369_1:FormatText(var_372_16.content)

				arg_369_1.text_.text = var_372_17

				LuaForUtil.ClearLinePrefixSymbol(arg_369_1.text_)

				local var_372_18 = 32
				local var_372_19 = utf8.len(var_372_17)
				local var_372_20 = var_372_18 <= 0 and var_372_14 or var_372_14 * (var_372_19 / var_372_18)

				if var_372_20 > 0 and var_372_14 < var_372_20 then
					arg_369_1.talkMaxDuration = var_372_20

					if var_372_20 + var_372_13 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_20 + var_372_13
					end
				end

				arg_369_1.text_.text = var_372_17
				arg_369_1.typewritter.percent = 0

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323121", "323121091", "story_v_out_323121.awb") ~= 0 then
					local var_372_21 = manager.audio:GetVoiceLength("story_v_out_323121", "323121091", "story_v_out_323121.awb") / 1000

					if var_372_21 + var_372_13 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_21 + var_372_13
					end

					if var_372_16.prefab_name ~= "" and arg_369_1.actors_[var_372_16.prefab_name] ~= nil then
						local var_372_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_369_1.actors_[var_372_16.prefab_name].transform, "story_v_out_323121", "323121091", "story_v_out_323121.awb")

						arg_369_1:RecordAudio("323121091", var_372_22)
						arg_369_1:RecordAudio("323121091", var_372_22)
					else
						arg_369_1:AudioAction("play", "voice", "story_v_out_323121", "323121091", "story_v_out_323121.awb")
					end

					arg_369_1:RecordHistoryTalkVoice("story_v_out_323121", "323121091", "story_v_out_323121.awb")
				end

				arg_369_1:RecordContent(arg_369_1.text_.text)
			end

			local var_372_23 = math.max(var_372_14, arg_369_1.talkMaxDuration)

			if var_372_13 <= arg_369_1.time_ and arg_369_1.time_ < var_372_13 + var_372_23 then
				arg_369_1.typewritter.percent = (arg_369_1.time_ - var_372_13) / var_372_23

				arg_369_1.typewritter:SetDirty()
			end

			if arg_369_1.time_ >= var_372_13 + var_372_23 and arg_369_1.time_ < var_372_13 + var_372_23 + arg_372_0 then
				arg_369_1.typewritter.percent = 1

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(true)
			end
		end

		arg_369_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_369_1:InitPlayNodeList()
	end,
	Play323121092 = function(arg_373_0, arg_373_1)
		arg_373_1.time_ = 0
		arg_373_1.frameCnt_ = 0
		arg_373_1.state_ = "playing"
		arg_373_1.curTalkId_ = 323121092
		arg_373_1.duration_ = 5

		SetActive(arg_373_1.tipsGo_, false)

		function arg_373_1.onSingleLineFinish_()
			arg_373_1.onSingleLineUpdate_ = nil
			arg_373_1.onSingleLineFinish_ = nil
			arg_373_1.state_ = "waiting"
		end

		function arg_373_1.playNext_(arg_375_0)
			if arg_375_0 == 1 then
				arg_373_0:Play323121093(arg_373_1)
			end
		end

		function arg_373_1.onSingleLineUpdate_(arg_376_0)
			local var_376_0 = arg_373_1.actors_["1019ui_story"]
			local var_376_1 = 0

			if var_376_1 < arg_373_1.time_ and arg_373_1.time_ <= var_376_1 + arg_376_0 and not isNil(var_376_0) and arg_373_1.var_.characterEffect1019ui_story == nil then
				arg_373_1.var_.characterEffect1019ui_story = var_376_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_376_2 = 0.200000002980232

			if var_376_1 <= arg_373_1.time_ and arg_373_1.time_ < var_376_1 + var_376_2 and not isNil(var_376_0) then
				local var_376_3 = (arg_373_1.time_ - var_376_1) / var_376_2

				if arg_373_1.var_.characterEffect1019ui_story and not isNil(var_376_0) then
					local var_376_4 = Mathf.Lerp(0, 0.5, var_376_3)

					arg_373_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_373_1.var_.characterEffect1019ui_story.fillRatio = var_376_4
				end
			end

			if arg_373_1.time_ >= var_376_1 + var_376_2 and arg_373_1.time_ < var_376_1 + var_376_2 + arg_376_0 and not isNil(var_376_0) and arg_373_1.var_.characterEffect1019ui_story then
				local var_376_5 = 0.5

				arg_373_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_373_1.var_.characterEffect1019ui_story.fillRatio = var_376_5
			end

			local var_376_6 = 0
			local var_376_7 = 0.1

			if var_376_6 < arg_373_1.time_ and arg_373_1.time_ <= var_376_6 + arg_376_0 then
				arg_373_1.talkMaxDuration = 0
				arg_373_1.dialogCg_.alpha = 1

				arg_373_1.dialog_:SetActive(true)
				SetActive(arg_373_1.leftNameGo_, true)

				local var_376_8 = arg_373_1:FormatText(StoryNameCfg[7].name)

				arg_373_1.leftNameTxt_.text = var_376_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_373_1.leftNameTxt_.transform)

				arg_373_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_373_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_373_1:RecordName(arg_373_1.leftNameTxt_.text)
				SetActive(arg_373_1.iconTrs_.gameObject, true)
				arg_373_1.iconController_:SetSelectedState("hero")

				arg_373_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_373_1.callingController_:SetSelectedState("normal")

				arg_373_1.keyicon_.color = Color.New(1, 1, 1)
				arg_373_1.icon_.color = Color.New(1, 1, 1)

				local var_376_9 = arg_373_1:GetWordFromCfg(323121092)
				local var_376_10 = arg_373_1:FormatText(var_376_9.content)

				arg_373_1.text_.text = var_376_10

				LuaForUtil.ClearLinePrefixSymbol(arg_373_1.text_)

				local var_376_11 = 4
				local var_376_12 = utf8.len(var_376_10)
				local var_376_13 = var_376_11 <= 0 and var_376_7 or var_376_7 * (var_376_12 / var_376_11)

				if var_376_13 > 0 and var_376_7 < var_376_13 then
					arg_373_1.talkMaxDuration = var_376_13

					if var_376_13 + var_376_6 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_13 + var_376_6
					end
				end

				arg_373_1.text_.text = var_376_10
				arg_373_1.typewritter.percent = 0

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(false)
				arg_373_1:RecordContent(arg_373_1.text_.text)
			end

			local var_376_14 = math.max(var_376_7, arg_373_1.talkMaxDuration)

			if var_376_6 <= arg_373_1.time_ and arg_373_1.time_ < var_376_6 + var_376_14 then
				arg_373_1.typewritter.percent = (arg_373_1.time_ - var_376_6) / var_376_14

				arg_373_1.typewritter:SetDirty()
			end

			if arg_373_1.time_ >= var_376_6 + var_376_14 and arg_373_1.time_ < var_376_6 + var_376_14 + arg_376_0 then
				arg_373_1.typewritter.percent = 1

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(true)
			end
		end

		arg_373_1.nodeConfigList_ = {}

		arg_373_1:InitPlayNodeList()
	end,
	Play323121093 = function(arg_377_0, arg_377_1)
		arg_377_1.time_ = 0
		arg_377_1.frameCnt_ = 0
		arg_377_1.state_ = "playing"
		arg_377_1.curTalkId_ = 323121093
		arg_377_1.duration_ = 3.6

		local var_377_0 = {
			zh = 2.6,
			ja = 3.6
		}
		local var_377_1 = manager.audio:GetLocalizationFlag()

		if var_377_0[var_377_1] ~= nil then
			arg_377_1.duration_ = var_377_0[var_377_1]
		end

		SetActive(arg_377_1.tipsGo_, false)

		function arg_377_1.onSingleLineFinish_()
			arg_377_1.onSingleLineUpdate_ = nil
			arg_377_1.onSingleLineFinish_ = nil
			arg_377_1.state_ = "waiting"
		end

		function arg_377_1.playNext_(arg_379_0)
			if arg_379_0 == 1 then
				arg_377_0:Play323121094(arg_377_1)
			end
		end

		function arg_377_1.onSingleLineUpdate_(arg_380_0)
			local var_380_0 = arg_377_1.actors_["1019ui_story"].transform
			local var_380_1 = 0

			if var_380_1 < arg_377_1.time_ and arg_377_1.time_ <= var_380_1 + arg_380_0 then
				arg_377_1.var_.moveOldPos1019ui_story = var_380_0.localPosition
			end

			local var_380_2 = 0.001

			if var_380_1 <= arg_377_1.time_ and arg_377_1.time_ < var_380_1 + var_380_2 then
				local var_380_3 = (arg_377_1.time_ - var_380_1) / var_380_2
				local var_380_4 = Vector3.New(-0.2, -1.08, -5.9)

				var_380_0.localPosition = Vector3.Lerp(arg_377_1.var_.moveOldPos1019ui_story, var_380_4, var_380_3)

				local var_380_5 = manager.ui.mainCamera.transform.position - var_380_0.position

				var_380_0.forward = Vector3.New(var_380_5.x, var_380_5.y, var_380_5.z)

				local var_380_6 = var_380_0.localEulerAngles

				var_380_6.z = 0
				var_380_6.x = 0
				var_380_0.localEulerAngles = var_380_6
			end

			if arg_377_1.time_ >= var_380_1 + var_380_2 and arg_377_1.time_ < var_380_1 + var_380_2 + arg_380_0 then
				var_380_0.localPosition = Vector3.New(-0.2, -1.08, -5.9)

				local var_380_7 = manager.ui.mainCamera.transform.position - var_380_0.position

				var_380_0.forward = Vector3.New(var_380_7.x, var_380_7.y, var_380_7.z)

				local var_380_8 = var_380_0.localEulerAngles

				var_380_8.z = 0
				var_380_8.x = 0
				var_380_0.localEulerAngles = var_380_8
			end

			local var_380_9 = arg_377_1.actors_["1019ui_story"]
			local var_380_10 = 0

			if var_380_10 < arg_377_1.time_ and arg_377_1.time_ <= var_380_10 + arg_380_0 and not isNil(var_380_9) and arg_377_1.var_.characterEffect1019ui_story == nil then
				arg_377_1.var_.characterEffect1019ui_story = var_380_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_380_11 = 0.200000002980232

			if var_380_10 <= arg_377_1.time_ and arg_377_1.time_ < var_380_10 + var_380_11 and not isNil(var_380_9) then
				local var_380_12 = (arg_377_1.time_ - var_380_10) / var_380_11

				if arg_377_1.var_.characterEffect1019ui_story and not isNil(var_380_9) then
					arg_377_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_377_1.time_ >= var_380_10 + var_380_11 and arg_377_1.time_ < var_380_10 + var_380_11 + arg_380_0 and not isNil(var_380_9) and arg_377_1.var_.characterEffect1019ui_story then
				arg_377_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_380_13 = 0

			if var_380_13 < arg_377_1.time_ and arg_377_1.time_ <= var_380_13 + arg_380_0 then
				arg_377_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action453")
			end

			local var_380_14 = 0

			if var_380_14 < arg_377_1.time_ and arg_377_1.time_ <= var_380_14 + arg_380_0 then
				arg_377_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_380_15 = 0
			local var_380_16 = 0.3

			if var_380_15 < arg_377_1.time_ and arg_377_1.time_ <= var_380_15 + arg_380_0 then
				arg_377_1.talkMaxDuration = 0
				arg_377_1.dialogCg_.alpha = 1

				arg_377_1.dialog_:SetActive(true)
				SetActive(arg_377_1.leftNameGo_, true)

				local var_380_17 = arg_377_1:FormatText(StoryNameCfg[13].name)

				arg_377_1.leftNameTxt_.text = var_380_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_377_1.leftNameTxt_.transform)

				arg_377_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_377_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_377_1:RecordName(arg_377_1.leftNameTxt_.text)
				SetActive(arg_377_1.iconTrs_.gameObject, false)
				arg_377_1.callingController_:SetSelectedState("normal")

				local var_380_18 = arg_377_1:GetWordFromCfg(323121093)
				local var_380_19 = arg_377_1:FormatText(var_380_18.content)

				arg_377_1.text_.text = var_380_19

				LuaForUtil.ClearLinePrefixSymbol(arg_377_1.text_)

				local var_380_20 = 12
				local var_380_21 = utf8.len(var_380_19)
				local var_380_22 = var_380_20 <= 0 and var_380_16 or var_380_16 * (var_380_21 / var_380_20)

				if var_380_22 > 0 and var_380_16 < var_380_22 then
					arg_377_1.talkMaxDuration = var_380_22

					if var_380_22 + var_380_15 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_22 + var_380_15
					end
				end

				arg_377_1.text_.text = var_380_19
				arg_377_1.typewritter.percent = 0

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323121", "323121093", "story_v_out_323121.awb") ~= 0 then
					local var_380_23 = manager.audio:GetVoiceLength("story_v_out_323121", "323121093", "story_v_out_323121.awb") / 1000

					if var_380_23 + var_380_15 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_23 + var_380_15
					end

					if var_380_18.prefab_name ~= "" and arg_377_1.actors_[var_380_18.prefab_name] ~= nil then
						local var_380_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_377_1.actors_[var_380_18.prefab_name].transform, "story_v_out_323121", "323121093", "story_v_out_323121.awb")

						arg_377_1:RecordAudio("323121093", var_380_24)
						arg_377_1:RecordAudio("323121093", var_380_24)
					else
						arg_377_1:AudioAction("play", "voice", "story_v_out_323121", "323121093", "story_v_out_323121.awb")
					end

					arg_377_1:RecordHistoryTalkVoice("story_v_out_323121", "323121093", "story_v_out_323121.awb")
				end

				arg_377_1:RecordContent(arg_377_1.text_.text)
			end

			local var_380_25 = math.max(var_380_16, arg_377_1.talkMaxDuration)

			if var_380_15 <= arg_377_1.time_ and arg_377_1.time_ < var_380_15 + var_380_25 then
				arg_377_1.typewritter.percent = (arg_377_1.time_ - var_380_15) / var_380_25

				arg_377_1.typewritter:SetDirty()
			end

			if arg_377_1.time_ >= var_380_15 + var_380_25 and arg_377_1.time_ < var_380_15 + var_380_25 + arg_380_0 then
				arg_377_1.typewritter.percent = 1

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(true)
			end
		end

		arg_377_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_377_1:InitPlayNodeList()
	end,
	Play323121094 = function(arg_381_0, arg_381_1)
		arg_381_1.time_ = 0
		arg_381_1.frameCnt_ = 0
		arg_381_1.state_ = "playing"
		arg_381_1.curTalkId_ = 323121094
		arg_381_1.duration_ = 5

		SetActive(arg_381_1.tipsGo_, false)

		function arg_381_1.onSingleLineFinish_()
			arg_381_1.onSingleLineUpdate_ = nil
			arg_381_1.onSingleLineFinish_ = nil
			arg_381_1.state_ = "waiting"
		end

		function arg_381_1.playNext_(arg_383_0)
			if arg_383_0 == 1 then
				arg_381_0:Play323121095(arg_381_1)
			end
		end

		function arg_381_1.onSingleLineUpdate_(arg_384_0)
			local var_384_0 = arg_381_1.actors_["1019ui_story"]
			local var_384_1 = 0

			if var_384_1 < arg_381_1.time_ and arg_381_1.time_ <= var_384_1 + arg_384_0 and not isNil(var_384_0) and arg_381_1.var_.characterEffect1019ui_story == nil then
				arg_381_1.var_.characterEffect1019ui_story = var_384_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_384_2 = 0.200000002980232

			if var_384_1 <= arg_381_1.time_ and arg_381_1.time_ < var_384_1 + var_384_2 and not isNil(var_384_0) then
				local var_384_3 = (arg_381_1.time_ - var_384_1) / var_384_2

				if arg_381_1.var_.characterEffect1019ui_story and not isNil(var_384_0) then
					local var_384_4 = Mathf.Lerp(0, 0.5, var_384_3)

					arg_381_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_381_1.var_.characterEffect1019ui_story.fillRatio = var_384_4
				end
			end

			if arg_381_1.time_ >= var_384_1 + var_384_2 and arg_381_1.time_ < var_384_1 + var_384_2 + arg_384_0 and not isNil(var_384_0) and arg_381_1.var_.characterEffect1019ui_story then
				local var_384_5 = 0.5

				arg_381_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_381_1.var_.characterEffect1019ui_story.fillRatio = var_384_5
			end

			local var_384_6 = 0
			local var_384_7 = 0.525

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

				arg_381_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_381_1.callingController_:SetSelectedState("normal")

				arg_381_1.keyicon_.color = Color.New(1, 1, 1)
				arg_381_1.icon_.color = Color.New(1, 1, 1)

				local var_384_9 = arg_381_1:GetWordFromCfg(323121094)
				local var_384_10 = arg_381_1:FormatText(var_384_9.content)

				arg_381_1.text_.text = var_384_10

				LuaForUtil.ClearLinePrefixSymbol(arg_381_1.text_)

				local var_384_11 = 21
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
	Play323121095 = function(arg_385_0, arg_385_1)
		arg_385_1.time_ = 0
		arg_385_1.frameCnt_ = 0
		arg_385_1.state_ = "playing"
		arg_385_1.curTalkId_ = 323121095
		arg_385_1.duration_ = 10.67

		local var_385_0 = {
			zh = 10.666,
			ja = 9.5
		}
		local var_385_1 = manager.audio:GetLocalizationFlag()

		if var_385_0[var_385_1] ~= nil then
			arg_385_1.duration_ = var_385_0[var_385_1]
		end

		SetActive(arg_385_1.tipsGo_, false)

		function arg_385_1.onSingleLineFinish_()
			arg_385_1.onSingleLineUpdate_ = nil
			arg_385_1.onSingleLineFinish_ = nil
			arg_385_1.state_ = "waiting"
		end

		function arg_385_1.playNext_(arg_387_0)
			if arg_387_0 == 1 then
				arg_385_0:Play323121096(arg_385_1)
			end
		end

		function arg_385_1.onSingleLineUpdate_(arg_388_0)
			local var_388_0 = arg_385_1.actors_["1019ui_story"]
			local var_388_1 = 0

			if var_388_1 < arg_385_1.time_ and arg_385_1.time_ <= var_388_1 + arg_388_0 and not isNil(var_388_0) and arg_385_1.var_.characterEffect1019ui_story == nil then
				arg_385_1.var_.characterEffect1019ui_story = var_388_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_388_2 = 0.200000002980232

			if var_388_1 <= arg_385_1.time_ and arg_385_1.time_ < var_388_1 + var_388_2 and not isNil(var_388_0) then
				local var_388_3 = (arg_385_1.time_ - var_388_1) / var_388_2

				if arg_385_1.var_.characterEffect1019ui_story and not isNil(var_388_0) then
					arg_385_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_385_1.time_ >= var_388_1 + var_388_2 and arg_385_1.time_ < var_388_1 + var_388_2 + arg_388_0 and not isNil(var_388_0) and arg_385_1.var_.characterEffect1019ui_story then
				arg_385_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_388_4 = 0

			if var_388_4 < arg_385_1.time_ and arg_385_1.time_ <= var_388_4 + arg_388_0 then
				arg_385_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action3_2")
			end

			local var_388_5 = 0
			local var_388_6 = 1.25

			if var_388_5 < arg_385_1.time_ and arg_385_1.time_ <= var_388_5 + arg_388_0 then
				arg_385_1.talkMaxDuration = 0
				arg_385_1.dialogCg_.alpha = 1

				arg_385_1.dialog_:SetActive(true)
				SetActive(arg_385_1.leftNameGo_, true)

				local var_388_7 = arg_385_1:FormatText(StoryNameCfg[13].name)

				arg_385_1.leftNameTxt_.text = var_388_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_385_1.leftNameTxt_.transform)

				arg_385_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_385_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_385_1:RecordName(arg_385_1.leftNameTxt_.text)
				SetActive(arg_385_1.iconTrs_.gameObject, false)
				arg_385_1.callingController_:SetSelectedState("normal")

				local var_388_8 = arg_385_1:GetWordFromCfg(323121095)
				local var_388_9 = arg_385_1:FormatText(var_388_8.content)

				arg_385_1.text_.text = var_388_9

				LuaForUtil.ClearLinePrefixSymbol(arg_385_1.text_)

				local var_388_10 = 50
				local var_388_11 = utf8.len(var_388_9)
				local var_388_12 = var_388_10 <= 0 and var_388_6 or var_388_6 * (var_388_11 / var_388_10)

				if var_388_12 > 0 and var_388_6 < var_388_12 then
					arg_385_1.talkMaxDuration = var_388_12

					if var_388_12 + var_388_5 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_12 + var_388_5
					end
				end

				arg_385_1.text_.text = var_388_9
				arg_385_1.typewritter.percent = 0

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323121", "323121095", "story_v_out_323121.awb") ~= 0 then
					local var_388_13 = manager.audio:GetVoiceLength("story_v_out_323121", "323121095", "story_v_out_323121.awb") / 1000

					if var_388_13 + var_388_5 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_13 + var_388_5
					end

					if var_388_8.prefab_name ~= "" and arg_385_1.actors_[var_388_8.prefab_name] ~= nil then
						local var_388_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_385_1.actors_[var_388_8.prefab_name].transform, "story_v_out_323121", "323121095", "story_v_out_323121.awb")

						arg_385_1:RecordAudio("323121095", var_388_14)
						arg_385_1:RecordAudio("323121095", var_388_14)
					else
						arg_385_1:AudioAction("play", "voice", "story_v_out_323121", "323121095", "story_v_out_323121.awb")
					end

					arg_385_1:RecordHistoryTalkVoice("story_v_out_323121", "323121095", "story_v_out_323121.awb")
				end

				arg_385_1:RecordContent(arg_385_1.text_.text)
			end

			local var_388_15 = math.max(var_388_6, arg_385_1.talkMaxDuration)

			if var_388_5 <= arg_385_1.time_ and arg_385_1.time_ < var_388_5 + var_388_15 then
				arg_385_1.typewritter.percent = (arg_385_1.time_ - var_388_5) / var_388_15

				arg_385_1.typewritter:SetDirty()
			end

			if arg_385_1.time_ >= var_388_5 + var_388_15 and arg_385_1.time_ < var_388_5 + var_388_15 + arg_388_0 then
				arg_385_1.typewritter.percent = 1

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(true)
			end
		end

		arg_385_1.nodeConfigList_ = {}

		arg_385_1:InitPlayNodeList()
	end,
	Play323121096 = function(arg_389_0, arg_389_1)
		arg_389_1.time_ = 0
		arg_389_1.frameCnt_ = 0
		arg_389_1.state_ = "playing"
		arg_389_1.curTalkId_ = 323121096
		arg_389_1.duration_ = 15.97

		local var_389_0 = {
			zh = 11.766,
			ja = 15.966
		}
		local var_389_1 = manager.audio:GetLocalizationFlag()

		if var_389_0[var_389_1] ~= nil then
			arg_389_1.duration_ = var_389_0[var_389_1]
		end

		SetActive(arg_389_1.tipsGo_, false)

		function arg_389_1.onSingleLineFinish_()
			arg_389_1.onSingleLineUpdate_ = nil
			arg_389_1.onSingleLineFinish_ = nil
			arg_389_1.state_ = "waiting"
		end

		function arg_389_1.playNext_(arg_391_0)
			if arg_391_0 == 1 then
				arg_389_0:Play323121097(arg_389_1)
			end
		end

		function arg_389_1.onSingleLineUpdate_(arg_392_0)
			local var_392_0 = 0
			local var_392_1 = 1.375

			if var_392_0 < arg_389_1.time_ and arg_389_1.time_ <= var_392_0 + arg_392_0 then
				arg_389_1.talkMaxDuration = 0
				arg_389_1.dialogCg_.alpha = 1

				arg_389_1.dialog_:SetActive(true)
				SetActive(arg_389_1.leftNameGo_, true)

				local var_392_2 = arg_389_1:FormatText(StoryNameCfg[13].name)

				arg_389_1.leftNameTxt_.text = var_392_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_389_1.leftNameTxt_.transform)

				arg_389_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_389_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_389_1:RecordName(arg_389_1.leftNameTxt_.text)
				SetActive(arg_389_1.iconTrs_.gameObject, false)
				arg_389_1.callingController_:SetSelectedState("normal")

				local var_392_3 = arg_389_1:GetWordFromCfg(323121096)
				local var_392_4 = arg_389_1:FormatText(var_392_3.content)

				arg_389_1.text_.text = var_392_4

				LuaForUtil.ClearLinePrefixSymbol(arg_389_1.text_)

				local var_392_5 = 55
				local var_392_6 = utf8.len(var_392_4)
				local var_392_7 = var_392_5 <= 0 and var_392_1 or var_392_1 * (var_392_6 / var_392_5)

				if var_392_7 > 0 and var_392_1 < var_392_7 then
					arg_389_1.talkMaxDuration = var_392_7

					if var_392_7 + var_392_0 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_7 + var_392_0
					end
				end

				arg_389_1.text_.text = var_392_4
				arg_389_1.typewritter.percent = 0

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323121", "323121096", "story_v_out_323121.awb") ~= 0 then
					local var_392_8 = manager.audio:GetVoiceLength("story_v_out_323121", "323121096", "story_v_out_323121.awb") / 1000

					if var_392_8 + var_392_0 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_8 + var_392_0
					end

					if var_392_3.prefab_name ~= "" and arg_389_1.actors_[var_392_3.prefab_name] ~= nil then
						local var_392_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_389_1.actors_[var_392_3.prefab_name].transform, "story_v_out_323121", "323121096", "story_v_out_323121.awb")

						arg_389_1:RecordAudio("323121096", var_392_9)
						arg_389_1:RecordAudio("323121096", var_392_9)
					else
						arg_389_1:AudioAction("play", "voice", "story_v_out_323121", "323121096", "story_v_out_323121.awb")
					end

					arg_389_1:RecordHistoryTalkVoice("story_v_out_323121", "323121096", "story_v_out_323121.awb")
				end

				arg_389_1:RecordContent(arg_389_1.text_.text)
			end

			local var_392_10 = math.max(var_392_1, arg_389_1.talkMaxDuration)

			if var_392_0 <= arg_389_1.time_ and arg_389_1.time_ < var_392_0 + var_392_10 then
				arg_389_1.typewritter.percent = (arg_389_1.time_ - var_392_0) / var_392_10

				arg_389_1.typewritter:SetDirty()
			end

			if arg_389_1.time_ >= var_392_0 + var_392_10 and arg_389_1.time_ < var_392_0 + var_392_10 + arg_392_0 then
				arg_389_1.typewritter.percent = 1

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(true)
			end
		end

		arg_389_1.nodeConfigList_ = {}

		arg_389_1:InitPlayNodeList()
	end,
	Play323121097 = function(arg_393_0, arg_393_1)
		arg_393_1.time_ = 0
		arg_393_1.frameCnt_ = 0
		arg_393_1.state_ = "playing"
		arg_393_1.curTalkId_ = 323121097
		arg_393_1.duration_ = 5

		SetActive(arg_393_1.tipsGo_, false)

		function arg_393_1.onSingleLineFinish_()
			arg_393_1.onSingleLineUpdate_ = nil
			arg_393_1.onSingleLineFinish_ = nil
			arg_393_1.state_ = "waiting"
		end

		function arg_393_1.playNext_(arg_395_0)
			if arg_395_0 == 1 then
				arg_393_0:Play323121098(arg_393_1)
			end
		end

		function arg_393_1.onSingleLineUpdate_(arg_396_0)
			local var_396_0 = arg_393_1.actors_["1019ui_story"]
			local var_396_1 = 0

			if var_396_1 < arg_393_1.time_ and arg_393_1.time_ <= var_396_1 + arg_396_0 and not isNil(var_396_0) and arg_393_1.var_.characterEffect1019ui_story == nil then
				arg_393_1.var_.characterEffect1019ui_story = var_396_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_396_2 = 0.200000002980232

			if var_396_1 <= arg_393_1.time_ and arg_393_1.time_ < var_396_1 + var_396_2 and not isNil(var_396_0) then
				local var_396_3 = (arg_393_1.time_ - var_396_1) / var_396_2

				if arg_393_1.var_.characterEffect1019ui_story and not isNil(var_396_0) then
					local var_396_4 = Mathf.Lerp(0, 0.5, var_396_3)

					arg_393_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_393_1.var_.characterEffect1019ui_story.fillRatio = var_396_4
				end
			end

			if arg_393_1.time_ >= var_396_1 + var_396_2 and arg_393_1.time_ < var_396_1 + var_396_2 + arg_396_0 and not isNil(var_396_0) and arg_393_1.var_.characterEffect1019ui_story then
				local var_396_5 = 0.5

				arg_393_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_393_1.var_.characterEffect1019ui_story.fillRatio = var_396_5
			end

			local var_396_6 = 0
			local var_396_7 = 0.175

			if var_396_6 < arg_393_1.time_ and arg_393_1.time_ <= var_396_6 + arg_396_0 then
				arg_393_1.talkMaxDuration = 0
				arg_393_1.dialogCg_.alpha = 1

				arg_393_1.dialog_:SetActive(true)
				SetActive(arg_393_1.leftNameGo_, true)

				local var_396_8 = arg_393_1:FormatText(StoryNameCfg[7].name)

				arg_393_1.leftNameTxt_.text = var_396_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_393_1.leftNameTxt_.transform)

				arg_393_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_393_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_393_1:RecordName(arg_393_1.leftNameTxt_.text)
				SetActive(arg_393_1.iconTrs_.gameObject, true)
				arg_393_1.iconController_:SetSelectedState("hero")

				arg_393_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_393_1.callingController_:SetSelectedState("normal")

				arg_393_1.keyicon_.color = Color.New(1, 1, 1)
				arg_393_1.icon_.color = Color.New(1, 1, 1)

				local var_396_9 = arg_393_1:GetWordFromCfg(323121097)
				local var_396_10 = arg_393_1:FormatText(var_396_9.content)

				arg_393_1.text_.text = var_396_10

				LuaForUtil.ClearLinePrefixSymbol(arg_393_1.text_)

				local var_396_11 = 7
				local var_396_12 = utf8.len(var_396_10)
				local var_396_13 = var_396_11 <= 0 and var_396_7 or var_396_7 * (var_396_12 / var_396_11)

				if var_396_13 > 0 and var_396_7 < var_396_13 then
					arg_393_1.talkMaxDuration = var_396_13

					if var_396_13 + var_396_6 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_13 + var_396_6
					end
				end

				arg_393_1.text_.text = var_396_10
				arg_393_1.typewritter.percent = 0

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(false)
				arg_393_1:RecordContent(arg_393_1.text_.text)
			end

			local var_396_14 = math.max(var_396_7, arg_393_1.talkMaxDuration)

			if var_396_6 <= arg_393_1.time_ and arg_393_1.time_ < var_396_6 + var_396_14 then
				arg_393_1.typewritter.percent = (arg_393_1.time_ - var_396_6) / var_396_14

				arg_393_1.typewritter:SetDirty()
			end

			if arg_393_1.time_ >= var_396_6 + var_396_14 and arg_393_1.time_ < var_396_6 + var_396_14 + arg_396_0 then
				arg_393_1.typewritter.percent = 1

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(true)
			end
		end

		arg_393_1.nodeConfigList_ = {}

		arg_393_1:InitPlayNodeList()
	end,
	Play323121098 = function(arg_397_0, arg_397_1)
		arg_397_1.time_ = 0
		arg_397_1.frameCnt_ = 0
		arg_397_1.state_ = "playing"
		arg_397_1.curTalkId_ = 323121098
		arg_397_1.duration_ = 8.4

		local var_397_0 = {
			zh = 5.1,
			ja = 8.4
		}
		local var_397_1 = manager.audio:GetLocalizationFlag()

		if var_397_0[var_397_1] ~= nil then
			arg_397_1.duration_ = var_397_0[var_397_1]
		end

		SetActive(arg_397_1.tipsGo_, false)

		function arg_397_1.onSingleLineFinish_()
			arg_397_1.onSingleLineUpdate_ = nil
			arg_397_1.onSingleLineFinish_ = nil
			arg_397_1.state_ = "waiting"
		end

		function arg_397_1.playNext_(arg_399_0)
			if arg_399_0 == 1 then
				arg_397_0:Play323121099(arg_397_1)
			end
		end

		function arg_397_1.onSingleLineUpdate_(arg_400_0)
			local var_400_0 = arg_397_1.actors_["1019ui_story"]
			local var_400_1 = 0

			if var_400_1 < arg_397_1.time_ and arg_397_1.time_ <= var_400_1 + arg_400_0 and not isNil(var_400_0) and arg_397_1.var_.characterEffect1019ui_story == nil then
				arg_397_1.var_.characterEffect1019ui_story = var_400_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_400_2 = 0.200000002980232

			if var_400_1 <= arg_397_1.time_ and arg_397_1.time_ < var_400_1 + var_400_2 and not isNil(var_400_0) then
				local var_400_3 = (arg_397_1.time_ - var_400_1) / var_400_2

				if arg_397_1.var_.characterEffect1019ui_story and not isNil(var_400_0) then
					arg_397_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_397_1.time_ >= var_400_1 + var_400_2 and arg_397_1.time_ < var_400_1 + var_400_2 + arg_400_0 and not isNil(var_400_0) and arg_397_1.var_.characterEffect1019ui_story then
				arg_397_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_400_4 = 0

			if var_400_4 < arg_397_1.time_ and arg_397_1.time_ <= var_400_4 + arg_400_0 then
				arg_397_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action4_1")
			end

			local var_400_5 = 0

			if var_400_5 < arg_397_1.time_ and arg_397_1.time_ <= var_400_5 + arg_400_0 then
				arg_397_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_400_6 = 0
			local var_400_7 = 0.675

			if var_400_6 < arg_397_1.time_ and arg_397_1.time_ <= var_400_6 + arg_400_0 then
				arg_397_1.talkMaxDuration = 0
				arg_397_1.dialogCg_.alpha = 1

				arg_397_1.dialog_:SetActive(true)
				SetActive(arg_397_1.leftNameGo_, true)

				local var_400_8 = arg_397_1:FormatText(StoryNameCfg[13].name)

				arg_397_1.leftNameTxt_.text = var_400_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_397_1.leftNameTxt_.transform)

				arg_397_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_397_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_397_1:RecordName(arg_397_1.leftNameTxt_.text)
				SetActive(arg_397_1.iconTrs_.gameObject, false)
				arg_397_1.callingController_:SetSelectedState("normal")

				local var_400_9 = arg_397_1:GetWordFromCfg(323121098)
				local var_400_10 = arg_397_1:FormatText(var_400_9.content)

				arg_397_1.text_.text = var_400_10

				LuaForUtil.ClearLinePrefixSymbol(arg_397_1.text_)

				local var_400_11 = 27
				local var_400_12 = utf8.len(var_400_10)
				local var_400_13 = var_400_11 <= 0 and var_400_7 or var_400_7 * (var_400_12 / var_400_11)

				if var_400_13 > 0 and var_400_7 < var_400_13 then
					arg_397_1.talkMaxDuration = var_400_13

					if var_400_13 + var_400_6 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_13 + var_400_6
					end
				end

				arg_397_1.text_.text = var_400_10
				arg_397_1.typewritter.percent = 0

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323121", "323121098", "story_v_out_323121.awb") ~= 0 then
					local var_400_14 = manager.audio:GetVoiceLength("story_v_out_323121", "323121098", "story_v_out_323121.awb") / 1000

					if var_400_14 + var_400_6 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_14 + var_400_6
					end

					if var_400_9.prefab_name ~= "" and arg_397_1.actors_[var_400_9.prefab_name] ~= nil then
						local var_400_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_397_1.actors_[var_400_9.prefab_name].transform, "story_v_out_323121", "323121098", "story_v_out_323121.awb")

						arg_397_1:RecordAudio("323121098", var_400_15)
						arg_397_1:RecordAudio("323121098", var_400_15)
					else
						arg_397_1:AudioAction("play", "voice", "story_v_out_323121", "323121098", "story_v_out_323121.awb")
					end

					arg_397_1:RecordHistoryTalkVoice("story_v_out_323121", "323121098", "story_v_out_323121.awb")
				end

				arg_397_1:RecordContent(arg_397_1.text_.text)
			end

			local var_400_16 = math.max(var_400_7, arg_397_1.talkMaxDuration)

			if var_400_6 <= arg_397_1.time_ and arg_397_1.time_ < var_400_6 + var_400_16 then
				arg_397_1.typewritter.percent = (arg_397_1.time_ - var_400_6) / var_400_16

				arg_397_1.typewritter:SetDirty()
			end

			if arg_397_1.time_ >= var_400_6 + var_400_16 and arg_397_1.time_ < var_400_6 + var_400_16 + arg_400_0 then
				arg_397_1.typewritter.percent = 1

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(true)
			end
		end

		arg_397_1.nodeConfigList_ = {}

		arg_397_1:InitPlayNodeList()
	end,
	Play323121099 = function(arg_401_0, arg_401_1)
		arg_401_1.time_ = 0
		arg_401_1.frameCnt_ = 0
		arg_401_1.state_ = "playing"
		arg_401_1.curTalkId_ = 323121099
		arg_401_1.duration_ = 5

		SetActive(arg_401_1.tipsGo_, false)

		function arg_401_1.onSingleLineFinish_()
			arg_401_1.onSingleLineUpdate_ = nil
			arg_401_1.onSingleLineFinish_ = nil
			arg_401_1.state_ = "waiting"
		end

		function arg_401_1.playNext_(arg_403_0)
			if arg_403_0 == 1 then
				arg_401_0:Play323121100(arg_401_1)
			end
		end

		function arg_401_1.onSingleLineUpdate_(arg_404_0)
			local var_404_0 = arg_401_1.actors_["1019ui_story"]
			local var_404_1 = 0

			if var_404_1 < arg_401_1.time_ and arg_401_1.time_ <= var_404_1 + arg_404_0 and not isNil(var_404_0) and arg_401_1.var_.characterEffect1019ui_story == nil then
				arg_401_1.var_.characterEffect1019ui_story = var_404_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_404_2 = 0.200000002980232

			if var_404_1 <= arg_401_1.time_ and arg_401_1.time_ < var_404_1 + var_404_2 and not isNil(var_404_0) then
				local var_404_3 = (arg_401_1.time_ - var_404_1) / var_404_2

				if arg_401_1.var_.characterEffect1019ui_story and not isNil(var_404_0) then
					local var_404_4 = Mathf.Lerp(0, 0.5, var_404_3)

					arg_401_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_401_1.var_.characterEffect1019ui_story.fillRatio = var_404_4
				end
			end

			if arg_401_1.time_ >= var_404_1 + var_404_2 and arg_401_1.time_ < var_404_1 + var_404_2 + arg_404_0 and not isNil(var_404_0) and arg_401_1.var_.characterEffect1019ui_story then
				local var_404_5 = 0.5

				arg_401_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_401_1.var_.characterEffect1019ui_story.fillRatio = var_404_5
			end

			local var_404_6 = 0
			local var_404_7 = 0.6

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

				arg_401_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_401_1.callingController_:SetSelectedState("normal")

				arg_401_1.keyicon_.color = Color.New(1, 1, 1)
				arg_401_1.icon_.color = Color.New(1, 1, 1)

				local var_404_9 = arg_401_1:GetWordFromCfg(323121099)
				local var_404_10 = arg_401_1:FormatText(var_404_9.content)

				arg_401_1.text_.text = var_404_10

				LuaForUtil.ClearLinePrefixSymbol(arg_401_1.text_)

				local var_404_11 = 24
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
	Play323121100 = function(arg_405_0, arg_405_1)
		arg_405_1.time_ = 0
		arg_405_1.frameCnt_ = 0
		arg_405_1.state_ = "playing"
		arg_405_1.curTalkId_ = 323121100
		arg_405_1.duration_ = 6.21

		SetActive(arg_405_1.tipsGo_, false)

		function arg_405_1.onSingleLineFinish_()
			arg_405_1.onSingleLineUpdate_ = nil
			arg_405_1.onSingleLineFinish_ = nil
			arg_405_1.state_ = "waiting"
		end

		function arg_405_1.playNext_(arg_407_0)
			if arg_407_0 == 1 then
				arg_405_0:Play323121101(arg_405_1)
			end
		end

		function arg_405_1.onSingleLineUpdate_(arg_408_0)
			local var_408_0 = arg_405_1.actors_["1019ui_story"].transform
			local var_408_1 = 0

			if var_408_1 < arg_405_1.time_ and arg_405_1.time_ <= var_408_1 + arg_408_0 then
				arg_405_1.var_.moveOldPos1019ui_story = var_408_0.localPosition
			end

			local var_408_2 = 0.001

			if var_408_1 <= arg_405_1.time_ and arg_405_1.time_ < var_408_1 + var_408_2 then
				local var_408_3 = (arg_405_1.time_ - var_408_1) / var_408_2
				local var_408_4 = Vector3.New(0, 100, 0)

				var_408_0.localPosition = Vector3.Lerp(arg_405_1.var_.moveOldPos1019ui_story, var_408_4, var_408_3)

				local var_408_5 = manager.ui.mainCamera.transform.position - var_408_0.position

				var_408_0.forward = Vector3.New(var_408_5.x, var_408_5.y, var_408_5.z)

				local var_408_6 = var_408_0.localEulerAngles

				var_408_6.z = 0
				var_408_6.x = 0
				var_408_0.localEulerAngles = var_408_6
			end

			if arg_405_1.time_ >= var_408_1 + var_408_2 and arg_405_1.time_ < var_408_1 + var_408_2 + arg_408_0 then
				var_408_0.localPosition = Vector3.New(0, 100, 0)

				local var_408_7 = manager.ui.mainCamera.transform.position - var_408_0.position

				var_408_0.forward = Vector3.New(var_408_7.x, var_408_7.y, var_408_7.z)

				local var_408_8 = var_408_0.localEulerAngles

				var_408_8.z = 0
				var_408_8.x = 0
				var_408_0.localEulerAngles = var_408_8
			end

			local var_408_9 = manager.ui.mainCamera.transform
			local var_408_10 = 0

			if var_408_10 < arg_405_1.time_ and arg_405_1.time_ <= var_408_10 + arg_408_0 then
				local var_408_11 = arg_405_1.var_.effectyinbo
				local var_408_12
				local var_408_13 = var_408_9

				if not var_408_11 then
					var_408_11 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_soundonly"), var_408_13)
					var_408_11.name = "yinbo"
					arg_405_1.var_.effectyinbo = var_408_11
				else
					var_408_11.transform:SetParent(var_408_13)
				end

				var_408_11.transform.localPosition = Vector3.New(0, 0, 0)
				var_408_11.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_408_14 = 1.7777777777777777
				local var_408_15 = Screen.width / Screen.height
				local var_408_16 = var_408_15 / var_408_14
				local var_408_17 = Mathf.Max(var_408_14 / var_408_15, 1)
				local var_408_18 = Mathf.Max(var_408_16, var_408_17)

				var_408_11.transform.localScale = Vector3.New(var_408_11.transform.localScale.x * var_408_18, var_408_11.transform.localScale.y * var_408_18, var_408_11.transform.localScale.z * var_408_18)
			end

			local var_408_19 = manager.ui.mainCamera.transform
			local var_408_20 = 2.06666666666667

			if var_408_20 < arg_405_1.time_ and arg_405_1.time_ <= var_408_20 + arg_408_0 then
				local var_408_21 = arg_405_1.var_.effectyinbo

				if var_408_21 then
					Object.Destroy(var_408_21)

					arg_405_1.var_.effectyinbo = nil
				end
			end

			local var_408_22 = 0

			if var_408_22 < arg_405_1.time_ and arg_405_1.time_ <= var_408_22 + arg_408_0 then
				arg_405_1.allBtn_.enabled = false
			end

			local var_408_23 = 1.56666666666667

			if arg_405_1.time_ >= var_408_22 + var_408_23 and arg_405_1.time_ < var_408_22 + var_408_23 + arg_408_0 then
				arg_405_1.allBtn_.enabled = true
			end

			if arg_405_1.frameCnt_ <= 1 then
				arg_405_1.dialog_:SetActive(false)
			end

			local var_408_24 = 1.20563190481626
			local var_408_25 = 1.675

			if var_408_24 < arg_405_1.time_ and arg_405_1.time_ <= var_408_24 + arg_408_0 then
				arg_405_1.talkMaxDuration = 0

				arg_405_1.dialog_:SetActive(true)

				arg_405_1.dialogCg_.alpha = 0

				local var_408_26 = LeanTween.value(arg_405_1.dialog_, 0, 1, 0.3)

				var_408_26:setOnUpdate(LuaHelper.FloatAction(function(arg_409_0)
					arg_405_1.dialogCg_.alpha = arg_409_0
				end))
				var_408_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_405_1.dialog_)
					var_408_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_405_1.duration_ = arg_405_1.duration_ + 0.3

				SetActive(arg_405_1.leftNameGo_, false)

				arg_405_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_405_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_405_1:RecordName(arg_405_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_405_1.iconTrs_.gameObject, false)
				arg_405_1.callingController_:SetSelectedState("normal")

				local var_408_27 = arg_405_1:GetWordFromCfg(323121100)
				local var_408_28 = arg_405_1:FormatText(var_408_27.content)

				arg_405_1.text_.text = var_408_28

				LuaForUtil.ClearLinePrefixSymbol(arg_405_1.text_)

				local var_408_29 = 67
				local var_408_30 = utf8.len(var_408_28)
				local var_408_31 = var_408_29 <= 0 and var_408_25 or var_408_25 * (var_408_30 / var_408_29)

				if var_408_31 > 0 and var_408_25 < var_408_31 then
					arg_405_1.talkMaxDuration = var_408_31
					var_408_24 = var_408_24 + 0.3

					if var_408_31 + var_408_24 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_31 + var_408_24
					end
				end

				arg_405_1.text_.text = var_408_28
				arg_405_1.typewritter.percent = 0

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(false)
				arg_405_1:RecordContent(arg_405_1.text_.text)
			end

			local var_408_32 = var_408_24 + 0.3
			local var_408_33 = math.max(var_408_25, arg_405_1.talkMaxDuration)

			if var_408_32 <= arg_405_1.time_ and arg_405_1.time_ < var_408_32 + var_408_33 then
				arg_405_1.typewritter.percent = (arg_405_1.time_ - var_408_32) / var_408_33

				arg_405_1.typewritter:SetDirty()
			end

			if arg_405_1.time_ >= var_408_32 + var_408_33 and arg_405_1.time_ < var_408_32 + var_408_33 + arg_408_0 then
				arg_405_1.typewritter.percent = 1

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(true)
			end
		end

		arg_405_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_405_1:InitPlayNodeList()
	end,
	Play323121101 = function(arg_411_0, arg_411_1)
		arg_411_1.time_ = 0
		arg_411_1.frameCnt_ = 0
		arg_411_1.state_ = "playing"
		arg_411_1.curTalkId_ = 323121101
		arg_411_1.duration_ = 3.43

		local var_411_0 = {
			zh = 1.8,
			ja = 3.433
		}
		local var_411_1 = manager.audio:GetLocalizationFlag()

		if var_411_0[var_411_1] ~= nil then
			arg_411_1.duration_ = var_411_0[var_411_1]
		end

		SetActive(arg_411_1.tipsGo_, false)

		function arg_411_1.onSingleLineFinish_()
			arg_411_1.onSingleLineUpdate_ = nil
			arg_411_1.onSingleLineFinish_ = nil
			arg_411_1.state_ = "waiting"
		end

		function arg_411_1.playNext_(arg_413_0)
			if arg_413_0 == 1 then
				arg_411_0:Play323121102(arg_411_1)
			end
		end

		function arg_411_1.onSingleLineUpdate_(arg_414_0)
			local var_414_0 = 0
			local var_414_1 = 0.15

			if var_414_0 < arg_411_1.time_ and arg_411_1.time_ <= var_414_0 + arg_414_0 then
				arg_411_1.talkMaxDuration = 0
				arg_411_1.dialogCg_.alpha = 1

				arg_411_1.dialog_:SetActive(true)
				SetActive(arg_411_1.leftNameGo_, true)

				local var_414_2 = arg_411_1:FormatText(StoryNameCfg[1454].name)

				arg_411_1.leftNameTxt_.text = var_414_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_411_1.leftNameTxt_.transform)

				arg_411_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_411_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_411_1:RecordName(arg_411_1.leftNameTxt_.text)
				SetActive(arg_411_1.iconTrs_.gameObject, true)
				arg_411_1.iconController_:SetSelectedState("hero")

				arg_411_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10169")

				arg_411_1.callingController_:SetSelectedState("normal")

				arg_411_1.keyicon_.color = Color.New(1, 1, 1)
				arg_411_1.icon_.color = Color.New(1, 1, 1)

				local var_414_3 = arg_411_1:GetWordFromCfg(323121101)
				local var_414_4 = arg_411_1:FormatText(var_414_3.content)

				arg_411_1.text_.text = var_414_4

				LuaForUtil.ClearLinePrefixSymbol(arg_411_1.text_)

				local var_414_5 = 6
				local var_414_6 = utf8.len(var_414_4)
				local var_414_7 = var_414_5 <= 0 and var_414_1 or var_414_1 * (var_414_6 / var_414_5)

				if var_414_7 > 0 and var_414_1 < var_414_7 then
					arg_411_1.talkMaxDuration = var_414_7

					if var_414_7 + var_414_0 > arg_411_1.duration_ then
						arg_411_1.duration_ = var_414_7 + var_414_0
					end
				end

				arg_411_1.text_.text = var_414_4
				arg_411_1.typewritter.percent = 0

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323121", "323121101", "story_v_out_323121.awb") ~= 0 then
					local var_414_8 = manager.audio:GetVoiceLength("story_v_out_323121", "323121101", "story_v_out_323121.awb") / 1000

					if var_414_8 + var_414_0 > arg_411_1.duration_ then
						arg_411_1.duration_ = var_414_8 + var_414_0
					end

					if var_414_3.prefab_name ~= "" and arg_411_1.actors_[var_414_3.prefab_name] ~= nil then
						local var_414_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_411_1.actors_[var_414_3.prefab_name].transform, "story_v_out_323121", "323121101", "story_v_out_323121.awb")

						arg_411_1:RecordAudio("323121101", var_414_9)
						arg_411_1:RecordAudio("323121101", var_414_9)
					else
						arg_411_1:AudioAction("play", "voice", "story_v_out_323121", "323121101", "story_v_out_323121.awb")
					end

					arg_411_1:RecordHistoryTalkVoice("story_v_out_323121", "323121101", "story_v_out_323121.awb")
				end

				arg_411_1:RecordContent(arg_411_1.text_.text)
			end

			local var_414_10 = math.max(var_414_1, arg_411_1.talkMaxDuration)

			if var_414_0 <= arg_411_1.time_ and arg_411_1.time_ < var_414_0 + var_414_10 then
				arg_411_1.typewritter.percent = (arg_411_1.time_ - var_414_0) / var_414_10

				arg_411_1.typewritter:SetDirty()
			end

			if arg_411_1.time_ >= var_414_0 + var_414_10 and arg_411_1.time_ < var_414_0 + var_414_10 + arg_414_0 then
				arg_411_1.typewritter.percent = 1

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(true)
			end
		end

		arg_411_1.nodeConfigList_ = {}

		arg_411_1:InitPlayNodeList()
	end,
	Play323121102 = function(arg_415_0, arg_415_1)
		arg_415_1.time_ = 0
		arg_415_1.frameCnt_ = 0
		arg_415_1.state_ = "playing"
		arg_415_1.curTalkId_ = 323121102
		arg_415_1.duration_ = 5

		SetActive(arg_415_1.tipsGo_, false)

		function arg_415_1.onSingleLineFinish_()
			arg_415_1.onSingleLineUpdate_ = nil
			arg_415_1.onSingleLineFinish_ = nil
			arg_415_1.state_ = "waiting"
		end

		function arg_415_1.playNext_(arg_417_0)
			if arg_417_0 == 1 then
				arg_415_0:Play323121103(arg_415_1)
			end
		end

		function arg_415_1.onSingleLineUpdate_(arg_418_0)
			local var_418_0 = 0
			local var_418_1 = 0.6

			if var_418_0 < arg_415_1.time_ and arg_415_1.time_ <= var_418_0 + arg_418_0 then
				arg_415_1.talkMaxDuration = 0
				arg_415_1.dialogCg_.alpha = 1

				arg_415_1.dialog_:SetActive(true)
				SetActive(arg_415_1.leftNameGo_, true)

				local var_418_2 = arg_415_1:FormatText(StoryNameCfg[7].name)

				arg_415_1.leftNameTxt_.text = var_418_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_415_1.leftNameTxt_.transform)

				arg_415_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_415_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_415_1:RecordName(arg_415_1.leftNameTxt_.text)
				SetActive(arg_415_1.iconTrs_.gameObject, true)
				arg_415_1.iconController_:SetSelectedState("hero")

				arg_415_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_415_1.callingController_:SetSelectedState("normal")

				arg_415_1.keyicon_.color = Color.New(1, 1, 1)
				arg_415_1.icon_.color = Color.New(1, 1, 1)

				local var_418_3 = arg_415_1:GetWordFromCfg(323121102)
				local var_418_4 = arg_415_1:FormatText(var_418_3.content)

				arg_415_1.text_.text = var_418_4

				LuaForUtil.ClearLinePrefixSymbol(arg_415_1.text_)

				local var_418_5 = 24
				local var_418_6 = utf8.len(var_418_4)
				local var_418_7 = var_418_5 <= 0 and var_418_1 or var_418_1 * (var_418_6 / var_418_5)

				if var_418_7 > 0 and var_418_1 < var_418_7 then
					arg_415_1.talkMaxDuration = var_418_7

					if var_418_7 + var_418_0 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_7 + var_418_0
					end
				end

				arg_415_1.text_.text = var_418_4
				arg_415_1.typewritter.percent = 0

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(false)
				arg_415_1:RecordContent(arg_415_1.text_.text)
			end

			local var_418_8 = math.max(var_418_1, arg_415_1.talkMaxDuration)

			if var_418_0 <= arg_415_1.time_ and arg_415_1.time_ < var_418_0 + var_418_8 then
				arg_415_1.typewritter.percent = (arg_415_1.time_ - var_418_0) / var_418_8

				arg_415_1.typewritter:SetDirty()
			end

			if arg_415_1.time_ >= var_418_0 + var_418_8 and arg_415_1.time_ < var_418_0 + var_418_8 + arg_418_0 then
				arg_415_1.typewritter.percent = 1

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(true)
			end
		end

		arg_415_1.nodeConfigList_ = {}

		arg_415_1:InitPlayNodeList()
	end,
	Play323121103 = function(arg_419_0, arg_419_1)
		arg_419_1.time_ = 0
		arg_419_1.frameCnt_ = 0
		arg_419_1.state_ = "playing"
		arg_419_1.curTalkId_ = 323121103
		arg_419_1.duration_ = 4.43

		local var_419_0 = {
			zh = 3.6,
			ja = 4.433
		}
		local var_419_1 = manager.audio:GetLocalizationFlag()

		if var_419_0[var_419_1] ~= nil then
			arg_419_1.duration_ = var_419_0[var_419_1]
		end

		SetActive(arg_419_1.tipsGo_, false)

		function arg_419_1.onSingleLineFinish_()
			arg_419_1.onSingleLineUpdate_ = nil
			arg_419_1.onSingleLineFinish_ = nil
			arg_419_1.state_ = "waiting"
		end

		function arg_419_1.playNext_(arg_421_0)
			if arg_421_0 == 1 then
				arg_419_0:Play323121104(arg_419_1)
			end
		end

		function arg_419_1.onSingleLineUpdate_(arg_422_0)
			local var_422_0 = 0
			local var_422_1 = 0.325

			if var_422_0 < arg_419_1.time_ and arg_419_1.time_ <= var_422_0 + arg_422_0 then
				arg_419_1.talkMaxDuration = 0
				arg_419_1.dialogCg_.alpha = 1

				arg_419_1.dialog_:SetActive(true)
				SetActive(arg_419_1.leftNameGo_, true)

				local var_422_2 = arg_419_1:FormatText(StoryNameCfg[1454].name)

				arg_419_1.leftNameTxt_.text = var_422_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_419_1.leftNameTxt_.transform)

				arg_419_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_419_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_419_1:RecordName(arg_419_1.leftNameTxt_.text)
				SetActive(arg_419_1.iconTrs_.gameObject, true)
				arg_419_1.iconController_:SetSelectedState("hero")

				arg_419_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10169")

				arg_419_1.callingController_:SetSelectedState("normal")

				arg_419_1.keyicon_.color = Color.New(1, 1, 1)
				arg_419_1.icon_.color = Color.New(1, 1, 1)

				local var_422_3 = arg_419_1:GetWordFromCfg(323121103)
				local var_422_4 = arg_419_1:FormatText(var_422_3.content)

				arg_419_1.text_.text = var_422_4

				LuaForUtil.ClearLinePrefixSymbol(arg_419_1.text_)

				local var_422_5 = 13
				local var_422_6 = utf8.len(var_422_4)
				local var_422_7 = var_422_5 <= 0 and var_422_1 or var_422_1 * (var_422_6 / var_422_5)

				if var_422_7 > 0 and var_422_1 < var_422_7 then
					arg_419_1.talkMaxDuration = var_422_7

					if var_422_7 + var_422_0 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_7 + var_422_0
					end
				end

				arg_419_1.text_.text = var_422_4
				arg_419_1.typewritter.percent = 0

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323121", "323121103", "story_v_out_323121.awb") ~= 0 then
					local var_422_8 = manager.audio:GetVoiceLength("story_v_out_323121", "323121103", "story_v_out_323121.awb") / 1000

					if var_422_8 + var_422_0 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_8 + var_422_0
					end

					if var_422_3.prefab_name ~= "" and arg_419_1.actors_[var_422_3.prefab_name] ~= nil then
						local var_422_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_419_1.actors_[var_422_3.prefab_name].transform, "story_v_out_323121", "323121103", "story_v_out_323121.awb")

						arg_419_1:RecordAudio("323121103", var_422_9)
						arg_419_1:RecordAudio("323121103", var_422_9)
					else
						arg_419_1:AudioAction("play", "voice", "story_v_out_323121", "323121103", "story_v_out_323121.awb")
					end

					arg_419_1:RecordHistoryTalkVoice("story_v_out_323121", "323121103", "story_v_out_323121.awb")
				end

				arg_419_1:RecordContent(arg_419_1.text_.text)
			end

			local var_422_10 = math.max(var_422_1, arg_419_1.talkMaxDuration)

			if var_422_0 <= arg_419_1.time_ and arg_419_1.time_ < var_422_0 + var_422_10 then
				arg_419_1.typewritter.percent = (arg_419_1.time_ - var_422_0) / var_422_10

				arg_419_1.typewritter:SetDirty()
			end

			if arg_419_1.time_ >= var_422_0 + var_422_10 and arg_419_1.time_ < var_422_0 + var_422_10 + arg_422_0 then
				arg_419_1.typewritter.percent = 1

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(true)
			end
		end

		arg_419_1.nodeConfigList_ = {}

		arg_419_1:InitPlayNodeList()
	end,
	Play323121104 = function(arg_423_0, arg_423_1)
		arg_423_1.time_ = 0
		arg_423_1.frameCnt_ = 0
		arg_423_1.state_ = "playing"
		arg_423_1.curTalkId_ = 323121104
		arg_423_1.duration_ = 5

		SetActive(arg_423_1.tipsGo_, false)

		function arg_423_1.onSingleLineFinish_()
			arg_423_1.onSingleLineUpdate_ = nil
			arg_423_1.onSingleLineFinish_ = nil
			arg_423_1.state_ = "waiting"
		end

		function arg_423_1.playNext_(arg_425_0)
			if arg_425_0 == 1 then
				arg_423_0:Play323121105(arg_423_1)
			end
		end

		function arg_423_1.onSingleLineUpdate_(arg_426_0)
			local var_426_0 = 0
			local var_426_1 = 0.225

			if var_426_0 < arg_423_1.time_ and arg_423_1.time_ <= var_426_0 + arg_426_0 then
				arg_423_1.talkMaxDuration = 0
				arg_423_1.dialogCg_.alpha = 1

				arg_423_1.dialog_:SetActive(true)
				SetActive(arg_423_1.leftNameGo_, true)

				local var_426_2 = arg_423_1:FormatText(StoryNameCfg[7].name)

				arg_423_1.leftNameTxt_.text = var_426_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_423_1.leftNameTxt_.transform)

				arg_423_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_423_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_423_1:RecordName(arg_423_1.leftNameTxt_.text)
				SetActive(arg_423_1.iconTrs_.gameObject, true)
				arg_423_1.iconController_:SetSelectedState("hero")

				arg_423_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_423_1.callingController_:SetSelectedState("normal")

				arg_423_1.keyicon_.color = Color.New(1, 1, 1)
				arg_423_1.icon_.color = Color.New(1, 1, 1)

				local var_426_3 = arg_423_1:GetWordFromCfg(323121104)
				local var_426_4 = arg_423_1:FormatText(var_426_3.content)

				arg_423_1.text_.text = var_426_4

				LuaForUtil.ClearLinePrefixSymbol(arg_423_1.text_)

				local var_426_5 = 9
				local var_426_6 = utf8.len(var_426_4)
				local var_426_7 = var_426_5 <= 0 and var_426_1 or var_426_1 * (var_426_6 / var_426_5)

				if var_426_7 > 0 and var_426_1 < var_426_7 then
					arg_423_1.talkMaxDuration = var_426_7

					if var_426_7 + var_426_0 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_7 + var_426_0
					end
				end

				arg_423_1.text_.text = var_426_4
				arg_423_1.typewritter.percent = 0

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(false)
				arg_423_1:RecordContent(arg_423_1.text_.text)
			end

			local var_426_8 = math.max(var_426_1, arg_423_1.talkMaxDuration)

			if var_426_0 <= arg_423_1.time_ and arg_423_1.time_ < var_426_0 + var_426_8 then
				arg_423_1.typewritter.percent = (arg_423_1.time_ - var_426_0) / var_426_8

				arg_423_1.typewritter:SetDirty()
			end

			if arg_423_1.time_ >= var_426_0 + var_426_8 and arg_423_1.time_ < var_426_0 + var_426_8 + arg_426_0 then
				arg_423_1.typewritter.percent = 1

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(true)
			end
		end

		arg_423_1.nodeConfigList_ = {}

		arg_423_1:InitPlayNodeList()
	end,
	Play323121105 = function(arg_427_0, arg_427_1)
		arg_427_1.time_ = 0
		arg_427_1.frameCnt_ = 0
		arg_427_1.state_ = "playing"
		arg_427_1.curTalkId_ = 323121105
		arg_427_1.duration_ = 3.9

		local var_427_0 = {
			zh = 2.933,
			ja = 3.9
		}
		local var_427_1 = manager.audio:GetLocalizationFlag()

		if var_427_0[var_427_1] ~= nil then
			arg_427_1.duration_ = var_427_0[var_427_1]
		end

		SetActive(arg_427_1.tipsGo_, false)

		function arg_427_1.onSingleLineFinish_()
			arg_427_1.onSingleLineUpdate_ = nil
			arg_427_1.onSingleLineFinish_ = nil
			arg_427_1.state_ = "waiting"
		end

		function arg_427_1.playNext_(arg_429_0)
			if arg_429_0 == 1 then
				arg_427_0:Play323121106(arg_427_1)
			end
		end

		function arg_427_1.onSingleLineUpdate_(arg_430_0)
			local var_430_0 = 0
			local var_430_1 = 0.225

			if var_430_0 < arg_427_1.time_ and arg_427_1.time_ <= var_430_0 + arg_430_0 then
				arg_427_1.talkMaxDuration = 0
				arg_427_1.dialogCg_.alpha = 1

				arg_427_1.dialog_:SetActive(true)
				SetActive(arg_427_1.leftNameGo_, true)

				local var_430_2 = arg_427_1:FormatText(StoryNameCfg[1454].name)

				arg_427_1.leftNameTxt_.text = var_430_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_427_1.leftNameTxt_.transform)

				arg_427_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_427_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_427_1:RecordName(arg_427_1.leftNameTxt_.text)
				SetActive(arg_427_1.iconTrs_.gameObject, true)
				arg_427_1.iconController_:SetSelectedState("hero")

				arg_427_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10169")

				arg_427_1.callingController_:SetSelectedState("normal")

				arg_427_1.keyicon_.color = Color.New(1, 1, 1)
				arg_427_1.icon_.color = Color.New(1, 1, 1)

				local var_430_3 = arg_427_1:GetWordFromCfg(323121105)
				local var_430_4 = arg_427_1:FormatText(var_430_3.content)

				arg_427_1.text_.text = var_430_4

				LuaForUtil.ClearLinePrefixSymbol(arg_427_1.text_)

				local var_430_5 = 9
				local var_430_6 = utf8.len(var_430_4)
				local var_430_7 = var_430_5 <= 0 and var_430_1 or var_430_1 * (var_430_6 / var_430_5)

				if var_430_7 > 0 and var_430_1 < var_430_7 then
					arg_427_1.talkMaxDuration = var_430_7

					if var_430_7 + var_430_0 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_7 + var_430_0
					end
				end

				arg_427_1.text_.text = var_430_4
				arg_427_1.typewritter.percent = 0

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323121", "323121105", "story_v_out_323121.awb") ~= 0 then
					local var_430_8 = manager.audio:GetVoiceLength("story_v_out_323121", "323121105", "story_v_out_323121.awb") / 1000

					if var_430_8 + var_430_0 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_8 + var_430_0
					end

					if var_430_3.prefab_name ~= "" and arg_427_1.actors_[var_430_3.prefab_name] ~= nil then
						local var_430_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_427_1.actors_[var_430_3.prefab_name].transform, "story_v_out_323121", "323121105", "story_v_out_323121.awb")

						arg_427_1:RecordAudio("323121105", var_430_9)
						arg_427_1:RecordAudio("323121105", var_430_9)
					else
						arg_427_1:AudioAction("play", "voice", "story_v_out_323121", "323121105", "story_v_out_323121.awb")
					end

					arg_427_1:RecordHistoryTalkVoice("story_v_out_323121", "323121105", "story_v_out_323121.awb")
				end

				arg_427_1:RecordContent(arg_427_1.text_.text)
			end

			local var_430_10 = math.max(var_430_1, arg_427_1.talkMaxDuration)

			if var_430_0 <= arg_427_1.time_ and arg_427_1.time_ < var_430_0 + var_430_10 then
				arg_427_1.typewritter.percent = (arg_427_1.time_ - var_430_0) / var_430_10

				arg_427_1.typewritter:SetDirty()
			end

			if arg_427_1.time_ >= var_430_0 + var_430_10 and arg_427_1.time_ < var_430_0 + var_430_10 + arg_430_0 then
				arg_427_1.typewritter.percent = 1

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(true)
			end
		end

		arg_427_1.nodeConfigList_ = {}

		arg_427_1:InitPlayNodeList()
	end,
	Play323121106 = function(arg_431_0, arg_431_1)
		arg_431_1.time_ = 0
		arg_431_1.frameCnt_ = 0
		arg_431_1.state_ = "playing"
		arg_431_1.curTalkId_ = 323121106
		arg_431_1.duration_ = 2

		SetActive(arg_431_1.tipsGo_, false)

		function arg_431_1.onSingleLineFinish_()
			arg_431_1.onSingleLineUpdate_ = nil
			arg_431_1.onSingleLineFinish_ = nil
			arg_431_1.state_ = "waiting"
		end

		function arg_431_1.playNext_(arg_433_0)
			if arg_433_0 == 1 then
				arg_431_0:Play323121107(arg_431_1)
			end
		end

		function arg_431_1.onSingleLineUpdate_(arg_434_0)
			local var_434_0 = arg_431_1.actors_["1053ui_story"].transform
			local var_434_1 = 0

			if var_434_1 < arg_431_1.time_ and arg_431_1.time_ <= var_434_1 + arg_434_0 then
				arg_431_1.var_.moveOldPos1053ui_story = var_434_0.localPosition

				local var_434_2 = GameObjectTools.GetOrAddComponent(var_434_0.gameObject, typeof(DynamicBoneHelper))

				if var_434_2 then
					var_434_2:EnableDynamicBone(false)
				end
			end

			local var_434_3 = 0.001

			if var_434_1 <= arg_431_1.time_ and arg_431_1.time_ < var_434_1 + var_434_3 then
				local var_434_4 = (arg_431_1.time_ - var_434_1) / var_434_3
				local var_434_5 = Vector3.New(0, -1.08, -6)

				var_434_0.localPosition = Vector3.Lerp(arg_431_1.var_.moveOldPos1053ui_story, var_434_5, var_434_4)

				local var_434_6 = manager.ui.mainCamera.transform.position - var_434_0.position

				var_434_0.forward = Vector3.New(var_434_6.x, var_434_6.y, var_434_6.z)

				local var_434_7 = var_434_0.localEulerAngles

				var_434_7.z = 0
				var_434_7.x = 0
				var_434_0.localEulerAngles = var_434_7
			end

			if arg_431_1.time_ >= var_434_1 + var_434_3 and arg_431_1.time_ < var_434_1 + var_434_3 + arg_434_0 then
				var_434_0.localPosition = Vector3.New(0, -1.08, -6)

				local var_434_8 = manager.ui.mainCamera.transform.position - var_434_0.position

				var_434_0.forward = Vector3.New(var_434_8.x, var_434_8.y, var_434_8.z)

				local var_434_9 = var_434_0.localEulerAngles

				var_434_9.z = 0
				var_434_9.x = 0
				var_434_0.localEulerAngles = var_434_9

				local var_434_10 = GameObjectTools.GetOrAddComponent(var_434_0.gameObject, typeof(DynamicBoneHelper))

				if var_434_10 then
					var_434_10:EnableDynamicBone(true)
				end
			end

			local var_434_11 = arg_431_1.actors_["1053ui_story"]
			local var_434_12 = 0

			if var_434_12 < arg_431_1.time_ and arg_431_1.time_ <= var_434_12 + arg_434_0 and not isNil(var_434_11) and arg_431_1.var_.characterEffect1053ui_story == nil then
				arg_431_1.var_.characterEffect1053ui_story = var_434_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_434_13 = 0.200000002980232

			if var_434_12 <= arg_431_1.time_ and arg_431_1.time_ < var_434_12 + var_434_13 and not isNil(var_434_11) then
				local var_434_14 = (arg_431_1.time_ - var_434_12) / var_434_13

				if arg_431_1.var_.characterEffect1053ui_story and not isNil(var_434_11) then
					arg_431_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_431_1.time_ >= var_434_12 + var_434_13 and arg_431_1.time_ < var_434_12 + var_434_13 + arg_434_0 and not isNil(var_434_11) and arg_431_1.var_.characterEffect1053ui_story then
				arg_431_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_434_15 = 0

			if var_434_15 < arg_431_1.time_ and arg_431_1.time_ <= var_434_15 + arg_434_0 then
				arg_431_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053action/1053action1_1")
			end

			local var_434_16 = 0

			if var_434_16 < arg_431_1.time_ and arg_431_1.time_ <= var_434_16 + arg_434_0 then
				arg_431_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_434_17 = 0
			local var_434_18 = 0.075

			if var_434_17 < arg_431_1.time_ and arg_431_1.time_ <= var_434_17 + arg_434_0 then
				arg_431_1.talkMaxDuration = 0
				arg_431_1.dialogCg_.alpha = 1

				arg_431_1.dialog_:SetActive(true)
				SetActive(arg_431_1.leftNameGo_, true)

				local var_434_19 = arg_431_1:FormatText(StoryNameCfg[1453].name)

				arg_431_1.leftNameTxt_.text = var_434_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_431_1.leftNameTxt_.transform)

				arg_431_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_431_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_431_1:RecordName(arg_431_1.leftNameTxt_.text)
				SetActive(arg_431_1.iconTrs_.gameObject, false)
				arg_431_1.callingController_:SetSelectedState("normal")

				local var_434_20 = arg_431_1:GetWordFromCfg(323121106)
				local var_434_21 = arg_431_1:FormatText(var_434_20.content)

				arg_431_1.text_.text = var_434_21

				LuaForUtil.ClearLinePrefixSymbol(arg_431_1.text_)

				local var_434_22 = 3
				local var_434_23 = utf8.len(var_434_21)
				local var_434_24 = var_434_22 <= 0 and var_434_18 or var_434_18 * (var_434_23 / var_434_22)

				if var_434_24 > 0 and var_434_18 < var_434_24 then
					arg_431_1.talkMaxDuration = var_434_24

					if var_434_24 + var_434_17 > arg_431_1.duration_ then
						arg_431_1.duration_ = var_434_24 + var_434_17
					end
				end

				arg_431_1.text_.text = var_434_21
				arg_431_1.typewritter.percent = 0

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323121", "323121106", "story_v_out_323121.awb") ~= 0 then
					local var_434_25 = manager.audio:GetVoiceLength("story_v_out_323121", "323121106", "story_v_out_323121.awb") / 1000

					if var_434_25 + var_434_17 > arg_431_1.duration_ then
						arg_431_1.duration_ = var_434_25 + var_434_17
					end

					if var_434_20.prefab_name ~= "" and arg_431_1.actors_[var_434_20.prefab_name] ~= nil then
						local var_434_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_431_1.actors_[var_434_20.prefab_name].transform, "story_v_out_323121", "323121106", "story_v_out_323121.awb")

						arg_431_1:RecordAudio("323121106", var_434_26)
						arg_431_1:RecordAudio("323121106", var_434_26)
					else
						arg_431_1:AudioAction("play", "voice", "story_v_out_323121", "323121106", "story_v_out_323121.awb")
					end

					arg_431_1:RecordHistoryTalkVoice("story_v_out_323121", "323121106", "story_v_out_323121.awb")
				end

				arg_431_1:RecordContent(arg_431_1.text_.text)
			end

			local var_434_27 = math.max(var_434_18, arg_431_1.talkMaxDuration)

			if var_434_17 <= arg_431_1.time_ and arg_431_1.time_ < var_434_17 + var_434_27 then
				arg_431_1.typewritter.percent = (arg_431_1.time_ - var_434_17) / var_434_27

				arg_431_1.typewritter:SetDirty()
			end

			if arg_431_1.time_ >= var_434_17 + var_434_27 and arg_431_1.time_ < var_434_17 + var_434_27 + arg_434_0 then
				arg_431_1.typewritter.percent = 1

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(true)
			end
		end

		arg_431_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_431_1:InitPlayNodeList()
	end,
	Play323121107 = function(arg_435_0, arg_435_1)
		arg_435_1.time_ = 0
		arg_435_1.frameCnt_ = 0
		arg_435_1.state_ = "playing"
		arg_435_1.curTalkId_ = 323121107
		arg_435_1.duration_ = 5

		SetActive(arg_435_1.tipsGo_, false)

		function arg_435_1.onSingleLineFinish_()
			arg_435_1.onSingleLineUpdate_ = nil
			arg_435_1.onSingleLineFinish_ = nil
			arg_435_1.state_ = "waiting"
		end

		function arg_435_1.playNext_(arg_437_0)
			if arg_437_0 == 1 then
				arg_435_0:Play323121108(arg_435_1)
			end
		end

		function arg_435_1.onSingleLineUpdate_(arg_438_0)
			local var_438_0 = arg_435_1.actors_["1053ui_story"]
			local var_438_1 = 0

			if var_438_1 < arg_435_1.time_ and arg_435_1.time_ <= var_438_1 + arg_438_0 and not isNil(var_438_0) and arg_435_1.var_.characterEffect1053ui_story == nil then
				arg_435_1.var_.characterEffect1053ui_story = var_438_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_438_2 = 0.200000002980232

			if var_438_1 <= arg_435_1.time_ and arg_435_1.time_ < var_438_1 + var_438_2 and not isNil(var_438_0) then
				local var_438_3 = (arg_435_1.time_ - var_438_1) / var_438_2

				if arg_435_1.var_.characterEffect1053ui_story and not isNil(var_438_0) then
					local var_438_4 = Mathf.Lerp(0, 0.5, var_438_3)

					arg_435_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_435_1.var_.characterEffect1053ui_story.fillRatio = var_438_4
				end
			end

			if arg_435_1.time_ >= var_438_1 + var_438_2 and arg_435_1.time_ < var_438_1 + var_438_2 + arg_438_0 and not isNil(var_438_0) and arg_435_1.var_.characterEffect1053ui_story then
				local var_438_5 = 0.5

				arg_435_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_435_1.var_.characterEffect1053ui_story.fillRatio = var_438_5
			end

			local var_438_6 = 0
			local var_438_7 = 0.8

			if var_438_6 < arg_435_1.time_ and arg_435_1.time_ <= var_438_6 + arg_438_0 then
				arg_435_1.talkMaxDuration = 0
				arg_435_1.dialogCg_.alpha = 1

				arg_435_1.dialog_:SetActive(true)
				SetActive(arg_435_1.leftNameGo_, true)

				local var_438_8 = arg_435_1:FormatText(StoryNameCfg[7].name)

				arg_435_1.leftNameTxt_.text = var_438_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_435_1.leftNameTxt_.transform)

				arg_435_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_435_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_435_1:RecordName(arg_435_1.leftNameTxt_.text)
				SetActive(arg_435_1.iconTrs_.gameObject, true)
				arg_435_1.iconController_:SetSelectedState("hero")

				arg_435_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_435_1.callingController_:SetSelectedState("normal")

				arg_435_1.keyicon_.color = Color.New(1, 1, 1)
				arg_435_1.icon_.color = Color.New(1, 1, 1)

				local var_438_9 = arg_435_1:GetWordFromCfg(323121107)
				local var_438_10 = arg_435_1:FormatText(var_438_9.content)

				arg_435_1.text_.text = var_438_10

				LuaForUtil.ClearLinePrefixSymbol(arg_435_1.text_)

				local var_438_11 = 32
				local var_438_12 = utf8.len(var_438_10)
				local var_438_13 = var_438_11 <= 0 and var_438_7 or var_438_7 * (var_438_12 / var_438_11)

				if var_438_13 > 0 and var_438_7 < var_438_13 then
					arg_435_1.talkMaxDuration = var_438_13

					if var_438_13 + var_438_6 > arg_435_1.duration_ then
						arg_435_1.duration_ = var_438_13 + var_438_6
					end
				end

				arg_435_1.text_.text = var_438_10
				arg_435_1.typewritter.percent = 0

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(false)
				arg_435_1:RecordContent(arg_435_1.text_.text)
			end

			local var_438_14 = math.max(var_438_7, arg_435_1.talkMaxDuration)

			if var_438_6 <= arg_435_1.time_ and arg_435_1.time_ < var_438_6 + var_438_14 then
				arg_435_1.typewritter.percent = (arg_435_1.time_ - var_438_6) / var_438_14

				arg_435_1.typewritter:SetDirty()
			end

			if arg_435_1.time_ >= var_438_6 + var_438_14 and arg_435_1.time_ < var_438_6 + var_438_14 + arg_438_0 then
				arg_435_1.typewritter.percent = 1

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(true)
			end
		end

		arg_435_1.nodeConfigList_ = {}

		arg_435_1:InitPlayNodeList()
	end,
	Play323121108 = function(arg_439_0, arg_439_1)
		arg_439_1.time_ = 0
		arg_439_1.frameCnt_ = 0
		arg_439_1.state_ = "playing"
		arg_439_1.curTalkId_ = 323121108
		arg_439_1.duration_ = 23.5

		local var_439_0 = {
			zh = 13.866,
			ja = 23.5
		}
		local var_439_1 = manager.audio:GetLocalizationFlag()

		if var_439_0[var_439_1] ~= nil then
			arg_439_1.duration_ = var_439_0[var_439_1]
		end

		SetActive(arg_439_1.tipsGo_, false)

		function arg_439_1.onSingleLineFinish_()
			arg_439_1.onSingleLineUpdate_ = nil
			arg_439_1.onSingleLineFinish_ = nil
			arg_439_1.state_ = "waiting"
		end

		function arg_439_1.playNext_(arg_441_0)
			if arg_441_0 == 1 then
				arg_439_0:Play323121109(arg_439_1)
			end
		end

		function arg_439_1.onSingleLineUpdate_(arg_442_0)
			local var_442_0 = arg_439_1.actors_["1053ui_story"].transform
			local var_442_1 = 0

			if var_442_1 < arg_439_1.time_ and arg_439_1.time_ <= var_442_1 + arg_442_0 then
				arg_439_1.var_.moveOldPos1053ui_story = var_442_0.localPosition

				local var_442_2 = GameObjectTools.GetOrAddComponent(var_442_0.gameObject, typeof(DynamicBoneHelper))

				if var_442_2 then
					var_442_2:EnableDynamicBone(false)
				end
			end

			local var_442_3 = 0.001

			if var_442_1 <= arg_439_1.time_ and arg_439_1.time_ < var_442_1 + var_442_3 then
				local var_442_4 = (arg_439_1.time_ - var_442_1) / var_442_3
				local var_442_5 = Vector3.New(0, 100, 0)

				var_442_0.localPosition = Vector3.Lerp(arg_439_1.var_.moveOldPos1053ui_story, var_442_5, var_442_4)

				local var_442_6 = manager.ui.mainCamera.transform.position - var_442_0.position

				var_442_0.forward = Vector3.New(var_442_6.x, var_442_6.y, var_442_6.z)

				local var_442_7 = var_442_0.localEulerAngles

				var_442_7.z = 0
				var_442_7.x = 0
				var_442_0.localEulerAngles = var_442_7
			end

			if arg_439_1.time_ >= var_442_1 + var_442_3 and arg_439_1.time_ < var_442_1 + var_442_3 + arg_442_0 then
				var_442_0.localPosition = Vector3.New(0, 100, 0)

				local var_442_8 = manager.ui.mainCamera.transform.position - var_442_0.position

				var_442_0.forward = Vector3.New(var_442_8.x, var_442_8.y, var_442_8.z)

				local var_442_9 = var_442_0.localEulerAngles

				var_442_9.z = 0
				var_442_9.x = 0
				var_442_0.localEulerAngles = var_442_9

				local var_442_10 = GameObjectTools.GetOrAddComponent(var_442_0.gameObject, typeof(DynamicBoneHelper))

				if var_442_10 then
					var_442_10:EnableDynamicBone(true)
				end
			end

			local var_442_11 = 0
			local var_442_12 = 1.475

			if var_442_11 < arg_439_1.time_ and arg_439_1.time_ <= var_442_11 + arg_442_0 then
				arg_439_1.talkMaxDuration = 0
				arg_439_1.dialogCg_.alpha = 1

				arg_439_1.dialog_:SetActive(true)
				SetActive(arg_439_1.leftNameGo_, true)

				local var_442_13 = arg_439_1:FormatText(StoryNameCfg[1454].name)

				arg_439_1.leftNameTxt_.text = var_442_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_439_1.leftNameTxt_.transform)

				arg_439_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_439_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_439_1:RecordName(arg_439_1.leftNameTxt_.text)
				SetActive(arg_439_1.iconTrs_.gameObject, true)
				arg_439_1.iconController_:SetSelectedState("hero")

				arg_439_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10169")

				arg_439_1.callingController_:SetSelectedState("normal")

				arg_439_1.keyicon_.color = Color.New(1, 1, 1)
				arg_439_1.icon_.color = Color.New(1, 1, 1)

				local var_442_14 = arg_439_1:GetWordFromCfg(323121108)
				local var_442_15 = arg_439_1:FormatText(var_442_14.content)

				arg_439_1.text_.text = var_442_15

				LuaForUtil.ClearLinePrefixSymbol(arg_439_1.text_)

				local var_442_16 = 59
				local var_442_17 = utf8.len(var_442_15)
				local var_442_18 = var_442_16 <= 0 and var_442_12 or var_442_12 * (var_442_17 / var_442_16)

				if var_442_18 > 0 and var_442_12 < var_442_18 then
					arg_439_1.talkMaxDuration = var_442_18

					if var_442_18 + var_442_11 > arg_439_1.duration_ then
						arg_439_1.duration_ = var_442_18 + var_442_11
					end
				end

				arg_439_1.text_.text = var_442_15
				arg_439_1.typewritter.percent = 0

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323121", "323121108", "story_v_out_323121.awb") ~= 0 then
					local var_442_19 = manager.audio:GetVoiceLength("story_v_out_323121", "323121108", "story_v_out_323121.awb") / 1000

					if var_442_19 + var_442_11 > arg_439_1.duration_ then
						arg_439_1.duration_ = var_442_19 + var_442_11
					end

					if var_442_14.prefab_name ~= "" and arg_439_1.actors_[var_442_14.prefab_name] ~= nil then
						local var_442_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_439_1.actors_[var_442_14.prefab_name].transform, "story_v_out_323121", "323121108", "story_v_out_323121.awb")

						arg_439_1:RecordAudio("323121108", var_442_20)
						arg_439_1:RecordAudio("323121108", var_442_20)
					else
						arg_439_1:AudioAction("play", "voice", "story_v_out_323121", "323121108", "story_v_out_323121.awb")
					end

					arg_439_1:RecordHistoryTalkVoice("story_v_out_323121", "323121108", "story_v_out_323121.awb")
				end

				arg_439_1:RecordContent(arg_439_1.text_.text)
			end

			local var_442_21 = math.max(var_442_12, arg_439_1.talkMaxDuration)

			if var_442_11 <= arg_439_1.time_ and arg_439_1.time_ < var_442_11 + var_442_21 then
				arg_439_1.typewritter.percent = (arg_439_1.time_ - var_442_11) / var_442_21

				arg_439_1.typewritter:SetDirty()
			end

			if arg_439_1.time_ >= var_442_11 + var_442_21 and arg_439_1.time_ < var_442_11 + var_442_21 + arg_442_0 then
				arg_439_1.typewritter.percent = 1

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(true)
			end
		end

		arg_439_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_439_1:InitPlayNodeList()
	end,
	Play323121109 = function(arg_443_0, arg_443_1)
		arg_443_1.time_ = 0
		arg_443_1.frameCnt_ = 0
		arg_443_1.state_ = "playing"
		arg_443_1.curTalkId_ = 323121109
		arg_443_1.duration_ = 12.03

		local var_443_0 = {
			zh = 10.3,
			ja = 12.033
		}
		local var_443_1 = manager.audio:GetLocalizationFlag()

		if var_443_0[var_443_1] ~= nil then
			arg_443_1.duration_ = var_443_0[var_443_1]
		end

		SetActive(arg_443_1.tipsGo_, false)

		function arg_443_1.onSingleLineFinish_()
			arg_443_1.onSingleLineUpdate_ = nil
			arg_443_1.onSingleLineFinish_ = nil
			arg_443_1.state_ = "waiting"
		end

		function arg_443_1.playNext_(arg_445_0)
			if arg_445_0 == 1 then
				arg_443_0:Play323121110(arg_443_1)
			end
		end

		function arg_443_1.onSingleLineUpdate_(arg_446_0)
			local var_446_0 = 0
			local var_446_1 = 1.075

			if var_446_0 < arg_443_1.time_ and arg_443_1.time_ <= var_446_0 + arg_446_0 then
				arg_443_1.talkMaxDuration = 0
				arg_443_1.dialogCg_.alpha = 1

				arg_443_1.dialog_:SetActive(true)
				SetActive(arg_443_1.leftNameGo_, true)

				local var_446_2 = arg_443_1:FormatText(StoryNameCfg[1454].name)

				arg_443_1.leftNameTxt_.text = var_446_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_443_1.leftNameTxt_.transform)

				arg_443_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_443_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_443_1:RecordName(arg_443_1.leftNameTxt_.text)
				SetActive(arg_443_1.iconTrs_.gameObject, true)
				arg_443_1.iconController_:SetSelectedState("hero")

				arg_443_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10169")

				arg_443_1.callingController_:SetSelectedState("normal")

				arg_443_1.keyicon_.color = Color.New(1, 1, 1)
				arg_443_1.icon_.color = Color.New(1, 1, 1)

				local var_446_3 = arg_443_1:GetWordFromCfg(323121109)
				local var_446_4 = arg_443_1:FormatText(var_446_3.content)

				arg_443_1.text_.text = var_446_4

				LuaForUtil.ClearLinePrefixSymbol(arg_443_1.text_)

				local var_446_5 = 43
				local var_446_6 = utf8.len(var_446_4)
				local var_446_7 = var_446_5 <= 0 and var_446_1 or var_446_1 * (var_446_6 / var_446_5)

				if var_446_7 > 0 and var_446_1 < var_446_7 then
					arg_443_1.talkMaxDuration = var_446_7

					if var_446_7 + var_446_0 > arg_443_1.duration_ then
						arg_443_1.duration_ = var_446_7 + var_446_0
					end
				end

				arg_443_1.text_.text = var_446_4
				arg_443_1.typewritter.percent = 0

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323121", "323121109", "story_v_out_323121.awb") ~= 0 then
					local var_446_8 = manager.audio:GetVoiceLength("story_v_out_323121", "323121109", "story_v_out_323121.awb") / 1000

					if var_446_8 + var_446_0 > arg_443_1.duration_ then
						arg_443_1.duration_ = var_446_8 + var_446_0
					end

					if var_446_3.prefab_name ~= "" and arg_443_1.actors_[var_446_3.prefab_name] ~= nil then
						local var_446_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_443_1.actors_[var_446_3.prefab_name].transform, "story_v_out_323121", "323121109", "story_v_out_323121.awb")

						arg_443_1:RecordAudio("323121109", var_446_9)
						arg_443_1:RecordAudio("323121109", var_446_9)
					else
						arg_443_1:AudioAction("play", "voice", "story_v_out_323121", "323121109", "story_v_out_323121.awb")
					end

					arg_443_1:RecordHistoryTalkVoice("story_v_out_323121", "323121109", "story_v_out_323121.awb")
				end

				arg_443_1:RecordContent(arg_443_1.text_.text)
			end

			local var_446_10 = math.max(var_446_1, arg_443_1.talkMaxDuration)

			if var_446_0 <= arg_443_1.time_ and arg_443_1.time_ < var_446_0 + var_446_10 then
				arg_443_1.typewritter.percent = (arg_443_1.time_ - var_446_0) / var_446_10

				arg_443_1.typewritter:SetDirty()
			end

			if arg_443_1.time_ >= var_446_0 + var_446_10 and arg_443_1.time_ < var_446_0 + var_446_10 + arg_446_0 then
				arg_443_1.typewritter.percent = 1

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(true)
			end
		end

		arg_443_1.nodeConfigList_ = {}

		arg_443_1:InitPlayNodeList()
	end,
	Play323121110 = function(arg_447_0, arg_447_1)
		arg_447_1.time_ = 0
		arg_447_1.frameCnt_ = 0
		arg_447_1.state_ = "playing"
		arg_447_1.curTalkId_ = 323121110
		arg_447_1.duration_ = 21.77

		local var_447_0 = {
			zh = 12.9,
			ja = 21.766
		}
		local var_447_1 = manager.audio:GetLocalizationFlag()

		if var_447_0[var_447_1] ~= nil then
			arg_447_1.duration_ = var_447_0[var_447_1]
		end

		SetActive(arg_447_1.tipsGo_, false)

		function arg_447_1.onSingleLineFinish_()
			arg_447_1.onSingleLineUpdate_ = nil
			arg_447_1.onSingleLineFinish_ = nil
			arg_447_1.state_ = "waiting"
		end

		function arg_447_1.playNext_(arg_449_0)
			if arg_449_0 == 1 then
				arg_447_0:Play323121111(arg_447_1)
			end
		end

		function arg_447_1.onSingleLineUpdate_(arg_450_0)
			local var_450_0 = 0
			local var_450_1 = 1.425

			if var_450_0 < arg_447_1.time_ and arg_447_1.time_ <= var_450_0 + arg_450_0 then
				arg_447_1.talkMaxDuration = 0
				arg_447_1.dialogCg_.alpha = 1

				arg_447_1.dialog_:SetActive(true)
				SetActive(arg_447_1.leftNameGo_, true)

				local var_450_2 = arg_447_1:FormatText(StoryNameCfg[1454].name)

				arg_447_1.leftNameTxt_.text = var_450_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_447_1.leftNameTxt_.transform)

				arg_447_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_447_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_447_1:RecordName(arg_447_1.leftNameTxt_.text)
				SetActive(arg_447_1.iconTrs_.gameObject, true)
				arg_447_1.iconController_:SetSelectedState("hero")

				arg_447_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10169")

				arg_447_1.callingController_:SetSelectedState("normal")

				arg_447_1.keyicon_.color = Color.New(1, 1, 1)
				arg_447_1.icon_.color = Color.New(1, 1, 1)

				local var_450_3 = arg_447_1:GetWordFromCfg(323121110)
				local var_450_4 = arg_447_1:FormatText(var_450_3.content)

				arg_447_1.text_.text = var_450_4

				LuaForUtil.ClearLinePrefixSymbol(arg_447_1.text_)

				local var_450_5 = 57
				local var_450_6 = utf8.len(var_450_4)
				local var_450_7 = var_450_5 <= 0 and var_450_1 or var_450_1 * (var_450_6 / var_450_5)

				if var_450_7 > 0 and var_450_1 < var_450_7 then
					arg_447_1.talkMaxDuration = var_450_7

					if var_450_7 + var_450_0 > arg_447_1.duration_ then
						arg_447_1.duration_ = var_450_7 + var_450_0
					end
				end

				arg_447_1.text_.text = var_450_4
				arg_447_1.typewritter.percent = 0

				arg_447_1.typewritter:SetDirty()
				arg_447_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323121", "323121110", "story_v_out_323121.awb") ~= 0 then
					local var_450_8 = manager.audio:GetVoiceLength("story_v_out_323121", "323121110", "story_v_out_323121.awb") / 1000

					if var_450_8 + var_450_0 > arg_447_1.duration_ then
						arg_447_1.duration_ = var_450_8 + var_450_0
					end

					if var_450_3.prefab_name ~= "" and arg_447_1.actors_[var_450_3.prefab_name] ~= nil then
						local var_450_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_447_1.actors_[var_450_3.prefab_name].transform, "story_v_out_323121", "323121110", "story_v_out_323121.awb")

						arg_447_1:RecordAudio("323121110", var_450_9)
						arg_447_1:RecordAudio("323121110", var_450_9)
					else
						arg_447_1:AudioAction("play", "voice", "story_v_out_323121", "323121110", "story_v_out_323121.awb")
					end

					arg_447_1:RecordHistoryTalkVoice("story_v_out_323121", "323121110", "story_v_out_323121.awb")
				end

				arg_447_1:RecordContent(arg_447_1.text_.text)
			end

			local var_450_10 = math.max(var_450_1, arg_447_1.talkMaxDuration)

			if var_450_0 <= arg_447_1.time_ and arg_447_1.time_ < var_450_0 + var_450_10 then
				arg_447_1.typewritter.percent = (arg_447_1.time_ - var_450_0) / var_450_10

				arg_447_1.typewritter:SetDirty()
			end

			if arg_447_1.time_ >= var_450_0 + var_450_10 and arg_447_1.time_ < var_450_0 + var_450_10 + arg_450_0 then
				arg_447_1.typewritter.percent = 1

				arg_447_1.typewritter:SetDirty()
				arg_447_1:ShowNextGo(true)
			end
		end

		arg_447_1.nodeConfigList_ = {}

		arg_447_1:InitPlayNodeList()
	end,
	Play323121111 = function(arg_451_0, arg_451_1)
		arg_451_1.time_ = 0
		arg_451_1.frameCnt_ = 0
		arg_451_1.state_ = "playing"
		arg_451_1.curTalkId_ = 323121111
		arg_451_1.duration_ = 19

		local var_451_0 = {
			zh = 15.433,
			ja = 19
		}
		local var_451_1 = manager.audio:GetLocalizationFlag()

		if var_451_0[var_451_1] ~= nil then
			arg_451_1.duration_ = var_451_0[var_451_1]
		end

		SetActive(arg_451_1.tipsGo_, false)

		function arg_451_1.onSingleLineFinish_()
			arg_451_1.onSingleLineUpdate_ = nil
			arg_451_1.onSingleLineFinish_ = nil
			arg_451_1.state_ = "waiting"
		end

		function arg_451_1.playNext_(arg_453_0)
			if arg_453_0 == 1 then
				arg_451_0:Play323121112(arg_451_1)
			end
		end

		function arg_451_1.onSingleLineUpdate_(arg_454_0)
			local var_454_0 = 0
			local var_454_1 = 1.3

			if var_454_0 < arg_451_1.time_ and arg_451_1.time_ <= var_454_0 + arg_454_0 then
				arg_451_1.talkMaxDuration = 0
				arg_451_1.dialogCg_.alpha = 1

				arg_451_1.dialog_:SetActive(true)
				SetActive(arg_451_1.leftNameGo_, true)

				local var_454_2 = arg_451_1:FormatText(StoryNameCfg[1454].name)

				arg_451_1.leftNameTxt_.text = var_454_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_451_1.leftNameTxt_.transform)

				arg_451_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_451_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_451_1:RecordName(arg_451_1.leftNameTxt_.text)
				SetActive(arg_451_1.iconTrs_.gameObject, true)
				arg_451_1.iconController_:SetSelectedState("hero")

				arg_451_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10169")

				arg_451_1.callingController_:SetSelectedState("normal")

				arg_451_1.keyicon_.color = Color.New(1, 1, 1)
				arg_451_1.icon_.color = Color.New(1, 1, 1)

				local var_454_3 = arg_451_1:GetWordFromCfg(323121111)
				local var_454_4 = arg_451_1:FormatText(var_454_3.content)

				arg_451_1.text_.text = var_454_4

				LuaForUtil.ClearLinePrefixSymbol(arg_451_1.text_)

				local var_454_5 = 52
				local var_454_6 = utf8.len(var_454_4)
				local var_454_7 = var_454_5 <= 0 and var_454_1 or var_454_1 * (var_454_6 / var_454_5)

				if var_454_7 > 0 and var_454_1 < var_454_7 then
					arg_451_1.talkMaxDuration = var_454_7

					if var_454_7 + var_454_0 > arg_451_1.duration_ then
						arg_451_1.duration_ = var_454_7 + var_454_0
					end
				end

				arg_451_1.text_.text = var_454_4
				arg_451_1.typewritter.percent = 0

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323121", "323121111", "story_v_out_323121.awb") ~= 0 then
					local var_454_8 = manager.audio:GetVoiceLength("story_v_out_323121", "323121111", "story_v_out_323121.awb") / 1000

					if var_454_8 + var_454_0 > arg_451_1.duration_ then
						arg_451_1.duration_ = var_454_8 + var_454_0
					end

					if var_454_3.prefab_name ~= "" and arg_451_1.actors_[var_454_3.prefab_name] ~= nil then
						local var_454_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_451_1.actors_[var_454_3.prefab_name].transform, "story_v_out_323121", "323121111", "story_v_out_323121.awb")

						arg_451_1:RecordAudio("323121111", var_454_9)
						arg_451_1:RecordAudio("323121111", var_454_9)
					else
						arg_451_1:AudioAction("play", "voice", "story_v_out_323121", "323121111", "story_v_out_323121.awb")
					end

					arg_451_1:RecordHistoryTalkVoice("story_v_out_323121", "323121111", "story_v_out_323121.awb")
				end

				arg_451_1:RecordContent(arg_451_1.text_.text)
			end

			local var_454_10 = math.max(var_454_1, arg_451_1.talkMaxDuration)

			if var_454_0 <= arg_451_1.time_ and arg_451_1.time_ < var_454_0 + var_454_10 then
				arg_451_1.typewritter.percent = (arg_451_1.time_ - var_454_0) / var_454_10

				arg_451_1.typewritter:SetDirty()
			end

			if arg_451_1.time_ >= var_454_0 + var_454_10 and arg_451_1.time_ < var_454_0 + var_454_10 + arg_454_0 then
				arg_451_1.typewritter.percent = 1

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(true)
			end
		end

		arg_451_1.nodeConfigList_ = {}

		arg_451_1:InitPlayNodeList()
	end,
	Play323121112 = function(arg_455_0, arg_455_1)
		arg_455_1.time_ = 0
		arg_455_1.frameCnt_ = 0
		arg_455_1.state_ = "playing"
		arg_455_1.curTalkId_ = 323121112
		arg_455_1.duration_ = 9.67

		local var_455_0 = {
			zh = 4.366,
			ja = 9.666
		}
		local var_455_1 = manager.audio:GetLocalizationFlag()

		if var_455_0[var_455_1] ~= nil then
			arg_455_1.duration_ = var_455_0[var_455_1]
		end

		SetActive(arg_455_1.tipsGo_, false)

		function arg_455_1.onSingleLineFinish_()
			arg_455_1.onSingleLineUpdate_ = nil
			arg_455_1.onSingleLineFinish_ = nil
			arg_455_1.state_ = "waiting"
		end

		function arg_455_1.playNext_(arg_457_0)
			if arg_457_0 == 1 then
				arg_455_0:Play323121113(arg_455_1)
			end
		end

		function arg_455_1.onSingleLineUpdate_(arg_458_0)
			local var_458_0 = 0
			local var_458_1 = 0.5

			if var_458_0 < arg_455_1.time_ and arg_455_1.time_ <= var_458_0 + arg_458_0 then
				arg_455_1.talkMaxDuration = 0
				arg_455_1.dialogCg_.alpha = 1

				arg_455_1.dialog_:SetActive(true)
				SetActive(arg_455_1.leftNameGo_, true)

				local var_458_2 = arg_455_1:FormatText(StoryNameCfg[1454].name)

				arg_455_1.leftNameTxt_.text = var_458_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_455_1.leftNameTxt_.transform)

				arg_455_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_455_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_455_1:RecordName(arg_455_1.leftNameTxt_.text)
				SetActive(arg_455_1.iconTrs_.gameObject, true)
				arg_455_1.iconController_:SetSelectedState("hero")

				arg_455_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10169")

				arg_455_1.callingController_:SetSelectedState("normal")

				arg_455_1.keyicon_.color = Color.New(1, 1, 1)
				arg_455_1.icon_.color = Color.New(1, 1, 1)

				local var_458_3 = arg_455_1:GetWordFromCfg(323121112)
				local var_458_4 = arg_455_1:FormatText(var_458_3.content)

				arg_455_1.text_.text = var_458_4

				LuaForUtil.ClearLinePrefixSymbol(arg_455_1.text_)

				local var_458_5 = 20
				local var_458_6 = utf8.len(var_458_4)
				local var_458_7 = var_458_5 <= 0 and var_458_1 or var_458_1 * (var_458_6 / var_458_5)

				if var_458_7 > 0 and var_458_1 < var_458_7 then
					arg_455_1.talkMaxDuration = var_458_7

					if var_458_7 + var_458_0 > arg_455_1.duration_ then
						arg_455_1.duration_ = var_458_7 + var_458_0
					end
				end

				arg_455_1.text_.text = var_458_4
				arg_455_1.typewritter.percent = 0

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323121", "323121112", "story_v_out_323121.awb") ~= 0 then
					local var_458_8 = manager.audio:GetVoiceLength("story_v_out_323121", "323121112", "story_v_out_323121.awb") / 1000

					if var_458_8 + var_458_0 > arg_455_1.duration_ then
						arg_455_1.duration_ = var_458_8 + var_458_0
					end

					if var_458_3.prefab_name ~= "" and arg_455_1.actors_[var_458_3.prefab_name] ~= nil then
						local var_458_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_455_1.actors_[var_458_3.prefab_name].transform, "story_v_out_323121", "323121112", "story_v_out_323121.awb")

						arg_455_1:RecordAudio("323121112", var_458_9)
						arg_455_1:RecordAudio("323121112", var_458_9)
					else
						arg_455_1:AudioAction("play", "voice", "story_v_out_323121", "323121112", "story_v_out_323121.awb")
					end

					arg_455_1:RecordHistoryTalkVoice("story_v_out_323121", "323121112", "story_v_out_323121.awb")
				end

				arg_455_1:RecordContent(arg_455_1.text_.text)
			end

			local var_458_10 = math.max(var_458_1, arg_455_1.talkMaxDuration)

			if var_458_0 <= arg_455_1.time_ and arg_455_1.time_ < var_458_0 + var_458_10 then
				arg_455_1.typewritter.percent = (arg_455_1.time_ - var_458_0) / var_458_10

				arg_455_1.typewritter:SetDirty()
			end

			if arg_455_1.time_ >= var_458_0 + var_458_10 and arg_455_1.time_ < var_458_0 + var_458_10 + arg_458_0 then
				arg_455_1.typewritter.percent = 1

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(true)
			end
		end

		arg_455_1.nodeConfigList_ = {}

		arg_455_1:InitPlayNodeList()
	end,
	Play323121113 = function(arg_459_0, arg_459_1)
		arg_459_1.time_ = 0
		arg_459_1.frameCnt_ = 0
		arg_459_1.state_ = "playing"
		arg_459_1.curTalkId_ = 323121113
		arg_459_1.duration_ = 3.67

		local var_459_0 = {
			zh = 2.466,
			ja = 3.666
		}
		local var_459_1 = manager.audio:GetLocalizationFlag()

		if var_459_0[var_459_1] ~= nil then
			arg_459_1.duration_ = var_459_0[var_459_1]
		end

		SetActive(arg_459_1.tipsGo_, false)

		function arg_459_1.onSingleLineFinish_()
			arg_459_1.onSingleLineUpdate_ = nil
			arg_459_1.onSingleLineFinish_ = nil
			arg_459_1.state_ = "waiting"
		end

		function arg_459_1.playNext_(arg_461_0)
			if arg_461_0 == 1 then
				arg_459_0:Play323121114(arg_459_1)
			end
		end

		function arg_459_1.onSingleLineUpdate_(arg_462_0)
			local var_462_0 = arg_459_1.actors_["10170ui_story"].transform
			local var_462_1 = 0

			if var_462_1 < arg_459_1.time_ and arg_459_1.time_ <= var_462_1 + arg_462_0 then
				arg_459_1.var_.moveOldPos10170ui_story = var_462_0.localPosition

				local var_462_2 = GameObjectTools.GetOrAddComponent(var_462_0.gameObject, typeof(DynamicBoneHelper))

				if var_462_2 then
					var_462_2:EnableDynamicBone(false)
				end
			end

			local var_462_3 = 0.001

			if var_462_1 <= arg_459_1.time_ and arg_459_1.time_ < var_462_1 + var_462_3 then
				local var_462_4 = (arg_459_1.time_ - var_462_1) / var_462_3
				local var_462_5 = Vector3.New(0, -1.03, -6.05)

				var_462_0.localPosition = Vector3.Lerp(arg_459_1.var_.moveOldPos10170ui_story, var_462_5, var_462_4)

				local var_462_6 = manager.ui.mainCamera.transform.position - var_462_0.position

				var_462_0.forward = Vector3.New(var_462_6.x, var_462_6.y, var_462_6.z)

				local var_462_7 = var_462_0.localEulerAngles

				var_462_7.z = 0
				var_462_7.x = 0
				var_462_0.localEulerAngles = var_462_7
			end

			if arg_459_1.time_ >= var_462_1 + var_462_3 and arg_459_1.time_ < var_462_1 + var_462_3 + arg_462_0 then
				var_462_0.localPosition = Vector3.New(0, -1.03, -6.05)

				local var_462_8 = manager.ui.mainCamera.transform.position - var_462_0.position

				var_462_0.forward = Vector3.New(var_462_8.x, var_462_8.y, var_462_8.z)

				local var_462_9 = var_462_0.localEulerAngles

				var_462_9.z = 0
				var_462_9.x = 0
				var_462_0.localEulerAngles = var_462_9

				local var_462_10 = GameObjectTools.GetOrAddComponent(var_462_0.gameObject, typeof(DynamicBoneHelper))

				if var_462_10 then
					var_462_10:EnableDynamicBone(true)
				end
			end

			local var_462_11 = arg_459_1.actors_["10170ui_story"]
			local var_462_12 = 0

			if var_462_12 < arg_459_1.time_ and arg_459_1.time_ <= var_462_12 + arg_462_0 and not isNil(var_462_11) and arg_459_1.var_.characterEffect10170ui_story == nil then
				arg_459_1.var_.characterEffect10170ui_story = var_462_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_462_13 = 0.200000002980232

			if var_462_12 <= arg_459_1.time_ and arg_459_1.time_ < var_462_12 + var_462_13 and not isNil(var_462_11) then
				local var_462_14 = (arg_459_1.time_ - var_462_12) / var_462_13

				if arg_459_1.var_.characterEffect10170ui_story and not isNil(var_462_11) then
					arg_459_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_459_1.time_ >= var_462_12 + var_462_13 and arg_459_1.time_ < var_462_12 + var_462_13 + arg_462_0 and not isNil(var_462_11) and arg_459_1.var_.characterEffect10170ui_story then
				arg_459_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_462_15 = 0

			if var_462_15 < arg_459_1.time_ and arg_459_1.time_ <= var_462_15 + arg_462_0 then
				arg_459_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/story10170/story10170action/10170action2_1")
			end

			local var_462_16 = 0

			if var_462_16 < arg_459_1.time_ and arg_459_1.time_ <= var_462_16 + arg_462_0 then
				arg_459_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_462_17 = 0
			local var_462_18 = 0.225

			if var_462_17 < arg_459_1.time_ and arg_459_1.time_ <= var_462_17 + arg_462_0 then
				arg_459_1.talkMaxDuration = 0
				arg_459_1.dialogCg_.alpha = 1

				arg_459_1.dialog_:SetActive(true)
				SetActive(arg_459_1.leftNameGo_, true)

				local var_462_19 = arg_459_1:FormatText(StoryNameCfg[1450].name)

				arg_459_1.leftNameTxt_.text = var_462_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_459_1.leftNameTxt_.transform)

				arg_459_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_459_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_459_1:RecordName(arg_459_1.leftNameTxt_.text)
				SetActive(arg_459_1.iconTrs_.gameObject, false)
				arg_459_1.callingController_:SetSelectedState("normal")

				local var_462_20 = arg_459_1:GetWordFromCfg(323121113)
				local var_462_21 = arg_459_1:FormatText(var_462_20.content)

				arg_459_1.text_.text = var_462_21

				LuaForUtil.ClearLinePrefixSymbol(arg_459_1.text_)

				local var_462_22 = 9
				local var_462_23 = utf8.len(var_462_21)
				local var_462_24 = var_462_22 <= 0 and var_462_18 or var_462_18 * (var_462_23 / var_462_22)

				if var_462_24 > 0 and var_462_18 < var_462_24 then
					arg_459_1.talkMaxDuration = var_462_24

					if var_462_24 + var_462_17 > arg_459_1.duration_ then
						arg_459_1.duration_ = var_462_24 + var_462_17
					end
				end

				arg_459_1.text_.text = var_462_21
				arg_459_1.typewritter.percent = 0

				arg_459_1.typewritter:SetDirty()
				arg_459_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323121", "323121113", "story_v_out_323121.awb") ~= 0 then
					local var_462_25 = manager.audio:GetVoiceLength("story_v_out_323121", "323121113", "story_v_out_323121.awb") / 1000

					if var_462_25 + var_462_17 > arg_459_1.duration_ then
						arg_459_1.duration_ = var_462_25 + var_462_17
					end

					if var_462_20.prefab_name ~= "" and arg_459_1.actors_[var_462_20.prefab_name] ~= nil then
						local var_462_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_459_1.actors_[var_462_20.prefab_name].transform, "story_v_out_323121", "323121113", "story_v_out_323121.awb")

						arg_459_1:RecordAudio("323121113", var_462_26)
						arg_459_1:RecordAudio("323121113", var_462_26)
					else
						arg_459_1:AudioAction("play", "voice", "story_v_out_323121", "323121113", "story_v_out_323121.awb")
					end

					arg_459_1:RecordHistoryTalkVoice("story_v_out_323121", "323121113", "story_v_out_323121.awb")
				end

				arg_459_1:RecordContent(arg_459_1.text_.text)
			end

			local var_462_27 = math.max(var_462_18, arg_459_1.talkMaxDuration)

			if var_462_17 <= arg_459_1.time_ and arg_459_1.time_ < var_462_17 + var_462_27 then
				arg_459_1.typewritter.percent = (arg_459_1.time_ - var_462_17) / var_462_27

				arg_459_1.typewritter:SetDirty()
			end

			if arg_459_1.time_ >= var_462_17 + var_462_27 and arg_459_1.time_ < var_462_17 + var_462_27 + arg_462_0 then
				arg_459_1.typewritter.percent = 1

				arg_459_1.typewritter:SetDirty()
				arg_459_1:ShowNextGo(true)
			end
		end

		arg_459_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_459_1:InitPlayNodeList()
	end,
	Play323121114 = function(arg_463_0, arg_463_1)
		arg_463_1.time_ = 0
		arg_463_1.frameCnt_ = 0
		arg_463_1.state_ = "playing"
		arg_463_1.curTalkId_ = 323121114
		arg_463_1.duration_ = 8.9

		local var_463_0 = {
			zh = 7.166,
			ja = 8.9
		}
		local var_463_1 = manager.audio:GetLocalizationFlag()

		if var_463_0[var_463_1] ~= nil then
			arg_463_1.duration_ = var_463_0[var_463_1]
		end

		SetActive(arg_463_1.tipsGo_, false)

		function arg_463_1.onSingleLineFinish_()
			arg_463_1.onSingleLineUpdate_ = nil
			arg_463_1.onSingleLineFinish_ = nil
			arg_463_1.state_ = "waiting"
		end

		function arg_463_1.playNext_(arg_465_0)
			if arg_465_0 == 1 then
				arg_463_0:Play323121115(arg_463_1)
			end
		end

		function arg_463_1.onSingleLineUpdate_(arg_466_0)
			local var_466_0 = arg_463_1.actors_["10170ui_story"]
			local var_466_1 = 0

			if var_466_1 < arg_463_1.time_ and arg_463_1.time_ <= var_466_1 + arg_466_0 and not isNil(var_466_0) and arg_463_1.var_.characterEffect10170ui_story == nil then
				arg_463_1.var_.characterEffect10170ui_story = var_466_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_466_2 = 0.200000002980232

			if var_466_1 <= arg_463_1.time_ and arg_463_1.time_ < var_466_1 + var_466_2 and not isNil(var_466_0) then
				local var_466_3 = (arg_463_1.time_ - var_466_1) / var_466_2

				if arg_463_1.var_.characterEffect10170ui_story and not isNil(var_466_0) then
					local var_466_4 = Mathf.Lerp(0, 0.5, var_466_3)

					arg_463_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_463_1.var_.characterEffect10170ui_story.fillRatio = var_466_4
				end
			end

			if arg_463_1.time_ >= var_466_1 + var_466_2 and arg_463_1.time_ < var_466_1 + var_466_2 + arg_466_0 and not isNil(var_466_0) and arg_463_1.var_.characterEffect10170ui_story then
				local var_466_5 = 0.5

				arg_463_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_463_1.var_.characterEffect10170ui_story.fillRatio = var_466_5
			end

			local var_466_6 = 0
			local var_466_7 = 0.575

			if var_466_6 < arg_463_1.time_ and arg_463_1.time_ <= var_466_6 + arg_466_0 then
				arg_463_1.talkMaxDuration = 0
				arg_463_1.dialogCg_.alpha = 1

				arg_463_1.dialog_:SetActive(true)
				SetActive(arg_463_1.leftNameGo_, true)

				local var_466_8 = arg_463_1:FormatText(StoryNameCfg[1454].name)

				arg_463_1.leftNameTxt_.text = var_466_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_463_1.leftNameTxt_.transform)

				arg_463_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_463_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_463_1:RecordName(arg_463_1.leftNameTxt_.text)
				SetActive(arg_463_1.iconTrs_.gameObject, true)
				arg_463_1.iconController_:SetSelectedState("hero")

				arg_463_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10169")

				arg_463_1.callingController_:SetSelectedState("normal")

				arg_463_1.keyicon_.color = Color.New(1, 1, 1)
				arg_463_1.icon_.color = Color.New(1, 1, 1)

				local var_466_9 = arg_463_1:GetWordFromCfg(323121114)
				local var_466_10 = arg_463_1:FormatText(var_466_9.content)

				arg_463_1.text_.text = var_466_10

				LuaForUtil.ClearLinePrefixSymbol(arg_463_1.text_)

				local var_466_11 = 23
				local var_466_12 = utf8.len(var_466_10)
				local var_466_13 = var_466_11 <= 0 and var_466_7 or var_466_7 * (var_466_12 / var_466_11)

				if var_466_13 > 0 and var_466_7 < var_466_13 then
					arg_463_1.talkMaxDuration = var_466_13

					if var_466_13 + var_466_6 > arg_463_1.duration_ then
						arg_463_1.duration_ = var_466_13 + var_466_6
					end
				end

				arg_463_1.text_.text = var_466_10
				arg_463_1.typewritter.percent = 0

				arg_463_1.typewritter:SetDirty()
				arg_463_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323121", "323121114", "story_v_out_323121.awb") ~= 0 then
					local var_466_14 = manager.audio:GetVoiceLength("story_v_out_323121", "323121114", "story_v_out_323121.awb") / 1000

					if var_466_14 + var_466_6 > arg_463_1.duration_ then
						arg_463_1.duration_ = var_466_14 + var_466_6
					end

					if var_466_9.prefab_name ~= "" and arg_463_1.actors_[var_466_9.prefab_name] ~= nil then
						local var_466_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_463_1.actors_[var_466_9.prefab_name].transform, "story_v_out_323121", "323121114", "story_v_out_323121.awb")

						arg_463_1:RecordAudio("323121114", var_466_15)
						arg_463_1:RecordAudio("323121114", var_466_15)
					else
						arg_463_1:AudioAction("play", "voice", "story_v_out_323121", "323121114", "story_v_out_323121.awb")
					end

					arg_463_1:RecordHistoryTalkVoice("story_v_out_323121", "323121114", "story_v_out_323121.awb")
				end

				arg_463_1:RecordContent(arg_463_1.text_.text)
			end

			local var_466_16 = math.max(var_466_7, arg_463_1.talkMaxDuration)

			if var_466_6 <= arg_463_1.time_ and arg_463_1.time_ < var_466_6 + var_466_16 then
				arg_463_1.typewritter.percent = (arg_463_1.time_ - var_466_6) / var_466_16

				arg_463_1.typewritter:SetDirty()
			end

			if arg_463_1.time_ >= var_466_6 + var_466_16 and arg_463_1.time_ < var_466_6 + var_466_16 + arg_466_0 then
				arg_463_1.typewritter.percent = 1

				arg_463_1.typewritter:SetDirty()
				arg_463_1:ShowNextGo(true)
			end
		end

		arg_463_1.nodeConfigList_ = {}

		arg_463_1:InitPlayNodeList()
	end,
	Play323121115 = function(arg_467_0, arg_467_1)
		arg_467_1.time_ = 0
		arg_467_1.frameCnt_ = 0
		arg_467_1.state_ = "playing"
		arg_467_1.curTalkId_ = 323121115
		arg_467_1.duration_ = 12.63

		local var_467_0 = {
			zh = 5.166,
			ja = 12.633
		}
		local var_467_1 = manager.audio:GetLocalizationFlag()

		if var_467_0[var_467_1] ~= nil then
			arg_467_1.duration_ = var_467_0[var_467_1]
		end

		SetActive(arg_467_1.tipsGo_, false)

		function arg_467_1.onSingleLineFinish_()
			arg_467_1.onSingleLineUpdate_ = nil
			arg_467_1.onSingleLineFinish_ = nil
			arg_467_1.state_ = "waiting"
		end

		function arg_467_1.playNext_(arg_469_0)
			if arg_469_0 == 1 then
				arg_467_0:Play323121116(arg_467_1)
			end
		end

		function arg_467_1.onSingleLineUpdate_(arg_470_0)
			local var_470_0 = 0
			local var_470_1 = 0.825

			if var_470_0 < arg_467_1.time_ and arg_467_1.time_ <= var_470_0 + arg_470_0 then
				arg_467_1.talkMaxDuration = 0
				arg_467_1.dialogCg_.alpha = 1

				arg_467_1.dialog_:SetActive(true)
				SetActive(arg_467_1.leftNameGo_, true)

				local var_470_2 = arg_467_1:FormatText(StoryNameCfg[1454].name)

				arg_467_1.leftNameTxt_.text = var_470_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_467_1.leftNameTxt_.transform)

				arg_467_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_467_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_467_1:RecordName(arg_467_1.leftNameTxt_.text)
				SetActive(arg_467_1.iconTrs_.gameObject, true)
				arg_467_1.iconController_:SetSelectedState("hero")

				arg_467_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10169")

				arg_467_1.callingController_:SetSelectedState("normal")

				arg_467_1.keyicon_.color = Color.New(1, 1, 1)
				arg_467_1.icon_.color = Color.New(1, 1, 1)

				local var_470_3 = arg_467_1:GetWordFromCfg(323121115)
				local var_470_4 = arg_467_1:FormatText(var_470_3.content)

				arg_467_1.text_.text = var_470_4

				LuaForUtil.ClearLinePrefixSymbol(arg_467_1.text_)

				local var_470_5 = 33
				local var_470_6 = utf8.len(var_470_4)
				local var_470_7 = var_470_5 <= 0 and var_470_1 or var_470_1 * (var_470_6 / var_470_5)

				if var_470_7 > 0 and var_470_1 < var_470_7 then
					arg_467_1.talkMaxDuration = var_470_7

					if var_470_7 + var_470_0 > arg_467_1.duration_ then
						arg_467_1.duration_ = var_470_7 + var_470_0
					end
				end

				arg_467_1.text_.text = var_470_4
				arg_467_1.typewritter.percent = 0

				arg_467_1.typewritter:SetDirty()
				arg_467_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323121", "323121115", "story_v_out_323121.awb") ~= 0 then
					local var_470_8 = manager.audio:GetVoiceLength("story_v_out_323121", "323121115", "story_v_out_323121.awb") / 1000

					if var_470_8 + var_470_0 > arg_467_1.duration_ then
						arg_467_1.duration_ = var_470_8 + var_470_0
					end

					if var_470_3.prefab_name ~= "" and arg_467_1.actors_[var_470_3.prefab_name] ~= nil then
						local var_470_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_467_1.actors_[var_470_3.prefab_name].transform, "story_v_out_323121", "323121115", "story_v_out_323121.awb")

						arg_467_1:RecordAudio("323121115", var_470_9)
						arg_467_1:RecordAudio("323121115", var_470_9)
					else
						arg_467_1:AudioAction("play", "voice", "story_v_out_323121", "323121115", "story_v_out_323121.awb")
					end

					arg_467_1:RecordHistoryTalkVoice("story_v_out_323121", "323121115", "story_v_out_323121.awb")
				end

				arg_467_1:RecordContent(arg_467_1.text_.text)
			end

			local var_470_10 = math.max(var_470_1, arg_467_1.talkMaxDuration)

			if var_470_0 <= arg_467_1.time_ and arg_467_1.time_ < var_470_0 + var_470_10 then
				arg_467_1.typewritter.percent = (arg_467_1.time_ - var_470_0) / var_470_10

				arg_467_1.typewritter:SetDirty()
			end

			if arg_467_1.time_ >= var_470_0 + var_470_10 and arg_467_1.time_ < var_470_0 + var_470_10 + arg_470_0 then
				arg_467_1.typewritter.percent = 1

				arg_467_1.typewritter:SetDirty()
				arg_467_1:ShowNextGo(true)
			end
		end

		arg_467_1.nodeConfigList_ = {}

		arg_467_1:InitPlayNodeList()
	end,
	Play323121116 = function(arg_471_0, arg_471_1)
		arg_471_1.time_ = 0
		arg_471_1.frameCnt_ = 0
		arg_471_1.state_ = "playing"
		arg_471_1.curTalkId_ = 323121116
		arg_471_1.duration_ = 20.87

		local var_471_0 = {
			zh = 13.333,
			ja = 20.866
		}
		local var_471_1 = manager.audio:GetLocalizationFlag()

		if var_471_0[var_471_1] ~= nil then
			arg_471_1.duration_ = var_471_0[var_471_1]
		end

		SetActive(arg_471_1.tipsGo_, false)

		function arg_471_1.onSingleLineFinish_()
			arg_471_1.onSingleLineUpdate_ = nil
			arg_471_1.onSingleLineFinish_ = nil
			arg_471_1.state_ = "waiting"
		end

		function arg_471_1.playNext_(arg_473_0)
			if arg_473_0 == 1 then
				arg_471_0:Play323121117(arg_471_1)
			end
		end

		function arg_471_1.onSingleLineUpdate_(arg_474_0)
			local var_474_0 = 0
			local var_474_1 = 1.35

			if var_474_0 < arg_471_1.time_ and arg_471_1.time_ <= var_474_0 + arg_474_0 then
				arg_471_1.talkMaxDuration = 0
				arg_471_1.dialogCg_.alpha = 1

				arg_471_1.dialog_:SetActive(true)
				SetActive(arg_471_1.leftNameGo_, true)

				local var_474_2 = arg_471_1:FormatText(StoryNameCfg[1454].name)

				arg_471_1.leftNameTxt_.text = var_474_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_471_1.leftNameTxt_.transform)

				arg_471_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_471_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_471_1:RecordName(arg_471_1.leftNameTxt_.text)
				SetActive(arg_471_1.iconTrs_.gameObject, true)
				arg_471_1.iconController_:SetSelectedState("hero")

				arg_471_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10169")

				arg_471_1.callingController_:SetSelectedState("normal")

				arg_471_1.keyicon_.color = Color.New(1, 1, 1)
				arg_471_1.icon_.color = Color.New(1, 1, 1)

				local var_474_3 = arg_471_1:GetWordFromCfg(323121116)
				local var_474_4 = arg_471_1:FormatText(var_474_3.content)

				arg_471_1.text_.text = var_474_4

				LuaForUtil.ClearLinePrefixSymbol(arg_471_1.text_)

				local var_474_5 = 54
				local var_474_6 = utf8.len(var_474_4)
				local var_474_7 = var_474_5 <= 0 and var_474_1 or var_474_1 * (var_474_6 / var_474_5)

				if var_474_7 > 0 and var_474_1 < var_474_7 then
					arg_471_1.talkMaxDuration = var_474_7

					if var_474_7 + var_474_0 > arg_471_1.duration_ then
						arg_471_1.duration_ = var_474_7 + var_474_0
					end
				end

				arg_471_1.text_.text = var_474_4
				arg_471_1.typewritter.percent = 0

				arg_471_1.typewritter:SetDirty()
				arg_471_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323121", "323121116", "story_v_out_323121.awb") ~= 0 then
					local var_474_8 = manager.audio:GetVoiceLength("story_v_out_323121", "323121116", "story_v_out_323121.awb") / 1000

					if var_474_8 + var_474_0 > arg_471_1.duration_ then
						arg_471_1.duration_ = var_474_8 + var_474_0
					end

					if var_474_3.prefab_name ~= "" and arg_471_1.actors_[var_474_3.prefab_name] ~= nil then
						local var_474_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_471_1.actors_[var_474_3.prefab_name].transform, "story_v_out_323121", "323121116", "story_v_out_323121.awb")

						arg_471_1:RecordAudio("323121116", var_474_9)
						arg_471_1:RecordAudio("323121116", var_474_9)
					else
						arg_471_1:AudioAction("play", "voice", "story_v_out_323121", "323121116", "story_v_out_323121.awb")
					end

					arg_471_1:RecordHistoryTalkVoice("story_v_out_323121", "323121116", "story_v_out_323121.awb")
				end

				arg_471_1:RecordContent(arg_471_1.text_.text)
			end

			local var_474_10 = math.max(var_474_1, arg_471_1.talkMaxDuration)

			if var_474_0 <= arg_471_1.time_ and arg_471_1.time_ < var_474_0 + var_474_10 then
				arg_471_1.typewritter.percent = (arg_471_1.time_ - var_474_0) / var_474_10

				arg_471_1.typewritter:SetDirty()
			end

			if arg_471_1.time_ >= var_474_0 + var_474_10 and arg_471_1.time_ < var_474_0 + var_474_10 + arg_474_0 then
				arg_471_1.typewritter.percent = 1

				arg_471_1.typewritter:SetDirty()
				arg_471_1:ShowNextGo(true)
			end
		end

		arg_471_1.nodeConfigList_ = {}

		arg_471_1:InitPlayNodeList()
	end,
	Play323121117 = function(arg_475_0, arg_475_1)
		arg_475_1.time_ = 0
		arg_475_1.frameCnt_ = 0
		arg_475_1.state_ = "playing"
		arg_475_1.curTalkId_ = 323121117
		arg_475_1.duration_ = 5

		SetActive(arg_475_1.tipsGo_, false)

		function arg_475_1.onSingleLineFinish_()
			arg_475_1.onSingleLineUpdate_ = nil
			arg_475_1.onSingleLineFinish_ = nil
			arg_475_1.state_ = "waiting"
		end

		function arg_475_1.playNext_(arg_477_0)
			if arg_477_0 == 1 then
				arg_475_0:Play323121118(arg_475_1)
			end
		end

		function arg_475_1.onSingleLineUpdate_(arg_478_0)
			local var_478_0 = arg_475_1.actors_["10170ui_story"].transform
			local var_478_1 = 0

			if var_478_1 < arg_475_1.time_ and arg_475_1.time_ <= var_478_1 + arg_478_0 then
				arg_475_1.var_.moveOldPos10170ui_story = var_478_0.localPosition

				local var_478_2 = GameObjectTools.GetOrAddComponent(var_478_0.gameObject, typeof(DynamicBoneHelper))

				if var_478_2 then
					var_478_2:EnableDynamicBone(false)
				end
			end

			local var_478_3 = 0.001

			if var_478_1 <= arg_475_1.time_ and arg_475_1.time_ < var_478_1 + var_478_3 then
				local var_478_4 = (arg_475_1.time_ - var_478_1) / var_478_3
				local var_478_5 = Vector3.New(0, 100, 0)

				var_478_0.localPosition = Vector3.Lerp(arg_475_1.var_.moveOldPos10170ui_story, var_478_5, var_478_4)

				local var_478_6 = manager.ui.mainCamera.transform.position - var_478_0.position

				var_478_0.forward = Vector3.New(var_478_6.x, var_478_6.y, var_478_6.z)

				local var_478_7 = var_478_0.localEulerAngles

				var_478_7.z = 0
				var_478_7.x = 0
				var_478_0.localEulerAngles = var_478_7
			end

			if arg_475_1.time_ >= var_478_1 + var_478_3 and arg_475_1.time_ < var_478_1 + var_478_3 + arg_478_0 then
				var_478_0.localPosition = Vector3.New(0, 100, 0)

				local var_478_8 = manager.ui.mainCamera.transform.position - var_478_0.position

				var_478_0.forward = Vector3.New(var_478_8.x, var_478_8.y, var_478_8.z)

				local var_478_9 = var_478_0.localEulerAngles

				var_478_9.z = 0
				var_478_9.x = 0
				var_478_0.localEulerAngles = var_478_9

				local var_478_10 = GameObjectTools.GetOrAddComponent(var_478_0.gameObject, typeof(DynamicBoneHelper))

				if var_478_10 then
					var_478_10:EnableDynamicBone(true)
				end
			end

			local var_478_11 = 0
			local var_478_12 = 0.65

			if var_478_11 < arg_475_1.time_ and arg_475_1.time_ <= var_478_11 + arg_478_0 then
				arg_475_1.talkMaxDuration = 0
				arg_475_1.dialogCg_.alpha = 1

				arg_475_1.dialog_:SetActive(true)
				SetActive(arg_475_1.leftNameGo_, true)

				local var_478_13 = arg_475_1:FormatText(StoryNameCfg[7].name)

				arg_475_1.leftNameTxt_.text = var_478_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_475_1.leftNameTxt_.transform)

				arg_475_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_475_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_475_1:RecordName(arg_475_1.leftNameTxt_.text)
				SetActive(arg_475_1.iconTrs_.gameObject, true)
				arg_475_1.iconController_:SetSelectedState("hero")

				arg_475_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_475_1.callingController_:SetSelectedState("normal")

				arg_475_1.keyicon_.color = Color.New(1, 1, 1)
				arg_475_1.icon_.color = Color.New(1, 1, 1)

				local var_478_14 = arg_475_1:GetWordFromCfg(323121117)
				local var_478_15 = arg_475_1:FormatText(var_478_14.content)

				arg_475_1.text_.text = var_478_15

				LuaForUtil.ClearLinePrefixSymbol(arg_475_1.text_)

				local var_478_16 = 26
				local var_478_17 = utf8.len(var_478_15)
				local var_478_18 = var_478_16 <= 0 and var_478_12 or var_478_12 * (var_478_17 / var_478_16)

				if var_478_18 > 0 and var_478_12 < var_478_18 then
					arg_475_1.talkMaxDuration = var_478_18

					if var_478_18 + var_478_11 > arg_475_1.duration_ then
						arg_475_1.duration_ = var_478_18 + var_478_11
					end
				end

				arg_475_1.text_.text = var_478_15
				arg_475_1.typewritter.percent = 0

				arg_475_1.typewritter:SetDirty()
				arg_475_1:ShowNextGo(false)
				arg_475_1:RecordContent(arg_475_1.text_.text)
			end

			local var_478_19 = math.max(var_478_12, arg_475_1.talkMaxDuration)

			if var_478_11 <= arg_475_1.time_ and arg_475_1.time_ < var_478_11 + var_478_19 then
				arg_475_1.typewritter.percent = (arg_475_1.time_ - var_478_11) / var_478_19

				arg_475_1.typewritter:SetDirty()
			end

			if arg_475_1.time_ >= var_478_11 + var_478_19 and arg_475_1.time_ < var_478_11 + var_478_19 + arg_478_0 then
				arg_475_1.typewritter.percent = 1

				arg_475_1.typewritter:SetDirty()
				arg_475_1:ShowNextGo(true)
			end
		end

		arg_475_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_475_1:InitPlayNodeList()
	end,
	Play323121118 = function(arg_479_0, arg_479_1)
		arg_479_1.time_ = 0
		arg_479_1.frameCnt_ = 0
		arg_479_1.state_ = "playing"
		arg_479_1.curTalkId_ = 323121118
		arg_479_1.duration_ = 15.3

		local var_479_0 = {
			zh = 8.4,
			ja = 15.3
		}
		local var_479_1 = manager.audio:GetLocalizationFlag()

		if var_479_0[var_479_1] ~= nil then
			arg_479_1.duration_ = var_479_0[var_479_1]
		end

		SetActive(arg_479_1.tipsGo_, false)

		function arg_479_1.onSingleLineFinish_()
			arg_479_1.onSingleLineUpdate_ = nil
			arg_479_1.onSingleLineFinish_ = nil
			arg_479_1.state_ = "waiting"
		end

		function arg_479_1.playNext_(arg_481_0)
			if arg_481_0 == 1 then
				arg_479_0:Play323121119(arg_479_1)
			end
		end

		function arg_479_1.onSingleLineUpdate_(arg_482_0)
			local var_482_0 = 0
			local var_482_1 = 0.75

			if var_482_0 < arg_479_1.time_ and arg_479_1.time_ <= var_482_0 + arg_482_0 then
				arg_479_1.talkMaxDuration = 0
				arg_479_1.dialogCg_.alpha = 1

				arg_479_1.dialog_:SetActive(true)
				SetActive(arg_479_1.leftNameGo_, true)

				local var_482_2 = arg_479_1:FormatText(StoryNameCfg[1454].name)

				arg_479_1.leftNameTxt_.text = var_482_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_479_1.leftNameTxt_.transform)

				arg_479_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_479_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_479_1:RecordName(arg_479_1.leftNameTxt_.text)
				SetActive(arg_479_1.iconTrs_.gameObject, true)
				arg_479_1.iconController_:SetSelectedState("hero")

				arg_479_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10169")

				arg_479_1.callingController_:SetSelectedState("normal")

				arg_479_1.keyicon_.color = Color.New(1, 1, 1)
				arg_479_1.icon_.color = Color.New(1, 1, 1)

				local var_482_3 = arg_479_1:GetWordFromCfg(323121118)
				local var_482_4 = arg_479_1:FormatText(var_482_3.content)

				arg_479_1.text_.text = var_482_4

				LuaForUtil.ClearLinePrefixSymbol(arg_479_1.text_)

				local var_482_5 = 30
				local var_482_6 = utf8.len(var_482_4)
				local var_482_7 = var_482_5 <= 0 and var_482_1 or var_482_1 * (var_482_6 / var_482_5)

				if var_482_7 > 0 and var_482_1 < var_482_7 then
					arg_479_1.talkMaxDuration = var_482_7

					if var_482_7 + var_482_0 > arg_479_1.duration_ then
						arg_479_1.duration_ = var_482_7 + var_482_0
					end
				end

				arg_479_1.text_.text = var_482_4
				arg_479_1.typewritter.percent = 0

				arg_479_1.typewritter:SetDirty()
				arg_479_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323121", "323121118", "story_v_out_323121.awb") ~= 0 then
					local var_482_8 = manager.audio:GetVoiceLength("story_v_out_323121", "323121118", "story_v_out_323121.awb") / 1000

					if var_482_8 + var_482_0 > arg_479_1.duration_ then
						arg_479_1.duration_ = var_482_8 + var_482_0
					end

					if var_482_3.prefab_name ~= "" and arg_479_1.actors_[var_482_3.prefab_name] ~= nil then
						local var_482_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_479_1.actors_[var_482_3.prefab_name].transform, "story_v_out_323121", "323121118", "story_v_out_323121.awb")

						arg_479_1:RecordAudio("323121118", var_482_9)
						arg_479_1:RecordAudio("323121118", var_482_9)
					else
						arg_479_1:AudioAction("play", "voice", "story_v_out_323121", "323121118", "story_v_out_323121.awb")
					end

					arg_479_1:RecordHistoryTalkVoice("story_v_out_323121", "323121118", "story_v_out_323121.awb")
				end

				arg_479_1:RecordContent(arg_479_1.text_.text)
			end

			local var_482_10 = math.max(var_482_1, arg_479_1.talkMaxDuration)

			if var_482_0 <= arg_479_1.time_ and arg_479_1.time_ < var_482_0 + var_482_10 then
				arg_479_1.typewritter.percent = (arg_479_1.time_ - var_482_0) / var_482_10

				arg_479_1.typewritter:SetDirty()
			end

			if arg_479_1.time_ >= var_482_0 + var_482_10 and arg_479_1.time_ < var_482_0 + var_482_10 + arg_482_0 then
				arg_479_1.typewritter.percent = 1

				arg_479_1.typewritter:SetDirty()
				arg_479_1:ShowNextGo(true)
			end
		end

		arg_479_1.nodeConfigList_ = {}

		arg_479_1:InitPlayNodeList()
	end,
	Play323121119 = function(arg_483_0, arg_483_1)
		arg_483_1.time_ = 0
		arg_483_1.frameCnt_ = 0
		arg_483_1.state_ = "playing"
		arg_483_1.curTalkId_ = 323121119
		arg_483_1.duration_ = 14.67

		local var_483_0 = {
			zh = 7.1,
			ja = 14.666
		}
		local var_483_1 = manager.audio:GetLocalizationFlag()

		if var_483_0[var_483_1] ~= nil then
			arg_483_1.duration_ = var_483_0[var_483_1]
		end

		SetActive(arg_483_1.tipsGo_, false)

		function arg_483_1.onSingleLineFinish_()
			arg_483_1.onSingleLineUpdate_ = nil
			arg_483_1.onSingleLineFinish_ = nil
			arg_483_1.state_ = "waiting"
		end

		function arg_483_1.playNext_(arg_485_0)
			if arg_485_0 == 1 then
				arg_483_0:Play323121120(arg_483_1)
			end
		end

		function arg_483_1.onSingleLineUpdate_(arg_486_0)
			local var_486_0 = 0
			local var_486_1 = 0.825

			if var_486_0 < arg_483_1.time_ and arg_483_1.time_ <= var_486_0 + arg_486_0 then
				arg_483_1.talkMaxDuration = 0
				arg_483_1.dialogCg_.alpha = 1

				arg_483_1.dialog_:SetActive(true)
				SetActive(arg_483_1.leftNameGo_, true)

				local var_486_2 = arg_483_1:FormatText(StoryNameCfg[1454].name)

				arg_483_1.leftNameTxt_.text = var_486_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_483_1.leftNameTxt_.transform)

				arg_483_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_483_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_483_1:RecordName(arg_483_1.leftNameTxt_.text)
				SetActive(arg_483_1.iconTrs_.gameObject, true)
				arg_483_1.iconController_:SetSelectedState("hero")

				arg_483_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10169")

				arg_483_1.callingController_:SetSelectedState("normal")

				arg_483_1.keyicon_.color = Color.New(1, 1, 1)
				arg_483_1.icon_.color = Color.New(1, 1, 1)

				local var_486_3 = arg_483_1:GetWordFromCfg(323121119)
				local var_486_4 = arg_483_1:FormatText(var_486_3.content)

				arg_483_1.text_.text = var_486_4

				LuaForUtil.ClearLinePrefixSymbol(arg_483_1.text_)

				local var_486_5 = 33
				local var_486_6 = utf8.len(var_486_4)
				local var_486_7 = var_486_5 <= 0 and var_486_1 or var_486_1 * (var_486_6 / var_486_5)

				if var_486_7 > 0 and var_486_1 < var_486_7 then
					arg_483_1.talkMaxDuration = var_486_7

					if var_486_7 + var_486_0 > arg_483_1.duration_ then
						arg_483_1.duration_ = var_486_7 + var_486_0
					end
				end

				arg_483_1.text_.text = var_486_4
				arg_483_1.typewritter.percent = 0

				arg_483_1.typewritter:SetDirty()
				arg_483_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323121", "323121119", "story_v_out_323121.awb") ~= 0 then
					local var_486_8 = manager.audio:GetVoiceLength("story_v_out_323121", "323121119", "story_v_out_323121.awb") / 1000

					if var_486_8 + var_486_0 > arg_483_1.duration_ then
						arg_483_1.duration_ = var_486_8 + var_486_0
					end

					if var_486_3.prefab_name ~= "" and arg_483_1.actors_[var_486_3.prefab_name] ~= nil then
						local var_486_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_483_1.actors_[var_486_3.prefab_name].transform, "story_v_out_323121", "323121119", "story_v_out_323121.awb")

						arg_483_1:RecordAudio("323121119", var_486_9)
						arg_483_1:RecordAudio("323121119", var_486_9)
					else
						arg_483_1:AudioAction("play", "voice", "story_v_out_323121", "323121119", "story_v_out_323121.awb")
					end

					arg_483_1:RecordHistoryTalkVoice("story_v_out_323121", "323121119", "story_v_out_323121.awb")
				end

				arg_483_1:RecordContent(arg_483_1.text_.text)
			end

			local var_486_10 = math.max(var_486_1, arg_483_1.talkMaxDuration)

			if var_486_0 <= arg_483_1.time_ and arg_483_1.time_ < var_486_0 + var_486_10 then
				arg_483_1.typewritter.percent = (arg_483_1.time_ - var_486_0) / var_486_10

				arg_483_1.typewritter:SetDirty()
			end

			if arg_483_1.time_ >= var_486_0 + var_486_10 and arg_483_1.time_ < var_486_0 + var_486_10 + arg_486_0 then
				arg_483_1.typewritter.percent = 1

				arg_483_1.typewritter:SetDirty()
				arg_483_1:ShowNextGo(true)
			end
		end

		arg_483_1.nodeConfigList_ = {}

		arg_483_1:InitPlayNodeList()
	end,
	Play323121120 = function(arg_487_0, arg_487_1)
		arg_487_1.time_ = 0
		arg_487_1.frameCnt_ = 0
		arg_487_1.state_ = "playing"
		arg_487_1.curTalkId_ = 323121120
		arg_487_1.duration_ = 15.2

		local var_487_0 = {
			zh = 8.233,
			ja = 15.2
		}
		local var_487_1 = manager.audio:GetLocalizationFlag()

		if var_487_0[var_487_1] ~= nil then
			arg_487_1.duration_ = var_487_0[var_487_1]
		end

		SetActive(arg_487_1.tipsGo_, false)

		function arg_487_1.onSingleLineFinish_()
			arg_487_1.onSingleLineUpdate_ = nil
			arg_487_1.onSingleLineFinish_ = nil
			arg_487_1.state_ = "waiting"
		end

		function arg_487_1.playNext_(arg_489_0)
			if arg_489_0 == 1 then
				arg_487_0:Play323121121(arg_487_1)
			end
		end

		function arg_487_1.onSingleLineUpdate_(arg_490_0)
			local var_490_0 = 0
			local var_490_1 = 0.875

			if var_490_0 < arg_487_1.time_ and arg_487_1.time_ <= var_490_0 + arg_490_0 then
				arg_487_1.talkMaxDuration = 0
				arg_487_1.dialogCg_.alpha = 1

				arg_487_1.dialog_:SetActive(true)
				SetActive(arg_487_1.leftNameGo_, true)

				local var_490_2 = arg_487_1:FormatText(StoryNameCfg[1454].name)

				arg_487_1.leftNameTxt_.text = var_490_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_487_1.leftNameTxt_.transform)

				arg_487_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_487_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_487_1:RecordName(arg_487_1.leftNameTxt_.text)
				SetActive(arg_487_1.iconTrs_.gameObject, true)
				arg_487_1.iconController_:SetSelectedState("hero")

				arg_487_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10169")

				arg_487_1.callingController_:SetSelectedState("normal")

				arg_487_1.keyicon_.color = Color.New(1, 1, 1)
				arg_487_1.icon_.color = Color.New(1, 1, 1)

				local var_490_3 = arg_487_1:GetWordFromCfg(323121120)
				local var_490_4 = arg_487_1:FormatText(var_490_3.content)

				arg_487_1.text_.text = var_490_4

				LuaForUtil.ClearLinePrefixSymbol(arg_487_1.text_)

				local var_490_5 = 35
				local var_490_6 = utf8.len(var_490_4)
				local var_490_7 = var_490_5 <= 0 and var_490_1 or var_490_1 * (var_490_6 / var_490_5)

				if var_490_7 > 0 and var_490_1 < var_490_7 then
					arg_487_1.talkMaxDuration = var_490_7

					if var_490_7 + var_490_0 > arg_487_1.duration_ then
						arg_487_1.duration_ = var_490_7 + var_490_0
					end
				end

				arg_487_1.text_.text = var_490_4
				arg_487_1.typewritter.percent = 0

				arg_487_1.typewritter:SetDirty()
				arg_487_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323121", "323121120", "story_v_out_323121.awb") ~= 0 then
					local var_490_8 = manager.audio:GetVoiceLength("story_v_out_323121", "323121120", "story_v_out_323121.awb") / 1000

					if var_490_8 + var_490_0 > arg_487_1.duration_ then
						arg_487_1.duration_ = var_490_8 + var_490_0
					end

					if var_490_3.prefab_name ~= "" and arg_487_1.actors_[var_490_3.prefab_name] ~= nil then
						local var_490_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_487_1.actors_[var_490_3.prefab_name].transform, "story_v_out_323121", "323121120", "story_v_out_323121.awb")

						arg_487_1:RecordAudio("323121120", var_490_9)
						arg_487_1:RecordAudio("323121120", var_490_9)
					else
						arg_487_1:AudioAction("play", "voice", "story_v_out_323121", "323121120", "story_v_out_323121.awb")
					end

					arg_487_1:RecordHistoryTalkVoice("story_v_out_323121", "323121120", "story_v_out_323121.awb")
				end

				arg_487_1:RecordContent(arg_487_1.text_.text)
			end

			local var_490_10 = math.max(var_490_1, arg_487_1.talkMaxDuration)

			if var_490_0 <= arg_487_1.time_ and arg_487_1.time_ < var_490_0 + var_490_10 then
				arg_487_1.typewritter.percent = (arg_487_1.time_ - var_490_0) / var_490_10

				arg_487_1.typewritter:SetDirty()
			end

			if arg_487_1.time_ >= var_490_0 + var_490_10 and arg_487_1.time_ < var_490_0 + var_490_10 + arg_490_0 then
				arg_487_1.typewritter.percent = 1

				arg_487_1.typewritter:SetDirty()
				arg_487_1:ShowNextGo(true)
			end
		end

		arg_487_1.nodeConfigList_ = {}

		arg_487_1:InitPlayNodeList()
	end,
	Play323121121 = function(arg_491_0, arg_491_1)
		arg_491_1.time_ = 0
		arg_491_1.frameCnt_ = 0
		arg_491_1.state_ = "playing"
		arg_491_1.curTalkId_ = 323121121
		arg_491_1.duration_ = 13.97

		local var_491_0 = {
			zh = 6.666,
			ja = 13.966
		}
		local var_491_1 = manager.audio:GetLocalizationFlag()

		if var_491_0[var_491_1] ~= nil then
			arg_491_1.duration_ = var_491_0[var_491_1]
		end

		SetActive(arg_491_1.tipsGo_, false)

		function arg_491_1.onSingleLineFinish_()
			arg_491_1.onSingleLineUpdate_ = nil
			arg_491_1.onSingleLineFinish_ = nil
			arg_491_1.state_ = "waiting"
		end

		function arg_491_1.playNext_(arg_493_0)
			if arg_493_0 == 1 then
				arg_491_0:Play323121122(arg_491_1)
			end
		end

		function arg_491_1.onSingleLineUpdate_(arg_494_0)
			local var_494_0 = 0
			local var_494_1 = 0.7

			if var_494_0 < arg_491_1.time_ and arg_491_1.time_ <= var_494_0 + arg_494_0 then
				arg_491_1.talkMaxDuration = 0
				arg_491_1.dialogCg_.alpha = 1

				arg_491_1.dialog_:SetActive(true)
				SetActive(arg_491_1.leftNameGo_, true)

				local var_494_2 = arg_491_1:FormatText(StoryNameCfg[1454].name)

				arg_491_1.leftNameTxt_.text = var_494_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_491_1.leftNameTxt_.transform)

				arg_491_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_491_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_491_1:RecordName(arg_491_1.leftNameTxt_.text)
				SetActive(arg_491_1.iconTrs_.gameObject, true)
				arg_491_1.iconController_:SetSelectedState("hero")

				arg_491_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10169")

				arg_491_1.callingController_:SetSelectedState("normal")

				arg_491_1.keyicon_.color = Color.New(1, 1, 1)
				arg_491_1.icon_.color = Color.New(1, 1, 1)

				local var_494_3 = arg_491_1:GetWordFromCfg(323121121)
				local var_494_4 = arg_491_1:FormatText(var_494_3.content)

				arg_491_1.text_.text = var_494_4

				LuaForUtil.ClearLinePrefixSymbol(arg_491_1.text_)

				local var_494_5 = 28
				local var_494_6 = utf8.len(var_494_4)
				local var_494_7 = var_494_5 <= 0 and var_494_1 or var_494_1 * (var_494_6 / var_494_5)

				if var_494_7 > 0 and var_494_1 < var_494_7 then
					arg_491_1.talkMaxDuration = var_494_7

					if var_494_7 + var_494_0 > arg_491_1.duration_ then
						arg_491_1.duration_ = var_494_7 + var_494_0
					end
				end

				arg_491_1.text_.text = var_494_4
				arg_491_1.typewritter.percent = 0

				arg_491_1.typewritter:SetDirty()
				arg_491_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323121", "323121121", "story_v_out_323121.awb") ~= 0 then
					local var_494_8 = manager.audio:GetVoiceLength("story_v_out_323121", "323121121", "story_v_out_323121.awb") / 1000

					if var_494_8 + var_494_0 > arg_491_1.duration_ then
						arg_491_1.duration_ = var_494_8 + var_494_0
					end

					if var_494_3.prefab_name ~= "" and arg_491_1.actors_[var_494_3.prefab_name] ~= nil then
						local var_494_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_491_1.actors_[var_494_3.prefab_name].transform, "story_v_out_323121", "323121121", "story_v_out_323121.awb")

						arg_491_1:RecordAudio("323121121", var_494_9)
						arg_491_1:RecordAudio("323121121", var_494_9)
					else
						arg_491_1:AudioAction("play", "voice", "story_v_out_323121", "323121121", "story_v_out_323121.awb")
					end

					arg_491_1:RecordHistoryTalkVoice("story_v_out_323121", "323121121", "story_v_out_323121.awb")
				end

				arg_491_1:RecordContent(arg_491_1.text_.text)
			end

			local var_494_10 = math.max(var_494_1, arg_491_1.talkMaxDuration)

			if var_494_0 <= arg_491_1.time_ and arg_491_1.time_ < var_494_0 + var_494_10 then
				arg_491_1.typewritter.percent = (arg_491_1.time_ - var_494_0) / var_494_10

				arg_491_1.typewritter:SetDirty()
			end

			if arg_491_1.time_ >= var_494_0 + var_494_10 and arg_491_1.time_ < var_494_0 + var_494_10 + arg_494_0 then
				arg_491_1.typewritter.percent = 1

				arg_491_1.typewritter:SetDirty()
				arg_491_1:ShowNextGo(true)
			end
		end

		arg_491_1.nodeConfigList_ = {}

		arg_491_1:InitPlayNodeList()
	end,
	Play323121122 = function(arg_495_0, arg_495_1)
		arg_495_1.time_ = 0
		arg_495_1.frameCnt_ = 0
		arg_495_1.state_ = "playing"
		arg_495_1.curTalkId_ = 323121122
		arg_495_1.duration_ = 5

		SetActive(arg_495_1.tipsGo_, false)

		function arg_495_1.onSingleLineFinish_()
			arg_495_1.onSingleLineUpdate_ = nil
			arg_495_1.onSingleLineFinish_ = nil
			arg_495_1.state_ = "waiting"
		end

		function arg_495_1.playNext_(arg_497_0)
			if arg_497_0 == 1 then
				arg_495_0:Play323121123(arg_495_1)
			end
		end

		function arg_495_1.onSingleLineUpdate_(arg_498_0)
			local var_498_0 = 0
			local var_498_1 = 0.925

			if var_498_0 < arg_495_1.time_ and arg_495_1.time_ <= var_498_0 + arg_498_0 then
				arg_495_1.talkMaxDuration = 0
				arg_495_1.dialogCg_.alpha = 1

				arg_495_1.dialog_:SetActive(true)
				SetActive(arg_495_1.leftNameGo_, false)

				arg_495_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_495_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_495_1:RecordName(arg_495_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_495_1.iconTrs_.gameObject, false)
				arg_495_1.callingController_:SetSelectedState("normal")

				local var_498_2 = arg_495_1:GetWordFromCfg(323121122)
				local var_498_3 = arg_495_1:FormatText(var_498_2.content)

				arg_495_1.text_.text = var_498_3

				LuaForUtil.ClearLinePrefixSymbol(arg_495_1.text_)

				local var_498_4 = 37
				local var_498_5 = utf8.len(var_498_3)
				local var_498_6 = var_498_4 <= 0 and var_498_1 or var_498_1 * (var_498_5 / var_498_4)

				if var_498_6 > 0 and var_498_1 < var_498_6 then
					arg_495_1.talkMaxDuration = var_498_6

					if var_498_6 + var_498_0 > arg_495_1.duration_ then
						arg_495_1.duration_ = var_498_6 + var_498_0
					end
				end

				arg_495_1.text_.text = var_498_3
				arg_495_1.typewritter.percent = 0

				arg_495_1.typewritter:SetDirty()
				arg_495_1:ShowNextGo(false)
				arg_495_1:RecordContent(arg_495_1.text_.text)
			end

			local var_498_7 = math.max(var_498_1, arg_495_1.talkMaxDuration)

			if var_498_0 <= arg_495_1.time_ and arg_495_1.time_ < var_498_0 + var_498_7 then
				arg_495_1.typewritter.percent = (arg_495_1.time_ - var_498_0) / var_498_7

				arg_495_1.typewritter:SetDirty()
			end

			if arg_495_1.time_ >= var_498_0 + var_498_7 and arg_495_1.time_ < var_498_0 + var_498_7 + arg_498_0 then
				arg_495_1.typewritter.percent = 1

				arg_495_1.typewritter:SetDirty()
				arg_495_1:ShowNextGo(true)
			end
		end

		arg_495_1.nodeConfigList_ = {}

		arg_495_1:InitPlayNodeList()
	end,
	Play323121123 = function(arg_499_0, arg_499_1)
		arg_499_1.time_ = 0
		arg_499_1.frameCnt_ = 0
		arg_499_1.state_ = "playing"
		arg_499_1.curTalkId_ = 323121123
		arg_499_1.duration_ = 5

		SetActive(arg_499_1.tipsGo_, false)

		function arg_499_1.onSingleLineFinish_()
			arg_499_1.onSingleLineUpdate_ = nil
			arg_499_1.onSingleLineFinish_ = nil
			arg_499_1.state_ = "waiting"
		end

		function arg_499_1.playNext_(arg_501_0)
			if arg_501_0 == 1 then
				arg_499_0:Play323121124(arg_499_1)
			end
		end

		function arg_499_1.onSingleLineUpdate_(arg_502_0)
			local var_502_0 = 0
			local var_502_1 = 0.225

			if var_502_0 < arg_499_1.time_ and arg_499_1.time_ <= var_502_0 + arg_502_0 then
				arg_499_1.talkMaxDuration = 0
				arg_499_1.dialogCg_.alpha = 1

				arg_499_1.dialog_:SetActive(true)
				SetActive(arg_499_1.leftNameGo_, true)

				local var_502_2 = arg_499_1:FormatText(StoryNameCfg[7].name)

				arg_499_1.leftNameTxt_.text = var_502_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_499_1.leftNameTxt_.transform)

				arg_499_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_499_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_499_1:RecordName(arg_499_1.leftNameTxt_.text)
				SetActive(arg_499_1.iconTrs_.gameObject, true)
				arg_499_1.iconController_:SetSelectedState("hero")

				arg_499_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_499_1.callingController_:SetSelectedState("normal")

				arg_499_1.keyicon_.color = Color.New(1, 1, 1)
				arg_499_1.icon_.color = Color.New(1, 1, 1)

				local var_502_3 = arg_499_1:GetWordFromCfg(323121123)
				local var_502_4 = arg_499_1:FormatText(var_502_3.content)

				arg_499_1.text_.text = var_502_4

				LuaForUtil.ClearLinePrefixSymbol(arg_499_1.text_)

				local var_502_5 = 9
				local var_502_6 = utf8.len(var_502_4)
				local var_502_7 = var_502_5 <= 0 and var_502_1 or var_502_1 * (var_502_6 / var_502_5)

				if var_502_7 > 0 and var_502_1 < var_502_7 then
					arg_499_1.talkMaxDuration = var_502_7

					if var_502_7 + var_502_0 > arg_499_1.duration_ then
						arg_499_1.duration_ = var_502_7 + var_502_0
					end
				end

				arg_499_1.text_.text = var_502_4
				arg_499_1.typewritter.percent = 0

				arg_499_1.typewritter:SetDirty()
				arg_499_1:ShowNextGo(false)
				arg_499_1:RecordContent(arg_499_1.text_.text)
			end

			local var_502_8 = math.max(var_502_1, arg_499_1.talkMaxDuration)

			if var_502_0 <= arg_499_1.time_ and arg_499_1.time_ < var_502_0 + var_502_8 then
				arg_499_1.typewritter.percent = (arg_499_1.time_ - var_502_0) / var_502_8

				arg_499_1.typewritter:SetDirty()
			end

			if arg_499_1.time_ >= var_502_0 + var_502_8 and arg_499_1.time_ < var_502_0 + var_502_8 + arg_502_0 then
				arg_499_1.typewritter.percent = 1

				arg_499_1.typewritter:SetDirty()
				arg_499_1:ShowNextGo(true)
			end
		end

		arg_499_1.nodeConfigList_ = {}

		arg_499_1:InitPlayNodeList()
	end,
	Play323121124 = function(arg_503_0, arg_503_1)
		arg_503_1.time_ = 0
		arg_503_1.frameCnt_ = 0
		arg_503_1.state_ = "playing"
		arg_503_1.curTalkId_ = 323121124
		arg_503_1.duration_ = 5

		SetActive(arg_503_1.tipsGo_, false)

		function arg_503_1.onSingleLineFinish_()
			arg_503_1.onSingleLineUpdate_ = nil
			arg_503_1.onSingleLineFinish_ = nil
			arg_503_1.state_ = "waiting"
		end

		function arg_503_1.playNext_(arg_505_0)
			if arg_505_0 == 1 then
				arg_503_0:Play323121125(arg_503_1)
			end
		end

		function arg_503_1.onSingleLineUpdate_(arg_506_0)
			local var_506_0 = 0
			local var_506_1 = 1

			if var_506_0 < arg_503_1.time_ and arg_503_1.time_ <= var_506_0 + arg_506_0 then
				arg_503_1.talkMaxDuration = 0
				arg_503_1.dialogCg_.alpha = 1

				arg_503_1.dialog_:SetActive(true)
				SetActive(arg_503_1.leftNameGo_, false)

				arg_503_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_503_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_503_1:RecordName(arg_503_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_503_1.iconTrs_.gameObject, false)
				arg_503_1.callingController_:SetSelectedState("normal")

				local var_506_2 = arg_503_1:GetWordFromCfg(323121124)
				local var_506_3 = arg_503_1:FormatText(var_506_2.content)

				arg_503_1.text_.text = var_506_3

				LuaForUtil.ClearLinePrefixSymbol(arg_503_1.text_)

				local var_506_4 = 40
				local var_506_5 = utf8.len(var_506_3)
				local var_506_6 = var_506_4 <= 0 and var_506_1 or var_506_1 * (var_506_5 / var_506_4)

				if var_506_6 > 0 and var_506_1 < var_506_6 then
					arg_503_1.talkMaxDuration = var_506_6

					if var_506_6 + var_506_0 > arg_503_1.duration_ then
						arg_503_1.duration_ = var_506_6 + var_506_0
					end
				end

				arg_503_1.text_.text = var_506_3
				arg_503_1.typewritter.percent = 0

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(false)
				arg_503_1:RecordContent(arg_503_1.text_.text)
			end

			local var_506_7 = math.max(var_506_1, arg_503_1.talkMaxDuration)

			if var_506_0 <= arg_503_1.time_ and arg_503_1.time_ < var_506_0 + var_506_7 then
				arg_503_1.typewritter.percent = (arg_503_1.time_ - var_506_0) / var_506_7

				arg_503_1.typewritter:SetDirty()
			end

			if arg_503_1.time_ >= var_506_0 + var_506_7 and arg_503_1.time_ < var_506_0 + var_506_7 + arg_506_0 then
				arg_503_1.typewritter.percent = 1

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(true)
			end
		end

		arg_503_1.nodeConfigList_ = {}

		arg_503_1:InitPlayNodeList()
	end,
	Play323121125 = function(arg_507_0, arg_507_1)
		arg_507_1.time_ = 0
		arg_507_1.frameCnt_ = 0
		arg_507_1.state_ = "playing"
		arg_507_1.curTalkId_ = 323121125
		arg_507_1.duration_ = 6

		SetActive(arg_507_1.tipsGo_, false)

		function arg_507_1.onSingleLineFinish_()
			arg_507_1.onSingleLineUpdate_ = nil
			arg_507_1.onSingleLineFinish_ = nil
			arg_507_1.state_ = "waiting"
		end

		function arg_507_1.playNext_(arg_509_0)
			if arg_509_0 == 1 then
				arg_507_0:Play323121126(arg_507_1)
			end
		end

		function arg_507_1.onSingleLineUpdate_(arg_510_0)
			local var_510_0 = 0.266666666666667
			local var_510_1 = 1

			if var_510_0 < arg_507_1.time_ and arg_507_1.time_ <= var_510_0 + arg_510_0 then
				local var_510_2 = "play"
				local var_510_3 = "effect"

				arg_507_1:AudioAction(var_510_2, var_510_3, "se_story_148", "se_story_148_sword05", "")
			end

			local var_510_4 = manager.ui.mainCamera.transform
			local var_510_5 = 0

			if var_510_5 < arg_507_1.time_ and arg_507_1.time_ <= var_510_5 + arg_510_0 then
				local var_510_6 = arg_507_1.var_.effect000
				local var_510_7
				local var_510_8 = var_510_4

				if not var_510_6 then
					var_510_6 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_qiliuzhan"), var_510_8)
					var_510_6.name = "000"
					arg_507_1.var_.effect000 = var_510_6
				else
					var_510_6.transform:SetParent(var_510_8)
				end

				var_510_6.transform.localPosition = Vector3.New(-0.39, 0.79, -3.43)
				var_510_6.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_510_9 = 1.7777777777777777
				local var_510_10 = Screen.width / Screen.height
				local var_510_11 = var_510_10 / var_510_9
				local var_510_12 = Mathf.Max(var_510_9 / var_510_10, 1)
				local var_510_13 = Mathf.Max(var_510_11, var_510_12)

				var_510_6.transform.localScale = Vector3.New(var_510_6.transform.localScale.x * var_510_13, var_510_6.transform.localScale.y * var_510_13, var_510_6.transform.localScale.z * var_510_13)
			end

			local var_510_14 = manager.ui.mainCamera.transform
			local var_510_15 = 2.63333333333333

			if var_510_15 < arg_507_1.time_ and arg_507_1.time_ <= var_510_15 + arg_510_0 then
				local var_510_16 = arg_507_1.var_.effect000

				if var_510_16 then
					Object.Destroy(var_510_16)

					arg_507_1.var_.effect000 = nil
				end
			end

			local var_510_17 = 0

			if var_510_17 < arg_507_1.time_ and arg_507_1.time_ <= var_510_17 + arg_510_0 then
				arg_507_1.allBtn_.enabled = false
			end

			local var_510_18 = 1.26666666666667

			if arg_507_1.time_ >= var_510_17 + var_510_18 and arg_507_1.time_ < var_510_17 + var_510_18 + arg_510_0 then
				arg_507_1.allBtn_.enabled = true
			end

			if arg_507_1.frameCnt_ <= 1 then
				arg_507_1.dialog_:SetActive(false)
			end

			local var_510_19 = 1
			local var_510_20 = 1.1

			if var_510_19 < arg_507_1.time_ and arg_507_1.time_ <= var_510_19 + arg_510_0 then
				arg_507_1.talkMaxDuration = 0

				arg_507_1.dialog_:SetActive(true)

				arg_507_1.dialogCg_.alpha = 0

				local var_510_21 = LeanTween.value(arg_507_1.dialog_, 0, 1, 0.3)

				var_510_21:setOnUpdate(LuaHelper.FloatAction(function(arg_511_0)
					arg_507_1.dialogCg_.alpha = arg_511_0
				end))
				var_510_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_507_1.dialog_)
					var_510_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_507_1.duration_ = arg_507_1.duration_ + 0.3

				SetActive(arg_507_1.leftNameGo_, false)

				arg_507_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_507_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_507_1:RecordName(arg_507_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_507_1.iconTrs_.gameObject, false)
				arg_507_1.callingController_:SetSelectedState("normal")

				local var_510_22 = arg_507_1:GetWordFromCfg(323121125)
				local var_510_23 = arg_507_1:FormatText(var_510_22.content)

				arg_507_1.text_.text = var_510_23

				LuaForUtil.ClearLinePrefixSymbol(arg_507_1.text_)

				local var_510_24 = 44
				local var_510_25 = utf8.len(var_510_23)
				local var_510_26 = var_510_24 <= 0 and var_510_20 or var_510_20 * (var_510_25 / var_510_24)

				if var_510_26 > 0 and var_510_20 < var_510_26 then
					arg_507_1.talkMaxDuration = var_510_26
					var_510_19 = var_510_19 + 0.3

					if var_510_26 + var_510_19 > arg_507_1.duration_ then
						arg_507_1.duration_ = var_510_26 + var_510_19
					end
				end

				arg_507_1.text_.text = var_510_23
				arg_507_1.typewritter.percent = 0

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(false)
				arg_507_1:RecordContent(arg_507_1.text_.text)
			end

			local var_510_27 = var_510_19 + 0.3
			local var_510_28 = math.max(var_510_20, arg_507_1.talkMaxDuration)

			if var_510_27 <= arg_507_1.time_ and arg_507_1.time_ < var_510_27 + var_510_28 then
				arg_507_1.typewritter.percent = (arg_507_1.time_ - var_510_27) / var_510_28

				arg_507_1.typewritter:SetDirty()
			end

			if arg_507_1.time_ >= var_510_27 + var_510_28 and arg_507_1.time_ < var_510_27 + var_510_28 + arg_510_0 then
				arg_507_1.typewritter.percent = 1

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(true)
			end
		end

		arg_507_1.nodeConfigList_ = {}

		arg_507_1:InitPlayNodeList()
	end,
	Play323121126 = function(arg_513_0, arg_513_1)
		arg_513_1.time_ = 0
		arg_513_1.frameCnt_ = 0
		arg_513_1.state_ = "playing"
		arg_513_1.curTalkId_ = 323121126
		arg_513_1.duration_ = 5

		SetActive(arg_513_1.tipsGo_, false)

		function arg_513_1.onSingleLineFinish_()
			arg_513_1.onSingleLineUpdate_ = nil
			arg_513_1.onSingleLineFinish_ = nil
			arg_513_1.state_ = "waiting"
		end

		function arg_513_1.playNext_(arg_515_0)
			if arg_515_0 == 1 then
				arg_513_0:Play323121127(arg_513_1)
			end
		end

		function arg_513_1.onSingleLineUpdate_(arg_516_0)
			local var_516_0 = 0
			local var_516_1 = 0.475

			if var_516_0 < arg_513_1.time_ and arg_513_1.time_ <= var_516_0 + arg_516_0 then
				arg_513_1.talkMaxDuration = 0
				arg_513_1.dialogCg_.alpha = 1

				arg_513_1.dialog_:SetActive(true)
				SetActive(arg_513_1.leftNameGo_, true)

				local var_516_2 = arg_513_1:FormatText(StoryNameCfg[7].name)

				arg_513_1.leftNameTxt_.text = var_516_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_513_1.leftNameTxt_.transform)

				arg_513_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_513_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_513_1:RecordName(arg_513_1.leftNameTxt_.text)
				SetActive(arg_513_1.iconTrs_.gameObject, true)
				arg_513_1.iconController_:SetSelectedState("hero")

				arg_513_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_513_1.callingController_:SetSelectedState("normal")

				arg_513_1.keyicon_.color = Color.New(1, 1, 1)
				arg_513_1.icon_.color = Color.New(1, 1, 1)

				local var_516_3 = arg_513_1:GetWordFromCfg(323121126)
				local var_516_4 = arg_513_1:FormatText(var_516_3.content)

				arg_513_1.text_.text = var_516_4

				LuaForUtil.ClearLinePrefixSymbol(arg_513_1.text_)

				local var_516_5 = 19
				local var_516_6 = utf8.len(var_516_4)
				local var_516_7 = var_516_5 <= 0 and var_516_1 or var_516_1 * (var_516_6 / var_516_5)

				if var_516_7 > 0 and var_516_1 < var_516_7 then
					arg_513_1.talkMaxDuration = var_516_7

					if var_516_7 + var_516_0 > arg_513_1.duration_ then
						arg_513_1.duration_ = var_516_7 + var_516_0
					end
				end

				arg_513_1.text_.text = var_516_4
				arg_513_1.typewritter.percent = 0

				arg_513_1.typewritter:SetDirty()
				arg_513_1:ShowNextGo(false)
				arg_513_1:RecordContent(arg_513_1.text_.text)
			end

			local var_516_8 = math.max(var_516_1, arg_513_1.talkMaxDuration)

			if var_516_0 <= arg_513_1.time_ and arg_513_1.time_ < var_516_0 + var_516_8 then
				arg_513_1.typewritter.percent = (arg_513_1.time_ - var_516_0) / var_516_8

				arg_513_1.typewritter:SetDirty()
			end

			if arg_513_1.time_ >= var_516_0 + var_516_8 and arg_513_1.time_ < var_516_0 + var_516_8 + arg_516_0 then
				arg_513_1.typewritter.percent = 1

				arg_513_1.typewritter:SetDirty()
				arg_513_1:ShowNextGo(true)
			end
		end

		arg_513_1.nodeConfigList_ = {}

		arg_513_1:InitPlayNodeList()
	end,
	Play323121127 = function(arg_517_0, arg_517_1)
		arg_517_1.time_ = 0
		arg_517_1.frameCnt_ = 0
		arg_517_1.state_ = "playing"
		arg_517_1.curTalkId_ = 323121127
		arg_517_1.duration_ = 2

		SetActive(arg_517_1.tipsGo_, false)

		function arg_517_1.onSingleLineFinish_()
			arg_517_1.onSingleLineUpdate_ = nil
			arg_517_1.onSingleLineFinish_ = nil
			arg_517_1.state_ = "waiting"
		end

		function arg_517_1.playNext_(arg_519_0)
			if arg_519_0 == 1 then
				arg_517_0:Play323121128(arg_517_1)
			end
		end

		function arg_517_1.onSingleLineUpdate_(arg_520_0)
			local var_520_0 = arg_517_1.actors_["10170ui_story"].transform
			local var_520_1 = 0

			if var_520_1 < arg_517_1.time_ and arg_517_1.time_ <= var_520_1 + arg_520_0 then
				arg_517_1.var_.moveOldPos10170ui_story = var_520_0.localPosition

				local var_520_2 = GameObjectTools.GetOrAddComponent(var_520_0.gameObject, typeof(DynamicBoneHelper))

				if var_520_2 then
					var_520_2:EnableDynamicBone(false)
				end
			end

			local var_520_3 = 0.001

			if var_520_1 <= arg_517_1.time_ and arg_517_1.time_ < var_520_1 + var_520_3 then
				local var_520_4 = (arg_517_1.time_ - var_520_1) / var_520_3
				local var_520_5 = Vector3.New(0, -1.03, -6.05)

				var_520_0.localPosition = Vector3.Lerp(arg_517_1.var_.moveOldPos10170ui_story, var_520_5, var_520_4)

				local var_520_6 = manager.ui.mainCamera.transform.position - var_520_0.position

				var_520_0.forward = Vector3.New(var_520_6.x, var_520_6.y, var_520_6.z)

				local var_520_7 = var_520_0.localEulerAngles

				var_520_7.z = 0
				var_520_7.x = 0
				var_520_0.localEulerAngles = var_520_7
			end

			if arg_517_1.time_ >= var_520_1 + var_520_3 and arg_517_1.time_ < var_520_1 + var_520_3 + arg_520_0 then
				var_520_0.localPosition = Vector3.New(0, -1.03, -6.05)

				local var_520_8 = manager.ui.mainCamera.transform.position - var_520_0.position

				var_520_0.forward = Vector3.New(var_520_8.x, var_520_8.y, var_520_8.z)

				local var_520_9 = var_520_0.localEulerAngles

				var_520_9.z = 0
				var_520_9.x = 0
				var_520_0.localEulerAngles = var_520_9

				local var_520_10 = GameObjectTools.GetOrAddComponent(var_520_0.gameObject, typeof(DynamicBoneHelper))

				if var_520_10 then
					var_520_10:EnableDynamicBone(true)
				end
			end

			local var_520_11 = arg_517_1.actors_["10170ui_story"]
			local var_520_12 = 0

			if var_520_12 < arg_517_1.time_ and arg_517_1.time_ <= var_520_12 + arg_520_0 and not isNil(var_520_11) and arg_517_1.var_.characterEffect10170ui_story == nil then
				arg_517_1.var_.characterEffect10170ui_story = var_520_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_520_13 = 0.200000002980232

			if var_520_12 <= arg_517_1.time_ and arg_517_1.time_ < var_520_12 + var_520_13 and not isNil(var_520_11) then
				local var_520_14 = (arg_517_1.time_ - var_520_12) / var_520_13

				if arg_517_1.var_.characterEffect10170ui_story and not isNil(var_520_11) then
					arg_517_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_517_1.time_ >= var_520_12 + var_520_13 and arg_517_1.time_ < var_520_12 + var_520_13 + arg_520_0 and not isNil(var_520_11) and arg_517_1.var_.characterEffect10170ui_story then
				arg_517_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_520_15 = 0

			if var_520_15 < arg_517_1.time_ and arg_517_1.time_ <= var_520_15 + arg_520_0 then
				arg_517_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_520_16 = 0

			if var_520_16 < arg_517_1.time_ and arg_517_1.time_ <= var_520_16 + arg_520_0 then
				arg_517_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/story10170/story10170action/10170action2_2")
			end

			local var_520_17 = 0
			local var_520_18 = 0.125

			if var_520_17 < arg_517_1.time_ and arg_517_1.time_ <= var_520_17 + arg_520_0 then
				arg_517_1.talkMaxDuration = 0
				arg_517_1.dialogCg_.alpha = 1

				arg_517_1.dialog_:SetActive(true)
				SetActive(arg_517_1.leftNameGo_, true)

				local var_520_19 = arg_517_1:FormatText(StoryNameCfg[1450].name)

				arg_517_1.leftNameTxt_.text = var_520_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_517_1.leftNameTxt_.transform)

				arg_517_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_517_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_517_1:RecordName(arg_517_1.leftNameTxt_.text)
				SetActive(arg_517_1.iconTrs_.gameObject, false)
				arg_517_1.callingController_:SetSelectedState("normal")

				local var_520_20 = arg_517_1:GetWordFromCfg(323121127)
				local var_520_21 = arg_517_1:FormatText(var_520_20.content)

				arg_517_1.text_.text = var_520_21

				LuaForUtil.ClearLinePrefixSymbol(arg_517_1.text_)

				local var_520_22 = 5
				local var_520_23 = utf8.len(var_520_21)
				local var_520_24 = var_520_22 <= 0 and var_520_18 or var_520_18 * (var_520_23 / var_520_22)

				if var_520_24 > 0 and var_520_18 < var_520_24 then
					arg_517_1.talkMaxDuration = var_520_24

					if var_520_24 + var_520_17 > arg_517_1.duration_ then
						arg_517_1.duration_ = var_520_24 + var_520_17
					end
				end

				arg_517_1.text_.text = var_520_21
				arg_517_1.typewritter.percent = 0

				arg_517_1.typewritter:SetDirty()
				arg_517_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323121", "323121127", "story_v_out_323121.awb") ~= 0 then
					local var_520_25 = manager.audio:GetVoiceLength("story_v_out_323121", "323121127", "story_v_out_323121.awb") / 1000

					if var_520_25 + var_520_17 > arg_517_1.duration_ then
						arg_517_1.duration_ = var_520_25 + var_520_17
					end

					if var_520_20.prefab_name ~= "" and arg_517_1.actors_[var_520_20.prefab_name] ~= nil then
						local var_520_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_517_1.actors_[var_520_20.prefab_name].transform, "story_v_out_323121", "323121127", "story_v_out_323121.awb")

						arg_517_1:RecordAudio("323121127", var_520_26)
						arg_517_1:RecordAudio("323121127", var_520_26)
					else
						arg_517_1:AudioAction("play", "voice", "story_v_out_323121", "323121127", "story_v_out_323121.awb")
					end

					arg_517_1:RecordHistoryTalkVoice("story_v_out_323121", "323121127", "story_v_out_323121.awb")
				end

				arg_517_1:RecordContent(arg_517_1.text_.text)
			end

			local var_520_27 = math.max(var_520_18, arg_517_1.talkMaxDuration)

			if var_520_17 <= arg_517_1.time_ and arg_517_1.time_ < var_520_17 + var_520_27 then
				arg_517_1.typewritter.percent = (arg_517_1.time_ - var_520_17) / var_520_27

				arg_517_1.typewritter:SetDirty()
			end

			if arg_517_1.time_ >= var_520_17 + var_520_27 and arg_517_1.time_ < var_520_17 + var_520_27 + arg_520_0 then
				arg_517_1.typewritter.percent = 1

				arg_517_1.typewritter:SetDirty()
				arg_517_1:ShowNextGo(true)
			end
		end

		arg_517_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_517_1:InitPlayNodeList()
	end,
	Play323121128 = function(arg_521_0, arg_521_1)
		arg_521_1.time_ = 0
		arg_521_1.frameCnt_ = 0
		arg_521_1.state_ = "playing"
		arg_521_1.curTalkId_ = 323121128
		arg_521_1.duration_ = 5

		SetActive(arg_521_1.tipsGo_, false)

		function arg_521_1.onSingleLineFinish_()
			arg_521_1.onSingleLineUpdate_ = nil
			arg_521_1.onSingleLineFinish_ = nil
			arg_521_1.state_ = "waiting"
		end

		function arg_521_1.playNext_(arg_523_0)
			if arg_523_0 == 1 then
				arg_521_0:Play323121129(arg_521_1)
			end
		end

		function arg_521_1.onSingleLineUpdate_(arg_524_0)
			local var_524_0 = arg_521_1.actors_["10170ui_story"]
			local var_524_1 = 0

			if var_524_1 < arg_521_1.time_ and arg_521_1.time_ <= var_524_1 + arg_524_0 and not isNil(var_524_0) and arg_521_1.var_.characterEffect10170ui_story == nil then
				arg_521_1.var_.characterEffect10170ui_story = var_524_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_524_2 = 0.200000002980232

			if var_524_1 <= arg_521_1.time_ and arg_521_1.time_ < var_524_1 + var_524_2 and not isNil(var_524_0) then
				local var_524_3 = (arg_521_1.time_ - var_524_1) / var_524_2

				if arg_521_1.var_.characterEffect10170ui_story and not isNil(var_524_0) then
					local var_524_4 = Mathf.Lerp(0, 0.5, var_524_3)

					arg_521_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_521_1.var_.characterEffect10170ui_story.fillRatio = var_524_4
				end
			end

			if arg_521_1.time_ >= var_524_1 + var_524_2 and arg_521_1.time_ < var_524_1 + var_524_2 + arg_524_0 and not isNil(var_524_0) and arg_521_1.var_.characterEffect10170ui_story then
				local var_524_5 = 0.5

				arg_521_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_521_1.var_.characterEffect10170ui_story.fillRatio = var_524_5
			end

			local var_524_6 = 0
			local var_524_7 = 0.125

			if var_524_6 < arg_521_1.time_ and arg_521_1.time_ <= var_524_6 + arg_524_0 then
				arg_521_1.talkMaxDuration = 0
				arg_521_1.dialogCg_.alpha = 1

				arg_521_1.dialog_:SetActive(true)
				SetActive(arg_521_1.leftNameGo_, true)

				local var_524_8 = arg_521_1:FormatText(StoryNameCfg[7].name)

				arg_521_1.leftNameTxt_.text = var_524_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_521_1.leftNameTxt_.transform)

				arg_521_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_521_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_521_1:RecordName(arg_521_1.leftNameTxt_.text)
				SetActive(arg_521_1.iconTrs_.gameObject, true)
				arg_521_1.iconController_:SetSelectedState("hero")

				arg_521_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_521_1.callingController_:SetSelectedState("normal")

				arg_521_1.keyicon_.color = Color.New(1, 1, 1)
				arg_521_1.icon_.color = Color.New(1, 1, 1)

				local var_524_9 = arg_521_1:GetWordFromCfg(323121128)
				local var_524_10 = arg_521_1:FormatText(var_524_9.content)

				arg_521_1.text_.text = var_524_10

				LuaForUtil.ClearLinePrefixSymbol(arg_521_1.text_)

				local var_524_11 = 5
				local var_524_12 = utf8.len(var_524_10)
				local var_524_13 = var_524_11 <= 0 and var_524_7 or var_524_7 * (var_524_12 / var_524_11)

				if var_524_13 > 0 and var_524_7 < var_524_13 then
					arg_521_1.talkMaxDuration = var_524_13

					if var_524_13 + var_524_6 > arg_521_1.duration_ then
						arg_521_1.duration_ = var_524_13 + var_524_6
					end
				end

				arg_521_1.text_.text = var_524_10
				arg_521_1.typewritter.percent = 0

				arg_521_1.typewritter:SetDirty()
				arg_521_1:ShowNextGo(false)
				arg_521_1:RecordContent(arg_521_1.text_.text)
			end

			local var_524_14 = math.max(var_524_7, arg_521_1.talkMaxDuration)

			if var_524_6 <= arg_521_1.time_ and arg_521_1.time_ < var_524_6 + var_524_14 then
				arg_521_1.typewritter.percent = (arg_521_1.time_ - var_524_6) / var_524_14

				arg_521_1.typewritter:SetDirty()
			end

			if arg_521_1.time_ >= var_524_6 + var_524_14 and arg_521_1.time_ < var_524_6 + var_524_14 + arg_524_0 then
				arg_521_1.typewritter.percent = 1

				arg_521_1.typewritter:SetDirty()
				arg_521_1:ShowNextGo(true)
			end
		end

		arg_521_1.nodeConfigList_ = {}

		arg_521_1:InitPlayNodeList()
	end,
	Play323121129 = function(arg_525_0, arg_525_1)
		arg_525_1.time_ = 0
		arg_525_1.frameCnt_ = 0
		arg_525_1.state_ = "playing"
		arg_525_1.curTalkId_ = 323121129
		arg_525_1.duration_ = 5.43

		SetActive(arg_525_1.tipsGo_, false)

		function arg_525_1.onSingleLineFinish_()
			arg_525_1.onSingleLineUpdate_ = nil
			arg_525_1.onSingleLineFinish_ = nil
			arg_525_1.state_ = "waiting"
		end

		function arg_525_1.playNext_(arg_527_0)
			if arg_527_0 == 1 then
				arg_525_0:Play323121130(arg_525_1)
			end
		end

		function arg_525_1.onSingleLineUpdate_(arg_528_0)
			local var_528_0 = arg_525_1.actors_["10170ui_story"].transform
			local var_528_1 = 0

			if var_528_1 < arg_525_1.time_ and arg_525_1.time_ <= var_528_1 + arg_528_0 then
				arg_525_1.var_.moveOldPos10170ui_story = var_528_0.localPosition

				local var_528_2 = GameObjectTools.GetOrAddComponent(var_528_0.gameObject, typeof(DynamicBoneHelper))

				if var_528_2 then
					var_528_2:EnableDynamicBone(false)
				end
			end

			local var_528_3 = 0.001

			if var_528_1 <= arg_525_1.time_ and arg_525_1.time_ < var_528_1 + var_528_3 then
				local var_528_4 = (arg_525_1.time_ - var_528_1) / var_528_3
				local var_528_5 = Vector3.New(0, 100, 0)

				var_528_0.localPosition = Vector3.Lerp(arg_525_1.var_.moveOldPos10170ui_story, var_528_5, var_528_4)

				local var_528_6 = manager.ui.mainCamera.transform.position - var_528_0.position

				var_528_0.forward = Vector3.New(var_528_6.x, var_528_6.y, var_528_6.z)

				local var_528_7 = var_528_0.localEulerAngles

				var_528_7.z = 0
				var_528_7.x = 0
				var_528_0.localEulerAngles = var_528_7
			end

			if arg_525_1.time_ >= var_528_1 + var_528_3 and arg_525_1.time_ < var_528_1 + var_528_3 + arg_528_0 then
				var_528_0.localPosition = Vector3.New(0, 100, 0)

				local var_528_8 = manager.ui.mainCamera.transform.position - var_528_0.position

				var_528_0.forward = Vector3.New(var_528_8.x, var_528_8.y, var_528_8.z)

				local var_528_9 = var_528_0.localEulerAngles

				var_528_9.z = 0
				var_528_9.x = 0
				var_528_0.localEulerAngles = var_528_9

				local var_528_10 = GameObjectTools.GetOrAddComponent(var_528_0.gameObject, typeof(DynamicBoneHelper))

				if var_528_10 then
					var_528_10:EnableDynamicBone(true)
				end
			end

			local var_528_11 = manager.ui.mainCamera.transform
			local var_528_12 = 0

			if var_528_12 < arg_525_1.time_ and arg_525_1.time_ <= var_528_12 + arg_528_0 then
				local var_528_13 = arg_525_1.var_.effectlfneg
				local var_528_14
				local var_528_15 = var_528_11

				if not var_528_13 then
					var_528_13 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_liefeng_keep"), var_528_15)
					var_528_13.name = "lfneg"
					arg_525_1.var_.effectlfneg = var_528_13
				else
					var_528_13.transform:SetParent(var_528_15)
				end

				var_528_13.transform.localPosition = Vector3.New(0, 0, -1.01)
				var_528_13.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_528_16 = 1.7777777777777777
				local var_528_17 = Screen.width / Screen.height
				local var_528_18 = var_528_17 / var_528_16
				local var_528_19 = Mathf.Max(var_528_16 / var_528_17, 1)
				local var_528_20 = Mathf.Max(var_528_18, var_528_19)

				var_528_13.transform.localScale = Vector3.New(var_528_13.transform.localScale.x * var_528_20, var_528_13.transform.localScale.y * var_528_20, var_528_13.transform.localScale.z * var_528_20)
			end

			local var_528_21 = 0

			if var_528_21 < arg_525_1.time_ and arg_525_1.time_ <= var_528_21 + arg_528_0 then
				arg_525_1.allBtn_.enabled = false
			end

			local var_528_22 = 1.56666666666667

			if arg_525_1.time_ >= var_528_21 + var_528_22 and arg_525_1.time_ < var_528_21 + var_528_22 + arg_528_0 then
				arg_525_1.allBtn_.enabled = true
			end

			local var_528_23 = 0
			local var_528_24 = 1

			if var_528_23 < arg_525_1.time_ and arg_525_1.time_ <= var_528_23 + arg_528_0 then
				local var_528_25 = "play"
				local var_528_26 = "effect"

				arg_525_1:AudioAction(var_528_25, var_528_26, "se_story_148", "se_story_148_sword01", "")
			end

			if arg_525_1.frameCnt_ <= 1 then
				arg_525_1.dialog_:SetActive(false)
			end

			local var_528_27 = 0.433333333333333
			local var_528_28 = 0.975

			if var_528_27 < arg_525_1.time_ and arg_525_1.time_ <= var_528_27 + arg_528_0 then
				arg_525_1.talkMaxDuration = 0

				arg_525_1.dialog_:SetActive(true)

				arg_525_1.dialogCg_.alpha = 0

				local var_528_29 = LeanTween.value(arg_525_1.dialog_, 0, 1, 0.3)

				var_528_29:setOnUpdate(LuaHelper.FloatAction(function(arg_529_0)
					arg_525_1.dialogCg_.alpha = arg_529_0
				end))
				var_528_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_525_1.dialog_)
					var_528_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_525_1.duration_ = arg_525_1.duration_ + 0.3

				SetActive(arg_525_1.leftNameGo_, false)

				arg_525_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_525_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_525_1:RecordName(arg_525_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_525_1.iconTrs_.gameObject, false)
				arg_525_1.callingController_:SetSelectedState("normal")

				local var_528_30 = arg_525_1:GetWordFromCfg(323121129)
				local var_528_31 = arg_525_1:FormatText(var_528_30.content)

				arg_525_1.text_.text = var_528_31

				LuaForUtil.ClearLinePrefixSymbol(arg_525_1.text_)

				local var_528_32 = 39
				local var_528_33 = utf8.len(var_528_31)
				local var_528_34 = var_528_32 <= 0 and var_528_28 or var_528_28 * (var_528_33 / var_528_32)

				if var_528_34 > 0 and var_528_28 < var_528_34 then
					arg_525_1.talkMaxDuration = var_528_34
					var_528_27 = var_528_27 + 0.3

					if var_528_34 + var_528_27 > arg_525_1.duration_ then
						arg_525_1.duration_ = var_528_34 + var_528_27
					end
				end

				arg_525_1.text_.text = var_528_31
				arg_525_1.typewritter.percent = 0

				arg_525_1.typewritter:SetDirty()
				arg_525_1:ShowNextGo(false)
				arg_525_1:RecordContent(arg_525_1.text_.text)
			end

			local var_528_35 = var_528_27 + 0.3
			local var_528_36 = math.max(var_528_28, arg_525_1.talkMaxDuration)

			if var_528_35 <= arg_525_1.time_ and arg_525_1.time_ < var_528_35 + var_528_36 then
				arg_525_1.typewritter.percent = (arg_525_1.time_ - var_528_35) / var_528_36

				arg_525_1.typewritter:SetDirty()
			end

			if arg_525_1.time_ >= var_528_35 + var_528_36 and arg_525_1.time_ < var_528_35 + var_528_36 + arg_528_0 then
				arg_525_1.typewritter.percent = 1

				arg_525_1.typewritter:SetDirty()
				arg_525_1:ShowNextGo(true)
			end
		end

		arg_525_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_525_1:InitPlayNodeList()
	end,
	Play323121130 = function(arg_531_0, arg_531_1)
		arg_531_1.time_ = 0
		arg_531_1.frameCnt_ = 0
		arg_531_1.state_ = "playing"
		arg_531_1.curTalkId_ = 323121130
		arg_531_1.duration_ = 5

		SetActive(arg_531_1.tipsGo_, false)

		function arg_531_1.onSingleLineFinish_()
			arg_531_1.onSingleLineUpdate_ = nil
			arg_531_1.onSingleLineFinish_ = nil
			arg_531_1.state_ = "waiting"
		end

		function arg_531_1.playNext_(arg_533_0)
			if arg_533_0 == 1 then
				arg_531_0:Play323121131(arg_531_1)
			end
		end

		function arg_531_1.onSingleLineUpdate_(arg_534_0)
			local var_534_0 = 0
			local var_534_1 = 1.75

			if var_534_0 < arg_531_1.time_ and arg_531_1.time_ <= var_534_0 + arg_534_0 then
				arg_531_1.talkMaxDuration = 0
				arg_531_1.dialogCg_.alpha = 1

				arg_531_1.dialog_:SetActive(true)
				SetActive(arg_531_1.leftNameGo_, false)

				arg_531_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_531_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_531_1:RecordName(arg_531_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_531_1.iconTrs_.gameObject, false)
				arg_531_1.callingController_:SetSelectedState("normal")

				local var_534_2 = arg_531_1:GetWordFromCfg(323121130)
				local var_534_3 = arg_531_1:FormatText(var_534_2.content)

				arg_531_1.text_.text = var_534_3

				LuaForUtil.ClearLinePrefixSymbol(arg_531_1.text_)

				local var_534_4 = 70
				local var_534_5 = utf8.len(var_534_3)
				local var_534_6 = var_534_4 <= 0 and var_534_1 or var_534_1 * (var_534_5 / var_534_4)

				if var_534_6 > 0 and var_534_1 < var_534_6 then
					arg_531_1.talkMaxDuration = var_534_6

					if var_534_6 + var_534_0 > arg_531_1.duration_ then
						arg_531_1.duration_ = var_534_6 + var_534_0
					end
				end

				arg_531_1.text_.text = var_534_3
				arg_531_1.typewritter.percent = 0

				arg_531_1.typewritter:SetDirty()
				arg_531_1:ShowNextGo(false)
				arg_531_1:RecordContent(arg_531_1.text_.text)
			end

			local var_534_7 = math.max(var_534_1, arg_531_1.talkMaxDuration)

			if var_534_0 <= arg_531_1.time_ and arg_531_1.time_ < var_534_0 + var_534_7 then
				arg_531_1.typewritter.percent = (arg_531_1.time_ - var_534_0) / var_534_7

				arg_531_1.typewritter:SetDirty()
			end

			if arg_531_1.time_ >= var_534_0 + var_534_7 and arg_531_1.time_ < var_534_0 + var_534_7 + arg_534_0 then
				arg_531_1.typewritter.percent = 1

				arg_531_1.typewritter:SetDirty()
				arg_531_1:ShowNextGo(true)
			end
		end

		arg_531_1.nodeConfigList_ = {}

		arg_531_1:InitPlayNodeList()
	end,
	Play323121131 = function(arg_535_0, arg_535_1)
		arg_535_1.time_ = 0
		arg_535_1.frameCnt_ = 0
		arg_535_1.state_ = "playing"
		arg_535_1.curTalkId_ = 323121131
		arg_535_1.duration_ = 4.53

		SetActive(arg_535_1.tipsGo_, false)

		function arg_535_1.onSingleLineFinish_()
			arg_535_1.onSingleLineUpdate_ = nil
			arg_535_1.onSingleLineFinish_ = nil
			arg_535_1.state_ = "waiting"
		end

		function arg_535_1.playNext_(arg_537_0)
			if arg_537_0 == 1 then
				arg_535_0:Play323121132(arg_535_1)
			end
		end

		function arg_535_1.onSingleLineUpdate_(arg_538_0)
			local var_538_0 = "STblack"

			if arg_535_1.bgs_[var_538_0] == nil then
				local var_538_1 = Object.Instantiate(arg_535_1.paintGo_)

				var_538_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_538_0)
				var_538_1.name = var_538_0
				var_538_1.transform.parent = arg_535_1.stage_.transform
				var_538_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_535_1.bgs_[var_538_0] = var_538_1
			end

			local var_538_2 = 1

			if var_538_2 < arg_535_1.time_ and arg_535_1.time_ <= var_538_2 + arg_538_0 then
				local var_538_3 = manager.ui.mainCamera.transform.localPosition
				local var_538_4 = Vector3.New(0, 0, 10) + Vector3.New(var_538_3.x, var_538_3.y, 0)
				local var_538_5 = arg_535_1.bgs_.STblack

				var_538_5.transform.localPosition = var_538_4
				var_538_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_538_6 = var_538_5:GetComponent("SpriteRenderer")

				if var_538_6 and var_538_6.sprite then
					local var_538_7 = (var_538_5.transform.localPosition - var_538_3).z
					local var_538_8 = manager.ui.mainCameraCom_
					local var_538_9 = 2 * var_538_7 * Mathf.Tan(var_538_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_538_10 = var_538_9 * var_538_8.aspect
					local var_538_11 = var_538_6.sprite.bounds.size.x
					local var_538_12 = var_538_6.sprite.bounds.size.y
					local var_538_13 = var_538_10 / var_538_11
					local var_538_14 = var_538_9 / var_538_12
					local var_538_15 = var_538_14 < var_538_13 and var_538_13 or var_538_14

					var_538_5.transform.localScale = Vector3.New(var_538_15, var_538_15, 0)
				end

				for iter_538_0, iter_538_1 in pairs(arg_535_1.bgs_) do
					if iter_538_0 ~= "STblack" then
						iter_538_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_538_16 = 0

			if var_538_16 < arg_535_1.time_ and arg_535_1.time_ <= var_538_16 + arg_538_0 then
				arg_535_1.allBtn_.enabled = false
			end

			local var_538_17 = 0.3

			if arg_535_1.time_ >= var_538_16 + var_538_17 and arg_535_1.time_ < var_538_16 + var_538_17 + arg_538_0 then
				arg_535_1.allBtn_.enabled = true
			end

			local var_538_18 = 0

			if var_538_18 < arg_535_1.time_ and arg_535_1.time_ <= var_538_18 + arg_538_0 then
				arg_535_1.mask_.enabled = true
				arg_535_1.mask_.raycastTarget = true

				arg_535_1:SetGaussion(false)
			end

			local var_538_19 = 1

			if var_538_18 <= arg_535_1.time_ and arg_535_1.time_ < var_538_18 + var_538_19 then
				local var_538_20 = (arg_535_1.time_ - var_538_18) / var_538_19
				local var_538_21 = Color.New(0, 0, 0)

				var_538_21.a = Mathf.Lerp(0, 1, var_538_20)
				arg_535_1.mask_.color = var_538_21
			end

			if arg_535_1.time_ >= var_538_18 + var_538_19 and arg_535_1.time_ < var_538_18 + var_538_19 + arg_538_0 then
				local var_538_22 = Color.New(0, 0, 0)

				var_538_22.a = 1
				arg_535_1.mask_.color = var_538_22
			end

			local var_538_23 = 1

			if var_538_23 < arg_535_1.time_ and arg_535_1.time_ <= var_538_23 + arg_538_0 then
				arg_535_1.mask_.enabled = true
				arg_535_1.mask_.raycastTarget = true

				arg_535_1:SetGaussion(false)
			end

			local var_538_24 = 1.53333333333333

			if var_538_23 <= arg_535_1.time_ and arg_535_1.time_ < var_538_23 + var_538_24 then
				local var_538_25 = (arg_535_1.time_ - var_538_23) / var_538_24
				local var_538_26 = Color.New(0, 0, 0)

				var_538_26.a = Mathf.Lerp(1, 0, var_538_25)
				arg_535_1.mask_.color = var_538_26
			end

			if arg_535_1.time_ >= var_538_23 + var_538_24 and arg_535_1.time_ < var_538_23 + var_538_24 + arg_538_0 then
				local var_538_27 = Color.New(0, 0, 0)
				local var_538_28 = 0

				arg_535_1.mask_.enabled = false
				var_538_27.a = var_538_28
				arg_535_1.mask_.color = var_538_27
			end

			local var_538_29 = manager.ui.mainCamera.transform
			local var_538_30 = 0

			if var_538_30 < arg_535_1.time_ and arg_535_1.time_ <= var_538_30 + arg_538_0 then
				local var_538_31 = arg_535_1.var_.effectlfneg

				if var_538_31 then
					Object.Destroy(var_538_31)

					arg_535_1.var_.effectlfneg = nil
				end
			end

			local var_538_32 = manager.ui.mainCamera.transform
			local var_538_33 = 2

			if var_538_33 < arg_535_1.time_ and arg_535_1.time_ <= var_538_33 + arg_538_0 then
				local var_538_34 = arg_535_1.var_.effect4535
				local var_538_35
				local var_538_36 = var_538_32

				if not var_538_34 then
					var_538_34 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_error"), var_538_36)
					var_538_34.name = "4535"
					arg_535_1.var_.effect4535 = var_538_34
				else
					var_538_34.transform:SetParent(var_538_36)
				end

				var_538_34.transform.localPosition = Vector3.New(0, 0, 0)
				var_538_34.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_538_37 = 1.7777777777777777
				local var_538_38 = Screen.width / Screen.height
				local var_538_39 = var_538_38 / var_538_37
				local var_538_40 = Mathf.Max(var_538_37 / var_538_38, 1)

				var_538_34.transform.localScale = Vector3.New(var_538_34.transform.localScale.x * var_538_39, var_538_34.transform.localScale.y * var_538_40, var_538_34.transform.localScale.z)
			end

			local var_538_41 = manager.ui.mainCamera.transform
			local var_538_42 = 3.26666666666666

			if var_538_42 < arg_535_1.time_ and arg_535_1.time_ <= var_538_42 + arg_538_0 then
				local var_538_43 = arg_535_1.var_.effect4535

				if var_538_43 then
					Object.Destroy(var_538_43)

					arg_535_1.var_.effect4535 = nil
				end
			end

			local var_538_44 = 1

			if var_538_44 < arg_535_1.time_ and arg_535_1.time_ <= var_538_44 + arg_538_0 then
				arg_535_1.fswbg_:SetActive(false)
				arg_535_1.dialog_:SetActive(false)
				SetActive(arg_535_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_535_1:ShowNextGo(false)
			end

			local var_538_45 = 2
			local var_538_46 = 1
			local var_538_47 = manager.audio:GetVoiceLength("story_v_out_323121", "323121131", "0") / 1000

			if var_538_47 > 0 and var_538_46 < var_538_47 and var_538_47 + var_538_45 > arg_535_1.duration_ then
				local var_538_48 = var_538_47

				arg_535_1.duration_ = var_538_47 + var_538_45
			end

			if var_538_45 < arg_535_1.time_ and arg_535_1.time_ <= var_538_45 + arg_538_0 then
				local var_538_49 = "play"
				local var_538_50 = "voice"

				arg_535_1:AudioAction(var_538_49, var_538_50, "story_v_out_323121", "323121131", "0")
			end
		end

		arg_535_1.nodeConfigList_ = {
			{
				displayDialog = false,
				enableBgChange = false,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				enableEffect = true,
				contentID = 323121131,
				charCount = 16,
				enableLayoutChange = true,
				duration = 1.6,
				groupID = "233",
				startTime = 1.56666666666667,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.CREATE_TEXT_GROUP,
				layoutData = {
					topPadding = 0,
					bottomPadding = 0,
					rightPadding = 0,
					leftPadding = 0,
					paragraphSpacing = 0,
					offsetMin = Vector2.New(245, 170),
					offsetMax = Vector2.New(-128.6, -143.2),
					paragraphAlignment = UnityEngine.TextAnchor.MiddleLeft
				},
				textComProperty = {
					fontSize = 40,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.UpperLeft
				},
				effectData = {
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.TYPE_WRITER
				}
			}
		}

		arg_535_1:InitPlayNodeList()
	end,
	Play323121132 = function(arg_539_0, arg_539_1)
		arg_539_1.time_ = 0
		arg_539_1.frameCnt_ = 0
		arg_539_1.state_ = "playing"
		arg_539_1.curTalkId_ = 323121132
		arg_539_1.duration_ = 7.37

		SetActive(arg_539_1.tipsGo_, false)

		function arg_539_1.onSingleLineFinish_()
			arg_539_1.onSingleLineUpdate_ = nil
			arg_539_1.onSingleLineFinish_ = nil
			arg_539_1.state_ = "waiting"
		end

		function arg_539_1.playNext_(arg_541_0)
			if arg_541_0 == 1 then
				arg_539_0:Play323121133(arg_539_1)
			end
		end

		function arg_539_1.onSingleLineUpdate_(arg_542_0)
			local var_542_0 = 1

			if var_542_0 < arg_539_1.time_ and arg_539_1.time_ <= var_542_0 + arg_542_0 then
				local var_542_1 = manager.ui.mainCamera.transform.localPosition
				local var_542_2 = Vector3.New(0, 0, 10) + Vector3.New(var_542_1.x, var_542_1.y, 0)
				local var_542_3 = arg_539_1.bgs_.ST2005

				var_542_3.transform.localPosition = var_542_2
				var_542_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_542_4 = var_542_3:GetComponent("SpriteRenderer")

				if var_542_4 and var_542_4.sprite then
					local var_542_5 = (var_542_3.transform.localPosition - var_542_1).z
					local var_542_6 = manager.ui.mainCameraCom_
					local var_542_7 = 2 * var_542_5 * Mathf.Tan(var_542_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_542_8 = var_542_7 * var_542_6.aspect
					local var_542_9 = var_542_4.sprite.bounds.size.x
					local var_542_10 = var_542_4.sprite.bounds.size.y
					local var_542_11 = var_542_8 / var_542_9
					local var_542_12 = var_542_7 / var_542_10
					local var_542_13 = var_542_12 < var_542_11 and var_542_11 or var_542_12

					var_542_3.transform.localScale = Vector3.New(var_542_13, var_542_13, 0)
				end

				for iter_542_0, iter_542_1 in pairs(arg_539_1.bgs_) do
					if iter_542_0 ~= "ST2005" then
						iter_542_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_542_14 = 0

			if var_542_14 < arg_539_1.time_ and arg_539_1.time_ <= var_542_14 + arg_542_0 then
				arg_539_1.allBtn_.enabled = false
			end

			local var_542_15 = 0.3

			if arg_539_1.time_ >= var_542_14 + var_542_15 and arg_539_1.time_ < var_542_14 + var_542_15 + arg_542_0 then
				arg_539_1.allBtn_.enabled = true
			end

			local var_542_16 = 0

			if var_542_16 < arg_539_1.time_ and arg_539_1.time_ <= var_542_16 + arg_542_0 then
				arg_539_1.mask_.enabled = true
				arg_539_1.mask_.raycastTarget = true

				arg_539_1:SetGaussion(false)
			end

			local var_542_17 = 1

			if var_542_16 <= arg_539_1.time_ and arg_539_1.time_ < var_542_16 + var_542_17 then
				local var_542_18 = (arg_539_1.time_ - var_542_16) / var_542_17
				local var_542_19 = Color.New(0, 0, 0)

				var_542_19.a = Mathf.Lerp(0, 1, var_542_18)
				arg_539_1.mask_.color = var_542_19
			end

			if arg_539_1.time_ >= var_542_16 + var_542_17 and arg_539_1.time_ < var_542_16 + var_542_17 + arg_542_0 then
				local var_542_20 = Color.New(0, 0, 0)

				var_542_20.a = 1
				arg_539_1.mask_.color = var_542_20
			end

			local var_542_21 = 1

			if var_542_21 < arg_539_1.time_ and arg_539_1.time_ <= var_542_21 + arg_542_0 then
				arg_539_1.mask_.enabled = true
				arg_539_1.mask_.raycastTarget = true

				arg_539_1:SetGaussion(false)
			end

			local var_542_22 = 1.66666666666667

			if var_542_21 <= arg_539_1.time_ and arg_539_1.time_ < var_542_21 + var_542_22 then
				local var_542_23 = (arg_539_1.time_ - var_542_21) / var_542_22
				local var_542_24 = Color.New(0, 0, 0)

				var_542_24.a = Mathf.Lerp(1, 0, var_542_23)
				arg_539_1.mask_.color = var_542_24
			end

			if arg_539_1.time_ >= var_542_21 + var_542_22 and arg_539_1.time_ < var_542_21 + var_542_22 + arg_542_0 then
				local var_542_25 = Color.New(0, 0, 0)
				local var_542_26 = 0

				arg_539_1.mask_.enabled = false
				var_542_25.a = var_542_26
				arg_539_1.mask_.color = var_542_25
			end

			if arg_539_1.frameCnt_ <= 1 then
				arg_539_1.dialog_:SetActive(false)
			end

			local var_542_27 = 2.36666666666667
			local var_542_28 = 0.325

			if var_542_27 < arg_539_1.time_ and arg_539_1.time_ <= var_542_27 + arg_542_0 then
				arg_539_1.talkMaxDuration = 0

				arg_539_1.dialog_:SetActive(true)

				arg_539_1.dialogCg_.alpha = 0

				local var_542_29 = LeanTween.value(arg_539_1.dialog_, 0, 1, 0.3)

				var_542_29:setOnUpdate(LuaHelper.FloatAction(function(arg_543_0)
					arg_539_1.dialogCg_.alpha = arg_543_0
				end))
				var_542_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_539_1.dialog_)
					var_542_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_539_1.duration_ = arg_539_1.duration_ + 0.3

				SetActive(arg_539_1.leftNameGo_, true)

				local var_542_30 = arg_539_1:FormatText(StoryNameCfg[7].name)

				arg_539_1.leftNameTxt_.text = var_542_30

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_539_1.leftNameTxt_.transform)

				arg_539_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_539_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_539_1:RecordName(arg_539_1.leftNameTxt_.text)
				SetActive(arg_539_1.iconTrs_.gameObject, true)
				arg_539_1.iconController_:SetSelectedState("hero")

				arg_539_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_539_1.callingController_:SetSelectedState("normal")

				arg_539_1.keyicon_.color = Color.New(1, 1, 1)
				arg_539_1.icon_.color = Color.New(1, 1, 1)

				local var_542_31 = arg_539_1:GetWordFromCfg(323121132)
				local var_542_32 = arg_539_1:FormatText(var_542_31.content)

				arg_539_1.text_.text = var_542_32

				LuaForUtil.ClearLinePrefixSymbol(arg_539_1.text_)

				local var_542_33 = 13
				local var_542_34 = utf8.len(var_542_32)
				local var_542_35 = var_542_33 <= 0 and var_542_28 or var_542_28 * (var_542_34 / var_542_33)

				if var_542_35 > 0 and var_542_28 < var_542_35 then
					arg_539_1.talkMaxDuration = var_542_35
					var_542_27 = var_542_27 + 0.3

					if var_542_35 + var_542_27 > arg_539_1.duration_ then
						arg_539_1.duration_ = var_542_35 + var_542_27
					end
				end

				arg_539_1.text_.text = var_542_32
				arg_539_1.typewritter.percent = 0

				arg_539_1.typewritter:SetDirty()
				arg_539_1:ShowNextGo(false)
				arg_539_1:RecordContent(arg_539_1.text_.text)
			end

			local var_542_36 = var_542_27 + 0.3
			local var_542_37 = math.max(var_542_28, arg_539_1.talkMaxDuration)

			if var_542_36 <= arg_539_1.time_ and arg_539_1.time_ < var_542_36 + var_542_37 then
				arg_539_1.typewritter.percent = (arg_539_1.time_ - var_542_36) / var_542_37

				arg_539_1.typewritter:SetDirty()
			end

			if arg_539_1.time_ >= var_542_36 + var_542_37 and arg_539_1.time_ < var_542_36 + var_542_37 + arg_542_0 then
				arg_539_1.typewritter.percent = 1

				arg_539_1.typewritter:SetDirty()
				arg_539_1:ShowNextGo(true)
			end
		end

		arg_539_1.nodeConfigList_ = {
			{
				groupID = "222",
				duration = 0.666666666666667,
				className = "StoryTextGroupNode",
				startTime = 1,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.DESTROY_ALL_TEXT_GROUP
			}
		}

		arg_539_1:InitPlayNodeList()
	end,
	Play323121133 = function(arg_545_0, arg_545_1)
		arg_545_1.time_ = 0
		arg_545_1.frameCnt_ = 0
		arg_545_1.state_ = "playing"
		arg_545_1.curTalkId_ = 323121133
		arg_545_1.duration_ = 1.83

		SetActive(arg_545_1.tipsGo_, false)

		function arg_545_1.onSingleLineFinish_()
			arg_545_1.onSingleLineUpdate_ = nil
			arg_545_1.onSingleLineFinish_ = nil
			arg_545_1.state_ = "waiting"
		end

		function arg_545_1.playNext_(arg_547_0)
			if arg_547_0 == 1 then
				arg_545_0:Play323121134(arg_545_1)
			end
		end

		function arg_545_1.onSingleLineUpdate_(arg_548_0)
			local var_548_0 = arg_545_1.actors_["10170ui_story"]
			local var_548_1 = 0

			if var_548_1 < arg_545_1.time_ and arg_545_1.time_ <= var_548_1 + arg_548_0 and not isNil(var_548_0) and arg_545_1.var_.characterEffect10170ui_story == nil then
				arg_545_1.var_.characterEffect10170ui_story = var_548_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_548_2 = 0.200000002980232

			if var_548_1 <= arg_545_1.time_ and arg_545_1.time_ < var_548_1 + var_548_2 and not isNil(var_548_0) then
				local var_548_3 = (arg_545_1.time_ - var_548_1) / var_548_2

				if arg_545_1.var_.characterEffect10170ui_story and not isNil(var_548_0) then
					arg_545_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_545_1.time_ >= var_548_1 + var_548_2 and arg_545_1.time_ < var_548_1 + var_548_2 + arg_548_0 and not isNil(var_548_0) and arg_545_1.var_.characterEffect10170ui_story then
				arg_545_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_548_4 = 0
			local var_548_5 = 0.0329999998211861

			if var_548_4 < arg_545_1.time_ and arg_545_1.time_ <= var_548_4 + arg_548_0 then
				arg_545_1.talkMaxDuration = 0
				arg_545_1.dialogCg_.alpha = 1

				arg_545_1.dialog_:SetActive(true)
				SetActive(arg_545_1.leftNameGo_, true)

				local var_548_6 = arg_545_1:FormatText(StoryNameCfg[1450].name)

				arg_545_1.leftNameTxt_.text = var_548_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_545_1.leftNameTxt_.transform)

				arg_545_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_545_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_545_1:RecordName(arg_545_1.leftNameTxt_.text)
				SetActive(arg_545_1.iconTrs_.gameObject, true)
				arg_545_1.iconController_:SetSelectedState("hero")

				arg_545_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10170")

				arg_545_1.callingController_:SetSelectedState("normal")

				arg_545_1.keyicon_.color = Color.New(1, 1, 1)
				arg_545_1.icon_.color = Color.New(1, 1, 1)

				local var_548_7 = arg_545_1:GetWordFromCfg(323121133)
				local var_548_8 = arg_545_1:FormatText(var_548_7.content)

				arg_545_1.text_.text = var_548_8

				LuaForUtil.ClearLinePrefixSymbol(arg_545_1.text_)

				local var_548_9 = 1
				local var_548_10 = utf8.len(var_548_8)
				local var_548_11 = var_548_9 <= 0 and var_548_5 or var_548_5 * (var_548_10 / var_548_9)

				if var_548_11 > 0 and var_548_5 < var_548_11 then
					arg_545_1.talkMaxDuration = var_548_11

					if var_548_11 + var_548_4 > arg_545_1.duration_ then
						arg_545_1.duration_ = var_548_11 + var_548_4
					end
				end

				arg_545_1.text_.text = var_548_8
				arg_545_1.typewritter.percent = 0

				arg_545_1.typewritter:SetDirty()
				arg_545_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323121", "323121133", "story_v_out_323121.awb") ~= 0 then
					local var_548_12 = manager.audio:GetVoiceLength("story_v_out_323121", "323121133", "story_v_out_323121.awb") / 1000

					if var_548_12 + var_548_4 > arg_545_1.duration_ then
						arg_545_1.duration_ = var_548_12 + var_548_4
					end

					if var_548_7.prefab_name ~= "" and arg_545_1.actors_[var_548_7.prefab_name] ~= nil then
						local var_548_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_545_1.actors_[var_548_7.prefab_name].transform, "story_v_out_323121", "323121133", "story_v_out_323121.awb")

						arg_545_1:RecordAudio("323121133", var_548_13)
						arg_545_1:RecordAudio("323121133", var_548_13)
					else
						arg_545_1:AudioAction("play", "voice", "story_v_out_323121", "323121133", "story_v_out_323121.awb")
					end

					arg_545_1:RecordHistoryTalkVoice("story_v_out_323121", "323121133", "story_v_out_323121.awb")
				end

				arg_545_1:RecordContent(arg_545_1.text_.text)
			end

			local var_548_14 = math.max(var_548_5, arg_545_1.talkMaxDuration)

			if var_548_4 <= arg_545_1.time_ and arg_545_1.time_ < var_548_4 + var_548_14 then
				arg_545_1.typewritter.percent = (arg_545_1.time_ - var_548_4) / var_548_14

				arg_545_1.typewritter:SetDirty()
			end

			if arg_545_1.time_ >= var_548_4 + var_548_14 and arg_545_1.time_ < var_548_4 + var_548_14 + arg_548_0 then
				arg_545_1.typewritter.percent = 1

				arg_545_1.typewritter:SetDirty()
				arg_545_1:ShowNextGo(true)
			end
		end

		arg_545_1.nodeConfigList_ = {}

		arg_545_1:InitPlayNodeList()
	end,
	Play323121134 = function(arg_549_0, arg_549_1)
		arg_549_1.time_ = 0
		arg_549_1.frameCnt_ = 0
		arg_549_1.state_ = "playing"
		arg_549_1.curTalkId_ = 323121134
		arg_549_1.duration_ = 5

		SetActive(arg_549_1.tipsGo_, false)

		function arg_549_1.onSingleLineFinish_()
			arg_549_1.onSingleLineUpdate_ = nil
			arg_549_1.onSingleLineFinish_ = nil
			arg_549_1.state_ = "waiting"
		end

		function arg_549_1.playNext_(arg_551_0)
			if arg_551_0 == 1 then
				arg_549_0:Play323121135(arg_549_1)
			end
		end

		function arg_549_1.onSingleLineUpdate_(arg_552_0)
			local var_552_0 = arg_549_1.actors_["10170ui_story"]
			local var_552_1 = 0

			if var_552_1 < arg_549_1.time_ and arg_549_1.time_ <= var_552_1 + arg_552_0 and not isNil(var_552_0) and arg_549_1.var_.characterEffect10170ui_story == nil then
				arg_549_1.var_.characterEffect10170ui_story = var_552_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_552_2 = 0.200000002980232

			if var_552_1 <= arg_549_1.time_ and arg_549_1.time_ < var_552_1 + var_552_2 and not isNil(var_552_0) then
				local var_552_3 = (arg_549_1.time_ - var_552_1) / var_552_2

				if arg_549_1.var_.characterEffect10170ui_story and not isNil(var_552_0) then
					local var_552_4 = Mathf.Lerp(0, 0.5, var_552_3)

					arg_549_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_549_1.var_.characterEffect10170ui_story.fillRatio = var_552_4
				end
			end

			if arg_549_1.time_ >= var_552_1 + var_552_2 and arg_549_1.time_ < var_552_1 + var_552_2 + arg_552_0 and not isNil(var_552_0) and arg_549_1.var_.characterEffect10170ui_story then
				local var_552_5 = 0.5

				arg_549_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_549_1.var_.characterEffect10170ui_story.fillRatio = var_552_5
			end

			local var_552_6 = 0
			local var_552_7 = 0.0329999998211861

			if var_552_6 < arg_549_1.time_ and arg_549_1.time_ <= var_552_6 + arg_552_0 then
				arg_549_1.talkMaxDuration = 0
				arg_549_1.dialogCg_.alpha = 1

				arg_549_1.dialog_:SetActive(true)
				SetActive(arg_549_1.leftNameGo_, true)

				local var_552_8 = arg_549_1:FormatText(StoryNameCfg[7].name)

				arg_549_1.leftNameTxt_.text = var_552_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_549_1.leftNameTxt_.transform)

				arg_549_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_549_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_549_1:RecordName(arg_549_1.leftNameTxt_.text)
				SetActive(arg_549_1.iconTrs_.gameObject, true)
				arg_549_1.iconController_:SetSelectedState("hero")

				arg_549_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_549_1.callingController_:SetSelectedState("normal")

				arg_549_1.keyicon_.color = Color.New(1, 1, 1)
				arg_549_1.icon_.color = Color.New(1, 1, 1)

				local var_552_9 = arg_549_1:GetWordFromCfg(323121134)
				local var_552_10 = arg_549_1:FormatText(var_552_9.content)

				arg_549_1.text_.text = var_552_10

				LuaForUtil.ClearLinePrefixSymbol(arg_549_1.text_)

				local var_552_11 = 1
				local var_552_12 = utf8.len(var_552_10)
				local var_552_13 = var_552_11 <= 0 and var_552_7 or var_552_7 * (var_552_12 / var_552_11)

				if var_552_13 > 0 and var_552_7 < var_552_13 then
					arg_549_1.talkMaxDuration = var_552_13

					if var_552_13 + var_552_6 > arg_549_1.duration_ then
						arg_549_1.duration_ = var_552_13 + var_552_6
					end
				end

				arg_549_1.text_.text = var_552_10
				arg_549_1.typewritter.percent = 0

				arg_549_1.typewritter:SetDirty()
				arg_549_1:ShowNextGo(false)
				arg_549_1:RecordContent(arg_549_1.text_.text)
			end

			local var_552_14 = math.max(var_552_7, arg_549_1.talkMaxDuration)

			if var_552_6 <= arg_549_1.time_ and arg_549_1.time_ < var_552_6 + var_552_14 then
				arg_549_1.typewritter.percent = (arg_549_1.time_ - var_552_6) / var_552_14

				arg_549_1.typewritter:SetDirty()
			end

			if arg_549_1.time_ >= var_552_6 + var_552_14 and arg_549_1.time_ < var_552_6 + var_552_14 + arg_552_0 then
				arg_549_1.typewritter.percent = 1

				arg_549_1.typewritter:SetDirty()
				arg_549_1:ShowNextGo(true)
			end
		end

		arg_549_1.nodeConfigList_ = {}

		arg_549_1:InitPlayNodeList()
	end,
	Play323121135 = function(arg_553_0, arg_553_1)
		arg_553_1.time_ = 0
		arg_553_1.frameCnt_ = 0
		arg_553_1.state_ = "playing"
		arg_553_1.curTalkId_ = 323121135
		arg_553_1.duration_ = 5

		SetActive(arg_553_1.tipsGo_, false)

		function arg_553_1.onSingleLineFinish_()
			arg_553_1.onSingleLineUpdate_ = nil
			arg_553_1.onSingleLineFinish_ = nil
			arg_553_1.state_ = "waiting"
		end

		function arg_553_1.playNext_(arg_555_0)
			if arg_555_0 == 1 then
				arg_553_0:Play323121136(arg_553_1)
			end
		end

		function arg_553_1.onSingleLineUpdate_(arg_556_0)
			local var_556_0 = 0
			local var_556_1 = 0.95

			if var_556_0 < arg_553_1.time_ and arg_553_1.time_ <= var_556_0 + arg_556_0 then
				arg_553_1.talkMaxDuration = 0
				arg_553_1.dialogCg_.alpha = 1

				arg_553_1.dialog_:SetActive(true)
				SetActive(arg_553_1.leftNameGo_, false)

				arg_553_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_553_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_553_1:RecordName(arg_553_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_553_1.iconTrs_.gameObject, false)
				arg_553_1.callingController_:SetSelectedState("normal")

				local var_556_2 = arg_553_1:GetWordFromCfg(323121135)
				local var_556_3 = arg_553_1:FormatText(var_556_2.content)

				arg_553_1.text_.text = var_556_3

				LuaForUtil.ClearLinePrefixSymbol(arg_553_1.text_)

				local var_556_4 = 38
				local var_556_5 = utf8.len(var_556_3)
				local var_556_6 = var_556_4 <= 0 and var_556_1 or var_556_1 * (var_556_5 / var_556_4)

				if var_556_6 > 0 and var_556_1 < var_556_6 then
					arg_553_1.talkMaxDuration = var_556_6

					if var_556_6 + var_556_0 > arg_553_1.duration_ then
						arg_553_1.duration_ = var_556_6 + var_556_0
					end
				end

				arg_553_1.text_.text = var_556_3
				arg_553_1.typewritter.percent = 0

				arg_553_1.typewritter:SetDirty()
				arg_553_1:ShowNextGo(false)
				arg_553_1:RecordContent(arg_553_1.text_.text)
			end

			local var_556_7 = math.max(var_556_1, arg_553_1.talkMaxDuration)

			if var_556_0 <= arg_553_1.time_ and arg_553_1.time_ < var_556_0 + var_556_7 then
				arg_553_1.typewritter.percent = (arg_553_1.time_ - var_556_0) / var_556_7

				arg_553_1.typewritter:SetDirty()
			end

			if arg_553_1.time_ >= var_556_0 + var_556_7 and arg_553_1.time_ < var_556_0 + var_556_7 + arg_556_0 then
				arg_553_1.typewritter.percent = 1

				arg_553_1.typewritter:SetDirty()
				arg_553_1:ShowNextGo(true)
			end
		end

		arg_553_1.nodeConfigList_ = {}

		arg_553_1:InitPlayNodeList()
	end,
	Play323121136 = function(arg_557_0, arg_557_1)
		arg_557_1.time_ = 0
		arg_557_1.frameCnt_ = 0
		arg_557_1.state_ = "playing"
		arg_557_1.curTalkId_ = 323121136
		arg_557_1.duration_ = 2.7

		local var_557_0 = {
			zh = 1.999999999999,
			ja = 2.7
		}
		local var_557_1 = manager.audio:GetLocalizationFlag()

		if var_557_0[var_557_1] ~= nil then
			arg_557_1.duration_ = var_557_0[var_557_1]
		end

		SetActive(arg_557_1.tipsGo_, false)

		function arg_557_1.onSingleLineFinish_()
			arg_557_1.onSingleLineUpdate_ = nil
			arg_557_1.onSingleLineFinish_ = nil
			arg_557_1.state_ = "waiting"
		end

		function arg_557_1.playNext_(arg_559_0)
			if arg_559_0 == 1 then
				arg_557_0:Play323121137(arg_557_1)
			end
		end

		function arg_557_1.onSingleLineUpdate_(arg_560_0)
			local var_560_0 = arg_557_1.actors_["10170ui_story"].transform
			local var_560_1 = 0

			if var_560_1 < arg_557_1.time_ and arg_557_1.time_ <= var_560_1 + arg_560_0 then
				arg_557_1.var_.moveOldPos10170ui_story = var_560_0.localPosition

				local var_560_2 = GameObjectTools.GetOrAddComponent(var_560_0.gameObject, typeof(DynamicBoneHelper))

				if var_560_2 then
					var_560_2:EnableDynamicBone(false)
				end
			end

			local var_560_3 = 0.001

			if var_560_1 <= arg_557_1.time_ and arg_557_1.time_ < var_560_1 + var_560_3 then
				local var_560_4 = (arg_557_1.time_ - var_560_1) / var_560_3
				local var_560_5 = Vector3.New(0, -1.03, -6.05)

				var_560_0.localPosition = Vector3.Lerp(arg_557_1.var_.moveOldPos10170ui_story, var_560_5, var_560_4)

				local var_560_6 = manager.ui.mainCamera.transform.position - var_560_0.position

				var_560_0.forward = Vector3.New(var_560_6.x, var_560_6.y, var_560_6.z)

				local var_560_7 = var_560_0.localEulerAngles

				var_560_7.z = 0
				var_560_7.x = 0
				var_560_0.localEulerAngles = var_560_7
			end

			if arg_557_1.time_ >= var_560_1 + var_560_3 and arg_557_1.time_ < var_560_1 + var_560_3 + arg_560_0 then
				var_560_0.localPosition = Vector3.New(0, -1.03, -6.05)

				local var_560_8 = manager.ui.mainCamera.transform.position - var_560_0.position

				var_560_0.forward = Vector3.New(var_560_8.x, var_560_8.y, var_560_8.z)

				local var_560_9 = var_560_0.localEulerAngles

				var_560_9.z = 0
				var_560_9.x = 0
				var_560_0.localEulerAngles = var_560_9

				local var_560_10 = GameObjectTools.GetOrAddComponent(var_560_0.gameObject, typeof(DynamicBoneHelper))

				if var_560_10 then
					var_560_10:EnableDynamicBone(true)
				end
			end

			local var_560_11 = arg_557_1.actors_["10170ui_story"]
			local var_560_12 = 0

			if var_560_12 < arg_557_1.time_ and arg_557_1.time_ <= var_560_12 + arg_560_0 and not isNil(var_560_11) and arg_557_1.var_.characterEffect10170ui_story == nil then
				arg_557_1.var_.characterEffect10170ui_story = var_560_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_560_13 = 0.200000002980232

			if var_560_12 <= arg_557_1.time_ and arg_557_1.time_ < var_560_12 + var_560_13 and not isNil(var_560_11) then
				local var_560_14 = (arg_557_1.time_ - var_560_12) / var_560_13

				if arg_557_1.var_.characterEffect10170ui_story and not isNil(var_560_11) then
					arg_557_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_557_1.time_ >= var_560_12 + var_560_13 and arg_557_1.time_ < var_560_12 + var_560_13 + arg_560_0 and not isNil(var_560_11) and arg_557_1.var_.characterEffect10170ui_story then
				arg_557_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_560_15 = 0

			if var_560_15 < arg_557_1.time_ and arg_557_1.time_ <= var_560_15 + arg_560_0 then
				arg_557_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_560_16 = 0

			if var_560_16 < arg_557_1.time_ and arg_557_1.time_ <= var_560_16 + arg_560_0 then
				arg_557_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/story10170/story10170action/10170action1_1")
			end

			local var_560_17 = 0
			local var_560_18 = 0.15

			if var_560_17 < arg_557_1.time_ and arg_557_1.time_ <= var_560_17 + arg_560_0 then
				arg_557_1.talkMaxDuration = 0
				arg_557_1.dialogCg_.alpha = 1

				arg_557_1.dialog_:SetActive(true)
				SetActive(arg_557_1.leftNameGo_, true)

				local var_560_19 = arg_557_1:FormatText(StoryNameCfg[1450].name)

				arg_557_1.leftNameTxt_.text = var_560_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_557_1.leftNameTxt_.transform)

				arg_557_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_557_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_557_1:RecordName(arg_557_1.leftNameTxt_.text)
				SetActive(arg_557_1.iconTrs_.gameObject, false)
				arg_557_1.callingController_:SetSelectedState("normal")

				local var_560_20 = arg_557_1:GetWordFromCfg(323121136)
				local var_560_21 = arg_557_1:FormatText(var_560_20.content)

				arg_557_1.text_.text = var_560_21

				LuaForUtil.ClearLinePrefixSymbol(arg_557_1.text_)

				local var_560_22 = 6
				local var_560_23 = utf8.len(var_560_21)
				local var_560_24 = var_560_22 <= 0 and var_560_18 or var_560_18 * (var_560_23 / var_560_22)

				if var_560_24 > 0 and var_560_18 < var_560_24 then
					arg_557_1.talkMaxDuration = var_560_24

					if var_560_24 + var_560_17 > arg_557_1.duration_ then
						arg_557_1.duration_ = var_560_24 + var_560_17
					end
				end

				arg_557_1.text_.text = var_560_21
				arg_557_1.typewritter.percent = 0

				arg_557_1.typewritter:SetDirty()
				arg_557_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323121", "323121136", "story_v_out_323121.awb") ~= 0 then
					local var_560_25 = manager.audio:GetVoiceLength("story_v_out_323121", "323121136", "story_v_out_323121.awb") / 1000

					if var_560_25 + var_560_17 > arg_557_1.duration_ then
						arg_557_1.duration_ = var_560_25 + var_560_17
					end

					if var_560_20.prefab_name ~= "" and arg_557_1.actors_[var_560_20.prefab_name] ~= nil then
						local var_560_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_557_1.actors_[var_560_20.prefab_name].transform, "story_v_out_323121", "323121136", "story_v_out_323121.awb")

						arg_557_1:RecordAudio("323121136", var_560_26)
						arg_557_1:RecordAudio("323121136", var_560_26)
					else
						arg_557_1:AudioAction("play", "voice", "story_v_out_323121", "323121136", "story_v_out_323121.awb")
					end

					arg_557_1:RecordHistoryTalkVoice("story_v_out_323121", "323121136", "story_v_out_323121.awb")
				end

				arg_557_1:RecordContent(arg_557_1.text_.text)
			end

			local var_560_27 = math.max(var_560_18, arg_557_1.talkMaxDuration)

			if var_560_17 <= arg_557_1.time_ and arg_557_1.time_ < var_560_17 + var_560_27 then
				arg_557_1.typewritter.percent = (arg_557_1.time_ - var_560_17) / var_560_27

				arg_557_1.typewritter:SetDirty()
			end

			if arg_557_1.time_ >= var_560_17 + var_560_27 and arg_557_1.time_ < var_560_17 + var_560_27 + arg_560_0 then
				arg_557_1.typewritter.percent = 1

				arg_557_1.typewritter:SetDirty()
				arg_557_1:ShowNextGo(true)
			end
		end

		arg_557_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_557_1:InitPlayNodeList()
	end,
	Play323121137 = function(arg_561_0, arg_561_1)
		arg_561_1.time_ = 0
		arg_561_1.frameCnt_ = 0
		arg_561_1.state_ = "playing"
		arg_561_1.curTalkId_ = 323121137
		arg_561_1.duration_ = 5

		SetActive(arg_561_1.tipsGo_, false)

		function arg_561_1.onSingleLineFinish_()
			arg_561_1.onSingleLineUpdate_ = nil
			arg_561_1.onSingleLineFinish_ = nil
			arg_561_1.state_ = "waiting"
			arg_561_1.auto_ = false
		end

		function arg_561_1.playNext_(arg_563_0)
			arg_561_1.onStoryFinished_()
		end

		function arg_561_1.onSingleLineUpdate_(arg_564_0)
			local var_564_0 = arg_561_1.actors_["10170ui_story"].transform
			local var_564_1 = 0

			if var_564_1 < arg_561_1.time_ and arg_561_1.time_ <= var_564_1 + arg_564_0 then
				arg_561_1.var_.moveOldPos10170ui_story = var_564_0.localPosition

				local var_564_2 = GameObjectTools.GetOrAddComponent(var_564_0.gameObject, typeof(DynamicBoneHelper))

				if var_564_2 then
					var_564_2:EnableDynamicBone(false)
				end
			end

			local var_564_3 = 0.001

			if var_564_1 <= arg_561_1.time_ and arg_561_1.time_ < var_564_1 + var_564_3 then
				local var_564_4 = (arg_561_1.time_ - var_564_1) / var_564_3
				local var_564_5 = Vector3.New(0, 100, 0)

				var_564_0.localPosition = Vector3.Lerp(arg_561_1.var_.moveOldPos10170ui_story, var_564_5, var_564_4)

				local var_564_6 = manager.ui.mainCamera.transform.position - var_564_0.position

				var_564_0.forward = Vector3.New(var_564_6.x, var_564_6.y, var_564_6.z)

				local var_564_7 = var_564_0.localEulerAngles

				var_564_7.z = 0
				var_564_7.x = 0
				var_564_0.localEulerAngles = var_564_7
			end

			if arg_561_1.time_ >= var_564_1 + var_564_3 and arg_561_1.time_ < var_564_1 + var_564_3 + arg_564_0 then
				var_564_0.localPosition = Vector3.New(0, 100, 0)

				local var_564_8 = manager.ui.mainCamera.transform.position - var_564_0.position

				var_564_0.forward = Vector3.New(var_564_8.x, var_564_8.y, var_564_8.z)

				local var_564_9 = var_564_0.localEulerAngles

				var_564_9.z = 0
				var_564_9.x = 0
				var_564_0.localEulerAngles = var_564_9

				local var_564_10 = GameObjectTools.GetOrAddComponent(var_564_0.gameObject, typeof(DynamicBoneHelper))

				if var_564_10 then
					var_564_10:EnableDynamicBone(true)
				end
			end

			local var_564_11 = arg_561_1.actors_["10170ui_story"]
			local var_564_12 = 0

			if var_564_12 < arg_561_1.time_ and arg_561_1.time_ <= var_564_12 + arg_564_0 and not isNil(var_564_11) and arg_561_1.var_.characterEffect10170ui_story == nil then
				arg_561_1.var_.characterEffect10170ui_story = var_564_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_564_13 = 0.200000002980232

			if var_564_12 <= arg_561_1.time_ and arg_561_1.time_ < var_564_12 + var_564_13 and not isNil(var_564_11) then
				local var_564_14 = (arg_561_1.time_ - var_564_12) / var_564_13

				if arg_561_1.var_.characterEffect10170ui_story and not isNil(var_564_11) then
					local var_564_15 = Mathf.Lerp(0, 0.5, var_564_14)

					arg_561_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_561_1.var_.characterEffect10170ui_story.fillRatio = var_564_15
				end
			end

			if arg_561_1.time_ >= var_564_12 + var_564_13 and arg_561_1.time_ < var_564_12 + var_564_13 + arg_564_0 and not isNil(var_564_11) and arg_561_1.var_.characterEffect10170ui_story then
				local var_564_16 = 0.5

				arg_561_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_561_1.var_.characterEffect10170ui_story.fillRatio = var_564_16
			end

			local var_564_17 = 0
			local var_564_18 = 0.9

			if var_564_17 < arg_561_1.time_ and arg_561_1.time_ <= var_564_17 + arg_564_0 then
				arg_561_1.talkMaxDuration = 0
				arg_561_1.dialogCg_.alpha = 1

				arg_561_1.dialog_:SetActive(true)
				SetActive(arg_561_1.leftNameGo_, false)

				arg_561_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_561_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_561_1:RecordName(arg_561_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_561_1.iconTrs_.gameObject, false)
				arg_561_1.callingController_:SetSelectedState("normal")

				local var_564_19 = arg_561_1:GetWordFromCfg(323121137)
				local var_564_20 = arg_561_1:FormatText(var_564_19.content)

				arg_561_1.text_.text = var_564_20

				LuaForUtil.ClearLinePrefixSymbol(arg_561_1.text_)

				local var_564_21 = 36
				local var_564_22 = utf8.len(var_564_20)
				local var_564_23 = var_564_21 <= 0 and var_564_18 or var_564_18 * (var_564_22 / var_564_21)

				if var_564_23 > 0 and var_564_18 < var_564_23 then
					arg_561_1.talkMaxDuration = var_564_23

					if var_564_23 + var_564_17 > arg_561_1.duration_ then
						arg_561_1.duration_ = var_564_23 + var_564_17
					end
				end

				arg_561_1.text_.text = var_564_20
				arg_561_1.typewritter.percent = 0

				arg_561_1.typewritter:SetDirty()
				arg_561_1:ShowNextGo(false)
				arg_561_1:RecordContent(arg_561_1.text_.text)
			end

			local var_564_24 = math.max(var_564_18, arg_561_1.talkMaxDuration)

			if var_564_17 <= arg_561_1.time_ and arg_561_1.time_ < var_564_17 + var_564_24 then
				arg_561_1.typewritter.percent = (arg_561_1.time_ - var_564_17) / var_564_24

				arg_561_1.typewritter:SetDirty()
			end

			if arg_561_1.time_ >= var_564_17 + var_564_24 and arg_561_1.time_ < var_564_17 + var_564_24 + arg_564_0 then
				arg_561_1.typewritter.percent = 1

				arg_561_1.typewritter:SetDirty()
				arg_561_1:ShowNextGo(true)
			end
		end

		arg_561_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_561_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST2005",
		"TextureConfig/Background/ST12",
		"TextureConfig/Background/STblack"
	},
	voices = {
		"story_v_out_323121.awb"
	}
}
