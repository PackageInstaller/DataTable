return {
	Play110152001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 110152001
		arg_1_1.duration_ = 7.57

		local var_1_0 = {
			ja = 5.033,
			ko = 7.566,
			zh = 7.166,
			en = 5.366
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
				arg_1_0:Play110152002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "B12a"

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
				local var_4_5 = arg_1_1.bgs_.B12a

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
					if iter_4_0 ~= "B12a" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = "1184ui_story"

			if arg_1_1.actors_[var_4_16] == nil then
				local var_4_17 = Asset.Load("Char/" .. "1184ui_story")

				if not isNil(var_4_17) then
					local var_4_18 = Object.Instantiate(Asset.Load("Char/" .. "1184ui_story"), arg_1_1.stage_.transform)

					var_4_18.name = var_4_16
					var_4_18.transform.localPosition = Vector3.New(0, 100, 0)
					arg_1_1.actors_[var_4_16] = var_4_18

					local var_4_19 = var_4_18:GetComponentInChildren(typeof(CharacterEffect))

					var_4_19.enabled = true

					local var_4_20 = GameObjectTools.GetOrAddComponent(var_4_18, typeof(DynamicBoneHelper))

					if var_4_20 then
						var_4_20:EnableDynamicBone(false)
					end

					arg_1_1:ShowWeapon(var_4_19.transform, false)

					arg_1_1.var_[var_4_16 .. "Animator"] = var_4_19.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_1_1.var_[var_4_16 .. "Animator"].applyRootMotion = true
					arg_1_1.var_[var_4_16 .. "LipSync"] = var_4_19.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_4_21 = arg_1_1.actors_["1184ui_story"].transform
			local var_4_22 = 1.8

			if var_4_22 < arg_1_1.time_ and arg_1_1.time_ <= var_4_22 + arg_4_0 then
				arg_1_1.var_.moveOldPos1184ui_story = var_4_21.localPosition
			end

			local var_4_23 = 0.001

			if var_4_22 <= arg_1_1.time_ and arg_1_1.time_ < var_4_22 + var_4_23 then
				local var_4_24 = (arg_1_1.time_ - var_4_22) / var_4_23
				local var_4_25 = Vector3.New(0, -0.97, -6)

				var_4_21.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1184ui_story, var_4_25, var_4_24)

				local var_4_26 = manager.ui.mainCamera.transform.position - var_4_21.position

				var_4_21.forward = Vector3.New(var_4_26.x, var_4_26.y, var_4_26.z)

				local var_4_27 = var_4_21.localEulerAngles

				var_4_27.z = 0
				var_4_27.x = 0
				var_4_21.localEulerAngles = var_4_27
			end

			if arg_1_1.time_ >= var_4_22 + var_4_23 and arg_1_1.time_ < var_4_22 + var_4_23 + arg_4_0 then
				var_4_21.localPosition = Vector3.New(0, -0.97, -6)

				local var_4_28 = manager.ui.mainCamera.transform.position - var_4_21.position

				var_4_21.forward = Vector3.New(var_4_28.x, var_4_28.y, var_4_28.z)

				local var_4_29 = var_4_21.localEulerAngles

				var_4_29.z = 0
				var_4_29.x = 0
				var_4_21.localEulerAngles = var_4_29
			end

			local var_4_30 = 1.8

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				arg_1_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action4_1")
			end

			local var_4_31 = 1.8

			if var_4_31 < arg_1_1.time_ and arg_1_1.time_ <= var_4_31 + arg_4_0 then
				arg_1_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_4_32 = arg_1_1.bgs_.B12a
			local var_4_33 = 0

			if var_4_33 < arg_1_1.time_ and arg_1_1.time_ <= var_4_33 + arg_4_0 then
				local var_4_34 = var_4_32:GetComponent("SpriteRenderer")

				if var_4_34 then
					arg_1_1.var_.alphaOldValueB12a = var_4_34.color.a
					arg_1_1.var_.alphaMatValueB12a = var_4_34
				end

				arg_1_1.var_.alphaOldValueB12a = 0
			end

			local var_4_35 = 1.5

			if var_4_33 <= arg_1_1.time_ and arg_1_1.time_ < var_4_33 + var_4_35 then
				local var_4_36 = (arg_1_1.time_ - var_4_33) / var_4_35
				local var_4_37 = Mathf.Lerp(arg_1_1.var_.alphaOldValueB12a, 1, var_4_36)

				if arg_1_1.var_.alphaMatValueB12a then
					local var_4_38 = arg_1_1.var_.alphaMatValueB12a.color

					var_4_38.a = var_4_37
					arg_1_1.var_.alphaMatValueB12a.color = var_4_38
				end
			end

			if arg_1_1.time_ >= var_4_33 + var_4_35 and arg_1_1.time_ < var_4_33 + var_4_35 + arg_4_0 and arg_1_1.var_.alphaMatValueB12a then
				local var_4_39 = arg_1_1.var_.alphaMatValueB12a
				local var_4_40 = var_4_39.color

				var_4_40.a = 1
				var_4_39.color = var_4_40
			end

			local var_4_41 = manager.ui.mainCamera.transform
			local var_4_42 = 0.5

			if var_4_42 < arg_1_1.time_ and arg_1_1.time_ <= var_4_42 + arg_4_0 then
				arg_1_1.var_.shakeOldPos = var_4_41.localPosition
			end

			local var_4_43 = 1

			if var_4_42 <= arg_1_1.time_ and arg_1_1.time_ < var_4_42 + var_4_43 then
				local var_4_44 = (arg_1_1.time_ - var_4_42) / 0.066
				local var_4_45, var_4_46 = math.modf(var_4_44)

				var_4_41.localPosition = Vector3.New(var_4_46 * 0.13, var_4_46 * 0.13, var_4_46 * 0.13) + arg_1_1.var_.shakeOldPos
			end

			if arg_1_1.time_ >= var_4_42 + var_4_43 and arg_1_1.time_ < var_4_42 + var_4_43 + arg_4_0 then
				var_4_41.localPosition = arg_1_1.var_.shakeOldPos
			end

			local var_4_47 = arg_1_1.actors_["1184ui_story"]
			local var_4_48 = 1.8

			if var_4_48 < arg_1_1.time_ and arg_1_1.time_ <= var_4_48 + arg_4_0 and not isNil(var_4_47) and arg_1_1.var_.characterEffect1184ui_story == nil then
				arg_1_1.var_.characterEffect1184ui_story = var_4_47:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_49 = 0.2

			if var_4_48 <= arg_1_1.time_ and arg_1_1.time_ < var_4_48 + var_4_49 and not isNil(var_4_47) then
				local var_4_50 = (arg_1_1.time_ - var_4_48) / var_4_49

				if arg_1_1.var_.characterEffect1184ui_story and not isNil(var_4_47) then
					arg_1_1.var_.characterEffect1184ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= var_4_48 + var_4_49 and arg_1_1.time_ < var_4_48 + var_4_49 + arg_4_0 and not isNil(var_4_47) and arg_1_1.var_.characterEffect1184ui_story then
				arg_1_1.var_.characterEffect1184ui_story.fillFlat = false
			end

			local var_4_51 = 0

			if var_4_51 < arg_1_1.time_ and arg_1_1.time_ <= var_4_51 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_52 = 2

			if arg_1_1.time_ >= var_4_51 + var_4_52 and arg_1_1.time_ < var_4_51 + var_4_52 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_53 = 0
			local var_4_54 = 0.6

			if var_4_53 < arg_1_1.time_ and arg_1_1.time_ <= var_4_53 + arg_4_0 then
				local var_4_55 = "play"
				local var_4_56 = "music"

				arg_1_1:AudioAction(var_4_55, var_4_56, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_57 = ""
				local var_4_58 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_58 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_58 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_58

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_58
						arg_1_1.bgmTxt2_.text = var_4_58
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

			local var_4_59 = 0.738461699336767
			local var_4_60 = 1

			if var_4_59 < arg_1_1.time_ and arg_1_1.time_ <= var_4_59 + arg_4_0 then
				local var_4_61 = "play"
				local var_4_62 = "music"

				arg_1_1:AudioAction(var_4_61, var_4_62, "bgm_story_v1_battleground_2", "bgm_story_v1_battleground_2", "bgm_story_v1_battleground_2.awb")

				local var_4_63 = ""
				local var_4_64 = manager.audio:GetAudioName("bgm_story_v1_battleground_2", "bgm_story_v1_battleground_2")

				if var_4_64 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_64 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_64

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_64
						arg_1_1.bgmTxt2_.text = var_4_64
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

			local var_4_65 = 2
			local var_4_66 = 0.475

			if var_4_65 < arg_1_1.time_ and arg_1_1.time_ <= var_4_65 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_67 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_67:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_67:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_67:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_68 = arg_1_1:FormatText(StoryNameCfg[6].name)

				arg_1_1.leftNameTxt_.text = var_4_68

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_69 = arg_1_1:GetWordFromCfg(110152001)
				local var_4_70 = arg_1_1:FormatText(var_4_69.content)

				arg_1_1.text_.text = var_4_70

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_71 = 19
				local var_4_72 = utf8.len(var_4_70)
				local var_4_73 = var_4_71 <= 0 and var_4_66 or var_4_66 * (var_4_72 / var_4_71)

				if var_4_73 > 0 and var_4_66 < var_4_73 then
					arg_1_1.talkMaxDuration = var_4_73
					var_4_65 = var_4_65 + 0.3

					if var_4_73 + var_4_65 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_73 + var_4_65
					end
				end

				arg_1_1.text_.text = var_4_70
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_110152", "110152001", "story_v_out_110152.awb") ~= 0 then
					local var_4_74 = manager.audio:GetVoiceLength("story_v_out_110152", "110152001", "story_v_out_110152.awb") / 1000

					if var_4_74 + var_4_65 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_74 + var_4_65
					end

					if var_4_69.prefab_name ~= "" and arg_1_1.actors_[var_4_69.prefab_name] ~= nil then
						local var_4_75 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_69.prefab_name].transform, "story_v_out_110152", "110152001", "story_v_out_110152.awb")

						arg_1_1:RecordAudio("110152001", var_4_75)
						arg_1_1:RecordAudio("110152001", var_4_75)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_110152", "110152001", "story_v_out_110152.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_110152", "110152001", "story_v_out_110152.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_76 = var_4_65 + 0.3
			local var_4_77 = math.max(var_4_66, arg_1_1.talkMaxDuration)

			if var_4_76 <= arg_1_1.time_ and arg_1_1.time_ < var_4_76 + var_4_77 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_76) / var_4_77

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_76 + var_4_77 and arg_1_1.time_ < var_4_76 + var_4_77 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play110152002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 110152002
		arg_9_1.duration_ = 7.77

		local var_9_0 = {
			ja = 5.833,
			ko = 7.5,
			zh = 5.766,
			en = 7.766
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
				arg_9_0:Play110152003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = arg_9_1.actors_["1184ui_story"].transform
			local var_12_1 = 0

			if var_12_1 < arg_9_1.time_ and arg_9_1.time_ <= var_12_1 + arg_12_0 then
				arg_9_1.var_.moveOldPos1184ui_story = var_12_0.localPosition
			end

			local var_12_2 = 0.001

			if var_12_1 <= arg_9_1.time_ and arg_9_1.time_ < var_12_1 + var_12_2 then
				local var_12_3 = (arg_9_1.time_ - var_12_1) / var_12_2
				local var_12_4 = Vector3.New(0, 100, 0)

				var_12_0.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1184ui_story, var_12_4, var_12_3)

				local var_12_5 = manager.ui.mainCamera.transform.position - var_12_0.position

				var_12_0.forward = Vector3.New(var_12_5.x, var_12_5.y, var_12_5.z)

				local var_12_6 = var_12_0.localEulerAngles

				var_12_6.z = 0
				var_12_6.x = 0
				var_12_0.localEulerAngles = var_12_6
			end

			if arg_9_1.time_ >= var_12_1 + var_12_2 and arg_9_1.time_ < var_12_1 + var_12_2 + arg_12_0 then
				var_12_0.localPosition = Vector3.New(0, 100, 0)

				local var_12_7 = manager.ui.mainCamera.transform.position - var_12_0.position

				var_12_0.forward = Vector3.New(var_12_7.x, var_12_7.y, var_12_7.z)

				local var_12_8 = var_12_0.localEulerAngles

				var_12_8.z = 0
				var_12_8.x = 0
				var_12_0.localEulerAngles = var_12_8
			end

			local var_12_9 = 0
			local var_12_10 = 0.725

			if var_12_9 < arg_9_1.time_ and arg_9_1.time_ <= var_12_9 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_11 = arg_9_1:FormatText(StoryNameCfg[10].name)

				arg_9_1.leftNameTxt_.text = var_12_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, true)
				arg_9_1.iconController_:SetSelectedState("hero")

				arg_9_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_9_1.callingController_:SetSelectedState("normal")

				arg_9_1.keyicon_.color = Color.New(1, 1, 1)
				arg_9_1.icon_.color = Color.New(1, 1, 1)

				local var_12_12 = arg_9_1:GetWordFromCfg(110152002)
				local var_12_13 = arg_9_1:FormatText(var_12_12.content)

				arg_9_1.text_.text = var_12_13

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_14 = 29
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

				if manager.audio:GetVoiceLength("story_v_out_110152", "110152002", "story_v_out_110152.awb") ~= 0 then
					local var_12_17 = manager.audio:GetVoiceLength("story_v_out_110152", "110152002", "story_v_out_110152.awb") / 1000

					if var_12_17 + var_12_9 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_17 + var_12_9
					end

					if var_12_12.prefab_name ~= "" and arg_9_1.actors_[var_12_12.prefab_name] ~= nil then
						local var_12_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_12.prefab_name].transform, "story_v_out_110152", "110152002", "story_v_out_110152.awb")

						arg_9_1:RecordAudio("110152002", var_12_18)
						arg_9_1:RecordAudio("110152002", var_12_18)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_110152", "110152002", "story_v_out_110152.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_110152", "110152002", "story_v_out_110152.awb")
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

		arg_9_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_9_1:InitPlayNodeList()
	end,
	Play110152003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 110152003
		arg_13_1.duration_ = 6.07

		local var_13_0 = {
			ja = 6.066,
			ko = 5.2,
			zh = 3.4,
			en = 4.733
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
				arg_13_0:Play110152004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0

			if var_16_0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_0 + arg_16_0 then
				arg_13_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_16_1 = arg_13_1.actors_["1184ui_story"]
			local var_16_2 = 0

			if var_16_2 < arg_13_1.time_ and arg_13_1.time_ <= var_16_2 + arg_16_0 and not isNil(var_16_1) and arg_13_1.var_.characterEffect1184ui_story == nil then
				arg_13_1.var_.characterEffect1184ui_story = var_16_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_3 = 0.2

			if var_16_2 <= arg_13_1.time_ and arg_13_1.time_ < var_16_2 + var_16_3 and not isNil(var_16_1) then
				local var_16_4 = (arg_13_1.time_ - var_16_2) / var_16_3

				if arg_13_1.var_.characterEffect1184ui_story and not isNil(var_16_1) then
					arg_13_1.var_.characterEffect1184ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= var_16_2 + var_16_3 and arg_13_1.time_ < var_16_2 + var_16_3 + arg_16_0 and not isNil(var_16_1) and arg_13_1.var_.characterEffect1184ui_story then
				arg_13_1.var_.characterEffect1184ui_story.fillFlat = false
			end

			local var_16_5 = 0

			if var_16_5 < arg_13_1.time_ and arg_13_1.time_ <= var_16_5 + arg_16_0 then
				arg_13_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			local var_16_6 = arg_13_1.actors_["1184ui_story"].transform
			local var_16_7 = 0

			if var_16_7 < arg_13_1.time_ and arg_13_1.time_ <= var_16_7 + arg_16_0 then
				arg_13_1.var_.moveOldPos1184ui_story = var_16_6.localPosition

				local var_16_8 = "1184ui_story"

				arg_13_1:ShowWeapon(arg_13_1.var_[var_16_8 .. "Animator"].transform, false)
			end

			local var_16_9 = 0.001

			if var_16_7 <= arg_13_1.time_ and arg_13_1.time_ < var_16_7 + var_16_9 then
				local var_16_10 = (arg_13_1.time_ - var_16_7) / var_16_9
				local var_16_11 = Vector3.New(0, -0.97, -6)

				var_16_6.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1184ui_story, var_16_11, var_16_10)

				local var_16_12 = manager.ui.mainCamera.transform.position - var_16_6.position

				var_16_6.forward = Vector3.New(var_16_12.x, var_16_12.y, var_16_12.z)

				local var_16_13 = var_16_6.localEulerAngles

				var_16_13.z = 0
				var_16_13.x = 0
				var_16_6.localEulerAngles = var_16_13
			end

			if arg_13_1.time_ >= var_16_7 + var_16_9 and arg_13_1.time_ < var_16_7 + var_16_9 + arg_16_0 then
				var_16_6.localPosition = Vector3.New(0, -0.97, -6)

				local var_16_14 = manager.ui.mainCamera.transform.position - var_16_6.position

				var_16_6.forward = Vector3.New(var_16_14.x, var_16_14.y, var_16_14.z)

				local var_16_15 = var_16_6.localEulerAngles

				var_16_15.z = 0
				var_16_15.x = 0
				var_16_6.localEulerAngles = var_16_15
			end

			local var_16_16 = 0
			local var_16_17 = 0.45

			if var_16_16 < arg_13_1.time_ and arg_13_1.time_ <= var_16_16 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_18 = arg_13_1:FormatText(StoryNameCfg[6].name)

				arg_13_1.leftNameTxt_.text = var_16_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_19 = arg_13_1:GetWordFromCfg(110152003)
				local var_16_20 = arg_13_1:FormatText(var_16_19.content)

				arg_13_1.text_.text = var_16_20

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_21 = 18
				local var_16_22 = utf8.len(var_16_20)
				local var_16_23 = var_16_21 <= 0 and var_16_17 or var_16_17 * (var_16_22 / var_16_21)

				if var_16_23 > 0 and var_16_17 < var_16_23 then
					arg_13_1.talkMaxDuration = var_16_23

					if var_16_23 + var_16_16 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_23 + var_16_16
					end
				end

				arg_13_1.text_.text = var_16_20
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_110152", "110152003", "story_v_out_110152.awb") ~= 0 then
					local var_16_24 = manager.audio:GetVoiceLength("story_v_out_110152", "110152003", "story_v_out_110152.awb") / 1000

					if var_16_24 + var_16_16 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_24 + var_16_16
					end

					if var_16_19.prefab_name ~= "" and arg_13_1.actors_[var_16_19.prefab_name] ~= nil then
						local var_16_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_19.prefab_name].transform, "story_v_out_110152", "110152003", "story_v_out_110152.awb")

						arg_13_1:RecordAudio("110152003", var_16_25)
						arg_13_1:RecordAudio("110152003", var_16_25)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_110152", "110152003", "story_v_out_110152.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_110152", "110152003", "story_v_out_110152.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_26 = math.max(var_16_17, arg_13_1.talkMaxDuration)

			if var_16_16 <= arg_13_1.time_ and arg_13_1.time_ < var_16_16 + var_16_26 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_16) / var_16_26

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_16 + var_16_26 and arg_13_1.time_ < var_16_16 + var_16_26 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
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
	Play110152004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 110152004
		arg_17_1.duration_ = 16.43

		local var_17_0 = {
			ja = 16.433,
			ko = 13.8,
			zh = 12.833,
			en = 15.166
		}
		local var_17_1 = manager.audio:GetLocalizationFlag()

		if var_17_0[var_17_1] ~= nil then
			arg_17_1.duration_ = var_17_0[var_17_1]
		end

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play110152005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = arg_17_1.actors_["1184ui_story"]
			local var_20_1 = 0

			if var_20_1 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.characterEffect1184ui_story == nil then
				arg_17_1.var_.characterEffect1184ui_story = var_20_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_2 = 0.2

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_2 and not isNil(var_20_0) then
				local var_20_3 = (arg_17_1.time_ - var_20_1) / var_20_2

				if arg_17_1.var_.characterEffect1184ui_story and not isNil(var_20_0) then
					local var_20_4 = Mathf.Lerp(0, 0.5, var_20_3)

					arg_17_1.var_.characterEffect1184ui_story.fillFlat = true
					arg_17_1.var_.characterEffect1184ui_story.fillRatio = var_20_4
				end
			end

			if arg_17_1.time_ >= var_20_1 + var_20_2 and arg_17_1.time_ < var_20_1 + var_20_2 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.characterEffect1184ui_story then
				local var_20_5 = 0.5

				arg_17_1.var_.characterEffect1184ui_story.fillFlat = true
				arg_17_1.var_.characterEffect1184ui_story.fillRatio = var_20_5
			end

			local var_20_6 = 0
			local var_20_7 = 1.775

			if var_20_6 < arg_17_1.time_ and arg_17_1.time_ <= var_20_6 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_8 = arg_17_1:FormatText(StoryNameCfg[10].name)

				arg_17_1.leftNameTxt_.text = var_20_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, true)
				arg_17_1.iconController_:SetSelectedState("hero")

				arg_17_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_17_1.callingController_:SetSelectedState("normal")

				arg_17_1.keyicon_.color = Color.New(1, 1, 1)
				arg_17_1.icon_.color = Color.New(1, 1, 1)

				local var_20_9 = arg_17_1:GetWordFromCfg(110152004)
				local var_20_10 = arg_17_1:FormatText(var_20_9.content)

				arg_17_1.text_.text = var_20_10

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_11 = 71
				local var_20_12 = utf8.len(var_20_10)
				local var_20_13 = var_20_11 <= 0 and var_20_7 or var_20_7 * (var_20_12 / var_20_11)

				if var_20_13 > 0 and var_20_7 < var_20_13 then
					arg_17_1.talkMaxDuration = var_20_13

					if var_20_13 + var_20_6 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_13 + var_20_6
					end
				end

				arg_17_1.text_.text = var_20_10
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_110152", "110152004", "story_v_out_110152.awb") ~= 0 then
					local var_20_14 = manager.audio:GetVoiceLength("story_v_out_110152", "110152004", "story_v_out_110152.awb") / 1000

					if var_20_14 + var_20_6 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_14 + var_20_6
					end

					if var_20_9.prefab_name ~= "" and arg_17_1.actors_[var_20_9.prefab_name] ~= nil then
						local var_20_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_9.prefab_name].transform, "story_v_out_110152", "110152004", "story_v_out_110152.awb")

						arg_17_1:RecordAudio("110152004", var_20_15)
						arg_17_1:RecordAudio("110152004", var_20_15)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_110152", "110152004", "story_v_out_110152.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_110152", "110152004", "story_v_out_110152.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_16 = math.max(var_20_7, arg_17_1.talkMaxDuration)

			if var_20_6 <= arg_17_1.time_ and arg_17_1.time_ < var_20_6 + var_20_16 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_6) / var_20_16

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_6 + var_20_16 and arg_17_1.time_ < var_20_6 + var_20_16 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play110152005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 110152005
		arg_21_1.duration_ = 4.67

		local var_21_0 = {
			ja = 4.666,
			ko = 3,
			zh = 2.8,
			en = 3.566
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
				arg_21_0:Play110152006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = arg_21_1.actors_["1184ui_story"]
			local var_24_1 = 0

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.characterEffect1184ui_story == nil then
				arg_21_1.var_.characterEffect1184ui_story = var_24_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_2 = 0.2

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_2 and not isNil(var_24_0) then
				local var_24_3 = (arg_21_1.time_ - var_24_1) / var_24_2

				if arg_21_1.var_.characterEffect1184ui_story and not isNil(var_24_0) then
					arg_21_1.var_.characterEffect1184ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= var_24_1 + var_24_2 and arg_21_1.time_ < var_24_1 + var_24_2 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.characterEffect1184ui_story then
				arg_21_1.var_.characterEffect1184ui_story.fillFlat = false
			end

			local var_24_4 = 0

			if var_24_4 < arg_21_1.time_ and arg_21_1.time_ <= var_24_4 + arg_24_0 then
				arg_21_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action4135")
			end

			local var_24_5 = 0

			if var_24_5 < arg_21_1.time_ and arg_21_1.time_ <= var_24_5 + arg_24_0 then
				arg_21_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_24_6 = 0
			local var_24_7 = 0.375

			if var_24_6 < arg_21_1.time_ and arg_21_1.time_ <= var_24_6 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_8 = arg_21_1:FormatText(StoryNameCfg[6].name)

				arg_21_1.leftNameTxt_.text = var_24_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_9 = arg_21_1:GetWordFromCfg(110152005)
				local var_24_10 = arg_21_1:FormatText(var_24_9.content)

				arg_21_1.text_.text = var_24_10

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_11 = 15
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

				if manager.audio:GetVoiceLength("story_v_out_110152", "110152005", "story_v_out_110152.awb") ~= 0 then
					local var_24_14 = manager.audio:GetVoiceLength("story_v_out_110152", "110152005", "story_v_out_110152.awb") / 1000

					if var_24_14 + var_24_6 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_14 + var_24_6
					end

					if var_24_9.prefab_name ~= "" and arg_21_1.actors_[var_24_9.prefab_name] ~= nil then
						local var_24_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_9.prefab_name].transform, "story_v_out_110152", "110152005", "story_v_out_110152.awb")

						arg_21_1:RecordAudio("110152005", var_24_15)
						arg_21_1:RecordAudio("110152005", var_24_15)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_110152", "110152005", "story_v_out_110152.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_110152", "110152005", "story_v_out_110152.awb")
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
	Play110152006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 110152006
		arg_25_1.duration_ = 6.6

		local var_25_0 = {
			ja = 6.6,
			ko = 5.866,
			zh = 4.366,
			en = 3.966
		}
		local var_25_1 = manager.audio:GetLocalizationFlag()

		if var_25_0[var_25_1] ~= nil then
			arg_25_1.duration_ = var_25_0[var_25_1]
		end

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play110152007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = arg_25_1.actors_["1184ui_story"].transform
			local var_28_1 = 0

			if var_28_1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 then
				arg_25_1.var_.moveOldPos1184ui_story = var_28_0.localPosition
			end

			local var_28_2 = 0.001

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_2 then
				local var_28_3 = (arg_25_1.time_ - var_28_1) / var_28_2
				local var_28_4 = Vector3.New(0, 100, 0)

				var_28_0.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1184ui_story, var_28_4, var_28_3)

				local var_28_5 = manager.ui.mainCamera.transform.position - var_28_0.position

				var_28_0.forward = Vector3.New(var_28_5.x, var_28_5.y, var_28_5.z)

				local var_28_6 = var_28_0.localEulerAngles

				var_28_6.z = 0
				var_28_6.x = 0
				var_28_0.localEulerAngles = var_28_6
			end

			if arg_25_1.time_ >= var_28_1 + var_28_2 and arg_25_1.time_ < var_28_1 + var_28_2 + arg_28_0 then
				var_28_0.localPosition = Vector3.New(0, 100, 0)

				local var_28_7 = manager.ui.mainCamera.transform.position - var_28_0.position

				var_28_0.forward = Vector3.New(var_28_7.x, var_28_7.y, var_28_7.z)

				local var_28_8 = var_28_0.localEulerAngles

				var_28_8.z = 0
				var_28_8.x = 0
				var_28_0.localEulerAngles = var_28_8
			end

			local var_28_9 = "1019ui_story"

			if arg_25_1.actors_[var_28_9] == nil then
				local var_28_10 = Asset.Load("Char/" .. "1019ui_story")

				if not isNil(var_28_10) then
					local var_28_11 = Object.Instantiate(Asset.Load("Char/" .. "1019ui_story"), arg_25_1.stage_.transform)

					var_28_11.name = var_28_9
					var_28_11.transform.localPosition = Vector3.New(0, 100, 0)
					arg_25_1.actors_[var_28_9] = var_28_11

					local var_28_12 = var_28_11:GetComponentInChildren(typeof(CharacterEffect))

					var_28_12.enabled = true

					local var_28_13 = GameObjectTools.GetOrAddComponent(var_28_11, typeof(DynamicBoneHelper))

					if var_28_13 then
						var_28_13:EnableDynamicBone(false)
					end

					arg_25_1:ShowWeapon(var_28_12.transform, false)

					arg_25_1.var_[var_28_9 .. "Animator"] = var_28_12.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_25_1.var_[var_28_9 .. "Animator"].applyRootMotion = true
					arg_25_1.var_[var_28_9 .. "LipSync"] = var_28_12.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_28_14 = arg_25_1.actors_["1019ui_story"].transform
			local var_28_15 = 0

			if var_28_15 < arg_25_1.time_ and arg_25_1.time_ <= var_28_15 + arg_28_0 then
				arg_25_1.var_.moveOldPos1019ui_story = var_28_14.localPosition
			end

			local var_28_16 = 0.001

			if var_28_15 <= arg_25_1.time_ and arg_25_1.time_ < var_28_15 + var_28_16 then
				local var_28_17 = (arg_25_1.time_ - var_28_15) / var_28_16
				local var_28_18 = Vector3.New(-0.7, -1.08, -5.9)

				var_28_14.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1019ui_story, var_28_18, var_28_17)

				local var_28_19 = manager.ui.mainCamera.transform.position - var_28_14.position

				var_28_14.forward = Vector3.New(var_28_19.x, var_28_19.y, var_28_19.z)

				local var_28_20 = var_28_14.localEulerAngles

				var_28_20.z = 0
				var_28_20.x = 0
				var_28_14.localEulerAngles = var_28_20
			end

			if arg_25_1.time_ >= var_28_15 + var_28_16 and arg_25_1.time_ < var_28_15 + var_28_16 + arg_28_0 then
				var_28_14.localPosition = Vector3.New(-0.7, -1.08, -5.9)

				local var_28_21 = manager.ui.mainCamera.transform.position - var_28_14.position

				var_28_14.forward = Vector3.New(var_28_21.x, var_28_21.y, var_28_21.z)

				local var_28_22 = var_28_14.localEulerAngles

				var_28_22.z = 0
				var_28_22.x = 0
				var_28_14.localEulerAngles = var_28_22
			end

			local var_28_23 = arg_25_1.actors_["1019ui_story"]
			local var_28_24 = 0

			if var_28_24 < arg_25_1.time_ and arg_25_1.time_ <= var_28_24 + arg_28_0 and not isNil(var_28_23) and arg_25_1.var_.characterEffect1019ui_story == nil then
				arg_25_1.var_.characterEffect1019ui_story = var_28_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_25 = 0.2

			if var_28_24 <= arg_25_1.time_ and arg_25_1.time_ < var_28_24 + var_28_25 and not isNil(var_28_23) then
				local var_28_26 = (arg_25_1.time_ - var_28_24) / var_28_25

				if arg_25_1.var_.characterEffect1019ui_story and not isNil(var_28_23) then
					arg_25_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= var_28_24 + var_28_25 and arg_25_1.time_ < var_28_24 + var_28_25 + arg_28_0 and not isNil(var_28_23) and arg_25_1.var_.characterEffect1019ui_story then
				arg_25_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_28_27 = 0

			if var_28_27 < arg_25_1.time_ and arg_25_1.time_ <= var_28_27 + arg_28_0 then
				arg_25_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action5_1")
			end

			local var_28_28 = 0

			if var_28_28 < arg_25_1.time_ and arg_25_1.time_ <= var_28_28 + arg_28_0 then
				arg_25_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_28_29 = 0
			local var_28_30 = 0.5

			if var_28_29 < arg_25_1.time_ and arg_25_1.time_ <= var_28_29 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_31 = arg_25_1:FormatText(StoryNameCfg[13].name)

				arg_25_1.leftNameTxt_.text = var_28_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_32 = arg_25_1:GetWordFromCfg(110152006)
				local var_28_33 = arg_25_1:FormatText(var_28_32.content)

				arg_25_1.text_.text = var_28_33

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_34 = 20
				local var_28_35 = utf8.len(var_28_33)
				local var_28_36 = var_28_34 <= 0 and var_28_30 or var_28_30 * (var_28_35 / var_28_34)

				if var_28_36 > 0 and var_28_30 < var_28_36 then
					arg_25_1.talkMaxDuration = var_28_36

					if var_28_36 + var_28_29 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_36 + var_28_29
					end
				end

				arg_25_1.text_.text = var_28_33
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_110152", "110152006", "story_v_out_110152.awb") ~= 0 then
					local var_28_37 = manager.audio:GetVoiceLength("story_v_out_110152", "110152006", "story_v_out_110152.awb") / 1000

					if var_28_37 + var_28_29 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_37 + var_28_29
					end

					if var_28_32.prefab_name ~= "" and arg_25_1.actors_[var_28_32.prefab_name] ~= nil then
						local var_28_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_32.prefab_name].transform, "story_v_out_110152", "110152006", "story_v_out_110152.awb")

						arg_25_1:RecordAudio("110152006", var_28_38)
						arg_25_1:RecordAudio("110152006", var_28_38)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_110152", "110152006", "story_v_out_110152.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_110152", "110152006", "story_v_out_110152.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_39 = math.max(var_28_30, arg_25_1.talkMaxDuration)

			if var_28_29 <= arg_25_1.time_ and arg_25_1.time_ < var_28_29 + var_28_39 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_29) / var_28_39

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_29 + var_28_39 and arg_25_1.time_ < var_28_29 + var_28_39 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_25_1:InitPlayNodeList()
	end,
	Play110152007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 110152007
		arg_29_1.duration_ = 9.4

		local var_29_0 = {
			ja = 8.866,
			ko = 9.4,
			zh = 6.333,
			en = 8.8
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
				arg_29_0:Play110152008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = "1011ui_story"

			if arg_29_1.actors_[var_32_0] == nil then
				local var_32_1 = Asset.Load("Char/" .. "1011ui_story")

				if not isNil(var_32_1) then
					local var_32_2 = Object.Instantiate(Asset.Load("Char/" .. "1011ui_story"), arg_29_1.stage_.transform)

					var_32_2.name = var_32_0
					var_32_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_29_1.actors_[var_32_0] = var_32_2

					local var_32_3 = var_32_2:GetComponentInChildren(typeof(CharacterEffect))

					var_32_3.enabled = true

					local var_32_4 = GameObjectTools.GetOrAddComponent(var_32_2, typeof(DynamicBoneHelper))

					if var_32_4 then
						var_32_4:EnableDynamicBone(false)
					end

					arg_29_1:ShowWeapon(var_32_3.transform, false)

					arg_29_1.var_[var_32_0 .. "Animator"] = var_32_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_29_1.var_[var_32_0 .. "Animator"].applyRootMotion = true
					arg_29_1.var_[var_32_0 .. "LipSync"] = var_32_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_32_5 = arg_29_1.actors_["1011ui_story"].transform
			local var_32_6 = 0

			if var_32_6 < arg_29_1.time_ and arg_29_1.time_ <= var_32_6 + arg_32_0 then
				arg_29_1.var_.moveOldPos1011ui_story = var_32_5.localPosition
			end

			local var_32_7 = 0.001

			if var_32_6 <= arg_29_1.time_ and arg_29_1.time_ < var_32_6 + var_32_7 then
				local var_32_8 = (arg_29_1.time_ - var_32_6) / var_32_7
				local var_32_9 = Vector3.New(0.7, -0.71, -6)

				var_32_5.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos1011ui_story, var_32_9, var_32_8)

				local var_32_10 = manager.ui.mainCamera.transform.position - var_32_5.position

				var_32_5.forward = Vector3.New(var_32_10.x, var_32_10.y, var_32_10.z)

				local var_32_11 = var_32_5.localEulerAngles

				var_32_11.z = 0
				var_32_11.x = 0
				var_32_5.localEulerAngles = var_32_11
			end

			if arg_29_1.time_ >= var_32_6 + var_32_7 and arg_29_1.time_ < var_32_6 + var_32_7 + arg_32_0 then
				var_32_5.localPosition = Vector3.New(0.7, -0.71, -6)

				local var_32_12 = manager.ui.mainCamera.transform.position - var_32_5.position

				var_32_5.forward = Vector3.New(var_32_12.x, var_32_12.y, var_32_12.z)

				local var_32_13 = var_32_5.localEulerAngles

				var_32_13.z = 0
				var_32_13.x = 0
				var_32_5.localEulerAngles = var_32_13
			end

			local var_32_14 = 0

			if var_32_14 < arg_29_1.time_ and arg_29_1.time_ <= var_32_14 + arg_32_0 then
				arg_29_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action6_1")
			end

			local var_32_15 = 0

			if var_32_15 < arg_29_1.time_ and arg_29_1.time_ <= var_32_15 + arg_32_0 then
				arg_29_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_32_16 = arg_29_1.actors_["1019ui_story"]
			local var_32_17 = 0

			if var_32_17 < arg_29_1.time_ and arg_29_1.time_ <= var_32_17 + arg_32_0 and not isNil(var_32_16) and arg_29_1.var_.characterEffect1019ui_story == nil then
				arg_29_1.var_.characterEffect1019ui_story = var_32_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_18 = 0.2

			if var_32_17 <= arg_29_1.time_ and arg_29_1.time_ < var_32_17 + var_32_18 and not isNil(var_32_16) then
				local var_32_19 = (arg_29_1.time_ - var_32_17) / var_32_18

				if arg_29_1.var_.characterEffect1019ui_story and not isNil(var_32_16) then
					local var_32_20 = Mathf.Lerp(0, 0.5, var_32_19)

					arg_29_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_29_1.var_.characterEffect1019ui_story.fillRatio = var_32_20
				end
			end

			if arg_29_1.time_ >= var_32_17 + var_32_18 and arg_29_1.time_ < var_32_17 + var_32_18 + arg_32_0 and not isNil(var_32_16) and arg_29_1.var_.characterEffect1019ui_story then
				local var_32_21 = 0.5

				arg_29_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_29_1.var_.characterEffect1019ui_story.fillRatio = var_32_21
			end

			local var_32_22 = arg_29_1.actors_["1011ui_story"]
			local var_32_23 = 0

			if var_32_23 < arg_29_1.time_ and arg_29_1.time_ <= var_32_23 + arg_32_0 and not isNil(var_32_22) and arg_29_1.var_.characterEffect1011ui_story == nil then
				arg_29_1.var_.characterEffect1011ui_story = var_32_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_24 = 0.2

			if var_32_23 <= arg_29_1.time_ and arg_29_1.time_ < var_32_23 + var_32_24 and not isNil(var_32_22) then
				local var_32_25 = (arg_29_1.time_ - var_32_23) / var_32_24

				if arg_29_1.var_.characterEffect1011ui_story and not isNil(var_32_22) then
					arg_29_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= var_32_23 + var_32_24 and arg_29_1.time_ < var_32_23 + var_32_24 + arg_32_0 and not isNil(var_32_22) and arg_29_1.var_.characterEffect1011ui_story then
				arg_29_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_32_26 = 0
			local var_32_27 = 0.975

			if var_32_26 < arg_29_1.time_ and arg_29_1.time_ <= var_32_26 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_28 = arg_29_1:FormatText(StoryNameCfg[37].name)

				arg_29_1.leftNameTxt_.text = var_32_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_29 = arg_29_1:GetWordFromCfg(110152007)
				local var_32_30 = arg_29_1:FormatText(var_32_29.content)

				arg_29_1.text_.text = var_32_30

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_31 = 35
				local var_32_32 = utf8.len(var_32_30)
				local var_32_33 = var_32_31 <= 0 and var_32_27 or var_32_27 * (var_32_32 / var_32_31)

				if var_32_33 > 0 and var_32_27 < var_32_33 then
					arg_29_1.talkMaxDuration = var_32_33

					if var_32_33 + var_32_26 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_33 + var_32_26
					end
				end

				arg_29_1.text_.text = var_32_30
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_110152", "110152007", "story_v_out_110152.awb") ~= 0 then
					local var_32_34 = manager.audio:GetVoiceLength("story_v_out_110152", "110152007", "story_v_out_110152.awb") / 1000

					if var_32_34 + var_32_26 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_34 + var_32_26
					end

					if var_32_29.prefab_name ~= "" and arg_29_1.actors_[var_32_29.prefab_name] ~= nil then
						local var_32_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_29.prefab_name].transform, "story_v_out_110152", "110152007", "story_v_out_110152.awb")

						arg_29_1:RecordAudio("110152007", var_32_35)
						arg_29_1:RecordAudio("110152007", var_32_35)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_110152", "110152007", "story_v_out_110152.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_110152", "110152007", "story_v_out_110152.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_36 = math.max(var_32_27, arg_29_1.talkMaxDuration)

			if var_32_26 <= arg_29_1.time_ and arg_29_1.time_ < var_32_26 + var_32_36 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_26) / var_32_36

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_26 + var_32_36 and arg_29_1.time_ < var_32_26 + var_32_36 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_29_1:InitPlayNodeList()
	end,
	Play110152008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 110152008
		arg_33_1.duration_ = 7.8

		local var_33_0 = {
			ja = 4.7,
			ko = 7.8,
			zh = 5,
			en = 5.7
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
				arg_33_0:Play110152009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = arg_33_1.actors_["1019ui_story"].transform
			local var_36_1 = 0

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 then
				arg_33_1.var_.moveOldPos1019ui_story = var_36_0.localPosition
			end

			local var_36_2 = 0.001

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_2 then
				local var_36_3 = (arg_33_1.time_ - var_36_1) / var_36_2
				local var_36_4 = Vector3.New(0, 100, 0)

				var_36_0.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos1019ui_story, var_36_4, var_36_3)

				local var_36_5 = manager.ui.mainCamera.transform.position - var_36_0.position

				var_36_0.forward = Vector3.New(var_36_5.x, var_36_5.y, var_36_5.z)

				local var_36_6 = var_36_0.localEulerAngles

				var_36_6.z = 0
				var_36_6.x = 0
				var_36_0.localEulerAngles = var_36_6
			end

			if arg_33_1.time_ >= var_36_1 + var_36_2 and arg_33_1.time_ < var_36_1 + var_36_2 + arg_36_0 then
				var_36_0.localPosition = Vector3.New(0, 100, 0)

				local var_36_7 = manager.ui.mainCamera.transform.position - var_36_0.position

				var_36_0.forward = Vector3.New(var_36_7.x, var_36_7.y, var_36_7.z)

				local var_36_8 = var_36_0.localEulerAngles

				var_36_8.z = 0
				var_36_8.x = 0
				var_36_0.localEulerAngles = var_36_8
			end

			local var_36_9 = arg_33_1.actors_["1184ui_story"].transform
			local var_36_10 = 0

			if var_36_10 < arg_33_1.time_ and arg_33_1.time_ <= var_36_10 + arg_36_0 then
				arg_33_1.var_.moveOldPos1184ui_story = var_36_9.localPosition
			end

			local var_36_11 = 0.001

			if var_36_10 <= arg_33_1.time_ and arg_33_1.time_ < var_36_10 + var_36_11 then
				local var_36_12 = (arg_33_1.time_ - var_36_10) / var_36_11
				local var_36_13 = Vector3.New(-0.7, -0.97, -6)

				var_36_9.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos1184ui_story, var_36_13, var_36_12)

				local var_36_14 = manager.ui.mainCamera.transform.position - var_36_9.position

				var_36_9.forward = Vector3.New(var_36_14.x, var_36_14.y, var_36_14.z)

				local var_36_15 = var_36_9.localEulerAngles

				var_36_15.z = 0
				var_36_15.x = 0
				var_36_9.localEulerAngles = var_36_15
			end

			if arg_33_1.time_ >= var_36_10 + var_36_11 and arg_33_1.time_ < var_36_10 + var_36_11 + arg_36_0 then
				var_36_9.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_36_16 = manager.ui.mainCamera.transform.position - var_36_9.position

				var_36_9.forward = Vector3.New(var_36_16.x, var_36_16.y, var_36_16.z)

				local var_36_17 = var_36_9.localEulerAngles

				var_36_17.z = 0
				var_36_17.x = 0
				var_36_9.localEulerAngles = var_36_17
			end

			local var_36_18 = arg_33_1.actors_["1011ui_story"]
			local var_36_19 = 0

			if var_36_19 < arg_33_1.time_ and arg_33_1.time_ <= var_36_19 + arg_36_0 and not isNil(var_36_18) and arg_33_1.var_.characterEffect1011ui_story == nil then
				arg_33_1.var_.characterEffect1011ui_story = var_36_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_20 = 0.2

			if var_36_19 <= arg_33_1.time_ and arg_33_1.time_ < var_36_19 + var_36_20 and not isNil(var_36_18) then
				local var_36_21 = (arg_33_1.time_ - var_36_19) / var_36_20

				if arg_33_1.var_.characterEffect1011ui_story and not isNil(var_36_18) then
					local var_36_22 = Mathf.Lerp(0, 0.5, var_36_21)

					arg_33_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_33_1.var_.characterEffect1011ui_story.fillRatio = var_36_22
				end
			end

			if arg_33_1.time_ >= var_36_19 + var_36_20 and arg_33_1.time_ < var_36_19 + var_36_20 + arg_36_0 and not isNil(var_36_18) and arg_33_1.var_.characterEffect1011ui_story then
				local var_36_23 = 0.5

				arg_33_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_33_1.var_.characterEffect1011ui_story.fillRatio = var_36_23
			end

			local var_36_24 = 0

			if var_36_24 < arg_33_1.time_ and arg_33_1.time_ <= var_36_24 + arg_36_0 then
				arg_33_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			local var_36_25 = 0

			if var_36_25 < arg_33_1.time_ and arg_33_1.time_ <= var_36_25 + arg_36_0 then
				arg_33_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_36_26 = arg_33_1.actors_["1184ui_story"]
			local var_36_27 = 0

			if var_36_27 < arg_33_1.time_ and arg_33_1.time_ <= var_36_27 + arg_36_0 and not isNil(var_36_26) and arg_33_1.var_.characterEffect1184ui_story == nil then
				arg_33_1.var_.characterEffect1184ui_story = var_36_26:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_28 = 0.2

			if var_36_27 <= arg_33_1.time_ and arg_33_1.time_ < var_36_27 + var_36_28 and not isNil(var_36_26) then
				local var_36_29 = (arg_33_1.time_ - var_36_27) / var_36_28

				if arg_33_1.var_.characterEffect1184ui_story and not isNil(var_36_26) then
					arg_33_1.var_.characterEffect1184ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= var_36_27 + var_36_28 and arg_33_1.time_ < var_36_27 + var_36_28 + arg_36_0 and not isNil(var_36_26) and arg_33_1.var_.characterEffect1184ui_story then
				arg_33_1.var_.characterEffect1184ui_story.fillFlat = false
			end

			local var_36_30 = 0
			local var_36_31 = 0.7

			if var_36_30 < arg_33_1.time_ and arg_33_1.time_ <= var_36_30 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_32 = arg_33_1:FormatText(StoryNameCfg[6].name)

				arg_33_1.leftNameTxt_.text = var_36_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_33 = arg_33_1:GetWordFromCfg(110152008)
				local var_36_34 = arg_33_1:FormatText(var_36_33.content)

				arg_33_1.text_.text = var_36_34

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_35 = 28
				local var_36_36 = utf8.len(var_36_34)
				local var_36_37 = var_36_35 <= 0 and var_36_31 or var_36_31 * (var_36_36 / var_36_35)

				if var_36_37 > 0 and var_36_31 < var_36_37 then
					arg_33_1.talkMaxDuration = var_36_37

					if var_36_37 + var_36_30 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_37 + var_36_30
					end
				end

				arg_33_1.text_.text = var_36_34
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_110152", "110152008", "story_v_out_110152.awb") ~= 0 then
					local var_36_38 = manager.audio:GetVoiceLength("story_v_out_110152", "110152008", "story_v_out_110152.awb") / 1000

					if var_36_38 + var_36_30 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_38 + var_36_30
					end

					if var_36_33.prefab_name ~= "" and arg_33_1.actors_[var_36_33.prefab_name] ~= nil then
						local var_36_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_33.prefab_name].transform, "story_v_out_110152", "110152008", "story_v_out_110152.awb")

						arg_33_1:RecordAudio("110152008", var_36_39)
						arg_33_1:RecordAudio("110152008", var_36_39)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_110152", "110152008", "story_v_out_110152.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_110152", "110152008", "story_v_out_110152.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_40 = math.max(var_36_31, arg_33_1.talkMaxDuration)

			if var_36_30 <= arg_33_1.time_ and arg_33_1.time_ < var_36_30 + var_36_40 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_30) / var_36_40

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_30 + var_36_40 and arg_33_1.time_ < var_36_30 + var_36_40 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_33_1:InitPlayNodeList()
	end,
	Play110152009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 110152009
		arg_37_1.duration_ = 7.07

		local var_37_0 = {
			ja = 6.266,
			ko = 7.066,
			zh = 5.1,
			en = 4.1
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
				arg_37_0:Play110152010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = arg_37_1.actors_["1011ui_story"]
			local var_40_1 = 0

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.characterEffect1011ui_story == nil then
				arg_37_1.var_.characterEffect1011ui_story = var_40_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_2 = 0.2

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_2 and not isNil(var_40_0) then
				local var_40_3 = (arg_37_1.time_ - var_40_1) / var_40_2

				if arg_37_1.var_.characterEffect1011ui_story and not isNil(var_40_0) then
					arg_37_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_37_1.time_ >= var_40_1 + var_40_2 and arg_37_1.time_ < var_40_1 + var_40_2 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.characterEffect1011ui_story then
				arg_37_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_40_4 = arg_37_1.actors_["1184ui_story"]
			local var_40_5 = 0

			if var_40_5 < arg_37_1.time_ and arg_37_1.time_ <= var_40_5 + arg_40_0 and not isNil(var_40_4) and arg_37_1.var_.characterEffect1184ui_story == nil then
				arg_37_1.var_.characterEffect1184ui_story = var_40_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_6 = 0.2

			if var_40_5 <= arg_37_1.time_ and arg_37_1.time_ < var_40_5 + var_40_6 and not isNil(var_40_4) then
				local var_40_7 = (arg_37_1.time_ - var_40_5) / var_40_6

				if arg_37_1.var_.characterEffect1184ui_story and not isNil(var_40_4) then
					local var_40_8 = Mathf.Lerp(0, 0.5, var_40_7)

					arg_37_1.var_.characterEffect1184ui_story.fillFlat = true
					arg_37_1.var_.characterEffect1184ui_story.fillRatio = var_40_8
				end
			end

			if arg_37_1.time_ >= var_40_5 + var_40_6 and arg_37_1.time_ < var_40_5 + var_40_6 + arg_40_0 and not isNil(var_40_4) and arg_37_1.var_.characterEffect1184ui_story then
				local var_40_9 = 0.5

				arg_37_1.var_.characterEffect1184ui_story.fillFlat = true
				arg_37_1.var_.characterEffect1184ui_story.fillRatio = var_40_9
			end

			local var_40_10 = 0

			if var_40_10 < arg_37_1.time_ and arg_37_1.time_ <= var_40_10 + arg_40_0 then
				arg_37_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1304cva")
			end

			local var_40_11 = 0
			local var_40_12 = 0.625

			if var_40_11 < arg_37_1.time_ and arg_37_1.time_ <= var_40_11 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_13 = arg_37_1:FormatText(StoryNameCfg[37].name)

				arg_37_1.leftNameTxt_.text = var_40_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_14 = arg_37_1:GetWordFromCfg(110152009)
				local var_40_15 = arg_37_1:FormatText(var_40_14.content)

				arg_37_1.text_.text = var_40_15

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_16 = 25
				local var_40_17 = utf8.len(var_40_15)
				local var_40_18 = var_40_16 <= 0 and var_40_12 or var_40_12 * (var_40_17 / var_40_16)

				if var_40_18 > 0 and var_40_12 < var_40_18 then
					arg_37_1.talkMaxDuration = var_40_18

					if var_40_18 + var_40_11 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_18 + var_40_11
					end
				end

				arg_37_1.text_.text = var_40_15
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_110152", "110152009", "story_v_out_110152.awb") ~= 0 then
					local var_40_19 = manager.audio:GetVoiceLength("story_v_out_110152", "110152009", "story_v_out_110152.awb") / 1000

					if var_40_19 + var_40_11 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_19 + var_40_11
					end

					if var_40_14.prefab_name ~= "" and arg_37_1.actors_[var_40_14.prefab_name] ~= nil then
						local var_40_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_14.prefab_name].transform, "story_v_out_110152", "110152009", "story_v_out_110152.awb")

						arg_37_1:RecordAudio("110152009", var_40_20)
						arg_37_1:RecordAudio("110152009", var_40_20)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_110152", "110152009", "story_v_out_110152.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_110152", "110152009", "story_v_out_110152.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_21 = math.max(var_40_12, arg_37_1.talkMaxDuration)

			if var_40_11 <= arg_37_1.time_ and arg_37_1.time_ < var_40_11 + var_40_21 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_11) / var_40_21

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_11 + var_40_21 and arg_37_1.time_ < var_40_11 + var_40_21 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play110152010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 110152010
		arg_41_1.duration_ = 6.53

		local var_41_0 = {
			ja = 6.533,
			ko = 3.9,
			zh = 3.8,
			en = 4.266
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
				arg_41_0:Play110152011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = arg_41_1.actors_["1011ui_story"]
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect1011ui_story == nil then
				arg_41_1.var_.characterEffect1011ui_story = var_44_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_2 = 0.2

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_2 and not isNil(var_44_0) then
				local var_44_3 = (arg_41_1.time_ - var_44_1) / var_44_2

				if arg_41_1.var_.characterEffect1011ui_story and not isNil(var_44_0) then
					local var_44_4 = Mathf.Lerp(0, 0.5, var_44_3)

					arg_41_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_41_1.var_.characterEffect1011ui_story.fillRatio = var_44_4
				end
			end

			if arg_41_1.time_ >= var_44_1 + var_44_2 and arg_41_1.time_ < var_44_1 + var_44_2 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect1011ui_story then
				local var_44_5 = 0.5

				arg_41_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_41_1.var_.characterEffect1011ui_story.fillRatio = var_44_5
			end

			local var_44_6 = 0
			local var_44_7 = 0.325

			if var_44_6 < arg_41_1.time_ and arg_41_1.time_ <= var_44_6 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_8 = arg_41_1:FormatText(StoryNameCfg[67].name)

				arg_41_1.leftNameTxt_.text = var_44_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, true)
				arg_41_1.iconController_:SetSelectedState("hero")

				arg_41_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1111")

				arg_41_1.callingController_:SetSelectedState("normal")

				arg_41_1.keyicon_.color = Color.New(1, 1, 1)
				arg_41_1.icon_.color = Color.New(1, 1, 1)

				local var_44_9 = arg_41_1:GetWordFromCfg(110152010)
				local var_44_10 = arg_41_1:FormatText(var_44_9.content)

				arg_41_1.text_.text = var_44_10

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_11 = 13
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

				if manager.audio:GetVoiceLength("story_v_out_110152", "110152010", "story_v_out_110152.awb") ~= 0 then
					local var_44_14 = manager.audio:GetVoiceLength("story_v_out_110152", "110152010", "story_v_out_110152.awb") / 1000

					if var_44_14 + var_44_6 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_14 + var_44_6
					end

					if var_44_9.prefab_name ~= "" and arg_41_1.actors_[var_44_9.prefab_name] ~= nil then
						local var_44_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_9.prefab_name].transform, "story_v_out_110152", "110152010", "story_v_out_110152.awb")

						arg_41_1:RecordAudio("110152010", var_44_15)
						arg_41_1:RecordAudio("110152010", var_44_15)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_110152", "110152010", "story_v_out_110152.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_110152", "110152010", "story_v_out_110152.awb")
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
	Play110152011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 110152011
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play110152012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = arg_45_1.actors_["1184ui_story"].transform
			local var_48_1 = 0

			if var_48_1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 then
				arg_45_1.var_.moveOldPos1184ui_story = var_48_0.localPosition
			end

			local var_48_2 = 0.001

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_2 then
				local var_48_3 = (arg_45_1.time_ - var_48_1) / var_48_2
				local var_48_4 = Vector3.New(0, 100, 0)

				var_48_0.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos1184ui_story, var_48_4, var_48_3)

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

			local var_48_9 = arg_45_1.actors_["1011ui_story"].transform
			local var_48_10 = 0

			if var_48_10 < arg_45_1.time_ and arg_45_1.time_ <= var_48_10 + arg_48_0 then
				arg_45_1.var_.moveOldPos1011ui_story = var_48_9.localPosition
			end

			local var_48_11 = 0.001

			if var_48_10 <= arg_45_1.time_ and arg_45_1.time_ < var_48_10 + var_48_11 then
				local var_48_12 = (arg_45_1.time_ - var_48_10) / var_48_11
				local var_48_13 = Vector3.New(0, 100, 0)

				var_48_9.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos1011ui_story, var_48_13, var_48_12)

				local var_48_14 = manager.ui.mainCamera.transform.position - var_48_9.position

				var_48_9.forward = Vector3.New(var_48_14.x, var_48_14.y, var_48_14.z)

				local var_48_15 = var_48_9.localEulerAngles

				var_48_15.z = 0
				var_48_15.x = 0
				var_48_9.localEulerAngles = var_48_15
			end

			if arg_45_1.time_ >= var_48_10 + var_48_11 and arg_45_1.time_ < var_48_10 + var_48_11 + arg_48_0 then
				var_48_9.localPosition = Vector3.New(0, 100, 0)

				local var_48_16 = manager.ui.mainCamera.transform.position - var_48_9.position

				var_48_9.forward = Vector3.New(var_48_16.x, var_48_16.y, var_48_16.z)

				local var_48_17 = var_48_9.localEulerAngles

				var_48_17.z = 0
				var_48_17.x = 0
				var_48_9.localEulerAngles = var_48_17
			end

			local var_48_18 = 0
			local var_48_19 = 0.4

			if var_48_18 < arg_45_1.time_ and arg_45_1.time_ <= var_48_18 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, false)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_20 = arg_45_1:GetWordFromCfg(110152011)
				local var_48_21 = arg_45_1:FormatText(var_48_20.content)

				arg_45_1.text_.text = var_48_21

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_22 = 16
				local var_48_23 = utf8.len(var_48_21)
				local var_48_24 = var_48_22 <= 0 and var_48_19 or var_48_19 * (var_48_23 / var_48_22)

				if var_48_24 > 0 and var_48_19 < var_48_24 then
					arg_45_1.talkMaxDuration = var_48_24

					if var_48_24 + var_48_18 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_24 + var_48_18
					end
				end

				arg_45_1.text_.text = var_48_21
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)
				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_25 = math.max(var_48_19, arg_45_1.talkMaxDuration)

			if var_48_18 <= arg_45_1.time_ and arg_45_1.time_ < var_48_18 + var_48_25 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_18) / var_48_25

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_18 + var_48_25 and arg_45_1.time_ < var_48_18 + var_48_25 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_45_1:InitPlayNodeList()
	end,
	Play110152012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 110152012
		arg_49_1.duration_ = 8.57

		local var_49_0 = {
			ja = 4.066,
			ko = 6.966,
			zh = 8.566,
			en = 7.933
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
				arg_49_0:Play110152013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = "1111ui_story"

			if arg_49_1.actors_[var_52_0] == nil then
				local var_52_1 = Asset.Load("Char/" .. "1111ui_story")

				if not isNil(var_52_1) then
					local var_52_2 = Object.Instantiate(Asset.Load("Char/" .. "1111ui_story"), arg_49_1.stage_.transform)

					var_52_2.name = var_52_0
					var_52_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_49_1.actors_[var_52_0] = var_52_2

					local var_52_3 = var_52_2:GetComponentInChildren(typeof(CharacterEffect))

					var_52_3.enabled = true

					local var_52_4 = GameObjectTools.GetOrAddComponent(var_52_2, typeof(DynamicBoneHelper))

					if var_52_4 then
						var_52_4:EnableDynamicBone(false)
					end

					arg_49_1:ShowWeapon(var_52_3.transform, false)

					arg_49_1.var_[var_52_0 .. "Animator"] = var_52_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_49_1.var_[var_52_0 .. "Animator"].applyRootMotion = true
					arg_49_1.var_[var_52_0 .. "LipSync"] = var_52_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_52_5 = arg_49_1.actors_["1111ui_story"].transform
			local var_52_6 = 0

			if var_52_6 < arg_49_1.time_ and arg_49_1.time_ <= var_52_6 + arg_52_0 then
				arg_49_1.var_.moveOldPos1111ui_story = var_52_5.localPosition
			end

			local var_52_7 = 0.001

			if var_52_6 <= arg_49_1.time_ and arg_49_1.time_ < var_52_6 + var_52_7 then
				local var_52_8 = (arg_49_1.time_ - var_52_6) / var_52_7
				local var_52_9 = Vector3.New(0, -0.87, -5.7)

				var_52_5.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos1111ui_story, var_52_9, var_52_8)

				local var_52_10 = manager.ui.mainCamera.transform.position - var_52_5.position

				var_52_5.forward = Vector3.New(var_52_10.x, var_52_10.y, var_52_10.z)

				local var_52_11 = var_52_5.localEulerAngles

				var_52_11.z = 0
				var_52_11.x = 0
				var_52_5.localEulerAngles = var_52_11
			end

			if arg_49_1.time_ >= var_52_6 + var_52_7 and arg_49_1.time_ < var_52_6 + var_52_7 + arg_52_0 then
				var_52_5.localPosition = Vector3.New(0, -0.87, -5.7)

				local var_52_12 = manager.ui.mainCamera.transform.position - var_52_5.position

				var_52_5.forward = Vector3.New(var_52_12.x, var_52_12.y, var_52_12.z)

				local var_52_13 = var_52_5.localEulerAngles

				var_52_13.z = 0
				var_52_13.x = 0
				var_52_5.localEulerAngles = var_52_13
			end

			local var_52_14 = 0

			if var_52_14 < arg_49_1.time_ and arg_49_1.time_ <= var_52_14 + arg_52_0 then
				arg_49_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action6_1")
			end

			local var_52_15 = 0

			if var_52_15 < arg_49_1.time_ and arg_49_1.time_ <= var_52_15 + arg_52_0 then
				arg_49_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_52_16 = 0
			local var_52_17 = 0.725

			if var_52_16 < arg_49_1.time_ and arg_49_1.time_ <= var_52_16 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_18 = arg_49_1:FormatText(StoryNameCfg[67].name)

				arg_49_1.leftNameTxt_.text = var_52_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_19 = arg_49_1:GetWordFromCfg(110152012)
				local var_52_20 = arg_49_1:FormatText(var_52_19.content)

				arg_49_1.text_.text = var_52_20

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_21 = 29
				local var_52_22 = utf8.len(var_52_20)
				local var_52_23 = var_52_21 <= 0 and var_52_17 or var_52_17 * (var_52_22 / var_52_21)

				if var_52_23 > 0 and var_52_17 < var_52_23 then
					arg_49_1.talkMaxDuration = var_52_23

					if var_52_23 + var_52_16 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_23 + var_52_16
					end
				end

				arg_49_1.text_.text = var_52_20
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_110152", "110152012", "story_v_out_110152.awb") ~= 0 then
					local var_52_24 = manager.audio:GetVoiceLength("story_v_out_110152", "110152012", "story_v_out_110152.awb") / 1000

					if var_52_24 + var_52_16 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_24 + var_52_16
					end

					if var_52_19.prefab_name ~= "" and arg_49_1.actors_[var_52_19.prefab_name] ~= nil then
						local var_52_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_19.prefab_name].transform, "story_v_out_110152", "110152012", "story_v_out_110152.awb")

						arg_49_1:RecordAudio("110152012", var_52_25)
						arg_49_1:RecordAudio("110152012", var_52_25)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_110152", "110152012", "story_v_out_110152.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_110152", "110152012", "story_v_out_110152.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_26 = math.max(var_52_17, arg_49_1.talkMaxDuration)

			if var_52_16 <= arg_49_1.time_ and arg_49_1.time_ < var_52_16 + var_52_26 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_16) / var_52_26

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_16 + var_52_26 and arg_49_1.time_ < var_52_16 + var_52_26 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_49_1:InitPlayNodeList()
	end,
	Play110152013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 110152013
		arg_53_1.duration_ = 5

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play110152014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = arg_53_1.actors_["1111ui_story"].transform
			local var_56_1 = 0

			if var_56_1 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 then
				arg_53_1.var_.moveOldPos1111ui_story = var_56_0.localPosition
			end

			local var_56_2 = 0.001

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_2 then
				local var_56_3 = (arg_53_1.time_ - var_56_1) / var_56_2
				local var_56_4 = Vector3.New(0, 100, 0)

				var_56_0.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos1111ui_story, var_56_4, var_56_3)

				local var_56_5 = manager.ui.mainCamera.transform.position - var_56_0.position

				var_56_0.forward = Vector3.New(var_56_5.x, var_56_5.y, var_56_5.z)

				local var_56_6 = var_56_0.localEulerAngles

				var_56_6.z = 0
				var_56_6.x = 0
				var_56_0.localEulerAngles = var_56_6
			end

			if arg_53_1.time_ >= var_56_1 + var_56_2 and arg_53_1.time_ < var_56_1 + var_56_2 + arg_56_0 then
				var_56_0.localPosition = Vector3.New(0, 100, 0)

				local var_56_7 = manager.ui.mainCamera.transform.position - var_56_0.position

				var_56_0.forward = Vector3.New(var_56_7.x, var_56_7.y, var_56_7.z)

				local var_56_8 = var_56_0.localEulerAngles

				var_56_8.z = 0
				var_56_8.x = 0
				var_56_0.localEulerAngles = var_56_8
			end

			local var_56_9 = 0
			local var_56_10 = 0.625

			if var_56_9 < arg_53_1.time_ and arg_53_1.time_ <= var_56_9 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, false)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_11 = arg_53_1:GetWordFromCfg(110152013)
				local var_56_12 = arg_53_1:FormatText(var_56_11.content)

				arg_53_1.text_.text = var_56_12

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_13 = 25
				local var_56_14 = utf8.len(var_56_12)
				local var_56_15 = var_56_13 <= 0 and var_56_10 or var_56_10 * (var_56_14 / var_56_13)

				if var_56_15 > 0 and var_56_10 < var_56_15 then
					arg_53_1.talkMaxDuration = var_56_15

					if var_56_15 + var_56_9 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_15 + var_56_9
					end
				end

				arg_53_1.text_.text = var_56_12
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)
				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_16 = math.max(var_56_10, arg_53_1.talkMaxDuration)

			if var_56_9 <= arg_53_1.time_ and arg_53_1.time_ < var_56_9 + var_56_16 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_9) / var_56_16

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_9 + var_56_16 and arg_53_1.time_ < var_56_9 + var_56_16 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_53_1:InitPlayNodeList()
	end,
	Play110152014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 110152014
		arg_57_1.duration_ = 5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play110152015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = arg_57_1.bgs_.B12a.transform
			local var_60_1 = 0

			if var_60_1 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 then
				arg_57_1.var_.moveOldPosB12a = var_60_0.localPosition
			end

			local var_60_2 = 1.5

			if var_60_1 <= arg_57_1.time_ and arg_57_1.time_ < var_60_1 + var_60_2 then
				local var_60_3 = (arg_57_1.time_ - var_60_1) / var_60_2
				local var_60_4 = Vector3.New(0, 1, 9.5)

				var_60_0.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPosB12a, var_60_4, var_60_3)
			end

			if arg_57_1.time_ >= var_60_1 + var_60_2 and arg_57_1.time_ < var_60_1 + var_60_2 + arg_60_0 then
				var_60_0.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_60_5 = 0
			local var_60_6 = 0.825

			if var_60_5 < arg_57_1.time_ and arg_57_1.time_ <= var_60_5 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, false)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_7 = arg_57_1:GetWordFromCfg(110152014)
				local var_60_8 = arg_57_1:FormatText(var_60_7.content)

				arg_57_1.text_.text = var_60_8

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_9 = 33
				local var_60_10 = utf8.len(var_60_8)
				local var_60_11 = var_60_9 <= 0 and var_60_6 or var_60_6 * (var_60_10 / var_60_9)

				if var_60_11 > 0 and var_60_6 < var_60_11 then
					arg_57_1.talkMaxDuration = var_60_11

					if var_60_11 + var_60_5 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_11 + var_60_5
					end
				end

				arg_57_1.text_.text = var_60_8
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)
				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_12 = math.max(var_60_6, arg_57_1.talkMaxDuration)

			if var_60_5 <= arg_57_1.time_ and arg_57_1.time_ < var_60_5 + var_60_12 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_5) / var_60_12

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_5 + var_60_12 and arg_57_1.time_ < var_60_5 + var_60_12 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "B12a",
				changeDisplayLayer = false,
				needEase = false,
				duration = 1.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_57_1:InitPlayNodeList()
	end,
	Play110152015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 110152015
		arg_61_1.duration_ = 5

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play110152016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = 0
			local var_64_1 = 0.15

			if var_64_0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_0 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_2 = arg_61_1:FormatText(StoryNameCfg[7].name)

				arg_61_1.leftNameTxt_.text = var_64_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, true)
				arg_61_1.iconController_:SetSelectedState("hero")

				arg_61_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_61_1.callingController_:SetSelectedState("normal")

				arg_61_1.keyicon_.color = Color.New(1, 1, 1)
				arg_61_1.icon_.color = Color.New(1, 1, 1)

				local var_64_3 = arg_61_1:GetWordFromCfg(110152015)
				local var_64_4 = arg_61_1:FormatText(var_64_3.content)

				arg_61_1.text_.text = var_64_4

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_5 = 6
				local var_64_6 = utf8.len(var_64_4)
				local var_64_7 = var_64_5 <= 0 and var_64_1 or var_64_1 * (var_64_6 / var_64_5)

				if var_64_7 > 0 and var_64_1 < var_64_7 then
					arg_61_1.talkMaxDuration = var_64_7

					if var_64_7 + var_64_0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_7 + var_64_0
					end
				end

				arg_61_1.text_.text = var_64_4
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)
				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_8 = math.max(var_64_1, arg_61_1.talkMaxDuration)

			if var_64_0 <= arg_61_1.time_ and arg_61_1.time_ < var_64_0 + var_64_8 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_0) / var_64_8

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_0 + var_64_8 and arg_61_1.time_ < var_64_0 + var_64_8 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play110152016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 110152016
		arg_65_1.duration_ = 5

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play110152017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = 0
			local var_68_1 = 0.7

			if var_68_0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_0 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, false)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_2 = arg_65_1:GetWordFromCfg(110152016)
				local var_68_3 = arg_65_1:FormatText(var_68_2.content)

				arg_65_1.text_.text = var_68_3

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_4 = 28
				local var_68_5 = utf8.len(var_68_3)
				local var_68_6 = var_68_4 <= 0 and var_68_1 or var_68_1 * (var_68_5 / var_68_4)

				if var_68_6 > 0 and var_68_1 < var_68_6 then
					arg_65_1.talkMaxDuration = var_68_6

					if var_68_6 + var_68_0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_6 + var_68_0
					end
				end

				arg_65_1.text_.text = var_68_3
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)
				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_7 = math.max(var_68_1, arg_65_1.talkMaxDuration)

			if var_68_0 <= arg_65_1.time_ and arg_65_1.time_ < var_68_0 + var_68_7 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_0) / var_68_7

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_0 + var_68_7 and arg_65_1.time_ < var_68_0 + var_68_7 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play110152017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 110152017
		arg_69_1.duration_ = 5

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play110152018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = 0
			local var_72_1 = 0.75

			if var_72_0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_0 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, false)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_2 = arg_69_1:GetWordFromCfg(110152017)
				local var_72_3 = arg_69_1:FormatText(var_72_2.content)

				arg_69_1.text_.text = var_72_3

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_4 = 30
				local var_72_5 = utf8.len(var_72_3)
				local var_72_6 = var_72_4 <= 0 and var_72_1 or var_72_1 * (var_72_5 / var_72_4)

				if var_72_6 > 0 and var_72_1 < var_72_6 then
					arg_69_1.talkMaxDuration = var_72_6

					if var_72_6 + var_72_0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_6 + var_72_0
					end
				end

				arg_69_1.text_.text = var_72_3
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)
				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_7 = math.max(var_72_1, arg_69_1.talkMaxDuration)

			if var_72_0 <= arg_69_1.time_ and arg_69_1.time_ < var_72_0 + var_72_7 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_0) / var_72_7

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_0 + var_72_7 and arg_69_1.time_ < var_72_0 + var_72_7 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play110152018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 110152018
		arg_73_1.duration_ = 3.97

		local var_73_0 = {
			ja = 3.2,
			ko = 3.233,
			zh = 3.633,
			en = 3.966
		}
		local var_73_1 = manager.audio:GetLocalizationFlag()

		if var_73_0[var_73_1] ~= nil then
			arg_73_1.duration_ = var_73_0[var_73_1]
		end

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play110152019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = 0

			if var_76_0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_0 + arg_76_0 then
				arg_73_1.mask_.enabled = true
				arg_73_1.mask_.raycastTarget = true

				arg_73_1:SetGaussion(false)
			end

			local var_76_1 = 1.5

			if var_76_0 <= arg_73_1.time_ and arg_73_1.time_ < var_76_0 + var_76_1 then
				local var_76_2 = (arg_73_1.time_ - var_76_0) / var_76_1
				local var_76_3 = Color.New(1, 1, 1)

				var_76_3.a = Mathf.Lerp(1, 0, var_76_2)
				arg_73_1.mask_.color = var_76_3
			end

			if arg_73_1.time_ >= var_76_0 + var_76_1 and arg_73_1.time_ < var_76_0 + var_76_1 + arg_76_0 then
				local var_76_4 = Color.New(1, 1, 1)
				local var_76_5 = 0

				arg_73_1.mask_.enabled = false
				var_76_4.a = var_76_5
				arg_73_1.mask_.color = var_76_4
			end

			local var_76_6 = manager.ui.mainCamera.transform
			local var_76_7 = 2

			if var_76_7 < arg_73_1.time_ and arg_73_1.time_ <= var_76_7 + arg_76_0 then
				arg_73_1.var_.shakeOldPos = var_76_6.localPosition
			end

			local var_76_8 = 0.6

			if var_76_7 <= arg_73_1.time_ and arg_73_1.time_ < var_76_7 + var_76_8 then
				local var_76_9 = (arg_73_1.time_ - var_76_7) / 0.066
				local var_76_10, var_76_11 = math.modf(var_76_9)

				var_76_6.localPosition = Vector3.New(var_76_11 * 0.13, var_76_11 * 0.13, var_76_11 * 0.13) + arg_73_1.var_.shakeOldPos
			end

			if arg_73_1.time_ >= var_76_7 + var_76_8 and arg_73_1.time_ < var_76_7 + var_76_8 + arg_76_0 then
				var_76_6.localPosition = arg_73_1.var_.shakeOldPos
			end

			if arg_73_1.frameCnt_ <= 1 then
				arg_73_1.dialog_:SetActive(false)
			end

			local var_76_12 = 2
			local var_76_13 = 0.1

			if var_76_12 < arg_73_1.time_ and arg_73_1.time_ <= var_76_12 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0

				arg_73_1.dialog_:SetActive(true)

				arg_73_1.dialogCg_.alpha = 0

				local var_76_14 = LeanTween.value(arg_73_1.dialog_, 0, 1, 0.3)

				var_76_14:setOnUpdate(LuaHelper.FloatAction(function(arg_77_0)
					arg_73_1.dialogCg_.alpha = arg_77_0
				end))
				var_76_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_73_1.dialog_)
					var_76_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_73_1.duration_ = arg_73_1.duration_ + 0.3

				SetActive(arg_73_1.leftNameGo_, true)

				local var_76_15 = arg_73_1:FormatText(StoryNameCfg[6].name)

				arg_73_1.leftNameTxt_.text = var_76_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, true)
				arg_73_1.iconController_:SetSelectedState("hero")

				arg_73_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1184")

				arg_73_1.callingController_:SetSelectedState("normal")

				arg_73_1.keyicon_.color = Color.New(1, 1, 1)
				arg_73_1.icon_.color = Color.New(1, 1, 1)

				local var_76_16 = arg_73_1:GetWordFromCfg(110152018)
				local var_76_17 = arg_73_1:FormatText(var_76_16.content)

				arg_73_1.text_.text = var_76_17

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_18 = 4
				local var_76_19 = utf8.len(var_76_17)
				local var_76_20 = var_76_18 <= 0 and var_76_13 or var_76_13 * (var_76_19 / var_76_18)

				if var_76_20 > 0 and var_76_13 < var_76_20 then
					arg_73_1.talkMaxDuration = var_76_20
					var_76_12 = var_76_12 + 0.3

					if var_76_20 + var_76_12 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_20 + var_76_12
					end
				end

				arg_73_1.text_.text = var_76_17
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_110152", "110152018", "story_v_out_110152.awb") ~= 0 then
					local var_76_21 = manager.audio:GetVoiceLength("story_v_out_110152", "110152018", "story_v_out_110152.awb") / 1000

					if var_76_21 + var_76_12 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_21 + var_76_12
					end

					if var_76_16.prefab_name ~= "" and arg_73_1.actors_[var_76_16.prefab_name] ~= nil then
						local var_76_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_16.prefab_name].transform, "story_v_out_110152", "110152018", "story_v_out_110152.awb")

						arg_73_1:RecordAudio("110152018", var_76_22)
						arg_73_1:RecordAudio("110152018", var_76_22)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_110152", "110152018", "story_v_out_110152.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_110152", "110152018", "story_v_out_110152.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_23 = var_76_12 + 0.3
			local var_76_24 = math.max(var_76_13, arg_73_1.talkMaxDuration)

			if var_76_23 <= arg_73_1.time_ and arg_73_1.time_ < var_76_23 + var_76_24 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_23) / var_76_24

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_23 + var_76_24 and arg_73_1.time_ < var_76_23 + var_76_24 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play110152019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 110152019
		arg_79_1.duration_ = 2.4

		local var_79_0 = {
			ja = 1.433,
			ko = 2.1,
			zh = 2.4,
			en = 2
		}
		local var_79_1 = manager.audio:GetLocalizationFlag()

		if var_79_0[var_79_1] ~= nil then
			arg_79_1.duration_ = var_79_0[var_79_1]
		end

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play110152020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = 0
			local var_82_1 = 0.15

			if var_82_0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_0 + arg_82_0 then
				local var_82_2 = "play"
				local var_82_3 = "music"

				arg_79_1:AudioAction(var_82_2, var_82_3, "ui_battle", "ui_battle_stopbgm", "")

				local var_82_4 = ""
				local var_82_5 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_82_5 ~= "" then
					if arg_79_1.bgmTxt_.text ~= var_82_5 and arg_79_1.bgmTxt_.text ~= "" then
						if arg_79_1.bgmTxt2_.text ~= "" then
							arg_79_1.bgmTxt_.text = arg_79_1.bgmTxt2_.text
						end

						arg_79_1.bgmTxt2_.text = var_82_5

						arg_79_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_79_1.bgmTxt_.text = var_82_5
						arg_79_1.bgmTxt2_.text = var_82_5
					end

					if arg_79_1.bgmTimer then
						arg_79_1.bgmTimer:Stop()

						arg_79_1.bgmTimer = nil
					end

					if arg_79_1.settingData.show_music_name == 1 then
						arg_79_1.musicController:SetSelectedState("show")
						arg_79_1.musicAnimator_:Play("open", 0, 0)

						if arg_79_1.settingData.music_time ~= 0 then
							arg_79_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_79_1.settingData.music_time), function()
								if arg_79_1 == nil or isNil(arg_79_1.bgmTxt_) then
									return
								end

								arg_79_1.musicController:SetSelectedState("hide")
								arg_79_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_82_6 = 0
			local var_82_7 = 0.15

			if var_82_6 < arg_79_1.time_ and arg_79_1.time_ <= var_82_6 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				local var_82_8 = arg_79_1:FormatText(StoryNameCfg[37].name)

				arg_79_1.leftNameTxt_.text = var_82_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, true)
				arg_79_1.iconController_:SetSelectedState("hero")

				arg_79_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1011")

				arg_79_1.callingController_:SetSelectedState("normal")

				arg_79_1.keyicon_.color = Color.New(1, 1, 1)
				arg_79_1.icon_.color = Color.New(1, 1, 1)

				local var_82_9 = arg_79_1:GetWordFromCfg(110152019)
				local var_82_10 = arg_79_1:FormatText(var_82_9.content)

				arg_79_1.text_.text = var_82_10

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_11 = 6
				local var_82_12 = utf8.len(var_82_10)
				local var_82_13 = var_82_11 <= 0 and var_82_7 or var_82_7 * (var_82_12 / var_82_11)

				if var_82_13 > 0 and var_82_7 < var_82_13 then
					arg_79_1.talkMaxDuration = var_82_13

					if var_82_13 + var_82_6 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_13 + var_82_6
					end
				end

				arg_79_1.text_.text = var_82_10
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_110152", "110152019", "story_v_out_110152.awb") ~= 0 then
					local var_82_14 = manager.audio:GetVoiceLength("story_v_out_110152", "110152019", "story_v_out_110152.awb") / 1000

					if var_82_14 + var_82_6 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_14 + var_82_6
					end

					if var_82_9.prefab_name ~= "" and arg_79_1.actors_[var_82_9.prefab_name] ~= nil then
						local var_82_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_9.prefab_name].transform, "story_v_out_110152", "110152019", "story_v_out_110152.awb")

						arg_79_1:RecordAudio("110152019", var_82_15)
						arg_79_1:RecordAudio("110152019", var_82_15)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_out_110152", "110152019", "story_v_out_110152.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_out_110152", "110152019", "story_v_out_110152.awb")
				end

				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_16 = math.max(var_82_7, arg_79_1.talkMaxDuration)

			if var_82_6 <= arg_79_1.time_ and arg_79_1.time_ < var_82_6 + var_82_16 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_6) / var_82_16

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_6 + var_82_16 and arg_79_1.time_ < var_82_6 + var_82_16 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play110152020 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 110152020
		arg_84_1.duration_ = 5

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play110152021(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = manager.ui.mainCamera.transform
			local var_87_1 = 0

			if var_87_1 < arg_84_1.time_ and arg_84_1.time_ <= var_87_1 + arg_87_0 then
				arg_84_1.var_.shakeOldPos = var_87_0.localPosition
			end

			local var_87_2 = 0.6

			if var_87_1 <= arg_84_1.time_ and arg_84_1.time_ < var_87_1 + var_87_2 then
				local var_87_3 = (arg_84_1.time_ - var_87_1) / 0.066
				local var_87_4, var_87_5 = math.modf(var_87_3)

				var_87_0.localPosition = Vector3.New(var_87_5 * 0.13, var_87_5 * 0.13, var_87_5 * 0.13) + arg_84_1.var_.shakeOldPos
			end

			if arg_84_1.time_ >= var_87_1 + var_87_2 and arg_84_1.time_ < var_87_1 + var_87_2 + arg_87_0 then
				var_87_0.localPosition = arg_84_1.var_.shakeOldPos
			end

			local var_87_6 = 0
			local var_87_7 = 0.1

			if var_87_6 < arg_84_1.time_ and arg_84_1.time_ <= var_87_6 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				local var_87_8 = arg_84_1:FormatText(StoryNameCfg[7].name)

				arg_84_1.leftNameTxt_.text = var_87_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, true)
				arg_84_1.iconController_:SetSelectedState("hero")

				arg_84_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_84_1.callingController_:SetSelectedState("normal")

				arg_84_1.keyicon_.color = Color.New(1, 1, 1)
				arg_84_1.icon_.color = Color.New(1, 1, 1)

				local var_87_9 = arg_84_1:GetWordFromCfg(110152020)
				local var_87_10 = arg_84_1:FormatText(var_87_9.content)

				arg_84_1.text_.text = var_87_10

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_11 = 4
				local var_87_12 = utf8.len(var_87_10)
				local var_87_13 = var_87_11 <= 0 and var_87_7 or var_87_7 * (var_87_12 / var_87_11)

				if var_87_13 > 0 and var_87_7 < var_87_13 then
					arg_84_1.talkMaxDuration = var_87_13

					if var_87_13 + var_87_6 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_13 + var_87_6
					end
				end

				arg_84_1.text_.text = var_87_10
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)
				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_14 = math.max(var_87_7, arg_84_1.talkMaxDuration)

			if var_87_6 <= arg_84_1.time_ and arg_84_1.time_ < var_87_6 + var_87_14 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_6) / var_87_14

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_6 + var_87_14 and arg_84_1.time_ < var_87_6 + var_87_14 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {}

		arg_84_1:InitPlayNodeList()
	end,
	Play110152021 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 110152021
		arg_88_1.duration_ = 5

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play110152022(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = 0
			local var_91_1 = 0.95

			if var_91_0 < arg_88_1.time_ and arg_88_1.time_ <= var_91_0 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, false)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_2 = arg_88_1:GetWordFromCfg(110152021)
				local var_91_3 = arg_88_1:FormatText(var_91_2.content)

				arg_88_1.text_.text = var_91_3

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_4 = 38
				local var_91_5 = utf8.len(var_91_3)
				local var_91_6 = var_91_4 <= 0 and var_91_1 or var_91_1 * (var_91_5 / var_91_4)

				if var_91_6 > 0 and var_91_1 < var_91_6 then
					arg_88_1.talkMaxDuration = var_91_6

					if var_91_6 + var_91_0 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_6 + var_91_0
					end
				end

				arg_88_1.text_.text = var_91_3
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)
				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_7 = math.max(var_91_1, arg_88_1.talkMaxDuration)

			if var_91_0 <= arg_88_1.time_ and arg_88_1.time_ < var_91_0 + var_91_7 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_0) / var_91_7

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_0 + var_91_7 and arg_88_1.time_ < var_91_0 + var_91_7 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {}

		arg_88_1:InitPlayNodeList()
	end,
	Play110152022 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 110152022
		arg_92_1.duration_ = 10.47

		local var_92_0 = {
			ja = 8.066,
			ko = 9.4,
			zh = 8.366,
			en = 10.466
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
				arg_92_0:Play110152023(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			local var_95_0 = arg_92_1.actors_["1111ui_story"].transform
			local var_95_1 = 0

			if var_95_1 < arg_92_1.time_ and arg_92_1.time_ <= var_95_1 + arg_95_0 then
				arg_92_1.var_.moveOldPos1111ui_story = var_95_0.localPosition
			end

			local var_95_2 = 0.001

			if var_95_1 <= arg_92_1.time_ and arg_92_1.time_ < var_95_1 + var_95_2 then
				local var_95_3 = (arg_92_1.time_ - var_95_1) / var_95_2
				local var_95_4 = Vector3.New(0, -0.87, -5.7)

				var_95_0.localPosition = Vector3.Lerp(arg_92_1.var_.moveOldPos1111ui_story, var_95_4, var_95_3)

				local var_95_5 = manager.ui.mainCamera.transform.position - var_95_0.position

				var_95_0.forward = Vector3.New(var_95_5.x, var_95_5.y, var_95_5.z)

				local var_95_6 = var_95_0.localEulerAngles

				var_95_6.z = 0
				var_95_6.x = 0
				var_95_0.localEulerAngles = var_95_6
			end

			if arg_92_1.time_ >= var_95_1 + var_95_2 and arg_92_1.time_ < var_95_1 + var_95_2 + arg_95_0 then
				var_95_0.localPosition = Vector3.New(0, -0.87, -5.7)

				local var_95_7 = manager.ui.mainCamera.transform.position - var_95_0.position

				var_95_0.forward = Vector3.New(var_95_7.x, var_95_7.y, var_95_7.z)

				local var_95_8 = var_95_0.localEulerAngles

				var_95_8.z = 0
				var_95_8.x = 0
				var_95_0.localEulerAngles = var_95_8
			end

			local var_95_9 = 0

			if var_95_9 < arg_92_1.time_ and arg_92_1.time_ <= var_95_9 + arg_95_0 then
				arg_92_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action5_1")
			end

			local var_95_10 = 0

			if var_95_10 < arg_92_1.time_ and arg_92_1.time_ <= var_95_10 + arg_95_0 then
				arg_92_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_95_11 = arg_92_1.actors_["1111ui_story"]
			local var_95_12 = 0

			if var_95_12 < arg_92_1.time_ and arg_92_1.time_ <= var_95_12 + arg_95_0 and not isNil(var_95_11) and arg_92_1.var_.characterEffect1111ui_story == nil then
				arg_92_1.var_.characterEffect1111ui_story = var_95_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_13 = 0.2

			if var_95_12 <= arg_92_1.time_ and arg_92_1.time_ < var_95_12 + var_95_13 and not isNil(var_95_11) then
				local var_95_14 = (arg_92_1.time_ - var_95_12) / var_95_13

				if arg_92_1.var_.characterEffect1111ui_story and not isNil(var_95_11) then
					arg_92_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_92_1.time_ >= var_95_12 + var_95_13 and arg_92_1.time_ < var_95_12 + var_95_13 + arg_95_0 and not isNil(var_95_11) and arg_92_1.var_.characterEffect1111ui_story then
				arg_92_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_95_15 = 0
			local var_95_16 = 0.825

			if var_95_15 < arg_92_1.time_ and arg_92_1.time_ <= var_95_15 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				local var_95_17 = arg_92_1:FormatText(StoryNameCfg[67].name)

				arg_92_1.leftNameTxt_.text = var_95_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_18 = arg_92_1:GetWordFromCfg(110152022)
				local var_95_19 = arg_92_1:FormatText(var_95_18.content)

				arg_92_1.text_.text = var_95_19

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_20 = 33
				local var_95_21 = utf8.len(var_95_19)
				local var_95_22 = var_95_20 <= 0 and var_95_16 or var_95_16 * (var_95_21 / var_95_20)

				if var_95_22 > 0 and var_95_16 < var_95_22 then
					arg_92_1.talkMaxDuration = var_95_22

					if var_95_22 + var_95_15 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_22 + var_95_15
					end
				end

				arg_92_1.text_.text = var_95_19
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_110152", "110152022", "story_v_out_110152.awb") ~= 0 then
					local var_95_23 = manager.audio:GetVoiceLength("story_v_out_110152", "110152022", "story_v_out_110152.awb") / 1000

					if var_95_23 + var_95_15 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_23 + var_95_15
					end

					if var_95_18.prefab_name ~= "" and arg_92_1.actors_[var_95_18.prefab_name] ~= nil then
						local var_95_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_18.prefab_name].transform, "story_v_out_110152", "110152022", "story_v_out_110152.awb")

						arg_92_1:RecordAudio("110152022", var_95_24)
						arg_92_1:RecordAudio("110152022", var_95_24)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_out_110152", "110152022", "story_v_out_110152.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_out_110152", "110152022", "story_v_out_110152.awb")
				end

				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_25 = math.max(var_95_16, arg_92_1.talkMaxDuration)

			if var_95_15 <= arg_92_1.time_ and arg_92_1.time_ < var_95_15 + var_95_25 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_15) / var_95_25

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_15 + var_95_25 and arg_92_1.time_ < var_95_15 + var_95_25 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_92_1:InitPlayNodeList()
	end,
	Play110152023 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 110152023
		arg_96_1.duration_ = 5

		SetActive(arg_96_1.tipsGo_, false)

		function arg_96_1.onSingleLineFinish_()
			arg_96_1.onSingleLineUpdate_ = nil
			arg_96_1.onSingleLineFinish_ = nil
			arg_96_1.state_ = "waiting"
		end

		function arg_96_1.playNext_(arg_98_0)
			if arg_98_0 == 1 then
				arg_96_0:Play110152024(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			local var_99_0 = arg_96_1.actors_["1111ui_story"]
			local var_99_1 = 0

			if var_99_1 < arg_96_1.time_ and arg_96_1.time_ <= var_99_1 + arg_99_0 and not isNil(var_99_0) and arg_96_1.var_.characterEffect1111ui_story == nil then
				arg_96_1.var_.characterEffect1111ui_story = var_99_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_2 = 0.2

			if var_99_1 <= arg_96_1.time_ and arg_96_1.time_ < var_99_1 + var_99_2 and not isNil(var_99_0) then
				local var_99_3 = (arg_96_1.time_ - var_99_1) / var_99_2

				if arg_96_1.var_.characterEffect1111ui_story and not isNil(var_99_0) then
					local var_99_4 = Mathf.Lerp(0, 0.5, var_99_3)

					arg_96_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_96_1.var_.characterEffect1111ui_story.fillRatio = var_99_4
				end
			end

			if arg_96_1.time_ >= var_99_1 + var_99_2 and arg_96_1.time_ < var_99_1 + var_99_2 + arg_99_0 and not isNil(var_99_0) and arg_96_1.var_.characterEffect1111ui_story then
				local var_99_5 = 0.5

				arg_96_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_96_1.var_.characterEffect1111ui_story.fillRatio = var_99_5
			end

			local var_99_6 = 0
			local var_99_7 = 0.45

			if var_99_6 < arg_96_1.time_ and arg_96_1.time_ <= var_99_6 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, false)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_8 = arg_96_1:GetWordFromCfg(110152023)
				local var_99_9 = arg_96_1:FormatText(var_99_8.content)

				arg_96_1.text_.text = var_99_9

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_10 = 18
				local var_99_11 = utf8.len(var_99_9)
				local var_99_12 = var_99_10 <= 0 and var_99_7 or var_99_7 * (var_99_11 / var_99_10)

				if var_99_12 > 0 and var_99_7 < var_99_12 then
					arg_96_1.talkMaxDuration = var_99_12

					if var_99_12 + var_99_6 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_12 + var_99_6
					end
				end

				arg_96_1.text_.text = var_99_9
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)
				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_13 = math.max(var_99_7, arg_96_1.talkMaxDuration)

			if var_99_6 <= arg_96_1.time_ and arg_96_1.time_ < var_99_6 + var_99_13 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_6) / var_99_13

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_6 + var_99_13 and arg_96_1.time_ < var_99_6 + var_99_13 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {}

		arg_96_1:InitPlayNodeList()
	end,
	Play110152024 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 110152024
		arg_100_1.duration_ = 3.9

		local var_100_0 = {
			ja = 3.9,
			ko = 3.533,
			zh = 3.6,
			en = 2.966
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
				arg_100_0:Play110152025(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			local var_103_0 = 0
			local var_103_1 = 0.275

			if var_103_0 < arg_100_1.time_ and arg_100_1.time_ <= var_103_0 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				local var_103_2 = arg_100_1:FormatText(StoryNameCfg[6].name)

				arg_100_1.leftNameTxt_.text = var_103_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, true)
				arg_100_1.iconController_:SetSelectedState("hero")

				arg_100_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1184")

				arg_100_1.callingController_:SetSelectedState("normal")

				arg_100_1.keyicon_.color = Color.New(1, 1, 1)
				arg_100_1.icon_.color = Color.New(1, 1, 1)

				local var_103_3 = arg_100_1:GetWordFromCfg(110152024)
				local var_103_4 = arg_100_1:FormatText(var_103_3.content)

				arg_100_1.text_.text = var_103_4

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_5 = 11
				local var_103_6 = utf8.len(var_103_4)
				local var_103_7 = var_103_5 <= 0 and var_103_1 or var_103_1 * (var_103_6 / var_103_5)

				if var_103_7 > 0 and var_103_1 < var_103_7 then
					arg_100_1.talkMaxDuration = var_103_7

					if var_103_7 + var_103_0 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_7 + var_103_0
					end
				end

				arg_100_1.text_.text = var_103_4
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_110152", "110152024", "story_v_out_110152.awb") ~= 0 then
					local var_103_8 = manager.audio:GetVoiceLength("story_v_out_110152", "110152024", "story_v_out_110152.awb") / 1000

					if var_103_8 + var_103_0 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_8 + var_103_0
					end

					if var_103_3.prefab_name ~= "" and arg_100_1.actors_[var_103_3.prefab_name] ~= nil then
						local var_103_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_100_1.actors_[var_103_3.prefab_name].transform, "story_v_out_110152", "110152024", "story_v_out_110152.awb")

						arg_100_1:RecordAudio("110152024", var_103_9)
						arg_100_1:RecordAudio("110152024", var_103_9)
					else
						arg_100_1:AudioAction("play", "voice", "story_v_out_110152", "110152024", "story_v_out_110152.awb")
					end

					arg_100_1:RecordHistoryTalkVoice("story_v_out_110152", "110152024", "story_v_out_110152.awb")
				end

				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_10 = math.max(var_103_1, arg_100_1.talkMaxDuration)

			if var_103_0 <= arg_100_1.time_ and arg_100_1.time_ < var_103_0 + var_103_10 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_0) / var_103_10

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_0 + var_103_10 and arg_100_1.time_ < var_103_0 + var_103_10 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {}

		arg_100_1:InitPlayNodeList()
	end,
	Play110152025 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 110152025
		arg_104_1.duration_ = 10.07

		local var_104_0 = {
			ja = 7.466,
			ko = 10.066,
			zh = 7.366,
			en = 7.866
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
				arg_104_0:Play110152026(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			local var_107_0 = 0

			if var_107_0 < arg_104_1.time_ and arg_104_1.time_ <= var_107_0 + arg_107_0 then
				arg_104_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111actionlink/1111action454")
			end

			local var_107_1 = 0

			if var_107_1 < arg_104_1.time_ and arg_104_1.time_ <= var_107_1 + arg_107_0 then
				arg_104_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_107_2 = arg_104_1.actors_["1111ui_story"]
			local var_107_3 = 0

			if var_107_3 < arg_104_1.time_ and arg_104_1.time_ <= var_107_3 + arg_107_0 and not isNil(var_107_2) and arg_104_1.var_.characterEffect1111ui_story == nil then
				arg_104_1.var_.characterEffect1111ui_story = var_107_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_107_4 = 0.2

			if var_107_3 <= arg_104_1.time_ and arg_104_1.time_ < var_107_3 + var_107_4 and not isNil(var_107_2) then
				local var_107_5 = (arg_104_1.time_ - var_107_3) / var_107_4

				if arg_104_1.var_.characterEffect1111ui_story and not isNil(var_107_2) then
					arg_104_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_104_1.time_ >= var_107_3 + var_107_4 and arg_104_1.time_ < var_107_3 + var_107_4 + arg_107_0 and not isNil(var_107_2) and arg_104_1.var_.characterEffect1111ui_story then
				arg_104_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_107_6 = 0
			local var_107_7 = 0.775

			if var_107_6 < arg_104_1.time_ and arg_104_1.time_ <= var_107_6 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				local var_107_8 = arg_104_1:FormatText(StoryNameCfg[67].name)

				arg_104_1.leftNameTxt_.text = var_107_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_9 = arg_104_1:GetWordFromCfg(110152025)
				local var_107_10 = arg_104_1:FormatText(var_107_9.content)

				arg_104_1.text_.text = var_107_10

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_11 = 31
				local var_107_12 = utf8.len(var_107_10)
				local var_107_13 = var_107_11 <= 0 and var_107_7 or var_107_7 * (var_107_12 / var_107_11)

				if var_107_13 > 0 and var_107_7 < var_107_13 then
					arg_104_1.talkMaxDuration = var_107_13

					if var_107_13 + var_107_6 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_13 + var_107_6
					end
				end

				arg_104_1.text_.text = var_107_10
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_110152", "110152025", "story_v_out_110152.awb") ~= 0 then
					local var_107_14 = manager.audio:GetVoiceLength("story_v_out_110152", "110152025", "story_v_out_110152.awb") / 1000

					if var_107_14 + var_107_6 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_14 + var_107_6
					end

					if var_107_9.prefab_name ~= "" and arg_104_1.actors_[var_107_9.prefab_name] ~= nil then
						local var_107_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_104_1.actors_[var_107_9.prefab_name].transform, "story_v_out_110152", "110152025", "story_v_out_110152.awb")

						arg_104_1:RecordAudio("110152025", var_107_15)
						arg_104_1:RecordAudio("110152025", var_107_15)
					else
						arg_104_1:AudioAction("play", "voice", "story_v_out_110152", "110152025", "story_v_out_110152.awb")
					end

					arg_104_1:RecordHistoryTalkVoice("story_v_out_110152", "110152025", "story_v_out_110152.awb")
				end

				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_16 = math.max(var_107_7, arg_104_1.talkMaxDuration)

			if var_107_6 <= arg_104_1.time_ and arg_104_1.time_ < var_107_6 + var_107_16 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_6) / var_107_16

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_6 + var_107_16 and arg_104_1.time_ < var_107_6 + var_107_16 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {}

		arg_104_1:InitPlayNodeList()
	end,
	Play110152026 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 110152026
		arg_108_1.duration_ = 5

		SetActive(arg_108_1.tipsGo_, false)

		function arg_108_1.onSingleLineFinish_()
			arg_108_1.onSingleLineUpdate_ = nil
			arg_108_1.onSingleLineFinish_ = nil
			arg_108_1.state_ = "waiting"
		end

		function arg_108_1.playNext_(arg_110_0)
			if arg_110_0 == 1 then
				arg_108_0:Play110152027(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			local var_111_0 = arg_108_1.actors_["1111ui_story"]
			local var_111_1 = 0

			if var_111_1 < arg_108_1.time_ and arg_108_1.time_ <= var_111_1 + arg_111_0 and not isNil(var_111_0) and arg_108_1.var_.characterEffect1111ui_story == nil then
				arg_108_1.var_.characterEffect1111ui_story = var_111_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_111_2 = 0.2

			if var_111_1 <= arg_108_1.time_ and arg_108_1.time_ < var_111_1 + var_111_2 and not isNil(var_111_0) then
				local var_111_3 = (arg_108_1.time_ - var_111_1) / var_111_2

				if arg_108_1.var_.characterEffect1111ui_story and not isNil(var_111_0) then
					local var_111_4 = Mathf.Lerp(0, 0.5, var_111_3)

					arg_108_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_108_1.var_.characterEffect1111ui_story.fillRatio = var_111_4
				end
			end

			if arg_108_1.time_ >= var_111_1 + var_111_2 and arg_108_1.time_ < var_111_1 + var_111_2 + arg_111_0 and not isNil(var_111_0) and arg_108_1.var_.characterEffect1111ui_story then
				local var_111_5 = 0.5

				arg_108_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_108_1.var_.characterEffect1111ui_story.fillRatio = var_111_5
			end

			local var_111_6 = 0
			local var_111_7 = 0.45

			if var_111_6 < arg_108_1.time_ and arg_108_1.time_ <= var_111_6 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				local var_111_8 = arg_108_1:FormatText(StoryNameCfg[7].name)

				arg_108_1.leftNameTxt_.text = var_111_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, true)
				arg_108_1.iconController_:SetSelectedState("hero")

				arg_108_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_108_1.callingController_:SetSelectedState("normal")

				arg_108_1.keyicon_.color = Color.New(1, 1, 1)
				arg_108_1.icon_.color = Color.New(1, 1, 1)

				local var_111_9 = arg_108_1:GetWordFromCfg(110152026)
				local var_111_10 = arg_108_1:FormatText(var_111_9.content)

				arg_108_1.text_.text = var_111_10

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_11 = 18
				local var_111_12 = utf8.len(var_111_10)
				local var_111_13 = var_111_11 <= 0 and var_111_7 or var_111_7 * (var_111_12 / var_111_11)

				if var_111_13 > 0 and var_111_7 < var_111_13 then
					arg_108_1.talkMaxDuration = var_111_13

					if var_111_13 + var_111_6 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_13 + var_111_6
					end
				end

				arg_108_1.text_.text = var_111_10
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)
				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_14 = math.max(var_111_7, arg_108_1.talkMaxDuration)

			if var_111_6 <= arg_108_1.time_ and arg_108_1.time_ < var_111_6 + var_111_14 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_6) / var_111_14

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_6 + var_111_14 and arg_108_1.time_ < var_111_6 + var_111_14 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {}

		arg_108_1:InitPlayNodeList()
	end,
	Play110152027 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 110152027
		arg_112_1.duration_ = 5

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
		end

		function arg_112_1.playNext_(arg_114_0)
			if arg_114_0 == 1 then
				arg_112_0:Play110152028(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			local var_115_0 = 0
			local var_115_1 = 0.425

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

				local var_115_3 = arg_112_1:GetWordFromCfg(110152027)
				local var_115_4 = arg_112_1:FormatText(var_115_3.content)

				arg_112_1.text_.text = var_115_4

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_5 = 17
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
	Play110152028 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 110152028
		arg_116_1.duration_ = 2

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play110152029(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			local var_119_0 = arg_116_1.actors_["1111ui_story"]
			local var_119_1 = 0

			if var_119_1 < arg_116_1.time_ and arg_116_1.time_ <= var_119_1 + arg_119_0 and not isNil(var_119_0) and arg_116_1.var_.characterEffect1111ui_story == nil then
				arg_116_1.var_.characterEffect1111ui_story = var_119_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_119_2 = 0.2

			if var_119_1 <= arg_116_1.time_ and arg_116_1.time_ < var_119_1 + var_119_2 and not isNil(var_119_0) then
				local var_119_3 = (arg_116_1.time_ - var_119_1) / var_119_2

				if arg_116_1.var_.characterEffect1111ui_story and not isNil(var_119_0) then
					arg_116_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_116_1.time_ >= var_119_1 + var_119_2 and arg_116_1.time_ < var_119_1 + var_119_2 + arg_119_0 and not isNil(var_119_0) and arg_116_1.var_.characterEffect1111ui_story then
				arg_116_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_119_4 = 0

			if var_119_4 < arg_116_1.time_ and arg_116_1.time_ <= var_119_4 + arg_119_0 then
				arg_116_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111actionlink/1111action445")
			end

			local var_119_5 = 0

			if var_119_5 < arg_116_1.time_ and arg_116_1.time_ <= var_119_5 + arg_119_0 then
				arg_116_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_119_6 = 0
			local var_119_7 = 0.05

			if var_119_6 < arg_116_1.time_ and arg_116_1.time_ <= var_119_6 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				local var_119_8 = arg_116_1:FormatText(StoryNameCfg[67].name)

				arg_116_1.leftNameTxt_.text = var_119_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_9 = arg_116_1:GetWordFromCfg(110152028)
				local var_119_10 = arg_116_1:FormatText(var_119_9.content)

				arg_116_1.text_.text = var_119_10

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_11 = 2
				local var_119_12 = utf8.len(var_119_10)
				local var_119_13 = var_119_11 <= 0 and var_119_7 or var_119_7 * (var_119_12 / var_119_11)

				if var_119_13 > 0 and var_119_7 < var_119_13 then
					arg_116_1.talkMaxDuration = var_119_13

					if var_119_13 + var_119_6 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_13 + var_119_6
					end
				end

				arg_116_1.text_.text = var_119_10
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_110152", "110152028", "story_v_out_110152.awb") ~= 0 then
					local var_119_14 = manager.audio:GetVoiceLength("story_v_out_110152", "110152028", "story_v_out_110152.awb") / 1000

					if var_119_14 + var_119_6 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_14 + var_119_6
					end

					if var_119_9.prefab_name ~= "" and arg_116_1.actors_[var_119_9.prefab_name] ~= nil then
						local var_119_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_116_1.actors_[var_119_9.prefab_name].transform, "story_v_out_110152", "110152028", "story_v_out_110152.awb")

						arg_116_1:RecordAudio("110152028", var_119_15)
						arg_116_1:RecordAudio("110152028", var_119_15)
					else
						arg_116_1:AudioAction("play", "voice", "story_v_out_110152", "110152028", "story_v_out_110152.awb")
					end

					arg_116_1:RecordHistoryTalkVoice("story_v_out_110152", "110152028", "story_v_out_110152.awb")
				end

				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_16 = math.max(var_119_7, arg_116_1.talkMaxDuration)

			if var_119_6 <= arg_116_1.time_ and arg_116_1.time_ < var_119_6 + var_119_16 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_6) / var_119_16

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_6 + var_119_16 and arg_116_1.time_ < var_119_6 + var_119_16 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {}

		arg_116_1:InitPlayNodeList()
	end,
	Play110152029 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 110152029
		arg_120_1.duration_ = 5

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"
		end

		function arg_120_1.playNext_(arg_122_0)
			if arg_122_0 == 1 then
				arg_120_0:Play110152030(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			local var_123_0 = arg_120_1.actors_["1111ui_story"]
			local var_123_1 = 0

			if var_123_1 < arg_120_1.time_ and arg_120_1.time_ <= var_123_1 + arg_123_0 and not isNil(var_123_0) and arg_120_1.var_.characterEffect1111ui_story == nil then
				arg_120_1.var_.characterEffect1111ui_story = var_123_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_123_2 = 0.2

			if var_123_1 <= arg_120_1.time_ and arg_120_1.time_ < var_123_1 + var_123_2 and not isNil(var_123_0) then
				local var_123_3 = (arg_120_1.time_ - var_123_1) / var_123_2

				if arg_120_1.var_.characterEffect1111ui_story and not isNil(var_123_0) then
					local var_123_4 = Mathf.Lerp(0, 0.5, var_123_3)

					arg_120_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_120_1.var_.characterEffect1111ui_story.fillRatio = var_123_4
				end
			end

			if arg_120_1.time_ >= var_123_1 + var_123_2 and arg_120_1.time_ < var_123_1 + var_123_2 + arg_123_0 and not isNil(var_123_0) and arg_120_1.var_.characterEffect1111ui_story then
				local var_123_5 = 0.5

				arg_120_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_120_1.var_.characterEffect1111ui_story.fillRatio = var_123_5
			end

			local var_123_6 = 0
			local var_123_7 = 1.025

			if var_123_6 < arg_120_1.time_ and arg_120_1.time_ <= var_123_6 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				local var_123_8 = arg_120_1:FormatText(StoryNameCfg[7].name)

				arg_120_1.leftNameTxt_.text = var_123_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, true)
				arg_120_1.iconController_:SetSelectedState("hero")

				arg_120_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_120_1.callingController_:SetSelectedState("normal")

				arg_120_1.keyicon_.color = Color.New(1, 1, 1)
				arg_120_1.icon_.color = Color.New(1, 1, 1)

				local var_123_9 = arg_120_1:GetWordFromCfg(110152029)
				local var_123_10 = arg_120_1:FormatText(var_123_9.content)

				arg_120_1.text_.text = var_123_10

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_11 = 43
				local var_123_12 = utf8.len(var_123_10)
				local var_123_13 = var_123_11 <= 0 and var_123_7 or var_123_7 * (var_123_12 / var_123_11)

				if var_123_13 > 0 and var_123_7 < var_123_13 then
					arg_120_1.talkMaxDuration = var_123_13

					if var_123_13 + var_123_6 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_13 + var_123_6
					end
				end

				arg_120_1.text_.text = var_123_10
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)
				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_14 = math.max(var_123_7, arg_120_1.talkMaxDuration)

			if var_123_6 <= arg_120_1.time_ and arg_120_1.time_ < var_123_6 + var_123_14 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_6) / var_123_14

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_6 + var_123_14 and arg_120_1.time_ < var_123_6 + var_123_14 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {}

		arg_120_1:InitPlayNodeList()
	end,
	Play110152030 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 110152030
		arg_124_1.duration_ = 5

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play110152031(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			local var_127_0 = 0
			local var_127_1 = 0.5

			if var_127_0 < arg_124_1.time_ and arg_124_1.time_ <= var_127_0 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				local var_127_2 = arg_124_1:FormatText(StoryNameCfg[7].name)

				arg_124_1.leftNameTxt_.text = var_127_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, true)
				arg_124_1.iconController_:SetSelectedState("hero")

				arg_124_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_124_1.callingController_:SetSelectedState("normal")

				arg_124_1.keyicon_.color = Color.New(1, 1, 1)
				arg_124_1.icon_.color = Color.New(1, 1, 1)

				local var_127_3 = arg_124_1:GetWordFromCfg(110152030)
				local var_127_4 = arg_124_1:FormatText(var_127_3.content)

				arg_124_1.text_.text = var_127_4

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_5 = 20
				local var_127_6 = utf8.len(var_127_4)
				local var_127_7 = var_127_5 <= 0 and var_127_1 or var_127_1 * (var_127_6 / var_127_5)

				if var_127_7 > 0 and var_127_1 < var_127_7 then
					arg_124_1.talkMaxDuration = var_127_7

					if var_127_7 + var_127_0 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_7 + var_127_0
					end
				end

				arg_124_1.text_.text = var_127_4
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)
				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_8 = math.max(var_127_1, arg_124_1.talkMaxDuration)

			if var_127_0 <= arg_124_1.time_ and arg_124_1.time_ < var_127_0 + var_127_8 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_0) / var_127_8

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_0 + var_127_8 and arg_124_1.time_ < var_127_0 + var_127_8 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {}

		arg_124_1:InitPlayNodeList()
	end,
	Play110152031 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 110152031
		arg_128_1.duration_ = 2

		SetActive(arg_128_1.tipsGo_, false)

		function arg_128_1.onSingleLineFinish_()
			arg_128_1.onSingleLineUpdate_ = nil
			arg_128_1.onSingleLineFinish_ = nil
			arg_128_1.state_ = "waiting"
		end

		function arg_128_1.playNext_(arg_130_0)
			if arg_130_0 == 1 then
				arg_128_0:Play110152032(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			local var_131_0 = 0

			if var_131_0 < arg_128_1.time_ and arg_128_1.time_ <= var_131_0 + arg_131_0 then
				arg_128_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111actionlink/1111action453")
			end

			local var_131_1 = 0

			if var_131_1 < arg_128_1.time_ and arg_128_1.time_ <= var_131_1 + arg_131_0 then
				arg_128_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0203cva")
			end

			local var_131_2 = arg_128_1.actors_["1111ui_story"]
			local var_131_3 = 0

			if var_131_3 < arg_128_1.time_ and arg_128_1.time_ <= var_131_3 + arg_131_0 and not isNil(var_131_2) and arg_128_1.var_.characterEffect1111ui_story == nil then
				arg_128_1.var_.characterEffect1111ui_story = var_131_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_131_4 = 0.2

			if var_131_3 <= arg_128_1.time_ and arg_128_1.time_ < var_131_3 + var_131_4 and not isNil(var_131_2) then
				local var_131_5 = (arg_128_1.time_ - var_131_3) / var_131_4

				if arg_128_1.var_.characterEffect1111ui_story and not isNil(var_131_2) then
					arg_128_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_128_1.time_ >= var_131_3 + var_131_4 and arg_128_1.time_ < var_131_3 + var_131_4 + arg_131_0 and not isNil(var_131_2) and arg_128_1.var_.characterEffect1111ui_story then
				arg_128_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_131_6 = 0
			local var_131_7 = 0.05

			if var_131_6 < arg_128_1.time_ and arg_128_1.time_ <= var_131_6 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				local var_131_8 = arg_128_1:FormatText(StoryNameCfg[67].name)

				arg_128_1.leftNameTxt_.text = var_131_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_9 = arg_128_1:GetWordFromCfg(110152031)
				local var_131_10 = arg_128_1:FormatText(var_131_9.content)

				arg_128_1.text_.text = var_131_10

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_11 = 2
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

				if manager.audio:GetVoiceLength("story_v_out_110152", "110152031", "story_v_out_110152.awb") ~= 0 then
					local var_131_14 = manager.audio:GetVoiceLength("story_v_out_110152", "110152031", "story_v_out_110152.awb") / 1000

					if var_131_14 + var_131_6 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_14 + var_131_6
					end

					if var_131_9.prefab_name ~= "" and arg_128_1.actors_[var_131_9.prefab_name] ~= nil then
						local var_131_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_9.prefab_name].transform, "story_v_out_110152", "110152031", "story_v_out_110152.awb")

						arg_128_1:RecordAudio("110152031", var_131_15)
						arg_128_1:RecordAudio("110152031", var_131_15)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_out_110152", "110152031", "story_v_out_110152.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_out_110152", "110152031", "story_v_out_110152.awb")
				end

				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_16 = math.max(var_131_7, arg_128_1.talkMaxDuration)

			if var_131_6 <= arg_128_1.time_ and arg_128_1.time_ < var_131_6 + var_131_16 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_6) / var_131_16

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_6 + var_131_16 and arg_128_1.time_ < var_131_6 + var_131_16 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {}

		arg_128_1:InitPlayNodeList()
	end,
	Play110152032 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 110152032
		arg_132_1.duration_ = 5

		SetActive(arg_132_1.tipsGo_, false)

		function arg_132_1.onSingleLineFinish_()
			arg_132_1.onSingleLineUpdate_ = nil
			arg_132_1.onSingleLineFinish_ = nil
			arg_132_1.state_ = "waiting"
		end

		function arg_132_1.playNext_(arg_134_0)
			if arg_134_0 == 1 then
				arg_132_0:Play110152033(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			local var_135_0 = arg_132_1.actors_["1111ui_story"].transform
			local var_135_1 = 0

			if var_135_1 < arg_132_1.time_ and arg_132_1.time_ <= var_135_1 + arg_135_0 then
				arg_132_1.var_.moveOldPos1111ui_story = var_135_0.localPosition
			end

			local var_135_2 = 0.001

			if var_135_1 <= arg_132_1.time_ and arg_132_1.time_ < var_135_1 + var_135_2 then
				local var_135_3 = (arg_132_1.time_ - var_135_1) / var_135_2
				local var_135_4 = Vector3.New(0, 100, 0)

				var_135_0.localPosition = Vector3.Lerp(arg_132_1.var_.moveOldPos1111ui_story, var_135_4, var_135_3)

				local var_135_5 = manager.ui.mainCamera.transform.position - var_135_0.position

				var_135_0.forward = Vector3.New(var_135_5.x, var_135_5.y, var_135_5.z)

				local var_135_6 = var_135_0.localEulerAngles

				var_135_6.z = 0
				var_135_6.x = 0
				var_135_0.localEulerAngles = var_135_6
			end

			if arg_132_1.time_ >= var_135_1 + var_135_2 and arg_132_1.time_ < var_135_1 + var_135_2 + arg_135_0 then
				var_135_0.localPosition = Vector3.New(0, 100, 0)

				local var_135_7 = manager.ui.mainCamera.transform.position - var_135_0.position

				var_135_0.forward = Vector3.New(var_135_7.x, var_135_7.y, var_135_7.z)

				local var_135_8 = var_135_0.localEulerAngles

				var_135_8.z = 0
				var_135_8.x = 0
				var_135_0.localEulerAngles = var_135_8
			end

			local var_135_9 = arg_132_1.actors_["1111ui_story"]
			local var_135_10 = 0

			if var_135_10 < arg_132_1.time_ and arg_132_1.time_ <= var_135_10 + arg_135_0 and not isNil(var_135_9) and arg_132_1.var_.characterEffect1111ui_story == nil then
				arg_132_1.var_.characterEffect1111ui_story = var_135_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_135_11 = 0.2

			if var_135_10 <= arg_132_1.time_ and arg_132_1.time_ < var_135_10 + var_135_11 and not isNil(var_135_9) then
				local var_135_12 = (arg_132_1.time_ - var_135_10) / var_135_11

				if arg_132_1.var_.characterEffect1111ui_story and not isNil(var_135_9) then
					local var_135_13 = Mathf.Lerp(0, 0.5, var_135_12)

					arg_132_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_132_1.var_.characterEffect1111ui_story.fillRatio = var_135_13
				end
			end

			if arg_132_1.time_ >= var_135_10 + var_135_11 and arg_132_1.time_ < var_135_10 + var_135_11 + arg_135_0 and not isNil(var_135_9) and arg_132_1.var_.characterEffect1111ui_story then
				local var_135_14 = 0.5

				arg_132_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_132_1.var_.characterEffect1111ui_story.fillRatio = var_135_14
			end

			local var_135_15 = 0
			local var_135_16 = 1.05

			if var_135_15 < arg_132_1.time_ and arg_132_1.time_ <= var_135_15 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, false)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_17 = arg_132_1:GetWordFromCfg(110152032)
				local var_135_18 = arg_132_1:FormatText(var_135_17.content)

				arg_132_1.text_.text = var_135_18

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_19 = 42
				local var_135_20 = utf8.len(var_135_18)
				local var_135_21 = var_135_19 <= 0 and var_135_16 or var_135_16 * (var_135_20 / var_135_19)

				if var_135_21 > 0 and var_135_16 < var_135_21 then
					arg_132_1.talkMaxDuration = var_135_21

					if var_135_21 + var_135_15 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_21 + var_135_15
					end
				end

				arg_132_1.text_.text = var_135_18
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)
				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_22 = math.max(var_135_16, arg_132_1.talkMaxDuration)

			if var_135_15 <= arg_132_1.time_ and arg_132_1.time_ < var_135_15 + var_135_22 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_15) / var_135_22

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_15 + var_135_22 and arg_132_1.time_ < var_135_15 + var_135_22 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_132_1:InitPlayNodeList()
	end,
	Play110152033 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 110152033
		arg_136_1.duration_ = 6.27

		local var_136_0 = {
			ja = 2.633,
			ko = 4.1,
			zh = 5.1,
			en = 6.266
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
				arg_136_0:Play110152034(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			local var_139_0 = 0

			if var_139_0 < arg_136_1.time_ and arg_136_1.time_ <= var_139_0 + arg_139_0 then
				arg_136_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action9_1")
			end

			local var_139_1 = arg_136_1.actors_["1111ui_story"].transform
			local var_139_2 = 0

			if var_139_2 < arg_136_1.time_ and arg_136_1.time_ <= var_139_2 + arg_139_0 then
				arg_136_1.var_.moveOldPos1111ui_story = var_139_1.localPosition
			end

			local var_139_3 = 0.001

			if var_139_2 <= arg_136_1.time_ and arg_136_1.time_ < var_139_2 + var_139_3 then
				local var_139_4 = (arg_136_1.time_ - var_139_2) / var_139_3
				local var_139_5 = Vector3.New(0, -0.87, -5.7)

				var_139_1.localPosition = Vector3.Lerp(arg_136_1.var_.moveOldPos1111ui_story, var_139_5, var_139_4)

				local var_139_6 = manager.ui.mainCamera.transform.position - var_139_1.position

				var_139_1.forward = Vector3.New(var_139_6.x, var_139_6.y, var_139_6.z)

				local var_139_7 = var_139_1.localEulerAngles

				var_139_7.z = 0
				var_139_7.x = 0
				var_139_1.localEulerAngles = var_139_7
			end

			if arg_136_1.time_ >= var_139_2 + var_139_3 and arg_136_1.time_ < var_139_2 + var_139_3 + arg_139_0 then
				var_139_1.localPosition = Vector3.New(0, -0.87, -5.7)

				local var_139_8 = manager.ui.mainCamera.transform.position - var_139_1.position

				var_139_1.forward = Vector3.New(var_139_8.x, var_139_8.y, var_139_8.z)

				local var_139_9 = var_139_1.localEulerAngles

				var_139_9.z = 0
				var_139_9.x = 0
				var_139_1.localEulerAngles = var_139_9
			end

			local var_139_10 = 0

			if var_139_10 < arg_136_1.time_ and arg_136_1.time_ <= var_139_10 + arg_139_0 then
				arg_136_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_139_11 = arg_136_1.actors_["1111ui_story"]
			local var_139_12 = 0

			if var_139_12 < arg_136_1.time_ and arg_136_1.time_ <= var_139_12 + arg_139_0 and not isNil(var_139_11) and arg_136_1.var_.characterEffect1111ui_story == nil then
				arg_136_1.var_.characterEffect1111ui_story = var_139_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_139_13 = 0.2

			if var_139_12 <= arg_136_1.time_ and arg_136_1.time_ < var_139_12 + var_139_13 and not isNil(var_139_11) then
				local var_139_14 = (arg_136_1.time_ - var_139_12) / var_139_13

				if arg_136_1.var_.characterEffect1111ui_story and not isNil(var_139_11) then
					arg_136_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_136_1.time_ >= var_139_12 + var_139_13 and arg_136_1.time_ < var_139_12 + var_139_13 + arg_139_0 and not isNil(var_139_11) and arg_136_1.var_.characterEffect1111ui_story then
				arg_136_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_139_15 = 0
			local var_139_16 = 0.425

			if var_139_15 < arg_136_1.time_ and arg_136_1.time_ <= var_139_15 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				local var_139_17 = arg_136_1:FormatText(StoryNameCfg[67].name)

				arg_136_1.leftNameTxt_.text = var_139_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_18 = arg_136_1:GetWordFromCfg(110152033)
				local var_139_19 = arg_136_1:FormatText(var_139_18.content)

				arg_136_1.text_.text = var_139_19

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_20 = 17
				local var_139_21 = utf8.len(var_139_19)
				local var_139_22 = var_139_20 <= 0 and var_139_16 or var_139_16 * (var_139_21 / var_139_20)

				if var_139_22 > 0 and var_139_16 < var_139_22 then
					arg_136_1.talkMaxDuration = var_139_22

					if var_139_22 + var_139_15 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_22 + var_139_15
					end
				end

				arg_136_1.text_.text = var_139_19
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_110152", "110152033", "story_v_out_110152.awb") ~= 0 then
					local var_139_23 = manager.audio:GetVoiceLength("story_v_out_110152", "110152033", "story_v_out_110152.awb") / 1000

					if var_139_23 + var_139_15 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_23 + var_139_15
					end

					if var_139_18.prefab_name ~= "" and arg_136_1.actors_[var_139_18.prefab_name] ~= nil then
						local var_139_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_136_1.actors_[var_139_18.prefab_name].transform, "story_v_out_110152", "110152033", "story_v_out_110152.awb")

						arg_136_1:RecordAudio("110152033", var_139_24)
						arg_136_1:RecordAudio("110152033", var_139_24)
					else
						arg_136_1:AudioAction("play", "voice", "story_v_out_110152", "110152033", "story_v_out_110152.awb")
					end

					arg_136_1:RecordHistoryTalkVoice("story_v_out_110152", "110152033", "story_v_out_110152.awb")
				end

				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_25 = math.max(var_139_16, arg_136_1.talkMaxDuration)

			if var_139_15 <= arg_136_1.time_ and arg_136_1.time_ < var_139_15 + var_139_25 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_15) / var_139_25

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_15 + var_139_25 and arg_136_1.time_ < var_139_15 + var_139_25 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_136_1:InitPlayNodeList()
	end,
	Play110152034 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 110152034
		arg_140_1.duration_ = 3.97

		local var_140_0 = {
			ja = 3.966,
			ko = 2.966,
			zh = 3.8,
			en = 2.833
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
				arg_140_0:Play110152035(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			local var_143_0 = arg_140_1.actors_["1111ui_story"]
			local var_143_1 = 0

			if var_143_1 < arg_140_1.time_ and arg_140_1.time_ <= var_143_1 + arg_143_0 and not isNil(var_143_0) and arg_140_1.var_.characterEffect1111ui_story == nil then
				arg_140_1.var_.characterEffect1111ui_story = var_143_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_143_2 = 0.2

			if var_143_1 <= arg_140_1.time_ and arg_140_1.time_ < var_143_1 + var_143_2 and not isNil(var_143_0) then
				local var_143_3 = (arg_140_1.time_ - var_143_1) / var_143_2

				if arg_140_1.var_.characterEffect1111ui_story and not isNil(var_143_0) then
					local var_143_4 = Mathf.Lerp(0, 0.5, var_143_3)

					arg_140_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_140_1.var_.characterEffect1111ui_story.fillRatio = var_143_4
				end
			end

			if arg_140_1.time_ >= var_143_1 + var_143_2 and arg_140_1.time_ < var_143_1 + var_143_2 + arg_143_0 and not isNil(var_143_0) and arg_140_1.var_.characterEffect1111ui_story then
				local var_143_5 = 0.5

				arg_140_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_140_1.var_.characterEffect1111ui_story.fillRatio = var_143_5
			end

			local var_143_6 = 0
			local var_143_7 = 0.2

			if var_143_6 < arg_140_1.time_ and arg_140_1.time_ <= var_143_6 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, true)

				local var_143_8 = arg_140_1:FormatText(StoryNameCfg[6].name)

				arg_140_1.leftNameTxt_.text = var_143_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_140_1.leftNameTxt_.transform)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1.leftNameTxt_.text)
				SetActive(arg_140_1.iconTrs_.gameObject, true)
				arg_140_1.iconController_:SetSelectedState("hero")

				arg_140_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1184")

				arg_140_1.callingController_:SetSelectedState("normal")

				arg_140_1.keyicon_.color = Color.New(1, 1, 1)
				arg_140_1.icon_.color = Color.New(1, 1, 1)

				local var_143_9 = arg_140_1:GetWordFromCfg(110152034)
				local var_143_10 = arg_140_1:FormatText(var_143_9.content)

				arg_140_1.text_.text = var_143_10

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_11 = 8
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

				if manager.audio:GetVoiceLength("story_v_out_110152", "110152034", "story_v_out_110152.awb") ~= 0 then
					local var_143_14 = manager.audio:GetVoiceLength("story_v_out_110152", "110152034", "story_v_out_110152.awb") / 1000

					if var_143_14 + var_143_6 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_14 + var_143_6
					end

					if var_143_9.prefab_name ~= "" and arg_140_1.actors_[var_143_9.prefab_name] ~= nil then
						local var_143_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_140_1.actors_[var_143_9.prefab_name].transform, "story_v_out_110152", "110152034", "story_v_out_110152.awb")

						arg_140_1:RecordAudio("110152034", var_143_15)
						arg_140_1:RecordAudio("110152034", var_143_15)
					else
						arg_140_1:AudioAction("play", "voice", "story_v_out_110152", "110152034", "story_v_out_110152.awb")
					end

					arg_140_1:RecordHistoryTalkVoice("story_v_out_110152", "110152034", "story_v_out_110152.awb")
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
	Play110152035 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 110152035
		arg_144_1.duration_ = 5.97

		local var_144_0 = {
			ja = 5.966,
			ko = 2.233,
			zh = 2.133,
			en = 2.933
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
				arg_144_0:Play110152036(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			local var_147_0 = 0
			local var_147_1 = 0.3

			if var_147_0 < arg_144_1.time_ and arg_144_1.time_ <= var_147_0 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				local var_147_2 = arg_144_1:FormatText(StoryNameCfg[13].name)

				arg_144_1.leftNameTxt_.text = var_147_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, true)
				arg_144_1.iconController_:SetSelectedState("hero")

				arg_144_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019")

				arg_144_1.callingController_:SetSelectedState("normal")

				arg_144_1.keyicon_.color = Color.New(1, 1, 1)
				arg_144_1.icon_.color = Color.New(1, 1, 1)

				local var_147_3 = arg_144_1:GetWordFromCfg(110152035)
				local var_147_4 = arg_144_1:FormatText(var_147_3.content)

				arg_144_1.text_.text = var_147_4

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_5 = 12
				local var_147_6 = utf8.len(var_147_4)
				local var_147_7 = var_147_5 <= 0 and var_147_1 or var_147_1 * (var_147_6 / var_147_5)

				if var_147_7 > 0 and var_147_1 < var_147_7 then
					arg_144_1.talkMaxDuration = var_147_7

					if var_147_7 + var_147_0 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_7 + var_147_0
					end
				end

				arg_144_1.text_.text = var_147_4
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_110152", "110152035", "story_v_out_110152.awb") ~= 0 then
					local var_147_8 = manager.audio:GetVoiceLength("story_v_out_110152", "110152035", "story_v_out_110152.awb") / 1000

					if var_147_8 + var_147_0 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_8 + var_147_0
					end

					if var_147_3.prefab_name ~= "" and arg_144_1.actors_[var_147_3.prefab_name] ~= nil then
						local var_147_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_144_1.actors_[var_147_3.prefab_name].transform, "story_v_out_110152", "110152035", "story_v_out_110152.awb")

						arg_144_1:RecordAudio("110152035", var_147_9)
						arg_144_1:RecordAudio("110152035", var_147_9)
					else
						arg_144_1:AudioAction("play", "voice", "story_v_out_110152", "110152035", "story_v_out_110152.awb")
					end

					arg_144_1:RecordHistoryTalkVoice("story_v_out_110152", "110152035", "story_v_out_110152.awb")
				end

				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_10 = math.max(var_147_1, arg_144_1.talkMaxDuration)

			if var_147_0 <= arg_144_1.time_ and arg_144_1.time_ < var_147_0 + var_147_10 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_0) / var_147_10

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_0 + var_147_10 and arg_144_1.time_ < var_147_0 + var_147_10 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {}

		arg_144_1:InitPlayNodeList()
	end,
	Play110152036 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 110152036
		arg_148_1.duration_ = 10.87

		local var_148_0 = {
			ja = 9.866,
			ko = 10.866,
			zh = 8.8,
			en = 9
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
				arg_148_0:Play110152037(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			local var_151_0 = 0

			if var_151_0 < arg_148_1.time_ and arg_148_1.time_ <= var_151_0 + arg_151_0 then
				arg_148_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111actionlink/1111action494")
			end

			local var_151_1 = 0

			if var_151_1 < arg_148_1.time_ and arg_148_1.time_ <= var_151_1 + arg_151_0 then
				arg_148_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_151_2 = arg_148_1.actors_["1111ui_story"]
			local var_151_3 = 0

			if var_151_3 < arg_148_1.time_ and arg_148_1.time_ <= var_151_3 + arg_151_0 and not isNil(var_151_2) and arg_148_1.var_.characterEffect1111ui_story == nil then
				arg_148_1.var_.characterEffect1111ui_story = var_151_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_151_4 = 0.2

			if var_151_3 <= arg_148_1.time_ and arg_148_1.time_ < var_151_3 + var_151_4 and not isNil(var_151_2) then
				local var_151_5 = (arg_148_1.time_ - var_151_3) / var_151_4

				if arg_148_1.var_.characterEffect1111ui_story and not isNil(var_151_2) then
					arg_148_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_148_1.time_ >= var_151_3 + var_151_4 and arg_148_1.time_ < var_151_3 + var_151_4 + arg_151_0 and not isNil(var_151_2) and arg_148_1.var_.characterEffect1111ui_story then
				arg_148_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_151_6 = 0
			local var_151_7 = 1

			if var_151_6 < arg_148_1.time_ and arg_148_1.time_ <= var_151_6 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, true)

				local var_151_8 = arg_148_1:FormatText(StoryNameCfg[67].name)

				arg_148_1.leftNameTxt_.text = var_151_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_148_1.leftNameTxt_.transform)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1.leftNameTxt_.text)
				SetActive(arg_148_1.iconTrs_.gameObject, false)
				arg_148_1.callingController_:SetSelectedState("normal")

				local var_151_9 = arg_148_1:GetWordFromCfg(110152036)
				local var_151_10 = arg_148_1:FormatText(var_151_9.content)

				arg_148_1.text_.text = var_151_10

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_11 = 40
				local var_151_12 = utf8.len(var_151_10)
				local var_151_13 = var_151_11 <= 0 and var_151_7 or var_151_7 * (var_151_12 / var_151_11)

				if var_151_13 > 0 and var_151_7 < var_151_13 then
					arg_148_1.talkMaxDuration = var_151_13

					if var_151_13 + var_151_6 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_13 + var_151_6
					end
				end

				arg_148_1.text_.text = var_151_10
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_110152", "110152036", "story_v_out_110152.awb") ~= 0 then
					local var_151_14 = manager.audio:GetVoiceLength("story_v_out_110152", "110152036", "story_v_out_110152.awb") / 1000

					if var_151_14 + var_151_6 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_14 + var_151_6
					end

					if var_151_9.prefab_name ~= "" and arg_148_1.actors_[var_151_9.prefab_name] ~= nil then
						local var_151_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_148_1.actors_[var_151_9.prefab_name].transform, "story_v_out_110152", "110152036", "story_v_out_110152.awb")

						arg_148_1:RecordAudio("110152036", var_151_15)
						arg_148_1:RecordAudio("110152036", var_151_15)
					else
						arg_148_1:AudioAction("play", "voice", "story_v_out_110152", "110152036", "story_v_out_110152.awb")
					end

					arg_148_1:RecordHistoryTalkVoice("story_v_out_110152", "110152036", "story_v_out_110152.awb")
				end

				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_16 = math.max(var_151_7, arg_148_1.talkMaxDuration)

			if var_151_6 <= arg_148_1.time_ and arg_148_1.time_ < var_151_6 + var_151_16 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_6) / var_151_16

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_6 + var_151_16 and arg_148_1.time_ < var_151_6 + var_151_16 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {}

		arg_148_1:InitPlayNodeList()
	end,
	Play110152037 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 110152037
		arg_152_1.duration_ = 16.43

		local var_152_0 = {
			ja = 16.433,
			ko = 13.7,
			zh = 12.2,
			en = 14.833
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
				arg_152_0:Play110152038(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			local var_155_0 = 0

			if var_155_0 < arg_152_1.time_ and arg_152_1.time_ <= var_155_0 + arg_155_0 then
				arg_152_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111actionlink/1111action443")
			end

			local var_155_1 = 0

			if var_155_1 < arg_152_1.time_ and arg_152_1.time_ <= var_155_1 + arg_155_0 then
				arg_152_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0204cva")
			end

			local var_155_2 = 0
			local var_155_3 = 1.525

			if var_155_2 < arg_152_1.time_ and arg_152_1.time_ <= var_155_2 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, true)

				local var_155_4 = arg_152_1:FormatText(StoryNameCfg[67].name)

				arg_152_1.leftNameTxt_.text = var_155_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, false)
				arg_152_1.callingController_:SetSelectedState("normal")

				local var_155_5 = arg_152_1:GetWordFromCfg(110152037)
				local var_155_6 = arg_152_1:FormatText(var_155_5.content)

				arg_152_1.text_.text = var_155_6

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_7 = 61
				local var_155_8 = utf8.len(var_155_6)
				local var_155_9 = var_155_7 <= 0 and var_155_3 or var_155_3 * (var_155_8 / var_155_7)

				if var_155_9 > 0 and var_155_3 < var_155_9 then
					arg_152_1.talkMaxDuration = var_155_9

					if var_155_9 + var_155_2 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_9 + var_155_2
					end
				end

				arg_152_1.text_.text = var_155_6
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_110152", "110152037", "story_v_out_110152.awb") ~= 0 then
					local var_155_10 = manager.audio:GetVoiceLength("story_v_out_110152", "110152037", "story_v_out_110152.awb") / 1000

					if var_155_10 + var_155_2 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_10 + var_155_2
					end

					if var_155_5.prefab_name ~= "" and arg_152_1.actors_[var_155_5.prefab_name] ~= nil then
						local var_155_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_152_1.actors_[var_155_5.prefab_name].transform, "story_v_out_110152", "110152037", "story_v_out_110152.awb")

						arg_152_1:RecordAudio("110152037", var_155_11)
						arg_152_1:RecordAudio("110152037", var_155_11)
					else
						arg_152_1:AudioAction("play", "voice", "story_v_out_110152", "110152037", "story_v_out_110152.awb")
					end

					arg_152_1:RecordHistoryTalkVoice("story_v_out_110152", "110152037", "story_v_out_110152.awb")
				end

				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_12 = math.max(var_155_3, arg_152_1.talkMaxDuration)

			if var_155_2 <= arg_152_1.time_ and arg_152_1.time_ < var_155_2 + var_155_12 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_2) / var_155_12

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_2 + var_155_12 and arg_152_1.time_ < var_155_2 + var_155_12 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {}

		arg_152_1:InitPlayNodeList()
	end,
	Play110152038 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 110152038
		arg_156_1.duration_ = 8.2

		local var_156_0 = {
			ja = 7.533,
			ko = 5.466,
			zh = 6.2,
			en = 8.2
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
				arg_156_0:Play110152039(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			local var_159_0 = 0

			if var_159_0 < arg_156_1.time_ and arg_156_1.time_ <= var_159_0 + arg_159_0 then
				arg_156_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_159_1 = 0
			local var_159_2 = 0.825

			if var_159_1 < arg_156_1.time_ and arg_156_1.time_ <= var_159_1 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, true)

				local var_159_3 = arg_156_1:FormatText(StoryNameCfg[67].name)

				arg_156_1.leftNameTxt_.text = var_159_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_156_1.leftNameTxt_.transform)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1.leftNameTxt_.text)
				SetActive(arg_156_1.iconTrs_.gameObject, false)
				arg_156_1.callingController_:SetSelectedState("normal")

				local var_159_4 = arg_156_1:GetWordFromCfg(110152038)
				local var_159_5 = arg_156_1:FormatText(var_159_4.content)

				arg_156_1.text_.text = var_159_5

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_6 = 31
				local var_159_7 = utf8.len(var_159_5)
				local var_159_8 = var_159_6 <= 0 and var_159_2 or var_159_2 * (var_159_7 / var_159_6)

				if var_159_8 > 0 and var_159_2 < var_159_8 then
					arg_156_1.talkMaxDuration = var_159_8

					if var_159_8 + var_159_1 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_8 + var_159_1
					end
				end

				arg_156_1.text_.text = var_159_5
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_110152", "110152038", "story_v_out_110152.awb") ~= 0 then
					local var_159_9 = manager.audio:GetVoiceLength("story_v_out_110152", "110152038", "story_v_out_110152.awb") / 1000

					if var_159_9 + var_159_1 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_9 + var_159_1
					end

					if var_159_4.prefab_name ~= "" and arg_156_1.actors_[var_159_4.prefab_name] ~= nil then
						local var_159_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_156_1.actors_[var_159_4.prefab_name].transform, "story_v_out_110152", "110152038", "story_v_out_110152.awb")

						arg_156_1:RecordAudio("110152038", var_159_10)
						arg_156_1:RecordAudio("110152038", var_159_10)
					else
						arg_156_1:AudioAction("play", "voice", "story_v_out_110152", "110152038", "story_v_out_110152.awb")
					end

					arg_156_1:RecordHistoryTalkVoice("story_v_out_110152", "110152038", "story_v_out_110152.awb")
				end

				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_11 = math.max(var_159_2, arg_156_1.talkMaxDuration)

			if var_159_1 <= arg_156_1.time_ and arg_156_1.time_ < var_159_1 + var_159_11 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_1) / var_159_11

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_1 + var_159_11 and arg_156_1.time_ < var_159_1 + var_159_11 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {}

		arg_156_1:InitPlayNodeList()
	end,
	Play110152039 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 110152039
		arg_160_1.duration_ = 11.43

		local var_160_0 = {
			ja = 11.433,
			ko = 9.766,
			zh = 7.8,
			en = 7.033
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
				arg_160_0:Play110152040(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			local var_163_0 = 0

			if var_163_0 < arg_160_1.time_ and arg_160_1.time_ <= var_163_0 + arg_163_0 then
				arg_160_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action3_2")
			end

			local var_163_1 = 0

			if var_163_1 < arg_160_1.time_ and arg_160_1.time_ <= var_163_1 + arg_163_0 then
				arg_160_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_163_2 = 0
			local var_163_3 = 0.8

			if var_163_2 < arg_160_1.time_ and arg_160_1.time_ <= var_163_2 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, true)

				local var_163_4 = arg_160_1:FormatText(StoryNameCfg[67].name)

				arg_160_1.leftNameTxt_.text = var_163_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_160_1.leftNameTxt_.transform)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1.leftNameTxt_.text)
				SetActive(arg_160_1.iconTrs_.gameObject, false)
				arg_160_1.callingController_:SetSelectedState("normal")

				local var_163_5 = arg_160_1:GetWordFromCfg(110152039)
				local var_163_6 = arg_160_1:FormatText(var_163_5.content)

				arg_160_1.text_.text = var_163_6

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_7 = 32
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

				if manager.audio:GetVoiceLength("story_v_out_110152", "110152039", "story_v_out_110152.awb") ~= 0 then
					local var_163_10 = manager.audio:GetVoiceLength("story_v_out_110152", "110152039", "story_v_out_110152.awb") / 1000

					if var_163_10 + var_163_2 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_10 + var_163_2
					end

					if var_163_5.prefab_name ~= "" and arg_160_1.actors_[var_163_5.prefab_name] ~= nil then
						local var_163_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_160_1.actors_[var_163_5.prefab_name].transform, "story_v_out_110152", "110152039", "story_v_out_110152.awb")

						arg_160_1:RecordAudio("110152039", var_163_11)
						arg_160_1:RecordAudio("110152039", var_163_11)
					else
						arg_160_1:AudioAction("play", "voice", "story_v_out_110152", "110152039", "story_v_out_110152.awb")
					end

					arg_160_1:RecordHistoryTalkVoice("story_v_out_110152", "110152039", "story_v_out_110152.awb")
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
	Play110152040 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 110152040
		arg_164_1.duration_ = 5.03

		local var_164_0 = {
			ja = 2.066,
			ko = 3.466,
			zh = 4.4,
			en = 5.033
		}
		local var_164_1 = manager.audio:GetLocalizationFlag()

		if var_164_0[var_164_1] ~= nil then
			arg_164_1.duration_ = var_164_0[var_164_1]
		end

		SetActive(arg_164_1.tipsGo_, false)

		function arg_164_1.onSingleLineFinish_()
			arg_164_1.onSingleLineUpdate_ = nil
			arg_164_1.onSingleLineFinish_ = nil
			arg_164_1.state_ = "waiting"
		end

		function arg_164_1.playNext_(arg_166_0)
			if arg_166_0 == 1 then
				arg_164_0:Play110152041(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			local var_167_0 = arg_164_1.actors_["1111ui_story"].transform
			local var_167_1 = 0

			if var_167_1 < arg_164_1.time_ and arg_164_1.time_ <= var_167_1 + arg_167_0 then
				arg_164_1.var_.moveOldPos1111ui_story = var_167_0.localPosition
			end

			local var_167_2 = 0.5

			if var_167_1 <= arg_164_1.time_ and arg_164_1.time_ < var_167_1 + var_167_2 then
				local var_167_3 = (arg_164_1.time_ - var_167_1) / var_167_2
				local var_167_4 = Vector3.New(0.7, -0.87, -5.7)

				var_167_0.localPosition = Vector3.Lerp(arg_164_1.var_.moveOldPos1111ui_story, var_167_4, var_167_3)

				local var_167_5 = manager.ui.mainCamera.transform.position - var_167_0.position

				var_167_0.forward = Vector3.New(var_167_5.x, var_167_5.y, var_167_5.z)

				local var_167_6 = var_167_0.localEulerAngles

				var_167_6.z = 0
				var_167_6.x = 0
				var_167_0.localEulerAngles = var_167_6
			end

			if arg_164_1.time_ >= var_167_1 + var_167_2 and arg_164_1.time_ < var_167_1 + var_167_2 + arg_167_0 then
				var_167_0.localPosition = Vector3.New(0.7, -0.87, -5.7)

				local var_167_7 = manager.ui.mainCamera.transform.position - var_167_0.position

				var_167_0.forward = Vector3.New(var_167_7.x, var_167_7.y, var_167_7.z)

				local var_167_8 = var_167_0.localEulerAngles

				var_167_8.z = 0
				var_167_8.x = 0
				var_167_0.localEulerAngles = var_167_8
			end

			local var_167_9 = arg_164_1.actors_["1011ui_story"].transform
			local var_167_10 = 0

			if var_167_10 < arg_164_1.time_ and arg_164_1.time_ <= var_167_10 + arg_167_0 then
				arg_164_1.var_.moveOldPos1011ui_story = var_167_9.localPosition
			end

			local var_167_11 = 0.001

			if var_167_10 <= arg_164_1.time_ and arg_164_1.time_ < var_167_10 + var_167_11 then
				local var_167_12 = (arg_164_1.time_ - var_167_10) / var_167_11
				local var_167_13 = Vector3.New(-0.7, -0.71, -6)

				var_167_9.localPosition = Vector3.Lerp(arg_164_1.var_.moveOldPos1011ui_story, var_167_13, var_167_12)

				local var_167_14 = manager.ui.mainCamera.transform.position - var_167_9.position

				var_167_9.forward = Vector3.New(var_167_14.x, var_167_14.y, var_167_14.z)

				local var_167_15 = var_167_9.localEulerAngles

				var_167_15.z = 0
				var_167_15.x = 0
				var_167_9.localEulerAngles = var_167_15
			end

			if arg_164_1.time_ >= var_167_10 + var_167_11 and arg_164_1.time_ < var_167_10 + var_167_11 + arg_167_0 then
				var_167_9.localPosition = Vector3.New(-0.7, -0.71, -6)

				local var_167_16 = manager.ui.mainCamera.transform.position - var_167_9.position

				var_167_9.forward = Vector3.New(var_167_16.x, var_167_16.y, var_167_16.z)

				local var_167_17 = var_167_9.localEulerAngles

				var_167_17.z = 0
				var_167_17.x = 0
				var_167_9.localEulerAngles = var_167_17
			end

			local var_167_18 = 0

			if var_167_18 < arg_164_1.time_ and arg_164_1.time_ <= var_167_18 + arg_167_0 then
				arg_164_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action6_1")
			end

			local var_167_19 = 0

			if var_167_19 < arg_164_1.time_ and arg_164_1.time_ <= var_167_19 + arg_167_0 then
				arg_164_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_167_20 = arg_164_1.actors_["1011ui_story"]
			local var_167_21 = 0

			if var_167_21 < arg_164_1.time_ and arg_164_1.time_ <= var_167_21 + arg_167_0 and not isNil(var_167_20) and arg_164_1.var_.characterEffect1011ui_story == nil then
				arg_164_1.var_.characterEffect1011ui_story = var_167_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_167_22 = 0.2

			if var_167_21 <= arg_164_1.time_ and arg_164_1.time_ < var_167_21 + var_167_22 and not isNil(var_167_20) then
				local var_167_23 = (arg_164_1.time_ - var_167_21) / var_167_22

				if arg_164_1.var_.characterEffect1011ui_story and not isNil(var_167_20) then
					arg_164_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_164_1.time_ >= var_167_21 + var_167_22 and arg_164_1.time_ < var_167_21 + var_167_22 + arg_167_0 and not isNil(var_167_20) and arg_164_1.var_.characterEffect1011ui_story then
				arg_164_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_167_24 = arg_164_1.actors_["1111ui_story"]
			local var_167_25 = 0

			if var_167_25 < arg_164_1.time_ and arg_164_1.time_ <= var_167_25 + arg_167_0 and not isNil(var_167_24) and arg_164_1.var_.characterEffect1111ui_story == nil then
				arg_164_1.var_.characterEffect1111ui_story = var_167_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_167_26 = 0.2

			if var_167_25 <= arg_164_1.time_ and arg_164_1.time_ < var_167_25 + var_167_26 and not isNil(var_167_24) then
				local var_167_27 = (arg_164_1.time_ - var_167_25) / var_167_26

				if arg_164_1.var_.characterEffect1111ui_story and not isNil(var_167_24) then
					local var_167_28 = Mathf.Lerp(0, 0.5, var_167_27)

					arg_164_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_164_1.var_.characterEffect1111ui_story.fillRatio = var_167_28
				end
			end

			if arg_164_1.time_ >= var_167_25 + var_167_26 and arg_164_1.time_ < var_167_25 + var_167_26 + arg_167_0 and not isNil(var_167_24) and arg_164_1.var_.characterEffect1111ui_story then
				local var_167_29 = 0.5

				arg_164_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_164_1.var_.characterEffect1111ui_story.fillRatio = var_167_29
			end

			local var_167_30 = 0
			local var_167_31 = 0.425

			if var_167_30 < arg_164_1.time_ and arg_164_1.time_ <= var_167_30 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0
				arg_164_1.dialogCg_.alpha = 1

				arg_164_1.dialog_:SetActive(true)
				SetActive(arg_164_1.leftNameGo_, true)

				local var_167_32 = arg_164_1:FormatText(StoryNameCfg[37].name)

				arg_164_1.leftNameTxt_.text = var_167_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_164_1.leftNameTxt_.transform)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1.leftNameTxt_.text)
				SetActive(arg_164_1.iconTrs_.gameObject, false)
				arg_164_1.callingController_:SetSelectedState("normal")

				local var_167_33 = arg_164_1:GetWordFromCfg(110152040)
				local var_167_34 = arg_164_1:FormatText(var_167_33.content)

				arg_164_1.text_.text = var_167_34

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_35 = 17
				local var_167_36 = utf8.len(var_167_34)
				local var_167_37 = var_167_35 <= 0 and var_167_31 or var_167_31 * (var_167_36 / var_167_35)

				if var_167_37 > 0 and var_167_31 < var_167_37 then
					arg_164_1.talkMaxDuration = var_167_37

					if var_167_37 + var_167_30 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_37 + var_167_30
					end
				end

				arg_164_1.text_.text = var_167_34
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_110152", "110152040", "story_v_out_110152.awb") ~= 0 then
					local var_167_38 = manager.audio:GetVoiceLength("story_v_out_110152", "110152040", "story_v_out_110152.awb") / 1000

					if var_167_38 + var_167_30 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_38 + var_167_30
					end

					if var_167_33.prefab_name ~= "" and arg_164_1.actors_[var_167_33.prefab_name] ~= nil then
						local var_167_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_164_1.actors_[var_167_33.prefab_name].transform, "story_v_out_110152", "110152040", "story_v_out_110152.awb")

						arg_164_1:RecordAudio("110152040", var_167_39)
						arg_164_1:RecordAudio("110152040", var_167_39)
					else
						arg_164_1:AudioAction("play", "voice", "story_v_out_110152", "110152040", "story_v_out_110152.awb")
					end

					arg_164_1:RecordHistoryTalkVoice("story_v_out_110152", "110152040", "story_v_out_110152.awb")
				end

				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_40 = math.max(var_167_31, arg_164_1.talkMaxDuration)

			if var_167_30 <= arg_164_1.time_ and arg_164_1.time_ < var_167_30 + var_167_40 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - var_167_30) / var_167_40

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= var_167_30 + var_167_40 and arg_164_1.time_ < var_167_30 + var_167_40 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_164_1:InitPlayNodeList()
	end,
	Play110152041 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 110152041
		arg_168_1.duration_ = 2

		SetActive(arg_168_1.tipsGo_, false)

		function arg_168_1.onSingleLineFinish_()
			arg_168_1.onSingleLineUpdate_ = nil
			arg_168_1.onSingleLineFinish_ = nil
			arg_168_1.state_ = "waiting"
		end

		function arg_168_1.playNext_(arg_170_0)
			if arg_170_0 == 1 then
				arg_168_0:Play110152042(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			local var_171_0 = 0

			if var_171_0 < arg_168_1.time_ and arg_168_1.time_ <= var_171_0 + arg_171_0 then
				arg_168_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action5_1")
			end

			local var_171_1 = 0

			if var_171_1 < arg_168_1.time_ and arg_168_1.time_ <= var_171_1 + arg_171_0 then
				arg_168_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_171_2 = arg_168_1.actors_["1111ui_story"]
			local var_171_3 = 0

			if var_171_3 < arg_168_1.time_ and arg_168_1.time_ <= var_171_3 + arg_171_0 and not isNil(var_171_2) and arg_168_1.var_.characterEffect1111ui_story == nil then
				arg_168_1.var_.characterEffect1111ui_story = var_171_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_171_4 = 0.2

			if var_171_3 <= arg_168_1.time_ and arg_168_1.time_ < var_171_3 + var_171_4 and not isNil(var_171_2) then
				local var_171_5 = (arg_168_1.time_ - var_171_3) / var_171_4

				if arg_168_1.var_.characterEffect1111ui_story and not isNil(var_171_2) then
					arg_168_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_168_1.time_ >= var_171_3 + var_171_4 and arg_168_1.time_ < var_171_3 + var_171_4 + arg_171_0 and not isNil(var_171_2) and arg_168_1.var_.characterEffect1111ui_story then
				arg_168_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_171_6 = arg_168_1.actors_["1011ui_story"]
			local var_171_7 = 0

			if var_171_7 < arg_168_1.time_ and arg_168_1.time_ <= var_171_7 + arg_171_0 and not isNil(var_171_6) and arg_168_1.var_.characterEffect1011ui_story == nil then
				arg_168_1.var_.characterEffect1011ui_story = var_171_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_171_8 = 0.2

			if var_171_7 <= arg_168_1.time_ and arg_168_1.time_ < var_171_7 + var_171_8 and not isNil(var_171_6) then
				local var_171_9 = (arg_168_1.time_ - var_171_7) / var_171_8

				if arg_168_1.var_.characterEffect1011ui_story and not isNil(var_171_6) then
					local var_171_10 = Mathf.Lerp(0, 0.5, var_171_9)

					arg_168_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_168_1.var_.characterEffect1011ui_story.fillRatio = var_171_10
				end
			end

			if arg_168_1.time_ >= var_171_7 + var_171_8 and arg_168_1.time_ < var_171_7 + var_171_8 + arg_171_0 and not isNil(var_171_6) and arg_168_1.var_.characterEffect1011ui_story then
				local var_171_11 = 0.5

				arg_168_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_168_1.var_.characterEffect1011ui_story.fillRatio = var_171_11
			end

			local var_171_12 = 0
			local var_171_13 = 0.05

			if var_171_12 < arg_168_1.time_ and arg_168_1.time_ <= var_171_12 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0
				arg_168_1.dialogCg_.alpha = 1

				arg_168_1.dialog_:SetActive(true)
				SetActive(arg_168_1.leftNameGo_, true)

				local var_171_14 = arg_168_1:FormatText(StoryNameCfg[67].name)

				arg_168_1.leftNameTxt_.text = var_171_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_168_1.leftNameTxt_.transform)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1.leftNameTxt_.text)
				SetActive(arg_168_1.iconTrs_.gameObject, false)
				arg_168_1.callingController_:SetSelectedState("normal")

				local var_171_15 = arg_168_1:GetWordFromCfg(110152041)
				local var_171_16 = arg_168_1:FormatText(var_171_15.content)

				arg_168_1.text_.text = var_171_16

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_17 = 2
				local var_171_18 = utf8.len(var_171_16)
				local var_171_19 = var_171_17 <= 0 and var_171_13 or var_171_13 * (var_171_18 / var_171_17)

				if var_171_19 > 0 and var_171_13 < var_171_19 then
					arg_168_1.talkMaxDuration = var_171_19

					if var_171_19 + var_171_12 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_19 + var_171_12
					end
				end

				arg_168_1.text_.text = var_171_16
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_110152", "110152041", "story_v_out_110152.awb") ~= 0 then
					local var_171_20 = manager.audio:GetVoiceLength("story_v_out_110152", "110152041", "story_v_out_110152.awb") / 1000

					if var_171_20 + var_171_12 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_20 + var_171_12
					end

					if var_171_15.prefab_name ~= "" and arg_168_1.actors_[var_171_15.prefab_name] ~= nil then
						local var_171_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_168_1.actors_[var_171_15.prefab_name].transform, "story_v_out_110152", "110152041", "story_v_out_110152.awb")

						arg_168_1:RecordAudio("110152041", var_171_21)
						arg_168_1:RecordAudio("110152041", var_171_21)
					else
						arg_168_1:AudioAction("play", "voice", "story_v_out_110152", "110152041", "story_v_out_110152.awb")
					end

					arg_168_1:RecordHistoryTalkVoice("story_v_out_110152", "110152041", "story_v_out_110152.awb")
				end

				arg_168_1:RecordContent(arg_168_1.text_.text)
			end

			local var_171_22 = math.max(var_171_13, arg_168_1.talkMaxDuration)

			if var_171_12 <= arg_168_1.time_ and arg_168_1.time_ < var_171_12 + var_171_22 then
				arg_168_1.typewritter.percent = (arg_168_1.time_ - var_171_12) / var_171_22

				arg_168_1.typewritter:SetDirty()
			end

			if arg_168_1.time_ >= var_171_12 + var_171_22 and arg_168_1.time_ < var_171_12 + var_171_22 + arg_171_0 then
				arg_168_1.typewritter.percent = 1

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(true)
			end
		end

		arg_168_1.nodeConfigList_ = {}

		arg_168_1:InitPlayNodeList()
	end,
	Play110152042 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 110152042
		arg_172_1.duration_ = 12.6

		local var_172_0 = {
			ja = 12.6,
			ko = 8.166,
			zh = 9.633,
			en = 5.266
		}
		local var_172_1 = manager.audio:GetLocalizationFlag()

		if var_172_0[var_172_1] ~= nil then
			arg_172_1.duration_ = var_172_0[var_172_1]
		end

		SetActive(arg_172_1.tipsGo_, false)

		function arg_172_1.onSingleLineFinish_()
			arg_172_1.onSingleLineUpdate_ = nil
			arg_172_1.onSingleLineFinish_ = nil
			arg_172_1.state_ = "waiting"
		end

		function arg_172_1.playNext_(arg_174_0)
			if arg_174_0 == 1 then
				arg_172_0:Play110152043(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			local var_175_0 = arg_172_1.actors_["1011ui_story"]
			local var_175_1 = 0

			if var_175_1 < arg_172_1.time_ and arg_172_1.time_ <= var_175_1 + arg_175_0 and not isNil(var_175_0) and arg_172_1.var_.characterEffect1011ui_story == nil then
				arg_172_1.var_.characterEffect1011ui_story = var_175_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_175_2 = 0.2

			if var_175_1 <= arg_172_1.time_ and arg_172_1.time_ < var_175_1 + var_175_2 and not isNil(var_175_0) then
				local var_175_3 = (arg_172_1.time_ - var_175_1) / var_175_2

				if arg_172_1.var_.characterEffect1011ui_story and not isNil(var_175_0) then
					arg_172_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_172_1.time_ >= var_175_1 + var_175_2 and arg_172_1.time_ < var_175_1 + var_175_2 + arg_175_0 and not isNil(var_175_0) and arg_172_1.var_.characterEffect1011ui_story then
				arg_172_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_175_4 = arg_172_1.actors_["1111ui_story"]
			local var_175_5 = 0

			if var_175_5 < arg_172_1.time_ and arg_172_1.time_ <= var_175_5 + arg_175_0 and not isNil(var_175_4) and arg_172_1.var_.characterEffect1111ui_story == nil then
				arg_172_1.var_.characterEffect1111ui_story = var_175_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_175_6 = 0.2

			if var_175_5 <= arg_172_1.time_ and arg_172_1.time_ < var_175_5 + var_175_6 and not isNil(var_175_4) then
				local var_175_7 = (arg_172_1.time_ - var_175_5) / var_175_6

				if arg_172_1.var_.characterEffect1111ui_story and not isNil(var_175_4) then
					local var_175_8 = Mathf.Lerp(0, 0.5, var_175_7)

					arg_172_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_172_1.var_.characterEffect1111ui_story.fillRatio = var_175_8
				end
			end

			if arg_172_1.time_ >= var_175_5 + var_175_6 and arg_172_1.time_ < var_175_5 + var_175_6 + arg_175_0 and not isNil(var_175_4) and arg_172_1.var_.characterEffect1111ui_story then
				local var_175_9 = 0.5

				arg_172_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_172_1.var_.characterEffect1111ui_story.fillRatio = var_175_9
			end

			local var_175_10 = 0

			if var_175_10 < arg_172_1.time_ and arg_172_1.time_ <= var_175_10 + arg_175_0 then
				arg_172_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_175_11 = 0
			local var_175_12 = 0.6

			if var_175_11 < arg_172_1.time_ and arg_172_1.time_ <= var_175_11 + arg_175_0 then
				local var_175_13 = "play"
				local var_175_14 = "music"

				arg_172_1:AudioAction(var_175_13, var_175_14, "ui_battle", "ui_battle_stopbgm", "")

				local var_175_15 = ""
				local var_175_16 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_175_16 ~= "" then
					if arg_172_1.bgmTxt_.text ~= var_175_16 and arg_172_1.bgmTxt_.text ~= "" then
						if arg_172_1.bgmTxt2_.text ~= "" then
							arg_172_1.bgmTxt_.text = arg_172_1.bgmTxt2_.text
						end

						arg_172_1.bgmTxt2_.text = var_175_16

						arg_172_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_172_1.bgmTxt_.text = var_175_16
						arg_172_1.bgmTxt2_.text = var_175_16
					end

					if arg_172_1.bgmTimer then
						arg_172_1.bgmTimer:Stop()

						arg_172_1.bgmTimer = nil
					end

					if arg_172_1.settingData.show_music_name == 1 then
						arg_172_1.musicController:SetSelectedState("show")
						arg_172_1.musicAnimator_:Play("open", 0, 0)

						if arg_172_1.settingData.music_time ~= 0 then
							arg_172_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_172_1.settingData.music_time), function()
								if arg_172_1 == nil or isNil(arg_172_1.bgmTxt_) then
									return
								end

								arg_172_1.musicController:SetSelectedState("hide")
								arg_172_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_175_17 = 0.738461699336767
			local var_175_18 = 1

			if var_175_17 < arg_172_1.time_ and arg_172_1.time_ <= var_175_17 + arg_175_0 then
				local var_175_19 = "play"
				local var_175_20 = "music"

				arg_172_1:AudioAction(var_175_19, var_175_20, "bgm_activity_1_0_1_osiris_ui", "bgm_activity_1_0_1_osiris_ui", "bgm_activity_1_0_1_osiris_ui.awb")

				local var_175_21 = ""
				local var_175_22 = manager.audio:GetAudioName("bgm_activity_1_0_1_osiris_ui", "bgm_activity_1_0_1_osiris_ui")

				if var_175_22 ~= "" then
					if arg_172_1.bgmTxt_.text ~= var_175_22 and arg_172_1.bgmTxt_.text ~= "" then
						if arg_172_1.bgmTxt2_.text ~= "" then
							arg_172_1.bgmTxt_.text = arg_172_1.bgmTxt2_.text
						end

						arg_172_1.bgmTxt2_.text = var_175_22

						arg_172_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_172_1.bgmTxt_.text = var_175_22
						arg_172_1.bgmTxt2_.text = var_175_22
					end

					if arg_172_1.bgmTimer then
						arg_172_1.bgmTimer:Stop()

						arg_172_1.bgmTimer = nil
					end

					if arg_172_1.settingData.show_music_name == 1 then
						arg_172_1.musicController:SetSelectedState("show")
						arg_172_1.musicAnimator_:Play("open", 0, 0)

						if arg_172_1.settingData.music_time ~= 0 then
							arg_172_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_172_1.settingData.music_time), function()
								if arg_172_1 == nil or isNil(arg_172_1.bgmTxt_) then
									return
								end

								arg_172_1.musicController:SetSelectedState("hide")
								arg_172_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_175_23 = 0
			local var_175_24 = 0.775

			if var_175_23 < arg_172_1.time_ and arg_172_1.time_ <= var_175_23 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, true)

				local var_175_25 = arg_172_1:FormatText(StoryNameCfg[37].name)

				arg_172_1.leftNameTxt_.text = var_175_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_172_1.leftNameTxt_.transform)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1.leftNameTxt_.text)
				SetActive(arg_172_1.iconTrs_.gameObject, false)
				arg_172_1.callingController_:SetSelectedState("normal")

				local var_175_26 = arg_172_1:GetWordFromCfg(110152042)
				local var_175_27 = arg_172_1:FormatText(var_175_26.content)

				arg_172_1.text_.text = var_175_27

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_28 = 31
				local var_175_29 = utf8.len(var_175_27)
				local var_175_30 = var_175_28 <= 0 and var_175_24 or var_175_24 * (var_175_29 / var_175_28)

				if var_175_30 > 0 and var_175_24 < var_175_30 then
					arg_172_1.talkMaxDuration = var_175_30

					if var_175_30 + var_175_23 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_30 + var_175_23
					end
				end

				arg_172_1.text_.text = var_175_27
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_110152", "110152042", "story_v_out_110152.awb") ~= 0 then
					local var_175_31 = manager.audio:GetVoiceLength("story_v_out_110152", "110152042", "story_v_out_110152.awb") / 1000

					if var_175_31 + var_175_23 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_31 + var_175_23
					end

					if var_175_26.prefab_name ~= "" and arg_172_1.actors_[var_175_26.prefab_name] ~= nil then
						local var_175_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_172_1.actors_[var_175_26.prefab_name].transform, "story_v_out_110152", "110152042", "story_v_out_110152.awb")

						arg_172_1:RecordAudio("110152042", var_175_32)
						arg_172_1:RecordAudio("110152042", var_175_32)
					else
						arg_172_1:AudioAction("play", "voice", "story_v_out_110152", "110152042", "story_v_out_110152.awb")
					end

					arg_172_1:RecordHistoryTalkVoice("story_v_out_110152", "110152042", "story_v_out_110152.awb")
				end

				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_33 = math.max(var_175_24, arg_172_1.talkMaxDuration)

			if var_175_23 <= arg_172_1.time_ and arg_172_1.time_ < var_175_23 + var_175_33 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - var_175_23) / var_175_33

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= var_175_23 + var_175_33 and arg_172_1.time_ < var_175_23 + var_175_33 + arg_175_0 then
				arg_172_1.typewritter.percent = 1

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(true)
			end
		end

		arg_172_1.nodeConfigList_ = {}

		arg_172_1:InitPlayNodeList()
	end,
	Play110152043 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 110152043
		arg_178_1.duration_ = 5.17

		local var_178_0 = {
			ja = 3.533,
			ko = 5.166,
			zh = 5,
			en = 5
		}
		local var_178_1 = manager.audio:GetLocalizationFlag()

		if var_178_0[var_178_1] ~= nil then
			arg_178_1.duration_ = var_178_0[var_178_1]
		end

		SetActive(arg_178_1.tipsGo_, false)

		function arg_178_1.onSingleLineFinish_()
			arg_178_1.onSingleLineUpdate_ = nil
			arg_178_1.onSingleLineFinish_ = nil
			arg_178_1.state_ = "waiting"
		end

		function arg_178_1.playNext_(arg_180_0)
			if arg_180_0 == 1 then
				arg_178_0:Play110152044(arg_178_1)
			end
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			local var_181_0 = arg_178_1.actors_["1111ui_story"]
			local var_181_1 = 0

			if var_181_1 < arg_178_1.time_ and arg_178_1.time_ <= var_181_1 + arg_181_0 and not isNil(var_181_0) and arg_178_1.var_.characterEffect1111ui_story == nil then
				arg_178_1.var_.characterEffect1111ui_story = var_181_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_181_2 = 0.2

			if var_181_1 <= arg_178_1.time_ and arg_178_1.time_ < var_181_1 + var_181_2 and not isNil(var_181_0) then
				local var_181_3 = (arg_178_1.time_ - var_181_1) / var_181_2

				if arg_178_1.var_.characterEffect1111ui_story and not isNil(var_181_0) then
					arg_178_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_178_1.time_ >= var_181_1 + var_181_2 and arg_178_1.time_ < var_181_1 + var_181_2 + arg_181_0 and not isNil(var_181_0) and arg_178_1.var_.characterEffect1111ui_story then
				arg_178_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_181_4 = arg_178_1.actors_["1011ui_story"]
			local var_181_5 = 0

			if var_181_5 < arg_178_1.time_ and arg_178_1.time_ <= var_181_5 + arg_181_0 and not isNil(var_181_4) and arg_178_1.var_.characterEffect1011ui_story == nil then
				arg_178_1.var_.characterEffect1011ui_story = var_181_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_181_6 = 0.2

			if var_181_5 <= arg_178_1.time_ and arg_178_1.time_ < var_181_5 + var_181_6 and not isNil(var_181_4) then
				local var_181_7 = (arg_178_1.time_ - var_181_5) / var_181_6

				if arg_178_1.var_.characterEffect1011ui_story and not isNil(var_181_4) then
					local var_181_8 = Mathf.Lerp(0, 0.5, var_181_7)

					arg_178_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_178_1.var_.characterEffect1011ui_story.fillRatio = var_181_8
				end
			end

			if arg_178_1.time_ >= var_181_5 + var_181_6 and arg_178_1.time_ < var_181_5 + var_181_6 + arg_181_0 and not isNil(var_181_4) and arg_178_1.var_.characterEffect1011ui_story then
				local var_181_9 = 0.5

				arg_178_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_178_1.var_.characterEffect1011ui_story.fillRatio = var_181_9
			end

			local var_181_10 = 0

			if var_181_10 < arg_178_1.time_ and arg_178_1.time_ <= var_181_10 + arg_181_0 then
				arg_178_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111actionlink/1111action453")
			end

			local var_181_11 = 0

			if var_181_11 < arg_178_1.time_ and arg_178_1.time_ <= var_181_11 + arg_181_0 then
				arg_178_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0204cva")
			end

			local var_181_12 = 0
			local var_181_13 = 0.575

			if var_181_12 < arg_178_1.time_ and arg_178_1.time_ <= var_181_12 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0
				arg_178_1.dialogCg_.alpha = 1

				arg_178_1.dialog_:SetActive(true)
				SetActive(arg_178_1.leftNameGo_, true)

				local var_181_14 = arg_178_1:FormatText(StoryNameCfg[67].name)

				arg_178_1.leftNameTxt_.text = var_181_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_178_1.leftNameTxt_.transform)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1.leftNameTxt_.text)
				SetActive(arg_178_1.iconTrs_.gameObject, false)
				arg_178_1.callingController_:SetSelectedState("normal")

				local var_181_15 = arg_178_1:GetWordFromCfg(110152043)
				local var_181_16 = arg_178_1:FormatText(var_181_15.content)

				arg_178_1.text_.text = var_181_16

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_17 = 23
				local var_181_18 = utf8.len(var_181_16)
				local var_181_19 = var_181_17 <= 0 and var_181_13 or var_181_13 * (var_181_18 / var_181_17)

				if var_181_19 > 0 and var_181_13 < var_181_19 then
					arg_178_1.talkMaxDuration = var_181_19

					if var_181_19 + var_181_12 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_19 + var_181_12
					end
				end

				arg_178_1.text_.text = var_181_16
				arg_178_1.typewritter.percent = 0

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_110152", "110152043", "story_v_out_110152.awb") ~= 0 then
					local var_181_20 = manager.audio:GetVoiceLength("story_v_out_110152", "110152043", "story_v_out_110152.awb") / 1000

					if var_181_20 + var_181_12 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_20 + var_181_12
					end

					if var_181_15.prefab_name ~= "" and arg_178_1.actors_[var_181_15.prefab_name] ~= nil then
						local var_181_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_178_1.actors_[var_181_15.prefab_name].transform, "story_v_out_110152", "110152043", "story_v_out_110152.awb")

						arg_178_1:RecordAudio("110152043", var_181_21)
						arg_178_1:RecordAudio("110152043", var_181_21)
					else
						arg_178_1:AudioAction("play", "voice", "story_v_out_110152", "110152043", "story_v_out_110152.awb")
					end

					arg_178_1:RecordHistoryTalkVoice("story_v_out_110152", "110152043", "story_v_out_110152.awb")
				end

				arg_178_1:RecordContent(arg_178_1.text_.text)
			end

			local var_181_22 = math.max(var_181_13, arg_178_1.talkMaxDuration)

			if var_181_12 <= arg_178_1.time_ and arg_178_1.time_ < var_181_12 + var_181_22 then
				arg_178_1.typewritter.percent = (arg_178_1.time_ - var_181_12) / var_181_22

				arg_178_1.typewritter:SetDirty()
			end

			if arg_178_1.time_ >= var_181_12 + var_181_22 and arg_178_1.time_ < var_181_12 + var_181_22 + arg_181_0 then
				arg_178_1.typewritter.percent = 1

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(true)
			end
		end

		arg_178_1.nodeConfigList_ = {}

		arg_178_1:InitPlayNodeList()
	end,
	Play110152044 = function(arg_182_0, arg_182_1)
		arg_182_1.time_ = 0
		arg_182_1.frameCnt_ = 0
		arg_182_1.state_ = "playing"
		arg_182_1.curTalkId_ = 110152044
		arg_182_1.duration_ = 12.93

		local var_182_0 = {
			ja = 12.4,
			ko = 12.933,
			zh = 12.3,
			en = 12
		}
		local var_182_1 = manager.audio:GetLocalizationFlag()

		if var_182_0[var_182_1] ~= nil then
			arg_182_1.duration_ = var_182_0[var_182_1]
		end

		SetActive(arg_182_1.tipsGo_, false)

		function arg_182_1.onSingleLineFinish_()
			arg_182_1.onSingleLineUpdate_ = nil
			arg_182_1.onSingleLineFinish_ = nil
			arg_182_1.state_ = "waiting"
		end

		function arg_182_1.playNext_(arg_184_0)
			if arg_184_0 == 1 then
				arg_182_0:Play110152045(arg_182_1)
			end
		end

		function arg_182_1.onSingleLineUpdate_(arg_185_0)
			local var_185_0 = 0

			if var_185_0 < arg_182_1.time_ and arg_182_1.time_ <= var_185_0 + arg_185_0 then
				arg_182_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_185_1 = arg_182_1.actors_["1011ui_story"]
			local var_185_2 = 0

			if var_185_2 < arg_182_1.time_ and arg_182_1.time_ <= var_185_2 + arg_185_0 and not isNil(var_185_1) and arg_182_1.var_.characterEffect1011ui_story == nil then
				arg_182_1.var_.characterEffect1011ui_story = var_185_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_185_3 = 0.2

			if var_185_2 <= arg_182_1.time_ and arg_182_1.time_ < var_185_2 + var_185_3 and not isNil(var_185_1) then
				local var_185_4 = (arg_182_1.time_ - var_185_2) / var_185_3

				if arg_182_1.var_.characterEffect1011ui_story and not isNil(var_185_1) then
					arg_182_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_182_1.time_ >= var_185_2 + var_185_3 and arg_182_1.time_ < var_185_2 + var_185_3 + arg_185_0 and not isNil(var_185_1) and arg_182_1.var_.characterEffect1011ui_story then
				arg_182_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_185_5 = arg_182_1.actors_["1111ui_story"]
			local var_185_6 = 0

			if var_185_6 < arg_182_1.time_ and arg_182_1.time_ <= var_185_6 + arg_185_0 and not isNil(var_185_5) and arg_182_1.var_.characterEffect1111ui_story == nil then
				arg_182_1.var_.characterEffect1111ui_story = var_185_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_185_7 = 0.2

			if var_185_6 <= arg_182_1.time_ and arg_182_1.time_ < var_185_6 + var_185_7 and not isNil(var_185_5) then
				local var_185_8 = (arg_182_1.time_ - var_185_6) / var_185_7

				if arg_182_1.var_.characterEffect1111ui_story and not isNil(var_185_5) then
					local var_185_9 = Mathf.Lerp(0, 0.5, var_185_8)

					arg_182_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_182_1.var_.characterEffect1111ui_story.fillRatio = var_185_9
				end
			end

			if arg_182_1.time_ >= var_185_6 + var_185_7 and arg_182_1.time_ < var_185_6 + var_185_7 + arg_185_0 and not isNil(var_185_5) and arg_182_1.var_.characterEffect1111ui_story then
				local var_185_10 = 0.5

				arg_182_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_182_1.var_.characterEffect1111ui_story.fillRatio = var_185_10
			end

			local var_185_11 = 0
			local var_185_12 = 1.175

			if var_185_11 < arg_182_1.time_ and arg_182_1.time_ <= var_185_11 + arg_185_0 then
				arg_182_1.talkMaxDuration = 0
				arg_182_1.dialogCg_.alpha = 1

				arg_182_1.dialog_:SetActive(true)
				SetActive(arg_182_1.leftNameGo_, true)

				local var_185_13 = arg_182_1:FormatText(StoryNameCfg[37].name)

				arg_182_1.leftNameTxt_.text = var_185_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_182_1.leftNameTxt_.transform)

				arg_182_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_182_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_182_1:RecordName(arg_182_1.leftNameTxt_.text)
				SetActive(arg_182_1.iconTrs_.gameObject, false)
				arg_182_1.callingController_:SetSelectedState("normal")

				local var_185_14 = arg_182_1:GetWordFromCfg(110152044)
				local var_185_15 = arg_182_1:FormatText(var_185_14.content)

				arg_182_1.text_.text = var_185_15

				LuaForUtil.ClearLinePrefixSymbol(arg_182_1.text_)

				local var_185_16 = 47
				local var_185_17 = utf8.len(var_185_15)
				local var_185_18 = var_185_16 <= 0 and var_185_12 or var_185_12 * (var_185_17 / var_185_16)

				if var_185_18 > 0 and var_185_12 < var_185_18 then
					arg_182_1.talkMaxDuration = var_185_18

					if var_185_18 + var_185_11 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_18 + var_185_11
					end
				end

				arg_182_1.text_.text = var_185_15
				arg_182_1.typewritter.percent = 0

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_110152", "110152044", "story_v_out_110152.awb") ~= 0 then
					local var_185_19 = manager.audio:GetVoiceLength("story_v_out_110152", "110152044", "story_v_out_110152.awb") / 1000

					if var_185_19 + var_185_11 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_19 + var_185_11
					end

					if var_185_14.prefab_name ~= "" and arg_182_1.actors_[var_185_14.prefab_name] ~= nil then
						local var_185_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_182_1.actors_[var_185_14.prefab_name].transform, "story_v_out_110152", "110152044", "story_v_out_110152.awb")

						arg_182_1:RecordAudio("110152044", var_185_20)
						arg_182_1:RecordAudio("110152044", var_185_20)
					else
						arg_182_1:AudioAction("play", "voice", "story_v_out_110152", "110152044", "story_v_out_110152.awb")
					end

					arg_182_1:RecordHistoryTalkVoice("story_v_out_110152", "110152044", "story_v_out_110152.awb")
				end

				arg_182_1:RecordContent(arg_182_1.text_.text)
			end

			local var_185_21 = math.max(var_185_12, arg_182_1.talkMaxDuration)

			if var_185_11 <= arg_182_1.time_ and arg_182_1.time_ < var_185_11 + var_185_21 then
				arg_182_1.typewritter.percent = (arg_182_1.time_ - var_185_11) / var_185_21

				arg_182_1.typewritter:SetDirty()
			end

			if arg_182_1.time_ >= var_185_11 + var_185_21 and arg_182_1.time_ < var_185_11 + var_185_21 + arg_185_0 then
				arg_182_1.typewritter.percent = 1

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(true)
			end
		end

		arg_182_1.nodeConfigList_ = {}

		arg_182_1:InitPlayNodeList()
	end,
	Play110152045 = function(arg_186_0, arg_186_1)
		arg_186_1.time_ = 0
		arg_186_1.frameCnt_ = 0
		arg_186_1.state_ = "playing"
		arg_186_1.curTalkId_ = 110152045
		arg_186_1.duration_ = 2

		SetActive(arg_186_1.tipsGo_, false)

		function arg_186_1.onSingleLineFinish_()
			arg_186_1.onSingleLineUpdate_ = nil
			arg_186_1.onSingleLineFinish_ = nil
			arg_186_1.state_ = "waiting"
		end

		function arg_186_1.playNext_(arg_188_0)
			if arg_188_0 == 1 then
				arg_186_0:Play110152046(arg_186_1)
			end
		end

		function arg_186_1.onSingleLineUpdate_(arg_189_0)
			local var_189_0 = 0

			if var_189_0 < arg_186_1.time_ and arg_186_1.time_ <= var_189_0 + arg_189_0 then
				arg_186_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_189_1 = arg_186_1.actors_["1011ui_story"]
			local var_189_2 = 0

			if var_189_2 < arg_186_1.time_ and arg_186_1.time_ <= var_189_2 + arg_189_0 and not isNil(var_189_1) and arg_186_1.var_.characterEffect1011ui_story == nil then
				arg_186_1.var_.characterEffect1011ui_story = var_189_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_189_3 = 0.2

			if var_189_2 <= arg_186_1.time_ and arg_186_1.time_ < var_189_2 + var_189_3 and not isNil(var_189_1) then
				local var_189_4 = (arg_186_1.time_ - var_189_2) / var_189_3

				if arg_186_1.var_.characterEffect1011ui_story and not isNil(var_189_1) then
					local var_189_5 = Mathf.Lerp(0, 0.5, var_189_4)

					arg_186_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_186_1.var_.characterEffect1011ui_story.fillRatio = var_189_5
				end
			end

			if arg_186_1.time_ >= var_189_2 + var_189_3 and arg_186_1.time_ < var_189_2 + var_189_3 + arg_189_0 and not isNil(var_189_1) and arg_186_1.var_.characterEffect1011ui_story then
				local var_189_6 = 0.5

				arg_186_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_186_1.var_.characterEffect1011ui_story.fillRatio = var_189_6
			end

			local var_189_7 = arg_186_1.actors_["1111ui_story"]
			local var_189_8 = 0

			if var_189_8 < arg_186_1.time_ and arg_186_1.time_ <= var_189_8 + arg_189_0 and not isNil(var_189_7) and arg_186_1.var_.characterEffect1111ui_story == nil then
				arg_186_1.var_.characterEffect1111ui_story = var_189_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_189_9 = 0.2

			if var_189_8 <= arg_186_1.time_ and arg_186_1.time_ < var_189_8 + var_189_9 and not isNil(var_189_7) then
				local var_189_10 = (arg_186_1.time_ - var_189_8) / var_189_9

				if arg_186_1.var_.characterEffect1111ui_story and not isNil(var_189_7) then
					arg_186_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_186_1.time_ >= var_189_8 + var_189_9 and arg_186_1.time_ < var_189_8 + var_189_9 + arg_189_0 and not isNil(var_189_7) and arg_186_1.var_.characterEffect1111ui_story then
				arg_186_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_189_11 = 0
			local var_189_12 = 0.05

			if var_189_11 < arg_186_1.time_ and arg_186_1.time_ <= var_189_11 + arg_189_0 then
				arg_186_1.talkMaxDuration = 0
				arg_186_1.dialogCg_.alpha = 1

				arg_186_1.dialog_:SetActive(true)
				SetActive(arg_186_1.leftNameGo_, true)

				local var_189_13 = arg_186_1:FormatText(StoryNameCfg[67].name)

				arg_186_1.leftNameTxt_.text = var_189_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_186_1.leftNameTxt_.transform)

				arg_186_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_186_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_186_1:RecordName(arg_186_1.leftNameTxt_.text)
				SetActive(arg_186_1.iconTrs_.gameObject, false)
				arg_186_1.callingController_:SetSelectedState("normal")

				local var_189_14 = arg_186_1:GetWordFromCfg(110152045)
				local var_189_15 = arg_186_1:FormatText(var_189_14.content)

				arg_186_1.text_.text = var_189_15

				LuaForUtil.ClearLinePrefixSymbol(arg_186_1.text_)

				local var_189_16 = 2
				local var_189_17 = utf8.len(var_189_15)
				local var_189_18 = var_189_16 <= 0 and var_189_12 or var_189_12 * (var_189_17 / var_189_16)

				if var_189_18 > 0 and var_189_12 < var_189_18 then
					arg_186_1.talkMaxDuration = var_189_18

					if var_189_18 + var_189_11 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_18 + var_189_11
					end
				end

				arg_186_1.text_.text = var_189_15
				arg_186_1.typewritter.percent = 0

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_110152", "110152045", "story_v_out_110152.awb") ~= 0 then
					local var_189_19 = manager.audio:GetVoiceLength("story_v_out_110152", "110152045", "story_v_out_110152.awb") / 1000

					if var_189_19 + var_189_11 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_19 + var_189_11
					end

					if var_189_14.prefab_name ~= "" and arg_186_1.actors_[var_189_14.prefab_name] ~= nil then
						local var_189_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_186_1.actors_[var_189_14.prefab_name].transform, "story_v_out_110152", "110152045", "story_v_out_110152.awb")

						arg_186_1:RecordAudio("110152045", var_189_20)
						arg_186_1:RecordAudio("110152045", var_189_20)
					else
						arg_186_1:AudioAction("play", "voice", "story_v_out_110152", "110152045", "story_v_out_110152.awb")
					end

					arg_186_1:RecordHistoryTalkVoice("story_v_out_110152", "110152045", "story_v_out_110152.awb")
				end

				arg_186_1:RecordContent(arg_186_1.text_.text)
			end

			local var_189_21 = math.max(var_189_12, arg_186_1.talkMaxDuration)

			if var_189_11 <= arg_186_1.time_ and arg_186_1.time_ < var_189_11 + var_189_21 then
				arg_186_1.typewritter.percent = (arg_186_1.time_ - var_189_11) / var_189_21

				arg_186_1.typewritter:SetDirty()
			end

			if arg_186_1.time_ >= var_189_11 + var_189_21 and arg_186_1.time_ < var_189_11 + var_189_21 + arg_189_0 then
				arg_186_1.typewritter.percent = 1

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(true)
			end
		end

		arg_186_1.nodeConfigList_ = {}

		arg_186_1:InitPlayNodeList()
	end,
	Play110152046 = function(arg_190_0, arg_190_1)
		arg_190_1.time_ = 0
		arg_190_1.frameCnt_ = 0
		arg_190_1.state_ = "playing"
		arg_190_1.curTalkId_ = 110152046
		arg_190_1.duration_ = 12.8

		local var_190_0 = {
			ja = 8.3,
			ko = 11.166,
			zh = 10.766,
			en = 12.8
		}
		local var_190_1 = manager.audio:GetLocalizationFlag()

		if var_190_0[var_190_1] ~= nil then
			arg_190_1.duration_ = var_190_0[var_190_1]
		end

		SetActive(arg_190_1.tipsGo_, false)

		function arg_190_1.onSingleLineFinish_()
			arg_190_1.onSingleLineUpdate_ = nil
			arg_190_1.onSingleLineFinish_ = nil
			arg_190_1.state_ = "waiting"
		end

		function arg_190_1.playNext_(arg_192_0)
			if arg_192_0 == 1 then
				arg_190_0:Play110152047(arg_190_1)
			end
		end

		function arg_190_1.onSingleLineUpdate_(arg_193_0)
			local var_193_0 = 0

			if var_193_0 < arg_190_1.time_ and arg_190_1.time_ <= var_193_0 + arg_193_0 then
				arg_190_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_193_1 = arg_190_1.actors_["1111ui_story"]
			local var_193_2 = 0

			if var_193_2 < arg_190_1.time_ and arg_190_1.time_ <= var_193_2 + arg_193_0 and not isNil(var_193_1) and arg_190_1.var_.characterEffect1111ui_story == nil then
				arg_190_1.var_.characterEffect1111ui_story = var_193_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_193_3 = 0.2

			if var_193_2 <= arg_190_1.time_ and arg_190_1.time_ < var_193_2 + var_193_3 and not isNil(var_193_1) then
				local var_193_4 = (arg_190_1.time_ - var_193_2) / var_193_3

				if arg_190_1.var_.characterEffect1111ui_story and not isNil(var_193_1) then
					local var_193_5 = Mathf.Lerp(0, 0.5, var_193_4)

					arg_190_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_190_1.var_.characterEffect1111ui_story.fillRatio = var_193_5
				end
			end

			if arg_190_1.time_ >= var_193_2 + var_193_3 and arg_190_1.time_ < var_193_2 + var_193_3 + arg_193_0 and not isNil(var_193_1) and arg_190_1.var_.characterEffect1111ui_story then
				local var_193_6 = 0.5

				arg_190_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_190_1.var_.characterEffect1111ui_story.fillRatio = var_193_6
			end

			local var_193_7 = arg_190_1.actors_["1011ui_story"]
			local var_193_8 = 0

			if var_193_8 < arg_190_1.time_ and arg_190_1.time_ <= var_193_8 + arg_193_0 and not isNil(var_193_7) and arg_190_1.var_.characterEffect1011ui_story == nil then
				arg_190_1.var_.characterEffect1011ui_story = var_193_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_193_9 = 0.2

			if var_193_8 <= arg_190_1.time_ and arg_190_1.time_ < var_193_8 + var_193_9 and not isNil(var_193_7) then
				local var_193_10 = (arg_190_1.time_ - var_193_8) / var_193_9

				if arg_190_1.var_.characterEffect1011ui_story and not isNil(var_193_7) then
					arg_190_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_190_1.time_ >= var_193_8 + var_193_9 and arg_190_1.time_ < var_193_8 + var_193_9 + arg_193_0 and not isNil(var_193_7) and arg_190_1.var_.characterEffect1011ui_story then
				arg_190_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_193_11 = 0
			local var_193_12 = 1.025

			if var_193_11 < arg_190_1.time_ and arg_190_1.time_ <= var_193_11 + arg_193_0 then
				arg_190_1.talkMaxDuration = 0
				arg_190_1.dialogCg_.alpha = 1

				arg_190_1.dialog_:SetActive(true)
				SetActive(arg_190_1.leftNameGo_, true)

				local var_193_13 = arg_190_1:FormatText(StoryNameCfg[37].name)

				arg_190_1.leftNameTxt_.text = var_193_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_190_1.leftNameTxt_.transform)

				arg_190_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_190_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_190_1:RecordName(arg_190_1.leftNameTxt_.text)
				SetActive(arg_190_1.iconTrs_.gameObject, false)
				arg_190_1.callingController_:SetSelectedState("normal")

				local var_193_14 = arg_190_1:GetWordFromCfg(110152046)
				local var_193_15 = arg_190_1:FormatText(var_193_14.content)

				arg_190_1.text_.text = var_193_15

				LuaForUtil.ClearLinePrefixSymbol(arg_190_1.text_)

				local var_193_16 = 41
				local var_193_17 = utf8.len(var_193_15)
				local var_193_18 = var_193_16 <= 0 and var_193_12 or var_193_12 * (var_193_17 / var_193_16)

				if var_193_18 > 0 and var_193_12 < var_193_18 then
					arg_190_1.talkMaxDuration = var_193_18

					if var_193_18 + var_193_11 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_18 + var_193_11
					end
				end

				arg_190_1.text_.text = var_193_15
				arg_190_1.typewritter.percent = 0

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_110152", "110152046", "story_v_out_110152.awb") ~= 0 then
					local var_193_19 = manager.audio:GetVoiceLength("story_v_out_110152", "110152046", "story_v_out_110152.awb") / 1000

					if var_193_19 + var_193_11 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_19 + var_193_11
					end

					if var_193_14.prefab_name ~= "" and arg_190_1.actors_[var_193_14.prefab_name] ~= nil then
						local var_193_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_190_1.actors_[var_193_14.prefab_name].transform, "story_v_out_110152", "110152046", "story_v_out_110152.awb")

						arg_190_1:RecordAudio("110152046", var_193_20)
						arg_190_1:RecordAudio("110152046", var_193_20)
					else
						arg_190_1:AudioAction("play", "voice", "story_v_out_110152", "110152046", "story_v_out_110152.awb")
					end

					arg_190_1:RecordHistoryTalkVoice("story_v_out_110152", "110152046", "story_v_out_110152.awb")
				end

				arg_190_1:RecordContent(arg_190_1.text_.text)
			end

			local var_193_21 = math.max(var_193_12, arg_190_1.talkMaxDuration)

			if var_193_11 <= arg_190_1.time_ and arg_190_1.time_ < var_193_11 + var_193_21 then
				arg_190_1.typewritter.percent = (arg_190_1.time_ - var_193_11) / var_193_21

				arg_190_1.typewritter:SetDirty()
			end

			if arg_190_1.time_ >= var_193_11 + var_193_21 and arg_190_1.time_ < var_193_11 + var_193_21 + arg_193_0 then
				arg_190_1.typewritter.percent = 1

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(true)
			end
		end

		arg_190_1.nodeConfigList_ = {}

		arg_190_1:InitPlayNodeList()
	end,
	Play110152047 = function(arg_194_0, arg_194_1)
		arg_194_1.time_ = 0
		arg_194_1.frameCnt_ = 0
		arg_194_1.state_ = "playing"
		arg_194_1.curTalkId_ = 110152047
		arg_194_1.duration_ = 4.43

		local var_194_0 = {
			ja = 4.433,
			ko = 3.7,
			zh = 2.733,
			en = 3.166
		}
		local var_194_1 = manager.audio:GetLocalizationFlag()

		if var_194_0[var_194_1] ~= nil then
			arg_194_1.duration_ = var_194_0[var_194_1]
		end

		SetActive(arg_194_1.tipsGo_, false)

		function arg_194_1.onSingleLineFinish_()
			arg_194_1.onSingleLineUpdate_ = nil
			arg_194_1.onSingleLineFinish_ = nil
			arg_194_1.state_ = "waiting"
		end

		function arg_194_1.playNext_(arg_196_0)
			if arg_196_0 == 1 then
				arg_194_0:Play110152048(arg_194_1)
			end
		end

		function arg_194_1.onSingleLineUpdate_(arg_197_0)
			local var_197_0 = 0

			if var_197_0 < arg_194_1.time_ and arg_194_1.time_ <= var_197_0 + arg_197_0 then
				arg_194_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action3_2")
			end

			local var_197_1 = 0

			if var_197_1 < arg_194_1.time_ and arg_194_1.time_ <= var_197_1 + arg_197_0 then
				arg_194_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_197_2 = arg_194_1.actors_["1111ui_story"]
			local var_197_3 = 0

			if var_197_3 < arg_194_1.time_ and arg_194_1.time_ <= var_197_3 + arg_197_0 and not isNil(var_197_2) and arg_194_1.var_.characterEffect1111ui_story == nil then
				arg_194_1.var_.characterEffect1111ui_story = var_197_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_197_4 = 0.2

			if var_197_3 <= arg_194_1.time_ and arg_194_1.time_ < var_197_3 + var_197_4 and not isNil(var_197_2) then
				local var_197_5 = (arg_194_1.time_ - var_197_3) / var_197_4

				if arg_194_1.var_.characterEffect1111ui_story and not isNil(var_197_2) then
					arg_194_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_194_1.time_ >= var_197_3 + var_197_4 and arg_194_1.time_ < var_197_3 + var_197_4 + arg_197_0 and not isNil(var_197_2) and arg_194_1.var_.characterEffect1111ui_story then
				arg_194_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_197_6 = arg_194_1.actors_["1011ui_story"]
			local var_197_7 = 0

			if var_197_7 < arg_194_1.time_ and arg_194_1.time_ <= var_197_7 + arg_197_0 and not isNil(var_197_6) and arg_194_1.var_.characterEffect1011ui_story == nil then
				arg_194_1.var_.characterEffect1011ui_story = var_197_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_197_8 = 0.2

			if var_197_7 <= arg_194_1.time_ and arg_194_1.time_ < var_197_7 + var_197_8 and not isNil(var_197_6) then
				local var_197_9 = (arg_194_1.time_ - var_197_7) / var_197_8

				if arg_194_1.var_.characterEffect1011ui_story and not isNil(var_197_6) then
					local var_197_10 = Mathf.Lerp(0, 0.5, var_197_9)

					arg_194_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_194_1.var_.characterEffect1011ui_story.fillRatio = var_197_10
				end
			end

			if arg_194_1.time_ >= var_197_7 + var_197_8 and arg_194_1.time_ < var_197_7 + var_197_8 + arg_197_0 and not isNil(var_197_6) and arg_194_1.var_.characterEffect1011ui_story then
				local var_197_11 = 0.5

				arg_194_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_194_1.var_.characterEffect1011ui_story.fillRatio = var_197_11
			end

			local var_197_12 = 0
			local var_197_13 = 0.4

			if var_197_12 < arg_194_1.time_ and arg_194_1.time_ <= var_197_12 + arg_197_0 then
				arg_194_1.talkMaxDuration = 0
				arg_194_1.dialogCg_.alpha = 1

				arg_194_1.dialog_:SetActive(true)
				SetActive(arg_194_1.leftNameGo_, true)

				local var_197_14 = arg_194_1:FormatText(StoryNameCfg[67].name)

				arg_194_1.leftNameTxt_.text = var_197_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_194_1.leftNameTxt_.transform)

				arg_194_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_194_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_194_1:RecordName(arg_194_1.leftNameTxt_.text)
				SetActive(arg_194_1.iconTrs_.gameObject, false)
				arg_194_1.callingController_:SetSelectedState("normal")

				local var_197_15 = arg_194_1:GetWordFromCfg(110152047)
				local var_197_16 = arg_194_1:FormatText(var_197_15.content)

				arg_194_1.text_.text = var_197_16

				LuaForUtil.ClearLinePrefixSymbol(arg_194_1.text_)

				local var_197_17 = 16
				local var_197_18 = utf8.len(var_197_16)
				local var_197_19 = var_197_17 <= 0 and var_197_13 or var_197_13 * (var_197_18 / var_197_17)

				if var_197_19 > 0 and var_197_13 < var_197_19 then
					arg_194_1.talkMaxDuration = var_197_19

					if var_197_19 + var_197_12 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_19 + var_197_12
					end
				end

				arg_194_1.text_.text = var_197_16
				arg_194_1.typewritter.percent = 0

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_110152", "110152047", "story_v_out_110152.awb") ~= 0 then
					local var_197_20 = manager.audio:GetVoiceLength("story_v_out_110152", "110152047", "story_v_out_110152.awb") / 1000

					if var_197_20 + var_197_12 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_20 + var_197_12
					end

					if var_197_15.prefab_name ~= "" and arg_194_1.actors_[var_197_15.prefab_name] ~= nil then
						local var_197_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_194_1.actors_[var_197_15.prefab_name].transform, "story_v_out_110152", "110152047", "story_v_out_110152.awb")

						arg_194_1:RecordAudio("110152047", var_197_21)
						arg_194_1:RecordAudio("110152047", var_197_21)
					else
						arg_194_1:AudioAction("play", "voice", "story_v_out_110152", "110152047", "story_v_out_110152.awb")
					end

					arg_194_1:RecordHistoryTalkVoice("story_v_out_110152", "110152047", "story_v_out_110152.awb")
				end

				arg_194_1:RecordContent(arg_194_1.text_.text)
			end

			local var_197_22 = math.max(var_197_13, arg_194_1.talkMaxDuration)

			if var_197_12 <= arg_194_1.time_ and arg_194_1.time_ < var_197_12 + var_197_22 then
				arg_194_1.typewritter.percent = (arg_194_1.time_ - var_197_12) / var_197_22

				arg_194_1.typewritter:SetDirty()
			end

			if arg_194_1.time_ >= var_197_12 + var_197_22 and arg_194_1.time_ < var_197_12 + var_197_22 + arg_197_0 then
				arg_194_1.typewritter.percent = 1

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(true)
			end
		end

		arg_194_1.nodeConfigList_ = {}

		arg_194_1:InitPlayNodeList()
	end,
	Play110152048 = function(arg_198_0, arg_198_1)
		arg_198_1.time_ = 0
		arg_198_1.frameCnt_ = 0
		arg_198_1.state_ = "playing"
		arg_198_1.curTalkId_ = 110152048
		arg_198_1.duration_ = 5.3

		local var_198_0 = {
			ja = 5.3,
			ko = 4.866,
			zh = 4.366,
			en = 3.7
		}
		local var_198_1 = manager.audio:GetLocalizationFlag()

		if var_198_0[var_198_1] ~= nil then
			arg_198_1.duration_ = var_198_0[var_198_1]
		end

		SetActive(arg_198_1.tipsGo_, false)

		function arg_198_1.onSingleLineFinish_()
			arg_198_1.onSingleLineUpdate_ = nil
			arg_198_1.onSingleLineFinish_ = nil
			arg_198_1.state_ = "waiting"
		end

		function arg_198_1.playNext_(arg_200_0)
			if arg_200_0 == 1 then
				arg_198_0:Play110152049(arg_198_1)
			end
		end

		function arg_198_1.onSingleLineUpdate_(arg_201_0)
			local var_201_0 = 0

			if var_201_0 < arg_198_1.time_ and arg_198_1.time_ <= var_201_0 + arg_201_0 then
				arg_198_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_201_1 = 0
			local var_201_2 = 0.5

			if var_201_1 < arg_198_1.time_ and arg_198_1.time_ <= var_201_1 + arg_201_0 then
				arg_198_1.talkMaxDuration = 0
				arg_198_1.dialogCg_.alpha = 1

				arg_198_1.dialog_:SetActive(true)
				SetActive(arg_198_1.leftNameGo_, true)

				local var_201_3 = arg_198_1:FormatText(StoryNameCfg[67].name)

				arg_198_1.leftNameTxt_.text = var_201_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_198_1.leftNameTxt_.transform)

				arg_198_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_198_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_198_1:RecordName(arg_198_1.leftNameTxt_.text)
				SetActive(arg_198_1.iconTrs_.gameObject, false)
				arg_198_1.callingController_:SetSelectedState("normal")

				local var_201_4 = arg_198_1:GetWordFromCfg(110152048)
				local var_201_5 = arg_198_1:FormatText(var_201_4.content)

				arg_198_1.text_.text = var_201_5

				LuaForUtil.ClearLinePrefixSymbol(arg_198_1.text_)

				local var_201_6 = 20
				local var_201_7 = utf8.len(var_201_5)
				local var_201_8 = var_201_6 <= 0 and var_201_2 or var_201_2 * (var_201_7 / var_201_6)

				if var_201_8 > 0 and var_201_2 < var_201_8 then
					arg_198_1.talkMaxDuration = var_201_8

					if var_201_8 + var_201_1 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_8 + var_201_1
					end
				end

				arg_198_1.text_.text = var_201_5
				arg_198_1.typewritter.percent = 0

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_110152", "110152048", "story_v_out_110152.awb") ~= 0 then
					local var_201_9 = manager.audio:GetVoiceLength("story_v_out_110152", "110152048", "story_v_out_110152.awb") / 1000

					if var_201_9 + var_201_1 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_9 + var_201_1
					end

					if var_201_4.prefab_name ~= "" and arg_198_1.actors_[var_201_4.prefab_name] ~= nil then
						local var_201_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_198_1.actors_[var_201_4.prefab_name].transform, "story_v_out_110152", "110152048", "story_v_out_110152.awb")

						arg_198_1:RecordAudio("110152048", var_201_10)
						arg_198_1:RecordAudio("110152048", var_201_10)
					else
						arg_198_1:AudioAction("play", "voice", "story_v_out_110152", "110152048", "story_v_out_110152.awb")
					end

					arg_198_1:RecordHistoryTalkVoice("story_v_out_110152", "110152048", "story_v_out_110152.awb")
				end

				arg_198_1:RecordContent(arg_198_1.text_.text)
			end

			local var_201_11 = math.max(var_201_2, arg_198_1.talkMaxDuration)

			if var_201_1 <= arg_198_1.time_ and arg_198_1.time_ < var_201_1 + var_201_11 then
				arg_198_1.typewritter.percent = (arg_198_1.time_ - var_201_1) / var_201_11

				arg_198_1.typewritter:SetDirty()
			end

			if arg_198_1.time_ >= var_201_1 + var_201_11 and arg_198_1.time_ < var_201_1 + var_201_11 + arg_201_0 then
				arg_198_1.typewritter.percent = 1

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(true)
			end
		end

		arg_198_1.nodeConfigList_ = {}

		arg_198_1:InitPlayNodeList()
	end,
	Play110152049 = function(arg_202_0, arg_202_1)
		arg_202_1.time_ = 0
		arg_202_1.frameCnt_ = 0
		arg_202_1.state_ = "playing"
		arg_202_1.curTalkId_ = 110152049
		arg_202_1.duration_ = 2

		SetActive(arg_202_1.tipsGo_, false)

		function arg_202_1.onSingleLineFinish_()
			arg_202_1.onSingleLineUpdate_ = nil
			arg_202_1.onSingleLineFinish_ = nil
			arg_202_1.state_ = "waiting"
		end

		function arg_202_1.playNext_(arg_204_0)
			if arg_204_0 == 1 then
				arg_202_0:Play110152050(arg_202_1)
			end
		end

		function arg_202_1.onSingleLineUpdate_(arg_205_0)
			local var_205_0 = 0

			if var_205_0 < arg_202_1.time_ and arg_202_1.time_ <= var_205_0 + arg_205_0 then
				arg_202_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_205_1 = 0

			if var_205_1 < arg_202_1.time_ and arg_202_1.time_ <= var_205_1 + arg_205_0 then
				arg_202_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011actionlink/1011action426")
			end

			local var_205_2 = arg_202_1.actors_["1011ui_story"]
			local var_205_3 = 0

			if var_205_3 < arg_202_1.time_ and arg_202_1.time_ <= var_205_3 + arg_205_0 and not isNil(var_205_2) and arg_202_1.var_.characterEffect1011ui_story == nil then
				arg_202_1.var_.characterEffect1011ui_story = var_205_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_205_4 = 0.2

			if var_205_3 <= arg_202_1.time_ and arg_202_1.time_ < var_205_3 + var_205_4 and not isNil(var_205_2) then
				local var_205_5 = (arg_202_1.time_ - var_205_3) / var_205_4

				if arg_202_1.var_.characterEffect1011ui_story and not isNil(var_205_2) then
					arg_202_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_202_1.time_ >= var_205_3 + var_205_4 and arg_202_1.time_ < var_205_3 + var_205_4 + arg_205_0 and not isNil(var_205_2) and arg_202_1.var_.characterEffect1011ui_story then
				arg_202_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_205_6 = arg_202_1.actors_["1111ui_story"]
			local var_205_7 = 0

			if var_205_7 < arg_202_1.time_ and arg_202_1.time_ <= var_205_7 + arg_205_0 and not isNil(var_205_6) and arg_202_1.var_.characterEffect1111ui_story == nil then
				arg_202_1.var_.characterEffect1111ui_story = var_205_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_205_8 = 0.2

			if var_205_7 <= arg_202_1.time_ and arg_202_1.time_ < var_205_7 + var_205_8 and not isNil(var_205_6) then
				local var_205_9 = (arg_202_1.time_ - var_205_7) / var_205_8

				if arg_202_1.var_.characterEffect1111ui_story and not isNil(var_205_6) then
					local var_205_10 = Mathf.Lerp(0, 0.5, var_205_9)

					arg_202_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_202_1.var_.characterEffect1111ui_story.fillRatio = var_205_10
				end
			end

			if arg_202_1.time_ >= var_205_7 + var_205_8 and arg_202_1.time_ < var_205_7 + var_205_8 + arg_205_0 and not isNil(var_205_6) and arg_202_1.var_.characterEffect1111ui_story then
				local var_205_11 = 0.5

				arg_202_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_202_1.var_.characterEffect1111ui_story.fillRatio = var_205_11
			end

			local var_205_12 = 0
			local var_205_13 = 0.075

			if var_205_12 < arg_202_1.time_ and arg_202_1.time_ <= var_205_12 + arg_205_0 then
				arg_202_1.talkMaxDuration = 0
				arg_202_1.dialogCg_.alpha = 1

				arg_202_1.dialog_:SetActive(true)
				SetActive(arg_202_1.leftNameGo_, true)

				local var_205_14 = arg_202_1:FormatText(StoryNameCfg[37].name)

				arg_202_1.leftNameTxt_.text = var_205_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_202_1.leftNameTxt_.transform)

				arg_202_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_202_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_202_1:RecordName(arg_202_1.leftNameTxt_.text)
				SetActive(arg_202_1.iconTrs_.gameObject, false)
				arg_202_1.callingController_:SetSelectedState("normal")

				local var_205_15 = arg_202_1:GetWordFromCfg(110152049)
				local var_205_16 = arg_202_1:FormatText(var_205_15.content)

				arg_202_1.text_.text = var_205_16

				LuaForUtil.ClearLinePrefixSymbol(arg_202_1.text_)

				local var_205_17 = 3
				local var_205_18 = utf8.len(var_205_16)
				local var_205_19 = var_205_17 <= 0 and var_205_13 or var_205_13 * (var_205_18 / var_205_17)

				if var_205_19 > 0 and var_205_13 < var_205_19 then
					arg_202_1.talkMaxDuration = var_205_19

					if var_205_19 + var_205_12 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_19 + var_205_12
					end
				end

				arg_202_1.text_.text = var_205_16
				arg_202_1.typewritter.percent = 0

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_110152", "110152049", "story_v_out_110152.awb") ~= 0 then
					local var_205_20 = manager.audio:GetVoiceLength("story_v_out_110152", "110152049", "story_v_out_110152.awb") / 1000

					if var_205_20 + var_205_12 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_20 + var_205_12
					end

					if var_205_15.prefab_name ~= "" and arg_202_1.actors_[var_205_15.prefab_name] ~= nil then
						local var_205_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_202_1.actors_[var_205_15.prefab_name].transform, "story_v_out_110152", "110152049", "story_v_out_110152.awb")

						arg_202_1:RecordAudio("110152049", var_205_21)
						arg_202_1:RecordAudio("110152049", var_205_21)
					else
						arg_202_1:AudioAction("play", "voice", "story_v_out_110152", "110152049", "story_v_out_110152.awb")
					end

					arg_202_1:RecordHistoryTalkVoice("story_v_out_110152", "110152049", "story_v_out_110152.awb")
				end

				arg_202_1:RecordContent(arg_202_1.text_.text)
			end

			local var_205_22 = math.max(var_205_13, arg_202_1.talkMaxDuration)

			if var_205_12 <= arg_202_1.time_ and arg_202_1.time_ < var_205_12 + var_205_22 then
				arg_202_1.typewritter.percent = (arg_202_1.time_ - var_205_12) / var_205_22

				arg_202_1.typewritter:SetDirty()
			end

			if arg_202_1.time_ >= var_205_12 + var_205_22 and arg_202_1.time_ < var_205_12 + var_205_22 + arg_205_0 then
				arg_202_1.typewritter.percent = 1

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(true)
			end
		end

		arg_202_1.nodeConfigList_ = {}

		arg_202_1:InitPlayNodeList()
	end,
	Play110152050 = function(arg_206_0, arg_206_1)
		arg_206_1.time_ = 0
		arg_206_1.frameCnt_ = 0
		arg_206_1.state_ = "playing"
		arg_206_1.curTalkId_ = 110152050
		arg_206_1.duration_ = 11.83

		local var_206_0 = {
			ja = 7.6,
			ko = 11.833,
			zh = 10,
			en = 7.433
		}
		local var_206_1 = manager.audio:GetLocalizationFlag()

		if var_206_0[var_206_1] ~= nil then
			arg_206_1.duration_ = var_206_0[var_206_1]
		end

		SetActive(arg_206_1.tipsGo_, false)

		function arg_206_1.onSingleLineFinish_()
			arg_206_1.onSingleLineUpdate_ = nil
			arg_206_1.onSingleLineFinish_ = nil
			arg_206_1.state_ = "waiting"
		end

		function arg_206_1.playNext_(arg_208_0)
			if arg_208_0 == 1 then
				arg_206_0:Play110152051(arg_206_1)
			end
		end

		function arg_206_1.onSingleLineUpdate_(arg_209_0)
			local var_209_0 = 0

			if var_209_0 < arg_206_1.time_ and arg_206_1.time_ <= var_209_0 + arg_209_0 then
				arg_206_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action4_1")
			end

			local var_209_1 = 0

			if var_209_1 < arg_206_1.time_ and arg_206_1.time_ <= var_209_1 + arg_209_0 then
				arg_206_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_209_2 = arg_206_1.actors_["1011ui_story"]
			local var_209_3 = 0

			if var_209_3 < arg_206_1.time_ and arg_206_1.time_ <= var_209_3 + arg_209_0 and not isNil(var_209_2) and arg_206_1.var_.characterEffect1011ui_story == nil then
				arg_206_1.var_.characterEffect1011ui_story = var_209_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_209_4 = 0.2

			if var_209_3 <= arg_206_1.time_ and arg_206_1.time_ < var_209_3 + var_209_4 and not isNil(var_209_2) then
				local var_209_5 = (arg_206_1.time_ - var_209_3) / var_209_4

				if arg_206_1.var_.characterEffect1011ui_story and not isNil(var_209_2) then
					local var_209_6 = Mathf.Lerp(0, 0.5, var_209_5)

					arg_206_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_206_1.var_.characterEffect1011ui_story.fillRatio = var_209_6
				end
			end

			if arg_206_1.time_ >= var_209_3 + var_209_4 and arg_206_1.time_ < var_209_3 + var_209_4 + arg_209_0 and not isNil(var_209_2) and arg_206_1.var_.characterEffect1011ui_story then
				local var_209_7 = 0.5

				arg_206_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_206_1.var_.characterEffect1011ui_story.fillRatio = var_209_7
			end

			local var_209_8 = arg_206_1.actors_["1111ui_story"]
			local var_209_9 = 0

			if var_209_9 < arg_206_1.time_ and arg_206_1.time_ <= var_209_9 + arg_209_0 and not isNil(var_209_8) and arg_206_1.var_.characterEffect1111ui_story == nil then
				arg_206_1.var_.characterEffect1111ui_story = var_209_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_209_10 = 0.2

			if var_209_9 <= arg_206_1.time_ and arg_206_1.time_ < var_209_9 + var_209_10 and not isNil(var_209_8) then
				local var_209_11 = (arg_206_1.time_ - var_209_9) / var_209_10

				if arg_206_1.var_.characterEffect1111ui_story and not isNil(var_209_8) then
					arg_206_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_206_1.time_ >= var_209_9 + var_209_10 and arg_206_1.time_ < var_209_9 + var_209_10 + arg_209_0 and not isNil(var_209_8) and arg_206_1.var_.characterEffect1111ui_story then
				arg_206_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_209_12 = 0
			local var_209_13 = 1.075

			if var_209_12 < arg_206_1.time_ and arg_206_1.time_ <= var_209_12 + arg_209_0 then
				arg_206_1.talkMaxDuration = 0
				arg_206_1.dialogCg_.alpha = 1

				arg_206_1.dialog_:SetActive(true)
				SetActive(arg_206_1.leftNameGo_, true)

				local var_209_14 = arg_206_1:FormatText(StoryNameCfg[67].name)

				arg_206_1.leftNameTxt_.text = var_209_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_206_1.leftNameTxt_.transform)

				arg_206_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_206_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_206_1:RecordName(arg_206_1.leftNameTxt_.text)
				SetActive(arg_206_1.iconTrs_.gameObject, false)
				arg_206_1.callingController_:SetSelectedState("normal")

				local var_209_15 = arg_206_1:GetWordFromCfg(110152050)
				local var_209_16 = arg_206_1:FormatText(var_209_15.content)

				arg_206_1.text_.text = var_209_16

				LuaForUtil.ClearLinePrefixSymbol(arg_206_1.text_)

				local var_209_17 = 41
				local var_209_18 = utf8.len(var_209_16)
				local var_209_19 = var_209_17 <= 0 and var_209_13 or var_209_13 * (var_209_18 / var_209_17)

				if var_209_19 > 0 and var_209_13 < var_209_19 then
					arg_206_1.talkMaxDuration = var_209_19

					if var_209_19 + var_209_12 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_19 + var_209_12
					end
				end

				arg_206_1.text_.text = var_209_16
				arg_206_1.typewritter.percent = 0

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_110152", "110152050", "story_v_out_110152.awb") ~= 0 then
					local var_209_20 = manager.audio:GetVoiceLength("story_v_out_110152", "110152050", "story_v_out_110152.awb") / 1000

					if var_209_20 + var_209_12 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_20 + var_209_12
					end

					if var_209_15.prefab_name ~= "" and arg_206_1.actors_[var_209_15.prefab_name] ~= nil then
						local var_209_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_206_1.actors_[var_209_15.prefab_name].transform, "story_v_out_110152", "110152050", "story_v_out_110152.awb")

						arg_206_1:RecordAudio("110152050", var_209_21)
						arg_206_1:RecordAudio("110152050", var_209_21)
					else
						arg_206_1:AudioAction("play", "voice", "story_v_out_110152", "110152050", "story_v_out_110152.awb")
					end

					arg_206_1:RecordHistoryTalkVoice("story_v_out_110152", "110152050", "story_v_out_110152.awb")
				end

				arg_206_1:RecordContent(arg_206_1.text_.text)
			end

			local var_209_22 = math.max(var_209_13, arg_206_1.talkMaxDuration)

			if var_209_12 <= arg_206_1.time_ and arg_206_1.time_ < var_209_12 + var_209_22 then
				arg_206_1.typewritter.percent = (arg_206_1.time_ - var_209_12) / var_209_22

				arg_206_1.typewritter:SetDirty()
			end

			if arg_206_1.time_ >= var_209_12 + var_209_22 and arg_206_1.time_ < var_209_12 + var_209_22 + arg_209_0 then
				arg_206_1.typewritter.percent = 1

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(true)
			end
		end

		arg_206_1.nodeConfigList_ = {}

		arg_206_1:InitPlayNodeList()
	end,
	Play110152051 = function(arg_210_0, arg_210_1)
		arg_210_1.time_ = 0
		arg_210_1.frameCnt_ = 0
		arg_210_1.state_ = "playing"
		arg_210_1.curTalkId_ = 110152051
		arg_210_1.duration_ = 2

		SetActive(arg_210_1.tipsGo_, false)

		function arg_210_1.onSingleLineFinish_()
			arg_210_1.onSingleLineUpdate_ = nil
			arg_210_1.onSingleLineFinish_ = nil
			arg_210_1.state_ = "waiting"
		end

		function arg_210_1.playNext_(arg_212_0)
			if arg_212_0 == 1 then
				arg_210_0:Play110152052(arg_210_1)
			end
		end

		function arg_210_1.onSingleLineUpdate_(arg_213_0)
			local var_213_0 = 0

			if var_213_0 < arg_210_1.time_ and arg_210_1.time_ <= var_213_0 + arg_213_0 then
				arg_210_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011actionlink/1011action463")
			end

			local var_213_1 = 0

			if var_213_1 < arg_210_1.time_ and arg_210_1.time_ <= var_213_1 + arg_213_0 then
				arg_210_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_213_2 = arg_210_1.actors_["1011ui_story"]
			local var_213_3 = 0

			if var_213_3 < arg_210_1.time_ and arg_210_1.time_ <= var_213_3 + arg_213_0 and not isNil(var_213_2) and arg_210_1.var_.characterEffect1011ui_story == nil then
				arg_210_1.var_.characterEffect1011ui_story = var_213_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_213_4 = 0.2

			if var_213_3 <= arg_210_1.time_ and arg_210_1.time_ < var_213_3 + var_213_4 and not isNil(var_213_2) then
				local var_213_5 = (arg_210_1.time_ - var_213_3) / var_213_4

				if arg_210_1.var_.characterEffect1011ui_story and not isNil(var_213_2) then
					arg_210_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_210_1.time_ >= var_213_3 + var_213_4 and arg_210_1.time_ < var_213_3 + var_213_4 + arg_213_0 and not isNil(var_213_2) and arg_210_1.var_.characterEffect1011ui_story then
				arg_210_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_213_6 = arg_210_1.actors_["1111ui_story"]
			local var_213_7 = 0

			if var_213_7 < arg_210_1.time_ and arg_210_1.time_ <= var_213_7 + arg_213_0 and not isNil(var_213_6) and arg_210_1.var_.characterEffect1111ui_story == nil then
				arg_210_1.var_.characterEffect1111ui_story = var_213_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_213_8 = 0.2

			if var_213_7 <= arg_210_1.time_ and arg_210_1.time_ < var_213_7 + var_213_8 and not isNil(var_213_6) then
				local var_213_9 = (arg_210_1.time_ - var_213_7) / var_213_8

				if arg_210_1.var_.characterEffect1111ui_story and not isNil(var_213_6) then
					local var_213_10 = Mathf.Lerp(0, 0.5, var_213_9)

					arg_210_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_210_1.var_.characterEffect1111ui_story.fillRatio = var_213_10
				end
			end

			if arg_210_1.time_ >= var_213_7 + var_213_8 and arg_210_1.time_ < var_213_7 + var_213_8 + arg_213_0 and not isNil(var_213_6) and arg_210_1.var_.characterEffect1111ui_story then
				local var_213_11 = 0.5

				arg_210_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_210_1.var_.characterEffect1111ui_story.fillRatio = var_213_11
			end

			local var_213_12 = 0
			local var_213_13 = 0.05

			if var_213_12 < arg_210_1.time_ and arg_210_1.time_ <= var_213_12 + arg_213_0 then
				arg_210_1.talkMaxDuration = 0
				arg_210_1.dialogCg_.alpha = 1

				arg_210_1.dialog_:SetActive(true)
				SetActive(arg_210_1.leftNameGo_, true)

				local var_213_14 = arg_210_1:FormatText(StoryNameCfg[37].name)

				arg_210_1.leftNameTxt_.text = var_213_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_210_1.leftNameTxt_.transform)

				arg_210_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_210_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_210_1:RecordName(arg_210_1.leftNameTxt_.text)
				SetActive(arg_210_1.iconTrs_.gameObject, false)
				arg_210_1.callingController_:SetSelectedState("normal")

				local var_213_15 = arg_210_1:GetWordFromCfg(110152051)
				local var_213_16 = arg_210_1:FormatText(var_213_15.content)

				arg_210_1.text_.text = var_213_16

				LuaForUtil.ClearLinePrefixSymbol(arg_210_1.text_)

				local var_213_17 = 2
				local var_213_18 = utf8.len(var_213_16)
				local var_213_19 = var_213_17 <= 0 and var_213_13 or var_213_13 * (var_213_18 / var_213_17)

				if var_213_19 > 0 and var_213_13 < var_213_19 then
					arg_210_1.talkMaxDuration = var_213_19

					if var_213_19 + var_213_12 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_19 + var_213_12
					end
				end

				arg_210_1.text_.text = var_213_16
				arg_210_1.typewritter.percent = 0

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_110152", "110152051", "story_v_out_110152.awb") ~= 0 then
					local var_213_20 = manager.audio:GetVoiceLength("story_v_out_110152", "110152051", "story_v_out_110152.awb") / 1000

					if var_213_20 + var_213_12 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_20 + var_213_12
					end

					if var_213_15.prefab_name ~= "" and arg_210_1.actors_[var_213_15.prefab_name] ~= nil then
						local var_213_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_210_1.actors_[var_213_15.prefab_name].transform, "story_v_out_110152", "110152051", "story_v_out_110152.awb")

						arg_210_1:RecordAudio("110152051", var_213_21)
						arg_210_1:RecordAudio("110152051", var_213_21)
					else
						arg_210_1:AudioAction("play", "voice", "story_v_out_110152", "110152051", "story_v_out_110152.awb")
					end

					arg_210_1:RecordHistoryTalkVoice("story_v_out_110152", "110152051", "story_v_out_110152.awb")
				end

				arg_210_1:RecordContent(arg_210_1.text_.text)
			end

			local var_213_22 = math.max(var_213_13, arg_210_1.talkMaxDuration)

			if var_213_12 <= arg_210_1.time_ and arg_210_1.time_ < var_213_12 + var_213_22 then
				arg_210_1.typewritter.percent = (arg_210_1.time_ - var_213_12) / var_213_22

				arg_210_1.typewritter:SetDirty()
			end

			if arg_210_1.time_ >= var_213_12 + var_213_22 and arg_210_1.time_ < var_213_12 + var_213_22 + arg_213_0 then
				arg_210_1.typewritter.percent = 1

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(true)
			end
		end

		arg_210_1.nodeConfigList_ = {}

		arg_210_1:InitPlayNodeList()
	end,
	Play110152052 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 110152052
		arg_214_1.duration_ = 9.53

		local var_214_0 = {
			ja = 6.2,
			ko = 9.533,
			zh = 6.933,
			en = 6.933
		}
		local var_214_1 = manager.audio:GetLocalizationFlag()

		if var_214_0[var_214_1] ~= nil then
			arg_214_1.duration_ = var_214_0[var_214_1]
		end

		SetActive(arg_214_1.tipsGo_, false)

		function arg_214_1.onSingleLineFinish_()
			arg_214_1.onSingleLineUpdate_ = nil
			arg_214_1.onSingleLineFinish_ = nil
			arg_214_1.state_ = "waiting"
		end

		function arg_214_1.playNext_(arg_216_0)
			if arg_216_0 == 1 then
				arg_214_0:Play110152053(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			local var_217_0 = 0

			if var_217_0 < arg_214_1.time_ and arg_214_1.time_ <= var_217_0 + arg_217_0 then
				arg_214_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_217_1 = arg_214_1.actors_["1011ui_story"]
			local var_217_2 = 0

			if var_217_2 < arg_214_1.time_ and arg_214_1.time_ <= var_217_2 + arg_217_0 and not isNil(var_217_1) and arg_214_1.var_.characterEffect1011ui_story == nil then
				arg_214_1.var_.characterEffect1011ui_story = var_217_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_217_3 = 0.2

			if var_217_2 <= arg_214_1.time_ and arg_214_1.time_ < var_217_2 + var_217_3 and not isNil(var_217_1) then
				local var_217_4 = (arg_214_1.time_ - var_217_2) / var_217_3

				if arg_214_1.var_.characterEffect1011ui_story and not isNil(var_217_1) then
					local var_217_5 = Mathf.Lerp(0, 0.5, var_217_4)

					arg_214_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_214_1.var_.characterEffect1011ui_story.fillRatio = var_217_5
				end
			end

			if arg_214_1.time_ >= var_217_2 + var_217_3 and arg_214_1.time_ < var_217_2 + var_217_3 + arg_217_0 and not isNil(var_217_1) and arg_214_1.var_.characterEffect1011ui_story then
				local var_217_6 = 0.5

				arg_214_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_214_1.var_.characterEffect1011ui_story.fillRatio = var_217_6
			end

			local var_217_7 = arg_214_1.actors_["1111ui_story"]
			local var_217_8 = 0

			if var_217_8 < arg_214_1.time_ and arg_214_1.time_ <= var_217_8 + arg_217_0 and not isNil(var_217_7) and arg_214_1.var_.characterEffect1111ui_story == nil then
				arg_214_1.var_.characterEffect1111ui_story = var_217_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_217_9 = 0.2

			if var_217_8 <= arg_214_1.time_ and arg_214_1.time_ < var_217_8 + var_217_9 and not isNil(var_217_7) then
				local var_217_10 = (arg_214_1.time_ - var_217_8) / var_217_9

				if arg_214_1.var_.characterEffect1111ui_story and not isNil(var_217_7) then
					arg_214_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_214_1.time_ >= var_217_8 + var_217_9 and arg_214_1.time_ < var_217_8 + var_217_9 + arg_217_0 and not isNil(var_217_7) and arg_214_1.var_.characterEffect1111ui_story then
				arg_214_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_217_11 = 0
			local var_217_12 = 0.925

			if var_217_11 < arg_214_1.time_ and arg_214_1.time_ <= var_217_11 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0
				arg_214_1.dialogCg_.alpha = 1

				arg_214_1.dialog_:SetActive(true)
				SetActive(arg_214_1.leftNameGo_, true)

				local var_217_13 = arg_214_1:FormatText(StoryNameCfg[67].name)

				arg_214_1.leftNameTxt_.text = var_217_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_214_1.leftNameTxt_.transform)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1.leftNameTxt_.text)
				SetActive(arg_214_1.iconTrs_.gameObject, false)
				arg_214_1.callingController_:SetSelectedState("normal")

				local var_217_14 = arg_214_1:GetWordFromCfg(110152052)
				local var_217_15 = arg_214_1:FormatText(var_217_14.content)

				arg_214_1.text_.text = var_217_15

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_16 = 37
				local var_217_17 = utf8.len(var_217_15)
				local var_217_18 = var_217_16 <= 0 and var_217_12 or var_217_12 * (var_217_17 / var_217_16)

				if var_217_18 > 0 and var_217_12 < var_217_18 then
					arg_214_1.talkMaxDuration = var_217_18

					if var_217_18 + var_217_11 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_18 + var_217_11
					end
				end

				arg_214_1.text_.text = var_217_15
				arg_214_1.typewritter.percent = 0

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_110152", "110152052", "story_v_out_110152.awb") ~= 0 then
					local var_217_19 = manager.audio:GetVoiceLength("story_v_out_110152", "110152052", "story_v_out_110152.awb") / 1000

					if var_217_19 + var_217_11 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_19 + var_217_11
					end

					if var_217_14.prefab_name ~= "" and arg_214_1.actors_[var_217_14.prefab_name] ~= nil then
						local var_217_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_214_1.actors_[var_217_14.prefab_name].transform, "story_v_out_110152", "110152052", "story_v_out_110152.awb")

						arg_214_1:RecordAudio("110152052", var_217_20)
						arg_214_1:RecordAudio("110152052", var_217_20)
					else
						arg_214_1:AudioAction("play", "voice", "story_v_out_110152", "110152052", "story_v_out_110152.awb")
					end

					arg_214_1:RecordHistoryTalkVoice("story_v_out_110152", "110152052", "story_v_out_110152.awb")
				end

				arg_214_1:RecordContent(arg_214_1.text_.text)
			end

			local var_217_21 = math.max(var_217_12, arg_214_1.talkMaxDuration)

			if var_217_11 <= arg_214_1.time_ and arg_214_1.time_ < var_217_11 + var_217_21 then
				arg_214_1.typewritter.percent = (arg_214_1.time_ - var_217_11) / var_217_21

				arg_214_1.typewritter:SetDirty()
			end

			if arg_214_1.time_ >= var_217_11 + var_217_21 and arg_214_1.time_ < var_217_11 + var_217_21 + arg_217_0 then
				arg_214_1.typewritter.percent = 1

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(true)
			end
		end

		arg_214_1.nodeConfigList_ = {}

		arg_214_1:InitPlayNodeList()
	end,
	Play110152053 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 110152053
		arg_218_1.duration_ = 8.8

		local var_218_0 = {
			ja = 8.8,
			ko = 6.4,
			zh = 8.333,
			en = 7.866
		}
		local var_218_1 = manager.audio:GetLocalizationFlag()

		if var_218_0[var_218_1] ~= nil then
			arg_218_1.duration_ = var_218_0[var_218_1]
		end

		SetActive(arg_218_1.tipsGo_, false)

		function arg_218_1.onSingleLineFinish_()
			arg_218_1.onSingleLineUpdate_ = nil
			arg_218_1.onSingleLineFinish_ = nil
			arg_218_1.state_ = "waiting"
		end

		function arg_218_1.playNext_(arg_220_0)
			if arg_220_0 == 1 then
				arg_218_0:Play110152054(arg_218_1)
			end
		end

		function arg_218_1.onSingleLineUpdate_(arg_221_0)
			local var_221_0 = 0

			if var_221_0 < arg_218_1.time_ and arg_218_1.time_ <= var_221_0 + arg_221_0 then
				arg_218_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011actionlink/1011action432")
			end

			local var_221_1 = 0

			if var_221_1 < arg_218_1.time_ and arg_218_1.time_ <= var_221_1 + arg_221_0 then
				arg_218_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_221_2 = arg_218_1.actors_["1111ui_story"]
			local var_221_3 = 0

			if var_221_3 < arg_218_1.time_ and arg_218_1.time_ <= var_221_3 + arg_221_0 and not isNil(var_221_2) and arg_218_1.var_.characterEffect1111ui_story == nil then
				arg_218_1.var_.characterEffect1111ui_story = var_221_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_221_4 = 0.2

			if var_221_3 <= arg_218_1.time_ and arg_218_1.time_ < var_221_3 + var_221_4 and not isNil(var_221_2) then
				local var_221_5 = (arg_218_1.time_ - var_221_3) / var_221_4

				if arg_218_1.var_.characterEffect1111ui_story and not isNil(var_221_2) then
					local var_221_6 = Mathf.Lerp(0, 0.5, var_221_5)

					arg_218_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_218_1.var_.characterEffect1111ui_story.fillRatio = var_221_6
				end
			end

			if arg_218_1.time_ >= var_221_3 + var_221_4 and arg_218_1.time_ < var_221_3 + var_221_4 + arg_221_0 and not isNil(var_221_2) and arg_218_1.var_.characterEffect1111ui_story then
				local var_221_7 = 0.5

				arg_218_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_218_1.var_.characterEffect1111ui_story.fillRatio = var_221_7
			end

			local var_221_8 = arg_218_1.actors_["1011ui_story"]
			local var_221_9 = 0

			if var_221_9 < arg_218_1.time_ and arg_218_1.time_ <= var_221_9 + arg_221_0 and not isNil(var_221_8) and arg_218_1.var_.characterEffect1011ui_story == nil then
				arg_218_1.var_.characterEffect1011ui_story = var_221_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_221_10 = 0.2

			if var_221_9 <= arg_218_1.time_ and arg_218_1.time_ < var_221_9 + var_221_10 and not isNil(var_221_8) then
				local var_221_11 = (arg_218_1.time_ - var_221_9) / var_221_10

				if arg_218_1.var_.characterEffect1011ui_story and not isNil(var_221_8) then
					arg_218_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_218_1.time_ >= var_221_9 + var_221_10 and arg_218_1.time_ < var_221_9 + var_221_10 + arg_221_0 and not isNil(var_221_8) and arg_218_1.var_.characterEffect1011ui_story then
				arg_218_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_221_12 = 0
			local var_221_13 = 0.6

			if var_221_12 < arg_218_1.time_ and arg_218_1.time_ <= var_221_12 + arg_221_0 then
				arg_218_1.talkMaxDuration = 0
				arg_218_1.dialogCg_.alpha = 1

				arg_218_1.dialog_:SetActive(true)
				SetActive(arg_218_1.leftNameGo_, true)

				local var_221_14 = arg_218_1:FormatText(StoryNameCfg[37].name)

				arg_218_1.leftNameTxt_.text = var_221_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_218_1.leftNameTxt_.transform)

				arg_218_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_218_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_218_1:RecordName(arg_218_1.leftNameTxt_.text)
				SetActive(arg_218_1.iconTrs_.gameObject, false)
				arg_218_1.callingController_:SetSelectedState("normal")

				local var_221_15 = arg_218_1:GetWordFromCfg(110152053)
				local var_221_16 = arg_218_1:FormatText(var_221_15.content)

				arg_218_1.text_.text = var_221_16

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_17 = 24
				local var_221_18 = utf8.len(var_221_16)
				local var_221_19 = var_221_17 <= 0 and var_221_13 or var_221_13 * (var_221_18 / var_221_17)

				if var_221_19 > 0 and var_221_13 < var_221_19 then
					arg_218_1.talkMaxDuration = var_221_19

					if var_221_19 + var_221_12 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_19 + var_221_12
					end
				end

				arg_218_1.text_.text = var_221_16
				arg_218_1.typewritter.percent = 0

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_110152", "110152053", "story_v_out_110152.awb") ~= 0 then
					local var_221_20 = manager.audio:GetVoiceLength("story_v_out_110152", "110152053", "story_v_out_110152.awb") / 1000

					if var_221_20 + var_221_12 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_20 + var_221_12
					end

					if var_221_15.prefab_name ~= "" and arg_218_1.actors_[var_221_15.prefab_name] ~= nil then
						local var_221_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_218_1.actors_[var_221_15.prefab_name].transform, "story_v_out_110152", "110152053", "story_v_out_110152.awb")

						arg_218_1:RecordAudio("110152053", var_221_21)
						arg_218_1:RecordAudio("110152053", var_221_21)
					else
						arg_218_1:AudioAction("play", "voice", "story_v_out_110152", "110152053", "story_v_out_110152.awb")
					end

					arg_218_1:RecordHistoryTalkVoice("story_v_out_110152", "110152053", "story_v_out_110152.awb")
				end

				arg_218_1:RecordContent(arg_218_1.text_.text)
			end

			local var_221_22 = math.max(var_221_13, arg_218_1.talkMaxDuration)

			if var_221_12 <= arg_218_1.time_ and arg_218_1.time_ < var_221_12 + var_221_22 then
				arg_218_1.typewritter.percent = (arg_218_1.time_ - var_221_12) / var_221_22

				arg_218_1.typewritter:SetDirty()
			end

			if arg_218_1.time_ >= var_221_12 + var_221_22 and arg_218_1.time_ < var_221_12 + var_221_22 + arg_221_0 then
				arg_218_1.typewritter.percent = 1

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(true)
			end
		end

		arg_218_1.nodeConfigList_ = {}

		arg_218_1:InitPlayNodeList()
	end,
	Play110152054 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 110152054
		arg_222_1.duration_ = 9.43

		local var_222_0 = {
			ja = 5.8,
			ko = 9.433,
			zh = 9,
			en = 7.6
		}
		local var_222_1 = manager.audio:GetLocalizationFlag()

		if var_222_0[var_222_1] ~= nil then
			arg_222_1.duration_ = var_222_0[var_222_1]
		end

		SetActive(arg_222_1.tipsGo_, false)

		function arg_222_1.onSingleLineFinish_()
			arg_222_1.onSingleLineUpdate_ = nil
			arg_222_1.onSingleLineFinish_ = nil
			arg_222_1.state_ = "waiting"
		end

		function arg_222_1.playNext_(arg_224_0)
			if arg_224_0 == 1 then
				arg_222_0:Play110152055(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			local var_225_0 = 0

			if var_225_0 < arg_222_1.time_ and arg_222_1.time_ <= var_225_0 + arg_225_0 then
				arg_222_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111actionlink/1111action445")
			end

			local var_225_1 = 0

			if var_225_1 < arg_222_1.time_ and arg_222_1.time_ <= var_225_1 + arg_225_0 then
				arg_222_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0204cva")
			end

			local var_225_2 = arg_222_1.actors_["1011ui_story"]
			local var_225_3 = 0

			if var_225_3 < arg_222_1.time_ and arg_222_1.time_ <= var_225_3 + arg_225_0 and not isNil(var_225_2) and arg_222_1.var_.characterEffect1011ui_story == nil then
				arg_222_1.var_.characterEffect1011ui_story = var_225_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_225_4 = 0.2

			if var_225_3 <= arg_222_1.time_ and arg_222_1.time_ < var_225_3 + var_225_4 and not isNil(var_225_2) then
				local var_225_5 = (arg_222_1.time_ - var_225_3) / var_225_4

				if arg_222_1.var_.characterEffect1011ui_story and not isNil(var_225_2) then
					local var_225_6 = Mathf.Lerp(0, 0.5, var_225_5)

					arg_222_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_222_1.var_.characterEffect1011ui_story.fillRatio = var_225_6
				end
			end

			if arg_222_1.time_ >= var_225_3 + var_225_4 and arg_222_1.time_ < var_225_3 + var_225_4 + arg_225_0 and not isNil(var_225_2) and arg_222_1.var_.characterEffect1011ui_story then
				local var_225_7 = 0.5

				arg_222_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_222_1.var_.characterEffect1011ui_story.fillRatio = var_225_7
			end

			local var_225_8 = arg_222_1.actors_["1111ui_story"]
			local var_225_9 = 0

			if var_225_9 < arg_222_1.time_ and arg_222_1.time_ <= var_225_9 + arg_225_0 and not isNil(var_225_8) and arg_222_1.var_.characterEffect1111ui_story == nil then
				arg_222_1.var_.characterEffect1111ui_story = var_225_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_225_10 = 0.2

			if var_225_9 <= arg_222_1.time_ and arg_222_1.time_ < var_225_9 + var_225_10 and not isNil(var_225_8) then
				local var_225_11 = (arg_222_1.time_ - var_225_9) / var_225_10

				if arg_222_1.var_.characterEffect1111ui_story and not isNil(var_225_8) then
					arg_222_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_222_1.time_ >= var_225_9 + var_225_10 and arg_222_1.time_ < var_225_9 + var_225_10 + arg_225_0 and not isNil(var_225_8) and arg_222_1.var_.characterEffect1111ui_story then
				arg_222_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_225_12 = 0
			local var_225_13 = 0.925

			if var_225_12 < arg_222_1.time_ and arg_222_1.time_ <= var_225_12 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0
				arg_222_1.dialogCg_.alpha = 1

				arg_222_1.dialog_:SetActive(true)
				SetActive(arg_222_1.leftNameGo_, true)

				local var_225_14 = arg_222_1:FormatText(StoryNameCfg[67].name)

				arg_222_1.leftNameTxt_.text = var_225_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_222_1.leftNameTxt_.transform)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1.leftNameTxt_.text)
				SetActive(arg_222_1.iconTrs_.gameObject, false)
				arg_222_1.callingController_:SetSelectedState("normal")

				local var_225_15 = arg_222_1:GetWordFromCfg(110152054)
				local var_225_16 = arg_222_1:FormatText(var_225_15.content)

				arg_222_1.text_.text = var_225_16

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_17 = 37
				local var_225_18 = utf8.len(var_225_16)
				local var_225_19 = var_225_17 <= 0 and var_225_13 or var_225_13 * (var_225_18 / var_225_17)

				if var_225_19 > 0 and var_225_13 < var_225_19 then
					arg_222_1.talkMaxDuration = var_225_19

					if var_225_19 + var_225_12 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_19 + var_225_12
					end
				end

				arg_222_1.text_.text = var_225_16
				arg_222_1.typewritter.percent = 0

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_110152", "110152054", "story_v_out_110152.awb") ~= 0 then
					local var_225_20 = manager.audio:GetVoiceLength("story_v_out_110152", "110152054", "story_v_out_110152.awb") / 1000

					if var_225_20 + var_225_12 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_20 + var_225_12
					end

					if var_225_15.prefab_name ~= "" and arg_222_1.actors_[var_225_15.prefab_name] ~= nil then
						local var_225_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_222_1.actors_[var_225_15.prefab_name].transform, "story_v_out_110152", "110152054", "story_v_out_110152.awb")

						arg_222_1:RecordAudio("110152054", var_225_21)
						arg_222_1:RecordAudio("110152054", var_225_21)
					else
						arg_222_1:AudioAction("play", "voice", "story_v_out_110152", "110152054", "story_v_out_110152.awb")
					end

					arg_222_1:RecordHistoryTalkVoice("story_v_out_110152", "110152054", "story_v_out_110152.awb")
				end

				arg_222_1:RecordContent(arg_222_1.text_.text)
			end

			local var_225_22 = math.max(var_225_13, arg_222_1.talkMaxDuration)

			if var_225_12 <= arg_222_1.time_ and arg_222_1.time_ < var_225_12 + var_225_22 then
				arg_222_1.typewritter.percent = (arg_222_1.time_ - var_225_12) / var_225_22

				arg_222_1.typewritter:SetDirty()
			end

			if arg_222_1.time_ >= var_225_12 + var_225_22 and arg_222_1.time_ < var_225_12 + var_225_22 + arg_225_0 then
				arg_222_1.typewritter.percent = 1

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(true)
			end
		end

		arg_222_1.nodeConfigList_ = {}

		arg_222_1:InitPlayNodeList()
	end,
	Play110152055 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 110152055
		arg_226_1.duration_ = 5.97

		local var_226_0 = {
			ja = 5.966,
			ko = 3.733,
			zh = 3.7,
			en = 2.4
		}
		local var_226_1 = manager.audio:GetLocalizationFlag()

		if var_226_0[var_226_1] ~= nil then
			arg_226_1.duration_ = var_226_0[var_226_1]
		end

		SetActive(arg_226_1.tipsGo_, false)

		function arg_226_1.onSingleLineFinish_()
			arg_226_1.onSingleLineUpdate_ = nil
			arg_226_1.onSingleLineFinish_ = nil
			arg_226_1.state_ = "waiting"
		end

		function arg_226_1.playNext_(arg_228_0)
			if arg_228_0 == 1 then
				arg_226_0:Play110152056(arg_226_1)
			end
		end

		function arg_226_1.onSingleLineUpdate_(arg_229_0)
			local var_229_0 = 0

			if var_229_0 < arg_226_1.time_ and arg_226_1.time_ <= var_229_0 + arg_229_0 then
				arg_226_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_229_1 = arg_226_1.actors_["1011ui_story"]
			local var_229_2 = 0

			if var_229_2 < arg_226_1.time_ and arg_226_1.time_ <= var_229_2 + arg_229_0 and not isNil(var_229_1) and arg_226_1.var_.characterEffect1011ui_story == nil then
				arg_226_1.var_.characterEffect1011ui_story = var_229_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_229_3 = 0.2

			if var_229_2 <= arg_226_1.time_ and arg_226_1.time_ < var_229_2 + var_229_3 and not isNil(var_229_1) then
				local var_229_4 = (arg_226_1.time_ - var_229_2) / var_229_3

				if arg_226_1.var_.characterEffect1011ui_story and not isNil(var_229_1) then
					arg_226_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_226_1.time_ >= var_229_2 + var_229_3 and arg_226_1.time_ < var_229_2 + var_229_3 + arg_229_0 and not isNil(var_229_1) and arg_226_1.var_.characterEffect1011ui_story then
				arg_226_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_229_5 = arg_226_1.actors_["1111ui_story"]
			local var_229_6 = 0

			if var_229_6 < arg_226_1.time_ and arg_226_1.time_ <= var_229_6 + arg_229_0 and not isNil(var_229_5) and arg_226_1.var_.characterEffect1111ui_story == nil then
				arg_226_1.var_.characterEffect1111ui_story = var_229_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_229_7 = 0.2

			if var_229_6 <= arg_226_1.time_ and arg_226_1.time_ < var_229_6 + var_229_7 and not isNil(var_229_5) then
				local var_229_8 = (arg_226_1.time_ - var_229_6) / var_229_7

				if arg_226_1.var_.characterEffect1111ui_story and not isNil(var_229_5) then
					local var_229_9 = Mathf.Lerp(0, 0.5, var_229_8)

					arg_226_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_226_1.var_.characterEffect1111ui_story.fillRatio = var_229_9
				end
			end

			if arg_226_1.time_ >= var_229_6 + var_229_7 and arg_226_1.time_ < var_229_6 + var_229_7 + arg_229_0 and not isNil(var_229_5) and arg_226_1.var_.characterEffect1111ui_story then
				local var_229_10 = 0.5

				arg_226_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_226_1.var_.characterEffect1111ui_story.fillRatio = var_229_10
			end

			local var_229_11 = 0
			local var_229_12 = 0.125

			if var_229_11 < arg_226_1.time_ and arg_226_1.time_ <= var_229_11 + arg_229_0 then
				arg_226_1.talkMaxDuration = 0
				arg_226_1.dialogCg_.alpha = 1

				arg_226_1.dialog_:SetActive(true)
				SetActive(arg_226_1.leftNameGo_, true)

				local var_229_13 = arg_226_1:FormatText(StoryNameCfg[37].name)

				arg_226_1.leftNameTxt_.text = var_229_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_226_1.leftNameTxt_.transform)

				arg_226_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_226_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_226_1:RecordName(arg_226_1.leftNameTxt_.text)
				SetActive(arg_226_1.iconTrs_.gameObject, false)
				arg_226_1.callingController_:SetSelectedState("normal")

				local var_229_14 = arg_226_1:GetWordFromCfg(110152055)
				local var_229_15 = arg_226_1:FormatText(var_229_14.content)

				arg_226_1.text_.text = var_229_15

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_16 = 5
				local var_229_17 = utf8.len(var_229_15)
				local var_229_18 = var_229_16 <= 0 and var_229_12 or var_229_12 * (var_229_17 / var_229_16)

				if var_229_18 > 0 and var_229_12 < var_229_18 then
					arg_226_1.talkMaxDuration = var_229_18

					if var_229_18 + var_229_11 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_18 + var_229_11
					end
				end

				arg_226_1.text_.text = var_229_15
				arg_226_1.typewritter.percent = 0

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_110152", "110152055", "story_v_out_110152.awb") ~= 0 then
					local var_229_19 = manager.audio:GetVoiceLength("story_v_out_110152", "110152055", "story_v_out_110152.awb") / 1000

					if var_229_19 + var_229_11 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_19 + var_229_11
					end

					if var_229_14.prefab_name ~= "" and arg_226_1.actors_[var_229_14.prefab_name] ~= nil then
						local var_229_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_226_1.actors_[var_229_14.prefab_name].transform, "story_v_out_110152", "110152055", "story_v_out_110152.awb")

						arg_226_1:RecordAudio("110152055", var_229_20)
						arg_226_1:RecordAudio("110152055", var_229_20)
					else
						arg_226_1:AudioAction("play", "voice", "story_v_out_110152", "110152055", "story_v_out_110152.awb")
					end

					arg_226_1:RecordHistoryTalkVoice("story_v_out_110152", "110152055", "story_v_out_110152.awb")
				end

				arg_226_1:RecordContent(arg_226_1.text_.text)
			end

			local var_229_21 = math.max(var_229_12, arg_226_1.talkMaxDuration)

			if var_229_11 <= arg_226_1.time_ and arg_226_1.time_ < var_229_11 + var_229_21 then
				arg_226_1.typewritter.percent = (arg_226_1.time_ - var_229_11) / var_229_21

				arg_226_1.typewritter:SetDirty()
			end

			if arg_226_1.time_ >= var_229_11 + var_229_21 and arg_226_1.time_ < var_229_11 + var_229_21 + arg_229_0 then
				arg_226_1.typewritter.percent = 1

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(true)
			end
		end

		arg_226_1.nodeConfigList_ = {}

		arg_226_1:InitPlayNodeList()
	end,
	Play110152056 = function(arg_230_0, arg_230_1)
		arg_230_1.time_ = 0
		arg_230_1.frameCnt_ = 0
		arg_230_1.state_ = "playing"
		arg_230_1.curTalkId_ = 110152056
		arg_230_1.duration_ = 5

		SetActive(arg_230_1.tipsGo_, false)

		function arg_230_1.onSingleLineFinish_()
			arg_230_1.onSingleLineUpdate_ = nil
			arg_230_1.onSingleLineFinish_ = nil
			arg_230_1.state_ = "waiting"
		end

		function arg_230_1.playNext_(arg_232_0)
			if arg_232_0 == 1 then
				arg_230_0:Play110152057(arg_230_1)
			end
		end

		function arg_230_1.onSingleLineUpdate_(arg_233_0)
			local var_233_0 = arg_230_1.actors_["1111ui_story"].transform
			local var_233_1 = 0

			if var_233_1 < arg_230_1.time_ and arg_230_1.time_ <= var_233_1 + arg_233_0 then
				arg_230_1.var_.moveOldPos1111ui_story = var_233_0.localPosition
			end

			local var_233_2 = 0.001

			if var_233_1 <= arg_230_1.time_ and arg_230_1.time_ < var_233_1 + var_233_2 then
				local var_233_3 = (arg_230_1.time_ - var_233_1) / var_233_2
				local var_233_4 = Vector3.New(0, 100, 0)

				var_233_0.localPosition = Vector3.Lerp(arg_230_1.var_.moveOldPos1111ui_story, var_233_4, var_233_3)

				local var_233_5 = manager.ui.mainCamera.transform.position - var_233_0.position

				var_233_0.forward = Vector3.New(var_233_5.x, var_233_5.y, var_233_5.z)

				local var_233_6 = var_233_0.localEulerAngles

				var_233_6.z = 0
				var_233_6.x = 0
				var_233_0.localEulerAngles = var_233_6
			end

			if arg_230_1.time_ >= var_233_1 + var_233_2 and arg_230_1.time_ < var_233_1 + var_233_2 + arg_233_0 then
				var_233_0.localPosition = Vector3.New(0, 100, 0)

				local var_233_7 = manager.ui.mainCamera.transform.position - var_233_0.position

				var_233_0.forward = Vector3.New(var_233_7.x, var_233_7.y, var_233_7.z)

				local var_233_8 = var_233_0.localEulerAngles

				var_233_8.z = 0
				var_233_8.x = 0
				var_233_0.localEulerAngles = var_233_8
			end

			local var_233_9 = arg_230_1.actors_["1011ui_story"].transform
			local var_233_10 = 0

			if var_233_10 < arg_230_1.time_ and arg_230_1.time_ <= var_233_10 + arg_233_0 then
				arg_230_1.var_.moveOldPos1011ui_story = var_233_9.localPosition
			end

			local var_233_11 = 0.001

			if var_233_10 <= arg_230_1.time_ and arg_230_1.time_ < var_233_10 + var_233_11 then
				local var_233_12 = (arg_230_1.time_ - var_233_10) / var_233_11
				local var_233_13 = Vector3.New(0, 100, 0)

				var_233_9.localPosition = Vector3.Lerp(arg_230_1.var_.moveOldPos1011ui_story, var_233_13, var_233_12)

				local var_233_14 = manager.ui.mainCamera.transform.position - var_233_9.position

				var_233_9.forward = Vector3.New(var_233_14.x, var_233_14.y, var_233_14.z)

				local var_233_15 = var_233_9.localEulerAngles

				var_233_15.z = 0
				var_233_15.x = 0
				var_233_9.localEulerAngles = var_233_15
			end

			if arg_230_1.time_ >= var_233_10 + var_233_11 and arg_230_1.time_ < var_233_10 + var_233_11 + arg_233_0 then
				var_233_9.localPosition = Vector3.New(0, 100, 0)

				local var_233_16 = manager.ui.mainCamera.transform.position - var_233_9.position

				var_233_9.forward = Vector3.New(var_233_16.x, var_233_16.y, var_233_16.z)

				local var_233_17 = var_233_9.localEulerAngles

				var_233_17.z = 0
				var_233_17.x = 0
				var_233_9.localEulerAngles = var_233_17
			end

			local var_233_18 = 0
			local var_233_19 = 0.825

			if var_233_18 < arg_230_1.time_ and arg_230_1.time_ <= var_233_18 + arg_233_0 then
				arg_230_1.talkMaxDuration = 0
				arg_230_1.dialogCg_.alpha = 1

				arg_230_1.dialog_:SetActive(true)
				SetActive(arg_230_1.leftNameGo_, false)

				arg_230_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_230_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_230_1:RecordName(arg_230_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_230_1.iconTrs_.gameObject, false)
				arg_230_1.callingController_:SetSelectedState("normal")

				local var_233_20 = arg_230_1:GetWordFromCfg(110152056)
				local var_233_21 = arg_230_1:FormatText(var_233_20.content)

				arg_230_1.text_.text = var_233_21

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_22 = 33
				local var_233_23 = utf8.len(var_233_21)
				local var_233_24 = var_233_22 <= 0 and var_233_19 or var_233_19 * (var_233_23 / var_233_22)

				if var_233_24 > 0 and var_233_19 < var_233_24 then
					arg_230_1.talkMaxDuration = var_233_24

					if var_233_24 + var_233_18 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_24 + var_233_18
					end
				end

				arg_230_1.text_.text = var_233_21
				arg_230_1.typewritter.percent = 0

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(false)
				arg_230_1:RecordContent(arg_230_1.text_.text)
			end

			local var_233_25 = math.max(var_233_19, arg_230_1.talkMaxDuration)

			if var_233_18 <= arg_230_1.time_ and arg_230_1.time_ < var_233_18 + var_233_25 then
				arg_230_1.typewritter.percent = (arg_230_1.time_ - var_233_18) / var_233_25

				arg_230_1.typewritter:SetDirty()
			end

			if arg_230_1.time_ >= var_233_18 + var_233_25 and arg_230_1.time_ < var_233_18 + var_233_25 + arg_233_0 then
				arg_230_1.typewritter.percent = 1

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(true)
			end
		end

		arg_230_1.nodeConfigList_ = {
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
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_230_1:InitPlayNodeList()
	end,
	Play110152057 = function(arg_234_0, arg_234_1)
		arg_234_1.time_ = 0
		arg_234_1.frameCnt_ = 0
		arg_234_1.state_ = "playing"
		arg_234_1.curTalkId_ = 110152057
		arg_234_1.duration_ = 4.47

		local var_234_0 = {
			ja = 3.733,
			ko = 3.8,
			zh = 4.466,
			en = 4.233
		}
		local var_234_1 = manager.audio:GetLocalizationFlag()

		if var_234_0[var_234_1] ~= nil then
			arg_234_1.duration_ = var_234_0[var_234_1]
		end

		SetActive(arg_234_1.tipsGo_, false)

		function arg_234_1.onSingleLineFinish_()
			arg_234_1.onSingleLineUpdate_ = nil
			arg_234_1.onSingleLineFinish_ = nil
			arg_234_1.state_ = "waiting"
		end

		function arg_234_1.playNext_(arg_236_0)
			if arg_236_0 == 1 then
				arg_234_0:Play110152058(arg_234_1)
			end
		end

		function arg_234_1.onSingleLineUpdate_(arg_237_0)
			local var_237_0 = 0

			if var_237_0 < arg_234_1.time_ and arg_234_1.time_ <= var_237_0 + arg_237_0 then
				arg_234_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action6_1")
			end

			local var_237_1 = arg_234_1.actors_["1011ui_story"].transform
			local var_237_2 = 0

			if var_237_2 < arg_234_1.time_ and arg_234_1.time_ <= var_237_2 + arg_237_0 then
				arg_234_1.var_.moveOldPos1011ui_story = var_237_1.localPosition
			end

			local var_237_3 = 0.001

			if var_237_2 <= arg_234_1.time_ and arg_234_1.time_ < var_237_2 + var_237_3 then
				local var_237_4 = (arg_234_1.time_ - var_237_2) / var_237_3
				local var_237_5 = Vector3.New(0, -0.71, -6)

				var_237_1.localPosition = Vector3.Lerp(arg_234_1.var_.moveOldPos1011ui_story, var_237_5, var_237_4)

				local var_237_6 = manager.ui.mainCamera.transform.position - var_237_1.position

				var_237_1.forward = Vector3.New(var_237_6.x, var_237_6.y, var_237_6.z)

				local var_237_7 = var_237_1.localEulerAngles

				var_237_7.z = 0
				var_237_7.x = 0
				var_237_1.localEulerAngles = var_237_7
			end

			if arg_234_1.time_ >= var_237_2 + var_237_3 and arg_234_1.time_ < var_237_2 + var_237_3 + arg_237_0 then
				var_237_1.localPosition = Vector3.New(0, -0.71, -6)

				local var_237_8 = manager.ui.mainCamera.transform.position - var_237_1.position

				var_237_1.forward = Vector3.New(var_237_8.x, var_237_8.y, var_237_8.z)

				local var_237_9 = var_237_1.localEulerAngles

				var_237_9.z = 0
				var_237_9.x = 0
				var_237_1.localEulerAngles = var_237_9
			end

			local var_237_10 = 0

			if var_237_10 < arg_234_1.time_ and arg_234_1.time_ <= var_237_10 + arg_237_0 then
				arg_234_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_237_11 = arg_234_1.actors_["1011ui_story"]
			local var_237_12 = 0

			if var_237_12 < arg_234_1.time_ and arg_234_1.time_ <= var_237_12 + arg_237_0 and not isNil(var_237_11) and arg_234_1.var_.characterEffect1011ui_story == nil then
				arg_234_1.var_.characterEffect1011ui_story = var_237_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_237_13 = 0.2

			if var_237_12 <= arg_234_1.time_ and arg_234_1.time_ < var_237_12 + var_237_13 and not isNil(var_237_11) then
				local var_237_14 = (arg_234_1.time_ - var_237_12) / var_237_13

				if arg_234_1.var_.characterEffect1011ui_story and not isNil(var_237_11) then
					arg_234_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_234_1.time_ >= var_237_12 + var_237_13 and arg_234_1.time_ < var_237_12 + var_237_13 + arg_237_0 and not isNil(var_237_11) and arg_234_1.var_.characterEffect1011ui_story then
				arg_234_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_237_15 = 0
			local var_237_16 = 0.425

			if var_237_15 < arg_234_1.time_ and arg_234_1.time_ <= var_237_15 + arg_237_0 then
				arg_234_1.talkMaxDuration = 0
				arg_234_1.dialogCg_.alpha = 1

				arg_234_1.dialog_:SetActive(true)
				SetActive(arg_234_1.leftNameGo_, true)

				local var_237_17 = arg_234_1:FormatText(StoryNameCfg[37].name)

				arg_234_1.leftNameTxt_.text = var_237_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_234_1.leftNameTxt_.transform)

				arg_234_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_234_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_234_1:RecordName(arg_234_1.leftNameTxt_.text)
				SetActive(arg_234_1.iconTrs_.gameObject, false)
				arg_234_1.callingController_:SetSelectedState("normal")

				local var_237_18 = arg_234_1:GetWordFromCfg(110152057)
				local var_237_19 = arg_234_1:FormatText(var_237_18.content)

				arg_234_1.text_.text = var_237_19

				LuaForUtil.ClearLinePrefixSymbol(arg_234_1.text_)

				local var_237_20 = 17
				local var_237_21 = utf8.len(var_237_19)
				local var_237_22 = var_237_20 <= 0 and var_237_16 or var_237_16 * (var_237_21 / var_237_20)

				if var_237_22 > 0 and var_237_16 < var_237_22 then
					arg_234_1.talkMaxDuration = var_237_22

					if var_237_22 + var_237_15 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_22 + var_237_15
					end
				end

				arg_234_1.text_.text = var_237_19
				arg_234_1.typewritter.percent = 0

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_110152", "110152057", "story_v_out_110152.awb") ~= 0 then
					local var_237_23 = manager.audio:GetVoiceLength("story_v_out_110152", "110152057", "story_v_out_110152.awb") / 1000

					if var_237_23 + var_237_15 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_23 + var_237_15
					end

					if var_237_18.prefab_name ~= "" and arg_234_1.actors_[var_237_18.prefab_name] ~= nil then
						local var_237_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_234_1.actors_[var_237_18.prefab_name].transform, "story_v_out_110152", "110152057", "story_v_out_110152.awb")

						arg_234_1:RecordAudio("110152057", var_237_24)
						arg_234_1:RecordAudio("110152057", var_237_24)
					else
						arg_234_1:AudioAction("play", "voice", "story_v_out_110152", "110152057", "story_v_out_110152.awb")
					end

					arg_234_1:RecordHistoryTalkVoice("story_v_out_110152", "110152057", "story_v_out_110152.awb")
				end

				arg_234_1:RecordContent(arg_234_1.text_.text)
			end

			local var_237_25 = math.max(var_237_16, arg_234_1.talkMaxDuration)

			if var_237_15 <= arg_234_1.time_ and arg_234_1.time_ < var_237_15 + var_237_25 then
				arg_234_1.typewritter.percent = (arg_234_1.time_ - var_237_15) / var_237_25

				arg_234_1.typewritter:SetDirty()
			end

			if arg_234_1.time_ >= var_237_15 + var_237_25 and arg_234_1.time_ < var_237_15 + var_237_25 + arg_237_0 then
				arg_234_1.typewritter.percent = 1

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(true)
			end
		end

		arg_234_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_234_1:InitPlayNodeList()
	end,
	Play110152058 = function(arg_238_0, arg_238_1)
		arg_238_1.time_ = 0
		arg_238_1.frameCnt_ = 0
		arg_238_1.state_ = "playing"
		arg_238_1.curTalkId_ = 110152058
		arg_238_1.duration_ = 14.73

		local var_238_0 = {
			ja = 14.733,
			ko = 8.8,
			zh = 9.366,
			en = 11.033
		}
		local var_238_1 = manager.audio:GetLocalizationFlag()

		if var_238_0[var_238_1] ~= nil then
			arg_238_1.duration_ = var_238_0[var_238_1]
		end

		SetActive(arg_238_1.tipsGo_, false)

		function arg_238_1.onSingleLineFinish_()
			arg_238_1.onSingleLineUpdate_ = nil
			arg_238_1.onSingleLineFinish_ = nil
			arg_238_1.state_ = "waiting"
		end

		function arg_238_1.playNext_(arg_240_0)
			if arg_240_0 == 1 then
				arg_238_0:Play110152059(arg_238_1)
			end
		end

		function arg_238_1.onSingleLineUpdate_(arg_241_0)
			local var_241_0 = 0

			if var_241_0 < arg_238_1.time_ and arg_238_1.time_ <= var_241_0 + arg_241_0 then
				arg_238_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1204cva")
			end

			local var_241_1 = 0
			local var_241_2 = 0.675

			if var_241_1 < arg_238_1.time_ and arg_238_1.time_ <= var_241_1 + arg_241_0 then
				arg_238_1.talkMaxDuration = 0
				arg_238_1.dialogCg_.alpha = 1

				arg_238_1.dialog_:SetActive(true)
				SetActive(arg_238_1.leftNameGo_, true)

				local var_241_3 = arg_238_1:FormatText(StoryNameCfg[37].name)

				arg_238_1.leftNameTxt_.text = var_241_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_238_1.leftNameTxt_.transform)

				arg_238_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_238_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_238_1:RecordName(arg_238_1.leftNameTxt_.text)
				SetActive(arg_238_1.iconTrs_.gameObject, false)
				arg_238_1.callingController_:SetSelectedState("normal")

				local var_241_4 = arg_238_1:GetWordFromCfg(110152058)
				local var_241_5 = arg_238_1:FormatText(var_241_4.content)

				arg_238_1.text_.text = var_241_5

				LuaForUtil.ClearLinePrefixSymbol(arg_238_1.text_)

				local var_241_6 = 27
				local var_241_7 = utf8.len(var_241_5)
				local var_241_8 = var_241_6 <= 0 and var_241_2 or var_241_2 * (var_241_7 / var_241_6)

				if var_241_8 > 0 and var_241_2 < var_241_8 then
					arg_238_1.talkMaxDuration = var_241_8

					if var_241_8 + var_241_1 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_8 + var_241_1
					end
				end

				arg_238_1.text_.text = var_241_5
				arg_238_1.typewritter.percent = 0

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_110152", "110152058", "story_v_out_110152.awb") ~= 0 then
					local var_241_9 = manager.audio:GetVoiceLength("story_v_out_110152", "110152058", "story_v_out_110152.awb") / 1000

					if var_241_9 + var_241_1 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_9 + var_241_1
					end

					if var_241_4.prefab_name ~= "" and arg_238_1.actors_[var_241_4.prefab_name] ~= nil then
						local var_241_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_238_1.actors_[var_241_4.prefab_name].transform, "story_v_out_110152", "110152058", "story_v_out_110152.awb")

						arg_238_1:RecordAudio("110152058", var_241_10)
						arg_238_1:RecordAudio("110152058", var_241_10)
					else
						arg_238_1:AudioAction("play", "voice", "story_v_out_110152", "110152058", "story_v_out_110152.awb")
					end

					arg_238_1:RecordHistoryTalkVoice("story_v_out_110152", "110152058", "story_v_out_110152.awb")
				end

				arg_238_1:RecordContent(arg_238_1.text_.text)
			end

			local var_241_11 = math.max(var_241_2, arg_238_1.talkMaxDuration)

			if var_241_1 <= arg_238_1.time_ and arg_238_1.time_ < var_241_1 + var_241_11 then
				arg_238_1.typewritter.percent = (arg_238_1.time_ - var_241_1) / var_241_11

				arg_238_1.typewritter:SetDirty()
			end

			if arg_238_1.time_ >= var_241_1 + var_241_11 and arg_238_1.time_ < var_241_1 + var_241_11 + arg_241_0 then
				arg_238_1.typewritter.percent = 1

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(true)
			end
		end

		arg_238_1.nodeConfigList_ = {}

		arg_238_1:InitPlayNodeList()
	end,
	Play110152059 = function(arg_242_0, arg_242_1)
		arg_242_1.time_ = 0
		arg_242_1.frameCnt_ = 0
		arg_242_1.state_ = "playing"
		arg_242_1.curTalkId_ = 110152059
		arg_242_1.duration_ = 2.97

		local var_242_0 = {
			ja = 2.7,
			ko = 2.966,
			zh = 2.333,
			en = 2.633
		}
		local var_242_1 = manager.audio:GetLocalizationFlag()

		if var_242_0[var_242_1] ~= nil then
			arg_242_1.duration_ = var_242_0[var_242_1]
		end

		SetActive(arg_242_1.tipsGo_, false)

		function arg_242_1.onSingleLineFinish_()
			arg_242_1.onSingleLineUpdate_ = nil
			arg_242_1.onSingleLineFinish_ = nil
			arg_242_1.state_ = "waiting"
		end

		function arg_242_1.playNext_(arg_244_0)
			if arg_244_0 == 1 then
				arg_242_0:Play110152060(arg_242_1)
			end
		end

		function arg_242_1.onSingleLineUpdate_(arg_245_0)
			local var_245_0 = arg_242_1.actors_["1011ui_story"]
			local var_245_1 = 0

			if var_245_1 < arg_242_1.time_ and arg_242_1.time_ <= var_245_1 + arg_245_0 and not isNil(var_245_0) and arg_242_1.var_.characterEffect1011ui_story == nil then
				arg_242_1.var_.characterEffect1011ui_story = var_245_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_245_2 = 0.2

			if var_245_1 <= arg_242_1.time_ and arg_242_1.time_ < var_245_1 + var_245_2 and not isNil(var_245_0) then
				local var_245_3 = (arg_242_1.time_ - var_245_1) / var_245_2

				if arg_242_1.var_.characterEffect1011ui_story and not isNil(var_245_0) then
					local var_245_4 = Mathf.Lerp(0, 0.5, var_245_3)

					arg_242_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_242_1.var_.characterEffect1011ui_story.fillRatio = var_245_4
				end
			end

			if arg_242_1.time_ >= var_245_1 + var_245_2 and arg_242_1.time_ < var_245_1 + var_245_2 + arg_245_0 and not isNil(var_245_0) and arg_242_1.var_.characterEffect1011ui_story then
				local var_245_5 = 0.5

				arg_242_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_242_1.var_.characterEffect1011ui_story.fillRatio = var_245_5
			end

			local var_245_6 = 0
			local var_245_7 = 0.25

			if var_245_6 < arg_242_1.time_ and arg_242_1.time_ <= var_245_6 + arg_245_0 then
				arg_242_1.talkMaxDuration = 0
				arg_242_1.dialogCg_.alpha = 1

				arg_242_1.dialog_:SetActive(true)
				SetActive(arg_242_1.leftNameGo_, true)

				local var_245_8 = arg_242_1:FormatText(StoryNameCfg[6].name)

				arg_242_1.leftNameTxt_.text = var_245_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_242_1.leftNameTxt_.transform)

				arg_242_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_242_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_242_1:RecordName(arg_242_1.leftNameTxt_.text)
				SetActive(arg_242_1.iconTrs_.gameObject, true)
				arg_242_1.iconController_:SetSelectedState("hero")

				arg_242_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1184")

				arg_242_1.callingController_:SetSelectedState("normal")

				arg_242_1.keyicon_.color = Color.New(1, 1, 1)
				arg_242_1.icon_.color = Color.New(1, 1, 1)

				local var_245_9 = arg_242_1:GetWordFromCfg(110152059)
				local var_245_10 = arg_242_1:FormatText(var_245_9.content)

				arg_242_1.text_.text = var_245_10

				LuaForUtil.ClearLinePrefixSymbol(arg_242_1.text_)

				local var_245_11 = 10
				local var_245_12 = utf8.len(var_245_10)
				local var_245_13 = var_245_11 <= 0 and var_245_7 or var_245_7 * (var_245_12 / var_245_11)

				if var_245_13 > 0 and var_245_7 < var_245_13 then
					arg_242_1.talkMaxDuration = var_245_13

					if var_245_13 + var_245_6 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_13 + var_245_6
					end
				end

				arg_242_1.text_.text = var_245_10
				arg_242_1.typewritter.percent = 0

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_110152", "110152059", "story_v_out_110152.awb") ~= 0 then
					local var_245_14 = manager.audio:GetVoiceLength("story_v_out_110152", "110152059", "story_v_out_110152.awb") / 1000

					if var_245_14 + var_245_6 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_14 + var_245_6
					end

					if var_245_9.prefab_name ~= "" and arg_242_1.actors_[var_245_9.prefab_name] ~= nil then
						local var_245_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_242_1.actors_[var_245_9.prefab_name].transform, "story_v_out_110152", "110152059", "story_v_out_110152.awb")

						arg_242_1:RecordAudio("110152059", var_245_15)
						arg_242_1:RecordAudio("110152059", var_245_15)
					else
						arg_242_1:AudioAction("play", "voice", "story_v_out_110152", "110152059", "story_v_out_110152.awb")
					end

					arg_242_1:RecordHistoryTalkVoice("story_v_out_110152", "110152059", "story_v_out_110152.awb")
				end

				arg_242_1:RecordContent(arg_242_1.text_.text)
			end

			local var_245_16 = math.max(var_245_7, arg_242_1.talkMaxDuration)

			if var_245_6 <= arg_242_1.time_ and arg_242_1.time_ < var_245_6 + var_245_16 then
				arg_242_1.typewritter.percent = (arg_242_1.time_ - var_245_6) / var_245_16

				arg_242_1.typewritter:SetDirty()
			end

			if arg_242_1.time_ >= var_245_6 + var_245_16 and arg_242_1.time_ < var_245_6 + var_245_16 + arg_245_0 then
				arg_242_1.typewritter.percent = 1

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(true)
			end
		end

		arg_242_1.nodeConfigList_ = {}

		arg_242_1:InitPlayNodeList()
	end,
	Play110152060 = function(arg_246_0, arg_246_1)
		arg_246_1.time_ = 0
		arg_246_1.frameCnt_ = 0
		arg_246_1.state_ = "playing"
		arg_246_1.curTalkId_ = 110152060
		arg_246_1.duration_ = 3.23

		local var_246_0 = {
			ja = 2.9,
			ko = 3.233,
			zh = 2.433,
			en = 2.3
		}
		local var_246_1 = manager.audio:GetLocalizationFlag()

		if var_246_0[var_246_1] ~= nil then
			arg_246_1.duration_ = var_246_0[var_246_1]
		end

		SetActive(arg_246_1.tipsGo_, false)

		function arg_246_1.onSingleLineFinish_()
			arg_246_1.onSingleLineUpdate_ = nil
			arg_246_1.onSingleLineFinish_ = nil
			arg_246_1.state_ = "waiting"
		end

		function arg_246_1.playNext_(arg_248_0)
			if arg_248_0 == 1 then
				arg_246_0:Play110152061(arg_246_1)
			end
		end

		function arg_246_1.onSingleLineUpdate_(arg_249_0)
			local var_249_0 = 0
			local var_249_1 = 0.225

			if var_249_0 < arg_246_1.time_ and arg_246_1.time_ <= var_249_0 + arg_249_0 then
				arg_246_1.talkMaxDuration = 0
				arg_246_1.dialogCg_.alpha = 1

				arg_246_1.dialog_:SetActive(true)
				SetActive(arg_246_1.leftNameGo_, true)

				local var_249_2 = arg_246_1:FormatText(StoryNameCfg[13].name)

				arg_246_1.leftNameTxt_.text = var_249_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_246_1.leftNameTxt_.transform)

				arg_246_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_246_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_246_1:RecordName(arg_246_1.leftNameTxt_.text)
				SetActive(arg_246_1.iconTrs_.gameObject, true)
				arg_246_1.iconController_:SetSelectedState("hero")

				arg_246_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019")

				arg_246_1.callingController_:SetSelectedState("normal")

				arg_246_1.keyicon_.color = Color.New(1, 1, 1)
				arg_246_1.icon_.color = Color.New(1, 1, 1)

				local var_249_3 = arg_246_1:GetWordFromCfg(110152060)
				local var_249_4 = arg_246_1:FormatText(var_249_3.content)

				arg_246_1.text_.text = var_249_4

				LuaForUtil.ClearLinePrefixSymbol(arg_246_1.text_)

				local var_249_5 = 9
				local var_249_6 = utf8.len(var_249_4)
				local var_249_7 = var_249_5 <= 0 and var_249_1 or var_249_1 * (var_249_6 / var_249_5)

				if var_249_7 > 0 and var_249_1 < var_249_7 then
					arg_246_1.talkMaxDuration = var_249_7

					if var_249_7 + var_249_0 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_7 + var_249_0
					end
				end

				arg_246_1.text_.text = var_249_4
				arg_246_1.typewritter.percent = 0

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_110152", "110152060", "story_v_out_110152.awb") ~= 0 then
					local var_249_8 = manager.audio:GetVoiceLength("story_v_out_110152", "110152060", "story_v_out_110152.awb") / 1000

					if var_249_8 + var_249_0 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_8 + var_249_0
					end

					if var_249_3.prefab_name ~= "" and arg_246_1.actors_[var_249_3.prefab_name] ~= nil then
						local var_249_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_246_1.actors_[var_249_3.prefab_name].transform, "story_v_out_110152", "110152060", "story_v_out_110152.awb")

						arg_246_1:RecordAudio("110152060", var_249_9)
						arg_246_1:RecordAudio("110152060", var_249_9)
					else
						arg_246_1:AudioAction("play", "voice", "story_v_out_110152", "110152060", "story_v_out_110152.awb")
					end

					arg_246_1:RecordHistoryTalkVoice("story_v_out_110152", "110152060", "story_v_out_110152.awb")
				end

				arg_246_1:RecordContent(arg_246_1.text_.text)
			end

			local var_249_10 = math.max(var_249_1, arg_246_1.talkMaxDuration)

			if var_249_0 <= arg_246_1.time_ and arg_246_1.time_ < var_249_0 + var_249_10 then
				arg_246_1.typewritter.percent = (arg_246_1.time_ - var_249_0) / var_249_10

				arg_246_1.typewritter:SetDirty()
			end

			if arg_246_1.time_ >= var_249_0 + var_249_10 and arg_246_1.time_ < var_249_0 + var_249_10 + arg_249_0 then
				arg_246_1.typewritter.percent = 1

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(true)
			end
		end

		arg_246_1.nodeConfigList_ = {}

		arg_246_1:InitPlayNodeList()
	end,
	Play110152061 = function(arg_250_0, arg_250_1)
		arg_250_1.time_ = 0
		arg_250_1.frameCnt_ = 0
		arg_250_1.state_ = "playing"
		arg_250_1.curTalkId_ = 110152061
		arg_250_1.duration_ = 9.87

		local var_250_0 = {
			ja = 8.133,
			ko = 5.433,
			zh = 9.866,
			en = 6.066
		}
		local var_250_1 = manager.audio:GetLocalizationFlag()

		if var_250_0[var_250_1] ~= nil then
			arg_250_1.duration_ = var_250_0[var_250_1]
		end

		SetActive(arg_250_1.tipsGo_, false)

		function arg_250_1.onSingleLineFinish_()
			arg_250_1.onSingleLineUpdate_ = nil
			arg_250_1.onSingleLineFinish_ = nil
			arg_250_1.state_ = "waiting"
		end

		function arg_250_1.playNext_(arg_252_0)
			if arg_252_0 == 1 then
				arg_250_0:Play110152062(arg_250_1)
			end
		end

		function arg_250_1.onSingleLineUpdate_(arg_253_0)
			local var_253_0 = 0

			if var_253_0 < arg_250_1.time_ and arg_250_1.time_ <= var_253_0 + arg_253_0 then
				arg_250_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011actionlink/1011action462")
			end

			local var_253_1 = 0

			if var_253_1 < arg_250_1.time_ and arg_250_1.time_ <= var_253_1 + arg_253_0 then
				arg_250_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_253_2 = arg_250_1.actors_["1011ui_story"]
			local var_253_3 = 0

			if var_253_3 < arg_250_1.time_ and arg_250_1.time_ <= var_253_3 + arg_253_0 and not isNil(var_253_2) and arg_250_1.var_.characterEffect1011ui_story == nil then
				arg_250_1.var_.characterEffect1011ui_story = var_253_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_253_4 = 0.2

			if var_253_3 <= arg_250_1.time_ and arg_250_1.time_ < var_253_3 + var_253_4 and not isNil(var_253_2) then
				local var_253_5 = (arg_250_1.time_ - var_253_3) / var_253_4

				if arg_250_1.var_.characterEffect1011ui_story and not isNil(var_253_2) then
					arg_250_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_250_1.time_ >= var_253_3 + var_253_4 and arg_250_1.time_ < var_253_3 + var_253_4 + arg_253_0 and not isNil(var_253_2) and arg_250_1.var_.characterEffect1011ui_story then
				arg_250_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_253_6 = 0
			local var_253_7 = 0.45

			if var_253_6 < arg_250_1.time_ and arg_250_1.time_ <= var_253_6 + arg_253_0 then
				arg_250_1.talkMaxDuration = 0
				arg_250_1.dialogCg_.alpha = 1

				arg_250_1.dialog_:SetActive(true)
				SetActive(arg_250_1.leftNameGo_, true)

				local var_253_8 = arg_250_1:FormatText(StoryNameCfg[37].name)

				arg_250_1.leftNameTxt_.text = var_253_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_250_1.leftNameTxt_.transform)

				arg_250_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_250_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_250_1:RecordName(arg_250_1.leftNameTxt_.text)
				SetActive(arg_250_1.iconTrs_.gameObject, false)
				arg_250_1.callingController_:SetSelectedState("normal")

				local var_253_9 = arg_250_1:GetWordFromCfg(110152061)
				local var_253_10 = arg_250_1:FormatText(var_253_9.content)

				arg_250_1.text_.text = var_253_10

				LuaForUtil.ClearLinePrefixSymbol(arg_250_1.text_)

				local var_253_11 = 18
				local var_253_12 = utf8.len(var_253_10)
				local var_253_13 = var_253_11 <= 0 and var_253_7 or var_253_7 * (var_253_12 / var_253_11)

				if var_253_13 > 0 and var_253_7 < var_253_13 then
					arg_250_1.talkMaxDuration = var_253_13

					if var_253_13 + var_253_6 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_13 + var_253_6
					end
				end

				arg_250_1.text_.text = var_253_10
				arg_250_1.typewritter.percent = 0

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_110152", "110152061", "story_v_out_110152.awb") ~= 0 then
					local var_253_14 = manager.audio:GetVoiceLength("story_v_out_110152", "110152061", "story_v_out_110152.awb") / 1000

					if var_253_14 + var_253_6 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_14 + var_253_6
					end

					if var_253_9.prefab_name ~= "" and arg_250_1.actors_[var_253_9.prefab_name] ~= nil then
						local var_253_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_250_1.actors_[var_253_9.prefab_name].transform, "story_v_out_110152", "110152061", "story_v_out_110152.awb")

						arg_250_1:RecordAudio("110152061", var_253_15)
						arg_250_1:RecordAudio("110152061", var_253_15)
					else
						arg_250_1:AudioAction("play", "voice", "story_v_out_110152", "110152061", "story_v_out_110152.awb")
					end

					arg_250_1:RecordHistoryTalkVoice("story_v_out_110152", "110152061", "story_v_out_110152.awb")
				end

				arg_250_1:RecordContent(arg_250_1.text_.text)
			end

			local var_253_16 = math.max(var_253_7, arg_250_1.talkMaxDuration)

			if var_253_6 <= arg_250_1.time_ and arg_250_1.time_ < var_253_6 + var_253_16 then
				arg_250_1.typewritter.percent = (arg_250_1.time_ - var_253_6) / var_253_16

				arg_250_1.typewritter:SetDirty()
			end

			if arg_250_1.time_ >= var_253_6 + var_253_16 and arg_250_1.time_ < var_253_6 + var_253_16 + arg_253_0 then
				arg_250_1.typewritter.percent = 1

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(true)
			end
		end

		arg_250_1.nodeConfigList_ = {}

		arg_250_1:InitPlayNodeList()
	end,
	Play110152062 = function(arg_254_0, arg_254_1)
		arg_254_1.time_ = 0
		arg_254_1.frameCnt_ = 0
		arg_254_1.state_ = "playing"
		arg_254_1.curTalkId_ = 110152062
		arg_254_1.duration_ = 5

		SetActive(arg_254_1.tipsGo_, false)

		function arg_254_1.onSingleLineFinish_()
			arg_254_1.onSingleLineUpdate_ = nil
			arg_254_1.onSingleLineFinish_ = nil
			arg_254_1.state_ = "waiting"
		end

		function arg_254_1.playNext_(arg_256_0)
			if arg_256_0 == 1 then
				arg_254_0:Play110152063(arg_254_1)
			end
		end

		function arg_254_1.onSingleLineUpdate_(arg_257_0)
			local var_257_0 = arg_254_1.actors_["1011ui_story"]
			local var_257_1 = 0

			if var_257_1 < arg_254_1.time_ and arg_254_1.time_ <= var_257_1 + arg_257_0 and not isNil(var_257_0) and arg_254_1.var_.characterEffect1011ui_story == nil then
				arg_254_1.var_.characterEffect1011ui_story = var_257_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_257_2 = 0.2

			if var_257_1 <= arg_254_1.time_ and arg_254_1.time_ < var_257_1 + var_257_2 and not isNil(var_257_0) then
				local var_257_3 = (arg_254_1.time_ - var_257_1) / var_257_2

				if arg_254_1.var_.characterEffect1011ui_story and not isNil(var_257_0) then
					local var_257_4 = Mathf.Lerp(0, 0.5, var_257_3)

					arg_254_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_254_1.var_.characterEffect1011ui_story.fillRatio = var_257_4
				end
			end

			if arg_254_1.time_ >= var_257_1 + var_257_2 and arg_254_1.time_ < var_257_1 + var_257_2 + arg_257_0 and not isNil(var_257_0) and arg_254_1.var_.characterEffect1011ui_story then
				local var_257_5 = 0.5

				arg_254_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_254_1.var_.characterEffect1011ui_story.fillRatio = var_257_5
			end

			local var_257_6 = 0
			local var_257_7 = 0.125

			if var_257_6 < arg_254_1.time_ and arg_254_1.time_ <= var_257_6 + arg_257_0 then
				arg_254_1.talkMaxDuration = 0
				arg_254_1.dialogCg_.alpha = 1

				arg_254_1.dialog_:SetActive(true)
				SetActive(arg_254_1.leftNameGo_, true)

				local var_257_8 = arg_254_1:FormatText(StoryNameCfg[7].name)

				arg_254_1.leftNameTxt_.text = var_257_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_254_1.leftNameTxt_.transform)

				arg_254_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_254_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_254_1:RecordName(arg_254_1.leftNameTxt_.text)
				SetActive(arg_254_1.iconTrs_.gameObject, true)
				arg_254_1.iconController_:SetSelectedState("hero")

				arg_254_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_254_1.callingController_:SetSelectedState("normal")

				arg_254_1.keyicon_.color = Color.New(1, 1, 1)
				arg_254_1.icon_.color = Color.New(1, 1, 1)

				local var_257_9 = arg_254_1:GetWordFromCfg(110152062)
				local var_257_10 = arg_254_1:FormatText(var_257_9.content)

				arg_254_1.text_.text = var_257_10

				LuaForUtil.ClearLinePrefixSymbol(arg_254_1.text_)

				local var_257_11 = 5
				local var_257_12 = utf8.len(var_257_10)
				local var_257_13 = var_257_11 <= 0 and var_257_7 or var_257_7 * (var_257_12 / var_257_11)

				if var_257_13 > 0 and var_257_7 < var_257_13 then
					arg_254_1.talkMaxDuration = var_257_13

					if var_257_13 + var_257_6 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_13 + var_257_6
					end
				end

				arg_254_1.text_.text = var_257_10
				arg_254_1.typewritter.percent = 0

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(false)
				arg_254_1:RecordContent(arg_254_1.text_.text)
			end

			local var_257_14 = math.max(var_257_7, arg_254_1.talkMaxDuration)

			if var_257_6 <= arg_254_1.time_ and arg_254_1.time_ < var_257_6 + var_257_14 then
				arg_254_1.typewritter.percent = (arg_254_1.time_ - var_257_6) / var_257_14

				arg_254_1.typewritter:SetDirty()
			end

			if arg_254_1.time_ >= var_257_6 + var_257_14 and arg_254_1.time_ < var_257_6 + var_257_14 + arg_257_0 then
				arg_254_1.typewritter.percent = 1

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(true)
			end
		end

		arg_254_1.nodeConfigList_ = {}

		arg_254_1:InitPlayNodeList()
	end,
	Play110152063 = function(arg_258_0, arg_258_1)
		arg_258_1.time_ = 0
		arg_258_1.frameCnt_ = 0
		arg_258_1.state_ = "playing"
		arg_258_1.curTalkId_ = 110152063
		arg_258_1.duration_ = 6.33

		local var_258_0 = {
			ja = 6.333,
			ko = 3.8,
			zh = 4.7,
			en = 3.166
		}
		local var_258_1 = manager.audio:GetLocalizationFlag()

		if var_258_0[var_258_1] ~= nil then
			arg_258_1.duration_ = var_258_0[var_258_1]
		end

		SetActive(arg_258_1.tipsGo_, false)

		function arg_258_1.onSingleLineFinish_()
			arg_258_1.onSingleLineUpdate_ = nil
			arg_258_1.onSingleLineFinish_ = nil
			arg_258_1.state_ = "waiting"
			arg_258_1.auto_ = false
		end

		function arg_258_1.playNext_(arg_260_0)
			arg_258_1.onStoryFinished_()
		end

		function arg_258_1.onSingleLineUpdate_(arg_261_0)
			local var_261_0 = 0

			if var_261_0 < arg_258_1.time_ and arg_258_1.time_ <= var_261_0 + arg_261_0 then
				arg_258_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1204cva")
			end

			local var_261_1 = arg_258_1.actors_["1011ui_story"]
			local var_261_2 = 0

			if var_261_2 < arg_258_1.time_ and arg_258_1.time_ <= var_261_2 + arg_261_0 and not isNil(var_261_1) and arg_258_1.var_.characterEffect1011ui_story == nil then
				arg_258_1.var_.characterEffect1011ui_story = var_261_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_261_3 = 0.2

			if var_261_2 <= arg_258_1.time_ and arg_258_1.time_ < var_261_2 + var_261_3 and not isNil(var_261_1) then
				local var_261_4 = (arg_258_1.time_ - var_261_2) / var_261_3

				if arg_258_1.var_.characterEffect1011ui_story and not isNil(var_261_1) then
					arg_258_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_258_1.time_ >= var_261_2 + var_261_3 and arg_258_1.time_ < var_261_2 + var_261_3 + arg_261_0 and not isNil(var_261_1) and arg_258_1.var_.characterEffect1011ui_story then
				arg_258_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_261_5 = 0
			local var_261_6 = 0.25

			if var_261_5 < arg_258_1.time_ and arg_258_1.time_ <= var_261_5 + arg_261_0 then
				arg_258_1.talkMaxDuration = 0
				arg_258_1.dialogCg_.alpha = 1

				arg_258_1.dialog_:SetActive(true)
				SetActive(arg_258_1.leftNameGo_, true)

				local var_261_7 = arg_258_1:FormatText(StoryNameCfg[37].name)

				arg_258_1.leftNameTxt_.text = var_261_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_258_1.leftNameTxt_.transform)

				arg_258_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_258_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_258_1:RecordName(arg_258_1.leftNameTxt_.text)
				SetActive(arg_258_1.iconTrs_.gameObject, false)
				arg_258_1.callingController_:SetSelectedState("normal")

				local var_261_8 = arg_258_1:GetWordFromCfg(110152063)
				local var_261_9 = arg_258_1:FormatText(var_261_8.content)

				arg_258_1.text_.text = var_261_9

				LuaForUtil.ClearLinePrefixSymbol(arg_258_1.text_)

				local var_261_10 = 10
				local var_261_11 = utf8.len(var_261_9)
				local var_261_12 = var_261_10 <= 0 and var_261_6 or var_261_6 * (var_261_11 / var_261_10)

				if var_261_12 > 0 and var_261_6 < var_261_12 then
					arg_258_1.talkMaxDuration = var_261_12

					if var_261_12 + var_261_5 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_12 + var_261_5
					end
				end

				arg_258_1.text_.text = var_261_9
				arg_258_1.typewritter.percent = 0

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_110152", "110152063", "story_v_out_110152.awb") ~= 0 then
					local var_261_13 = manager.audio:GetVoiceLength("story_v_out_110152", "110152063", "story_v_out_110152.awb") / 1000

					if var_261_13 + var_261_5 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_13 + var_261_5
					end

					if var_261_8.prefab_name ~= "" and arg_258_1.actors_[var_261_8.prefab_name] ~= nil then
						local var_261_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_258_1.actors_[var_261_8.prefab_name].transform, "story_v_out_110152", "110152063", "story_v_out_110152.awb")

						arg_258_1:RecordAudio("110152063", var_261_14)
						arg_258_1:RecordAudio("110152063", var_261_14)
					else
						arg_258_1:AudioAction("play", "voice", "story_v_out_110152", "110152063", "story_v_out_110152.awb")
					end

					arg_258_1:RecordHistoryTalkVoice("story_v_out_110152", "110152063", "story_v_out_110152.awb")
				end

				arg_258_1:RecordContent(arg_258_1.text_.text)
			end

			local var_261_15 = math.max(var_261_6, arg_258_1.talkMaxDuration)

			if var_261_5 <= arg_258_1.time_ and arg_258_1.time_ < var_261_5 + var_261_15 then
				arg_258_1.typewritter.percent = (arg_258_1.time_ - var_261_5) / var_261_15

				arg_258_1.typewritter:SetDirty()
			end

			if arg_258_1.time_ >= var_261_5 + var_261_15 and arg_258_1.time_ < var_261_5 + var_261_15 + arg_261_0 then
				arg_258_1.typewritter.percent = 1

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(true)
			end
		end

		arg_258_1.nodeConfigList_ = {}

		arg_258_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/B12a"
	},
	voices = {
		"story_v_out_110152.awb"
	}
}
