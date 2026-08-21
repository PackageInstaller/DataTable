return {
	Play107112001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 107112001
		arg_1_1.duration_ = 7.2

		local var_1_0 = {
			ja = 5.433,
			ko = 5.666,
			zh = 5.6,
			en = 7.2
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
				arg_1_0:Play107112002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "3007_tpose"

			if arg_1_1.actors_[var_4_0] == nil then
				local var_4_1 = Asset.Load("Char/" .. "3007_tpose")

				if not isNil(var_4_1) then
					local var_4_2 = Object.Instantiate(Asset.Load("Char/" .. "3007_tpose"), arg_1_1.stage_.transform)

					var_4_2.name = var_4_0
					var_4_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_1_1.actors_[var_4_0] = var_4_2

					local var_4_3 = var_4_2:GetComponentInChildren(typeof(CharacterEffect))

					var_4_3.enabled = true

					local var_4_4 = GameObjectTools.GetOrAddComponent(var_4_2, typeof(DynamicBoneHelper))

					if var_4_4 then
						var_4_4:EnableDynamicBone(false)
					end

					arg_1_1:ShowWeapon(var_4_3.transform, false)

					arg_1_1.var_[var_4_0 .. "Animator"] = var_4_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_1_1.var_[var_4_0 .. "Animator"].applyRootMotion = true
					arg_1_1.var_[var_4_0 .. "LipSync"] = var_4_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_4_5 = arg_1_1.actors_["3007_tpose"]
			local var_4_6 = 0.967

			if var_4_6 < arg_1_1.time_ and arg_1_1.time_ <= var_4_6 + arg_4_0 and not isNil(var_4_5) and arg_1_1.var_.characterEffect3007_tpose == nil then
				arg_1_1.var_.characterEffect3007_tpose = var_4_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_7 = 0.0329999999999998

			if var_4_6 <= arg_1_1.time_ and arg_1_1.time_ < var_4_6 + var_4_7 and not isNil(var_4_5) then
				local var_4_8 = (arg_1_1.time_ - var_4_6) / var_4_7

				if arg_1_1.var_.characterEffect3007_tpose and not isNil(var_4_5) then
					local var_4_9 = Mathf.Lerp(0, 0.5, var_4_8)

					arg_1_1.var_.characterEffect3007_tpose.fillFlat = true
					arg_1_1.var_.characterEffect3007_tpose.fillRatio = var_4_9
				end
			end

			if arg_1_1.time_ >= var_4_6 + var_4_7 and arg_1_1.time_ < var_4_6 + var_4_7 + arg_4_0 and not isNil(var_4_5) and arg_1_1.var_.characterEffect3007_tpose then
				local var_4_10 = 0.5

				arg_1_1.var_.characterEffect3007_tpose.fillFlat = true
				arg_1_1.var_.characterEffect3007_tpose.fillRatio = var_4_10
			end

			local var_4_11 = "C03a"

			if arg_1_1.bgs_[var_4_11] == nil then
				local var_4_12 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_12:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_11)
				var_4_12.name = var_4_11
				var_4_12.transform.parent = arg_1_1.stage_.transform
				var_4_12.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_11] = var_4_12
			end

			local var_4_13 = 0

			if var_4_13 < arg_1_1.time_ and arg_1_1.time_ <= var_4_13 + arg_4_0 then
				local var_4_14 = manager.ui.mainCamera.transform.localPosition
				local var_4_15 = Vector3.New(0, 0, 10) + Vector3.New(var_4_14.x, var_4_14.y, 0)
				local var_4_16 = arg_1_1.bgs_.C03a

				var_4_16.transform.localPosition = var_4_15
				var_4_16.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_17 = var_4_16:GetComponent("SpriteRenderer")

				if var_4_17 and var_4_17.sprite then
					local var_4_18 = (var_4_16.transform.localPosition - var_4_14).z
					local var_4_19 = manager.ui.mainCameraCom_
					local var_4_20 = 2 * var_4_18 * Mathf.Tan(var_4_19.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_4_21 = var_4_20 * var_4_19.aspect
					local var_4_22 = var_4_17.sprite.bounds.size.x
					local var_4_23 = var_4_17.sprite.bounds.size.y
					local var_4_24 = var_4_21 / var_4_22
					local var_4_25 = var_4_20 / var_4_23
					local var_4_26 = var_4_25 < var_4_24 and var_4_24 or var_4_25

					var_4_16.transform.localScale = Vector3.New(var_4_26, var_4_26, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "C03a" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_27 = arg_1_1.actors_["3007_tpose"].transform
			local var_4_28 = 1.8

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				arg_1_1.var_.moveOldPos3007_tpose = var_4_27.localPosition

				local var_4_29 = GameObjectTools.GetOrAddComponent(var_4_27.gameObject, typeof(DynamicBoneHelper))

				if var_4_29 then
					var_4_29:EnableDynamicBone(false)
				end
			end

			local var_4_30 = 0.001

			if var_4_28 <= arg_1_1.time_ and arg_1_1.time_ < var_4_28 + var_4_30 then
				local var_4_31 = (arg_1_1.time_ - var_4_28) / var_4_30
				local var_4_32 = Vector3.New(0, 100, 0)

				var_4_27.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos3007_tpose, var_4_32, var_4_31)

				local var_4_33 = manager.ui.mainCamera.transform.position - var_4_27.position

				var_4_27.forward = Vector3.New(var_4_33.x, var_4_33.y, var_4_33.z)

				local var_4_34 = var_4_27.localEulerAngles

				var_4_34.z = 0
				var_4_34.x = 0
				var_4_27.localEulerAngles = var_4_34
			end

			if arg_1_1.time_ >= var_4_28 + var_4_30 and arg_1_1.time_ < var_4_28 + var_4_30 + arg_4_0 then
				var_4_27.localPosition = Vector3.New(0, 100, 0)

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

			local var_4_38 = 1.8

			if var_4_38 < arg_1_1.time_ and arg_1_1.time_ <= var_4_38 + arg_4_0 then
				arg_1_1:PlayTimeline("3007_tpose", "StoryTimeline/CharAction/story3007/story3007action/3007action1_1")
			end

			local var_4_39 = 0
			local var_4_40 = 1

			if var_4_39 < arg_1_1.time_ and arg_1_1.time_ <= var_4_39 + arg_4_0 then
				local var_4_41 = "play"
				local var_4_42 = "music"

				arg_1_1:AudioAction(var_4_41, var_4_42, "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1.awb")

				local var_4_43 = ""
				local var_4_44 = manager.audio:GetAudioName("bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1")

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

			local var_4_45 = arg_1_1.bgs_.C03a
			local var_4_46 = 0

			if var_4_46 < arg_1_1.time_ and arg_1_1.time_ <= var_4_46 + arg_4_0 then
				local var_4_47 = var_4_45:GetComponent("SpriteRenderer")

				if var_4_47 then
					arg_1_1.var_.alphaOldValueC03a = var_4_47.color.a
					arg_1_1.var_.alphaMatValueC03a = var_4_47
				end

				arg_1_1.var_.alphaOldValueC03a = 0
			end

			local var_4_48 = 1.5

			if var_4_46 <= arg_1_1.time_ and arg_1_1.time_ < var_4_46 + var_4_48 then
				local var_4_49 = (arg_1_1.time_ - var_4_46) / var_4_48
				local var_4_50 = Mathf.Lerp(arg_1_1.var_.alphaOldValueC03a, 1, var_4_49)

				if arg_1_1.var_.alphaMatValueC03a then
					local var_4_51 = arg_1_1.var_.alphaMatValueC03a.color

					var_4_51.a = var_4_50
					arg_1_1.var_.alphaMatValueC03a.color = var_4_51
				end
			end

			if arg_1_1.time_ >= var_4_46 + var_4_48 and arg_1_1.time_ < var_4_46 + var_4_48 + arg_4_0 and arg_1_1.var_.alphaMatValueC03a then
				local var_4_52 = arg_1_1.var_.alphaMatValueC03a
				local var_4_53 = var_4_52.color

				var_4_53.a = 1
				var_4_52.color = var_4_53
			end

			local var_4_54 = 0

			if var_4_54 < arg_1_1.time_ and arg_1_1.time_ <= var_4_54 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_55 = 2

			if arg_1_1.time_ >= var_4_54 + var_4_55 and arg_1_1.time_ < var_4_54 + var_4_55 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_56 = 2
			local var_4_57 = 0.35

			if var_4_56 < arg_1_1.time_ and arg_1_1.time_ <= var_4_56 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_58 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_58:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_58:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_58:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_59 = arg_1_1:FormatText(StoryNameCfg[94].name)

				arg_1_1.leftNameTxt_.text = var_4_59

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1038")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_60 = arg_1_1:GetWordFromCfg(107112001)
				local var_4_61 = arg_1_1:FormatText(var_4_60.content)

				arg_1_1.text_.text = var_4_61

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_62 = 14
				local var_4_63 = utf8.len(var_4_61)
				local var_4_64 = var_4_62 <= 0 and var_4_57 or var_4_57 * (var_4_63 / var_4_62)

				if var_4_64 > 0 and var_4_57 < var_4_64 then
					arg_1_1.talkMaxDuration = var_4_64
					var_4_56 = var_4_56 + 0.3

					if var_4_64 + var_4_56 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_64 + var_4_56
					end
				end

				arg_1_1.text_.text = var_4_61
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107112", "107112001", "story_v_out_107112.awb") ~= 0 then
					local var_4_65 = manager.audio:GetVoiceLength("story_v_out_107112", "107112001", "story_v_out_107112.awb") / 1000

					if var_4_65 + var_4_56 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_65 + var_4_56
					end

					if var_4_60.prefab_name ~= "" and arg_1_1.actors_[var_4_60.prefab_name] ~= nil then
						local var_4_66 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_60.prefab_name].transform, "story_v_out_107112", "107112001", "story_v_out_107112.awb")

						arg_1_1:RecordAudio("107112001", var_4_66)
						arg_1_1:RecordAudio("107112001", var_4_66)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_107112", "107112001", "story_v_out_107112.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_107112", "107112001", "story_v_out_107112.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_67 = var_4_56 + 0.3
			local var_4_68 = math.max(var_4_57, arg_1_1.talkMaxDuration)

			if var_4_67 <= arg_1_1.time_ and arg_1_1.time_ < var_4_67 + var_4_68 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_67) / var_4_68

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_67 + var_4_68 and arg_1_1.time_ < var_4_67 + var_4_68 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3007_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 1.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play107112002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 107112002
		arg_8_1.duration_ = 1.67

		local var_8_0 = {
			ja = 1.2,
			ko = 1.666,
			zh = 1.2,
			en = 1.1
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
				arg_8_0:Play107112003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0
			local var_11_1 = 0.15

			if var_11_0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_0 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				local var_11_2 = arg_8_1:FormatText(StoryNameCfg[99].name)

				arg_8_1.leftNameTxt_.text = var_11_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, true)
				arg_8_1.iconController_:SetSelectedState("hero")

				arg_8_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10012")

				arg_8_1.callingController_:SetSelectedState("normal")

				arg_8_1.keyicon_.color = Color.New(1, 1, 1)
				arg_8_1.icon_.color = Color.New(1, 1, 1)

				local var_11_3 = arg_8_1:GetWordFromCfg(107112002)
				local var_11_4 = arg_8_1:FormatText(var_11_3.content)

				arg_8_1.text_.text = var_11_4

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_5 = 6
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

				if manager.audio:GetVoiceLength("story_v_out_107112", "107112002", "story_v_out_107112.awb") ~= 0 then
					local var_11_8 = manager.audio:GetVoiceLength("story_v_out_107112", "107112002", "story_v_out_107112.awb") / 1000

					if var_11_8 + var_11_0 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_8 + var_11_0
					end

					if var_11_3.prefab_name ~= "" and arg_8_1.actors_[var_11_3.prefab_name] ~= nil then
						local var_11_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_3.prefab_name].transform, "story_v_out_107112", "107112002", "story_v_out_107112.awb")

						arg_8_1:RecordAudio("107112002", var_11_9)
						arg_8_1:RecordAudio("107112002", var_11_9)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_107112", "107112002", "story_v_out_107112.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_107112", "107112002", "story_v_out_107112.awb")
				end

				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_10 = math.max(var_11_1, arg_8_1.talkMaxDuration)

			if var_11_0 <= arg_8_1.time_ and arg_8_1.time_ < var_11_0 + var_11_10 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_0) / var_11_10

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_0 + var_11_10 and arg_8_1.time_ < var_11_0 + var_11_10 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play107112003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 107112003
		arg_12_1.duration_ = 4.9

		local var_12_0 = {
			ja = 4.9,
			ko = 3.466,
			zh = 4.233,
			en = 4.233
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
				arg_12_0:Play107112004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = arg_12_1.bgs_.C03a
			local var_15_1 = 0

			if var_15_1 < arg_12_1.time_ and arg_12_1.time_ <= var_15_1 + arg_15_0 then
				local var_15_2 = var_15_0:GetComponent("SpriteRenderer")

				if var_15_2 then
					arg_12_1.var_.alphaOldValueC03a = var_15_2.color.a
					arg_12_1.var_.alphaMatValueC03a = var_15_2
				end

				arg_12_1.var_.alphaOldValueC03a = 1
			end

			local var_15_3 = 1.5

			if var_15_1 <= arg_12_1.time_ and arg_12_1.time_ < var_15_1 + var_15_3 then
				local var_15_4 = (arg_12_1.time_ - var_15_1) / var_15_3
				local var_15_5 = Mathf.Lerp(arg_12_1.var_.alphaOldValueC03a, 0, var_15_4)

				if arg_12_1.var_.alphaMatValueC03a then
					local var_15_6 = arg_12_1.var_.alphaMatValueC03a.color

					var_15_6.a = var_15_5
					arg_12_1.var_.alphaMatValueC03a.color = var_15_6
				end
			end

			if arg_12_1.time_ >= var_15_1 + var_15_3 and arg_12_1.time_ < var_15_1 + var_15_3 + arg_15_0 and arg_12_1.var_.alphaMatValueC03a then
				local var_15_7 = arg_12_1.var_.alphaMatValueC03a
				local var_15_8 = var_15_7.color

				var_15_8.a = 0
				var_15_7.color = var_15_8
			end

			local var_15_9 = "S0704"

			if arg_12_1.bgs_[var_15_9] == nil then
				local var_15_10 = Object.Instantiate(arg_12_1.paintGo_)

				var_15_10:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_15_9)
				var_15_10.name = var_15_9
				var_15_10.transform.parent = arg_12_1.stage_.transform
				var_15_10.transform.localPosition = Vector3.New(0, 100, 0)
				arg_12_1.bgs_[var_15_9] = var_15_10
			end

			local var_15_11 = arg_12_1.bgs_.S0704
			local var_15_12 = 1.5

			if var_15_12 < arg_12_1.time_ and arg_12_1.time_ <= var_15_12 + arg_15_0 then
				local var_15_13 = var_15_11:GetComponent("SpriteRenderer")

				if var_15_13 then
					arg_12_1.var_.alphaOldValueS0704 = var_15_13.color.a
					arg_12_1.var_.alphaMatValueS0704 = var_15_13
				end

				arg_12_1.var_.alphaOldValueS0704 = 0
			end

			local var_15_14 = 1.5

			if var_15_12 <= arg_12_1.time_ and arg_12_1.time_ < var_15_12 + var_15_14 then
				local var_15_15 = (arg_12_1.time_ - var_15_12) / var_15_14
				local var_15_16 = Mathf.Lerp(arg_12_1.var_.alphaOldValueS0704, 1, var_15_15)

				if arg_12_1.var_.alphaMatValueS0704 then
					local var_15_17 = arg_12_1.var_.alphaMatValueS0704.color

					var_15_17.a = var_15_16
					arg_12_1.var_.alphaMatValueS0704.color = var_15_17
				end
			end

			if arg_12_1.time_ >= var_15_12 + var_15_14 and arg_12_1.time_ < var_15_12 + var_15_14 + arg_15_0 and arg_12_1.var_.alphaMatValueS0704 then
				local var_15_18 = arg_12_1.var_.alphaMatValueS0704
				local var_15_19 = var_15_18.color

				var_15_19.a = 1
				var_15_18.color = var_15_19
			end

			local var_15_20 = arg_12_1.actors_["3007_tpose"].transform
			local var_15_21 = 0

			if var_15_21 < arg_12_1.time_ and arg_12_1.time_ <= var_15_21 + arg_15_0 then
				arg_12_1.var_.moveOldPos3007_tpose = var_15_20.localPosition

				local var_15_22 = GameObjectTools.GetOrAddComponent(var_15_20.gameObject, typeof(DynamicBoneHelper))

				if var_15_22 then
					var_15_22:EnableDynamicBone(false)
				end
			end

			local var_15_23 = 0.001

			if var_15_21 <= arg_12_1.time_ and arg_12_1.time_ < var_15_21 + var_15_23 then
				local var_15_24 = (arg_12_1.time_ - var_15_21) / var_15_23
				local var_15_25 = Vector3.New(0, 100, 0)

				var_15_20.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos3007_tpose, var_15_25, var_15_24)

				local var_15_26 = manager.ui.mainCamera.transform.position - var_15_20.position

				var_15_20.forward = Vector3.New(var_15_26.x, var_15_26.y, var_15_26.z)

				local var_15_27 = var_15_20.localEulerAngles

				var_15_27.z = 0
				var_15_27.x = 0
				var_15_20.localEulerAngles = var_15_27
			end

			if arg_12_1.time_ >= var_15_21 + var_15_23 and arg_12_1.time_ < var_15_21 + var_15_23 + arg_15_0 then
				var_15_20.localPosition = Vector3.New(0, 100, 0)

				local var_15_28 = manager.ui.mainCamera.transform.position - var_15_20.position

				var_15_20.forward = Vector3.New(var_15_28.x, var_15_28.y, var_15_28.z)

				local var_15_29 = var_15_20.localEulerAngles

				var_15_29.z = 0
				var_15_29.x = 0
				var_15_20.localEulerAngles = var_15_29

				local var_15_30 = GameObjectTools.GetOrAddComponent(var_15_20.gameObject, typeof(DynamicBoneHelper))

				if var_15_30 then
					var_15_30:EnableDynamicBone(true)
				end
			end

			local var_15_31 = 1.5

			if var_15_31 < arg_12_1.time_ and arg_12_1.time_ <= var_15_31 + arg_15_0 then
				local var_15_32 = manager.ui.mainCamera.transform.localPosition
				local var_15_33 = Vector3.New(0, 0, 10) + Vector3.New(var_15_32.x, var_15_32.y, 0)
				local var_15_34 = arg_12_1.bgs_.S0704

				var_15_34.transform.localPosition = var_15_33
				var_15_34.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_15_35 = var_15_34:GetComponent("SpriteRenderer")

				if var_15_35 and var_15_35.sprite then
					local var_15_36 = (var_15_34.transform.localPosition - var_15_32).z
					local var_15_37 = manager.ui.mainCameraCom_
					local var_15_38 = 2 * var_15_36 * Mathf.Tan(var_15_37.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_15_39 = var_15_38 * var_15_37.aspect
					local var_15_40 = var_15_35.sprite.bounds.size.x
					local var_15_41 = var_15_35.sprite.bounds.size.y
					local var_15_42 = var_15_39 / var_15_40
					local var_15_43 = var_15_38 / var_15_41
					local var_15_44 = var_15_43 < var_15_42 and var_15_42 or var_15_43

					var_15_34.transform.localScale = Vector3.New(var_15_44, var_15_44, 0)
				end

				for iter_15_0, iter_15_1 in pairs(arg_12_1.bgs_) do
					if iter_15_0 ~= "S0704" then
						iter_15_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_15_45 = 0

			if var_15_45 < arg_12_1.time_ and arg_12_1.time_ <= var_15_45 + arg_15_0 then
				arg_12_1.allBtn_.enabled = false
			end

			local var_15_46 = 2

			if arg_12_1.time_ >= var_15_45 + var_15_46 and arg_12_1.time_ < var_15_45 + var_15_46 + arg_15_0 then
				arg_12_1.allBtn_.enabled = true
			end

			local var_15_47 = "1038ui_story"

			if arg_12_1.actors_[var_15_47] == nil then
				local var_15_48 = Asset.Load("Char/" .. "1038ui_story")

				if not isNil(var_15_48) then
					local var_15_49 = Object.Instantiate(Asset.Load("Char/" .. "1038ui_story"), arg_12_1.stage_.transform)

					var_15_49.name = var_15_47
					var_15_49.transform.localPosition = Vector3.New(0, 100, 0)
					arg_12_1.actors_[var_15_47] = var_15_49

					local var_15_50 = var_15_49:GetComponentInChildren(typeof(CharacterEffect))

					var_15_50.enabled = true

					local var_15_51 = GameObjectTools.GetOrAddComponent(var_15_49, typeof(DynamicBoneHelper))

					if var_15_51 then
						var_15_51:EnableDynamicBone(false)
					end

					arg_12_1:ShowWeapon(var_15_50.transform, false)

					arg_12_1.var_[var_15_47 .. "Animator"] = var_15_50.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_12_1.var_[var_15_47 .. "Animator"].applyRootMotion = true
					arg_12_1.var_[var_15_47 .. "LipSync"] = var_15_50.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_15_52 = 0

			if var_15_52 < arg_12_1.time_ and arg_12_1.time_ <= var_15_52 + arg_15_0 then
				arg_12_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			if arg_12_1.frameCnt_ <= 1 then
				arg_12_1.dialog_:SetActive(false)
			end

			local var_15_53 = 2
			local var_15_54 = 0.175

			if var_15_53 < arg_12_1.time_ and arg_12_1.time_ <= var_15_53 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0

				arg_12_1.dialog_:SetActive(true)

				arg_12_1.dialogCg_.alpha = 0

				local var_15_55 = LeanTween.value(arg_12_1.dialog_, 0, 1, 0.3)

				var_15_55:setOnUpdate(LuaHelper.FloatAction(function(arg_16_0)
					arg_12_1.dialogCg_.alpha = arg_16_0
				end))
				var_15_55:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_12_1.dialog_)
					var_15_55:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_12_1.duration_ = arg_12_1.duration_ + 0.3

				SetActive(arg_12_1.leftNameGo_, true)

				local var_15_56 = arg_12_1:FormatText(StoryNameCfg[94].name)

				arg_12_1.leftNameTxt_.text = var_15_56

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, true)
				arg_12_1.iconController_:SetSelectedState("hero")

				arg_12_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1038")

				arg_12_1.callingController_:SetSelectedState("normal")

				arg_12_1.keyicon_.color = Color.New(1, 1, 1)
				arg_12_1.icon_.color = Color.New(1, 1, 1)

				local var_15_57 = arg_12_1:GetWordFromCfg(107112003)
				local var_15_58 = arg_12_1:FormatText(var_15_57.content)

				arg_12_1.text_.text = var_15_58

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_59 = 7
				local var_15_60 = utf8.len(var_15_58)
				local var_15_61 = var_15_59 <= 0 and var_15_54 or var_15_54 * (var_15_60 / var_15_59)

				if var_15_61 > 0 and var_15_54 < var_15_61 then
					arg_12_1.talkMaxDuration = var_15_61
					var_15_53 = var_15_53 + 0.3

					if var_15_61 + var_15_53 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_61 + var_15_53
					end
				end

				arg_12_1.text_.text = var_15_58
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107112", "107112003", "story_v_out_107112.awb") ~= 0 then
					local var_15_62 = manager.audio:GetVoiceLength("story_v_out_107112", "107112003", "story_v_out_107112.awb") / 1000

					if var_15_62 + var_15_53 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_62 + var_15_53
					end

					if var_15_57.prefab_name ~= "" and arg_12_1.actors_[var_15_57.prefab_name] ~= nil then
						local var_15_63 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_57.prefab_name].transform, "story_v_out_107112", "107112003", "story_v_out_107112.awb")

						arg_12_1:RecordAudio("107112003", var_15_63)
						arg_12_1:RecordAudio("107112003", var_15_63)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_107112", "107112003", "story_v_out_107112.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_107112", "107112003", "story_v_out_107112.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_64 = var_15_53 + 0.3
			local var_15_65 = math.max(var_15_54, arg_12_1.talkMaxDuration)

			if var_15_64 <= arg_12_1.time_ and arg_12_1.time_ < var_15_64 + var_15_65 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_64) / var_15_65

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_64 + var_15_65 and arg_12_1.time_ < var_15_64 + var_15_65 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3007_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_12_1:InitPlayNodeList()
	end,
	Play107112004 = function(arg_18_0, arg_18_1)
		arg_18_1.time_ = 0
		arg_18_1.frameCnt_ = 0
		arg_18_1.state_ = "playing"
		arg_18_1.curTalkId_ = 107112004
		arg_18_1.duration_ = 4.6

		local var_18_0 = {
			ja = 4,
			ko = 2,
			zh = 4.6,
			en = 4.233
		}
		local var_18_1 = manager.audio:GetLocalizationFlag()

		if var_18_0[var_18_1] ~= nil then
			arg_18_1.duration_ = var_18_0[var_18_1]
		end

		SetActive(arg_18_1.tipsGo_, false)

		function arg_18_1.onSingleLineFinish_()
			arg_18_1.onSingleLineUpdate_ = nil
			arg_18_1.onSingleLineFinish_ = nil
			arg_18_1.state_ = "waiting"
		end

		function arg_18_1.playNext_(arg_20_0)
			if arg_20_0 == 1 then
				arg_18_0:Play107112005(arg_18_1)
			end
		end

		function arg_18_1.onSingleLineUpdate_(arg_21_0)
			local var_21_0 = 0
			local var_21_1 = 0.1

			if var_21_0 < arg_18_1.time_ and arg_18_1.time_ <= var_21_0 + arg_21_0 then
				arg_18_1.talkMaxDuration = 0
				arg_18_1.dialogCg_.alpha = 1

				arg_18_1.dialog_:SetActive(true)
				SetActive(arg_18_1.leftNameGo_, true)

				local var_21_2 = arg_18_1:FormatText(StoryNameCfg[98].name)

				arg_18_1.leftNameTxt_.text = var_21_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_18_1.leftNameTxt_.transform)

				arg_18_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_18_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_18_1:RecordName(arg_18_1.leftNameTxt_.text)
				SetActive(arg_18_1.iconTrs_.gameObject, true)
				arg_18_1.iconController_:SetSelectedState("hero")

				arg_18_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3007")

				arg_18_1.callingController_:SetSelectedState("normal")

				arg_18_1.keyicon_.color = Color.New(1, 1, 1)
				arg_18_1.icon_.color = Color.New(1, 1, 1)

				local var_21_3 = arg_18_1:GetWordFromCfg(107112004)
				local var_21_4 = arg_18_1:FormatText(var_21_3.content)

				arg_18_1.text_.text = var_21_4

				LuaForUtil.ClearLinePrefixSymbol(arg_18_1.text_)

				local var_21_5 = 4
				local var_21_6 = utf8.len(var_21_4)
				local var_21_7 = var_21_5 <= 0 and var_21_1 or var_21_1 * (var_21_6 / var_21_5)

				if var_21_7 > 0 and var_21_1 < var_21_7 then
					arg_18_1.talkMaxDuration = var_21_7

					if var_21_7 + var_21_0 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_7 + var_21_0
					end
				end

				arg_18_1.text_.text = var_21_4
				arg_18_1.typewritter.percent = 0

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107112", "107112004", "story_v_out_107112.awb") ~= 0 then
					local var_21_8 = manager.audio:GetVoiceLength("story_v_out_107112", "107112004", "story_v_out_107112.awb") / 1000

					if var_21_8 + var_21_0 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_8 + var_21_0
					end

					if var_21_3.prefab_name ~= "" and arg_18_1.actors_[var_21_3.prefab_name] ~= nil then
						local var_21_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_18_1.actors_[var_21_3.prefab_name].transform, "story_v_out_107112", "107112004", "story_v_out_107112.awb")

						arg_18_1:RecordAudio("107112004", var_21_9)
						arg_18_1:RecordAudio("107112004", var_21_9)
					else
						arg_18_1:AudioAction("play", "voice", "story_v_out_107112", "107112004", "story_v_out_107112.awb")
					end

					arg_18_1:RecordHistoryTalkVoice("story_v_out_107112", "107112004", "story_v_out_107112.awb")
				end

				arg_18_1:RecordContent(arg_18_1.text_.text)
			end

			local var_21_10 = math.max(var_21_1, arg_18_1.talkMaxDuration)

			if var_21_0 <= arg_18_1.time_ and arg_18_1.time_ < var_21_0 + var_21_10 then
				arg_18_1.typewritter.percent = (arg_18_1.time_ - var_21_0) / var_21_10

				arg_18_1.typewritter:SetDirty()
			end

			if arg_18_1.time_ >= var_21_0 + var_21_10 and arg_18_1.time_ < var_21_0 + var_21_10 + arg_21_0 then
				arg_18_1.typewritter.percent = 1

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(true)
			end
		end

		arg_18_1.nodeConfigList_ = {}

		arg_18_1:InitPlayNodeList()
	end,
	Play107112005 = function(arg_22_0, arg_22_1)
		arg_22_1.time_ = 0
		arg_22_1.frameCnt_ = 0
		arg_22_1.state_ = "playing"
		arg_22_1.curTalkId_ = 107112005
		arg_22_1.duration_ = 5.9

		local var_22_0 = {
			ja = 5.9,
			ko = 5.333,
			zh = 4.2,
			en = 5.066
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
				arg_22_0:Play107112006(arg_22_1)
			end
		end

		function arg_22_1.onSingleLineUpdate_(arg_25_0)
			local var_25_0 = 0
			local var_25_1 = 0.475

			if var_25_0 < arg_22_1.time_ and arg_22_1.time_ <= var_25_0 + arg_25_0 then
				arg_22_1.talkMaxDuration = 0
				arg_22_1.dialogCg_.alpha = 1

				arg_22_1.dialog_:SetActive(true)
				SetActive(arg_22_1.leftNameGo_, true)

				local var_25_2 = arg_22_1:FormatText(StoryNameCfg[99].name)

				arg_22_1.leftNameTxt_.text = var_25_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_22_1.leftNameTxt_.transform)

				arg_22_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_22_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_22_1:RecordName(arg_22_1.leftNameTxt_.text)
				SetActive(arg_22_1.iconTrs_.gameObject, true)
				arg_22_1.iconController_:SetSelectedState("hero")

				arg_22_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10012")

				arg_22_1.callingController_:SetSelectedState("normal")

				arg_22_1.keyicon_.color = Color.New(1, 1, 1)
				arg_22_1.icon_.color = Color.New(1, 1, 1)

				local var_25_3 = arg_22_1:GetWordFromCfg(107112005)
				local var_25_4 = arg_22_1:FormatText(var_25_3.content)

				arg_22_1.text_.text = var_25_4

				LuaForUtil.ClearLinePrefixSymbol(arg_22_1.text_)

				local var_25_5 = 19
				local var_25_6 = utf8.len(var_25_4)
				local var_25_7 = var_25_5 <= 0 and var_25_1 or var_25_1 * (var_25_6 / var_25_5)

				if var_25_7 > 0 and var_25_1 < var_25_7 then
					arg_22_1.talkMaxDuration = var_25_7

					if var_25_7 + var_25_0 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_7 + var_25_0
					end
				end

				arg_22_1.text_.text = var_25_4
				arg_22_1.typewritter.percent = 0

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107112", "107112005", "story_v_out_107112.awb") ~= 0 then
					local var_25_8 = manager.audio:GetVoiceLength("story_v_out_107112", "107112005", "story_v_out_107112.awb") / 1000

					if var_25_8 + var_25_0 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_8 + var_25_0
					end

					if var_25_3.prefab_name ~= "" and arg_22_1.actors_[var_25_3.prefab_name] ~= nil then
						local var_25_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_22_1.actors_[var_25_3.prefab_name].transform, "story_v_out_107112", "107112005", "story_v_out_107112.awb")

						arg_22_1:RecordAudio("107112005", var_25_9)
						arg_22_1:RecordAudio("107112005", var_25_9)
					else
						arg_22_1:AudioAction("play", "voice", "story_v_out_107112", "107112005", "story_v_out_107112.awb")
					end

					arg_22_1:RecordHistoryTalkVoice("story_v_out_107112", "107112005", "story_v_out_107112.awb")
				end

				arg_22_1:RecordContent(arg_22_1.text_.text)
			end

			local var_25_10 = math.max(var_25_1, arg_22_1.talkMaxDuration)

			if var_25_0 <= arg_22_1.time_ and arg_22_1.time_ < var_25_0 + var_25_10 then
				arg_22_1.typewritter.percent = (arg_22_1.time_ - var_25_0) / var_25_10

				arg_22_1.typewritter:SetDirty()
			end

			if arg_22_1.time_ >= var_25_0 + var_25_10 and arg_22_1.time_ < var_25_0 + var_25_10 + arg_25_0 then
				arg_22_1.typewritter.percent = 1

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(true)
			end
		end

		arg_22_1.nodeConfigList_ = {}

		arg_22_1:InitPlayNodeList()
	end,
	Play107112006 = function(arg_26_0, arg_26_1)
		arg_26_1.time_ = 0
		arg_26_1.frameCnt_ = 0
		arg_26_1.state_ = "playing"
		arg_26_1.curTalkId_ = 107112006
		arg_26_1.duration_ = 5.03

		local var_26_0 = {
			ja = 3.9,
			ko = 3.3,
			zh = 4.9,
			en = 5.033
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
				arg_26_0:Play107112007(arg_26_1)
			end
		end

		function arg_26_1.onSingleLineUpdate_(arg_29_0)
			local var_29_0 = arg_26_1.actors_["3007_tpose"]
			local var_29_1 = 0

			if var_29_1 < arg_26_1.time_ and arg_26_1.time_ <= var_29_1 + arg_29_0 and not isNil(var_29_0) and arg_26_1.var_.characterEffect3007_tpose == nil then
				arg_26_1.var_.characterEffect3007_tpose = var_29_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_29_2 = 0.1

			if var_29_1 <= arg_26_1.time_ and arg_26_1.time_ < var_29_1 + var_29_2 and not isNil(var_29_0) then
				local var_29_3 = (arg_26_1.time_ - var_29_1) / var_29_2

				if arg_26_1.var_.characterEffect3007_tpose and not isNil(var_29_0) then
					arg_26_1.var_.characterEffect3007_tpose.fillFlat = false
				end
			end

			if arg_26_1.time_ >= var_29_1 + var_29_2 and arg_26_1.time_ < var_29_1 + var_29_2 + arg_29_0 and not isNil(var_29_0) and arg_26_1.var_.characterEffect3007_tpose then
				arg_26_1.var_.characterEffect3007_tpose.fillFlat = false
			end

			local var_29_4 = 0
			local var_29_5 = 0.15

			if var_29_4 < arg_26_1.time_ and arg_26_1.time_ <= var_29_4 + arg_29_0 then
				arg_26_1.talkMaxDuration = 0
				arg_26_1.dialogCg_.alpha = 1

				arg_26_1.dialog_:SetActive(true)
				SetActive(arg_26_1.leftNameGo_, true)

				local var_29_6 = arg_26_1:FormatText(StoryNameCfg[98].name)

				arg_26_1.leftNameTxt_.text = var_29_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_26_1.leftNameTxt_.transform)

				arg_26_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_26_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_26_1:RecordName(arg_26_1.leftNameTxt_.text)
				SetActive(arg_26_1.iconTrs_.gameObject, true)
				arg_26_1.iconController_:SetSelectedState("hero")

				arg_26_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3007")

				arg_26_1.callingController_:SetSelectedState("normal")

				arg_26_1.keyicon_.color = Color.New(1, 1, 1)
				arg_26_1.icon_.color = Color.New(1, 1, 1)

				local var_29_7 = arg_26_1:GetWordFromCfg(107112006)
				local var_29_8 = arg_26_1:FormatText(var_29_7.content)

				arg_26_1.text_.text = var_29_8

				LuaForUtil.ClearLinePrefixSymbol(arg_26_1.text_)

				local var_29_9 = 6
				local var_29_10 = utf8.len(var_29_8)
				local var_29_11 = var_29_9 <= 0 and var_29_5 or var_29_5 * (var_29_10 / var_29_9)

				if var_29_11 > 0 and var_29_5 < var_29_11 then
					arg_26_1.talkMaxDuration = var_29_11

					if var_29_11 + var_29_4 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_11 + var_29_4
					end
				end

				arg_26_1.text_.text = var_29_8
				arg_26_1.typewritter.percent = 0

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107112", "107112006", "story_v_out_107112.awb") ~= 0 then
					local var_29_12 = manager.audio:GetVoiceLength("story_v_out_107112", "107112006", "story_v_out_107112.awb") / 1000

					if var_29_12 + var_29_4 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_12 + var_29_4
					end

					if var_29_7.prefab_name ~= "" and arg_26_1.actors_[var_29_7.prefab_name] ~= nil then
						local var_29_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_26_1.actors_[var_29_7.prefab_name].transform, "story_v_out_107112", "107112006", "story_v_out_107112.awb")

						arg_26_1:RecordAudio("107112006", var_29_13)
						arg_26_1:RecordAudio("107112006", var_29_13)
					else
						arg_26_1:AudioAction("play", "voice", "story_v_out_107112", "107112006", "story_v_out_107112.awb")
					end

					arg_26_1:RecordHistoryTalkVoice("story_v_out_107112", "107112006", "story_v_out_107112.awb")
				end

				arg_26_1:RecordContent(arg_26_1.text_.text)
			end

			local var_29_14 = math.max(var_29_5, arg_26_1.talkMaxDuration)

			if var_29_4 <= arg_26_1.time_ and arg_26_1.time_ < var_29_4 + var_29_14 then
				arg_26_1.typewritter.percent = (arg_26_1.time_ - var_29_4) / var_29_14

				arg_26_1.typewritter:SetDirty()
			end

			if arg_26_1.time_ >= var_29_4 + var_29_14 and arg_26_1.time_ < var_29_4 + var_29_14 + arg_29_0 then
				arg_26_1.typewritter.percent = 1

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(true)
			end
		end

		arg_26_1.nodeConfigList_ = {}

		arg_26_1:InitPlayNodeList()
	end,
	Play107112007 = function(arg_30_0, arg_30_1)
		arg_30_1.time_ = 0
		arg_30_1.frameCnt_ = 0
		arg_30_1.state_ = "playing"
		arg_30_1.curTalkId_ = 107112007
		arg_30_1.duration_ = 7.03

		local var_30_0 = {
			ja = 7.033,
			ko = 4.433,
			zh = 6.666,
			en = 6.533
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
				arg_30_0:Play107112008(arg_30_1)
			end
		end

		function arg_30_1.onSingleLineUpdate_(arg_33_0)
			local var_33_0 = 0
			local var_33_1 = 0.625

			if var_33_0 < arg_30_1.time_ and arg_30_1.time_ <= var_33_0 + arg_33_0 then
				arg_30_1.talkMaxDuration = 0
				arg_30_1.dialogCg_.alpha = 1

				arg_30_1.dialog_:SetActive(true)
				SetActive(arg_30_1.leftNameGo_, true)

				local var_33_2 = arg_30_1:FormatText(StoryNameCfg[99].name)

				arg_30_1.leftNameTxt_.text = var_33_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_30_1.leftNameTxt_.transform)

				arg_30_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_30_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_30_1:RecordName(arg_30_1.leftNameTxt_.text)
				SetActive(arg_30_1.iconTrs_.gameObject, true)
				arg_30_1.iconController_:SetSelectedState("hero")

				arg_30_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10012")

				arg_30_1.callingController_:SetSelectedState("normal")

				arg_30_1.keyicon_.color = Color.New(1, 1, 1)
				arg_30_1.icon_.color = Color.New(1, 1, 1)

				local var_33_3 = arg_30_1:GetWordFromCfg(107112007)
				local var_33_4 = arg_30_1:FormatText(var_33_3.content)

				arg_30_1.text_.text = var_33_4

				LuaForUtil.ClearLinePrefixSymbol(arg_30_1.text_)

				local var_33_5 = 26
				local var_33_6 = utf8.len(var_33_4)
				local var_33_7 = var_33_5 <= 0 and var_33_1 or var_33_1 * (var_33_6 / var_33_5)

				if var_33_7 > 0 and var_33_1 < var_33_7 then
					arg_30_1.talkMaxDuration = var_33_7

					if var_33_7 + var_33_0 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_7 + var_33_0
					end
				end

				arg_30_1.text_.text = var_33_4
				arg_30_1.typewritter.percent = 0

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107112", "107112007", "story_v_out_107112.awb") ~= 0 then
					local var_33_8 = manager.audio:GetVoiceLength("story_v_out_107112", "107112007", "story_v_out_107112.awb") / 1000

					if var_33_8 + var_33_0 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_8 + var_33_0
					end

					if var_33_3.prefab_name ~= "" and arg_30_1.actors_[var_33_3.prefab_name] ~= nil then
						local var_33_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_30_1.actors_[var_33_3.prefab_name].transform, "story_v_out_107112", "107112007", "story_v_out_107112.awb")

						arg_30_1:RecordAudio("107112007", var_33_9)
						arg_30_1:RecordAudio("107112007", var_33_9)
					else
						arg_30_1:AudioAction("play", "voice", "story_v_out_107112", "107112007", "story_v_out_107112.awb")
					end

					arg_30_1:RecordHistoryTalkVoice("story_v_out_107112", "107112007", "story_v_out_107112.awb")
				end

				arg_30_1:RecordContent(arg_30_1.text_.text)
			end

			local var_33_10 = math.max(var_33_1, arg_30_1.talkMaxDuration)

			if var_33_0 <= arg_30_1.time_ and arg_30_1.time_ < var_33_0 + var_33_10 then
				arg_30_1.typewritter.percent = (arg_30_1.time_ - var_33_0) / var_33_10

				arg_30_1.typewritter:SetDirty()
			end

			if arg_30_1.time_ >= var_33_0 + var_33_10 and arg_30_1.time_ < var_33_0 + var_33_10 + arg_33_0 then
				arg_30_1.typewritter.percent = 1

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(true)
			end
		end

		arg_30_1.nodeConfigList_ = {}

		arg_30_1:InitPlayNodeList()
	end,
	Play107112008 = function(arg_34_0, arg_34_1)
		arg_34_1.time_ = 0
		arg_34_1.frameCnt_ = 0
		arg_34_1.state_ = "playing"
		arg_34_1.curTalkId_ = 107112008
		arg_34_1.duration_ = 5.8

		local var_34_0 = {
			ja = 3.5,
			ko = 4.166,
			zh = 3.9,
			en = 5.8
		}
		local var_34_1 = manager.audio:GetLocalizationFlag()

		if var_34_0[var_34_1] ~= nil then
			arg_34_1.duration_ = var_34_0[var_34_1]
		end

		SetActive(arg_34_1.tipsGo_, false)

		function arg_34_1.onSingleLineFinish_()
			arg_34_1.onSingleLineUpdate_ = nil
			arg_34_1.onSingleLineFinish_ = nil
			arg_34_1.state_ = "waiting"
		end

		function arg_34_1.playNext_(arg_36_0)
			if arg_36_0 == 1 then
				arg_34_0:Play107112009(arg_34_1)
			end
		end

		function arg_34_1.onSingleLineUpdate_(arg_37_0)
			local var_37_0 = 0
			local var_37_1 = 0.475

			if var_37_0 < arg_34_1.time_ and arg_34_1.time_ <= var_37_0 + arg_37_0 then
				arg_34_1.talkMaxDuration = 0
				arg_34_1.dialogCg_.alpha = 1

				arg_34_1.dialog_:SetActive(true)
				SetActive(arg_34_1.leftNameGo_, true)

				local var_37_2 = arg_34_1:FormatText(StoryNameCfg[99].name)

				arg_34_1.leftNameTxt_.text = var_37_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_34_1.leftNameTxt_.transform)

				arg_34_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_34_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_34_1:RecordName(arg_34_1.leftNameTxt_.text)
				SetActive(arg_34_1.iconTrs_.gameObject, true)
				arg_34_1.iconController_:SetSelectedState("hero")

				arg_34_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10012")

				arg_34_1.callingController_:SetSelectedState("normal")

				arg_34_1.keyicon_.color = Color.New(1, 1, 1)
				arg_34_1.icon_.color = Color.New(1, 1, 1)

				local var_37_3 = arg_34_1:GetWordFromCfg(107112008)
				local var_37_4 = arg_34_1:FormatText(var_37_3.content)

				arg_34_1.text_.text = var_37_4

				LuaForUtil.ClearLinePrefixSymbol(arg_34_1.text_)

				local var_37_5 = 18
				local var_37_6 = utf8.len(var_37_4)
				local var_37_7 = var_37_5 <= 0 and var_37_1 or var_37_1 * (var_37_6 / var_37_5)

				if var_37_7 > 0 and var_37_1 < var_37_7 then
					arg_34_1.talkMaxDuration = var_37_7

					if var_37_7 + var_37_0 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_7 + var_37_0
					end
				end

				arg_34_1.text_.text = var_37_4
				arg_34_1.typewritter.percent = 0

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107112", "107112008", "story_v_out_107112.awb") ~= 0 then
					local var_37_8 = manager.audio:GetVoiceLength("story_v_out_107112", "107112008", "story_v_out_107112.awb") / 1000

					if var_37_8 + var_37_0 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_8 + var_37_0
					end

					if var_37_3.prefab_name ~= "" and arg_34_1.actors_[var_37_3.prefab_name] ~= nil then
						local var_37_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_34_1.actors_[var_37_3.prefab_name].transform, "story_v_out_107112", "107112008", "story_v_out_107112.awb")

						arg_34_1:RecordAudio("107112008", var_37_9)
						arg_34_1:RecordAudio("107112008", var_37_9)
					else
						arg_34_1:AudioAction("play", "voice", "story_v_out_107112", "107112008", "story_v_out_107112.awb")
					end

					arg_34_1:RecordHistoryTalkVoice("story_v_out_107112", "107112008", "story_v_out_107112.awb")
				end

				arg_34_1:RecordContent(arg_34_1.text_.text)
			end

			local var_37_10 = math.max(var_37_1, arg_34_1.talkMaxDuration)

			if var_37_0 <= arg_34_1.time_ and arg_34_1.time_ < var_37_0 + var_37_10 then
				arg_34_1.typewritter.percent = (arg_34_1.time_ - var_37_0) / var_37_10

				arg_34_1.typewritter:SetDirty()
			end

			if arg_34_1.time_ >= var_37_0 + var_37_10 and arg_34_1.time_ < var_37_0 + var_37_10 + arg_37_0 then
				arg_34_1.typewritter.percent = 1

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(true)
			end
		end

		arg_34_1.nodeConfigList_ = {}

		arg_34_1:InitPlayNodeList()
	end,
	Play107112009 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 107112009
		arg_38_1.duration_ = 4.73

		local var_38_0 = {
			ja = 4.733,
			ko = 4.3,
			zh = 2.266,
			en = 2.2
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
				arg_38_0:Play107112010(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			local var_41_0 = 0
			local var_41_1 = 0.075

			if var_41_0 < arg_38_1.time_ and arg_38_1.time_ <= var_41_0 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0
				arg_38_1.dialogCg_.alpha = 1

				arg_38_1.dialog_:SetActive(true)
				SetActive(arg_38_1.leftNameGo_, true)

				local var_41_2 = arg_38_1:FormatText(StoryNameCfg[98].name)

				arg_38_1.leftNameTxt_.text = var_41_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_38_1.leftNameTxt_.transform)

				arg_38_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_38_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_38_1:RecordName(arg_38_1.leftNameTxt_.text)
				SetActive(arg_38_1.iconTrs_.gameObject, true)
				arg_38_1.iconController_:SetSelectedState("hero")

				arg_38_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3007")

				arg_38_1.callingController_:SetSelectedState("normal")

				arg_38_1.keyicon_.color = Color.New(1, 1, 1)
				arg_38_1.icon_.color = Color.New(1, 1, 1)

				local var_41_3 = arg_38_1:GetWordFromCfg(107112009)
				local var_41_4 = arg_38_1:FormatText(var_41_3.content)

				arg_38_1.text_.text = var_41_4

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_5 = 3
				local var_41_6 = utf8.len(var_41_4)
				local var_41_7 = var_41_5 <= 0 and var_41_1 or var_41_1 * (var_41_6 / var_41_5)

				if var_41_7 > 0 and var_41_1 < var_41_7 then
					arg_38_1.talkMaxDuration = var_41_7

					if var_41_7 + var_41_0 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_7 + var_41_0
					end
				end

				arg_38_1.text_.text = var_41_4
				arg_38_1.typewritter.percent = 0

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107112", "107112009", "story_v_out_107112.awb") ~= 0 then
					local var_41_8 = manager.audio:GetVoiceLength("story_v_out_107112", "107112009", "story_v_out_107112.awb") / 1000

					if var_41_8 + var_41_0 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_8 + var_41_0
					end

					if var_41_3.prefab_name ~= "" and arg_38_1.actors_[var_41_3.prefab_name] ~= nil then
						local var_41_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_38_1.actors_[var_41_3.prefab_name].transform, "story_v_out_107112", "107112009", "story_v_out_107112.awb")

						arg_38_1:RecordAudio("107112009", var_41_9)
						arg_38_1:RecordAudio("107112009", var_41_9)
					else
						arg_38_1:AudioAction("play", "voice", "story_v_out_107112", "107112009", "story_v_out_107112.awb")
					end

					arg_38_1:RecordHistoryTalkVoice("story_v_out_107112", "107112009", "story_v_out_107112.awb")
				end

				arg_38_1:RecordContent(arg_38_1.text_.text)
			end

			local var_41_10 = math.max(var_41_1, arg_38_1.talkMaxDuration)

			if var_41_0 <= arg_38_1.time_ and arg_38_1.time_ < var_41_0 + var_41_10 then
				arg_38_1.typewritter.percent = (arg_38_1.time_ - var_41_0) / var_41_10

				arg_38_1.typewritter:SetDirty()
			end

			if arg_38_1.time_ >= var_41_0 + var_41_10 and arg_38_1.time_ < var_41_0 + var_41_10 + arg_41_0 then
				arg_38_1.typewritter.percent = 1

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(true)
			end
		end

		arg_38_1.nodeConfigList_ = {}

		arg_38_1:InitPlayNodeList()
	end,
	Play107112010 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 107112010
		arg_42_1.duration_ = 7.13

		local var_42_0 = {
			ja = 6.766,
			ko = 4.3,
			zh = 6.266,
			en = 7.133
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
				arg_42_0:Play107112011(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			local var_45_0 = 0
			local var_45_1 = 0.2

			if var_45_0 < arg_42_1.time_ and arg_42_1.time_ <= var_45_0 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0
				arg_42_1.dialogCg_.alpha = 1

				arg_42_1.dialog_:SetActive(true)
				SetActive(arg_42_1.leftNameGo_, true)

				local var_45_2 = arg_42_1:FormatText(StoryNameCfg[98].name)

				arg_42_1.leftNameTxt_.text = var_45_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_42_1.leftNameTxt_.transform)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1.leftNameTxt_.text)
				SetActive(arg_42_1.iconTrs_.gameObject, true)
				arg_42_1.iconController_:SetSelectedState("hero")

				arg_42_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3007")

				arg_42_1.callingController_:SetSelectedState("normal")

				arg_42_1.keyicon_.color = Color.New(1, 1, 1)
				arg_42_1.icon_.color = Color.New(1, 1, 1)

				local var_45_3 = arg_42_1:GetWordFromCfg(107112010)
				local var_45_4 = arg_42_1:FormatText(var_45_3.content)

				arg_42_1.text_.text = var_45_4

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_5 = 8
				local var_45_6 = utf8.len(var_45_4)
				local var_45_7 = var_45_5 <= 0 and var_45_1 or var_45_1 * (var_45_6 / var_45_5)

				if var_45_7 > 0 and var_45_1 < var_45_7 then
					arg_42_1.talkMaxDuration = var_45_7

					if var_45_7 + var_45_0 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_7 + var_45_0
					end
				end

				arg_42_1.text_.text = var_45_4
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107112", "107112010", "story_v_out_107112.awb") ~= 0 then
					local var_45_8 = manager.audio:GetVoiceLength("story_v_out_107112", "107112010", "story_v_out_107112.awb") / 1000

					if var_45_8 + var_45_0 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_8 + var_45_0
					end

					if var_45_3.prefab_name ~= "" and arg_42_1.actors_[var_45_3.prefab_name] ~= nil then
						local var_45_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_42_1.actors_[var_45_3.prefab_name].transform, "story_v_out_107112", "107112010", "story_v_out_107112.awb")

						arg_42_1:RecordAudio("107112010", var_45_9)
						arg_42_1:RecordAudio("107112010", var_45_9)
					else
						arg_42_1:AudioAction("play", "voice", "story_v_out_107112", "107112010", "story_v_out_107112.awb")
					end

					arg_42_1:RecordHistoryTalkVoice("story_v_out_107112", "107112010", "story_v_out_107112.awb")
				end

				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_10 = math.max(var_45_1, arg_42_1.talkMaxDuration)

			if var_45_0 <= arg_42_1.time_ and arg_42_1.time_ < var_45_0 + var_45_10 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - var_45_0) / var_45_10

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= var_45_0 + var_45_10 and arg_42_1.time_ < var_45_0 + var_45_10 + arg_45_0 then
				arg_42_1.typewritter.percent = 1

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(true)
			end
		end

		arg_42_1.nodeConfigList_ = {}

		arg_42_1:InitPlayNodeList()
	end,
	Play107112011 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 107112011
		arg_46_1.duration_ = 6.13

		local var_46_0 = {
			ja = 5.9,
			ko = 5.333,
			zh = 5.8,
			en = 6.133
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
				arg_46_0:Play107112012(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			local var_49_0 = "1084ui_story"

			if arg_46_1.actors_[var_49_0] == nil then
				local var_49_1 = Asset.Load("Char/" .. "1084ui_story")

				if not isNil(var_49_1) then
					local var_49_2 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_46_1.stage_.transform)

					var_49_2.name = var_49_0
					var_49_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_46_1.actors_[var_49_0] = var_49_2

					local var_49_3 = var_49_2:GetComponentInChildren(typeof(CharacterEffect))

					var_49_3.enabled = true

					local var_49_4 = GameObjectTools.GetOrAddComponent(var_49_2, typeof(DynamicBoneHelper))

					if var_49_4 then
						var_49_4:EnableDynamicBone(false)
					end

					arg_46_1:ShowWeapon(var_49_3.transform, false)

					arg_46_1.var_[var_49_0 .. "Animator"] = var_49_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_46_1.var_[var_49_0 .. "Animator"].applyRootMotion = true
					arg_46_1.var_[var_49_0 .. "LipSync"] = var_49_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_49_5 = arg_46_1.actors_["1084ui_story"]
			local var_49_6 = 3

			if var_49_6 < arg_46_1.time_ and arg_46_1.time_ <= var_49_6 + arg_49_0 and not isNil(var_49_5) and arg_46_1.var_.characterEffect1084ui_story == nil then
				arg_46_1.var_.characterEffect1084ui_story = var_49_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_49_7 = 0.1

			if var_49_6 <= arg_46_1.time_ and arg_46_1.time_ < var_49_6 + var_49_7 and not isNil(var_49_5) then
				local var_49_8 = (arg_46_1.time_ - var_49_6) / var_49_7

				if arg_46_1.var_.characterEffect1084ui_story and not isNil(var_49_5) then
					arg_46_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_46_1.time_ >= var_49_6 + var_49_7 and arg_46_1.time_ < var_49_6 + var_49_7 + arg_49_0 and not isNil(var_49_5) and arg_46_1.var_.characterEffect1084ui_story then
				arg_46_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_49_9 = arg_46_1.actors_["3007_tpose"]
			local var_49_10 = 3

			if var_49_10 < arg_46_1.time_ and arg_46_1.time_ <= var_49_10 + arg_49_0 and not isNil(var_49_9) and arg_46_1.var_.characterEffect3007_tpose == nil then
				arg_46_1.var_.characterEffect3007_tpose = var_49_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_49_11 = 0.1

			if var_49_10 <= arg_46_1.time_ and arg_46_1.time_ < var_49_10 + var_49_11 and not isNil(var_49_9) then
				local var_49_12 = (arg_46_1.time_ - var_49_10) / var_49_11

				if arg_46_1.var_.characterEffect3007_tpose and not isNil(var_49_9) then
					local var_49_13 = Mathf.Lerp(0, 0.5, var_49_12)

					arg_46_1.var_.characterEffect3007_tpose.fillFlat = true
					arg_46_1.var_.characterEffect3007_tpose.fillRatio = var_49_13
				end
			end

			if arg_46_1.time_ >= var_49_10 + var_49_11 and arg_46_1.time_ < var_49_10 + var_49_11 + arg_49_0 and not isNil(var_49_9) and arg_46_1.var_.characterEffect3007_tpose then
				local var_49_14 = 0.5

				arg_46_1.var_.characterEffect3007_tpose.fillFlat = true
				arg_46_1.var_.characterEffect3007_tpose.fillRatio = var_49_14
			end

			local var_49_15 = arg_46_1.actors_["3007_tpose"].transform
			local var_49_16 = 3

			if var_49_16 < arg_46_1.time_ and arg_46_1.time_ <= var_49_16 + arg_49_0 then
				arg_46_1.var_.moveOldPos3007_tpose = var_49_15.localPosition

				local var_49_17 = GameObjectTools.GetOrAddComponent(var_49_15.gameObject, typeof(DynamicBoneHelper))

				if var_49_17 then
					var_49_17:EnableDynamicBone(false)
				end
			end

			local var_49_18 = 0.001

			if var_49_16 <= arg_46_1.time_ and arg_46_1.time_ < var_49_16 + var_49_18 then
				local var_49_19 = (arg_46_1.time_ - var_49_16) / var_49_18
				local var_49_20 = Vector3.New(0, 100, 0)

				var_49_15.localPosition = Vector3.Lerp(arg_46_1.var_.moveOldPos3007_tpose, var_49_20, var_49_19)

				local var_49_21 = manager.ui.mainCamera.transform.position - var_49_15.position

				var_49_15.forward = Vector3.New(var_49_21.x, var_49_21.y, var_49_21.z)

				local var_49_22 = var_49_15.localEulerAngles

				var_49_22.z = 0
				var_49_22.x = 0
				var_49_15.localEulerAngles = var_49_22
			end

			if arg_46_1.time_ >= var_49_16 + var_49_18 and arg_46_1.time_ < var_49_16 + var_49_18 + arg_49_0 then
				var_49_15.localPosition = Vector3.New(0, 100, 0)

				local var_49_23 = manager.ui.mainCamera.transform.position - var_49_15.position

				var_49_15.forward = Vector3.New(var_49_23.x, var_49_23.y, var_49_23.z)

				local var_49_24 = var_49_15.localEulerAngles

				var_49_24.z = 0
				var_49_24.x = 0
				var_49_15.localEulerAngles = var_49_24

				local var_49_25 = GameObjectTools.GetOrAddComponent(var_49_15.gameObject, typeof(DynamicBoneHelper))

				if var_49_25 then
					var_49_25:EnableDynamicBone(true)
				end
			end

			local var_49_26 = arg_46_1.actors_["1084ui_story"].transform
			local var_49_27 = 3

			if var_49_27 < arg_46_1.time_ and arg_46_1.time_ <= var_49_27 + arg_49_0 then
				arg_46_1.var_.moveOldPos1084ui_story = var_49_26.localPosition
			end

			local var_49_28 = 0.001

			if var_49_27 <= arg_46_1.time_ and arg_46_1.time_ < var_49_27 + var_49_28 then
				local var_49_29 = (arg_46_1.time_ - var_49_27) / var_49_28
				local var_49_30 = Vector3.New(-0.7, -0.97, -6)

				var_49_26.localPosition = Vector3.Lerp(arg_46_1.var_.moveOldPos1084ui_story, var_49_30, var_49_29)

				local var_49_31 = manager.ui.mainCamera.transform.position - var_49_26.position

				var_49_26.forward = Vector3.New(var_49_31.x, var_49_31.y, var_49_31.z)

				local var_49_32 = var_49_26.localEulerAngles

				var_49_32.z = 0
				var_49_32.x = 0
				var_49_26.localEulerAngles = var_49_32
			end

			if arg_46_1.time_ >= var_49_27 + var_49_28 and arg_46_1.time_ < var_49_27 + var_49_28 + arg_49_0 then
				var_49_26.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_49_33 = manager.ui.mainCamera.transform.position - var_49_26.position

				var_49_26.forward = Vector3.New(var_49_33.x, var_49_33.y, var_49_33.z)

				local var_49_34 = var_49_26.localEulerAngles

				var_49_34.z = 0
				var_49_34.x = 0
				var_49_26.localEulerAngles = var_49_34
			end

			local var_49_35 = 3

			if var_49_35 < arg_46_1.time_ and arg_46_1.time_ <= var_49_35 + arg_49_0 then
				arg_46_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action6_1")
			end

			local var_49_36 = arg_46_1.bgs_.S0704
			local var_49_37 = 0

			if var_49_37 < arg_46_1.time_ and arg_46_1.time_ <= var_49_37 + arg_49_0 then
				local var_49_38 = var_49_36:GetComponent("SpriteRenderer")

				if var_49_38 then
					arg_46_1.var_.alphaOldValueS0704 = var_49_38.color.a
					arg_46_1.var_.alphaMatValueS0704 = var_49_38
				end

				arg_46_1.var_.alphaOldValueS0704 = 1
			end

			local var_49_39 = 1.5

			if var_49_37 <= arg_46_1.time_ and arg_46_1.time_ < var_49_37 + var_49_39 then
				local var_49_40 = (arg_46_1.time_ - var_49_37) / var_49_39
				local var_49_41 = Mathf.Lerp(arg_46_1.var_.alphaOldValueS0704, 0, var_49_40)

				if arg_46_1.var_.alphaMatValueS0704 then
					local var_49_42 = arg_46_1.var_.alphaMatValueS0704.color

					var_49_42.a = var_49_41
					arg_46_1.var_.alphaMatValueS0704.color = var_49_42
				end
			end

			if arg_46_1.time_ >= var_49_37 + var_49_39 and arg_46_1.time_ < var_49_37 + var_49_39 + arg_49_0 and arg_46_1.var_.alphaMatValueS0704 then
				local var_49_43 = arg_46_1.var_.alphaMatValueS0704
				local var_49_44 = var_49_43.color

				var_49_44.a = 0
				var_49_43.color = var_49_44
			end

			local var_49_45 = arg_46_1.bgs_.C03a
			local var_49_46 = 1.5

			if var_49_46 < arg_46_1.time_ and arg_46_1.time_ <= var_49_46 + arg_49_0 then
				local var_49_47 = var_49_45:GetComponent("SpriteRenderer")

				if var_49_47 then
					arg_46_1.var_.alphaOldValueC03a = var_49_47.color.a
					arg_46_1.var_.alphaMatValueC03a = var_49_47
				end

				arg_46_1.var_.alphaOldValueC03a = 0
			end

			local var_49_48 = 1.5

			if var_49_46 <= arg_46_1.time_ and arg_46_1.time_ < var_49_46 + var_49_48 then
				local var_49_49 = (arg_46_1.time_ - var_49_46) / var_49_48
				local var_49_50 = Mathf.Lerp(arg_46_1.var_.alphaOldValueC03a, 1, var_49_49)

				if arg_46_1.var_.alphaMatValueC03a then
					local var_49_51 = arg_46_1.var_.alphaMatValueC03a.color

					var_49_51.a = var_49_50
					arg_46_1.var_.alphaMatValueC03a.color = var_49_51
				end
			end

			if arg_46_1.time_ >= var_49_46 + var_49_48 and arg_46_1.time_ < var_49_46 + var_49_48 + arg_49_0 and arg_46_1.var_.alphaMatValueC03a then
				local var_49_52 = arg_46_1.var_.alphaMatValueC03a
				local var_49_53 = var_49_52.color

				var_49_53.a = 1
				var_49_52.color = var_49_53
			end

			local var_49_54 = 1.5

			if var_49_54 < arg_46_1.time_ and arg_46_1.time_ <= var_49_54 + arg_49_0 then
				local var_49_55 = manager.ui.mainCamera.transform.localPosition
				local var_49_56 = Vector3.New(0, 0, 10) + Vector3.New(var_49_55.x, var_49_55.y, 0)
				local var_49_57 = arg_46_1.bgs_.C03a

				var_49_57.transform.localPosition = var_49_56
				var_49_57.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_49_58 = var_49_57:GetComponent("SpriteRenderer")

				if var_49_58 and var_49_58.sprite then
					local var_49_59 = (var_49_57.transform.localPosition - var_49_55).z
					local var_49_60 = manager.ui.mainCameraCom_
					local var_49_61 = 2 * var_49_59 * Mathf.Tan(var_49_60.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_49_62 = var_49_61 * var_49_60.aspect
					local var_49_63 = var_49_58.sprite.bounds.size.x
					local var_49_64 = var_49_58.sprite.bounds.size.y
					local var_49_65 = var_49_62 / var_49_63
					local var_49_66 = var_49_61 / var_49_64
					local var_49_67 = var_49_66 < var_49_65 and var_49_65 or var_49_66

					var_49_57.transform.localScale = Vector3.New(var_49_67, var_49_67, 0)
				end

				for iter_49_0, iter_49_1 in pairs(arg_46_1.bgs_) do
					if iter_49_0 ~= "C03a" then
						iter_49_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_49_68 = 0

			if var_49_68 < arg_46_1.time_ and arg_46_1.time_ <= var_49_68 + arg_49_0 then
				arg_46_1.allBtn_.enabled = false
			end

			local var_49_69 = 3

			if arg_46_1.time_ >= var_49_68 + var_49_69 and arg_46_1.time_ < var_49_68 + var_49_69 + arg_49_0 then
				arg_46_1.allBtn_.enabled = true
			end

			if arg_46_1.frameCnt_ <= 1 then
				arg_46_1.dialog_:SetActive(false)
			end

			local var_49_70 = 3
			local var_49_71 = 0.35

			if var_49_70 < arg_46_1.time_ and arg_46_1.time_ <= var_49_70 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0

				arg_46_1.dialog_:SetActive(true)

				arg_46_1.dialogCg_.alpha = 0

				local var_49_72 = LeanTween.value(arg_46_1.dialog_, 0, 1, 0.3)

				var_49_72:setOnUpdate(LuaHelper.FloatAction(function(arg_50_0)
					arg_46_1.dialogCg_.alpha = arg_50_0
				end))
				var_49_72:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_46_1.dialog_)
					var_49_72:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_46_1.duration_ = arg_46_1.duration_ + 0.3

				SetActive(arg_46_1.leftNameGo_, true)

				local var_49_73 = arg_46_1:FormatText(StoryNameCfg[6].name)

				arg_46_1.leftNameTxt_.text = var_49_73

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_46_1.leftNameTxt_.transform)

				arg_46_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_46_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_46_1:RecordName(arg_46_1.leftNameTxt_.text)
				SetActive(arg_46_1.iconTrs_.gameObject, false)
				arg_46_1.callingController_:SetSelectedState("normal")

				local var_49_74 = arg_46_1:GetWordFromCfg(107112011)
				local var_49_75 = arg_46_1:FormatText(var_49_74.content)

				arg_46_1.text_.text = var_49_75

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_76 = 14
				local var_49_77 = utf8.len(var_49_75)
				local var_49_78 = var_49_76 <= 0 and var_49_71 or var_49_71 * (var_49_77 / var_49_76)

				if var_49_78 > 0 and var_49_71 < var_49_78 then
					arg_46_1.talkMaxDuration = var_49_78
					var_49_70 = var_49_70 + 0.3

					if var_49_78 + var_49_70 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_78 + var_49_70
					end
				end

				arg_46_1.text_.text = var_49_75
				arg_46_1.typewritter.percent = 0

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107112", "107112011", "story_v_out_107112.awb") ~= 0 then
					local var_49_79 = manager.audio:GetVoiceLength("story_v_out_107112", "107112011", "story_v_out_107112.awb") / 1000

					if var_49_79 + var_49_70 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_79 + var_49_70
					end

					if var_49_74.prefab_name ~= "" and arg_46_1.actors_[var_49_74.prefab_name] ~= nil then
						local var_49_80 = LuaForUtil.PlayVoiceWithCriLipsync(arg_46_1.actors_[var_49_74.prefab_name].transform, "story_v_out_107112", "107112011", "story_v_out_107112.awb")

						arg_46_1:RecordAudio("107112011", var_49_80)
						arg_46_1:RecordAudio("107112011", var_49_80)
					else
						arg_46_1:AudioAction("play", "voice", "story_v_out_107112", "107112011", "story_v_out_107112.awb")
					end

					arg_46_1:RecordHistoryTalkVoice("story_v_out_107112", "107112011", "story_v_out_107112.awb")
				end

				arg_46_1:RecordContent(arg_46_1.text_.text)
			end

			local var_49_81 = var_49_70 + 0.3
			local var_49_82 = math.max(var_49_71, arg_46_1.talkMaxDuration)

			if var_49_81 <= arg_46_1.time_ and arg_46_1.time_ < var_49_81 + var_49_82 then
				arg_46_1.typewritter.percent = (arg_46_1.time_ - var_49_81) / var_49_82

				arg_46_1.typewritter:SetDirty()
			end

			if arg_46_1.time_ >= var_49_81 + var_49_82 and arg_46_1.time_ < var_49_81 + var_49_82 + arg_49_0 then
				arg_46_1.typewritter.percent = 1

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(true)
			end
		end

		arg_46_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3007_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0329999999999999,
				className = "StoryMoveNode",
				startTime = 3,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 3,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_46_1:InitPlayNodeList()
	end,
	Play107112012 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 107112012
		arg_52_1.duration_ = 7.53

		local var_52_0 = {
			ja = 4.6,
			ko = 6.3,
			zh = 7.133,
			en = 7.533
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
				arg_52_0:Play107112013(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = arg_52_1.actors_["1084ui_story"]
			local var_55_1 = 0

			if var_55_1 < arg_52_1.time_ and arg_52_1.time_ <= var_55_1 + arg_55_0 and not isNil(var_55_0) and arg_52_1.var_.characterEffect1084ui_story == nil then
				arg_52_1.var_.characterEffect1084ui_story = var_55_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_2 = 0.1

			if var_55_1 <= arg_52_1.time_ and arg_52_1.time_ < var_55_1 + var_55_2 and not isNil(var_55_0) then
				local var_55_3 = (arg_52_1.time_ - var_55_1) / var_55_2

				if arg_52_1.var_.characterEffect1084ui_story and not isNil(var_55_0) then
					local var_55_4 = Mathf.Lerp(0, 0.5, var_55_3)

					arg_52_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_52_1.var_.characterEffect1084ui_story.fillRatio = var_55_4
				end
			end

			if arg_52_1.time_ >= var_55_1 + var_55_2 and arg_52_1.time_ < var_55_1 + var_55_2 + arg_55_0 and not isNil(var_55_0) and arg_52_1.var_.characterEffect1084ui_story then
				local var_55_5 = 0.5

				arg_52_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_52_1.var_.characterEffect1084ui_story.fillRatio = var_55_5
			end

			local var_55_6 = 0
			local var_55_7 = 0.85

			if var_55_6 < arg_52_1.time_ and arg_52_1.time_ <= var_55_6 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				local var_55_8 = arg_52_1:FormatText(StoryNameCfg[10].name)

				arg_52_1.leftNameTxt_.text = var_55_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, true)
				arg_52_1.iconController_:SetSelectedState("hero")

				arg_52_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_52_1.callingController_:SetSelectedState("normal")

				arg_52_1.keyicon_.color = Color.New(1, 1, 1)
				arg_52_1.icon_.color = Color.New(1, 1, 1)

				local var_55_9 = arg_52_1:GetWordFromCfg(107112012)
				local var_55_10 = arg_52_1:FormatText(var_55_9.content)

				arg_52_1.text_.text = var_55_10

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_11 = 34
				local var_55_12 = utf8.len(var_55_10)
				local var_55_13 = var_55_11 <= 0 and var_55_7 or var_55_7 * (var_55_12 / var_55_11)

				if var_55_13 > 0 and var_55_7 < var_55_13 then
					arg_52_1.talkMaxDuration = var_55_13

					if var_55_13 + var_55_6 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_13 + var_55_6
					end
				end

				arg_52_1.text_.text = var_55_10
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107112", "107112012", "story_v_out_107112.awb") ~= 0 then
					local var_55_14 = manager.audio:GetVoiceLength("story_v_out_107112", "107112012", "story_v_out_107112.awb") / 1000

					if var_55_14 + var_55_6 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_14 + var_55_6
					end

					if var_55_9.prefab_name ~= "" and arg_52_1.actors_[var_55_9.prefab_name] ~= nil then
						local var_55_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_9.prefab_name].transform, "story_v_out_107112", "107112012", "story_v_out_107112.awb")

						arg_52_1:RecordAudio("107112012", var_55_15)
						arg_52_1:RecordAudio("107112012", var_55_15)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_107112", "107112012", "story_v_out_107112.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_107112", "107112012", "story_v_out_107112.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_16 = math.max(var_55_7, arg_52_1.talkMaxDuration)

			if var_55_6 <= arg_52_1.time_ and arg_52_1.time_ < var_55_6 + var_55_16 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_6) / var_55_16

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_6 + var_55_16 and arg_52_1.time_ < var_55_6 + var_55_16 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play107112013 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 107112013
		arg_56_1.duration_ = 6.6

		local var_56_0 = {
			ja = 6.6,
			ko = 5.2,
			zh = 3.966,
			en = 4
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
				arg_56_0:Play107112014(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = arg_56_1.actors_["1038ui_story"]
			local var_59_1 = 0

			if var_59_1 < arg_56_1.time_ and arg_56_1.time_ <= var_59_1 + arg_59_0 and not isNil(var_59_0) and arg_56_1.var_.characterEffect1038ui_story == nil then
				arg_56_1.var_.characterEffect1038ui_story = var_59_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_2 = 0.1

			if var_59_1 <= arg_56_1.time_ and arg_56_1.time_ < var_59_1 + var_59_2 and not isNil(var_59_0) then
				local var_59_3 = (arg_56_1.time_ - var_59_1) / var_59_2

				if arg_56_1.var_.characterEffect1038ui_story and not isNil(var_59_0) then
					arg_56_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_56_1.time_ >= var_59_1 + var_59_2 and arg_56_1.time_ < var_59_1 + var_59_2 + arg_59_0 and not isNil(var_59_0) and arg_56_1.var_.characterEffect1038ui_story then
				arg_56_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_59_4 = arg_56_1.actors_["1038ui_story"].transform
			local var_59_5 = 0

			if var_59_5 < arg_56_1.time_ and arg_56_1.time_ <= var_59_5 + arg_59_0 then
				arg_56_1.var_.moveOldPos1038ui_story = var_59_4.localPosition
			end

			local var_59_6 = 0.001

			if var_59_5 <= arg_56_1.time_ and arg_56_1.time_ < var_59_5 + var_59_6 then
				local var_59_7 = (arg_56_1.time_ - var_59_5) / var_59_6
				local var_59_8 = Vector3.New(0.7, -1.11, -5.9)

				var_59_4.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos1038ui_story, var_59_8, var_59_7)

				local var_59_9 = manager.ui.mainCamera.transform.position - var_59_4.position

				var_59_4.forward = Vector3.New(var_59_9.x, var_59_9.y, var_59_9.z)

				local var_59_10 = var_59_4.localEulerAngles

				var_59_10.z = 0
				var_59_10.x = 0
				var_59_4.localEulerAngles = var_59_10
			end

			if arg_56_1.time_ >= var_59_5 + var_59_6 and arg_56_1.time_ < var_59_5 + var_59_6 + arg_59_0 then
				var_59_4.localPosition = Vector3.New(0.7, -1.11, -5.9)

				local var_59_11 = manager.ui.mainCamera.transform.position - var_59_4.position

				var_59_4.forward = Vector3.New(var_59_11.x, var_59_11.y, var_59_11.z)

				local var_59_12 = var_59_4.localEulerAngles

				var_59_12.z = 0
				var_59_12.x = 0
				var_59_4.localEulerAngles = var_59_12
			end

			local var_59_13 = 0

			if var_59_13 < arg_56_1.time_ and arg_56_1.time_ <= var_59_13 + arg_59_0 then
				arg_56_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038action/1038action5_1")
			end

			local var_59_14 = 0

			if var_59_14 < arg_56_1.time_ and arg_56_1.time_ <= var_59_14 + arg_59_0 then
				arg_56_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_59_15 = 0
			local var_59_16 = 0.5

			if var_59_15 < arg_56_1.time_ and arg_56_1.time_ <= var_59_15 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				local var_59_17 = arg_56_1:FormatText(StoryNameCfg[94].name)

				arg_56_1.leftNameTxt_.text = var_59_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_18 = arg_56_1:GetWordFromCfg(107112013)
				local var_59_19 = arg_56_1:FormatText(var_59_18.content)

				arg_56_1.text_.text = var_59_19

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_20 = 20
				local var_59_21 = utf8.len(var_59_19)
				local var_59_22 = var_59_20 <= 0 and var_59_16 or var_59_16 * (var_59_21 / var_59_20)

				if var_59_22 > 0 and var_59_16 < var_59_22 then
					arg_56_1.talkMaxDuration = var_59_22

					if var_59_22 + var_59_15 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_22 + var_59_15
					end
				end

				arg_56_1.text_.text = var_59_19
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107112", "107112013", "story_v_out_107112.awb") ~= 0 then
					local var_59_23 = manager.audio:GetVoiceLength("story_v_out_107112", "107112013", "story_v_out_107112.awb") / 1000

					if var_59_23 + var_59_15 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_23 + var_59_15
					end

					if var_59_18.prefab_name ~= "" and arg_56_1.actors_[var_59_18.prefab_name] ~= nil then
						local var_59_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_18.prefab_name].transform, "story_v_out_107112", "107112013", "story_v_out_107112.awb")

						arg_56_1:RecordAudio("107112013", var_59_24)
						arg_56_1:RecordAudio("107112013", var_59_24)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_107112", "107112013", "story_v_out_107112.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_107112", "107112013", "story_v_out_107112.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_25 = math.max(var_59_16, arg_56_1.talkMaxDuration)

			if var_59_15 <= arg_56_1.time_ and arg_56_1.time_ < var_59_15 + var_59_25 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_15) / var_59_25

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_15 + var_59_25 and arg_56_1.time_ < var_59_15 + var_59_25 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_56_1:InitPlayNodeList()
	end,
	Play107112014 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 107112014
		arg_60_1.duration_ = 1.3

		local var_60_0 = {
			ja = 1.266,
			ko = 1.066,
			zh = 1.3,
			en = 1.3
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
				arg_60_0:Play107112015(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = arg_60_1.actors_["1038ui_story"]
			local var_63_1 = 0

			if var_63_1 < arg_60_1.time_ and arg_60_1.time_ <= var_63_1 + arg_63_0 and not isNil(var_63_0) and arg_60_1.var_.characterEffect1038ui_story == nil then
				arg_60_1.var_.characterEffect1038ui_story = var_63_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_2 = 0.1

			if var_63_1 <= arg_60_1.time_ and arg_60_1.time_ < var_63_1 + var_63_2 and not isNil(var_63_0) then
				local var_63_3 = (arg_60_1.time_ - var_63_1) / var_63_2

				if arg_60_1.var_.characterEffect1038ui_story and not isNil(var_63_0) then
					local var_63_4 = Mathf.Lerp(0, 0.5, var_63_3)

					arg_60_1.var_.characterEffect1038ui_story.fillFlat = true
					arg_60_1.var_.characterEffect1038ui_story.fillRatio = var_63_4
				end
			end

			if arg_60_1.time_ >= var_63_1 + var_63_2 and arg_60_1.time_ < var_63_1 + var_63_2 + arg_63_0 and not isNil(var_63_0) and arg_60_1.var_.characterEffect1038ui_story then
				local var_63_5 = 0.5

				arg_60_1.var_.characterEffect1038ui_story.fillFlat = true
				arg_60_1.var_.characterEffect1038ui_story.fillRatio = var_63_5
			end

			local var_63_6 = 0
			local var_63_7 = 0.05

			if var_63_6 < arg_60_1.time_ and arg_60_1.time_ <= var_63_6 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				local var_63_8 = arg_60_1:FormatText(StoryNameCfg[99].name)

				arg_60_1.leftNameTxt_.text = var_63_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, true)
				arg_60_1.iconController_:SetSelectedState("hero")

				arg_60_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10012")

				arg_60_1.callingController_:SetSelectedState("normal")

				arg_60_1.keyicon_.color = Color.New(1, 1, 1)
				arg_60_1.icon_.color = Color.New(1, 1, 1)

				local var_63_9 = arg_60_1:GetWordFromCfg(107112014)
				local var_63_10 = arg_60_1:FormatText(var_63_9.content)

				arg_60_1.text_.text = var_63_10

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_11 = 2
				local var_63_12 = utf8.len(var_63_10)
				local var_63_13 = var_63_11 <= 0 and var_63_7 or var_63_7 * (var_63_12 / var_63_11)

				if var_63_13 > 0 and var_63_7 < var_63_13 then
					arg_60_1.talkMaxDuration = var_63_13

					if var_63_13 + var_63_6 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_13 + var_63_6
					end
				end

				arg_60_1.text_.text = var_63_10
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107112", "107112014", "story_v_out_107112.awb") ~= 0 then
					local var_63_14 = manager.audio:GetVoiceLength("story_v_out_107112", "107112014", "story_v_out_107112.awb") / 1000

					if var_63_14 + var_63_6 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_14 + var_63_6
					end

					if var_63_9.prefab_name ~= "" and arg_60_1.actors_[var_63_9.prefab_name] ~= nil then
						local var_63_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_9.prefab_name].transform, "story_v_out_107112", "107112014", "story_v_out_107112.awb")

						arg_60_1:RecordAudio("107112014", var_63_15)
						arg_60_1:RecordAudio("107112014", var_63_15)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_107112", "107112014", "story_v_out_107112.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_107112", "107112014", "story_v_out_107112.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_16 = math.max(var_63_7, arg_60_1.talkMaxDuration)

			if var_63_6 <= arg_60_1.time_ and arg_60_1.time_ < var_63_6 + var_63_16 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_6) / var_63_16

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_6 + var_63_16 and arg_60_1.time_ < var_63_6 + var_63_16 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play107112015 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 107112015
		arg_64_1.duration_ = 2.7

		local var_64_0 = {
			ja = 2.6,
			ko = 2.533,
			zh = 2.7,
			en = 2.6
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
				arg_64_0:Play107112016(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = arg_64_1.actors_["1038ui_story"].transform
			local var_67_1 = 0

			if var_67_1 < arg_64_1.time_ and arg_64_1.time_ <= var_67_1 + arg_67_0 then
				arg_64_1.var_.moveOldPos1038ui_story = var_67_0.localPosition
			end

			local var_67_2 = 0.001

			if var_67_1 <= arg_64_1.time_ and arg_64_1.time_ < var_67_1 + var_67_2 then
				local var_67_3 = (arg_64_1.time_ - var_67_1) / var_67_2
				local var_67_4 = Vector3.New(0, 100, 0)

				var_67_0.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos1038ui_story, var_67_4, var_67_3)

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

			local var_67_9 = arg_64_1.actors_["1084ui_story"].transform
			local var_67_10 = 0

			if var_67_10 < arg_64_1.time_ and arg_64_1.time_ <= var_67_10 + arg_67_0 then
				arg_64_1.var_.moveOldPos1084ui_story = var_67_9.localPosition
			end

			local var_67_11 = 0.001

			if var_67_10 <= arg_64_1.time_ and arg_64_1.time_ < var_67_10 + var_67_11 then
				local var_67_12 = (arg_64_1.time_ - var_67_10) / var_67_11
				local var_67_13 = Vector3.New(0, 100, 0)

				var_67_9.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos1084ui_story, var_67_13, var_67_12)

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

			local var_67_18 = 0
			local var_67_19 = 0.275

			if var_67_18 < arg_64_1.time_ and arg_64_1.time_ <= var_67_18 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				local var_67_20 = arg_64_1:FormatText(StoryNameCfg[10].name)

				arg_64_1.leftNameTxt_.text = var_67_20

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, true)
				arg_64_1.iconController_:SetSelectedState("hero")

				arg_64_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_64_1.callingController_:SetSelectedState("normal")

				arg_64_1.keyicon_.color = Color.New(1, 1, 1)
				arg_64_1.icon_.color = Color.New(1, 1, 1)

				local var_67_21 = arg_64_1:GetWordFromCfg(107112015)
				local var_67_22 = arg_64_1:FormatText(var_67_21.content)

				arg_64_1.text_.text = var_67_22

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_23 = 11
				local var_67_24 = utf8.len(var_67_22)
				local var_67_25 = var_67_23 <= 0 and var_67_19 or var_67_19 * (var_67_24 / var_67_23)

				if var_67_25 > 0 and var_67_19 < var_67_25 then
					arg_64_1.talkMaxDuration = var_67_25

					if var_67_25 + var_67_18 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_25 + var_67_18
					end
				end

				arg_64_1.text_.text = var_67_22
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107112", "107112015", "story_v_out_107112.awb") ~= 0 then
					local var_67_26 = manager.audio:GetVoiceLength("story_v_out_107112", "107112015", "story_v_out_107112.awb") / 1000

					if var_67_26 + var_67_18 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_26 + var_67_18
					end

					if var_67_21.prefab_name ~= "" and arg_64_1.actors_[var_67_21.prefab_name] ~= nil then
						local var_67_27 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_21.prefab_name].transform, "story_v_out_107112", "107112015", "story_v_out_107112.awb")

						arg_64_1:RecordAudio("107112015", var_67_27)
						arg_64_1:RecordAudio("107112015", var_67_27)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_107112", "107112015", "story_v_out_107112.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_107112", "107112015", "story_v_out_107112.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_28 = math.max(var_67_19, arg_64_1.talkMaxDuration)

			if var_67_18 <= arg_64_1.time_ and arg_64_1.time_ < var_67_18 + var_67_28 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_18) / var_67_28

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_18 + var_67_28 and arg_64_1.time_ < var_67_18 + var_67_28 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_64_1:InitPlayNodeList()
	end,
	Play107112016 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 107112016
		arg_68_1.duration_ = 5.97

		local var_68_0 = {
			ja = 3.666,
			ko = 5,
			zh = 5.966,
			en = 3.966
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
				arg_68_0:Play107112017(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = 0
			local var_71_1 = 0.65

			if var_71_0 < arg_68_1.time_ and arg_68_1.time_ <= var_71_0 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				local var_71_2 = arg_68_1:FormatText(StoryNameCfg[10].name)

				arg_68_1.leftNameTxt_.text = var_71_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, true)
				arg_68_1.iconController_:SetSelectedState("hero")

				arg_68_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_68_1.callingController_:SetSelectedState("normal")

				arg_68_1.keyicon_.color = Color.New(1, 1, 1)
				arg_68_1.icon_.color = Color.New(1, 1, 1)

				local var_71_3 = arg_68_1:GetWordFromCfg(107112016)
				local var_71_4 = arg_68_1:FormatText(var_71_3.content)

				arg_68_1.text_.text = var_71_4

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_5 = 26
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

				if manager.audio:GetVoiceLength("story_v_out_107112", "107112016", "story_v_out_107112.awb") ~= 0 then
					local var_71_8 = manager.audio:GetVoiceLength("story_v_out_107112", "107112016", "story_v_out_107112.awb") / 1000

					if var_71_8 + var_71_0 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_8 + var_71_0
					end

					if var_71_3.prefab_name ~= "" and arg_68_1.actors_[var_71_3.prefab_name] ~= nil then
						local var_71_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_3.prefab_name].transform, "story_v_out_107112", "107112016", "story_v_out_107112.awb")

						arg_68_1:RecordAudio("107112016", var_71_9)
						arg_68_1:RecordAudio("107112016", var_71_9)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_107112", "107112016", "story_v_out_107112.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_107112", "107112016", "story_v_out_107112.awb")
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
	Play107112017 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 107112017
		arg_72_1.duration_ = 12.43

		local var_72_0 = {
			ja = 12.2,
			ko = 12.2,
			zh = 10.9,
			en = 12.433
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
				arg_72_0:Play107112018(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = 0
			local var_75_1 = 1.25

			if var_75_0 < arg_72_1.time_ and arg_72_1.time_ <= var_75_0 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				local var_75_2 = arg_72_1:FormatText(StoryNameCfg[10].name)

				arg_72_1.leftNameTxt_.text = var_75_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, true)
				arg_72_1.iconController_:SetSelectedState("hero")

				arg_72_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_72_1.callingController_:SetSelectedState("normal")

				arg_72_1.keyicon_.color = Color.New(1, 1, 1)
				arg_72_1.icon_.color = Color.New(1, 1, 1)

				local var_75_3 = arg_72_1:GetWordFromCfg(107112017)
				local var_75_4 = arg_72_1:FormatText(var_75_3.content)

				arg_72_1.text_.text = var_75_4

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_5 = 50
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

				if manager.audio:GetVoiceLength("story_v_out_107112", "107112017", "story_v_out_107112.awb") ~= 0 then
					local var_75_8 = manager.audio:GetVoiceLength("story_v_out_107112", "107112017", "story_v_out_107112.awb") / 1000

					if var_75_8 + var_75_0 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_8 + var_75_0
					end

					if var_75_3.prefab_name ~= "" and arg_72_1.actors_[var_75_3.prefab_name] ~= nil then
						local var_75_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_3.prefab_name].transform, "story_v_out_107112", "107112017", "story_v_out_107112.awb")

						arg_72_1:RecordAudio("107112017", var_75_9)
						arg_72_1:RecordAudio("107112017", var_75_9)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_107112", "107112017", "story_v_out_107112.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_107112", "107112017", "story_v_out_107112.awb")
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
	Play107112018 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 107112018
		arg_76_1.duration_ = 5.53

		local var_76_0 = {
			ja = 5.533,
			ko = 3.166,
			zh = 5.033,
			en = 5.233
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
				arg_76_0:Play107112019(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = arg_76_1.actors_["1038ui_story"]
			local var_79_1 = 0

			if var_79_1 < arg_76_1.time_ and arg_76_1.time_ <= var_79_1 + arg_79_0 and not isNil(var_79_0) and arg_76_1.var_.characterEffect1038ui_story == nil then
				arg_76_1.var_.characterEffect1038ui_story = var_79_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_2 = 0.1

			if var_79_1 <= arg_76_1.time_ and arg_76_1.time_ < var_79_1 + var_79_2 and not isNil(var_79_0) then
				local var_79_3 = (arg_76_1.time_ - var_79_1) / var_79_2

				if arg_76_1.var_.characterEffect1038ui_story and not isNil(var_79_0) then
					arg_76_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_76_1.time_ >= var_79_1 + var_79_2 and arg_76_1.time_ < var_79_1 + var_79_2 + arg_79_0 and not isNil(var_79_0) and arg_76_1.var_.characterEffect1038ui_story then
				arg_76_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_79_4 = arg_76_1.actors_["1038ui_story"].transform
			local var_79_5 = 0

			if var_79_5 < arg_76_1.time_ and arg_76_1.time_ <= var_79_5 + arg_79_0 then
				arg_76_1.var_.moveOldPos1038ui_story = var_79_4.localPosition
			end

			local var_79_6 = 0.001

			if var_79_5 <= arg_76_1.time_ and arg_76_1.time_ < var_79_5 + var_79_6 then
				local var_79_7 = (arg_76_1.time_ - var_79_5) / var_79_6
				local var_79_8 = Vector3.New(0, -1.11, -5.9)

				var_79_4.localPosition = Vector3.Lerp(arg_76_1.var_.moveOldPos1038ui_story, var_79_8, var_79_7)

				local var_79_9 = manager.ui.mainCamera.transform.position - var_79_4.position

				var_79_4.forward = Vector3.New(var_79_9.x, var_79_9.y, var_79_9.z)

				local var_79_10 = var_79_4.localEulerAngles

				var_79_10.z = 0
				var_79_10.x = 0
				var_79_4.localEulerAngles = var_79_10
			end

			if arg_76_1.time_ >= var_79_5 + var_79_6 and arg_76_1.time_ < var_79_5 + var_79_6 + arg_79_0 then
				var_79_4.localPosition = Vector3.New(0, -1.11, -5.9)

				local var_79_11 = manager.ui.mainCamera.transform.position - var_79_4.position

				var_79_4.forward = Vector3.New(var_79_11.x, var_79_11.y, var_79_11.z)

				local var_79_12 = var_79_4.localEulerAngles

				var_79_12.z = 0
				var_79_12.x = 0
				var_79_4.localEulerAngles = var_79_12
			end

			local var_79_13 = 0

			if var_79_13 < arg_76_1.time_ and arg_76_1.time_ <= var_79_13 + arg_79_0 then
				arg_76_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038action/1038action3_1")
			end

			local var_79_14 = 0

			if var_79_14 < arg_76_1.time_ and arg_76_1.time_ <= var_79_14 + arg_79_0 then
				arg_76_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_79_15 = 0
			local var_79_16 = 0.35

			if var_79_15 < arg_76_1.time_ and arg_76_1.time_ <= var_79_15 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				local var_79_17 = arg_76_1:FormatText(StoryNameCfg[94].name)

				arg_76_1.leftNameTxt_.text = var_79_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_18 = arg_76_1:GetWordFromCfg(107112018)
				local var_79_19 = arg_76_1:FormatText(var_79_18.content)

				arg_76_1.text_.text = var_79_19

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_20 = 18
				local var_79_21 = utf8.len(var_79_19)
				local var_79_22 = var_79_20 <= 0 and var_79_16 or var_79_16 * (var_79_21 / var_79_20)

				if var_79_22 > 0 and var_79_16 < var_79_22 then
					arg_76_1.talkMaxDuration = var_79_22

					if var_79_22 + var_79_15 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_22 + var_79_15
					end
				end

				arg_76_1.text_.text = var_79_19
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107112", "107112018", "story_v_out_107112.awb") ~= 0 then
					local var_79_23 = manager.audio:GetVoiceLength("story_v_out_107112", "107112018", "story_v_out_107112.awb") / 1000

					if var_79_23 + var_79_15 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_23 + var_79_15
					end

					if var_79_18.prefab_name ~= "" and arg_76_1.actors_[var_79_18.prefab_name] ~= nil then
						local var_79_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_18.prefab_name].transform, "story_v_out_107112", "107112018", "story_v_out_107112.awb")

						arg_76_1:RecordAudio("107112018", var_79_24)
						arg_76_1:RecordAudio("107112018", var_79_24)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_107112", "107112018", "story_v_out_107112.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_107112", "107112018", "story_v_out_107112.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_25 = math.max(var_79_16, arg_76_1.talkMaxDuration)

			if var_79_15 <= arg_76_1.time_ and arg_76_1.time_ < var_79_15 + var_79_25 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_15) / var_79_25

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_15 + var_79_25 and arg_76_1.time_ < var_79_15 + var_79_25 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_76_1:InitPlayNodeList()
	end,
	Play107112019 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 107112019
		arg_80_1.duration_ = 9.6

		local var_80_0 = {
			ja = 8.366,
			ko = 7.333,
			zh = 7,
			en = 9.6
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
				arg_80_0:Play107112020(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = 0

			if var_83_0 < arg_80_1.time_ and arg_80_1.time_ <= var_83_0 + arg_83_0 then
				arg_80_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038actionlink/1038action436")
			end

			local var_83_1 = 0

			if var_83_1 < arg_80_1.time_ and arg_80_1.time_ <= var_83_1 + arg_83_0 then
				arg_80_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_83_2 = 0
			local var_83_3 = 0.9

			if var_83_2 < arg_80_1.time_ and arg_80_1.time_ <= var_83_2 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				local var_83_4 = arg_80_1:FormatText(StoryNameCfg[94].name)

				arg_80_1.leftNameTxt_.text = var_83_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_5 = arg_80_1:GetWordFromCfg(107112019)
				local var_83_6 = arg_80_1:FormatText(var_83_5.content)

				arg_80_1.text_.text = var_83_6

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_7 = 36
				local var_83_8 = utf8.len(var_83_6)
				local var_83_9 = var_83_7 <= 0 and var_83_3 or var_83_3 * (var_83_8 / var_83_7)

				if var_83_9 > 0 and var_83_3 < var_83_9 then
					arg_80_1.talkMaxDuration = var_83_9

					if var_83_9 + var_83_2 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_9 + var_83_2
					end
				end

				arg_80_1.text_.text = var_83_6
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107112", "107112019", "story_v_out_107112.awb") ~= 0 then
					local var_83_10 = manager.audio:GetVoiceLength("story_v_out_107112", "107112019", "story_v_out_107112.awb") / 1000

					if var_83_10 + var_83_2 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_10 + var_83_2
					end

					if var_83_5.prefab_name ~= "" and arg_80_1.actors_[var_83_5.prefab_name] ~= nil then
						local var_83_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_5.prefab_name].transform, "story_v_out_107112", "107112019", "story_v_out_107112.awb")

						arg_80_1:RecordAudio("107112019", var_83_11)
						arg_80_1:RecordAudio("107112019", var_83_11)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_out_107112", "107112019", "story_v_out_107112.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_out_107112", "107112019", "story_v_out_107112.awb")
				end

				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_12 = math.max(var_83_3, arg_80_1.talkMaxDuration)

			if var_83_2 <= arg_80_1.time_ and arg_80_1.time_ < var_83_2 + var_83_12 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_2) / var_83_12

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_2 + var_83_12 and arg_80_1.time_ < var_83_2 + var_83_12 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {}

		arg_80_1:InitPlayNodeList()
	end,
	Play107112020 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 107112020
		arg_84_1.duration_ = 2.67

		local var_84_0 = {
			ja = 2.5,
			ko = 2.6,
			zh = 2.1,
			en = 2.666
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
				arg_84_0:Play107112021(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = arg_84_1.actors_["1038ui_story"]
			local var_87_1 = 0

			if var_87_1 < arg_84_1.time_ and arg_84_1.time_ <= var_87_1 + arg_87_0 and not isNil(var_87_0) and arg_84_1.var_.characterEffect1038ui_story == nil then
				arg_84_1.var_.characterEffect1038ui_story = var_87_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_2 = 0.1

			if var_87_1 <= arg_84_1.time_ and arg_84_1.time_ < var_87_1 + var_87_2 and not isNil(var_87_0) then
				local var_87_3 = (arg_84_1.time_ - var_87_1) / var_87_2

				if arg_84_1.var_.characterEffect1038ui_story and not isNil(var_87_0) then
					local var_87_4 = Mathf.Lerp(0, 0.5, var_87_3)

					arg_84_1.var_.characterEffect1038ui_story.fillFlat = true
					arg_84_1.var_.characterEffect1038ui_story.fillRatio = var_87_4
				end
			end

			if arg_84_1.time_ >= var_87_1 + var_87_2 and arg_84_1.time_ < var_87_1 + var_87_2 + arg_87_0 and not isNil(var_87_0) and arg_84_1.var_.characterEffect1038ui_story then
				local var_87_5 = 0.5

				arg_84_1.var_.characterEffect1038ui_story.fillFlat = true
				arg_84_1.var_.characterEffect1038ui_story.fillRatio = var_87_5
			end

			local var_87_6 = arg_84_1.actors_["1038ui_story"].transform
			local var_87_7 = 0

			if var_87_7 < arg_84_1.time_ and arg_84_1.time_ <= var_87_7 + arg_87_0 then
				arg_84_1.var_.moveOldPos1038ui_story = var_87_6.localPosition
			end

			local var_87_8 = 0.001

			if var_87_7 <= arg_84_1.time_ and arg_84_1.time_ < var_87_7 + var_87_8 then
				local var_87_9 = (arg_84_1.time_ - var_87_7) / var_87_8
				local var_87_10 = Vector3.New(0, 100, 0)

				var_87_6.localPosition = Vector3.Lerp(arg_84_1.var_.moveOldPos1038ui_story, var_87_10, var_87_9)

				local var_87_11 = manager.ui.mainCamera.transform.position - var_87_6.position

				var_87_6.forward = Vector3.New(var_87_11.x, var_87_11.y, var_87_11.z)

				local var_87_12 = var_87_6.localEulerAngles

				var_87_12.z = 0
				var_87_12.x = 0
				var_87_6.localEulerAngles = var_87_12
			end

			if arg_84_1.time_ >= var_87_7 + var_87_8 and arg_84_1.time_ < var_87_7 + var_87_8 + arg_87_0 then
				var_87_6.localPosition = Vector3.New(0, 100, 0)

				local var_87_13 = manager.ui.mainCamera.transform.position - var_87_6.position

				var_87_6.forward = Vector3.New(var_87_13.x, var_87_13.y, var_87_13.z)

				local var_87_14 = var_87_6.localEulerAngles

				var_87_14.z = 0
				var_87_14.x = 0
				var_87_6.localEulerAngles = var_87_14
			end

			local var_87_15 = 0
			local var_87_16 = 0.2

			if var_87_15 < arg_84_1.time_ and arg_84_1.time_ <= var_87_15 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				local var_87_17 = arg_84_1:FormatText(StoryNameCfg[99].name)

				arg_84_1.leftNameTxt_.text = var_87_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, true)
				arg_84_1.iconController_:SetSelectedState("hero")

				arg_84_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10012")

				arg_84_1.callingController_:SetSelectedState("normal")

				arg_84_1.keyicon_.color = Color.New(1, 1, 1)
				arg_84_1.icon_.color = Color.New(1, 1, 1)

				local var_87_18 = arg_84_1:GetWordFromCfg(107112020)
				local var_87_19 = arg_84_1:FormatText(var_87_18.content)

				arg_84_1.text_.text = var_87_19

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_20 = 8
				local var_87_21 = utf8.len(var_87_19)
				local var_87_22 = var_87_20 <= 0 and var_87_16 or var_87_16 * (var_87_21 / var_87_20)

				if var_87_22 > 0 and var_87_16 < var_87_22 then
					arg_84_1.talkMaxDuration = var_87_22

					if var_87_22 + var_87_15 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_22 + var_87_15
					end
				end

				arg_84_1.text_.text = var_87_19
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107112", "107112020", "story_v_out_107112.awb") ~= 0 then
					local var_87_23 = manager.audio:GetVoiceLength("story_v_out_107112", "107112020", "story_v_out_107112.awb") / 1000

					if var_87_23 + var_87_15 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_23 + var_87_15
					end

					if var_87_18.prefab_name ~= "" and arg_84_1.actors_[var_87_18.prefab_name] ~= nil then
						local var_87_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_18.prefab_name].transform, "story_v_out_107112", "107112020", "story_v_out_107112.awb")

						arg_84_1:RecordAudio("107112020", var_87_24)
						arg_84_1:RecordAudio("107112020", var_87_24)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_out_107112", "107112020", "story_v_out_107112.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_out_107112", "107112020", "story_v_out_107112.awb")
				end

				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_25 = math.max(var_87_16, arg_84_1.talkMaxDuration)

			if var_87_15 <= arg_84_1.time_ and arg_84_1.time_ < var_87_15 + var_87_25 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_15) / var_87_25

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_15 + var_87_25 and arg_84_1.time_ < var_87_15 + var_87_25 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_84_1:InitPlayNodeList()
	end,
	Play107112021 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 107112021
		arg_88_1.duration_ = 4.57

		local var_88_0 = {
			ja = 1.999999999999,
			ko = 2.8,
			zh = 4.566,
			en = 4.366
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
				arg_88_0:Play107112022(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = arg_88_1.actors_["3007_tpose"]
			local var_91_1 = 0

			if var_91_1 < arg_88_1.time_ and arg_88_1.time_ <= var_91_1 + arg_91_0 and not isNil(var_91_0) and arg_88_1.var_.characterEffect3007_tpose == nil then
				arg_88_1.var_.characterEffect3007_tpose = var_91_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_2 = 0.1

			if var_91_1 <= arg_88_1.time_ and arg_88_1.time_ < var_91_1 + var_91_2 and not isNil(var_91_0) then
				local var_91_3 = (arg_88_1.time_ - var_91_1) / var_91_2

				if arg_88_1.var_.characterEffect3007_tpose and not isNil(var_91_0) then
					arg_88_1.var_.characterEffect3007_tpose.fillFlat = false
				end
			end

			if arg_88_1.time_ >= var_91_1 + var_91_2 and arg_88_1.time_ < var_91_1 + var_91_2 + arg_91_0 and not isNil(var_91_0) and arg_88_1.var_.characterEffect3007_tpose then
				arg_88_1.var_.characterEffect3007_tpose.fillFlat = false
			end

			local var_91_4 = arg_88_1.actors_["3007_tpose"].transform
			local var_91_5 = 0

			if var_91_5 < arg_88_1.time_ and arg_88_1.time_ <= var_91_5 + arg_91_0 then
				arg_88_1.var_.moveOldPos3007_tpose = var_91_4.localPosition

				local var_91_6 = GameObjectTools.GetOrAddComponent(var_91_4.gameObject, typeof(DynamicBoneHelper))

				if var_91_6 then
					var_91_6:EnableDynamicBone(false)
				end
			end

			local var_91_7 = 0.001

			if var_91_5 <= arg_88_1.time_ and arg_88_1.time_ < var_91_5 + var_91_7 then
				local var_91_8 = (arg_88_1.time_ - var_91_5) / var_91_7
				local var_91_9 = Vector3.New(0, -2.25, -1.9)

				var_91_4.localPosition = Vector3.Lerp(arg_88_1.var_.moveOldPos3007_tpose, var_91_9, var_91_8)

				local var_91_10 = manager.ui.mainCamera.transform.position - var_91_4.position

				var_91_4.forward = Vector3.New(var_91_10.x, var_91_10.y, var_91_10.z)

				local var_91_11 = var_91_4.localEulerAngles

				var_91_11.z = 0
				var_91_11.x = 0
				var_91_4.localEulerAngles = var_91_11
			end

			if arg_88_1.time_ >= var_91_5 + var_91_7 and arg_88_1.time_ < var_91_5 + var_91_7 + arg_91_0 then
				var_91_4.localPosition = Vector3.New(0, -2.25, -1.9)

				local var_91_12 = manager.ui.mainCamera.transform.position - var_91_4.position

				var_91_4.forward = Vector3.New(var_91_12.x, var_91_12.y, var_91_12.z)

				local var_91_13 = var_91_4.localEulerAngles

				var_91_13.z = 0
				var_91_13.x = 0
				var_91_4.localEulerAngles = var_91_13

				local var_91_14 = GameObjectTools.GetOrAddComponent(var_91_4.gameObject, typeof(DynamicBoneHelper))

				if var_91_14 then
					var_91_14:EnableDynamicBone(true)
				end
			end

			local var_91_15 = 0

			if var_91_15 < arg_88_1.time_ and arg_88_1.time_ <= var_91_15 + arg_91_0 then
				arg_88_1:PlayTimeline("3007_tpose", "StoryTimeline/CharAction/story3007/story3007action/3007action1_1")
			end

			local var_91_16 = 0
			local var_91_17 = 0.15

			if var_91_16 < arg_88_1.time_ and arg_88_1.time_ <= var_91_16 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				local var_91_18 = arg_88_1:FormatText(StoryNameCfg[98].name)

				arg_88_1.leftNameTxt_.text = var_91_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_19 = arg_88_1:GetWordFromCfg(107112021)
				local var_91_20 = arg_88_1:FormatText(var_91_19.content)

				arg_88_1.text_.text = var_91_20

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_21 = 6
				local var_91_22 = utf8.len(var_91_20)
				local var_91_23 = var_91_21 <= 0 and var_91_17 or var_91_17 * (var_91_22 / var_91_21)

				if var_91_23 > 0 and var_91_17 < var_91_23 then
					arg_88_1.talkMaxDuration = var_91_23

					if var_91_23 + var_91_16 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_23 + var_91_16
					end
				end

				arg_88_1.text_.text = var_91_20
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107112", "107112021", "story_v_out_107112.awb") ~= 0 then
					local var_91_24 = manager.audio:GetVoiceLength("story_v_out_107112", "107112021", "story_v_out_107112.awb") / 1000

					if var_91_24 + var_91_16 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_24 + var_91_16
					end

					if var_91_19.prefab_name ~= "" and arg_88_1.actors_[var_91_19.prefab_name] ~= nil then
						local var_91_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_88_1.actors_[var_91_19.prefab_name].transform, "story_v_out_107112", "107112021", "story_v_out_107112.awb")

						arg_88_1:RecordAudio("107112021", var_91_25)
						arg_88_1:RecordAudio("107112021", var_91_25)
					else
						arg_88_1:AudioAction("play", "voice", "story_v_out_107112", "107112021", "story_v_out_107112.awb")
					end

					arg_88_1:RecordHistoryTalkVoice("story_v_out_107112", "107112021", "story_v_out_107112.awb")
				end

				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_26 = math.max(var_91_17, arg_88_1.talkMaxDuration)

			if var_91_16 <= arg_88_1.time_ and arg_88_1.time_ < var_91_16 + var_91_26 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_16) / var_91_26

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_16 + var_91_26 and arg_88_1.time_ < var_91_16 + var_91_26 + arg_91_0 then
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
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_88_1:InitPlayNodeList()
	end,
	Play107112022 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 107112022
		arg_92_1.duration_ = 5.83

		local var_92_0 = {
			ja = 5.833,
			ko = 4.966,
			zh = 3.766,
			en = 4.9
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
				arg_92_0:Play107112023(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			local var_95_0 = arg_92_1.actors_["1038ui_story"]
			local var_95_1 = 0

			if var_95_1 < arg_92_1.time_ and arg_92_1.time_ <= var_95_1 + arg_95_0 and not isNil(var_95_0) and arg_92_1.var_.characterEffect1038ui_story == nil then
				arg_92_1.var_.characterEffect1038ui_story = var_95_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_2 = 0.1

			if var_95_1 <= arg_92_1.time_ and arg_92_1.time_ < var_95_1 + var_95_2 and not isNil(var_95_0) then
				local var_95_3 = (arg_92_1.time_ - var_95_1) / var_95_2

				if arg_92_1.var_.characterEffect1038ui_story and not isNil(var_95_0) then
					arg_92_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_92_1.time_ >= var_95_1 + var_95_2 and arg_92_1.time_ < var_95_1 + var_95_2 + arg_95_0 and not isNil(var_95_0) and arg_92_1.var_.characterEffect1038ui_story then
				arg_92_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_95_4 = arg_92_1.actors_["3007_tpose"]
			local var_95_5 = 0

			if var_95_5 < arg_92_1.time_ and arg_92_1.time_ <= var_95_5 + arg_95_0 and not isNil(var_95_4) and arg_92_1.var_.characterEffect3007_tpose == nil then
				arg_92_1.var_.characterEffect3007_tpose = var_95_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_6 = 0.1

			if var_95_5 <= arg_92_1.time_ and arg_92_1.time_ < var_95_5 + var_95_6 and not isNil(var_95_4) then
				local var_95_7 = (arg_92_1.time_ - var_95_5) / var_95_6

				if arg_92_1.var_.characterEffect3007_tpose and not isNil(var_95_4) then
					local var_95_8 = Mathf.Lerp(0, 0.5, var_95_7)

					arg_92_1.var_.characterEffect3007_tpose.fillFlat = true
					arg_92_1.var_.characterEffect3007_tpose.fillRatio = var_95_8
				end
			end

			if arg_92_1.time_ >= var_95_5 + var_95_6 and arg_92_1.time_ < var_95_5 + var_95_6 + arg_95_0 and not isNil(var_95_4) and arg_92_1.var_.characterEffect3007_tpose then
				local var_95_9 = 0.5

				arg_92_1.var_.characterEffect3007_tpose.fillFlat = true
				arg_92_1.var_.characterEffect3007_tpose.fillRatio = var_95_9
			end

			local var_95_10 = arg_92_1.actors_["3007_tpose"].transform
			local var_95_11 = 0

			if var_95_11 < arg_92_1.time_ and arg_92_1.time_ <= var_95_11 + arg_95_0 then
				arg_92_1.var_.moveOldPos3007_tpose = var_95_10.localPosition

				local var_95_12 = GameObjectTools.GetOrAddComponent(var_95_10.gameObject, typeof(DynamicBoneHelper))

				if var_95_12 then
					var_95_12:EnableDynamicBone(false)
				end
			end

			local var_95_13 = 0.001

			if var_95_11 <= arg_92_1.time_ and arg_92_1.time_ < var_95_11 + var_95_13 then
				local var_95_14 = (arg_92_1.time_ - var_95_11) / var_95_13
				local var_95_15 = Vector3.New(0, 100, 0)

				var_95_10.localPosition = Vector3.Lerp(arg_92_1.var_.moveOldPos3007_tpose, var_95_15, var_95_14)

				local var_95_16 = manager.ui.mainCamera.transform.position - var_95_10.position

				var_95_10.forward = Vector3.New(var_95_16.x, var_95_16.y, var_95_16.z)

				local var_95_17 = var_95_10.localEulerAngles

				var_95_17.z = 0
				var_95_17.x = 0
				var_95_10.localEulerAngles = var_95_17
			end

			if arg_92_1.time_ >= var_95_11 + var_95_13 and arg_92_1.time_ < var_95_11 + var_95_13 + arg_95_0 then
				var_95_10.localPosition = Vector3.New(0, 100, 0)

				local var_95_18 = manager.ui.mainCamera.transform.position - var_95_10.position

				var_95_10.forward = Vector3.New(var_95_18.x, var_95_18.y, var_95_18.z)

				local var_95_19 = var_95_10.localEulerAngles

				var_95_19.z = 0
				var_95_19.x = 0
				var_95_10.localEulerAngles = var_95_19

				local var_95_20 = GameObjectTools.GetOrAddComponent(var_95_10.gameObject, typeof(DynamicBoneHelper))

				if var_95_20 then
					var_95_20:EnableDynamicBone(true)
				end
			end

			local var_95_21 = arg_92_1.actors_["1038ui_story"].transform
			local var_95_22 = 0

			if var_95_22 < arg_92_1.time_ and arg_92_1.time_ <= var_95_22 + arg_95_0 then
				arg_92_1.var_.moveOldPos1038ui_story = var_95_21.localPosition
			end

			local var_95_23 = 0.001

			if var_95_22 <= arg_92_1.time_ and arg_92_1.time_ < var_95_22 + var_95_23 then
				local var_95_24 = (arg_92_1.time_ - var_95_22) / var_95_23
				local var_95_25 = Vector3.New(0, -1.11, -5.9)

				var_95_21.localPosition = Vector3.Lerp(arg_92_1.var_.moveOldPos1038ui_story, var_95_25, var_95_24)

				local var_95_26 = manager.ui.mainCamera.transform.position - var_95_21.position

				var_95_21.forward = Vector3.New(var_95_26.x, var_95_26.y, var_95_26.z)

				local var_95_27 = var_95_21.localEulerAngles

				var_95_27.z = 0
				var_95_27.x = 0
				var_95_21.localEulerAngles = var_95_27
			end

			if arg_92_1.time_ >= var_95_22 + var_95_23 and arg_92_1.time_ < var_95_22 + var_95_23 + arg_95_0 then
				var_95_21.localPosition = Vector3.New(0, -1.11, -5.9)

				local var_95_28 = manager.ui.mainCamera.transform.position - var_95_21.position

				var_95_21.forward = Vector3.New(var_95_28.x, var_95_28.y, var_95_28.z)

				local var_95_29 = var_95_21.localEulerAngles

				var_95_29.z = 0
				var_95_29.x = 0
				var_95_21.localEulerAngles = var_95_29
			end

			local var_95_30 = 0

			if var_95_30 < arg_92_1.time_ and arg_92_1.time_ <= var_95_30 + arg_95_0 then
				arg_92_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038action/1038action1_1")
			end

			local var_95_31 = 0

			if var_95_31 < arg_92_1.time_ and arg_92_1.time_ <= var_95_31 + arg_95_0 then
				arg_92_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_95_32 = 0
			local var_95_33 = 0.525

			if var_95_32 < arg_92_1.time_ and arg_92_1.time_ <= var_95_32 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				local var_95_34 = arg_92_1:FormatText(StoryNameCfg[94].name)

				arg_92_1.leftNameTxt_.text = var_95_34

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_35 = arg_92_1:GetWordFromCfg(107112022)
				local var_95_36 = arg_92_1:FormatText(var_95_35.content)

				arg_92_1.text_.text = var_95_36

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_37 = 18
				local var_95_38 = utf8.len(var_95_36)
				local var_95_39 = var_95_37 <= 0 and var_95_33 or var_95_33 * (var_95_38 / var_95_37)

				if var_95_39 > 0 and var_95_33 < var_95_39 then
					arg_92_1.talkMaxDuration = var_95_39

					if var_95_39 + var_95_32 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_39 + var_95_32
					end
				end

				arg_92_1.text_.text = var_95_36
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107112", "107112022", "story_v_out_107112.awb") ~= 0 then
					local var_95_40 = manager.audio:GetVoiceLength("story_v_out_107112", "107112022", "story_v_out_107112.awb") / 1000

					if var_95_40 + var_95_32 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_40 + var_95_32
					end

					if var_95_35.prefab_name ~= "" and arg_92_1.actors_[var_95_35.prefab_name] ~= nil then
						local var_95_41 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_35.prefab_name].transform, "story_v_out_107112", "107112022", "story_v_out_107112.awb")

						arg_92_1:RecordAudio("107112022", var_95_41)
						arg_92_1:RecordAudio("107112022", var_95_41)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_out_107112", "107112022", "story_v_out_107112.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_out_107112", "107112022", "story_v_out_107112.awb")
				end

				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_42 = math.max(var_95_33, arg_92_1.talkMaxDuration)

			if var_95_32 <= arg_92_1.time_ and arg_92_1.time_ < var_95_32 + var_95_42 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_32) / var_95_42

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_32 + var_95_42 and arg_92_1.time_ < var_95_32 + var_95_42 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3007_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1038ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_92_1:InitPlayNodeList()
	end,
	Play107112023 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 107112023
		arg_96_1.duration_ = 9.57

		local var_96_0 = {
			ja = 9.566,
			ko = 6.833,
			zh = 6.366,
			en = 6.6
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
				arg_96_0:Play107112024(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			local var_99_0 = 0

			if var_99_0 < arg_96_1.time_ and arg_96_1.time_ <= var_99_0 + arg_99_0 then
				local var_99_1 = manager.ui.mainCamera.transform.localPosition
				local var_99_2 = Vector3.New(0, 0, 10) + Vector3.New(var_99_1.x, var_99_1.y, 0)
				local var_99_3 = arg_96_1.bgs_.C03a

				var_99_3.transform.localPosition = var_99_2
				var_99_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_99_4 = var_99_3:GetComponent("SpriteRenderer")

				if var_99_4 and var_99_4.sprite then
					local var_99_5 = (var_99_3.transform.localPosition - var_99_1).z
					local var_99_6 = manager.ui.mainCameraCom_
					local var_99_7 = 2 * var_99_5 * Mathf.Tan(var_99_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_99_8 = var_99_7 * var_99_6.aspect
					local var_99_9 = var_99_4.sprite.bounds.size.x
					local var_99_10 = var_99_4.sprite.bounds.size.y
					local var_99_11 = var_99_8 / var_99_9
					local var_99_12 = var_99_7 / var_99_10
					local var_99_13 = var_99_12 < var_99_11 and var_99_11 or var_99_12

					var_99_3.transform.localScale = Vector3.New(var_99_13, var_99_13, 0)
				end

				for iter_99_0, iter_99_1 in pairs(arg_96_1.bgs_) do
					if iter_99_0 ~= "C03a" then
						iter_99_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_99_14 = 0

			if var_99_14 < arg_96_1.time_ and arg_96_1.time_ <= var_99_14 + arg_99_0 then
				arg_96_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038action/1038action5_1")
			end

			local var_99_15 = 0

			if var_99_15 < arg_96_1.time_ and arg_96_1.time_ <= var_99_15 + arg_99_0 then
				arg_96_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_99_16 = 0
			local var_99_17 = 0.65

			if var_99_16 < arg_96_1.time_ and arg_96_1.time_ <= var_99_16 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				local var_99_18 = arg_96_1:FormatText(StoryNameCfg[94].name)

				arg_96_1.leftNameTxt_.text = var_99_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_19 = arg_96_1:GetWordFromCfg(107112023)
				local var_99_20 = arg_96_1:FormatText(var_99_19.content)

				arg_96_1.text_.text = var_99_20

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_21 = 26
				local var_99_22 = utf8.len(var_99_20)
				local var_99_23 = var_99_21 <= 0 and var_99_17 or var_99_17 * (var_99_22 / var_99_21)

				if var_99_23 > 0 and var_99_17 < var_99_23 then
					arg_96_1.talkMaxDuration = var_99_23

					if var_99_23 + var_99_16 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_23 + var_99_16
					end
				end

				arg_96_1.text_.text = var_99_20
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107112", "107112023", "story_v_out_107112.awb") ~= 0 then
					local var_99_24 = manager.audio:GetVoiceLength("story_v_out_107112", "107112023", "story_v_out_107112.awb") / 1000

					if var_99_24 + var_99_16 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_24 + var_99_16
					end

					if var_99_19.prefab_name ~= "" and arg_96_1.actors_[var_99_19.prefab_name] ~= nil then
						local var_99_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_96_1.actors_[var_99_19.prefab_name].transform, "story_v_out_107112", "107112023", "story_v_out_107112.awb")

						arg_96_1:RecordAudio("107112023", var_99_25)
						arg_96_1:RecordAudio("107112023", var_99_25)
					else
						arg_96_1:AudioAction("play", "voice", "story_v_out_107112", "107112023", "story_v_out_107112.awb")
					end

					arg_96_1:RecordHistoryTalkVoice("story_v_out_107112", "107112023", "story_v_out_107112.awb")
				end

				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_26 = math.max(var_99_17, arg_96_1.talkMaxDuration)

			if var_99_16 <= arg_96_1.time_ and arg_96_1.time_ < var_99_16 + var_99_26 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_16) / var_99_26

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_16 + var_99_26 and arg_96_1.time_ < var_99_16 + var_99_26 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {}

		arg_96_1:InitPlayNodeList()
	end,
	Play107112024 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 107112024
		arg_100_1.duration_ = 5

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play107112025(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			local var_103_0 = arg_100_1.actors_["1038ui_story"]
			local var_103_1 = 0

			if var_103_1 < arg_100_1.time_ and arg_100_1.time_ <= var_103_1 + arg_103_0 and not isNil(var_103_0) and arg_100_1.var_.characterEffect1038ui_story == nil then
				arg_100_1.var_.characterEffect1038ui_story = var_103_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_103_2 = 0.1

			if var_103_1 <= arg_100_1.time_ and arg_100_1.time_ < var_103_1 + var_103_2 and not isNil(var_103_0) then
				local var_103_3 = (arg_100_1.time_ - var_103_1) / var_103_2

				if arg_100_1.var_.characterEffect1038ui_story and not isNil(var_103_0) then
					local var_103_4 = Mathf.Lerp(0, 0.5, var_103_3)

					arg_100_1.var_.characterEffect1038ui_story.fillFlat = true
					arg_100_1.var_.characterEffect1038ui_story.fillRatio = var_103_4
				end
			end

			if arg_100_1.time_ >= var_103_1 + var_103_2 and arg_100_1.time_ < var_103_1 + var_103_2 + arg_103_0 and not isNil(var_103_0) and arg_100_1.var_.characterEffect1038ui_story then
				local var_103_5 = 0.5

				arg_100_1.var_.characterEffect1038ui_story.fillFlat = true
				arg_100_1.var_.characterEffect1038ui_story.fillRatio = var_103_5
			end

			local var_103_6 = 0
			local var_103_7 = 0.5

			if var_103_6 < arg_100_1.time_ and arg_100_1.time_ <= var_103_6 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				local var_103_8 = arg_100_1:FormatText(StoryNameCfg[7].name)

				arg_100_1.leftNameTxt_.text = var_103_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, true)
				arg_100_1.iconController_:SetSelectedState("hero")

				arg_100_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_100_1.callingController_:SetSelectedState("normal")

				arg_100_1.keyicon_.color = Color.New(1, 1, 1)
				arg_100_1.icon_.color = Color.New(1, 1, 1)

				local var_103_9 = arg_100_1:GetWordFromCfg(107112024)
				local var_103_10 = arg_100_1:FormatText(var_103_9.content)

				arg_100_1.text_.text = var_103_10

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_11 = 20
				local var_103_12 = utf8.len(var_103_10)
				local var_103_13 = var_103_11 <= 0 and var_103_7 or var_103_7 * (var_103_12 / var_103_11)

				if var_103_13 > 0 and var_103_7 < var_103_13 then
					arg_100_1.talkMaxDuration = var_103_13

					if var_103_13 + var_103_6 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_13 + var_103_6
					end
				end

				arg_100_1.text_.text = var_103_10
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)
				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_14 = math.max(var_103_7, arg_100_1.talkMaxDuration)

			if var_103_6 <= arg_100_1.time_ and arg_100_1.time_ < var_103_6 + var_103_14 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_6) / var_103_14

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_6 + var_103_14 and arg_100_1.time_ < var_103_6 + var_103_14 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {}

		arg_100_1:InitPlayNodeList()
	end,
	Play107112025 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 107112025
		arg_104_1.duration_ = 8

		SetActive(arg_104_1.tipsGo_, false)

		function arg_104_1.onSingleLineFinish_()
			arg_104_1.onSingleLineUpdate_ = nil
			arg_104_1.onSingleLineFinish_ = nil
			arg_104_1.state_ = "waiting"
		end

		function arg_104_1.playNext_(arg_106_0)
			if arg_106_0 == 1 then
				arg_104_0:Play107112026(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			local var_107_0 = arg_104_1.actors_["1038ui_story"].transform
			local var_107_1 = 0

			if var_107_1 < arg_104_1.time_ and arg_104_1.time_ <= var_107_1 + arg_107_0 then
				arg_104_1.var_.moveOldPos1038ui_story = var_107_0.localPosition
			end

			local var_107_2 = 0.001

			if var_107_1 <= arg_104_1.time_ and arg_104_1.time_ < var_107_1 + var_107_2 then
				local var_107_3 = (arg_104_1.time_ - var_107_1) / var_107_2
				local var_107_4 = Vector3.New(0, 100, 0)

				var_107_0.localPosition = Vector3.Lerp(arg_104_1.var_.moveOldPos1038ui_story, var_107_4, var_107_3)

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

			local var_107_9 = arg_104_1.bgs_.C03a
			local var_107_10 = 0

			if var_107_10 < arg_104_1.time_ and arg_104_1.time_ <= var_107_10 + arg_107_0 then
				local var_107_11 = var_107_9:GetComponent("SpriteRenderer")

				if var_107_11 then
					arg_104_1.var_.alphaOldValueC03a = var_107_11.color.a
					arg_104_1.var_.alphaMatValueC03a = var_107_11
				end

				arg_104_1.var_.alphaOldValueC03a = 1
			end

			local var_107_12 = 1.5

			if var_107_10 <= arg_104_1.time_ and arg_104_1.time_ < var_107_10 + var_107_12 then
				local var_107_13 = (arg_104_1.time_ - var_107_10) / var_107_12
				local var_107_14 = Mathf.Lerp(arg_104_1.var_.alphaOldValueC03a, 0, var_107_13)

				if arg_104_1.var_.alphaMatValueC03a then
					local var_107_15 = arg_104_1.var_.alphaMatValueC03a.color

					var_107_15.a = var_107_14
					arg_104_1.var_.alphaMatValueC03a.color = var_107_15
				end
			end

			if arg_104_1.time_ >= var_107_10 + var_107_12 and arg_104_1.time_ < var_107_10 + var_107_12 + arg_107_0 and arg_104_1.var_.alphaMatValueC03a then
				local var_107_16 = arg_104_1.var_.alphaMatValueC03a
				local var_107_17 = var_107_16.color

				var_107_17.a = 0
				var_107_16.color = var_107_17
			end

			local var_107_18 = "C06b"

			if arg_104_1.bgs_[var_107_18] == nil then
				local var_107_19 = Object.Instantiate(arg_104_1.paintGo_)

				var_107_19:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_107_18)
				var_107_19.name = var_107_18
				var_107_19.transform.parent = arg_104_1.stage_.transform
				var_107_19.transform.localPosition = Vector3.New(0, 100, 0)
				arg_104_1.bgs_[var_107_18] = var_107_19
			end

			local var_107_20 = arg_104_1.bgs_.C06b
			local var_107_21 = 1.5

			if var_107_21 < arg_104_1.time_ and arg_104_1.time_ <= var_107_21 + arg_107_0 then
				local var_107_22 = var_107_20:GetComponent("SpriteRenderer")

				if var_107_22 then
					arg_104_1.var_.alphaOldValueC06b = var_107_22.color.a
					arg_104_1.var_.alphaMatValueC06b = var_107_22
				end

				arg_104_1.var_.alphaOldValueC06b = 0
			end

			local var_107_23 = 1.5

			if var_107_21 <= arg_104_1.time_ and arg_104_1.time_ < var_107_21 + var_107_23 then
				local var_107_24 = (arg_104_1.time_ - var_107_21) / var_107_23
				local var_107_25 = Mathf.Lerp(arg_104_1.var_.alphaOldValueC06b, 1, var_107_24)

				if arg_104_1.var_.alphaMatValueC06b then
					local var_107_26 = arg_104_1.var_.alphaMatValueC06b.color

					var_107_26.a = var_107_25
					arg_104_1.var_.alphaMatValueC06b.color = var_107_26
				end
			end

			if arg_104_1.time_ >= var_107_21 + var_107_23 and arg_104_1.time_ < var_107_21 + var_107_23 + arg_107_0 and arg_104_1.var_.alphaMatValueC06b then
				local var_107_27 = arg_104_1.var_.alphaMatValueC06b
				local var_107_28 = var_107_27.color

				var_107_28.a = 1
				var_107_27.color = var_107_28
			end

			local var_107_29 = 1.5

			if var_107_29 < arg_104_1.time_ and arg_104_1.time_ <= var_107_29 + arg_107_0 then
				local var_107_30 = manager.ui.mainCamera.transform.localPosition
				local var_107_31 = Vector3.New(0, 0, 10) + Vector3.New(var_107_30.x, var_107_30.y, 0)
				local var_107_32 = arg_104_1.bgs_.C06b

				var_107_32.transform.localPosition = var_107_31
				var_107_32.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_107_33 = var_107_32:GetComponent("SpriteRenderer")

				if var_107_33 and var_107_33.sprite then
					local var_107_34 = (var_107_32.transform.localPosition - var_107_30).z
					local var_107_35 = manager.ui.mainCameraCom_
					local var_107_36 = 2 * var_107_34 * Mathf.Tan(var_107_35.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_107_37 = var_107_36 * var_107_35.aspect
					local var_107_38 = var_107_33.sprite.bounds.size.x
					local var_107_39 = var_107_33.sprite.bounds.size.y
					local var_107_40 = var_107_37 / var_107_38
					local var_107_41 = var_107_36 / var_107_39
					local var_107_42 = var_107_41 < var_107_40 and var_107_40 or var_107_41

					var_107_32.transform.localScale = Vector3.New(var_107_42, var_107_42, 0)
				end

				for iter_107_0, iter_107_1 in pairs(arg_104_1.bgs_) do
					if iter_107_0 ~= "C06b" then
						iter_107_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_107_43 = 0

			if var_107_43 < arg_104_1.time_ and arg_104_1.time_ <= var_107_43 + arg_107_0 then
				arg_104_1.allBtn_.enabled = false
			end

			local var_107_44 = 3

			if arg_104_1.time_ >= var_107_43 + var_107_44 and arg_104_1.time_ < var_107_43 + var_107_44 + arg_107_0 then
				arg_104_1.allBtn_.enabled = true
			end

			if arg_104_1.frameCnt_ <= 1 then
				arg_104_1.dialog_:SetActive(false)
			end

			local var_107_45 = 3
			local var_107_46 = 0.75

			if var_107_45 < arg_104_1.time_ and arg_104_1.time_ <= var_107_45 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0

				arg_104_1.dialog_:SetActive(true)

				arg_104_1.dialogCg_.alpha = 0

				local var_107_47 = LeanTween.value(arg_104_1.dialog_, 0, 1, 0.3)

				var_107_47:setOnUpdate(LuaHelper.FloatAction(function(arg_108_0)
					arg_104_1.dialogCg_.alpha = arg_108_0
				end))
				var_107_47:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_104_1.dialog_)
					var_107_47:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_104_1.duration_ = arg_104_1.duration_ + 0.3

				SetActive(arg_104_1.leftNameGo_, false)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_48 = arg_104_1:GetWordFromCfg(107112025)
				local var_107_49 = arg_104_1:FormatText(var_107_48.content)

				arg_104_1.text_.text = var_107_49

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_50 = 30
				local var_107_51 = utf8.len(var_107_49)
				local var_107_52 = var_107_50 <= 0 and var_107_46 or var_107_46 * (var_107_51 / var_107_50)

				if var_107_52 > 0 and var_107_46 < var_107_52 then
					arg_104_1.talkMaxDuration = var_107_52
					var_107_45 = var_107_45 + 0.3

					if var_107_52 + var_107_45 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_52 + var_107_45
					end
				end

				arg_104_1.text_.text = var_107_49
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)
				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_53 = var_107_45 + 0.3
			local var_107_54 = math.max(var_107_46, arg_104_1.talkMaxDuration)

			if var_107_53 <= arg_104_1.time_ and arg_104_1.time_ < var_107_53 + var_107_54 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_53) / var_107_54

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_53 + var_107_54 and arg_104_1.time_ < var_107_53 + var_107_54 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038ui_story",
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
	Play107112026 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 107112026
		arg_110_1.duration_ = 2.97

		local var_110_0 = {
			ja = 2.433,
			ko = 2.366,
			zh = 2.766,
			en = 2.966
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
				arg_110_0:Play107112027(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			local var_113_0 = 0
			local var_113_1 = 0.3

			if var_113_0 < arg_110_1.time_ and arg_110_1.time_ <= var_113_0 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				local var_113_2 = arg_110_1:FormatText(StoryNameCfg[93].name)

				arg_110_1.leftNameTxt_.text = var_113_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, false)
				arg_110_1.callingController_:SetSelectedState("normal")

				local var_113_3 = arg_110_1:GetWordFromCfg(107112026)
				local var_113_4 = arg_110_1:FormatText(var_113_3.content)

				arg_110_1.text_.text = var_113_4

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_5 = 12
				local var_113_6 = utf8.len(var_113_4)
				local var_113_7 = var_113_5 <= 0 and var_113_1 or var_113_1 * (var_113_6 / var_113_5)

				if var_113_7 > 0 and var_113_1 < var_113_7 then
					arg_110_1.talkMaxDuration = var_113_7

					if var_113_7 + var_113_0 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_7 + var_113_0
					end
				end

				arg_110_1.text_.text = var_113_4
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107112", "107112026", "story_v_out_107112.awb") ~= 0 then
					local var_113_8 = manager.audio:GetVoiceLength("story_v_out_107112", "107112026", "story_v_out_107112.awb") / 1000

					if var_113_8 + var_113_0 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_8 + var_113_0
					end

					if var_113_3.prefab_name ~= "" and arg_110_1.actors_[var_113_3.prefab_name] ~= nil then
						local var_113_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_110_1.actors_[var_113_3.prefab_name].transform, "story_v_out_107112", "107112026", "story_v_out_107112.awb")

						arg_110_1:RecordAudio("107112026", var_113_9)
						arg_110_1:RecordAudio("107112026", var_113_9)
					else
						arg_110_1:AudioAction("play", "voice", "story_v_out_107112", "107112026", "story_v_out_107112.awb")
					end

					arg_110_1:RecordHistoryTalkVoice("story_v_out_107112", "107112026", "story_v_out_107112.awb")
				end

				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_10 = math.max(var_113_1, arg_110_1.talkMaxDuration)

			if var_113_0 <= arg_110_1.time_ and arg_110_1.time_ < var_113_0 + var_113_10 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_0) / var_113_10

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_0 + var_113_10 and arg_110_1.time_ < var_113_0 + var_113_10 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {}

		arg_110_1:InitPlayNodeList()
	end,
	Play107112027 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 107112027
		arg_114_1.duration_ = 8.1

		local var_114_0 = {
			ja = 7.366,
			ko = 6.466,
			zh = 6.833,
			en = 8.1
		}
		local var_114_1 = manager.audio:GetLocalizationFlag()

		if var_114_0[var_114_1] ~= nil then
			arg_114_1.duration_ = var_114_0[var_114_1]
		end

		SetActive(arg_114_1.tipsGo_, false)

		function arg_114_1.onSingleLineFinish_()
			arg_114_1.onSingleLineUpdate_ = nil
			arg_114_1.onSingleLineFinish_ = nil
			arg_114_1.state_ = "waiting"
		end

		function arg_114_1.playNext_(arg_116_0)
			if arg_116_0 == 1 then
				arg_114_0:Play107112028(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			local var_117_0 = "1058ui_story"

			if arg_114_1.actors_[var_117_0] == nil then
				local var_117_1 = Asset.Load("Char/" .. "1058ui_story")

				if not isNil(var_117_1) then
					local var_117_2 = Object.Instantiate(Asset.Load("Char/" .. "1058ui_story"), arg_114_1.stage_.transform)

					var_117_2.name = var_117_0
					var_117_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_114_1.actors_[var_117_0] = var_117_2

					local var_117_3 = var_117_2:GetComponentInChildren(typeof(CharacterEffect))

					var_117_3.enabled = true

					local var_117_4 = GameObjectTools.GetOrAddComponent(var_117_2, typeof(DynamicBoneHelper))

					if var_117_4 then
						var_117_4:EnableDynamicBone(false)
					end

					arg_114_1:ShowWeapon(var_117_3.transform, false)

					arg_114_1.var_[var_117_0 .. "Animator"] = var_117_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_114_1.var_[var_117_0 .. "Animator"].applyRootMotion = true
					arg_114_1.var_[var_117_0 .. "LipSync"] = var_117_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_117_5 = arg_114_1.actors_["1058ui_story"]
			local var_117_6 = 0

			if var_117_6 < arg_114_1.time_ and arg_114_1.time_ <= var_117_6 + arg_117_0 and not isNil(var_117_5) and arg_114_1.var_.characterEffect1058ui_story == nil then
				arg_114_1.var_.characterEffect1058ui_story = var_117_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_117_7 = 0.1

			if var_117_6 <= arg_114_1.time_ and arg_114_1.time_ < var_117_6 + var_117_7 and not isNil(var_117_5) then
				local var_117_8 = (arg_114_1.time_ - var_117_6) / var_117_7

				if arg_114_1.var_.characterEffect1058ui_story and not isNil(var_117_5) then
					arg_114_1.var_.characterEffect1058ui_story.fillFlat = false
				end
			end

			if arg_114_1.time_ >= var_117_6 + var_117_7 and arg_114_1.time_ < var_117_6 + var_117_7 + arg_117_0 and not isNil(var_117_5) and arg_114_1.var_.characterEffect1058ui_story then
				arg_114_1.var_.characterEffect1058ui_story.fillFlat = false
			end

			local var_117_9 = arg_114_1.actors_["1058ui_story"].transform
			local var_117_10 = 0

			if var_117_10 < arg_114_1.time_ and arg_114_1.time_ <= var_117_10 + arg_117_0 then
				arg_114_1.var_.moveOldPos1058ui_story = var_117_9.localPosition
			end

			local var_117_11 = 0.001

			if var_117_10 <= arg_114_1.time_ and arg_114_1.time_ < var_117_10 + var_117_11 then
				local var_117_12 = (arg_114_1.time_ - var_117_10) / var_117_11
				local var_117_13 = Vector3.New(0, -0.95, -5.88)

				var_117_9.localPosition = Vector3.Lerp(arg_114_1.var_.moveOldPos1058ui_story, var_117_13, var_117_12)

				local var_117_14 = manager.ui.mainCamera.transform.position - var_117_9.position

				var_117_9.forward = Vector3.New(var_117_14.x, var_117_14.y, var_117_14.z)

				local var_117_15 = var_117_9.localEulerAngles

				var_117_15.z = 0
				var_117_15.x = 0
				var_117_9.localEulerAngles = var_117_15
			end

			if arg_114_1.time_ >= var_117_10 + var_117_11 and arg_114_1.time_ < var_117_10 + var_117_11 + arg_117_0 then
				var_117_9.localPosition = Vector3.New(0, -0.95, -5.88)

				local var_117_16 = manager.ui.mainCamera.transform.position - var_117_9.position

				var_117_9.forward = Vector3.New(var_117_16.x, var_117_16.y, var_117_16.z)

				local var_117_17 = var_117_9.localEulerAngles

				var_117_17.z = 0
				var_117_17.x = 0
				var_117_9.localEulerAngles = var_117_17
			end

			local var_117_18 = 0

			if var_117_18 < arg_114_1.time_ and arg_114_1.time_ <= var_117_18 + arg_117_0 then
				arg_114_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/story1058/story1058action/1058action4_1")
			end

			local var_117_19 = 0

			if var_117_19 < arg_114_1.time_ and arg_114_1.time_ <= var_117_19 + arg_117_0 then
				arg_114_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_117_20 = 0
			local var_117_21 = 0.8

			if var_117_20 < arg_114_1.time_ and arg_114_1.time_ <= var_117_20 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, true)

				local var_117_22 = arg_114_1:FormatText(StoryNameCfg[92].name)

				arg_114_1.leftNameTxt_.text = var_117_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_114_1.leftNameTxt_.transform)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1.leftNameTxt_.text)
				SetActive(arg_114_1.iconTrs_.gameObject, false)
				arg_114_1.callingController_:SetSelectedState("normal")

				local var_117_23 = arg_114_1:GetWordFromCfg(107112027)
				local var_117_24 = arg_114_1:FormatText(var_117_23.content)

				arg_114_1.text_.text = var_117_24

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_25 = 32
				local var_117_26 = utf8.len(var_117_24)
				local var_117_27 = var_117_25 <= 0 and var_117_21 or var_117_21 * (var_117_26 / var_117_25)

				if var_117_27 > 0 and var_117_21 < var_117_27 then
					arg_114_1.talkMaxDuration = var_117_27

					if var_117_27 + var_117_20 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_27 + var_117_20
					end
				end

				arg_114_1.text_.text = var_117_24
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107112", "107112027", "story_v_out_107112.awb") ~= 0 then
					local var_117_28 = manager.audio:GetVoiceLength("story_v_out_107112", "107112027", "story_v_out_107112.awb") / 1000

					if var_117_28 + var_117_20 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_28 + var_117_20
					end

					if var_117_23.prefab_name ~= "" and arg_114_1.actors_[var_117_23.prefab_name] ~= nil then
						local var_117_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_114_1.actors_[var_117_23.prefab_name].transform, "story_v_out_107112", "107112027", "story_v_out_107112.awb")

						arg_114_1:RecordAudio("107112027", var_117_29)
						arg_114_1:RecordAudio("107112027", var_117_29)
					else
						arg_114_1:AudioAction("play", "voice", "story_v_out_107112", "107112027", "story_v_out_107112.awb")
					end

					arg_114_1:RecordHistoryTalkVoice("story_v_out_107112", "107112027", "story_v_out_107112.awb")
				end

				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_30 = math.max(var_117_21, arg_114_1.talkMaxDuration)

			if var_117_20 <= arg_114_1.time_ and arg_114_1.time_ < var_117_20 + var_117_30 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - var_117_20) / var_117_30

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= var_117_20 + var_117_30 and arg_114_1.time_ < var_117_20 + var_117_30 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_114_1:InitPlayNodeList()
	end,
	Play107112028 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 107112028
		arg_118_1.duration_ = 3.9

		local var_118_0 = {
			ja = 3.7,
			ko = 3.9,
			zh = 3.5,
			en = 3.266
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
				arg_118_0:Play107112029(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			local var_121_0 = 0

			if var_121_0 < arg_118_1.time_ and arg_118_1.time_ <= var_121_0 + arg_121_0 then
				arg_118_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/story1058/story1058actionlink/1058action442")
			end

			local var_121_1 = 0

			if var_121_1 < arg_118_1.time_ and arg_118_1.time_ <= var_121_1 + arg_121_0 then
				arg_118_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_121_2 = 0
			local var_121_3 = 0.525

			if var_121_2 < arg_118_1.time_ and arg_118_1.time_ <= var_121_2 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, true)

				local var_121_4 = arg_118_1:FormatText(StoryNameCfg[92].name)

				arg_118_1.leftNameTxt_.text = var_121_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_118_1.leftNameTxt_.transform)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1.leftNameTxt_.text)
				SetActive(arg_118_1.iconTrs_.gameObject, false)
				arg_118_1.callingController_:SetSelectedState("normal")

				local var_121_5 = arg_118_1:GetWordFromCfg(107112028)
				local var_121_6 = arg_118_1:FormatText(var_121_5.content)

				arg_118_1.text_.text = var_121_6

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_7 = 21
				local var_121_8 = utf8.len(var_121_6)
				local var_121_9 = var_121_7 <= 0 and var_121_3 or var_121_3 * (var_121_8 / var_121_7)

				if var_121_9 > 0 and var_121_3 < var_121_9 then
					arg_118_1.talkMaxDuration = var_121_9

					if var_121_9 + var_121_2 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_9 + var_121_2
					end
				end

				arg_118_1.text_.text = var_121_6
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107112", "107112028", "story_v_out_107112.awb") ~= 0 then
					local var_121_10 = manager.audio:GetVoiceLength("story_v_out_107112", "107112028", "story_v_out_107112.awb") / 1000

					if var_121_10 + var_121_2 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_10 + var_121_2
					end

					if var_121_5.prefab_name ~= "" and arg_118_1.actors_[var_121_5.prefab_name] ~= nil then
						local var_121_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_118_1.actors_[var_121_5.prefab_name].transform, "story_v_out_107112", "107112028", "story_v_out_107112.awb")

						arg_118_1:RecordAudio("107112028", var_121_11)
						arg_118_1:RecordAudio("107112028", var_121_11)
					else
						arg_118_1:AudioAction("play", "voice", "story_v_out_107112", "107112028", "story_v_out_107112.awb")
					end

					arg_118_1:RecordHistoryTalkVoice("story_v_out_107112", "107112028", "story_v_out_107112.awb")
				end

				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_12 = math.max(var_121_3, arg_118_1.talkMaxDuration)

			if var_121_2 <= arg_118_1.time_ and arg_118_1.time_ < var_121_2 + var_121_12 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - var_121_2) / var_121_12

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= var_121_2 + var_121_12 and arg_118_1.time_ < var_121_2 + var_121_12 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {}

		arg_118_1:InitPlayNodeList()
	end,
	Play107112029 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 107112029
		arg_122_1.duration_ = 6.67

		local var_122_0 = {
			ja = 3.9,
			ko = 3.066,
			zh = 5.4,
			en = 6.666
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
			arg_122_1.auto_ = false
		end

		function arg_122_1.playNext_(arg_124_0)
			arg_122_1.onStoryFinished_()
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			local var_125_0 = arg_122_1.actors_["1058ui_story"]
			local var_125_1 = 0

			if var_125_1 < arg_122_1.time_ and arg_122_1.time_ <= var_125_1 + arg_125_0 and not isNil(var_125_0) and arg_122_1.var_.characterEffect1058ui_story == nil then
				arg_122_1.var_.characterEffect1058ui_story = var_125_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_125_2 = 0.1

			if var_125_1 <= arg_122_1.time_ and arg_122_1.time_ < var_125_1 + var_125_2 and not isNil(var_125_0) then
				local var_125_3 = (arg_122_1.time_ - var_125_1) / var_125_2

				if arg_122_1.var_.characterEffect1058ui_story and not isNil(var_125_0) then
					local var_125_4 = Mathf.Lerp(0, 0.5, var_125_3)

					arg_122_1.var_.characterEffect1058ui_story.fillFlat = true
					arg_122_1.var_.characterEffect1058ui_story.fillRatio = var_125_4
				end
			end

			if arg_122_1.time_ >= var_125_1 + var_125_2 and arg_122_1.time_ < var_125_1 + var_125_2 + arg_125_0 and not isNil(var_125_0) and arg_122_1.var_.characterEffect1058ui_story then
				local var_125_5 = 0.5

				arg_122_1.var_.characterEffect1058ui_story.fillFlat = true
				arg_122_1.var_.characterEffect1058ui_story.fillRatio = var_125_5
			end

			local var_125_6 = 0
			local var_125_7 = 0.45

			if var_125_6 < arg_122_1.time_ and arg_122_1.time_ <= var_125_6 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, true)

				local var_125_8 = arg_122_1:FormatText(StoryNameCfg[93].name)

				arg_122_1.leftNameTxt_.text = var_125_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_122_1.leftNameTxt_.transform)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1.leftNameTxt_.text)
				SetActive(arg_122_1.iconTrs_.gameObject, true)
				arg_122_1.iconController_:SetSelectedState("hero")

				arg_122_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2095")

				arg_122_1.callingController_:SetSelectedState("normal")

				arg_122_1.keyicon_.color = Color.New(1, 1, 1)
				arg_122_1.icon_.color = Color.New(1, 1, 1)

				local var_125_9 = arg_122_1:GetWordFromCfg(107112029)
				local var_125_10 = arg_122_1:FormatText(var_125_9.content)

				arg_122_1.text_.text = var_125_10

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_11 = 18
				local var_125_12 = utf8.len(var_125_10)
				local var_125_13 = var_125_11 <= 0 and var_125_7 or var_125_7 * (var_125_12 / var_125_11)

				if var_125_13 > 0 and var_125_7 < var_125_13 then
					arg_122_1.talkMaxDuration = var_125_13

					if var_125_13 + var_125_6 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_13 + var_125_6
					end
				end

				arg_122_1.text_.text = var_125_10
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107112", "107112029", "story_v_out_107112.awb") ~= 0 then
					local var_125_14 = manager.audio:GetVoiceLength("story_v_out_107112", "107112029", "story_v_out_107112.awb") / 1000

					if var_125_14 + var_125_6 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_14 + var_125_6
					end

					if var_125_9.prefab_name ~= "" and arg_122_1.actors_[var_125_9.prefab_name] ~= nil then
						local var_125_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_122_1.actors_[var_125_9.prefab_name].transform, "story_v_out_107112", "107112029", "story_v_out_107112.awb")

						arg_122_1:RecordAudio("107112029", var_125_15)
						arg_122_1:RecordAudio("107112029", var_125_15)
					else
						arg_122_1:AudioAction("play", "voice", "story_v_out_107112", "107112029", "story_v_out_107112.awb")
					end

					arg_122_1:RecordHistoryTalkVoice("story_v_out_107112", "107112029", "story_v_out_107112.awb")
				end

				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_16 = math.max(var_125_7, arg_122_1.talkMaxDuration)

			if var_125_6 <= arg_122_1.time_ and arg_122_1.time_ < var_125_6 + var_125_16 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_6) / var_125_16

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_6 + var_125_16 and arg_122_1.time_ < var_125_6 + var_125_16 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {}

		arg_122_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/C03a",
		"TextureConfig/Background/S0704",
		"TextureConfig/Background/C06b"
	},
	voices = {
		"story_v_out_107112.awb"
	}
}
