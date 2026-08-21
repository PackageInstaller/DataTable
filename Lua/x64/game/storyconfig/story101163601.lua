return {
	Play116361001 = function(arg_1_0, arg_1_1)
		arg_1_1.marker = "Mark1"
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 116361001
		arg_1_1.duration_ = 22.5

		local var_1_0 = {
			zh = 18.336,
			ja = 22.503
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
			arg_1_1.marker = ""

			if arg_3_0 == 1 then
				arg_1_0:Play116361002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "I07a"

			if arg_1_1.bgs_[var_4_0] == nil then
				local var_4_1 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_0)
				var_4_1.name = var_4_0
				var_4_1.transform.parent = arg_1_1.stage_.transform
				var_4_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_0] = var_4_1
			end

			local var_4_2 = 3.67

			if var_4_2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_2 + arg_4_0 then
				local var_4_3 = manager.ui.mainCamera.transform.localPosition
				local var_4_4 = Vector3.New(0, 0, 10) + Vector3.New(var_4_3.x, var_4_3.y, 0)
				local var_4_5 = arg_1_1.bgs_.I07a

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
					if iter_4_0 ~= "I07a" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = 0

			if var_4_16 < arg_1_1.time_ and arg_1_1.time_ <= var_4_16 + arg_4_0 then
				SetActive(arg_1_1.dialog_, false)
				SetActive(arg_1_1.allBtn_.gameObject, false)
				arg_1_1.hideBtnsController_:SetSelectedIndex(1)

				arg_1_1.marker = "PlayCantSkipVideo"

				manager.video:Play("SofdecAsset/story/story_101161201.usm", function(arg_5_0)
					arg_1_1.time_ = var_4_16 + 3.66000000022352

					if arg_1_1.state_ == "pause" then
						arg_1_1.state_ = "playing"
					end

					manager.video:Dispose()
				end, nil, nil, function(arg_6_0)
					if arg_6_0 then
						arg_1_1.state_ = "pause"
					else
						arg_1_1.state_ = "playing"
					end
				end)
				manager.video.transform_:SetSiblingIndex(1)
			end

			local var_4_17 = 3.67

			if var_4_16 <= arg_1_1.time_ and arg_1_1.time_ < var_4_16 + var_4_17 then
				-- block empty
			end

			if arg_1_1.time_ >= var_4_16 + var_4_17 and arg_1_1.time_ < var_4_16 + var_4_17 + arg_4_0 then
				arg_1_1.marker = ""
			end

			local var_4_18 = 3.67

			if var_4_18 < arg_1_1.time_ and arg_1_1.time_ <= var_4_18 + arg_4_0 then
				SetActive(arg_1_1.dialog_, true)
				SetActive(arg_1_1.allBtn_.gameObject, true)
				arg_1_1.hideBtnsController_:SetSelectedIndex(0)
				manager.video:Dispose()

				arg_1_1.isInLoopVideo = false
			end

			local var_4_19 = 0.0166666666666667

			if var_4_18 <= arg_1_1.time_ and arg_1_1.time_ < var_4_18 + var_4_19 then
				-- block empty
			end

			if arg_1_1.time_ >= var_4_18 + var_4_19 and arg_1_1.time_ < var_4_18 + var_4_19 + arg_4_0 then
				-- block empty
			end

			local var_4_20 = 3.68666666666667

			if var_4_20 < arg_1_1.time_ and arg_1_1.time_ <= var_4_20 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_21 = 2

			if var_4_20 <= arg_1_1.time_ and arg_1_1.time_ < var_4_20 + var_4_21 then
				local var_4_22 = (arg_1_1.time_ - var_4_20) / var_4_21
				local var_4_23 = Color.New(0, 0, 0)

				var_4_23.a = Mathf.Lerp(1, 0, var_4_22)
				arg_1_1.mask_.color = var_4_23
			end

			if arg_1_1.time_ >= var_4_20 + var_4_21 and arg_1_1.time_ < var_4_20 + var_4_21 + arg_4_0 then
				local var_4_24 = Color.New(0, 0, 0)
				local var_4_25 = 0

				arg_1_1.mask_.enabled = false
				var_4_24.a = var_4_25
				arg_1_1.mask_.color = var_4_24
			end

			local var_4_26 = "10032ui_story"

			if arg_1_1.actors_[var_4_26] == nil then
				local var_4_27 = Asset.Load("Char/" .. "10032ui_story")

				if not isNil(var_4_27) then
					local var_4_28 = Object.Instantiate(Asset.Load("Char/" .. "10032ui_story"), arg_1_1.stage_.transform)

					var_4_28.name = var_4_26
					var_4_28.transform.localPosition = Vector3.New(0, 100, 0)
					arg_1_1.actors_[var_4_26] = var_4_28

					local var_4_29 = var_4_28:GetComponentInChildren(typeof(CharacterEffect))

					var_4_29.enabled = true

					local var_4_30 = GameObjectTools.GetOrAddComponent(var_4_28, typeof(DynamicBoneHelper))

					if var_4_30 then
						var_4_30:EnableDynamicBone(false)
					end

					arg_1_1:ShowWeapon(var_4_29.transform, false)

					arg_1_1.var_[var_4_26 .. "Animator"] = var_4_29.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_1_1.var_[var_4_26 .. "Animator"].applyRootMotion = true
					arg_1_1.var_[var_4_26 .. "LipSync"] = var_4_29.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_4_31 = arg_1_1.actors_["10032ui_story"].transform
			local var_4_32 = 5.68666666666667

			if var_4_32 < arg_1_1.time_ and arg_1_1.time_ <= var_4_32 + arg_4_0 then
				arg_1_1.var_.moveOldPos10032ui_story = var_4_31.localPosition
			end

			local var_4_33 = 0.001

			if var_4_32 <= arg_1_1.time_ and arg_1_1.time_ < var_4_32 + var_4_33 then
				local var_4_34 = (arg_1_1.time_ - var_4_32) / var_4_33
				local var_4_35 = Vector3.New(0, -1.1, -5.9)

				var_4_31.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos10032ui_story, var_4_35, var_4_34)

				local var_4_36 = manager.ui.mainCamera.transform.position - var_4_31.position

				var_4_31.forward = Vector3.New(var_4_36.x, var_4_36.y, var_4_36.z)

				local var_4_37 = var_4_31.localEulerAngles

				var_4_37.z = 0
				var_4_37.x = 0
				var_4_31.localEulerAngles = var_4_37
			end

			if arg_1_1.time_ >= var_4_32 + var_4_33 and arg_1_1.time_ < var_4_32 + var_4_33 + arg_4_0 then
				var_4_31.localPosition = Vector3.New(0, -1.1, -5.9)

				local var_4_38 = manager.ui.mainCamera.transform.position - var_4_31.position

				var_4_31.forward = Vector3.New(var_4_38.x, var_4_38.y, var_4_38.z)

				local var_4_39 = var_4_31.localEulerAngles

				var_4_39.z = 0
				var_4_39.x = 0
				var_4_31.localEulerAngles = var_4_39
			end

			local var_4_40 = 5.68666666666667

			if var_4_40 < arg_1_1.time_ and arg_1_1.time_ <= var_4_40 + arg_4_0 then
				arg_1_1:PlayTimeline("10032ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action1_1")
			end

			local var_4_41 = 5.68666666666667

			if var_4_41 < arg_1_1.time_ and arg_1_1.time_ <= var_4_41 + arg_4_0 then
				arg_1_1:PlayTimeline("10032ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_4_42 = arg_1_1.actors_["10032ui_story"]
			local var_4_43 = 5.68666666666667

			if var_4_43 < arg_1_1.time_ and arg_1_1.time_ <= var_4_43 + arg_4_0 and not isNil(var_4_42) and arg_1_1.var_.characterEffect10032ui_story == nil then
				arg_1_1.var_.characterEffect10032ui_story = var_4_42:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_44 = 0.2

			if var_4_43 <= arg_1_1.time_ and arg_1_1.time_ < var_4_43 + var_4_44 and not isNil(var_4_42) then
				local var_4_45 = (arg_1_1.time_ - var_4_43) / var_4_44

				if arg_1_1.var_.characterEffect10032ui_story and not isNil(var_4_42) then
					arg_1_1.var_.characterEffect10032ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= var_4_43 + var_4_44 and arg_1_1.time_ < var_4_43 + var_4_44 + arg_4_0 and not isNil(var_4_42) and arg_1_1.var_.characterEffect10032ui_story then
				arg_1_1.var_.characterEffect10032ui_story.fillFlat = false
			end

			local var_4_46 = 0
			local var_4_47 = 0.266666666666667

			if var_4_46 < arg_1_1.time_ and arg_1_1.time_ <= var_4_46 + arg_4_0 then
				local var_4_48 = "play"
				local var_4_49 = "music"

				arg_1_1:AudioAction(var_4_48, var_4_49, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_50 = ""
				local var_4_51 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_52 = 5.67
			local var_4_53 = 1.075

			if var_4_52 < arg_1_1.time_ and arg_1_1.time_ <= var_4_52 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_54 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_54:setOnUpdate(LuaHelper.FloatAction(function(arg_8_0)
					arg_1_1.dialogCg_.alpha = arg_8_0
				end))
				var_4_54:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_54:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_55 = arg_1_1:FormatText(StoryNameCfg[328].name)

				arg_1_1.leftNameTxt_.text = var_4_55

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_56 = arg_1_1:GetWordFromCfg(116361001)
				local var_4_57 = arg_1_1:FormatText(var_4_56.content)

				arg_1_1.text_.text = var_4_57

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_58 = 43
				local var_4_59 = utf8.len(var_4_57)
				local var_4_60 = var_4_58 <= 0 and var_4_53 or var_4_53 * (var_4_59 / var_4_58)

				if var_4_60 > 0 and var_4_53 < var_4_60 then
					arg_1_1.talkMaxDuration = var_4_60
					var_4_52 = var_4_52 + 0.3

					if var_4_60 + var_4_52 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_60 + var_4_52
					end
				end

				arg_1_1.text_.text = var_4_57
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116361", "116361001", "story_v_out_116361.awb") ~= 0 then
					local var_4_61 = manager.audio:GetVoiceLength("story_v_out_116361", "116361001", "story_v_out_116361.awb") / 1000

					if var_4_61 + var_4_52 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_61 + var_4_52
					end

					if var_4_56.prefab_name ~= "" and arg_1_1.actors_[var_4_56.prefab_name] ~= nil then
						local var_4_62 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_56.prefab_name].transform, "story_v_out_116361", "116361001", "story_v_out_116361.awb")

						arg_1_1:RecordAudio("116361001", var_4_62)
						arg_1_1:RecordAudio("116361001", var_4_62)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_116361", "116361001", "story_v_out_116361.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_116361", "116361001", "story_v_out_116361.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_63 = var_4_52 + 0.3
			local var_4_64 = math.max(var_4_53, arg_1_1.talkMaxDuration)

			if var_4_63 <= arg_1_1.time_ and arg_1_1.time_ < var_4_63 + var_4_64 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_63) / var_4_64

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_63 + var_4_64 and arg_1_1.time_ < var_4_63 + var_4_64 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10032ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 5.68666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play116361002 = function(arg_10_0, arg_10_1)
		arg_10_1.time_ = 0
		arg_10_1.frameCnt_ = 0
		arg_10_1.state_ = "playing"
		arg_10_1.curTalkId_ = 116361002
		arg_10_1.duration_ = 12.53

		local var_10_0 = {
			zh = 11.966,
			ja = 12.533
		}
		local var_10_1 = manager.audio:GetLocalizationFlag()

		if var_10_0[var_10_1] ~= nil then
			arg_10_1.duration_ = var_10_0[var_10_1]
		end

		SetActive(arg_10_1.tipsGo_, false)

		function arg_10_1.onSingleLineFinish_()
			arg_10_1.onSingleLineUpdate_ = nil
			arg_10_1.onSingleLineFinish_ = nil
			arg_10_1.state_ = "waiting"
		end

		function arg_10_1.playNext_(arg_12_0)
			if arg_12_0 == 1 then
				arg_10_0:Play116361003(arg_10_1)
			end
		end

		function arg_10_1.onSingleLineUpdate_(arg_13_0)
			local var_13_0 = arg_10_1.actors_["10032ui_story"].transform
			local var_13_1 = 0

			if var_13_1 < arg_10_1.time_ and arg_10_1.time_ <= var_13_1 + arg_13_0 then
				arg_10_1.var_.moveOldPos10032ui_story = var_13_0.localPosition
			end

			local var_13_2 = 0.001

			if var_13_1 <= arg_10_1.time_ and arg_10_1.time_ < var_13_1 + var_13_2 then
				local var_13_3 = (arg_10_1.time_ - var_13_1) / var_13_2
				local var_13_4 = Vector3.New(0, -1.1, -5.9)

				var_13_0.localPosition = Vector3.Lerp(arg_10_1.var_.moveOldPos10032ui_story, var_13_4, var_13_3)

				local var_13_5 = manager.ui.mainCamera.transform.position - var_13_0.position

				var_13_0.forward = Vector3.New(var_13_5.x, var_13_5.y, var_13_5.z)

				local var_13_6 = var_13_0.localEulerAngles

				var_13_6.z = 0
				var_13_6.x = 0
				var_13_0.localEulerAngles = var_13_6
			end

			if arg_10_1.time_ >= var_13_1 + var_13_2 and arg_10_1.time_ < var_13_1 + var_13_2 + arg_13_0 then
				var_13_0.localPosition = Vector3.New(0, -1.1, -5.9)

				local var_13_7 = manager.ui.mainCamera.transform.position - var_13_0.position

				var_13_0.forward = Vector3.New(var_13_7.x, var_13_7.y, var_13_7.z)

				local var_13_8 = var_13_0.localEulerAngles

				var_13_8.z = 0
				var_13_8.x = 0
				var_13_0.localEulerAngles = var_13_8
			end

			local var_13_9 = 0

			if var_13_9 < arg_10_1.time_ and arg_10_1.time_ <= var_13_9 + arg_13_0 then
				arg_10_1:PlayTimeline("10032ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0204cva")
			end

			local var_13_10 = arg_10_1.actors_["10032ui_story"]
			local var_13_11 = 0

			if var_13_11 < arg_10_1.time_ and arg_10_1.time_ <= var_13_11 + arg_13_0 and not isNil(var_13_10) and arg_10_1.var_.characterEffect10032ui_story == nil then
				arg_10_1.var_.characterEffect10032ui_story = var_13_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_13_12 = 0.2

			if var_13_11 <= arg_10_1.time_ and arg_10_1.time_ < var_13_11 + var_13_12 and not isNil(var_13_10) then
				local var_13_13 = (arg_10_1.time_ - var_13_11) / var_13_12

				if arg_10_1.var_.characterEffect10032ui_story and not isNil(var_13_10) then
					arg_10_1.var_.characterEffect10032ui_story.fillFlat = false
				end
			end

			if arg_10_1.time_ >= var_13_11 + var_13_12 and arg_10_1.time_ < var_13_11 + var_13_12 + arg_13_0 and not isNil(var_13_10) and arg_10_1.var_.characterEffect10032ui_story then
				arg_10_1.var_.characterEffect10032ui_story.fillFlat = false
			end

			local var_13_14 = 0

			if var_13_14 < arg_10_1.time_ and arg_10_1.time_ <= var_13_14 + arg_13_0 then
				arg_10_1:PlayTimeline("10032ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action4_1")
			end

			local var_13_15 = 0
			local var_13_16 = 1.2

			if var_13_15 < arg_10_1.time_ and arg_10_1.time_ <= var_13_15 + arg_13_0 then
				arg_10_1.talkMaxDuration = 0
				arg_10_1.dialogCg_.alpha = 1

				arg_10_1.dialog_:SetActive(true)
				SetActive(arg_10_1.leftNameGo_, true)

				local var_13_17 = arg_10_1:FormatText(StoryNameCfg[328].name)

				arg_10_1.leftNameTxt_.text = var_13_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_10_1.leftNameTxt_.transform)

				arg_10_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_10_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_10_1:RecordName(arg_10_1.leftNameTxt_.text)
				SetActive(arg_10_1.iconTrs_.gameObject, false)
				arg_10_1.callingController_:SetSelectedState("normal")

				local var_13_18 = arg_10_1:GetWordFromCfg(116361002)
				local var_13_19 = arg_10_1:FormatText(var_13_18.content)

				arg_10_1.text_.text = var_13_19

				LuaForUtil.ClearLinePrefixSymbol(arg_10_1.text_)

				local var_13_20 = 48
				local var_13_21 = utf8.len(var_13_19)
				local var_13_22 = var_13_20 <= 0 and var_13_16 or var_13_16 * (var_13_21 / var_13_20)

				if var_13_22 > 0 and var_13_16 < var_13_22 then
					arg_10_1.talkMaxDuration = var_13_22

					if var_13_22 + var_13_15 > arg_10_1.duration_ then
						arg_10_1.duration_ = var_13_22 + var_13_15
					end
				end

				arg_10_1.text_.text = var_13_19
				arg_10_1.typewritter.percent = 0

				arg_10_1.typewritter:SetDirty()
				arg_10_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116361", "116361002", "story_v_out_116361.awb") ~= 0 then
					local var_13_23 = manager.audio:GetVoiceLength("story_v_out_116361", "116361002", "story_v_out_116361.awb") / 1000

					if var_13_23 + var_13_15 > arg_10_1.duration_ then
						arg_10_1.duration_ = var_13_23 + var_13_15
					end

					if var_13_18.prefab_name ~= "" and arg_10_1.actors_[var_13_18.prefab_name] ~= nil then
						local var_13_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_10_1.actors_[var_13_18.prefab_name].transform, "story_v_out_116361", "116361002", "story_v_out_116361.awb")

						arg_10_1:RecordAudio("116361002", var_13_24)
						arg_10_1:RecordAudio("116361002", var_13_24)
					else
						arg_10_1:AudioAction("play", "voice", "story_v_out_116361", "116361002", "story_v_out_116361.awb")
					end

					arg_10_1:RecordHistoryTalkVoice("story_v_out_116361", "116361002", "story_v_out_116361.awb")
				end

				arg_10_1:RecordContent(arg_10_1.text_.text)
			end

			local var_13_25 = math.max(var_13_16, arg_10_1.talkMaxDuration)

			if var_13_15 <= arg_10_1.time_ and arg_10_1.time_ < var_13_15 + var_13_25 then
				arg_10_1.typewritter.percent = (arg_10_1.time_ - var_13_15) / var_13_25

				arg_10_1.typewritter:SetDirty()
			end

			if arg_10_1.time_ >= var_13_15 + var_13_25 and arg_10_1.time_ < var_13_15 + var_13_25 + arg_13_0 then
				arg_10_1.typewritter.percent = 1

				arg_10_1.typewritter:SetDirty()
				arg_10_1:ShowNextGo(true)
			end
		end

		arg_10_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10032ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_10_1:InitPlayNodeList()
	end,
	Play116361003 = function(arg_14_0, arg_14_1)
		arg_14_1.time_ = 0
		arg_14_1.frameCnt_ = 0
		arg_14_1.state_ = "playing"
		arg_14_1.curTalkId_ = 116361003
		arg_14_1.duration_ = 10.7

		local var_14_0 = {
			zh = 7.1,
			ja = 10.7
		}
		local var_14_1 = manager.audio:GetLocalizationFlag()

		if var_14_0[var_14_1] ~= nil then
			arg_14_1.duration_ = var_14_0[var_14_1]
		end

		SetActive(arg_14_1.tipsGo_, false)

		function arg_14_1.onSingleLineFinish_()
			arg_14_1.onSingleLineUpdate_ = nil
			arg_14_1.onSingleLineFinish_ = nil
			arg_14_1.state_ = "waiting"
		end

		function arg_14_1.playNext_(arg_16_0)
			if arg_16_0 == 1 then
				arg_14_0:Play116361004(arg_14_1)
			end
		end

		function arg_14_1.onSingleLineUpdate_(arg_17_0)
			local var_17_0 = arg_14_1.actors_["10032ui_story"].transform
			local var_17_1 = 0

			if var_17_1 < arg_14_1.time_ and arg_14_1.time_ <= var_17_1 + arg_17_0 then
				arg_14_1.var_.moveOldPos10032ui_story = var_17_0.localPosition
			end

			local var_17_2 = 0.001

			if var_17_1 <= arg_14_1.time_ and arg_14_1.time_ < var_17_1 + var_17_2 then
				local var_17_3 = (arg_14_1.time_ - var_17_1) / var_17_2
				local var_17_4 = Vector3.New(0, -1.1, -5.9)

				var_17_0.localPosition = Vector3.Lerp(arg_14_1.var_.moveOldPos10032ui_story, var_17_4, var_17_3)

				local var_17_5 = manager.ui.mainCamera.transform.position - var_17_0.position

				var_17_0.forward = Vector3.New(var_17_5.x, var_17_5.y, var_17_5.z)

				local var_17_6 = var_17_0.localEulerAngles

				var_17_6.z = 0
				var_17_6.x = 0
				var_17_0.localEulerAngles = var_17_6
			end

			if arg_14_1.time_ >= var_17_1 + var_17_2 and arg_14_1.time_ < var_17_1 + var_17_2 + arg_17_0 then
				var_17_0.localPosition = Vector3.New(0, -1.1, -5.9)

				local var_17_7 = manager.ui.mainCamera.transform.position - var_17_0.position

				var_17_0.forward = Vector3.New(var_17_7.x, var_17_7.y, var_17_7.z)

				local var_17_8 = var_17_0.localEulerAngles

				var_17_8.z = 0
				var_17_8.x = 0
				var_17_0.localEulerAngles = var_17_8
			end

			local var_17_9 = 0

			if var_17_9 < arg_14_1.time_ and arg_14_1.time_ <= var_17_9 + arg_17_0 then
				arg_14_1:PlayTimeline("10032ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_17_10 = 0
			local var_17_11 = 0.7

			if var_17_10 < arg_14_1.time_ and arg_14_1.time_ <= var_17_10 + arg_17_0 then
				arg_14_1.talkMaxDuration = 0
				arg_14_1.dialogCg_.alpha = 1

				arg_14_1.dialog_:SetActive(true)
				SetActive(arg_14_1.leftNameGo_, true)

				local var_17_12 = arg_14_1:FormatText(StoryNameCfg[328].name)

				arg_14_1.leftNameTxt_.text = var_17_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_14_1.leftNameTxt_.transform)

				arg_14_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_14_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_14_1:RecordName(arg_14_1.leftNameTxt_.text)
				SetActive(arg_14_1.iconTrs_.gameObject, false)
				arg_14_1.callingController_:SetSelectedState("normal")

				local var_17_13 = arg_14_1:GetWordFromCfg(116361003)
				local var_17_14 = arg_14_1:FormatText(var_17_13.content)

				arg_14_1.text_.text = var_17_14

				LuaForUtil.ClearLinePrefixSymbol(arg_14_1.text_)

				local var_17_15 = 28
				local var_17_16 = utf8.len(var_17_14)
				local var_17_17 = var_17_15 <= 0 and var_17_11 or var_17_11 * (var_17_16 / var_17_15)

				if var_17_17 > 0 and var_17_11 < var_17_17 then
					arg_14_1.talkMaxDuration = var_17_17

					if var_17_17 + var_17_10 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_17 + var_17_10
					end
				end

				arg_14_1.text_.text = var_17_14
				arg_14_1.typewritter.percent = 0

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116361", "116361003", "story_v_out_116361.awb") ~= 0 then
					local var_17_18 = manager.audio:GetVoiceLength("story_v_out_116361", "116361003", "story_v_out_116361.awb") / 1000

					if var_17_18 + var_17_10 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_18 + var_17_10
					end

					if var_17_13.prefab_name ~= "" and arg_14_1.actors_[var_17_13.prefab_name] ~= nil then
						local var_17_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_14_1.actors_[var_17_13.prefab_name].transform, "story_v_out_116361", "116361003", "story_v_out_116361.awb")

						arg_14_1:RecordAudio("116361003", var_17_19)
						arg_14_1:RecordAudio("116361003", var_17_19)
					else
						arg_14_1:AudioAction("play", "voice", "story_v_out_116361", "116361003", "story_v_out_116361.awb")
					end

					arg_14_1:RecordHistoryTalkVoice("story_v_out_116361", "116361003", "story_v_out_116361.awb")
				end

				arg_14_1:RecordContent(arg_14_1.text_.text)
			end

			local var_17_20 = math.max(var_17_11, arg_14_1.talkMaxDuration)

			if var_17_10 <= arg_14_1.time_ and arg_14_1.time_ < var_17_10 + var_17_20 then
				arg_14_1.typewritter.percent = (arg_14_1.time_ - var_17_10) / var_17_20

				arg_14_1.typewritter:SetDirty()
			end

			if arg_14_1.time_ >= var_17_10 + var_17_20 and arg_14_1.time_ < var_17_10 + var_17_20 + arg_17_0 then
				arg_14_1.typewritter.percent = 1

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(true)
			end
		end

		arg_14_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10032ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_14_1:InitPlayNodeList()
	end,
	Play116361004 = function(arg_18_0, arg_18_1)
		arg_18_1.time_ = 0
		arg_18_1.frameCnt_ = 0
		arg_18_1.state_ = "playing"
		arg_18_1.curTalkId_ = 116361004
		arg_18_1.duration_ = 6.63

		local var_18_0 = {
			zh = 3.733,
			ja = 6.633
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
				arg_18_0:Play116361005(arg_18_1)
			end
		end

		function arg_18_1.onSingleLineUpdate_(arg_21_0)
			local var_21_0 = arg_18_1.actors_["10032ui_story"].transform
			local var_21_1 = 0

			if var_21_1 < arg_18_1.time_ and arg_18_1.time_ <= var_21_1 + arg_21_0 then
				arg_18_1.var_.moveOldPos10032ui_story = var_21_0.localPosition
			end

			local var_21_2 = 0.001

			if var_21_1 <= arg_18_1.time_ and arg_18_1.time_ < var_21_1 + var_21_2 then
				local var_21_3 = (arg_18_1.time_ - var_21_1) / var_21_2
				local var_21_4 = Vector3.New(0, -1.1, -5.9)

				var_21_0.localPosition = Vector3.Lerp(arg_18_1.var_.moveOldPos10032ui_story, var_21_4, var_21_3)

				local var_21_5 = manager.ui.mainCamera.transform.position - var_21_0.position

				var_21_0.forward = Vector3.New(var_21_5.x, var_21_5.y, var_21_5.z)

				local var_21_6 = var_21_0.localEulerAngles

				var_21_6.z = 0
				var_21_6.x = 0
				var_21_0.localEulerAngles = var_21_6
			end

			if arg_18_1.time_ >= var_21_1 + var_21_2 and arg_18_1.time_ < var_21_1 + var_21_2 + arg_21_0 then
				var_21_0.localPosition = Vector3.New(0, -1.1, -5.9)

				local var_21_7 = manager.ui.mainCamera.transform.position - var_21_0.position

				var_21_0.forward = Vector3.New(var_21_7.x, var_21_7.y, var_21_7.z)

				local var_21_8 = var_21_0.localEulerAngles

				var_21_8.z = 0
				var_21_8.x = 0
				var_21_0.localEulerAngles = var_21_8
			end

			local var_21_9 = 0

			if var_21_9 < arg_18_1.time_ and arg_18_1.time_ <= var_21_9 + arg_21_0 then
				arg_18_1:PlayTimeline("10032ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_21_10 = 0

			if var_21_10 < arg_18_1.time_ and arg_18_1.time_ <= var_21_10 + arg_21_0 then
				arg_18_1:PlayTimeline("10032ui_story", "StoryTimeline/CharAction/story10025/story10025actionlink/10025action447")
			end

			local var_21_11 = 0
			local var_21_12 = 0.25

			if var_21_11 < arg_18_1.time_ and arg_18_1.time_ <= var_21_11 + arg_21_0 then
				arg_18_1.talkMaxDuration = 0
				arg_18_1.dialogCg_.alpha = 1

				arg_18_1.dialog_:SetActive(true)
				SetActive(arg_18_1.leftNameGo_, true)

				local var_21_13 = arg_18_1:FormatText(StoryNameCfg[328].name)

				arg_18_1.leftNameTxt_.text = var_21_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_18_1.leftNameTxt_.transform)

				arg_18_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_18_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_18_1:RecordName(arg_18_1.leftNameTxt_.text)
				SetActive(arg_18_1.iconTrs_.gameObject, false)
				arg_18_1.callingController_:SetSelectedState("normal")

				local var_21_14 = arg_18_1:GetWordFromCfg(116361004)
				local var_21_15 = arg_18_1:FormatText(var_21_14.content)

				arg_18_1.text_.text = var_21_15

				LuaForUtil.ClearLinePrefixSymbol(arg_18_1.text_)

				local var_21_16 = 10
				local var_21_17 = utf8.len(var_21_15)
				local var_21_18 = var_21_16 <= 0 and var_21_12 or var_21_12 * (var_21_17 / var_21_16)

				if var_21_18 > 0 and var_21_12 < var_21_18 then
					arg_18_1.talkMaxDuration = var_21_18

					if var_21_18 + var_21_11 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_18 + var_21_11
					end
				end

				arg_18_1.text_.text = var_21_15
				arg_18_1.typewritter.percent = 0

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116361", "116361004", "story_v_out_116361.awb") ~= 0 then
					local var_21_19 = manager.audio:GetVoiceLength("story_v_out_116361", "116361004", "story_v_out_116361.awb") / 1000

					if var_21_19 + var_21_11 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_19 + var_21_11
					end

					if var_21_14.prefab_name ~= "" and arg_18_1.actors_[var_21_14.prefab_name] ~= nil then
						local var_21_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_18_1.actors_[var_21_14.prefab_name].transform, "story_v_out_116361", "116361004", "story_v_out_116361.awb")

						arg_18_1:RecordAudio("116361004", var_21_20)
						arg_18_1:RecordAudio("116361004", var_21_20)
					else
						arg_18_1:AudioAction("play", "voice", "story_v_out_116361", "116361004", "story_v_out_116361.awb")
					end

					arg_18_1:RecordHistoryTalkVoice("story_v_out_116361", "116361004", "story_v_out_116361.awb")
				end

				arg_18_1:RecordContent(arg_18_1.text_.text)
			end

			local var_21_21 = math.max(var_21_12, arg_18_1.talkMaxDuration)

			if var_21_11 <= arg_18_1.time_ and arg_18_1.time_ < var_21_11 + var_21_21 then
				arg_18_1.typewritter.percent = (arg_18_1.time_ - var_21_11) / var_21_21

				arg_18_1.typewritter:SetDirty()
			end

			if arg_18_1.time_ >= var_21_11 + var_21_21 and arg_18_1.time_ < var_21_11 + var_21_21 + arg_21_0 then
				arg_18_1.typewritter.percent = 1

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(true)
			end
		end

		arg_18_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10032ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_18_1:InitPlayNodeList()
	end,
	Play116361005 = function(arg_22_0, arg_22_1)
		arg_22_1.marker = "Mark2"
		arg_22_1.time_ = 0
		arg_22_1.frameCnt_ = 0
		arg_22_1.state_ = "playing"
		arg_22_1.curTalkId_ = 116361005
		arg_22_1.duration_ = 12.69

		SetActive(arg_22_1.tipsGo_, false)

		function arg_22_1.onSingleLineFinish_()
			arg_22_1.onSingleLineUpdate_ = nil
			arg_22_1.onSingleLineFinish_ = nil
			arg_22_1.state_ = "waiting"
		end

		function arg_22_1.playNext_(arg_24_0)
			arg_22_1.marker = ""

			if arg_24_0 == 1 then
				arg_22_0:Play116361006(arg_22_1)
			end
		end

		function arg_22_1.onSingleLineUpdate_(arg_25_0)
			local var_25_0 = "ST15"

			if arg_22_1.bgs_[var_25_0] == nil then
				local var_25_1 = Object.Instantiate(arg_22_1.paintGo_)

				var_25_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_25_0)
				var_25_1.name = var_25_0
				var_25_1.transform.parent = arg_22_1.stage_.transform
				var_25_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_22_1.bgs_[var_25_0] = var_25_1
			end

			local var_25_2 = 5.68666666666667

			if var_25_2 < arg_22_1.time_ and arg_22_1.time_ <= var_25_2 + arg_25_0 then
				local var_25_3 = manager.ui.mainCamera.transform.localPosition
				local var_25_4 = Vector3.New(0, 0, 10) + Vector3.New(var_25_3.x, var_25_3.y, 0)
				local var_25_5 = arg_22_1.bgs_.ST15

				var_25_5.transform.localPosition = var_25_4
				var_25_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_25_6 = var_25_5:GetComponent("SpriteRenderer")

				if var_25_6 and var_25_6.sprite then
					local var_25_7 = (var_25_5.transform.localPosition - var_25_3).z
					local var_25_8 = manager.ui.mainCameraCom_
					local var_25_9 = 2 * var_25_7 * Mathf.Tan(var_25_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_25_10 = var_25_9 * var_25_8.aspect
					local var_25_11 = var_25_6.sprite.bounds.size.x
					local var_25_12 = var_25_6.sprite.bounds.size.y
					local var_25_13 = var_25_10 / var_25_11
					local var_25_14 = var_25_9 / var_25_12
					local var_25_15 = var_25_14 < var_25_13 and var_25_13 or var_25_14

					var_25_5.transform.localScale = Vector3.New(var_25_15, var_25_15, 0)
				end

				for iter_25_0, iter_25_1 in pairs(arg_22_1.bgs_) do
					if iter_25_0 ~= "ST15" then
						iter_25_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_25_16 = 5.68666666666667

			if var_25_16 < arg_22_1.time_ and arg_22_1.time_ <= var_25_16 + arg_25_0 then
				arg_22_1.mask_.enabled = true
				arg_22_1.mask_.raycastTarget = true

				arg_22_1:SetGaussion(false)
			end

			local var_25_17 = 2

			if var_25_16 <= arg_22_1.time_ and arg_22_1.time_ < var_25_16 + var_25_17 then
				local var_25_18 = (arg_22_1.time_ - var_25_16) / var_25_17
				local var_25_19 = Color.New(0, 0, 0)

				var_25_19.a = Mathf.Lerp(1, 0, var_25_18)
				arg_22_1.mask_.color = var_25_19
			end

			if arg_22_1.time_ >= var_25_16 + var_25_17 and arg_22_1.time_ < var_25_16 + var_25_17 + arg_25_0 then
				local var_25_20 = Color.New(0, 0, 0)
				local var_25_21 = 0

				arg_22_1.mask_.enabled = false
				var_25_20.a = var_25_21
				arg_22_1.mask_.color = var_25_20
			end

			local var_25_22 = 2

			if var_25_22 < arg_22_1.time_ and arg_22_1.time_ <= var_25_22 + arg_25_0 then
				SetActive(arg_22_1.dialog_, false)
				SetActive(arg_22_1.allBtn_.gameObject, false)
				arg_22_1.hideBtnsController_:SetSelectedIndex(1)

				arg_22_1.marker = "PlayCantSkipVideo"

				manager.video:Play("SofdecAsset/story/story_101161201.usm", function(arg_26_0)
					arg_22_1.time_ = var_25_22 + 3.66000000022352

					if arg_22_1.state_ == "pause" then
						arg_22_1.state_ = "playing"
					end

					manager.video:Dispose()
				end, nil, nil, function(arg_27_0)
					if arg_27_0 then
						arg_22_1.state_ = "pause"
					else
						arg_22_1.state_ = "playing"
					end
				end)
				manager.video.transform_:SetSiblingIndex(1)
			end

			local var_25_23 = 3.67

			if var_25_22 <= arg_22_1.time_ and arg_22_1.time_ < var_25_22 + var_25_23 then
				-- block empty
			end

			if arg_22_1.time_ >= var_25_22 + var_25_23 and arg_22_1.time_ < var_25_22 + var_25_23 + arg_25_0 then
				arg_22_1.marker = ""
			end

			local var_25_24 = 5.67

			if var_25_24 < arg_22_1.time_ and arg_22_1.time_ <= var_25_24 + arg_25_0 then
				SetActive(arg_22_1.dialog_, false)
				SetActive(arg_22_1.allBtn_.gameObject, true)
				arg_22_1.hideBtnsController_:SetSelectedIndex(0)
				manager.video:Dispose()

				arg_22_1.isInLoopVideo = false
			end

			local var_25_25 = 0.0166666666666667

			if var_25_24 <= arg_22_1.time_ and arg_22_1.time_ < var_25_24 + var_25_25 then
				-- block empty
			end

			if arg_22_1.time_ >= var_25_24 + var_25_25 and arg_22_1.time_ < var_25_24 + var_25_25 + arg_25_0 then
				-- block empty
			end

			local var_25_26 = arg_22_1.actors_["10032ui_story"].transform
			local var_25_27 = 1.966

			if var_25_27 < arg_22_1.time_ and arg_22_1.time_ <= var_25_27 + arg_25_0 then
				arg_22_1.var_.moveOldPos10032ui_story = var_25_26.localPosition
			end

			local var_25_28 = 0.001

			if var_25_27 <= arg_22_1.time_ and arg_22_1.time_ < var_25_27 + var_25_28 then
				local var_25_29 = (arg_22_1.time_ - var_25_27) / var_25_28
				local var_25_30 = Vector3.New(0, 100, 0)

				var_25_26.localPosition = Vector3.Lerp(arg_22_1.var_.moveOldPos10032ui_story, var_25_30, var_25_29)

				local var_25_31 = manager.ui.mainCamera.transform.position - var_25_26.position

				var_25_26.forward = Vector3.New(var_25_31.x, var_25_31.y, var_25_31.z)

				local var_25_32 = var_25_26.localEulerAngles

				var_25_32.z = 0
				var_25_32.x = 0
				var_25_26.localEulerAngles = var_25_32
			end

			if arg_22_1.time_ >= var_25_27 + var_25_28 and arg_22_1.time_ < var_25_27 + var_25_28 + arg_25_0 then
				var_25_26.localPosition = Vector3.New(0, 100, 0)

				local var_25_33 = manager.ui.mainCamera.transform.position - var_25_26.position

				var_25_26.forward = Vector3.New(var_25_33.x, var_25_33.y, var_25_33.z)

				local var_25_34 = var_25_26.localEulerAngles

				var_25_34.z = 0
				var_25_34.x = 0
				var_25_26.localEulerAngles = var_25_34
			end

			local var_25_35 = 2.034
			local var_25_36 = 0.666666666666667

			if var_25_35 < arg_22_1.time_ and arg_22_1.time_ <= var_25_35 + arg_25_0 then
				local var_25_37 = "play"
				local var_25_38 = "music"

				arg_22_1:AudioAction(var_25_37, var_25_38, "ui_battle", "ui_battle_stopbgm", "")

				local var_25_39 = ""
				local var_25_40 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_25_40 ~= "" then
					if arg_22_1.bgmTxt_.text ~= var_25_40 and arg_22_1.bgmTxt_.text ~= "" then
						if arg_22_1.bgmTxt2_.text ~= "" then
							arg_22_1.bgmTxt_.text = arg_22_1.bgmTxt2_.text
						end

						arg_22_1.bgmTxt2_.text = var_25_40

						arg_22_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_22_1.bgmTxt_.text = var_25_40
						arg_22_1.bgmTxt2_.text = var_25_40
					end

					if arg_22_1.bgmTimer then
						arg_22_1.bgmTimer:Stop()

						arg_22_1.bgmTimer = nil
					end

					if arg_22_1.settingData.show_music_name == 1 then
						arg_22_1.musicController:SetSelectedState("show")
						arg_22_1.musicAnimator_:Play("open", 0, 0)

						if arg_22_1.settingData.music_time ~= 0 then
							arg_22_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_22_1.settingData.music_time), function()
								if arg_22_1 == nil or isNil(arg_22_1.bgmTxt_) then
									return
								end

								arg_22_1.musicController:SetSelectedState("hide")
								arg_22_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_25_41 = 7.68666666666667
			local var_25_42 = 0.483333333333333

			if var_25_41 < arg_22_1.time_ and arg_22_1.time_ <= var_25_41 + arg_25_0 then
				local var_25_43 = "play"
				local var_25_44 = "music"

				arg_22_1:AudioAction(var_25_43, var_25_44, "bgm_side_daily05", "bgm_side_daily05", "bgm_side_daily05.awb")

				local var_25_45 = ""
				local var_25_46 = manager.audio:GetAudioName("bgm_side_daily05", "bgm_side_daily05")

				if var_25_46 ~= "" then
					if arg_22_1.bgmTxt_.text ~= var_25_46 and arg_22_1.bgmTxt_.text ~= "" then
						if arg_22_1.bgmTxt2_.text ~= "" then
							arg_22_1.bgmTxt_.text = arg_22_1.bgmTxt2_.text
						end

						arg_22_1.bgmTxt2_.text = var_25_46

						arg_22_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_22_1.bgmTxt_.text = var_25_46
						arg_22_1.bgmTxt2_.text = var_25_46
					end

					if arg_22_1.bgmTimer then
						arg_22_1.bgmTimer:Stop()

						arg_22_1.bgmTimer = nil
					end

					if arg_22_1.settingData.show_music_name == 1 then
						arg_22_1.musicController:SetSelectedState("show")
						arg_22_1.musicAnimator_:Play("open", 0, 0)

						if arg_22_1.settingData.music_time ~= 0 then
							arg_22_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_22_1.settingData.music_time), function()
								if arg_22_1 == nil or isNil(arg_22_1.bgmTxt_) then
									return
								end

								arg_22_1.musicController:SetSelectedState("hide")
								arg_22_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_25_47 = 0

			if var_25_47 < arg_22_1.time_ and arg_22_1.time_ <= var_25_47 + arg_25_0 then
				arg_22_1.mask_.enabled = true
				arg_22_1.mask_.raycastTarget = true

				arg_22_1:SetGaussion(false)
			end

			local var_25_48 = 2

			if var_25_47 <= arg_22_1.time_ and arg_22_1.time_ < var_25_47 + var_25_48 then
				local var_25_49 = (arg_22_1.time_ - var_25_47) / var_25_48
				local var_25_50 = Color.New(0, 0, 0)

				var_25_50.a = Mathf.Lerp(0, 1, var_25_49)
				arg_22_1.mask_.color = var_25_50
			end

			if arg_22_1.time_ >= var_25_47 + var_25_48 and arg_22_1.time_ < var_25_47 + var_25_48 + arg_25_0 then
				local var_25_51 = Color.New(0, 0, 0)

				var_25_51.a = 1
				arg_22_1.mask_.color = var_25_51
			end

			local var_25_52 = 2

			if var_25_52 < arg_22_1.time_ and arg_22_1.time_ <= var_25_52 + arg_25_0 then
				arg_22_1.mask_.enabled = true
				arg_22_1.mask_.raycastTarget = true

				arg_22_1:SetGaussion(false)
			end

			local var_25_53 = 0.0166666666666667

			if var_25_52 <= arg_22_1.time_ and arg_22_1.time_ < var_25_52 + var_25_53 then
				local var_25_54 = (arg_22_1.time_ - var_25_52) / var_25_53
				local var_25_55 = Color.New(0, 0, 0)

				var_25_55.a = Mathf.Lerp(1, 0, var_25_54)
				arg_22_1.mask_.color = var_25_55
			end

			if arg_22_1.time_ >= var_25_52 + var_25_53 and arg_22_1.time_ < var_25_52 + var_25_53 + arg_25_0 then
				local var_25_56 = Color.New(0, 0, 0)
				local var_25_57 = 0

				arg_22_1.mask_.enabled = false
				var_25_56.a = var_25_57
				arg_22_1.mask_.color = var_25_56
			end

			if arg_22_1.frameCnt_ <= 1 then
				arg_22_1.dialog_:SetActive(false)
			end

			local var_25_58 = 7.68666666666667
			local var_25_59 = 0.5

			if var_25_58 < arg_22_1.time_ and arg_22_1.time_ <= var_25_58 + arg_25_0 then
				arg_22_1.talkMaxDuration = 0

				arg_22_1.dialog_:SetActive(true)

				arg_22_1.dialogCg_.alpha = 0

				local var_25_60 = LeanTween.value(arg_22_1.dialog_, 0, 1, 0.3)

				var_25_60:setOnUpdate(LuaHelper.FloatAction(function(arg_30_0)
					arg_22_1.dialogCg_.alpha = arg_30_0
				end))
				var_25_60:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_22_1.dialog_)
					var_25_60:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_22_1.duration_ = arg_22_1.duration_ + 0.3

				SetActive(arg_22_1.leftNameGo_, true)

				local var_25_61 = arg_22_1:FormatText(StoryNameCfg[344].name)

				arg_22_1.leftNameTxt_.text = var_25_61

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_22_1.leftNameTxt_.transform)

				arg_22_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_22_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_22_1:RecordName(arg_22_1.leftNameTxt_.text)
				SetActive(arg_22_1.iconTrs_.gameObject, false)
				arg_22_1.callingController_:SetSelectedState("normal")

				local var_25_62 = arg_22_1:GetWordFromCfg(116361005)
				local var_25_63 = arg_22_1:FormatText(var_25_62.content)

				arg_22_1.text_.text = var_25_63

				LuaForUtil.ClearLinePrefixSymbol(arg_22_1.text_)

				local var_25_64 = 20
				local var_25_65 = utf8.len(var_25_63)
				local var_25_66 = var_25_64 <= 0 and var_25_59 or var_25_59 * (var_25_65 / var_25_64)

				if var_25_66 > 0 and var_25_59 < var_25_66 then
					arg_22_1.talkMaxDuration = var_25_66
					var_25_58 = var_25_58 + 0.3

					if var_25_66 + var_25_58 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_66 + var_25_58
					end
				end

				arg_22_1.text_.text = var_25_63
				arg_22_1.typewritter.percent = 0

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(false)
				arg_22_1:RecordContent(arg_22_1.text_.text)
			end

			local var_25_67 = var_25_58 + 0.3
			local var_25_68 = math.max(var_25_59, arg_22_1.talkMaxDuration)

			if var_25_67 <= arg_22_1.time_ and arg_22_1.time_ < var_25_67 + var_25_68 then
				arg_22_1.typewritter.percent = (arg_22_1.time_ - var_25_67) / var_25_68

				arg_22_1.typewritter:SetDirty()
			end

			if arg_22_1.time_ >= var_25_67 + var_25_68 and arg_22_1.time_ < var_25_67 + var_25_68 + arg_25_0 then
				arg_22_1.typewritter.percent = 1

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(true)
			end
		end

		arg_22_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10032ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_22_1:InitPlayNodeList()
	end,
	Play116361006 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 116361006
		arg_32_1.duration_ = 6.03

		local var_32_0 = {
			zh = 4.933,
			ja = 6.033
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
				arg_32_0:Play116361007(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = "10025ui_story"

			if arg_32_1.actors_[var_35_0] == nil then
				local var_35_1 = Asset.Load("Char/" .. "10025ui_story")

				if not isNil(var_35_1) then
					local var_35_2 = Object.Instantiate(Asset.Load("Char/" .. "10025ui_story"), arg_32_1.stage_.transform)

					var_35_2.name = var_35_0
					var_35_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_32_1.actors_[var_35_0] = var_35_2

					local var_35_3 = var_35_2:GetComponentInChildren(typeof(CharacterEffect))

					var_35_3.enabled = true

					local var_35_4 = GameObjectTools.GetOrAddComponent(var_35_2, typeof(DynamicBoneHelper))

					if var_35_4 then
						var_35_4:EnableDynamicBone(false)
					end

					arg_32_1:ShowWeapon(var_35_3.transform, false)

					arg_32_1.var_[var_35_0 .. "Animator"] = var_35_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_32_1.var_[var_35_0 .. "Animator"].applyRootMotion = true
					arg_32_1.var_[var_35_0 .. "LipSync"] = var_35_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_35_5 = arg_32_1.actors_["10025ui_story"].transform
			local var_35_6 = 0

			if var_35_6 < arg_32_1.time_ and arg_32_1.time_ <= var_35_6 + arg_35_0 then
				arg_32_1.var_.moveOldPos10025ui_story = var_35_5.localPosition
			end

			local var_35_7 = 0.001

			if var_35_6 <= arg_32_1.time_ and arg_32_1.time_ < var_35_6 + var_35_7 then
				local var_35_8 = (arg_32_1.time_ - var_35_6) / var_35_7
				local var_35_9 = Vector3.New(0, -1.1, -5.9)

				var_35_5.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos10025ui_story, var_35_9, var_35_8)

				local var_35_10 = manager.ui.mainCamera.transform.position - var_35_5.position

				var_35_5.forward = Vector3.New(var_35_10.x, var_35_10.y, var_35_10.z)

				local var_35_11 = var_35_5.localEulerAngles

				var_35_11.z = 0
				var_35_11.x = 0
				var_35_5.localEulerAngles = var_35_11
			end

			if arg_32_1.time_ >= var_35_6 + var_35_7 and arg_32_1.time_ < var_35_6 + var_35_7 + arg_35_0 then
				var_35_5.localPosition = Vector3.New(0, -1.1, -5.9)

				local var_35_12 = manager.ui.mainCamera.transform.position - var_35_5.position

				var_35_5.forward = Vector3.New(var_35_12.x, var_35_12.y, var_35_12.z)

				local var_35_13 = var_35_5.localEulerAngles

				var_35_13.z = 0
				var_35_13.x = 0
				var_35_5.localEulerAngles = var_35_13
			end

			local var_35_14 = 0

			if var_35_14 < arg_32_1.time_ and arg_32_1.time_ <= var_35_14 + arg_35_0 then
				arg_32_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_35_15 = 0

			if var_35_15 < arg_32_1.time_ and arg_32_1.time_ <= var_35_15 + arg_35_0 then
				arg_32_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action5_1")
			end

			local var_35_16 = arg_32_1.actors_["10025ui_story"]
			local var_35_17 = 0

			if var_35_17 < arg_32_1.time_ and arg_32_1.time_ <= var_35_17 + arg_35_0 and not isNil(var_35_16) and arg_32_1.var_.characterEffect10025ui_story == nil then
				arg_32_1.var_.characterEffect10025ui_story = var_35_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_18 = 0.2

			if var_35_17 <= arg_32_1.time_ and arg_32_1.time_ < var_35_17 + var_35_18 and not isNil(var_35_16) then
				local var_35_19 = (arg_32_1.time_ - var_35_17) / var_35_18

				if arg_32_1.var_.characterEffect10025ui_story and not isNil(var_35_16) then
					arg_32_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_32_1.time_ >= var_35_17 + var_35_18 and arg_32_1.time_ < var_35_17 + var_35_18 + arg_35_0 and not isNil(var_35_16) and arg_32_1.var_.characterEffect10025ui_story then
				arg_32_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			local var_35_20 = 0
			local var_35_21 = 0.35

			if var_35_20 < arg_32_1.time_ and arg_32_1.time_ <= var_35_20 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				local var_35_22 = arg_32_1:FormatText(StoryNameCfg[328].name)

				arg_32_1.leftNameTxt_.text = var_35_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_23 = arg_32_1:GetWordFromCfg(116361006)
				local var_35_24 = arg_32_1:FormatText(var_35_23.content)

				arg_32_1.text_.text = var_35_24

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_25 = 14
				local var_35_26 = utf8.len(var_35_24)
				local var_35_27 = var_35_25 <= 0 and var_35_21 or var_35_21 * (var_35_26 / var_35_25)

				if var_35_27 > 0 and var_35_21 < var_35_27 then
					arg_32_1.talkMaxDuration = var_35_27

					if var_35_27 + var_35_20 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_27 + var_35_20
					end
				end

				arg_32_1.text_.text = var_35_24
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116361", "116361006", "story_v_out_116361.awb") ~= 0 then
					local var_35_28 = manager.audio:GetVoiceLength("story_v_out_116361", "116361006", "story_v_out_116361.awb") / 1000

					if var_35_28 + var_35_20 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_28 + var_35_20
					end

					if var_35_23.prefab_name ~= "" and arg_32_1.actors_[var_35_23.prefab_name] ~= nil then
						local var_35_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_23.prefab_name].transform, "story_v_out_116361", "116361006", "story_v_out_116361.awb")

						arg_32_1:RecordAudio("116361006", var_35_29)
						arg_32_1:RecordAudio("116361006", var_35_29)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_116361", "116361006", "story_v_out_116361.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_116361", "116361006", "story_v_out_116361.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_30 = math.max(var_35_21, arg_32_1.talkMaxDuration)

			if var_35_20 <= arg_32_1.time_ and arg_32_1.time_ < var_35_20 + var_35_30 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_20) / var_35_30

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_20 + var_35_30 and arg_32_1.time_ < var_35_20 + var_35_30 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_32_1:InitPlayNodeList()
	end,
	Play116361007 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 116361007
		arg_36_1.duration_ = 5

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play116361008(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = arg_36_1.actors_["10025ui_story"]
			local var_39_1 = 0

			if var_39_1 < arg_36_1.time_ and arg_36_1.time_ <= var_39_1 + arg_39_0 and not isNil(var_39_0) and arg_36_1.var_.characterEffect10025ui_story == nil then
				arg_36_1.var_.characterEffect10025ui_story = var_39_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_2 = 0.2

			if var_39_1 <= arg_36_1.time_ and arg_36_1.time_ < var_39_1 + var_39_2 and not isNil(var_39_0) then
				local var_39_3 = (arg_36_1.time_ - var_39_1) / var_39_2

				if arg_36_1.var_.characterEffect10025ui_story and not isNil(var_39_0) then
					local var_39_4 = Mathf.Lerp(0, 0.5, var_39_3)

					arg_36_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_36_1.var_.characterEffect10025ui_story.fillRatio = var_39_4
				end
			end

			if arg_36_1.time_ >= var_39_1 + var_39_2 and arg_36_1.time_ < var_39_1 + var_39_2 + arg_39_0 and not isNil(var_39_0) and arg_36_1.var_.characterEffect10025ui_story then
				local var_39_5 = 0.5

				arg_36_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_36_1.var_.characterEffect10025ui_story.fillRatio = var_39_5
			end

			local var_39_6 = 0
			local var_39_7 = 1.05

			if var_39_6 < arg_36_1.time_ and arg_36_1.time_ <= var_39_6 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				local var_39_8 = arg_36_1:FormatText(StoryNameCfg[344].name)

				arg_36_1.leftNameTxt_.text = var_39_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_9 = arg_36_1:GetWordFromCfg(116361007)
				local var_39_10 = arg_36_1:FormatText(var_39_9.content)

				arg_36_1.text_.text = var_39_10

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_11 = 42
				local var_39_12 = utf8.len(var_39_10)
				local var_39_13 = var_39_11 <= 0 and var_39_7 or var_39_7 * (var_39_12 / var_39_11)

				if var_39_13 > 0 and var_39_7 < var_39_13 then
					arg_36_1.talkMaxDuration = var_39_13

					if var_39_13 + var_39_6 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_13 + var_39_6
					end
				end

				arg_36_1.text_.text = var_39_10
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)
				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_14 = math.max(var_39_7, arg_36_1.talkMaxDuration)

			if var_39_6 <= arg_36_1.time_ and arg_36_1.time_ < var_39_6 + var_39_14 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_6) / var_39_14

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_6 + var_39_14 and arg_36_1.time_ < var_39_6 + var_39_14 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play116361008 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 116361008
		arg_40_1.duration_ = 3.4

		local var_40_0 = {
			zh = 3.4,
			ja = 3.2
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
				arg_40_0:Play116361009(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = arg_40_1.actors_["10025ui_story"].transform
			local var_43_1 = 0

			if var_43_1 < arg_40_1.time_ and arg_40_1.time_ <= var_43_1 + arg_43_0 then
				arg_40_1.var_.moveOldPos10025ui_story = var_43_0.localPosition
			end

			local var_43_2 = 0.001

			if var_43_1 <= arg_40_1.time_ and arg_40_1.time_ < var_43_1 + var_43_2 then
				local var_43_3 = (arg_40_1.time_ - var_43_1) / var_43_2
				local var_43_4 = Vector3.New(0, -1.1, -5.9)

				var_43_0.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos10025ui_story, var_43_4, var_43_3)

				local var_43_5 = manager.ui.mainCamera.transform.position - var_43_0.position

				var_43_0.forward = Vector3.New(var_43_5.x, var_43_5.y, var_43_5.z)

				local var_43_6 = var_43_0.localEulerAngles

				var_43_6.z = 0
				var_43_6.x = 0
				var_43_0.localEulerAngles = var_43_6
			end

			if arg_40_1.time_ >= var_43_1 + var_43_2 and arg_40_1.time_ < var_43_1 + var_43_2 + arg_43_0 then
				var_43_0.localPosition = Vector3.New(0, -1.1, -5.9)

				local var_43_7 = manager.ui.mainCamera.transform.position - var_43_0.position

				var_43_0.forward = Vector3.New(var_43_7.x, var_43_7.y, var_43_7.z)

				local var_43_8 = var_43_0.localEulerAngles

				var_43_8.z = 0
				var_43_8.x = 0
				var_43_0.localEulerAngles = var_43_8
			end

			local var_43_9 = 0

			if var_43_9 < arg_40_1.time_ and arg_40_1.time_ <= var_43_9 + arg_43_0 then
				arg_40_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_43_10 = 0

			if var_43_10 < arg_40_1.time_ and arg_40_1.time_ <= var_43_10 + arg_43_0 then
				arg_40_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action5_2")
			end

			local var_43_11 = arg_40_1.actors_["10025ui_story"]
			local var_43_12 = 0

			if var_43_12 < arg_40_1.time_ and arg_40_1.time_ <= var_43_12 + arg_43_0 and not isNil(var_43_11) and arg_40_1.var_.characterEffect10025ui_story == nil then
				arg_40_1.var_.characterEffect10025ui_story = var_43_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_13 = 0.2

			if var_43_12 <= arg_40_1.time_ and arg_40_1.time_ < var_43_12 + var_43_13 and not isNil(var_43_11) then
				local var_43_14 = (arg_40_1.time_ - var_43_12) / var_43_13

				if arg_40_1.var_.characterEffect10025ui_story and not isNil(var_43_11) then
					arg_40_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_40_1.time_ >= var_43_12 + var_43_13 and arg_40_1.time_ < var_43_12 + var_43_13 + arg_43_0 and not isNil(var_43_11) and arg_40_1.var_.characterEffect10025ui_story then
				arg_40_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			local var_43_15 = 0
			local var_43_16 = 0.225

			if var_43_15 < arg_40_1.time_ and arg_40_1.time_ <= var_43_15 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				local var_43_17 = arg_40_1:FormatText(StoryNameCfg[328].name)

				arg_40_1.leftNameTxt_.text = var_43_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_18 = arg_40_1:GetWordFromCfg(116361008)
				local var_43_19 = arg_40_1:FormatText(var_43_18.content)

				arg_40_1.text_.text = var_43_19

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_20 = 9
				local var_43_21 = utf8.len(var_43_19)
				local var_43_22 = var_43_20 <= 0 and var_43_16 or var_43_16 * (var_43_21 / var_43_20)

				if var_43_22 > 0 and var_43_16 < var_43_22 then
					arg_40_1.talkMaxDuration = var_43_22

					if var_43_22 + var_43_15 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_22 + var_43_15
					end
				end

				arg_40_1.text_.text = var_43_19
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116361", "116361008", "story_v_out_116361.awb") ~= 0 then
					local var_43_23 = manager.audio:GetVoiceLength("story_v_out_116361", "116361008", "story_v_out_116361.awb") / 1000

					if var_43_23 + var_43_15 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_23 + var_43_15
					end

					if var_43_18.prefab_name ~= "" and arg_40_1.actors_[var_43_18.prefab_name] ~= nil then
						local var_43_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_18.prefab_name].transform, "story_v_out_116361", "116361008", "story_v_out_116361.awb")

						arg_40_1:RecordAudio("116361008", var_43_24)
						arg_40_1:RecordAudio("116361008", var_43_24)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_116361", "116361008", "story_v_out_116361.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_116361", "116361008", "story_v_out_116361.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_25 = math.max(var_43_16, arg_40_1.talkMaxDuration)

			if var_43_15 <= arg_40_1.time_ and arg_40_1.time_ < var_43_15 + var_43_25 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_15) / var_43_25

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_15 + var_43_25 and arg_40_1.time_ < var_43_15 + var_43_25 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_40_1:InitPlayNodeList()
	end,
	Play116361009 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 116361009
		arg_44_1.duration_ = 5

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play116361010(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = arg_44_1.actors_["10025ui_story"]
			local var_47_1 = 0

			if var_47_1 < arg_44_1.time_ and arg_44_1.time_ <= var_47_1 + arg_47_0 and not isNil(var_47_0) and arg_44_1.var_.characterEffect10025ui_story == nil then
				arg_44_1.var_.characterEffect10025ui_story = var_47_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_2 = 0.2

			if var_47_1 <= arg_44_1.time_ and arg_44_1.time_ < var_47_1 + var_47_2 and not isNil(var_47_0) then
				local var_47_3 = (arg_44_1.time_ - var_47_1) / var_47_2

				if arg_44_1.var_.characterEffect10025ui_story and not isNil(var_47_0) then
					local var_47_4 = Mathf.Lerp(0, 0.5, var_47_3)

					arg_44_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_44_1.var_.characterEffect10025ui_story.fillRatio = var_47_4
				end
			end

			if arg_44_1.time_ >= var_47_1 + var_47_2 and arg_44_1.time_ < var_47_1 + var_47_2 + arg_47_0 and not isNil(var_47_0) and arg_44_1.var_.characterEffect10025ui_story then
				local var_47_5 = 0.5

				arg_44_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_44_1.var_.characterEffect10025ui_story.fillRatio = var_47_5
			end

			local var_47_6 = 0
			local var_47_7 = 1.475

			if var_47_6 < arg_44_1.time_ and arg_44_1.time_ <= var_47_6 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				local var_47_8 = arg_44_1:FormatText(StoryNameCfg[344].name)

				arg_44_1.leftNameTxt_.text = var_47_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_9 = arg_44_1:GetWordFromCfg(116361009)
				local var_47_10 = arg_44_1:FormatText(var_47_9.content)

				arg_44_1.text_.text = var_47_10

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_11 = 59
				local var_47_12 = utf8.len(var_47_10)
				local var_47_13 = var_47_11 <= 0 and var_47_7 or var_47_7 * (var_47_12 / var_47_11)

				if var_47_13 > 0 and var_47_7 < var_47_13 then
					arg_44_1.talkMaxDuration = var_47_13

					if var_47_13 + var_47_6 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_13 + var_47_6
					end
				end

				arg_44_1.text_.text = var_47_10
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)
				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_14 = math.max(var_47_7, arg_44_1.talkMaxDuration)

			if var_47_6 <= arg_44_1.time_ and arg_44_1.time_ < var_47_6 + var_47_14 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_6) / var_47_14

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_6 + var_47_14 and arg_44_1.time_ < var_47_6 + var_47_14 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play116361010 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 116361010
		arg_48_1.duration_ = 7.6

		local var_48_0 = {
			zh = 6.966,
			ja = 7.6
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
				arg_48_0:Play116361011(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = arg_48_1.actors_["10025ui_story"].transform
			local var_51_1 = 0

			if var_51_1 < arg_48_1.time_ and arg_48_1.time_ <= var_51_1 + arg_51_0 then
				arg_48_1.var_.moveOldPos10025ui_story = var_51_0.localPosition
			end

			local var_51_2 = 0.001

			if var_51_1 <= arg_48_1.time_ and arg_48_1.time_ < var_51_1 + var_51_2 then
				local var_51_3 = (arg_48_1.time_ - var_51_1) / var_51_2
				local var_51_4 = Vector3.New(0, -1.1, -5.9)

				var_51_0.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos10025ui_story, var_51_4, var_51_3)

				local var_51_5 = manager.ui.mainCamera.transform.position - var_51_0.position

				var_51_0.forward = Vector3.New(var_51_5.x, var_51_5.y, var_51_5.z)

				local var_51_6 = var_51_0.localEulerAngles

				var_51_6.z = 0
				var_51_6.x = 0
				var_51_0.localEulerAngles = var_51_6
			end

			if arg_48_1.time_ >= var_51_1 + var_51_2 and arg_48_1.time_ < var_51_1 + var_51_2 + arg_51_0 then
				var_51_0.localPosition = Vector3.New(0, -1.1, -5.9)

				local var_51_7 = manager.ui.mainCamera.transform.position - var_51_0.position

				var_51_0.forward = Vector3.New(var_51_7.x, var_51_7.y, var_51_7.z)

				local var_51_8 = var_51_0.localEulerAngles

				var_51_8.z = 0
				var_51_8.x = 0
				var_51_0.localEulerAngles = var_51_8
			end

			local var_51_9 = 0

			if var_51_9 < arg_48_1.time_ and arg_48_1.time_ <= var_51_9 + arg_51_0 then
				arg_48_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_51_10 = arg_48_1.actors_["10025ui_story"]
			local var_51_11 = 0

			if var_51_11 < arg_48_1.time_ and arg_48_1.time_ <= var_51_11 + arg_51_0 and not isNil(var_51_10) and arg_48_1.var_.characterEffect10025ui_story == nil then
				arg_48_1.var_.characterEffect10025ui_story = var_51_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_12 = 0.2

			if var_51_11 <= arg_48_1.time_ and arg_48_1.time_ < var_51_11 + var_51_12 and not isNil(var_51_10) then
				local var_51_13 = (arg_48_1.time_ - var_51_11) / var_51_12

				if arg_48_1.var_.characterEffect10025ui_story and not isNil(var_51_10) then
					arg_48_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_48_1.time_ >= var_51_11 + var_51_12 and arg_48_1.time_ < var_51_11 + var_51_12 + arg_51_0 and not isNil(var_51_10) and arg_48_1.var_.characterEffect10025ui_story then
				arg_48_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			local var_51_14 = 0

			if var_51_14 < arg_48_1.time_ and arg_48_1.time_ <= var_51_14 + arg_51_0 then
				arg_48_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action4_1")
			end

			local var_51_15 = 0
			local var_51_16 = 0.575

			if var_51_15 < arg_48_1.time_ and arg_48_1.time_ <= var_51_15 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				local var_51_17 = arg_48_1:FormatText(StoryNameCfg[328].name)

				arg_48_1.leftNameTxt_.text = var_51_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_18 = arg_48_1:GetWordFromCfg(116361010)
				local var_51_19 = arg_48_1:FormatText(var_51_18.content)

				arg_48_1.text_.text = var_51_19

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_20 = 23
				local var_51_21 = utf8.len(var_51_19)
				local var_51_22 = var_51_20 <= 0 and var_51_16 or var_51_16 * (var_51_21 / var_51_20)

				if var_51_22 > 0 and var_51_16 < var_51_22 then
					arg_48_1.talkMaxDuration = var_51_22

					if var_51_22 + var_51_15 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_22 + var_51_15
					end
				end

				arg_48_1.text_.text = var_51_19
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116361", "116361010", "story_v_out_116361.awb") ~= 0 then
					local var_51_23 = manager.audio:GetVoiceLength("story_v_out_116361", "116361010", "story_v_out_116361.awb") / 1000

					if var_51_23 + var_51_15 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_23 + var_51_15
					end

					if var_51_18.prefab_name ~= "" and arg_48_1.actors_[var_51_18.prefab_name] ~= nil then
						local var_51_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_18.prefab_name].transform, "story_v_out_116361", "116361010", "story_v_out_116361.awb")

						arg_48_1:RecordAudio("116361010", var_51_24)
						arg_48_1:RecordAudio("116361010", var_51_24)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_116361", "116361010", "story_v_out_116361.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_116361", "116361010", "story_v_out_116361.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_25 = math.max(var_51_16, arg_48_1.talkMaxDuration)

			if var_51_15 <= arg_48_1.time_ and arg_48_1.time_ < var_51_15 + var_51_25 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_15) / var_51_25

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_15 + var_51_25 and arg_48_1.time_ < var_51_15 + var_51_25 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_48_1:InitPlayNodeList()
	end,
	Play116361011 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 116361011
		arg_52_1.duration_ = 5

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play116361012(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = arg_52_1.actors_["10025ui_story"]
			local var_55_1 = 0

			if var_55_1 < arg_52_1.time_ and arg_52_1.time_ <= var_55_1 + arg_55_0 and not isNil(var_55_0) and arg_52_1.var_.characterEffect10025ui_story == nil then
				arg_52_1.var_.characterEffect10025ui_story = var_55_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_2 = 0.2

			if var_55_1 <= arg_52_1.time_ and arg_52_1.time_ < var_55_1 + var_55_2 and not isNil(var_55_0) then
				local var_55_3 = (arg_52_1.time_ - var_55_1) / var_55_2

				if arg_52_1.var_.characterEffect10025ui_story and not isNil(var_55_0) then
					local var_55_4 = Mathf.Lerp(0, 0.5, var_55_3)

					arg_52_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_52_1.var_.characterEffect10025ui_story.fillRatio = var_55_4
				end
			end

			if arg_52_1.time_ >= var_55_1 + var_55_2 and arg_52_1.time_ < var_55_1 + var_55_2 + arg_55_0 and not isNil(var_55_0) and arg_52_1.var_.characterEffect10025ui_story then
				local var_55_5 = 0.5

				arg_52_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_52_1.var_.characterEffect10025ui_story.fillRatio = var_55_5
			end

			local var_55_6 = 0
			local var_55_7 = 0.525

			if var_55_6 < arg_52_1.time_ and arg_52_1.time_ <= var_55_6 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				local var_55_8 = arg_52_1:FormatText(StoryNameCfg[344].name)

				arg_52_1.leftNameTxt_.text = var_55_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_9 = arg_52_1:GetWordFromCfg(116361011)
				local var_55_10 = arg_52_1:FormatText(var_55_9.content)

				arg_52_1.text_.text = var_55_10

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_11 = 21
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
				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_14 = math.max(var_55_7, arg_52_1.talkMaxDuration)

			if var_55_6 <= arg_52_1.time_ and arg_52_1.time_ < var_55_6 + var_55_14 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_6) / var_55_14

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_6 + var_55_14 and arg_52_1.time_ < var_55_6 + var_55_14 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play116361012 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 116361012
		arg_56_1.duration_ = 2.7

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play116361013(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = arg_56_1.actors_["10025ui_story"].transform
			local var_59_1 = 0

			if var_59_1 < arg_56_1.time_ and arg_56_1.time_ <= var_59_1 + arg_59_0 then
				arg_56_1.var_.moveOldPos10025ui_story = var_59_0.localPosition
			end

			local var_59_2 = 0.001

			if var_59_1 <= arg_56_1.time_ and arg_56_1.time_ < var_59_1 + var_59_2 then
				local var_59_3 = (arg_56_1.time_ - var_59_1) / var_59_2
				local var_59_4 = Vector3.New(0, -1.1, -5.9)

				var_59_0.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos10025ui_story, var_59_4, var_59_3)

				local var_59_5 = manager.ui.mainCamera.transform.position - var_59_0.position

				var_59_0.forward = Vector3.New(var_59_5.x, var_59_5.y, var_59_5.z)

				local var_59_6 = var_59_0.localEulerAngles

				var_59_6.z = 0
				var_59_6.x = 0
				var_59_0.localEulerAngles = var_59_6
			end

			if arg_56_1.time_ >= var_59_1 + var_59_2 and arg_56_1.time_ < var_59_1 + var_59_2 + arg_59_0 then
				var_59_0.localPosition = Vector3.New(0, -1.1, -5.9)

				local var_59_7 = manager.ui.mainCamera.transform.position - var_59_0.position

				var_59_0.forward = Vector3.New(var_59_7.x, var_59_7.y, var_59_7.z)

				local var_59_8 = var_59_0.localEulerAngles

				var_59_8.z = 0
				var_59_8.x = 0
				var_59_0.localEulerAngles = var_59_8
			end

			local var_59_9 = 0

			if var_59_9 < arg_56_1.time_ and arg_56_1.time_ <= var_59_9 + arg_59_0 then
				arg_56_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_59_10 = arg_56_1.actors_["10025ui_story"]
			local var_59_11 = 0

			if var_59_11 < arg_56_1.time_ and arg_56_1.time_ <= var_59_11 + arg_59_0 and not isNil(var_59_10) and arg_56_1.var_.characterEffect10025ui_story == nil then
				arg_56_1.var_.characterEffect10025ui_story = var_59_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_12 = 0.2

			if var_59_11 <= arg_56_1.time_ and arg_56_1.time_ < var_59_11 + var_59_12 and not isNil(var_59_10) then
				local var_59_13 = (arg_56_1.time_ - var_59_11) / var_59_12

				if arg_56_1.var_.characterEffect10025ui_story and not isNil(var_59_10) then
					arg_56_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_56_1.time_ >= var_59_11 + var_59_12 and arg_56_1.time_ < var_59_11 + var_59_12 + arg_59_0 and not isNil(var_59_10) and arg_56_1.var_.characterEffect10025ui_story then
				arg_56_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			local var_59_14 = 0

			if var_59_14 < arg_56_1.time_ and arg_56_1.time_ <= var_59_14 + arg_59_0 then
				arg_56_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action4_2")
			end

			local var_59_15 = 0
			local var_59_16 = 0.075

			if var_59_15 < arg_56_1.time_ and arg_56_1.time_ <= var_59_15 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				local var_59_17 = arg_56_1:FormatText(StoryNameCfg[328].name)

				arg_56_1.leftNameTxt_.text = var_59_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_18 = arg_56_1:GetWordFromCfg(116361012)
				local var_59_19 = arg_56_1:FormatText(var_59_18.content)

				arg_56_1.text_.text = var_59_19

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_20 = 3
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

				if manager.audio:GetVoiceLength("story_v_out_116361", "116361012", "story_v_out_116361.awb") ~= 0 then
					local var_59_23 = manager.audio:GetVoiceLength("story_v_out_116361", "116361012", "story_v_out_116361.awb") / 1000

					if var_59_23 + var_59_15 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_23 + var_59_15
					end

					if var_59_18.prefab_name ~= "" and arg_56_1.actors_[var_59_18.prefab_name] ~= nil then
						local var_59_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_18.prefab_name].transform, "story_v_out_116361", "116361012", "story_v_out_116361.awb")

						arg_56_1:RecordAudio("116361012", var_59_24)
						arg_56_1:RecordAudio("116361012", var_59_24)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_116361", "116361012", "story_v_out_116361.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_116361", "116361012", "story_v_out_116361.awb")
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
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_56_1:InitPlayNodeList()
	end,
	Play116361013 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 116361013
		arg_60_1.duration_ = 5

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play116361014(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = arg_60_1.actors_["10025ui_story"]
			local var_63_1 = 0

			if var_63_1 < arg_60_1.time_ and arg_60_1.time_ <= var_63_1 + arg_63_0 and not isNil(var_63_0) and arg_60_1.var_.characterEffect10025ui_story == nil then
				arg_60_1.var_.characterEffect10025ui_story = var_63_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_2 = 0.2

			if var_63_1 <= arg_60_1.time_ and arg_60_1.time_ < var_63_1 + var_63_2 and not isNil(var_63_0) then
				local var_63_3 = (arg_60_1.time_ - var_63_1) / var_63_2

				if arg_60_1.var_.characterEffect10025ui_story and not isNil(var_63_0) then
					local var_63_4 = Mathf.Lerp(0, 0.5, var_63_3)

					arg_60_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_60_1.var_.characterEffect10025ui_story.fillRatio = var_63_4
				end
			end

			if arg_60_1.time_ >= var_63_1 + var_63_2 and arg_60_1.time_ < var_63_1 + var_63_2 + arg_63_0 and not isNil(var_63_0) and arg_60_1.var_.characterEffect10025ui_story then
				local var_63_5 = 0.5

				arg_60_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_60_1.var_.characterEffect10025ui_story.fillRatio = var_63_5
			end

			local var_63_6 = 0
			local var_63_7 = 0.725

			if var_63_6 < arg_60_1.time_ and arg_60_1.time_ <= var_63_6 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				local var_63_8 = arg_60_1:FormatText(StoryNameCfg[344].name)

				arg_60_1.leftNameTxt_.text = var_63_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_9 = arg_60_1:GetWordFromCfg(116361013)
				local var_63_10 = arg_60_1:FormatText(var_63_9.content)

				arg_60_1.text_.text = var_63_10

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_11 = 29
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
				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_14 = math.max(var_63_7, arg_60_1.talkMaxDuration)

			if var_63_6 <= arg_60_1.time_ and arg_60_1.time_ < var_63_6 + var_63_14 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_6) / var_63_14

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_6 + var_63_14 and arg_60_1.time_ < var_63_6 + var_63_14 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play116361014 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 116361014
		arg_64_1.duration_ = 8.33

		local var_64_0 = {
			zh = 7.633,
			ja = 8.333
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
				arg_64_0:Play116361015(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = arg_64_1.actors_["10025ui_story"].transform
			local var_67_1 = 0

			if var_67_1 < arg_64_1.time_ and arg_64_1.time_ <= var_67_1 + arg_67_0 then
				arg_64_1.var_.moveOldPos10025ui_story = var_67_0.localPosition
			end

			local var_67_2 = 0.001

			if var_67_1 <= arg_64_1.time_ and arg_64_1.time_ < var_67_1 + var_67_2 then
				local var_67_3 = (arg_64_1.time_ - var_67_1) / var_67_2
				local var_67_4 = Vector3.New(0, -1.1, -5.9)

				var_67_0.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos10025ui_story, var_67_4, var_67_3)

				local var_67_5 = manager.ui.mainCamera.transform.position - var_67_0.position

				var_67_0.forward = Vector3.New(var_67_5.x, var_67_5.y, var_67_5.z)

				local var_67_6 = var_67_0.localEulerAngles

				var_67_6.z = 0
				var_67_6.x = 0
				var_67_0.localEulerAngles = var_67_6
			end

			if arg_64_1.time_ >= var_67_1 + var_67_2 and arg_64_1.time_ < var_67_1 + var_67_2 + arg_67_0 then
				var_67_0.localPosition = Vector3.New(0, -1.1, -5.9)

				local var_67_7 = manager.ui.mainCamera.transform.position - var_67_0.position

				var_67_0.forward = Vector3.New(var_67_7.x, var_67_7.y, var_67_7.z)

				local var_67_8 = var_67_0.localEulerAngles

				var_67_8.z = 0
				var_67_8.x = 0
				var_67_0.localEulerAngles = var_67_8
			end

			local var_67_9 = 0

			if var_67_9 < arg_64_1.time_ and arg_64_1.time_ <= var_67_9 + arg_67_0 then
				arg_64_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_67_10 = arg_64_1.actors_["10025ui_story"]
			local var_67_11 = 0

			if var_67_11 < arg_64_1.time_ and arg_64_1.time_ <= var_67_11 + arg_67_0 and not isNil(var_67_10) and arg_64_1.var_.characterEffect10025ui_story == nil then
				arg_64_1.var_.characterEffect10025ui_story = var_67_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_12 = 0.2

			if var_67_11 <= arg_64_1.time_ and arg_64_1.time_ < var_67_11 + var_67_12 and not isNil(var_67_10) then
				local var_67_13 = (arg_64_1.time_ - var_67_11) / var_67_12

				if arg_64_1.var_.characterEffect10025ui_story and not isNil(var_67_10) then
					arg_64_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_64_1.time_ >= var_67_11 + var_67_12 and arg_64_1.time_ < var_67_11 + var_67_12 + arg_67_0 and not isNil(var_67_10) and arg_64_1.var_.characterEffect10025ui_story then
				arg_64_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			local var_67_14 = 0

			if var_67_14 < arg_64_1.time_ and arg_64_1.time_ <= var_67_14 + arg_67_0 then
				arg_64_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action2_1")
			end

			local var_67_15 = 0
			local var_67_16 = 0.675

			if var_67_15 < arg_64_1.time_ and arg_64_1.time_ <= var_67_15 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				local var_67_17 = arg_64_1:FormatText(StoryNameCfg[328].name)

				arg_64_1.leftNameTxt_.text = var_67_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_18 = arg_64_1:GetWordFromCfg(116361014)
				local var_67_19 = arg_64_1:FormatText(var_67_18.content)

				arg_64_1.text_.text = var_67_19

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_20 = 27
				local var_67_21 = utf8.len(var_67_19)
				local var_67_22 = var_67_20 <= 0 and var_67_16 or var_67_16 * (var_67_21 / var_67_20)

				if var_67_22 > 0 and var_67_16 < var_67_22 then
					arg_64_1.talkMaxDuration = var_67_22

					if var_67_22 + var_67_15 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_22 + var_67_15
					end
				end

				arg_64_1.text_.text = var_67_19
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116361", "116361014", "story_v_out_116361.awb") ~= 0 then
					local var_67_23 = manager.audio:GetVoiceLength("story_v_out_116361", "116361014", "story_v_out_116361.awb") / 1000

					if var_67_23 + var_67_15 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_23 + var_67_15
					end

					if var_67_18.prefab_name ~= "" and arg_64_1.actors_[var_67_18.prefab_name] ~= nil then
						local var_67_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_18.prefab_name].transform, "story_v_out_116361", "116361014", "story_v_out_116361.awb")

						arg_64_1:RecordAudio("116361014", var_67_24)
						arg_64_1:RecordAudio("116361014", var_67_24)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_116361", "116361014", "story_v_out_116361.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_116361", "116361014", "story_v_out_116361.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_25 = math.max(var_67_16, arg_64_1.talkMaxDuration)

			if var_67_15 <= arg_64_1.time_ and arg_64_1.time_ < var_67_15 + var_67_25 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_15) / var_67_25

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_15 + var_67_25 and arg_64_1.time_ < var_67_15 + var_67_25 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_64_1:InitPlayNodeList()
	end,
	Play116361015 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 116361015
		arg_68_1.duration_ = 5

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"
		end

		function arg_68_1.playNext_(arg_70_0)
			if arg_70_0 == 1 then
				arg_68_0:Play116361016(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = arg_68_1.actors_["10025ui_story"].transform
			local var_71_1 = 0

			if var_71_1 < arg_68_1.time_ and arg_68_1.time_ <= var_71_1 + arg_71_0 then
				arg_68_1.var_.moveOldPos10025ui_story = var_71_0.localPosition
			end

			local var_71_2 = 0.001

			if var_71_1 <= arg_68_1.time_ and arg_68_1.time_ < var_71_1 + var_71_2 then
				local var_71_3 = (arg_68_1.time_ - var_71_1) / var_71_2
				local var_71_4 = Vector3.New(0, 100, 0)

				var_71_0.localPosition = Vector3.Lerp(arg_68_1.var_.moveOldPos10025ui_story, var_71_4, var_71_3)

				local var_71_5 = manager.ui.mainCamera.transform.position - var_71_0.position

				var_71_0.forward = Vector3.New(var_71_5.x, var_71_5.y, var_71_5.z)

				local var_71_6 = var_71_0.localEulerAngles

				var_71_6.z = 0
				var_71_6.x = 0
				var_71_0.localEulerAngles = var_71_6
			end

			if arg_68_1.time_ >= var_71_1 + var_71_2 and arg_68_1.time_ < var_71_1 + var_71_2 + arg_71_0 then
				var_71_0.localPosition = Vector3.New(0, 100, 0)

				local var_71_7 = manager.ui.mainCamera.transform.position - var_71_0.position

				var_71_0.forward = Vector3.New(var_71_7.x, var_71_7.y, var_71_7.z)

				local var_71_8 = var_71_0.localEulerAngles

				var_71_8.z = 0
				var_71_8.x = 0
				var_71_0.localEulerAngles = var_71_8
			end

			local var_71_9 = 0
			local var_71_10 = 0.225

			if var_71_9 < arg_68_1.time_ and arg_68_1.time_ <= var_71_9 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				local var_71_11 = arg_68_1:FormatText(StoryNameCfg[344].name)

				arg_68_1.leftNameTxt_.text = var_71_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_12 = arg_68_1:GetWordFromCfg(116361015)
				local var_71_13 = arg_68_1:FormatText(var_71_12.content)

				arg_68_1.text_.text = var_71_13

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_14 = 9
				local var_71_15 = utf8.len(var_71_13)
				local var_71_16 = var_71_14 <= 0 and var_71_10 or var_71_10 * (var_71_15 / var_71_14)

				if var_71_16 > 0 and var_71_10 < var_71_16 then
					arg_68_1.talkMaxDuration = var_71_16

					if var_71_16 + var_71_9 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_16 + var_71_9
					end
				end

				arg_68_1.text_.text = var_71_13
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)
				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_17 = math.max(var_71_10, arg_68_1.talkMaxDuration)

			if var_71_9 <= arg_68_1.time_ and arg_68_1.time_ < var_71_9 + var_71_17 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_9) / var_71_17

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_9 + var_71_17 and arg_68_1.time_ < var_71_9 + var_71_17 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_68_1:InitPlayNodeList()
	end,
	Play116361016 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 116361016
		arg_72_1.duration_ = 5

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play116361017(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = 0
			local var_75_1 = 0.9

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

				local var_75_2 = arg_72_1:GetWordFromCfg(116361016)
				local var_75_3 = arg_72_1:FormatText(var_75_2.content)

				arg_72_1.text_.text = var_75_3

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_4 = 36
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
	Play116361017 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 116361017
		arg_76_1.duration_ = 5

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play116361018(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = 0
			local var_79_1 = 0.975

			if var_79_0 < arg_76_1.time_ and arg_76_1.time_ <= var_79_0 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				local var_79_2 = arg_76_1:FormatText(StoryNameCfg[344].name)

				arg_76_1.leftNameTxt_.text = var_79_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_3 = arg_76_1:GetWordFromCfg(116361017)
				local var_79_4 = arg_76_1:FormatText(var_79_3.content)

				arg_76_1.text_.text = var_79_4

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_5 = 39
				local var_79_6 = utf8.len(var_79_4)
				local var_79_7 = var_79_5 <= 0 and var_79_1 or var_79_1 * (var_79_6 / var_79_5)

				if var_79_7 > 0 and var_79_1 < var_79_7 then
					arg_76_1.talkMaxDuration = var_79_7

					if var_79_7 + var_79_0 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_7 + var_79_0
					end
				end

				arg_76_1.text_.text = var_79_4
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)
				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_8 = math.max(var_79_1, arg_76_1.talkMaxDuration)

			if var_79_0 <= arg_76_1.time_ and arg_76_1.time_ < var_79_0 + var_79_8 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_0) / var_79_8

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_0 + var_79_8 and arg_76_1.time_ < var_79_0 + var_79_8 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {}

		arg_76_1:InitPlayNodeList()
	end,
	Play116361018 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 116361018
		arg_80_1.duration_ = 5

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play116361019(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = 0
			local var_83_1 = 0.625

			if var_83_0 < arg_80_1.time_ and arg_80_1.time_ <= var_83_0 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				local var_83_2 = arg_80_1:FormatText(StoryNameCfg[344].name)

				arg_80_1.leftNameTxt_.text = var_83_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_3 = arg_80_1:GetWordFromCfg(116361018)
				local var_83_4 = arg_80_1:FormatText(var_83_3.content)

				arg_80_1.text_.text = var_83_4

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_5 = 25
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
				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_8 = math.max(var_83_1, arg_80_1.talkMaxDuration)

			if var_83_0 <= arg_80_1.time_ and arg_80_1.time_ < var_83_0 + var_83_8 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_0) / var_83_8

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_0 + var_83_8 and arg_80_1.time_ < var_83_0 + var_83_8 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {}

		arg_80_1:InitPlayNodeList()
	end,
	Play116361019 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 116361019
		arg_84_1.duration_ = 5

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play116361020(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = 0
			local var_87_1 = 0.725

			if var_87_0 < arg_84_1.time_ and arg_84_1.time_ <= var_87_0 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				local var_87_2 = arg_84_1:FormatText(StoryNameCfg[344].name)

				arg_84_1.leftNameTxt_.text = var_87_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_3 = arg_84_1:GetWordFromCfg(116361019)
				local var_87_4 = arg_84_1:FormatText(var_87_3.content)

				arg_84_1.text_.text = var_87_4

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_5 = 29
				local var_87_6 = utf8.len(var_87_4)
				local var_87_7 = var_87_5 <= 0 and var_87_1 or var_87_1 * (var_87_6 / var_87_5)

				if var_87_7 > 0 and var_87_1 < var_87_7 then
					arg_84_1.talkMaxDuration = var_87_7

					if var_87_7 + var_87_0 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_7 + var_87_0
					end
				end

				arg_84_1.text_.text = var_87_4
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)
				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_8 = math.max(var_87_1, arg_84_1.talkMaxDuration)

			if var_87_0 <= arg_84_1.time_ and arg_84_1.time_ < var_87_0 + var_87_8 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_0) / var_87_8

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_0 + var_87_8 and arg_84_1.time_ < var_87_0 + var_87_8 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {}

		arg_84_1:InitPlayNodeList()
	end,
	Play116361020 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 116361020
		arg_88_1.duration_ = 5

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play116361021(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = 0
			local var_91_1 = 0.575

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

				local var_91_2 = arg_88_1:GetWordFromCfg(116361020)
				local var_91_3 = arg_88_1:FormatText(var_91_2.content)

				arg_88_1.text_.text = var_91_3

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_4 = 23
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
	Play116361021 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 116361021
		arg_92_1.duration_ = 7

		SetActive(arg_92_1.tipsGo_, false)

		function arg_92_1.onSingleLineFinish_()
			arg_92_1.onSingleLineUpdate_ = nil
			arg_92_1.onSingleLineFinish_ = nil
			arg_92_1.state_ = "waiting"
		end

		function arg_92_1.playNext_(arg_94_0)
			if arg_94_0 == 1 then
				arg_92_0:Play116361022(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			local var_95_0 = 0

			if var_95_0 < arg_92_1.time_ and arg_92_1.time_ <= var_95_0 + arg_95_0 then
				arg_92_1.mask_.enabled = true
				arg_92_1.mask_.raycastTarget = true

				arg_92_1:SetGaussion(false)
			end

			local var_95_1 = 2

			if var_95_0 <= arg_92_1.time_ and arg_92_1.time_ < var_95_0 + var_95_1 then
				local var_95_2 = (arg_92_1.time_ - var_95_0) / var_95_1
				local var_95_3 = Color.New(1, 1, 1)

				var_95_3.a = Mathf.Lerp(1, 0, var_95_2)
				arg_92_1.mask_.color = var_95_3
			end

			if arg_92_1.time_ >= var_95_0 + var_95_1 and arg_92_1.time_ < var_95_0 + var_95_1 + arg_95_0 then
				local var_95_4 = Color.New(1, 1, 1)
				local var_95_5 = 0

				arg_92_1.mask_.enabled = false
				var_95_4.a = var_95_5
				arg_92_1.mask_.color = var_95_4
			end

			local var_95_6 = 0
			local var_95_7 = 1

			if var_95_6 < arg_92_1.time_ and arg_92_1.time_ <= var_95_6 + arg_95_0 then
				local var_95_8 = "play"
				local var_95_9 = "effect"

				arg_92_1:AudioAction(var_95_8, var_95_9, "se_story_16", "se_story_16_camera", "")
			end

			if arg_92_1.frameCnt_ <= 1 then
				arg_92_1.dialog_:SetActive(false)
			end

			local var_95_10 = 2
			local var_95_11 = 0.1

			if var_95_10 < arg_92_1.time_ and arg_92_1.time_ <= var_95_10 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0

				arg_92_1.dialog_:SetActive(true)

				arg_92_1.dialogCg_.alpha = 0

				local var_95_12 = LeanTween.value(arg_92_1.dialog_, 0, 1, 0.3)

				var_95_12:setOnUpdate(LuaHelper.FloatAction(function(arg_96_0)
					arg_92_1.dialogCg_.alpha = arg_96_0
				end))
				var_95_12:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_92_1.dialog_)
					var_95_12:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_92_1.duration_ = arg_92_1.duration_ + 0.3

				SetActive(arg_92_1.leftNameGo_, false)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_13 = arg_92_1:GetWordFromCfg(116361021)
				local var_95_14 = arg_92_1:FormatText(var_95_13.content)

				arg_92_1.text_.text = var_95_14

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_15 = 4
				local var_95_16 = utf8.len(var_95_14)
				local var_95_17 = var_95_15 <= 0 and var_95_11 or var_95_11 * (var_95_16 / var_95_15)

				if var_95_17 > 0 and var_95_11 < var_95_17 then
					arg_92_1.talkMaxDuration = var_95_17
					var_95_10 = var_95_10 + 0.3

					if var_95_17 + var_95_10 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_17 + var_95_10
					end
				end

				arg_92_1.text_.text = var_95_14
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)
				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_18 = var_95_10 + 0.3
			local var_95_19 = math.max(var_95_11, arg_92_1.talkMaxDuration)

			if var_95_18 <= arg_92_1.time_ and arg_92_1.time_ < var_95_18 + var_95_19 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_18) / var_95_19

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_18 + var_95_19 and arg_92_1.time_ < var_95_18 + var_95_19 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {}

		arg_92_1:InitPlayNodeList()
	end,
	Play116361022 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 116361022
		arg_98_1.duration_ = 5

		SetActive(arg_98_1.tipsGo_, false)

		function arg_98_1.onSingleLineFinish_()
			arg_98_1.onSingleLineUpdate_ = nil
			arg_98_1.onSingleLineFinish_ = nil
			arg_98_1.state_ = "waiting"
		end

		function arg_98_1.playNext_(arg_100_0)
			if arg_100_0 == 1 then
				arg_98_0:Play116361023(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			local var_101_0 = 0
			local var_101_1 = 0.15

			if var_101_0 < arg_98_1.time_ and arg_98_1.time_ <= var_101_0 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				local var_101_2 = arg_98_1:FormatText(StoryNameCfg[344].name)

				arg_98_1.leftNameTxt_.text = var_101_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_3 = arg_98_1:GetWordFromCfg(116361022)
				local var_101_4 = arg_98_1:FormatText(var_101_3.content)

				arg_98_1.text_.text = var_101_4

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_5 = 6
				local var_101_6 = utf8.len(var_101_4)
				local var_101_7 = var_101_5 <= 0 and var_101_1 or var_101_1 * (var_101_6 / var_101_5)

				if var_101_7 > 0 and var_101_1 < var_101_7 then
					arg_98_1.talkMaxDuration = var_101_7

					if var_101_7 + var_101_0 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_7 + var_101_0
					end
				end

				arg_98_1.text_.text = var_101_4
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)
				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_8 = math.max(var_101_1, arg_98_1.talkMaxDuration)

			if var_101_0 <= arg_98_1.time_ and arg_98_1.time_ < var_101_0 + var_101_8 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_0) / var_101_8

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_0 + var_101_8 and arg_98_1.time_ < var_101_0 + var_101_8 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {}

		arg_98_1:InitPlayNodeList()
	end,
	Play116361023 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 116361023
		arg_102_1.duration_ = 5.57

		local var_102_0 = {
			zh = 5.566,
			ja = 4.133
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
				arg_102_0:Play116361024(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			local var_105_0 = arg_102_1.actors_["10025ui_story"].transform
			local var_105_1 = 0

			if var_105_1 < arg_102_1.time_ and arg_102_1.time_ <= var_105_1 + arg_105_0 then
				arg_102_1.var_.moveOldPos10025ui_story = var_105_0.localPosition
			end

			local var_105_2 = 0.001

			if var_105_1 <= arg_102_1.time_ and arg_102_1.time_ < var_105_1 + var_105_2 then
				local var_105_3 = (arg_102_1.time_ - var_105_1) / var_105_2
				local var_105_4 = Vector3.New(0, -1.1, -5.9)

				var_105_0.localPosition = Vector3.Lerp(arg_102_1.var_.moveOldPos10025ui_story, var_105_4, var_105_3)

				local var_105_5 = manager.ui.mainCamera.transform.position - var_105_0.position

				var_105_0.forward = Vector3.New(var_105_5.x, var_105_5.y, var_105_5.z)

				local var_105_6 = var_105_0.localEulerAngles

				var_105_6.z = 0
				var_105_6.x = 0
				var_105_0.localEulerAngles = var_105_6
			end

			if arg_102_1.time_ >= var_105_1 + var_105_2 and arg_102_1.time_ < var_105_1 + var_105_2 + arg_105_0 then
				var_105_0.localPosition = Vector3.New(0, -1.1, -5.9)

				local var_105_7 = manager.ui.mainCamera.transform.position - var_105_0.position

				var_105_0.forward = Vector3.New(var_105_7.x, var_105_7.y, var_105_7.z)

				local var_105_8 = var_105_0.localEulerAngles

				var_105_8.z = 0
				var_105_8.x = 0
				var_105_0.localEulerAngles = var_105_8
			end

			local var_105_9 = 0

			if var_105_9 < arg_102_1.time_ and arg_102_1.time_ <= var_105_9 + arg_105_0 then
				arg_102_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_105_10 = arg_102_1.actors_["10025ui_story"]
			local var_105_11 = 0

			if var_105_11 < arg_102_1.time_ and arg_102_1.time_ <= var_105_11 + arg_105_0 and not isNil(var_105_10) and arg_102_1.var_.characterEffect10025ui_story == nil then
				arg_102_1.var_.characterEffect10025ui_story = var_105_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_105_12 = 0.2

			if var_105_11 <= arg_102_1.time_ and arg_102_1.time_ < var_105_11 + var_105_12 and not isNil(var_105_10) then
				local var_105_13 = (arg_102_1.time_ - var_105_11) / var_105_12

				if arg_102_1.var_.characterEffect10025ui_story and not isNil(var_105_10) then
					arg_102_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_102_1.time_ >= var_105_11 + var_105_12 and arg_102_1.time_ < var_105_11 + var_105_12 + arg_105_0 and not isNil(var_105_10) and arg_102_1.var_.characterEffect10025ui_story then
				arg_102_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			local var_105_14 = 0

			if var_105_14 < arg_102_1.time_ and arg_102_1.time_ <= var_105_14 + arg_105_0 then
				arg_102_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action5_1")
			end

			local var_105_15 = 0
			local var_105_16 = 0.55

			if var_105_15 < arg_102_1.time_ and arg_102_1.time_ <= var_105_15 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				local var_105_17 = arg_102_1:FormatText(StoryNameCfg[328].name)

				arg_102_1.leftNameTxt_.text = var_105_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_18 = arg_102_1:GetWordFromCfg(116361023)
				local var_105_19 = arg_102_1:FormatText(var_105_18.content)

				arg_102_1.text_.text = var_105_19

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_20 = 22
				local var_105_21 = utf8.len(var_105_19)
				local var_105_22 = var_105_20 <= 0 and var_105_16 or var_105_16 * (var_105_21 / var_105_20)

				if var_105_22 > 0 and var_105_16 < var_105_22 then
					arg_102_1.talkMaxDuration = var_105_22

					if var_105_22 + var_105_15 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_22 + var_105_15
					end
				end

				arg_102_1.text_.text = var_105_19
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116361", "116361023", "story_v_out_116361.awb") ~= 0 then
					local var_105_23 = manager.audio:GetVoiceLength("story_v_out_116361", "116361023", "story_v_out_116361.awb") / 1000

					if var_105_23 + var_105_15 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_23 + var_105_15
					end

					if var_105_18.prefab_name ~= "" and arg_102_1.actors_[var_105_18.prefab_name] ~= nil then
						local var_105_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_102_1.actors_[var_105_18.prefab_name].transform, "story_v_out_116361", "116361023", "story_v_out_116361.awb")

						arg_102_1:RecordAudio("116361023", var_105_24)
						arg_102_1:RecordAudio("116361023", var_105_24)
					else
						arg_102_1:AudioAction("play", "voice", "story_v_out_116361", "116361023", "story_v_out_116361.awb")
					end

					arg_102_1:RecordHistoryTalkVoice("story_v_out_116361", "116361023", "story_v_out_116361.awb")
				end

				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_25 = math.max(var_105_16, arg_102_1.talkMaxDuration)

			if var_105_15 <= arg_102_1.time_ and arg_102_1.time_ < var_105_15 + var_105_25 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_15) / var_105_25

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_15 + var_105_25 and arg_102_1.time_ < var_105_15 + var_105_25 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_102_1:InitPlayNodeList()
	end,
	Play116361024 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 116361024
		arg_106_1.duration_ = 5

		SetActive(arg_106_1.tipsGo_, false)

		function arg_106_1.onSingleLineFinish_()
			arg_106_1.onSingleLineUpdate_ = nil
			arg_106_1.onSingleLineFinish_ = nil
			arg_106_1.state_ = "waiting"
		end

		function arg_106_1.playNext_(arg_108_0)
			if arg_108_0 == 1 then
				arg_106_0:Play116361025(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			local var_109_0 = arg_106_1.actors_["10025ui_story"]
			local var_109_1 = 0

			if var_109_1 < arg_106_1.time_ and arg_106_1.time_ <= var_109_1 + arg_109_0 and not isNil(var_109_0) and arg_106_1.var_.characterEffect10025ui_story == nil then
				arg_106_1.var_.characterEffect10025ui_story = var_109_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_109_2 = 0.2

			if var_109_1 <= arg_106_1.time_ and arg_106_1.time_ < var_109_1 + var_109_2 and not isNil(var_109_0) then
				local var_109_3 = (arg_106_1.time_ - var_109_1) / var_109_2

				if arg_106_1.var_.characterEffect10025ui_story and not isNil(var_109_0) then
					local var_109_4 = Mathf.Lerp(0, 0.5, var_109_3)

					arg_106_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_106_1.var_.characterEffect10025ui_story.fillRatio = var_109_4
				end
			end

			if arg_106_1.time_ >= var_109_1 + var_109_2 and arg_106_1.time_ < var_109_1 + var_109_2 + arg_109_0 and not isNil(var_109_0) and arg_106_1.var_.characterEffect10025ui_story then
				local var_109_5 = 0.5

				arg_106_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_106_1.var_.characterEffect10025ui_story.fillRatio = var_109_5
			end

			local var_109_6 = 0
			local var_109_7 = 0.375

			if var_109_6 < arg_106_1.time_ and arg_106_1.time_ <= var_109_6 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				local var_109_8 = arg_106_1:FormatText(StoryNameCfg[344].name)

				arg_106_1.leftNameTxt_.text = var_109_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_9 = arg_106_1:GetWordFromCfg(116361024)
				local var_109_10 = arg_106_1:FormatText(var_109_9.content)

				arg_106_1.text_.text = var_109_10

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_11 = 15
				local var_109_12 = utf8.len(var_109_10)
				local var_109_13 = var_109_11 <= 0 and var_109_7 or var_109_7 * (var_109_12 / var_109_11)

				if var_109_13 > 0 and var_109_7 < var_109_13 then
					arg_106_1.talkMaxDuration = var_109_13

					if var_109_13 + var_109_6 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_13 + var_109_6
					end
				end

				arg_106_1.text_.text = var_109_10
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)
				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_14 = math.max(var_109_7, arg_106_1.talkMaxDuration)

			if var_109_6 <= arg_106_1.time_ and arg_106_1.time_ < var_109_6 + var_109_14 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_6) / var_109_14

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_6 + var_109_14 and arg_106_1.time_ < var_109_6 + var_109_14 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {}

		arg_106_1:InitPlayNodeList()
	end,
	Play116361025 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 116361025
		arg_110_1.duration_ = 5

		local var_110_0 = {
			zh = 2.2,
			ja = 5
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
				arg_110_0:Play116361026(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			local var_113_0 = arg_110_1.actors_["10025ui_story"].transform
			local var_113_1 = 0

			if var_113_1 < arg_110_1.time_ and arg_110_1.time_ <= var_113_1 + arg_113_0 then
				arg_110_1.var_.moveOldPos10025ui_story = var_113_0.localPosition
			end

			local var_113_2 = 0.001

			if var_113_1 <= arg_110_1.time_ and arg_110_1.time_ < var_113_1 + var_113_2 then
				local var_113_3 = (arg_110_1.time_ - var_113_1) / var_113_2
				local var_113_4 = Vector3.New(0, -1.1, -5.9)

				var_113_0.localPosition = Vector3.Lerp(arg_110_1.var_.moveOldPos10025ui_story, var_113_4, var_113_3)

				local var_113_5 = manager.ui.mainCamera.transform.position - var_113_0.position

				var_113_0.forward = Vector3.New(var_113_5.x, var_113_5.y, var_113_5.z)

				local var_113_6 = var_113_0.localEulerAngles

				var_113_6.z = 0
				var_113_6.x = 0
				var_113_0.localEulerAngles = var_113_6
			end

			if arg_110_1.time_ >= var_113_1 + var_113_2 and arg_110_1.time_ < var_113_1 + var_113_2 + arg_113_0 then
				var_113_0.localPosition = Vector3.New(0, -1.1, -5.9)

				local var_113_7 = manager.ui.mainCamera.transform.position - var_113_0.position

				var_113_0.forward = Vector3.New(var_113_7.x, var_113_7.y, var_113_7.z)

				local var_113_8 = var_113_0.localEulerAngles

				var_113_8.z = 0
				var_113_8.x = 0
				var_113_0.localEulerAngles = var_113_8
			end

			local var_113_9 = 0

			if var_113_9 < arg_110_1.time_ and arg_110_1.time_ <= var_113_9 + arg_113_0 then
				arg_110_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_113_10 = arg_110_1.actors_["10025ui_story"]
			local var_113_11 = 0

			if var_113_11 < arg_110_1.time_ and arg_110_1.time_ <= var_113_11 + arg_113_0 and not isNil(var_113_10) and arg_110_1.var_.characterEffect10025ui_story == nil then
				arg_110_1.var_.characterEffect10025ui_story = var_113_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_113_12 = 0.2

			if var_113_11 <= arg_110_1.time_ and arg_110_1.time_ < var_113_11 + var_113_12 and not isNil(var_113_10) then
				local var_113_13 = (arg_110_1.time_ - var_113_11) / var_113_12

				if arg_110_1.var_.characterEffect10025ui_story and not isNil(var_113_10) then
					arg_110_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_110_1.time_ >= var_113_11 + var_113_12 and arg_110_1.time_ < var_113_11 + var_113_12 + arg_113_0 and not isNil(var_113_10) and arg_110_1.var_.characterEffect10025ui_story then
				arg_110_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			local var_113_14 = 0
			local var_113_15 = 0.225

			if var_113_14 < arg_110_1.time_ and arg_110_1.time_ <= var_113_14 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				local var_113_16 = arg_110_1:FormatText(StoryNameCfg[328].name)

				arg_110_1.leftNameTxt_.text = var_113_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, false)
				arg_110_1.callingController_:SetSelectedState("normal")

				local var_113_17 = arg_110_1:GetWordFromCfg(116361025)
				local var_113_18 = arg_110_1:FormatText(var_113_17.content)

				arg_110_1.text_.text = var_113_18

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_19 = 9
				local var_113_20 = utf8.len(var_113_18)
				local var_113_21 = var_113_19 <= 0 and var_113_15 or var_113_15 * (var_113_20 / var_113_19)

				if var_113_21 > 0 and var_113_15 < var_113_21 then
					arg_110_1.talkMaxDuration = var_113_21

					if var_113_21 + var_113_14 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_21 + var_113_14
					end
				end

				arg_110_1.text_.text = var_113_18
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116361", "116361025", "story_v_out_116361.awb") ~= 0 then
					local var_113_22 = manager.audio:GetVoiceLength("story_v_out_116361", "116361025", "story_v_out_116361.awb") / 1000

					if var_113_22 + var_113_14 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_22 + var_113_14
					end

					if var_113_17.prefab_name ~= "" and arg_110_1.actors_[var_113_17.prefab_name] ~= nil then
						local var_113_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_110_1.actors_[var_113_17.prefab_name].transform, "story_v_out_116361", "116361025", "story_v_out_116361.awb")

						arg_110_1:RecordAudio("116361025", var_113_23)
						arg_110_1:RecordAudio("116361025", var_113_23)
					else
						arg_110_1:AudioAction("play", "voice", "story_v_out_116361", "116361025", "story_v_out_116361.awb")
					end

					arg_110_1:RecordHistoryTalkVoice("story_v_out_116361", "116361025", "story_v_out_116361.awb")
				end

				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_24 = math.max(var_113_15, arg_110_1.talkMaxDuration)

			if var_113_14 <= arg_110_1.time_ and arg_110_1.time_ < var_113_14 + var_113_24 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_14) / var_113_24

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_14 + var_113_24 and arg_110_1.time_ < var_113_14 + var_113_24 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_110_1:InitPlayNodeList()
	end,
	Play116361026 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 116361026
		arg_114_1.duration_ = 7

		SetActive(arg_114_1.tipsGo_, false)

		function arg_114_1.onSingleLineFinish_()
			arg_114_1.onSingleLineUpdate_ = nil
			arg_114_1.onSingleLineFinish_ = nil
			arg_114_1.state_ = "waiting"
		end

		function arg_114_1.playNext_(arg_116_0)
			if arg_116_0 == 1 then
				arg_114_0:Play116361027(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			local var_117_0 = "STblack"

			if arg_114_1.bgs_[var_117_0] == nil then
				local var_117_1 = Object.Instantiate(arg_114_1.paintGo_)

				var_117_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_117_0)
				var_117_1.name = var_117_0
				var_117_1.transform.parent = arg_114_1.stage_.transform
				var_117_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_114_1.bgs_[var_117_0] = var_117_1
			end

			local var_117_2 = 0

			if var_117_2 < arg_114_1.time_ and arg_114_1.time_ <= var_117_2 + arg_117_0 then
				local var_117_3 = manager.ui.mainCamera.transform.localPosition
				local var_117_4 = Vector3.New(0, 0, 10) + Vector3.New(var_117_3.x, var_117_3.y, 0)
				local var_117_5 = arg_114_1.bgs_.STblack

				var_117_5.transform.localPosition = var_117_4
				var_117_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_117_6 = var_117_5:GetComponent("SpriteRenderer")

				if var_117_6 and var_117_6.sprite then
					local var_117_7 = (var_117_5.transform.localPosition - var_117_3).z
					local var_117_8 = manager.ui.mainCameraCom_
					local var_117_9 = 2 * var_117_7 * Mathf.Tan(var_117_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_117_10 = var_117_9 * var_117_8.aspect
					local var_117_11 = var_117_6.sprite.bounds.size.x
					local var_117_12 = var_117_6.sprite.bounds.size.y
					local var_117_13 = var_117_10 / var_117_11
					local var_117_14 = var_117_9 / var_117_12
					local var_117_15 = var_117_14 < var_117_13 and var_117_13 or var_117_14

					var_117_5.transform.localScale = Vector3.New(var_117_15, var_117_15, 0)
				end

				for iter_117_0, iter_117_1 in pairs(arg_114_1.bgs_) do
					if iter_117_0 ~= "STblack" then
						iter_117_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_117_16 = 0

			if var_117_16 < arg_114_1.time_ and arg_114_1.time_ <= var_117_16 + arg_117_0 then
				arg_114_1.mask_.enabled = true
				arg_114_1.mask_.raycastTarget = true

				arg_114_1:SetGaussion(false)
			end

			local var_117_17 = 2

			if var_117_16 <= arg_114_1.time_ and arg_114_1.time_ < var_117_16 + var_117_17 then
				local var_117_18 = (arg_114_1.time_ - var_117_16) / var_117_17
				local var_117_19 = Color.New(0, 0, 0)

				var_117_19.a = Mathf.Lerp(1, 0, var_117_18)
				arg_114_1.mask_.color = var_117_19
			end

			if arg_114_1.time_ >= var_117_16 + var_117_17 and arg_114_1.time_ < var_117_16 + var_117_17 + arg_117_0 then
				local var_117_20 = Color.New(0, 0, 0)
				local var_117_21 = 0

				arg_114_1.mask_.enabled = false
				var_117_20.a = var_117_21
				arg_114_1.mask_.color = var_117_20
			end

			local var_117_22 = arg_114_1.actors_["10025ui_story"].transform
			local var_117_23 = 0

			if var_117_23 < arg_114_1.time_ and arg_114_1.time_ <= var_117_23 + arg_117_0 then
				arg_114_1.var_.moveOldPos10025ui_story = var_117_22.localPosition
			end

			local var_117_24 = 0.001

			if var_117_23 <= arg_114_1.time_ and arg_114_1.time_ < var_117_23 + var_117_24 then
				local var_117_25 = (arg_114_1.time_ - var_117_23) / var_117_24
				local var_117_26 = Vector3.New(0, 100, 0)

				var_117_22.localPosition = Vector3.Lerp(arg_114_1.var_.moveOldPos10025ui_story, var_117_26, var_117_25)

				local var_117_27 = manager.ui.mainCamera.transform.position - var_117_22.position

				var_117_22.forward = Vector3.New(var_117_27.x, var_117_27.y, var_117_27.z)

				local var_117_28 = var_117_22.localEulerAngles

				var_117_28.z = 0
				var_117_28.x = 0
				var_117_22.localEulerAngles = var_117_28
			end

			if arg_114_1.time_ >= var_117_23 + var_117_24 and arg_114_1.time_ < var_117_23 + var_117_24 + arg_117_0 then
				var_117_22.localPosition = Vector3.New(0, 100, 0)

				local var_117_29 = manager.ui.mainCamera.transform.position - var_117_22.position

				var_117_22.forward = Vector3.New(var_117_29.x, var_117_29.y, var_117_29.z)

				local var_117_30 = var_117_22.localEulerAngles

				var_117_30.z = 0
				var_117_30.x = 0
				var_117_22.localEulerAngles = var_117_30
			end

			local var_117_31 = 0
			local var_117_32 = 0.034

			if var_117_31 < arg_114_1.time_ and arg_114_1.time_ <= var_117_31 + arg_117_0 then
				local var_117_33 = "play"
				local var_117_34 = "music"

				arg_114_1:AudioAction(var_117_33, var_117_34, "ui_battle", "ui_battle_stopbgm", "")

				local var_117_35 = ""
				local var_117_36 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_117_36 ~= "" then
					if arg_114_1.bgmTxt_.text ~= var_117_36 and arg_114_1.bgmTxt_.text ~= "" then
						if arg_114_1.bgmTxt2_.text ~= "" then
							arg_114_1.bgmTxt_.text = arg_114_1.bgmTxt2_.text
						end

						arg_114_1.bgmTxt2_.text = var_117_36

						arg_114_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_114_1.bgmTxt_.text = var_117_36
						arg_114_1.bgmTxt2_.text = var_117_36
					end

					if arg_114_1.bgmTimer then
						arg_114_1.bgmTimer:Stop()

						arg_114_1.bgmTimer = nil
					end

					if arg_114_1.settingData.show_music_name == 1 then
						arg_114_1.musicController:SetSelectedState("show")
						arg_114_1.musicAnimator_:Play("open", 0, 0)

						if arg_114_1.settingData.music_time ~= 0 then
							arg_114_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_114_1.settingData.music_time), function()
								if arg_114_1 == nil or isNil(arg_114_1.bgmTxt_) then
									return
								end

								arg_114_1.musicController:SetSelectedState("hide")
								arg_114_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_117_37 = 0.034
			local var_117_38 = 1

			if var_117_37 < arg_114_1.time_ and arg_114_1.time_ <= var_117_37 + arg_117_0 then
				local var_117_39 = "play"
				local var_117_40 = "music"

				arg_114_1:AudioAction(var_117_39, var_117_40, "bgm_story_scheme", "bgm_story_scheme", "bgm_story_scheme.awb")

				local var_117_41 = ""
				local var_117_42 = manager.audio:GetAudioName("bgm_story_scheme", "bgm_story_scheme")

				if var_117_42 ~= "" then
					if arg_114_1.bgmTxt_.text ~= var_117_42 and arg_114_1.bgmTxt_.text ~= "" then
						if arg_114_1.bgmTxt2_.text ~= "" then
							arg_114_1.bgmTxt_.text = arg_114_1.bgmTxt2_.text
						end

						arg_114_1.bgmTxt2_.text = var_117_42

						arg_114_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_114_1.bgmTxt_.text = var_117_42
						arg_114_1.bgmTxt2_.text = var_117_42
					end

					if arg_114_1.bgmTimer then
						arg_114_1.bgmTimer:Stop()

						arg_114_1.bgmTimer = nil
					end

					if arg_114_1.settingData.show_music_name == 1 then
						arg_114_1.musicController:SetSelectedState("show")
						arg_114_1.musicAnimator_:Play("open", 0, 0)

						if arg_114_1.settingData.music_time ~= 0 then
							arg_114_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_114_1.settingData.music_time), function()
								if arg_114_1 == nil or isNil(arg_114_1.bgmTxt_) then
									return
								end

								arg_114_1.musicController:SetSelectedState("hide")
								arg_114_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_114_1.frameCnt_ <= 1 then
				arg_114_1.dialog_:SetActive(false)
			end

			local var_117_43 = 2
			local var_117_44 = 0.175

			if var_117_43 < arg_114_1.time_ and arg_114_1.time_ <= var_117_43 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0

				arg_114_1.dialog_:SetActive(true)

				arg_114_1.dialogCg_.alpha = 0

				local var_117_45 = LeanTween.value(arg_114_1.dialog_, 0, 1, 0.3)

				var_117_45:setOnUpdate(LuaHelper.FloatAction(function(arg_120_0)
					arg_114_1.dialogCg_.alpha = arg_120_0
				end))
				var_117_45:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_114_1.dialog_)
					var_117_45:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_114_1.duration_ = arg_114_1.duration_ + 0.3

				SetActive(arg_114_1.leftNameGo_, false)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_114_1.iconTrs_.gameObject, false)
				arg_114_1.callingController_:SetSelectedState("normal")

				local var_117_46 = arg_114_1:GetWordFromCfg(116361026)
				local var_117_47 = arg_114_1:FormatText(var_117_46.content)

				arg_114_1.text_.text = var_117_47

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_48 = 7
				local var_117_49 = utf8.len(var_117_47)
				local var_117_50 = var_117_48 <= 0 and var_117_44 or var_117_44 * (var_117_49 / var_117_48)

				if var_117_50 > 0 and var_117_44 < var_117_50 then
					arg_114_1.talkMaxDuration = var_117_50
					var_117_43 = var_117_43 + 0.3

					if var_117_50 + var_117_43 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_50 + var_117_43
					end
				end

				arg_114_1.text_.text = var_117_47
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)
				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_51 = var_117_43 + 0.3
			local var_117_52 = math.max(var_117_44, arg_114_1.talkMaxDuration)

			if var_117_51 <= arg_114_1.time_ and arg_114_1.time_ < var_117_51 + var_117_52 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - var_117_51) / var_117_52

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= var_117_51 + var_117_52 and arg_114_1.time_ < var_117_51 + var_117_52 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_114_1:InitPlayNodeList()
	end,
	Play116361027 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 116361027
		arg_122_1.duration_ = 7

		SetActive(arg_122_1.tipsGo_, false)

		function arg_122_1.onSingleLineFinish_()
			arg_122_1.onSingleLineUpdate_ = nil
			arg_122_1.onSingleLineFinish_ = nil
			arg_122_1.state_ = "waiting"
		end

		function arg_122_1.playNext_(arg_124_0)
			if arg_124_0 == 1 then
				arg_122_0:Play116361028(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			local var_125_0 = 0

			if var_125_0 < arg_122_1.time_ and arg_122_1.time_ <= var_125_0 + arg_125_0 then
				local var_125_1 = manager.ui.mainCamera.transform.localPosition
				local var_125_2 = Vector3.New(0, 0, 10) + Vector3.New(var_125_1.x, var_125_1.y, 0)
				local var_125_3 = arg_122_1.bgs_.I07a

				var_125_3.transform.localPosition = var_125_2
				var_125_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_125_4 = var_125_3:GetComponent("SpriteRenderer")

				if var_125_4 and var_125_4.sprite then
					local var_125_5 = (var_125_3.transform.localPosition - var_125_1).z
					local var_125_6 = manager.ui.mainCameraCom_
					local var_125_7 = 2 * var_125_5 * Mathf.Tan(var_125_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_125_8 = var_125_7 * var_125_6.aspect
					local var_125_9 = var_125_4.sprite.bounds.size.x
					local var_125_10 = var_125_4.sprite.bounds.size.y
					local var_125_11 = var_125_8 / var_125_9
					local var_125_12 = var_125_7 / var_125_10
					local var_125_13 = var_125_12 < var_125_11 and var_125_11 or var_125_12

					var_125_3.transform.localScale = Vector3.New(var_125_13, var_125_13, 0)
				end

				for iter_125_0, iter_125_1 in pairs(arg_122_1.bgs_) do
					if iter_125_0 ~= "I07a" then
						iter_125_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_125_14 = 0

			if var_125_14 < arg_122_1.time_ and arg_122_1.time_ <= var_125_14 + arg_125_0 then
				arg_122_1.mask_.enabled = true
				arg_122_1.mask_.raycastTarget = true

				arg_122_1:SetGaussion(false)
			end

			local var_125_15 = 2

			if var_125_14 <= arg_122_1.time_ and arg_122_1.time_ < var_125_14 + var_125_15 then
				local var_125_16 = (arg_122_1.time_ - var_125_14) / var_125_15
				local var_125_17 = Color.New(0, 0, 0)

				var_125_17.a = Mathf.Lerp(1, 0, var_125_16)
				arg_122_1.mask_.color = var_125_17
			end

			if arg_122_1.time_ >= var_125_14 + var_125_15 and arg_122_1.time_ < var_125_14 + var_125_15 + arg_125_0 then
				local var_125_18 = Color.New(0, 0, 0)
				local var_125_19 = 0

				arg_122_1.mask_.enabled = false
				var_125_18.a = var_125_19
				arg_122_1.mask_.color = var_125_18
			end

			if arg_122_1.frameCnt_ <= 1 then
				arg_122_1.dialog_:SetActive(false)
			end

			local var_125_20 = 2
			local var_125_21 = 1.35

			if var_125_20 < arg_122_1.time_ and arg_122_1.time_ <= var_125_20 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0

				arg_122_1.dialog_:SetActive(true)

				arg_122_1.dialogCg_.alpha = 0

				local var_125_22 = LeanTween.value(arg_122_1.dialog_, 0, 1, 0.3)

				var_125_22:setOnUpdate(LuaHelper.FloatAction(function(arg_126_0)
					arg_122_1.dialogCg_.alpha = arg_126_0
				end))
				var_125_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_122_1.dialog_)
					var_125_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_122_1.duration_ = arg_122_1.duration_ + 0.3

				SetActive(arg_122_1.leftNameGo_, false)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_122_1.iconTrs_.gameObject, false)
				arg_122_1.callingController_:SetSelectedState("normal")

				local var_125_23 = arg_122_1:GetWordFromCfg(116361027)
				local var_125_24 = arg_122_1:FormatText(var_125_23.content)

				arg_122_1.text_.text = var_125_24

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_25 = 54
				local var_125_26 = utf8.len(var_125_24)
				local var_125_27 = var_125_25 <= 0 and var_125_21 or var_125_21 * (var_125_26 / var_125_25)

				if var_125_27 > 0 and var_125_21 < var_125_27 then
					arg_122_1.talkMaxDuration = var_125_27
					var_125_20 = var_125_20 + 0.3

					if var_125_27 + var_125_20 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_27 + var_125_20
					end
				end

				arg_122_1.text_.text = var_125_24
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)
				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_28 = var_125_20 + 0.3
			local var_125_29 = math.max(var_125_21, arg_122_1.talkMaxDuration)

			if var_125_28 <= arg_122_1.time_ and arg_122_1.time_ < var_125_28 + var_125_29 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_28) / var_125_29

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_28 + var_125_29 and arg_122_1.time_ < var_125_28 + var_125_29 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {}

		arg_122_1:InitPlayNodeList()
	end,
	Play116361028 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 116361028
		arg_128_1.duration_ = 8.03

		local var_128_0 = {
			zh = 8.033,
			ja = 5.433
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
				arg_128_0:Play116361029(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			local var_131_0 = arg_128_1.actors_["10032ui_story"].transform
			local var_131_1 = 0

			if var_131_1 < arg_128_1.time_ and arg_128_1.time_ <= var_131_1 + arg_131_0 then
				arg_128_1.var_.moveOldPos10032ui_story = var_131_0.localPosition
			end

			local var_131_2 = 0.001

			if var_131_1 <= arg_128_1.time_ and arg_128_1.time_ < var_131_1 + var_131_2 then
				local var_131_3 = (arg_128_1.time_ - var_131_1) / var_131_2
				local var_131_4 = Vector3.New(0, -1.1, -5.9)

				var_131_0.localPosition = Vector3.Lerp(arg_128_1.var_.moveOldPos10032ui_story, var_131_4, var_131_3)

				local var_131_5 = manager.ui.mainCamera.transform.position - var_131_0.position

				var_131_0.forward = Vector3.New(var_131_5.x, var_131_5.y, var_131_5.z)

				local var_131_6 = var_131_0.localEulerAngles

				var_131_6.z = 0
				var_131_6.x = 0
				var_131_0.localEulerAngles = var_131_6
			end

			if arg_128_1.time_ >= var_131_1 + var_131_2 and arg_128_1.time_ < var_131_1 + var_131_2 + arg_131_0 then
				var_131_0.localPosition = Vector3.New(0, -1.1, -5.9)

				local var_131_7 = manager.ui.mainCamera.transform.position - var_131_0.position

				var_131_0.forward = Vector3.New(var_131_7.x, var_131_7.y, var_131_7.z)

				local var_131_8 = var_131_0.localEulerAngles

				var_131_8.z = 0
				var_131_8.x = 0
				var_131_0.localEulerAngles = var_131_8
			end

			local var_131_9 = 0

			if var_131_9 < arg_128_1.time_ and arg_128_1.time_ <= var_131_9 + arg_131_0 then
				arg_128_1:PlayTimeline("10032ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0203cva")
			end

			local var_131_10 = arg_128_1.actors_["10032ui_story"]
			local var_131_11 = 0

			if var_131_11 < arg_128_1.time_ and arg_128_1.time_ <= var_131_11 + arg_131_0 and not isNil(var_131_10) and arg_128_1.var_.characterEffect10032ui_story == nil then
				arg_128_1.var_.characterEffect10032ui_story = var_131_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_131_12 = 0.2

			if var_131_11 <= arg_128_1.time_ and arg_128_1.time_ < var_131_11 + var_131_12 and not isNil(var_131_10) then
				local var_131_13 = (arg_128_1.time_ - var_131_11) / var_131_12

				if arg_128_1.var_.characterEffect10032ui_story and not isNil(var_131_10) then
					arg_128_1.var_.characterEffect10032ui_story.fillFlat = false
				end
			end

			if arg_128_1.time_ >= var_131_11 + var_131_12 and arg_128_1.time_ < var_131_11 + var_131_12 + arg_131_0 and not isNil(var_131_10) and arg_128_1.var_.characterEffect10032ui_story then
				arg_128_1.var_.characterEffect10032ui_story.fillFlat = false
			end

			local var_131_14 = 0

			if var_131_14 < arg_128_1.time_ and arg_128_1.time_ <= var_131_14 + arg_131_0 then
				arg_128_1:PlayTimeline("10032ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action4_1")
			end

			local var_131_15 = 0
			local var_131_16 = 0.625

			if var_131_15 < arg_128_1.time_ and arg_128_1.time_ <= var_131_15 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				local var_131_17 = arg_128_1:FormatText(StoryNameCfg[328].name)

				arg_128_1.leftNameTxt_.text = var_131_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_18 = arg_128_1:GetWordFromCfg(116361028)
				local var_131_19 = arg_128_1:FormatText(var_131_18.content)

				arg_128_1.text_.text = var_131_19

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_20 = 25
				local var_131_21 = utf8.len(var_131_19)
				local var_131_22 = var_131_20 <= 0 and var_131_16 or var_131_16 * (var_131_21 / var_131_20)

				if var_131_22 > 0 and var_131_16 < var_131_22 then
					arg_128_1.talkMaxDuration = var_131_22

					if var_131_22 + var_131_15 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_22 + var_131_15
					end
				end

				arg_128_1.text_.text = var_131_19
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116361", "116361028", "story_v_out_116361.awb") ~= 0 then
					local var_131_23 = manager.audio:GetVoiceLength("story_v_out_116361", "116361028", "story_v_out_116361.awb") / 1000

					if var_131_23 + var_131_15 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_23 + var_131_15
					end

					if var_131_18.prefab_name ~= "" and arg_128_1.actors_[var_131_18.prefab_name] ~= nil then
						local var_131_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_18.prefab_name].transform, "story_v_out_116361", "116361028", "story_v_out_116361.awb")

						arg_128_1:RecordAudio("116361028", var_131_24)
						arg_128_1:RecordAudio("116361028", var_131_24)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_out_116361", "116361028", "story_v_out_116361.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_out_116361", "116361028", "story_v_out_116361.awb")
				end

				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_25 = math.max(var_131_16, arg_128_1.talkMaxDuration)

			if var_131_15 <= arg_128_1.time_ and arg_128_1.time_ < var_131_15 + var_131_25 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_15) / var_131_25

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_15 + var_131_25 and arg_128_1.time_ < var_131_15 + var_131_25 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10032ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_128_1:InitPlayNodeList()
	end,
	Play116361029 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 116361029
		arg_132_1.duration_ = 11

		local var_132_0 = {
			zh = 11,
			ja = 8.2
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
				arg_132_0:Play116361030(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			local var_135_0 = arg_132_1.actors_["10032ui_story"].transform
			local var_135_1 = 0

			if var_135_1 < arg_132_1.time_ and arg_132_1.time_ <= var_135_1 + arg_135_0 then
				arg_132_1.var_.moveOldPos10032ui_story = var_135_0.localPosition
			end

			local var_135_2 = 0.001

			if var_135_1 <= arg_132_1.time_ and arg_132_1.time_ < var_135_1 + var_135_2 then
				local var_135_3 = (arg_132_1.time_ - var_135_1) / var_135_2
				local var_135_4 = Vector3.New(0, -1.1, -5.9)

				var_135_0.localPosition = Vector3.Lerp(arg_132_1.var_.moveOldPos10032ui_story, var_135_4, var_135_3)

				local var_135_5 = manager.ui.mainCamera.transform.position - var_135_0.position

				var_135_0.forward = Vector3.New(var_135_5.x, var_135_5.y, var_135_5.z)

				local var_135_6 = var_135_0.localEulerAngles

				var_135_6.z = 0
				var_135_6.x = 0
				var_135_0.localEulerAngles = var_135_6
			end

			if arg_132_1.time_ >= var_135_1 + var_135_2 and arg_132_1.time_ < var_135_1 + var_135_2 + arg_135_0 then
				var_135_0.localPosition = Vector3.New(0, -1.1, -5.9)

				local var_135_7 = manager.ui.mainCamera.transform.position - var_135_0.position

				var_135_0.forward = Vector3.New(var_135_7.x, var_135_7.y, var_135_7.z)

				local var_135_8 = var_135_0.localEulerAngles

				var_135_8.z = 0
				var_135_8.x = 0
				var_135_0.localEulerAngles = var_135_8
			end

			local var_135_9 = 0

			if var_135_9 < arg_132_1.time_ and arg_132_1.time_ <= var_135_9 + arg_135_0 then
				arg_132_1:PlayTimeline("10032ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_135_10 = 0
			local var_135_11 = 1

			if var_135_10 < arg_132_1.time_ and arg_132_1.time_ <= var_135_10 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				local var_135_12 = arg_132_1:FormatText(StoryNameCfg[328].name)

				arg_132_1.leftNameTxt_.text = var_135_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_13 = arg_132_1:GetWordFromCfg(116361029)
				local var_135_14 = arg_132_1:FormatText(var_135_13.content)

				arg_132_1.text_.text = var_135_14

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_15 = 40
				local var_135_16 = utf8.len(var_135_14)
				local var_135_17 = var_135_15 <= 0 and var_135_11 or var_135_11 * (var_135_16 / var_135_15)

				if var_135_17 > 0 and var_135_11 < var_135_17 then
					arg_132_1.talkMaxDuration = var_135_17

					if var_135_17 + var_135_10 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_17 + var_135_10
					end
				end

				arg_132_1.text_.text = var_135_14
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116361", "116361029", "story_v_out_116361.awb") ~= 0 then
					local var_135_18 = manager.audio:GetVoiceLength("story_v_out_116361", "116361029", "story_v_out_116361.awb") / 1000

					if var_135_18 + var_135_10 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_18 + var_135_10
					end

					if var_135_13.prefab_name ~= "" and arg_132_1.actors_[var_135_13.prefab_name] ~= nil then
						local var_135_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_13.prefab_name].transform, "story_v_out_116361", "116361029", "story_v_out_116361.awb")

						arg_132_1:RecordAudio("116361029", var_135_19)
						arg_132_1:RecordAudio("116361029", var_135_19)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_out_116361", "116361029", "story_v_out_116361.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_out_116361", "116361029", "story_v_out_116361.awb")
				end

				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_20 = math.max(var_135_11, arg_132_1.talkMaxDuration)

			if var_135_10 <= arg_132_1.time_ and arg_132_1.time_ < var_135_10 + var_135_20 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_10) / var_135_20

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_10 + var_135_20 and arg_132_1.time_ < var_135_10 + var_135_20 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10032ui_story",
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
	Play116361030 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 116361030
		arg_136_1.duration_ = 11.17

		local var_136_0 = {
			zh = 8.633,
			ja = 11.166
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
				arg_136_0:Play116361031(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			local var_139_0 = arg_136_1.actors_["10032ui_story"].transform
			local var_139_1 = 0

			if var_139_1 < arg_136_1.time_ and arg_136_1.time_ <= var_139_1 + arg_139_0 then
				arg_136_1.var_.moveOldPos10032ui_story = var_139_0.localPosition
			end

			local var_139_2 = 0.001

			if var_139_1 <= arg_136_1.time_ and arg_136_1.time_ < var_139_1 + var_139_2 then
				local var_139_3 = (arg_136_1.time_ - var_139_1) / var_139_2
				local var_139_4 = Vector3.New(0, -1.1, -5.9)

				var_139_0.localPosition = Vector3.Lerp(arg_136_1.var_.moveOldPos10032ui_story, var_139_4, var_139_3)

				local var_139_5 = manager.ui.mainCamera.transform.position - var_139_0.position

				var_139_0.forward = Vector3.New(var_139_5.x, var_139_5.y, var_139_5.z)

				local var_139_6 = var_139_0.localEulerAngles

				var_139_6.z = 0
				var_139_6.x = 0
				var_139_0.localEulerAngles = var_139_6
			end

			if arg_136_1.time_ >= var_139_1 + var_139_2 and arg_136_1.time_ < var_139_1 + var_139_2 + arg_139_0 then
				var_139_0.localPosition = Vector3.New(0, -1.1, -5.9)

				local var_139_7 = manager.ui.mainCamera.transform.position - var_139_0.position

				var_139_0.forward = Vector3.New(var_139_7.x, var_139_7.y, var_139_7.z)

				local var_139_8 = var_139_0.localEulerAngles

				var_139_8.z = 0
				var_139_8.x = 0
				var_139_0.localEulerAngles = var_139_8
			end

			local var_139_9 = 0

			if var_139_9 < arg_136_1.time_ and arg_136_1.time_ <= var_139_9 + arg_139_0 then
				arg_136_1:PlayTimeline("10032ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0203cva")
			end

			local var_139_10 = arg_136_1.actors_["10032ui_story"]
			local var_139_11 = 0

			if var_139_11 < arg_136_1.time_ and arg_136_1.time_ <= var_139_11 + arg_139_0 and not isNil(var_139_10) and arg_136_1.var_.characterEffect10032ui_story == nil then
				arg_136_1.var_.characterEffect10032ui_story = var_139_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_139_12 = 0.2

			if var_139_11 <= arg_136_1.time_ and arg_136_1.time_ < var_139_11 + var_139_12 and not isNil(var_139_10) then
				local var_139_13 = (arg_136_1.time_ - var_139_11) / var_139_12

				if arg_136_1.var_.characterEffect10032ui_story and not isNil(var_139_10) then
					arg_136_1.var_.characterEffect10032ui_story.fillFlat = false
				end
			end

			if arg_136_1.time_ >= var_139_11 + var_139_12 and arg_136_1.time_ < var_139_11 + var_139_12 + arg_139_0 and not isNil(var_139_10) and arg_136_1.var_.characterEffect10032ui_story then
				arg_136_1.var_.characterEffect10032ui_story.fillFlat = false
			end

			local var_139_14 = 0

			if var_139_14 < arg_136_1.time_ and arg_136_1.time_ <= var_139_14 + arg_139_0 then
				arg_136_1:PlayTimeline("10032ui_story", "StoryTimeline/CharAction/story10025/story10025actionlink/10025action442")
			end

			local var_139_15 = 0
			local var_139_16 = 0.725

			if var_139_15 < arg_136_1.time_ and arg_136_1.time_ <= var_139_15 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				local var_139_17 = arg_136_1:FormatText(StoryNameCfg[328].name)

				arg_136_1.leftNameTxt_.text = var_139_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_18 = arg_136_1:GetWordFromCfg(116361030)
				local var_139_19 = arg_136_1:FormatText(var_139_18.content)

				arg_136_1.text_.text = var_139_19

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_20 = 29
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

				if manager.audio:GetVoiceLength("story_v_out_116361", "116361030", "story_v_out_116361.awb") ~= 0 then
					local var_139_23 = manager.audio:GetVoiceLength("story_v_out_116361", "116361030", "story_v_out_116361.awb") / 1000

					if var_139_23 + var_139_15 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_23 + var_139_15
					end

					if var_139_18.prefab_name ~= "" and arg_136_1.actors_[var_139_18.prefab_name] ~= nil then
						local var_139_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_136_1.actors_[var_139_18.prefab_name].transform, "story_v_out_116361", "116361030", "story_v_out_116361.awb")

						arg_136_1:RecordAudio("116361030", var_139_24)
						arg_136_1:RecordAudio("116361030", var_139_24)
					else
						arg_136_1:AudioAction("play", "voice", "story_v_out_116361", "116361030", "story_v_out_116361.awb")
					end

					arg_136_1:RecordHistoryTalkVoice("story_v_out_116361", "116361030", "story_v_out_116361.awb")
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
				actorName = "10032ui_story",
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
	Play116361031 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 116361031
		arg_140_1.duration_ = 5

		SetActive(arg_140_1.tipsGo_, false)

		function arg_140_1.onSingleLineFinish_()
			arg_140_1.onSingleLineUpdate_ = nil
			arg_140_1.onSingleLineFinish_ = nil
			arg_140_1.state_ = "waiting"
		end

		function arg_140_1.playNext_(arg_142_0)
			if arg_142_0 == 1 then
				arg_140_0:Play116361032(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			local var_143_0 = arg_140_1.actors_["10032ui_story"].transform
			local var_143_1 = 0

			if var_143_1 < arg_140_1.time_ and arg_140_1.time_ <= var_143_1 + arg_143_0 then
				arg_140_1.var_.moveOldPos10032ui_story = var_143_0.localPosition
			end

			local var_143_2 = 0.001

			if var_143_1 <= arg_140_1.time_ and arg_140_1.time_ < var_143_1 + var_143_2 then
				local var_143_3 = (arg_140_1.time_ - var_143_1) / var_143_2
				local var_143_4 = Vector3.New(0, 100, 0)

				var_143_0.localPosition = Vector3.Lerp(arg_140_1.var_.moveOldPos10032ui_story, var_143_4, var_143_3)

				local var_143_5 = manager.ui.mainCamera.transform.position - var_143_0.position

				var_143_0.forward = Vector3.New(var_143_5.x, var_143_5.y, var_143_5.z)

				local var_143_6 = var_143_0.localEulerAngles

				var_143_6.z = 0
				var_143_6.x = 0
				var_143_0.localEulerAngles = var_143_6
			end

			if arg_140_1.time_ >= var_143_1 + var_143_2 and arg_140_1.time_ < var_143_1 + var_143_2 + arg_143_0 then
				var_143_0.localPosition = Vector3.New(0, 100, 0)

				local var_143_7 = manager.ui.mainCamera.transform.position - var_143_0.position

				var_143_0.forward = Vector3.New(var_143_7.x, var_143_7.y, var_143_7.z)

				local var_143_8 = var_143_0.localEulerAngles

				var_143_8.z = 0
				var_143_8.x = 0
				var_143_0.localEulerAngles = var_143_8
			end

			local var_143_9 = 0
			local var_143_10 = 0.725

			if var_143_9 < arg_140_1.time_ and arg_140_1.time_ <= var_143_9 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, false)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_140_1.iconTrs_.gameObject, false)
				arg_140_1.callingController_:SetSelectedState("normal")

				local var_143_11 = arg_140_1:GetWordFromCfg(116361031)
				local var_143_12 = arg_140_1:FormatText(var_143_11.content)

				arg_140_1.text_.text = var_143_12

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_13 = 29
				local var_143_14 = utf8.len(var_143_12)
				local var_143_15 = var_143_13 <= 0 and var_143_10 or var_143_10 * (var_143_14 / var_143_13)

				if var_143_15 > 0 and var_143_10 < var_143_15 then
					arg_140_1.talkMaxDuration = var_143_15

					if var_143_15 + var_143_9 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_15 + var_143_9
					end
				end

				arg_140_1.text_.text = var_143_12
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)
				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_16 = math.max(var_143_10, arg_140_1.talkMaxDuration)

			if var_143_9 <= arg_140_1.time_ and arg_140_1.time_ < var_143_9 + var_143_16 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_9) / var_143_16

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_9 + var_143_16 and arg_140_1.time_ < var_143_9 + var_143_16 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10032ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_140_1:InitPlayNodeList()
	end,
	Play116361032 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 116361032
		arg_144_1.duration_ = 5.8

		local var_144_0 = {
			zh = 4.2,
			ja = 5.8
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
				arg_144_0:Play116361033(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			local var_147_0 = 0
			local var_147_1 = 0.375

			if var_147_0 < arg_144_1.time_ and arg_144_1.time_ <= var_147_0 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				local var_147_2 = arg_144_1:FormatText(StoryNameCfg[328].name)

				arg_144_1.leftNameTxt_.text = var_147_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, true)
				arg_144_1.iconController_:SetSelectedState("hero")

				arg_144_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10032")

				arg_144_1.callingController_:SetSelectedState("normal")

				arg_144_1.keyicon_.color = Color.New(1, 1, 1)
				arg_144_1.icon_.color = Color.New(1, 1, 1)

				local var_147_3 = arg_144_1:GetWordFromCfg(116361032)
				local var_147_4 = arg_144_1:FormatText(var_147_3.content)

				arg_144_1.text_.text = var_147_4

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_5 = 15
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

				if manager.audio:GetVoiceLength("story_v_out_116361", "116361032", "story_v_out_116361.awb") ~= 0 then
					local var_147_8 = manager.audio:GetVoiceLength("story_v_out_116361", "116361032", "story_v_out_116361.awb") / 1000

					if var_147_8 + var_147_0 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_8 + var_147_0
					end

					if var_147_3.prefab_name ~= "" and arg_144_1.actors_[var_147_3.prefab_name] ~= nil then
						local var_147_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_144_1.actors_[var_147_3.prefab_name].transform, "story_v_out_116361", "116361032", "story_v_out_116361.awb")

						arg_144_1:RecordAudio("116361032", var_147_9)
						arg_144_1:RecordAudio("116361032", var_147_9)
					else
						arg_144_1:AudioAction("play", "voice", "story_v_out_116361", "116361032", "story_v_out_116361.awb")
					end

					arg_144_1:RecordHistoryTalkVoice("story_v_out_116361", "116361032", "story_v_out_116361.awb")
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
	Play116361033 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 116361033
		arg_148_1.duration_ = 26.7

		SetActive(arg_148_1.tipsGo_, false)

		function arg_148_1.onSingleLineFinish_()
			arg_148_1.onSingleLineUpdate_ = nil
			arg_148_1.onSingleLineFinish_ = nil
			arg_148_1.state_ = "waiting"
		end

		function arg_148_1.playNext_(arg_150_0)
			if arg_150_0 == 1 then
				arg_148_0:Play116361034(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			local var_151_0 = "ST03_blur"

			if arg_148_1.bgs_[var_151_0] == nil then
				local var_151_1 = Object.Instantiate(arg_148_1.paintGo_)

				var_151_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_151_0)
				var_151_1.name = var_151_0
				var_151_1.transform.parent = arg_148_1.stage_.transform
				var_151_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_148_1.bgs_[var_151_0] = var_151_1
			end

			local var_151_2 = 5.7

			if var_151_2 < arg_148_1.time_ and arg_148_1.time_ <= var_151_2 + arg_151_0 then
				local var_151_3 = manager.ui.mainCamera.transform.localPosition
				local var_151_4 = Vector3.New(0, 0, 10) + Vector3.New(var_151_3.x, var_151_3.y, 0)
				local var_151_5 = arg_148_1.bgs_.ST03_blur

				var_151_5.transform.localPosition = var_151_4
				var_151_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_151_6 = var_151_5:GetComponent("SpriteRenderer")

				if var_151_6 and var_151_6.sprite then
					local var_151_7 = (var_151_5.transform.localPosition - var_151_3).z
					local var_151_8 = manager.ui.mainCameraCom_
					local var_151_9 = 2 * var_151_7 * Mathf.Tan(var_151_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_151_10 = var_151_9 * var_151_8.aspect
					local var_151_11 = var_151_6.sprite.bounds.size.x
					local var_151_12 = var_151_6.sprite.bounds.size.y
					local var_151_13 = var_151_10 / var_151_11
					local var_151_14 = var_151_9 / var_151_12
					local var_151_15 = var_151_14 < var_151_13 and var_151_13 or var_151_14

					var_151_5.transform.localScale = Vector3.New(var_151_15, var_151_15, 0)
				end

				for iter_151_0, iter_151_1 in pairs(arg_148_1.bgs_) do
					if iter_151_0 ~= "ST03_blur" then
						iter_151_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_151_16 = "I05"

			if arg_148_1.bgs_[var_151_16] == nil then
				local var_151_17 = Object.Instantiate(arg_148_1.paintGo_)

				var_151_17:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_151_16)
				var_151_17.name = var_151_16
				var_151_17.transform.parent = arg_148_1.stage_.transform
				var_151_17.transform.localPosition = Vector3.New(0, 100, 0)
				arg_148_1.bgs_[var_151_16] = var_151_17
			end

			local var_151_18 = 12.6866666666667

			if var_151_18 < arg_148_1.time_ and arg_148_1.time_ <= var_151_18 + arg_151_0 then
				local var_151_19 = manager.ui.mainCamera.transform.localPosition
				local var_151_20 = Vector3.New(0, 0, 10) + Vector3.New(var_151_19.x, var_151_19.y, 0)
				local var_151_21 = arg_148_1.bgs_.I05

				var_151_21.transform.localPosition = var_151_20
				var_151_21.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_151_22 = var_151_21:GetComponent("SpriteRenderer")

				if var_151_22 and var_151_22.sprite then
					local var_151_23 = (var_151_21.transform.localPosition - var_151_19).z
					local var_151_24 = manager.ui.mainCameraCom_
					local var_151_25 = 2 * var_151_23 * Mathf.Tan(var_151_24.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_151_26 = var_151_25 * var_151_24.aspect
					local var_151_27 = var_151_22.sprite.bounds.size.x
					local var_151_28 = var_151_22.sprite.bounds.size.y
					local var_151_29 = var_151_26 / var_151_27
					local var_151_30 = var_151_25 / var_151_28
					local var_151_31 = var_151_30 < var_151_29 and var_151_29 or var_151_30

					var_151_21.transform.localScale = Vector3.New(var_151_31, var_151_31, 0)
				end

				for iter_151_2, iter_151_3 in pairs(arg_148_1.bgs_) do
					if iter_151_2 ~= "I05" then
						iter_151_3.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_151_32 = 19.7

			if var_151_32 < arg_148_1.time_ and arg_148_1.time_ <= var_151_32 + arg_151_0 then
				local var_151_33 = manager.ui.mainCamera.transform.localPosition
				local var_151_34 = Vector3.New(0, 0, 10) + Vector3.New(var_151_33.x, var_151_33.y, 0)
				local var_151_35 = arg_148_1.bgs_.ST15

				var_151_35.transform.localPosition = var_151_34
				var_151_35.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_151_36 = var_151_35:GetComponent("SpriteRenderer")

				if var_151_36 and var_151_36.sprite then
					local var_151_37 = (var_151_35.transform.localPosition - var_151_33).z
					local var_151_38 = manager.ui.mainCameraCom_
					local var_151_39 = 2 * var_151_37 * Mathf.Tan(var_151_38.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_151_40 = var_151_39 * var_151_38.aspect
					local var_151_41 = var_151_36.sprite.bounds.size.x
					local var_151_42 = var_151_36.sprite.bounds.size.y
					local var_151_43 = var_151_40 / var_151_41
					local var_151_44 = var_151_39 / var_151_42
					local var_151_45 = var_151_44 < var_151_43 and var_151_43 or var_151_44

					var_151_35.transform.localScale = Vector3.New(var_151_45, var_151_45, 0)
				end

				for iter_151_4, iter_151_5 in pairs(arg_148_1.bgs_) do
					if iter_151_4 ~= "ST15" then
						iter_151_5.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_151_46 = 0

			if var_151_46 < arg_148_1.time_ and arg_148_1.time_ <= var_151_46 + arg_151_0 then
				arg_148_1.mask_.enabled = true
				arg_148_1.mask_.raycastTarget = true

				arg_148_1:SetGaussion(false)
			end

			local var_151_47 = 2

			if var_151_46 <= arg_148_1.time_ and arg_148_1.time_ < var_151_46 + var_151_47 then
				local var_151_48 = (arg_148_1.time_ - var_151_46) / var_151_47
				local var_151_49 = Color.New(0, 0, 0)

				var_151_49.a = Mathf.Lerp(0, 1, var_151_48)
				arg_148_1.mask_.color = var_151_49
			end

			if arg_148_1.time_ >= var_151_46 + var_151_47 and arg_148_1.time_ < var_151_46 + var_151_47 + arg_151_0 then
				local var_151_50 = Color.New(0, 0, 0)

				var_151_50.a = 1
				arg_148_1.mask_.color = var_151_50
			end

			local var_151_51 = 2

			if var_151_51 < arg_148_1.time_ and arg_148_1.time_ <= var_151_51 + arg_151_0 then
				arg_148_1.mask_.enabled = true
				arg_148_1.mask_.raycastTarget = true

				arg_148_1:SetGaussion(false)
			end

			local var_151_52 = 0.0166666666666667

			if var_151_51 <= arg_148_1.time_ and arg_148_1.time_ < var_151_51 + var_151_52 then
				local var_151_53 = (arg_148_1.time_ - var_151_51) / var_151_52
				local var_151_54 = Color.New(0, 0, 0)

				var_151_54.a = Mathf.Lerp(1, 0, var_151_53)
				arg_148_1.mask_.color = var_151_54
			end

			if arg_148_1.time_ >= var_151_51 + var_151_52 and arg_148_1.time_ < var_151_51 + var_151_52 + arg_151_0 then
				local var_151_55 = Color.New(0, 0, 0)
				local var_151_56 = 0

				arg_148_1.mask_.enabled = false
				var_151_55.a = var_151_56
				arg_148_1.mask_.color = var_151_55
			end

			local var_151_57 = 2
			local var_151_58 = 1

			if var_151_57 < arg_148_1.time_ and arg_148_1.time_ <= var_151_57 + arg_151_0 then
				local var_151_59 = "play"
				local var_151_60 = "effect"

				arg_148_1:AudioAction(var_151_59, var_151_60, "se_story_16", "se_story_16_whoosh", "")
			end

			local var_151_61 = 2

			if var_151_61 < arg_148_1.time_ and arg_148_1.time_ <= var_151_61 + arg_151_0 then
				SetActive(arg_148_1.dialog_, false)
				SetActive(arg_148_1.allBtn_.gameObject, false)
				arg_148_1.hideBtnsController_:SetSelectedIndex(1)
				manager.video:Play("SofdecAsset/story/story_101161201.usm", function(arg_152_0)
					arg_148_1.time_ = var_151_61 + 3.66000000022352

					if arg_148_1.state_ == "pause" then
						arg_148_1.state_ = "playing"
					end

					manager.video:Dispose()
				end, nil, nil, function(arg_153_0)
					if arg_153_0 then
						arg_148_1.state_ = "pause"
					else
						arg_148_1.state_ = "playing"
					end
				end)
				manager.video.transform_:SetSiblingIndex(1)
			end

			local var_151_62 = 3.67

			if var_151_61 <= arg_148_1.time_ and arg_148_1.time_ < var_151_61 + var_151_62 then
				-- block empty
			end

			if arg_148_1.time_ >= var_151_61 + var_151_62 and arg_148_1.time_ < var_151_61 + var_151_62 + arg_151_0 then
				-- block empty
			end

			local var_151_63 = 5.67

			if var_151_63 < arg_148_1.time_ and arg_148_1.time_ <= var_151_63 + arg_151_0 then
				SetActive(arg_148_1.dialog_, true)
				SetActive(arg_148_1.allBtn_.gameObject, true)
				arg_148_1.hideBtnsController_:SetSelectedIndex(0)
				manager.video:Dispose()

				arg_148_1.isInLoopVideo = false
			end

			local var_151_64 = 0.0300000000000002

			if var_151_63 <= arg_148_1.time_ and arg_148_1.time_ < var_151_63 + var_151_64 then
				-- block empty
			end

			if arg_148_1.time_ >= var_151_63 + var_151_64 and arg_148_1.time_ < var_151_63 + var_151_64 + arg_151_0 then
				-- block empty
			end

			local var_151_65 = "ST03_blur"

			if arg_148_1.bgs_[var_151_65] == nil then
				local var_151_66 = Object.Instantiate(arg_148_1.blurPaintGo_)
				local var_151_67 = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_151_65)

				var_151_66:GetComponent("SpriteRenderer").sprite = var_151_67
				var_151_66.name = var_151_65
				var_151_66.transform.parent = arg_148_1.stage_.transform
				var_151_66.transform.localPosition = Vector3.New(0, 100, 0)
				arg_148_1.bgs_[var_151_65] = var_151_66
			end

			local var_151_68 = 5.7
			local var_151_69 = arg_148_1.bgs_[var_151_65]

			if var_151_68 < arg_148_1.time_ and arg_148_1.time_ <= var_151_68 + arg_151_0 then
				local var_151_70 = manager.ui.mainCamera.transform.localPosition
				local var_151_71 = Vector3.New(0, 0, 10) + Vector3.New(var_151_70.x, var_151_70.y, 0)

				var_151_69.transform.localPosition = var_151_71
				var_151_69.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_151_72 = var_151_69:GetComponent("SpriteRenderer")

				if var_151_72 and var_151_72.sprite then
					local var_151_73 = (var_151_69.transform.localPosition - var_151_70).z
					local var_151_74 = manager.ui.mainCameraCom_
					local var_151_75 = 2 * var_151_73 * Mathf.Tan(var_151_74.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_151_76 = var_151_75 * var_151_74.aspect
					local var_151_77 = var_151_72.sprite.bounds.size.x
					local var_151_78 = var_151_72.sprite.bounds.size.y
					local var_151_79 = var_151_76 / var_151_77
					local var_151_80 = var_151_75 / var_151_78
					local var_151_81 = var_151_80 < var_151_79 and var_151_79 or var_151_80

					var_151_69.transform.localScale = Vector3.New(var_151_81, var_151_81, 0)
				end
			end

			local var_151_82 = 7

			if var_151_68 <= arg_148_1.time_ and arg_148_1.time_ < var_151_68 + var_151_82 then
				local var_151_83 = (arg_148_1.time_ - var_151_68) / var_151_82
				local var_151_84 = Color.New(1, 1, 1)

				var_151_84.a = Mathf.Lerp(0, 1, var_151_83)

				var_151_69:GetComponent("SpriteRenderer").material:SetColor("_Color", var_151_84)
			end

			local var_151_85 = "I05_blur"

			if arg_148_1.bgs_[var_151_85] == nil then
				local var_151_86 = Object.Instantiate(arg_148_1.blurPaintGo_)
				local var_151_87 = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_151_85)

				var_151_86:GetComponent("SpriteRenderer").sprite = var_151_87
				var_151_86.name = var_151_85
				var_151_86.transform.parent = arg_148_1.stage_.transform
				var_151_86.transform.localPosition = Vector3.New(0, 100, 0)
				arg_148_1.bgs_[var_151_85] = var_151_86
			end

			local var_151_88 = 12.7
			local var_151_89 = arg_148_1.bgs_[var_151_85]

			if var_151_88 < arg_148_1.time_ and arg_148_1.time_ <= var_151_88 + arg_151_0 then
				local var_151_90 = manager.ui.mainCamera.transform.localPosition
				local var_151_91 = Vector3.New(0, 0, 10) + Vector3.New(var_151_90.x, var_151_90.y, 0)

				var_151_89.transform.localPosition = var_151_91
				var_151_89.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_151_92 = var_151_89:GetComponent("SpriteRenderer")

				if var_151_92 and var_151_92.sprite then
					local var_151_93 = (var_151_89.transform.localPosition - var_151_90).z
					local var_151_94 = manager.ui.mainCameraCom_
					local var_151_95 = 2 * var_151_93 * Mathf.Tan(var_151_94.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_151_96 = var_151_95 * var_151_94.aspect
					local var_151_97 = var_151_92.sprite.bounds.size.x
					local var_151_98 = var_151_92.sprite.bounds.size.y
					local var_151_99 = var_151_96 / var_151_97
					local var_151_100 = var_151_95 / var_151_98
					local var_151_101 = var_151_100 < var_151_99 and var_151_99 or var_151_100

					var_151_89.transform.localScale = Vector3.New(var_151_101, var_151_101, 0)
				end
			end

			local var_151_102 = 7

			if var_151_88 <= arg_148_1.time_ and arg_148_1.time_ < var_151_88 + var_151_102 then
				local var_151_103 = (arg_148_1.time_ - var_151_88) / var_151_102
				local var_151_104 = Color.New(1, 1, 1)

				var_151_104.a = Mathf.Lerp(0, 1, var_151_103)

				var_151_89:GetComponent("SpriteRenderer").material:SetColor("_Color", var_151_104)
			end

			local var_151_105 = "ST15_blur"

			if arg_148_1.bgs_[var_151_105] == nil then
				local var_151_106 = Object.Instantiate(arg_148_1.blurPaintGo_)
				local var_151_107 = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_151_105)

				var_151_106:GetComponent("SpriteRenderer").sprite = var_151_107
				var_151_106.name = var_151_105
				var_151_106.transform.parent = arg_148_1.stage_.transform
				var_151_106.transform.localPosition = Vector3.New(0, 100, 0)
				arg_148_1.bgs_[var_151_105] = var_151_106
			end

			local var_151_108 = 19.7
			local var_151_109 = arg_148_1.bgs_[var_151_105]

			if var_151_108 < arg_148_1.time_ and arg_148_1.time_ <= var_151_108 + arg_151_0 then
				local var_151_110 = manager.ui.mainCamera.transform.localPosition
				local var_151_111 = Vector3.New(0, 0, 10) + Vector3.New(var_151_110.x, var_151_110.y, 0)

				var_151_109.transform.localPosition = var_151_111
				var_151_109.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_151_112 = var_151_109:GetComponent("SpriteRenderer")

				if var_151_112 and var_151_112.sprite then
					local var_151_113 = (var_151_109.transform.localPosition - var_151_110).z
					local var_151_114 = manager.ui.mainCameraCom_
					local var_151_115 = 2 * var_151_113 * Mathf.Tan(var_151_114.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_151_116 = var_151_115 * var_151_114.aspect
					local var_151_117 = var_151_112.sprite.bounds.size.x
					local var_151_118 = var_151_112.sprite.bounds.size.y
					local var_151_119 = var_151_116 / var_151_117
					local var_151_120 = var_151_115 / var_151_118
					local var_151_121 = var_151_120 < var_151_119 and var_151_119 or var_151_120

					var_151_109.transform.localScale = Vector3.New(var_151_121, var_151_121, 0)
				end
			end

			local var_151_122 = 7

			if var_151_108 <= arg_148_1.time_ and arg_148_1.time_ < var_151_108 + var_151_122 then
				local var_151_123 = (arg_148_1.time_ - var_151_108) / var_151_122
				local var_151_124 = Color.New(1, 1, 1)

				var_151_124.a = Mathf.Lerp(0, 1, var_151_123)

				var_151_109:GetComponent("SpriteRenderer").material:SetColor("_Color", var_151_124)
			end

			local var_151_125 = 5.7

			if var_151_125 < arg_148_1.time_ and arg_148_1.time_ <= var_151_125 + arg_151_0 then
				arg_148_1.mask_.enabled = true
				arg_148_1.mask_.raycastTarget = true

				arg_148_1:SetGaussion(false)
			end

			local var_151_126 = 5

			if var_151_125 <= arg_148_1.time_ and arg_148_1.time_ < var_151_125 + var_151_126 then
				local var_151_127 = (arg_148_1.time_ - var_151_125) / var_151_126
				local var_151_128 = Color.New(1, 1, 1)

				var_151_128.a = Mathf.Lerp(1, 0, var_151_127)
				arg_148_1.mask_.color = var_151_128
			end

			if arg_148_1.time_ >= var_151_125 + var_151_126 and arg_148_1.time_ < var_151_125 + var_151_126 + arg_151_0 then
				local var_151_129 = Color.New(1, 1, 1)
				local var_151_130 = 0

				arg_148_1.mask_.enabled = false
				var_151_129.a = var_151_130
				arg_148_1.mask_.color = var_151_129
			end

			local var_151_131 = 12.7

			if var_151_131 < arg_148_1.time_ and arg_148_1.time_ <= var_151_131 + arg_151_0 then
				arg_148_1.mask_.enabled = true
				arg_148_1.mask_.raycastTarget = true

				arg_148_1:SetGaussion(false)
			end

			local var_151_132 = 5

			if var_151_131 <= arg_148_1.time_ and arg_148_1.time_ < var_151_131 + var_151_132 then
				local var_151_133 = (arg_148_1.time_ - var_151_131) / var_151_132
				local var_151_134 = Color.New(1, 1, 1)

				var_151_134.a = Mathf.Lerp(1, 0, var_151_133)
				arg_148_1.mask_.color = var_151_134
			end

			if arg_148_1.time_ >= var_151_131 + var_151_132 and arg_148_1.time_ < var_151_131 + var_151_132 + arg_151_0 then
				local var_151_135 = Color.New(1, 1, 1)
				local var_151_136 = 0

				arg_148_1.mask_.enabled = false
				var_151_135.a = var_151_136
				arg_148_1.mask_.color = var_151_135
			end

			local var_151_137 = 19.7

			if var_151_137 < arg_148_1.time_ and arg_148_1.time_ <= var_151_137 + arg_151_0 then
				arg_148_1.mask_.enabled = true
				arg_148_1.mask_.raycastTarget = true

				arg_148_1:SetGaussion(false)
			end

			local var_151_138 = 5

			if var_151_137 <= arg_148_1.time_ and arg_148_1.time_ < var_151_137 + var_151_138 then
				local var_151_139 = (arg_148_1.time_ - var_151_137) / var_151_138
				local var_151_140 = Color.New(1, 1, 1)

				var_151_140.a = Mathf.Lerp(1, 0, var_151_139)
				arg_148_1.mask_.color = var_151_140
			end

			if arg_148_1.time_ >= var_151_137 + var_151_138 and arg_148_1.time_ < var_151_137 + var_151_138 + arg_151_0 then
				local var_151_141 = Color.New(1, 1, 1)
				local var_151_142 = 0

				arg_148_1.mask_.enabled = false
				var_151_141.a = var_151_142
				arg_148_1.mask_.color = var_151_141
			end

			local var_151_143 = 2

			if var_151_143 < arg_148_1.time_ and arg_148_1.time_ <= var_151_143 + arg_151_0 then
				local var_151_144 = arg_148_1.fswbg_.transform:Find("textbox/adapt/content") or arg_148_1.fswbg_.transform:Find("textbox/content")
				local var_151_145 = arg_148_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_151_146 = var_151_144:GetComponent("Text")
				local var_151_147 = var_151_144:GetComponent("RectTransform")

				var_151_146.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_151_147.offsetMin = Vector2.New(0, 0)
				var_151_147.offsetMax = Vector2.New(0, 0)
			end

			local var_151_148 = 5.67

			if var_151_148 < arg_148_1.time_ and arg_148_1.time_ <= var_151_148 + arg_151_0 then
				arg_148_1.fswbg_:SetActive(true)
				arg_148_1.dialog_:SetActive(false)

				arg_148_1.fswtw_.percent = 0

				local var_151_149 = arg_148_1:GetWordFromCfg(116361033)
				local var_151_150 = arg_148_1:FormatText(var_151_149.content)

				arg_148_1.fswt_.text = var_151_150

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.fswt_)

				arg_148_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_148_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_148_1.fswtw_:SetDirty()

				arg_148_1.typewritterCharCountI18N = 0

				SetActive(arg_148_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_148_1:ShowNextGo(false)
			end

			local var_151_151 = 5.70333333333333

			if var_151_151 < arg_148_1.time_ and arg_148_1.time_ <= var_151_151 + arg_151_0 then
				arg_148_1.var_.oldValueTypewriter = arg_148_1.fswtw_.percent

				SetActive(arg_148_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_148_1:ShowNextGo(false)
			end

			local var_151_152 = 2
			local var_151_153 = 0.133333333333333
			local var_151_154 = arg_148_1:GetWordFromCfg(116361033)
			local var_151_155 = arg_148_1:FormatText(var_151_154.content)
			local var_151_156, var_151_157 = arg_148_1:GetPercentByPara(var_151_155, 1)

			if var_151_151 < arg_148_1.time_ and arg_148_1.time_ <= var_151_151 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0

				local var_151_158 = var_151_152 <= 0 and var_151_153 or var_151_153 * ((var_151_157 - arg_148_1.typewritterCharCountI18N) / var_151_152)

				if var_151_158 > 0 and var_151_153 < var_151_158 then
					arg_148_1.talkMaxDuration = var_151_158

					if var_151_158 + var_151_151 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_158 + var_151_151
					end
				end
			end

			local var_151_159 = 0.133333333333333
			local var_151_160 = math.max(var_151_159, arg_148_1.talkMaxDuration)

			if var_151_151 <= arg_148_1.time_ and arg_148_1.time_ < var_151_151 + var_151_160 then
				local var_151_161 = (arg_148_1.time_ - var_151_151) / var_151_160

				arg_148_1.fswtw_.percent = Mathf.Lerp(arg_148_1.var_.oldValueTypewriter, var_151_156, var_151_161)
				arg_148_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_148_1.fswtw_:SetDirty()
			end

			if arg_148_1.time_ >= var_151_151 + var_151_160 and arg_148_1.time_ < var_151_151 + var_151_160 + arg_151_0 then
				arg_148_1.fswtw_.percent = var_151_156

				arg_148_1.fswtw_:SetDirty()
				arg_148_1:ShowNextGo(true)

				arg_148_1.typewritterCharCountI18N = var_151_157
			end

			local var_151_162 = 5.67

			if var_151_162 < arg_148_1.time_ and arg_148_1.time_ <= var_151_162 + arg_151_0 then
				arg_148_1.allBtn_.enabled = false
			end

			local var_151_163 = 21.03

			if arg_148_1.time_ >= var_151_162 + var_151_163 and arg_148_1.time_ < var_151_162 + var_151_163 + arg_151_0 then
				arg_148_1.allBtn_.enabled = true
			end

			local var_151_164 = 0
			local var_151_165 = 1

			if var_151_164 < arg_148_1.time_ and arg_148_1.time_ <= var_151_164 + arg_151_0 then
				local var_151_166 = "play"
				local var_151_167 = "music"

				arg_148_1:AudioAction(var_151_166, var_151_167, "ui_battle", "ui_battle_stopbgm", "")

				local var_151_168 = ""
				local var_151_169 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_151_169 ~= "" then
					if arg_148_1.bgmTxt_.text ~= var_151_169 and arg_148_1.bgmTxt_.text ~= "" then
						if arg_148_1.bgmTxt2_.text ~= "" then
							arg_148_1.bgmTxt_.text = arg_148_1.bgmTxt2_.text
						end

						arg_148_1.bgmTxt2_.text = var_151_169

						arg_148_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_148_1.bgmTxt_.text = var_151_169
						arg_148_1.bgmTxt2_.text = var_151_169
					end

					if arg_148_1.bgmTimer then
						arg_148_1.bgmTimer:Stop()

						arg_148_1.bgmTimer = nil
					end

					if arg_148_1.settingData.show_music_name == 1 then
						arg_148_1.musicController:SetSelectedState("show")
						arg_148_1.musicAnimator_:Play("open", 0, 0)

						if arg_148_1.settingData.music_time ~= 0 then
							arg_148_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_148_1.settingData.music_time), function()
								if arg_148_1 == nil or isNil(arg_148_1.bgmTxt_) then
									return
								end

								arg_148_1.musicController:SetSelectedState("hide")
								arg_148_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_151_170 = 5.83666666666667
			local var_151_171 = 1

			if var_151_170 < arg_148_1.time_ and arg_148_1.time_ <= var_151_170 + arg_151_0 then
				local var_151_172 = "play"
				local var_151_173 = "music"

				arg_148_1:AudioAction(var_151_172, var_151_173, "bgm_activity_1_6_story_skuld", "bgm_activity_1_6_story_skuld", "bgm_activity_1_6_story_skuld.awb")

				local var_151_174 = ""
				local var_151_175 = manager.audio:GetAudioName("bgm_activity_1_6_story_skuld", "bgm_activity_1_6_story_skuld")

				if var_151_175 ~= "" then
					if arg_148_1.bgmTxt_.text ~= var_151_175 and arg_148_1.bgmTxt_.text ~= "" then
						if arg_148_1.bgmTxt2_.text ~= "" then
							arg_148_1.bgmTxt_.text = arg_148_1.bgmTxt2_.text
						end

						arg_148_1.bgmTxt2_.text = var_151_175

						arg_148_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_148_1.bgmTxt_.text = var_151_175
						arg_148_1.bgmTxt2_.text = var_151_175
					end

					if arg_148_1.bgmTimer then
						arg_148_1.bgmTimer:Stop()

						arg_148_1.bgmTimer = nil
					end

					if arg_148_1.settingData.show_music_name == 1 then
						arg_148_1.musicController:SetSelectedState("show")
						arg_148_1.musicAnimator_:Play("open", 0, 0)

						if arg_148_1.settingData.music_time ~= 0 then
							arg_148_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_148_1.settingData.music_time), function()
								if arg_148_1 == nil or isNil(arg_148_1.bgmTxt_) then
									return
								end

								arg_148_1.musicController:SetSelectedState("hide")
								arg_148_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end
		end

		arg_148_1.nodeConfigList_ = {}

		arg_148_1:InitPlayNodeList()
	end,
	Play116361034 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 116361034
		arg_156_1.duration_ = 23.2

		SetActive(arg_156_1.tipsGo_, false)

		function arg_156_1.onSingleLineFinish_()
			arg_156_1.onSingleLineUpdate_ = nil
			arg_156_1.onSingleLineFinish_ = nil
			arg_156_1.state_ = "waiting"
		end

		function arg_156_1.playNext_(arg_158_0)
			if arg_158_0 == 1 then
				arg_156_0:Play116361035(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			local var_159_0 = 0
			local var_159_1 = 1

			if var_159_0 < arg_156_1.time_ and arg_156_1.time_ <= var_159_0 + arg_159_0 then
				local var_159_2 = "play"
				local var_159_3 = "effect"

				arg_156_1:AudioAction(var_159_2, var_159_3, "se_story_16", "se_story_16_whoosh", "")
			end

			local var_159_4 = 2

			if var_159_4 < arg_156_1.time_ and arg_156_1.time_ <= var_159_4 + arg_159_0 then
				local var_159_5 = manager.ui.mainCamera.transform.localPosition
				local var_159_6 = Vector3.New(0, 0, 10) + Vector3.New(var_159_5.x, var_159_5.y, 0)
				local var_159_7 = arg_156_1.bgs_.ST03_blur

				var_159_7.transform.localPosition = var_159_6
				var_159_7.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_159_8 = var_159_7:GetComponent("SpriteRenderer")

				if var_159_8 and var_159_8.sprite then
					local var_159_9 = (var_159_7.transform.localPosition - var_159_5).z
					local var_159_10 = manager.ui.mainCameraCom_
					local var_159_11 = 2 * var_159_9 * Mathf.Tan(var_159_10.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_159_12 = var_159_11 * var_159_10.aspect
					local var_159_13 = var_159_8.sprite.bounds.size.x
					local var_159_14 = var_159_8.sprite.bounds.size.y
					local var_159_15 = var_159_12 / var_159_13
					local var_159_16 = var_159_11 / var_159_14
					local var_159_17 = var_159_16 < var_159_15 and var_159_15 or var_159_16

					var_159_7.transform.localScale = Vector3.New(var_159_17, var_159_17, 0)
				end

				for iter_159_0, iter_159_1 in pairs(arg_156_1.bgs_) do
					if iter_159_0 ~= "ST03_blur" then
						iter_159_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_159_18 = 9

			if var_159_18 < arg_156_1.time_ and arg_156_1.time_ <= var_159_18 + arg_159_0 then
				local var_159_19 = manager.ui.mainCamera.transform.localPosition
				local var_159_20 = Vector3.New(0, 0, 10) + Vector3.New(var_159_19.x, var_159_19.y, 0)
				local var_159_21 = arg_156_1.bgs_.I05

				var_159_21.transform.localPosition = var_159_20
				var_159_21.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_159_22 = var_159_21:GetComponent("SpriteRenderer")

				if var_159_22 and var_159_22.sprite then
					local var_159_23 = (var_159_21.transform.localPosition - var_159_19).z
					local var_159_24 = manager.ui.mainCameraCom_
					local var_159_25 = 2 * var_159_23 * Mathf.Tan(var_159_24.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_159_26 = var_159_25 * var_159_24.aspect
					local var_159_27 = var_159_22.sprite.bounds.size.x
					local var_159_28 = var_159_22.sprite.bounds.size.y
					local var_159_29 = var_159_26 / var_159_27
					local var_159_30 = var_159_25 / var_159_28
					local var_159_31 = var_159_30 < var_159_29 and var_159_29 or var_159_30

					var_159_21.transform.localScale = Vector3.New(var_159_31, var_159_31, 0)
				end

				for iter_159_2, iter_159_3 in pairs(arg_156_1.bgs_) do
					if iter_159_2 ~= "I05" then
						iter_159_3.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_159_32 = 16.2

			if var_159_32 < arg_156_1.time_ and arg_156_1.time_ <= var_159_32 + arg_159_0 then
				local var_159_33 = manager.ui.mainCamera.transform.localPosition
				local var_159_34 = Vector3.New(0, 0, 10) + Vector3.New(var_159_33.x, var_159_33.y, 0)
				local var_159_35 = arg_156_1.bgs_.ST15

				var_159_35.transform.localPosition = var_159_34
				var_159_35.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_159_36 = var_159_35:GetComponent("SpriteRenderer")

				if var_159_36 and var_159_36.sprite then
					local var_159_37 = (var_159_35.transform.localPosition - var_159_33).z
					local var_159_38 = manager.ui.mainCameraCom_
					local var_159_39 = 2 * var_159_37 * Mathf.Tan(var_159_38.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_159_40 = var_159_39 * var_159_38.aspect
					local var_159_41 = var_159_36.sprite.bounds.size.x
					local var_159_42 = var_159_36.sprite.bounds.size.y
					local var_159_43 = var_159_40 / var_159_41
					local var_159_44 = var_159_39 / var_159_42
					local var_159_45 = var_159_44 < var_159_43 and var_159_43 or var_159_44

					var_159_35.transform.localScale = Vector3.New(var_159_45, var_159_45, 0)
				end

				for iter_159_4, iter_159_5 in pairs(arg_156_1.bgs_) do
					if iter_159_4 ~= "ST15" then
						iter_159_5.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_159_46 = 0

			if var_159_46 < arg_156_1.time_ and arg_156_1.time_ <= var_159_46 + arg_159_0 then
				arg_156_1.mask_.enabled = true
				arg_156_1.mask_.raycastTarget = true

				arg_156_1:SetGaussion(false)
			end

			local var_159_47 = 2

			if var_159_46 <= arg_156_1.time_ and arg_156_1.time_ < var_159_46 + var_159_47 then
				local var_159_48 = (arg_156_1.time_ - var_159_46) / var_159_47
				local var_159_49 = Color.New(0, 0, 0)

				var_159_49.a = Mathf.Lerp(0, 1, var_159_48)
				arg_156_1.mask_.color = var_159_49
			end

			if arg_156_1.time_ >= var_159_46 + var_159_47 and arg_156_1.time_ < var_159_46 + var_159_47 + arg_159_0 then
				local var_159_50 = Color.New(0, 0, 0)

				var_159_50.a = 1
				arg_156_1.mask_.color = var_159_50
			end

			local var_159_51 = 2

			if var_159_51 < arg_156_1.time_ and arg_156_1.time_ <= var_159_51 + arg_159_0 then
				arg_156_1.mask_.enabled = true
				arg_156_1.mask_.raycastTarget = true

				arg_156_1:SetGaussion(false)
			end

			local var_159_52 = 5

			if var_159_51 <= arg_156_1.time_ and arg_156_1.time_ < var_159_51 + var_159_52 then
				local var_159_53 = (arg_156_1.time_ - var_159_51) / var_159_52
				local var_159_54 = Color.New(1, 1, 1)

				var_159_54.a = Mathf.Lerp(1, 0, var_159_53)
				arg_156_1.mask_.color = var_159_54
			end

			if arg_156_1.time_ >= var_159_51 + var_159_52 and arg_156_1.time_ < var_159_51 + var_159_52 + arg_159_0 then
				local var_159_55 = Color.New(1, 1, 1)
				local var_159_56 = 0

				arg_156_1.mask_.enabled = false
				var_159_55.a = var_159_56
				arg_156_1.mask_.color = var_159_55
			end

			local var_159_57 = 9

			if var_159_57 < arg_156_1.time_ and arg_156_1.time_ <= var_159_57 + arg_159_0 then
				arg_156_1.mask_.enabled = true
				arg_156_1.mask_.raycastTarget = true

				arg_156_1:SetGaussion(false)
			end

			local var_159_58 = 5

			if var_159_57 <= arg_156_1.time_ and arg_156_1.time_ < var_159_57 + var_159_58 then
				local var_159_59 = (arg_156_1.time_ - var_159_57) / var_159_58
				local var_159_60 = Color.New(1, 1, 1)

				var_159_60.a = Mathf.Lerp(1, 0, var_159_59)
				arg_156_1.mask_.color = var_159_60
			end

			if arg_156_1.time_ >= var_159_57 + var_159_58 and arg_156_1.time_ < var_159_57 + var_159_58 + arg_159_0 then
				local var_159_61 = Color.New(1, 1, 1)
				local var_159_62 = 0

				arg_156_1.mask_.enabled = false
				var_159_61.a = var_159_62
				arg_156_1.mask_.color = var_159_61
			end

			local var_159_63 = 16.2

			if var_159_63 < arg_156_1.time_ and arg_156_1.time_ <= var_159_63 + arg_159_0 then
				arg_156_1.mask_.enabled = true
				arg_156_1.mask_.raycastTarget = true

				arg_156_1:SetGaussion(false)
			end

			local var_159_64 = 5

			if var_159_63 <= arg_156_1.time_ and arg_156_1.time_ < var_159_63 + var_159_64 then
				local var_159_65 = (arg_156_1.time_ - var_159_63) / var_159_64
				local var_159_66 = Color.New(1, 1, 1)

				var_159_66.a = Mathf.Lerp(1, 0, var_159_65)
				arg_156_1.mask_.color = var_159_66
			end

			if arg_156_1.time_ >= var_159_63 + var_159_64 and arg_156_1.time_ < var_159_63 + var_159_64 + arg_159_0 then
				local var_159_67 = Color.New(1, 1, 1)
				local var_159_68 = 0

				arg_156_1.mask_.enabled = false
				var_159_67.a = var_159_68
				arg_156_1.mask_.color = var_159_67
			end

			local var_159_69 = "ST03_blur"

			if arg_156_1.bgs_[var_159_69] == nil then
				local var_159_70 = Object.Instantiate(arg_156_1.blurPaintGo_)
				local var_159_71 = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_159_69)

				var_159_70:GetComponent("SpriteRenderer").sprite = var_159_71
				var_159_70.name = var_159_69
				var_159_70.transform.parent = arg_156_1.stage_.transform
				var_159_70.transform.localPosition = Vector3.New(0, 100, 0)
				arg_156_1.bgs_[var_159_69] = var_159_70
			end

			local var_159_72 = 2
			local var_159_73 = arg_156_1.bgs_[var_159_69]

			if var_159_72 < arg_156_1.time_ and arg_156_1.time_ <= var_159_72 + arg_159_0 then
				local var_159_74 = manager.ui.mainCamera.transform.localPosition
				local var_159_75 = Vector3.New(0, 0, 10) + Vector3.New(var_159_74.x, var_159_74.y, 0)

				var_159_73.transform.localPosition = var_159_75
				var_159_73.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_159_76 = var_159_73:GetComponent("SpriteRenderer")

				if var_159_76 and var_159_76.sprite then
					local var_159_77 = (var_159_73.transform.localPosition - var_159_74).z
					local var_159_78 = manager.ui.mainCameraCom_
					local var_159_79 = 2 * var_159_77 * Mathf.Tan(var_159_78.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_159_80 = var_159_79 * var_159_78.aspect
					local var_159_81 = var_159_76.sprite.bounds.size.x
					local var_159_82 = var_159_76.sprite.bounds.size.y
					local var_159_83 = var_159_80 / var_159_81
					local var_159_84 = var_159_79 / var_159_82
					local var_159_85 = var_159_84 < var_159_83 and var_159_83 or var_159_84

					var_159_73.transform.localScale = Vector3.New(var_159_85, var_159_85, 0)
				end
			end

			local var_159_86 = 7

			if var_159_72 <= arg_156_1.time_ and arg_156_1.time_ < var_159_72 + var_159_86 then
				local var_159_87 = (arg_156_1.time_ - var_159_72) / var_159_86
				local var_159_88 = Color.New(1, 1, 1)

				var_159_88.a = Mathf.Lerp(0, 1, var_159_87)

				var_159_73:GetComponent("SpriteRenderer").material:SetColor("_Color", var_159_88)
			end

			local var_159_89 = "I05_blur"

			if arg_156_1.bgs_[var_159_89] == nil then
				local var_159_90 = Object.Instantiate(arg_156_1.blurPaintGo_)
				local var_159_91 = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_159_89)

				var_159_90:GetComponent("SpriteRenderer").sprite = var_159_91
				var_159_90.name = var_159_89
				var_159_90.transform.parent = arg_156_1.stage_.transform
				var_159_90.transform.localPosition = Vector3.New(0, 100, 0)
				arg_156_1.bgs_[var_159_89] = var_159_90
			end

			local var_159_92 = 9
			local var_159_93 = arg_156_1.bgs_[var_159_89]

			if var_159_92 < arg_156_1.time_ and arg_156_1.time_ <= var_159_92 + arg_159_0 then
				local var_159_94 = manager.ui.mainCamera.transform.localPosition
				local var_159_95 = Vector3.New(0, 0, 10) + Vector3.New(var_159_94.x, var_159_94.y, 0)

				var_159_93.transform.localPosition = var_159_95
				var_159_93.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_159_96 = var_159_93:GetComponent("SpriteRenderer")

				if var_159_96 and var_159_96.sprite then
					local var_159_97 = (var_159_93.transform.localPosition - var_159_94).z
					local var_159_98 = manager.ui.mainCameraCom_
					local var_159_99 = 2 * var_159_97 * Mathf.Tan(var_159_98.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_159_100 = var_159_99 * var_159_98.aspect
					local var_159_101 = var_159_96.sprite.bounds.size.x
					local var_159_102 = var_159_96.sprite.bounds.size.y
					local var_159_103 = var_159_100 / var_159_101
					local var_159_104 = var_159_99 / var_159_102
					local var_159_105 = var_159_104 < var_159_103 and var_159_103 or var_159_104

					var_159_93.transform.localScale = Vector3.New(var_159_105, var_159_105, 0)
				end
			end

			local var_159_106 = 7.2

			if var_159_92 <= arg_156_1.time_ and arg_156_1.time_ < var_159_92 + var_159_106 then
				local var_159_107 = (arg_156_1.time_ - var_159_92) / var_159_106
				local var_159_108 = Color.New(1, 1, 1)

				var_159_108.a = Mathf.Lerp(0, 1, var_159_107)

				var_159_93:GetComponent("SpriteRenderer").material:SetColor("_Color", var_159_108)
			end

			local var_159_109 = "ST15_blur"

			if arg_156_1.bgs_[var_159_109] == nil then
				local var_159_110 = Object.Instantiate(arg_156_1.blurPaintGo_)
				local var_159_111 = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_159_109)

				var_159_110:GetComponent("SpriteRenderer").sprite = var_159_111
				var_159_110.name = var_159_109
				var_159_110.transform.parent = arg_156_1.stage_.transform
				var_159_110.transform.localPosition = Vector3.New(0, 100, 0)
				arg_156_1.bgs_[var_159_109] = var_159_110
			end

			local var_159_112 = 16.2
			local var_159_113 = arg_156_1.bgs_[var_159_109]

			if var_159_112 < arg_156_1.time_ and arg_156_1.time_ <= var_159_112 + arg_159_0 then
				local var_159_114 = manager.ui.mainCamera.transform.localPosition
				local var_159_115 = Vector3.New(0, 0, 10) + Vector3.New(var_159_114.x, var_159_114.y, 0)

				var_159_113.transform.localPosition = var_159_115
				var_159_113.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_159_116 = var_159_113:GetComponent("SpriteRenderer")

				if var_159_116 and var_159_116.sprite then
					local var_159_117 = (var_159_113.transform.localPosition - var_159_114).z
					local var_159_118 = manager.ui.mainCameraCom_
					local var_159_119 = 2 * var_159_117 * Mathf.Tan(var_159_118.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_159_120 = var_159_119 * var_159_118.aspect
					local var_159_121 = var_159_116.sprite.bounds.size.x
					local var_159_122 = var_159_116.sprite.bounds.size.y
					local var_159_123 = var_159_120 / var_159_121
					local var_159_124 = var_159_119 / var_159_122
					local var_159_125 = var_159_124 < var_159_123 and var_159_123 or var_159_124

					var_159_113.transform.localScale = Vector3.New(var_159_125, var_159_125, 0)
				end
			end

			local var_159_126 = 7

			if var_159_112 <= arg_156_1.time_ and arg_156_1.time_ < var_159_112 + var_159_126 then
				local var_159_127 = (arg_156_1.time_ - var_159_112) / var_159_126
				local var_159_128 = Color.New(1, 1, 1)

				var_159_128.a = Mathf.Lerp(0, 1, var_159_127)

				var_159_113:GetComponent("SpriteRenderer").material:SetColor("_Color", var_159_128)
			end

			local var_159_129 = 0

			if var_159_129 < arg_156_1.time_ and arg_156_1.time_ <= var_159_129 + arg_159_0 then
				arg_156_1.fswbg_:SetActive(true)
				arg_156_1.dialog_:SetActive(false)

				arg_156_1.fswtw_.percent = 0

				local var_159_130 = arg_156_1:GetWordFromCfg(116361034)
				local var_159_131 = arg_156_1:FormatText(var_159_130.content)

				arg_156_1.fswt_.text = var_159_131

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.fswt_)

				arg_156_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_156_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_156_1.fswtw_:SetDirty()

				arg_156_1.typewritterCharCountI18N = 0

				SetActive(arg_156_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_156_1:ShowNextGo(false)
			end

			local var_159_132 = 2

			if var_159_132 < arg_156_1.time_ and arg_156_1.time_ <= var_159_132 + arg_159_0 then
				arg_156_1.var_.oldValueTypewriter = arg_156_1.fswtw_.percent

				SetActive(arg_156_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_156_1:ShowNextGo(false)
			end

			local var_159_133 = 2
			local var_159_134 = 0.133333333333333
			local var_159_135 = arg_156_1:GetWordFromCfg(116361034)
			local var_159_136 = arg_156_1:FormatText(var_159_135.content)
			local var_159_137, var_159_138 = arg_156_1:GetPercentByPara(var_159_136, 1)

			if var_159_132 < arg_156_1.time_ and arg_156_1.time_ <= var_159_132 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0

				local var_159_139 = var_159_133 <= 0 and var_159_134 or var_159_134 * ((var_159_138 - arg_156_1.typewritterCharCountI18N) / var_159_133)

				if var_159_139 > 0 and var_159_134 < var_159_139 then
					arg_156_1.talkMaxDuration = var_159_139

					if var_159_139 + var_159_132 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_139 + var_159_132
					end
				end
			end

			local var_159_140 = 0.133333333333333
			local var_159_141 = math.max(var_159_140, arg_156_1.talkMaxDuration)

			if var_159_132 <= arg_156_1.time_ and arg_156_1.time_ < var_159_132 + var_159_141 then
				local var_159_142 = (arg_156_1.time_ - var_159_132) / var_159_141

				arg_156_1.fswtw_.percent = Mathf.Lerp(arg_156_1.var_.oldValueTypewriter, var_159_137, var_159_142)
				arg_156_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_156_1.fswtw_:SetDirty()
			end

			if arg_156_1.time_ >= var_159_132 + var_159_141 and arg_156_1.time_ < var_159_132 + var_159_141 + arg_159_0 then
				arg_156_1.fswtw_.percent = var_159_137

				arg_156_1.fswtw_:SetDirty()
				arg_156_1:ShowNextGo(true)

				arg_156_1.typewritterCharCountI18N = var_159_138
			end

			local var_159_143 = 2

			if var_159_143 < arg_156_1.time_ and arg_156_1.time_ <= var_159_143 + arg_159_0 then
				arg_156_1.allBtn_.enabled = false
			end

			local var_159_144 = 21.2

			if arg_156_1.time_ >= var_159_143 + var_159_144 and arg_156_1.time_ < var_159_143 + var_159_144 + arg_159_0 then
				arg_156_1.allBtn_.enabled = true
			end
		end

		arg_156_1.nodeConfigList_ = {}

		arg_156_1:InitPlayNodeList()
	end,
	Play116361035 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 116361035
		arg_160_1.duration_ = 4.69

		SetActive(arg_160_1.tipsGo_, false)

		function arg_160_1.onSingleLineFinish_()
			arg_160_1.onSingleLineUpdate_ = nil
			arg_160_1.onSingleLineFinish_ = nil
			arg_160_1.state_ = "waiting"
		end

		function arg_160_1.playNext_(arg_162_0)
			if arg_162_0 == 1 then
				arg_160_0:Play116361036(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			local var_163_0 = "STwhite"

			if arg_160_1.bgs_[var_163_0] == nil then
				local var_163_1 = Object.Instantiate(arg_160_1.paintGo_)

				var_163_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_163_0)
				var_163_1.name = var_163_0
				var_163_1.transform.parent = arg_160_1.stage_.transform
				var_163_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_160_1.bgs_[var_163_0] = var_163_1
			end

			local var_163_2 = 0

			if var_163_2 < arg_160_1.time_ and arg_160_1.time_ <= var_163_2 + arg_163_0 then
				local var_163_3 = manager.ui.mainCamera.transform.localPosition
				local var_163_4 = Vector3.New(0, 0, 10) + Vector3.New(var_163_3.x, var_163_3.y, 0)
				local var_163_5 = arg_160_1.bgs_.STwhite

				var_163_5.transform.localPosition = var_163_4
				var_163_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_163_6 = var_163_5:GetComponent("SpriteRenderer")

				if var_163_6 and var_163_6.sprite then
					local var_163_7 = (var_163_5.transform.localPosition - var_163_3).z
					local var_163_8 = manager.ui.mainCameraCom_
					local var_163_9 = 2 * var_163_7 * Mathf.Tan(var_163_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_163_10 = var_163_9 * var_163_8.aspect
					local var_163_11 = var_163_6.sprite.bounds.size.x
					local var_163_12 = var_163_6.sprite.bounds.size.y
					local var_163_13 = var_163_10 / var_163_11
					local var_163_14 = var_163_9 / var_163_12
					local var_163_15 = var_163_14 < var_163_13 and var_163_13 or var_163_14

					var_163_5.transform.localScale = Vector3.New(var_163_15, var_163_15, 0)
				end

				for iter_163_0, iter_163_1 in pairs(arg_160_1.bgs_) do
					if iter_163_0 ~= "STwhite" then
						iter_163_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_163_16 = 0

			if var_163_16 < arg_160_1.time_ and arg_160_1.time_ <= var_163_16 + arg_163_0 then
				arg_160_1.mask_.enabled = true
				arg_160_1.mask_.raycastTarget = true

				arg_160_1:SetGaussion(false)
			end

			local var_163_17 = 2

			if var_163_16 <= arg_160_1.time_ and arg_160_1.time_ < var_163_16 + var_163_17 then
				local var_163_18 = (arg_160_1.time_ - var_163_16) / var_163_17
				local var_163_19 = Color.New(0, 0, 0)

				var_163_19.a = Mathf.Lerp(1, 0, var_163_18)
				arg_160_1.mask_.color = var_163_19
			end

			if arg_160_1.time_ >= var_163_16 + var_163_17 and arg_160_1.time_ < var_163_16 + var_163_17 + arg_163_0 then
				local var_163_20 = Color.New(0, 0, 0)
				local var_163_21 = 0

				arg_160_1.mask_.enabled = false
				var_163_20.a = var_163_21
				arg_160_1.mask_.color = var_163_20
			end

			local var_163_22 = 0

			if var_163_22 < arg_160_1.time_ and arg_160_1.time_ <= var_163_22 + arg_163_0 then
				arg_160_1.fswbg_:SetActive(true)
				arg_160_1.dialog_:SetActive(false)

				arg_160_1.fswtw_.percent = 0

				local var_163_23 = arg_160_1:GetWordFromCfg(116361035)
				local var_163_24 = arg_160_1:FormatText(var_163_23.content)

				arg_160_1.fswt_.text = var_163_24

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.fswt_)

				arg_160_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_160_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_160_1.fswtw_:SetDirty()

				arg_160_1.typewritterCharCountI18N = 0

				SetActive(arg_160_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_160_1:ShowNextGo(false)
			end

			local var_163_25 = 2

			if var_163_25 < arg_160_1.time_ and arg_160_1.time_ <= var_163_25 + arg_163_0 then
				arg_160_1.var_.oldValueTypewriter = arg_160_1.fswtw_.percent

				SetActive(arg_160_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_160_1:ShowNextGo(false)
			end

			local var_163_26 = 12
			local var_163_27 = 0.8
			local var_163_28 = arg_160_1:GetWordFromCfg(116361035)
			local var_163_29 = arg_160_1:FormatText(var_163_28.content)
			local var_163_30, var_163_31 = arg_160_1:GetPercentByPara(var_163_29, 1)

			if var_163_25 < arg_160_1.time_ and arg_160_1.time_ <= var_163_25 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0

				local var_163_32 = var_163_26 <= 0 and var_163_27 or var_163_27 * ((var_163_31 - arg_160_1.typewritterCharCountI18N) / var_163_26)

				if var_163_32 > 0 and var_163_27 < var_163_32 then
					arg_160_1.talkMaxDuration = var_163_32

					if var_163_32 + var_163_25 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_32 + var_163_25
					end
				end
			end

			local var_163_33 = 0.8
			local var_163_34 = math.max(var_163_33, arg_160_1.talkMaxDuration)

			if var_163_25 <= arg_160_1.time_ and arg_160_1.time_ < var_163_25 + var_163_34 then
				local var_163_35 = (arg_160_1.time_ - var_163_25) / var_163_34

				arg_160_1.fswtw_.percent = Mathf.Lerp(arg_160_1.var_.oldValueTypewriter, var_163_30, var_163_35)
				arg_160_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_160_1.fswtw_:SetDirty()
			end

			if arg_160_1.time_ >= var_163_25 + var_163_34 and arg_160_1.time_ < var_163_25 + var_163_34 + arg_163_0 then
				arg_160_1.fswtw_.percent = var_163_30

				arg_160_1.fswtw_:SetDirty()
				arg_160_1:ShowNextGo(true)

				arg_160_1.typewritterCharCountI18N = var_163_31
			end

			local var_163_36 = 2

			if var_163_36 < arg_160_1.time_ and arg_160_1.time_ <= var_163_36 + arg_163_0 then
				local var_163_37 = arg_160_1.fswbg_.transform:Find("textbox/adapt/content") or arg_160_1.fswbg_.transform:Find("textbox/content")
				local var_163_38 = arg_160_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_163_39 = var_163_37:GetComponent("Text")
				local var_163_40 = var_163_37:GetComponent("RectTransform")

				var_163_39.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_163_40.offsetMin = Vector2.New(0, 0)
				var_163_40.offsetMax = Vector2.New(0, 0)
			end

			local var_163_41 = 2
			local var_163_42 = 2.695
			local var_163_43 = manager.audio:GetVoiceLength("story_v_out_116361", "116361035", "story_v_out_116361.awb") / 1000

			if var_163_43 > 0 and var_163_42 < var_163_43 and var_163_43 + var_163_41 > arg_160_1.duration_ then
				local var_163_44 = var_163_43

				arg_160_1.duration_ = var_163_43 + var_163_41
			end

			if var_163_41 < arg_160_1.time_ and arg_160_1.time_ <= var_163_41 + arg_163_0 then
				local var_163_45 = "play"
				local var_163_46 = "voice"

				arg_160_1:AudioAction(var_163_45, var_163_46, "story_v_out_116361", "116361035", "story_v_out_116361.awb")
			end

			local var_163_47 = 0
			local var_163_48 = 0.666666666666667

			if var_163_47 < arg_160_1.time_ and arg_160_1.time_ <= var_163_47 + arg_163_0 then
				local var_163_49 = "play"
				local var_163_50 = "music"

				arg_160_1:AudioAction(var_163_49, var_163_50, "ui_battle", "ui_battle_stopbgm", "")

				local var_163_51 = ""
				local var_163_52 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_163_52 ~= "" then
					if arg_160_1.bgmTxt_.text ~= var_163_52 and arg_160_1.bgmTxt_.text ~= "" then
						if arg_160_1.bgmTxt2_.text ~= "" then
							arg_160_1.bgmTxt_.text = arg_160_1.bgmTxt2_.text
						end

						arg_160_1.bgmTxt2_.text = var_163_52

						arg_160_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_160_1.bgmTxt_.text = var_163_52
						arg_160_1.bgmTxt2_.text = var_163_52
					end

					if arg_160_1.bgmTimer then
						arg_160_1.bgmTimer:Stop()

						arg_160_1.bgmTimer = nil
					end

					if arg_160_1.settingData.show_music_name == 1 then
						arg_160_1.musicController:SetSelectedState("show")
						arg_160_1.musicAnimator_:Play("open", 0, 0)

						if arg_160_1.settingData.music_time ~= 0 then
							arg_160_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_160_1.settingData.music_time), function()
								if arg_160_1 == nil or isNil(arg_160_1.bgmTxt_) then
									return
								end

								arg_160_1.musicController:SetSelectedState("hide")
								arg_160_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end
		end

		arg_160_1.nodeConfigList_ = {}

		arg_160_1:InitPlayNodeList()
	end,
	Play116361036 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 116361036
		arg_165_1.duration_ = 5.09

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play116361037(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = 0

			if var_168_0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_0 + arg_168_0 then
				arg_165_1.fswbg_:SetActive(true)
				arg_165_1.dialog_:SetActive(false)

				arg_165_1.fswtw_.percent = 0

				local var_168_1 = arg_165_1:GetWordFromCfg(116361036)
				local var_168_2 = arg_165_1:FormatText(var_168_1.content)

				arg_165_1.fswt_.text = var_168_2

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.fswt_)

				arg_165_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_165_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_165_1.fswtw_:SetDirty()

				arg_165_1.typewritterCharCountI18N = 0

				SetActive(arg_165_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_165_1:ShowNextGo(false)
			end

			local var_168_3 = 0.0166666666666666

			if var_168_3 < arg_165_1.time_ and arg_165_1.time_ <= var_168_3 + arg_168_0 then
				arg_165_1.var_.oldValueTypewriter = arg_165_1.fswtw_.percent

				SetActive(arg_165_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_165_1:ShowNextGo(false)
			end

			local var_168_4 = 10
			local var_168_5 = 0.666666666666667
			local var_168_6 = arg_165_1:GetWordFromCfg(116361036)
			local var_168_7 = arg_165_1:FormatText(var_168_6.content)
			local var_168_8, var_168_9 = arg_165_1:GetPercentByPara(var_168_7, 1)

			if var_168_3 < arg_165_1.time_ and arg_165_1.time_ <= var_168_3 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0

				local var_168_10 = var_168_4 <= 0 and var_168_5 or var_168_5 * ((var_168_9 - arg_165_1.typewritterCharCountI18N) / var_168_4)

				if var_168_10 > 0 and var_168_5 < var_168_10 then
					arg_165_1.talkMaxDuration = var_168_10

					if var_168_10 + var_168_3 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_10 + var_168_3
					end
				end
			end

			local var_168_11 = 0.666666666666667
			local var_168_12 = math.max(var_168_11, arg_165_1.talkMaxDuration)

			if var_168_3 <= arg_165_1.time_ and arg_165_1.time_ < var_168_3 + var_168_12 then
				local var_168_13 = (arg_165_1.time_ - var_168_3) / var_168_12

				arg_165_1.fswtw_.percent = Mathf.Lerp(arg_165_1.var_.oldValueTypewriter, var_168_8, var_168_13)
				arg_165_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_165_1.fswtw_:SetDirty()
			end

			if arg_165_1.time_ >= var_168_3 + var_168_12 and arg_165_1.time_ < var_168_3 + var_168_12 + arg_168_0 then
				arg_165_1.fswtw_.percent = var_168_8

				arg_165_1.fswtw_:SetDirty()
				arg_165_1:ShowNextGo(true)

				arg_165_1.typewritterCharCountI18N = var_168_9
			end

			local var_168_14 = 2

			if var_168_14 < arg_165_1.time_ and arg_165_1.time_ <= var_168_14 + arg_168_0 then
				arg_165_1.fswbg_:SetActive(true)
				arg_165_1.dialog_:SetActive(false)

				arg_165_1.fswtw_.percent = 0

				local var_168_15 = arg_165_1:GetWordFromCfg(116361036)
				local var_168_16 = arg_165_1:FormatText(var_168_15.content)

				arg_165_1.fswt_.text = var_168_16

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.fswt_)

				arg_165_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_165_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_165_1.fswtw_:SetDirty()

				arg_165_1.typewritterCharCountI18N = 0

				SetActive(arg_165_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_165_1:ShowNextGo(false)
			end

			local var_168_17 = 0

			if var_168_17 < arg_165_1.time_ and arg_165_1.time_ <= var_168_17 + arg_168_0 then
				local var_168_18 = arg_165_1.fswbg_.transform:Find("textbox/adapt/content") or arg_165_1.fswbg_.transform:Find("textbox/content")
				local var_168_19 = arg_165_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_168_20 = var_168_18:GetComponent("Text")
				local var_168_21 = var_168_18:GetComponent("RectTransform")

				var_168_20.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_168_21.offsetMin = Vector2.New(0, 0)
				var_168_21.offsetMax = Vector2.New(0, 0)
			end

			local var_168_22 = 0
			local var_168_23 = 3.093
			local var_168_24 = manager.audio:GetVoiceLength("story_v_out_116361", "116361036", "story_v_out_116361.awb") / 1000

			if var_168_24 > 0 and var_168_23 < var_168_24 and var_168_24 + var_168_22 > arg_165_1.duration_ then
				local var_168_25 = var_168_24

				arg_165_1.duration_ = var_168_24 + var_168_22
			end

			if var_168_22 < arg_165_1.time_ and arg_165_1.time_ <= var_168_22 + arg_168_0 then
				local var_168_26 = "play"
				local var_168_27 = "voice"

				arg_165_1:AudioAction(var_168_26, var_168_27, "story_v_out_116361", "116361036", "story_v_out_116361.awb")
			end

			local var_168_28 = 0

			if var_168_28 < arg_165_1.time_ and arg_165_1.time_ <= var_168_28 + arg_168_0 then
				arg_165_1.allBtn_.enabled = false
			end

			local var_168_29 = 0.683333333333333

			if arg_165_1.time_ >= var_168_28 + var_168_29 and arg_165_1.time_ < var_168_28 + var_168_29 + arg_168_0 then
				arg_165_1.allBtn_.enabled = true
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play116361037 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 116361037
		arg_169_1.duration_ = 11.59

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play116361038(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = 0

			if var_172_0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_0 + arg_172_0 then
				arg_169_1.fswbg_:SetActive(true)
				arg_169_1.dialog_:SetActive(false)

				arg_169_1.fswtw_.percent = 0

				local var_172_1 = arg_169_1:GetWordFromCfg(116361037)
				local var_172_2 = arg_169_1:FormatText(var_172_1.content)

				arg_169_1.fswt_.text = var_172_2

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.fswt_)

				arg_169_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_169_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_169_1.fswtw_:SetDirty()

				arg_169_1.typewritterCharCountI18N = 0

				SetActive(arg_169_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_169_1:ShowNextGo(false)
			end

			local var_172_3 = 0

			if var_172_3 < arg_169_1.time_ and arg_169_1.time_ <= var_172_3 + arg_172_0 then
				arg_169_1.var_.oldValueTypewriter = arg_169_1.fswtw_.percent

				SetActive(arg_169_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_169_1:ShowNextGo(false)
			end

			local var_172_4 = 32
			local var_172_5 = 2.13333333333333
			local var_172_6 = arg_169_1:GetWordFromCfg(116361037)
			local var_172_7 = arg_169_1:FormatText(var_172_6.content)
			local var_172_8, var_172_9 = arg_169_1:GetPercentByPara(var_172_7, 1)

			if var_172_3 < arg_169_1.time_ and arg_169_1.time_ <= var_172_3 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0

				local var_172_10 = var_172_4 <= 0 and var_172_5 or var_172_5 * ((var_172_9 - arg_169_1.typewritterCharCountI18N) / var_172_4)

				if var_172_10 > 0 and var_172_5 < var_172_10 then
					arg_169_1.talkMaxDuration = var_172_10

					if var_172_10 + var_172_3 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_10 + var_172_3
					end
				end
			end

			local var_172_11 = 2.13333333333333
			local var_172_12 = math.max(var_172_11, arg_169_1.talkMaxDuration)

			if var_172_3 <= arg_169_1.time_ and arg_169_1.time_ < var_172_3 + var_172_12 then
				local var_172_13 = (arg_169_1.time_ - var_172_3) / var_172_12

				arg_169_1.fswtw_.percent = Mathf.Lerp(arg_169_1.var_.oldValueTypewriter, var_172_8, var_172_13)
				arg_169_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_169_1.fswtw_:SetDirty()
			end

			if arg_169_1.time_ >= var_172_3 + var_172_12 and arg_169_1.time_ < var_172_3 + var_172_12 + arg_172_0 then
				arg_169_1.fswtw_.percent = var_172_8

				arg_169_1.fswtw_:SetDirty()
				arg_169_1:ShowNextGo(true)

				arg_169_1.typewritterCharCountI18N = var_172_9
			end

			local var_172_14 = 0

			if var_172_14 < arg_169_1.time_ and arg_169_1.time_ <= var_172_14 + arg_172_0 then
				local var_172_15 = arg_169_1.fswbg_.transform:Find("textbox/adapt/content") or arg_169_1.fswbg_.transform:Find("textbox/content")
				local var_172_16 = arg_169_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_172_17 = var_172_15:GetComponent("Text")
				local var_172_18 = var_172_15:GetComponent("RectTransform")

				var_172_17.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_172_18.offsetMin = Vector2.New(0, 0)
				var_172_18.offsetMax = Vector2.New(0, 0)
			end

			local var_172_19 = 0
			local var_172_20 = 11.59
			local var_172_21 = manager.audio:GetVoiceLength("story_v_out_116361", "116361037", "story_v_out_116361.awb") / 1000

			if var_172_21 > 0 and var_172_20 < var_172_21 and var_172_21 + var_172_19 > arg_169_1.duration_ then
				local var_172_22 = var_172_21

				arg_169_1.duration_ = var_172_21 + var_172_19
			end

			if var_172_19 < arg_169_1.time_ and arg_169_1.time_ <= var_172_19 + arg_172_0 then
				local var_172_23 = "play"
				local var_172_24 = "voice"

				arg_169_1:AudioAction(var_172_23, var_172_24, "story_v_out_116361", "116361037", "story_v_out_116361.awb")
			end

			local var_172_25 = 0

			if var_172_25 < arg_169_1.time_ and arg_169_1.time_ <= var_172_25 + arg_172_0 then
				arg_169_1.allBtn_.enabled = false
			end

			local var_172_26 = 2.15

			if arg_169_1.time_ >= var_172_25 + var_172_26 and arg_169_1.time_ < var_172_25 + var_172_26 + arg_172_0 then
				arg_169_1.allBtn_.enabled = true
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play116361038 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 116361038
		arg_173_1.duration_ = 7.74

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play116361039(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = 0

			if var_176_0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_0 + arg_176_0 then
				arg_173_1.fswbg_:SetActive(true)
				arg_173_1.dialog_:SetActive(false)

				arg_173_1.fswtw_.percent = 0

				local var_176_1 = arg_173_1:GetWordFromCfg(116361038)
				local var_176_2 = arg_173_1:FormatText(var_176_1.content)

				arg_173_1.fswt_.text = var_176_2

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.fswt_)

				arg_173_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_173_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_173_1.fswtw_:SetDirty()

				arg_173_1.typewritterCharCountI18N = 0

				SetActive(arg_173_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_173_1:ShowNextGo(false)
			end

			local var_176_3 = 0.0166666666666666

			if var_176_3 < arg_173_1.time_ and arg_173_1.time_ <= var_176_3 + arg_176_0 then
				arg_173_1.var_.oldValueTypewriter = arg_173_1.fswtw_.percent

				SetActive(arg_173_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_173_1:ShowNextGo(false)
			end

			local var_176_4 = 25
			local var_176_5 = 1.66666666666667
			local var_176_6 = arg_173_1:GetWordFromCfg(116361038)
			local var_176_7 = arg_173_1:FormatText(var_176_6.content)
			local var_176_8, var_176_9 = arg_173_1:GetPercentByPara(var_176_7, 1)

			if var_176_3 < arg_173_1.time_ and arg_173_1.time_ <= var_176_3 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0

				local var_176_10 = var_176_4 <= 0 and var_176_5 or var_176_5 * ((var_176_9 - arg_173_1.typewritterCharCountI18N) / var_176_4)

				if var_176_10 > 0 and var_176_5 < var_176_10 then
					arg_173_1.talkMaxDuration = var_176_10

					if var_176_10 + var_176_3 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_10 + var_176_3
					end
				end
			end

			local var_176_11 = 1.66666666666667
			local var_176_12 = math.max(var_176_11, arg_173_1.talkMaxDuration)

			if var_176_3 <= arg_173_1.time_ and arg_173_1.time_ < var_176_3 + var_176_12 then
				local var_176_13 = (arg_173_1.time_ - var_176_3) / var_176_12

				arg_173_1.fswtw_.percent = Mathf.Lerp(arg_173_1.var_.oldValueTypewriter, var_176_8, var_176_13)
				arg_173_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_173_1.fswtw_:SetDirty()
			end

			if arg_173_1.time_ >= var_176_3 + var_176_12 and arg_173_1.time_ < var_176_3 + var_176_12 + arg_176_0 then
				arg_173_1.fswtw_.percent = var_176_8

				arg_173_1.fswtw_:SetDirty()
				arg_173_1:ShowNextGo(true)

				arg_173_1.typewritterCharCountI18N = var_176_9
			end

			local var_176_14 = 0

			if var_176_14 < arg_173_1.time_ and arg_173_1.time_ <= var_176_14 + arg_176_0 then
				local var_176_15 = arg_173_1.fswbg_.transform:Find("textbox/adapt/content") or arg_173_1.fswbg_.transform:Find("textbox/content")
				local var_176_16 = arg_173_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_176_17 = var_176_15:GetComponent("Text")
				local var_176_18 = var_176_15:GetComponent("RectTransform")

				var_176_17.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_176_18.offsetMin = Vector2.New(0, 0)
				var_176_18.offsetMax = Vector2.New(0, 0)
			end

			local var_176_19 = 0
			local var_176_20 = 7.744
			local var_176_21 = manager.audio:GetVoiceLength("story_v_out_116361", "116361038", "story_v_out_116361.awb") / 1000

			if var_176_21 > 0 and var_176_20 < var_176_21 and var_176_21 + var_176_19 > arg_173_1.duration_ then
				local var_176_22 = var_176_21

				arg_173_1.duration_ = var_176_21 + var_176_19
			end

			if var_176_19 < arg_173_1.time_ and arg_173_1.time_ <= var_176_19 + arg_176_0 then
				local var_176_23 = "play"
				local var_176_24 = "voice"

				arg_173_1:AudioAction(var_176_23, var_176_24, "story_v_out_116361", "116361038", "story_v_out_116361.awb")
			end

			local var_176_25 = 0

			if var_176_25 < arg_173_1.time_ and arg_173_1.time_ <= var_176_25 + arg_176_0 then
				arg_173_1.allBtn_.enabled = false
			end

			local var_176_26 = 1.68333333333333

			if arg_173_1.time_ >= var_176_25 + var_176_26 and arg_173_1.time_ < var_176_25 + var_176_26 + arg_176_0 then
				arg_173_1.allBtn_.enabled = true
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play116361039 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 116361039
		arg_177_1.duration_ = 9.7

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play116361040(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = 0

			if var_180_0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_0 + arg_180_0 then
				arg_177_1.fswbg_:SetActive(true)
				arg_177_1.dialog_:SetActive(false)

				arg_177_1.fswtw_.percent = 0

				local var_180_1 = arg_177_1:GetWordFromCfg(116361039)
				local var_180_2 = arg_177_1:FormatText(var_180_1.content)

				arg_177_1.fswt_.text = var_180_2

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.fswt_)

				arg_177_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_177_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_177_1.fswtw_:SetDirty()

				arg_177_1.typewritterCharCountI18N = 0

				SetActive(arg_177_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_177_1:ShowNextGo(false)
			end

			local var_180_3 = 0.0166666666666666

			if var_180_3 < arg_177_1.time_ and arg_177_1.time_ <= var_180_3 + arg_180_0 then
				arg_177_1.var_.oldValueTypewriter = arg_177_1.fswtw_.percent

				SetActive(arg_177_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_177_1:ShowNextGo(false)
			end

			local var_180_4 = 31
			local var_180_5 = 2.06666666666667
			local var_180_6 = arg_177_1:GetWordFromCfg(116361039)
			local var_180_7 = arg_177_1:FormatText(var_180_6.content)
			local var_180_8, var_180_9 = arg_177_1:GetPercentByPara(var_180_7, 1)

			if var_180_3 < arg_177_1.time_ and arg_177_1.time_ <= var_180_3 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0

				local var_180_10 = var_180_4 <= 0 and var_180_5 or var_180_5 * ((var_180_9 - arg_177_1.typewritterCharCountI18N) / var_180_4)

				if var_180_10 > 0 and var_180_5 < var_180_10 then
					arg_177_1.talkMaxDuration = var_180_10

					if var_180_10 + var_180_3 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_10 + var_180_3
					end
				end
			end

			local var_180_11 = 2.06666666666667
			local var_180_12 = math.max(var_180_11, arg_177_1.talkMaxDuration)

			if var_180_3 <= arg_177_1.time_ and arg_177_1.time_ < var_180_3 + var_180_12 then
				local var_180_13 = (arg_177_1.time_ - var_180_3) / var_180_12

				arg_177_1.fswtw_.percent = Mathf.Lerp(arg_177_1.var_.oldValueTypewriter, var_180_8, var_180_13)
				arg_177_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_177_1.fswtw_:SetDirty()
			end

			if arg_177_1.time_ >= var_180_3 + var_180_12 and arg_177_1.time_ < var_180_3 + var_180_12 + arg_180_0 then
				arg_177_1.fswtw_.percent = var_180_8

				arg_177_1.fswtw_:SetDirty()
				arg_177_1:ShowNextGo(true)

				arg_177_1.typewritterCharCountI18N = var_180_9
			end

			local var_180_14 = 0

			if var_180_14 < arg_177_1.time_ and arg_177_1.time_ <= var_180_14 + arg_180_0 then
				local var_180_15 = arg_177_1.fswbg_.transform:Find("textbox/adapt/content") or arg_177_1.fswbg_.transform:Find("textbox/content")
				local var_180_16 = arg_177_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_180_17 = var_180_15:GetComponent("Text")
				local var_180_18 = var_180_15:GetComponent("RectTransform")

				var_180_17.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_180_18.offsetMin = Vector2.New(0, 0)
				var_180_18.offsetMax = Vector2.New(0, 0)
			end

			local var_180_19 = 0
			local var_180_20 = 9.702
			local var_180_21 = manager.audio:GetVoiceLength("story_v_out_116361", "116361039", "story_v_out_116361.awb") / 1000

			if var_180_21 > 0 and var_180_20 < var_180_21 and var_180_21 + var_180_19 > arg_177_1.duration_ then
				local var_180_22 = var_180_21

				arg_177_1.duration_ = var_180_21 + var_180_19
			end

			if var_180_19 < arg_177_1.time_ and arg_177_1.time_ <= var_180_19 + arg_180_0 then
				local var_180_23 = "play"
				local var_180_24 = "voice"

				arg_177_1:AudioAction(var_180_23, var_180_24, "story_v_out_116361", "116361039", "story_v_out_116361.awb")
			end

			local var_180_25 = 0

			if var_180_25 < arg_177_1.time_ and arg_177_1.time_ <= var_180_25 + arg_180_0 then
				arg_177_1.allBtn_.enabled = false
			end

			local var_180_26 = 2.06666666666667

			if arg_177_1.time_ >= var_180_25 + var_180_26 and arg_177_1.time_ < var_180_25 + var_180_26 + arg_180_0 then
				arg_177_1.allBtn_.enabled = true
			end
		end

		arg_177_1.nodeConfigList_ = {}

		arg_177_1:InitPlayNodeList()
	end,
	Play116361040 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 116361040
		arg_181_1.duration_ = 14.84

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play116361041(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = 0

			if var_184_0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_0 + arg_184_0 then
				arg_181_1.fswbg_:SetActive(true)
				arg_181_1.dialog_:SetActive(false)

				arg_181_1.fswtw_.percent = 0

				local var_184_1 = arg_181_1:GetWordFromCfg(116361040)
				local var_184_2 = arg_181_1:FormatText(var_184_1.content)

				arg_181_1.fswt_.text = var_184_2

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.fswt_)

				arg_181_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_181_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_181_1.fswtw_:SetDirty()

				arg_181_1.typewritterCharCountI18N = 0

				SetActive(arg_181_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_181_1:ShowNextGo(false)
			end

			local var_184_3 = 0.0166666666666666

			if var_184_3 < arg_181_1.time_ and arg_181_1.time_ <= var_184_3 + arg_184_0 then
				arg_181_1.var_.oldValueTypewriter = arg_181_1.fswtw_.percent

				SetActive(arg_181_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_181_1:ShowNextGo(false)
			end

			local var_184_4 = 49
			local var_184_5 = 3.33333333333333
			local var_184_6 = arg_181_1:GetWordFromCfg(116361040)
			local var_184_7 = arg_181_1:FormatText(var_184_6.content)
			local var_184_8, var_184_9 = arg_181_1:GetPercentByPara(var_184_7, 1)

			if var_184_3 < arg_181_1.time_ and arg_181_1.time_ <= var_184_3 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0

				local var_184_10 = var_184_4 <= 0 and var_184_5 or var_184_5 * ((var_184_9 - arg_181_1.typewritterCharCountI18N) / var_184_4)

				if var_184_10 > 0 and var_184_5 < var_184_10 then
					arg_181_1.talkMaxDuration = var_184_10

					if var_184_10 + var_184_3 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_10 + var_184_3
					end
				end
			end

			local var_184_11 = 3.33333333333333
			local var_184_12 = math.max(var_184_11, arg_181_1.talkMaxDuration)

			if var_184_3 <= arg_181_1.time_ and arg_181_1.time_ < var_184_3 + var_184_12 then
				local var_184_13 = (arg_181_1.time_ - var_184_3) / var_184_12

				arg_181_1.fswtw_.percent = Mathf.Lerp(arg_181_1.var_.oldValueTypewriter, var_184_8, var_184_13)
				arg_181_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_181_1.fswtw_:SetDirty()
			end

			if arg_181_1.time_ >= var_184_3 + var_184_12 and arg_181_1.time_ < var_184_3 + var_184_12 + arg_184_0 then
				arg_181_1.fswtw_.percent = var_184_8

				arg_181_1.fswtw_:SetDirty()
				arg_181_1:ShowNextGo(true)

				arg_181_1.typewritterCharCountI18N = var_184_9
			end

			local var_184_14 = 0

			if var_184_14 < arg_181_1.time_ and arg_181_1.time_ <= var_184_14 + arg_184_0 then
				local var_184_15 = arg_181_1.fswbg_.transform:Find("textbox/adapt/content") or arg_181_1.fswbg_.transform:Find("textbox/content")
				local var_184_16 = arg_181_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_184_17 = var_184_15:GetComponent("Text")
				local var_184_18 = var_184_15:GetComponent("RectTransform")

				var_184_17.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_184_18.offsetMin = Vector2.New(0, 0)
				var_184_18.offsetMax = Vector2.New(0, 0)
			end

			local var_184_19 = 0
			local var_184_20 = 14.841
			local var_184_21 = manager.audio:GetVoiceLength("story_v_out_116361", "116361040", "story_v_out_116361.awb") / 1000

			if var_184_21 > 0 and var_184_20 < var_184_21 and var_184_21 + var_184_19 > arg_181_1.duration_ then
				local var_184_22 = var_184_21

				arg_181_1.duration_ = var_184_21 + var_184_19
			end

			if var_184_19 < arg_181_1.time_ and arg_181_1.time_ <= var_184_19 + arg_184_0 then
				local var_184_23 = "play"
				local var_184_24 = "voice"

				arg_181_1:AudioAction(var_184_23, var_184_24, "story_v_out_116361", "116361040", "story_v_out_116361.awb")
			end

			local var_184_25 = 0

			if var_184_25 < arg_181_1.time_ and arg_181_1.time_ <= var_184_25 + arg_184_0 then
				arg_181_1.allBtn_.enabled = false
			end

			local var_184_26 = 3.35

			if arg_181_1.time_ >= var_184_25 + var_184_26 and arg_181_1.time_ < var_184_25 + var_184_26 + arg_184_0 then
				arg_181_1.allBtn_.enabled = true
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play116361041 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 116361041
		arg_185_1.duration_ = 5.43

		local var_185_0 = {
			zh = 5.366,
			ja = 5.433
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
				arg_185_0:Play116361042(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = 2

			if var_188_0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_0 + arg_188_0 then
				local var_188_1 = manager.ui.mainCamera.transform.localPosition
				local var_188_2 = Vector3.New(0, 0, 10) + Vector3.New(var_188_1.x, var_188_1.y, 0)
				local var_188_3 = arg_185_1.bgs_.I07a

				var_188_3.transform.localPosition = var_188_2
				var_188_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_188_4 = var_188_3:GetComponent("SpriteRenderer")

				if var_188_4 and var_188_4.sprite then
					local var_188_5 = (var_188_3.transform.localPosition - var_188_1).z
					local var_188_6 = manager.ui.mainCameraCom_
					local var_188_7 = 2 * var_188_5 * Mathf.Tan(var_188_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_188_8 = var_188_7 * var_188_6.aspect
					local var_188_9 = var_188_4.sprite.bounds.size.x
					local var_188_10 = var_188_4.sprite.bounds.size.y
					local var_188_11 = var_188_8 / var_188_9
					local var_188_12 = var_188_7 / var_188_10
					local var_188_13 = var_188_12 < var_188_11 and var_188_11 or var_188_12

					var_188_3.transform.localScale = Vector3.New(var_188_13, var_188_13, 0)
				end

				for iter_188_0, iter_188_1 in pairs(arg_185_1.bgs_) do
					if iter_188_0 ~= "I07a" then
						iter_188_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_188_14 = 0

			if var_188_14 < arg_185_1.time_ and arg_185_1.time_ <= var_188_14 + arg_188_0 then
				arg_185_1.fswbg_:SetActive(false)
				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_185_1:ShowNextGo(false)
			end

			local var_188_15 = 4
			local var_188_16 = 0.266666666666667

			if var_188_15 < arg_185_1.time_ and arg_185_1.time_ <= var_188_15 + arg_188_0 then
				local var_188_17 = "play"
				local var_188_18 = "music"

				arg_185_1:AudioAction(var_188_17, var_188_18, "ui_battle", "ui_battle_stopbgm", "")

				local var_188_19 = ""
				local var_188_20 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_188_20 ~= "" then
					if arg_185_1.bgmTxt_.text ~= var_188_20 and arg_185_1.bgmTxt_.text ~= "" then
						if arg_185_1.bgmTxt2_.text ~= "" then
							arg_185_1.bgmTxt_.text = arg_185_1.bgmTxt2_.text
						end

						arg_185_1.bgmTxt2_.text = var_188_20

						arg_185_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_185_1.bgmTxt_.text = var_188_20
						arg_185_1.bgmTxt2_.text = var_188_20
					end

					if arg_185_1.bgmTimer then
						arg_185_1.bgmTimer:Stop()

						arg_185_1.bgmTimer = nil
					end

					if arg_185_1.settingData.show_music_name == 1 then
						arg_185_1.musicController:SetSelectedState("show")
						arg_185_1.musicAnimator_:Play("open", 0, 0)

						if arg_185_1.settingData.music_time ~= 0 then
							arg_185_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_185_1.settingData.music_time), function()
								if arg_185_1 == nil or isNil(arg_185_1.bgmTxt_) then
									return
								end

								arg_185_1.musicController:SetSelectedState("hide")
								arg_185_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_188_21 = 4.4
			local var_188_22 = 0.6

			if var_188_21 < arg_185_1.time_ and arg_185_1.time_ <= var_188_21 + arg_188_0 then
				local var_188_23 = "play"
				local var_188_24 = "music"

				arg_185_1:AudioAction(var_188_23, var_188_24, "bgm_story_scheme", "bgm_story_scheme", "bgm_story_scheme.awb")

				local var_188_25 = ""
				local var_188_26 = manager.audio:GetAudioName("bgm_story_scheme", "bgm_story_scheme")

				if var_188_26 ~= "" then
					if arg_185_1.bgmTxt_.text ~= var_188_26 and arg_185_1.bgmTxt_.text ~= "" then
						if arg_185_1.bgmTxt2_.text ~= "" then
							arg_185_1.bgmTxt_.text = arg_185_1.bgmTxt2_.text
						end

						arg_185_1.bgmTxt2_.text = var_188_26

						arg_185_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_185_1.bgmTxt_.text = var_188_26
						arg_185_1.bgmTxt2_.text = var_188_26
					end

					if arg_185_1.bgmTimer then
						arg_185_1.bgmTimer:Stop()

						arg_185_1.bgmTimer = nil
					end

					if arg_185_1.settingData.show_music_name == 1 then
						arg_185_1.musicController:SetSelectedState("show")
						arg_185_1.musicAnimator_:Play("open", 0, 0)

						if arg_185_1.settingData.music_time ~= 0 then
							arg_185_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_185_1.settingData.music_time), function()
								if arg_185_1 == nil or isNil(arg_185_1.bgmTxt_) then
									return
								end

								arg_185_1.musicController:SetSelectedState("hide")
								arg_185_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_188_27 = 0

			if var_188_27 < arg_185_1.time_ and arg_185_1.time_ <= var_188_27 + arg_188_0 then
				arg_185_1.mask_.enabled = true
				arg_185_1.mask_.raycastTarget = true

				arg_185_1:SetGaussion(false)
			end

			local var_188_28 = 2

			if var_188_27 <= arg_185_1.time_ and arg_185_1.time_ < var_188_27 + var_188_28 then
				local var_188_29 = (arg_185_1.time_ - var_188_27) / var_188_28
				local var_188_30 = Color.New(0, 0, 0)

				var_188_30.a = Mathf.Lerp(0, 1, var_188_29)
				arg_185_1.mask_.color = var_188_30
			end

			if arg_185_1.time_ >= var_188_27 + var_188_28 and arg_185_1.time_ < var_188_27 + var_188_28 + arg_188_0 then
				local var_188_31 = Color.New(0, 0, 0)

				var_188_31.a = 1
				arg_185_1.mask_.color = var_188_31
			end

			local var_188_32 = 2

			if var_188_32 < arg_185_1.time_ and arg_185_1.time_ <= var_188_32 + arg_188_0 then
				arg_185_1.mask_.enabled = true
				arg_185_1.mask_.raycastTarget = true

				arg_185_1:SetGaussion(false)
			end

			local var_188_33 = 2

			if var_188_32 <= arg_185_1.time_ and arg_185_1.time_ < var_188_32 + var_188_33 then
				local var_188_34 = (arg_185_1.time_ - var_188_32) / var_188_33
				local var_188_35 = Color.New(0, 0, 0)

				var_188_35.a = Mathf.Lerp(1, 0, var_188_34)
				arg_185_1.mask_.color = var_188_35
			end

			if arg_185_1.time_ >= var_188_32 + var_188_33 and arg_185_1.time_ < var_188_32 + var_188_33 + arg_188_0 then
				local var_188_36 = Color.New(0, 0, 0)
				local var_188_37 = 0

				arg_185_1.mask_.enabled = false
				var_188_36.a = var_188_37
				arg_185_1.mask_.color = var_188_36
			end

			if arg_185_1.frameCnt_ <= 1 then
				arg_185_1.dialog_:SetActive(false)
			end

			local var_188_38 = 4
			local var_188_39 = 0.125

			if var_188_38 < arg_185_1.time_ and arg_185_1.time_ <= var_188_38 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0

				arg_185_1.dialog_:SetActive(true)

				arg_185_1.dialogCg_.alpha = 0

				local var_188_40 = LeanTween.value(arg_185_1.dialog_, 0, 1, 0.3)

				var_188_40:setOnUpdate(LuaHelper.FloatAction(function(arg_191_0)
					arg_185_1.dialogCg_.alpha = arg_191_0
				end))
				var_188_40:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_185_1.dialog_)
					var_188_40:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_185_1.duration_ = arg_185_1.duration_ + 0.3

				SetActive(arg_185_1.leftNameGo_, true)

				local var_188_41 = arg_185_1:FormatText(StoryNameCfg[332].name)

				arg_185_1.leftNameTxt_.text = var_188_41

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, true)
				arg_185_1.iconController_:SetSelectedState("hero")

				arg_185_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10024")

				arg_185_1.callingController_:SetSelectedState("normal")

				arg_185_1.keyicon_.color = Color.New(1, 1, 1)
				arg_185_1.icon_.color = Color.New(1, 1, 1)

				local var_188_42 = arg_185_1:GetWordFromCfg(116361041)
				local var_188_43 = arg_185_1:FormatText(var_188_42.content)

				arg_185_1.text_.text = var_188_43

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_44 = 5
				local var_188_45 = utf8.len(var_188_43)
				local var_188_46 = var_188_44 <= 0 and var_188_39 or var_188_39 * (var_188_45 / var_188_44)

				if var_188_46 > 0 and var_188_39 < var_188_46 then
					arg_185_1.talkMaxDuration = var_188_46
					var_188_38 = var_188_38 + 0.3

					if var_188_46 + var_188_38 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_46 + var_188_38
					end
				end

				arg_185_1.text_.text = var_188_43
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116361", "116361041", "story_v_out_116361.awb") ~= 0 then
					local var_188_47 = manager.audio:GetVoiceLength("story_v_out_116361", "116361041", "story_v_out_116361.awb") / 1000

					if var_188_47 + var_188_38 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_47 + var_188_38
					end

					if var_188_42.prefab_name ~= "" and arg_185_1.actors_[var_188_42.prefab_name] ~= nil then
						local var_188_48 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_42.prefab_name].transform, "story_v_out_116361", "116361041", "story_v_out_116361.awb")

						arg_185_1:RecordAudio("116361041", var_188_48)
						arg_185_1:RecordAudio("116361041", var_188_48)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_116361", "116361041", "story_v_out_116361.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_116361", "116361041", "story_v_out_116361.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_49 = var_188_38 + 0.3
			local var_188_50 = math.max(var_188_39, arg_185_1.talkMaxDuration)

			if var_188_49 <= arg_185_1.time_ and arg_185_1.time_ < var_188_49 + var_188_50 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_49) / var_188_50

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_49 + var_188_50 and arg_185_1.time_ < var_188_49 + var_188_50 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play116361042 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 116361042
		arg_193_1.duration_ = 2.07

		local var_193_0 = {
			zh = 2.066,
			ja = 0.999999999999
		}
		local var_193_1 = manager.audio:GetLocalizationFlag()

		if var_193_0[var_193_1] ~= nil then
			arg_193_1.duration_ = var_193_0[var_193_1]
		end

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play116361043(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = 0
			local var_196_1 = 0.1

			if var_196_0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_0 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, false)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_2 = arg_193_1:GetWordFromCfg(116361042)
				local var_196_3 = arg_193_1:FormatText(var_196_2.content)

				arg_193_1.text_.text = var_196_3

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_4 = 4
				local var_196_5 = utf8.len(var_196_3)
				local var_196_6 = var_196_4 <= 0 and var_196_1 or var_196_1 * (var_196_5 / var_196_4)

				if var_196_6 > 0 and var_196_1 < var_196_6 then
					arg_193_1.talkMaxDuration = var_196_6

					if var_196_6 + var_196_0 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_6 + var_196_0
					end
				end

				arg_193_1.text_.text = var_196_3
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116361", "116361042", "story_v_out_116361.awb") ~= 0 then
					local var_196_7 = manager.audio:GetVoiceLength("story_v_out_116361", "116361042", "story_v_out_116361.awb") / 1000

					if var_196_7 + var_196_0 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_7 + var_196_0
					end

					if var_196_2.prefab_name ~= "" and arg_193_1.actors_[var_196_2.prefab_name] ~= nil then
						local var_196_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_2.prefab_name].transform, "story_v_out_116361", "116361042", "story_v_out_116361.awb")

						arg_193_1:RecordAudio("116361042", var_196_8)
						arg_193_1:RecordAudio("116361042", var_196_8)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_out_116361", "116361042", "story_v_out_116361.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_out_116361", "116361042", "story_v_out_116361.awb")
				end

				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_9 = math.max(var_196_1, arg_193_1.talkMaxDuration)

			if var_196_0 <= arg_193_1.time_ and arg_193_1.time_ < var_196_0 + var_196_9 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_0) / var_196_9

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_0 + var_196_9 and arg_193_1.time_ < var_196_0 + var_196_9 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	Play116361043 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 116361043
		arg_197_1.duration_ = 4.57

		local var_197_0 = {
			zh = 4.566,
			ja = 3.766
		}
		local var_197_1 = manager.audio:GetLocalizationFlag()

		if var_197_0[var_197_1] ~= nil then
			arg_197_1.duration_ = var_197_0[var_197_1]
		end

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play116361044(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = 0
			local var_200_1 = 0.425

			if var_200_0 < arg_197_1.time_ and arg_197_1.time_ <= var_200_0 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				local var_200_2 = arg_197_1:FormatText(StoryNameCfg[328].name)

				arg_197_1.leftNameTxt_.text = var_200_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, true)
				arg_197_1.iconController_:SetSelectedState("hero")

				arg_197_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10032")

				arg_197_1.callingController_:SetSelectedState("normal")

				arg_197_1.keyicon_.color = Color.New(1, 1, 1)
				arg_197_1.icon_.color = Color.New(1, 1, 1)

				local var_200_3 = arg_197_1:GetWordFromCfg(116361043)
				local var_200_4 = arg_197_1:FormatText(var_200_3.content)

				arg_197_1.text_.text = var_200_4

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_5 = 17
				local var_200_6 = utf8.len(var_200_4)
				local var_200_7 = var_200_5 <= 0 and var_200_1 or var_200_1 * (var_200_6 / var_200_5)

				if var_200_7 > 0 and var_200_1 < var_200_7 then
					arg_197_1.talkMaxDuration = var_200_7

					if var_200_7 + var_200_0 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_7 + var_200_0
					end
				end

				arg_197_1.text_.text = var_200_4
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116361", "116361043", "story_v_out_116361.awb") ~= 0 then
					local var_200_8 = manager.audio:GetVoiceLength("story_v_out_116361", "116361043", "story_v_out_116361.awb") / 1000

					if var_200_8 + var_200_0 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_8 + var_200_0
					end

					if var_200_3.prefab_name ~= "" and arg_197_1.actors_[var_200_3.prefab_name] ~= nil then
						local var_200_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_3.prefab_name].transform, "story_v_out_116361", "116361043", "story_v_out_116361.awb")

						arg_197_1:RecordAudio("116361043", var_200_9)
						arg_197_1:RecordAudio("116361043", var_200_9)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_116361", "116361043", "story_v_out_116361.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_116361", "116361043", "story_v_out_116361.awb")
				end

				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_10 = math.max(var_200_1, arg_197_1.talkMaxDuration)

			if var_200_0 <= arg_197_1.time_ and arg_197_1.time_ < var_200_0 + var_200_10 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_0) / var_200_10

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_0 + var_200_10 and arg_197_1.time_ < var_200_0 + var_200_10 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {}

		arg_197_1:InitPlayNodeList()
	end,
	Play116361044 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 116361044
		arg_201_1.duration_ = 5

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play116361045(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = 0
			local var_204_1 = 1.175

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

				local var_204_2 = arg_201_1:GetWordFromCfg(116361044)
				local var_204_3 = arg_201_1:FormatText(var_204_2.content)

				arg_201_1.text_.text = var_204_3

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_4 = 47
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
	Play116361045 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 116361045
		arg_205_1.duration_ = 3.77

		local var_205_0 = {
			zh = 3.7,
			ja = 3.766
		}
		local var_205_1 = manager.audio:GetLocalizationFlag()

		if var_205_0[var_205_1] ~= nil then
			arg_205_1.duration_ = var_205_0[var_205_1]
		end

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play116361046(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = 0
			local var_208_1 = 0.375

			if var_208_0 < arg_205_1.time_ and arg_205_1.time_ <= var_208_0 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				local var_208_2 = arg_205_1:FormatText(StoryNameCfg[332].name)

				arg_205_1.leftNameTxt_.text = var_208_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, true)
				arg_205_1.iconController_:SetSelectedState("hero")

				arg_205_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10024")

				arg_205_1.callingController_:SetSelectedState("normal")

				arg_205_1.keyicon_.color = Color.New(1, 1, 1)
				arg_205_1.icon_.color = Color.New(1, 1, 1)

				local var_208_3 = arg_205_1:GetWordFromCfg(116361045)
				local var_208_4 = arg_205_1:FormatText(var_208_3.content)

				arg_205_1.text_.text = var_208_4

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_5 = 15
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

				if manager.audio:GetVoiceLength("story_v_out_116361", "116361045", "story_v_out_116361.awb") ~= 0 then
					local var_208_8 = manager.audio:GetVoiceLength("story_v_out_116361", "116361045", "story_v_out_116361.awb") / 1000

					if var_208_8 + var_208_0 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_8 + var_208_0
					end

					if var_208_3.prefab_name ~= "" and arg_205_1.actors_[var_208_3.prefab_name] ~= nil then
						local var_208_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_205_1.actors_[var_208_3.prefab_name].transform, "story_v_out_116361", "116361045", "story_v_out_116361.awb")

						arg_205_1:RecordAudio("116361045", var_208_9)
						arg_205_1:RecordAudio("116361045", var_208_9)
					else
						arg_205_1:AudioAction("play", "voice", "story_v_out_116361", "116361045", "story_v_out_116361.awb")
					end

					arg_205_1:RecordHistoryTalkVoice("story_v_out_116361", "116361045", "story_v_out_116361.awb")
				end

				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_10 = math.max(var_208_1, arg_205_1.talkMaxDuration)

			if var_208_0 <= arg_205_1.time_ and arg_205_1.time_ < var_208_0 + var_208_10 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_0) / var_208_10

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_0 + var_208_10 and arg_205_1.time_ < var_208_0 + var_208_10 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {}

		arg_205_1:InitPlayNodeList()
	end,
	Play116361046 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 116361046
		arg_209_1.duration_ = 2.53

		local var_209_0 = {
			zh = 2.533,
			ja = 2.433
		}
		local var_209_1 = manager.audio:GetLocalizationFlag()

		if var_209_0[var_209_1] ~= nil then
			arg_209_1.duration_ = var_209_0[var_209_1]
		end

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play116361047(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = 0

			if var_212_0 < arg_209_1.time_ and arg_209_1.time_ <= var_212_0 + arg_212_0 then
				arg_209_1:PlayTimeline("10032ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action2_1")
			end

			local var_212_1 = 0

			if var_212_1 < arg_209_1.time_ and arg_209_1.time_ <= var_212_1 + arg_212_0 then
				arg_209_1:PlayTimeline("10032ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_212_2 = arg_209_1.actors_["10032ui_story"]
			local var_212_3 = 0

			if var_212_3 < arg_209_1.time_ and arg_209_1.time_ <= var_212_3 + arg_212_0 and not isNil(var_212_2) and arg_209_1.var_.characterEffect10032ui_story == nil then
				arg_209_1.var_.characterEffect10032ui_story = var_212_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_212_4 = 0.2

			if var_212_3 <= arg_209_1.time_ and arg_209_1.time_ < var_212_3 + var_212_4 and not isNil(var_212_2) then
				local var_212_5 = (arg_209_1.time_ - var_212_3) / var_212_4

				if arg_209_1.var_.characterEffect10032ui_story and not isNil(var_212_2) then
					arg_209_1.var_.characterEffect10032ui_story.fillFlat = false
				end
			end

			if arg_209_1.time_ >= var_212_3 + var_212_4 and arg_209_1.time_ < var_212_3 + var_212_4 + arg_212_0 and not isNil(var_212_2) and arg_209_1.var_.characterEffect10032ui_story then
				arg_209_1.var_.characterEffect10032ui_story.fillFlat = false
			end

			local var_212_6 = arg_209_1.actors_["10032ui_story"].transform
			local var_212_7 = 0

			if var_212_7 < arg_209_1.time_ and arg_209_1.time_ <= var_212_7 + arg_212_0 then
				arg_209_1.var_.moveOldPos10032ui_story = var_212_6.localPosition
			end

			local var_212_8 = 0.001

			if var_212_7 <= arg_209_1.time_ and arg_209_1.time_ < var_212_7 + var_212_8 then
				local var_212_9 = (arg_209_1.time_ - var_212_7) / var_212_8
				local var_212_10 = Vector3.New(0, -1.1, -5.9)

				var_212_6.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos10032ui_story, var_212_10, var_212_9)

				local var_212_11 = manager.ui.mainCamera.transform.position - var_212_6.position

				var_212_6.forward = Vector3.New(var_212_11.x, var_212_11.y, var_212_11.z)

				local var_212_12 = var_212_6.localEulerAngles

				var_212_12.z = 0
				var_212_12.x = 0
				var_212_6.localEulerAngles = var_212_12
			end

			if arg_209_1.time_ >= var_212_7 + var_212_8 and arg_209_1.time_ < var_212_7 + var_212_8 + arg_212_0 then
				var_212_6.localPosition = Vector3.New(0, -1.1, -5.9)

				local var_212_13 = manager.ui.mainCamera.transform.position - var_212_6.position

				var_212_6.forward = Vector3.New(var_212_13.x, var_212_13.y, var_212_13.z)

				local var_212_14 = var_212_6.localEulerAngles

				var_212_14.z = 0
				var_212_14.x = 0
				var_212_6.localEulerAngles = var_212_14
			end

			local var_212_15 = 0
			local var_212_16 = 0.3

			if var_212_15 < arg_209_1.time_ and arg_209_1.time_ <= var_212_15 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				local var_212_17 = arg_209_1:FormatText(StoryNameCfg[328].name)

				arg_209_1.leftNameTxt_.text = var_212_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_18 = arg_209_1:GetWordFromCfg(116361046)
				local var_212_19 = arg_209_1:FormatText(var_212_18.content)

				arg_209_1.text_.text = var_212_19

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_20 = 12
				local var_212_21 = utf8.len(var_212_19)
				local var_212_22 = var_212_20 <= 0 and var_212_16 or var_212_16 * (var_212_21 / var_212_20)

				if var_212_22 > 0 and var_212_16 < var_212_22 then
					arg_209_1.talkMaxDuration = var_212_22

					if var_212_22 + var_212_15 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_22 + var_212_15
					end
				end

				arg_209_1.text_.text = var_212_19
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116361", "116361046", "story_v_out_116361.awb") ~= 0 then
					local var_212_23 = manager.audio:GetVoiceLength("story_v_out_116361", "116361046", "story_v_out_116361.awb") / 1000

					if var_212_23 + var_212_15 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_23 + var_212_15
					end

					if var_212_18.prefab_name ~= "" and arg_209_1.actors_[var_212_18.prefab_name] ~= nil then
						local var_212_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_18.prefab_name].transform, "story_v_out_116361", "116361046", "story_v_out_116361.awb")

						arg_209_1:RecordAudio("116361046", var_212_24)
						arg_209_1:RecordAudio("116361046", var_212_24)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_out_116361", "116361046", "story_v_out_116361.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_out_116361", "116361046", "story_v_out_116361.awb")
				end

				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_25 = math.max(var_212_16, arg_209_1.talkMaxDuration)

			if var_212_15 <= arg_209_1.time_ and arg_209_1.time_ < var_212_15 + var_212_25 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_15) / var_212_25

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_15 + var_212_25 and arg_209_1.time_ < var_212_15 + var_212_25 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10032ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_209_1:InitPlayNodeList()
	end,
	Play116361047 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 116361047
		arg_213_1.duration_ = 8.7

		local var_213_0 = {
			zh = 8.7,
			ja = 6.933
		}
		local var_213_1 = manager.audio:GetLocalizationFlag()

		if var_213_0[var_213_1] ~= nil then
			arg_213_1.duration_ = var_213_0[var_213_1]
		end

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play116361048(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = arg_213_1.actors_["10032ui_story"]
			local var_216_1 = 0

			if var_216_1 < arg_213_1.time_ and arg_213_1.time_ <= var_216_1 + arg_216_0 and not isNil(var_216_0) and arg_213_1.var_.characterEffect10032ui_story == nil then
				arg_213_1.var_.characterEffect10032ui_story = var_216_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_216_2 = 0.2

			if var_216_1 <= arg_213_1.time_ and arg_213_1.time_ < var_216_1 + var_216_2 and not isNil(var_216_0) then
				local var_216_3 = (arg_213_1.time_ - var_216_1) / var_216_2

				if arg_213_1.var_.characterEffect10032ui_story and not isNil(var_216_0) then
					local var_216_4 = Mathf.Lerp(0, 0.5, var_216_3)

					arg_213_1.var_.characterEffect10032ui_story.fillFlat = true
					arg_213_1.var_.characterEffect10032ui_story.fillRatio = var_216_4
				end
			end

			if arg_213_1.time_ >= var_216_1 + var_216_2 and arg_213_1.time_ < var_216_1 + var_216_2 + arg_216_0 and not isNil(var_216_0) and arg_213_1.var_.characterEffect10032ui_story then
				local var_216_5 = 0.5

				arg_213_1.var_.characterEffect10032ui_story.fillFlat = true
				arg_213_1.var_.characterEffect10032ui_story.fillRatio = var_216_5
			end

			local var_216_6 = 0
			local var_216_7 = 0.975

			if var_216_6 < arg_213_1.time_ and arg_213_1.time_ <= var_216_6 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				local var_216_8 = arg_213_1:FormatText(StoryNameCfg[332].name)

				arg_213_1.leftNameTxt_.text = var_216_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, true)
				arg_213_1.iconController_:SetSelectedState("hero")

				arg_213_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10024")

				arg_213_1.callingController_:SetSelectedState("normal")

				arg_213_1.keyicon_.color = Color.New(1, 1, 1)
				arg_213_1.icon_.color = Color.New(1, 1, 1)

				local var_216_9 = arg_213_1:GetWordFromCfg(116361047)
				local var_216_10 = arg_213_1:FormatText(var_216_9.content)

				arg_213_1.text_.text = var_216_10

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_11 = 38
				local var_216_12 = utf8.len(var_216_10)
				local var_216_13 = var_216_11 <= 0 and var_216_7 or var_216_7 * (var_216_12 / var_216_11)

				if var_216_13 > 0 and var_216_7 < var_216_13 then
					arg_213_1.talkMaxDuration = var_216_13

					if var_216_13 + var_216_6 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_13 + var_216_6
					end
				end

				arg_213_1.text_.text = var_216_10
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116361", "116361047", "story_v_out_116361.awb") ~= 0 then
					local var_216_14 = manager.audio:GetVoiceLength("story_v_out_116361", "116361047", "story_v_out_116361.awb") / 1000

					if var_216_14 + var_216_6 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_14 + var_216_6
					end

					if var_216_9.prefab_name ~= "" and arg_213_1.actors_[var_216_9.prefab_name] ~= nil then
						local var_216_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_9.prefab_name].transform, "story_v_out_116361", "116361047", "story_v_out_116361.awb")

						arg_213_1:RecordAudio("116361047", var_216_15)
						arg_213_1:RecordAudio("116361047", var_216_15)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_out_116361", "116361047", "story_v_out_116361.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_out_116361", "116361047", "story_v_out_116361.awb")
				end

				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_16 = math.max(var_216_7, arg_213_1.talkMaxDuration)

			if var_216_6 <= arg_213_1.time_ and arg_213_1.time_ < var_216_6 + var_216_16 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_6) / var_216_16

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_6 + var_216_16 and arg_213_1.time_ < var_216_6 + var_216_16 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {}

		arg_213_1:InitPlayNodeList()
	end,
	Play116361048 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 116361048
		arg_217_1.duration_ = 10.37

		local var_217_0 = {
			zh = 6.9,
			ja = 10.366
		}
		local var_217_1 = manager.audio:GetLocalizationFlag()

		if var_217_0[var_217_1] ~= nil then
			arg_217_1.duration_ = var_217_0[var_217_1]
		end

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play116361049(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = 0

			if var_220_0 < arg_217_1.time_ and arg_217_1.time_ <= var_220_0 + arg_220_0 then
				arg_217_1:PlayTimeline("10032ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_220_1 = arg_217_1.actors_["10032ui_story"]
			local var_220_2 = 0

			if var_220_2 < arg_217_1.time_ and arg_217_1.time_ <= var_220_2 + arg_220_0 and not isNil(var_220_1) and arg_217_1.var_.characterEffect10032ui_story == nil then
				arg_217_1.var_.characterEffect10032ui_story = var_220_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_220_3 = 0.2

			if var_220_2 <= arg_217_1.time_ and arg_217_1.time_ < var_220_2 + var_220_3 and not isNil(var_220_1) then
				local var_220_4 = (arg_217_1.time_ - var_220_2) / var_220_3

				if arg_217_1.var_.characterEffect10032ui_story and not isNil(var_220_1) then
					arg_217_1.var_.characterEffect10032ui_story.fillFlat = false
				end
			end

			if arg_217_1.time_ >= var_220_2 + var_220_3 and arg_217_1.time_ < var_220_2 + var_220_3 + arg_220_0 and not isNil(var_220_1) and arg_217_1.var_.characterEffect10032ui_story then
				arg_217_1.var_.characterEffect10032ui_story.fillFlat = false
			end

			local var_220_5 = 0
			local var_220_6 = 0.65

			if var_220_5 < arg_217_1.time_ and arg_217_1.time_ <= var_220_5 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				local var_220_7 = arg_217_1:FormatText(StoryNameCfg[328].name)

				arg_217_1.leftNameTxt_.text = var_220_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_8 = arg_217_1:GetWordFromCfg(116361048)
				local var_220_9 = arg_217_1:FormatText(var_220_8.content)

				arg_217_1.text_.text = var_220_9

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_10 = 26
				local var_220_11 = utf8.len(var_220_9)
				local var_220_12 = var_220_10 <= 0 and var_220_6 or var_220_6 * (var_220_11 / var_220_10)

				if var_220_12 > 0 and var_220_6 < var_220_12 then
					arg_217_1.talkMaxDuration = var_220_12

					if var_220_12 + var_220_5 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_12 + var_220_5
					end
				end

				arg_217_1.text_.text = var_220_9
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116361", "116361048", "story_v_out_116361.awb") ~= 0 then
					local var_220_13 = manager.audio:GetVoiceLength("story_v_out_116361", "116361048", "story_v_out_116361.awb") / 1000

					if var_220_13 + var_220_5 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_13 + var_220_5
					end

					if var_220_8.prefab_name ~= "" and arg_217_1.actors_[var_220_8.prefab_name] ~= nil then
						local var_220_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_217_1.actors_[var_220_8.prefab_name].transform, "story_v_out_116361", "116361048", "story_v_out_116361.awb")

						arg_217_1:RecordAudio("116361048", var_220_14)
						arg_217_1:RecordAudio("116361048", var_220_14)
					else
						arg_217_1:AudioAction("play", "voice", "story_v_out_116361", "116361048", "story_v_out_116361.awb")
					end

					arg_217_1:RecordHistoryTalkVoice("story_v_out_116361", "116361048", "story_v_out_116361.awb")
				end

				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_15 = math.max(var_220_6, arg_217_1.talkMaxDuration)

			if var_220_5 <= arg_217_1.time_ and arg_217_1.time_ < var_220_5 + var_220_15 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_5) / var_220_15

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_5 + var_220_15 and arg_217_1.time_ < var_220_5 + var_220_15 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {}

		arg_217_1:InitPlayNodeList()
	end,
	Play116361049 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 116361049
		arg_221_1.duration_ = 8.57

		local var_221_0 = {
			zh = 8.566,
			ja = 7.2
		}
		local var_221_1 = manager.audio:GetLocalizationFlag()

		if var_221_0[var_221_1] ~= nil then
			arg_221_1.duration_ = var_221_0[var_221_1]
		end

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play116361050(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_0 = arg_221_1.actors_["10032ui_story"]
			local var_224_1 = 0

			if var_224_1 < arg_221_1.time_ and arg_221_1.time_ <= var_224_1 + arg_224_0 and not isNil(var_224_0) and arg_221_1.var_.characterEffect10032ui_story == nil then
				arg_221_1.var_.characterEffect10032ui_story = var_224_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_224_2 = 0.2

			if var_224_1 <= arg_221_1.time_ and arg_221_1.time_ < var_224_1 + var_224_2 and not isNil(var_224_0) then
				local var_224_3 = (arg_221_1.time_ - var_224_1) / var_224_2

				if arg_221_1.var_.characterEffect10032ui_story and not isNil(var_224_0) then
					local var_224_4 = Mathf.Lerp(0, 0.5, var_224_3)

					arg_221_1.var_.characterEffect10032ui_story.fillFlat = true
					arg_221_1.var_.characterEffect10032ui_story.fillRatio = var_224_4
				end
			end

			if arg_221_1.time_ >= var_224_1 + var_224_2 and arg_221_1.time_ < var_224_1 + var_224_2 + arg_224_0 and not isNil(var_224_0) and arg_221_1.var_.characterEffect10032ui_story then
				local var_224_5 = 0.5

				arg_221_1.var_.characterEffect10032ui_story.fillFlat = true
				arg_221_1.var_.characterEffect10032ui_story.fillRatio = var_224_5
			end

			local var_224_6 = 0
			local var_224_7 = 0.775

			if var_224_6 < arg_221_1.time_ and arg_221_1.time_ <= var_224_6 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				local var_224_8 = arg_221_1:FormatText(StoryNameCfg[332].name)

				arg_221_1.leftNameTxt_.text = var_224_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, true)
				arg_221_1.iconController_:SetSelectedState("hero")

				arg_221_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10024")

				arg_221_1.callingController_:SetSelectedState("normal")

				arg_221_1.keyicon_.color = Color.New(1, 1, 1)
				arg_221_1.icon_.color = Color.New(1, 1, 1)

				local var_224_9 = arg_221_1:GetWordFromCfg(116361049)
				local var_224_10 = arg_221_1:FormatText(var_224_9.content)

				arg_221_1.text_.text = var_224_10

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_11 = 31
				local var_224_12 = utf8.len(var_224_10)
				local var_224_13 = var_224_11 <= 0 and var_224_7 or var_224_7 * (var_224_12 / var_224_11)

				if var_224_13 > 0 and var_224_7 < var_224_13 then
					arg_221_1.talkMaxDuration = var_224_13

					if var_224_13 + var_224_6 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_13 + var_224_6
					end
				end

				arg_221_1.text_.text = var_224_10
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116361", "116361049", "story_v_out_116361.awb") ~= 0 then
					local var_224_14 = manager.audio:GetVoiceLength("story_v_out_116361", "116361049", "story_v_out_116361.awb") / 1000

					if var_224_14 + var_224_6 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_14 + var_224_6
					end

					if var_224_9.prefab_name ~= "" and arg_221_1.actors_[var_224_9.prefab_name] ~= nil then
						local var_224_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_9.prefab_name].transform, "story_v_out_116361", "116361049", "story_v_out_116361.awb")

						arg_221_1:RecordAudio("116361049", var_224_15)
						arg_221_1:RecordAudio("116361049", var_224_15)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_out_116361", "116361049", "story_v_out_116361.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_out_116361", "116361049", "story_v_out_116361.awb")
				end

				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_16 = math.max(var_224_7, arg_221_1.talkMaxDuration)

			if var_224_6 <= arg_221_1.time_ and arg_221_1.time_ < var_224_6 + var_224_16 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_6) / var_224_16

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_6 + var_224_16 and arg_221_1.time_ < var_224_6 + var_224_16 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {}

		arg_221_1:InitPlayNodeList()
	end,
	Play116361050 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 116361050
		arg_225_1.duration_ = 2.6

		local var_225_0 = {
			zh = 2.6,
			ja = 1.999999999999
		}
		local var_225_1 = manager.audio:GetLocalizationFlag()

		if var_225_0[var_225_1] ~= nil then
			arg_225_1.duration_ = var_225_0[var_225_1]
		end

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play116361051(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = 0

			if var_228_0 < arg_225_1.time_ and arg_225_1.time_ <= var_228_0 + arg_228_0 then
				arg_225_1:PlayTimeline("10032ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_228_1 = arg_225_1.actors_["10032ui_story"]
			local var_228_2 = 0

			if var_228_2 < arg_225_1.time_ and arg_225_1.time_ <= var_228_2 + arg_228_0 and not isNil(var_228_1) and arg_225_1.var_.characterEffect10032ui_story == nil then
				arg_225_1.var_.characterEffect10032ui_story = var_228_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_228_3 = 0.2

			if var_228_2 <= arg_225_1.time_ and arg_225_1.time_ < var_228_2 + var_228_3 and not isNil(var_228_1) then
				local var_228_4 = (arg_225_1.time_ - var_228_2) / var_228_3

				if arg_225_1.var_.characterEffect10032ui_story and not isNil(var_228_1) then
					arg_225_1.var_.characterEffect10032ui_story.fillFlat = false
				end
			end

			if arg_225_1.time_ >= var_228_2 + var_228_3 and arg_225_1.time_ < var_228_2 + var_228_3 + arg_228_0 and not isNil(var_228_1) and arg_225_1.var_.characterEffect10032ui_story then
				arg_225_1.var_.characterEffect10032ui_story.fillFlat = false
			end

			local var_228_5 = 0
			local var_228_6 = 0.275

			if var_228_5 < arg_225_1.time_ and arg_225_1.time_ <= var_228_5 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				local var_228_7 = arg_225_1:FormatText(StoryNameCfg[328].name)

				arg_225_1.leftNameTxt_.text = var_228_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_8 = arg_225_1:GetWordFromCfg(116361050)
				local var_228_9 = arg_225_1:FormatText(var_228_8.content)

				arg_225_1.text_.text = var_228_9

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_10 = 11
				local var_228_11 = utf8.len(var_228_9)
				local var_228_12 = var_228_10 <= 0 and var_228_6 or var_228_6 * (var_228_11 / var_228_10)

				if var_228_12 > 0 and var_228_6 < var_228_12 then
					arg_225_1.talkMaxDuration = var_228_12

					if var_228_12 + var_228_5 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_12 + var_228_5
					end
				end

				arg_225_1.text_.text = var_228_9
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116361", "116361050", "story_v_out_116361.awb") ~= 0 then
					local var_228_13 = manager.audio:GetVoiceLength("story_v_out_116361", "116361050", "story_v_out_116361.awb") / 1000

					if var_228_13 + var_228_5 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_13 + var_228_5
					end

					if var_228_8.prefab_name ~= "" and arg_225_1.actors_[var_228_8.prefab_name] ~= nil then
						local var_228_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_225_1.actors_[var_228_8.prefab_name].transform, "story_v_out_116361", "116361050", "story_v_out_116361.awb")

						arg_225_1:RecordAudio("116361050", var_228_14)
						arg_225_1:RecordAudio("116361050", var_228_14)
					else
						arg_225_1:AudioAction("play", "voice", "story_v_out_116361", "116361050", "story_v_out_116361.awb")
					end

					arg_225_1:RecordHistoryTalkVoice("story_v_out_116361", "116361050", "story_v_out_116361.awb")
				end

				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_15 = math.max(var_228_6, arg_225_1.talkMaxDuration)

			if var_228_5 <= arg_225_1.time_ and arg_225_1.time_ < var_228_5 + var_228_15 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_5) / var_228_15

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_5 + var_228_15 and arg_225_1.time_ < var_228_5 + var_228_15 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {}

		arg_225_1:InitPlayNodeList()
	end,
	Play116361051 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 116361051
		arg_229_1.duration_ = 7.23

		local var_229_0 = {
			zh = 3.666,
			ja = 7.233
		}
		local var_229_1 = manager.audio:GetLocalizationFlag()

		if var_229_0[var_229_1] ~= nil then
			arg_229_1.duration_ = var_229_0[var_229_1]
		end

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play116361052(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = arg_229_1.actors_["10032ui_story"]
			local var_232_1 = 0

			if var_232_1 < arg_229_1.time_ and arg_229_1.time_ <= var_232_1 + arg_232_0 and not isNil(var_232_0) and arg_229_1.var_.characterEffect10032ui_story == nil then
				arg_229_1.var_.characterEffect10032ui_story = var_232_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_232_2 = 0.2

			if var_232_1 <= arg_229_1.time_ and arg_229_1.time_ < var_232_1 + var_232_2 and not isNil(var_232_0) then
				local var_232_3 = (arg_229_1.time_ - var_232_1) / var_232_2

				if arg_229_1.var_.characterEffect10032ui_story and not isNil(var_232_0) then
					local var_232_4 = Mathf.Lerp(0, 0.5, var_232_3)

					arg_229_1.var_.characterEffect10032ui_story.fillFlat = true
					arg_229_1.var_.characterEffect10032ui_story.fillRatio = var_232_4
				end
			end

			if arg_229_1.time_ >= var_232_1 + var_232_2 and arg_229_1.time_ < var_232_1 + var_232_2 + arg_232_0 and not isNil(var_232_0) and arg_229_1.var_.characterEffect10032ui_story then
				local var_232_5 = 0.5

				arg_229_1.var_.characterEffect10032ui_story.fillFlat = true
				arg_229_1.var_.characterEffect10032ui_story.fillRatio = var_232_5
			end

			local var_232_6 = 0
			local var_232_7 = 0.375

			if var_232_6 < arg_229_1.time_ and arg_229_1.time_ <= var_232_6 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				local var_232_8 = arg_229_1:FormatText(StoryNameCfg[332].name)

				arg_229_1.leftNameTxt_.text = var_232_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, true)
				arg_229_1.iconController_:SetSelectedState("hero")

				arg_229_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10024")

				arg_229_1.callingController_:SetSelectedState("normal")

				arg_229_1.keyicon_.color = Color.New(1, 1, 1)
				arg_229_1.icon_.color = Color.New(1, 1, 1)

				local var_232_9 = arg_229_1:GetWordFromCfg(116361051)
				local var_232_10 = arg_229_1:FormatText(var_232_9.content)

				arg_229_1.text_.text = var_232_10

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_11 = 15
				local var_232_12 = utf8.len(var_232_10)
				local var_232_13 = var_232_11 <= 0 and var_232_7 or var_232_7 * (var_232_12 / var_232_11)

				if var_232_13 > 0 and var_232_7 < var_232_13 then
					arg_229_1.talkMaxDuration = var_232_13

					if var_232_13 + var_232_6 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_13 + var_232_6
					end
				end

				arg_229_1.text_.text = var_232_10
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116361", "116361051", "story_v_out_116361.awb") ~= 0 then
					local var_232_14 = manager.audio:GetVoiceLength("story_v_out_116361", "116361051", "story_v_out_116361.awb") / 1000

					if var_232_14 + var_232_6 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_14 + var_232_6
					end

					if var_232_9.prefab_name ~= "" and arg_229_1.actors_[var_232_9.prefab_name] ~= nil then
						local var_232_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_9.prefab_name].transform, "story_v_out_116361", "116361051", "story_v_out_116361.awb")

						arg_229_1:RecordAudio("116361051", var_232_15)
						arg_229_1:RecordAudio("116361051", var_232_15)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_out_116361", "116361051", "story_v_out_116361.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_out_116361", "116361051", "story_v_out_116361.awb")
				end

				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_16 = math.max(var_232_7, arg_229_1.talkMaxDuration)

			if var_232_6 <= arg_229_1.time_ and arg_229_1.time_ < var_232_6 + var_232_16 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_6) / var_232_16

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_6 + var_232_16 and arg_229_1.time_ < var_232_6 + var_232_16 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {}

		arg_229_1:InitPlayNodeList()
	end,
	Play116361052 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 116361052
		arg_233_1.duration_ = 9.97

		local var_233_0 = {
			zh = 7.666,
			ja = 9.966
		}
		local var_233_1 = manager.audio:GetLocalizationFlag()

		if var_233_0[var_233_1] ~= nil then
			arg_233_1.duration_ = var_233_0[var_233_1]
		end

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play116361053(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			local var_236_0 = "10024ui_story"

			if arg_233_1.actors_[var_236_0] == nil then
				local var_236_1 = Asset.Load("Char/" .. "10024ui_story")

				if not isNil(var_236_1) then
					local var_236_2 = Object.Instantiate(Asset.Load("Char/" .. "10024ui_story"), arg_233_1.stage_.transform)

					var_236_2.name = var_236_0
					var_236_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_233_1.actors_[var_236_0] = var_236_2

					local var_236_3 = var_236_2:GetComponentInChildren(typeof(CharacterEffect))

					var_236_3.enabled = true

					local var_236_4 = GameObjectTools.GetOrAddComponent(var_236_2, typeof(DynamicBoneHelper))

					if var_236_4 then
						var_236_4:EnableDynamicBone(false)
					end

					arg_233_1:ShowWeapon(var_236_3.transform, false)

					arg_233_1.var_[var_236_0 .. "Animator"] = var_236_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_233_1.var_[var_236_0 .. "Animator"].applyRootMotion = true
					arg_233_1.var_[var_236_0 .. "LipSync"] = var_236_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_236_5 = 0

			if var_236_5 < arg_233_1.time_ and arg_233_1.time_ <= var_236_5 + arg_236_0 then
				arg_233_1:PlayTimeline("10024ui_story", "StoryTimeline/CharAction/story10024/story10024action/10024action1_1")
			end

			local var_236_6 = 0

			if var_236_6 < arg_233_1.time_ and arg_233_1.time_ <= var_236_6 + arg_236_0 then
				arg_233_1:PlayTimeline("10024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_236_7 = 0
			local var_236_8 = 0.825

			if var_236_7 < arg_233_1.time_ and arg_233_1.time_ <= var_236_7 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				local var_236_9 = arg_233_1:FormatText(StoryNameCfg[332].name)

				arg_233_1.leftNameTxt_.text = var_236_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, true)
				arg_233_1.iconController_:SetSelectedState("hero")

				arg_233_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10024")

				arg_233_1.callingController_:SetSelectedState("normal")

				arg_233_1.keyicon_.color = Color.New(1, 1, 1)
				arg_233_1.icon_.color = Color.New(1, 1, 1)

				local var_236_10 = arg_233_1:GetWordFromCfg(116361052)
				local var_236_11 = arg_233_1:FormatText(var_236_10.content)

				arg_233_1.text_.text = var_236_11

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_12 = 33
				local var_236_13 = utf8.len(var_236_11)
				local var_236_14 = var_236_12 <= 0 and var_236_8 or var_236_8 * (var_236_13 / var_236_12)

				if var_236_14 > 0 and var_236_8 < var_236_14 then
					arg_233_1.talkMaxDuration = var_236_14

					if var_236_14 + var_236_7 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_14 + var_236_7
					end
				end

				arg_233_1.text_.text = var_236_11
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116361", "116361052", "story_v_out_116361.awb") ~= 0 then
					local var_236_15 = manager.audio:GetVoiceLength("story_v_out_116361", "116361052", "story_v_out_116361.awb") / 1000

					if var_236_15 + var_236_7 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_15 + var_236_7
					end

					if var_236_10.prefab_name ~= "" and arg_233_1.actors_[var_236_10.prefab_name] ~= nil then
						local var_236_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_233_1.actors_[var_236_10.prefab_name].transform, "story_v_out_116361", "116361052", "story_v_out_116361.awb")

						arg_233_1:RecordAudio("116361052", var_236_16)
						arg_233_1:RecordAudio("116361052", var_236_16)
					else
						arg_233_1:AudioAction("play", "voice", "story_v_out_116361", "116361052", "story_v_out_116361.awb")
					end

					arg_233_1:RecordHistoryTalkVoice("story_v_out_116361", "116361052", "story_v_out_116361.awb")
				end

				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_17 = math.max(var_236_8, arg_233_1.talkMaxDuration)

			if var_236_7 <= arg_233_1.time_ and arg_233_1.time_ < var_236_7 + var_236_17 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_7) / var_236_17

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_7 + var_236_17 and arg_233_1.time_ < var_236_7 + var_236_17 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {}

		arg_233_1:InitPlayNodeList()
	end,
	Play116361053 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 116361053
		arg_237_1.duration_ = 9.57

		local var_237_0 = {
			zh = 9.566,
			ja = 6.9
		}
		local var_237_1 = manager.audio:GetLocalizationFlag()

		if var_237_0[var_237_1] ~= nil then
			arg_237_1.duration_ = var_237_0[var_237_1]
		end

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play116361054(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			local var_240_0 = 0

			if var_240_0 < arg_237_1.time_ and arg_237_1.time_ <= var_240_0 + arg_240_0 then
				arg_237_1:PlayTimeline("10032ui_story", "StoryTimeline/CharAction/story10025/story10025actionlink/10025action424")
			end

			local var_240_1 = 0

			if var_240_1 < arg_237_1.time_ and arg_237_1.time_ <= var_240_1 + arg_240_0 then
				arg_237_1:PlayTimeline("10032ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_240_2 = arg_237_1.actors_["10032ui_story"]
			local var_240_3 = 0

			if var_240_3 < arg_237_1.time_ and arg_237_1.time_ <= var_240_3 + arg_240_0 and not isNil(var_240_2) and arg_237_1.var_.characterEffect10032ui_story == nil then
				arg_237_1.var_.characterEffect10032ui_story = var_240_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_240_4 = 0.2

			if var_240_3 <= arg_237_1.time_ and arg_237_1.time_ < var_240_3 + var_240_4 and not isNil(var_240_2) then
				local var_240_5 = (arg_237_1.time_ - var_240_3) / var_240_4

				if arg_237_1.var_.characterEffect10032ui_story and not isNil(var_240_2) then
					arg_237_1.var_.characterEffect10032ui_story.fillFlat = false
				end
			end

			if arg_237_1.time_ >= var_240_3 + var_240_4 and arg_237_1.time_ < var_240_3 + var_240_4 + arg_240_0 and not isNil(var_240_2) and arg_237_1.var_.characterEffect10032ui_story then
				arg_237_1.var_.characterEffect10032ui_story.fillFlat = false
			end

			local var_240_6 = 0
			local var_240_7 = 0.85

			if var_240_6 < arg_237_1.time_ and arg_237_1.time_ <= var_240_6 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				local var_240_8 = arg_237_1:FormatText(StoryNameCfg[328].name)

				arg_237_1.leftNameTxt_.text = var_240_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_9 = arg_237_1:GetWordFromCfg(116361053)
				local var_240_10 = arg_237_1:FormatText(var_240_9.content)

				arg_237_1.text_.text = var_240_10

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_11 = 34
				local var_240_12 = utf8.len(var_240_10)
				local var_240_13 = var_240_11 <= 0 and var_240_7 or var_240_7 * (var_240_12 / var_240_11)

				if var_240_13 > 0 and var_240_7 < var_240_13 then
					arg_237_1.talkMaxDuration = var_240_13

					if var_240_13 + var_240_6 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_13 + var_240_6
					end
				end

				arg_237_1.text_.text = var_240_10
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116361", "116361053", "story_v_out_116361.awb") ~= 0 then
					local var_240_14 = manager.audio:GetVoiceLength("story_v_out_116361", "116361053", "story_v_out_116361.awb") / 1000

					if var_240_14 + var_240_6 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_14 + var_240_6
					end

					if var_240_9.prefab_name ~= "" and arg_237_1.actors_[var_240_9.prefab_name] ~= nil then
						local var_240_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_237_1.actors_[var_240_9.prefab_name].transform, "story_v_out_116361", "116361053", "story_v_out_116361.awb")

						arg_237_1:RecordAudio("116361053", var_240_15)
						arg_237_1:RecordAudio("116361053", var_240_15)
					else
						arg_237_1:AudioAction("play", "voice", "story_v_out_116361", "116361053", "story_v_out_116361.awb")
					end

					arg_237_1:RecordHistoryTalkVoice("story_v_out_116361", "116361053", "story_v_out_116361.awb")
				end

				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_16 = math.max(var_240_7, arg_237_1.talkMaxDuration)

			if var_240_6 <= arg_237_1.time_ and arg_237_1.time_ < var_240_6 + var_240_16 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_6) / var_240_16

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_6 + var_240_16 and arg_237_1.time_ < var_240_6 + var_240_16 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {}

		arg_237_1:InitPlayNodeList()
	end,
	Play116361054 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 116361054
		arg_241_1.duration_ = 13.1

		local var_241_0 = {
			zh = 10.666,
			ja = 13.1
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
				arg_241_0:Play116361055(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			local var_244_0 = arg_241_1.actors_["10032ui_story"]
			local var_244_1 = 0

			if var_244_1 < arg_241_1.time_ and arg_241_1.time_ <= var_244_1 + arg_244_0 and not isNil(var_244_0) and arg_241_1.var_.characterEffect10032ui_story == nil then
				arg_241_1.var_.characterEffect10032ui_story = var_244_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_244_2 = 0.2

			if var_244_1 <= arg_241_1.time_ and arg_241_1.time_ < var_244_1 + var_244_2 and not isNil(var_244_0) then
				local var_244_3 = (arg_241_1.time_ - var_244_1) / var_244_2

				if arg_241_1.var_.characterEffect10032ui_story and not isNil(var_244_0) then
					local var_244_4 = Mathf.Lerp(0, 0.5, var_244_3)

					arg_241_1.var_.characterEffect10032ui_story.fillFlat = true
					arg_241_1.var_.characterEffect10032ui_story.fillRatio = var_244_4
				end
			end

			if arg_241_1.time_ >= var_244_1 + var_244_2 and arg_241_1.time_ < var_244_1 + var_244_2 + arg_244_0 and not isNil(var_244_0) and arg_241_1.var_.characterEffect10032ui_story then
				local var_244_5 = 0.5

				arg_241_1.var_.characterEffect10032ui_story.fillFlat = true
				arg_241_1.var_.characterEffect10032ui_story.fillRatio = var_244_5
			end

			local var_244_6 = 0
			local var_244_7 = 1.075

			if var_244_6 < arg_241_1.time_ and arg_241_1.time_ <= var_244_6 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				local var_244_8 = arg_241_1:FormatText(StoryNameCfg[332].name)

				arg_241_1.leftNameTxt_.text = var_244_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, true)
				arg_241_1.iconController_:SetSelectedState("hero")

				arg_241_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10024")

				arg_241_1.callingController_:SetSelectedState("normal")

				arg_241_1.keyicon_.color = Color.New(1, 1, 1)
				arg_241_1.icon_.color = Color.New(1, 1, 1)

				local var_244_9 = arg_241_1:GetWordFromCfg(116361054)
				local var_244_10 = arg_241_1:FormatText(var_244_9.content)

				arg_241_1.text_.text = var_244_10

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_11 = 43
				local var_244_12 = utf8.len(var_244_10)
				local var_244_13 = var_244_11 <= 0 and var_244_7 or var_244_7 * (var_244_12 / var_244_11)

				if var_244_13 > 0 and var_244_7 < var_244_13 then
					arg_241_1.talkMaxDuration = var_244_13

					if var_244_13 + var_244_6 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_13 + var_244_6
					end
				end

				arg_241_1.text_.text = var_244_10
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116361", "116361054", "story_v_out_116361.awb") ~= 0 then
					local var_244_14 = manager.audio:GetVoiceLength("story_v_out_116361", "116361054", "story_v_out_116361.awb") / 1000

					if var_244_14 + var_244_6 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_14 + var_244_6
					end

					if var_244_9.prefab_name ~= "" and arg_241_1.actors_[var_244_9.prefab_name] ~= nil then
						local var_244_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_241_1.actors_[var_244_9.prefab_name].transform, "story_v_out_116361", "116361054", "story_v_out_116361.awb")

						arg_241_1:RecordAudio("116361054", var_244_15)
						arg_241_1:RecordAudio("116361054", var_244_15)
					else
						arg_241_1:AudioAction("play", "voice", "story_v_out_116361", "116361054", "story_v_out_116361.awb")
					end

					arg_241_1:RecordHistoryTalkVoice("story_v_out_116361", "116361054", "story_v_out_116361.awb")
				end

				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_16 = math.max(var_244_7, arg_241_1.talkMaxDuration)

			if var_244_6 <= arg_241_1.time_ and arg_241_1.time_ < var_244_6 + var_244_16 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_6) / var_244_16

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_6 + var_244_16 and arg_241_1.time_ < var_244_6 + var_244_16 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {}

		arg_241_1:InitPlayNodeList()
	end,
	Play116361055 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 116361055
		arg_245_1.duration_ = 3.57

		local var_245_0 = {
			zh = 2.533,
			ja = 3.566
		}
		local var_245_1 = manager.audio:GetLocalizationFlag()

		if var_245_0[var_245_1] ~= nil then
			arg_245_1.duration_ = var_245_0[var_245_1]
		end

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play116361056(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			local var_248_0 = 0
			local var_248_1 = 0.325

			if var_248_0 < arg_245_1.time_ and arg_245_1.time_ <= var_248_0 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, true)

				local var_248_2 = arg_245_1:FormatText(StoryNameCfg[332].name)

				arg_245_1.leftNameTxt_.text = var_248_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, true)
				arg_245_1.iconController_:SetSelectedState("hero")

				arg_245_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10024")

				arg_245_1.callingController_:SetSelectedState("normal")

				arg_245_1.keyicon_.color = Color.New(1, 1, 1)
				arg_245_1.icon_.color = Color.New(1, 1, 1)

				local var_248_3 = arg_245_1:GetWordFromCfg(116361055)
				local var_248_4 = arg_245_1:FormatText(var_248_3.content)

				arg_245_1.text_.text = var_248_4

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_5 = 13
				local var_248_6 = utf8.len(var_248_4)
				local var_248_7 = var_248_5 <= 0 and var_248_1 or var_248_1 * (var_248_6 / var_248_5)

				if var_248_7 > 0 and var_248_1 < var_248_7 then
					arg_245_1.talkMaxDuration = var_248_7

					if var_248_7 + var_248_0 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_7 + var_248_0
					end
				end

				arg_245_1.text_.text = var_248_4
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116361", "116361055", "story_v_out_116361.awb") ~= 0 then
					local var_248_8 = manager.audio:GetVoiceLength("story_v_out_116361", "116361055", "story_v_out_116361.awb") / 1000

					if var_248_8 + var_248_0 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_8 + var_248_0
					end

					if var_248_3.prefab_name ~= "" and arg_245_1.actors_[var_248_3.prefab_name] ~= nil then
						local var_248_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_245_1.actors_[var_248_3.prefab_name].transform, "story_v_out_116361", "116361055", "story_v_out_116361.awb")

						arg_245_1:RecordAudio("116361055", var_248_9)
						arg_245_1:RecordAudio("116361055", var_248_9)
					else
						arg_245_1:AudioAction("play", "voice", "story_v_out_116361", "116361055", "story_v_out_116361.awb")
					end

					arg_245_1:RecordHistoryTalkVoice("story_v_out_116361", "116361055", "story_v_out_116361.awb")
				end

				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_10 = math.max(var_248_1, arg_245_1.talkMaxDuration)

			if var_248_0 <= arg_245_1.time_ and arg_245_1.time_ < var_248_0 + var_248_10 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_0) / var_248_10

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_0 + var_248_10 and arg_245_1.time_ < var_248_0 + var_248_10 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {}

		arg_245_1:InitPlayNodeList()
	end,
	Play116361056 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 116361056
		arg_249_1.duration_ = 3.47

		local var_249_0 = {
			zh = 1.999999999999,
			ja = 3.466
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
				arg_249_0:Play116361057(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			local var_252_0 = 0

			if var_252_0 < arg_249_1.time_ and arg_249_1.time_ <= var_252_0 + arg_252_0 then
				arg_249_1:PlayTimeline("10032ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_252_1 = arg_249_1.actors_["10032ui_story"]
			local var_252_2 = 0

			if var_252_2 < arg_249_1.time_ and arg_249_1.time_ <= var_252_2 + arg_252_0 and not isNil(var_252_1) and arg_249_1.var_.characterEffect10032ui_story == nil then
				arg_249_1.var_.characterEffect10032ui_story = var_252_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_252_3 = 0.2

			if var_252_2 <= arg_249_1.time_ and arg_249_1.time_ < var_252_2 + var_252_3 and not isNil(var_252_1) then
				local var_252_4 = (arg_249_1.time_ - var_252_2) / var_252_3

				if arg_249_1.var_.characterEffect10032ui_story and not isNil(var_252_1) then
					arg_249_1.var_.characterEffect10032ui_story.fillFlat = false
				end
			end

			if arg_249_1.time_ >= var_252_2 + var_252_3 and arg_249_1.time_ < var_252_2 + var_252_3 + arg_252_0 and not isNil(var_252_1) and arg_249_1.var_.characterEffect10032ui_story then
				arg_249_1.var_.characterEffect10032ui_story.fillFlat = false
			end

			local var_252_5 = 0
			local var_252_6 = 0.175

			if var_252_5 < arg_249_1.time_ and arg_249_1.time_ <= var_252_5 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				local var_252_7 = arg_249_1:FormatText(StoryNameCfg[328].name)

				arg_249_1.leftNameTxt_.text = var_252_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_8 = arg_249_1:GetWordFromCfg(116361056)
				local var_252_9 = arg_249_1:FormatText(var_252_8.content)

				arg_249_1.text_.text = var_252_9

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_10 = 7
				local var_252_11 = utf8.len(var_252_9)
				local var_252_12 = var_252_10 <= 0 and var_252_6 or var_252_6 * (var_252_11 / var_252_10)

				if var_252_12 > 0 and var_252_6 < var_252_12 then
					arg_249_1.talkMaxDuration = var_252_12

					if var_252_12 + var_252_5 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_12 + var_252_5
					end
				end

				arg_249_1.text_.text = var_252_9
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116361", "116361056", "story_v_out_116361.awb") ~= 0 then
					local var_252_13 = manager.audio:GetVoiceLength("story_v_out_116361", "116361056", "story_v_out_116361.awb") / 1000

					if var_252_13 + var_252_5 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_13 + var_252_5
					end

					if var_252_8.prefab_name ~= "" and arg_249_1.actors_[var_252_8.prefab_name] ~= nil then
						local var_252_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_249_1.actors_[var_252_8.prefab_name].transform, "story_v_out_116361", "116361056", "story_v_out_116361.awb")

						arg_249_1:RecordAudio("116361056", var_252_14)
						arg_249_1:RecordAudio("116361056", var_252_14)
					else
						arg_249_1:AudioAction("play", "voice", "story_v_out_116361", "116361056", "story_v_out_116361.awb")
					end

					arg_249_1:RecordHistoryTalkVoice("story_v_out_116361", "116361056", "story_v_out_116361.awb")
				end

				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_15 = math.max(var_252_6, arg_249_1.talkMaxDuration)

			if var_252_5 <= arg_249_1.time_ and arg_249_1.time_ < var_252_5 + var_252_15 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_5) / var_252_15

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_5 + var_252_15 and arg_249_1.time_ < var_252_5 + var_252_15 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {}

		arg_249_1:InitPlayNodeList()
	end,
	Play116361057 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 116361057
		arg_253_1.duration_ = 6.7

		local var_253_0 = {
			zh = 6,
			ja = 6.7
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
				arg_253_0:Play116361058(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			local var_256_0 = arg_253_1.actors_["10032ui_story"]
			local var_256_1 = 0

			if var_256_1 < arg_253_1.time_ and arg_253_1.time_ <= var_256_1 + arg_256_0 and not isNil(var_256_0) and arg_253_1.var_.characterEffect10032ui_story == nil then
				arg_253_1.var_.characterEffect10032ui_story = var_256_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_256_2 = 0.2

			if var_256_1 <= arg_253_1.time_ and arg_253_1.time_ < var_256_1 + var_256_2 and not isNil(var_256_0) then
				local var_256_3 = (arg_253_1.time_ - var_256_1) / var_256_2

				if arg_253_1.var_.characterEffect10032ui_story and not isNil(var_256_0) then
					local var_256_4 = Mathf.Lerp(0, 0.5, var_256_3)

					arg_253_1.var_.characterEffect10032ui_story.fillFlat = true
					arg_253_1.var_.characterEffect10032ui_story.fillRatio = var_256_4
				end
			end

			if arg_253_1.time_ >= var_256_1 + var_256_2 and arg_253_1.time_ < var_256_1 + var_256_2 + arg_256_0 and not isNil(var_256_0) and arg_253_1.var_.characterEffect10032ui_story then
				local var_256_5 = 0.5

				arg_253_1.var_.characterEffect10032ui_story.fillFlat = true
				arg_253_1.var_.characterEffect10032ui_story.fillRatio = var_256_5
			end

			local var_256_6 = 0
			local var_256_7 = 0.65

			if var_256_6 < arg_253_1.time_ and arg_253_1.time_ <= var_256_6 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				local var_256_8 = arg_253_1:FormatText(StoryNameCfg[332].name)

				arg_253_1.leftNameTxt_.text = var_256_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, true)
				arg_253_1.iconController_:SetSelectedState("hero")

				arg_253_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10024")

				arg_253_1.callingController_:SetSelectedState("normal")

				arg_253_1.keyicon_.color = Color.New(1, 1, 1)
				arg_253_1.icon_.color = Color.New(1, 1, 1)

				local var_256_9 = arg_253_1:GetWordFromCfg(116361057)
				local var_256_10 = arg_253_1:FormatText(var_256_9.content)

				arg_253_1.text_.text = var_256_10

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_11 = 26
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

				if manager.audio:GetVoiceLength("story_v_out_116361", "116361057", "story_v_out_116361.awb") ~= 0 then
					local var_256_14 = manager.audio:GetVoiceLength("story_v_out_116361", "116361057", "story_v_out_116361.awb") / 1000

					if var_256_14 + var_256_6 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_14 + var_256_6
					end

					if var_256_9.prefab_name ~= "" and arg_253_1.actors_[var_256_9.prefab_name] ~= nil then
						local var_256_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_253_1.actors_[var_256_9.prefab_name].transform, "story_v_out_116361", "116361057", "story_v_out_116361.awb")

						arg_253_1:RecordAudio("116361057", var_256_15)
						arg_253_1:RecordAudio("116361057", var_256_15)
					else
						arg_253_1:AudioAction("play", "voice", "story_v_out_116361", "116361057", "story_v_out_116361.awb")
					end

					arg_253_1:RecordHistoryTalkVoice("story_v_out_116361", "116361057", "story_v_out_116361.awb")
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
	Play116361058 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 116361058
		arg_257_1.duration_ = 17.7

		local var_257_0 = {
			zh = 17.7,
			ja = 12.6
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
				arg_257_0:Play116361059(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			local var_260_0 = arg_257_1.actors_["10032ui_story"].transform
			local var_260_1 = 0

			if var_260_1 < arg_257_1.time_ and arg_257_1.time_ <= var_260_1 + arg_260_0 then
				arg_257_1.var_.moveOldPos10032ui_story = var_260_0.localPosition
			end

			local var_260_2 = 0.001

			if var_260_1 <= arg_257_1.time_ and arg_257_1.time_ < var_260_1 + var_260_2 then
				local var_260_3 = (arg_257_1.time_ - var_260_1) / var_260_2
				local var_260_4 = Vector3.New(0, 100, 0)

				var_260_0.localPosition = Vector3.Lerp(arg_257_1.var_.moveOldPos10032ui_story, var_260_4, var_260_3)

				local var_260_5 = manager.ui.mainCamera.transform.position - var_260_0.position

				var_260_0.forward = Vector3.New(var_260_5.x, var_260_5.y, var_260_5.z)

				local var_260_6 = var_260_0.localEulerAngles

				var_260_6.z = 0
				var_260_6.x = 0
				var_260_0.localEulerAngles = var_260_6
			end

			if arg_257_1.time_ >= var_260_1 + var_260_2 and arg_257_1.time_ < var_260_1 + var_260_2 + arg_260_0 then
				var_260_0.localPosition = Vector3.New(0, 100, 0)

				local var_260_7 = manager.ui.mainCamera.transform.position - var_260_0.position

				var_260_0.forward = Vector3.New(var_260_7.x, var_260_7.y, var_260_7.z)

				local var_260_8 = var_260_0.localEulerAngles

				var_260_8.z = 0
				var_260_8.x = 0
				var_260_0.localEulerAngles = var_260_8
			end

			local var_260_9 = 0
			local var_260_10 = 1.575

			if var_260_9 < arg_257_1.time_ and arg_257_1.time_ <= var_260_9 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, false)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_11 = arg_257_1:GetWordFromCfg(116361058)
				local var_260_12 = arg_257_1:FormatText(var_260_11.content)

				arg_257_1.text_.text = var_260_12

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_13 = 63
				local var_260_14 = utf8.len(var_260_12)
				local var_260_15 = var_260_13 <= 0 and var_260_10 or var_260_10 * (var_260_14 / var_260_13)

				if var_260_15 > 0 and var_260_10 < var_260_15 then
					arg_257_1.talkMaxDuration = var_260_15

					if var_260_15 + var_260_9 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_15 + var_260_9
					end
				end

				arg_257_1.text_.text = var_260_12
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116361", "116361058", "story_v_out_116361.awb") ~= 0 then
					local var_260_16 = manager.audio:GetVoiceLength("story_v_out_116361", "116361058", "story_v_out_116361.awb") / 1000

					if var_260_16 + var_260_9 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_16 + var_260_9
					end

					if var_260_11.prefab_name ~= "" and arg_257_1.actors_[var_260_11.prefab_name] ~= nil then
						local var_260_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_257_1.actors_[var_260_11.prefab_name].transform, "story_v_out_116361", "116361058", "story_v_out_116361.awb")

						arg_257_1:RecordAudio("116361058", var_260_17)
						arg_257_1:RecordAudio("116361058", var_260_17)
					else
						arg_257_1:AudioAction("play", "voice", "story_v_out_116361", "116361058", "story_v_out_116361.awb")
					end

					arg_257_1:RecordHistoryTalkVoice("story_v_out_116361", "116361058", "story_v_out_116361.awb")
				end

				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_18 = math.max(var_260_10, arg_257_1.talkMaxDuration)

			if var_260_9 <= arg_257_1.time_ and arg_257_1.time_ < var_260_9 + var_260_18 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_9) / var_260_18

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_9 + var_260_18 and arg_257_1.time_ < var_260_9 + var_260_18 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10032ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_257_1:InitPlayNodeList()
	end,
	Play116361059 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 116361059
		arg_261_1.duration_ = 11.9

		local var_261_0 = {
			zh = 11.9,
			ja = 4.433
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
				arg_261_0:Play116361060(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			local var_264_0 = 0
			local var_264_1 = 0.7

			if var_264_0 < arg_261_1.time_ and arg_261_1.time_ <= var_264_0 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, false)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_2 = arg_261_1:GetWordFromCfg(116361059)
				local var_264_3 = arg_261_1:FormatText(var_264_2.content)

				arg_261_1.text_.text = var_264_3

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_4 = 28
				local var_264_5 = utf8.len(var_264_3)
				local var_264_6 = var_264_4 <= 0 and var_264_1 or var_264_1 * (var_264_5 / var_264_4)

				if var_264_6 > 0 and var_264_1 < var_264_6 then
					arg_261_1.talkMaxDuration = var_264_6

					if var_264_6 + var_264_0 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_6 + var_264_0
					end
				end

				arg_261_1.text_.text = var_264_3
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116361", "116361059", "story_v_out_116361.awb") ~= 0 then
					local var_264_7 = manager.audio:GetVoiceLength("story_v_out_116361", "116361059", "story_v_out_116361.awb") / 1000

					if var_264_7 + var_264_0 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_7 + var_264_0
					end

					if var_264_2.prefab_name ~= "" and arg_261_1.actors_[var_264_2.prefab_name] ~= nil then
						local var_264_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_261_1.actors_[var_264_2.prefab_name].transform, "story_v_out_116361", "116361059", "story_v_out_116361.awb")

						arg_261_1:RecordAudio("116361059", var_264_8)
						arg_261_1:RecordAudio("116361059", var_264_8)
					else
						arg_261_1:AudioAction("play", "voice", "story_v_out_116361", "116361059", "story_v_out_116361.awb")
					end

					arg_261_1:RecordHistoryTalkVoice("story_v_out_116361", "116361059", "story_v_out_116361.awb")
				end

				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_9 = math.max(var_264_1, arg_261_1.talkMaxDuration)

			if var_264_0 <= arg_261_1.time_ and arg_261_1.time_ < var_264_0 + var_264_9 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_0) / var_264_9

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_0 + var_264_9 and arg_261_1.time_ < var_264_0 + var_264_9 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {}

		arg_261_1:InitPlayNodeList()
	end,
	Play116361060 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 116361060
		arg_265_1.duration_ = 7.13

		local var_265_0 = {
			zh = 5.266,
			ja = 7.133
		}
		local var_265_1 = manager.audio:GetLocalizationFlag()

		if var_265_0[var_265_1] ~= nil then
			arg_265_1.duration_ = var_265_0[var_265_1]
		end

		SetActive(arg_265_1.tipsGo_, false)

		function arg_265_1.onSingleLineFinish_()
			arg_265_1.onSingleLineUpdate_ = nil
			arg_265_1.onSingleLineFinish_ = nil
			arg_265_1.state_ = "waiting"
			arg_265_1.auto_ = false
		end

		function arg_265_1.playNext_(arg_267_0)
			arg_265_1.onStoryFinished_()
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			local var_268_0 = 0
			local var_268_1 = 0.425

			if var_268_0 < arg_265_1.time_ and arg_265_1.time_ <= var_268_0 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, false)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_2 = arg_265_1:GetWordFromCfg(116361060)
				local var_268_3 = arg_265_1:FormatText(var_268_2.content)

				arg_265_1.text_.text = var_268_3

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_4 = 17
				local var_268_5 = utf8.len(var_268_3)
				local var_268_6 = var_268_4 <= 0 and var_268_1 or var_268_1 * (var_268_5 / var_268_4)

				if var_268_6 > 0 and var_268_1 < var_268_6 then
					arg_265_1.talkMaxDuration = var_268_6

					if var_268_6 + var_268_0 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_6 + var_268_0
					end
				end

				arg_265_1.text_.text = var_268_3
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116361", "116361060", "story_v_out_116361.awb") ~= 0 then
					local var_268_7 = manager.audio:GetVoiceLength("story_v_out_116361", "116361060", "story_v_out_116361.awb") / 1000

					if var_268_7 + var_268_0 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_7 + var_268_0
					end

					if var_268_2.prefab_name ~= "" and arg_265_1.actors_[var_268_2.prefab_name] ~= nil then
						local var_268_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_265_1.actors_[var_268_2.prefab_name].transform, "story_v_out_116361", "116361060", "story_v_out_116361.awb")

						arg_265_1:RecordAudio("116361060", var_268_8)
						arg_265_1:RecordAudio("116361060", var_268_8)
					else
						arg_265_1:AudioAction("play", "voice", "story_v_out_116361", "116361060", "story_v_out_116361.awb")
					end

					arg_265_1:RecordHistoryTalkVoice("story_v_out_116361", "116361060", "story_v_out_116361.awb")
				end

				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_9 = math.max(var_268_1, arg_265_1.talkMaxDuration)

			if var_268_0 <= arg_265_1.time_ and arg_265_1.time_ < var_268_0 + var_268_9 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_0) / var_268_9

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_0 + var_268_9 and arg_265_1.time_ < var_268_0 + var_268_9 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {}

		arg_265_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/I07a",
		"SofdecAsset/story/story_101161201.usm",
		"TextureConfig/Background/ST15",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/ST03_blur",
		"TextureConfig/Background/I05",
		"TextureConfig/Background/STwhite"
	},
	voices = {
		"story_v_out_116361.awb"
	},
	skipMarkers = {
		116361001,
		116361005
	}
}
