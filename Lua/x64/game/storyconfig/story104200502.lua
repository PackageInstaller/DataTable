return {
	Play420052001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 420052001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play420052002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "L16I"

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
				local var_4_5 = arg_1_1.bgs_.L16I

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
					if iter_4_0 ~= "L16I" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = 2

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

			local var_4_30 = 0.333333333333333
			local var_4_31 = 1

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				local var_4_32 = "play"
				local var_4_33 = "music"

				arg_1_1:AudioAction(var_4_32, var_4_33, "bgm_activity_4_0_story_park_night", "bgm_activity_4_0_story_park_night", "bgm_activity_4_0_story_park_night.awb")

				local var_4_34 = ""
				local var_4_35 = manager.audio:GetAudioName("bgm_activity_4_0_story_park_night", "bgm_activity_4_0_story_park_night")

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

			local var_4_36 = 2
			local var_4_37 = 0.65

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

				local var_4_39 = arg_1_1:FormatText(StoryNameCfg[7].name)

				arg_1_1.leftNameTxt_.text = var_4_39

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_40 = arg_1_1:GetWordFromCfg(420052001)
				local var_4_41 = arg_1_1:FormatText(var_4_40.content)

				arg_1_1.text_.text = var_4_41

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_42 = 26
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
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_45 = var_4_36 + 0.3
			local var_4_46 = math.max(var_4_37, arg_1_1.talkMaxDuration)

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
	Play420052002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 420052002
		arg_9_1.duration_ = 10.47

		local var_9_0 = {
			zh = 10.033,
			ja = 10.466
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
				arg_9_0:Play420052003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = "404001_tpose"

			if arg_9_1.actors_[var_12_0] == nil then
				local var_12_1 = Asset.Load("Char/" .. "404001_tpose")

				if not isNil(var_12_1) then
					local var_12_2 = Object.Instantiate(Asset.Load("Char/" .. "404001_tpose"), arg_9_1.stage_.transform)

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

			local var_12_5 = arg_9_1.actors_["404001_tpose"]
			local var_12_6 = 0

			if var_12_6 < arg_9_1.time_ and arg_9_1.time_ <= var_12_6 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.characterEffect404001_tpose == nil then
				arg_9_1.var_.characterEffect404001_tpose = var_12_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_7 = 0.200000002980232

			if var_12_6 <= arg_9_1.time_ and arg_9_1.time_ < var_12_6 + var_12_7 and not isNil(var_12_5) then
				local var_12_8 = (arg_9_1.time_ - var_12_6) / var_12_7

				if arg_9_1.var_.characterEffect404001_tpose and not isNil(var_12_5) then
					arg_9_1.var_.characterEffect404001_tpose.fillFlat = false
				end
			end

			if arg_9_1.time_ >= var_12_6 + var_12_7 and arg_9_1.time_ < var_12_6 + var_12_7 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.characterEffect404001_tpose then
				arg_9_1.var_.characterEffect404001_tpose.fillFlat = false
			end

			local var_12_9 = 0
			local var_12_10 = 1.1

			if var_12_9 < arg_9_1.time_ and arg_9_1.time_ <= var_12_9 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_11 = arg_9_1:FormatText(StoryNameCfg[668].name)

				arg_9_1.leftNameTxt_.text = var_12_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, true)
				arg_9_1.iconController_:SetSelectedState("hero")

				arg_9_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4040")

				arg_9_1.callingController_:SetSelectedState("normal")

				arg_9_1.keyicon_.color = Color.New(1, 1, 1)
				arg_9_1.icon_.color = Color.New(1, 1, 1)

				local var_12_12 = arg_9_1:GetWordFromCfg(420052002)
				local var_12_13 = arg_9_1:FormatText(var_12_12.content)

				arg_9_1.text_.text = var_12_13

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_14 = 44
				local var_12_15 = utf8.len(var_12_13)
				local var_12_16 = var_12_14 <= 0 and var_12_10 or var_12_10 * (var_12_15 / var_12_14)

				if var_12_16 > 0 and var_12_10 < var_12_16 then
					arg_9_1.talkMaxDuration = var_12_16

					if var_12_16 + var_12_9 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_16 + var_12_9
					end
				end

				arg_9_1.text_.text = var_12_13
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420052", "420052002", "story_v_out_420052.awb") ~= 0 then
					local var_12_17 = manager.audio:GetVoiceLength("story_v_out_420052", "420052002", "story_v_out_420052.awb") / 1000

					if var_12_17 + var_12_9 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_17 + var_12_9
					end

					if var_12_12.prefab_name ~= "" and arg_9_1.actors_[var_12_12.prefab_name] ~= nil then
						local var_12_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_12.prefab_name].transform, "story_v_out_420052", "420052002", "story_v_out_420052.awb")

						arg_9_1:RecordAudio("420052002", var_12_18)
						arg_9_1:RecordAudio("420052002", var_12_18)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_420052", "420052002", "story_v_out_420052.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_420052", "420052002", "story_v_out_420052.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_19 = math.max(var_12_10, arg_9_1.talkMaxDuration)

			if var_12_9 <= arg_9_1.time_ and arg_9_1.time_ < var_12_9 + var_12_19 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_9) / var_12_19

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_9 + var_12_19 and arg_9_1.time_ < var_12_9 + var_12_19 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play420052003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 420052003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play420052004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0
			local var_16_1 = 0.825

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

				local var_16_2 = arg_13_1:GetWordFromCfg(420052003)
				local var_16_3 = arg_13_1:FormatText(var_16_2.content)

				arg_13_1.text_.text = var_16_3

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_4 = 33
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
	Play420052004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 420052004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play420052005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0

			if var_20_0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_0 + arg_20_0 then
				arg_17_1.allBtn_.enabled = false
			end

			local var_20_1 = 0.266666666666667

			if arg_17_1.time_ >= var_20_0 + var_20_1 and arg_17_1.time_ < var_20_0 + var_20_1 + arg_20_0 then
				arg_17_1.allBtn_.enabled = true
			end

			local var_20_2 = 0
			local var_20_3 = 0.125

			if var_20_2 < arg_17_1.time_ and arg_17_1.time_ <= var_20_2 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_4 = arg_17_1:FormatText(StoryNameCfg[7].name)

				arg_17_1.leftNameTxt_.text = var_20_4

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

				local var_20_5 = arg_17_1:GetWordFromCfg(420052004)
				local var_20_6 = arg_17_1:FormatText(var_20_5.content)

				arg_17_1.text_.text = var_20_6

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_7 = 5
				local var_20_8 = utf8.len(var_20_6)
				local var_20_9 = var_20_7 <= 0 and var_20_3 or var_20_3 * (var_20_8 / var_20_7)

				if var_20_9 > 0 and var_20_3 < var_20_9 then
					arg_17_1.talkMaxDuration = var_20_9

					if var_20_9 + var_20_2 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_9 + var_20_2
					end
				end

				arg_17_1.text_.text = var_20_6
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_10 = math.max(var_20_3, arg_17_1.talkMaxDuration)

			if var_20_2 <= arg_17_1.time_ and arg_17_1.time_ < var_20_2 + var_20_10 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_2) / var_20_10

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_2 + var_20_10 and arg_17_1.time_ < var_20_2 + var_20_10 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play420052005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 420052005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play420052006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0
			local var_24_1 = 1

			if var_24_0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_0 + arg_24_0 then
				local var_24_2 = "play"
				local var_24_3 = "effect"

				arg_21_1:AudioAction(var_24_2, var_24_3, "se_story_140", "se_story_140_camera01", "")
			end

			local var_24_4 = 0.70895176899309

			if var_24_4 < arg_21_1.time_ and arg_21_1.time_ <= var_24_4 + arg_24_0 then
				arg_21_1.mask_.enabled = true
				arg_21_1.mask_.raycastTarget = true

				arg_21_1:SetGaussion(false)
			end

			local var_24_5 = 0.19104823100691

			if var_24_4 <= arg_21_1.time_ and arg_21_1.time_ < var_24_4 + var_24_5 then
				local var_24_6 = (arg_21_1.time_ - var_24_4) / var_24_5
				local var_24_7 = Color.New(1, 1, 1)

				var_24_7.a = Mathf.Lerp(1, 0, var_24_6)
				arg_21_1.mask_.color = var_24_7
			end

			if arg_21_1.time_ >= var_24_4 + var_24_5 and arg_21_1.time_ < var_24_4 + var_24_5 + arg_24_0 then
				local var_24_8 = Color.New(1, 1, 1)
				local var_24_9 = 0

				arg_21_1.mask_.enabled = false
				var_24_8.a = var_24_9
				arg_21_1.mask_.color = var_24_8
			end

			local var_24_10 = 0
			local var_24_11 = 0.9

			if var_24_10 < arg_21_1.time_ and arg_21_1.time_ <= var_24_10 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, false)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_12 = arg_21_1:GetWordFromCfg(420052005)
				local var_24_13 = arg_21_1:FormatText(var_24_12.content)

				arg_21_1.text_.text = var_24_13

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_14 = 36
				local var_24_15 = utf8.len(var_24_13)
				local var_24_16 = var_24_14 <= 0 and var_24_11 or var_24_11 * (var_24_15 / var_24_14)

				if var_24_16 > 0 and var_24_11 < var_24_16 then
					arg_21_1.talkMaxDuration = var_24_16

					if var_24_16 + var_24_10 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_16 + var_24_10
					end
				end

				arg_21_1.text_.text = var_24_13
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_17 = math.max(var_24_11, arg_21_1.talkMaxDuration)

			if var_24_10 <= arg_21_1.time_ and arg_21_1.time_ < var_24_10 + var_24_17 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_10) / var_24_17

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_10 + var_24_17 and arg_21_1.time_ < var_24_10 + var_24_17 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play420052006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 420052006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play420052007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0
			local var_28_1 = 0.85

			if var_28_0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_0 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, false)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_2 = arg_25_1:GetWordFromCfg(420052006)
				local var_28_3 = arg_25_1:FormatText(var_28_2.content)

				arg_25_1.text_.text = var_28_3

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_4 = 34
				local var_28_5 = utf8.len(var_28_3)
				local var_28_6 = var_28_4 <= 0 and var_28_1 or var_28_1 * (var_28_5 / var_28_4)

				if var_28_6 > 0 and var_28_1 < var_28_6 then
					arg_25_1.talkMaxDuration = var_28_6

					if var_28_6 + var_28_0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_6 + var_28_0
					end
				end

				arg_25_1.text_.text = var_28_3
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_7 = math.max(var_28_1, arg_25_1.talkMaxDuration)

			if var_28_0 <= arg_25_1.time_ and arg_25_1.time_ < var_28_0 + var_28_7 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_0) / var_28_7

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_0 + var_28_7 and arg_25_1.time_ < var_28_0 + var_28_7 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play420052007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 420052007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play420052008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 0
			local var_32_1 = 0.525

			if var_32_0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_2 = arg_29_1:FormatText(StoryNameCfg[7].name)

				arg_29_1.leftNameTxt_.text = var_32_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, true)
				arg_29_1.iconController_:SetSelectedState("hero")

				arg_29_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_29_1.callingController_:SetSelectedState("normal")

				arg_29_1.keyicon_.color = Color.New(1, 1, 1)
				arg_29_1.icon_.color = Color.New(1, 1, 1)

				local var_32_3 = arg_29_1:GetWordFromCfg(420052007)
				local var_32_4 = arg_29_1:FormatText(var_32_3.content)

				arg_29_1.text_.text = var_32_4

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_5 = 21
				local var_32_6 = utf8.len(var_32_4)
				local var_32_7 = var_32_5 <= 0 and var_32_1 or var_32_1 * (var_32_6 / var_32_5)

				if var_32_7 > 0 and var_32_1 < var_32_7 then
					arg_29_1.talkMaxDuration = var_32_7

					if var_32_7 + var_32_0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_7 + var_32_0
					end
				end

				arg_29_1.text_.text = var_32_4
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_8 = math.max(var_32_1, arg_29_1.talkMaxDuration)

			if var_32_0 <= arg_29_1.time_ and arg_29_1.time_ < var_32_0 + var_32_8 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_0) / var_32_8

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_0 + var_32_8 and arg_29_1.time_ < var_32_0 + var_32_8 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play420052008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 420052008
		arg_33_1.duration_ = 2.17

		local var_33_0 = {
			zh = 1.999999999999,
			ja = 2.166
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
				arg_33_0:Play420052009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = "1085ui_story"

			if arg_33_1.actors_[var_36_0] == nil then
				local var_36_1 = Asset.Load("Char/" .. "1085ui_story")

				if not isNil(var_36_1) then
					local var_36_2 = Object.Instantiate(Asset.Load("Char/" .. "1085ui_story"), arg_33_1.stage_.transform)

					var_36_2.name = var_36_0
					var_36_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_33_1.actors_[var_36_0] = var_36_2

					local var_36_3 = var_36_2:GetComponentInChildren(typeof(CharacterEffect))

					var_36_3.enabled = true

					local var_36_4 = GameObjectTools.GetOrAddComponent(var_36_2, typeof(DynamicBoneHelper))

					if var_36_4 then
						var_36_4:EnableDynamicBone(false)
					end

					arg_33_1:ShowWeapon(var_36_3.transform, false)

					arg_33_1.var_[var_36_0 .. "Animator"] = var_36_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_33_1.var_[var_36_0 .. "Animator"].applyRootMotion = true
					arg_33_1.var_[var_36_0 .. "LipSync"] = var_36_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_36_5 = arg_33_1.actors_["1085ui_story"].transform
			local var_36_6 = 0

			if var_36_6 < arg_33_1.time_ and arg_33_1.time_ <= var_36_6 + arg_36_0 then
				arg_33_1.var_.moveOldPos1085ui_story = var_36_5.localPosition
			end

			local var_36_7 = 0.001

			if var_36_6 <= arg_33_1.time_ and arg_33_1.time_ < var_36_6 + var_36_7 then
				local var_36_8 = (arg_33_1.time_ - var_36_6) / var_36_7
				local var_36_9 = Vector3.New(0, -1.01, -5.83)

				var_36_5.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos1085ui_story, var_36_9, var_36_8)

				local var_36_10 = manager.ui.mainCamera.transform.position - var_36_5.position

				var_36_5.forward = Vector3.New(var_36_10.x, var_36_10.y, var_36_10.z)

				local var_36_11 = var_36_5.localEulerAngles

				var_36_11.z = 0
				var_36_11.x = 0
				var_36_5.localEulerAngles = var_36_11
			end

			if arg_33_1.time_ >= var_36_6 + var_36_7 and arg_33_1.time_ < var_36_6 + var_36_7 + arg_36_0 then
				var_36_5.localPosition = Vector3.New(0, -1.01, -5.83)

				local var_36_12 = manager.ui.mainCamera.transform.position - var_36_5.position

				var_36_5.forward = Vector3.New(var_36_12.x, var_36_12.y, var_36_12.z)

				local var_36_13 = var_36_5.localEulerAngles

				var_36_13.z = 0
				var_36_13.x = 0
				var_36_5.localEulerAngles = var_36_13
			end

			local var_36_14 = arg_33_1.actors_["1085ui_story"]
			local var_36_15 = 0

			if var_36_15 < arg_33_1.time_ and arg_33_1.time_ <= var_36_15 + arg_36_0 and not isNil(var_36_14) and arg_33_1.var_.characterEffect1085ui_story == nil then
				arg_33_1.var_.characterEffect1085ui_story = var_36_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_16 = 0.200000002980232

			if var_36_15 <= arg_33_1.time_ and arg_33_1.time_ < var_36_15 + var_36_16 and not isNil(var_36_14) then
				local var_36_17 = (arg_33_1.time_ - var_36_15) / var_36_16

				if arg_33_1.var_.characterEffect1085ui_story and not isNil(var_36_14) then
					arg_33_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= var_36_15 + var_36_16 and arg_33_1.time_ < var_36_15 + var_36_16 + arg_36_0 and not isNil(var_36_14) and arg_33_1.var_.characterEffect1085ui_story then
				arg_33_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_36_18 = 0

			if var_36_18 < arg_33_1.time_ and arg_33_1.time_ <= var_36_18 + arg_36_0 then
				arg_33_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action2_1")
			end

			local var_36_19 = 0

			if var_36_19 < arg_33_1.time_ and arg_33_1.time_ <= var_36_19 + arg_36_0 then
				arg_33_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_36_20 = 0

			if var_36_20 < arg_33_1.time_ and arg_33_1.time_ <= var_36_20 + arg_36_0 then
				arg_33_1.allBtn_.enabled = false
			end

			local var_36_21 = 1

			if arg_33_1.time_ >= var_36_20 + var_36_21 and arg_33_1.time_ < var_36_20 + var_36_21 + arg_36_0 then
				arg_33_1.allBtn_.enabled = true
			end

			local var_36_22 = 0
			local var_36_23 = 0.075

			if var_36_22 < arg_33_1.time_ and arg_33_1.time_ <= var_36_22 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_24 = arg_33_1:FormatText(StoryNameCfg[328].name)

				arg_33_1.leftNameTxt_.text = var_36_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_25 = arg_33_1:GetWordFromCfg(420052008)
				local var_36_26 = arg_33_1:FormatText(var_36_25.content)

				arg_33_1.text_.text = var_36_26

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_27 = 3
				local var_36_28 = utf8.len(var_36_26)
				local var_36_29 = var_36_27 <= 0 and var_36_23 or var_36_23 * (var_36_28 / var_36_27)

				if var_36_29 > 0 and var_36_23 < var_36_29 then
					arg_33_1.talkMaxDuration = var_36_29

					if var_36_29 + var_36_22 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_29 + var_36_22
					end
				end

				arg_33_1.text_.text = var_36_26
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420052", "420052008", "story_v_out_420052.awb") ~= 0 then
					local var_36_30 = manager.audio:GetVoiceLength("story_v_out_420052", "420052008", "story_v_out_420052.awb") / 1000

					if var_36_30 + var_36_22 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_30 + var_36_22
					end

					if var_36_25.prefab_name ~= "" and arg_33_1.actors_[var_36_25.prefab_name] ~= nil then
						local var_36_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_25.prefab_name].transform, "story_v_out_420052", "420052008", "story_v_out_420052.awb")

						arg_33_1:RecordAudio("420052008", var_36_31)
						arg_33_1:RecordAudio("420052008", var_36_31)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_420052", "420052008", "story_v_out_420052.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_420052", "420052008", "story_v_out_420052.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_32 = math.max(var_36_23, arg_33_1.talkMaxDuration)

			if var_36_22 <= arg_33_1.time_ and arg_33_1.time_ < var_36_22 + var_36_32 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_22) / var_36_32

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_22 + var_36_32 and arg_33_1.time_ < var_36_22 + var_36_32 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_33_1:InitPlayNodeList()
	end,
	Play420052009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 420052009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play420052010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = arg_37_1.actors_["1085ui_story"].transform
			local var_40_1 = 0

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 then
				arg_37_1.var_.moveOldPos1085ui_story = var_40_0.localPosition
			end

			local var_40_2 = 0.001

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_2 then
				local var_40_3 = (arg_37_1.time_ - var_40_1) / var_40_2
				local var_40_4 = Vector3.New(0, 100, 0)

				var_40_0.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos1085ui_story, var_40_4, var_40_3)

				local var_40_5 = manager.ui.mainCamera.transform.position - var_40_0.position

				var_40_0.forward = Vector3.New(var_40_5.x, var_40_5.y, var_40_5.z)

				local var_40_6 = var_40_0.localEulerAngles

				var_40_6.z = 0
				var_40_6.x = 0
				var_40_0.localEulerAngles = var_40_6
			end

			if arg_37_1.time_ >= var_40_1 + var_40_2 and arg_37_1.time_ < var_40_1 + var_40_2 + arg_40_0 then
				var_40_0.localPosition = Vector3.New(0, 100, 0)

				local var_40_7 = manager.ui.mainCamera.transform.position - var_40_0.position

				var_40_0.forward = Vector3.New(var_40_7.x, var_40_7.y, var_40_7.z)

				local var_40_8 = var_40_0.localEulerAngles

				var_40_8.z = 0
				var_40_8.x = 0
				var_40_0.localEulerAngles = var_40_8
			end

			local var_40_9 = 0
			local var_40_10 = 1.025

			if var_40_9 < arg_37_1.time_ and arg_37_1.time_ <= var_40_9 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, false)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_11 = arg_37_1:GetWordFromCfg(420052009)
				local var_40_12 = arg_37_1:FormatText(var_40_11.content)

				arg_37_1.text_.text = var_40_12

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_13 = 41
				local var_40_14 = utf8.len(var_40_12)
				local var_40_15 = var_40_13 <= 0 and var_40_10 or var_40_10 * (var_40_14 / var_40_13)

				if var_40_15 > 0 and var_40_10 < var_40_15 then
					arg_37_1.talkMaxDuration = var_40_15

					if var_40_15 + var_40_9 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_15 + var_40_9
					end
				end

				arg_37_1.text_.text = var_40_12
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_16 = math.max(var_40_10, arg_37_1.talkMaxDuration)

			if var_40_9 <= arg_37_1.time_ and arg_37_1.time_ < var_40_9 + var_40_16 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_9) / var_40_16

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_9 + var_40_16 and arg_37_1.time_ < var_40_9 + var_40_16 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_37_1:InitPlayNodeList()
	end,
	Play420052010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 420052010
		arg_41_1.duration_ = 4.57

		local var_41_0 = {
			zh = 4.566,
			ja = 4.033
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
				arg_41_0:Play420052011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = arg_41_1.actors_["1085ui_story"]
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect1085ui_story == nil then
				arg_41_1.var_.characterEffect1085ui_story = var_44_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_2 = 0.200000002980232

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_2 and not isNil(var_44_0) then
				local var_44_3 = (arg_41_1.time_ - var_44_1) / var_44_2

				if arg_41_1.var_.characterEffect1085ui_story and not isNil(var_44_0) then
					arg_41_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= var_44_1 + var_44_2 and arg_41_1.time_ < var_44_1 + var_44_2 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect1085ui_story then
				arg_41_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_44_4 = arg_41_1.actors_["1085ui_story"].transform
			local var_44_5 = 0

			if var_44_5 < arg_41_1.time_ and arg_41_1.time_ <= var_44_5 + arg_44_0 then
				arg_41_1.var_.moveOldPos1085ui_story = var_44_4.localPosition
			end

			local var_44_6 = 0.001

			if var_44_5 <= arg_41_1.time_ and arg_41_1.time_ < var_44_5 + var_44_6 then
				local var_44_7 = (arg_41_1.time_ - var_44_5) / var_44_6
				local var_44_8 = Vector3.New(0, -1.01, -5.83)

				var_44_4.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos1085ui_story, var_44_8, var_44_7)

				local var_44_9 = manager.ui.mainCamera.transform.position - var_44_4.position

				var_44_4.forward = Vector3.New(var_44_9.x, var_44_9.y, var_44_9.z)

				local var_44_10 = var_44_4.localEulerAngles

				var_44_10.z = 0
				var_44_10.x = 0
				var_44_4.localEulerAngles = var_44_10
			end

			if arg_41_1.time_ >= var_44_5 + var_44_6 and arg_41_1.time_ < var_44_5 + var_44_6 + arg_44_0 then
				var_44_4.localPosition = Vector3.New(0, -1.01, -5.83)

				local var_44_11 = manager.ui.mainCamera.transform.position - var_44_4.position

				var_44_4.forward = Vector3.New(var_44_11.x, var_44_11.y, var_44_11.z)

				local var_44_12 = var_44_4.localEulerAngles

				var_44_12.z = 0
				var_44_12.x = 0
				var_44_4.localEulerAngles = var_44_12
			end

			local var_44_13 = 0

			if var_44_13 < arg_41_1.time_ and arg_41_1.time_ <= var_44_13 + arg_44_0 then
				arg_41_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085actionlink/1085action425")
			end

			local var_44_14 = 0

			if var_44_14 < arg_41_1.time_ and arg_41_1.time_ <= var_44_14 + arg_44_0 then
				arg_41_1.allBtn_.enabled = false
			end

			local var_44_15 = 0.833333333333333

			if arg_41_1.time_ >= var_44_14 + var_44_15 and arg_41_1.time_ < var_44_14 + var_44_15 + arg_44_0 then
				arg_41_1.allBtn_.enabled = true
			end

			local var_44_16 = 0
			local var_44_17 = 0.275

			if var_44_16 < arg_41_1.time_ and arg_41_1.time_ <= var_44_16 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_18 = arg_41_1:FormatText(StoryNameCfg[328].name)

				arg_41_1.leftNameTxt_.text = var_44_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_19 = arg_41_1:GetWordFromCfg(420052010)
				local var_44_20 = arg_41_1:FormatText(var_44_19.content)

				arg_41_1.text_.text = var_44_20

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_21 = 11
				local var_44_22 = utf8.len(var_44_20)
				local var_44_23 = var_44_21 <= 0 and var_44_17 or var_44_17 * (var_44_22 / var_44_21)

				if var_44_23 > 0 and var_44_17 < var_44_23 then
					arg_41_1.talkMaxDuration = var_44_23

					if var_44_23 + var_44_16 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_23 + var_44_16
					end
				end

				arg_41_1.text_.text = var_44_20
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420052", "420052010", "story_v_out_420052.awb") ~= 0 then
					local var_44_24 = manager.audio:GetVoiceLength("story_v_out_420052", "420052010", "story_v_out_420052.awb") / 1000

					if var_44_24 + var_44_16 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_24 + var_44_16
					end

					if var_44_19.prefab_name ~= "" and arg_41_1.actors_[var_44_19.prefab_name] ~= nil then
						local var_44_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_19.prefab_name].transform, "story_v_out_420052", "420052010", "story_v_out_420052.awb")

						arg_41_1:RecordAudio("420052010", var_44_25)
						arg_41_1:RecordAudio("420052010", var_44_25)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_420052", "420052010", "story_v_out_420052.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_420052", "420052010", "story_v_out_420052.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_26 = math.max(var_44_17, arg_41_1.talkMaxDuration)

			if var_44_16 <= arg_41_1.time_ and arg_41_1.time_ < var_44_16 + var_44_26 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_16) / var_44_26

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_16 + var_44_26 and arg_41_1.time_ < var_44_16 + var_44_26 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_41_1:InitPlayNodeList()
	end,
	Play420052011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 420052011
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play420052012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = arg_45_1.actors_["1085ui_story"].transform
			local var_48_1 = 0

			if var_48_1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 then
				arg_45_1.var_.moveOldPos1085ui_story = var_48_0.localPosition
			end

			local var_48_2 = 0.001

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_2 then
				local var_48_3 = (arg_45_1.time_ - var_48_1) / var_48_2
				local var_48_4 = Vector3.New(0, 100, 0)

				var_48_0.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos1085ui_story, var_48_4, var_48_3)

				local var_48_5 = manager.ui.mainCamera.transform.position - var_48_0.position

				var_48_0.forward = Vector3.New(var_48_5.x, var_48_5.y, var_48_5.z)

				local var_48_6 = var_48_0.localEulerAngles

				var_48_6.z = 0
				var_48_6.x = 0
				var_48_0.localEulerAngles = var_48_6
			end

			if arg_45_1.time_ >= var_48_1 + var_48_2 and arg_45_1.time_ < var_48_1 + var_48_2 + arg_48_0 then
				var_48_0.localPosition = Vector3.New(0, 100, 0)

				local var_48_7 = manager.ui.mainCamera.transform.position - var_48_0.position

				var_48_0.forward = Vector3.New(var_48_7.x, var_48_7.y, var_48_7.z)

				local var_48_8 = var_48_0.localEulerAngles

				var_48_8.z = 0
				var_48_8.x = 0
				var_48_0.localEulerAngles = var_48_8
			end

			local var_48_9 = 0
			local var_48_10 = 0.55

			if var_48_9 < arg_45_1.time_ and arg_45_1.time_ <= var_48_9 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_11 = arg_45_1:FormatText(StoryNameCfg[7].name)

				arg_45_1.leftNameTxt_.text = var_48_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, true)
				arg_45_1.iconController_:SetSelectedState("hero")

				arg_45_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_45_1.callingController_:SetSelectedState("normal")

				arg_45_1.keyicon_.color = Color.New(1, 1, 1)
				arg_45_1.icon_.color = Color.New(1, 1, 1)

				local var_48_12 = arg_45_1:GetWordFromCfg(420052011)
				local var_48_13 = arg_45_1:FormatText(var_48_12.content)

				arg_45_1.text_.text = var_48_13

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_14 = 22
				local var_48_15 = utf8.len(var_48_13)
				local var_48_16 = var_48_14 <= 0 and var_48_10 or var_48_10 * (var_48_15 / var_48_14)

				if var_48_16 > 0 and var_48_10 < var_48_16 then
					arg_45_1.talkMaxDuration = var_48_16

					if var_48_16 + var_48_9 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_16 + var_48_9
					end
				end

				arg_45_1.text_.text = var_48_13
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)
				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_17 = math.max(var_48_10, arg_45_1.talkMaxDuration)

			if var_48_9 <= arg_45_1.time_ and arg_45_1.time_ < var_48_9 + var_48_17 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_9) / var_48_17

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_9 + var_48_17 and arg_45_1.time_ < var_48_9 + var_48_17 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_45_1:InitPlayNodeList()
	end,
	Play420052012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 420052012
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"

			SetActive(arg_49_1.choicesGo_, true)

			for iter_50_0, iter_50_1 in ipairs(arg_49_1.choices_) do
				local var_50_0 = iter_50_0 <= 1

				SetActive(iter_50_1.go, var_50_0)
			end

			arg_49_1.choices_[1].txt.text = arg_49_1:FormatText(StoryChoiceCfg[1230].name)
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play420052034(arg_49_1)
			end

			arg_49_1:RecordChoiceLog(420052012, 1230)
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			return
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play420052034 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 420052034
		arg_53_1.duration_ = 1.7

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play420052013(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 0
			local var_56_1 = 1

			if var_56_0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_0 + arg_56_0 then
				local var_56_2 = "play"
				local var_56_3 = "effect"

				arg_53_1:AudioAction(var_56_2, var_56_3, "se_story_140", "se_story_140_camera02", "")
			end

			local var_56_4 = "01"

			if not arg_53_1.actionList["01"] then
				arg_53_1.actionList["01"] = StoryShakePictureGame.New(arg_53_1)

				arg_53_1.actionList["01"]:SetData({
					moveHorizontalDistancePerShake = 300,
					path = "TextureConfig/Background/side_story_skuld_photo4",
					shakeTimes = 6
				})
			end

			local var_56_5 = 0

			if var_56_5 < arg_53_1.time_ and arg_53_1.time_ <= var_56_5 + arg_56_0 then
				arg_53_1.allBtn_.enabled = false
			end

			local var_56_6 = 1.66666666666667

			if arg_53_1.time_ >= var_56_5 + var_56_6 and arg_53_1.time_ < var_56_5 + var_56_6 + arg_56_0 then
				arg_53_1.allBtn_.enabled = true
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play420052013 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 420052013
		arg_57_1.duration_ = 5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play420052014(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = 0
			local var_60_1 = 0.7

			if var_60_0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_0 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0

				arg_57_1.dialog_:SetActive(true)

				arg_57_1.dialogCg_.alpha = 0

				local var_60_2 = LeanTween.value(arg_57_1.dialog_, 0, 1, 0.3)

				var_60_2:setOnUpdate(LuaHelper.FloatAction(function(arg_61_0)
					arg_57_1.dialogCg_.alpha = arg_61_0
				end))
				var_60_2:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_57_1.dialog_)
					var_60_2:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_57_1.duration_ = arg_57_1.duration_ + 0.3

				SetActive(arg_57_1.leftNameGo_, false)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_3 = arg_57_1:GetWordFromCfg(420052013)
				local var_60_4 = arg_57_1:FormatText(var_60_3.content)

				arg_57_1.text_.text = var_60_4

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_5 = 28
				local var_60_6 = utf8.len(var_60_4)
				local var_60_7 = var_60_5 <= 0 and var_60_1 or var_60_1 * (var_60_6 / var_60_5)

				if var_60_7 > 0 and var_60_1 < var_60_7 then
					arg_57_1.talkMaxDuration = var_60_7
					var_60_0 = var_60_0 + 0.3

					if var_60_7 + var_60_0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_7 + var_60_0
					end
				end

				arg_57_1.text_.text = var_60_4
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)
				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_8 = var_60_0 + 0.3
			local var_60_9 = math.max(var_60_1, arg_57_1.talkMaxDuration)

			if var_60_8 <= arg_57_1.time_ and arg_57_1.time_ < var_60_8 + var_60_9 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_8) / var_60_9

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_8 + var_60_9 and arg_57_1.time_ < var_60_8 + var_60_9 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play420052014 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 420052014
		arg_63_1.duration_ = 2.87

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play420052015(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = "STwhite"

			if arg_63_1.bgs_[var_66_0] == nil then
				local var_66_1 = Object.Instantiate(arg_63_1.paintGo_)

				var_66_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_66_0)
				var_66_1.name = var_66_0
				var_66_1.transform.parent = arg_63_1.stage_.transform
				var_66_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_63_1.bgs_[var_66_0] = var_66_1
			end

			local var_66_2 = 0

			if var_66_2 < arg_63_1.time_ and arg_63_1.time_ <= var_66_2 + arg_66_0 then
				local var_66_3 = manager.ui.mainCamera.transform.localPosition
				local var_66_4 = Vector3.New(0, 0, 10) + Vector3.New(var_66_3.x, var_66_3.y, 0)
				local var_66_5 = arg_63_1.bgs_.STwhite

				var_66_5.transform.localPosition = var_66_4
				var_66_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_66_6 = var_66_5:GetComponent("SpriteRenderer")

				if var_66_6 and var_66_6.sprite then
					local var_66_7 = (var_66_5.transform.localPosition - var_66_3).z
					local var_66_8 = manager.ui.mainCameraCom_
					local var_66_9 = 2 * var_66_7 * Mathf.Tan(var_66_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_66_10 = var_66_9 * var_66_8.aspect
					local var_66_11 = var_66_6.sprite.bounds.size.x
					local var_66_12 = var_66_6.sprite.bounds.size.y
					local var_66_13 = var_66_10 / var_66_11
					local var_66_14 = var_66_9 / var_66_12
					local var_66_15 = var_66_14 < var_66_13 and var_66_13 or var_66_14

					var_66_5.transform.localScale = Vector3.New(var_66_15, var_66_15, 0)
				end

				for iter_66_0, iter_66_1 in pairs(arg_63_1.bgs_) do
					if iter_66_0 ~= "STwhite" then
						iter_66_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_66_16 = 2

			if var_66_16 < arg_63_1.time_ and arg_63_1.time_ <= var_66_16 + arg_66_0 then
				arg_63_1.allBtn_.enabled = false
			end

			local var_66_17 = 0.133333333333333

			if arg_63_1.time_ >= var_66_16 + var_66_17 and arg_63_1.time_ < var_66_16 + var_66_17 + arg_66_0 then
				arg_63_1.allBtn_.enabled = true
			end

			local var_66_18 = 0

			if var_66_18 < arg_63_1.time_ and arg_63_1.time_ <= var_66_18 + arg_66_0 then
				arg_63_1.mask_.enabled = true
				arg_63_1.mask_.raycastTarget = true

				arg_63_1:SetGaussion(false)
			end

			local var_66_19 = 2

			if var_66_18 <= arg_63_1.time_ and arg_63_1.time_ < var_66_18 + var_66_19 then
				local var_66_20 = (arg_63_1.time_ - var_66_18) / var_66_19
				local var_66_21 = Color.New(0, 0, 0)

				var_66_21.a = Mathf.Lerp(1, 0, var_66_20)
				arg_63_1.mask_.color = var_66_21
			end

			if arg_63_1.time_ >= var_66_18 + var_66_19 and arg_63_1.time_ < var_66_18 + var_66_19 + arg_66_0 then
				local var_66_22 = Color.New(0, 0, 0)
				local var_66_23 = 0

				arg_63_1.mask_.enabled = false
				var_66_22.a = var_66_23
				arg_63_1.mask_.color = var_66_22
			end

			local var_66_24 = 0

			if var_66_24 < arg_63_1.time_ and arg_63_1.time_ <= var_66_24 + arg_66_0 then
				arg_63_1.cswbg_:SetActive(true)

				local var_66_25 = arg_63_1.cswt_:GetComponent("RectTransform")

				arg_63_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_66_25.offsetMin = Vector2.New(0, 0)
				var_66_25.offsetMax = Vector2.New(0, 130)

				local var_66_26 = arg_63_1:GetWordFromCfg(419146)
				local var_66_27 = arg_63_1:FormatText(var_66_26.content)

				arg_63_1.cswt_.text = var_66_27

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.cswt_)

				arg_63_1.cswt_.fontSize = 120
				arg_63_1.cswt_:GetComponent("Text").color = Color(0, 0, 0)

				arg_63_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_63_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end

			local var_66_28 = 0

			if var_66_28 < arg_63_1.time_ and arg_63_1.time_ <= var_66_28 + arg_66_0 then
				local var_66_29 = arg_63_1.fswbg_.transform:Find("textbox/adapt/content") or arg_63_1.fswbg_.transform:Find("textbox/content")
				local var_66_30 = arg_63_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_66_31 = var_66_29:GetComponent("Text")
				local var_66_32 = var_66_29:GetComponent("RectTransform")

				var_66_31.alignment = UnityEngine.TextAnchor.LowerCenter
				var_66_32.offsetMin = Vector2.New(0, -70)
				var_66_32.offsetMax = Vector2.New(0, 0)
			end

			local var_66_33 = 0

			if var_66_33 < arg_63_1.time_ and arg_63_1.time_ <= var_66_33 + arg_66_0 then
				arg_63_1.fswbg_:SetActive(true)
				arg_63_1.dialog_:SetActive(false)

				arg_63_1.fswtw_.percent = 0

				local var_66_34 = arg_63_1:GetWordFromCfg(420052014)
				local var_66_35 = arg_63_1:FormatText(var_66_34.content)

				arg_63_1.fswt_.text = var_66_35

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.fswt_)

				arg_63_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_63_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_63_1.fswtw_:SetDirty()

				arg_63_1.typewritterCharCountI18N = 0

				SetActive(arg_63_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_63_1:ShowNextGo(false)
			end

			local var_66_36 = 2

			if var_66_36 < arg_63_1.time_ and arg_63_1.time_ <= var_66_36 + arg_66_0 then
				arg_63_1.var_.oldValueTypewriter = arg_63_1.fswtw_.percent

				SetActive(arg_63_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_63_1:ShowNextGo(false)
			end

			local var_66_37 = 13
			local var_66_38 = 0.866666666666667
			local var_66_39 = arg_63_1:GetWordFromCfg(420052014)
			local var_66_40 = arg_63_1:FormatText(var_66_39.content)
			local var_66_41, var_66_42 = arg_63_1:GetPercentByPara(var_66_40, 1)

			if var_66_36 < arg_63_1.time_ and arg_63_1.time_ <= var_66_36 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0

				local var_66_43 = var_66_37 <= 0 and var_66_38 or var_66_38 * ((var_66_42 - arg_63_1.typewritterCharCountI18N) / var_66_37)

				if var_66_43 > 0 and var_66_38 < var_66_43 then
					arg_63_1.talkMaxDuration = var_66_43

					if var_66_43 + var_66_36 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_43 + var_66_36
					end
				end
			end

			local var_66_44 = 0.866666666666667
			local var_66_45 = math.max(var_66_44, arg_63_1.talkMaxDuration)

			if var_66_36 <= arg_63_1.time_ and arg_63_1.time_ < var_66_36 + var_66_45 then
				local var_66_46 = (arg_63_1.time_ - var_66_36) / var_66_45

				arg_63_1.fswtw_.percent = Mathf.Lerp(arg_63_1.var_.oldValueTypewriter, var_66_41, var_66_46)
				arg_63_1.fswt_:GetComponent("Text").color = Color(0, 0, 0)

				arg_63_1.fswtw_:SetDirty()
			end

			if arg_63_1.time_ >= var_66_36 + var_66_45 and arg_63_1.time_ < var_66_36 + var_66_45 + arg_66_0 then
				arg_63_1.fswtw_.percent = var_66_41

				arg_63_1.fswtw_:SetDirty()
				arg_63_1:ShowNextGo(true)

				arg_63_1.typewritterCharCountI18N = var_66_42
			end
		end

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	Play420052015 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 420052015
		arg_67_1.duration_ = 5.12

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play420052016(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = 0

			if var_70_0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_0 + arg_70_0 then
				arg_67_1.fswbg_:SetActive(true)
				arg_67_1.dialog_:SetActive(false)

				arg_67_1.fswtw_.percent = 0

				local var_70_1 = arg_67_1:GetWordFromCfg(420052015)
				local var_70_2 = arg_67_1:FormatText(var_70_1.content)

				arg_67_1.fswt_.text = var_70_2

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.fswt_)

				arg_67_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_67_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_67_1.fswtw_:SetDirty()

				arg_67_1.typewritterCharCountI18N = 0

				SetActive(arg_67_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_67_1:ShowNextGo(false)
			end

			local var_70_3 = 0.0166666666666667

			if var_70_3 < arg_67_1.time_ and arg_67_1.time_ <= var_70_3 + arg_70_0 then
				arg_67_1.var_.oldValueTypewriter = arg_67_1.fswtw_.percent

				SetActive(arg_67_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_67_1:ShowNextGo(false)
			end

			local var_70_4 = 22
			local var_70_5 = 1.46666666666667
			local var_70_6 = arg_67_1:GetWordFromCfg(420052015)
			local var_70_7 = arg_67_1:FormatText(var_70_6.content)
			local var_70_8, var_70_9 = arg_67_1:GetPercentByPara(var_70_7, 1)

			if var_70_3 < arg_67_1.time_ and arg_67_1.time_ <= var_70_3 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0

				local var_70_10 = var_70_4 <= 0 and var_70_5 or var_70_5 * ((var_70_9 - arg_67_1.typewritterCharCountI18N) / var_70_4)

				if var_70_10 > 0 and var_70_5 < var_70_10 then
					arg_67_1.talkMaxDuration = var_70_10

					if var_70_10 + var_70_3 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_10 + var_70_3
					end
				end
			end

			local var_70_11 = 1.46666666666667
			local var_70_12 = math.max(var_70_11, arg_67_1.talkMaxDuration)

			if var_70_3 <= arg_67_1.time_ and arg_67_1.time_ < var_70_3 + var_70_12 then
				local var_70_13 = (arg_67_1.time_ - var_70_3) / var_70_12

				arg_67_1.fswtw_.percent = Mathf.Lerp(arg_67_1.var_.oldValueTypewriter, var_70_8, var_70_13)
				arg_67_1.fswt_:GetComponent("Text").color = Color(0, 0, 0)

				arg_67_1.fswtw_:SetDirty()
			end

			if arg_67_1.time_ >= var_70_3 + var_70_12 and arg_67_1.time_ < var_70_3 + var_70_12 + arg_70_0 then
				arg_67_1.fswtw_.percent = var_70_8

				arg_67_1.fswtw_:SetDirty()
				arg_67_1:ShowNextGo(true)

				arg_67_1.typewritterCharCountI18N = var_70_9
			end

			local var_70_14 = 0.0166666666666667
			local var_70_15 = 5.1
			local var_70_16 = manager.audio:GetVoiceLength("story_v_out_420052", "420052015", "story_v_out_420052.awb") / 1000

			if var_70_16 > 0 and var_70_15 < var_70_16 and var_70_16 + var_70_14 > arg_67_1.duration_ then
				local var_70_17 = var_70_16

				arg_67_1.duration_ = var_70_16 + var_70_14
			end

			if var_70_14 < arg_67_1.time_ and arg_67_1.time_ <= var_70_14 + arg_70_0 then
				local var_70_18 = "play"
				local var_70_19 = "voice"

				arg_67_1:AudioAction(var_70_18, var_70_19, "story_v_out_420052", "420052015", "story_v_out_420052.awb")
			end
		end

		arg_67_1.nodeConfigList_ = {}

		arg_67_1:InitPlayNodeList()
	end,
	Play420052016 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 420052016
		arg_71_1.duration_ = 7

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play420052017(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = 0

			if var_74_0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_0 + arg_74_0 then
				arg_71_1.mask_.enabled = true
				arg_71_1.mask_.raycastTarget = true

				arg_71_1:SetGaussion(false)
			end

			local var_74_1 = 2

			if var_74_0 <= arg_71_1.time_ and arg_71_1.time_ < var_74_0 + var_74_1 then
				local var_74_2 = (arg_71_1.time_ - var_74_0) / var_74_1
				local var_74_3 = Color.New(1, 1, 1)

				var_74_3.a = Mathf.Lerp(1, 0, var_74_2)
				arg_71_1.mask_.color = var_74_3
			end

			if arg_71_1.time_ >= var_74_0 + var_74_1 and arg_71_1.time_ < var_74_0 + var_74_1 + arg_74_0 then
				local var_74_4 = Color.New(1, 1, 1)
				local var_74_5 = 0

				arg_71_1.mask_.enabled = false
				var_74_4.a = var_74_5
				arg_71_1.mask_.color = var_74_4
			end

			local var_74_6 = 0

			if var_74_6 < arg_71_1.time_ and arg_71_1.time_ <= var_74_6 + arg_74_0 then
				local var_74_7 = manager.ui.mainCamera.transform.localPosition
				local var_74_8 = Vector3.New(0, 0, 10) + Vector3.New(var_74_7.x, var_74_7.y, 0)
				local var_74_9 = arg_71_1.bgs_.L16I

				var_74_9.transform.localPosition = var_74_8
				var_74_9.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_74_10 = var_74_9:GetComponent("SpriteRenderer")

				if var_74_10 and var_74_10.sprite then
					local var_74_11 = (var_74_9.transform.localPosition - var_74_7).z
					local var_74_12 = manager.ui.mainCameraCom_
					local var_74_13 = 2 * var_74_11 * Mathf.Tan(var_74_12.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_74_14 = var_74_13 * var_74_12.aspect
					local var_74_15 = var_74_10.sprite.bounds.size.x
					local var_74_16 = var_74_10.sprite.bounds.size.y
					local var_74_17 = var_74_14 / var_74_15
					local var_74_18 = var_74_13 / var_74_16
					local var_74_19 = var_74_18 < var_74_17 and var_74_17 or var_74_18

					var_74_9.transform.localScale = Vector3.New(var_74_19, var_74_19, 0)
				end

				for iter_74_0, iter_74_1 in pairs(arg_71_1.bgs_) do
					if iter_74_0 ~= "L16I" then
						iter_74_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_74_20 = 0

			if var_74_20 < arg_71_1.time_ and arg_71_1.time_ <= var_74_20 + arg_74_0 then
				arg_71_1.fswbg_:SetActive(false)
				arg_71_1.dialog_:SetActive(false)
				SetActive(arg_71_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_71_1:ShowNextGo(false)
			end

			local var_74_21 = 0

			if var_74_21 < arg_71_1.time_ and arg_71_1.time_ <= var_74_21 + arg_74_0 then
				arg_71_1.cswbg_:SetActive(false)
			end

			if arg_71_1.frameCnt_ <= 1 then
				arg_71_1.dialog_:SetActive(false)
			end

			local var_74_22 = 2
			local var_74_23 = 0.325

			if var_74_22 < arg_71_1.time_ and arg_71_1.time_ <= var_74_22 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0

				arg_71_1.dialog_:SetActive(true)

				arg_71_1.dialogCg_.alpha = 0

				local var_74_24 = LeanTween.value(arg_71_1.dialog_, 0, 1, 0.3)

				var_74_24:setOnUpdate(LuaHelper.FloatAction(function(arg_75_0)
					arg_71_1.dialogCg_.alpha = arg_75_0
				end))
				var_74_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_71_1.dialog_)
					var_74_24:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_71_1.duration_ = arg_71_1.duration_ + 0.3

				SetActive(arg_71_1.leftNameGo_, true)

				local var_74_25 = arg_71_1:FormatText(StoryNameCfg[7].name)

				arg_71_1.leftNameTxt_.text = var_74_25

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

				local var_74_26 = arg_71_1:GetWordFromCfg(420052016)
				local var_74_27 = arg_71_1:FormatText(var_74_26.content)

				arg_71_1.text_.text = var_74_27

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_28 = 14
				local var_74_29 = utf8.len(var_74_27)
				local var_74_30 = var_74_28 <= 0 and var_74_23 or var_74_23 * (var_74_29 / var_74_28)

				if var_74_30 > 0 and var_74_23 < var_74_30 then
					arg_71_1.talkMaxDuration = var_74_30
					var_74_22 = var_74_22 + 0.3

					if var_74_30 + var_74_22 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_30 + var_74_22
					end
				end

				arg_71_1.text_.text = var_74_27
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)
				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_31 = var_74_22 + 0.3
			local var_74_32 = math.max(var_74_23, arg_71_1.talkMaxDuration)

			if var_74_31 <= arg_71_1.time_ and arg_71_1.time_ < var_74_31 + var_74_32 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_31) / var_74_32

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_31 + var_74_32 and arg_71_1.time_ < var_74_31 + var_74_32 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {}

		arg_71_1:InitPlayNodeList()
	end,
	Play420052017 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 420052017
		arg_77_1.duration_ = 4.13

		local var_77_0 = {
			zh = 3.733,
			ja = 4.133
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
				arg_77_0:Play420052018(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = arg_77_1.actors_["1085ui_story"].transform
			local var_80_1 = 0

			if var_80_1 < arg_77_1.time_ and arg_77_1.time_ <= var_80_1 + arg_80_0 then
				arg_77_1.var_.moveOldPos1085ui_story = var_80_0.localPosition
			end

			local var_80_2 = 0.001

			if var_80_1 <= arg_77_1.time_ and arg_77_1.time_ < var_80_1 + var_80_2 then
				local var_80_3 = (arg_77_1.time_ - var_80_1) / var_80_2
				local var_80_4 = Vector3.New(0, -1.01, -5.83)

				var_80_0.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos1085ui_story, var_80_4, var_80_3)

				local var_80_5 = manager.ui.mainCamera.transform.position - var_80_0.position

				var_80_0.forward = Vector3.New(var_80_5.x, var_80_5.y, var_80_5.z)

				local var_80_6 = var_80_0.localEulerAngles

				var_80_6.z = 0
				var_80_6.x = 0
				var_80_0.localEulerAngles = var_80_6
			end

			if arg_77_1.time_ >= var_80_1 + var_80_2 and arg_77_1.time_ < var_80_1 + var_80_2 + arg_80_0 then
				var_80_0.localPosition = Vector3.New(0, -1.01, -5.83)

				local var_80_7 = manager.ui.mainCamera.transform.position - var_80_0.position

				var_80_0.forward = Vector3.New(var_80_7.x, var_80_7.y, var_80_7.z)

				local var_80_8 = var_80_0.localEulerAngles

				var_80_8.z = 0
				var_80_8.x = 0
				var_80_0.localEulerAngles = var_80_8
			end

			local var_80_9 = arg_77_1.actors_["1085ui_story"]
			local var_80_10 = 0

			if var_80_10 < arg_77_1.time_ and arg_77_1.time_ <= var_80_10 + arg_80_0 and not isNil(var_80_9) and arg_77_1.var_.characterEffect1085ui_story == nil then
				arg_77_1.var_.characterEffect1085ui_story = var_80_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_11 = 0.200000002980232

			if var_80_10 <= arg_77_1.time_ and arg_77_1.time_ < var_80_10 + var_80_11 and not isNil(var_80_9) then
				local var_80_12 = (arg_77_1.time_ - var_80_10) / var_80_11

				if arg_77_1.var_.characterEffect1085ui_story and not isNil(var_80_9) then
					arg_77_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_77_1.time_ >= var_80_10 + var_80_11 and arg_77_1.time_ < var_80_10 + var_80_11 + arg_80_0 and not isNil(var_80_9) and arg_77_1.var_.characterEffect1085ui_story then
				arg_77_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_80_13 = 0

			if var_80_13 < arg_77_1.time_ and arg_77_1.time_ <= var_80_13 + arg_80_0 then
				arg_77_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action1_1")
			end

			local var_80_14 = 0
			local var_80_15 = 0.325

			if var_80_14 < arg_77_1.time_ and arg_77_1.time_ <= var_80_14 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				local var_80_16 = arg_77_1:FormatText(StoryNameCfg[328].name)

				arg_77_1.leftNameTxt_.text = var_80_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_17 = arg_77_1:GetWordFromCfg(420052017)
				local var_80_18 = arg_77_1:FormatText(var_80_17.content)

				arg_77_1.text_.text = var_80_18

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_19 = 13
				local var_80_20 = utf8.len(var_80_18)
				local var_80_21 = var_80_19 <= 0 and var_80_15 or var_80_15 * (var_80_20 / var_80_19)

				if var_80_21 > 0 and var_80_15 < var_80_21 then
					arg_77_1.talkMaxDuration = var_80_21

					if var_80_21 + var_80_14 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_21 + var_80_14
					end
				end

				arg_77_1.text_.text = var_80_18
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420052", "420052017", "story_v_out_420052.awb") ~= 0 then
					local var_80_22 = manager.audio:GetVoiceLength("story_v_out_420052", "420052017", "story_v_out_420052.awb") / 1000

					if var_80_22 + var_80_14 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_22 + var_80_14
					end

					if var_80_17.prefab_name ~= "" and arg_77_1.actors_[var_80_17.prefab_name] ~= nil then
						local var_80_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_17.prefab_name].transform, "story_v_out_420052", "420052017", "story_v_out_420052.awb")

						arg_77_1:RecordAudio("420052017", var_80_23)
						arg_77_1:RecordAudio("420052017", var_80_23)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_420052", "420052017", "story_v_out_420052.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_420052", "420052017", "story_v_out_420052.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_24 = math.max(var_80_15, arg_77_1.talkMaxDuration)

			if var_80_14 <= arg_77_1.time_ and arg_77_1.time_ < var_80_14 + var_80_24 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_14) / var_80_24

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_14 + var_80_24 and arg_77_1.time_ < var_80_14 + var_80_24 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_77_1:InitPlayNodeList()
	end,
	Play420052018 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 420052018
		arg_81_1.duration_ = 5

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play420052019(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = arg_81_1.actors_["1085ui_story"]
			local var_84_1 = 0

			if var_84_1 < arg_81_1.time_ and arg_81_1.time_ <= var_84_1 + arg_84_0 and not isNil(var_84_0) and arg_81_1.var_.characterEffect1085ui_story == nil then
				arg_81_1.var_.characterEffect1085ui_story = var_84_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_2 = 0.200000002980232

			if var_84_1 <= arg_81_1.time_ and arg_81_1.time_ < var_84_1 + var_84_2 and not isNil(var_84_0) then
				local var_84_3 = (arg_81_1.time_ - var_84_1) / var_84_2

				if arg_81_1.var_.characterEffect1085ui_story and not isNil(var_84_0) then
					local var_84_4 = Mathf.Lerp(0, 0.5, var_84_3)

					arg_81_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_81_1.var_.characterEffect1085ui_story.fillRatio = var_84_4
				end
			end

			if arg_81_1.time_ >= var_84_1 + var_84_2 and arg_81_1.time_ < var_84_1 + var_84_2 + arg_84_0 and not isNil(var_84_0) and arg_81_1.var_.characterEffect1085ui_story then
				local var_84_5 = 0.5

				arg_81_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_81_1.var_.characterEffect1085ui_story.fillRatio = var_84_5
			end

			local var_84_6 = 0
			local var_84_7 = 0.275

			if var_84_6 < arg_81_1.time_ and arg_81_1.time_ <= var_84_6 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				local var_84_8 = arg_81_1:FormatText(StoryNameCfg[7].name)

				arg_81_1.leftNameTxt_.text = var_84_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, true)
				arg_81_1.iconController_:SetSelectedState("hero")

				arg_81_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_81_1.callingController_:SetSelectedState("normal")

				arg_81_1.keyicon_.color = Color.New(1, 1, 1)
				arg_81_1.icon_.color = Color.New(1, 1, 1)

				local var_84_9 = arg_81_1:GetWordFromCfg(420052018)
				local var_84_10 = arg_81_1:FormatText(var_84_9.content)

				arg_81_1.text_.text = var_84_10

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_11 = 11
				local var_84_12 = utf8.len(var_84_10)
				local var_84_13 = var_84_11 <= 0 and var_84_7 or var_84_7 * (var_84_12 / var_84_11)

				if var_84_13 > 0 and var_84_7 < var_84_13 then
					arg_81_1.talkMaxDuration = var_84_13

					if var_84_13 + var_84_6 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_13 + var_84_6
					end
				end

				arg_81_1.text_.text = var_84_10
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)
				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_14 = math.max(var_84_7, arg_81_1.talkMaxDuration)

			if var_84_6 <= arg_81_1.time_ and arg_81_1.time_ < var_84_6 + var_84_14 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_6) / var_84_14

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_6 + var_84_14 and arg_81_1.time_ < var_84_6 + var_84_14 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play420052019 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 420052019
		arg_85_1.duration_ = 11.03

		local var_85_0 = {
			zh = 6.8,
			ja = 11.033
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
				arg_85_0:Play420052020(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = arg_85_1.actors_["1085ui_story"]
			local var_88_1 = 0

			if var_88_1 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 and not isNil(var_88_0) and arg_85_1.var_.characterEffect1085ui_story == nil then
				arg_85_1.var_.characterEffect1085ui_story = var_88_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_2 = 0.200000002980232

			if var_88_1 <= arg_85_1.time_ and arg_85_1.time_ < var_88_1 + var_88_2 and not isNil(var_88_0) then
				local var_88_3 = (arg_85_1.time_ - var_88_1) / var_88_2

				if arg_85_1.var_.characterEffect1085ui_story and not isNil(var_88_0) then
					arg_85_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_85_1.time_ >= var_88_1 + var_88_2 and arg_85_1.time_ < var_88_1 + var_88_2 + arg_88_0 and not isNil(var_88_0) and arg_85_1.var_.characterEffect1085ui_story then
				arg_85_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_88_4 = 0
			local var_88_5 = 0.6

			if var_88_4 < arg_85_1.time_ and arg_85_1.time_ <= var_88_4 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				local var_88_6 = arg_85_1:FormatText(StoryNameCfg[328].name)

				arg_85_1.leftNameTxt_.text = var_88_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_7 = arg_85_1:GetWordFromCfg(420052019)
				local var_88_8 = arg_85_1:FormatText(var_88_7.content)

				arg_85_1.text_.text = var_88_8

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_9 = 24
				local var_88_10 = utf8.len(var_88_8)
				local var_88_11 = var_88_9 <= 0 and var_88_5 or var_88_5 * (var_88_10 / var_88_9)

				if var_88_11 > 0 and var_88_5 < var_88_11 then
					arg_85_1.talkMaxDuration = var_88_11

					if var_88_11 + var_88_4 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_11 + var_88_4
					end
				end

				arg_85_1.text_.text = var_88_8
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420052", "420052019", "story_v_out_420052.awb") ~= 0 then
					local var_88_12 = manager.audio:GetVoiceLength("story_v_out_420052", "420052019", "story_v_out_420052.awb") / 1000

					if var_88_12 + var_88_4 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_12 + var_88_4
					end

					if var_88_7.prefab_name ~= "" and arg_85_1.actors_[var_88_7.prefab_name] ~= nil then
						local var_88_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_7.prefab_name].transform, "story_v_out_420052", "420052019", "story_v_out_420052.awb")

						arg_85_1:RecordAudio("420052019", var_88_13)
						arg_85_1:RecordAudio("420052019", var_88_13)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_420052", "420052019", "story_v_out_420052.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_420052", "420052019", "story_v_out_420052.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_14 = math.max(var_88_5, arg_85_1.talkMaxDuration)

			if var_88_4 <= arg_85_1.time_ and arg_85_1.time_ < var_88_4 + var_88_14 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_4) / var_88_14

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_4 + var_88_14 and arg_85_1.time_ < var_88_4 + var_88_14 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play420052020 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 420052020
		arg_89_1.duration_ = 8.4

		local var_89_0 = {
			zh = 8.2,
			ja = 8.4
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
				arg_89_0:Play420052021(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = 0

			if var_92_0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_0 + arg_92_0 then
				arg_89_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action3_1")
			end

			local var_92_1 = 0
			local var_92_2 = 0.7

			if var_92_1 < arg_89_1.time_ and arg_89_1.time_ <= var_92_1 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				local var_92_3 = arg_89_1:FormatText(StoryNameCfg[328].name)

				arg_89_1.leftNameTxt_.text = var_92_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_4 = arg_89_1:GetWordFromCfg(420052020)
				local var_92_5 = arg_89_1:FormatText(var_92_4.content)

				arg_89_1.text_.text = var_92_5

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_6 = 28
				local var_92_7 = utf8.len(var_92_5)
				local var_92_8 = var_92_6 <= 0 and var_92_2 or var_92_2 * (var_92_7 / var_92_6)

				if var_92_8 > 0 and var_92_2 < var_92_8 then
					arg_89_1.talkMaxDuration = var_92_8

					if var_92_8 + var_92_1 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_8 + var_92_1
					end
				end

				arg_89_1.text_.text = var_92_5
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420052", "420052020", "story_v_out_420052.awb") ~= 0 then
					local var_92_9 = manager.audio:GetVoiceLength("story_v_out_420052", "420052020", "story_v_out_420052.awb") / 1000

					if var_92_9 + var_92_1 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_9 + var_92_1
					end

					if var_92_4.prefab_name ~= "" and arg_89_1.actors_[var_92_4.prefab_name] ~= nil then
						local var_92_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_4.prefab_name].transform, "story_v_out_420052", "420052020", "story_v_out_420052.awb")

						arg_89_1:RecordAudio("420052020", var_92_10)
						arg_89_1:RecordAudio("420052020", var_92_10)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_420052", "420052020", "story_v_out_420052.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_420052", "420052020", "story_v_out_420052.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_11 = math.max(var_92_2, arg_89_1.talkMaxDuration)

			if var_92_1 <= arg_89_1.time_ and arg_89_1.time_ < var_92_1 + var_92_11 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_1) / var_92_11

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_1 + var_92_11 and arg_89_1.time_ < var_92_1 + var_92_11 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play420052021 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 420052021
		arg_93_1.duration_ = 5

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play420052022(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = arg_93_1.actors_["1085ui_story"]
			local var_96_1 = 0

			if var_96_1 < arg_93_1.time_ and arg_93_1.time_ <= var_96_1 + arg_96_0 and not isNil(var_96_0) and arg_93_1.var_.characterEffect1085ui_story == nil then
				arg_93_1.var_.characterEffect1085ui_story = var_96_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_2 = 0.200000002980232

			if var_96_1 <= arg_93_1.time_ and arg_93_1.time_ < var_96_1 + var_96_2 and not isNil(var_96_0) then
				local var_96_3 = (arg_93_1.time_ - var_96_1) / var_96_2

				if arg_93_1.var_.characterEffect1085ui_story and not isNil(var_96_0) then
					local var_96_4 = Mathf.Lerp(0, 0.5, var_96_3)

					arg_93_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_93_1.var_.characterEffect1085ui_story.fillRatio = var_96_4
				end
			end

			if arg_93_1.time_ >= var_96_1 + var_96_2 and arg_93_1.time_ < var_96_1 + var_96_2 + arg_96_0 and not isNil(var_96_0) and arg_93_1.var_.characterEffect1085ui_story then
				local var_96_5 = 0.5

				arg_93_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_93_1.var_.characterEffect1085ui_story.fillRatio = var_96_5
			end

			local var_96_6 = 0
			local var_96_7 = 0.65

			if var_96_6 < arg_93_1.time_ and arg_93_1.time_ <= var_96_6 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				local var_96_8 = arg_93_1:FormatText(StoryNameCfg[7].name)

				arg_93_1.leftNameTxt_.text = var_96_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, true)
				arg_93_1.iconController_:SetSelectedState("hero")

				arg_93_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_93_1.callingController_:SetSelectedState("normal")

				arg_93_1.keyicon_.color = Color.New(1, 1, 1)
				arg_93_1.icon_.color = Color.New(1, 1, 1)

				local var_96_9 = arg_93_1:GetWordFromCfg(420052021)
				local var_96_10 = arg_93_1:FormatText(var_96_9.content)

				arg_93_1.text_.text = var_96_10

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_11 = 26
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
				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_14 = math.max(var_96_7, arg_93_1.talkMaxDuration)

			if var_96_6 <= arg_93_1.time_ and arg_93_1.time_ < var_96_6 + var_96_14 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_6) / var_96_14

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_6 + var_96_14 and arg_93_1.time_ < var_96_6 + var_96_14 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play420052022 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 420052022
		arg_97_1.duration_ = 5

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play420052023(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = 0
			local var_100_1 = 0.6

			if var_100_0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_0 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				local var_100_2 = arg_97_1:FormatText(StoryNameCfg[7].name)

				arg_97_1.leftNameTxt_.text = var_100_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, true)
				arg_97_1.iconController_:SetSelectedState("hero")

				arg_97_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_97_1.callingController_:SetSelectedState("normal")

				arg_97_1.keyicon_.color = Color.New(1, 1, 1)
				arg_97_1.icon_.color = Color.New(1, 1, 1)

				local var_100_3 = arg_97_1:GetWordFromCfg(420052022)
				local var_100_4 = arg_97_1:FormatText(var_100_3.content)

				arg_97_1.text_.text = var_100_4

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_5 = 24
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
				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_8 = math.max(var_100_1, arg_97_1.talkMaxDuration)

			if var_100_0 <= arg_97_1.time_ and arg_97_1.time_ < var_100_0 + var_100_8 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_0) / var_100_8

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_0 + var_100_8 and arg_97_1.time_ < var_100_0 + var_100_8 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play420052023 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 420052023
		arg_101_1.duration_ = 5.2

		local var_101_0 = {
			zh = 4.933,
			ja = 5.2
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
				arg_101_0:Play420052024(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = arg_101_1.actors_["1085ui_story"]
			local var_104_1 = 0

			if var_104_1 < arg_101_1.time_ and arg_101_1.time_ <= var_104_1 + arg_104_0 and not isNil(var_104_0) and arg_101_1.var_.characterEffect1085ui_story == nil then
				arg_101_1.var_.characterEffect1085ui_story = var_104_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_2 = 0.200000002980232

			if var_104_1 <= arg_101_1.time_ and arg_101_1.time_ < var_104_1 + var_104_2 and not isNil(var_104_0) then
				local var_104_3 = (arg_101_1.time_ - var_104_1) / var_104_2

				if arg_101_1.var_.characterEffect1085ui_story and not isNil(var_104_0) then
					arg_101_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_101_1.time_ >= var_104_1 + var_104_2 and arg_101_1.time_ < var_104_1 + var_104_2 + arg_104_0 and not isNil(var_104_0) and arg_101_1.var_.characterEffect1085ui_story then
				arg_101_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_104_4 = 0

			if var_104_4 < arg_101_1.time_ and arg_101_1.time_ <= var_104_4 + arg_104_0 then
				arg_101_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action3_2")
			end

			local var_104_5 = 0

			if var_104_5 < arg_101_1.time_ and arg_101_1.time_ <= var_104_5 + arg_104_0 then
				arg_101_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_104_6 = 0
			local var_104_7 = 0.45

			if var_104_6 < arg_101_1.time_ and arg_101_1.time_ <= var_104_6 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				local var_104_8 = arg_101_1:FormatText(StoryNameCfg[328].name)

				arg_101_1.leftNameTxt_.text = var_104_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_9 = arg_101_1:GetWordFromCfg(420052023)
				local var_104_10 = arg_101_1:FormatText(var_104_9.content)

				arg_101_1.text_.text = var_104_10

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_11 = 18
				local var_104_12 = utf8.len(var_104_10)
				local var_104_13 = var_104_11 <= 0 and var_104_7 or var_104_7 * (var_104_12 / var_104_11)

				if var_104_13 > 0 and var_104_7 < var_104_13 then
					arg_101_1.talkMaxDuration = var_104_13

					if var_104_13 + var_104_6 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_13 + var_104_6
					end
				end

				arg_101_1.text_.text = var_104_10
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420052", "420052023", "story_v_out_420052.awb") ~= 0 then
					local var_104_14 = manager.audio:GetVoiceLength("story_v_out_420052", "420052023", "story_v_out_420052.awb") / 1000

					if var_104_14 + var_104_6 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_14 + var_104_6
					end

					if var_104_9.prefab_name ~= "" and arg_101_1.actors_[var_104_9.prefab_name] ~= nil then
						local var_104_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_9.prefab_name].transform, "story_v_out_420052", "420052023", "story_v_out_420052.awb")

						arg_101_1:RecordAudio("420052023", var_104_15)
						arg_101_1:RecordAudio("420052023", var_104_15)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_420052", "420052023", "story_v_out_420052.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_420052", "420052023", "story_v_out_420052.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_16 = math.max(var_104_7, arg_101_1.talkMaxDuration)

			if var_104_6 <= arg_101_1.time_ and arg_101_1.time_ < var_104_6 + var_104_16 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_6) / var_104_16

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_6 + var_104_16 and arg_101_1.time_ < var_104_6 + var_104_16 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play420052024 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 420052024
		arg_105_1.duration_ = 7.6

		local var_105_0 = {
			zh = 7.6,
			ja = 7.4
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
				arg_105_0:Play420052025(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = 0
			local var_108_1 = 0.7

			if var_108_0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_0 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				local var_108_2 = arg_105_1:FormatText(StoryNameCfg[328].name)

				arg_105_1.leftNameTxt_.text = var_108_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_3 = arg_105_1:GetWordFromCfg(420052024)
				local var_108_4 = arg_105_1:FormatText(var_108_3.content)

				arg_105_1.text_.text = var_108_4

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_5 = 28
				local var_108_6 = utf8.len(var_108_4)
				local var_108_7 = var_108_5 <= 0 and var_108_1 or var_108_1 * (var_108_6 / var_108_5)

				if var_108_7 > 0 and var_108_1 < var_108_7 then
					arg_105_1.talkMaxDuration = var_108_7

					if var_108_7 + var_108_0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_7 + var_108_0
					end
				end

				arg_105_1.text_.text = var_108_4
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420052", "420052024", "story_v_out_420052.awb") ~= 0 then
					local var_108_8 = manager.audio:GetVoiceLength("story_v_out_420052", "420052024", "story_v_out_420052.awb") / 1000

					if var_108_8 + var_108_0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_8 + var_108_0
					end

					if var_108_3.prefab_name ~= "" and arg_105_1.actors_[var_108_3.prefab_name] ~= nil then
						local var_108_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_3.prefab_name].transform, "story_v_out_420052", "420052024", "story_v_out_420052.awb")

						arg_105_1:RecordAudio("420052024", var_108_9)
						arg_105_1:RecordAudio("420052024", var_108_9)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_420052", "420052024", "story_v_out_420052.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_420052", "420052024", "story_v_out_420052.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_10 = math.max(var_108_1, arg_105_1.talkMaxDuration)

			if var_108_0 <= arg_105_1.time_ and arg_105_1.time_ < var_108_0 + var_108_10 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_0) / var_108_10

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_0 + var_108_10 and arg_105_1.time_ < var_108_0 + var_108_10 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play420052025 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 420052025
		arg_109_1.duration_ = 5

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play420052026(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = arg_109_1.actors_["1085ui_story"]
			local var_112_1 = 0

			if var_112_1 < arg_109_1.time_ and arg_109_1.time_ <= var_112_1 + arg_112_0 and not isNil(var_112_0) and arg_109_1.var_.characterEffect1085ui_story == nil then
				arg_109_1.var_.characterEffect1085ui_story = var_112_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_2 = 0.200000002980232

			if var_112_1 <= arg_109_1.time_ and arg_109_1.time_ < var_112_1 + var_112_2 and not isNil(var_112_0) then
				local var_112_3 = (arg_109_1.time_ - var_112_1) / var_112_2

				if arg_109_1.var_.characterEffect1085ui_story and not isNil(var_112_0) then
					local var_112_4 = Mathf.Lerp(0, 0.5, var_112_3)

					arg_109_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_109_1.var_.characterEffect1085ui_story.fillRatio = var_112_4
				end
			end

			if arg_109_1.time_ >= var_112_1 + var_112_2 and arg_109_1.time_ < var_112_1 + var_112_2 + arg_112_0 and not isNil(var_112_0) and arg_109_1.var_.characterEffect1085ui_story then
				local var_112_5 = 0.5

				arg_109_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_109_1.var_.characterEffect1085ui_story.fillRatio = var_112_5
			end

			local var_112_6 = 0
			local var_112_7 = 0.525

			if var_112_6 < arg_109_1.time_ and arg_109_1.time_ <= var_112_6 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				local var_112_8 = arg_109_1:FormatText(StoryNameCfg[7].name)

				arg_109_1.leftNameTxt_.text = var_112_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, true)
				arg_109_1.iconController_:SetSelectedState("hero")

				arg_109_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_109_1.callingController_:SetSelectedState("normal")

				arg_109_1.keyicon_.color = Color.New(1, 1, 1)
				arg_109_1.icon_.color = Color.New(1, 1, 1)

				local var_112_9 = arg_109_1:GetWordFromCfg(420052025)
				local var_112_10 = arg_109_1:FormatText(var_112_9.content)

				arg_109_1.text_.text = var_112_10

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_11 = 21
				local var_112_12 = utf8.len(var_112_10)
				local var_112_13 = var_112_11 <= 0 and var_112_7 or var_112_7 * (var_112_12 / var_112_11)

				if var_112_13 > 0 and var_112_7 < var_112_13 then
					arg_109_1.talkMaxDuration = var_112_13

					if var_112_13 + var_112_6 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_13 + var_112_6
					end
				end

				arg_109_1.text_.text = var_112_10
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)
				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_14 = math.max(var_112_7, arg_109_1.talkMaxDuration)

			if var_112_6 <= arg_109_1.time_ and arg_109_1.time_ < var_112_6 + var_112_14 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_6) / var_112_14

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_6 + var_112_14 and arg_109_1.time_ < var_112_6 + var_112_14 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play420052026 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 420052026
		arg_113_1.duration_ = 13.73

		local var_113_0 = {
			zh = 10.366,
			ja = 13.733
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
				arg_113_0:Play420052027(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = arg_113_1.actors_["1085ui_story"]
			local var_116_1 = 0

			if var_116_1 < arg_113_1.time_ and arg_113_1.time_ <= var_116_1 + arg_116_0 and not isNil(var_116_0) and arg_113_1.var_.characterEffect1085ui_story == nil then
				arg_113_1.var_.characterEffect1085ui_story = var_116_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_2 = 0.200000002980232

			if var_116_1 <= arg_113_1.time_ and arg_113_1.time_ < var_116_1 + var_116_2 and not isNil(var_116_0) then
				local var_116_3 = (arg_113_1.time_ - var_116_1) / var_116_2

				if arg_113_1.var_.characterEffect1085ui_story and not isNil(var_116_0) then
					arg_113_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_113_1.time_ >= var_116_1 + var_116_2 and arg_113_1.time_ < var_116_1 + var_116_2 + arg_116_0 and not isNil(var_116_0) and arg_113_1.var_.characterEffect1085ui_story then
				arg_113_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_116_4 = 0

			if var_116_4 < arg_113_1.time_ and arg_113_1.time_ <= var_116_4 + arg_116_0 then
				arg_113_1.allBtn_.enabled = false
			end

			local var_116_5 = 0.766666666666667

			if arg_113_1.time_ >= var_116_4 + var_116_5 and arg_113_1.time_ < var_116_4 + var_116_5 + arg_116_0 then
				arg_113_1.allBtn_.enabled = true
			end

			local var_116_6 = 0
			local var_116_7 = 0.925

			if var_116_6 < arg_113_1.time_ and arg_113_1.time_ <= var_116_6 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				local var_116_8 = arg_113_1:FormatText(StoryNameCfg[328].name)

				arg_113_1.leftNameTxt_.text = var_116_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_9 = arg_113_1:GetWordFromCfg(420052026)
				local var_116_10 = arg_113_1:FormatText(var_116_9.content)

				arg_113_1.text_.text = var_116_10

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_11 = 37
				local var_116_12 = utf8.len(var_116_10)
				local var_116_13 = var_116_11 <= 0 and var_116_7 or var_116_7 * (var_116_12 / var_116_11)

				if var_116_13 > 0 and var_116_7 < var_116_13 then
					arg_113_1.talkMaxDuration = var_116_13

					if var_116_13 + var_116_6 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_13 + var_116_6
					end
				end

				arg_113_1.text_.text = var_116_10
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420052", "420052026", "story_v_out_420052.awb") ~= 0 then
					local var_116_14 = manager.audio:GetVoiceLength("story_v_out_420052", "420052026", "story_v_out_420052.awb") / 1000

					if var_116_14 + var_116_6 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_14 + var_116_6
					end

					if var_116_9.prefab_name ~= "" and arg_113_1.actors_[var_116_9.prefab_name] ~= nil then
						local var_116_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_9.prefab_name].transform, "story_v_out_420052", "420052026", "story_v_out_420052.awb")

						arg_113_1:RecordAudio("420052026", var_116_15)
						arg_113_1:RecordAudio("420052026", var_116_15)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_420052", "420052026", "story_v_out_420052.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_420052", "420052026", "story_v_out_420052.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_16 = math.max(var_116_7, arg_113_1.talkMaxDuration)

			if var_116_6 <= arg_113_1.time_ and arg_113_1.time_ < var_116_6 + var_116_16 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_6) / var_116_16

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_6 + var_116_16 and arg_113_1.time_ < var_116_6 + var_116_16 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play420052027 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 420052027
		arg_117_1.duration_ = 5

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play420052028(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = arg_117_1.actors_["1085ui_story"]
			local var_120_1 = 0

			if var_120_1 < arg_117_1.time_ and arg_117_1.time_ <= var_120_1 + arg_120_0 and not isNil(var_120_0) and arg_117_1.var_.characterEffect1085ui_story == nil then
				arg_117_1.var_.characterEffect1085ui_story = var_120_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_2 = 0.200000002980232

			if var_120_1 <= arg_117_1.time_ and arg_117_1.time_ < var_120_1 + var_120_2 and not isNil(var_120_0) then
				local var_120_3 = (arg_117_1.time_ - var_120_1) / var_120_2

				if arg_117_1.var_.characterEffect1085ui_story and not isNil(var_120_0) then
					local var_120_4 = Mathf.Lerp(0, 0.5, var_120_3)

					arg_117_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_117_1.var_.characterEffect1085ui_story.fillRatio = var_120_4
				end
			end

			if arg_117_1.time_ >= var_120_1 + var_120_2 and arg_117_1.time_ < var_120_1 + var_120_2 + arg_120_0 and not isNil(var_120_0) and arg_117_1.var_.characterEffect1085ui_story then
				local var_120_5 = 0.5

				arg_117_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_117_1.var_.characterEffect1085ui_story.fillRatio = var_120_5
			end

			local var_120_6 = 0
			local var_120_7 = 0.55

			if var_120_6 < arg_117_1.time_ and arg_117_1.time_ <= var_120_6 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				local var_120_8 = arg_117_1:FormatText(StoryNameCfg[7].name)

				arg_117_1.leftNameTxt_.text = var_120_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, true)
				arg_117_1.iconController_:SetSelectedState("hero")

				arg_117_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_117_1.callingController_:SetSelectedState("normal")

				arg_117_1.keyicon_.color = Color.New(1, 1, 1)
				arg_117_1.icon_.color = Color.New(1, 1, 1)

				local var_120_9 = arg_117_1:GetWordFromCfg(420052027)
				local var_120_10 = arg_117_1:FormatText(var_120_9.content)

				arg_117_1.text_.text = var_120_10

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_11 = 22
				local var_120_12 = utf8.len(var_120_10)
				local var_120_13 = var_120_11 <= 0 and var_120_7 or var_120_7 * (var_120_12 / var_120_11)

				if var_120_13 > 0 and var_120_7 < var_120_13 then
					arg_117_1.talkMaxDuration = var_120_13

					if var_120_13 + var_120_6 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_13 + var_120_6
					end
				end

				arg_117_1.text_.text = var_120_10
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)
				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_14 = math.max(var_120_7, arg_117_1.talkMaxDuration)

			if var_120_6 <= arg_117_1.time_ and arg_117_1.time_ < var_120_6 + var_120_14 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_6) / var_120_14

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_6 + var_120_14 and arg_117_1.time_ < var_120_6 + var_120_14 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play420052028 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 420052028
		arg_121_1.duration_ = 5

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play420052029(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = 0
			local var_124_1 = 0.725

			if var_124_0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_0 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				local var_124_2 = arg_121_1:FormatText(StoryNameCfg[7].name)

				arg_121_1.leftNameTxt_.text = var_124_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, true)
				arg_121_1.iconController_:SetSelectedState("hero")

				arg_121_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_121_1.callingController_:SetSelectedState("normal")

				arg_121_1.keyicon_.color = Color.New(1, 1, 1)
				arg_121_1.icon_.color = Color.New(1, 1, 1)

				local var_124_3 = arg_121_1:GetWordFromCfg(420052028)
				local var_124_4 = arg_121_1:FormatText(var_124_3.content)

				arg_121_1.text_.text = var_124_4

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_5 = 29
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
				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_8 = math.max(var_124_1, arg_121_1.talkMaxDuration)

			if var_124_0 <= arg_121_1.time_ and arg_121_1.time_ < var_124_0 + var_124_8 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_0) / var_124_8

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_0 + var_124_8 and arg_121_1.time_ < var_124_0 + var_124_8 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play420052029 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 420052029
		arg_125_1.duration_ = 5

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play420052030(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = 0
			local var_128_1 = 0.55

			if var_128_0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_0 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				local var_128_2 = arg_125_1:FormatText(StoryNameCfg[7].name)

				arg_125_1.leftNameTxt_.text = var_128_2

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

				local var_128_3 = arg_125_1:GetWordFromCfg(420052029)
				local var_128_4 = arg_125_1:FormatText(var_128_3.content)

				arg_125_1.text_.text = var_128_4

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_5 = 22
				local var_128_6 = utf8.len(var_128_4)
				local var_128_7 = var_128_5 <= 0 and var_128_1 or var_128_1 * (var_128_6 / var_128_5)

				if var_128_7 > 0 and var_128_1 < var_128_7 then
					arg_125_1.talkMaxDuration = var_128_7

					if var_128_7 + var_128_0 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_7 + var_128_0
					end
				end

				arg_125_1.text_.text = var_128_4
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)
				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_8 = math.max(var_128_1, arg_125_1.talkMaxDuration)

			if var_128_0 <= arg_125_1.time_ and arg_125_1.time_ < var_128_0 + var_128_8 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_0) / var_128_8

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_0 + var_128_8 and arg_125_1.time_ < var_128_0 + var_128_8 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play420052030 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 420052030
		arg_129_1.duration_ = 2

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play420052031(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = arg_129_1.actors_["1085ui_story"]
			local var_132_1 = 0

			if var_132_1 < arg_129_1.time_ and arg_129_1.time_ <= var_132_1 + arg_132_0 and not isNil(var_132_0) and arg_129_1.var_.characterEffect1085ui_story == nil then
				arg_129_1.var_.characterEffect1085ui_story = var_132_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_2 = 0.200000002980232

			if var_132_1 <= arg_129_1.time_ and arg_129_1.time_ < var_132_1 + var_132_2 and not isNil(var_132_0) then
				local var_132_3 = (arg_129_1.time_ - var_132_1) / var_132_2

				if arg_129_1.var_.characterEffect1085ui_story and not isNil(var_132_0) then
					arg_129_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_129_1.time_ >= var_132_1 + var_132_2 and arg_129_1.time_ < var_132_1 + var_132_2 + arg_132_0 and not isNil(var_132_0) and arg_129_1.var_.characterEffect1085ui_story then
				arg_129_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_132_4 = 0

			if var_132_4 < arg_129_1.time_ and arg_129_1.time_ <= var_132_4 + arg_132_0 then
				arg_129_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_132_5 = 0

			if var_132_5 < arg_129_1.time_ and arg_129_1.time_ <= var_132_5 + arg_132_0 then
				arg_129_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action4_1")
			end

			local var_132_6 = 0
			local var_132_7 = 0.1

			if var_132_6 < arg_129_1.time_ and arg_129_1.time_ <= var_132_6 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				local var_132_8 = arg_129_1:FormatText(StoryNameCfg[328].name)

				arg_129_1.leftNameTxt_.text = var_132_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_9 = arg_129_1:GetWordFromCfg(420052030)
				local var_132_10 = arg_129_1:FormatText(var_132_9.content)

				arg_129_1.text_.text = var_132_10

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_11 = 4
				local var_132_12 = utf8.len(var_132_10)
				local var_132_13 = var_132_11 <= 0 and var_132_7 or var_132_7 * (var_132_12 / var_132_11)

				if var_132_13 > 0 and var_132_7 < var_132_13 then
					arg_129_1.talkMaxDuration = var_132_13

					if var_132_13 + var_132_6 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_13 + var_132_6
					end
				end

				arg_129_1.text_.text = var_132_10
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420052", "420052030", "story_v_out_420052.awb") ~= 0 then
					local var_132_14 = manager.audio:GetVoiceLength("story_v_out_420052", "420052030", "story_v_out_420052.awb") / 1000

					if var_132_14 + var_132_6 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_14 + var_132_6
					end

					if var_132_9.prefab_name ~= "" and arg_129_1.actors_[var_132_9.prefab_name] ~= nil then
						local var_132_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_9.prefab_name].transform, "story_v_out_420052", "420052030", "story_v_out_420052.awb")

						arg_129_1:RecordAudio("420052030", var_132_15)
						arg_129_1:RecordAudio("420052030", var_132_15)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_420052", "420052030", "story_v_out_420052.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_420052", "420052030", "story_v_out_420052.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_16 = math.max(var_132_7, arg_129_1.talkMaxDuration)

			if var_132_6 <= arg_129_1.time_ and arg_129_1.time_ < var_132_6 + var_132_16 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_6) / var_132_16

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_6 + var_132_16 and arg_129_1.time_ < var_132_6 + var_132_16 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play420052031 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 420052031
		arg_133_1.duration_ = 4.37

		local var_133_0 = {
			zh = 3.166,
			ja = 4.366
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
				arg_133_0:Play420052032(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = 0

			if var_136_0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_0 + arg_136_0 then
				arg_133_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_136_1 = 0

			if var_136_1 < arg_133_1.time_ and arg_133_1.time_ <= var_136_1 + arg_136_0 then
				arg_133_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action4_2")
			end

			local var_136_2 = 0

			if var_136_2 < arg_133_1.time_ and arg_133_1.time_ <= var_136_2 + arg_136_0 then
				arg_133_1.allBtn_.enabled = false
			end

			local var_136_3 = 0.766666666666667

			if arg_133_1.time_ >= var_136_2 + var_136_3 and arg_133_1.time_ < var_136_2 + var_136_3 + arg_136_0 then
				arg_133_1.allBtn_.enabled = true
			end

			local var_136_4 = 0
			local var_136_5 = 0.2

			if var_136_4 < arg_133_1.time_ and arg_133_1.time_ <= var_136_4 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				local var_136_6 = arg_133_1:FormatText(StoryNameCfg[328].name)

				arg_133_1.leftNameTxt_.text = var_136_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_7 = arg_133_1:GetWordFromCfg(420052031)
				local var_136_8 = arg_133_1:FormatText(var_136_7.content)

				arg_133_1.text_.text = var_136_8

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_9 = 8
				local var_136_10 = utf8.len(var_136_8)
				local var_136_11 = var_136_9 <= 0 and var_136_5 or var_136_5 * (var_136_10 / var_136_9)

				if var_136_11 > 0 and var_136_5 < var_136_11 then
					arg_133_1.talkMaxDuration = var_136_11

					if var_136_11 + var_136_4 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_11 + var_136_4
					end
				end

				arg_133_1.text_.text = var_136_8
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420052", "420052031", "story_v_out_420052.awb") ~= 0 then
					local var_136_12 = manager.audio:GetVoiceLength("story_v_out_420052", "420052031", "story_v_out_420052.awb") / 1000

					if var_136_12 + var_136_4 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_12 + var_136_4
					end

					if var_136_7.prefab_name ~= "" and arg_133_1.actors_[var_136_7.prefab_name] ~= nil then
						local var_136_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_7.prefab_name].transform, "story_v_out_420052", "420052031", "story_v_out_420052.awb")

						arg_133_1:RecordAudio("420052031", var_136_13)
						arg_133_1:RecordAudio("420052031", var_136_13)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_420052", "420052031", "story_v_out_420052.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_420052", "420052031", "story_v_out_420052.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_14 = math.max(var_136_5, arg_133_1.talkMaxDuration)

			if var_136_4 <= arg_133_1.time_ and arg_133_1.time_ < var_136_4 + var_136_14 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_4) / var_136_14

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_4 + var_136_14 and arg_133_1.time_ < var_136_4 + var_136_14 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play420052032 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 420052032
		arg_137_1.duration_ = 5

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play420052033(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = arg_137_1.actors_["1085ui_story"].transform
			local var_140_1 = 0

			if var_140_1 < arg_137_1.time_ and arg_137_1.time_ <= var_140_1 + arg_140_0 then
				arg_137_1.var_.moveOldPos1085ui_story = var_140_0.localPosition
			end

			local var_140_2 = 0.001

			if var_140_1 <= arg_137_1.time_ and arg_137_1.time_ < var_140_1 + var_140_2 then
				local var_140_3 = (arg_137_1.time_ - var_140_1) / var_140_2
				local var_140_4 = Vector3.New(0, 100, 0)

				var_140_0.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos1085ui_story, var_140_4, var_140_3)

				local var_140_5 = manager.ui.mainCamera.transform.position - var_140_0.position

				var_140_0.forward = Vector3.New(var_140_5.x, var_140_5.y, var_140_5.z)

				local var_140_6 = var_140_0.localEulerAngles

				var_140_6.z = 0
				var_140_6.x = 0
				var_140_0.localEulerAngles = var_140_6
			end

			if arg_137_1.time_ >= var_140_1 + var_140_2 and arg_137_1.time_ < var_140_1 + var_140_2 + arg_140_0 then
				var_140_0.localPosition = Vector3.New(0, 100, 0)

				local var_140_7 = manager.ui.mainCamera.transform.position - var_140_0.position

				var_140_0.forward = Vector3.New(var_140_7.x, var_140_7.y, var_140_7.z)

				local var_140_8 = var_140_0.localEulerAngles

				var_140_8.z = 0
				var_140_8.x = 0
				var_140_0.localEulerAngles = var_140_8
			end

			local var_140_9 = 0
			local var_140_10 = 0.8

			if var_140_9 < arg_137_1.time_ and arg_137_1.time_ <= var_140_9 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, false)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_11 = arg_137_1:GetWordFromCfg(420052032)
				local var_140_12 = arg_137_1:FormatText(var_140_11.content)

				arg_137_1.text_.text = var_140_12

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_13 = 32
				local var_140_14 = utf8.len(var_140_12)
				local var_140_15 = var_140_13 <= 0 and var_140_10 or var_140_10 * (var_140_14 / var_140_13)

				if var_140_15 > 0 and var_140_10 < var_140_15 then
					arg_137_1.talkMaxDuration = var_140_15

					if var_140_15 + var_140_9 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_15 + var_140_9
					end
				end

				arg_137_1.text_.text = var_140_12
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)
				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_16 = math.max(var_140_10, arg_137_1.talkMaxDuration)

			if var_140_9 <= arg_137_1.time_ and arg_137_1.time_ < var_140_9 + var_140_16 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_9) / var_140_16

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_9 + var_140_16 and arg_137_1.time_ < var_140_9 + var_140_16 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_137_1:InitPlayNodeList()
	end,
	Play420052033 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 420052033
		arg_141_1.duration_ = 5

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
			arg_141_1.auto_ = false
		end

		function arg_141_1.playNext_(arg_143_0)
			arg_141_1.onStoryFinished_()
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = 0
			local var_144_1 = 0.3

			if var_144_0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_0 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, false)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_2 = arg_141_1:GetWordFromCfg(420052033)
				local var_144_3 = arg_141_1:FormatText(var_144_2.content)

				arg_141_1.text_.text = var_144_3

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_4 = 12
				local var_144_5 = utf8.len(var_144_3)
				local var_144_6 = var_144_4 <= 0 and var_144_1 or var_144_1 * (var_144_5 / var_144_4)

				if var_144_6 > 0 and var_144_1 < var_144_6 then
					arg_141_1.talkMaxDuration = var_144_6

					if var_144_6 + var_144_0 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_6 + var_144_0
					end
				end

				arg_141_1.text_.text = var_144_3
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)
				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_7 = math.max(var_144_1, arg_141_1.talkMaxDuration)

			if var_144_0 <= arg_141_1.time_ and arg_141_1.time_ < var_144_0 + var_144_7 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_0) / var_144_7

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_0 + var_144_7 and arg_141_1.time_ < var_144_0 + var_144_7 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/L16I",
		"TextureConfig/Background/STwhite"
	},
	voices = {
		"story_v_out_420052.awb"
	}
}
