return {
	Play109011001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 109011001
		arg_1_1.duration_ = 5

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play109011002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = 0
			local var_4_1 = 1

			if var_4_0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_0 + arg_4_0 then
				local var_4_2 = "play"
				local var_4_3 = "music"

				arg_1_1:AudioAction(var_4_2, var_4_3, "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1.awb")

				local var_4_4 = ""
				local var_4_5 = manager.audio:GetAudioName("bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1")

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
			local var_4_7 = 0.575

			if var_4_6 < arg_1_1.time_ and arg_1_1.time_ <= var_4_6 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_8 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_8:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_8:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_8:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_9 = arg_1_1:GetWordFromCfg(109011001)
				local var_4_10 = arg_1_1:FormatText(var_4_9.content)

				arg_1_1.text_.text = var_4_10

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_11 = 23
				local var_4_12 = utf8.len(var_4_10)
				local var_4_13 = var_4_11 <= 0 and var_4_7 or var_4_7 * (var_4_12 / var_4_11)

				if var_4_13 > 0 and var_4_7 < var_4_13 then
					arg_1_1.talkMaxDuration = var_4_13
					var_4_6 = var_4_6 + 0.3

					if var_4_13 + var_4_6 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_13 + var_4_6
					end
				end

				arg_1_1.text_.text = var_4_10
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_14 = var_4_6 + 0.3
			local var_4_15 = math.max(var_4_7, arg_1_1.talkMaxDuration)

			if var_4_14 <= arg_1_1.time_ and arg_1_1.time_ < var_4_14 + var_4_15 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_14) / var_4_15

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_14 + var_4_15 and arg_1_1.time_ < var_4_14 + var_4_15 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play109011002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 109011002
		arg_8_1.duration_ = 10.3

		local var_8_0 = {
			ja = 8,
			ko = 9.833,
			zh = 10.266,
			en = 10.3
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
				arg_8_0:Play109011003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = "C05b"

			if arg_8_1.bgs_[var_11_0] == nil then
				local var_11_1 = Object.Instantiate(arg_8_1.paintGo_)

				var_11_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_11_0)
				var_11_1.name = var_11_0
				var_11_1.transform.parent = arg_8_1.stage_.transform
				var_11_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_8_1.bgs_[var_11_0] = var_11_1
			end

			local var_11_2 = 0

			if var_11_2 < arg_8_1.time_ and arg_8_1.time_ <= var_11_2 + arg_11_0 then
				local var_11_3 = manager.ui.mainCamera.transform.localPosition
				local var_11_4 = Vector3.New(0, 0, 10) + Vector3.New(var_11_3.x, var_11_3.y, 0)
				local var_11_5 = arg_8_1.bgs_.C05b

				var_11_5.transform.localPosition = var_11_4
				var_11_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_11_6 = var_11_5:GetComponent("SpriteRenderer")

				if var_11_6 and var_11_6.sprite then
					local var_11_7 = (var_11_5.transform.localPosition - var_11_3).z
					local var_11_8 = manager.ui.mainCameraCom_
					local var_11_9 = 2 * var_11_7 * Mathf.Tan(var_11_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_11_10 = var_11_9 * var_11_8.aspect
					local var_11_11 = var_11_6.sprite.bounds.size.x
					local var_11_12 = var_11_6.sprite.bounds.size.y
					local var_11_13 = var_11_10 / var_11_11
					local var_11_14 = var_11_9 / var_11_12
					local var_11_15 = var_11_14 < var_11_13 and var_11_13 or var_11_14

					var_11_5.transform.localScale = Vector3.New(var_11_15, var_11_15, 0)
				end

				for iter_11_0, iter_11_1 in pairs(arg_8_1.bgs_) do
					if iter_11_0 ~= "C05b" then
						iter_11_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_11_16 = arg_8_1.bgs_.C05b
			local var_11_17 = 0

			if var_11_17 < arg_8_1.time_ and arg_8_1.time_ <= var_11_17 + arg_11_0 then
				local var_11_18 = var_11_16:GetComponent("SpriteRenderer")

				if var_11_18 then
					arg_8_1.var_.alphaOldValueC05b = var_11_18.color.a
					arg_8_1.var_.alphaMatValueC05b = var_11_18
				end

				arg_8_1.var_.alphaOldValueC05b = 0
			end

			local var_11_19 = 1.5

			if var_11_17 <= arg_8_1.time_ and arg_8_1.time_ < var_11_17 + var_11_19 then
				local var_11_20 = (arg_8_1.time_ - var_11_17) / var_11_19
				local var_11_21 = Mathf.Lerp(arg_8_1.var_.alphaOldValueC05b, 1, var_11_20)

				if arg_8_1.var_.alphaMatValueC05b then
					local var_11_22 = arg_8_1.var_.alphaMatValueC05b.color

					var_11_22.a = var_11_21
					arg_8_1.var_.alphaMatValueC05b.color = var_11_22
				end
			end

			if arg_8_1.time_ >= var_11_17 + var_11_19 and arg_8_1.time_ < var_11_17 + var_11_19 + arg_11_0 and arg_8_1.var_.alphaMatValueC05b then
				local var_11_23 = arg_8_1.var_.alphaMatValueC05b
				local var_11_24 = var_11_23.color

				var_11_24.a = 1
				var_11_23.color = var_11_24
			end

			local var_11_25 = "1084ui_story"

			if arg_8_1.actors_[var_11_25] == nil then
				local var_11_26 = Asset.Load("Char/" .. "1084ui_story")

				if not isNil(var_11_26) then
					local var_11_27 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_8_1.stage_.transform)

					var_11_27.name = var_11_25
					var_11_27.transform.localPosition = Vector3.New(0, 100, 0)
					arg_8_1.actors_[var_11_25] = var_11_27

					local var_11_28 = var_11_27:GetComponentInChildren(typeof(CharacterEffect))

					var_11_28.enabled = true

					local var_11_29 = GameObjectTools.GetOrAddComponent(var_11_27, typeof(DynamicBoneHelper))

					if var_11_29 then
						var_11_29:EnableDynamicBone(false)
					end

					arg_8_1:ShowWeapon(var_11_28.transform, false)

					arg_8_1.var_[var_11_25 .. "Animator"] = var_11_28.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_8_1.var_[var_11_25 .. "Animator"].applyRootMotion = true
					arg_8_1.var_[var_11_25 .. "LipSync"] = var_11_28.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_11_30 = arg_8_1.actors_["1084ui_story"]
			local var_11_31 = 1.8

			if var_11_31 < arg_8_1.time_ and arg_8_1.time_ <= var_11_31 + arg_11_0 and not isNil(var_11_30) and arg_8_1.var_.characterEffect1084ui_story == nil then
				arg_8_1.var_.characterEffect1084ui_story = var_11_30:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_32 = 0.2

			if var_11_31 <= arg_8_1.time_ and arg_8_1.time_ < var_11_31 + var_11_32 and not isNil(var_11_30) then
				local var_11_33 = (arg_8_1.time_ - var_11_31) / var_11_32

				if arg_8_1.var_.characterEffect1084ui_story and not isNil(var_11_30) then
					arg_8_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_8_1.time_ >= var_11_31 + var_11_32 and arg_8_1.time_ < var_11_31 + var_11_32 + arg_11_0 and not isNil(var_11_30) and arg_8_1.var_.characterEffect1084ui_story then
				arg_8_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_11_34 = arg_8_1.actors_["1084ui_story"].transform
			local var_11_35 = 1.8

			if var_11_35 < arg_8_1.time_ and arg_8_1.time_ <= var_11_35 + arg_11_0 then
				arg_8_1.var_.moveOldPos1084ui_story = var_11_34.localPosition
			end

			local var_11_36 = 0.001

			if var_11_35 <= arg_8_1.time_ and arg_8_1.time_ < var_11_35 + var_11_36 then
				local var_11_37 = (arg_8_1.time_ - var_11_35) / var_11_36
				local var_11_38 = Vector3.New(-0.7, -0.97, -6)

				var_11_34.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos1084ui_story, var_11_38, var_11_37)

				local var_11_39 = manager.ui.mainCamera.transform.position - var_11_34.position

				var_11_34.forward = Vector3.New(var_11_39.x, var_11_39.y, var_11_39.z)

				local var_11_40 = var_11_34.localEulerAngles

				var_11_40.z = 0
				var_11_40.x = 0
				var_11_34.localEulerAngles = var_11_40
			end

			if arg_8_1.time_ >= var_11_35 + var_11_36 and arg_8_1.time_ < var_11_35 + var_11_36 + arg_11_0 then
				var_11_34.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_11_41 = manager.ui.mainCamera.transform.position - var_11_34.position

				var_11_34.forward = Vector3.New(var_11_41.x, var_11_41.y, var_11_41.z)

				local var_11_42 = var_11_34.localEulerAngles

				var_11_42.z = 0
				var_11_42.x = 0
				var_11_34.localEulerAngles = var_11_42
			end

			local var_11_43 = 1.8

			if var_11_43 < arg_8_1.time_ and arg_8_1.time_ <= var_11_43 + arg_11_0 then
				arg_8_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action6_1")
			end

			local var_11_44 = 1.8

			if var_11_44 < arg_8_1.time_ and arg_8_1.time_ <= var_11_44 + arg_11_0 then
				arg_8_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_11_45 = 0

			if var_11_45 < arg_8_1.time_ and arg_8_1.time_ <= var_11_45 + arg_11_0 then
				arg_8_1.allBtn_.enabled = false
			end

			local var_11_46 = 2

			if arg_8_1.time_ >= var_11_45 + var_11_46 and arg_8_1.time_ < var_11_45 + var_11_46 + arg_11_0 then
				arg_8_1.allBtn_.enabled = true
			end

			local var_11_47 = 2
			local var_11_48 = 0.725

			if var_11_47 < arg_8_1.time_ and arg_8_1.time_ <= var_11_47 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				local var_11_49 = arg_8_1:FormatText(StoryNameCfg[6].name)

				arg_8_1.leftNameTxt_.text = var_11_49

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_50 = arg_8_1:GetWordFromCfg(109011002)
				local var_11_51 = arg_8_1:FormatText(var_11_50.content)

				arg_8_1.text_.text = var_11_51

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_52 = 29
				local var_11_53 = utf8.len(var_11_51)
				local var_11_54 = var_11_52 <= 0 and var_11_48 or var_11_48 * (var_11_53 / var_11_52)

				if var_11_54 > 0 and var_11_48 < var_11_54 then
					arg_8_1.talkMaxDuration = var_11_54

					if var_11_54 + var_11_47 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_54 + var_11_47
					end
				end

				arg_8_1.text_.text = var_11_51
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109011", "109011002", "story_v_out_109011.awb") ~= 0 then
					local var_11_55 = manager.audio:GetVoiceLength("story_v_out_109011", "109011002", "story_v_out_109011.awb") / 1000

					if var_11_55 + var_11_47 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_55 + var_11_47
					end

					if var_11_50.prefab_name ~= "" and arg_8_1.actors_[var_11_50.prefab_name] ~= nil then
						local var_11_56 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_50.prefab_name].transform, "story_v_out_109011", "109011002", "story_v_out_109011.awb")

						arg_8_1:RecordAudio("109011002", var_11_56)
						arg_8_1:RecordAudio("109011002", var_11_56)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_109011", "109011002", "story_v_out_109011.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_109011", "109011002", "story_v_out_109011.awb")
				end

				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_57 = math.max(var_11_48, arg_8_1.talkMaxDuration)

			if var_11_47 <= arg_8_1.time_ and arg_8_1.time_ < var_11_47 + var_11_57 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_47) / var_11_57

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_47 + var_11_57 and arg_8_1.time_ < var_11_47 + var_11_57 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 1.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_8_1:InitPlayNodeList()
	end,
	Play109011003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 109011003
		arg_12_1.duration_ = 5.6

		local var_12_0 = {
			ja = 3.533,
			ko = 5.033,
			zh = 5.6,
			en = 4.533
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
				arg_12_0:Play109011004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = "1038ui_story"

			if arg_12_1.actors_[var_15_0] == nil then
				local var_15_1 = Asset.Load("Char/" .. "1038ui_story")

				if not isNil(var_15_1) then
					local var_15_2 = Object.Instantiate(Asset.Load("Char/" .. "1038ui_story"), arg_12_1.stage_.transform)

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

			local var_15_5 = arg_12_1.actors_["1038ui_story"].transform
			local var_15_6 = 0

			if var_15_6 < arg_12_1.time_ and arg_12_1.time_ <= var_15_6 + arg_15_0 then
				arg_12_1.var_.moveOldPos1038ui_story = var_15_5.localPosition
			end

			local var_15_7 = 0.001

			if var_15_6 <= arg_12_1.time_ and arg_12_1.time_ < var_15_6 + var_15_7 then
				local var_15_8 = (arg_12_1.time_ - var_15_6) / var_15_7
				local var_15_9 = Vector3.New(0.7, -1.11, -5.9)

				var_15_5.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos1038ui_story, var_15_9, var_15_8)

				local var_15_10 = manager.ui.mainCamera.transform.position - var_15_5.position

				var_15_5.forward = Vector3.New(var_15_10.x, var_15_10.y, var_15_10.z)

				local var_15_11 = var_15_5.localEulerAngles

				var_15_11.z = 0
				var_15_11.x = 0
				var_15_5.localEulerAngles = var_15_11
			end

			if arg_12_1.time_ >= var_15_6 + var_15_7 and arg_12_1.time_ < var_15_6 + var_15_7 + arg_15_0 then
				var_15_5.localPosition = Vector3.New(0.7, -1.11, -5.9)

				local var_15_12 = manager.ui.mainCamera.transform.position - var_15_5.position

				var_15_5.forward = Vector3.New(var_15_12.x, var_15_12.y, var_15_12.z)

				local var_15_13 = var_15_5.localEulerAngles

				var_15_13.z = 0
				var_15_13.x = 0
				var_15_5.localEulerAngles = var_15_13
			end

			local var_15_14 = arg_12_1.actors_["1038ui_story"]
			local var_15_15 = 0

			if var_15_15 < arg_12_1.time_ and arg_12_1.time_ <= var_15_15 + arg_15_0 and not isNil(var_15_14) and arg_12_1.var_.characterEffect1038ui_story == nil then
				arg_12_1.var_.characterEffect1038ui_story = var_15_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_16 = 0.2

			if var_15_15 <= arg_12_1.time_ and arg_12_1.time_ < var_15_15 + var_15_16 and not isNil(var_15_14) then
				local var_15_17 = (arg_12_1.time_ - var_15_15) / var_15_16

				if arg_12_1.var_.characterEffect1038ui_story and not isNil(var_15_14) then
					arg_12_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_12_1.time_ >= var_15_15 + var_15_16 and arg_12_1.time_ < var_15_15 + var_15_16 + arg_15_0 and not isNil(var_15_14) and arg_12_1.var_.characterEffect1038ui_story then
				arg_12_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_15_18 = arg_12_1.actors_["1084ui_story"]
			local var_15_19 = 0

			if var_15_19 < arg_12_1.time_ and arg_12_1.time_ <= var_15_19 + arg_15_0 and not isNil(var_15_18) and arg_12_1.var_.characterEffect1084ui_story == nil then
				arg_12_1.var_.characterEffect1084ui_story = var_15_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_20 = 0.2

			if var_15_19 <= arg_12_1.time_ and arg_12_1.time_ < var_15_19 + var_15_20 and not isNil(var_15_18) then
				local var_15_21 = (arg_12_1.time_ - var_15_19) / var_15_20

				if arg_12_1.var_.characterEffect1084ui_story and not isNil(var_15_18) then
					local var_15_22 = Mathf.Lerp(0, 0.5, var_15_21)

					arg_12_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_12_1.var_.characterEffect1084ui_story.fillRatio = var_15_22
				end
			end

			if arg_12_1.time_ >= var_15_19 + var_15_20 and arg_12_1.time_ < var_15_19 + var_15_20 + arg_15_0 and not isNil(var_15_18) and arg_12_1.var_.characterEffect1084ui_story then
				local var_15_23 = 0.5

				arg_12_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_12_1.var_.characterEffect1084ui_story.fillRatio = var_15_23
			end

			local var_15_24 = 0

			if var_15_24 < arg_12_1.time_ and arg_12_1.time_ <= var_15_24 + arg_15_0 then
				arg_12_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038action/1038action3_1")
			end

			local var_15_25 = 0

			if var_15_25 < arg_12_1.time_ and arg_12_1.time_ <= var_15_25 + arg_15_0 then
				arg_12_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_15_26 = 0
			local var_15_27 = 0.55

			if var_15_26 < arg_12_1.time_ and arg_12_1.time_ <= var_15_26 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				local var_15_28 = arg_12_1:FormatText(StoryNameCfg[94].name)

				arg_12_1.leftNameTxt_.text = var_15_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_29 = arg_12_1:GetWordFromCfg(109011003)
				local var_15_30 = arg_12_1:FormatText(var_15_29.content)

				arg_12_1.text_.text = var_15_30

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_31 = 22
				local var_15_32 = utf8.len(var_15_30)
				local var_15_33 = var_15_31 <= 0 and var_15_27 or var_15_27 * (var_15_32 / var_15_31)

				if var_15_33 > 0 and var_15_27 < var_15_33 then
					arg_12_1.talkMaxDuration = var_15_33

					if var_15_33 + var_15_26 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_33 + var_15_26
					end
				end

				arg_12_1.text_.text = var_15_30
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109011", "109011003", "story_v_out_109011.awb") ~= 0 then
					local var_15_34 = manager.audio:GetVoiceLength("story_v_out_109011", "109011003", "story_v_out_109011.awb") / 1000

					if var_15_34 + var_15_26 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_34 + var_15_26
					end

					if var_15_29.prefab_name ~= "" and arg_12_1.actors_[var_15_29.prefab_name] ~= nil then
						local var_15_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_29.prefab_name].transform, "story_v_out_109011", "109011003", "story_v_out_109011.awb")

						arg_12_1:RecordAudio("109011003", var_15_35)
						arg_12_1:RecordAudio("109011003", var_15_35)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_109011", "109011003", "story_v_out_109011.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_109011", "109011003", "story_v_out_109011.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_36 = math.max(var_15_27, arg_12_1.talkMaxDuration)

			if var_15_26 <= arg_12_1.time_ and arg_12_1.time_ < var_15_26 + var_15_36 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_26) / var_15_36

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_26 + var_15_36 and arg_12_1.time_ < var_15_26 + var_15_36 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {
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

		arg_12_1:InitPlayNodeList()
	end,
	Play109011004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 109011004
		arg_16_1.duration_ = 11.43

		local var_16_0 = {
			ja = 10.166,
			ko = 8.9,
			zh = 8.2,
			en = 11.433
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
				arg_16_0:Play109011005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = arg_16_1.actors_["1038ui_story"]
			local var_19_1 = 0

			if var_19_1 < arg_16_1.time_ and arg_16_1.time_ <= var_19_1 + arg_19_0 and not isNil(var_19_0) and arg_16_1.var_.characterEffect1038ui_story == nil then
				arg_16_1.var_.characterEffect1038ui_story = var_19_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_2 = 0.2

			if var_19_1 <= arg_16_1.time_ and arg_16_1.time_ < var_19_1 + var_19_2 and not isNil(var_19_0) then
				local var_19_3 = (arg_16_1.time_ - var_19_1) / var_19_2

				if arg_16_1.var_.characterEffect1038ui_story and not isNil(var_19_0) then
					local var_19_4 = Mathf.Lerp(0, 0.5, var_19_3)

					arg_16_1.var_.characterEffect1038ui_story.fillFlat = true
					arg_16_1.var_.characterEffect1038ui_story.fillRatio = var_19_4
				end
			end

			if arg_16_1.time_ >= var_19_1 + var_19_2 and arg_16_1.time_ < var_19_1 + var_19_2 + arg_19_0 and not isNil(var_19_0) and arg_16_1.var_.characterEffect1038ui_story then
				local var_19_5 = 0.5

				arg_16_1.var_.characterEffect1038ui_story.fillFlat = true
				arg_16_1.var_.characterEffect1038ui_story.fillRatio = var_19_5
			end

			local var_19_6 = arg_16_1.actors_["1084ui_story"]
			local var_19_7 = 0

			if var_19_7 < arg_16_1.time_ and arg_16_1.time_ <= var_19_7 + arg_19_0 and not isNil(var_19_6) and arg_16_1.var_.characterEffect1084ui_story == nil then
				arg_16_1.var_.characterEffect1084ui_story = var_19_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_8 = 0.2

			if var_19_7 <= arg_16_1.time_ and arg_16_1.time_ < var_19_7 + var_19_8 and not isNil(var_19_6) then
				local var_19_9 = (arg_16_1.time_ - var_19_7) / var_19_8

				if arg_16_1.var_.characterEffect1084ui_story and not isNil(var_19_6) then
					local var_19_10 = Mathf.Lerp(0, 0.5, var_19_9)

					arg_16_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_16_1.var_.characterEffect1084ui_story.fillRatio = var_19_10
				end
			end

			if arg_16_1.time_ >= var_19_7 + var_19_8 and arg_16_1.time_ < var_19_7 + var_19_8 + arg_19_0 and not isNil(var_19_6) and arg_16_1.var_.characterEffect1084ui_story then
				local var_19_11 = 0.5

				arg_16_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_16_1.var_.characterEffect1084ui_story.fillRatio = var_19_11
			end

			local var_19_12 = 0
			local var_19_13 = 1

			if var_19_12 < arg_16_1.time_ and arg_16_1.time_ <= var_19_12 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				local var_19_14 = arg_16_1:FormatText(StoryNameCfg[10].name)

				arg_16_1.leftNameTxt_.text = var_19_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, true)
				arg_16_1.iconController_:SetSelectedState("hero")

				arg_16_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_16_1.callingController_:SetSelectedState("normal")

				arg_16_1.keyicon_.color = Color.New(1, 1, 1)
				arg_16_1.icon_.color = Color.New(1, 1, 1)

				local var_19_15 = arg_16_1:GetWordFromCfg(109011004)
				local var_19_16 = arg_16_1:FormatText(var_19_15.content)

				arg_16_1.text_.text = var_19_16

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_17 = 40
				local var_19_18 = utf8.len(var_19_16)
				local var_19_19 = var_19_17 <= 0 and var_19_13 or var_19_13 * (var_19_18 / var_19_17)

				if var_19_19 > 0 and var_19_13 < var_19_19 then
					arg_16_1.talkMaxDuration = var_19_19

					if var_19_19 + var_19_12 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_19 + var_19_12
					end
				end

				arg_16_1.text_.text = var_19_16
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109011", "109011004", "story_v_out_109011.awb") ~= 0 then
					local var_19_20 = manager.audio:GetVoiceLength("story_v_out_109011", "109011004", "story_v_out_109011.awb") / 1000

					if var_19_20 + var_19_12 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_20 + var_19_12
					end

					if var_19_15.prefab_name ~= "" and arg_16_1.actors_[var_19_15.prefab_name] ~= nil then
						local var_19_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_15.prefab_name].transform, "story_v_out_109011", "109011004", "story_v_out_109011.awb")

						arg_16_1:RecordAudio("109011004", var_19_21)
						arg_16_1:RecordAudio("109011004", var_19_21)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_109011", "109011004", "story_v_out_109011.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_109011", "109011004", "story_v_out_109011.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_22 = math.max(var_19_13, arg_16_1.talkMaxDuration)

			if var_19_12 <= arg_16_1.time_ and arg_16_1.time_ < var_19_12 + var_19_22 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_12) / var_19_22

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_12 + var_19_22 and arg_16_1.time_ < var_19_12 + var_19_22 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play109011005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 109011005
		arg_20_1.duration_ = 4.6

		local var_20_0 = {
			ja = 3.466,
			ko = 2.833,
			zh = 2.866,
			en = 4.6
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
				arg_20_0:Play109011006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = 0

			if var_23_0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_0 + arg_23_0 then
				arg_20_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action6_2")
			end

			local var_23_1 = 0
			local var_23_2 = 0.25

			if var_23_1 < arg_20_1.time_ and arg_20_1.time_ <= var_23_1 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				local var_23_3 = arg_20_1:FormatText(StoryNameCfg[74].name)

				arg_20_1.leftNameTxt_.text = var_23_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, true)
				arg_20_1.iconController_:SetSelectedState("hero")

				arg_20_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1050")

				arg_20_1.callingController_:SetSelectedState("normal")

				arg_20_1.keyicon_.color = Color.New(1, 1, 1)
				arg_20_1.icon_.color = Color.New(1, 1, 1)

				local var_23_4 = arg_20_1:GetWordFromCfg(109011005)
				local var_23_5 = arg_20_1:FormatText(var_23_4.content)

				arg_20_1.text_.text = var_23_5

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_6 = 10
				local var_23_7 = utf8.len(var_23_5)
				local var_23_8 = var_23_6 <= 0 and var_23_2 or var_23_2 * (var_23_7 / var_23_6)

				if var_23_8 > 0 and var_23_2 < var_23_8 then
					arg_20_1.talkMaxDuration = var_23_8

					if var_23_8 + var_23_1 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_8 + var_23_1
					end
				end

				arg_20_1.text_.text = var_23_5
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109011", "109011005", "story_v_out_109011.awb") ~= 0 then
					local var_23_9 = manager.audio:GetVoiceLength("story_v_out_109011", "109011005", "story_v_out_109011.awb") / 1000

					if var_23_9 + var_23_1 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_9 + var_23_1
					end

					if var_23_4.prefab_name ~= "" and arg_20_1.actors_[var_23_4.prefab_name] ~= nil then
						local var_23_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_4.prefab_name].transform, "story_v_out_109011", "109011005", "story_v_out_109011.awb")

						arg_20_1:RecordAudio("109011005", var_23_10)
						arg_20_1:RecordAudio("109011005", var_23_10)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_109011", "109011005", "story_v_out_109011.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_109011", "109011005", "story_v_out_109011.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_11 = math.max(var_23_2, arg_20_1.talkMaxDuration)

			if var_23_1 <= arg_20_1.time_ and arg_20_1.time_ < var_23_1 + var_23_11 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_1) / var_23_11

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_1 + var_23_11 and arg_20_1.time_ < var_23_1 + var_23_11 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play109011006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 109011006
		arg_24_1.duration_ = 5.27

		local var_24_0 = {
			ja = 3.1,
			ko = 3.066,
			zh = 3.966,
			en = 5.266
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
				arg_24_0:Play109011007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = arg_24_1.actors_["1038ui_story"]
			local var_27_1 = 0

			if var_27_1 < arg_24_1.time_ and arg_24_1.time_ <= var_27_1 + arg_27_0 and not isNil(var_27_0) and arg_24_1.var_.characterEffect1038ui_story == nil then
				arg_24_1.var_.characterEffect1038ui_story = var_27_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_2 = 0.2

			if var_27_1 <= arg_24_1.time_ and arg_24_1.time_ < var_27_1 + var_27_2 and not isNil(var_27_0) then
				local var_27_3 = (arg_24_1.time_ - var_27_1) / var_27_2

				if arg_24_1.var_.characterEffect1038ui_story and not isNil(var_27_0) then
					arg_24_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_24_1.time_ >= var_27_1 + var_27_2 and arg_24_1.time_ < var_27_1 + var_27_2 + arg_27_0 and not isNil(var_27_0) and arg_24_1.var_.characterEffect1038ui_story then
				arg_24_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_27_4 = 0

			if var_27_4 < arg_24_1.time_ and arg_24_1.time_ <= var_27_4 + arg_27_0 then
				arg_24_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038actionlink/1038action435")
			end

			local var_27_5 = 0

			if var_27_5 < arg_24_1.time_ and arg_24_1.time_ <= var_27_5 + arg_27_0 then
				arg_24_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0203cva")
			end

			local var_27_6 = 0
			local var_27_7 = 0.35

			if var_27_6 < arg_24_1.time_ and arg_24_1.time_ <= var_27_6 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				local var_27_8 = arg_24_1:FormatText(StoryNameCfg[94].name)

				arg_24_1.leftNameTxt_.text = var_27_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_9 = arg_24_1:GetWordFromCfg(109011006)
				local var_27_10 = arg_24_1:FormatText(var_27_9.content)

				arg_24_1.text_.text = var_27_10

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_11 = 14
				local var_27_12 = utf8.len(var_27_10)
				local var_27_13 = var_27_11 <= 0 and var_27_7 or var_27_7 * (var_27_12 / var_27_11)

				if var_27_13 > 0 and var_27_7 < var_27_13 then
					arg_24_1.talkMaxDuration = var_27_13

					if var_27_13 + var_27_6 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_13 + var_27_6
					end
				end

				arg_24_1.text_.text = var_27_10
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109011", "109011006", "story_v_out_109011.awb") ~= 0 then
					local var_27_14 = manager.audio:GetVoiceLength("story_v_out_109011", "109011006", "story_v_out_109011.awb") / 1000

					if var_27_14 + var_27_6 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_14 + var_27_6
					end

					if var_27_9.prefab_name ~= "" and arg_24_1.actors_[var_27_9.prefab_name] ~= nil then
						local var_27_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_9.prefab_name].transform, "story_v_out_109011", "109011006", "story_v_out_109011.awb")

						arg_24_1:RecordAudio("109011006", var_27_15)
						arg_24_1:RecordAudio("109011006", var_27_15)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_109011", "109011006", "story_v_out_109011.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_109011", "109011006", "story_v_out_109011.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_16 = math.max(var_27_7, arg_24_1.talkMaxDuration)

			if var_27_6 <= arg_24_1.time_ and arg_24_1.time_ < var_27_6 + var_27_16 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_6) / var_27_16

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_6 + var_27_16 and arg_24_1.time_ < var_27_6 + var_27_16 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play109011007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 109011007
		arg_28_1.duration_ = 4.87

		local var_28_0 = {
			ja = 4.1,
			ko = 3.433,
			zh = 4.866,
			en = 4.733
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
				arg_28_0:Play109011008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = arg_28_1.actors_["1084ui_story"]
			local var_31_1 = 0

			if var_31_1 < arg_28_1.time_ and arg_28_1.time_ <= var_31_1 + arg_31_0 and not isNil(var_31_0) and arg_28_1.var_.characterEffect1084ui_story == nil then
				arg_28_1.var_.characterEffect1084ui_story = var_31_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_2 = 0.2

			if var_31_1 <= arg_28_1.time_ and arg_28_1.time_ < var_31_1 + var_31_2 and not isNil(var_31_0) then
				local var_31_3 = (arg_28_1.time_ - var_31_1) / var_31_2

				if arg_28_1.var_.characterEffect1084ui_story and not isNil(var_31_0) then
					arg_28_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_28_1.time_ >= var_31_1 + var_31_2 and arg_28_1.time_ < var_31_1 + var_31_2 + arg_31_0 and not isNil(var_31_0) and arg_28_1.var_.characterEffect1084ui_story then
				arg_28_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_31_4 = arg_28_1.actors_["1038ui_story"]
			local var_31_5 = 0

			if var_31_5 < arg_28_1.time_ and arg_28_1.time_ <= var_31_5 + arg_31_0 and not isNil(var_31_4) and arg_28_1.var_.characterEffect1038ui_story == nil then
				arg_28_1.var_.characterEffect1038ui_story = var_31_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_6 = 0.2

			if var_31_5 <= arg_28_1.time_ and arg_28_1.time_ < var_31_5 + var_31_6 and not isNil(var_31_4) then
				local var_31_7 = (arg_28_1.time_ - var_31_5) / var_31_6

				if arg_28_1.var_.characterEffect1038ui_story and not isNil(var_31_4) then
					local var_31_8 = Mathf.Lerp(0, 0.5, var_31_7)

					arg_28_1.var_.characterEffect1038ui_story.fillFlat = true
					arg_28_1.var_.characterEffect1038ui_story.fillRatio = var_31_8
				end
			end

			if arg_28_1.time_ >= var_31_5 + var_31_6 and arg_28_1.time_ < var_31_5 + var_31_6 + arg_31_0 and not isNil(var_31_4) and arg_28_1.var_.characterEffect1038ui_story then
				local var_31_9 = 0.5

				arg_28_1.var_.characterEffect1038ui_story.fillFlat = true
				arg_28_1.var_.characterEffect1038ui_story.fillRatio = var_31_9
			end

			local var_31_10 = 0

			if var_31_10 < arg_28_1.time_ and arg_28_1.time_ <= var_31_10 + arg_31_0 then
				arg_28_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action8_1")
			end

			local var_31_11 = 0

			if var_31_11 < arg_28_1.time_ and arg_28_1.time_ <= var_31_11 + arg_31_0 then
				arg_28_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1204cva")
			end

			local var_31_12 = 0
			local var_31_13 = 0.625

			if var_31_12 < arg_28_1.time_ and arg_28_1.time_ <= var_31_12 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				local var_31_14 = arg_28_1:FormatText(StoryNameCfg[6].name)

				arg_28_1.leftNameTxt_.text = var_31_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_15 = arg_28_1:GetWordFromCfg(109011007)
				local var_31_16 = arg_28_1:FormatText(var_31_15.content)

				arg_28_1.text_.text = var_31_16

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_17 = 25
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

				if manager.audio:GetVoiceLength("story_v_out_109011", "109011007", "story_v_out_109011.awb") ~= 0 then
					local var_31_20 = manager.audio:GetVoiceLength("story_v_out_109011", "109011007", "story_v_out_109011.awb") / 1000

					if var_31_20 + var_31_12 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_20 + var_31_12
					end

					if var_31_15.prefab_name ~= "" and arg_28_1.actors_[var_31_15.prefab_name] ~= nil then
						local var_31_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_15.prefab_name].transform, "story_v_out_109011", "109011007", "story_v_out_109011.awb")

						arg_28_1:RecordAudio("109011007", var_31_21)
						arg_28_1:RecordAudio("109011007", var_31_21)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_109011", "109011007", "story_v_out_109011.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_109011", "109011007", "story_v_out_109011.awb")
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
	Play109011008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 109011008
		arg_32_1.duration_ = 6.9

		local var_32_0 = {
			ja = 5.666,
			ko = 6.2,
			zh = 5.566,
			en = 6.9
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
				arg_32_0:Play109011009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = 0

			if var_35_0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_0 + arg_35_0 then
				arg_32_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1204cva")
			end

			local var_35_1 = 0
			local var_35_2 = 0.725

			if var_35_1 < arg_32_1.time_ and arg_32_1.time_ <= var_35_1 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				local var_35_3 = arg_32_1:FormatText(StoryNameCfg[6].name)

				arg_32_1.leftNameTxt_.text = var_35_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_4 = arg_32_1:GetWordFromCfg(109011008)
				local var_35_5 = arg_32_1:FormatText(var_35_4.content)

				arg_32_1.text_.text = var_35_5

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_6 = 29
				local var_35_7 = utf8.len(var_35_5)
				local var_35_8 = var_35_6 <= 0 and var_35_2 or var_35_2 * (var_35_7 / var_35_6)

				if var_35_8 > 0 and var_35_2 < var_35_8 then
					arg_32_1.talkMaxDuration = var_35_8

					if var_35_8 + var_35_1 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_8 + var_35_1
					end
				end

				arg_32_1.text_.text = var_35_5
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109011", "109011008", "story_v_out_109011.awb") ~= 0 then
					local var_35_9 = manager.audio:GetVoiceLength("story_v_out_109011", "109011008", "story_v_out_109011.awb") / 1000

					if var_35_9 + var_35_1 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_9 + var_35_1
					end

					if var_35_4.prefab_name ~= "" and arg_32_1.actors_[var_35_4.prefab_name] ~= nil then
						local var_35_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_4.prefab_name].transform, "story_v_out_109011", "109011008", "story_v_out_109011.awb")

						arg_32_1:RecordAudio("109011008", var_35_10)
						arg_32_1:RecordAudio("109011008", var_35_10)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_109011", "109011008", "story_v_out_109011.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_109011", "109011008", "story_v_out_109011.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_11 = math.max(var_35_2, arg_32_1.talkMaxDuration)

			if var_35_1 <= arg_32_1.time_ and arg_32_1.time_ < var_35_1 + var_35_11 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_1) / var_35_11

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_1 + var_35_11 and arg_32_1.time_ < var_35_1 + var_35_11 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play109011009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 109011009
		arg_36_1.duration_ = 6.67

		local var_36_0 = {
			ja = 6.533,
			ko = 4.566,
			zh = 4.466,
			en = 6.666
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
				arg_36_0:Play109011010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = arg_36_1.actors_["1084ui_story"].transform
			local var_39_1 = 0

			if var_39_1 < arg_36_1.time_ and arg_36_1.time_ <= var_39_1 + arg_39_0 then
				arg_36_1.var_.moveOldPos1084ui_story = var_39_0.localPosition
			end

			local var_39_2 = 0.001

			if var_39_1 <= arg_36_1.time_ and arg_36_1.time_ < var_39_1 + var_39_2 then
				local var_39_3 = (arg_36_1.time_ - var_39_1) / var_39_2
				local var_39_4 = Vector3.New(0, 100, 0)

				var_39_0.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos1084ui_story, var_39_4, var_39_3)

				local var_39_5 = manager.ui.mainCamera.transform.position - var_39_0.position

				var_39_0.forward = Vector3.New(var_39_5.x, var_39_5.y, var_39_5.z)

				local var_39_6 = var_39_0.localEulerAngles

				var_39_6.z = 0
				var_39_6.x = 0
				var_39_0.localEulerAngles = var_39_6
			end

			if arg_36_1.time_ >= var_39_1 + var_39_2 and arg_36_1.time_ < var_39_1 + var_39_2 + arg_39_0 then
				var_39_0.localPosition = Vector3.New(0, 100, 0)

				local var_39_7 = manager.ui.mainCamera.transform.position - var_39_0.position

				var_39_0.forward = Vector3.New(var_39_7.x, var_39_7.y, var_39_7.z)

				local var_39_8 = var_39_0.localEulerAngles

				var_39_8.z = 0
				var_39_8.x = 0
				var_39_0.localEulerAngles = var_39_8
			end

			local var_39_9 = "1099ui_story"

			if arg_36_1.actors_[var_39_9] == nil then
				local var_39_10 = Asset.Load("Char/" .. "1099ui_story")

				if not isNil(var_39_10) then
					local var_39_11 = Object.Instantiate(Asset.Load("Char/" .. "1099ui_story"), arg_36_1.stage_.transform)

					var_39_11.name = var_39_9
					var_39_11.transform.localPosition = Vector3.New(0, 100, 0)
					arg_36_1.actors_[var_39_9] = var_39_11

					local var_39_12 = var_39_11:GetComponentInChildren(typeof(CharacterEffect))

					var_39_12.enabled = true

					local var_39_13 = GameObjectTools.GetOrAddComponent(var_39_11, typeof(DynamicBoneHelper))

					if var_39_13 then
						var_39_13:EnableDynamicBone(false)
					end

					arg_36_1:ShowWeapon(var_39_12.transform, false)

					arg_36_1.var_[var_39_9 .. "Animator"] = var_39_12.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_36_1.var_[var_39_9 .. "Animator"].applyRootMotion = true
					arg_36_1.var_[var_39_9 .. "LipSync"] = var_39_12.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_39_14 = arg_36_1.actors_["1099ui_story"].transform
			local var_39_15 = 0

			if var_39_15 < arg_36_1.time_ and arg_36_1.time_ <= var_39_15 + arg_39_0 then
				arg_36_1.var_.moveOldPos1099ui_story = var_39_14.localPosition
			end

			local var_39_16 = 0.001

			if var_39_15 <= arg_36_1.time_ and arg_36_1.time_ < var_39_15 + var_39_16 then
				local var_39_17 = (arg_36_1.time_ - var_39_15) / var_39_16
				local var_39_18 = Vector3.New(-0.7, -1.08, -5.9)

				var_39_14.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos1099ui_story, var_39_18, var_39_17)

				local var_39_19 = manager.ui.mainCamera.transform.position - var_39_14.position

				var_39_14.forward = Vector3.New(var_39_19.x, var_39_19.y, var_39_19.z)

				local var_39_20 = var_39_14.localEulerAngles

				var_39_20.z = 0
				var_39_20.x = 0
				var_39_14.localEulerAngles = var_39_20
			end

			if arg_36_1.time_ >= var_39_15 + var_39_16 and arg_36_1.time_ < var_39_15 + var_39_16 + arg_39_0 then
				var_39_14.localPosition = Vector3.New(-0.7, -1.08, -5.9)

				local var_39_21 = manager.ui.mainCamera.transform.position - var_39_14.position

				var_39_14.forward = Vector3.New(var_39_21.x, var_39_21.y, var_39_21.z)

				local var_39_22 = var_39_14.localEulerAngles

				var_39_22.z = 0
				var_39_22.x = 0
				var_39_14.localEulerAngles = var_39_22
			end

			local var_39_23 = arg_36_1.actors_["1099ui_story"]
			local var_39_24 = 0

			if var_39_24 < arg_36_1.time_ and arg_36_1.time_ <= var_39_24 + arg_39_0 and not isNil(var_39_23) and arg_36_1.var_.characterEffect1099ui_story == nil then
				arg_36_1.var_.characterEffect1099ui_story = var_39_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_25 = 0.2

			if var_39_24 <= arg_36_1.time_ and arg_36_1.time_ < var_39_24 + var_39_25 and not isNil(var_39_23) then
				local var_39_26 = (arg_36_1.time_ - var_39_24) / var_39_25

				if arg_36_1.var_.characterEffect1099ui_story and not isNil(var_39_23) then
					arg_36_1.var_.characterEffect1099ui_story.fillFlat = false
				end
			end

			if arg_36_1.time_ >= var_39_24 + var_39_25 and arg_36_1.time_ < var_39_24 + var_39_25 + arg_39_0 and not isNil(var_39_23) and arg_36_1.var_.characterEffect1099ui_story then
				arg_36_1.var_.characterEffect1099ui_story.fillFlat = false
			end

			local var_39_27 = 0

			if var_39_27 < arg_36_1.time_ and arg_36_1.time_ <= var_39_27 + arg_39_0 then
				arg_36_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/story1099/story1099action/1099action5_1")
			end

			local var_39_28 = 0

			if var_39_28 < arg_36_1.time_ and arg_36_1.time_ <= var_39_28 + arg_39_0 then
				arg_36_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_39_29 = 0
			local var_39_30 = 0.575

			if var_39_29 < arg_36_1.time_ and arg_36_1.time_ <= var_39_29 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				local var_39_31 = arg_36_1:FormatText(StoryNameCfg[84].name)

				arg_36_1.leftNameTxt_.text = var_39_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_32 = arg_36_1:GetWordFromCfg(109011009)
				local var_39_33 = arg_36_1:FormatText(var_39_32.content)

				arg_36_1.text_.text = var_39_33

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_34 = 22
				local var_39_35 = utf8.len(var_39_33)
				local var_39_36 = var_39_34 <= 0 and var_39_30 or var_39_30 * (var_39_35 / var_39_34)

				if var_39_36 > 0 and var_39_30 < var_39_36 then
					arg_36_1.talkMaxDuration = var_39_36

					if var_39_36 + var_39_29 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_36 + var_39_29
					end
				end

				arg_36_1.text_.text = var_39_33
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109011", "109011009", "story_v_out_109011.awb") ~= 0 then
					local var_39_37 = manager.audio:GetVoiceLength("story_v_out_109011", "109011009", "story_v_out_109011.awb") / 1000

					if var_39_37 + var_39_29 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_37 + var_39_29
					end

					if var_39_32.prefab_name ~= "" and arg_36_1.actors_[var_39_32.prefab_name] ~= nil then
						local var_39_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_32.prefab_name].transform, "story_v_out_109011", "109011009", "story_v_out_109011.awb")

						arg_36_1:RecordAudio("109011009", var_39_38)
						arg_36_1:RecordAudio("109011009", var_39_38)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_109011", "109011009", "story_v_out_109011.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_109011", "109011009", "story_v_out_109011.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_39 = math.max(var_39_30, arg_36_1.talkMaxDuration)

			if var_39_29 <= arg_36_1.time_ and arg_36_1.time_ < var_39_29 + var_39_39 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_29) / var_39_39

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_29 + var_39_39 and arg_36_1.time_ < var_39_29 + var_39_39 + arg_39_0 then
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

		arg_36_1:InitPlayNodeList()
	end,
	Play109011010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 109011010
		arg_40_1.duration_ = 2

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play109011011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = arg_40_1.actors_["1038ui_story"]
			local var_43_1 = 0

			if var_43_1 < arg_40_1.time_ and arg_40_1.time_ <= var_43_1 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.characterEffect1038ui_story == nil then
				arg_40_1.var_.characterEffect1038ui_story = var_43_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_2 = 0.2

			if var_43_1 <= arg_40_1.time_ and arg_40_1.time_ < var_43_1 + var_43_2 and not isNil(var_43_0) then
				local var_43_3 = (arg_40_1.time_ - var_43_1) / var_43_2

				if arg_40_1.var_.characterEffect1038ui_story and not isNil(var_43_0) then
					arg_40_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_40_1.time_ >= var_43_1 + var_43_2 and arg_40_1.time_ < var_43_1 + var_43_2 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.characterEffect1038ui_story then
				arg_40_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_43_4 = arg_40_1.actors_["1099ui_story"]
			local var_43_5 = 0

			if var_43_5 < arg_40_1.time_ and arg_40_1.time_ <= var_43_5 + arg_43_0 and not isNil(var_43_4) and arg_40_1.var_.characterEffect1099ui_story == nil then
				arg_40_1.var_.characterEffect1099ui_story = var_43_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_6 = 0.2

			if var_43_5 <= arg_40_1.time_ and arg_40_1.time_ < var_43_5 + var_43_6 and not isNil(var_43_4) then
				local var_43_7 = (arg_40_1.time_ - var_43_5) / var_43_6

				if arg_40_1.var_.characterEffect1099ui_story and not isNil(var_43_4) then
					local var_43_8 = Mathf.Lerp(0, 0.5, var_43_7)

					arg_40_1.var_.characterEffect1099ui_story.fillFlat = true
					arg_40_1.var_.characterEffect1099ui_story.fillRatio = var_43_8
				end
			end

			if arg_40_1.time_ >= var_43_5 + var_43_6 and arg_40_1.time_ < var_43_5 + var_43_6 + arg_43_0 and not isNil(var_43_4) and arg_40_1.var_.characterEffect1099ui_story then
				local var_43_9 = 0.5

				arg_40_1.var_.characterEffect1099ui_story.fillFlat = true
				arg_40_1.var_.characterEffect1099ui_story.fillRatio = var_43_9
			end

			local var_43_10 = 0

			if var_43_10 < arg_40_1.time_ and arg_40_1.time_ <= var_43_10 + arg_43_0 then
				arg_40_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_43_11 = 0
			local var_43_12 = 0.2

			if var_43_11 < arg_40_1.time_ and arg_40_1.time_ <= var_43_11 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				local var_43_13 = arg_40_1:FormatText(StoryNameCfg[94].name)

				arg_40_1.leftNameTxt_.text = var_43_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_14 = arg_40_1:GetWordFromCfg(109011010)
				local var_43_15 = arg_40_1:FormatText(var_43_14.content)

				arg_40_1.text_.text = var_43_15

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_16 = 8
				local var_43_17 = utf8.len(var_43_15)
				local var_43_18 = var_43_16 <= 0 and var_43_12 or var_43_12 * (var_43_17 / var_43_16)

				if var_43_18 > 0 and var_43_12 < var_43_18 then
					arg_40_1.talkMaxDuration = var_43_18

					if var_43_18 + var_43_11 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_18 + var_43_11
					end
				end

				arg_40_1.text_.text = var_43_15
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109011", "109011010", "story_v_out_109011.awb") ~= 0 then
					local var_43_19 = manager.audio:GetVoiceLength("story_v_out_109011", "109011010", "story_v_out_109011.awb") / 1000

					if var_43_19 + var_43_11 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_19 + var_43_11
					end

					if var_43_14.prefab_name ~= "" and arg_40_1.actors_[var_43_14.prefab_name] ~= nil then
						local var_43_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_14.prefab_name].transform, "story_v_out_109011", "109011010", "story_v_out_109011.awb")

						arg_40_1:RecordAudio("109011010", var_43_20)
						arg_40_1:RecordAudio("109011010", var_43_20)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_109011", "109011010", "story_v_out_109011.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_109011", "109011010", "story_v_out_109011.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_21 = math.max(var_43_12, arg_40_1.talkMaxDuration)

			if var_43_11 <= arg_40_1.time_ and arg_40_1.time_ < var_43_11 + var_43_21 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_11) / var_43_21

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_11 + var_43_21 and arg_40_1.time_ < var_43_11 + var_43_21 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play109011011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 109011011
		arg_44_1.duration_ = 16.07

		local var_44_0 = {
			ja = 7.966,
			ko = 16.066,
			zh = 12.166,
			en = 12.433
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
				arg_44_0:Play109011012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = arg_44_1.actors_["1038ui_story"]
			local var_47_1 = 0

			if var_47_1 < arg_44_1.time_ and arg_44_1.time_ <= var_47_1 + arg_47_0 and not isNil(var_47_0) and arg_44_1.var_.characterEffect1038ui_story == nil then
				arg_44_1.var_.characterEffect1038ui_story = var_47_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_2 = 0.2

			if var_47_1 <= arg_44_1.time_ and arg_44_1.time_ < var_47_1 + var_47_2 and not isNil(var_47_0) then
				local var_47_3 = (arg_44_1.time_ - var_47_1) / var_47_2

				if arg_44_1.var_.characterEffect1038ui_story and not isNil(var_47_0) then
					local var_47_4 = Mathf.Lerp(0, 0.5, var_47_3)

					arg_44_1.var_.characterEffect1038ui_story.fillFlat = true
					arg_44_1.var_.characterEffect1038ui_story.fillRatio = var_47_4
				end
			end

			if arg_44_1.time_ >= var_47_1 + var_47_2 and arg_44_1.time_ < var_47_1 + var_47_2 + arg_47_0 and not isNil(var_47_0) and arg_44_1.var_.characterEffect1038ui_story then
				local var_47_5 = 0.5

				arg_44_1.var_.characterEffect1038ui_story.fillFlat = true
				arg_44_1.var_.characterEffect1038ui_story.fillRatio = var_47_5
			end

			local var_47_6 = arg_44_1.actors_["1099ui_story"]
			local var_47_7 = 0

			if var_47_7 < arg_44_1.time_ and arg_44_1.time_ <= var_47_7 + arg_47_0 and not isNil(var_47_6) and arg_44_1.var_.characterEffect1099ui_story == nil then
				arg_44_1.var_.characterEffect1099ui_story = var_47_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_8 = 0.2

			if var_47_7 <= arg_44_1.time_ and arg_44_1.time_ < var_47_7 + var_47_8 and not isNil(var_47_6) then
				local var_47_9 = (arg_44_1.time_ - var_47_7) / var_47_8

				if arg_44_1.var_.characterEffect1099ui_story and not isNil(var_47_6) then
					arg_44_1.var_.characterEffect1099ui_story.fillFlat = false
				end
			end

			if arg_44_1.time_ >= var_47_7 + var_47_8 and arg_44_1.time_ < var_47_7 + var_47_8 + arg_47_0 and not isNil(var_47_6) and arg_44_1.var_.characterEffect1099ui_story then
				arg_44_1.var_.characterEffect1099ui_story.fillFlat = false
			end

			local var_47_10 = 0

			if var_47_10 < arg_44_1.time_ and arg_44_1.time_ <= var_47_10 + arg_47_0 then
				arg_44_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/story1099/story1099action/1099action5_2")
			end

			local var_47_11 = 0

			if var_47_11 < arg_44_1.time_ and arg_44_1.time_ <= var_47_11 + arg_47_0 then
				arg_44_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_47_12 = 0
			local var_47_13 = 1.675

			if var_47_12 < arg_44_1.time_ and arg_44_1.time_ <= var_47_12 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				local var_47_14 = arg_44_1:FormatText(StoryNameCfg[84].name)

				arg_44_1.leftNameTxt_.text = var_47_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_15 = arg_44_1:GetWordFromCfg(109011011)
				local var_47_16 = arg_44_1:FormatText(var_47_15.content)

				arg_44_1.text_.text = var_47_16

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_17 = 67
				local var_47_18 = utf8.len(var_47_16)
				local var_47_19 = var_47_17 <= 0 and var_47_13 or var_47_13 * (var_47_18 / var_47_17)

				if var_47_19 > 0 and var_47_13 < var_47_19 then
					arg_44_1.talkMaxDuration = var_47_19

					if var_47_19 + var_47_12 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_19 + var_47_12
					end
				end

				arg_44_1.text_.text = var_47_16
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109011", "109011011", "story_v_out_109011.awb") ~= 0 then
					local var_47_20 = manager.audio:GetVoiceLength("story_v_out_109011", "109011011", "story_v_out_109011.awb") / 1000

					if var_47_20 + var_47_12 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_20 + var_47_12
					end

					if var_47_15.prefab_name ~= "" and arg_44_1.actors_[var_47_15.prefab_name] ~= nil then
						local var_47_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_15.prefab_name].transform, "story_v_out_109011", "109011011", "story_v_out_109011.awb")

						arg_44_1:RecordAudio("109011011", var_47_21)
						arg_44_1:RecordAudio("109011011", var_47_21)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_109011", "109011011", "story_v_out_109011.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_109011", "109011011", "story_v_out_109011.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_22 = math.max(var_47_13, arg_44_1.talkMaxDuration)

			if var_47_12 <= arg_44_1.time_ and arg_44_1.time_ < var_47_12 + var_47_22 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_12) / var_47_22

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_12 + var_47_22 and arg_44_1.time_ < var_47_12 + var_47_22 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play109011012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 109011012
		arg_48_1.duration_ = 6.17

		local var_48_0 = {
			ja = 6.166,
			ko = 4.233,
			zh = 4.166,
			en = 5.066
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
			arg_48_1.auto_ = false
		end

		function arg_48_1.playNext_(arg_50_0)
			arg_48_1.onStoryFinished_()
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = 0

			if var_51_0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_0 + arg_51_0 then
				arg_48_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_51_1 = 0
			local var_51_2 = 0.65

			if var_51_1 < arg_48_1.time_ and arg_48_1.time_ <= var_51_1 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				local var_51_3 = arg_48_1:FormatText(StoryNameCfg[84].name)

				arg_48_1.leftNameTxt_.text = var_51_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_4 = arg_48_1:GetWordFromCfg(109011012)
				local var_51_5 = arg_48_1:FormatText(var_51_4.content)

				arg_48_1.text_.text = var_51_5

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_6 = 26
				local var_51_7 = utf8.len(var_51_5)
				local var_51_8 = var_51_6 <= 0 and var_51_2 or var_51_2 * (var_51_7 / var_51_6)

				if var_51_8 > 0 and var_51_2 < var_51_8 then
					arg_48_1.talkMaxDuration = var_51_8

					if var_51_8 + var_51_1 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_8 + var_51_1
					end
				end

				arg_48_1.text_.text = var_51_5
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109011", "109011012", "story_v_out_109011.awb") ~= 0 then
					local var_51_9 = manager.audio:GetVoiceLength("story_v_out_109011", "109011012", "story_v_out_109011.awb") / 1000

					if var_51_9 + var_51_1 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_9 + var_51_1
					end

					if var_51_4.prefab_name ~= "" and arg_48_1.actors_[var_51_4.prefab_name] ~= nil then
						local var_51_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_4.prefab_name].transform, "story_v_out_109011", "109011012", "story_v_out_109011.awb")

						arg_48_1:RecordAudio("109011012", var_51_10)
						arg_48_1:RecordAudio("109011012", var_51_10)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_109011", "109011012", "story_v_out_109011.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_109011", "109011012", "story_v_out_109011.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_11 = math.max(var_51_2, arg_48_1.talkMaxDuration)

			if var_51_1 <= arg_48_1.time_ and arg_48_1.time_ < var_51_1 + var_51_11 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_1) / var_51_11

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_1 + var_51_11 and arg_48_1.time_ < var_51_1 + var_51_11 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/C05b"
	},
	voices = {
		"story_v_out_109011.awb"
	}
}
