return {
	Play109081001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 109081001
		arg_1_1.duration_ = 5.3

		local var_1_0 = {
			ja = 3.799999999999,
			ko = 4.7,
			zh = 5.3,
			en = 3.966
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
				arg_1_0:Play109081002(arg_1_1)
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

			local var_4_25 = "3004_tpose"

			if arg_1_1.actors_[var_4_25] == nil then
				local var_4_26 = Asset.Load("Char/" .. "3004_tpose")

				if not isNil(var_4_26) then
					local var_4_27 = Object.Instantiate(Asset.Load("Char/" .. "3004_tpose"), arg_1_1.stage_.transform)

					var_4_27.name = var_4_25
					var_4_27.transform.localPosition = Vector3.New(0, 100, 0)
					arg_1_1.actors_[var_4_25] = var_4_27

					local var_4_28 = var_4_27:GetComponentInChildren(typeof(CharacterEffect))

					var_4_28.enabled = true

					local var_4_29 = GameObjectTools.GetOrAddComponent(var_4_27, typeof(DynamicBoneHelper))

					if var_4_29 then
						var_4_29:EnableDynamicBone(false)
					end

					arg_1_1:ShowWeapon(var_4_28.transform, false)

					arg_1_1.var_[var_4_25 .. "Animator"] = var_4_28.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_1_1.var_[var_4_25 .. "Animator"].applyRootMotion = true
					arg_1_1.var_[var_4_25 .. "LipSync"] = var_4_28.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_4_30 = arg_1_1.actors_["3004_tpose"].transform
			local var_4_31 = 1.8

			if var_4_31 < arg_1_1.time_ and arg_1_1.time_ <= var_4_31 + arg_4_0 then
				arg_1_1.var_.moveOldPos3004_tpose = var_4_30.localPosition

				local var_4_32 = GameObjectTools.GetOrAddComponent(var_4_30.gameObject, typeof(DynamicBoneHelper))

				if var_4_32 then
					var_4_32:EnableDynamicBone(false)
				end
			end

			local var_4_33 = 0.001

			if var_4_31 <= arg_1_1.time_ and arg_1_1.time_ < var_4_31 + var_4_33 then
				local var_4_34 = (arg_1_1.time_ - var_4_31) / var_4_33
				local var_4_35 = Vector3.New(-0.7, -2.22, -3.1)

				var_4_30.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos3004_tpose, var_4_35, var_4_34)

				local var_4_36 = manager.ui.mainCamera.transform.position - var_4_30.position

				var_4_30.forward = Vector3.New(var_4_36.x, var_4_36.y, var_4_36.z)

				local var_4_37 = var_4_30.localEulerAngles

				var_4_37.z = 0
				var_4_37.x = 0
				var_4_30.localEulerAngles = var_4_37
			end

			if arg_1_1.time_ >= var_4_31 + var_4_33 and arg_1_1.time_ < var_4_31 + var_4_33 + arg_4_0 then
				var_4_30.localPosition = Vector3.New(-0.7, -2.22, -3.1)

				local var_4_38 = manager.ui.mainCamera.transform.position - var_4_30.position

				var_4_30.forward = Vector3.New(var_4_38.x, var_4_38.y, var_4_38.z)

				local var_4_39 = var_4_30.localEulerAngles

				var_4_39.z = 0
				var_4_39.x = 0
				var_4_30.localEulerAngles = var_4_39

				local var_4_40 = GameObjectTools.GetOrAddComponent(var_4_30.gameObject, typeof(DynamicBoneHelper))

				if var_4_40 then
					var_4_40:EnableDynamicBone(true)
				end
			end

			local var_4_41 = arg_1_1.actors_["3004_tpose"]
			local var_4_42 = 1.8

			if var_4_42 < arg_1_1.time_ and arg_1_1.time_ <= var_4_42 + arg_4_0 and not isNil(var_4_41) and arg_1_1.var_.characterEffect3004_tpose == nil then
				arg_1_1.var_.characterEffect3004_tpose = var_4_41:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_43 = 0.2

			if var_4_42 <= arg_1_1.time_ and arg_1_1.time_ < var_4_42 + var_4_43 and not isNil(var_4_41) then
				local var_4_44 = (arg_1_1.time_ - var_4_42) / var_4_43

				if arg_1_1.var_.characterEffect3004_tpose and not isNil(var_4_41) then
					arg_1_1.var_.characterEffect3004_tpose.fillFlat = false
				end
			end

			if arg_1_1.time_ >= var_4_42 + var_4_43 and arg_1_1.time_ < var_4_42 + var_4_43 + arg_4_0 and not isNil(var_4_41) and arg_1_1.var_.characterEffect3004_tpose then
				arg_1_1.var_.characterEffect3004_tpose.fillFlat = false
			end

			local var_4_45 = 1.8

			if var_4_45 < arg_1_1.time_ and arg_1_1.time_ <= var_4_45 + arg_4_0 then
				arg_1_1:PlayTimeline("3004_tpose", "StoryTimeline/CharAction/story3004/story3004action/3004action1_1")
			end

			local var_4_46 = 0
			local var_4_47 = 1

			if var_4_46 < arg_1_1.time_ and arg_1_1.time_ <= var_4_46 + arg_4_0 then
				local var_4_48 = "play"
				local var_4_49 = "music"

				arg_1_1:AudioAction(var_4_48, var_4_49, "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1.awb")

				local var_4_50 = ""
				local var_4_51 = manager.audio:GetAudioName("bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1")

				if var_4_51 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_51 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_51

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_51
						arg_1_1.bgmTxt2_.text = var_4_51
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

			local var_4_52 = 0

			if var_4_52 < arg_1_1.time_ and arg_1_1.time_ <= var_4_52 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_53 = 2

			if arg_1_1.time_ >= var_4_52 + var_4_53 and arg_1_1.time_ < var_4_52 + var_4_53 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_54 = 2
			local var_4_55 = 0.175

			if var_4_54 < arg_1_1.time_ and arg_1_1.time_ <= var_4_54 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_56 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_56:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_56:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_56:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_57 = arg_1_1:FormatText(StoryNameCfg[82].name)

				arg_1_1.leftNameTxt_.text = var_4_57

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_58 = arg_1_1:GetWordFromCfg(109081001)
				local var_4_59 = arg_1_1:FormatText(var_4_58.content)

				arg_1_1.text_.text = var_4_59

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_60 = 7
				local var_4_61 = utf8.len(var_4_59)
				local var_4_62 = var_4_60 <= 0 and var_4_55 or var_4_55 * (var_4_61 / var_4_60)

				if var_4_62 > 0 and var_4_55 < var_4_62 then
					arg_1_1.talkMaxDuration = var_4_62
					var_4_54 = var_4_54 + 0.3

					if var_4_62 + var_4_54 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_62 + var_4_54
					end
				end

				arg_1_1.text_.text = var_4_59
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109081", "109081001", "story_v_out_109081.awb") ~= 0 then
					local var_4_63 = manager.audio:GetVoiceLength("story_v_out_109081", "109081001", "story_v_out_109081.awb") / 1000

					if var_4_63 + var_4_54 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_63 + var_4_54
					end

					if var_4_58.prefab_name ~= "" and arg_1_1.actors_[var_4_58.prefab_name] ~= nil then
						local var_4_64 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_58.prefab_name].transform, "story_v_out_109081", "109081001", "story_v_out_109081.awb")

						arg_1_1:RecordAudio("109081001", var_4_64)
						arg_1_1:RecordAudio("109081001", var_4_64)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_109081", "109081001", "story_v_out_109081.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_109081", "109081001", "story_v_out_109081.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_65 = var_4_54 + 0.3
			local var_4_66 = math.max(var_4_55, arg_1_1.talkMaxDuration)

			if var_4_65 <= arg_1_1.time_ and arg_1_1.time_ < var_4_65 + var_4_66 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_65) / var_4_66

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_65 + var_4_66 and arg_1_1.time_ < var_4_65 + var_4_66 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3004_tpose",
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
	Play109081002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 109081002
		arg_8_1.duration_ = 2

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play109081003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = arg_8_1.actors_["3004_tpose"]
			local var_11_1 = 0

			if var_11_1 < arg_8_1.time_ and arg_8_1.time_ <= var_11_1 + arg_11_0 and not isNil(var_11_0) and arg_8_1.var_.characterEffect3004_tpose == nil then
				arg_8_1.var_.characterEffect3004_tpose = var_11_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_2 = 0.2

			if var_11_1 <= arg_8_1.time_ and arg_8_1.time_ < var_11_1 + var_11_2 and not isNil(var_11_0) then
				local var_11_3 = (arg_8_1.time_ - var_11_1) / var_11_2

				if arg_8_1.var_.characterEffect3004_tpose and not isNil(var_11_0) then
					local var_11_4 = Mathf.Lerp(0, 0.5, var_11_3)

					arg_8_1.var_.characterEffect3004_tpose.fillFlat = true
					arg_8_1.var_.characterEffect3004_tpose.fillRatio = var_11_4
				end
			end

			if arg_8_1.time_ >= var_11_1 + var_11_2 and arg_8_1.time_ < var_11_1 + var_11_2 + arg_11_0 and not isNil(var_11_0) and arg_8_1.var_.characterEffect3004_tpose then
				local var_11_5 = 0.5

				arg_8_1.var_.characterEffect3004_tpose.fillFlat = true
				arg_8_1.var_.characterEffect3004_tpose.fillRatio = var_11_5
			end

			local var_11_6 = "10004ui_story"

			if arg_8_1.actors_[var_11_6] == nil then
				local var_11_7 = Asset.Load("Char/" .. "10004ui_story")

				if not isNil(var_11_7) then
					local var_11_8 = Object.Instantiate(Asset.Load("Char/" .. "10004ui_story"), arg_8_1.stage_.transform)

					var_11_8.name = var_11_6
					var_11_8.transform.localPosition = Vector3.New(0, 100, 0)
					arg_8_1.actors_[var_11_6] = var_11_8

					local var_11_9 = var_11_8:GetComponentInChildren(typeof(CharacterEffect))

					var_11_9.enabled = true

					local var_11_10 = GameObjectTools.GetOrAddComponent(var_11_8, typeof(DynamicBoneHelper))

					if var_11_10 then
						var_11_10:EnableDynamicBone(false)
					end

					arg_8_1:ShowWeapon(var_11_9.transform, false)

					arg_8_1.var_[var_11_6 .. "Animator"] = var_11_9.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_8_1.var_[var_11_6 .. "Animator"].applyRootMotion = true
					arg_8_1.var_[var_11_6 .. "LipSync"] = var_11_9.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_11_11 = arg_8_1.actors_["10004ui_story"]
			local var_11_12 = 0

			if var_11_12 < arg_8_1.time_ and arg_8_1.time_ <= var_11_12 + arg_11_0 and not isNil(var_11_11) and arg_8_1.var_.characterEffect10004ui_story == nil then
				arg_8_1.var_.characterEffect10004ui_story = var_11_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_13 = 0.2

			if var_11_12 <= arg_8_1.time_ and arg_8_1.time_ < var_11_12 + var_11_13 and not isNil(var_11_11) then
				local var_11_14 = (arg_8_1.time_ - var_11_12) / var_11_13

				if arg_8_1.var_.characterEffect10004ui_story and not isNil(var_11_11) then
					arg_8_1.var_.characterEffect10004ui_story.fillFlat = false
				end
			end

			if arg_8_1.time_ >= var_11_12 + var_11_13 and arg_8_1.time_ < var_11_12 + var_11_13 + arg_11_0 and not isNil(var_11_11) and arg_8_1.var_.characterEffect10004ui_story then
				arg_8_1.var_.characterEffect10004ui_story.fillFlat = false
			end

			local var_11_15 = arg_8_1.actors_["10004ui_story"].transform
			local var_11_16 = 0

			if var_11_16 < arg_8_1.time_ and arg_8_1.time_ <= var_11_16 + arg_11_0 then
				arg_8_1.var_.moveOldPos10004ui_story = var_11_15.localPosition
			end

			local var_11_17 = 0.001

			if var_11_16 <= arg_8_1.time_ and arg_8_1.time_ < var_11_16 + var_11_17 then
				local var_11_18 = (arg_8_1.time_ - var_11_16) / var_11_17
				local var_11_19 = Vector3.New(0.7, -1.1, -5.6)

				var_11_15.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos10004ui_story, var_11_19, var_11_18)

				local var_11_20 = manager.ui.mainCamera.transform.position - var_11_15.position

				var_11_15.forward = Vector3.New(var_11_20.x, var_11_20.y, var_11_20.z)

				local var_11_21 = var_11_15.localEulerAngles

				var_11_21.z = 0
				var_11_21.x = 0
				var_11_15.localEulerAngles = var_11_21
			end

			if arg_8_1.time_ >= var_11_16 + var_11_17 and arg_8_1.time_ < var_11_16 + var_11_17 + arg_11_0 then
				var_11_15.localPosition = Vector3.New(0.7, -1.1, -5.6)

				local var_11_22 = manager.ui.mainCamera.transform.position - var_11_15.position

				var_11_15.forward = Vector3.New(var_11_22.x, var_11_22.y, var_11_22.z)

				local var_11_23 = var_11_15.localEulerAngles

				var_11_23.z = 0
				var_11_23.x = 0
				var_11_15.localEulerAngles = var_11_23
			end

			local var_11_24 = 0

			if var_11_24 < arg_8_1.time_ and arg_8_1.time_ <= var_11_24 + arg_11_0 then
				arg_8_1:PlayTimeline("10004ui_story", "StoryTimeline/CharAction/story10004/story10004action/10004action1_1")
			end

			local var_11_25 = 0

			if var_11_25 < arg_8_1.time_ and arg_8_1.time_ <= var_11_25 + arg_11_0 then
				arg_8_1:PlayTimeline("10004ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_11_26 = 0
			local var_11_27 = 0.075

			if var_11_26 < arg_8_1.time_ and arg_8_1.time_ <= var_11_26 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				local var_11_28 = arg_8_1:FormatText(StoryNameCfg[80].name)

				arg_8_1.leftNameTxt_.text = var_11_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_29 = arg_8_1:GetWordFromCfg(109081002)
				local var_11_30 = arg_8_1:FormatText(var_11_29.content)

				arg_8_1.text_.text = var_11_30

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_31 = 3
				local var_11_32 = utf8.len(var_11_30)
				local var_11_33 = var_11_31 <= 0 and var_11_27 or var_11_27 * (var_11_32 / var_11_31)

				if var_11_33 > 0 and var_11_27 < var_11_33 then
					arg_8_1.talkMaxDuration = var_11_33

					if var_11_33 + var_11_26 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_33 + var_11_26
					end
				end

				arg_8_1.text_.text = var_11_30
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109081", "109081002", "story_v_out_109081.awb") ~= 0 then
					local var_11_34 = manager.audio:GetVoiceLength("story_v_out_109081", "109081002", "story_v_out_109081.awb") / 1000

					if var_11_34 + var_11_26 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_34 + var_11_26
					end

					if var_11_29.prefab_name ~= "" and arg_8_1.actors_[var_11_29.prefab_name] ~= nil then
						local var_11_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_29.prefab_name].transform, "story_v_out_109081", "109081002", "story_v_out_109081.awb")

						arg_8_1:RecordAudio("109081002", var_11_35)
						arg_8_1:RecordAudio("109081002", var_11_35)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_109081", "109081002", "story_v_out_109081.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_109081", "109081002", "story_v_out_109081.awb")
				end

				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_36 = math.max(var_11_27, arg_8_1.talkMaxDuration)

			if var_11_26 <= arg_8_1.time_ and arg_8_1.time_ < var_11_26 + var_11_36 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_26) / var_11_36

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_26 + var_11_36 and arg_8_1.time_ < var_11_26 + var_11_36 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10004ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_8_1:InitPlayNodeList()
	end,
	Play109081003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 109081003
		arg_12_1.duration_ = 8.47

		local var_12_0 = {
			ja = 4.133,
			ko = 4.066,
			zh = 8.466,
			en = 3.933
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
				arg_12_0:Play109081004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = arg_12_1.actors_["3004_tpose"]
			local var_15_1 = 0

			if var_15_1 < arg_12_1.time_ and arg_12_1.time_ <= var_15_1 + arg_15_0 and not isNil(var_15_0) and arg_12_1.var_.characterEffect3004_tpose == nil then
				arg_12_1.var_.characterEffect3004_tpose = var_15_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_2 = 0.2

			if var_15_1 <= arg_12_1.time_ and arg_12_1.time_ < var_15_1 + var_15_2 and not isNil(var_15_0) then
				local var_15_3 = (arg_12_1.time_ - var_15_1) / var_15_2

				if arg_12_1.var_.characterEffect3004_tpose and not isNil(var_15_0) then
					arg_12_1.var_.characterEffect3004_tpose.fillFlat = false
				end
			end

			if arg_12_1.time_ >= var_15_1 + var_15_2 and arg_12_1.time_ < var_15_1 + var_15_2 + arg_15_0 and not isNil(var_15_0) and arg_12_1.var_.characterEffect3004_tpose then
				arg_12_1.var_.characterEffect3004_tpose.fillFlat = false
			end

			local var_15_4 = arg_12_1.actors_["10004ui_story"]
			local var_15_5 = 0

			if var_15_5 < arg_12_1.time_ and arg_12_1.time_ <= var_15_5 + arg_15_0 and not isNil(var_15_4) and arg_12_1.var_.characterEffect10004ui_story == nil then
				arg_12_1.var_.characterEffect10004ui_story = var_15_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_6 = 0.2

			if var_15_5 <= arg_12_1.time_ and arg_12_1.time_ < var_15_5 + var_15_6 and not isNil(var_15_4) then
				local var_15_7 = (arg_12_1.time_ - var_15_5) / var_15_6

				if arg_12_1.var_.characterEffect10004ui_story and not isNil(var_15_4) then
					local var_15_8 = Mathf.Lerp(0, 0.5, var_15_7)

					arg_12_1.var_.characterEffect10004ui_story.fillFlat = true
					arg_12_1.var_.characterEffect10004ui_story.fillRatio = var_15_8
				end
			end

			if arg_12_1.time_ >= var_15_5 + var_15_6 and arg_12_1.time_ < var_15_5 + var_15_6 + arg_15_0 and not isNil(var_15_4) and arg_12_1.var_.characterEffect10004ui_story then
				local var_15_9 = 0.5

				arg_12_1.var_.characterEffect10004ui_story.fillFlat = true
				arg_12_1.var_.characterEffect10004ui_story.fillRatio = var_15_9
			end

			local var_15_10 = 0
			local var_15_11 = 0.35

			if var_15_10 < arg_12_1.time_ and arg_12_1.time_ <= var_15_10 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				local var_15_12 = arg_12_1:FormatText(StoryNameCfg[82].name)

				arg_12_1.leftNameTxt_.text = var_15_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_13 = arg_12_1:GetWordFromCfg(109081003)
				local var_15_14 = arg_12_1:FormatText(var_15_13.content)

				arg_12_1.text_.text = var_15_14

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_15 = 14
				local var_15_16 = utf8.len(var_15_14)
				local var_15_17 = var_15_15 <= 0 and var_15_11 or var_15_11 * (var_15_16 / var_15_15)

				if var_15_17 > 0 and var_15_11 < var_15_17 then
					arg_12_1.talkMaxDuration = var_15_17

					if var_15_17 + var_15_10 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_17 + var_15_10
					end
				end

				arg_12_1.text_.text = var_15_14
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109081", "109081003", "story_v_out_109081.awb") ~= 0 then
					local var_15_18 = manager.audio:GetVoiceLength("story_v_out_109081", "109081003", "story_v_out_109081.awb") / 1000

					if var_15_18 + var_15_10 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_18 + var_15_10
					end

					if var_15_13.prefab_name ~= "" and arg_12_1.actors_[var_15_13.prefab_name] ~= nil then
						local var_15_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_13.prefab_name].transform, "story_v_out_109081", "109081003", "story_v_out_109081.awb")

						arg_12_1:RecordAudio("109081003", var_15_19)
						arg_12_1:RecordAudio("109081003", var_15_19)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_109081", "109081003", "story_v_out_109081.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_109081", "109081003", "story_v_out_109081.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_20 = math.max(var_15_11, arg_12_1.talkMaxDuration)

			if var_15_10 <= arg_12_1.time_ and arg_12_1.time_ < var_15_10 + var_15_20 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_10) / var_15_20

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_10 + var_15_20 and arg_12_1.time_ < var_15_10 + var_15_20 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play109081004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 109081004
		arg_16_1.duration_ = 6.13

		local var_16_0 = {
			ja = 5.933,
			ko = 6.133,
			zh = 5.533,
			en = 5.733
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
				arg_16_0:Play109081005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = arg_16_1.actors_["3004_tpose"].transform
			local var_19_1 = 0

			if var_19_1 < arg_16_1.time_ and arg_16_1.time_ <= var_19_1 + arg_19_0 then
				arg_16_1.var_.moveOldPos3004_tpose = var_19_0.localPosition

				local var_19_2 = GameObjectTools.GetOrAddComponent(var_19_0.gameObject, typeof(DynamicBoneHelper))

				if var_19_2 then
					var_19_2:EnableDynamicBone(false)
				end
			end

			local var_19_3 = 0.001

			if var_19_1 <= arg_16_1.time_ and arg_16_1.time_ < var_19_1 + var_19_3 then
				local var_19_4 = (arg_16_1.time_ - var_19_1) / var_19_3
				local var_19_5 = Vector3.New(0, 100, 0)

				var_19_0.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos3004_tpose, var_19_5, var_19_4)

				local var_19_6 = manager.ui.mainCamera.transform.position - var_19_0.position

				var_19_0.forward = Vector3.New(var_19_6.x, var_19_6.y, var_19_6.z)

				local var_19_7 = var_19_0.localEulerAngles

				var_19_7.z = 0
				var_19_7.x = 0
				var_19_0.localEulerAngles = var_19_7
			end

			if arg_16_1.time_ >= var_19_1 + var_19_3 and arg_16_1.time_ < var_19_1 + var_19_3 + arg_19_0 then
				var_19_0.localPosition = Vector3.New(0, 100, 0)

				local var_19_8 = manager.ui.mainCamera.transform.position - var_19_0.position

				var_19_0.forward = Vector3.New(var_19_8.x, var_19_8.y, var_19_8.z)

				local var_19_9 = var_19_0.localEulerAngles

				var_19_9.z = 0
				var_19_9.x = 0
				var_19_0.localEulerAngles = var_19_9

				local var_19_10 = GameObjectTools.GetOrAddComponent(var_19_0.gameObject, typeof(DynamicBoneHelper))

				if var_19_10 then
					var_19_10:EnableDynamicBone(true)
				end
			end

			local var_19_11 = arg_16_1.actors_["10004ui_story"].transform
			local var_19_12 = 0

			if var_19_12 < arg_16_1.time_ and arg_16_1.time_ <= var_19_12 + arg_19_0 then
				arg_16_1.var_.moveOldPos10004ui_story = var_19_11.localPosition
			end

			local var_19_13 = 0.001

			if var_19_12 <= arg_16_1.time_ and arg_16_1.time_ < var_19_12 + var_19_13 then
				local var_19_14 = (arg_16_1.time_ - var_19_12) / var_19_13
				local var_19_15 = Vector3.New(0, 100, 0)

				var_19_11.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos10004ui_story, var_19_15, var_19_14)

				local var_19_16 = manager.ui.mainCamera.transform.position - var_19_11.position

				var_19_11.forward = Vector3.New(var_19_16.x, var_19_16.y, var_19_16.z)

				local var_19_17 = var_19_11.localEulerAngles

				var_19_17.z = 0
				var_19_17.x = 0
				var_19_11.localEulerAngles = var_19_17
			end

			if arg_16_1.time_ >= var_19_12 + var_19_13 and arg_16_1.time_ < var_19_12 + var_19_13 + arg_19_0 then
				var_19_11.localPosition = Vector3.New(0, 100, 0)

				local var_19_18 = manager.ui.mainCamera.transform.position - var_19_11.position

				var_19_11.forward = Vector3.New(var_19_18.x, var_19_18.y, var_19_18.z)

				local var_19_19 = var_19_11.localEulerAngles

				var_19_19.z = 0
				var_19_19.x = 0
				var_19_11.localEulerAngles = var_19_19
			end

			local var_19_20 = "1099ui_story"

			if arg_16_1.actors_[var_19_20] == nil then
				local var_19_21 = Asset.Load("Char/" .. "1099ui_story")

				if not isNil(var_19_21) then
					local var_19_22 = Object.Instantiate(Asset.Load("Char/" .. "1099ui_story"), arg_16_1.stage_.transform)

					var_19_22.name = var_19_20
					var_19_22.transform.localPosition = Vector3.New(0, 100, 0)
					arg_16_1.actors_[var_19_20] = var_19_22

					local var_19_23 = var_19_22:GetComponentInChildren(typeof(CharacterEffect))

					var_19_23.enabled = true

					local var_19_24 = GameObjectTools.GetOrAddComponent(var_19_22, typeof(DynamicBoneHelper))

					if var_19_24 then
						var_19_24:EnableDynamicBone(false)
					end

					arg_16_1:ShowWeapon(var_19_23.transform, false)

					arg_16_1.var_[var_19_20 .. "Animator"] = var_19_23.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_16_1.var_[var_19_20 .. "Animator"].applyRootMotion = true
					arg_16_1.var_[var_19_20 .. "LipSync"] = var_19_23.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_19_25 = arg_16_1.actors_["1099ui_story"].transform
			local var_19_26 = 0

			if var_19_26 < arg_16_1.time_ and arg_16_1.time_ <= var_19_26 + arg_19_0 then
				arg_16_1.var_.moveOldPos1099ui_story = var_19_25.localPosition
			end

			local var_19_27 = 0.001

			if var_19_26 <= arg_16_1.time_ and arg_16_1.time_ < var_19_26 + var_19_27 then
				local var_19_28 = (arg_16_1.time_ - var_19_26) / var_19_27
				local var_19_29 = Vector3.New(-0.7, -1.08, -5.9)

				var_19_25.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos1099ui_story, var_19_29, var_19_28)

				local var_19_30 = manager.ui.mainCamera.transform.position - var_19_25.position

				var_19_25.forward = Vector3.New(var_19_30.x, var_19_30.y, var_19_30.z)

				local var_19_31 = var_19_25.localEulerAngles

				var_19_31.z = 0
				var_19_31.x = 0
				var_19_25.localEulerAngles = var_19_31
			end

			if arg_16_1.time_ >= var_19_26 + var_19_27 and arg_16_1.time_ < var_19_26 + var_19_27 + arg_19_0 then
				var_19_25.localPosition = Vector3.New(-0.7, -1.08, -5.9)

				local var_19_32 = manager.ui.mainCamera.transform.position - var_19_25.position

				var_19_25.forward = Vector3.New(var_19_32.x, var_19_32.y, var_19_32.z)

				local var_19_33 = var_19_25.localEulerAngles

				var_19_33.z = 0
				var_19_33.x = 0
				var_19_25.localEulerAngles = var_19_33
			end

			local var_19_34 = arg_16_1.actors_["1099ui_story"]
			local var_19_35 = 0

			if var_19_35 < arg_16_1.time_ and arg_16_1.time_ <= var_19_35 + arg_19_0 and not isNil(var_19_34) and arg_16_1.var_.characterEffect1099ui_story == nil then
				arg_16_1.var_.characterEffect1099ui_story = var_19_34:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_36 = 0.2

			if var_19_35 <= arg_16_1.time_ and arg_16_1.time_ < var_19_35 + var_19_36 and not isNil(var_19_34) then
				local var_19_37 = (arg_16_1.time_ - var_19_35) / var_19_36

				if arg_16_1.var_.characterEffect1099ui_story and not isNil(var_19_34) then
					arg_16_1.var_.characterEffect1099ui_story.fillFlat = false
				end
			end

			if arg_16_1.time_ >= var_19_35 + var_19_36 and arg_16_1.time_ < var_19_35 + var_19_36 + arg_19_0 and not isNil(var_19_34) and arg_16_1.var_.characterEffect1099ui_story then
				arg_16_1.var_.characterEffect1099ui_story.fillFlat = false
			end

			local var_19_38 = 0

			if var_19_38 < arg_16_1.time_ and arg_16_1.time_ <= var_19_38 + arg_19_0 then
				arg_16_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/story1099/story1099action/1099action5_1")
			end

			local var_19_39 = 0

			if var_19_39 < arg_16_1.time_ and arg_16_1.time_ <= var_19_39 + arg_19_0 then
				arg_16_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_19_40 = 0
			local var_19_41 = 0.8

			if var_19_40 < arg_16_1.time_ and arg_16_1.time_ <= var_19_40 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				local var_19_42 = arg_16_1:FormatText(StoryNameCfg[84].name)

				arg_16_1.leftNameTxt_.text = var_19_42

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_43 = arg_16_1:GetWordFromCfg(109081004)
				local var_19_44 = arg_16_1:FormatText(var_19_43.content)

				arg_16_1.text_.text = var_19_44

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_45 = 32
				local var_19_46 = utf8.len(var_19_44)
				local var_19_47 = var_19_45 <= 0 and var_19_41 or var_19_41 * (var_19_46 / var_19_45)

				if var_19_47 > 0 and var_19_41 < var_19_47 then
					arg_16_1.talkMaxDuration = var_19_47

					if var_19_47 + var_19_40 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_47 + var_19_40
					end
				end

				arg_16_1.text_.text = var_19_44
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109081", "109081004", "story_v_out_109081.awb") ~= 0 then
					local var_19_48 = manager.audio:GetVoiceLength("story_v_out_109081", "109081004", "story_v_out_109081.awb") / 1000

					if var_19_48 + var_19_40 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_48 + var_19_40
					end

					if var_19_43.prefab_name ~= "" and arg_16_1.actors_[var_19_43.prefab_name] ~= nil then
						local var_19_49 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_43.prefab_name].transform, "story_v_out_109081", "109081004", "story_v_out_109081.awb")

						arg_16_1:RecordAudio("109081004", var_19_49)
						arg_16_1:RecordAudio("109081004", var_19_49)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_109081", "109081004", "story_v_out_109081.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_109081", "109081004", "story_v_out_109081.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_50 = math.max(var_19_41, arg_16_1.talkMaxDuration)

			if var_19_40 <= arg_16_1.time_ and arg_16_1.time_ < var_19_40 + var_19_50 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_40) / var_19_50

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_40 + var_19_50 and arg_16_1.time_ < var_19_40 + var_19_50 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {
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

		arg_16_1:InitPlayNodeList()
	end,
	Play109081005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 109081005
		arg_20_1.duration_ = 2

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play109081006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = arg_20_1.actors_["1099ui_story"]
			local var_23_1 = 0

			if var_23_1 < arg_20_1.time_ and arg_20_1.time_ <= var_23_1 + arg_23_0 and not isNil(var_23_0) and arg_20_1.var_.characterEffect1099ui_story == nil then
				arg_20_1.var_.characterEffect1099ui_story = var_23_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_2 = 0.2

			if var_23_1 <= arg_20_1.time_ and arg_20_1.time_ < var_23_1 + var_23_2 and not isNil(var_23_0) then
				local var_23_3 = (arg_20_1.time_ - var_23_1) / var_23_2

				if arg_20_1.var_.characterEffect1099ui_story and not isNil(var_23_0) then
					local var_23_4 = Mathf.Lerp(0, 0.5, var_23_3)

					arg_20_1.var_.characterEffect1099ui_story.fillFlat = true
					arg_20_1.var_.characterEffect1099ui_story.fillRatio = var_23_4
				end
			end

			if arg_20_1.time_ >= var_23_1 + var_23_2 and arg_20_1.time_ < var_23_1 + var_23_2 + arg_23_0 and not isNil(var_23_0) and arg_20_1.var_.characterEffect1099ui_story then
				local var_23_5 = 0.5

				arg_20_1.var_.characterEffect1099ui_story.fillFlat = true
				arg_20_1.var_.characterEffect1099ui_story.fillRatio = var_23_5
			end

			local var_23_6 = "1050ui_story"

			if arg_20_1.actors_[var_23_6] == nil then
				local var_23_7 = Asset.Load("Char/" .. "1050ui_story")

				if not isNil(var_23_7) then
					local var_23_8 = Object.Instantiate(Asset.Load("Char/" .. "1050ui_story"), arg_20_1.stage_.transform)

					var_23_8.name = var_23_6
					var_23_8.transform.localPosition = Vector3.New(0, 100, 0)
					arg_20_1.actors_[var_23_6] = var_23_8

					local var_23_9 = var_23_8:GetComponentInChildren(typeof(CharacterEffect))

					var_23_9.enabled = true

					local var_23_10 = GameObjectTools.GetOrAddComponent(var_23_8, typeof(DynamicBoneHelper))

					if var_23_10 then
						var_23_10:EnableDynamicBone(false)
					end

					arg_20_1:ShowWeapon(var_23_9.transform, false)

					arg_20_1.var_[var_23_6 .. "Animator"] = var_23_9.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_20_1.var_[var_23_6 .. "Animator"].applyRootMotion = true
					arg_20_1.var_[var_23_6 .. "LipSync"] = var_23_9.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_23_11 = arg_20_1.actors_["1050ui_story"]
			local var_23_12 = 0

			if var_23_12 < arg_20_1.time_ and arg_20_1.time_ <= var_23_12 + arg_23_0 and not isNil(var_23_11) and arg_20_1.var_.characterEffect1050ui_story == nil then
				arg_20_1.var_.characterEffect1050ui_story = var_23_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_13 = 0.2

			if var_23_12 <= arg_20_1.time_ and arg_20_1.time_ < var_23_12 + var_23_13 and not isNil(var_23_11) then
				local var_23_14 = (arg_20_1.time_ - var_23_12) / var_23_13

				if arg_20_1.var_.characterEffect1050ui_story and not isNil(var_23_11) then
					arg_20_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_20_1.time_ >= var_23_12 + var_23_13 and arg_20_1.time_ < var_23_12 + var_23_13 + arg_23_0 and not isNil(var_23_11) and arg_20_1.var_.characterEffect1050ui_story then
				arg_20_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			local var_23_15 = arg_20_1.actors_["1050ui_story"].transform
			local var_23_16 = 0

			if var_23_16 < arg_20_1.time_ and arg_20_1.time_ <= var_23_16 + arg_23_0 then
				arg_20_1.var_.moveOldPos1050ui_story = var_23_15.localPosition

				local var_23_17 = "1050ui_story"

				arg_20_1:ShowWeapon(arg_20_1.var_[var_23_17 .. "Animator"].transform, true)
			end

			local var_23_18 = 0.001

			if var_23_16 <= arg_20_1.time_ and arg_20_1.time_ < var_23_16 + var_23_18 then
				local var_23_19 = (arg_20_1.time_ - var_23_16) / var_23_18
				local var_23_20 = Vector3.New(0.7, -1, -6.1)

				var_23_15.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos1050ui_story, var_23_20, var_23_19)

				local var_23_21 = manager.ui.mainCamera.transform.position - var_23_15.position

				var_23_15.forward = Vector3.New(var_23_21.x, var_23_21.y, var_23_21.z)

				local var_23_22 = var_23_15.localEulerAngles

				var_23_22.z = 0
				var_23_22.x = 0
				var_23_15.localEulerAngles = var_23_22
			end

			if arg_20_1.time_ >= var_23_16 + var_23_18 and arg_20_1.time_ < var_23_16 + var_23_18 + arg_23_0 then
				var_23_15.localPosition = Vector3.New(0.7, -1, -6.1)

				local var_23_23 = manager.ui.mainCamera.transform.position - var_23_15.position

				var_23_15.forward = Vector3.New(var_23_23.x, var_23_23.y, var_23_23.z)

				local var_23_24 = var_23_15.localEulerAngles

				var_23_24.z = 0
				var_23_24.x = 0
				var_23_15.localEulerAngles = var_23_24
			end

			local var_23_25 = 0

			if var_23_25 < arg_20_1.time_ and arg_20_1.time_ <= var_23_25 + arg_23_0 then
				arg_20_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050action/1050action6_1")
			end

			local var_23_26 = 0

			if var_23_26 < arg_20_1.time_ and arg_20_1.time_ <= var_23_26 + arg_23_0 then
				arg_20_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_23_27 = 0
			local var_23_28 = 0.15

			if var_23_27 < arg_20_1.time_ and arg_20_1.time_ <= var_23_27 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				local var_23_29 = arg_20_1:FormatText(StoryNameCfg[74].name)

				arg_20_1.leftNameTxt_.text = var_23_29

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_30 = arg_20_1:GetWordFromCfg(109081005)
				local var_23_31 = arg_20_1:FormatText(var_23_30.content)

				arg_20_1.text_.text = var_23_31

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_32 = 6
				local var_23_33 = utf8.len(var_23_31)
				local var_23_34 = var_23_32 <= 0 and var_23_28 or var_23_28 * (var_23_33 / var_23_32)

				if var_23_34 > 0 and var_23_28 < var_23_34 then
					arg_20_1.talkMaxDuration = var_23_34

					if var_23_34 + var_23_27 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_34 + var_23_27
					end
				end

				arg_20_1.text_.text = var_23_31
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109081", "109081005", "story_v_out_109081.awb") ~= 0 then
					local var_23_35 = manager.audio:GetVoiceLength("story_v_out_109081", "109081005", "story_v_out_109081.awb") / 1000

					if var_23_35 + var_23_27 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_35 + var_23_27
					end

					if var_23_30.prefab_name ~= "" and arg_20_1.actors_[var_23_30.prefab_name] ~= nil then
						local var_23_36 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_30.prefab_name].transform, "story_v_out_109081", "109081005", "story_v_out_109081.awb")

						arg_20_1:RecordAudio("109081005", var_23_36)
						arg_20_1:RecordAudio("109081005", var_23_36)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_109081", "109081005", "story_v_out_109081.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_109081", "109081005", "story_v_out_109081.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_37 = math.max(var_23_28, arg_20_1.talkMaxDuration)

			if var_23_27 <= arg_20_1.time_ and arg_20_1.time_ < var_23_27 + var_23_37 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_27) / var_23_37

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_27 + var_23_37 and arg_20_1.time_ < var_23_27 + var_23_37 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {
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

		arg_20_1:InitPlayNodeList()
	end,
	Play109081006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 109081006
		arg_24_1.duration_ = 6.6

		local var_24_0 = {
			ja = 6.6,
			ko = 2.933,
			zh = 4.633,
			en = 3.5
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
				arg_24_0:Play109081007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = arg_24_1.actors_["1099ui_story"]
			local var_27_1 = 0

			if var_27_1 < arg_24_1.time_ and arg_24_1.time_ <= var_27_1 + arg_27_0 and not isNil(var_27_0) and arg_24_1.var_.characterEffect1099ui_story == nil then
				arg_24_1.var_.characterEffect1099ui_story = var_27_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_2 = 0.2

			if var_27_1 <= arg_24_1.time_ and arg_24_1.time_ < var_27_1 + var_27_2 and not isNil(var_27_0) then
				local var_27_3 = (arg_24_1.time_ - var_27_1) / var_27_2

				if arg_24_1.var_.characterEffect1099ui_story and not isNil(var_27_0) then
					local var_27_4 = Mathf.Lerp(0, 0.5, var_27_3)

					arg_24_1.var_.characterEffect1099ui_story.fillFlat = true
					arg_24_1.var_.characterEffect1099ui_story.fillRatio = var_27_4
				end
			end

			if arg_24_1.time_ >= var_27_1 + var_27_2 and arg_24_1.time_ < var_27_1 + var_27_2 + arg_27_0 and not isNil(var_27_0) and arg_24_1.var_.characterEffect1099ui_story then
				local var_27_5 = 0.5

				arg_24_1.var_.characterEffect1099ui_story.fillFlat = true
				arg_24_1.var_.characterEffect1099ui_story.fillRatio = var_27_5
			end

			local var_27_6 = arg_24_1.actors_["1050ui_story"]
			local var_27_7 = 0

			if var_27_7 < arg_24_1.time_ and arg_24_1.time_ <= var_27_7 + arg_27_0 and not isNil(var_27_6) and arg_24_1.var_.characterEffect1050ui_story == nil then
				arg_24_1.var_.characterEffect1050ui_story = var_27_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_8 = 0.2

			if var_27_7 <= arg_24_1.time_ and arg_24_1.time_ < var_27_7 + var_27_8 and not isNil(var_27_6) then
				local var_27_9 = (arg_24_1.time_ - var_27_7) / var_27_8

				if arg_24_1.var_.characterEffect1050ui_story and not isNil(var_27_6) then
					local var_27_10 = Mathf.Lerp(0, 0.5, var_27_9)

					arg_24_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_24_1.var_.characterEffect1050ui_story.fillRatio = var_27_10
				end
			end

			if arg_24_1.time_ >= var_27_7 + var_27_8 and arg_24_1.time_ < var_27_7 + var_27_8 + arg_27_0 and not isNil(var_27_6) and arg_24_1.var_.characterEffect1050ui_story then
				local var_27_11 = 0.5

				arg_24_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_24_1.var_.characterEffect1050ui_story.fillRatio = var_27_11
			end

			local var_27_12 = 0
			local var_27_13 = 0.45

			if var_27_12 < arg_24_1.time_ and arg_24_1.time_ <= var_27_12 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				local var_27_14 = arg_24_1:FormatText(StoryNameCfg[80].name)

				arg_24_1.leftNameTxt_.text = var_27_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, true)
				arg_24_1.iconController_:SetSelectedState("hero")

				arg_24_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10004")

				arg_24_1.callingController_:SetSelectedState("normal")

				arg_24_1.keyicon_.color = Color.New(1, 1, 1)
				arg_24_1.icon_.color = Color.New(1, 1, 1)

				local var_27_15 = arg_24_1:GetWordFromCfg(109081006)
				local var_27_16 = arg_24_1:FormatText(var_27_15.content)

				arg_24_1.text_.text = var_27_16

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_17 = 18
				local var_27_18 = utf8.len(var_27_16)
				local var_27_19 = var_27_17 <= 0 and var_27_13 or var_27_13 * (var_27_18 / var_27_17)

				if var_27_19 > 0 and var_27_13 < var_27_19 then
					arg_24_1.talkMaxDuration = var_27_19

					if var_27_19 + var_27_12 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_19 + var_27_12
					end
				end

				arg_24_1.text_.text = var_27_16
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109081", "109081006", "story_v_out_109081.awb") ~= 0 then
					local var_27_20 = manager.audio:GetVoiceLength("story_v_out_109081", "109081006", "story_v_out_109081.awb") / 1000

					if var_27_20 + var_27_12 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_20 + var_27_12
					end

					if var_27_15.prefab_name ~= "" and arg_24_1.actors_[var_27_15.prefab_name] ~= nil then
						local var_27_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_15.prefab_name].transform, "story_v_out_109081", "109081006", "story_v_out_109081.awb")

						arg_24_1:RecordAudio("109081006", var_27_21)
						arg_24_1:RecordAudio("109081006", var_27_21)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_109081", "109081006", "story_v_out_109081.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_109081", "109081006", "story_v_out_109081.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_22 = math.max(var_27_13, arg_24_1.talkMaxDuration)

			if var_27_12 <= arg_24_1.time_ and arg_24_1.time_ < var_27_12 + var_27_22 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_12) / var_27_22

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_12 + var_27_22 and arg_24_1.time_ < var_27_12 + var_27_22 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play109081007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 109081007
		arg_28_1.duration_ = 5

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play109081008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = arg_28_1.actors_["1050ui_story"].transform
			local var_31_1 = 0

			if var_31_1 < arg_28_1.time_ and arg_28_1.time_ <= var_31_1 + arg_31_0 then
				arg_28_1.var_.moveOldPos1050ui_story = var_31_0.localPosition

				local var_31_2 = "1050ui_story"

				arg_28_1:ShowWeapon(arg_28_1.var_[var_31_2 .. "Animator"].transform, true)
			end

			local var_31_3 = 0.001

			if var_31_1 <= arg_28_1.time_ and arg_28_1.time_ < var_31_1 + var_31_3 then
				local var_31_4 = (arg_28_1.time_ - var_31_1) / var_31_3
				local var_31_5 = Vector3.New(0, 100, 0)

				var_31_0.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos1050ui_story, var_31_5, var_31_4)

				local var_31_6 = manager.ui.mainCamera.transform.position - var_31_0.position

				var_31_0.forward = Vector3.New(var_31_6.x, var_31_6.y, var_31_6.z)

				local var_31_7 = var_31_0.localEulerAngles

				var_31_7.z = 0
				var_31_7.x = 0
				var_31_0.localEulerAngles = var_31_7
			end

			if arg_28_1.time_ >= var_31_1 + var_31_3 and arg_28_1.time_ < var_31_1 + var_31_3 + arg_31_0 then
				var_31_0.localPosition = Vector3.New(0, 100, 0)

				local var_31_8 = manager.ui.mainCamera.transform.position - var_31_0.position

				var_31_0.forward = Vector3.New(var_31_8.x, var_31_8.y, var_31_8.z)

				local var_31_9 = var_31_0.localEulerAngles

				var_31_9.z = 0
				var_31_9.x = 0
				var_31_0.localEulerAngles = var_31_9
			end

			local var_31_10 = arg_28_1.actors_["1099ui_story"].transform
			local var_31_11 = 0

			if var_31_11 < arg_28_1.time_ and arg_28_1.time_ <= var_31_11 + arg_31_0 then
				arg_28_1.var_.moveOldPos1099ui_story = var_31_10.localPosition
			end

			local var_31_12 = 0.001

			if var_31_11 <= arg_28_1.time_ and arg_28_1.time_ < var_31_11 + var_31_12 then
				local var_31_13 = (arg_28_1.time_ - var_31_11) / var_31_12
				local var_31_14 = Vector3.New(0, 100, 0)

				var_31_10.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos1099ui_story, var_31_14, var_31_13)

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

			local var_31_19 = 0
			local var_31_20 = 0.375

			if var_31_19 < arg_28_1.time_ and arg_28_1.time_ <= var_31_19 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0

				arg_28_1.dialog_:SetActive(true)

				arg_28_1.dialogCg_.alpha = 0

				local var_31_21 = LeanTween.value(arg_28_1.dialog_, 0, 1, 0.3)

				var_31_21:setOnUpdate(LuaHelper.FloatAction(function(arg_32_0)
					arg_28_1.dialogCg_.alpha = arg_32_0
				end))
				var_31_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_28_1.dialog_)
					var_31_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_28_1.duration_ = arg_28_1.duration_ + 0.3

				SetActive(arg_28_1.leftNameGo_, false)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_22 = arg_28_1:GetWordFromCfg(109081007)
				local var_31_23 = arg_28_1:FormatText(var_31_22.content)

				arg_28_1.text_.text = var_31_23

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_24 = 15
				local var_31_25 = utf8.len(var_31_23)
				local var_31_26 = var_31_24 <= 0 and var_31_20 or var_31_20 * (var_31_25 / var_31_24)

				if var_31_26 > 0 and var_31_20 < var_31_26 then
					arg_28_1.talkMaxDuration = var_31_26
					var_31_19 = var_31_19 + 0.3

					if var_31_26 + var_31_19 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_26 + var_31_19
					end
				end

				arg_28_1.text_.text = var_31_23
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)
				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_27 = var_31_19 + 0.3
			local var_31_28 = math.max(var_31_20, arg_28_1.talkMaxDuration)

			if var_31_27 <= arg_28_1.time_ and arg_28_1.time_ < var_31_27 + var_31_28 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_27) / var_31_28

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_27 + var_31_28 and arg_28_1.time_ < var_31_27 + var_31_28 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {
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
			}
		}

		arg_28_1:InitPlayNodeList()
	end,
	Play109081008 = function(arg_34_0, arg_34_1)
		arg_34_1.time_ = 0
		arg_34_1.frameCnt_ = 0
		arg_34_1.state_ = "playing"
		arg_34_1.curTalkId_ = 109081008
		arg_34_1.duration_ = 5

		SetActive(arg_34_1.tipsGo_, false)

		function arg_34_1.onSingleLineFinish_()
			arg_34_1.onSingleLineUpdate_ = nil
			arg_34_1.onSingleLineFinish_ = nil
			arg_34_1.state_ = "waiting"
		end

		function arg_34_1.playNext_(arg_36_0)
			if arg_36_0 == 1 then
				arg_34_0:Play109081009(arg_34_1)
			end
		end

		function arg_34_1.onSingleLineUpdate_(arg_37_0)
			local var_37_0 = manager.ui.mainCamera.transform
			local var_37_1 = 0.866666666666667

			if var_37_1 < arg_34_1.time_ and arg_34_1.time_ <= var_37_1 + arg_37_0 then
				arg_34_1.var_.shakeOldPosC07_1 = var_37_0.localPosition
			end

			local var_37_2 = 0.6

			if var_37_1 <= arg_34_1.time_ and arg_34_1.time_ < var_37_1 + var_37_2 then
				local var_37_3 = (arg_34_1.time_ - var_37_1) / 0.066
				local var_37_4, var_37_5 = math.modf(var_37_3)

				var_37_0.localPosition = Vector3.New(var_37_5 * 0.13, var_37_5 * 0.13, var_37_5 * 0.13) + arg_34_1.var_.shakeOldPosC07_1
			end

			if arg_34_1.time_ >= var_37_1 + var_37_2 and arg_34_1.time_ < var_37_1 + var_37_2 + arg_37_0 then
				var_37_0.localPosition = arg_34_1.var_.shakeOldPosC07_1
			end

			local var_37_6 = 0
			local var_37_7 = 1

			if var_37_6 < arg_34_1.time_ and arg_34_1.time_ <= var_37_6 + arg_37_0 then
				local var_37_8 = "play"
				local var_37_9 = "effect"

				arg_34_1:AudioAction(var_37_8, var_37_9, "se_story_9", "se_story_9_shock", "")
			end

			local var_37_10 = 0.466666666666667
			local var_37_11 = 1

			if var_37_10 < arg_34_1.time_ and arg_34_1.time_ <= var_37_10 + arg_37_0 then
				local var_37_12 = "play"
				local var_37_13 = "effect"

				arg_34_1:AudioAction(var_37_12, var_37_13, "se_story_9", "se_story_9_shock02_loop", "")
			end

			local var_37_14 = 0
			local var_37_15 = 1.15

			if var_37_14 < arg_34_1.time_ and arg_34_1.time_ <= var_37_14 + arg_37_0 then
				arg_34_1.talkMaxDuration = 0
				arg_34_1.dialogCg_.alpha = 1

				arg_34_1.dialog_:SetActive(true)
				SetActive(arg_34_1.leftNameGo_, false)

				arg_34_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_34_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_34_1:RecordName(arg_34_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_34_1.iconTrs_.gameObject, false)
				arg_34_1.callingController_:SetSelectedState("normal")

				local var_37_16 = arg_34_1:GetWordFromCfg(109081008)
				local var_37_17 = arg_34_1:FormatText(var_37_16.content)

				arg_34_1.text_.text = var_37_17

				LuaForUtil.ClearLinePrefixSymbol(arg_34_1.text_)

				local var_37_18 = 46
				local var_37_19 = utf8.len(var_37_17)
				local var_37_20 = var_37_18 <= 0 and var_37_15 or var_37_15 * (var_37_19 / var_37_18)

				if var_37_20 > 0 and var_37_15 < var_37_20 then
					arg_34_1.talkMaxDuration = var_37_20

					if var_37_20 + var_37_14 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_20 + var_37_14
					end
				end

				arg_34_1.text_.text = var_37_17
				arg_34_1.typewritter.percent = 0

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(false)
				arg_34_1:RecordContent(arg_34_1.text_.text)
			end

			local var_37_21 = math.max(var_37_15, arg_34_1.talkMaxDuration)

			if var_37_14 <= arg_34_1.time_ and arg_34_1.time_ < var_37_14 + var_37_21 then
				arg_34_1.typewritter.percent = (arg_34_1.time_ - var_37_14) / var_37_21

				arg_34_1.typewritter:SetDirty()
			end

			if arg_34_1.time_ >= var_37_14 + var_37_21 and arg_34_1.time_ < var_37_14 + var_37_21 + arg_37_0 then
				arg_34_1.typewritter.percent = 1

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(true)
			end
		end

		arg_34_1.nodeConfigList_ = {}

		arg_34_1:InitPlayNodeList()
	end,
	Play109081009 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 109081009
		arg_38_1.duration_ = 5.47

		SetActive(arg_38_1.tipsGo_, false)

		function arg_38_1.onSingleLineFinish_()
			arg_38_1.onSingleLineUpdate_ = nil
			arg_38_1.onSingleLineFinish_ = nil
			arg_38_1.state_ = "waiting"
		end

		function arg_38_1.playNext_(arg_40_0)
			if arg_40_0 == 1 then
				arg_38_0:Play109081010(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			local var_41_0 = arg_38_1.bgs_.C07_1.transform
			local var_41_1 = 0.466666666666667

			if var_41_1 < arg_38_1.time_ and arg_38_1.time_ <= var_41_1 + arg_41_0 then
				arg_38_1.var_.shakeOldPosC07_1 = var_41_0.localPosition
			end

			local var_41_2 = 5

			if var_41_1 <= arg_38_1.time_ and arg_38_1.time_ < var_41_1 + var_41_2 then
				local var_41_3 = (arg_38_1.time_ - var_41_1) / 0.099
				local var_41_4, var_41_5 = math.modf(var_41_3)

				var_41_0.localPosition = Vector3.New(var_41_5 * 0.5, var_41_5 * 0.5, var_41_5 * 0) + arg_38_1.var_.shakeOldPosC07_1
			end

			if arg_38_1.time_ >= var_41_1 + var_41_2 and arg_38_1.time_ < var_41_1 + var_41_2 + arg_41_0 then
				var_41_0.localPosition = arg_38_1.var_.shakeOldPosC07_1
			end

			local var_41_6 = 0
			local var_41_7 = 0.925

			if var_41_6 < arg_38_1.time_ and arg_38_1.time_ <= var_41_6 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0
				arg_38_1.dialogCg_.alpha = 1

				arg_38_1.dialog_:SetActive(true)
				SetActive(arg_38_1.leftNameGo_, false)

				arg_38_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_38_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_38_1:RecordName(arg_38_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_38_1.iconTrs_.gameObject, false)
				arg_38_1.callingController_:SetSelectedState("normal")

				local var_41_8 = arg_38_1:GetWordFromCfg(109081009)
				local var_41_9 = arg_38_1:FormatText(var_41_8.content)

				arg_38_1.text_.text = var_41_9

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_10 = 37
				local var_41_11 = utf8.len(var_41_9)
				local var_41_12 = var_41_10 <= 0 and var_41_7 or var_41_7 * (var_41_11 / var_41_10)

				if var_41_12 > 0 and var_41_7 < var_41_12 then
					arg_38_1.talkMaxDuration = var_41_12

					if var_41_12 + var_41_6 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_12 + var_41_6
					end
				end

				arg_38_1.text_.text = var_41_9
				arg_38_1.typewritter.percent = 0

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(false)
				arg_38_1:RecordContent(arg_38_1.text_.text)
			end

			local var_41_13 = math.max(var_41_7, arg_38_1.talkMaxDuration)

			if var_41_6 <= arg_38_1.time_ and arg_38_1.time_ < var_41_6 + var_41_13 then
				arg_38_1.typewritter.percent = (arg_38_1.time_ - var_41_6) / var_41_13

				arg_38_1.typewritter:SetDirty()
			end

			if arg_38_1.time_ >= var_41_6 + var_41_13 and arg_38_1.time_ < var_41_6 + var_41_13 + arg_41_0 then
				arg_38_1.typewritter.percent = 1

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(true)
			end
		end

		arg_38_1.nodeConfigList_ = {}

		arg_38_1:InitPlayNodeList()
	end,
	Play109081010 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 109081010
		arg_42_1.duration_ = 2

		SetActive(arg_42_1.tipsGo_, false)

		function arg_42_1.onSingleLineFinish_()
			arg_42_1.onSingleLineUpdate_ = nil
			arg_42_1.onSingleLineFinish_ = nil
			arg_42_1.state_ = "waiting"
		end

		function arg_42_1.playNext_(arg_44_0)
			if arg_44_0 == 1 then
				arg_42_0:Play109081011(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			local var_45_0 = arg_42_1.actors_["1050ui_story"].transform
			local var_45_1 = 0

			if var_45_1 < arg_42_1.time_ and arg_42_1.time_ <= var_45_1 + arg_45_0 then
				arg_42_1.var_.moveOldPos1050ui_story = var_45_0.localPosition

				local var_45_2 = "1050ui_story"

				arg_42_1:ShowWeapon(arg_42_1.var_[var_45_2 .. "Animator"].transform, false)
			end

			local var_45_3 = 0.001

			if var_45_1 <= arg_42_1.time_ and arg_42_1.time_ < var_45_1 + var_45_3 then
				local var_45_4 = (arg_42_1.time_ - var_45_1) / var_45_3
				local var_45_5 = Vector3.New(-0.7, -1, -6.1)

				var_45_0.localPosition = Vector3.Lerp(arg_42_1.var_.moveOldPos1050ui_story, var_45_5, var_45_4)

				local var_45_6 = manager.ui.mainCamera.transform.position - var_45_0.position

				var_45_0.forward = Vector3.New(var_45_6.x, var_45_6.y, var_45_6.z)

				local var_45_7 = var_45_0.localEulerAngles

				var_45_7.z = 0
				var_45_7.x = 0
				var_45_0.localEulerAngles = var_45_7
			end

			if arg_42_1.time_ >= var_45_1 + var_45_3 and arg_42_1.time_ < var_45_1 + var_45_3 + arg_45_0 then
				var_45_0.localPosition = Vector3.New(-0.7, -1, -6.1)

				local var_45_8 = manager.ui.mainCamera.transform.position - var_45_0.position

				var_45_0.forward = Vector3.New(var_45_8.x, var_45_8.y, var_45_8.z)

				local var_45_9 = var_45_0.localEulerAngles

				var_45_9.z = 0
				var_45_9.x = 0
				var_45_0.localEulerAngles = var_45_9
			end

			local var_45_10 = manager.ui.mainCamera.transform
			local var_45_11 = 0

			if var_45_11 < arg_42_1.time_ and arg_42_1.time_ <= var_45_11 + arg_45_0 then
				arg_42_1.var_.shakeOldPosC07_1 = var_45_10.localPosition
			end

			local var_45_12 = 0.6

			if var_45_11 <= arg_42_1.time_ and arg_42_1.time_ < var_45_11 + var_45_12 then
				local var_45_13 = (arg_42_1.time_ - var_45_11) / 0.066
				local var_45_14, var_45_15 = math.modf(var_45_13)

				var_45_10.localPosition = Vector3.New(var_45_15 * 0.13, var_45_15 * 0.13, var_45_15 * 0.13) + arg_42_1.var_.shakeOldPosC07_1
			end

			if arg_42_1.time_ >= var_45_11 + var_45_12 and arg_42_1.time_ < var_45_11 + var_45_12 + arg_45_0 then
				var_45_10.localPosition = arg_42_1.var_.shakeOldPosC07_1
			end

			local var_45_16 = arg_42_1.actors_["1050ui_story"]
			local var_45_17 = 0

			if var_45_17 < arg_42_1.time_ and arg_42_1.time_ <= var_45_17 + arg_45_0 and not isNil(var_45_16) and arg_42_1.var_.characterEffect1050ui_story == nil then
				arg_42_1.var_.characterEffect1050ui_story = var_45_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_45_18 = 0.2

			if var_45_17 <= arg_42_1.time_ and arg_42_1.time_ < var_45_17 + var_45_18 and not isNil(var_45_16) then
				local var_45_19 = (arg_42_1.time_ - var_45_17) / var_45_18

				if arg_42_1.var_.characterEffect1050ui_story and not isNil(var_45_16) then
					arg_42_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_42_1.time_ >= var_45_17 + var_45_18 and arg_42_1.time_ < var_45_17 + var_45_18 + arg_45_0 and not isNil(var_45_16) and arg_42_1.var_.characterEffect1050ui_story then
				arg_42_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			local var_45_20 = 0

			if var_45_20 < arg_42_1.time_ and arg_42_1.time_ <= var_45_20 + arg_45_0 then
				arg_42_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_45_21 = 0

			if var_45_21 < arg_42_1.time_ and arg_42_1.time_ <= var_45_21 + arg_45_0 then
				arg_42_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050action/1050action3_1")
			end

			local var_45_22 = 0
			local var_45_23 = 0.15

			if var_45_22 < arg_42_1.time_ and arg_42_1.time_ <= var_45_22 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0

				arg_42_1.dialog_:SetActive(true)

				arg_42_1.dialogCg_.alpha = 0

				local var_45_24 = LeanTween.value(arg_42_1.dialog_, 0, 1, 0.3)

				var_45_24:setOnUpdate(LuaHelper.FloatAction(function(arg_46_0)
					arg_42_1.dialogCg_.alpha = arg_46_0
				end))
				var_45_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_42_1.dialog_)
					var_45_24:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_42_1.duration_ = arg_42_1.duration_ + 0.3

				SetActive(arg_42_1.leftNameGo_, true)

				local var_45_25 = arg_42_1:FormatText(StoryNameCfg[74].name)

				arg_42_1.leftNameTxt_.text = var_45_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_42_1.leftNameTxt_.transform)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1.leftNameTxt_.text)
				SetActive(arg_42_1.iconTrs_.gameObject, false)
				arg_42_1.callingController_:SetSelectedState("normal")

				local var_45_26 = arg_42_1:GetWordFromCfg(109081010)
				local var_45_27 = arg_42_1:FormatText(var_45_26.content)

				arg_42_1.text_.text = var_45_27

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_28 = 6
				local var_45_29 = utf8.len(var_45_27)
				local var_45_30 = var_45_28 <= 0 and var_45_23 or var_45_23 * (var_45_29 / var_45_28)

				if var_45_30 > 0 and var_45_23 < var_45_30 then
					arg_42_1.talkMaxDuration = var_45_30
					var_45_22 = var_45_22 + 0.3

					if var_45_30 + var_45_22 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_30 + var_45_22
					end
				end

				arg_42_1.text_.text = var_45_27
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109081", "109081010", "story_v_out_109081.awb") ~= 0 then
					local var_45_31 = manager.audio:GetVoiceLength("story_v_out_109081", "109081010", "story_v_out_109081.awb") / 1000

					if var_45_31 + var_45_22 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_31 + var_45_22
					end

					if var_45_26.prefab_name ~= "" and arg_42_1.actors_[var_45_26.prefab_name] ~= nil then
						local var_45_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_42_1.actors_[var_45_26.prefab_name].transform, "story_v_out_109081", "109081010", "story_v_out_109081.awb")

						arg_42_1:RecordAudio("109081010", var_45_32)
						arg_42_1:RecordAudio("109081010", var_45_32)
					else
						arg_42_1:AudioAction("play", "voice", "story_v_out_109081", "109081010", "story_v_out_109081.awb")
					end

					arg_42_1:RecordHistoryTalkVoice("story_v_out_109081", "109081010", "story_v_out_109081.awb")
				end

				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_33 = var_45_22 + 0.3
			local var_45_34 = math.max(var_45_23, arg_42_1.talkMaxDuration)

			if var_45_33 <= arg_42_1.time_ and arg_42_1.time_ < var_45_33 + var_45_34 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - var_45_33) / var_45_34

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= var_45_33 + var_45_34 and arg_42_1.time_ < var_45_33 + var_45_34 + arg_45_0 then
				arg_42_1.typewritter.percent = 1

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(true)
			end
		end

		arg_42_1.nodeConfigList_ = {
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

		arg_42_1:InitPlayNodeList()
	end,
	Play109081011 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 109081011
		arg_48_1.duration_ = 3.47

		local var_48_0 = {
			ja = 2.766,
			ko = 2.5,
			zh = 3.466,
			en = 2.633
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
				arg_48_0:Play109081012(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = arg_48_1.actors_["1099ui_story"].transform
			local var_51_1 = 0

			if var_51_1 < arg_48_1.time_ and arg_48_1.time_ <= var_51_1 + arg_51_0 then
				arg_48_1.var_.moveOldPos1099ui_story = var_51_0.localPosition
			end

			local var_51_2 = 0.001

			if var_51_1 <= arg_48_1.time_ and arg_48_1.time_ < var_51_1 + var_51_2 then
				local var_51_3 = (arg_48_1.time_ - var_51_1) / var_51_2
				local var_51_4 = Vector3.New(0.7, -1.08, -5.9)

				var_51_0.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos1099ui_story, var_51_4, var_51_3)

				local var_51_5 = manager.ui.mainCamera.transform.position - var_51_0.position

				var_51_0.forward = Vector3.New(var_51_5.x, var_51_5.y, var_51_5.z)

				local var_51_6 = var_51_0.localEulerAngles

				var_51_6.z = 0
				var_51_6.x = 0
				var_51_0.localEulerAngles = var_51_6
			end

			if arg_48_1.time_ >= var_51_1 + var_51_2 and arg_48_1.time_ < var_51_1 + var_51_2 + arg_51_0 then
				var_51_0.localPosition = Vector3.New(0.7, -1.08, -5.9)

				local var_51_7 = manager.ui.mainCamera.transform.position - var_51_0.position

				var_51_0.forward = Vector3.New(var_51_7.x, var_51_7.y, var_51_7.z)

				local var_51_8 = var_51_0.localEulerAngles

				var_51_8.z = 0
				var_51_8.x = 0
				var_51_0.localEulerAngles = var_51_8
			end

			local var_51_9 = arg_48_1.actors_["1099ui_story"]
			local var_51_10 = 0

			if var_51_10 < arg_48_1.time_ and arg_48_1.time_ <= var_51_10 + arg_51_0 and not isNil(var_51_9) and arg_48_1.var_.characterEffect1099ui_story == nil then
				arg_48_1.var_.characterEffect1099ui_story = var_51_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_11 = 0.2

			if var_51_10 <= arg_48_1.time_ and arg_48_1.time_ < var_51_10 + var_51_11 and not isNil(var_51_9) then
				local var_51_12 = (arg_48_1.time_ - var_51_10) / var_51_11

				if arg_48_1.var_.characterEffect1099ui_story and not isNil(var_51_9) then
					arg_48_1.var_.characterEffect1099ui_story.fillFlat = false
				end
			end

			if arg_48_1.time_ >= var_51_10 + var_51_11 and arg_48_1.time_ < var_51_10 + var_51_11 + arg_51_0 and not isNil(var_51_9) and arg_48_1.var_.characterEffect1099ui_story then
				arg_48_1.var_.characterEffect1099ui_story.fillFlat = false
			end

			local var_51_13 = arg_48_1.actors_["1050ui_story"]
			local var_51_14 = 0

			if var_51_14 < arg_48_1.time_ and arg_48_1.time_ <= var_51_14 + arg_51_0 and not isNil(var_51_13) and arg_48_1.var_.characterEffect1050ui_story == nil then
				arg_48_1.var_.characterEffect1050ui_story = var_51_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_15 = 0.2

			if var_51_14 <= arg_48_1.time_ and arg_48_1.time_ < var_51_14 + var_51_15 and not isNil(var_51_13) then
				local var_51_16 = (arg_48_1.time_ - var_51_14) / var_51_15

				if arg_48_1.var_.characterEffect1050ui_story and not isNil(var_51_13) then
					local var_51_17 = Mathf.Lerp(0, 0.5, var_51_16)

					arg_48_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_48_1.var_.characterEffect1050ui_story.fillRatio = var_51_17
				end
			end

			if arg_48_1.time_ >= var_51_14 + var_51_15 and arg_48_1.time_ < var_51_14 + var_51_15 + arg_51_0 and not isNil(var_51_13) and arg_48_1.var_.characterEffect1050ui_story then
				local var_51_18 = 0.5

				arg_48_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_48_1.var_.characterEffect1050ui_story.fillRatio = var_51_18
			end

			local var_51_19 = 0

			if var_51_19 < arg_48_1.time_ and arg_48_1.time_ <= var_51_19 + arg_51_0 then
				arg_48_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/story1099/story1099action/1099action5_1")
			end

			local var_51_20 = arg_48_1.bgs_.C07_1.transform
			local var_51_21 = 0

			if var_51_21 < arg_48_1.time_ and arg_48_1.time_ <= var_51_21 + arg_51_0 then
				arg_48_1.var_.shakeOldPosC07_1 = var_51_20.localPosition
			end

			local var_51_22 = 2

			if var_51_21 <= arg_48_1.time_ and arg_48_1.time_ < var_51_21 + var_51_22 then
				local var_51_23 = (arg_48_1.time_ - var_51_21) / 0.099
				local var_51_24, var_51_25 = math.modf(var_51_23)

				var_51_20.localPosition = Vector3.New(var_51_25 * 0.1, var_51_25 * 0.1, var_51_25 * 0) + arg_48_1.var_.shakeOldPosC07_1
			end

			if arg_48_1.time_ >= var_51_21 + var_51_22 and arg_48_1.time_ < var_51_21 + var_51_22 + arg_51_0 then
				var_51_20.localPosition = arg_48_1.var_.shakeOldPosC07_1
			end

			local var_51_26 = 0

			if var_51_26 < arg_48_1.time_ and arg_48_1.time_ <= var_51_26 + arg_51_0 then
				arg_48_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_51_27 = 0
			local var_51_28 = 0.35

			if var_51_27 < arg_48_1.time_ and arg_48_1.time_ <= var_51_27 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				local var_51_29 = arg_48_1:FormatText(StoryNameCfg[84].name)

				arg_48_1.leftNameTxt_.text = var_51_29

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_30 = arg_48_1:GetWordFromCfg(109081011)
				local var_51_31 = arg_48_1:FormatText(var_51_30.content)

				arg_48_1.text_.text = var_51_31

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_32 = 14
				local var_51_33 = utf8.len(var_51_31)
				local var_51_34 = var_51_32 <= 0 and var_51_28 or var_51_28 * (var_51_33 / var_51_32)

				if var_51_34 > 0 and var_51_28 < var_51_34 then
					arg_48_1.talkMaxDuration = var_51_34

					if var_51_34 + var_51_27 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_34 + var_51_27
					end
				end

				arg_48_1.text_.text = var_51_31
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109081", "109081011", "story_v_out_109081.awb") ~= 0 then
					local var_51_35 = manager.audio:GetVoiceLength("story_v_out_109081", "109081011", "story_v_out_109081.awb") / 1000

					if var_51_35 + var_51_27 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_35 + var_51_27
					end

					if var_51_30.prefab_name ~= "" and arg_48_1.actors_[var_51_30.prefab_name] ~= nil then
						local var_51_36 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_30.prefab_name].transform, "story_v_out_109081", "109081011", "story_v_out_109081.awb")

						arg_48_1:RecordAudio("109081011", var_51_36)
						arg_48_1:RecordAudio("109081011", var_51_36)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_109081", "109081011", "story_v_out_109081.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_109081", "109081011", "story_v_out_109081.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_37 = math.max(var_51_28, arg_48_1.talkMaxDuration)

			if var_51_27 <= arg_48_1.time_ and arg_48_1.time_ < var_51_27 + var_51_37 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_27) / var_51_37

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_27 + var_51_37 and arg_48_1.time_ < var_51_27 + var_51_37 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {
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

		arg_48_1:InitPlayNodeList()
	end,
	Play109081012 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 109081012
		arg_52_1.duration_ = 5

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play109081013(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = "S0905"

			if arg_52_1.bgs_[var_55_0] == nil then
				local var_55_1 = Object.Instantiate(arg_52_1.paintGo_)

				var_55_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_55_0)
				var_55_1.name = var_55_0
				var_55_1.transform.parent = arg_52_1.stage_.transform
				var_55_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_52_1.bgs_[var_55_0] = var_55_1
			end

			local var_55_2 = 0

			if var_55_2 < arg_52_1.time_ and arg_52_1.time_ <= var_55_2 + arg_55_0 then
				local var_55_3 = manager.ui.mainCamera.transform.localPosition
				local var_55_4 = Vector3.New(0, 0, 10) + Vector3.New(var_55_3.x, var_55_3.y, 0)
				local var_55_5 = arg_52_1.bgs_.S0905

				var_55_5.transform.localPosition = var_55_4
				var_55_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_55_6 = var_55_5:GetComponent("SpriteRenderer")

				if var_55_6 and var_55_6.sprite then
					local var_55_7 = (var_55_5.transform.localPosition - var_55_3).z
					local var_55_8 = manager.ui.mainCameraCom_
					local var_55_9 = 2 * var_55_7 * Mathf.Tan(var_55_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_55_10 = var_55_9 * var_55_8.aspect
					local var_55_11 = var_55_6.sprite.bounds.size.x
					local var_55_12 = var_55_6.sprite.bounds.size.y
					local var_55_13 = var_55_10 / var_55_11
					local var_55_14 = var_55_9 / var_55_12
					local var_55_15 = var_55_14 < var_55_13 and var_55_13 or var_55_14

					var_55_5.transform.localScale = Vector3.New(var_55_15, var_55_15, 0)
				end

				for iter_55_0, iter_55_1 in pairs(arg_52_1.bgs_) do
					if iter_55_0 ~= "S0905" then
						iter_55_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_55_16 = arg_52_1.actors_["1050ui_story"].transform
			local var_55_17 = 0

			if var_55_17 < arg_52_1.time_ and arg_52_1.time_ <= var_55_17 + arg_55_0 then
				arg_52_1.var_.moveOldPos1050ui_story = var_55_16.localPosition
			end

			local var_55_18 = 0.001

			if var_55_17 <= arg_52_1.time_ and arg_52_1.time_ < var_55_17 + var_55_18 then
				local var_55_19 = (arg_52_1.time_ - var_55_17) / var_55_18
				local var_55_20 = Vector3.New(0, 100, 0)

				var_55_16.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPos1050ui_story, var_55_20, var_55_19)

				local var_55_21 = manager.ui.mainCamera.transform.position - var_55_16.position

				var_55_16.forward = Vector3.New(var_55_21.x, var_55_21.y, var_55_21.z)

				local var_55_22 = var_55_16.localEulerAngles

				var_55_22.z = 0
				var_55_22.x = 0
				var_55_16.localEulerAngles = var_55_22
			end

			if arg_52_1.time_ >= var_55_17 + var_55_18 and arg_52_1.time_ < var_55_17 + var_55_18 + arg_55_0 then
				var_55_16.localPosition = Vector3.New(0, 100, 0)

				local var_55_23 = manager.ui.mainCamera.transform.position - var_55_16.position

				var_55_16.forward = Vector3.New(var_55_23.x, var_55_23.y, var_55_23.z)

				local var_55_24 = var_55_16.localEulerAngles

				var_55_24.z = 0
				var_55_24.x = 0
				var_55_16.localEulerAngles = var_55_24
			end

			local var_55_25 = arg_52_1.actors_["1099ui_story"].transform
			local var_55_26 = 0

			if var_55_26 < arg_52_1.time_ and arg_52_1.time_ <= var_55_26 + arg_55_0 then
				arg_52_1.var_.moveOldPos1099ui_story = var_55_25.localPosition
			end

			local var_55_27 = 0.001

			if var_55_26 <= arg_52_1.time_ and arg_52_1.time_ < var_55_26 + var_55_27 then
				local var_55_28 = (arg_52_1.time_ - var_55_26) / var_55_27
				local var_55_29 = Vector3.New(0, 100, 0)

				var_55_25.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPos1099ui_story, var_55_29, var_55_28)

				local var_55_30 = manager.ui.mainCamera.transform.position - var_55_25.position

				var_55_25.forward = Vector3.New(var_55_30.x, var_55_30.y, var_55_30.z)

				local var_55_31 = var_55_25.localEulerAngles

				var_55_31.z = 0
				var_55_31.x = 0
				var_55_25.localEulerAngles = var_55_31
			end

			if arg_52_1.time_ >= var_55_26 + var_55_27 and arg_52_1.time_ < var_55_26 + var_55_27 + arg_55_0 then
				var_55_25.localPosition = Vector3.New(0, 100, 0)

				local var_55_32 = manager.ui.mainCamera.transform.position - var_55_25.position

				var_55_25.forward = Vector3.New(var_55_32.x, var_55_32.y, var_55_32.z)

				local var_55_33 = var_55_25.localEulerAngles

				var_55_33.z = 0
				var_55_33.x = 0
				var_55_25.localEulerAngles = var_55_33
			end

			local var_55_34 = manager.ui.mainCamera.transform
			local var_55_35 = 0

			if var_55_35 < arg_52_1.time_ and arg_52_1.time_ <= var_55_35 + arg_55_0 then
				arg_52_1.var_.shakeOldPos = var_55_34.localPosition
			end

			local var_55_36 = 3

			if var_55_35 <= arg_52_1.time_ and arg_52_1.time_ < var_55_35 + var_55_36 then
				local var_55_37 = (arg_52_1.time_ - var_55_35) / 0.066
				local var_55_38, var_55_39 = math.modf(var_55_37)

				var_55_34.localPosition = Vector3.New(var_55_39 * 0.13, var_55_39 * 0.13, var_55_39 * 0.13) + arg_52_1.var_.shakeOldPos
			end

			if arg_52_1.time_ >= var_55_35 + var_55_36 and arg_52_1.time_ < var_55_35 + var_55_36 + arg_55_0 then
				var_55_34.localPosition = arg_52_1.var_.shakeOldPos
			end

			local var_55_40 = arg_52_1.bgs_.S0905
			local var_55_41 = 0

			if var_55_41 < arg_52_1.time_ and arg_52_1.time_ <= var_55_41 + arg_55_0 then
				local var_55_42 = var_55_40:GetComponent("SpriteRenderer")

				if var_55_42 then
					arg_52_1.var_.alphaOldValueS0905 = var_55_42.color.a
					arg_52_1.var_.alphaMatValueS0905 = var_55_42
				end

				arg_52_1.var_.alphaOldValueS0905 = 0
			end

			local var_55_43 = 1.5

			if var_55_41 <= arg_52_1.time_ and arg_52_1.time_ < var_55_41 + var_55_43 then
				local var_55_44 = (arg_52_1.time_ - var_55_41) / var_55_43
				local var_55_45 = Mathf.Lerp(arg_52_1.var_.alphaOldValueS0905, 1, var_55_44)

				if arg_52_1.var_.alphaMatValueS0905 then
					local var_55_46 = arg_52_1.var_.alphaMatValueS0905.color

					var_55_46.a = var_55_45
					arg_52_1.var_.alphaMatValueS0905.color = var_55_46
				end
			end

			if arg_52_1.time_ >= var_55_41 + var_55_43 and arg_52_1.time_ < var_55_41 + var_55_43 + arg_55_0 and arg_52_1.var_.alphaMatValueS0905 then
				local var_55_47 = arg_52_1.var_.alphaMatValueS0905
				local var_55_48 = var_55_47.color

				var_55_48.a = 1
				var_55_47.color = var_55_48
			end

			local var_55_49 = arg_52_1.bgs_.S0905.transform
			local var_55_50 = 0

			if var_55_50 < arg_52_1.time_ and arg_52_1.time_ <= var_55_50 + arg_55_0 then
				arg_52_1.var_.moveOldPosS0905 = var_55_49.localPosition
			end

			local var_55_51 = 3

			if var_55_50 <= arg_52_1.time_ and arg_52_1.time_ < var_55_50 + var_55_51 then
				local var_55_52 = (arg_52_1.time_ - var_55_50) / var_55_51
				local var_55_53 = Vector3.New(0, 1, 9.5)

				var_55_49.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPosS0905, var_55_53, var_55_52)
			end

			if arg_52_1.time_ >= var_55_50 + var_55_51 and arg_52_1.time_ < var_55_50 + var_55_51 + arg_55_0 then
				var_55_49.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_55_54 = 0
			local var_55_55 = 1

			if var_55_54 < arg_52_1.time_ and arg_52_1.time_ <= var_55_54 + arg_55_0 then
				local var_55_56 = "stop"
				local var_55_57 = "music"

				arg_52_1:AudioAction(var_55_56, var_55_57, "se_story_9", "se_story_9_shock02_loop", "")

				local var_55_58 = ""
				local var_55_59 = manager.audio:GetAudioName("se_story_9", "se_story_9_shock02_loop")

				if var_55_59 ~= "" then
					if arg_52_1.bgmTxt_.text ~= var_55_59 and arg_52_1.bgmTxt_.text ~= "" then
						if arg_52_1.bgmTxt2_.text ~= "" then
							arg_52_1.bgmTxt_.text = arg_52_1.bgmTxt2_.text
						end

						arg_52_1.bgmTxt2_.text = var_55_59

						arg_52_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_52_1.bgmTxt_.text = var_55_59
						arg_52_1.bgmTxt2_.text = var_55_59
					end

					if arg_52_1.bgmTimer then
						arg_52_1.bgmTimer:Stop()

						arg_52_1.bgmTimer = nil
					end

					if arg_52_1.settingData.show_music_name == 1 then
						arg_52_1.musicController:SetSelectedState("show")
						arg_52_1.musicAnimator_:Play("open", 0, 0)

						if arg_52_1.settingData.music_time ~= 0 then
							arg_52_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_52_1.settingData.music_time), function()
								if arg_52_1 == nil or isNil(arg_52_1.bgmTxt_) then
									return
								end

								arg_52_1.musicController:SetSelectedState("hide")
								arg_52_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_55_60 = 0.433333333333333
			local var_55_61 = 1

			if var_55_60 < arg_52_1.time_ and arg_52_1.time_ <= var_55_60 + arg_55_0 then
				local var_55_62 = "play"
				local var_55_63 = "effect"

				arg_52_1:AudioAction(var_55_62, var_55_63, "se_story_9", "se_story_9_monster", "")
			end

			local var_55_64 = 0
			local var_55_65 = 0.1

			if var_55_64 < arg_52_1.time_ and arg_52_1.time_ <= var_55_64 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0

				arg_52_1.dialog_:SetActive(true)

				arg_52_1.dialogCg_.alpha = 0

				local var_55_66 = LeanTween.value(arg_52_1.dialog_, 0, 1, 0.3)

				var_55_66:setOnUpdate(LuaHelper.FloatAction(function(arg_57_0)
					arg_52_1.dialogCg_.alpha = arg_57_0
				end))
				var_55_66:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_52_1.dialog_)
					var_55_66:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_52_1.duration_ = arg_52_1.duration_ + 0.3

				SetActive(arg_52_1.leftNameGo_, true)

				local var_55_67 = arg_52_1:FormatText(StoryNameCfg[159].name)

				arg_52_1.leftNameTxt_.text = var_55_67

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_68 = arg_52_1:GetWordFromCfg(109081012)
				local var_55_69 = arg_52_1:FormatText(var_55_68.content)

				arg_52_1.text_.text = var_55_69

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_70 = 4
				local var_55_71 = utf8.len(var_55_69)
				local var_55_72 = var_55_70 <= 0 and var_55_65 or var_55_65 * (var_55_71 / var_55_70)

				if var_55_72 > 0 and var_55_65 < var_55_72 then
					arg_52_1.talkMaxDuration = var_55_72
					var_55_64 = var_55_64 + 0.3

					if var_55_72 + var_55_64 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_72 + var_55_64
					end
				end

				arg_52_1.text_.text = var_55_69
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)
				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_73 = var_55_64 + 0.3
			local var_55_74 = math.max(var_55_65, arg_52_1.talkMaxDuration)

			if var_55_73 <= arg_52_1.time_ and arg_52_1.time_ < var_55_73 + var_55_74 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_73) / var_55_74

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_73 + var_55_74 and arg_52_1.time_ < var_55_73 + var_55_74 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {
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
				actorName = "S0905",
				changeDisplayLayer = false,
				needEase = false,
				duration = 3,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_52_1:InitPlayNodeList()
	end,
	Play109081013 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 109081013
		arg_59_1.duration_ = 5

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play109081014(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = 0
			local var_62_1 = 1

			if var_62_0 < arg_59_1.time_ and arg_59_1.time_ <= var_62_0 + arg_62_0 then
				local var_62_2 = "play"
				local var_62_3 = "effect"

				arg_59_1:AudioAction(var_62_2, var_62_3, "se_story_9", "se_story_9_monster02", "")
			end

			local var_62_4 = 0
			local var_62_5 = 1.15

			if var_62_4 < arg_59_1.time_ and arg_59_1.time_ <= var_62_4 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, false)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_6 = arg_59_1:GetWordFromCfg(109081013)
				local var_62_7 = arg_59_1:FormatText(var_62_6.content)

				arg_59_1.text_.text = var_62_7

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_8 = 46
				local var_62_9 = utf8.len(var_62_7)
				local var_62_10 = var_62_8 <= 0 and var_62_5 or var_62_5 * (var_62_9 / var_62_8)

				if var_62_10 > 0 and var_62_5 < var_62_10 then
					arg_59_1.talkMaxDuration = var_62_10

					if var_62_10 + var_62_4 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_10 + var_62_4
					end
				end

				arg_59_1.text_.text = var_62_7
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)
				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_11 = math.max(var_62_5, arg_59_1.talkMaxDuration)

			if var_62_4 <= arg_59_1.time_ and arg_59_1.time_ < var_62_4 + var_62_11 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_4) / var_62_11

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_4 + var_62_11 and arg_59_1.time_ < var_62_4 + var_62_11 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {}

		arg_59_1:InitPlayNodeList()
	end,
	Play109081014 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 109081014
		arg_63_1.duration_ = 5

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play109081015(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = 0
			local var_66_1 = 0.725

			if var_66_0 < arg_63_1.time_ and arg_63_1.time_ <= var_66_0 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, false)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_2 = arg_63_1:GetWordFromCfg(109081014)
				local var_66_3 = arg_63_1:FormatText(var_66_2.content)

				arg_63_1.text_.text = var_66_3

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_4 = 29
				local var_66_5 = utf8.len(var_66_3)
				local var_66_6 = var_66_4 <= 0 and var_66_1 or var_66_1 * (var_66_5 / var_66_4)

				if var_66_6 > 0 and var_66_1 < var_66_6 then
					arg_63_1.talkMaxDuration = var_66_6

					if var_66_6 + var_66_0 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_6 + var_66_0
					end
				end

				arg_63_1.text_.text = var_66_3
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)
				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_7 = math.max(var_66_1, arg_63_1.talkMaxDuration)

			if var_66_0 <= arg_63_1.time_ and arg_63_1.time_ < var_66_0 + var_66_7 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_0) / var_66_7

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_0 + var_66_7 and arg_63_1.time_ < var_66_0 + var_66_7 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	Play109081015 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 109081015
		arg_67_1.duration_ = 10

		local var_67_0 = {
			ja = 10,
			ko = 8,
			zh = 5.9,
			en = 6.533
		}
		local var_67_1 = manager.audio:GetLocalizationFlag()

		if var_67_0[var_67_1] ~= nil then
			arg_67_1.duration_ = var_67_0[var_67_1]
		end

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play109081016(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = 0
			local var_70_1 = 0.5

			if var_70_0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_0 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				local var_70_2 = arg_67_1:FormatText(StoryNameCfg[87].name)

				arg_67_1.leftNameTxt_.text = var_70_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_3 = arg_67_1:GetWordFromCfg(109081015)
				local var_70_4 = arg_67_1:FormatText(var_70_3.content)

				arg_67_1.text_.text = var_70_4

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_5 = 20
				local var_70_6 = utf8.len(var_70_4)
				local var_70_7 = var_70_5 <= 0 and var_70_1 or var_70_1 * (var_70_6 / var_70_5)

				if var_70_7 > 0 and var_70_1 < var_70_7 then
					arg_67_1.talkMaxDuration = var_70_7

					if var_70_7 + var_70_0 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_7 + var_70_0
					end
				end

				arg_67_1.text_.text = var_70_4
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109081", "109081015", "story_v_out_109081.awb") ~= 0 then
					local var_70_8 = manager.audio:GetVoiceLength("story_v_out_109081", "109081015", "story_v_out_109081.awb") / 1000

					if var_70_8 + var_70_0 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_8 + var_70_0
					end

					if var_70_3.prefab_name ~= "" and arg_67_1.actors_[var_70_3.prefab_name] ~= nil then
						local var_70_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_3.prefab_name].transform, "story_v_out_109081", "109081015", "story_v_out_109081.awb")

						arg_67_1:RecordAudio("109081015", var_70_9)
						arg_67_1:RecordAudio("109081015", var_70_9)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_109081", "109081015", "story_v_out_109081.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_109081", "109081015", "story_v_out_109081.awb")
				end

				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_10 = math.max(var_70_1, arg_67_1.talkMaxDuration)

			if var_70_0 <= arg_67_1.time_ and arg_67_1.time_ < var_70_0 + var_70_10 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_0) / var_70_10

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_0 + var_70_10 and arg_67_1.time_ < var_70_0 + var_70_10 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {}

		arg_67_1:InitPlayNodeList()
	end,
	Play109081016 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 109081016
		arg_71_1.duration_ = 9.8

		local var_71_0 = {
			ja = 9.8,
			ko = 6.2,
			zh = 5.033,
			en = 6.433
		}
		local var_71_1 = manager.audio:GetLocalizationFlag()

		if var_71_0[var_71_1] ~= nil then
			arg_71_1.duration_ = var_71_0[var_71_1]
		end

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play109081017(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = 0
			local var_74_1 = 1

			if var_74_0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_0 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				local var_74_2 = arg_71_1:FormatText(StoryNameCfg[87].name)

				arg_71_1.leftNameTxt_.text = var_74_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_3 = arg_71_1:GetWordFromCfg(109081016)
				local var_74_4 = arg_71_1:FormatText(var_74_3.content)

				arg_71_1.text_.text = var_74_4

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_5 = 16
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

				if manager.audio:GetVoiceLength("story_v_out_109081", "109081016", "story_v_out_109081.awb") ~= 0 then
					local var_74_8 = manager.audio:GetVoiceLength("story_v_out_109081", "109081016", "story_v_out_109081.awb") / 1000

					if var_74_8 + var_74_0 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_8 + var_74_0
					end

					if var_74_3.prefab_name ~= "" and arg_71_1.actors_[var_74_3.prefab_name] ~= nil then
						local var_74_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_3.prefab_name].transform, "story_v_out_109081", "109081016", "story_v_out_109081.awb")

						arg_71_1:RecordAudio("109081016", var_74_9)
						arg_71_1:RecordAudio("109081016", var_74_9)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_109081", "109081016", "story_v_out_109081.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_109081", "109081016", "story_v_out_109081.awb")
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
	Play109081017 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 109081017
		arg_75_1.duration_ = 14.7

		local var_75_0 = {
			ja = 14.7,
			ko = 6.733,
			zh = 8,
			en = 7.433
		}
		local var_75_1 = manager.audio:GetLocalizationFlag()

		if var_75_0[var_75_1] ~= nil then
			arg_75_1.duration_ = var_75_0[var_75_1]
		end

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play109081018(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = 0
			local var_78_1 = 0.7

			if var_78_0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_0 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				local var_78_2 = arg_75_1:FormatText(StoryNameCfg[87].name)

				arg_75_1.leftNameTxt_.text = var_78_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_3 = arg_75_1:GetWordFromCfg(109081017)
				local var_78_4 = arg_75_1:FormatText(var_78_3.content)

				arg_75_1.text_.text = var_78_4

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_5 = 28
				local var_78_6 = utf8.len(var_78_4)
				local var_78_7 = var_78_5 <= 0 and var_78_1 or var_78_1 * (var_78_6 / var_78_5)

				if var_78_7 > 0 and var_78_1 < var_78_7 then
					arg_75_1.talkMaxDuration = var_78_7

					if var_78_7 + var_78_0 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_7 + var_78_0
					end
				end

				arg_75_1.text_.text = var_78_4
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109081", "109081017", "story_v_out_109081.awb") ~= 0 then
					local var_78_8 = manager.audio:GetVoiceLength("story_v_out_109081", "109081017", "story_v_out_109081.awb") / 1000

					if var_78_8 + var_78_0 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_8 + var_78_0
					end

					if var_78_3.prefab_name ~= "" and arg_75_1.actors_[var_78_3.prefab_name] ~= nil then
						local var_78_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_3.prefab_name].transform, "story_v_out_109081", "109081017", "story_v_out_109081.awb")

						arg_75_1:RecordAudio("109081017", var_78_9)
						arg_75_1:RecordAudio("109081017", var_78_9)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_out_109081", "109081017", "story_v_out_109081.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_out_109081", "109081017", "story_v_out_109081.awb")
				end

				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_10 = math.max(var_78_1, arg_75_1.talkMaxDuration)

			if var_78_0 <= arg_75_1.time_ and arg_75_1.time_ < var_78_0 + var_78_10 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_0) / var_78_10

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_0 + var_78_10 and arg_75_1.time_ < var_78_0 + var_78_10 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play109081018 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 109081018
		arg_79_1.duration_ = 1.43

		local var_79_0 = {
			ja = 1.433,
			ko = 1.233,
			zh = 1.233,
			en = 1.266
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
				arg_79_0:Play109081019(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = 0
			local var_82_1 = 0.1

			if var_82_0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_0 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				local var_82_2 = arg_79_1:FormatText(StoryNameCfg[84].name)

				arg_79_1.leftNameTxt_.text = var_82_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, true)
				arg_79_1.iconController_:SetSelectedState("hero")

				arg_79_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1099")

				arg_79_1.callingController_:SetSelectedState("normal")

				arg_79_1.keyicon_.color = Color.New(1, 1, 1)
				arg_79_1.icon_.color = Color.New(1, 1, 1)

				local var_82_3 = arg_79_1:GetWordFromCfg(109081018)
				local var_82_4 = arg_79_1:FormatText(var_82_3.content)

				arg_79_1.text_.text = var_82_4

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_5 = 4
				local var_82_6 = utf8.len(var_82_4)
				local var_82_7 = var_82_5 <= 0 and var_82_1 or var_82_1 * (var_82_6 / var_82_5)

				if var_82_7 > 0 and var_82_1 < var_82_7 then
					arg_79_1.talkMaxDuration = var_82_7

					if var_82_7 + var_82_0 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_7 + var_82_0
					end
				end

				arg_79_1.text_.text = var_82_4
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109081", "109081018", "story_v_out_109081.awb") ~= 0 then
					local var_82_8 = manager.audio:GetVoiceLength("story_v_out_109081", "109081018", "story_v_out_109081.awb") / 1000

					if var_82_8 + var_82_0 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_8 + var_82_0
					end

					if var_82_3.prefab_name ~= "" and arg_79_1.actors_[var_82_3.prefab_name] ~= nil then
						local var_82_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_3.prefab_name].transform, "story_v_out_109081", "109081018", "story_v_out_109081.awb")

						arg_79_1:RecordAudio("109081018", var_82_9)
						arg_79_1:RecordAudio("109081018", var_82_9)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_out_109081", "109081018", "story_v_out_109081.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_out_109081", "109081018", "story_v_out_109081.awb")
				end

				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_10 = math.max(var_82_1, arg_79_1.talkMaxDuration)

			if var_82_0 <= arg_79_1.time_ and arg_79_1.time_ < var_82_0 + var_82_10 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_0) / var_82_10

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_0 + var_82_10 and arg_79_1.time_ < var_82_0 + var_82_10 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play109081019 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 109081019
		arg_83_1.duration_ = 3.57

		local var_83_0 = {
			ja = 2.5,
			ko = 2.666,
			zh = 3.566,
			en = 3.5
		}
		local var_83_1 = manager.audio:GetLocalizationFlag()

		if var_83_0[var_83_1] ~= nil then
			arg_83_1.duration_ = var_83_0[var_83_1]
		end

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play109081020(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = 0
			local var_86_1 = 0.325

			if var_86_0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_0 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				local var_86_2 = arg_83_1:FormatText(StoryNameCfg[74].name)

				arg_83_1.leftNameTxt_.text = var_86_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, true)
				arg_83_1.iconController_:SetSelectedState("hero")

				arg_83_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1050")

				arg_83_1.callingController_:SetSelectedState("normal")

				arg_83_1.keyicon_.color = Color.New(1, 1, 1)
				arg_83_1.icon_.color = Color.New(1, 1, 1)

				local var_86_3 = arg_83_1:GetWordFromCfg(109081019)
				local var_86_4 = arg_83_1:FormatText(var_86_3.content)

				arg_83_1.text_.text = var_86_4

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_5 = 13
				local var_86_6 = utf8.len(var_86_4)
				local var_86_7 = var_86_5 <= 0 and var_86_1 or var_86_1 * (var_86_6 / var_86_5)

				if var_86_7 > 0 and var_86_1 < var_86_7 then
					arg_83_1.talkMaxDuration = var_86_7

					if var_86_7 + var_86_0 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_7 + var_86_0
					end
				end

				arg_83_1.text_.text = var_86_4
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109081", "109081019", "story_v_out_109081.awb") ~= 0 then
					local var_86_8 = manager.audio:GetVoiceLength("story_v_out_109081", "109081019", "story_v_out_109081.awb") / 1000

					if var_86_8 + var_86_0 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_8 + var_86_0
					end

					if var_86_3.prefab_name ~= "" and arg_83_1.actors_[var_86_3.prefab_name] ~= nil then
						local var_86_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_3.prefab_name].transform, "story_v_out_109081", "109081019", "story_v_out_109081.awb")

						arg_83_1:RecordAudio("109081019", var_86_9)
						arg_83_1:RecordAudio("109081019", var_86_9)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_out_109081", "109081019", "story_v_out_109081.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_out_109081", "109081019", "story_v_out_109081.awb")
				end

				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_10 = math.max(var_86_1, arg_83_1.talkMaxDuration)

			if var_86_0 <= arg_83_1.time_ and arg_83_1.time_ < var_86_0 + var_86_10 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_0) / var_86_10

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_0 + var_86_10 and arg_83_1.time_ < var_86_0 + var_86_10 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play109081020 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 109081020
		arg_87_1.duration_ = 14.07

		local var_87_0 = {
			ja = 9.566,
			ko = 11.866,
			zh = 12.8,
			en = 14.066
		}
		local var_87_1 = manager.audio:GetLocalizationFlag()

		if var_87_0[var_87_1] ~= nil then
			arg_87_1.duration_ = var_87_0[var_87_1]
		end

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play109081021(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = 0
			local var_90_1 = 0.975

			if var_90_0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_0 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				local var_90_2 = arg_87_1:FormatText(StoryNameCfg[87].name)

				arg_87_1.leftNameTxt_.text = var_90_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_3 = arg_87_1:GetWordFromCfg(109081020)
				local var_90_4 = arg_87_1:FormatText(var_90_3.content)

				arg_87_1.text_.text = var_90_4

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_5 = 45
				local var_90_6 = utf8.len(var_90_4)
				local var_90_7 = var_90_5 <= 0 and var_90_1 or var_90_1 * (var_90_6 / var_90_5)

				if var_90_7 > 0 and var_90_1 < var_90_7 then
					arg_87_1.talkMaxDuration = var_90_7

					if var_90_7 + var_90_0 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_7 + var_90_0
					end
				end

				arg_87_1.text_.text = var_90_4
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109081", "109081020", "story_v_out_109081.awb") ~= 0 then
					local var_90_8 = manager.audio:GetVoiceLength("story_v_out_109081", "109081020", "story_v_out_109081.awb") / 1000

					if var_90_8 + var_90_0 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_8 + var_90_0
					end

					if var_90_3.prefab_name ~= "" and arg_87_1.actors_[var_90_3.prefab_name] ~= nil then
						local var_90_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_3.prefab_name].transform, "story_v_out_109081", "109081020", "story_v_out_109081.awb")

						arg_87_1:RecordAudio("109081020", var_90_9)
						arg_87_1:RecordAudio("109081020", var_90_9)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_109081", "109081020", "story_v_out_109081.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_109081", "109081020", "story_v_out_109081.awb")
				end

				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_10 = math.max(var_90_1, arg_87_1.talkMaxDuration)

			if var_90_0 <= arg_87_1.time_ and arg_87_1.time_ < var_90_0 + var_90_10 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_0) / var_90_10

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_0 + var_90_10 and arg_87_1.time_ < var_90_0 + var_90_10 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {}

		arg_87_1:InitPlayNodeList()
	end,
	Play109081021 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 109081021
		arg_91_1.duration_ = 5

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play109081022(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			local var_94_0 = manager.ui.mainCamera.transform
			local var_94_1 = 0

			if var_94_1 < arg_91_1.time_ and arg_91_1.time_ <= var_94_1 + arg_94_0 then
				arg_91_1.var_.shakeOldPos = var_94_0.localPosition
			end

			local var_94_2 = 1.5

			if var_94_1 <= arg_91_1.time_ and arg_91_1.time_ < var_94_1 + var_94_2 then
				local var_94_3 = (arg_91_1.time_ - var_94_1) / 0.099
				local var_94_4, var_94_5 = math.modf(var_94_3)

				var_94_0.localPosition = Vector3.New(var_94_5 * 0.13, var_94_5 * 0.13, var_94_5 * 0.13) + arg_91_1.var_.shakeOldPos
			end

			if arg_91_1.time_ >= var_94_1 + var_94_2 and arg_91_1.time_ < var_94_1 + var_94_2 + arg_94_0 then
				var_94_0.localPosition = arg_91_1.var_.shakeOldPos
			end

			local var_94_6 = 0
			local var_94_7 = 1

			if var_94_6 < arg_91_1.time_ and arg_91_1.time_ <= var_94_6 + arg_94_0 then
				local var_94_8 = "play"
				local var_94_9 = "effect"

				arg_91_1:AudioAction(var_94_8, var_94_9, "se_story_9", "se_story_9_monster03", "")
			end

			local var_94_10 = 0
			local var_94_11 = 0.1

			if var_94_10 < arg_91_1.time_ and arg_91_1.time_ <= var_94_10 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				local var_94_12 = arg_91_1:FormatText(StoryNameCfg[159].name)

				arg_91_1.leftNameTxt_.text = var_94_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_13 = arg_91_1:GetWordFromCfg(109081021)
				local var_94_14 = arg_91_1:FormatText(var_94_13.content)

				arg_91_1.text_.text = var_94_14

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_15 = 4
				local var_94_16 = utf8.len(var_94_14)
				local var_94_17 = var_94_15 <= 0 and var_94_11 or var_94_11 * (var_94_16 / var_94_15)

				if var_94_17 > 0 and var_94_11 < var_94_17 then
					arg_91_1.talkMaxDuration = var_94_17

					if var_94_17 + var_94_10 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_17 + var_94_10
					end
				end

				arg_91_1.text_.text = var_94_14
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)
				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_18 = math.max(var_94_11, arg_91_1.talkMaxDuration)

			if var_94_10 <= arg_91_1.time_ and arg_91_1.time_ < var_94_10 + var_94_18 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_10) / var_94_18

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_10 + var_94_18 and arg_91_1.time_ < var_94_10 + var_94_18 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {}

		arg_91_1:InitPlayNodeList()
	end,
	Play109081022 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 109081022
		arg_95_1.duration_ = 5.77

		local var_95_0 = {
			ja = 5.765999999999,
			ko = 4.399999999999,
			zh = 4.232999999999,
			en = 4.599999999999
		}
		local var_95_1 = manager.audio:GetLocalizationFlag()

		if var_95_0[var_95_1] ~= nil then
			arg_95_1.duration_ = var_95_0[var_95_1]
		end

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play109081023(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			local var_98_0 = 0

			if var_98_0 < arg_95_1.time_ and arg_95_1.time_ <= var_98_0 + arg_98_0 then
				local var_98_1 = manager.ui.mainCamera.transform.localPosition
				local var_98_2 = Vector3.New(0, 0, 10) + Vector3.New(var_98_1.x, var_98_1.y, 0)
				local var_98_3 = arg_95_1.bgs_.C07_1

				var_98_3.transform.localPosition = var_98_2
				var_98_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_98_4 = var_98_3:GetComponent("SpriteRenderer")

				if var_98_4 and var_98_4.sprite then
					local var_98_5 = (var_98_3.transform.localPosition - var_98_1).z
					local var_98_6 = manager.ui.mainCameraCom_
					local var_98_7 = 2 * var_98_5 * Mathf.Tan(var_98_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_98_8 = var_98_7 * var_98_6.aspect
					local var_98_9 = var_98_4.sprite.bounds.size.x
					local var_98_10 = var_98_4.sprite.bounds.size.y
					local var_98_11 = var_98_8 / var_98_9
					local var_98_12 = var_98_7 / var_98_10
					local var_98_13 = var_98_12 < var_98_11 and var_98_11 or var_98_12

					var_98_3.transform.localScale = Vector3.New(var_98_13, var_98_13, 0)
				end

				for iter_98_0, iter_98_1 in pairs(arg_95_1.bgs_) do
					if iter_98_0 ~= "C07_1" then
						iter_98_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_98_14 = arg_95_1.bgs_.C07_1
			local var_98_15 = 0

			if var_98_15 < arg_95_1.time_ and arg_95_1.time_ <= var_98_15 + arg_98_0 then
				local var_98_16 = var_98_14:GetComponent("SpriteRenderer")

				if var_98_16 then
					arg_95_1.var_.alphaOldValueC07_1 = var_98_16.color.a
					arg_95_1.var_.alphaMatValueC07_1 = var_98_16
				end

				arg_95_1.var_.alphaOldValueC07_1 = 0
			end

			local var_98_17 = 1.5

			if var_98_15 <= arg_95_1.time_ and arg_95_1.time_ < var_98_15 + var_98_17 then
				local var_98_18 = (arg_95_1.time_ - var_98_15) / var_98_17
				local var_98_19 = Mathf.Lerp(arg_95_1.var_.alphaOldValueC07_1, 1, var_98_18)

				if arg_95_1.var_.alphaMatValueC07_1 then
					local var_98_20 = arg_95_1.var_.alphaMatValueC07_1.color

					var_98_20.a = var_98_19
					arg_95_1.var_.alphaMatValueC07_1.color = var_98_20
				end
			end

			if arg_95_1.time_ >= var_98_15 + var_98_17 and arg_95_1.time_ < var_98_15 + var_98_17 + arg_98_0 and arg_95_1.var_.alphaMatValueC07_1 then
				local var_98_21 = arg_95_1.var_.alphaMatValueC07_1
				local var_98_22 = var_98_21.color

				var_98_22.a = 1
				var_98_21.color = var_98_22
			end

			local var_98_23 = 0

			if var_98_23 < arg_95_1.time_ and arg_95_1.time_ <= var_98_23 + arg_98_0 then
				arg_95_1.allBtn_.enabled = false
			end

			local var_98_24 = 1.5

			if arg_95_1.time_ >= var_98_23 + var_98_24 and arg_95_1.time_ < var_98_23 + var_98_24 + arg_98_0 then
				arg_95_1.allBtn_.enabled = true
			end

			local var_98_25 = arg_95_1.actors_["10004ui_story"].transform
			local var_98_26 = 1

			if var_98_26 < arg_95_1.time_ and arg_95_1.time_ <= var_98_26 + arg_98_0 then
				arg_95_1.var_.moveOldPos10004ui_story = var_98_25.localPosition
			end

			local var_98_27 = 0.001

			if var_98_26 <= arg_95_1.time_ and arg_95_1.time_ < var_98_26 + var_98_27 then
				local var_98_28 = (arg_95_1.time_ - var_98_26) / var_98_27
				local var_98_29 = Vector3.New(0, -1.1, -5.6)

				var_98_25.localPosition = Vector3.Lerp(arg_95_1.var_.moveOldPos10004ui_story, var_98_29, var_98_28)

				local var_98_30 = manager.ui.mainCamera.transform.position - var_98_25.position

				var_98_25.forward = Vector3.New(var_98_30.x, var_98_30.y, var_98_30.z)

				local var_98_31 = var_98_25.localEulerAngles

				var_98_31.z = 0
				var_98_31.x = 0
				var_98_25.localEulerAngles = var_98_31
			end

			if arg_95_1.time_ >= var_98_26 + var_98_27 and arg_95_1.time_ < var_98_26 + var_98_27 + arg_98_0 then
				var_98_25.localPosition = Vector3.New(0, -1.1, -5.6)

				local var_98_32 = manager.ui.mainCamera.transform.position - var_98_25.position

				var_98_25.forward = Vector3.New(var_98_32.x, var_98_32.y, var_98_32.z)

				local var_98_33 = var_98_25.localEulerAngles

				var_98_33.z = 0
				var_98_33.x = 0
				var_98_25.localEulerAngles = var_98_33
			end

			local var_98_34 = 1

			if var_98_34 < arg_95_1.time_ and arg_95_1.time_ <= var_98_34 + arg_98_0 then
				arg_95_1:PlayTimeline("10004ui_story", "StoryTimeline/CharAction/story10004/story10004action/10004action7_2")
			end

			local var_98_35 = arg_95_1.actors_["10004ui_story"]
			local var_98_36 = 1

			if var_98_36 < arg_95_1.time_ and arg_95_1.time_ <= var_98_36 + arg_98_0 and not isNil(var_98_35) and arg_95_1.var_.characterEffect10004ui_story == nil then
				arg_95_1.var_.characterEffect10004ui_story = var_98_35:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_98_37 = 0.2

			if var_98_36 <= arg_95_1.time_ and arg_95_1.time_ < var_98_36 + var_98_37 and not isNil(var_98_35) then
				local var_98_38 = (arg_95_1.time_ - var_98_36) / var_98_37

				if arg_95_1.var_.characterEffect10004ui_story and not isNil(var_98_35) then
					arg_95_1.var_.characterEffect10004ui_story.fillFlat = false
				end
			end

			if arg_95_1.time_ >= var_98_36 + var_98_37 and arg_95_1.time_ < var_98_36 + var_98_37 + arg_98_0 and not isNil(var_98_35) and arg_95_1.var_.characterEffect10004ui_story then
				arg_95_1.var_.characterEffect10004ui_story.fillFlat = false
			end

			local var_98_39 = 1

			if var_98_39 < arg_95_1.time_ and arg_95_1.time_ <= var_98_39 + arg_98_0 then
				arg_95_1:PlayTimeline("10004ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_98_40 = 1.499999999999
			local var_98_41 = 0.3

			if var_98_40 < arg_95_1.time_ and arg_95_1.time_ <= var_98_40 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				local var_98_42 = arg_95_1:FormatText(StoryNameCfg[80].name)

				arg_95_1.leftNameTxt_.text = var_98_42

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_43 = arg_95_1:GetWordFromCfg(109081022)
				local var_98_44 = arg_95_1:FormatText(var_98_43.content)

				arg_95_1.text_.text = var_98_44

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_45 = 12
				local var_98_46 = utf8.len(var_98_44)
				local var_98_47 = var_98_45 <= 0 and var_98_41 or var_98_41 * (var_98_46 / var_98_45)

				if var_98_47 > 0 and var_98_41 < var_98_47 then
					arg_95_1.talkMaxDuration = var_98_47

					if var_98_47 + var_98_40 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_47 + var_98_40
					end
				end

				arg_95_1.text_.text = var_98_44
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109081", "109081022", "story_v_out_109081.awb") ~= 0 then
					local var_98_48 = manager.audio:GetVoiceLength("story_v_out_109081", "109081022", "story_v_out_109081.awb") / 1000

					if var_98_48 + var_98_40 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_48 + var_98_40
					end

					if var_98_43.prefab_name ~= "" and arg_95_1.actors_[var_98_43.prefab_name] ~= nil then
						local var_98_49 = LuaForUtil.PlayVoiceWithCriLipsync(arg_95_1.actors_[var_98_43.prefab_name].transform, "story_v_out_109081", "109081022", "story_v_out_109081.awb")

						arg_95_1:RecordAudio("109081022", var_98_49)
						arg_95_1:RecordAudio("109081022", var_98_49)
					else
						arg_95_1:AudioAction("play", "voice", "story_v_out_109081", "109081022", "story_v_out_109081.awb")
					end

					arg_95_1:RecordHistoryTalkVoice("story_v_out_109081", "109081022", "story_v_out_109081.awb")
				end

				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_50 = math.max(var_98_41, arg_95_1.talkMaxDuration)

			if var_98_40 <= arg_95_1.time_ and arg_95_1.time_ < var_98_40 + var_98_50 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_40) / var_98_50

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_40 + var_98_50 and arg_95_1.time_ < var_98_40 + var_98_50 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10004ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_95_1:InitPlayNodeList()
	end,
	Play109081023 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 109081023
		arg_99_1.duration_ = 8.67

		local var_99_0 = {
			ja = 8.666,
			ko = 5.866,
			zh = 4.3,
			en = 5.466
		}
		local var_99_1 = manager.audio:GetLocalizationFlag()

		if var_99_0[var_99_1] ~= nil then
			arg_99_1.duration_ = var_99_0[var_99_1]
		end

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play109081024(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = "4014_tpose"

			if arg_99_1.actors_[var_102_0] == nil then
				local var_102_1 = Asset.Load("Char/" .. "4014_tpose")

				if not isNil(var_102_1) then
					local var_102_2 = Object.Instantiate(Asset.Load("Char/" .. "4014_tpose"), arg_99_1.stage_.transform)

					var_102_2.name = var_102_0
					var_102_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_99_1.actors_[var_102_0] = var_102_2

					local var_102_3 = var_102_2:GetComponentInChildren(typeof(CharacterEffect))

					var_102_3.enabled = true

					local var_102_4 = GameObjectTools.GetOrAddComponent(var_102_2, typeof(DynamicBoneHelper))

					if var_102_4 then
						var_102_4:EnableDynamicBone(false)
					end

					arg_99_1:ShowWeapon(var_102_3.transform, false)

					arg_99_1.var_[var_102_0 .. "Animator"] = var_102_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_99_1.var_[var_102_0 .. "Animator"].applyRootMotion = true
					arg_99_1.var_[var_102_0 .. "LipSync"] = var_102_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_102_5 = arg_99_1.actors_["4014_tpose"].transform
			local var_102_6 = 0

			if var_102_6 < arg_99_1.time_ and arg_99_1.time_ <= var_102_6 + arg_102_0 then
				arg_99_1.var_.moveOldPos4014_tpose = var_102_5.localPosition

				local var_102_7 = GameObjectTools.GetOrAddComponent(var_102_5.gameObject, typeof(DynamicBoneHelper))

				if var_102_7 then
					var_102_7:EnableDynamicBone(false)
				end
			end

			local var_102_8 = 0.001

			if var_102_6 <= arg_99_1.time_ and arg_99_1.time_ < var_102_6 + var_102_8 then
				local var_102_9 = (arg_99_1.time_ - var_102_6) / var_102_8
				local var_102_10 = Vector3.New(0, -1.95, -4.2)

				var_102_5.localPosition = Vector3.Lerp(arg_99_1.var_.moveOldPos4014_tpose, var_102_10, var_102_9)

				local var_102_11 = manager.ui.mainCamera.transform.position - var_102_5.position

				var_102_5.forward = Vector3.New(var_102_11.x, var_102_11.y, var_102_11.z)

				local var_102_12 = var_102_5.localEulerAngles

				var_102_12.z = 0
				var_102_12.x = 0
				var_102_5.localEulerAngles = var_102_12
			end

			if arg_99_1.time_ >= var_102_6 + var_102_8 and arg_99_1.time_ < var_102_6 + var_102_8 + arg_102_0 then
				var_102_5.localPosition = Vector3.New(0, -1.95, -4.2)

				local var_102_13 = manager.ui.mainCamera.transform.position - var_102_5.position

				var_102_5.forward = Vector3.New(var_102_13.x, var_102_13.y, var_102_13.z)

				local var_102_14 = var_102_5.localEulerAngles

				var_102_14.z = 0
				var_102_14.x = 0
				var_102_5.localEulerAngles = var_102_14

				local var_102_15 = GameObjectTools.GetOrAddComponent(var_102_5.gameObject, typeof(DynamicBoneHelper))

				if var_102_15 then
					var_102_15:EnableDynamicBone(true)
				end
			end

			local var_102_16 = arg_99_1.actors_["4014_tpose"]
			local var_102_17 = 0

			if var_102_17 < arg_99_1.time_ and arg_99_1.time_ <= var_102_17 + arg_102_0 and not isNil(var_102_16) and arg_99_1.var_.characterEffect4014_tpose == nil then
				arg_99_1.var_.characterEffect4014_tpose = var_102_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_102_18 = 0.2

			if var_102_17 <= arg_99_1.time_ and arg_99_1.time_ < var_102_17 + var_102_18 and not isNil(var_102_16) then
				local var_102_19 = (arg_99_1.time_ - var_102_17) / var_102_18

				if arg_99_1.var_.characterEffect4014_tpose and not isNil(var_102_16) then
					arg_99_1.var_.characterEffect4014_tpose.fillFlat = false
				end
			end

			if arg_99_1.time_ >= var_102_17 + var_102_18 and arg_99_1.time_ < var_102_17 + var_102_18 + arg_102_0 and not isNil(var_102_16) and arg_99_1.var_.characterEffect4014_tpose then
				arg_99_1.var_.characterEffect4014_tpose.fillFlat = false
			end

			local var_102_20 = 0

			if var_102_20 < arg_99_1.time_ and arg_99_1.time_ <= var_102_20 + arg_102_0 then
				arg_99_1:PlayTimeline("4014_tpose", "StoryTimeline/CharAction/story4014/story4014action/4014action1_1")
			end

			local var_102_21 = arg_99_1.actors_["10004ui_story"].transform
			local var_102_22 = 0

			if var_102_22 < arg_99_1.time_ and arg_99_1.time_ <= var_102_22 + arg_102_0 then
				arg_99_1.var_.moveOldPos10004ui_story = var_102_21.localPosition
			end

			local var_102_23 = 0.001

			if var_102_22 <= arg_99_1.time_ and arg_99_1.time_ < var_102_22 + var_102_23 then
				local var_102_24 = (arg_99_1.time_ - var_102_22) / var_102_23
				local var_102_25 = Vector3.New(0, 100, 0)

				var_102_21.localPosition = Vector3.Lerp(arg_99_1.var_.moveOldPos10004ui_story, var_102_25, var_102_24)

				local var_102_26 = manager.ui.mainCamera.transform.position - var_102_21.position

				var_102_21.forward = Vector3.New(var_102_26.x, var_102_26.y, var_102_26.z)

				local var_102_27 = var_102_21.localEulerAngles

				var_102_27.z = 0
				var_102_27.x = 0
				var_102_21.localEulerAngles = var_102_27
			end

			if arg_99_1.time_ >= var_102_22 + var_102_23 and arg_99_1.time_ < var_102_22 + var_102_23 + arg_102_0 then
				var_102_21.localPosition = Vector3.New(0, 100, 0)

				local var_102_28 = manager.ui.mainCamera.transform.position - var_102_21.position

				var_102_21.forward = Vector3.New(var_102_28.x, var_102_28.y, var_102_28.z)

				local var_102_29 = var_102_21.localEulerAngles

				var_102_29.z = 0
				var_102_29.x = 0
				var_102_21.localEulerAngles = var_102_29
			end

			local var_102_30 = 0
			local var_102_31 = 0.45

			if var_102_30 < arg_99_1.time_ and arg_99_1.time_ <= var_102_30 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				local var_102_32 = arg_99_1:FormatText(StoryNameCfg[87].name)

				arg_99_1.leftNameTxt_.text = var_102_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_33 = arg_99_1:GetWordFromCfg(109081023)
				local var_102_34 = arg_99_1:FormatText(var_102_33.content)

				arg_99_1.text_.text = var_102_34

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_35 = 18
				local var_102_36 = utf8.len(var_102_34)
				local var_102_37 = var_102_35 <= 0 and var_102_31 or var_102_31 * (var_102_36 / var_102_35)

				if var_102_37 > 0 and var_102_31 < var_102_37 then
					arg_99_1.talkMaxDuration = var_102_37

					if var_102_37 + var_102_30 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_37 + var_102_30
					end
				end

				arg_99_1.text_.text = var_102_34
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109081", "109081023", "story_v_out_109081.awb") ~= 0 then
					local var_102_38 = manager.audio:GetVoiceLength("story_v_out_109081", "109081023", "story_v_out_109081.awb") / 1000

					if var_102_38 + var_102_30 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_38 + var_102_30
					end

					if var_102_33.prefab_name ~= "" and arg_99_1.actors_[var_102_33.prefab_name] ~= nil then
						local var_102_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_99_1.actors_[var_102_33.prefab_name].transform, "story_v_out_109081", "109081023", "story_v_out_109081.awb")

						arg_99_1:RecordAudio("109081023", var_102_39)
						arg_99_1:RecordAudio("109081023", var_102_39)
					else
						arg_99_1:AudioAction("play", "voice", "story_v_out_109081", "109081023", "story_v_out_109081.awb")
					end

					arg_99_1:RecordHistoryTalkVoice("story_v_out_109081", "109081023", "story_v_out_109081.awb")
				end

				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_40 = math.max(var_102_31, arg_99_1.talkMaxDuration)

			if var_102_30 <= arg_99_1.time_ and arg_99_1.time_ < var_102_30 + var_102_40 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_30) / var_102_40

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_30 + var_102_40 and arg_99_1.time_ < var_102_30 + var_102_40 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4014_tpose",
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
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_99_1:InitPlayNodeList()
	end,
	Play109081024 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 109081024
		arg_103_1.duration_ = 5

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play109081025(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			local var_106_0 = arg_103_1.actors_["4014_tpose"].transform
			local var_106_1 = 0

			if var_106_1 < arg_103_1.time_ and arg_103_1.time_ <= var_106_1 + arg_106_0 then
				arg_103_1.var_.moveOldPos4014_tpose = var_106_0.localPosition

				local var_106_2 = GameObjectTools.GetOrAddComponent(var_106_0.gameObject, typeof(DynamicBoneHelper))

				if var_106_2 then
					var_106_2:EnableDynamicBone(false)
				end
			end

			local var_106_3 = 0.001

			if var_106_1 <= arg_103_1.time_ and arg_103_1.time_ < var_106_1 + var_106_3 then
				local var_106_4 = (arg_103_1.time_ - var_106_1) / var_106_3
				local var_106_5 = Vector3.New(0, 100, 0)

				var_106_0.localPosition = Vector3.Lerp(arg_103_1.var_.moveOldPos4014_tpose, var_106_5, var_106_4)

				local var_106_6 = manager.ui.mainCamera.transform.position - var_106_0.position

				var_106_0.forward = Vector3.New(var_106_6.x, var_106_6.y, var_106_6.z)

				local var_106_7 = var_106_0.localEulerAngles

				var_106_7.z = 0
				var_106_7.x = 0
				var_106_0.localEulerAngles = var_106_7
			end

			if arg_103_1.time_ >= var_106_1 + var_106_3 and arg_103_1.time_ < var_106_1 + var_106_3 + arg_106_0 then
				var_106_0.localPosition = Vector3.New(0, 100, 0)

				local var_106_8 = manager.ui.mainCamera.transform.position - var_106_0.position

				var_106_0.forward = Vector3.New(var_106_8.x, var_106_8.y, var_106_8.z)

				local var_106_9 = var_106_0.localEulerAngles

				var_106_9.z = 0
				var_106_9.x = 0
				var_106_0.localEulerAngles = var_106_9

				local var_106_10 = GameObjectTools.GetOrAddComponent(var_106_0.gameObject, typeof(DynamicBoneHelper))

				if var_106_10 then
					var_106_10:EnableDynamicBone(true)
				end
			end

			local var_106_11 = 0
			local var_106_12 = 0.425

			if var_106_11 < arg_103_1.time_ and arg_103_1.time_ <= var_106_11 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				local var_106_13 = arg_103_1:FormatText(StoryNameCfg[7].name)

				arg_103_1.leftNameTxt_.text = var_106_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, true)
				arg_103_1.iconController_:SetSelectedState("hero")

				arg_103_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_103_1.callingController_:SetSelectedState("normal")

				arg_103_1.keyicon_.color = Color.New(1, 1, 1)
				arg_103_1.icon_.color = Color.New(1, 1, 1)

				local var_106_14 = arg_103_1:GetWordFromCfg(109081024)
				local var_106_15 = arg_103_1:FormatText(var_106_14.content)

				arg_103_1.text_.text = var_106_15

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_16 = 17
				local var_106_17 = utf8.len(var_106_15)
				local var_106_18 = var_106_16 <= 0 and var_106_12 or var_106_12 * (var_106_17 / var_106_16)

				if var_106_18 > 0 and var_106_12 < var_106_18 then
					arg_103_1.talkMaxDuration = var_106_18

					if var_106_18 + var_106_11 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_18 + var_106_11
					end
				end

				arg_103_1.text_.text = var_106_15
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)
				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_19 = math.max(var_106_12, arg_103_1.talkMaxDuration)

			if var_106_11 <= arg_103_1.time_ and arg_103_1.time_ < var_106_11 + var_106_19 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_11) / var_106_19

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_11 + var_106_19 and arg_103_1.time_ < var_106_11 + var_106_19 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4014_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_103_1:InitPlayNodeList()
	end,
	Play109081025 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 109081025
		arg_107_1.duration_ = 2.17

		local var_107_0 = {
			ja = 1.999999999999,
			ko = 2.166,
			zh = 1.999999999999,
			en = 1.999999999999
		}
		local var_107_1 = manager.audio:GetLocalizationFlag()

		if var_107_0[var_107_1] ~= nil then
			arg_107_1.duration_ = var_107_0[var_107_1]
		end

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play109081026(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			local var_110_0 = "1038ui_story"

			if arg_107_1.actors_[var_110_0] == nil then
				local var_110_1 = Asset.Load("Char/" .. "1038ui_story")

				if not isNil(var_110_1) then
					local var_110_2 = Object.Instantiate(Asset.Load("Char/" .. "1038ui_story"), arg_107_1.stage_.transform)

					var_110_2.name = var_110_0
					var_110_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_107_1.actors_[var_110_0] = var_110_2

					local var_110_3 = var_110_2:GetComponentInChildren(typeof(CharacterEffect))

					var_110_3.enabled = true

					local var_110_4 = GameObjectTools.GetOrAddComponent(var_110_2, typeof(DynamicBoneHelper))

					if var_110_4 then
						var_110_4:EnableDynamicBone(false)
					end

					arg_107_1:ShowWeapon(var_110_3.transform, false)

					arg_107_1.var_[var_110_0 .. "Animator"] = var_110_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_107_1.var_[var_110_0 .. "Animator"].applyRootMotion = true
					arg_107_1.var_[var_110_0 .. "LipSync"] = var_110_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_110_5 = arg_107_1.actors_["1038ui_story"].transform
			local var_110_6 = 0

			if var_110_6 < arg_107_1.time_ and arg_107_1.time_ <= var_110_6 + arg_110_0 then
				arg_107_1.var_.moveOldPos1038ui_story = var_110_5.localPosition
			end

			local var_110_7 = 0.001

			if var_110_6 <= arg_107_1.time_ and arg_107_1.time_ < var_110_6 + var_110_7 then
				local var_110_8 = (arg_107_1.time_ - var_110_6) / var_110_7
				local var_110_9 = Vector3.New(-0.7, -1.11, -5.9)

				var_110_5.localPosition = Vector3.Lerp(arg_107_1.var_.moveOldPos1038ui_story, var_110_9, var_110_8)

				local var_110_10 = manager.ui.mainCamera.transform.position - var_110_5.position

				var_110_5.forward = Vector3.New(var_110_10.x, var_110_10.y, var_110_10.z)

				local var_110_11 = var_110_5.localEulerAngles

				var_110_11.z = 0
				var_110_11.x = 0
				var_110_5.localEulerAngles = var_110_11
			end

			if arg_107_1.time_ >= var_110_6 + var_110_7 and arg_107_1.time_ < var_110_6 + var_110_7 + arg_110_0 then
				var_110_5.localPosition = Vector3.New(-0.7, -1.11, -5.9)

				local var_110_12 = manager.ui.mainCamera.transform.position - var_110_5.position

				var_110_5.forward = Vector3.New(var_110_12.x, var_110_12.y, var_110_12.z)

				local var_110_13 = var_110_5.localEulerAngles

				var_110_13.z = 0
				var_110_13.x = 0
				var_110_5.localEulerAngles = var_110_13
			end

			local var_110_14 = arg_107_1.actors_["1038ui_story"]
			local var_110_15 = 0

			if var_110_15 < arg_107_1.time_ and arg_107_1.time_ <= var_110_15 + arg_110_0 and not isNil(var_110_14) and arg_107_1.var_.characterEffect1038ui_story == nil then
				arg_107_1.var_.characterEffect1038ui_story = var_110_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_110_16 = 0.2

			if var_110_15 <= arg_107_1.time_ and arg_107_1.time_ < var_110_15 + var_110_16 and not isNil(var_110_14) then
				local var_110_17 = (arg_107_1.time_ - var_110_15) / var_110_16

				if arg_107_1.var_.characterEffect1038ui_story and not isNil(var_110_14) then
					arg_107_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_107_1.time_ >= var_110_15 + var_110_16 and arg_107_1.time_ < var_110_15 + var_110_16 + arg_110_0 and not isNil(var_110_14) and arg_107_1.var_.characterEffect1038ui_story then
				arg_107_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_110_18 = 0

			if var_110_18 < arg_107_1.time_ and arg_107_1.time_ <= var_110_18 + arg_110_0 then
				arg_107_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038action/1038action7_1")
			end

			local var_110_19 = 0

			if var_110_19 < arg_107_1.time_ and arg_107_1.time_ <= var_110_19 + arg_110_0 then
				arg_107_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_110_20 = 0
			local var_110_21 = 0.25

			if var_110_20 < arg_107_1.time_ and arg_107_1.time_ <= var_110_20 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				local var_110_22 = arg_107_1:FormatText(StoryNameCfg[94].name)

				arg_107_1.leftNameTxt_.text = var_110_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_23 = arg_107_1:GetWordFromCfg(109081025)
				local var_110_24 = arg_107_1:FormatText(var_110_23.content)

				arg_107_1.text_.text = var_110_24

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_25 = 10
				local var_110_26 = utf8.len(var_110_24)
				local var_110_27 = var_110_25 <= 0 and var_110_21 or var_110_21 * (var_110_26 / var_110_25)

				if var_110_27 > 0 and var_110_21 < var_110_27 then
					arg_107_1.talkMaxDuration = var_110_27

					if var_110_27 + var_110_20 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_27 + var_110_20
					end
				end

				arg_107_1.text_.text = var_110_24
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109081", "109081025", "story_v_out_109081.awb") ~= 0 then
					local var_110_28 = manager.audio:GetVoiceLength("story_v_out_109081", "109081025", "story_v_out_109081.awb") / 1000

					if var_110_28 + var_110_20 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_28 + var_110_20
					end

					if var_110_23.prefab_name ~= "" and arg_107_1.actors_[var_110_23.prefab_name] ~= nil then
						local var_110_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_23.prefab_name].transform, "story_v_out_109081", "109081025", "story_v_out_109081.awb")

						arg_107_1:RecordAudio("109081025", var_110_29)
						arg_107_1:RecordAudio("109081025", var_110_29)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_out_109081", "109081025", "story_v_out_109081.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_out_109081", "109081025", "story_v_out_109081.awb")
				end

				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_30 = math.max(var_110_21, arg_107_1.talkMaxDuration)

			if var_110_20 <= arg_107_1.time_ and arg_107_1.time_ < var_110_20 + var_110_30 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_20) / var_110_30

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_20 + var_110_30 and arg_107_1.time_ < var_110_20 + var_110_30 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {
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

		arg_107_1:InitPlayNodeList()
	end,
	Play109081026 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 109081026
		arg_111_1.duration_ = 2.1

		local var_111_0 = {
			ja = 1.999999999999,
			ko = 2.1,
			zh = 1.999999999999,
			en = 1.999999999999
		}
		local var_111_1 = manager.audio:GetLocalizationFlag()

		if var_111_0[var_111_1] ~= nil then
			arg_111_1.duration_ = var_111_0[var_111_1]
		end

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play109081027(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = "1084ui_story"

			if arg_111_1.actors_[var_114_0] == nil then
				local var_114_1 = Asset.Load("Char/" .. "1084ui_story")

				if not isNil(var_114_1) then
					local var_114_2 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_111_1.stage_.transform)

					var_114_2.name = var_114_0
					var_114_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_111_1.actors_[var_114_0] = var_114_2

					local var_114_3 = var_114_2:GetComponentInChildren(typeof(CharacterEffect))

					var_114_3.enabled = true

					local var_114_4 = GameObjectTools.GetOrAddComponent(var_114_2, typeof(DynamicBoneHelper))

					if var_114_4 then
						var_114_4:EnableDynamicBone(false)
					end

					arg_111_1:ShowWeapon(var_114_3.transform, false)

					arg_111_1.var_[var_114_0 .. "Animator"] = var_114_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_111_1.var_[var_114_0 .. "Animator"].applyRootMotion = true
					arg_111_1.var_[var_114_0 .. "LipSync"] = var_114_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_114_5 = arg_111_1.actors_["1084ui_story"].transform
			local var_114_6 = 0

			if var_114_6 < arg_111_1.time_ and arg_111_1.time_ <= var_114_6 + arg_114_0 then
				arg_111_1.var_.moveOldPos1084ui_story = var_114_5.localPosition

				local var_114_7 = "1084ui_story"

				arg_111_1:ShowWeapon(arg_111_1.var_[var_114_7 .. "Animator"].transform, true)
			end

			local var_114_8 = 0.001

			if var_114_6 <= arg_111_1.time_ and arg_111_1.time_ < var_114_6 + var_114_8 then
				local var_114_9 = (arg_111_1.time_ - var_114_6) / var_114_8
				local var_114_10 = Vector3.New(0.7, -0.97, -6)

				var_114_5.localPosition = Vector3.Lerp(arg_111_1.var_.moveOldPos1084ui_story, var_114_10, var_114_9)

				local var_114_11 = manager.ui.mainCamera.transform.position - var_114_5.position

				var_114_5.forward = Vector3.New(var_114_11.x, var_114_11.y, var_114_11.z)

				local var_114_12 = var_114_5.localEulerAngles

				var_114_12.z = 0
				var_114_12.x = 0
				var_114_5.localEulerAngles = var_114_12
			end

			if arg_111_1.time_ >= var_114_6 + var_114_8 and arg_111_1.time_ < var_114_6 + var_114_8 + arg_114_0 then
				var_114_5.localPosition = Vector3.New(0.7, -0.97, -6)

				local var_114_13 = manager.ui.mainCamera.transform.position - var_114_5.position

				var_114_5.forward = Vector3.New(var_114_13.x, var_114_13.y, var_114_13.z)

				local var_114_14 = var_114_5.localEulerAngles

				var_114_14.z = 0
				var_114_14.x = 0
				var_114_5.localEulerAngles = var_114_14
			end

			local var_114_15 = arg_111_1.actors_["1084ui_story"]
			local var_114_16 = 0

			if var_114_16 < arg_111_1.time_ and arg_111_1.time_ <= var_114_16 + arg_114_0 and not isNil(var_114_15) and arg_111_1.var_.characterEffect1084ui_story == nil then
				arg_111_1.var_.characterEffect1084ui_story = var_114_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_17 = 0.2

			if var_114_16 <= arg_111_1.time_ and arg_111_1.time_ < var_114_16 + var_114_17 and not isNil(var_114_15) then
				local var_114_18 = (arg_111_1.time_ - var_114_16) / var_114_17

				if arg_111_1.var_.characterEffect1084ui_story and not isNil(var_114_15) then
					arg_111_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_111_1.time_ >= var_114_16 + var_114_17 and arg_111_1.time_ < var_114_16 + var_114_17 + arg_114_0 and not isNil(var_114_15) and arg_111_1.var_.characterEffect1084ui_story then
				arg_111_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_114_19 = arg_111_1.actors_["1038ui_story"]
			local var_114_20 = 0

			if var_114_20 < arg_111_1.time_ and arg_111_1.time_ <= var_114_20 + arg_114_0 and not isNil(var_114_19) and arg_111_1.var_.characterEffect1038ui_story == nil then
				arg_111_1.var_.characterEffect1038ui_story = var_114_19:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_21 = 0.2

			if var_114_20 <= arg_111_1.time_ and arg_111_1.time_ < var_114_20 + var_114_21 and not isNil(var_114_19) then
				local var_114_22 = (arg_111_1.time_ - var_114_20) / var_114_21

				if arg_111_1.var_.characterEffect1038ui_story and not isNil(var_114_19) then
					local var_114_23 = Mathf.Lerp(0, 0.5, var_114_22)

					arg_111_1.var_.characterEffect1038ui_story.fillFlat = true
					arg_111_1.var_.characterEffect1038ui_story.fillRatio = var_114_23
				end
			end

			if arg_111_1.time_ >= var_114_20 + var_114_21 and arg_111_1.time_ < var_114_20 + var_114_21 + arg_114_0 and not isNil(var_114_19) and arg_111_1.var_.characterEffect1038ui_story then
				local var_114_24 = 0.5

				arg_111_1.var_.characterEffect1038ui_story.fillFlat = true
				arg_111_1.var_.characterEffect1038ui_story.fillRatio = var_114_24
			end

			local var_114_25 = 0

			if var_114_25 < arg_111_1.time_ and arg_111_1.time_ <= var_114_25 + arg_114_0 then
				arg_111_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action11_1")
			end

			local var_114_26 = 0

			if var_114_26 < arg_111_1.time_ and arg_111_1.time_ <= var_114_26 + arg_114_0 then
				arg_111_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_114_27 = 0
			local var_114_28 = 0.2

			if var_114_27 < arg_111_1.time_ and arg_111_1.time_ <= var_114_27 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				local var_114_29 = arg_111_1:FormatText(StoryNameCfg[6].name)

				arg_111_1.leftNameTxt_.text = var_114_29

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_30 = arg_111_1:GetWordFromCfg(109081026)
				local var_114_31 = arg_111_1:FormatText(var_114_30.content)

				arg_111_1.text_.text = var_114_31

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_32 = 8
				local var_114_33 = utf8.len(var_114_31)
				local var_114_34 = var_114_32 <= 0 and var_114_28 or var_114_28 * (var_114_33 / var_114_32)

				if var_114_34 > 0 and var_114_28 < var_114_34 then
					arg_111_1.talkMaxDuration = var_114_34

					if var_114_34 + var_114_27 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_34 + var_114_27
					end
				end

				arg_111_1.text_.text = var_114_31
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109081", "109081026", "story_v_out_109081.awb") ~= 0 then
					local var_114_35 = manager.audio:GetVoiceLength("story_v_out_109081", "109081026", "story_v_out_109081.awb") / 1000

					if var_114_35 + var_114_27 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_35 + var_114_27
					end

					if var_114_30.prefab_name ~= "" and arg_111_1.actors_[var_114_30.prefab_name] ~= nil then
						local var_114_36 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_30.prefab_name].transform, "story_v_out_109081", "109081026", "story_v_out_109081.awb")

						arg_111_1:RecordAudio("109081026", var_114_36)
						arg_111_1:RecordAudio("109081026", var_114_36)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_109081", "109081026", "story_v_out_109081.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_109081", "109081026", "story_v_out_109081.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_37 = math.max(var_114_28, arg_111_1.talkMaxDuration)

			if var_114_27 <= arg_111_1.time_ and arg_111_1.time_ < var_114_27 + var_114_37 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_27) / var_114_37

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_27 + var_114_37 and arg_111_1.time_ < var_114_27 + var_114_37 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {
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

		arg_111_1:InitPlayNodeList()
	end,
	Play109081027 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 109081027
		arg_115_1.duration_ = 8.1

		local var_115_0 = {
			ja = 7.8,
			ko = 7.933,
			zh = 7.966,
			en = 8.1
		}
		local var_115_1 = manager.audio:GetLocalizationFlag()

		if var_115_0[var_115_1] ~= nil then
			arg_115_1.duration_ = var_115_0[var_115_1]
		end

		SetActive(arg_115_1.tipsGo_, false)

		function arg_115_1.onSingleLineFinish_()
			arg_115_1.onSingleLineUpdate_ = nil
			arg_115_1.onSingleLineFinish_ = nil
			arg_115_1.state_ = "waiting"
		end

		function arg_115_1.playNext_(arg_117_0)
			if arg_117_0 == 1 then
				arg_115_0:Play109081028(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = 0

			if var_118_0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_0 + arg_118_0 then
				arg_115_1:PlayTimeline("4014_tpose", "StoryTimeline/CharAction/story4014/story4014action/4014action1_1")
			end

			local var_118_1 = arg_115_1.actors_["4014_tpose"]
			local var_118_2 = 0

			if var_118_2 < arg_115_1.time_ and arg_115_1.time_ <= var_118_2 + arg_118_0 and not isNil(var_118_1) and arg_115_1.var_.characterEffect4014_tpose == nil then
				arg_115_1.var_.characterEffect4014_tpose = var_118_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_3 = 0.2

			if var_118_2 <= arg_115_1.time_ and arg_115_1.time_ < var_118_2 + var_118_3 and not isNil(var_118_1) then
				local var_118_4 = (arg_115_1.time_ - var_118_2) / var_118_3

				if arg_115_1.var_.characterEffect4014_tpose and not isNil(var_118_1) then
					arg_115_1.var_.characterEffect4014_tpose.fillFlat = false
				end
			end

			if arg_115_1.time_ >= var_118_2 + var_118_3 and arg_115_1.time_ < var_118_2 + var_118_3 + arg_118_0 and not isNil(var_118_1) and arg_115_1.var_.characterEffect4014_tpose then
				arg_115_1.var_.characterEffect4014_tpose.fillFlat = false
			end

			local var_118_5 = arg_115_1.actors_["1038ui_story"].transform
			local var_118_6 = 0

			if var_118_6 < arg_115_1.time_ and arg_115_1.time_ <= var_118_6 + arg_118_0 then
				arg_115_1.var_.moveOldPos1038ui_story = var_118_5.localPosition
			end

			local var_118_7 = 0.001

			if var_118_6 <= arg_115_1.time_ and arg_115_1.time_ < var_118_6 + var_118_7 then
				local var_118_8 = (arg_115_1.time_ - var_118_6) / var_118_7
				local var_118_9 = Vector3.New(0, 100, 0)

				var_118_5.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos1038ui_story, var_118_9, var_118_8)

				local var_118_10 = manager.ui.mainCamera.transform.position - var_118_5.position

				var_118_5.forward = Vector3.New(var_118_10.x, var_118_10.y, var_118_10.z)

				local var_118_11 = var_118_5.localEulerAngles

				var_118_11.z = 0
				var_118_11.x = 0
				var_118_5.localEulerAngles = var_118_11
			end

			if arg_115_1.time_ >= var_118_6 + var_118_7 and arg_115_1.time_ < var_118_6 + var_118_7 + arg_118_0 then
				var_118_5.localPosition = Vector3.New(0, 100, 0)

				local var_118_12 = manager.ui.mainCamera.transform.position - var_118_5.position

				var_118_5.forward = Vector3.New(var_118_12.x, var_118_12.y, var_118_12.z)

				local var_118_13 = var_118_5.localEulerAngles

				var_118_13.z = 0
				var_118_13.x = 0
				var_118_5.localEulerAngles = var_118_13
			end

			local var_118_14 = arg_115_1.actors_["1084ui_story"].transform
			local var_118_15 = 0

			if var_118_15 < arg_115_1.time_ and arg_115_1.time_ <= var_118_15 + arg_118_0 then
				arg_115_1.var_.moveOldPos1084ui_story = var_118_14.localPosition
			end

			local var_118_16 = 0.001

			if var_118_15 <= arg_115_1.time_ and arg_115_1.time_ < var_118_15 + var_118_16 then
				local var_118_17 = (arg_115_1.time_ - var_118_15) / var_118_16
				local var_118_18 = Vector3.New(0, 100, 0)

				var_118_14.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos1084ui_story, var_118_18, var_118_17)

				local var_118_19 = manager.ui.mainCamera.transform.position - var_118_14.position

				var_118_14.forward = Vector3.New(var_118_19.x, var_118_19.y, var_118_19.z)

				local var_118_20 = var_118_14.localEulerAngles

				var_118_20.z = 0
				var_118_20.x = 0
				var_118_14.localEulerAngles = var_118_20
			end

			if arg_115_1.time_ >= var_118_15 + var_118_16 and arg_115_1.time_ < var_118_15 + var_118_16 + arg_118_0 then
				var_118_14.localPosition = Vector3.New(0, 100, 0)

				local var_118_21 = manager.ui.mainCamera.transform.position - var_118_14.position

				var_118_14.forward = Vector3.New(var_118_21.x, var_118_21.y, var_118_21.z)

				local var_118_22 = var_118_14.localEulerAngles

				var_118_22.z = 0
				var_118_22.x = 0
				var_118_14.localEulerAngles = var_118_22
			end

			local var_118_23 = arg_115_1.actors_["4014_tpose"].transform
			local var_118_24 = 0

			if var_118_24 < arg_115_1.time_ and arg_115_1.time_ <= var_118_24 + arg_118_0 then
				arg_115_1.var_.moveOldPos4014_tpose = var_118_23.localPosition

				local var_118_25 = GameObjectTools.GetOrAddComponent(var_118_23.gameObject, typeof(DynamicBoneHelper))

				if var_118_25 then
					var_118_25:EnableDynamicBone(false)
				end
			end

			local var_118_26 = 0.001

			if var_118_24 <= arg_115_1.time_ and arg_115_1.time_ < var_118_24 + var_118_26 then
				local var_118_27 = (arg_115_1.time_ - var_118_24) / var_118_26
				local var_118_28 = Vector3.New(0, -1.95, -4.2)

				var_118_23.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos4014_tpose, var_118_28, var_118_27)

				local var_118_29 = manager.ui.mainCamera.transform.position - var_118_23.position

				var_118_23.forward = Vector3.New(var_118_29.x, var_118_29.y, var_118_29.z)

				local var_118_30 = var_118_23.localEulerAngles

				var_118_30.z = 0
				var_118_30.x = 0
				var_118_23.localEulerAngles = var_118_30
			end

			if arg_115_1.time_ >= var_118_24 + var_118_26 and arg_115_1.time_ < var_118_24 + var_118_26 + arg_118_0 then
				var_118_23.localPosition = Vector3.New(0, -1.95, -4.2)

				local var_118_31 = manager.ui.mainCamera.transform.position - var_118_23.position

				var_118_23.forward = Vector3.New(var_118_31.x, var_118_31.y, var_118_31.z)

				local var_118_32 = var_118_23.localEulerAngles

				var_118_32.z = 0
				var_118_32.x = 0
				var_118_23.localEulerAngles = var_118_32

				local var_118_33 = GameObjectTools.GetOrAddComponent(var_118_23.gameObject, typeof(DynamicBoneHelper))

				if var_118_33 then
					var_118_33:EnableDynamicBone(true)
				end
			end

			local var_118_34 = 0
			local var_118_35 = 0.7

			if var_118_34 < arg_115_1.time_ and arg_115_1.time_ <= var_118_34 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				local var_118_36 = arg_115_1:FormatText(StoryNameCfg[87].name)

				arg_115_1.leftNameTxt_.text = var_118_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_37 = arg_115_1:GetWordFromCfg(109081027)
				local var_118_38 = arg_115_1:FormatText(var_118_37.content)

				arg_115_1.text_.text = var_118_38

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_39 = 28
				local var_118_40 = utf8.len(var_118_38)
				local var_118_41 = var_118_39 <= 0 and var_118_35 or var_118_35 * (var_118_40 / var_118_39)

				if var_118_41 > 0 and var_118_35 < var_118_41 then
					arg_115_1.talkMaxDuration = var_118_41

					if var_118_41 + var_118_34 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_41 + var_118_34
					end
				end

				arg_115_1.text_.text = var_118_38
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109081", "109081027", "story_v_out_109081.awb") ~= 0 then
					local var_118_42 = manager.audio:GetVoiceLength("story_v_out_109081", "109081027", "story_v_out_109081.awb") / 1000

					if var_118_42 + var_118_34 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_42 + var_118_34
					end

					if var_118_37.prefab_name ~= "" and arg_115_1.actors_[var_118_37.prefab_name] ~= nil then
						local var_118_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_37.prefab_name].transform, "story_v_out_109081", "109081027", "story_v_out_109081.awb")

						arg_115_1:RecordAudio("109081027", var_118_43)
						arg_115_1:RecordAudio("109081027", var_118_43)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_109081", "109081027", "story_v_out_109081.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_109081", "109081027", "story_v_out_109081.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_44 = math.max(var_118_35, arg_115_1.talkMaxDuration)

			if var_118_34 <= arg_115_1.time_ and arg_115_1.time_ < var_118_34 + var_118_44 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_34) / var_118_44

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_34 + var_118_44 and arg_115_1.time_ < var_118_34 + var_118_44 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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
				actorName = "4014_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_115_1:InitPlayNodeList()
	end,
	Play109081028 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 109081028
		arg_119_1.duration_ = 8.13

		local var_119_0 = {
			ja = 3.333,
			ko = 5.7,
			zh = 7.233,
			en = 8.133
		}
		local var_119_1 = manager.audio:GetLocalizationFlag()

		if var_119_0[var_119_1] ~= nil then
			arg_119_1.duration_ = var_119_0[var_119_1]
		end

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play109081029(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = arg_119_1.actors_["4014_tpose"].transform
			local var_122_1 = 0

			if var_122_1 < arg_119_1.time_ and arg_119_1.time_ <= var_122_1 + arg_122_0 then
				arg_119_1.var_.moveOldPos4014_tpose = var_122_0.localPosition

				local var_122_2 = GameObjectTools.GetOrAddComponent(var_122_0.gameObject, typeof(DynamicBoneHelper))

				if var_122_2 then
					var_122_2:EnableDynamicBone(false)
				end
			end

			local var_122_3 = 0.001

			if var_122_1 <= arg_119_1.time_ and arg_119_1.time_ < var_122_1 + var_122_3 then
				local var_122_4 = (arg_119_1.time_ - var_122_1) / var_122_3
				local var_122_5 = Vector3.New(0, 100, 0)

				var_122_0.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos4014_tpose, var_122_5, var_122_4)

				local var_122_6 = manager.ui.mainCamera.transform.position - var_122_0.position

				var_122_0.forward = Vector3.New(var_122_6.x, var_122_6.y, var_122_6.z)

				local var_122_7 = var_122_0.localEulerAngles

				var_122_7.z = 0
				var_122_7.x = 0
				var_122_0.localEulerAngles = var_122_7
			end

			if arg_119_1.time_ >= var_122_1 + var_122_3 and arg_119_1.time_ < var_122_1 + var_122_3 + arg_122_0 then
				var_122_0.localPosition = Vector3.New(0, 100, 0)

				local var_122_8 = manager.ui.mainCamera.transform.position - var_122_0.position

				var_122_0.forward = Vector3.New(var_122_8.x, var_122_8.y, var_122_8.z)

				local var_122_9 = var_122_0.localEulerAngles

				var_122_9.z = 0
				var_122_9.x = 0
				var_122_0.localEulerAngles = var_122_9

				local var_122_10 = GameObjectTools.GetOrAddComponent(var_122_0.gameObject, typeof(DynamicBoneHelper))

				if var_122_10 then
					var_122_10:EnableDynamicBone(true)
				end
			end

			local var_122_11 = arg_119_1.actors_["1099ui_story"].transform
			local var_122_12 = 0

			if var_122_12 < arg_119_1.time_ and arg_119_1.time_ <= var_122_12 + arg_122_0 then
				arg_119_1.var_.moveOldPos1099ui_story = var_122_11.localPosition
			end

			local var_122_13 = 0.001

			if var_122_12 <= arg_119_1.time_ and arg_119_1.time_ < var_122_12 + var_122_13 then
				local var_122_14 = (arg_119_1.time_ - var_122_12) / var_122_13
				local var_122_15 = Vector3.New(-0.7, -1.08, -5.9)

				var_122_11.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos1099ui_story, var_122_15, var_122_14)

				local var_122_16 = manager.ui.mainCamera.transform.position - var_122_11.position

				var_122_11.forward = Vector3.New(var_122_16.x, var_122_16.y, var_122_16.z)

				local var_122_17 = var_122_11.localEulerAngles

				var_122_17.z = 0
				var_122_17.x = 0
				var_122_11.localEulerAngles = var_122_17
			end

			if arg_119_1.time_ >= var_122_12 + var_122_13 and arg_119_1.time_ < var_122_12 + var_122_13 + arg_122_0 then
				var_122_11.localPosition = Vector3.New(-0.7, -1.08, -5.9)

				local var_122_18 = manager.ui.mainCamera.transform.position - var_122_11.position

				var_122_11.forward = Vector3.New(var_122_18.x, var_122_18.y, var_122_18.z)

				local var_122_19 = var_122_11.localEulerAngles

				var_122_19.z = 0
				var_122_19.x = 0
				var_122_11.localEulerAngles = var_122_19
			end

			local var_122_20 = arg_119_1.actors_["1099ui_story"]
			local var_122_21 = 0

			if var_122_21 < arg_119_1.time_ and arg_119_1.time_ <= var_122_21 + arg_122_0 and not isNil(var_122_20) and arg_119_1.var_.characterEffect1099ui_story == nil then
				arg_119_1.var_.characterEffect1099ui_story = var_122_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_22 = 0.2

			if var_122_21 <= arg_119_1.time_ and arg_119_1.time_ < var_122_21 + var_122_22 and not isNil(var_122_20) then
				local var_122_23 = (arg_119_1.time_ - var_122_21) / var_122_22

				if arg_119_1.var_.characterEffect1099ui_story and not isNil(var_122_20) then
					arg_119_1.var_.characterEffect1099ui_story.fillFlat = false
				end
			end

			if arg_119_1.time_ >= var_122_21 + var_122_22 and arg_119_1.time_ < var_122_21 + var_122_22 + arg_122_0 and not isNil(var_122_20) and arg_119_1.var_.characterEffect1099ui_story then
				arg_119_1.var_.characterEffect1099ui_story.fillFlat = false
			end

			local var_122_24 = 0

			if var_122_24 < arg_119_1.time_ and arg_119_1.time_ <= var_122_24 + arg_122_0 then
				arg_119_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/story1099/story1099action/1099action5_1")
			end

			local var_122_25 = 0

			if var_122_25 < arg_119_1.time_ and arg_119_1.time_ <= var_122_25 + arg_122_0 then
				arg_119_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_122_26 = 0
			local var_122_27 = 0.95

			if var_122_26 < arg_119_1.time_ and arg_119_1.time_ <= var_122_26 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				local var_122_28 = arg_119_1:FormatText(StoryNameCfg[84].name)

				arg_119_1.leftNameTxt_.text = var_122_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_29 = arg_119_1:GetWordFromCfg(109081028)
				local var_122_30 = arg_119_1:FormatText(var_122_29.content)

				arg_119_1.text_.text = var_122_30

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_31 = 38
				local var_122_32 = utf8.len(var_122_30)
				local var_122_33 = var_122_31 <= 0 and var_122_27 or var_122_27 * (var_122_32 / var_122_31)

				if var_122_33 > 0 and var_122_27 < var_122_33 then
					arg_119_1.talkMaxDuration = var_122_33

					if var_122_33 + var_122_26 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_33 + var_122_26
					end
				end

				arg_119_1.text_.text = var_122_30
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109081", "109081028", "story_v_out_109081.awb") ~= 0 then
					local var_122_34 = manager.audio:GetVoiceLength("story_v_out_109081", "109081028", "story_v_out_109081.awb") / 1000

					if var_122_34 + var_122_26 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_34 + var_122_26
					end

					if var_122_29.prefab_name ~= "" and arg_119_1.actors_[var_122_29.prefab_name] ~= nil then
						local var_122_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_29.prefab_name].transform, "story_v_out_109081", "109081028", "story_v_out_109081.awb")

						arg_119_1:RecordAudio("109081028", var_122_35)
						arg_119_1:RecordAudio("109081028", var_122_35)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_109081", "109081028", "story_v_out_109081.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_109081", "109081028", "story_v_out_109081.awb")
				end

				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_36 = math.max(var_122_27, arg_119_1.talkMaxDuration)

			if var_122_26 <= arg_119_1.time_ and arg_119_1.time_ < var_122_26 + var_122_36 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_26) / var_122_36

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_26 + var_122_36 and arg_119_1.time_ < var_122_26 + var_122_36 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4014_tpose",
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

		arg_119_1:InitPlayNodeList()
	end,
	Play109081029 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 109081029
		arg_123_1.duration_ = 3.53

		local var_123_0 = {
			ja = 3.533,
			ko = 3.4,
			zh = 3.333,
			en = 2.8
		}
		local var_123_1 = manager.audio:GetLocalizationFlag()

		if var_123_0[var_123_1] ~= nil then
			arg_123_1.duration_ = var_123_0[var_123_1]
		end

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play109081030(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = 0

			if var_126_0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_0 + arg_126_0 then
				arg_123_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_126_1 = 0
			local var_126_2 = 0.45

			if var_126_1 < arg_123_1.time_ and arg_123_1.time_ <= var_126_1 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				local var_126_3 = arg_123_1:FormatText(StoryNameCfg[84].name)

				arg_123_1.leftNameTxt_.text = var_126_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_4 = arg_123_1:GetWordFromCfg(109081029)
				local var_126_5 = arg_123_1:FormatText(var_126_4.content)

				arg_123_1.text_.text = var_126_5

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_6 = 18
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

				if manager.audio:GetVoiceLength("story_v_out_109081", "109081029", "story_v_out_109081.awb") ~= 0 then
					local var_126_9 = manager.audio:GetVoiceLength("story_v_out_109081", "109081029", "story_v_out_109081.awb") / 1000

					if var_126_9 + var_126_1 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_9 + var_126_1
					end

					if var_126_4.prefab_name ~= "" and arg_123_1.actors_[var_126_4.prefab_name] ~= nil then
						local var_126_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_4.prefab_name].transform, "story_v_out_109081", "109081029", "story_v_out_109081.awb")

						arg_123_1:RecordAudio("109081029", var_126_10)
						arg_123_1:RecordAudio("109081029", var_126_10)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_109081", "109081029", "story_v_out_109081.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_109081", "109081029", "story_v_out_109081.awb")
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
	Play109081030 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 109081030
		arg_127_1.duration_ = 2.23

		local var_127_0 = {
			ja = 1.999999999999,
			ko = 2.066,
			zh = 2.033,
			en = 2.233
		}
		local var_127_1 = manager.audio:GetLocalizationFlag()

		if var_127_0[var_127_1] ~= nil then
			arg_127_1.duration_ = var_127_0[var_127_1]
		end

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play109081031(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = arg_127_1.actors_["1050ui_story"].transform
			local var_130_1 = 0

			if var_130_1 < arg_127_1.time_ and arg_127_1.time_ <= var_130_1 + arg_130_0 then
				arg_127_1.var_.moveOldPos1050ui_story = var_130_0.localPosition

				local var_130_2 = "1050ui_story"

				arg_127_1:ShowWeapon(arg_127_1.var_[var_130_2 .. "Animator"].transform, true)
			end

			local var_130_3 = 0.001

			if var_130_1 <= arg_127_1.time_ and arg_127_1.time_ < var_130_1 + var_130_3 then
				local var_130_4 = (arg_127_1.time_ - var_130_1) / var_130_3
				local var_130_5 = Vector3.New(0.7, -1, -6.1)

				var_130_0.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPos1050ui_story, var_130_5, var_130_4)

				local var_130_6 = manager.ui.mainCamera.transform.position - var_130_0.position

				var_130_0.forward = Vector3.New(var_130_6.x, var_130_6.y, var_130_6.z)

				local var_130_7 = var_130_0.localEulerAngles

				var_130_7.z = 0
				var_130_7.x = 0
				var_130_0.localEulerAngles = var_130_7
			end

			if arg_127_1.time_ >= var_130_1 + var_130_3 and arg_127_1.time_ < var_130_1 + var_130_3 + arg_130_0 then
				var_130_0.localPosition = Vector3.New(0.7, -1, -6.1)

				local var_130_8 = manager.ui.mainCamera.transform.position - var_130_0.position

				var_130_0.forward = Vector3.New(var_130_8.x, var_130_8.y, var_130_8.z)

				local var_130_9 = var_130_0.localEulerAngles

				var_130_9.z = 0
				var_130_9.x = 0
				var_130_0.localEulerAngles = var_130_9
			end

			local var_130_10 = arg_127_1.actors_["1099ui_story"]
			local var_130_11 = 0

			if var_130_11 < arg_127_1.time_ and arg_127_1.time_ <= var_130_11 + arg_130_0 and not isNil(var_130_10) and arg_127_1.var_.characterEffect1099ui_story == nil then
				arg_127_1.var_.characterEffect1099ui_story = var_130_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_12 = 0.2

			if var_130_11 <= arg_127_1.time_ and arg_127_1.time_ < var_130_11 + var_130_12 and not isNil(var_130_10) then
				local var_130_13 = (arg_127_1.time_ - var_130_11) / var_130_12

				if arg_127_1.var_.characterEffect1099ui_story and not isNil(var_130_10) then
					local var_130_14 = Mathf.Lerp(0, 0.5, var_130_13)

					arg_127_1.var_.characterEffect1099ui_story.fillFlat = true
					arg_127_1.var_.characterEffect1099ui_story.fillRatio = var_130_14
				end
			end

			if arg_127_1.time_ >= var_130_11 + var_130_12 and arg_127_1.time_ < var_130_11 + var_130_12 + arg_130_0 and not isNil(var_130_10) and arg_127_1.var_.characterEffect1099ui_story then
				local var_130_15 = 0.5

				arg_127_1.var_.characterEffect1099ui_story.fillFlat = true
				arg_127_1.var_.characterEffect1099ui_story.fillRatio = var_130_15
			end

			local var_130_16 = arg_127_1.actors_["1050ui_story"]
			local var_130_17 = 0

			if var_130_17 < arg_127_1.time_ and arg_127_1.time_ <= var_130_17 + arg_130_0 and not isNil(var_130_16) and arg_127_1.var_.characterEffect1050ui_story == nil then
				arg_127_1.var_.characterEffect1050ui_story = var_130_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_18 = 0.2

			if var_130_17 <= arg_127_1.time_ and arg_127_1.time_ < var_130_17 + var_130_18 and not isNil(var_130_16) then
				local var_130_19 = (arg_127_1.time_ - var_130_17) / var_130_18

				if arg_127_1.var_.characterEffect1050ui_story and not isNil(var_130_16) then
					arg_127_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_127_1.time_ >= var_130_17 + var_130_18 and arg_127_1.time_ < var_130_17 + var_130_18 + arg_130_0 and not isNil(var_130_16) and arg_127_1.var_.characterEffect1050ui_story then
				arg_127_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			local var_130_20 = 0

			if var_130_20 < arg_127_1.time_ and arg_127_1.time_ <= var_130_20 + arg_130_0 then
				arg_127_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050action/1050action6_1")
			end

			local var_130_21 = 5.89805981832114e-17

			if var_130_21 < arg_127_1.time_ and arg_127_1.time_ <= var_130_21 + arg_130_0 then
				arg_127_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_130_22 = 0
			local var_130_23 = 0.25

			if var_130_22 < arg_127_1.time_ and arg_127_1.time_ <= var_130_22 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				local var_130_24 = arg_127_1:FormatText(StoryNameCfg[74].name)

				arg_127_1.leftNameTxt_.text = var_130_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_25 = arg_127_1:GetWordFromCfg(109081030)
				local var_130_26 = arg_127_1:FormatText(var_130_25.content)

				arg_127_1.text_.text = var_130_26

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_27 = 10
				local var_130_28 = utf8.len(var_130_26)
				local var_130_29 = var_130_27 <= 0 and var_130_23 or var_130_23 * (var_130_28 / var_130_27)

				if var_130_29 > 0 and var_130_23 < var_130_29 then
					arg_127_1.talkMaxDuration = var_130_29

					if var_130_29 + var_130_22 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_29 + var_130_22
					end
				end

				arg_127_1.text_.text = var_130_26
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109081", "109081030", "story_v_out_109081.awb") ~= 0 then
					local var_130_30 = manager.audio:GetVoiceLength("story_v_out_109081", "109081030", "story_v_out_109081.awb") / 1000

					if var_130_30 + var_130_22 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_30 + var_130_22
					end

					if var_130_25.prefab_name ~= "" and arg_127_1.actors_[var_130_25.prefab_name] ~= nil then
						local var_130_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_25.prefab_name].transform, "story_v_out_109081", "109081030", "story_v_out_109081.awb")

						arg_127_1:RecordAudio("109081030", var_130_31)
						arg_127_1:RecordAudio("109081030", var_130_31)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_109081", "109081030", "story_v_out_109081.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_109081", "109081030", "story_v_out_109081.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_32 = math.max(var_130_23, arg_127_1.talkMaxDuration)

			if var_130_22 <= arg_127_1.time_ and arg_127_1.time_ < var_130_22 + var_130_32 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_22) / var_130_32

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_22 + var_130_32 and arg_127_1.time_ < var_130_22 + var_130_32 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {
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

		arg_127_1:InitPlayNodeList()
	end,
	Play109081031 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 109081031
		arg_131_1.duration_ = 3.53

		local var_131_0 = {
			ja = 2.9,
			ko = 1.999999999999,
			zh = 1.999999999999,
			en = 3.533
		}
		local var_131_1 = manager.audio:GetLocalizationFlag()

		if var_131_0[var_131_1] ~= nil then
			arg_131_1.duration_ = var_131_0[var_131_1]
		end

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play109081032(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = arg_131_1.actors_["1099ui_story"]
			local var_134_1 = 0

			if var_134_1 < arg_131_1.time_ and arg_131_1.time_ <= var_134_1 + arg_134_0 and not isNil(var_134_0) and arg_131_1.var_.characterEffect1099ui_story == nil then
				arg_131_1.var_.characterEffect1099ui_story = var_134_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_2 = 0.2

			if var_134_1 <= arg_131_1.time_ and arg_131_1.time_ < var_134_1 + var_134_2 and not isNil(var_134_0) then
				local var_134_3 = (arg_131_1.time_ - var_134_1) / var_134_2

				if arg_131_1.var_.characterEffect1099ui_story and not isNil(var_134_0) then
					arg_131_1.var_.characterEffect1099ui_story.fillFlat = false
				end
			end

			if arg_131_1.time_ >= var_134_1 + var_134_2 and arg_131_1.time_ < var_134_1 + var_134_2 + arg_134_0 and not isNil(var_134_0) and arg_131_1.var_.characterEffect1099ui_story then
				arg_131_1.var_.characterEffect1099ui_story.fillFlat = false
			end

			local var_134_4 = arg_131_1.actors_["1050ui_story"]
			local var_134_5 = 0

			if var_134_5 < arg_131_1.time_ and arg_131_1.time_ <= var_134_5 + arg_134_0 and not isNil(var_134_4) and arg_131_1.var_.characterEffect1050ui_story == nil then
				arg_131_1.var_.characterEffect1050ui_story = var_134_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_6 = 0.2

			if var_134_5 <= arg_131_1.time_ and arg_131_1.time_ < var_134_5 + var_134_6 and not isNil(var_134_4) then
				local var_134_7 = (arg_131_1.time_ - var_134_5) / var_134_6

				if arg_131_1.var_.characterEffect1050ui_story and not isNil(var_134_4) then
					local var_134_8 = Mathf.Lerp(0, 0.5, var_134_7)

					arg_131_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_131_1.var_.characterEffect1050ui_story.fillRatio = var_134_8
				end
			end

			if arg_131_1.time_ >= var_134_5 + var_134_6 and arg_131_1.time_ < var_134_5 + var_134_6 + arg_134_0 and not isNil(var_134_4) and arg_131_1.var_.characterEffect1050ui_story then
				local var_134_9 = 0.5

				arg_131_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_131_1.var_.characterEffect1050ui_story.fillRatio = var_134_9
			end

			local var_134_10 = 0

			if var_134_10 < arg_131_1.time_ and arg_131_1.time_ <= var_134_10 + arg_134_0 then
				arg_131_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_134_11 = 0
			local var_134_12 = 0.25

			if var_134_11 < arg_131_1.time_ and arg_131_1.time_ <= var_134_11 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				local var_134_13 = arg_131_1:FormatText(StoryNameCfg[84].name)

				arg_131_1.leftNameTxt_.text = var_134_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_14 = arg_131_1:GetWordFromCfg(109081031)
				local var_134_15 = arg_131_1:FormatText(var_134_14.content)

				arg_131_1.text_.text = var_134_15

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_16 = 10
				local var_134_17 = utf8.len(var_134_15)
				local var_134_18 = var_134_16 <= 0 and var_134_12 or var_134_12 * (var_134_17 / var_134_16)

				if var_134_18 > 0 and var_134_12 < var_134_18 then
					arg_131_1.talkMaxDuration = var_134_18

					if var_134_18 + var_134_11 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_18 + var_134_11
					end
				end

				arg_131_1.text_.text = var_134_15
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109081", "109081031", "story_v_out_109081.awb") ~= 0 then
					local var_134_19 = manager.audio:GetVoiceLength("story_v_out_109081", "109081031", "story_v_out_109081.awb") / 1000

					if var_134_19 + var_134_11 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_19 + var_134_11
					end

					if var_134_14.prefab_name ~= "" and arg_131_1.actors_[var_134_14.prefab_name] ~= nil then
						local var_134_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_14.prefab_name].transform, "story_v_out_109081", "109081031", "story_v_out_109081.awb")

						arg_131_1:RecordAudio("109081031", var_134_20)
						arg_131_1:RecordAudio("109081031", var_134_20)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_109081", "109081031", "story_v_out_109081.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_109081", "109081031", "story_v_out_109081.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_21 = math.max(var_134_12, arg_131_1.talkMaxDuration)

			if var_134_11 <= arg_131_1.time_ and arg_131_1.time_ < var_134_11 + var_134_21 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_11) / var_134_21

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_11 + var_134_21 and arg_131_1.time_ < var_134_11 + var_134_21 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play109081032 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 109081032
		arg_135_1.duration_ = 8.73

		local var_135_0 = {
			ja = 8.733,
			ko = 5.733,
			zh = 4.833,
			en = 5.1
		}
		local var_135_1 = manager.audio:GetLocalizationFlag()

		if var_135_0[var_135_1] ~= nil then
			arg_135_1.duration_ = var_135_0[var_135_1]
		end

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
			arg_135_1.auto_ = false
		end

		function arg_135_1.playNext_(arg_137_0)
			arg_135_1.onStoryFinished_()
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = arg_135_1.actors_["1050ui_story"].transform
			local var_138_1 = 0

			if var_138_1 < arg_135_1.time_ and arg_135_1.time_ <= var_138_1 + arg_138_0 then
				arg_135_1.var_.moveOldPos1050ui_story = var_138_0.localPosition
			end

			local var_138_2 = 0.001

			if var_138_1 <= arg_135_1.time_ and arg_135_1.time_ < var_138_1 + var_138_2 then
				local var_138_3 = (arg_135_1.time_ - var_138_1) / var_138_2
				local var_138_4 = Vector3.New(0, 100, 0)

				var_138_0.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPos1050ui_story, var_138_4, var_138_3)

				local var_138_5 = manager.ui.mainCamera.transform.position - var_138_0.position

				var_138_0.forward = Vector3.New(var_138_5.x, var_138_5.y, var_138_5.z)

				local var_138_6 = var_138_0.localEulerAngles

				var_138_6.z = 0
				var_138_6.x = 0
				var_138_0.localEulerAngles = var_138_6
			end

			if arg_135_1.time_ >= var_138_1 + var_138_2 and arg_135_1.time_ < var_138_1 + var_138_2 + arg_138_0 then
				var_138_0.localPosition = Vector3.New(0, 100, 0)

				local var_138_7 = manager.ui.mainCamera.transform.position - var_138_0.position

				var_138_0.forward = Vector3.New(var_138_7.x, var_138_7.y, var_138_7.z)

				local var_138_8 = var_138_0.localEulerAngles

				var_138_8.z = 0
				var_138_8.x = 0
				var_138_0.localEulerAngles = var_138_8
			end

			local var_138_9 = arg_135_1.actors_["1099ui_story"].transform
			local var_138_10 = 0

			if var_138_10 < arg_135_1.time_ and arg_135_1.time_ <= var_138_10 + arg_138_0 then
				arg_135_1.var_.moveOldPos1099ui_story = var_138_9.localPosition
			end

			local var_138_11 = 0.001

			if var_138_10 <= arg_135_1.time_ and arg_135_1.time_ < var_138_10 + var_138_11 then
				local var_138_12 = (arg_135_1.time_ - var_138_10) / var_138_11
				local var_138_13 = Vector3.New(0, 100, 0)

				var_138_9.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPos1099ui_story, var_138_13, var_138_12)

				local var_138_14 = manager.ui.mainCamera.transform.position - var_138_9.position

				var_138_9.forward = Vector3.New(var_138_14.x, var_138_14.y, var_138_14.z)

				local var_138_15 = var_138_9.localEulerAngles

				var_138_15.z = 0
				var_138_15.x = 0
				var_138_9.localEulerAngles = var_138_15
			end

			if arg_135_1.time_ >= var_138_10 + var_138_11 and arg_135_1.time_ < var_138_10 + var_138_11 + arg_138_0 then
				var_138_9.localPosition = Vector3.New(0, 100, 0)

				local var_138_16 = manager.ui.mainCamera.transform.position - var_138_9.position

				var_138_9.forward = Vector3.New(var_138_16.x, var_138_16.y, var_138_16.z)

				local var_138_17 = var_138_9.localEulerAngles

				var_138_17.z = 0
				var_138_17.x = 0
				var_138_9.localEulerAngles = var_138_17
			end

			local var_138_18 = arg_135_1.actors_["4014_tpose"].transform
			local var_138_19 = 0

			if var_138_19 < arg_135_1.time_ and arg_135_1.time_ <= var_138_19 + arg_138_0 then
				arg_135_1.var_.moveOldPos4014_tpose = var_138_18.localPosition

				local var_138_20 = GameObjectTools.GetOrAddComponent(var_138_18.gameObject, typeof(DynamicBoneHelper))

				if var_138_20 then
					var_138_20:EnableDynamicBone(false)
				end
			end

			local var_138_21 = 0.001

			if var_138_19 <= arg_135_1.time_ and arg_135_1.time_ < var_138_19 + var_138_21 then
				local var_138_22 = (arg_135_1.time_ - var_138_19) / var_138_21
				local var_138_23 = Vector3.New(0, -1.95, -4.2)

				var_138_18.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPos4014_tpose, var_138_23, var_138_22)

				local var_138_24 = manager.ui.mainCamera.transform.position - var_138_18.position

				var_138_18.forward = Vector3.New(var_138_24.x, var_138_24.y, var_138_24.z)

				local var_138_25 = var_138_18.localEulerAngles

				var_138_25.z = 0
				var_138_25.x = 0
				var_138_18.localEulerAngles = var_138_25
			end

			if arg_135_1.time_ >= var_138_19 + var_138_21 and arg_135_1.time_ < var_138_19 + var_138_21 + arg_138_0 then
				var_138_18.localPosition = Vector3.New(0, -1.95, -4.2)

				local var_138_26 = manager.ui.mainCamera.transform.position - var_138_18.position

				var_138_18.forward = Vector3.New(var_138_26.x, var_138_26.y, var_138_26.z)

				local var_138_27 = var_138_18.localEulerAngles

				var_138_27.z = 0
				var_138_27.x = 0
				var_138_18.localEulerAngles = var_138_27

				local var_138_28 = GameObjectTools.GetOrAddComponent(var_138_18.gameObject, typeof(DynamicBoneHelper))

				if var_138_28 then
					var_138_28:EnableDynamicBone(true)
				end
			end

			local var_138_29 = arg_135_1.actors_["4014_tpose"]
			local var_138_30 = 0

			if var_138_30 < arg_135_1.time_ and arg_135_1.time_ <= var_138_30 + arg_138_0 and not isNil(var_138_29) and arg_135_1.var_.characterEffect4014_tpose == nil then
				arg_135_1.var_.characterEffect4014_tpose = var_138_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_31 = 0.2

			if var_138_30 <= arg_135_1.time_ and arg_135_1.time_ < var_138_30 + var_138_31 and not isNil(var_138_29) then
				local var_138_32 = (arg_135_1.time_ - var_138_30) / var_138_31

				if arg_135_1.var_.characterEffect4014_tpose and not isNil(var_138_29) then
					arg_135_1.var_.characterEffect4014_tpose.fillFlat = false
				end
			end

			if arg_135_1.time_ >= var_138_30 + var_138_31 and arg_135_1.time_ < var_138_30 + var_138_31 + arg_138_0 and not isNil(var_138_29) and arg_135_1.var_.characterEffect4014_tpose then
				arg_135_1.var_.characterEffect4014_tpose.fillFlat = false
			end

			local var_138_33 = 0

			if var_138_33 < arg_135_1.time_ and arg_135_1.time_ <= var_138_33 + arg_138_0 then
				arg_135_1:PlayTimeline("4014_tpose", "StoryTimeline/CharAction/story4014/story4014action/4014action1_1")
			end

			local var_138_34 = 0
			local var_138_35 = 0.4

			if var_138_34 < arg_135_1.time_ and arg_135_1.time_ <= var_138_34 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				local var_138_36 = arg_135_1:FormatText(StoryNameCfg[87].name)

				arg_135_1.leftNameTxt_.text = var_138_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_37 = arg_135_1:GetWordFromCfg(109081032)
				local var_138_38 = arg_135_1:FormatText(var_138_37.content)

				arg_135_1.text_.text = var_138_38

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_39 = 16
				local var_138_40 = utf8.len(var_138_38)
				local var_138_41 = var_138_39 <= 0 and var_138_35 or var_138_35 * (var_138_40 / var_138_39)

				if var_138_41 > 0 and var_138_35 < var_138_41 then
					arg_135_1.talkMaxDuration = var_138_41

					if var_138_41 + var_138_34 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_41 + var_138_34
					end
				end

				arg_135_1.text_.text = var_138_38
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109081", "109081032", "story_v_out_109081.awb") ~= 0 then
					local var_138_42 = manager.audio:GetVoiceLength("story_v_out_109081", "109081032", "story_v_out_109081.awb") / 1000

					if var_138_42 + var_138_34 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_42 + var_138_34
					end

					if var_138_37.prefab_name ~= "" and arg_135_1.actors_[var_138_37.prefab_name] ~= nil then
						local var_138_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_37.prefab_name].transform, "story_v_out_109081", "109081032", "story_v_out_109081.awb")

						arg_135_1:RecordAudio("109081032", var_138_43)
						arg_135_1:RecordAudio("109081032", var_138_43)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_109081", "109081032", "story_v_out_109081.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_109081", "109081032", "story_v_out_109081.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_44 = math.max(var_138_35, arg_135_1.talkMaxDuration)

			if var_138_34 <= arg_135_1.time_ and arg_135_1.time_ < var_138_34 + var_138_44 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_34) / var_138_44

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_34 + var_138_44 and arg_135_1.time_ < var_138_34 + var_138_44 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {
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
				actorName = "4014_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_135_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/C07_1",
		"TextureConfig/Background/S0905"
	},
	voices = {
		"story_v_out_109081.awb"
	}
}
