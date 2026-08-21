return {
	Play109061001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 109061001
		arg_1_1.duration_ = 11.1

		local var_1_0 = {
			ja = 10.7,
			ko = 11.066,
			zh = 11.1,
			en = 9.9
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
				arg_1_0:Play109061002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "C07_1"

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
				local var_4_5 = arg_1_1.bgs_.C07_1

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
					if iter_4_0 ~= "C07_1" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = arg_1_1.bgs_.C07_1
			local var_4_17 = 0

			if var_4_17 < arg_1_1.time_ and arg_1_1.time_ <= var_4_17 + arg_4_0 then
				local var_4_18 = var_4_16:GetComponent("SpriteRenderer")

				if var_4_18 then
					arg_1_1.var_.alphaOldValueC07_1 = var_4_18.color.a
					arg_1_1.var_.alphaMatValueC07_1 = var_4_18
				end

				arg_1_1.var_.alphaOldValueC07_1 = 0
			end

			local var_4_19 = 1.5

			if var_4_17 <= arg_1_1.time_ and arg_1_1.time_ < var_4_17 + var_4_19 then
				local var_4_20 = (arg_1_1.time_ - var_4_17) / var_4_19
				local var_4_21 = Mathf.Lerp(arg_1_1.var_.alphaOldValueC07_1, 1, var_4_20)

				if arg_1_1.var_.alphaMatValueC07_1 then
					local var_4_22 = arg_1_1.var_.alphaMatValueC07_1.color

					var_4_22.a = var_4_21
					arg_1_1.var_.alphaMatValueC07_1.color = var_4_22
				end
			end

			if arg_1_1.time_ >= var_4_17 + var_4_19 and arg_1_1.time_ < var_4_17 + var_4_19 + arg_4_0 and arg_1_1.var_.alphaMatValueC07_1 then
				local var_4_23 = arg_1_1.var_.alphaMatValueC07_1
				local var_4_24 = var_4_23.color

				var_4_24.a = 1
				var_4_23.color = var_4_24
			end

			local var_4_25 = 0
			local var_4_26 = 1

			if var_4_25 < arg_1_1.time_ and arg_1_1.time_ <= var_4_25 + arg_4_0 then
				local var_4_27 = "play"
				local var_4_28 = "music"

				arg_1_1:AudioAction(var_4_27, var_4_28, "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1.awb")

				local var_4_29 = ""
				local var_4_30 = manager.audio:GetAudioName("bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1")

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

			local var_4_31 = 1.5

			if var_4_31 < arg_1_1.time_ and arg_1_1.time_ <= var_4_31 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_32 = 2

			if arg_1_1.time_ >= var_4_31 + var_4_32 and arg_1_1.time_ < var_4_31 + var_4_32 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_33 = "10004ui_story"

			if arg_1_1.actors_[var_4_33] == nil then
				local var_4_34 = Asset.Load("Char/" .. "10004ui_story")

				if not isNil(var_4_34) then
					local var_4_35 = Object.Instantiate(Asset.Load("Char/" .. "10004ui_story"), arg_1_1.stage_.transform)

					var_4_35.name = var_4_33
					var_4_35.transform.localPosition = Vector3.New(0, 100, 0)
					arg_1_1.actors_[var_4_33] = var_4_35

					local var_4_36 = var_4_35:GetComponentInChildren(typeof(CharacterEffect))

					var_4_36.enabled = true

					local var_4_37 = GameObjectTools.GetOrAddComponent(var_4_35, typeof(DynamicBoneHelper))

					if var_4_37 then
						var_4_37:EnableDynamicBone(false)
					end

					arg_1_1:ShowWeapon(var_4_36.transform, false)

					arg_1_1.var_[var_4_33 .. "Animator"] = var_4_36.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_1_1.var_[var_4_33 .. "Animator"].applyRootMotion = true
					arg_1_1.var_[var_4_33 .. "LipSync"] = var_4_36.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_4_38 = arg_1_1.actors_["10004ui_story"]
			local var_4_39 = 1.5

			if var_4_39 < arg_1_1.time_ and arg_1_1.time_ <= var_4_39 + arg_4_0 and not isNil(var_4_38) and arg_1_1.var_.characterEffect10004ui_story == nil then
				arg_1_1.var_.characterEffect10004ui_story = var_4_38:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_40 = 0.1

			if var_4_39 <= arg_1_1.time_ and arg_1_1.time_ < var_4_39 + var_4_40 and not isNil(var_4_38) then
				local var_4_41 = (arg_1_1.time_ - var_4_39) / var_4_40

				if arg_1_1.var_.characterEffect10004ui_story and not isNil(var_4_38) then
					arg_1_1.var_.characterEffect10004ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= var_4_39 + var_4_40 and arg_1_1.time_ < var_4_39 + var_4_40 + arg_4_0 and not isNil(var_4_38) and arg_1_1.var_.characterEffect10004ui_story then
				arg_1_1.var_.characterEffect10004ui_story.fillFlat = false
			end

			local var_4_42 = arg_1_1.actors_["10004ui_story"].transform
			local var_4_43 = 1.5

			if var_4_43 < arg_1_1.time_ and arg_1_1.time_ <= var_4_43 + arg_4_0 then
				arg_1_1.var_.moveOldPos10004ui_story = var_4_42.localPosition
			end

			local var_4_44 = 0.001

			if var_4_43 <= arg_1_1.time_ and arg_1_1.time_ < var_4_43 + var_4_44 then
				local var_4_45 = (arg_1_1.time_ - var_4_43) / var_4_44
				local var_4_46 = Vector3.New(-0.7, -1.1, -5.6)

				var_4_42.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos10004ui_story, var_4_46, var_4_45)

				local var_4_47 = manager.ui.mainCamera.transform.position - var_4_42.position

				var_4_42.forward = Vector3.New(var_4_47.x, var_4_47.y, var_4_47.z)

				local var_4_48 = var_4_42.localEulerAngles

				var_4_48.z = 0
				var_4_48.x = 0
				var_4_42.localEulerAngles = var_4_48
			end

			if arg_1_1.time_ >= var_4_43 + var_4_44 and arg_1_1.time_ < var_4_43 + var_4_44 + arg_4_0 then
				var_4_42.localPosition = Vector3.New(-0.7, -1.1, -5.6)

				local var_4_49 = manager.ui.mainCamera.transform.position - var_4_42.position

				var_4_42.forward = Vector3.New(var_4_49.x, var_4_49.y, var_4_49.z)

				local var_4_50 = var_4_42.localEulerAngles

				var_4_50.z = 0
				var_4_50.x = 0
				var_4_42.localEulerAngles = var_4_50
			end

			local var_4_51 = "10003ui_story"

			if arg_1_1.actors_[var_4_51] == nil then
				local var_4_52 = Asset.Load("Char/" .. "10003ui_story")

				if not isNil(var_4_52) then
					local var_4_53 = Object.Instantiate(Asset.Load("Char/" .. "10003ui_story"), arg_1_1.stage_.transform)

					var_4_53.name = var_4_51
					var_4_53.transform.localPosition = Vector3.New(0, 100, 0)
					arg_1_1.actors_[var_4_51] = var_4_53

					local var_4_54 = var_4_53:GetComponentInChildren(typeof(CharacterEffect))

					var_4_54.enabled = true

					local var_4_55 = GameObjectTools.GetOrAddComponent(var_4_53, typeof(DynamicBoneHelper))

					if var_4_55 then
						var_4_55:EnableDynamicBone(false)
					end

					arg_1_1:ShowWeapon(var_4_54.transform, false)

					arg_1_1.var_[var_4_51 .. "Animator"] = var_4_54.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_1_1.var_[var_4_51 .. "Animator"].applyRootMotion = true
					arg_1_1.var_[var_4_51 .. "LipSync"] = var_4_54.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_4_56 = arg_1_1.actors_["10003ui_story"].transform
			local var_4_57 = 0

			if var_4_57 < arg_1_1.time_ and arg_1_1.time_ <= var_4_57 + arg_4_0 then
				arg_1_1.var_.moveOldPos10003ui_story = var_4_56.localPosition
			end

			local var_4_58 = 0.001

			if var_4_57 <= arg_1_1.time_ and arg_1_1.time_ < var_4_57 + var_4_58 then
				local var_4_59 = (arg_1_1.time_ - var_4_57) / var_4_58
				local var_4_60 = Vector3.New(0, 100, 0)

				var_4_56.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos10003ui_story, var_4_60, var_4_59)

				local var_4_61 = manager.ui.mainCamera.transform.position - var_4_56.position

				var_4_56.forward = Vector3.New(var_4_61.x, var_4_61.y, var_4_61.z)

				local var_4_62 = var_4_56.localEulerAngles

				var_4_62.z = 0
				var_4_62.x = 0
				var_4_56.localEulerAngles = var_4_62
			end

			if arg_1_1.time_ >= var_4_57 + var_4_58 and arg_1_1.time_ < var_4_57 + var_4_58 + arg_4_0 then
				var_4_56.localPosition = Vector3.New(0, 100, 0)

				local var_4_63 = manager.ui.mainCamera.transform.position - var_4_56.position

				var_4_56.forward = Vector3.New(var_4_63.x, var_4_63.y, var_4_63.z)

				local var_4_64 = var_4_56.localEulerAngles

				var_4_64.z = 0
				var_4_64.x = 0
				var_4_56.localEulerAngles = var_4_64
			end

			local var_4_65 = 0

			if var_4_65 < arg_1_1.time_ and arg_1_1.time_ <= var_4_65 + arg_4_0 then
				arg_1_1:PlayTimeline("10003ui_story", "StoryTimeline/CharAction/story10003/story10003action/10003action2_1")
			end

			local var_4_66 = 1.5

			if var_4_66 < arg_1_1.time_ and arg_1_1.time_ <= var_4_66 + arg_4_0 then
				arg_1_1:PlayTimeline("10004ui_story", "StoryTimeline/CharAction/story10004/story10004action/10004action3_1")
			end

			local var_4_67 = 0

			if var_4_67 < arg_1_1.time_ and arg_1_1.time_ <= var_4_67 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_68 = 2

			if arg_1_1.time_ >= var_4_67 + var_4_68 and arg_1_1.time_ < var_4_67 + var_4_68 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_69 = 1.5

			if var_4_69 < arg_1_1.time_ and arg_1_1.time_ <= var_4_69 + arg_4_0 then
				arg_1_1:PlayTimeline("10004ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_70 = 2
			local var_4_71 = 0.975

			if var_4_70 < arg_1_1.time_ and arg_1_1.time_ <= var_4_70 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_72 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_72:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_72:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_72:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_73 = arg_1_1:FormatText(StoryNameCfg[80].name)

				arg_1_1.leftNameTxt_.text = var_4_73

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_74 = arg_1_1:GetWordFromCfg(109061001)
				local var_4_75 = arg_1_1:FormatText(var_4_74.content)

				arg_1_1.text_.text = var_4_75

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_76 = 39
				local var_4_77 = utf8.len(var_4_75)
				local var_4_78 = var_4_76 <= 0 and var_4_71 or var_4_71 * (var_4_77 / var_4_76)

				if var_4_78 > 0 and var_4_71 < var_4_78 then
					arg_1_1.talkMaxDuration = var_4_78
					var_4_70 = var_4_70 + 0.3

					if var_4_78 + var_4_70 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_78 + var_4_70
					end
				end

				arg_1_1.text_.text = var_4_75
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109061", "109061001", "story_v_out_109061.awb") ~= 0 then
					local var_4_79 = manager.audio:GetVoiceLength("story_v_out_109061", "109061001", "story_v_out_109061.awb") / 1000

					if var_4_79 + var_4_70 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_79 + var_4_70
					end

					if var_4_74.prefab_name ~= "" and arg_1_1.actors_[var_4_74.prefab_name] ~= nil then
						local var_4_80 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_74.prefab_name].transform, "story_v_out_109061", "109061001", "story_v_out_109061.awb")

						arg_1_1:RecordAudio("109061001", var_4_80)
						arg_1_1:RecordAudio("109061001", var_4_80)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_109061", "109061001", "story_v_out_109061.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_109061", "109061001", "story_v_out_109061.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_81 = var_4_70 + 0.3
			local var_4_82 = math.max(var_4_71, arg_1_1.talkMaxDuration)

			if var_4_81 <= arg_1_1.time_ and arg_1_1.time_ < var_4_81 + var_4_82 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_81) / var_4_82

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_81 + var_4_82 and arg_1_1.time_ < var_4_81 + var_4_82 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10004ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.5,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play109061002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 109061002
		arg_8_1.duration_ = 5.03

		local var_8_0 = {
			ja = 5.033,
			ko = 2.8,
			zh = 4.433,
			en = 3.5
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
				arg_8_0:Play109061003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = arg_8_1.actors_["10004ui_story"]
			local var_11_1 = 0

			if var_11_1 < arg_8_1.time_ and arg_8_1.time_ <= var_11_1 + arg_11_0 and not isNil(var_11_0) and arg_8_1.var_.characterEffect10004ui_story == nil then
				arg_8_1.var_.characterEffect10004ui_story = var_11_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_2 = 0.1

			if var_11_1 <= arg_8_1.time_ and arg_8_1.time_ < var_11_1 + var_11_2 and not isNil(var_11_0) then
				local var_11_3 = (arg_8_1.time_ - var_11_1) / var_11_2

				if arg_8_1.var_.characterEffect10004ui_story and not isNil(var_11_0) then
					local var_11_4 = Mathf.Lerp(0, 0.5, var_11_3)

					arg_8_1.var_.characterEffect10004ui_story.fillFlat = true
					arg_8_1.var_.characterEffect10004ui_story.fillRatio = var_11_4
				end
			end

			if arg_8_1.time_ >= var_11_1 + var_11_2 and arg_8_1.time_ < var_11_1 + var_11_2 + arg_11_0 and not isNil(var_11_0) and arg_8_1.var_.characterEffect10004ui_story then
				local var_11_5 = 0.5

				arg_8_1.var_.characterEffect10004ui_story.fillFlat = true
				arg_8_1.var_.characterEffect10004ui_story.fillRatio = var_11_5
			end

			local var_11_6 = 0
			local var_11_7 = 0.425

			if var_11_6 < arg_8_1.time_ and arg_8_1.time_ <= var_11_6 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				local var_11_8 = arg_8_1:FormatText(StoryNameCfg[157].name)

				arg_8_1.leftNameTxt_.text = var_11_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, true)
				arg_8_1.iconController_:SetSelectedState("hero")

				arg_8_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2032")

				arg_8_1.callingController_:SetSelectedState("normal")

				arg_8_1.keyicon_.color = Color.New(1, 1, 1)
				arg_8_1.icon_.color = Color.New(1, 1, 1)

				local var_11_9 = arg_8_1:GetWordFromCfg(109061002)
				local var_11_10 = arg_8_1:FormatText(var_11_9.content)

				arg_8_1.text_.text = var_11_10

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_11 = 17
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

				if manager.audio:GetVoiceLength("story_v_out_109061", "109061002", "story_v_out_109061.awb") ~= 0 then
					local var_11_14 = manager.audio:GetVoiceLength("story_v_out_109061", "109061002", "story_v_out_109061.awb") / 1000

					if var_11_14 + var_11_6 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_14 + var_11_6
					end

					if var_11_9.prefab_name ~= "" and arg_8_1.actors_[var_11_9.prefab_name] ~= nil then
						local var_11_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_9.prefab_name].transform, "story_v_out_109061", "109061002", "story_v_out_109061.awb")

						arg_8_1:RecordAudio("109061002", var_11_15)
						arg_8_1:RecordAudio("109061002", var_11_15)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_109061", "109061002", "story_v_out_109061.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_109061", "109061002", "story_v_out_109061.awb")
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
	Play109061003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 109061003
		arg_12_1.duration_ = 10.6

		local var_12_0 = {
			ja = 10.6,
			ko = 6.8,
			zh = 6.9,
			en = 7.6
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
				arg_12_0:Play109061004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = arg_12_1.actors_["10003ui_story"].transform
			local var_15_1 = 0

			if var_15_1 < arg_12_1.time_ and arg_12_1.time_ <= var_15_1 + arg_15_0 then
				arg_12_1.var_.moveOldPos10003ui_story = var_15_0.localPosition
			end

			local var_15_2 = 0.001

			if var_15_1 <= arg_12_1.time_ and arg_12_1.time_ < var_15_1 + var_15_2 then
				local var_15_3 = (arg_12_1.time_ - var_15_1) / var_15_2
				local var_15_4 = Vector3.New(0.7, -1.05, -5.9)

				var_15_0.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos10003ui_story, var_15_4, var_15_3)

				local var_15_5 = manager.ui.mainCamera.transform.position - var_15_0.position

				var_15_0.forward = Vector3.New(var_15_5.x, var_15_5.y, var_15_5.z)

				local var_15_6 = var_15_0.localEulerAngles

				var_15_6.z = 0
				var_15_6.x = 0
				var_15_0.localEulerAngles = var_15_6
			end

			if arg_12_1.time_ >= var_15_1 + var_15_2 and arg_12_1.time_ < var_15_1 + var_15_2 + arg_15_0 then
				var_15_0.localPosition = Vector3.New(0.7, -1.05, -5.9)

				local var_15_7 = manager.ui.mainCamera.transform.position - var_15_0.position

				var_15_0.forward = Vector3.New(var_15_7.x, var_15_7.y, var_15_7.z)

				local var_15_8 = var_15_0.localEulerAngles

				var_15_8.z = 0
				var_15_8.x = 0
				var_15_0.localEulerAngles = var_15_8
			end

			local var_15_9 = arg_12_1.actors_["10004ui_story"]
			local var_15_10 = 0

			if var_15_10 < arg_12_1.time_ and arg_12_1.time_ <= var_15_10 + arg_15_0 and not isNil(var_15_9) and arg_12_1.var_.characterEffect10004ui_story == nil then
				arg_12_1.var_.characterEffect10004ui_story = var_15_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_11 = 0.1

			if var_15_10 <= arg_12_1.time_ and arg_12_1.time_ < var_15_10 + var_15_11 and not isNil(var_15_9) then
				local var_15_12 = (arg_12_1.time_ - var_15_10) / var_15_11

				if arg_12_1.var_.characterEffect10004ui_story and not isNil(var_15_9) then
					local var_15_13 = Mathf.Lerp(0, 0.5, var_15_12)

					arg_12_1.var_.characterEffect10004ui_story.fillFlat = true
					arg_12_1.var_.characterEffect10004ui_story.fillRatio = var_15_13
				end
			end

			if arg_12_1.time_ >= var_15_10 + var_15_11 and arg_12_1.time_ < var_15_10 + var_15_11 + arg_15_0 and not isNil(var_15_9) and arg_12_1.var_.characterEffect10004ui_story then
				local var_15_14 = 0.5

				arg_12_1.var_.characterEffect10004ui_story.fillFlat = true
				arg_12_1.var_.characterEffect10004ui_story.fillRatio = var_15_14
			end

			local var_15_15 = arg_12_1.actors_["10003ui_story"]
			local var_15_16 = 0

			if var_15_16 < arg_12_1.time_ and arg_12_1.time_ <= var_15_16 + arg_15_0 and not isNil(var_15_15) and arg_12_1.var_.characterEffect10003ui_story == nil then
				arg_12_1.var_.characterEffect10003ui_story = var_15_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_17 = 0.1

			if var_15_16 <= arg_12_1.time_ and arg_12_1.time_ < var_15_16 + var_15_17 and not isNil(var_15_15) then
				local var_15_18 = (arg_12_1.time_ - var_15_16) / var_15_17

				if arg_12_1.var_.characterEffect10003ui_story and not isNil(var_15_15) then
					arg_12_1.var_.characterEffect10003ui_story.fillFlat = false
				end
			end

			if arg_12_1.time_ >= var_15_16 + var_15_17 and arg_12_1.time_ < var_15_16 + var_15_17 + arg_15_0 and not isNil(var_15_15) and arg_12_1.var_.characterEffect10003ui_story then
				arg_12_1.var_.characterEffect10003ui_story.fillFlat = false
			end

			local var_15_19 = 0

			if var_15_19 < arg_12_1.time_ and arg_12_1.time_ <= var_15_19 + arg_15_0 then
				arg_12_1:PlayTimeline("10003ui_story", "StoryTimeline/CharAction/story10003/story10003action/10003action1_1")
			end

			local var_15_20 = 0

			if var_15_20 < arg_12_1.time_ and arg_12_1.time_ <= var_15_20 + arg_15_0 then
				arg_12_1:PlayTimeline("10003ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_15_21 = 0
			local var_15_22 = 0.75

			if var_15_21 < arg_12_1.time_ and arg_12_1.time_ <= var_15_21 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				local var_15_23 = arg_12_1:FormatText(StoryNameCfg[81].name)

				arg_12_1.leftNameTxt_.text = var_15_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_24 = arg_12_1:GetWordFromCfg(109061003)
				local var_15_25 = arg_12_1:FormatText(var_15_24.content)

				arg_12_1.text_.text = var_15_25

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_26 = 30
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

				if manager.audio:GetVoiceLength("story_v_out_109061", "109061003", "story_v_out_109061.awb") ~= 0 then
					local var_15_29 = manager.audio:GetVoiceLength("story_v_out_109061", "109061003", "story_v_out_109061.awb") / 1000

					if var_15_29 + var_15_21 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_29 + var_15_21
					end

					if var_15_24.prefab_name ~= "" and arg_12_1.actors_[var_15_24.prefab_name] ~= nil then
						local var_15_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_24.prefab_name].transform, "story_v_out_109061", "109061003", "story_v_out_109061.awb")

						arg_12_1:RecordAudio("109061003", var_15_30)
						arg_12_1:RecordAudio("109061003", var_15_30)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_109061", "109061003", "story_v_out_109061.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_109061", "109061003", "story_v_out_109061.awb")
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
				actorName = "10003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_12_1:InitPlayNodeList()
	end,
	Play109061004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 109061004
		arg_16_1.duration_ = 8.2

		local var_16_0 = {
			ja = 8.2,
			ko = 5.433,
			zh = 5.833,
			en = 6.833
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
				arg_16_0:Play109061005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = 0

			if var_19_0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_0 + arg_19_0 then
				arg_16_1:PlayTimeline("10003ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_19_1 = 0
			local var_19_2 = 0.7

			if var_19_1 < arg_16_1.time_ and arg_16_1.time_ <= var_19_1 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				local var_19_3 = arg_16_1:FormatText(StoryNameCfg[81].name)

				arg_16_1.leftNameTxt_.text = var_19_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_4 = arg_16_1:GetWordFromCfg(109061004)
				local var_19_5 = arg_16_1:FormatText(var_19_4.content)

				arg_16_1.text_.text = var_19_5

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_6 = 28
				local var_19_7 = utf8.len(var_19_5)
				local var_19_8 = var_19_6 <= 0 and var_19_2 or var_19_2 * (var_19_7 / var_19_6)

				if var_19_8 > 0 and var_19_2 < var_19_8 then
					arg_16_1.talkMaxDuration = var_19_8

					if var_19_8 + var_19_1 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_8 + var_19_1
					end
				end

				arg_16_1.text_.text = var_19_5
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109061", "109061004", "story_v_out_109061.awb") ~= 0 then
					local var_19_9 = manager.audio:GetVoiceLength("story_v_out_109061", "109061004", "story_v_out_109061.awb") / 1000

					if var_19_9 + var_19_1 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_9 + var_19_1
					end

					if var_19_4.prefab_name ~= "" and arg_16_1.actors_[var_19_4.prefab_name] ~= nil then
						local var_19_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_4.prefab_name].transform, "story_v_out_109061", "109061004", "story_v_out_109061.awb")

						arg_16_1:RecordAudio("109061004", var_19_10)
						arg_16_1:RecordAudio("109061004", var_19_10)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_109061", "109061004", "story_v_out_109061.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_109061", "109061004", "story_v_out_109061.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_11 = math.max(var_19_2, arg_16_1.talkMaxDuration)

			if var_19_1 <= arg_16_1.time_ and arg_16_1.time_ < var_19_1 + var_19_11 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_1) / var_19_11

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_1 + var_19_11 and arg_16_1.time_ < var_19_1 + var_19_11 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play109061005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 109061005
		arg_20_1.duration_ = 13.2

		local var_20_0 = {
			ja = 13.2,
			ko = 9.233,
			zh = 12.033,
			en = 8.6
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
				arg_20_0:Play109061006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = arg_20_1.actors_["10004ui_story"]
			local var_23_1 = 0

			if var_23_1 < arg_20_1.time_ and arg_20_1.time_ <= var_23_1 + arg_23_0 and not isNil(var_23_0) and arg_20_1.var_.characterEffect10004ui_story == nil then
				arg_20_1.var_.characterEffect10004ui_story = var_23_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_2 = 0.1

			if var_23_1 <= arg_20_1.time_ and arg_20_1.time_ < var_23_1 + var_23_2 and not isNil(var_23_0) then
				local var_23_3 = (arg_20_1.time_ - var_23_1) / var_23_2

				if arg_20_1.var_.characterEffect10004ui_story and not isNil(var_23_0) then
					arg_20_1.var_.characterEffect10004ui_story.fillFlat = false
				end
			end

			if arg_20_1.time_ >= var_23_1 + var_23_2 and arg_20_1.time_ < var_23_1 + var_23_2 + arg_23_0 and not isNil(var_23_0) and arg_20_1.var_.characterEffect10004ui_story then
				arg_20_1.var_.characterEffect10004ui_story.fillFlat = false
			end

			local var_23_4 = arg_20_1.actors_["10003ui_story"]
			local var_23_5 = 0

			if var_23_5 < arg_20_1.time_ and arg_20_1.time_ <= var_23_5 + arg_23_0 and not isNil(var_23_4) and arg_20_1.var_.characterEffect10003ui_story == nil then
				arg_20_1.var_.characterEffect10003ui_story = var_23_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_6 = 0.1

			if var_23_5 <= arg_20_1.time_ and arg_20_1.time_ < var_23_5 + var_23_6 and not isNil(var_23_4) then
				local var_23_7 = (arg_20_1.time_ - var_23_5) / var_23_6

				if arg_20_1.var_.characterEffect10003ui_story and not isNil(var_23_4) then
					local var_23_8 = Mathf.Lerp(0, 0.5, var_23_7)

					arg_20_1.var_.characterEffect10003ui_story.fillFlat = true
					arg_20_1.var_.characterEffect10003ui_story.fillRatio = var_23_8
				end
			end

			if arg_20_1.time_ >= var_23_5 + var_23_6 and arg_20_1.time_ < var_23_5 + var_23_6 + arg_23_0 and not isNil(var_23_4) and arg_20_1.var_.characterEffect10003ui_story then
				local var_23_9 = 0.5

				arg_20_1.var_.characterEffect10003ui_story.fillFlat = true
				arg_20_1.var_.characterEffect10003ui_story.fillRatio = var_23_9
			end

			local var_23_10 = 0

			if var_23_10 < arg_20_1.time_ and arg_20_1.time_ <= var_23_10 + arg_23_0 then
				arg_20_1:PlayTimeline("10004ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_23_11 = 0
			local var_23_12 = 0.975

			if var_23_11 < arg_20_1.time_ and arg_20_1.time_ <= var_23_11 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				local var_23_13 = arg_20_1:FormatText(StoryNameCfg[80].name)

				arg_20_1.leftNameTxt_.text = var_23_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_14 = arg_20_1:GetWordFromCfg(109061005)
				local var_23_15 = arg_20_1:FormatText(var_23_14.content)

				arg_20_1.text_.text = var_23_15

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_16 = 39
				local var_23_17 = utf8.len(var_23_15)
				local var_23_18 = var_23_16 <= 0 and var_23_12 or var_23_12 * (var_23_17 / var_23_16)

				if var_23_18 > 0 and var_23_12 < var_23_18 then
					arg_20_1.talkMaxDuration = var_23_18

					if var_23_18 + var_23_11 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_18 + var_23_11
					end
				end

				arg_20_1.text_.text = var_23_15
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109061", "109061005", "story_v_out_109061.awb") ~= 0 then
					local var_23_19 = manager.audio:GetVoiceLength("story_v_out_109061", "109061005", "story_v_out_109061.awb") / 1000

					if var_23_19 + var_23_11 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_19 + var_23_11
					end

					if var_23_14.prefab_name ~= "" and arg_20_1.actors_[var_23_14.prefab_name] ~= nil then
						local var_23_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_14.prefab_name].transform, "story_v_out_109061", "109061005", "story_v_out_109061.awb")

						arg_20_1:RecordAudio("109061005", var_23_20)
						arg_20_1:RecordAudio("109061005", var_23_20)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_109061", "109061005", "story_v_out_109061.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_109061", "109061005", "story_v_out_109061.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_21 = math.max(var_23_12, arg_20_1.talkMaxDuration)

			if var_23_11 <= arg_20_1.time_ and arg_20_1.time_ < var_23_11 + var_23_21 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_11) / var_23_21

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_11 + var_23_21 and arg_20_1.time_ < var_23_11 + var_23_21 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play109061006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 109061006
		arg_24_1.duration_ = 2.5

		local var_24_0 = {
			ja = 2.2,
			ko = 1.999999999999,
			zh = 2.3,
			en = 2.5
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
				arg_24_0:Play109061007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = "3004_tpose"

			if arg_24_1.actors_[var_27_0] == nil then
				local var_27_1 = Asset.Load("Char/" .. "3004_tpose")

				if not isNil(var_27_1) then
					local var_27_2 = Object.Instantiate(Asset.Load("Char/" .. "3004_tpose"), arg_24_1.stage_.transform)

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

			local var_27_5 = arg_24_1.actors_["3004_tpose"].transform
			local var_27_6 = 0

			if var_27_6 < arg_24_1.time_ and arg_24_1.time_ <= var_27_6 + arg_27_0 then
				arg_24_1.var_.moveOldPos3004_tpose = var_27_5.localPosition

				local var_27_7 = GameObjectTools.GetOrAddComponent(var_27_5.gameObject, typeof(DynamicBoneHelper))

				if var_27_7 then
					var_27_7:EnableDynamicBone(false)
				end
			end

			local var_27_8 = 0.001

			if var_27_6 <= arg_24_1.time_ and arg_24_1.time_ < var_27_6 + var_27_8 then
				local var_27_9 = (arg_24_1.time_ - var_27_6) / var_27_8
				local var_27_10 = Vector3.New(0.7, -2.22, -3.1)

				var_27_5.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos3004_tpose, var_27_10, var_27_9)

				local var_27_11 = manager.ui.mainCamera.transform.position - var_27_5.position

				var_27_5.forward = Vector3.New(var_27_11.x, var_27_11.y, var_27_11.z)

				local var_27_12 = var_27_5.localEulerAngles

				var_27_12.z = 0
				var_27_12.x = 0
				var_27_5.localEulerAngles = var_27_12
			end

			if arg_24_1.time_ >= var_27_6 + var_27_8 and arg_24_1.time_ < var_27_6 + var_27_8 + arg_27_0 then
				var_27_5.localPosition = Vector3.New(0.7, -2.22, -3.1)

				local var_27_13 = manager.ui.mainCamera.transform.position - var_27_5.position

				var_27_5.forward = Vector3.New(var_27_13.x, var_27_13.y, var_27_13.z)

				local var_27_14 = var_27_5.localEulerAngles

				var_27_14.z = 0
				var_27_14.x = 0
				var_27_5.localEulerAngles = var_27_14

				local var_27_15 = GameObjectTools.GetOrAddComponent(var_27_5.gameObject, typeof(DynamicBoneHelper))

				if var_27_15 then
					var_27_15:EnableDynamicBone(true)
				end
			end

			local var_27_16 = arg_24_1.actors_["3004_tpose"]
			local var_27_17 = 0

			if var_27_17 < arg_24_1.time_ and arg_24_1.time_ <= var_27_17 + arg_27_0 and not isNil(var_27_16) and arg_24_1.var_.characterEffect3004_tpose == nil then
				arg_24_1.var_.characterEffect3004_tpose = var_27_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_18 = 0.100000001490116

			if var_27_17 <= arg_24_1.time_ and arg_24_1.time_ < var_27_17 + var_27_18 and not isNil(var_27_16) then
				local var_27_19 = (arg_24_1.time_ - var_27_17) / var_27_18

				if arg_24_1.var_.characterEffect3004_tpose and not isNil(var_27_16) then
					arg_24_1.var_.characterEffect3004_tpose.fillFlat = false
				end
			end

			if arg_24_1.time_ >= var_27_17 + var_27_18 and arg_24_1.time_ < var_27_17 + var_27_18 + arg_27_0 and not isNil(var_27_16) and arg_24_1.var_.characterEffect3004_tpose then
				arg_24_1.var_.characterEffect3004_tpose.fillFlat = false
			end

			local var_27_20 = arg_24_1.actors_["10004ui_story"]
			local var_27_21 = 0

			if var_27_21 < arg_24_1.time_ and arg_24_1.time_ <= var_27_21 + arg_27_0 and not isNil(var_27_20) and arg_24_1.var_.characterEffect10004ui_story == nil then
				arg_24_1.var_.characterEffect10004ui_story = var_27_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_22 = 0.1

			if var_27_21 <= arg_24_1.time_ and arg_24_1.time_ < var_27_21 + var_27_22 and not isNil(var_27_20) then
				local var_27_23 = (arg_24_1.time_ - var_27_21) / var_27_22

				if arg_24_1.var_.characterEffect10004ui_story and not isNil(var_27_20) then
					local var_27_24 = Mathf.Lerp(0, 0.5, var_27_23)

					arg_24_1.var_.characterEffect10004ui_story.fillFlat = true
					arg_24_1.var_.characterEffect10004ui_story.fillRatio = var_27_24
				end
			end

			if arg_24_1.time_ >= var_27_21 + var_27_22 and arg_24_1.time_ < var_27_21 + var_27_22 + arg_27_0 and not isNil(var_27_20) and arg_24_1.var_.characterEffect10004ui_story then
				local var_27_25 = 0.5

				arg_24_1.var_.characterEffect10004ui_story.fillFlat = true
				arg_24_1.var_.characterEffect10004ui_story.fillRatio = var_27_25
			end

			local var_27_26 = 0

			if var_27_26 < arg_24_1.time_ and arg_24_1.time_ <= var_27_26 + arg_27_0 then
				arg_24_1:PlayTimeline("3004_tpose", "StoryTimeline/CharAction/story3004/story3004action/3004action1_1")
			end

			local var_27_27 = arg_24_1.actors_["10003ui_story"].transform
			local var_27_28 = 0

			if var_27_28 < arg_24_1.time_ and arg_24_1.time_ <= var_27_28 + arg_27_0 then
				arg_24_1.var_.moveOldPos10003ui_story = var_27_27.localPosition
			end

			local var_27_29 = 0.001

			if var_27_28 <= arg_24_1.time_ and arg_24_1.time_ < var_27_28 + var_27_29 then
				local var_27_30 = (arg_24_1.time_ - var_27_28) / var_27_29
				local var_27_31 = Vector3.New(0, 100, 0)

				var_27_27.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos10003ui_story, var_27_31, var_27_30)

				local var_27_32 = manager.ui.mainCamera.transform.position - var_27_27.position

				var_27_27.forward = Vector3.New(var_27_32.x, var_27_32.y, var_27_32.z)

				local var_27_33 = var_27_27.localEulerAngles

				var_27_33.z = 0
				var_27_33.x = 0
				var_27_27.localEulerAngles = var_27_33
			end

			if arg_24_1.time_ >= var_27_28 + var_27_29 and arg_24_1.time_ < var_27_28 + var_27_29 + arg_27_0 then
				var_27_27.localPosition = Vector3.New(0, 100, 0)

				local var_27_34 = manager.ui.mainCamera.transform.position - var_27_27.position

				var_27_27.forward = Vector3.New(var_27_34.x, var_27_34.y, var_27_34.z)

				local var_27_35 = var_27_27.localEulerAngles

				var_27_35.z = 0
				var_27_35.x = 0
				var_27_27.localEulerAngles = var_27_35
			end

			local var_27_36 = 0
			local var_27_37 = 0.175

			if var_27_36 < arg_24_1.time_ and arg_24_1.time_ <= var_27_36 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				local var_27_38 = arg_24_1:FormatText(StoryNameCfg[82].name)

				arg_24_1.leftNameTxt_.text = var_27_38

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_39 = arg_24_1:GetWordFromCfg(109061006)
				local var_27_40 = arg_24_1:FormatText(var_27_39.content)

				arg_24_1.text_.text = var_27_40

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_41 = 7
				local var_27_42 = utf8.len(var_27_40)
				local var_27_43 = var_27_41 <= 0 and var_27_37 or var_27_37 * (var_27_42 / var_27_41)

				if var_27_43 > 0 and var_27_37 < var_27_43 then
					arg_24_1.talkMaxDuration = var_27_43

					if var_27_43 + var_27_36 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_43 + var_27_36
					end
				end

				arg_24_1.text_.text = var_27_40
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109061", "109061006", "story_v_out_109061.awb") ~= 0 then
					local var_27_44 = manager.audio:GetVoiceLength("story_v_out_109061", "109061006", "story_v_out_109061.awb") / 1000

					if var_27_44 + var_27_36 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_44 + var_27_36
					end

					if var_27_39.prefab_name ~= "" and arg_24_1.actors_[var_27_39.prefab_name] ~= nil then
						local var_27_45 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_39.prefab_name].transform, "story_v_out_109061", "109061006", "story_v_out_109061.awb")

						arg_24_1:RecordAudio("109061006", var_27_45)
						arg_24_1:RecordAudio("109061006", var_27_45)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_109061", "109061006", "story_v_out_109061.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_109061", "109061006", "story_v_out_109061.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_46 = math.max(var_27_37, arg_24_1.talkMaxDuration)

			if var_27_36 <= arg_24_1.time_ and arg_24_1.time_ < var_27_36 + var_27_46 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_36) / var_27_46

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_36 + var_27_46 and arg_24_1.time_ < var_27_36 + var_27_46 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {
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
				actorName = "10003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_24_1:InitPlayNodeList()
	end,
	Play109061007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 109061007
		arg_28_1.duration_ = 2

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play109061008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = arg_28_1.actors_["3004_tpose"]
			local var_31_1 = 0

			if var_31_1 < arg_28_1.time_ and arg_28_1.time_ <= var_31_1 + arg_31_0 and not isNil(var_31_0) and arg_28_1.var_.characterEffect3004_tpose == nil then
				arg_28_1.var_.characterEffect3004_tpose = var_31_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_2 = 0.100000001490116

			if var_31_1 <= arg_28_1.time_ and arg_28_1.time_ < var_31_1 + var_31_2 and not isNil(var_31_0) then
				local var_31_3 = (arg_28_1.time_ - var_31_1) / var_31_2

				if arg_28_1.var_.characterEffect3004_tpose and not isNil(var_31_0) then
					local var_31_4 = Mathf.Lerp(0, 0.5, var_31_3)

					arg_28_1.var_.characterEffect3004_tpose.fillFlat = true
					arg_28_1.var_.characterEffect3004_tpose.fillRatio = var_31_4
				end
			end

			if arg_28_1.time_ >= var_31_1 + var_31_2 and arg_28_1.time_ < var_31_1 + var_31_2 + arg_31_0 and not isNil(var_31_0) and arg_28_1.var_.characterEffect3004_tpose then
				local var_31_5 = 0.5

				arg_28_1.var_.characterEffect3004_tpose.fillFlat = true
				arg_28_1.var_.characterEffect3004_tpose.fillRatio = var_31_5
			end

			local var_31_6 = arg_28_1.actors_["10004ui_story"]
			local var_31_7 = 0

			if var_31_7 < arg_28_1.time_ and arg_28_1.time_ <= var_31_7 + arg_31_0 and not isNil(var_31_6) and arg_28_1.var_.characterEffect10004ui_story == nil then
				arg_28_1.var_.characterEffect10004ui_story = var_31_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_8 = 0.1

			if var_31_7 <= arg_28_1.time_ and arg_28_1.time_ < var_31_7 + var_31_8 and not isNil(var_31_6) then
				local var_31_9 = (arg_28_1.time_ - var_31_7) / var_31_8

				if arg_28_1.var_.characterEffect10004ui_story and not isNil(var_31_6) then
					arg_28_1.var_.characterEffect10004ui_story.fillFlat = false
				end
			end

			if arg_28_1.time_ >= var_31_7 + var_31_8 and arg_28_1.time_ < var_31_7 + var_31_8 + arg_31_0 and not isNil(var_31_6) and arg_28_1.var_.characterEffect10004ui_story then
				arg_28_1.var_.characterEffect10004ui_story.fillFlat = false
			end

			local var_31_10 = 0

			if var_31_10 < arg_28_1.time_ and arg_28_1.time_ <= var_31_10 + arg_31_0 then
				arg_28_1:PlayTimeline("10004ui_story", "StoryTimeline/CharAction/story10004/story10004action/10004action3_2")
			end

			local var_31_11 = 0

			if var_31_11 < arg_28_1.time_ and arg_28_1.time_ <= var_31_11 + arg_31_0 then
				arg_28_1:PlayTimeline("10004ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_31_12 = 0
			local var_31_13 = 0.1

			if var_31_12 < arg_28_1.time_ and arg_28_1.time_ <= var_31_12 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				local var_31_14 = arg_28_1:FormatText(StoryNameCfg[80].name)

				arg_28_1.leftNameTxt_.text = var_31_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_15 = arg_28_1:GetWordFromCfg(109061007)
				local var_31_16 = arg_28_1:FormatText(var_31_15.content)

				arg_28_1.text_.text = var_31_16

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_17 = 4
				local var_31_18 = utf8.len(var_31_16)
				local var_31_19 = var_31_17 <= 0 and var_31_13 or var_31_13 * (var_31_18 / var_31_17)

				if var_31_19 > 0 and var_31_13 < var_31_19 then
					arg_28_1.talkMaxDuration = var_31_19

					if var_31_19 + var_31_12 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_19 + var_31_12
					end
				end

				arg_28_1.text_.text = var_31_16
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109061", "109061007", "story_v_out_109061.awb") ~= 0 then
					local var_31_20 = manager.audio:GetVoiceLength("story_v_out_109061", "109061007", "story_v_out_109061.awb") / 1000

					if var_31_20 + var_31_12 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_20 + var_31_12
					end

					if var_31_15.prefab_name ~= "" and arg_28_1.actors_[var_31_15.prefab_name] ~= nil then
						local var_31_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_15.prefab_name].transform, "story_v_out_109061", "109061007", "story_v_out_109061.awb")

						arg_28_1:RecordAudio("109061007", var_31_21)
						arg_28_1:RecordAudio("109061007", var_31_21)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_109061", "109061007", "story_v_out_109061.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_109061", "109061007", "story_v_out_109061.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_22 = math.max(var_31_13, arg_28_1.talkMaxDuration)

			if var_31_12 <= arg_28_1.time_ and arg_28_1.time_ < var_31_12 + var_31_22 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_12) / var_31_22

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_12 + var_31_22 and arg_28_1.time_ < var_31_12 + var_31_22 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play109061008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 109061008
		arg_32_1.duration_ = 4.57

		local var_32_0 = {
			ja = 2.8,
			ko = 4.566,
			zh = 4.166,
			en = 4
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
				arg_32_0:Play109061009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = arg_32_1.actors_["3004_tpose"]
			local var_35_1 = 0

			if var_35_1 < arg_32_1.time_ and arg_32_1.time_ <= var_35_1 + arg_35_0 and not isNil(var_35_0) and arg_32_1.var_.characterEffect3004_tpose == nil then
				arg_32_1.var_.characterEffect3004_tpose = var_35_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_2 = 0.100000001490116

			if var_35_1 <= arg_32_1.time_ and arg_32_1.time_ < var_35_1 + var_35_2 and not isNil(var_35_0) then
				local var_35_3 = (arg_32_1.time_ - var_35_1) / var_35_2

				if arg_32_1.var_.characterEffect3004_tpose and not isNil(var_35_0) then
					arg_32_1.var_.characterEffect3004_tpose.fillFlat = false
				end
			end

			if arg_32_1.time_ >= var_35_1 + var_35_2 and arg_32_1.time_ < var_35_1 + var_35_2 + arg_35_0 and not isNil(var_35_0) and arg_32_1.var_.characterEffect3004_tpose then
				arg_32_1.var_.characterEffect3004_tpose.fillFlat = false
			end

			local var_35_4 = arg_32_1.actors_["10004ui_story"]
			local var_35_5 = 0

			if var_35_5 < arg_32_1.time_ and arg_32_1.time_ <= var_35_5 + arg_35_0 and not isNil(var_35_4) and arg_32_1.var_.characterEffect10004ui_story == nil then
				arg_32_1.var_.characterEffect10004ui_story = var_35_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_6 = 0.1

			if var_35_5 <= arg_32_1.time_ and arg_32_1.time_ < var_35_5 + var_35_6 and not isNil(var_35_4) then
				local var_35_7 = (arg_32_1.time_ - var_35_5) / var_35_6

				if arg_32_1.var_.characterEffect10004ui_story and not isNil(var_35_4) then
					local var_35_8 = Mathf.Lerp(0, 0.5, var_35_7)

					arg_32_1.var_.characterEffect10004ui_story.fillFlat = true
					arg_32_1.var_.characterEffect10004ui_story.fillRatio = var_35_8
				end
			end

			if arg_32_1.time_ >= var_35_5 + var_35_6 and arg_32_1.time_ < var_35_5 + var_35_6 + arg_35_0 and not isNil(var_35_4) and arg_32_1.var_.characterEffect10004ui_story then
				local var_35_9 = 0.5

				arg_32_1.var_.characterEffect10004ui_story.fillFlat = true
				arg_32_1.var_.characterEffect10004ui_story.fillRatio = var_35_9
			end

			local var_35_10 = 0
			local var_35_11 = 0.4

			if var_35_10 < arg_32_1.time_ and arg_32_1.time_ <= var_35_10 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				local var_35_12 = arg_32_1:FormatText(StoryNameCfg[82].name)

				arg_32_1.leftNameTxt_.text = var_35_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_13 = arg_32_1:GetWordFromCfg(109061008)
				local var_35_14 = arg_32_1:FormatText(var_35_13.content)

				arg_32_1.text_.text = var_35_14

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_15 = 16
				local var_35_16 = utf8.len(var_35_14)
				local var_35_17 = var_35_15 <= 0 and var_35_11 or var_35_11 * (var_35_16 / var_35_15)

				if var_35_17 > 0 and var_35_11 < var_35_17 then
					arg_32_1.talkMaxDuration = var_35_17

					if var_35_17 + var_35_10 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_17 + var_35_10
					end
				end

				arg_32_1.text_.text = var_35_14
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109061", "109061008", "story_v_out_109061.awb") ~= 0 then
					local var_35_18 = manager.audio:GetVoiceLength("story_v_out_109061", "109061008", "story_v_out_109061.awb") / 1000

					if var_35_18 + var_35_10 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_18 + var_35_10
					end

					if var_35_13.prefab_name ~= "" and arg_32_1.actors_[var_35_13.prefab_name] ~= nil then
						local var_35_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_13.prefab_name].transform, "story_v_out_109061", "109061008", "story_v_out_109061.awb")

						arg_32_1:RecordAudio("109061008", var_35_19)
						arg_32_1:RecordAudio("109061008", var_35_19)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_109061", "109061008", "story_v_out_109061.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_109061", "109061008", "story_v_out_109061.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_20 = math.max(var_35_11, arg_32_1.talkMaxDuration)

			if var_35_10 <= arg_32_1.time_ and arg_32_1.time_ < var_35_10 + var_35_20 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_10) / var_35_20

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_10 + var_35_20 and arg_32_1.time_ < var_35_10 + var_35_20 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play109061009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 109061009
		arg_36_1.duration_ = 5.77

		local var_36_0 = {
			ja = 5.766,
			ko = 3.9,
			zh = 4.4,
			en = 3.266
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
				arg_36_0:Play109061010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = 0
			local var_39_1 = 0.45

			if var_39_0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_0 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				local var_39_2 = arg_36_1:FormatText(StoryNameCfg[82].name)

				arg_36_1.leftNameTxt_.text = var_39_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_3 = arg_36_1:GetWordFromCfg(109061009)
				local var_39_4 = arg_36_1:FormatText(var_39_3.content)

				arg_36_1.text_.text = var_39_4

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_5 = 18
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

				if manager.audio:GetVoiceLength("story_v_out_109061", "109061009", "story_v_out_109061.awb") ~= 0 then
					local var_39_8 = manager.audio:GetVoiceLength("story_v_out_109061", "109061009", "story_v_out_109061.awb") / 1000

					if var_39_8 + var_39_0 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_8 + var_39_0
					end

					if var_39_3.prefab_name ~= "" and arg_36_1.actors_[var_39_3.prefab_name] ~= nil then
						local var_39_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_3.prefab_name].transform, "story_v_out_109061", "109061009", "story_v_out_109061.awb")

						arg_36_1:RecordAudio("109061009", var_39_9)
						arg_36_1:RecordAudio("109061009", var_39_9)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_109061", "109061009", "story_v_out_109061.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_109061", "109061009", "story_v_out_109061.awb")
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
	Play109061010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 109061010
		arg_40_1.duration_ = 6.63

		local var_40_0 = {
			ja = 5.133,
			ko = 5.533,
			zh = 6.633,
			en = 4.4
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
				arg_40_0:Play109061011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = manager.ui.mainCamera.transform
			local var_43_1 = 0.5

			if var_43_1 < arg_40_1.time_ and arg_40_1.time_ <= var_43_1 + arg_43_0 then
				arg_40_1.var_.shakeOldPos = var_43_0.localPosition
			end

			local var_43_2 = 0.2

			if var_43_1 <= arg_40_1.time_ and arg_40_1.time_ < var_43_1 + var_43_2 then
				local var_43_3 = (arg_40_1.time_ - var_43_1) / 0.066
				local var_43_4, var_43_5 = math.modf(var_43_3)

				var_43_0.localPosition = Vector3.New(var_43_5 * 0.13, var_43_5 * 0.13, var_43_5 * 0.13) + arg_40_1.var_.shakeOldPos
			end

			if arg_40_1.time_ >= var_43_1 + var_43_2 and arg_40_1.time_ < var_43_1 + var_43_2 + arg_43_0 then
				var_43_0.localPosition = arg_40_1.var_.shakeOldPos
			end

			local var_43_6 = arg_40_1.actors_["3004_tpose"]
			local var_43_7 = 0

			if var_43_7 < arg_40_1.time_ and arg_40_1.time_ <= var_43_7 + arg_43_0 and not isNil(var_43_6) and arg_40_1.var_.characterEffect3004_tpose == nil then
				arg_40_1.var_.characterEffect3004_tpose = var_43_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_8 = 0.100000001490116

			if var_43_7 <= arg_40_1.time_ and arg_40_1.time_ < var_43_7 + var_43_8 and not isNil(var_43_6) then
				local var_43_9 = (arg_40_1.time_ - var_43_7) / var_43_8

				if arg_40_1.var_.characterEffect3004_tpose and not isNil(var_43_6) then
					local var_43_10 = Mathf.Lerp(0, 0.5, var_43_9)

					arg_40_1.var_.characterEffect3004_tpose.fillFlat = true
					arg_40_1.var_.characterEffect3004_tpose.fillRatio = var_43_10
				end
			end

			if arg_40_1.time_ >= var_43_7 + var_43_8 and arg_40_1.time_ < var_43_7 + var_43_8 + arg_43_0 and not isNil(var_43_6) and arg_40_1.var_.characterEffect3004_tpose then
				local var_43_11 = 0.5

				arg_40_1.var_.characterEffect3004_tpose.fillFlat = true
				arg_40_1.var_.characterEffect3004_tpose.fillRatio = var_43_11
			end

			local var_43_12 = 0
			local var_43_13 = 0.65

			if var_43_12 < arg_40_1.time_ and arg_40_1.time_ <= var_43_12 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				local var_43_14 = arg_40_1:FormatText(StoryNameCfg[76].name)

				arg_40_1.leftNameTxt_.text = var_43_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, true)
				arg_40_1.iconController_:SetSelectedState("hero")

				arg_40_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6065")

				arg_40_1.callingController_:SetSelectedState("normal")

				arg_40_1.keyicon_.color = Color.New(1, 1, 1)
				arg_40_1.icon_.color = Color.New(1, 1, 1)

				local var_43_15 = arg_40_1:GetWordFromCfg(109061010)
				local var_43_16 = arg_40_1:FormatText(var_43_15.content)

				arg_40_1.text_.text = var_43_16

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_17 = 26
				local var_43_18 = utf8.len(var_43_16)
				local var_43_19 = var_43_17 <= 0 and var_43_13 or var_43_13 * (var_43_18 / var_43_17)

				if var_43_19 > 0 and var_43_13 < var_43_19 then
					arg_40_1.talkMaxDuration = var_43_19

					if var_43_19 + var_43_12 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_19 + var_43_12
					end
				end

				arg_40_1.text_.text = var_43_16
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109061", "109061010", "story_v_out_109061.awb") ~= 0 then
					local var_43_20 = manager.audio:GetVoiceLength("story_v_out_109061", "109061010", "story_v_out_109061.awb") / 1000

					if var_43_20 + var_43_12 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_20 + var_43_12
					end

					if var_43_15.prefab_name ~= "" and arg_40_1.actors_[var_43_15.prefab_name] ~= nil then
						local var_43_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_15.prefab_name].transform, "story_v_out_109061", "109061010", "story_v_out_109061.awb")

						arg_40_1:RecordAudio("109061010", var_43_21)
						arg_40_1:RecordAudio("109061010", var_43_21)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_109061", "109061010", "story_v_out_109061.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_109061", "109061010", "story_v_out_109061.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_22 = math.max(var_43_13, arg_40_1.talkMaxDuration)

			if var_43_12 <= arg_40_1.time_ and arg_40_1.time_ < var_43_12 + var_43_22 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_12) / var_43_22

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_12 + var_43_22 and arg_40_1.time_ < var_43_12 + var_43_22 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play109061011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 109061011
		arg_44_1.duration_ = 2.9

		local var_44_0 = {
			ja = 2.866,
			ko = 1.999999999999,
			zh = 2.9,
			en = 2.366
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
				arg_44_0:Play109061012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = arg_44_1.actors_["3004_tpose"]
			local var_47_1 = 0

			if var_47_1 < arg_44_1.time_ and arg_44_1.time_ <= var_47_1 + arg_47_0 and not isNil(var_47_0) and arg_44_1.var_.characterEffect3004_tpose == nil then
				arg_44_1.var_.characterEffect3004_tpose = var_47_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_2 = 0.100000001490116

			if var_47_1 <= arg_44_1.time_ and arg_44_1.time_ < var_47_1 + var_47_2 and not isNil(var_47_0) then
				local var_47_3 = (arg_44_1.time_ - var_47_1) / var_47_2

				if arg_44_1.var_.characterEffect3004_tpose and not isNil(var_47_0) then
					local var_47_4 = Mathf.Lerp(0, 0.5, var_47_3)

					arg_44_1.var_.characterEffect3004_tpose.fillFlat = true
					arg_44_1.var_.characterEffect3004_tpose.fillRatio = var_47_4
				end
			end

			if arg_44_1.time_ >= var_47_1 + var_47_2 and arg_44_1.time_ < var_47_1 + var_47_2 + arg_47_0 and not isNil(var_47_0) and arg_44_1.var_.characterEffect3004_tpose then
				local var_47_5 = 0.5

				arg_44_1.var_.characterEffect3004_tpose.fillFlat = true
				arg_44_1.var_.characterEffect3004_tpose.fillRatio = var_47_5
			end

			local var_47_6 = arg_44_1.actors_["10004ui_story"]
			local var_47_7 = 0

			if var_47_7 < arg_44_1.time_ and arg_44_1.time_ <= var_47_7 + arg_47_0 and not isNil(var_47_6) and arg_44_1.var_.characterEffect10004ui_story == nil then
				arg_44_1.var_.characterEffect10004ui_story = var_47_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_8 = 0.1

			if var_47_7 <= arg_44_1.time_ and arg_44_1.time_ < var_47_7 + var_47_8 and not isNil(var_47_6) then
				local var_47_9 = (arg_44_1.time_ - var_47_7) / var_47_8

				if arg_44_1.var_.characterEffect10004ui_story and not isNil(var_47_6) then
					arg_44_1.var_.characterEffect10004ui_story.fillFlat = false
				end
			end

			if arg_44_1.time_ >= var_47_7 + var_47_8 and arg_44_1.time_ < var_47_7 + var_47_8 + arg_47_0 and not isNil(var_47_6) and arg_44_1.var_.characterEffect10004ui_story then
				arg_44_1.var_.characterEffect10004ui_story.fillFlat = false
			end

			local var_47_10 = 0

			if var_47_10 < arg_44_1.time_ and arg_44_1.time_ <= var_47_10 + arg_47_0 then
				arg_44_1:PlayTimeline("10004ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_47_11 = 0
			local var_47_12 = 0.175

			if var_47_11 < arg_44_1.time_ and arg_44_1.time_ <= var_47_11 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				local var_47_13 = arg_44_1:FormatText(StoryNameCfg[80].name)

				arg_44_1.leftNameTxt_.text = var_47_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_14 = arg_44_1:GetWordFromCfg(109061011)
				local var_47_15 = arg_44_1:FormatText(var_47_14.content)

				arg_44_1.text_.text = var_47_15

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_16 = 7
				local var_47_17 = utf8.len(var_47_15)
				local var_47_18 = var_47_16 <= 0 and var_47_12 or var_47_12 * (var_47_17 / var_47_16)

				if var_47_18 > 0 and var_47_12 < var_47_18 then
					arg_44_1.talkMaxDuration = var_47_18

					if var_47_18 + var_47_11 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_18 + var_47_11
					end
				end

				arg_44_1.text_.text = var_47_15
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109061", "109061011", "story_v_out_109061.awb") ~= 0 then
					local var_47_19 = manager.audio:GetVoiceLength("story_v_out_109061", "109061011", "story_v_out_109061.awb") / 1000

					if var_47_19 + var_47_11 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_19 + var_47_11
					end

					if var_47_14.prefab_name ~= "" and arg_44_1.actors_[var_47_14.prefab_name] ~= nil then
						local var_47_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_14.prefab_name].transform, "story_v_out_109061", "109061011", "story_v_out_109061.awb")

						arg_44_1:RecordAudio("109061011", var_47_20)
						arg_44_1:RecordAudio("109061011", var_47_20)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_109061", "109061011", "story_v_out_109061.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_109061", "109061011", "story_v_out_109061.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_21 = math.max(var_47_12, arg_44_1.talkMaxDuration)

			if var_47_11 <= arg_44_1.time_ and arg_44_1.time_ < var_47_11 + var_47_21 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_11) / var_47_21

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_11 + var_47_21 and arg_44_1.time_ < var_47_11 + var_47_21 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play109061012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 109061012
		arg_48_1.duration_ = 8.27

		local var_48_0 = {
			ja = 8.266,
			ko = 7.233,
			zh = 7.366,
			en = 6.766
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
				arg_48_0:Play109061013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = arg_48_1.actors_["3004_tpose"]
			local var_51_1 = 0

			if var_51_1 < arg_48_1.time_ and arg_48_1.time_ <= var_51_1 + arg_51_0 and not isNil(var_51_0) and arg_48_1.var_.characterEffect3004_tpose == nil then
				arg_48_1.var_.characterEffect3004_tpose = var_51_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_2 = 0.2

			if var_51_1 <= arg_48_1.time_ and arg_48_1.time_ < var_51_1 + var_51_2 and not isNil(var_51_0) then
				local var_51_3 = (arg_48_1.time_ - var_51_1) / var_51_2

				if arg_48_1.var_.characterEffect3004_tpose and not isNil(var_51_0) then
					arg_48_1.var_.characterEffect3004_tpose.fillFlat = false
				end
			end

			if arg_48_1.time_ >= var_51_1 + var_51_2 and arg_48_1.time_ < var_51_1 + var_51_2 + arg_51_0 and not isNil(var_51_0) and arg_48_1.var_.characterEffect3004_tpose then
				arg_48_1.var_.characterEffect3004_tpose.fillFlat = false
			end

			local var_51_4 = arg_48_1.actors_["10004ui_story"]
			local var_51_5 = 0

			if var_51_5 < arg_48_1.time_ and arg_48_1.time_ <= var_51_5 + arg_51_0 and not isNil(var_51_4) and arg_48_1.var_.characterEffect10004ui_story == nil then
				arg_48_1.var_.characterEffect10004ui_story = var_51_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_6 = 0.2

			if var_51_5 <= arg_48_1.time_ and arg_48_1.time_ < var_51_5 + var_51_6 and not isNil(var_51_4) then
				local var_51_7 = (arg_48_1.time_ - var_51_5) / var_51_6

				if arg_48_1.var_.characterEffect10004ui_story and not isNil(var_51_4) then
					local var_51_8 = Mathf.Lerp(0, 0.5, var_51_7)

					arg_48_1.var_.characterEffect10004ui_story.fillFlat = true
					arg_48_1.var_.characterEffect10004ui_story.fillRatio = var_51_8
				end
			end

			if arg_48_1.time_ >= var_51_5 + var_51_6 and arg_48_1.time_ < var_51_5 + var_51_6 + arg_51_0 and not isNil(var_51_4) and arg_48_1.var_.characterEffect10004ui_story then
				local var_51_9 = 0.5

				arg_48_1.var_.characterEffect10004ui_story.fillFlat = true
				arg_48_1.var_.characterEffect10004ui_story.fillRatio = var_51_9
			end

			local var_51_10 = 0
			local var_51_11 = 0.775

			if var_51_10 < arg_48_1.time_ and arg_48_1.time_ <= var_51_10 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				local var_51_12 = arg_48_1:FormatText(StoryNameCfg[82].name)

				arg_48_1.leftNameTxt_.text = var_51_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_13 = arg_48_1:GetWordFromCfg(109061012)
				local var_51_14 = arg_48_1:FormatText(var_51_13.content)

				arg_48_1.text_.text = var_51_14

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_15 = 31
				local var_51_16 = utf8.len(var_51_14)
				local var_51_17 = var_51_15 <= 0 and var_51_11 or var_51_11 * (var_51_16 / var_51_15)

				if var_51_17 > 0 and var_51_11 < var_51_17 then
					arg_48_1.talkMaxDuration = var_51_17

					if var_51_17 + var_51_10 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_17 + var_51_10
					end
				end

				arg_48_1.text_.text = var_51_14
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109061", "109061012", "story_v_out_109061.awb") ~= 0 then
					local var_51_18 = manager.audio:GetVoiceLength("story_v_out_109061", "109061012", "story_v_out_109061.awb") / 1000

					if var_51_18 + var_51_10 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_18 + var_51_10
					end

					if var_51_13.prefab_name ~= "" and arg_48_1.actors_[var_51_13.prefab_name] ~= nil then
						local var_51_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_13.prefab_name].transform, "story_v_out_109061", "109061012", "story_v_out_109061.awb")

						arg_48_1:RecordAudio("109061012", var_51_19)
						arg_48_1:RecordAudio("109061012", var_51_19)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_109061", "109061012", "story_v_out_109061.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_109061", "109061012", "story_v_out_109061.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_20 = math.max(var_51_11, arg_48_1.talkMaxDuration)

			if var_51_10 <= arg_48_1.time_ and arg_48_1.time_ < var_51_10 + var_51_20 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_10) / var_51_20

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_10 + var_51_20 and arg_48_1.time_ < var_51_10 + var_51_20 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play109061013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 109061013
		arg_52_1.duration_ = 1.8

		local var_52_0 = {
			ja = 1.8,
			ko = 1.2,
			zh = 1.533,
			en = 1.633
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
				arg_52_0:Play109061014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = arg_52_1.actors_["3004_tpose"]
			local var_55_1 = 0

			if var_55_1 < arg_52_1.time_ and arg_52_1.time_ <= var_55_1 + arg_55_0 and not isNil(var_55_0) and arg_52_1.var_.characterEffect3004_tpose == nil then
				arg_52_1.var_.characterEffect3004_tpose = var_55_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_2 = 0.100000001490116

			if var_55_1 <= arg_52_1.time_ and arg_52_1.time_ < var_55_1 + var_55_2 and not isNil(var_55_0) then
				local var_55_3 = (arg_52_1.time_ - var_55_1) / var_55_2

				if arg_52_1.var_.characterEffect3004_tpose and not isNil(var_55_0) then
					local var_55_4 = Mathf.Lerp(0, 0.5, var_55_3)

					arg_52_1.var_.characterEffect3004_tpose.fillFlat = true
					arg_52_1.var_.characterEffect3004_tpose.fillRatio = var_55_4
				end
			end

			if arg_52_1.time_ >= var_55_1 + var_55_2 and arg_52_1.time_ < var_55_1 + var_55_2 + arg_55_0 and not isNil(var_55_0) and arg_52_1.var_.characterEffect3004_tpose then
				local var_55_5 = 0.5

				arg_52_1.var_.characterEffect3004_tpose.fillFlat = true
				arg_52_1.var_.characterEffect3004_tpose.fillRatio = var_55_5
			end

			local var_55_6 = 0
			local var_55_7 = 0.125

			if var_55_6 < arg_52_1.time_ and arg_52_1.time_ <= var_55_6 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				local var_55_8 = arg_52_1:FormatText(StoryNameCfg[81].name)

				arg_52_1.leftNameTxt_.text = var_55_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, true)
				arg_52_1.iconController_:SetSelectedState("hero")

				arg_52_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10003")

				arg_52_1.callingController_:SetSelectedState("normal")

				arg_52_1.keyicon_.color = Color.New(1, 1, 1)
				arg_52_1.icon_.color = Color.New(1, 1, 1)

				local var_55_9 = arg_52_1:GetWordFromCfg(109061013)
				local var_55_10 = arg_52_1:FormatText(var_55_9.content)

				arg_52_1.text_.text = var_55_10

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_11 = 5
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

				if manager.audio:GetVoiceLength("story_v_out_109061", "109061013", "story_v_out_109061.awb") ~= 0 then
					local var_55_14 = manager.audio:GetVoiceLength("story_v_out_109061", "109061013", "story_v_out_109061.awb") / 1000

					if var_55_14 + var_55_6 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_14 + var_55_6
					end

					if var_55_9.prefab_name ~= "" and arg_52_1.actors_[var_55_9.prefab_name] ~= nil then
						local var_55_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_9.prefab_name].transform, "story_v_out_109061", "109061013", "story_v_out_109061.awb")

						arg_52_1:RecordAudio("109061013", var_55_15)
						arg_52_1:RecordAudio("109061013", var_55_15)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_109061", "109061013", "story_v_out_109061.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_109061", "109061013", "story_v_out_109061.awb")
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
	Play109061014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 109061014
		arg_56_1.duration_ = 6.7

		local var_56_0 = {
			ja = 3.966,
			ko = 3.5,
			zh = 3.233,
			en = 6.7
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
				arg_56_0:Play109061015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = 0
			local var_59_1 = 0.3

			if var_59_0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_0 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				local var_59_2 = arg_56_1:FormatText(StoryNameCfg[76].name)

				arg_56_1.leftNameTxt_.text = var_59_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, true)
				arg_56_1.iconController_:SetSelectedState("hero")

				arg_56_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6065")

				arg_56_1.callingController_:SetSelectedState("normal")

				arg_56_1.keyicon_.color = Color.New(1, 1, 1)
				arg_56_1.icon_.color = Color.New(1, 1, 1)

				local var_59_3 = arg_56_1:GetWordFromCfg(109061014)
				local var_59_4 = arg_56_1:FormatText(var_59_3.content)

				arg_56_1.text_.text = var_59_4

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_5 = 12
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

				if manager.audio:GetVoiceLength("story_v_out_109061", "109061014", "story_v_out_109061.awb") ~= 0 then
					local var_59_8 = manager.audio:GetVoiceLength("story_v_out_109061", "109061014", "story_v_out_109061.awb") / 1000

					if var_59_8 + var_59_0 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_8 + var_59_0
					end

					if var_59_3.prefab_name ~= "" and arg_56_1.actors_[var_59_3.prefab_name] ~= nil then
						local var_59_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_3.prefab_name].transform, "story_v_out_109061", "109061014", "story_v_out_109061.awb")

						arg_56_1:RecordAudio("109061014", var_59_9)
						arg_56_1:RecordAudio("109061014", var_59_9)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_109061", "109061014", "story_v_out_109061.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_109061", "109061014", "story_v_out_109061.awb")
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
	Play109061015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 109061015
		arg_60_1.duration_ = 5

		local var_60_0 = {
			ja = 4.466,
			ko = 5,
			zh = 4.166,
			en = 4.7
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
				arg_60_0:Play109061016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = 0
			local var_63_1 = 0.45

			if var_63_0 < arg_60_1.time_ and arg_60_1.time_ <= var_63_0 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				local var_63_2 = arg_60_1:FormatText(StoryNameCfg[81].name)

				arg_60_1.leftNameTxt_.text = var_63_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, true)
				arg_60_1.iconController_:SetSelectedState("hero")

				arg_60_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10003")

				arg_60_1.callingController_:SetSelectedState("normal")

				arg_60_1.keyicon_.color = Color.New(1, 1, 1)
				arg_60_1.icon_.color = Color.New(1, 1, 1)

				local var_63_3 = arg_60_1:GetWordFromCfg(109061015)
				local var_63_4 = arg_60_1:FormatText(var_63_3.content)

				arg_60_1.text_.text = var_63_4

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_5 = 18
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

				if manager.audio:GetVoiceLength("story_v_out_109061", "109061015", "story_v_out_109061.awb") ~= 0 then
					local var_63_8 = manager.audio:GetVoiceLength("story_v_out_109061", "109061015", "story_v_out_109061.awb") / 1000

					if var_63_8 + var_63_0 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_8 + var_63_0
					end

					if var_63_3.prefab_name ~= "" and arg_60_1.actors_[var_63_3.prefab_name] ~= nil then
						local var_63_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_3.prefab_name].transform, "story_v_out_109061", "109061015", "story_v_out_109061.awb")

						arg_60_1:RecordAudio("109061015", var_63_9)
						arg_60_1:RecordAudio("109061015", var_63_9)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_109061", "109061015", "story_v_out_109061.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_109061", "109061015", "story_v_out_109061.awb")
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
	Play109061016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 109061016
		arg_64_1.duration_ = 6.8

		local var_64_0 = {
			ja = 5.2,
			ko = 4.3,
			zh = 6.366,
			en = 6.8
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
				arg_64_0:Play109061017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = 0
			local var_67_1 = 0.825

			if var_67_0 < arg_64_1.time_ and arg_64_1.time_ <= var_67_0 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				local var_67_2 = arg_64_1:FormatText(StoryNameCfg[76].name)

				arg_64_1.leftNameTxt_.text = var_67_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, true)
				arg_64_1.iconController_:SetSelectedState("hero")

				arg_64_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6065")

				arg_64_1.callingController_:SetSelectedState("normal")

				arg_64_1.keyicon_.color = Color.New(1, 1, 1)
				arg_64_1.icon_.color = Color.New(1, 1, 1)

				local var_67_3 = arg_64_1:GetWordFromCfg(109061016)
				local var_67_4 = arg_64_1:FormatText(var_67_3.content)

				arg_64_1.text_.text = var_67_4

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_5 = 33
				local var_67_6 = utf8.len(var_67_4)
				local var_67_7 = var_67_5 <= 0 and var_67_1 or var_67_1 * (var_67_6 / var_67_5)

				if var_67_7 > 0 and var_67_1 < var_67_7 then
					arg_64_1.talkMaxDuration = var_67_7

					if var_67_7 + var_67_0 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_7 + var_67_0
					end
				end

				arg_64_1.text_.text = var_67_4
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109061", "109061016", "story_v_out_109061.awb") ~= 0 then
					local var_67_8 = manager.audio:GetVoiceLength("story_v_out_109061", "109061016", "story_v_out_109061.awb") / 1000

					if var_67_8 + var_67_0 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_8 + var_67_0
					end

					if var_67_3.prefab_name ~= "" and arg_64_1.actors_[var_67_3.prefab_name] ~= nil then
						local var_67_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_3.prefab_name].transform, "story_v_out_109061", "109061016", "story_v_out_109061.awb")

						arg_64_1:RecordAudio("109061016", var_67_9)
						arg_64_1:RecordAudio("109061016", var_67_9)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_109061", "109061016", "story_v_out_109061.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_109061", "109061016", "story_v_out_109061.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_10 = math.max(var_67_1, arg_64_1.talkMaxDuration)

			if var_67_0 <= arg_64_1.time_ and arg_64_1.time_ < var_67_0 + var_67_10 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_0) / var_67_10

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_0 + var_67_10 and arg_64_1.time_ < var_67_0 + var_67_10 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {}

		arg_64_1:InitPlayNodeList()
	end,
	Play109061017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 109061017
		arg_68_1.duration_ = 3.4

		local var_68_0 = {
			ja = 2.833,
			ko = 2.166,
			zh = 3.366,
			en = 3.4
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
				arg_68_0:Play109061018(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = arg_68_1.actors_["3004_tpose"]
			local var_71_1 = 0

			if var_71_1 < arg_68_1.time_ and arg_68_1.time_ <= var_71_1 + arg_71_0 and not isNil(var_71_0) and arg_68_1.var_.characterEffect3004_tpose == nil then
				arg_68_1.var_.characterEffect3004_tpose = var_71_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_2 = 0.2

			if var_71_1 <= arg_68_1.time_ and arg_68_1.time_ < var_71_1 + var_71_2 and not isNil(var_71_0) then
				local var_71_3 = (arg_68_1.time_ - var_71_1) / var_71_2

				if arg_68_1.var_.characterEffect3004_tpose and not isNil(var_71_0) then
					arg_68_1.var_.characterEffect3004_tpose.fillFlat = false
				end
			end

			if arg_68_1.time_ >= var_71_1 + var_71_2 and arg_68_1.time_ < var_71_1 + var_71_2 + arg_71_0 and not isNil(var_71_0) and arg_68_1.var_.characterEffect3004_tpose then
				arg_68_1.var_.characterEffect3004_tpose.fillFlat = false
			end

			local var_71_4 = 0
			local var_71_5 = 0.175

			if var_71_4 < arg_68_1.time_ and arg_68_1.time_ <= var_71_4 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				local var_71_6 = arg_68_1:FormatText(StoryNameCfg[82].name)

				arg_68_1.leftNameTxt_.text = var_71_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_7 = arg_68_1:GetWordFromCfg(109061017)
				local var_71_8 = arg_68_1:FormatText(var_71_7.content)

				arg_68_1.text_.text = var_71_8

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_9 = 7
				local var_71_10 = utf8.len(var_71_8)
				local var_71_11 = var_71_9 <= 0 and var_71_5 or var_71_5 * (var_71_10 / var_71_9)

				if var_71_11 > 0 and var_71_5 < var_71_11 then
					arg_68_1.talkMaxDuration = var_71_11

					if var_71_11 + var_71_4 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_11 + var_71_4
					end
				end

				arg_68_1.text_.text = var_71_8
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109061", "109061017", "story_v_out_109061.awb") ~= 0 then
					local var_71_12 = manager.audio:GetVoiceLength("story_v_out_109061", "109061017", "story_v_out_109061.awb") / 1000

					if var_71_12 + var_71_4 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_12 + var_71_4
					end

					if var_71_7.prefab_name ~= "" and arg_68_1.actors_[var_71_7.prefab_name] ~= nil then
						local var_71_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_7.prefab_name].transform, "story_v_out_109061", "109061017", "story_v_out_109061.awb")

						arg_68_1:RecordAudio("109061017", var_71_13)
						arg_68_1:RecordAudio("109061017", var_71_13)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_109061", "109061017", "story_v_out_109061.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_109061", "109061017", "story_v_out_109061.awb")
				end

				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_14 = math.max(var_71_5, arg_68_1.talkMaxDuration)

			if var_71_4 <= arg_68_1.time_ and arg_68_1.time_ < var_71_4 + var_71_14 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_4) / var_71_14

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_4 + var_71_14 and arg_68_1.time_ < var_71_4 + var_71_14 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {}

		arg_68_1:InitPlayNodeList()
	end,
	Play109061018 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 109061018
		arg_72_1.duration_ = 5

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play109061019(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = 0
			local var_75_1 = 0.475

			if var_75_0 < arg_72_1.time_ and arg_72_1.time_ <= var_75_0 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, false)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_2 = arg_72_1:GetWordFromCfg(109061018)
				local var_75_3 = arg_72_1:FormatText(var_75_2.content)

				arg_72_1.text_.text = var_75_3

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_4 = 19
				local var_75_5 = utf8.len(var_75_3)
				local var_75_6 = var_75_4 <= 0 and var_75_1 or var_75_1 * (var_75_5 / var_75_4)

				if var_75_6 > 0 and var_75_1 < var_75_6 then
					arg_72_1.talkMaxDuration = var_75_6

					if var_75_6 + var_75_0 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_6 + var_75_0
					end
				end

				arg_72_1.text_.text = var_75_3
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)
				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_7 = math.max(var_75_1, arg_72_1.talkMaxDuration)

			if var_75_0 <= arg_72_1.time_ and arg_72_1.time_ < var_75_0 + var_75_7 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_0) / var_75_7

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_0 + var_75_7 and arg_72_1.time_ < var_75_0 + var_75_7 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {}

		arg_72_1:InitPlayNodeList()
	end,
	Play109061019 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 109061019
		arg_76_1.duration_ = 4.07

		local var_76_0 = {
			ja = 4.066,
			ko = 2.6,
			zh = 2.466,
			en = 3.233
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
				arg_76_0:Play109061020(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = manager.ui.mainCamera.transform
			local var_79_1 = 0.1

			if var_79_1 < arg_76_1.time_ and arg_76_1.time_ <= var_79_1 + arg_79_0 then
				arg_76_1.var_.shakeOldPos = var_79_0.localPosition
			end

			local var_79_2 = 0.8

			if var_79_1 <= arg_76_1.time_ and arg_76_1.time_ < var_79_1 + var_79_2 then
				local var_79_3 = (arg_76_1.time_ - var_79_1) / 0.099
				local var_79_4, var_79_5 = math.modf(var_79_3)

				var_79_0.localPosition = Vector3.New(var_79_5 * 0.13, var_79_5 * 0.13, var_79_5 * 0.13) + arg_76_1.var_.shakeOldPos
			end

			if arg_76_1.time_ >= var_79_1 + var_79_2 and arg_76_1.time_ < var_79_1 + var_79_2 + arg_79_0 then
				var_79_0.localPosition = arg_76_1.var_.shakeOldPos
			end

			local var_79_6 = 0
			local var_79_7 = 0.2

			if var_79_6 < arg_76_1.time_ and arg_76_1.time_ <= var_79_6 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				local var_79_8 = arg_76_1:FormatText(StoryNameCfg[76].name)

				arg_76_1.leftNameTxt_.text = var_79_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, true)
				arg_76_1.iconController_:SetSelectedState("hero")

				arg_76_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6065")

				arg_76_1.callingController_:SetSelectedState("normal")

				arg_76_1.keyicon_.color = Color.New(1, 1, 1)
				arg_76_1.icon_.color = Color.New(1, 1, 1)

				local var_79_9 = arg_76_1:GetWordFromCfg(109061019)
				local var_79_10 = arg_76_1:FormatText(var_79_9.content)

				arg_76_1.text_.text = var_79_10

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_11 = 8
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

				if manager.audio:GetVoiceLength("story_v_out_109061", "109061019", "story_v_out_109061.awb") ~= 0 then
					local var_79_14 = manager.audio:GetVoiceLength("story_v_out_109061", "109061019", "story_v_out_109061.awb") / 1000

					if var_79_14 + var_79_6 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_14 + var_79_6
					end

					if var_79_9.prefab_name ~= "" and arg_76_1.actors_[var_79_9.prefab_name] ~= nil then
						local var_79_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_9.prefab_name].transform, "story_v_out_109061", "109061019", "story_v_out_109061.awb")

						arg_76_1:RecordAudio("109061019", var_79_15)
						arg_76_1:RecordAudio("109061019", var_79_15)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_109061", "109061019", "story_v_out_109061.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_109061", "109061019", "story_v_out_109061.awb")
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
	Play109061020 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 109061020
		arg_80_1.duration_ = 5

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play109061021(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = arg_80_1.actors_["3004_tpose"].transform
			local var_83_1 = 0

			if var_83_1 < arg_80_1.time_ and arg_80_1.time_ <= var_83_1 + arg_83_0 then
				arg_80_1.var_.moveOldPos3004_tpose = var_83_0.localPosition

				local var_83_2 = GameObjectTools.GetOrAddComponent(var_83_0.gameObject, typeof(DynamicBoneHelper))

				if var_83_2 then
					var_83_2:EnableDynamicBone(false)
				end
			end

			local var_83_3 = 0.001

			if var_83_1 <= arg_80_1.time_ and arg_80_1.time_ < var_83_1 + var_83_3 then
				local var_83_4 = (arg_80_1.time_ - var_83_1) / var_83_3
				local var_83_5 = Vector3.New(0, 100, 0)

				var_83_0.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPos3004_tpose, var_83_5, var_83_4)

				local var_83_6 = manager.ui.mainCamera.transform.position - var_83_0.position

				var_83_0.forward = Vector3.New(var_83_6.x, var_83_6.y, var_83_6.z)

				local var_83_7 = var_83_0.localEulerAngles

				var_83_7.z = 0
				var_83_7.x = 0
				var_83_0.localEulerAngles = var_83_7
			end

			if arg_80_1.time_ >= var_83_1 + var_83_3 and arg_80_1.time_ < var_83_1 + var_83_3 + arg_83_0 then
				var_83_0.localPosition = Vector3.New(0, 100, 0)

				local var_83_8 = manager.ui.mainCamera.transform.position - var_83_0.position

				var_83_0.forward = Vector3.New(var_83_8.x, var_83_8.y, var_83_8.z)

				local var_83_9 = var_83_0.localEulerAngles

				var_83_9.z = 0
				var_83_9.x = 0
				var_83_0.localEulerAngles = var_83_9

				local var_83_10 = GameObjectTools.GetOrAddComponent(var_83_0.gameObject, typeof(DynamicBoneHelper))

				if var_83_10 then
					var_83_10:EnableDynamicBone(true)
				end
			end

			local var_83_11 = arg_80_1.actors_["10004ui_story"].transform
			local var_83_12 = 0

			if var_83_12 < arg_80_1.time_ and arg_80_1.time_ <= var_83_12 + arg_83_0 then
				arg_80_1.var_.moveOldPos10004ui_story = var_83_11.localPosition
			end

			local var_83_13 = 0.001

			if var_83_12 <= arg_80_1.time_ and arg_80_1.time_ < var_83_12 + var_83_13 then
				local var_83_14 = (arg_80_1.time_ - var_83_12) / var_83_13
				local var_83_15 = Vector3.New(0, 100, 0)

				var_83_11.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPos10004ui_story, var_83_15, var_83_14)

				local var_83_16 = manager.ui.mainCamera.transform.position - var_83_11.position

				var_83_11.forward = Vector3.New(var_83_16.x, var_83_16.y, var_83_16.z)

				local var_83_17 = var_83_11.localEulerAngles

				var_83_17.z = 0
				var_83_17.x = 0
				var_83_11.localEulerAngles = var_83_17
			end

			if arg_80_1.time_ >= var_83_12 + var_83_13 and arg_80_1.time_ < var_83_12 + var_83_13 + arg_83_0 then
				var_83_11.localPosition = Vector3.New(0, 100, 0)

				local var_83_18 = manager.ui.mainCamera.transform.position - var_83_11.position

				var_83_11.forward = Vector3.New(var_83_18.x, var_83_18.y, var_83_18.z)

				local var_83_19 = var_83_11.localEulerAngles

				var_83_19.z = 0
				var_83_19.x = 0
				var_83_11.localEulerAngles = var_83_19
			end

			local var_83_20 = 0
			local var_83_21 = 0.925

			if var_83_20 < arg_80_1.time_ and arg_80_1.time_ <= var_83_20 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0

				arg_80_1.dialog_:SetActive(true)

				arg_80_1.dialogCg_.alpha = 0

				local var_83_22 = LeanTween.value(arg_80_1.dialog_, 0, 1, 0.3)

				var_83_22:setOnUpdate(LuaHelper.FloatAction(function(arg_84_0)
					arg_80_1.dialogCg_.alpha = arg_84_0
				end))
				var_83_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_80_1.dialog_)
					var_83_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_80_1.duration_ = arg_80_1.duration_ + 0.3

				SetActive(arg_80_1.leftNameGo_, false)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_23 = arg_80_1:GetWordFromCfg(109061020)
				local var_83_24 = arg_80_1:FormatText(var_83_23.content)

				arg_80_1.text_.text = var_83_24

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_25 = 37
				local var_83_26 = utf8.len(var_83_24)
				local var_83_27 = var_83_25 <= 0 and var_83_21 or var_83_21 * (var_83_26 / var_83_25)

				if var_83_27 > 0 and var_83_21 < var_83_27 then
					arg_80_1.talkMaxDuration = var_83_27
					var_83_20 = var_83_20 + 0.3

					if var_83_27 + var_83_20 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_27 + var_83_20
					end
				end

				arg_80_1.text_.text = var_83_24
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)
				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_28 = var_83_20 + 0.3
			local var_83_29 = math.max(var_83_21, arg_80_1.talkMaxDuration)

			if var_83_28 <= arg_80_1.time_ and arg_80_1.time_ < var_83_28 + var_83_29 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_28) / var_83_29

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_28 + var_83_29 and arg_80_1.time_ < var_83_28 + var_83_29 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {
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
				actorName = "10004ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_80_1:InitPlayNodeList()
	end,
	Play109061021 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 109061021
		arg_86_1.duration_ = 2.8

		local var_86_0 = {
			ja = 2.5,
			ko = 2.1,
			zh = 2.8,
			en = 2.466
		}
		local var_86_1 = manager.audio:GetLocalizationFlag()

		if var_86_0[var_86_1] ~= nil then
			arg_86_1.duration_ = var_86_0[var_86_1]
		end

		SetActive(arg_86_1.tipsGo_, false)

		function arg_86_1.onSingleLineFinish_()
			arg_86_1.onSingleLineUpdate_ = nil
			arg_86_1.onSingleLineFinish_ = nil
			arg_86_1.state_ = "waiting"
		end

		function arg_86_1.playNext_(arg_88_0)
			if arg_88_0 == 1 then
				arg_86_0:Play109061022(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			local var_89_0 = "1084ui_story"

			if arg_86_1.actors_[var_89_0] == nil then
				local var_89_1 = Asset.Load("Char/" .. "1084ui_story")

				if not isNil(var_89_1) then
					local var_89_2 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_86_1.stage_.transform)

					var_89_2.name = var_89_0
					var_89_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_86_1.actors_[var_89_0] = var_89_2

					local var_89_3 = var_89_2:GetComponentInChildren(typeof(CharacterEffect))

					var_89_3.enabled = true

					local var_89_4 = GameObjectTools.GetOrAddComponent(var_89_2, typeof(DynamicBoneHelper))

					if var_89_4 then
						var_89_4:EnableDynamicBone(false)
					end

					arg_86_1:ShowWeapon(var_89_3.transform, false)

					arg_86_1.var_[var_89_0 .. "Animator"] = var_89_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_86_1.var_[var_89_0 .. "Animator"].applyRootMotion = true
					arg_86_1.var_[var_89_0 .. "LipSync"] = var_89_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_89_5 = arg_86_1.actors_["1084ui_story"].transform
			local var_89_6 = 0

			if var_89_6 < arg_86_1.time_ and arg_86_1.time_ <= var_89_6 + arg_89_0 then
				arg_86_1.var_.moveOldPos1084ui_story = var_89_5.localPosition
			end

			local var_89_7 = 0.001

			if var_89_6 <= arg_86_1.time_ and arg_86_1.time_ < var_89_6 + var_89_7 then
				local var_89_8 = (arg_86_1.time_ - var_89_6) / var_89_7
				local var_89_9 = Vector3.New(0, -0.97, -6)

				var_89_5.localPosition = Vector3.Lerp(arg_86_1.var_.moveOldPos1084ui_story, var_89_9, var_89_8)

				local var_89_10 = manager.ui.mainCamera.transform.position - var_89_5.position

				var_89_5.forward = Vector3.New(var_89_10.x, var_89_10.y, var_89_10.z)

				local var_89_11 = var_89_5.localEulerAngles

				var_89_11.z = 0
				var_89_11.x = 0
				var_89_5.localEulerAngles = var_89_11
			end

			if arg_86_1.time_ >= var_89_6 + var_89_7 and arg_86_1.time_ < var_89_6 + var_89_7 + arg_89_0 then
				var_89_5.localPosition = Vector3.New(0, -0.97, -6)

				local var_89_12 = manager.ui.mainCamera.transform.position - var_89_5.position

				var_89_5.forward = Vector3.New(var_89_12.x, var_89_12.y, var_89_12.z)

				local var_89_13 = var_89_5.localEulerAngles

				var_89_13.z = 0
				var_89_13.x = 0
				var_89_5.localEulerAngles = var_89_13
			end

			local var_89_14 = arg_86_1.actors_["1084ui_story"]
			local var_89_15 = 0

			if var_89_15 < arg_86_1.time_ and arg_86_1.time_ <= var_89_15 + arg_89_0 and not isNil(var_89_14) and arg_86_1.var_.characterEffect1084ui_story == nil then
				arg_86_1.var_.characterEffect1084ui_story = var_89_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_89_16 = 0.2

			if var_89_15 <= arg_86_1.time_ and arg_86_1.time_ < var_89_15 + var_89_16 and not isNil(var_89_14) then
				local var_89_17 = (arg_86_1.time_ - var_89_15) / var_89_16

				if arg_86_1.var_.characterEffect1084ui_story and not isNil(var_89_14) then
					arg_86_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_86_1.time_ >= var_89_15 + var_89_16 and arg_86_1.time_ < var_89_15 + var_89_16 + arg_89_0 and not isNil(var_89_14) and arg_86_1.var_.characterEffect1084ui_story then
				arg_86_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_89_18 = 0

			if var_89_18 < arg_86_1.time_ and arg_86_1.time_ <= var_89_18 + arg_89_0 then
				arg_86_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			local var_89_19 = 0

			if var_89_19 < arg_86_1.time_ and arg_86_1.time_ <= var_89_19 + arg_89_0 then
				arg_86_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_89_20 = 0
			local var_89_21 = 0.25

			if var_89_20 < arg_86_1.time_ and arg_86_1.time_ <= var_89_20 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, true)

				local var_89_22 = arg_86_1:FormatText(StoryNameCfg[6].name)

				arg_86_1.leftNameTxt_.text = var_89_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_23 = arg_86_1:GetWordFromCfg(109061021)
				local var_89_24 = arg_86_1:FormatText(var_89_23.content)

				arg_86_1.text_.text = var_89_24

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_25 = 10
				local var_89_26 = utf8.len(var_89_24)
				local var_89_27 = var_89_25 <= 0 and var_89_21 or var_89_21 * (var_89_26 / var_89_25)

				if var_89_27 > 0 and var_89_21 < var_89_27 then
					arg_86_1.talkMaxDuration = var_89_27

					if var_89_27 + var_89_20 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_27 + var_89_20
					end
				end

				arg_86_1.text_.text = var_89_24
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109061", "109061021", "story_v_out_109061.awb") ~= 0 then
					local var_89_28 = manager.audio:GetVoiceLength("story_v_out_109061", "109061021", "story_v_out_109061.awb") / 1000

					if var_89_28 + var_89_20 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_28 + var_89_20
					end

					if var_89_23.prefab_name ~= "" and arg_86_1.actors_[var_89_23.prefab_name] ~= nil then
						local var_89_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_86_1.actors_[var_89_23.prefab_name].transform, "story_v_out_109061", "109061021", "story_v_out_109061.awb")

						arg_86_1:RecordAudio("109061021", var_89_29)
						arg_86_1:RecordAudio("109061021", var_89_29)
					else
						arg_86_1:AudioAction("play", "voice", "story_v_out_109061", "109061021", "story_v_out_109061.awb")
					end

					arg_86_1:RecordHistoryTalkVoice("story_v_out_109061", "109061021", "story_v_out_109061.awb")
				end

				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_30 = math.max(var_89_21, arg_86_1.talkMaxDuration)

			if var_89_20 <= arg_86_1.time_ and arg_86_1.time_ < var_89_20 + var_89_30 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_20) / var_89_30

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_20 + var_89_30 and arg_86_1.time_ < var_89_20 + var_89_30 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {
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

		arg_86_1:InitPlayNodeList()
	end,
	Play109061022 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 109061022
		arg_90_1.duration_ = 7.47

		local var_90_0 = {
			ja = 7.466,
			ko = 6.233,
			zh = 6.6,
			en = 6.966
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
				arg_90_0:Play109061023(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			local var_93_0 = 0
			local var_93_1 = 0.4

			if var_93_0 < arg_90_1.time_ and arg_90_1.time_ <= var_93_0 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				local var_93_2 = arg_90_1:FormatText(StoryNameCfg[76].name)

				arg_90_1.leftNameTxt_.text = var_93_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, true)
				arg_90_1.iconController_:SetSelectedState("hero")

				arg_90_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6065")

				arg_90_1.callingController_:SetSelectedState("normal")

				arg_90_1.keyicon_.color = Color.New(1, 1, 1)
				arg_90_1.icon_.color = Color.New(1, 1, 1)

				local var_93_3 = arg_90_1:GetWordFromCfg(109061022)
				local var_93_4 = arg_90_1:FormatText(var_93_3.content)

				arg_90_1.text_.text = var_93_4

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_5 = 16
				local var_93_6 = utf8.len(var_93_4)
				local var_93_7 = var_93_5 <= 0 and var_93_1 or var_93_1 * (var_93_6 / var_93_5)

				if var_93_7 > 0 and var_93_1 < var_93_7 then
					arg_90_1.talkMaxDuration = var_93_7

					if var_93_7 + var_93_0 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_7 + var_93_0
					end
				end

				arg_90_1.text_.text = var_93_4
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109061", "109061022", "story_v_out_109061.awb") ~= 0 then
					local var_93_8 = manager.audio:GetVoiceLength("story_v_out_109061", "109061022", "story_v_out_109061.awb") / 1000

					if var_93_8 + var_93_0 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_8 + var_93_0
					end

					if var_93_3.prefab_name ~= "" and arg_90_1.actors_[var_93_3.prefab_name] ~= nil then
						local var_93_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_90_1.actors_[var_93_3.prefab_name].transform, "story_v_out_109061", "109061022", "story_v_out_109061.awb")

						arg_90_1:RecordAudio("109061022", var_93_9)
						arg_90_1:RecordAudio("109061022", var_93_9)
					else
						arg_90_1:AudioAction("play", "voice", "story_v_out_109061", "109061022", "story_v_out_109061.awb")
					end

					arg_90_1:RecordHistoryTalkVoice("story_v_out_109061", "109061022", "story_v_out_109061.awb")
				end

				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_10 = math.max(var_93_1, arg_90_1.talkMaxDuration)

			if var_93_0 <= arg_90_1.time_ and arg_90_1.time_ < var_93_0 + var_93_10 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_0) / var_93_10

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_0 + var_93_10 and arg_90_1.time_ < var_93_0 + var_93_10 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {}

		arg_90_1:InitPlayNodeList()
	end,
	Play109061023 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 109061023
		arg_94_1.duration_ = 9.53

		local var_94_0 = {
			ja = 5.933,
			ko = 6.633,
			zh = 8.3,
			en = 9.533
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
				arg_94_0:Play109061024(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			local var_97_0 = arg_94_1.actors_["1084ui_story"].transform
			local var_97_1 = 0

			if var_97_1 < arg_94_1.time_ and arg_94_1.time_ <= var_97_1 + arg_97_0 then
				arg_94_1.var_.moveOldPos1084ui_story = var_97_0.localPosition
			end

			local var_97_2 = 0.001

			if var_97_1 <= arg_94_1.time_ and arg_94_1.time_ < var_97_1 + var_97_2 then
				local var_97_3 = (arg_94_1.time_ - var_97_1) / var_97_2
				local var_97_4 = Vector3.New(0, 100, 0)

				var_97_0.localPosition = Vector3.Lerp(arg_94_1.var_.moveOldPos1084ui_story, var_97_4, var_97_3)

				local var_97_5 = manager.ui.mainCamera.transform.position - var_97_0.position

				var_97_0.forward = Vector3.New(var_97_5.x, var_97_5.y, var_97_5.z)

				local var_97_6 = var_97_0.localEulerAngles

				var_97_6.z = 0
				var_97_6.x = 0
				var_97_0.localEulerAngles = var_97_6
			end

			if arg_94_1.time_ >= var_97_1 + var_97_2 and arg_94_1.time_ < var_97_1 + var_97_2 + arg_97_0 then
				var_97_0.localPosition = Vector3.New(0, 100, 0)

				local var_97_7 = manager.ui.mainCamera.transform.position - var_97_0.position

				var_97_0.forward = Vector3.New(var_97_7.x, var_97_7.y, var_97_7.z)

				local var_97_8 = var_97_0.localEulerAngles

				var_97_8.z = 0
				var_97_8.x = 0
				var_97_0.localEulerAngles = var_97_8
			end

			local var_97_9 = arg_94_1.actors_["3004_tpose"].transform
			local var_97_10 = 0

			if var_97_10 < arg_94_1.time_ and arg_94_1.time_ <= var_97_10 + arg_97_0 then
				arg_94_1.var_.moveOldPos3004_tpose = var_97_9.localPosition

				local var_97_11 = GameObjectTools.GetOrAddComponent(var_97_9.gameObject, typeof(DynamicBoneHelper))

				if var_97_11 then
					var_97_11:EnableDynamicBone(false)
				end
			end

			local var_97_12 = 0.001

			if var_97_10 <= arg_94_1.time_ and arg_94_1.time_ < var_97_10 + var_97_12 then
				local var_97_13 = (arg_94_1.time_ - var_97_10) / var_97_12
				local var_97_14 = Vector3.New(0, -2.22, -3.1)

				var_97_9.localPosition = Vector3.Lerp(arg_94_1.var_.moveOldPos3004_tpose, var_97_14, var_97_13)

				local var_97_15 = manager.ui.mainCamera.transform.position - var_97_9.position

				var_97_9.forward = Vector3.New(var_97_15.x, var_97_15.y, var_97_15.z)

				local var_97_16 = var_97_9.localEulerAngles

				var_97_16.z = 0
				var_97_16.x = 0
				var_97_9.localEulerAngles = var_97_16
			end

			if arg_94_1.time_ >= var_97_10 + var_97_12 and arg_94_1.time_ < var_97_10 + var_97_12 + arg_97_0 then
				var_97_9.localPosition = Vector3.New(0, -2.22, -3.1)

				local var_97_17 = manager.ui.mainCamera.transform.position - var_97_9.position

				var_97_9.forward = Vector3.New(var_97_17.x, var_97_17.y, var_97_17.z)

				local var_97_18 = var_97_9.localEulerAngles

				var_97_18.z = 0
				var_97_18.x = 0
				var_97_9.localEulerAngles = var_97_18

				local var_97_19 = GameObjectTools.GetOrAddComponent(var_97_9.gameObject, typeof(DynamicBoneHelper))

				if var_97_19 then
					var_97_19:EnableDynamicBone(true)
				end
			end

			local var_97_20 = arg_94_1.actors_["3004_tpose"]
			local var_97_21 = 0

			if var_97_21 < arg_94_1.time_ and arg_94_1.time_ <= var_97_21 + arg_97_0 and not isNil(var_97_20) and arg_94_1.var_.characterEffect3004_tpose == nil then
				arg_94_1.var_.characterEffect3004_tpose = var_97_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_97_22 = 0.2

			if var_97_21 <= arg_94_1.time_ and arg_94_1.time_ < var_97_21 + var_97_22 and not isNil(var_97_20) then
				local var_97_23 = (arg_94_1.time_ - var_97_21) / var_97_22

				if arg_94_1.var_.characterEffect3004_tpose and not isNil(var_97_20) then
					arg_94_1.var_.characterEffect3004_tpose.fillFlat = false
				end
			end

			if arg_94_1.time_ >= var_97_21 + var_97_22 and arg_94_1.time_ < var_97_21 + var_97_22 + arg_97_0 and not isNil(var_97_20) and arg_94_1.var_.characterEffect3004_tpose then
				arg_94_1.var_.characterEffect3004_tpose.fillFlat = false
			end

			local var_97_24 = 0

			if var_97_24 < arg_94_1.time_ and arg_94_1.time_ <= var_97_24 + arg_97_0 then
				arg_94_1:PlayTimeline("3004_tpose", "StoryTimeline/CharAction/story3004/story3004action/3004action1_1")
			end

			local var_97_25 = 0
			local var_97_26 = 0.7

			if var_97_25 < arg_94_1.time_ and arg_94_1.time_ <= var_97_25 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				local var_97_27 = arg_94_1:FormatText(StoryNameCfg[82].name)

				arg_94_1.leftNameTxt_.text = var_97_27

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_28 = arg_94_1:GetWordFromCfg(109061023)
				local var_97_29 = arg_94_1:FormatText(var_97_28.content)

				arg_94_1.text_.text = var_97_29

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_30 = 28
				local var_97_31 = utf8.len(var_97_29)
				local var_97_32 = var_97_30 <= 0 and var_97_26 or var_97_26 * (var_97_31 / var_97_30)

				if var_97_32 > 0 and var_97_26 < var_97_32 then
					arg_94_1.talkMaxDuration = var_97_32

					if var_97_32 + var_97_25 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_32 + var_97_25
					end
				end

				arg_94_1.text_.text = var_97_29
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109061", "109061023", "story_v_out_109061.awb") ~= 0 then
					local var_97_33 = manager.audio:GetVoiceLength("story_v_out_109061", "109061023", "story_v_out_109061.awb") / 1000

					if var_97_33 + var_97_25 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_33 + var_97_25
					end

					if var_97_28.prefab_name ~= "" and arg_94_1.actors_[var_97_28.prefab_name] ~= nil then
						local var_97_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_94_1.actors_[var_97_28.prefab_name].transform, "story_v_out_109061", "109061023", "story_v_out_109061.awb")

						arg_94_1:RecordAudio("109061023", var_97_34)
						arg_94_1:RecordAudio("109061023", var_97_34)
					else
						arg_94_1:AudioAction("play", "voice", "story_v_out_109061", "109061023", "story_v_out_109061.awb")
					end

					arg_94_1:RecordHistoryTalkVoice("story_v_out_109061", "109061023", "story_v_out_109061.awb")
				end

				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_35 = math.max(var_97_26, arg_94_1.talkMaxDuration)

			if var_97_25 <= arg_94_1.time_ and arg_94_1.time_ < var_97_25 + var_97_35 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_25) / var_97_35

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_25 + var_97_35 and arg_94_1.time_ < var_97_25 + var_97_35 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {
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
				actorName = "3004_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_94_1:InitPlayNodeList()
	end,
	Play109061024 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 109061024
		arg_98_1.duration_ = 4.63

		local var_98_0 = {
			ja = 2.466,
			ko = 2.8,
			zh = 3.7,
			en = 4.633
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
				arg_98_0:Play109061025(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			local var_101_0 = arg_98_1.actors_["3004_tpose"].transform
			local var_101_1 = 0

			if var_101_1 < arg_98_1.time_ and arg_98_1.time_ <= var_101_1 + arg_101_0 then
				arg_98_1.var_.moveOldPos3004_tpose = var_101_0.localPosition

				local var_101_2 = GameObjectTools.GetOrAddComponent(var_101_0.gameObject, typeof(DynamicBoneHelper))

				if var_101_2 then
					var_101_2:EnableDynamicBone(false)
				end
			end

			local var_101_3 = 0.001

			if var_101_1 <= arg_98_1.time_ and arg_98_1.time_ < var_101_1 + var_101_3 then
				local var_101_4 = (arg_98_1.time_ - var_101_1) / var_101_3
				local var_101_5 = Vector3.New(0, 100, 0)

				var_101_0.localPosition = Vector3.Lerp(arg_98_1.var_.moveOldPos3004_tpose, var_101_5, var_101_4)

				local var_101_6 = manager.ui.mainCamera.transform.position - var_101_0.position

				var_101_0.forward = Vector3.New(var_101_6.x, var_101_6.y, var_101_6.z)

				local var_101_7 = var_101_0.localEulerAngles

				var_101_7.z = 0
				var_101_7.x = 0
				var_101_0.localEulerAngles = var_101_7
			end

			if arg_98_1.time_ >= var_101_1 + var_101_3 and arg_98_1.time_ < var_101_1 + var_101_3 + arg_101_0 then
				var_101_0.localPosition = Vector3.New(0, 100, 0)

				local var_101_8 = manager.ui.mainCamera.transform.position - var_101_0.position

				var_101_0.forward = Vector3.New(var_101_8.x, var_101_8.y, var_101_8.z)

				local var_101_9 = var_101_0.localEulerAngles

				var_101_9.z = 0
				var_101_9.x = 0
				var_101_0.localEulerAngles = var_101_9

				local var_101_10 = GameObjectTools.GetOrAddComponent(var_101_0.gameObject, typeof(DynamicBoneHelper))

				if var_101_10 then
					var_101_10:EnableDynamicBone(true)
				end
			end

			local var_101_11 = "1099ui_story"

			if arg_98_1.actors_[var_101_11] == nil then
				local var_101_12 = Asset.Load("Char/" .. "1099ui_story")

				if not isNil(var_101_12) then
					local var_101_13 = Object.Instantiate(Asset.Load("Char/" .. "1099ui_story"), arg_98_1.stage_.transform)

					var_101_13.name = var_101_11
					var_101_13.transform.localPosition = Vector3.New(0, 100, 0)
					arg_98_1.actors_[var_101_11] = var_101_13

					local var_101_14 = var_101_13:GetComponentInChildren(typeof(CharacterEffect))

					var_101_14.enabled = true

					local var_101_15 = GameObjectTools.GetOrAddComponent(var_101_13, typeof(DynamicBoneHelper))

					if var_101_15 then
						var_101_15:EnableDynamicBone(false)
					end

					arg_98_1:ShowWeapon(var_101_14.transform, false)

					arg_98_1.var_[var_101_11 .. "Animator"] = var_101_14.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_98_1.var_[var_101_11 .. "Animator"].applyRootMotion = true
					arg_98_1.var_[var_101_11 .. "LipSync"] = var_101_14.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_101_16 = arg_98_1.actors_["1099ui_story"].transform
			local var_101_17 = 0

			if var_101_17 < arg_98_1.time_ and arg_98_1.time_ <= var_101_17 + arg_101_0 then
				arg_98_1.var_.moveOldPos1099ui_story = var_101_16.localPosition
			end

			local var_101_18 = 0.001

			if var_101_17 <= arg_98_1.time_ and arg_98_1.time_ < var_101_17 + var_101_18 then
				local var_101_19 = (arg_98_1.time_ - var_101_17) / var_101_18
				local var_101_20 = Vector3.New(0, -1.08, -5.9)

				var_101_16.localPosition = Vector3.Lerp(arg_98_1.var_.moveOldPos1099ui_story, var_101_20, var_101_19)

				local var_101_21 = manager.ui.mainCamera.transform.position - var_101_16.position

				var_101_16.forward = Vector3.New(var_101_21.x, var_101_21.y, var_101_21.z)

				local var_101_22 = var_101_16.localEulerAngles

				var_101_22.z = 0
				var_101_22.x = 0
				var_101_16.localEulerAngles = var_101_22
			end

			if arg_98_1.time_ >= var_101_17 + var_101_18 and arg_98_1.time_ < var_101_17 + var_101_18 + arg_101_0 then
				var_101_16.localPosition = Vector3.New(0, -1.08, -5.9)

				local var_101_23 = manager.ui.mainCamera.transform.position - var_101_16.position

				var_101_16.forward = Vector3.New(var_101_23.x, var_101_23.y, var_101_23.z)

				local var_101_24 = var_101_16.localEulerAngles

				var_101_24.z = 0
				var_101_24.x = 0
				var_101_16.localEulerAngles = var_101_24
			end

			local var_101_25 = 0

			if var_101_25 < arg_98_1.time_ and arg_98_1.time_ <= var_101_25 + arg_101_0 then
				arg_98_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/story1099/story1099action/1099action6_1")
			end

			local var_101_26 = arg_98_1.actors_["1099ui_story"]
			local var_101_27 = 0

			if var_101_27 < arg_98_1.time_ and arg_98_1.time_ <= var_101_27 + arg_101_0 and not isNil(var_101_26) and arg_98_1.var_.characterEffect1099ui_story == nil then
				arg_98_1.var_.characterEffect1099ui_story = var_101_26:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_101_28 = 0.2

			if var_101_27 <= arg_98_1.time_ and arg_98_1.time_ < var_101_27 + var_101_28 and not isNil(var_101_26) then
				local var_101_29 = (arg_98_1.time_ - var_101_27) / var_101_28

				if arg_98_1.var_.characterEffect1099ui_story and not isNil(var_101_26) then
					arg_98_1.var_.characterEffect1099ui_story.fillFlat = false
				end
			end

			if arg_98_1.time_ >= var_101_27 + var_101_28 and arg_98_1.time_ < var_101_27 + var_101_28 + arg_101_0 and not isNil(var_101_26) and arg_98_1.var_.characterEffect1099ui_story then
				arg_98_1.var_.characterEffect1099ui_story.fillFlat = false
			end

			local var_101_30 = 0

			if var_101_30 < arg_98_1.time_ and arg_98_1.time_ <= var_101_30 + arg_101_0 then
				arg_98_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_101_31 = 0
			local var_101_32 = 0.425

			if var_101_31 < arg_98_1.time_ and arg_98_1.time_ <= var_101_31 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				local var_101_33 = arg_98_1:FormatText(StoryNameCfg[84].name)

				arg_98_1.leftNameTxt_.text = var_101_33

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_34 = arg_98_1:GetWordFromCfg(109061024)
				local var_101_35 = arg_98_1:FormatText(var_101_34.content)

				arg_98_1.text_.text = var_101_35

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_36 = 17
				local var_101_37 = utf8.len(var_101_35)
				local var_101_38 = var_101_36 <= 0 and var_101_32 or var_101_32 * (var_101_37 / var_101_36)

				if var_101_38 > 0 and var_101_32 < var_101_38 then
					arg_98_1.talkMaxDuration = var_101_38

					if var_101_38 + var_101_31 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_38 + var_101_31
					end
				end

				arg_98_1.text_.text = var_101_35
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109061", "109061024", "story_v_out_109061.awb") ~= 0 then
					local var_101_39 = manager.audio:GetVoiceLength("story_v_out_109061", "109061024", "story_v_out_109061.awb") / 1000

					if var_101_39 + var_101_31 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_39 + var_101_31
					end

					if var_101_34.prefab_name ~= "" and arg_98_1.actors_[var_101_34.prefab_name] ~= nil then
						local var_101_40 = LuaForUtil.PlayVoiceWithCriLipsync(arg_98_1.actors_[var_101_34.prefab_name].transform, "story_v_out_109061", "109061024", "story_v_out_109061.awb")

						arg_98_1:RecordAudio("109061024", var_101_40)
						arg_98_1:RecordAudio("109061024", var_101_40)
					else
						arg_98_1:AudioAction("play", "voice", "story_v_out_109061", "109061024", "story_v_out_109061.awb")
					end

					arg_98_1:RecordHistoryTalkVoice("story_v_out_109061", "109061024", "story_v_out_109061.awb")
				end

				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_41 = math.max(var_101_32, arg_98_1.talkMaxDuration)

			if var_101_31 <= arg_98_1.time_ and arg_98_1.time_ < var_101_31 + var_101_41 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_31) / var_101_41

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_31 + var_101_41 and arg_98_1.time_ < var_101_31 + var_101_41 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {
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
				actorName = "1099ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_98_1:InitPlayNodeList()
	end,
	Play109061025 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 109061025
		arg_102_1.duration_ = 8.53

		local var_102_0 = {
			ja = 6.8,
			ko = 4.8,
			zh = 8.533,
			en = 7.466
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
				arg_102_0:Play109061026(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			local var_105_0 = arg_102_1.actors_["1099ui_story"].transform
			local var_105_1 = 0

			if var_105_1 < arg_102_1.time_ and arg_102_1.time_ <= var_105_1 + arg_105_0 then
				arg_102_1.var_.moveOldPos1099ui_story = var_105_0.localPosition
			end

			local var_105_2 = 0.001

			if var_105_1 <= arg_102_1.time_ and arg_102_1.time_ < var_105_1 + var_105_2 then
				local var_105_3 = (arg_102_1.time_ - var_105_1) / var_105_2
				local var_105_4 = Vector3.New(0, 100, 0)

				var_105_0.localPosition = Vector3.Lerp(arg_102_1.var_.moveOldPos1099ui_story, var_105_4, var_105_3)

				local var_105_5 = manager.ui.mainCamera.transform.position - var_105_0.position

				var_105_0.forward = Vector3.New(var_105_5.x, var_105_5.y, var_105_5.z)

				local var_105_6 = var_105_0.localEulerAngles

				var_105_6.z = 0
				var_105_6.x = 0
				var_105_0.localEulerAngles = var_105_6
			end

			if arg_102_1.time_ >= var_105_1 + var_105_2 and arg_102_1.time_ < var_105_1 + var_105_2 + arg_105_0 then
				var_105_0.localPosition = Vector3.New(0, 100, 0)

				local var_105_7 = manager.ui.mainCamera.transform.position - var_105_0.position

				var_105_0.forward = Vector3.New(var_105_7.x, var_105_7.y, var_105_7.z)

				local var_105_8 = var_105_0.localEulerAngles

				var_105_8.z = 0
				var_105_8.x = 0
				var_105_0.localEulerAngles = var_105_8
			end

			local var_105_9 = arg_102_1.actors_["3004_tpose"].transform
			local var_105_10 = 0

			if var_105_10 < arg_102_1.time_ and arg_102_1.time_ <= var_105_10 + arg_105_0 then
				arg_102_1.var_.moveOldPos3004_tpose = var_105_9.localPosition

				local var_105_11 = GameObjectTools.GetOrAddComponent(var_105_9.gameObject, typeof(DynamicBoneHelper))

				if var_105_11 then
					var_105_11:EnableDynamicBone(false)
				end
			end

			local var_105_12 = 0.001

			if var_105_10 <= arg_102_1.time_ and arg_102_1.time_ < var_105_10 + var_105_12 then
				local var_105_13 = (arg_102_1.time_ - var_105_10) / var_105_12
				local var_105_14 = Vector3.New(0, -2.22, -3.1)

				var_105_9.localPosition = Vector3.Lerp(arg_102_1.var_.moveOldPos3004_tpose, var_105_14, var_105_13)

				local var_105_15 = manager.ui.mainCamera.transform.position - var_105_9.position

				var_105_9.forward = Vector3.New(var_105_15.x, var_105_15.y, var_105_15.z)

				local var_105_16 = var_105_9.localEulerAngles

				var_105_16.z = 0
				var_105_16.x = 0
				var_105_9.localEulerAngles = var_105_16
			end

			if arg_102_1.time_ >= var_105_10 + var_105_12 and arg_102_1.time_ < var_105_10 + var_105_12 + arg_105_0 then
				var_105_9.localPosition = Vector3.New(0, -2.22, -3.1)

				local var_105_17 = manager.ui.mainCamera.transform.position - var_105_9.position

				var_105_9.forward = Vector3.New(var_105_17.x, var_105_17.y, var_105_17.z)

				local var_105_18 = var_105_9.localEulerAngles

				var_105_18.z = 0
				var_105_18.x = 0
				var_105_9.localEulerAngles = var_105_18

				local var_105_19 = GameObjectTools.GetOrAddComponent(var_105_9.gameObject, typeof(DynamicBoneHelper))

				if var_105_19 then
					var_105_19:EnableDynamicBone(true)
				end
			end

			local var_105_20 = arg_102_1.actors_["3004_tpose"]
			local var_105_21 = 0

			if var_105_21 < arg_102_1.time_ and arg_102_1.time_ <= var_105_21 + arg_105_0 and not isNil(var_105_20) and arg_102_1.var_.characterEffect3004_tpose == nil then
				arg_102_1.var_.characterEffect3004_tpose = var_105_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_105_22 = 0.2

			if var_105_21 <= arg_102_1.time_ and arg_102_1.time_ < var_105_21 + var_105_22 and not isNil(var_105_20) then
				local var_105_23 = (arg_102_1.time_ - var_105_21) / var_105_22

				if arg_102_1.var_.characterEffect3004_tpose and not isNil(var_105_20) then
					arg_102_1.var_.characterEffect3004_tpose.fillFlat = false
				end
			end

			if arg_102_1.time_ >= var_105_21 + var_105_22 and arg_102_1.time_ < var_105_21 + var_105_22 + arg_105_0 and not isNil(var_105_20) and arg_102_1.var_.characterEffect3004_tpose then
				arg_102_1.var_.characterEffect3004_tpose.fillFlat = false
			end

			local var_105_24 = 0

			if var_105_24 < arg_102_1.time_ and arg_102_1.time_ <= var_105_24 + arg_105_0 then
				arg_102_1:PlayTimeline("3004_tpose", "StoryTimeline/CharAction/story3004/story3004action/3004action1_1")
			end

			local var_105_25 = 0
			local var_105_26 = 0.925

			if var_105_25 < arg_102_1.time_ and arg_102_1.time_ <= var_105_25 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				local var_105_27 = arg_102_1:FormatText(StoryNameCfg[82].name)

				arg_102_1.leftNameTxt_.text = var_105_27

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_28 = arg_102_1:GetWordFromCfg(109061025)
				local var_105_29 = arg_102_1:FormatText(var_105_28.content)

				arg_102_1.text_.text = var_105_29

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_30 = 37
				local var_105_31 = utf8.len(var_105_29)
				local var_105_32 = var_105_30 <= 0 and var_105_26 or var_105_26 * (var_105_31 / var_105_30)

				if var_105_32 > 0 and var_105_26 < var_105_32 then
					arg_102_1.talkMaxDuration = var_105_32

					if var_105_32 + var_105_25 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_32 + var_105_25
					end
				end

				arg_102_1.text_.text = var_105_29
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109061", "109061025", "story_v_out_109061.awb") ~= 0 then
					local var_105_33 = manager.audio:GetVoiceLength("story_v_out_109061", "109061025", "story_v_out_109061.awb") / 1000

					if var_105_33 + var_105_25 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_33 + var_105_25
					end

					if var_105_28.prefab_name ~= "" and arg_102_1.actors_[var_105_28.prefab_name] ~= nil then
						local var_105_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_102_1.actors_[var_105_28.prefab_name].transform, "story_v_out_109061", "109061025", "story_v_out_109061.awb")

						arg_102_1:RecordAudio("109061025", var_105_34)
						arg_102_1:RecordAudio("109061025", var_105_34)
					else
						arg_102_1:AudioAction("play", "voice", "story_v_out_109061", "109061025", "story_v_out_109061.awb")
					end

					arg_102_1:RecordHistoryTalkVoice("story_v_out_109061", "109061025", "story_v_out_109061.awb")
				end

				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_35 = math.max(var_105_26, arg_102_1.talkMaxDuration)

			if var_105_25 <= arg_102_1.time_ and arg_102_1.time_ < var_105_25 + var_105_35 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_25) / var_105_35

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_25 + var_105_35 and arg_102_1.time_ < var_105_25 + var_105_35 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1099ui_story",
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

		arg_102_1:InitPlayNodeList()
	end,
	Play109061026 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 109061026
		arg_106_1.duration_ = 3.5

		local var_106_0 = {
			ja = 3.333,
			ko = 3.1,
			zh = 3,
			en = 3.5
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
				arg_106_0:Play109061027(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			local var_109_0 = arg_106_1.actors_["3004_tpose"].transform
			local var_109_1 = 0

			if var_109_1 < arg_106_1.time_ and arg_106_1.time_ <= var_109_1 + arg_109_0 then
				arg_106_1.var_.moveOldPos3004_tpose = var_109_0.localPosition

				local var_109_2 = GameObjectTools.GetOrAddComponent(var_109_0.gameObject, typeof(DynamicBoneHelper))

				if var_109_2 then
					var_109_2:EnableDynamicBone(false)
				end
			end

			local var_109_3 = 0.001

			if var_109_1 <= arg_106_1.time_ and arg_106_1.time_ < var_109_1 + var_109_3 then
				local var_109_4 = (arg_106_1.time_ - var_109_1) / var_109_3
				local var_109_5 = Vector3.New(0, 100, 0)

				var_109_0.localPosition = Vector3.Lerp(arg_106_1.var_.moveOldPos3004_tpose, var_109_5, var_109_4)

				local var_109_6 = manager.ui.mainCamera.transform.position - var_109_0.position

				var_109_0.forward = Vector3.New(var_109_6.x, var_109_6.y, var_109_6.z)

				local var_109_7 = var_109_0.localEulerAngles

				var_109_7.z = 0
				var_109_7.x = 0
				var_109_0.localEulerAngles = var_109_7
			end

			if arg_106_1.time_ >= var_109_1 + var_109_3 and arg_106_1.time_ < var_109_1 + var_109_3 + arg_109_0 then
				var_109_0.localPosition = Vector3.New(0, 100, 0)

				local var_109_8 = manager.ui.mainCamera.transform.position - var_109_0.position

				var_109_0.forward = Vector3.New(var_109_8.x, var_109_8.y, var_109_8.z)

				local var_109_9 = var_109_0.localEulerAngles

				var_109_9.z = 0
				var_109_9.x = 0
				var_109_0.localEulerAngles = var_109_9

				local var_109_10 = GameObjectTools.GetOrAddComponent(var_109_0.gameObject, typeof(DynamicBoneHelper))

				if var_109_10 then
					var_109_10:EnableDynamicBone(true)
				end
			end

			local var_109_11 = "1050ui_story"

			if arg_106_1.actors_[var_109_11] == nil then
				local var_109_12 = Asset.Load("Char/" .. "1050ui_story")

				if not isNil(var_109_12) then
					local var_109_13 = Object.Instantiate(Asset.Load("Char/" .. "1050ui_story"), arg_106_1.stage_.transform)

					var_109_13.name = var_109_11
					var_109_13.transform.localPosition = Vector3.New(0, 100, 0)
					arg_106_1.actors_[var_109_11] = var_109_13

					local var_109_14 = var_109_13:GetComponentInChildren(typeof(CharacterEffect))

					var_109_14.enabled = true

					local var_109_15 = GameObjectTools.GetOrAddComponent(var_109_13, typeof(DynamicBoneHelper))

					if var_109_15 then
						var_109_15:EnableDynamicBone(false)
					end

					arg_106_1:ShowWeapon(var_109_14.transform, false)

					arg_106_1.var_[var_109_11 .. "Animator"] = var_109_14.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_106_1.var_[var_109_11 .. "Animator"].applyRootMotion = true
					arg_106_1.var_[var_109_11 .. "LipSync"] = var_109_14.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_109_16 = arg_106_1.actors_["1050ui_story"].transform
			local var_109_17 = 0

			if var_109_17 < arg_106_1.time_ and arg_106_1.time_ <= var_109_17 + arg_109_0 then
				arg_106_1.var_.moveOldPos1050ui_story = var_109_16.localPosition

				local var_109_18 = "1050ui_story"

				arg_106_1:ShowWeapon(arg_106_1.var_[var_109_18 .. "Animator"].transform, true)
			end

			local var_109_19 = 0.001

			if var_109_17 <= arg_106_1.time_ and arg_106_1.time_ < var_109_17 + var_109_19 then
				local var_109_20 = (arg_106_1.time_ - var_109_17) / var_109_19
				local var_109_21 = Vector3.New(-0.7, -1, -6.1)

				var_109_16.localPosition = Vector3.Lerp(arg_106_1.var_.moveOldPos1050ui_story, var_109_21, var_109_20)

				local var_109_22 = manager.ui.mainCamera.transform.position - var_109_16.position

				var_109_16.forward = Vector3.New(var_109_22.x, var_109_22.y, var_109_22.z)

				local var_109_23 = var_109_16.localEulerAngles

				var_109_23.z = 0
				var_109_23.x = 0
				var_109_16.localEulerAngles = var_109_23
			end

			if arg_106_1.time_ >= var_109_17 + var_109_19 and arg_106_1.time_ < var_109_17 + var_109_19 + arg_109_0 then
				var_109_16.localPosition = Vector3.New(-0.7, -1, -6.1)

				local var_109_24 = manager.ui.mainCamera.transform.position - var_109_16.position

				var_109_16.forward = Vector3.New(var_109_24.x, var_109_24.y, var_109_24.z)

				local var_109_25 = var_109_16.localEulerAngles

				var_109_25.z = 0
				var_109_25.x = 0
				var_109_16.localEulerAngles = var_109_25
			end

			local var_109_26 = arg_106_1.actors_["1050ui_story"]
			local var_109_27 = 0

			if var_109_27 < arg_106_1.time_ and arg_106_1.time_ <= var_109_27 + arg_109_0 and not isNil(var_109_26) and arg_106_1.var_.characterEffect1050ui_story == nil then
				arg_106_1.var_.characterEffect1050ui_story = var_109_26:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_109_28 = 0.2

			if var_109_27 <= arg_106_1.time_ and arg_106_1.time_ < var_109_27 + var_109_28 and not isNil(var_109_26) then
				local var_109_29 = (arg_106_1.time_ - var_109_27) / var_109_28

				if arg_106_1.var_.characterEffect1050ui_story and not isNil(var_109_26) then
					arg_106_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_106_1.time_ >= var_109_27 + var_109_28 and arg_106_1.time_ < var_109_27 + var_109_28 + arg_109_0 and not isNil(var_109_26) and arg_106_1.var_.characterEffect1050ui_story then
				arg_106_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			local var_109_30 = 0

			if var_109_30 < arg_106_1.time_ and arg_106_1.time_ <= var_109_30 + arg_109_0 then
				arg_106_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050action/1050action6_1")
			end

			local var_109_31 = 0

			if var_109_31 < arg_106_1.time_ and arg_106_1.time_ <= var_109_31 + arg_109_0 then
				arg_106_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_109_32 = 0
			local var_109_33 = 0.3

			if var_109_32 < arg_106_1.time_ and arg_106_1.time_ <= var_109_32 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				local var_109_34 = arg_106_1:FormatText(StoryNameCfg[74].name)

				arg_106_1.leftNameTxt_.text = var_109_34

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_35 = arg_106_1:GetWordFromCfg(109061026)
				local var_109_36 = arg_106_1:FormatText(var_109_35.content)

				arg_106_1.text_.text = var_109_36

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_37 = 12
				local var_109_38 = utf8.len(var_109_36)
				local var_109_39 = var_109_37 <= 0 and var_109_33 or var_109_33 * (var_109_38 / var_109_37)

				if var_109_39 > 0 and var_109_33 < var_109_39 then
					arg_106_1.talkMaxDuration = var_109_39

					if var_109_39 + var_109_32 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_39 + var_109_32
					end
				end

				arg_106_1.text_.text = var_109_36
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109061", "109061026", "story_v_out_109061.awb") ~= 0 then
					local var_109_40 = manager.audio:GetVoiceLength("story_v_out_109061", "109061026", "story_v_out_109061.awb") / 1000

					if var_109_40 + var_109_32 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_40 + var_109_32
					end

					if var_109_35.prefab_name ~= "" and arg_106_1.actors_[var_109_35.prefab_name] ~= nil then
						local var_109_41 = LuaForUtil.PlayVoiceWithCriLipsync(arg_106_1.actors_[var_109_35.prefab_name].transform, "story_v_out_109061", "109061026", "story_v_out_109061.awb")

						arg_106_1:RecordAudio("109061026", var_109_41)
						arg_106_1:RecordAudio("109061026", var_109_41)
					else
						arg_106_1:AudioAction("play", "voice", "story_v_out_109061", "109061026", "story_v_out_109061.awb")
					end

					arg_106_1:RecordHistoryTalkVoice("story_v_out_109061", "109061026", "story_v_out_109061.awb")
				end

				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_42 = math.max(var_109_33, arg_106_1.talkMaxDuration)

			if var_109_32 <= arg_106_1.time_ and arg_106_1.time_ < var_109_32 + var_109_42 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_32) / var_109_42

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_32 + var_109_42 and arg_106_1.time_ < var_109_32 + var_109_42 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {
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
				actorName = "1050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_106_1:InitPlayNodeList()
	end,
	Play109061027 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 109061027
		arg_110_1.duration_ = 5.4

		local var_110_0 = {
			ja = 4.6,
			ko = 5.4,
			zh = 5.3,
			en = 4.8
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
				arg_110_0:Play109061028(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			local var_113_0 = arg_110_1.actors_["1099ui_story"].transform
			local var_113_1 = 0

			if var_113_1 < arg_110_1.time_ and arg_110_1.time_ <= var_113_1 + arg_113_0 then
				arg_110_1.var_.moveOldPos1099ui_story = var_113_0.localPosition
			end

			local var_113_2 = 0.001

			if var_113_1 <= arg_110_1.time_ and arg_110_1.time_ < var_113_1 + var_113_2 then
				local var_113_3 = (arg_110_1.time_ - var_113_1) / var_113_2
				local var_113_4 = Vector3.New(0.7, -1.08, -5.9)

				var_113_0.localPosition = Vector3.Lerp(arg_110_1.var_.moveOldPos1099ui_story, var_113_4, var_113_3)

				local var_113_5 = manager.ui.mainCamera.transform.position - var_113_0.position

				var_113_0.forward = Vector3.New(var_113_5.x, var_113_5.y, var_113_5.z)

				local var_113_6 = var_113_0.localEulerAngles

				var_113_6.z = 0
				var_113_6.x = 0
				var_113_0.localEulerAngles = var_113_6
			end

			if arg_110_1.time_ >= var_113_1 + var_113_2 and arg_110_1.time_ < var_113_1 + var_113_2 + arg_113_0 then
				var_113_0.localPosition = Vector3.New(0.7, -1.08, -5.9)

				local var_113_7 = manager.ui.mainCamera.transform.position - var_113_0.position

				var_113_0.forward = Vector3.New(var_113_7.x, var_113_7.y, var_113_7.z)

				local var_113_8 = var_113_0.localEulerAngles

				var_113_8.z = 0
				var_113_8.x = 0
				var_113_0.localEulerAngles = var_113_8
			end

			local var_113_9 = arg_110_1.actors_["1099ui_story"]
			local var_113_10 = 0

			if var_113_10 < arg_110_1.time_ and arg_110_1.time_ <= var_113_10 + arg_113_0 and not isNil(var_113_9) and arg_110_1.var_.characterEffect1099ui_story == nil then
				arg_110_1.var_.characterEffect1099ui_story = var_113_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_113_11 = 0.2

			if var_113_10 <= arg_110_1.time_ and arg_110_1.time_ < var_113_10 + var_113_11 and not isNil(var_113_9) then
				local var_113_12 = (arg_110_1.time_ - var_113_10) / var_113_11

				if arg_110_1.var_.characterEffect1099ui_story and not isNil(var_113_9) then
					arg_110_1.var_.characterEffect1099ui_story.fillFlat = false
				end
			end

			if arg_110_1.time_ >= var_113_10 + var_113_11 and arg_110_1.time_ < var_113_10 + var_113_11 + arg_113_0 and not isNil(var_113_9) and arg_110_1.var_.characterEffect1099ui_story then
				arg_110_1.var_.characterEffect1099ui_story.fillFlat = false
			end

			local var_113_13 = arg_110_1.actors_["1050ui_story"]
			local var_113_14 = 0

			if var_113_14 < arg_110_1.time_ and arg_110_1.time_ <= var_113_14 + arg_113_0 and not isNil(var_113_13) and arg_110_1.var_.characterEffect1050ui_story == nil then
				arg_110_1.var_.characterEffect1050ui_story = var_113_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_113_15 = 0.2

			if var_113_14 <= arg_110_1.time_ and arg_110_1.time_ < var_113_14 + var_113_15 and not isNil(var_113_13) then
				local var_113_16 = (arg_110_1.time_ - var_113_14) / var_113_15

				if arg_110_1.var_.characterEffect1050ui_story and not isNil(var_113_13) then
					local var_113_17 = Mathf.Lerp(0, 0.5, var_113_16)

					arg_110_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_110_1.var_.characterEffect1050ui_story.fillRatio = var_113_17
				end
			end

			if arg_110_1.time_ >= var_113_14 + var_113_15 and arg_110_1.time_ < var_113_14 + var_113_15 + arg_113_0 and not isNil(var_113_13) and arg_110_1.var_.characterEffect1050ui_story then
				local var_113_18 = 0.5

				arg_110_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_110_1.var_.characterEffect1050ui_story.fillRatio = var_113_18
			end

			local var_113_19 = 0

			if var_113_19 < arg_110_1.time_ and arg_110_1.time_ <= var_113_19 + arg_113_0 then
				arg_110_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_113_20 = 0

			if var_113_20 < arg_110_1.time_ and arg_110_1.time_ <= var_113_20 + arg_113_0 then
				arg_110_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/story1099/story1099action/1099action5_1")
			end

			local var_113_21 = 0
			local var_113_22 = 0.625

			if var_113_21 < arg_110_1.time_ and arg_110_1.time_ <= var_113_21 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				local var_113_23 = arg_110_1:FormatText(StoryNameCfg[84].name)

				arg_110_1.leftNameTxt_.text = var_113_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, false)
				arg_110_1.callingController_:SetSelectedState("normal")

				local var_113_24 = arg_110_1:GetWordFromCfg(109061027)
				local var_113_25 = arg_110_1:FormatText(var_113_24.content)

				arg_110_1.text_.text = var_113_25

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_26 = 25
				local var_113_27 = utf8.len(var_113_25)
				local var_113_28 = var_113_26 <= 0 and var_113_22 or var_113_22 * (var_113_27 / var_113_26)

				if var_113_28 > 0 and var_113_22 < var_113_28 then
					arg_110_1.talkMaxDuration = var_113_28

					if var_113_28 + var_113_21 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_28 + var_113_21
					end
				end

				arg_110_1.text_.text = var_113_25
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109061", "109061027", "story_v_out_109061.awb") ~= 0 then
					local var_113_29 = manager.audio:GetVoiceLength("story_v_out_109061", "109061027", "story_v_out_109061.awb") / 1000

					if var_113_29 + var_113_21 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_29 + var_113_21
					end

					if var_113_24.prefab_name ~= "" and arg_110_1.actors_[var_113_24.prefab_name] ~= nil then
						local var_113_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_110_1.actors_[var_113_24.prefab_name].transform, "story_v_out_109061", "109061027", "story_v_out_109061.awb")

						arg_110_1:RecordAudio("109061027", var_113_30)
						arg_110_1:RecordAudio("109061027", var_113_30)
					else
						arg_110_1:AudioAction("play", "voice", "story_v_out_109061", "109061027", "story_v_out_109061.awb")
					end

					arg_110_1:RecordHistoryTalkVoice("story_v_out_109061", "109061027", "story_v_out_109061.awb")
				end

				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_31 = math.max(var_113_22, arg_110_1.talkMaxDuration)

			if var_113_21 <= arg_110_1.time_ and arg_110_1.time_ < var_113_21 + var_113_31 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_21) / var_113_31

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_21 + var_113_31 and arg_110_1.time_ < var_113_21 + var_113_31 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1099ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_110_1:InitPlayNodeList()
	end,
	Play109061028 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 109061028
		arg_114_1.duration_ = 6

		local var_114_0 = {
			ja = 4.433,
			ko = 3.2,
			zh = 6,
			en = 3.533
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
				arg_114_0:Play109061029(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			local var_117_0 = arg_114_1.actors_["1099ui_story"]
			local var_117_1 = 0

			if var_117_1 < arg_114_1.time_ and arg_114_1.time_ <= var_117_1 + arg_117_0 and not isNil(var_117_0) and arg_114_1.var_.characterEffect1099ui_story == nil then
				arg_114_1.var_.characterEffect1099ui_story = var_117_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_117_2 = 0.2

			if var_117_1 <= arg_114_1.time_ and arg_114_1.time_ < var_117_1 + var_117_2 and not isNil(var_117_0) then
				local var_117_3 = (arg_114_1.time_ - var_117_1) / var_117_2

				if arg_114_1.var_.characterEffect1099ui_story and not isNil(var_117_0) then
					local var_117_4 = Mathf.Lerp(0, 0.5, var_117_3)

					arg_114_1.var_.characterEffect1099ui_story.fillFlat = true
					arg_114_1.var_.characterEffect1099ui_story.fillRatio = var_117_4
				end
			end

			if arg_114_1.time_ >= var_117_1 + var_117_2 and arg_114_1.time_ < var_117_1 + var_117_2 + arg_117_0 and not isNil(var_117_0) and arg_114_1.var_.characterEffect1099ui_story then
				local var_117_5 = 0.5

				arg_114_1.var_.characterEffect1099ui_story.fillFlat = true
				arg_114_1.var_.characterEffect1099ui_story.fillRatio = var_117_5
			end

			local var_117_6 = 0

			if var_117_6 < arg_114_1.time_ and arg_114_1.time_ <= var_117_6 + arg_117_0 then
				arg_114_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action4_2")
			end

			local var_117_7 = arg_114_1.actors_["1050ui_story"].transform
			local var_117_8 = 0

			if var_117_8 < arg_114_1.time_ and arg_114_1.time_ <= var_117_8 + arg_117_0 then
				arg_114_1.var_.moveOldPos1050ui_story = var_117_7.localPosition

				local var_117_9 = "1050ui_story"

				arg_114_1:ShowWeapon(arg_114_1.var_[var_117_9 .. "Animator"].transform, true)
			end

			local var_117_10 = 0.001

			if var_117_8 <= arg_114_1.time_ and arg_114_1.time_ < var_117_8 + var_117_10 then
				local var_117_11 = (arg_114_1.time_ - var_117_8) / var_117_10
				local var_117_12 = Vector3.New(0, 100, 0)

				var_117_7.localPosition = Vector3.Lerp(arg_114_1.var_.moveOldPos1050ui_story, var_117_12, var_117_11)

				local var_117_13 = manager.ui.mainCamera.transform.position - var_117_7.position

				var_117_7.forward = Vector3.New(var_117_13.x, var_117_13.y, var_117_13.z)

				local var_117_14 = var_117_7.localEulerAngles

				var_117_14.z = 0
				var_117_14.x = 0
				var_117_7.localEulerAngles = var_117_14
			end

			if arg_114_1.time_ >= var_117_8 + var_117_10 and arg_114_1.time_ < var_117_8 + var_117_10 + arg_117_0 then
				var_117_7.localPosition = Vector3.New(0, 100, 0)

				local var_117_15 = manager.ui.mainCamera.transform.position - var_117_7.position

				var_117_7.forward = Vector3.New(var_117_15.x, var_117_15.y, var_117_15.z)

				local var_117_16 = var_117_7.localEulerAngles

				var_117_16.z = 0
				var_117_16.x = 0
				var_117_7.localEulerAngles = var_117_16
			end

			local var_117_17 = arg_114_1.actors_["1099ui_story"].transform
			local var_117_18 = 0

			if var_117_18 < arg_114_1.time_ and arg_114_1.time_ <= var_117_18 + arg_117_0 then
				arg_114_1.var_.moveOldPos1099ui_story = var_117_17.localPosition
			end

			local var_117_19 = 0.001

			if var_117_18 <= arg_114_1.time_ and arg_114_1.time_ < var_117_18 + var_117_19 then
				local var_117_20 = (arg_114_1.time_ - var_117_18) / var_117_19
				local var_117_21 = Vector3.New(0, 100, 0)

				var_117_17.localPosition = Vector3.Lerp(arg_114_1.var_.moveOldPos1099ui_story, var_117_21, var_117_20)

				local var_117_22 = manager.ui.mainCamera.transform.position - var_117_17.position

				var_117_17.forward = Vector3.New(var_117_22.x, var_117_22.y, var_117_22.z)

				local var_117_23 = var_117_17.localEulerAngles

				var_117_23.z = 0
				var_117_23.x = 0
				var_117_17.localEulerAngles = var_117_23
			end

			if arg_114_1.time_ >= var_117_18 + var_117_19 and arg_114_1.time_ < var_117_18 + var_117_19 + arg_117_0 then
				var_117_17.localPosition = Vector3.New(0, 100, 0)

				local var_117_24 = manager.ui.mainCamera.transform.position - var_117_17.position

				var_117_17.forward = Vector3.New(var_117_24.x, var_117_24.y, var_117_24.z)

				local var_117_25 = var_117_17.localEulerAngles

				var_117_25.z = 0
				var_117_25.x = 0
				var_117_17.localEulerAngles = var_117_25
			end

			local var_117_26 = arg_114_1.actors_["10004ui_story"].transform
			local var_117_27 = 0

			if var_117_27 < arg_114_1.time_ and arg_114_1.time_ <= var_117_27 + arg_117_0 then
				arg_114_1.var_.moveOldPos10004ui_story = var_117_26.localPosition
			end

			local var_117_28 = 0.001

			if var_117_27 <= arg_114_1.time_ and arg_114_1.time_ < var_117_27 + var_117_28 then
				local var_117_29 = (arg_114_1.time_ - var_117_27) / var_117_28
				local var_117_30 = Vector3.New(0, -1.1, -5.6)

				var_117_26.localPosition = Vector3.Lerp(arg_114_1.var_.moveOldPos10004ui_story, var_117_30, var_117_29)

				local var_117_31 = manager.ui.mainCamera.transform.position - var_117_26.position

				var_117_26.forward = Vector3.New(var_117_31.x, var_117_31.y, var_117_31.z)

				local var_117_32 = var_117_26.localEulerAngles

				var_117_32.z = 0
				var_117_32.x = 0
				var_117_26.localEulerAngles = var_117_32
			end

			if arg_114_1.time_ >= var_117_27 + var_117_28 and arg_114_1.time_ < var_117_27 + var_117_28 + arg_117_0 then
				var_117_26.localPosition = Vector3.New(0, -1.1, -5.6)

				local var_117_33 = manager.ui.mainCamera.transform.position - var_117_26.position

				var_117_26.forward = Vector3.New(var_117_33.x, var_117_33.y, var_117_33.z)

				local var_117_34 = var_117_26.localEulerAngles

				var_117_34.z = 0
				var_117_34.x = 0
				var_117_26.localEulerAngles = var_117_34
			end

			local var_117_35 = arg_114_1.actors_["10004ui_story"]
			local var_117_36 = 0

			if var_117_36 < arg_114_1.time_ and arg_114_1.time_ <= var_117_36 + arg_117_0 and not isNil(var_117_35) and arg_114_1.var_.characterEffect10004ui_story == nil then
				arg_114_1.var_.characterEffect10004ui_story = var_117_35:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_117_37 = 0.2

			if var_117_36 <= arg_114_1.time_ and arg_114_1.time_ < var_117_36 + var_117_37 and not isNil(var_117_35) then
				local var_117_38 = (arg_114_1.time_ - var_117_36) / var_117_37

				if arg_114_1.var_.characterEffect10004ui_story and not isNil(var_117_35) then
					arg_114_1.var_.characterEffect10004ui_story.fillFlat = false
				end
			end

			if arg_114_1.time_ >= var_117_36 + var_117_37 and arg_114_1.time_ < var_117_36 + var_117_37 + arg_117_0 and not isNil(var_117_35) and arg_114_1.var_.characterEffect10004ui_story then
				arg_114_1.var_.characterEffect10004ui_story.fillFlat = false
			end

			local var_117_39 = 0

			if var_117_39 < arg_114_1.time_ and arg_114_1.time_ <= var_117_39 + arg_117_0 then
				arg_114_1:PlayTimeline("10004ui_story", "StoryTimeline/CharAction/story10004/story10004action/10004action4_1")
			end

			local var_117_40 = 0

			if var_117_40 < arg_114_1.time_ and arg_114_1.time_ <= var_117_40 + arg_117_0 then
				arg_114_1:PlayTimeline("10004ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_117_41 = 0
			local var_117_42 = 0.45

			if var_117_41 < arg_114_1.time_ and arg_114_1.time_ <= var_117_41 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, true)

				local var_117_43 = arg_114_1:FormatText(StoryNameCfg[80].name)

				arg_114_1.leftNameTxt_.text = var_117_43

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_114_1.leftNameTxt_.transform)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1.leftNameTxt_.text)
				SetActive(arg_114_1.iconTrs_.gameObject, false)
				arg_114_1.callingController_:SetSelectedState("normal")

				local var_117_44 = arg_114_1:GetWordFromCfg(109061028)
				local var_117_45 = arg_114_1:FormatText(var_117_44.content)

				arg_114_1.text_.text = var_117_45

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_46 = 18
				local var_117_47 = utf8.len(var_117_45)
				local var_117_48 = var_117_46 <= 0 and var_117_42 or var_117_42 * (var_117_47 / var_117_46)

				if var_117_48 > 0 and var_117_42 < var_117_48 then
					arg_114_1.talkMaxDuration = var_117_48

					if var_117_48 + var_117_41 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_48 + var_117_41
					end
				end

				arg_114_1.text_.text = var_117_45
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109061", "109061028", "story_v_out_109061.awb") ~= 0 then
					local var_117_49 = manager.audio:GetVoiceLength("story_v_out_109061", "109061028", "story_v_out_109061.awb") / 1000

					if var_117_49 + var_117_41 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_49 + var_117_41
					end

					if var_117_44.prefab_name ~= "" and arg_114_1.actors_[var_117_44.prefab_name] ~= nil then
						local var_117_50 = LuaForUtil.PlayVoiceWithCriLipsync(arg_114_1.actors_[var_117_44.prefab_name].transform, "story_v_out_109061", "109061028", "story_v_out_109061.awb")

						arg_114_1:RecordAudio("109061028", var_117_50)
						arg_114_1:RecordAudio("109061028", var_117_50)
					else
						arg_114_1:AudioAction("play", "voice", "story_v_out_109061", "109061028", "story_v_out_109061.awb")
					end

					arg_114_1:RecordHistoryTalkVoice("story_v_out_109061", "109061028", "story_v_out_109061.awb")
				end

				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_51 = math.max(var_117_42, arg_114_1.talkMaxDuration)

			if var_117_41 <= arg_114_1.time_ and arg_114_1.time_ < var_117_41 + var_117_51 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - var_117_41) / var_117_51

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= var_117_41 + var_117_51 and arg_114_1.time_ < var_117_41 + var_117_51 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1099ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10004ui_story",
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
	Play109061029 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 109061029
		arg_118_1.duration_ = 6.1

		local var_118_0 = {
			ja = 6.066,
			ko = 5.6,
			zh = 4.833,
			en = 6.1
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
			arg_118_1.auto_ = false
		end

		function arg_118_1.playNext_(arg_120_0)
			arg_118_1.onStoryFinished_()
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			local var_121_0 = arg_118_1.actors_["1084ui_story"].transform
			local var_121_1 = 0

			if var_121_1 < arg_118_1.time_ and arg_118_1.time_ <= var_121_1 + arg_121_0 then
				arg_118_1.var_.moveOldPos1084ui_story = var_121_0.localPosition

				local var_121_2 = "1084ui_story"

				arg_118_1:ShowWeapon(arg_118_1.var_[var_121_2 .. "Animator"].transform, true)
			end

			local var_121_3 = 0.001

			if var_121_1 <= arg_118_1.time_ and arg_118_1.time_ < var_121_1 + var_121_3 then
				local var_121_4 = (arg_118_1.time_ - var_121_1) / var_121_3
				local var_121_5 = Vector3.New(0.7, -0.97, -6)

				var_121_0.localPosition = Vector3.Lerp(arg_118_1.var_.moveOldPos1084ui_story, var_121_5, var_121_4)

				local var_121_6 = manager.ui.mainCamera.transform.position - var_121_0.position

				var_121_0.forward = Vector3.New(var_121_6.x, var_121_6.y, var_121_6.z)

				local var_121_7 = var_121_0.localEulerAngles

				var_121_7.z = 0
				var_121_7.x = 0
				var_121_0.localEulerAngles = var_121_7
			end

			if arg_118_1.time_ >= var_121_1 + var_121_3 and arg_118_1.time_ < var_121_1 + var_121_3 + arg_121_0 then
				var_121_0.localPosition = Vector3.New(0.7, -0.97, -6)

				local var_121_8 = manager.ui.mainCamera.transform.position - var_121_0.position

				var_121_0.forward = Vector3.New(var_121_8.x, var_121_8.y, var_121_8.z)

				local var_121_9 = var_121_0.localEulerAngles

				var_121_9.z = 0
				var_121_9.x = 0
				var_121_0.localEulerAngles = var_121_9
			end

			local var_121_10 = arg_118_1.actors_["10004ui_story"].transform
			local var_121_11 = 0

			if var_121_11 < arg_118_1.time_ and arg_118_1.time_ <= var_121_11 + arg_121_0 then
				arg_118_1.var_.moveOldPos10004ui_story = var_121_10.localPosition
			end

			local var_121_12 = 0.001

			if var_121_11 <= arg_118_1.time_ and arg_118_1.time_ < var_121_11 + var_121_12 then
				local var_121_13 = (arg_118_1.time_ - var_121_11) / var_121_12
				local var_121_14 = Vector3.New(0, 100, 0)

				var_121_10.localPosition = Vector3.Lerp(arg_118_1.var_.moveOldPos10004ui_story, var_121_14, var_121_13)

				local var_121_15 = manager.ui.mainCamera.transform.position - var_121_10.position

				var_121_10.forward = Vector3.New(var_121_15.x, var_121_15.y, var_121_15.z)

				local var_121_16 = var_121_10.localEulerAngles

				var_121_16.z = 0
				var_121_16.x = 0
				var_121_10.localEulerAngles = var_121_16
			end

			if arg_118_1.time_ >= var_121_11 + var_121_12 and arg_118_1.time_ < var_121_11 + var_121_12 + arg_121_0 then
				var_121_10.localPosition = Vector3.New(0, 100, 0)

				local var_121_17 = manager.ui.mainCamera.transform.position - var_121_10.position

				var_121_10.forward = Vector3.New(var_121_17.x, var_121_17.y, var_121_17.z)

				local var_121_18 = var_121_10.localEulerAngles

				var_121_18.z = 0
				var_121_18.x = 0
				var_121_10.localEulerAngles = var_121_18
			end

			local var_121_19 = arg_118_1.actors_["1050ui_story"].transform
			local var_121_20 = 0

			if var_121_20 < arg_118_1.time_ and arg_118_1.time_ <= var_121_20 + arg_121_0 then
				arg_118_1.var_.moveOldPos1050ui_story = var_121_19.localPosition

				local var_121_21 = "1050ui_story"

				arg_118_1:ShowWeapon(arg_118_1.var_[var_121_21 .. "Animator"].transform, true)
			end

			local var_121_22 = 0.001

			if var_121_20 <= arg_118_1.time_ and arg_118_1.time_ < var_121_20 + var_121_22 then
				local var_121_23 = (arg_118_1.time_ - var_121_20) / var_121_22
				local var_121_24 = Vector3.New(-0.7, -1, -6.1)

				var_121_19.localPosition = Vector3.Lerp(arg_118_1.var_.moveOldPos1050ui_story, var_121_24, var_121_23)

				local var_121_25 = manager.ui.mainCamera.transform.position - var_121_19.position

				var_121_19.forward = Vector3.New(var_121_25.x, var_121_25.y, var_121_25.z)

				local var_121_26 = var_121_19.localEulerAngles

				var_121_26.z = 0
				var_121_26.x = 0
				var_121_19.localEulerAngles = var_121_26
			end

			if arg_118_1.time_ >= var_121_20 + var_121_22 and arg_118_1.time_ < var_121_20 + var_121_22 + arg_121_0 then
				var_121_19.localPosition = Vector3.New(-0.7, -1, -6.1)

				local var_121_27 = manager.ui.mainCamera.transform.position - var_121_19.position

				var_121_19.forward = Vector3.New(var_121_27.x, var_121_27.y, var_121_27.z)

				local var_121_28 = var_121_19.localEulerAngles

				var_121_28.z = 0
				var_121_28.x = 0
				var_121_19.localEulerAngles = var_121_28
			end

			local var_121_29 = arg_118_1.actors_["1084ui_story"]
			local var_121_30 = 0

			if var_121_30 < arg_118_1.time_ and arg_118_1.time_ <= var_121_30 + arg_121_0 and not isNil(var_121_29) and arg_118_1.var_.characterEffect1084ui_story == nil then
				arg_118_1.var_.characterEffect1084ui_story = var_121_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_121_31 = 0.2

			if var_121_30 <= arg_118_1.time_ and arg_118_1.time_ < var_121_30 + var_121_31 and not isNil(var_121_29) then
				local var_121_32 = (arg_118_1.time_ - var_121_30) / var_121_31

				if arg_118_1.var_.characterEffect1084ui_story and not isNil(var_121_29) then
					arg_118_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_118_1.time_ >= var_121_30 + var_121_31 and arg_118_1.time_ < var_121_30 + var_121_31 + arg_121_0 and not isNil(var_121_29) and arg_118_1.var_.characterEffect1084ui_story then
				arg_118_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_121_33 = 0

			if var_121_33 < arg_118_1.time_ and arg_118_1.time_ <= var_121_33 + arg_121_0 then
				arg_118_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action11_1")
			end

			local var_121_34 = 0

			if var_121_34 < arg_118_1.time_ and arg_118_1.time_ <= var_121_34 + arg_121_0 then
				arg_118_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_121_35 = 0
			local var_121_36 = 0.525

			if var_121_35 < arg_118_1.time_ and arg_118_1.time_ <= var_121_35 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, true)

				local var_121_37 = arg_118_1:FormatText(StoryNameCfg[6].name)

				arg_118_1.leftNameTxt_.text = var_121_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_118_1.leftNameTxt_.transform)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1.leftNameTxt_.text)
				SetActive(arg_118_1.iconTrs_.gameObject, false)
				arg_118_1.callingController_:SetSelectedState("normal")

				local var_121_38 = arg_118_1:GetWordFromCfg(109061029)
				local var_121_39 = arg_118_1:FormatText(var_121_38.content)

				arg_118_1.text_.text = var_121_39

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_40 = 21
				local var_121_41 = utf8.len(var_121_39)
				local var_121_42 = var_121_40 <= 0 and var_121_36 or var_121_36 * (var_121_41 / var_121_40)

				if var_121_42 > 0 and var_121_36 < var_121_42 then
					arg_118_1.talkMaxDuration = var_121_42

					if var_121_42 + var_121_35 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_42 + var_121_35
					end
				end

				arg_118_1.text_.text = var_121_39
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109061", "109061029", "story_v_out_109061.awb") ~= 0 then
					local var_121_43 = manager.audio:GetVoiceLength("story_v_out_109061", "109061029", "story_v_out_109061.awb") / 1000

					if var_121_43 + var_121_35 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_43 + var_121_35
					end

					if var_121_38.prefab_name ~= "" and arg_118_1.actors_[var_121_38.prefab_name] ~= nil then
						local var_121_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_118_1.actors_[var_121_38.prefab_name].transform, "story_v_out_109061", "109061029", "story_v_out_109061.awb")

						arg_118_1:RecordAudio("109061029", var_121_44)
						arg_118_1:RecordAudio("109061029", var_121_44)
					else
						arg_118_1:AudioAction("play", "voice", "story_v_out_109061", "109061029", "story_v_out_109061.awb")
					end

					arg_118_1:RecordHistoryTalkVoice("story_v_out_109061", "109061029", "story_v_out_109061.awb")
				end

				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_45 = math.max(var_121_36, arg_118_1.talkMaxDuration)

			if var_121_35 <= arg_118_1.time_ and arg_118_1.time_ < var_121_35 + var_121_45 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - var_121_35) / var_121_45

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= var_121_35 + var_121_45 and arg_118_1.time_ < var_121_35 + var_121_45 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {
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
				actorName = "10004ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_118_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/C07_1"
	},
	voices = {
		"story_v_out_109061.awb"
	}
}
