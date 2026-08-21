return {
	Play1109701001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 1109701001
		arg_1_1.duration_ = 9.37

		local var_1_0 = {
			zh = 7.40000000298023,
			ja = 9.36600000298023
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
				arg_1_0:Play1109701002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "ST12"

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
				local var_4_5 = arg_1_1.bgs_.ST12

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
					if iter_4_0 ~= "ST12" then
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

			local var_4_22 = "1019ui_story"

			if arg_1_1.actors_[var_4_22] == nil then
				local var_4_23 = Asset.Load("Char/" .. "1019ui_story")

				if not isNil(var_4_23) then
					local var_4_24 = Object.Instantiate(Asset.Load("Char/" .. "1019ui_story"), arg_1_1.stage_.transform)

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

			local var_4_27 = arg_1_1.actors_["1019ui_story"].transform
			local var_4_28 = 1.8

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				arg_1_1.var_.moveOldPos1019ui_story = var_4_27.localPosition
			end

			local var_4_29 = 0.001

			if var_4_28 <= arg_1_1.time_ and arg_1_1.time_ < var_4_28 + var_4_29 then
				local var_4_30 = (arg_1_1.time_ - var_4_28) / var_4_29
				local var_4_31 = Vector3.New(-0.2, -1.08, -5.9)

				var_4_27.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1019ui_story, var_4_31, var_4_30)

				local var_4_32 = manager.ui.mainCamera.transform.position - var_4_27.position

				var_4_27.forward = Vector3.New(var_4_32.x, var_4_32.y, var_4_32.z)

				local var_4_33 = var_4_27.localEulerAngles

				var_4_33.z = 0
				var_4_33.x = 0
				var_4_27.localEulerAngles = var_4_33
			end

			if arg_1_1.time_ >= var_4_28 + var_4_29 and arg_1_1.time_ < var_4_28 + var_4_29 + arg_4_0 then
				var_4_27.localPosition = Vector3.New(-0.2, -1.08, -5.9)

				local var_4_34 = manager.ui.mainCamera.transform.position - var_4_27.position

				var_4_27.forward = Vector3.New(var_4_34.x, var_4_34.y, var_4_34.z)

				local var_4_35 = var_4_27.localEulerAngles

				var_4_35.z = 0
				var_4_35.x = 0
				var_4_27.localEulerAngles = var_4_35
			end

			local var_4_36 = arg_1_1.actors_["1019ui_story"]
			local var_4_37 = 1.8

			if var_4_37 < arg_1_1.time_ and arg_1_1.time_ <= var_4_37 + arg_4_0 and not isNil(var_4_36) and arg_1_1.var_.characterEffect1019ui_story == nil then
				arg_1_1.var_.characterEffect1019ui_story = var_4_36:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_38 = 0.200000002980232

			if var_4_37 <= arg_1_1.time_ and arg_1_1.time_ < var_4_37 + var_4_38 and not isNil(var_4_36) then
				local var_4_39 = (arg_1_1.time_ - var_4_37) / var_4_38

				if arg_1_1.var_.characterEffect1019ui_story and not isNil(var_4_36) then
					arg_1_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= var_4_37 + var_4_38 and arg_1_1.time_ < var_4_37 + var_4_38 + arg_4_0 and not isNil(var_4_36) and arg_1_1.var_.characterEffect1019ui_story then
				arg_1_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_4_40 = 1.8

			if var_4_40 < arg_1_1.time_ and arg_1_1.time_ <= var_4_40 + arg_4_0 then
				arg_1_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action2_1")
			end

			local var_4_41 = 1.8

			if var_4_41 < arg_1_1.time_ and arg_1_1.time_ <= var_4_41 + arg_4_0 then
				arg_1_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_4_42 = 0
			local var_4_43 = 0.2

			if var_4_42 < arg_1_1.time_ and arg_1_1.time_ <= var_4_42 + arg_4_0 then
				local var_4_44 = "play"
				local var_4_45 = "music"

				arg_1_1:AudioAction(var_4_44, var_4_45, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_46 = ""
				local var_4_47 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_47 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_47 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_47

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_47
						arg_1_1.bgmTxt2_.text = var_4_47
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

			local var_4_48 = "ST12_blur"

			if arg_1_1.bgs_[var_4_48] == nil then
				local var_4_49 = Object.Instantiate(arg_1_1.blurPaintGo_)
				local var_4_50 = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_48)

				var_4_49:GetComponent("SpriteRenderer").sprite = var_4_50
				var_4_49.name = var_4_48
				var_4_49.transform.parent = arg_1_1.stage_.transform
				var_4_49.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_48] = var_4_49
			end

			local var_4_51 = 0
			local var_4_52 = arg_1_1.bgs_[var_4_48]

			if var_4_51 < arg_1_1.time_ and arg_1_1.time_ <= var_4_51 + arg_4_0 then
				local var_4_53 = manager.ui.mainCamera.transform.localPosition
				local var_4_54 = Vector3.New(0, 0, 10) + Vector3.New(var_4_53.x, var_4_53.y, 0)

				var_4_52.transform.localPosition = var_4_54
				var_4_52.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_55 = var_4_52:GetComponent("SpriteRenderer")

				if var_4_55 and var_4_55.sprite then
					local var_4_56 = (var_4_52.transform.localPosition - var_4_53).z
					local var_4_57 = manager.ui.mainCameraCom_
					local var_4_58 = 2 * var_4_56 * Mathf.Tan(var_4_57.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_4_59 = var_4_58 * var_4_57.aspect
					local var_4_60 = var_4_55.sprite.bounds.size.x
					local var_4_61 = var_4_55.sprite.bounds.size.y
					local var_4_62 = var_4_59 / var_4_60
					local var_4_63 = var_4_58 / var_4_61
					local var_4_64 = var_4_63 < var_4_62 and var_4_62 or var_4_63

					var_4_52.transform.localScale = Vector3.New(var_4_64, var_4_64, 0)
				end
			end

			local var_4_65 = 2.00000000298023

			if var_4_51 <= arg_1_1.time_ and arg_1_1.time_ < var_4_51 + var_4_65 then
				local var_4_66 = (arg_1_1.time_ - var_4_51) / var_4_65
				local var_4_67 = Color.New(1, 1, 1)

				var_4_67.a = Mathf.Lerp(0, 1, var_4_66)

				var_4_52:GetComponent("SpriteRenderer").material:SetColor("_Color", var_4_67)
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_68 = 2.00000000298023
			local var_4_69 = 0.625

			if var_4_68 < arg_1_1.time_ and arg_1_1.time_ <= var_4_68 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_70 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_70:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_70:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_70:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_71 = arg_1_1:FormatText(StoryNameCfg[949].name)

				arg_1_1.leftNameTxt_.text = var_4_71

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_72 = arg_1_1:GetWordFromCfg(1109701001)
				local var_4_73 = arg_1_1:FormatText(var_4_72.content)

				arg_1_1.text_.text = var_4_73

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_74 = 25
				local var_4_75 = utf8.len(var_4_73)
				local var_4_76 = var_4_74 <= 0 and var_4_69 or var_4_69 * (var_4_75 / var_4_74)

				if var_4_76 > 0 and var_4_69 < var_4_76 then
					arg_1_1.talkMaxDuration = var_4_76
					var_4_68 = var_4_68 + 0.3

					if var_4_76 + var_4_68 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_76 + var_4_68
					end
				end

				arg_1_1.text_.text = var_4_73
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701001", "story_v_side_new_1109701.awb") ~= 0 then
					local var_4_77 = manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701001", "story_v_side_new_1109701.awb") / 1000

					if var_4_77 + var_4_68 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_77 + var_4_68
					end

					if var_4_72.prefab_name ~= "" and arg_1_1.actors_[var_4_72.prefab_name] ~= nil then
						local var_4_78 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_72.prefab_name].transform, "story_v_side_new_1109701", "1109701001", "story_v_side_new_1109701.awb")

						arg_1_1:RecordAudio("1109701001", var_4_78)
						arg_1_1:RecordAudio("1109701001", var_4_78)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_side_new_1109701", "1109701001", "story_v_side_new_1109701.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_side_new_1109701", "1109701001", "story_v_side_new_1109701.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_79 = var_4_68 + 0.3
			local var_4_80 = math.max(var_4_69, arg_1_1.talkMaxDuration)

			if var_4_79 <= arg_1_1.time_ and arg_1_1.time_ < var_4_79 + var_4_80 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_79) / var_4_80

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_79 + var_4_80 and arg_1_1.time_ < var_4_79 + var_4_80 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play1109701002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 1109701002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play1109701003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = arg_8_1.actors_["1019ui_story"]
			local var_11_1 = 0

			if var_11_1 < arg_8_1.time_ and arg_8_1.time_ <= var_11_1 + arg_11_0 and not isNil(var_11_0) and arg_8_1.var_.characterEffect1019ui_story == nil then
				arg_8_1.var_.characterEffect1019ui_story = var_11_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_2 = 0.200000002980232

			if var_11_1 <= arg_8_1.time_ and arg_8_1.time_ < var_11_1 + var_11_2 and not isNil(var_11_0) then
				local var_11_3 = (arg_8_1.time_ - var_11_1) / var_11_2

				if arg_8_1.var_.characterEffect1019ui_story and not isNil(var_11_0) then
					local var_11_4 = Mathf.Lerp(0, 0.5, var_11_3)

					arg_8_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_8_1.var_.characterEffect1019ui_story.fillRatio = var_11_4
				end
			end

			if arg_8_1.time_ >= var_11_1 + var_11_2 and arg_8_1.time_ < var_11_1 + var_11_2 + arg_11_0 and not isNil(var_11_0) and arg_8_1.var_.characterEffect1019ui_story then
				local var_11_5 = 0.5

				arg_8_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_8_1.var_.characterEffect1019ui_story.fillRatio = var_11_5
			end

			local var_11_6 = 0
			local var_11_7 = 0.325

			if var_11_6 < arg_8_1.time_ and arg_8_1.time_ <= var_11_6 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				local var_11_8 = arg_8_1:FormatText(StoryNameCfg[950].name)

				arg_8_1.leftNameTxt_.text = var_11_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_9 = arg_8_1:GetWordFromCfg(1109701002)
				local var_11_10 = arg_8_1:FormatText(var_11_9.content)

				arg_8_1.text_.text = var_11_10

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_11 = 13
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
				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_14 = math.max(var_11_7, arg_8_1.talkMaxDuration)

			if var_11_6 <= arg_8_1.time_ and arg_8_1.time_ < var_11_6 + var_11_14 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_6) / var_11_14

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_6 + var_11_14 and arg_8_1.time_ < var_11_6 + var_11_14 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play1109701003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 1109701003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play1109701004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 0
			local var_15_1 = 0.925

			if var_15_0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_0 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, false)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_2 = arg_12_1:GetWordFromCfg(1109701003)
				local var_15_3 = arg_12_1:FormatText(var_15_2.content)

				arg_12_1.text_.text = var_15_3

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_4 = 37
				local var_15_5 = utf8.len(var_15_3)
				local var_15_6 = var_15_4 <= 0 and var_15_1 or var_15_1 * (var_15_5 / var_15_4)

				if var_15_6 > 0 and var_15_1 < var_15_6 then
					arg_12_1.talkMaxDuration = var_15_6

					if var_15_6 + var_15_0 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_6 + var_15_0
					end
				end

				arg_12_1.text_.text = var_15_3
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)
				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_7 = math.max(var_15_1, arg_12_1.talkMaxDuration)

			if var_15_0 <= arg_12_1.time_ and arg_12_1.time_ < var_15_0 + var_15_7 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_0) / var_15_7

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_0 + var_15_7 and arg_12_1.time_ < var_15_0 + var_15_7 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play1109701004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 1109701004
		arg_16_1.duration_ = 10.43

		local var_16_0 = {
			zh = 8.1,
			ja = 10.433
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
				arg_16_0:Play1109701005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = arg_16_1.actors_["1019ui_story"].transform
			local var_19_1 = 0

			if var_19_1 < arg_16_1.time_ and arg_16_1.time_ <= var_19_1 + arg_19_0 then
				arg_16_1.var_.moveOldPos1019ui_story = var_19_0.localPosition
			end

			local var_19_2 = 0.001

			if var_19_1 <= arg_16_1.time_ and arg_16_1.time_ < var_19_1 + var_19_2 then
				local var_19_3 = (arg_16_1.time_ - var_19_1) / var_19_2
				local var_19_4 = Vector3.New(-0.2, -1.08, -5.9)

				var_19_0.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos1019ui_story, var_19_4, var_19_3)

				local var_19_5 = manager.ui.mainCamera.transform.position - var_19_0.position

				var_19_0.forward = Vector3.New(var_19_5.x, var_19_5.y, var_19_5.z)

				local var_19_6 = var_19_0.localEulerAngles

				var_19_6.z = 0
				var_19_6.x = 0
				var_19_0.localEulerAngles = var_19_6
			end

			if arg_16_1.time_ >= var_19_1 + var_19_2 and arg_16_1.time_ < var_19_1 + var_19_2 + arg_19_0 then
				var_19_0.localPosition = Vector3.New(-0.2, -1.08, -5.9)

				local var_19_7 = manager.ui.mainCamera.transform.position - var_19_0.position

				var_19_0.forward = Vector3.New(var_19_7.x, var_19_7.y, var_19_7.z)

				local var_19_8 = var_19_0.localEulerAngles

				var_19_8.z = 0
				var_19_8.x = 0
				var_19_0.localEulerAngles = var_19_8
			end

			local var_19_9 = arg_16_1.actors_["1019ui_story"]
			local var_19_10 = 0

			if var_19_10 < arg_16_1.time_ and arg_16_1.time_ <= var_19_10 + arg_19_0 and not isNil(var_19_9) and arg_16_1.var_.characterEffect1019ui_story == nil then
				arg_16_1.var_.characterEffect1019ui_story = var_19_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_11 = 0.200000002980232

			if var_19_10 <= arg_16_1.time_ and arg_16_1.time_ < var_19_10 + var_19_11 and not isNil(var_19_9) then
				local var_19_12 = (arg_16_1.time_ - var_19_10) / var_19_11

				if arg_16_1.var_.characterEffect1019ui_story and not isNil(var_19_9) then
					arg_16_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_16_1.time_ >= var_19_10 + var_19_11 and arg_16_1.time_ < var_19_10 + var_19_11 + arg_19_0 and not isNil(var_19_9) and arg_16_1.var_.characterEffect1019ui_story then
				arg_16_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_19_13 = 0

			if var_19_13 < arg_16_1.time_ and arg_16_1.time_ <= var_19_13 + arg_19_0 then
				arg_16_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action2_2")
			end

			local var_19_14 = 0

			if var_19_14 < arg_16_1.time_ and arg_16_1.time_ <= var_19_14 + arg_19_0 then
				arg_16_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_19_15 = 0
			local var_19_16 = 0.725

			if var_19_15 < arg_16_1.time_ and arg_16_1.time_ <= var_19_15 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				local var_19_17 = arg_16_1:FormatText(StoryNameCfg[949].name)

				arg_16_1.leftNameTxt_.text = var_19_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_18 = arg_16_1:GetWordFromCfg(1109701004)
				local var_19_19 = arg_16_1:FormatText(var_19_18.content)

				arg_16_1.text_.text = var_19_19

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_20 = 29
				local var_19_21 = utf8.len(var_19_19)
				local var_19_22 = var_19_20 <= 0 and var_19_16 or var_19_16 * (var_19_21 / var_19_20)

				if var_19_22 > 0 and var_19_16 < var_19_22 then
					arg_16_1.talkMaxDuration = var_19_22

					if var_19_22 + var_19_15 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_22 + var_19_15
					end
				end

				arg_16_1.text_.text = var_19_19
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701004", "story_v_side_new_1109701.awb") ~= 0 then
					local var_19_23 = manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701004", "story_v_side_new_1109701.awb") / 1000

					if var_19_23 + var_19_15 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_23 + var_19_15
					end

					if var_19_18.prefab_name ~= "" and arg_16_1.actors_[var_19_18.prefab_name] ~= nil then
						local var_19_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_18.prefab_name].transform, "story_v_side_new_1109701", "1109701004", "story_v_side_new_1109701.awb")

						arg_16_1:RecordAudio("1109701004", var_19_24)
						arg_16_1:RecordAudio("1109701004", var_19_24)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_side_new_1109701", "1109701004", "story_v_side_new_1109701.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_side_new_1109701", "1109701004", "story_v_side_new_1109701.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_25 = math.max(var_19_16, arg_16_1.talkMaxDuration)

			if var_19_15 <= arg_16_1.time_ and arg_16_1.time_ < var_19_15 + var_19_25 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_15) / var_19_25

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_15 + var_19_25 and arg_16_1.time_ < var_19_15 + var_19_25 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_16_1:InitPlayNodeList()
	end,
	Play1109701005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 1109701005
		arg_20_1.duration_ = 10.3

		local var_20_0 = {
			zh = 6.9,
			ja = 10.3
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
				arg_20_0:Play1109701006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = 0

			if var_23_0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_0 + arg_23_0 then
				arg_20_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_23_1 = 0
			local var_23_2 = 0.75

			if var_23_1 < arg_20_1.time_ and arg_20_1.time_ <= var_23_1 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				local var_23_3 = arg_20_1:FormatText(StoryNameCfg[949].name)

				arg_20_1.leftNameTxt_.text = var_23_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_4 = arg_20_1:GetWordFromCfg(1109701005)
				local var_23_5 = arg_20_1:FormatText(var_23_4.content)

				arg_20_1.text_.text = var_23_5

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_6 = 30
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

				if manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701005", "story_v_side_new_1109701.awb") ~= 0 then
					local var_23_9 = manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701005", "story_v_side_new_1109701.awb") / 1000

					if var_23_9 + var_23_1 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_9 + var_23_1
					end

					if var_23_4.prefab_name ~= "" and arg_20_1.actors_[var_23_4.prefab_name] ~= nil then
						local var_23_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_4.prefab_name].transform, "story_v_side_new_1109701", "1109701005", "story_v_side_new_1109701.awb")

						arg_20_1:RecordAudio("1109701005", var_23_10)
						arg_20_1:RecordAudio("1109701005", var_23_10)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_side_new_1109701", "1109701005", "story_v_side_new_1109701.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_side_new_1109701", "1109701005", "story_v_side_new_1109701.awb")
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
	Play1109701006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 1109701006
		arg_24_1.duration_ = 5

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play1109701007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = arg_24_1.actors_["1019ui_story"]
			local var_27_1 = 0

			if var_27_1 < arg_24_1.time_ and arg_24_1.time_ <= var_27_1 + arg_27_0 and not isNil(var_27_0) and arg_24_1.var_.characterEffect1019ui_story == nil then
				arg_24_1.var_.characterEffect1019ui_story = var_27_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_2 = 0.200000002980232

			if var_27_1 <= arg_24_1.time_ and arg_24_1.time_ < var_27_1 + var_27_2 and not isNil(var_27_0) then
				local var_27_3 = (arg_24_1.time_ - var_27_1) / var_27_2

				if arg_24_1.var_.characterEffect1019ui_story and not isNil(var_27_0) then
					local var_27_4 = Mathf.Lerp(0, 0.5, var_27_3)

					arg_24_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_24_1.var_.characterEffect1019ui_story.fillRatio = var_27_4
				end
			end

			if arg_24_1.time_ >= var_27_1 + var_27_2 and arg_24_1.time_ < var_27_1 + var_27_2 + arg_27_0 and not isNil(var_27_0) and arg_24_1.var_.characterEffect1019ui_story then
				local var_27_5 = 0.5

				arg_24_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_24_1.var_.characterEffect1019ui_story.fillRatio = var_27_5
			end

			local var_27_6 = 0
			local var_27_7 = 0.375

			if var_27_6 < arg_24_1.time_ and arg_24_1.time_ <= var_27_6 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				local var_27_8 = arg_24_1:FormatText(StoryNameCfg[950].name)

				arg_24_1.leftNameTxt_.text = var_27_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_9 = arg_24_1:GetWordFromCfg(1109701006)
				local var_27_10 = arg_24_1:FormatText(var_27_9.content)

				arg_24_1.text_.text = var_27_10

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_11 = 15
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
				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_14 = math.max(var_27_7, arg_24_1.talkMaxDuration)

			if var_27_6 <= arg_24_1.time_ and arg_24_1.time_ < var_27_6 + var_27_14 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_6) / var_27_14

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_6 + var_27_14 and arg_24_1.time_ < var_27_6 + var_27_14 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play1109701007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 1109701007
		arg_28_1.duration_ = 7

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play1109701008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = "ST01"

			if arg_28_1.bgs_[var_31_0] == nil then
				local var_31_1 = Object.Instantiate(arg_28_1.paintGo_)

				var_31_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_31_0)
				var_31_1.name = var_31_0
				var_31_1.transform.parent = arg_28_1.stage_.transform
				var_31_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_28_1.bgs_[var_31_0] = var_31_1
			end

			local var_31_2 = 0

			if var_31_2 < arg_28_1.time_ and arg_28_1.time_ <= var_31_2 + arg_31_0 then
				local var_31_3 = manager.ui.mainCamera.transform.localPosition
				local var_31_4 = Vector3.New(0, 0, 10) + Vector3.New(var_31_3.x, var_31_3.y, 0)
				local var_31_5 = arg_28_1.bgs_.ST01

				var_31_5.transform.localPosition = var_31_4
				var_31_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_31_6 = var_31_5:GetComponent("SpriteRenderer")

				if var_31_6 and var_31_6.sprite then
					local var_31_7 = (var_31_5.transform.localPosition - var_31_3).z
					local var_31_8 = manager.ui.mainCameraCom_
					local var_31_9 = 2 * var_31_7 * Mathf.Tan(var_31_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_31_10 = var_31_9 * var_31_8.aspect
					local var_31_11 = var_31_6.sprite.bounds.size.x
					local var_31_12 = var_31_6.sprite.bounds.size.y
					local var_31_13 = var_31_10 / var_31_11
					local var_31_14 = var_31_9 / var_31_12
					local var_31_15 = var_31_14 < var_31_13 and var_31_13 or var_31_14

					var_31_5.transform.localScale = Vector3.New(var_31_15, var_31_15, 0)
				end

				for iter_31_0, iter_31_1 in pairs(arg_28_1.bgs_) do
					if iter_31_0 ~= "ST01" then
						iter_31_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_31_16 = 0

			if var_31_16 < arg_28_1.time_ and arg_28_1.time_ <= var_31_16 + arg_31_0 then
				arg_28_1.mask_.enabled = true
				arg_28_1.mask_.raycastTarget = true

				arg_28_1:SetGaussion(false)
			end

			local var_31_17 = 2

			if var_31_16 <= arg_28_1.time_ and arg_28_1.time_ < var_31_16 + var_31_17 then
				local var_31_18 = (arg_28_1.time_ - var_31_16) / var_31_17
				local var_31_19 = Color.New(1, 1, 1)

				var_31_19.a = Mathf.Lerp(1, 0, var_31_18)
				arg_28_1.mask_.color = var_31_19
			end

			if arg_28_1.time_ >= var_31_16 + var_31_17 and arg_28_1.time_ < var_31_16 + var_31_17 + arg_31_0 then
				local var_31_20 = Color.New(1, 1, 1)
				local var_31_21 = 0

				arg_28_1.mask_.enabled = false
				var_31_20.a = var_31_21
				arg_28_1.mask_.color = var_31_20
			end

			local var_31_22 = arg_28_1.actors_["1019ui_story"].transform
			local var_31_23 = 0

			if var_31_23 < arg_28_1.time_ and arg_28_1.time_ <= var_31_23 + arg_31_0 then
				arg_28_1.var_.moveOldPos1019ui_story = var_31_22.localPosition
			end

			local var_31_24 = 0.001

			if var_31_23 <= arg_28_1.time_ and arg_28_1.time_ < var_31_23 + var_31_24 then
				local var_31_25 = (arg_28_1.time_ - var_31_23) / var_31_24
				local var_31_26 = Vector3.New(0, 100, 0)

				var_31_22.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos1019ui_story, var_31_26, var_31_25)

				local var_31_27 = manager.ui.mainCamera.transform.position - var_31_22.position

				var_31_22.forward = Vector3.New(var_31_27.x, var_31_27.y, var_31_27.z)

				local var_31_28 = var_31_22.localEulerAngles

				var_31_28.z = 0
				var_31_28.x = 0
				var_31_22.localEulerAngles = var_31_28
			end

			if arg_28_1.time_ >= var_31_23 + var_31_24 and arg_28_1.time_ < var_31_23 + var_31_24 + arg_31_0 then
				var_31_22.localPosition = Vector3.New(0, 100, 0)

				local var_31_29 = manager.ui.mainCamera.transform.position - var_31_22.position

				var_31_22.forward = Vector3.New(var_31_29.x, var_31_29.y, var_31_29.z)

				local var_31_30 = var_31_22.localEulerAngles

				var_31_30.z = 0
				var_31_30.x = 0
				var_31_22.localEulerAngles = var_31_30
			end

			local var_31_31 = arg_28_1.actors_["1019ui_story"]
			local var_31_32 = 0

			if var_31_32 < arg_28_1.time_ and arg_28_1.time_ <= var_31_32 + arg_31_0 and not isNil(var_31_31) and arg_28_1.var_.characterEffect1019ui_story == nil then
				arg_28_1.var_.characterEffect1019ui_story = var_31_31:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_33 = 0.034000001847744

			if var_31_32 <= arg_28_1.time_ and arg_28_1.time_ < var_31_32 + var_31_33 and not isNil(var_31_31) then
				local var_31_34 = (arg_28_1.time_ - var_31_32) / var_31_33

				if arg_28_1.var_.characterEffect1019ui_story and not isNil(var_31_31) then
					local var_31_35 = Mathf.Lerp(0, 0.5, var_31_34)

					arg_28_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_28_1.var_.characterEffect1019ui_story.fillRatio = var_31_35
				end
			end

			if arg_28_1.time_ >= var_31_32 + var_31_33 and arg_28_1.time_ < var_31_32 + var_31_33 + arg_31_0 and not isNil(var_31_31) and arg_28_1.var_.characterEffect1019ui_story then
				local var_31_36 = 0.5

				arg_28_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_28_1.var_.characterEffect1019ui_story.fillRatio = var_31_36
			end

			local var_31_37 = 0
			local var_31_38 = 0.2

			if var_31_37 < arg_28_1.time_ and arg_28_1.time_ <= var_31_37 + arg_31_0 then
				local var_31_39 = "play"
				local var_31_40 = "music"

				arg_28_1:AudioAction(var_31_39, var_31_40, "ui_battle", "ui_battle_stopbgm", "")

				local var_31_41 = ""
				local var_31_42 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_31_42 ~= "" then
					if arg_28_1.bgmTxt_.text ~= var_31_42 and arg_28_1.bgmTxt_.text ~= "" then
						if arg_28_1.bgmTxt2_.text ~= "" then
							arg_28_1.bgmTxt_.text = arg_28_1.bgmTxt2_.text
						end

						arg_28_1.bgmTxt2_.text = var_31_42

						arg_28_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_28_1.bgmTxt_.text = var_31_42
						arg_28_1.bgmTxt2_.text = var_31_42
					end

					if arg_28_1.bgmTimer then
						arg_28_1.bgmTimer:Stop()

						arg_28_1.bgmTimer = nil
					end

					if arg_28_1.settingData.show_music_name == 1 then
						arg_28_1.musicController:SetSelectedState("show")
						arg_28_1.musicAnimator_:Play("open", 0, 0)

						if arg_28_1.settingData.music_time ~= 0 then
							arg_28_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_28_1.settingData.music_time), function()
								if arg_28_1 == nil or isNil(arg_28_1.bgmTxt_) then
									return
								end

								arg_28_1.musicController:SetSelectedState("hide")
								arg_28_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_31_43 = 0.3
			local var_31_44 = 0.9

			if var_31_43 < arg_28_1.time_ and arg_28_1.time_ <= var_31_43 + arg_31_0 then
				local var_31_45 = "play"
				local var_31_46 = "music"

				arg_28_1:AudioAction(var_31_45, var_31_46, "bgm_side_daily05", "bgm_side_daily05", "bgm_side_daily05.awb")

				local var_31_47 = ""
				local var_31_48 = manager.audio:GetAudioName("bgm_side_daily05", "bgm_side_daily05")

				if var_31_48 ~= "" then
					if arg_28_1.bgmTxt_.text ~= var_31_48 and arg_28_1.bgmTxt_.text ~= "" then
						if arg_28_1.bgmTxt2_.text ~= "" then
							arg_28_1.bgmTxt_.text = arg_28_1.bgmTxt2_.text
						end

						arg_28_1.bgmTxt2_.text = var_31_48

						arg_28_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_28_1.bgmTxt_.text = var_31_48
						arg_28_1.bgmTxt2_.text = var_31_48
					end

					if arg_28_1.bgmTimer then
						arg_28_1.bgmTimer:Stop()

						arg_28_1.bgmTimer = nil
					end

					if arg_28_1.settingData.show_music_name == 1 then
						arg_28_1.musicController:SetSelectedState("show")
						arg_28_1.musicAnimator_:Play("open", 0, 0)

						if arg_28_1.settingData.music_time ~= 0 then
							arg_28_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_28_1.settingData.music_time), function()
								if arg_28_1 == nil or isNil(arg_28_1.bgmTxt_) then
									return
								end

								arg_28_1.musicController:SetSelectedState("hide")
								arg_28_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_28_1.frameCnt_ <= 1 then
				arg_28_1.dialog_:SetActive(false)
			end

			local var_31_49 = 2
			local var_31_50 = 0.425

			if var_31_49 < arg_28_1.time_ and arg_28_1.time_ <= var_31_49 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0

				arg_28_1.dialog_:SetActive(true)

				arg_28_1.dialogCg_.alpha = 0

				local var_31_51 = LeanTween.value(arg_28_1.dialog_, 0, 1, 0.3)

				var_31_51:setOnUpdate(LuaHelper.FloatAction(function(arg_34_0)
					arg_28_1.dialogCg_.alpha = arg_34_0
				end))
				var_31_51:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_28_1.dialog_)
					var_31_51:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_28_1.duration_ = arg_28_1.duration_ + 0.3

				SetActive(arg_28_1.leftNameGo_, true)

				local var_31_52 = arg_28_1:FormatText(StoryNameCfg[7].name)

				arg_28_1.leftNameTxt_.text = var_31_52

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, true)
				arg_28_1.iconController_:SetSelectedState("hero")

				arg_28_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_28_1.callingController_:SetSelectedState("normal")

				arg_28_1.keyicon_.color = Color.New(1, 1, 1)
				arg_28_1.icon_.color = Color.New(1, 1, 1)

				local var_31_53 = arg_28_1:GetWordFromCfg(1109701007)
				local var_31_54 = arg_28_1:FormatText(var_31_53.content)

				arg_28_1.text_.text = var_31_54

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_55 = 17
				local var_31_56 = utf8.len(var_31_54)
				local var_31_57 = var_31_55 <= 0 and var_31_50 or var_31_50 * (var_31_56 / var_31_55)

				if var_31_57 > 0 and var_31_50 < var_31_57 then
					arg_28_1.talkMaxDuration = var_31_57
					var_31_49 = var_31_49 + 0.3

					if var_31_57 + var_31_49 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_57 + var_31_49
					end
				end

				arg_28_1.text_.text = var_31_54
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)
				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_58 = var_31_49 + 0.3
			local var_31_59 = math.max(var_31_50, arg_28_1.talkMaxDuration)

			if var_31_58 <= arg_28_1.time_ and arg_28_1.time_ < var_31_58 + var_31_59 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_58) / var_31_59

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_58 + var_31_59 and arg_28_1.time_ < var_31_58 + var_31_59 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_28_1:InitPlayNodeList()
	end,
	Play1109701008 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 1109701008
		arg_36_1.duration_ = 5

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play1109701009(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = 0
			local var_39_1 = 1.1

			if var_39_0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_0 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, false)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_2 = arg_36_1:GetWordFromCfg(1109701008)
				local var_39_3 = arg_36_1:FormatText(var_39_2.content)

				arg_36_1.text_.text = var_39_3

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_4 = 44
				local var_39_5 = utf8.len(var_39_3)
				local var_39_6 = var_39_4 <= 0 and var_39_1 or var_39_1 * (var_39_5 / var_39_4)

				if var_39_6 > 0 and var_39_1 < var_39_6 then
					arg_36_1.talkMaxDuration = var_39_6

					if var_39_6 + var_39_0 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_6 + var_39_0
					end
				end

				arg_36_1.text_.text = var_39_3
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)
				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_7 = math.max(var_39_1, arg_36_1.talkMaxDuration)

			if var_39_0 <= arg_36_1.time_ and arg_36_1.time_ < var_39_0 + var_39_7 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_0) / var_39_7

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_0 + var_39_7 and arg_36_1.time_ < var_39_0 + var_39_7 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play1109701009 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 1109701009
		arg_40_1.duration_ = 5

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play1109701010(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = 0
			local var_43_1 = 0.5

			if var_43_0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_0 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				local var_43_2 = arg_40_1:FormatText(StoryNameCfg[7].name)

				arg_40_1.leftNameTxt_.text = var_43_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, true)
				arg_40_1.iconController_:SetSelectedState("hero")

				arg_40_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_40_1.callingController_:SetSelectedState("normal")

				arg_40_1.keyicon_.color = Color.New(1, 1, 1)
				arg_40_1.icon_.color = Color.New(1, 1, 1)

				local var_43_3 = arg_40_1:GetWordFromCfg(1109701009)
				local var_43_4 = arg_40_1:FormatText(var_43_3.content)

				arg_40_1.text_.text = var_43_4

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_5 = 20
				local var_43_6 = utf8.len(var_43_4)
				local var_43_7 = var_43_5 <= 0 and var_43_1 or var_43_1 * (var_43_6 / var_43_5)

				if var_43_7 > 0 and var_43_1 < var_43_7 then
					arg_40_1.talkMaxDuration = var_43_7

					if var_43_7 + var_43_0 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_7 + var_43_0
					end
				end

				arg_40_1.text_.text = var_43_4
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)
				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_8 = math.max(var_43_1, arg_40_1.talkMaxDuration)

			if var_43_0 <= arg_40_1.time_ and arg_40_1.time_ < var_43_0 + var_43_8 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_0) / var_43_8

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_0 + var_43_8 and arg_40_1.time_ < var_43_0 + var_43_8 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play1109701010 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 1109701010
		arg_44_1.duration_ = 5

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play1109701011(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = 0
			local var_47_1 = 1.25

			if var_47_0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_0 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, false)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_2 = arg_44_1:GetWordFromCfg(1109701010)
				local var_47_3 = arg_44_1:FormatText(var_47_2.content)

				arg_44_1.text_.text = var_47_3

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_4 = 50
				local var_47_5 = utf8.len(var_47_3)
				local var_47_6 = var_47_4 <= 0 and var_47_1 or var_47_1 * (var_47_5 / var_47_4)

				if var_47_6 > 0 and var_47_1 < var_47_6 then
					arg_44_1.talkMaxDuration = var_47_6

					if var_47_6 + var_47_0 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_6 + var_47_0
					end
				end

				arg_44_1.text_.text = var_47_3
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)
				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_7 = math.max(var_47_1, arg_44_1.talkMaxDuration)

			if var_47_0 <= arg_44_1.time_ and arg_44_1.time_ < var_47_0 + var_47_7 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_0) / var_47_7

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_0 + var_47_7 and arg_44_1.time_ < var_47_0 + var_47_7 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play1109701011 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 1109701011
		arg_48_1.duration_ = 5

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play1109701012(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = 0
			local var_51_1 = 0.975

			if var_51_0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_0 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, false)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_2 = arg_48_1:GetWordFromCfg(1109701011)
				local var_51_3 = arg_48_1:FormatText(var_51_2.content)

				arg_48_1.text_.text = var_51_3

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_4 = 39
				local var_51_5 = utf8.len(var_51_3)
				local var_51_6 = var_51_4 <= 0 and var_51_1 or var_51_1 * (var_51_5 / var_51_4)

				if var_51_6 > 0 and var_51_1 < var_51_6 then
					arg_48_1.talkMaxDuration = var_51_6

					if var_51_6 + var_51_0 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_6 + var_51_0
					end
				end

				arg_48_1.text_.text = var_51_3
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)
				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_7 = math.max(var_51_1, arg_48_1.talkMaxDuration)

			if var_51_0 <= arg_48_1.time_ and arg_48_1.time_ < var_51_0 + var_51_7 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_0) / var_51_7

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_0 + var_51_7 and arg_48_1.time_ < var_51_0 + var_51_7 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play1109701012 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 1109701012
		arg_52_1.duration_ = 5.97

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play1109701013(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = "F01"

			if arg_52_1.bgs_[var_55_0] == nil then
				local var_55_1 = Object.Instantiate(arg_52_1.paintGo_)

				var_55_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_55_0)
				var_55_1.name = var_55_0
				var_55_1.transform.parent = arg_52_1.stage_.transform
				var_55_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_52_1.bgs_[var_55_0] = var_55_1
			end

			local var_55_2 = 2

			if var_55_2 < arg_52_1.time_ and arg_52_1.time_ <= var_55_2 + arg_55_0 then
				local var_55_3 = manager.ui.mainCamera.transform.localPosition
				local var_55_4 = Vector3.New(0, 0, 10) + Vector3.New(var_55_3.x, var_55_3.y, 0)
				local var_55_5 = arg_52_1.bgs_.F01

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
					if iter_55_0 ~= "F01" then
						iter_55_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_55_16 = 0

			if var_55_16 < arg_52_1.time_ and arg_52_1.time_ <= var_55_16 + arg_55_0 then
				arg_52_1.mask_.enabled = true
				arg_52_1.mask_.raycastTarget = true

				arg_52_1:SetGaussion(false)
			end

			local var_55_17 = 2

			if var_55_16 <= arg_52_1.time_ and arg_52_1.time_ < var_55_16 + var_55_17 then
				local var_55_18 = (arg_52_1.time_ - var_55_16) / var_55_17
				local var_55_19 = Color.New(0, 0, 0)

				var_55_19.a = Mathf.Lerp(0, 1, var_55_18)
				arg_52_1.mask_.color = var_55_19
			end

			if arg_52_1.time_ >= var_55_16 + var_55_17 and arg_52_1.time_ < var_55_16 + var_55_17 + arg_55_0 then
				local var_55_20 = Color.New(0, 0, 0)

				var_55_20.a = 1
				arg_52_1.mask_.color = var_55_20
			end

			local var_55_21 = 2

			if var_55_21 < arg_52_1.time_ and arg_52_1.time_ <= var_55_21 + arg_55_0 then
				arg_52_1.mask_.enabled = true
				arg_52_1.mask_.raycastTarget = true

				arg_52_1:SetGaussion(false)
			end

			local var_55_22 = 2

			if var_55_21 <= arg_52_1.time_ and arg_52_1.time_ < var_55_21 + var_55_22 then
				local var_55_23 = (arg_52_1.time_ - var_55_21) / var_55_22
				local var_55_24 = Color.New(0, 0, 0)

				var_55_24.a = Mathf.Lerp(1, 0, var_55_23)
				arg_52_1.mask_.color = var_55_24
			end

			if arg_52_1.time_ >= var_55_21 + var_55_22 and arg_52_1.time_ < var_55_21 + var_55_22 + arg_55_0 then
				local var_55_25 = Color.New(0, 0, 0)
				local var_55_26 = 0

				arg_52_1.mask_.enabled = false
				var_55_25.a = var_55_26
				arg_52_1.mask_.color = var_55_25
			end

			local var_55_27 = "1042ui_story"

			if arg_52_1.actors_[var_55_27] == nil then
				local var_55_28 = Asset.Load("Char/" .. "1042ui_story")

				if not isNil(var_55_28) then
					local var_55_29 = Object.Instantiate(Asset.Load("Char/" .. "1042ui_story"), arg_52_1.stage_.transform)

					var_55_29.name = var_55_27
					var_55_29.transform.localPosition = Vector3.New(0, 100, 0)
					arg_52_1.actors_[var_55_27] = var_55_29

					local var_55_30 = var_55_29:GetComponentInChildren(typeof(CharacterEffect))

					var_55_30.enabled = true

					local var_55_31 = GameObjectTools.GetOrAddComponent(var_55_29, typeof(DynamicBoneHelper))

					if var_55_31 then
						var_55_31:EnableDynamicBone(false)
					end

					arg_52_1:ShowWeapon(var_55_30.transform, false)

					arg_52_1.var_[var_55_27 .. "Animator"] = var_55_30.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_52_1.var_[var_55_27 .. "Animator"].applyRootMotion = true
					arg_52_1.var_[var_55_27 .. "LipSync"] = var_55_30.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_55_32 = arg_52_1.actors_["1042ui_story"].transform
			local var_55_33 = 3.8

			if var_55_33 < arg_52_1.time_ and arg_52_1.time_ <= var_55_33 + arg_55_0 then
				arg_52_1.var_.moveOldPos1042ui_story = var_55_32.localPosition
			end

			local var_55_34 = 0.001

			if var_55_33 <= arg_52_1.time_ and arg_52_1.time_ < var_55_33 + var_55_34 then
				local var_55_35 = (arg_52_1.time_ - var_55_33) / var_55_34
				local var_55_36 = Vector3.New(0, -1.06, -6.2)

				var_55_32.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPos1042ui_story, var_55_36, var_55_35)

				local var_55_37 = manager.ui.mainCamera.transform.position - var_55_32.position

				var_55_32.forward = Vector3.New(var_55_37.x, var_55_37.y, var_55_37.z)

				local var_55_38 = var_55_32.localEulerAngles

				var_55_38.z = 0
				var_55_38.x = 0
				var_55_32.localEulerAngles = var_55_38
			end

			if arg_52_1.time_ >= var_55_33 + var_55_34 and arg_52_1.time_ < var_55_33 + var_55_34 + arg_55_0 then
				var_55_32.localPosition = Vector3.New(0, -1.06, -6.2)

				local var_55_39 = manager.ui.mainCamera.transform.position - var_55_32.position

				var_55_32.forward = Vector3.New(var_55_39.x, var_55_39.y, var_55_39.z)

				local var_55_40 = var_55_32.localEulerAngles

				var_55_40.z = 0
				var_55_40.x = 0
				var_55_32.localEulerAngles = var_55_40
			end

			local var_55_41 = arg_52_1.actors_["1042ui_story"]
			local var_55_42 = 3.8

			if var_55_42 < arg_52_1.time_ and arg_52_1.time_ <= var_55_42 + arg_55_0 and not isNil(var_55_41) and arg_52_1.var_.characterEffect1042ui_story == nil then
				arg_52_1.var_.characterEffect1042ui_story = var_55_41:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_43 = 0.200000002980232

			if var_55_42 <= arg_52_1.time_ and arg_52_1.time_ < var_55_42 + var_55_43 and not isNil(var_55_41) then
				local var_55_44 = (arg_52_1.time_ - var_55_42) / var_55_43

				if arg_52_1.var_.characterEffect1042ui_story and not isNil(var_55_41) then
					arg_52_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_52_1.time_ >= var_55_42 + var_55_43 and arg_52_1.time_ < var_55_42 + var_55_43 + arg_55_0 and not isNil(var_55_41) and arg_52_1.var_.characterEffect1042ui_story then
				arg_52_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_55_45 = 3.8

			if var_55_45 < arg_52_1.time_ and arg_52_1.time_ <= var_55_45 + arg_55_0 then
				arg_52_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action4_1")
			end

			local var_55_46 = 3.8

			if var_55_46 < arg_52_1.time_ and arg_52_1.time_ <= var_55_46 + arg_55_0 then
				arg_52_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0201cva")
			end

			if arg_52_1.frameCnt_ <= 1 then
				arg_52_1.dialog_:SetActive(false)
			end

			local var_55_47 = 4
			local var_55_48 = 0.075

			if var_55_47 < arg_52_1.time_ and arg_52_1.time_ <= var_55_47 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0

				arg_52_1.dialog_:SetActive(true)

				arg_52_1.dialogCg_.alpha = 0

				local var_55_49 = LeanTween.value(arg_52_1.dialog_, 0, 1, 0.3)

				var_55_49:setOnUpdate(LuaHelper.FloatAction(function(arg_56_0)
					arg_52_1.dialogCg_.alpha = arg_56_0
				end))
				var_55_49:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_52_1.dialog_)
					var_55_49:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_52_1.duration_ = arg_52_1.duration_ + 0.3

				SetActive(arg_52_1.leftNameGo_, true)

				local var_55_50 = arg_52_1:FormatText(StoryNameCfg[205].name)

				arg_52_1.leftNameTxt_.text = var_55_50

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_51 = arg_52_1:GetWordFromCfg(1109701012)
				local var_55_52 = arg_52_1:FormatText(var_55_51.content)

				arg_52_1.text_.text = var_55_52

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_53 = 3
				local var_55_54 = utf8.len(var_55_52)
				local var_55_55 = var_55_53 <= 0 and var_55_48 or var_55_48 * (var_55_54 / var_55_53)

				if var_55_55 > 0 and var_55_48 < var_55_55 then
					arg_52_1.talkMaxDuration = var_55_55
					var_55_47 = var_55_47 + 0.3

					if var_55_55 + var_55_47 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_55 + var_55_47
					end
				end

				arg_52_1.text_.text = var_55_52
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701012", "story_v_side_new_1109701.awb") ~= 0 then
					local var_55_56 = manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701012", "story_v_side_new_1109701.awb") / 1000

					if var_55_56 + var_55_47 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_56 + var_55_47
					end

					if var_55_51.prefab_name ~= "" and arg_52_1.actors_[var_55_51.prefab_name] ~= nil then
						local var_55_57 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_51.prefab_name].transform, "story_v_side_new_1109701", "1109701012", "story_v_side_new_1109701.awb")

						arg_52_1:RecordAudio("1109701012", var_55_57)
						arg_52_1:RecordAudio("1109701012", var_55_57)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_side_new_1109701", "1109701012", "story_v_side_new_1109701.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_side_new_1109701", "1109701012", "story_v_side_new_1109701.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_58 = var_55_47 + 0.3
			local var_55_59 = math.max(var_55_48, arg_52_1.talkMaxDuration)

			if var_55_58 <= arg_52_1.time_ and arg_52_1.time_ < var_55_58 + var_55_59 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_58) / var_55_59

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_58 + var_55_59 and arg_52_1.time_ < var_55_58 + var_55_59 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_52_1:InitPlayNodeList()
	end,
	Play1109701013 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 1109701013
		arg_58_1.duration_ = 5.13

		local var_58_0 = {
			zh = 5.133,
			ja = 4.166
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
				arg_58_0:Play1109701014(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			local var_61_0 = arg_58_1.actors_["1042ui_story"].transform
			local var_61_1 = 0

			if var_61_1 < arg_58_1.time_ and arg_58_1.time_ <= var_61_1 + arg_61_0 then
				arg_58_1.var_.moveOldPos1042ui_story = var_61_0.localPosition
			end

			local var_61_2 = 0.001

			if var_61_1 <= arg_58_1.time_ and arg_58_1.time_ < var_61_1 + var_61_2 then
				local var_61_3 = (arg_58_1.time_ - var_61_1) / var_61_2
				local var_61_4 = Vector3.New(0, 100, 0)

				var_61_0.localPosition = Vector3.Lerp(arg_58_1.var_.moveOldPos1042ui_story, var_61_4, var_61_3)

				local var_61_5 = manager.ui.mainCamera.transform.position - var_61_0.position

				var_61_0.forward = Vector3.New(var_61_5.x, var_61_5.y, var_61_5.z)

				local var_61_6 = var_61_0.localEulerAngles

				var_61_6.z = 0
				var_61_6.x = 0
				var_61_0.localEulerAngles = var_61_6
			end

			if arg_58_1.time_ >= var_61_1 + var_61_2 and arg_58_1.time_ < var_61_1 + var_61_2 + arg_61_0 then
				var_61_0.localPosition = Vector3.New(0, 100, 0)

				local var_61_7 = manager.ui.mainCamera.transform.position - var_61_0.position

				var_61_0.forward = Vector3.New(var_61_7.x, var_61_7.y, var_61_7.z)

				local var_61_8 = var_61_0.localEulerAngles

				var_61_8.z = 0
				var_61_8.x = 0
				var_61_0.localEulerAngles = var_61_8
			end

			local var_61_9 = arg_58_1.actors_["1042ui_story"]
			local var_61_10 = 0

			if var_61_10 < arg_58_1.time_ and arg_58_1.time_ <= var_61_10 + arg_61_0 and not isNil(var_61_9) and arg_58_1.var_.characterEffect1042ui_story == nil then
				arg_58_1.var_.characterEffect1042ui_story = var_61_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_61_11 = 0.200000002980232

			if var_61_10 <= arg_58_1.time_ and arg_58_1.time_ < var_61_10 + var_61_11 and not isNil(var_61_9) then
				local var_61_12 = (arg_58_1.time_ - var_61_10) / var_61_11

				if arg_58_1.var_.characterEffect1042ui_story and not isNil(var_61_9) then
					local var_61_13 = Mathf.Lerp(0, 0.5, var_61_12)

					arg_58_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_58_1.var_.characterEffect1042ui_story.fillRatio = var_61_13
				end
			end

			if arg_58_1.time_ >= var_61_10 + var_61_11 and arg_58_1.time_ < var_61_10 + var_61_11 + arg_61_0 and not isNil(var_61_9) and arg_58_1.var_.characterEffect1042ui_story then
				local var_61_14 = 0.5

				arg_58_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_58_1.var_.characterEffect1042ui_story.fillRatio = var_61_14
			end

			local var_61_15 = "6045_story"

			if arg_58_1.actors_[var_61_15] == nil then
				local var_61_16 = Asset.Load("Char/" .. "6045_story")

				if not isNil(var_61_16) then
					local var_61_17 = Object.Instantiate(Asset.Load("Char/" .. "6045_story"), arg_58_1.stage_.transform)

					var_61_17.name = var_61_15
					var_61_17.transform.localPosition = Vector3.New(0, 100, 0)
					arg_58_1.actors_[var_61_15] = var_61_17

					local var_61_18 = var_61_17:GetComponentInChildren(typeof(CharacterEffect))

					var_61_18.enabled = true

					local var_61_19 = GameObjectTools.GetOrAddComponent(var_61_17, typeof(DynamicBoneHelper))

					if var_61_19 then
						var_61_19:EnableDynamicBone(false)
					end

					arg_58_1:ShowWeapon(var_61_18.transform, false)

					arg_58_1.var_[var_61_15 .. "Animator"] = var_61_18.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_58_1.var_[var_61_15 .. "Animator"].applyRootMotion = true
					arg_58_1.var_[var_61_15 .. "LipSync"] = var_61_18.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_61_20 = arg_58_1.actors_["6045_story"].transform
			local var_61_21 = 0

			if var_61_21 < arg_58_1.time_ and arg_58_1.time_ <= var_61_21 + arg_61_0 then
				arg_58_1.var_.moveOldPos6045_story = var_61_20.localPosition

				local var_61_22 = GameObjectTools.GetOrAddComponent(var_61_20.gameObject, typeof(DynamicBoneHelper))

				if var_61_22 then
					var_61_22:EnableDynamicBone(false)
				end
			end

			local var_61_23 = 0.001

			if var_61_21 <= arg_58_1.time_ and arg_58_1.time_ < var_61_21 + var_61_23 then
				local var_61_24 = (arg_58_1.time_ - var_61_21) / var_61_23
				local var_61_25 = Vector3.New(-0.7, -0.5, -6.3)

				var_61_20.localPosition = Vector3.Lerp(arg_58_1.var_.moveOldPos6045_story, var_61_25, var_61_24)

				local var_61_26 = manager.ui.mainCamera.transform.position - var_61_20.position

				var_61_20.forward = Vector3.New(var_61_26.x, var_61_26.y, var_61_26.z)

				local var_61_27 = var_61_20.localEulerAngles

				var_61_27.z = 0
				var_61_27.x = 0
				var_61_20.localEulerAngles = var_61_27
			end

			if arg_58_1.time_ >= var_61_21 + var_61_23 and arg_58_1.time_ < var_61_21 + var_61_23 + arg_61_0 then
				var_61_20.localPosition = Vector3.New(-0.7, -0.5, -6.3)

				local var_61_28 = manager.ui.mainCamera.transform.position - var_61_20.position

				var_61_20.forward = Vector3.New(var_61_28.x, var_61_28.y, var_61_28.z)

				local var_61_29 = var_61_20.localEulerAngles

				var_61_29.z = 0
				var_61_29.x = 0
				var_61_20.localEulerAngles = var_61_29

				local var_61_30 = GameObjectTools.GetOrAddComponent(var_61_20.gameObject, typeof(DynamicBoneHelper))

				if var_61_30 then
					var_61_30:EnableDynamicBone(true)
				end
			end

			local var_61_31 = arg_58_1.actors_["6045_story"]
			local var_61_32 = 0

			if var_61_32 < arg_58_1.time_ and arg_58_1.time_ <= var_61_32 + arg_61_0 and not isNil(var_61_31) and arg_58_1.var_.characterEffect6045_story == nil then
				arg_58_1.var_.characterEffect6045_story = var_61_31:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_61_33 = 0.200000002980232

			if var_61_32 <= arg_58_1.time_ and arg_58_1.time_ < var_61_32 + var_61_33 and not isNil(var_61_31) then
				local var_61_34 = (arg_58_1.time_ - var_61_32) / var_61_33

				if arg_58_1.var_.characterEffect6045_story and not isNil(var_61_31) then
					arg_58_1.var_.characterEffect6045_story.fillFlat = false
				end
			end

			if arg_58_1.time_ >= var_61_32 + var_61_33 and arg_58_1.time_ < var_61_32 + var_61_33 + arg_61_0 and not isNil(var_61_31) and arg_58_1.var_.characterEffect6045_story then
				arg_58_1.var_.characterEffect6045_story.fillFlat = false
			end

			local var_61_35 = 0

			if var_61_35 < arg_58_1.time_ and arg_58_1.time_ <= var_61_35 + arg_61_0 then
				arg_58_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/story6045/story6045action/6045action1_1")
			end

			local var_61_36 = 0

			if var_61_36 < arg_58_1.time_ and arg_58_1.time_ <= var_61_36 + arg_61_0 then
				arg_58_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_61_37 = "6046_story"

			if arg_58_1.actors_[var_61_37] == nil then
				local var_61_38 = Asset.Load("Char/" .. "6046_story")

				if not isNil(var_61_38) then
					local var_61_39 = Object.Instantiate(Asset.Load("Char/" .. "6046_story"), arg_58_1.stage_.transform)

					var_61_39.name = var_61_37
					var_61_39.transform.localPosition = Vector3.New(0, 100, 0)
					arg_58_1.actors_[var_61_37] = var_61_39

					local var_61_40 = var_61_39:GetComponentInChildren(typeof(CharacterEffect))

					var_61_40.enabled = true

					local var_61_41 = GameObjectTools.GetOrAddComponent(var_61_39, typeof(DynamicBoneHelper))

					if var_61_41 then
						var_61_41:EnableDynamicBone(false)
					end

					arg_58_1:ShowWeapon(var_61_40.transform, false)

					arg_58_1.var_[var_61_37 .. "Animator"] = var_61_40.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_58_1.var_[var_61_37 .. "Animator"].applyRootMotion = true
					arg_58_1.var_[var_61_37 .. "LipSync"] = var_61_40.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_61_42 = arg_58_1.actors_["6046_story"].transform
			local var_61_43 = 0

			if var_61_43 < arg_58_1.time_ and arg_58_1.time_ <= var_61_43 + arg_61_0 then
				arg_58_1.var_.moveOldPos6046_story = var_61_42.localPosition

				local var_61_44 = GameObjectTools.GetOrAddComponent(var_61_42.gameObject, typeof(DynamicBoneHelper))

				if var_61_44 then
					var_61_44:EnableDynamicBone(false)
				end
			end

			local var_61_45 = 0.001

			if var_61_43 <= arg_58_1.time_ and arg_58_1.time_ < var_61_43 + var_61_45 then
				local var_61_46 = (arg_58_1.time_ - var_61_43) / var_61_45
				local var_61_47 = Vector3.New(0.7, -0.5, -6.3)

				var_61_42.localPosition = Vector3.Lerp(arg_58_1.var_.moveOldPos6046_story, var_61_47, var_61_46)

				local var_61_48 = manager.ui.mainCamera.transform.position - var_61_42.position

				var_61_42.forward = Vector3.New(var_61_48.x, var_61_48.y, var_61_48.z)

				local var_61_49 = var_61_42.localEulerAngles

				var_61_49.z = 0
				var_61_49.x = 0
				var_61_42.localEulerAngles = var_61_49
			end

			if arg_58_1.time_ >= var_61_43 + var_61_45 and arg_58_1.time_ < var_61_43 + var_61_45 + arg_61_0 then
				var_61_42.localPosition = Vector3.New(0.7, -0.5, -6.3)

				local var_61_50 = manager.ui.mainCamera.transform.position - var_61_42.position

				var_61_42.forward = Vector3.New(var_61_50.x, var_61_50.y, var_61_50.z)

				local var_61_51 = var_61_42.localEulerAngles

				var_61_51.z = 0
				var_61_51.x = 0
				var_61_42.localEulerAngles = var_61_51

				local var_61_52 = GameObjectTools.GetOrAddComponent(var_61_42.gameObject, typeof(DynamicBoneHelper))

				if var_61_52 then
					var_61_52:EnableDynamicBone(true)
				end
			end

			local var_61_53 = arg_58_1.actors_["6046_story"]
			local var_61_54 = 0

			if var_61_54 < arg_58_1.time_ and arg_58_1.time_ <= var_61_54 + arg_61_0 and not isNil(var_61_53) and arg_58_1.var_.characterEffect6046_story == nil then
				arg_58_1.var_.characterEffect6046_story = var_61_53:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_61_55 = 0.200000002980232

			if var_61_54 <= arg_58_1.time_ and arg_58_1.time_ < var_61_54 + var_61_55 and not isNil(var_61_53) then
				local var_61_56 = (arg_58_1.time_ - var_61_54) / var_61_55

				if arg_58_1.var_.characterEffect6046_story and not isNil(var_61_53) then
					local var_61_57 = Mathf.Lerp(0, 0.5, var_61_56)

					arg_58_1.var_.characterEffect6046_story.fillFlat = true
					arg_58_1.var_.characterEffect6046_story.fillRatio = var_61_57
				end
			end

			if arg_58_1.time_ >= var_61_54 + var_61_55 and arg_58_1.time_ < var_61_54 + var_61_55 + arg_61_0 and not isNil(var_61_53) and arg_58_1.var_.characterEffect6046_story then
				local var_61_58 = 0.5

				arg_58_1.var_.characterEffect6046_story.fillFlat = true
				arg_58_1.var_.characterEffect6046_story.fillRatio = var_61_58
			end

			local var_61_59 = 0
			local var_61_60 = 0.425

			if var_61_59 < arg_58_1.time_ and arg_58_1.time_ <= var_61_59 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, true)

				local var_61_61 = arg_58_1:FormatText(StoryNameCfg[215].name)

				arg_58_1.leftNameTxt_.text = var_61_61

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, false)
				arg_58_1.callingController_:SetSelectedState("normal")

				local var_61_62 = arg_58_1:GetWordFromCfg(1109701013)
				local var_61_63 = arg_58_1:FormatText(var_61_62.content)

				arg_58_1.text_.text = var_61_63

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_64 = 17
				local var_61_65 = utf8.len(var_61_63)
				local var_61_66 = var_61_64 <= 0 and var_61_60 or var_61_60 * (var_61_65 / var_61_64)

				if var_61_66 > 0 and var_61_60 < var_61_66 then
					arg_58_1.talkMaxDuration = var_61_66

					if var_61_66 + var_61_59 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_66 + var_61_59
					end
				end

				arg_58_1.text_.text = var_61_63
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701013", "story_v_side_new_1109701.awb") ~= 0 then
					local var_61_67 = manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701013", "story_v_side_new_1109701.awb") / 1000

					if var_61_67 + var_61_59 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_67 + var_61_59
					end

					if var_61_62.prefab_name ~= "" and arg_58_1.actors_[var_61_62.prefab_name] ~= nil then
						local var_61_68 = LuaForUtil.PlayVoiceWithCriLipsync(arg_58_1.actors_[var_61_62.prefab_name].transform, "story_v_side_new_1109701", "1109701013", "story_v_side_new_1109701.awb")

						arg_58_1:RecordAudio("1109701013", var_61_68)
						arg_58_1:RecordAudio("1109701013", var_61_68)
					else
						arg_58_1:AudioAction("play", "voice", "story_v_side_new_1109701", "1109701013", "story_v_side_new_1109701.awb")
					end

					arg_58_1:RecordHistoryTalkVoice("story_v_side_new_1109701", "1109701013", "story_v_side_new_1109701.awb")
				end

				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_69 = math.max(var_61_60, arg_58_1.talkMaxDuration)

			if var_61_59 <= arg_58_1.time_ and arg_58_1.time_ < var_61_59 + var_61_69 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_59) / var_61_69

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_59 + var_61_69 and arg_58_1.time_ < var_61_59 + var_61_69 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6045_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6046_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_58_1:InitPlayNodeList()
	end,
	Play1109701014 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 1109701014
		arg_62_1.duration_ = 7.67

		local var_62_0 = {
			zh = 6.833,
			ja = 7.666
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
				arg_62_0:Play1109701015(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			local var_65_0 = arg_62_1.actors_["6045_story"].transform
			local var_65_1 = 0

			if var_65_1 < arg_62_1.time_ and arg_62_1.time_ <= var_65_1 + arg_65_0 then
				arg_62_1.var_.moveOldPos6045_story = var_65_0.localPosition

				local var_65_2 = GameObjectTools.GetOrAddComponent(var_65_0.gameObject, typeof(DynamicBoneHelper))

				if var_65_2 then
					var_65_2:EnableDynamicBone(false)
				end
			end

			local var_65_3 = 0.001

			if var_65_1 <= arg_62_1.time_ and arg_62_1.time_ < var_65_1 + var_65_3 then
				local var_65_4 = (arg_62_1.time_ - var_65_1) / var_65_3
				local var_65_5 = Vector3.New(-0.7, -0.5, -6.3)

				var_65_0.localPosition = Vector3.Lerp(arg_62_1.var_.moveOldPos6045_story, var_65_5, var_65_4)

				local var_65_6 = manager.ui.mainCamera.transform.position - var_65_0.position

				var_65_0.forward = Vector3.New(var_65_6.x, var_65_6.y, var_65_6.z)

				local var_65_7 = var_65_0.localEulerAngles

				var_65_7.z = 0
				var_65_7.x = 0
				var_65_0.localEulerAngles = var_65_7
			end

			if arg_62_1.time_ >= var_65_1 + var_65_3 and arg_62_1.time_ < var_65_1 + var_65_3 + arg_65_0 then
				var_65_0.localPosition = Vector3.New(-0.7, -0.5, -6.3)

				local var_65_8 = manager.ui.mainCamera.transform.position - var_65_0.position

				var_65_0.forward = Vector3.New(var_65_8.x, var_65_8.y, var_65_8.z)

				local var_65_9 = var_65_0.localEulerAngles

				var_65_9.z = 0
				var_65_9.x = 0
				var_65_0.localEulerAngles = var_65_9

				local var_65_10 = GameObjectTools.GetOrAddComponent(var_65_0.gameObject, typeof(DynamicBoneHelper))

				if var_65_10 then
					var_65_10:EnableDynamicBone(true)
				end
			end

			local var_65_11 = arg_62_1.actors_["6045_story"]
			local var_65_12 = 0

			if var_65_12 < arg_62_1.time_ and arg_62_1.time_ <= var_65_12 + arg_65_0 and not isNil(var_65_11) and arg_62_1.var_.characterEffect6045_story == nil then
				arg_62_1.var_.characterEffect6045_story = var_65_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_65_13 = 0.200000002980232

			if var_65_12 <= arg_62_1.time_ and arg_62_1.time_ < var_65_12 + var_65_13 and not isNil(var_65_11) then
				local var_65_14 = (arg_62_1.time_ - var_65_12) / var_65_13

				if arg_62_1.var_.characterEffect6045_story and not isNil(var_65_11) then
					local var_65_15 = Mathf.Lerp(0, 0.5, var_65_14)

					arg_62_1.var_.characterEffect6045_story.fillFlat = true
					arg_62_1.var_.characterEffect6045_story.fillRatio = var_65_15
				end
			end

			if arg_62_1.time_ >= var_65_12 + var_65_13 and arg_62_1.time_ < var_65_12 + var_65_13 + arg_65_0 and not isNil(var_65_11) and arg_62_1.var_.characterEffect6045_story then
				local var_65_16 = 0.5

				arg_62_1.var_.characterEffect6045_story.fillFlat = true
				arg_62_1.var_.characterEffect6045_story.fillRatio = var_65_16
			end

			local var_65_17 = arg_62_1.actors_["6046_story"].transform
			local var_65_18 = 0

			if var_65_18 < arg_62_1.time_ and arg_62_1.time_ <= var_65_18 + arg_65_0 then
				arg_62_1.var_.moveOldPos6046_story = var_65_17.localPosition

				local var_65_19 = GameObjectTools.GetOrAddComponent(var_65_17.gameObject, typeof(DynamicBoneHelper))

				if var_65_19 then
					var_65_19:EnableDynamicBone(false)
				end
			end

			local var_65_20 = 0.001

			if var_65_18 <= arg_62_1.time_ and arg_62_1.time_ < var_65_18 + var_65_20 then
				local var_65_21 = (arg_62_1.time_ - var_65_18) / var_65_20
				local var_65_22 = Vector3.New(0.7, -0.5, -6.3)

				var_65_17.localPosition = Vector3.Lerp(arg_62_1.var_.moveOldPos6046_story, var_65_22, var_65_21)

				local var_65_23 = manager.ui.mainCamera.transform.position - var_65_17.position

				var_65_17.forward = Vector3.New(var_65_23.x, var_65_23.y, var_65_23.z)

				local var_65_24 = var_65_17.localEulerAngles

				var_65_24.z = 0
				var_65_24.x = 0
				var_65_17.localEulerAngles = var_65_24
			end

			if arg_62_1.time_ >= var_65_18 + var_65_20 and arg_62_1.time_ < var_65_18 + var_65_20 + arg_65_0 then
				var_65_17.localPosition = Vector3.New(0.7, -0.5, -6.3)

				local var_65_25 = manager.ui.mainCamera.transform.position - var_65_17.position

				var_65_17.forward = Vector3.New(var_65_25.x, var_65_25.y, var_65_25.z)

				local var_65_26 = var_65_17.localEulerAngles

				var_65_26.z = 0
				var_65_26.x = 0
				var_65_17.localEulerAngles = var_65_26

				local var_65_27 = GameObjectTools.GetOrAddComponent(var_65_17.gameObject, typeof(DynamicBoneHelper))

				if var_65_27 then
					var_65_27:EnableDynamicBone(true)
				end
			end

			local var_65_28 = arg_62_1.actors_["6046_story"]
			local var_65_29 = 0

			if var_65_29 < arg_62_1.time_ and arg_62_1.time_ <= var_65_29 + arg_65_0 and not isNil(var_65_28) and arg_62_1.var_.characterEffect6046_story == nil then
				arg_62_1.var_.characterEffect6046_story = var_65_28:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_65_30 = 0.200000002980232

			if var_65_29 <= arg_62_1.time_ and arg_62_1.time_ < var_65_29 + var_65_30 and not isNil(var_65_28) then
				local var_65_31 = (arg_62_1.time_ - var_65_29) / var_65_30

				if arg_62_1.var_.characterEffect6046_story and not isNil(var_65_28) then
					arg_62_1.var_.characterEffect6046_story.fillFlat = false
				end
			end

			if arg_62_1.time_ >= var_65_29 + var_65_30 and arg_62_1.time_ < var_65_29 + var_65_30 + arg_65_0 and not isNil(var_65_28) and arg_62_1.var_.characterEffect6046_story then
				arg_62_1.var_.characterEffect6046_story.fillFlat = false
			end

			local var_65_32 = 0

			if var_65_32 < arg_62_1.time_ and arg_62_1.time_ <= var_65_32 + arg_65_0 then
				arg_62_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/story6046/story6046action/6046action1_1")
			end

			local var_65_33 = 0

			if var_65_33 < arg_62_1.time_ and arg_62_1.time_ <= var_65_33 + arg_65_0 then
				arg_62_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_65_34 = 0
			local var_65_35 = 0.675

			if var_65_34 < arg_62_1.time_ and arg_62_1.time_ <= var_65_34 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, true)

				local var_65_36 = arg_62_1:FormatText(StoryNameCfg[214].name)

				arg_62_1.leftNameTxt_.text = var_65_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_62_1.leftNameTxt_.transform)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1.leftNameTxt_.text)
				SetActive(arg_62_1.iconTrs_.gameObject, false)
				arg_62_1.callingController_:SetSelectedState("normal")

				local var_65_37 = arg_62_1:GetWordFromCfg(1109701014)
				local var_65_38 = arg_62_1:FormatText(var_65_37.content)

				arg_62_1.text_.text = var_65_38

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_39 = 27
				local var_65_40 = utf8.len(var_65_38)
				local var_65_41 = var_65_39 <= 0 and var_65_35 or var_65_35 * (var_65_40 / var_65_39)

				if var_65_41 > 0 and var_65_35 < var_65_41 then
					arg_62_1.talkMaxDuration = var_65_41

					if var_65_41 + var_65_34 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_41 + var_65_34
					end
				end

				arg_62_1.text_.text = var_65_38
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701014", "story_v_side_new_1109701.awb") ~= 0 then
					local var_65_42 = manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701014", "story_v_side_new_1109701.awb") / 1000

					if var_65_42 + var_65_34 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_42 + var_65_34
					end

					if var_65_37.prefab_name ~= "" and arg_62_1.actors_[var_65_37.prefab_name] ~= nil then
						local var_65_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_62_1.actors_[var_65_37.prefab_name].transform, "story_v_side_new_1109701", "1109701014", "story_v_side_new_1109701.awb")

						arg_62_1:RecordAudio("1109701014", var_65_43)
						arg_62_1:RecordAudio("1109701014", var_65_43)
					else
						arg_62_1:AudioAction("play", "voice", "story_v_side_new_1109701", "1109701014", "story_v_side_new_1109701.awb")
					end

					arg_62_1:RecordHistoryTalkVoice("story_v_side_new_1109701", "1109701014", "story_v_side_new_1109701.awb")
				end

				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_44 = math.max(var_65_35, arg_62_1.talkMaxDuration)

			if var_65_34 <= arg_62_1.time_ and arg_62_1.time_ < var_65_34 + var_65_44 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - var_65_34) / var_65_44

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= var_65_34 + var_65_44 and arg_62_1.time_ < var_65_34 + var_65_44 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6045_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6046_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_62_1:InitPlayNodeList()
	end,
	Play1109701015 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 1109701015
		arg_66_1.duration_ = 3.7

		local var_66_0 = {
			zh = 3.7,
			ja = 2.366
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
				arg_66_0:Play1109701016(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			local var_69_0 = "1097ui_story"

			if arg_66_1.actors_[var_69_0] == nil then
				local var_69_1 = Asset.Load("Char/" .. "1097ui_story")

				if not isNil(var_69_1) then
					local var_69_2 = Object.Instantiate(Asset.Load("Char/" .. "1097ui_story"), arg_66_1.stage_.transform)

					var_69_2.name = var_69_0
					var_69_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_66_1.actors_[var_69_0] = var_69_2

					local var_69_3 = var_69_2:GetComponentInChildren(typeof(CharacterEffect))

					var_69_3.enabled = true

					local var_69_4 = GameObjectTools.GetOrAddComponent(var_69_2, typeof(DynamicBoneHelper))

					if var_69_4 then
						var_69_4:EnableDynamicBone(false)
					end

					arg_66_1:ShowWeapon(var_69_3.transform, false)

					arg_66_1.var_[var_69_0 .. "Animator"] = var_69_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_66_1.var_[var_69_0 .. "Animator"].applyRootMotion = true
					arg_66_1.var_[var_69_0 .. "LipSync"] = var_69_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_69_5 = arg_66_1.actors_["1097ui_story"].transform
			local var_69_6 = 0

			if var_69_6 < arg_66_1.time_ and arg_66_1.time_ <= var_69_6 + arg_69_0 then
				arg_66_1.var_.moveOldPos1097ui_story = var_69_5.localPosition
			end

			local var_69_7 = 0.001

			if var_69_6 <= arg_66_1.time_ and arg_66_1.time_ < var_69_6 + var_69_7 then
				local var_69_8 = (arg_66_1.time_ - var_69_6) / var_69_7
				local var_69_9 = Vector3.New(0, -0.54, -6.3)

				var_69_5.localPosition = Vector3.Lerp(arg_66_1.var_.moveOldPos1097ui_story, var_69_9, var_69_8)

				local var_69_10 = manager.ui.mainCamera.transform.position - var_69_5.position

				var_69_5.forward = Vector3.New(var_69_10.x, var_69_10.y, var_69_10.z)

				local var_69_11 = var_69_5.localEulerAngles

				var_69_11.z = 0
				var_69_11.x = 0
				var_69_5.localEulerAngles = var_69_11
			end

			if arg_66_1.time_ >= var_69_6 + var_69_7 and arg_66_1.time_ < var_69_6 + var_69_7 + arg_69_0 then
				var_69_5.localPosition = Vector3.New(0, -0.54, -6.3)

				local var_69_12 = manager.ui.mainCamera.transform.position - var_69_5.position

				var_69_5.forward = Vector3.New(var_69_12.x, var_69_12.y, var_69_12.z)

				local var_69_13 = var_69_5.localEulerAngles

				var_69_13.z = 0
				var_69_13.x = 0
				var_69_5.localEulerAngles = var_69_13
			end

			local var_69_14 = arg_66_1.actors_["1097ui_story"]
			local var_69_15 = 0

			if var_69_15 < arg_66_1.time_ and arg_66_1.time_ <= var_69_15 + arg_69_0 and not isNil(var_69_14) and arg_66_1.var_.characterEffect1097ui_story == nil then
				arg_66_1.var_.characterEffect1097ui_story = var_69_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_69_16 = 0.200000002980232

			if var_69_15 <= arg_66_1.time_ and arg_66_1.time_ < var_69_15 + var_69_16 and not isNil(var_69_14) then
				local var_69_17 = (arg_66_1.time_ - var_69_15) / var_69_16

				if arg_66_1.var_.characterEffect1097ui_story and not isNil(var_69_14) then
					arg_66_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_66_1.time_ >= var_69_15 + var_69_16 and arg_66_1.time_ < var_69_15 + var_69_16 + arg_69_0 and not isNil(var_69_14) and arg_66_1.var_.characterEffect1097ui_story then
				arg_66_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_69_18 = 0

			if var_69_18 < arg_66_1.time_ and arg_66_1.time_ <= var_69_18 + arg_69_0 then
				arg_66_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			local var_69_19 = 0

			if var_69_19 < arg_66_1.time_ and arg_66_1.time_ <= var_69_19 + arg_69_0 then
				arg_66_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_69_20 = arg_66_1.actors_["6045_story"].transform
			local var_69_21 = 0

			if var_69_21 < arg_66_1.time_ and arg_66_1.time_ <= var_69_21 + arg_69_0 then
				arg_66_1.var_.moveOldPos6045_story = var_69_20.localPosition

				local var_69_22 = GameObjectTools.GetOrAddComponent(var_69_20.gameObject, typeof(DynamicBoneHelper))

				if var_69_22 then
					var_69_22:EnableDynamicBone(false)
				end
			end

			local var_69_23 = 0.001

			if var_69_21 <= arg_66_1.time_ and arg_66_1.time_ < var_69_21 + var_69_23 then
				local var_69_24 = (arg_66_1.time_ - var_69_21) / var_69_23
				local var_69_25 = Vector3.New(0, 100, 0)

				var_69_20.localPosition = Vector3.Lerp(arg_66_1.var_.moveOldPos6045_story, var_69_25, var_69_24)

				local var_69_26 = manager.ui.mainCamera.transform.position - var_69_20.position

				var_69_20.forward = Vector3.New(var_69_26.x, var_69_26.y, var_69_26.z)

				local var_69_27 = var_69_20.localEulerAngles

				var_69_27.z = 0
				var_69_27.x = 0
				var_69_20.localEulerAngles = var_69_27
			end

			if arg_66_1.time_ >= var_69_21 + var_69_23 and arg_66_1.time_ < var_69_21 + var_69_23 + arg_69_0 then
				var_69_20.localPosition = Vector3.New(0, 100, 0)

				local var_69_28 = manager.ui.mainCamera.transform.position - var_69_20.position

				var_69_20.forward = Vector3.New(var_69_28.x, var_69_28.y, var_69_28.z)

				local var_69_29 = var_69_20.localEulerAngles

				var_69_29.z = 0
				var_69_29.x = 0
				var_69_20.localEulerAngles = var_69_29

				local var_69_30 = GameObjectTools.GetOrAddComponent(var_69_20.gameObject, typeof(DynamicBoneHelper))

				if var_69_30 then
					var_69_30:EnableDynamicBone(true)
				end
			end

			local var_69_31 = arg_66_1.actors_["6045_story"]
			local var_69_32 = 0

			if var_69_32 < arg_66_1.time_ and arg_66_1.time_ <= var_69_32 + arg_69_0 and not isNil(var_69_31) and arg_66_1.var_.characterEffect6045_story == nil then
				arg_66_1.var_.characterEffect6045_story = var_69_31:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_69_33 = 0.200000002980232

			if var_69_32 <= arg_66_1.time_ and arg_66_1.time_ < var_69_32 + var_69_33 and not isNil(var_69_31) then
				local var_69_34 = (arg_66_1.time_ - var_69_32) / var_69_33

				if arg_66_1.var_.characterEffect6045_story and not isNil(var_69_31) then
					local var_69_35 = Mathf.Lerp(0, 0.5, var_69_34)

					arg_66_1.var_.characterEffect6045_story.fillFlat = true
					arg_66_1.var_.characterEffect6045_story.fillRatio = var_69_35
				end
			end

			if arg_66_1.time_ >= var_69_32 + var_69_33 and arg_66_1.time_ < var_69_32 + var_69_33 + arg_69_0 and not isNil(var_69_31) and arg_66_1.var_.characterEffect6045_story then
				local var_69_36 = 0.5

				arg_66_1.var_.characterEffect6045_story.fillFlat = true
				arg_66_1.var_.characterEffect6045_story.fillRatio = var_69_36
			end

			local var_69_37 = arg_66_1.actors_["6046_story"].transform
			local var_69_38 = 0

			if var_69_38 < arg_66_1.time_ and arg_66_1.time_ <= var_69_38 + arg_69_0 then
				arg_66_1.var_.moveOldPos6046_story = var_69_37.localPosition

				local var_69_39 = GameObjectTools.GetOrAddComponent(var_69_37.gameObject, typeof(DynamicBoneHelper))

				if var_69_39 then
					var_69_39:EnableDynamicBone(false)
				end
			end

			local var_69_40 = 0.001

			if var_69_38 <= arg_66_1.time_ and arg_66_1.time_ < var_69_38 + var_69_40 then
				local var_69_41 = (arg_66_1.time_ - var_69_38) / var_69_40
				local var_69_42 = Vector3.New(0, 100, 0)

				var_69_37.localPosition = Vector3.Lerp(arg_66_1.var_.moveOldPos6046_story, var_69_42, var_69_41)

				local var_69_43 = manager.ui.mainCamera.transform.position - var_69_37.position

				var_69_37.forward = Vector3.New(var_69_43.x, var_69_43.y, var_69_43.z)

				local var_69_44 = var_69_37.localEulerAngles

				var_69_44.z = 0
				var_69_44.x = 0
				var_69_37.localEulerAngles = var_69_44
			end

			if arg_66_1.time_ >= var_69_38 + var_69_40 and arg_66_1.time_ < var_69_38 + var_69_40 + arg_69_0 then
				var_69_37.localPosition = Vector3.New(0, 100, 0)

				local var_69_45 = manager.ui.mainCamera.transform.position - var_69_37.position

				var_69_37.forward = Vector3.New(var_69_45.x, var_69_45.y, var_69_45.z)

				local var_69_46 = var_69_37.localEulerAngles

				var_69_46.z = 0
				var_69_46.x = 0
				var_69_37.localEulerAngles = var_69_46

				local var_69_47 = GameObjectTools.GetOrAddComponent(var_69_37.gameObject, typeof(DynamicBoneHelper))

				if var_69_47 then
					var_69_47:EnableDynamicBone(true)
				end
			end

			local var_69_48 = arg_66_1.actors_["6046_story"]
			local var_69_49 = 0

			if var_69_49 < arg_66_1.time_ and arg_66_1.time_ <= var_69_49 + arg_69_0 and not isNil(var_69_48) and arg_66_1.var_.characterEffect6046_story == nil then
				arg_66_1.var_.characterEffect6046_story = var_69_48:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_69_50 = 0.200000002980232

			if var_69_49 <= arg_66_1.time_ and arg_66_1.time_ < var_69_49 + var_69_50 and not isNil(var_69_48) then
				local var_69_51 = (arg_66_1.time_ - var_69_49) / var_69_50

				if arg_66_1.var_.characterEffect6046_story and not isNil(var_69_48) then
					local var_69_52 = Mathf.Lerp(0, 0.5, var_69_51)

					arg_66_1.var_.characterEffect6046_story.fillFlat = true
					arg_66_1.var_.characterEffect6046_story.fillRatio = var_69_52
				end
			end

			if arg_66_1.time_ >= var_69_49 + var_69_50 and arg_66_1.time_ < var_69_49 + var_69_50 + arg_69_0 and not isNil(var_69_48) and arg_66_1.var_.characterEffect6046_story then
				local var_69_53 = 0.5

				arg_66_1.var_.characterEffect6046_story.fillFlat = true
				arg_66_1.var_.characterEffect6046_story.fillRatio = var_69_53
			end

			local var_69_54 = 0
			local var_69_55 = 0.5

			if var_69_54 < arg_66_1.time_ and arg_66_1.time_ <= var_69_54 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				local var_69_56 = arg_66_1:FormatText(StoryNameCfg[216].name)

				arg_66_1.leftNameTxt_.text = var_69_56

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_57 = arg_66_1:GetWordFromCfg(1109701015)
				local var_69_58 = arg_66_1:FormatText(var_69_57.content)

				arg_66_1.text_.text = var_69_58

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_59 = 20
				local var_69_60 = utf8.len(var_69_58)
				local var_69_61 = var_69_59 <= 0 and var_69_55 or var_69_55 * (var_69_60 / var_69_59)

				if var_69_61 > 0 and var_69_55 < var_69_61 then
					arg_66_1.talkMaxDuration = var_69_61

					if var_69_61 + var_69_54 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_61 + var_69_54
					end
				end

				arg_66_1.text_.text = var_69_58
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701015", "story_v_side_new_1109701.awb") ~= 0 then
					local var_69_62 = manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701015", "story_v_side_new_1109701.awb") / 1000

					if var_69_62 + var_69_54 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_62 + var_69_54
					end

					if var_69_57.prefab_name ~= "" and arg_66_1.actors_[var_69_57.prefab_name] ~= nil then
						local var_69_63 = LuaForUtil.PlayVoiceWithCriLipsync(arg_66_1.actors_[var_69_57.prefab_name].transform, "story_v_side_new_1109701", "1109701015", "story_v_side_new_1109701.awb")

						arg_66_1:RecordAudio("1109701015", var_69_63)
						arg_66_1:RecordAudio("1109701015", var_69_63)
					else
						arg_66_1:AudioAction("play", "voice", "story_v_side_new_1109701", "1109701015", "story_v_side_new_1109701.awb")
					end

					arg_66_1:RecordHistoryTalkVoice("story_v_side_new_1109701", "1109701015", "story_v_side_new_1109701.awb")
				end

				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_64 = math.max(var_69_55, arg_66_1.talkMaxDuration)

			if var_69_54 <= arg_66_1.time_ and arg_66_1.time_ < var_69_54 + var_69_64 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_54) / var_69_64

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_54 + var_69_64 and arg_66_1.time_ < var_69_54 + var_69_64 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6045_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6046_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_66_1:InitPlayNodeList()
	end,
	Play1109701016 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 1109701016
		arg_70_1.duration_ = 5

		SetActive(arg_70_1.tipsGo_, false)

		function arg_70_1.onSingleLineFinish_()
			arg_70_1.onSingleLineUpdate_ = nil
			arg_70_1.onSingleLineFinish_ = nil
			arg_70_1.state_ = "waiting"
		end

		function arg_70_1.playNext_(arg_72_0)
			if arg_72_0 == 1 then
				arg_70_0:Play1109701017(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			local var_73_0 = arg_70_1.actors_["1097ui_story"]
			local var_73_1 = 0

			if var_73_1 < arg_70_1.time_ and arg_70_1.time_ <= var_73_1 + arg_73_0 and not isNil(var_73_0) and arg_70_1.var_.characterEffect1097ui_story == nil then
				arg_70_1.var_.characterEffect1097ui_story = var_73_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_73_2 = 0.200000002980232

			if var_73_1 <= arg_70_1.time_ and arg_70_1.time_ < var_73_1 + var_73_2 and not isNil(var_73_0) then
				local var_73_3 = (arg_70_1.time_ - var_73_1) / var_73_2

				if arg_70_1.var_.characterEffect1097ui_story and not isNil(var_73_0) then
					local var_73_4 = Mathf.Lerp(0, 0.5, var_73_3)

					arg_70_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_70_1.var_.characterEffect1097ui_story.fillRatio = var_73_4
				end
			end

			if arg_70_1.time_ >= var_73_1 + var_73_2 and arg_70_1.time_ < var_73_1 + var_73_2 + arg_73_0 and not isNil(var_73_0) and arg_70_1.var_.characterEffect1097ui_story then
				local var_73_5 = 0.5

				arg_70_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_70_1.var_.characterEffect1097ui_story.fillRatio = var_73_5
			end

			local var_73_6 = arg_70_1.actors_["1097ui_story"].transform
			local var_73_7 = 0

			if var_73_7 < arg_70_1.time_ and arg_70_1.time_ <= var_73_7 + arg_73_0 then
				arg_70_1.var_.moveOldPos1097ui_story = var_73_6.localPosition
			end

			local var_73_8 = 0.001

			if var_73_7 <= arg_70_1.time_ and arg_70_1.time_ < var_73_7 + var_73_8 then
				local var_73_9 = (arg_70_1.time_ - var_73_7) / var_73_8
				local var_73_10 = Vector3.New(0, 100, 0)

				var_73_6.localPosition = Vector3.Lerp(arg_70_1.var_.moveOldPos1097ui_story, var_73_10, var_73_9)

				local var_73_11 = manager.ui.mainCamera.transform.position - var_73_6.position

				var_73_6.forward = Vector3.New(var_73_11.x, var_73_11.y, var_73_11.z)

				local var_73_12 = var_73_6.localEulerAngles

				var_73_12.z = 0
				var_73_12.x = 0
				var_73_6.localEulerAngles = var_73_12
			end

			if arg_70_1.time_ >= var_73_7 + var_73_8 and arg_70_1.time_ < var_73_7 + var_73_8 + arg_73_0 then
				var_73_6.localPosition = Vector3.New(0, 100, 0)

				local var_73_13 = manager.ui.mainCamera.transform.position - var_73_6.position

				var_73_6.forward = Vector3.New(var_73_13.x, var_73_13.y, var_73_13.z)

				local var_73_14 = var_73_6.localEulerAngles

				var_73_14.z = 0
				var_73_14.x = 0
				var_73_6.localEulerAngles = var_73_14
			end

			local var_73_15 = 0
			local var_73_16 = 0.975

			if var_73_15 < arg_70_1.time_ and arg_70_1.time_ <= var_73_15 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, false)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_70_1.iconTrs_.gameObject, false)
				arg_70_1.callingController_:SetSelectedState("normal")

				local var_73_17 = arg_70_1:GetWordFromCfg(1109701016)
				local var_73_18 = arg_70_1:FormatText(var_73_17.content)

				arg_70_1.text_.text = var_73_18

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_19 = 39
				local var_73_20 = utf8.len(var_73_18)
				local var_73_21 = var_73_19 <= 0 and var_73_16 or var_73_16 * (var_73_20 / var_73_19)

				if var_73_21 > 0 and var_73_16 < var_73_21 then
					arg_70_1.talkMaxDuration = var_73_21

					if var_73_21 + var_73_15 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_21 + var_73_15
					end
				end

				arg_70_1.text_.text = var_73_18
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)
				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_22 = math.max(var_73_16, arg_70_1.talkMaxDuration)

			if var_73_15 <= arg_70_1.time_ and arg_70_1.time_ < var_73_15 + var_73_22 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_15) / var_73_22

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_15 + var_73_22 and arg_70_1.time_ < var_73_15 + var_73_22 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_70_1:InitPlayNodeList()
	end,
	Play1109701017 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 1109701017
		arg_74_1.duration_ = 5

		SetActive(arg_74_1.tipsGo_, false)

		function arg_74_1.onSingleLineFinish_()
			arg_74_1.onSingleLineUpdate_ = nil
			arg_74_1.onSingleLineFinish_ = nil
			arg_74_1.state_ = "waiting"
		end

		function arg_74_1.playNext_(arg_76_0)
			if arg_76_0 == 1 then
				arg_74_0:Play1109701018(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			local var_77_0 = 0
			local var_77_1 = 0.925

			if var_77_0 < arg_74_1.time_ and arg_74_1.time_ <= var_77_0 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, false)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_74_1.iconTrs_.gameObject, false)
				arg_74_1.callingController_:SetSelectedState("normal")

				local var_77_2 = arg_74_1:GetWordFromCfg(1109701017)
				local var_77_3 = arg_74_1:FormatText(var_77_2.content)

				arg_74_1.text_.text = var_77_3

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_4 = 37
				local var_77_5 = utf8.len(var_77_3)
				local var_77_6 = var_77_4 <= 0 and var_77_1 or var_77_1 * (var_77_5 / var_77_4)

				if var_77_6 > 0 and var_77_1 < var_77_6 then
					arg_74_1.talkMaxDuration = var_77_6

					if var_77_6 + var_77_0 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_6 + var_77_0
					end
				end

				arg_74_1.text_.text = var_77_3
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)
				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_7 = math.max(var_77_1, arg_74_1.talkMaxDuration)

			if var_77_0 <= arg_74_1.time_ and arg_74_1.time_ < var_77_0 + var_77_7 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_0) / var_77_7

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_0 + var_77_7 and arg_74_1.time_ < var_77_0 + var_77_7 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {}

		arg_74_1:InitPlayNodeList()
	end,
	Play1109701018 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 1109701018
		arg_78_1.duration_ = 5

		SetActive(arg_78_1.tipsGo_, false)

		function arg_78_1.onSingleLineFinish_()
			arg_78_1.onSingleLineUpdate_ = nil
			arg_78_1.onSingleLineFinish_ = nil
			arg_78_1.state_ = "waiting"
		end

		function arg_78_1.playNext_(arg_80_0)
			if arg_80_0 == 1 then
				arg_78_0:Play1109701019(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			local var_81_0 = 0
			local var_81_1 = 0.725

			if var_81_0 < arg_78_1.time_ and arg_78_1.time_ <= var_81_0 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, false)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_78_1.iconTrs_.gameObject, false)
				arg_78_1.callingController_:SetSelectedState("normal")

				local var_81_2 = arg_78_1:GetWordFromCfg(1109701018)
				local var_81_3 = arg_78_1:FormatText(var_81_2.content)

				arg_78_1.text_.text = var_81_3

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_4 = 29
				local var_81_5 = utf8.len(var_81_3)
				local var_81_6 = var_81_4 <= 0 and var_81_1 or var_81_1 * (var_81_5 / var_81_4)

				if var_81_6 > 0 and var_81_1 < var_81_6 then
					arg_78_1.talkMaxDuration = var_81_6

					if var_81_6 + var_81_0 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_6 + var_81_0
					end
				end

				arg_78_1.text_.text = var_81_3
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)
				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_7 = math.max(var_81_1, arg_78_1.talkMaxDuration)

			if var_81_0 <= arg_78_1.time_ and arg_78_1.time_ < var_81_0 + var_81_7 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_0) / var_81_7

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_0 + var_81_7 and arg_78_1.time_ < var_81_0 + var_81_7 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {}

		arg_78_1:InitPlayNodeList()
	end,
	Play1109701019 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 1109701019
		arg_82_1.duration_ = 5

		SetActive(arg_82_1.tipsGo_, false)

		function arg_82_1.onSingleLineFinish_()
			arg_82_1.onSingleLineUpdate_ = nil
			arg_82_1.onSingleLineFinish_ = nil
			arg_82_1.state_ = "waiting"
		end

		function arg_82_1.playNext_(arg_84_0)
			if arg_84_0 == 1 then
				arg_82_0:Play1109701020(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			local var_85_0 = 0
			local var_85_1 = 0.325

			if var_85_0 < arg_82_1.time_ and arg_82_1.time_ <= var_85_0 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				local var_85_2 = arg_82_1:FormatText(StoryNameCfg[7].name)

				arg_82_1.leftNameTxt_.text = var_85_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, true)
				arg_82_1.iconController_:SetSelectedState("hero")

				arg_82_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_82_1.callingController_:SetSelectedState("normal")

				arg_82_1.keyicon_.color = Color.New(1, 1, 1)
				arg_82_1.icon_.color = Color.New(1, 1, 1)

				local var_85_3 = arg_82_1:GetWordFromCfg(1109701019)
				local var_85_4 = arg_82_1:FormatText(var_85_3.content)

				arg_82_1.text_.text = var_85_4

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_5 = 13
				local var_85_6 = utf8.len(var_85_4)
				local var_85_7 = var_85_5 <= 0 and var_85_1 or var_85_1 * (var_85_6 / var_85_5)

				if var_85_7 > 0 and var_85_1 < var_85_7 then
					arg_82_1.talkMaxDuration = var_85_7

					if var_85_7 + var_85_0 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_7 + var_85_0
					end
				end

				arg_82_1.text_.text = var_85_4
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)
				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_8 = math.max(var_85_1, arg_82_1.talkMaxDuration)

			if var_85_0 <= arg_82_1.time_ and arg_82_1.time_ < var_85_0 + var_85_8 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_0) / var_85_8

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_0 + var_85_8 and arg_82_1.time_ < var_85_0 + var_85_8 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {}

		arg_82_1:InitPlayNodeList()
	end,
	Play1109701020 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 1109701020
		arg_86_1.duration_ = 3.73

		local var_86_0 = {
			zh = 3.133,
			ja = 3.733
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
				arg_86_0:Play1109701021(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			local var_89_0 = arg_86_1.actors_["1042ui_story"].transform
			local var_89_1 = 0

			if var_89_1 < arg_86_1.time_ and arg_86_1.time_ <= var_89_1 + arg_89_0 then
				arg_86_1.var_.moveOldPos1042ui_story = var_89_0.localPosition
			end

			local var_89_2 = 0.001

			if var_89_1 <= arg_86_1.time_ and arg_86_1.time_ < var_89_1 + var_89_2 then
				local var_89_3 = (arg_86_1.time_ - var_89_1) / var_89_2
				local var_89_4 = Vector3.New(0, -1.06, -6.2)

				var_89_0.localPosition = Vector3.Lerp(arg_86_1.var_.moveOldPos1042ui_story, var_89_4, var_89_3)

				local var_89_5 = manager.ui.mainCamera.transform.position - var_89_0.position

				var_89_0.forward = Vector3.New(var_89_5.x, var_89_5.y, var_89_5.z)

				local var_89_6 = var_89_0.localEulerAngles

				var_89_6.z = 0
				var_89_6.x = 0
				var_89_0.localEulerAngles = var_89_6
			end

			if arg_86_1.time_ >= var_89_1 + var_89_2 and arg_86_1.time_ < var_89_1 + var_89_2 + arg_89_0 then
				var_89_0.localPosition = Vector3.New(0, -1.06, -6.2)

				local var_89_7 = manager.ui.mainCamera.transform.position - var_89_0.position

				var_89_0.forward = Vector3.New(var_89_7.x, var_89_7.y, var_89_7.z)

				local var_89_8 = var_89_0.localEulerAngles

				var_89_8.z = 0
				var_89_8.x = 0
				var_89_0.localEulerAngles = var_89_8
			end

			local var_89_9 = arg_86_1.actors_["1042ui_story"]
			local var_89_10 = 0

			if var_89_10 < arg_86_1.time_ and arg_86_1.time_ <= var_89_10 + arg_89_0 and not isNil(var_89_9) and arg_86_1.var_.characterEffect1042ui_story == nil then
				arg_86_1.var_.characterEffect1042ui_story = var_89_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_89_11 = 0.200000002980232

			if var_89_10 <= arg_86_1.time_ and arg_86_1.time_ < var_89_10 + var_89_11 and not isNil(var_89_9) then
				local var_89_12 = (arg_86_1.time_ - var_89_10) / var_89_11

				if arg_86_1.var_.characterEffect1042ui_story and not isNil(var_89_9) then
					arg_86_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_86_1.time_ >= var_89_10 + var_89_11 and arg_86_1.time_ < var_89_10 + var_89_11 + arg_89_0 and not isNil(var_89_9) and arg_86_1.var_.characterEffect1042ui_story then
				arg_86_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_89_13 = 0

			if var_89_13 < arg_86_1.time_ and arg_86_1.time_ <= var_89_13 + arg_89_0 then
				arg_86_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action2_1")
			end

			local var_89_14 = 0

			if var_89_14 < arg_86_1.time_ and arg_86_1.time_ <= var_89_14 + arg_89_0 then
				arg_86_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_89_15 = 0
			local var_89_16 = 0.575

			if var_89_15 < arg_86_1.time_ and arg_86_1.time_ <= var_89_15 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, true)

				local var_89_17 = arg_86_1:FormatText(StoryNameCfg[205].name)

				arg_86_1.leftNameTxt_.text = var_89_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_18 = arg_86_1:GetWordFromCfg(1109701020)
				local var_89_19 = arg_86_1:FormatText(var_89_18.content)

				arg_86_1.text_.text = var_89_19

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_20 = 23
				local var_89_21 = utf8.len(var_89_19)
				local var_89_22 = var_89_20 <= 0 and var_89_16 or var_89_16 * (var_89_21 / var_89_20)

				if var_89_22 > 0 and var_89_16 < var_89_22 then
					arg_86_1.talkMaxDuration = var_89_22

					if var_89_22 + var_89_15 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_22 + var_89_15
					end
				end

				arg_86_1.text_.text = var_89_19
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701020", "story_v_side_new_1109701.awb") ~= 0 then
					local var_89_23 = manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701020", "story_v_side_new_1109701.awb") / 1000

					if var_89_23 + var_89_15 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_23 + var_89_15
					end

					if var_89_18.prefab_name ~= "" and arg_86_1.actors_[var_89_18.prefab_name] ~= nil then
						local var_89_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_86_1.actors_[var_89_18.prefab_name].transform, "story_v_side_new_1109701", "1109701020", "story_v_side_new_1109701.awb")

						arg_86_1:RecordAudio("1109701020", var_89_24)
						arg_86_1:RecordAudio("1109701020", var_89_24)
					else
						arg_86_1:AudioAction("play", "voice", "story_v_side_new_1109701", "1109701020", "story_v_side_new_1109701.awb")
					end

					arg_86_1:RecordHistoryTalkVoice("story_v_side_new_1109701", "1109701020", "story_v_side_new_1109701.awb")
				end

				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_25 = math.max(var_89_16, arg_86_1.talkMaxDuration)

			if var_89_15 <= arg_86_1.time_ and arg_86_1.time_ < var_89_15 + var_89_25 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_15) / var_89_25

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_15 + var_89_25 and arg_86_1.time_ < var_89_15 + var_89_25 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_86_1:InitPlayNodeList()
	end,
	Play1109701021 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 1109701021
		arg_90_1.duration_ = 16.4

		local var_90_0 = {
			zh = 11.633,
			ja = 16.4
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
				arg_90_0:Play1109701022(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			local var_93_0 = arg_90_1.actors_["1042ui_story"].transform
			local var_93_1 = 0

			if var_93_1 < arg_90_1.time_ and arg_90_1.time_ <= var_93_1 + arg_93_0 then
				arg_90_1.var_.moveOldPos1042ui_story = var_93_0.localPosition
			end

			local var_93_2 = 0.001

			if var_93_1 <= arg_90_1.time_ and arg_90_1.time_ < var_93_1 + var_93_2 then
				local var_93_3 = (arg_90_1.time_ - var_93_1) / var_93_2
				local var_93_4 = Vector3.New(0, -1.06, -6.2)

				var_93_0.localPosition = Vector3.Lerp(arg_90_1.var_.moveOldPos1042ui_story, var_93_4, var_93_3)

				local var_93_5 = manager.ui.mainCamera.transform.position - var_93_0.position

				var_93_0.forward = Vector3.New(var_93_5.x, var_93_5.y, var_93_5.z)

				local var_93_6 = var_93_0.localEulerAngles

				var_93_6.z = 0
				var_93_6.x = 0
				var_93_0.localEulerAngles = var_93_6
			end

			if arg_90_1.time_ >= var_93_1 + var_93_2 and arg_90_1.time_ < var_93_1 + var_93_2 + arg_93_0 then
				var_93_0.localPosition = Vector3.New(0, -1.06, -6.2)

				local var_93_7 = manager.ui.mainCamera.transform.position - var_93_0.position

				var_93_0.forward = Vector3.New(var_93_7.x, var_93_7.y, var_93_7.z)

				local var_93_8 = var_93_0.localEulerAngles

				var_93_8.z = 0
				var_93_8.x = 0
				var_93_0.localEulerAngles = var_93_8
			end

			local var_93_9 = arg_90_1.actors_["1042ui_story"]
			local var_93_10 = 0

			if var_93_10 < arg_90_1.time_ and arg_90_1.time_ <= var_93_10 + arg_93_0 and not isNil(var_93_9) and arg_90_1.var_.characterEffect1042ui_story == nil then
				arg_90_1.var_.characterEffect1042ui_story = var_93_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_93_11 = 0.200000002980232

			if var_93_10 <= arg_90_1.time_ and arg_90_1.time_ < var_93_10 + var_93_11 and not isNil(var_93_9) then
				local var_93_12 = (arg_90_1.time_ - var_93_10) / var_93_11

				if arg_90_1.var_.characterEffect1042ui_story and not isNil(var_93_9) then
					arg_90_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_90_1.time_ >= var_93_10 + var_93_11 and arg_90_1.time_ < var_93_10 + var_93_11 + arg_93_0 and not isNil(var_93_9) and arg_90_1.var_.characterEffect1042ui_story then
				arg_90_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_93_13 = 0

			if var_93_13 < arg_90_1.time_ and arg_90_1.time_ <= var_93_13 + arg_93_0 then
				arg_90_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042actionlink/1042action426")
			end

			local var_93_14 = 0

			if var_93_14 < arg_90_1.time_ and arg_90_1.time_ <= var_93_14 + arg_93_0 then
				arg_90_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_93_15 = 0
			local var_93_16 = 1.525

			if var_93_15 < arg_90_1.time_ and arg_90_1.time_ <= var_93_15 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				local var_93_17 = arg_90_1:FormatText(StoryNameCfg[205].name)

				arg_90_1.leftNameTxt_.text = var_93_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_18 = arg_90_1:GetWordFromCfg(1109701021)
				local var_93_19 = arg_90_1:FormatText(var_93_18.content)

				arg_90_1.text_.text = var_93_19

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_20 = 61
				local var_93_21 = utf8.len(var_93_19)
				local var_93_22 = var_93_20 <= 0 and var_93_16 or var_93_16 * (var_93_21 / var_93_20)

				if var_93_22 > 0 and var_93_16 < var_93_22 then
					arg_90_1.talkMaxDuration = var_93_22

					if var_93_22 + var_93_15 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_22 + var_93_15
					end
				end

				arg_90_1.text_.text = var_93_19
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701021", "story_v_side_new_1109701.awb") ~= 0 then
					local var_93_23 = manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701021", "story_v_side_new_1109701.awb") / 1000

					if var_93_23 + var_93_15 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_23 + var_93_15
					end

					if var_93_18.prefab_name ~= "" and arg_90_1.actors_[var_93_18.prefab_name] ~= nil then
						local var_93_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_90_1.actors_[var_93_18.prefab_name].transform, "story_v_side_new_1109701", "1109701021", "story_v_side_new_1109701.awb")

						arg_90_1:RecordAudio("1109701021", var_93_24)
						arg_90_1:RecordAudio("1109701021", var_93_24)
					else
						arg_90_1:AudioAction("play", "voice", "story_v_side_new_1109701", "1109701021", "story_v_side_new_1109701.awb")
					end

					arg_90_1:RecordHistoryTalkVoice("story_v_side_new_1109701", "1109701021", "story_v_side_new_1109701.awb")
				end

				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_25 = math.max(var_93_16, arg_90_1.talkMaxDuration)

			if var_93_15 <= arg_90_1.time_ and arg_90_1.time_ < var_93_15 + var_93_25 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_15) / var_93_25

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_15 + var_93_25 and arg_90_1.time_ < var_93_15 + var_93_25 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_90_1:InitPlayNodeList()
	end,
	Play1109701022 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 1109701022
		arg_94_1.duration_ = 5

		SetActive(arg_94_1.tipsGo_, false)

		function arg_94_1.onSingleLineFinish_()
			arg_94_1.onSingleLineUpdate_ = nil
			arg_94_1.onSingleLineFinish_ = nil
			arg_94_1.state_ = "waiting"
		end

		function arg_94_1.playNext_(arg_96_0)
			if arg_96_0 == 1 then
				arg_94_0:Play1109701023(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			local var_97_0 = arg_94_1.actors_["1042ui_story"]
			local var_97_1 = 0

			if var_97_1 < arg_94_1.time_ and arg_94_1.time_ <= var_97_1 + arg_97_0 and not isNil(var_97_0) and arg_94_1.var_.characterEffect1042ui_story == nil then
				arg_94_1.var_.characterEffect1042ui_story = var_97_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_97_2 = 0.200000002980232

			if var_97_1 <= arg_94_1.time_ and arg_94_1.time_ < var_97_1 + var_97_2 and not isNil(var_97_0) then
				local var_97_3 = (arg_94_1.time_ - var_97_1) / var_97_2

				if arg_94_1.var_.characterEffect1042ui_story and not isNil(var_97_0) then
					local var_97_4 = Mathf.Lerp(0, 0.5, var_97_3)

					arg_94_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_94_1.var_.characterEffect1042ui_story.fillRatio = var_97_4
				end
			end

			if arg_94_1.time_ >= var_97_1 + var_97_2 and arg_94_1.time_ < var_97_1 + var_97_2 + arg_97_0 and not isNil(var_97_0) and arg_94_1.var_.characterEffect1042ui_story then
				local var_97_5 = 0.5

				arg_94_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_94_1.var_.characterEffect1042ui_story.fillRatio = var_97_5
			end

			local var_97_6 = 0
			local var_97_7 = 0.1

			if var_97_6 < arg_94_1.time_ and arg_94_1.time_ <= var_97_6 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				local var_97_8 = arg_94_1:FormatText(StoryNameCfg[7].name)

				arg_94_1.leftNameTxt_.text = var_97_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, true)
				arg_94_1.iconController_:SetSelectedState("hero")

				arg_94_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_94_1.callingController_:SetSelectedState("normal")

				arg_94_1.keyicon_.color = Color.New(1, 1, 1)
				arg_94_1.icon_.color = Color.New(1, 1, 1)

				local var_97_9 = arg_94_1:GetWordFromCfg(1109701022)
				local var_97_10 = arg_94_1:FormatText(var_97_9.content)

				arg_94_1.text_.text = var_97_10

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_11 = 4
				local var_97_12 = utf8.len(var_97_10)
				local var_97_13 = var_97_11 <= 0 and var_97_7 or var_97_7 * (var_97_12 / var_97_11)

				if var_97_13 > 0 and var_97_7 < var_97_13 then
					arg_94_1.talkMaxDuration = var_97_13

					if var_97_13 + var_97_6 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_13 + var_97_6
					end
				end

				arg_94_1.text_.text = var_97_10
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)
				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_14 = math.max(var_97_7, arg_94_1.talkMaxDuration)

			if var_97_6 <= arg_94_1.time_ and arg_94_1.time_ < var_97_6 + var_97_14 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_6) / var_97_14

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_6 + var_97_14 and arg_94_1.time_ < var_97_6 + var_97_14 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {}

		arg_94_1:InitPlayNodeList()
	end,
	Play1109701023 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 1109701023
		arg_98_1.duration_ = 5

		SetActive(arg_98_1.tipsGo_, false)

		function arg_98_1.onSingleLineFinish_()
			arg_98_1.onSingleLineUpdate_ = nil
			arg_98_1.onSingleLineFinish_ = nil
			arg_98_1.state_ = "waiting"
		end

		function arg_98_1.playNext_(arg_100_0)
			if arg_100_0 == 1 then
				arg_98_0:Play1109701024(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			local var_101_0 = arg_98_1.actors_["1042ui_story"].transform
			local var_101_1 = 0

			if var_101_1 < arg_98_1.time_ and arg_98_1.time_ <= var_101_1 + arg_101_0 then
				arg_98_1.var_.moveOldPos1042ui_story = var_101_0.localPosition
			end

			local var_101_2 = 0.001

			if var_101_1 <= arg_98_1.time_ and arg_98_1.time_ < var_101_1 + var_101_2 then
				local var_101_3 = (arg_98_1.time_ - var_101_1) / var_101_2
				local var_101_4 = Vector3.New(0, 100, 0)

				var_101_0.localPosition = Vector3.Lerp(arg_98_1.var_.moveOldPos1042ui_story, var_101_4, var_101_3)

				local var_101_5 = manager.ui.mainCamera.transform.position - var_101_0.position

				var_101_0.forward = Vector3.New(var_101_5.x, var_101_5.y, var_101_5.z)

				local var_101_6 = var_101_0.localEulerAngles

				var_101_6.z = 0
				var_101_6.x = 0
				var_101_0.localEulerAngles = var_101_6
			end

			if arg_98_1.time_ >= var_101_1 + var_101_2 and arg_98_1.time_ < var_101_1 + var_101_2 + arg_101_0 then
				var_101_0.localPosition = Vector3.New(0, 100, 0)

				local var_101_7 = manager.ui.mainCamera.transform.position - var_101_0.position

				var_101_0.forward = Vector3.New(var_101_7.x, var_101_7.y, var_101_7.z)

				local var_101_8 = var_101_0.localEulerAngles

				var_101_8.z = 0
				var_101_8.x = 0
				var_101_0.localEulerAngles = var_101_8
			end

			local var_101_9 = arg_98_1.actors_["1042ui_story"]
			local var_101_10 = 0

			if var_101_10 < arg_98_1.time_ and arg_98_1.time_ <= var_101_10 + arg_101_0 and not isNil(var_101_9) and arg_98_1.var_.characterEffect1042ui_story == nil then
				arg_98_1.var_.characterEffect1042ui_story = var_101_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_101_11 = 0.200000002980232

			if var_101_10 <= arg_98_1.time_ and arg_98_1.time_ < var_101_10 + var_101_11 and not isNil(var_101_9) then
				local var_101_12 = (arg_98_1.time_ - var_101_10) / var_101_11

				if arg_98_1.var_.characterEffect1042ui_story and not isNil(var_101_9) then
					local var_101_13 = Mathf.Lerp(0, 0.5, var_101_12)

					arg_98_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_98_1.var_.characterEffect1042ui_story.fillRatio = var_101_13
				end
			end

			if arg_98_1.time_ >= var_101_10 + var_101_11 and arg_98_1.time_ < var_101_10 + var_101_11 + arg_101_0 and not isNil(var_101_9) and arg_98_1.var_.characterEffect1042ui_story then
				local var_101_14 = 0.5

				arg_98_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_98_1.var_.characterEffect1042ui_story.fillRatio = var_101_14
			end

			local var_101_15 = 0
			local var_101_16 = 1.3

			if var_101_15 < arg_98_1.time_ and arg_98_1.time_ <= var_101_15 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, false)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_17 = arg_98_1:GetWordFromCfg(1109701023)
				local var_101_18 = arg_98_1:FormatText(var_101_17.content)

				arg_98_1.text_.text = var_101_18

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_19 = 52
				local var_101_20 = utf8.len(var_101_18)
				local var_101_21 = var_101_19 <= 0 and var_101_16 or var_101_16 * (var_101_20 / var_101_19)

				if var_101_21 > 0 and var_101_16 < var_101_21 then
					arg_98_1.talkMaxDuration = var_101_21

					if var_101_21 + var_101_15 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_21 + var_101_15
					end
				end

				arg_98_1.text_.text = var_101_18
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)
				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_22 = math.max(var_101_16, arg_98_1.talkMaxDuration)

			if var_101_15 <= arg_98_1.time_ and arg_98_1.time_ < var_101_15 + var_101_22 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_15) / var_101_22

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_15 + var_101_22 and arg_98_1.time_ < var_101_15 + var_101_22 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_98_1:InitPlayNodeList()
	end,
	Play1109701024 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 1109701024
		arg_102_1.duration_ = 4.1

		local var_102_0 = {
			zh = 4.1,
			ja = 3.466
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
				arg_102_0:Play1109701025(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			local var_105_0 = arg_102_1.actors_["1097ui_story"].transform
			local var_105_1 = 0

			if var_105_1 < arg_102_1.time_ and arg_102_1.time_ <= var_105_1 + arg_105_0 then
				arg_102_1.var_.moveOldPos1097ui_story = var_105_0.localPosition
			end

			local var_105_2 = 0.001

			if var_105_1 <= arg_102_1.time_ and arg_102_1.time_ < var_105_1 + var_105_2 then
				local var_105_3 = (arg_102_1.time_ - var_105_1) / var_105_2
				local var_105_4 = Vector3.New(0, -0.54, -6.3)

				var_105_0.localPosition = Vector3.Lerp(arg_102_1.var_.moveOldPos1097ui_story, var_105_4, var_105_3)

				local var_105_5 = manager.ui.mainCamera.transform.position - var_105_0.position

				var_105_0.forward = Vector3.New(var_105_5.x, var_105_5.y, var_105_5.z)

				local var_105_6 = var_105_0.localEulerAngles

				var_105_6.z = 0
				var_105_6.x = 0
				var_105_0.localEulerAngles = var_105_6
			end

			if arg_102_1.time_ >= var_105_1 + var_105_2 and arg_102_1.time_ < var_105_1 + var_105_2 + arg_105_0 then
				var_105_0.localPosition = Vector3.New(0, -0.54, -6.3)

				local var_105_7 = manager.ui.mainCamera.transform.position - var_105_0.position

				var_105_0.forward = Vector3.New(var_105_7.x, var_105_7.y, var_105_7.z)

				local var_105_8 = var_105_0.localEulerAngles

				var_105_8.z = 0
				var_105_8.x = 0
				var_105_0.localEulerAngles = var_105_8
			end

			local var_105_9 = arg_102_1.actors_["1097ui_story"]
			local var_105_10 = 0

			if var_105_10 < arg_102_1.time_ and arg_102_1.time_ <= var_105_10 + arg_105_0 and not isNil(var_105_9) and arg_102_1.var_.characterEffect1097ui_story == nil then
				arg_102_1.var_.characterEffect1097ui_story = var_105_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_105_11 = 0.200000002980232

			if var_105_10 <= arg_102_1.time_ and arg_102_1.time_ < var_105_10 + var_105_11 and not isNil(var_105_9) then
				local var_105_12 = (arg_102_1.time_ - var_105_10) / var_105_11

				if arg_102_1.var_.characterEffect1097ui_story and not isNil(var_105_9) then
					arg_102_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_102_1.time_ >= var_105_10 + var_105_11 and arg_102_1.time_ < var_105_10 + var_105_11 + arg_105_0 and not isNil(var_105_9) and arg_102_1.var_.characterEffect1097ui_story then
				arg_102_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_105_13 = 0

			if var_105_13 < arg_102_1.time_ and arg_102_1.time_ <= var_105_13 + arg_105_0 then
				arg_102_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			local var_105_14 = 0

			if var_105_14 < arg_102_1.time_ and arg_102_1.time_ <= var_105_14 + arg_105_0 then
				arg_102_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_105_15 = 0
			local var_105_16 = 0.275

			if var_105_15 < arg_102_1.time_ and arg_102_1.time_ <= var_105_15 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				local var_105_17 = arg_102_1:FormatText(StoryNameCfg[216].name)

				arg_102_1.leftNameTxt_.text = var_105_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_18 = arg_102_1:GetWordFromCfg(1109701024)
				local var_105_19 = arg_102_1:FormatText(var_105_18.content)

				arg_102_1.text_.text = var_105_19

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_20 = 11
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

				if manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701024", "story_v_side_new_1109701.awb") ~= 0 then
					local var_105_23 = manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701024", "story_v_side_new_1109701.awb") / 1000

					if var_105_23 + var_105_15 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_23 + var_105_15
					end

					if var_105_18.prefab_name ~= "" and arg_102_1.actors_[var_105_18.prefab_name] ~= nil then
						local var_105_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_102_1.actors_[var_105_18.prefab_name].transform, "story_v_side_new_1109701", "1109701024", "story_v_side_new_1109701.awb")

						arg_102_1:RecordAudio("1109701024", var_105_24)
						arg_102_1:RecordAudio("1109701024", var_105_24)
					else
						arg_102_1:AudioAction("play", "voice", "story_v_side_new_1109701", "1109701024", "story_v_side_new_1109701.awb")
					end

					arg_102_1:RecordHistoryTalkVoice("story_v_side_new_1109701", "1109701024", "story_v_side_new_1109701.awb")
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
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_102_1:InitPlayNodeList()
	end,
	Play1109701025 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 1109701025
		arg_106_1.duration_ = 5

		SetActive(arg_106_1.tipsGo_, false)

		function arg_106_1.onSingleLineFinish_()
			arg_106_1.onSingleLineUpdate_ = nil
			arg_106_1.onSingleLineFinish_ = nil
			arg_106_1.state_ = "waiting"
		end

		function arg_106_1.playNext_(arg_108_0)
			if arg_108_0 == 1 then
				arg_106_0:Play1109701026(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			local var_109_0 = arg_106_1.actors_["1097ui_story"]
			local var_109_1 = 0

			if var_109_1 < arg_106_1.time_ and arg_106_1.time_ <= var_109_1 + arg_109_0 and not isNil(var_109_0) and arg_106_1.var_.characterEffect1097ui_story == nil then
				arg_106_1.var_.characterEffect1097ui_story = var_109_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_109_2 = 0.200000002980232

			if var_109_1 <= arg_106_1.time_ and arg_106_1.time_ < var_109_1 + var_109_2 and not isNil(var_109_0) then
				local var_109_3 = (arg_106_1.time_ - var_109_1) / var_109_2

				if arg_106_1.var_.characterEffect1097ui_story and not isNil(var_109_0) then
					local var_109_4 = Mathf.Lerp(0, 0.5, var_109_3)

					arg_106_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_106_1.var_.characterEffect1097ui_story.fillRatio = var_109_4
				end
			end

			if arg_106_1.time_ >= var_109_1 + var_109_2 and arg_106_1.time_ < var_109_1 + var_109_2 + arg_109_0 and not isNil(var_109_0) and arg_106_1.var_.characterEffect1097ui_story then
				local var_109_5 = 0.5

				arg_106_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_106_1.var_.characterEffect1097ui_story.fillRatio = var_109_5
			end

			local var_109_6 = 0
			local var_109_7 = 1.225

			if var_109_6 < arg_106_1.time_ and arg_106_1.time_ <= var_109_6 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				local var_109_8 = arg_106_1:FormatText(StoryNameCfg[7].name)

				arg_106_1.leftNameTxt_.text = var_109_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, true)
				arg_106_1.iconController_:SetSelectedState("hero")

				arg_106_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_106_1.callingController_:SetSelectedState("normal")

				arg_106_1.keyicon_.color = Color.New(1, 1, 1)
				arg_106_1.icon_.color = Color.New(1, 1, 1)

				local var_109_9 = arg_106_1:GetWordFromCfg(1109701025)
				local var_109_10 = arg_106_1:FormatText(var_109_9.content)

				arg_106_1.text_.text = var_109_10

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_11 = 49
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
	Play1109701026 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 1109701026
		arg_110_1.duration_ = 5

		SetActive(arg_110_1.tipsGo_, false)

		function arg_110_1.onSingleLineFinish_()
			arg_110_1.onSingleLineUpdate_ = nil
			arg_110_1.onSingleLineFinish_ = nil
			arg_110_1.state_ = "waiting"
		end

		function arg_110_1.playNext_(arg_112_0)
			if arg_112_0 == 1 then
				arg_110_0:Play1109701027(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			local var_113_0 = 0
			local var_113_1 = 0.525

			if var_113_0 < arg_110_1.time_ and arg_110_1.time_ <= var_113_0 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				local var_113_2 = arg_110_1:FormatText(StoryNameCfg[7].name)

				arg_110_1.leftNameTxt_.text = var_113_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, true)
				arg_110_1.iconController_:SetSelectedState("hero")

				arg_110_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_110_1.callingController_:SetSelectedState("normal")

				arg_110_1.keyicon_.color = Color.New(1, 1, 1)
				arg_110_1.icon_.color = Color.New(1, 1, 1)

				local var_113_3 = arg_110_1:GetWordFromCfg(1109701026)
				local var_113_4 = arg_110_1:FormatText(var_113_3.content)

				arg_110_1.text_.text = var_113_4

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_5 = 21
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
				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_8 = math.max(var_113_1, arg_110_1.talkMaxDuration)

			if var_113_0 <= arg_110_1.time_ and arg_110_1.time_ < var_113_0 + var_113_8 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_0) / var_113_8

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_0 + var_113_8 and arg_110_1.time_ < var_113_0 + var_113_8 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {}

		arg_110_1:InitPlayNodeList()
	end,
	Play1109701027 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 1109701027
		arg_114_1.duration_ = 9.87

		local var_114_0 = {
			zh = 9.866,
			ja = 8.233
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
				arg_114_0:Play1109701028(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			local var_117_0 = arg_114_1.actors_["1097ui_story"].transform
			local var_117_1 = 0

			if var_117_1 < arg_114_1.time_ and arg_114_1.time_ <= var_117_1 + arg_117_0 then
				arg_114_1.var_.moveOldPos1097ui_story = var_117_0.localPosition
			end

			local var_117_2 = 0.001

			if var_117_1 <= arg_114_1.time_ and arg_114_1.time_ < var_117_1 + var_117_2 then
				local var_117_3 = (arg_114_1.time_ - var_117_1) / var_117_2
				local var_117_4 = Vector3.New(0, -0.54, -6.3)

				var_117_0.localPosition = Vector3.Lerp(arg_114_1.var_.moveOldPos1097ui_story, var_117_4, var_117_3)

				local var_117_5 = manager.ui.mainCamera.transform.position - var_117_0.position

				var_117_0.forward = Vector3.New(var_117_5.x, var_117_5.y, var_117_5.z)

				local var_117_6 = var_117_0.localEulerAngles

				var_117_6.z = 0
				var_117_6.x = 0
				var_117_0.localEulerAngles = var_117_6
			end

			if arg_114_1.time_ >= var_117_1 + var_117_2 and arg_114_1.time_ < var_117_1 + var_117_2 + arg_117_0 then
				var_117_0.localPosition = Vector3.New(0, -0.54, -6.3)

				local var_117_7 = manager.ui.mainCamera.transform.position - var_117_0.position

				var_117_0.forward = Vector3.New(var_117_7.x, var_117_7.y, var_117_7.z)

				local var_117_8 = var_117_0.localEulerAngles

				var_117_8.z = 0
				var_117_8.x = 0
				var_117_0.localEulerAngles = var_117_8
			end

			local var_117_9 = arg_114_1.actors_["1097ui_story"]
			local var_117_10 = 0

			if var_117_10 < arg_114_1.time_ and arg_114_1.time_ <= var_117_10 + arg_117_0 and not isNil(var_117_9) and arg_114_1.var_.characterEffect1097ui_story == nil then
				arg_114_1.var_.characterEffect1097ui_story = var_117_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_117_11 = 0.200000002980232

			if var_117_10 <= arg_114_1.time_ and arg_114_1.time_ < var_117_10 + var_117_11 and not isNil(var_117_9) then
				local var_117_12 = (arg_114_1.time_ - var_117_10) / var_117_11

				if arg_114_1.var_.characterEffect1097ui_story and not isNil(var_117_9) then
					arg_114_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_114_1.time_ >= var_117_10 + var_117_11 and arg_114_1.time_ < var_117_10 + var_117_11 + arg_117_0 and not isNil(var_117_9) and arg_114_1.var_.characterEffect1097ui_story then
				arg_114_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_117_13 = 0

			if var_117_13 < arg_114_1.time_ and arg_114_1.time_ <= var_117_13 + arg_117_0 then
				arg_114_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action7_1")
			end

			local var_117_14 = 0

			if var_117_14 < arg_114_1.time_ and arg_114_1.time_ <= var_117_14 + arg_117_0 then
				arg_114_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_117_15 = 0
			local var_117_16 = 0.675

			if var_117_15 < arg_114_1.time_ and arg_114_1.time_ <= var_117_15 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, true)

				local var_117_17 = arg_114_1:FormatText(StoryNameCfg[216].name)

				arg_114_1.leftNameTxt_.text = var_117_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_114_1.leftNameTxt_.transform)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1.leftNameTxt_.text)
				SetActive(arg_114_1.iconTrs_.gameObject, false)
				arg_114_1.callingController_:SetSelectedState("normal")

				local var_117_18 = arg_114_1:GetWordFromCfg(1109701027)
				local var_117_19 = arg_114_1:FormatText(var_117_18.content)

				arg_114_1.text_.text = var_117_19

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_20 = 27
				local var_117_21 = utf8.len(var_117_19)
				local var_117_22 = var_117_20 <= 0 and var_117_16 or var_117_16 * (var_117_21 / var_117_20)

				if var_117_22 > 0 and var_117_16 < var_117_22 then
					arg_114_1.talkMaxDuration = var_117_22

					if var_117_22 + var_117_15 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_22 + var_117_15
					end
				end

				arg_114_1.text_.text = var_117_19
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701027", "story_v_side_new_1109701.awb") ~= 0 then
					local var_117_23 = manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701027", "story_v_side_new_1109701.awb") / 1000

					if var_117_23 + var_117_15 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_23 + var_117_15
					end

					if var_117_18.prefab_name ~= "" and arg_114_1.actors_[var_117_18.prefab_name] ~= nil then
						local var_117_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_114_1.actors_[var_117_18.prefab_name].transform, "story_v_side_new_1109701", "1109701027", "story_v_side_new_1109701.awb")

						arg_114_1:RecordAudio("1109701027", var_117_24)
						arg_114_1:RecordAudio("1109701027", var_117_24)
					else
						arg_114_1:AudioAction("play", "voice", "story_v_side_new_1109701", "1109701027", "story_v_side_new_1109701.awb")
					end

					arg_114_1:RecordHistoryTalkVoice("story_v_side_new_1109701", "1109701027", "story_v_side_new_1109701.awb")
				end

				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_25 = math.max(var_117_16, arg_114_1.talkMaxDuration)

			if var_117_15 <= arg_114_1.time_ and arg_114_1.time_ < var_117_15 + var_117_25 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - var_117_15) / var_117_25

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= var_117_15 + var_117_25 and arg_114_1.time_ < var_117_15 + var_117_25 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_114_1:InitPlayNodeList()
	end,
	Play1109701028 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 1109701028
		arg_118_1.duration_ = 5

		SetActive(arg_118_1.tipsGo_, false)

		function arg_118_1.onSingleLineFinish_()
			arg_118_1.onSingleLineUpdate_ = nil
			arg_118_1.onSingleLineFinish_ = nil
			arg_118_1.state_ = "waiting"
		end

		function arg_118_1.playNext_(arg_120_0)
			if arg_120_0 == 1 then
				arg_118_0:Play1109701029(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			local var_121_0 = arg_118_1.actors_["1097ui_story"]
			local var_121_1 = 0

			if var_121_1 < arg_118_1.time_ and arg_118_1.time_ <= var_121_1 + arg_121_0 and not isNil(var_121_0) and arg_118_1.var_.characterEffect1097ui_story == nil then
				arg_118_1.var_.characterEffect1097ui_story = var_121_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_121_2 = 0.200000002980232

			if var_121_1 <= arg_118_1.time_ and arg_118_1.time_ < var_121_1 + var_121_2 and not isNil(var_121_0) then
				local var_121_3 = (arg_118_1.time_ - var_121_1) / var_121_2

				if arg_118_1.var_.characterEffect1097ui_story and not isNil(var_121_0) then
					local var_121_4 = Mathf.Lerp(0, 0.5, var_121_3)

					arg_118_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_118_1.var_.characterEffect1097ui_story.fillRatio = var_121_4
				end
			end

			if arg_118_1.time_ >= var_121_1 + var_121_2 and arg_118_1.time_ < var_121_1 + var_121_2 + arg_121_0 and not isNil(var_121_0) and arg_118_1.var_.characterEffect1097ui_story then
				local var_121_5 = 0.5

				arg_118_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_118_1.var_.characterEffect1097ui_story.fillRatio = var_121_5
			end

			local var_121_6 = 0
			local var_121_7 = 0.4

			if var_121_6 < arg_118_1.time_ and arg_118_1.time_ <= var_121_6 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, true)

				local var_121_8 = arg_118_1:FormatText(StoryNameCfg[7].name)

				arg_118_1.leftNameTxt_.text = var_121_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_118_1.leftNameTxt_.transform)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1.leftNameTxt_.text)
				SetActive(arg_118_1.iconTrs_.gameObject, true)
				arg_118_1.iconController_:SetSelectedState("hero")

				arg_118_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_118_1.callingController_:SetSelectedState("normal")

				arg_118_1.keyicon_.color = Color.New(1, 1, 1)
				arg_118_1.icon_.color = Color.New(1, 1, 1)

				local var_121_9 = arg_118_1:GetWordFromCfg(1109701028)
				local var_121_10 = arg_118_1:FormatText(var_121_9.content)

				arg_118_1.text_.text = var_121_10

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_11 = 16
				local var_121_12 = utf8.len(var_121_10)
				local var_121_13 = var_121_11 <= 0 and var_121_7 or var_121_7 * (var_121_12 / var_121_11)

				if var_121_13 > 0 and var_121_7 < var_121_13 then
					arg_118_1.talkMaxDuration = var_121_13

					if var_121_13 + var_121_6 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_13 + var_121_6
					end
				end

				arg_118_1.text_.text = var_121_10
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)
				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_14 = math.max(var_121_7, arg_118_1.talkMaxDuration)

			if var_121_6 <= arg_118_1.time_ and arg_118_1.time_ < var_121_6 + var_121_14 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - var_121_6) / var_121_14

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= var_121_6 + var_121_14 and arg_118_1.time_ < var_121_6 + var_121_14 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {}

		arg_118_1:InitPlayNodeList()
	end,
	Play1109701029 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 1109701029
		arg_122_1.duration_ = 5

		SetActive(arg_122_1.tipsGo_, false)

		function arg_122_1.onSingleLineFinish_()
			arg_122_1.onSingleLineUpdate_ = nil
			arg_122_1.onSingleLineFinish_ = nil
			arg_122_1.state_ = "waiting"
		end

		function arg_122_1.playNext_(arg_124_0)
			if arg_124_0 == 1 then
				arg_122_0:Play1109701030(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			local var_125_0 = 0
			local var_125_1 = 0.775

			if var_125_0 < arg_122_1.time_ and arg_122_1.time_ <= var_125_0 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, false)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_122_1.iconTrs_.gameObject, false)
				arg_122_1.callingController_:SetSelectedState("normal")

				local var_125_2 = arg_122_1:GetWordFromCfg(1109701029)
				local var_125_3 = arg_122_1:FormatText(var_125_2.content)

				arg_122_1.text_.text = var_125_3

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_4 = 31
				local var_125_5 = utf8.len(var_125_3)
				local var_125_6 = var_125_4 <= 0 and var_125_1 or var_125_1 * (var_125_5 / var_125_4)

				if var_125_6 > 0 and var_125_1 < var_125_6 then
					arg_122_1.talkMaxDuration = var_125_6

					if var_125_6 + var_125_0 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_6 + var_125_0
					end
				end

				arg_122_1.text_.text = var_125_3
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)
				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_7 = math.max(var_125_1, arg_122_1.talkMaxDuration)

			if var_125_0 <= arg_122_1.time_ and arg_122_1.time_ < var_125_0 + var_125_7 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_0) / var_125_7

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_0 + var_125_7 and arg_122_1.time_ < var_125_0 + var_125_7 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {}

		arg_122_1:InitPlayNodeList()
	end,
	Play1109701030 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 1109701030
		arg_126_1.duration_ = 4.97

		local var_126_0 = {
			zh = 2.133,
			ja = 4.966
		}
		local var_126_1 = manager.audio:GetLocalizationFlag()

		if var_126_0[var_126_1] ~= nil then
			arg_126_1.duration_ = var_126_0[var_126_1]
		end

		SetActive(arg_126_1.tipsGo_, false)

		function arg_126_1.onSingleLineFinish_()
			arg_126_1.onSingleLineUpdate_ = nil
			arg_126_1.onSingleLineFinish_ = nil
			arg_126_1.state_ = "waiting"
		end

		function arg_126_1.playNext_(arg_128_0)
			if arg_128_0 == 1 then
				arg_126_0:Play1109701031(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			local var_129_0 = arg_126_1.actors_["1097ui_story"].transform
			local var_129_1 = 0

			if var_129_1 < arg_126_1.time_ and arg_126_1.time_ <= var_129_1 + arg_129_0 then
				arg_126_1.var_.moveOldPos1097ui_story = var_129_0.localPosition
			end

			local var_129_2 = 0.001

			if var_129_1 <= arg_126_1.time_ and arg_126_1.time_ < var_129_1 + var_129_2 then
				local var_129_3 = (arg_126_1.time_ - var_129_1) / var_129_2
				local var_129_4 = Vector3.New(0, -0.54, -6.3)

				var_129_0.localPosition = Vector3.Lerp(arg_126_1.var_.moveOldPos1097ui_story, var_129_4, var_129_3)

				local var_129_5 = manager.ui.mainCamera.transform.position - var_129_0.position

				var_129_0.forward = Vector3.New(var_129_5.x, var_129_5.y, var_129_5.z)

				local var_129_6 = var_129_0.localEulerAngles

				var_129_6.z = 0
				var_129_6.x = 0
				var_129_0.localEulerAngles = var_129_6
			end

			if arg_126_1.time_ >= var_129_1 + var_129_2 and arg_126_1.time_ < var_129_1 + var_129_2 + arg_129_0 then
				var_129_0.localPosition = Vector3.New(0, -0.54, -6.3)

				local var_129_7 = manager.ui.mainCamera.transform.position - var_129_0.position

				var_129_0.forward = Vector3.New(var_129_7.x, var_129_7.y, var_129_7.z)

				local var_129_8 = var_129_0.localEulerAngles

				var_129_8.z = 0
				var_129_8.x = 0
				var_129_0.localEulerAngles = var_129_8
			end

			local var_129_9 = arg_126_1.actors_["1097ui_story"]
			local var_129_10 = 0

			if var_129_10 < arg_126_1.time_ and arg_126_1.time_ <= var_129_10 + arg_129_0 and not isNil(var_129_9) and arg_126_1.var_.characterEffect1097ui_story == nil then
				arg_126_1.var_.characterEffect1097ui_story = var_129_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_129_11 = 0.200000002980232

			if var_129_10 <= arg_126_1.time_ and arg_126_1.time_ < var_129_10 + var_129_11 and not isNil(var_129_9) then
				local var_129_12 = (arg_126_1.time_ - var_129_10) / var_129_11

				if arg_126_1.var_.characterEffect1097ui_story and not isNil(var_129_9) then
					arg_126_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_126_1.time_ >= var_129_10 + var_129_11 and arg_126_1.time_ < var_129_10 + var_129_11 + arg_129_0 and not isNil(var_129_9) and arg_126_1.var_.characterEffect1097ui_story then
				arg_126_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_129_13 = 0

			if var_129_13 < arg_126_1.time_ and arg_126_1.time_ <= var_129_13 + arg_129_0 then
				arg_126_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action7_2")
			end

			local var_129_14 = 0

			if var_129_14 < arg_126_1.time_ and arg_126_1.time_ <= var_129_14 + arg_129_0 then
				arg_126_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_129_15 = 0
			local var_129_16 = 0.125

			if var_129_15 < arg_126_1.time_ and arg_126_1.time_ <= var_129_15 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, true)

				local var_129_17 = arg_126_1:FormatText(StoryNameCfg[216].name)

				arg_126_1.leftNameTxt_.text = var_129_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_126_1.leftNameTxt_.transform)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1.leftNameTxt_.text)
				SetActive(arg_126_1.iconTrs_.gameObject, false)
				arg_126_1.callingController_:SetSelectedState("normal")

				local var_129_18 = arg_126_1:GetWordFromCfg(1109701030)
				local var_129_19 = arg_126_1:FormatText(var_129_18.content)

				arg_126_1.text_.text = var_129_19

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_20 = 5
				local var_129_21 = utf8.len(var_129_19)
				local var_129_22 = var_129_20 <= 0 and var_129_16 or var_129_16 * (var_129_21 / var_129_20)

				if var_129_22 > 0 and var_129_16 < var_129_22 then
					arg_126_1.talkMaxDuration = var_129_22

					if var_129_22 + var_129_15 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_22 + var_129_15
					end
				end

				arg_126_1.text_.text = var_129_19
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701030", "story_v_side_new_1109701.awb") ~= 0 then
					local var_129_23 = manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701030", "story_v_side_new_1109701.awb") / 1000

					if var_129_23 + var_129_15 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_23 + var_129_15
					end

					if var_129_18.prefab_name ~= "" and arg_126_1.actors_[var_129_18.prefab_name] ~= nil then
						local var_129_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_126_1.actors_[var_129_18.prefab_name].transform, "story_v_side_new_1109701", "1109701030", "story_v_side_new_1109701.awb")

						arg_126_1:RecordAudio("1109701030", var_129_24)
						arg_126_1:RecordAudio("1109701030", var_129_24)
					else
						arg_126_1:AudioAction("play", "voice", "story_v_side_new_1109701", "1109701030", "story_v_side_new_1109701.awb")
					end

					arg_126_1:RecordHistoryTalkVoice("story_v_side_new_1109701", "1109701030", "story_v_side_new_1109701.awb")
				end

				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_25 = math.max(var_129_16, arg_126_1.talkMaxDuration)

			if var_129_15 <= arg_126_1.time_ and arg_126_1.time_ < var_129_15 + var_129_25 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - var_129_15) / var_129_25

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= var_129_15 + var_129_25 and arg_126_1.time_ < var_129_15 + var_129_25 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_126_1:InitPlayNodeList()
	end,
	Play1109701031 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 1109701031
		arg_130_1.duration_ = 6.43

		local var_130_0 = {
			zh = 5.2,
			ja = 6.433
		}
		local var_130_1 = manager.audio:GetLocalizationFlag()

		if var_130_0[var_130_1] ~= nil then
			arg_130_1.duration_ = var_130_0[var_130_1]
		end

		SetActive(arg_130_1.tipsGo_, false)

		function arg_130_1.onSingleLineFinish_()
			arg_130_1.onSingleLineUpdate_ = nil
			arg_130_1.onSingleLineFinish_ = nil
			arg_130_1.state_ = "waiting"
		end

		function arg_130_1.playNext_(arg_132_0)
			if arg_132_0 == 1 then
				arg_130_0:Play1109701032(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			local var_133_0 = 0

			if var_133_0 < arg_130_1.time_ and arg_130_1.time_ <= var_133_0 + arg_133_0 then
				arg_130_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_133_1 = 0
			local var_133_2 = 0.4

			if var_133_1 < arg_130_1.time_ and arg_130_1.time_ <= var_133_1 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, true)

				local var_133_3 = arg_130_1:FormatText(StoryNameCfg[216].name)

				arg_130_1.leftNameTxt_.text = var_133_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_130_1.leftNameTxt_.transform)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1.leftNameTxt_.text)
				SetActive(arg_130_1.iconTrs_.gameObject, false)
				arg_130_1.callingController_:SetSelectedState("normal")

				local var_133_4 = arg_130_1:GetWordFromCfg(1109701031)
				local var_133_5 = arg_130_1:FormatText(var_133_4.content)

				arg_130_1.text_.text = var_133_5

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_6 = 16
				local var_133_7 = utf8.len(var_133_5)
				local var_133_8 = var_133_6 <= 0 and var_133_2 or var_133_2 * (var_133_7 / var_133_6)

				if var_133_8 > 0 and var_133_2 < var_133_8 then
					arg_130_1.talkMaxDuration = var_133_8

					if var_133_8 + var_133_1 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_8 + var_133_1
					end
				end

				arg_130_1.text_.text = var_133_5
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701031", "story_v_side_new_1109701.awb") ~= 0 then
					local var_133_9 = manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701031", "story_v_side_new_1109701.awb") / 1000

					if var_133_9 + var_133_1 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_9 + var_133_1
					end

					if var_133_4.prefab_name ~= "" and arg_130_1.actors_[var_133_4.prefab_name] ~= nil then
						local var_133_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_130_1.actors_[var_133_4.prefab_name].transform, "story_v_side_new_1109701", "1109701031", "story_v_side_new_1109701.awb")

						arg_130_1:RecordAudio("1109701031", var_133_10)
						arg_130_1:RecordAudio("1109701031", var_133_10)
					else
						arg_130_1:AudioAction("play", "voice", "story_v_side_new_1109701", "1109701031", "story_v_side_new_1109701.awb")
					end

					arg_130_1:RecordHistoryTalkVoice("story_v_side_new_1109701", "1109701031", "story_v_side_new_1109701.awb")
				end

				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_11 = math.max(var_133_2, arg_130_1.talkMaxDuration)

			if var_133_1 <= arg_130_1.time_ and arg_130_1.time_ < var_133_1 + var_133_11 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - var_133_1) / var_133_11

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= var_133_1 + var_133_11 and arg_130_1.time_ < var_133_1 + var_133_11 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {}

		arg_130_1:InitPlayNodeList()
	end,
	Play1109701032 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 1109701032
		arg_134_1.duration_ = 5

		SetActive(arg_134_1.tipsGo_, false)

		function arg_134_1.onSingleLineFinish_()
			arg_134_1.onSingleLineUpdate_ = nil
			arg_134_1.onSingleLineFinish_ = nil
			arg_134_1.state_ = "waiting"
		end

		function arg_134_1.playNext_(arg_136_0)
			if arg_136_0 == 1 then
				arg_134_0:Play1109701033(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			local var_137_0 = arg_134_1.actors_["1097ui_story"]
			local var_137_1 = 0

			if var_137_1 < arg_134_1.time_ and arg_134_1.time_ <= var_137_1 + arg_137_0 and not isNil(var_137_0) and arg_134_1.var_.characterEffect1097ui_story == nil then
				arg_134_1.var_.characterEffect1097ui_story = var_137_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_137_2 = 0.200000002980232

			if var_137_1 <= arg_134_1.time_ and arg_134_1.time_ < var_137_1 + var_137_2 and not isNil(var_137_0) then
				local var_137_3 = (arg_134_1.time_ - var_137_1) / var_137_2

				if arg_134_1.var_.characterEffect1097ui_story and not isNil(var_137_0) then
					local var_137_4 = Mathf.Lerp(0, 0.5, var_137_3)

					arg_134_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_134_1.var_.characterEffect1097ui_story.fillRatio = var_137_4
				end
			end

			if arg_134_1.time_ >= var_137_1 + var_137_2 and arg_134_1.time_ < var_137_1 + var_137_2 + arg_137_0 and not isNil(var_137_0) and arg_134_1.var_.characterEffect1097ui_story then
				local var_137_5 = 0.5

				arg_134_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_134_1.var_.characterEffect1097ui_story.fillRatio = var_137_5
			end

			local var_137_6 = 0
			local var_137_7 = 0.05

			if var_137_6 < arg_134_1.time_ and arg_134_1.time_ <= var_137_6 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, true)

				local var_137_8 = arg_134_1:FormatText(StoryNameCfg[7].name)

				arg_134_1.leftNameTxt_.text = var_137_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_134_1.leftNameTxt_.transform)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1.leftNameTxt_.text)
				SetActive(arg_134_1.iconTrs_.gameObject, true)
				arg_134_1.iconController_:SetSelectedState("hero")

				arg_134_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_134_1.callingController_:SetSelectedState("normal")

				arg_134_1.keyicon_.color = Color.New(1, 1, 1)
				arg_134_1.icon_.color = Color.New(1, 1, 1)

				local var_137_9 = arg_134_1:GetWordFromCfg(1109701032)
				local var_137_10 = arg_134_1:FormatText(var_137_9.content)

				arg_134_1.text_.text = var_137_10

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_11 = 2
				local var_137_12 = utf8.len(var_137_10)
				local var_137_13 = var_137_11 <= 0 and var_137_7 or var_137_7 * (var_137_12 / var_137_11)

				if var_137_13 > 0 and var_137_7 < var_137_13 then
					arg_134_1.talkMaxDuration = var_137_13

					if var_137_13 + var_137_6 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_13 + var_137_6
					end
				end

				arg_134_1.text_.text = var_137_10
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)
				arg_134_1:RecordContent(arg_134_1.text_.text)
			end

			local var_137_14 = math.max(var_137_7, arg_134_1.talkMaxDuration)

			if var_137_6 <= arg_134_1.time_ and arg_134_1.time_ < var_137_6 + var_137_14 then
				arg_134_1.typewritter.percent = (arg_134_1.time_ - var_137_6) / var_137_14

				arg_134_1.typewritter:SetDirty()
			end

			if arg_134_1.time_ >= var_137_6 + var_137_14 and arg_134_1.time_ < var_137_6 + var_137_14 + arg_137_0 then
				arg_134_1.typewritter.percent = 1

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(true)
			end
		end

		arg_134_1.nodeConfigList_ = {}

		arg_134_1:InitPlayNodeList()
	end,
	Play1109701033 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 1109701033
		arg_138_1.duration_ = 9.7

		local var_138_0 = {
			zh = 9.7,
			ja = 7.233
		}
		local var_138_1 = manager.audio:GetLocalizationFlag()

		if var_138_0[var_138_1] ~= nil then
			arg_138_1.duration_ = var_138_0[var_138_1]
		end

		SetActive(arg_138_1.tipsGo_, false)

		function arg_138_1.onSingleLineFinish_()
			arg_138_1.onSingleLineUpdate_ = nil
			arg_138_1.onSingleLineFinish_ = nil
			arg_138_1.state_ = "waiting"
		end

		function arg_138_1.playNext_(arg_140_0)
			if arg_140_0 == 1 then
				arg_138_0:Play1109701034(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			local var_141_0 = arg_138_1.actors_["1097ui_story"].transform
			local var_141_1 = 0

			if var_141_1 < arg_138_1.time_ and arg_138_1.time_ <= var_141_1 + arg_141_0 then
				arg_138_1.var_.moveOldPos1097ui_story = var_141_0.localPosition
			end

			local var_141_2 = 0.001

			if var_141_1 <= arg_138_1.time_ and arg_138_1.time_ < var_141_1 + var_141_2 then
				local var_141_3 = (arg_138_1.time_ - var_141_1) / var_141_2
				local var_141_4 = Vector3.New(0, 100, 0)

				var_141_0.localPosition = Vector3.Lerp(arg_138_1.var_.moveOldPos1097ui_story, var_141_4, var_141_3)

				local var_141_5 = manager.ui.mainCamera.transform.position - var_141_0.position

				var_141_0.forward = Vector3.New(var_141_5.x, var_141_5.y, var_141_5.z)

				local var_141_6 = var_141_0.localEulerAngles

				var_141_6.z = 0
				var_141_6.x = 0
				var_141_0.localEulerAngles = var_141_6
			end

			if arg_138_1.time_ >= var_141_1 + var_141_2 and arg_138_1.time_ < var_141_1 + var_141_2 + arg_141_0 then
				var_141_0.localPosition = Vector3.New(0, 100, 0)

				local var_141_7 = manager.ui.mainCamera.transform.position - var_141_0.position

				var_141_0.forward = Vector3.New(var_141_7.x, var_141_7.y, var_141_7.z)

				local var_141_8 = var_141_0.localEulerAngles

				var_141_8.z = 0
				var_141_8.x = 0
				var_141_0.localEulerAngles = var_141_8
			end

			local var_141_9 = arg_138_1.actors_["1097ui_story"]
			local var_141_10 = 0

			if var_141_10 < arg_138_1.time_ and arg_138_1.time_ <= var_141_10 + arg_141_0 and not isNil(var_141_9) and arg_138_1.var_.characterEffect1097ui_story == nil then
				arg_138_1.var_.characterEffect1097ui_story = var_141_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_141_11 = 0.200000002980232

			if var_141_10 <= arg_138_1.time_ and arg_138_1.time_ < var_141_10 + var_141_11 and not isNil(var_141_9) then
				local var_141_12 = (arg_138_1.time_ - var_141_10) / var_141_11

				if arg_138_1.var_.characterEffect1097ui_story and not isNil(var_141_9) then
					local var_141_13 = Mathf.Lerp(0, 0.5, var_141_12)

					arg_138_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_138_1.var_.characterEffect1097ui_story.fillRatio = var_141_13
				end
			end

			if arg_138_1.time_ >= var_141_10 + var_141_11 and arg_138_1.time_ < var_141_10 + var_141_11 + arg_141_0 and not isNil(var_141_9) and arg_138_1.var_.characterEffect1097ui_story then
				local var_141_14 = 0.5

				arg_138_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_138_1.var_.characterEffect1097ui_story.fillRatio = var_141_14
			end

			local var_141_15 = arg_138_1.actors_["6045_story"].transform
			local var_141_16 = 0

			if var_141_16 < arg_138_1.time_ and arg_138_1.time_ <= var_141_16 + arg_141_0 then
				arg_138_1.var_.moveOldPos6045_story = var_141_15.localPosition

				local var_141_17 = GameObjectTools.GetOrAddComponent(var_141_15.gameObject, typeof(DynamicBoneHelper))

				if var_141_17 then
					var_141_17:EnableDynamicBone(false)
				end
			end

			local var_141_18 = 0.001

			if var_141_16 <= arg_138_1.time_ and arg_138_1.time_ < var_141_16 + var_141_18 then
				local var_141_19 = (arg_138_1.time_ - var_141_16) / var_141_18
				local var_141_20 = Vector3.New(-0.7, -0.5, -6.3)

				var_141_15.localPosition = Vector3.Lerp(arg_138_1.var_.moveOldPos6045_story, var_141_20, var_141_19)

				local var_141_21 = manager.ui.mainCamera.transform.position - var_141_15.position

				var_141_15.forward = Vector3.New(var_141_21.x, var_141_21.y, var_141_21.z)

				local var_141_22 = var_141_15.localEulerAngles

				var_141_22.z = 0
				var_141_22.x = 0
				var_141_15.localEulerAngles = var_141_22
			end

			if arg_138_1.time_ >= var_141_16 + var_141_18 and arg_138_1.time_ < var_141_16 + var_141_18 + arg_141_0 then
				var_141_15.localPosition = Vector3.New(-0.7, -0.5, -6.3)

				local var_141_23 = manager.ui.mainCamera.transform.position - var_141_15.position

				var_141_15.forward = Vector3.New(var_141_23.x, var_141_23.y, var_141_23.z)

				local var_141_24 = var_141_15.localEulerAngles

				var_141_24.z = 0
				var_141_24.x = 0
				var_141_15.localEulerAngles = var_141_24

				local var_141_25 = GameObjectTools.GetOrAddComponent(var_141_15.gameObject, typeof(DynamicBoneHelper))

				if var_141_25 then
					var_141_25:EnableDynamicBone(true)
				end
			end

			local var_141_26 = arg_138_1.actors_["6045_story"]
			local var_141_27 = 0

			if var_141_27 < arg_138_1.time_ and arg_138_1.time_ <= var_141_27 + arg_141_0 and not isNil(var_141_26) and arg_138_1.var_.characterEffect6045_story == nil then
				arg_138_1.var_.characterEffect6045_story = var_141_26:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_141_28 = 0.200000002980232

			if var_141_27 <= arg_138_1.time_ and arg_138_1.time_ < var_141_27 + var_141_28 and not isNil(var_141_26) then
				local var_141_29 = (arg_138_1.time_ - var_141_27) / var_141_28

				if arg_138_1.var_.characterEffect6045_story and not isNil(var_141_26) then
					arg_138_1.var_.characterEffect6045_story.fillFlat = false
				end
			end

			if arg_138_1.time_ >= var_141_27 + var_141_28 and arg_138_1.time_ < var_141_27 + var_141_28 + arg_141_0 and not isNil(var_141_26) and arg_138_1.var_.characterEffect6045_story then
				arg_138_1.var_.characterEffect6045_story.fillFlat = false
			end

			local var_141_30 = 0

			if var_141_30 < arg_138_1.time_ and arg_138_1.time_ <= var_141_30 + arg_141_0 then
				arg_138_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/story6045/story6045action/6045action4_1")
			end

			local var_141_31 = 0

			if var_141_31 < arg_138_1.time_ and arg_138_1.time_ <= var_141_31 + arg_141_0 then
				arg_138_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_141_32 = arg_138_1.actors_["6046_story"].transform
			local var_141_33 = 0

			if var_141_33 < arg_138_1.time_ and arg_138_1.time_ <= var_141_33 + arg_141_0 then
				arg_138_1.var_.moveOldPos6046_story = var_141_32.localPosition

				local var_141_34 = GameObjectTools.GetOrAddComponent(var_141_32.gameObject, typeof(DynamicBoneHelper))

				if var_141_34 then
					var_141_34:EnableDynamicBone(false)
				end
			end

			local var_141_35 = 0.001

			if var_141_33 <= arg_138_1.time_ and arg_138_1.time_ < var_141_33 + var_141_35 then
				local var_141_36 = (arg_138_1.time_ - var_141_33) / var_141_35
				local var_141_37 = Vector3.New(0.7, -0.5, -6.3)

				var_141_32.localPosition = Vector3.Lerp(arg_138_1.var_.moveOldPos6046_story, var_141_37, var_141_36)

				local var_141_38 = manager.ui.mainCamera.transform.position - var_141_32.position

				var_141_32.forward = Vector3.New(var_141_38.x, var_141_38.y, var_141_38.z)

				local var_141_39 = var_141_32.localEulerAngles

				var_141_39.z = 0
				var_141_39.x = 0
				var_141_32.localEulerAngles = var_141_39
			end

			if arg_138_1.time_ >= var_141_33 + var_141_35 and arg_138_1.time_ < var_141_33 + var_141_35 + arg_141_0 then
				var_141_32.localPosition = Vector3.New(0.7, -0.5, -6.3)

				local var_141_40 = manager.ui.mainCamera.transform.position - var_141_32.position

				var_141_32.forward = Vector3.New(var_141_40.x, var_141_40.y, var_141_40.z)

				local var_141_41 = var_141_32.localEulerAngles

				var_141_41.z = 0
				var_141_41.x = 0
				var_141_32.localEulerAngles = var_141_41

				local var_141_42 = GameObjectTools.GetOrAddComponent(var_141_32.gameObject, typeof(DynamicBoneHelper))

				if var_141_42 then
					var_141_42:EnableDynamicBone(true)
				end
			end

			local var_141_43 = arg_138_1.actors_["6046_story"]
			local var_141_44 = 0

			if var_141_44 < arg_138_1.time_ and arg_138_1.time_ <= var_141_44 + arg_141_0 and not isNil(var_141_43) and arg_138_1.var_.characterEffect6046_story == nil then
				arg_138_1.var_.characterEffect6046_story = var_141_43:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_141_45 = 0.200000002980232

			if var_141_44 <= arg_138_1.time_ and arg_138_1.time_ < var_141_44 + var_141_45 and not isNil(var_141_43) then
				local var_141_46 = (arg_138_1.time_ - var_141_44) / var_141_45

				if arg_138_1.var_.characterEffect6046_story and not isNil(var_141_43) then
					local var_141_47 = Mathf.Lerp(0, 0.5, var_141_46)

					arg_138_1.var_.characterEffect6046_story.fillFlat = true
					arg_138_1.var_.characterEffect6046_story.fillRatio = var_141_47
				end
			end

			if arg_138_1.time_ >= var_141_44 + var_141_45 and arg_138_1.time_ < var_141_44 + var_141_45 + arg_141_0 and not isNil(var_141_43) and arg_138_1.var_.characterEffect6046_story then
				local var_141_48 = 0.5

				arg_138_1.var_.characterEffect6046_story.fillFlat = true
				arg_138_1.var_.characterEffect6046_story.fillRatio = var_141_48
			end

			local var_141_49 = 0
			local var_141_50 = 0.825

			if var_141_49 < arg_138_1.time_ and arg_138_1.time_ <= var_141_49 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, true)

				local var_141_51 = arg_138_1:FormatText(StoryNameCfg[215].name)

				arg_138_1.leftNameTxt_.text = var_141_51

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_138_1.leftNameTxt_.transform)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1.leftNameTxt_.text)
				SetActive(arg_138_1.iconTrs_.gameObject, false)
				arg_138_1.callingController_:SetSelectedState("normal")

				local var_141_52 = arg_138_1:GetWordFromCfg(1109701033)
				local var_141_53 = arg_138_1:FormatText(var_141_52.content)

				arg_138_1.text_.text = var_141_53

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_54 = 33
				local var_141_55 = utf8.len(var_141_53)
				local var_141_56 = var_141_54 <= 0 and var_141_50 or var_141_50 * (var_141_55 / var_141_54)

				if var_141_56 > 0 and var_141_50 < var_141_56 then
					arg_138_1.talkMaxDuration = var_141_56

					if var_141_56 + var_141_49 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_56 + var_141_49
					end
				end

				arg_138_1.text_.text = var_141_53
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701033", "story_v_side_new_1109701.awb") ~= 0 then
					local var_141_57 = manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701033", "story_v_side_new_1109701.awb") / 1000

					if var_141_57 + var_141_49 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_57 + var_141_49
					end

					if var_141_52.prefab_name ~= "" and arg_138_1.actors_[var_141_52.prefab_name] ~= nil then
						local var_141_58 = LuaForUtil.PlayVoiceWithCriLipsync(arg_138_1.actors_[var_141_52.prefab_name].transform, "story_v_side_new_1109701", "1109701033", "story_v_side_new_1109701.awb")

						arg_138_1:RecordAudio("1109701033", var_141_58)
						arg_138_1:RecordAudio("1109701033", var_141_58)
					else
						arg_138_1:AudioAction("play", "voice", "story_v_side_new_1109701", "1109701033", "story_v_side_new_1109701.awb")
					end

					arg_138_1:RecordHistoryTalkVoice("story_v_side_new_1109701", "1109701033", "story_v_side_new_1109701.awb")
				end

				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_59 = math.max(var_141_50, arg_138_1.talkMaxDuration)

			if var_141_49 <= arg_138_1.time_ and arg_138_1.time_ < var_141_49 + var_141_59 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - var_141_49) / var_141_59

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= var_141_49 + var_141_59 and arg_138_1.time_ < var_141_49 + var_141_59 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6045_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6046_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_138_1:InitPlayNodeList()
	end,
	Play1109701034 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 1109701034
		arg_142_1.duration_ = 3.17

		local var_142_0 = {
			zh = 2,
			ja = 3.166
		}
		local var_142_1 = manager.audio:GetLocalizationFlag()

		if var_142_0[var_142_1] ~= nil then
			arg_142_1.duration_ = var_142_0[var_142_1]
		end

		SetActive(arg_142_1.tipsGo_, false)

		function arg_142_1.onSingleLineFinish_()
			arg_142_1.onSingleLineUpdate_ = nil
			arg_142_1.onSingleLineFinish_ = nil
			arg_142_1.state_ = "waiting"
		end

		function arg_142_1.playNext_(arg_144_0)
			if arg_144_0 == 1 then
				arg_142_0:Play1109701035(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			local var_145_0 = arg_142_1.actors_["6046_story"].transform
			local var_145_1 = 0

			if var_145_1 < arg_142_1.time_ and arg_142_1.time_ <= var_145_1 + arg_145_0 then
				arg_142_1.var_.moveOldPos6046_story = var_145_0.localPosition

				local var_145_2 = GameObjectTools.GetOrAddComponent(var_145_0.gameObject, typeof(DynamicBoneHelper))

				if var_145_2 then
					var_145_2:EnableDynamicBone(false)
				end
			end

			local var_145_3 = 0.001

			if var_145_1 <= arg_142_1.time_ and arg_142_1.time_ < var_145_1 + var_145_3 then
				local var_145_4 = (arg_142_1.time_ - var_145_1) / var_145_3
				local var_145_5 = Vector3.New(0.7, -0.5, -6.3)

				var_145_0.localPosition = Vector3.Lerp(arg_142_1.var_.moveOldPos6046_story, var_145_5, var_145_4)

				local var_145_6 = manager.ui.mainCamera.transform.position - var_145_0.position

				var_145_0.forward = Vector3.New(var_145_6.x, var_145_6.y, var_145_6.z)

				local var_145_7 = var_145_0.localEulerAngles

				var_145_7.z = 0
				var_145_7.x = 0
				var_145_0.localEulerAngles = var_145_7
			end

			if arg_142_1.time_ >= var_145_1 + var_145_3 and arg_142_1.time_ < var_145_1 + var_145_3 + arg_145_0 then
				var_145_0.localPosition = Vector3.New(0.7, -0.5, -6.3)

				local var_145_8 = manager.ui.mainCamera.transform.position - var_145_0.position

				var_145_0.forward = Vector3.New(var_145_8.x, var_145_8.y, var_145_8.z)

				local var_145_9 = var_145_0.localEulerAngles

				var_145_9.z = 0
				var_145_9.x = 0
				var_145_0.localEulerAngles = var_145_9

				local var_145_10 = GameObjectTools.GetOrAddComponent(var_145_0.gameObject, typeof(DynamicBoneHelper))

				if var_145_10 then
					var_145_10:EnableDynamicBone(true)
				end
			end

			local var_145_11 = arg_142_1.actors_["6046_story"]
			local var_145_12 = 0

			if var_145_12 < arg_142_1.time_ and arg_142_1.time_ <= var_145_12 + arg_145_0 and not isNil(var_145_11) and arg_142_1.var_.characterEffect6046_story == nil then
				arg_142_1.var_.characterEffect6046_story = var_145_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_145_13 = 0.200000002980232

			if var_145_12 <= arg_142_1.time_ and arg_142_1.time_ < var_145_12 + var_145_13 and not isNil(var_145_11) then
				local var_145_14 = (arg_142_1.time_ - var_145_12) / var_145_13

				if arg_142_1.var_.characterEffect6046_story and not isNil(var_145_11) then
					arg_142_1.var_.characterEffect6046_story.fillFlat = false
				end
			end

			if arg_142_1.time_ >= var_145_12 + var_145_13 and arg_142_1.time_ < var_145_12 + var_145_13 + arg_145_0 and not isNil(var_145_11) and arg_142_1.var_.characterEffect6046_story then
				arg_142_1.var_.characterEffect6046_story.fillFlat = false
			end

			local var_145_15 = 0

			if var_145_15 < arg_142_1.time_ and arg_142_1.time_ <= var_145_15 + arg_145_0 then
				arg_142_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/story6046/story6046action/6046action5_1")
			end

			local var_145_16 = 0

			if var_145_16 < arg_142_1.time_ and arg_142_1.time_ <= var_145_16 + arg_145_0 then
				arg_142_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_145_17 = arg_142_1.actors_["6045_story"]
			local var_145_18 = 0

			if var_145_18 < arg_142_1.time_ and arg_142_1.time_ <= var_145_18 + arg_145_0 and not isNil(var_145_17) and arg_142_1.var_.characterEffect6045_story == nil then
				arg_142_1.var_.characterEffect6045_story = var_145_17:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_145_19 = 0.200000002980232

			if var_145_18 <= arg_142_1.time_ and arg_142_1.time_ < var_145_18 + var_145_19 and not isNil(var_145_17) then
				local var_145_20 = (arg_142_1.time_ - var_145_18) / var_145_19

				if arg_142_1.var_.characterEffect6045_story and not isNil(var_145_17) then
					local var_145_21 = Mathf.Lerp(0, 0.5, var_145_20)

					arg_142_1.var_.characterEffect6045_story.fillFlat = true
					arg_142_1.var_.characterEffect6045_story.fillRatio = var_145_21
				end
			end

			if arg_142_1.time_ >= var_145_18 + var_145_19 and arg_142_1.time_ < var_145_18 + var_145_19 + arg_145_0 and not isNil(var_145_17) and arg_142_1.var_.characterEffect6045_story then
				local var_145_22 = 0.5

				arg_142_1.var_.characterEffect6045_story.fillFlat = true
				arg_142_1.var_.characterEffect6045_story.fillRatio = var_145_22
			end

			local var_145_23 = 0
			local var_145_24 = 0.125

			if var_145_23 < arg_142_1.time_ and arg_142_1.time_ <= var_145_23 + arg_145_0 then
				arg_142_1.talkMaxDuration = 0
				arg_142_1.dialogCg_.alpha = 1

				arg_142_1.dialog_:SetActive(true)
				SetActive(arg_142_1.leftNameGo_, true)

				local var_145_25 = arg_142_1:FormatText(StoryNameCfg[214].name)

				arg_142_1.leftNameTxt_.text = var_145_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_142_1.leftNameTxt_.transform)

				arg_142_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_142_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_142_1:RecordName(arg_142_1.leftNameTxt_.text)
				SetActive(arg_142_1.iconTrs_.gameObject, false)
				arg_142_1.callingController_:SetSelectedState("normal")

				local var_145_26 = arg_142_1:GetWordFromCfg(1109701034)
				local var_145_27 = arg_142_1:FormatText(var_145_26.content)

				arg_142_1.text_.text = var_145_27

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_28 = 5
				local var_145_29 = utf8.len(var_145_27)
				local var_145_30 = var_145_28 <= 0 and var_145_24 or var_145_24 * (var_145_29 / var_145_28)

				if var_145_30 > 0 and var_145_24 < var_145_30 then
					arg_142_1.talkMaxDuration = var_145_30

					if var_145_30 + var_145_23 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_30 + var_145_23
					end
				end

				arg_142_1.text_.text = var_145_27
				arg_142_1.typewritter.percent = 0

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701034", "story_v_side_new_1109701.awb") ~= 0 then
					local var_145_31 = manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701034", "story_v_side_new_1109701.awb") / 1000

					if var_145_31 + var_145_23 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_31 + var_145_23
					end

					if var_145_26.prefab_name ~= "" and arg_142_1.actors_[var_145_26.prefab_name] ~= nil then
						local var_145_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_142_1.actors_[var_145_26.prefab_name].transform, "story_v_side_new_1109701", "1109701034", "story_v_side_new_1109701.awb")

						arg_142_1:RecordAudio("1109701034", var_145_32)
						arg_142_1:RecordAudio("1109701034", var_145_32)
					else
						arg_142_1:AudioAction("play", "voice", "story_v_side_new_1109701", "1109701034", "story_v_side_new_1109701.awb")
					end

					arg_142_1:RecordHistoryTalkVoice("story_v_side_new_1109701", "1109701034", "story_v_side_new_1109701.awb")
				end

				arg_142_1:RecordContent(arg_142_1.text_.text)
			end

			local var_145_33 = math.max(var_145_24, arg_142_1.talkMaxDuration)

			if var_145_23 <= arg_142_1.time_ and arg_142_1.time_ < var_145_23 + var_145_33 then
				arg_142_1.typewritter.percent = (arg_142_1.time_ - var_145_23) / var_145_33

				arg_142_1.typewritter:SetDirty()
			end

			if arg_142_1.time_ >= var_145_23 + var_145_33 and arg_142_1.time_ < var_145_23 + var_145_33 + arg_145_0 then
				arg_142_1.typewritter.percent = 1

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(true)
			end
		end

		arg_142_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6046_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_142_1:InitPlayNodeList()
	end,
	Play1109701035 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 1109701035
		arg_146_1.duration_ = 5

		SetActive(arg_146_1.tipsGo_, false)

		function arg_146_1.onSingleLineFinish_()
			arg_146_1.onSingleLineUpdate_ = nil
			arg_146_1.onSingleLineFinish_ = nil
			arg_146_1.state_ = "waiting"
		end

		function arg_146_1.playNext_(arg_148_0)
			if arg_148_0 == 1 then
				arg_146_0:Play1109701036(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			local var_149_0 = arg_146_1.actors_["6046_story"]
			local var_149_1 = 0

			if var_149_1 < arg_146_1.time_ and arg_146_1.time_ <= var_149_1 + arg_149_0 and not isNil(var_149_0) and arg_146_1.var_.characterEffect6046_story == nil then
				arg_146_1.var_.characterEffect6046_story = var_149_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_149_2 = 0.200000002980232

			if var_149_1 <= arg_146_1.time_ and arg_146_1.time_ < var_149_1 + var_149_2 and not isNil(var_149_0) then
				local var_149_3 = (arg_146_1.time_ - var_149_1) / var_149_2

				if arg_146_1.var_.characterEffect6046_story and not isNil(var_149_0) then
					local var_149_4 = Mathf.Lerp(0, 0.5, var_149_3)

					arg_146_1.var_.characterEffect6046_story.fillFlat = true
					arg_146_1.var_.characterEffect6046_story.fillRatio = var_149_4
				end
			end

			if arg_146_1.time_ >= var_149_1 + var_149_2 and arg_146_1.time_ < var_149_1 + var_149_2 + arg_149_0 and not isNil(var_149_0) and arg_146_1.var_.characterEffect6046_story then
				local var_149_5 = 0.5

				arg_146_1.var_.characterEffect6046_story.fillFlat = true
				arg_146_1.var_.characterEffect6046_story.fillRatio = var_149_5
			end

			local var_149_6 = 0
			local var_149_7 = 0.1

			if var_149_6 < arg_146_1.time_ and arg_146_1.time_ <= var_149_6 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0
				arg_146_1.dialogCg_.alpha = 1

				arg_146_1.dialog_:SetActive(true)
				SetActive(arg_146_1.leftNameGo_, true)

				local var_149_8 = arg_146_1:FormatText(StoryNameCfg[7].name)

				arg_146_1.leftNameTxt_.text = var_149_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_146_1.leftNameTxt_.transform)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1.leftNameTxt_.text)
				SetActive(arg_146_1.iconTrs_.gameObject, true)
				arg_146_1.iconController_:SetSelectedState("hero")

				arg_146_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_146_1.callingController_:SetSelectedState("normal")

				arg_146_1.keyicon_.color = Color.New(1, 1, 1)
				arg_146_1.icon_.color = Color.New(1, 1, 1)

				local var_149_9 = arg_146_1:GetWordFromCfg(1109701035)
				local var_149_10 = arg_146_1:FormatText(var_149_9.content)

				arg_146_1.text_.text = var_149_10

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_11 = 4
				local var_149_12 = utf8.len(var_149_10)
				local var_149_13 = var_149_11 <= 0 and var_149_7 or var_149_7 * (var_149_12 / var_149_11)

				if var_149_13 > 0 and var_149_7 < var_149_13 then
					arg_146_1.talkMaxDuration = var_149_13

					if var_149_13 + var_149_6 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_13 + var_149_6
					end
				end

				arg_146_1.text_.text = var_149_10
				arg_146_1.typewritter.percent = 0

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(false)
				arg_146_1:RecordContent(arg_146_1.text_.text)
			end

			local var_149_14 = math.max(var_149_7, arg_146_1.talkMaxDuration)

			if var_149_6 <= arg_146_1.time_ and arg_146_1.time_ < var_149_6 + var_149_14 then
				arg_146_1.typewritter.percent = (arg_146_1.time_ - var_149_6) / var_149_14

				arg_146_1.typewritter:SetDirty()
			end

			if arg_146_1.time_ >= var_149_6 + var_149_14 and arg_146_1.time_ < var_149_6 + var_149_14 + arg_149_0 then
				arg_146_1.typewritter.percent = 1

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(true)
			end
		end

		arg_146_1.nodeConfigList_ = {}

		arg_146_1:InitPlayNodeList()
	end,
	Play1109701036 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 1109701036
		arg_150_1.duration_ = 5

		SetActive(arg_150_1.tipsGo_, false)

		function arg_150_1.onSingleLineFinish_()
			arg_150_1.onSingleLineUpdate_ = nil
			arg_150_1.onSingleLineFinish_ = nil
			arg_150_1.state_ = "waiting"
		end

		function arg_150_1.playNext_(arg_152_0)
			if arg_152_0 == 1 then
				arg_150_0:Play1109701037(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			local var_153_0 = 0
			local var_153_1 = 0.4

			if var_153_0 < arg_150_1.time_ and arg_150_1.time_ <= var_153_0 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0
				arg_150_1.dialogCg_.alpha = 1

				arg_150_1.dialog_:SetActive(true)
				SetActive(arg_150_1.leftNameGo_, true)

				local var_153_2 = arg_150_1:FormatText(StoryNameCfg[7].name)

				arg_150_1.leftNameTxt_.text = var_153_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_150_1.leftNameTxt_.transform)

				arg_150_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_150_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_150_1:RecordName(arg_150_1.leftNameTxt_.text)
				SetActive(arg_150_1.iconTrs_.gameObject, true)
				arg_150_1.iconController_:SetSelectedState("hero")

				arg_150_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_150_1.callingController_:SetSelectedState("normal")

				arg_150_1.keyicon_.color = Color.New(1, 1, 1)
				arg_150_1.icon_.color = Color.New(1, 1, 1)

				local var_153_3 = arg_150_1:GetWordFromCfg(1109701036)
				local var_153_4 = arg_150_1:FormatText(var_153_3.content)

				arg_150_1.text_.text = var_153_4

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_5 = 16
				local var_153_6 = utf8.len(var_153_4)
				local var_153_7 = var_153_5 <= 0 and var_153_1 or var_153_1 * (var_153_6 / var_153_5)

				if var_153_7 > 0 and var_153_1 < var_153_7 then
					arg_150_1.talkMaxDuration = var_153_7

					if var_153_7 + var_153_0 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_7 + var_153_0
					end
				end

				arg_150_1.text_.text = var_153_4
				arg_150_1.typewritter.percent = 0

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(false)
				arg_150_1:RecordContent(arg_150_1.text_.text)
			end

			local var_153_8 = math.max(var_153_1, arg_150_1.talkMaxDuration)

			if var_153_0 <= arg_150_1.time_ and arg_150_1.time_ < var_153_0 + var_153_8 then
				arg_150_1.typewritter.percent = (arg_150_1.time_ - var_153_0) / var_153_8

				arg_150_1.typewritter:SetDirty()
			end

			if arg_150_1.time_ >= var_153_0 + var_153_8 and arg_150_1.time_ < var_153_0 + var_153_8 + arg_153_0 then
				arg_150_1.typewritter.percent = 1

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(true)
			end
		end

		arg_150_1.nodeConfigList_ = {}

		arg_150_1:InitPlayNodeList()
	end,
	Play1109701037 = function(arg_154_0, arg_154_1)
		arg_154_1.time_ = 0
		arg_154_1.frameCnt_ = 0
		arg_154_1.state_ = "playing"
		arg_154_1.curTalkId_ = 1109701037
		arg_154_1.duration_ = 2

		SetActive(arg_154_1.tipsGo_, false)

		function arg_154_1.onSingleLineFinish_()
			arg_154_1.onSingleLineUpdate_ = nil
			arg_154_1.onSingleLineFinish_ = nil
			arg_154_1.state_ = "waiting"
		end

		function arg_154_1.playNext_(arg_156_0)
			if arg_156_0 == 1 then
				arg_154_0:Play1109701038(arg_154_1)
			end
		end

		function arg_154_1.onSingleLineUpdate_(arg_157_0)
			local var_157_0 = arg_154_1.actors_["1097ui_story"].transform
			local var_157_1 = 0

			if var_157_1 < arg_154_1.time_ and arg_154_1.time_ <= var_157_1 + arg_157_0 then
				arg_154_1.var_.moveOldPos1097ui_story = var_157_0.localPosition
			end

			local var_157_2 = 0.001

			if var_157_1 <= arg_154_1.time_ and arg_154_1.time_ < var_157_1 + var_157_2 then
				local var_157_3 = (arg_154_1.time_ - var_157_1) / var_157_2
				local var_157_4 = Vector3.New(0, -0.54, -6.3)

				var_157_0.localPosition = Vector3.Lerp(arg_154_1.var_.moveOldPos1097ui_story, var_157_4, var_157_3)

				local var_157_5 = manager.ui.mainCamera.transform.position - var_157_0.position

				var_157_0.forward = Vector3.New(var_157_5.x, var_157_5.y, var_157_5.z)

				local var_157_6 = var_157_0.localEulerAngles

				var_157_6.z = 0
				var_157_6.x = 0
				var_157_0.localEulerAngles = var_157_6
			end

			if arg_154_1.time_ >= var_157_1 + var_157_2 and arg_154_1.time_ < var_157_1 + var_157_2 + arg_157_0 then
				var_157_0.localPosition = Vector3.New(0, -0.54, -6.3)

				local var_157_7 = manager.ui.mainCamera.transform.position - var_157_0.position

				var_157_0.forward = Vector3.New(var_157_7.x, var_157_7.y, var_157_7.z)

				local var_157_8 = var_157_0.localEulerAngles

				var_157_8.z = 0
				var_157_8.x = 0
				var_157_0.localEulerAngles = var_157_8
			end

			local var_157_9 = arg_154_1.actors_["1097ui_story"]
			local var_157_10 = 0

			if var_157_10 < arg_154_1.time_ and arg_154_1.time_ <= var_157_10 + arg_157_0 and not isNil(var_157_9) and arg_154_1.var_.characterEffect1097ui_story == nil then
				arg_154_1.var_.characterEffect1097ui_story = var_157_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_157_11 = 0.200000002980232

			if var_157_10 <= arg_154_1.time_ and arg_154_1.time_ < var_157_10 + var_157_11 and not isNil(var_157_9) then
				local var_157_12 = (arg_154_1.time_ - var_157_10) / var_157_11

				if arg_154_1.var_.characterEffect1097ui_story and not isNil(var_157_9) then
					arg_154_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_154_1.time_ >= var_157_10 + var_157_11 and arg_154_1.time_ < var_157_10 + var_157_11 + arg_157_0 and not isNil(var_157_9) and arg_154_1.var_.characterEffect1097ui_story then
				arg_154_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_157_13 = 0

			if var_157_13 < arg_154_1.time_ and arg_154_1.time_ <= var_157_13 + arg_157_0 then
				arg_154_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			local var_157_14 = 0

			if var_157_14 < arg_154_1.time_ and arg_154_1.time_ <= var_157_14 + arg_157_0 then
				arg_154_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_157_15 = arg_154_1.actors_["6045_story"].transform
			local var_157_16 = 0

			if var_157_16 < arg_154_1.time_ and arg_154_1.time_ <= var_157_16 + arg_157_0 then
				arg_154_1.var_.moveOldPos6045_story = var_157_15.localPosition

				local var_157_17 = GameObjectTools.GetOrAddComponent(var_157_15.gameObject, typeof(DynamicBoneHelper))

				if var_157_17 then
					var_157_17:EnableDynamicBone(false)
				end
			end

			local var_157_18 = 0.001

			if var_157_16 <= arg_154_1.time_ and arg_154_1.time_ < var_157_16 + var_157_18 then
				local var_157_19 = (arg_154_1.time_ - var_157_16) / var_157_18
				local var_157_20 = Vector3.New(0, 100, 0)

				var_157_15.localPosition = Vector3.Lerp(arg_154_1.var_.moveOldPos6045_story, var_157_20, var_157_19)

				local var_157_21 = manager.ui.mainCamera.transform.position - var_157_15.position

				var_157_15.forward = Vector3.New(var_157_21.x, var_157_21.y, var_157_21.z)

				local var_157_22 = var_157_15.localEulerAngles

				var_157_22.z = 0
				var_157_22.x = 0
				var_157_15.localEulerAngles = var_157_22
			end

			if arg_154_1.time_ >= var_157_16 + var_157_18 and arg_154_1.time_ < var_157_16 + var_157_18 + arg_157_0 then
				var_157_15.localPosition = Vector3.New(0, 100, 0)

				local var_157_23 = manager.ui.mainCamera.transform.position - var_157_15.position

				var_157_15.forward = Vector3.New(var_157_23.x, var_157_23.y, var_157_23.z)

				local var_157_24 = var_157_15.localEulerAngles

				var_157_24.z = 0
				var_157_24.x = 0
				var_157_15.localEulerAngles = var_157_24

				local var_157_25 = GameObjectTools.GetOrAddComponent(var_157_15.gameObject, typeof(DynamicBoneHelper))

				if var_157_25 then
					var_157_25:EnableDynamicBone(true)
				end
			end

			local var_157_26 = arg_154_1.actors_["6045_story"]
			local var_157_27 = 0

			if var_157_27 < arg_154_1.time_ and arg_154_1.time_ <= var_157_27 + arg_157_0 and not isNil(var_157_26) and arg_154_1.var_.characterEffect6045_story == nil then
				arg_154_1.var_.characterEffect6045_story = var_157_26:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_157_28 = 0.200000002980232

			if var_157_27 <= arg_154_1.time_ and arg_154_1.time_ < var_157_27 + var_157_28 and not isNil(var_157_26) then
				local var_157_29 = (arg_154_1.time_ - var_157_27) / var_157_28

				if arg_154_1.var_.characterEffect6045_story and not isNil(var_157_26) then
					local var_157_30 = Mathf.Lerp(0, 0.5, var_157_29)

					arg_154_1.var_.characterEffect6045_story.fillFlat = true
					arg_154_1.var_.characterEffect6045_story.fillRatio = var_157_30
				end
			end

			if arg_154_1.time_ >= var_157_27 + var_157_28 and arg_154_1.time_ < var_157_27 + var_157_28 + arg_157_0 and not isNil(var_157_26) and arg_154_1.var_.characterEffect6045_story then
				local var_157_31 = 0.5

				arg_154_1.var_.characterEffect6045_story.fillFlat = true
				arg_154_1.var_.characterEffect6045_story.fillRatio = var_157_31
			end

			local var_157_32 = arg_154_1.actors_["6046_story"].transform
			local var_157_33 = 0

			if var_157_33 < arg_154_1.time_ and arg_154_1.time_ <= var_157_33 + arg_157_0 then
				arg_154_1.var_.moveOldPos6046_story = var_157_32.localPosition

				local var_157_34 = GameObjectTools.GetOrAddComponent(var_157_32.gameObject, typeof(DynamicBoneHelper))

				if var_157_34 then
					var_157_34:EnableDynamicBone(false)
				end
			end

			local var_157_35 = 0.001

			if var_157_33 <= arg_154_1.time_ and arg_154_1.time_ < var_157_33 + var_157_35 then
				local var_157_36 = (arg_154_1.time_ - var_157_33) / var_157_35
				local var_157_37 = Vector3.New(0, 100, 0)

				var_157_32.localPosition = Vector3.Lerp(arg_154_1.var_.moveOldPos6046_story, var_157_37, var_157_36)

				local var_157_38 = manager.ui.mainCamera.transform.position - var_157_32.position

				var_157_32.forward = Vector3.New(var_157_38.x, var_157_38.y, var_157_38.z)

				local var_157_39 = var_157_32.localEulerAngles

				var_157_39.z = 0
				var_157_39.x = 0
				var_157_32.localEulerAngles = var_157_39
			end

			if arg_154_1.time_ >= var_157_33 + var_157_35 and arg_154_1.time_ < var_157_33 + var_157_35 + arg_157_0 then
				var_157_32.localPosition = Vector3.New(0, 100, 0)

				local var_157_40 = manager.ui.mainCamera.transform.position - var_157_32.position

				var_157_32.forward = Vector3.New(var_157_40.x, var_157_40.y, var_157_40.z)

				local var_157_41 = var_157_32.localEulerAngles

				var_157_41.z = 0
				var_157_41.x = 0
				var_157_32.localEulerAngles = var_157_41

				local var_157_42 = GameObjectTools.GetOrAddComponent(var_157_32.gameObject, typeof(DynamicBoneHelper))

				if var_157_42 then
					var_157_42:EnableDynamicBone(true)
				end
			end

			local var_157_43 = arg_154_1.actors_["6046_story"]
			local var_157_44 = 0

			if var_157_44 < arg_154_1.time_ and arg_154_1.time_ <= var_157_44 + arg_157_0 and not isNil(var_157_43) and arg_154_1.var_.characterEffect6046_story == nil then
				arg_154_1.var_.characterEffect6046_story = var_157_43:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_157_45 = 0.200000002980232

			if var_157_44 <= arg_154_1.time_ and arg_154_1.time_ < var_157_44 + var_157_45 and not isNil(var_157_43) then
				local var_157_46 = (arg_154_1.time_ - var_157_44) / var_157_45

				if arg_154_1.var_.characterEffect6046_story and not isNil(var_157_43) then
					local var_157_47 = Mathf.Lerp(0, 0.5, var_157_46)

					arg_154_1.var_.characterEffect6046_story.fillFlat = true
					arg_154_1.var_.characterEffect6046_story.fillRatio = var_157_47
				end
			end

			if arg_154_1.time_ >= var_157_44 + var_157_45 and arg_154_1.time_ < var_157_44 + var_157_45 + arg_157_0 and not isNil(var_157_43) and arg_154_1.var_.characterEffect6046_story then
				local var_157_48 = 0.5

				arg_154_1.var_.characterEffect6046_story.fillFlat = true
				arg_154_1.var_.characterEffect6046_story.fillRatio = var_157_48
			end

			local var_157_49 = 0
			local var_157_50 = 0.075

			if var_157_49 < arg_154_1.time_ and arg_154_1.time_ <= var_157_49 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0
				arg_154_1.dialogCg_.alpha = 1

				arg_154_1.dialog_:SetActive(true)
				SetActive(arg_154_1.leftNameGo_, true)

				local var_157_51 = arg_154_1:FormatText(StoryNameCfg[216].name)

				arg_154_1.leftNameTxt_.text = var_157_51

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_154_1.leftNameTxt_.transform)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1.leftNameTxt_.text)
				SetActive(arg_154_1.iconTrs_.gameObject, false)
				arg_154_1.callingController_:SetSelectedState("normal")

				local var_157_52 = arg_154_1:GetWordFromCfg(1109701037)
				local var_157_53 = arg_154_1:FormatText(var_157_52.content)

				arg_154_1.text_.text = var_157_53

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_54 = 3
				local var_157_55 = utf8.len(var_157_53)
				local var_157_56 = var_157_54 <= 0 and var_157_50 or var_157_50 * (var_157_55 / var_157_54)

				if var_157_56 > 0 and var_157_50 < var_157_56 then
					arg_154_1.talkMaxDuration = var_157_56

					if var_157_56 + var_157_49 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_56 + var_157_49
					end
				end

				arg_154_1.text_.text = var_157_53
				arg_154_1.typewritter.percent = 0

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701037", "story_v_side_new_1109701.awb") ~= 0 then
					local var_157_57 = manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701037", "story_v_side_new_1109701.awb") / 1000

					if var_157_57 + var_157_49 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_57 + var_157_49
					end

					if var_157_52.prefab_name ~= "" and arg_154_1.actors_[var_157_52.prefab_name] ~= nil then
						local var_157_58 = LuaForUtil.PlayVoiceWithCriLipsync(arg_154_1.actors_[var_157_52.prefab_name].transform, "story_v_side_new_1109701", "1109701037", "story_v_side_new_1109701.awb")

						arg_154_1:RecordAudio("1109701037", var_157_58)
						arg_154_1:RecordAudio("1109701037", var_157_58)
					else
						arg_154_1:AudioAction("play", "voice", "story_v_side_new_1109701", "1109701037", "story_v_side_new_1109701.awb")
					end

					arg_154_1:RecordHistoryTalkVoice("story_v_side_new_1109701", "1109701037", "story_v_side_new_1109701.awb")
				end

				arg_154_1:RecordContent(arg_154_1.text_.text)
			end

			local var_157_59 = math.max(var_157_50, arg_154_1.talkMaxDuration)

			if var_157_49 <= arg_154_1.time_ and arg_154_1.time_ < var_157_49 + var_157_59 then
				arg_154_1.typewritter.percent = (arg_154_1.time_ - var_157_49) / var_157_59

				arg_154_1.typewritter:SetDirty()
			end

			if arg_154_1.time_ >= var_157_49 + var_157_59 and arg_154_1.time_ < var_157_49 + var_157_59 + arg_157_0 then
				arg_154_1.typewritter.percent = 1

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(true)
			end
		end

		arg_154_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6045_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6046_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_154_1:InitPlayNodeList()
	end,
	Play1109701038 = function(arg_158_0, arg_158_1)
		arg_158_1.time_ = 0
		arg_158_1.frameCnt_ = 0
		arg_158_1.state_ = "playing"
		arg_158_1.curTalkId_ = 1109701038
		arg_158_1.duration_ = 5

		SetActive(arg_158_1.tipsGo_, false)

		function arg_158_1.onSingleLineFinish_()
			arg_158_1.onSingleLineUpdate_ = nil
			arg_158_1.onSingleLineFinish_ = nil
			arg_158_1.state_ = "waiting"
		end

		function arg_158_1.playNext_(arg_160_0)
			if arg_160_0 == 1 then
				arg_158_0:Play1109701039(arg_158_1)
			end
		end

		function arg_158_1.onSingleLineUpdate_(arg_161_0)
			local var_161_0 = arg_158_1.actors_["1097ui_story"]
			local var_161_1 = 0

			if var_161_1 < arg_158_1.time_ and arg_158_1.time_ <= var_161_1 + arg_161_0 and not isNil(var_161_0) and arg_158_1.var_.characterEffect1097ui_story == nil then
				arg_158_1.var_.characterEffect1097ui_story = var_161_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_161_2 = 0.200000002980232

			if var_161_1 <= arg_158_1.time_ and arg_158_1.time_ < var_161_1 + var_161_2 and not isNil(var_161_0) then
				local var_161_3 = (arg_158_1.time_ - var_161_1) / var_161_2

				if arg_158_1.var_.characterEffect1097ui_story and not isNil(var_161_0) then
					local var_161_4 = Mathf.Lerp(0, 0.5, var_161_3)

					arg_158_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_158_1.var_.characterEffect1097ui_story.fillRatio = var_161_4
				end
			end

			if arg_158_1.time_ >= var_161_1 + var_161_2 and arg_158_1.time_ < var_161_1 + var_161_2 + arg_161_0 and not isNil(var_161_0) and arg_158_1.var_.characterEffect1097ui_story then
				local var_161_5 = 0.5

				arg_158_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_158_1.var_.characterEffect1097ui_story.fillRatio = var_161_5
			end

			local var_161_6 = 0
			local var_161_7 = 0.775

			if var_161_6 < arg_158_1.time_ and arg_158_1.time_ <= var_161_6 + arg_161_0 then
				arg_158_1.talkMaxDuration = 0
				arg_158_1.dialogCg_.alpha = 1

				arg_158_1.dialog_:SetActive(true)
				SetActive(arg_158_1.leftNameGo_, false)

				arg_158_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_158_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_158_1:RecordName(arg_158_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_158_1.iconTrs_.gameObject, false)
				arg_158_1.callingController_:SetSelectedState("normal")

				local var_161_8 = arg_158_1:GetWordFromCfg(1109701038)
				local var_161_9 = arg_158_1:FormatText(var_161_8.content)

				arg_158_1.text_.text = var_161_9

				LuaForUtil.ClearLinePrefixSymbol(arg_158_1.text_)

				local var_161_10 = 31
				local var_161_11 = utf8.len(var_161_9)
				local var_161_12 = var_161_10 <= 0 and var_161_7 or var_161_7 * (var_161_11 / var_161_10)

				if var_161_12 > 0 and var_161_7 < var_161_12 then
					arg_158_1.talkMaxDuration = var_161_12

					if var_161_12 + var_161_6 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_12 + var_161_6
					end
				end

				arg_158_1.text_.text = var_161_9
				arg_158_1.typewritter.percent = 0

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(false)
				arg_158_1:RecordContent(arg_158_1.text_.text)
			end

			local var_161_13 = math.max(var_161_7, arg_158_1.talkMaxDuration)

			if var_161_6 <= arg_158_1.time_ and arg_158_1.time_ < var_161_6 + var_161_13 then
				arg_158_1.typewritter.percent = (arg_158_1.time_ - var_161_6) / var_161_13

				arg_158_1.typewritter:SetDirty()
			end

			if arg_158_1.time_ >= var_161_6 + var_161_13 and arg_158_1.time_ < var_161_6 + var_161_13 + arg_161_0 then
				arg_158_1.typewritter.percent = 1

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(true)
			end
		end

		arg_158_1.nodeConfigList_ = {}

		arg_158_1:InitPlayNodeList()
	end,
	Play1109701039 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 1109701039
		arg_162_1.duration_ = 5

		SetActive(arg_162_1.tipsGo_, false)

		function arg_162_1.onSingleLineFinish_()
			arg_162_1.onSingleLineUpdate_ = nil
			arg_162_1.onSingleLineFinish_ = nil
			arg_162_1.state_ = "waiting"
		end

		function arg_162_1.playNext_(arg_164_0)
			if arg_164_0 == 1 then
				arg_162_0:Play1109701040(arg_162_1)
			end
		end

		function arg_162_1.onSingleLineUpdate_(arg_165_0)
			local var_165_0 = 0
			local var_165_1 = 0.225

			if var_165_0 < arg_162_1.time_ and arg_162_1.time_ <= var_165_0 + arg_165_0 then
				arg_162_1.talkMaxDuration = 0
				arg_162_1.dialogCg_.alpha = 1

				arg_162_1.dialog_:SetActive(true)
				SetActive(arg_162_1.leftNameGo_, true)

				local var_165_2 = arg_162_1:FormatText(StoryNameCfg[7].name)

				arg_162_1.leftNameTxt_.text = var_165_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_162_1.leftNameTxt_.transform)

				arg_162_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_162_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_162_1:RecordName(arg_162_1.leftNameTxt_.text)
				SetActive(arg_162_1.iconTrs_.gameObject, true)
				arg_162_1.iconController_:SetSelectedState("hero")

				arg_162_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_162_1.callingController_:SetSelectedState("normal")

				arg_162_1.keyicon_.color = Color.New(1, 1, 1)
				arg_162_1.icon_.color = Color.New(1, 1, 1)

				local var_165_3 = arg_162_1:GetWordFromCfg(1109701039)
				local var_165_4 = arg_162_1:FormatText(var_165_3.content)

				arg_162_1.text_.text = var_165_4

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_5 = 9
				local var_165_6 = utf8.len(var_165_4)
				local var_165_7 = var_165_5 <= 0 and var_165_1 or var_165_1 * (var_165_6 / var_165_5)

				if var_165_7 > 0 and var_165_1 < var_165_7 then
					arg_162_1.talkMaxDuration = var_165_7

					if var_165_7 + var_165_0 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_7 + var_165_0
					end
				end

				arg_162_1.text_.text = var_165_4
				arg_162_1.typewritter.percent = 0

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(false)
				arg_162_1:RecordContent(arg_162_1.text_.text)
			end

			local var_165_8 = math.max(var_165_1, arg_162_1.talkMaxDuration)

			if var_165_0 <= arg_162_1.time_ and arg_162_1.time_ < var_165_0 + var_165_8 then
				arg_162_1.typewritter.percent = (arg_162_1.time_ - var_165_0) / var_165_8

				arg_162_1.typewritter:SetDirty()
			end

			if arg_162_1.time_ >= var_165_0 + var_165_8 and arg_162_1.time_ < var_165_0 + var_165_8 + arg_165_0 then
				arg_162_1.typewritter.percent = 1

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(true)
			end
		end

		arg_162_1.nodeConfigList_ = {}

		arg_162_1:InitPlayNodeList()
	end,
	Play1109701040 = function(arg_166_0, arg_166_1)
		arg_166_1.time_ = 0
		arg_166_1.frameCnt_ = 0
		arg_166_1.state_ = "playing"
		arg_166_1.curTalkId_ = 1109701040
		arg_166_1.duration_ = 5

		SetActive(arg_166_1.tipsGo_, false)

		function arg_166_1.onSingleLineFinish_()
			arg_166_1.onSingleLineUpdate_ = nil
			arg_166_1.onSingleLineFinish_ = nil
			arg_166_1.state_ = "waiting"
		end

		function arg_166_1.playNext_(arg_168_0)
			if arg_168_0 == 1 then
				arg_166_0:Play1109701041(arg_166_1)
			end
		end

		function arg_166_1.onSingleLineUpdate_(arg_169_0)
			local var_169_0 = 0
			local var_169_1 = 0.3

			if var_169_0 < arg_166_1.time_ and arg_166_1.time_ <= var_169_0 + arg_169_0 then
				arg_166_1.talkMaxDuration = 0
				arg_166_1.dialogCg_.alpha = 1

				arg_166_1.dialog_:SetActive(true)
				SetActive(arg_166_1.leftNameGo_, true)

				local var_169_2 = arg_166_1:FormatText(StoryNameCfg[7].name)

				arg_166_1.leftNameTxt_.text = var_169_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_166_1.leftNameTxt_.transform)

				arg_166_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_166_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_166_1:RecordName(arg_166_1.leftNameTxt_.text)
				SetActive(arg_166_1.iconTrs_.gameObject, true)
				arg_166_1.iconController_:SetSelectedState("hero")

				arg_166_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_166_1.callingController_:SetSelectedState("normal")

				arg_166_1.keyicon_.color = Color.New(1, 1, 1)
				arg_166_1.icon_.color = Color.New(1, 1, 1)

				local var_169_3 = arg_166_1:GetWordFromCfg(1109701040)
				local var_169_4 = arg_166_1:FormatText(var_169_3.content)

				arg_166_1.text_.text = var_169_4

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_5 = 12
				local var_169_6 = utf8.len(var_169_4)
				local var_169_7 = var_169_5 <= 0 and var_169_1 or var_169_1 * (var_169_6 / var_169_5)

				if var_169_7 > 0 and var_169_1 < var_169_7 then
					arg_166_1.talkMaxDuration = var_169_7

					if var_169_7 + var_169_0 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_7 + var_169_0
					end
				end

				arg_166_1.text_.text = var_169_4
				arg_166_1.typewritter.percent = 0

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(false)
				arg_166_1:RecordContent(arg_166_1.text_.text)
			end

			local var_169_8 = math.max(var_169_1, arg_166_1.talkMaxDuration)

			if var_169_0 <= arg_166_1.time_ and arg_166_1.time_ < var_169_0 + var_169_8 then
				arg_166_1.typewritter.percent = (arg_166_1.time_ - var_169_0) / var_169_8

				arg_166_1.typewritter:SetDirty()
			end

			if arg_166_1.time_ >= var_169_0 + var_169_8 and arg_166_1.time_ < var_169_0 + var_169_8 + arg_169_0 then
				arg_166_1.typewritter.percent = 1

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(true)
			end
		end

		arg_166_1.nodeConfigList_ = {}

		arg_166_1:InitPlayNodeList()
	end,
	Play1109701041 = function(arg_170_0, arg_170_1)
		arg_170_1.time_ = 0
		arg_170_1.frameCnt_ = 0
		arg_170_1.state_ = "playing"
		arg_170_1.curTalkId_ = 1109701041
		arg_170_1.duration_ = 4.83

		local var_170_0 = {
			zh = 4.833,
			ja = 2.099999999999
		}
		local var_170_1 = manager.audio:GetLocalizationFlag()

		if var_170_0[var_170_1] ~= nil then
			arg_170_1.duration_ = var_170_0[var_170_1]
		end

		SetActive(arg_170_1.tipsGo_, false)

		function arg_170_1.onSingleLineFinish_()
			arg_170_1.onSingleLineUpdate_ = nil
			arg_170_1.onSingleLineFinish_ = nil
			arg_170_1.state_ = "waiting"
		end

		function arg_170_1.playNext_(arg_172_0)
			if arg_172_0 == 1 then
				arg_170_0:Play1109701042(arg_170_1)
			end
		end

		function arg_170_1.onSingleLineUpdate_(arg_173_0)
			local var_173_0 = arg_170_1.actors_["1097ui_story"].transform
			local var_173_1 = 0

			if var_173_1 < arg_170_1.time_ and arg_170_1.time_ <= var_173_1 + arg_173_0 then
				arg_170_1.var_.moveOldPos1097ui_story = var_173_0.localPosition
			end

			local var_173_2 = 0.001

			if var_173_1 <= arg_170_1.time_ and arg_170_1.time_ < var_173_1 + var_173_2 then
				local var_173_3 = (arg_170_1.time_ - var_173_1) / var_173_2
				local var_173_4 = Vector3.New(0, -0.54, -6.3)

				var_173_0.localPosition = Vector3.Lerp(arg_170_1.var_.moveOldPos1097ui_story, var_173_4, var_173_3)

				local var_173_5 = manager.ui.mainCamera.transform.position - var_173_0.position

				var_173_0.forward = Vector3.New(var_173_5.x, var_173_5.y, var_173_5.z)

				local var_173_6 = var_173_0.localEulerAngles

				var_173_6.z = 0
				var_173_6.x = 0
				var_173_0.localEulerAngles = var_173_6
			end

			if arg_170_1.time_ >= var_173_1 + var_173_2 and arg_170_1.time_ < var_173_1 + var_173_2 + arg_173_0 then
				var_173_0.localPosition = Vector3.New(0, -0.54, -6.3)

				local var_173_7 = manager.ui.mainCamera.transform.position - var_173_0.position

				var_173_0.forward = Vector3.New(var_173_7.x, var_173_7.y, var_173_7.z)

				local var_173_8 = var_173_0.localEulerAngles

				var_173_8.z = 0
				var_173_8.x = 0
				var_173_0.localEulerAngles = var_173_8
			end

			local var_173_9 = arg_170_1.actors_["1097ui_story"]
			local var_173_10 = 0

			if var_173_10 < arg_170_1.time_ and arg_170_1.time_ <= var_173_10 + arg_173_0 and not isNil(var_173_9) and arg_170_1.var_.characterEffect1097ui_story == nil then
				arg_170_1.var_.characterEffect1097ui_story = var_173_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_173_11 = 0.200000002980232

			if var_173_10 <= arg_170_1.time_ and arg_170_1.time_ < var_173_10 + var_173_11 and not isNil(var_173_9) then
				local var_173_12 = (arg_170_1.time_ - var_173_10) / var_173_11

				if arg_170_1.var_.characterEffect1097ui_story and not isNil(var_173_9) then
					arg_170_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_170_1.time_ >= var_173_10 + var_173_11 and arg_170_1.time_ < var_173_10 + var_173_11 + arg_173_0 and not isNil(var_173_9) and arg_170_1.var_.characterEffect1097ui_story then
				arg_170_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_173_13 = 0

			if var_173_13 < arg_170_1.time_ and arg_170_1.time_ <= var_173_13 + arg_173_0 then
				arg_170_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action5_1")
			end

			local var_173_14 = 0

			if var_173_14 < arg_170_1.time_ and arg_170_1.time_ <= var_173_14 + arg_173_0 then
				arg_170_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_173_15 = arg_170_1.actors_["1097ui_story"].transform
			local var_173_16 = 0

			if var_173_16 < arg_170_1.time_ and arg_170_1.time_ <= var_173_16 + arg_173_0 then
				local var_173_17 = arg_170_1.var_.effect1097ui_storyyangchuxian1
				local var_173_18
				local var_173_19 = var_173_15

				if not var_173_17 then
					var_173_17 = Object.Instantiate(Asset.Load("Effect/Hero/1097/fx_1097_story_smoke"), var_173_19)
					var_173_17.name = "yangchuxian1"
					arg_170_1.var_.effect1097ui_storyyangchuxian1 = var_173_17
				else
					var_173_17.transform:SetParent(var_173_19)
				end

				var_173_17.transform.localPosition = Vector3.New(0, 1.28, 0.3)
				var_173_17.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_173_20 = arg_170_1.actors_["1097ui_story"].transform
			local var_173_21 = 2

			if var_173_21 < arg_170_1.time_ and arg_170_1.time_ <= var_173_21 + arg_173_0 then
				local var_173_22 = arg_170_1.var_.effect1097ui_storyyangchuxian1

				if var_173_22 then
					Object.Destroy(var_173_22)

					arg_170_1.var_.effect1097ui_storyyangchuxian1 = nil
				end
			end

			local var_173_23 = 0
			local var_173_24 = 0.6

			if var_173_23 < arg_170_1.time_ and arg_170_1.time_ <= var_173_23 + arg_173_0 then
				arg_170_1.talkMaxDuration = 0
				arg_170_1.dialogCg_.alpha = 1

				arg_170_1.dialog_:SetActive(true)
				SetActive(arg_170_1.leftNameGo_, true)

				local var_173_25 = arg_170_1:FormatText(StoryNameCfg[216].name)

				arg_170_1.leftNameTxt_.text = var_173_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_170_1.leftNameTxt_.transform)

				arg_170_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_170_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_170_1:RecordName(arg_170_1.leftNameTxt_.text)
				SetActive(arg_170_1.iconTrs_.gameObject, false)
				arg_170_1.callingController_:SetSelectedState("normal")

				local var_173_26 = arg_170_1:GetWordFromCfg(1109701041)
				local var_173_27 = arg_170_1:FormatText(var_173_26.content)

				arg_170_1.text_.text = var_173_27

				LuaForUtil.ClearLinePrefixSymbol(arg_170_1.text_)

				local var_173_28 = 24
				local var_173_29 = utf8.len(var_173_27)
				local var_173_30 = var_173_28 <= 0 and var_173_24 or var_173_24 * (var_173_29 / var_173_28)

				if var_173_30 > 0 and var_173_24 < var_173_30 then
					arg_170_1.talkMaxDuration = var_173_30

					if var_173_30 + var_173_23 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_30 + var_173_23
					end
				end

				arg_170_1.text_.text = var_173_27
				arg_170_1.typewritter.percent = 0

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701041", "story_v_side_new_1109701.awb") ~= 0 then
					local var_173_31 = manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701041", "story_v_side_new_1109701.awb") / 1000

					if var_173_31 + var_173_23 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_31 + var_173_23
					end

					if var_173_26.prefab_name ~= "" and arg_170_1.actors_[var_173_26.prefab_name] ~= nil then
						local var_173_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_170_1.actors_[var_173_26.prefab_name].transform, "story_v_side_new_1109701", "1109701041", "story_v_side_new_1109701.awb")

						arg_170_1:RecordAudio("1109701041", var_173_32)
						arg_170_1:RecordAudio("1109701041", var_173_32)
					else
						arg_170_1:AudioAction("play", "voice", "story_v_side_new_1109701", "1109701041", "story_v_side_new_1109701.awb")
					end

					arg_170_1:RecordHistoryTalkVoice("story_v_side_new_1109701", "1109701041", "story_v_side_new_1109701.awb")
				end

				arg_170_1:RecordContent(arg_170_1.text_.text)
			end

			local var_173_33 = math.max(var_173_24, arg_170_1.talkMaxDuration)

			if var_173_23 <= arg_170_1.time_ and arg_170_1.time_ < var_173_23 + var_173_33 then
				arg_170_1.typewritter.percent = (arg_170_1.time_ - var_173_23) / var_173_33

				arg_170_1.typewritter:SetDirty()
			end

			if arg_170_1.time_ >= var_173_23 + var_173_33 and arg_170_1.time_ < var_173_23 + var_173_33 + arg_173_0 then
				arg_170_1.typewritter.percent = 1

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(true)
			end
		end

		arg_170_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_170_1:InitPlayNodeList()
	end,
	Play1109701042 = function(arg_174_0, arg_174_1)
		arg_174_1.time_ = 0
		arg_174_1.frameCnt_ = 0
		arg_174_1.state_ = "playing"
		arg_174_1.curTalkId_ = 1109701042
		arg_174_1.duration_ = 5

		SetActive(arg_174_1.tipsGo_, false)

		function arg_174_1.onSingleLineFinish_()
			arg_174_1.onSingleLineUpdate_ = nil
			arg_174_1.onSingleLineFinish_ = nil
			arg_174_1.state_ = "waiting"
		end

		function arg_174_1.playNext_(arg_176_0)
			if arg_176_0 == 1 then
				arg_174_0:Play1109701043(arg_174_1)
			end
		end

		function arg_174_1.onSingleLineUpdate_(arg_177_0)
			local var_177_0 = arg_174_1.actors_["1097ui_story"]
			local var_177_1 = 0

			if var_177_1 < arg_174_1.time_ and arg_174_1.time_ <= var_177_1 + arg_177_0 and not isNil(var_177_0) and arg_174_1.var_.characterEffect1097ui_story == nil then
				arg_174_1.var_.characterEffect1097ui_story = var_177_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_177_2 = 0.200000002980232

			if var_177_1 <= arg_174_1.time_ and arg_174_1.time_ < var_177_1 + var_177_2 and not isNil(var_177_0) then
				local var_177_3 = (arg_174_1.time_ - var_177_1) / var_177_2

				if arg_174_1.var_.characterEffect1097ui_story and not isNil(var_177_0) then
					local var_177_4 = Mathf.Lerp(0, 0.5, var_177_3)

					arg_174_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_174_1.var_.characterEffect1097ui_story.fillRatio = var_177_4
				end
			end

			if arg_174_1.time_ >= var_177_1 + var_177_2 and arg_174_1.time_ < var_177_1 + var_177_2 + arg_177_0 and not isNil(var_177_0) and arg_174_1.var_.characterEffect1097ui_story then
				local var_177_5 = 0.5

				arg_174_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_174_1.var_.characterEffect1097ui_story.fillRatio = var_177_5
			end

			local var_177_6 = 0
			local var_177_7 = 0.325

			if var_177_6 < arg_174_1.time_ and arg_174_1.time_ <= var_177_6 + arg_177_0 then
				arg_174_1.talkMaxDuration = 0
				arg_174_1.dialogCg_.alpha = 1

				arg_174_1.dialog_:SetActive(true)
				SetActive(arg_174_1.leftNameGo_, true)

				local var_177_8 = arg_174_1:FormatText(StoryNameCfg[7].name)

				arg_174_1.leftNameTxt_.text = var_177_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_174_1.leftNameTxt_.transform)

				arg_174_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_174_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_174_1:RecordName(arg_174_1.leftNameTxt_.text)
				SetActive(arg_174_1.iconTrs_.gameObject, true)
				arg_174_1.iconController_:SetSelectedState("hero")

				arg_174_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_174_1.callingController_:SetSelectedState("normal")

				arg_174_1.keyicon_.color = Color.New(1, 1, 1)
				arg_174_1.icon_.color = Color.New(1, 1, 1)

				local var_177_9 = arg_174_1:GetWordFromCfg(1109701042)
				local var_177_10 = arg_174_1:FormatText(var_177_9.content)

				arg_174_1.text_.text = var_177_10

				LuaForUtil.ClearLinePrefixSymbol(arg_174_1.text_)

				local var_177_11 = 13
				local var_177_12 = utf8.len(var_177_10)
				local var_177_13 = var_177_11 <= 0 and var_177_7 or var_177_7 * (var_177_12 / var_177_11)

				if var_177_13 > 0 and var_177_7 < var_177_13 then
					arg_174_1.talkMaxDuration = var_177_13

					if var_177_13 + var_177_6 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_13 + var_177_6
					end
				end

				arg_174_1.text_.text = var_177_10
				arg_174_1.typewritter.percent = 0

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(false)
				arg_174_1:RecordContent(arg_174_1.text_.text)
			end

			local var_177_14 = math.max(var_177_7, arg_174_1.talkMaxDuration)

			if var_177_6 <= arg_174_1.time_ and arg_174_1.time_ < var_177_6 + var_177_14 then
				arg_174_1.typewritter.percent = (arg_174_1.time_ - var_177_6) / var_177_14

				arg_174_1.typewritter:SetDirty()
			end

			if arg_174_1.time_ >= var_177_6 + var_177_14 and arg_174_1.time_ < var_177_6 + var_177_14 + arg_177_0 then
				arg_174_1.typewritter.percent = 1

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(true)
			end
		end

		arg_174_1.nodeConfigList_ = {}

		arg_174_1:InitPlayNodeList()
	end,
	Play1109701043 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 1109701043
		arg_178_1.duration_ = 5

		SetActive(arg_178_1.tipsGo_, false)

		function arg_178_1.onSingleLineFinish_()
			arg_178_1.onSingleLineUpdate_ = nil
			arg_178_1.onSingleLineFinish_ = nil
			arg_178_1.state_ = "waiting"
		end

		function arg_178_1.playNext_(arg_180_0)
			if arg_180_0 == 1 then
				arg_178_0:Play1109701044(arg_178_1)
			end
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			local var_181_0 = arg_178_1.actors_["1097ui_story"].transform
			local var_181_1 = 0

			if var_181_1 < arg_178_1.time_ and arg_178_1.time_ <= var_181_1 + arg_181_0 then
				arg_178_1.var_.moveOldPos1097ui_story = var_181_0.localPosition
			end

			local var_181_2 = 0.001

			if var_181_1 <= arg_178_1.time_ and arg_178_1.time_ < var_181_1 + var_181_2 then
				local var_181_3 = (arg_178_1.time_ - var_181_1) / var_181_2
				local var_181_4 = Vector3.New(0, 100, 0)

				var_181_0.localPosition = Vector3.Lerp(arg_178_1.var_.moveOldPos1097ui_story, var_181_4, var_181_3)

				local var_181_5 = manager.ui.mainCamera.transform.position - var_181_0.position

				var_181_0.forward = Vector3.New(var_181_5.x, var_181_5.y, var_181_5.z)

				local var_181_6 = var_181_0.localEulerAngles

				var_181_6.z = 0
				var_181_6.x = 0
				var_181_0.localEulerAngles = var_181_6
			end

			if arg_178_1.time_ >= var_181_1 + var_181_2 and arg_178_1.time_ < var_181_1 + var_181_2 + arg_181_0 then
				var_181_0.localPosition = Vector3.New(0, 100, 0)

				local var_181_7 = manager.ui.mainCamera.transform.position - var_181_0.position

				var_181_0.forward = Vector3.New(var_181_7.x, var_181_7.y, var_181_7.z)

				local var_181_8 = var_181_0.localEulerAngles

				var_181_8.z = 0
				var_181_8.x = 0
				var_181_0.localEulerAngles = var_181_8
			end

			local var_181_9 = 0
			local var_181_10 = 0.525

			if var_181_9 < arg_178_1.time_ and arg_178_1.time_ <= var_181_9 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0
				arg_178_1.dialogCg_.alpha = 1

				arg_178_1.dialog_:SetActive(true)
				SetActive(arg_178_1.leftNameGo_, false)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_178_1.iconTrs_.gameObject, false)
				arg_178_1.callingController_:SetSelectedState("normal")

				local var_181_11 = arg_178_1:GetWordFromCfg(1109701043)
				local var_181_12 = arg_178_1:FormatText(var_181_11.content)

				arg_178_1.text_.text = var_181_12

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_13 = 21
				local var_181_14 = utf8.len(var_181_12)
				local var_181_15 = var_181_13 <= 0 and var_181_10 or var_181_10 * (var_181_14 / var_181_13)

				if var_181_15 > 0 and var_181_10 < var_181_15 then
					arg_178_1.talkMaxDuration = var_181_15

					if var_181_15 + var_181_9 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_15 + var_181_9
					end
				end

				arg_178_1.text_.text = var_181_12
				arg_178_1.typewritter.percent = 0

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(false)
				arg_178_1:RecordContent(arg_178_1.text_.text)
			end

			local var_181_16 = math.max(var_181_10, arg_178_1.talkMaxDuration)

			if var_181_9 <= arg_178_1.time_ and arg_178_1.time_ < var_181_9 + var_181_16 then
				arg_178_1.typewritter.percent = (arg_178_1.time_ - var_181_9) / var_181_16

				arg_178_1.typewritter:SetDirty()
			end

			if arg_178_1.time_ >= var_181_9 + var_181_16 and arg_178_1.time_ < var_181_9 + var_181_16 + arg_181_0 then
				arg_178_1.typewritter.percent = 1

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(true)
			end
		end

		arg_178_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_178_1:InitPlayNodeList()
	end,
	Play1109701044 = function(arg_182_0, arg_182_1)
		arg_182_1.time_ = 0
		arg_182_1.frameCnt_ = 0
		arg_182_1.state_ = "playing"
		arg_182_1.curTalkId_ = 1109701044
		arg_182_1.duration_ = 5

		SetActive(arg_182_1.tipsGo_, false)

		function arg_182_1.onSingleLineFinish_()
			arg_182_1.onSingleLineUpdate_ = nil
			arg_182_1.onSingleLineFinish_ = nil
			arg_182_1.state_ = "waiting"
		end

		function arg_182_1.playNext_(arg_184_0)
			if arg_184_0 == 1 then
				arg_182_0:Play1109701045(arg_182_1)
			end
		end

		function arg_182_1.onSingleLineUpdate_(arg_185_0)
			local var_185_0 = 0
			local var_185_1 = 0.075

			if var_185_0 < arg_182_1.time_ and arg_182_1.time_ <= var_185_0 + arg_185_0 then
				arg_182_1.talkMaxDuration = 0
				arg_182_1.dialogCg_.alpha = 1

				arg_182_1.dialog_:SetActive(true)
				SetActive(arg_182_1.leftNameGo_, true)

				local var_185_2 = arg_182_1:FormatText(StoryNameCfg[7].name)

				arg_182_1.leftNameTxt_.text = var_185_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_182_1.leftNameTxt_.transform)

				arg_182_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_182_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_182_1:RecordName(arg_182_1.leftNameTxt_.text)
				SetActive(arg_182_1.iconTrs_.gameObject, true)
				arg_182_1.iconController_:SetSelectedState("hero")

				arg_182_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_182_1.callingController_:SetSelectedState("normal")

				arg_182_1.keyicon_.color = Color.New(1, 1, 1)
				arg_182_1.icon_.color = Color.New(1, 1, 1)

				local var_185_3 = arg_182_1:GetWordFromCfg(1109701044)
				local var_185_4 = arg_182_1:FormatText(var_185_3.content)

				arg_182_1.text_.text = var_185_4

				LuaForUtil.ClearLinePrefixSymbol(arg_182_1.text_)

				local var_185_5 = 3
				local var_185_6 = utf8.len(var_185_4)
				local var_185_7 = var_185_5 <= 0 and var_185_1 or var_185_1 * (var_185_6 / var_185_5)

				if var_185_7 > 0 and var_185_1 < var_185_7 then
					arg_182_1.talkMaxDuration = var_185_7

					if var_185_7 + var_185_0 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_7 + var_185_0
					end
				end

				arg_182_1.text_.text = var_185_4
				arg_182_1.typewritter.percent = 0

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(false)
				arg_182_1:RecordContent(arg_182_1.text_.text)
			end

			local var_185_8 = math.max(var_185_1, arg_182_1.talkMaxDuration)

			if var_185_0 <= arg_182_1.time_ and arg_182_1.time_ < var_185_0 + var_185_8 then
				arg_182_1.typewritter.percent = (arg_182_1.time_ - var_185_0) / var_185_8

				arg_182_1.typewritter:SetDirty()
			end

			if arg_182_1.time_ >= var_185_0 + var_185_8 and arg_182_1.time_ < var_185_0 + var_185_8 + arg_185_0 then
				arg_182_1.typewritter.percent = 1

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(true)
			end
		end

		arg_182_1.nodeConfigList_ = {}

		arg_182_1:InitPlayNodeList()
	end,
	Play1109701045 = function(arg_186_0, arg_186_1)
		arg_186_1.time_ = 0
		arg_186_1.frameCnt_ = 0
		arg_186_1.state_ = "playing"
		arg_186_1.curTalkId_ = 1109701045
		arg_186_1.duration_ = 5

		SetActive(arg_186_1.tipsGo_, false)

		function arg_186_1.onSingleLineFinish_()
			arg_186_1.onSingleLineUpdate_ = nil
			arg_186_1.onSingleLineFinish_ = nil
			arg_186_1.state_ = "waiting"
		end

		function arg_186_1.playNext_(arg_188_0)
			if arg_188_0 == 1 then
				arg_186_0:Play1109701046(arg_186_1)
			end
		end

		function arg_186_1.onSingleLineUpdate_(arg_189_0)
			local var_189_0 = 0
			local var_189_1 = 0.75

			if var_189_0 < arg_186_1.time_ and arg_186_1.time_ <= var_189_0 + arg_189_0 then
				arg_186_1.talkMaxDuration = 0
				arg_186_1.dialogCg_.alpha = 1

				arg_186_1.dialog_:SetActive(true)
				SetActive(arg_186_1.leftNameGo_, false)

				arg_186_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_186_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_186_1:RecordName(arg_186_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_186_1.iconTrs_.gameObject, false)
				arg_186_1.callingController_:SetSelectedState("normal")

				local var_189_2 = arg_186_1:GetWordFromCfg(1109701045)
				local var_189_3 = arg_186_1:FormatText(var_189_2.content)

				arg_186_1.text_.text = var_189_3

				LuaForUtil.ClearLinePrefixSymbol(arg_186_1.text_)

				local var_189_4 = 30
				local var_189_5 = utf8.len(var_189_3)
				local var_189_6 = var_189_4 <= 0 and var_189_1 or var_189_1 * (var_189_5 / var_189_4)

				if var_189_6 > 0 and var_189_1 < var_189_6 then
					arg_186_1.talkMaxDuration = var_189_6

					if var_189_6 + var_189_0 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_6 + var_189_0
					end
				end

				arg_186_1.text_.text = var_189_3
				arg_186_1.typewritter.percent = 0

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(false)
				arg_186_1:RecordContent(arg_186_1.text_.text)
			end

			local var_189_7 = math.max(var_189_1, arg_186_1.talkMaxDuration)

			if var_189_0 <= arg_186_1.time_ and arg_186_1.time_ < var_189_0 + var_189_7 then
				arg_186_1.typewritter.percent = (arg_186_1.time_ - var_189_0) / var_189_7

				arg_186_1.typewritter:SetDirty()
			end

			if arg_186_1.time_ >= var_189_0 + var_189_7 and arg_186_1.time_ < var_189_0 + var_189_7 + arg_189_0 then
				arg_186_1.typewritter.percent = 1

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(true)
			end
		end

		arg_186_1.nodeConfigList_ = {}

		arg_186_1:InitPlayNodeList()
	end,
	Play1109701046 = function(arg_190_0, arg_190_1)
		arg_190_1.time_ = 0
		arg_190_1.frameCnt_ = 0
		arg_190_1.state_ = "playing"
		arg_190_1.curTalkId_ = 1109701046
		arg_190_1.duration_ = 5

		SetActive(arg_190_1.tipsGo_, false)

		function arg_190_1.onSingleLineFinish_()
			arg_190_1.onSingleLineUpdate_ = nil
			arg_190_1.onSingleLineFinish_ = nil
			arg_190_1.state_ = "waiting"
		end

		function arg_190_1.playNext_(arg_192_0)
			if arg_192_0 == 1 then
				arg_190_0:Play1109701047(arg_190_1)
			end
		end

		function arg_190_1.onSingleLineUpdate_(arg_193_0)
			local var_193_0 = 0
			local var_193_1 = 0.3

			if var_193_0 < arg_190_1.time_ and arg_190_1.time_ <= var_193_0 + arg_193_0 then
				arg_190_1.talkMaxDuration = 0
				arg_190_1.dialogCg_.alpha = 1

				arg_190_1.dialog_:SetActive(true)
				SetActive(arg_190_1.leftNameGo_, true)

				local var_193_2 = arg_190_1:FormatText(StoryNameCfg[7].name)

				arg_190_1.leftNameTxt_.text = var_193_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_190_1.leftNameTxt_.transform)

				arg_190_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_190_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_190_1:RecordName(arg_190_1.leftNameTxt_.text)
				SetActive(arg_190_1.iconTrs_.gameObject, true)
				arg_190_1.iconController_:SetSelectedState("hero")

				arg_190_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_190_1.callingController_:SetSelectedState("normal")

				arg_190_1.keyicon_.color = Color.New(1, 1, 1)
				arg_190_1.icon_.color = Color.New(1, 1, 1)

				local var_193_3 = arg_190_1:GetWordFromCfg(1109701046)
				local var_193_4 = arg_190_1:FormatText(var_193_3.content)

				arg_190_1.text_.text = var_193_4

				LuaForUtil.ClearLinePrefixSymbol(arg_190_1.text_)

				local var_193_5 = 12
				local var_193_6 = utf8.len(var_193_4)
				local var_193_7 = var_193_5 <= 0 and var_193_1 or var_193_1 * (var_193_6 / var_193_5)

				if var_193_7 > 0 and var_193_1 < var_193_7 then
					arg_190_1.talkMaxDuration = var_193_7

					if var_193_7 + var_193_0 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_7 + var_193_0
					end
				end

				arg_190_1.text_.text = var_193_4
				arg_190_1.typewritter.percent = 0

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(false)
				arg_190_1:RecordContent(arg_190_1.text_.text)
			end

			local var_193_8 = math.max(var_193_1, arg_190_1.talkMaxDuration)

			if var_193_0 <= arg_190_1.time_ and arg_190_1.time_ < var_193_0 + var_193_8 then
				arg_190_1.typewritter.percent = (arg_190_1.time_ - var_193_0) / var_193_8

				arg_190_1.typewritter:SetDirty()
			end

			if arg_190_1.time_ >= var_193_0 + var_193_8 and arg_190_1.time_ < var_193_0 + var_193_8 + arg_193_0 then
				arg_190_1.typewritter.percent = 1

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(true)
			end
		end

		arg_190_1.nodeConfigList_ = {}

		arg_190_1:InitPlayNodeList()
	end,
	Play1109701047 = function(arg_194_0, arg_194_1)
		arg_194_1.time_ = 0
		arg_194_1.frameCnt_ = 0
		arg_194_1.state_ = "playing"
		arg_194_1.curTalkId_ = 1109701047
		arg_194_1.duration_ = 5

		SetActive(arg_194_1.tipsGo_, false)

		function arg_194_1.onSingleLineFinish_()
			arg_194_1.onSingleLineUpdate_ = nil
			arg_194_1.onSingleLineFinish_ = nil
			arg_194_1.state_ = "waiting"
		end

		function arg_194_1.playNext_(arg_196_0)
			if arg_196_0 == 1 then
				arg_194_0:Play1109701048(arg_194_1)
			end
		end

		function arg_194_1.onSingleLineUpdate_(arg_197_0)
			local var_197_0 = 0
			local var_197_1 = 1.15

			if var_197_0 < arg_194_1.time_ and arg_194_1.time_ <= var_197_0 + arg_197_0 then
				arg_194_1.talkMaxDuration = 0
				arg_194_1.dialogCg_.alpha = 1

				arg_194_1.dialog_:SetActive(true)
				SetActive(arg_194_1.leftNameGo_, false)

				arg_194_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_194_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_194_1:RecordName(arg_194_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_194_1.iconTrs_.gameObject, false)
				arg_194_1.callingController_:SetSelectedState("normal")

				local var_197_2 = arg_194_1:GetWordFromCfg(1109701047)
				local var_197_3 = arg_194_1:FormatText(var_197_2.content)

				arg_194_1.text_.text = var_197_3

				LuaForUtil.ClearLinePrefixSymbol(arg_194_1.text_)

				local var_197_4 = 46
				local var_197_5 = utf8.len(var_197_3)
				local var_197_6 = var_197_4 <= 0 and var_197_1 or var_197_1 * (var_197_5 / var_197_4)

				if var_197_6 > 0 and var_197_1 < var_197_6 then
					arg_194_1.talkMaxDuration = var_197_6

					if var_197_6 + var_197_0 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_6 + var_197_0
					end
				end

				arg_194_1.text_.text = var_197_3
				arg_194_1.typewritter.percent = 0

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(false)
				arg_194_1:RecordContent(arg_194_1.text_.text)
			end

			local var_197_7 = math.max(var_197_1, arg_194_1.talkMaxDuration)

			if var_197_0 <= arg_194_1.time_ and arg_194_1.time_ < var_197_0 + var_197_7 then
				arg_194_1.typewritter.percent = (arg_194_1.time_ - var_197_0) / var_197_7

				arg_194_1.typewritter:SetDirty()
			end

			if arg_194_1.time_ >= var_197_0 + var_197_7 and arg_194_1.time_ < var_197_0 + var_197_7 + arg_197_0 then
				arg_194_1.typewritter.percent = 1

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(true)
			end
		end

		arg_194_1.nodeConfigList_ = {}

		arg_194_1:InitPlayNodeList()
	end,
	Play1109701048 = function(arg_198_0, arg_198_1)
		arg_198_1.time_ = 0
		arg_198_1.frameCnt_ = 0
		arg_198_1.state_ = "playing"
		arg_198_1.curTalkId_ = 1109701048
		arg_198_1.duration_ = 5.17

		local var_198_0 = {
			zh = 5.166,
			ja = 3.933
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
				arg_198_0:Play1109701049(arg_198_1)
			end
		end

		function arg_198_1.onSingleLineUpdate_(arg_201_0)
			local var_201_0 = arg_198_1.actors_["1097ui_story"].transform
			local var_201_1 = 0

			if var_201_1 < arg_198_1.time_ and arg_198_1.time_ <= var_201_1 + arg_201_0 then
				arg_198_1.var_.moveOldPos1097ui_story = var_201_0.localPosition
			end

			local var_201_2 = 0.001

			if var_201_1 <= arg_198_1.time_ and arg_198_1.time_ < var_201_1 + var_201_2 then
				local var_201_3 = (arg_198_1.time_ - var_201_1) / var_201_2
				local var_201_4 = Vector3.New(0, -0.54, -6.3)

				var_201_0.localPosition = Vector3.Lerp(arg_198_1.var_.moveOldPos1097ui_story, var_201_4, var_201_3)

				local var_201_5 = manager.ui.mainCamera.transform.position - var_201_0.position

				var_201_0.forward = Vector3.New(var_201_5.x, var_201_5.y, var_201_5.z)

				local var_201_6 = var_201_0.localEulerAngles

				var_201_6.z = 0
				var_201_6.x = 0
				var_201_0.localEulerAngles = var_201_6
			end

			if arg_198_1.time_ >= var_201_1 + var_201_2 and arg_198_1.time_ < var_201_1 + var_201_2 + arg_201_0 then
				var_201_0.localPosition = Vector3.New(0, -0.54, -6.3)

				local var_201_7 = manager.ui.mainCamera.transform.position - var_201_0.position

				var_201_0.forward = Vector3.New(var_201_7.x, var_201_7.y, var_201_7.z)

				local var_201_8 = var_201_0.localEulerAngles

				var_201_8.z = 0
				var_201_8.x = 0
				var_201_0.localEulerAngles = var_201_8
			end

			local var_201_9 = arg_198_1.actors_["1097ui_story"]
			local var_201_10 = 0

			if var_201_10 < arg_198_1.time_ and arg_198_1.time_ <= var_201_10 + arg_201_0 and not isNil(var_201_9) and arg_198_1.var_.characterEffect1097ui_story == nil then
				arg_198_1.var_.characterEffect1097ui_story = var_201_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_201_11 = 0.200000002980232

			if var_201_10 <= arg_198_1.time_ and arg_198_1.time_ < var_201_10 + var_201_11 and not isNil(var_201_9) then
				local var_201_12 = (arg_198_1.time_ - var_201_10) / var_201_11

				if arg_198_1.var_.characterEffect1097ui_story and not isNil(var_201_9) then
					arg_198_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_198_1.time_ >= var_201_10 + var_201_11 and arg_198_1.time_ < var_201_10 + var_201_11 + arg_201_0 and not isNil(var_201_9) and arg_198_1.var_.characterEffect1097ui_story then
				arg_198_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_201_13 = 0

			if var_201_13 < arg_198_1.time_ and arg_198_1.time_ <= var_201_13 + arg_201_0 then
				arg_198_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			local var_201_14 = 0

			if var_201_14 < arg_198_1.time_ and arg_198_1.time_ <= var_201_14 + arg_201_0 then
				arg_198_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_201_15 = 0
			local var_201_16 = 0.675

			if var_201_15 < arg_198_1.time_ and arg_198_1.time_ <= var_201_15 + arg_201_0 then
				arg_198_1.talkMaxDuration = 0
				arg_198_1.dialogCg_.alpha = 1

				arg_198_1.dialog_:SetActive(true)
				SetActive(arg_198_1.leftNameGo_, true)

				local var_201_17 = arg_198_1:FormatText(StoryNameCfg[216].name)

				arg_198_1.leftNameTxt_.text = var_201_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_198_1.leftNameTxt_.transform)

				arg_198_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_198_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_198_1:RecordName(arg_198_1.leftNameTxt_.text)
				SetActive(arg_198_1.iconTrs_.gameObject, false)
				arg_198_1.callingController_:SetSelectedState("normal")

				local var_201_18 = arg_198_1:GetWordFromCfg(1109701048)
				local var_201_19 = arg_198_1:FormatText(var_201_18.content)

				arg_198_1.text_.text = var_201_19

				LuaForUtil.ClearLinePrefixSymbol(arg_198_1.text_)

				local var_201_20 = 27
				local var_201_21 = utf8.len(var_201_19)
				local var_201_22 = var_201_20 <= 0 and var_201_16 or var_201_16 * (var_201_21 / var_201_20)

				if var_201_22 > 0 and var_201_16 < var_201_22 then
					arg_198_1.talkMaxDuration = var_201_22

					if var_201_22 + var_201_15 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_22 + var_201_15
					end
				end

				arg_198_1.text_.text = var_201_19
				arg_198_1.typewritter.percent = 0

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701048", "story_v_side_new_1109701.awb") ~= 0 then
					local var_201_23 = manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701048", "story_v_side_new_1109701.awb") / 1000

					if var_201_23 + var_201_15 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_23 + var_201_15
					end

					if var_201_18.prefab_name ~= "" and arg_198_1.actors_[var_201_18.prefab_name] ~= nil then
						local var_201_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_198_1.actors_[var_201_18.prefab_name].transform, "story_v_side_new_1109701", "1109701048", "story_v_side_new_1109701.awb")

						arg_198_1:RecordAudio("1109701048", var_201_24)
						arg_198_1:RecordAudio("1109701048", var_201_24)
					else
						arg_198_1:AudioAction("play", "voice", "story_v_side_new_1109701", "1109701048", "story_v_side_new_1109701.awb")
					end

					arg_198_1:RecordHistoryTalkVoice("story_v_side_new_1109701", "1109701048", "story_v_side_new_1109701.awb")
				end

				arg_198_1:RecordContent(arg_198_1.text_.text)
			end

			local var_201_25 = math.max(var_201_16, arg_198_1.talkMaxDuration)

			if var_201_15 <= arg_198_1.time_ and arg_198_1.time_ < var_201_15 + var_201_25 then
				arg_198_1.typewritter.percent = (arg_198_1.time_ - var_201_15) / var_201_25

				arg_198_1.typewritter:SetDirty()
			end

			if arg_198_1.time_ >= var_201_15 + var_201_25 and arg_198_1.time_ < var_201_15 + var_201_25 + arg_201_0 then
				arg_198_1.typewritter.percent = 1

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(true)
			end
		end

		arg_198_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_198_1:InitPlayNodeList()
	end,
	Play1109701049 = function(arg_202_0, arg_202_1)
		arg_202_1.time_ = 0
		arg_202_1.frameCnt_ = 0
		arg_202_1.state_ = "playing"
		arg_202_1.curTalkId_ = 1109701049
		arg_202_1.duration_ = 5

		SetActive(arg_202_1.tipsGo_, false)

		function arg_202_1.onSingleLineFinish_()
			arg_202_1.onSingleLineUpdate_ = nil
			arg_202_1.onSingleLineFinish_ = nil
			arg_202_1.state_ = "waiting"
		end

		function arg_202_1.playNext_(arg_204_0)
			if arg_204_0 == 1 then
				arg_202_0:Play1109701050(arg_202_1)
			end
		end

		function arg_202_1.onSingleLineUpdate_(arg_205_0)
			local var_205_0 = arg_202_1.actors_["1097ui_story"]
			local var_205_1 = 0

			if var_205_1 < arg_202_1.time_ and arg_202_1.time_ <= var_205_1 + arg_205_0 and not isNil(var_205_0) and arg_202_1.var_.characterEffect1097ui_story == nil then
				arg_202_1.var_.characterEffect1097ui_story = var_205_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_205_2 = 0.200000002980232

			if var_205_1 <= arg_202_1.time_ and arg_202_1.time_ < var_205_1 + var_205_2 and not isNil(var_205_0) then
				local var_205_3 = (arg_202_1.time_ - var_205_1) / var_205_2

				if arg_202_1.var_.characterEffect1097ui_story and not isNil(var_205_0) then
					local var_205_4 = Mathf.Lerp(0, 0.5, var_205_3)

					arg_202_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_202_1.var_.characterEffect1097ui_story.fillRatio = var_205_4
				end
			end

			if arg_202_1.time_ >= var_205_1 + var_205_2 and arg_202_1.time_ < var_205_1 + var_205_2 + arg_205_0 and not isNil(var_205_0) and arg_202_1.var_.characterEffect1097ui_story then
				local var_205_5 = 0.5

				arg_202_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_202_1.var_.characterEffect1097ui_story.fillRatio = var_205_5
			end

			local var_205_6 = 0
			local var_205_7 = 0.4

			if var_205_6 < arg_202_1.time_ and arg_202_1.time_ <= var_205_6 + arg_205_0 then
				arg_202_1.talkMaxDuration = 0
				arg_202_1.dialogCg_.alpha = 1

				arg_202_1.dialog_:SetActive(true)
				SetActive(arg_202_1.leftNameGo_, true)

				local var_205_8 = arg_202_1:FormatText(StoryNameCfg[7].name)

				arg_202_1.leftNameTxt_.text = var_205_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_202_1.leftNameTxt_.transform)

				arg_202_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_202_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_202_1:RecordName(arg_202_1.leftNameTxt_.text)
				SetActive(arg_202_1.iconTrs_.gameObject, true)
				arg_202_1.iconController_:SetSelectedState("hero")

				arg_202_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_202_1.callingController_:SetSelectedState("normal")

				arg_202_1.keyicon_.color = Color.New(1, 1, 1)
				arg_202_1.icon_.color = Color.New(1, 1, 1)

				local var_205_9 = arg_202_1:GetWordFromCfg(1109701049)
				local var_205_10 = arg_202_1:FormatText(var_205_9.content)

				arg_202_1.text_.text = var_205_10

				LuaForUtil.ClearLinePrefixSymbol(arg_202_1.text_)

				local var_205_11 = 16
				local var_205_12 = utf8.len(var_205_10)
				local var_205_13 = var_205_11 <= 0 and var_205_7 or var_205_7 * (var_205_12 / var_205_11)

				if var_205_13 > 0 and var_205_7 < var_205_13 then
					arg_202_1.talkMaxDuration = var_205_13

					if var_205_13 + var_205_6 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_13 + var_205_6
					end
				end

				arg_202_1.text_.text = var_205_10
				arg_202_1.typewritter.percent = 0

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(false)
				arg_202_1:RecordContent(arg_202_1.text_.text)
			end

			local var_205_14 = math.max(var_205_7, arg_202_1.talkMaxDuration)

			if var_205_6 <= arg_202_1.time_ and arg_202_1.time_ < var_205_6 + var_205_14 then
				arg_202_1.typewritter.percent = (arg_202_1.time_ - var_205_6) / var_205_14

				arg_202_1.typewritter:SetDirty()
			end

			if arg_202_1.time_ >= var_205_6 + var_205_14 and arg_202_1.time_ < var_205_6 + var_205_14 + arg_205_0 then
				arg_202_1.typewritter.percent = 1

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(true)
			end
		end

		arg_202_1.nodeConfigList_ = {}

		arg_202_1:InitPlayNodeList()
	end,
	Play1109701050 = function(arg_206_0, arg_206_1)
		arg_206_1.time_ = 0
		arg_206_1.frameCnt_ = 0
		arg_206_1.state_ = "playing"
		arg_206_1.curTalkId_ = 1109701050
		arg_206_1.duration_ = 5

		SetActive(arg_206_1.tipsGo_, false)

		function arg_206_1.onSingleLineFinish_()
			arg_206_1.onSingleLineUpdate_ = nil
			arg_206_1.onSingleLineFinish_ = nil
			arg_206_1.state_ = "waiting"
		end

		function arg_206_1.playNext_(arg_208_0)
			if arg_208_0 == 1 then
				arg_206_0:Play1109701051(arg_206_1)
			end
		end

		function arg_206_1.onSingleLineUpdate_(arg_209_0)
			local var_209_0 = 0
			local var_209_1 = 1.1

			if var_209_0 < arg_206_1.time_ and arg_206_1.time_ <= var_209_0 + arg_209_0 then
				arg_206_1.talkMaxDuration = 0
				arg_206_1.dialogCg_.alpha = 1

				arg_206_1.dialog_:SetActive(true)
				SetActive(arg_206_1.leftNameGo_, false)

				arg_206_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_206_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_206_1:RecordName(arg_206_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_206_1.iconTrs_.gameObject, false)
				arg_206_1.callingController_:SetSelectedState("normal")

				local var_209_2 = arg_206_1:GetWordFromCfg(1109701050)
				local var_209_3 = arg_206_1:FormatText(var_209_2.content)

				arg_206_1.text_.text = var_209_3

				LuaForUtil.ClearLinePrefixSymbol(arg_206_1.text_)

				local var_209_4 = 44
				local var_209_5 = utf8.len(var_209_3)
				local var_209_6 = var_209_4 <= 0 and var_209_1 or var_209_1 * (var_209_5 / var_209_4)

				if var_209_6 > 0 and var_209_1 < var_209_6 then
					arg_206_1.talkMaxDuration = var_209_6

					if var_209_6 + var_209_0 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_6 + var_209_0
					end
				end

				arg_206_1.text_.text = var_209_3
				arg_206_1.typewritter.percent = 0

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(false)
				arg_206_1:RecordContent(arg_206_1.text_.text)
			end

			local var_209_7 = math.max(var_209_1, arg_206_1.talkMaxDuration)

			if var_209_0 <= arg_206_1.time_ and arg_206_1.time_ < var_209_0 + var_209_7 then
				arg_206_1.typewritter.percent = (arg_206_1.time_ - var_209_0) / var_209_7

				arg_206_1.typewritter:SetDirty()
			end

			if arg_206_1.time_ >= var_209_0 + var_209_7 and arg_206_1.time_ < var_209_0 + var_209_7 + arg_209_0 then
				arg_206_1.typewritter.percent = 1

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(true)
			end
		end

		arg_206_1.nodeConfigList_ = {}

		arg_206_1:InitPlayNodeList()
	end,
	Play1109701051 = function(arg_210_0, arg_210_1)
		arg_210_1.time_ = 0
		arg_210_1.frameCnt_ = 0
		arg_210_1.state_ = "playing"
		arg_210_1.curTalkId_ = 1109701051
		arg_210_1.duration_ = 4.7

		local var_210_0 = {
			zh = 4.7,
			ja = 4.2
		}
		local var_210_1 = manager.audio:GetLocalizationFlag()

		if var_210_0[var_210_1] ~= nil then
			arg_210_1.duration_ = var_210_0[var_210_1]
		end

		SetActive(arg_210_1.tipsGo_, false)

		function arg_210_1.onSingleLineFinish_()
			arg_210_1.onSingleLineUpdate_ = nil
			arg_210_1.onSingleLineFinish_ = nil
			arg_210_1.state_ = "waiting"
		end

		function arg_210_1.playNext_(arg_212_0)
			if arg_212_0 == 1 then
				arg_210_0:Play1109701052(arg_210_1)
			end
		end

		function arg_210_1.onSingleLineUpdate_(arg_213_0)
			local var_213_0 = arg_210_1.actors_["1097ui_story"]
			local var_213_1 = 0

			if var_213_1 < arg_210_1.time_ and arg_210_1.time_ <= var_213_1 + arg_213_0 and not isNil(var_213_0) and arg_210_1.var_.characterEffect1097ui_story == nil then
				arg_210_1.var_.characterEffect1097ui_story = var_213_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_213_2 = 0.200000002980232

			if var_213_1 <= arg_210_1.time_ and arg_210_1.time_ < var_213_1 + var_213_2 and not isNil(var_213_0) then
				local var_213_3 = (arg_210_1.time_ - var_213_1) / var_213_2

				if arg_210_1.var_.characterEffect1097ui_story and not isNil(var_213_0) then
					arg_210_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_210_1.time_ >= var_213_1 + var_213_2 and arg_210_1.time_ < var_213_1 + var_213_2 + arg_213_0 and not isNil(var_213_0) and arg_210_1.var_.characterEffect1097ui_story then
				arg_210_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_213_4 = 0

			if var_213_4 < arg_210_1.time_ and arg_210_1.time_ <= var_213_4 + arg_213_0 then
				arg_210_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			local var_213_5 = 0

			if var_213_5 < arg_210_1.time_ and arg_210_1.time_ <= var_213_5 + arg_213_0 then
				arg_210_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_213_6 = 0
			local var_213_7 = 0.3

			if var_213_6 < arg_210_1.time_ and arg_210_1.time_ <= var_213_6 + arg_213_0 then
				arg_210_1.talkMaxDuration = 0
				arg_210_1.dialogCg_.alpha = 1

				arg_210_1.dialog_:SetActive(true)
				SetActive(arg_210_1.leftNameGo_, true)

				local var_213_8 = arg_210_1:FormatText(StoryNameCfg[216].name)

				arg_210_1.leftNameTxt_.text = var_213_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_210_1.leftNameTxt_.transform)

				arg_210_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_210_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_210_1:RecordName(arg_210_1.leftNameTxt_.text)
				SetActive(arg_210_1.iconTrs_.gameObject, false)
				arg_210_1.callingController_:SetSelectedState("normal")

				local var_213_9 = arg_210_1:GetWordFromCfg(1109701051)
				local var_213_10 = arg_210_1:FormatText(var_213_9.content)

				arg_210_1.text_.text = var_213_10

				LuaForUtil.ClearLinePrefixSymbol(arg_210_1.text_)

				local var_213_11 = 12
				local var_213_12 = utf8.len(var_213_10)
				local var_213_13 = var_213_11 <= 0 and var_213_7 or var_213_7 * (var_213_12 / var_213_11)

				if var_213_13 > 0 and var_213_7 < var_213_13 then
					arg_210_1.talkMaxDuration = var_213_13

					if var_213_13 + var_213_6 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_13 + var_213_6
					end
				end

				arg_210_1.text_.text = var_213_10
				arg_210_1.typewritter.percent = 0

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701051", "story_v_side_new_1109701.awb") ~= 0 then
					local var_213_14 = manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701051", "story_v_side_new_1109701.awb") / 1000

					if var_213_14 + var_213_6 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_14 + var_213_6
					end

					if var_213_9.prefab_name ~= "" and arg_210_1.actors_[var_213_9.prefab_name] ~= nil then
						local var_213_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_210_1.actors_[var_213_9.prefab_name].transform, "story_v_side_new_1109701", "1109701051", "story_v_side_new_1109701.awb")

						arg_210_1:RecordAudio("1109701051", var_213_15)
						arg_210_1:RecordAudio("1109701051", var_213_15)
					else
						arg_210_1:AudioAction("play", "voice", "story_v_side_new_1109701", "1109701051", "story_v_side_new_1109701.awb")
					end

					arg_210_1:RecordHistoryTalkVoice("story_v_side_new_1109701", "1109701051", "story_v_side_new_1109701.awb")
				end

				arg_210_1:RecordContent(arg_210_1.text_.text)
			end

			local var_213_16 = math.max(var_213_7, arg_210_1.talkMaxDuration)

			if var_213_6 <= arg_210_1.time_ and arg_210_1.time_ < var_213_6 + var_213_16 then
				arg_210_1.typewritter.percent = (arg_210_1.time_ - var_213_6) / var_213_16

				arg_210_1.typewritter:SetDirty()
			end

			if arg_210_1.time_ >= var_213_6 + var_213_16 and arg_210_1.time_ < var_213_6 + var_213_16 + arg_213_0 then
				arg_210_1.typewritter.percent = 1

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(true)
			end
		end

		arg_210_1.nodeConfigList_ = {}

		arg_210_1:InitPlayNodeList()
	end,
	Play1109701052 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 1109701052
		arg_214_1.duration_ = 5

		SetActive(arg_214_1.tipsGo_, false)

		function arg_214_1.onSingleLineFinish_()
			arg_214_1.onSingleLineUpdate_ = nil
			arg_214_1.onSingleLineFinish_ = nil
			arg_214_1.state_ = "waiting"
		end

		function arg_214_1.playNext_(arg_216_0)
			if arg_216_0 == 1 then
				arg_214_0:Play1109701053(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			local var_217_0 = arg_214_1.actors_["1097ui_story"]
			local var_217_1 = 0

			if var_217_1 < arg_214_1.time_ and arg_214_1.time_ <= var_217_1 + arg_217_0 and not isNil(var_217_0) and arg_214_1.var_.characterEffect1097ui_story == nil then
				arg_214_1.var_.characterEffect1097ui_story = var_217_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_217_2 = 0.200000002980232

			if var_217_1 <= arg_214_1.time_ and arg_214_1.time_ < var_217_1 + var_217_2 and not isNil(var_217_0) then
				local var_217_3 = (arg_214_1.time_ - var_217_1) / var_217_2

				if arg_214_1.var_.characterEffect1097ui_story and not isNil(var_217_0) then
					local var_217_4 = Mathf.Lerp(0, 0.5, var_217_3)

					arg_214_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_214_1.var_.characterEffect1097ui_story.fillRatio = var_217_4
				end
			end

			if arg_214_1.time_ >= var_217_1 + var_217_2 and arg_214_1.time_ < var_217_1 + var_217_2 + arg_217_0 and not isNil(var_217_0) and arg_214_1.var_.characterEffect1097ui_story then
				local var_217_5 = 0.5

				arg_214_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_214_1.var_.characterEffect1097ui_story.fillRatio = var_217_5
			end

			local var_217_6 = 0
			local var_217_7 = 0.175

			if var_217_6 < arg_214_1.time_ and arg_214_1.time_ <= var_217_6 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0
				arg_214_1.dialogCg_.alpha = 1

				arg_214_1.dialog_:SetActive(true)
				SetActive(arg_214_1.leftNameGo_, true)

				local var_217_8 = arg_214_1:FormatText(StoryNameCfg[7].name)

				arg_214_1.leftNameTxt_.text = var_217_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_214_1.leftNameTxt_.transform)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1.leftNameTxt_.text)
				SetActive(arg_214_1.iconTrs_.gameObject, true)
				arg_214_1.iconController_:SetSelectedState("hero")

				arg_214_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_214_1.callingController_:SetSelectedState("normal")

				arg_214_1.keyicon_.color = Color.New(1, 1, 1)
				arg_214_1.icon_.color = Color.New(1, 1, 1)

				local var_217_9 = arg_214_1:GetWordFromCfg(1109701052)
				local var_217_10 = arg_214_1:FormatText(var_217_9.content)

				arg_214_1.text_.text = var_217_10

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_11 = 7
				local var_217_12 = utf8.len(var_217_10)
				local var_217_13 = var_217_11 <= 0 and var_217_7 or var_217_7 * (var_217_12 / var_217_11)

				if var_217_13 > 0 and var_217_7 < var_217_13 then
					arg_214_1.talkMaxDuration = var_217_13

					if var_217_13 + var_217_6 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_13 + var_217_6
					end
				end

				arg_214_1.text_.text = var_217_10
				arg_214_1.typewritter.percent = 0

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(false)
				arg_214_1:RecordContent(arg_214_1.text_.text)
			end

			local var_217_14 = math.max(var_217_7, arg_214_1.talkMaxDuration)

			if var_217_6 <= arg_214_1.time_ and arg_214_1.time_ < var_217_6 + var_217_14 then
				arg_214_1.typewritter.percent = (arg_214_1.time_ - var_217_6) / var_217_14

				arg_214_1.typewritter:SetDirty()
			end

			if arg_214_1.time_ >= var_217_6 + var_217_14 and arg_214_1.time_ < var_217_6 + var_217_14 + arg_217_0 then
				arg_214_1.typewritter.percent = 1

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(true)
			end
		end

		arg_214_1.nodeConfigList_ = {}

		arg_214_1:InitPlayNodeList()
	end,
	Play1109701053 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 1109701053
		arg_218_1.duration_ = 5

		SetActive(arg_218_1.tipsGo_, false)

		function arg_218_1.onSingleLineFinish_()
			arg_218_1.onSingleLineUpdate_ = nil
			arg_218_1.onSingleLineFinish_ = nil
			arg_218_1.state_ = "waiting"
		end

		function arg_218_1.playNext_(arg_220_0)
			if arg_220_0 == 1 then
				arg_218_0:Play1109701054(arg_218_1)
			end
		end

		function arg_218_1.onSingleLineUpdate_(arg_221_0)
			local var_221_0 = 0
			local var_221_1 = 1.15

			if var_221_0 < arg_218_1.time_ and arg_218_1.time_ <= var_221_0 + arg_221_0 then
				arg_218_1.talkMaxDuration = 0
				arg_218_1.dialogCg_.alpha = 1

				arg_218_1.dialog_:SetActive(true)
				SetActive(arg_218_1.leftNameGo_, false)

				arg_218_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_218_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_218_1:RecordName(arg_218_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_218_1.iconTrs_.gameObject, false)
				arg_218_1.callingController_:SetSelectedState("normal")

				local var_221_2 = arg_218_1:GetWordFromCfg(1109701053)
				local var_221_3 = arg_218_1:FormatText(var_221_2.content)

				arg_218_1.text_.text = var_221_3

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_4 = 46
				local var_221_5 = utf8.len(var_221_3)
				local var_221_6 = var_221_4 <= 0 and var_221_1 or var_221_1 * (var_221_5 / var_221_4)

				if var_221_6 > 0 and var_221_1 < var_221_6 then
					arg_218_1.talkMaxDuration = var_221_6

					if var_221_6 + var_221_0 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_6 + var_221_0
					end
				end

				arg_218_1.text_.text = var_221_3
				arg_218_1.typewritter.percent = 0

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(false)
				arg_218_1:RecordContent(arg_218_1.text_.text)
			end

			local var_221_7 = math.max(var_221_1, arg_218_1.talkMaxDuration)

			if var_221_0 <= arg_218_1.time_ and arg_218_1.time_ < var_221_0 + var_221_7 then
				arg_218_1.typewritter.percent = (arg_218_1.time_ - var_221_0) / var_221_7

				arg_218_1.typewritter:SetDirty()
			end

			if arg_218_1.time_ >= var_221_0 + var_221_7 and arg_218_1.time_ < var_221_0 + var_221_7 + arg_221_0 then
				arg_218_1.typewritter.percent = 1

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(true)
			end
		end

		arg_218_1.nodeConfigList_ = {}

		arg_218_1:InitPlayNodeList()
	end,
	Play1109701054 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 1109701054
		arg_222_1.duration_ = 3.63

		local var_222_0 = {
			zh = 2.6,
			ja = 3.633
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
				arg_222_0:Play1109701055(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			local var_225_0 = arg_222_1.actors_["1097ui_story"].transform
			local var_225_1 = 0

			if var_225_1 < arg_222_1.time_ and arg_222_1.time_ <= var_225_1 + arg_225_0 then
				arg_222_1.var_.moveOldPos1097ui_story = var_225_0.localPosition
			end

			local var_225_2 = 0.001

			if var_225_1 <= arg_222_1.time_ and arg_222_1.time_ < var_225_1 + var_225_2 then
				local var_225_3 = (arg_222_1.time_ - var_225_1) / var_225_2
				local var_225_4 = Vector3.New(0, 100, 0)

				var_225_0.localPosition = Vector3.Lerp(arg_222_1.var_.moveOldPos1097ui_story, var_225_4, var_225_3)

				local var_225_5 = manager.ui.mainCamera.transform.position - var_225_0.position

				var_225_0.forward = Vector3.New(var_225_5.x, var_225_5.y, var_225_5.z)

				local var_225_6 = var_225_0.localEulerAngles

				var_225_6.z = 0
				var_225_6.x = 0
				var_225_0.localEulerAngles = var_225_6
			end

			if arg_222_1.time_ >= var_225_1 + var_225_2 and arg_222_1.time_ < var_225_1 + var_225_2 + arg_225_0 then
				var_225_0.localPosition = Vector3.New(0, 100, 0)

				local var_225_7 = manager.ui.mainCamera.transform.position - var_225_0.position

				var_225_0.forward = Vector3.New(var_225_7.x, var_225_7.y, var_225_7.z)

				local var_225_8 = var_225_0.localEulerAngles

				var_225_8.z = 0
				var_225_8.x = 0
				var_225_0.localEulerAngles = var_225_8
			end

			local var_225_9 = arg_222_1.actors_["1097ui_story"]
			local var_225_10 = 0

			if var_225_10 < arg_222_1.time_ and arg_222_1.time_ <= var_225_10 + arg_225_0 and not isNil(var_225_9) and arg_222_1.var_.characterEffect1097ui_story == nil then
				arg_222_1.var_.characterEffect1097ui_story = var_225_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_225_11 = 0.200000002980232

			if var_225_10 <= arg_222_1.time_ and arg_222_1.time_ < var_225_10 + var_225_11 and not isNil(var_225_9) then
				local var_225_12 = (arg_222_1.time_ - var_225_10) / var_225_11

				if arg_222_1.var_.characterEffect1097ui_story and not isNil(var_225_9) then
					local var_225_13 = Mathf.Lerp(0, 0.5, var_225_12)

					arg_222_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_222_1.var_.characterEffect1097ui_story.fillRatio = var_225_13
				end
			end

			if arg_222_1.time_ >= var_225_10 + var_225_11 and arg_222_1.time_ < var_225_10 + var_225_11 + arg_225_0 and not isNil(var_225_9) and arg_222_1.var_.characterEffect1097ui_story then
				local var_225_14 = 0.5

				arg_222_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_222_1.var_.characterEffect1097ui_story.fillRatio = var_225_14
			end

			local var_225_15 = arg_222_1.actors_["6045_story"].transform
			local var_225_16 = 0

			if var_225_16 < arg_222_1.time_ and arg_222_1.time_ <= var_225_16 + arg_225_0 then
				arg_222_1.var_.moveOldPos6045_story = var_225_15.localPosition

				local var_225_17 = GameObjectTools.GetOrAddComponent(var_225_15.gameObject, typeof(DynamicBoneHelper))

				if var_225_17 then
					var_225_17:EnableDynamicBone(false)
				end
			end

			local var_225_18 = 0.001

			if var_225_16 <= arg_222_1.time_ and arg_222_1.time_ < var_225_16 + var_225_18 then
				local var_225_19 = (arg_222_1.time_ - var_225_16) / var_225_18
				local var_225_20 = Vector3.New(-0.7, -0.5, -6.3)

				var_225_15.localPosition = Vector3.Lerp(arg_222_1.var_.moveOldPos6045_story, var_225_20, var_225_19)

				local var_225_21 = manager.ui.mainCamera.transform.position - var_225_15.position

				var_225_15.forward = Vector3.New(var_225_21.x, var_225_21.y, var_225_21.z)

				local var_225_22 = var_225_15.localEulerAngles

				var_225_22.z = 0
				var_225_22.x = 0
				var_225_15.localEulerAngles = var_225_22
			end

			if arg_222_1.time_ >= var_225_16 + var_225_18 and arg_222_1.time_ < var_225_16 + var_225_18 + arg_225_0 then
				var_225_15.localPosition = Vector3.New(-0.7, -0.5, -6.3)

				local var_225_23 = manager.ui.mainCamera.transform.position - var_225_15.position

				var_225_15.forward = Vector3.New(var_225_23.x, var_225_23.y, var_225_23.z)

				local var_225_24 = var_225_15.localEulerAngles

				var_225_24.z = 0
				var_225_24.x = 0
				var_225_15.localEulerAngles = var_225_24

				local var_225_25 = GameObjectTools.GetOrAddComponent(var_225_15.gameObject, typeof(DynamicBoneHelper))

				if var_225_25 then
					var_225_25:EnableDynamicBone(true)
				end
			end

			local var_225_26 = arg_222_1.actors_["6045_story"]
			local var_225_27 = 0

			if var_225_27 < arg_222_1.time_ and arg_222_1.time_ <= var_225_27 + arg_225_0 and not isNil(var_225_26) and arg_222_1.var_.characterEffect6045_story == nil then
				arg_222_1.var_.characterEffect6045_story = var_225_26:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_225_28 = 0.200000002980232

			if var_225_27 <= arg_222_1.time_ and arg_222_1.time_ < var_225_27 + var_225_28 and not isNil(var_225_26) then
				local var_225_29 = (arg_222_1.time_ - var_225_27) / var_225_28

				if arg_222_1.var_.characterEffect6045_story and not isNil(var_225_26) then
					local var_225_30 = Mathf.Lerp(0, 0.5, var_225_29)

					arg_222_1.var_.characterEffect6045_story.fillFlat = true
					arg_222_1.var_.characterEffect6045_story.fillRatio = var_225_30
				end
			end

			if arg_222_1.time_ >= var_225_27 + var_225_28 and arg_222_1.time_ < var_225_27 + var_225_28 + arg_225_0 and not isNil(var_225_26) and arg_222_1.var_.characterEffect6045_story then
				local var_225_31 = 0.5

				arg_222_1.var_.characterEffect6045_story.fillFlat = true
				arg_222_1.var_.characterEffect6045_story.fillRatio = var_225_31
			end

			local var_225_32 = arg_222_1.actors_["6046_story"].transform
			local var_225_33 = 0

			if var_225_33 < arg_222_1.time_ and arg_222_1.time_ <= var_225_33 + arg_225_0 then
				arg_222_1.var_.moveOldPos6046_story = var_225_32.localPosition

				local var_225_34 = GameObjectTools.GetOrAddComponent(var_225_32.gameObject, typeof(DynamicBoneHelper))

				if var_225_34 then
					var_225_34:EnableDynamicBone(false)
				end
			end

			local var_225_35 = 0.001

			if var_225_33 <= arg_222_1.time_ and arg_222_1.time_ < var_225_33 + var_225_35 then
				local var_225_36 = (arg_222_1.time_ - var_225_33) / var_225_35
				local var_225_37 = Vector3.New(0.7, -0.5, -6.3)

				var_225_32.localPosition = Vector3.Lerp(arg_222_1.var_.moveOldPos6046_story, var_225_37, var_225_36)

				local var_225_38 = manager.ui.mainCamera.transform.position - var_225_32.position

				var_225_32.forward = Vector3.New(var_225_38.x, var_225_38.y, var_225_38.z)

				local var_225_39 = var_225_32.localEulerAngles

				var_225_39.z = 0
				var_225_39.x = 0
				var_225_32.localEulerAngles = var_225_39
			end

			if arg_222_1.time_ >= var_225_33 + var_225_35 and arg_222_1.time_ < var_225_33 + var_225_35 + arg_225_0 then
				var_225_32.localPosition = Vector3.New(0.7, -0.5, -6.3)

				local var_225_40 = manager.ui.mainCamera.transform.position - var_225_32.position

				var_225_32.forward = Vector3.New(var_225_40.x, var_225_40.y, var_225_40.z)

				local var_225_41 = var_225_32.localEulerAngles

				var_225_41.z = 0
				var_225_41.x = 0
				var_225_32.localEulerAngles = var_225_41

				local var_225_42 = GameObjectTools.GetOrAddComponent(var_225_32.gameObject, typeof(DynamicBoneHelper))

				if var_225_42 then
					var_225_42:EnableDynamicBone(true)
				end
			end

			local var_225_43 = arg_222_1.actors_["6046_story"]
			local var_225_44 = 0

			if var_225_44 < arg_222_1.time_ and arg_222_1.time_ <= var_225_44 + arg_225_0 and not isNil(var_225_43) and arg_222_1.var_.characterEffect6046_story == nil then
				arg_222_1.var_.characterEffect6046_story = var_225_43:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_225_45 = 0.200000002980232

			if var_225_44 <= arg_222_1.time_ and arg_222_1.time_ < var_225_44 + var_225_45 and not isNil(var_225_43) then
				local var_225_46 = (arg_222_1.time_ - var_225_44) / var_225_45

				if arg_222_1.var_.characterEffect6046_story and not isNil(var_225_43) then
					arg_222_1.var_.characterEffect6046_story.fillFlat = false
				end
			end

			if arg_222_1.time_ >= var_225_44 + var_225_45 and arg_222_1.time_ < var_225_44 + var_225_45 + arg_225_0 and not isNil(var_225_43) and arg_222_1.var_.characterEffect6046_story then
				arg_222_1.var_.characterEffect6046_story.fillFlat = false
			end

			local var_225_47 = 0

			if var_225_47 < arg_222_1.time_ and arg_222_1.time_ <= var_225_47 + arg_225_0 then
				arg_222_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/story6046/story6046action/6046action1_1")
			end

			local var_225_48 = 0

			if var_225_48 < arg_222_1.time_ and arg_222_1.time_ <= var_225_48 + arg_225_0 then
				arg_222_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_225_49 = 0

			if var_225_49 < arg_222_1.time_ and arg_222_1.time_ <= var_225_49 + arg_225_0 then
				arg_222_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/story6045/story6045action/6045action1_1")
			end

			local var_225_50 = 0
			local var_225_51 = 0.225

			if var_225_50 < arg_222_1.time_ and arg_222_1.time_ <= var_225_50 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0
				arg_222_1.dialogCg_.alpha = 1

				arg_222_1.dialog_:SetActive(true)
				SetActive(arg_222_1.leftNameGo_, true)

				local var_225_52 = arg_222_1:FormatText(StoryNameCfg[214].name)

				arg_222_1.leftNameTxt_.text = var_225_52

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_222_1.leftNameTxt_.transform)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1.leftNameTxt_.text)
				SetActive(arg_222_1.iconTrs_.gameObject, false)
				arg_222_1.callingController_:SetSelectedState("normal")

				local var_225_53 = arg_222_1:GetWordFromCfg(1109701054)
				local var_225_54 = arg_222_1:FormatText(var_225_53.content)

				arg_222_1.text_.text = var_225_54

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_55 = 9
				local var_225_56 = utf8.len(var_225_54)
				local var_225_57 = var_225_55 <= 0 and var_225_51 or var_225_51 * (var_225_56 / var_225_55)

				if var_225_57 > 0 and var_225_51 < var_225_57 then
					arg_222_1.talkMaxDuration = var_225_57

					if var_225_57 + var_225_50 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_57 + var_225_50
					end
				end

				arg_222_1.text_.text = var_225_54
				arg_222_1.typewritter.percent = 0

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701054", "story_v_side_new_1109701.awb") ~= 0 then
					local var_225_58 = manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701054", "story_v_side_new_1109701.awb") / 1000

					if var_225_58 + var_225_50 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_58 + var_225_50
					end

					if var_225_53.prefab_name ~= "" and arg_222_1.actors_[var_225_53.prefab_name] ~= nil then
						local var_225_59 = LuaForUtil.PlayVoiceWithCriLipsync(arg_222_1.actors_[var_225_53.prefab_name].transform, "story_v_side_new_1109701", "1109701054", "story_v_side_new_1109701.awb")

						arg_222_1:RecordAudio("1109701054", var_225_59)
						arg_222_1:RecordAudio("1109701054", var_225_59)
					else
						arg_222_1:AudioAction("play", "voice", "story_v_side_new_1109701", "1109701054", "story_v_side_new_1109701.awb")
					end

					arg_222_1:RecordHistoryTalkVoice("story_v_side_new_1109701", "1109701054", "story_v_side_new_1109701.awb")
				end

				arg_222_1:RecordContent(arg_222_1.text_.text)
			end

			local var_225_60 = math.max(var_225_51, arg_222_1.talkMaxDuration)

			if var_225_50 <= arg_222_1.time_ and arg_222_1.time_ < var_225_50 + var_225_60 then
				arg_222_1.typewritter.percent = (arg_222_1.time_ - var_225_50) / var_225_60

				arg_222_1.typewritter:SetDirty()
			end

			if arg_222_1.time_ >= var_225_50 + var_225_60 and arg_222_1.time_ < var_225_50 + var_225_60 + arg_225_0 then
				arg_222_1.typewritter.percent = 1

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(true)
			end
		end

		arg_222_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6045_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6046_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_222_1:InitPlayNodeList()
	end,
	Play1109701055 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 1109701055
		arg_226_1.duration_ = 3.93

		local var_226_0 = {
			zh = 3.3,
			ja = 3.933
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
				arg_226_0:Play1109701056(arg_226_1)
			end
		end

		function arg_226_1.onSingleLineUpdate_(arg_229_0)
			local var_229_0 = arg_226_1.actors_["6045_story"].transform
			local var_229_1 = 0

			if var_229_1 < arg_226_1.time_ and arg_226_1.time_ <= var_229_1 + arg_229_0 then
				arg_226_1.var_.moveOldPos6045_story = var_229_0.localPosition

				local var_229_2 = GameObjectTools.GetOrAddComponent(var_229_0.gameObject, typeof(DynamicBoneHelper))

				if var_229_2 then
					var_229_2:EnableDynamicBone(false)
				end
			end

			local var_229_3 = 0.001

			if var_229_1 <= arg_226_1.time_ and arg_226_1.time_ < var_229_1 + var_229_3 then
				local var_229_4 = (arg_226_1.time_ - var_229_1) / var_229_3
				local var_229_5 = Vector3.New(-0.7, -0.5, -6.3)

				var_229_0.localPosition = Vector3.Lerp(arg_226_1.var_.moveOldPos6045_story, var_229_5, var_229_4)

				local var_229_6 = manager.ui.mainCamera.transform.position - var_229_0.position

				var_229_0.forward = Vector3.New(var_229_6.x, var_229_6.y, var_229_6.z)

				local var_229_7 = var_229_0.localEulerAngles

				var_229_7.z = 0
				var_229_7.x = 0
				var_229_0.localEulerAngles = var_229_7
			end

			if arg_226_1.time_ >= var_229_1 + var_229_3 and arg_226_1.time_ < var_229_1 + var_229_3 + arg_229_0 then
				var_229_0.localPosition = Vector3.New(-0.7, -0.5, -6.3)

				local var_229_8 = manager.ui.mainCamera.transform.position - var_229_0.position

				var_229_0.forward = Vector3.New(var_229_8.x, var_229_8.y, var_229_8.z)

				local var_229_9 = var_229_0.localEulerAngles

				var_229_9.z = 0
				var_229_9.x = 0
				var_229_0.localEulerAngles = var_229_9

				local var_229_10 = GameObjectTools.GetOrAddComponent(var_229_0.gameObject, typeof(DynamicBoneHelper))

				if var_229_10 then
					var_229_10:EnableDynamicBone(true)
				end
			end

			local var_229_11 = arg_226_1.actors_["6045_story"]
			local var_229_12 = 0

			if var_229_12 < arg_226_1.time_ and arg_226_1.time_ <= var_229_12 + arg_229_0 and not isNil(var_229_11) and arg_226_1.var_.characterEffect6045_story == nil then
				arg_226_1.var_.characterEffect6045_story = var_229_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_229_13 = 0.200000002980232

			if var_229_12 <= arg_226_1.time_ and arg_226_1.time_ < var_229_12 + var_229_13 and not isNil(var_229_11) then
				local var_229_14 = (arg_226_1.time_ - var_229_12) / var_229_13

				if arg_226_1.var_.characterEffect6045_story and not isNil(var_229_11) then
					arg_226_1.var_.characterEffect6045_story.fillFlat = false
				end
			end

			if arg_226_1.time_ >= var_229_12 + var_229_13 and arg_226_1.time_ < var_229_12 + var_229_13 + arg_229_0 and not isNil(var_229_11) and arg_226_1.var_.characterEffect6045_story then
				arg_226_1.var_.characterEffect6045_story.fillFlat = false
			end

			local var_229_15 = 0

			if var_229_15 < arg_226_1.time_ and arg_226_1.time_ <= var_229_15 + arg_229_0 then
				arg_226_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/story6045/story6045action/6045action1_1")
			end

			local var_229_16 = 0

			if var_229_16 < arg_226_1.time_ and arg_226_1.time_ <= var_229_16 + arg_229_0 then
				arg_226_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_229_17 = arg_226_1.actors_["6046_story"]
			local var_229_18 = 0

			if var_229_18 < arg_226_1.time_ and arg_226_1.time_ <= var_229_18 + arg_229_0 and not isNil(var_229_17) and arg_226_1.var_.characterEffect6046_story == nil then
				arg_226_1.var_.characterEffect6046_story = var_229_17:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_229_19 = 0.200000002980232

			if var_229_18 <= arg_226_1.time_ and arg_226_1.time_ < var_229_18 + var_229_19 and not isNil(var_229_17) then
				local var_229_20 = (arg_226_1.time_ - var_229_18) / var_229_19

				if arg_226_1.var_.characterEffect6046_story and not isNil(var_229_17) then
					local var_229_21 = Mathf.Lerp(0, 0.5, var_229_20)

					arg_226_1.var_.characterEffect6046_story.fillFlat = true
					arg_226_1.var_.characterEffect6046_story.fillRatio = var_229_21
				end
			end

			if arg_226_1.time_ >= var_229_18 + var_229_19 and arg_226_1.time_ < var_229_18 + var_229_19 + arg_229_0 and not isNil(var_229_17) and arg_226_1.var_.characterEffect6046_story then
				local var_229_22 = 0.5

				arg_226_1.var_.characterEffect6046_story.fillFlat = true
				arg_226_1.var_.characterEffect6046_story.fillRatio = var_229_22
			end

			local var_229_23 = 0
			local var_229_24 = 0.25

			if var_229_23 < arg_226_1.time_ and arg_226_1.time_ <= var_229_23 + arg_229_0 then
				arg_226_1.talkMaxDuration = 0
				arg_226_1.dialogCg_.alpha = 1

				arg_226_1.dialog_:SetActive(true)
				SetActive(arg_226_1.leftNameGo_, true)

				local var_229_25 = arg_226_1:FormatText(StoryNameCfg[215].name)

				arg_226_1.leftNameTxt_.text = var_229_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_226_1.leftNameTxt_.transform)

				arg_226_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_226_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_226_1:RecordName(arg_226_1.leftNameTxt_.text)
				SetActive(arg_226_1.iconTrs_.gameObject, false)
				arg_226_1.callingController_:SetSelectedState("normal")

				local var_229_26 = arg_226_1:GetWordFromCfg(1109701055)
				local var_229_27 = arg_226_1:FormatText(var_229_26.content)

				arg_226_1.text_.text = var_229_27

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_28 = 10
				local var_229_29 = utf8.len(var_229_27)
				local var_229_30 = var_229_28 <= 0 and var_229_24 or var_229_24 * (var_229_29 / var_229_28)

				if var_229_30 > 0 and var_229_24 < var_229_30 then
					arg_226_1.talkMaxDuration = var_229_30

					if var_229_30 + var_229_23 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_30 + var_229_23
					end
				end

				arg_226_1.text_.text = var_229_27
				arg_226_1.typewritter.percent = 0

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701055", "story_v_side_new_1109701.awb") ~= 0 then
					local var_229_31 = manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701055", "story_v_side_new_1109701.awb") / 1000

					if var_229_31 + var_229_23 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_31 + var_229_23
					end

					if var_229_26.prefab_name ~= "" and arg_226_1.actors_[var_229_26.prefab_name] ~= nil then
						local var_229_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_226_1.actors_[var_229_26.prefab_name].transform, "story_v_side_new_1109701", "1109701055", "story_v_side_new_1109701.awb")

						arg_226_1:RecordAudio("1109701055", var_229_32)
						arg_226_1:RecordAudio("1109701055", var_229_32)
					else
						arg_226_1:AudioAction("play", "voice", "story_v_side_new_1109701", "1109701055", "story_v_side_new_1109701.awb")
					end

					arg_226_1:RecordHistoryTalkVoice("story_v_side_new_1109701", "1109701055", "story_v_side_new_1109701.awb")
				end

				arg_226_1:RecordContent(arg_226_1.text_.text)
			end

			local var_229_33 = math.max(var_229_24, arg_226_1.talkMaxDuration)

			if var_229_23 <= arg_226_1.time_ and arg_226_1.time_ < var_229_23 + var_229_33 then
				arg_226_1.typewritter.percent = (arg_226_1.time_ - var_229_23) / var_229_33

				arg_226_1.typewritter:SetDirty()
			end

			if arg_226_1.time_ >= var_229_23 + var_229_33 and arg_226_1.time_ < var_229_23 + var_229_33 + arg_229_0 then
				arg_226_1.typewritter.percent = 1

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(true)
			end
		end

		arg_226_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6045_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_226_1:InitPlayNodeList()
	end,
	Play1109701056 = function(arg_230_0, arg_230_1)
		arg_230_1.time_ = 0
		arg_230_1.frameCnt_ = 0
		arg_230_1.state_ = "playing"
		arg_230_1.curTalkId_ = 1109701056
		arg_230_1.duration_ = 5

		SetActive(arg_230_1.tipsGo_, false)

		function arg_230_1.onSingleLineFinish_()
			arg_230_1.onSingleLineUpdate_ = nil
			arg_230_1.onSingleLineFinish_ = nil
			arg_230_1.state_ = "waiting"
		end

		function arg_230_1.playNext_(arg_232_0)
			if arg_232_0 == 1 then
				arg_230_0:Play1109701057(arg_230_1)
			end
		end

		function arg_230_1.onSingleLineUpdate_(arg_233_0)
			local var_233_0 = arg_230_1.actors_["6045_story"]
			local var_233_1 = 0

			if var_233_1 < arg_230_1.time_ and arg_230_1.time_ <= var_233_1 + arg_233_0 and not isNil(var_233_0) and arg_230_1.var_.characterEffect6045_story == nil then
				arg_230_1.var_.characterEffect6045_story = var_233_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_233_2 = 0.200000002980232

			if var_233_1 <= arg_230_1.time_ and arg_230_1.time_ < var_233_1 + var_233_2 and not isNil(var_233_0) then
				local var_233_3 = (arg_230_1.time_ - var_233_1) / var_233_2

				if arg_230_1.var_.characterEffect6045_story and not isNil(var_233_0) then
					local var_233_4 = Mathf.Lerp(0, 0.5, var_233_3)

					arg_230_1.var_.characterEffect6045_story.fillFlat = true
					arg_230_1.var_.characterEffect6045_story.fillRatio = var_233_4
				end
			end

			if arg_230_1.time_ >= var_233_1 + var_233_2 and arg_230_1.time_ < var_233_1 + var_233_2 + arg_233_0 and not isNil(var_233_0) and arg_230_1.var_.characterEffect6045_story then
				local var_233_5 = 0.5

				arg_230_1.var_.characterEffect6045_story.fillFlat = true
				arg_230_1.var_.characterEffect6045_story.fillRatio = var_233_5
			end

			local var_233_6 = 0
			local var_233_7 = 0.25

			if var_233_6 < arg_230_1.time_ and arg_230_1.time_ <= var_233_6 + arg_233_0 then
				arg_230_1.talkMaxDuration = 0
				arg_230_1.dialogCg_.alpha = 1

				arg_230_1.dialog_:SetActive(true)
				SetActive(arg_230_1.leftNameGo_, true)

				local var_233_8 = arg_230_1:FormatText(StoryNameCfg[7].name)

				arg_230_1.leftNameTxt_.text = var_233_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_230_1.leftNameTxt_.transform)

				arg_230_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_230_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_230_1:RecordName(arg_230_1.leftNameTxt_.text)
				SetActive(arg_230_1.iconTrs_.gameObject, true)
				arg_230_1.iconController_:SetSelectedState("hero")

				arg_230_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_230_1.callingController_:SetSelectedState("normal")

				arg_230_1.keyicon_.color = Color.New(1, 1, 1)
				arg_230_1.icon_.color = Color.New(1, 1, 1)

				local var_233_9 = arg_230_1:GetWordFromCfg(1109701056)
				local var_233_10 = arg_230_1:FormatText(var_233_9.content)

				arg_230_1.text_.text = var_233_10

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_11 = 10
				local var_233_12 = utf8.len(var_233_10)
				local var_233_13 = var_233_11 <= 0 and var_233_7 or var_233_7 * (var_233_12 / var_233_11)

				if var_233_13 > 0 and var_233_7 < var_233_13 then
					arg_230_1.talkMaxDuration = var_233_13

					if var_233_13 + var_233_6 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_13 + var_233_6
					end
				end

				arg_230_1.text_.text = var_233_10
				arg_230_1.typewritter.percent = 0

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(false)
				arg_230_1:RecordContent(arg_230_1.text_.text)
			end

			local var_233_14 = math.max(var_233_7, arg_230_1.talkMaxDuration)

			if var_233_6 <= arg_230_1.time_ and arg_230_1.time_ < var_233_6 + var_233_14 then
				arg_230_1.typewritter.percent = (arg_230_1.time_ - var_233_6) / var_233_14

				arg_230_1.typewritter:SetDirty()
			end

			if arg_230_1.time_ >= var_233_6 + var_233_14 and arg_230_1.time_ < var_233_6 + var_233_14 + arg_233_0 then
				arg_230_1.typewritter.percent = 1

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(true)
			end
		end

		arg_230_1.nodeConfigList_ = {}

		arg_230_1:InitPlayNodeList()
	end,
	Play1109701057 = function(arg_234_0, arg_234_1)
		arg_234_1.time_ = 0
		arg_234_1.frameCnt_ = 0
		arg_234_1.state_ = "playing"
		arg_234_1.curTalkId_ = 1109701057
		arg_234_1.duration_ = 6.37

		local var_234_0 = {
			zh = 6.333,
			ja = 6.366
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
				arg_234_0:Play1109701058(arg_234_1)
			end
		end

		function arg_234_1.onSingleLineUpdate_(arg_237_0)
			local var_237_0 = arg_234_1.actors_["1042ui_story"].transform
			local var_237_1 = 0

			if var_237_1 < arg_234_1.time_ and arg_234_1.time_ <= var_237_1 + arg_237_0 then
				arg_234_1.var_.moveOldPos1042ui_story = var_237_0.localPosition
			end

			local var_237_2 = 0.001

			if var_237_1 <= arg_234_1.time_ and arg_234_1.time_ < var_237_1 + var_237_2 then
				local var_237_3 = (arg_234_1.time_ - var_237_1) / var_237_2
				local var_237_4 = Vector3.New(0, -1.06, -6.2)

				var_237_0.localPosition = Vector3.Lerp(arg_234_1.var_.moveOldPos1042ui_story, var_237_4, var_237_3)

				local var_237_5 = manager.ui.mainCamera.transform.position - var_237_0.position

				var_237_0.forward = Vector3.New(var_237_5.x, var_237_5.y, var_237_5.z)

				local var_237_6 = var_237_0.localEulerAngles

				var_237_6.z = 0
				var_237_6.x = 0
				var_237_0.localEulerAngles = var_237_6
			end

			if arg_234_1.time_ >= var_237_1 + var_237_2 and arg_234_1.time_ < var_237_1 + var_237_2 + arg_237_0 then
				var_237_0.localPosition = Vector3.New(0, -1.06, -6.2)

				local var_237_7 = manager.ui.mainCamera.transform.position - var_237_0.position

				var_237_0.forward = Vector3.New(var_237_7.x, var_237_7.y, var_237_7.z)

				local var_237_8 = var_237_0.localEulerAngles

				var_237_8.z = 0
				var_237_8.x = 0
				var_237_0.localEulerAngles = var_237_8
			end

			local var_237_9 = arg_234_1.actors_["1042ui_story"]
			local var_237_10 = 0

			if var_237_10 < arg_234_1.time_ and arg_234_1.time_ <= var_237_10 + arg_237_0 and not isNil(var_237_9) and arg_234_1.var_.characterEffect1042ui_story == nil then
				arg_234_1.var_.characterEffect1042ui_story = var_237_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_237_11 = 0.200000002980232

			if var_237_10 <= arg_234_1.time_ and arg_234_1.time_ < var_237_10 + var_237_11 and not isNil(var_237_9) then
				local var_237_12 = (arg_234_1.time_ - var_237_10) / var_237_11

				if arg_234_1.var_.characterEffect1042ui_story and not isNil(var_237_9) then
					arg_234_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_234_1.time_ >= var_237_10 + var_237_11 and arg_234_1.time_ < var_237_10 + var_237_11 + arg_237_0 and not isNil(var_237_9) and arg_234_1.var_.characterEffect1042ui_story then
				arg_234_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_237_13 = 0

			if var_237_13 < arg_234_1.time_ and arg_234_1.time_ <= var_237_13 + arg_237_0 then
				arg_234_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action1_1")
			end

			local var_237_14 = 0

			if var_237_14 < arg_234_1.time_ and arg_234_1.time_ <= var_237_14 + arg_237_0 then
				arg_234_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_237_15 = arg_234_1.actors_["6045_story"].transform
			local var_237_16 = 0

			if var_237_16 < arg_234_1.time_ and arg_234_1.time_ <= var_237_16 + arg_237_0 then
				arg_234_1.var_.moveOldPos6045_story = var_237_15.localPosition

				local var_237_17 = GameObjectTools.GetOrAddComponent(var_237_15.gameObject, typeof(DynamicBoneHelper))

				if var_237_17 then
					var_237_17:EnableDynamicBone(false)
				end
			end

			local var_237_18 = 0.001

			if var_237_16 <= arg_234_1.time_ and arg_234_1.time_ < var_237_16 + var_237_18 then
				local var_237_19 = (arg_234_1.time_ - var_237_16) / var_237_18
				local var_237_20 = Vector3.New(0, 100, 0)

				var_237_15.localPosition = Vector3.Lerp(arg_234_1.var_.moveOldPos6045_story, var_237_20, var_237_19)

				local var_237_21 = manager.ui.mainCamera.transform.position - var_237_15.position

				var_237_15.forward = Vector3.New(var_237_21.x, var_237_21.y, var_237_21.z)

				local var_237_22 = var_237_15.localEulerAngles

				var_237_22.z = 0
				var_237_22.x = 0
				var_237_15.localEulerAngles = var_237_22
			end

			if arg_234_1.time_ >= var_237_16 + var_237_18 and arg_234_1.time_ < var_237_16 + var_237_18 + arg_237_0 then
				var_237_15.localPosition = Vector3.New(0, 100, 0)

				local var_237_23 = manager.ui.mainCamera.transform.position - var_237_15.position

				var_237_15.forward = Vector3.New(var_237_23.x, var_237_23.y, var_237_23.z)

				local var_237_24 = var_237_15.localEulerAngles

				var_237_24.z = 0
				var_237_24.x = 0
				var_237_15.localEulerAngles = var_237_24

				local var_237_25 = GameObjectTools.GetOrAddComponent(var_237_15.gameObject, typeof(DynamicBoneHelper))

				if var_237_25 then
					var_237_25:EnableDynamicBone(true)
				end
			end

			local var_237_26 = arg_234_1.actors_["6045_story"]
			local var_237_27 = 0

			if var_237_27 < arg_234_1.time_ and arg_234_1.time_ <= var_237_27 + arg_237_0 and not isNil(var_237_26) and arg_234_1.var_.characterEffect6045_story == nil then
				arg_234_1.var_.characterEffect6045_story = var_237_26:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_237_28 = 0.200000002980232

			if var_237_27 <= arg_234_1.time_ and arg_234_1.time_ < var_237_27 + var_237_28 and not isNil(var_237_26) then
				local var_237_29 = (arg_234_1.time_ - var_237_27) / var_237_28

				if arg_234_1.var_.characterEffect6045_story and not isNil(var_237_26) then
					local var_237_30 = Mathf.Lerp(0, 0.5, var_237_29)

					arg_234_1.var_.characterEffect6045_story.fillFlat = true
					arg_234_1.var_.characterEffect6045_story.fillRatio = var_237_30
				end
			end

			if arg_234_1.time_ >= var_237_27 + var_237_28 and arg_234_1.time_ < var_237_27 + var_237_28 + arg_237_0 and not isNil(var_237_26) and arg_234_1.var_.characterEffect6045_story then
				local var_237_31 = 0.5

				arg_234_1.var_.characterEffect6045_story.fillFlat = true
				arg_234_1.var_.characterEffect6045_story.fillRatio = var_237_31
			end

			local var_237_32 = arg_234_1.actors_["6046_story"].transform
			local var_237_33 = 0

			if var_237_33 < arg_234_1.time_ and arg_234_1.time_ <= var_237_33 + arg_237_0 then
				arg_234_1.var_.moveOldPos6046_story = var_237_32.localPosition

				local var_237_34 = GameObjectTools.GetOrAddComponent(var_237_32.gameObject, typeof(DynamicBoneHelper))

				if var_237_34 then
					var_237_34:EnableDynamicBone(false)
				end
			end

			local var_237_35 = 0.001

			if var_237_33 <= arg_234_1.time_ and arg_234_1.time_ < var_237_33 + var_237_35 then
				local var_237_36 = (arg_234_1.time_ - var_237_33) / var_237_35
				local var_237_37 = Vector3.New(0, 100, 0)

				var_237_32.localPosition = Vector3.Lerp(arg_234_1.var_.moveOldPos6046_story, var_237_37, var_237_36)

				local var_237_38 = manager.ui.mainCamera.transform.position - var_237_32.position

				var_237_32.forward = Vector3.New(var_237_38.x, var_237_38.y, var_237_38.z)

				local var_237_39 = var_237_32.localEulerAngles

				var_237_39.z = 0
				var_237_39.x = 0
				var_237_32.localEulerAngles = var_237_39
			end

			if arg_234_1.time_ >= var_237_33 + var_237_35 and arg_234_1.time_ < var_237_33 + var_237_35 + arg_237_0 then
				var_237_32.localPosition = Vector3.New(0, 100, 0)

				local var_237_40 = manager.ui.mainCamera.transform.position - var_237_32.position

				var_237_32.forward = Vector3.New(var_237_40.x, var_237_40.y, var_237_40.z)

				local var_237_41 = var_237_32.localEulerAngles

				var_237_41.z = 0
				var_237_41.x = 0
				var_237_32.localEulerAngles = var_237_41

				local var_237_42 = GameObjectTools.GetOrAddComponent(var_237_32.gameObject, typeof(DynamicBoneHelper))

				if var_237_42 then
					var_237_42:EnableDynamicBone(true)
				end
			end

			local var_237_43 = arg_234_1.actors_["6046_story"]
			local var_237_44 = 0

			if var_237_44 < arg_234_1.time_ and arg_234_1.time_ <= var_237_44 + arg_237_0 and not isNil(var_237_43) and arg_234_1.var_.characterEffect6046_story == nil then
				arg_234_1.var_.characterEffect6046_story = var_237_43:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_237_45 = 0.200000002980232

			if var_237_44 <= arg_234_1.time_ and arg_234_1.time_ < var_237_44 + var_237_45 and not isNil(var_237_43) then
				local var_237_46 = (arg_234_1.time_ - var_237_44) / var_237_45

				if arg_234_1.var_.characterEffect6046_story and not isNil(var_237_43) then
					local var_237_47 = Mathf.Lerp(0, 0.5, var_237_46)

					arg_234_1.var_.characterEffect6046_story.fillFlat = true
					arg_234_1.var_.characterEffect6046_story.fillRatio = var_237_47
				end
			end

			if arg_234_1.time_ >= var_237_44 + var_237_45 and arg_234_1.time_ < var_237_44 + var_237_45 + arg_237_0 and not isNil(var_237_43) and arg_234_1.var_.characterEffect6046_story then
				local var_237_48 = 0.5

				arg_234_1.var_.characterEffect6046_story.fillFlat = true
				arg_234_1.var_.characterEffect6046_story.fillRatio = var_237_48
			end

			local var_237_49 = 0
			local var_237_50 = 0.8

			if var_237_49 < arg_234_1.time_ and arg_234_1.time_ <= var_237_49 + arg_237_0 then
				arg_234_1.talkMaxDuration = 0
				arg_234_1.dialogCg_.alpha = 1

				arg_234_1.dialog_:SetActive(true)
				SetActive(arg_234_1.leftNameGo_, true)

				local var_237_51 = arg_234_1:FormatText(StoryNameCfg[205].name)

				arg_234_1.leftNameTxt_.text = var_237_51

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_234_1.leftNameTxt_.transform)

				arg_234_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_234_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_234_1:RecordName(arg_234_1.leftNameTxt_.text)
				SetActive(arg_234_1.iconTrs_.gameObject, false)
				arg_234_1.callingController_:SetSelectedState("normal")

				local var_237_52 = arg_234_1:GetWordFromCfg(1109701057)
				local var_237_53 = arg_234_1:FormatText(var_237_52.content)

				arg_234_1.text_.text = var_237_53

				LuaForUtil.ClearLinePrefixSymbol(arg_234_1.text_)

				local var_237_54 = 32
				local var_237_55 = utf8.len(var_237_53)
				local var_237_56 = var_237_54 <= 0 and var_237_50 or var_237_50 * (var_237_55 / var_237_54)

				if var_237_56 > 0 and var_237_50 < var_237_56 then
					arg_234_1.talkMaxDuration = var_237_56

					if var_237_56 + var_237_49 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_56 + var_237_49
					end
				end

				arg_234_1.text_.text = var_237_53
				arg_234_1.typewritter.percent = 0

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701057", "story_v_side_new_1109701.awb") ~= 0 then
					local var_237_57 = manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701057", "story_v_side_new_1109701.awb") / 1000

					if var_237_57 + var_237_49 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_57 + var_237_49
					end

					if var_237_52.prefab_name ~= "" and arg_234_1.actors_[var_237_52.prefab_name] ~= nil then
						local var_237_58 = LuaForUtil.PlayVoiceWithCriLipsync(arg_234_1.actors_[var_237_52.prefab_name].transform, "story_v_side_new_1109701", "1109701057", "story_v_side_new_1109701.awb")

						arg_234_1:RecordAudio("1109701057", var_237_58)
						arg_234_1:RecordAudio("1109701057", var_237_58)
					else
						arg_234_1:AudioAction("play", "voice", "story_v_side_new_1109701", "1109701057", "story_v_side_new_1109701.awb")
					end

					arg_234_1:RecordHistoryTalkVoice("story_v_side_new_1109701", "1109701057", "story_v_side_new_1109701.awb")
				end

				arg_234_1:RecordContent(arg_234_1.text_.text)
			end

			local var_237_59 = math.max(var_237_50, arg_234_1.talkMaxDuration)

			if var_237_49 <= arg_234_1.time_ and arg_234_1.time_ < var_237_49 + var_237_59 then
				arg_234_1.typewritter.percent = (arg_234_1.time_ - var_237_49) / var_237_59

				arg_234_1.typewritter:SetDirty()
			end

			if arg_234_1.time_ >= var_237_49 + var_237_59 and arg_234_1.time_ < var_237_49 + var_237_59 + arg_237_0 then
				arg_234_1.typewritter.percent = 1

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(true)
			end
		end

		arg_234_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6045_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6046_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_234_1:InitPlayNodeList()
	end,
	Play1109701058 = function(arg_238_0, arg_238_1)
		arg_238_1.time_ = 0
		arg_238_1.frameCnt_ = 0
		arg_238_1.state_ = "playing"
		arg_238_1.curTalkId_ = 1109701058
		arg_238_1.duration_ = 5

		SetActive(arg_238_1.tipsGo_, false)

		function arg_238_1.onSingleLineFinish_()
			arg_238_1.onSingleLineUpdate_ = nil
			arg_238_1.onSingleLineFinish_ = nil
			arg_238_1.state_ = "waiting"
		end

		function arg_238_1.playNext_(arg_240_0)
			if arg_240_0 == 1 then
				arg_238_0:Play1109701059(arg_238_1)
			end
		end

		function arg_238_1.onSingleLineUpdate_(arg_241_0)
			local var_241_0 = arg_238_1.actors_["1042ui_story"]
			local var_241_1 = 0

			if var_241_1 < arg_238_1.time_ and arg_238_1.time_ <= var_241_1 + arg_241_0 and not isNil(var_241_0) and arg_238_1.var_.characterEffect1042ui_story == nil then
				arg_238_1.var_.characterEffect1042ui_story = var_241_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_241_2 = 0.200000002980232

			if var_241_1 <= arg_238_1.time_ and arg_238_1.time_ < var_241_1 + var_241_2 and not isNil(var_241_0) then
				local var_241_3 = (arg_238_1.time_ - var_241_1) / var_241_2

				if arg_238_1.var_.characterEffect1042ui_story and not isNil(var_241_0) then
					local var_241_4 = Mathf.Lerp(0, 0.5, var_241_3)

					arg_238_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_238_1.var_.characterEffect1042ui_story.fillRatio = var_241_4
				end
			end

			if arg_238_1.time_ >= var_241_1 + var_241_2 and arg_238_1.time_ < var_241_1 + var_241_2 + arg_241_0 and not isNil(var_241_0) and arg_238_1.var_.characterEffect1042ui_story then
				local var_241_5 = 0.5

				arg_238_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_238_1.var_.characterEffect1042ui_story.fillRatio = var_241_5
			end

			local var_241_6 = 0
			local var_241_7 = 0.575

			if var_241_6 < arg_238_1.time_ and arg_238_1.time_ <= var_241_6 + arg_241_0 then
				arg_238_1.talkMaxDuration = 0
				arg_238_1.dialogCg_.alpha = 1

				arg_238_1.dialog_:SetActive(true)
				SetActive(arg_238_1.leftNameGo_, false)

				arg_238_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_238_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_238_1:RecordName(arg_238_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_238_1.iconTrs_.gameObject, false)
				arg_238_1.callingController_:SetSelectedState("normal")

				local var_241_8 = arg_238_1:GetWordFromCfg(1109701058)
				local var_241_9 = arg_238_1:FormatText(var_241_8.content)

				arg_238_1.text_.text = var_241_9

				LuaForUtil.ClearLinePrefixSymbol(arg_238_1.text_)

				local var_241_10 = 23
				local var_241_11 = utf8.len(var_241_9)
				local var_241_12 = var_241_10 <= 0 and var_241_7 or var_241_7 * (var_241_11 / var_241_10)

				if var_241_12 > 0 and var_241_7 < var_241_12 then
					arg_238_1.talkMaxDuration = var_241_12

					if var_241_12 + var_241_6 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_12 + var_241_6
					end
				end

				arg_238_1.text_.text = var_241_9
				arg_238_1.typewritter.percent = 0

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(false)
				arg_238_1:RecordContent(arg_238_1.text_.text)
			end

			local var_241_13 = math.max(var_241_7, arg_238_1.talkMaxDuration)

			if var_241_6 <= arg_238_1.time_ and arg_238_1.time_ < var_241_6 + var_241_13 then
				arg_238_1.typewritter.percent = (arg_238_1.time_ - var_241_6) / var_241_13

				arg_238_1.typewritter:SetDirty()
			end

			if arg_238_1.time_ >= var_241_6 + var_241_13 and arg_238_1.time_ < var_241_6 + var_241_13 + arg_241_0 then
				arg_238_1.typewritter.percent = 1

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(true)
			end
		end

		arg_238_1.nodeConfigList_ = {}

		arg_238_1:InitPlayNodeList()
	end,
	Play1109701059 = function(arg_242_0, arg_242_1)
		arg_242_1.time_ = 0
		arg_242_1.frameCnt_ = 0
		arg_242_1.state_ = "playing"
		arg_242_1.curTalkId_ = 1109701059
		arg_242_1.duration_ = 7.8

		local var_242_0 = {
			zh = 4.9,
			ja = 7.8
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
				arg_242_0:Play1109701060(arg_242_1)
			end
		end

		function arg_242_1.onSingleLineUpdate_(arg_245_0)
			local var_245_0 = arg_242_1.actors_["1042ui_story"]
			local var_245_1 = 0

			if var_245_1 < arg_242_1.time_ and arg_242_1.time_ <= var_245_1 + arg_245_0 and not isNil(var_245_0) and arg_242_1.var_.characterEffect1042ui_story == nil then
				arg_242_1.var_.characterEffect1042ui_story = var_245_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_245_2 = 0.200000002980232

			if var_245_1 <= arg_242_1.time_ and arg_242_1.time_ < var_245_1 + var_245_2 and not isNil(var_245_0) then
				local var_245_3 = (arg_242_1.time_ - var_245_1) / var_245_2

				if arg_242_1.var_.characterEffect1042ui_story and not isNil(var_245_0) then
					arg_242_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_242_1.time_ >= var_245_1 + var_245_2 and arg_242_1.time_ < var_245_1 + var_245_2 + arg_245_0 and not isNil(var_245_0) and arg_242_1.var_.characterEffect1042ui_story then
				arg_242_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_245_4 = 0

			if var_245_4 < arg_242_1.time_ and arg_242_1.time_ <= var_245_4 + arg_245_0 then
				arg_242_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action8_1")
			end

			local var_245_5 = 0

			if var_245_5 < arg_242_1.time_ and arg_242_1.time_ <= var_245_5 + arg_245_0 then
				arg_242_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_245_6 = 0
			local var_245_7 = 0.65

			if var_245_6 < arg_242_1.time_ and arg_242_1.time_ <= var_245_6 + arg_245_0 then
				arg_242_1.talkMaxDuration = 0
				arg_242_1.dialogCg_.alpha = 1

				arg_242_1.dialog_:SetActive(true)
				SetActive(arg_242_1.leftNameGo_, true)

				local var_245_8 = arg_242_1:FormatText(StoryNameCfg[205].name)

				arg_242_1.leftNameTxt_.text = var_245_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_242_1.leftNameTxt_.transform)

				arg_242_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_242_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_242_1:RecordName(arg_242_1.leftNameTxt_.text)
				SetActive(arg_242_1.iconTrs_.gameObject, false)
				arg_242_1.callingController_:SetSelectedState("normal")

				local var_245_9 = arg_242_1:GetWordFromCfg(1109701059)
				local var_245_10 = arg_242_1:FormatText(var_245_9.content)

				arg_242_1.text_.text = var_245_10

				LuaForUtil.ClearLinePrefixSymbol(arg_242_1.text_)

				local var_245_11 = 26
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

				if manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701059", "story_v_side_new_1109701.awb") ~= 0 then
					local var_245_14 = manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701059", "story_v_side_new_1109701.awb") / 1000

					if var_245_14 + var_245_6 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_14 + var_245_6
					end

					if var_245_9.prefab_name ~= "" and arg_242_1.actors_[var_245_9.prefab_name] ~= nil then
						local var_245_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_242_1.actors_[var_245_9.prefab_name].transform, "story_v_side_new_1109701", "1109701059", "story_v_side_new_1109701.awb")

						arg_242_1:RecordAudio("1109701059", var_245_15)
						arg_242_1:RecordAudio("1109701059", var_245_15)
					else
						arg_242_1:AudioAction("play", "voice", "story_v_side_new_1109701", "1109701059", "story_v_side_new_1109701.awb")
					end

					arg_242_1:RecordHistoryTalkVoice("story_v_side_new_1109701", "1109701059", "story_v_side_new_1109701.awb")
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
	Play1109701060 = function(arg_246_0, arg_246_1)
		arg_246_1.time_ = 0
		arg_246_1.frameCnt_ = 0
		arg_246_1.state_ = "playing"
		arg_246_1.curTalkId_ = 1109701060
		arg_246_1.duration_ = 5

		SetActive(arg_246_1.tipsGo_, false)

		function arg_246_1.onSingleLineFinish_()
			arg_246_1.onSingleLineUpdate_ = nil
			arg_246_1.onSingleLineFinish_ = nil
			arg_246_1.state_ = "waiting"
		end

		function arg_246_1.playNext_(arg_248_0)
			if arg_248_0 == 1 then
				arg_246_0:Play1109701061(arg_246_1)
			end
		end

		function arg_246_1.onSingleLineUpdate_(arg_249_0)
			local var_249_0 = arg_246_1.actors_["1042ui_story"]
			local var_249_1 = 0

			if var_249_1 < arg_246_1.time_ and arg_246_1.time_ <= var_249_1 + arg_249_0 and not isNil(var_249_0) and arg_246_1.var_.characterEffect1042ui_story == nil then
				arg_246_1.var_.characterEffect1042ui_story = var_249_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_249_2 = 0.200000002980232

			if var_249_1 <= arg_246_1.time_ and arg_246_1.time_ < var_249_1 + var_249_2 and not isNil(var_249_0) then
				local var_249_3 = (arg_246_1.time_ - var_249_1) / var_249_2

				if arg_246_1.var_.characterEffect1042ui_story and not isNil(var_249_0) then
					local var_249_4 = Mathf.Lerp(0, 0.5, var_249_3)

					arg_246_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_246_1.var_.characterEffect1042ui_story.fillRatio = var_249_4
				end
			end

			if arg_246_1.time_ >= var_249_1 + var_249_2 and arg_246_1.time_ < var_249_1 + var_249_2 + arg_249_0 and not isNil(var_249_0) and arg_246_1.var_.characterEffect1042ui_story then
				local var_249_5 = 0.5

				arg_246_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_246_1.var_.characterEffect1042ui_story.fillRatio = var_249_5
			end

			local var_249_6 = 0
			local var_249_7 = 0.9

			if var_249_6 < arg_246_1.time_ and arg_246_1.time_ <= var_249_6 + arg_249_0 then
				arg_246_1.talkMaxDuration = 0
				arg_246_1.dialogCg_.alpha = 1

				arg_246_1.dialog_:SetActive(true)
				SetActive(arg_246_1.leftNameGo_, true)

				local var_249_8 = arg_246_1:FormatText(StoryNameCfg[7].name)

				arg_246_1.leftNameTxt_.text = var_249_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_246_1.leftNameTxt_.transform)

				arg_246_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_246_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_246_1:RecordName(arg_246_1.leftNameTxt_.text)
				SetActive(arg_246_1.iconTrs_.gameObject, true)
				arg_246_1.iconController_:SetSelectedState("hero")

				arg_246_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_246_1.callingController_:SetSelectedState("normal")

				arg_246_1.keyicon_.color = Color.New(1, 1, 1)
				arg_246_1.icon_.color = Color.New(1, 1, 1)

				local var_249_9 = arg_246_1:GetWordFromCfg(1109701060)
				local var_249_10 = arg_246_1:FormatText(var_249_9.content)

				arg_246_1.text_.text = var_249_10

				LuaForUtil.ClearLinePrefixSymbol(arg_246_1.text_)

				local var_249_11 = 36
				local var_249_12 = utf8.len(var_249_10)
				local var_249_13 = var_249_11 <= 0 and var_249_7 or var_249_7 * (var_249_12 / var_249_11)

				if var_249_13 > 0 and var_249_7 < var_249_13 then
					arg_246_1.talkMaxDuration = var_249_13

					if var_249_13 + var_249_6 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_13 + var_249_6
					end
				end

				arg_246_1.text_.text = var_249_10
				arg_246_1.typewritter.percent = 0

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(false)
				arg_246_1:RecordContent(arg_246_1.text_.text)
			end

			local var_249_14 = math.max(var_249_7, arg_246_1.talkMaxDuration)

			if var_249_6 <= arg_246_1.time_ and arg_246_1.time_ < var_249_6 + var_249_14 then
				arg_246_1.typewritter.percent = (arg_246_1.time_ - var_249_6) / var_249_14

				arg_246_1.typewritter:SetDirty()
			end

			if arg_246_1.time_ >= var_249_6 + var_249_14 and arg_246_1.time_ < var_249_6 + var_249_14 + arg_249_0 then
				arg_246_1.typewritter.percent = 1

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(true)
			end
		end

		arg_246_1.nodeConfigList_ = {}

		arg_246_1:InitPlayNodeList()
	end,
	Play1109701061 = function(arg_250_0, arg_250_1)
		arg_250_1.time_ = 0
		arg_250_1.frameCnt_ = 0
		arg_250_1.state_ = "playing"
		arg_250_1.curTalkId_ = 1109701061
		arg_250_1.duration_ = 8.57

		local var_250_0 = {
			zh = 6.966,
			ja = 8.566
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
				arg_250_0:Play1109701062(arg_250_1)
			end
		end

		function arg_250_1.onSingleLineUpdate_(arg_253_0)
			local var_253_0 = arg_250_1.actors_["1042ui_story"]
			local var_253_1 = 0

			if var_253_1 < arg_250_1.time_ and arg_250_1.time_ <= var_253_1 + arg_253_0 and not isNil(var_253_0) and arg_250_1.var_.characterEffect1042ui_story == nil then
				arg_250_1.var_.characterEffect1042ui_story = var_253_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_253_2 = 0.200000002980232

			if var_253_1 <= arg_250_1.time_ and arg_250_1.time_ < var_253_1 + var_253_2 and not isNil(var_253_0) then
				local var_253_3 = (arg_250_1.time_ - var_253_1) / var_253_2

				if arg_250_1.var_.characterEffect1042ui_story and not isNil(var_253_0) then
					arg_250_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_250_1.time_ >= var_253_1 + var_253_2 and arg_250_1.time_ < var_253_1 + var_253_2 + arg_253_0 and not isNil(var_253_0) and arg_250_1.var_.characterEffect1042ui_story then
				arg_250_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_253_4 = 0

			if var_253_4 < arg_250_1.time_ and arg_250_1.time_ <= var_253_4 + arg_253_0 then
				arg_250_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action8_2")
			end

			local var_253_5 = 0

			if var_253_5 < arg_250_1.time_ and arg_250_1.time_ <= var_253_5 + arg_253_0 then
				arg_250_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_253_6 = 0
			local var_253_7 = 0.825

			if var_253_6 < arg_250_1.time_ and arg_250_1.time_ <= var_253_6 + arg_253_0 then
				arg_250_1.talkMaxDuration = 0
				arg_250_1.dialogCg_.alpha = 1

				arg_250_1.dialog_:SetActive(true)
				SetActive(arg_250_1.leftNameGo_, true)

				local var_253_8 = arg_250_1:FormatText(StoryNameCfg[205].name)

				arg_250_1.leftNameTxt_.text = var_253_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_250_1.leftNameTxt_.transform)

				arg_250_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_250_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_250_1:RecordName(arg_250_1.leftNameTxt_.text)
				SetActive(arg_250_1.iconTrs_.gameObject, false)
				arg_250_1.callingController_:SetSelectedState("normal")

				local var_253_9 = arg_250_1:GetWordFromCfg(1109701061)
				local var_253_10 = arg_250_1:FormatText(var_253_9.content)

				arg_250_1.text_.text = var_253_10

				LuaForUtil.ClearLinePrefixSymbol(arg_250_1.text_)

				local var_253_11 = 33
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

				if manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701061", "story_v_side_new_1109701.awb") ~= 0 then
					local var_253_14 = manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701061", "story_v_side_new_1109701.awb") / 1000

					if var_253_14 + var_253_6 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_14 + var_253_6
					end

					if var_253_9.prefab_name ~= "" and arg_250_1.actors_[var_253_9.prefab_name] ~= nil then
						local var_253_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_250_1.actors_[var_253_9.prefab_name].transform, "story_v_side_new_1109701", "1109701061", "story_v_side_new_1109701.awb")

						arg_250_1:RecordAudio("1109701061", var_253_15)
						arg_250_1:RecordAudio("1109701061", var_253_15)
					else
						arg_250_1:AudioAction("play", "voice", "story_v_side_new_1109701", "1109701061", "story_v_side_new_1109701.awb")
					end

					arg_250_1:RecordHistoryTalkVoice("story_v_side_new_1109701", "1109701061", "story_v_side_new_1109701.awb")
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
	Play1109701062 = function(arg_254_0, arg_254_1)
		arg_254_1.time_ = 0
		arg_254_1.frameCnt_ = 0
		arg_254_1.state_ = "playing"
		arg_254_1.curTalkId_ = 1109701062
		arg_254_1.duration_ = 5

		SetActive(arg_254_1.tipsGo_, false)

		function arg_254_1.onSingleLineFinish_()
			arg_254_1.onSingleLineUpdate_ = nil
			arg_254_1.onSingleLineFinish_ = nil
			arg_254_1.state_ = "waiting"
		end

		function arg_254_1.playNext_(arg_256_0)
			if arg_256_0 == 1 then
				arg_254_0:Play1109701063(arg_254_1)
			end
		end

		function arg_254_1.onSingleLineUpdate_(arg_257_0)
			local var_257_0 = arg_254_1.actors_["1042ui_story"]
			local var_257_1 = 0

			if var_257_1 < arg_254_1.time_ and arg_254_1.time_ <= var_257_1 + arg_257_0 and not isNil(var_257_0) and arg_254_1.var_.characterEffect1042ui_story == nil then
				arg_254_1.var_.characterEffect1042ui_story = var_257_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_257_2 = 0.200000002980232

			if var_257_1 <= arg_254_1.time_ and arg_254_1.time_ < var_257_1 + var_257_2 and not isNil(var_257_0) then
				local var_257_3 = (arg_254_1.time_ - var_257_1) / var_257_2

				if arg_254_1.var_.characterEffect1042ui_story and not isNil(var_257_0) then
					local var_257_4 = Mathf.Lerp(0, 0.5, var_257_3)

					arg_254_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_254_1.var_.characterEffect1042ui_story.fillRatio = var_257_4
				end
			end

			if arg_254_1.time_ >= var_257_1 + var_257_2 and arg_254_1.time_ < var_257_1 + var_257_2 + arg_257_0 and not isNil(var_257_0) and arg_254_1.var_.characterEffect1042ui_story then
				local var_257_5 = 0.5

				arg_254_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_254_1.var_.characterEffect1042ui_story.fillRatio = var_257_5
			end

			local var_257_6 = 0
			local var_257_7 = 0.475

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

				local var_257_9 = arg_254_1:GetWordFromCfg(1109701062)
				local var_257_10 = arg_254_1:FormatText(var_257_9.content)

				arg_254_1.text_.text = var_257_10

				LuaForUtil.ClearLinePrefixSymbol(arg_254_1.text_)

				local var_257_11 = 19
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
	Play1109701063 = function(arg_258_0, arg_258_1)
		arg_258_1.time_ = 0
		arg_258_1.frameCnt_ = 0
		arg_258_1.state_ = "playing"
		arg_258_1.curTalkId_ = 1109701063
		arg_258_1.duration_ = 4.5

		local var_258_0 = {
			zh = 4.5,
			ja = 3.933
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
		end

		function arg_258_1.playNext_(arg_260_0)
			if arg_260_0 == 1 then
				arg_258_0:Play1109701064(arg_258_1)
			end
		end

		function arg_258_1.onSingleLineUpdate_(arg_261_0)
			local var_261_0 = arg_258_1.actors_["1097ui_story"].transform
			local var_261_1 = 0

			if var_261_1 < arg_258_1.time_ and arg_258_1.time_ <= var_261_1 + arg_261_0 then
				arg_258_1.var_.moveOldPos1097ui_story = var_261_0.localPosition
			end

			local var_261_2 = 0.001

			if var_261_1 <= arg_258_1.time_ and arg_258_1.time_ < var_261_1 + var_261_2 then
				local var_261_3 = (arg_258_1.time_ - var_261_1) / var_261_2
				local var_261_4 = Vector3.New(0, -0.54, -6.3)

				var_261_0.localPosition = Vector3.Lerp(arg_258_1.var_.moveOldPos1097ui_story, var_261_4, var_261_3)

				local var_261_5 = manager.ui.mainCamera.transform.position - var_261_0.position

				var_261_0.forward = Vector3.New(var_261_5.x, var_261_5.y, var_261_5.z)

				local var_261_6 = var_261_0.localEulerAngles

				var_261_6.z = 0
				var_261_6.x = 0
				var_261_0.localEulerAngles = var_261_6
			end

			if arg_258_1.time_ >= var_261_1 + var_261_2 and arg_258_1.time_ < var_261_1 + var_261_2 + arg_261_0 then
				var_261_0.localPosition = Vector3.New(0, -0.54, -6.3)

				local var_261_7 = manager.ui.mainCamera.transform.position - var_261_0.position

				var_261_0.forward = Vector3.New(var_261_7.x, var_261_7.y, var_261_7.z)

				local var_261_8 = var_261_0.localEulerAngles

				var_261_8.z = 0
				var_261_8.x = 0
				var_261_0.localEulerAngles = var_261_8
			end

			local var_261_9 = arg_258_1.actors_["1097ui_story"]
			local var_261_10 = 0

			if var_261_10 < arg_258_1.time_ and arg_258_1.time_ <= var_261_10 + arg_261_0 and not isNil(var_261_9) and arg_258_1.var_.characterEffect1097ui_story == nil then
				arg_258_1.var_.characterEffect1097ui_story = var_261_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_261_11 = 0.200000002980232

			if var_261_10 <= arg_258_1.time_ and arg_258_1.time_ < var_261_10 + var_261_11 and not isNil(var_261_9) then
				local var_261_12 = (arg_258_1.time_ - var_261_10) / var_261_11

				if arg_258_1.var_.characterEffect1097ui_story and not isNil(var_261_9) then
					arg_258_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_258_1.time_ >= var_261_10 + var_261_11 and arg_258_1.time_ < var_261_10 + var_261_11 + arg_261_0 and not isNil(var_261_9) and arg_258_1.var_.characterEffect1097ui_story then
				arg_258_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_261_13 = 0

			if var_261_13 < arg_258_1.time_ and arg_258_1.time_ <= var_261_13 + arg_261_0 then
				arg_258_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			local var_261_14 = 0

			if var_261_14 < arg_258_1.time_ and arg_258_1.time_ <= var_261_14 + arg_261_0 then
				arg_258_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_261_15 = arg_258_1.actors_["1042ui_story"].transform
			local var_261_16 = 0

			if var_261_16 < arg_258_1.time_ and arg_258_1.time_ <= var_261_16 + arg_261_0 then
				arg_258_1.var_.moveOldPos1042ui_story = var_261_15.localPosition
			end

			local var_261_17 = 0.001

			if var_261_16 <= arg_258_1.time_ and arg_258_1.time_ < var_261_16 + var_261_17 then
				local var_261_18 = (arg_258_1.time_ - var_261_16) / var_261_17
				local var_261_19 = Vector3.New(0, 100, 0)

				var_261_15.localPosition = Vector3.Lerp(arg_258_1.var_.moveOldPos1042ui_story, var_261_19, var_261_18)

				local var_261_20 = manager.ui.mainCamera.transform.position - var_261_15.position

				var_261_15.forward = Vector3.New(var_261_20.x, var_261_20.y, var_261_20.z)

				local var_261_21 = var_261_15.localEulerAngles

				var_261_21.z = 0
				var_261_21.x = 0
				var_261_15.localEulerAngles = var_261_21
			end

			if arg_258_1.time_ >= var_261_16 + var_261_17 and arg_258_1.time_ < var_261_16 + var_261_17 + arg_261_0 then
				var_261_15.localPosition = Vector3.New(0, 100, 0)

				local var_261_22 = manager.ui.mainCamera.transform.position - var_261_15.position

				var_261_15.forward = Vector3.New(var_261_22.x, var_261_22.y, var_261_22.z)

				local var_261_23 = var_261_15.localEulerAngles

				var_261_23.z = 0
				var_261_23.x = 0
				var_261_15.localEulerAngles = var_261_23
			end

			local var_261_24 = arg_258_1.actors_["1042ui_story"]
			local var_261_25 = 0

			if var_261_25 < arg_258_1.time_ and arg_258_1.time_ <= var_261_25 + arg_261_0 and not isNil(var_261_24) and arg_258_1.var_.characterEffect1042ui_story == nil then
				arg_258_1.var_.characterEffect1042ui_story = var_261_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_261_26 = 0.200000002980232

			if var_261_25 <= arg_258_1.time_ and arg_258_1.time_ < var_261_25 + var_261_26 and not isNil(var_261_24) then
				local var_261_27 = (arg_258_1.time_ - var_261_25) / var_261_26

				if arg_258_1.var_.characterEffect1042ui_story and not isNil(var_261_24) then
					local var_261_28 = Mathf.Lerp(0, 0.5, var_261_27)

					arg_258_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_258_1.var_.characterEffect1042ui_story.fillRatio = var_261_28
				end
			end

			if arg_258_1.time_ >= var_261_25 + var_261_26 and arg_258_1.time_ < var_261_25 + var_261_26 + arg_261_0 and not isNil(var_261_24) and arg_258_1.var_.characterEffect1042ui_story then
				local var_261_29 = 0.5

				arg_258_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_258_1.var_.characterEffect1042ui_story.fillRatio = var_261_29
			end

			local var_261_30 = 0
			local var_261_31 = 0.6

			if var_261_30 < arg_258_1.time_ and arg_258_1.time_ <= var_261_30 + arg_261_0 then
				arg_258_1.talkMaxDuration = 0
				arg_258_1.dialogCg_.alpha = 1

				arg_258_1.dialog_:SetActive(true)
				SetActive(arg_258_1.leftNameGo_, true)

				local var_261_32 = arg_258_1:FormatText(StoryNameCfg[216].name)

				arg_258_1.leftNameTxt_.text = var_261_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_258_1.leftNameTxt_.transform)

				arg_258_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_258_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_258_1:RecordName(arg_258_1.leftNameTxt_.text)
				SetActive(arg_258_1.iconTrs_.gameObject, false)
				arg_258_1.callingController_:SetSelectedState("normal")

				local var_261_33 = arg_258_1:GetWordFromCfg(1109701063)
				local var_261_34 = arg_258_1:FormatText(var_261_33.content)

				arg_258_1.text_.text = var_261_34

				LuaForUtil.ClearLinePrefixSymbol(arg_258_1.text_)

				local var_261_35 = 24
				local var_261_36 = utf8.len(var_261_34)
				local var_261_37 = var_261_35 <= 0 and var_261_31 or var_261_31 * (var_261_36 / var_261_35)

				if var_261_37 > 0 and var_261_31 < var_261_37 then
					arg_258_1.talkMaxDuration = var_261_37

					if var_261_37 + var_261_30 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_37 + var_261_30
					end
				end

				arg_258_1.text_.text = var_261_34
				arg_258_1.typewritter.percent = 0

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701063", "story_v_side_new_1109701.awb") ~= 0 then
					local var_261_38 = manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701063", "story_v_side_new_1109701.awb") / 1000

					if var_261_38 + var_261_30 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_38 + var_261_30
					end

					if var_261_33.prefab_name ~= "" and arg_258_1.actors_[var_261_33.prefab_name] ~= nil then
						local var_261_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_258_1.actors_[var_261_33.prefab_name].transform, "story_v_side_new_1109701", "1109701063", "story_v_side_new_1109701.awb")

						arg_258_1:RecordAudio("1109701063", var_261_39)
						arg_258_1:RecordAudio("1109701063", var_261_39)
					else
						arg_258_1:AudioAction("play", "voice", "story_v_side_new_1109701", "1109701063", "story_v_side_new_1109701.awb")
					end

					arg_258_1:RecordHistoryTalkVoice("story_v_side_new_1109701", "1109701063", "story_v_side_new_1109701.awb")
				end

				arg_258_1:RecordContent(arg_258_1.text_.text)
			end

			local var_261_40 = math.max(var_261_31, arg_258_1.talkMaxDuration)

			if var_261_30 <= arg_258_1.time_ and arg_258_1.time_ < var_261_30 + var_261_40 then
				arg_258_1.typewritter.percent = (arg_258_1.time_ - var_261_30) / var_261_40

				arg_258_1.typewritter:SetDirty()
			end

			if arg_258_1.time_ >= var_261_30 + var_261_40 and arg_258_1.time_ < var_261_30 + var_261_40 + arg_261_0 then
				arg_258_1.typewritter.percent = 1

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(true)
			end
		end

		arg_258_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_258_1:InitPlayNodeList()
	end,
	Play1109701064 = function(arg_262_0, arg_262_1)
		arg_262_1.time_ = 0
		arg_262_1.frameCnt_ = 0
		arg_262_1.state_ = "playing"
		arg_262_1.curTalkId_ = 1109701064
		arg_262_1.duration_ = 5

		SetActive(arg_262_1.tipsGo_, false)

		function arg_262_1.onSingleLineFinish_()
			arg_262_1.onSingleLineUpdate_ = nil
			arg_262_1.onSingleLineFinish_ = nil
			arg_262_1.state_ = "waiting"
		end

		function arg_262_1.playNext_(arg_264_0)
			if arg_264_0 == 1 then
				arg_262_0:Play1109701065(arg_262_1)
			end
		end

		function arg_262_1.onSingleLineUpdate_(arg_265_0)
			local var_265_0 = arg_262_1.actors_["1097ui_story"]
			local var_265_1 = 0

			if var_265_1 < arg_262_1.time_ and arg_262_1.time_ <= var_265_1 + arg_265_0 and not isNil(var_265_0) and arg_262_1.var_.characterEffect1097ui_story == nil then
				arg_262_1.var_.characterEffect1097ui_story = var_265_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_265_2 = 0.200000002980232

			if var_265_1 <= arg_262_1.time_ and arg_262_1.time_ < var_265_1 + var_265_2 and not isNil(var_265_0) then
				local var_265_3 = (arg_262_1.time_ - var_265_1) / var_265_2

				if arg_262_1.var_.characterEffect1097ui_story and not isNil(var_265_0) then
					local var_265_4 = Mathf.Lerp(0, 0.5, var_265_3)

					arg_262_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_262_1.var_.characterEffect1097ui_story.fillRatio = var_265_4
				end
			end

			if arg_262_1.time_ >= var_265_1 + var_265_2 and arg_262_1.time_ < var_265_1 + var_265_2 + arg_265_0 and not isNil(var_265_0) and arg_262_1.var_.characterEffect1097ui_story then
				local var_265_5 = 0.5

				arg_262_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_262_1.var_.characterEffect1097ui_story.fillRatio = var_265_5
			end

			local var_265_6 = 0
			local var_265_7 = 0.5

			if var_265_6 < arg_262_1.time_ and arg_262_1.time_ <= var_265_6 + arg_265_0 then
				arg_262_1.talkMaxDuration = 0
				arg_262_1.dialogCg_.alpha = 1

				arg_262_1.dialog_:SetActive(true)
				SetActive(arg_262_1.leftNameGo_, true)

				local var_265_8 = arg_262_1:FormatText(StoryNameCfg[7].name)

				arg_262_1.leftNameTxt_.text = var_265_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_262_1.leftNameTxt_.transform)

				arg_262_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_262_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_262_1:RecordName(arg_262_1.leftNameTxt_.text)
				SetActive(arg_262_1.iconTrs_.gameObject, true)
				arg_262_1.iconController_:SetSelectedState("hero")

				arg_262_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_262_1.callingController_:SetSelectedState("normal")

				arg_262_1.keyicon_.color = Color.New(1, 1, 1)
				arg_262_1.icon_.color = Color.New(1, 1, 1)

				local var_265_9 = arg_262_1:GetWordFromCfg(1109701064)
				local var_265_10 = arg_262_1:FormatText(var_265_9.content)

				arg_262_1.text_.text = var_265_10

				LuaForUtil.ClearLinePrefixSymbol(arg_262_1.text_)

				local var_265_11 = 20
				local var_265_12 = utf8.len(var_265_10)
				local var_265_13 = var_265_11 <= 0 and var_265_7 or var_265_7 * (var_265_12 / var_265_11)

				if var_265_13 > 0 and var_265_7 < var_265_13 then
					arg_262_1.talkMaxDuration = var_265_13

					if var_265_13 + var_265_6 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_13 + var_265_6
					end
				end

				arg_262_1.text_.text = var_265_10
				arg_262_1.typewritter.percent = 0

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(false)
				arg_262_1:RecordContent(arg_262_1.text_.text)
			end

			local var_265_14 = math.max(var_265_7, arg_262_1.talkMaxDuration)

			if var_265_6 <= arg_262_1.time_ and arg_262_1.time_ < var_265_6 + var_265_14 then
				arg_262_1.typewritter.percent = (arg_262_1.time_ - var_265_6) / var_265_14

				arg_262_1.typewritter:SetDirty()
			end

			if arg_262_1.time_ >= var_265_6 + var_265_14 and arg_262_1.time_ < var_265_6 + var_265_14 + arg_265_0 then
				arg_262_1.typewritter.percent = 1

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(true)
			end
		end

		arg_262_1.nodeConfigList_ = {}

		arg_262_1:InitPlayNodeList()
	end,
	Play1109701065 = function(arg_266_0, arg_266_1)
		arg_266_1.time_ = 0
		arg_266_1.frameCnt_ = 0
		arg_266_1.state_ = "playing"
		arg_266_1.curTalkId_ = 1109701065
		arg_266_1.duration_ = 5.23

		local var_266_0 = {
			zh = 5.233,
			ja = 1.999999999999
		}
		local var_266_1 = manager.audio:GetLocalizationFlag()

		if var_266_0[var_266_1] ~= nil then
			arg_266_1.duration_ = var_266_0[var_266_1]
		end

		SetActive(arg_266_1.tipsGo_, false)

		function arg_266_1.onSingleLineFinish_()
			arg_266_1.onSingleLineUpdate_ = nil
			arg_266_1.onSingleLineFinish_ = nil
			arg_266_1.state_ = "waiting"
		end

		function arg_266_1.playNext_(arg_268_0)
			if arg_268_0 == 1 then
				arg_266_0:Play1109701066(arg_266_1)
			end
		end

		function arg_266_1.onSingleLineUpdate_(arg_269_0)
			local var_269_0 = arg_266_1.actors_["1097ui_story"].transform
			local var_269_1 = 0

			if var_269_1 < arg_266_1.time_ and arg_266_1.time_ <= var_269_1 + arg_269_0 then
				arg_266_1.var_.moveOldPos1097ui_story = var_269_0.localPosition
			end

			local var_269_2 = 0.001

			if var_269_1 <= arg_266_1.time_ and arg_266_1.time_ < var_269_1 + var_269_2 then
				local var_269_3 = (arg_266_1.time_ - var_269_1) / var_269_2
				local var_269_4 = Vector3.New(0, -0.54, -6.3)

				var_269_0.localPosition = Vector3.Lerp(arg_266_1.var_.moveOldPos1097ui_story, var_269_4, var_269_3)

				local var_269_5 = manager.ui.mainCamera.transform.position - var_269_0.position

				var_269_0.forward = Vector3.New(var_269_5.x, var_269_5.y, var_269_5.z)

				local var_269_6 = var_269_0.localEulerAngles

				var_269_6.z = 0
				var_269_6.x = 0
				var_269_0.localEulerAngles = var_269_6
			end

			if arg_266_1.time_ >= var_269_1 + var_269_2 and arg_266_1.time_ < var_269_1 + var_269_2 + arg_269_0 then
				var_269_0.localPosition = Vector3.New(0, -0.54, -6.3)

				local var_269_7 = manager.ui.mainCamera.transform.position - var_269_0.position

				var_269_0.forward = Vector3.New(var_269_7.x, var_269_7.y, var_269_7.z)

				local var_269_8 = var_269_0.localEulerAngles

				var_269_8.z = 0
				var_269_8.x = 0
				var_269_0.localEulerAngles = var_269_8
			end

			local var_269_9 = arg_266_1.actors_["1097ui_story"]
			local var_269_10 = 0

			if var_269_10 < arg_266_1.time_ and arg_266_1.time_ <= var_269_10 + arg_269_0 and not isNil(var_269_9) and arg_266_1.var_.characterEffect1097ui_story == nil then
				arg_266_1.var_.characterEffect1097ui_story = var_269_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_269_11 = 0.200000002980232

			if var_269_10 <= arg_266_1.time_ and arg_266_1.time_ < var_269_10 + var_269_11 and not isNil(var_269_9) then
				local var_269_12 = (arg_266_1.time_ - var_269_10) / var_269_11

				if arg_266_1.var_.characterEffect1097ui_story and not isNil(var_269_9) then
					arg_266_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_266_1.time_ >= var_269_10 + var_269_11 and arg_266_1.time_ < var_269_10 + var_269_11 + arg_269_0 and not isNil(var_269_9) and arg_266_1.var_.characterEffect1097ui_story then
				arg_266_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_269_13 = 0

			if var_269_13 < arg_266_1.time_ and arg_266_1.time_ <= var_269_13 + arg_269_0 then
				arg_266_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_269_14 = 0

			if var_269_14 < arg_266_1.time_ and arg_266_1.time_ <= var_269_14 + arg_269_0 then
				arg_266_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_269_15 = 0
			local var_269_16 = 0.6

			if var_269_15 < arg_266_1.time_ and arg_266_1.time_ <= var_269_15 + arg_269_0 then
				arg_266_1.talkMaxDuration = 0
				arg_266_1.dialogCg_.alpha = 1

				arg_266_1.dialog_:SetActive(true)
				SetActive(arg_266_1.leftNameGo_, true)

				local var_269_17 = arg_266_1:FormatText(StoryNameCfg[216].name)

				arg_266_1.leftNameTxt_.text = var_269_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_266_1.leftNameTxt_.transform)

				arg_266_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_266_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_266_1:RecordName(arg_266_1.leftNameTxt_.text)
				SetActive(arg_266_1.iconTrs_.gameObject, false)
				arg_266_1.callingController_:SetSelectedState("normal")

				local var_269_18 = arg_266_1:GetWordFromCfg(1109701065)
				local var_269_19 = arg_266_1:FormatText(var_269_18.content)

				arg_266_1.text_.text = var_269_19

				LuaForUtil.ClearLinePrefixSymbol(arg_266_1.text_)

				local var_269_20 = 24
				local var_269_21 = utf8.len(var_269_19)
				local var_269_22 = var_269_20 <= 0 and var_269_16 or var_269_16 * (var_269_21 / var_269_20)

				if var_269_22 > 0 and var_269_16 < var_269_22 then
					arg_266_1.talkMaxDuration = var_269_22

					if var_269_22 + var_269_15 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_22 + var_269_15
					end
				end

				arg_266_1.text_.text = var_269_19
				arg_266_1.typewritter.percent = 0

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701065", "story_v_side_new_1109701.awb") ~= 0 then
					local var_269_23 = manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701065", "story_v_side_new_1109701.awb") / 1000

					if var_269_23 + var_269_15 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_23 + var_269_15
					end

					if var_269_18.prefab_name ~= "" and arg_266_1.actors_[var_269_18.prefab_name] ~= nil then
						local var_269_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_266_1.actors_[var_269_18.prefab_name].transform, "story_v_side_new_1109701", "1109701065", "story_v_side_new_1109701.awb")

						arg_266_1:RecordAudio("1109701065", var_269_24)
						arg_266_1:RecordAudio("1109701065", var_269_24)
					else
						arg_266_1:AudioAction("play", "voice", "story_v_side_new_1109701", "1109701065", "story_v_side_new_1109701.awb")
					end

					arg_266_1:RecordHistoryTalkVoice("story_v_side_new_1109701", "1109701065", "story_v_side_new_1109701.awb")
				end

				arg_266_1:RecordContent(arg_266_1.text_.text)
			end

			local var_269_25 = math.max(var_269_16, arg_266_1.talkMaxDuration)

			if var_269_15 <= arg_266_1.time_ and arg_266_1.time_ < var_269_15 + var_269_25 then
				arg_266_1.typewritter.percent = (arg_266_1.time_ - var_269_15) / var_269_25

				arg_266_1.typewritter:SetDirty()
			end

			if arg_266_1.time_ >= var_269_15 + var_269_25 and arg_266_1.time_ < var_269_15 + var_269_25 + arg_269_0 then
				arg_266_1.typewritter.percent = 1

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(true)
			end
		end

		arg_266_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_266_1:InitPlayNodeList()
	end,
	Play1109701066 = function(arg_270_0, arg_270_1)
		arg_270_1.time_ = 0
		arg_270_1.frameCnt_ = 0
		arg_270_1.state_ = "playing"
		arg_270_1.curTalkId_ = 1109701066
		arg_270_1.duration_ = 5

		SetActive(arg_270_1.tipsGo_, false)

		function arg_270_1.onSingleLineFinish_()
			arg_270_1.onSingleLineUpdate_ = nil
			arg_270_1.onSingleLineFinish_ = nil
			arg_270_1.state_ = "waiting"
		end

		function arg_270_1.playNext_(arg_272_0)
			if arg_272_0 == 1 then
				arg_270_0:Play1109701067(arg_270_1)
			end
		end

		function arg_270_1.onSingleLineUpdate_(arg_273_0)
			local var_273_0 = arg_270_1.actors_["1097ui_story"]
			local var_273_1 = 0

			if var_273_1 < arg_270_1.time_ and arg_270_1.time_ <= var_273_1 + arg_273_0 and not isNil(var_273_0) and arg_270_1.var_.characterEffect1097ui_story == nil then
				arg_270_1.var_.characterEffect1097ui_story = var_273_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_273_2 = 0.200000002980232

			if var_273_1 <= arg_270_1.time_ and arg_270_1.time_ < var_273_1 + var_273_2 and not isNil(var_273_0) then
				local var_273_3 = (arg_270_1.time_ - var_273_1) / var_273_2

				if arg_270_1.var_.characterEffect1097ui_story and not isNil(var_273_0) then
					local var_273_4 = Mathf.Lerp(0, 0.5, var_273_3)

					arg_270_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_270_1.var_.characterEffect1097ui_story.fillRatio = var_273_4
				end
			end

			if arg_270_1.time_ >= var_273_1 + var_273_2 and arg_270_1.time_ < var_273_1 + var_273_2 + arg_273_0 and not isNil(var_273_0) and arg_270_1.var_.characterEffect1097ui_story then
				local var_273_5 = 0.5

				arg_270_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_270_1.var_.characterEffect1097ui_story.fillRatio = var_273_5
			end

			local var_273_6 = 0
			local var_273_7 = 0.95

			if var_273_6 < arg_270_1.time_ and arg_270_1.time_ <= var_273_6 + arg_273_0 then
				arg_270_1.talkMaxDuration = 0
				arg_270_1.dialogCg_.alpha = 1

				arg_270_1.dialog_:SetActive(true)
				SetActive(arg_270_1.leftNameGo_, false)

				arg_270_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_270_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_270_1:RecordName(arg_270_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_270_1.iconTrs_.gameObject, false)
				arg_270_1.callingController_:SetSelectedState("normal")

				local var_273_8 = arg_270_1:GetWordFromCfg(1109701066)
				local var_273_9 = arg_270_1:FormatText(var_273_8.content)

				arg_270_1.text_.text = var_273_9

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.text_)

				local var_273_10 = 38
				local var_273_11 = utf8.len(var_273_9)
				local var_273_12 = var_273_10 <= 0 and var_273_7 or var_273_7 * (var_273_11 / var_273_10)

				if var_273_12 > 0 and var_273_7 < var_273_12 then
					arg_270_1.talkMaxDuration = var_273_12

					if var_273_12 + var_273_6 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_12 + var_273_6
					end
				end

				arg_270_1.text_.text = var_273_9
				arg_270_1.typewritter.percent = 0

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(false)
				arg_270_1:RecordContent(arg_270_1.text_.text)
			end

			local var_273_13 = math.max(var_273_7, arg_270_1.talkMaxDuration)

			if var_273_6 <= arg_270_1.time_ and arg_270_1.time_ < var_273_6 + var_273_13 then
				arg_270_1.typewritter.percent = (arg_270_1.time_ - var_273_6) / var_273_13

				arg_270_1.typewritter:SetDirty()
			end

			if arg_270_1.time_ >= var_273_6 + var_273_13 and arg_270_1.time_ < var_273_6 + var_273_13 + arg_273_0 then
				arg_270_1.typewritter.percent = 1

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(true)
			end
		end

		arg_270_1.nodeConfigList_ = {}

		arg_270_1:InitPlayNodeList()
	end,
	Play1109701067 = function(arg_274_0, arg_274_1)
		arg_274_1.time_ = 0
		arg_274_1.frameCnt_ = 0
		arg_274_1.state_ = "playing"
		arg_274_1.curTalkId_ = 1109701067
		arg_274_1.duration_ = 5

		SetActive(arg_274_1.tipsGo_, false)

		function arg_274_1.onSingleLineFinish_()
			arg_274_1.onSingleLineUpdate_ = nil
			arg_274_1.onSingleLineFinish_ = nil
			arg_274_1.state_ = "waiting"
		end

		function arg_274_1.playNext_(arg_276_0)
			if arg_276_0 == 1 then
				arg_274_0:Play1109701068(arg_274_1)
			end
		end

		function arg_274_1.onSingleLineUpdate_(arg_277_0)
			local var_277_0 = 0
			local var_277_1 = 0.675

			if var_277_0 < arg_274_1.time_ and arg_274_1.time_ <= var_277_0 + arg_277_0 then
				arg_274_1.talkMaxDuration = 0
				arg_274_1.dialogCg_.alpha = 1

				arg_274_1.dialog_:SetActive(true)
				SetActive(arg_274_1.leftNameGo_, false)

				arg_274_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_274_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_274_1:RecordName(arg_274_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_274_1.iconTrs_.gameObject, false)
				arg_274_1.callingController_:SetSelectedState("normal")

				local var_277_2 = arg_274_1:GetWordFromCfg(1109701067)
				local var_277_3 = arg_274_1:FormatText(var_277_2.content)

				arg_274_1.text_.text = var_277_3

				LuaForUtil.ClearLinePrefixSymbol(arg_274_1.text_)

				local var_277_4 = 27
				local var_277_5 = utf8.len(var_277_3)
				local var_277_6 = var_277_4 <= 0 and var_277_1 or var_277_1 * (var_277_5 / var_277_4)

				if var_277_6 > 0 and var_277_1 < var_277_6 then
					arg_274_1.talkMaxDuration = var_277_6

					if var_277_6 + var_277_0 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_6 + var_277_0
					end
				end

				arg_274_1.text_.text = var_277_3
				arg_274_1.typewritter.percent = 0

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(false)
				arg_274_1:RecordContent(arg_274_1.text_.text)
			end

			local var_277_7 = math.max(var_277_1, arg_274_1.talkMaxDuration)

			if var_277_0 <= arg_274_1.time_ and arg_274_1.time_ < var_277_0 + var_277_7 then
				arg_274_1.typewritter.percent = (arg_274_1.time_ - var_277_0) / var_277_7

				arg_274_1.typewritter:SetDirty()
			end

			if arg_274_1.time_ >= var_277_0 + var_277_7 and arg_274_1.time_ < var_277_0 + var_277_7 + arg_277_0 then
				arg_274_1.typewritter.percent = 1

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(true)
			end
		end

		arg_274_1.nodeConfigList_ = {}

		arg_274_1:InitPlayNodeList()
	end,
	Play1109701068 = function(arg_278_0, arg_278_1)
		arg_278_1.time_ = 0
		arg_278_1.frameCnt_ = 0
		arg_278_1.state_ = "playing"
		arg_278_1.curTalkId_ = 1109701068
		arg_278_1.duration_ = 9

		SetActive(arg_278_1.tipsGo_, false)

		function arg_278_1.onSingleLineFinish_()
			arg_278_1.onSingleLineUpdate_ = nil
			arg_278_1.onSingleLineFinish_ = nil
			arg_278_1.state_ = "waiting"
		end

		function arg_278_1.playNext_(arg_280_0)
			if arg_280_0 == 1 then
				arg_278_0:Play1109701069(arg_278_1)
			end
		end

		function arg_278_1.onSingleLineUpdate_(arg_281_0)
			local var_281_0 = 2

			if var_281_0 < arg_278_1.time_ and arg_278_1.time_ <= var_281_0 + arg_281_0 then
				local var_281_1 = manager.ui.mainCamera.transform.localPosition
				local var_281_2 = Vector3.New(0, 0, 10) + Vector3.New(var_281_1.x, var_281_1.y, 0)
				local var_281_3 = arg_278_1.bgs_.F01

				var_281_3.transform.localPosition = var_281_2
				var_281_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_281_4 = var_281_3:GetComponent("SpriteRenderer")

				if var_281_4 and var_281_4.sprite then
					local var_281_5 = (var_281_3.transform.localPosition - var_281_1).z
					local var_281_6 = manager.ui.mainCameraCom_
					local var_281_7 = 2 * var_281_5 * Mathf.Tan(var_281_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_281_8 = var_281_7 * var_281_6.aspect
					local var_281_9 = var_281_4.sprite.bounds.size.x
					local var_281_10 = var_281_4.sprite.bounds.size.y
					local var_281_11 = var_281_8 / var_281_9
					local var_281_12 = var_281_7 / var_281_10
					local var_281_13 = var_281_12 < var_281_11 and var_281_11 or var_281_12

					var_281_3.transform.localScale = Vector3.New(var_281_13, var_281_13, 0)
				end

				for iter_281_0, iter_281_1 in pairs(arg_278_1.bgs_) do
					if iter_281_0 ~= "F01" then
						iter_281_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_281_14 = 0

			if var_281_14 < arg_278_1.time_ and arg_278_1.time_ <= var_281_14 + arg_281_0 then
				arg_278_1.mask_.enabled = true
				arg_278_1.mask_.raycastTarget = true

				arg_278_1:SetGaussion(false)
			end

			local var_281_15 = 2

			if var_281_14 <= arg_278_1.time_ and arg_278_1.time_ < var_281_14 + var_281_15 then
				local var_281_16 = (arg_278_1.time_ - var_281_14) / var_281_15
				local var_281_17 = Color.New(0, 0, 0)

				var_281_17.a = Mathf.Lerp(0, 1, var_281_16)
				arg_278_1.mask_.color = var_281_17
			end

			if arg_278_1.time_ >= var_281_14 + var_281_15 and arg_278_1.time_ < var_281_14 + var_281_15 + arg_281_0 then
				local var_281_18 = Color.New(0, 0, 0)

				var_281_18.a = 1
				arg_278_1.mask_.color = var_281_18
			end

			local var_281_19 = 2

			if var_281_19 < arg_278_1.time_ and arg_278_1.time_ <= var_281_19 + arg_281_0 then
				arg_278_1.mask_.enabled = true
				arg_278_1.mask_.raycastTarget = true

				arg_278_1:SetGaussion(false)
			end

			local var_281_20 = 2

			if var_281_19 <= arg_278_1.time_ and arg_278_1.time_ < var_281_19 + var_281_20 then
				local var_281_21 = (arg_278_1.time_ - var_281_19) / var_281_20
				local var_281_22 = Color.New(0, 0, 0)

				var_281_22.a = Mathf.Lerp(1, 0, var_281_21)
				arg_278_1.mask_.color = var_281_22
			end

			if arg_278_1.time_ >= var_281_19 + var_281_20 and arg_278_1.time_ < var_281_19 + var_281_20 + arg_281_0 then
				local var_281_23 = Color.New(0, 0, 0)
				local var_281_24 = 0

				arg_278_1.mask_.enabled = false
				var_281_23.a = var_281_24
				arg_278_1.mask_.color = var_281_23
			end

			local var_281_25 = arg_278_1.actors_["1097ui_story"].transform
			local var_281_26 = 1.96599999815226

			if var_281_26 < arg_278_1.time_ and arg_278_1.time_ <= var_281_26 + arg_281_0 then
				arg_278_1.var_.moveOldPos1097ui_story = var_281_25.localPosition
			end

			local var_281_27 = 0.001

			if var_281_26 <= arg_278_1.time_ and arg_278_1.time_ < var_281_26 + var_281_27 then
				local var_281_28 = (arg_278_1.time_ - var_281_26) / var_281_27
				local var_281_29 = Vector3.New(0, 100, 0)

				var_281_25.localPosition = Vector3.Lerp(arg_278_1.var_.moveOldPos1097ui_story, var_281_29, var_281_28)

				local var_281_30 = manager.ui.mainCamera.transform.position - var_281_25.position

				var_281_25.forward = Vector3.New(var_281_30.x, var_281_30.y, var_281_30.z)

				local var_281_31 = var_281_25.localEulerAngles

				var_281_31.z = 0
				var_281_31.x = 0
				var_281_25.localEulerAngles = var_281_31
			end

			if arg_278_1.time_ >= var_281_26 + var_281_27 and arg_278_1.time_ < var_281_26 + var_281_27 + arg_281_0 then
				var_281_25.localPosition = Vector3.New(0, 100, 0)

				local var_281_32 = manager.ui.mainCamera.transform.position - var_281_25.position

				var_281_25.forward = Vector3.New(var_281_32.x, var_281_32.y, var_281_32.z)

				local var_281_33 = var_281_25.localEulerAngles

				var_281_33.z = 0
				var_281_33.x = 0
				var_281_25.localEulerAngles = var_281_33
			end

			local var_281_34 = arg_278_1.actors_["1097ui_story"]
			local var_281_35 = 1.96599999815226

			if var_281_35 < arg_278_1.time_ and arg_278_1.time_ <= var_281_35 + arg_281_0 and not isNil(var_281_34) and arg_278_1.var_.characterEffect1097ui_story == nil then
				arg_278_1.var_.characterEffect1097ui_story = var_281_34:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_281_36 = 0.034000001847744

			if var_281_35 <= arg_278_1.time_ and arg_278_1.time_ < var_281_35 + var_281_36 and not isNil(var_281_34) then
				local var_281_37 = (arg_278_1.time_ - var_281_35) / var_281_36

				if arg_278_1.var_.characterEffect1097ui_story and not isNil(var_281_34) then
					local var_281_38 = Mathf.Lerp(0, 0.5, var_281_37)

					arg_278_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_278_1.var_.characterEffect1097ui_story.fillRatio = var_281_38
				end
			end

			if arg_278_1.time_ >= var_281_35 + var_281_36 and arg_278_1.time_ < var_281_35 + var_281_36 + arg_281_0 and not isNil(var_281_34) and arg_278_1.var_.characterEffect1097ui_story then
				local var_281_39 = 0.5

				arg_278_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_278_1.var_.characterEffect1097ui_story.fillRatio = var_281_39
			end

			if arg_278_1.frameCnt_ <= 1 then
				arg_278_1.dialog_:SetActive(false)
			end

			local var_281_40 = 4
			local var_281_41 = 0.1

			if var_281_40 < arg_278_1.time_ and arg_278_1.time_ <= var_281_40 + arg_281_0 then
				arg_278_1.talkMaxDuration = 0

				arg_278_1.dialog_:SetActive(true)

				arg_278_1.dialogCg_.alpha = 0

				local var_281_42 = LeanTween.value(arg_278_1.dialog_, 0, 1, 0.3)

				var_281_42:setOnUpdate(LuaHelper.FloatAction(function(arg_282_0)
					arg_278_1.dialogCg_.alpha = arg_282_0
				end))
				var_281_42:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_278_1.dialog_)
					var_281_42:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_278_1.duration_ = arg_278_1.duration_ + 0.3

				SetActive(arg_278_1.leftNameGo_, true)

				local var_281_43 = arg_278_1:FormatText(StoryNameCfg[7].name)

				arg_278_1.leftNameTxt_.text = var_281_43

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_278_1.leftNameTxt_.transform)

				arg_278_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_278_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_278_1:RecordName(arg_278_1.leftNameTxt_.text)
				SetActive(arg_278_1.iconTrs_.gameObject, true)
				arg_278_1.iconController_:SetSelectedState("hero")

				arg_278_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_278_1.callingController_:SetSelectedState("normal")

				arg_278_1.keyicon_.color = Color.New(1, 1, 1)
				arg_278_1.icon_.color = Color.New(1, 1, 1)

				local var_281_44 = arg_278_1:GetWordFromCfg(1109701068)
				local var_281_45 = arg_278_1:FormatText(var_281_44.content)

				arg_278_1.text_.text = var_281_45

				LuaForUtil.ClearLinePrefixSymbol(arg_278_1.text_)

				local var_281_46 = 4
				local var_281_47 = utf8.len(var_281_45)
				local var_281_48 = var_281_46 <= 0 and var_281_41 or var_281_41 * (var_281_47 / var_281_46)

				if var_281_48 > 0 and var_281_41 < var_281_48 then
					arg_278_1.talkMaxDuration = var_281_48
					var_281_40 = var_281_40 + 0.3

					if var_281_48 + var_281_40 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_48 + var_281_40
					end
				end

				arg_278_1.text_.text = var_281_45
				arg_278_1.typewritter.percent = 0

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(false)
				arg_278_1:RecordContent(arg_278_1.text_.text)
			end

			local var_281_49 = var_281_40 + 0.3
			local var_281_50 = math.max(var_281_41, arg_278_1.talkMaxDuration)

			if var_281_49 <= arg_278_1.time_ and arg_278_1.time_ < var_281_49 + var_281_50 then
				arg_278_1.typewritter.percent = (arg_278_1.time_ - var_281_49) / var_281_50

				arg_278_1.typewritter:SetDirty()
			end

			if arg_278_1.time_ >= var_281_49 + var_281_50 and arg_278_1.time_ < var_281_49 + var_281_50 + arg_281_0 then
				arg_278_1.typewritter.percent = 1

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(true)
			end
		end

		arg_278_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_278_1:InitPlayNodeList()
	end,
	Play1109701069 = function(arg_284_0, arg_284_1)
		arg_284_1.time_ = 0
		arg_284_1.frameCnt_ = 0
		arg_284_1.state_ = "playing"
		arg_284_1.curTalkId_ = 1109701069
		arg_284_1.duration_ = 3.63

		local var_284_0 = {
			zh = 3.633,
			ja = 2.766
		}
		local var_284_1 = manager.audio:GetLocalizationFlag()

		if var_284_0[var_284_1] ~= nil then
			arg_284_1.duration_ = var_284_0[var_284_1]
		end

		SetActive(arg_284_1.tipsGo_, false)

		function arg_284_1.onSingleLineFinish_()
			arg_284_1.onSingleLineUpdate_ = nil
			arg_284_1.onSingleLineFinish_ = nil
			arg_284_1.state_ = "waiting"
		end

		function arg_284_1.playNext_(arg_286_0)
			if arg_286_0 == 1 then
				arg_284_0:Play1109701070(arg_284_1)
			end
		end

		function arg_284_1.onSingleLineUpdate_(arg_287_0)
			local var_287_0 = arg_284_1.actors_["1097ui_story"].transform
			local var_287_1 = 0

			if var_287_1 < arg_284_1.time_ and arg_284_1.time_ <= var_287_1 + arg_287_0 then
				arg_284_1.var_.moveOldPos1097ui_story = var_287_0.localPosition
			end

			local var_287_2 = 0.001

			if var_287_1 <= arg_284_1.time_ and arg_284_1.time_ < var_287_1 + var_287_2 then
				local var_287_3 = (arg_284_1.time_ - var_287_1) / var_287_2
				local var_287_4 = Vector3.New(0, -0.54, -6.3)

				var_287_0.localPosition = Vector3.Lerp(arg_284_1.var_.moveOldPos1097ui_story, var_287_4, var_287_3)

				local var_287_5 = manager.ui.mainCamera.transform.position - var_287_0.position

				var_287_0.forward = Vector3.New(var_287_5.x, var_287_5.y, var_287_5.z)

				local var_287_6 = var_287_0.localEulerAngles

				var_287_6.z = 0
				var_287_6.x = 0
				var_287_0.localEulerAngles = var_287_6
			end

			if arg_284_1.time_ >= var_287_1 + var_287_2 and arg_284_1.time_ < var_287_1 + var_287_2 + arg_287_0 then
				var_287_0.localPosition = Vector3.New(0, -0.54, -6.3)

				local var_287_7 = manager.ui.mainCamera.transform.position - var_287_0.position

				var_287_0.forward = Vector3.New(var_287_7.x, var_287_7.y, var_287_7.z)

				local var_287_8 = var_287_0.localEulerAngles

				var_287_8.z = 0
				var_287_8.x = 0
				var_287_0.localEulerAngles = var_287_8
			end

			local var_287_9 = arg_284_1.actors_["1097ui_story"]
			local var_287_10 = 0

			if var_287_10 < arg_284_1.time_ and arg_284_1.time_ <= var_287_10 + arg_287_0 and not isNil(var_287_9) and arg_284_1.var_.characterEffect1097ui_story == nil then
				arg_284_1.var_.characterEffect1097ui_story = var_287_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_287_11 = 0.200000002980232

			if var_287_10 <= arg_284_1.time_ and arg_284_1.time_ < var_287_10 + var_287_11 and not isNil(var_287_9) then
				local var_287_12 = (arg_284_1.time_ - var_287_10) / var_287_11

				if arg_284_1.var_.characterEffect1097ui_story and not isNil(var_287_9) then
					arg_284_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_284_1.time_ >= var_287_10 + var_287_11 and arg_284_1.time_ < var_287_10 + var_287_11 + arg_287_0 and not isNil(var_287_9) and arg_284_1.var_.characterEffect1097ui_story then
				arg_284_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_287_13 = 0

			if var_287_13 < arg_284_1.time_ and arg_284_1.time_ <= var_287_13 + arg_287_0 then
				arg_284_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action7_1")
			end

			local var_287_14 = 0

			if var_287_14 < arg_284_1.time_ and arg_284_1.time_ <= var_287_14 + arg_287_0 then
				arg_284_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_287_15 = 0
			local var_287_16 = 0.475

			if var_287_15 < arg_284_1.time_ and arg_284_1.time_ <= var_287_15 + arg_287_0 then
				arg_284_1.talkMaxDuration = 0
				arg_284_1.dialogCg_.alpha = 1

				arg_284_1.dialog_:SetActive(true)
				SetActive(arg_284_1.leftNameGo_, true)

				local var_287_17 = arg_284_1:FormatText(StoryNameCfg[216].name)

				arg_284_1.leftNameTxt_.text = var_287_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_284_1.leftNameTxt_.transform)

				arg_284_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_284_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_284_1:RecordName(arg_284_1.leftNameTxt_.text)
				SetActive(arg_284_1.iconTrs_.gameObject, false)
				arg_284_1.callingController_:SetSelectedState("normal")

				local var_287_18 = arg_284_1:GetWordFromCfg(1109701069)
				local var_287_19 = arg_284_1:FormatText(var_287_18.content)

				arg_284_1.text_.text = var_287_19

				LuaForUtil.ClearLinePrefixSymbol(arg_284_1.text_)

				local var_287_20 = 19
				local var_287_21 = utf8.len(var_287_19)
				local var_287_22 = var_287_20 <= 0 and var_287_16 or var_287_16 * (var_287_21 / var_287_20)

				if var_287_22 > 0 and var_287_16 < var_287_22 then
					arg_284_1.talkMaxDuration = var_287_22

					if var_287_22 + var_287_15 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_22 + var_287_15
					end
				end

				arg_284_1.text_.text = var_287_19
				arg_284_1.typewritter.percent = 0

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701069", "story_v_side_new_1109701.awb") ~= 0 then
					local var_287_23 = manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701069", "story_v_side_new_1109701.awb") / 1000

					if var_287_23 + var_287_15 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_23 + var_287_15
					end

					if var_287_18.prefab_name ~= "" and arg_284_1.actors_[var_287_18.prefab_name] ~= nil then
						local var_287_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_284_1.actors_[var_287_18.prefab_name].transform, "story_v_side_new_1109701", "1109701069", "story_v_side_new_1109701.awb")

						arg_284_1:RecordAudio("1109701069", var_287_24)
						arg_284_1:RecordAudio("1109701069", var_287_24)
					else
						arg_284_1:AudioAction("play", "voice", "story_v_side_new_1109701", "1109701069", "story_v_side_new_1109701.awb")
					end

					arg_284_1:RecordHistoryTalkVoice("story_v_side_new_1109701", "1109701069", "story_v_side_new_1109701.awb")
				end

				arg_284_1:RecordContent(arg_284_1.text_.text)
			end

			local var_287_25 = math.max(var_287_16, arg_284_1.talkMaxDuration)

			if var_287_15 <= arg_284_1.time_ and arg_284_1.time_ < var_287_15 + var_287_25 then
				arg_284_1.typewritter.percent = (arg_284_1.time_ - var_287_15) / var_287_25

				arg_284_1.typewritter:SetDirty()
			end

			if arg_284_1.time_ >= var_287_15 + var_287_25 and arg_284_1.time_ < var_287_15 + var_287_25 + arg_287_0 then
				arg_284_1.typewritter.percent = 1

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(true)
			end
		end

		arg_284_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_284_1:InitPlayNodeList()
	end,
	Play1109701070 = function(arg_288_0, arg_288_1)
		arg_288_1.time_ = 0
		arg_288_1.frameCnt_ = 0
		arg_288_1.state_ = "playing"
		arg_288_1.curTalkId_ = 1109701070
		arg_288_1.duration_ = 5

		SetActive(arg_288_1.tipsGo_, false)

		function arg_288_1.onSingleLineFinish_()
			arg_288_1.onSingleLineUpdate_ = nil
			arg_288_1.onSingleLineFinish_ = nil
			arg_288_1.state_ = "waiting"
		end

		function arg_288_1.playNext_(arg_290_0)
			if arg_290_0 == 1 then
				arg_288_0:Play1109701071(arg_288_1)
			end
		end

		function arg_288_1.onSingleLineUpdate_(arg_291_0)
			local var_291_0 = arg_288_1.actors_["1097ui_story"]
			local var_291_1 = 0

			if var_291_1 < arg_288_1.time_ and arg_288_1.time_ <= var_291_1 + arg_291_0 and not isNil(var_291_0) and arg_288_1.var_.characterEffect1097ui_story == nil then
				arg_288_1.var_.characterEffect1097ui_story = var_291_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_291_2 = 0.200000002980232

			if var_291_1 <= arg_288_1.time_ and arg_288_1.time_ < var_291_1 + var_291_2 and not isNil(var_291_0) then
				local var_291_3 = (arg_288_1.time_ - var_291_1) / var_291_2

				if arg_288_1.var_.characterEffect1097ui_story and not isNil(var_291_0) then
					local var_291_4 = Mathf.Lerp(0, 0.5, var_291_3)

					arg_288_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_288_1.var_.characterEffect1097ui_story.fillRatio = var_291_4
				end
			end

			if arg_288_1.time_ >= var_291_1 + var_291_2 and arg_288_1.time_ < var_291_1 + var_291_2 + arg_291_0 and not isNil(var_291_0) and arg_288_1.var_.characterEffect1097ui_story then
				local var_291_5 = 0.5

				arg_288_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_288_1.var_.characterEffect1097ui_story.fillRatio = var_291_5
			end

			local var_291_6 = 0
			local var_291_7 = 0.75

			if var_291_6 < arg_288_1.time_ and arg_288_1.time_ <= var_291_6 + arg_291_0 then
				arg_288_1.talkMaxDuration = 0
				arg_288_1.dialogCg_.alpha = 1

				arg_288_1.dialog_:SetActive(true)
				SetActive(arg_288_1.leftNameGo_, false)

				arg_288_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_288_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_288_1:RecordName(arg_288_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_288_1.iconTrs_.gameObject, false)
				arg_288_1.callingController_:SetSelectedState("normal")

				local var_291_8 = arg_288_1:GetWordFromCfg(1109701070)
				local var_291_9 = arg_288_1:FormatText(var_291_8.content)

				arg_288_1.text_.text = var_291_9

				LuaForUtil.ClearLinePrefixSymbol(arg_288_1.text_)

				local var_291_10 = 30
				local var_291_11 = utf8.len(var_291_9)
				local var_291_12 = var_291_10 <= 0 and var_291_7 or var_291_7 * (var_291_11 / var_291_10)

				if var_291_12 > 0 and var_291_7 < var_291_12 then
					arg_288_1.talkMaxDuration = var_291_12

					if var_291_12 + var_291_6 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_12 + var_291_6
					end
				end

				arg_288_1.text_.text = var_291_9
				arg_288_1.typewritter.percent = 0

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(false)
				arg_288_1:RecordContent(arg_288_1.text_.text)
			end

			local var_291_13 = math.max(var_291_7, arg_288_1.talkMaxDuration)

			if var_291_6 <= arg_288_1.time_ and arg_288_1.time_ < var_291_6 + var_291_13 then
				arg_288_1.typewritter.percent = (arg_288_1.time_ - var_291_6) / var_291_13

				arg_288_1.typewritter:SetDirty()
			end

			if arg_288_1.time_ >= var_291_6 + var_291_13 and arg_288_1.time_ < var_291_6 + var_291_13 + arg_291_0 then
				arg_288_1.typewritter.percent = 1

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(true)
			end
		end

		arg_288_1.nodeConfigList_ = {}

		arg_288_1:InitPlayNodeList()
	end,
	Play1109701071 = function(arg_292_0, arg_292_1)
		arg_292_1.time_ = 0
		arg_292_1.frameCnt_ = 0
		arg_292_1.state_ = "playing"
		arg_292_1.curTalkId_ = 1109701071
		arg_292_1.duration_ = 5

		SetActive(arg_292_1.tipsGo_, false)

		function arg_292_1.onSingleLineFinish_()
			arg_292_1.onSingleLineUpdate_ = nil
			arg_292_1.onSingleLineFinish_ = nil
			arg_292_1.state_ = "waiting"
		end

		function arg_292_1.playNext_(arg_294_0)
			if arg_294_0 == 1 then
				arg_292_0:Play1109701072(arg_292_1)
			end
		end

		function arg_292_1.onSingleLineUpdate_(arg_295_0)
			local var_295_0 = 0
			local var_295_1 = 0.625

			if var_295_0 < arg_292_1.time_ and arg_292_1.time_ <= var_295_0 + arg_295_0 then
				arg_292_1.talkMaxDuration = 0
				arg_292_1.dialogCg_.alpha = 1

				arg_292_1.dialog_:SetActive(true)
				SetActive(arg_292_1.leftNameGo_, true)

				local var_295_2 = arg_292_1:FormatText(StoryNameCfg[7].name)

				arg_292_1.leftNameTxt_.text = var_295_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_292_1.leftNameTxt_.transform)

				arg_292_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_292_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_292_1:RecordName(arg_292_1.leftNameTxt_.text)
				SetActive(arg_292_1.iconTrs_.gameObject, true)
				arg_292_1.iconController_:SetSelectedState("hero")

				arg_292_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_292_1.callingController_:SetSelectedState("normal")

				arg_292_1.keyicon_.color = Color.New(1, 1, 1)
				arg_292_1.icon_.color = Color.New(1, 1, 1)

				local var_295_3 = arg_292_1:GetWordFromCfg(1109701071)
				local var_295_4 = arg_292_1:FormatText(var_295_3.content)

				arg_292_1.text_.text = var_295_4

				LuaForUtil.ClearLinePrefixSymbol(arg_292_1.text_)

				local var_295_5 = 25
				local var_295_6 = utf8.len(var_295_4)
				local var_295_7 = var_295_5 <= 0 and var_295_1 or var_295_1 * (var_295_6 / var_295_5)

				if var_295_7 > 0 and var_295_1 < var_295_7 then
					arg_292_1.talkMaxDuration = var_295_7

					if var_295_7 + var_295_0 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_7 + var_295_0
					end
				end

				arg_292_1.text_.text = var_295_4
				arg_292_1.typewritter.percent = 0

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(false)
				arg_292_1:RecordContent(arg_292_1.text_.text)
			end

			local var_295_8 = math.max(var_295_1, arg_292_1.talkMaxDuration)

			if var_295_0 <= arg_292_1.time_ and arg_292_1.time_ < var_295_0 + var_295_8 then
				arg_292_1.typewritter.percent = (arg_292_1.time_ - var_295_0) / var_295_8

				arg_292_1.typewritter:SetDirty()
			end

			if arg_292_1.time_ >= var_295_0 + var_295_8 and arg_292_1.time_ < var_295_0 + var_295_8 + arg_295_0 then
				arg_292_1.typewritter.percent = 1

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(true)
			end
		end

		arg_292_1.nodeConfigList_ = {}

		arg_292_1:InitPlayNodeList()
	end,
	Play1109701072 = function(arg_296_0, arg_296_1)
		arg_296_1.time_ = 0
		arg_296_1.frameCnt_ = 0
		arg_296_1.state_ = "playing"
		arg_296_1.curTalkId_ = 1109701072
		arg_296_1.duration_ = 7.3

		local var_296_0 = {
			zh = 7.3,
			ja = 5.266
		}
		local var_296_1 = manager.audio:GetLocalizationFlag()

		if var_296_0[var_296_1] ~= nil then
			arg_296_1.duration_ = var_296_0[var_296_1]
		end

		SetActive(arg_296_1.tipsGo_, false)

		function arg_296_1.onSingleLineFinish_()
			arg_296_1.onSingleLineUpdate_ = nil
			arg_296_1.onSingleLineFinish_ = nil
			arg_296_1.state_ = "waiting"
		end

		function arg_296_1.playNext_(arg_298_0)
			if arg_298_0 == 1 then
				arg_296_0:Play1109701073(arg_296_1)
			end
		end

		function arg_296_1.onSingleLineUpdate_(arg_299_0)
			local var_299_0 = arg_296_1.actors_["1097ui_story"].transform
			local var_299_1 = 0

			if var_299_1 < arg_296_1.time_ and arg_296_1.time_ <= var_299_1 + arg_299_0 then
				arg_296_1.var_.moveOldPos1097ui_story = var_299_0.localPosition
			end

			local var_299_2 = 0.001

			if var_299_1 <= arg_296_1.time_ and arg_296_1.time_ < var_299_1 + var_299_2 then
				local var_299_3 = (arg_296_1.time_ - var_299_1) / var_299_2
				local var_299_4 = Vector3.New(0, 100, 0)

				var_299_0.localPosition = Vector3.Lerp(arg_296_1.var_.moveOldPos1097ui_story, var_299_4, var_299_3)

				local var_299_5 = manager.ui.mainCamera.transform.position - var_299_0.position

				var_299_0.forward = Vector3.New(var_299_5.x, var_299_5.y, var_299_5.z)

				local var_299_6 = var_299_0.localEulerAngles

				var_299_6.z = 0
				var_299_6.x = 0
				var_299_0.localEulerAngles = var_299_6
			end

			if arg_296_1.time_ >= var_299_1 + var_299_2 and arg_296_1.time_ < var_299_1 + var_299_2 + arg_299_0 then
				var_299_0.localPosition = Vector3.New(0, 100, 0)

				local var_299_7 = manager.ui.mainCamera.transform.position - var_299_0.position

				var_299_0.forward = Vector3.New(var_299_7.x, var_299_7.y, var_299_7.z)

				local var_299_8 = var_299_0.localEulerAngles

				var_299_8.z = 0
				var_299_8.x = 0
				var_299_0.localEulerAngles = var_299_8
			end

			local var_299_9 = arg_296_1.actors_["1097ui_story"]
			local var_299_10 = 0

			if var_299_10 < arg_296_1.time_ and arg_296_1.time_ <= var_299_10 + arg_299_0 and not isNil(var_299_9) and arg_296_1.var_.characterEffect1097ui_story == nil then
				arg_296_1.var_.characterEffect1097ui_story = var_299_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_299_11 = 0.200000002980232

			if var_299_10 <= arg_296_1.time_ and arg_296_1.time_ < var_299_10 + var_299_11 and not isNil(var_299_9) then
				local var_299_12 = (arg_296_1.time_ - var_299_10) / var_299_11

				if arg_296_1.var_.characterEffect1097ui_story and not isNil(var_299_9) then
					local var_299_13 = Mathf.Lerp(0, 0.5, var_299_12)

					arg_296_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_296_1.var_.characterEffect1097ui_story.fillRatio = var_299_13
				end
			end

			if arg_296_1.time_ >= var_299_10 + var_299_11 and arg_296_1.time_ < var_299_10 + var_299_11 + arg_299_0 and not isNil(var_299_9) and arg_296_1.var_.characterEffect1097ui_story then
				local var_299_14 = 0.5

				arg_296_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_296_1.var_.characterEffect1097ui_story.fillRatio = var_299_14
			end

			local var_299_15 = arg_296_1.actors_["6045_story"].transform
			local var_299_16 = 0

			if var_299_16 < arg_296_1.time_ and arg_296_1.time_ <= var_299_16 + arg_299_0 then
				arg_296_1.var_.moveOldPos6045_story = var_299_15.localPosition

				local var_299_17 = GameObjectTools.GetOrAddComponent(var_299_15.gameObject, typeof(DynamicBoneHelper))

				if var_299_17 then
					var_299_17:EnableDynamicBone(false)
				end
			end

			local var_299_18 = 0.001

			if var_299_16 <= arg_296_1.time_ and arg_296_1.time_ < var_299_16 + var_299_18 then
				local var_299_19 = (arg_296_1.time_ - var_299_16) / var_299_18
				local var_299_20 = Vector3.New(-0.7, -0.5, -6.3)

				var_299_15.localPosition = Vector3.Lerp(arg_296_1.var_.moveOldPos6045_story, var_299_20, var_299_19)

				local var_299_21 = manager.ui.mainCamera.transform.position - var_299_15.position

				var_299_15.forward = Vector3.New(var_299_21.x, var_299_21.y, var_299_21.z)

				local var_299_22 = var_299_15.localEulerAngles

				var_299_22.z = 0
				var_299_22.x = 0
				var_299_15.localEulerAngles = var_299_22
			end

			if arg_296_1.time_ >= var_299_16 + var_299_18 and arg_296_1.time_ < var_299_16 + var_299_18 + arg_299_0 then
				var_299_15.localPosition = Vector3.New(-0.7, -0.5, -6.3)

				local var_299_23 = manager.ui.mainCamera.transform.position - var_299_15.position

				var_299_15.forward = Vector3.New(var_299_23.x, var_299_23.y, var_299_23.z)

				local var_299_24 = var_299_15.localEulerAngles

				var_299_24.z = 0
				var_299_24.x = 0
				var_299_15.localEulerAngles = var_299_24

				local var_299_25 = GameObjectTools.GetOrAddComponent(var_299_15.gameObject, typeof(DynamicBoneHelper))

				if var_299_25 then
					var_299_25:EnableDynamicBone(true)
				end
			end

			local var_299_26 = arg_296_1.actors_["6045_story"]
			local var_299_27 = 0

			if var_299_27 < arg_296_1.time_ and arg_296_1.time_ <= var_299_27 + arg_299_0 and not isNil(var_299_26) and arg_296_1.var_.characterEffect6045_story == nil then
				arg_296_1.var_.characterEffect6045_story = var_299_26:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_299_28 = 0.200000002980232

			if var_299_27 <= arg_296_1.time_ and arg_296_1.time_ < var_299_27 + var_299_28 and not isNil(var_299_26) then
				local var_299_29 = (arg_296_1.time_ - var_299_27) / var_299_28

				if arg_296_1.var_.characterEffect6045_story and not isNil(var_299_26) then
					local var_299_30 = Mathf.Lerp(0, 0.5, var_299_29)

					arg_296_1.var_.characterEffect6045_story.fillFlat = true
					arg_296_1.var_.characterEffect6045_story.fillRatio = var_299_30
				end
			end

			if arg_296_1.time_ >= var_299_27 + var_299_28 and arg_296_1.time_ < var_299_27 + var_299_28 + arg_299_0 and not isNil(var_299_26) and arg_296_1.var_.characterEffect6045_story then
				local var_299_31 = 0.5

				arg_296_1.var_.characterEffect6045_story.fillFlat = true
				arg_296_1.var_.characterEffect6045_story.fillRatio = var_299_31
			end

			local var_299_32 = arg_296_1.actors_["6046_story"].transform
			local var_299_33 = 0

			if var_299_33 < arg_296_1.time_ and arg_296_1.time_ <= var_299_33 + arg_299_0 then
				arg_296_1.var_.moveOldPos6046_story = var_299_32.localPosition

				local var_299_34 = GameObjectTools.GetOrAddComponent(var_299_32.gameObject, typeof(DynamicBoneHelper))

				if var_299_34 then
					var_299_34:EnableDynamicBone(false)
				end
			end

			local var_299_35 = 0.001

			if var_299_33 <= arg_296_1.time_ and arg_296_1.time_ < var_299_33 + var_299_35 then
				local var_299_36 = (arg_296_1.time_ - var_299_33) / var_299_35
				local var_299_37 = Vector3.New(0.7, -0.5, -6.3)

				var_299_32.localPosition = Vector3.Lerp(arg_296_1.var_.moveOldPos6046_story, var_299_37, var_299_36)

				local var_299_38 = manager.ui.mainCamera.transform.position - var_299_32.position

				var_299_32.forward = Vector3.New(var_299_38.x, var_299_38.y, var_299_38.z)

				local var_299_39 = var_299_32.localEulerAngles

				var_299_39.z = 0
				var_299_39.x = 0
				var_299_32.localEulerAngles = var_299_39
			end

			if arg_296_1.time_ >= var_299_33 + var_299_35 and arg_296_1.time_ < var_299_33 + var_299_35 + arg_299_0 then
				var_299_32.localPosition = Vector3.New(0.7, -0.5, -6.3)

				local var_299_40 = manager.ui.mainCamera.transform.position - var_299_32.position

				var_299_32.forward = Vector3.New(var_299_40.x, var_299_40.y, var_299_40.z)

				local var_299_41 = var_299_32.localEulerAngles

				var_299_41.z = 0
				var_299_41.x = 0
				var_299_32.localEulerAngles = var_299_41

				local var_299_42 = GameObjectTools.GetOrAddComponent(var_299_32.gameObject, typeof(DynamicBoneHelper))

				if var_299_42 then
					var_299_42:EnableDynamicBone(true)
				end
			end

			local var_299_43 = arg_296_1.actors_["6046_story"]
			local var_299_44 = 0

			if var_299_44 < arg_296_1.time_ and arg_296_1.time_ <= var_299_44 + arg_299_0 and not isNil(var_299_43) and arg_296_1.var_.characterEffect6046_story == nil then
				arg_296_1.var_.characterEffect6046_story = var_299_43:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_299_45 = 0.200000002980232

			if var_299_44 <= arg_296_1.time_ and arg_296_1.time_ < var_299_44 + var_299_45 and not isNil(var_299_43) then
				local var_299_46 = (arg_296_1.time_ - var_299_44) / var_299_45

				if arg_296_1.var_.characterEffect6046_story and not isNil(var_299_43) then
					arg_296_1.var_.characterEffect6046_story.fillFlat = false
				end
			end

			if arg_296_1.time_ >= var_299_44 + var_299_45 and arg_296_1.time_ < var_299_44 + var_299_45 + arg_299_0 and not isNil(var_299_43) and arg_296_1.var_.characterEffect6046_story then
				arg_296_1.var_.characterEffect6046_story.fillFlat = false
			end

			local var_299_47 = 0

			if var_299_47 < arg_296_1.time_ and arg_296_1.time_ <= var_299_47 + arg_299_0 then
				arg_296_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/story6046/story6046action/6046action4_1")
			end

			local var_299_48 = 0

			if var_299_48 < arg_296_1.time_ and arg_296_1.time_ <= var_299_48 + arg_299_0 then
				arg_296_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_299_49 = 0
			local var_299_50 = 0.675

			if var_299_49 < arg_296_1.time_ and arg_296_1.time_ <= var_299_49 + arg_299_0 then
				arg_296_1.talkMaxDuration = 0
				arg_296_1.dialogCg_.alpha = 1

				arg_296_1.dialog_:SetActive(true)
				SetActive(arg_296_1.leftNameGo_, true)

				local var_299_51 = arg_296_1:FormatText(StoryNameCfg[214].name)

				arg_296_1.leftNameTxt_.text = var_299_51

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_296_1.leftNameTxt_.transform)

				arg_296_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_296_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_296_1:RecordName(arg_296_1.leftNameTxt_.text)
				SetActive(arg_296_1.iconTrs_.gameObject, false)
				arg_296_1.callingController_:SetSelectedState("normal")

				local var_299_52 = arg_296_1:GetWordFromCfg(1109701072)
				local var_299_53 = arg_296_1:FormatText(var_299_52.content)

				arg_296_1.text_.text = var_299_53

				LuaForUtil.ClearLinePrefixSymbol(arg_296_1.text_)

				local var_299_54 = 27
				local var_299_55 = utf8.len(var_299_53)
				local var_299_56 = var_299_54 <= 0 and var_299_50 or var_299_50 * (var_299_55 / var_299_54)

				if var_299_56 > 0 and var_299_50 < var_299_56 then
					arg_296_1.talkMaxDuration = var_299_56

					if var_299_56 + var_299_49 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_56 + var_299_49
					end
				end

				arg_296_1.text_.text = var_299_53
				arg_296_1.typewritter.percent = 0

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701072", "story_v_side_new_1109701.awb") ~= 0 then
					local var_299_57 = manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701072", "story_v_side_new_1109701.awb") / 1000

					if var_299_57 + var_299_49 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_57 + var_299_49
					end

					if var_299_52.prefab_name ~= "" and arg_296_1.actors_[var_299_52.prefab_name] ~= nil then
						local var_299_58 = LuaForUtil.PlayVoiceWithCriLipsync(arg_296_1.actors_[var_299_52.prefab_name].transform, "story_v_side_new_1109701", "1109701072", "story_v_side_new_1109701.awb")

						arg_296_1:RecordAudio("1109701072", var_299_58)
						arg_296_1:RecordAudio("1109701072", var_299_58)
					else
						arg_296_1:AudioAction("play", "voice", "story_v_side_new_1109701", "1109701072", "story_v_side_new_1109701.awb")
					end

					arg_296_1:RecordHistoryTalkVoice("story_v_side_new_1109701", "1109701072", "story_v_side_new_1109701.awb")
				end

				arg_296_1:RecordContent(arg_296_1.text_.text)
			end

			local var_299_59 = math.max(var_299_50, arg_296_1.talkMaxDuration)

			if var_299_49 <= arg_296_1.time_ and arg_296_1.time_ < var_299_49 + var_299_59 then
				arg_296_1.typewritter.percent = (arg_296_1.time_ - var_299_49) / var_299_59

				arg_296_1.typewritter:SetDirty()
			end

			if arg_296_1.time_ >= var_299_49 + var_299_59 and arg_296_1.time_ < var_299_49 + var_299_59 + arg_299_0 then
				arg_296_1.typewritter.percent = 1

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(true)
			end
		end

		arg_296_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6045_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6046_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_296_1:InitPlayNodeList()
	end,
	Play1109701073 = function(arg_300_0, arg_300_1)
		arg_300_1.time_ = 0
		arg_300_1.frameCnt_ = 0
		arg_300_1.state_ = "playing"
		arg_300_1.curTalkId_ = 1109701073
		arg_300_1.duration_ = 4.67

		local var_300_0 = {
			zh = 4.666,
			ja = 4.1
		}
		local var_300_1 = manager.audio:GetLocalizationFlag()

		if var_300_0[var_300_1] ~= nil then
			arg_300_1.duration_ = var_300_0[var_300_1]
		end

		SetActive(arg_300_1.tipsGo_, false)

		function arg_300_1.onSingleLineFinish_()
			arg_300_1.onSingleLineUpdate_ = nil
			arg_300_1.onSingleLineFinish_ = nil
			arg_300_1.state_ = "waiting"
		end

		function arg_300_1.playNext_(arg_302_0)
			if arg_302_0 == 1 then
				arg_300_0:Play1109701074(arg_300_1)
			end
		end

		function arg_300_1.onSingleLineUpdate_(arg_303_0)
			local var_303_0 = arg_300_1.actors_["6045_story"].transform
			local var_303_1 = 0

			if var_303_1 < arg_300_1.time_ and arg_300_1.time_ <= var_303_1 + arg_303_0 then
				arg_300_1.var_.moveOldPos6045_story = var_303_0.localPosition

				local var_303_2 = GameObjectTools.GetOrAddComponent(var_303_0.gameObject, typeof(DynamicBoneHelper))

				if var_303_2 then
					var_303_2:EnableDynamicBone(false)
				end
			end

			local var_303_3 = 0.001

			if var_303_1 <= arg_300_1.time_ and arg_300_1.time_ < var_303_1 + var_303_3 then
				local var_303_4 = (arg_300_1.time_ - var_303_1) / var_303_3
				local var_303_5 = Vector3.New(-0.7, -0.5, -6.3)

				var_303_0.localPosition = Vector3.Lerp(arg_300_1.var_.moveOldPos6045_story, var_303_5, var_303_4)

				local var_303_6 = manager.ui.mainCamera.transform.position - var_303_0.position

				var_303_0.forward = Vector3.New(var_303_6.x, var_303_6.y, var_303_6.z)

				local var_303_7 = var_303_0.localEulerAngles

				var_303_7.z = 0
				var_303_7.x = 0
				var_303_0.localEulerAngles = var_303_7
			end

			if arg_300_1.time_ >= var_303_1 + var_303_3 and arg_300_1.time_ < var_303_1 + var_303_3 + arg_303_0 then
				var_303_0.localPosition = Vector3.New(-0.7, -0.5, -6.3)

				local var_303_8 = manager.ui.mainCamera.transform.position - var_303_0.position

				var_303_0.forward = Vector3.New(var_303_8.x, var_303_8.y, var_303_8.z)

				local var_303_9 = var_303_0.localEulerAngles

				var_303_9.z = 0
				var_303_9.x = 0
				var_303_0.localEulerAngles = var_303_9

				local var_303_10 = GameObjectTools.GetOrAddComponent(var_303_0.gameObject, typeof(DynamicBoneHelper))

				if var_303_10 then
					var_303_10:EnableDynamicBone(true)
				end
			end

			local var_303_11 = arg_300_1.actors_["6045_story"]
			local var_303_12 = 0

			if var_303_12 < arg_300_1.time_ and arg_300_1.time_ <= var_303_12 + arg_303_0 and not isNil(var_303_11) and arg_300_1.var_.characterEffect6045_story == nil then
				arg_300_1.var_.characterEffect6045_story = var_303_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_303_13 = 0.200000002980232

			if var_303_12 <= arg_300_1.time_ and arg_300_1.time_ < var_303_12 + var_303_13 and not isNil(var_303_11) then
				local var_303_14 = (arg_300_1.time_ - var_303_12) / var_303_13

				if arg_300_1.var_.characterEffect6045_story and not isNil(var_303_11) then
					arg_300_1.var_.characterEffect6045_story.fillFlat = false
				end
			end

			if arg_300_1.time_ >= var_303_12 + var_303_13 and arg_300_1.time_ < var_303_12 + var_303_13 + arg_303_0 and not isNil(var_303_11) and arg_300_1.var_.characterEffect6045_story then
				arg_300_1.var_.characterEffect6045_story.fillFlat = false
			end

			local var_303_15 = 0

			if var_303_15 < arg_300_1.time_ and arg_300_1.time_ <= var_303_15 + arg_303_0 then
				arg_300_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/story6045/story6045action/6045action4_1")
			end

			local var_303_16 = 0

			if var_303_16 < arg_300_1.time_ and arg_300_1.time_ <= var_303_16 + arg_303_0 then
				arg_300_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_303_17 = arg_300_1.actors_["6046_story"]
			local var_303_18 = 0

			if var_303_18 < arg_300_1.time_ and arg_300_1.time_ <= var_303_18 + arg_303_0 and not isNil(var_303_17) and arg_300_1.var_.characterEffect6046_story == nil then
				arg_300_1.var_.characterEffect6046_story = var_303_17:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_303_19 = 0.200000002980232

			if var_303_18 <= arg_300_1.time_ and arg_300_1.time_ < var_303_18 + var_303_19 and not isNil(var_303_17) then
				local var_303_20 = (arg_300_1.time_ - var_303_18) / var_303_19

				if arg_300_1.var_.characterEffect6046_story and not isNil(var_303_17) then
					local var_303_21 = Mathf.Lerp(0, 0.5, var_303_20)

					arg_300_1.var_.characterEffect6046_story.fillFlat = true
					arg_300_1.var_.characterEffect6046_story.fillRatio = var_303_21
				end
			end

			if arg_300_1.time_ >= var_303_18 + var_303_19 and arg_300_1.time_ < var_303_18 + var_303_19 + arg_303_0 and not isNil(var_303_17) and arg_300_1.var_.characterEffect6046_story then
				local var_303_22 = 0.5

				arg_300_1.var_.characterEffect6046_story.fillFlat = true
				arg_300_1.var_.characterEffect6046_story.fillRatio = var_303_22
			end

			local var_303_23 = 0
			local var_303_24 = 0.375

			if var_303_23 < arg_300_1.time_ and arg_300_1.time_ <= var_303_23 + arg_303_0 then
				arg_300_1.talkMaxDuration = 0
				arg_300_1.dialogCg_.alpha = 1

				arg_300_1.dialog_:SetActive(true)
				SetActive(arg_300_1.leftNameGo_, true)

				local var_303_25 = arg_300_1:FormatText(StoryNameCfg[215].name)

				arg_300_1.leftNameTxt_.text = var_303_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_300_1.leftNameTxt_.transform)

				arg_300_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_300_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_300_1:RecordName(arg_300_1.leftNameTxt_.text)
				SetActive(arg_300_1.iconTrs_.gameObject, false)
				arg_300_1.callingController_:SetSelectedState("normal")

				local var_303_26 = arg_300_1:GetWordFromCfg(1109701073)
				local var_303_27 = arg_300_1:FormatText(var_303_26.content)

				arg_300_1.text_.text = var_303_27

				LuaForUtil.ClearLinePrefixSymbol(arg_300_1.text_)

				local var_303_28 = 15
				local var_303_29 = utf8.len(var_303_27)
				local var_303_30 = var_303_28 <= 0 and var_303_24 or var_303_24 * (var_303_29 / var_303_28)

				if var_303_30 > 0 and var_303_24 < var_303_30 then
					arg_300_1.talkMaxDuration = var_303_30

					if var_303_30 + var_303_23 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_30 + var_303_23
					end
				end

				arg_300_1.text_.text = var_303_27
				arg_300_1.typewritter.percent = 0

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701073", "story_v_side_new_1109701.awb") ~= 0 then
					local var_303_31 = manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701073", "story_v_side_new_1109701.awb") / 1000

					if var_303_31 + var_303_23 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_31 + var_303_23
					end

					if var_303_26.prefab_name ~= "" and arg_300_1.actors_[var_303_26.prefab_name] ~= nil then
						local var_303_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_300_1.actors_[var_303_26.prefab_name].transform, "story_v_side_new_1109701", "1109701073", "story_v_side_new_1109701.awb")

						arg_300_1:RecordAudio("1109701073", var_303_32)
						arg_300_1:RecordAudio("1109701073", var_303_32)
					else
						arg_300_1:AudioAction("play", "voice", "story_v_side_new_1109701", "1109701073", "story_v_side_new_1109701.awb")
					end

					arg_300_1:RecordHistoryTalkVoice("story_v_side_new_1109701", "1109701073", "story_v_side_new_1109701.awb")
				end

				arg_300_1:RecordContent(arg_300_1.text_.text)
			end

			local var_303_33 = math.max(var_303_24, arg_300_1.talkMaxDuration)

			if var_303_23 <= arg_300_1.time_ and arg_300_1.time_ < var_303_23 + var_303_33 then
				arg_300_1.typewritter.percent = (arg_300_1.time_ - var_303_23) / var_303_33

				arg_300_1.typewritter:SetDirty()
			end

			if arg_300_1.time_ >= var_303_23 + var_303_33 and arg_300_1.time_ < var_303_23 + var_303_33 + arg_303_0 then
				arg_300_1.typewritter.percent = 1

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(true)
			end
		end

		arg_300_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6045_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_300_1:InitPlayNodeList()
	end,
	Play1109701074 = function(arg_304_0, arg_304_1)
		arg_304_1.time_ = 0
		arg_304_1.frameCnt_ = 0
		arg_304_1.state_ = "playing"
		arg_304_1.curTalkId_ = 1109701074
		arg_304_1.duration_ = 5

		SetActive(arg_304_1.tipsGo_, false)

		function arg_304_1.onSingleLineFinish_()
			arg_304_1.onSingleLineUpdate_ = nil
			arg_304_1.onSingleLineFinish_ = nil
			arg_304_1.state_ = "waiting"
		end

		function arg_304_1.playNext_(arg_306_0)
			if arg_306_0 == 1 then
				arg_304_0:Play1109701075(arg_304_1)
			end
		end

		function arg_304_1.onSingleLineUpdate_(arg_307_0)
			local var_307_0 = arg_304_1.actors_["6045_story"]
			local var_307_1 = 0

			if var_307_1 < arg_304_1.time_ and arg_304_1.time_ <= var_307_1 + arg_307_0 and not isNil(var_307_0) and arg_304_1.var_.characterEffect6045_story == nil then
				arg_304_1.var_.characterEffect6045_story = var_307_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_307_2 = 0.200000002980232

			if var_307_1 <= arg_304_1.time_ and arg_304_1.time_ < var_307_1 + var_307_2 and not isNil(var_307_0) then
				local var_307_3 = (arg_304_1.time_ - var_307_1) / var_307_2

				if arg_304_1.var_.characterEffect6045_story and not isNil(var_307_0) then
					local var_307_4 = Mathf.Lerp(0, 0.5, var_307_3)

					arg_304_1.var_.characterEffect6045_story.fillFlat = true
					arg_304_1.var_.characterEffect6045_story.fillRatio = var_307_4
				end
			end

			if arg_304_1.time_ >= var_307_1 + var_307_2 and arg_304_1.time_ < var_307_1 + var_307_2 + arg_307_0 and not isNil(var_307_0) and arg_304_1.var_.characterEffect6045_story then
				local var_307_5 = 0.5

				arg_304_1.var_.characterEffect6045_story.fillFlat = true
				arg_304_1.var_.characterEffect6045_story.fillRatio = var_307_5
			end

			local var_307_6 = 0
			local var_307_7 = 0.125

			if var_307_6 < arg_304_1.time_ and arg_304_1.time_ <= var_307_6 + arg_307_0 then
				arg_304_1.talkMaxDuration = 0
				arg_304_1.dialogCg_.alpha = 1

				arg_304_1.dialog_:SetActive(true)
				SetActive(arg_304_1.leftNameGo_, true)

				local var_307_8 = arg_304_1:FormatText(StoryNameCfg[7].name)

				arg_304_1.leftNameTxt_.text = var_307_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_304_1.leftNameTxt_.transform)

				arg_304_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_304_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_304_1:RecordName(arg_304_1.leftNameTxt_.text)
				SetActive(arg_304_1.iconTrs_.gameObject, true)
				arg_304_1.iconController_:SetSelectedState("hero")

				arg_304_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_304_1.callingController_:SetSelectedState("normal")

				arg_304_1.keyicon_.color = Color.New(1, 1, 1)
				arg_304_1.icon_.color = Color.New(1, 1, 1)

				local var_307_9 = arg_304_1:GetWordFromCfg(1109701074)
				local var_307_10 = arg_304_1:FormatText(var_307_9.content)

				arg_304_1.text_.text = var_307_10

				LuaForUtil.ClearLinePrefixSymbol(arg_304_1.text_)

				local var_307_11 = 5
				local var_307_12 = utf8.len(var_307_10)
				local var_307_13 = var_307_11 <= 0 and var_307_7 or var_307_7 * (var_307_12 / var_307_11)

				if var_307_13 > 0 and var_307_7 < var_307_13 then
					arg_304_1.talkMaxDuration = var_307_13

					if var_307_13 + var_307_6 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_13 + var_307_6
					end
				end

				arg_304_1.text_.text = var_307_10
				arg_304_1.typewritter.percent = 0

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(false)
				arg_304_1:RecordContent(arg_304_1.text_.text)
			end

			local var_307_14 = math.max(var_307_7, arg_304_1.talkMaxDuration)

			if var_307_6 <= arg_304_1.time_ and arg_304_1.time_ < var_307_6 + var_307_14 then
				arg_304_1.typewritter.percent = (arg_304_1.time_ - var_307_6) / var_307_14

				arg_304_1.typewritter:SetDirty()
			end

			if arg_304_1.time_ >= var_307_6 + var_307_14 and arg_304_1.time_ < var_307_6 + var_307_14 + arg_307_0 then
				arg_304_1.typewritter.percent = 1

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(true)
			end
		end

		arg_304_1.nodeConfigList_ = {}

		arg_304_1:InitPlayNodeList()
	end,
	Play1109701075 = function(arg_308_0, arg_308_1)
		arg_308_1.time_ = 0
		arg_308_1.frameCnt_ = 0
		arg_308_1.state_ = "playing"
		arg_308_1.curTalkId_ = 1109701075
		arg_308_1.duration_ = 5

		SetActive(arg_308_1.tipsGo_, false)

		function arg_308_1.onSingleLineFinish_()
			arg_308_1.onSingleLineUpdate_ = nil
			arg_308_1.onSingleLineFinish_ = nil
			arg_308_1.state_ = "waiting"
		end

		function arg_308_1.playNext_(arg_310_0)
			if arg_310_0 == 1 then
				arg_308_0:Play1109701076(arg_308_1)
			end
		end

		function arg_308_1.onSingleLineUpdate_(arg_311_0)
			local var_311_0 = arg_308_1.actors_["6045_story"].transform
			local var_311_1 = 0

			if var_311_1 < arg_308_1.time_ and arg_308_1.time_ <= var_311_1 + arg_311_0 then
				arg_308_1.var_.moveOldPos6045_story = var_311_0.localPosition

				local var_311_2 = GameObjectTools.GetOrAddComponent(var_311_0.gameObject, typeof(DynamicBoneHelper))

				if var_311_2 then
					var_311_2:EnableDynamicBone(false)
				end
			end

			local var_311_3 = 0.001

			if var_311_1 <= arg_308_1.time_ and arg_308_1.time_ < var_311_1 + var_311_3 then
				local var_311_4 = (arg_308_1.time_ - var_311_1) / var_311_3
				local var_311_5 = Vector3.New(0, 100, 0)

				var_311_0.localPosition = Vector3.Lerp(arg_308_1.var_.moveOldPos6045_story, var_311_5, var_311_4)

				local var_311_6 = manager.ui.mainCamera.transform.position - var_311_0.position

				var_311_0.forward = Vector3.New(var_311_6.x, var_311_6.y, var_311_6.z)

				local var_311_7 = var_311_0.localEulerAngles

				var_311_7.z = 0
				var_311_7.x = 0
				var_311_0.localEulerAngles = var_311_7
			end

			if arg_308_1.time_ >= var_311_1 + var_311_3 and arg_308_1.time_ < var_311_1 + var_311_3 + arg_311_0 then
				var_311_0.localPosition = Vector3.New(0, 100, 0)

				local var_311_8 = manager.ui.mainCamera.transform.position - var_311_0.position

				var_311_0.forward = Vector3.New(var_311_8.x, var_311_8.y, var_311_8.z)

				local var_311_9 = var_311_0.localEulerAngles

				var_311_9.z = 0
				var_311_9.x = 0
				var_311_0.localEulerAngles = var_311_9

				local var_311_10 = GameObjectTools.GetOrAddComponent(var_311_0.gameObject, typeof(DynamicBoneHelper))

				if var_311_10 then
					var_311_10:EnableDynamicBone(true)
				end
			end

			local var_311_11 = arg_308_1.actors_["6045_story"]
			local var_311_12 = 0

			if var_311_12 < arg_308_1.time_ and arg_308_1.time_ <= var_311_12 + arg_311_0 and not isNil(var_311_11) and arg_308_1.var_.characterEffect6045_story == nil then
				arg_308_1.var_.characterEffect6045_story = var_311_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_311_13 = 0.200000002980232

			if var_311_12 <= arg_308_1.time_ and arg_308_1.time_ < var_311_12 + var_311_13 and not isNil(var_311_11) then
				local var_311_14 = (arg_308_1.time_ - var_311_12) / var_311_13

				if arg_308_1.var_.characterEffect6045_story and not isNil(var_311_11) then
					local var_311_15 = Mathf.Lerp(0, 0.5, var_311_14)

					arg_308_1.var_.characterEffect6045_story.fillFlat = true
					arg_308_1.var_.characterEffect6045_story.fillRatio = var_311_15
				end
			end

			if arg_308_1.time_ >= var_311_12 + var_311_13 and arg_308_1.time_ < var_311_12 + var_311_13 + arg_311_0 and not isNil(var_311_11) and arg_308_1.var_.characterEffect6045_story then
				local var_311_16 = 0.5

				arg_308_1.var_.characterEffect6045_story.fillFlat = true
				arg_308_1.var_.characterEffect6045_story.fillRatio = var_311_16
			end

			local var_311_17 = arg_308_1.actors_["6046_story"].transform
			local var_311_18 = 0

			if var_311_18 < arg_308_1.time_ and arg_308_1.time_ <= var_311_18 + arg_311_0 then
				arg_308_1.var_.moveOldPos6046_story = var_311_17.localPosition

				local var_311_19 = GameObjectTools.GetOrAddComponent(var_311_17.gameObject, typeof(DynamicBoneHelper))

				if var_311_19 then
					var_311_19:EnableDynamicBone(false)
				end
			end

			local var_311_20 = 0.001

			if var_311_18 <= arg_308_1.time_ and arg_308_1.time_ < var_311_18 + var_311_20 then
				local var_311_21 = (arg_308_1.time_ - var_311_18) / var_311_20
				local var_311_22 = Vector3.New(0, 100, 0)

				var_311_17.localPosition = Vector3.Lerp(arg_308_1.var_.moveOldPos6046_story, var_311_22, var_311_21)

				local var_311_23 = manager.ui.mainCamera.transform.position - var_311_17.position

				var_311_17.forward = Vector3.New(var_311_23.x, var_311_23.y, var_311_23.z)

				local var_311_24 = var_311_17.localEulerAngles

				var_311_24.z = 0
				var_311_24.x = 0
				var_311_17.localEulerAngles = var_311_24
			end

			if arg_308_1.time_ >= var_311_18 + var_311_20 and arg_308_1.time_ < var_311_18 + var_311_20 + arg_311_0 then
				var_311_17.localPosition = Vector3.New(0, 100, 0)

				local var_311_25 = manager.ui.mainCamera.transform.position - var_311_17.position

				var_311_17.forward = Vector3.New(var_311_25.x, var_311_25.y, var_311_25.z)

				local var_311_26 = var_311_17.localEulerAngles

				var_311_26.z = 0
				var_311_26.x = 0
				var_311_17.localEulerAngles = var_311_26

				local var_311_27 = GameObjectTools.GetOrAddComponent(var_311_17.gameObject, typeof(DynamicBoneHelper))

				if var_311_27 then
					var_311_27:EnableDynamicBone(true)
				end
			end

			local var_311_28 = arg_308_1.actors_["6046_story"]
			local var_311_29 = 0

			if var_311_29 < arg_308_1.time_ and arg_308_1.time_ <= var_311_29 + arg_311_0 and not isNil(var_311_28) and arg_308_1.var_.characterEffect6046_story == nil then
				arg_308_1.var_.characterEffect6046_story = var_311_28:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_311_30 = 0.200000002980232

			if var_311_29 <= arg_308_1.time_ and arg_308_1.time_ < var_311_29 + var_311_30 and not isNil(var_311_28) then
				local var_311_31 = (arg_308_1.time_ - var_311_29) / var_311_30

				if arg_308_1.var_.characterEffect6046_story and not isNil(var_311_28) then
					local var_311_32 = Mathf.Lerp(0, 0.5, var_311_31)

					arg_308_1.var_.characterEffect6046_story.fillFlat = true
					arg_308_1.var_.characterEffect6046_story.fillRatio = var_311_32
				end
			end

			if arg_308_1.time_ >= var_311_29 + var_311_30 and arg_308_1.time_ < var_311_29 + var_311_30 + arg_311_0 and not isNil(var_311_28) and arg_308_1.var_.characterEffect6046_story then
				local var_311_33 = 0.5

				arg_308_1.var_.characterEffect6046_story.fillFlat = true
				arg_308_1.var_.characterEffect6046_story.fillRatio = var_311_33
			end

			local var_311_34 = 0
			local var_311_35 = 0.625

			if var_311_34 < arg_308_1.time_ and arg_308_1.time_ <= var_311_34 + arg_311_0 then
				arg_308_1.talkMaxDuration = 0
				arg_308_1.dialogCg_.alpha = 1

				arg_308_1.dialog_:SetActive(true)
				SetActive(arg_308_1.leftNameGo_, true)

				local var_311_36 = arg_308_1:FormatText(StoryNameCfg[7].name)

				arg_308_1.leftNameTxt_.text = var_311_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_308_1.leftNameTxt_.transform)

				arg_308_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_308_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_308_1:RecordName(arg_308_1.leftNameTxt_.text)
				SetActive(arg_308_1.iconTrs_.gameObject, true)
				arg_308_1.iconController_:SetSelectedState("hero")

				arg_308_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_308_1.callingController_:SetSelectedState("normal")

				arg_308_1.keyicon_.color = Color.New(1, 1, 1)
				arg_308_1.icon_.color = Color.New(1, 1, 1)

				local var_311_37 = arg_308_1:GetWordFromCfg(1109701075)
				local var_311_38 = arg_308_1:FormatText(var_311_37.content)

				arg_308_1.text_.text = var_311_38

				LuaForUtil.ClearLinePrefixSymbol(arg_308_1.text_)

				local var_311_39 = 25
				local var_311_40 = utf8.len(var_311_38)
				local var_311_41 = var_311_39 <= 0 and var_311_35 or var_311_35 * (var_311_40 / var_311_39)

				if var_311_41 > 0 and var_311_35 < var_311_41 then
					arg_308_1.talkMaxDuration = var_311_41

					if var_311_41 + var_311_34 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_41 + var_311_34
					end
				end

				arg_308_1.text_.text = var_311_38
				arg_308_1.typewritter.percent = 0

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(false)
				arg_308_1:RecordContent(arg_308_1.text_.text)
			end

			local var_311_42 = math.max(var_311_35, arg_308_1.talkMaxDuration)

			if var_311_34 <= arg_308_1.time_ and arg_308_1.time_ < var_311_34 + var_311_42 then
				arg_308_1.typewritter.percent = (arg_308_1.time_ - var_311_34) / var_311_42

				arg_308_1.typewritter:SetDirty()
			end

			if arg_308_1.time_ >= var_311_34 + var_311_42 and arg_308_1.time_ < var_311_34 + var_311_42 + arg_311_0 then
				arg_308_1.typewritter.percent = 1

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(true)
			end
		end

		arg_308_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6045_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6046_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_308_1:InitPlayNodeList()
	end,
	Play1109701076 = function(arg_312_0, arg_312_1)
		arg_312_1.time_ = 0
		arg_312_1.frameCnt_ = 0
		arg_312_1.state_ = "playing"
		arg_312_1.curTalkId_ = 1109701076
		arg_312_1.duration_ = 6.63

		local var_312_0 = {
			zh = 5.066,
			ja = 6.633
		}
		local var_312_1 = manager.audio:GetLocalizationFlag()

		if var_312_0[var_312_1] ~= nil then
			arg_312_1.duration_ = var_312_0[var_312_1]
		end

		SetActive(arg_312_1.tipsGo_, false)

		function arg_312_1.onSingleLineFinish_()
			arg_312_1.onSingleLineUpdate_ = nil
			arg_312_1.onSingleLineFinish_ = nil
			arg_312_1.state_ = "waiting"
		end

		function arg_312_1.playNext_(arg_314_0)
			if arg_314_0 == 1 then
				arg_312_0:Play1109701077(arg_312_1)
			end
		end

		function arg_312_1.onSingleLineUpdate_(arg_315_0)
			local var_315_0 = arg_312_1.actors_["1097ui_story"].transform
			local var_315_1 = 0

			if var_315_1 < arg_312_1.time_ and arg_312_1.time_ <= var_315_1 + arg_315_0 then
				arg_312_1.var_.moveOldPos1097ui_story = var_315_0.localPosition
			end

			local var_315_2 = 0.001

			if var_315_1 <= arg_312_1.time_ and arg_312_1.time_ < var_315_1 + var_315_2 then
				local var_315_3 = (arg_312_1.time_ - var_315_1) / var_315_2
				local var_315_4 = Vector3.New(0, -0.54, -6.3)

				var_315_0.localPosition = Vector3.Lerp(arg_312_1.var_.moveOldPos1097ui_story, var_315_4, var_315_3)

				local var_315_5 = manager.ui.mainCamera.transform.position - var_315_0.position

				var_315_0.forward = Vector3.New(var_315_5.x, var_315_5.y, var_315_5.z)

				local var_315_6 = var_315_0.localEulerAngles

				var_315_6.z = 0
				var_315_6.x = 0
				var_315_0.localEulerAngles = var_315_6
			end

			if arg_312_1.time_ >= var_315_1 + var_315_2 and arg_312_1.time_ < var_315_1 + var_315_2 + arg_315_0 then
				var_315_0.localPosition = Vector3.New(0, -0.54, -6.3)

				local var_315_7 = manager.ui.mainCamera.transform.position - var_315_0.position

				var_315_0.forward = Vector3.New(var_315_7.x, var_315_7.y, var_315_7.z)

				local var_315_8 = var_315_0.localEulerAngles

				var_315_8.z = 0
				var_315_8.x = 0
				var_315_0.localEulerAngles = var_315_8
			end

			local var_315_9 = arg_312_1.actors_["1097ui_story"]
			local var_315_10 = 0

			if var_315_10 < arg_312_1.time_ and arg_312_1.time_ <= var_315_10 + arg_315_0 and not isNil(var_315_9) and arg_312_1.var_.characterEffect1097ui_story == nil then
				arg_312_1.var_.characterEffect1097ui_story = var_315_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_315_11 = 0.200000002980232

			if var_315_10 <= arg_312_1.time_ and arg_312_1.time_ < var_315_10 + var_315_11 and not isNil(var_315_9) then
				local var_315_12 = (arg_312_1.time_ - var_315_10) / var_315_11

				if arg_312_1.var_.characterEffect1097ui_story and not isNil(var_315_9) then
					arg_312_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_312_1.time_ >= var_315_10 + var_315_11 and arg_312_1.time_ < var_315_10 + var_315_11 + arg_315_0 and not isNil(var_315_9) and arg_312_1.var_.characterEffect1097ui_story then
				arg_312_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_315_13 = 0

			if var_315_13 < arg_312_1.time_ and arg_312_1.time_ <= var_315_13 + arg_315_0 then
				arg_312_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action7_2")
			end

			local var_315_14 = 0

			if var_315_14 < arg_312_1.time_ and arg_312_1.time_ <= var_315_14 + arg_315_0 then
				arg_312_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_315_15 = 0
			local var_315_16 = 0.675

			if var_315_15 < arg_312_1.time_ and arg_312_1.time_ <= var_315_15 + arg_315_0 then
				arg_312_1.talkMaxDuration = 0
				arg_312_1.dialogCg_.alpha = 1

				arg_312_1.dialog_:SetActive(true)
				SetActive(arg_312_1.leftNameGo_, true)

				local var_315_17 = arg_312_1:FormatText(StoryNameCfg[216].name)

				arg_312_1.leftNameTxt_.text = var_315_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_312_1.leftNameTxt_.transform)

				arg_312_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_312_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_312_1:RecordName(arg_312_1.leftNameTxt_.text)
				SetActive(arg_312_1.iconTrs_.gameObject, false)
				arg_312_1.callingController_:SetSelectedState("normal")

				local var_315_18 = arg_312_1:GetWordFromCfg(1109701076)
				local var_315_19 = arg_312_1:FormatText(var_315_18.content)

				arg_312_1.text_.text = var_315_19

				LuaForUtil.ClearLinePrefixSymbol(arg_312_1.text_)

				local var_315_20 = 27
				local var_315_21 = utf8.len(var_315_19)
				local var_315_22 = var_315_20 <= 0 and var_315_16 or var_315_16 * (var_315_21 / var_315_20)

				if var_315_22 > 0 and var_315_16 < var_315_22 then
					arg_312_1.talkMaxDuration = var_315_22

					if var_315_22 + var_315_15 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_22 + var_315_15
					end
				end

				arg_312_1.text_.text = var_315_19
				arg_312_1.typewritter.percent = 0

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701076", "story_v_side_new_1109701.awb") ~= 0 then
					local var_315_23 = manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701076", "story_v_side_new_1109701.awb") / 1000

					if var_315_23 + var_315_15 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_23 + var_315_15
					end

					if var_315_18.prefab_name ~= "" and arg_312_1.actors_[var_315_18.prefab_name] ~= nil then
						local var_315_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_312_1.actors_[var_315_18.prefab_name].transform, "story_v_side_new_1109701", "1109701076", "story_v_side_new_1109701.awb")

						arg_312_1:RecordAudio("1109701076", var_315_24)
						arg_312_1:RecordAudio("1109701076", var_315_24)
					else
						arg_312_1:AudioAction("play", "voice", "story_v_side_new_1109701", "1109701076", "story_v_side_new_1109701.awb")
					end

					arg_312_1:RecordHistoryTalkVoice("story_v_side_new_1109701", "1109701076", "story_v_side_new_1109701.awb")
				end

				arg_312_1:RecordContent(arg_312_1.text_.text)
			end

			local var_315_25 = math.max(var_315_16, arg_312_1.talkMaxDuration)

			if var_315_15 <= arg_312_1.time_ and arg_312_1.time_ < var_315_15 + var_315_25 then
				arg_312_1.typewritter.percent = (arg_312_1.time_ - var_315_15) / var_315_25

				arg_312_1.typewritter:SetDirty()
			end

			if arg_312_1.time_ >= var_315_15 + var_315_25 and arg_312_1.time_ < var_315_15 + var_315_25 + arg_315_0 then
				arg_312_1.typewritter.percent = 1

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(true)
			end
		end

		arg_312_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_312_1:InitPlayNodeList()
	end,
	Play1109701077 = function(arg_316_0, arg_316_1)
		arg_316_1.time_ = 0
		arg_316_1.frameCnt_ = 0
		arg_316_1.state_ = "playing"
		arg_316_1.curTalkId_ = 1109701077
		arg_316_1.duration_ = 5

		SetActive(arg_316_1.tipsGo_, false)

		function arg_316_1.onSingleLineFinish_()
			arg_316_1.onSingleLineUpdate_ = nil
			arg_316_1.onSingleLineFinish_ = nil
			arg_316_1.state_ = "waiting"
		end

		function arg_316_1.playNext_(arg_318_0)
			if arg_318_0 == 1 then
				arg_316_0:Play1109701078(arg_316_1)
			end
		end

		function arg_316_1.onSingleLineUpdate_(arg_319_0)
			local var_319_0 = arg_316_1.actors_["1097ui_story"]
			local var_319_1 = 0

			if var_319_1 < arg_316_1.time_ and arg_316_1.time_ <= var_319_1 + arg_319_0 and not isNil(var_319_0) and arg_316_1.var_.characterEffect1097ui_story == nil then
				arg_316_1.var_.characterEffect1097ui_story = var_319_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_319_2 = 0.200000002980232

			if var_319_1 <= arg_316_1.time_ and arg_316_1.time_ < var_319_1 + var_319_2 and not isNil(var_319_0) then
				local var_319_3 = (arg_316_1.time_ - var_319_1) / var_319_2

				if arg_316_1.var_.characterEffect1097ui_story and not isNil(var_319_0) then
					local var_319_4 = Mathf.Lerp(0, 0.5, var_319_3)

					arg_316_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_316_1.var_.characterEffect1097ui_story.fillRatio = var_319_4
				end
			end

			if arg_316_1.time_ >= var_319_1 + var_319_2 and arg_316_1.time_ < var_319_1 + var_319_2 + arg_319_0 and not isNil(var_319_0) and arg_316_1.var_.characterEffect1097ui_story then
				local var_319_5 = 0.5

				arg_316_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_316_1.var_.characterEffect1097ui_story.fillRatio = var_319_5
			end

			local var_319_6 = 0
			local var_319_7 = 0.1

			if var_319_6 < arg_316_1.time_ and arg_316_1.time_ <= var_319_6 + arg_319_0 then
				arg_316_1.talkMaxDuration = 0
				arg_316_1.dialogCg_.alpha = 1

				arg_316_1.dialog_:SetActive(true)
				SetActive(arg_316_1.leftNameGo_, true)

				local var_319_8 = arg_316_1:FormatText(StoryNameCfg[7].name)

				arg_316_1.leftNameTxt_.text = var_319_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_316_1.leftNameTxt_.transform)

				arg_316_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_316_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_316_1:RecordName(arg_316_1.leftNameTxt_.text)
				SetActive(arg_316_1.iconTrs_.gameObject, true)
				arg_316_1.iconController_:SetSelectedState("hero")

				arg_316_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_316_1.callingController_:SetSelectedState("normal")

				arg_316_1.keyicon_.color = Color.New(1, 1, 1)
				arg_316_1.icon_.color = Color.New(1, 1, 1)

				local var_319_9 = arg_316_1:GetWordFromCfg(1109701077)
				local var_319_10 = arg_316_1:FormatText(var_319_9.content)

				arg_316_1.text_.text = var_319_10

				LuaForUtil.ClearLinePrefixSymbol(arg_316_1.text_)

				local var_319_11 = 4
				local var_319_12 = utf8.len(var_319_10)
				local var_319_13 = var_319_11 <= 0 and var_319_7 or var_319_7 * (var_319_12 / var_319_11)

				if var_319_13 > 0 and var_319_7 < var_319_13 then
					arg_316_1.talkMaxDuration = var_319_13

					if var_319_13 + var_319_6 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_13 + var_319_6
					end
				end

				arg_316_1.text_.text = var_319_10
				arg_316_1.typewritter.percent = 0

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(false)
				arg_316_1:RecordContent(arg_316_1.text_.text)
			end

			local var_319_14 = math.max(var_319_7, arg_316_1.talkMaxDuration)

			if var_319_6 <= arg_316_1.time_ and arg_316_1.time_ < var_319_6 + var_319_14 then
				arg_316_1.typewritter.percent = (arg_316_1.time_ - var_319_6) / var_319_14

				arg_316_1.typewritter:SetDirty()
			end

			if arg_316_1.time_ >= var_319_6 + var_319_14 and arg_316_1.time_ < var_319_6 + var_319_14 + arg_319_0 then
				arg_316_1.typewritter.percent = 1

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(true)
			end
		end

		arg_316_1.nodeConfigList_ = {}

		arg_316_1:InitPlayNodeList()
	end,
	Play1109701078 = function(arg_320_0, arg_320_1)
		arg_320_1.time_ = 0
		arg_320_1.frameCnt_ = 0
		arg_320_1.state_ = "playing"
		arg_320_1.curTalkId_ = 1109701078
		arg_320_1.duration_ = 5

		SetActive(arg_320_1.tipsGo_, false)

		function arg_320_1.onSingleLineFinish_()
			arg_320_1.onSingleLineUpdate_ = nil
			arg_320_1.onSingleLineFinish_ = nil
			arg_320_1.state_ = "waiting"
		end

		function arg_320_1.playNext_(arg_322_0)
			if arg_322_0 == 1 then
				arg_320_0:Play1109701079(arg_320_1)
			end
		end

		function arg_320_1.onSingleLineUpdate_(arg_323_0)
			local var_323_0 = 0
			local var_323_1 = 0.95

			if var_323_0 < arg_320_1.time_ and arg_320_1.time_ <= var_323_0 + arg_323_0 then
				arg_320_1.talkMaxDuration = 0
				arg_320_1.dialogCg_.alpha = 1

				arg_320_1.dialog_:SetActive(true)
				SetActive(arg_320_1.leftNameGo_, false)

				arg_320_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_320_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_320_1:RecordName(arg_320_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_320_1.iconTrs_.gameObject, false)
				arg_320_1.callingController_:SetSelectedState("normal")

				local var_323_2 = arg_320_1:GetWordFromCfg(1109701078)
				local var_323_3 = arg_320_1:FormatText(var_323_2.content)

				arg_320_1.text_.text = var_323_3

				LuaForUtil.ClearLinePrefixSymbol(arg_320_1.text_)

				local var_323_4 = 38
				local var_323_5 = utf8.len(var_323_3)
				local var_323_6 = var_323_4 <= 0 and var_323_1 or var_323_1 * (var_323_5 / var_323_4)

				if var_323_6 > 0 and var_323_1 < var_323_6 then
					arg_320_1.talkMaxDuration = var_323_6

					if var_323_6 + var_323_0 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_6 + var_323_0
					end
				end

				arg_320_1.text_.text = var_323_3
				arg_320_1.typewritter.percent = 0

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(false)
				arg_320_1:RecordContent(arg_320_1.text_.text)
			end

			local var_323_7 = math.max(var_323_1, arg_320_1.talkMaxDuration)

			if var_323_0 <= arg_320_1.time_ and arg_320_1.time_ < var_323_0 + var_323_7 then
				arg_320_1.typewritter.percent = (arg_320_1.time_ - var_323_0) / var_323_7

				arg_320_1.typewritter:SetDirty()
			end

			if arg_320_1.time_ >= var_323_0 + var_323_7 and arg_320_1.time_ < var_323_0 + var_323_7 + arg_323_0 then
				arg_320_1.typewritter.percent = 1

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(true)
			end
		end

		arg_320_1.nodeConfigList_ = {}

		arg_320_1:InitPlayNodeList()
	end,
	Play1109701079 = function(arg_324_0, arg_324_1)
		arg_324_1.time_ = 0
		arg_324_1.frameCnt_ = 0
		arg_324_1.state_ = "playing"
		arg_324_1.curTalkId_ = 1109701079
		arg_324_1.duration_ = 5

		SetActive(arg_324_1.tipsGo_, false)

		function arg_324_1.onSingleLineFinish_()
			arg_324_1.onSingleLineUpdate_ = nil
			arg_324_1.onSingleLineFinish_ = nil
			arg_324_1.state_ = "waiting"
		end

		function arg_324_1.playNext_(arg_326_0)
			if arg_326_0 == 1 then
				arg_324_0:Play1109701080(arg_324_1)
			end
		end

		function arg_324_1.onSingleLineUpdate_(arg_327_0)
			local var_327_0 = 0
			local var_327_1 = 0.325

			if var_327_0 < arg_324_1.time_ and arg_324_1.time_ <= var_327_0 + arg_327_0 then
				arg_324_1.talkMaxDuration = 0
				arg_324_1.dialogCg_.alpha = 1

				arg_324_1.dialog_:SetActive(true)
				SetActive(arg_324_1.leftNameGo_, true)

				local var_327_2 = arg_324_1:FormatText(StoryNameCfg[7].name)

				arg_324_1.leftNameTxt_.text = var_327_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_324_1.leftNameTxt_.transform)

				arg_324_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_324_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_324_1:RecordName(arg_324_1.leftNameTxt_.text)
				SetActive(arg_324_1.iconTrs_.gameObject, true)
				arg_324_1.iconController_:SetSelectedState("hero")

				arg_324_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_324_1.callingController_:SetSelectedState("normal")

				arg_324_1.keyicon_.color = Color.New(1, 1, 1)
				arg_324_1.icon_.color = Color.New(1, 1, 1)

				local var_327_3 = arg_324_1:GetWordFromCfg(1109701079)
				local var_327_4 = arg_324_1:FormatText(var_327_3.content)

				arg_324_1.text_.text = var_327_4

				LuaForUtil.ClearLinePrefixSymbol(arg_324_1.text_)

				local var_327_5 = 13
				local var_327_6 = utf8.len(var_327_4)
				local var_327_7 = var_327_5 <= 0 and var_327_1 or var_327_1 * (var_327_6 / var_327_5)

				if var_327_7 > 0 and var_327_1 < var_327_7 then
					arg_324_1.talkMaxDuration = var_327_7

					if var_327_7 + var_327_0 > arg_324_1.duration_ then
						arg_324_1.duration_ = var_327_7 + var_327_0
					end
				end

				arg_324_1.text_.text = var_327_4
				arg_324_1.typewritter.percent = 0

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(false)
				arg_324_1:RecordContent(arg_324_1.text_.text)
			end

			local var_327_8 = math.max(var_327_1, arg_324_1.talkMaxDuration)

			if var_327_0 <= arg_324_1.time_ and arg_324_1.time_ < var_327_0 + var_327_8 then
				arg_324_1.typewritter.percent = (arg_324_1.time_ - var_327_0) / var_327_8

				arg_324_1.typewritter:SetDirty()
			end

			if arg_324_1.time_ >= var_327_0 + var_327_8 and arg_324_1.time_ < var_327_0 + var_327_8 + arg_327_0 then
				arg_324_1.typewritter.percent = 1

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(true)
			end
		end

		arg_324_1.nodeConfigList_ = {}

		arg_324_1:InitPlayNodeList()
	end,
	Play1109701080 = function(arg_328_0, arg_328_1)
		arg_328_1.time_ = 0
		arg_328_1.frameCnt_ = 0
		arg_328_1.state_ = "playing"
		arg_328_1.curTalkId_ = 1109701080
		arg_328_1.duration_ = 7

		local var_328_0 = {
			zh = 6.133,
			ja = 7
		}
		local var_328_1 = manager.audio:GetLocalizationFlag()

		if var_328_0[var_328_1] ~= nil then
			arg_328_1.duration_ = var_328_0[var_328_1]
		end

		SetActive(arg_328_1.tipsGo_, false)

		function arg_328_1.onSingleLineFinish_()
			arg_328_1.onSingleLineUpdate_ = nil
			arg_328_1.onSingleLineFinish_ = nil
			arg_328_1.state_ = "waiting"
		end

		function arg_328_1.playNext_(arg_330_0)
			if arg_330_0 == 1 then
				arg_328_0:Play1109701081(arg_328_1)
			end
		end

		function arg_328_1.onSingleLineUpdate_(arg_331_0)
			local var_331_0 = arg_328_1.actors_["1097ui_story"]
			local var_331_1 = 0

			if var_331_1 < arg_328_1.time_ and arg_328_1.time_ <= var_331_1 + arg_331_0 and not isNil(var_331_0) and arg_328_1.var_.characterEffect1097ui_story == nil then
				arg_328_1.var_.characterEffect1097ui_story = var_331_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_331_2 = 0.200000002980232

			if var_331_1 <= arg_328_1.time_ and arg_328_1.time_ < var_331_1 + var_331_2 and not isNil(var_331_0) then
				local var_331_3 = (arg_328_1.time_ - var_331_1) / var_331_2

				if arg_328_1.var_.characterEffect1097ui_story and not isNil(var_331_0) then
					arg_328_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_328_1.time_ >= var_331_1 + var_331_2 and arg_328_1.time_ < var_331_1 + var_331_2 + arg_331_0 and not isNil(var_331_0) and arg_328_1.var_.characterEffect1097ui_story then
				arg_328_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_331_4 = 0

			if var_331_4 < arg_328_1.time_ and arg_328_1.time_ <= var_331_4 + arg_331_0 then
				arg_328_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			local var_331_5 = 0

			if var_331_5 < arg_328_1.time_ and arg_328_1.time_ <= var_331_5 + arg_331_0 then
				arg_328_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_331_6 = 0
			local var_331_7 = 0.45

			if var_331_6 < arg_328_1.time_ and arg_328_1.time_ <= var_331_6 + arg_331_0 then
				arg_328_1.talkMaxDuration = 0
				arg_328_1.dialogCg_.alpha = 1

				arg_328_1.dialog_:SetActive(true)
				SetActive(arg_328_1.leftNameGo_, true)

				local var_331_8 = arg_328_1:FormatText(StoryNameCfg[216].name)

				arg_328_1.leftNameTxt_.text = var_331_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_328_1.leftNameTxt_.transform)

				arg_328_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_328_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_328_1:RecordName(arg_328_1.leftNameTxt_.text)
				SetActive(arg_328_1.iconTrs_.gameObject, false)
				arg_328_1.callingController_:SetSelectedState("normal")

				local var_331_9 = arg_328_1:GetWordFromCfg(1109701080)
				local var_331_10 = arg_328_1:FormatText(var_331_9.content)

				arg_328_1.text_.text = var_331_10

				LuaForUtil.ClearLinePrefixSymbol(arg_328_1.text_)

				local var_331_11 = 18
				local var_331_12 = utf8.len(var_331_10)
				local var_331_13 = var_331_11 <= 0 and var_331_7 or var_331_7 * (var_331_12 / var_331_11)

				if var_331_13 > 0 and var_331_7 < var_331_13 then
					arg_328_1.talkMaxDuration = var_331_13

					if var_331_13 + var_331_6 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_13 + var_331_6
					end
				end

				arg_328_1.text_.text = var_331_10
				arg_328_1.typewritter.percent = 0

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701080", "story_v_side_new_1109701.awb") ~= 0 then
					local var_331_14 = manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701080", "story_v_side_new_1109701.awb") / 1000

					if var_331_14 + var_331_6 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_14 + var_331_6
					end

					if var_331_9.prefab_name ~= "" and arg_328_1.actors_[var_331_9.prefab_name] ~= nil then
						local var_331_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_328_1.actors_[var_331_9.prefab_name].transform, "story_v_side_new_1109701", "1109701080", "story_v_side_new_1109701.awb")

						arg_328_1:RecordAudio("1109701080", var_331_15)
						arg_328_1:RecordAudio("1109701080", var_331_15)
					else
						arg_328_1:AudioAction("play", "voice", "story_v_side_new_1109701", "1109701080", "story_v_side_new_1109701.awb")
					end

					arg_328_1:RecordHistoryTalkVoice("story_v_side_new_1109701", "1109701080", "story_v_side_new_1109701.awb")
				end

				arg_328_1:RecordContent(arg_328_1.text_.text)
			end

			local var_331_16 = math.max(var_331_7, arg_328_1.talkMaxDuration)

			if var_331_6 <= arg_328_1.time_ and arg_328_1.time_ < var_331_6 + var_331_16 then
				arg_328_1.typewritter.percent = (arg_328_1.time_ - var_331_6) / var_331_16

				arg_328_1.typewritter:SetDirty()
			end

			if arg_328_1.time_ >= var_331_6 + var_331_16 and arg_328_1.time_ < var_331_6 + var_331_16 + arg_331_0 then
				arg_328_1.typewritter.percent = 1

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(true)
			end
		end

		arg_328_1.nodeConfigList_ = {}

		arg_328_1:InitPlayNodeList()
	end,
	Play1109701081 = function(arg_332_0, arg_332_1)
		arg_332_1.time_ = 0
		arg_332_1.frameCnt_ = 0
		arg_332_1.state_ = "playing"
		arg_332_1.curTalkId_ = 1109701081
		arg_332_1.duration_ = 5

		SetActive(arg_332_1.tipsGo_, false)

		function arg_332_1.onSingleLineFinish_()
			arg_332_1.onSingleLineUpdate_ = nil
			arg_332_1.onSingleLineFinish_ = nil
			arg_332_1.state_ = "waiting"
		end

		function arg_332_1.playNext_(arg_334_0)
			if arg_334_0 == 1 then
				arg_332_0:Play1109701082(arg_332_1)
			end
		end

		function arg_332_1.onSingleLineUpdate_(arg_335_0)
			local var_335_0 = arg_332_1.actors_["1097ui_story"]
			local var_335_1 = 0

			if var_335_1 < arg_332_1.time_ and arg_332_1.time_ <= var_335_1 + arg_335_0 and not isNil(var_335_0) and arg_332_1.var_.characterEffect1097ui_story == nil then
				arg_332_1.var_.characterEffect1097ui_story = var_335_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_335_2 = 0.200000002980232

			if var_335_1 <= arg_332_1.time_ and arg_332_1.time_ < var_335_1 + var_335_2 and not isNil(var_335_0) then
				local var_335_3 = (arg_332_1.time_ - var_335_1) / var_335_2

				if arg_332_1.var_.characterEffect1097ui_story and not isNil(var_335_0) then
					local var_335_4 = Mathf.Lerp(0, 0.5, var_335_3)

					arg_332_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_332_1.var_.characterEffect1097ui_story.fillRatio = var_335_4
				end
			end

			if arg_332_1.time_ >= var_335_1 + var_335_2 and arg_332_1.time_ < var_335_1 + var_335_2 + arg_335_0 and not isNil(var_335_0) and arg_332_1.var_.characterEffect1097ui_story then
				local var_335_5 = 0.5

				arg_332_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_332_1.var_.characterEffect1097ui_story.fillRatio = var_335_5
			end

			local var_335_6 = 0
			local var_335_7 = 0.2

			if var_335_6 < arg_332_1.time_ and arg_332_1.time_ <= var_335_6 + arg_335_0 then
				arg_332_1.talkMaxDuration = 0
				arg_332_1.dialogCg_.alpha = 1

				arg_332_1.dialog_:SetActive(true)
				SetActive(arg_332_1.leftNameGo_, true)

				local var_335_8 = arg_332_1:FormatText(StoryNameCfg[7].name)

				arg_332_1.leftNameTxt_.text = var_335_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_332_1.leftNameTxt_.transform)

				arg_332_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_332_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_332_1:RecordName(arg_332_1.leftNameTxt_.text)
				SetActive(arg_332_1.iconTrs_.gameObject, true)
				arg_332_1.iconController_:SetSelectedState("hero")

				arg_332_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_332_1.callingController_:SetSelectedState("normal")

				arg_332_1.keyicon_.color = Color.New(1, 1, 1)
				arg_332_1.icon_.color = Color.New(1, 1, 1)

				local var_335_9 = arg_332_1:GetWordFromCfg(1109701081)
				local var_335_10 = arg_332_1:FormatText(var_335_9.content)

				arg_332_1.text_.text = var_335_10

				LuaForUtil.ClearLinePrefixSymbol(arg_332_1.text_)

				local var_335_11 = 8
				local var_335_12 = utf8.len(var_335_10)
				local var_335_13 = var_335_11 <= 0 and var_335_7 or var_335_7 * (var_335_12 / var_335_11)

				if var_335_13 > 0 and var_335_7 < var_335_13 then
					arg_332_1.talkMaxDuration = var_335_13

					if var_335_13 + var_335_6 > arg_332_1.duration_ then
						arg_332_1.duration_ = var_335_13 + var_335_6
					end
				end

				arg_332_1.text_.text = var_335_10
				arg_332_1.typewritter.percent = 0

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(false)
				arg_332_1:RecordContent(arg_332_1.text_.text)
			end

			local var_335_14 = math.max(var_335_7, arg_332_1.talkMaxDuration)

			if var_335_6 <= arg_332_1.time_ and arg_332_1.time_ < var_335_6 + var_335_14 then
				arg_332_1.typewritter.percent = (arg_332_1.time_ - var_335_6) / var_335_14

				arg_332_1.typewritter:SetDirty()
			end

			if arg_332_1.time_ >= var_335_6 + var_335_14 and arg_332_1.time_ < var_335_6 + var_335_14 + arg_335_0 then
				arg_332_1.typewritter.percent = 1

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(true)
			end
		end

		arg_332_1.nodeConfigList_ = {}

		arg_332_1:InitPlayNodeList()
	end,
	Play1109701082 = function(arg_336_0, arg_336_1)
		arg_336_1.time_ = 0
		arg_336_1.frameCnt_ = 0
		arg_336_1.state_ = "playing"
		arg_336_1.curTalkId_ = 1109701082
		arg_336_1.duration_ = 8.8

		local var_336_0 = {
			zh = 7.1,
			ja = 8.8
		}
		local var_336_1 = manager.audio:GetLocalizationFlag()

		if var_336_0[var_336_1] ~= nil then
			arg_336_1.duration_ = var_336_0[var_336_1]
		end

		SetActive(arg_336_1.tipsGo_, false)

		function arg_336_1.onSingleLineFinish_()
			arg_336_1.onSingleLineUpdate_ = nil
			arg_336_1.onSingleLineFinish_ = nil
			arg_336_1.state_ = "waiting"
		end

		function arg_336_1.playNext_(arg_338_0)
			if arg_338_0 == 1 then
				arg_336_0:Play1109701083(arg_336_1)
			end
		end

		function arg_336_1.onSingleLineUpdate_(arg_339_0)
			local var_339_0 = arg_336_1.actors_["1097ui_story"].transform
			local var_339_1 = 0

			if var_339_1 < arg_336_1.time_ and arg_336_1.time_ <= var_339_1 + arg_339_0 then
				arg_336_1.var_.moveOldPos1097ui_story = var_339_0.localPosition
			end

			local var_339_2 = 0.001

			if var_339_1 <= arg_336_1.time_ and arg_336_1.time_ < var_339_1 + var_339_2 then
				local var_339_3 = (arg_336_1.time_ - var_339_1) / var_339_2
				local var_339_4 = Vector3.New(0, -0.54, -6.3)

				var_339_0.localPosition = Vector3.Lerp(arg_336_1.var_.moveOldPos1097ui_story, var_339_4, var_339_3)

				local var_339_5 = manager.ui.mainCamera.transform.position - var_339_0.position

				var_339_0.forward = Vector3.New(var_339_5.x, var_339_5.y, var_339_5.z)

				local var_339_6 = var_339_0.localEulerAngles

				var_339_6.z = 0
				var_339_6.x = 0
				var_339_0.localEulerAngles = var_339_6
			end

			if arg_336_1.time_ >= var_339_1 + var_339_2 and arg_336_1.time_ < var_339_1 + var_339_2 + arg_339_0 then
				var_339_0.localPosition = Vector3.New(0, -0.54, -6.3)

				local var_339_7 = manager.ui.mainCamera.transform.position - var_339_0.position

				var_339_0.forward = Vector3.New(var_339_7.x, var_339_7.y, var_339_7.z)

				local var_339_8 = var_339_0.localEulerAngles

				var_339_8.z = 0
				var_339_8.x = 0
				var_339_0.localEulerAngles = var_339_8
			end

			local var_339_9 = arg_336_1.actors_["1097ui_story"]
			local var_339_10 = 0

			if var_339_10 < arg_336_1.time_ and arg_336_1.time_ <= var_339_10 + arg_339_0 and not isNil(var_339_9) and arg_336_1.var_.characterEffect1097ui_story == nil then
				arg_336_1.var_.characterEffect1097ui_story = var_339_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_339_11 = 0.200000002980232

			if var_339_10 <= arg_336_1.time_ and arg_336_1.time_ < var_339_10 + var_339_11 and not isNil(var_339_9) then
				local var_339_12 = (arg_336_1.time_ - var_339_10) / var_339_11

				if arg_336_1.var_.characterEffect1097ui_story and not isNil(var_339_9) then
					arg_336_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_336_1.time_ >= var_339_10 + var_339_11 and arg_336_1.time_ < var_339_10 + var_339_11 + arg_339_0 and not isNil(var_339_9) and arg_336_1.var_.characterEffect1097ui_story then
				arg_336_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_339_13 = 0

			if var_339_13 < arg_336_1.time_ and arg_336_1.time_ <= var_339_13 + arg_339_0 then
				arg_336_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action6_1")
			end

			local var_339_14 = 0

			if var_339_14 < arg_336_1.time_ and arg_336_1.time_ <= var_339_14 + arg_339_0 then
				arg_336_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_339_15 = 0
			local var_339_16 = 0.525

			if var_339_15 < arg_336_1.time_ and arg_336_1.time_ <= var_339_15 + arg_339_0 then
				arg_336_1.talkMaxDuration = 0
				arg_336_1.dialogCg_.alpha = 1

				arg_336_1.dialog_:SetActive(true)
				SetActive(arg_336_1.leftNameGo_, true)

				local var_339_17 = arg_336_1:FormatText(StoryNameCfg[216].name)

				arg_336_1.leftNameTxt_.text = var_339_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_336_1.leftNameTxt_.transform)

				arg_336_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_336_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_336_1:RecordName(arg_336_1.leftNameTxt_.text)
				SetActive(arg_336_1.iconTrs_.gameObject, false)
				arg_336_1.callingController_:SetSelectedState("normal")

				local var_339_18 = arg_336_1:GetWordFromCfg(1109701082)
				local var_339_19 = arg_336_1:FormatText(var_339_18.content)

				arg_336_1.text_.text = var_339_19

				LuaForUtil.ClearLinePrefixSymbol(arg_336_1.text_)

				local var_339_20 = 21
				local var_339_21 = utf8.len(var_339_19)
				local var_339_22 = var_339_20 <= 0 and var_339_16 or var_339_16 * (var_339_21 / var_339_20)

				if var_339_22 > 0 and var_339_16 < var_339_22 then
					arg_336_1.talkMaxDuration = var_339_22

					if var_339_22 + var_339_15 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_22 + var_339_15
					end
				end

				arg_336_1.text_.text = var_339_19
				arg_336_1.typewritter.percent = 0

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701082", "story_v_side_new_1109701.awb") ~= 0 then
					local var_339_23 = manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701082", "story_v_side_new_1109701.awb") / 1000

					if var_339_23 + var_339_15 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_23 + var_339_15
					end

					if var_339_18.prefab_name ~= "" and arg_336_1.actors_[var_339_18.prefab_name] ~= nil then
						local var_339_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_336_1.actors_[var_339_18.prefab_name].transform, "story_v_side_new_1109701", "1109701082", "story_v_side_new_1109701.awb")

						arg_336_1:RecordAudio("1109701082", var_339_24)
						arg_336_1:RecordAudio("1109701082", var_339_24)
					else
						arg_336_1:AudioAction("play", "voice", "story_v_side_new_1109701", "1109701082", "story_v_side_new_1109701.awb")
					end

					arg_336_1:RecordHistoryTalkVoice("story_v_side_new_1109701", "1109701082", "story_v_side_new_1109701.awb")
				end

				arg_336_1:RecordContent(arg_336_1.text_.text)
			end

			local var_339_25 = math.max(var_339_16, arg_336_1.talkMaxDuration)

			if var_339_15 <= arg_336_1.time_ and arg_336_1.time_ < var_339_15 + var_339_25 then
				arg_336_1.typewritter.percent = (arg_336_1.time_ - var_339_15) / var_339_25

				arg_336_1.typewritter:SetDirty()
			end

			if arg_336_1.time_ >= var_339_15 + var_339_25 and arg_336_1.time_ < var_339_15 + var_339_25 + arg_339_0 then
				arg_336_1.typewritter.percent = 1

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(true)
			end
		end

		arg_336_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_336_1:InitPlayNodeList()
	end,
	Play1109701083 = function(arg_340_0, arg_340_1)
		arg_340_1.time_ = 0
		arg_340_1.frameCnt_ = 0
		arg_340_1.state_ = "playing"
		arg_340_1.curTalkId_ = 1109701083
		arg_340_1.duration_ = 5

		SetActive(arg_340_1.tipsGo_, false)

		function arg_340_1.onSingleLineFinish_()
			arg_340_1.onSingleLineUpdate_ = nil
			arg_340_1.onSingleLineFinish_ = nil
			arg_340_1.state_ = "waiting"
		end

		function arg_340_1.playNext_(arg_342_0)
			if arg_342_0 == 1 then
				arg_340_0:Play1109701084(arg_340_1)
			end
		end

		function arg_340_1.onSingleLineUpdate_(arg_343_0)
			local var_343_0 = arg_340_1.actors_["1097ui_story"]
			local var_343_1 = 0

			if var_343_1 < arg_340_1.time_ and arg_340_1.time_ <= var_343_1 + arg_343_0 and not isNil(var_343_0) and arg_340_1.var_.characterEffect1097ui_story == nil then
				arg_340_1.var_.characterEffect1097ui_story = var_343_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_343_2 = 0.200000002980232

			if var_343_1 <= arg_340_1.time_ and arg_340_1.time_ < var_343_1 + var_343_2 and not isNil(var_343_0) then
				local var_343_3 = (arg_340_1.time_ - var_343_1) / var_343_2

				if arg_340_1.var_.characterEffect1097ui_story and not isNil(var_343_0) then
					local var_343_4 = Mathf.Lerp(0, 0.5, var_343_3)

					arg_340_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_340_1.var_.characterEffect1097ui_story.fillRatio = var_343_4
				end
			end

			if arg_340_1.time_ >= var_343_1 + var_343_2 and arg_340_1.time_ < var_343_1 + var_343_2 + arg_343_0 and not isNil(var_343_0) and arg_340_1.var_.characterEffect1097ui_story then
				local var_343_5 = 0.5

				arg_340_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_340_1.var_.characterEffect1097ui_story.fillRatio = var_343_5
			end

			local var_343_6 = 0
			local var_343_7 = 0.625

			if var_343_6 < arg_340_1.time_ and arg_340_1.time_ <= var_343_6 + arg_343_0 then
				arg_340_1.talkMaxDuration = 0
				arg_340_1.dialogCg_.alpha = 1

				arg_340_1.dialog_:SetActive(true)
				SetActive(arg_340_1.leftNameGo_, true)

				local var_343_8 = arg_340_1:FormatText(StoryNameCfg[7].name)

				arg_340_1.leftNameTxt_.text = var_343_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_340_1.leftNameTxt_.transform)

				arg_340_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_340_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_340_1:RecordName(arg_340_1.leftNameTxt_.text)
				SetActive(arg_340_1.iconTrs_.gameObject, true)
				arg_340_1.iconController_:SetSelectedState("hero")

				arg_340_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_340_1.callingController_:SetSelectedState("normal")

				arg_340_1.keyicon_.color = Color.New(1, 1, 1)
				arg_340_1.icon_.color = Color.New(1, 1, 1)

				local var_343_9 = arg_340_1:GetWordFromCfg(1109701083)
				local var_343_10 = arg_340_1:FormatText(var_343_9.content)

				arg_340_1.text_.text = var_343_10

				LuaForUtil.ClearLinePrefixSymbol(arg_340_1.text_)

				local var_343_11 = 25
				local var_343_12 = utf8.len(var_343_10)
				local var_343_13 = var_343_11 <= 0 and var_343_7 or var_343_7 * (var_343_12 / var_343_11)

				if var_343_13 > 0 and var_343_7 < var_343_13 then
					arg_340_1.talkMaxDuration = var_343_13

					if var_343_13 + var_343_6 > arg_340_1.duration_ then
						arg_340_1.duration_ = var_343_13 + var_343_6
					end
				end

				arg_340_1.text_.text = var_343_10
				arg_340_1.typewritter.percent = 0

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(false)
				arg_340_1:RecordContent(arg_340_1.text_.text)
			end

			local var_343_14 = math.max(var_343_7, arg_340_1.talkMaxDuration)

			if var_343_6 <= arg_340_1.time_ and arg_340_1.time_ < var_343_6 + var_343_14 then
				arg_340_1.typewritter.percent = (arg_340_1.time_ - var_343_6) / var_343_14

				arg_340_1.typewritter:SetDirty()
			end

			if arg_340_1.time_ >= var_343_6 + var_343_14 and arg_340_1.time_ < var_343_6 + var_343_14 + arg_343_0 then
				arg_340_1.typewritter.percent = 1

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(true)
			end
		end

		arg_340_1.nodeConfigList_ = {}

		arg_340_1:InitPlayNodeList()
	end,
	Play1109701084 = function(arg_344_0, arg_344_1)
		arg_344_1.time_ = 0
		arg_344_1.frameCnt_ = 0
		arg_344_1.state_ = "playing"
		arg_344_1.curTalkId_ = 1109701084
		arg_344_1.duration_ = 5

		SetActive(arg_344_1.tipsGo_, false)

		function arg_344_1.onSingleLineFinish_()
			arg_344_1.onSingleLineUpdate_ = nil
			arg_344_1.onSingleLineFinish_ = nil
			arg_344_1.state_ = "waiting"
		end

		function arg_344_1.playNext_(arg_346_0)
			if arg_346_0 == 1 then
				arg_344_0:Play1109701085(arg_344_1)
			end
		end

		function arg_344_1.onSingleLineUpdate_(arg_347_0)
			local var_347_0 = 0
			local var_347_1 = 0.525

			if var_347_0 < arg_344_1.time_ and arg_344_1.time_ <= var_347_0 + arg_347_0 then
				arg_344_1.talkMaxDuration = 0
				arg_344_1.dialogCg_.alpha = 1

				arg_344_1.dialog_:SetActive(true)
				SetActive(arg_344_1.leftNameGo_, true)

				local var_347_2 = arg_344_1:FormatText(StoryNameCfg[7].name)

				arg_344_1.leftNameTxt_.text = var_347_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_344_1.leftNameTxt_.transform)

				arg_344_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_344_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_344_1:RecordName(arg_344_1.leftNameTxt_.text)
				SetActive(arg_344_1.iconTrs_.gameObject, true)
				arg_344_1.iconController_:SetSelectedState("hero")

				arg_344_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_344_1.callingController_:SetSelectedState("normal")

				arg_344_1.keyicon_.color = Color.New(1, 1, 1)
				arg_344_1.icon_.color = Color.New(1, 1, 1)

				local var_347_3 = arg_344_1:GetWordFromCfg(1109701084)
				local var_347_4 = arg_344_1:FormatText(var_347_3.content)

				arg_344_1.text_.text = var_347_4

				LuaForUtil.ClearLinePrefixSymbol(arg_344_1.text_)

				local var_347_5 = 21
				local var_347_6 = utf8.len(var_347_4)
				local var_347_7 = var_347_5 <= 0 and var_347_1 or var_347_1 * (var_347_6 / var_347_5)

				if var_347_7 > 0 and var_347_1 < var_347_7 then
					arg_344_1.talkMaxDuration = var_347_7

					if var_347_7 + var_347_0 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_7 + var_347_0
					end
				end

				arg_344_1.text_.text = var_347_4
				arg_344_1.typewritter.percent = 0

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(false)
				arg_344_1:RecordContent(arg_344_1.text_.text)
			end

			local var_347_8 = math.max(var_347_1, arg_344_1.talkMaxDuration)

			if var_347_0 <= arg_344_1.time_ and arg_344_1.time_ < var_347_0 + var_347_8 then
				arg_344_1.typewritter.percent = (arg_344_1.time_ - var_347_0) / var_347_8

				arg_344_1.typewritter:SetDirty()
			end

			if arg_344_1.time_ >= var_347_0 + var_347_8 and arg_344_1.time_ < var_347_0 + var_347_8 + arg_347_0 then
				arg_344_1.typewritter.percent = 1

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(true)
			end
		end

		arg_344_1.nodeConfigList_ = {}

		arg_344_1:InitPlayNodeList()
	end,
	Play1109701085 = function(arg_348_0, arg_348_1)
		arg_348_1.time_ = 0
		arg_348_1.frameCnt_ = 0
		arg_348_1.state_ = "playing"
		arg_348_1.curTalkId_ = 1109701085
		arg_348_1.duration_ = 10.33

		local var_348_0 = {
			zh = 8,
			ja = 10.333
		}
		local var_348_1 = manager.audio:GetLocalizationFlag()

		if var_348_0[var_348_1] ~= nil then
			arg_348_1.duration_ = var_348_0[var_348_1]
		end

		SetActive(arg_348_1.tipsGo_, false)

		function arg_348_1.onSingleLineFinish_()
			arg_348_1.onSingleLineUpdate_ = nil
			arg_348_1.onSingleLineFinish_ = nil
			arg_348_1.state_ = "waiting"
		end

		function arg_348_1.playNext_(arg_350_0)
			if arg_350_0 == 1 then
				arg_348_0:Play1109701086(arg_348_1)
			end
		end

		function arg_348_1.onSingleLineUpdate_(arg_351_0)
			local var_351_0 = arg_348_1.actors_["1097ui_story"].transform
			local var_351_1 = 0

			if var_351_1 < arg_348_1.time_ and arg_348_1.time_ <= var_351_1 + arg_351_0 then
				arg_348_1.var_.moveOldPos1097ui_story = var_351_0.localPosition
			end

			local var_351_2 = 0.001

			if var_351_1 <= arg_348_1.time_ and arg_348_1.time_ < var_351_1 + var_351_2 then
				local var_351_3 = (arg_348_1.time_ - var_351_1) / var_351_2
				local var_351_4 = Vector3.New(0, -0.54, -6.3)

				var_351_0.localPosition = Vector3.Lerp(arg_348_1.var_.moveOldPos1097ui_story, var_351_4, var_351_3)

				local var_351_5 = manager.ui.mainCamera.transform.position - var_351_0.position

				var_351_0.forward = Vector3.New(var_351_5.x, var_351_5.y, var_351_5.z)

				local var_351_6 = var_351_0.localEulerAngles

				var_351_6.z = 0
				var_351_6.x = 0
				var_351_0.localEulerAngles = var_351_6
			end

			if arg_348_1.time_ >= var_351_1 + var_351_2 and arg_348_1.time_ < var_351_1 + var_351_2 + arg_351_0 then
				var_351_0.localPosition = Vector3.New(0, -0.54, -6.3)

				local var_351_7 = manager.ui.mainCamera.transform.position - var_351_0.position

				var_351_0.forward = Vector3.New(var_351_7.x, var_351_7.y, var_351_7.z)

				local var_351_8 = var_351_0.localEulerAngles

				var_351_8.z = 0
				var_351_8.x = 0
				var_351_0.localEulerAngles = var_351_8
			end

			local var_351_9 = arg_348_1.actors_["1097ui_story"]
			local var_351_10 = 0

			if var_351_10 < arg_348_1.time_ and arg_348_1.time_ <= var_351_10 + arg_351_0 and not isNil(var_351_9) and arg_348_1.var_.characterEffect1097ui_story == nil then
				arg_348_1.var_.characterEffect1097ui_story = var_351_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_351_11 = 0.200000002980232

			if var_351_10 <= arg_348_1.time_ and arg_348_1.time_ < var_351_10 + var_351_11 and not isNil(var_351_9) then
				local var_351_12 = (arg_348_1.time_ - var_351_10) / var_351_11

				if arg_348_1.var_.characterEffect1097ui_story and not isNil(var_351_9) then
					arg_348_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_348_1.time_ >= var_351_10 + var_351_11 and arg_348_1.time_ < var_351_10 + var_351_11 + arg_351_0 and not isNil(var_351_9) and arg_348_1.var_.characterEffect1097ui_story then
				arg_348_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_351_13 = 0

			if var_351_13 < arg_348_1.time_ and arg_348_1.time_ <= var_351_13 + arg_351_0 then
				arg_348_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action6_2")
			end

			local var_351_14 = 0

			if var_351_14 < arg_348_1.time_ and arg_348_1.time_ <= var_351_14 + arg_351_0 then
				arg_348_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_351_15 = 0
			local var_351_16 = 0.7

			if var_351_15 < arg_348_1.time_ and arg_348_1.time_ <= var_351_15 + arg_351_0 then
				arg_348_1.talkMaxDuration = 0
				arg_348_1.dialogCg_.alpha = 1

				arg_348_1.dialog_:SetActive(true)
				SetActive(arg_348_1.leftNameGo_, true)

				local var_351_17 = arg_348_1:FormatText(StoryNameCfg[216].name)

				arg_348_1.leftNameTxt_.text = var_351_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_348_1.leftNameTxt_.transform)

				arg_348_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_348_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_348_1:RecordName(arg_348_1.leftNameTxt_.text)
				SetActive(arg_348_1.iconTrs_.gameObject, false)
				arg_348_1.callingController_:SetSelectedState("normal")

				local var_351_18 = arg_348_1:GetWordFromCfg(1109701085)
				local var_351_19 = arg_348_1:FormatText(var_351_18.content)

				arg_348_1.text_.text = var_351_19

				LuaForUtil.ClearLinePrefixSymbol(arg_348_1.text_)

				local var_351_20 = 28
				local var_351_21 = utf8.len(var_351_19)
				local var_351_22 = var_351_20 <= 0 and var_351_16 or var_351_16 * (var_351_21 / var_351_20)

				if var_351_22 > 0 and var_351_16 < var_351_22 then
					arg_348_1.talkMaxDuration = var_351_22

					if var_351_22 + var_351_15 > arg_348_1.duration_ then
						arg_348_1.duration_ = var_351_22 + var_351_15
					end
				end

				arg_348_1.text_.text = var_351_19
				arg_348_1.typewritter.percent = 0

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701085", "story_v_side_new_1109701.awb") ~= 0 then
					local var_351_23 = manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701085", "story_v_side_new_1109701.awb") / 1000

					if var_351_23 + var_351_15 > arg_348_1.duration_ then
						arg_348_1.duration_ = var_351_23 + var_351_15
					end

					if var_351_18.prefab_name ~= "" and arg_348_1.actors_[var_351_18.prefab_name] ~= nil then
						local var_351_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_348_1.actors_[var_351_18.prefab_name].transform, "story_v_side_new_1109701", "1109701085", "story_v_side_new_1109701.awb")

						arg_348_1:RecordAudio("1109701085", var_351_24)
						arg_348_1:RecordAudio("1109701085", var_351_24)
					else
						arg_348_1:AudioAction("play", "voice", "story_v_side_new_1109701", "1109701085", "story_v_side_new_1109701.awb")
					end

					arg_348_1:RecordHistoryTalkVoice("story_v_side_new_1109701", "1109701085", "story_v_side_new_1109701.awb")
				end

				arg_348_1:RecordContent(arg_348_1.text_.text)
			end

			local var_351_25 = math.max(var_351_16, arg_348_1.talkMaxDuration)

			if var_351_15 <= arg_348_1.time_ and arg_348_1.time_ < var_351_15 + var_351_25 then
				arg_348_1.typewritter.percent = (arg_348_1.time_ - var_351_15) / var_351_25

				arg_348_1.typewritter:SetDirty()
			end

			if arg_348_1.time_ >= var_351_15 + var_351_25 and arg_348_1.time_ < var_351_15 + var_351_25 + arg_351_0 then
				arg_348_1.typewritter.percent = 1

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(true)
			end
		end

		arg_348_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_348_1:InitPlayNodeList()
	end,
	Play1109701086 = function(arg_352_0, arg_352_1)
		arg_352_1.time_ = 0
		arg_352_1.frameCnt_ = 0
		arg_352_1.state_ = "playing"
		arg_352_1.curTalkId_ = 1109701086
		arg_352_1.duration_ = 5

		SetActive(arg_352_1.tipsGo_, false)

		function arg_352_1.onSingleLineFinish_()
			arg_352_1.onSingleLineUpdate_ = nil
			arg_352_1.onSingleLineFinish_ = nil
			arg_352_1.state_ = "waiting"
		end

		function arg_352_1.playNext_(arg_354_0)
			if arg_354_0 == 1 then
				arg_352_0:Play1109701087(arg_352_1)
			end
		end

		function arg_352_1.onSingleLineUpdate_(arg_355_0)
			local var_355_0 = arg_352_1.actors_["1097ui_story"]
			local var_355_1 = 0

			if var_355_1 < arg_352_1.time_ and arg_352_1.time_ <= var_355_1 + arg_355_0 and not isNil(var_355_0) and arg_352_1.var_.characterEffect1097ui_story == nil then
				arg_352_1.var_.characterEffect1097ui_story = var_355_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_355_2 = 0.200000002980232

			if var_355_1 <= arg_352_1.time_ and arg_352_1.time_ < var_355_1 + var_355_2 and not isNil(var_355_0) then
				local var_355_3 = (arg_352_1.time_ - var_355_1) / var_355_2

				if arg_352_1.var_.characterEffect1097ui_story and not isNil(var_355_0) then
					local var_355_4 = Mathf.Lerp(0, 0.5, var_355_3)

					arg_352_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_352_1.var_.characterEffect1097ui_story.fillRatio = var_355_4
				end
			end

			if arg_352_1.time_ >= var_355_1 + var_355_2 and arg_352_1.time_ < var_355_1 + var_355_2 + arg_355_0 and not isNil(var_355_0) and arg_352_1.var_.characterEffect1097ui_story then
				local var_355_5 = 0.5

				arg_352_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_352_1.var_.characterEffect1097ui_story.fillRatio = var_355_5
			end

			local var_355_6 = 0
			local var_355_7 = 0.6

			if var_355_6 < arg_352_1.time_ and arg_352_1.time_ <= var_355_6 + arg_355_0 then
				arg_352_1.talkMaxDuration = 0
				arg_352_1.dialogCg_.alpha = 1

				arg_352_1.dialog_:SetActive(true)
				SetActive(arg_352_1.leftNameGo_, true)

				local var_355_8 = arg_352_1:FormatText(StoryNameCfg[7].name)

				arg_352_1.leftNameTxt_.text = var_355_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_352_1.leftNameTxt_.transform)

				arg_352_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_352_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_352_1:RecordName(arg_352_1.leftNameTxt_.text)
				SetActive(arg_352_1.iconTrs_.gameObject, true)
				arg_352_1.iconController_:SetSelectedState("hero")

				arg_352_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_352_1.callingController_:SetSelectedState("normal")

				arg_352_1.keyicon_.color = Color.New(1, 1, 1)
				arg_352_1.icon_.color = Color.New(1, 1, 1)

				local var_355_9 = arg_352_1:GetWordFromCfg(1109701086)
				local var_355_10 = arg_352_1:FormatText(var_355_9.content)

				arg_352_1.text_.text = var_355_10

				LuaForUtil.ClearLinePrefixSymbol(arg_352_1.text_)

				local var_355_11 = 24
				local var_355_12 = utf8.len(var_355_10)
				local var_355_13 = var_355_11 <= 0 and var_355_7 or var_355_7 * (var_355_12 / var_355_11)

				if var_355_13 > 0 and var_355_7 < var_355_13 then
					arg_352_1.talkMaxDuration = var_355_13

					if var_355_13 + var_355_6 > arg_352_1.duration_ then
						arg_352_1.duration_ = var_355_13 + var_355_6
					end
				end

				arg_352_1.text_.text = var_355_10
				arg_352_1.typewritter.percent = 0

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(false)
				arg_352_1:RecordContent(arg_352_1.text_.text)
			end

			local var_355_14 = math.max(var_355_7, arg_352_1.talkMaxDuration)

			if var_355_6 <= arg_352_1.time_ and arg_352_1.time_ < var_355_6 + var_355_14 then
				arg_352_1.typewritter.percent = (arg_352_1.time_ - var_355_6) / var_355_14

				arg_352_1.typewritter:SetDirty()
			end

			if arg_352_1.time_ >= var_355_6 + var_355_14 and arg_352_1.time_ < var_355_6 + var_355_14 + arg_355_0 then
				arg_352_1.typewritter.percent = 1

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(true)
			end
		end

		arg_352_1.nodeConfigList_ = {}

		arg_352_1:InitPlayNodeList()
	end,
	Play1109701087 = function(arg_356_0, arg_356_1)
		arg_356_1.time_ = 0
		arg_356_1.frameCnt_ = 0
		arg_356_1.state_ = "playing"
		arg_356_1.curTalkId_ = 1109701087
		arg_356_1.duration_ = 5.1

		local var_356_0 = {
			zh = 3.833,
			ja = 5.1
		}
		local var_356_1 = manager.audio:GetLocalizationFlag()

		if var_356_0[var_356_1] ~= nil then
			arg_356_1.duration_ = var_356_0[var_356_1]
		end

		SetActive(arg_356_1.tipsGo_, false)

		function arg_356_1.onSingleLineFinish_()
			arg_356_1.onSingleLineUpdate_ = nil
			arg_356_1.onSingleLineFinish_ = nil
			arg_356_1.state_ = "waiting"
		end

		function arg_356_1.playNext_(arg_358_0)
			if arg_358_0 == 1 then
				arg_356_0:Play1109701088(arg_356_1)
			end
		end

		function arg_356_1.onSingleLineUpdate_(arg_359_0)
			local var_359_0 = arg_356_1.actors_["1097ui_story"]
			local var_359_1 = 0

			if var_359_1 < arg_356_1.time_ and arg_356_1.time_ <= var_359_1 + arg_359_0 and not isNil(var_359_0) and arg_356_1.var_.characterEffect1097ui_story == nil then
				arg_356_1.var_.characterEffect1097ui_story = var_359_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_359_2 = 0.200000002980232

			if var_359_1 <= arg_356_1.time_ and arg_356_1.time_ < var_359_1 + var_359_2 and not isNil(var_359_0) then
				local var_359_3 = (arg_356_1.time_ - var_359_1) / var_359_2

				if arg_356_1.var_.characterEffect1097ui_story and not isNil(var_359_0) then
					arg_356_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_356_1.time_ >= var_359_1 + var_359_2 and arg_356_1.time_ < var_359_1 + var_359_2 + arg_359_0 and not isNil(var_359_0) and arg_356_1.var_.characterEffect1097ui_story then
				arg_356_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_359_4 = 0

			if var_359_4 < arg_356_1.time_ and arg_356_1.time_ <= var_359_4 + arg_359_0 then
				arg_356_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			local var_359_5 = 0

			if var_359_5 < arg_356_1.time_ and arg_356_1.time_ <= var_359_5 + arg_359_0 then
				arg_356_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_359_6 = 0
			local var_359_7 = 0.325

			if var_359_6 < arg_356_1.time_ and arg_356_1.time_ <= var_359_6 + arg_359_0 then
				arg_356_1.talkMaxDuration = 0
				arg_356_1.dialogCg_.alpha = 1

				arg_356_1.dialog_:SetActive(true)
				SetActive(arg_356_1.leftNameGo_, true)

				local var_359_8 = arg_356_1:FormatText(StoryNameCfg[216].name)

				arg_356_1.leftNameTxt_.text = var_359_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_356_1.leftNameTxt_.transform)

				arg_356_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_356_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_356_1:RecordName(arg_356_1.leftNameTxt_.text)
				SetActive(arg_356_1.iconTrs_.gameObject, false)
				arg_356_1.callingController_:SetSelectedState("normal")

				local var_359_9 = arg_356_1:GetWordFromCfg(1109701087)
				local var_359_10 = arg_356_1:FormatText(var_359_9.content)

				arg_356_1.text_.text = var_359_10

				LuaForUtil.ClearLinePrefixSymbol(arg_356_1.text_)

				local var_359_11 = 13
				local var_359_12 = utf8.len(var_359_10)
				local var_359_13 = var_359_11 <= 0 and var_359_7 or var_359_7 * (var_359_12 / var_359_11)

				if var_359_13 > 0 and var_359_7 < var_359_13 then
					arg_356_1.talkMaxDuration = var_359_13

					if var_359_13 + var_359_6 > arg_356_1.duration_ then
						arg_356_1.duration_ = var_359_13 + var_359_6
					end
				end

				arg_356_1.text_.text = var_359_10
				arg_356_1.typewritter.percent = 0

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701087", "story_v_side_new_1109701.awb") ~= 0 then
					local var_359_14 = manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701087", "story_v_side_new_1109701.awb") / 1000

					if var_359_14 + var_359_6 > arg_356_1.duration_ then
						arg_356_1.duration_ = var_359_14 + var_359_6
					end

					if var_359_9.prefab_name ~= "" and arg_356_1.actors_[var_359_9.prefab_name] ~= nil then
						local var_359_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_356_1.actors_[var_359_9.prefab_name].transform, "story_v_side_new_1109701", "1109701087", "story_v_side_new_1109701.awb")

						arg_356_1:RecordAudio("1109701087", var_359_15)
						arg_356_1:RecordAudio("1109701087", var_359_15)
					else
						arg_356_1:AudioAction("play", "voice", "story_v_side_new_1109701", "1109701087", "story_v_side_new_1109701.awb")
					end

					arg_356_1:RecordHistoryTalkVoice("story_v_side_new_1109701", "1109701087", "story_v_side_new_1109701.awb")
				end

				arg_356_1:RecordContent(arg_356_1.text_.text)
			end

			local var_359_16 = math.max(var_359_7, arg_356_1.talkMaxDuration)

			if var_359_6 <= arg_356_1.time_ and arg_356_1.time_ < var_359_6 + var_359_16 then
				arg_356_1.typewritter.percent = (arg_356_1.time_ - var_359_6) / var_359_16

				arg_356_1.typewritter:SetDirty()
			end

			if arg_356_1.time_ >= var_359_6 + var_359_16 and arg_356_1.time_ < var_359_6 + var_359_16 + arg_359_0 then
				arg_356_1.typewritter.percent = 1

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(true)
			end
		end

		arg_356_1.nodeConfigList_ = {}

		arg_356_1:InitPlayNodeList()
	end,
	Play1109701088 = function(arg_360_0, arg_360_1)
		arg_360_1.time_ = 0
		arg_360_1.frameCnt_ = 0
		arg_360_1.state_ = "playing"
		arg_360_1.curTalkId_ = 1109701088
		arg_360_1.duration_ = 5

		SetActive(arg_360_1.tipsGo_, false)

		function arg_360_1.onSingleLineFinish_()
			arg_360_1.onSingleLineUpdate_ = nil
			arg_360_1.onSingleLineFinish_ = nil
			arg_360_1.state_ = "waiting"
		end

		function arg_360_1.playNext_(arg_362_0)
			if arg_362_0 == 1 then
				arg_360_0:Play1109701089(arg_360_1)
			end
		end

		function arg_360_1.onSingleLineUpdate_(arg_363_0)
			local var_363_0 = arg_360_1.actors_["1097ui_story"]
			local var_363_1 = 0

			if var_363_1 < arg_360_1.time_ and arg_360_1.time_ <= var_363_1 + arg_363_0 and not isNil(var_363_0) and arg_360_1.var_.characterEffect1097ui_story == nil then
				arg_360_1.var_.characterEffect1097ui_story = var_363_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_363_2 = 0.200000002980232

			if var_363_1 <= arg_360_1.time_ and arg_360_1.time_ < var_363_1 + var_363_2 and not isNil(var_363_0) then
				local var_363_3 = (arg_360_1.time_ - var_363_1) / var_363_2

				if arg_360_1.var_.characterEffect1097ui_story and not isNil(var_363_0) then
					local var_363_4 = Mathf.Lerp(0, 0.5, var_363_3)

					arg_360_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_360_1.var_.characterEffect1097ui_story.fillRatio = var_363_4
				end
			end

			if arg_360_1.time_ >= var_363_1 + var_363_2 and arg_360_1.time_ < var_363_1 + var_363_2 + arg_363_0 and not isNil(var_363_0) and arg_360_1.var_.characterEffect1097ui_story then
				local var_363_5 = 0.5

				arg_360_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_360_1.var_.characterEffect1097ui_story.fillRatio = var_363_5
			end

			local var_363_6 = 0
			local var_363_7 = 0.85

			if var_363_6 < arg_360_1.time_ and arg_360_1.time_ <= var_363_6 + arg_363_0 then
				arg_360_1.talkMaxDuration = 0
				arg_360_1.dialogCg_.alpha = 1

				arg_360_1.dialog_:SetActive(true)
				SetActive(arg_360_1.leftNameGo_, true)

				local var_363_8 = arg_360_1:FormatText(StoryNameCfg[7].name)

				arg_360_1.leftNameTxt_.text = var_363_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_360_1.leftNameTxt_.transform)

				arg_360_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_360_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_360_1:RecordName(arg_360_1.leftNameTxt_.text)
				SetActive(arg_360_1.iconTrs_.gameObject, true)
				arg_360_1.iconController_:SetSelectedState("hero")

				arg_360_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_360_1.callingController_:SetSelectedState("normal")

				arg_360_1.keyicon_.color = Color.New(1, 1, 1)
				arg_360_1.icon_.color = Color.New(1, 1, 1)

				local var_363_9 = arg_360_1:GetWordFromCfg(1109701088)
				local var_363_10 = arg_360_1:FormatText(var_363_9.content)

				arg_360_1.text_.text = var_363_10

				LuaForUtil.ClearLinePrefixSymbol(arg_360_1.text_)

				local var_363_11 = 34
				local var_363_12 = utf8.len(var_363_10)
				local var_363_13 = var_363_11 <= 0 and var_363_7 or var_363_7 * (var_363_12 / var_363_11)

				if var_363_13 > 0 and var_363_7 < var_363_13 then
					arg_360_1.talkMaxDuration = var_363_13

					if var_363_13 + var_363_6 > arg_360_1.duration_ then
						arg_360_1.duration_ = var_363_13 + var_363_6
					end
				end

				arg_360_1.text_.text = var_363_10
				arg_360_1.typewritter.percent = 0

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(false)
				arg_360_1:RecordContent(arg_360_1.text_.text)
			end

			local var_363_14 = math.max(var_363_7, arg_360_1.talkMaxDuration)

			if var_363_6 <= arg_360_1.time_ and arg_360_1.time_ < var_363_6 + var_363_14 then
				arg_360_1.typewritter.percent = (arg_360_1.time_ - var_363_6) / var_363_14

				arg_360_1.typewritter:SetDirty()
			end

			if arg_360_1.time_ >= var_363_6 + var_363_14 and arg_360_1.time_ < var_363_6 + var_363_14 + arg_363_0 then
				arg_360_1.typewritter.percent = 1

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(true)
			end
		end

		arg_360_1.nodeConfigList_ = {}

		arg_360_1:InitPlayNodeList()
	end,
	Play1109701089 = function(arg_364_0, arg_364_1)
		arg_364_1.time_ = 0
		arg_364_1.frameCnt_ = 0
		arg_364_1.state_ = "playing"
		arg_364_1.curTalkId_ = 1109701089
		arg_364_1.duration_ = 5

		SetActive(arg_364_1.tipsGo_, false)

		function arg_364_1.onSingleLineFinish_()
			arg_364_1.onSingleLineUpdate_ = nil
			arg_364_1.onSingleLineFinish_ = nil
			arg_364_1.state_ = "waiting"
		end

		function arg_364_1.playNext_(arg_366_0)
			if arg_366_0 == 1 then
				arg_364_0:Play1109701090(arg_364_1)
			end
		end

		function arg_364_1.onSingleLineUpdate_(arg_367_0)
			local var_367_0 = 0
			local var_367_1 = 0.825

			if var_367_0 < arg_364_1.time_ and arg_364_1.time_ <= var_367_0 + arg_367_0 then
				arg_364_1.talkMaxDuration = 0
				arg_364_1.dialogCg_.alpha = 1

				arg_364_1.dialog_:SetActive(true)
				SetActive(arg_364_1.leftNameGo_, false)

				arg_364_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_364_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_364_1:RecordName(arg_364_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_364_1.iconTrs_.gameObject, false)
				arg_364_1.callingController_:SetSelectedState("normal")

				local var_367_2 = arg_364_1:GetWordFromCfg(1109701089)
				local var_367_3 = arg_364_1:FormatText(var_367_2.content)

				arg_364_1.text_.text = var_367_3

				LuaForUtil.ClearLinePrefixSymbol(arg_364_1.text_)

				local var_367_4 = 33
				local var_367_5 = utf8.len(var_367_3)
				local var_367_6 = var_367_4 <= 0 and var_367_1 or var_367_1 * (var_367_5 / var_367_4)

				if var_367_6 > 0 and var_367_1 < var_367_6 then
					arg_364_1.talkMaxDuration = var_367_6

					if var_367_6 + var_367_0 > arg_364_1.duration_ then
						arg_364_1.duration_ = var_367_6 + var_367_0
					end
				end

				arg_364_1.text_.text = var_367_3
				arg_364_1.typewritter.percent = 0

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(false)
				arg_364_1:RecordContent(arg_364_1.text_.text)
			end

			local var_367_7 = math.max(var_367_1, arg_364_1.talkMaxDuration)

			if var_367_0 <= arg_364_1.time_ and arg_364_1.time_ < var_367_0 + var_367_7 then
				arg_364_1.typewritter.percent = (arg_364_1.time_ - var_367_0) / var_367_7

				arg_364_1.typewritter:SetDirty()
			end

			if arg_364_1.time_ >= var_367_0 + var_367_7 and arg_364_1.time_ < var_367_0 + var_367_7 + arg_367_0 then
				arg_364_1.typewritter.percent = 1

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(true)
			end
		end

		arg_364_1.nodeConfigList_ = {}

		arg_364_1:InitPlayNodeList()
	end,
	Play1109701090 = function(arg_368_0, arg_368_1)
		arg_368_1.time_ = 0
		arg_368_1.frameCnt_ = 0
		arg_368_1.state_ = "playing"
		arg_368_1.curTalkId_ = 1109701090
		arg_368_1.duration_ = 5

		SetActive(arg_368_1.tipsGo_, false)

		function arg_368_1.onSingleLineFinish_()
			arg_368_1.onSingleLineUpdate_ = nil
			arg_368_1.onSingleLineFinish_ = nil
			arg_368_1.state_ = "waiting"
		end

		function arg_368_1.playNext_(arg_370_0)
			if arg_370_0 == 1 then
				arg_368_0:Play1109701091(arg_368_1)
			end
		end

		function arg_368_1.onSingleLineUpdate_(arg_371_0)
			local var_371_0 = 0
			local var_371_1 = 0.8

			if var_371_0 < arg_368_1.time_ and arg_368_1.time_ <= var_371_0 + arg_371_0 then
				arg_368_1.talkMaxDuration = 0
				arg_368_1.dialogCg_.alpha = 1

				arg_368_1.dialog_:SetActive(true)
				SetActive(arg_368_1.leftNameGo_, true)

				local var_371_2 = arg_368_1:FormatText(StoryNameCfg[7].name)

				arg_368_1.leftNameTxt_.text = var_371_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_368_1.leftNameTxt_.transform)

				arg_368_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_368_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_368_1:RecordName(arg_368_1.leftNameTxt_.text)
				SetActive(arg_368_1.iconTrs_.gameObject, true)
				arg_368_1.iconController_:SetSelectedState("hero")

				arg_368_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_368_1.callingController_:SetSelectedState("normal")

				arg_368_1.keyicon_.color = Color.New(1, 1, 1)
				arg_368_1.icon_.color = Color.New(1, 1, 1)

				local var_371_3 = arg_368_1:GetWordFromCfg(1109701090)
				local var_371_4 = arg_368_1:FormatText(var_371_3.content)

				arg_368_1.text_.text = var_371_4

				LuaForUtil.ClearLinePrefixSymbol(arg_368_1.text_)

				local var_371_5 = 32
				local var_371_6 = utf8.len(var_371_4)
				local var_371_7 = var_371_5 <= 0 and var_371_1 or var_371_1 * (var_371_6 / var_371_5)

				if var_371_7 > 0 and var_371_1 < var_371_7 then
					arg_368_1.talkMaxDuration = var_371_7

					if var_371_7 + var_371_0 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_7 + var_371_0
					end
				end

				arg_368_1.text_.text = var_371_4
				arg_368_1.typewritter.percent = 0

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(false)
				arg_368_1:RecordContent(arg_368_1.text_.text)
			end

			local var_371_8 = math.max(var_371_1, arg_368_1.talkMaxDuration)

			if var_371_0 <= arg_368_1.time_ and arg_368_1.time_ < var_371_0 + var_371_8 then
				arg_368_1.typewritter.percent = (arg_368_1.time_ - var_371_0) / var_371_8

				arg_368_1.typewritter:SetDirty()
			end

			if arg_368_1.time_ >= var_371_0 + var_371_8 and arg_368_1.time_ < var_371_0 + var_371_8 + arg_371_0 then
				arg_368_1.typewritter.percent = 1

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(true)
			end
		end

		arg_368_1.nodeConfigList_ = {}

		arg_368_1:InitPlayNodeList()
	end,
	Play1109701091 = function(arg_372_0, arg_372_1)
		arg_372_1.time_ = 0
		arg_372_1.frameCnt_ = 0
		arg_372_1.state_ = "playing"
		arg_372_1.curTalkId_ = 1109701091
		arg_372_1.duration_ = 5

		SetActive(arg_372_1.tipsGo_, false)

		function arg_372_1.onSingleLineFinish_()
			arg_372_1.onSingleLineUpdate_ = nil
			arg_372_1.onSingleLineFinish_ = nil
			arg_372_1.state_ = "waiting"
		end

		function arg_372_1.playNext_(arg_374_0)
			if arg_374_0 == 1 then
				arg_372_0:Play1109701092(arg_372_1)
			end
		end

		function arg_372_1.onSingleLineUpdate_(arg_375_0)
			local var_375_0 = 0
			local var_375_1 = 0.575

			if var_375_0 < arg_372_1.time_ and arg_372_1.time_ <= var_375_0 + arg_375_0 then
				arg_372_1.talkMaxDuration = 0
				arg_372_1.dialogCg_.alpha = 1

				arg_372_1.dialog_:SetActive(true)
				SetActive(arg_372_1.leftNameGo_, false)

				arg_372_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_372_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_372_1:RecordName(arg_372_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_372_1.iconTrs_.gameObject, false)
				arg_372_1.callingController_:SetSelectedState("normal")

				local var_375_2 = arg_372_1:GetWordFromCfg(1109701091)
				local var_375_3 = arg_372_1:FormatText(var_375_2.content)

				arg_372_1.text_.text = var_375_3

				LuaForUtil.ClearLinePrefixSymbol(arg_372_1.text_)

				local var_375_4 = 23
				local var_375_5 = utf8.len(var_375_3)
				local var_375_6 = var_375_4 <= 0 and var_375_1 or var_375_1 * (var_375_5 / var_375_4)

				if var_375_6 > 0 and var_375_1 < var_375_6 then
					arg_372_1.talkMaxDuration = var_375_6

					if var_375_6 + var_375_0 > arg_372_1.duration_ then
						arg_372_1.duration_ = var_375_6 + var_375_0
					end
				end

				arg_372_1.text_.text = var_375_3
				arg_372_1.typewritter.percent = 0

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(false)
				arg_372_1:RecordContent(arg_372_1.text_.text)
			end

			local var_375_7 = math.max(var_375_1, arg_372_1.talkMaxDuration)

			if var_375_0 <= arg_372_1.time_ and arg_372_1.time_ < var_375_0 + var_375_7 then
				arg_372_1.typewritter.percent = (arg_372_1.time_ - var_375_0) / var_375_7

				arg_372_1.typewritter:SetDirty()
			end

			if arg_372_1.time_ >= var_375_0 + var_375_7 and arg_372_1.time_ < var_375_0 + var_375_7 + arg_375_0 then
				arg_372_1.typewritter.percent = 1

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(true)
			end
		end

		arg_372_1.nodeConfigList_ = {}

		arg_372_1:InitPlayNodeList()
	end,
	Play1109701092 = function(arg_376_0, arg_376_1)
		arg_376_1.time_ = 0
		arg_376_1.frameCnt_ = 0
		arg_376_1.state_ = "playing"
		arg_376_1.curTalkId_ = 1109701092
		arg_376_1.duration_ = 5.8

		local var_376_0 = {
			zh = 4.433,
			ja = 5.8
		}
		local var_376_1 = manager.audio:GetLocalizationFlag()

		if var_376_0[var_376_1] ~= nil then
			arg_376_1.duration_ = var_376_0[var_376_1]
		end

		SetActive(arg_376_1.tipsGo_, false)

		function arg_376_1.onSingleLineFinish_()
			arg_376_1.onSingleLineUpdate_ = nil
			arg_376_1.onSingleLineFinish_ = nil
			arg_376_1.state_ = "waiting"
		end

		function arg_376_1.playNext_(arg_378_0)
			if arg_378_0 == 1 then
				arg_376_0:Play1109701093(arg_376_1)
			end
		end

		function arg_376_1.onSingleLineUpdate_(arg_379_0)
			local var_379_0 = arg_376_1.actors_["1097ui_story"].transform
			local var_379_1 = 0

			if var_379_1 < arg_376_1.time_ and arg_376_1.time_ <= var_379_1 + arg_379_0 then
				arg_376_1.var_.moveOldPos1097ui_story = var_379_0.localPosition
			end

			local var_379_2 = 0.001

			if var_379_1 <= arg_376_1.time_ and arg_376_1.time_ < var_379_1 + var_379_2 then
				local var_379_3 = (arg_376_1.time_ - var_379_1) / var_379_2
				local var_379_4 = Vector3.New(0, -0.54, -6.3)

				var_379_0.localPosition = Vector3.Lerp(arg_376_1.var_.moveOldPos1097ui_story, var_379_4, var_379_3)

				local var_379_5 = manager.ui.mainCamera.transform.position - var_379_0.position

				var_379_0.forward = Vector3.New(var_379_5.x, var_379_5.y, var_379_5.z)

				local var_379_6 = var_379_0.localEulerAngles

				var_379_6.z = 0
				var_379_6.x = 0
				var_379_0.localEulerAngles = var_379_6
			end

			if arg_376_1.time_ >= var_379_1 + var_379_2 and arg_376_1.time_ < var_379_1 + var_379_2 + arg_379_0 then
				var_379_0.localPosition = Vector3.New(0, -0.54, -6.3)

				local var_379_7 = manager.ui.mainCamera.transform.position - var_379_0.position

				var_379_0.forward = Vector3.New(var_379_7.x, var_379_7.y, var_379_7.z)

				local var_379_8 = var_379_0.localEulerAngles

				var_379_8.z = 0
				var_379_8.x = 0
				var_379_0.localEulerAngles = var_379_8
			end

			local var_379_9 = arg_376_1.actors_["1097ui_story"]
			local var_379_10 = 0

			if var_379_10 < arg_376_1.time_ and arg_376_1.time_ <= var_379_10 + arg_379_0 and not isNil(var_379_9) and arg_376_1.var_.characterEffect1097ui_story == nil then
				arg_376_1.var_.characterEffect1097ui_story = var_379_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_379_11 = 0.200000002980232

			if var_379_10 <= arg_376_1.time_ and arg_376_1.time_ < var_379_10 + var_379_11 and not isNil(var_379_9) then
				local var_379_12 = (arg_376_1.time_ - var_379_10) / var_379_11

				if arg_376_1.var_.characterEffect1097ui_story and not isNil(var_379_9) then
					arg_376_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_376_1.time_ >= var_379_10 + var_379_11 and arg_376_1.time_ < var_379_10 + var_379_11 + arg_379_0 and not isNil(var_379_9) and arg_376_1.var_.characterEffect1097ui_story then
				arg_376_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_379_13 = 0

			if var_379_13 < arg_376_1.time_ and arg_376_1.time_ <= var_379_13 + arg_379_0 then
				arg_376_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			local var_379_14 = 0

			if var_379_14 < arg_376_1.time_ and arg_376_1.time_ <= var_379_14 + arg_379_0 then
				arg_376_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_379_15 = 0
			local var_379_16 = 0.4

			if var_379_15 < arg_376_1.time_ and arg_376_1.time_ <= var_379_15 + arg_379_0 then
				arg_376_1.talkMaxDuration = 0
				arg_376_1.dialogCg_.alpha = 1

				arg_376_1.dialog_:SetActive(true)
				SetActive(arg_376_1.leftNameGo_, true)

				local var_379_17 = arg_376_1:FormatText(StoryNameCfg[216].name)

				arg_376_1.leftNameTxt_.text = var_379_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_376_1.leftNameTxt_.transform)

				arg_376_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_376_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_376_1:RecordName(arg_376_1.leftNameTxt_.text)
				SetActive(arg_376_1.iconTrs_.gameObject, false)
				arg_376_1.callingController_:SetSelectedState("normal")

				local var_379_18 = arg_376_1:GetWordFromCfg(1109701092)
				local var_379_19 = arg_376_1:FormatText(var_379_18.content)

				arg_376_1.text_.text = var_379_19

				LuaForUtil.ClearLinePrefixSymbol(arg_376_1.text_)

				local var_379_20 = 16
				local var_379_21 = utf8.len(var_379_19)
				local var_379_22 = var_379_20 <= 0 and var_379_16 or var_379_16 * (var_379_21 / var_379_20)

				if var_379_22 > 0 and var_379_16 < var_379_22 then
					arg_376_1.talkMaxDuration = var_379_22

					if var_379_22 + var_379_15 > arg_376_1.duration_ then
						arg_376_1.duration_ = var_379_22 + var_379_15
					end
				end

				arg_376_1.text_.text = var_379_19
				arg_376_1.typewritter.percent = 0

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701092", "story_v_side_new_1109701.awb") ~= 0 then
					local var_379_23 = manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701092", "story_v_side_new_1109701.awb") / 1000

					if var_379_23 + var_379_15 > arg_376_1.duration_ then
						arg_376_1.duration_ = var_379_23 + var_379_15
					end

					if var_379_18.prefab_name ~= "" and arg_376_1.actors_[var_379_18.prefab_name] ~= nil then
						local var_379_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_376_1.actors_[var_379_18.prefab_name].transform, "story_v_side_new_1109701", "1109701092", "story_v_side_new_1109701.awb")

						arg_376_1:RecordAudio("1109701092", var_379_24)
						arg_376_1:RecordAudio("1109701092", var_379_24)
					else
						arg_376_1:AudioAction("play", "voice", "story_v_side_new_1109701", "1109701092", "story_v_side_new_1109701.awb")
					end

					arg_376_1:RecordHistoryTalkVoice("story_v_side_new_1109701", "1109701092", "story_v_side_new_1109701.awb")
				end

				arg_376_1:RecordContent(arg_376_1.text_.text)
			end

			local var_379_25 = math.max(var_379_16, arg_376_1.talkMaxDuration)

			if var_379_15 <= arg_376_1.time_ and arg_376_1.time_ < var_379_15 + var_379_25 then
				arg_376_1.typewritter.percent = (arg_376_1.time_ - var_379_15) / var_379_25

				arg_376_1.typewritter:SetDirty()
			end

			if arg_376_1.time_ >= var_379_15 + var_379_25 and arg_376_1.time_ < var_379_15 + var_379_25 + arg_379_0 then
				arg_376_1.typewritter.percent = 1

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(true)
			end
		end

		arg_376_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_376_1:InitPlayNodeList()
	end,
	Play1109701093 = function(arg_380_0, arg_380_1)
		arg_380_1.time_ = 0
		arg_380_1.frameCnt_ = 0
		arg_380_1.state_ = "playing"
		arg_380_1.curTalkId_ = 1109701093
		arg_380_1.duration_ = 7.1

		local var_380_0 = {
			zh = 7.1,
			ja = 6.1
		}
		local var_380_1 = manager.audio:GetLocalizationFlag()

		if var_380_0[var_380_1] ~= nil then
			arg_380_1.duration_ = var_380_0[var_380_1]
		end

		SetActive(arg_380_1.tipsGo_, false)

		function arg_380_1.onSingleLineFinish_()
			arg_380_1.onSingleLineUpdate_ = nil
			arg_380_1.onSingleLineFinish_ = nil
			arg_380_1.state_ = "waiting"
		end

		function arg_380_1.playNext_(arg_382_0)
			if arg_382_0 == 1 then
				arg_380_0:Play1109701094(arg_380_1)
			end
		end

		function arg_380_1.onSingleLineUpdate_(arg_383_0)
			local var_383_0 = arg_380_1.actors_["1097ui_story"].transform
			local var_383_1 = 0

			if var_383_1 < arg_380_1.time_ and arg_380_1.time_ <= var_383_1 + arg_383_0 then
				arg_380_1.var_.moveOldPos1097ui_story = var_383_0.localPosition
			end

			local var_383_2 = 0.001

			if var_383_1 <= arg_380_1.time_ and arg_380_1.time_ < var_383_1 + var_383_2 then
				local var_383_3 = (arg_380_1.time_ - var_383_1) / var_383_2
				local var_383_4 = Vector3.New(0, 100, 0)

				var_383_0.localPosition = Vector3.Lerp(arg_380_1.var_.moveOldPos1097ui_story, var_383_4, var_383_3)

				local var_383_5 = manager.ui.mainCamera.transform.position - var_383_0.position

				var_383_0.forward = Vector3.New(var_383_5.x, var_383_5.y, var_383_5.z)

				local var_383_6 = var_383_0.localEulerAngles

				var_383_6.z = 0
				var_383_6.x = 0
				var_383_0.localEulerAngles = var_383_6
			end

			if arg_380_1.time_ >= var_383_1 + var_383_2 and arg_380_1.time_ < var_383_1 + var_383_2 + arg_383_0 then
				var_383_0.localPosition = Vector3.New(0, 100, 0)

				local var_383_7 = manager.ui.mainCamera.transform.position - var_383_0.position

				var_383_0.forward = Vector3.New(var_383_7.x, var_383_7.y, var_383_7.z)

				local var_383_8 = var_383_0.localEulerAngles

				var_383_8.z = 0
				var_383_8.x = 0
				var_383_0.localEulerAngles = var_383_8
			end

			local var_383_9 = arg_380_1.actors_["1097ui_story"]
			local var_383_10 = 0

			if var_383_10 < arg_380_1.time_ and arg_380_1.time_ <= var_383_10 + arg_383_0 and not isNil(var_383_9) and arg_380_1.var_.characterEffect1097ui_story == nil then
				arg_380_1.var_.characterEffect1097ui_story = var_383_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_383_11 = 0.200000002980232

			if var_383_10 <= arg_380_1.time_ and arg_380_1.time_ < var_383_10 + var_383_11 and not isNil(var_383_9) then
				local var_383_12 = (arg_380_1.time_ - var_383_10) / var_383_11

				if arg_380_1.var_.characterEffect1097ui_story and not isNil(var_383_9) then
					local var_383_13 = Mathf.Lerp(0, 0.5, var_383_12)

					arg_380_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_380_1.var_.characterEffect1097ui_story.fillRatio = var_383_13
				end
			end

			if arg_380_1.time_ >= var_383_10 + var_383_11 and arg_380_1.time_ < var_383_10 + var_383_11 + arg_383_0 and not isNil(var_383_9) and arg_380_1.var_.characterEffect1097ui_story then
				local var_383_14 = 0.5

				arg_380_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_380_1.var_.characterEffect1097ui_story.fillRatio = var_383_14
			end

			local var_383_15 = arg_380_1.actors_["6045_story"].transform
			local var_383_16 = 0

			if var_383_16 < arg_380_1.time_ and arg_380_1.time_ <= var_383_16 + arg_383_0 then
				arg_380_1.var_.moveOldPos6045_story = var_383_15.localPosition

				local var_383_17 = GameObjectTools.GetOrAddComponent(var_383_15.gameObject, typeof(DynamicBoneHelper))

				if var_383_17 then
					var_383_17:EnableDynamicBone(false)
				end
			end

			local var_383_18 = 0.001

			if var_383_16 <= arg_380_1.time_ and arg_380_1.time_ < var_383_16 + var_383_18 then
				local var_383_19 = (arg_380_1.time_ - var_383_16) / var_383_18
				local var_383_20 = Vector3.New(-0.7, -0.5, -6.3)

				var_383_15.localPosition = Vector3.Lerp(arg_380_1.var_.moveOldPos6045_story, var_383_20, var_383_19)

				local var_383_21 = manager.ui.mainCamera.transform.position - var_383_15.position

				var_383_15.forward = Vector3.New(var_383_21.x, var_383_21.y, var_383_21.z)

				local var_383_22 = var_383_15.localEulerAngles

				var_383_22.z = 0
				var_383_22.x = 0
				var_383_15.localEulerAngles = var_383_22
			end

			if arg_380_1.time_ >= var_383_16 + var_383_18 and arg_380_1.time_ < var_383_16 + var_383_18 + arg_383_0 then
				var_383_15.localPosition = Vector3.New(-0.7, -0.5, -6.3)

				local var_383_23 = manager.ui.mainCamera.transform.position - var_383_15.position

				var_383_15.forward = Vector3.New(var_383_23.x, var_383_23.y, var_383_23.z)

				local var_383_24 = var_383_15.localEulerAngles

				var_383_24.z = 0
				var_383_24.x = 0
				var_383_15.localEulerAngles = var_383_24

				local var_383_25 = GameObjectTools.GetOrAddComponent(var_383_15.gameObject, typeof(DynamicBoneHelper))

				if var_383_25 then
					var_383_25:EnableDynamicBone(true)
				end
			end

			local var_383_26 = arg_380_1.actors_["6045_story"]
			local var_383_27 = 0

			if var_383_27 < arg_380_1.time_ and arg_380_1.time_ <= var_383_27 + arg_383_0 and not isNil(var_383_26) and arg_380_1.var_.characterEffect6045_story == nil then
				arg_380_1.var_.characterEffect6045_story = var_383_26:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_383_28 = 0.200000002980232

			if var_383_27 <= arg_380_1.time_ and arg_380_1.time_ < var_383_27 + var_383_28 and not isNil(var_383_26) then
				local var_383_29 = (arg_380_1.time_ - var_383_27) / var_383_28

				if arg_380_1.var_.characterEffect6045_story and not isNil(var_383_26) then
					local var_383_30 = Mathf.Lerp(0, 0.5, var_383_29)

					arg_380_1.var_.characterEffect6045_story.fillFlat = true
					arg_380_1.var_.characterEffect6045_story.fillRatio = var_383_30
				end
			end

			if arg_380_1.time_ >= var_383_27 + var_383_28 and arg_380_1.time_ < var_383_27 + var_383_28 + arg_383_0 and not isNil(var_383_26) and arg_380_1.var_.characterEffect6045_story then
				local var_383_31 = 0.5

				arg_380_1.var_.characterEffect6045_story.fillFlat = true
				arg_380_1.var_.characterEffect6045_story.fillRatio = var_383_31
			end

			local var_383_32 = arg_380_1.actors_["6046_story"].transform
			local var_383_33 = 0

			if var_383_33 < arg_380_1.time_ and arg_380_1.time_ <= var_383_33 + arg_383_0 then
				arg_380_1.var_.moveOldPos6046_story = var_383_32.localPosition

				local var_383_34 = GameObjectTools.GetOrAddComponent(var_383_32.gameObject, typeof(DynamicBoneHelper))

				if var_383_34 then
					var_383_34:EnableDynamicBone(false)
				end
			end

			local var_383_35 = 0.001

			if var_383_33 <= arg_380_1.time_ and arg_380_1.time_ < var_383_33 + var_383_35 then
				local var_383_36 = (arg_380_1.time_ - var_383_33) / var_383_35
				local var_383_37 = Vector3.New(0.7, -0.5, -6.3)

				var_383_32.localPosition = Vector3.Lerp(arg_380_1.var_.moveOldPos6046_story, var_383_37, var_383_36)

				local var_383_38 = manager.ui.mainCamera.transform.position - var_383_32.position

				var_383_32.forward = Vector3.New(var_383_38.x, var_383_38.y, var_383_38.z)

				local var_383_39 = var_383_32.localEulerAngles

				var_383_39.z = 0
				var_383_39.x = 0
				var_383_32.localEulerAngles = var_383_39
			end

			if arg_380_1.time_ >= var_383_33 + var_383_35 and arg_380_1.time_ < var_383_33 + var_383_35 + arg_383_0 then
				var_383_32.localPosition = Vector3.New(0.7, -0.5, -6.3)

				local var_383_40 = manager.ui.mainCamera.transform.position - var_383_32.position

				var_383_32.forward = Vector3.New(var_383_40.x, var_383_40.y, var_383_40.z)

				local var_383_41 = var_383_32.localEulerAngles

				var_383_41.z = 0
				var_383_41.x = 0
				var_383_32.localEulerAngles = var_383_41

				local var_383_42 = GameObjectTools.GetOrAddComponent(var_383_32.gameObject, typeof(DynamicBoneHelper))

				if var_383_42 then
					var_383_42:EnableDynamicBone(true)
				end
			end

			local var_383_43 = arg_380_1.actors_["6046_story"]
			local var_383_44 = 0

			if var_383_44 < arg_380_1.time_ and arg_380_1.time_ <= var_383_44 + arg_383_0 and not isNil(var_383_43) and arg_380_1.var_.characterEffect6046_story == nil then
				arg_380_1.var_.characterEffect6046_story = var_383_43:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_383_45 = 0.200000002980232

			if var_383_44 <= arg_380_1.time_ and arg_380_1.time_ < var_383_44 + var_383_45 and not isNil(var_383_43) then
				local var_383_46 = (arg_380_1.time_ - var_383_44) / var_383_45

				if arg_380_1.var_.characterEffect6046_story and not isNil(var_383_43) then
					arg_380_1.var_.characterEffect6046_story.fillFlat = false
				end
			end

			if arg_380_1.time_ >= var_383_44 + var_383_45 and arg_380_1.time_ < var_383_44 + var_383_45 + arg_383_0 and not isNil(var_383_43) and arg_380_1.var_.characterEffect6046_story then
				arg_380_1.var_.characterEffect6046_story.fillFlat = false
			end

			local var_383_47 = 0

			if var_383_47 < arg_380_1.time_ and arg_380_1.time_ <= var_383_47 + arg_383_0 then
				arg_380_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/story6046/story6046action/6046action4_2")
			end

			local var_383_48 = 0

			if var_383_48 < arg_380_1.time_ and arg_380_1.time_ <= var_383_48 + arg_383_0 then
				arg_380_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_383_49 = 0

			if var_383_49 < arg_380_1.time_ and arg_380_1.time_ <= var_383_49 + arg_383_0 then
				arg_380_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/story6045/story6045action/6045action4_2")
			end

			local var_383_50 = 0
			local var_383_51 = 0.675

			if var_383_50 < arg_380_1.time_ and arg_380_1.time_ <= var_383_50 + arg_383_0 then
				arg_380_1.talkMaxDuration = 0
				arg_380_1.dialogCg_.alpha = 1

				arg_380_1.dialog_:SetActive(true)
				SetActive(arg_380_1.leftNameGo_, true)

				local var_383_52 = arg_380_1:FormatText(StoryNameCfg[214].name)

				arg_380_1.leftNameTxt_.text = var_383_52

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_380_1.leftNameTxt_.transform)

				arg_380_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_380_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_380_1:RecordName(arg_380_1.leftNameTxt_.text)
				SetActive(arg_380_1.iconTrs_.gameObject, false)
				arg_380_1.callingController_:SetSelectedState("normal")

				local var_383_53 = arg_380_1:GetWordFromCfg(1109701093)
				local var_383_54 = arg_380_1:FormatText(var_383_53.content)

				arg_380_1.text_.text = var_383_54

				LuaForUtil.ClearLinePrefixSymbol(arg_380_1.text_)

				local var_383_55 = 27
				local var_383_56 = utf8.len(var_383_54)
				local var_383_57 = var_383_55 <= 0 and var_383_51 or var_383_51 * (var_383_56 / var_383_55)

				if var_383_57 > 0 and var_383_51 < var_383_57 then
					arg_380_1.talkMaxDuration = var_383_57

					if var_383_57 + var_383_50 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_57 + var_383_50
					end
				end

				arg_380_1.text_.text = var_383_54
				arg_380_1.typewritter.percent = 0

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701093", "story_v_side_new_1109701.awb") ~= 0 then
					local var_383_58 = manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701093", "story_v_side_new_1109701.awb") / 1000

					if var_383_58 + var_383_50 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_58 + var_383_50
					end

					if var_383_53.prefab_name ~= "" and arg_380_1.actors_[var_383_53.prefab_name] ~= nil then
						local var_383_59 = LuaForUtil.PlayVoiceWithCriLipsync(arg_380_1.actors_[var_383_53.prefab_name].transform, "story_v_side_new_1109701", "1109701093", "story_v_side_new_1109701.awb")

						arg_380_1:RecordAudio("1109701093", var_383_59)
						arg_380_1:RecordAudio("1109701093", var_383_59)
					else
						arg_380_1:AudioAction("play", "voice", "story_v_side_new_1109701", "1109701093", "story_v_side_new_1109701.awb")
					end

					arg_380_1:RecordHistoryTalkVoice("story_v_side_new_1109701", "1109701093", "story_v_side_new_1109701.awb")
				end

				arg_380_1:RecordContent(arg_380_1.text_.text)
			end

			local var_383_60 = math.max(var_383_51, arg_380_1.talkMaxDuration)

			if var_383_50 <= arg_380_1.time_ and arg_380_1.time_ < var_383_50 + var_383_60 then
				arg_380_1.typewritter.percent = (arg_380_1.time_ - var_383_50) / var_383_60

				arg_380_1.typewritter:SetDirty()
			end

			if arg_380_1.time_ >= var_383_50 + var_383_60 and arg_380_1.time_ < var_383_50 + var_383_60 + arg_383_0 then
				arg_380_1.typewritter.percent = 1

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(true)
			end
		end

		arg_380_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6045_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6046_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_380_1:InitPlayNodeList()
	end,
	Play1109701094 = function(arg_384_0, arg_384_1)
		arg_384_1.time_ = 0
		arg_384_1.frameCnt_ = 0
		arg_384_1.state_ = "playing"
		arg_384_1.curTalkId_ = 1109701094
		arg_384_1.duration_ = 5.67

		local var_384_0 = {
			zh = 5.666,
			ja = 3.966
		}
		local var_384_1 = manager.audio:GetLocalizationFlag()

		if var_384_0[var_384_1] ~= nil then
			arg_384_1.duration_ = var_384_0[var_384_1]
		end

		SetActive(arg_384_1.tipsGo_, false)

		function arg_384_1.onSingleLineFinish_()
			arg_384_1.onSingleLineUpdate_ = nil
			arg_384_1.onSingleLineFinish_ = nil
			arg_384_1.state_ = "waiting"
		end

		function arg_384_1.playNext_(arg_386_0)
			if arg_386_0 == 1 then
				arg_384_0:Play1109701095(arg_384_1)
			end
		end

		function arg_384_1.onSingleLineUpdate_(arg_387_0)
			local var_387_0 = arg_384_1.actors_["6045_story"].transform
			local var_387_1 = 0

			if var_387_1 < arg_384_1.time_ and arg_384_1.time_ <= var_387_1 + arg_387_0 then
				arg_384_1.var_.moveOldPos6045_story = var_387_0.localPosition

				local var_387_2 = GameObjectTools.GetOrAddComponent(var_387_0.gameObject, typeof(DynamicBoneHelper))

				if var_387_2 then
					var_387_2:EnableDynamicBone(false)
				end
			end

			local var_387_3 = 0.001

			if var_387_1 <= arg_384_1.time_ and arg_384_1.time_ < var_387_1 + var_387_3 then
				local var_387_4 = (arg_384_1.time_ - var_387_1) / var_387_3
				local var_387_5 = Vector3.New(-0.7, -0.5, -6.3)

				var_387_0.localPosition = Vector3.Lerp(arg_384_1.var_.moveOldPos6045_story, var_387_5, var_387_4)

				local var_387_6 = manager.ui.mainCamera.transform.position - var_387_0.position

				var_387_0.forward = Vector3.New(var_387_6.x, var_387_6.y, var_387_6.z)

				local var_387_7 = var_387_0.localEulerAngles

				var_387_7.z = 0
				var_387_7.x = 0
				var_387_0.localEulerAngles = var_387_7
			end

			if arg_384_1.time_ >= var_387_1 + var_387_3 and arg_384_1.time_ < var_387_1 + var_387_3 + arg_387_0 then
				var_387_0.localPosition = Vector3.New(-0.7, -0.5, -6.3)

				local var_387_8 = manager.ui.mainCamera.transform.position - var_387_0.position

				var_387_0.forward = Vector3.New(var_387_8.x, var_387_8.y, var_387_8.z)

				local var_387_9 = var_387_0.localEulerAngles

				var_387_9.z = 0
				var_387_9.x = 0
				var_387_0.localEulerAngles = var_387_9

				local var_387_10 = GameObjectTools.GetOrAddComponent(var_387_0.gameObject, typeof(DynamicBoneHelper))

				if var_387_10 then
					var_387_10:EnableDynamicBone(true)
				end
			end

			local var_387_11 = arg_384_1.actors_["6045_story"]
			local var_387_12 = 0

			if var_387_12 < arg_384_1.time_ and arg_384_1.time_ <= var_387_12 + arg_387_0 and not isNil(var_387_11) and arg_384_1.var_.characterEffect6045_story == nil then
				arg_384_1.var_.characterEffect6045_story = var_387_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_387_13 = 0.200000002980232

			if var_387_12 <= arg_384_1.time_ and arg_384_1.time_ < var_387_12 + var_387_13 and not isNil(var_387_11) then
				local var_387_14 = (arg_384_1.time_ - var_387_12) / var_387_13

				if arg_384_1.var_.characterEffect6045_story and not isNil(var_387_11) then
					arg_384_1.var_.characterEffect6045_story.fillFlat = false
				end
			end

			if arg_384_1.time_ >= var_387_12 + var_387_13 and arg_384_1.time_ < var_387_12 + var_387_13 + arg_387_0 and not isNil(var_387_11) and arg_384_1.var_.characterEffect6045_story then
				arg_384_1.var_.characterEffect6045_story.fillFlat = false
			end

			local var_387_15 = 0

			if var_387_15 < arg_384_1.time_ and arg_384_1.time_ <= var_387_15 + arg_387_0 then
				arg_384_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/story6045/story6045action/6045action1_1")
			end

			local var_387_16 = 0

			if var_387_16 < arg_384_1.time_ and arg_384_1.time_ <= var_387_16 + arg_387_0 then
				arg_384_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_387_17 = arg_384_1.actors_["6046_story"]
			local var_387_18 = 0

			if var_387_18 < arg_384_1.time_ and arg_384_1.time_ <= var_387_18 + arg_387_0 and not isNil(var_387_17) and arg_384_1.var_.characterEffect6046_story == nil then
				arg_384_1.var_.characterEffect6046_story = var_387_17:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_387_19 = 0.200000002980232

			if var_387_18 <= arg_384_1.time_ and arg_384_1.time_ < var_387_18 + var_387_19 and not isNil(var_387_17) then
				local var_387_20 = (arg_384_1.time_ - var_387_18) / var_387_19

				if arg_384_1.var_.characterEffect6046_story and not isNil(var_387_17) then
					local var_387_21 = Mathf.Lerp(0, 0.5, var_387_20)

					arg_384_1.var_.characterEffect6046_story.fillFlat = true
					arg_384_1.var_.characterEffect6046_story.fillRatio = var_387_21
				end
			end

			if arg_384_1.time_ >= var_387_18 + var_387_19 and arg_384_1.time_ < var_387_18 + var_387_19 + arg_387_0 and not isNil(var_387_17) and arg_384_1.var_.characterEffect6046_story then
				local var_387_22 = 0.5

				arg_384_1.var_.characterEffect6046_story.fillFlat = true
				arg_384_1.var_.characterEffect6046_story.fillRatio = var_387_22
			end

			local var_387_23 = 0
			local var_387_24 = 0.45

			if var_387_23 < arg_384_1.time_ and arg_384_1.time_ <= var_387_23 + arg_387_0 then
				arg_384_1.talkMaxDuration = 0
				arg_384_1.dialogCg_.alpha = 1

				arg_384_1.dialog_:SetActive(true)
				SetActive(arg_384_1.leftNameGo_, true)

				local var_387_25 = arg_384_1:FormatText(StoryNameCfg[215].name)

				arg_384_1.leftNameTxt_.text = var_387_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_384_1.leftNameTxt_.transform)

				arg_384_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_384_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_384_1:RecordName(arg_384_1.leftNameTxt_.text)
				SetActive(arg_384_1.iconTrs_.gameObject, false)
				arg_384_1.callingController_:SetSelectedState("normal")

				local var_387_26 = arg_384_1:GetWordFromCfg(1109701094)
				local var_387_27 = arg_384_1:FormatText(var_387_26.content)

				arg_384_1.text_.text = var_387_27

				LuaForUtil.ClearLinePrefixSymbol(arg_384_1.text_)

				local var_387_28 = 18
				local var_387_29 = utf8.len(var_387_27)
				local var_387_30 = var_387_28 <= 0 and var_387_24 or var_387_24 * (var_387_29 / var_387_28)

				if var_387_30 > 0 and var_387_24 < var_387_30 then
					arg_384_1.talkMaxDuration = var_387_30

					if var_387_30 + var_387_23 > arg_384_1.duration_ then
						arg_384_1.duration_ = var_387_30 + var_387_23
					end
				end

				arg_384_1.text_.text = var_387_27
				arg_384_1.typewritter.percent = 0

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701094", "story_v_side_new_1109701.awb") ~= 0 then
					local var_387_31 = manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701094", "story_v_side_new_1109701.awb") / 1000

					if var_387_31 + var_387_23 > arg_384_1.duration_ then
						arg_384_1.duration_ = var_387_31 + var_387_23
					end

					if var_387_26.prefab_name ~= "" and arg_384_1.actors_[var_387_26.prefab_name] ~= nil then
						local var_387_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_384_1.actors_[var_387_26.prefab_name].transform, "story_v_side_new_1109701", "1109701094", "story_v_side_new_1109701.awb")

						arg_384_1:RecordAudio("1109701094", var_387_32)
						arg_384_1:RecordAudio("1109701094", var_387_32)
					else
						arg_384_1:AudioAction("play", "voice", "story_v_side_new_1109701", "1109701094", "story_v_side_new_1109701.awb")
					end

					arg_384_1:RecordHistoryTalkVoice("story_v_side_new_1109701", "1109701094", "story_v_side_new_1109701.awb")
				end

				arg_384_1:RecordContent(arg_384_1.text_.text)
			end

			local var_387_33 = math.max(var_387_24, arg_384_1.talkMaxDuration)

			if var_387_23 <= arg_384_1.time_ and arg_384_1.time_ < var_387_23 + var_387_33 then
				arg_384_1.typewritter.percent = (arg_384_1.time_ - var_387_23) / var_387_33

				arg_384_1.typewritter:SetDirty()
			end

			if arg_384_1.time_ >= var_387_23 + var_387_33 and arg_384_1.time_ < var_387_23 + var_387_33 + arg_387_0 then
				arg_384_1.typewritter.percent = 1

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(true)
			end
		end

		arg_384_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6045_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_384_1:InitPlayNodeList()
	end,
	Play1109701095 = function(arg_388_0, arg_388_1)
		arg_388_1.time_ = 0
		arg_388_1.frameCnt_ = 0
		arg_388_1.state_ = "playing"
		arg_388_1.curTalkId_ = 1109701095
		arg_388_1.duration_ = 2

		SetActive(arg_388_1.tipsGo_, false)

		function arg_388_1.onSingleLineFinish_()
			arg_388_1.onSingleLineUpdate_ = nil
			arg_388_1.onSingleLineFinish_ = nil
			arg_388_1.state_ = "waiting"
		end

		function arg_388_1.playNext_(arg_390_0)
			if arg_390_0 == 1 then
				arg_388_0:Play1109701096(arg_388_1)
			end
		end

		function arg_388_1.onSingleLineUpdate_(arg_391_0)
			local var_391_0 = arg_388_1.actors_["6045_story"].transform
			local var_391_1 = 0

			if var_391_1 < arg_388_1.time_ and arg_388_1.time_ <= var_391_1 + arg_391_0 then
				arg_388_1.var_.moveOldPos6045_story = var_391_0.localPosition

				local var_391_2 = GameObjectTools.GetOrAddComponent(var_391_0.gameObject, typeof(DynamicBoneHelper))

				if var_391_2 then
					var_391_2:EnableDynamicBone(false)
				end
			end

			local var_391_3 = 0.001

			if var_391_1 <= arg_388_1.time_ and arg_388_1.time_ < var_391_1 + var_391_3 then
				local var_391_4 = (arg_388_1.time_ - var_391_1) / var_391_3
				local var_391_5 = Vector3.New(0, 100, 0)

				var_391_0.localPosition = Vector3.Lerp(arg_388_1.var_.moveOldPos6045_story, var_391_5, var_391_4)

				local var_391_6 = manager.ui.mainCamera.transform.position - var_391_0.position

				var_391_0.forward = Vector3.New(var_391_6.x, var_391_6.y, var_391_6.z)

				local var_391_7 = var_391_0.localEulerAngles

				var_391_7.z = 0
				var_391_7.x = 0
				var_391_0.localEulerAngles = var_391_7
			end

			if arg_388_1.time_ >= var_391_1 + var_391_3 and arg_388_1.time_ < var_391_1 + var_391_3 + arg_391_0 then
				var_391_0.localPosition = Vector3.New(0, 100, 0)

				local var_391_8 = manager.ui.mainCamera.transform.position - var_391_0.position

				var_391_0.forward = Vector3.New(var_391_8.x, var_391_8.y, var_391_8.z)

				local var_391_9 = var_391_0.localEulerAngles

				var_391_9.z = 0
				var_391_9.x = 0
				var_391_0.localEulerAngles = var_391_9

				local var_391_10 = GameObjectTools.GetOrAddComponent(var_391_0.gameObject, typeof(DynamicBoneHelper))

				if var_391_10 then
					var_391_10:EnableDynamicBone(true)
				end
			end

			local var_391_11 = arg_388_1.actors_["6045_story"]
			local var_391_12 = 0

			if var_391_12 < arg_388_1.time_ and arg_388_1.time_ <= var_391_12 + arg_391_0 and not isNil(var_391_11) and arg_388_1.var_.characterEffect6045_story == nil then
				arg_388_1.var_.characterEffect6045_story = var_391_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_391_13 = 0.200000002980232

			if var_391_12 <= arg_388_1.time_ and arg_388_1.time_ < var_391_12 + var_391_13 and not isNil(var_391_11) then
				local var_391_14 = (arg_388_1.time_ - var_391_12) / var_391_13

				if arg_388_1.var_.characterEffect6045_story and not isNil(var_391_11) then
					local var_391_15 = Mathf.Lerp(0, 0.5, var_391_14)

					arg_388_1.var_.characterEffect6045_story.fillFlat = true
					arg_388_1.var_.characterEffect6045_story.fillRatio = var_391_15
				end
			end

			if arg_388_1.time_ >= var_391_12 + var_391_13 and arg_388_1.time_ < var_391_12 + var_391_13 + arg_391_0 and not isNil(var_391_11) and arg_388_1.var_.characterEffect6045_story then
				local var_391_16 = 0.5

				arg_388_1.var_.characterEffect6045_story.fillFlat = true
				arg_388_1.var_.characterEffect6045_story.fillRatio = var_391_16
			end

			local var_391_17 = arg_388_1.actors_["6046_story"].transform
			local var_391_18 = 0

			if var_391_18 < arg_388_1.time_ and arg_388_1.time_ <= var_391_18 + arg_391_0 then
				arg_388_1.var_.moveOldPos6046_story = var_391_17.localPosition

				local var_391_19 = GameObjectTools.GetOrAddComponent(var_391_17.gameObject, typeof(DynamicBoneHelper))

				if var_391_19 then
					var_391_19:EnableDynamicBone(false)
				end
			end

			local var_391_20 = 0.001

			if var_391_18 <= arg_388_1.time_ and arg_388_1.time_ < var_391_18 + var_391_20 then
				local var_391_21 = (arg_388_1.time_ - var_391_18) / var_391_20
				local var_391_22 = Vector3.New(0, 100, 0)

				var_391_17.localPosition = Vector3.Lerp(arg_388_1.var_.moveOldPos6046_story, var_391_22, var_391_21)

				local var_391_23 = manager.ui.mainCamera.transform.position - var_391_17.position

				var_391_17.forward = Vector3.New(var_391_23.x, var_391_23.y, var_391_23.z)

				local var_391_24 = var_391_17.localEulerAngles

				var_391_24.z = 0
				var_391_24.x = 0
				var_391_17.localEulerAngles = var_391_24
			end

			if arg_388_1.time_ >= var_391_18 + var_391_20 and arg_388_1.time_ < var_391_18 + var_391_20 + arg_391_0 then
				var_391_17.localPosition = Vector3.New(0, 100, 0)

				local var_391_25 = manager.ui.mainCamera.transform.position - var_391_17.position

				var_391_17.forward = Vector3.New(var_391_25.x, var_391_25.y, var_391_25.z)

				local var_391_26 = var_391_17.localEulerAngles

				var_391_26.z = 0
				var_391_26.x = 0
				var_391_17.localEulerAngles = var_391_26

				local var_391_27 = GameObjectTools.GetOrAddComponent(var_391_17.gameObject, typeof(DynamicBoneHelper))

				if var_391_27 then
					var_391_27:EnableDynamicBone(true)
				end
			end

			local var_391_28 = arg_388_1.actors_["6046_story"]
			local var_391_29 = 0

			if var_391_29 < arg_388_1.time_ and arg_388_1.time_ <= var_391_29 + arg_391_0 and not isNil(var_391_28) and arg_388_1.var_.characterEffect6046_story == nil then
				arg_388_1.var_.characterEffect6046_story = var_391_28:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_391_30 = 0.200000002980232

			if var_391_29 <= arg_388_1.time_ and arg_388_1.time_ < var_391_29 + var_391_30 and not isNil(var_391_28) then
				local var_391_31 = (arg_388_1.time_ - var_391_29) / var_391_30

				if arg_388_1.var_.characterEffect6046_story and not isNil(var_391_28) then
					local var_391_32 = Mathf.Lerp(0, 0.5, var_391_31)

					arg_388_1.var_.characterEffect6046_story.fillFlat = true
					arg_388_1.var_.characterEffect6046_story.fillRatio = var_391_32
				end
			end

			if arg_388_1.time_ >= var_391_29 + var_391_30 and arg_388_1.time_ < var_391_29 + var_391_30 + arg_391_0 and not isNil(var_391_28) and arg_388_1.var_.characterEffect6046_story then
				local var_391_33 = 0.5

				arg_388_1.var_.characterEffect6046_story.fillFlat = true
				arg_388_1.var_.characterEffect6046_story.fillRatio = var_391_33
			end

			local var_391_34 = arg_388_1.actors_["1097ui_story"].transform
			local var_391_35 = 0

			if var_391_35 < arg_388_1.time_ and arg_388_1.time_ <= var_391_35 + arg_391_0 then
				arg_388_1.var_.moveOldPos1097ui_story = var_391_34.localPosition
			end

			local var_391_36 = 0.001

			if var_391_35 <= arg_388_1.time_ and arg_388_1.time_ < var_391_35 + var_391_36 then
				local var_391_37 = (arg_388_1.time_ - var_391_35) / var_391_36
				local var_391_38 = Vector3.New(0, -0.54, -6.3)

				var_391_34.localPosition = Vector3.Lerp(arg_388_1.var_.moveOldPos1097ui_story, var_391_38, var_391_37)

				local var_391_39 = manager.ui.mainCamera.transform.position - var_391_34.position

				var_391_34.forward = Vector3.New(var_391_39.x, var_391_39.y, var_391_39.z)

				local var_391_40 = var_391_34.localEulerAngles

				var_391_40.z = 0
				var_391_40.x = 0
				var_391_34.localEulerAngles = var_391_40
			end

			if arg_388_1.time_ >= var_391_35 + var_391_36 and arg_388_1.time_ < var_391_35 + var_391_36 + arg_391_0 then
				var_391_34.localPosition = Vector3.New(0, -0.54, -6.3)

				local var_391_41 = manager.ui.mainCamera.transform.position - var_391_34.position

				var_391_34.forward = Vector3.New(var_391_41.x, var_391_41.y, var_391_41.z)

				local var_391_42 = var_391_34.localEulerAngles

				var_391_42.z = 0
				var_391_42.x = 0
				var_391_34.localEulerAngles = var_391_42
			end

			local var_391_43 = arg_388_1.actors_["1097ui_story"]
			local var_391_44 = 0

			if var_391_44 < arg_388_1.time_ and arg_388_1.time_ <= var_391_44 + arg_391_0 and not isNil(var_391_43) and arg_388_1.var_.characterEffect1097ui_story == nil then
				arg_388_1.var_.characterEffect1097ui_story = var_391_43:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_391_45 = 0.200000002980232

			if var_391_44 <= arg_388_1.time_ and arg_388_1.time_ < var_391_44 + var_391_45 and not isNil(var_391_43) then
				local var_391_46 = (arg_388_1.time_ - var_391_44) / var_391_45

				if arg_388_1.var_.characterEffect1097ui_story and not isNil(var_391_43) then
					arg_388_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_388_1.time_ >= var_391_44 + var_391_45 and arg_388_1.time_ < var_391_44 + var_391_45 + arg_391_0 and not isNil(var_391_43) and arg_388_1.var_.characterEffect1097ui_story then
				arg_388_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_391_47 = 0

			if var_391_47 < arg_388_1.time_ and arg_388_1.time_ <= var_391_47 + arg_391_0 then
				arg_388_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action7_1")
			end

			local var_391_48 = 0

			if var_391_48 < arg_388_1.time_ and arg_388_1.time_ <= var_391_48 + arg_391_0 then
				arg_388_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_391_49 = 0
			local var_391_50 = 0.075

			if var_391_49 < arg_388_1.time_ and arg_388_1.time_ <= var_391_49 + arg_391_0 then
				arg_388_1.talkMaxDuration = 0
				arg_388_1.dialogCg_.alpha = 1

				arg_388_1.dialog_:SetActive(true)
				SetActive(arg_388_1.leftNameGo_, true)

				local var_391_51 = arg_388_1:FormatText(StoryNameCfg[216].name)

				arg_388_1.leftNameTxt_.text = var_391_51

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_388_1.leftNameTxt_.transform)

				arg_388_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_388_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_388_1:RecordName(arg_388_1.leftNameTxt_.text)
				SetActive(arg_388_1.iconTrs_.gameObject, false)
				arg_388_1.callingController_:SetSelectedState("normal")

				local var_391_52 = arg_388_1:GetWordFromCfg(1109701095)
				local var_391_53 = arg_388_1:FormatText(var_391_52.content)

				arg_388_1.text_.text = var_391_53

				LuaForUtil.ClearLinePrefixSymbol(arg_388_1.text_)

				local var_391_54 = 3
				local var_391_55 = utf8.len(var_391_53)
				local var_391_56 = var_391_54 <= 0 and var_391_50 or var_391_50 * (var_391_55 / var_391_54)

				if var_391_56 > 0 and var_391_50 < var_391_56 then
					arg_388_1.talkMaxDuration = var_391_56

					if var_391_56 + var_391_49 > arg_388_1.duration_ then
						arg_388_1.duration_ = var_391_56 + var_391_49
					end
				end

				arg_388_1.text_.text = var_391_53
				arg_388_1.typewritter.percent = 0

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701095", "story_v_side_new_1109701.awb") ~= 0 then
					local var_391_57 = manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701095", "story_v_side_new_1109701.awb") / 1000

					if var_391_57 + var_391_49 > arg_388_1.duration_ then
						arg_388_1.duration_ = var_391_57 + var_391_49
					end

					if var_391_52.prefab_name ~= "" and arg_388_1.actors_[var_391_52.prefab_name] ~= nil then
						local var_391_58 = LuaForUtil.PlayVoiceWithCriLipsync(arg_388_1.actors_[var_391_52.prefab_name].transform, "story_v_side_new_1109701", "1109701095", "story_v_side_new_1109701.awb")

						arg_388_1:RecordAudio("1109701095", var_391_58)
						arg_388_1:RecordAudio("1109701095", var_391_58)
					else
						arg_388_1:AudioAction("play", "voice", "story_v_side_new_1109701", "1109701095", "story_v_side_new_1109701.awb")
					end

					arg_388_1:RecordHistoryTalkVoice("story_v_side_new_1109701", "1109701095", "story_v_side_new_1109701.awb")
				end

				arg_388_1:RecordContent(arg_388_1.text_.text)
			end

			local var_391_59 = math.max(var_391_50, arg_388_1.talkMaxDuration)

			if var_391_49 <= arg_388_1.time_ and arg_388_1.time_ < var_391_49 + var_391_59 then
				arg_388_1.typewritter.percent = (arg_388_1.time_ - var_391_49) / var_391_59

				arg_388_1.typewritter:SetDirty()
			end

			if arg_388_1.time_ >= var_391_49 + var_391_59 and arg_388_1.time_ < var_391_49 + var_391_59 + arg_391_0 then
				arg_388_1.typewritter.percent = 1

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(true)
			end
		end

		arg_388_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6045_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6046_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_388_1:InitPlayNodeList()
	end,
	Play1109701096 = function(arg_392_0, arg_392_1)
		arg_392_1.time_ = 0
		arg_392_1.frameCnt_ = 0
		arg_392_1.state_ = "playing"
		arg_392_1.curTalkId_ = 1109701096
		arg_392_1.duration_ = 5

		SetActive(arg_392_1.tipsGo_, false)

		function arg_392_1.onSingleLineFinish_()
			arg_392_1.onSingleLineUpdate_ = nil
			arg_392_1.onSingleLineFinish_ = nil
			arg_392_1.state_ = "waiting"
		end

		function arg_392_1.playNext_(arg_394_0)
			if arg_394_0 == 1 then
				arg_392_0:Play1109701097(arg_392_1)
			end
		end

		function arg_392_1.onSingleLineUpdate_(arg_395_0)
			local var_395_0 = arg_392_1.actors_["1097ui_story"]
			local var_395_1 = 0

			if var_395_1 < arg_392_1.time_ and arg_392_1.time_ <= var_395_1 + arg_395_0 and not isNil(var_395_0) and arg_392_1.var_.characterEffect1097ui_story == nil then
				arg_392_1.var_.characterEffect1097ui_story = var_395_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_395_2 = 0.200000002980232

			if var_395_1 <= arg_392_1.time_ and arg_392_1.time_ < var_395_1 + var_395_2 and not isNil(var_395_0) then
				local var_395_3 = (arg_392_1.time_ - var_395_1) / var_395_2

				if arg_392_1.var_.characterEffect1097ui_story and not isNil(var_395_0) then
					local var_395_4 = Mathf.Lerp(0, 0.5, var_395_3)

					arg_392_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_392_1.var_.characterEffect1097ui_story.fillRatio = var_395_4
				end
			end

			if arg_392_1.time_ >= var_395_1 + var_395_2 and arg_392_1.time_ < var_395_1 + var_395_2 + arg_395_0 and not isNil(var_395_0) and arg_392_1.var_.characterEffect1097ui_story then
				local var_395_5 = 0.5

				arg_392_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_392_1.var_.characterEffect1097ui_story.fillRatio = var_395_5
			end

			local var_395_6 = 0
			local var_395_7 = 0.35

			if var_395_6 < arg_392_1.time_ and arg_392_1.time_ <= var_395_6 + arg_395_0 then
				arg_392_1.talkMaxDuration = 0
				arg_392_1.dialogCg_.alpha = 1

				arg_392_1.dialog_:SetActive(true)
				SetActive(arg_392_1.leftNameGo_, false)

				arg_392_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_392_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_392_1:RecordName(arg_392_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_392_1.iconTrs_.gameObject, false)
				arg_392_1.callingController_:SetSelectedState("normal")

				local var_395_8 = arg_392_1:GetWordFromCfg(1109701096)
				local var_395_9 = arg_392_1:FormatText(var_395_8.content)

				arg_392_1.text_.text = var_395_9

				LuaForUtil.ClearLinePrefixSymbol(arg_392_1.text_)

				local var_395_10 = 14
				local var_395_11 = utf8.len(var_395_9)
				local var_395_12 = var_395_10 <= 0 and var_395_7 or var_395_7 * (var_395_11 / var_395_10)

				if var_395_12 > 0 and var_395_7 < var_395_12 then
					arg_392_1.talkMaxDuration = var_395_12

					if var_395_12 + var_395_6 > arg_392_1.duration_ then
						arg_392_1.duration_ = var_395_12 + var_395_6
					end
				end

				arg_392_1.text_.text = var_395_9
				arg_392_1.typewritter.percent = 0

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(false)
				arg_392_1:RecordContent(arg_392_1.text_.text)
			end

			local var_395_13 = math.max(var_395_7, arg_392_1.talkMaxDuration)

			if var_395_6 <= arg_392_1.time_ and arg_392_1.time_ < var_395_6 + var_395_13 then
				arg_392_1.typewritter.percent = (arg_392_1.time_ - var_395_6) / var_395_13

				arg_392_1.typewritter:SetDirty()
			end

			if arg_392_1.time_ >= var_395_6 + var_395_13 and arg_392_1.time_ < var_395_6 + var_395_13 + arg_395_0 then
				arg_392_1.typewritter.percent = 1

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(true)
			end
		end

		arg_392_1.nodeConfigList_ = {}

		arg_392_1:InitPlayNodeList()
	end,
	Play1109701097 = function(arg_396_0, arg_396_1)
		arg_396_1.time_ = 0
		arg_396_1.frameCnt_ = 0
		arg_396_1.state_ = "playing"
		arg_396_1.curTalkId_ = 1109701097
		arg_396_1.duration_ = 5

		SetActive(arg_396_1.tipsGo_, false)

		function arg_396_1.onSingleLineFinish_()
			arg_396_1.onSingleLineUpdate_ = nil
			arg_396_1.onSingleLineFinish_ = nil
			arg_396_1.state_ = "waiting"
		end

		function arg_396_1.playNext_(arg_398_0)
			if arg_398_0 == 1 then
				arg_396_0:Play1109701098(arg_396_1)
			end
		end

		function arg_396_1.onSingleLineUpdate_(arg_399_0)
			local var_399_0 = 0
			local var_399_1 = 1.125

			if var_399_0 < arg_396_1.time_ and arg_396_1.time_ <= var_399_0 + arg_399_0 then
				arg_396_1.talkMaxDuration = 0
				arg_396_1.dialogCg_.alpha = 1

				arg_396_1.dialog_:SetActive(true)
				SetActive(arg_396_1.leftNameGo_, true)

				local var_399_2 = arg_396_1:FormatText(StoryNameCfg[7].name)

				arg_396_1.leftNameTxt_.text = var_399_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_396_1.leftNameTxt_.transform)

				arg_396_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_396_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_396_1:RecordName(arg_396_1.leftNameTxt_.text)
				SetActive(arg_396_1.iconTrs_.gameObject, true)
				arg_396_1.iconController_:SetSelectedState("hero")

				arg_396_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_396_1.callingController_:SetSelectedState("normal")

				arg_396_1.keyicon_.color = Color.New(1, 1, 1)
				arg_396_1.icon_.color = Color.New(1, 1, 1)

				local var_399_3 = arg_396_1:GetWordFromCfg(1109701097)
				local var_399_4 = arg_396_1:FormatText(var_399_3.content)

				arg_396_1.text_.text = var_399_4

				LuaForUtil.ClearLinePrefixSymbol(arg_396_1.text_)

				local var_399_5 = 47
				local var_399_6 = utf8.len(var_399_4)
				local var_399_7 = var_399_5 <= 0 and var_399_1 or var_399_1 * (var_399_6 / var_399_5)

				if var_399_7 > 0 and var_399_1 < var_399_7 then
					arg_396_1.talkMaxDuration = var_399_7

					if var_399_7 + var_399_0 > arg_396_1.duration_ then
						arg_396_1.duration_ = var_399_7 + var_399_0
					end
				end

				arg_396_1.text_.text = var_399_4
				arg_396_1.typewritter.percent = 0

				arg_396_1.typewritter:SetDirty()
				arg_396_1:ShowNextGo(false)
				arg_396_1:RecordContent(arg_396_1.text_.text)
			end

			local var_399_8 = math.max(var_399_1, arg_396_1.talkMaxDuration)

			if var_399_0 <= arg_396_1.time_ and arg_396_1.time_ < var_399_0 + var_399_8 then
				arg_396_1.typewritter.percent = (arg_396_1.time_ - var_399_0) / var_399_8

				arg_396_1.typewritter:SetDirty()
			end

			if arg_396_1.time_ >= var_399_0 + var_399_8 and arg_396_1.time_ < var_399_0 + var_399_8 + arg_399_0 then
				arg_396_1.typewritter.percent = 1

				arg_396_1.typewritter:SetDirty()
				arg_396_1:ShowNextGo(true)
			end
		end

		arg_396_1.nodeConfigList_ = {}

		arg_396_1:InitPlayNodeList()
	end,
	Play1109701098 = function(arg_400_0, arg_400_1)
		arg_400_1.time_ = 0
		arg_400_1.frameCnt_ = 0
		arg_400_1.state_ = "playing"
		arg_400_1.curTalkId_ = 1109701098
		arg_400_1.duration_ = 5.27

		local var_400_0 = {
			zh = 5.266,
			ja = 4.366
		}
		local var_400_1 = manager.audio:GetLocalizationFlag()

		if var_400_0[var_400_1] ~= nil then
			arg_400_1.duration_ = var_400_0[var_400_1]
		end

		SetActive(arg_400_1.tipsGo_, false)

		function arg_400_1.onSingleLineFinish_()
			arg_400_1.onSingleLineUpdate_ = nil
			arg_400_1.onSingleLineFinish_ = nil
			arg_400_1.state_ = "waiting"
		end

		function arg_400_1.playNext_(arg_402_0)
			if arg_402_0 == 1 then
				arg_400_0:Play1109701099(arg_400_1)
			end
		end

		function arg_400_1.onSingleLineUpdate_(arg_403_0)
			local var_403_0 = arg_400_1.actors_["1097ui_story"].transform
			local var_403_1 = 0

			if var_403_1 < arg_400_1.time_ and arg_400_1.time_ <= var_403_1 + arg_403_0 then
				arg_400_1.var_.moveOldPos1097ui_story = var_403_0.localPosition
			end

			local var_403_2 = 0.001

			if var_403_1 <= arg_400_1.time_ and arg_400_1.time_ < var_403_1 + var_403_2 then
				local var_403_3 = (arg_400_1.time_ - var_403_1) / var_403_2
				local var_403_4 = Vector3.New(-0.7, -0.54, -6.3)

				var_403_0.localPosition = Vector3.Lerp(arg_400_1.var_.moveOldPos1097ui_story, var_403_4, var_403_3)

				local var_403_5 = manager.ui.mainCamera.transform.position - var_403_0.position

				var_403_0.forward = Vector3.New(var_403_5.x, var_403_5.y, var_403_5.z)

				local var_403_6 = var_403_0.localEulerAngles

				var_403_6.z = 0
				var_403_6.x = 0
				var_403_0.localEulerAngles = var_403_6
			end

			if arg_400_1.time_ >= var_403_1 + var_403_2 and arg_400_1.time_ < var_403_1 + var_403_2 + arg_403_0 then
				var_403_0.localPosition = Vector3.New(-0.7, -0.54, -6.3)

				local var_403_7 = manager.ui.mainCamera.transform.position - var_403_0.position

				var_403_0.forward = Vector3.New(var_403_7.x, var_403_7.y, var_403_7.z)

				local var_403_8 = var_403_0.localEulerAngles

				var_403_8.z = 0
				var_403_8.x = 0
				var_403_0.localEulerAngles = var_403_8
			end

			local var_403_9 = arg_400_1.actors_["1097ui_story"]
			local var_403_10 = 0

			if var_403_10 < arg_400_1.time_ and arg_400_1.time_ <= var_403_10 + arg_403_0 and not isNil(var_403_9) and arg_400_1.var_.characterEffect1097ui_story == nil then
				arg_400_1.var_.characterEffect1097ui_story = var_403_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_403_11 = 0.200000002980232

			if var_403_10 <= arg_400_1.time_ and arg_400_1.time_ < var_403_10 + var_403_11 and not isNil(var_403_9) then
				local var_403_12 = (arg_400_1.time_ - var_403_10) / var_403_11

				if arg_400_1.var_.characterEffect1097ui_story and not isNil(var_403_9) then
					local var_403_13 = Mathf.Lerp(0, 0.5, var_403_12)

					arg_400_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_400_1.var_.characterEffect1097ui_story.fillRatio = var_403_13
				end
			end

			if arg_400_1.time_ >= var_403_10 + var_403_11 and arg_400_1.time_ < var_403_10 + var_403_11 + arg_403_0 and not isNil(var_403_9) and arg_400_1.var_.characterEffect1097ui_story then
				local var_403_14 = 0.5

				arg_400_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_400_1.var_.characterEffect1097ui_story.fillRatio = var_403_14
			end

			local var_403_15 = arg_400_1.actors_["1042ui_story"].transform
			local var_403_16 = 0

			if var_403_16 < arg_400_1.time_ and arg_400_1.time_ <= var_403_16 + arg_403_0 then
				arg_400_1.var_.moveOldPos1042ui_story = var_403_15.localPosition
			end

			local var_403_17 = 0.001

			if var_403_16 <= arg_400_1.time_ and arg_400_1.time_ < var_403_16 + var_403_17 then
				local var_403_18 = (arg_400_1.time_ - var_403_16) / var_403_17
				local var_403_19 = Vector3.New(0.7, -1.06, -6.2)

				var_403_15.localPosition = Vector3.Lerp(arg_400_1.var_.moveOldPos1042ui_story, var_403_19, var_403_18)

				local var_403_20 = manager.ui.mainCamera.transform.position - var_403_15.position

				var_403_15.forward = Vector3.New(var_403_20.x, var_403_20.y, var_403_20.z)

				local var_403_21 = var_403_15.localEulerAngles

				var_403_21.z = 0
				var_403_21.x = 0
				var_403_15.localEulerAngles = var_403_21
			end

			if arg_400_1.time_ >= var_403_16 + var_403_17 and arg_400_1.time_ < var_403_16 + var_403_17 + arg_403_0 then
				var_403_15.localPosition = Vector3.New(0.7, -1.06, -6.2)

				local var_403_22 = manager.ui.mainCamera.transform.position - var_403_15.position

				var_403_15.forward = Vector3.New(var_403_22.x, var_403_22.y, var_403_22.z)

				local var_403_23 = var_403_15.localEulerAngles

				var_403_23.z = 0
				var_403_23.x = 0
				var_403_15.localEulerAngles = var_403_23
			end

			local var_403_24 = arg_400_1.actors_["1042ui_story"]
			local var_403_25 = 0

			if var_403_25 < arg_400_1.time_ and arg_400_1.time_ <= var_403_25 + arg_403_0 and not isNil(var_403_24) and arg_400_1.var_.characterEffect1042ui_story == nil then
				arg_400_1.var_.characterEffect1042ui_story = var_403_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_403_26 = 0.200000002980232

			if var_403_25 <= arg_400_1.time_ and arg_400_1.time_ < var_403_25 + var_403_26 and not isNil(var_403_24) then
				local var_403_27 = (arg_400_1.time_ - var_403_25) / var_403_26

				if arg_400_1.var_.characterEffect1042ui_story and not isNil(var_403_24) then
					arg_400_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_400_1.time_ >= var_403_25 + var_403_26 and arg_400_1.time_ < var_403_25 + var_403_26 + arg_403_0 and not isNil(var_403_24) and arg_400_1.var_.characterEffect1042ui_story then
				arg_400_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_403_28 = 0

			if var_403_28 < arg_400_1.time_ and arg_400_1.time_ <= var_403_28 + arg_403_0 then
				arg_400_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action1_1")
			end

			local var_403_29 = 0

			if var_403_29 < arg_400_1.time_ and arg_400_1.time_ <= var_403_29 + arg_403_0 then
				arg_400_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_403_30 = 0
			local var_403_31 = 0.525

			if var_403_30 < arg_400_1.time_ and arg_400_1.time_ <= var_403_30 + arg_403_0 then
				arg_400_1.talkMaxDuration = 0
				arg_400_1.dialogCg_.alpha = 1

				arg_400_1.dialog_:SetActive(true)
				SetActive(arg_400_1.leftNameGo_, true)

				local var_403_32 = arg_400_1:FormatText(StoryNameCfg[205].name)

				arg_400_1.leftNameTxt_.text = var_403_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_400_1.leftNameTxt_.transform)

				arg_400_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_400_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_400_1:RecordName(arg_400_1.leftNameTxt_.text)
				SetActive(arg_400_1.iconTrs_.gameObject, false)
				arg_400_1.callingController_:SetSelectedState("normal")

				local var_403_33 = arg_400_1:GetWordFromCfg(1109701098)
				local var_403_34 = arg_400_1:FormatText(var_403_33.content)

				arg_400_1.text_.text = var_403_34

				LuaForUtil.ClearLinePrefixSymbol(arg_400_1.text_)

				local var_403_35 = 21
				local var_403_36 = utf8.len(var_403_34)
				local var_403_37 = var_403_35 <= 0 and var_403_31 or var_403_31 * (var_403_36 / var_403_35)

				if var_403_37 > 0 and var_403_31 < var_403_37 then
					arg_400_1.talkMaxDuration = var_403_37

					if var_403_37 + var_403_30 > arg_400_1.duration_ then
						arg_400_1.duration_ = var_403_37 + var_403_30
					end
				end

				arg_400_1.text_.text = var_403_34
				arg_400_1.typewritter.percent = 0

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701098", "story_v_side_new_1109701.awb") ~= 0 then
					local var_403_38 = manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701098", "story_v_side_new_1109701.awb") / 1000

					if var_403_38 + var_403_30 > arg_400_1.duration_ then
						arg_400_1.duration_ = var_403_38 + var_403_30
					end

					if var_403_33.prefab_name ~= "" and arg_400_1.actors_[var_403_33.prefab_name] ~= nil then
						local var_403_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_400_1.actors_[var_403_33.prefab_name].transform, "story_v_side_new_1109701", "1109701098", "story_v_side_new_1109701.awb")

						arg_400_1:RecordAudio("1109701098", var_403_39)
						arg_400_1:RecordAudio("1109701098", var_403_39)
					else
						arg_400_1:AudioAction("play", "voice", "story_v_side_new_1109701", "1109701098", "story_v_side_new_1109701.awb")
					end

					arg_400_1:RecordHistoryTalkVoice("story_v_side_new_1109701", "1109701098", "story_v_side_new_1109701.awb")
				end

				arg_400_1:RecordContent(arg_400_1.text_.text)
			end

			local var_403_40 = math.max(var_403_31, arg_400_1.talkMaxDuration)

			if var_403_30 <= arg_400_1.time_ and arg_400_1.time_ < var_403_30 + var_403_40 then
				arg_400_1.typewritter.percent = (arg_400_1.time_ - var_403_30) / var_403_40

				arg_400_1.typewritter:SetDirty()
			end

			if arg_400_1.time_ >= var_403_30 + var_403_40 and arg_400_1.time_ < var_403_30 + var_403_40 + arg_403_0 then
				arg_400_1.typewritter.percent = 1

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(true)
			end
		end

		arg_400_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_400_1:InitPlayNodeList()
	end,
	Play1109701099 = function(arg_404_0, arg_404_1)
		arg_404_1.time_ = 0
		arg_404_1.frameCnt_ = 0
		arg_404_1.state_ = "playing"
		arg_404_1.curTalkId_ = 1109701099
		arg_404_1.duration_ = 2

		SetActive(arg_404_1.tipsGo_, false)

		function arg_404_1.onSingleLineFinish_()
			arg_404_1.onSingleLineUpdate_ = nil
			arg_404_1.onSingleLineFinish_ = nil
			arg_404_1.state_ = "waiting"
		end

		function arg_404_1.playNext_(arg_406_0)
			if arg_406_0 == 1 then
				arg_404_0:Play1109701100(arg_404_1)
			end
		end

		function arg_404_1.onSingleLineUpdate_(arg_407_0)
			local var_407_0 = arg_404_1.actors_["1097ui_story"].transform
			local var_407_1 = 0

			if var_407_1 < arg_404_1.time_ and arg_404_1.time_ <= var_407_1 + arg_407_0 then
				arg_404_1.var_.moveOldPos1097ui_story = var_407_0.localPosition
			end

			local var_407_2 = 0.001

			if var_407_1 <= arg_404_1.time_ and arg_404_1.time_ < var_407_1 + var_407_2 then
				local var_407_3 = (arg_404_1.time_ - var_407_1) / var_407_2
				local var_407_4 = Vector3.New(-0.7, -0.54, -6.3)

				var_407_0.localPosition = Vector3.Lerp(arg_404_1.var_.moveOldPos1097ui_story, var_407_4, var_407_3)

				local var_407_5 = manager.ui.mainCamera.transform.position - var_407_0.position

				var_407_0.forward = Vector3.New(var_407_5.x, var_407_5.y, var_407_5.z)

				local var_407_6 = var_407_0.localEulerAngles

				var_407_6.z = 0
				var_407_6.x = 0
				var_407_0.localEulerAngles = var_407_6
			end

			if arg_404_1.time_ >= var_407_1 + var_407_2 and arg_404_1.time_ < var_407_1 + var_407_2 + arg_407_0 then
				var_407_0.localPosition = Vector3.New(-0.7, -0.54, -6.3)

				local var_407_7 = manager.ui.mainCamera.transform.position - var_407_0.position

				var_407_0.forward = Vector3.New(var_407_7.x, var_407_7.y, var_407_7.z)

				local var_407_8 = var_407_0.localEulerAngles

				var_407_8.z = 0
				var_407_8.x = 0
				var_407_0.localEulerAngles = var_407_8
			end

			local var_407_9 = arg_404_1.actors_["1097ui_story"]
			local var_407_10 = 0

			if var_407_10 < arg_404_1.time_ and arg_404_1.time_ <= var_407_10 + arg_407_0 and not isNil(var_407_9) and arg_404_1.var_.characterEffect1097ui_story == nil then
				arg_404_1.var_.characterEffect1097ui_story = var_407_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_407_11 = 0.200000002980232

			if var_407_10 <= arg_404_1.time_ and arg_404_1.time_ < var_407_10 + var_407_11 and not isNil(var_407_9) then
				local var_407_12 = (arg_404_1.time_ - var_407_10) / var_407_11

				if arg_404_1.var_.characterEffect1097ui_story and not isNil(var_407_9) then
					arg_404_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_404_1.time_ >= var_407_10 + var_407_11 and arg_404_1.time_ < var_407_10 + var_407_11 + arg_407_0 and not isNil(var_407_9) and arg_404_1.var_.characterEffect1097ui_story then
				arg_404_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_407_13 = 0

			if var_407_13 < arg_404_1.time_ and arg_404_1.time_ <= var_407_13 + arg_407_0 then
				arg_404_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action7_2")
			end

			local var_407_14 = 0

			if var_407_14 < arg_404_1.time_ and arg_404_1.time_ <= var_407_14 + arg_407_0 then
				arg_404_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_407_15 = arg_404_1.actors_["1042ui_story"]
			local var_407_16 = 0

			if var_407_16 < arg_404_1.time_ and arg_404_1.time_ <= var_407_16 + arg_407_0 and not isNil(var_407_15) and arg_404_1.var_.characterEffect1042ui_story == nil then
				arg_404_1.var_.characterEffect1042ui_story = var_407_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_407_17 = 0.200000002980232

			if var_407_16 <= arg_404_1.time_ and arg_404_1.time_ < var_407_16 + var_407_17 and not isNil(var_407_15) then
				local var_407_18 = (arg_404_1.time_ - var_407_16) / var_407_17

				if arg_404_1.var_.characterEffect1042ui_story and not isNil(var_407_15) then
					local var_407_19 = Mathf.Lerp(0, 0.5, var_407_18)

					arg_404_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_404_1.var_.characterEffect1042ui_story.fillRatio = var_407_19
				end
			end

			if arg_404_1.time_ >= var_407_16 + var_407_17 and arg_404_1.time_ < var_407_16 + var_407_17 + arg_407_0 and not isNil(var_407_15) and arg_404_1.var_.characterEffect1042ui_story then
				local var_407_20 = 0.5

				arg_404_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_404_1.var_.characterEffect1042ui_story.fillRatio = var_407_20
			end

			local var_407_21 = 0
			local var_407_22 = 0.05

			if var_407_21 < arg_404_1.time_ and arg_404_1.time_ <= var_407_21 + arg_407_0 then
				arg_404_1.talkMaxDuration = 0
				arg_404_1.dialogCg_.alpha = 1

				arg_404_1.dialog_:SetActive(true)
				SetActive(arg_404_1.leftNameGo_, true)

				local var_407_23 = arg_404_1:FormatText(StoryNameCfg[216].name)

				arg_404_1.leftNameTxt_.text = var_407_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_404_1.leftNameTxt_.transform)

				arg_404_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_404_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_404_1:RecordName(arg_404_1.leftNameTxt_.text)
				SetActive(arg_404_1.iconTrs_.gameObject, false)
				arg_404_1.callingController_:SetSelectedState("normal")

				local var_407_24 = arg_404_1:GetWordFromCfg(1109701099)
				local var_407_25 = arg_404_1:FormatText(var_407_24.content)

				arg_404_1.text_.text = var_407_25

				LuaForUtil.ClearLinePrefixSymbol(arg_404_1.text_)

				local var_407_26 = 2
				local var_407_27 = utf8.len(var_407_25)
				local var_407_28 = var_407_26 <= 0 and var_407_22 or var_407_22 * (var_407_27 / var_407_26)

				if var_407_28 > 0 and var_407_22 < var_407_28 then
					arg_404_1.talkMaxDuration = var_407_28

					if var_407_28 + var_407_21 > arg_404_1.duration_ then
						arg_404_1.duration_ = var_407_28 + var_407_21
					end
				end

				arg_404_1.text_.text = var_407_25
				arg_404_1.typewritter.percent = 0

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701099", "story_v_side_new_1109701.awb") ~= 0 then
					local var_407_29 = manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701099", "story_v_side_new_1109701.awb") / 1000

					if var_407_29 + var_407_21 > arg_404_1.duration_ then
						arg_404_1.duration_ = var_407_29 + var_407_21
					end

					if var_407_24.prefab_name ~= "" and arg_404_1.actors_[var_407_24.prefab_name] ~= nil then
						local var_407_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_404_1.actors_[var_407_24.prefab_name].transform, "story_v_side_new_1109701", "1109701099", "story_v_side_new_1109701.awb")

						arg_404_1:RecordAudio("1109701099", var_407_30)
						arg_404_1:RecordAudio("1109701099", var_407_30)
					else
						arg_404_1:AudioAction("play", "voice", "story_v_side_new_1109701", "1109701099", "story_v_side_new_1109701.awb")
					end

					arg_404_1:RecordHistoryTalkVoice("story_v_side_new_1109701", "1109701099", "story_v_side_new_1109701.awb")
				end

				arg_404_1:RecordContent(arg_404_1.text_.text)
			end

			local var_407_31 = math.max(var_407_22, arg_404_1.talkMaxDuration)

			if var_407_21 <= arg_404_1.time_ and arg_404_1.time_ < var_407_21 + var_407_31 then
				arg_404_1.typewritter.percent = (arg_404_1.time_ - var_407_21) / var_407_31

				arg_404_1.typewritter:SetDirty()
			end

			if arg_404_1.time_ >= var_407_21 + var_407_31 and arg_404_1.time_ < var_407_21 + var_407_31 + arg_407_0 then
				arg_404_1.typewritter.percent = 1

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(true)
			end
		end

		arg_404_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_404_1:InitPlayNodeList()
	end,
	Play1109701100 = function(arg_408_0, arg_408_1)
		arg_408_1.time_ = 0
		arg_408_1.frameCnt_ = 0
		arg_408_1.state_ = "playing"
		arg_408_1.curTalkId_ = 1109701100
		arg_408_1.duration_ = 5

		SetActive(arg_408_1.tipsGo_, false)

		function arg_408_1.onSingleLineFinish_()
			arg_408_1.onSingleLineUpdate_ = nil
			arg_408_1.onSingleLineFinish_ = nil
			arg_408_1.state_ = "waiting"
		end

		function arg_408_1.playNext_(arg_410_0)
			if arg_410_0 == 1 then
				arg_408_0:Play1109701101(arg_408_1)
			end
		end

		function arg_408_1.onSingleLineUpdate_(arg_411_0)
			local var_411_0 = arg_408_1.actors_["1097ui_story"]
			local var_411_1 = 0

			if var_411_1 < arg_408_1.time_ and arg_408_1.time_ <= var_411_1 + arg_411_0 and not isNil(var_411_0) and arg_408_1.var_.characterEffect1097ui_story == nil then
				arg_408_1.var_.characterEffect1097ui_story = var_411_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_411_2 = 0.200000002980232

			if var_411_1 <= arg_408_1.time_ and arg_408_1.time_ < var_411_1 + var_411_2 and not isNil(var_411_0) then
				local var_411_3 = (arg_408_1.time_ - var_411_1) / var_411_2

				if arg_408_1.var_.characterEffect1097ui_story and not isNil(var_411_0) then
					local var_411_4 = Mathf.Lerp(0, 0.5, var_411_3)

					arg_408_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_408_1.var_.characterEffect1097ui_story.fillRatio = var_411_4
				end
			end

			if arg_408_1.time_ >= var_411_1 + var_411_2 and arg_408_1.time_ < var_411_1 + var_411_2 + arg_411_0 and not isNil(var_411_0) and arg_408_1.var_.characterEffect1097ui_story then
				local var_411_5 = 0.5

				arg_408_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_408_1.var_.characterEffect1097ui_story.fillRatio = var_411_5
			end

			local var_411_6 = 0
			local var_411_7 = 0.475

			if var_411_6 < arg_408_1.time_ and arg_408_1.time_ <= var_411_6 + arg_411_0 then
				arg_408_1.talkMaxDuration = 0
				arg_408_1.dialogCg_.alpha = 1

				arg_408_1.dialog_:SetActive(true)
				SetActive(arg_408_1.leftNameGo_, false)

				arg_408_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_408_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_408_1:RecordName(arg_408_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_408_1.iconTrs_.gameObject, false)
				arg_408_1.callingController_:SetSelectedState("normal")

				local var_411_8 = arg_408_1:GetWordFromCfg(1109701100)
				local var_411_9 = arg_408_1:FormatText(var_411_8.content)

				arg_408_1.text_.text = var_411_9

				LuaForUtil.ClearLinePrefixSymbol(arg_408_1.text_)

				local var_411_10 = 19
				local var_411_11 = utf8.len(var_411_9)
				local var_411_12 = var_411_10 <= 0 and var_411_7 or var_411_7 * (var_411_11 / var_411_10)

				if var_411_12 > 0 and var_411_7 < var_411_12 then
					arg_408_1.talkMaxDuration = var_411_12

					if var_411_12 + var_411_6 > arg_408_1.duration_ then
						arg_408_1.duration_ = var_411_12 + var_411_6
					end
				end

				arg_408_1.text_.text = var_411_9
				arg_408_1.typewritter.percent = 0

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(false)
				arg_408_1:RecordContent(arg_408_1.text_.text)
			end

			local var_411_13 = math.max(var_411_7, arg_408_1.talkMaxDuration)

			if var_411_6 <= arg_408_1.time_ and arg_408_1.time_ < var_411_6 + var_411_13 then
				arg_408_1.typewritter.percent = (arg_408_1.time_ - var_411_6) / var_411_13

				arg_408_1.typewritter:SetDirty()
			end

			if arg_408_1.time_ >= var_411_6 + var_411_13 and arg_408_1.time_ < var_411_6 + var_411_13 + arg_411_0 then
				arg_408_1.typewritter.percent = 1

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(true)
			end
		end

		arg_408_1.nodeConfigList_ = {}

		arg_408_1:InitPlayNodeList()
	end,
	Play1109701101 = function(arg_412_0, arg_412_1)
		arg_412_1.time_ = 0
		arg_412_1.frameCnt_ = 0
		arg_412_1.state_ = "playing"
		arg_412_1.curTalkId_ = 1109701101
		arg_412_1.duration_ = 5

		SetActive(arg_412_1.tipsGo_, false)

		function arg_412_1.onSingleLineFinish_()
			arg_412_1.onSingleLineUpdate_ = nil
			arg_412_1.onSingleLineFinish_ = nil
			arg_412_1.state_ = "waiting"
		end

		function arg_412_1.playNext_(arg_414_0)
			if arg_414_0 == 1 then
				arg_412_0:Play1109701102(arg_412_1)
			end
		end

		function arg_412_1.onSingleLineUpdate_(arg_415_0)
			local var_415_0 = 0
			local var_415_1 = 0.95

			if var_415_0 < arg_412_1.time_ and arg_412_1.time_ <= var_415_0 + arg_415_0 then
				arg_412_1.talkMaxDuration = 0
				arg_412_1.dialogCg_.alpha = 1

				arg_412_1.dialog_:SetActive(true)
				SetActive(arg_412_1.leftNameGo_, true)

				local var_415_2 = arg_412_1:FormatText(StoryNameCfg[7].name)

				arg_412_1.leftNameTxt_.text = var_415_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_412_1.leftNameTxt_.transform)

				arg_412_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_412_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_412_1:RecordName(arg_412_1.leftNameTxt_.text)
				SetActive(arg_412_1.iconTrs_.gameObject, true)
				arg_412_1.iconController_:SetSelectedState("hero")

				arg_412_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_412_1.callingController_:SetSelectedState("normal")

				arg_412_1.keyicon_.color = Color.New(1, 1, 1)
				arg_412_1.icon_.color = Color.New(1, 1, 1)

				local var_415_3 = arg_412_1:GetWordFromCfg(1109701101)
				local var_415_4 = arg_412_1:FormatText(var_415_3.content)

				arg_412_1.text_.text = var_415_4

				LuaForUtil.ClearLinePrefixSymbol(arg_412_1.text_)

				local var_415_5 = 38
				local var_415_6 = utf8.len(var_415_4)
				local var_415_7 = var_415_5 <= 0 and var_415_1 or var_415_1 * (var_415_6 / var_415_5)

				if var_415_7 > 0 and var_415_1 < var_415_7 then
					arg_412_1.talkMaxDuration = var_415_7

					if var_415_7 + var_415_0 > arg_412_1.duration_ then
						arg_412_1.duration_ = var_415_7 + var_415_0
					end
				end

				arg_412_1.text_.text = var_415_4
				arg_412_1.typewritter.percent = 0

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(false)
				arg_412_1:RecordContent(arg_412_1.text_.text)
			end

			local var_415_8 = math.max(var_415_1, arg_412_1.talkMaxDuration)

			if var_415_0 <= arg_412_1.time_ and arg_412_1.time_ < var_415_0 + var_415_8 then
				arg_412_1.typewritter.percent = (arg_412_1.time_ - var_415_0) / var_415_8

				arg_412_1.typewritter:SetDirty()
			end

			if arg_412_1.time_ >= var_415_0 + var_415_8 and arg_412_1.time_ < var_415_0 + var_415_8 + arg_415_0 then
				arg_412_1.typewritter.percent = 1

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(true)
			end
		end

		arg_412_1.nodeConfigList_ = {}

		arg_412_1:InitPlayNodeList()
	end,
	Play1109701102 = function(arg_416_0, arg_416_1)
		arg_416_1.time_ = 0
		arg_416_1.frameCnt_ = 0
		arg_416_1.state_ = "playing"
		arg_416_1.curTalkId_ = 1109701102
		arg_416_1.duration_ = 5

		SetActive(arg_416_1.tipsGo_, false)

		function arg_416_1.onSingleLineFinish_()
			arg_416_1.onSingleLineUpdate_ = nil
			arg_416_1.onSingleLineFinish_ = nil
			arg_416_1.state_ = "waiting"
		end

		function arg_416_1.playNext_(arg_418_0)
			if arg_418_0 == 1 then
				arg_416_0:Play1109701103(arg_416_1)
			end
		end

		function arg_416_1.onSingleLineUpdate_(arg_419_0)
			local var_419_0 = 0
			local var_419_1 = 0.7

			if var_419_0 < arg_416_1.time_ and arg_416_1.time_ <= var_419_0 + arg_419_0 then
				arg_416_1.talkMaxDuration = 0
				arg_416_1.dialogCg_.alpha = 1

				arg_416_1.dialog_:SetActive(true)
				SetActive(arg_416_1.leftNameGo_, true)

				local var_419_2 = arg_416_1:FormatText(StoryNameCfg[7].name)

				arg_416_1.leftNameTxt_.text = var_419_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_416_1.leftNameTxt_.transform)

				arg_416_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_416_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_416_1:RecordName(arg_416_1.leftNameTxt_.text)
				SetActive(arg_416_1.iconTrs_.gameObject, true)
				arg_416_1.iconController_:SetSelectedState("hero")

				arg_416_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_416_1.callingController_:SetSelectedState("normal")

				arg_416_1.keyicon_.color = Color.New(1, 1, 1)
				arg_416_1.icon_.color = Color.New(1, 1, 1)

				local var_419_3 = arg_416_1:GetWordFromCfg(1109701102)
				local var_419_4 = arg_416_1:FormatText(var_419_3.content)

				arg_416_1.text_.text = var_419_4

				LuaForUtil.ClearLinePrefixSymbol(arg_416_1.text_)

				local var_419_5 = 28
				local var_419_6 = utf8.len(var_419_4)
				local var_419_7 = var_419_5 <= 0 and var_419_1 or var_419_1 * (var_419_6 / var_419_5)

				if var_419_7 > 0 and var_419_1 < var_419_7 then
					arg_416_1.talkMaxDuration = var_419_7

					if var_419_7 + var_419_0 > arg_416_1.duration_ then
						arg_416_1.duration_ = var_419_7 + var_419_0
					end
				end

				arg_416_1.text_.text = var_419_4
				arg_416_1.typewritter.percent = 0

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(false)
				arg_416_1:RecordContent(arg_416_1.text_.text)
			end

			local var_419_8 = math.max(var_419_1, arg_416_1.talkMaxDuration)

			if var_419_0 <= arg_416_1.time_ and arg_416_1.time_ < var_419_0 + var_419_8 then
				arg_416_1.typewritter.percent = (arg_416_1.time_ - var_419_0) / var_419_8

				arg_416_1.typewritter:SetDirty()
			end

			if arg_416_1.time_ >= var_419_0 + var_419_8 and arg_416_1.time_ < var_419_0 + var_419_8 + arg_419_0 then
				arg_416_1.typewritter.percent = 1

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(true)
			end
		end

		arg_416_1.nodeConfigList_ = {}

		arg_416_1:InitPlayNodeList()
	end,
	Play1109701103 = function(arg_420_0, arg_420_1)
		arg_420_1.time_ = 0
		arg_420_1.frameCnt_ = 0
		arg_420_1.state_ = "playing"
		arg_420_1.curTalkId_ = 1109701103
		arg_420_1.duration_ = 4.57

		local var_420_0 = {
			zh = 4.566,
			ja = 3.833
		}
		local var_420_1 = manager.audio:GetLocalizationFlag()

		if var_420_0[var_420_1] ~= nil then
			arg_420_1.duration_ = var_420_0[var_420_1]
		end

		SetActive(arg_420_1.tipsGo_, false)

		function arg_420_1.onSingleLineFinish_()
			arg_420_1.onSingleLineUpdate_ = nil
			arg_420_1.onSingleLineFinish_ = nil
			arg_420_1.state_ = "waiting"
		end

		function arg_420_1.playNext_(arg_422_0)
			if arg_422_0 == 1 then
				arg_420_0:Play1109701104(arg_420_1)
			end
		end

		function arg_420_1.onSingleLineUpdate_(arg_423_0)
			local var_423_0 = arg_420_1.actors_["1097ui_story"]
			local var_423_1 = 0

			if var_423_1 < arg_420_1.time_ and arg_420_1.time_ <= var_423_1 + arg_423_0 and not isNil(var_423_0) and arg_420_1.var_.characterEffect1097ui_story == nil then
				arg_420_1.var_.characterEffect1097ui_story = var_423_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_423_2 = 0.200000002980232

			if var_423_1 <= arg_420_1.time_ and arg_420_1.time_ < var_423_1 + var_423_2 and not isNil(var_423_0) then
				local var_423_3 = (arg_420_1.time_ - var_423_1) / var_423_2

				if arg_420_1.var_.characterEffect1097ui_story and not isNil(var_423_0) then
					arg_420_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_420_1.time_ >= var_423_1 + var_423_2 and arg_420_1.time_ < var_423_1 + var_423_2 + arg_423_0 and not isNil(var_423_0) and arg_420_1.var_.characterEffect1097ui_story then
				arg_420_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_423_4 = 0

			if var_423_4 < arg_420_1.time_ and arg_420_1.time_ <= var_423_4 + arg_423_0 then
				arg_420_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			local var_423_5 = 0

			if var_423_5 < arg_420_1.time_ and arg_420_1.time_ <= var_423_5 + arg_423_0 then
				arg_420_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_423_6 = 0
			local var_423_7 = 0.35

			if var_423_6 < arg_420_1.time_ and arg_420_1.time_ <= var_423_6 + arg_423_0 then
				arg_420_1.talkMaxDuration = 0
				arg_420_1.dialogCg_.alpha = 1

				arg_420_1.dialog_:SetActive(true)
				SetActive(arg_420_1.leftNameGo_, true)

				local var_423_8 = arg_420_1:FormatText(StoryNameCfg[216].name)

				arg_420_1.leftNameTxt_.text = var_423_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_420_1.leftNameTxt_.transform)

				arg_420_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_420_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_420_1:RecordName(arg_420_1.leftNameTxt_.text)
				SetActive(arg_420_1.iconTrs_.gameObject, false)
				arg_420_1.callingController_:SetSelectedState("normal")

				local var_423_9 = arg_420_1:GetWordFromCfg(1109701103)
				local var_423_10 = arg_420_1:FormatText(var_423_9.content)

				arg_420_1.text_.text = var_423_10

				LuaForUtil.ClearLinePrefixSymbol(arg_420_1.text_)

				local var_423_11 = 14
				local var_423_12 = utf8.len(var_423_10)
				local var_423_13 = var_423_11 <= 0 and var_423_7 or var_423_7 * (var_423_12 / var_423_11)

				if var_423_13 > 0 and var_423_7 < var_423_13 then
					arg_420_1.talkMaxDuration = var_423_13

					if var_423_13 + var_423_6 > arg_420_1.duration_ then
						arg_420_1.duration_ = var_423_13 + var_423_6
					end
				end

				arg_420_1.text_.text = var_423_10
				arg_420_1.typewritter.percent = 0

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701103", "story_v_side_new_1109701.awb") ~= 0 then
					local var_423_14 = manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701103", "story_v_side_new_1109701.awb") / 1000

					if var_423_14 + var_423_6 > arg_420_1.duration_ then
						arg_420_1.duration_ = var_423_14 + var_423_6
					end

					if var_423_9.prefab_name ~= "" and arg_420_1.actors_[var_423_9.prefab_name] ~= nil then
						local var_423_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_420_1.actors_[var_423_9.prefab_name].transform, "story_v_side_new_1109701", "1109701103", "story_v_side_new_1109701.awb")

						arg_420_1:RecordAudio("1109701103", var_423_15)
						arg_420_1:RecordAudio("1109701103", var_423_15)
					else
						arg_420_1:AudioAction("play", "voice", "story_v_side_new_1109701", "1109701103", "story_v_side_new_1109701.awb")
					end

					arg_420_1:RecordHistoryTalkVoice("story_v_side_new_1109701", "1109701103", "story_v_side_new_1109701.awb")
				end

				arg_420_1:RecordContent(arg_420_1.text_.text)
			end

			local var_423_16 = math.max(var_423_7, arg_420_1.talkMaxDuration)

			if var_423_6 <= arg_420_1.time_ and arg_420_1.time_ < var_423_6 + var_423_16 then
				arg_420_1.typewritter.percent = (arg_420_1.time_ - var_423_6) / var_423_16

				arg_420_1.typewritter:SetDirty()
			end

			if arg_420_1.time_ >= var_423_6 + var_423_16 and arg_420_1.time_ < var_423_6 + var_423_16 + arg_423_0 then
				arg_420_1.typewritter.percent = 1

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(true)
			end
		end

		arg_420_1.nodeConfigList_ = {}

		arg_420_1:InitPlayNodeList()
	end,
	Play1109701104 = function(arg_424_0, arg_424_1)
		arg_424_1.time_ = 0
		arg_424_1.frameCnt_ = 0
		arg_424_1.state_ = "playing"
		arg_424_1.curTalkId_ = 1109701104
		arg_424_1.duration_ = 5

		SetActive(arg_424_1.tipsGo_, false)

		function arg_424_1.onSingleLineFinish_()
			arg_424_1.onSingleLineUpdate_ = nil
			arg_424_1.onSingleLineFinish_ = nil
			arg_424_1.state_ = "waiting"
		end

		function arg_424_1.playNext_(arg_426_0)
			if arg_426_0 == 1 then
				arg_424_0:Play1109701105(arg_424_1)
			end
		end

		function arg_424_1.onSingleLineUpdate_(arg_427_0)
			local var_427_0 = arg_424_1.actors_["1097ui_story"]
			local var_427_1 = 0

			if var_427_1 < arg_424_1.time_ and arg_424_1.time_ <= var_427_1 + arg_427_0 and not isNil(var_427_0) and arg_424_1.var_.characterEffect1097ui_story == nil then
				arg_424_1.var_.characterEffect1097ui_story = var_427_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_427_2 = 0.200000002980232

			if var_427_1 <= arg_424_1.time_ and arg_424_1.time_ < var_427_1 + var_427_2 and not isNil(var_427_0) then
				local var_427_3 = (arg_424_1.time_ - var_427_1) / var_427_2

				if arg_424_1.var_.characterEffect1097ui_story and not isNil(var_427_0) then
					local var_427_4 = Mathf.Lerp(0, 0.5, var_427_3)

					arg_424_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_424_1.var_.characterEffect1097ui_story.fillRatio = var_427_4
				end
			end

			if arg_424_1.time_ >= var_427_1 + var_427_2 and arg_424_1.time_ < var_427_1 + var_427_2 + arg_427_0 and not isNil(var_427_0) and arg_424_1.var_.characterEffect1097ui_story then
				local var_427_5 = 0.5

				arg_424_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_424_1.var_.characterEffect1097ui_story.fillRatio = var_427_5
			end

			local var_427_6 = 0
			local var_427_7 = 0.325

			if var_427_6 < arg_424_1.time_ and arg_424_1.time_ <= var_427_6 + arg_427_0 then
				arg_424_1.talkMaxDuration = 0
				arg_424_1.dialogCg_.alpha = 1

				arg_424_1.dialog_:SetActive(true)
				SetActive(arg_424_1.leftNameGo_, true)

				local var_427_8 = arg_424_1:FormatText(StoryNameCfg[7].name)

				arg_424_1.leftNameTxt_.text = var_427_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_424_1.leftNameTxt_.transform)

				arg_424_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_424_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_424_1:RecordName(arg_424_1.leftNameTxt_.text)
				SetActive(arg_424_1.iconTrs_.gameObject, true)
				arg_424_1.iconController_:SetSelectedState("hero")

				arg_424_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_424_1.callingController_:SetSelectedState("normal")

				arg_424_1.keyicon_.color = Color.New(1, 1, 1)
				arg_424_1.icon_.color = Color.New(1, 1, 1)

				local var_427_9 = arg_424_1:GetWordFromCfg(1109701104)
				local var_427_10 = arg_424_1:FormatText(var_427_9.content)

				arg_424_1.text_.text = var_427_10

				LuaForUtil.ClearLinePrefixSymbol(arg_424_1.text_)

				local var_427_11 = 13
				local var_427_12 = utf8.len(var_427_10)
				local var_427_13 = var_427_11 <= 0 and var_427_7 or var_427_7 * (var_427_12 / var_427_11)

				if var_427_13 > 0 and var_427_7 < var_427_13 then
					arg_424_1.talkMaxDuration = var_427_13

					if var_427_13 + var_427_6 > arg_424_1.duration_ then
						arg_424_1.duration_ = var_427_13 + var_427_6
					end
				end

				arg_424_1.text_.text = var_427_10
				arg_424_1.typewritter.percent = 0

				arg_424_1.typewritter:SetDirty()
				arg_424_1:ShowNextGo(false)
				arg_424_1:RecordContent(arg_424_1.text_.text)
			end

			local var_427_14 = math.max(var_427_7, arg_424_1.talkMaxDuration)

			if var_427_6 <= arg_424_1.time_ and arg_424_1.time_ < var_427_6 + var_427_14 then
				arg_424_1.typewritter.percent = (arg_424_1.time_ - var_427_6) / var_427_14

				arg_424_1.typewritter:SetDirty()
			end

			if arg_424_1.time_ >= var_427_6 + var_427_14 and arg_424_1.time_ < var_427_6 + var_427_14 + arg_427_0 then
				arg_424_1.typewritter.percent = 1

				arg_424_1.typewritter:SetDirty()
				arg_424_1:ShowNextGo(true)
			end
		end

		arg_424_1.nodeConfigList_ = {}

		arg_424_1:InitPlayNodeList()
	end,
	Play1109701105 = function(arg_428_0, arg_428_1)
		arg_428_1.time_ = 0
		arg_428_1.frameCnt_ = 0
		arg_428_1.state_ = "playing"
		arg_428_1.curTalkId_ = 1109701105
		arg_428_1.duration_ = 5

		SetActive(arg_428_1.tipsGo_, false)

		function arg_428_1.onSingleLineFinish_()
			arg_428_1.onSingleLineUpdate_ = nil
			arg_428_1.onSingleLineFinish_ = nil
			arg_428_1.state_ = "waiting"
		end

		function arg_428_1.playNext_(arg_430_0)
			if arg_430_0 == 1 then
				arg_428_0:Play1109701106(arg_428_1)
			end
		end

		function arg_428_1.onSingleLineUpdate_(arg_431_0)
			local var_431_0 = 0
			local var_431_1 = 0.425

			if var_431_0 < arg_428_1.time_ and arg_428_1.time_ <= var_431_0 + arg_431_0 then
				arg_428_1.talkMaxDuration = 0
				arg_428_1.dialogCg_.alpha = 1

				arg_428_1.dialog_:SetActive(true)
				SetActive(arg_428_1.leftNameGo_, false)

				arg_428_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_428_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_428_1:RecordName(arg_428_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_428_1.iconTrs_.gameObject, false)
				arg_428_1.callingController_:SetSelectedState("normal")

				local var_431_2 = arg_428_1:GetWordFromCfg(1109701105)
				local var_431_3 = arg_428_1:FormatText(var_431_2.content)

				arg_428_1.text_.text = var_431_3

				LuaForUtil.ClearLinePrefixSymbol(arg_428_1.text_)

				local var_431_4 = 17
				local var_431_5 = utf8.len(var_431_3)
				local var_431_6 = var_431_4 <= 0 and var_431_1 or var_431_1 * (var_431_5 / var_431_4)

				if var_431_6 > 0 and var_431_1 < var_431_6 then
					arg_428_1.talkMaxDuration = var_431_6

					if var_431_6 + var_431_0 > arg_428_1.duration_ then
						arg_428_1.duration_ = var_431_6 + var_431_0
					end
				end

				arg_428_1.text_.text = var_431_3
				arg_428_1.typewritter.percent = 0

				arg_428_1.typewritter:SetDirty()
				arg_428_1:ShowNextGo(false)
				arg_428_1:RecordContent(arg_428_1.text_.text)
			end

			local var_431_7 = math.max(var_431_1, arg_428_1.talkMaxDuration)

			if var_431_0 <= arg_428_1.time_ and arg_428_1.time_ < var_431_0 + var_431_7 then
				arg_428_1.typewritter.percent = (arg_428_1.time_ - var_431_0) / var_431_7

				arg_428_1.typewritter:SetDirty()
			end

			if arg_428_1.time_ >= var_431_0 + var_431_7 and arg_428_1.time_ < var_431_0 + var_431_7 + arg_431_0 then
				arg_428_1.typewritter.percent = 1

				arg_428_1.typewritter:SetDirty()
				arg_428_1:ShowNextGo(true)
			end
		end

		arg_428_1.nodeConfigList_ = {}

		arg_428_1:InitPlayNodeList()
	end,
	Play1109701106 = function(arg_432_0, arg_432_1)
		arg_432_1.time_ = 0
		arg_432_1.frameCnt_ = 0
		arg_432_1.state_ = "playing"
		arg_432_1.curTalkId_ = 1109701106
		arg_432_1.duration_ = 8.13

		local var_432_0 = {
			zh = 4.7,
			ja = 8.133
		}
		local var_432_1 = manager.audio:GetLocalizationFlag()

		if var_432_0[var_432_1] ~= nil then
			arg_432_1.duration_ = var_432_0[var_432_1]
		end

		SetActive(arg_432_1.tipsGo_, false)

		function arg_432_1.onSingleLineFinish_()
			arg_432_1.onSingleLineUpdate_ = nil
			arg_432_1.onSingleLineFinish_ = nil
			arg_432_1.state_ = "waiting"
		end

		function arg_432_1.playNext_(arg_434_0)
			if arg_434_0 == 1 then
				arg_432_0:Play1109701107(arg_432_1)
			end
		end

		function arg_432_1.onSingleLineUpdate_(arg_435_0)
			local var_435_0 = arg_432_1.actors_["1097ui_story"]
			local var_435_1 = 0

			if var_435_1 < arg_432_1.time_ and arg_432_1.time_ <= var_435_1 + arg_435_0 and not isNil(var_435_0) and arg_432_1.var_.characterEffect1097ui_story == nil then
				arg_432_1.var_.characterEffect1097ui_story = var_435_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_435_2 = 0.200000002980232

			if var_435_1 <= arg_432_1.time_ and arg_432_1.time_ < var_435_1 + var_435_2 and not isNil(var_435_0) then
				local var_435_3 = (arg_432_1.time_ - var_435_1) / var_435_2

				if arg_432_1.var_.characterEffect1097ui_story and not isNil(var_435_0) then
					arg_432_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_432_1.time_ >= var_435_1 + var_435_2 and arg_432_1.time_ < var_435_1 + var_435_2 + arg_435_0 and not isNil(var_435_0) and arg_432_1.var_.characterEffect1097ui_story then
				arg_432_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_435_4 = 0

			if var_435_4 < arg_432_1.time_ and arg_432_1.time_ <= var_435_4 + arg_435_0 then
				arg_432_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			local var_435_5 = 0

			if var_435_5 < arg_432_1.time_ and arg_432_1.time_ <= var_435_5 + arg_435_0 then
				arg_432_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_435_6 = 0
			local var_435_7 = 0.375

			if var_435_6 < arg_432_1.time_ and arg_432_1.time_ <= var_435_6 + arg_435_0 then
				arg_432_1.talkMaxDuration = 0
				arg_432_1.dialogCg_.alpha = 1

				arg_432_1.dialog_:SetActive(true)
				SetActive(arg_432_1.leftNameGo_, true)

				local var_435_8 = arg_432_1:FormatText(StoryNameCfg[216].name)

				arg_432_1.leftNameTxt_.text = var_435_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_432_1.leftNameTxt_.transform)

				arg_432_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_432_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_432_1:RecordName(arg_432_1.leftNameTxt_.text)
				SetActive(arg_432_1.iconTrs_.gameObject, false)
				arg_432_1.callingController_:SetSelectedState("normal")

				local var_435_9 = arg_432_1:GetWordFromCfg(1109701106)
				local var_435_10 = arg_432_1:FormatText(var_435_9.content)

				arg_432_1.text_.text = var_435_10

				LuaForUtil.ClearLinePrefixSymbol(arg_432_1.text_)

				local var_435_11 = 15
				local var_435_12 = utf8.len(var_435_10)
				local var_435_13 = var_435_11 <= 0 and var_435_7 or var_435_7 * (var_435_12 / var_435_11)

				if var_435_13 > 0 and var_435_7 < var_435_13 then
					arg_432_1.talkMaxDuration = var_435_13

					if var_435_13 + var_435_6 > arg_432_1.duration_ then
						arg_432_1.duration_ = var_435_13 + var_435_6
					end
				end

				arg_432_1.text_.text = var_435_10
				arg_432_1.typewritter.percent = 0

				arg_432_1.typewritter:SetDirty()
				arg_432_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701106", "story_v_side_new_1109701.awb") ~= 0 then
					local var_435_14 = manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701106", "story_v_side_new_1109701.awb") / 1000

					if var_435_14 + var_435_6 > arg_432_1.duration_ then
						arg_432_1.duration_ = var_435_14 + var_435_6
					end

					if var_435_9.prefab_name ~= "" and arg_432_1.actors_[var_435_9.prefab_name] ~= nil then
						local var_435_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_432_1.actors_[var_435_9.prefab_name].transform, "story_v_side_new_1109701", "1109701106", "story_v_side_new_1109701.awb")

						arg_432_1:RecordAudio("1109701106", var_435_15)
						arg_432_1:RecordAudio("1109701106", var_435_15)
					else
						arg_432_1:AudioAction("play", "voice", "story_v_side_new_1109701", "1109701106", "story_v_side_new_1109701.awb")
					end

					arg_432_1:RecordHistoryTalkVoice("story_v_side_new_1109701", "1109701106", "story_v_side_new_1109701.awb")
				end

				arg_432_1:RecordContent(arg_432_1.text_.text)
			end

			local var_435_16 = math.max(var_435_7, arg_432_1.talkMaxDuration)

			if var_435_6 <= arg_432_1.time_ and arg_432_1.time_ < var_435_6 + var_435_16 then
				arg_432_1.typewritter.percent = (arg_432_1.time_ - var_435_6) / var_435_16

				arg_432_1.typewritter:SetDirty()
			end

			if arg_432_1.time_ >= var_435_6 + var_435_16 and arg_432_1.time_ < var_435_6 + var_435_16 + arg_435_0 then
				arg_432_1.typewritter.percent = 1

				arg_432_1.typewritter:SetDirty()
				arg_432_1:ShowNextGo(true)
			end
		end

		arg_432_1.nodeConfigList_ = {}

		arg_432_1:InitPlayNodeList()
	end,
	Play1109701107 = function(arg_436_0, arg_436_1)
		arg_436_1.time_ = 0
		arg_436_1.frameCnt_ = 0
		arg_436_1.state_ = "playing"
		arg_436_1.curTalkId_ = 1109701107
		arg_436_1.duration_ = 6.83

		local var_436_0 = {
			zh = 6.233,
			ja = 6.833
		}
		local var_436_1 = manager.audio:GetLocalizationFlag()

		if var_436_0[var_436_1] ~= nil then
			arg_436_1.duration_ = var_436_0[var_436_1]
		end

		SetActive(arg_436_1.tipsGo_, false)

		function arg_436_1.onSingleLineFinish_()
			arg_436_1.onSingleLineUpdate_ = nil
			arg_436_1.onSingleLineFinish_ = nil
			arg_436_1.state_ = "waiting"
		end

		function arg_436_1.playNext_(arg_438_0)
			if arg_438_0 == 1 then
				arg_436_0:Play1109701108(arg_436_1)
			end
		end

		function arg_436_1.onSingleLineUpdate_(arg_439_0)
			local var_439_0 = 0

			if var_439_0 < arg_436_1.time_ and arg_436_1.time_ <= var_439_0 + arg_439_0 then
				arg_436_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			local var_439_1 = 0

			if var_439_1 < arg_436_1.time_ and arg_436_1.time_ <= var_439_1 + arg_439_0 then
				arg_436_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_439_2 = 0
			local var_439_3 = 0.5

			if var_439_2 < arg_436_1.time_ and arg_436_1.time_ <= var_439_2 + arg_439_0 then
				arg_436_1.talkMaxDuration = 0
				arg_436_1.dialogCg_.alpha = 1

				arg_436_1.dialog_:SetActive(true)
				SetActive(arg_436_1.leftNameGo_, true)

				local var_439_4 = arg_436_1:FormatText(StoryNameCfg[216].name)

				arg_436_1.leftNameTxt_.text = var_439_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_436_1.leftNameTxt_.transform)

				arg_436_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_436_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_436_1:RecordName(arg_436_1.leftNameTxt_.text)
				SetActive(arg_436_1.iconTrs_.gameObject, false)
				arg_436_1.callingController_:SetSelectedState("normal")

				local var_439_5 = arg_436_1:GetWordFromCfg(1109701107)
				local var_439_6 = arg_436_1:FormatText(var_439_5.content)

				arg_436_1.text_.text = var_439_6

				LuaForUtil.ClearLinePrefixSymbol(arg_436_1.text_)

				local var_439_7 = 20
				local var_439_8 = utf8.len(var_439_6)
				local var_439_9 = var_439_7 <= 0 and var_439_3 or var_439_3 * (var_439_8 / var_439_7)

				if var_439_9 > 0 and var_439_3 < var_439_9 then
					arg_436_1.talkMaxDuration = var_439_9

					if var_439_9 + var_439_2 > arg_436_1.duration_ then
						arg_436_1.duration_ = var_439_9 + var_439_2
					end
				end

				arg_436_1.text_.text = var_439_6
				arg_436_1.typewritter.percent = 0

				arg_436_1.typewritter:SetDirty()
				arg_436_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701107", "story_v_side_new_1109701.awb") ~= 0 then
					local var_439_10 = manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701107", "story_v_side_new_1109701.awb") / 1000

					if var_439_10 + var_439_2 > arg_436_1.duration_ then
						arg_436_1.duration_ = var_439_10 + var_439_2
					end

					if var_439_5.prefab_name ~= "" and arg_436_1.actors_[var_439_5.prefab_name] ~= nil then
						local var_439_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_436_1.actors_[var_439_5.prefab_name].transform, "story_v_side_new_1109701", "1109701107", "story_v_side_new_1109701.awb")

						arg_436_1:RecordAudio("1109701107", var_439_11)
						arg_436_1:RecordAudio("1109701107", var_439_11)
					else
						arg_436_1:AudioAction("play", "voice", "story_v_side_new_1109701", "1109701107", "story_v_side_new_1109701.awb")
					end

					arg_436_1:RecordHistoryTalkVoice("story_v_side_new_1109701", "1109701107", "story_v_side_new_1109701.awb")
				end

				arg_436_1:RecordContent(arg_436_1.text_.text)
			end

			local var_439_12 = math.max(var_439_3, arg_436_1.talkMaxDuration)

			if var_439_2 <= arg_436_1.time_ and arg_436_1.time_ < var_439_2 + var_439_12 then
				arg_436_1.typewritter.percent = (arg_436_1.time_ - var_439_2) / var_439_12

				arg_436_1.typewritter:SetDirty()
			end

			if arg_436_1.time_ >= var_439_2 + var_439_12 and arg_436_1.time_ < var_439_2 + var_439_12 + arg_439_0 then
				arg_436_1.typewritter.percent = 1

				arg_436_1.typewritter:SetDirty()
				arg_436_1:ShowNextGo(true)
			end
		end

		arg_436_1.nodeConfigList_ = {}

		arg_436_1:InitPlayNodeList()
	end,
	Play1109701108 = function(arg_440_0, arg_440_1)
		arg_440_1.time_ = 0
		arg_440_1.frameCnt_ = 0
		arg_440_1.state_ = "playing"
		arg_440_1.curTalkId_ = 1109701108
		arg_440_1.duration_ = 5

		SetActive(arg_440_1.tipsGo_, false)

		function arg_440_1.onSingleLineFinish_()
			arg_440_1.onSingleLineUpdate_ = nil
			arg_440_1.onSingleLineFinish_ = nil
			arg_440_1.state_ = "waiting"
		end

		function arg_440_1.playNext_(arg_442_0)
			if arg_442_0 == 1 then
				arg_440_0:Play1109701109(arg_440_1)
			end
		end

		function arg_440_1.onSingleLineUpdate_(arg_443_0)
			local var_443_0 = arg_440_1.actors_["1097ui_story"]
			local var_443_1 = 0

			if var_443_1 < arg_440_1.time_ and arg_440_1.time_ <= var_443_1 + arg_443_0 and not isNil(var_443_0) and arg_440_1.var_.characterEffect1097ui_story == nil then
				arg_440_1.var_.characterEffect1097ui_story = var_443_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_443_2 = 0.200000002980232

			if var_443_1 <= arg_440_1.time_ and arg_440_1.time_ < var_443_1 + var_443_2 and not isNil(var_443_0) then
				local var_443_3 = (arg_440_1.time_ - var_443_1) / var_443_2

				if arg_440_1.var_.characterEffect1097ui_story and not isNil(var_443_0) then
					local var_443_4 = Mathf.Lerp(0, 0.5, var_443_3)

					arg_440_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_440_1.var_.characterEffect1097ui_story.fillRatio = var_443_4
				end
			end

			if arg_440_1.time_ >= var_443_1 + var_443_2 and arg_440_1.time_ < var_443_1 + var_443_2 + arg_443_0 and not isNil(var_443_0) and arg_440_1.var_.characterEffect1097ui_story then
				local var_443_5 = 0.5

				arg_440_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_440_1.var_.characterEffect1097ui_story.fillRatio = var_443_5
			end

			local var_443_6 = 0
			local var_443_7 = 0.1

			if var_443_6 < arg_440_1.time_ and arg_440_1.time_ <= var_443_6 + arg_443_0 then
				arg_440_1.talkMaxDuration = 0
				arg_440_1.dialogCg_.alpha = 1

				arg_440_1.dialog_:SetActive(true)
				SetActive(arg_440_1.leftNameGo_, true)

				local var_443_8 = arg_440_1:FormatText(StoryNameCfg[7].name)

				arg_440_1.leftNameTxt_.text = var_443_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_440_1.leftNameTxt_.transform)

				arg_440_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_440_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_440_1:RecordName(arg_440_1.leftNameTxt_.text)
				SetActive(arg_440_1.iconTrs_.gameObject, true)
				arg_440_1.iconController_:SetSelectedState("hero")

				arg_440_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_440_1.callingController_:SetSelectedState("normal")

				arg_440_1.keyicon_.color = Color.New(1, 1, 1)
				arg_440_1.icon_.color = Color.New(1, 1, 1)

				local var_443_9 = arg_440_1:GetWordFromCfg(1109701108)
				local var_443_10 = arg_440_1:FormatText(var_443_9.content)

				arg_440_1.text_.text = var_443_10

				LuaForUtil.ClearLinePrefixSymbol(arg_440_1.text_)

				local var_443_11 = 4
				local var_443_12 = utf8.len(var_443_10)
				local var_443_13 = var_443_11 <= 0 and var_443_7 or var_443_7 * (var_443_12 / var_443_11)

				if var_443_13 > 0 and var_443_7 < var_443_13 then
					arg_440_1.talkMaxDuration = var_443_13

					if var_443_13 + var_443_6 > arg_440_1.duration_ then
						arg_440_1.duration_ = var_443_13 + var_443_6
					end
				end

				arg_440_1.text_.text = var_443_10
				arg_440_1.typewritter.percent = 0

				arg_440_1.typewritter:SetDirty()
				arg_440_1:ShowNextGo(false)
				arg_440_1:RecordContent(arg_440_1.text_.text)
			end

			local var_443_14 = math.max(var_443_7, arg_440_1.talkMaxDuration)

			if var_443_6 <= arg_440_1.time_ and arg_440_1.time_ < var_443_6 + var_443_14 then
				arg_440_1.typewritter.percent = (arg_440_1.time_ - var_443_6) / var_443_14

				arg_440_1.typewritter:SetDirty()
			end

			if arg_440_1.time_ >= var_443_6 + var_443_14 and arg_440_1.time_ < var_443_6 + var_443_14 + arg_443_0 then
				arg_440_1.typewritter.percent = 1

				arg_440_1.typewritter:SetDirty()
				arg_440_1:ShowNextGo(true)
			end
		end

		arg_440_1.nodeConfigList_ = {}

		arg_440_1:InitPlayNodeList()
	end,
	Play1109701109 = function(arg_444_0, arg_444_1)
		arg_444_1.time_ = 0
		arg_444_1.frameCnt_ = 0
		arg_444_1.state_ = "playing"
		arg_444_1.curTalkId_ = 1109701109
		arg_444_1.duration_ = 5.9

		local var_444_0 = {
			zh = 5.533,
			ja = 5.9
		}
		local var_444_1 = manager.audio:GetLocalizationFlag()

		if var_444_0[var_444_1] ~= nil then
			arg_444_1.duration_ = var_444_0[var_444_1]
		end

		SetActive(arg_444_1.tipsGo_, false)

		function arg_444_1.onSingleLineFinish_()
			arg_444_1.onSingleLineUpdate_ = nil
			arg_444_1.onSingleLineFinish_ = nil
			arg_444_1.state_ = "waiting"
		end

		function arg_444_1.playNext_(arg_446_0)
			if arg_446_0 == 1 then
				arg_444_0:Play1109701110(arg_444_1)
			end
		end

		function arg_444_1.onSingleLineUpdate_(arg_447_0)
			local var_447_0 = arg_444_1.actors_["1042ui_story"].transform
			local var_447_1 = 0

			if var_447_1 < arg_444_1.time_ and arg_444_1.time_ <= var_447_1 + arg_447_0 then
				arg_444_1.var_.moveOldPos1042ui_story = var_447_0.localPosition
			end

			local var_447_2 = 0.001

			if var_447_1 <= arg_444_1.time_ and arg_444_1.time_ < var_447_1 + var_447_2 then
				local var_447_3 = (arg_444_1.time_ - var_447_1) / var_447_2
				local var_447_4 = Vector3.New(0.7, -1.06, -6.2)

				var_447_0.localPosition = Vector3.Lerp(arg_444_1.var_.moveOldPos1042ui_story, var_447_4, var_447_3)

				local var_447_5 = manager.ui.mainCamera.transform.position - var_447_0.position

				var_447_0.forward = Vector3.New(var_447_5.x, var_447_5.y, var_447_5.z)

				local var_447_6 = var_447_0.localEulerAngles

				var_447_6.z = 0
				var_447_6.x = 0
				var_447_0.localEulerAngles = var_447_6
			end

			if arg_444_1.time_ >= var_447_1 + var_447_2 and arg_444_1.time_ < var_447_1 + var_447_2 + arg_447_0 then
				var_447_0.localPosition = Vector3.New(0.7, -1.06, -6.2)

				local var_447_7 = manager.ui.mainCamera.transform.position - var_447_0.position

				var_447_0.forward = Vector3.New(var_447_7.x, var_447_7.y, var_447_7.z)

				local var_447_8 = var_447_0.localEulerAngles

				var_447_8.z = 0
				var_447_8.x = 0
				var_447_0.localEulerAngles = var_447_8
			end

			local var_447_9 = arg_444_1.actors_["1042ui_story"]
			local var_447_10 = 0

			if var_447_10 < arg_444_1.time_ and arg_444_1.time_ <= var_447_10 + arg_447_0 and not isNil(var_447_9) and arg_444_1.var_.characterEffect1042ui_story == nil then
				arg_444_1.var_.characterEffect1042ui_story = var_447_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_447_11 = 0.200000002980232

			if var_447_10 <= arg_444_1.time_ and arg_444_1.time_ < var_447_10 + var_447_11 and not isNil(var_447_9) then
				local var_447_12 = (arg_444_1.time_ - var_447_10) / var_447_11

				if arg_444_1.var_.characterEffect1042ui_story and not isNil(var_447_9) then
					arg_444_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_444_1.time_ >= var_447_10 + var_447_11 and arg_444_1.time_ < var_447_10 + var_447_11 + arg_447_0 and not isNil(var_447_9) and arg_444_1.var_.characterEffect1042ui_story then
				arg_444_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_447_13 = 0

			if var_447_13 < arg_444_1.time_ and arg_444_1.time_ <= var_447_13 + arg_447_0 then
				arg_444_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action1_1")
			end

			local var_447_14 = 0

			if var_447_14 < arg_444_1.time_ and arg_444_1.time_ <= var_447_14 + arg_447_0 then
				arg_444_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_447_15 = 0
			local var_447_16 = 0.6

			if var_447_15 < arg_444_1.time_ and arg_444_1.time_ <= var_447_15 + arg_447_0 then
				arg_444_1.talkMaxDuration = 0
				arg_444_1.dialogCg_.alpha = 1

				arg_444_1.dialog_:SetActive(true)
				SetActive(arg_444_1.leftNameGo_, true)

				local var_447_17 = arg_444_1:FormatText(StoryNameCfg[205].name)

				arg_444_1.leftNameTxt_.text = var_447_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_444_1.leftNameTxt_.transform)

				arg_444_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_444_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_444_1:RecordName(arg_444_1.leftNameTxt_.text)
				SetActive(arg_444_1.iconTrs_.gameObject, false)
				arg_444_1.callingController_:SetSelectedState("normal")

				local var_447_18 = arg_444_1:GetWordFromCfg(1109701109)
				local var_447_19 = arg_444_1:FormatText(var_447_18.content)

				arg_444_1.text_.text = var_447_19

				LuaForUtil.ClearLinePrefixSymbol(arg_444_1.text_)

				local var_447_20 = 24
				local var_447_21 = utf8.len(var_447_19)
				local var_447_22 = var_447_20 <= 0 and var_447_16 or var_447_16 * (var_447_21 / var_447_20)

				if var_447_22 > 0 and var_447_16 < var_447_22 then
					arg_444_1.talkMaxDuration = var_447_22

					if var_447_22 + var_447_15 > arg_444_1.duration_ then
						arg_444_1.duration_ = var_447_22 + var_447_15
					end
				end

				arg_444_1.text_.text = var_447_19
				arg_444_1.typewritter.percent = 0

				arg_444_1.typewritter:SetDirty()
				arg_444_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701109", "story_v_side_new_1109701.awb") ~= 0 then
					local var_447_23 = manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701109", "story_v_side_new_1109701.awb") / 1000

					if var_447_23 + var_447_15 > arg_444_1.duration_ then
						arg_444_1.duration_ = var_447_23 + var_447_15
					end

					if var_447_18.prefab_name ~= "" and arg_444_1.actors_[var_447_18.prefab_name] ~= nil then
						local var_447_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_444_1.actors_[var_447_18.prefab_name].transform, "story_v_side_new_1109701", "1109701109", "story_v_side_new_1109701.awb")

						arg_444_1:RecordAudio("1109701109", var_447_24)
						arg_444_1:RecordAudio("1109701109", var_447_24)
					else
						arg_444_1:AudioAction("play", "voice", "story_v_side_new_1109701", "1109701109", "story_v_side_new_1109701.awb")
					end

					arg_444_1:RecordHistoryTalkVoice("story_v_side_new_1109701", "1109701109", "story_v_side_new_1109701.awb")
				end

				arg_444_1:RecordContent(arg_444_1.text_.text)
			end

			local var_447_25 = math.max(var_447_16, arg_444_1.talkMaxDuration)

			if var_447_15 <= arg_444_1.time_ and arg_444_1.time_ < var_447_15 + var_447_25 then
				arg_444_1.typewritter.percent = (arg_444_1.time_ - var_447_15) / var_447_25

				arg_444_1.typewritter:SetDirty()
			end

			if arg_444_1.time_ >= var_447_15 + var_447_25 and arg_444_1.time_ < var_447_15 + var_447_25 + arg_447_0 then
				arg_444_1.typewritter.percent = 1

				arg_444_1.typewritter:SetDirty()
				arg_444_1:ShowNextGo(true)
			end
		end

		arg_444_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_444_1:InitPlayNodeList()
	end,
	Play1109701110 = function(arg_448_0, arg_448_1)
		arg_448_1.time_ = 0
		arg_448_1.frameCnt_ = 0
		arg_448_1.state_ = "playing"
		arg_448_1.curTalkId_ = 1109701110
		arg_448_1.duration_ = 5.2

		local var_448_0 = {
			zh = 4.1,
			ja = 5.2
		}
		local var_448_1 = manager.audio:GetLocalizationFlag()

		if var_448_0[var_448_1] ~= nil then
			arg_448_1.duration_ = var_448_0[var_448_1]
		end

		SetActive(arg_448_1.tipsGo_, false)

		function arg_448_1.onSingleLineFinish_()
			arg_448_1.onSingleLineUpdate_ = nil
			arg_448_1.onSingleLineFinish_ = nil
			arg_448_1.state_ = "waiting"
		end

		function arg_448_1.playNext_(arg_450_0)
			if arg_450_0 == 1 then
				arg_448_0:Play1109701111(arg_448_1)
			end
		end

		function arg_448_1.onSingleLineUpdate_(arg_451_0)
			local var_451_0 = 0

			if var_451_0 < arg_448_1.time_ and arg_448_1.time_ <= var_451_0 + arg_451_0 then
				arg_448_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action2_1")
			end

			local var_451_1 = 0

			if var_451_1 < arg_448_1.time_ and arg_448_1.time_ <= var_451_1 + arg_451_0 then
				arg_448_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_451_2 = 0
			local var_451_3 = 0.45

			if var_451_2 < arg_448_1.time_ and arg_448_1.time_ <= var_451_2 + arg_451_0 then
				arg_448_1.talkMaxDuration = 0
				arg_448_1.dialogCg_.alpha = 1

				arg_448_1.dialog_:SetActive(true)
				SetActive(arg_448_1.leftNameGo_, true)

				local var_451_4 = arg_448_1:FormatText(StoryNameCfg[205].name)

				arg_448_1.leftNameTxt_.text = var_451_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_448_1.leftNameTxt_.transform)

				arg_448_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_448_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_448_1:RecordName(arg_448_1.leftNameTxt_.text)
				SetActive(arg_448_1.iconTrs_.gameObject, false)
				arg_448_1.callingController_:SetSelectedState("normal")

				local var_451_5 = arg_448_1:GetWordFromCfg(1109701110)
				local var_451_6 = arg_448_1:FormatText(var_451_5.content)

				arg_448_1.text_.text = var_451_6

				LuaForUtil.ClearLinePrefixSymbol(arg_448_1.text_)

				local var_451_7 = 18
				local var_451_8 = utf8.len(var_451_6)
				local var_451_9 = var_451_7 <= 0 and var_451_3 or var_451_3 * (var_451_8 / var_451_7)

				if var_451_9 > 0 and var_451_3 < var_451_9 then
					arg_448_1.talkMaxDuration = var_451_9

					if var_451_9 + var_451_2 > arg_448_1.duration_ then
						arg_448_1.duration_ = var_451_9 + var_451_2
					end
				end

				arg_448_1.text_.text = var_451_6
				arg_448_1.typewritter.percent = 0

				arg_448_1.typewritter:SetDirty()
				arg_448_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701110", "story_v_side_new_1109701.awb") ~= 0 then
					local var_451_10 = manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701110", "story_v_side_new_1109701.awb") / 1000

					if var_451_10 + var_451_2 > arg_448_1.duration_ then
						arg_448_1.duration_ = var_451_10 + var_451_2
					end

					if var_451_5.prefab_name ~= "" and arg_448_1.actors_[var_451_5.prefab_name] ~= nil then
						local var_451_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_448_1.actors_[var_451_5.prefab_name].transform, "story_v_side_new_1109701", "1109701110", "story_v_side_new_1109701.awb")

						arg_448_1:RecordAudio("1109701110", var_451_11)
						arg_448_1:RecordAudio("1109701110", var_451_11)
					else
						arg_448_1:AudioAction("play", "voice", "story_v_side_new_1109701", "1109701110", "story_v_side_new_1109701.awb")
					end

					arg_448_1:RecordHistoryTalkVoice("story_v_side_new_1109701", "1109701110", "story_v_side_new_1109701.awb")
				end

				arg_448_1:RecordContent(arg_448_1.text_.text)
			end

			local var_451_12 = math.max(var_451_3, arg_448_1.talkMaxDuration)

			if var_451_2 <= arg_448_1.time_ and arg_448_1.time_ < var_451_2 + var_451_12 then
				arg_448_1.typewritter.percent = (arg_448_1.time_ - var_451_2) / var_451_12

				arg_448_1.typewritter:SetDirty()
			end

			if arg_448_1.time_ >= var_451_2 + var_451_12 and arg_448_1.time_ < var_451_2 + var_451_12 + arg_451_0 then
				arg_448_1.typewritter.percent = 1

				arg_448_1.typewritter:SetDirty()
				arg_448_1:ShowNextGo(true)
			end
		end

		arg_448_1.nodeConfigList_ = {}

		arg_448_1:InitPlayNodeList()
	end,
	Play1109701111 = function(arg_452_0, arg_452_1)
		arg_452_1.time_ = 0
		arg_452_1.frameCnt_ = 0
		arg_452_1.state_ = "playing"
		arg_452_1.curTalkId_ = 1109701111
		arg_452_1.duration_ = 5

		SetActive(arg_452_1.tipsGo_, false)

		function arg_452_1.onSingleLineFinish_()
			arg_452_1.onSingleLineUpdate_ = nil
			arg_452_1.onSingleLineFinish_ = nil
			arg_452_1.state_ = "waiting"
		end

		function arg_452_1.playNext_(arg_454_0)
			if arg_454_0 == 1 then
				arg_452_0:Play1109701112(arg_452_1)
			end
		end

		function arg_452_1.onSingleLineUpdate_(arg_455_0)
			local var_455_0 = arg_452_1.actors_["1042ui_story"]
			local var_455_1 = 0

			if var_455_1 < arg_452_1.time_ and arg_452_1.time_ <= var_455_1 + arg_455_0 and not isNil(var_455_0) and arg_452_1.var_.characterEffect1042ui_story == nil then
				arg_452_1.var_.characterEffect1042ui_story = var_455_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_455_2 = 0.200000002980232

			if var_455_1 <= arg_452_1.time_ and arg_452_1.time_ < var_455_1 + var_455_2 and not isNil(var_455_0) then
				local var_455_3 = (arg_452_1.time_ - var_455_1) / var_455_2

				if arg_452_1.var_.characterEffect1042ui_story and not isNil(var_455_0) then
					local var_455_4 = Mathf.Lerp(0, 0.5, var_455_3)

					arg_452_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_452_1.var_.characterEffect1042ui_story.fillRatio = var_455_4
				end
			end

			if arg_452_1.time_ >= var_455_1 + var_455_2 and arg_452_1.time_ < var_455_1 + var_455_2 + arg_455_0 and not isNil(var_455_0) and arg_452_1.var_.characterEffect1042ui_story then
				local var_455_5 = 0.5

				arg_452_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_452_1.var_.characterEffect1042ui_story.fillRatio = var_455_5
			end

			local var_455_6 = 0
			local var_455_7 = 0.075

			if var_455_6 < arg_452_1.time_ and arg_452_1.time_ <= var_455_6 + arg_455_0 then
				arg_452_1.talkMaxDuration = 0
				arg_452_1.dialogCg_.alpha = 1

				arg_452_1.dialog_:SetActive(true)
				SetActive(arg_452_1.leftNameGo_, true)

				local var_455_8 = arg_452_1:FormatText(StoryNameCfg[7].name)

				arg_452_1.leftNameTxt_.text = var_455_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_452_1.leftNameTxt_.transform)

				arg_452_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_452_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_452_1:RecordName(arg_452_1.leftNameTxt_.text)
				SetActive(arg_452_1.iconTrs_.gameObject, true)
				arg_452_1.iconController_:SetSelectedState("hero")

				arg_452_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_452_1.callingController_:SetSelectedState("normal")

				arg_452_1.keyicon_.color = Color.New(1, 1, 1)
				arg_452_1.icon_.color = Color.New(1, 1, 1)

				local var_455_9 = arg_452_1:GetWordFromCfg(1109701111)
				local var_455_10 = arg_452_1:FormatText(var_455_9.content)

				arg_452_1.text_.text = var_455_10

				LuaForUtil.ClearLinePrefixSymbol(arg_452_1.text_)

				local var_455_11 = 3
				local var_455_12 = utf8.len(var_455_10)
				local var_455_13 = var_455_11 <= 0 and var_455_7 or var_455_7 * (var_455_12 / var_455_11)

				if var_455_13 > 0 and var_455_7 < var_455_13 then
					arg_452_1.talkMaxDuration = var_455_13

					if var_455_13 + var_455_6 > arg_452_1.duration_ then
						arg_452_1.duration_ = var_455_13 + var_455_6
					end
				end

				arg_452_1.text_.text = var_455_10
				arg_452_1.typewritter.percent = 0

				arg_452_1.typewritter:SetDirty()
				arg_452_1:ShowNextGo(false)
				arg_452_1:RecordContent(arg_452_1.text_.text)
			end

			local var_455_14 = math.max(var_455_7, arg_452_1.talkMaxDuration)

			if var_455_6 <= arg_452_1.time_ and arg_452_1.time_ < var_455_6 + var_455_14 then
				arg_452_1.typewritter.percent = (arg_452_1.time_ - var_455_6) / var_455_14

				arg_452_1.typewritter:SetDirty()
			end

			if arg_452_1.time_ >= var_455_6 + var_455_14 and arg_452_1.time_ < var_455_6 + var_455_14 + arg_455_0 then
				arg_452_1.typewritter.percent = 1

				arg_452_1.typewritter:SetDirty()
				arg_452_1:ShowNextGo(true)
			end
		end

		arg_452_1.nodeConfigList_ = {}

		arg_452_1:InitPlayNodeList()
	end,
	Play1109701112 = function(arg_456_0, arg_456_1)
		arg_456_1.time_ = 0
		arg_456_1.frameCnt_ = 0
		arg_456_1.state_ = "playing"
		arg_456_1.curTalkId_ = 1109701112
		arg_456_1.duration_ = 5

		SetActive(arg_456_1.tipsGo_, false)

		function arg_456_1.onSingleLineFinish_()
			arg_456_1.onSingleLineUpdate_ = nil
			arg_456_1.onSingleLineFinish_ = nil
			arg_456_1.state_ = "waiting"
		end

		function arg_456_1.playNext_(arg_458_0)
			if arg_458_0 == 1 then
				arg_456_0:Play1109701113(arg_456_1)
			end
		end

		function arg_456_1.onSingleLineUpdate_(arg_459_0)
			local var_459_0 = arg_456_1.actors_["1042ui_story"].transform
			local var_459_1 = 0

			if var_459_1 < arg_456_1.time_ and arg_456_1.time_ <= var_459_1 + arg_459_0 then
				arg_456_1.var_.moveOldPos1042ui_story = var_459_0.localPosition
			end

			local var_459_2 = 0.001

			if var_459_1 <= arg_456_1.time_ and arg_456_1.time_ < var_459_1 + var_459_2 then
				local var_459_3 = (arg_456_1.time_ - var_459_1) / var_459_2
				local var_459_4 = Vector3.New(0, 100, 0)

				var_459_0.localPosition = Vector3.Lerp(arg_456_1.var_.moveOldPos1042ui_story, var_459_4, var_459_3)

				local var_459_5 = manager.ui.mainCamera.transform.position - var_459_0.position

				var_459_0.forward = Vector3.New(var_459_5.x, var_459_5.y, var_459_5.z)

				local var_459_6 = var_459_0.localEulerAngles

				var_459_6.z = 0
				var_459_6.x = 0
				var_459_0.localEulerAngles = var_459_6
			end

			if arg_456_1.time_ >= var_459_1 + var_459_2 and arg_456_1.time_ < var_459_1 + var_459_2 + arg_459_0 then
				var_459_0.localPosition = Vector3.New(0, 100, 0)

				local var_459_7 = manager.ui.mainCamera.transform.position - var_459_0.position

				var_459_0.forward = Vector3.New(var_459_7.x, var_459_7.y, var_459_7.z)

				local var_459_8 = var_459_0.localEulerAngles

				var_459_8.z = 0
				var_459_8.x = 0
				var_459_0.localEulerAngles = var_459_8
			end

			local var_459_9 = arg_456_1.actors_["1097ui_story"].transform
			local var_459_10 = 0

			if var_459_10 < arg_456_1.time_ and arg_456_1.time_ <= var_459_10 + arg_459_0 then
				arg_456_1.var_.moveOldPos1097ui_story = var_459_9.localPosition
			end

			local var_459_11 = 0.001

			if var_459_10 <= arg_456_1.time_ and arg_456_1.time_ < var_459_10 + var_459_11 then
				local var_459_12 = (arg_456_1.time_ - var_459_10) / var_459_11
				local var_459_13 = Vector3.New(0, -0.54, -6.3)

				var_459_9.localPosition = Vector3.Lerp(arg_456_1.var_.moveOldPos1097ui_story, var_459_13, var_459_12)

				local var_459_14 = manager.ui.mainCamera.transform.position - var_459_9.position

				var_459_9.forward = Vector3.New(var_459_14.x, var_459_14.y, var_459_14.z)

				local var_459_15 = var_459_9.localEulerAngles

				var_459_15.z = 0
				var_459_15.x = 0
				var_459_9.localEulerAngles = var_459_15
			end

			if arg_456_1.time_ >= var_459_10 + var_459_11 and arg_456_1.time_ < var_459_10 + var_459_11 + arg_459_0 then
				var_459_9.localPosition = Vector3.New(0, -0.54, -6.3)

				local var_459_16 = manager.ui.mainCamera.transform.position - var_459_9.position

				var_459_9.forward = Vector3.New(var_459_16.x, var_459_16.y, var_459_16.z)

				local var_459_17 = var_459_9.localEulerAngles

				var_459_17.z = 0
				var_459_17.x = 0
				var_459_9.localEulerAngles = var_459_17
			end

			local var_459_18 = arg_456_1.actors_["1097ui_story"]
			local var_459_19 = 0

			if var_459_19 < arg_456_1.time_ and arg_456_1.time_ <= var_459_19 + arg_459_0 and not isNil(var_459_18) and arg_456_1.var_.characterEffect1097ui_story == nil then
				arg_456_1.var_.characterEffect1097ui_story = var_459_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_459_20 = 0.034000001847744

			if var_459_19 <= arg_456_1.time_ and arg_456_1.time_ < var_459_19 + var_459_20 and not isNil(var_459_18) then
				local var_459_21 = (arg_456_1.time_ - var_459_19) / var_459_20

				if arg_456_1.var_.characterEffect1097ui_story and not isNil(var_459_18) then
					local var_459_22 = Mathf.Lerp(0, 0.5, var_459_21)

					arg_456_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_456_1.var_.characterEffect1097ui_story.fillRatio = var_459_22
				end
			end

			if arg_456_1.time_ >= var_459_19 + var_459_20 and arg_456_1.time_ < var_459_19 + var_459_20 + arg_459_0 and not isNil(var_459_18) and arg_456_1.var_.characterEffect1097ui_story then
				local var_459_23 = 0.5

				arg_456_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_456_1.var_.characterEffect1097ui_story.fillRatio = var_459_23
			end

			local var_459_24 = 0
			local var_459_25 = 0.85

			if var_459_24 < arg_456_1.time_ and arg_456_1.time_ <= var_459_24 + arg_459_0 then
				arg_456_1.talkMaxDuration = 0
				arg_456_1.dialogCg_.alpha = 1

				arg_456_1.dialog_:SetActive(true)
				SetActive(arg_456_1.leftNameGo_, false)

				arg_456_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_456_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_456_1:RecordName(arg_456_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_456_1.iconTrs_.gameObject, false)
				arg_456_1.callingController_:SetSelectedState("normal")

				local var_459_26 = arg_456_1:GetWordFromCfg(1109701112)
				local var_459_27 = arg_456_1:FormatText(var_459_26.content)

				arg_456_1.text_.text = var_459_27

				LuaForUtil.ClearLinePrefixSymbol(arg_456_1.text_)

				local var_459_28 = 34
				local var_459_29 = utf8.len(var_459_27)
				local var_459_30 = var_459_28 <= 0 and var_459_25 or var_459_25 * (var_459_29 / var_459_28)

				if var_459_30 > 0 and var_459_25 < var_459_30 then
					arg_456_1.talkMaxDuration = var_459_30

					if var_459_30 + var_459_24 > arg_456_1.duration_ then
						arg_456_1.duration_ = var_459_30 + var_459_24
					end
				end

				arg_456_1.text_.text = var_459_27
				arg_456_1.typewritter.percent = 0

				arg_456_1.typewritter:SetDirty()
				arg_456_1:ShowNextGo(false)
				arg_456_1:RecordContent(arg_456_1.text_.text)
			end

			local var_459_31 = math.max(var_459_25, arg_456_1.talkMaxDuration)

			if var_459_24 <= arg_456_1.time_ and arg_456_1.time_ < var_459_24 + var_459_31 then
				arg_456_1.typewritter.percent = (arg_456_1.time_ - var_459_24) / var_459_31

				arg_456_1.typewritter:SetDirty()
			end

			if arg_456_1.time_ >= var_459_24 + var_459_31 and arg_456_1.time_ < var_459_24 + var_459_31 + arg_459_0 then
				arg_456_1.typewritter.percent = 1

				arg_456_1.typewritter:SetDirty()
				arg_456_1:ShowNextGo(true)
			end
		end

		arg_456_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_456_1:InitPlayNodeList()
	end,
	Play1109701113 = function(arg_460_0, arg_460_1)
		arg_460_1.time_ = 0
		arg_460_1.frameCnt_ = 0
		arg_460_1.state_ = "playing"
		arg_460_1.curTalkId_ = 1109701113
		arg_460_1.duration_ = 3.3

		local var_460_0 = {
			zh = 3.3,
			ja = 3
		}
		local var_460_1 = manager.audio:GetLocalizationFlag()

		if var_460_0[var_460_1] ~= nil then
			arg_460_1.duration_ = var_460_0[var_460_1]
		end

		SetActive(arg_460_1.tipsGo_, false)

		function arg_460_1.onSingleLineFinish_()
			arg_460_1.onSingleLineUpdate_ = nil
			arg_460_1.onSingleLineFinish_ = nil
			arg_460_1.state_ = "waiting"
		end

		function arg_460_1.playNext_(arg_462_0)
			if arg_462_0 == 1 then
				arg_460_0:Play1109701114(arg_460_1)
			end
		end

		function arg_460_1.onSingleLineUpdate_(arg_463_0)
			local var_463_0 = arg_460_1.actors_["1097ui_story"]
			local var_463_1 = 0

			if var_463_1 < arg_460_1.time_ and arg_460_1.time_ <= var_463_1 + arg_463_0 and not isNil(var_463_0) and arg_460_1.var_.characterEffect1097ui_story == nil then
				arg_460_1.var_.characterEffect1097ui_story = var_463_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_463_2 = 0.200000002980232

			if var_463_1 <= arg_460_1.time_ and arg_460_1.time_ < var_463_1 + var_463_2 and not isNil(var_463_0) then
				local var_463_3 = (arg_460_1.time_ - var_463_1) / var_463_2

				if arg_460_1.var_.characterEffect1097ui_story and not isNil(var_463_0) then
					arg_460_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_460_1.time_ >= var_463_1 + var_463_2 and arg_460_1.time_ < var_463_1 + var_463_2 + arg_463_0 and not isNil(var_463_0) and arg_460_1.var_.characterEffect1097ui_story then
				arg_460_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_463_4 = 0

			if var_463_4 < arg_460_1.time_ and arg_460_1.time_ <= var_463_4 + arg_463_0 then
				arg_460_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			local var_463_5 = 0

			if var_463_5 < arg_460_1.time_ and arg_460_1.time_ <= var_463_5 + arg_463_0 then
				arg_460_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_463_6 = 0
			local var_463_7 = 0.525

			if var_463_6 < arg_460_1.time_ and arg_460_1.time_ <= var_463_6 + arg_463_0 then
				arg_460_1.talkMaxDuration = 0
				arg_460_1.dialogCg_.alpha = 1

				arg_460_1.dialog_:SetActive(true)
				SetActive(arg_460_1.leftNameGo_, true)

				local var_463_8 = arg_460_1:FormatText(StoryNameCfg[216].name)

				arg_460_1.leftNameTxt_.text = var_463_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_460_1.leftNameTxt_.transform)

				arg_460_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_460_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_460_1:RecordName(arg_460_1.leftNameTxt_.text)
				SetActive(arg_460_1.iconTrs_.gameObject, false)
				arg_460_1.callingController_:SetSelectedState("normal")

				local var_463_9 = arg_460_1:GetWordFromCfg(1109701113)
				local var_463_10 = arg_460_1:FormatText(var_463_9.content)

				arg_460_1.text_.text = var_463_10

				LuaForUtil.ClearLinePrefixSymbol(arg_460_1.text_)

				local var_463_11 = 21
				local var_463_12 = utf8.len(var_463_10)
				local var_463_13 = var_463_11 <= 0 and var_463_7 or var_463_7 * (var_463_12 / var_463_11)

				if var_463_13 > 0 and var_463_7 < var_463_13 then
					arg_460_1.talkMaxDuration = var_463_13

					if var_463_13 + var_463_6 > arg_460_1.duration_ then
						arg_460_1.duration_ = var_463_13 + var_463_6
					end
				end

				arg_460_1.text_.text = var_463_10
				arg_460_1.typewritter.percent = 0

				arg_460_1.typewritter:SetDirty()
				arg_460_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701113", "story_v_side_new_1109701.awb") ~= 0 then
					local var_463_14 = manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701113", "story_v_side_new_1109701.awb") / 1000

					if var_463_14 + var_463_6 > arg_460_1.duration_ then
						arg_460_1.duration_ = var_463_14 + var_463_6
					end

					if var_463_9.prefab_name ~= "" and arg_460_1.actors_[var_463_9.prefab_name] ~= nil then
						local var_463_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_460_1.actors_[var_463_9.prefab_name].transform, "story_v_side_new_1109701", "1109701113", "story_v_side_new_1109701.awb")

						arg_460_1:RecordAudio("1109701113", var_463_15)
						arg_460_1:RecordAudio("1109701113", var_463_15)
					else
						arg_460_1:AudioAction("play", "voice", "story_v_side_new_1109701", "1109701113", "story_v_side_new_1109701.awb")
					end

					arg_460_1:RecordHistoryTalkVoice("story_v_side_new_1109701", "1109701113", "story_v_side_new_1109701.awb")
				end

				arg_460_1:RecordContent(arg_460_1.text_.text)
			end

			local var_463_16 = math.max(var_463_7, arg_460_1.talkMaxDuration)

			if var_463_6 <= arg_460_1.time_ and arg_460_1.time_ < var_463_6 + var_463_16 then
				arg_460_1.typewritter.percent = (arg_460_1.time_ - var_463_6) / var_463_16

				arg_460_1.typewritter:SetDirty()
			end

			if arg_460_1.time_ >= var_463_6 + var_463_16 and arg_460_1.time_ < var_463_6 + var_463_16 + arg_463_0 then
				arg_460_1.typewritter.percent = 1

				arg_460_1.typewritter:SetDirty()
				arg_460_1:ShowNextGo(true)
			end
		end

		arg_460_1.nodeConfigList_ = {}

		arg_460_1:InitPlayNodeList()
	end,
	Play1109701114 = function(arg_464_0, arg_464_1)
		arg_464_1.time_ = 0
		arg_464_1.frameCnt_ = 0
		arg_464_1.state_ = "playing"
		arg_464_1.curTalkId_ = 1109701114
		arg_464_1.duration_ = 5

		SetActive(arg_464_1.tipsGo_, false)

		function arg_464_1.onSingleLineFinish_()
			arg_464_1.onSingleLineUpdate_ = nil
			arg_464_1.onSingleLineFinish_ = nil
			arg_464_1.state_ = "waiting"
		end

		function arg_464_1.playNext_(arg_466_0)
			if arg_466_0 == 1 then
				arg_464_0:Play1109701115(arg_464_1)
			end
		end

		function arg_464_1.onSingleLineUpdate_(arg_467_0)
			local var_467_0 = arg_464_1.actors_["1097ui_story"]
			local var_467_1 = 0

			if var_467_1 < arg_464_1.time_ and arg_464_1.time_ <= var_467_1 + arg_467_0 and not isNil(var_467_0) and arg_464_1.var_.characterEffect1097ui_story == nil then
				arg_464_1.var_.characterEffect1097ui_story = var_467_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_467_2 = 0.200000002980232

			if var_467_1 <= arg_464_1.time_ and arg_464_1.time_ < var_467_1 + var_467_2 and not isNil(var_467_0) then
				local var_467_3 = (arg_464_1.time_ - var_467_1) / var_467_2

				if arg_464_1.var_.characterEffect1097ui_story and not isNil(var_467_0) then
					local var_467_4 = Mathf.Lerp(0, 0.5, var_467_3)

					arg_464_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_464_1.var_.characterEffect1097ui_story.fillRatio = var_467_4
				end
			end

			if arg_464_1.time_ >= var_467_1 + var_467_2 and arg_464_1.time_ < var_467_1 + var_467_2 + arg_467_0 and not isNil(var_467_0) and arg_464_1.var_.characterEffect1097ui_story then
				local var_467_5 = 0.5

				arg_464_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_464_1.var_.characterEffect1097ui_story.fillRatio = var_467_5
			end

			local var_467_6 = 0
			local var_467_7 = 0.325

			if var_467_6 < arg_464_1.time_ and arg_464_1.time_ <= var_467_6 + arg_467_0 then
				arg_464_1.talkMaxDuration = 0
				arg_464_1.dialogCg_.alpha = 1

				arg_464_1.dialog_:SetActive(true)
				SetActive(arg_464_1.leftNameGo_, true)

				local var_467_8 = arg_464_1:FormatText(StoryNameCfg[7].name)

				arg_464_1.leftNameTxt_.text = var_467_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_464_1.leftNameTxt_.transform)

				arg_464_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_464_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_464_1:RecordName(arg_464_1.leftNameTxt_.text)
				SetActive(arg_464_1.iconTrs_.gameObject, true)
				arg_464_1.iconController_:SetSelectedState("hero")

				arg_464_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_464_1.callingController_:SetSelectedState("normal")

				arg_464_1.keyicon_.color = Color.New(1, 1, 1)
				arg_464_1.icon_.color = Color.New(1, 1, 1)

				local var_467_9 = arg_464_1:GetWordFromCfg(1109701114)
				local var_467_10 = arg_464_1:FormatText(var_467_9.content)

				arg_464_1.text_.text = var_467_10

				LuaForUtil.ClearLinePrefixSymbol(arg_464_1.text_)

				local var_467_11 = 13
				local var_467_12 = utf8.len(var_467_10)
				local var_467_13 = var_467_11 <= 0 and var_467_7 or var_467_7 * (var_467_12 / var_467_11)

				if var_467_13 > 0 and var_467_7 < var_467_13 then
					arg_464_1.talkMaxDuration = var_467_13

					if var_467_13 + var_467_6 > arg_464_1.duration_ then
						arg_464_1.duration_ = var_467_13 + var_467_6
					end
				end

				arg_464_1.text_.text = var_467_10
				arg_464_1.typewritter.percent = 0

				arg_464_1.typewritter:SetDirty()
				arg_464_1:ShowNextGo(false)
				arg_464_1:RecordContent(arg_464_1.text_.text)
			end

			local var_467_14 = math.max(var_467_7, arg_464_1.talkMaxDuration)

			if var_467_6 <= arg_464_1.time_ and arg_464_1.time_ < var_467_6 + var_467_14 then
				arg_464_1.typewritter.percent = (arg_464_1.time_ - var_467_6) / var_467_14

				arg_464_1.typewritter:SetDirty()
			end

			if arg_464_1.time_ >= var_467_6 + var_467_14 and arg_464_1.time_ < var_467_6 + var_467_14 + arg_467_0 then
				arg_464_1.typewritter.percent = 1

				arg_464_1.typewritter:SetDirty()
				arg_464_1:ShowNextGo(true)
			end
		end

		arg_464_1.nodeConfigList_ = {}

		arg_464_1:InitPlayNodeList()
	end,
	Play1109701115 = function(arg_468_0, arg_468_1)
		arg_468_1.time_ = 0
		arg_468_1.frameCnt_ = 0
		arg_468_1.state_ = "playing"
		arg_468_1.curTalkId_ = 1109701115
		arg_468_1.duration_ = 5

		SetActive(arg_468_1.tipsGo_, false)

		function arg_468_1.onSingleLineFinish_()
			arg_468_1.onSingleLineUpdate_ = nil
			arg_468_1.onSingleLineFinish_ = nil
			arg_468_1.state_ = "waiting"
		end

		function arg_468_1.playNext_(arg_470_0)
			if arg_470_0 == 1 then
				arg_468_0:Play1109701116(arg_468_1)
			end
		end

		function arg_468_1.onSingleLineUpdate_(arg_471_0)
			local var_471_0 = 0
			local var_471_1 = 0.8

			if var_471_0 < arg_468_1.time_ and arg_468_1.time_ <= var_471_0 + arg_471_0 then
				arg_468_1.talkMaxDuration = 0
				arg_468_1.dialogCg_.alpha = 1

				arg_468_1.dialog_:SetActive(true)
				SetActive(arg_468_1.leftNameGo_, false)

				arg_468_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_468_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_468_1:RecordName(arg_468_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_468_1.iconTrs_.gameObject, false)
				arg_468_1.callingController_:SetSelectedState("normal")

				local var_471_2 = arg_468_1:GetWordFromCfg(1109701115)
				local var_471_3 = arg_468_1:FormatText(var_471_2.content)

				arg_468_1.text_.text = var_471_3

				LuaForUtil.ClearLinePrefixSymbol(arg_468_1.text_)

				local var_471_4 = 32
				local var_471_5 = utf8.len(var_471_3)
				local var_471_6 = var_471_4 <= 0 and var_471_1 or var_471_1 * (var_471_5 / var_471_4)

				if var_471_6 > 0 and var_471_1 < var_471_6 then
					arg_468_1.talkMaxDuration = var_471_6

					if var_471_6 + var_471_0 > arg_468_1.duration_ then
						arg_468_1.duration_ = var_471_6 + var_471_0
					end
				end

				arg_468_1.text_.text = var_471_3
				arg_468_1.typewritter.percent = 0

				arg_468_1.typewritter:SetDirty()
				arg_468_1:ShowNextGo(false)
				arg_468_1:RecordContent(arg_468_1.text_.text)
			end

			local var_471_7 = math.max(var_471_1, arg_468_1.talkMaxDuration)

			if var_471_0 <= arg_468_1.time_ and arg_468_1.time_ < var_471_0 + var_471_7 then
				arg_468_1.typewritter.percent = (arg_468_1.time_ - var_471_0) / var_471_7

				arg_468_1.typewritter:SetDirty()
			end

			if arg_468_1.time_ >= var_471_0 + var_471_7 and arg_468_1.time_ < var_471_0 + var_471_7 + arg_471_0 then
				arg_468_1.typewritter.percent = 1

				arg_468_1.typewritter:SetDirty()
				arg_468_1:ShowNextGo(true)
			end
		end

		arg_468_1.nodeConfigList_ = {}

		arg_468_1:InitPlayNodeList()
	end,
	Play1109701116 = function(arg_472_0, arg_472_1)
		arg_472_1.time_ = 0
		arg_472_1.frameCnt_ = 0
		arg_472_1.state_ = "playing"
		arg_472_1.curTalkId_ = 1109701116
		arg_472_1.duration_ = 4

		local var_472_0 = {
			zh = 3.1,
			ja = 4
		}
		local var_472_1 = manager.audio:GetLocalizationFlag()

		if var_472_0[var_472_1] ~= nil then
			arg_472_1.duration_ = var_472_0[var_472_1]
		end

		SetActive(arg_472_1.tipsGo_, false)

		function arg_472_1.onSingleLineFinish_()
			arg_472_1.onSingleLineUpdate_ = nil
			arg_472_1.onSingleLineFinish_ = nil
			arg_472_1.state_ = "waiting"
		end

		function arg_472_1.playNext_(arg_474_0)
			if arg_474_0 == 1 then
				arg_472_0:Play1109701117(arg_472_1)
			end
		end

		function arg_472_1.onSingleLineUpdate_(arg_475_0)
			local var_475_0 = arg_472_1.actors_["1097ui_story"].transform
			local var_475_1 = 0

			if var_475_1 < arg_472_1.time_ and arg_472_1.time_ <= var_475_1 + arg_475_0 then
				arg_472_1.var_.moveOldPos1097ui_story = var_475_0.localPosition
			end

			local var_475_2 = 0.001

			if var_475_1 <= arg_472_1.time_ and arg_472_1.time_ < var_475_1 + var_475_2 then
				local var_475_3 = (arg_472_1.time_ - var_475_1) / var_475_2
				local var_475_4 = Vector3.New(0, -0.54, -6.3)

				var_475_0.localPosition = Vector3.Lerp(arg_472_1.var_.moveOldPos1097ui_story, var_475_4, var_475_3)

				local var_475_5 = manager.ui.mainCamera.transform.position - var_475_0.position

				var_475_0.forward = Vector3.New(var_475_5.x, var_475_5.y, var_475_5.z)

				local var_475_6 = var_475_0.localEulerAngles

				var_475_6.z = 0
				var_475_6.x = 0
				var_475_0.localEulerAngles = var_475_6
			end

			if arg_472_1.time_ >= var_475_1 + var_475_2 and arg_472_1.time_ < var_475_1 + var_475_2 + arg_475_0 then
				var_475_0.localPosition = Vector3.New(0, -0.54, -6.3)

				local var_475_7 = manager.ui.mainCamera.transform.position - var_475_0.position

				var_475_0.forward = Vector3.New(var_475_7.x, var_475_7.y, var_475_7.z)

				local var_475_8 = var_475_0.localEulerAngles

				var_475_8.z = 0
				var_475_8.x = 0
				var_475_0.localEulerAngles = var_475_8
			end

			local var_475_9 = arg_472_1.actors_["1097ui_story"]
			local var_475_10 = 0

			if var_475_10 < arg_472_1.time_ and arg_472_1.time_ <= var_475_10 + arg_475_0 and not isNil(var_475_9) and arg_472_1.var_.characterEffect1097ui_story == nil then
				arg_472_1.var_.characterEffect1097ui_story = var_475_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_475_11 = 0.200000002980232

			if var_475_10 <= arg_472_1.time_ and arg_472_1.time_ < var_475_10 + var_475_11 and not isNil(var_475_9) then
				local var_475_12 = (arg_472_1.time_ - var_475_10) / var_475_11

				if arg_472_1.var_.characterEffect1097ui_story and not isNil(var_475_9) then
					arg_472_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_472_1.time_ >= var_475_10 + var_475_11 and arg_472_1.time_ < var_475_10 + var_475_11 + arg_475_0 and not isNil(var_475_9) and arg_472_1.var_.characterEffect1097ui_story then
				arg_472_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_475_13 = 0

			if var_475_13 < arg_472_1.time_ and arg_472_1.time_ <= var_475_13 + arg_475_0 then
				arg_472_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			local var_475_14 = 0

			if var_475_14 < arg_472_1.time_ and arg_472_1.time_ <= var_475_14 + arg_475_0 then
				arg_472_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_475_15 = 0
			local var_475_16 = 0.45

			if var_475_15 < arg_472_1.time_ and arg_472_1.time_ <= var_475_15 + arg_475_0 then
				arg_472_1.talkMaxDuration = 0
				arg_472_1.dialogCg_.alpha = 1

				arg_472_1.dialog_:SetActive(true)
				SetActive(arg_472_1.leftNameGo_, true)

				local var_475_17 = arg_472_1:FormatText(StoryNameCfg[216].name)

				arg_472_1.leftNameTxt_.text = var_475_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_472_1.leftNameTxt_.transform)

				arg_472_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_472_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_472_1:RecordName(arg_472_1.leftNameTxt_.text)
				SetActive(arg_472_1.iconTrs_.gameObject, false)
				arg_472_1.callingController_:SetSelectedState("normal")

				local var_475_18 = arg_472_1:GetWordFromCfg(1109701116)
				local var_475_19 = arg_472_1:FormatText(var_475_18.content)

				arg_472_1.text_.text = var_475_19

				LuaForUtil.ClearLinePrefixSymbol(arg_472_1.text_)

				local var_475_20 = 18
				local var_475_21 = utf8.len(var_475_19)
				local var_475_22 = var_475_20 <= 0 and var_475_16 or var_475_16 * (var_475_21 / var_475_20)

				if var_475_22 > 0 and var_475_16 < var_475_22 then
					arg_472_1.talkMaxDuration = var_475_22

					if var_475_22 + var_475_15 > arg_472_1.duration_ then
						arg_472_1.duration_ = var_475_22 + var_475_15
					end
				end

				arg_472_1.text_.text = var_475_19
				arg_472_1.typewritter.percent = 0

				arg_472_1.typewritter:SetDirty()
				arg_472_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701116", "story_v_side_new_1109701.awb") ~= 0 then
					local var_475_23 = manager.audio:GetVoiceLength("story_v_side_new_1109701", "1109701116", "story_v_side_new_1109701.awb") / 1000

					if var_475_23 + var_475_15 > arg_472_1.duration_ then
						arg_472_1.duration_ = var_475_23 + var_475_15
					end

					if var_475_18.prefab_name ~= "" and arg_472_1.actors_[var_475_18.prefab_name] ~= nil then
						local var_475_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_472_1.actors_[var_475_18.prefab_name].transform, "story_v_side_new_1109701", "1109701116", "story_v_side_new_1109701.awb")

						arg_472_1:RecordAudio("1109701116", var_475_24)
						arg_472_1:RecordAudio("1109701116", var_475_24)
					else
						arg_472_1:AudioAction("play", "voice", "story_v_side_new_1109701", "1109701116", "story_v_side_new_1109701.awb")
					end

					arg_472_1:RecordHistoryTalkVoice("story_v_side_new_1109701", "1109701116", "story_v_side_new_1109701.awb")
				end

				arg_472_1:RecordContent(arg_472_1.text_.text)
			end

			local var_475_25 = math.max(var_475_16, arg_472_1.talkMaxDuration)

			if var_475_15 <= arg_472_1.time_ and arg_472_1.time_ < var_475_15 + var_475_25 then
				arg_472_1.typewritter.percent = (arg_472_1.time_ - var_475_15) / var_475_25

				arg_472_1.typewritter:SetDirty()
			end

			if arg_472_1.time_ >= var_475_15 + var_475_25 and arg_472_1.time_ < var_475_15 + var_475_25 + arg_475_0 then
				arg_472_1.typewritter.percent = 1

				arg_472_1.typewritter:SetDirty()
				arg_472_1:ShowNextGo(true)
			end
		end

		arg_472_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_472_1:InitPlayNodeList()
	end,
	Play1109701117 = function(arg_476_0, arg_476_1)
		arg_476_1.time_ = 0
		arg_476_1.frameCnt_ = 0
		arg_476_1.state_ = "playing"
		arg_476_1.curTalkId_ = 1109701117
		arg_476_1.duration_ = 5

		SetActive(arg_476_1.tipsGo_, false)

		function arg_476_1.onSingleLineFinish_()
			arg_476_1.onSingleLineUpdate_ = nil
			arg_476_1.onSingleLineFinish_ = nil
			arg_476_1.state_ = "waiting"
		end

		function arg_476_1.playNext_(arg_478_0)
			if arg_478_0 == 1 then
				arg_476_0:Play1109701118(arg_476_1)
			end
		end

		function arg_476_1.onSingleLineUpdate_(arg_479_0)
			local var_479_0 = arg_476_1.actors_["1097ui_story"]
			local var_479_1 = 0

			if var_479_1 < arg_476_1.time_ and arg_476_1.time_ <= var_479_1 + arg_479_0 and not isNil(var_479_0) and arg_476_1.var_.characterEffect1097ui_story == nil then
				arg_476_1.var_.characterEffect1097ui_story = var_479_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_479_2 = 0.200000002980232

			if var_479_1 <= arg_476_1.time_ and arg_476_1.time_ < var_479_1 + var_479_2 and not isNil(var_479_0) then
				local var_479_3 = (arg_476_1.time_ - var_479_1) / var_479_2

				if arg_476_1.var_.characterEffect1097ui_story and not isNil(var_479_0) then
					local var_479_4 = Mathf.Lerp(0, 0.5, var_479_3)

					arg_476_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_476_1.var_.characterEffect1097ui_story.fillRatio = var_479_4
				end
			end

			if arg_476_1.time_ >= var_479_1 + var_479_2 and arg_476_1.time_ < var_479_1 + var_479_2 + arg_479_0 and not isNil(var_479_0) and arg_476_1.var_.characterEffect1097ui_story then
				local var_479_5 = 0.5

				arg_476_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_476_1.var_.characterEffect1097ui_story.fillRatio = var_479_5
			end

			local var_479_6 = 0
			local var_479_7 = 0.075

			if var_479_6 < arg_476_1.time_ and arg_476_1.time_ <= var_479_6 + arg_479_0 then
				arg_476_1.talkMaxDuration = 0
				arg_476_1.dialogCg_.alpha = 1

				arg_476_1.dialog_:SetActive(true)
				SetActive(arg_476_1.leftNameGo_, true)

				local var_479_8 = arg_476_1:FormatText(StoryNameCfg[7].name)

				arg_476_1.leftNameTxt_.text = var_479_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_476_1.leftNameTxt_.transform)

				arg_476_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_476_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_476_1:RecordName(arg_476_1.leftNameTxt_.text)
				SetActive(arg_476_1.iconTrs_.gameObject, true)
				arg_476_1.iconController_:SetSelectedState("hero")

				arg_476_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_476_1.callingController_:SetSelectedState("normal")

				arg_476_1.keyicon_.color = Color.New(1, 1, 1)
				arg_476_1.icon_.color = Color.New(1, 1, 1)

				local var_479_9 = arg_476_1:GetWordFromCfg(1109701117)
				local var_479_10 = arg_476_1:FormatText(var_479_9.content)

				arg_476_1.text_.text = var_479_10

				LuaForUtil.ClearLinePrefixSymbol(arg_476_1.text_)

				local var_479_11 = 3
				local var_479_12 = utf8.len(var_479_10)
				local var_479_13 = var_479_11 <= 0 and var_479_7 or var_479_7 * (var_479_12 / var_479_11)

				if var_479_13 > 0 and var_479_7 < var_479_13 then
					arg_476_1.talkMaxDuration = var_479_13

					if var_479_13 + var_479_6 > arg_476_1.duration_ then
						arg_476_1.duration_ = var_479_13 + var_479_6
					end
				end

				arg_476_1.text_.text = var_479_10
				arg_476_1.typewritter.percent = 0

				arg_476_1.typewritter:SetDirty()
				arg_476_1:ShowNextGo(false)
				arg_476_1:RecordContent(arg_476_1.text_.text)
			end

			local var_479_14 = math.max(var_479_7, arg_476_1.talkMaxDuration)

			if var_479_6 <= arg_476_1.time_ and arg_476_1.time_ < var_479_6 + var_479_14 then
				arg_476_1.typewritter.percent = (arg_476_1.time_ - var_479_6) / var_479_14

				arg_476_1.typewritter:SetDirty()
			end

			if arg_476_1.time_ >= var_479_6 + var_479_14 and arg_476_1.time_ < var_479_6 + var_479_14 + arg_479_0 then
				arg_476_1.typewritter.percent = 1

				arg_476_1.typewritter:SetDirty()
				arg_476_1:ShowNextGo(true)
			end
		end

		arg_476_1.nodeConfigList_ = {}

		arg_476_1:InitPlayNodeList()
	end,
	Play1109701118 = function(arg_480_0, arg_480_1)
		arg_480_1.time_ = 0
		arg_480_1.frameCnt_ = 0
		arg_480_1.state_ = "playing"
		arg_480_1.curTalkId_ = 1109701118
		arg_480_1.duration_ = 5

		SetActive(arg_480_1.tipsGo_, false)

		function arg_480_1.onSingleLineFinish_()
			arg_480_1.onSingleLineUpdate_ = nil
			arg_480_1.onSingleLineFinish_ = nil
			arg_480_1.state_ = "waiting"
			arg_480_1.auto_ = false
		end

		function arg_480_1.playNext_(arg_482_0)
			arg_480_1.onStoryFinished_()
		end

		function arg_480_1.onSingleLineUpdate_(arg_483_0)
			local var_483_0 = 0
			local var_483_1 = 0.7

			if var_483_0 < arg_480_1.time_ and arg_480_1.time_ <= var_483_0 + arg_483_0 then
				arg_480_1.talkMaxDuration = 0
				arg_480_1.dialogCg_.alpha = 1

				arg_480_1.dialog_:SetActive(true)
				SetActive(arg_480_1.leftNameGo_, false)

				arg_480_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_480_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_480_1:RecordName(arg_480_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_480_1.iconTrs_.gameObject, false)
				arg_480_1.callingController_:SetSelectedState("normal")

				local var_483_2 = arg_480_1:GetWordFromCfg(1109701118)
				local var_483_3 = arg_480_1:FormatText(var_483_2.content)

				arg_480_1.text_.text = var_483_3

				LuaForUtil.ClearLinePrefixSymbol(arg_480_1.text_)

				local var_483_4 = 28
				local var_483_5 = utf8.len(var_483_3)
				local var_483_6 = var_483_4 <= 0 and var_483_1 or var_483_1 * (var_483_5 / var_483_4)

				if var_483_6 > 0 and var_483_1 < var_483_6 then
					arg_480_1.talkMaxDuration = var_483_6

					if var_483_6 + var_483_0 > arg_480_1.duration_ then
						arg_480_1.duration_ = var_483_6 + var_483_0
					end
				end

				arg_480_1.text_.text = var_483_3
				arg_480_1.typewritter.percent = 0

				arg_480_1.typewritter:SetDirty()
				arg_480_1:ShowNextGo(false)
				arg_480_1:RecordContent(arg_480_1.text_.text)
			end

			local var_483_7 = math.max(var_483_1, arg_480_1.talkMaxDuration)

			if var_483_0 <= arg_480_1.time_ and arg_480_1.time_ < var_483_0 + var_483_7 then
				arg_480_1.typewritter.percent = (arg_480_1.time_ - var_483_0) / var_483_7

				arg_480_1.typewritter:SetDirty()
			end

			if arg_480_1.time_ >= var_483_0 + var_483_7 and arg_480_1.time_ < var_483_0 + var_483_7 + arg_483_0 then
				arg_480_1.typewritter.percent = 1

				arg_480_1.typewritter:SetDirty()
				arg_480_1:ShowNextGo(true)
			end
		end

		arg_480_1.nodeConfigList_ = {}

		arg_480_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST12",
		"TextureConfig/Background/ST01",
		"TextureConfig/Background/F01"
	},
	voices = {
		"story_v_side_new_1109701.awb"
	}
}
