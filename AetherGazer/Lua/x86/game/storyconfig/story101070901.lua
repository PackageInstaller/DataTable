return {
	Play107091001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 107091001
		arg_1_1.duration_ = 12.03

		local var_1_0 = {
			ja = 9.766,
			ko = 11.2,
			zh = 10.666,
			en = 12.033
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
				arg_1_0:Play107091002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "1038ui_story"

			if arg_1_1.actors_[var_4_0] == nil then
				local var_4_1 = Asset.Load("Char/" .. "1038ui_story")

				if not isNil(var_4_1) then
					local var_4_2 = Object.Instantiate(Asset.Load("Char/" .. "1038ui_story"), arg_1_1.stage_.transform)

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

			local var_4_5 = arg_1_1.actors_["1038ui_story"]
			local var_4_6 = 1.8

			if var_4_6 < arg_1_1.time_ and arg_1_1.time_ <= var_4_6 + arg_4_0 and not isNil(var_4_5) and arg_1_1.var_.characterEffect1038ui_story == nil then
				arg_1_1.var_.characterEffect1038ui_story = var_4_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_7 = 0.1

			if var_4_6 <= arg_1_1.time_ and arg_1_1.time_ < var_4_6 + var_4_7 and not isNil(var_4_5) then
				local var_4_8 = (arg_1_1.time_ - var_4_6) / var_4_7

				if arg_1_1.var_.characterEffect1038ui_story and not isNil(var_4_5) then
					arg_1_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= var_4_6 + var_4_7 and arg_1_1.time_ < var_4_6 + var_4_7 + arg_4_0 and not isNil(var_4_5) and arg_1_1.var_.characterEffect1038ui_story then
				arg_1_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_4_9 = "C06b"

			if arg_1_1.bgs_[var_4_9] == nil then
				local var_4_10 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_10:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_9)
				var_4_10.name = var_4_9
				var_4_10.transform.parent = arg_1_1.stage_.transform
				var_4_10.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_9] = var_4_10
			end

			local var_4_11 = 0

			if var_4_11 < arg_1_1.time_ and arg_1_1.time_ <= var_4_11 + arg_4_0 then
				local var_4_12 = manager.ui.mainCamera.transform.localPosition
				local var_4_13 = Vector3.New(0, 0, 10) + Vector3.New(var_4_12.x, var_4_12.y, 0)
				local var_4_14 = arg_1_1.bgs_.C06b

				var_4_14.transform.localPosition = var_4_13
				var_4_14.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_15 = var_4_14:GetComponent("SpriteRenderer")

				if var_4_15 and var_4_15.sprite then
					local var_4_16 = (var_4_14.transform.localPosition - var_4_12).z
					local var_4_17 = manager.ui.mainCameraCom_
					local var_4_18 = 2 * var_4_16 * Mathf.Tan(var_4_17.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_4_19 = var_4_18 * var_4_17.aspect
					local var_4_20 = var_4_15.sprite.bounds.size.x
					local var_4_21 = var_4_15.sprite.bounds.size.y
					local var_4_22 = var_4_19 / var_4_20
					local var_4_23 = var_4_18 / var_4_21
					local var_4_24 = var_4_23 < var_4_22 and var_4_22 or var_4_23

					var_4_14.transform.localScale = Vector3.New(var_4_24, var_4_24, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "C06b" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_25 = arg_1_1.actors_["1038ui_story"].transform
			local var_4_26 = 1.8

			if var_4_26 < arg_1_1.time_ and arg_1_1.time_ <= var_4_26 + arg_4_0 then
				arg_1_1.var_.moveOldPos1038ui_story = var_4_25.localPosition
			end

			local var_4_27 = 0.001

			if var_4_26 <= arg_1_1.time_ and arg_1_1.time_ < var_4_26 + var_4_27 then
				local var_4_28 = (arg_1_1.time_ - var_4_26) / var_4_27
				local var_4_29 = Vector3.New(0, -1.11, -5.9)

				var_4_25.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1038ui_story, var_4_29, var_4_28)

				local var_4_30 = manager.ui.mainCamera.transform.position - var_4_25.position

				var_4_25.forward = Vector3.New(var_4_30.x, var_4_30.y, var_4_30.z)

				local var_4_31 = var_4_25.localEulerAngles

				var_4_31.z = 0
				var_4_31.x = 0
				var_4_25.localEulerAngles = var_4_31
			end

			if arg_1_1.time_ >= var_4_26 + var_4_27 and arg_1_1.time_ < var_4_26 + var_4_27 + arg_4_0 then
				var_4_25.localPosition = Vector3.New(0, -1.11, -5.9)

				local var_4_32 = manager.ui.mainCamera.transform.position - var_4_25.position

				var_4_25.forward = Vector3.New(var_4_32.x, var_4_32.y, var_4_32.z)

				local var_4_33 = var_4_25.localEulerAngles

				var_4_33.z = 0
				var_4_33.x = 0
				var_4_25.localEulerAngles = var_4_33
			end

			local var_4_34 = 1.8

			if var_4_34 < arg_1_1.time_ and arg_1_1.time_ <= var_4_34 + arg_4_0 then
				arg_1_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038action/1038pick1")
			end

			local var_4_35 = arg_1_1.bgs_.C06b
			local var_4_36 = 0

			if var_4_36 < arg_1_1.time_ and arg_1_1.time_ <= var_4_36 + arg_4_0 then
				local var_4_37 = var_4_35:GetComponent("SpriteRenderer")

				if var_4_37 then
					arg_1_1.var_.alphaOldValueC06b = var_4_37.color.a
					arg_1_1.var_.alphaMatValueC06b = var_4_37
				end

				arg_1_1.var_.alphaOldValueC06b = 0
			end

			local var_4_38 = 1.5

			if var_4_36 <= arg_1_1.time_ and arg_1_1.time_ < var_4_36 + var_4_38 then
				local var_4_39 = (arg_1_1.time_ - var_4_36) / var_4_38
				local var_4_40 = Mathf.Lerp(arg_1_1.var_.alphaOldValueC06b, 1, var_4_39)

				if arg_1_1.var_.alphaMatValueC06b then
					local var_4_41 = arg_1_1.var_.alphaMatValueC06b.color

					var_4_41.a = var_4_40
					arg_1_1.var_.alphaMatValueC06b.color = var_4_41
				end
			end

			if arg_1_1.time_ >= var_4_36 + var_4_38 and arg_1_1.time_ < var_4_36 + var_4_38 + arg_4_0 and arg_1_1.var_.alphaMatValueC06b then
				local var_4_42 = arg_1_1.var_.alphaMatValueC06b
				local var_4_43 = var_4_42.color

				var_4_43.a = 1
				var_4_42.color = var_4_43
			end

			local var_4_44 = 0
			local var_4_45 = 1

			if var_4_44 < arg_1_1.time_ and arg_1_1.time_ <= var_4_44 + arg_4_0 then
				local var_4_46 = "play"
				local var_4_47 = "music"

				arg_1_1:AudioAction(var_4_46, var_4_47, "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1.awb")

				local var_4_48 = ""
				local var_4_49 = manager.audio:GetAudioName("bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1")

				if var_4_49 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_49 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_49

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_49
						arg_1_1.bgmTxt2_.text = var_4_49
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

			local var_4_50 = 0

			if var_4_50 < arg_1_1.time_ and arg_1_1.time_ <= var_4_50 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_51 = 2

			if arg_1_1.time_ >= var_4_50 + var_4_51 and arg_1_1.time_ < var_4_50 + var_4_51 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_52 = 0

			if var_4_52 < arg_1_1.time_ and arg_1_1.time_ <= var_4_52 + arg_4_0 then
				arg_1_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_53 = 2
			local var_4_54 = 0.925

			if var_4_53 < arg_1_1.time_ and arg_1_1.time_ <= var_4_53 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_55 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_55:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_55:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_55:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_56 = arg_1_1:FormatText(StoryNameCfg[94].name)

				arg_1_1.leftNameTxt_.text = var_4_56

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_57 = arg_1_1:GetWordFromCfg(107091001)
				local var_4_58 = arg_1_1:FormatText(var_4_57.content)

				arg_1_1.text_.text = var_4_58

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_59 = 37
				local var_4_60 = utf8.len(var_4_58)
				local var_4_61 = var_4_59 <= 0 and var_4_54 or var_4_54 * (var_4_60 / var_4_59)

				if var_4_61 > 0 and var_4_54 < var_4_61 then
					arg_1_1.talkMaxDuration = var_4_61
					var_4_53 = var_4_53 + 0.3

					if var_4_61 + var_4_53 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_61 + var_4_53
					end
				end

				arg_1_1.text_.text = var_4_58
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107091", "107091001", "story_v_out_107091.awb") ~= 0 then
					local var_4_62 = manager.audio:GetVoiceLength("story_v_out_107091", "107091001", "story_v_out_107091.awb") / 1000

					if var_4_62 + var_4_53 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_62 + var_4_53
					end

					if var_4_57.prefab_name ~= "" and arg_1_1.actors_[var_4_57.prefab_name] ~= nil then
						local var_4_63 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_57.prefab_name].transform, "story_v_out_107091", "107091001", "story_v_out_107091.awb")

						arg_1_1:RecordAudio("107091001", var_4_63)
						arg_1_1:RecordAudio("107091001", var_4_63)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_107091", "107091001", "story_v_out_107091.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_107091", "107091001", "story_v_out_107091.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_64 = var_4_53 + 0.3
			local var_4_65 = math.max(var_4_54, arg_1_1.talkMaxDuration)

			if var_4_64 <= arg_1_1.time_ and arg_1_1.time_ < var_4_64 + var_4_65 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_64) / var_4_65

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_64 + var_4_65 and arg_1_1.time_ < var_4_64 + var_4_65 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 1.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play107091002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 107091002
		arg_8_1.duration_ = 13.3

		local var_8_0 = {
			ja = 13.3,
			ko = 7,
			zh = 8.033,
			en = 11.366
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
				arg_8_0:Play107091003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0

			if var_11_0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_0 + arg_11_0 then
				arg_8_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038action/1038action5_1")
			end

			local var_11_1 = 0

			if var_11_1 < arg_8_1.time_ and arg_8_1.time_ <= var_11_1 + arg_11_0 then
				arg_8_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_11_2 = 0
			local var_11_3 = 0.875

			if var_11_2 < arg_8_1.time_ and arg_8_1.time_ <= var_11_2 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				local var_11_4 = arg_8_1:FormatText(StoryNameCfg[94].name)

				arg_8_1.leftNameTxt_.text = var_11_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_5 = arg_8_1:GetWordFromCfg(107091002)
				local var_11_6 = arg_8_1:FormatText(var_11_5.content)

				arg_8_1.text_.text = var_11_6

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_7 = 35
				local var_11_8 = utf8.len(var_11_6)
				local var_11_9 = var_11_7 <= 0 and var_11_3 or var_11_3 * (var_11_8 / var_11_7)

				if var_11_9 > 0 and var_11_3 < var_11_9 then
					arg_8_1.talkMaxDuration = var_11_9

					if var_11_9 + var_11_2 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_9 + var_11_2
					end
				end

				arg_8_1.text_.text = var_11_6
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107091", "107091002", "story_v_out_107091.awb") ~= 0 then
					local var_11_10 = manager.audio:GetVoiceLength("story_v_out_107091", "107091002", "story_v_out_107091.awb") / 1000

					if var_11_10 + var_11_2 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_10 + var_11_2
					end

					if var_11_5.prefab_name ~= "" and arg_8_1.actors_[var_11_5.prefab_name] ~= nil then
						local var_11_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_5.prefab_name].transform, "story_v_out_107091", "107091002", "story_v_out_107091.awb")

						arg_8_1:RecordAudio("107091002", var_11_11)
						arg_8_1:RecordAudio("107091002", var_11_11)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_107091", "107091002", "story_v_out_107091.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_107091", "107091002", "story_v_out_107091.awb")
				end

				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_12 = math.max(var_11_3, arg_8_1.talkMaxDuration)

			if var_11_2 <= arg_8_1.time_ and arg_8_1.time_ < var_11_2 + var_11_12 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_2) / var_11_12

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_2 + var_11_12 and arg_8_1.time_ < var_11_2 + var_11_12 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play107091003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 107091003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play107091004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = arg_12_1.actors_["1038ui_story"]
			local var_15_1 = 0

			if var_15_1 < arg_12_1.time_ and arg_12_1.time_ <= var_15_1 + arg_15_0 and not isNil(var_15_0) and arg_12_1.var_.characterEffect1038ui_story == nil then
				arg_12_1.var_.characterEffect1038ui_story = var_15_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_2 = 0.1

			if var_15_1 <= arg_12_1.time_ and arg_12_1.time_ < var_15_1 + var_15_2 and not isNil(var_15_0) then
				local var_15_3 = (arg_12_1.time_ - var_15_1) / var_15_2

				if arg_12_1.var_.characterEffect1038ui_story and not isNil(var_15_0) then
					local var_15_4 = Mathf.Lerp(0, 0.5, var_15_3)

					arg_12_1.var_.characterEffect1038ui_story.fillFlat = true
					arg_12_1.var_.characterEffect1038ui_story.fillRatio = var_15_4
				end
			end

			if arg_12_1.time_ >= var_15_1 + var_15_2 and arg_12_1.time_ < var_15_1 + var_15_2 + arg_15_0 and not isNil(var_15_0) and arg_12_1.var_.characterEffect1038ui_story then
				local var_15_5 = 0.5

				arg_12_1.var_.characterEffect1038ui_story.fillFlat = true
				arg_12_1.var_.characterEffect1038ui_story.fillRatio = var_15_5
			end

			local var_15_6 = 0
			local var_15_7 = 0.075

			if var_15_6 < arg_12_1.time_ and arg_12_1.time_ <= var_15_6 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				local var_15_8 = arg_12_1:FormatText(StoryNameCfg[7].name)

				arg_12_1.leftNameTxt_.text = var_15_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, true)
				arg_12_1.iconController_:SetSelectedState("hero")

				arg_12_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_12_1.callingController_:SetSelectedState("normal")

				arg_12_1.keyicon_.color = Color.New(1, 1, 1)
				arg_12_1.icon_.color = Color.New(1, 1, 1)

				local var_15_9 = arg_12_1:GetWordFromCfg(107091003)
				local var_15_10 = arg_12_1:FormatText(var_15_9.content)

				arg_12_1.text_.text = var_15_10

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_11 = 3
				local var_15_12 = utf8.len(var_15_10)
				local var_15_13 = var_15_11 <= 0 and var_15_7 or var_15_7 * (var_15_12 / var_15_11)

				if var_15_13 > 0 and var_15_7 < var_15_13 then
					arg_12_1.talkMaxDuration = var_15_13

					if var_15_13 + var_15_6 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_13 + var_15_6
					end
				end

				arg_12_1.text_.text = var_15_10
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)
				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_14 = math.max(var_15_7, arg_12_1.talkMaxDuration)

			if var_15_6 <= arg_12_1.time_ and arg_12_1.time_ < var_15_6 + var_15_14 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_6) / var_15_14

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_6 + var_15_14 and arg_12_1.time_ < var_15_6 + var_15_14 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play107091004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 107091004
		arg_16_1.duration_ = 5

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play107091005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = 0
			local var_19_1 = 1.25

			if var_19_0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_0 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, false)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_2 = arg_16_1:GetWordFromCfg(107091004)
				local var_19_3 = arg_16_1:FormatText(var_19_2.content)

				arg_16_1.text_.text = var_19_3

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_4 = 50
				local var_19_5 = utf8.len(var_19_3)
				local var_19_6 = var_19_4 <= 0 and var_19_1 or var_19_1 * (var_19_5 / var_19_4)

				if var_19_6 > 0 and var_19_1 < var_19_6 then
					arg_16_1.talkMaxDuration = var_19_6

					if var_19_6 + var_19_0 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_6 + var_19_0
					end
				end

				arg_16_1.text_.text = var_19_3
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)
				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_7 = math.max(var_19_1, arg_16_1.talkMaxDuration)

			if var_19_0 <= arg_16_1.time_ and arg_16_1.time_ < var_19_0 + var_19_7 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_0) / var_19_7

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_0 + var_19_7 and arg_16_1.time_ < var_19_0 + var_19_7 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play107091005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 107091005
		arg_20_1.duration_ = 5

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play107091006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = arg_20_1.actors_["1038ui_story"].transform
			local var_23_1 = 0

			if var_23_1 < arg_20_1.time_ and arg_20_1.time_ <= var_23_1 + arg_23_0 then
				arg_20_1.var_.moveOldPos1038ui_story = var_23_0.localPosition
			end

			local var_23_2 = 0.001

			if var_23_1 <= arg_20_1.time_ and arg_20_1.time_ < var_23_1 + var_23_2 then
				local var_23_3 = (arg_20_1.time_ - var_23_1) / var_23_2
				local var_23_4 = Vector3.New(0, 100, 0)

				var_23_0.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos1038ui_story, var_23_4, var_23_3)

				local var_23_5 = manager.ui.mainCamera.transform.position - var_23_0.position

				var_23_0.forward = Vector3.New(var_23_5.x, var_23_5.y, var_23_5.z)

				local var_23_6 = var_23_0.localEulerAngles

				var_23_6.z = 0
				var_23_6.x = 0
				var_23_0.localEulerAngles = var_23_6
			end

			if arg_20_1.time_ >= var_23_1 + var_23_2 and arg_20_1.time_ < var_23_1 + var_23_2 + arg_23_0 then
				var_23_0.localPosition = Vector3.New(0, 100, 0)

				local var_23_7 = manager.ui.mainCamera.transform.position - var_23_0.position

				var_23_0.forward = Vector3.New(var_23_7.x, var_23_7.y, var_23_7.z)

				local var_23_8 = var_23_0.localEulerAngles

				var_23_8.z = 0
				var_23_8.x = 0
				var_23_0.localEulerAngles = var_23_8
			end

			local var_23_9 = 0
			local var_23_10 = 0.375

			if var_23_9 < arg_20_1.time_ and arg_20_1.time_ <= var_23_9 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				local var_23_11 = arg_20_1:FormatText(StoryNameCfg[7].name)

				arg_20_1.leftNameTxt_.text = var_23_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, true)
				arg_20_1.iconController_:SetSelectedState("hero")

				arg_20_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_20_1.callingController_:SetSelectedState("normal")

				arg_20_1.keyicon_.color = Color.New(1, 1, 1)
				arg_20_1.icon_.color = Color.New(1, 1, 1)

				local var_23_12 = arg_20_1:GetWordFromCfg(107091005)
				local var_23_13 = arg_20_1:FormatText(var_23_12.content)

				arg_20_1.text_.text = var_23_13

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_14 = 15
				local var_23_15 = utf8.len(var_23_13)
				local var_23_16 = var_23_14 <= 0 and var_23_10 or var_23_10 * (var_23_15 / var_23_14)

				if var_23_16 > 0 and var_23_10 < var_23_16 then
					arg_20_1.talkMaxDuration = var_23_16

					if var_23_16 + var_23_9 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_16 + var_23_9
					end
				end

				arg_20_1.text_.text = var_23_13
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)
				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_17 = math.max(var_23_10, arg_20_1.talkMaxDuration)

			if var_23_9 <= arg_20_1.time_ and arg_20_1.time_ < var_23_9 + var_23_17 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_9) / var_23_17

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_9 + var_23_17 and arg_20_1.time_ < var_23_9 + var_23_17 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {
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

		arg_20_1:InitPlayNodeList()
	end,
	Play107091006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 107091006
		arg_24_1.duration_ = 14.57

		local var_24_0 = {
			ja = 14.566,
			ko = 7.666,
			zh = 8.1,
			en = 12.333
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
				arg_24_0:Play107091007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = "1084ui_story"

			if arg_24_1.actors_[var_27_0] == nil then
				local var_27_1 = Asset.Load("Char/" .. "1084ui_story")

				if not isNil(var_27_1) then
					local var_27_2 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_24_1.stage_.transform)

					var_27_2.name = var_27_0
					var_27_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_24_1.actors_[var_27_0] = var_27_2

					local var_27_3 = var_27_2:GetComponentInChildren(typeof(CharacterEffect))

					var_27_3.enabled = true

					local var_27_4 = GameObjectTools.GetOrAddComponent(var_27_2, typeof(DynamicBoneHelper))

					if var_27_4 then
						var_27_4:EnableDynamicBone(false)
					end

					arg_24_1:ShowWeapon(var_27_3.transform, false)

					arg_24_1.var_[var_27_0 .. "Animator"] = var_27_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_24_1.var_[var_27_0 .. "Animator"].applyRootMotion = true
					arg_24_1.var_[var_27_0 .. "LipSync"] = var_27_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_27_5 = arg_24_1.actors_["1084ui_story"]
			local var_27_6 = 0

			if var_27_6 < arg_24_1.time_ and arg_24_1.time_ <= var_27_6 + arg_27_0 and not isNil(var_27_5) and arg_24_1.var_.characterEffect1084ui_story == nil then
				arg_24_1.var_.characterEffect1084ui_story = var_27_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_7 = 0.1

			if var_27_6 <= arg_24_1.time_ and arg_24_1.time_ < var_27_6 + var_27_7 and not isNil(var_27_5) then
				local var_27_8 = (arg_24_1.time_ - var_27_6) / var_27_7

				if arg_24_1.var_.characterEffect1084ui_story and not isNil(var_27_5) then
					arg_24_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_24_1.time_ >= var_27_6 + var_27_7 and arg_24_1.time_ < var_27_6 + var_27_7 + arg_27_0 and not isNil(var_27_5) and arg_24_1.var_.characterEffect1084ui_story then
				arg_24_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_27_9 = arg_24_1.actors_["1084ui_story"].transform
			local var_27_10 = 0

			if var_27_10 < arg_24_1.time_ and arg_24_1.time_ <= var_27_10 + arg_27_0 then
				arg_24_1.var_.moveOldPos1084ui_story = var_27_9.localPosition
			end

			local var_27_11 = 0.001

			if var_27_10 <= arg_24_1.time_ and arg_24_1.time_ < var_27_10 + var_27_11 then
				local var_27_12 = (arg_24_1.time_ - var_27_10) / var_27_11
				local var_27_13 = Vector3.New(0, -0.97, -6)

				var_27_9.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos1084ui_story, var_27_13, var_27_12)

				local var_27_14 = manager.ui.mainCamera.transform.position - var_27_9.position

				var_27_9.forward = Vector3.New(var_27_14.x, var_27_14.y, var_27_14.z)

				local var_27_15 = var_27_9.localEulerAngles

				var_27_15.z = 0
				var_27_15.x = 0
				var_27_9.localEulerAngles = var_27_15
			end

			if arg_24_1.time_ >= var_27_10 + var_27_11 and arg_24_1.time_ < var_27_10 + var_27_11 + arg_27_0 then
				var_27_9.localPosition = Vector3.New(0, -0.97, -6)

				local var_27_16 = manager.ui.mainCamera.transform.position - var_27_9.position

				var_27_9.forward = Vector3.New(var_27_16.x, var_27_16.y, var_27_16.z)

				local var_27_17 = var_27_9.localEulerAngles

				var_27_17.z = 0
				var_27_17.x = 0
				var_27_9.localEulerAngles = var_27_17
			end

			local var_27_18 = 0

			if var_27_18 < arg_24_1.time_ and arg_24_1.time_ <= var_27_18 + arg_27_0 then
				arg_24_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action6_1")
			end

			local var_27_19 = 0

			if var_27_19 < arg_24_1.time_ and arg_24_1.time_ <= var_27_19 + arg_27_0 then
				arg_24_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038action/1038action5_1")
			end

			local var_27_20 = 0

			if var_27_20 < arg_24_1.time_ and arg_24_1.time_ <= var_27_20 + arg_27_0 then
				arg_24_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_27_21 = 0
			local var_27_22 = 0.85

			if var_27_21 < arg_24_1.time_ and arg_24_1.time_ <= var_27_21 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				local var_27_23 = arg_24_1:FormatText(StoryNameCfg[6].name)

				arg_24_1.leftNameTxt_.text = var_27_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_24 = arg_24_1:GetWordFromCfg(107091006)
				local var_27_25 = arg_24_1:FormatText(var_27_24.content)

				arg_24_1.text_.text = var_27_25

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_26 = 34
				local var_27_27 = utf8.len(var_27_25)
				local var_27_28 = var_27_26 <= 0 and var_27_22 or var_27_22 * (var_27_27 / var_27_26)

				if var_27_28 > 0 and var_27_22 < var_27_28 then
					arg_24_1.talkMaxDuration = var_27_28

					if var_27_28 + var_27_21 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_28 + var_27_21
					end
				end

				arg_24_1.text_.text = var_27_25
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107091", "107091006", "story_v_out_107091.awb") ~= 0 then
					local var_27_29 = manager.audio:GetVoiceLength("story_v_out_107091", "107091006", "story_v_out_107091.awb") / 1000

					if var_27_29 + var_27_21 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_29 + var_27_21
					end

					if var_27_24.prefab_name ~= "" and arg_24_1.actors_[var_27_24.prefab_name] ~= nil then
						local var_27_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_24.prefab_name].transform, "story_v_out_107091", "107091006", "story_v_out_107091.awb")

						arg_24_1:RecordAudio("107091006", var_27_30)
						arg_24_1:RecordAudio("107091006", var_27_30)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_107091", "107091006", "story_v_out_107091.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_107091", "107091006", "story_v_out_107091.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_31 = math.max(var_27_22, arg_24_1.talkMaxDuration)

			if var_27_21 <= arg_24_1.time_ and arg_24_1.time_ < var_27_21 + var_27_31 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_21) / var_27_31

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_21 + var_27_31 and arg_24_1.time_ < var_27_21 + var_27_31 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
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
	Play107091007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 107091007
		arg_28_1.duration_ = 2

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play107091008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = arg_28_1.actors_["1038ui_story"]
			local var_31_1 = 0

			if var_31_1 < arg_28_1.time_ and arg_28_1.time_ <= var_31_1 + arg_31_0 and not isNil(var_31_0) and arg_28_1.var_.characterEffect1038ui_story == nil then
				arg_28_1.var_.characterEffect1038ui_story = var_31_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_2 = 0.1

			if var_31_1 <= arg_28_1.time_ and arg_28_1.time_ < var_31_1 + var_31_2 and not isNil(var_31_0) then
				local var_31_3 = (arg_28_1.time_ - var_31_1) / var_31_2

				if arg_28_1.var_.characterEffect1038ui_story and not isNil(var_31_0) then
					arg_28_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_28_1.time_ >= var_31_1 + var_31_2 and arg_28_1.time_ < var_31_1 + var_31_2 + arg_31_0 and not isNil(var_31_0) and arg_28_1.var_.characterEffect1038ui_story then
				arg_28_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_31_4 = arg_28_1.actors_["1084ui_story"]
			local var_31_5 = 0

			if var_31_5 < arg_28_1.time_ and arg_28_1.time_ <= var_31_5 + arg_31_0 and not isNil(var_31_4) and arg_28_1.var_.characterEffect1084ui_story == nil then
				arg_28_1.var_.characterEffect1084ui_story = var_31_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_6 = 0.1

			if var_31_5 <= arg_28_1.time_ and arg_28_1.time_ < var_31_5 + var_31_6 and not isNil(var_31_4) then
				local var_31_7 = (arg_28_1.time_ - var_31_5) / var_31_6

				if arg_28_1.var_.characterEffect1084ui_story and not isNil(var_31_4) then
					local var_31_8 = Mathf.Lerp(0, 0.5, var_31_7)

					arg_28_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_28_1.var_.characterEffect1084ui_story.fillRatio = var_31_8
				end
			end

			if arg_28_1.time_ >= var_31_5 + var_31_6 and arg_28_1.time_ < var_31_5 + var_31_6 + arg_31_0 and not isNil(var_31_4) and arg_28_1.var_.characterEffect1084ui_story then
				local var_31_9 = 0.5

				arg_28_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_28_1.var_.characterEffect1084ui_story.fillRatio = var_31_9
			end

			local var_31_10 = arg_28_1.actors_["1084ui_story"].transform
			local var_31_11 = 0

			if var_31_11 < arg_28_1.time_ and arg_28_1.time_ <= var_31_11 + arg_31_0 then
				arg_28_1.var_.moveOldPos1084ui_story = var_31_10.localPosition
			end

			local var_31_12 = 0.001

			if var_31_11 <= arg_28_1.time_ and arg_28_1.time_ < var_31_11 + var_31_12 then
				local var_31_13 = (arg_28_1.time_ - var_31_11) / var_31_12
				local var_31_14 = Vector3.New(0, 100, 0)

				var_31_10.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos1084ui_story, var_31_14, var_31_13)

				local var_31_15 = manager.ui.mainCamera.transform.position - var_31_10.position

				var_31_10.forward = Vector3.New(var_31_15.x, var_31_15.y, var_31_15.z)

				local var_31_16 = var_31_10.localEulerAngles

				var_31_16.z = 0
				var_31_16.x = 0
				var_31_10.localEulerAngles = var_31_16
			end

			if arg_28_1.time_ >= var_31_11 + var_31_12 and arg_28_1.time_ < var_31_11 + var_31_12 + arg_31_0 then
				var_31_10.localPosition = Vector3.New(0, 100, 0)

				local var_31_17 = manager.ui.mainCamera.transform.position - var_31_10.position

				var_31_10.forward = Vector3.New(var_31_17.x, var_31_17.y, var_31_17.z)

				local var_31_18 = var_31_10.localEulerAngles

				var_31_18.z = 0
				var_31_18.x = 0
				var_31_10.localEulerAngles = var_31_18
			end

			local var_31_19 = arg_28_1.actors_["1038ui_story"].transform
			local var_31_20 = 0

			if var_31_20 < arg_28_1.time_ and arg_28_1.time_ <= var_31_20 + arg_31_0 then
				arg_28_1.var_.moveOldPos1038ui_story = var_31_19.localPosition
			end

			local var_31_21 = 0.001

			if var_31_20 <= arg_28_1.time_ and arg_28_1.time_ < var_31_20 + var_31_21 then
				local var_31_22 = (arg_28_1.time_ - var_31_20) / var_31_21
				local var_31_23 = Vector3.New(0, -1.11, -5.9)

				var_31_19.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos1038ui_story, var_31_23, var_31_22)

				local var_31_24 = manager.ui.mainCamera.transform.position - var_31_19.position

				var_31_19.forward = Vector3.New(var_31_24.x, var_31_24.y, var_31_24.z)

				local var_31_25 = var_31_19.localEulerAngles

				var_31_25.z = 0
				var_31_25.x = 0
				var_31_19.localEulerAngles = var_31_25
			end

			if arg_28_1.time_ >= var_31_20 + var_31_21 and arg_28_1.time_ < var_31_20 + var_31_21 + arg_31_0 then
				var_31_19.localPosition = Vector3.New(0, -1.11, -5.9)

				local var_31_26 = manager.ui.mainCamera.transform.position - var_31_19.position

				var_31_19.forward = Vector3.New(var_31_26.x, var_31_26.y, var_31_26.z)

				local var_31_27 = var_31_19.localEulerAngles

				var_31_27.z = 0
				var_31_27.x = 0
				var_31_19.localEulerAngles = var_31_27
			end

			local var_31_28 = 0

			if var_31_28 < arg_28_1.time_ and arg_28_1.time_ <= var_31_28 + arg_31_0 then
				arg_28_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0201cva")
			end

			local var_31_29 = 0
			local var_31_30 = 0.05

			if var_31_29 < arg_28_1.time_ and arg_28_1.time_ <= var_31_29 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				local var_31_31 = arg_28_1:FormatText(StoryNameCfg[94].name)

				arg_28_1.leftNameTxt_.text = var_31_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_32 = arg_28_1:GetWordFromCfg(107091007)
				local var_31_33 = arg_28_1:FormatText(var_31_32.content)

				arg_28_1.text_.text = var_31_33

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_34 = 2
				local var_31_35 = utf8.len(var_31_33)
				local var_31_36 = var_31_34 <= 0 and var_31_30 or var_31_30 * (var_31_35 / var_31_34)

				if var_31_36 > 0 and var_31_30 < var_31_36 then
					arg_28_1.talkMaxDuration = var_31_36

					if var_31_36 + var_31_29 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_36 + var_31_29
					end
				end

				arg_28_1.text_.text = var_31_33
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107091", "107091007", "story_v_out_107091.awb") ~= 0 then
					local var_31_37 = manager.audio:GetVoiceLength("story_v_out_107091", "107091007", "story_v_out_107091.awb") / 1000

					if var_31_37 + var_31_29 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_37 + var_31_29
					end

					if var_31_32.prefab_name ~= "" and arg_28_1.actors_[var_31_32.prefab_name] ~= nil then
						local var_31_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_32.prefab_name].transform, "story_v_out_107091", "107091007", "story_v_out_107091.awb")

						arg_28_1:RecordAudio("107091007", var_31_38)
						arg_28_1:RecordAudio("107091007", var_31_38)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_107091", "107091007", "story_v_out_107091.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_107091", "107091007", "story_v_out_107091.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_39 = math.max(var_31_30, arg_28_1.talkMaxDuration)

			if var_31_29 <= arg_28_1.time_ and arg_28_1.time_ < var_31_29 + var_31_39 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_29) / var_31_39

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_29 + var_31_39 and arg_28_1.time_ < var_31_29 + var_31_39 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_28_1:InitPlayNodeList()
	end,
	Play107091008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 107091008
		arg_32_1.duration_ = 5

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play107091009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = arg_32_1.actors_["1038ui_story"]
			local var_35_1 = 0

			if var_35_1 < arg_32_1.time_ and arg_32_1.time_ <= var_35_1 + arg_35_0 and not isNil(var_35_0) and arg_32_1.var_.characterEffect1038ui_story == nil then
				arg_32_1.var_.characterEffect1038ui_story = var_35_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_2 = 0.1

			if var_35_1 <= arg_32_1.time_ and arg_32_1.time_ < var_35_1 + var_35_2 and not isNil(var_35_0) then
				local var_35_3 = (arg_32_1.time_ - var_35_1) / var_35_2

				if arg_32_1.var_.characterEffect1038ui_story and not isNil(var_35_0) then
					local var_35_4 = Mathf.Lerp(0, 0.5, var_35_3)

					arg_32_1.var_.characterEffect1038ui_story.fillFlat = true
					arg_32_1.var_.characterEffect1038ui_story.fillRatio = var_35_4
				end
			end

			if arg_32_1.time_ >= var_35_1 + var_35_2 and arg_32_1.time_ < var_35_1 + var_35_2 + arg_35_0 and not isNil(var_35_0) and arg_32_1.var_.characterEffect1038ui_story then
				local var_35_5 = 0.5

				arg_32_1.var_.characterEffect1038ui_story.fillFlat = true
				arg_32_1.var_.characterEffect1038ui_story.fillRatio = var_35_5
			end

			local var_35_6 = arg_32_1.actors_["1038ui_story"].transform
			local var_35_7 = 0

			if var_35_7 < arg_32_1.time_ and arg_32_1.time_ <= var_35_7 + arg_35_0 then
				arg_32_1.var_.moveOldPos1038ui_story = var_35_6.localPosition
			end

			local var_35_8 = 0.001

			if var_35_7 <= arg_32_1.time_ and arg_32_1.time_ < var_35_7 + var_35_8 then
				local var_35_9 = (arg_32_1.time_ - var_35_7) / var_35_8
				local var_35_10 = Vector3.New(0, 100, 0)

				var_35_6.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos1038ui_story, var_35_10, var_35_9)

				local var_35_11 = manager.ui.mainCamera.transform.position - var_35_6.position

				var_35_6.forward = Vector3.New(var_35_11.x, var_35_11.y, var_35_11.z)

				local var_35_12 = var_35_6.localEulerAngles

				var_35_12.z = 0
				var_35_12.x = 0
				var_35_6.localEulerAngles = var_35_12
			end

			if arg_32_1.time_ >= var_35_7 + var_35_8 and arg_32_1.time_ < var_35_7 + var_35_8 + arg_35_0 then
				var_35_6.localPosition = Vector3.New(0, 100, 0)

				local var_35_13 = manager.ui.mainCamera.transform.position - var_35_6.position

				var_35_6.forward = Vector3.New(var_35_13.x, var_35_13.y, var_35_13.z)

				local var_35_14 = var_35_6.localEulerAngles

				var_35_14.z = 0
				var_35_14.x = 0
				var_35_6.localEulerAngles = var_35_14
			end

			local var_35_15 = 0
			local var_35_16 = 0.225

			if var_35_15 < arg_32_1.time_ and arg_32_1.time_ <= var_35_15 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				local var_35_17 = arg_32_1:FormatText(StoryNameCfg[7].name)

				arg_32_1.leftNameTxt_.text = var_35_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, true)
				arg_32_1.iconController_:SetSelectedState("hero")

				arg_32_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_32_1.callingController_:SetSelectedState("normal")

				arg_32_1.keyicon_.color = Color.New(1, 1, 1)
				arg_32_1.icon_.color = Color.New(1, 1, 1)

				local var_35_18 = arg_32_1:GetWordFromCfg(107091008)
				local var_35_19 = arg_32_1:FormatText(var_35_18.content)

				arg_32_1.text_.text = var_35_19

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_20 = 9
				local var_35_21 = utf8.len(var_35_19)
				local var_35_22 = var_35_20 <= 0 and var_35_16 or var_35_16 * (var_35_21 / var_35_20)

				if var_35_22 > 0 and var_35_16 < var_35_22 then
					arg_32_1.talkMaxDuration = var_35_22

					if var_35_22 + var_35_15 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_22 + var_35_15
					end
				end

				arg_32_1.text_.text = var_35_19
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)
				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_23 = math.max(var_35_16, arg_32_1.talkMaxDuration)

			if var_35_15 <= arg_32_1.time_ and arg_32_1.time_ < var_35_15 + var_35_23 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_15) / var_35_23

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_15 + var_35_23 and arg_32_1.time_ < var_35_15 + var_35_23 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {
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

		arg_32_1:InitPlayNodeList()
	end,
	Play107091009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 107091009
		arg_36_1.duration_ = 4.83

		local var_36_0 = {
			ja = 4.833,
			ko = 4.033,
			zh = 3.8,
			en = 4.366
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
				arg_36_0:Play107091010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = arg_36_1.actors_["1084ui_story"]
			local var_39_1 = 0

			if var_39_1 < arg_36_1.time_ and arg_36_1.time_ <= var_39_1 + arg_39_0 and not isNil(var_39_0) and arg_36_1.var_.characterEffect1084ui_story == nil then
				arg_36_1.var_.characterEffect1084ui_story = var_39_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_2 = 0.1

			if var_39_1 <= arg_36_1.time_ and arg_36_1.time_ < var_39_1 + var_39_2 and not isNil(var_39_0) then
				local var_39_3 = (arg_36_1.time_ - var_39_1) / var_39_2

				if arg_36_1.var_.characterEffect1084ui_story and not isNil(var_39_0) then
					arg_36_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_36_1.time_ >= var_39_1 + var_39_2 and arg_36_1.time_ < var_39_1 + var_39_2 + arg_39_0 and not isNil(var_39_0) and arg_36_1.var_.characterEffect1084ui_story then
				arg_36_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_39_4 = arg_36_1.actors_["1084ui_story"].transform
			local var_39_5 = 0

			if var_39_5 < arg_36_1.time_ and arg_36_1.time_ <= var_39_5 + arg_39_0 then
				arg_36_1.var_.moveOldPos1084ui_story = var_39_4.localPosition
			end

			local var_39_6 = 0.001

			if var_39_5 <= arg_36_1.time_ and arg_36_1.time_ < var_39_5 + var_39_6 then
				local var_39_7 = (arg_36_1.time_ - var_39_5) / var_39_6
				local var_39_8 = Vector3.New(0, -0.97, -6)

				var_39_4.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos1084ui_story, var_39_8, var_39_7)

				local var_39_9 = manager.ui.mainCamera.transform.position - var_39_4.position

				var_39_4.forward = Vector3.New(var_39_9.x, var_39_9.y, var_39_9.z)

				local var_39_10 = var_39_4.localEulerAngles

				var_39_10.z = 0
				var_39_10.x = 0
				var_39_4.localEulerAngles = var_39_10
			end

			if arg_36_1.time_ >= var_39_5 + var_39_6 and arg_36_1.time_ < var_39_5 + var_39_6 + arg_39_0 then
				var_39_4.localPosition = Vector3.New(0, -0.97, -6)

				local var_39_11 = manager.ui.mainCamera.transform.position - var_39_4.position

				var_39_4.forward = Vector3.New(var_39_11.x, var_39_11.y, var_39_11.z)

				local var_39_12 = var_39_4.localEulerAngles

				var_39_12.z = 0
				var_39_12.x = 0
				var_39_4.localEulerAngles = var_39_12
			end

			local var_39_13 = 0

			if var_39_13 < arg_36_1.time_ and arg_36_1.time_ <= var_39_13 + arg_39_0 then
				arg_36_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action8_1")
			end

			local var_39_14 = 0

			if var_39_14 < arg_36_1.time_ and arg_36_1.time_ <= var_39_14 + arg_39_0 then
				arg_36_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_39_15 = 0
			local var_39_16 = 0.45

			if var_39_15 < arg_36_1.time_ and arg_36_1.time_ <= var_39_15 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				local var_39_17 = arg_36_1:FormatText(StoryNameCfg[6].name)

				arg_36_1.leftNameTxt_.text = var_39_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_18 = arg_36_1:GetWordFromCfg(107091009)
				local var_39_19 = arg_36_1:FormatText(var_39_18.content)

				arg_36_1.text_.text = var_39_19

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_20 = 18
				local var_39_21 = utf8.len(var_39_19)
				local var_39_22 = var_39_20 <= 0 and var_39_16 or var_39_16 * (var_39_21 / var_39_20)

				if var_39_22 > 0 and var_39_16 < var_39_22 then
					arg_36_1.talkMaxDuration = var_39_22

					if var_39_22 + var_39_15 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_22 + var_39_15
					end
				end

				arg_36_1.text_.text = var_39_19
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107091", "107091009", "story_v_out_107091.awb") ~= 0 then
					local var_39_23 = manager.audio:GetVoiceLength("story_v_out_107091", "107091009", "story_v_out_107091.awb") / 1000

					if var_39_23 + var_39_15 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_23 + var_39_15
					end

					if var_39_18.prefab_name ~= "" and arg_36_1.actors_[var_39_18.prefab_name] ~= nil then
						local var_39_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_18.prefab_name].transform, "story_v_out_107091", "107091009", "story_v_out_107091.awb")

						arg_36_1:RecordAudio("107091009", var_39_24)
						arg_36_1:RecordAudio("107091009", var_39_24)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_107091", "107091009", "story_v_out_107091.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_107091", "107091009", "story_v_out_107091.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_25 = math.max(var_39_16, arg_36_1.talkMaxDuration)

			if var_39_15 <= arg_36_1.time_ and arg_36_1.time_ < var_39_15 + var_39_25 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_15) / var_39_25

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_15 + var_39_25 and arg_36_1.time_ < var_39_15 + var_39_25 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_36_1:InitPlayNodeList()
	end,
	Play107091010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 107091010
		arg_40_1.duration_ = 15.43

		local var_40_0 = {
			ja = 15.433,
			ko = 13.033,
			zh = 9.7,
			en = 10.866
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
				arg_40_0:Play107091011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = arg_40_1.actors_["1084ui_story"]
			local var_43_1 = 0

			if var_43_1 < arg_40_1.time_ and arg_40_1.time_ <= var_43_1 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.characterEffect1084ui_story == nil then
				arg_40_1.var_.characterEffect1084ui_story = var_43_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_2 = 0.1

			if var_43_1 <= arg_40_1.time_ and arg_40_1.time_ < var_43_1 + var_43_2 and not isNil(var_43_0) then
				local var_43_3 = (arg_40_1.time_ - var_43_1) / var_43_2

				if arg_40_1.var_.characterEffect1084ui_story and not isNil(var_43_0) then
					local var_43_4 = Mathf.Lerp(0, 0.5, var_43_3)

					arg_40_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_40_1.var_.characterEffect1084ui_story.fillRatio = var_43_4
				end
			end

			if arg_40_1.time_ >= var_43_1 + var_43_2 and arg_40_1.time_ < var_43_1 + var_43_2 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.characterEffect1084ui_story then
				local var_43_5 = 0.5

				arg_40_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_40_1.var_.characterEffect1084ui_story.fillRatio = var_43_5
			end

			local var_43_6 = 0
			local var_43_7 = 1.2

			if var_43_6 < arg_40_1.time_ and arg_40_1.time_ <= var_43_6 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				local var_43_8 = arg_40_1:FormatText(StoryNameCfg[10].name)

				arg_40_1.leftNameTxt_.text = var_43_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, true)
				arg_40_1.iconController_:SetSelectedState("hero")

				arg_40_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_40_1.callingController_:SetSelectedState("normal")

				arg_40_1.keyicon_.color = Color.New(1, 1, 1)
				arg_40_1.icon_.color = Color.New(1, 1, 1)

				local var_43_9 = arg_40_1:GetWordFromCfg(107091010)
				local var_43_10 = arg_40_1:FormatText(var_43_9.content)

				arg_40_1.text_.text = var_43_10

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_11 = 48
				local var_43_12 = utf8.len(var_43_10)
				local var_43_13 = var_43_11 <= 0 and var_43_7 or var_43_7 * (var_43_12 / var_43_11)

				if var_43_13 > 0 and var_43_7 < var_43_13 then
					arg_40_1.talkMaxDuration = var_43_13

					if var_43_13 + var_43_6 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_13 + var_43_6
					end
				end

				arg_40_1.text_.text = var_43_10
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107091", "107091010", "story_v_out_107091.awb") ~= 0 then
					local var_43_14 = manager.audio:GetVoiceLength("story_v_out_107091", "107091010", "story_v_out_107091.awb") / 1000

					if var_43_14 + var_43_6 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_14 + var_43_6
					end

					if var_43_9.prefab_name ~= "" and arg_40_1.actors_[var_43_9.prefab_name] ~= nil then
						local var_43_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_9.prefab_name].transform, "story_v_out_107091", "107091010", "story_v_out_107091.awb")

						arg_40_1:RecordAudio("107091010", var_43_15)
						arg_40_1:RecordAudio("107091010", var_43_15)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_107091", "107091010", "story_v_out_107091.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_107091", "107091010", "story_v_out_107091.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_16 = math.max(var_43_7, arg_40_1.talkMaxDuration)

			if var_43_6 <= arg_40_1.time_ and arg_40_1.time_ < var_43_6 + var_43_16 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_6) / var_43_16

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_6 + var_43_16 and arg_40_1.time_ < var_43_6 + var_43_16 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play107091011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 107091011
		arg_44_1.duration_ = 10.9

		local var_44_0 = {
			ja = 10.9,
			ko = 7.833,
			zh = 6.833,
			en = 9.9
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
				arg_44_0:Play107091012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = 0
			local var_47_1 = 0.8

			if var_47_0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_0 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				local var_47_2 = arg_44_1:FormatText(StoryNameCfg[10].name)

				arg_44_1.leftNameTxt_.text = var_47_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, true)
				arg_44_1.iconController_:SetSelectedState("hero")

				arg_44_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_44_1.callingController_:SetSelectedState("normal")

				arg_44_1.keyicon_.color = Color.New(1, 1, 1)
				arg_44_1.icon_.color = Color.New(1, 1, 1)

				local var_47_3 = arg_44_1:GetWordFromCfg(107091011)
				local var_47_4 = arg_44_1:FormatText(var_47_3.content)

				arg_44_1.text_.text = var_47_4

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_5 = 32
				local var_47_6 = utf8.len(var_47_4)
				local var_47_7 = var_47_5 <= 0 and var_47_1 or var_47_1 * (var_47_6 / var_47_5)

				if var_47_7 > 0 and var_47_1 < var_47_7 then
					arg_44_1.talkMaxDuration = var_47_7

					if var_47_7 + var_47_0 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_7 + var_47_0
					end
				end

				arg_44_1.text_.text = var_47_4
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107091", "107091011", "story_v_out_107091.awb") ~= 0 then
					local var_47_8 = manager.audio:GetVoiceLength("story_v_out_107091", "107091011", "story_v_out_107091.awb") / 1000

					if var_47_8 + var_47_0 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_8 + var_47_0
					end

					if var_47_3.prefab_name ~= "" and arg_44_1.actors_[var_47_3.prefab_name] ~= nil then
						local var_47_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_3.prefab_name].transform, "story_v_out_107091", "107091011", "story_v_out_107091.awb")

						arg_44_1:RecordAudio("107091011", var_47_9)
						arg_44_1:RecordAudio("107091011", var_47_9)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_107091", "107091011", "story_v_out_107091.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_107091", "107091011", "story_v_out_107091.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_10 = math.max(var_47_1, arg_44_1.talkMaxDuration)

			if var_47_0 <= arg_44_1.time_ and arg_44_1.time_ < var_47_0 + var_47_10 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_0) / var_47_10

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_0 + var_47_10 and arg_44_1.time_ < var_47_0 + var_47_10 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play107091012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 107091012
		arg_48_1.duration_ = 5.33

		local var_48_0 = {
			ja = 3.966,
			ko = 4.333,
			zh = 3.8,
			en = 5.333
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
				arg_48_0:Play107091013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = arg_48_1.actors_["1084ui_story"]
			local var_51_1 = 0

			if var_51_1 < arg_48_1.time_ and arg_48_1.time_ <= var_51_1 + arg_51_0 and not isNil(var_51_0) and arg_48_1.var_.characterEffect1084ui_story == nil then
				arg_48_1.var_.characterEffect1084ui_story = var_51_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_2 = 0.1

			if var_51_1 <= arg_48_1.time_ and arg_48_1.time_ < var_51_1 + var_51_2 and not isNil(var_51_0) then
				local var_51_3 = (arg_48_1.time_ - var_51_1) / var_51_2

				if arg_48_1.var_.characterEffect1084ui_story and not isNil(var_51_0) then
					arg_48_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_48_1.time_ >= var_51_1 + var_51_2 and arg_48_1.time_ < var_51_1 + var_51_2 + arg_51_0 and not isNil(var_51_0) and arg_48_1.var_.characterEffect1084ui_story then
				arg_48_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_51_4 = 0

			if var_51_4 < arg_48_1.time_ and arg_48_1.time_ <= var_51_4 + arg_51_0 then
				arg_48_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action4813")
			end

			local var_51_5 = 0

			if var_51_5 < arg_48_1.time_ and arg_48_1.time_ <= var_51_5 + arg_51_0 then
				arg_48_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_51_6 = 0
			local var_51_7 = 0.45

			if var_51_6 < arg_48_1.time_ and arg_48_1.time_ <= var_51_6 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				local var_51_8 = arg_48_1:FormatText(StoryNameCfg[6].name)

				arg_48_1.leftNameTxt_.text = var_51_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_9 = arg_48_1:GetWordFromCfg(107091012)
				local var_51_10 = arg_48_1:FormatText(var_51_9.content)

				arg_48_1.text_.text = var_51_10

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_11 = 18
				local var_51_12 = utf8.len(var_51_10)
				local var_51_13 = var_51_11 <= 0 and var_51_7 or var_51_7 * (var_51_12 / var_51_11)

				if var_51_13 > 0 and var_51_7 < var_51_13 then
					arg_48_1.talkMaxDuration = var_51_13

					if var_51_13 + var_51_6 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_13 + var_51_6
					end
				end

				arg_48_1.text_.text = var_51_10
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107091", "107091012", "story_v_out_107091.awb") ~= 0 then
					local var_51_14 = manager.audio:GetVoiceLength("story_v_out_107091", "107091012", "story_v_out_107091.awb") / 1000

					if var_51_14 + var_51_6 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_14 + var_51_6
					end

					if var_51_9.prefab_name ~= "" and arg_48_1.actors_[var_51_9.prefab_name] ~= nil then
						local var_51_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_9.prefab_name].transform, "story_v_out_107091", "107091012", "story_v_out_107091.awb")

						arg_48_1:RecordAudio("107091012", var_51_15)
						arg_48_1:RecordAudio("107091012", var_51_15)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_107091", "107091012", "story_v_out_107091.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_107091", "107091012", "story_v_out_107091.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_16 = math.max(var_51_7, arg_48_1.talkMaxDuration)

			if var_51_6 <= arg_48_1.time_ and arg_48_1.time_ < var_51_6 + var_51_16 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_6) / var_51_16

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_6 + var_51_16 and arg_48_1.time_ < var_51_6 + var_51_16 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play107091013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 107091013
		arg_52_1.duration_ = 14.57

		local var_52_0 = {
			ja = 14.566,
			ko = 7.366,
			zh = 7.166,
			en = 10.5
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
				arg_52_0:Play107091014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = 0
			local var_55_1 = 0.725

			if var_55_0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_0 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				local var_55_2 = arg_52_1:FormatText(StoryNameCfg[10].name)

				arg_52_1.leftNameTxt_.text = var_55_2

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

				local var_55_3 = arg_52_1:GetWordFromCfg(107091013)
				local var_55_4 = arg_52_1:FormatText(var_55_3.content)

				arg_52_1.text_.text = var_55_4

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_5 = 29
				local var_55_6 = utf8.len(var_55_4)
				local var_55_7 = var_55_5 <= 0 and var_55_1 or var_55_1 * (var_55_6 / var_55_5)

				if var_55_7 > 0 and var_55_1 < var_55_7 then
					arg_52_1.talkMaxDuration = var_55_7

					if var_55_7 + var_55_0 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_7 + var_55_0
					end
				end

				arg_52_1.text_.text = var_55_4
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107091", "107091013", "story_v_out_107091.awb") ~= 0 then
					local var_55_8 = manager.audio:GetVoiceLength("story_v_out_107091", "107091013", "story_v_out_107091.awb") / 1000

					if var_55_8 + var_55_0 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_8 + var_55_0
					end

					if var_55_3.prefab_name ~= "" and arg_52_1.actors_[var_55_3.prefab_name] ~= nil then
						local var_55_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_3.prefab_name].transform, "story_v_out_107091", "107091013", "story_v_out_107091.awb")

						arg_52_1:RecordAudio("107091013", var_55_9)
						arg_52_1:RecordAudio("107091013", var_55_9)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_107091", "107091013", "story_v_out_107091.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_107091", "107091013", "story_v_out_107091.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_10 = math.max(var_55_1, arg_52_1.talkMaxDuration)

			if var_55_0 <= arg_52_1.time_ and arg_52_1.time_ < var_55_0 + var_55_10 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_0) / var_55_10

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_0 + var_55_10 and arg_52_1.time_ < var_55_0 + var_55_10 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play107091014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 107091014
		arg_56_1.duration_ = 5

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play107091015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = arg_56_1.actors_["1084ui_story"]
			local var_59_1 = 0

			if var_59_1 < arg_56_1.time_ and arg_56_1.time_ <= var_59_1 + arg_59_0 and not isNil(var_59_0) and arg_56_1.var_.characterEffect1084ui_story == nil then
				arg_56_1.var_.characterEffect1084ui_story = var_59_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_2 = 0.1

			if var_59_1 <= arg_56_1.time_ and arg_56_1.time_ < var_59_1 + var_59_2 and not isNil(var_59_0) then
				local var_59_3 = (arg_56_1.time_ - var_59_1) / var_59_2

				if arg_56_1.var_.characterEffect1084ui_story and not isNil(var_59_0) then
					local var_59_4 = Mathf.Lerp(0, 0.5, var_59_3)

					arg_56_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_56_1.var_.characterEffect1084ui_story.fillRatio = var_59_4
				end
			end

			if arg_56_1.time_ >= var_59_1 + var_59_2 and arg_56_1.time_ < var_59_1 + var_59_2 + arg_59_0 and not isNil(var_59_0) and arg_56_1.var_.characterEffect1084ui_story then
				local var_59_5 = 0.5

				arg_56_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_56_1.var_.characterEffect1084ui_story.fillRatio = var_59_5
			end

			local var_59_6 = 0
			local var_59_7 = 0.25

			if var_59_6 < arg_56_1.time_ and arg_56_1.time_ <= var_59_6 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				local var_59_8 = arg_56_1:FormatText(StoryNameCfg[7].name)

				arg_56_1.leftNameTxt_.text = var_59_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, true)
				arg_56_1.iconController_:SetSelectedState("hero")

				arg_56_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_56_1.callingController_:SetSelectedState("normal")

				arg_56_1.keyicon_.color = Color.New(1, 1, 1)
				arg_56_1.icon_.color = Color.New(1, 1, 1)

				local var_59_9 = arg_56_1:GetWordFromCfg(107091014)
				local var_59_10 = arg_56_1:FormatText(var_59_9.content)

				arg_56_1.text_.text = var_59_10

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_11 = 10
				local var_59_12 = utf8.len(var_59_10)
				local var_59_13 = var_59_11 <= 0 and var_59_7 or var_59_7 * (var_59_12 / var_59_11)

				if var_59_13 > 0 and var_59_7 < var_59_13 then
					arg_56_1.talkMaxDuration = var_59_13

					if var_59_13 + var_59_6 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_13 + var_59_6
					end
				end

				arg_56_1.text_.text = var_59_10
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)
				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_14 = math.max(var_59_7, arg_56_1.talkMaxDuration)

			if var_59_6 <= arg_56_1.time_ and arg_56_1.time_ < var_59_6 + var_59_14 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_6) / var_59_14

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_6 + var_59_14 and arg_56_1.time_ < var_59_6 + var_59_14 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play107091015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 107091015
		arg_60_1.duration_ = 5

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play107091016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = arg_60_1.actors_["1084ui_story"].transform
			local var_63_1 = 0

			if var_63_1 < arg_60_1.time_ and arg_60_1.time_ <= var_63_1 + arg_63_0 then
				arg_60_1.var_.moveOldPos1084ui_story = var_63_0.localPosition
			end

			local var_63_2 = 0.001

			if var_63_1 <= arg_60_1.time_ and arg_60_1.time_ < var_63_1 + var_63_2 then
				local var_63_3 = (arg_60_1.time_ - var_63_1) / var_63_2
				local var_63_4 = Vector3.New(0, 100, 0)

				var_63_0.localPosition = Vector3.Lerp(arg_60_1.var_.moveOldPos1084ui_story, var_63_4, var_63_3)

				local var_63_5 = manager.ui.mainCamera.transform.position - var_63_0.position

				var_63_0.forward = Vector3.New(var_63_5.x, var_63_5.y, var_63_5.z)

				local var_63_6 = var_63_0.localEulerAngles

				var_63_6.z = 0
				var_63_6.x = 0
				var_63_0.localEulerAngles = var_63_6
			end

			if arg_60_1.time_ >= var_63_1 + var_63_2 and arg_60_1.time_ < var_63_1 + var_63_2 + arg_63_0 then
				var_63_0.localPosition = Vector3.New(0, 100, 0)

				local var_63_7 = manager.ui.mainCamera.transform.position - var_63_0.position

				var_63_0.forward = Vector3.New(var_63_7.x, var_63_7.y, var_63_7.z)

				local var_63_8 = var_63_0.localEulerAngles

				var_63_8.z = 0
				var_63_8.x = 0
				var_63_0.localEulerAngles = var_63_8
			end

			local var_63_9 = 0
			local var_63_10 = 0.1

			if var_63_9 < arg_60_1.time_ and arg_60_1.time_ <= var_63_9 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				local var_63_11 = arg_60_1:FormatText(StoryNameCfg[97].name)

				arg_60_1.leftNameTxt_.text = var_63_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, true)
				arg_60_1.iconController_:SetSelectedState("hero")

				arg_60_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2036")

				arg_60_1.callingController_:SetSelectedState("normal")

				arg_60_1.keyicon_.color = Color.New(1, 1, 1)
				arg_60_1.icon_.color = Color.New(1, 1, 1)

				local var_63_12 = arg_60_1:GetWordFromCfg(107091015)
				local var_63_13 = arg_60_1:FormatText(var_63_12.content)

				arg_60_1.text_.text = var_63_13

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_14 = 4
				local var_63_15 = utf8.len(var_63_13)
				local var_63_16 = var_63_14 <= 0 and var_63_10 or var_63_10 * (var_63_15 / var_63_14)

				if var_63_16 > 0 and var_63_10 < var_63_16 then
					arg_60_1.talkMaxDuration = var_63_16

					if var_63_16 + var_63_9 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_16 + var_63_9
					end
				end

				arg_60_1.text_.text = var_63_13
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)
				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_17 = math.max(var_63_10, arg_60_1.talkMaxDuration)

			if var_63_9 <= arg_60_1.time_ and arg_60_1.time_ < var_63_9 + var_63_17 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_9) / var_63_17

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_9 + var_63_17 and arg_60_1.time_ < var_63_9 + var_63_17 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {
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

		arg_60_1:InitPlayNodeList()
	end,
	Play107091016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 107091016
		arg_64_1.duration_ = 4.23

		local var_64_0 = {
			ja = 3.7,
			ko = 4.2,
			zh = 4.233,
			en = 3
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
				arg_64_0:Play107091017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = arg_64_1.actors_["1084ui_story"]
			local var_67_1 = 0

			if var_67_1 < arg_64_1.time_ and arg_64_1.time_ <= var_67_1 + arg_67_0 and not isNil(var_67_0) and arg_64_1.var_.characterEffect1084ui_story == nil then
				arg_64_1.var_.characterEffect1084ui_story = var_67_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_2 = 0.1

			if var_67_1 <= arg_64_1.time_ and arg_64_1.time_ < var_67_1 + var_67_2 and not isNil(var_67_0) then
				local var_67_3 = (arg_64_1.time_ - var_67_1) / var_67_2

				if arg_64_1.var_.characterEffect1084ui_story and not isNil(var_67_0) then
					arg_64_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_64_1.time_ >= var_67_1 + var_67_2 and arg_64_1.time_ < var_67_1 + var_67_2 + arg_67_0 and not isNil(var_67_0) and arg_64_1.var_.characterEffect1084ui_story then
				arg_64_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_67_4 = arg_64_1.actors_["1084ui_story"].transform
			local var_67_5 = 0

			if var_67_5 < arg_64_1.time_ and arg_64_1.time_ <= var_67_5 + arg_67_0 then
				arg_64_1.var_.moveOldPos1084ui_story = var_67_4.localPosition

				local var_67_6 = "1084ui_story"

				arg_64_1:ShowWeapon(arg_64_1.var_[var_67_6 .. "Animator"].transform, true)
			end

			local var_67_7 = 0.001

			if var_67_5 <= arg_64_1.time_ and arg_64_1.time_ < var_67_5 + var_67_7 then
				local var_67_8 = (arg_64_1.time_ - var_67_5) / var_67_7
				local var_67_9 = Vector3.New(0, -0.97, -6)

				var_67_4.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos1084ui_story, var_67_9, var_67_8)

				local var_67_10 = manager.ui.mainCamera.transform.position - var_67_4.position

				var_67_4.forward = Vector3.New(var_67_10.x, var_67_10.y, var_67_10.z)

				local var_67_11 = var_67_4.localEulerAngles

				var_67_11.z = 0
				var_67_11.x = 0
				var_67_4.localEulerAngles = var_67_11
			end

			if arg_64_1.time_ >= var_67_5 + var_67_7 and arg_64_1.time_ < var_67_5 + var_67_7 + arg_67_0 then
				var_67_4.localPosition = Vector3.New(0, -0.97, -6)

				local var_67_12 = manager.ui.mainCamera.transform.position - var_67_4.position

				var_67_4.forward = Vector3.New(var_67_12.x, var_67_12.y, var_67_12.z)

				local var_67_13 = var_67_4.localEulerAngles

				var_67_13.z = 0
				var_67_13.x = 0
				var_67_4.localEulerAngles = var_67_13
			end

			local var_67_14 = 0

			if var_67_14 < arg_64_1.time_ and arg_64_1.time_ <= var_67_14 + arg_67_0 then
				arg_64_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action11_1")
			end

			local var_67_15 = 0

			if var_67_15 < arg_64_1.time_ and arg_64_1.time_ <= var_67_15 + arg_67_0 then
				arg_64_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_67_16 = 0
			local var_67_17 = 0.375

			if var_67_16 < arg_64_1.time_ and arg_64_1.time_ <= var_67_16 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				local var_67_18 = arg_64_1:FormatText(StoryNameCfg[6].name)

				arg_64_1.leftNameTxt_.text = var_67_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_19 = arg_64_1:GetWordFromCfg(107091016)
				local var_67_20 = arg_64_1:FormatText(var_67_19.content)

				arg_64_1.text_.text = var_67_20

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_21 = 15
				local var_67_22 = utf8.len(var_67_20)
				local var_67_23 = var_67_21 <= 0 and var_67_17 or var_67_17 * (var_67_22 / var_67_21)

				if var_67_23 > 0 and var_67_17 < var_67_23 then
					arg_64_1.talkMaxDuration = var_67_23

					if var_67_23 + var_67_16 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_23 + var_67_16
					end
				end

				arg_64_1.text_.text = var_67_20
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107091", "107091016", "story_v_out_107091.awb") ~= 0 then
					local var_67_24 = manager.audio:GetVoiceLength("story_v_out_107091", "107091016", "story_v_out_107091.awb") / 1000

					if var_67_24 + var_67_16 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_24 + var_67_16
					end

					if var_67_19.prefab_name ~= "" and arg_64_1.actors_[var_67_19.prefab_name] ~= nil then
						local var_67_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_19.prefab_name].transform, "story_v_out_107091", "107091016", "story_v_out_107091.awb")

						arg_64_1:RecordAudio("107091016", var_67_25)
						arg_64_1:RecordAudio("107091016", var_67_25)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_107091", "107091016", "story_v_out_107091.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_107091", "107091016", "story_v_out_107091.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_26 = math.max(var_67_17, arg_64_1.talkMaxDuration)

			if var_67_16 <= arg_64_1.time_ and arg_64_1.time_ < var_67_16 + var_67_26 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_16) / var_67_26

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_16 + var_67_26 and arg_64_1.time_ < var_67_16 + var_67_26 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
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
	Play107091017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 107091017
		arg_68_1.duration_ = 0.1

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"

			SetActive(arg_68_1.choicesGo_, true)

			for iter_69_0, iter_69_1 in ipairs(arg_68_1.choices_) do
				local var_69_0 = iter_69_0 <= 1

				SetActive(iter_69_1.go, var_69_0)
			end

			arg_68_1.choices_[1].txt.text = arg_68_1:FormatText(StoryChoiceCfg[38].name)
		end

		function arg_68_1.playNext_(arg_70_0)
			if arg_70_0 == 1 then
				arg_68_0:Play107091018(arg_68_1)
			end

			arg_68_1:RecordChoiceLog(107091017, 38)
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = arg_68_1.actors_["1084ui_story"]
			local var_71_1 = 0

			if var_71_1 < arg_68_1.time_ and arg_68_1.time_ <= var_71_1 + arg_71_0 and not isNil(var_71_0) and arg_68_1.var_.characterEffect1084ui_story == nil then
				arg_68_1.var_.characterEffect1084ui_story = var_71_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_2 = 0.1

			if var_71_1 <= arg_68_1.time_ and arg_68_1.time_ < var_71_1 + var_71_2 and not isNil(var_71_0) then
				local var_71_3 = (arg_68_1.time_ - var_71_1) / var_71_2

				if arg_68_1.var_.characterEffect1084ui_story and not isNil(var_71_0) then
					local var_71_4 = Mathf.Lerp(0, 0.5, var_71_3)

					arg_68_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_68_1.var_.characterEffect1084ui_story.fillRatio = var_71_4
				end
			end

			if arg_68_1.time_ >= var_71_1 + var_71_2 and arg_68_1.time_ < var_71_1 + var_71_2 + arg_71_0 and not isNil(var_71_0) and arg_68_1.var_.characterEffect1084ui_story then
				local var_71_5 = 0.5

				arg_68_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_68_1.var_.characterEffect1084ui_story.fillRatio = var_71_5
			end
		end

		arg_68_1.nodeConfigList_ = {}

		arg_68_1:InitPlayNodeList()
	end,
	Play107091018 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 107091018
		arg_72_1.duration_ = 5.67

		local var_72_0 = {
			ja = 5.633,
			ko = 2.666,
			zh = 3.466,
			en = 5.666
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
				arg_72_0:Play107091019(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = arg_72_1.actors_["1038ui_story"]
			local var_75_1 = 0

			if var_75_1 < arg_72_1.time_ and arg_72_1.time_ <= var_75_1 + arg_75_0 and not isNil(var_75_0) and arg_72_1.var_.characterEffect1038ui_story == nil then
				arg_72_1.var_.characterEffect1038ui_story = var_75_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_2 = 0.1

			if var_75_1 <= arg_72_1.time_ and arg_72_1.time_ < var_75_1 + var_75_2 and not isNil(var_75_0) then
				local var_75_3 = (arg_72_1.time_ - var_75_1) / var_75_2

				if arg_72_1.var_.characterEffect1038ui_story and not isNil(var_75_0) then
					arg_72_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_72_1.time_ >= var_75_1 + var_75_2 and arg_72_1.time_ < var_75_1 + var_75_2 + arg_75_0 and not isNil(var_75_0) and arg_72_1.var_.characterEffect1038ui_story then
				arg_72_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_75_4 = arg_72_1.actors_["1084ui_story"].transform
			local var_75_5 = 0

			if var_75_5 < arg_72_1.time_ and arg_72_1.time_ <= var_75_5 + arg_75_0 then
				arg_72_1.var_.moveOldPos1084ui_story = var_75_4.localPosition
			end

			local var_75_6 = 0.001

			if var_75_5 <= arg_72_1.time_ and arg_72_1.time_ < var_75_5 + var_75_6 then
				local var_75_7 = (arg_72_1.time_ - var_75_5) / var_75_6
				local var_75_8 = Vector3.New(0, 100, 0)

				var_75_4.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPos1084ui_story, var_75_8, var_75_7)

				local var_75_9 = manager.ui.mainCamera.transform.position - var_75_4.position

				var_75_4.forward = Vector3.New(var_75_9.x, var_75_9.y, var_75_9.z)

				local var_75_10 = var_75_4.localEulerAngles

				var_75_10.z = 0
				var_75_10.x = 0
				var_75_4.localEulerAngles = var_75_10
			end

			if arg_72_1.time_ >= var_75_5 + var_75_6 and arg_72_1.time_ < var_75_5 + var_75_6 + arg_75_0 then
				var_75_4.localPosition = Vector3.New(0, 100, 0)

				local var_75_11 = manager.ui.mainCamera.transform.position - var_75_4.position

				var_75_4.forward = Vector3.New(var_75_11.x, var_75_11.y, var_75_11.z)

				local var_75_12 = var_75_4.localEulerAngles

				var_75_12.z = 0
				var_75_12.x = 0
				var_75_4.localEulerAngles = var_75_12
			end

			local var_75_13 = 0

			if var_75_13 < arg_72_1.time_ and arg_72_1.time_ <= var_75_13 + arg_75_0 then
				arg_72_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action11_2")
			end

			local var_75_14 = arg_72_1.actors_["1038ui_story"].transform
			local var_75_15 = 0

			if var_75_15 < arg_72_1.time_ and arg_72_1.time_ <= var_75_15 + arg_75_0 then
				arg_72_1.var_.moveOldPos1038ui_story = var_75_14.localPosition
			end

			local var_75_16 = 0.001

			if var_75_15 <= arg_72_1.time_ and arg_72_1.time_ < var_75_15 + var_75_16 then
				local var_75_17 = (arg_72_1.time_ - var_75_15) / var_75_16
				local var_75_18 = Vector3.New(0, -1.11, -5.9)

				var_75_14.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPos1038ui_story, var_75_18, var_75_17)

				local var_75_19 = manager.ui.mainCamera.transform.position - var_75_14.position

				var_75_14.forward = Vector3.New(var_75_19.x, var_75_19.y, var_75_19.z)

				local var_75_20 = var_75_14.localEulerAngles

				var_75_20.z = 0
				var_75_20.x = 0
				var_75_14.localEulerAngles = var_75_20
			end

			if arg_72_1.time_ >= var_75_15 + var_75_16 and arg_72_1.time_ < var_75_15 + var_75_16 + arg_75_0 then
				var_75_14.localPosition = Vector3.New(0, -1.11, -5.9)

				local var_75_21 = manager.ui.mainCamera.transform.position - var_75_14.position

				var_75_14.forward = Vector3.New(var_75_21.x, var_75_21.y, var_75_21.z)

				local var_75_22 = var_75_14.localEulerAngles

				var_75_22.z = 0
				var_75_22.x = 0
				var_75_14.localEulerAngles = var_75_22
			end

			local var_75_23 = 0

			if var_75_23 < arg_72_1.time_ and arg_72_1.time_ <= var_75_23 + arg_75_0 then
				arg_72_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038action/1038pick1")
			end

			local var_75_24 = 0

			if var_75_24 < arg_72_1.time_ and arg_72_1.time_ <= var_75_24 + arg_75_0 then
				arg_72_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_75_25 = 0
			local var_75_26 = 0.375

			if var_75_25 < arg_72_1.time_ and arg_72_1.time_ <= var_75_25 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				local var_75_27 = arg_72_1:FormatText(StoryNameCfg[94].name)

				arg_72_1.leftNameTxt_.text = var_75_27

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_28 = arg_72_1:GetWordFromCfg(107091018)
				local var_75_29 = arg_72_1:FormatText(var_75_28.content)

				arg_72_1.text_.text = var_75_29

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_30 = 15
				local var_75_31 = utf8.len(var_75_29)
				local var_75_32 = var_75_30 <= 0 and var_75_26 or var_75_26 * (var_75_31 / var_75_30)

				if var_75_32 > 0 and var_75_26 < var_75_32 then
					arg_72_1.talkMaxDuration = var_75_32

					if var_75_32 + var_75_25 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_32 + var_75_25
					end
				end

				arg_72_1.text_.text = var_75_29
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107091", "107091018", "story_v_out_107091.awb") ~= 0 then
					local var_75_33 = manager.audio:GetVoiceLength("story_v_out_107091", "107091018", "story_v_out_107091.awb") / 1000

					if var_75_33 + var_75_25 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_33 + var_75_25
					end

					if var_75_28.prefab_name ~= "" and arg_72_1.actors_[var_75_28.prefab_name] ~= nil then
						local var_75_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_28.prefab_name].transform, "story_v_out_107091", "107091018", "story_v_out_107091.awb")

						arg_72_1:RecordAudio("107091018", var_75_34)
						arg_72_1:RecordAudio("107091018", var_75_34)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_107091", "107091018", "story_v_out_107091.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_107091", "107091018", "story_v_out_107091.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_35 = math.max(var_75_26, arg_72_1.talkMaxDuration)

			if var_75_25 <= arg_72_1.time_ and arg_72_1.time_ < var_75_25 + var_75_35 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_25) / var_75_35

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_25 + var_75_35 and arg_72_1.time_ < var_75_25 + var_75_35 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {
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
				actorName = "1038ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_72_1:InitPlayNodeList()
	end,
	Play107091019 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 107091019
		arg_76_1.duration_ = 1.97

		local var_76_0 = {
			ja = 0.8,
			ko = 1.2,
			zh = 1.966,
			en = 1.8
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
				arg_76_0:Play107091020(arg_76_1)
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
					local var_79_4 = Mathf.Lerp(0, 0.5, var_79_3)

					arg_76_1.var_.characterEffect1038ui_story.fillFlat = true
					arg_76_1.var_.characterEffect1038ui_story.fillRatio = var_79_4
				end
			end

			if arg_76_1.time_ >= var_79_1 + var_79_2 and arg_76_1.time_ < var_79_1 + var_79_2 + arg_79_0 and not isNil(var_79_0) and arg_76_1.var_.characterEffect1038ui_story then
				local var_79_5 = 0.5

				arg_76_1.var_.characterEffect1038ui_story.fillFlat = true
				arg_76_1.var_.characterEffect1038ui_story.fillRatio = var_79_5
			end

			local var_79_6 = 0
			local var_79_7 = 0.075

			if var_79_6 < arg_76_1.time_ and arg_76_1.time_ <= var_79_6 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				local var_79_8 = arg_76_1:FormatText(StoryNameCfg[6].name)

				arg_76_1.leftNameTxt_.text = var_79_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, true)
				arg_76_1.iconController_:SetSelectedState("hero")

				arg_76_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_76_1.callingController_:SetSelectedState("normal")

				arg_76_1.keyicon_.color = Color.New(1, 1, 1)
				arg_76_1.icon_.color = Color.New(1, 1, 1)

				local var_79_9 = arg_76_1:GetWordFromCfg(107091019)
				local var_79_10 = arg_76_1:FormatText(var_79_9.content)

				arg_76_1.text_.text = var_79_10

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_11 = 5
				local var_79_12 = utf8.len(var_79_10)
				local var_79_13 = var_79_11 <= 0 and var_79_7 or var_79_7 * (var_79_12 / var_79_11)

				if var_79_13 > 0 and var_79_7 < var_79_13 then
					arg_76_1.talkMaxDuration = var_79_13

					if var_79_13 + var_79_6 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_13 + var_79_6
					end
				end

				arg_76_1.text_.text = var_79_10
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107091", "107091019", "story_v_out_107091.awb") ~= 0 then
					local var_79_14 = manager.audio:GetVoiceLength("story_v_out_107091", "107091019", "story_v_out_107091.awb") / 1000

					if var_79_14 + var_79_6 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_14 + var_79_6
					end

					if var_79_9.prefab_name ~= "" and arg_76_1.actors_[var_79_9.prefab_name] ~= nil then
						local var_79_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_9.prefab_name].transform, "story_v_out_107091", "107091019", "story_v_out_107091.awb")

						arg_76_1:RecordAudio("107091019", var_79_15)
						arg_76_1:RecordAudio("107091019", var_79_15)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_107091", "107091019", "story_v_out_107091.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_107091", "107091019", "story_v_out_107091.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_16 = math.max(var_79_7, arg_76_1.talkMaxDuration)

			if var_79_6 <= arg_76_1.time_ and arg_76_1.time_ < var_79_6 + var_79_16 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_6) / var_79_16

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_6 + var_79_16 and arg_76_1.time_ < var_79_6 + var_79_16 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {}

		arg_76_1:InitPlayNodeList()
	end,
	Play107091020 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 107091020
		arg_80_1.duration_ = 5.43

		local var_80_0 = {
			ja = 5,
			ko = 4.8,
			zh = 3.833,
			en = 5.433
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
				arg_80_0:Play107091021(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = arg_80_1.actors_["1038ui_story"]
			local var_83_1 = 0

			if var_83_1 < arg_80_1.time_ and arg_80_1.time_ <= var_83_1 + arg_83_0 and not isNil(var_83_0) and arg_80_1.var_.characterEffect1038ui_story == nil then
				arg_80_1.var_.characterEffect1038ui_story = var_83_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_2 = 0.1

			if var_83_1 <= arg_80_1.time_ and arg_80_1.time_ < var_83_1 + var_83_2 and not isNil(var_83_0) then
				local var_83_3 = (arg_80_1.time_ - var_83_1) / var_83_2

				if arg_80_1.var_.characterEffect1038ui_story and not isNil(var_83_0) then
					arg_80_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_80_1.time_ >= var_83_1 + var_83_2 and arg_80_1.time_ < var_83_1 + var_83_2 + arg_83_0 and not isNil(var_83_0) and arg_80_1.var_.characterEffect1038ui_story then
				arg_80_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_83_4 = 0

			if var_83_4 < arg_80_1.time_ and arg_80_1.time_ <= var_83_4 + arg_83_0 then
				arg_80_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038action/1038action4_1")
			end

			local var_83_5 = 0

			if var_83_5 < arg_80_1.time_ and arg_80_1.time_ <= var_83_5 + arg_83_0 then
				arg_80_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0203cva")
			end

			local var_83_6 = 0
			local var_83_7 = 0.45

			if var_83_6 < arg_80_1.time_ and arg_80_1.time_ <= var_83_6 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				local var_83_8 = arg_80_1:FormatText(StoryNameCfg[94].name)

				arg_80_1.leftNameTxt_.text = var_83_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_9 = arg_80_1:GetWordFromCfg(107091020)
				local var_83_10 = arg_80_1:FormatText(var_83_9.content)

				arg_80_1.text_.text = var_83_10

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_11 = 18
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

				if manager.audio:GetVoiceLength("story_v_out_107091", "107091020", "story_v_out_107091.awb") ~= 0 then
					local var_83_14 = manager.audio:GetVoiceLength("story_v_out_107091", "107091020", "story_v_out_107091.awb") / 1000

					if var_83_14 + var_83_6 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_14 + var_83_6
					end

					if var_83_9.prefab_name ~= "" and arg_80_1.actors_[var_83_9.prefab_name] ~= nil then
						local var_83_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_9.prefab_name].transform, "story_v_out_107091", "107091020", "story_v_out_107091.awb")

						arg_80_1:RecordAudio("107091020", var_83_15)
						arg_80_1:RecordAudio("107091020", var_83_15)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_out_107091", "107091020", "story_v_out_107091.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_out_107091", "107091020", "story_v_out_107091.awb")
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
	Play107091021 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 107091021
		arg_84_1.duration_ = 2.73

		local var_84_0 = {
			ja = 2.566,
			ko = 2.433,
			zh = 2.733,
			en = 2.533
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
				arg_84_0:Play107091022(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = arg_84_1.actors_["1084ui_story"]
			local var_87_1 = 0

			if var_87_1 < arg_84_1.time_ and arg_84_1.time_ <= var_87_1 + arg_87_0 and not isNil(var_87_0) and arg_84_1.var_.characterEffect1084ui_story == nil then
				arg_84_1.var_.characterEffect1084ui_story = var_87_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_2 = 0.1

			if var_87_1 <= arg_84_1.time_ and arg_84_1.time_ < var_87_1 + var_87_2 and not isNil(var_87_0) then
				local var_87_3 = (arg_84_1.time_ - var_87_1) / var_87_2

				if arg_84_1.var_.characterEffect1084ui_story and not isNil(var_87_0) then
					arg_84_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_84_1.time_ >= var_87_1 + var_87_2 and arg_84_1.time_ < var_87_1 + var_87_2 + arg_87_0 and not isNil(var_87_0) and arg_84_1.var_.characterEffect1084ui_story then
				arg_84_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_87_4 = arg_84_1.actors_["1038ui_story"]
			local var_87_5 = 0

			if var_87_5 < arg_84_1.time_ and arg_84_1.time_ <= var_87_5 + arg_87_0 and not isNil(var_87_4) and arg_84_1.var_.characterEffect1038ui_story == nil then
				arg_84_1.var_.characterEffect1038ui_story = var_87_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_6 = 0.1

			if var_87_5 <= arg_84_1.time_ and arg_84_1.time_ < var_87_5 + var_87_6 and not isNil(var_87_4) then
				local var_87_7 = (arg_84_1.time_ - var_87_5) / var_87_6

				if arg_84_1.var_.characterEffect1038ui_story and not isNil(var_87_4) then
					local var_87_8 = Mathf.Lerp(0, 0.5, var_87_7)

					arg_84_1.var_.characterEffect1038ui_story.fillFlat = true
					arg_84_1.var_.characterEffect1038ui_story.fillRatio = var_87_8
				end
			end

			if arg_84_1.time_ >= var_87_5 + var_87_6 and arg_84_1.time_ < var_87_5 + var_87_6 + arg_87_0 and not isNil(var_87_4) and arg_84_1.var_.characterEffect1038ui_story then
				local var_87_9 = 0.5

				arg_84_1.var_.characterEffect1038ui_story.fillFlat = true
				arg_84_1.var_.characterEffect1038ui_story.fillRatio = var_87_9
			end

			local var_87_10 = arg_84_1.actors_["1038ui_story"].transform
			local var_87_11 = 0

			if var_87_11 < arg_84_1.time_ and arg_84_1.time_ <= var_87_11 + arg_87_0 then
				arg_84_1.var_.moveOldPos1038ui_story = var_87_10.localPosition
			end

			local var_87_12 = 0.001

			if var_87_11 <= arg_84_1.time_ and arg_84_1.time_ < var_87_11 + var_87_12 then
				local var_87_13 = (arg_84_1.time_ - var_87_11) / var_87_12
				local var_87_14 = Vector3.New(0, 100, 0)

				var_87_10.localPosition = Vector3.Lerp(arg_84_1.var_.moveOldPos1038ui_story, var_87_14, var_87_13)

				local var_87_15 = manager.ui.mainCamera.transform.position - var_87_10.position

				var_87_10.forward = Vector3.New(var_87_15.x, var_87_15.y, var_87_15.z)

				local var_87_16 = var_87_10.localEulerAngles

				var_87_16.z = 0
				var_87_16.x = 0
				var_87_10.localEulerAngles = var_87_16
			end

			if arg_84_1.time_ >= var_87_11 + var_87_12 and arg_84_1.time_ < var_87_11 + var_87_12 + arg_87_0 then
				var_87_10.localPosition = Vector3.New(0, 100, 0)

				local var_87_17 = manager.ui.mainCamera.transform.position - var_87_10.position

				var_87_10.forward = Vector3.New(var_87_17.x, var_87_17.y, var_87_17.z)

				local var_87_18 = var_87_10.localEulerAngles

				var_87_18.z = 0
				var_87_18.x = 0
				var_87_10.localEulerAngles = var_87_18
			end

			local var_87_19 = arg_84_1.actors_["1084ui_story"].transform
			local var_87_20 = 0

			if var_87_20 < arg_84_1.time_ and arg_84_1.time_ <= var_87_20 + arg_87_0 then
				arg_84_1.var_.moveOldPos1084ui_story = var_87_19.localPosition

				local var_87_21 = "1084ui_story"

				arg_84_1:ShowWeapon(arg_84_1.var_[var_87_21 .. "Animator"].transform, false)
			end

			local var_87_22 = 0.001

			if var_87_20 <= arg_84_1.time_ and arg_84_1.time_ < var_87_20 + var_87_22 then
				local var_87_23 = (arg_84_1.time_ - var_87_20) / var_87_22
				local var_87_24 = Vector3.New(0, -0.97, -6)

				var_87_19.localPosition = Vector3.Lerp(arg_84_1.var_.moveOldPos1084ui_story, var_87_24, var_87_23)

				local var_87_25 = manager.ui.mainCamera.transform.position - var_87_19.position

				var_87_19.forward = Vector3.New(var_87_25.x, var_87_25.y, var_87_25.z)

				local var_87_26 = var_87_19.localEulerAngles

				var_87_26.z = 0
				var_87_26.x = 0
				var_87_19.localEulerAngles = var_87_26
			end

			if arg_84_1.time_ >= var_87_20 + var_87_22 and arg_84_1.time_ < var_87_20 + var_87_22 + arg_87_0 then
				var_87_19.localPosition = Vector3.New(0, -0.97, -6)

				local var_87_27 = manager.ui.mainCamera.transform.position - var_87_19.position

				var_87_19.forward = Vector3.New(var_87_27.x, var_87_27.y, var_87_27.z)

				local var_87_28 = var_87_19.localEulerAngles

				var_87_28.z = 0
				var_87_28.x = 0
				var_87_19.localEulerAngles = var_87_28
			end

			local var_87_29 = 0

			if var_87_29 < arg_84_1.time_ and arg_84_1.time_ <= var_87_29 + arg_87_0 then
				arg_84_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action4_1")
			end

			local var_87_30 = 0

			if var_87_30 < arg_84_1.time_ and arg_84_1.time_ <= var_87_30 + arg_87_0 then
				arg_84_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_87_31 = 0
			local var_87_32 = 0.3

			if var_87_31 < arg_84_1.time_ and arg_84_1.time_ <= var_87_31 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				local var_87_33 = arg_84_1:FormatText(StoryNameCfg[6].name)

				arg_84_1.leftNameTxt_.text = var_87_33

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_34 = arg_84_1:GetWordFromCfg(107091021)
				local var_87_35 = arg_84_1:FormatText(var_87_34.content)

				arg_84_1.text_.text = var_87_35

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_36 = 12
				local var_87_37 = utf8.len(var_87_35)
				local var_87_38 = var_87_36 <= 0 and var_87_32 or var_87_32 * (var_87_37 / var_87_36)

				if var_87_38 > 0 and var_87_32 < var_87_38 then
					arg_84_1.talkMaxDuration = var_87_38

					if var_87_38 + var_87_31 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_38 + var_87_31
					end
				end

				arg_84_1.text_.text = var_87_35
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107091", "107091021", "story_v_out_107091.awb") ~= 0 then
					local var_87_39 = manager.audio:GetVoiceLength("story_v_out_107091", "107091021", "story_v_out_107091.awb") / 1000

					if var_87_39 + var_87_31 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_39 + var_87_31
					end

					if var_87_34.prefab_name ~= "" and arg_84_1.actors_[var_87_34.prefab_name] ~= nil then
						local var_87_40 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_34.prefab_name].transform, "story_v_out_107091", "107091021", "story_v_out_107091.awb")

						arg_84_1:RecordAudio("107091021", var_87_40)
						arg_84_1:RecordAudio("107091021", var_87_40)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_out_107091", "107091021", "story_v_out_107091.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_out_107091", "107091021", "story_v_out_107091.awb")
				end

				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_41 = math.max(var_87_32, arg_84_1.talkMaxDuration)

			if var_87_31 <= arg_84_1.time_ and arg_84_1.time_ < var_87_31 + var_87_41 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_31) / var_87_41

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_31 + var_87_41 and arg_84_1.time_ < var_87_31 + var_87_41 + arg_87_0 then
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

		arg_84_1:InitPlayNodeList()
	end,
	Play107091022 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 107091022
		arg_88_1.duration_ = 8.8

		local var_88_0 = {
			ja = 8.8,
			ko = 6.633,
			zh = 8.133,
			en = 7.066
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
			arg_88_1.auto_ = false
		end

		function arg_88_1.playNext_(arg_90_0)
			arg_88_1.onStoryFinished_()
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = arg_88_1.actors_["1038ui_story"]
			local var_91_1 = 0

			if var_91_1 < arg_88_1.time_ and arg_88_1.time_ <= var_91_1 + arg_91_0 and not isNil(var_91_0) and arg_88_1.var_.characterEffect1038ui_story == nil then
				arg_88_1.var_.characterEffect1038ui_story = var_91_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_2 = 0.1

			if var_91_1 <= arg_88_1.time_ and arg_88_1.time_ < var_91_1 + var_91_2 and not isNil(var_91_0) then
				local var_91_3 = (arg_88_1.time_ - var_91_1) / var_91_2

				if arg_88_1.var_.characterEffect1038ui_story and not isNil(var_91_0) then
					arg_88_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_88_1.time_ >= var_91_1 + var_91_2 and arg_88_1.time_ < var_91_1 + var_91_2 + arg_91_0 and not isNil(var_91_0) and arg_88_1.var_.characterEffect1038ui_story then
				arg_88_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_91_4 = arg_88_1.actors_["1084ui_story"]
			local var_91_5 = 0

			if var_91_5 < arg_88_1.time_ and arg_88_1.time_ <= var_91_5 + arg_91_0 and not isNil(var_91_4) and arg_88_1.var_.characterEffect1084ui_story == nil then
				arg_88_1.var_.characterEffect1084ui_story = var_91_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_6 = 0.1

			if var_91_5 <= arg_88_1.time_ and arg_88_1.time_ < var_91_5 + var_91_6 and not isNil(var_91_4) then
				local var_91_7 = (arg_88_1.time_ - var_91_5) / var_91_6

				if arg_88_1.var_.characterEffect1084ui_story and not isNil(var_91_4) then
					local var_91_8 = Mathf.Lerp(0, 0.5, var_91_7)

					arg_88_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_88_1.var_.characterEffect1084ui_story.fillRatio = var_91_8
				end
			end

			if arg_88_1.time_ >= var_91_5 + var_91_6 and arg_88_1.time_ < var_91_5 + var_91_6 + arg_91_0 and not isNil(var_91_4) and arg_88_1.var_.characterEffect1084ui_story then
				local var_91_9 = 0.5

				arg_88_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_88_1.var_.characterEffect1084ui_story.fillRatio = var_91_9
			end

			local var_91_10 = arg_88_1.actors_["1084ui_story"].transform
			local var_91_11 = 0

			if var_91_11 < arg_88_1.time_ and arg_88_1.time_ <= var_91_11 + arg_91_0 then
				arg_88_1.var_.moveOldPos1084ui_story = var_91_10.localPosition
			end

			local var_91_12 = 0.001

			if var_91_11 <= arg_88_1.time_ and arg_88_1.time_ < var_91_11 + var_91_12 then
				local var_91_13 = (arg_88_1.time_ - var_91_11) / var_91_12
				local var_91_14 = Vector3.New(0, 100, 0)

				var_91_10.localPosition = Vector3.Lerp(arg_88_1.var_.moveOldPos1084ui_story, var_91_14, var_91_13)

				local var_91_15 = manager.ui.mainCamera.transform.position - var_91_10.position

				var_91_10.forward = Vector3.New(var_91_15.x, var_91_15.y, var_91_15.z)

				local var_91_16 = var_91_10.localEulerAngles

				var_91_16.z = 0
				var_91_16.x = 0
				var_91_10.localEulerAngles = var_91_16
			end

			if arg_88_1.time_ >= var_91_11 + var_91_12 and arg_88_1.time_ < var_91_11 + var_91_12 + arg_91_0 then
				var_91_10.localPosition = Vector3.New(0, 100, 0)

				local var_91_17 = manager.ui.mainCamera.transform.position - var_91_10.position

				var_91_10.forward = Vector3.New(var_91_17.x, var_91_17.y, var_91_17.z)

				local var_91_18 = var_91_10.localEulerAngles

				var_91_18.z = 0
				var_91_18.x = 0
				var_91_10.localEulerAngles = var_91_18
			end

			local var_91_19 = arg_88_1.actors_["1038ui_story"].transform
			local var_91_20 = 0

			if var_91_20 < arg_88_1.time_ and arg_88_1.time_ <= var_91_20 + arg_91_0 then
				arg_88_1.var_.moveOldPos1038ui_story = var_91_19.localPosition
			end

			local var_91_21 = 0.001

			if var_91_20 <= arg_88_1.time_ and arg_88_1.time_ < var_91_20 + var_91_21 then
				local var_91_22 = (arg_88_1.time_ - var_91_20) / var_91_21
				local var_91_23 = Vector3.New(0, -1.11, -5.9)

				var_91_19.localPosition = Vector3.Lerp(arg_88_1.var_.moveOldPos1038ui_story, var_91_23, var_91_22)

				local var_91_24 = manager.ui.mainCamera.transform.position - var_91_19.position

				var_91_19.forward = Vector3.New(var_91_24.x, var_91_24.y, var_91_24.z)

				local var_91_25 = var_91_19.localEulerAngles

				var_91_25.z = 0
				var_91_25.x = 0
				var_91_19.localEulerAngles = var_91_25
			end

			if arg_88_1.time_ >= var_91_20 + var_91_21 and arg_88_1.time_ < var_91_20 + var_91_21 + arg_91_0 then
				var_91_19.localPosition = Vector3.New(0, -1.11, -5.9)

				local var_91_26 = manager.ui.mainCamera.transform.position - var_91_19.position

				var_91_19.forward = Vector3.New(var_91_26.x, var_91_26.y, var_91_26.z)

				local var_91_27 = var_91_19.localEulerAngles

				var_91_27.z = 0
				var_91_27.x = 0
				var_91_19.localEulerAngles = var_91_27
			end

			local var_91_28 = 0

			if var_91_28 < arg_88_1.time_ and arg_88_1.time_ <= var_91_28 + arg_91_0 then
				arg_88_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038action/1038action7_1")
			end

			local var_91_29 = 0

			if var_91_29 < arg_88_1.time_ and arg_88_1.time_ <= var_91_29 + arg_91_0 then
				arg_88_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_91_30 = 0
			local var_91_31 = 0.775

			if var_91_30 < arg_88_1.time_ and arg_88_1.time_ <= var_91_30 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				local var_91_32 = arg_88_1:FormatText(StoryNameCfg[94].name)

				arg_88_1.leftNameTxt_.text = var_91_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_33 = arg_88_1:GetWordFromCfg(107091022)
				local var_91_34 = arg_88_1:FormatText(var_91_33.content)

				arg_88_1.text_.text = var_91_34

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_35 = 31
				local var_91_36 = utf8.len(var_91_34)
				local var_91_37 = var_91_35 <= 0 and var_91_31 or var_91_31 * (var_91_36 / var_91_35)

				if var_91_37 > 0 and var_91_31 < var_91_37 then
					arg_88_1.talkMaxDuration = var_91_37

					if var_91_37 + var_91_30 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_37 + var_91_30
					end
				end

				arg_88_1.text_.text = var_91_34
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107091", "107091022", "story_v_out_107091.awb") ~= 0 then
					local var_91_38 = manager.audio:GetVoiceLength("story_v_out_107091", "107091022", "story_v_out_107091.awb") / 1000

					if var_91_38 + var_91_30 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_38 + var_91_30
					end

					if var_91_33.prefab_name ~= "" and arg_88_1.actors_[var_91_33.prefab_name] ~= nil then
						local var_91_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_88_1.actors_[var_91_33.prefab_name].transform, "story_v_out_107091", "107091022", "story_v_out_107091.awb")

						arg_88_1:RecordAudio("107091022", var_91_39)
						arg_88_1:RecordAudio("107091022", var_91_39)
					else
						arg_88_1:AudioAction("play", "voice", "story_v_out_107091", "107091022", "story_v_out_107091.awb")
					end

					arg_88_1:RecordHistoryTalkVoice("story_v_out_107091", "107091022", "story_v_out_107091.awb")
				end

				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_40 = math.max(var_91_31, arg_88_1.talkMaxDuration)

			if var_91_30 <= arg_88_1.time_ and arg_88_1.time_ < var_91_30 + var_91_40 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_30) / var_91_40

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_30 + var_91_40 and arg_88_1.time_ < var_91_30 + var_91_40 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {
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
				actorName = "1038ui_story",
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
	assets = {
		"TextureConfig/Background/C06b"
	},
	voices = {
		"story_v_out_107091.awb"
	}
}
