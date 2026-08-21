return {
	Play101081001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 101081001
		arg_1_1.duration_ = 8.1

		local var_1_0 = {
			ja = 8.1,
			ko = 5.933,
			zh = 6.8,
			en = 6.933
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
				arg_1_0:Play101081002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = 0
			local var_4_1 = 1

			if var_4_0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_0 + arg_4_0 then
				local var_4_2 = "play"
				local var_4_3 = "music"

				arg_1_1:AudioAction(var_4_2, var_4_3, "bgm_story_scheme", "bgm_story_scheme", "bgm_story_scheme")

				local var_4_4 = ""
				local var_4_5 = manager.audio:GetAudioName("bgm_story_scheme", "bgm_story_scheme")

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

			local var_4_10 = "2030_tpose"

			if arg_1_1.actors_[var_4_10] == nil then
				local var_4_11 = Asset.Load("Char/" .. "2030_tpose")

				if not isNil(var_4_11) then
					local var_4_12 = Object.Instantiate(Asset.Load("Char/" .. "2030_tpose"), arg_1_1.stage_.transform)

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

			local var_4_15 = arg_1_1.actors_["2030_tpose"]
			local var_4_16 = 2

			if var_4_16 < arg_1_1.time_ and arg_1_1.time_ <= var_4_16 + arg_4_0 and not isNil(var_4_15) and arg_1_1.var_.characterEffect2030_tpose == nil then
				arg_1_1.var_.characterEffect2030_tpose = var_4_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_17 = 0.1

			if var_4_16 <= arg_1_1.time_ and arg_1_1.time_ < var_4_16 + var_4_17 and not isNil(var_4_15) then
				local var_4_18 = (arg_1_1.time_ - var_4_16) / var_4_17

				if arg_1_1.var_.characterEffect2030_tpose and not isNil(var_4_15) then
					arg_1_1.var_.characterEffect2030_tpose.fillFlat = false
				end
			end

			if arg_1_1.time_ >= var_4_16 + var_4_17 and arg_1_1.time_ < var_4_16 + var_4_17 + arg_4_0 and not isNil(var_4_15) and arg_1_1.var_.characterEffect2030_tpose then
				arg_1_1.var_.characterEffect2030_tpose.fillFlat = false
			end

			local var_4_19 = "B02b"

			if arg_1_1.bgs_[var_4_19] == nil then
				local var_4_20 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_20:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_19)
				var_4_20.name = var_4_19
				var_4_20.transform.parent = arg_1_1.stage_.transform
				var_4_20.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_19] = var_4_20
			end

			local var_4_21 = arg_1_1.bgs_.B02b
			local var_4_22 = 0

			if var_4_22 < arg_1_1.time_ and arg_1_1.time_ <= var_4_22 + arg_4_0 then
				local var_4_23 = var_4_21:GetComponent("SpriteRenderer")

				if var_4_23 then
					arg_1_1.var_.alphaOldValueB02b = var_4_23.color.a
					arg_1_1.var_.alphaMatValueB02b = var_4_23
				end

				arg_1_1.var_.alphaOldValueB02b = 0
			end

			local var_4_24 = 1.5

			if var_4_22 <= arg_1_1.time_ and arg_1_1.time_ < var_4_22 + var_4_24 then
				local var_4_25 = (arg_1_1.time_ - var_4_22) / var_4_24
				local var_4_26 = Mathf.Lerp(arg_1_1.var_.alphaOldValueB02b, 1, var_4_25)

				if arg_1_1.var_.alphaMatValueB02b then
					local var_4_27 = arg_1_1.var_.alphaMatValueB02b.color

					var_4_27.a = var_4_26
					arg_1_1.var_.alphaMatValueB02b.color = var_4_27
				end
			end

			if arg_1_1.time_ >= var_4_22 + var_4_24 and arg_1_1.time_ < var_4_22 + var_4_24 + arg_4_0 and arg_1_1.var_.alphaMatValueB02b then
				local var_4_28 = arg_1_1.var_.alphaMatValueB02b
				local var_4_29 = var_4_28.color

				var_4_29.a = 1
				var_4_28.color = var_4_29
			end

			local var_4_30 = 0

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				local var_4_31 = manager.ui.mainCamera.transform.localPosition
				local var_4_32 = Vector3.New(0, 0, 10) + Vector3.New(var_4_31.x, var_4_31.y, 0)
				local var_4_33 = arg_1_1.bgs_.B02b

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
					if iter_4_0 ~= "B02b" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_44 = arg_1_1.actors_["2030_tpose"].transform
			local var_4_45 = 1.79999995231628

			if var_4_45 < arg_1_1.time_ and arg_1_1.time_ <= var_4_45 + arg_4_0 then
				arg_1_1.var_.moveOldPos2030_tpose = var_4_44.localPosition

				local var_4_46 = GameObjectTools.GetOrAddComponent(var_4_44.gameObject, typeof(DynamicBoneHelper))

				if var_4_46 then
					var_4_46:EnableDynamicBone(false)
				end
			end

			local var_4_47 = 0.001

			if var_4_45 <= arg_1_1.time_ and arg_1_1.time_ < var_4_45 + var_4_47 then
				local var_4_48 = (arg_1_1.time_ - var_4_45) / var_4_47
				local var_4_49 = Vector3.New(-0.7, -1.2, -4.2)

				var_4_44.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos2030_tpose, var_4_49, var_4_48)

				local var_4_50 = manager.ui.mainCamera.transform.position - var_4_44.position

				var_4_44.forward = Vector3.New(var_4_50.x, var_4_50.y, var_4_50.z)

				local var_4_51 = var_4_44.localEulerAngles

				var_4_51.z = 0
				var_4_51.x = 0
				var_4_44.localEulerAngles = var_4_51
			end

			if arg_1_1.time_ >= var_4_45 + var_4_47 and arg_1_1.time_ < var_4_45 + var_4_47 + arg_4_0 then
				var_4_44.localPosition = Vector3.New(-0.7, -1.2, -4.2)

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
				arg_1_1:PlayTimeline("2030_tpose", "StoryTimeline/CharAction/story2030/story2030action/2030action1_1")
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
			local var_4_59 = 0.45

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

				local var_4_62 = arg_1_1:GetWordFromCfg(101081001)
				local var_4_63 = arg_1_1:FormatText(var_4_62.content)

				arg_1_1.text_.text = var_4_63

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_64 = 18
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

				if manager.audio:GetVoiceLength("story_v_out_101081", "101081001", "story_v_out_101081.awb") ~= 0 then
					local var_4_67 = manager.audio:GetVoiceLength("story_v_out_101081", "101081001", "story_v_out_101081.awb") / 1000

					if var_4_67 + var_4_58 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_67 + var_4_58
					end

					if var_4_62.prefab_name ~= "" and arg_1_1.actors_[var_4_62.prefab_name] ~= nil then
						local var_4_68 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_62.prefab_name].transform, "story_v_out_101081", "101081001", "story_v_out_101081.awb")

						arg_1_1:RecordAudio("101081001", var_4_68)
						arg_1_1:RecordAudio("101081001", var_4_68)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_101081", "101081001", "story_v_out_101081.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_101081", "101081001", "story_v_out_101081.awb")
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
				actorName = "2030_tpose",
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
	Play101081002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 101081002
		arg_8_1.duration_ = 4.47

		local var_8_0 = {
			ja = 4.466,
			ko = 3.666,
			zh = 3.133,
			en = 3.566
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
				arg_8_0:Play101081003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = "2020_tpose"

			if arg_8_1.actors_[var_11_0] == nil then
				local var_11_1 = Asset.Load("Char/" .. "2020_tpose")

				if not isNil(var_11_1) then
					local var_11_2 = Object.Instantiate(Asset.Load("Char/" .. "2020_tpose"), arg_8_1.stage_.transform)

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

			local var_11_5 = arg_8_1.actors_["2020_tpose"]
			local var_11_6 = 0

			if var_11_6 < arg_8_1.time_ and arg_8_1.time_ <= var_11_6 + arg_11_0 and not isNil(var_11_5) and arg_8_1.var_.characterEffect2020_tpose == nil then
				arg_8_1.var_.characterEffect2020_tpose = var_11_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_7 = 0.1

			if var_11_6 <= arg_8_1.time_ and arg_8_1.time_ < var_11_6 + var_11_7 and not isNil(var_11_5) then
				local var_11_8 = (arg_8_1.time_ - var_11_6) / var_11_7

				if arg_8_1.var_.characterEffect2020_tpose and not isNil(var_11_5) then
					arg_8_1.var_.characterEffect2020_tpose.fillFlat = false
				end
			end

			if arg_8_1.time_ >= var_11_6 + var_11_7 and arg_8_1.time_ < var_11_6 + var_11_7 + arg_11_0 and not isNil(var_11_5) and arg_8_1.var_.characterEffect2020_tpose then
				arg_8_1.var_.characterEffect2020_tpose.fillFlat = false
			end

			local var_11_9 = arg_8_1.actors_["2030_tpose"]
			local var_11_10 = 0

			if var_11_10 < arg_8_1.time_ and arg_8_1.time_ <= var_11_10 + arg_11_0 and not isNil(var_11_9) and arg_8_1.var_.characterEffect2030_tpose == nil then
				arg_8_1.var_.characterEffect2030_tpose = var_11_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_11 = 0.1

			if var_11_10 <= arg_8_1.time_ and arg_8_1.time_ < var_11_10 + var_11_11 and not isNil(var_11_9) then
				local var_11_12 = (arg_8_1.time_ - var_11_10) / var_11_11

				if arg_8_1.var_.characterEffect2030_tpose and not isNil(var_11_9) then
					local var_11_13 = Mathf.Lerp(0, 0.5, var_11_12)

					arg_8_1.var_.characterEffect2030_tpose.fillFlat = true
					arg_8_1.var_.characterEffect2030_tpose.fillRatio = var_11_13
				end
			end

			if arg_8_1.time_ >= var_11_10 + var_11_11 and arg_8_1.time_ < var_11_10 + var_11_11 + arg_11_0 and not isNil(var_11_9) and arg_8_1.var_.characterEffect2030_tpose then
				local var_11_14 = 0.5

				arg_8_1.var_.characterEffect2030_tpose.fillFlat = true
				arg_8_1.var_.characterEffect2030_tpose.fillRatio = var_11_14
			end

			local var_11_15 = arg_8_1.actors_["2020_tpose"].transform
			local var_11_16 = 0

			if var_11_16 < arg_8_1.time_ and arg_8_1.time_ <= var_11_16 + arg_11_0 then
				arg_8_1.var_.moveOldPos2020_tpose = var_11_15.localPosition

				local var_11_17 = GameObjectTools.GetOrAddComponent(var_11_15.gameObject, typeof(DynamicBoneHelper))

				if var_11_17 then
					var_11_17:EnableDynamicBone(false)
				end
			end

			local var_11_18 = 0.001

			if var_11_16 <= arg_8_1.time_ and arg_8_1.time_ < var_11_16 + var_11_18 then
				local var_11_19 = (arg_8_1.time_ - var_11_16) / var_11_18
				local var_11_20 = Vector3.New(0.7, -1.2, -4.1)

				var_11_15.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos2020_tpose, var_11_20, var_11_19)

				local var_11_21 = manager.ui.mainCamera.transform.position - var_11_15.position

				var_11_15.forward = Vector3.New(var_11_21.x, var_11_21.y, var_11_21.z)

				local var_11_22 = var_11_15.localEulerAngles

				var_11_22.z = 0
				var_11_22.x = 0
				var_11_15.localEulerAngles = var_11_22
			end

			if arg_8_1.time_ >= var_11_16 + var_11_18 and arg_8_1.time_ < var_11_16 + var_11_18 + arg_11_0 then
				var_11_15.localPosition = Vector3.New(0.7, -1.2, -4.1)

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
				arg_8_1:PlayTimeline("2020_tpose", "StoryTimeline/CharAction/story2020/story2020action/2020action1_1")
			end

			local var_11_27 = 0
			local var_11_28 = 0.325

			if var_11_27 < arg_8_1.time_ and arg_8_1.time_ <= var_11_27 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				local var_11_29 = arg_8_1:FormatText(StoryNameCfg[38].name)

				arg_8_1.leftNameTxt_.text = var_11_29

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_30 = arg_8_1:GetWordFromCfg(101081002)
				local var_11_31 = arg_8_1:FormatText(var_11_30.content)

				arg_8_1.text_.text = var_11_31

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_32 = 13
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

				if manager.audio:GetVoiceLength("story_v_out_101081", "101081002", "story_v_out_101081.awb") ~= 0 then
					local var_11_35 = manager.audio:GetVoiceLength("story_v_out_101081", "101081002", "story_v_out_101081.awb") / 1000

					if var_11_35 + var_11_27 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_35 + var_11_27
					end

					if var_11_30.prefab_name ~= "" and arg_8_1.actors_[var_11_30.prefab_name] ~= nil then
						local var_11_36 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_30.prefab_name].transform, "story_v_out_101081", "101081002", "story_v_out_101081.awb")

						arg_8_1:RecordAudio("101081002", var_11_36)
						arg_8_1:RecordAudio("101081002", var_11_36)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_101081", "101081002", "story_v_out_101081.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_101081", "101081002", "story_v_out_101081.awb")
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
				actorName = "2020_tpose",
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
	Play101081003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 101081003
		arg_12_1.duration_ = 8.13

		local var_12_0 = {
			ja = 5.7,
			ko = 5.7,
			zh = 4.433,
			en = 8.133
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
				arg_12_0:Play101081004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = arg_12_1.actors_["2030_tpose"]
			local var_15_1 = 0

			if var_15_1 < arg_12_1.time_ and arg_12_1.time_ <= var_15_1 + arg_15_0 and not isNil(var_15_0) and arg_12_1.var_.characterEffect2030_tpose == nil then
				arg_12_1.var_.characterEffect2030_tpose = var_15_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_2 = 0.1

			if var_15_1 <= arg_12_1.time_ and arg_12_1.time_ < var_15_1 + var_15_2 and not isNil(var_15_0) then
				local var_15_3 = (arg_12_1.time_ - var_15_1) / var_15_2

				if arg_12_1.var_.characterEffect2030_tpose and not isNil(var_15_0) then
					arg_12_1.var_.characterEffect2030_tpose.fillFlat = false
				end
			end

			if arg_12_1.time_ >= var_15_1 + var_15_2 and arg_12_1.time_ < var_15_1 + var_15_2 + arg_15_0 and not isNil(var_15_0) and arg_12_1.var_.characterEffect2030_tpose then
				arg_12_1.var_.characterEffect2030_tpose.fillFlat = false
			end

			local var_15_4 = arg_12_1.actors_["2020_tpose"]
			local var_15_5 = 0

			if var_15_5 < arg_12_1.time_ and arg_12_1.time_ <= var_15_5 + arg_15_0 and not isNil(var_15_4) and arg_12_1.var_.characterEffect2020_tpose == nil then
				arg_12_1.var_.characterEffect2020_tpose = var_15_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_6 = 0.1

			if var_15_5 <= arg_12_1.time_ and arg_12_1.time_ < var_15_5 + var_15_6 and not isNil(var_15_4) then
				local var_15_7 = (arg_12_1.time_ - var_15_5) / var_15_6

				if arg_12_1.var_.characterEffect2020_tpose and not isNil(var_15_4) then
					local var_15_8 = Mathf.Lerp(0, 0.5, var_15_7)

					arg_12_1.var_.characterEffect2020_tpose.fillFlat = true
					arg_12_1.var_.characterEffect2020_tpose.fillRatio = var_15_8
				end
			end

			if arg_12_1.time_ >= var_15_5 + var_15_6 and arg_12_1.time_ < var_15_5 + var_15_6 + arg_15_0 and not isNil(var_15_4) and arg_12_1.var_.characterEffect2020_tpose then
				local var_15_9 = 0.5

				arg_12_1.var_.characterEffect2020_tpose.fillFlat = true
				arg_12_1.var_.characterEffect2020_tpose.fillRatio = var_15_9
			end

			local var_15_10 = 0
			local var_15_11 = 0.6

			if var_15_10 < arg_12_1.time_ and arg_12_1.time_ <= var_15_10 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				local var_15_12 = arg_12_1:FormatText(StoryNameCfg[19].name)

				arg_12_1.leftNameTxt_.text = var_15_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_13 = arg_12_1:GetWordFromCfg(101081003)
				local var_15_14 = arg_12_1:FormatText(var_15_13.content)

				arg_12_1.text_.text = var_15_14

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_15 = 24
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

				if manager.audio:GetVoiceLength("story_v_out_101081", "101081003", "story_v_out_101081.awb") ~= 0 then
					local var_15_18 = manager.audio:GetVoiceLength("story_v_out_101081", "101081003", "story_v_out_101081.awb") / 1000

					if var_15_18 + var_15_10 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_18 + var_15_10
					end

					if var_15_13.prefab_name ~= "" and arg_12_1.actors_[var_15_13.prefab_name] ~= nil then
						local var_15_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_13.prefab_name].transform, "story_v_out_101081", "101081003", "story_v_out_101081.awb")

						arg_12_1:RecordAudio("101081003", var_15_19)
						arg_12_1:RecordAudio("101081003", var_15_19)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_101081", "101081003", "story_v_out_101081.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_101081", "101081003", "story_v_out_101081.awb")
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
	Play101081004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 101081004
		arg_16_1.duration_ = 3.7

		local var_16_0 = {
			ja = 3.7,
			ko = 3.466,
			zh = 2.8,
			en = 2.966
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
				arg_16_0:Play101081005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = arg_16_1.actors_["2020_tpose"]
			local var_19_1 = 0

			if var_19_1 < arg_16_1.time_ and arg_16_1.time_ <= var_19_1 + arg_19_0 and not isNil(var_19_0) and arg_16_1.var_.characterEffect2020_tpose == nil then
				arg_16_1.var_.characterEffect2020_tpose = var_19_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_2 = 0.1

			if var_19_1 <= arg_16_1.time_ and arg_16_1.time_ < var_19_1 + var_19_2 and not isNil(var_19_0) then
				local var_19_3 = (arg_16_1.time_ - var_19_1) / var_19_2

				if arg_16_1.var_.characterEffect2020_tpose and not isNil(var_19_0) then
					arg_16_1.var_.characterEffect2020_tpose.fillFlat = false
				end
			end

			if arg_16_1.time_ >= var_19_1 + var_19_2 and arg_16_1.time_ < var_19_1 + var_19_2 + arg_19_0 and not isNil(var_19_0) and arg_16_1.var_.characterEffect2020_tpose then
				arg_16_1.var_.characterEffect2020_tpose.fillFlat = false
			end

			local var_19_4 = arg_16_1.actors_["2030_tpose"]
			local var_19_5 = 0

			if var_19_5 < arg_16_1.time_ and arg_16_1.time_ <= var_19_5 + arg_19_0 and not isNil(var_19_4) and arg_16_1.var_.characterEffect2030_tpose == nil then
				arg_16_1.var_.characterEffect2030_tpose = var_19_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_6 = 0.1

			if var_19_5 <= arg_16_1.time_ and arg_16_1.time_ < var_19_5 + var_19_6 and not isNil(var_19_4) then
				local var_19_7 = (arg_16_1.time_ - var_19_5) / var_19_6

				if arg_16_1.var_.characterEffect2030_tpose and not isNil(var_19_4) then
					local var_19_8 = Mathf.Lerp(0, 0.5, var_19_7)

					arg_16_1.var_.characterEffect2030_tpose.fillFlat = true
					arg_16_1.var_.characterEffect2030_tpose.fillRatio = var_19_8
				end
			end

			if arg_16_1.time_ >= var_19_5 + var_19_6 and arg_16_1.time_ < var_19_5 + var_19_6 + arg_19_0 and not isNil(var_19_4) and arg_16_1.var_.characterEffect2030_tpose then
				local var_19_9 = 0.5

				arg_16_1.var_.characterEffect2030_tpose.fillFlat = true
				arg_16_1.var_.characterEffect2030_tpose.fillRatio = var_19_9
			end

			local var_19_10 = 0
			local var_19_11 = 0.25

			if var_19_10 < arg_16_1.time_ and arg_16_1.time_ <= var_19_10 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				local var_19_12 = arg_16_1:FormatText(StoryNameCfg[38].name)

				arg_16_1.leftNameTxt_.text = var_19_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_13 = arg_16_1:GetWordFromCfg(101081004)
				local var_19_14 = arg_16_1:FormatText(var_19_13.content)

				arg_16_1.text_.text = var_19_14

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_15 = 10
				local var_19_16 = utf8.len(var_19_14)
				local var_19_17 = var_19_15 <= 0 and var_19_11 or var_19_11 * (var_19_16 / var_19_15)

				if var_19_17 > 0 and var_19_11 < var_19_17 then
					arg_16_1.talkMaxDuration = var_19_17

					if var_19_17 + var_19_10 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_17 + var_19_10
					end
				end

				arg_16_1.text_.text = var_19_14
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101081", "101081004", "story_v_out_101081.awb") ~= 0 then
					local var_19_18 = manager.audio:GetVoiceLength("story_v_out_101081", "101081004", "story_v_out_101081.awb") / 1000

					if var_19_18 + var_19_10 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_18 + var_19_10
					end

					if var_19_13.prefab_name ~= "" and arg_16_1.actors_[var_19_13.prefab_name] ~= nil then
						local var_19_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_13.prefab_name].transform, "story_v_out_101081", "101081004", "story_v_out_101081.awb")

						arg_16_1:RecordAudio("101081004", var_19_19)
						arg_16_1:RecordAudio("101081004", var_19_19)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_101081", "101081004", "story_v_out_101081.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_101081", "101081004", "story_v_out_101081.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_20 = math.max(var_19_11, arg_16_1.talkMaxDuration)

			if var_19_10 <= arg_16_1.time_ and arg_16_1.time_ < var_19_10 + var_19_20 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_10) / var_19_20

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_10 + var_19_20 and arg_16_1.time_ < var_19_10 + var_19_20 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play101081005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 101081005
		arg_20_1.duration_ = 6.57

		local var_20_0 = {
			ja = 6.366,
			ko = 4.733,
			zh = 5.4,
			en = 6.566
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
				arg_20_0:Play101081006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = arg_20_1.actors_["2030_tpose"]
			local var_23_1 = 0

			if var_23_1 < arg_20_1.time_ and arg_20_1.time_ <= var_23_1 + arg_23_0 and not isNil(var_23_0) and arg_20_1.var_.characterEffect2030_tpose == nil then
				arg_20_1.var_.characterEffect2030_tpose = var_23_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_2 = 0.1

			if var_23_1 <= arg_20_1.time_ and arg_20_1.time_ < var_23_1 + var_23_2 and not isNil(var_23_0) then
				local var_23_3 = (arg_20_1.time_ - var_23_1) / var_23_2

				if arg_20_1.var_.characterEffect2030_tpose and not isNil(var_23_0) then
					arg_20_1.var_.characterEffect2030_tpose.fillFlat = false
				end
			end

			if arg_20_1.time_ >= var_23_1 + var_23_2 and arg_20_1.time_ < var_23_1 + var_23_2 + arg_23_0 and not isNil(var_23_0) and arg_20_1.var_.characterEffect2030_tpose then
				arg_20_1.var_.characterEffect2030_tpose.fillFlat = false
			end

			local var_23_4 = arg_20_1.actors_["2020_tpose"]
			local var_23_5 = 0

			if var_23_5 < arg_20_1.time_ and arg_20_1.time_ <= var_23_5 + arg_23_0 and not isNil(var_23_4) and arg_20_1.var_.characterEffect2020_tpose == nil then
				arg_20_1.var_.characterEffect2020_tpose = var_23_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_6 = 0.1

			if var_23_5 <= arg_20_1.time_ and arg_20_1.time_ < var_23_5 + var_23_6 and not isNil(var_23_4) then
				local var_23_7 = (arg_20_1.time_ - var_23_5) / var_23_6

				if arg_20_1.var_.characterEffect2020_tpose and not isNil(var_23_4) then
					local var_23_8 = Mathf.Lerp(0, 0.5, var_23_7)

					arg_20_1.var_.characterEffect2020_tpose.fillFlat = true
					arg_20_1.var_.characterEffect2020_tpose.fillRatio = var_23_8
				end
			end

			if arg_20_1.time_ >= var_23_5 + var_23_6 and arg_20_1.time_ < var_23_5 + var_23_6 + arg_23_0 and not isNil(var_23_4) and arg_20_1.var_.characterEffect2020_tpose then
				local var_23_9 = 0.5

				arg_20_1.var_.characterEffect2020_tpose.fillFlat = true
				arg_20_1.var_.characterEffect2020_tpose.fillRatio = var_23_9
			end

			local var_23_10 = 0
			local var_23_11 = 0.55

			if var_23_10 < arg_20_1.time_ and arg_20_1.time_ <= var_23_10 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				local var_23_12 = arg_20_1:FormatText(StoryNameCfg[19].name)

				arg_20_1.leftNameTxt_.text = var_23_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_13 = arg_20_1:GetWordFromCfg(101081005)
				local var_23_14 = arg_20_1:FormatText(var_23_13.content)

				arg_20_1.text_.text = var_23_14

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_15 = 22
				local var_23_16 = utf8.len(var_23_14)
				local var_23_17 = var_23_15 <= 0 and var_23_11 or var_23_11 * (var_23_16 / var_23_15)

				if var_23_17 > 0 and var_23_11 < var_23_17 then
					arg_20_1.talkMaxDuration = var_23_17

					if var_23_17 + var_23_10 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_17 + var_23_10
					end
				end

				arg_20_1.text_.text = var_23_14
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101081", "101081005", "story_v_out_101081.awb") ~= 0 then
					local var_23_18 = manager.audio:GetVoiceLength("story_v_out_101081", "101081005", "story_v_out_101081.awb") / 1000

					if var_23_18 + var_23_10 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_18 + var_23_10
					end

					if var_23_13.prefab_name ~= "" and arg_20_1.actors_[var_23_13.prefab_name] ~= nil then
						local var_23_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_13.prefab_name].transform, "story_v_out_101081", "101081005", "story_v_out_101081.awb")

						arg_20_1:RecordAudio("101081005", var_23_19)
						arg_20_1:RecordAudio("101081005", var_23_19)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_101081", "101081005", "story_v_out_101081.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_101081", "101081005", "story_v_out_101081.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_20 = math.max(var_23_11, arg_20_1.talkMaxDuration)

			if var_23_10 <= arg_20_1.time_ and arg_20_1.time_ < var_23_10 + var_23_20 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_10) / var_23_20

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_10 + var_23_20 and arg_20_1.time_ < var_23_10 + var_23_20 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play101081006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 101081006
		arg_24_1.duration_ = 2.53

		local var_24_0 = {
			ja = 2.533,
			ko = 1.133,
			zh = 1.266,
			en = 1.233
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
				arg_24_0:Play101081007(arg_24_1)
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
					arg_24_1.var_.characterEffect2020_tpose.fillFlat = false
				end
			end

			if arg_24_1.time_ >= var_27_1 + var_27_2 and arg_24_1.time_ < var_27_1 + var_27_2 + arg_27_0 and not isNil(var_27_0) and arg_24_1.var_.characterEffect2020_tpose then
				arg_24_1.var_.characterEffect2020_tpose.fillFlat = false
			end

			local var_27_4 = arg_24_1.actors_["2030_tpose"]
			local var_27_5 = 0

			if var_27_5 < arg_24_1.time_ and arg_24_1.time_ <= var_27_5 + arg_27_0 and not isNil(var_27_4) and arg_24_1.var_.characterEffect2030_tpose == nil then
				arg_24_1.var_.characterEffect2030_tpose = var_27_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_6 = 0.1

			if var_27_5 <= arg_24_1.time_ and arg_24_1.time_ < var_27_5 + var_27_6 and not isNil(var_27_4) then
				local var_27_7 = (arg_24_1.time_ - var_27_5) / var_27_6

				if arg_24_1.var_.characterEffect2030_tpose and not isNil(var_27_4) then
					local var_27_8 = Mathf.Lerp(0, 0.5, var_27_7)

					arg_24_1.var_.characterEffect2030_tpose.fillFlat = true
					arg_24_1.var_.characterEffect2030_tpose.fillRatio = var_27_8
				end
			end

			if arg_24_1.time_ >= var_27_5 + var_27_6 and arg_24_1.time_ < var_27_5 + var_27_6 + arg_27_0 and not isNil(var_27_4) and arg_24_1.var_.characterEffect2030_tpose then
				local var_27_9 = 0.5

				arg_24_1.var_.characterEffect2030_tpose.fillFlat = true
				arg_24_1.var_.characterEffect2030_tpose.fillRatio = var_27_9
			end

			local var_27_10 = 0
			local var_27_11 = 0.125

			if var_27_10 < arg_24_1.time_ and arg_24_1.time_ <= var_27_10 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				local var_27_12 = arg_24_1:FormatText(StoryNameCfg[38].name)

				arg_24_1.leftNameTxt_.text = var_27_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_13 = arg_24_1:GetWordFromCfg(101081006)
				local var_27_14 = arg_24_1:FormatText(var_27_13.content)

				arg_24_1.text_.text = var_27_14

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_15 = 5
				local var_27_16 = utf8.len(var_27_14)
				local var_27_17 = var_27_15 <= 0 and var_27_11 or var_27_11 * (var_27_16 / var_27_15)

				if var_27_17 > 0 and var_27_11 < var_27_17 then
					arg_24_1.talkMaxDuration = var_27_17

					if var_27_17 + var_27_10 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_17 + var_27_10
					end
				end

				arg_24_1.text_.text = var_27_14
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101081", "101081006", "story_v_out_101081.awb") ~= 0 then
					local var_27_18 = manager.audio:GetVoiceLength("story_v_out_101081", "101081006", "story_v_out_101081.awb") / 1000

					if var_27_18 + var_27_10 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_18 + var_27_10
					end

					if var_27_13.prefab_name ~= "" and arg_24_1.actors_[var_27_13.prefab_name] ~= nil then
						local var_27_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_13.prefab_name].transform, "story_v_out_101081", "101081006", "story_v_out_101081.awb")

						arg_24_1:RecordAudio("101081006", var_27_19)
						arg_24_1:RecordAudio("101081006", var_27_19)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_101081", "101081006", "story_v_out_101081.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_101081", "101081006", "story_v_out_101081.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_20 = math.max(var_27_11, arg_24_1.talkMaxDuration)

			if var_27_10 <= arg_24_1.time_ and arg_24_1.time_ < var_27_10 + var_27_20 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_10) / var_27_20

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_10 + var_27_20 and arg_24_1.time_ < var_27_10 + var_27_20 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play101081007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 101081007
		arg_28_1.duration_ = 5.8

		local var_28_0 = {
			ja = 5.8,
			ko = 3,
			zh = 4.933,
			en = 3.6
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
				arg_28_0:Play101081008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = arg_28_1.actors_["2030_tpose"]
			local var_31_1 = 0

			if var_31_1 < arg_28_1.time_ and arg_28_1.time_ <= var_31_1 + arg_31_0 and not isNil(var_31_0) and arg_28_1.var_.characterEffect2030_tpose == nil then
				arg_28_1.var_.characterEffect2030_tpose = var_31_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_2 = 0.1

			if var_31_1 <= arg_28_1.time_ and arg_28_1.time_ < var_31_1 + var_31_2 and not isNil(var_31_0) then
				local var_31_3 = (arg_28_1.time_ - var_31_1) / var_31_2

				if arg_28_1.var_.characterEffect2030_tpose and not isNil(var_31_0) then
					arg_28_1.var_.characterEffect2030_tpose.fillFlat = false
				end
			end

			if arg_28_1.time_ >= var_31_1 + var_31_2 and arg_28_1.time_ < var_31_1 + var_31_2 + arg_31_0 and not isNil(var_31_0) and arg_28_1.var_.characterEffect2030_tpose then
				arg_28_1.var_.characterEffect2030_tpose.fillFlat = false
			end

			local var_31_4 = arg_28_1.actors_["2020_tpose"]
			local var_31_5 = 0

			if var_31_5 < arg_28_1.time_ and arg_28_1.time_ <= var_31_5 + arg_31_0 and not isNil(var_31_4) and arg_28_1.var_.characterEffect2020_tpose == nil then
				arg_28_1.var_.characterEffect2020_tpose = var_31_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_6 = 0.1

			if var_31_5 <= arg_28_1.time_ and arg_28_1.time_ < var_31_5 + var_31_6 and not isNil(var_31_4) then
				local var_31_7 = (arg_28_1.time_ - var_31_5) / var_31_6

				if arg_28_1.var_.characterEffect2020_tpose and not isNil(var_31_4) then
					local var_31_8 = Mathf.Lerp(0, 0.5, var_31_7)

					arg_28_1.var_.characterEffect2020_tpose.fillFlat = true
					arg_28_1.var_.characterEffect2020_tpose.fillRatio = var_31_8
				end
			end

			if arg_28_1.time_ >= var_31_5 + var_31_6 and arg_28_1.time_ < var_31_5 + var_31_6 + arg_31_0 and not isNil(var_31_4) and arg_28_1.var_.characterEffect2020_tpose then
				local var_31_9 = 0.5

				arg_28_1.var_.characterEffect2020_tpose.fillFlat = true
				arg_28_1.var_.characterEffect2020_tpose.fillRatio = var_31_9
			end

			local var_31_10 = 0
			local var_31_11 = 0.425

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

				local var_31_13 = arg_28_1:GetWordFromCfg(101081007)
				local var_31_14 = arg_28_1:FormatText(var_31_13.content)

				arg_28_1.text_.text = var_31_14

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_15 = 17
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

				if manager.audio:GetVoiceLength("story_v_out_101081", "101081007", "story_v_out_101081.awb") ~= 0 then
					local var_31_18 = manager.audio:GetVoiceLength("story_v_out_101081", "101081007", "story_v_out_101081.awb") / 1000

					if var_31_18 + var_31_10 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_18 + var_31_10
					end

					if var_31_13.prefab_name ~= "" and arg_28_1.actors_[var_31_13.prefab_name] ~= nil then
						local var_31_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_13.prefab_name].transform, "story_v_out_101081", "101081007", "story_v_out_101081.awb")

						arg_28_1:RecordAudio("101081007", var_31_19)
						arg_28_1:RecordAudio("101081007", var_31_19)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_101081", "101081007", "story_v_out_101081.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_101081", "101081007", "story_v_out_101081.awb")
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
	Play101081008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 101081008
		arg_32_1.duration_ = 3.33

		local var_32_0 = {
			ja = 3.333,
			ko = 1.533,
			zh = 2,
			en = 1.333
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
				arg_32_0:Play101081009(arg_32_1)
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
					arg_32_1.var_.characterEffect2020_tpose.fillFlat = false
				end
			end

			if arg_32_1.time_ >= var_35_1 + var_35_2 and arg_32_1.time_ < var_35_1 + var_35_2 + arg_35_0 and not isNil(var_35_0) and arg_32_1.var_.characterEffect2020_tpose then
				arg_32_1.var_.characterEffect2020_tpose.fillFlat = false
			end

			local var_35_4 = arg_32_1.actors_["2030_tpose"]
			local var_35_5 = 0

			if var_35_5 < arg_32_1.time_ and arg_32_1.time_ <= var_35_5 + arg_35_0 and not isNil(var_35_4) and arg_32_1.var_.characterEffect2030_tpose == nil then
				arg_32_1.var_.characterEffect2030_tpose = var_35_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_6 = 0.1

			if var_35_5 <= arg_32_1.time_ and arg_32_1.time_ < var_35_5 + var_35_6 and not isNil(var_35_4) then
				local var_35_7 = (arg_32_1.time_ - var_35_5) / var_35_6

				if arg_32_1.var_.characterEffect2030_tpose and not isNil(var_35_4) then
					local var_35_8 = Mathf.Lerp(0, 0.5, var_35_7)

					arg_32_1.var_.characterEffect2030_tpose.fillFlat = true
					arg_32_1.var_.characterEffect2030_tpose.fillRatio = var_35_8
				end
			end

			if arg_32_1.time_ >= var_35_5 + var_35_6 and arg_32_1.time_ < var_35_5 + var_35_6 + arg_35_0 and not isNil(var_35_4) and arg_32_1.var_.characterEffect2030_tpose then
				local var_35_9 = 0.5

				arg_32_1.var_.characterEffect2030_tpose.fillFlat = true
				arg_32_1.var_.characterEffect2030_tpose.fillRatio = var_35_9
			end

			local var_35_10 = 0
			local var_35_11 = 0.15

			if var_35_10 < arg_32_1.time_ and arg_32_1.time_ <= var_35_10 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				local var_35_12 = arg_32_1:FormatText(StoryNameCfg[38].name)

				arg_32_1.leftNameTxt_.text = var_35_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_13 = arg_32_1:GetWordFromCfg(101081008)
				local var_35_14 = arg_32_1:FormatText(var_35_13.content)

				arg_32_1.text_.text = var_35_14

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_15 = 6
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

				if manager.audio:GetVoiceLength("story_v_out_101081", "101081008", "story_v_out_101081.awb") ~= 0 then
					local var_35_18 = manager.audio:GetVoiceLength("story_v_out_101081", "101081008", "story_v_out_101081.awb") / 1000

					if var_35_18 + var_35_10 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_18 + var_35_10
					end

					if var_35_13.prefab_name ~= "" and arg_32_1.actors_[var_35_13.prefab_name] ~= nil then
						local var_35_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_13.prefab_name].transform, "story_v_out_101081", "101081008", "story_v_out_101081.awb")

						arg_32_1:RecordAudio("101081008", var_35_19)
						arg_32_1:RecordAudio("101081008", var_35_19)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_101081", "101081008", "story_v_out_101081.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_101081", "101081008", "story_v_out_101081.awb")
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
	Play101081009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 101081009
		arg_36_1.duration_ = 5

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play101081010(arg_36_1)
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
					local var_39_4 = Mathf.Lerp(0, 0.5, var_39_3)

					arg_36_1.var_.characterEffect2020_tpose.fillFlat = true
					arg_36_1.var_.characterEffect2020_tpose.fillRatio = var_39_4
				end
			end

			if arg_36_1.time_ >= var_39_1 + var_39_2 and arg_36_1.time_ < var_39_1 + var_39_2 + arg_39_0 and not isNil(var_39_0) and arg_36_1.var_.characterEffect2020_tpose then
				local var_39_5 = 0.5

				arg_36_1.var_.characterEffect2020_tpose.fillFlat = true
				arg_36_1.var_.characterEffect2020_tpose.fillRatio = var_39_5
			end

			local var_39_6 = 0
			local var_39_7 = 0.725

			if var_39_6 < arg_36_1.time_ and arg_36_1.time_ <= var_39_6 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, false)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_8 = arg_36_1:GetWordFromCfg(101081009)
				local var_39_9 = arg_36_1:FormatText(var_39_8.content)

				arg_36_1.text_.text = var_39_9

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_10 = 29
				local var_39_11 = utf8.len(var_39_9)
				local var_39_12 = var_39_10 <= 0 and var_39_7 or var_39_7 * (var_39_11 / var_39_10)

				if var_39_12 > 0 and var_39_7 < var_39_12 then
					arg_36_1.talkMaxDuration = var_39_12

					if var_39_12 + var_39_6 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_12 + var_39_6
					end
				end

				arg_36_1.text_.text = var_39_9
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)
				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_13 = math.max(var_39_7, arg_36_1.talkMaxDuration)

			if var_39_6 <= arg_36_1.time_ and arg_36_1.time_ < var_39_6 + var_39_13 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_6) / var_39_13

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_6 + var_39_13 and arg_36_1.time_ < var_39_6 + var_39_13 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play101081010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 101081010
		arg_40_1.duration_ = 3.33

		local var_40_0 = {
			ja = 3.333,
			ko = 1.233,
			zh = 1.3,
			en = 1.266
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
				arg_40_0:Play101081011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = arg_40_1.actors_["2030_tpose"]
			local var_43_1 = 0

			if var_43_1 < arg_40_1.time_ and arg_40_1.time_ <= var_43_1 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.characterEffect2030_tpose == nil then
				arg_40_1.var_.characterEffect2030_tpose = var_43_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_2 = 0.1

			if var_43_1 <= arg_40_1.time_ and arg_40_1.time_ < var_43_1 + var_43_2 and not isNil(var_43_0) then
				local var_43_3 = (arg_40_1.time_ - var_43_1) / var_43_2

				if arg_40_1.var_.characterEffect2030_tpose and not isNil(var_43_0) then
					arg_40_1.var_.characterEffect2030_tpose.fillFlat = false
				end
			end

			if arg_40_1.time_ >= var_43_1 + var_43_2 and arg_40_1.time_ < var_43_1 + var_43_2 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.characterEffect2030_tpose then
				arg_40_1.var_.characterEffect2030_tpose.fillFlat = false
			end

			local var_43_4 = 0
			local var_43_5 = 0.1

			if var_43_4 < arg_40_1.time_ and arg_40_1.time_ <= var_43_4 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				local var_43_6 = arg_40_1:FormatText(StoryNameCfg[19].name)

				arg_40_1.leftNameTxt_.text = var_43_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_7 = arg_40_1:GetWordFromCfg(101081010)
				local var_43_8 = arg_40_1:FormatText(var_43_7.content)

				arg_40_1.text_.text = var_43_8

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_9 = 4
				local var_43_10 = utf8.len(var_43_8)
				local var_43_11 = var_43_9 <= 0 and var_43_5 or var_43_5 * (var_43_10 / var_43_9)

				if var_43_11 > 0 and var_43_5 < var_43_11 then
					arg_40_1.talkMaxDuration = var_43_11

					if var_43_11 + var_43_4 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_11 + var_43_4
					end
				end

				arg_40_1.text_.text = var_43_8
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101081", "101081010", "story_v_out_101081.awb") ~= 0 then
					local var_43_12 = manager.audio:GetVoiceLength("story_v_out_101081", "101081010", "story_v_out_101081.awb") / 1000

					if var_43_12 + var_43_4 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_12 + var_43_4
					end

					if var_43_7.prefab_name ~= "" and arg_40_1.actors_[var_43_7.prefab_name] ~= nil then
						local var_43_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_7.prefab_name].transform, "story_v_out_101081", "101081010", "story_v_out_101081.awb")

						arg_40_1:RecordAudio("101081010", var_43_13)
						arg_40_1:RecordAudio("101081010", var_43_13)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_101081", "101081010", "story_v_out_101081.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_101081", "101081010", "story_v_out_101081.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_14 = math.max(var_43_5, arg_40_1.talkMaxDuration)

			if var_43_4 <= arg_40_1.time_ and arg_40_1.time_ < var_43_4 + var_43_14 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_4) / var_43_14

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_4 + var_43_14 and arg_40_1.time_ < var_43_4 + var_43_14 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play101081011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 101081011
		arg_44_1.duration_ = 3.97

		local var_44_0 = {
			ja = 3.966,
			ko = 1.966,
			zh = 1.533,
			en = 1.766
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
				arg_44_0:Play101081012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = arg_44_1.actors_["2020_tpose"]
			local var_47_1 = 0

			if var_47_1 < arg_44_1.time_ and arg_44_1.time_ <= var_47_1 + arg_47_0 and not isNil(var_47_0) and arg_44_1.var_.characterEffect2020_tpose == nil then
				arg_44_1.var_.characterEffect2020_tpose = var_47_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_2 = 0.1

			if var_47_1 <= arg_44_1.time_ and arg_44_1.time_ < var_47_1 + var_47_2 and not isNil(var_47_0) then
				local var_47_3 = (arg_44_1.time_ - var_47_1) / var_47_2

				if arg_44_1.var_.characterEffect2020_tpose and not isNil(var_47_0) then
					arg_44_1.var_.characterEffect2020_tpose.fillFlat = false
				end
			end

			if arg_44_1.time_ >= var_47_1 + var_47_2 and arg_44_1.time_ < var_47_1 + var_47_2 + arg_47_0 and not isNil(var_47_0) and arg_44_1.var_.characterEffect2020_tpose then
				arg_44_1.var_.characterEffect2020_tpose.fillFlat = false
			end

			local var_47_4 = arg_44_1.actors_["2030_tpose"]
			local var_47_5 = 0

			if var_47_5 < arg_44_1.time_ and arg_44_1.time_ <= var_47_5 + arg_47_0 and not isNil(var_47_4) and arg_44_1.var_.characterEffect2030_tpose == nil then
				arg_44_1.var_.characterEffect2030_tpose = var_47_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_6 = 0.1

			if var_47_5 <= arg_44_1.time_ and arg_44_1.time_ < var_47_5 + var_47_6 and not isNil(var_47_4) then
				local var_47_7 = (arg_44_1.time_ - var_47_5) / var_47_6

				if arg_44_1.var_.characterEffect2030_tpose and not isNil(var_47_4) then
					local var_47_8 = Mathf.Lerp(0, 0.5, var_47_7)

					arg_44_1.var_.characterEffect2030_tpose.fillFlat = true
					arg_44_1.var_.characterEffect2030_tpose.fillRatio = var_47_8
				end
			end

			if arg_44_1.time_ >= var_47_5 + var_47_6 and arg_44_1.time_ < var_47_5 + var_47_6 + arg_47_0 and not isNil(var_47_4) and arg_44_1.var_.characterEffect2030_tpose then
				local var_47_9 = 0.5

				arg_44_1.var_.characterEffect2030_tpose.fillFlat = true
				arg_44_1.var_.characterEffect2030_tpose.fillRatio = var_47_9
			end

			local var_47_10 = 0
			local var_47_11 = 0.125

			if var_47_10 < arg_44_1.time_ and arg_44_1.time_ <= var_47_10 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				local var_47_12 = arg_44_1:FormatText(StoryNameCfg[38].name)

				arg_44_1.leftNameTxt_.text = var_47_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_13 = arg_44_1:GetWordFromCfg(101081011)
				local var_47_14 = arg_44_1:FormatText(var_47_13.content)

				arg_44_1.text_.text = var_47_14

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_15 = 5
				local var_47_16 = utf8.len(var_47_14)
				local var_47_17 = var_47_15 <= 0 and var_47_11 or var_47_11 * (var_47_16 / var_47_15)

				if var_47_17 > 0 and var_47_11 < var_47_17 then
					arg_44_1.talkMaxDuration = var_47_17

					if var_47_17 + var_47_10 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_17 + var_47_10
					end
				end

				arg_44_1.text_.text = var_47_14
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101081", "101081011", "story_v_out_101081.awb") ~= 0 then
					local var_47_18 = manager.audio:GetVoiceLength("story_v_out_101081", "101081011", "story_v_out_101081.awb") / 1000

					if var_47_18 + var_47_10 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_18 + var_47_10
					end

					if var_47_13.prefab_name ~= "" and arg_44_1.actors_[var_47_13.prefab_name] ~= nil then
						local var_47_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_13.prefab_name].transform, "story_v_out_101081", "101081011", "story_v_out_101081.awb")

						arg_44_1:RecordAudio("101081011", var_47_19)
						arg_44_1:RecordAudio("101081011", var_47_19)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_101081", "101081011", "story_v_out_101081.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_101081", "101081011", "story_v_out_101081.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_20 = math.max(var_47_11, arg_44_1.talkMaxDuration)

			if var_47_10 <= arg_44_1.time_ and arg_44_1.time_ < var_47_10 + var_47_20 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_10) / var_47_20

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_10 + var_47_20 and arg_44_1.time_ < var_47_10 + var_47_20 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play101081012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 101081012
		arg_48_1.duration_ = 4.6

		local var_48_0 = {
			ja = 4.6,
			ko = 2.866,
			zh = 3.4,
			en = 3.733
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
				arg_48_0:Play101081013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = arg_48_1.actors_["2030_tpose"]
			local var_51_1 = 0

			if var_51_1 < arg_48_1.time_ and arg_48_1.time_ <= var_51_1 + arg_51_0 and not isNil(var_51_0) and arg_48_1.var_.characterEffect2030_tpose == nil then
				arg_48_1.var_.characterEffect2030_tpose = var_51_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_2 = 0.1

			if var_51_1 <= arg_48_1.time_ and arg_48_1.time_ < var_51_1 + var_51_2 and not isNil(var_51_0) then
				local var_51_3 = (arg_48_1.time_ - var_51_1) / var_51_2

				if arg_48_1.var_.characterEffect2030_tpose and not isNil(var_51_0) then
					arg_48_1.var_.characterEffect2030_tpose.fillFlat = false
				end
			end

			if arg_48_1.time_ >= var_51_1 + var_51_2 and arg_48_1.time_ < var_51_1 + var_51_2 + arg_51_0 and not isNil(var_51_0) and arg_48_1.var_.characterEffect2030_tpose then
				arg_48_1.var_.characterEffect2030_tpose.fillFlat = false
			end

			local var_51_4 = arg_48_1.actors_["2020_tpose"]
			local var_51_5 = 0

			if var_51_5 < arg_48_1.time_ and arg_48_1.time_ <= var_51_5 + arg_51_0 and not isNil(var_51_4) and arg_48_1.var_.characterEffect2020_tpose == nil then
				arg_48_1.var_.characterEffect2020_tpose = var_51_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_6 = 0.1

			if var_51_5 <= arg_48_1.time_ and arg_48_1.time_ < var_51_5 + var_51_6 and not isNil(var_51_4) then
				local var_51_7 = (arg_48_1.time_ - var_51_5) / var_51_6

				if arg_48_1.var_.characterEffect2020_tpose and not isNil(var_51_4) then
					local var_51_8 = Mathf.Lerp(0, 0.5, var_51_7)

					arg_48_1.var_.characterEffect2020_tpose.fillFlat = true
					arg_48_1.var_.characterEffect2020_tpose.fillRatio = var_51_8
				end
			end

			if arg_48_1.time_ >= var_51_5 + var_51_6 and arg_48_1.time_ < var_51_5 + var_51_6 + arg_51_0 and not isNil(var_51_4) and arg_48_1.var_.characterEffect2020_tpose then
				local var_51_9 = 0.5

				arg_48_1.var_.characterEffect2020_tpose.fillFlat = true
				arg_48_1.var_.characterEffect2020_tpose.fillRatio = var_51_9
			end

			local var_51_10 = 0
			local var_51_11 = 0.25

			if var_51_10 < arg_48_1.time_ and arg_48_1.time_ <= var_51_10 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				local var_51_12 = arg_48_1:FormatText(StoryNameCfg[19].name)

				arg_48_1.leftNameTxt_.text = var_51_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_13 = arg_48_1:GetWordFromCfg(101081012)
				local var_51_14 = arg_48_1:FormatText(var_51_13.content)

				arg_48_1.text_.text = var_51_14

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_15 = 10
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

				if manager.audio:GetVoiceLength("story_v_out_101081", "101081012", "story_v_out_101081.awb") ~= 0 then
					local var_51_18 = manager.audio:GetVoiceLength("story_v_out_101081", "101081012", "story_v_out_101081.awb") / 1000

					if var_51_18 + var_51_10 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_18 + var_51_10
					end

					if var_51_13.prefab_name ~= "" and arg_48_1.actors_[var_51_13.prefab_name] ~= nil then
						local var_51_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_13.prefab_name].transform, "story_v_out_101081", "101081012", "story_v_out_101081.awb")

						arg_48_1:RecordAudio("101081012", var_51_19)
						arg_48_1:RecordAudio("101081012", var_51_19)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_101081", "101081012", "story_v_out_101081.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_101081", "101081012", "story_v_out_101081.awb")
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
	Play101081013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 101081013
		arg_52_1.duration_ = 6.97

		local var_52_0 = {
			ja = 6.9,
			ko = 6.166,
			zh = 6.833,
			en = 6.966
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
				arg_52_0:Play101081014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = arg_52_1.actors_["2020_tpose"]
			local var_55_1 = 0

			if var_55_1 < arg_52_1.time_ and arg_52_1.time_ <= var_55_1 + arg_55_0 and not isNil(var_55_0) and arg_52_1.var_.characterEffect2020_tpose == nil then
				arg_52_1.var_.characterEffect2020_tpose = var_55_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_2 = 0.1

			if var_55_1 <= arg_52_1.time_ and arg_52_1.time_ < var_55_1 + var_55_2 and not isNil(var_55_0) then
				local var_55_3 = (arg_52_1.time_ - var_55_1) / var_55_2

				if arg_52_1.var_.characterEffect2020_tpose and not isNil(var_55_0) then
					arg_52_1.var_.characterEffect2020_tpose.fillFlat = false
				end
			end

			if arg_52_1.time_ >= var_55_1 + var_55_2 and arg_52_1.time_ < var_55_1 + var_55_2 + arg_55_0 and not isNil(var_55_0) and arg_52_1.var_.characterEffect2020_tpose then
				arg_52_1.var_.characterEffect2020_tpose.fillFlat = false
			end

			local var_55_4 = arg_52_1.actors_["2030_tpose"]
			local var_55_5 = 0

			if var_55_5 < arg_52_1.time_ and arg_52_1.time_ <= var_55_5 + arg_55_0 and not isNil(var_55_4) and arg_52_1.var_.characterEffect2030_tpose == nil then
				arg_52_1.var_.characterEffect2030_tpose = var_55_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_6 = 0.1

			if var_55_5 <= arg_52_1.time_ and arg_52_1.time_ < var_55_5 + var_55_6 and not isNil(var_55_4) then
				local var_55_7 = (arg_52_1.time_ - var_55_5) / var_55_6

				if arg_52_1.var_.characterEffect2030_tpose and not isNil(var_55_4) then
					local var_55_8 = Mathf.Lerp(0, 0.5, var_55_7)

					arg_52_1.var_.characterEffect2030_tpose.fillFlat = true
					arg_52_1.var_.characterEffect2030_tpose.fillRatio = var_55_8
				end
			end

			if arg_52_1.time_ >= var_55_5 + var_55_6 and arg_52_1.time_ < var_55_5 + var_55_6 + arg_55_0 and not isNil(var_55_4) and arg_52_1.var_.characterEffect2030_tpose then
				local var_55_9 = 0.5

				arg_52_1.var_.characterEffect2030_tpose.fillFlat = true
				arg_52_1.var_.characterEffect2030_tpose.fillRatio = var_55_9
			end

			local var_55_10 = 0
			local var_55_11 = 0.675

			if var_55_10 < arg_52_1.time_ and arg_52_1.time_ <= var_55_10 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				local var_55_12 = arg_52_1:FormatText(StoryNameCfg[38].name)

				arg_52_1.leftNameTxt_.text = var_55_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_13 = arg_52_1:GetWordFromCfg(101081013)
				local var_55_14 = arg_52_1:FormatText(var_55_13.content)

				arg_52_1.text_.text = var_55_14

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_15 = 27
				local var_55_16 = utf8.len(var_55_14)
				local var_55_17 = var_55_15 <= 0 and var_55_11 or var_55_11 * (var_55_16 / var_55_15)

				if var_55_17 > 0 and var_55_11 < var_55_17 then
					arg_52_1.talkMaxDuration = var_55_17

					if var_55_17 + var_55_10 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_17 + var_55_10
					end
				end

				arg_52_1.text_.text = var_55_14
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101081", "101081013", "story_v_out_101081.awb") ~= 0 then
					local var_55_18 = manager.audio:GetVoiceLength("story_v_out_101081", "101081013", "story_v_out_101081.awb") / 1000

					if var_55_18 + var_55_10 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_18 + var_55_10
					end

					if var_55_13.prefab_name ~= "" and arg_52_1.actors_[var_55_13.prefab_name] ~= nil then
						local var_55_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_13.prefab_name].transform, "story_v_out_101081", "101081013", "story_v_out_101081.awb")

						arg_52_1:RecordAudio("101081013", var_55_19)
						arg_52_1:RecordAudio("101081013", var_55_19)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_101081", "101081013", "story_v_out_101081.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_101081", "101081013", "story_v_out_101081.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_20 = math.max(var_55_11, arg_52_1.talkMaxDuration)

			if var_55_10 <= arg_52_1.time_ and arg_52_1.time_ < var_55_10 + var_55_20 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_10) / var_55_20

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_10 + var_55_20 and arg_52_1.time_ < var_55_10 + var_55_20 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play101081014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 101081014
		arg_56_1.duration_ = 3.7

		local var_56_0 = {
			ja = 2.9,
			ko = 3.7,
			zh = 2.833,
			en = 2.3
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
				arg_56_0:Play101081015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = arg_56_1.actors_["2030_tpose"]
			local var_59_1 = 0

			if var_59_1 < arg_56_1.time_ and arg_56_1.time_ <= var_59_1 + arg_59_0 and not isNil(var_59_0) and arg_56_1.var_.characterEffect2030_tpose == nil then
				arg_56_1.var_.characterEffect2030_tpose = var_59_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_2 = 0.1

			if var_59_1 <= arg_56_1.time_ and arg_56_1.time_ < var_59_1 + var_59_2 and not isNil(var_59_0) then
				local var_59_3 = (arg_56_1.time_ - var_59_1) / var_59_2

				if arg_56_1.var_.characterEffect2030_tpose and not isNil(var_59_0) then
					arg_56_1.var_.characterEffect2030_tpose.fillFlat = false
				end
			end

			if arg_56_1.time_ >= var_59_1 + var_59_2 and arg_56_1.time_ < var_59_1 + var_59_2 + arg_59_0 and not isNil(var_59_0) and arg_56_1.var_.characterEffect2030_tpose then
				arg_56_1.var_.characterEffect2030_tpose.fillFlat = false
			end

			local var_59_4 = arg_56_1.actors_["2020_tpose"]
			local var_59_5 = 0

			if var_59_5 < arg_56_1.time_ and arg_56_1.time_ <= var_59_5 + arg_59_0 and not isNil(var_59_4) and arg_56_1.var_.characterEffect2020_tpose == nil then
				arg_56_1.var_.characterEffect2020_tpose = var_59_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_6 = 0.1

			if var_59_5 <= arg_56_1.time_ and arg_56_1.time_ < var_59_5 + var_59_6 and not isNil(var_59_4) then
				local var_59_7 = (arg_56_1.time_ - var_59_5) / var_59_6

				if arg_56_1.var_.characterEffect2020_tpose and not isNil(var_59_4) then
					local var_59_8 = Mathf.Lerp(0, 0.5, var_59_7)

					arg_56_1.var_.characterEffect2020_tpose.fillFlat = true
					arg_56_1.var_.characterEffect2020_tpose.fillRatio = var_59_8
				end
			end

			if arg_56_1.time_ >= var_59_5 + var_59_6 and arg_56_1.time_ < var_59_5 + var_59_6 + arg_59_0 and not isNil(var_59_4) and arg_56_1.var_.characterEffect2020_tpose then
				local var_59_9 = 0.5

				arg_56_1.var_.characterEffect2020_tpose.fillFlat = true
				arg_56_1.var_.characterEffect2020_tpose.fillRatio = var_59_9
			end

			local var_59_10 = 0
			local var_59_11 = 0.275

			if var_59_10 < arg_56_1.time_ and arg_56_1.time_ <= var_59_10 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				local var_59_12 = arg_56_1:FormatText(StoryNameCfg[19].name)

				arg_56_1.leftNameTxt_.text = var_59_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_13 = arg_56_1:GetWordFromCfg(101081014)
				local var_59_14 = arg_56_1:FormatText(var_59_13.content)

				arg_56_1.text_.text = var_59_14

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_15 = 11
				local var_59_16 = utf8.len(var_59_14)
				local var_59_17 = var_59_15 <= 0 and var_59_11 or var_59_11 * (var_59_16 / var_59_15)

				if var_59_17 > 0 and var_59_11 < var_59_17 then
					arg_56_1.talkMaxDuration = var_59_17

					if var_59_17 + var_59_10 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_17 + var_59_10
					end
				end

				arg_56_1.text_.text = var_59_14
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101081", "101081014", "story_v_out_101081.awb") ~= 0 then
					local var_59_18 = manager.audio:GetVoiceLength("story_v_out_101081", "101081014", "story_v_out_101081.awb") / 1000

					if var_59_18 + var_59_10 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_18 + var_59_10
					end

					if var_59_13.prefab_name ~= "" and arg_56_1.actors_[var_59_13.prefab_name] ~= nil then
						local var_59_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_13.prefab_name].transform, "story_v_out_101081", "101081014", "story_v_out_101081.awb")

						arg_56_1:RecordAudio("101081014", var_59_19)
						arg_56_1:RecordAudio("101081014", var_59_19)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_101081", "101081014", "story_v_out_101081.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_101081", "101081014", "story_v_out_101081.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_20 = math.max(var_59_11, arg_56_1.talkMaxDuration)

			if var_59_10 <= arg_56_1.time_ and arg_56_1.time_ < var_59_10 + var_59_20 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_10) / var_59_20

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_10 + var_59_20 and arg_56_1.time_ < var_59_10 + var_59_20 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play101081015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 101081015
		arg_60_1.duration_ = 5

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play101081016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = arg_60_1.actors_["2030_tpose"]
			local var_63_1 = 0

			if var_63_1 < arg_60_1.time_ and arg_60_1.time_ <= var_63_1 + arg_63_0 and not isNil(var_63_0) and arg_60_1.var_.characterEffect2030_tpose == nil then
				arg_60_1.var_.characterEffect2030_tpose = var_63_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_2 = 0.1

			if var_63_1 <= arg_60_1.time_ and arg_60_1.time_ < var_63_1 + var_63_2 and not isNil(var_63_0) then
				local var_63_3 = (arg_60_1.time_ - var_63_1) / var_63_2

				if arg_60_1.var_.characterEffect2030_tpose and not isNil(var_63_0) then
					local var_63_4 = Mathf.Lerp(0, 0.5, var_63_3)

					arg_60_1.var_.characterEffect2030_tpose.fillFlat = true
					arg_60_1.var_.characterEffect2030_tpose.fillRatio = var_63_4
				end
			end

			if arg_60_1.time_ >= var_63_1 + var_63_2 and arg_60_1.time_ < var_63_1 + var_63_2 + arg_63_0 and not isNil(var_63_0) and arg_60_1.var_.characterEffect2030_tpose then
				local var_63_5 = 0.5

				arg_60_1.var_.characterEffect2030_tpose.fillFlat = true
				arg_60_1.var_.characterEffect2030_tpose.fillRatio = var_63_5
			end

			local var_63_6 = arg_60_1.actors_["2020_tpose"].transform
			local var_63_7 = 0

			if var_63_7 < arg_60_1.time_ and arg_60_1.time_ <= var_63_7 + arg_63_0 then
				arg_60_1.var_.moveOldPos2020_tpose = var_63_6.localPosition

				local var_63_8 = GameObjectTools.GetOrAddComponent(var_63_6.gameObject, typeof(DynamicBoneHelper))

				if var_63_8 then
					var_63_8:EnableDynamicBone(false)
				end
			end

			local var_63_9 = 0.001

			if var_63_7 <= arg_60_1.time_ and arg_60_1.time_ < var_63_7 + var_63_9 then
				local var_63_10 = (arg_60_1.time_ - var_63_7) / var_63_9
				local var_63_11 = Vector3.New(0, 100, 0)

				var_63_6.localPosition = Vector3.Lerp(arg_60_1.var_.moveOldPos2020_tpose, var_63_11, var_63_10)

				local var_63_12 = manager.ui.mainCamera.transform.position - var_63_6.position

				var_63_6.forward = Vector3.New(var_63_12.x, var_63_12.y, var_63_12.z)

				local var_63_13 = var_63_6.localEulerAngles

				var_63_13.z = 0
				var_63_13.x = 0
				var_63_6.localEulerAngles = var_63_13
			end

			if arg_60_1.time_ >= var_63_7 + var_63_9 and arg_60_1.time_ < var_63_7 + var_63_9 + arg_63_0 then
				var_63_6.localPosition = Vector3.New(0, 100, 0)

				local var_63_14 = manager.ui.mainCamera.transform.position - var_63_6.position

				var_63_6.forward = Vector3.New(var_63_14.x, var_63_14.y, var_63_14.z)

				local var_63_15 = var_63_6.localEulerAngles

				var_63_15.z = 0
				var_63_15.x = 0
				var_63_6.localEulerAngles = var_63_15

				local var_63_16 = GameObjectTools.GetOrAddComponent(var_63_6.gameObject, typeof(DynamicBoneHelper))

				if var_63_16 then
					var_63_16:EnableDynamicBone(true)
				end
			end

			local var_63_17 = arg_60_1.actors_["2030_tpose"].transform
			local var_63_18 = 0

			if var_63_18 < arg_60_1.time_ and arg_60_1.time_ <= var_63_18 + arg_63_0 then
				arg_60_1.var_.moveOldPos2030_tpose = var_63_17.localPosition

				local var_63_19 = GameObjectTools.GetOrAddComponent(var_63_17.gameObject, typeof(DynamicBoneHelper))

				if var_63_19 then
					var_63_19:EnableDynamicBone(false)
				end
			end

			local var_63_20 = 0.001

			if var_63_18 <= arg_60_1.time_ and arg_60_1.time_ < var_63_18 + var_63_20 then
				local var_63_21 = (arg_60_1.time_ - var_63_18) / var_63_20
				local var_63_22 = Vector3.New(0, 100, 0)

				var_63_17.localPosition = Vector3.Lerp(arg_60_1.var_.moveOldPos2030_tpose, var_63_22, var_63_21)

				local var_63_23 = manager.ui.mainCamera.transform.position - var_63_17.position

				var_63_17.forward = Vector3.New(var_63_23.x, var_63_23.y, var_63_23.z)

				local var_63_24 = var_63_17.localEulerAngles

				var_63_24.z = 0
				var_63_24.x = 0
				var_63_17.localEulerAngles = var_63_24
			end

			if arg_60_1.time_ >= var_63_18 + var_63_20 and arg_60_1.time_ < var_63_18 + var_63_20 + arg_63_0 then
				var_63_17.localPosition = Vector3.New(0, 100, 0)

				local var_63_25 = manager.ui.mainCamera.transform.position - var_63_17.position

				var_63_17.forward = Vector3.New(var_63_25.x, var_63_25.y, var_63_25.z)

				local var_63_26 = var_63_17.localEulerAngles

				var_63_26.z = 0
				var_63_26.x = 0
				var_63_17.localEulerAngles = var_63_26

				local var_63_27 = GameObjectTools.GetOrAddComponent(var_63_17.gameObject, typeof(DynamicBoneHelper))

				if var_63_27 then
					var_63_27:EnableDynamicBone(true)
				end
			end

			local var_63_28 = 0
			local var_63_29 = 0.675

			if var_63_28 < arg_60_1.time_ and arg_60_1.time_ <= var_63_28 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, false)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_30 = arg_60_1:GetWordFromCfg(101081015)
				local var_63_31 = arg_60_1:FormatText(var_63_30.content)

				arg_60_1.text_.text = var_63_31

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_32 = 26
				local var_63_33 = utf8.len(var_63_31)
				local var_63_34 = var_63_32 <= 0 and var_63_29 or var_63_29 * (var_63_33 / var_63_32)

				if var_63_34 > 0 and var_63_29 < var_63_34 then
					arg_60_1.talkMaxDuration = var_63_34

					if var_63_34 + var_63_28 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_34 + var_63_28
					end
				end

				arg_60_1.text_.text = var_63_31
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)
				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_35 = math.max(var_63_29, arg_60_1.talkMaxDuration)

			if var_63_28 <= arg_60_1.time_ and arg_60_1.time_ < var_63_28 + var_63_35 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_28) / var_63_35

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_28 + var_63_35 and arg_60_1.time_ < var_63_28 + var_63_35 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {
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
			}
		}

		arg_60_1:InitPlayNodeList()
	end,
	Play101081016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 101081016
		arg_64_1.duration_ = 2.5

		local var_64_0 = {
			ja = 2.2,
			ko = 2.133,
			zh = 2.5,
			en = 2.433
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
				arg_64_0:Play101081017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = arg_64_1.actors_["2030_tpose"]
			local var_67_1 = 0

			if var_67_1 < arg_64_1.time_ and arg_64_1.time_ <= var_67_1 + arg_67_0 and not isNil(var_67_0) and arg_64_1.var_.characterEffect2030_tpose == nil then
				arg_64_1.var_.characterEffect2030_tpose = var_67_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_2 = 0.1

			if var_67_1 <= arg_64_1.time_ and arg_64_1.time_ < var_67_1 + var_67_2 and not isNil(var_67_0) then
				local var_67_3 = (arg_64_1.time_ - var_67_1) / var_67_2

				if arg_64_1.var_.characterEffect2030_tpose and not isNil(var_67_0) then
					arg_64_1.var_.characterEffect2030_tpose.fillFlat = false
				end
			end

			if arg_64_1.time_ >= var_67_1 + var_67_2 and arg_64_1.time_ < var_67_1 + var_67_2 + arg_67_0 and not isNil(var_67_0) and arg_64_1.var_.characterEffect2030_tpose then
				arg_64_1.var_.characterEffect2030_tpose.fillFlat = false
			end

			local var_67_4 = arg_64_1.actors_["2030_tpose"].transform
			local var_67_5 = 0

			if var_67_5 < arg_64_1.time_ and arg_64_1.time_ <= var_67_5 + arg_67_0 then
				arg_64_1.var_.moveOldPos2030_tpose = var_67_4.localPosition

				local var_67_6 = GameObjectTools.GetOrAddComponent(var_67_4.gameObject, typeof(DynamicBoneHelper))

				if var_67_6 then
					var_67_6:EnableDynamicBone(false)
				end
			end

			local var_67_7 = 0.001

			if var_67_5 <= arg_64_1.time_ and arg_64_1.time_ < var_67_5 + var_67_7 then
				local var_67_8 = (arg_64_1.time_ - var_67_5) / var_67_7
				local var_67_9 = Vector3.New(-0.7, -1.2, -4.2)

				var_67_4.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos2030_tpose, var_67_9, var_67_8)

				local var_67_10 = manager.ui.mainCamera.transform.position - var_67_4.position

				var_67_4.forward = Vector3.New(var_67_10.x, var_67_10.y, var_67_10.z)

				local var_67_11 = var_67_4.localEulerAngles

				var_67_11.z = 0
				var_67_11.x = 0
				var_67_4.localEulerAngles = var_67_11
			end

			if arg_64_1.time_ >= var_67_5 + var_67_7 and arg_64_1.time_ < var_67_5 + var_67_7 + arg_67_0 then
				var_67_4.localPosition = Vector3.New(-0.7, -1.2, -4.2)

				local var_67_12 = manager.ui.mainCamera.transform.position - var_67_4.position

				var_67_4.forward = Vector3.New(var_67_12.x, var_67_12.y, var_67_12.z)

				local var_67_13 = var_67_4.localEulerAngles

				var_67_13.z = 0
				var_67_13.x = 0
				var_67_4.localEulerAngles = var_67_13

				local var_67_14 = GameObjectTools.GetOrAddComponent(var_67_4.gameObject, typeof(DynamicBoneHelper))

				if var_67_14 then
					var_67_14:EnableDynamicBone(true)
				end
			end

			local var_67_15 = arg_64_1.actors_["2020_tpose"].transform
			local var_67_16 = 0

			if var_67_16 < arg_64_1.time_ and arg_64_1.time_ <= var_67_16 + arg_67_0 then
				arg_64_1.var_.moveOldPos2020_tpose = var_67_15.localPosition

				local var_67_17 = GameObjectTools.GetOrAddComponent(var_67_15.gameObject, typeof(DynamicBoneHelper))

				if var_67_17 then
					var_67_17:EnableDynamicBone(false)
				end
			end

			local var_67_18 = 0.001

			if var_67_16 <= arg_64_1.time_ and arg_64_1.time_ < var_67_16 + var_67_18 then
				local var_67_19 = (arg_64_1.time_ - var_67_16) / var_67_18
				local var_67_20 = Vector3.New(0.7, -1.2, -4.1)

				var_67_15.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos2020_tpose, var_67_20, var_67_19)

				local var_67_21 = manager.ui.mainCamera.transform.position - var_67_15.position

				var_67_15.forward = Vector3.New(var_67_21.x, var_67_21.y, var_67_21.z)

				local var_67_22 = var_67_15.localEulerAngles

				var_67_22.z = 0
				var_67_22.x = 0
				var_67_15.localEulerAngles = var_67_22
			end

			if arg_64_1.time_ >= var_67_16 + var_67_18 and arg_64_1.time_ < var_67_16 + var_67_18 + arg_67_0 then
				var_67_15.localPosition = Vector3.New(0.7, -1.2, -4.1)

				local var_67_23 = manager.ui.mainCamera.transform.position - var_67_15.position

				var_67_15.forward = Vector3.New(var_67_23.x, var_67_23.y, var_67_23.z)

				local var_67_24 = var_67_15.localEulerAngles

				var_67_24.z = 0
				var_67_24.x = 0
				var_67_15.localEulerAngles = var_67_24

				local var_67_25 = GameObjectTools.GetOrAddComponent(var_67_15.gameObject, typeof(DynamicBoneHelper))

				if var_67_25 then
					var_67_25:EnableDynamicBone(true)
				end
			end

			local var_67_26 = 0
			local var_67_27 = 0.2

			if var_67_26 < arg_64_1.time_ and arg_64_1.time_ <= var_67_26 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				local var_67_28 = arg_64_1:FormatText(StoryNameCfg[19].name)

				arg_64_1.leftNameTxt_.text = var_67_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_29 = arg_64_1:GetWordFromCfg(101081016)
				local var_67_30 = arg_64_1:FormatText(var_67_29.content)

				arg_64_1.text_.text = var_67_30

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_31 = 9
				local var_67_32 = utf8.len(var_67_30)
				local var_67_33 = var_67_31 <= 0 and var_67_27 or var_67_27 * (var_67_32 / var_67_31)

				if var_67_33 > 0 and var_67_27 < var_67_33 then
					arg_64_1.talkMaxDuration = var_67_33

					if var_67_33 + var_67_26 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_33 + var_67_26
					end
				end

				arg_64_1.text_.text = var_67_30
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101081", "101081016", "story_v_out_101081.awb") ~= 0 then
					local var_67_34 = manager.audio:GetVoiceLength("story_v_out_101081", "101081016", "story_v_out_101081.awb") / 1000

					if var_67_34 + var_67_26 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_34 + var_67_26
					end

					if var_67_29.prefab_name ~= "" and arg_64_1.actors_[var_67_29.prefab_name] ~= nil then
						local var_67_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_29.prefab_name].transform, "story_v_out_101081", "101081016", "story_v_out_101081.awb")

						arg_64_1:RecordAudio("101081016", var_67_35)
						arg_64_1:RecordAudio("101081016", var_67_35)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_101081", "101081016", "story_v_out_101081.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_101081", "101081016", "story_v_out_101081.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_36 = math.max(var_67_27, arg_64_1.talkMaxDuration)

			if var_67_26 <= arg_64_1.time_ and arg_64_1.time_ < var_67_26 + var_67_36 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_26) / var_67_36

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_26 + var_67_36 and arg_64_1.time_ < var_67_26 + var_67_36 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {
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
				actorName = "2020_tpose",
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
	Play101081017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 101081017
		arg_68_1.duration_ = 8.5

		local var_68_0 = {
			ja = 6.833,
			ko = 6.466,
			zh = 8.5,
			en = 7.9
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
				arg_68_0:Play101081018(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = 0
			local var_71_1 = 0.825

			if var_71_0 < arg_68_1.time_ and arg_68_1.time_ <= var_71_0 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				local var_71_2 = arg_68_1:FormatText(StoryNameCfg[19].name)

				arg_68_1.leftNameTxt_.text = var_71_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_3 = arg_68_1:GetWordFromCfg(101081017)
				local var_71_4 = arg_68_1:FormatText(var_71_3.content)

				arg_68_1.text_.text = var_71_4

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_5 = 33
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

				if manager.audio:GetVoiceLength("story_v_out_101081", "101081017", "story_v_out_101081.awb") ~= 0 then
					local var_71_8 = manager.audio:GetVoiceLength("story_v_out_101081", "101081017", "story_v_out_101081.awb") / 1000

					if var_71_8 + var_71_0 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_8 + var_71_0
					end

					if var_71_3.prefab_name ~= "" and arg_68_1.actors_[var_71_3.prefab_name] ~= nil then
						local var_71_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_3.prefab_name].transform, "story_v_out_101081", "101081017", "story_v_out_101081.awb")

						arg_68_1:RecordAudio("101081017", var_71_9)
						arg_68_1:RecordAudio("101081017", var_71_9)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_101081", "101081017", "story_v_out_101081.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_101081", "101081017", "story_v_out_101081.awb")
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
	Play101081018 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 101081018
		arg_72_1.duration_ = 5

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play101081019(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = arg_72_1.actors_["2030_tpose"]
			local var_75_1 = 0

			if var_75_1 < arg_72_1.time_ and arg_72_1.time_ <= var_75_1 + arg_75_0 and not isNil(var_75_0) and arg_72_1.var_.characterEffect2030_tpose == nil then
				arg_72_1.var_.characterEffect2030_tpose = var_75_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_2 = 0.1

			if var_75_1 <= arg_72_1.time_ and arg_72_1.time_ < var_75_1 + var_75_2 and not isNil(var_75_0) then
				local var_75_3 = (arg_72_1.time_ - var_75_1) / var_75_2

				if arg_72_1.var_.characterEffect2030_tpose and not isNil(var_75_0) then
					local var_75_4 = Mathf.Lerp(0, 0.5, var_75_3)

					arg_72_1.var_.characterEffect2030_tpose.fillFlat = true
					arg_72_1.var_.characterEffect2030_tpose.fillRatio = var_75_4
				end
			end

			if arg_72_1.time_ >= var_75_1 + var_75_2 and arg_72_1.time_ < var_75_1 + var_75_2 + arg_75_0 and not isNil(var_75_0) and arg_72_1.var_.characterEffect2030_tpose then
				local var_75_5 = 0.5

				arg_72_1.var_.characterEffect2030_tpose.fillFlat = true
				arg_72_1.var_.characterEffect2030_tpose.fillRatio = var_75_5
			end

			local var_75_6 = 0

			if var_75_6 < arg_72_1.time_ and arg_72_1.time_ <= var_75_6 + arg_75_0 then
				arg_72_1.mask_.enabled = true
				arg_72_1.mask_.raycastTarget = false

				arg_72_1:SetGaussion(false)
			end

			local var_75_7 = 0.5

			if var_75_6 <= arg_72_1.time_ and arg_72_1.time_ < var_75_6 + var_75_7 then
				local var_75_8 = (arg_72_1.time_ - var_75_6) / var_75_7
				local var_75_9 = Color.New(1, 1, 1)

				var_75_9.a = Mathf.Lerp(1, 0, var_75_8)
				arg_72_1.mask_.color = var_75_9
			end

			if arg_72_1.time_ >= var_75_6 + var_75_7 and arg_72_1.time_ < var_75_6 + var_75_7 + arg_75_0 then
				local var_75_10 = Color.New(1, 1, 1)
				local var_75_11 = 0

				arg_72_1.mask_.enabled = false
				var_75_10.a = var_75_11
				arg_72_1.mask_.color = var_75_10
			end

			local var_75_12 = arg_72_1.actors_["2030_tpose"].transform
			local var_75_13 = 0

			if var_75_13 < arg_72_1.time_ and arg_72_1.time_ <= var_75_13 + arg_75_0 then
				arg_72_1.var_.moveOldPos2030_tpose = var_75_12.localPosition

				local var_75_14 = GameObjectTools.GetOrAddComponent(var_75_12.gameObject, typeof(DynamicBoneHelper))

				if var_75_14 then
					var_75_14:EnableDynamicBone(false)
				end
			end

			local var_75_15 = 0.001

			if var_75_13 <= arg_72_1.time_ and arg_72_1.time_ < var_75_13 + var_75_15 then
				local var_75_16 = (arg_72_1.time_ - var_75_13) / var_75_15
				local var_75_17 = Vector3.New(0, 100, 0)

				var_75_12.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPos2030_tpose, var_75_17, var_75_16)

				local var_75_18 = manager.ui.mainCamera.transform.position - var_75_12.position

				var_75_12.forward = Vector3.New(var_75_18.x, var_75_18.y, var_75_18.z)

				local var_75_19 = var_75_12.localEulerAngles

				var_75_19.z = 0
				var_75_19.x = 0
				var_75_12.localEulerAngles = var_75_19
			end

			if arg_72_1.time_ >= var_75_13 + var_75_15 and arg_72_1.time_ < var_75_13 + var_75_15 + arg_75_0 then
				var_75_12.localPosition = Vector3.New(0, 100, 0)

				local var_75_20 = manager.ui.mainCamera.transform.position - var_75_12.position

				var_75_12.forward = Vector3.New(var_75_20.x, var_75_20.y, var_75_20.z)

				local var_75_21 = var_75_12.localEulerAngles

				var_75_21.z = 0
				var_75_21.x = 0
				var_75_12.localEulerAngles = var_75_21

				local var_75_22 = GameObjectTools.GetOrAddComponent(var_75_12.gameObject, typeof(DynamicBoneHelper))

				if var_75_22 then
					var_75_22:EnableDynamicBone(true)
				end
			end

			local var_75_23 = manager.ui.mainCamera.transform
			local var_75_24 = 0

			if var_75_24 < arg_72_1.time_ and arg_72_1.time_ <= var_75_24 + arg_75_0 then
				arg_72_1.var_.shakeOldPosMainCamera = var_75_23.localPosition
			end

			local var_75_25 = 0.600000023841858

			if var_75_24 <= arg_72_1.time_ and arg_72_1.time_ < var_75_24 + var_75_25 then
				local var_75_26 = (arg_72_1.time_ - var_75_24) / 0.066
				local var_75_27, var_75_28 = math.modf(var_75_26)

				var_75_23.localPosition = Vector3.New(var_75_28 * 0.13, var_75_28 * 0.13, var_75_28 * 0.13) + arg_72_1.var_.shakeOldPosMainCamera
			end

			if arg_72_1.time_ >= var_75_24 + var_75_25 and arg_72_1.time_ < var_75_24 + var_75_25 + arg_75_0 then
				var_75_23.localPosition = arg_72_1.var_.shakeOldPosMainCamera
			end

			local var_75_29 = arg_72_1.actors_["2020_tpose"].transform
			local var_75_30 = 0

			if var_75_30 < arg_72_1.time_ and arg_72_1.time_ <= var_75_30 + arg_75_0 then
				arg_72_1.var_.moveOldPos2020_tpose = var_75_29.localPosition

				local var_75_31 = GameObjectTools.GetOrAddComponent(var_75_29.gameObject, typeof(DynamicBoneHelper))

				if var_75_31 then
					var_75_31:EnableDynamicBone(false)
				end
			end

			local var_75_32 = 0.001

			if var_75_30 <= arg_72_1.time_ and arg_72_1.time_ < var_75_30 + var_75_32 then
				local var_75_33 = (arg_72_1.time_ - var_75_30) / var_75_32
				local var_75_34 = Vector3.New(0, 100, 0)

				var_75_29.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPos2020_tpose, var_75_34, var_75_33)

				local var_75_35 = manager.ui.mainCamera.transform.position - var_75_29.position

				var_75_29.forward = Vector3.New(var_75_35.x, var_75_35.y, var_75_35.z)

				local var_75_36 = var_75_29.localEulerAngles

				var_75_36.z = 0
				var_75_36.x = 0
				var_75_29.localEulerAngles = var_75_36
			end

			if arg_72_1.time_ >= var_75_30 + var_75_32 and arg_72_1.time_ < var_75_30 + var_75_32 + arg_75_0 then
				var_75_29.localPosition = Vector3.New(0, 100, 0)

				local var_75_37 = manager.ui.mainCamera.transform.position - var_75_29.position

				var_75_29.forward = Vector3.New(var_75_37.x, var_75_37.y, var_75_37.z)

				local var_75_38 = var_75_29.localEulerAngles

				var_75_38.z = 0
				var_75_38.x = 0
				var_75_29.localEulerAngles = var_75_38

				local var_75_39 = GameObjectTools.GetOrAddComponent(var_75_29.gameObject, typeof(DynamicBoneHelper))

				if var_75_39 then
					var_75_39:EnableDynamicBone(true)
				end
			end

			local var_75_40 = 0
			local var_75_41 = 1.05

			if var_75_40 < arg_72_1.time_ and arg_72_1.time_ <= var_75_40 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, false)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_42 = arg_72_1:GetWordFromCfg(101081018)
				local var_75_43 = arg_72_1:FormatText(var_75_42.content)

				arg_72_1.text_.text = var_75_43

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_44 = 42
				local var_75_45 = utf8.len(var_75_43)
				local var_75_46 = var_75_44 <= 0 and var_75_41 or var_75_41 * (var_75_45 / var_75_44)

				if var_75_46 > 0 and var_75_41 < var_75_46 then
					arg_72_1.talkMaxDuration = var_75_46

					if var_75_46 + var_75_40 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_46 + var_75_40
					end
				end

				arg_72_1.text_.text = var_75_43
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)
				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_47 = math.max(var_75_41, arg_72_1.talkMaxDuration)

			if var_75_40 <= arg_72_1.time_ and arg_72_1.time_ < var_75_40 + var_75_47 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_40) / var_75_47

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_40 + var_75_47 and arg_72_1.time_ < var_75_40 + var_75_47 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {
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
				actorName = "2020_tpose",
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
	Play101081019 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 101081019
		arg_76_1.duration_ = 5

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play101081020(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = 0
			local var_79_1 = 0.775

			if var_79_0 < arg_76_1.time_ and arg_76_1.time_ <= var_79_0 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, false)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_2 = arg_76_1:GetWordFromCfg(101081019)
				local var_79_3 = arg_76_1:FormatText(var_79_2.content)

				arg_76_1.text_.text = var_79_3

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_4 = 31
				local var_79_5 = utf8.len(var_79_3)
				local var_79_6 = var_79_4 <= 0 and var_79_1 or var_79_1 * (var_79_5 / var_79_4)

				if var_79_6 > 0 and var_79_1 < var_79_6 then
					arg_76_1.talkMaxDuration = var_79_6

					if var_79_6 + var_79_0 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_6 + var_79_0
					end
				end

				arg_76_1.text_.text = var_79_3
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)
				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_7 = math.max(var_79_1, arg_76_1.talkMaxDuration)

			if var_79_0 <= arg_76_1.time_ and arg_76_1.time_ < var_79_0 + var_79_7 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_0) / var_79_7

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_0 + var_79_7 and arg_76_1.time_ < var_79_0 + var_79_7 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {}

		arg_76_1:InitPlayNodeList()
	end,
	Play101081020 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 101081020
		arg_80_1.duration_ = 3.13

		local var_80_0 = {
			ja = 2.366,
			ko = 1.2,
			zh = 3.133,
			en = 0.933
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
				arg_80_0:Play101081021(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = 0
			local var_83_1 = 0.075

			if var_83_0 < arg_80_1.time_ and arg_80_1.time_ <= var_83_0 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				local var_83_2 = arg_80_1:FormatText(StoryNameCfg[19].name)

				arg_80_1.leftNameTxt_.text = var_83_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, true)
				arg_80_1.iconController_:SetSelectedState("hero")

				arg_80_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_20302")

				arg_80_1.callingController_:SetSelectedState("normal")

				arg_80_1.keyicon_.color = Color.New(1, 1, 1)
				arg_80_1.icon_.color = Color.New(1, 1, 1)

				local var_83_3 = arg_80_1:GetWordFromCfg(101081020)
				local var_83_4 = arg_80_1:FormatText(var_83_3.content)

				arg_80_1.text_.text = var_83_4

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_5 = 3
				local var_83_6 = utf8.len(var_83_4)
				local var_83_7 = var_83_5 <= 0 and var_83_1 or var_83_1 * (var_83_6 / var_83_5)

				if var_83_7 > 0 and var_83_1 < var_83_7 then
					arg_80_1.talkMaxDuration = var_83_7

					if var_83_7 + var_83_0 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_7 + var_83_0
					end
				end

				arg_80_1.text_.text = var_83_4
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101081", "101081020", "story_v_out_101081.awb") ~= 0 then
					local var_83_8 = manager.audio:GetVoiceLength("story_v_out_101081", "101081020", "story_v_out_101081.awb") / 1000

					if var_83_8 + var_83_0 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_8 + var_83_0
					end

					if var_83_3.prefab_name ~= "" and arg_80_1.actors_[var_83_3.prefab_name] ~= nil then
						local var_83_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_3.prefab_name].transform, "story_v_out_101081", "101081020", "story_v_out_101081.awb")

						arg_80_1:RecordAudio("101081020", var_83_9)
						arg_80_1:RecordAudio("101081020", var_83_9)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_out_101081", "101081020", "story_v_out_101081.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_out_101081", "101081020", "story_v_out_101081.awb")
				end

				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_10 = math.max(var_83_1, arg_80_1.talkMaxDuration)

			if var_83_0 <= arg_80_1.time_ and arg_80_1.time_ < var_83_0 + var_83_10 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_0) / var_83_10

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_0 + var_83_10 and arg_80_1.time_ < var_83_0 + var_83_10 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {}

		arg_80_1:InitPlayNodeList()
	end,
	Play101081021 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 101081021
		arg_84_1.duration_ = 4.33

		local var_84_0 = {
			ja = 4.333,
			ko = 2.733,
			zh = 2.633,
			en = 3.3
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
			arg_84_1.auto_ = false
		end

		function arg_84_1.playNext_(arg_86_0)
			arg_84_1.onStoryFinished_()
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = "1036ui_story"

			if arg_84_1.actors_[var_87_0] == nil then
				local var_87_1 = Asset.Load("Char/" .. "1036ui_story")

				if not isNil(var_87_1) then
					local var_87_2 = Object.Instantiate(Asset.Load("Char/" .. "1036ui_story"), arg_84_1.stage_.transform)

					var_87_2.name = var_87_0
					var_87_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_84_1.actors_[var_87_0] = var_87_2

					local var_87_3 = var_87_2:GetComponentInChildren(typeof(CharacterEffect))

					var_87_3.enabled = true

					local var_87_4 = GameObjectTools.GetOrAddComponent(var_87_2, typeof(DynamicBoneHelper))

					if var_87_4 then
						var_87_4:EnableDynamicBone(false)
					end

					arg_84_1:ShowWeapon(var_87_3.transform, false)

					arg_84_1.var_[var_87_0 .. "Animator"] = var_87_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_84_1.var_[var_87_0 .. "Animator"].applyRootMotion = true
					arg_84_1.var_[var_87_0 .. "LipSync"] = var_87_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_87_5 = arg_84_1.actors_["1036ui_story"]
			local var_87_6 = 0

			if var_87_6 < arg_84_1.time_ and arg_84_1.time_ <= var_87_6 + arg_87_0 and not isNil(var_87_5) and arg_84_1.var_.characterEffect1036ui_story == nil then
				arg_84_1.var_.characterEffect1036ui_story = var_87_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_7 = 0.1

			if var_87_6 <= arg_84_1.time_ and arg_84_1.time_ < var_87_6 + var_87_7 and not isNil(var_87_5) then
				local var_87_8 = (arg_84_1.time_ - var_87_6) / var_87_7

				if arg_84_1.var_.characterEffect1036ui_story and not isNil(var_87_5) then
					arg_84_1.var_.characterEffect1036ui_story.fillFlat = false
				end
			end

			if arg_84_1.time_ >= var_87_6 + var_87_7 and arg_84_1.time_ < var_87_6 + var_87_7 + arg_87_0 and not isNil(var_87_5) and arg_84_1.var_.characterEffect1036ui_story then
				arg_84_1.var_.characterEffect1036ui_story.fillFlat = false
			end

			local var_87_9 = arg_84_1.actors_["1036ui_story"].transform
			local var_87_10 = 0

			if var_87_10 < arg_84_1.time_ and arg_84_1.time_ <= var_87_10 + arg_87_0 then
				arg_84_1.var_.moveOldPos1036ui_story = var_87_9.localPosition
			end

			local var_87_11 = 0.001

			if var_87_10 <= arg_84_1.time_ and arg_84_1.time_ < var_87_10 + var_87_11 then
				local var_87_12 = (arg_84_1.time_ - var_87_10) / var_87_11
				local var_87_13 = Vector3.New(0, -1.09, -5.78)

				var_87_9.localPosition = Vector3.Lerp(arg_84_1.var_.moveOldPos1036ui_story, var_87_13, var_87_12)

				local var_87_14 = manager.ui.mainCamera.transform.position - var_87_9.position

				var_87_9.forward = Vector3.New(var_87_14.x, var_87_14.y, var_87_14.z)

				local var_87_15 = var_87_9.localEulerAngles

				var_87_15.z = 0
				var_87_15.x = 0
				var_87_9.localEulerAngles = var_87_15
			end

			if arg_84_1.time_ >= var_87_10 + var_87_11 and arg_84_1.time_ < var_87_10 + var_87_11 + arg_87_0 then
				var_87_9.localPosition = Vector3.New(0, -1.09, -5.78)

				local var_87_16 = manager.ui.mainCamera.transform.position - var_87_9.position

				var_87_9.forward = Vector3.New(var_87_16.x, var_87_16.y, var_87_16.z)

				local var_87_17 = var_87_9.localEulerAngles

				var_87_17.z = 0
				var_87_17.x = 0
				var_87_9.localEulerAngles = var_87_17
			end

			local var_87_18 = 0

			if var_87_18 < arg_84_1.time_ and arg_84_1.time_ <= var_87_18 + arg_87_0 then
				arg_84_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/story1036/story1036action/1036action3_1")
			end

			local var_87_19 = 0

			if var_87_19 < arg_84_1.time_ and arg_84_1.time_ <= var_87_19 + arg_87_0 then
				arg_84_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_87_20 = 0
			local var_87_21 = 0.275

			if var_87_20 < arg_84_1.time_ and arg_84_1.time_ <= var_87_20 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				local var_87_22 = arg_84_1:FormatText(StoryNameCfg[5].name)

				arg_84_1.leftNameTxt_.text = var_87_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_23 = arg_84_1:GetWordFromCfg(101081021)
				local var_87_24 = arg_84_1:FormatText(var_87_23.content)

				arg_84_1.text_.text = var_87_24

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_25 = 11
				local var_87_26 = utf8.len(var_87_24)
				local var_87_27 = var_87_25 <= 0 and var_87_21 or var_87_21 * (var_87_26 / var_87_25)

				if var_87_27 > 0 and var_87_21 < var_87_27 then
					arg_84_1.talkMaxDuration = var_87_27

					if var_87_27 + var_87_20 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_27 + var_87_20
					end
				end

				arg_84_1.text_.text = var_87_24
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101081", "101081021", "story_v_out_101081.awb") ~= 0 then
					local var_87_28 = manager.audio:GetVoiceLength("story_v_out_101081", "101081021", "story_v_out_101081.awb") / 1000

					if var_87_28 + var_87_20 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_28 + var_87_20
					end

					if var_87_23.prefab_name ~= "" and arg_84_1.actors_[var_87_23.prefab_name] ~= nil then
						local var_87_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_23.prefab_name].transform, "story_v_out_101081", "101081021", "story_v_out_101081.awb")

						arg_84_1:RecordAudio("101081021", var_87_29)
						arg_84_1:RecordAudio("101081021", var_87_29)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_out_101081", "101081021", "story_v_out_101081.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_out_101081", "101081021", "story_v_out_101081.awb")
				end

				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_30 = math.max(var_87_21, arg_84_1.talkMaxDuration)

			if var_87_20 <= arg_84_1.time_ and arg_84_1.time_ < var_87_20 + var_87_30 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_20) / var_87_30

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_20 + var_87_30 and arg_84_1.time_ < var_87_20 + var_87_30 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {
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

		arg_84_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/B02b"
	},
	voices = {
		"story_v_out_101081.awb"
	}
}
