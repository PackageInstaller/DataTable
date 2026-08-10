return {
	Play101061001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 101061001
		arg_1_1.duration_ = 4.7

		local var_1_0 = {
			ja = 4.3,
			ko = 4.7,
			zh = 4.3,
			en = 4.166
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
				arg_1_0:Play101061002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = 0
			local var_4_1 = 1

			if var_4_0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_0 + arg_4_0 then
				local var_4_2 = "play"
				local var_4_3 = "music"

				arg_1_1:AudioAction(var_4_2, var_4_3, "bgm_story_v1_battleground_2", "bgm_story_v1_battleground_2", "bgm_story_v1_battleground_2")

				local var_4_4 = ""
				local var_4_5 = manager.audio:GetAudioName("bgm_story_v1_battleground_2", "bgm_story_v1_battleground_2")

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

			local var_4_6 = 0
			local var_4_7 = 1

			if var_4_6 < arg_1_1.time_ and arg_1_1.time_ <= var_4_6 + arg_4_0 then
				local var_4_8 = "play"
				local var_4_9 = "effect"

				arg_1_1:AudioAction(var_4_8, var_4_9, "se_story_v1_environment_factory", "se_story_v1_environment_factory", "se_story_v1_environment_factory")
			end

			local var_4_10 = "2020_tpose"

			if arg_1_1.actors_[var_4_10] == nil then
				local var_4_11 = Asset.Load("Char/" .. "2020_tpose")

				if not isNil(var_4_11) then
					local var_4_12 = Object.Instantiate(Asset.Load("Char/" .. "2020_tpose"), arg_1_1.stage_.transform)

					var_4_12.name = var_4_10
					var_4_12.transform.localPosition = Vector3.New(0, 100, 0)
					arg_1_1.actors_[var_4_10] = var_4_12

					local var_4_13 = var_4_12:GetComponentInChildren(typeof(CharacterEffect))

					var_4_13.enabled = true

					local var_4_14 = GameObjectTools.GetOrAddComponent(var_4_12, typeof(DynamicBoneHelper))

					if var_4_14 then
						var_4_14:EnableDynamicBone(false)
					end

					arg_1_1:ShowWeapon(var_4_13.transform, false)

					arg_1_1.var_[var_4_10 .. "Animator"] = var_4_13.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_1_1.var_[var_4_10 .. "Animator"].applyRootMotion = true
					arg_1_1.var_[var_4_10 .. "LipSync"] = var_4_13.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_4_15 = arg_1_1.actors_["2020_tpose"]
			local var_4_16 = 2

			if var_4_16 < arg_1_1.time_ and arg_1_1.time_ <= var_4_16 + arg_4_0 and not isNil(var_4_15) and arg_1_1.var_.characterEffect2020_tpose == nil then
				arg_1_1.var_.characterEffect2020_tpose = var_4_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_17 = 0.1

			if var_4_16 <= arg_1_1.time_ and arg_1_1.time_ < var_4_16 + var_4_17 and not isNil(var_4_15) then
				local var_4_18 = (arg_1_1.time_ - var_4_16) / var_4_17

				if arg_1_1.var_.characterEffect2020_tpose and not isNil(var_4_15) then
					arg_1_1.var_.characterEffect2020_tpose.fillFlat = false
				end
			end

			if arg_1_1.time_ >= var_4_16 + var_4_17 and arg_1_1.time_ < var_4_16 + var_4_17 + arg_4_0 and not isNil(var_4_15) and arg_1_1.var_.characterEffect2020_tpose then
				arg_1_1.var_.characterEffect2020_tpose.fillFlat = false
			end

			local var_4_19 = "B08b"

			if arg_1_1.bgs_[var_4_19] == nil then
				local var_4_20 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_20:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_19)
				var_4_20.name = var_4_19
				var_4_20.transform.parent = arg_1_1.stage_.transform
				var_4_20.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_19] = var_4_20
			end

			local var_4_21 = arg_1_1.bgs_.B08b
			local var_4_22 = 0

			if var_4_22 < arg_1_1.time_ and arg_1_1.time_ <= var_4_22 + arg_4_0 then
				local var_4_23 = var_4_21:GetComponent("SpriteRenderer")

				if var_4_23 then
					arg_1_1.var_.alphaOldValueB08b = var_4_23.color.a
					arg_1_1.var_.alphaMatValueB08b = var_4_23
				end

				arg_1_1.var_.alphaOldValueB08b = 0
			end

			local var_4_24 = 1.5

			if var_4_22 <= arg_1_1.time_ and arg_1_1.time_ < var_4_22 + var_4_24 then
				local var_4_25 = (arg_1_1.time_ - var_4_22) / var_4_24
				local var_4_26 = Mathf.Lerp(arg_1_1.var_.alphaOldValueB08b, 1, var_4_25)

				if arg_1_1.var_.alphaMatValueB08b then
					local var_4_27 = arg_1_1.var_.alphaMatValueB08b.color

					var_4_27.a = var_4_26
					arg_1_1.var_.alphaMatValueB08b.color = var_4_27
				end
			end

			if arg_1_1.time_ >= var_4_22 + var_4_24 and arg_1_1.time_ < var_4_22 + var_4_24 + arg_4_0 and arg_1_1.var_.alphaMatValueB08b then
				local var_4_28 = arg_1_1.var_.alphaMatValueB08b
				local var_4_29 = var_4_28.color

				var_4_29.a = 1
				var_4_28.color = var_4_29
			end

			local var_4_30 = 0

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				local var_4_31 = manager.ui.mainCamera.transform.localPosition
				local var_4_32 = Vector3.New(0, 0, 10) + Vector3.New(var_4_31.x, var_4_31.y, 0)
				local var_4_33 = arg_1_1.bgs_.B08b

				var_4_33.transform.localPosition = var_4_32
				var_4_33.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_34 = var_4_33:GetComponent("SpriteRenderer")

				if var_4_34 and var_4_34.sprite then
					local var_4_35 = (var_4_33.transform.localPosition - var_4_31).z
					local var_4_36 = manager.ui.mainCameraCom_
					local var_4_37 = 2 * var_4_35 * Mathf.Tan(var_4_36.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_4_38 = var_4_37 * var_4_36.aspect
					local var_4_39 = var_4_34.sprite.bounds.size.x
					local var_4_40 = var_4_34.sprite.bounds.size.y
					local var_4_41 = var_4_38 / var_4_39
					local var_4_42 = var_4_37 / var_4_40
					local var_4_43 = var_4_42 < var_4_41 and var_4_41 or var_4_42

					var_4_33.transform.localScale = Vector3.New(var_4_43, var_4_43, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "B08b" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_44 = arg_1_1.actors_["2020_tpose"].transform
			local var_4_45 = 1.79999995231628

			if var_4_45 < arg_1_1.time_ and arg_1_1.time_ <= var_4_45 + arg_4_0 then
				arg_1_1.var_.moveOldPos2020_tpose = var_4_44.localPosition

				local var_4_46 = GameObjectTools.GetOrAddComponent(var_4_44.gameObject, typeof(DynamicBoneHelper))

				if var_4_46 then
					var_4_46:EnableDynamicBone(false)
				end
			end

			local var_4_47 = 0.001

			if var_4_45 <= arg_1_1.time_ and arg_1_1.time_ < var_4_45 + var_4_47 then
				local var_4_48 = (arg_1_1.time_ - var_4_45) / var_4_47
				local var_4_49 = Vector3.New(-0.7, -1.2, -4.1)

				var_4_44.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos2020_tpose, var_4_49, var_4_48)

				local var_4_50 = manager.ui.mainCamera.transform.position - var_4_44.position

				var_4_44.forward = Vector3.New(var_4_50.x, var_4_50.y, var_4_50.z)

				local var_4_51 = var_4_44.localEulerAngles

				var_4_51.z = 0
				var_4_51.x = 0
				var_4_44.localEulerAngles = var_4_51
			end

			if arg_1_1.time_ >= var_4_45 + var_4_47 and arg_1_1.time_ < var_4_45 + var_4_47 + arg_4_0 then
				var_4_44.localPosition = Vector3.New(-0.7, -1.2, -4.1)

				local var_4_52 = manager.ui.mainCamera.transform.position - var_4_44.position

				var_4_44.forward = Vector3.New(var_4_52.x, var_4_52.y, var_4_52.z)

				local var_4_53 = var_4_44.localEulerAngles

				var_4_53.z = 0
				var_4_53.x = 0
				var_4_44.localEulerAngles = var_4_53

				local var_4_54 = GameObjectTools.GetOrAddComponent(var_4_44.gameObject, typeof(DynamicBoneHelper))

				if var_4_54 then
					var_4_54:EnableDynamicBone(true)
				end
			end

			local var_4_55 = 0

			if var_4_55 < arg_1_1.time_ and arg_1_1.time_ <= var_4_55 + arg_4_0 then
				arg_1_1:PlayTimeline("2020_tpose", "StoryTimeline/CharAction/story2020/story2020action/2020action1_1")
			end

			local var_4_56 = 0

			if var_4_56 < arg_1_1.time_ and arg_1_1.time_ <= var_4_56 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_57 = 2

			if arg_1_1.time_ >= var_4_56 + var_4_57 and arg_1_1.time_ < var_4_56 + var_4_57 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_58 = 2
			local var_4_59 = 0.3

			if var_4_58 < arg_1_1.time_ and arg_1_1.time_ <= var_4_58 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_60 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_60:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_60:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_60:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_61 = arg_1_1:FormatText(StoryNameCfg[19].name)

				arg_1_1.leftNameTxt_.text = var_4_61

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_62 = arg_1_1:GetWordFromCfg(101061001)
				local var_4_63 = arg_1_1:FormatText(var_4_62.content)

				arg_1_1.text_.text = var_4_63

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_64 = 12
				local var_4_65 = utf8.len(var_4_63)
				local var_4_66 = var_4_64 <= 0 and var_4_59 or var_4_59 * (var_4_65 / var_4_64)

				if var_4_66 > 0 and var_4_59 < var_4_66 then
					arg_1_1.talkMaxDuration = var_4_66
					var_4_58 = var_4_58 + 0.3

					if var_4_66 + var_4_58 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_66 + var_4_58
					end
				end

				arg_1_1.text_.text = var_4_63
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101061", "101061001", "story_v_out_101061.awb") ~= 0 then
					local var_4_67 = manager.audio:GetVoiceLength("story_v_out_101061", "101061001", "story_v_out_101061.awb") / 1000

					if var_4_67 + var_4_58 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_67 + var_4_58
					end

					if var_4_62.prefab_name ~= "" and arg_1_1.actors_[var_4_62.prefab_name] ~= nil then
						local var_4_68 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_62.prefab_name].transform, "story_v_out_101061", "101061001", "story_v_out_101061.awb")

						arg_1_1:RecordAudio("101061001", var_4_68)
						arg_1_1:RecordAudio("101061001", var_4_68)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_101061", "101061001", "story_v_out_101061.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_101061", "101061001", "story_v_out_101061.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_69 = var_4_58 + 0.3
			local var_4_70 = math.max(var_4_59, arg_1_1.talkMaxDuration)

			if var_4_69 <= arg_1_1.time_ and arg_1_1.time_ < var_4_69 + var_4_70 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_69) / var_4_70

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_69 + var_4_70 and arg_1_1.time_ < var_4_69 + var_4_70 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2020_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 1.79999995231628,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play101061002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 101061002
		arg_8_1.duration_ = 2

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play101061003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = "2030_tpose"

			if arg_8_1.actors_[var_11_0] == nil then
				local var_11_1 = Asset.Load("Char/" .. "2030_tpose")

				if not isNil(var_11_1) then
					local var_11_2 = Object.Instantiate(Asset.Load("Char/" .. "2030_tpose"), arg_8_1.stage_.transform)

					var_11_2.name = var_11_0
					var_11_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_8_1.actors_[var_11_0] = var_11_2

					local var_11_3 = var_11_2:GetComponentInChildren(typeof(CharacterEffect))

					var_11_3.enabled = true

					local var_11_4 = GameObjectTools.GetOrAddComponent(var_11_2, typeof(DynamicBoneHelper))

					if var_11_4 then
						var_11_4:EnableDynamicBone(false)
					end

					arg_8_1:ShowWeapon(var_11_3.transform, false)

					arg_8_1.var_[var_11_0 .. "Animator"] = var_11_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_8_1.var_[var_11_0 .. "Animator"].applyRootMotion = true
					arg_8_1.var_[var_11_0 .. "LipSync"] = var_11_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_11_5 = arg_8_1.actors_["2030_tpose"]
			local var_11_6 = 0

			if var_11_6 < arg_8_1.time_ and arg_8_1.time_ <= var_11_6 + arg_11_0 and not isNil(var_11_5) and arg_8_1.var_.characterEffect2030_tpose == nil then
				arg_8_1.var_.characterEffect2030_tpose = var_11_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_7 = 0.1

			if var_11_6 <= arg_8_1.time_ and arg_8_1.time_ < var_11_6 + var_11_7 and not isNil(var_11_5) then
				local var_11_8 = (arg_8_1.time_ - var_11_6) / var_11_7

				if arg_8_1.var_.characterEffect2030_tpose and not isNil(var_11_5) then
					arg_8_1.var_.characterEffect2030_tpose.fillFlat = false
				end
			end

			if arg_8_1.time_ >= var_11_6 + var_11_7 and arg_8_1.time_ < var_11_6 + var_11_7 + arg_11_0 and not isNil(var_11_5) and arg_8_1.var_.characterEffect2030_tpose then
				arg_8_1.var_.characterEffect2030_tpose.fillFlat = false
			end

			local var_11_9 = arg_8_1.actors_["2020_tpose"]
			local var_11_10 = 0

			if var_11_10 < arg_8_1.time_ and arg_8_1.time_ <= var_11_10 + arg_11_0 and not isNil(var_11_9) and arg_8_1.var_.characterEffect2020_tpose == nil then
				arg_8_1.var_.characterEffect2020_tpose = var_11_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_11 = 0.1

			if var_11_10 <= arg_8_1.time_ and arg_8_1.time_ < var_11_10 + var_11_11 and not isNil(var_11_9) then
				local var_11_12 = (arg_8_1.time_ - var_11_10) / var_11_11

				if arg_8_1.var_.characterEffect2020_tpose and not isNil(var_11_9) then
					local var_11_13 = Mathf.Lerp(0, 0.5, var_11_12)

					arg_8_1.var_.characterEffect2020_tpose.fillFlat = true
					arg_8_1.var_.characterEffect2020_tpose.fillRatio = var_11_13
				end
			end

			if arg_8_1.time_ >= var_11_10 + var_11_11 and arg_8_1.time_ < var_11_10 + var_11_11 + arg_11_0 and not isNil(var_11_9) and arg_8_1.var_.characterEffect2020_tpose then
				local var_11_14 = 0.5

				arg_8_1.var_.characterEffect2020_tpose.fillFlat = true
				arg_8_1.var_.characterEffect2020_tpose.fillRatio = var_11_14
			end

			local var_11_15 = arg_8_1.actors_["2030_tpose"].transform
			local var_11_16 = 0

			if var_11_16 < arg_8_1.time_ and arg_8_1.time_ <= var_11_16 + arg_11_0 then
				arg_8_1.var_.moveOldPos2030_tpose = var_11_15.localPosition

				local var_11_17 = GameObjectTools.GetOrAddComponent(var_11_15.gameObject, typeof(DynamicBoneHelper))

				if var_11_17 then
					var_11_17:EnableDynamicBone(false)
				end
			end

			local var_11_18 = 0.001

			if var_11_16 <= arg_8_1.time_ and arg_8_1.time_ < var_11_16 + var_11_18 then
				local var_11_19 = (arg_8_1.time_ - var_11_16) / var_11_18
				local var_11_20 = Vector3.New(0.7, -1.2, -4.2)

				var_11_15.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos2030_tpose, var_11_20, var_11_19)

				local var_11_21 = manager.ui.mainCamera.transform.position - var_11_15.position

				var_11_15.forward = Vector3.New(var_11_21.x, var_11_21.y, var_11_21.z)

				local var_11_22 = var_11_15.localEulerAngles

				var_11_22.z = 0
				var_11_22.x = 0
				var_11_15.localEulerAngles = var_11_22
			end

			if arg_8_1.time_ >= var_11_16 + var_11_18 and arg_8_1.time_ < var_11_16 + var_11_18 + arg_11_0 then
				var_11_15.localPosition = Vector3.New(0.7, -1.2, -4.2)

				local var_11_23 = manager.ui.mainCamera.transform.position - var_11_15.position

				var_11_15.forward = Vector3.New(var_11_23.x, var_11_23.y, var_11_23.z)

				local var_11_24 = var_11_15.localEulerAngles

				var_11_24.z = 0
				var_11_24.x = 0
				var_11_15.localEulerAngles = var_11_24

				local var_11_25 = GameObjectTools.GetOrAddComponent(var_11_15.gameObject, typeof(DynamicBoneHelper))

				if var_11_25 then
					var_11_25:EnableDynamicBone(true)
				end
			end

			local var_11_26 = 0

			if var_11_26 < arg_8_1.time_ and arg_8_1.time_ <= var_11_26 + arg_11_0 then
				arg_8_1:PlayTimeline("2030_tpose", "StoryTimeline/CharAction/story2030/story2030action/2030action1_1")
			end

			local var_11_27 = 0
			local var_11_28 = 0.1

			if var_11_27 < arg_8_1.time_ and arg_8_1.time_ <= var_11_27 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				local var_11_29 = arg_8_1:FormatText(StoryNameCfg[33].name)

				arg_8_1.leftNameTxt_.text = var_11_29

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_30 = arg_8_1:GetWordFromCfg(101061002)
				local var_11_31 = arg_8_1:FormatText(var_11_30.content)

				arg_8_1.text_.text = var_11_31

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_32 = 4
				local var_11_33 = utf8.len(var_11_31)
				local var_11_34 = var_11_32 <= 0 and var_11_28 or var_11_28 * (var_11_33 / var_11_32)

				if var_11_34 > 0 and var_11_28 < var_11_34 then
					arg_8_1.talkMaxDuration = var_11_34

					if var_11_34 + var_11_27 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_34 + var_11_27
					end
				end

				arg_8_1.text_.text = var_11_31
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101061", "101061002", "story_v_out_101061.awb") ~= 0 then
					local var_11_35 = manager.audio:GetVoiceLength("story_v_out_101061", "101061002", "story_v_out_101061.awb") / 1000

					if var_11_35 + var_11_27 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_35 + var_11_27
					end

					if var_11_30.prefab_name ~= "" and arg_8_1.actors_[var_11_30.prefab_name] ~= nil then
						local var_11_36 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_30.prefab_name].transform, "story_v_out_101061", "101061002", "story_v_out_101061.awb")

						arg_8_1:RecordAudio("101061002", var_11_36)
						arg_8_1:RecordAudio("101061002", var_11_36)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_101061", "101061002", "story_v_out_101061.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_101061", "101061002", "story_v_out_101061.awb")
				end

				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_37 = math.max(var_11_28, arg_8_1.talkMaxDuration)

			if var_11_27 <= arg_8_1.time_ and arg_8_1.time_ < var_11_27 + var_11_37 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_27) / var_11_37

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_27 + var_11_37 and arg_8_1.time_ < var_11_27 + var_11_37 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2030_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_8_1:InitPlayNodeList()
	end,
	Play101061003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 101061003
		arg_12_1.duration_ = 3.1

		local var_12_0 = {
			ja = 1.999999999999,
			ko = 1.999999999999,
			zh = 3.1,
			en = 1.999999999999
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
				arg_12_0:Play101061004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = "3008ui_story"

			if arg_12_1.actors_[var_15_0] == nil then
				local var_15_1 = Asset.Load("Char/" .. "3008ui_story")

				if not isNil(var_15_1) then
					local var_15_2 = Object.Instantiate(Asset.Load("Char/" .. "3008ui_story"), arg_12_1.stage_.transform)

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

			local var_15_5 = arg_12_1.actors_["3008ui_story"]
			local var_15_6 = 0

			if var_15_6 < arg_12_1.time_ and arg_12_1.time_ <= var_15_6 + arg_15_0 and not isNil(var_15_5) and arg_12_1.var_.characterEffect3008ui_story == nil then
				arg_12_1.var_.characterEffect3008ui_story = var_15_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_7 = 0.1

			if var_15_6 <= arg_12_1.time_ and arg_12_1.time_ < var_15_6 + var_15_7 and not isNil(var_15_5) then
				local var_15_8 = (arg_12_1.time_ - var_15_6) / var_15_7

				if arg_12_1.var_.characterEffect3008ui_story and not isNil(var_15_5) then
					arg_12_1.var_.characterEffect3008ui_story.fillFlat = false
				end
			end

			if arg_12_1.time_ >= var_15_6 + var_15_7 and arg_12_1.time_ < var_15_6 + var_15_7 + arg_15_0 and not isNil(var_15_5) and arg_12_1.var_.characterEffect3008ui_story then
				arg_12_1.var_.characterEffect3008ui_story.fillFlat = false
			end

			local var_15_9 = arg_12_1.actors_["2030_tpose"]
			local var_15_10 = 0

			if var_15_10 < arg_12_1.time_ and arg_12_1.time_ <= var_15_10 + arg_15_0 and not isNil(var_15_9) and arg_12_1.var_.characterEffect2030_tpose == nil then
				arg_12_1.var_.characterEffect2030_tpose = var_15_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_11 = 0.1

			if var_15_10 <= arg_12_1.time_ and arg_12_1.time_ < var_15_10 + var_15_11 and not isNil(var_15_9) then
				local var_15_12 = (arg_12_1.time_ - var_15_10) / var_15_11

				if arg_12_1.var_.characterEffect2030_tpose and not isNil(var_15_9) then
					local var_15_13 = Mathf.Lerp(0, 0.5, var_15_12)

					arg_12_1.var_.characterEffect2030_tpose.fillFlat = true
					arg_12_1.var_.characterEffect2030_tpose.fillRatio = var_15_13
				end
			end

			if arg_12_1.time_ >= var_15_10 + var_15_11 and arg_12_1.time_ < var_15_10 + var_15_11 + arg_15_0 and not isNil(var_15_9) and arg_12_1.var_.characterEffect2030_tpose then
				local var_15_14 = 0.5

				arg_12_1.var_.characterEffect2030_tpose.fillFlat = true
				arg_12_1.var_.characterEffect2030_tpose.fillRatio = var_15_14
			end

			local var_15_15 = arg_12_1.actors_["2020_tpose"].transform
			local var_15_16 = 0

			if var_15_16 < arg_12_1.time_ and arg_12_1.time_ <= var_15_16 + arg_15_0 then
				arg_12_1.var_.moveOldPos2020_tpose = var_15_15.localPosition

				local var_15_17 = GameObjectTools.GetOrAddComponent(var_15_15.gameObject, typeof(DynamicBoneHelper))

				if var_15_17 then
					var_15_17:EnableDynamicBone(false)
				end
			end

			local var_15_18 = 0.001

			if var_15_16 <= arg_12_1.time_ and arg_12_1.time_ < var_15_16 + var_15_18 then
				local var_15_19 = (arg_12_1.time_ - var_15_16) / var_15_18
				local var_15_20 = Vector3.New(0, 100, 0)

				var_15_15.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos2020_tpose, var_15_20, var_15_19)

				local var_15_21 = manager.ui.mainCamera.transform.position - var_15_15.position

				var_15_15.forward = Vector3.New(var_15_21.x, var_15_21.y, var_15_21.z)

				local var_15_22 = var_15_15.localEulerAngles

				var_15_22.z = 0
				var_15_22.x = 0
				var_15_15.localEulerAngles = var_15_22
			end

			if arg_12_1.time_ >= var_15_16 + var_15_18 and arg_12_1.time_ < var_15_16 + var_15_18 + arg_15_0 then
				var_15_15.localPosition = Vector3.New(0, 100, 0)

				local var_15_23 = manager.ui.mainCamera.transform.position - var_15_15.position

				var_15_15.forward = Vector3.New(var_15_23.x, var_15_23.y, var_15_23.z)

				local var_15_24 = var_15_15.localEulerAngles

				var_15_24.z = 0
				var_15_24.x = 0
				var_15_15.localEulerAngles = var_15_24

				local var_15_25 = GameObjectTools.GetOrAddComponent(var_15_15.gameObject, typeof(DynamicBoneHelper))

				if var_15_25 then
					var_15_25:EnableDynamicBone(true)
				end
			end

			local var_15_26 = arg_12_1.actors_["2030_tpose"].transform
			local var_15_27 = 0

			if var_15_27 < arg_12_1.time_ and arg_12_1.time_ <= var_15_27 + arg_15_0 then
				arg_12_1.var_.moveOldPos2030_tpose = var_15_26.localPosition

				local var_15_28 = GameObjectTools.GetOrAddComponent(var_15_26.gameObject, typeof(DynamicBoneHelper))

				if var_15_28 then
					var_15_28:EnableDynamicBone(false)
				end
			end

			local var_15_29 = 0.001

			if var_15_27 <= arg_12_1.time_ and arg_12_1.time_ < var_15_27 + var_15_29 then
				local var_15_30 = (arg_12_1.time_ - var_15_27) / var_15_29
				local var_15_31 = Vector3.New(0, 100, 0)

				var_15_26.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos2030_tpose, var_15_31, var_15_30)

				local var_15_32 = manager.ui.mainCamera.transform.position - var_15_26.position

				var_15_26.forward = Vector3.New(var_15_32.x, var_15_32.y, var_15_32.z)

				local var_15_33 = var_15_26.localEulerAngles

				var_15_33.z = 0
				var_15_33.x = 0
				var_15_26.localEulerAngles = var_15_33
			end

			if arg_12_1.time_ >= var_15_27 + var_15_29 and arg_12_1.time_ < var_15_27 + var_15_29 + arg_15_0 then
				var_15_26.localPosition = Vector3.New(0, 100, 0)

				local var_15_34 = manager.ui.mainCamera.transform.position - var_15_26.position

				var_15_26.forward = Vector3.New(var_15_34.x, var_15_34.y, var_15_34.z)

				local var_15_35 = var_15_26.localEulerAngles

				var_15_35.z = 0
				var_15_35.x = 0
				var_15_26.localEulerAngles = var_15_35

				local var_15_36 = GameObjectTools.GetOrAddComponent(var_15_26.gameObject, typeof(DynamicBoneHelper))

				if var_15_36 then
					var_15_36:EnableDynamicBone(true)
				end
			end

			local var_15_37 = arg_12_1.actors_["3008ui_story"].transform
			local var_15_38 = 0

			if var_15_38 < arg_12_1.time_ and arg_12_1.time_ <= var_15_38 + arg_15_0 then
				arg_12_1.var_.moveOldPos3008ui_story = var_15_37.localPosition
			end

			local var_15_39 = 0.001

			if var_15_38 <= arg_12_1.time_ and arg_12_1.time_ < var_15_38 + var_15_39 then
				local var_15_40 = (arg_12_1.time_ - var_15_38) / var_15_39
				local var_15_41 = Vector3.New(0, -1.51, -4.3)

				var_15_37.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos3008ui_story, var_15_41, var_15_40)

				local var_15_42 = manager.ui.mainCamera.transform.position - var_15_37.position

				var_15_37.forward = Vector3.New(var_15_42.x, var_15_42.y, var_15_42.z)

				local var_15_43 = var_15_37.localEulerAngles

				var_15_43.z = 0
				var_15_43.x = 0
				var_15_37.localEulerAngles = var_15_43
			end

			if arg_12_1.time_ >= var_15_38 + var_15_39 and arg_12_1.time_ < var_15_38 + var_15_39 + arg_15_0 then
				var_15_37.localPosition = Vector3.New(0, -1.51, -4.3)

				local var_15_44 = manager.ui.mainCamera.transform.position - var_15_37.position

				var_15_37.forward = Vector3.New(var_15_44.x, var_15_44.y, var_15_44.z)

				local var_15_45 = var_15_37.localEulerAngles

				var_15_45.z = 0
				var_15_45.x = 0
				var_15_37.localEulerAngles = var_15_45
			end

			local var_15_46 = 0

			if var_15_46 < arg_12_1.time_ and arg_12_1.time_ <= var_15_46 + arg_15_0 then
				arg_12_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/story3008/story3008action/3008action1_1")
			end

			local var_15_47 = 0

			if var_15_47 < arg_12_1.time_ and arg_12_1.time_ <= var_15_47 + arg_15_0 then
				arg_12_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_15_48 = 0
			local var_15_49 = 0.075

			if var_15_48 < arg_12_1.time_ and arg_12_1.time_ <= var_15_48 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				local var_15_50 = arg_12_1:FormatText(StoryNameCfg[20].name)

				arg_12_1.leftNameTxt_.text = var_15_50

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_51 = arg_12_1:GetWordFromCfg(101061003)
				local var_15_52 = arg_12_1:FormatText(var_15_51.content)

				arg_12_1.text_.text = var_15_52

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_53 = 3
				local var_15_54 = utf8.len(var_15_52)
				local var_15_55 = var_15_53 <= 0 and var_15_49 or var_15_49 * (var_15_54 / var_15_53)

				if var_15_55 > 0 and var_15_49 < var_15_55 then
					arg_12_1.talkMaxDuration = var_15_55

					if var_15_55 + var_15_48 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_55 + var_15_48
					end
				end

				arg_12_1.text_.text = var_15_52
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101061", "101061003", "story_v_out_101061.awb") ~= 0 then
					local var_15_56 = manager.audio:GetVoiceLength("story_v_out_101061", "101061003", "story_v_out_101061.awb") / 1000

					if var_15_56 + var_15_48 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_56 + var_15_48
					end

					if var_15_51.prefab_name ~= "" and arg_12_1.actors_[var_15_51.prefab_name] ~= nil then
						local var_15_57 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_51.prefab_name].transform, "story_v_out_101061", "101061003", "story_v_out_101061.awb")

						arg_12_1:RecordAudio("101061003", var_15_57)
						arg_12_1:RecordAudio("101061003", var_15_57)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_101061", "101061003", "story_v_out_101061.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_101061", "101061003", "story_v_out_101061.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_58 = math.max(var_15_49, arg_12_1.talkMaxDuration)

			if var_15_48 <= arg_12_1.time_ and arg_12_1.time_ < var_15_48 + var_15_58 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_48) / var_15_58

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_48 + var_15_58 and arg_12_1.time_ < var_15_48 + var_15_58 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2020_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "2030_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "3008ui_story",
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
	Play101061004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 101061004
		arg_16_1.duration_ = 5

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play101061005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = arg_16_1.actors_["3008ui_story"]
			local var_19_1 = 0

			if var_19_1 < arg_16_1.time_ and arg_16_1.time_ <= var_19_1 + arg_19_0 and not isNil(var_19_0) and arg_16_1.var_.characterEffect3008ui_story == nil then
				arg_16_1.var_.characterEffect3008ui_story = var_19_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_2 = 0.1

			if var_19_1 <= arg_16_1.time_ and arg_16_1.time_ < var_19_1 + var_19_2 and not isNil(var_19_0) then
				local var_19_3 = (arg_16_1.time_ - var_19_1) / var_19_2

				if arg_16_1.var_.characterEffect3008ui_story and not isNil(var_19_0) then
					local var_19_4 = Mathf.Lerp(0, 0.5, var_19_3)

					arg_16_1.var_.characterEffect3008ui_story.fillFlat = true
					arg_16_1.var_.characterEffect3008ui_story.fillRatio = var_19_4
				end
			end

			if arg_16_1.time_ >= var_19_1 + var_19_2 and arg_16_1.time_ < var_19_1 + var_19_2 + arg_19_0 and not isNil(var_19_0) and arg_16_1.var_.characterEffect3008ui_story then
				local var_19_5 = 0.5

				arg_16_1.var_.characterEffect3008ui_story.fillFlat = true
				arg_16_1.var_.characterEffect3008ui_story.fillRatio = var_19_5
			end

			local var_19_6 = arg_16_1.actors_["3008ui_story"].transform
			local var_19_7 = 0

			if var_19_7 < arg_16_1.time_ and arg_16_1.time_ <= var_19_7 + arg_19_0 then
				arg_16_1.var_.moveOldPos3008ui_story = var_19_6.localPosition
			end

			local var_19_8 = 0.001

			if var_19_7 <= arg_16_1.time_ and arg_16_1.time_ < var_19_7 + var_19_8 then
				local var_19_9 = (arg_16_1.time_ - var_19_7) / var_19_8
				local var_19_10 = Vector3.New(0, 100, 0)

				var_19_6.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos3008ui_story, var_19_10, var_19_9)

				local var_19_11 = manager.ui.mainCamera.transform.position - var_19_6.position

				var_19_6.forward = Vector3.New(var_19_11.x, var_19_11.y, var_19_11.z)

				local var_19_12 = var_19_6.localEulerAngles

				var_19_12.z = 0
				var_19_12.x = 0
				var_19_6.localEulerAngles = var_19_12
			end

			if arg_16_1.time_ >= var_19_7 + var_19_8 and arg_16_1.time_ < var_19_7 + var_19_8 + arg_19_0 then
				var_19_6.localPosition = Vector3.New(0, 100, 0)

				local var_19_13 = manager.ui.mainCamera.transform.position - var_19_6.position

				var_19_6.forward = Vector3.New(var_19_13.x, var_19_13.y, var_19_13.z)

				local var_19_14 = var_19_6.localEulerAngles

				var_19_14.z = 0
				var_19_14.x = 0
				var_19_6.localEulerAngles = var_19_14
			end

			local var_19_15 = 0
			local var_19_16 = 0.625

			if var_19_15 < arg_16_1.time_ and arg_16_1.time_ <= var_19_15 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, false)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_17 = arg_16_1:GetWordFromCfg(101061004)
				local var_19_18 = arg_16_1:FormatText(var_19_17.content)

				arg_16_1.text_.text = var_19_18

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_19 = 25
				local var_19_20 = utf8.len(var_19_18)
				local var_19_21 = var_19_19 <= 0 and var_19_16 or var_19_16 * (var_19_20 / var_19_19)

				if var_19_21 > 0 and var_19_16 < var_19_21 then
					arg_16_1.talkMaxDuration = var_19_21

					if var_19_21 + var_19_15 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_21 + var_19_15
					end
				end

				arg_16_1.text_.text = var_19_18
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)
				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_22 = math.max(var_19_16, arg_16_1.talkMaxDuration)

			if var_19_15 <= arg_16_1.time_ and arg_16_1.time_ < var_19_15 + var_19_22 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_15) / var_19_22

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_15 + var_19_22 and arg_16_1.time_ < var_19_15 + var_19_22 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3008ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_16_1:InitPlayNodeList()
	end,
	Play101061005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 101061005
		arg_20_1.duration_ = 7.17

		local var_20_0 = {
			ja = 7.166,
			ko = 5.633,
			zh = 6.7,
			en = 6.1
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
				arg_20_0:Play101061006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = arg_20_1.actors_["2020_tpose"]
			local var_23_1 = 0

			if var_23_1 < arg_20_1.time_ and arg_20_1.time_ <= var_23_1 + arg_23_0 and not isNil(var_23_0) and arg_20_1.var_.characterEffect2020_tpose == nil then
				arg_20_1.var_.characterEffect2020_tpose = var_23_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_2 = 0.1

			if var_23_1 <= arg_20_1.time_ and arg_20_1.time_ < var_23_1 + var_23_2 and not isNil(var_23_0) then
				local var_23_3 = (arg_20_1.time_ - var_23_1) / var_23_2

				if arg_20_1.var_.characterEffect2020_tpose and not isNil(var_23_0) then
					arg_20_1.var_.characterEffect2020_tpose.fillFlat = false
				end
			end

			if arg_20_1.time_ >= var_23_1 + var_23_2 and arg_20_1.time_ < var_23_1 + var_23_2 + arg_23_0 and not isNil(var_23_0) and arg_20_1.var_.characterEffect2020_tpose then
				arg_20_1.var_.characterEffect2020_tpose.fillFlat = false
			end

			local var_23_4 = arg_20_1.actors_["2020_tpose"].transform
			local var_23_5 = 0

			if var_23_5 < arg_20_1.time_ and arg_20_1.time_ <= var_23_5 + arg_23_0 then
				arg_20_1.var_.moveOldPos2020_tpose = var_23_4.localPosition

				local var_23_6 = GameObjectTools.GetOrAddComponent(var_23_4.gameObject, typeof(DynamicBoneHelper))

				if var_23_6 then
					var_23_6:EnableDynamicBone(false)
				end
			end

			local var_23_7 = 0.001

			if var_23_5 <= arg_20_1.time_ and arg_20_1.time_ < var_23_5 + var_23_7 then
				local var_23_8 = (arg_20_1.time_ - var_23_5) / var_23_7
				local var_23_9 = Vector3.New(-0.7, -1.2, -4.1)

				var_23_4.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos2020_tpose, var_23_9, var_23_8)

				local var_23_10 = manager.ui.mainCamera.transform.position - var_23_4.position

				var_23_4.forward = Vector3.New(var_23_10.x, var_23_10.y, var_23_10.z)

				local var_23_11 = var_23_4.localEulerAngles

				var_23_11.z = 0
				var_23_11.x = 0
				var_23_4.localEulerAngles = var_23_11
			end

			if arg_20_1.time_ >= var_23_5 + var_23_7 and arg_20_1.time_ < var_23_5 + var_23_7 + arg_23_0 then
				var_23_4.localPosition = Vector3.New(-0.7, -1.2, -4.1)

				local var_23_12 = manager.ui.mainCamera.transform.position - var_23_4.position

				var_23_4.forward = Vector3.New(var_23_12.x, var_23_12.y, var_23_12.z)

				local var_23_13 = var_23_4.localEulerAngles

				var_23_13.z = 0
				var_23_13.x = 0
				var_23_4.localEulerAngles = var_23_13

				local var_23_14 = GameObjectTools.GetOrAddComponent(var_23_4.gameObject, typeof(DynamicBoneHelper))

				if var_23_14 then
					var_23_14:EnableDynamicBone(true)
				end
			end

			local var_23_15 = 0

			if var_23_15 < arg_20_1.time_ and arg_20_1.time_ <= var_23_15 + arg_23_0 then
				arg_20_1:PlayTimeline("2020_tpose", "StoryTimeline/CharAction/story2020/story2020action/2020action1_1")
			end

			local var_23_16 = 0
			local var_23_17 = 0.775

			if var_23_16 < arg_20_1.time_ and arg_20_1.time_ <= var_23_16 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				local var_23_18 = arg_20_1:FormatText(StoryNameCfg[19].name)

				arg_20_1.leftNameTxt_.text = var_23_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_19 = arg_20_1:GetWordFromCfg(101061005)
				local var_23_20 = arg_20_1:FormatText(var_23_19.content)

				arg_20_1.text_.text = var_23_20

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_21 = 31
				local var_23_22 = utf8.len(var_23_20)
				local var_23_23 = var_23_21 <= 0 and var_23_17 or var_23_17 * (var_23_22 / var_23_21)

				if var_23_23 > 0 and var_23_17 < var_23_23 then
					arg_20_1.talkMaxDuration = var_23_23

					if var_23_23 + var_23_16 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_23 + var_23_16
					end
				end

				arg_20_1.text_.text = var_23_20
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101061", "101061005", "story_v_out_101061.awb") ~= 0 then
					local var_23_24 = manager.audio:GetVoiceLength("story_v_out_101061", "101061005", "story_v_out_101061.awb") / 1000

					if var_23_24 + var_23_16 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_24 + var_23_16
					end

					if var_23_19.prefab_name ~= "" and arg_20_1.actors_[var_23_19.prefab_name] ~= nil then
						local var_23_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_19.prefab_name].transform, "story_v_out_101061", "101061005", "story_v_out_101061.awb")

						arg_20_1:RecordAudio("101061005", var_23_25)
						arg_20_1:RecordAudio("101061005", var_23_25)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_101061", "101061005", "story_v_out_101061.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_101061", "101061005", "story_v_out_101061.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_26 = math.max(var_23_17, arg_20_1.talkMaxDuration)

			if var_23_16 <= arg_20_1.time_ and arg_20_1.time_ < var_23_16 + var_23_26 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_16) / var_23_26

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_16 + var_23_26 and arg_20_1.time_ < var_23_16 + var_23_26 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2020_tpose",
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
	Play101061006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 101061006
		arg_24_1.duration_ = 13.97

		local var_24_0 = {
			ja = 13.966,
			ko = 6.3,
			zh = 5.766,
			en = 5.166
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
				arg_24_0:Play101061007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = arg_24_1.actors_["2020_tpose"]
			local var_27_1 = 0

			if var_27_1 < arg_24_1.time_ and arg_24_1.time_ <= var_27_1 + arg_27_0 and not isNil(var_27_0) and arg_24_1.var_.characterEffect2020_tpose == nil then
				arg_24_1.var_.characterEffect2020_tpose = var_27_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_2 = 0.1

			if var_27_1 <= arg_24_1.time_ and arg_24_1.time_ < var_27_1 + var_27_2 and not isNil(var_27_0) then
				local var_27_3 = (arg_24_1.time_ - var_27_1) / var_27_2

				if arg_24_1.var_.characterEffect2020_tpose and not isNil(var_27_0) then
					local var_27_4 = Mathf.Lerp(0, 0.5, var_27_3)

					arg_24_1.var_.characterEffect2020_tpose.fillFlat = true
					arg_24_1.var_.characterEffect2020_tpose.fillRatio = var_27_4
				end
			end

			if arg_24_1.time_ >= var_27_1 + var_27_2 and arg_24_1.time_ < var_27_1 + var_27_2 + arg_27_0 and not isNil(var_27_0) and arg_24_1.var_.characterEffect2020_tpose then
				local var_27_5 = 0.5

				arg_24_1.var_.characterEffect2020_tpose.fillFlat = true
				arg_24_1.var_.characterEffect2020_tpose.fillRatio = var_27_5
			end

			local var_27_6 = "1035ui_story"

			if arg_24_1.actors_[var_27_6] == nil then
				local var_27_7 = Asset.Load("Char/" .. "1035ui_story")

				if not isNil(var_27_7) then
					local var_27_8 = Object.Instantiate(Asset.Load("Char/" .. "1035ui_story"), arg_24_1.stage_.transform)

					var_27_8.name = var_27_6
					var_27_8.transform.localPosition = Vector3.New(0, 100, 0)
					arg_24_1.actors_[var_27_6] = var_27_8

					local var_27_9 = var_27_8:GetComponentInChildren(typeof(CharacterEffect))

					var_27_9.enabled = true

					local var_27_10 = GameObjectTools.GetOrAddComponent(var_27_8, typeof(DynamicBoneHelper))

					if var_27_10 then
						var_27_10:EnableDynamicBone(false)
					end

					arg_24_1:ShowWeapon(var_27_9.transform, false)

					arg_24_1.var_[var_27_6 .. "Animator"] = var_27_9.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_24_1.var_[var_27_6 .. "Animator"].applyRootMotion = true
					arg_24_1.var_[var_27_6 .. "LipSync"] = var_27_9.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_27_11 = arg_24_1.actors_["1035ui_story"]
			local var_27_12 = 0

			if var_27_12 < arg_24_1.time_ and arg_24_1.time_ <= var_27_12 + arg_27_0 and not isNil(var_27_11) and arg_24_1.var_.characterEffect1035ui_story == nil then
				arg_24_1.var_.characterEffect1035ui_story = var_27_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_13 = 0.100000001490116

			if var_27_12 <= arg_24_1.time_ and arg_24_1.time_ < var_27_12 + var_27_13 and not isNil(var_27_11) then
				local var_27_14 = (arg_24_1.time_ - var_27_12) / var_27_13

				if arg_24_1.var_.characterEffect1035ui_story and not isNil(var_27_11) then
					arg_24_1.var_.characterEffect1035ui_story.fillFlat = false
				end
			end

			if arg_24_1.time_ >= var_27_12 + var_27_13 and arg_24_1.time_ < var_27_12 + var_27_13 + arg_27_0 and not isNil(var_27_11) and arg_24_1.var_.characterEffect1035ui_story then
				arg_24_1.var_.characterEffect1035ui_story.fillFlat = false
			end

			local var_27_15 = 0

			if var_27_15 < arg_24_1.time_ and arg_24_1.time_ <= var_27_15 + arg_27_0 then
				arg_24_1:PlayTimeline("1035ui_story", "StoryTimeline/CharAction/story1035/story1035action/1035action11_1")
			end

			local var_27_16 = arg_24_1.actors_["1035ui_story"].transform
			local var_27_17 = 0

			if var_27_17 < arg_24_1.time_ and arg_24_1.time_ <= var_27_17 + arg_27_0 then
				arg_24_1.var_.moveOldPos1035ui_story = var_27_16.localPosition
			end

			local var_27_18 = 0.001

			if var_27_17 <= arg_24_1.time_ and arg_24_1.time_ < var_27_17 + var_27_18 then
				local var_27_19 = (arg_24_1.time_ - var_27_17) / var_27_18
				local var_27_20 = Vector3.New(0.7, -1.05, -5.6)

				var_27_16.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos1035ui_story, var_27_20, var_27_19)

				local var_27_21 = manager.ui.mainCamera.transform.position - var_27_16.position

				var_27_16.forward = Vector3.New(var_27_21.x, var_27_21.y, var_27_21.z)

				local var_27_22 = var_27_16.localEulerAngles

				var_27_22.z = 0
				var_27_22.x = 0
				var_27_16.localEulerAngles = var_27_22
			end

			if arg_24_1.time_ >= var_27_17 + var_27_18 and arg_24_1.time_ < var_27_17 + var_27_18 + arg_27_0 then
				var_27_16.localPosition = Vector3.New(0.7, -1.05, -5.6)

				local var_27_23 = manager.ui.mainCamera.transform.position - var_27_16.position

				var_27_16.forward = Vector3.New(var_27_23.x, var_27_23.y, var_27_23.z)

				local var_27_24 = var_27_16.localEulerAngles

				var_27_24.z = 0
				var_27_24.x = 0
				var_27_16.localEulerAngles = var_27_24
			end

			local var_27_25 = 0
			local var_27_26 = 0.7

			if var_27_25 < arg_24_1.time_ and arg_24_1.time_ <= var_27_25 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				local var_27_27 = arg_24_1:FormatText(StoryNameCfg[21].name)

				arg_24_1.leftNameTxt_.text = var_27_27

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_28 = arg_24_1:GetWordFromCfg(101061006)
				local var_27_29 = arg_24_1:FormatText(var_27_28.content)

				arg_24_1.text_.text = var_27_29

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_30 = 28
				local var_27_31 = utf8.len(var_27_29)
				local var_27_32 = var_27_30 <= 0 and var_27_26 or var_27_26 * (var_27_31 / var_27_30)

				if var_27_32 > 0 and var_27_26 < var_27_32 then
					arg_24_1.talkMaxDuration = var_27_32

					if var_27_32 + var_27_25 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_32 + var_27_25
					end
				end

				arg_24_1.text_.text = var_27_29
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101061", "101061006", "story_v_out_101061.awb") ~= 0 then
					local var_27_33 = manager.audio:GetVoiceLength("story_v_out_101061", "101061006", "story_v_out_101061.awb") / 1000

					if var_27_33 + var_27_25 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_33 + var_27_25
					end

					if var_27_28.prefab_name ~= "" and arg_24_1.actors_[var_27_28.prefab_name] ~= nil then
						local var_27_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_28.prefab_name].transform, "story_v_out_101061", "101061006", "story_v_out_101061.awb")

						arg_24_1:RecordAudio("101061006", var_27_34)
						arg_24_1:RecordAudio("101061006", var_27_34)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_101061", "101061006", "story_v_out_101061.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_101061", "101061006", "story_v_out_101061.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_35 = math.max(var_27_26, arg_24_1.talkMaxDuration)

			if var_27_25 <= arg_24_1.time_ and arg_24_1.time_ < var_27_25 + var_27_35 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_25) / var_27_35

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_25 + var_27_35 and arg_24_1.time_ < var_27_25 + var_27_35 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1035ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_24_1:InitPlayNodeList()
	end,
	Play101061007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 101061007
		arg_28_1.duration_ = 7.97

		local var_28_0 = {
			ja = 7.966,
			ko = 7.466,
			zh = 5.866,
			en = 5.5
		}
		local var_28_1 = manager.audio:GetLocalizationFlag()

		if var_28_0[var_28_1] ~= nil then
			arg_28_1.duration_ = var_28_0[var_28_1]
		end

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play101061008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = arg_28_1.actors_["2020_tpose"]
			local var_31_1 = 0

			if var_31_1 < arg_28_1.time_ and arg_28_1.time_ <= var_31_1 + arg_31_0 and not isNil(var_31_0) and arg_28_1.var_.characterEffect2020_tpose == nil then
				arg_28_1.var_.characterEffect2020_tpose = var_31_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_2 = 0.1

			if var_31_1 <= arg_28_1.time_ and arg_28_1.time_ < var_31_1 + var_31_2 and not isNil(var_31_0) then
				local var_31_3 = (arg_28_1.time_ - var_31_1) / var_31_2

				if arg_28_1.var_.characterEffect2020_tpose and not isNil(var_31_0) then
					arg_28_1.var_.characterEffect2020_tpose.fillFlat = false
				end
			end

			if arg_28_1.time_ >= var_31_1 + var_31_2 and arg_28_1.time_ < var_31_1 + var_31_2 + arg_31_0 and not isNil(var_31_0) and arg_28_1.var_.characterEffect2020_tpose then
				arg_28_1.var_.characterEffect2020_tpose.fillFlat = false
			end

			local var_31_4 = arg_28_1.actors_["1035ui_story"]
			local var_31_5 = 0

			if var_31_5 < arg_28_1.time_ and arg_28_1.time_ <= var_31_5 + arg_31_0 and not isNil(var_31_4) and arg_28_1.var_.characterEffect1035ui_story == nil then
				arg_28_1.var_.characterEffect1035ui_story = var_31_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_6 = 0.1

			if var_31_5 <= arg_28_1.time_ and arg_28_1.time_ < var_31_5 + var_31_6 and not isNil(var_31_4) then
				local var_31_7 = (arg_28_1.time_ - var_31_5) / var_31_6

				if arg_28_1.var_.characterEffect1035ui_story and not isNil(var_31_4) then
					local var_31_8 = Mathf.Lerp(0, 0.5, var_31_7)

					arg_28_1.var_.characterEffect1035ui_story.fillFlat = true
					arg_28_1.var_.characterEffect1035ui_story.fillRatio = var_31_8
				end
			end

			if arg_28_1.time_ >= var_31_5 + var_31_6 and arg_28_1.time_ < var_31_5 + var_31_6 + arg_31_0 and not isNil(var_31_4) and arg_28_1.var_.characterEffect1035ui_story then
				local var_31_9 = 0.5

				arg_28_1.var_.characterEffect1035ui_story.fillFlat = true
				arg_28_1.var_.characterEffect1035ui_story.fillRatio = var_31_9
			end

			local var_31_10 = 0
			local var_31_11 = 0.75

			if var_31_10 < arg_28_1.time_ and arg_28_1.time_ <= var_31_10 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				local var_31_12 = arg_28_1:FormatText(StoryNameCfg[19].name)

				arg_28_1.leftNameTxt_.text = var_31_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_13 = arg_28_1:GetWordFromCfg(101061007)
				local var_31_14 = arg_28_1:FormatText(var_31_13.content)

				arg_28_1.text_.text = var_31_14

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_15 = 30
				local var_31_16 = utf8.len(var_31_14)
				local var_31_17 = var_31_15 <= 0 and var_31_11 or var_31_11 * (var_31_16 / var_31_15)

				if var_31_17 > 0 and var_31_11 < var_31_17 then
					arg_28_1.talkMaxDuration = var_31_17

					if var_31_17 + var_31_10 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_17 + var_31_10
					end
				end

				arg_28_1.text_.text = var_31_14
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101061", "101061007", "story_v_out_101061.awb") ~= 0 then
					local var_31_18 = manager.audio:GetVoiceLength("story_v_out_101061", "101061007", "story_v_out_101061.awb") / 1000

					if var_31_18 + var_31_10 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_18 + var_31_10
					end

					if var_31_13.prefab_name ~= "" and arg_28_1.actors_[var_31_13.prefab_name] ~= nil then
						local var_31_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_13.prefab_name].transform, "story_v_out_101061", "101061007", "story_v_out_101061.awb")

						arg_28_1:RecordAudio("101061007", var_31_19)
						arg_28_1:RecordAudio("101061007", var_31_19)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_101061", "101061007", "story_v_out_101061.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_101061", "101061007", "story_v_out_101061.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_20 = math.max(var_31_11, arg_28_1.talkMaxDuration)

			if var_31_10 <= arg_28_1.time_ and arg_28_1.time_ < var_31_10 + var_31_20 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_10) / var_31_20

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_10 + var_31_20 and arg_28_1.time_ < var_31_10 + var_31_20 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play101061008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 101061008
		arg_32_1.duration_ = 6.67

		local var_32_0 = {
			ja = 3.566,
			ko = 6.666,
			zh = 2.7,
			en = 3.266
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
				arg_32_0:Play101061009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = arg_32_1.actors_["2020_tpose"]
			local var_35_1 = 0

			if var_35_1 < arg_32_1.time_ and arg_32_1.time_ <= var_35_1 + arg_35_0 and not isNil(var_35_0) and arg_32_1.var_.characterEffect2020_tpose == nil then
				arg_32_1.var_.characterEffect2020_tpose = var_35_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_2 = 0.1

			if var_35_1 <= arg_32_1.time_ and arg_32_1.time_ < var_35_1 + var_35_2 and not isNil(var_35_0) then
				local var_35_3 = (arg_32_1.time_ - var_35_1) / var_35_2

				if arg_32_1.var_.characterEffect2020_tpose and not isNil(var_35_0) then
					local var_35_4 = Mathf.Lerp(0, 0.5, var_35_3)

					arg_32_1.var_.characterEffect2020_tpose.fillFlat = true
					arg_32_1.var_.characterEffect2020_tpose.fillRatio = var_35_4
				end
			end

			if arg_32_1.time_ >= var_35_1 + var_35_2 and arg_32_1.time_ < var_35_1 + var_35_2 + arg_35_0 and not isNil(var_35_0) and arg_32_1.var_.characterEffect2020_tpose then
				local var_35_5 = 0.5

				arg_32_1.var_.characterEffect2020_tpose.fillFlat = true
				arg_32_1.var_.characterEffect2020_tpose.fillRatio = var_35_5
			end

			local var_35_6 = arg_32_1.actors_["1035ui_story"]
			local var_35_7 = 0

			if var_35_7 < arg_32_1.time_ and arg_32_1.time_ <= var_35_7 + arg_35_0 and not isNil(var_35_6) and arg_32_1.var_.characterEffect1035ui_story == nil then
				arg_32_1.var_.characterEffect1035ui_story = var_35_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_8 = 0.1

			if var_35_7 <= arg_32_1.time_ and arg_32_1.time_ < var_35_7 + var_35_8 and not isNil(var_35_6) then
				local var_35_9 = (arg_32_1.time_ - var_35_7) / var_35_8

				if arg_32_1.var_.characterEffect1035ui_story and not isNil(var_35_6) then
					arg_32_1.var_.characterEffect1035ui_story.fillFlat = false
				end
			end

			if arg_32_1.time_ >= var_35_7 + var_35_8 and arg_32_1.time_ < var_35_7 + var_35_8 + arg_35_0 and not isNil(var_35_6) and arg_32_1.var_.characterEffect1035ui_story then
				arg_32_1.var_.characterEffect1035ui_story.fillFlat = false
			end

			local var_35_10 = 0

			if var_35_10 < arg_32_1.time_ and arg_32_1.time_ <= var_35_10 + arg_35_0 then
				arg_32_1:PlayTimeline("1035ui_story", "StoryTimeline/CharAction/story1035/story1035actionlink/1035action4118")
			end

			local var_35_11 = 0
			local var_35_12 = 0.3

			if var_35_11 < arg_32_1.time_ and arg_32_1.time_ <= var_35_11 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				local var_35_13 = arg_32_1:FormatText(StoryNameCfg[21].name)

				arg_32_1.leftNameTxt_.text = var_35_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_14 = arg_32_1:GetWordFromCfg(101061008)
				local var_35_15 = arg_32_1:FormatText(var_35_14.content)

				arg_32_1.text_.text = var_35_15

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_16 = 12
				local var_35_17 = utf8.len(var_35_15)
				local var_35_18 = var_35_16 <= 0 and var_35_12 or var_35_12 * (var_35_17 / var_35_16)

				if var_35_18 > 0 and var_35_12 < var_35_18 then
					arg_32_1.talkMaxDuration = var_35_18

					if var_35_18 + var_35_11 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_18 + var_35_11
					end
				end

				arg_32_1.text_.text = var_35_15
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101061", "101061008", "story_v_out_101061.awb") ~= 0 then
					local var_35_19 = manager.audio:GetVoiceLength("story_v_out_101061", "101061008", "story_v_out_101061.awb") / 1000

					if var_35_19 + var_35_11 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_19 + var_35_11
					end

					if var_35_14.prefab_name ~= "" and arg_32_1.actors_[var_35_14.prefab_name] ~= nil then
						local var_35_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_14.prefab_name].transform, "story_v_out_101061", "101061008", "story_v_out_101061.awb")

						arg_32_1:RecordAudio("101061008", var_35_20)
						arg_32_1:RecordAudio("101061008", var_35_20)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_101061", "101061008", "story_v_out_101061.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_101061", "101061008", "story_v_out_101061.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_21 = math.max(var_35_12, arg_32_1.talkMaxDuration)

			if var_35_11 <= arg_32_1.time_ and arg_32_1.time_ < var_35_11 + var_35_21 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_11) / var_35_21

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_11 + var_35_21 and arg_32_1.time_ < var_35_11 + var_35_21 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play101061009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 101061009
		arg_36_1.duration_ = 8.67

		local var_36_0 = {
			ja = 8.666,
			ko = 3.1,
			zh = 5.8,
			en = 5.6
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
				arg_36_0:Play101061010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = arg_36_1.actors_["2020_tpose"]
			local var_39_1 = 0

			if var_39_1 < arg_36_1.time_ and arg_36_1.time_ <= var_39_1 + arg_39_0 and not isNil(var_39_0) and arg_36_1.var_.characterEffect2020_tpose == nil then
				arg_36_1.var_.characterEffect2020_tpose = var_39_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_2 = 0.1

			if var_39_1 <= arg_36_1.time_ and arg_36_1.time_ < var_39_1 + var_39_2 and not isNil(var_39_0) then
				local var_39_3 = (arg_36_1.time_ - var_39_1) / var_39_2

				if arg_36_1.var_.characterEffect2020_tpose and not isNil(var_39_0) then
					arg_36_1.var_.characterEffect2020_tpose.fillFlat = false
				end
			end

			if arg_36_1.time_ >= var_39_1 + var_39_2 and arg_36_1.time_ < var_39_1 + var_39_2 + arg_39_0 and not isNil(var_39_0) and arg_36_1.var_.characterEffect2020_tpose then
				arg_36_1.var_.characterEffect2020_tpose.fillFlat = false
			end

			local var_39_4 = arg_36_1.actors_["1035ui_story"]
			local var_39_5 = 0

			if var_39_5 < arg_36_1.time_ and arg_36_1.time_ <= var_39_5 + arg_39_0 and not isNil(var_39_4) and arg_36_1.var_.characterEffect1035ui_story == nil then
				arg_36_1.var_.characterEffect1035ui_story = var_39_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_6 = 0.1

			if var_39_5 <= arg_36_1.time_ and arg_36_1.time_ < var_39_5 + var_39_6 and not isNil(var_39_4) then
				local var_39_7 = (arg_36_1.time_ - var_39_5) / var_39_6

				if arg_36_1.var_.characterEffect1035ui_story and not isNil(var_39_4) then
					local var_39_8 = Mathf.Lerp(0, 0.5, var_39_7)

					arg_36_1.var_.characterEffect1035ui_story.fillFlat = true
					arg_36_1.var_.characterEffect1035ui_story.fillRatio = var_39_8
				end
			end

			if arg_36_1.time_ >= var_39_5 + var_39_6 and arg_36_1.time_ < var_39_5 + var_39_6 + arg_39_0 and not isNil(var_39_4) and arg_36_1.var_.characterEffect1035ui_story then
				local var_39_9 = 0.5

				arg_36_1.var_.characterEffect1035ui_story.fillFlat = true
				arg_36_1.var_.characterEffect1035ui_story.fillRatio = var_39_9
			end

			local var_39_10 = 0
			local var_39_11 = 0.675

			if var_39_10 < arg_36_1.time_ and arg_36_1.time_ <= var_39_10 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				local var_39_12 = arg_36_1:FormatText(StoryNameCfg[19].name)

				arg_36_1.leftNameTxt_.text = var_39_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_13 = arg_36_1:GetWordFromCfg(101061009)
				local var_39_14 = arg_36_1:FormatText(var_39_13.content)

				arg_36_1.text_.text = var_39_14

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_15 = 27
				local var_39_16 = utf8.len(var_39_14)
				local var_39_17 = var_39_15 <= 0 and var_39_11 or var_39_11 * (var_39_16 / var_39_15)

				if var_39_17 > 0 and var_39_11 < var_39_17 then
					arg_36_1.talkMaxDuration = var_39_17

					if var_39_17 + var_39_10 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_17 + var_39_10
					end
				end

				arg_36_1.text_.text = var_39_14
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101061", "101061009", "story_v_out_101061.awb") ~= 0 then
					local var_39_18 = manager.audio:GetVoiceLength("story_v_out_101061", "101061009", "story_v_out_101061.awb") / 1000

					if var_39_18 + var_39_10 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_18 + var_39_10
					end

					if var_39_13.prefab_name ~= "" and arg_36_1.actors_[var_39_13.prefab_name] ~= nil then
						local var_39_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_13.prefab_name].transform, "story_v_out_101061", "101061009", "story_v_out_101061.awb")

						arg_36_1:RecordAudio("101061009", var_39_19)
						arg_36_1:RecordAudio("101061009", var_39_19)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_101061", "101061009", "story_v_out_101061.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_101061", "101061009", "story_v_out_101061.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_20 = math.max(var_39_11, arg_36_1.talkMaxDuration)

			if var_39_10 <= arg_36_1.time_ and arg_36_1.time_ < var_39_10 + var_39_20 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_10) / var_39_20

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_10 + var_39_20 and arg_36_1.time_ < var_39_10 + var_39_20 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play101061010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 101061010
		arg_40_1.duration_ = 7

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play101061011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = arg_40_1.actors_["2020_tpose"]
			local var_43_1 = 2

			if var_43_1 < arg_40_1.time_ and arg_40_1.time_ <= var_43_1 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.characterEffect2020_tpose == nil then
				arg_40_1.var_.characterEffect2020_tpose = var_43_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_2 = 0.1

			if var_43_1 <= arg_40_1.time_ and arg_40_1.time_ < var_43_1 + var_43_2 and not isNil(var_43_0) then
				local var_43_3 = (arg_40_1.time_ - var_43_1) / var_43_2

				if arg_40_1.var_.characterEffect2020_tpose and not isNil(var_43_0) then
					local var_43_4 = Mathf.Lerp(0, 0.5, var_43_3)

					arg_40_1.var_.characterEffect2020_tpose.fillFlat = true
					arg_40_1.var_.characterEffect2020_tpose.fillRatio = var_43_4
				end
			end

			if arg_40_1.time_ >= var_43_1 + var_43_2 and arg_40_1.time_ < var_43_1 + var_43_2 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.characterEffect2020_tpose then
				local var_43_5 = 0.5

				arg_40_1.var_.characterEffect2020_tpose.fillFlat = true
				arg_40_1.var_.characterEffect2020_tpose.fillRatio = var_43_5
			end

			local var_43_6 = arg_40_1.bgs_.B08b
			local var_43_7 = 0

			if var_43_7 < arg_40_1.time_ and arg_40_1.time_ <= var_43_7 + arg_43_0 then
				local var_43_8 = var_43_6:GetComponent("SpriteRenderer")

				if var_43_8 then
					arg_40_1.var_.alphaOldValueB08b = var_43_8.color.a
					arg_40_1.var_.alphaMatValueB08b = var_43_8
				end

				arg_40_1.var_.alphaOldValueB08b = 1
			end

			local var_43_9 = 1.5

			if var_43_7 <= arg_40_1.time_ and arg_40_1.time_ < var_43_7 + var_43_9 then
				local var_43_10 = (arg_40_1.time_ - var_43_7) / var_43_9
				local var_43_11 = Mathf.Lerp(arg_40_1.var_.alphaOldValueB08b, 0, var_43_10)

				if arg_40_1.var_.alphaMatValueB08b then
					local var_43_12 = arg_40_1.var_.alphaMatValueB08b.color

					var_43_12.a = var_43_11
					arg_40_1.var_.alphaMatValueB08b.color = var_43_12
				end
			end

			if arg_40_1.time_ >= var_43_7 + var_43_9 and arg_40_1.time_ < var_43_7 + var_43_9 + arg_43_0 and arg_40_1.var_.alphaMatValueB08b then
				local var_43_13 = arg_40_1.var_.alphaMatValueB08b
				local var_43_14 = var_43_13.color

				var_43_14.a = 0
				var_43_13.color = var_43_14
			end

			local var_43_15 = arg_40_1.bgs_.B08b.transform
			local var_43_16 = 1.5

			if var_43_16 < arg_40_1.time_ and arg_40_1.time_ <= var_43_16 + arg_43_0 then
				arg_40_1.var_.moveOldPosB08b = var_43_15.localPosition
			end

			local var_43_17 = 0.001

			if var_43_16 <= arg_40_1.time_ and arg_40_1.time_ < var_43_16 + var_43_17 then
				local var_43_18 = (arg_40_1.time_ - var_43_16) / var_43_17
				local var_43_19 = Vector3.New(0, -100, 10)

				var_43_15.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPosB08b, var_43_19, var_43_18)
			end

			if arg_40_1.time_ >= var_43_16 + var_43_17 and arg_40_1.time_ < var_43_16 + var_43_17 + arg_43_0 then
				var_43_15.localPosition = Vector3.New(0, -100, 10)
			end

			local var_43_20 = "B08c"

			if arg_40_1.bgs_[var_43_20] == nil then
				local var_43_21 = Object.Instantiate(arg_40_1.paintGo_)

				var_43_21:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_43_20)
				var_43_21.name = var_43_20
				var_43_21.transform.parent = arg_40_1.stage_.transform
				var_43_21.transform.localPosition = Vector3.New(0, 100, 0)
				arg_40_1.bgs_[var_43_20] = var_43_21
			end

			local var_43_22 = arg_40_1.bgs_.B08c
			local var_43_23 = 1.5

			if var_43_23 < arg_40_1.time_ and arg_40_1.time_ <= var_43_23 + arg_43_0 then
				local var_43_24 = var_43_22:GetComponent("SpriteRenderer")

				if var_43_24 then
					arg_40_1.var_.alphaOldValueB08c = var_43_24.color.a
					arg_40_1.var_.alphaMatValueB08c = var_43_24
				end

				arg_40_1.var_.alphaOldValueB08c = 0
			end

			local var_43_25 = 1.5

			if var_43_23 <= arg_40_1.time_ and arg_40_1.time_ < var_43_23 + var_43_25 then
				local var_43_26 = (arg_40_1.time_ - var_43_23) / var_43_25
				local var_43_27 = Mathf.Lerp(arg_40_1.var_.alphaOldValueB08c, 1, var_43_26)

				if arg_40_1.var_.alphaMatValueB08c then
					local var_43_28 = arg_40_1.var_.alphaMatValueB08c.color

					var_43_28.a = var_43_27
					arg_40_1.var_.alphaMatValueB08c.color = var_43_28
				end
			end

			if arg_40_1.time_ >= var_43_23 + var_43_25 and arg_40_1.time_ < var_43_23 + var_43_25 + arg_43_0 and arg_40_1.var_.alphaMatValueB08c then
				local var_43_29 = arg_40_1.var_.alphaMatValueB08c
				local var_43_30 = var_43_29.color

				var_43_30.a = 1
				var_43_29.color = var_43_30
			end

			local var_43_31 = 1.5

			if var_43_31 < arg_40_1.time_ and arg_40_1.time_ <= var_43_31 + arg_43_0 then
				local var_43_32 = manager.ui.mainCamera.transform.localPosition
				local var_43_33 = Vector3.New(0, 0, 10) + Vector3.New(var_43_32.x, var_43_32.y, 0)
				local var_43_34 = arg_40_1.bgs_.B08c

				var_43_34.transform.localPosition = var_43_33
				var_43_34.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_43_35 = var_43_34:GetComponent("SpriteRenderer")

				if var_43_35 and var_43_35.sprite then
					local var_43_36 = (var_43_34.transform.localPosition - var_43_32).z
					local var_43_37 = manager.ui.mainCameraCom_
					local var_43_38 = 2 * var_43_36 * Mathf.Tan(var_43_37.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_43_39 = var_43_38 * var_43_37.aspect
					local var_43_40 = var_43_35.sprite.bounds.size.x
					local var_43_41 = var_43_35.sprite.bounds.size.y
					local var_43_42 = var_43_39 / var_43_40
					local var_43_43 = var_43_38 / var_43_41
					local var_43_44 = var_43_43 < var_43_42 and var_43_42 or var_43_43

					var_43_34.transform.localScale = Vector3.New(var_43_44, var_43_44, 0)
				end

				for iter_43_0, iter_43_1 in pairs(arg_40_1.bgs_) do
					if iter_43_0 ~= "B08c" then
						iter_43_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_43_45 = arg_40_1.actors_["2020_tpose"].transform
			local var_43_46 = 0

			if var_43_46 < arg_40_1.time_ and arg_40_1.time_ <= var_43_46 + arg_43_0 then
				arg_40_1.var_.moveOldPos2020_tpose = var_43_45.localPosition

				local var_43_47 = GameObjectTools.GetOrAddComponent(var_43_45.gameObject, typeof(DynamicBoneHelper))

				if var_43_47 then
					var_43_47:EnableDynamicBone(false)
				end
			end

			local var_43_48 = 0.001

			if var_43_46 <= arg_40_1.time_ and arg_40_1.time_ < var_43_46 + var_43_48 then
				local var_43_49 = (arg_40_1.time_ - var_43_46) / var_43_48
				local var_43_50 = Vector3.New(0, 100, 0)

				var_43_45.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos2020_tpose, var_43_50, var_43_49)

				local var_43_51 = manager.ui.mainCamera.transform.position - var_43_45.position

				var_43_45.forward = Vector3.New(var_43_51.x, var_43_51.y, var_43_51.z)

				local var_43_52 = var_43_45.localEulerAngles

				var_43_52.z = 0
				var_43_52.x = 0
				var_43_45.localEulerAngles = var_43_52
			end

			if arg_40_1.time_ >= var_43_46 + var_43_48 and arg_40_1.time_ < var_43_46 + var_43_48 + arg_43_0 then
				var_43_45.localPosition = Vector3.New(0, 100, 0)

				local var_43_53 = manager.ui.mainCamera.transform.position - var_43_45.position

				var_43_45.forward = Vector3.New(var_43_53.x, var_43_53.y, var_43_53.z)

				local var_43_54 = var_43_45.localEulerAngles

				var_43_54.z = 0
				var_43_54.x = 0
				var_43_45.localEulerAngles = var_43_54

				local var_43_55 = GameObjectTools.GetOrAddComponent(var_43_45.gameObject, typeof(DynamicBoneHelper))

				if var_43_55 then
					var_43_55:EnableDynamicBone(true)
				end
			end

			local var_43_56 = arg_40_1.actors_["1035ui_story"].transform
			local var_43_57 = 0

			if var_43_57 < arg_40_1.time_ and arg_40_1.time_ <= var_43_57 + arg_43_0 then
				arg_40_1.var_.moveOldPos1035ui_story = var_43_56.localPosition
			end

			local var_43_58 = 0.001

			if var_43_57 <= arg_40_1.time_ and arg_40_1.time_ < var_43_57 + var_43_58 then
				local var_43_59 = (arg_40_1.time_ - var_43_57) / var_43_58
				local var_43_60 = Vector3.New(0, 100, 0)

				var_43_56.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos1035ui_story, var_43_60, var_43_59)

				local var_43_61 = manager.ui.mainCamera.transform.position - var_43_56.position

				var_43_56.forward = Vector3.New(var_43_61.x, var_43_61.y, var_43_61.z)

				local var_43_62 = var_43_56.localEulerAngles

				var_43_62.z = 0
				var_43_62.x = 0
				var_43_56.localEulerAngles = var_43_62
			end

			if arg_40_1.time_ >= var_43_57 + var_43_58 and arg_40_1.time_ < var_43_57 + var_43_58 + arg_43_0 then
				var_43_56.localPosition = Vector3.New(0, 100, 0)

				local var_43_63 = manager.ui.mainCamera.transform.position - var_43_56.position

				var_43_56.forward = Vector3.New(var_43_63.x, var_43_63.y, var_43_63.z)

				local var_43_64 = var_43_56.localEulerAngles

				var_43_64.z = 0
				var_43_64.x = 0
				var_43_56.localEulerAngles = var_43_64
			end

			local var_43_65 = 0

			if var_43_65 < arg_40_1.time_ and arg_40_1.time_ <= var_43_65 + arg_43_0 then
				arg_40_1.allBtn_.enabled = false
			end

			local var_43_66 = 2

			if arg_40_1.time_ >= var_43_65 + var_43_66 and arg_40_1.time_ < var_43_65 + var_43_66 + arg_43_0 then
				arg_40_1.allBtn_.enabled = true
			end

			if arg_40_1.frameCnt_ <= 1 then
				arg_40_1.dialog_:SetActive(false)
			end

			local var_43_67 = 2
			local var_43_68 = 0.125

			if var_43_67 < arg_40_1.time_ and arg_40_1.time_ <= var_43_67 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0

				arg_40_1.dialog_:SetActive(true)

				arg_40_1.dialogCg_.alpha = 0

				local var_43_69 = LeanTween.value(arg_40_1.dialog_, 0, 1, 0.3)

				var_43_69:setOnUpdate(LuaHelper.FloatAction(function(arg_44_0)
					arg_40_1.dialogCg_.alpha = arg_44_0
				end))
				var_43_69:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_40_1.dialog_)
					var_43_69:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_40_1.duration_ = arg_40_1.duration_ + 0.3

				SetActive(arg_40_1.leftNameGo_, false)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_70 = arg_40_1:GetWordFromCfg(101061010)
				local var_43_71 = arg_40_1:FormatText(var_43_70.content)

				arg_40_1.text_.text = var_43_71

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_72 = 5
				local var_43_73 = utf8.len(var_43_71)
				local var_43_74 = var_43_72 <= 0 and var_43_68 or var_43_68 * (var_43_73 / var_43_72)

				if var_43_74 > 0 and var_43_68 < var_43_74 then
					arg_40_1.talkMaxDuration = var_43_74
					var_43_67 = var_43_67 + 0.3

					if var_43_74 + var_43_67 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_74 + var_43_67
					end
				end

				arg_40_1.text_.text = var_43_71
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)
				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_75 = var_43_67 + 0.3
			local var_43_76 = math.max(var_43_68, arg_40_1.talkMaxDuration)

			if var_43_75 <= arg_40_1.time_ and arg_40_1.time_ < var_43_75 + var_43_76 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_75) / var_43_76

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_75 + var_43_76 and arg_40_1.time_ < var_43_75 + var_43_76 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "B08b",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 1.5,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "2020_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1035ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_40_1:InitPlayNodeList()
	end,
	Play101061011 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 101061011
		arg_46_1.duration_ = 3.17

		local var_46_0 = {
			ja = 2.866,
			ko = 2.033,
			zh = 2.8,
			en = 3.166
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
				arg_46_0:Play101061012(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			local var_49_0 = arg_46_1.actors_["3008ui_story"]
			local var_49_1 = 0

			if var_49_1 < arg_46_1.time_ and arg_46_1.time_ <= var_49_1 + arg_49_0 and not isNil(var_49_0) and arg_46_1.var_.characterEffect3008ui_story == nil then
				arg_46_1.var_.characterEffect3008ui_story = var_49_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_49_2 = 0.1

			if var_49_1 <= arg_46_1.time_ and arg_46_1.time_ < var_49_1 + var_49_2 and not isNil(var_49_0) then
				local var_49_3 = (arg_46_1.time_ - var_49_1) / var_49_2

				if arg_46_1.var_.characterEffect3008ui_story and not isNil(var_49_0) then
					arg_46_1.var_.characterEffect3008ui_story.fillFlat = false
				end
			end

			if arg_46_1.time_ >= var_49_1 + var_49_2 and arg_46_1.time_ < var_49_1 + var_49_2 + arg_49_0 and not isNil(var_49_0) and arg_46_1.var_.characterEffect3008ui_story then
				arg_46_1.var_.characterEffect3008ui_story.fillFlat = false
			end

			local var_49_4 = arg_46_1.actors_["3008ui_story"].transform
			local var_49_5 = 0

			if var_49_5 < arg_46_1.time_ and arg_46_1.time_ <= var_49_5 + arg_49_0 then
				arg_46_1.var_.moveOldPos3008ui_story = var_49_4.localPosition
			end

			local var_49_6 = 0.001

			if var_49_5 <= arg_46_1.time_ and arg_46_1.time_ < var_49_5 + var_49_6 then
				local var_49_7 = (arg_46_1.time_ - var_49_5) / var_49_6
				local var_49_8 = Vector3.New(0, -1.51, -4.3)

				var_49_4.localPosition = Vector3.Lerp(arg_46_1.var_.moveOldPos3008ui_story, var_49_8, var_49_7)

				local var_49_9 = manager.ui.mainCamera.transform.position - var_49_4.position

				var_49_4.forward = Vector3.New(var_49_9.x, var_49_9.y, var_49_9.z)

				local var_49_10 = var_49_4.localEulerAngles

				var_49_10.z = 0
				var_49_10.x = 0
				var_49_4.localEulerAngles = var_49_10
			end

			if arg_46_1.time_ >= var_49_5 + var_49_6 and arg_46_1.time_ < var_49_5 + var_49_6 + arg_49_0 then
				var_49_4.localPosition = Vector3.New(0, -1.51, -4.3)

				local var_49_11 = manager.ui.mainCamera.transform.position - var_49_4.position

				var_49_4.forward = Vector3.New(var_49_11.x, var_49_11.y, var_49_11.z)

				local var_49_12 = var_49_4.localEulerAngles

				var_49_12.z = 0
				var_49_12.x = 0
				var_49_4.localEulerAngles = var_49_12
			end

			local var_49_13 = 0

			if var_49_13 < arg_46_1.time_ and arg_46_1.time_ <= var_49_13 + arg_49_0 then
				arg_46_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/story3008/story3008action/3008action6_1")
			end

			local var_49_14 = 0

			if var_49_14 < arg_46_1.time_ and arg_46_1.time_ <= var_49_14 + arg_49_0 then
				arg_46_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_49_15 = 0
			local var_49_16 = 0.325

			if var_49_15 < arg_46_1.time_ and arg_46_1.time_ <= var_49_15 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0
				arg_46_1.dialogCg_.alpha = 1

				arg_46_1.dialog_:SetActive(true)
				SetActive(arg_46_1.leftNameGo_, true)

				local var_49_17 = arg_46_1:FormatText(StoryNameCfg[20].name)

				arg_46_1.leftNameTxt_.text = var_49_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_46_1.leftNameTxt_.transform)

				arg_46_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_46_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_46_1:RecordName(arg_46_1.leftNameTxt_.text)
				SetActive(arg_46_1.iconTrs_.gameObject, false)
				arg_46_1.callingController_:SetSelectedState("normal")

				local var_49_18 = arg_46_1:GetWordFromCfg(101061011)
				local var_49_19 = arg_46_1:FormatText(var_49_18.content)

				arg_46_1.text_.text = var_49_19

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_20 = 11
				local var_49_21 = utf8.len(var_49_19)
				local var_49_22 = var_49_20 <= 0 and var_49_16 or var_49_16 * (var_49_21 / var_49_20)

				if var_49_22 > 0 and var_49_16 < var_49_22 then
					arg_46_1.talkMaxDuration = var_49_22

					if var_49_22 + var_49_15 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_22 + var_49_15
					end
				end

				arg_46_1.text_.text = var_49_19
				arg_46_1.typewritter.percent = 0

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101061", "101061011", "story_v_out_101061.awb") ~= 0 then
					local var_49_23 = manager.audio:GetVoiceLength("story_v_out_101061", "101061011", "story_v_out_101061.awb") / 1000

					if var_49_23 + var_49_15 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_23 + var_49_15
					end

					if var_49_18.prefab_name ~= "" and arg_46_1.actors_[var_49_18.prefab_name] ~= nil then
						local var_49_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_46_1.actors_[var_49_18.prefab_name].transform, "story_v_out_101061", "101061011", "story_v_out_101061.awb")

						arg_46_1:RecordAudio("101061011", var_49_24)
						arg_46_1:RecordAudio("101061011", var_49_24)
					else
						arg_46_1:AudioAction("play", "voice", "story_v_out_101061", "101061011", "story_v_out_101061.awb")
					end

					arg_46_1:RecordHistoryTalkVoice("story_v_out_101061", "101061011", "story_v_out_101061.awb")
				end

				arg_46_1:RecordContent(arg_46_1.text_.text)
			end

			local var_49_25 = math.max(var_49_16, arg_46_1.talkMaxDuration)

			if var_49_15 <= arg_46_1.time_ and arg_46_1.time_ < var_49_15 + var_49_25 then
				arg_46_1.typewritter.percent = (arg_46_1.time_ - var_49_15) / var_49_25

				arg_46_1.typewritter:SetDirty()
			end

			if arg_46_1.time_ >= var_49_15 + var_49_25 and arg_46_1.time_ < var_49_15 + var_49_25 + arg_49_0 then
				arg_46_1.typewritter.percent = 1

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(true)
			end
		end

		arg_46_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3008ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_46_1:InitPlayNodeList()
	end,
	Play101061012 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 101061012
		arg_50_1.duration_ = 5

		local var_50_0 = {
			ja = 5,
			ko = 4.433,
			zh = 4,
			en = 4.8
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
				arg_50_0:Play101061013(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			local var_53_0 = arg_50_1.actors_["3008ui_story"]
			local var_53_1 = 0

			if var_53_1 < arg_50_1.time_ and arg_50_1.time_ <= var_53_1 + arg_53_0 and not isNil(var_53_0) and arg_50_1.var_.characterEffect3008ui_story == nil then
				arg_50_1.var_.characterEffect3008ui_story = var_53_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_53_2 = 0.1

			if var_53_1 <= arg_50_1.time_ and arg_50_1.time_ < var_53_1 + var_53_2 and not isNil(var_53_0) then
				local var_53_3 = (arg_50_1.time_ - var_53_1) / var_53_2

				if arg_50_1.var_.characterEffect3008ui_story and not isNil(var_53_0) then
					local var_53_4 = Mathf.Lerp(0, 0.5, var_53_3)

					arg_50_1.var_.characterEffect3008ui_story.fillFlat = true
					arg_50_1.var_.characterEffect3008ui_story.fillRatio = var_53_4
				end
			end

			if arg_50_1.time_ >= var_53_1 + var_53_2 and arg_50_1.time_ < var_53_1 + var_53_2 + arg_53_0 and not isNil(var_53_0) and arg_50_1.var_.characterEffect3008ui_story then
				local var_53_5 = 0.5

				arg_50_1.var_.characterEffect3008ui_story.fillFlat = true
				arg_50_1.var_.characterEffect3008ui_story.fillRatio = var_53_5
			end

			local var_53_6 = 0
			local var_53_7 = 0.225

			if var_53_6 < arg_50_1.time_ and arg_50_1.time_ <= var_53_6 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, true)

				local var_53_8 = arg_50_1:FormatText(StoryNameCfg[34].name)

				arg_50_1.leftNameTxt_.text = var_53_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_50_1.leftNameTxt_.transform)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1.leftNameTxt_.text)
				SetActive(arg_50_1.iconTrs_.gameObject, true)
				arg_50_1.iconController_:SetSelectedState("hero")

				arg_50_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_20301")

				arg_50_1.callingController_:SetSelectedState("normal")

				arg_50_1.keyicon_.color = Color.New(1, 1, 1)
				arg_50_1.icon_.color = Color.New(1, 1, 1)

				local var_53_9 = arg_50_1:GetWordFromCfg(101061012)
				local var_53_10 = arg_50_1:FormatText(var_53_9.content)

				arg_50_1.text_.text = var_53_10

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_11 = 9
				local var_53_12 = utf8.len(var_53_10)
				local var_53_13 = var_53_11 <= 0 and var_53_7 or var_53_7 * (var_53_12 / var_53_11)

				if var_53_13 > 0 and var_53_7 < var_53_13 then
					arg_50_1.talkMaxDuration = var_53_13

					if var_53_13 + var_53_6 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_13 + var_53_6
					end
				end

				arg_50_1.text_.text = var_53_10
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101061", "101061012", "story_v_out_101061.awb") ~= 0 then
					local var_53_14 = manager.audio:GetVoiceLength("story_v_out_101061", "101061012", "story_v_out_101061.awb") / 1000

					if var_53_14 + var_53_6 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_14 + var_53_6
					end

					if var_53_9.prefab_name ~= "" and arg_50_1.actors_[var_53_9.prefab_name] ~= nil then
						local var_53_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_50_1.actors_[var_53_9.prefab_name].transform, "story_v_out_101061", "101061012", "story_v_out_101061.awb")

						arg_50_1:RecordAudio("101061012", var_53_15)
						arg_50_1:RecordAudio("101061012", var_53_15)
					else
						arg_50_1:AudioAction("play", "voice", "story_v_out_101061", "101061012", "story_v_out_101061.awb")
					end

					arg_50_1:RecordHistoryTalkVoice("story_v_out_101061", "101061012", "story_v_out_101061.awb")
				end

				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_16 = math.max(var_53_7, arg_50_1.talkMaxDuration)

			if var_53_6 <= arg_50_1.time_ and arg_50_1.time_ < var_53_6 + var_53_16 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - var_53_6) / var_53_16

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= var_53_6 + var_53_16 and arg_50_1.time_ < var_53_6 + var_53_16 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {}

		arg_50_1:InitPlayNodeList()
	end,
	Play101061013 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 101061013
		arg_54_1.duration_ = 4.73

		local var_54_0 = {
			ja = 2.833,
			ko = 4.733,
			zh = 4.566,
			en = 4.133
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
				arg_54_0:Play101061014(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			local var_57_0 = arg_54_1.actors_["3008ui_story"]
			local var_57_1 = 0

			if var_57_1 < arg_54_1.time_ and arg_54_1.time_ <= var_57_1 + arg_57_0 and not isNil(var_57_0) and arg_54_1.var_.characterEffect3008ui_story == nil then
				arg_54_1.var_.characterEffect3008ui_story = var_57_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_57_2 = 0.1

			if var_57_1 <= arg_54_1.time_ and arg_54_1.time_ < var_57_1 + var_57_2 and not isNil(var_57_0) then
				local var_57_3 = (arg_54_1.time_ - var_57_1) / var_57_2

				if arg_54_1.var_.characterEffect3008ui_story and not isNil(var_57_0) then
					arg_54_1.var_.characterEffect3008ui_story.fillFlat = false
				end
			end

			if arg_54_1.time_ >= var_57_1 + var_57_2 and arg_54_1.time_ < var_57_1 + var_57_2 + arg_57_0 and not isNil(var_57_0) and arg_54_1.var_.characterEffect3008ui_story then
				arg_54_1.var_.characterEffect3008ui_story.fillFlat = false
			end

			local var_57_4 = arg_54_1.actors_["3008ui_story"].transform
			local var_57_5 = 0

			if var_57_5 < arg_54_1.time_ and arg_54_1.time_ <= var_57_5 + arg_57_0 then
				arg_54_1.var_.moveOldPos3008ui_story = var_57_4.localPosition
			end

			local var_57_6 = 0.5

			if var_57_5 <= arg_54_1.time_ and arg_54_1.time_ < var_57_5 + var_57_6 then
				local var_57_7 = (arg_54_1.time_ - var_57_5) / var_57_6
				local var_57_8 = Vector3.New(-0.7, -1.51, -4.3)

				var_57_4.localPosition = Vector3.Lerp(arg_54_1.var_.moveOldPos3008ui_story, var_57_8, var_57_7)

				local var_57_9 = manager.ui.mainCamera.transform.position - var_57_4.position

				var_57_4.forward = Vector3.New(var_57_9.x, var_57_9.y, var_57_9.z)

				local var_57_10 = var_57_4.localEulerAngles

				var_57_10.z = 0
				var_57_10.x = 0
				var_57_4.localEulerAngles = var_57_10
			end

			if arg_54_1.time_ >= var_57_5 + var_57_6 and arg_54_1.time_ < var_57_5 + var_57_6 + arg_57_0 then
				var_57_4.localPosition = Vector3.New(-0.7, -1.51, -4.3)

				local var_57_11 = manager.ui.mainCamera.transform.position - var_57_4.position

				var_57_4.forward = Vector3.New(var_57_11.x, var_57_11.y, var_57_11.z)

				local var_57_12 = var_57_4.localEulerAngles

				var_57_12.z = 0
				var_57_12.x = 0
				var_57_4.localEulerAngles = var_57_12
			end

			local var_57_13 = 0

			if var_57_13 < arg_54_1.time_ and arg_54_1.time_ <= var_57_13 + arg_57_0 then
				arg_54_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_57_14 = 0
			local var_57_15 = 0.55

			if var_57_14 < arg_54_1.time_ and arg_54_1.time_ <= var_57_14 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, true)

				local var_57_16 = arg_54_1:FormatText(StoryNameCfg[20].name)

				arg_54_1.leftNameTxt_.text = var_57_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_54_1.leftNameTxt_.transform)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1.leftNameTxt_.text)
				SetActive(arg_54_1.iconTrs_.gameObject, false)
				arg_54_1.callingController_:SetSelectedState("normal")

				local var_57_17 = arg_54_1:GetWordFromCfg(101061013)
				local var_57_18 = arg_54_1:FormatText(var_57_17.content)

				arg_54_1.text_.text = var_57_18

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_19 = 22
				local var_57_20 = utf8.len(var_57_18)
				local var_57_21 = var_57_19 <= 0 and var_57_15 or var_57_15 * (var_57_20 / var_57_19)

				if var_57_21 > 0 and var_57_15 < var_57_21 then
					arg_54_1.talkMaxDuration = var_57_21

					if var_57_21 + var_57_14 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_21 + var_57_14
					end
				end

				arg_54_1.text_.text = var_57_18
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101061", "101061013", "story_v_out_101061.awb") ~= 0 then
					local var_57_22 = manager.audio:GetVoiceLength("story_v_out_101061", "101061013", "story_v_out_101061.awb") / 1000

					if var_57_22 + var_57_14 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_22 + var_57_14
					end

					if var_57_17.prefab_name ~= "" and arg_54_1.actors_[var_57_17.prefab_name] ~= nil then
						local var_57_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_54_1.actors_[var_57_17.prefab_name].transform, "story_v_out_101061", "101061013", "story_v_out_101061.awb")

						arg_54_1:RecordAudio("101061013", var_57_23)
						arg_54_1:RecordAudio("101061013", var_57_23)
					else
						arg_54_1:AudioAction("play", "voice", "story_v_out_101061", "101061013", "story_v_out_101061.awb")
					end

					arg_54_1:RecordHistoryTalkVoice("story_v_out_101061", "101061013", "story_v_out_101061.awb")
				end

				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_24 = math.max(var_57_15, arg_54_1.talkMaxDuration)

			if var_57_14 <= arg_54_1.time_ and arg_54_1.time_ < var_57_14 + var_57_24 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - var_57_14) / var_57_24

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= var_57_14 + var_57_24 and arg_54_1.time_ < var_57_14 + var_57_24 + arg_57_0 then
				arg_54_1.typewritter.percent = 1

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(true)
			end
		end

		arg_54_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3008ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_54_1:InitPlayNodeList()
	end,
	Play101061014 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 101061014
		arg_58_1.duration_ = 6.87

		local var_58_0 = {
			ja = 6.866,
			ko = 3.666,
			zh = 5.2,
			en = 5.933
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
				arg_58_0:Play101061015(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			local var_61_0 = arg_58_1.actors_["2020_tpose"]
			local var_61_1 = 0

			if var_61_1 < arg_58_1.time_ and arg_58_1.time_ <= var_61_1 + arg_61_0 and not isNil(var_61_0) and arg_58_1.var_.characterEffect2020_tpose == nil then
				arg_58_1.var_.characterEffect2020_tpose = var_61_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_61_2 = 0.1

			if var_61_1 <= arg_58_1.time_ and arg_58_1.time_ < var_61_1 + var_61_2 and not isNil(var_61_0) then
				local var_61_3 = (arg_58_1.time_ - var_61_1) / var_61_2

				if arg_58_1.var_.characterEffect2020_tpose and not isNil(var_61_0) then
					arg_58_1.var_.characterEffect2020_tpose.fillFlat = false
				end
			end

			if arg_58_1.time_ >= var_61_1 + var_61_2 and arg_58_1.time_ < var_61_1 + var_61_2 + arg_61_0 and not isNil(var_61_0) and arg_58_1.var_.characterEffect2020_tpose then
				arg_58_1.var_.characterEffect2020_tpose.fillFlat = false
			end

			local var_61_4 = arg_58_1.actors_["3008ui_story"]
			local var_61_5 = 0

			if var_61_5 < arg_58_1.time_ and arg_58_1.time_ <= var_61_5 + arg_61_0 and not isNil(var_61_4) and arg_58_1.var_.characterEffect3008ui_story == nil then
				arg_58_1.var_.characterEffect3008ui_story = var_61_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_61_6 = 0.1

			if var_61_5 <= arg_58_1.time_ and arg_58_1.time_ < var_61_5 + var_61_6 and not isNil(var_61_4) then
				local var_61_7 = (arg_58_1.time_ - var_61_5) / var_61_6

				if arg_58_1.var_.characterEffect3008ui_story and not isNil(var_61_4) then
					local var_61_8 = Mathf.Lerp(0, 0.5, var_61_7)

					arg_58_1.var_.characterEffect3008ui_story.fillFlat = true
					arg_58_1.var_.characterEffect3008ui_story.fillRatio = var_61_8
				end
			end

			if arg_58_1.time_ >= var_61_5 + var_61_6 and arg_58_1.time_ < var_61_5 + var_61_6 + arg_61_0 and not isNil(var_61_4) and arg_58_1.var_.characterEffect3008ui_story then
				local var_61_9 = 0.5

				arg_58_1.var_.characterEffect3008ui_story.fillFlat = true
				arg_58_1.var_.characterEffect3008ui_story.fillRatio = var_61_9
			end

			local var_61_10 = arg_58_1.actors_["2020_tpose"].transform
			local var_61_11 = 0

			if var_61_11 < arg_58_1.time_ and arg_58_1.time_ <= var_61_11 + arg_61_0 then
				arg_58_1.var_.moveOldPos2020_tpose = var_61_10.localPosition

				local var_61_12 = GameObjectTools.GetOrAddComponent(var_61_10.gameObject, typeof(DynamicBoneHelper))

				if var_61_12 then
					var_61_12:EnableDynamicBone(false)
				end
			end

			local var_61_13 = 0.001

			if var_61_11 <= arg_58_1.time_ and arg_58_1.time_ < var_61_11 + var_61_13 then
				local var_61_14 = (arg_58_1.time_ - var_61_11) / var_61_13
				local var_61_15 = Vector3.New(0.7, -1.2, -4.1)

				var_61_10.localPosition = Vector3.Lerp(arg_58_1.var_.moveOldPos2020_tpose, var_61_15, var_61_14)

				local var_61_16 = manager.ui.mainCamera.transform.position - var_61_10.position

				var_61_10.forward = Vector3.New(var_61_16.x, var_61_16.y, var_61_16.z)

				local var_61_17 = var_61_10.localEulerAngles

				var_61_17.z = 0
				var_61_17.x = 0
				var_61_10.localEulerAngles = var_61_17
			end

			if arg_58_1.time_ >= var_61_11 + var_61_13 and arg_58_1.time_ < var_61_11 + var_61_13 + arg_61_0 then
				var_61_10.localPosition = Vector3.New(0.7, -1.2, -4.1)

				local var_61_18 = manager.ui.mainCamera.transform.position - var_61_10.position

				var_61_10.forward = Vector3.New(var_61_18.x, var_61_18.y, var_61_18.z)

				local var_61_19 = var_61_10.localEulerAngles

				var_61_19.z = 0
				var_61_19.x = 0
				var_61_10.localEulerAngles = var_61_19

				local var_61_20 = GameObjectTools.GetOrAddComponent(var_61_10.gameObject, typeof(DynamicBoneHelper))

				if var_61_20 then
					var_61_20:EnableDynamicBone(true)
				end
			end

			local var_61_21 = 0

			if var_61_21 < arg_58_1.time_ and arg_58_1.time_ <= var_61_21 + arg_61_0 then
				arg_58_1:PlayTimeline("2020_tpose", "StoryTimeline/CharAction/story2020/story2020action/2020action1_1")
			end

			local var_61_22 = 0
			local var_61_23 = 0.475

			if var_61_22 < arg_58_1.time_ and arg_58_1.time_ <= var_61_22 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, true)

				local var_61_24 = arg_58_1:FormatText(StoryNameCfg[34].name)

				arg_58_1.leftNameTxt_.text = var_61_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, false)
				arg_58_1.callingController_:SetSelectedState("normal")

				local var_61_25 = arg_58_1:GetWordFromCfg(101061014)
				local var_61_26 = arg_58_1:FormatText(var_61_25.content)

				arg_58_1.text_.text = var_61_26

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_27 = 19
				local var_61_28 = utf8.len(var_61_26)
				local var_61_29 = var_61_27 <= 0 and var_61_23 or var_61_23 * (var_61_28 / var_61_27)

				if var_61_29 > 0 and var_61_23 < var_61_29 then
					arg_58_1.talkMaxDuration = var_61_29

					if var_61_29 + var_61_22 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_29 + var_61_22
					end
				end

				arg_58_1.text_.text = var_61_26
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101061", "101061014", "story_v_out_101061.awb") ~= 0 then
					local var_61_30 = manager.audio:GetVoiceLength("story_v_out_101061", "101061014", "story_v_out_101061.awb") / 1000

					if var_61_30 + var_61_22 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_30 + var_61_22
					end

					if var_61_25.prefab_name ~= "" and arg_58_1.actors_[var_61_25.prefab_name] ~= nil then
						local var_61_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_58_1.actors_[var_61_25.prefab_name].transform, "story_v_out_101061", "101061014", "story_v_out_101061.awb")

						arg_58_1:RecordAudio("101061014", var_61_31)
						arg_58_1:RecordAudio("101061014", var_61_31)
					else
						arg_58_1:AudioAction("play", "voice", "story_v_out_101061", "101061014", "story_v_out_101061.awb")
					end

					arg_58_1:RecordHistoryTalkVoice("story_v_out_101061", "101061014", "story_v_out_101061.awb")
				end

				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_32 = math.max(var_61_23, arg_58_1.talkMaxDuration)

			if var_61_22 <= arg_58_1.time_ and arg_58_1.time_ < var_61_22 + var_61_32 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_22) / var_61_32

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_22 + var_61_32 and arg_58_1.time_ < var_61_22 + var_61_32 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2020_tpose",
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
	Play101061015 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 101061015
		arg_62_1.duration_ = 6.87

		local var_62_0 = {
			ja = 6.866,
			ko = 4.9,
			zh = 3.566,
			en = 4
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
				arg_62_0:Play101061016(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			local var_65_0 = arg_62_1.actors_["3008ui_story"]
			local var_65_1 = 0

			if var_65_1 < arg_62_1.time_ and arg_62_1.time_ <= var_65_1 + arg_65_0 and not isNil(var_65_0) and arg_62_1.var_.characterEffect3008ui_story == nil then
				arg_62_1.var_.characterEffect3008ui_story = var_65_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_65_2 = 0.1

			if var_65_1 <= arg_62_1.time_ and arg_62_1.time_ < var_65_1 + var_65_2 and not isNil(var_65_0) then
				local var_65_3 = (arg_62_1.time_ - var_65_1) / var_65_2

				if arg_62_1.var_.characterEffect3008ui_story and not isNil(var_65_0) then
					arg_62_1.var_.characterEffect3008ui_story.fillFlat = false
				end
			end

			if arg_62_1.time_ >= var_65_1 + var_65_2 and arg_62_1.time_ < var_65_1 + var_65_2 + arg_65_0 and not isNil(var_65_0) and arg_62_1.var_.characterEffect3008ui_story then
				arg_62_1.var_.characterEffect3008ui_story.fillFlat = false
			end

			local var_65_4 = arg_62_1.actors_["2020_tpose"]
			local var_65_5 = 0

			if var_65_5 < arg_62_1.time_ and arg_62_1.time_ <= var_65_5 + arg_65_0 and not isNil(var_65_4) and arg_62_1.var_.characterEffect2020_tpose == nil then
				arg_62_1.var_.characterEffect2020_tpose = var_65_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_65_6 = 0.1

			if var_65_5 <= arg_62_1.time_ and arg_62_1.time_ < var_65_5 + var_65_6 and not isNil(var_65_4) then
				local var_65_7 = (arg_62_1.time_ - var_65_5) / var_65_6

				if arg_62_1.var_.characterEffect2020_tpose and not isNil(var_65_4) then
					local var_65_8 = Mathf.Lerp(0, 0.5, var_65_7)

					arg_62_1.var_.characterEffect2020_tpose.fillFlat = true
					arg_62_1.var_.characterEffect2020_tpose.fillRatio = var_65_8
				end
			end

			if arg_62_1.time_ >= var_65_5 + var_65_6 and arg_62_1.time_ < var_65_5 + var_65_6 + arg_65_0 and not isNil(var_65_4) and arg_62_1.var_.characterEffect2020_tpose then
				local var_65_9 = 0.5

				arg_62_1.var_.characterEffect2020_tpose.fillFlat = true
				arg_62_1.var_.characterEffect2020_tpose.fillRatio = var_65_9
			end

			local var_65_10 = 0

			if var_65_10 < arg_62_1.time_ and arg_62_1.time_ <= var_65_10 + arg_65_0 then
				arg_62_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_65_11 = 0
			local var_65_12 = 0.425

			if var_65_11 < arg_62_1.time_ and arg_62_1.time_ <= var_65_11 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, true)

				local var_65_13 = arg_62_1:FormatText(StoryNameCfg[20].name)

				arg_62_1.leftNameTxt_.text = var_65_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_62_1.leftNameTxt_.transform)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1.leftNameTxt_.text)
				SetActive(arg_62_1.iconTrs_.gameObject, false)
				arg_62_1.callingController_:SetSelectedState("normal")

				local var_65_14 = arg_62_1:GetWordFromCfg(101061015)
				local var_65_15 = arg_62_1:FormatText(var_65_14.content)

				arg_62_1.text_.text = var_65_15

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_16 = 17
				local var_65_17 = utf8.len(var_65_15)
				local var_65_18 = var_65_16 <= 0 and var_65_12 or var_65_12 * (var_65_17 / var_65_16)

				if var_65_18 > 0 and var_65_12 < var_65_18 then
					arg_62_1.talkMaxDuration = var_65_18

					if var_65_18 + var_65_11 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_18 + var_65_11
					end
				end

				arg_62_1.text_.text = var_65_15
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101061", "101061015", "story_v_out_101061.awb") ~= 0 then
					local var_65_19 = manager.audio:GetVoiceLength("story_v_out_101061", "101061015", "story_v_out_101061.awb") / 1000

					if var_65_19 + var_65_11 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_19 + var_65_11
					end

					if var_65_14.prefab_name ~= "" and arg_62_1.actors_[var_65_14.prefab_name] ~= nil then
						local var_65_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_62_1.actors_[var_65_14.prefab_name].transform, "story_v_out_101061", "101061015", "story_v_out_101061.awb")

						arg_62_1:RecordAudio("101061015", var_65_20)
						arg_62_1:RecordAudio("101061015", var_65_20)
					else
						arg_62_1:AudioAction("play", "voice", "story_v_out_101061", "101061015", "story_v_out_101061.awb")
					end

					arg_62_1:RecordHistoryTalkVoice("story_v_out_101061", "101061015", "story_v_out_101061.awb")
				end

				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_21 = math.max(var_65_12, arg_62_1.talkMaxDuration)

			if var_65_11 <= arg_62_1.time_ and arg_62_1.time_ < var_65_11 + var_65_21 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - var_65_11) / var_65_21

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= var_65_11 + var_65_21 and arg_62_1.time_ < var_65_11 + var_65_21 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {}

		arg_62_1:InitPlayNodeList()
	end,
	Play101061016 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 101061016
		arg_66_1.duration_ = 4.53

		local var_66_0 = {
			ja = 4.533,
			ko = 2.833,
			zh = 3,
			en = 3.9
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
				arg_66_0:Play101061017(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			local var_69_0 = arg_66_1.actors_["2020_tpose"]
			local var_69_1 = 0

			if var_69_1 < arg_66_1.time_ and arg_66_1.time_ <= var_69_1 + arg_69_0 and not isNil(var_69_0) and arg_66_1.var_.characterEffect2020_tpose == nil then
				arg_66_1.var_.characterEffect2020_tpose = var_69_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_69_2 = 0.1

			if var_69_1 <= arg_66_1.time_ and arg_66_1.time_ < var_69_1 + var_69_2 and not isNil(var_69_0) then
				local var_69_3 = (arg_66_1.time_ - var_69_1) / var_69_2

				if arg_66_1.var_.characterEffect2020_tpose and not isNil(var_69_0) then
					arg_66_1.var_.characterEffect2020_tpose.fillFlat = false
				end
			end

			if arg_66_1.time_ >= var_69_1 + var_69_2 and arg_66_1.time_ < var_69_1 + var_69_2 + arg_69_0 and not isNil(var_69_0) and arg_66_1.var_.characterEffect2020_tpose then
				arg_66_1.var_.characterEffect2020_tpose.fillFlat = false
			end

			local var_69_4 = arg_66_1.actors_["3008ui_story"]
			local var_69_5 = 0

			if var_69_5 < arg_66_1.time_ and arg_66_1.time_ <= var_69_5 + arg_69_0 and not isNil(var_69_4) and arg_66_1.var_.characterEffect3008ui_story == nil then
				arg_66_1.var_.characterEffect3008ui_story = var_69_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_69_6 = 0.1

			if var_69_5 <= arg_66_1.time_ and arg_66_1.time_ < var_69_5 + var_69_6 and not isNil(var_69_4) then
				local var_69_7 = (arg_66_1.time_ - var_69_5) / var_69_6

				if arg_66_1.var_.characterEffect3008ui_story and not isNil(var_69_4) then
					local var_69_8 = Mathf.Lerp(0, 0.5, var_69_7)

					arg_66_1.var_.characterEffect3008ui_story.fillFlat = true
					arg_66_1.var_.characterEffect3008ui_story.fillRatio = var_69_8
				end
			end

			if arg_66_1.time_ >= var_69_5 + var_69_6 and arg_66_1.time_ < var_69_5 + var_69_6 + arg_69_0 and not isNil(var_69_4) and arg_66_1.var_.characterEffect3008ui_story then
				local var_69_9 = 0.5

				arg_66_1.var_.characterEffect3008ui_story.fillFlat = true
				arg_66_1.var_.characterEffect3008ui_story.fillRatio = var_69_9
			end

			local var_69_10 = 0
			local var_69_11 = 0.325

			if var_69_10 < arg_66_1.time_ and arg_66_1.time_ <= var_69_10 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				local var_69_12 = arg_66_1:FormatText(StoryNameCfg[34].name)

				arg_66_1.leftNameTxt_.text = var_69_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_13 = arg_66_1:GetWordFromCfg(101061016)
				local var_69_14 = arg_66_1:FormatText(var_69_13.content)

				arg_66_1.text_.text = var_69_14

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_15 = 13
				local var_69_16 = utf8.len(var_69_14)
				local var_69_17 = var_69_15 <= 0 and var_69_11 or var_69_11 * (var_69_16 / var_69_15)

				if var_69_17 > 0 and var_69_11 < var_69_17 then
					arg_66_1.talkMaxDuration = var_69_17

					if var_69_17 + var_69_10 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_17 + var_69_10
					end
				end

				arg_66_1.text_.text = var_69_14
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101061", "101061016", "story_v_out_101061.awb") ~= 0 then
					local var_69_18 = manager.audio:GetVoiceLength("story_v_out_101061", "101061016", "story_v_out_101061.awb") / 1000

					if var_69_18 + var_69_10 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_18 + var_69_10
					end

					if var_69_13.prefab_name ~= "" and arg_66_1.actors_[var_69_13.prefab_name] ~= nil then
						local var_69_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_66_1.actors_[var_69_13.prefab_name].transform, "story_v_out_101061", "101061016", "story_v_out_101061.awb")

						arg_66_1:RecordAudio("101061016", var_69_19)
						arg_66_1:RecordAudio("101061016", var_69_19)
					else
						arg_66_1:AudioAction("play", "voice", "story_v_out_101061", "101061016", "story_v_out_101061.awb")
					end

					arg_66_1:RecordHistoryTalkVoice("story_v_out_101061", "101061016", "story_v_out_101061.awb")
				end

				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_20 = math.max(var_69_11, arg_66_1.talkMaxDuration)

			if var_69_10 <= arg_66_1.time_ and arg_66_1.time_ < var_69_10 + var_69_20 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_10) / var_69_20

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_10 + var_69_20 and arg_66_1.time_ < var_69_10 + var_69_20 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {}

		arg_66_1:InitPlayNodeList()
	end,
	Play101061017 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 101061017
		arg_70_1.duration_ = 5.53

		local var_70_0 = {
			ja = 4.866,
			ko = 5.433,
			zh = 3.933,
			en = 5.533
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
				arg_70_0:Play101061018(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			local var_73_0 = arg_70_1.actors_["3008ui_story"]
			local var_73_1 = 0

			if var_73_1 < arg_70_1.time_ and arg_70_1.time_ <= var_73_1 + arg_73_0 and not isNil(var_73_0) and arg_70_1.var_.characterEffect3008ui_story == nil then
				arg_70_1.var_.characterEffect3008ui_story = var_73_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_73_2 = 0.1

			if var_73_1 <= arg_70_1.time_ and arg_70_1.time_ < var_73_1 + var_73_2 and not isNil(var_73_0) then
				local var_73_3 = (arg_70_1.time_ - var_73_1) / var_73_2

				if arg_70_1.var_.characterEffect3008ui_story and not isNil(var_73_0) then
					arg_70_1.var_.characterEffect3008ui_story.fillFlat = false
				end
			end

			if arg_70_1.time_ >= var_73_1 + var_73_2 and arg_70_1.time_ < var_73_1 + var_73_2 + arg_73_0 and not isNil(var_73_0) and arg_70_1.var_.characterEffect3008ui_story then
				arg_70_1.var_.characterEffect3008ui_story.fillFlat = false
			end

			local var_73_4 = arg_70_1.actors_["2020_tpose"]
			local var_73_5 = 0

			if var_73_5 < arg_70_1.time_ and arg_70_1.time_ <= var_73_5 + arg_73_0 and not isNil(var_73_4) and arg_70_1.var_.characterEffect2020_tpose == nil then
				arg_70_1.var_.characterEffect2020_tpose = var_73_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_73_6 = 0.1

			if var_73_5 <= arg_70_1.time_ and arg_70_1.time_ < var_73_5 + var_73_6 and not isNil(var_73_4) then
				local var_73_7 = (arg_70_1.time_ - var_73_5) / var_73_6

				if arg_70_1.var_.characterEffect2020_tpose and not isNil(var_73_4) then
					local var_73_8 = Mathf.Lerp(0, 0.5, var_73_7)

					arg_70_1.var_.characterEffect2020_tpose.fillFlat = true
					arg_70_1.var_.characterEffect2020_tpose.fillRatio = var_73_8
				end
			end

			if arg_70_1.time_ >= var_73_5 + var_73_6 and arg_70_1.time_ < var_73_5 + var_73_6 + arg_73_0 and not isNil(var_73_4) and arg_70_1.var_.characterEffect2020_tpose then
				local var_73_9 = 0.5

				arg_70_1.var_.characterEffect2020_tpose.fillFlat = true
				arg_70_1.var_.characterEffect2020_tpose.fillRatio = var_73_9
			end

			local var_73_10 = 0

			if var_73_10 < arg_70_1.time_ and arg_70_1.time_ <= var_73_10 + arg_73_0 then
				arg_70_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_73_11 = 0

			if var_73_11 < arg_70_1.time_ and arg_70_1.time_ <= var_73_11 + arg_73_0 then
				arg_70_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/story3008/story3008action/3008action6_2")
			end

			local var_73_12 = 0
			local var_73_13 = 0.55

			if var_73_12 < arg_70_1.time_ and arg_70_1.time_ <= var_73_12 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, true)

				local var_73_14 = arg_70_1:FormatText(StoryNameCfg[20].name)

				arg_70_1.leftNameTxt_.text = var_73_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_70_1.leftNameTxt_.transform)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1.leftNameTxt_.text)
				SetActive(arg_70_1.iconTrs_.gameObject, false)
				arg_70_1.callingController_:SetSelectedState("normal")

				local var_73_15 = arg_70_1:GetWordFromCfg(101061017)
				local var_73_16 = arg_70_1:FormatText(var_73_15.content)

				arg_70_1.text_.text = var_73_16

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_17 = 22
				local var_73_18 = utf8.len(var_73_16)
				local var_73_19 = var_73_17 <= 0 and var_73_13 or var_73_13 * (var_73_18 / var_73_17)

				if var_73_19 > 0 and var_73_13 < var_73_19 then
					arg_70_1.talkMaxDuration = var_73_19

					if var_73_19 + var_73_12 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_19 + var_73_12
					end
				end

				arg_70_1.text_.text = var_73_16
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101061", "101061017", "story_v_out_101061.awb") ~= 0 then
					local var_73_20 = manager.audio:GetVoiceLength("story_v_out_101061", "101061017", "story_v_out_101061.awb") / 1000

					if var_73_20 + var_73_12 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_20 + var_73_12
					end

					if var_73_15.prefab_name ~= "" and arg_70_1.actors_[var_73_15.prefab_name] ~= nil then
						local var_73_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_70_1.actors_[var_73_15.prefab_name].transform, "story_v_out_101061", "101061017", "story_v_out_101061.awb")

						arg_70_1:RecordAudio("101061017", var_73_21)
						arg_70_1:RecordAudio("101061017", var_73_21)
					else
						arg_70_1:AudioAction("play", "voice", "story_v_out_101061", "101061017", "story_v_out_101061.awb")
					end

					arg_70_1:RecordHistoryTalkVoice("story_v_out_101061", "101061017", "story_v_out_101061.awb")
				end

				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_22 = math.max(var_73_13, arg_70_1.talkMaxDuration)

			if var_73_12 <= arg_70_1.time_ and arg_70_1.time_ < var_73_12 + var_73_22 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_12) / var_73_22

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_12 + var_73_22 and arg_70_1.time_ < var_73_12 + var_73_22 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {}

		arg_70_1:InitPlayNodeList()
	end,
	Play101061018 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 101061018
		arg_74_1.duration_ = 2.83

		local var_74_0 = {
			ja = 2.566,
			ko = 2.166,
			zh = 2.833,
			en = 2.033
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
				arg_74_0:Play101061019(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			local var_77_0 = arg_74_1.actors_["2020_tpose"]
			local var_77_1 = 0

			if var_77_1 < arg_74_1.time_ and arg_74_1.time_ <= var_77_1 + arg_77_0 and not isNil(var_77_0) and arg_74_1.var_.characterEffect2020_tpose == nil then
				arg_74_1.var_.characterEffect2020_tpose = var_77_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_77_2 = 0.1

			if var_77_1 <= arg_74_1.time_ and arg_74_1.time_ < var_77_1 + var_77_2 and not isNil(var_77_0) then
				local var_77_3 = (arg_74_1.time_ - var_77_1) / var_77_2

				if arg_74_1.var_.characterEffect2020_tpose and not isNil(var_77_0) then
					arg_74_1.var_.characterEffect2020_tpose.fillFlat = false
				end
			end

			if arg_74_1.time_ >= var_77_1 + var_77_2 and arg_74_1.time_ < var_77_1 + var_77_2 + arg_77_0 and not isNil(var_77_0) and arg_74_1.var_.characterEffect2020_tpose then
				arg_74_1.var_.characterEffect2020_tpose.fillFlat = false
			end

			local var_77_4 = arg_74_1.actors_["3008ui_story"]
			local var_77_5 = 0

			if var_77_5 < arg_74_1.time_ and arg_74_1.time_ <= var_77_5 + arg_77_0 and not isNil(var_77_4) and arg_74_1.var_.characterEffect3008ui_story == nil then
				arg_74_1.var_.characterEffect3008ui_story = var_77_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_77_6 = 0.1

			if var_77_5 <= arg_74_1.time_ and arg_74_1.time_ < var_77_5 + var_77_6 and not isNil(var_77_4) then
				local var_77_7 = (arg_74_1.time_ - var_77_5) / var_77_6

				if arg_74_1.var_.characterEffect3008ui_story and not isNil(var_77_4) then
					local var_77_8 = Mathf.Lerp(0, 0.5, var_77_7)

					arg_74_1.var_.characterEffect3008ui_story.fillFlat = true
					arg_74_1.var_.characterEffect3008ui_story.fillRatio = var_77_8
				end
			end

			if arg_74_1.time_ >= var_77_5 + var_77_6 and arg_74_1.time_ < var_77_5 + var_77_6 + arg_77_0 and not isNil(var_77_4) and arg_74_1.var_.characterEffect3008ui_story then
				local var_77_9 = 0.5

				arg_74_1.var_.characterEffect3008ui_story.fillFlat = true
				arg_74_1.var_.characterEffect3008ui_story.fillRatio = var_77_9
			end

			local var_77_10 = 0
			local var_77_11 = 0.225

			if var_77_10 < arg_74_1.time_ and arg_74_1.time_ <= var_77_10 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, true)

				local var_77_12 = arg_74_1:FormatText(StoryNameCfg[34].name)

				arg_74_1.leftNameTxt_.text = var_77_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_74_1.leftNameTxt_.transform)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1.leftNameTxt_.text)
				SetActive(arg_74_1.iconTrs_.gameObject, false)
				arg_74_1.callingController_:SetSelectedState("normal")

				local var_77_13 = arg_74_1:GetWordFromCfg(101061018)
				local var_77_14 = arg_74_1:FormatText(var_77_13.content)

				arg_74_1.text_.text = var_77_14

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_15 = 9
				local var_77_16 = utf8.len(var_77_14)
				local var_77_17 = var_77_15 <= 0 and var_77_11 or var_77_11 * (var_77_16 / var_77_15)

				if var_77_17 > 0 and var_77_11 < var_77_17 then
					arg_74_1.talkMaxDuration = var_77_17

					if var_77_17 + var_77_10 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_17 + var_77_10
					end
				end

				arg_74_1.text_.text = var_77_14
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101061", "101061018", "story_v_out_101061.awb") ~= 0 then
					local var_77_18 = manager.audio:GetVoiceLength("story_v_out_101061", "101061018", "story_v_out_101061.awb") / 1000

					if var_77_18 + var_77_10 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_18 + var_77_10
					end

					if var_77_13.prefab_name ~= "" and arg_74_1.actors_[var_77_13.prefab_name] ~= nil then
						local var_77_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_74_1.actors_[var_77_13.prefab_name].transform, "story_v_out_101061", "101061018", "story_v_out_101061.awb")

						arg_74_1:RecordAudio("101061018", var_77_19)
						arg_74_1:RecordAudio("101061018", var_77_19)
					else
						arg_74_1:AudioAction("play", "voice", "story_v_out_101061", "101061018", "story_v_out_101061.awb")
					end

					arg_74_1:RecordHistoryTalkVoice("story_v_out_101061", "101061018", "story_v_out_101061.awb")
				end

				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_20 = math.max(var_77_11, arg_74_1.talkMaxDuration)

			if var_77_10 <= arg_74_1.time_ and arg_74_1.time_ < var_77_10 + var_77_20 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_10) / var_77_20

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_10 + var_77_20 and arg_74_1.time_ < var_77_10 + var_77_20 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {}

		arg_74_1:InitPlayNodeList()
	end,
	Play101061019 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 101061019
		arg_78_1.duration_ = 6.2

		local var_78_0 = {
			ja = 6.2,
			ko = 4.466,
			zh = 2.4,
			en = 3.2
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
				arg_78_0:Play101061020(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			local var_81_0 = arg_78_1.actors_["3008ui_story"]
			local var_81_1 = 0

			if var_81_1 < arg_78_1.time_ and arg_78_1.time_ <= var_81_1 + arg_81_0 and not isNil(var_81_0) and arg_78_1.var_.characterEffect3008ui_story == nil then
				arg_78_1.var_.characterEffect3008ui_story = var_81_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_81_2 = 0.1

			if var_81_1 <= arg_78_1.time_ and arg_78_1.time_ < var_81_1 + var_81_2 and not isNil(var_81_0) then
				local var_81_3 = (arg_78_1.time_ - var_81_1) / var_81_2

				if arg_78_1.var_.characterEffect3008ui_story and not isNil(var_81_0) then
					arg_78_1.var_.characterEffect3008ui_story.fillFlat = false
				end
			end

			if arg_78_1.time_ >= var_81_1 + var_81_2 and arg_78_1.time_ < var_81_1 + var_81_2 + arg_81_0 and not isNil(var_81_0) and arg_78_1.var_.characterEffect3008ui_story then
				arg_78_1.var_.characterEffect3008ui_story.fillFlat = false
			end

			local var_81_4 = arg_78_1.actors_["2020_tpose"]
			local var_81_5 = 0

			if var_81_5 < arg_78_1.time_ and arg_78_1.time_ <= var_81_5 + arg_81_0 and not isNil(var_81_4) and arg_78_1.var_.characterEffect2020_tpose == nil then
				arg_78_1.var_.characterEffect2020_tpose = var_81_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_81_6 = 0.1

			if var_81_5 <= arg_78_1.time_ and arg_78_1.time_ < var_81_5 + var_81_6 and not isNil(var_81_4) then
				local var_81_7 = (arg_78_1.time_ - var_81_5) / var_81_6

				if arg_78_1.var_.characterEffect2020_tpose and not isNil(var_81_4) then
					local var_81_8 = Mathf.Lerp(0, 0.5, var_81_7)

					arg_78_1.var_.characterEffect2020_tpose.fillFlat = true
					arg_78_1.var_.characterEffect2020_tpose.fillRatio = var_81_8
				end
			end

			if arg_78_1.time_ >= var_81_5 + var_81_6 and arg_78_1.time_ < var_81_5 + var_81_6 + arg_81_0 and not isNil(var_81_4) and arg_78_1.var_.characterEffect2020_tpose then
				local var_81_9 = 0.5

				arg_78_1.var_.characterEffect2020_tpose.fillFlat = true
				arg_78_1.var_.characterEffect2020_tpose.fillRatio = var_81_9
			end

			local var_81_10 = 0

			if var_81_10 < arg_78_1.time_ and arg_78_1.time_ <= var_81_10 + arg_81_0 then
				arg_78_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_81_11 = 0
			local var_81_12 = 0.325

			if var_81_11 < arg_78_1.time_ and arg_78_1.time_ <= var_81_11 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, true)

				local var_81_13 = arg_78_1:FormatText(StoryNameCfg[20].name)

				arg_78_1.leftNameTxt_.text = var_81_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_78_1.leftNameTxt_.transform)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1.leftNameTxt_.text)
				SetActive(arg_78_1.iconTrs_.gameObject, false)
				arg_78_1.callingController_:SetSelectedState("normal")

				local var_81_14 = arg_78_1:GetWordFromCfg(101061019)
				local var_81_15 = arg_78_1:FormatText(var_81_14.content)

				arg_78_1.text_.text = var_81_15

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_16 = 13
				local var_81_17 = utf8.len(var_81_15)
				local var_81_18 = var_81_16 <= 0 and var_81_12 or var_81_12 * (var_81_17 / var_81_16)

				if var_81_18 > 0 and var_81_12 < var_81_18 then
					arg_78_1.talkMaxDuration = var_81_18

					if var_81_18 + var_81_11 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_18 + var_81_11
					end
				end

				arg_78_1.text_.text = var_81_15
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101061", "101061019", "story_v_out_101061.awb") ~= 0 then
					local var_81_19 = manager.audio:GetVoiceLength("story_v_out_101061", "101061019", "story_v_out_101061.awb") / 1000

					if var_81_19 + var_81_11 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_19 + var_81_11
					end

					if var_81_14.prefab_name ~= "" and arg_78_1.actors_[var_81_14.prefab_name] ~= nil then
						local var_81_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_78_1.actors_[var_81_14.prefab_name].transform, "story_v_out_101061", "101061019", "story_v_out_101061.awb")

						arg_78_1:RecordAudio("101061019", var_81_20)
						arg_78_1:RecordAudio("101061019", var_81_20)
					else
						arg_78_1:AudioAction("play", "voice", "story_v_out_101061", "101061019", "story_v_out_101061.awb")
					end

					arg_78_1:RecordHistoryTalkVoice("story_v_out_101061", "101061019", "story_v_out_101061.awb")
				end

				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_21 = math.max(var_81_12, arg_78_1.talkMaxDuration)

			if var_81_11 <= arg_78_1.time_ and arg_78_1.time_ < var_81_11 + var_81_21 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_11) / var_81_21

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_11 + var_81_21 and arg_78_1.time_ < var_81_11 + var_81_21 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {}

		arg_78_1:InitPlayNodeList()
	end,
	Play101061020 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 101061020
		arg_82_1.duration_ = 4.97

		local var_82_0 = {
			ja = 4.966,
			ko = 1.733,
			zh = 2.5,
			en = 4.1
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
				arg_82_0:Play101061021(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			local var_85_0 = arg_82_1.actors_["2020_tpose"]
			local var_85_1 = 0

			if var_85_1 < arg_82_1.time_ and arg_82_1.time_ <= var_85_1 + arg_85_0 and not isNil(var_85_0) and arg_82_1.var_.characterEffect2020_tpose == nil then
				arg_82_1.var_.characterEffect2020_tpose = var_85_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_85_2 = 0.1

			if var_85_1 <= arg_82_1.time_ and arg_82_1.time_ < var_85_1 + var_85_2 and not isNil(var_85_0) then
				local var_85_3 = (arg_82_1.time_ - var_85_1) / var_85_2

				if arg_82_1.var_.characterEffect2020_tpose and not isNil(var_85_0) then
					arg_82_1.var_.characterEffect2020_tpose.fillFlat = false
				end
			end

			if arg_82_1.time_ >= var_85_1 + var_85_2 and arg_82_1.time_ < var_85_1 + var_85_2 + arg_85_0 and not isNil(var_85_0) and arg_82_1.var_.characterEffect2020_tpose then
				arg_82_1.var_.characterEffect2020_tpose.fillFlat = false
			end

			local var_85_4 = arg_82_1.actors_["3008ui_story"]
			local var_85_5 = 0

			if var_85_5 < arg_82_1.time_ and arg_82_1.time_ <= var_85_5 + arg_85_0 and not isNil(var_85_4) and arg_82_1.var_.characterEffect3008ui_story == nil then
				arg_82_1.var_.characterEffect3008ui_story = var_85_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_85_6 = 0.1

			if var_85_5 <= arg_82_1.time_ and arg_82_1.time_ < var_85_5 + var_85_6 and not isNil(var_85_4) then
				local var_85_7 = (arg_82_1.time_ - var_85_5) / var_85_6

				if arg_82_1.var_.characterEffect3008ui_story and not isNil(var_85_4) then
					local var_85_8 = Mathf.Lerp(0, 0.5, var_85_7)

					arg_82_1.var_.characterEffect3008ui_story.fillFlat = true
					arg_82_1.var_.characterEffect3008ui_story.fillRatio = var_85_8
				end
			end

			if arg_82_1.time_ >= var_85_5 + var_85_6 and arg_82_1.time_ < var_85_5 + var_85_6 + arg_85_0 and not isNil(var_85_4) and arg_82_1.var_.characterEffect3008ui_story then
				local var_85_9 = 0.5

				arg_82_1.var_.characterEffect3008ui_story.fillFlat = true
				arg_82_1.var_.characterEffect3008ui_story.fillRatio = var_85_9
			end

			local var_85_10 = 0
			local var_85_11 = 0.25

			if var_85_10 < arg_82_1.time_ and arg_82_1.time_ <= var_85_10 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				local var_85_12 = arg_82_1:FormatText(StoryNameCfg[34].name)

				arg_82_1.leftNameTxt_.text = var_85_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_13 = arg_82_1:GetWordFromCfg(101061020)
				local var_85_14 = arg_82_1:FormatText(var_85_13.content)

				arg_82_1.text_.text = var_85_14

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_15 = 10
				local var_85_16 = utf8.len(var_85_14)
				local var_85_17 = var_85_15 <= 0 and var_85_11 or var_85_11 * (var_85_16 / var_85_15)

				if var_85_17 > 0 and var_85_11 < var_85_17 then
					arg_82_1.talkMaxDuration = var_85_17

					if var_85_17 + var_85_10 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_17 + var_85_10
					end
				end

				arg_82_1.text_.text = var_85_14
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101061", "101061020", "story_v_out_101061.awb") ~= 0 then
					local var_85_18 = manager.audio:GetVoiceLength("story_v_out_101061", "101061020", "story_v_out_101061.awb") / 1000

					if var_85_18 + var_85_10 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_18 + var_85_10
					end

					if var_85_13.prefab_name ~= "" and arg_82_1.actors_[var_85_13.prefab_name] ~= nil then
						local var_85_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_82_1.actors_[var_85_13.prefab_name].transform, "story_v_out_101061", "101061020", "story_v_out_101061.awb")

						arg_82_1:RecordAudio("101061020", var_85_19)
						arg_82_1:RecordAudio("101061020", var_85_19)
					else
						arg_82_1:AudioAction("play", "voice", "story_v_out_101061", "101061020", "story_v_out_101061.awb")
					end

					arg_82_1:RecordHistoryTalkVoice("story_v_out_101061", "101061020", "story_v_out_101061.awb")
				end

				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_20 = math.max(var_85_11, arg_82_1.talkMaxDuration)

			if var_85_10 <= arg_82_1.time_ and arg_82_1.time_ < var_85_10 + var_85_20 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_10) / var_85_20

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_10 + var_85_20 and arg_82_1.time_ < var_85_10 + var_85_20 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {}

		arg_82_1:InitPlayNodeList()
	end,
	Play101061021 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 101061021
		arg_86_1.duration_ = 6.27

		local var_86_0 = {
			ja = 4.5,
			ko = 4.6,
			zh = 3.2,
			en = 6.266
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
				arg_86_0:Play101061022(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			local var_89_0 = arg_86_1.actors_["3008ui_story"]
			local var_89_1 = 0

			if var_89_1 < arg_86_1.time_ and arg_86_1.time_ <= var_89_1 + arg_89_0 and not isNil(var_89_0) and arg_86_1.var_.characterEffect3008ui_story == nil then
				arg_86_1.var_.characterEffect3008ui_story = var_89_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_89_2 = 0.1

			if var_89_1 <= arg_86_1.time_ and arg_86_1.time_ < var_89_1 + var_89_2 and not isNil(var_89_0) then
				local var_89_3 = (arg_86_1.time_ - var_89_1) / var_89_2

				if arg_86_1.var_.characterEffect3008ui_story and not isNil(var_89_0) then
					arg_86_1.var_.characterEffect3008ui_story.fillFlat = false
				end
			end

			if arg_86_1.time_ >= var_89_1 + var_89_2 and arg_86_1.time_ < var_89_1 + var_89_2 + arg_89_0 and not isNil(var_89_0) and arg_86_1.var_.characterEffect3008ui_story then
				arg_86_1.var_.characterEffect3008ui_story.fillFlat = false
			end

			local var_89_4 = arg_86_1.actors_["2020_tpose"]
			local var_89_5 = 0

			if var_89_5 < arg_86_1.time_ and arg_86_1.time_ <= var_89_5 + arg_89_0 and not isNil(var_89_4) and arg_86_1.var_.characterEffect2020_tpose == nil then
				arg_86_1.var_.characterEffect2020_tpose = var_89_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_89_6 = 0.1

			if var_89_5 <= arg_86_1.time_ and arg_86_1.time_ < var_89_5 + var_89_6 and not isNil(var_89_4) then
				local var_89_7 = (arg_86_1.time_ - var_89_5) / var_89_6

				if arg_86_1.var_.characterEffect2020_tpose and not isNil(var_89_4) then
					local var_89_8 = Mathf.Lerp(0, 0.5, var_89_7)

					arg_86_1.var_.characterEffect2020_tpose.fillFlat = true
					arg_86_1.var_.characterEffect2020_tpose.fillRatio = var_89_8
				end
			end

			if arg_86_1.time_ >= var_89_5 + var_89_6 and arg_86_1.time_ < var_89_5 + var_89_6 + arg_89_0 and not isNil(var_89_4) and arg_86_1.var_.characterEffect2020_tpose then
				local var_89_9 = 0.5

				arg_86_1.var_.characterEffect2020_tpose.fillFlat = true
				arg_86_1.var_.characterEffect2020_tpose.fillRatio = var_89_9
			end

			local var_89_10 = 0

			if var_89_10 < arg_86_1.time_ and arg_86_1.time_ <= var_89_10 + arg_89_0 then
				arg_86_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_89_11 = 0

			if var_89_11 < arg_86_1.time_ and arg_86_1.time_ <= var_89_11 + arg_89_0 then
				arg_86_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/story3008/story3008action/3008action2_1")
			end

			local var_89_12 = 0
			local var_89_13 = 0.375

			if var_89_12 < arg_86_1.time_ and arg_86_1.time_ <= var_89_12 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, true)

				local var_89_14 = arg_86_1:FormatText(StoryNameCfg[20].name)

				arg_86_1.leftNameTxt_.text = var_89_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_15 = arg_86_1:GetWordFromCfg(101061021)
				local var_89_16 = arg_86_1:FormatText(var_89_15.content)

				arg_86_1.text_.text = var_89_16

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_17 = 15
				local var_89_18 = utf8.len(var_89_16)
				local var_89_19 = var_89_17 <= 0 and var_89_13 or var_89_13 * (var_89_18 / var_89_17)

				if var_89_19 > 0 and var_89_13 < var_89_19 then
					arg_86_1.talkMaxDuration = var_89_19

					if var_89_19 + var_89_12 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_19 + var_89_12
					end
				end

				arg_86_1.text_.text = var_89_16
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101061", "101061021", "story_v_out_101061.awb") ~= 0 then
					local var_89_20 = manager.audio:GetVoiceLength("story_v_out_101061", "101061021", "story_v_out_101061.awb") / 1000

					if var_89_20 + var_89_12 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_20 + var_89_12
					end

					if var_89_15.prefab_name ~= "" and arg_86_1.actors_[var_89_15.prefab_name] ~= nil then
						local var_89_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_86_1.actors_[var_89_15.prefab_name].transform, "story_v_out_101061", "101061021", "story_v_out_101061.awb")

						arg_86_1:RecordAudio("101061021", var_89_21)
						arg_86_1:RecordAudio("101061021", var_89_21)
					else
						arg_86_1:AudioAction("play", "voice", "story_v_out_101061", "101061021", "story_v_out_101061.awb")
					end

					arg_86_1:RecordHistoryTalkVoice("story_v_out_101061", "101061021", "story_v_out_101061.awb")
				end

				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_22 = math.max(var_89_13, arg_86_1.talkMaxDuration)

			if var_89_12 <= arg_86_1.time_ and arg_86_1.time_ < var_89_12 + var_89_22 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_12) / var_89_22

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_12 + var_89_22 and arg_86_1.time_ < var_89_12 + var_89_22 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {}

		arg_86_1:InitPlayNodeList()
	end,
	Play101061022 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 101061022
		arg_90_1.duration_ = 7.23

		local var_90_0 = {
			ja = 7.233,
			ko = 5.766,
			zh = 5.7,
			en = 5.366
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
				arg_90_0:Play101061023(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			local var_93_0 = arg_90_1.actors_["2020_tpose"]
			local var_93_1 = 0

			if var_93_1 < arg_90_1.time_ and arg_90_1.time_ <= var_93_1 + arg_93_0 and not isNil(var_93_0) and arg_90_1.var_.characterEffect2020_tpose == nil then
				arg_90_1.var_.characterEffect2020_tpose = var_93_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_93_2 = 0.1

			if var_93_1 <= arg_90_1.time_ and arg_90_1.time_ < var_93_1 + var_93_2 and not isNil(var_93_0) then
				local var_93_3 = (arg_90_1.time_ - var_93_1) / var_93_2

				if arg_90_1.var_.characterEffect2020_tpose and not isNil(var_93_0) then
					arg_90_1.var_.characterEffect2020_tpose.fillFlat = false
				end
			end

			if arg_90_1.time_ >= var_93_1 + var_93_2 and arg_90_1.time_ < var_93_1 + var_93_2 + arg_93_0 and not isNil(var_93_0) and arg_90_1.var_.characterEffect2020_tpose then
				arg_90_1.var_.characterEffect2020_tpose.fillFlat = false
			end

			local var_93_4 = arg_90_1.actors_["3008ui_story"]
			local var_93_5 = 0

			if var_93_5 < arg_90_1.time_ and arg_90_1.time_ <= var_93_5 + arg_93_0 and not isNil(var_93_4) and arg_90_1.var_.characterEffect3008ui_story == nil then
				arg_90_1.var_.characterEffect3008ui_story = var_93_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_93_6 = 0.1

			if var_93_5 <= arg_90_1.time_ and arg_90_1.time_ < var_93_5 + var_93_6 and not isNil(var_93_4) then
				local var_93_7 = (arg_90_1.time_ - var_93_5) / var_93_6

				if arg_90_1.var_.characterEffect3008ui_story and not isNil(var_93_4) then
					local var_93_8 = Mathf.Lerp(0, 0.5, var_93_7)

					arg_90_1.var_.characterEffect3008ui_story.fillFlat = true
					arg_90_1.var_.characterEffect3008ui_story.fillRatio = var_93_8
				end
			end

			if arg_90_1.time_ >= var_93_5 + var_93_6 and arg_90_1.time_ < var_93_5 + var_93_6 + arg_93_0 and not isNil(var_93_4) and arg_90_1.var_.characterEffect3008ui_story then
				local var_93_9 = 0.5

				arg_90_1.var_.characterEffect3008ui_story.fillFlat = true
				arg_90_1.var_.characterEffect3008ui_story.fillRatio = var_93_9
			end

			local var_93_10 = 0
			local var_93_11 = 0.575

			if var_93_10 < arg_90_1.time_ and arg_90_1.time_ <= var_93_10 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				local var_93_12 = arg_90_1:FormatText(StoryNameCfg[34].name)

				arg_90_1.leftNameTxt_.text = var_93_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_13 = arg_90_1:GetWordFromCfg(101061022)
				local var_93_14 = arg_90_1:FormatText(var_93_13.content)

				arg_90_1.text_.text = var_93_14

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_15 = 23
				local var_93_16 = utf8.len(var_93_14)
				local var_93_17 = var_93_15 <= 0 and var_93_11 or var_93_11 * (var_93_16 / var_93_15)

				if var_93_17 > 0 and var_93_11 < var_93_17 then
					arg_90_1.talkMaxDuration = var_93_17

					if var_93_17 + var_93_10 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_17 + var_93_10
					end
				end

				arg_90_1.text_.text = var_93_14
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101061", "101061022", "story_v_out_101061.awb") ~= 0 then
					local var_93_18 = manager.audio:GetVoiceLength("story_v_out_101061", "101061022", "story_v_out_101061.awb") / 1000

					if var_93_18 + var_93_10 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_18 + var_93_10
					end

					if var_93_13.prefab_name ~= "" and arg_90_1.actors_[var_93_13.prefab_name] ~= nil then
						local var_93_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_90_1.actors_[var_93_13.prefab_name].transform, "story_v_out_101061", "101061022", "story_v_out_101061.awb")

						arg_90_1:RecordAudio("101061022", var_93_19)
						arg_90_1:RecordAudio("101061022", var_93_19)
					else
						arg_90_1:AudioAction("play", "voice", "story_v_out_101061", "101061022", "story_v_out_101061.awb")
					end

					arg_90_1:RecordHistoryTalkVoice("story_v_out_101061", "101061022", "story_v_out_101061.awb")
				end

				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_20 = math.max(var_93_11, arg_90_1.talkMaxDuration)

			if var_93_10 <= arg_90_1.time_ and arg_90_1.time_ < var_93_10 + var_93_20 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_10) / var_93_20

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_10 + var_93_20 and arg_90_1.time_ < var_93_10 + var_93_20 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {}

		arg_90_1:InitPlayNodeList()
	end,
	Play101061023 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 101061023
		arg_94_1.duration_ = 2

		SetActive(arg_94_1.tipsGo_, false)

		function arg_94_1.onSingleLineFinish_()
			arg_94_1.onSingleLineUpdate_ = nil
			arg_94_1.onSingleLineFinish_ = nil
			arg_94_1.state_ = "waiting"
		end

		function arg_94_1.playNext_(arg_96_0)
			if arg_96_0 == 1 then
				arg_94_0:Play101061024(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			local var_97_0 = arg_94_1.actors_["3008ui_story"]
			local var_97_1 = 0

			if var_97_1 < arg_94_1.time_ and arg_94_1.time_ <= var_97_1 + arg_97_0 and not isNil(var_97_0) and arg_94_1.var_.characterEffect3008ui_story == nil then
				arg_94_1.var_.characterEffect3008ui_story = var_97_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_97_2 = 0.1

			if var_97_1 <= arg_94_1.time_ and arg_94_1.time_ < var_97_1 + var_97_2 and not isNil(var_97_0) then
				local var_97_3 = (arg_94_1.time_ - var_97_1) / var_97_2

				if arg_94_1.var_.characterEffect3008ui_story and not isNil(var_97_0) then
					arg_94_1.var_.characterEffect3008ui_story.fillFlat = false
				end
			end

			if arg_94_1.time_ >= var_97_1 + var_97_2 and arg_94_1.time_ < var_97_1 + var_97_2 + arg_97_0 and not isNil(var_97_0) and arg_94_1.var_.characterEffect3008ui_story then
				arg_94_1.var_.characterEffect3008ui_story.fillFlat = false
			end

			local var_97_4 = arg_94_1.actors_["2020_tpose"]
			local var_97_5 = 0

			if var_97_5 < arg_94_1.time_ and arg_94_1.time_ <= var_97_5 + arg_97_0 and not isNil(var_97_4) and arg_94_1.var_.characterEffect2020_tpose == nil then
				arg_94_1.var_.characterEffect2020_tpose = var_97_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_97_6 = 0.1

			if var_97_5 <= arg_94_1.time_ and arg_94_1.time_ < var_97_5 + var_97_6 and not isNil(var_97_4) then
				local var_97_7 = (arg_94_1.time_ - var_97_5) / var_97_6

				if arg_94_1.var_.characterEffect2020_tpose and not isNil(var_97_4) then
					local var_97_8 = Mathf.Lerp(0, 0.5, var_97_7)

					arg_94_1.var_.characterEffect2020_tpose.fillFlat = true
					arg_94_1.var_.characterEffect2020_tpose.fillRatio = var_97_8
				end
			end

			if arg_94_1.time_ >= var_97_5 + var_97_6 and arg_94_1.time_ < var_97_5 + var_97_6 + arg_97_0 and not isNil(var_97_4) and arg_94_1.var_.characterEffect2020_tpose then
				local var_97_9 = 0.5

				arg_94_1.var_.characterEffect2020_tpose.fillFlat = true
				arg_94_1.var_.characterEffect2020_tpose.fillRatio = var_97_9
			end

			local var_97_10 = 0

			if var_97_10 < arg_94_1.time_ and arg_94_1.time_ <= var_97_10 + arg_97_0 then
				arg_94_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_97_11 = 0
			local var_97_12 = 0.1

			if var_97_11 < arg_94_1.time_ and arg_94_1.time_ <= var_97_11 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				local var_97_13 = arg_94_1:FormatText(StoryNameCfg[20].name)

				arg_94_1.leftNameTxt_.text = var_97_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_14 = arg_94_1:GetWordFromCfg(101061023)
				local var_97_15 = arg_94_1:FormatText(var_97_14.content)

				arg_94_1.text_.text = var_97_15

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_16 = 4
				local var_97_17 = utf8.len(var_97_15)
				local var_97_18 = var_97_16 <= 0 and var_97_12 or var_97_12 * (var_97_17 / var_97_16)

				if var_97_18 > 0 and var_97_12 < var_97_18 then
					arg_94_1.talkMaxDuration = var_97_18

					if var_97_18 + var_97_11 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_18 + var_97_11
					end
				end

				arg_94_1.text_.text = var_97_15
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101061", "101061023", "story_v_out_101061.awb") ~= 0 then
					local var_97_19 = manager.audio:GetVoiceLength("story_v_out_101061", "101061023", "story_v_out_101061.awb") / 1000

					if var_97_19 + var_97_11 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_19 + var_97_11
					end

					if var_97_14.prefab_name ~= "" and arg_94_1.actors_[var_97_14.prefab_name] ~= nil then
						local var_97_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_94_1.actors_[var_97_14.prefab_name].transform, "story_v_out_101061", "101061023", "story_v_out_101061.awb")

						arg_94_1:RecordAudio("101061023", var_97_20)
						arg_94_1:RecordAudio("101061023", var_97_20)
					else
						arg_94_1:AudioAction("play", "voice", "story_v_out_101061", "101061023", "story_v_out_101061.awb")
					end

					arg_94_1:RecordHistoryTalkVoice("story_v_out_101061", "101061023", "story_v_out_101061.awb")
				end

				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_21 = math.max(var_97_12, arg_94_1.talkMaxDuration)

			if var_97_11 <= arg_94_1.time_ and arg_94_1.time_ < var_97_11 + var_97_21 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_11) / var_97_21

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_11 + var_97_21 and arg_94_1.time_ < var_97_11 + var_97_21 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {}

		arg_94_1:InitPlayNodeList()
	end,
	Play101061024 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 101061024
		arg_98_1.duration_ = 12.9

		local var_98_0 = {
			ja = 12.9,
			ko = 8.133,
			zh = 10.833,
			en = 10.266
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
				arg_98_0:Play101061025(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			local var_101_0 = 0

			if var_101_0 < arg_98_1.time_ and arg_98_1.time_ <= var_101_0 + arg_101_0 then
				arg_98_1.mask_.enabled = true
				arg_98_1.mask_.raycastTarget = true

				arg_98_1:SetGaussion(false)
			end

			local var_101_1 = 2

			if var_101_0 <= arg_98_1.time_ and arg_98_1.time_ < var_101_0 + var_101_1 then
				local var_101_2 = (arg_98_1.time_ - var_101_0) / var_101_1
				local var_101_3 = Color.New(0, 0, 0)

				var_101_3.a = Mathf.Lerp(0, 1, var_101_2)
				arg_98_1.mask_.color = var_101_3
			end

			if arg_98_1.time_ >= var_101_0 + var_101_1 and arg_98_1.time_ < var_101_0 + var_101_1 + arg_101_0 then
				local var_101_4 = Color.New(0, 0, 0)

				var_101_4.a = 1
				arg_98_1.mask_.color = var_101_4
			end

			local var_101_5 = 2

			if var_101_5 < arg_98_1.time_ and arg_98_1.time_ <= var_101_5 + arg_101_0 then
				arg_98_1.mask_.enabled = true
				arg_98_1.mask_.raycastTarget = true

				arg_98_1:SetGaussion(false)
			end

			local var_101_6 = 2

			if var_101_5 <= arg_98_1.time_ and arg_98_1.time_ < var_101_5 + var_101_6 then
				local var_101_7 = (arg_98_1.time_ - var_101_5) / var_101_6
				local var_101_8 = Color.New(0, 0, 0)

				var_101_8.a = Mathf.Lerp(1, 0, var_101_7)
				arg_98_1.mask_.color = var_101_8
			end

			if arg_98_1.time_ >= var_101_5 + var_101_6 and arg_98_1.time_ < var_101_5 + var_101_6 + arg_101_0 then
				local var_101_9 = Color.New(0, 0, 0)
				local var_101_10 = 0

				arg_98_1.mask_.enabled = false
				var_101_9.a = var_101_10
				arg_98_1.mask_.color = var_101_9
			end

			local var_101_11 = "S0105"

			if arg_98_1.bgs_[var_101_11] == nil then
				local var_101_12 = Object.Instantiate(arg_98_1.paintGo_)

				var_101_12:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_101_11)
				var_101_12.name = var_101_11
				var_101_12.transform.parent = arg_98_1.stage_.transform
				var_101_12.transform.localPosition = Vector3.New(0, 100, 0)
				arg_98_1.bgs_[var_101_11] = var_101_12
			end

			local var_101_13 = 2

			if var_101_13 < arg_98_1.time_ and arg_98_1.time_ <= var_101_13 + arg_101_0 then
				local var_101_14 = manager.ui.mainCamera.transform.localPosition
				local var_101_15 = Vector3.New(0, 0, 10) + Vector3.New(var_101_14.x, var_101_14.y, 0)
				local var_101_16 = arg_98_1.bgs_.S0105

				var_101_16.transform.localPosition = var_101_15
				var_101_16.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_101_17 = var_101_16:GetComponent("SpriteRenderer")

				if var_101_17 and var_101_17.sprite then
					local var_101_18 = (var_101_16.transform.localPosition - var_101_14).z
					local var_101_19 = manager.ui.mainCameraCom_
					local var_101_20 = 2 * var_101_18 * Mathf.Tan(var_101_19.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_101_21 = var_101_20 * var_101_19.aspect
					local var_101_22 = var_101_17.sprite.bounds.size.x
					local var_101_23 = var_101_17.sprite.bounds.size.y
					local var_101_24 = var_101_21 / var_101_22
					local var_101_25 = var_101_20 / var_101_23
					local var_101_26 = var_101_25 < var_101_24 and var_101_24 or var_101_25

					var_101_16.transform.localScale = Vector3.New(var_101_26, var_101_26, 0)
				end

				for iter_101_0, iter_101_1 in pairs(arg_98_1.bgs_) do
					if iter_101_0 ~= "S0105" then
						iter_101_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_101_27 = arg_98_1.actors_["2020_tpose"].transform
			local var_101_28 = 1.967

			if var_101_28 < arg_98_1.time_ and arg_98_1.time_ <= var_101_28 + arg_101_0 then
				arg_98_1.var_.moveOldPos2020_tpose = var_101_27.localPosition

				local var_101_29 = GameObjectTools.GetOrAddComponent(var_101_27.gameObject, typeof(DynamicBoneHelper))

				if var_101_29 then
					var_101_29:EnableDynamicBone(false)
				end
			end

			local var_101_30 = 0.001

			if var_101_28 <= arg_98_1.time_ and arg_98_1.time_ < var_101_28 + var_101_30 then
				local var_101_31 = (arg_98_1.time_ - var_101_28) / var_101_30
				local var_101_32 = Vector3.New(0, 100, 0)

				var_101_27.localPosition = Vector3.Lerp(arg_98_1.var_.moveOldPos2020_tpose, var_101_32, var_101_31)

				local var_101_33 = manager.ui.mainCamera.transform.position - var_101_27.position

				var_101_27.forward = Vector3.New(var_101_33.x, var_101_33.y, var_101_33.z)

				local var_101_34 = var_101_27.localEulerAngles

				var_101_34.z = 0
				var_101_34.x = 0
				var_101_27.localEulerAngles = var_101_34
			end

			if arg_98_1.time_ >= var_101_28 + var_101_30 and arg_98_1.time_ < var_101_28 + var_101_30 + arg_101_0 then
				var_101_27.localPosition = Vector3.New(0, 100, 0)

				local var_101_35 = manager.ui.mainCamera.transform.position - var_101_27.position

				var_101_27.forward = Vector3.New(var_101_35.x, var_101_35.y, var_101_35.z)

				local var_101_36 = var_101_27.localEulerAngles

				var_101_36.z = 0
				var_101_36.x = 0
				var_101_27.localEulerAngles = var_101_36

				local var_101_37 = GameObjectTools.GetOrAddComponent(var_101_27.gameObject, typeof(DynamicBoneHelper))

				if var_101_37 then
					var_101_37:EnableDynamicBone(true)
				end
			end

			local var_101_38 = arg_98_1.actors_["3008ui_story"].transform
			local var_101_39 = 1.967

			if var_101_39 < arg_98_1.time_ and arg_98_1.time_ <= var_101_39 + arg_101_0 then
				arg_98_1.var_.moveOldPos3008ui_story = var_101_38.localPosition
			end

			local var_101_40 = 0.001

			if var_101_39 <= arg_98_1.time_ and arg_98_1.time_ < var_101_39 + var_101_40 then
				local var_101_41 = (arg_98_1.time_ - var_101_39) / var_101_40
				local var_101_42 = Vector3.New(0, 100, 0)

				var_101_38.localPosition = Vector3.Lerp(arg_98_1.var_.moveOldPos3008ui_story, var_101_42, var_101_41)

				local var_101_43 = manager.ui.mainCamera.transform.position - var_101_38.position

				var_101_38.forward = Vector3.New(var_101_43.x, var_101_43.y, var_101_43.z)

				local var_101_44 = var_101_38.localEulerAngles

				var_101_44.z = 0
				var_101_44.x = 0
				var_101_38.localEulerAngles = var_101_44
			end

			if arg_98_1.time_ >= var_101_39 + var_101_40 and arg_98_1.time_ < var_101_39 + var_101_40 + arg_101_0 then
				var_101_38.localPosition = Vector3.New(0, 100, 0)

				local var_101_45 = manager.ui.mainCamera.transform.position - var_101_38.position

				var_101_38.forward = Vector3.New(var_101_45.x, var_101_45.y, var_101_45.z)

				local var_101_46 = var_101_38.localEulerAngles

				var_101_46.z = 0
				var_101_46.x = 0
				var_101_38.localEulerAngles = var_101_46
			end

			if arg_98_1.frameCnt_ <= 1 then
				arg_98_1.dialog_:SetActive(false)
			end

			local var_101_47 = 4
			local var_101_48 = 0.5

			if var_101_47 < arg_98_1.time_ and arg_98_1.time_ <= var_101_47 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0

				arg_98_1.dialog_:SetActive(true)

				arg_98_1.dialogCg_.alpha = 0

				local var_101_49 = LeanTween.value(arg_98_1.dialog_, 0, 1, 0.3)

				var_101_49:setOnUpdate(LuaHelper.FloatAction(function(arg_102_0)
					arg_98_1.dialogCg_.alpha = arg_102_0
				end))
				var_101_49:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_98_1.dialog_)
					var_101_49:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_98_1.duration_ = arg_98_1.duration_ + 0.3

				SetActive(arg_98_1.leftNameGo_, true)

				local var_101_50 = arg_98_1:FormatText(StoryNameCfg[35].name)

				arg_98_1.leftNameTxt_.text = var_101_50

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_51 = arg_98_1:GetWordFromCfg(101061024)
				local var_101_52 = arg_98_1:FormatText(var_101_51.content)

				arg_98_1.text_.text = var_101_52

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_53 = 20
				local var_101_54 = utf8.len(var_101_52)
				local var_101_55 = var_101_53 <= 0 and var_101_48 or var_101_48 * (var_101_54 / var_101_53)

				if var_101_55 > 0 and var_101_48 < var_101_55 then
					arg_98_1.talkMaxDuration = var_101_55
					var_101_47 = var_101_47 + 0.3

					if var_101_55 + var_101_47 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_55 + var_101_47
					end
				end

				arg_98_1.text_.text = var_101_52
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101061", "101061024", "story_v_out_101061.awb") ~= 0 then
					local var_101_56 = manager.audio:GetVoiceLength("story_v_out_101061", "101061024", "story_v_out_101061.awb") / 1000

					if var_101_56 + var_101_47 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_56 + var_101_47
					end

					if var_101_51.prefab_name ~= "" and arg_98_1.actors_[var_101_51.prefab_name] ~= nil then
						local var_101_57 = LuaForUtil.PlayVoiceWithCriLipsync(arg_98_1.actors_[var_101_51.prefab_name].transform, "story_v_out_101061", "101061024", "story_v_out_101061.awb")

						arg_98_1:RecordAudio("101061024", var_101_57)
						arg_98_1:RecordAudio("101061024", var_101_57)
					else
						arg_98_1:AudioAction("play", "voice", "story_v_out_101061", "101061024", "story_v_out_101061.awb")
					end

					arg_98_1:RecordHistoryTalkVoice("story_v_out_101061", "101061024", "story_v_out_101061.awb")
				end

				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_58 = var_101_47 + 0.3
			local var_101_59 = math.max(var_101_48, arg_98_1.talkMaxDuration)

			if var_101_58 <= arg_98_1.time_ and arg_98_1.time_ < var_101_58 + var_101_59 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_58) / var_101_59

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_58 + var_101_59 and arg_98_1.time_ < var_101_58 + var_101_59 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2020_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 1.967,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "3008ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 1.967,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_98_1:InitPlayNodeList()
	end,
	Play101061025 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 101061025
		arg_104_1.duration_ = 7.6

		local var_104_0 = {
			ja = 4.133,
			ko = 7.6,
			zh = 5.466,
			en = 5.4
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
				arg_104_0:Play101061026(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			local var_107_0 = 0
			local var_107_1 = 0.55

			if var_107_0 < arg_104_1.time_ and arg_104_1.time_ <= var_107_0 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				local var_107_2 = arg_104_1:FormatText(StoryNameCfg[35].name)

				arg_104_1.leftNameTxt_.text = var_107_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_3 = arg_104_1:GetWordFromCfg(101061025)
				local var_107_4 = arg_104_1:FormatText(var_107_3.content)

				arg_104_1.text_.text = var_107_4

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_5 = 22
				local var_107_6 = utf8.len(var_107_4)
				local var_107_7 = var_107_5 <= 0 and var_107_1 or var_107_1 * (var_107_6 / var_107_5)

				if var_107_7 > 0 and var_107_1 < var_107_7 then
					arg_104_1.talkMaxDuration = var_107_7

					if var_107_7 + var_107_0 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_7 + var_107_0
					end
				end

				arg_104_1.text_.text = var_107_4
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101061", "101061025", "story_v_out_101061.awb") ~= 0 then
					local var_107_8 = manager.audio:GetVoiceLength("story_v_out_101061", "101061025", "story_v_out_101061.awb") / 1000

					if var_107_8 + var_107_0 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_8 + var_107_0
					end

					if var_107_3.prefab_name ~= "" and arg_104_1.actors_[var_107_3.prefab_name] ~= nil then
						local var_107_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_104_1.actors_[var_107_3.prefab_name].transform, "story_v_out_101061", "101061025", "story_v_out_101061.awb")

						arg_104_1:RecordAudio("101061025", var_107_9)
						arg_104_1:RecordAudio("101061025", var_107_9)
					else
						arg_104_1:AudioAction("play", "voice", "story_v_out_101061", "101061025", "story_v_out_101061.awb")
					end

					arg_104_1:RecordHistoryTalkVoice("story_v_out_101061", "101061025", "story_v_out_101061.awb")
				end

				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_10 = math.max(var_107_1, arg_104_1.talkMaxDuration)

			if var_107_0 <= arg_104_1.time_ and arg_104_1.time_ < var_107_0 + var_107_10 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_0) / var_107_10

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_0 + var_107_10 and arg_104_1.time_ < var_107_0 + var_107_10 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {}

		arg_104_1:InitPlayNodeList()
	end,
	Play101061026 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 101061026
		arg_108_1.duration_ = 10.2

		local var_108_0 = {
			ja = 9.233,
			ko = 7.3,
			zh = 6.533,
			en = 10.2
		}
		local var_108_1 = manager.audio:GetLocalizationFlag()

		if var_108_0[var_108_1] ~= nil then
			arg_108_1.duration_ = var_108_0[var_108_1]
		end

		SetActive(arg_108_1.tipsGo_, false)

		function arg_108_1.onSingleLineFinish_()
			arg_108_1.onSingleLineUpdate_ = nil
			arg_108_1.onSingleLineFinish_ = nil
			arg_108_1.state_ = "waiting"
		end

		function arg_108_1.playNext_(arg_110_0)
			if arg_110_0 == 1 then
				arg_108_0:Play101061027(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			local var_111_0 = 0
			local var_111_1 = 0.825

			if var_111_0 < arg_108_1.time_ and arg_108_1.time_ <= var_111_0 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				local var_111_2 = arg_108_1:FormatText(StoryNameCfg[34].name)

				arg_108_1.leftNameTxt_.text = var_111_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, true)
				arg_108_1.iconController_:SetSelectedState("hero")

				arg_108_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_20301")

				arg_108_1.callingController_:SetSelectedState("normal")

				arg_108_1.keyicon_.color = Color.New(1, 1, 1)
				arg_108_1.icon_.color = Color.New(1, 1, 1)

				local var_111_3 = arg_108_1:GetWordFromCfg(101061026)
				local var_111_4 = arg_108_1:FormatText(var_111_3.content)

				arg_108_1.text_.text = var_111_4

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_5 = 33
				local var_111_6 = utf8.len(var_111_4)
				local var_111_7 = var_111_5 <= 0 and var_111_1 or var_111_1 * (var_111_6 / var_111_5)

				if var_111_7 > 0 and var_111_1 < var_111_7 then
					arg_108_1.talkMaxDuration = var_111_7

					if var_111_7 + var_111_0 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_7 + var_111_0
					end
				end

				arg_108_1.text_.text = var_111_4
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101061", "101061026", "story_v_out_101061.awb") ~= 0 then
					local var_111_8 = manager.audio:GetVoiceLength("story_v_out_101061", "101061026", "story_v_out_101061.awb") / 1000

					if var_111_8 + var_111_0 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_8 + var_111_0
					end

					if var_111_3.prefab_name ~= "" and arg_108_1.actors_[var_111_3.prefab_name] ~= nil then
						local var_111_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_108_1.actors_[var_111_3.prefab_name].transform, "story_v_out_101061", "101061026", "story_v_out_101061.awb")

						arg_108_1:RecordAudio("101061026", var_111_9)
						arg_108_1:RecordAudio("101061026", var_111_9)
					else
						arg_108_1:AudioAction("play", "voice", "story_v_out_101061", "101061026", "story_v_out_101061.awb")
					end

					arg_108_1:RecordHistoryTalkVoice("story_v_out_101061", "101061026", "story_v_out_101061.awb")
				end

				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_10 = math.max(var_111_1, arg_108_1.talkMaxDuration)

			if var_111_0 <= arg_108_1.time_ and arg_108_1.time_ < var_111_0 + var_111_10 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_0) / var_111_10

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_0 + var_111_10 and arg_108_1.time_ < var_111_0 + var_111_10 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {}

		arg_108_1:InitPlayNodeList()
	end,
	Play101061027 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 101061027
		arg_112_1.duration_ = 8.47

		local var_112_0 = {
			ja = 4.366,
			ko = 6.5,
			zh = 5.9,
			en = 8.466
		}
		local var_112_1 = manager.audio:GetLocalizationFlag()

		if var_112_0[var_112_1] ~= nil then
			arg_112_1.duration_ = var_112_0[var_112_1]
		end

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
		end

		function arg_112_1.playNext_(arg_114_0)
			if arg_114_0 == 1 then
				arg_112_0:Play101061028(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			local var_115_0 = 0
			local var_115_1 = 0.675

			if var_115_0 < arg_112_1.time_ and arg_112_1.time_ <= var_115_0 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				local var_115_2 = arg_112_1:FormatText(StoryNameCfg[34].name)

				arg_112_1.leftNameTxt_.text = var_115_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, true)
				arg_112_1.iconController_:SetSelectedState("hero")

				arg_112_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_20302")

				arg_112_1.callingController_:SetSelectedState("normal")

				arg_112_1.keyicon_.color = Color.New(1, 1, 1)
				arg_112_1.icon_.color = Color.New(1, 1, 1)

				local var_115_3 = arg_112_1:GetWordFromCfg(101061027)
				local var_115_4 = arg_112_1:FormatText(var_115_3.content)

				arg_112_1.text_.text = var_115_4

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_5 = 27
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

				if manager.audio:GetVoiceLength("story_v_out_101061", "101061027", "story_v_out_101061.awb") ~= 0 then
					local var_115_8 = manager.audio:GetVoiceLength("story_v_out_101061", "101061027", "story_v_out_101061.awb") / 1000

					if var_115_8 + var_115_0 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_8 + var_115_0
					end

					if var_115_3.prefab_name ~= "" and arg_112_1.actors_[var_115_3.prefab_name] ~= nil then
						local var_115_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_3.prefab_name].transform, "story_v_out_101061", "101061027", "story_v_out_101061.awb")

						arg_112_1:RecordAudio("101061027", var_115_9)
						arg_112_1:RecordAudio("101061027", var_115_9)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_out_101061", "101061027", "story_v_out_101061.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_out_101061", "101061027", "story_v_out_101061.awb")
				end

				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_10 = math.max(var_115_1, arg_112_1.talkMaxDuration)

			if var_115_0 <= arg_112_1.time_ and arg_112_1.time_ < var_115_0 + var_115_10 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_0) / var_115_10

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_0 + var_115_10 and arg_112_1.time_ < var_115_0 + var_115_10 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {}

		arg_112_1:InitPlayNodeList()
	end,
	Play101061028 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 101061028
		arg_116_1.duration_ = 3.3

		local var_116_0 = {
			ja = 3.3,
			ko = 1.133,
			zh = 1.2,
			en = 1.533
		}
		local var_116_1 = manager.audio:GetLocalizationFlag()

		if var_116_0[var_116_1] ~= nil then
			arg_116_1.duration_ = var_116_0[var_116_1]
		end

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play101061029(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			local var_119_0 = 0
			local var_119_1 = 0.125

			if var_119_0 < arg_116_1.time_ and arg_116_1.time_ <= var_119_0 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				local var_119_2 = arg_116_1:FormatText(StoryNameCfg[20].name)

				arg_116_1.leftNameTxt_.text = var_119_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, true)
				arg_116_1.iconController_:SetSelectedState("hero")

				arg_116_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3008")

				arg_116_1.callingController_:SetSelectedState("normal")

				arg_116_1.keyicon_.color = Color.New(1, 1, 1)
				arg_116_1.icon_.color = Color.New(1, 1, 1)

				local var_119_3 = arg_116_1:GetWordFromCfg(101061028)
				local var_119_4 = arg_116_1:FormatText(var_119_3.content)

				arg_116_1.text_.text = var_119_4

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_5 = 5
				local var_119_6 = utf8.len(var_119_4)
				local var_119_7 = var_119_5 <= 0 and var_119_1 or var_119_1 * (var_119_6 / var_119_5)

				if var_119_7 > 0 and var_119_1 < var_119_7 then
					arg_116_1.talkMaxDuration = var_119_7

					if var_119_7 + var_119_0 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_7 + var_119_0
					end
				end

				arg_116_1.text_.text = var_119_4
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101061", "101061028", "story_v_out_101061.awb") ~= 0 then
					local var_119_8 = manager.audio:GetVoiceLength("story_v_out_101061", "101061028", "story_v_out_101061.awb") / 1000

					if var_119_8 + var_119_0 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_8 + var_119_0
					end

					if var_119_3.prefab_name ~= "" and arg_116_1.actors_[var_119_3.prefab_name] ~= nil then
						local var_119_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_116_1.actors_[var_119_3.prefab_name].transform, "story_v_out_101061", "101061028", "story_v_out_101061.awb")

						arg_116_1:RecordAudio("101061028", var_119_9)
						arg_116_1:RecordAudio("101061028", var_119_9)
					else
						arg_116_1:AudioAction("play", "voice", "story_v_out_101061", "101061028", "story_v_out_101061.awb")
					end

					arg_116_1:RecordHistoryTalkVoice("story_v_out_101061", "101061028", "story_v_out_101061.awb")
				end

				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_10 = math.max(var_119_1, arg_116_1.talkMaxDuration)

			if var_119_0 <= arg_116_1.time_ and arg_116_1.time_ < var_119_0 + var_119_10 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_0) / var_119_10

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_0 + var_119_10 and arg_116_1.time_ < var_119_0 + var_119_10 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {}

		arg_116_1:InitPlayNodeList()
	end,
	Play101061029 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 101061029
		arg_120_1.duration_ = 5

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"
		end

		function arg_120_1.playNext_(arg_122_0)
			if arg_122_0 == 1 then
				arg_120_0:Play101061030(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			local var_123_0 = 0
			local var_123_1 = 0.525

			if var_123_0 < arg_120_1.time_ and arg_120_1.time_ <= var_123_0 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, false)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_2 = arg_120_1:GetWordFromCfg(101061029)
				local var_123_3 = arg_120_1:FormatText(var_123_2.content)

				arg_120_1.text_.text = var_123_3

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_4 = 21
				local var_123_5 = utf8.len(var_123_3)
				local var_123_6 = var_123_4 <= 0 and var_123_1 or var_123_1 * (var_123_5 / var_123_4)

				if var_123_6 > 0 and var_123_1 < var_123_6 then
					arg_120_1.talkMaxDuration = var_123_6

					if var_123_6 + var_123_0 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_6 + var_123_0
					end
				end

				arg_120_1.text_.text = var_123_3
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)
				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_7 = math.max(var_123_1, arg_120_1.talkMaxDuration)

			if var_123_0 <= arg_120_1.time_ and arg_120_1.time_ < var_123_0 + var_123_7 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_0) / var_123_7

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_0 + var_123_7 and arg_120_1.time_ < var_123_0 + var_123_7 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {}

		arg_120_1:InitPlayNodeList()
	end,
	Play101061030 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 101061030
		arg_124_1.duration_ = 8

		local var_124_0 = {
			ja = 8,
			ko = 5,
			zh = 5.1,
			en = 5.7
		}
		local var_124_1 = manager.audio:GetLocalizationFlag()

		if var_124_0[var_124_1] ~= nil then
			arg_124_1.duration_ = var_124_0[var_124_1]
		end

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play101061031(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			local var_127_0 = 0
			local var_127_1 = 0.65

			if var_127_0 < arg_124_1.time_ and arg_124_1.time_ <= var_127_0 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				local var_127_2 = arg_124_1:FormatText(StoryNameCfg[20].name)

				arg_124_1.leftNameTxt_.text = var_127_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, true)
				arg_124_1.iconController_:SetSelectedState("hero")

				arg_124_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3008")

				arg_124_1.callingController_:SetSelectedState("normal")

				arg_124_1.keyicon_.color = Color.New(1, 1, 1)
				arg_124_1.icon_.color = Color.New(1, 1, 1)

				local var_127_3 = arg_124_1:GetWordFromCfg(101061030)
				local var_127_4 = arg_124_1:FormatText(var_127_3.content)

				arg_124_1.text_.text = var_127_4

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_5 = 26
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

				if manager.audio:GetVoiceLength("story_v_out_101061", "101061030", "story_v_out_101061.awb") ~= 0 then
					local var_127_8 = manager.audio:GetVoiceLength("story_v_out_101061", "101061030", "story_v_out_101061.awb") / 1000

					if var_127_8 + var_127_0 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_8 + var_127_0
					end

					if var_127_3.prefab_name ~= "" and arg_124_1.actors_[var_127_3.prefab_name] ~= nil then
						local var_127_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_124_1.actors_[var_127_3.prefab_name].transform, "story_v_out_101061", "101061030", "story_v_out_101061.awb")

						arg_124_1:RecordAudio("101061030", var_127_9)
						arg_124_1:RecordAudio("101061030", var_127_9)
					else
						arg_124_1:AudioAction("play", "voice", "story_v_out_101061", "101061030", "story_v_out_101061.awb")
					end

					arg_124_1:RecordHistoryTalkVoice("story_v_out_101061", "101061030", "story_v_out_101061.awb")
				end

				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_10 = math.max(var_127_1, arg_124_1.talkMaxDuration)

			if var_127_0 <= arg_124_1.time_ and arg_124_1.time_ < var_127_0 + var_127_10 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_0) / var_127_10

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_0 + var_127_10 and arg_124_1.time_ < var_127_0 + var_127_10 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {}

		arg_124_1:InitPlayNodeList()
	end,
	Play101061031 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 101061031
		arg_128_1.duration_ = 5.7

		local var_128_0 = {
			ja = 5.7,
			ko = 2.666,
			zh = 2.2,
			en = 3.066
		}
		local var_128_1 = manager.audio:GetLocalizationFlag()

		if var_128_0[var_128_1] ~= nil then
			arg_128_1.duration_ = var_128_0[var_128_1]
		end

		SetActive(arg_128_1.tipsGo_, false)

		function arg_128_1.onSingleLineFinish_()
			arg_128_1.onSingleLineUpdate_ = nil
			arg_128_1.onSingleLineFinish_ = nil
			arg_128_1.state_ = "waiting"
		end

		function arg_128_1.playNext_(arg_130_0)
			if arg_130_0 == 1 then
				arg_128_0:Play101061032(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			local var_131_0 = 0
			local var_131_1 = 0.25

			if var_131_0 < arg_128_1.time_ and arg_128_1.time_ <= var_131_0 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				local var_131_2 = arg_128_1:FormatText(StoryNameCfg[20].name)

				arg_128_1.leftNameTxt_.text = var_131_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, true)
				arg_128_1.iconController_:SetSelectedState("hero")

				arg_128_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3008")

				arg_128_1.callingController_:SetSelectedState("normal")

				arg_128_1.keyicon_.color = Color.New(1, 1, 1)
				arg_128_1.icon_.color = Color.New(1, 1, 1)

				local var_131_3 = arg_128_1:GetWordFromCfg(101061031)
				local var_131_4 = arg_128_1:FormatText(var_131_3.content)

				arg_128_1.text_.text = var_131_4

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_5 = 10
				local var_131_6 = utf8.len(var_131_4)
				local var_131_7 = var_131_5 <= 0 and var_131_1 or var_131_1 * (var_131_6 / var_131_5)

				if var_131_7 > 0 and var_131_1 < var_131_7 then
					arg_128_1.talkMaxDuration = var_131_7

					if var_131_7 + var_131_0 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_7 + var_131_0
					end
				end

				arg_128_1.text_.text = var_131_4
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101061", "101061031", "story_v_out_101061.awb") ~= 0 then
					local var_131_8 = manager.audio:GetVoiceLength("story_v_out_101061", "101061031", "story_v_out_101061.awb") / 1000

					if var_131_8 + var_131_0 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_8 + var_131_0
					end

					if var_131_3.prefab_name ~= "" and arg_128_1.actors_[var_131_3.prefab_name] ~= nil then
						local var_131_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_3.prefab_name].transform, "story_v_out_101061", "101061031", "story_v_out_101061.awb")

						arg_128_1:RecordAudio("101061031", var_131_9)
						arg_128_1:RecordAudio("101061031", var_131_9)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_out_101061", "101061031", "story_v_out_101061.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_out_101061", "101061031", "story_v_out_101061.awb")
				end

				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_10 = math.max(var_131_1, arg_128_1.talkMaxDuration)

			if var_131_0 <= arg_128_1.time_ and arg_128_1.time_ < var_131_0 + var_131_10 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_0) / var_131_10

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_0 + var_131_10 and arg_128_1.time_ < var_131_0 + var_131_10 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {}

		arg_128_1:InitPlayNodeList()
	end,
	Play101061032 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 101061032
		arg_132_1.duration_ = 8.57

		local var_132_0 = {
			ja = 8.566,
			ko = 3.633,
			zh = 4.033,
			en = 2.7
		}
		local var_132_1 = manager.audio:GetLocalizationFlag()

		if var_132_0[var_132_1] ~= nil then
			arg_132_1.duration_ = var_132_0[var_132_1]
		end

		SetActive(arg_132_1.tipsGo_, false)

		function arg_132_1.onSingleLineFinish_()
			arg_132_1.onSingleLineUpdate_ = nil
			arg_132_1.onSingleLineFinish_ = nil
			arg_132_1.state_ = "waiting"
		end

		function arg_132_1.playNext_(arg_134_0)
			if arg_134_0 == 1 then
				arg_132_0:Play101061033(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			local var_135_0 = 0
			local var_135_1 = 0.4

			if var_135_0 < arg_132_1.time_ and arg_132_1.time_ <= var_135_0 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				local var_135_2 = arg_132_1:FormatText(StoryNameCfg[35].name)

				arg_132_1.leftNameTxt_.text = var_135_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_3 = arg_132_1:GetWordFromCfg(101061032)
				local var_135_4 = arg_132_1:FormatText(var_135_3.content)

				arg_132_1.text_.text = var_135_4

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_5 = 16
				local var_135_6 = utf8.len(var_135_4)
				local var_135_7 = var_135_5 <= 0 and var_135_1 or var_135_1 * (var_135_6 / var_135_5)

				if var_135_7 > 0 and var_135_1 < var_135_7 then
					arg_132_1.talkMaxDuration = var_135_7

					if var_135_7 + var_135_0 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_7 + var_135_0
					end
				end

				arg_132_1.text_.text = var_135_4
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101061", "101061032", "story_v_out_101061.awb") ~= 0 then
					local var_135_8 = manager.audio:GetVoiceLength("story_v_out_101061", "101061032", "story_v_out_101061.awb") / 1000

					if var_135_8 + var_135_0 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_8 + var_135_0
					end

					if var_135_3.prefab_name ~= "" and arg_132_1.actors_[var_135_3.prefab_name] ~= nil then
						local var_135_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_3.prefab_name].transform, "story_v_out_101061", "101061032", "story_v_out_101061.awb")

						arg_132_1:RecordAudio("101061032", var_135_9)
						arg_132_1:RecordAudio("101061032", var_135_9)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_out_101061", "101061032", "story_v_out_101061.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_out_101061", "101061032", "story_v_out_101061.awb")
				end

				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_10 = math.max(var_135_1, arg_132_1.talkMaxDuration)

			if var_135_0 <= arg_132_1.time_ and arg_132_1.time_ < var_135_0 + var_135_10 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_0) / var_135_10

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_0 + var_135_10 and arg_132_1.time_ < var_135_0 + var_135_10 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {}

		arg_132_1:InitPlayNodeList()
	end,
	Play101061033 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 101061033
		arg_136_1.duration_ = 9.6

		local var_136_0 = {
			ja = 7.1,
			ko = 9.6,
			zh = 8,
			en = 8.533
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
				arg_136_0:Play101061034(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			local var_139_0 = 0
			local var_139_1 = 1.025

			if var_139_0 < arg_136_1.time_ and arg_136_1.time_ <= var_139_0 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				local var_139_2 = arg_136_1:FormatText(StoryNameCfg[35].name)

				arg_136_1.leftNameTxt_.text = var_139_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_3 = arg_136_1:GetWordFromCfg(101061033)
				local var_139_4 = arg_136_1:FormatText(var_139_3.content)

				arg_136_1.text_.text = var_139_4

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_5 = 41
				local var_139_6 = utf8.len(var_139_4)
				local var_139_7 = var_139_5 <= 0 and var_139_1 or var_139_1 * (var_139_6 / var_139_5)

				if var_139_7 > 0 and var_139_1 < var_139_7 then
					arg_136_1.talkMaxDuration = var_139_7

					if var_139_7 + var_139_0 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_7 + var_139_0
					end
				end

				arg_136_1.text_.text = var_139_4
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101061", "101061033", "story_v_out_101061.awb") ~= 0 then
					local var_139_8 = manager.audio:GetVoiceLength("story_v_out_101061", "101061033", "story_v_out_101061.awb") / 1000

					if var_139_8 + var_139_0 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_8 + var_139_0
					end

					if var_139_3.prefab_name ~= "" and arg_136_1.actors_[var_139_3.prefab_name] ~= nil then
						local var_139_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_136_1.actors_[var_139_3.prefab_name].transform, "story_v_out_101061", "101061033", "story_v_out_101061.awb")

						arg_136_1:RecordAudio("101061033", var_139_9)
						arg_136_1:RecordAudio("101061033", var_139_9)
					else
						arg_136_1:AudioAction("play", "voice", "story_v_out_101061", "101061033", "story_v_out_101061.awb")
					end

					arg_136_1:RecordHistoryTalkVoice("story_v_out_101061", "101061033", "story_v_out_101061.awb")
				end

				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_10 = math.max(var_139_1, arg_136_1.talkMaxDuration)

			if var_139_0 <= arg_136_1.time_ and arg_136_1.time_ < var_139_0 + var_139_10 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_0) / var_139_10

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_0 + var_139_10 and arg_136_1.time_ < var_139_0 + var_139_10 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {}

		arg_136_1:InitPlayNodeList()
	end,
	Play101061034 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 101061034
		arg_140_1.duration_ = 8.6

		local var_140_0 = {
			ja = 7.9,
			ko = 7.333,
			zh = 7.7,
			en = 8.6
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
				arg_140_0:Play101061035(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			local var_143_0 = 0
			local var_143_1 = 0.925

			if var_143_0 < arg_140_1.time_ and arg_140_1.time_ <= var_143_0 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, true)

				local var_143_2 = arg_140_1:FormatText(StoryNameCfg[20].name)

				arg_140_1.leftNameTxt_.text = var_143_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_140_1.leftNameTxt_.transform)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1.leftNameTxt_.text)
				SetActive(arg_140_1.iconTrs_.gameObject, true)
				arg_140_1.iconController_:SetSelectedState("hero")

				arg_140_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3008")

				arg_140_1.callingController_:SetSelectedState("normal")

				arg_140_1.keyicon_.color = Color.New(1, 1, 1)
				arg_140_1.icon_.color = Color.New(1, 1, 1)

				local var_143_3 = arg_140_1:GetWordFromCfg(101061034)
				local var_143_4 = arg_140_1:FormatText(var_143_3.content)

				arg_140_1.text_.text = var_143_4

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_5 = 36
				local var_143_6 = utf8.len(var_143_4)
				local var_143_7 = var_143_5 <= 0 and var_143_1 or var_143_1 * (var_143_6 / var_143_5)

				if var_143_7 > 0 and var_143_1 < var_143_7 then
					arg_140_1.talkMaxDuration = var_143_7

					if var_143_7 + var_143_0 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_7 + var_143_0
					end
				end

				arg_140_1.text_.text = var_143_4
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101061", "101061034", "story_v_out_101061.awb") ~= 0 then
					local var_143_8 = manager.audio:GetVoiceLength("story_v_out_101061", "101061034", "story_v_out_101061.awb") / 1000

					if var_143_8 + var_143_0 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_8 + var_143_0
					end

					if var_143_3.prefab_name ~= "" and arg_140_1.actors_[var_143_3.prefab_name] ~= nil then
						local var_143_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_140_1.actors_[var_143_3.prefab_name].transform, "story_v_out_101061", "101061034", "story_v_out_101061.awb")

						arg_140_1:RecordAudio("101061034", var_143_9)
						arg_140_1:RecordAudio("101061034", var_143_9)
					else
						arg_140_1:AudioAction("play", "voice", "story_v_out_101061", "101061034", "story_v_out_101061.awb")
					end

					arg_140_1:RecordHistoryTalkVoice("story_v_out_101061", "101061034", "story_v_out_101061.awb")
				end

				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_10 = math.max(var_143_1, arg_140_1.talkMaxDuration)

			if var_143_0 <= arg_140_1.time_ and arg_140_1.time_ < var_143_0 + var_143_10 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_0) / var_143_10

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_0 + var_143_10 and arg_140_1.time_ < var_143_0 + var_143_10 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {}

		arg_140_1:InitPlayNodeList()
	end,
	Play101061035 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 101061035
		arg_144_1.duration_ = 9.43

		local var_144_0 = {
			ja = 9.433,
			ko = 8.4,
			zh = 6.533,
			en = 8.066
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
				arg_144_0:Play101061036(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			local var_147_0 = 0
			local var_147_1 = 0.85

			if var_147_0 < arg_144_1.time_ and arg_144_1.time_ <= var_147_0 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				local var_147_2 = arg_144_1:FormatText(StoryNameCfg[35].name)

				arg_144_1.leftNameTxt_.text = var_147_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, false)
				arg_144_1.callingController_:SetSelectedState("normal")

				local var_147_3 = arg_144_1:GetWordFromCfg(101061035)
				local var_147_4 = arg_144_1:FormatText(var_147_3.content)

				arg_144_1.text_.text = var_147_4

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_5 = 34
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

				if manager.audio:GetVoiceLength("story_v_out_101061", "101061035", "story_v_out_101061.awb") ~= 0 then
					local var_147_8 = manager.audio:GetVoiceLength("story_v_out_101061", "101061035", "story_v_out_101061.awb") / 1000

					if var_147_8 + var_147_0 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_8 + var_147_0
					end

					if var_147_3.prefab_name ~= "" and arg_144_1.actors_[var_147_3.prefab_name] ~= nil then
						local var_147_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_144_1.actors_[var_147_3.prefab_name].transform, "story_v_out_101061", "101061035", "story_v_out_101061.awb")

						arg_144_1:RecordAudio("101061035", var_147_9)
						arg_144_1:RecordAudio("101061035", var_147_9)
					else
						arg_144_1:AudioAction("play", "voice", "story_v_out_101061", "101061035", "story_v_out_101061.awb")
					end

					arg_144_1:RecordHistoryTalkVoice("story_v_out_101061", "101061035", "story_v_out_101061.awb")
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
	Play101061036 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 101061036
		arg_148_1.duration_ = 4.1

		local var_148_0 = {
			ja = 1.333,
			ko = 3,
			zh = 2.7,
			en = 4.1
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
				arg_148_0:Play101061037(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			local var_151_0 = 0
			local var_151_1 = 0.3

			if var_151_0 < arg_148_1.time_ and arg_148_1.time_ <= var_151_0 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, true)

				local var_151_2 = arg_148_1:FormatText(StoryNameCfg[20].name)

				arg_148_1.leftNameTxt_.text = var_151_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_148_1.leftNameTxt_.transform)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1.leftNameTxt_.text)
				SetActive(arg_148_1.iconTrs_.gameObject, true)
				arg_148_1.iconController_:SetSelectedState("hero")

				arg_148_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3008")

				arg_148_1.callingController_:SetSelectedState("normal")

				arg_148_1.keyicon_.color = Color.New(1, 1, 1)
				arg_148_1.icon_.color = Color.New(1, 1, 1)

				local var_151_3 = arg_148_1:GetWordFromCfg(101061036)
				local var_151_4 = arg_148_1:FormatText(var_151_3.content)

				arg_148_1.text_.text = var_151_4

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_5 = 12
				local var_151_6 = utf8.len(var_151_4)
				local var_151_7 = var_151_5 <= 0 and var_151_1 or var_151_1 * (var_151_6 / var_151_5)

				if var_151_7 > 0 and var_151_1 < var_151_7 then
					arg_148_1.talkMaxDuration = var_151_7

					if var_151_7 + var_151_0 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_7 + var_151_0
					end
				end

				arg_148_1.text_.text = var_151_4
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101061", "101061036", "story_v_out_101061.awb") ~= 0 then
					local var_151_8 = manager.audio:GetVoiceLength("story_v_out_101061", "101061036", "story_v_out_101061.awb") / 1000

					if var_151_8 + var_151_0 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_8 + var_151_0
					end

					if var_151_3.prefab_name ~= "" and arg_148_1.actors_[var_151_3.prefab_name] ~= nil then
						local var_151_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_148_1.actors_[var_151_3.prefab_name].transform, "story_v_out_101061", "101061036", "story_v_out_101061.awb")

						arg_148_1:RecordAudio("101061036", var_151_9)
						arg_148_1:RecordAudio("101061036", var_151_9)
					else
						arg_148_1:AudioAction("play", "voice", "story_v_out_101061", "101061036", "story_v_out_101061.awb")
					end

					arg_148_1:RecordHistoryTalkVoice("story_v_out_101061", "101061036", "story_v_out_101061.awb")
				end

				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_10 = math.max(var_151_1, arg_148_1.talkMaxDuration)

			if var_151_0 <= arg_148_1.time_ and arg_148_1.time_ < var_151_0 + var_151_10 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_0) / var_151_10

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_0 + var_151_10 and arg_148_1.time_ < var_151_0 + var_151_10 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {}

		arg_148_1:InitPlayNodeList()
	end,
	Play101061037 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 101061037
		arg_152_1.duration_ = 8.97

		local var_152_0 = {
			ja = 8.966,
			ko = 3.866,
			zh = 5.9,
			en = 3.2
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
				arg_152_0:Play101061038(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			local var_155_0 = 0
			local var_155_1 = 0.525

			if var_155_0 < arg_152_1.time_ and arg_152_1.time_ <= var_155_0 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, true)

				local var_155_2 = arg_152_1:FormatText(StoryNameCfg[35].name)

				arg_152_1.leftNameTxt_.text = var_155_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, false)
				arg_152_1.callingController_:SetSelectedState("normal")

				local var_155_3 = arg_152_1:GetWordFromCfg(101061037)
				local var_155_4 = arg_152_1:FormatText(var_155_3.content)

				arg_152_1.text_.text = var_155_4

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_5 = 21
				local var_155_6 = utf8.len(var_155_4)
				local var_155_7 = var_155_5 <= 0 and var_155_1 or var_155_1 * (var_155_6 / var_155_5)

				if var_155_7 > 0 and var_155_1 < var_155_7 then
					arg_152_1.talkMaxDuration = var_155_7

					if var_155_7 + var_155_0 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_7 + var_155_0
					end
				end

				arg_152_1.text_.text = var_155_4
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101061", "101061037", "story_v_out_101061.awb") ~= 0 then
					local var_155_8 = manager.audio:GetVoiceLength("story_v_out_101061", "101061037", "story_v_out_101061.awb") / 1000

					if var_155_8 + var_155_0 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_8 + var_155_0
					end

					if var_155_3.prefab_name ~= "" and arg_152_1.actors_[var_155_3.prefab_name] ~= nil then
						local var_155_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_152_1.actors_[var_155_3.prefab_name].transform, "story_v_out_101061", "101061037", "story_v_out_101061.awb")

						arg_152_1:RecordAudio("101061037", var_155_9)
						arg_152_1:RecordAudio("101061037", var_155_9)
					else
						arg_152_1:AudioAction("play", "voice", "story_v_out_101061", "101061037", "story_v_out_101061.awb")
					end

					arg_152_1:RecordHistoryTalkVoice("story_v_out_101061", "101061037", "story_v_out_101061.awb")
				end

				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_10 = math.max(var_155_1, arg_152_1.talkMaxDuration)

			if var_155_0 <= arg_152_1.time_ and arg_152_1.time_ < var_155_0 + var_155_10 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_0) / var_155_10

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_0 + var_155_10 and arg_152_1.time_ < var_155_0 + var_155_10 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {}

		arg_152_1:InitPlayNodeList()
	end,
	Play101061038 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 101061038
		arg_156_1.duration_ = 3.07

		local var_156_0 = {
			ja = 3.066,
			ko = 2.233,
			zh = 2.366,
			en = 2.166
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
				arg_156_0:Play101061039(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			local var_159_0 = 0
			local var_159_1 = 0.3

			if var_159_0 < arg_156_1.time_ and arg_156_1.time_ <= var_159_0 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, true)

				local var_159_2 = arg_156_1:FormatText(StoryNameCfg[34].name)

				arg_156_1.leftNameTxt_.text = var_159_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_156_1.leftNameTxt_.transform)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1.leftNameTxt_.text)
				SetActive(arg_156_1.iconTrs_.gameObject, true)
				arg_156_1.iconController_:SetSelectedState("hero")

				arg_156_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_20301")

				arg_156_1.callingController_:SetSelectedState("normal")

				arg_156_1.keyicon_.color = Color.New(1, 1, 1)
				arg_156_1.icon_.color = Color.New(1, 1, 1)

				local var_159_3 = arg_156_1:GetWordFromCfg(101061038)
				local var_159_4 = arg_156_1:FormatText(var_159_3.content)

				arg_156_1.text_.text = var_159_4

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_5 = 12
				local var_159_6 = utf8.len(var_159_4)
				local var_159_7 = var_159_5 <= 0 and var_159_1 or var_159_1 * (var_159_6 / var_159_5)

				if var_159_7 > 0 and var_159_1 < var_159_7 then
					arg_156_1.talkMaxDuration = var_159_7

					if var_159_7 + var_159_0 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_7 + var_159_0
					end
				end

				arg_156_1.text_.text = var_159_4
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101061", "101061038", "story_v_out_101061.awb") ~= 0 then
					local var_159_8 = manager.audio:GetVoiceLength("story_v_out_101061", "101061038", "story_v_out_101061.awb") / 1000

					if var_159_8 + var_159_0 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_8 + var_159_0
					end

					if var_159_3.prefab_name ~= "" and arg_156_1.actors_[var_159_3.prefab_name] ~= nil then
						local var_159_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_156_1.actors_[var_159_3.prefab_name].transform, "story_v_out_101061", "101061038", "story_v_out_101061.awb")

						arg_156_1:RecordAudio("101061038", var_159_9)
						arg_156_1:RecordAudio("101061038", var_159_9)
					else
						arg_156_1:AudioAction("play", "voice", "story_v_out_101061", "101061038", "story_v_out_101061.awb")
					end

					arg_156_1:RecordHistoryTalkVoice("story_v_out_101061", "101061038", "story_v_out_101061.awb")
				end

				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_10 = math.max(var_159_1, arg_156_1.talkMaxDuration)

			if var_159_0 <= arg_156_1.time_ and arg_156_1.time_ < var_159_0 + var_159_10 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_0) / var_159_10

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_0 + var_159_10 and arg_156_1.time_ < var_159_0 + var_159_10 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {}

		arg_156_1:InitPlayNodeList()
	end,
	Play101061039 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 101061039
		arg_160_1.duration_ = 11.33

		local var_160_0 = {
			ja = 11.333,
			ko = 9,
			zh = 9.533,
			en = 7.966
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
				arg_160_0:Play101061040(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			local var_163_0 = 0
			local var_163_1 = 1

			if var_163_0 < arg_160_1.time_ and arg_160_1.time_ <= var_163_0 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, true)

				local var_163_2 = arg_160_1:FormatText(StoryNameCfg[35].name)

				arg_160_1.leftNameTxt_.text = var_163_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_160_1.leftNameTxt_.transform)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1.leftNameTxt_.text)
				SetActive(arg_160_1.iconTrs_.gameObject, false)
				arg_160_1.callingController_:SetSelectedState("normal")

				local var_163_3 = arg_160_1:GetWordFromCfg(101061039)
				local var_163_4 = arg_160_1:FormatText(var_163_3.content)

				arg_160_1.text_.text = var_163_4

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_5 = 40
				local var_163_6 = utf8.len(var_163_4)
				local var_163_7 = var_163_5 <= 0 and var_163_1 or var_163_1 * (var_163_6 / var_163_5)

				if var_163_7 > 0 and var_163_1 < var_163_7 then
					arg_160_1.talkMaxDuration = var_163_7

					if var_163_7 + var_163_0 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_7 + var_163_0
					end
				end

				arg_160_1.text_.text = var_163_4
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101061", "101061039", "story_v_out_101061.awb") ~= 0 then
					local var_163_8 = manager.audio:GetVoiceLength("story_v_out_101061", "101061039", "story_v_out_101061.awb") / 1000

					if var_163_8 + var_163_0 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_8 + var_163_0
					end

					if var_163_3.prefab_name ~= "" and arg_160_1.actors_[var_163_3.prefab_name] ~= nil then
						local var_163_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_160_1.actors_[var_163_3.prefab_name].transform, "story_v_out_101061", "101061039", "story_v_out_101061.awb")

						arg_160_1:RecordAudio("101061039", var_163_9)
						arg_160_1:RecordAudio("101061039", var_163_9)
					else
						arg_160_1:AudioAction("play", "voice", "story_v_out_101061", "101061039", "story_v_out_101061.awb")
					end

					arg_160_1:RecordHistoryTalkVoice("story_v_out_101061", "101061039", "story_v_out_101061.awb")
				end

				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_10 = math.max(var_163_1, arg_160_1.talkMaxDuration)

			if var_163_0 <= arg_160_1.time_ and arg_160_1.time_ < var_163_0 + var_163_10 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - var_163_0) / var_163_10

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= var_163_0 + var_163_10 and arg_160_1.time_ < var_163_0 + var_163_10 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {}

		arg_160_1:InitPlayNodeList()
	end,
	Play101061040 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 101061040
		arg_164_1.duration_ = 2.93

		local var_164_0 = {
			ja = 2.933,
			ko = 1.833,
			zh = 2.166,
			en = 2.366
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
				arg_164_0:Play101061041(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			local var_167_0 = 0
			local var_167_1 = 0.2

			if var_167_0 < arg_164_1.time_ and arg_164_1.time_ <= var_167_0 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0
				arg_164_1.dialogCg_.alpha = 1

				arg_164_1.dialog_:SetActive(true)
				SetActive(arg_164_1.leftNameGo_, true)

				local var_167_2 = arg_164_1:FormatText(StoryNameCfg[20].name)

				arg_164_1.leftNameTxt_.text = var_167_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_164_1.leftNameTxt_.transform)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1.leftNameTxt_.text)
				SetActive(arg_164_1.iconTrs_.gameObject, true)
				arg_164_1.iconController_:SetSelectedState("hero")

				arg_164_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3008")

				arg_164_1.callingController_:SetSelectedState("normal")

				arg_164_1.keyicon_.color = Color.New(1, 1, 1)
				arg_164_1.icon_.color = Color.New(1, 1, 1)

				local var_167_3 = arg_164_1:GetWordFromCfg(101061040)
				local var_167_4 = arg_164_1:FormatText(var_167_3.content)

				arg_164_1.text_.text = var_167_4

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_5 = 8
				local var_167_6 = utf8.len(var_167_4)
				local var_167_7 = var_167_5 <= 0 and var_167_1 or var_167_1 * (var_167_6 / var_167_5)

				if var_167_7 > 0 and var_167_1 < var_167_7 then
					arg_164_1.talkMaxDuration = var_167_7

					if var_167_7 + var_167_0 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_7 + var_167_0
					end
				end

				arg_164_1.text_.text = var_167_4
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101061", "101061040", "story_v_out_101061.awb") ~= 0 then
					local var_167_8 = manager.audio:GetVoiceLength("story_v_out_101061", "101061040", "story_v_out_101061.awb") / 1000

					if var_167_8 + var_167_0 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_8 + var_167_0
					end

					if var_167_3.prefab_name ~= "" and arg_164_1.actors_[var_167_3.prefab_name] ~= nil then
						local var_167_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_164_1.actors_[var_167_3.prefab_name].transform, "story_v_out_101061", "101061040", "story_v_out_101061.awb")

						arg_164_1:RecordAudio("101061040", var_167_9)
						arg_164_1:RecordAudio("101061040", var_167_9)
					else
						arg_164_1:AudioAction("play", "voice", "story_v_out_101061", "101061040", "story_v_out_101061.awb")
					end

					arg_164_1:RecordHistoryTalkVoice("story_v_out_101061", "101061040", "story_v_out_101061.awb")
				end

				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_10 = math.max(var_167_1, arg_164_1.talkMaxDuration)

			if var_167_0 <= arg_164_1.time_ and arg_164_1.time_ < var_167_0 + var_167_10 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - var_167_0) / var_167_10

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= var_167_0 + var_167_10 and arg_164_1.time_ < var_167_0 + var_167_10 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {}

		arg_164_1:InitPlayNodeList()
	end,
	Play101061041 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 101061041
		arg_168_1.duration_ = 8.33

		local var_168_0 = {
			ja = 8.333,
			ko = 7.6,
			zh = 6.133,
			en = 7.066
		}
		local var_168_1 = manager.audio:GetLocalizationFlag()

		if var_168_0[var_168_1] ~= nil then
			arg_168_1.duration_ = var_168_0[var_168_1]
		end

		SetActive(arg_168_1.tipsGo_, false)

		function arg_168_1.onSingleLineFinish_()
			arg_168_1.onSingleLineUpdate_ = nil
			arg_168_1.onSingleLineFinish_ = nil
			arg_168_1.state_ = "waiting"
		end

		function arg_168_1.playNext_(arg_170_0)
			if arg_170_0 == 1 then
				arg_168_0:Play101061042(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			local var_171_0 = 0
			local var_171_1 = 0.675

			if var_171_0 < arg_168_1.time_ and arg_168_1.time_ <= var_171_0 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0
				arg_168_1.dialogCg_.alpha = 1

				arg_168_1.dialog_:SetActive(true)
				SetActive(arg_168_1.leftNameGo_, true)

				local var_171_2 = arg_168_1:FormatText(StoryNameCfg[35].name)

				arg_168_1.leftNameTxt_.text = var_171_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_168_1.leftNameTxt_.transform)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1.leftNameTxt_.text)
				SetActive(arg_168_1.iconTrs_.gameObject, false)
				arg_168_1.callingController_:SetSelectedState("normal")

				local var_171_3 = arg_168_1:GetWordFromCfg(101061041)
				local var_171_4 = arg_168_1:FormatText(var_171_3.content)

				arg_168_1.text_.text = var_171_4

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_5 = 27
				local var_171_6 = utf8.len(var_171_4)
				local var_171_7 = var_171_5 <= 0 and var_171_1 or var_171_1 * (var_171_6 / var_171_5)

				if var_171_7 > 0 and var_171_1 < var_171_7 then
					arg_168_1.talkMaxDuration = var_171_7

					if var_171_7 + var_171_0 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_7 + var_171_0
					end
				end

				arg_168_1.text_.text = var_171_4
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101061", "101061041", "story_v_out_101061.awb") ~= 0 then
					local var_171_8 = manager.audio:GetVoiceLength("story_v_out_101061", "101061041", "story_v_out_101061.awb") / 1000

					if var_171_8 + var_171_0 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_8 + var_171_0
					end

					if var_171_3.prefab_name ~= "" and arg_168_1.actors_[var_171_3.prefab_name] ~= nil then
						local var_171_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_168_1.actors_[var_171_3.prefab_name].transform, "story_v_out_101061", "101061041", "story_v_out_101061.awb")

						arg_168_1:RecordAudio("101061041", var_171_9)
						arg_168_1:RecordAudio("101061041", var_171_9)
					else
						arg_168_1:AudioAction("play", "voice", "story_v_out_101061", "101061041", "story_v_out_101061.awb")
					end

					arg_168_1:RecordHistoryTalkVoice("story_v_out_101061", "101061041", "story_v_out_101061.awb")
				end

				arg_168_1:RecordContent(arg_168_1.text_.text)
			end

			local var_171_10 = math.max(var_171_1, arg_168_1.talkMaxDuration)

			if var_171_0 <= arg_168_1.time_ and arg_168_1.time_ < var_171_0 + var_171_10 then
				arg_168_1.typewritter.percent = (arg_168_1.time_ - var_171_0) / var_171_10

				arg_168_1.typewritter:SetDirty()
			end

			if arg_168_1.time_ >= var_171_0 + var_171_10 and arg_168_1.time_ < var_171_0 + var_171_10 + arg_171_0 then
				arg_168_1.typewritter.percent = 1

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(true)
			end
		end

		arg_168_1.nodeConfigList_ = {}

		arg_168_1:InitPlayNodeList()
	end,
	Play101061042 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 101061042
		arg_172_1.duration_ = 7.2

		local var_172_0 = {
			ja = 7.2,
			ko = 4.9,
			zh = 4.866,
			en = 3.366
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
				arg_172_0:Play101061043(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			local var_175_0 = 0
			local var_175_1 = 0.725

			if var_175_0 < arg_172_1.time_ and arg_172_1.time_ <= var_175_0 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, true)

				local var_175_2 = arg_172_1:FormatText(StoryNameCfg[20].name)

				arg_172_1.leftNameTxt_.text = var_175_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_172_1.leftNameTxt_.transform)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1.leftNameTxt_.text)
				SetActive(arg_172_1.iconTrs_.gameObject, true)
				arg_172_1.iconController_:SetSelectedState("hero")

				arg_172_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3008")

				arg_172_1.callingController_:SetSelectedState("normal")

				arg_172_1.keyicon_.color = Color.New(1, 1, 1)
				arg_172_1.icon_.color = Color.New(1, 1, 1)

				local var_175_3 = arg_172_1:GetWordFromCfg(101061042)
				local var_175_4 = arg_172_1:FormatText(var_175_3.content)

				arg_172_1.text_.text = var_175_4

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_5 = 29
				local var_175_6 = utf8.len(var_175_4)
				local var_175_7 = var_175_5 <= 0 and var_175_1 or var_175_1 * (var_175_6 / var_175_5)

				if var_175_7 > 0 and var_175_1 < var_175_7 then
					arg_172_1.talkMaxDuration = var_175_7

					if var_175_7 + var_175_0 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_7 + var_175_0
					end
				end

				arg_172_1.text_.text = var_175_4
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101061", "101061042", "story_v_out_101061.awb") ~= 0 then
					local var_175_8 = manager.audio:GetVoiceLength("story_v_out_101061", "101061042", "story_v_out_101061.awb") / 1000

					if var_175_8 + var_175_0 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_8 + var_175_0
					end

					if var_175_3.prefab_name ~= "" and arg_172_1.actors_[var_175_3.prefab_name] ~= nil then
						local var_175_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_172_1.actors_[var_175_3.prefab_name].transform, "story_v_out_101061", "101061042", "story_v_out_101061.awb")

						arg_172_1:RecordAudio("101061042", var_175_9)
						arg_172_1:RecordAudio("101061042", var_175_9)
					else
						arg_172_1:AudioAction("play", "voice", "story_v_out_101061", "101061042", "story_v_out_101061.awb")
					end

					arg_172_1:RecordHistoryTalkVoice("story_v_out_101061", "101061042", "story_v_out_101061.awb")
				end

				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_10 = math.max(var_175_1, arg_172_1.talkMaxDuration)

			if var_175_0 <= arg_172_1.time_ and arg_172_1.time_ < var_175_0 + var_175_10 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - var_175_0) / var_175_10

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= var_175_0 + var_175_10 and arg_172_1.time_ < var_175_0 + var_175_10 + arg_175_0 then
				arg_172_1.typewritter.percent = 1

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(true)
			end
		end

		arg_172_1.nodeConfigList_ = {}

		arg_172_1:InitPlayNodeList()
	end,
	Play101061043 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 101061043
		arg_176_1.duration_ = 6.6

		local var_176_0 = {
			ja = 6.6,
			ko = 3.6,
			zh = 3,
			en = 4.166
		}
		local var_176_1 = manager.audio:GetLocalizationFlag()

		if var_176_0[var_176_1] ~= nil then
			arg_176_1.duration_ = var_176_0[var_176_1]
		end

		SetActive(arg_176_1.tipsGo_, false)

		function arg_176_1.onSingleLineFinish_()
			arg_176_1.onSingleLineUpdate_ = nil
			arg_176_1.onSingleLineFinish_ = nil
			arg_176_1.state_ = "waiting"
		end

		function arg_176_1.playNext_(arg_178_0)
			if arg_178_0 == 1 then
				arg_176_0:Play101061044(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			local var_179_0 = 0
			local var_179_1 = 0.45

			if var_179_0 < arg_176_1.time_ and arg_176_1.time_ <= var_179_0 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0
				arg_176_1.dialogCg_.alpha = 1

				arg_176_1.dialog_:SetActive(true)
				SetActive(arg_176_1.leftNameGo_, true)

				local var_179_2 = arg_176_1:FormatText(StoryNameCfg[20].name)

				arg_176_1.leftNameTxt_.text = var_179_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_176_1.leftNameTxt_.transform)

				arg_176_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_176_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_176_1:RecordName(arg_176_1.leftNameTxt_.text)
				SetActive(arg_176_1.iconTrs_.gameObject, true)
				arg_176_1.iconController_:SetSelectedState("hero")

				arg_176_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3008")

				arg_176_1.callingController_:SetSelectedState("normal")

				arg_176_1.keyicon_.color = Color.New(1, 1, 1)
				arg_176_1.icon_.color = Color.New(1, 1, 1)

				local var_179_3 = arg_176_1:GetWordFromCfg(101061043)
				local var_179_4 = arg_176_1:FormatText(var_179_3.content)

				arg_176_1.text_.text = var_179_4

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_5 = 18
				local var_179_6 = utf8.len(var_179_4)
				local var_179_7 = var_179_5 <= 0 and var_179_1 or var_179_1 * (var_179_6 / var_179_5)

				if var_179_7 > 0 and var_179_1 < var_179_7 then
					arg_176_1.talkMaxDuration = var_179_7

					if var_179_7 + var_179_0 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_7 + var_179_0
					end
				end

				arg_176_1.text_.text = var_179_4
				arg_176_1.typewritter.percent = 0

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101061", "101061043", "story_v_out_101061.awb") ~= 0 then
					local var_179_8 = manager.audio:GetVoiceLength("story_v_out_101061", "101061043", "story_v_out_101061.awb") / 1000

					if var_179_8 + var_179_0 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_8 + var_179_0
					end

					if var_179_3.prefab_name ~= "" and arg_176_1.actors_[var_179_3.prefab_name] ~= nil then
						local var_179_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_176_1.actors_[var_179_3.prefab_name].transform, "story_v_out_101061", "101061043", "story_v_out_101061.awb")

						arg_176_1:RecordAudio("101061043", var_179_9)
						arg_176_1:RecordAudio("101061043", var_179_9)
					else
						arg_176_1:AudioAction("play", "voice", "story_v_out_101061", "101061043", "story_v_out_101061.awb")
					end

					arg_176_1:RecordHistoryTalkVoice("story_v_out_101061", "101061043", "story_v_out_101061.awb")
				end

				arg_176_1:RecordContent(arg_176_1.text_.text)
			end

			local var_179_10 = math.max(var_179_1, arg_176_1.talkMaxDuration)

			if var_179_0 <= arg_176_1.time_ and arg_176_1.time_ < var_179_0 + var_179_10 then
				arg_176_1.typewritter.percent = (arg_176_1.time_ - var_179_0) / var_179_10

				arg_176_1.typewritter:SetDirty()
			end

			if arg_176_1.time_ >= var_179_0 + var_179_10 and arg_176_1.time_ < var_179_0 + var_179_10 + arg_179_0 then
				arg_176_1.typewritter.percent = 1

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(true)
			end
		end

		arg_176_1.nodeConfigList_ = {}

		arg_176_1:InitPlayNodeList()
	end,
	Play101061044 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 101061044
		arg_180_1.duration_ = 4.13

		local var_180_0 = {
			ja = 3.033,
			ko = 4.133,
			zh = 3.033,
			en = 3.5
		}
		local var_180_1 = manager.audio:GetLocalizationFlag()

		if var_180_0[var_180_1] ~= nil then
			arg_180_1.duration_ = var_180_0[var_180_1]
		end

		SetActive(arg_180_1.tipsGo_, false)

		function arg_180_1.onSingleLineFinish_()
			arg_180_1.onSingleLineUpdate_ = nil
			arg_180_1.onSingleLineFinish_ = nil
			arg_180_1.state_ = "waiting"
		end

		function arg_180_1.playNext_(arg_182_0)
			if arg_182_0 == 1 then
				arg_180_0:Play101061045(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			local var_183_0 = 0
			local var_183_1 = 0.3

			if var_183_0 < arg_180_1.time_ and arg_180_1.time_ <= var_183_0 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0
				arg_180_1.dialogCg_.alpha = 1

				arg_180_1.dialog_:SetActive(true)
				SetActive(arg_180_1.leftNameGo_, true)

				local var_183_2 = arg_180_1:FormatText(StoryNameCfg[35].name)

				arg_180_1.leftNameTxt_.text = var_183_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_180_1.leftNameTxt_.transform)

				arg_180_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_180_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_180_1:RecordName(arg_180_1.leftNameTxt_.text)
				SetActive(arg_180_1.iconTrs_.gameObject, false)
				arg_180_1.callingController_:SetSelectedState("normal")

				local var_183_3 = arg_180_1:GetWordFromCfg(101061044)
				local var_183_4 = arg_180_1:FormatText(var_183_3.content)

				arg_180_1.text_.text = var_183_4

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_5 = 12
				local var_183_6 = utf8.len(var_183_4)
				local var_183_7 = var_183_5 <= 0 and var_183_1 or var_183_1 * (var_183_6 / var_183_5)

				if var_183_7 > 0 and var_183_1 < var_183_7 then
					arg_180_1.talkMaxDuration = var_183_7

					if var_183_7 + var_183_0 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_7 + var_183_0
					end
				end

				arg_180_1.text_.text = var_183_4
				arg_180_1.typewritter.percent = 0

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101061", "101061044", "story_v_out_101061.awb") ~= 0 then
					local var_183_8 = manager.audio:GetVoiceLength("story_v_out_101061", "101061044", "story_v_out_101061.awb") / 1000

					if var_183_8 + var_183_0 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_8 + var_183_0
					end

					if var_183_3.prefab_name ~= "" and arg_180_1.actors_[var_183_3.prefab_name] ~= nil then
						local var_183_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_180_1.actors_[var_183_3.prefab_name].transform, "story_v_out_101061", "101061044", "story_v_out_101061.awb")

						arg_180_1:RecordAudio("101061044", var_183_9)
						arg_180_1:RecordAudio("101061044", var_183_9)
					else
						arg_180_1:AudioAction("play", "voice", "story_v_out_101061", "101061044", "story_v_out_101061.awb")
					end

					arg_180_1:RecordHistoryTalkVoice("story_v_out_101061", "101061044", "story_v_out_101061.awb")
				end

				arg_180_1:RecordContent(arg_180_1.text_.text)
			end

			local var_183_10 = math.max(var_183_1, arg_180_1.talkMaxDuration)

			if var_183_0 <= arg_180_1.time_ and arg_180_1.time_ < var_183_0 + var_183_10 then
				arg_180_1.typewritter.percent = (arg_180_1.time_ - var_183_0) / var_183_10

				arg_180_1.typewritter:SetDirty()
			end

			if arg_180_1.time_ >= var_183_0 + var_183_10 and arg_180_1.time_ < var_183_0 + var_183_10 + arg_183_0 then
				arg_180_1.typewritter.percent = 1

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(true)
			end
		end

		arg_180_1.nodeConfigList_ = {}

		arg_180_1:InitPlayNodeList()
	end,
	Play101061045 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 101061045
		arg_184_1.duration_ = 5.23

		local var_184_0 = {
			ja = 5.233,
			ko = 4.366,
			zh = 3.3,
			en = 4.233
		}
		local var_184_1 = manager.audio:GetLocalizationFlag()

		if var_184_0[var_184_1] ~= nil then
			arg_184_1.duration_ = var_184_0[var_184_1]
		end

		SetActive(arg_184_1.tipsGo_, false)

		function arg_184_1.onSingleLineFinish_()
			arg_184_1.onSingleLineUpdate_ = nil
			arg_184_1.onSingleLineFinish_ = nil
			arg_184_1.state_ = "waiting"
			arg_184_1.auto_ = false
		end

		function arg_184_1.playNext_(arg_186_0)
			arg_184_1.onStoryFinished_()
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			local var_187_0 = 0
			local var_187_1 = 0.4

			if var_187_0 < arg_184_1.time_ and arg_184_1.time_ <= var_187_0 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0
				arg_184_1.dialogCg_.alpha = 1

				arg_184_1.dialog_:SetActive(true)
				SetActive(arg_184_1.leftNameGo_, true)

				local var_187_2 = arg_184_1:FormatText(StoryNameCfg[20].name)

				arg_184_1.leftNameTxt_.text = var_187_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_184_1.leftNameTxt_.transform)

				arg_184_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_184_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_184_1:RecordName(arg_184_1.leftNameTxt_.text)
				SetActive(arg_184_1.iconTrs_.gameObject, true)
				arg_184_1.iconController_:SetSelectedState("hero")

				arg_184_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3008")

				arg_184_1.callingController_:SetSelectedState("normal")

				arg_184_1.keyicon_.color = Color.New(1, 1, 1)
				arg_184_1.icon_.color = Color.New(1, 1, 1)

				local var_187_3 = arg_184_1:GetWordFromCfg(101061045)
				local var_187_4 = arg_184_1:FormatText(var_187_3.content)

				arg_184_1.text_.text = var_187_4

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.text_)

				local var_187_5 = 16
				local var_187_6 = utf8.len(var_187_4)
				local var_187_7 = var_187_5 <= 0 and var_187_1 or var_187_1 * (var_187_6 / var_187_5)

				if var_187_7 > 0 and var_187_1 < var_187_7 then
					arg_184_1.talkMaxDuration = var_187_7

					if var_187_7 + var_187_0 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_7 + var_187_0
					end
				end

				arg_184_1.text_.text = var_187_4
				arg_184_1.typewritter.percent = 0

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101061", "101061045", "story_v_out_101061.awb") ~= 0 then
					local var_187_8 = manager.audio:GetVoiceLength("story_v_out_101061", "101061045", "story_v_out_101061.awb") / 1000

					if var_187_8 + var_187_0 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_8 + var_187_0
					end

					if var_187_3.prefab_name ~= "" and arg_184_1.actors_[var_187_3.prefab_name] ~= nil then
						local var_187_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_184_1.actors_[var_187_3.prefab_name].transform, "story_v_out_101061", "101061045", "story_v_out_101061.awb")

						arg_184_1:RecordAudio("101061045", var_187_9)
						arg_184_1:RecordAudio("101061045", var_187_9)
					else
						arg_184_1:AudioAction("play", "voice", "story_v_out_101061", "101061045", "story_v_out_101061.awb")
					end

					arg_184_1:RecordHistoryTalkVoice("story_v_out_101061", "101061045", "story_v_out_101061.awb")
				end

				arg_184_1:RecordContent(arg_184_1.text_.text)
			end

			local var_187_10 = math.max(var_187_1, arg_184_1.talkMaxDuration)

			if var_187_0 <= arg_184_1.time_ and arg_184_1.time_ < var_187_0 + var_187_10 then
				arg_184_1.typewritter.percent = (arg_184_1.time_ - var_187_0) / var_187_10

				arg_184_1.typewritter:SetDirty()
			end

			if arg_184_1.time_ >= var_187_0 + var_187_10 and arg_184_1.time_ < var_187_0 + var_187_10 + arg_187_0 then
				arg_184_1.typewritter.percent = 1

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(true)
			end
		end

		arg_184_1.nodeConfigList_ = {}

		arg_184_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/B08b",
		"TextureConfig/Background/B08c",
		"TextureConfig/Background/S0105"
	},
	voices = {
		"story_v_out_101061.awb"
	}
}
