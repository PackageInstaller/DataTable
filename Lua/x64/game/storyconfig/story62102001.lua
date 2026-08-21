return {
	Play62102001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 62102001
		arg_1_1.duration_ = 7.47

		local var_1_0 = {
			ja = 5.533,
			ko = 7.466,
			zh = 5.6,
			en = 6.2
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
				arg_1_0:Play62101002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "B06h"

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
				local var_4_5 = arg_1_1.bgs_.B06h

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
					if iter_4_0 ~= "B06h" then
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

			local var_4_22 = "2030_tpose"

			if arg_1_1.actors_[var_4_22] == nil then
				local var_4_23 = Asset.Load("Char/" .. "2030_tpose")

				if not isNil(var_4_23) then
					local var_4_24 = Object.Instantiate(Asset.Load("Char/" .. "2030_tpose"), arg_1_1.stage_.transform)

					var_4_24.name = var_4_22
					var_4_24.transform.localPosition = Vector3.New(0, 100, 0)
					arg_1_1.actors_[var_4_22] = var_4_24

					local var_4_25 = var_4_24:GetComponentInChildren(typeof(CharacterEffect))

					var_4_25.enabled = true

					local var_4_26 = GameObjectTools.GetOrAddComponent(var_4_24, typeof(DynamicBoneHelper))

					if var_4_26 then
						var_4_26:EnableDynamicBone(false)
					end

					arg_1_1:ShowWeapon(var_4_25.transform, false)

					arg_1_1.var_[var_4_22 .. "Animator"] = var_4_25.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_1_1.var_[var_4_22 .. "Animator"].applyRootMotion = true
					arg_1_1.var_[var_4_22 .. "LipSync"] = var_4_25.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_4_27 = arg_1_1.actors_["2030_tpose"].transform
			local var_4_28 = 2

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				arg_1_1.var_.moveOldPos2030_tpose = var_4_27.localPosition

				local var_4_29 = GameObjectTools.GetOrAddComponent(var_4_27.gameObject, typeof(DynamicBoneHelper))

				if var_4_29 then
					var_4_29:EnableDynamicBone(false)
				end
			end

			local var_4_30 = 0.001

			if var_4_28 <= arg_1_1.time_ and arg_1_1.time_ < var_4_28 + var_4_30 then
				local var_4_31 = (arg_1_1.time_ - var_4_28) / var_4_30
				local var_4_32 = Vector3.New(0, -1.2, -4.2)

				var_4_27.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos2030_tpose, var_4_32, var_4_31)

				local var_4_33 = manager.ui.mainCamera.transform.position - var_4_27.position

				var_4_27.forward = Vector3.New(var_4_33.x, var_4_33.y, var_4_33.z)

				local var_4_34 = var_4_27.localEulerAngles

				var_4_34.z = 0
				var_4_34.x = 0
				var_4_27.localEulerAngles = var_4_34
			end

			if arg_1_1.time_ >= var_4_28 + var_4_30 and arg_1_1.time_ < var_4_28 + var_4_30 + arg_4_0 then
				var_4_27.localPosition = Vector3.New(0, -1.2, -4.2)

				local var_4_35 = manager.ui.mainCamera.transform.position - var_4_27.position

				var_4_27.forward = Vector3.New(var_4_35.x, var_4_35.y, var_4_35.z)

				local var_4_36 = var_4_27.localEulerAngles

				var_4_36.z = 0
				var_4_36.x = 0
				var_4_27.localEulerAngles = var_4_36

				local var_4_37 = GameObjectTools.GetOrAddComponent(var_4_27.gameObject, typeof(DynamicBoneHelper))

				if var_4_37 then
					var_4_37:EnableDynamicBone(true)
				end
			end

			local var_4_38 = 2

			if var_4_38 < arg_1_1.time_ and arg_1_1.time_ <= var_4_38 + arg_4_0 then
				arg_1_1:PlayTimeline("2030_tpose", "StoryTimeline/CharAction/story2030/story2030action/2030action1_1")
			end

			local var_4_39 = arg_1_1.actors_["2030_tpose"]
			local var_4_40 = 2

			if var_4_40 < arg_1_1.time_ and arg_1_1.time_ <= var_4_40 + arg_4_0 and not isNil(var_4_39) and arg_1_1.var_.characterEffect2030_tpose == nil then
				arg_1_1.var_.characterEffect2030_tpose = var_4_39:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_41 = 0.2

			if var_4_40 <= arg_1_1.time_ and arg_1_1.time_ < var_4_40 + var_4_41 and not isNil(var_4_39) then
				local var_4_42 = (arg_1_1.time_ - var_4_40) / var_4_41

				if arg_1_1.var_.characterEffect2030_tpose and not isNil(var_4_39) then
					arg_1_1.var_.characterEffect2030_tpose.fillFlat = false
				end
			end

			if arg_1_1.time_ >= var_4_40 + var_4_41 and arg_1_1.time_ < var_4_40 + var_4_41 + arg_4_0 and not isNil(var_4_39) and arg_1_1.var_.characterEffect2030_tpose then
				arg_1_1.var_.characterEffect2030_tpose.fillFlat = false
			end

			local var_4_43 = 0
			local var_4_44 = 0.333333333333333

			if var_4_43 < arg_1_1.time_ and arg_1_1.time_ <= var_4_43 + arg_4_0 then
				local var_4_45 = "play"
				local var_4_46 = "music"

				arg_1_1:AudioAction(var_4_45, var_4_46, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_47 = ""
				local var_4_48 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_48 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_48 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_48

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_48
						arg_1_1.bgmTxt2_.text = var_4_48
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

			local var_4_49 = 0.5
			local var_4_50 = 2.45666666666667

			if var_4_49 < arg_1_1.time_ and arg_1_1.time_ <= var_4_49 + arg_4_0 then
				local var_4_51 = "play"
				local var_4_52 = "music"

				arg_1_1:AudioAction(var_4_51, var_4_52, "bgm_activity_1_0_1_osiris_ui", "bgm_activity_1_0_1_osiris_ui", "bgm_activity_1_0_1_osiris_ui.awb")

				local var_4_53 = ""
				local var_4_54 = manager.audio:GetAudioName("bgm_activity_1_0_1_osiris_ui", "bgm_activity_1_0_1_osiris_ui")

				if var_4_54 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_54 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_54

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_54
						arg_1_1.bgmTxt2_.text = var_4_54
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

			local var_4_55 = 2
			local var_4_56 = 0.45

			if var_4_55 < arg_1_1.time_ and arg_1_1.time_ <= var_4_55 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_57 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_57:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_57:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_57:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_58 = arg_1_1:FormatText(StoryNameCfg[34].name)

				arg_1_1.leftNameTxt_.text = var_4_58

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_59 = arg_1_1:GetWordFromCfg(62102001)
				local var_4_60 = arg_1_1:FormatText(var_4_59.content)

				arg_1_1.text_.text = var_4_60

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_61 = 18
				local var_4_62 = utf8.len(var_4_60)
				local var_4_63 = var_4_61 <= 0 and var_4_56 or var_4_56 * (var_4_62 / var_4_61)

				if var_4_63 > 0 and var_4_56 < var_4_63 then
					arg_1_1.talkMaxDuration = var_4_63
					var_4_55 = var_4_55 + 0.3

					if var_4_63 + var_4_55 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_63 + var_4_55
					end
				end

				arg_1_1.text_.text = var_4_60
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_chess_62102", "62102001", "story_v_chess_62102.awb") ~= 0 then
					local var_4_64 = manager.audio:GetVoiceLength("story_v_chess_62102", "62102001", "story_v_chess_62102.awb") / 1000

					if var_4_64 + var_4_55 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_64 + var_4_55
					end

					if var_4_59.prefab_name ~= "" and arg_1_1.actors_[var_4_59.prefab_name] ~= nil then
						local var_4_65 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_59.prefab_name].transform, "story_v_chess_62102", "62102001", "story_v_chess_62102.awb")

						arg_1_1:RecordAudio("62102001", var_4_65)
						arg_1_1:RecordAudio("62102001", var_4_65)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_chess_62102", "62102001", "story_v_chess_62102.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_chess_62102", "62102001", "story_v_chess_62102.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_66 = var_4_55 + 0.3
			local var_4_67 = math.max(var_4_56, arg_1_1.talkMaxDuration)

			if var_4_66 <= arg_1_1.time_ and arg_1_1.time_ < var_4_66 + var_4_67 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_66) / var_4_67

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_66 + var_4_67 and arg_1_1.time_ < var_4_66 + var_4_67 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2030_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play62101002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 62101002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play62101003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = arg_9_1.actors_["2030_tpose"]
			local var_12_1 = 0

			if var_12_1 < arg_9_1.time_ and arg_9_1.time_ <= var_12_1 + arg_12_0 and not isNil(var_12_0) and arg_9_1.var_.characterEffect2030_tpose == nil then
				arg_9_1.var_.characterEffect2030_tpose = var_12_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_2 = 0.2

			if var_12_1 <= arg_9_1.time_ and arg_9_1.time_ < var_12_1 + var_12_2 and not isNil(var_12_0) then
				local var_12_3 = (arg_9_1.time_ - var_12_1) / var_12_2

				if arg_9_1.var_.characterEffect2030_tpose and not isNil(var_12_0) then
					local var_12_4 = Mathf.Lerp(0, 0.5, var_12_3)

					arg_9_1.var_.characterEffect2030_tpose.fillFlat = true
					arg_9_1.var_.characterEffect2030_tpose.fillRatio = var_12_4
				end
			end

			if arg_9_1.time_ >= var_12_1 + var_12_2 and arg_9_1.time_ < var_12_1 + var_12_2 + arg_12_0 and not isNil(var_12_0) and arg_9_1.var_.characterEffect2030_tpose then
				local var_12_5 = 0.5

				arg_9_1.var_.characterEffect2030_tpose.fillFlat = true
				arg_9_1.var_.characterEffect2030_tpose.fillRatio = var_12_5
			end

			local var_12_6 = 0
			local var_12_7 = 0.6

			if var_12_6 < arg_9_1.time_ and arg_9_1.time_ <= var_12_6 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_8 = arg_9_1:FormatText(StoryNameCfg[7].name)

				arg_9_1.leftNameTxt_.text = var_12_8

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

				local var_12_9 = arg_9_1:GetWordFromCfg(62102002)
				local var_12_10 = arg_9_1:FormatText(var_12_9.content)

				arg_9_1.text_.text = var_12_10

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_11 = 24
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
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_14 = math.max(var_12_7, arg_9_1.talkMaxDuration)

			if var_12_6 <= arg_9_1.time_ and arg_9_1.time_ < var_12_6 + var_12_14 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_6) / var_12_14

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_6 + var_12_14 and arg_9_1.time_ < var_12_6 + var_12_14 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play62101003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 62101003
		arg_13_1.duration_ = 6.87

		local var_13_0 = {
			ja = 6.7,
			ko = 6.866,
			zh = 6.3,
			en = 3.533
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
			arg_13_1.auto_ = false
		end

		function arg_13_1.playNext_(arg_15_0)
			arg_13_1.onStoryFinished_()
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = "1111ui_story"

			if arg_13_1.actors_[var_16_0] == nil then
				local var_16_1 = Asset.Load("Char/" .. "1111ui_story")

				if not isNil(var_16_1) then
					local var_16_2 = Object.Instantiate(Asset.Load("Char/" .. "1111ui_story"), arg_13_1.stage_.transform)

					var_16_2.name = var_16_0
					var_16_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_13_1.actors_[var_16_0] = var_16_2

					local var_16_3 = var_16_2:GetComponentInChildren(typeof(CharacterEffect))

					var_16_3.enabled = true

					local var_16_4 = GameObjectTools.GetOrAddComponent(var_16_2, typeof(DynamicBoneHelper))

					if var_16_4 then
						var_16_4:EnableDynamicBone(false)
					end

					arg_13_1:ShowWeapon(var_16_3.transform, false)

					arg_13_1.var_[var_16_0 .. "Animator"] = var_16_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_13_1.var_[var_16_0 .. "Animator"].applyRootMotion = true
					arg_13_1.var_[var_16_0 .. "LipSync"] = var_16_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_16_5 = arg_13_1.actors_["1111ui_story"].transform
			local var_16_6 = 0

			if var_16_6 < arg_13_1.time_ and arg_13_1.time_ <= var_16_6 + arg_16_0 then
				arg_13_1.var_.moveOldPos1111ui_story = var_16_5.localPosition
			end

			local var_16_7 = 0.001

			if var_16_6 <= arg_13_1.time_ and arg_13_1.time_ < var_16_6 + var_16_7 then
				local var_16_8 = (arg_13_1.time_ - var_16_6) / var_16_7
				local var_16_9 = Vector3.New(0, -0.87, -5.7)

				var_16_5.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1111ui_story, var_16_9, var_16_8)

				local var_16_10 = manager.ui.mainCamera.transform.position - var_16_5.position

				var_16_5.forward = Vector3.New(var_16_10.x, var_16_10.y, var_16_10.z)

				local var_16_11 = var_16_5.localEulerAngles

				var_16_11.z = 0
				var_16_11.x = 0
				var_16_5.localEulerAngles = var_16_11
			end

			if arg_13_1.time_ >= var_16_6 + var_16_7 and arg_13_1.time_ < var_16_6 + var_16_7 + arg_16_0 then
				var_16_5.localPosition = Vector3.New(0, -0.87, -5.7)

				local var_16_12 = manager.ui.mainCamera.transform.position - var_16_5.position

				var_16_5.forward = Vector3.New(var_16_12.x, var_16_12.y, var_16_12.z)

				local var_16_13 = var_16_5.localEulerAngles

				var_16_13.z = 0
				var_16_13.x = 0
				var_16_5.localEulerAngles = var_16_13
			end

			local var_16_14 = arg_13_1.actors_["1111ui_story"]
			local var_16_15 = 0

			if var_16_15 < arg_13_1.time_ and arg_13_1.time_ <= var_16_15 + arg_16_0 and not isNil(var_16_14) and arg_13_1.var_.characterEffect1111ui_story == nil then
				arg_13_1.var_.characterEffect1111ui_story = var_16_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_16 = 0.2

			if var_16_15 <= arg_13_1.time_ and arg_13_1.time_ < var_16_15 + var_16_16 and not isNil(var_16_14) then
				local var_16_17 = (arg_13_1.time_ - var_16_15) / var_16_16

				if arg_13_1.var_.characterEffect1111ui_story and not isNil(var_16_14) then
					arg_13_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= var_16_15 + var_16_16 and arg_13_1.time_ < var_16_15 + var_16_16 + arg_16_0 and not isNil(var_16_14) and arg_13_1.var_.characterEffect1111ui_story then
				arg_13_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_16_18 = arg_13_1.actors_["2030_tpose"].transform
			local var_16_19 = 0

			if var_16_19 < arg_13_1.time_ and arg_13_1.time_ <= var_16_19 + arg_16_0 then
				arg_13_1.var_.moveOldPos2030_tpose = var_16_18.localPosition

				local var_16_20 = GameObjectTools.GetOrAddComponent(var_16_18.gameObject, typeof(DynamicBoneHelper))

				if var_16_20 then
					var_16_20:EnableDynamicBone(false)
				end
			end

			local var_16_21 = 0.001

			if var_16_19 <= arg_13_1.time_ and arg_13_1.time_ < var_16_19 + var_16_21 then
				local var_16_22 = (arg_13_1.time_ - var_16_19) / var_16_21
				local var_16_23 = Vector3.New(0, 100, 0)

				var_16_18.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos2030_tpose, var_16_23, var_16_22)

				local var_16_24 = manager.ui.mainCamera.transform.position - var_16_18.position

				var_16_18.forward = Vector3.New(var_16_24.x, var_16_24.y, var_16_24.z)

				local var_16_25 = var_16_18.localEulerAngles

				var_16_25.z = 0
				var_16_25.x = 0
				var_16_18.localEulerAngles = var_16_25
			end

			if arg_13_1.time_ >= var_16_19 + var_16_21 and arg_13_1.time_ < var_16_19 + var_16_21 + arg_16_0 then
				var_16_18.localPosition = Vector3.New(0, 100, 0)

				local var_16_26 = manager.ui.mainCamera.transform.position - var_16_18.position

				var_16_18.forward = Vector3.New(var_16_26.x, var_16_26.y, var_16_26.z)

				local var_16_27 = var_16_18.localEulerAngles

				var_16_27.z = 0
				var_16_27.x = 0
				var_16_18.localEulerAngles = var_16_27

				local var_16_28 = GameObjectTools.GetOrAddComponent(var_16_18.gameObject, typeof(DynamicBoneHelper))

				if var_16_28 then
					var_16_28:EnableDynamicBone(true)
				end
			end

			local var_16_29 = 0

			if var_16_29 < arg_13_1.time_ and arg_13_1.time_ <= var_16_29 + arg_16_0 then
				arg_13_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action4_1")
			end

			local var_16_30 = 0

			if var_16_30 < arg_13_1.time_ and arg_13_1.time_ <= var_16_30 + arg_16_0 then
				arg_13_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_16_31 = 0
			local var_16_32 = 0.7

			if var_16_31 < arg_13_1.time_ and arg_13_1.time_ <= var_16_31 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_33 = arg_13_1:FormatText(StoryNameCfg[67].name)

				arg_13_1.leftNameTxt_.text = var_16_33

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_34 = arg_13_1:GetWordFromCfg(62102003)
				local var_16_35 = arg_13_1:FormatText(var_16_34.content)

				arg_13_1.text_.text = var_16_35

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_36 = 28
				local var_16_37 = utf8.len(var_16_35)
				local var_16_38 = var_16_36 <= 0 and var_16_32 or var_16_32 * (var_16_37 / var_16_36)

				if var_16_38 > 0 and var_16_32 < var_16_38 then
					arg_13_1.talkMaxDuration = var_16_38

					if var_16_38 + var_16_31 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_38 + var_16_31
					end
				end

				arg_13_1.text_.text = var_16_35
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_chess_62102", "62102003", "story_v_chess_62102.awb") ~= 0 then
					local var_16_39 = manager.audio:GetVoiceLength("story_v_chess_62102", "62102003", "story_v_chess_62102.awb") / 1000

					if var_16_39 + var_16_31 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_39 + var_16_31
					end

					if var_16_34.prefab_name ~= "" and arg_13_1.actors_[var_16_34.prefab_name] ~= nil then
						local var_16_40 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_34.prefab_name].transform, "story_v_chess_62102", "62102003", "story_v_chess_62102.awb")

						arg_13_1:RecordAudio("62102003", var_16_40)
						arg_13_1:RecordAudio("62102003", var_16_40)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_chess_62102", "62102003", "story_v_chess_62102.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_chess_62102", "62102003", "story_v_chess_62102.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_41 = math.max(var_16_32, arg_13_1.talkMaxDuration)

			if var_16_31 <= arg_13_1.time_ and arg_13_1.time_ < var_16_31 + var_16_41 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_31) / var_16_41

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_31 + var_16_41 and arg_13_1.time_ < var_16_31 + var_16_41 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "2030_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_13_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/B06h"
	},
	voices = {
		"story_v_chess_62102.awb"
	}
}
