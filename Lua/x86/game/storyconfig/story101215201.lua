return {
	Play121521001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 121521001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play121521002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "J12f"

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
				local var_4_5 = arg_1_1.bgs_.J12f

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
					if iter_4_0 ~= "J12f" then
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

			local var_4_22 = "1029ui_story"

			if arg_1_1.actors_[var_4_22] == nil then
				local var_4_23 = Asset.Load("Char/" .. "1029ui_story")

				if not isNil(var_4_23) then
					local var_4_24 = Object.Instantiate(Asset.Load("Char/" .. "1029ui_story"), arg_1_1.stage_.transform)

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

			local var_4_27 = arg_1_1.actors_["1029ui_story"].transform
			local var_4_28 = 1.8

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				arg_1_1.var_.moveOldPos1029ui_story = var_4_27.localPosition
			end

			local var_4_29 = 0.001

			if var_4_28 <= arg_1_1.time_ and arg_1_1.time_ < var_4_28 + var_4_29 then
				local var_4_30 = (arg_1_1.time_ - var_4_28) / var_4_29
				local var_4_31 = Vector3.New(-0.7, -1.09, -6.2)

				var_4_27.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1029ui_story, var_4_31, var_4_30)

				local var_4_32 = manager.ui.mainCamera.transform.position - var_4_27.position

				var_4_27.forward = Vector3.New(var_4_32.x, var_4_32.y, var_4_32.z)

				local var_4_33 = var_4_27.localEulerAngles

				var_4_33.z = 0
				var_4_33.x = 0
				var_4_27.localEulerAngles = var_4_33
			end

			if arg_1_1.time_ >= var_4_28 + var_4_29 and arg_1_1.time_ < var_4_28 + var_4_29 + arg_4_0 then
				var_4_27.localPosition = Vector3.New(-0.7, -1.09, -6.2)

				local var_4_34 = manager.ui.mainCamera.transform.position - var_4_27.position

				var_4_27.forward = Vector3.New(var_4_34.x, var_4_34.y, var_4_34.z)

				local var_4_35 = var_4_27.localEulerAngles

				var_4_35.z = 0
				var_4_35.x = 0
				var_4_27.localEulerAngles = var_4_35
			end

			local var_4_36 = arg_1_1.actors_["1029ui_story"]
			local var_4_37 = 1.8

			if var_4_37 < arg_1_1.time_ and arg_1_1.time_ <= var_4_37 + arg_4_0 and not isNil(var_4_36) and arg_1_1.var_.characterEffect1029ui_story == nil then
				arg_1_1.var_.characterEffect1029ui_story = var_4_36:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_38 = 0.200000002980232

			if var_4_37 <= arg_1_1.time_ and arg_1_1.time_ < var_4_37 + var_4_38 and not isNil(var_4_36) then
				local var_4_39 = (arg_1_1.time_ - var_4_37) / var_4_38

				if arg_1_1.var_.characterEffect1029ui_story and not isNil(var_4_36) then
					local var_4_40 = Mathf.Lerp(0, 0.5, var_4_39)

					arg_1_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_1_1.var_.characterEffect1029ui_story.fillRatio = var_4_40
				end
			end

			if arg_1_1.time_ >= var_4_37 + var_4_38 and arg_1_1.time_ < var_4_37 + var_4_38 + arg_4_0 and not isNil(var_4_36) and arg_1_1.var_.characterEffect1029ui_story then
				local var_4_41 = 0.5

				arg_1_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_1_1.var_.characterEffect1029ui_story.fillRatio = var_4_41
			end

			local var_4_42 = "1084ui_story"

			if arg_1_1.actors_[var_4_42] == nil then
				local var_4_43 = Asset.Load("Char/" .. "1084ui_story")

				if not isNil(var_4_43) then
					local var_4_44 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_1_1.stage_.transform)

					var_4_44.name = var_4_42
					var_4_44.transform.localPosition = Vector3.New(0, 100, 0)
					arg_1_1.actors_[var_4_42] = var_4_44

					local var_4_45 = var_4_44:GetComponentInChildren(typeof(CharacterEffect))

					var_4_45.enabled = true

					local var_4_46 = GameObjectTools.GetOrAddComponent(var_4_44, typeof(DynamicBoneHelper))

					if var_4_46 then
						var_4_46:EnableDynamicBone(false)
					end

					arg_1_1:ShowWeapon(var_4_45.transform, false)

					arg_1_1.var_[var_4_42 .. "Animator"] = var_4_45.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_1_1.var_[var_4_42 .. "Animator"].applyRootMotion = true
					arg_1_1.var_[var_4_42 .. "LipSync"] = var_4_45.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_4_47 = arg_1_1.actors_["1084ui_story"].transform
			local var_4_48 = 1.8

			if var_4_48 < arg_1_1.time_ and arg_1_1.time_ <= var_4_48 + arg_4_0 then
				arg_1_1.var_.moveOldPos1084ui_story = var_4_47.localPosition
			end

			local var_4_49 = 0.001

			if var_4_48 <= arg_1_1.time_ and arg_1_1.time_ < var_4_48 + var_4_49 then
				local var_4_50 = (arg_1_1.time_ - var_4_48) / var_4_49
				local var_4_51 = Vector3.New(0.7, -0.97, -6)

				var_4_47.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1084ui_story, var_4_51, var_4_50)

				local var_4_52 = manager.ui.mainCamera.transform.position - var_4_47.position

				var_4_47.forward = Vector3.New(var_4_52.x, var_4_52.y, var_4_52.z)

				local var_4_53 = var_4_47.localEulerAngles

				var_4_53.z = 0
				var_4_53.x = 0
				var_4_47.localEulerAngles = var_4_53
			end

			if arg_1_1.time_ >= var_4_48 + var_4_49 and arg_1_1.time_ < var_4_48 + var_4_49 + arg_4_0 then
				var_4_47.localPosition = Vector3.New(0.7, -0.97, -6)

				local var_4_54 = manager.ui.mainCamera.transform.position - var_4_47.position

				var_4_47.forward = Vector3.New(var_4_54.x, var_4_54.y, var_4_54.z)

				local var_4_55 = var_4_47.localEulerAngles

				var_4_55.z = 0
				var_4_55.x = 0
				var_4_47.localEulerAngles = var_4_55
			end

			local var_4_56 = arg_1_1.actors_["1084ui_story"]
			local var_4_57 = 1.8

			if var_4_57 < arg_1_1.time_ and arg_1_1.time_ <= var_4_57 + arg_4_0 and not isNil(var_4_56) and arg_1_1.var_.characterEffect1084ui_story == nil then
				arg_1_1.var_.characterEffect1084ui_story = var_4_56:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_58 = 0.200000002980232

			if var_4_57 <= arg_1_1.time_ and arg_1_1.time_ < var_4_57 + var_4_58 and not isNil(var_4_56) then
				local var_4_59 = (arg_1_1.time_ - var_4_57) / var_4_58

				if arg_1_1.var_.characterEffect1084ui_story and not isNil(var_4_56) then
					local var_4_60 = Mathf.Lerp(0, 0.5, var_4_59)

					arg_1_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_1_1.var_.characterEffect1084ui_story.fillRatio = var_4_60
				end
			end

			if arg_1_1.time_ >= var_4_57 + var_4_58 and arg_1_1.time_ < var_4_57 + var_4_58 + arg_4_0 and not isNil(var_4_56) and arg_1_1.var_.characterEffect1084ui_story then
				local var_4_61 = 0.5

				arg_1_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_1_1.var_.characterEffect1084ui_story.fillRatio = var_4_61
			end

			local var_4_62 = 1.8

			if var_4_62 < arg_1_1.time_ and arg_1_1.time_ <= var_4_62 + arg_4_0 then
				arg_1_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action1_1")
			end

			local var_4_63 = 1.8

			if var_4_63 < arg_1_1.time_ and arg_1_1.time_ <= var_4_63 + arg_4_0 then
				arg_1_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_4_64 = 1.8

			if var_4_64 < arg_1_1.time_ and arg_1_1.time_ <= var_4_64 + arg_4_0 then
				arg_1_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_4_65 = 0
			local var_4_66 = 0.1

			if var_4_65 < arg_1_1.time_ and arg_1_1.time_ <= var_4_65 + arg_4_0 then
				local var_4_67 = "play"
				local var_4_68 = "music"

				arg_1_1:AudioAction(var_4_67, var_4_68, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_69 = ""
				local var_4_70 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_70 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_70 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_70

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_70
						arg_1_1.bgmTxt2_.text = var_4_70
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

			local var_4_71 = 0.266666666666667
			local var_4_72 = 1

			if var_4_71 < arg_1_1.time_ and arg_1_1.time_ <= var_4_71 + arg_4_0 then
				local var_4_73 = "play"
				local var_4_74 = "music"

				arg_1_1:AudioAction(var_4_73, var_4_74, "bgm_story_v1_battleground_2", "bgm_story_v1_battleground_2", "bgm_story_v1_battleground_2.awb")

				local var_4_75 = ""
				local var_4_76 = manager.audio:GetAudioName("bgm_story_v1_battleground_2", "bgm_story_v1_battleground_2")

				if var_4_76 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_76 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_76

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_76
						arg_1_1.bgmTxt2_.text = var_4_76
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

			local var_4_77 = 2
			local var_4_78 = 0.725

			if var_4_77 < arg_1_1.time_ and arg_1_1.time_ <= var_4_77 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_79 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_79:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_79:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_79:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_80 = arg_1_1:FormatText(StoryNameCfg[7].name)

				arg_1_1.leftNameTxt_.text = var_4_80

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_81 = arg_1_1:GetWordFromCfg(121521001)
				local var_4_82 = arg_1_1:FormatText(var_4_81.content)

				arg_1_1.text_.text = var_4_82

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_83 = 29
				local var_4_84 = utf8.len(var_4_82)
				local var_4_85 = var_4_83 <= 0 and var_4_78 or var_4_78 * (var_4_84 / var_4_83)

				if var_4_85 > 0 and var_4_78 < var_4_85 then
					arg_1_1.talkMaxDuration = var_4_85
					var_4_77 = var_4_77 + 0.3

					if var_4_85 + var_4_77 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_85 + var_4_77
					end
				end

				arg_1_1.text_.text = var_4_82
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_86 = var_4_77 + 0.3
			local var_4_87 = math.max(var_4_78, arg_1_1.talkMaxDuration)

			if var_4_86 <= arg_1_1.time_ and arg_1_1.time_ < var_4_86 + var_4_87 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_86) / var_4_87

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_86 + var_4_87 and arg_1_1.time_ < var_4_86 + var_4_87 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1029ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
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
	Play121521002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 121521002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play121521003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0
			local var_12_1 = 1.625

			if var_12_0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, false)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_2 = arg_9_1:GetWordFromCfg(121521002)
				local var_12_3 = arg_9_1:FormatText(var_12_2.content)

				arg_9_1.text_.text = var_12_3

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_4 = 65
				local var_12_5 = utf8.len(var_12_3)
				local var_12_6 = var_12_4 <= 0 and var_12_1 or var_12_1 * (var_12_5 / var_12_4)

				if var_12_6 > 0 and var_12_1 < var_12_6 then
					arg_9_1.talkMaxDuration = var_12_6

					if var_12_6 + var_12_0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_6 + var_12_0
					end
				end

				arg_9_1.text_.text = var_12_3
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_7 = math.max(var_12_1, arg_9_1.talkMaxDuration)

			if var_12_0 <= arg_9_1.time_ and arg_9_1.time_ < var_12_0 + var_12_7 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_0) / var_12_7

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_0 + var_12_7 and arg_9_1.time_ < var_12_0 + var_12_7 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play121521003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 121521003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play121521004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0
			local var_16_1 = 0.85

			if var_16_0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, false)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_2 = arg_13_1:GetWordFromCfg(121521003)
				local var_16_3 = arg_13_1:FormatText(var_16_2.content)

				arg_13_1.text_.text = var_16_3

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_4 = 34
				local var_16_5 = utf8.len(var_16_3)
				local var_16_6 = var_16_4 <= 0 and var_16_1 or var_16_1 * (var_16_5 / var_16_4)

				if var_16_6 > 0 and var_16_1 < var_16_6 then
					arg_13_1.talkMaxDuration = var_16_6

					if var_16_6 + var_16_0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_6 + var_16_0
					end
				end

				arg_13_1.text_.text = var_16_3
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_7 = math.max(var_16_1, arg_13_1.talkMaxDuration)

			if var_16_0 <= arg_13_1.time_ and arg_13_1.time_ < var_16_0 + var_16_7 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_0) / var_16_7

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_0 + var_16_7 and arg_13_1.time_ < var_16_0 + var_16_7 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play121521004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 121521004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play121521005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0
			local var_20_1 = 0.7

			if var_20_0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_0 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, false)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_2 = arg_17_1:GetWordFromCfg(121521004)
				local var_20_3 = arg_17_1:FormatText(var_20_2.content)

				arg_17_1.text_.text = var_20_3

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_4 = 28
				local var_20_5 = utf8.len(var_20_3)
				local var_20_6 = var_20_4 <= 0 and var_20_1 or var_20_1 * (var_20_5 / var_20_4)

				if var_20_6 > 0 and var_20_1 < var_20_6 then
					arg_17_1.talkMaxDuration = var_20_6

					if var_20_6 + var_20_0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_6 + var_20_0
					end
				end

				arg_17_1.text_.text = var_20_3
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_7 = math.max(var_20_1, arg_17_1.talkMaxDuration)

			if var_20_0 <= arg_17_1.time_ and arg_17_1.time_ < var_20_0 + var_20_7 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_0) / var_20_7

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_0 + var_20_7 and arg_17_1.time_ < var_20_0 + var_20_7 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play121521005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 121521005
		arg_21_1.duration_ = 3.17

		local var_21_0 = {
			ja = 3.166,
			ko = 1.999999999999,
			zh = 1.999999999999
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
				arg_21_0:Play121521006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = arg_21_1.actors_["1029ui_story"]
			local var_24_1 = 0

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.characterEffect1029ui_story == nil then
				arg_21_1.var_.characterEffect1029ui_story = var_24_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_2 = 0.200000002980232

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_2 and not isNil(var_24_0) then
				local var_24_3 = (arg_21_1.time_ - var_24_1) / var_24_2

				if arg_21_1.var_.characterEffect1029ui_story and not isNil(var_24_0) then
					arg_21_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= var_24_1 + var_24_2 and arg_21_1.time_ < var_24_1 + var_24_2 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.characterEffect1029ui_story then
				arg_21_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_24_4 = 0

			if var_24_4 < arg_21_1.time_ and arg_21_1.time_ <= var_24_4 + arg_24_0 then
				arg_21_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action1_1")
			end

			local var_24_5 = 0

			if var_24_5 < arg_21_1.time_ and arg_21_1.time_ <= var_24_5 + arg_24_0 then
				arg_21_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_24_6 = 0
			local var_24_7 = 0.075

			if var_24_6 < arg_21_1.time_ and arg_21_1.time_ <= var_24_6 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_8 = arg_21_1:FormatText(StoryNameCfg[319].name)

				arg_21_1.leftNameTxt_.text = var_24_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_9 = arg_21_1:GetWordFromCfg(121521005)
				local var_24_10 = arg_21_1:FormatText(var_24_9.content)

				arg_21_1.text_.text = var_24_10

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_11 = 3
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

				if manager.audio:GetVoiceLength("story_v_out_121521", "121521005", "story_v_out_121521.awb") ~= 0 then
					local var_24_14 = manager.audio:GetVoiceLength("story_v_out_121521", "121521005", "story_v_out_121521.awb") / 1000

					if var_24_14 + var_24_6 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_14 + var_24_6
					end

					if var_24_9.prefab_name ~= "" and arg_21_1.actors_[var_24_9.prefab_name] ~= nil then
						local var_24_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_9.prefab_name].transform, "story_v_out_121521", "121521005", "story_v_out_121521.awb")

						arg_21_1:RecordAudio("121521005", var_24_15)
						arg_21_1:RecordAudio("121521005", var_24_15)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_121521", "121521005", "story_v_out_121521.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_121521", "121521005", "story_v_out_121521.awb")
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
	Play121521006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 121521006
		arg_25_1.duration_ = 11.6

		local var_25_0 = {
			ja = 11.6,
			ko = 7.7,
			zh = 7.7
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
				arg_25_0:Play121521007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = arg_25_1.actors_["1084ui_story"]
			local var_28_1 = 0

			if var_28_1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.characterEffect1084ui_story == nil then
				arg_25_1.var_.characterEffect1084ui_story = var_28_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_2 = 0.200000002980232

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_2 and not isNil(var_28_0) then
				local var_28_3 = (arg_25_1.time_ - var_28_1) / var_28_2

				if arg_25_1.var_.characterEffect1084ui_story and not isNil(var_28_0) then
					arg_25_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= var_28_1 + var_28_2 and arg_25_1.time_ < var_28_1 + var_28_2 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.characterEffect1084ui_story then
				arg_25_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_28_4 = 0

			if var_28_4 < arg_25_1.time_ and arg_25_1.time_ <= var_28_4 + arg_28_0 then
				arg_25_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			local var_28_5 = arg_25_1.actors_["1029ui_story"]
			local var_28_6 = 0

			if var_28_6 < arg_25_1.time_ and arg_25_1.time_ <= var_28_6 + arg_28_0 and not isNil(var_28_5) and arg_25_1.var_.characterEffect1029ui_story == nil then
				arg_25_1.var_.characterEffect1029ui_story = var_28_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_7 = 0.200000002980232

			if var_28_6 <= arg_25_1.time_ and arg_25_1.time_ < var_28_6 + var_28_7 and not isNil(var_28_5) then
				local var_28_8 = (arg_25_1.time_ - var_28_6) / var_28_7

				if arg_25_1.var_.characterEffect1029ui_story and not isNil(var_28_5) then
					local var_28_9 = Mathf.Lerp(0, 0.5, var_28_8)

					arg_25_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_25_1.var_.characterEffect1029ui_story.fillRatio = var_28_9
				end
			end

			if arg_25_1.time_ >= var_28_6 + var_28_7 and arg_25_1.time_ < var_28_6 + var_28_7 + arg_28_0 and not isNil(var_28_5) and arg_25_1.var_.characterEffect1029ui_story then
				local var_28_10 = 0.5

				arg_25_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_25_1.var_.characterEffect1029ui_story.fillRatio = var_28_10
			end

			local var_28_11 = 0
			local var_28_12 = 0.8

			if var_28_11 < arg_25_1.time_ and arg_25_1.time_ <= var_28_11 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_13 = arg_25_1:FormatText(StoryNameCfg[6].name)

				arg_25_1.leftNameTxt_.text = var_28_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_14 = arg_25_1:GetWordFromCfg(121521006)
				local var_28_15 = arg_25_1:FormatText(var_28_14.content)

				arg_25_1.text_.text = var_28_15

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_16 = 32
				local var_28_17 = utf8.len(var_28_15)
				local var_28_18 = var_28_16 <= 0 and var_28_12 or var_28_12 * (var_28_17 / var_28_16)

				if var_28_18 > 0 and var_28_12 < var_28_18 then
					arg_25_1.talkMaxDuration = var_28_18

					if var_28_18 + var_28_11 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_18 + var_28_11
					end
				end

				arg_25_1.text_.text = var_28_15
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121521", "121521006", "story_v_out_121521.awb") ~= 0 then
					local var_28_19 = manager.audio:GetVoiceLength("story_v_out_121521", "121521006", "story_v_out_121521.awb") / 1000

					if var_28_19 + var_28_11 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_19 + var_28_11
					end

					if var_28_14.prefab_name ~= "" and arg_25_1.actors_[var_28_14.prefab_name] ~= nil then
						local var_28_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_14.prefab_name].transform, "story_v_out_121521", "121521006", "story_v_out_121521.awb")

						arg_25_1:RecordAudio("121521006", var_28_20)
						arg_25_1:RecordAudio("121521006", var_28_20)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_121521", "121521006", "story_v_out_121521.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_121521", "121521006", "story_v_out_121521.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_21 = math.max(var_28_12, arg_25_1.talkMaxDuration)

			if var_28_11 <= arg_25_1.time_ and arg_25_1.time_ < var_28_11 + var_28_21 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_11) / var_28_21

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_11 + var_28_21 and arg_25_1.time_ < var_28_11 + var_28_21 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play121521007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 121521007
		arg_29_1.duration_ = 10.93

		local var_29_0 = {
			ja = 10.933,
			ko = 6.333,
			zh = 6.333
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
				arg_29_0:Play121521008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = arg_29_1.actors_["1029ui_story"]
			local var_32_1 = 0

			if var_32_1 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.characterEffect1029ui_story == nil then
				arg_29_1.var_.characterEffect1029ui_story = var_32_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_2 = 0.200000002980232

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_2 and not isNil(var_32_0) then
				local var_32_3 = (arg_29_1.time_ - var_32_1) / var_32_2

				if arg_29_1.var_.characterEffect1029ui_story and not isNil(var_32_0) then
					arg_29_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= var_32_1 + var_32_2 and arg_29_1.time_ < var_32_1 + var_32_2 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.characterEffect1029ui_story then
				arg_29_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_32_4 = 0

			if var_32_4 < arg_29_1.time_ and arg_29_1.time_ <= var_32_4 + arg_32_0 then
				arg_29_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action4_1")
			end

			local var_32_5 = 0

			if var_32_5 < arg_29_1.time_ and arg_29_1.time_ <= var_32_5 + arg_32_0 then
				arg_29_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_32_6 = arg_29_1.actors_["1084ui_story"]
			local var_32_7 = 0

			if var_32_7 < arg_29_1.time_ and arg_29_1.time_ <= var_32_7 + arg_32_0 and not isNil(var_32_6) and arg_29_1.var_.characterEffect1084ui_story == nil then
				arg_29_1.var_.characterEffect1084ui_story = var_32_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_8 = 0.200000002980232

			if var_32_7 <= arg_29_1.time_ and arg_29_1.time_ < var_32_7 + var_32_8 and not isNil(var_32_6) then
				local var_32_9 = (arg_29_1.time_ - var_32_7) / var_32_8

				if arg_29_1.var_.characterEffect1084ui_story and not isNil(var_32_6) then
					local var_32_10 = Mathf.Lerp(0, 0.5, var_32_9)

					arg_29_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_29_1.var_.characterEffect1084ui_story.fillRatio = var_32_10
				end
			end

			if arg_29_1.time_ >= var_32_7 + var_32_8 and arg_29_1.time_ < var_32_7 + var_32_8 + arg_32_0 and not isNil(var_32_6) and arg_29_1.var_.characterEffect1084ui_story then
				local var_32_11 = 0.5

				arg_29_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_29_1.var_.characterEffect1084ui_story.fillRatio = var_32_11
			end

			local var_32_12 = 0
			local var_32_13 = 0.75

			if var_32_12 < arg_29_1.time_ and arg_29_1.time_ <= var_32_12 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_14 = arg_29_1:FormatText(StoryNameCfg[319].name)

				arg_29_1.leftNameTxt_.text = var_32_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_15 = arg_29_1:GetWordFromCfg(121521007)
				local var_32_16 = arg_29_1:FormatText(var_32_15.content)

				arg_29_1.text_.text = var_32_16

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_17 = 30
				local var_32_18 = utf8.len(var_32_16)
				local var_32_19 = var_32_17 <= 0 and var_32_13 or var_32_13 * (var_32_18 / var_32_17)

				if var_32_19 > 0 and var_32_13 < var_32_19 then
					arg_29_1.talkMaxDuration = var_32_19

					if var_32_19 + var_32_12 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_19 + var_32_12
					end
				end

				arg_29_1.text_.text = var_32_16
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121521", "121521007", "story_v_out_121521.awb") ~= 0 then
					local var_32_20 = manager.audio:GetVoiceLength("story_v_out_121521", "121521007", "story_v_out_121521.awb") / 1000

					if var_32_20 + var_32_12 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_20 + var_32_12
					end

					if var_32_15.prefab_name ~= "" and arg_29_1.actors_[var_32_15.prefab_name] ~= nil then
						local var_32_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_15.prefab_name].transform, "story_v_out_121521", "121521007", "story_v_out_121521.awb")

						arg_29_1:RecordAudio("121521007", var_32_21)
						arg_29_1:RecordAudio("121521007", var_32_21)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_121521", "121521007", "story_v_out_121521.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_121521", "121521007", "story_v_out_121521.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_22 = math.max(var_32_13, arg_29_1.talkMaxDuration)

			if var_32_12 <= arg_29_1.time_ and arg_29_1.time_ < var_32_12 + var_32_22 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_12) / var_32_22

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_12 + var_32_22 and arg_29_1.time_ < var_32_12 + var_32_22 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play121521008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 121521008
		arg_33_1.duration_ = 11.43

		local var_33_0 = {
			ja = 11.433,
			ko = 7.5,
			zh = 7.5
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
				arg_33_0:Play121521009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 0

			if var_36_0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_0 + arg_36_0 then
				arg_33_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_36_1 = 0
			local var_36_2 = 0.775

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_3 = arg_33_1:FormatText(StoryNameCfg[319].name)

				arg_33_1.leftNameTxt_.text = var_36_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_4 = arg_33_1:GetWordFromCfg(121521008)
				local var_36_5 = arg_33_1:FormatText(var_36_4.content)

				arg_33_1.text_.text = var_36_5

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_6 = 31
				local var_36_7 = utf8.len(var_36_5)
				local var_36_8 = var_36_6 <= 0 and var_36_2 or var_36_2 * (var_36_7 / var_36_6)

				if var_36_8 > 0 and var_36_2 < var_36_8 then
					arg_33_1.talkMaxDuration = var_36_8

					if var_36_8 + var_36_1 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_8 + var_36_1
					end
				end

				arg_33_1.text_.text = var_36_5
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121521", "121521008", "story_v_out_121521.awb") ~= 0 then
					local var_36_9 = manager.audio:GetVoiceLength("story_v_out_121521", "121521008", "story_v_out_121521.awb") / 1000

					if var_36_9 + var_36_1 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_9 + var_36_1
					end

					if var_36_4.prefab_name ~= "" and arg_33_1.actors_[var_36_4.prefab_name] ~= nil then
						local var_36_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_4.prefab_name].transform, "story_v_out_121521", "121521008", "story_v_out_121521.awb")

						arg_33_1:RecordAudio("121521008", var_36_10)
						arg_33_1:RecordAudio("121521008", var_36_10)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_121521", "121521008", "story_v_out_121521.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_121521", "121521008", "story_v_out_121521.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_11 = math.max(var_36_2, arg_33_1.talkMaxDuration)

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_11 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_1) / var_36_11

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_1 + var_36_11 and arg_33_1.time_ < var_36_1 + var_36_11 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play121521009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 121521009
		arg_37_1.duration_ = 11.73

		local var_37_0 = {
			ja = 11.733,
			ko = 7.733,
			zh = 7.733
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
				arg_37_0:Play121521010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = arg_37_1.actors_["1084ui_story"]
			local var_40_1 = 0

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.characterEffect1084ui_story == nil then
				arg_37_1.var_.characterEffect1084ui_story = var_40_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_2 = 0.200000002980232

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_2 and not isNil(var_40_0) then
				local var_40_3 = (arg_37_1.time_ - var_40_1) / var_40_2

				if arg_37_1.var_.characterEffect1084ui_story and not isNil(var_40_0) then
					arg_37_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_37_1.time_ >= var_40_1 + var_40_2 and arg_37_1.time_ < var_40_1 + var_40_2 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.characterEffect1084ui_story then
				arg_37_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_40_4 = 0

			if var_40_4 < arg_37_1.time_ and arg_37_1.time_ <= var_40_4 + arg_40_0 then
				arg_37_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action41312")
			end

			local var_40_5 = 0

			if var_40_5 < arg_37_1.time_ and arg_37_1.time_ <= var_40_5 + arg_40_0 then
				arg_37_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_40_6 = arg_37_1.actors_["1029ui_story"]
			local var_40_7 = 0

			if var_40_7 < arg_37_1.time_ and arg_37_1.time_ <= var_40_7 + arg_40_0 and not isNil(var_40_6) and arg_37_1.var_.characterEffect1029ui_story == nil then
				arg_37_1.var_.characterEffect1029ui_story = var_40_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_8 = 0.200000002980232

			if var_40_7 <= arg_37_1.time_ and arg_37_1.time_ < var_40_7 + var_40_8 and not isNil(var_40_6) then
				local var_40_9 = (arg_37_1.time_ - var_40_7) / var_40_8

				if arg_37_1.var_.characterEffect1029ui_story and not isNil(var_40_6) then
					local var_40_10 = Mathf.Lerp(0, 0.5, var_40_9)

					arg_37_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_37_1.var_.characterEffect1029ui_story.fillRatio = var_40_10
				end
			end

			if arg_37_1.time_ >= var_40_7 + var_40_8 and arg_37_1.time_ < var_40_7 + var_40_8 + arg_40_0 and not isNil(var_40_6) and arg_37_1.var_.characterEffect1029ui_story then
				local var_40_11 = 0.5

				arg_37_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_37_1.var_.characterEffect1029ui_story.fillRatio = var_40_11
			end

			local var_40_12 = 0
			local var_40_13 = 0.9

			if var_40_12 < arg_37_1.time_ and arg_37_1.time_ <= var_40_12 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_14 = arg_37_1:FormatText(StoryNameCfg[6].name)

				arg_37_1.leftNameTxt_.text = var_40_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_15 = arg_37_1:GetWordFromCfg(121521009)
				local var_40_16 = arg_37_1:FormatText(var_40_15.content)

				arg_37_1.text_.text = var_40_16

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_17 = 36
				local var_40_18 = utf8.len(var_40_16)
				local var_40_19 = var_40_17 <= 0 and var_40_13 or var_40_13 * (var_40_18 / var_40_17)

				if var_40_19 > 0 and var_40_13 < var_40_19 then
					arg_37_1.talkMaxDuration = var_40_19

					if var_40_19 + var_40_12 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_19 + var_40_12
					end
				end

				arg_37_1.text_.text = var_40_16
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121521", "121521009", "story_v_out_121521.awb") ~= 0 then
					local var_40_20 = manager.audio:GetVoiceLength("story_v_out_121521", "121521009", "story_v_out_121521.awb") / 1000

					if var_40_20 + var_40_12 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_20 + var_40_12
					end

					if var_40_15.prefab_name ~= "" and arg_37_1.actors_[var_40_15.prefab_name] ~= nil then
						local var_40_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_15.prefab_name].transform, "story_v_out_121521", "121521009", "story_v_out_121521.awb")

						arg_37_1:RecordAudio("121521009", var_40_21)
						arg_37_1:RecordAudio("121521009", var_40_21)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_121521", "121521009", "story_v_out_121521.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_121521", "121521009", "story_v_out_121521.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_22 = math.max(var_40_13, arg_37_1.talkMaxDuration)

			if var_40_12 <= arg_37_1.time_ and arg_37_1.time_ < var_40_12 + var_40_22 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_12) / var_40_22

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_12 + var_40_22 and arg_37_1.time_ < var_40_12 + var_40_22 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play121521010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 121521010
		arg_41_1.duration_ = 5

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play121521011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = arg_41_1.actors_["1084ui_story"]
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect1084ui_story == nil then
				arg_41_1.var_.characterEffect1084ui_story = var_44_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_2 = 0.200000002980232

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_2 and not isNil(var_44_0) then
				local var_44_3 = (arg_41_1.time_ - var_44_1) / var_44_2

				if arg_41_1.var_.characterEffect1084ui_story and not isNil(var_44_0) then
					local var_44_4 = Mathf.Lerp(0, 0.5, var_44_3)

					arg_41_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_41_1.var_.characterEffect1084ui_story.fillRatio = var_44_4
				end
			end

			if arg_41_1.time_ >= var_44_1 + var_44_2 and arg_41_1.time_ < var_44_1 + var_44_2 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect1084ui_story then
				local var_44_5 = 0.5

				arg_41_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_41_1.var_.characterEffect1084ui_story.fillRatio = var_44_5
			end

			local var_44_6 = 0
			local var_44_7 = 1.125

			if var_44_6 < arg_41_1.time_ and arg_41_1.time_ <= var_44_6 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_8 = arg_41_1:FormatText(StoryNameCfg[7].name)

				arg_41_1.leftNameTxt_.text = var_44_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, true)
				arg_41_1.iconController_:SetSelectedState("hero")

				arg_41_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_41_1.callingController_:SetSelectedState("normal")

				arg_41_1.keyicon_.color = Color.New(1, 1, 1)
				arg_41_1.icon_.color = Color.New(1, 1, 1)

				local var_44_9 = arg_41_1:GetWordFromCfg(121521010)
				local var_44_10 = arg_41_1:FormatText(var_44_9.content)

				arg_41_1.text_.text = var_44_10

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_11 = 45
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
				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_14 = math.max(var_44_7, arg_41_1.talkMaxDuration)

			if var_44_6 <= arg_41_1.time_ and arg_41_1.time_ < var_44_6 + var_44_14 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_6) / var_44_14

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_6 + var_44_14 and arg_41_1.time_ < var_44_6 + var_44_14 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play121521011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 121521011
		arg_45_1.duration_ = 4

		local var_45_0 = {
			ja = 1.999999999999,
			ko = 4,
			zh = 4
		}
		local var_45_1 = manager.audio:GetLocalizationFlag()

		if var_45_0[var_45_1] ~= nil then
			arg_45_1.duration_ = var_45_0[var_45_1]
		end

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play121521012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = arg_45_1.actors_["1029ui_story"]
			local var_48_1 = 0

			if var_48_1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.characterEffect1029ui_story == nil then
				arg_45_1.var_.characterEffect1029ui_story = var_48_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_2 = 0.200000002980232

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_2 and not isNil(var_48_0) then
				local var_48_3 = (arg_45_1.time_ - var_48_1) / var_48_2

				if arg_45_1.var_.characterEffect1029ui_story and not isNil(var_48_0) then
					arg_45_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_45_1.time_ >= var_48_1 + var_48_2 and arg_45_1.time_ < var_48_1 + var_48_2 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.characterEffect1029ui_story then
				arg_45_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_48_4 = 0

			if var_48_4 < arg_45_1.time_ and arg_45_1.time_ <= var_48_4 + arg_48_0 then
				arg_45_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_48_5 = 0
			local var_48_6 = 0.375

			if var_48_5 < arg_45_1.time_ and arg_45_1.time_ <= var_48_5 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_7 = arg_45_1:FormatText(StoryNameCfg[319].name)

				arg_45_1.leftNameTxt_.text = var_48_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_8 = arg_45_1:GetWordFromCfg(121521011)
				local var_48_9 = arg_45_1:FormatText(var_48_8.content)

				arg_45_1.text_.text = var_48_9

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_10 = 15
				local var_48_11 = utf8.len(var_48_9)
				local var_48_12 = var_48_10 <= 0 and var_48_6 or var_48_6 * (var_48_11 / var_48_10)

				if var_48_12 > 0 and var_48_6 < var_48_12 then
					arg_45_1.talkMaxDuration = var_48_12

					if var_48_12 + var_48_5 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_12 + var_48_5
					end
				end

				arg_45_1.text_.text = var_48_9
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121521", "121521011", "story_v_out_121521.awb") ~= 0 then
					local var_48_13 = manager.audio:GetVoiceLength("story_v_out_121521", "121521011", "story_v_out_121521.awb") / 1000

					if var_48_13 + var_48_5 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_13 + var_48_5
					end

					if var_48_8.prefab_name ~= "" and arg_45_1.actors_[var_48_8.prefab_name] ~= nil then
						local var_48_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_8.prefab_name].transform, "story_v_out_121521", "121521011", "story_v_out_121521.awb")

						arg_45_1:RecordAudio("121521011", var_48_14)
						arg_45_1:RecordAudio("121521011", var_48_14)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_121521", "121521011", "story_v_out_121521.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_121521", "121521011", "story_v_out_121521.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_15 = math.max(var_48_6, arg_45_1.talkMaxDuration)

			if var_48_5 <= arg_45_1.time_ and arg_45_1.time_ < var_48_5 + var_48_15 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_5) / var_48_15

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_5 + var_48_15 and arg_45_1.time_ < var_48_5 + var_48_15 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play121521012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 121521012
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play121521013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = arg_49_1.actors_["1029ui_story"]
			local var_52_1 = 0

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.characterEffect1029ui_story == nil then
				arg_49_1.var_.characterEffect1029ui_story = var_52_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_2 = 0.200000002980232

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_2 and not isNil(var_52_0) then
				local var_52_3 = (arg_49_1.time_ - var_52_1) / var_52_2

				if arg_49_1.var_.characterEffect1029ui_story and not isNil(var_52_0) then
					local var_52_4 = Mathf.Lerp(0, 0.5, var_52_3)

					arg_49_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_49_1.var_.characterEffect1029ui_story.fillRatio = var_52_4
				end
			end

			if arg_49_1.time_ >= var_52_1 + var_52_2 and arg_49_1.time_ < var_52_1 + var_52_2 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.characterEffect1029ui_story then
				local var_52_5 = 0.5

				arg_49_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_49_1.var_.characterEffect1029ui_story.fillRatio = var_52_5
			end

			local var_52_6 = 0
			local var_52_7 = 0.9

			if var_52_6 < arg_49_1.time_ and arg_49_1.time_ <= var_52_6 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_8 = arg_49_1:FormatText(StoryNameCfg[7].name)

				arg_49_1.leftNameTxt_.text = var_52_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, true)
				arg_49_1.iconController_:SetSelectedState("hero")

				arg_49_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_49_1.callingController_:SetSelectedState("normal")

				arg_49_1.keyicon_.color = Color.New(1, 1, 1)
				arg_49_1.icon_.color = Color.New(1, 1, 1)

				local var_52_9 = arg_49_1:GetWordFromCfg(121521012)
				local var_52_10 = arg_49_1:FormatText(var_52_9.content)

				arg_49_1.text_.text = var_52_10

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_11 = 36
				local var_52_12 = utf8.len(var_52_10)
				local var_52_13 = var_52_11 <= 0 and var_52_7 or var_52_7 * (var_52_12 / var_52_11)

				if var_52_13 > 0 and var_52_7 < var_52_13 then
					arg_49_1.talkMaxDuration = var_52_13

					if var_52_13 + var_52_6 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_13 + var_52_6
					end
				end

				arg_49_1.text_.text = var_52_10
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)
				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_14 = math.max(var_52_7, arg_49_1.talkMaxDuration)

			if var_52_6 <= arg_49_1.time_ and arg_49_1.time_ < var_52_6 + var_52_14 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_6) / var_52_14

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_6 + var_52_14 and arg_49_1.time_ < var_52_6 + var_52_14 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play121521013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 121521013
		arg_53_1.duration_ = 5

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play121521014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 0
			local var_56_1 = 1.05

			if var_56_0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_2 = arg_53_1:FormatText(StoryNameCfg[7].name)

				arg_53_1.leftNameTxt_.text = var_56_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, true)
				arg_53_1.iconController_:SetSelectedState("hero")

				arg_53_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_53_1.callingController_:SetSelectedState("normal")

				arg_53_1.keyicon_.color = Color.New(1, 1, 1)
				arg_53_1.icon_.color = Color.New(1, 1, 1)

				local var_56_3 = arg_53_1:GetWordFromCfg(121521013)
				local var_56_4 = arg_53_1:FormatText(var_56_3.content)

				arg_53_1.text_.text = var_56_4

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_5 = 42
				local var_56_6 = utf8.len(var_56_4)
				local var_56_7 = var_56_5 <= 0 and var_56_1 or var_56_1 * (var_56_6 / var_56_5)

				if var_56_7 > 0 and var_56_1 < var_56_7 then
					arg_53_1.talkMaxDuration = var_56_7

					if var_56_7 + var_56_0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_7 + var_56_0
					end
				end

				arg_53_1.text_.text = var_56_4
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)
				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_8 = math.max(var_56_1, arg_53_1.talkMaxDuration)

			if var_56_0 <= arg_53_1.time_ and arg_53_1.time_ < var_56_0 + var_56_8 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_0) / var_56_8

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_0 + var_56_8 and arg_53_1.time_ < var_56_0 + var_56_8 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play121521014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 121521014
		arg_57_1.duration_ = 10.6

		local var_57_0 = {
			ja = 10.6,
			ko = 7.2,
			zh = 7.2
		}
		local var_57_1 = manager.audio:GetLocalizationFlag()

		if var_57_0[var_57_1] ~= nil then
			arg_57_1.duration_ = var_57_0[var_57_1]
		end

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play121521015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = arg_57_1.actors_["1084ui_story"]
			local var_60_1 = 0

			if var_60_1 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 and not isNil(var_60_0) and arg_57_1.var_.characterEffect1084ui_story == nil then
				arg_57_1.var_.characterEffect1084ui_story = var_60_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_2 = 0.200000002980232

			if var_60_1 <= arg_57_1.time_ and arg_57_1.time_ < var_60_1 + var_60_2 and not isNil(var_60_0) then
				local var_60_3 = (arg_57_1.time_ - var_60_1) / var_60_2

				if arg_57_1.var_.characterEffect1084ui_story and not isNil(var_60_0) then
					arg_57_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_57_1.time_ >= var_60_1 + var_60_2 and arg_57_1.time_ < var_60_1 + var_60_2 + arg_60_0 and not isNil(var_60_0) and arg_57_1.var_.characterEffect1084ui_story then
				arg_57_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_60_4 = 0

			if var_60_4 < arg_57_1.time_ and arg_57_1.time_ <= var_60_4 + arg_60_0 then
				arg_57_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_60_5 = 0
			local var_60_6 = 0.9

			if var_60_5 < arg_57_1.time_ and arg_57_1.time_ <= var_60_5 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_7 = arg_57_1:FormatText(StoryNameCfg[6].name)

				arg_57_1.leftNameTxt_.text = var_60_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_8 = arg_57_1:GetWordFromCfg(121521014)
				local var_60_9 = arg_57_1:FormatText(var_60_8.content)

				arg_57_1.text_.text = var_60_9

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_10 = 36
				local var_60_11 = utf8.len(var_60_9)
				local var_60_12 = var_60_10 <= 0 and var_60_6 or var_60_6 * (var_60_11 / var_60_10)

				if var_60_12 > 0 and var_60_6 < var_60_12 then
					arg_57_1.talkMaxDuration = var_60_12

					if var_60_12 + var_60_5 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_12 + var_60_5
					end
				end

				arg_57_1.text_.text = var_60_9
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121521", "121521014", "story_v_out_121521.awb") ~= 0 then
					local var_60_13 = manager.audio:GetVoiceLength("story_v_out_121521", "121521014", "story_v_out_121521.awb") / 1000

					if var_60_13 + var_60_5 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_13 + var_60_5
					end

					if var_60_8.prefab_name ~= "" and arg_57_1.actors_[var_60_8.prefab_name] ~= nil then
						local var_60_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_8.prefab_name].transform, "story_v_out_121521", "121521014", "story_v_out_121521.awb")

						arg_57_1:RecordAudio("121521014", var_60_14)
						arg_57_1:RecordAudio("121521014", var_60_14)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_121521", "121521014", "story_v_out_121521.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_121521", "121521014", "story_v_out_121521.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_15 = math.max(var_60_6, arg_57_1.talkMaxDuration)

			if var_60_5 <= arg_57_1.time_ and arg_57_1.time_ < var_60_5 + var_60_15 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_5) / var_60_15

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_5 + var_60_15 and arg_57_1.time_ < var_60_5 + var_60_15 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play121521015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 121521015
		arg_61_1.duration_ = 5.5

		local var_61_0 = {
			ja = 5.5,
			ko = 4.966,
			zh = 4.966
		}
		local var_61_1 = manager.audio:GetLocalizationFlag()

		if var_61_0[var_61_1] ~= nil then
			arg_61_1.duration_ = var_61_0[var_61_1]
		end

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play121521016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = 0
			local var_64_1 = 0.575

			if var_64_0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_0 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_2 = arg_61_1:FormatText(StoryNameCfg[6].name)

				arg_61_1.leftNameTxt_.text = var_64_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_3 = arg_61_1:GetWordFromCfg(121521015)
				local var_64_4 = arg_61_1:FormatText(var_64_3.content)

				arg_61_1.text_.text = var_64_4

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_5 = 23
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

				if manager.audio:GetVoiceLength("story_v_out_121521", "121521015", "story_v_out_121521.awb") ~= 0 then
					local var_64_8 = manager.audio:GetVoiceLength("story_v_out_121521", "121521015", "story_v_out_121521.awb") / 1000

					if var_64_8 + var_64_0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_8 + var_64_0
					end

					if var_64_3.prefab_name ~= "" and arg_61_1.actors_[var_64_3.prefab_name] ~= nil then
						local var_64_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_3.prefab_name].transform, "story_v_out_121521", "121521015", "story_v_out_121521.awb")

						arg_61_1:RecordAudio("121521015", var_64_9)
						arg_61_1:RecordAudio("121521015", var_64_9)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_121521", "121521015", "story_v_out_121521.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_121521", "121521015", "story_v_out_121521.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_10 = math.max(var_64_1, arg_61_1.talkMaxDuration)

			if var_64_0 <= arg_61_1.time_ and arg_61_1.time_ < var_64_0 + var_64_10 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_0) / var_64_10

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_0 + var_64_10 and arg_61_1.time_ < var_64_0 + var_64_10 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play121521016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 121521016
		arg_65_1.duration_ = 2

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play121521017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = arg_65_1.actors_["1029ui_story"]
			local var_68_1 = 0

			if var_68_1 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.characterEffect1029ui_story == nil then
				arg_65_1.var_.characterEffect1029ui_story = var_68_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_2 = 0.200000002980232

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_2 and not isNil(var_68_0) then
				local var_68_3 = (arg_65_1.time_ - var_68_1) / var_68_2

				if arg_65_1.var_.characterEffect1029ui_story and not isNil(var_68_0) then
					arg_65_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= var_68_1 + var_68_2 and arg_65_1.time_ < var_68_1 + var_68_2 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.characterEffect1029ui_story then
				arg_65_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_68_4 = 0

			if var_68_4 < arg_65_1.time_ and arg_65_1.time_ <= var_68_4 + arg_68_0 then
				arg_65_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_68_5 = arg_65_1.actors_["1084ui_story"]
			local var_68_6 = 0

			if var_68_6 < arg_65_1.time_ and arg_65_1.time_ <= var_68_6 + arg_68_0 and not isNil(var_68_5) and arg_65_1.var_.characterEffect1084ui_story == nil then
				arg_65_1.var_.characterEffect1084ui_story = var_68_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_7 = 0.200000002980232

			if var_68_6 <= arg_65_1.time_ and arg_65_1.time_ < var_68_6 + var_68_7 and not isNil(var_68_5) then
				local var_68_8 = (arg_65_1.time_ - var_68_6) / var_68_7

				if arg_65_1.var_.characterEffect1084ui_story and not isNil(var_68_5) then
					local var_68_9 = Mathf.Lerp(0, 0.5, var_68_8)

					arg_65_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_65_1.var_.characterEffect1084ui_story.fillRatio = var_68_9
				end
			end

			if arg_65_1.time_ >= var_68_6 + var_68_7 and arg_65_1.time_ < var_68_6 + var_68_7 + arg_68_0 and not isNil(var_68_5) and arg_65_1.var_.characterEffect1084ui_story then
				local var_68_10 = 0.5

				arg_65_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_65_1.var_.characterEffect1084ui_story.fillRatio = var_68_10
			end

			local var_68_11 = 0
			local var_68_12 = 0.125

			if var_68_11 < arg_65_1.time_ and arg_65_1.time_ <= var_68_11 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_13 = arg_65_1:FormatText(StoryNameCfg[319].name)

				arg_65_1.leftNameTxt_.text = var_68_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_14 = arg_65_1:GetWordFromCfg(121521016)
				local var_68_15 = arg_65_1:FormatText(var_68_14.content)

				arg_65_1.text_.text = var_68_15

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_16 = 5
				local var_68_17 = utf8.len(var_68_15)
				local var_68_18 = var_68_16 <= 0 and var_68_12 or var_68_12 * (var_68_17 / var_68_16)

				if var_68_18 > 0 and var_68_12 < var_68_18 then
					arg_65_1.talkMaxDuration = var_68_18

					if var_68_18 + var_68_11 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_18 + var_68_11
					end
				end

				arg_65_1.text_.text = var_68_15
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121521", "121521016", "story_v_out_121521.awb") ~= 0 then
					local var_68_19 = manager.audio:GetVoiceLength("story_v_out_121521", "121521016", "story_v_out_121521.awb") / 1000

					if var_68_19 + var_68_11 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_19 + var_68_11
					end

					if var_68_14.prefab_name ~= "" and arg_65_1.actors_[var_68_14.prefab_name] ~= nil then
						local var_68_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_14.prefab_name].transform, "story_v_out_121521", "121521016", "story_v_out_121521.awb")

						arg_65_1:RecordAudio("121521016", var_68_20)
						arg_65_1:RecordAudio("121521016", var_68_20)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_121521", "121521016", "story_v_out_121521.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_121521", "121521016", "story_v_out_121521.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_21 = math.max(var_68_12, arg_65_1.talkMaxDuration)

			if var_68_11 <= arg_65_1.time_ and arg_65_1.time_ < var_68_11 + var_68_21 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_11) / var_68_21

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_11 + var_68_21 and arg_65_1.time_ < var_68_11 + var_68_21 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play121521017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 121521017
		arg_69_1.duration_ = 4.23

		local var_69_0 = {
			ja = 4.233,
			ko = 3.1,
			zh = 3.1
		}
		local var_69_1 = manager.audio:GetLocalizationFlag()

		if var_69_0[var_69_1] ~= nil then
			arg_69_1.duration_ = var_69_0[var_69_1]
		end

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play121521018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = arg_69_1.actors_["1084ui_story"]
			local var_72_1 = 0

			if var_72_1 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 and not isNil(var_72_0) and arg_69_1.var_.characterEffect1084ui_story == nil then
				arg_69_1.var_.characterEffect1084ui_story = var_72_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_2 = 0.200000002980232

			if var_72_1 <= arg_69_1.time_ and arg_69_1.time_ < var_72_1 + var_72_2 and not isNil(var_72_0) then
				local var_72_3 = (arg_69_1.time_ - var_72_1) / var_72_2

				if arg_69_1.var_.characterEffect1084ui_story and not isNil(var_72_0) then
					arg_69_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_69_1.time_ >= var_72_1 + var_72_2 and arg_69_1.time_ < var_72_1 + var_72_2 + arg_72_0 and not isNil(var_72_0) and arg_69_1.var_.characterEffect1084ui_story then
				arg_69_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_72_4 = 0

			if var_72_4 < arg_69_1.time_ and arg_69_1.time_ <= var_72_4 + arg_72_0 then
				arg_69_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action4127")
			end

			local var_72_5 = 0

			if var_72_5 < arg_69_1.time_ and arg_69_1.time_ <= var_72_5 + arg_72_0 then
				arg_69_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_72_6 = arg_69_1.actors_["1029ui_story"]
			local var_72_7 = 0

			if var_72_7 < arg_69_1.time_ and arg_69_1.time_ <= var_72_7 + arg_72_0 and not isNil(var_72_6) and arg_69_1.var_.characterEffect1029ui_story == nil then
				arg_69_1.var_.characterEffect1029ui_story = var_72_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_8 = 0.200000002980232

			if var_72_7 <= arg_69_1.time_ and arg_69_1.time_ < var_72_7 + var_72_8 and not isNil(var_72_6) then
				local var_72_9 = (arg_69_1.time_ - var_72_7) / var_72_8

				if arg_69_1.var_.characterEffect1029ui_story and not isNil(var_72_6) then
					local var_72_10 = Mathf.Lerp(0, 0.5, var_72_9)

					arg_69_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_69_1.var_.characterEffect1029ui_story.fillRatio = var_72_10
				end
			end

			if arg_69_1.time_ >= var_72_7 + var_72_8 and arg_69_1.time_ < var_72_7 + var_72_8 + arg_72_0 and not isNil(var_72_6) and arg_69_1.var_.characterEffect1029ui_story then
				local var_72_11 = 0.5

				arg_69_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_69_1.var_.characterEffect1029ui_story.fillRatio = var_72_11
			end

			local var_72_12 = 0
			local var_72_13 = 0.2

			if var_72_12 < arg_69_1.time_ and arg_69_1.time_ <= var_72_12 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_14 = arg_69_1:FormatText(StoryNameCfg[6].name)

				arg_69_1.leftNameTxt_.text = var_72_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_15 = arg_69_1:GetWordFromCfg(121521017)
				local var_72_16 = arg_69_1:FormatText(var_72_15.content)

				arg_69_1.text_.text = var_72_16

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_17 = 8
				local var_72_18 = utf8.len(var_72_16)
				local var_72_19 = var_72_17 <= 0 and var_72_13 or var_72_13 * (var_72_18 / var_72_17)

				if var_72_19 > 0 and var_72_13 < var_72_19 then
					arg_69_1.talkMaxDuration = var_72_19

					if var_72_19 + var_72_12 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_19 + var_72_12
					end
				end

				arg_69_1.text_.text = var_72_16
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121521", "121521017", "story_v_out_121521.awb") ~= 0 then
					local var_72_20 = manager.audio:GetVoiceLength("story_v_out_121521", "121521017", "story_v_out_121521.awb") / 1000

					if var_72_20 + var_72_12 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_20 + var_72_12
					end

					if var_72_15.prefab_name ~= "" and arg_69_1.actors_[var_72_15.prefab_name] ~= nil then
						local var_72_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_15.prefab_name].transform, "story_v_out_121521", "121521017", "story_v_out_121521.awb")

						arg_69_1:RecordAudio("121521017", var_72_21)
						arg_69_1:RecordAudio("121521017", var_72_21)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_121521", "121521017", "story_v_out_121521.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_121521", "121521017", "story_v_out_121521.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_22 = math.max(var_72_13, arg_69_1.talkMaxDuration)

			if var_72_12 <= arg_69_1.time_ and arg_69_1.time_ < var_72_12 + var_72_22 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_12) / var_72_22

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_12 + var_72_22 and arg_69_1.time_ < var_72_12 + var_72_22 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play121521018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 121521018
		arg_73_1.duration_ = 12.57

		local var_73_0 = {
			ja = 12.566,
			ko = 11.1,
			zh = 11.1
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
				arg_73_0:Play121521019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = arg_73_1.actors_["1029ui_story"]
			local var_76_1 = 0

			if var_76_1 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 and not isNil(var_76_0) and arg_73_1.var_.characterEffect1029ui_story == nil then
				arg_73_1.var_.characterEffect1029ui_story = var_76_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_2 = 0.200000002980232

			if var_76_1 <= arg_73_1.time_ and arg_73_1.time_ < var_76_1 + var_76_2 and not isNil(var_76_0) then
				local var_76_3 = (arg_73_1.time_ - var_76_1) / var_76_2

				if arg_73_1.var_.characterEffect1029ui_story and not isNil(var_76_0) then
					arg_73_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_73_1.time_ >= var_76_1 + var_76_2 and arg_73_1.time_ < var_76_1 + var_76_2 + arg_76_0 and not isNil(var_76_0) and arg_73_1.var_.characterEffect1029ui_story then
				arg_73_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_76_4 = 0

			if var_76_4 < arg_73_1.time_ and arg_73_1.time_ <= var_76_4 + arg_76_0 then
				arg_73_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029actionlink/1029action442")
			end

			local var_76_5 = 0

			if var_76_5 < arg_73_1.time_ and arg_73_1.time_ <= var_76_5 + arg_76_0 then
				arg_73_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_76_6 = arg_73_1.actors_["1084ui_story"]
			local var_76_7 = 0

			if var_76_7 < arg_73_1.time_ and arg_73_1.time_ <= var_76_7 + arg_76_0 and not isNil(var_76_6) and arg_73_1.var_.characterEffect1084ui_story == nil then
				arg_73_1.var_.characterEffect1084ui_story = var_76_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_8 = 0.200000002980232

			if var_76_7 <= arg_73_1.time_ and arg_73_1.time_ < var_76_7 + var_76_8 and not isNil(var_76_6) then
				local var_76_9 = (arg_73_1.time_ - var_76_7) / var_76_8

				if arg_73_1.var_.characterEffect1084ui_story and not isNil(var_76_6) then
					local var_76_10 = Mathf.Lerp(0, 0.5, var_76_9)

					arg_73_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_73_1.var_.characterEffect1084ui_story.fillRatio = var_76_10
				end
			end

			if arg_73_1.time_ >= var_76_7 + var_76_8 and arg_73_1.time_ < var_76_7 + var_76_8 + arg_76_0 and not isNil(var_76_6) and arg_73_1.var_.characterEffect1084ui_story then
				local var_76_11 = 0.5

				arg_73_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_73_1.var_.characterEffect1084ui_story.fillRatio = var_76_11
			end

			local var_76_12 = 0
			local var_76_13 = 1.05

			if var_76_12 < arg_73_1.time_ and arg_73_1.time_ <= var_76_12 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				local var_76_14 = arg_73_1:FormatText(StoryNameCfg[319].name)

				arg_73_1.leftNameTxt_.text = var_76_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_15 = arg_73_1:GetWordFromCfg(121521018)
				local var_76_16 = arg_73_1:FormatText(var_76_15.content)

				arg_73_1.text_.text = var_76_16

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_17 = 42
				local var_76_18 = utf8.len(var_76_16)
				local var_76_19 = var_76_17 <= 0 and var_76_13 or var_76_13 * (var_76_18 / var_76_17)

				if var_76_19 > 0 and var_76_13 < var_76_19 then
					arg_73_1.talkMaxDuration = var_76_19

					if var_76_19 + var_76_12 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_19 + var_76_12
					end
				end

				arg_73_1.text_.text = var_76_16
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121521", "121521018", "story_v_out_121521.awb") ~= 0 then
					local var_76_20 = manager.audio:GetVoiceLength("story_v_out_121521", "121521018", "story_v_out_121521.awb") / 1000

					if var_76_20 + var_76_12 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_20 + var_76_12
					end

					if var_76_15.prefab_name ~= "" and arg_73_1.actors_[var_76_15.prefab_name] ~= nil then
						local var_76_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_15.prefab_name].transform, "story_v_out_121521", "121521018", "story_v_out_121521.awb")

						arg_73_1:RecordAudio("121521018", var_76_21)
						arg_73_1:RecordAudio("121521018", var_76_21)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_121521", "121521018", "story_v_out_121521.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_121521", "121521018", "story_v_out_121521.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_22 = math.max(var_76_13, arg_73_1.talkMaxDuration)

			if var_76_12 <= arg_73_1.time_ and arg_73_1.time_ < var_76_12 + var_76_22 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_12) / var_76_22

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_12 + var_76_22 and arg_73_1.time_ < var_76_12 + var_76_22 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play121521019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 121521019
		arg_77_1.duration_ = 11.2

		local var_77_0 = {
			ja = 6.933,
			ko = 11.2,
			zh = 11.2
		}
		local var_77_1 = manager.audio:GetLocalizationFlag()

		if var_77_0[var_77_1] ~= nil then
			arg_77_1.duration_ = var_77_0[var_77_1]
		end

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play121521020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = 0
			local var_80_1 = 1.175

			if var_80_0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_0 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				local var_80_2 = arg_77_1:FormatText(StoryNameCfg[319].name)

				arg_77_1.leftNameTxt_.text = var_80_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_3 = arg_77_1:GetWordFromCfg(121521019)
				local var_80_4 = arg_77_1:FormatText(var_80_3.content)

				arg_77_1.text_.text = var_80_4

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_5 = 47
				local var_80_6 = utf8.len(var_80_4)
				local var_80_7 = var_80_5 <= 0 and var_80_1 or var_80_1 * (var_80_6 / var_80_5)

				if var_80_7 > 0 and var_80_1 < var_80_7 then
					arg_77_1.talkMaxDuration = var_80_7

					if var_80_7 + var_80_0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_7 + var_80_0
					end
				end

				arg_77_1.text_.text = var_80_4
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121521", "121521019", "story_v_out_121521.awb") ~= 0 then
					local var_80_8 = manager.audio:GetVoiceLength("story_v_out_121521", "121521019", "story_v_out_121521.awb") / 1000

					if var_80_8 + var_80_0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_8 + var_80_0
					end

					if var_80_3.prefab_name ~= "" and arg_77_1.actors_[var_80_3.prefab_name] ~= nil then
						local var_80_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_3.prefab_name].transform, "story_v_out_121521", "121521019", "story_v_out_121521.awb")

						arg_77_1:RecordAudio("121521019", var_80_9)
						arg_77_1:RecordAudio("121521019", var_80_9)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_121521", "121521019", "story_v_out_121521.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_121521", "121521019", "story_v_out_121521.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_10 = math.max(var_80_1, arg_77_1.talkMaxDuration)

			if var_80_0 <= arg_77_1.time_ and arg_77_1.time_ < var_80_0 + var_80_10 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_0) / var_80_10

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_0 + var_80_10 and arg_77_1.time_ < var_80_0 + var_80_10 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play121521020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 121521020
		arg_81_1.duration_ = 11.4

		local var_81_0 = {
			ja = 10.833,
			ko = 11.4,
			zh = 11.4
		}
		local var_81_1 = manager.audio:GetLocalizationFlag()

		if var_81_0[var_81_1] ~= nil then
			arg_81_1.duration_ = var_81_0[var_81_1]
		end

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play121521021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = 0
			local var_84_1 = 1.15

			if var_84_0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_0 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				local var_84_2 = arg_81_1:FormatText(StoryNameCfg[319].name)

				arg_81_1.leftNameTxt_.text = var_84_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_3 = arg_81_1:GetWordFromCfg(121521020)
				local var_84_4 = arg_81_1:FormatText(var_84_3.content)

				arg_81_1.text_.text = var_84_4

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_5 = 46
				local var_84_6 = utf8.len(var_84_4)
				local var_84_7 = var_84_5 <= 0 and var_84_1 or var_84_1 * (var_84_6 / var_84_5)

				if var_84_7 > 0 and var_84_1 < var_84_7 then
					arg_81_1.talkMaxDuration = var_84_7

					if var_84_7 + var_84_0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_7 + var_84_0
					end
				end

				arg_81_1.text_.text = var_84_4
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121521", "121521020", "story_v_out_121521.awb") ~= 0 then
					local var_84_8 = manager.audio:GetVoiceLength("story_v_out_121521", "121521020", "story_v_out_121521.awb") / 1000

					if var_84_8 + var_84_0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_8 + var_84_0
					end

					if var_84_3.prefab_name ~= "" and arg_81_1.actors_[var_84_3.prefab_name] ~= nil then
						local var_84_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_3.prefab_name].transform, "story_v_out_121521", "121521020", "story_v_out_121521.awb")

						arg_81_1:RecordAudio("121521020", var_84_9)
						arg_81_1:RecordAudio("121521020", var_84_9)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_121521", "121521020", "story_v_out_121521.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_121521", "121521020", "story_v_out_121521.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_10 = math.max(var_84_1, arg_81_1.talkMaxDuration)

			if var_84_0 <= arg_81_1.time_ and arg_81_1.time_ < var_84_0 + var_84_10 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_0) / var_84_10

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_0 + var_84_10 and arg_81_1.time_ < var_84_0 + var_84_10 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play121521021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 121521021
		arg_85_1.duration_ = 2

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play121521022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = arg_85_1.actors_["1084ui_story"]
			local var_88_1 = 0

			if var_88_1 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 and not isNil(var_88_0) and arg_85_1.var_.characterEffect1084ui_story == nil then
				arg_85_1.var_.characterEffect1084ui_story = var_88_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_2 = 0.200000002980232

			if var_88_1 <= arg_85_1.time_ and arg_85_1.time_ < var_88_1 + var_88_2 and not isNil(var_88_0) then
				local var_88_3 = (arg_85_1.time_ - var_88_1) / var_88_2

				if arg_85_1.var_.characterEffect1084ui_story and not isNil(var_88_0) then
					arg_85_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_85_1.time_ >= var_88_1 + var_88_2 and arg_85_1.time_ < var_88_1 + var_88_2 + arg_88_0 and not isNil(var_88_0) and arg_85_1.var_.characterEffect1084ui_story then
				arg_85_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_88_4 = 0

			if var_88_4 < arg_85_1.time_ and arg_85_1.time_ <= var_88_4 + arg_88_0 then
				arg_85_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_2")
			end

			local var_88_5 = 0

			if var_88_5 < arg_85_1.time_ and arg_85_1.time_ <= var_88_5 + arg_88_0 then
				arg_85_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_88_6 = arg_85_1.actors_["1029ui_story"]
			local var_88_7 = 0

			if var_88_7 < arg_85_1.time_ and arg_85_1.time_ <= var_88_7 + arg_88_0 and not isNil(var_88_6) and arg_85_1.var_.characterEffect1029ui_story == nil then
				arg_85_1.var_.characterEffect1029ui_story = var_88_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_8 = 0.200000002980232

			if var_88_7 <= arg_85_1.time_ and arg_85_1.time_ < var_88_7 + var_88_8 and not isNil(var_88_6) then
				local var_88_9 = (arg_85_1.time_ - var_88_7) / var_88_8

				if arg_85_1.var_.characterEffect1029ui_story and not isNil(var_88_6) then
					local var_88_10 = Mathf.Lerp(0, 0.5, var_88_9)

					arg_85_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_85_1.var_.characterEffect1029ui_story.fillRatio = var_88_10
				end
			end

			if arg_85_1.time_ >= var_88_7 + var_88_8 and arg_85_1.time_ < var_88_7 + var_88_8 + arg_88_0 and not isNil(var_88_6) and arg_85_1.var_.characterEffect1029ui_story then
				local var_88_11 = 0.5

				arg_85_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_85_1.var_.characterEffect1029ui_story.fillRatio = var_88_11
			end

			local var_88_12 = 0
			local var_88_13 = 0.175

			if var_88_12 < arg_85_1.time_ and arg_85_1.time_ <= var_88_12 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				local var_88_14 = arg_85_1:FormatText(StoryNameCfg[6].name)

				arg_85_1.leftNameTxt_.text = var_88_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_15 = arg_85_1:GetWordFromCfg(121521021)
				local var_88_16 = arg_85_1:FormatText(var_88_15.content)

				arg_85_1.text_.text = var_88_16

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_17 = 7
				local var_88_18 = utf8.len(var_88_16)
				local var_88_19 = var_88_17 <= 0 and var_88_13 or var_88_13 * (var_88_18 / var_88_17)

				if var_88_19 > 0 and var_88_13 < var_88_19 then
					arg_85_1.talkMaxDuration = var_88_19

					if var_88_19 + var_88_12 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_19 + var_88_12
					end
				end

				arg_85_1.text_.text = var_88_16
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121521", "121521021", "story_v_out_121521.awb") ~= 0 then
					local var_88_20 = manager.audio:GetVoiceLength("story_v_out_121521", "121521021", "story_v_out_121521.awb") / 1000

					if var_88_20 + var_88_12 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_20 + var_88_12
					end

					if var_88_15.prefab_name ~= "" and arg_85_1.actors_[var_88_15.prefab_name] ~= nil then
						local var_88_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_15.prefab_name].transform, "story_v_out_121521", "121521021", "story_v_out_121521.awb")

						arg_85_1:RecordAudio("121521021", var_88_21)
						arg_85_1:RecordAudio("121521021", var_88_21)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_121521", "121521021", "story_v_out_121521.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_121521", "121521021", "story_v_out_121521.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_22 = math.max(var_88_13, arg_85_1.talkMaxDuration)

			if var_88_12 <= arg_85_1.time_ and arg_85_1.time_ < var_88_12 + var_88_22 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_12) / var_88_22

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_12 + var_88_22 and arg_85_1.time_ < var_88_12 + var_88_22 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play121521022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 121521022
		arg_89_1.duration_ = 12.4

		local var_89_0 = {
			ja = 12.4,
			ko = 5.266,
			zh = 5.266
		}
		local var_89_1 = manager.audio:GetLocalizationFlag()

		if var_89_0[var_89_1] ~= nil then
			arg_89_1.duration_ = var_89_0[var_89_1]
		end

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play121521023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = arg_89_1.actors_["1029ui_story"]
			local var_92_1 = 0

			if var_92_1 < arg_89_1.time_ and arg_89_1.time_ <= var_92_1 + arg_92_0 and not isNil(var_92_0) and arg_89_1.var_.characterEffect1029ui_story == nil then
				arg_89_1.var_.characterEffect1029ui_story = var_92_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_2 = 0.200000002980232

			if var_92_1 <= arg_89_1.time_ and arg_89_1.time_ < var_92_1 + var_92_2 and not isNil(var_92_0) then
				local var_92_3 = (arg_89_1.time_ - var_92_1) / var_92_2

				if arg_89_1.var_.characterEffect1029ui_story and not isNil(var_92_0) then
					arg_89_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_89_1.time_ >= var_92_1 + var_92_2 and arg_89_1.time_ < var_92_1 + var_92_2 + arg_92_0 and not isNil(var_92_0) and arg_89_1.var_.characterEffect1029ui_story then
				arg_89_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_92_4 = 0

			if var_92_4 < arg_89_1.time_ and arg_89_1.time_ <= var_92_4 + arg_92_0 then
				arg_89_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029actionlink/1029action424")
			end

			local var_92_5 = 0

			if var_92_5 < arg_89_1.time_ and arg_89_1.time_ <= var_92_5 + arg_92_0 then
				arg_89_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_92_6 = arg_89_1.actors_["1084ui_story"]
			local var_92_7 = 0

			if var_92_7 < arg_89_1.time_ and arg_89_1.time_ <= var_92_7 + arg_92_0 and not isNil(var_92_6) and arg_89_1.var_.characterEffect1084ui_story == nil then
				arg_89_1.var_.characterEffect1084ui_story = var_92_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_8 = 0.200000002980232

			if var_92_7 <= arg_89_1.time_ and arg_89_1.time_ < var_92_7 + var_92_8 and not isNil(var_92_6) then
				local var_92_9 = (arg_89_1.time_ - var_92_7) / var_92_8

				if arg_89_1.var_.characterEffect1084ui_story and not isNil(var_92_6) then
					local var_92_10 = Mathf.Lerp(0, 0.5, var_92_9)

					arg_89_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_89_1.var_.characterEffect1084ui_story.fillRatio = var_92_10
				end
			end

			if arg_89_1.time_ >= var_92_7 + var_92_8 and arg_89_1.time_ < var_92_7 + var_92_8 + arg_92_0 and not isNil(var_92_6) and arg_89_1.var_.characterEffect1084ui_story then
				local var_92_11 = 0.5

				arg_89_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_89_1.var_.characterEffect1084ui_story.fillRatio = var_92_11
			end

			local var_92_12 = 0
			local var_92_13 = 0.775

			if var_92_12 < arg_89_1.time_ and arg_89_1.time_ <= var_92_12 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				local var_92_14 = arg_89_1:FormatText(StoryNameCfg[319].name)

				arg_89_1.leftNameTxt_.text = var_92_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_15 = arg_89_1:GetWordFromCfg(121521022)
				local var_92_16 = arg_89_1:FormatText(var_92_15.content)

				arg_89_1.text_.text = var_92_16

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_17 = 31
				local var_92_18 = utf8.len(var_92_16)
				local var_92_19 = var_92_17 <= 0 and var_92_13 or var_92_13 * (var_92_18 / var_92_17)

				if var_92_19 > 0 and var_92_13 < var_92_19 then
					arg_89_1.talkMaxDuration = var_92_19

					if var_92_19 + var_92_12 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_19 + var_92_12
					end
				end

				arg_89_1.text_.text = var_92_16
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121521", "121521022", "story_v_out_121521.awb") ~= 0 then
					local var_92_20 = manager.audio:GetVoiceLength("story_v_out_121521", "121521022", "story_v_out_121521.awb") / 1000

					if var_92_20 + var_92_12 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_20 + var_92_12
					end

					if var_92_15.prefab_name ~= "" and arg_89_1.actors_[var_92_15.prefab_name] ~= nil then
						local var_92_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_15.prefab_name].transform, "story_v_out_121521", "121521022", "story_v_out_121521.awb")

						arg_89_1:RecordAudio("121521022", var_92_21)
						arg_89_1:RecordAudio("121521022", var_92_21)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_121521", "121521022", "story_v_out_121521.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_121521", "121521022", "story_v_out_121521.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_22 = math.max(var_92_13, arg_89_1.talkMaxDuration)

			if var_92_12 <= arg_89_1.time_ and arg_89_1.time_ < var_92_12 + var_92_22 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_12) / var_92_22

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_12 + var_92_22 and arg_89_1.time_ < var_92_12 + var_92_22 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play121521023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 121521023
		arg_93_1.duration_ = 14.07

		local var_93_0 = {
			ja = 14.066,
			ko = 10.766,
			zh = 10.766
		}
		local var_93_1 = manager.audio:GetLocalizationFlag()

		if var_93_0[var_93_1] ~= nil then
			arg_93_1.duration_ = var_93_0[var_93_1]
		end

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play121521024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = 0
			local var_96_1 = 1.025

			if var_96_0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_0 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				local var_96_2 = arg_93_1:FormatText(StoryNameCfg[319].name)

				arg_93_1.leftNameTxt_.text = var_96_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_3 = arg_93_1:GetWordFromCfg(121521023)
				local var_96_4 = arg_93_1:FormatText(var_96_3.content)

				arg_93_1.text_.text = var_96_4

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_5 = 41
				local var_96_6 = utf8.len(var_96_4)
				local var_96_7 = var_96_5 <= 0 and var_96_1 or var_96_1 * (var_96_6 / var_96_5)

				if var_96_7 > 0 and var_96_1 < var_96_7 then
					arg_93_1.talkMaxDuration = var_96_7

					if var_96_7 + var_96_0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_7 + var_96_0
					end
				end

				arg_93_1.text_.text = var_96_4
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121521", "121521023", "story_v_out_121521.awb") ~= 0 then
					local var_96_8 = manager.audio:GetVoiceLength("story_v_out_121521", "121521023", "story_v_out_121521.awb") / 1000

					if var_96_8 + var_96_0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_8 + var_96_0
					end

					if var_96_3.prefab_name ~= "" and arg_93_1.actors_[var_96_3.prefab_name] ~= nil then
						local var_96_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_3.prefab_name].transform, "story_v_out_121521", "121521023", "story_v_out_121521.awb")

						arg_93_1:RecordAudio("121521023", var_96_9)
						arg_93_1:RecordAudio("121521023", var_96_9)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_121521", "121521023", "story_v_out_121521.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_121521", "121521023", "story_v_out_121521.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_10 = math.max(var_96_1, arg_93_1.talkMaxDuration)

			if var_96_0 <= arg_93_1.time_ and arg_93_1.time_ < var_96_0 + var_96_10 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_0) / var_96_10

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_0 + var_96_10 and arg_93_1.time_ < var_96_0 + var_96_10 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play121521024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 121521024
		arg_97_1.duration_ = 5

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play121521025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = arg_97_1.actors_["1029ui_story"]
			local var_100_1 = 0

			if var_100_1 < arg_97_1.time_ and arg_97_1.time_ <= var_100_1 + arg_100_0 and not isNil(var_100_0) and arg_97_1.var_.characterEffect1029ui_story == nil then
				arg_97_1.var_.characterEffect1029ui_story = var_100_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_2 = 0.200000002980232

			if var_100_1 <= arg_97_1.time_ and arg_97_1.time_ < var_100_1 + var_100_2 and not isNil(var_100_0) then
				local var_100_3 = (arg_97_1.time_ - var_100_1) / var_100_2

				if arg_97_1.var_.characterEffect1029ui_story and not isNil(var_100_0) then
					local var_100_4 = Mathf.Lerp(0, 0.5, var_100_3)

					arg_97_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_97_1.var_.characterEffect1029ui_story.fillRatio = var_100_4
				end
			end

			if arg_97_1.time_ >= var_100_1 + var_100_2 and arg_97_1.time_ < var_100_1 + var_100_2 + arg_100_0 and not isNil(var_100_0) and arg_97_1.var_.characterEffect1029ui_story then
				local var_100_5 = 0.5

				arg_97_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_97_1.var_.characterEffect1029ui_story.fillRatio = var_100_5
			end

			local var_100_6 = 0
			local var_100_7 = 0.75

			if var_100_6 < arg_97_1.time_ and arg_97_1.time_ <= var_100_6 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				local var_100_8 = arg_97_1:FormatText(StoryNameCfg[7].name)

				arg_97_1.leftNameTxt_.text = var_100_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, true)
				arg_97_1.iconController_:SetSelectedState("hero")

				arg_97_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_97_1.callingController_:SetSelectedState("normal")

				arg_97_1.keyicon_.color = Color.New(1, 1, 1)
				arg_97_1.icon_.color = Color.New(1, 1, 1)

				local var_100_9 = arg_97_1:GetWordFromCfg(121521024)
				local var_100_10 = arg_97_1:FormatText(var_100_9.content)

				arg_97_1.text_.text = var_100_10

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_11 = 30
				local var_100_12 = utf8.len(var_100_10)
				local var_100_13 = var_100_11 <= 0 and var_100_7 or var_100_7 * (var_100_12 / var_100_11)

				if var_100_13 > 0 and var_100_7 < var_100_13 then
					arg_97_1.talkMaxDuration = var_100_13

					if var_100_13 + var_100_6 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_13 + var_100_6
					end
				end

				arg_97_1.text_.text = var_100_10
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)
				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_14 = math.max(var_100_7, arg_97_1.talkMaxDuration)

			if var_100_6 <= arg_97_1.time_ and arg_97_1.time_ < var_100_6 + var_100_14 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_6) / var_100_14

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_6 + var_100_14 and arg_97_1.time_ < var_100_6 + var_100_14 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play121521025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 121521025
		arg_101_1.duration_ = 4.47

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play121521026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = "STblack"

			if arg_101_1.bgs_[var_104_0] == nil then
				local var_104_1 = Object.Instantiate(arg_101_1.paintGo_)

				var_104_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_104_0)
				var_104_1.name = var_104_0
				var_104_1.transform.parent = arg_101_1.stage_.transform
				var_104_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_101_1.bgs_[var_104_0] = var_104_1
			end

			local var_104_2 = 2

			if var_104_2 < arg_101_1.time_ and arg_101_1.time_ <= var_104_2 + arg_104_0 then
				local var_104_3 = manager.ui.mainCamera.transform.localPosition
				local var_104_4 = Vector3.New(0, 0, 10) + Vector3.New(var_104_3.x, var_104_3.y, 0)
				local var_104_5 = arg_101_1.bgs_.STblack

				var_104_5.transform.localPosition = var_104_4
				var_104_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_104_6 = var_104_5:GetComponent("SpriteRenderer")

				if var_104_6 and var_104_6.sprite then
					local var_104_7 = (var_104_5.transform.localPosition - var_104_3).z
					local var_104_8 = manager.ui.mainCameraCom_
					local var_104_9 = 2 * var_104_7 * Mathf.Tan(var_104_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_104_10 = var_104_9 * var_104_8.aspect
					local var_104_11 = var_104_6.sprite.bounds.size.x
					local var_104_12 = var_104_6.sprite.bounds.size.y
					local var_104_13 = var_104_10 / var_104_11
					local var_104_14 = var_104_9 / var_104_12
					local var_104_15 = var_104_14 < var_104_13 and var_104_13 or var_104_14

					var_104_5.transform.localScale = Vector3.New(var_104_15, var_104_15, 0)
				end

				for iter_104_0, iter_104_1 in pairs(arg_101_1.bgs_) do
					if iter_104_0 ~= "STblack" then
						iter_104_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_104_16 = 0

			if var_104_16 < arg_101_1.time_ and arg_101_1.time_ <= var_104_16 + arg_104_0 then
				arg_101_1.mask_.enabled = true
				arg_101_1.mask_.raycastTarget = true

				arg_101_1:SetGaussion(false)
			end

			local var_104_17 = 2

			if var_104_16 <= arg_101_1.time_ and arg_101_1.time_ < var_104_16 + var_104_17 then
				local var_104_18 = (arg_101_1.time_ - var_104_16) / var_104_17
				local var_104_19 = Color.New(0, 0, 0)

				var_104_19.a = Mathf.Lerp(0, 1, var_104_18)
				arg_101_1.mask_.color = var_104_19
			end

			if arg_101_1.time_ >= var_104_16 + var_104_17 and arg_101_1.time_ < var_104_16 + var_104_17 + arg_104_0 then
				local var_104_20 = Color.New(0, 0, 0)

				var_104_20.a = 1
				arg_101_1.mask_.color = var_104_20
			end

			local var_104_21 = 2

			if var_104_21 < arg_101_1.time_ and arg_101_1.time_ <= var_104_21 + arg_104_0 then
				arg_101_1.mask_.enabled = true
				arg_101_1.mask_.raycastTarget = true

				arg_101_1:SetGaussion(false)
			end

			local var_104_22 = 2

			if var_104_21 <= arg_101_1.time_ and arg_101_1.time_ < var_104_21 + var_104_22 then
				local var_104_23 = (arg_101_1.time_ - var_104_21) / var_104_22
				local var_104_24 = Color.New(0, 0, 0)

				var_104_24.a = Mathf.Lerp(1, 0, var_104_23)
				arg_101_1.mask_.color = var_104_24
			end

			if arg_101_1.time_ >= var_104_21 + var_104_22 and arg_101_1.time_ < var_104_21 + var_104_22 + arg_104_0 then
				local var_104_25 = Color.New(0, 0, 0)
				local var_104_26 = 0

				arg_101_1.mask_.enabled = false
				var_104_25.a = var_104_26
				arg_101_1.mask_.color = var_104_25
			end

			local var_104_27 = arg_101_1.actors_["1029ui_story"].transform
			local var_104_28 = 1.96599999815226

			if var_104_28 < arg_101_1.time_ and arg_101_1.time_ <= var_104_28 + arg_104_0 then
				arg_101_1.var_.moveOldPos1029ui_story = var_104_27.localPosition
			end

			local var_104_29 = 0.001

			if var_104_28 <= arg_101_1.time_ and arg_101_1.time_ < var_104_28 + var_104_29 then
				local var_104_30 = (arg_101_1.time_ - var_104_28) / var_104_29
				local var_104_31 = Vector3.New(0, 100, 0)

				var_104_27.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos1029ui_story, var_104_31, var_104_30)

				local var_104_32 = manager.ui.mainCamera.transform.position - var_104_27.position

				var_104_27.forward = Vector3.New(var_104_32.x, var_104_32.y, var_104_32.z)

				local var_104_33 = var_104_27.localEulerAngles

				var_104_33.z = 0
				var_104_33.x = 0
				var_104_27.localEulerAngles = var_104_33
			end

			if arg_101_1.time_ >= var_104_28 + var_104_29 and arg_101_1.time_ < var_104_28 + var_104_29 + arg_104_0 then
				var_104_27.localPosition = Vector3.New(0, 100, 0)

				local var_104_34 = manager.ui.mainCamera.transform.position - var_104_27.position

				var_104_27.forward = Vector3.New(var_104_34.x, var_104_34.y, var_104_34.z)

				local var_104_35 = var_104_27.localEulerAngles

				var_104_35.z = 0
				var_104_35.x = 0
				var_104_27.localEulerAngles = var_104_35
			end

			local var_104_36 = arg_101_1.actors_["1029ui_story"]
			local var_104_37 = 1.96599999815226

			if var_104_37 < arg_101_1.time_ and arg_101_1.time_ <= var_104_37 + arg_104_0 and not isNil(var_104_36) and arg_101_1.var_.characterEffect1029ui_story == nil then
				arg_101_1.var_.characterEffect1029ui_story = var_104_36:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_38 = 0.034000001847744

			if var_104_37 <= arg_101_1.time_ and arg_101_1.time_ < var_104_37 + var_104_38 and not isNil(var_104_36) then
				local var_104_39 = (arg_101_1.time_ - var_104_37) / var_104_38

				if arg_101_1.var_.characterEffect1029ui_story and not isNil(var_104_36) then
					local var_104_40 = Mathf.Lerp(0, 0.5, var_104_39)

					arg_101_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_101_1.var_.characterEffect1029ui_story.fillRatio = var_104_40
				end
			end

			if arg_101_1.time_ >= var_104_37 + var_104_38 and arg_101_1.time_ < var_104_37 + var_104_38 + arg_104_0 and not isNil(var_104_36) and arg_101_1.var_.characterEffect1029ui_story then
				local var_104_41 = 0.5

				arg_101_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_101_1.var_.characterEffect1029ui_story.fillRatio = var_104_41
			end

			local var_104_42 = arg_101_1.actors_["1084ui_story"].transform
			local var_104_43 = 1.96599999815226

			if var_104_43 < arg_101_1.time_ and arg_101_1.time_ <= var_104_43 + arg_104_0 then
				arg_101_1.var_.moveOldPos1084ui_story = var_104_42.localPosition
			end

			local var_104_44 = 0.001

			if var_104_43 <= arg_101_1.time_ and arg_101_1.time_ < var_104_43 + var_104_44 then
				local var_104_45 = (arg_101_1.time_ - var_104_43) / var_104_44
				local var_104_46 = Vector3.New(0, 100, 0)

				var_104_42.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos1084ui_story, var_104_46, var_104_45)

				local var_104_47 = manager.ui.mainCamera.transform.position - var_104_42.position

				var_104_42.forward = Vector3.New(var_104_47.x, var_104_47.y, var_104_47.z)

				local var_104_48 = var_104_42.localEulerAngles

				var_104_48.z = 0
				var_104_48.x = 0
				var_104_42.localEulerAngles = var_104_48
			end

			if arg_101_1.time_ >= var_104_43 + var_104_44 and arg_101_1.time_ < var_104_43 + var_104_44 + arg_104_0 then
				var_104_42.localPosition = Vector3.New(0, 100, 0)

				local var_104_49 = manager.ui.mainCamera.transform.position - var_104_42.position

				var_104_42.forward = Vector3.New(var_104_49.x, var_104_49.y, var_104_49.z)

				local var_104_50 = var_104_42.localEulerAngles

				var_104_50.z = 0
				var_104_50.x = 0
				var_104_42.localEulerAngles = var_104_50
			end

			local var_104_51 = arg_101_1.actors_["1084ui_story"]
			local var_104_52 = 1.96599999815226

			if var_104_52 < arg_101_1.time_ and arg_101_1.time_ <= var_104_52 + arg_104_0 and not isNil(var_104_51) and arg_101_1.var_.characterEffect1084ui_story == nil then
				arg_101_1.var_.characterEffect1084ui_story = var_104_51:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_53 = 0.034000001847744

			if var_104_52 <= arg_101_1.time_ and arg_101_1.time_ < var_104_52 + var_104_53 and not isNil(var_104_51) then
				local var_104_54 = (arg_101_1.time_ - var_104_52) / var_104_53

				if arg_101_1.var_.characterEffect1084ui_story and not isNil(var_104_51) then
					local var_104_55 = Mathf.Lerp(0, 0.5, var_104_54)

					arg_101_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_101_1.var_.characterEffect1084ui_story.fillRatio = var_104_55
				end
			end

			if arg_101_1.time_ >= var_104_52 + var_104_53 and arg_101_1.time_ < var_104_52 + var_104_53 + arg_104_0 and not isNil(var_104_51) and arg_101_1.var_.characterEffect1084ui_story then
				local var_104_56 = 0.5

				arg_101_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_101_1.var_.characterEffect1084ui_story.fillRatio = var_104_56
			end

			local var_104_57 = 2

			if var_104_57 < arg_101_1.time_ and arg_101_1.time_ <= var_104_57 + arg_104_0 then
				arg_101_1.fswbg_:SetActive(true)
				arg_101_1.dialog_:SetActive(false)

				arg_101_1.fswtw_.percent = 0

				local var_104_58 = arg_101_1:GetWordFromCfg(121521025)
				local var_104_59 = arg_101_1:FormatText(var_104_58.content)

				arg_101_1.fswt_.text = var_104_59

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.fswt_)

				arg_101_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_101_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_101_1.fswtw_:SetDirty()

				arg_101_1.typewritterCharCountI18N = 0

				SetActive(arg_101_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_101_1:ShowNextGo(false)
			end

			local var_104_60 = 2.01666666666667

			if var_104_60 < arg_101_1.time_ and arg_101_1.time_ <= var_104_60 + arg_104_0 then
				arg_101_1.var_.oldValueTypewriter = arg_101_1.fswtw_.percent

				SetActive(arg_101_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_101_1:ShowNextGo(false)
			end

			local var_104_61 = 21
			local var_104_62 = 1.4
			local var_104_63 = arg_101_1:GetWordFromCfg(121521025)
			local var_104_64 = arg_101_1:FormatText(var_104_63.content)
			local var_104_65, var_104_66 = arg_101_1:GetPercentByPara(var_104_64, 1)

			if var_104_60 < arg_101_1.time_ and arg_101_1.time_ <= var_104_60 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0

				local var_104_67 = var_104_61 <= 0 and var_104_62 or var_104_62 * ((var_104_66 - arg_101_1.typewritterCharCountI18N) / var_104_61)

				if var_104_67 > 0 and var_104_62 < var_104_67 then
					arg_101_1.talkMaxDuration = var_104_67

					if var_104_67 + var_104_60 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_67 + var_104_60
					end
				end
			end

			local var_104_68 = 1.4
			local var_104_69 = math.max(var_104_68, arg_101_1.talkMaxDuration)

			if var_104_60 <= arg_101_1.time_ and arg_101_1.time_ < var_104_60 + var_104_69 then
				local var_104_70 = (arg_101_1.time_ - var_104_60) / var_104_69

				arg_101_1.fswtw_.percent = Mathf.Lerp(arg_101_1.var_.oldValueTypewriter, var_104_65, var_104_70)
				arg_101_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_101_1.fswtw_:SetDirty()
			end

			if arg_101_1.time_ >= var_104_60 + var_104_69 and arg_101_1.time_ < var_104_60 + var_104_69 + arg_104_0 then
				arg_101_1.fswtw_.percent = var_104_65

				arg_101_1.fswtw_:SetDirty()
				arg_101_1:ShowNextGo(true)

				arg_101_1.typewritterCharCountI18N = var_104_66
			end

			local var_104_71 = 2

			if var_104_71 < arg_101_1.time_ and arg_101_1.time_ <= var_104_71 + arg_104_0 then
				local var_104_72 = arg_101_1.fswbg_.transform:Find("textbox/adapt/content") or arg_101_1.fswbg_.transform:Find("textbox/content")
				local var_104_73 = arg_101_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_104_74 = var_104_72:GetComponent("Text")
				local var_104_75 = var_104_72:GetComponent("RectTransform")

				var_104_74.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_104_75.offsetMin = Vector2.New(0, 0)
				var_104_75.offsetMax = Vector2.New(0, 0)
			end

			local var_104_76 = 0.3
			local var_104_77 = 0.333333333333333

			if var_104_76 < arg_101_1.time_ and arg_101_1.time_ <= var_104_76 + arg_104_0 then
				local var_104_78 = "play"
				local var_104_79 = "effect"

				arg_101_1:AudioAction(var_104_78, var_104_79, "se_story_121_04", "se_story_121_04_recordopen", "")
			end
		end

		arg_101_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1029ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_101_1:InitPlayNodeList()
	end,
	Play121521026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 121521026
		arg_105_1.duration_ = 9

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play121521027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = "J12g"

			if arg_105_1.bgs_[var_108_0] == nil then
				local var_108_1 = Object.Instantiate(arg_105_1.paintGo_)

				var_108_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_108_0)
				var_108_1.name = var_108_0
				var_108_1.transform.parent = arg_105_1.stage_.transform
				var_108_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_105_1.bgs_[var_108_0] = var_108_1
			end

			local var_108_2 = 1.98333333333333

			if var_108_2 < arg_105_1.time_ and arg_105_1.time_ <= var_108_2 + arg_108_0 then
				local var_108_3 = manager.ui.mainCamera.transform.localPosition
				local var_108_4 = Vector3.New(0, 0, 10) + Vector3.New(var_108_3.x, var_108_3.y, 0)
				local var_108_5 = arg_105_1.bgs_.J12g

				var_108_5.transform.localPosition = var_108_4
				var_108_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_108_6 = var_108_5:GetComponent("SpriteRenderer")

				if var_108_6 and var_108_6.sprite then
					local var_108_7 = (var_108_5.transform.localPosition - var_108_3).z
					local var_108_8 = manager.ui.mainCameraCom_
					local var_108_9 = 2 * var_108_7 * Mathf.Tan(var_108_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_108_10 = var_108_9 * var_108_8.aspect
					local var_108_11 = var_108_6.sprite.bounds.size.x
					local var_108_12 = var_108_6.sprite.bounds.size.y
					local var_108_13 = var_108_10 / var_108_11
					local var_108_14 = var_108_9 / var_108_12
					local var_108_15 = var_108_14 < var_108_13 and var_108_13 or var_108_14

					var_108_5.transform.localScale = Vector3.New(var_108_15, var_108_15, 0)
				end

				for iter_108_0, iter_108_1 in pairs(arg_105_1.bgs_) do
					if iter_108_0 ~= "J12g" then
						iter_108_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_108_16 = 0

			if var_108_16 < arg_105_1.time_ and arg_105_1.time_ <= var_108_16 + arg_108_0 then
				arg_105_1.mask_.enabled = true
				arg_105_1.mask_.raycastTarget = true

				arg_105_1:SetGaussion(false)
			end

			local var_108_17 = 2

			if var_108_16 <= arg_105_1.time_ and arg_105_1.time_ < var_108_16 + var_108_17 then
				local var_108_18 = (arg_105_1.time_ - var_108_16) / var_108_17
				local var_108_19 = Color.New(0, 0, 0)

				var_108_19.a = Mathf.Lerp(0, 1, var_108_18)
				arg_105_1.mask_.color = var_108_19
			end

			if arg_105_1.time_ >= var_108_16 + var_108_17 and arg_105_1.time_ < var_108_16 + var_108_17 + arg_108_0 then
				local var_108_20 = Color.New(0, 0, 0)

				var_108_20.a = 1
				arg_105_1.mask_.color = var_108_20
			end

			local var_108_21 = 2

			if var_108_21 < arg_105_1.time_ and arg_105_1.time_ <= var_108_21 + arg_108_0 then
				arg_105_1.mask_.enabled = true
				arg_105_1.mask_.raycastTarget = true

				arg_105_1:SetGaussion(false)
			end

			local var_108_22 = 2

			if var_108_21 <= arg_105_1.time_ and arg_105_1.time_ < var_108_21 + var_108_22 then
				local var_108_23 = (arg_105_1.time_ - var_108_21) / var_108_22
				local var_108_24 = Color.New(0, 0, 0)

				var_108_24.a = Mathf.Lerp(1, 0, var_108_23)
				arg_105_1.mask_.color = var_108_24
			end

			if arg_105_1.time_ >= var_108_21 + var_108_22 and arg_105_1.time_ < var_108_21 + var_108_22 + arg_108_0 then
				local var_108_25 = Color.New(0, 0, 0)
				local var_108_26 = 0

				arg_105_1.mask_.enabled = false
				var_108_25.a = var_108_26
				arg_105_1.mask_.color = var_108_25
			end

			local var_108_27 = arg_105_1.actors_["1029ui_story"].transform
			local var_108_28 = 3.8

			if var_108_28 < arg_105_1.time_ and arg_105_1.time_ <= var_108_28 + arg_108_0 then
				arg_105_1.var_.moveOldPos1029ui_story = var_108_27.localPosition
			end

			local var_108_29 = 0.001

			if var_108_28 <= arg_105_1.time_ and arg_105_1.time_ < var_108_28 + var_108_29 then
				local var_108_30 = (arg_105_1.time_ - var_108_28) / var_108_29
				local var_108_31 = Vector3.New(0, -1.09, -6.2)

				var_108_27.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos1029ui_story, var_108_31, var_108_30)

				local var_108_32 = manager.ui.mainCamera.transform.position - var_108_27.position

				var_108_27.forward = Vector3.New(var_108_32.x, var_108_32.y, var_108_32.z)

				local var_108_33 = var_108_27.localEulerAngles

				var_108_33.z = 0
				var_108_33.x = 0
				var_108_27.localEulerAngles = var_108_33
			end

			if arg_105_1.time_ >= var_108_28 + var_108_29 and arg_105_1.time_ < var_108_28 + var_108_29 + arg_108_0 then
				var_108_27.localPosition = Vector3.New(0, -1.09, -6.2)

				local var_108_34 = manager.ui.mainCamera.transform.position - var_108_27.position

				var_108_27.forward = Vector3.New(var_108_34.x, var_108_34.y, var_108_34.z)

				local var_108_35 = var_108_27.localEulerAngles

				var_108_35.z = 0
				var_108_35.x = 0
				var_108_27.localEulerAngles = var_108_35
			end

			local var_108_36 = arg_105_1.actors_["1029ui_story"]
			local var_108_37 = 3.8

			if var_108_37 < arg_105_1.time_ and arg_105_1.time_ <= var_108_37 + arg_108_0 and not isNil(var_108_36) and arg_105_1.var_.characterEffect1029ui_story == nil then
				arg_105_1.var_.characterEffect1029ui_story = var_108_36:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_38 = 0.200000002980232

			if var_108_37 <= arg_105_1.time_ and arg_105_1.time_ < var_108_37 + var_108_38 and not isNil(var_108_36) then
				local var_108_39 = (arg_105_1.time_ - var_108_37) / var_108_38

				if arg_105_1.var_.characterEffect1029ui_story and not isNil(var_108_36) then
					local var_108_40 = Mathf.Lerp(0, 0.5, var_108_39)

					arg_105_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_105_1.var_.characterEffect1029ui_story.fillRatio = var_108_40
				end
			end

			if arg_105_1.time_ >= var_108_37 + var_108_38 and arg_105_1.time_ < var_108_37 + var_108_38 + arg_108_0 and not isNil(var_108_36) and arg_105_1.var_.characterEffect1029ui_story then
				local var_108_41 = 0.5

				arg_105_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_105_1.var_.characterEffect1029ui_story.fillRatio = var_108_41
			end

			local var_108_42 = 1.98333333333333

			if var_108_42 < arg_105_1.time_ and arg_105_1.time_ <= var_108_42 + arg_108_0 then
				arg_105_1.fswbg_:SetActive(false)
				arg_105_1.dialog_:SetActive(false)
				SetActive(arg_105_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_105_1:ShowNextGo(false)
			end

			if arg_105_1.frameCnt_ <= 1 then
				arg_105_1.dialog_:SetActive(false)
			end

			local var_108_43 = 4
			local var_108_44 = 0.5

			if var_108_43 < arg_105_1.time_ and arg_105_1.time_ <= var_108_43 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0

				arg_105_1.dialog_:SetActive(true)

				arg_105_1.dialogCg_.alpha = 0

				local var_108_45 = LeanTween.value(arg_105_1.dialog_, 0, 1, 0.3)

				var_108_45:setOnUpdate(LuaHelper.FloatAction(function(arg_109_0)
					arg_105_1.dialogCg_.alpha = arg_109_0
				end))
				var_108_45:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_105_1.dialog_)
					var_108_45:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_105_1.duration_ = arg_105_1.duration_ + 0.3

				SetActive(arg_105_1.leftNameGo_, true)

				local var_108_46 = arg_105_1:FormatText(StoryNameCfg[7].name)

				arg_105_1.leftNameTxt_.text = var_108_46

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, true)
				arg_105_1.iconController_:SetSelectedState("hero")

				arg_105_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_105_1.callingController_:SetSelectedState("normal")

				arg_105_1.keyicon_.color = Color.New(1, 1, 1)
				arg_105_1.icon_.color = Color.New(1, 1, 1)

				local var_108_47 = arg_105_1:GetWordFromCfg(121521026)
				local var_108_48 = arg_105_1:FormatText(var_108_47.content)

				arg_105_1.text_.text = var_108_48

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_49 = 20
				local var_108_50 = utf8.len(var_108_48)
				local var_108_51 = var_108_49 <= 0 and var_108_44 or var_108_44 * (var_108_50 / var_108_49)

				if var_108_51 > 0 and var_108_44 < var_108_51 then
					arg_105_1.talkMaxDuration = var_108_51
					var_108_43 = var_108_43 + 0.3

					if var_108_51 + var_108_43 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_51 + var_108_43
					end
				end

				arg_105_1.text_.text = var_108_48
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)
				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_52 = var_108_43 + 0.3
			local var_108_53 = math.max(var_108_44, arg_105_1.talkMaxDuration)

			if var_108_52 <= arg_105_1.time_ and arg_105_1.time_ < var_108_52 + var_108_53 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_52) / var_108_53

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_52 + var_108_53 and arg_105_1.time_ < var_108_52 + var_108_53 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1029ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_105_1:InitPlayNodeList()
	end,
	Play121521027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 121521027
		arg_111_1.duration_ = 6.87

		local var_111_0 = {
			ja = 5.433,
			ko = 6.866,
			zh = 6.866
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
				arg_111_0:Play121521028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = arg_111_1.actors_["1029ui_story"]
			local var_114_1 = 0

			if var_114_1 < arg_111_1.time_ and arg_111_1.time_ <= var_114_1 + arg_114_0 and not isNil(var_114_0) and arg_111_1.var_.characterEffect1029ui_story == nil then
				arg_111_1.var_.characterEffect1029ui_story = var_114_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_2 = 0.200000002980232

			if var_114_1 <= arg_111_1.time_ and arg_111_1.time_ < var_114_1 + var_114_2 and not isNil(var_114_0) then
				local var_114_3 = (arg_111_1.time_ - var_114_1) / var_114_2

				if arg_111_1.var_.characterEffect1029ui_story and not isNil(var_114_0) then
					arg_111_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_111_1.time_ >= var_114_1 + var_114_2 and arg_111_1.time_ < var_114_1 + var_114_2 + arg_114_0 and not isNil(var_114_0) and arg_111_1.var_.characterEffect1029ui_story then
				arg_111_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_114_4 = 0
			local var_114_5 = 0.35

			if var_114_4 < arg_111_1.time_ and arg_111_1.time_ <= var_114_4 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				local var_114_6 = arg_111_1:FormatText(StoryNameCfg[319].name)

				arg_111_1.leftNameTxt_.text = var_114_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_7 = arg_111_1:GetWordFromCfg(121521027)
				local var_114_8 = arg_111_1:FormatText(var_114_7.content)

				arg_111_1.text_.text = var_114_8

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_9 = 14
				local var_114_10 = utf8.len(var_114_8)
				local var_114_11 = var_114_9 <= 0 and var_114_5 or var_114_5 * (var_114_10 / var_114_9)

				if var_114_11 > 0 and var_114_5 < var_114_11 then
					arg_111_1.talkMaxDuration = var_114_11

					if var_114_11 + var_114_4 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_11 + var_114_4
					end
				end

				arg_111_1.text_.text = var_114_8
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121521", "121521027", "story_v_out_121521.awb") ~= 0 then
					local var_114_12 = manager.audio:GetVoiceLength("story_v_out_121521", "121521027", "story_v_out_121521.awb") / 1000

					if var_114_12 + var_114_4 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_12 + var_114_4
					end

					if var_114_7.prefab_name ~= "" and arg_111_1.actors_[var_114_7.prefab_name] ~= nil then
						local var_114_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_7.prefab_name].transform, "story_v_out_121521", "121521027", "story_v_out_121521.awb")

						arg_111_1:RecordAudio("121521027", var_114_13)
						arg_111_1:RecordAudio("121521027", var_114_13)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_121521", "121521027", "story_v_out_121521.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_121521", "121521027", "story_v_out_121521.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_14 = math.max(var_114_5, arg_111_1.talkMaxDuration)

			if var_114_4 <= arg_111_1.time_ and arg_111_1.time_ < var_114_4 + var_114_14 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_4) / var_114_14

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_4 + var_114_14 and arg_111_1.time_ < var_114_4 + var_114_14 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play121521028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 121521028
		arg_115_1.duration_ = 5

		SetActive(arg_115_1.tipsGo_, false)

		function arg_115_1.onSingleLineFinish_()
			arg_115_1.onSingleLineUpdate_ = nil
			arg_115_1.onSingleLineFinish_ = nil
			arg_115_1.state_ = "waiting"
		end

		function arg_115_1.playNext_(arg_117_0)
			if arg_117_0 == 1 then
				arg_115_0:Play121521029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = arg_115_1.actors_["1029ui_story"]
			local var_118_1 = 0

			if var_118_1 < arg_115_1.time_ and arg_115_1.time_ <= var_118_1 + arg_118_0 and not isNil(var_118_0) and arg_115_1.var_.characterEffect1029ui_story == nil then
				arg_115_1.var_.characterEffect1029ui_story = var_118_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_2 = 0.200000002980232

			if var_118_1 <= arg_115_1.time_ and arg_115_1.time_ < var_118_1 + var_118_2 and not isNil(var_118_0) then
				local var_118_3 = (arg_115_1.time_ - var_118_1) / var_118_2

				if arg_115_1.var_.characterEffect1029ui_story and not isNil(var_118_0) then
					local var_118_4 = Mathf.Lerp(0, 0.5, var_118_3)

					arg_115_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_115_1.var_.characterEffect1029ui_story.fillRatio = var_118_4
				end
			end

			if arg_115_1.time_ >= var_118_1 + var_118_2 and arg_115_1.time_ < var_118_1 + var_118_2 + arg_118_0 and not isNil(var_118_0) and arg_115_1.var_.characterEffect1029ui_story then
				local var_118_5 = 0.5

				arg_115_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_115_1.var_.characterEffect1029ui_story.fillRatio = var_118_5
			end

			local var_118_6 = 0
			local var_118_7 = 0.175

			if var_118_6 < arg_115_1.time_ and arg_115_1.time_ <= var_118_6 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				local var_118_8 = arg_115_1:FormatText(StoryNameCfg[7].name)

				arg_115_1.leftNameTxt_.text = var_118_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, true)
				arg_115_1.iconController_:SetSelectedState("hero")

				arg_115_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_115_1.callingController_:SetSelectedState("normal")

				arg_115_1.keyicon_.color = Color.New(1, 1, 1)
				arg_115_1.icon_.color = Color.New(1, 1, 1)

				local var_118_9 = arg_115_1:GetWordFromCfg(121521028)
				local var_118_10 = arg_115_1:FormatText(var_118_9.content)

				arg_115_1.text_.text = var_118_10

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_11 = 7
				local var_118_12 = utf8.len(var_118_10)
				local var_118_13 = var_118_11 <= 0 and var_118_7 or var_118_7 * (var_118_12 / var_118_11)

				if var_118_13 > 0 and var_118_7 < var_118_13 then
					arg_115_1.talkMaxDuration = var_118_13

					if var_118_13 + var_118_6 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_13 + var_118_6
					end
				end

				arg_115_1.text_.text = var_118_10
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)
				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_14 = math.max(var_118_7, arg_115_1.talkMaxDuration)

			if var_118_6 <= arg_115_1.time_ and arg_115_1.time_ < var_118_6 + var_118_14 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_6) / var_118_14

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_6 + var_118_14 and arg_115_1.time_ < var_118_6 + var_118_14 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {}

		arg_115_1:InitPlayNodeList()
	end,
	Play121521029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 121521029
		arg_119_1.duration_ = 5

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play121521030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = 0
			local var_122_1 = 0.9

			if var_122_0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_0 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, false)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_2 = arg_119_1:GetWordFromCfg(121521029)
				local var_122_3 = arg_119_1:FormatText(var_122_2.content)

				arg_119_1.text_.text = var_122_3

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_4 = 36
				local var_122_5 = utf8.len(var_122_3)
				local var_122_6 = var_122_4 <= 0 and var_122_1 or var_122_1 * (var_122_5 / var_122_4)

				if var_122_6 > 0 and var_122_1 < var_122_6 then
					arg_119_1.talkMaxDuration = var_122_6

					if var_122_6 + var_122_0 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_6 + var_122_0
					end
				end

				arg_119_1.text_.text = var_122_3
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)
				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_7 = math.max(var_122_1, arg_119_1.talkMaxDuration)

			if var_122_0 <= arg_119_1.time_ and arg_119_1.time_ < var_122_0 + var_122_7 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_0) / var_122_7

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_0 + var_122_7 and arg_119_1.time_ < var_122_0 + var_122_7 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {}

		arg_119_1:InitPlayNodeList()
	end,
	Play121521030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 121521030
		arg_123_1.duration_ = 10.23

		local var_123_0 = {
			ja = 10.233,
			ko = 5.766,
			zh = 5.766
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
				arg_123_0:Play121521031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = arg_123_1.actors_["1029ui_story"]
			local var_126_1 = 0

			if var_126_1 < arg_123_1.time_ and arg_123_1.time_ <= var_126_1 + arg_126_0 and not isNil(var_126_0) and arg_123_1.var_.characterEffect1029ui_story == nil then
				arg_123_1.var_.characterEffect1029ui_story = var_126_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_2 = 0.200000002980232

			if var_126_1 <= arg_123_1.time_ and arg_123_1.time_ < var_126_1 + var_126_2 and not isNil(var_126_0) then
				local var_126_3 = (arg_123_1.time_ - var_126_1) / var_126_2

				if arg_123_1.var_.characterEffect1029ui_story and not isNil(var_126_0) then
					arg_123_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_123_1.time_ >= var_126_1 + var_126_2 and arg_123_1.time_ < var_126_1 + var_126_2 + arg_126_0 and not isNil(var_126_0) and arg_123_1.var_.characterEffect1029ui_story then
				arg_123_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_126_4 = 0

			if var_126_4 < arg_123_1.time_ and arg_123_1.time_ <= var_126_4 + arg_126_0 then
				arg_123_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029actionlink/1029action442")
			end

			local var_126_5 = 0

			if var_126_5 < arg_123_1.time_ and arg_123_1.time_ <= var_126_5 + arg_126_0 then
				arg_123_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_126_6 = 0
			local var_126_7 = 0.65

			if var_126_6 < arg_123_1.time_ and arg_123_1.time_ <= var_126_6 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				local var_126_8 = arg_123_1:FormatText(StoryNameCfg[319].name)

				arg_123_1.leftNameTxt_.text = var_126_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_9 = arg_123_1:GetWordFromCfg(121521030)
				local var_126_10 = arg_123_1:FormatText(var_126_9.content)

				arg_123_1.text_.text = var_126_10

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_11 = 26
				local var_126_12 = utf8.len(var_126_10)
				local var_126_13 = var_126_11 <= 0 and var_126_7 or var_126_7 * (var_126_12 / var_126_11)

				if var_126_13 > 0 and var_126_7 < var_126_13 then
					arg_123_1.talkMaxDuration = var_126_13

					if var_126_13 + var_126_6 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_13 + var_126_6
					end
				end

				arg_123_1.text_.text = var_126_10
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121521", "121521030", "story_v_out_121521.awb") ~= 0 then
					local var_126_14 = manager.audio:GetVoiceLength("story_v_out_121521", "121521030", "story_v_out_121521.awb") / 1000

					if var_126_14 + var_126_6 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_14 + var_126_6
					end

					if var_126_9.prefab_name ~= "" and arg_123_1.actors_[var_126_9.prefab_name] ~= nil then
						local var_126_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_9.prefab_name].transform, "story_v_out_121521", "121521030", "story_v_out_121521.awb")

						arg_123_1:RecordAudio("121521030", var_126_15)
						arg_123_1:RecordAudio("121521030", var_126_15)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_121521", "121521030", "story_v_out_121521.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_121521", "121521030", "story_v_out_121521.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_16 = math.max(var_126_7, arg_123_1.talkMaxDuration)

			if var_126_6 <= arg_123_1.time_ and arg_123_1.time_ < var_126_6 + var_126_16 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_6) / var_126_16

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_6 + var_126_16 and arg_123_1.time_ < var_126_6 + var_126_16 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play121521031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 121521031
		arg_127_1.duration_ = 5

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play121521032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = arg_127_1.actors_["1029ui_story"]
			local var_130_1 = 0

			if var_130_1 < arg_127_1.time_ and arg_127_1.time_ <= var_130_1 + arg_130_0 and not isNil(var_130_0) and arg_127_1.var_.characterEffect1029ui_story == nil then
				arg_127_1.var_.characterEffect1029ui_story = var_130_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_2 = 0.200000002980232

			if var_130_1 <= arg_127_1.time_ and arg_127_1.time_ < var_130_1 + var_130_2 and not isNil(var_130_0) then
				local var_130_3 = (arg_127_1.time_ - var_130_1) / var_130_2

				if arg_127_1.var_.characterEffect1029ui_story and not isNil(var_130_0) then
					local var_130_4 = Mathf.Lerp(0, 0.5, var_130_3)

					arg_127_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_127_1.var_.characterEffect1029ui_story.fillRatio = var_130_4
				end
			end

			if arg_127_1.time_ >= var_130_1 + var_130_2 and arg_127_1.time_ < var_130_1 + var_130_2 + arg_130_0 and not isNil(var_130_0) and arg_127_1.var_.characterEffect1029ui_story then
				local var_130_5 = 0.5

				arg_127_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_127_1.var_.characterEffect1029ui_story.fillRatio = var_130_5
			end

			local var_130_6 = 0
			local var_130_7 = 0.55

			if var_130_6 < arg_127_1.time_ and arg_127_1.time_ <= var_130_6 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				local var_130_8 = arg_127_1:FormatText(StoryNameCfg[7].name)

				arg_127_1.leftNameTxt_.text = var_130_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, true)
				arg_127_1.iconController_:SetSelectedState("hero")

				arg_127_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_127_1.callingController_:SetSelectedState("normal")

				arg_127_1.keyicon_.color = Color.New(1, 1, 1)
				arg_127_1.icon_.color = Color.New(1, 1, 1)

				local var_130_9 = arg_127_1:GetWordFromCfg(121521031)
				local var_130_10 = arg_127_1:FormatText(var_130_9.content)

				arg_127_1.text_.text = var_130_10

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_11 = 22
				local var_130_12 = utf8.len(var_130_10)
				local var_130_13 = var_130_11 <= 0 and var_130_7 or var_130_7 * (var_130_12 / var_130_11)

				if var_130_13 > 0 and var_130_7 < var_130_13 then
					arg_127_1.talkMaxDuration = var_130_13

					if var_130_13 + var_130_6 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_13 + var_130_6
					end
				end

				arg_127_1.text_.text = var_130_10
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)
				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_14 = math.max(var_130_7, arg_127_1.talkMaxDuration)

			if var_130_6 <= arg_127_1.time_ and arg_127_1.time_ < var_130_6 + var_130_14 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_6) / var_130_14

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_6 + var_130_14 and arg_127_1.time_ < var_130_6 + var_130_14 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play121521032 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 121521032
		arg_131_1.duration_ = 5

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play121521033(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = arg_131_1.actors_["1029ui_story"].transform
			local var_134_1 = 0

			if var_134_1 < arg_131_1.time_ and arg_131_1.time_ <= var_134_1 + arg_134_0 then
				arg_131_1.var_.moveOldPos1029ui_story = var_134_0.localPosition
			end

			local var_134_2 = 0.001

			if var_134_1 <= arg_131_1.time_ and arg_131_1.time_ < var_134_1 + var_134_2 then
				local var_134_3 = (arg_131_1.time_ - var_134_1) / var_134_2
				local var_134_4 = Vector3.New(0, 100, 0)

				var_134_0.localPosition = Vector3.Lerp(arg_131_1.var_.moveOldPos1029ui_story, var_134_4, var_134_3)

				local var_134_5 = manager.ui.mainCamera.transform.position - var_134_0.position

				var_134_0.forward = Vector3.New(var_134_5.x, var_134_5.y, var_134_5.z)

				local var_134_6 = var_134_0.localEulerAngles

				var_134_6.z = 0
				var_134_6.x = 0
				var_134_0.localEulerAngles = var_134_6
			end

			if arg_131_1.time_ >= var_134_1 + var_134_2 and arg_131_1.time_ < var_134_1 + var_134_2 + arg_134_0 then
				var_134_0.localPosition = Vector3.New(0, 100, 0)

				local var_134_7 = manager.ui.mainCamera.transform.position - var_134_0.position

				var_134_0.forward = Vector3.New(var_134_7.x, var_134_7.y, var_134_7.z)

				local var_134_8 = var_134_0.localEulerAngles

				var_134_8.z = 0
				var_134_8.x = 0
				var_134_0.localEulerAngles = var_134_8
			end

			local var_134_9 = arg_131_1.actors_["1029ui_story"]
			local var_134_10 = 0

			if var_134_10 < arg_131_1.time_ and arg_131_1.time_ <= var_134_10 + arg_134_0 and not isNil(var_134_9) and arg_131_1.var_.characterEffect1029ui_story == nil then
				arg_131_1.var_.characterEffect1029ui_story = var_134_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_11 = 0.200000002980232

			if var_134_10 <= arg_131_1.time_ and arg_131_1.time_ < var_134_10 + var_134_11 and not isNil(var_134_9) then
				local var_134_12 = (arg_131_1.time_ - var_134_10) / var_134_11

				if arg_131_1.var_.characterEffect1029ui_story and not isNil(var_134_9) then
					local var_134_13 = Mathf.Lerp(0, 0.5, var_134_12)

					arg_131_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_131_1.var_.characterEffect1029ui_story.fillRatio = var_134_13
				end
			end

			if arg_131_1.time_ >= var_134_10 + var_134_11 and arg_131_1.time_ < var_134_10 + var_134_11 + arg_134_0 and not isNil(var_134_9) and arg_131_1.var_.characterEffect1029ui_story then
				local var_134_14 = 0.5

				arg_131_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_131_1.var_.characterEffect1029ui_story.fillRatio = var_134_14
			end

			local var_134_15 = 0
			local var_134_16 = 1

			if var_134_15 < arg_131_1.time_ and arg_131_1.time_ <= var_134_15 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, false)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_17 = arg_131_1:GetWordFromCfg(121521032)
				local var_134_18 = arg_131_1:FormatText(var_134_17.content)

				arg_131_1.text_.text = var_134_18

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_19 = 40
				local var_134_20 = utf8.len(var_134_18)
				local var_134_21 = var_134_19 <= 0 and var_134_16 or var_134_16 * (var_134_20 / var_134_19)

				if var_134_21 > 0 and var_134_16 < var_134_21 then
					arg_131_1.talkMaxDuration = var_134_21

					if var_134_21 + var_134_15 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_21 + var_134_15
					end
				end

				arg_131_1.text_.text = var_134_18
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)
				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_22 = math.max(var_134_16, arg_131_1.talkMaxDuration)

			if var_134_15 <= arg_131_1.time_ and arg_131_1.time_ < var_134_15 + var_134_22 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_15) / var_134_22

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_15 + var_134_22 and arg_131_1.time_ < var_134_15 + var_134_22 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1029ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_131_1:InitPlayNodeList()
	end,
	Play121521033 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 121521033
		arg_135_1.duration_ = 5

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play121521034(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = 0
			local var_138_1 = 0.75

			if var_138_0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_0 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, false)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_2 = arg_135_1:GetWordFromCfg(121521033)
				local var_138_3 = arg_135_1:FormatText(var_138_2.content)

				arg_135_1.text_.text = var_138_3

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_4 = 30
				local var_138_5 = utf8.len(var_138_3)
				local var_138_6 = var_138_4 <= 0 and var_138_1 or var_138_1 * (var_138_5 / var_138_4)

				if var_138_6 > 0 and var_138_1 < var_138_6 then
					arg_135_1.talkMaxDuration = var_138_6

					if var_138_6 + var_138_0 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_6 + var_138_0
					end
				end

				arg_135_1.text_.text = var_138_3
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)
				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_7 = math.max(var_138_1, arg_135_1.talkMaxDuration)

			if var_138_0 <= arg_135_1.time_ and arg_135_1.time_ < var_138_0 + var_138_7 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_0) / var_138_7

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_0 + var_138_7 and arg_135_1.time_ < var_138_0 + var_138_7 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play121521034 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 121521034
		arg_139_1.duration_ = 6.5

		local var_139_0 = {
			ja = 6.5,
			ko = 3.6,
			zh = 3.6
		}
		local var_139_1 = manager.audio:GetLocalizationFlag()

		if var_139_0[var_139_1] ~= nil then
			arg_139_1.duration_ = var_139_0[var_139_1]
		end

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play121521035(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = "1075ui_story"

			if arg_139_1.actors_[var_142_0] == nil then
				local var_142_1 = Asset.Load("Char/" .. "1075ui_story")

				if not isNil(var_142_1) then
					local var_142_2 = Object.Instantiate(Asset.Load("Char/" .. "1075ui_story"), arg_139_1.stage_.transform)

					var_142_2.name = var_142_0
					var_142_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_139_1.actors_[var_142_0] = var_142_2

					local var_142_3 = var_142_2:GetComponentInChildren(typeof(CharacterEffect))

					var_142_3.enabled = true

					local var_142_4 = GameObjectTools.GetOrAddComponent(var_142_2, typeof(DynamicBoneHelper))

					if var_142_4 then
						var_142_4:EnableDynamicBone(false)
					end

					arg_139_1:ShowWeapon(var_142_3.transform, false)

					arg_139_1.var_[var_142_0 .. "Animator"] = var_142_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_139_1.var_[var_142_0 .. "Animator"].applyRootMotion = true
					arg_139_1.var_[var_142_0 .. "LipSync"] = var_142_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_142_5 = arg_139_1.actors_["1075ui_story"].transform
			local var_142_6 = 0

			if var_142_6 < arg_139_1.time_ and arg_139_1.time_ <= var_142_6 + arg_142_0 then
				arg_139_1.var_.moveOldPos1075ui_story = var_142_5.localPosition
			end

			local var_142_7 = 0.001

			if var_142_6 <= arg_139_1.time_ and arg_139_1.time_ < var_142_6 + var_142_7 then
				local var_142_8 = (arg_139_1.time_ - var_142_6) / var_142_7
				local var_142_9 = Vector3.New(-0.7, -1.055, -6.16)

				var_142_5.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos1075ui_story, var_142_9, var_142_8)

				local var_142_10 = manager.ui.mainCamera.transform.position - var_142_5.position

				var_142_5.forward = Vector3.New(var_142_10.x, var_142_10.y, var_142_10.z)

				local var_142_11 = var_142_5.localEulerAngles

				var_142_11.z = 0
				var_142_11.x = 0
				var_142_5.localEulerAngles = var_142_11
			end

			if arg_139_1.time_ >= var_142_6 + var_142_7 and arg_139_1.time_ < var_142_6 + var_142_7 + arg_142_0 then
				var_142_5.localPosition = Vector3.New(-0.7, -1.055, -6.16)

				local var_142_12 = manager.ui.mainCamera.transform.position - var_142_5.position

				var_142_5.forward = Vector3.New(var_142_12.x, var_142_12.y, var_142_12.z)

				local var_142_13 = var_142_5.localEulerAngles

				var_142_13.z = 0
				var_142_13.x = 0
				var_142_5.localEulerAngles = var_142_13
			end

			local var_142_14 = arg_139_1.actors_["1075ui_story"]
			local var_142_15 = 0

			if var_142_15 < arg_139_1.time_ and arg_139_1.time_ <= var_142_15 + arg_142_0 and not isNil(var_142_14) and arg_139_1.var_.characterEffect1075ui_story == nil then
				arg_139_1.var_.characterEffect1075ui_story = var_142_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_16 = 0.200000002980232

			if var_142_15 <= arg_139_1.time_ and arg_139_1.time_ < var_142_15 + var_142_16 and not isNil(var_142_14) then
				local var_142_17 = (arg_139_1.time_ - var_142_15) / var_142_16

				if arg_139_1.var_.characterEffect1075ui_story and not isNil(var_142_14) then
					arg_139_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_139_1.time_ >= var_142_15 + var_142_16 and arg_139_1.time_ < var_142_15 + var_142_16 + arg_142_0 and not isNil(var_142_14) and arg_139_1.var_.characterEffect1075ui_story then
				arg_139_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_142_18 = 0

			if var_142_18 < arg_139_1.time_ and arg_139_1.time_ <= var_142_18 + arg_142_0 then
				arg_139_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action1_1")
			end

			local var_142_19 = 0

			if var_142_19 < arg_139_1.time_ and arg_139_1.time_ <= var_142_19 + arg_142_0 then
				arg_139_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_142_20 = arg_139_1.actors_["1084ui_story"].transform
			local var_142_21 = 0

			if var_142_21 < arg_139_1.time_ and arg_139_1.time_ <= var_142_21 + arg_142_0 then
				arg_139_1.var_.moveOldPos1084ui_story = var_142_20.localPosition
			end

			local var_142_22 = 0.001

			if var_142_21 <= arg_139_1.time_ and arg_139_1.time_ < var_142_21 + var_142_22 then
				local var_142_23 = (arg_139_1.time_ - var_142_21) / var_142_22
				local var_142_24 = Vector3.New(0.7, -0.97, -6)

				var_142_20.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos1084ui_story, var_142_24, var_142_23)

				local var_142_25 = manager.ui.mainCamera.transform.position - var_142_20.position

				var_142_20.forward = Vector3.New(var_142_25.x, var_142_25.y, var_142_25.z)

				local var_142_26 = var_142_20.localEulerAngles

				var_142_26.z = 0
				var_142_26.x = 0
				var_142_20.localEulerAngles = var_142_26
			end

			if arg_139_1.time_ >= var_142_21 + var_142_22 and arg_139_1.time_ < var_142_21 + var_142_22 + arg_142_0 then
				var_142_20.localPosition = Vector3.New(0.7, -0.97, -6)

				local var_142_27 = manager.ui.mainCamera.transform.position - var_142_20.position

				var_142_20.forward = Vector3.New(var_142_27.x, var_142_27.y, var_142_27.z)

				local var_142_28 = var_142_20.localEulerAngles

				var_142_28.z = 0
				var_142_28.x = 0
				var_142_20.localEulerAngles = var_142_28
			end

			local var_142_29 = arg_139_1.actors_["1084ui_story"]
			local var_142_30 = 0

			if var_142_30 < arg_139_1.time_ and arg_139_1.time_ <= var_142_30 + arg_142_0 and not isNil(var_142_29) and arg_139_1.var_.characterEffect1084ui_story == nil then
				arg_139_1.var_.characterEffect1084ui_story = var_142_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_31 = 0.200000002980232

			if var_142_30 <= arg_139_1.time_ and arg_139_1.time_ < var_142_30 + var_142_31 and not isNil(var_142_29) then
				local var_142_32 = (arg_139_1.time_ - var_142_30) / var_142_31

				if arg_139_1.var_.characterEffect1084ui_story and not isNil(var_142_29) then
					local var_142_33 = Mathf.Lerp(0, 0.5, var_142_32)

					arg_139_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_139_1.var_.characterEffect1084ui_story.fillRatio = var_142_33
				end
			end

			if arg_139_1.time_ >= var_142_30 + var_142_31 and arg_139_1.time_ < var_142_30 + var_142_31 + arg_142_0 and not isNil(var_142_29) and arg_139_1.var_.characterEffect1084ui_story then
				local var_142_34 = 0.5

				arg_139_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_139_1.var_.characterEffect1084ui_story.fillRatio = var_142_34
			end

			local var_142_35 = 0
			local var_142_36 = 0.35

			if var_142_35 < arg_139_1.time_ and arg_139_1.time_ <= var_142_35 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				local var_142_37 = arg_139_1:FormatText(StoryNameCfg[381].name)

				arg_139_1.leftNameTxt_.text = var_142_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_38 = arg_139_1:GetWordFromCfg(121521034)
				local var_142_39 = arg_139_1:FormatText(var_142_38.content)

				arg_139_1.text_.text = var_142_39

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_40 = 14
				local var_142_41 = utf8.len(var_142_39)
				local var_142_42 = var_142_40 <= 0 and var_142_36 or var_142_36 * (var_142_41 / var_142_40)

				if var_142_42 > 0 and var_142_36 < var_142_42 then
					arg_139_1.talkMaxDuration = var_142_42

					if var_142_42 + var_142_35 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_42 + var_142_35
					end
				end

				arg_139_1.text_.text = var_142_39
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121521", "121521034", "story_v_out_121521.awb") ~= 0 then
					local var_142_43 = manager.audio:GetVoiceLength("story_v_out_121521", "121521034", "story_v_out_121521.awb") / 1000

					if var_142_43 + var_142_35 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_43 + var_142_35
					end

					if var_142_38.prefab_name ~= "" and arg_139_1.actors_[var_142_38.prefab_name] ~= nil then
						local var_142_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_38.prefab_name].transform, "story_v_out_121521", "121521034", "story_v_out_121521.awb")

						arg_139_1:RecordAudio("121521034", var_142_44)
						arg_139_1:RecordAudio("121521034", var_142_44)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_121521", "121521034", "story_v_out_121521.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_121521", "121521034", "story_v_out_121521.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_45 = math.max(var_142_36, arg_139_1.talkMaxDuration)

			if var_142_35 <= arg_139_1.time_ and arg_139_1.time_ < var_142_35 + var_142_45 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_35) / var_142_45

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_35 + var_142_45 and arg_139_1.time_ < var_142_35 + var_142_45 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_139_1:InitPlayNodeList()
	end,
	Play121521035 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 121521035
		arg_143_1.duration_ = 5

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play121521036(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = arg_143_1.actors_["1075ui_story"]
			local var_146_1 = 0

			if var_146_1 < arg_143_1.time_ and arg_143_1.time_ <= var_146_1 + arg_146_0 and not isNil(var_146_0) and arg_143_1.var_.characterEffect1075ui_story == nil then
				arg_143_1.var_.characterEffect1075ui_story = var_146_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_2 = 0.200000002980232

			if var_146_1 <= arg_143_1.time_ and arg_143_1.time_ < var_146_1 + var_146_2 and not isNil(var_146_0) then
				local var_146_3 = (arg_143_1.time_ - var_146_1) / var_146_2

				if arg_143_1.var_.characterEffect1075ui_story and not isNil(var_146_0) then
					local var_146_4 = Mathf.Lerp(0, 0.5, var_146_3)

					arg_143_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_143_1.var_.characterEffect1075ui_story.fillRatio = var_146_4
				end
			end

			if arg_143_1.time_ >= var_146_1 + var_146_2 and arg_143_1.time_ < var_146_1 + var_146_2 + arg_146_0 and not isNil(var_146_0) and arg_143_1.var_.characterEffect1075ui_story then
				local var_146_5 = 0.5

				arg_143_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_143_1.var_.characterEffect1075ui_story.fillRatio = var_146_5
			end

			local var_146_6 = 0
			local var_146_7 = 0.575

			if var_146_6 < arg_143_1.time_ and arg_143_1.time_ <= var_146_6 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				local var_146_8 = arg_143_1:FormatText(StoryNameCfg[7].name)

				arg_143_1.leftNameTxt_.text = var_146_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, true)
				arg_143_1.iconController_:SetSelectedState("hero")

				arg_143_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_143_1.callingController_:SetSelectedState("normal")

				arg_143_1.keyicon_.color = Color.New(1, 1, 1)
				arg_143_1.icon_.color = Color.New(1, 1, 1)

				local var_146_9 = arg_143_1:GetWordFromCfg(121521035)
				local var_146_10 = arg_143_1:FormatText(var_146_9.content)

				arg_143_1.text_.text = var_146_10

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_11 = 23
				local var_146_12 = utf8.len(var_146_10)
				local var_146_13 = var_146_11 <= 0 and var_146_7 or var_146_7 * (var_146_12 / var_146_11)

				if var_146_13 > 0 and var_146_7 < var_146_13 then
					arg_143_1.talkMaxDuration = var_146_13

					if var_146_13 + var_146_6 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_13 + var_146_6
					end
				end

				arg_143_1.text_.text = var_146_10
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)
				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_14 = math.max(var_146_7, arg_143_1.talkMaxDuration)

			if var_146_6 <= arg_143_1.time_ and arg_143_1.time_ < var_146_6 + var_146_14 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_6) / var_146_14

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_6 + var_146_14 and arg_143_1.time_ < var_146_6 + var_146_14 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play121521036 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 121521036
		arg_147_1.duration_ = 8.33

		local var_147_0 = {
			ja = 8.333,
			ko = 7.933,
			zh = 7.933
		}
		local var_147_1 = manager.audio:GetLocalizationFlag()

		if var_147_0[var_147_1] ~= nil then
			arg_147_1.duration_ = var_147_0[var_147_1]
		end

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play121521037(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = arg_147_1.actors_["1075ui_story"]
			local var_150_1 = 0

			if var_150_1 < arg_147_1.time_ and arg_147_1.time_ <= var_150_1 + arg_150_0 and not isNil(var_150_0) and arg_147_1.var_.characterEffect1075ui_story == nil then
				arg_147_1.var_.characterEffect1075ui_story = var_150_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_2 = 0.200000002980232

			if var_150_1 <= arg_147_1.time_ and arg_147_1.time_ < var_150_1 + var_150_2 and not isNil(var_150_0) then
				local var_150_3 = (arg_147_1.time_ - var_150_1) / var_150_2

				if arg_147_1.var_.characterEffect1075ui_story and not isNil(var_150_0) then
					arg_147_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_147_1.time_ >= var_150_1 + var_150_2 and arg_147_1.time_ < var_150_1 + var_150_2 + arg_150_0 and not isNil(var_150_0) and arg_147_1.var_.characterEffect1075ui_story then
				arg_147_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_150_4 = 0

			if var_150_4 < arg_147_1.time_ and arg_147_1.time_ <= var_150_4 + arg_150_0 then
				arg_147_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action5_1")
			end

			local var_150_5 = 0

			if var_150_5 < arg_147_1.time_ and arg_147_1.time_ <= var_150_5 + arg_150_0 then
				arg_147_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_150_6 = 0
			local var_150_7 = 1

			if var_150_6 < arg_147_1.time_ and arg_147_1.time_ <= var_150_6 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				local var_150_8 = arg_147_1:FormatText(StoryNameCfg[381].name)

				arg_147_1.leftNameTxt_.text = var_150_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_9 = arg_147_1:GetWordFromCfg(121521036)
				local var_150_10 = arg_147_1:FormatText(var_150_9.content)

				arg_147_1.text_.text = var_150_10

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_11 = 40
				local var_150_12 = utf8.len(var_150_10)
				local var_150_13 = var_150_11 <= 0 and var_150_7 or var_150_7 * (var_150_12 / var_150_11)

				if var_150_13 > 0 and var_150_7 < var_150_13 then
					arg_147_1.talkMaxDuration = var_150_13

					if var_150_13 + var_150_6 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_13 + var_150_6
					end
				end

				arg_147_1.text_.text = var_150_10
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121521", "121521036", "story_v_out_121521.awb") ~= 0 then
					local var_150_14 = manager.audio:GetVoiceLength("story_v_out_121521", "121521036", "story_v_out_121521.awb") / 1000

					if var_150_14 + var_150_6 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_14 + var_150_6
					end

					if var_150_9.prefab_name ~= "" and arg_147_1.actors_[var_150_9.prefab_name] ~= nil then
						local var_150_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_9.prefab_name].transform, "story_v_out_121521", "121521036", "story_v_out_121521.awb")

						arg_147_1:RecordAudio("121521036", var_150_15)
						arg_147_1:RecordAudio("121521036", var_150_15)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_121521", "121521036", "story_v_out_121521.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_121521", "121521036", "story_v_out_121521.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_16 = math.max(var_150_7, arg_147_1.talkMaxDuration)

			if var_150_6 <= arg_147_1.time_ and arg_147_1.time_ < var_150_6 + var_150_16 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_6) / var_150_16

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_6 + var_150_16 and arg_147_1.time_ < var_150_6 + var_150_16 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play121521037 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 121521037
		arg_151_1.duration_ = 4.63

		local var_151_0 = {
			ja = 4.633,
			ko = 3.033,
			zh = 3.033
		}
		local var_151_1 = manager.audio:GetLocalizationFlag()

		if var_151_0[var_151_1] ~= nil then
			arg_151_1.duration_ = var_151_0[var_151_1]
		end

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play121521038(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = arg_151_1.actors_["1084ui_story"]
			local var_154_1 = 0

			if var_154_1 < arg_151_1.time_ and arg_151_1.time_ <= var_154_1 + arg_154_0 and not isNil(var_154_0) and arg_151_1.var_.characterEffect1084ui_story == nil then
				arg_151_1.var_.characterEffect1084ui_story = var_154_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_2 = 0.200000002980232

			if var_154_1 <= arg_151_1.time_ and arg_151_1.time_ < var_154_1 + var_154_2 and not isNil(var_154_0) then
				local var_154_3 = (arg_151_1.time_ - var_154_1) / var_154_2

				if arg_151_1.var_.characterEffect1084ui_story and not isNil(var_154_0) then
					arg_151_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_151_1.time_ >= var_154_1 + var_154_2 and arg_151_1.time_ < var_154_1 + var_154_2 + arg_154_0 and not isNil(var_154_0) and arg_151_1.var_.characterEffect1084ui_story then
				arg_151_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_154_4 = 0

			if var_154_4 < arg_151_1.time_ and arg_151_1.time_ <= var_154_4 + arg_154_0 then
				arg_151_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			local var_154_5 = 0

			if var_154_5 < arg_151_1.time_ and arg_151_1.time_ <= var_154_5 + arg_154_0 then
				arg_151_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_154_6 = arg_151_1.actors_["1075ui_story"]
			local var_154_7 = 0

			if var_154_7 < arg_151_1.time_ and arg_151_1.time_ <= var_154_7 + arg_154_0 and not isNil(var_154_6) and arg_151_1.var_.characterEffect1075ui_story == nil then
				arg_151_1.var_.characterEffect1075ui_story = var_154_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_8 = 0.200000002980232

			if var_154_7 <= arg_151_1.time_ and arg_151_1.time_ < var_154_7 + var_154_8 and not isNil(var_154_6) then
				local var_154_9 = (arg_151_1.time_ - var_154_7) / var_154_8

				if arg_151_1.var_.characterEffect1075ui_story and not isNil(var_154_6) then
					local var_154_10 = Mathf.Lerp(0, 0.5, var_154_9)

					arg_151_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_151_1.var_.characterEffect1075ui_story.fillRatio = var_154_10
				end
			end

			if arg_151_1.time_ >= var_154_7 + var_154_8 and arg_151_1.time_ < var_154_7 + var_154_8 + arg_154_0 and not isNil(var_154_6) and arg_151_1.var_.characterEffect1075ui_story then
				local var_154_11 = 0.5

				arg_151_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_151_1.var_.characterEffect1075ui_story.fillRatio = var_154_11
			end

			local var_154_12 = 0
			local var_154_13 = 0.375

			if var_154_12 < arg_151_1.time_ and arg_151_1.time_ <= var_154_12 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				local var_154_14 = arg_151_1:FormatText(StoryNameCfg[6].name)

				arg_151_1.leftNameTxt_.text = var_154_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_15 = arg_151_1:GetWordFromCfg(121521037)
				local var_154_16 = arg_151_1:FormatText(var_154_15.content)

				arg_151_1.text_.text = var_154_16

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_17 = 15
				local var_154_18 = utf8.len(var_154_16)
				local var_154_19 = var_154_17 <= 0 and var_154_13 or var_154_13 * (var_154_18 / var_154_17)

				if var_154_19 > 0 and var_154_13 < var_154_19 then
					arg_151_1.talkMaxDuration = var_154_19

					if var_154_19 + var_154_12 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_19 + var_154_12
					end
				end

				arg_151_1.text_.text = var_154_16
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121521", "121521037", "story_v_out_121521.awb") ~= 0 then
					local var_154_20 = manager.audio:GetVoiceLength("story_v_out_121521", "121521037", "story_v_out_121521.awb") / 1000

					if var_154_20 + var_154_12 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_20 + var_154_12
					end

					if var_154_15.prefab_name ~= "" and arg_151_1.actors_[var_154_15.prefab_name] ~= nil then
						local var_154_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_15.prefab_name].transform, "story_v_out_121521", "121521037", "story_v_out_121521.awb")

						arg_151_1:RecordAudio("121521037", var_154_21)
						arg_151_1:RecordAudio("121521037", var_154_21)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_121521", "121521037", "story_v_out_121521.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_121521", "121521037", "story_v_out_121521.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_22 = math.max(var_154_13, arg_151_1.talkMaxDuration)

			if var_154_12 <= arg_151_1.time_ and arg_151_1.time_ < var_154_12 + var_154_22 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_12) / var_154_22

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_12 + var_154_22 and arg_151_1.time_ < var_154_12 + var_154_22 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play121521038 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 121521038
		arg_155_1.duration_ = 6.67

		local var_155_0 = {
			ja = 5.6,
			ko = 6.666,
			zh = 6.666
		}
		local var_155_1 = manager.audio:GetLocalizationFlag()

		if var_155_0[var_155_1] ~= nil then
			arg_155_1.duration_ = var_155_0[var_155_1]
		end

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play121521039(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = arg_155_1.actors_["1075ui_story"]
			local var_158_1 = 0

			if var_158_1 < arg_155_1.time_ and arg_155_1.time_ <= var_158_1 + arg_158_0 and not isNil(var_158_0) and arg_155_1.var_.characterEffect1075ui_story == nil then
				arg_155_1.var_.characterEffect1075ui_story = var_158_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_158_2 = 0.200000002980232

			if var_158_1 <= arg_155_1.time_ and arg_155_1.time_ < var_158_1 + var_158_2 and not isNil(var_158_0) then
				local var_158_3 = (arg_155_1.time_ - var_158_1) / var_158_2

				if arg_155_1.var_.characterEffect1075ui_story and not isNil(var_158_0) then
					arg_155_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_155_1.time_ >= var_158_1 + var_158_2 and arg_155_1.time_ < var_158_1 + var_158_2 + arg_158_0 and not isNil(var_158_0) and arg_155_1.var_.characterEffect1075ui_story then
				arg_155_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_158_4 = 0

			if var_158_4 < arg_155_1.time_ and arg_155_1.time_ <= var_158_4 + arg_158_0 then
				arg_155_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action5_2")
			end

			local var_158_5 = 0

			if var_158_5 < arg_155_1.time_ and arg_155_1.time_ <= var_158_5 + arg_158_0 then
				arg_155_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_158_6 = arg_155_1.actors_["1084ui_story"]
			local var_158_7 = 0

			if var_158_7 < arg_155_1.time_ and arg_155_1.time_ <= var_158_7 + arg_158_0 and not isNil(var_158_6) and arg_155_1.var_.characterEffect1084ui_story == nil then
				arg_155_1.var_.characterEffect1084ui_story = var_158_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_158_8 = 0.200000002980232

			if var_158_7 <= arg_155_1.time_ and arg_155_1.time_ < var_158_7 + var_158_8 and not isNil(var_158_6) then
				local var_158_9 = (arg_155_1.time_ - var_158_7) / var_158_8

				if arg_155_1.var_.characterEffect1084ui_story and not isNil(var_158_6) then
					local var_158_10 = Mathf.Lerp(0, 0.5, var_158_9)

					arg_155_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_155_1.var_.characterEffect1084ui_story.fillRatio = var_158_10
				end
			end

			if arg_155_1.time_ >= var_158_7 + var_158_8 and arg_155_1.time_ < var_158_7 + var_158_8 + arg_158_0 and not isNil(var_158_6) and arg_155_1.var_.characterEffect1084ui_story then
				local var_158_11 = 0.5

				arg_155_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_155_1.var_.characterEffect1084ui_story.fillRatio = var_158_11
			end

			local var_158_12 = 0
			local var_158_13 = 0.875

			if var_158_12 < arg_155_1.time_ and arg_155_1.time_ <= var_158_12 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				local var_158_14 = arg_155_1:FormatText(StoryNameCfg[381].name)

				arg_155_1.leftNameTxt_.text = var_158_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_15 = arg_155_1:GetWordFromCfg(121521038)
				local var_158_16 = arg_155_1:FormatText(var_158_15.content)

				arg_155_1.text_.text = var_158_16

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_17 = 35
				local var_158_18 = utf8.len(var_158_16)
				local var_158_19 = var_158_17 <= 0 and var_158_13 or var_158_13 * (var_158_18 / var_158_17)

				if var_158_19 > 0 and var_158_13 < var_158_19 then
					arg_155_1.talkMaxDuration = var_158_19

					if var_158_19 + var_158_12 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_19 + var_158_12
					end
				end

				arg_155_1.text_.text = var_158_16
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121521", "121521038", "story_v_out_121521.awb") ~= 0 then
					local var_158_20 = manager.audio:GetVoiceLength("story_v_out_121521", "121521038", "story_v_out_121521.awb") / 1000

					if var_158_20 + var_158_12 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_20 + var_158_12
					end

					if var_158_15.prefab_name ~= "" and arg_155_1.actors_[var_158_15.prefab_name] ~= nil then
						local var_158_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_15.prefab_name].transform, "story_v_out_121521", "121521038", "story_v_out_121521.awb")

						arg_155_1:RecordAudio("121521038", var_158_21)
						arg_155_1:RecordAudio("121521038", var_158_21)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_121521", "121521038", "story_v_out_121521.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_121521", "121521038", "story_v_out_121521.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_22 = math.max(var_158_13, arg_155_1.talkMaxDuration)

			if var_158_12 <= arg_155_1.time_ and arg_155_1.time_ < var_158_12 + var_158_22 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_12) / var_158_22

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_12 + var_158_22 and arg_155_1.time_ < var_158_12 + var_158_22 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {}

		arg_155_1:InitPlayNodeList()
	end,
	Play121521039 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 121521039
		arg_159_1.duration_ = 7.4

		local var_159_0 = {
			ja = 7.4,
			ko = 6.233,
			zh = 6.233
		}
		local var_159_1 = manager.audio:GetLocalizationFlag()

		if var_159_0[var_159_1] ~= nil then
			arg_159_1.duration_ = var_159_0[var_159_1]
		end

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play121521040(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = 0
			local var_162_1 = 0.775

			if var_162_0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_0 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				local var_162_2 = arg_159_1:FormatText(StoryNameCfg[381].name)

				arg_159_1.leftNameTxt_.text = var_162_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_3 = arg_159_1:GetWordFromCfg(121521039)
				local var_162_4 = arg_159_1:FormatText(var_162_3.content)

				arg_159_1.text_.text = var_162_4

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_5 = 31
				local var_162_6 = utf8.len(var_162_4)
				local var_162_7 = var_162_5 <= 0 and var_162_1 or var_162_1 * (var_162_6 / var_162_5)

				if var_162_7 > 0 and var_162_1 < var_162_7 then
					arg_159_1.talkMaxDuration = var_162_7

					if var_162_7 + var_162_0 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_7 + var_162_0
					end
				end

				arg_159_1.text_.text = var_162_4
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121521", "121521039", "story_v_out_121521.awb") ~= 0 then
					local var_162_8 = manager.audio:GetVoiceLength("story_v_out_121521", "121521039", "story_v_out_121521.awb") / 1000

					if var_162_8 + var_162_0 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_8 + var_162_0
					end

					if var_162_3.prefab_name ~= "" and arg_159_1.actors_[var_162_3.prefab_name] ~= nil then
						local var_162_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_3.prefab_name].transform, "story_v_out_121521", "121521039", "story_v_out_121521.awb")

						arg_159_1:RecordAudio("121521039", var_162_9)
						arg_159_1:RecordAudio("121521039", var_162_9)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_121521", "121521039", "story_v_out_121521.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_121521", "121521039", "story_v_out_121521.awb")
				end

				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_10 = math.max(var_162_1, arg_159_1.talkMaxDuration)

			if var_162_0 <= arg_159_1.time_ and arg_159_1.time_ < var_162_0 + var_162_10 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_0) / var_162_10

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_0 + var_162_10 and arg_159_1.time_ < var_162_0 + var_162_10 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play121521040 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 121521040
		arg_163_1.duration_ = 10.97

		local var_163_0 = {
			ja = 10.966,
			ko = 9.166,
			zh = 9.166
		}
		local var_163_1 = manager.audio:GetLocalizationFlag()

		if var_163_0[var_163_1] ~= nil then
			arg_163_1.duration_ = var_163_0[var_163_1]
		end

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play121521041(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = arg_163_1.actors_["1075ui_story"]
			local var_166_1 = 0

			if var_166_1 < arg_163_1.time_ and arg_163_1.time_ <= var_166_1 + arg_166_0 and not isNil(var_166_0) and arg_163_1.var_.characterEffect1075ui_story == nil then
				arg_163_1.var_.characterEffect1075ui_story = var_166_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_2 = 0.200000002980232

			if var_166_1 <= arg_163_1.time_ and arg_163_1.time_ < var_166_1 + var_166_2 and not isNil(var_166_0) then
				local var_166_3 = (arg_163_1.time_ - var_166_1) / var_166_2

				if arg_163_1.var_.characterEffect1075ui_story and not isNil(var_166_0) then
					arg_163_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_163_1.time_ >= var_166_1 + var_166_2 and arg_163_1.time_ < var_166_1 + var_166_2 + arg_166_0 and not isNil(var_166_0) and arg_163_1.var_.characterEffect1075ui_story then
				arg_163_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_166_4 = 0

			if var_166_4 < arg_163_1.time_ and arg_163_1.time_ <= var_166_4 + arg_166_0 then
				arg_163_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_166_5 = 0
			local var_166_6 = 1.175

			if var_166_5 < arg_163_1.time_ and arg_163_1.time_ <= var_166_5 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				local var_166_7 = arg_163_1:FormatText(StoryNameCfg[381].name)

				arg_163_1.leftNameTxt_.text = var_166_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_8 = arg_163_1:GetWordFromCfg(121521040)
				local var_166_9 = arg_163_1:FormatText(var_166_8.content)

				arg_163_1.text_.text = var_166_9

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_10 = 47
				local var_166_11 = utf8.len(var_166_9)
				local var_166_12 = var_166_10 <= 0 and var_166_6 or var_166_6 * (var_166_11 / var_166_10)

				if var_166_12 > 0 and var_166_6 < var_166_12 then
					arg_163_1.talkMaxDuration = var_166_12

					if var_166_12 + var_166_5 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_12 + var_166_5
					end
				end

				arg_163_1.text_.text = var_166_9
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121521", "121521040", "story_v_out_121521.awb") ~= 0 then
					local var_166_13 = manager.audio:GetVoiceLength("story_v_out_121521", "121521040", "story_v_out_121521.awb") / 1000

					if var_166_13 + var_166_5 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_13 + var_166_5
					end

					if var_166_8.prefab_name ~= "" and arg_163_1.actors_[var_166_8.prefab_name] ~= nil then
						local var_166_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_8.prefab_name].transform, "story_v_out_121521", "121521040", "story_v_out_121521.awb")

						arg_163_1:RecordAudio("121521040", var_166_14)
						arg_163_1:RecordAudio("121521040", var_166_14)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_121521", "121521040", "story_v_out_121521.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_121521", "121521040", "story_v_out_121521.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_15 = math.max(var_166_6, arg_163_1.talkMaxDuration)

			if var_166_5 <= arg_163_1.time_ and arg_163_1.time_ < var_166_5 + var_166_15 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_5) / var_166_15

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_5 + var_166_15 and arg_163_1.time_ < var_166_5 + var_166_15 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {}

		arg_163_1:InitPlayNodeList()
	end,
	Play121521041 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 121521041
		arg_167_1.duration_ = 12.1

		local var_167_0 = {
			ja = 12.1,
			ko = 7.4,
			zh = 7.4
		}
		local var_167_1 = manager.audio:GetLocalizationFlag()

		if var_167_0[var_167_1] ~= nil then
			arg_167_1.duration_ = var_167_0[var_167_1]
		end

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play121521042(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = arg_167_1.actors_["1084ui_story"]
			local var_170_1 = 0

			if var_170_1 < arg_167_1.time_ and arg_167_1.time_ <= var_170_1 + arg_170_0 and not isNil(var_170_0) and arg_167_1.var_.characterEffect1084ui_story == nil then
				arg_167_1.var_.characterEffect1084ui_story = var_170_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_170_2 = 0.200000002980232

			if var_170_1 <= arg_167_1.time_ and arg_167_1.time_ < var_170_1 + var_170_2 and not isNil(var_170_0) then
				local var_170_3 = (arg_167_1.time_ - var_170_1) / var_170_2

				if arg_167_1.var_.characterEffect1084ui_story and not isNil(var_170_0) then
					arg_167_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_167_1.time_ >= var_170_1 + var_170_2 and arg_167_1.time_ < var_170_1 + var_170_2 + arg_170_0 and not isNil(var_170_0) and arg_167_1.var_.characterEffect1084ui_story then
				arg_167_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_170_4 = 0

			if var_170_4 < arg_167_1.time_ and arg_167_1.time_ <= var_170_4 + arg_170_0 then
				arg_167_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_170_5 = arg_167_1.actors_["1075ui_story"]
			local var_170_6 = 0

			if var_170_6 < arg_167_1.time_ and arg_167_1.time_ <= var_170_6 + arg_170_0 and not isNil(var_170_5) and arg_167_1.var_.characterEffect1075ui_story == nil then
				arg_167_1.var_.characterEffect1075ui_story = var_170_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_170_7 = 0.200000002980232

			if var_170_6 <= arg_167_1.time_ and arg_167_1.time_ < var_170_6 + var_170_7 and not isNil(var_170_5) then
				local var_170_8 = (arg_167_1.time_ - var_170_6) / var_170_7

				if arg_167_1.var_.characterEffect1075ui_story and not isNil(var_170_5) then
					local var_170_9 = Mathf.Lerp(0, 0.5, var_170_8)

					arg_167_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_167_1.var_.characterEffect1075ui_story.fillRatio = var_170_9
				end
			end

			if arg_167_1.time_ >= var_170_6 + var_170_7 and arg_167_1.time_ < var_170_6 + var_170_7 + arg_170_0 and not isNil(var_170_5) and arg_167_1.var_.characterEffect1075ui_story then
				local var_170_10 = 0.5

				arg_167_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_167_1.var_.characterEffect1075ui_story.fillRatio = var_170_10
			end

			local var_170_11 = 0
			local var_170_12 = 0.825

			if var_170_11 < arg_167_1.time_ and arg_167_1.time_ <= var_170_11 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				local var_170_13 = arg_167_1:FormatText(StoryNameCfg[6].name)

				arg_167_1.leftNameTxt_.text = var_170_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_14 = arg_167_1:GetWordFromCfg(121521041)
				local var_170_15 = arg_167_1:FormatText(var_170_14.content)

				arg_167_1.text_.text = var_170_15

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_16 = 34
				local var_170_17 = utf8.len(var_170_15)
				local var_170_18 = var_170_16 <= 0 and var_170_12 or var_170_12 * (var_170_17 / var_170_16)

				if var_170_18 > 0 and var_170_12 < var_170_18 then
					arg_167_1.talkMaxDuration = var_170_18

					if var_170_18 + var_170_11 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_18 + var_170_11
					end
				end

				arg_167_1.text_.text = var_170_15
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121521", "121521041", "story_v_out_121521.awb") ~= 0 then
					local var_170_19 = manager.audio:GetVoiceLength("story_v_out_121521", "121521041", "story_v_out_121521.awb") / 1000

					if var_170_19 + var_170_11 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_19 + var_170_11
					end

					if var_170_14.prefab_name ~= "" and arg_167_1.actors_[var_170_14.prefab_name] ~= nil then
						local var_170_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_14.prefab_name].transform, "story_v_out_121521", "121521041", "story_v_out_121521.awb")

						arg_167_1:RecordAudio("121521041", var_170_20)
						arg_167_1:RecordAudio("121521041", var_170_20)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_121521", "121521041", "story_v_out_121521.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_121521", "121521041", "story_v_out_121521.awb")
				end

				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_21 = math.max(var_170_12, arg_167_1.talkMaxDuration)

			if var_170_11 <= arg_167_1.time_ and arg_167_1.time_ < var_170_11 + var_170_21 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_11) / var_170_21

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_11 + var_170_21 and arg_167_1.time_ < var_170_11 + var_170_21 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	Play121521042 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 121521042
		arg_171_1.duration_ = 10.57

		local var_171_0 = {
			ja = 10.566,
			ko = 6.633,
			zh = 6.633
		}
		local var_171_1 = manager.audio:GetLocalizationFlag()

		if var_171_0[var_171_1] ~= nil then
			arg_171_1.duration_ = var_171_0[var_171_1]
		end

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play121521043(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = arg_171_1.actors_["1075ui_story"]
			local var_174_1 = 0

			if var_174_1 < arg_171_1.time_ and arg_171_1.time_ <= var_174_1 + arg_174_0 and not isNil(var_174_0) and arg_171_1.var_.characterEffect1075ui_story == nil then
				arg_171_1.var_.characterEffect1075ui_story = var_174_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_2 = 0.200000002980232

			if var_174_1 <= arg_171_1.time_ and arg_171_1.time_ < var_174_1 + var_174_2 and not isNil(var_174_0) then
				local var_174_3 = (arg_171_1.time_ - var_174_1) / var_174_2

				if arg_171_1.var_.characterEffect1075ui_story and not isNil(var_174_0) then
					arg_171_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_171_1.time_ >= var_174_1 + var_174_2 and arg_171_1.time_ < var_174_1 + var_174_2 + arg_174_0 and not isNil(var_174_0) and arg_171_1.var_.characterEffect1075ui_story then
				arg_171_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_174_4 = 0

			if var_174_4 < arg_171_1.time_ and arg_171_1.time_ <= var_174_4 + arg_174_0 then
				arg_171_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action5_1")
			end

			local var_174_5 = 0

			if var_174_5 < arg_171_1.time_ and arg_171_1.time_ <= var_174_5 + arg_174_0 then
				arg_171_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_174_6 = arg_171_1.actors_["1084ui_story"]
			local var_174_7 = 0

			if var_174_7 < arg_171_1.time_ and arg_171_1.time_ <= var_174_7 + arg_174_0 and not isNil(var_174_6) and arg_171_1.var_.characterEffect1084ui_story == nil then
				arg_171_1.var_.characterEffect1084ui_story = var_174_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_8 = 0.200000002980232

			if var_174_7 <= arg_171_1.time_ and arg_171_1.time_ < var_174_7 + var_174_8 and not isNil(var_174_6) then
				local var_174_9 = (arg_171_1.time_ - var_174_7) / var_174_8

				if arg_171_1.var_.characterEffect1084ui_story and not isNil(var_174_6) then
					local var_174_10 = Mathf.Lerp(0, 0.5, var_174_9)

					arg_171_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_171_1.var_.characterEffect1084ui_story.fillRatio = var_174_10
				end
			end

			if arg_171_1.time_ >= var_174_7 + var_174_8 and arg_171_1.time_ < var_174_7 + var_174_8 + arg_174_0 and not isNil(var_174_6) and arg_171_1.var_.characterEffect1084ui_story then
				local var_174_11 = 0.5

				arg_171_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_171_1.var_.characterEffect1084ui_story.fillRatio = var_174_11
			end

			local var_174_12 = 0
			local var_174_13 = 0.625

			if var_174_12 < arg_171_1.time_ and arg_171_1.time_ <= var_174_12 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				local var_174_14 = arg_171_1:FormatText(StoryNameCfg[381].name)

				arg_171_1.leftNameTxt_.text = var_174_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_15 = arg_171_1:GetWordFromCfg(121521042)
				local var_174_16 = arg_171_1:FormatText(var_174_15.content)

				arg_171_1.text_.text = var_174_16

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_17 = 25
				local var_174_18 = utf8.len(var_174_16)
				local var_174_19 = var_174_17 <= 0 and var_174_13 or var_174_13 * (var_174_18 / var_174_17)

				if var_174_19 > 0 and var_174_13 < var_174_19 then
					arg_171_1.talkMaxDuration = var_174_19

					if var_174_19 + var_174_12 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_19 + var_174_12
					end
				end

				arg_171_1.text_.text = var_174_16
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121521", "121521042", "story_v_out_121521.awb") ~= 0 then
					local var_174_20 = manager.audio:GetVoiceLength("story_v_out_121521", "121521042", "story_v_out_121521.awb") / 1000

					if var_174_20 + var_174_12 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_20 + var_174_12
					end

					if var_174_15.prefab_name ~= "" and arg_171_1.actors_[var_174_15.prefab_name] ~= nil then
						local var_174_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_15.prefab_name].transform, "story_v_out_121521", "121521042", "story_v_out_121521.awb")

						arg_171_1:RecordAudio("121521042", var_174_21)
						arg_171_1:RecordAudio("121521042", var_174_21)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_out_121521", "121521042", "story_v_out_121521.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_out_121521", "121521042", "story_v_out_121521.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_22 = math.max(var_174_13, arg_171_1.talkMaxDuration)

			if var_174_12 <= arg_171_1.time_ and arg_171_1.time_ < var_174_12 + var_174_22 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_12) / var_174_22

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_12 + var_174_22 and arg_171_1.time_ < var_174_12 + var_174_22 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {}

		arg_171_1:InitPlayNodeList()
	end,
	Play121521043 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 121521043
		arg_175_1.duration_ = 5

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play121521044(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = arg_175_1.actors_["1075ui_story"]
			local var_178_1 = 0

			if var_178_1 < arg_175_1.time_ and arg_175_1.time_ <= var_178_1 + arg_178_0 and not isNil(var_178_0) and arg_175_1.var_.characterEffect1075ui_story == nil then
				arg_175_1.var_.characterEffect1075ui_story = var_178_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_178_2 = 0.200000002980232

			if var_178_1 <= arg_175_1.time_ and arg_175_1.time_ < var_178_1 + var_178_2 and not isNil(var_178_0) then
				local var_178_3 = (arg_175_1.time_ - var_178_1) / var_178_2

				if arg_175_1.var_.characterEffect1075ui_story and not isNil(var_178_0) then
					local var_178_4 = Mathf.Lerp(0, 0.5, var_178_3)

					arg_175_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_175_1.var_.characterEffect1075ui_story.fillRatio = var_178_4
				end
			end

			if arg_175_1.time_ >= var_178_1 + var_178_2 and arg_175_1.time_ < var_178_1 + var_178_2 + arg_178_0 and not isNil(var_178_0) and arg_175_1.var_.characterEffect1075ui_story then
				local var_178_5 = 0.5

				arg_175_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_175_1.var_.characterEffect1075ui_story.fillRatio = var_178_5
			end

			local var_178_6 = 0
			local var_178_7 = 0.1

			if var_178_6 < arg_175_1.time_ and arg_175_1.time_ <= var_178_6 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				local var_178_8 = arg_175_1:FormatText(StoryNameCfg[7].name)

				arg_175_1.leftNameTxt_.text = var_178_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, true)
				arg_175_1.iconController_:SetSelectedState("hero")

				arg_175_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_175_1.callingController_:SetSelectedState("normal")

				arg_175_1.keyicon_.color = Color.New(1, 1, 1)
				arg_175_1.icon_.color = Color.New(1, 1, 1)

				local var_178_9 = arg_175_1:GetWordFromCfg(121521043)
				local var_178_10 = arg_175_1:FormatText(var_178_9.content)

				arg_175_1.text_.text = var_178_10

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_11 = 4
				local var_178_12 = utf8.len(var_178_10)
				local var_178_13 = var_178_11 <= 0 and var_178_7 or var_178_7 * (var_178_12 / var_178_11)

				if var_178_13 > 0 and var_178_7 < var_178_13 then
					arg_175_1.talkMaxDuration = var_178_13

					if var_178_13 + var_178_6 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_13 + var_178_6
					end
				end

				arg_175_1.text_.text = var_178_10
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)
				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_14 = math.max(var_178_7, arg_175_1.talkMaxDuration)

			if var_178_6 <= arg_175_1.time_ and arg_175_1.time_ < var_178_6 + var_178_14 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_6) / var_178_14

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_6 + var_178_14 and arg_175_1.time_ < var_178_6 + var_178_14 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {}

		arg_175_1:InitPlayNodeList()
	end,
	Play121521044 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 121521044
		arg_179_1.duration_ = 5

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play121521045(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = 0
			local var_182_1 = 0.95

			if var_182_0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_0 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, false)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_2 = arg_179_1:GetWordFromCfg(121521044)
				local var_182_3 = arg_179_1:FormatText(var_182_2.content)

				arg_179_1.text_.text = var_182_3

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_4 = 38
				local var_182_5 = utf8.len(var_182_3)
				local var_182_6 = var_182_4 <= 0 and var_182_1 or var_182_1 * (var_182_5 / var_182_4)

				if var_182_6 > 0 and var_182_1 < var_182_6 then
					arg_179_1.talkMaxDuration = var_182_6

					if var_182_6 + var_182_0 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_6 + var_182_0
					end
				end

				arg_179_1.text_.text = var_182_3
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)
				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_7 = math.max(var_182_1, arg_179_1.talkMaxDuration)

			if var_182_0 <= arg_179_1.time_ and arg_179_1.time_ < var_182_0 + var_182_7 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_0) / var_182_7

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_0 + var_182_7 and arg_179_1.time_ < var_182_0 + var_182_7 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play121521045 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 121521045
		arg_183_1.duration_ = 5

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play121521046(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = 0
			local var_186_1 = 1.4

			if var_186_0 < arg_183_1.time_ and arg_183_1.time_ <= var_186_0 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, false)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_2 = arg_183_1:GetWordFromCfg(121521045)
				local var_186_3 = arg_183_1:FormatText(var_186_2.content)

				arg_183_1.text_.text = var_186_3

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_4 = 56
				local var_186_5 = utf8.len(var_186_3)
				local var_186_6 = var_186_4 <= 0 and var_186_1 or var_186_1 * (var_186_5 / var_186_4)

				if var_186_6 > 0 and var_186_1 < var_186_6 then
					arg_183_1.talkMaxDuration = var_186_6

					if var_186_6 + var_186_0 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_6 + var_186_0
					end
				end

				arg_183_1.text_.text = var_186_3
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)
				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_7 = math.max(var_186_1, arg_183_1.talkMaxDuration)

			if var_186_0 <= arg_183_1.time_ and arg_183_1.time_ < var_186_0 + var_186_7 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_0) / var_186_7

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_0 + var_186_7 and arg_183_1.time_ < var_186_0 + var_186_7 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {}

		arg_183_1:InitPlayNodeList()
	end,
	Play121521046 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 121521046
		arg_187_1.duration_ = 8.8

		local var_187_0 = {
			ja = 8.8,
			ko = 6.166,
			zh = 6.166
		}
		local var_187_1 = manager.audio:GetLocalizationFlag()

		if var_187_0[var_187_1] ~= nil then
			arg_187_1.duration_ = var_187_0[var_187_1]
		end

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play121521047(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = arg_187_1.actors_["1084ui_story"]
			local var_190_1 = 0

			if var_190_1 < arg_187_1.time_ and arg_187_1.time_ <= var_190_1 + arg_190_0 and not isNil(var_190_0) and arg_187_1.var_.characterEffect1084ui_story == nil then
				arg_187_1.var_.characterEffect1084ui_story = var_190_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_2 = 0.200000002980232

			if var_190_1 <= arg_187_1.time_ and arg_187_1.time_ < var_190_1 + var_190_2 and not isNil(var_190_0) then
				local var_190_3 = (arg_187_1.time_ - var_190_1) / var_190_2

				if arg_187_1.var_.characterEffect1084ui_story and not isNil(var_190_0) then
					arg_187_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_187_1.time_ >= var_190_1 + var_190_2 and arg_187_1.time_ < var_190_1 + var_190_2 + arg_190_0 and not isNil(var_190_0) and arg_187_1.var_.characterEffect1084ui_story then
				arg_187_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_190_4 = 0
			local var_190_5 = 0.825

			if var_190_4 < arg_187_1.time_ and arg_187_1.time_ <= var_190_4 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				local var_190_6 = arg_187_1:FormatText(StoryNameCfg[6].name)

				arg_187_1.leftNameTxt_.text = var_190_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_7 = arg_187_1:GetWordFromCfg(121521046)
				local var_190_8 = arg_187_1:FormatText(var_190_7.content)

				arg_187_1.text_.text = var_190_8

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_9 = 33
				local var_190_10 = utf8.len(var_190_8)
				local var_190_11 = var_190_9 <= 0 and var_190_5 or var_190_5 * (var_190_10 / var_190_9)

				if var_190_11 > 0 and var_190_5 < var_190_11 then
					arg_187_1.talkMaxDuration = var_190_11

					if var_190_11 + var_190_4 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_11 + var_190_4
					end
				end

				arg_187_1.text_.text = var_190_8
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121521", "121521046", "story_v_out_121521.awb") ~= 0 then
					local var_190_12 = manager.audio:GetVoiceLength("story_v_out_121521", "121521046", "story_v_out_121521.awb") / 1000

					if var_190_12 + var_190_4 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_12 + var_190_4
					end

					if var_190_7.prefab_name ~= "" and arg_187_1.actors_[var_190_7.prefab_name] ~= nil then
						local var_190_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_187_1.actors_[var_190_7.prefab_name].transform, "story_v_out_121521", "121521046", "story_v_out_121521.awb")

						arg_187_1:RecordAudio("121521046", var_190_13)
						arg_187_1:RecordAudio("121521046", var_190_13)
					else
						arg_187_1:AudioAction("play", "voice", "story_v_out_121521", "121521046", "story_v_out_121521.awb")
					end

					arg_187_1:RecordHistoryTalkVoice("story_v_out_121521", "121521046", "story_v_out_121521.awb")
				end

				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_14 = math.max(var_190_5, arg_187_1.talkMaxDuration)

			if var_190_4 <= arg_187_1.time_ and arg_187_1.time_ < var_190_4 + var_190_14 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_4) / var_190_14

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_4 + var_190_14 and arg_187_1.time_ < var_190_4 + var_190_14 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play121521047 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 121521047
		arg_191_1.duration_ = 9.53

		local var_191_0 = {
			ja = 9.533,
			ko = 8,
			zh = 8
		}
		local var_191_1 = manager.audio:GetLocalizationFlag()

		if var_191_0[var_191_1] ~= nil then
			arg_191_1.duration_ = var_191_0[var_191_1]
		end

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play121521048(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = arg_191_1.actors_["1075ui_story"]
			local var_194_1 = 0

			if var_194_1 < arg_191_1.time_ and arg_191_1.time_ <= var_194_1 + arg_194_0 and not isNil(var_194_0) and arg_191_1.var_.characterEffect1075ui_story == nil then
				arg_191_1.var_.characterEffect1075ui_story = var_194_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_194_2 = 0.200000002980232

			if var_194_1 <= arg_191_1.time_ and arg_191_1.time_ < var_194_1 + var_194_2 and not isNil(var_194_0) then
				local var_194_3 = (arg_191_1.time_ - var_194_1) / var_194_2

				if arg_191_1.var_.characterEffect1075ui_story and not isNil(var_194_0) then
					arg_191_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_191_1.time_ >= var_194_1 + var_194_2 and arg_191_1.time_ < var_194_1 + var_194_2 + arg_194_0 and not isNil(var_194_0) and arg_191_1.var_.characterEffect1075ui_story then
				arg_191_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_194_4 = 0

			if var_194_4 < arg_191_1.time_ and arg_191_1.time_ <= var_194_4 + arg_194_0 then
				arg_191_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action5_2")
			end

			local var_194_5 = 0

			if var_194_5 < arg_191_1.time_ and arg_191_1.time_ <= var_194_5 + arg_194_0 then
				arg_191_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_194_6 = arg_191_1.actors_["1084ui_story"]
			local var_194_7 = 0

			if var_194_7 < arg_191_1.time_ and arg_191_1.time_ <= var_194_7 + arg_194_0 and not isNil(var_194_6) and arg_191_1.var_.characterEffect1084ui_story == nil then
				arg_191_1.var_.characterEffect1084ui_story = var_194_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_194_8 = 0.200000002980232

			if var_194_7 <= arg_191_1.time_ and arg_191_1.time_ < var_194_7 + var_194_8 and not isNil(var_194_6) then
				local var_194_9 = (arg_191_1.time_ - var_194_7) / var_194_8

				if arg_191_1.var_.characterEffect1084ui_story and not isNil(var_194_6) then
					local var_194_10 = Mathf.Lerp(0, 0.5, var_194_9)

					arg_191_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_191_1.var_.characterEffect1084ui_story.fillRatio = var_194_10
				end
			end

			if arg_191_1.time_ >= var_194_7 + var_194_8 and arg_191_1.time_ < var_194_7 + var_194_8 + arg_194_0 and not isNil(var_194_6) and arg_191_1.var_.characterEffect1084ui_story then
				local var_194_11 = 0.5

				arg_191_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_191_1.var_.characterEffect1084ui_story.fillRatio = var_194_11
			end

			local var_194_12 = 0
			local var_194_13 = 1.05

			if var_194_12 < arg_191_1.time_ and arg_191_1.time_ <= var_194_12 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				local var_194_14 = arg_191_1:FormatText(StoryNameCfg[381].name)

				arg_191_1.leftNameTxt_.text = var_194_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_15 = arg_191_1:GetWordFromCfg(121521047)
				local var_194_16 = arg_191_1:FormatText(var_194_15.content)

				arg_191_1.text_.text = var_194_16

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_17 = 42
				local var_194_18 = utf8.len(var_194_16)
				local var_194_19 = var_194_17 <= 0 and var_194_13 or var_194_13 * (var_194_18 / var_194_17)

				if var_194_19 > 0 and var_194_13 < var_194_19 then
					arg_191_1.talkMaxDuration = var_194_19

					if var_194_19 + var_194_12 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_19 + var_194_12
					end
				end

				arg_191_1.text_.text = var_194_16
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121521", "121521047", "story_v_out_121521.awb") ~= 0 then
					local var_194_20 = manager.audio:GetVoiceLength("story_v_out_121521", "121521047", "story_v_out_121521.awb") / 1000

					if var_194_20 + var_194_12 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_20 + var_194_12
					end

					if var_194_15.prefab_name ~= "" and arg_191_1.actors_[var_194_15.prefab_name] ~= nil then
						local var_194_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_15.prefab_name].transform, "story_v_out_121521", "121521047", "story_v_out_121521.awb")

						arg_191_1:RecordAudio("121521047", var_194_21)
						arg_191_1:RecordAudio("121521047", var_194_21)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_out_121521", "121521047", "story_v_out_121521.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_out_121521", "121521047", "story_v_out_121521.awb")
				end

				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_22 = math.max(var_194_13, arg_191_1.talkMaxDuration)

			if var_194_12 <= arg_191_1.time_ and arg_191_1.time_ < var_194_12 + var_194_22 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_12) / var_194_22

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_12 + var_194_22 and arg_191_1.time_ < var_194_12 + var_194_22 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {}

		arg_191_1:InitPlayNodeList()
	end,
	Play121521048 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 121521048
		arg_195_1.duration_ = 11.4

		local var_195_0 = {
			ja = 11.4,
			ko = 6.733,
			zh = 6.733
		}
		local var_195_1 = manager.audio:GetLocalizationFlag()

		if var_195_0[var_195_1] ~= nil then
			arg_195_1.duration_ = var_195_0[var_195_1]
		end

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play121521049(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = 0
			local var_198_1 = 0.85

			if var_198_0 < arg_195_1.time_ and arg_195_1.time_ <= var_198_0 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				local var_198_2 = arg_195_1:FormatText(StoryNameCfg[381].name)

				arg_195_1.leftNameTxt_.text = var_198_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_3 = arg_195_1:GetWordFromCfg(121521048)
				local var_198_4 = arg_195_1:FormatText(var_198_3.content)

				arg_195_1.text_.text = var_198_4

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_5 = 34
				local var_198_6 = utf8.len(var_198_4)
				local var_198_7 = var_198_5 <= 0 and var_198_1 or var_198_1 * (var_198_6 / var_198_5)

				if var_198_7 > 0 and var_198_1 < var_198_7 then
					arg_195_1.talkMaxDuration = var_198_7

					if var_198_7 + var_198_0 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_7 + var_198_0
					end
				end

				arg_195_1.text_.text = var_198_4
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121521", "121521048", "story_v_out_121521.awb") ~= 0 then
					local var_198_8 = manager.audio:GetVoiceLength("story_v_out_121521", "121521048", "story_v_out_121521.awb") / 1000

					if var_198_8 + var_198_0 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_8 + var_198_0
					end

					if var_198_3.prefab_name ~= "" and arg_195_1.actors_[var_198_3.prefab_name] ~= nil then
						local var_198_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_3.prefab_name].transform, "story_v_out_121521", "121521048", "story_v_out_121521.awb")

						arg_195_1:RecordAudio("121521048", var_198_9)
						arg_195_1:RecordAudio("121521048", var_198_9)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_out_121521", "121521048", "story_v_out_121521.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_out_121521", "121521048", "story_v_out_121521.awb")
				end

				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_10 = math.max(var_198_1, arg_195_1.talkMaxDuration)

			if var_198_0 <= arg_195_1.time_ and arg_195_1.time_ < var_198_0 + var_198_10 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_0) / var_198_10

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_0 + var_198_10 and arg_195_1.time_ < var_198_0 + var_198_10 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {}

		arg_195_1:InitPlayNodeList()
	end,
	Play121521049 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 121521049
		arg_199_1.duration_ = 6.63

		local var_199_0 = {
			ja = 6.633,
			ko = 3.5,
			zh = 3.5
		}
		local var_199_1 = manager.audio:GetLocalizationFlag()

		if var_199_0[var_199_1] ~= nil then
			arg_199_1.duration_ = var_199_0[var_199_1]
		end

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play121521050(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = arg_199_1.actors_["1084ui_story"]
			local var_202_1 = 0

			if var_202_1 < arg_199_1.time_ and arg_199_1.time_ <= var_202_1 + arg_202_0 and not isNil(var_202_0) and arg_199_1.var_.characterEffect1084ui_story == nil then
				arg_199_1.var_.characterEffect1084ui_story = var_202_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_202_2 = 0.200000002980232

			if var_202_1 <= arg_199_1.time_ and arg_199_1.time_ < var_202_1 + var_202_2 and not isNil(var_202_0) then
				local var_202_3 = (arg_199_1.time_ - var_202_1) / var_202_2

				if arg_199_1.var_.characterEffect1084ui_story and not isNil(var_202_0) then
					arg_199_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_199_1.time_ >= var_202_1 + var_202_2 and arg_199_1.time_ < var_202_1 + var_202_2 + arg_202_0 and not isNil(var_202_0) and arg_199_1.var_.characterEffect1084ui_story then
				arg_199_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_202_4 = 0

			if var_202_4 < arg_199_1.time_ and arg_199_1.time_ <= var_202_4 + arg_202_0 then
				arg_199_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action4137")
			end

			local var_202_5 = 0

			if var_202_5 < arg_199_1.time_ and arg_199_1.time_ <= var_202_5 + arg_202_0 then
				arg_199_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_202_6 = arg_199_1.actors_["1075ui_story"]
			local var_202_7 = 0

			if var_202_7 < arg_199_1.time_ and arg_199_1.time_ <= var_202_7 + arg_202_0 and not isNil(var_202_6) and arg_199_1.var_.characterEffect1075ui_story == nil then
				arg_199_1.var_.characterEffect1075ui_story = var_202_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_202_8 = 0.200000002980232

			if var_202_7 <= arg_199_1.time_ and arg_199_1.time_ < var_202_7 + var_202_8 and not isNil(var_202_6) then
				local var_202_9 = (arg_199_1.time_ - var_202_7) / var_202_8

				if arg_199_1.var_.characterEffect1075ui_story and not isNil(var_202_6) then
					local var_202_10 = Mathf.Lerp(0, 0.5, var_202_9)

					arg_199_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_199_1.var_.characterEffect1075ui_story.fillRatio = var_202_10
				end
			end

			if arg_199_1.time_ >= var_202_7 + var_202_8 and arg_199_1.time_ < var_202_7 + var_202_8 + arg_202_0 and not isNil(var_202_6) and arg_199_1.var_.characterEffect1075ui_story then
				local var_202_11 = 0.5

				arg_199_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_199_1.var_.characterEffect1075ui_story.fillRatio = var_202_11
			end

			local var_202_12 = 0
			local var_202_13 = 0.4

			if var_202_12 < arg_199_1.time_ and arg_199_1.time_ <= var_202_12 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				local var_202_14 = arg_199_1:FormatText(StoryNameCfg[6].name)

				arg_199_1.leftNameTxt_.text = var_202_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_15 = arg_199_1:GetWordFromCfg(121521049)
				local var_202_16 = arg_199_1:FormatText(var_202_15.content)

				arg_199_1.text_.text = var_202_16

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_17 = 16
				local var_202_18 = utf8.len(var_202_16)
				local var_202_19 = var_202_17 <= 0 and var_202_13 or var_202_13 * (var_202_18 / var_202_17)

				if var_202_19 > 0 and var_202_13 < var_202_19 then
					arg_199_1.talkMaxDuration = var_202_19

					if var_202_19 + var_202_12 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_19 + var_202_12
					end
				end

				arg_199_1.text_.text = var_202_16
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121521", "121521049", "story_v_out_121521.awb") ~= 0 then
					local var_202_20 = manager.audio:GetVoiceLength("story_v_out_121521", "121521049", "story_v_out_121521.awb") / 1000

					if var_202_20 + var_202_12 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_20 + var_202_12
					end

					if var_202_15.prefab_name ~= "" and arg_199_1.actors_[var_202_15.prefab_name] ~= nil then
						local var_202_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_199_1.actors_[var_202_15.prefab_name].transform, "story_v_out_121521", "121521049", "story_v_out_121521.awb")

						arg_199_1:RecordAudio("121521049", var_202_21)
						arg_199_1:RecordAudio("121521049", var_202_21)
					else
						arg_199_1:AudioAction("play", "voice", "story_v_out_121521", "121521049", "story_v_out_121521.awb")
					end

					arg_199_1:RecordHistoryTalkVoice("story_v_out_121521", "121521049", "story_v_out_121521.awb")
				end

				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_22 = math.max(var_202_13, arg_199_1.talkMaxDuration)

			if var_202_12 <= arg_199_1.time_ and arg_199_1.time_ < var_202_12 + var_202_22 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_12) / var_202_22

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_12 + var_202_22 and arg_199_1.time_ < var_202_12 + var_202_22 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {}

		arg_199_1:InitPlayNodeList()
	end,
	Play121521050 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 121521050
		arg_203_1.duration_ = 8.03

		local var_203_0 = {
			ja = 5.133,
			ko = 8.033,
			zh = 8.033
		}
		local var_203_1 = manager.audio:GetLocalizationFlag()

		if var_203_0[var_203_1] ~= nil then
			arg_203_1.duration_ = var_203_0[var_203_1]
		end

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play121521051(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			local var_206_0 = arg_203_1.actors_["1075ui_story"]
			local var_206_1 = 0

			if var_206_1 < arg_203_1.time_ and arg_203_1.time_ <= var_206_1 + arg_206_0 and not isNil(var_206_0) and arg_203_1.var_.characterEffect1075ui_story == nil then
				arg_203_1.var_.characterEffect1075ui_story = var_206_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_206_2 = 0.200000002980232

			if var_206_1 <= arg_203_1.time_ and arg_203_1.time_ < var_206_1 + var_206_2 and not isNil(var_206_0) then
				local var_206_3 = (arg_203_1.time_ - var_206_1) / var_206_2

				if arg_203_1.var_.characterEffect1075ui_story and not isNil(var_206_0) then
					arg_203_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_203_1.time_ >= var_206_1 + var_206_2 and arg_203_1.time_ < var_206_1 + var_206_2 + arg_206_0 and not isNil(var_206_0) and arg_203_1.var_.characterEffect1075ui_story then
				arg_203_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_206_4 = 0

			if var_206_4 < arg_203_1.time_ and arg_203_1.time_ <= var_206_4 + arg_206_0 then
				arg_203_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action1_1")
			end

			local var_206_5 = 0

			if var_206_5 < arg_203_1.time_ and arg_203_1.time_ <= var_206_5 + arg_206_0 then
				arg_203_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_206_6 = arg_203_1.actors_["1084ui_story"]
			local var_206_7 = 0

			if var_206_7 < arg_203_1.time_ and arg_203_1.time_ <= var_206_7 + arg_206_0 and not isNil(var_206_6) and arg_203_1.var_.characterEffect1084ui_story == nil then
				arg_203_1.var_.characterEffect1084ui_story = var_206_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_206_8 = 0.200000002980232

			if var_206_7 <= arg_203_1.time_ and arg_203_1.time_ < var_206_7 + var_206_8 and not isNil(var_206_6) then
				local var_206_9 = (arg_203_1.time_ - var_206_7) / var_206_8

				if arg_203_1.var_.characterEffect1084ui_story and not isNil(var_206_6) then
					local var_206_10 = Mathf.Lerp(0, 0.5, var_206_9)

					arg_203_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_203_1.var_.characterEffect1084ui_story.fillRatio = var_206_10
				end
			end

			if arg_203_1.time_ >= var_206_7 + var_206_8 and arg_203_1.time_ < var_206_7 + var_206_8 + arg_206_0 and not isNil(var_206_6) and arg_203_1.var_.characterEffect1084ui_story then
				local var_206_11 = 0.5

				arg_203_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_203_1.var_.characterEffect1084ui_story.fillRatio = var_206_11
			end

			local var_206_12 = 0
			local var_206_13 = 1.025

			if var_206_12 < arg_203_1.time_ and arg_203_1.time_ <= var_206_12 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				local var_206_14 = arg_203_1:FormatText(StoryNameCfg[381].name)

				arg_203_1.leftNameTxt_.text = var_206_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_15 = arg_203_1:GetWordFromCfg(121521050)
				local var_206_16 = arg_203_1:FormatText(var_206_15.content)

				arg_203_1.text_.text = var_206_16

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_17 = 41
				local var_206_18 = utf8.len(var_206_16)
				local var_206_19 = var_206_17 <= 0 and var_206_13 or var_206_13 * (var_206_18 / var_206_17)

				if var_206_19 > 0 and var_206_13 < var_206_19 then
					arg_203_1.talkMaxDuration = var_206_19

					if var_206_19 + var_206_12 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_19 + var_206_12
					end
				end

				arg_203_1.text_.text = var_206_16
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121521", "121521050", "story_v_out_121521.awb") ~= 0 then
					local var_206_20 = manager.audio:GetVoiceLength("story_v_out_121521", "121521050", "story_v_out_121521.awb") / 1000

					if var_206_20 + var_206_12 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_20 + var_206_12
					end

					if var_206_15.prefab_name ~= "" and arg_203_1.actors_[var_206_15.prefab_name] ~= nil then
						local var_206_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_15.prefab_name].transform, "story_v_out_121521", "121521050", "story_v_out_121521.awb")

						arg_203_1:RecordAudio("121521050", var_206_21)
						arg_203_1:RecordAudio("121521050", var_206_21)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_out_121521", "121521050", "story_v_out_121521.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_out_121521", "121521050", "story_v_out_121521.awb")
				end

				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_22 = math.max(var_206_13, arg_203_1.talkMaxDuration)

			if var_206_12 <= arg_203_1.time_ and arg_203_1.time_ < var_206_12 + var_206_22 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_12) / var_206_22

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_12 + var_206_22 and arg_203_1.time_ < var_206_12 + var_206_22 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {}

		arg_203_1:InitPlayNodeList()
	end,
	Play121521051 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 121521051
		arg_207_1.duration_ = 4.93

		local var_207_0 = {
			ja = 4.933,
			ko = 4.433,
			zh = 4.433
		}
		local var_207_1 = manager.audio:GetLocalizationFlag()

		if var_207_0[var_207_1] ~= nil then
			arg_207_1.duration_ = var_207_0[var_207_1]
		end

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play121521052(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			local var_210_0 = 0
			local var_210_1 = 0.5

			if var_210_0 < arg_207_1.time_ and arg_207_1.time_ <= var_210_0 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				local var_210_2 = arg_207_1:FormatText(StoryNameCfg[381].name)

				arg_207_1.leftNameTxt_.text = var_210_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_3 = arg_207_1:GetWordFromCfg(121521051)
				local var_210_4 = arg_207_1:FormatText(var_210_3.content)

				arg_207_1.text_.text = var_210_4

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_5 = 20
				local var_210_6 = utf8.len(var_210_4)
				local var_210_7 = var_210_5 <= 0 and var_210_1 or var_210_1 * (var_210_6 / var_210_5)

				if var_210_7 > 0 and var_210_1 < var_210_7 then
					arg_207_1.talkMaxDuration = var_210_7

					if var_210_7 + var_210_0 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_7 + var_210_0
					end
				end

				arg_207_1.text_.text = var_210_4
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121521", "121521051", "story_v_out_121521.awb") ~= 0 then
					local var_210_8 = manager.audio:GetVoiceLength("story_v_out_121521", "121521051", "story_v_out_121521.awb") / 1000

					if var_210_8 + var_210_0 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_8 + var_210_0
					end

					if var_210_3.prefab_name ~= "" and arg_207_1.actors_[var_210_3.prefab_name] ~= nil then
						local var_210_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_207_1.actors_[var_210_3.prefab_name].transform, "story_v_out_121521", "121521051", "story_v_out_121521.awb")

						arg_207_1:RecordAudio("121521051", var_210_9)
						arg_207_1:RecordAudio("121521051", var_210_9)
					else
						arg_207_1:AudioAction("play", "voice", "story_v_out_121521", "121521051", "story_v_out_121521.awb")
					end

					arg_207_1:RecordHistoryTalkVoice("story_v_out_121521", "121521051", "story_v_out_121521.awb")
				end

				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_10 = math.max(var_210_1, arg_207_1.talkMaxDuration)

			if var_210_0 <= arg_207_1.time_ and arg_207_1.time_ < var_210_0 + var_210_10 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_0) / var_210_10

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_0 + var_210_10 and arg_207_1.time_ < var_210_0 + var_210_10 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {}

		arg_207_1:InitPlayNodeList()
	end,
	Play121521052 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 121521052
		arg_211_1.duration_ = 5

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play121521053(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			local var_214_0 = arg_211_1.actors_["1075ui_story"].transform
			local var_214_1 = 0

			if var_214_1 < arg_211_1.time_ and arg_211_1.time_ <= var_214_1 + arg_214_0 then
				arg_211_1.var_.moveOldPos1075ui_story = var_214_0.localPosition
			end

			local var_214_2 = 0.001

			if var_214_1 <= arg_211_1.time_ and arg_211_1.time_ < var_214_1 + var_214_2 then
				local var_214_3 = (arg_211_1.time_ - var_214_1) / var_214_2
				local var_214_4 = Vector3.New(0, 100, 0)

				var_214_0.localPosition = Vector3.Lerp(arg_211_1.var_.moveOldPos1075ui_story, var_214_4, var_214_3)

				local var_214_5 = manager.ui.mainCamera.transform.position - var_214_0.position

				var_214_0.forward = Vector3.New(var_214_5.x, var_214_5.y, var_214_5.z)

				local var_214_6 = var_214_0.localEulerAngles

				var_214_6.z = 0
				var_214_6.x = 0
				var_214_0.localEulerAngles = var_214_6
			end

			if arg_211_1.time_ >= var_214_1 + var_214_2 and arg_211_1.time_ < var_214_1 + var_214_2 + arg_214_0 then
				var_214_0.localPosition = Vector3.New(0, 100, 0)

				local var_214_7 = manager.ui.mainCamera.transform.position - var_214_0.position

				var_214_0.forward = Vector3.New(var_214_7.x, var_214_7.y, var_214_7.z)

				local var_214_8 = var_214_0.localEulerAngles

				var_214_8.z = 0
				var_214_8.x = 0
				var_214_0.localEulerAngles = var_214_8
			end

			local var_214_9 = arg_211_1.actors_["1075ui_story"]
			local var_214_10 = 0

			if var_214_10 < arg_211_1.time_ and arg_211_1.time_ <= var_214_10 + arg_214_0 and not isNil(var_214_9) and arg_211_1.var_.characterEffect1075ui_story == nil then
				arg_211_1.var_.characterEffect1075ui_story = var_214_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_214_11 = 0.200000002980232

			if var_214_10 <= arg_211_1.time_ and arg_211_1.time_ < var_214_10 + var_214_11 and not isNil(var_214_9) then
				local var_214_12 = (arg_211_1.time_ - var_214_10) / var_214_11

				if arg_211_1.var_.characterEffect1075ui_story and not isNil(var_214_9) then
					local var_214_13 = Mathf.Lerp(0, 0.5, var_214_12)

					arg_211_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_211_1.var_.characterEffect1075ui_story.fillRatio = var_214_13
				end
			end

			if arg_211_1.time_ >= var_214_10 + var_214_11 and arg_211_1.time_ < var_214_10 + var_214_11 + arg_214_0 and not isNil(var_214_9) and arg_211_1.var_.characterEffect1075ui_story then
				local var_214_14 = 0.5

				arg_211_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_211_1.var_.characterEffect1075ui_story.fillRatio = var_214_14
			end

			local var_214_15 = arg_211_1.actors_["1084ui_story"].transform
			local var_214_16 = 0

			if var_214_16 < arg_211_1.time_ and arg_211_1.time_ <= var_214_16 + arg_214_0 then
				arg_211_1.var_.moveOldPos1084ui_story = var_214_15.localPosition
			end

			local var_214_17 = 0.001

			if var_214_16 <= arg_211_1.time_ and arg_211_1.time_ < var_214_16 + var_214_17 then
				local var_214_18 = (arg_211_1.time_ - var_214_16) / var_214_17
				local var_214_19 = Vector3.New(0, 100, 0)

				var_214_15.localPosition = Vector3.Lerp(arg_211_1.var_.moveOldPos1084ui_story, var_214_19, var_214_18)

				local var_214_20 = manager.ui.mainCamera.transform.position - var_214_15.position

				var_214_15.forward = Vector3.New(var_214_20.x, var_214_20.y, var_214_20.z)

				local var_214_21 = var_214_15.localEulerAngles

				var_214_21.z = 0
				var_214_21.x = 0
				var_214_15.localEulerAngles = var_214_21
			end

			if arg_211_1.time_ >= var_214_16 + var_214_17 and arg_211_1.time_ < var_214_16 + var_214_17 + arg_214_0 then
				var_214_15.localPosition = Vector3.New(0, 100, 0)

				local var_214_22 = manager.ui.mainCamera.transform.position - var_214_15.position

				var_214_15.forward = Vector3.New(var_214_22.x, var_214_22.y, var_214_22.z)

				local var_214_23 = var_214_15.localEulerAngles

				var_214_23.z = 0
				var_214_23.x = 0
				var_214_15.localEulerAngles = var_214_23
			end

			local var_214_24 = arg_211_1.actors_["1084ui_story"]
			local var_214_25 = 0

			if var_214_25 < arg_211_1.time_ and arg_211_1.time_ <= var_214_25 + arg_214_0 and not isNil(var_214_24) and arg_211_1.var_.characterEffect1084ui_story == nil then
				arg_211_1.var_.characterEffect1084ui_story = var_214_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_214_26 = 0.200000002980232

			if var_214_25 <= arg_211_1.time_ and arg_211_1.time_ < var_214_25 + var_214_26 and not isNil(var_214_24) then
				local var_214_27 = (arg_211_1.time_ - var_214_25) / var_214_26

				if arg_211_1.var_.characterEffect1084ui_story and not isNil(var_214_24) then
					local var_214_28 = Mathf.Lerp(0, 0.5, var_214_27)

					arg_211_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_211_1.var_.characterEffect1084ui_story.fillRatio = var_214_28
				end
			end

			if arg_211_1.time_ >= var_214_25 + var_214_26 and arg_211_1.time_ < var_214_25 + var_214_26 + arg_214_0 and not isNil(var_214_24) and arg_211_1.var_.characterEffect1084ui_story then
				local var_214_29 = 0.5

				arg_211_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_211_1.var_.characterEffect1084ui_story.fillRatio = var_214_29
			end

			local var_214_30 = 0
			local var_214_31 = 1.325

			if var_214_30 < arg_211_1.time_ and arg_211_1.time_ <= var_214_30 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, false)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_32 = arg_211_1:GetWordFromCfg(121521052)
				local var_214_33 = arg_211_1:FormatText(var_214_32.content)

				arg_211_1.text_.text = var_214_33

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_34 = 53
				local var_214_35 = utf8.len(var_214_33)
				local var_214_36 = var_214_34 <= 0 and var_214_31 or var_214_31 * (var_214_35 / var_214_34)

				if var_214_36 > 0 and var_214_31 < var_214_36 then
					arg_211_1.talkMaxDuration = var_214_36

					if var_214_36 + var_214_30 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_36 + var_214_30
					end
				end

				arg_211_1.text_.text = var_214_33
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)
				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_37 = math.max(var_214_31, arg_211_1.talkMaxDuration)

			if var_214_30 <= arg_211_1.time_ and arg_211_1.time_ < var_214_30 + var_214_37 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_30) / var_214_37

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_30 + var_214_37 and arg_211_1.time_ < var_214_30 + var_214_37 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_211_1:InitPlayNodeList()
	end,
	Play121521053 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 121521053
		arg_215_1.duration_ = 5

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play121521054(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			local var_218_0 = 0
			local var_218_1 = 1.175

			if var_218_0 < arg_215_1.time_ and arg_215_1.time_ <= var_218_0 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, false)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_2 = arg_215_1:GetWordFromCfg(121521053)
				local var_218_3 = arg_215_1:FormatText(var_218_2.content)

				arg_215_1.text_.text = var_218_3

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_4 = 47
				local var_218_5 = utf8.len(var_218_3)
				local var_218_6 = var_218_4 <= 0 and var_218_1 or var_218_1 * (var_218_5 / var_218_4)

				if var_218_6 > 0 and var_218_1 < var_218_6 then
					arg_215_1.talkMaxDuration = var_218_6

					if var_218_6 + var_218_0 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_6 + var_218_0
					end
				end

				arg_215_1.text_.text = var_218_3
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)
				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_7 = math.max(var_218_1, arg_215_1.talkMaxDuration)

			if var_218_0 <= arg_215_1.time_ and arg_215_1.time_ < var_218_0 + var_218_7 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_0) / var_218_7

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_0 + var_218_7 and arg_215_1.time_ < var_218_0 + var_218_7 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {}

		arg_215_1:InitPlayNodeList()
	end,
	Play121521054 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 121521054
		arg_219_1.duration_ = 5

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play121521055(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			local var_222_0 = 0
			local var_222_1 = 0.275

			if var_222_0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_0 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				local var_222_2 = arg_219_1:FormatText(StoryNameCfg[7].name)

				arg_219_1.leftNameTxt_.text = var_222_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, true)
				arg_219_1.iconController_:SetSelectedState("hero")

				arg_219_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_219_1.callingController_:SetSelectedState("normal")

				arg_219_1.keyicon_.color = Color.New(1, 1, 1)
				arg_219_1.icon_.color = Color.New(1, 1, 1)

				local var_222_3 = arg_219_1:GetWordFromCfg(121521054)
				local var_222_4 = arg_219_1:FormatText(var_222_3.content)

				arg_219_1.text_.text = var_222_4

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_5 = 11
				local var_222_6 = utf8.len(var_222_4)
				local var_222_7 = var_222_5 <= 0 and var_222_1 or var_222_1 * (var_222_6 / var_222_5)

				if var_222_7 > 0 and var_222_1 < var_222_7 then
					arg_219_1.talkMaxDuration = var_222_7

					if var_222_7 + var_222_0 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_7 + var_222_0
					end
				end

				arg_219_1.text_.text = var_222_4
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)
				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_8 = math.max(var_222_1, arg_219_1.talkMaxDuration)

			if var_222_0 <= arg_219_1.time_ and arg_219_1.time_ < var_222_0 + var_222_8 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_0) / var_222_8

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_0 + var_222_8 and arg_219_1.time_ < var_222_0 + var_222_8 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {}

		arg_219_1:InitPlayNodeList()
	end,
	Play121521055 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 121521055
		arg_223_1.duration_ = 5

		SetActive(arg_223_1.tipsGo_, false)

		function arg_223_1.onSingleLineFinish_()
			arg_223_1.onSingleLineUpdate_ = nil
			arg_223_1.onSingleLineFinish_ = nil
			arg_223_1.state_ = "waiting"
		end

		function arg_223_1.playNext_(arg_225_0)
			if arg_225_0 == 1 then
				arg_223_0:Play121521056(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			local var_226_0 = 0
			local var_226_1 = 0.8

			if var_226_0 < arg_223_1.time_ and arg_223_1.time_ <= var_226_0 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, false)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_2 = arg_223_1:GetWordFromCfg(121521055)
				local var_226_3 = arg_223_1:FormatText(var_226_2.content)

				arg_223_1.text_.text = var_226_3

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_4 = 32
				local var_226_5 = utf8.len(var_226_3)
				local var_226_6 = var_226_4 <= 0 and var_226_1 or var_226_1 * (var_226_5 / var_226_4)

				if var_226_6 > 0 and var_226_1 < var_226_6 then
					arg_223_1.talkMaxDuration = var_226_6

					if var_226_6 + var_226_0 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_6 + var_226_0
					end
				end

				arg_223_1.text_.text = var_226_3
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)
				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_7 = math.max(var_226_1, arg_223_1.talkMaxDuration)

			if var_226_0 <= arg_223_1.time_ and arg_223_1.time_ < var_226_0 + var_226_7 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_0) / var_226_7

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_0 + var_226_7 and arg_223_1.time_ < var_226_0 + var_226_7 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {}

		arg_223_1:InitPlayNodeList()
	end,
	Play121521056 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 121521056
		arg_227_1.duration_ = 5

		SetActive(arg_227_1.tipsGo_, false)

		function arg_227_1.onSingleLineFinish_()
			arg_227_1.onSingleLineUpdate_ = nil
			arg_227_1.onSingleLineFinish_ = nil
			arg_227_1.state_ = "waiting"
		end

		function arg_227_1.playNext_(arg_229_0)
			if arg_229_0 == 1 then
				arg_227_0:Play121521057(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			local var_230_0 = 0
			local var_230_1 = 0.633333333333333

			if var_230_0 < arg_227_1.time_ and arg_227_1.time_ <= var_230_0 + arg_230_0 then
				local var_230_2 = "play"
				local var_230_3 = "effect"

				arg_227_1:AudioAction(var_230_2, var_230_3, "se_story_121_04", "se_story_121_04_engineclose", "")
			end

			local var_230_4 = 0
			local var_230_5 = 0.775

			if var_230_4 < arg_227_1.time_ and arg_227_1.time_ <= var_230_4 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				local var_230_6 = arg_227_1:FormatText(StoryNameCfg[7].name)

				arg_227_1.leftNameTxt_.text = var_230_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, true)
				arg_227_1.iconController_:SetSelectedState("hero")

				arg_227_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_227_1.callingController_:SetSelectedState("normal")

				arg_227_1.keyicon_.color = Color.New(1, 1, 1)
				arg_227_1.icon_.color = Color.New(1, 1, 1)

				local var_230_7 = arg_227_1:GetWordFromCfg(121521056)
				local var_230_8 = arg_227_1:FormatText(var_230_7.content)

				arg_227_1.text_.text = var_230_8

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_9 = 31
				local var_230_10 = utf8.len(var_230_8)
				local var_230_11 = var_230_9 <= 0 and var_230_5 or var_230_5 * (var_230_10 / var_230_9)

				if var_230_11 > 0 and var_230_5 < var_230_11 then
					arg_227_1.talkMaxDuration = var_230_11

					if var_230_11 + var_230_4 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_11 + var_230_4
					end
				end

				arg_227_1.text_.text = var_230_8
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)
				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_12 = math.max(var_230_5, arg_227_1.talkMaxDuration)

			if var_230_4 <= arg_227_1.time_ and arg_227_1.time_ < var_230_4 + var_230_12 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_4) / var_230_12

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_4 + var_230_12 and arg_227_1.time_ < var_230_4 + var_230_12 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {}

		arg_227_1:InitPlayNodeList()
	end,
	Play121521057 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 121521057
		arg_231_1.duration_ = 2.23

		local var_231_0 = {
			ja = 2.233,
			ko = 1.999999999999,
			zh = 1.999999999999
		}
		local var_231_1 = manager.audio:GetLocalizationFlag()

		if var_231_0[var_231_1] ~= nil then
			arg_231_1.duration_ = var_231_0[var_231_1]
		end

		SetActive(arg_231_1.tipsGo_, false)

		function arg_231_1.onSingleLineFinish_()
			arg_231_1.onSingleLineUpdate_ = nil
			arg_231_1.onSingleLineFinish_ = nil
			arg_231_1.state_ = "waiting"
		end

		function arg_231_1.playNext_(arg_233_0)
			if arg_233_0 == 1 then
				arg_231_0:Play121521058(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			local var_234_0 = arg_231_1.actors_["1084ui_story"].transform
			local var_234_1 = 0

			if var_234_1 < arg_231_1.time_ and arg_231_1.time_ <= var_234_1 + arg_234_0 then
				arg_231_1.var_.moveOldPos1084ui_story = var_234_0.localPosition
			end

			local var_234_2 = 0.001

			if var_234_1 <= arg_231_1.time_ and arg_231_1.time_ < var_234_1 + var_234_2 then
				local var_234_3 = (arg_231_1.time_ - var_234_1) / var_234_2
				local var_234_4 = Vector3.New(0, -0.97, -6)

				var_234_0.localPosition = Vector3.Lerp(arg_231_1.var_.moveOldPos1084ui_story, var_234_4, var_234_3)

				local var_234_5 = manager.ui.mainCamera.transform.position - var_234_0.position

				var_234_0.forward = Vector3.New(var_234_5.x, var_234_5.y, var_234_5.z)

				local var_234_6 = var_234_0.localEulerAngles

				var_234_6.z = 0
				var_234_6.x = 0
				var_234_0.localEulerAngles = var_234_6
			end

			if arg_231_1.time_ >= var_234_1 + var_234_2 and arg_231_1.time_ < var_234_1 + var_234_2 + arg_234_0 then
				var_234_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_234_7 = manager.ui.mainCamera.transform.position - var_234_0.position

				var_234_0.forward = Vector3.New(var_234_7.x, var_234_7.y, var_234_7.z)

				local var_234_8 = var_234_0.localEulerAngles

				var_234_8.z = 0
				var_234_8.x = 0
				var_234_0.localEulerAngles = var_234_8
			end

			local var_234_9 = arg_231_1.actors_["1084ui_story"]
			local var_234_10 = 0

			if var_234_10 < arg_231_1.time_ and arg_231_1.time_ <= var_234_10 + arg_234_0 and not isNil(var_234_9) and arg_231_1.var_.characterEffect1084ui_story == nil then
				arg_231_1.var_.characterEffect1084ui_story = var_234_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_234_11 = 0.200000002980232

			if var_234_10 <= arg_231_1.time_ and arg_231_1.time_ < var_234_10 + var_234_11 and not isNil(var_234_9) then
				local var_234_12 = (arg_231_1.time_ - var_234_10) / var_234_11

				if arg_231_1.var_.characterEffect1084ui_story and not isNil(var_234_9) then
					arg_231_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_231_1.time_ >= var_234_10 + var_234_11 and arg_231_1.time_ < var_234_10 + var_234_11 + arg_234_0 and not isNil(var_234_9) and arg_231_1.var_.characterEffect1084ui_story then
				arg_231_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_234_13 = 0

			if var_234_13 < arg_231_1.time_ and arg_231_1.time_ <= var_234_13 + arg_234_0 then
				arg_231_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			local var_234_14 = 0

			if var_234_14 < arg_231_1.time_ and arg_231_1.time_ <= var_234_14 + arg_234_0 then
				arg_231_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_234_15 = 0
			local var_234_16 = 0.2

			if var_234_15 < arg_231_1.time_ and arg_231_1.time_ <= var_234_15 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				local var_234_17 = arg_231_1:FormatText(StoryNameCfg[6].name)

				arg_231_1.leftNameTxt_.text = var_234_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_18 = arg_231_1:GetWordFromCfg(121521057)
				local var_234_19 = arg_231_1:FormatText(var_234_18.content)

				arg_231_1.text_.text = var_234_19

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_20 = 8
				local var_234_21 = utf8.len(var_234_19)
				local var_234_22 = var_234_20 <= 0 and var_234_16 or var_234_16 * (var_234_21 / var_234_20)

				if var_234_22 > 0 and var_234_16 < var_234_22 then
					arg_231_1.talkMaxDuration = var_234_22

					if var_234_22 + var_234_15 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_22 + var_234_15
					end
				end

				arg_231_1.text_.text = var_234_19
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121521", "121521057", "story_v_out_121521.awb") ~= 0 then
					local var_234_23 = manager.audio:GetVoiceLength("story_v_out_121521", "121521057", "story_v_out_121521.awb") / 1000

					if var_234_23 + var_234_15 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_23 + var_234_15
					end

					if var_234_18.prefab_name ~= "" and arg_231_1.actors_[var_234_18.prefab_name] ~= nil then
						local var_234_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_231_1.actors_[var_234_18.prefab_name].transform, "story_v_out_121521", "121521057", "story_v_out_121521.awb")

						arg_231_1:RecordAudio("121521057", var_234_24)
						arg_231_1:RecordAudio("121521057", var_234_24)
					else
						arg_231_1:AudioAction("play", "voice", "story_v_out_121521", "121521057", "story_v_out_121521.awb")
					end

					arg_231_1:RecordHistoryTalkVoice("story_v_out_121521", "121521057", "story_v_out_121521.awb")
				end

				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_25 = math.max(var_234_16, arg_231_1.talkMaxDuration)

			if var_234_15 <= arg_231_1.time_ and arg_231_1.time_ < var_234_15 + var_234_25 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_15) / var_234_25

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_15 + var_234_25 and arg_231_1.time_ < var_234_15 + var_234_25 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_231_1:InitPlayNodeList()
	end,
	Play121521058 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 121521058
		arg_235_1.duration_ = 9

		SetActive(arg_235_1.tipsGo_, false)

		function arg_235_1.onSingleLineFinish_()
			arg_235_1.onSingleLineUpdate_ = nil
			arg_235_1.onSingleLineFinish_ = nil
			arg_235_1.state_ = "waiting"
		end

		function arg_235_1.playNext_(arg_237_0)
			if arg_237_0 == 1 then
				arg_235_0:Play121521059(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			local var_238_0 = "XH0306"

			if arg_235_1.bgs_[var_238_0] == nil then
				local var_238_1 = Object.Instantiate(arg_235_1.paintGo_)

				var_238_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_238_0)
				var_238_1.name = var_238_0
				var_238_1.transform.parent = arg_235_1.stage_.transform
				var_238_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_235_1.bgs_[var_238_0] = var_238_1
			end

			local var_238_2 = 2

			if var_238_2 < arg_235_1.time_ and arg_235_1.time_ <= var_238_2 + arg_238_0 then
				local var_238_3 = manager.ui.mainCamera.transform.localPosition
				local var_238_4 = Vector3.New(0, 0, 10) + Vector3.New(var_238_3.x, var_238_3.y, 0)
				local var_238_5 = arg_235_1.bgs_.XH0306

				var_238_5.transform.localPosition = var_238_4
				var_238_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_238_6 = var_238_5:GetComponent("SpriteRenderer")

				if var_238_6 and var_238_6.sprite then
					local var_238_7 = (var_238_5.transform.localPosition - var_238_3).z
					local var_238_8 = manager.ui.mainCameraCom_
					local var_238_9 = 2 * var_238_7 * Mathf.Tan(var_238_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_238_10 = var_238_9 * var_238_8.aspect
					local var_238_11 = var_238_6.sprite.bounds.size.x
					local var_238_12 = var_238_6.sprite.bounds.size.y
					local var_238_13 = var_238_10 / var_238_11
					local var_238_14 = var_238_9 / var_238_12
					local var_238_15 = var_238_14 < var_238_13 and var_238_13 or var_238_14

					var_238_5.transform.localScale = Vector3.New(var_238_15, var_238_15, 0)
				end

				for iter_238_0, iter_238_1 in pairs(arg_235_1.bgs_) do
					if iter_238_0 ~= "XH0306" then
						iter_238_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_238_16 = 0

			if var_238_16 < arg_235_1.time_ and arg_235_1.time_ <= var_238_16 + arg_238_0 then
				arg_235_1.mask_.enabled = true
				arg_235_1.mask_.raycastTarget = true

				arg_235_1:SetGaussion(false)
			end

			local var_238_17 = 2

			if var_238_16 <= arg_235_1.time_ and arg_235_1.time_ < var_238_16 + var_238_17 then
				local var_238_18 = (arg_235_1.time_ - var_238_16) / var_238_17
				local var_238_19 = Color.New(0, 0, 0)

				var_238_19.a = Mathf.Lerp(0, 1, var_238_18)
				arg_235_1.mask_.color = var_238_19
			end

			if arg_235_1.time_ >= var_238_16 + var_238_17 and arg_235_1.time_ < var_238_16 + var_238_17 + arg_238_0 then
				local var_238_20 = Color.New(0, 0, 0)

				var_238_20.a = 1
				arg_235_1.mask_.color = var_238_20
			end

			local var_238_21 = 2

			if var_238_21 < arg_235_1.time_ and arg_235_1.time_ <= var_238_21 + arg_238_0 then
				arg_235_1.mask_.enabled = true
				arg_235_1.mask_.raycastTarget = true

				arg_235_1:SetGaussion(false)
			end

			local var_238_22 = 2

			if var_238_21 <= arg_235_1.time_ and arg_235_1.time_ < var_238_21 + var_238_22 then
				local var_238_23 = (arg_235_1.time_ - var_238_21) / var_238_22
				local var_238_24 = Color.New(0, 0, 0)

				var_238_24.a = Mathf.Lerp(1, 0, var_238_23)
				arg_235_1.mask_.color = var_238_24
			end

			if arg_235_1.time_ >= var_238_21 + var_238_22 and arg_235_1.time_ < var_238_21 + var_238_22 + arg_238_0 then
				local var_238_25 = Color.New(0, 0, 0)
				local var_238_26 = 0

				arg_235_1.mask_.enabled = false
				var_238_25.a = var_238_26
				arg_235_1.mask_.color = var_238_25
			end

			local var_238_27 = arg_235_1.actors_["1084ui_story"].transform
			local var_238_28 = 1.96599999815226

			if var_238_28 < arg_235_1.time_ and arg_235_1.time_ <= var_238_28 + arg_238_0 then
				arg_235_1.var_.moveOldPos1084ui_story = var_238_27.localPosition
			end

			local var_238_29 = 0.001

			if var_238_28 <= arg_235_1.time_ and arg_235_1.time_ < var_238_28 + var_238_29 then
				local var_238_30 = (arg_235_1.time_ - var_238_28) / var_238_29
				local var_238_31 = Vector3.New(0, 100, 0)

				var_238_27.localPosition = Vector3.Lerp(arg_235_1.var_.moveOldPos1084ui_story, var_238_31, var_238_30)

				local var_238_32 = manager.ui.mainCamera.transform.position - var_238_27.position

				var_238_27.forward = Vector3.New(var_238_32.x, var_238_32.y, var_238_32.z)

				local var_238_33 = var_238_27.localEulerAngles

				var_238_33.z = 0
				var_238_33.x = 0
				var_238_27.localEulerAngles = var_238_33
			end

			if arg_235_1.time_ >= var_238_28 + var_238_29 and arg_235_1.time_ < var_238_28 + var_238_29 + arg_238_0 then
				var_238_27.localPosition = Vector3.New(0, 100, 0)

				local var_238_34 = manager.ui.mainCamera.transform.position - var_238_27.position

				var_238_27.forward = Vector3.New(var_238_34.x, var_238_34.y, var_238_34.z)

				local var_238_35 = var_238_27.localEulerAngles

				var_238_35.z = 0
				var_238_35.x = 0
				var_238_27.localEulerAngles = var_238_35
			end

			local var_238_36 = arg_235_1.actors_["1084ui_story"]
			local var_238_37 = 1.96599999815226

			if var_238_37 < arg_235_1.time_ and arg_235_1.time_ <= var_238_37 + arg_238_0 and not isNil(var_238_36) and arg_235_1.var_.characterEffect1084ui_story == nil then
				arg_235_1.var_.characterEffect1084ui_story = var_238_36:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_238_38 = 0.034000001847744

			if var_238_37 <= arg_235_1.time_ and arg_235_1.time_ < var_238_37 + var_238_38 and not isNil(var_238_36) then
				local var_238_39 = (arg_235_1.time_ - var_238_37) / var_238_38

				if arg_235_1.var_.characterEffect1084ui_story and not isNil(var_238_36) then
					local var_238_40 = Mathf.Lerp(0, 0.5, var_238_39)

					arg_235_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_235_1.var_.characterEffect1084ui_story.fillRatio = var_238_40
				end
			end

			if arg_235_1.time_ >= var_238_37 + var_238_38 and arg_235_1.time_ < var_238_37 + var_238_38 + arg_238_0 and not isNil(var_238_36) and arg_235_1.var_.characterEffect1084ui_story then
				local var_238_41 = 0.5

				arg_235_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_235_1.var_.characterEffect1084ui_story.fillRatio = var_238_41
			end

			local var_238_42 = arg_235_1.bgs_.XH0306.transform
			local var_238_43 = 2

			if var_238_43 < arg_235_1.time_ and arg_235_1.time_ <= var_238_43 + arg_238_0 then
				arg_235_1.var_.moveOldPosXH0306 = var_238_42.localPosition
			end

			local var_238_44 = 0.001

			if var_238_43 <= arg_235_1.time_ and arg_235_1.time_ < var_238_43 + var_238_44 then
				local var_238_45 = (arg_235_1.time_ - var_238_43) / var_238_44
				local var_238_46 = Vector3.New(0, 1, 9)

				var_238_42.localPosition = Vector3.Lerp(arg_235_1.var_.moveOldPosXH0306, var_238_46, var_238_45)
			end

			if arg_235_1.time_ >= var_238_43 + var_238_44 and arg_235_1.time_ < var_238_43 + var_238_44 + arg_238_0 then
				var_238_42.localPosition = Vector3.New(0, 1, 9)
			end

			local var_238_47 = arg_235_1.bgs_.XH0306.transform
			local var_238_48 = 2.01666666666667

			if var_238_48 < arg_235_1.time_ and arg_235_1.time_ <= var_238_48 + arg_238_0 then
				arg_235_1.var_.moveOldPosXH0306 = var_238_47.localPosition
			end

			local var_238_49 = 5

			if var_238_48 <= arg_235_1.time_ and arg_235_1.time_ < var_238_48 + var_238_49 then
				local var_238_50 = (arg_235_1.time_ - var_238_48) / var_238_49
				local var_238_51 = Vector3.New(0, 1, 10)

				var_238_47.localPosition = Vector3.Lerp(arg_235_1.var_.moveOldPosXH0306, var_238_51, var_238_50)
			end

			if arg_235_1.time_ >= var_238_48 + var_238_49 and arg_235_1.time_ < var_238_48 + var_238_49 + arg_238_0 then
				var_238_47.localPosition = Vector3.New(0, 1, 10)
			end

			local var_238_52 = 4

			if var_238_52 < arg_235_1.time_ and arg_235_1.time_ <= var_238_52 + arg_238_0 then
				arg_235_1.allBtn_.enabled = false
			end

			local var_238_53 = 3.01666666666667

			if arg_235_1.time_ >= var_238_52 + var_238_53 and arg_235_1.time_ < var_238_52 + var_238_53 + arg_238_0 then
				arg_235_1.allBtn_.enabled = true
			end

			if arg_235_1.frameCnt_ <= 1 then
				arg_235_1.dialog_:SetActive(false)
			end

			local var_238_54 = 4
			local var_238_55 = 0.45

			if var_238_54 < arg_235_1.time_ and arg_235_1.time_ <= var_238_54 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0

				arg_235_1.dialog_:SetActive(true)

				arg_235_1.dialogCg_.alpha = 0

				local var_238_56 = LeanTween.value(arg_235_1.dialog_, 0, 1, 0.3)

				var_238_56:setOnUpdate(LuaHelper.FloatAction(function(arg_239_0)
					arg_235_1.dialogCg_.alpha = arg_239_0
				end))
				var_238_56:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_235_1.dialog_)
					var_238_56:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_235_1.duration_ = arg_235_1.duration_ + 0.3

				SetActive(arg_235_1.leftNameGo_, false)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_57 = arg_235_1:GetWordFromCfg(121521058)
				local var_238_58 = arg_235_1:FormatText(var_238_57.content)

				arg_235_1.text_.text = var_238_58

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_59 = 18
				local var_238_60 = utf8.len(var_238_58)
				local var_238_61 = var_238_59 <= 0 and var_238_55 or var_238_55 * (var_238_60 / var_238_59)

				if var_238_61 > 0 and var_238_55 < var_238_61 then
					arg_235_1.talkMaxDuration = var_238_61
					var_238_54 = var_238_54 + 0.3

					if var_238_61 + var_238_54 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_61 + var_238_54
					end
				end

				arg_235_1.text_.text = var_238_58
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)
				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_62 = var_238_54 + 0.3
			local var_238_63 = math.max(var_238_55, arg_235_1.talkMaxDuration)

			if var_238_62 <= arg_235_1.time_ and arg_235_1.time_ < var_238_62 + var_238_63 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_62) / var_238_63

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_62 + var_238_63 and arg_235_1.time_ < var_238_62 + var_238_63 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "XH0306",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "XH0306",
				changeDisplayLayer = false,
				needEase = false,
				duration = 5,
				className = "StoryMoveNode",
				startTime = 2.01666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_235_1:InitPlayNodeList()
	end,
	Play121521059 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 121521059
		arg_241_1.duration_ = 5

		SetActive(arg_241_1.tipsGo_, false)

		function arg_241_1.onSingleLineFinish_()
			arg_241_1.onSingleLineUpdate_ = nil
			arg_241_1.onSingleLineFinish_ = nil
			arg_241_1.state_ = "waiting"
		end

		function arg_241_1.playNext_(arg_243_0)
			if arg_243_0 == 1 then
				arg_241_0:Play121521060(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			local var_244_0 = 0
			local var_244_1 = 0.8

			if var_244_0 < arg_241_1.time_ and arg_241_1.time_ <= var_244_0 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, false)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_2 = arg_241_1:GetWordFromCfg(121521059)
				local var_244_3 = arg_241_1:FormatText(var_244_2.content)

				arg_241_1.text_.text = var_244_3

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_4 = 32
				local var_244_5 = utf8.len(var_244_3)
				local var_244_6 = var_244_4 <= 0 and var_244_1 or var_244_1 * (var_244_5 / var_244_4)

				if var_244_6 > 0 and var_244_1 < var_244_6 then
					arg_241_1.talkMaxDuration = var_244_6

					if var_244_6 + var_244_0 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_6 + var_244_0
					end
				end

				arg_241_1.text_.text = var_244_3
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)
				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_7 = math.max(var_244_1, arg_241_1.talkMaxDuration)

			if var_244_0 <= arg_241_1.time_ and arg_241_1.time_ < var_244_0 + var_244_7 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_0) / var_244_7

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_0 + var_244_7 and arg_241_1.time_ < var_244_0 + var_244_7 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {}

		arg_241_1:InitPlayNodeList()
	end,
	Play121521060 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 121521060
		arg_245_1.duration_ = 5.2

		local var_245_0 = {
			ja = 5.2,
			ko = 3.533,
			zh = 3.533
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
				arg_245_0:Play121521061(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			local var_248_0 = 0
			local var_248_1 = 0.25

			if var_248_0 < arg_245_1.time_ and arg_245_1.time_ <= var_248_0 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, true)

				local var_248_2 = arg_245_1:FormatText(StoryNameCfg[6].name)

				arg_245_1.leftNameTxt_.text = var_248_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, true)
				arg_245_1.iconController_:SetSelectedState("hero")

				arg_245_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_245_1.callingController_:SetSelectedState("normal")

				arg_245_1.keyicon_.color = Color.New(1, 1, 1)
				arg_245_1.icon_.color = Color.New(1, 1, 1)

				local var_248_3 = arg_245_1:GetWordFromCfg(121521060)
				local var_248_4 = arg_245_1:FormatText(var_248_3.content)

				arg_245_1.text_.text = var_248_4

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_5 = 10
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

				if manager.audio:GetVoiceLength("story_v_out_121521", "121521060", "story_v_out_121521.awb") ~= 0 then
					local var_248_8 = manager.audio:GetVoiceLength("story_v_out_121521", "121521060", "story_v_out_121521.awb") / 1000

					if var_248_8 + var_248_0 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_8 + var_248_0
					end

					if var_248_3.prefab_name ~= "" and arg_245_1.actors_[var_248_3.prefab_name] ~= nil then
						local var_248_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_245_1.actors_[var_248_3.prefab_name].transform, "story_v_out_121521", "121521060", "story_v_out_121521.awb")

						arg_245_1:RecordAudio("121521060", var_248_9)
						arg_245_1:RecordAudio("121521060", var_248_9)
					else
						arg_245_1:AudioAction("play", "voice", "story_v_out_121521", "121521060", "story_v_out_121521.awb")
					end

					arg_245_1:RecordHistoryTalkVoice("story_v_out_121521", "121521060", "story_v_out_121521.awb")
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
	Play121521061 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 121521061
		arg_249_1.duration_ = 5

		SetActive(arg_249_1.tipsGo_, false)

		function arg_249_1.onSingleLineFinish_()
			arg_249_1.onSingleLineUpdate_ = nil
			arg_249_1.onSingleLineFinish_ = nil
			arg_249_1.state_ = "waiting"
		end

		function arg_249_1.playNext_(arg_251_0)
			if arg_251_0 == 1 then
				arg_249_0:Play121521062(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			local var_252_0 = 0
			local var_252_1 = 0.633333333333333

			if var_252_0 < arg_249_1.time_ and arg_249_1.time_ <= var_252_0 + arg_252_0 then
				local var_252_2 = "play"
				local var_252_3 = "effect"

				arg_249_1:AudioAction(var_252_2, var_252_3, "se_story_121_04", "se_story_121_04_engineclose_loop", "")
			end

			local var_252_4 = 0
			local var_252_5 = 1.55

			if var_252_4 < arg_249_1.time_ and arg_249_1.time_ <= var_252_4 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, false)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_6 = arg_249_1:GetWordFromCfg(121521061)
				local var_252_7 = arg_249_1:FormatText(var_252_6.content)

				arg_249_1.text_.text = var_252_7

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_8 = 62
				local var_252_9 = utf8.len(var_252_7)
				local var_252_10 = var_252_8 <= 0 and var_252_5 or var_252_5 * (var_252_9 / var_252_8)

				if var_252_10 > 0 and var_252_5 < var_252_10 then
					arg_249_1.talkMaxDuration = var_252_10

					if var_252_10 + var_252_4 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_10 + var_252_4
					end
				end

				arg_249_1.text_.text = var_252_7
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)
				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_11 = math.max(var_252_5, arg_249_1.talkMaxDuration)

			if var_252_4 <= arg_249_1.time_ and arg_249_1.time_ < var_252_4 + var_252_11 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_4) / var_252_11

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_4 + var_252_11 and arg_249_1.time_ < var_252_4 + var_252_11 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {}

		arg_249_1:InitPlayNodeList()
	end,
	Play121521062 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 121521062
		arg_253_1.duration_ = 5

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play121521063(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			local var_256_0 = 0
			local var_256_1 = 1.425

			if var_256_0 < arg_253_1.time_ and arg_253_1.time_ <= var_256_0 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, false)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_2 = arg_253_1:GetWordFromCfg(121521062)
				local var_256_3 = arg_253_1:FormatText(var_256_2.content)

				arg_253_1.text_.text = var_256_3

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_4 = 57
				local var_256_5 = utf8.len(var_256_3)
				local var_256_6 = var_256_4 <= 0 and var_256_1 or var_256_1 * (var_256_5 / var_256_4)

				if var_256_6 > 0 and var_256_1 < var_256_6 then
					arg_253_1.talkMaxDuration = var_256_6

					if var_256_6 + var_256_0 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_6 + var_256_0
					end
				end

				arg_253_1.text_.text = var_256_3
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)
				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_7 = math.max(var_256_1, arg_253_1.talkMaxDuration)

			if var_256_0 <= arg_253_1.time_ and arg_253_1.time_ < var_256_0 + var_256_7 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_0) / var_256_7

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_0 + var_256_7 and arg_253_1.time_ < var_256_0 + var_256_7 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {}

		arg_253_1:InitPlayNodeList()
	end,
	Play121521063 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 121521063
		arg_257_1.duration_ = 5

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
		end

		function arg_257_1.playNext_(arg_259_0)
			if arg_259_0 == 1 then
				arg_257_0:Play121521064(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			local var_260_0 = 0
			local var_260_1 = 0.475

			if var_260_0 < arg_257_1.time_ and arg_257_1.time_ <= var_260_0 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, false)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_2 = arg_257_1:GetWordFromCfg(121521063)
				local var_260_3 = arg_257_1:FormatText(var_260_2.content)

				arg_257_1.text_.text = var_260_3

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_4 = 19
				local var_260_5 = utf8.len(var_260_3)
				local var_260_6 = var_260_4 <= 0 and var_260_1 or var_260_1 * (var_260_5 / var_260_4)

				if var_260_6 > 0 and var_260_1 < var_260_6 then
					arg_257_1.talkMaxDuration = var_260_6

					if var_260_6 + var_260_0 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_6 + var_260_0
					end
				end

				arg_257_1.text_.text = var_260_3
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)
				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_7 = math.max(var_260_1, arg_257_1.talkMaxDuration)

			if var_260_0 <= arg_257_1.time_ and arg_257_1.time_ < var_260_0 + var_260_7 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_0) / var_260_7

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_0 + var_260_7 and arg_257_1.time_ < var_260_0 + var_260_7 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {}

		arg_257_1:InitPlayNodeList()
	end,
	Play121521064 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 121521064
		arg_261_1.duration_ = 4.97

		local var_261_0 = {
			ja = 4.933,
			ko = 4.966,
			zh = 4.966
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
				arg_261_0:Play121521065(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			local var_264_0 = 0
			local var_264_1 = 0.725

			if var_264_0 < arg_261_1.time_ and arg_261_1.time_ <= var_264_0 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				local var_264_2 = arg_261_1:FormatText(StoryNameCfg[381].name)

				arg_261_1.leftNameTxt_.text = var_264_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, true)
				arg_261_1.iconController_:SetSelectedState("hero")

				arg_261_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1075")

				arg_261_1.callingController_:SetSelectedState("normal")

				arg_261_1.keyicon_.color = Color.New(1, 1, 1)
				arg_261_1.icon_.color = Color.New(1, 1, 1)

				local var_264_3 = arg_261_1:GetWordFromCfg(121521064)
				local var_264_4 = arg_261_1:FormatText(var_264_3.content)

				arg_261_1.text_.text = var_264_4

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_5 = 29
				local var_264_6 = utf8.len(var_264_4)
				local var_264_7 = var_264_5 <= 0 and var_264_1 or var_264_1 * (var_264_6 / var_264_5)

				if var_264_7 > 0 and var_264_1 < var_264_7 then
					arg_261_1.talkMaxDuration = var_264_7

					if var_264_7 + var_264_0 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_7 + var_264_0
					end
				end

				arg_261_1.text_.text = var_264_4
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121521", "121521064", "story_v_out_121521.awb") ~= 0 then
					local var_264_8 = manager.audio:GetVoiceLength("story_v_out_121521", "121521064", "story_v_out_121521.awb") / 1000

					if var_264_8 + var_264_0 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_8 + var_264_0
					end

					if var_264_3.prefab_name ~= "" and arg_261_1.actors_[var_264_3.prefab_name] ~= nil then
						local var_264_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_261_1.actors_[var_264_3.prefab_name].transform, "story_v_out_121521", "121521064", "story_v_out_121521.awb")

						arg_261_1:RecordAudio("121521064", var_264_9)
						arg_261_1:RecordAudio("121521064", var_264_9)
					else
						arg_261_1:AudioAction("play", "voice", "story_v_out_121521", "121521064", "story_v_out_121521.awb")
					end

					arg_261_1:RecordHistoryTalkVoice("story_v_out_121521", "121521064", "story_v_out_121521.awb")
				end

				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_10 = math.max(var_264_1, arg_261_1.talkMaxDuration)

			if var_264_0 <= arg_261_1.time_ and arg_261_1.time_ < var_264_0 + var_264_10 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_0) / var_264_10

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_0 + var_264_10 and arg_261_1.time_ < var_264_0 + var_264_10 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {}

		arg_261_1:InitPlayNodeList()
	end,
	Play121521065 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 121521065
		arg_265_1.duration_ = 2.1

		local var_265_0 = {
			ja = 2.1,
			ko = 1.633,
			zh = 1.633
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
		end

		function arg_265_1.playNext_(arg_267_0)
			if arg_267_0 == 1 then
				arg_265_0:Play121521066(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			local var_268_0 = 0
			local var_268_1 = 0.1

			if var_268_0 < arg_265_1.time_ and arg_265_1.time_ <= var_268_0 + arg_268_0 then
				local var_268_2 = "stop"
				local var_268_3 = "music"

				arg_265_1:AudioAction(var_268_2, var_268_3, "se_story_121_04", "se_story_121_04_engineclose_loop", "")

				local var_268_4 = ""
				local var_268_5 = manager.audio:GetAudioName("se_story_121_04", "se_story_121_04_engineclose_loop")

				if var_268_5 ~= "" then
					if arg_265_1.bgmTxt_.text ~= var_268_5 and arg_265_1.bgmTxt_.text ~= "" then
						if arg_265_1.bgmTxt2_.text ~= "" then
							arg_265_1.bgmTxt_.text = arg_265_1.bgmTxt2_.text
						end

						arg_265_1.bgmTxt2_.text = var_268_5

						arg_265_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_265_1.bgmTxt_.text = var_268_5
						arg_265_1.bgmTxt2_.text = var_268_5
					end

					if arg_265_1.bgmTimer then
						arg_265_1.bgmTimer:Stop()

						arg_265_1.bgmTimer = nil
					end

					if arg_265_1.settingData.show_music_name == 1 then
						arg_265_1.musicController:SetSelectedState("show")
						arg_265_1.musicAnimator_:Play("open", 0, 0)

						if arg_265_1.settingData.music_time ~= 0 then
							arg_265_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_265_1.settingData.music_time), function()
								if arg_265_1 == nil or isNil(arg_265_1.bgmTxt_) then
									return
								end

								arg_265_1.musicController:SetSelectedState("hide")
								arg_265_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_268_6 = 0.133333333333333
			local var_268_7 = 0.633333333333333

			if var_268_6 < arg_265_1.time_ and arg_265_1.time_ <= var_268_6 + arg_268_0 then
				local var_268_8 = "play"
				local var_268_9 = "effect"

				arg_265_1:AudioAction(var_268_8, var_268_9, "se_story_121_04", "se_story_121_04_enginerepair", "")
			end

			local var_268_10 = 0
			local var_268_11 = 0.175

			if var_268_10 < arg_265_1.time_ and arg_265_1.time_ <= var_268_10 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				local var_268_12 = arg_265_1:FormatText(StoryNameCfg[6].name)

				arg_265_1.leftNameTxt_.text = var_268_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, true)
				arg_265_1.iconController_:SetSelectedState("hero")

				arg_265_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_265_1.callingController_:SetSelectedState("normal")

				arg_265_1.keyicon_.color = Color.New(1, 1, 1)
				arg_265_1.icon_.color = Color.New(1, 1, 1)

				local var_268_13 = arg_265_1:GetWordFromCfg(121521065)
				local var_268_14 = arg_265_1:FormatText(var_268_13.content)

				arg_265_1.text_.text = var_268_14

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_15 = 7
				local var_268_16 = utf8.len(var_268_14)
				local var_268_17 = var_268_15 <= 0 and var_268_11 or var_268_11 * (var_268_16 / var_268_15)

				if var_268_17 > 0 and var_268_11 < var_268_17 then
					arg_265_1.talkMaxDuration = var_268_17

					if var_268_17 + var_268_10 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_17 + var_268_10
					end
				end

				arg_265_1.text_.text = var_268_14
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121521", "121521065", "story_v_out_121521.awb") ~= 0 then
					local var_268_18 = manager.audio:GetVoiceLength("story_v_out_121521", "121521065", "story_v_out_121521.awb") / 1000

					if var_268_18 + var_268_10 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_18 + var_268_10
					end

					if var_268_13.prefab_name ~= "" and arg_265_1.actors_[var_268_13.prefab_name] ~= nil then
						local var_268_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_265_1.actors_[var_268_13.prefab_name].transform, "story_v_out_121521", "121521065", "story_v_out_121521.awb")

						arg_265_1:RecordAudio("121521065", var_268_19)
						arg_265_1:RecordAudio("121521065", var_268_19)
					else
						arg_265_1:AudioAction("play", "voice", "story_v_out_121521", "121521065", "story_v_out_121521.awb")
					end

					arg_265_1:RecordHistoryTalkVoice("story_v_out_121521", "121521065", "story_v_out_121521.awb")
				end

				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_20 = math.max(var_268_11, arg_265_1.talkMaxDuration)

			if var_268_10 <= arg_265_1.time_ and arg_265_1.time_ < var_268_10 + var_268_20 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_10) / var_268_20

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_10 + var_268_20 and arg_265_1.time_ < var_268_10 + var_268_20 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {}

		arg_265_1:InitPlayNodeList()
	end,
	Play121521066 = function(arg_270_0, arg_270_1)
		arg_270_1.time_ = 0
		arg_270_1.frameCnt_ = 0
		arg_270_1.state_ = "playing"
		arg_270_1.curTalkId_ = 121521066
		arg_270_1.duration_ = 9

		SetActive(arg_270_1.tipsGo_, false)

		function arg_270_1.onSingleLineFinish_()
			arg_270_1.onSingleLineUpdate_ = nil
			arg_270_1.onSingleLineFinish_ = nil
			arg_270_1.state_ = "waiting"
		end

		function arg_270_1.playNext_(arg_272_0)
			if arg_272_0 == 1 then
				arg_270_0:Play121521067(arg_270_1)
			end
		end

		function arg_270_1.onSingleLineUpdate_(arg_273_0)
			local var_273_0 = 2

			if var_273_0 < arg_270_1.time_ and arg_270_1.time_ <= var_273_0 + arg_273_0 then
				local var_273_1 = manager.ui.mainCamera.transform.localPosition
				local var_273_2 = Vector3.New(0, 0, 10) + Vector3.New(var_273_1.x, var_273_1.y, 0)
				local var_273_3 = arg_270_1.bgs_.J12f

				var_273_3.transform.localPosition = var_273_2
				var_273_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_273_4 = var_273_3:GetComponent("SpriteRenderer")

				if var_273_4 and var_273_4.sprite then
					local var_273_5 = (var_273_3.transform.localPosition - var_273_1).z
					local var_273_6 = manager.ui.mainCameraCom_
					local var_273_7 = 2 * var_273_5 * Mathf.Tan(var_273_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_273_8 = var_273_7 * var_273_6.aspect
					local var_273_9 = var_273_4.sprite.bounds.size.x
					local var_273_10 = var_273_4.sprite.bounds.size.y
					local var_273_11 = var_273_8 / var_273_9
					local var_273_12 = var_273_7 / var_273_10
					local var_273_13 = var_273_12 < var_273_11 and var_273_11 or var_273_12

					var_273_3.transform.localScale = Vector3.New(var_273_13, var_273_13, 0)
				end

				for iter_273_0, iter_273_1 in pairs(arg_270_1.bgs_) do
					if iter_273_0 ~= "J12f" then
						iter_273_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_273_14 = 0

			if var_273_14 < arg_270_1.time_ and arg_270_1.time_ <= var_273_14 + arg_273_0 then
				arg_270_1.mask_.enabled = true
				arg_270_1.mask_.raycastTarget = true

				arg_270_1:SetGaussion(false)
			end

			local var_273_15 = 2

			if var_273_14 <= arg_270_1.time_ and arg_270_1.time_ < var_273_14 + var_273_15 then
				local var_273_16 = (arg_270_1.time_ - var_273_14) / var_273_15
				local var_273_17 = Color.New(0, 0, 0)

				var_273_17.a = Mathf.Lerp(0, 1, var_273_16)
				arg_270_1.mask_.color = var_273_17
			end

			if arg_270_1.time_ >= var_273_14 + var_273_15 and arg_270_1.time_ < var_273_14 + var_273_15 + arg_273_0 then
				local var_273_18 = Color.New(0, 0, 0)

				var_273_18.a = 1
				arg_270_1.mask_.color = var_273_18
			end

			local var_273_19 = 2

			if var_273_19 < arg_270_1.time_ and arg_270_1.time_ <= var_273_19 + arg_273_0 then
				arg_270_1.mask_.enabled = true
				arg_270_1.mask_.raycastTarget = true

				arg_270_1:SetGaussion(false)
			end

			local var_273_20 = 2

			if var_273_19 <= arg_270_1.time_ and arg_270_1.time_ < var_273_19 + var_273_20 then
				local var_273_21 = (arg_270_1.time_ - var_273_19) / var_273_20
				local var_273_22 = Color.New(1, 1, 1)

				var_273_22.a = Mathf.Lerp(1, 0, var_273_21)
				arg_270_1.mask_.color = var_273_22
			end

			if arg_270_1.time_ >= var_273_19 + var_273_20 and arg_270_1.time_ < var_273_19 + var_273_20 + arg_273_0 then
				local var_273_23 = Color.New(1, 1, 1)
				local var_273_24 = 0

				arg_270_1.mask_.enabled = false
				var_273_23.a = var_273_24
				arg_270_1.mask_.color = var_273_23
			end

			local var_273_25 = 0
			local var_273_26 = 0.633333333333333

			if var_273_25 < arg_270_1.time_ and arg_270_1.time_ <= var_273_25 + arg_273_0 then
				local var_273_27 = "play"
				local var_273_28 = "effect"

				arg_270_1:AudioAction(var_273_27, var_273_28, "se_story_121_04", "se_story_121_04_crowd_loop", "")
			end

			if arg_270_1.frameCnt_ <= 1 then
				arg_270_1.dialog_:SetActive(false)
			end

			local var_273_29 = 4
			local var_273_30 = 0.975

			if var_273_29 < arg_270_1.time_ and arg_270_1.time_ <= var_273_29 + arg_273_0 then
				arg_270_1.talkMaxDuration = 0

				arg_270_1.dialog_:SetActive(true)

				arg_270_1.dialogCg_.alpha = 0

				local var_273_31 = LeanTween.value(arg_270_1.dialog_, 0, 1, 0.3)

				var_273_31:setOnUpdate(LuaHelper.FloatAction(function(arg_274_0)
					arg_270_1.dialogCg_.alpha = arg_274_0
				end))
				var_273_31:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_270_1.dialog_)
					var_273_31:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_270_1.duration_ = arg_270_1.duration_ + 0.3

				SetActive(arg_270_1.leftNameGo_, false)

				arg_270_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_270_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_270_1:RecordName(arg_270_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_270_1.iconTrs_.gameObject, false)
				arg_270_1.callingController_:SetSelectedState("normal")

				local var_273_32 = arg_270_1:GetWordFromCfg(121521066)
				local var_273_33 = arg_270_1:FormatText(var_273_32.content)

				arg_270_1.text_.text = var_273_33

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.text_)

				local var_273_34 = 39
				local var_273_35 = utf8.len(var_273_33)
				local var_273_36 = var_273_34 <= 0 and var_273_30 or var_273_30 * (var_273_35 / var_273_34)

				if var_273_36 > 0 and var_273_30 < var_273_36 then
					arg_270_1.talkMaxDuration = var_273_36
					var_273_29 = var_273_29 + 0.3

					if var_273_36 + var_273_29 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_36 + var_273_29
					end
				end

				arg_270_1.text_.text = var_273_33
				arg_270_1.typewritter.percent = 0

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(false)
				arg_270_1:RecordContent(arg_270_1.text_.text)
			end

			local var_273_37 = var_273_29 + 0.3
			local var_273_38 = math.max(var_273_30, arg_270_1.talkMaxDuration)

			if var_273_37 <= arg_270_1.time_ and arg_270_1.time_ < var_273_37 + var_273_38 then
				arg_270_1.typewritter.percent = (arg_270_1.time_ - var_273_37) / var_273_38

				arg_270_1.typewritter:SetDirty()
			end

			if arg_270_1.time_ >= var_273_37 + var_273_38 and arg_270_1.time_ < var_273_37 + var_273_38 + arg_273_0 then
				arg_270_1.typewritter.percent = 1

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(true)
			end
		end

		arg_270_1.nodeConfigList_ = {}

		arg_270_1:InitPlayNodeList()
	end,
	Play121521067 = function(arg_276_0, arg_276_1)
		arg_276_1.time_ = 0
		arg_276_1.frameCnt_ = 0
		arg_276_1.state_ = "playing"
		arg_276_1.curTalkId_ = 121521067
		arg_276_1.duration_ = 5

		SetActive(arg_276_1.tipsGo_, false)

		function arg_276_1.onSingleLineFinish_()
			arg_276_1.onSingleLineUpdate_ = nil
			arg_276_1.onSingleLineFinish_ = nil
			arg_276_1.state_ = "waiting"
		end

		function arg_276_1.playNext_(arg_278_0)
			if arg_278_0 == 1 then
				arg_276_0:Play121521068(arg_276_1)
			end
		end

		function arg_276_1.onSingleLineUpdate_(arg_279_0)
			local var_279_0 = 0
			local var_279_1 = 1.175

			if var_279_0 < arg_276_1.time_ and arg_276_1.time_ <= var_279_0 + arg_279_0 then
				arg_276_1.talkMaxDuration = 0
				arg_276_1.dialogCg_.alpha = 1

				arg_276_1.dialog_:SetActive(true)
				SetActive(arg_276_1.leftNameGo_, false)

				arg_276_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_276_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_276_1:RecordName(arg_276_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_276_1.iconTrs_.gameObject, false)
				arg_276_1.callingController_:SetSelectedState("normal")

				local var_279_2 = arg_276_1:GetWordFromCfg(121521067)
				local var_279_3 = arg_276_1:FormatText(var_279_2.content)

				arg_276_1.text_.text = var_279_3

				LuaForUtil.ClearLinePrefixSymbol(arg_276_1.text_)

				local var_279_4 = 47
				local var_279_5 = utf8.len(var_279_3)
				local var_279_6 = var_279_4 <= 0 and var_279_1 or var_279_1 * (var_279_5 / var_279_4)

				if var_279_6 > 0 and var_279_1 < var_279_6 then
					arg_276_1.talkMaxDuration = var_279_6

					if var_279_6 + var_279_0 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_6 + var_279_0
					end
				end

				arg_276_1.text_.text = var_279_3
				arg_276_1.typewritter.percent = 0

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(false)
				arg_276_1:RecordContent(arg_276_1.text_.text)
			end

			local var_279_7 = math.max(var_279_1, arg_276_1.talkMaxDuration)

			if var_279_0 <= arg_276_1.time_ and arg_276_1.time_ < var_279_0 + var_279_7 then
				arg_276_1.typewritter.percent = (arg_276_1.time_ - var_279_0) / var_279_7

				arg_276_1.typewritter:SetDirty()
			end

			if arg_276_1.time_ >= var_279_0 + var_279_7 and arg_276_1.time_ < var_279_0 + var_279_7 + arg_279_0 then
				arg_276_1.typewritter.percent = 1

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(true)
			end
		end

		arg_276_1.nodeConfigList_ = {}

		arg_276_1:InitPlayNodeList()
	end,
	Play121521068 = function(arg_280_0, arg_280_1)
		arg_280_1.time_ = 0
		arg_280_1.frameCnt_ = 0
		arg_280_1.state_ = "playing"
		arg_280_1.curTalkId_ = 121521068
		arg_280_1.duration_ = 5

		SetActive(arg_280_1.tipsGo_, false)

		function arg_280_1.onSingleLineFinish_()
			arg_280_1.onSingleLineUpdate_ = nil
			arg_280_1.onSingleLineFinish_ = nil
			arg_280_1.state_ = "waiting"
		end

		function arg_280_1.playNext_(arg_282_0)
			if arg_282_0 == 1 then
				arg_280_0:Play121521069(arg_280_1)
			end
		end

		function arg_280_1.onSingleLineUpdate_(arg_283_0)
			local var_283_0 = 0
			local var_283_1 = 0.95

			if var_283_0 < arg_280_1.time_ and arg_280_1.time_ <= var_283_0 + arg_283_0 then
				arg_280_1.talkMaxDuration = 0
				arg_280_1.dialogCg_.alpha = 1

				arg_280_1.dialog_:SetActive(true)
				SetActive(arg_280_1.leftNameGo_, false)

				arg_280_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_280_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_280_1:RecordName(arg_280_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_280_1.iconTrs_.gameObject, false)
				arg_280_1.callingController_:SetSelectedState("normal")

				local var_283_2 = arg_280_1:GetWordFromCfg(121521068)
				local var_283_3 = arg_280_1:FormatText(var_283_2.content)

				arg_280_1.text_.text = var_283_3

				LuaForUtil.ClearLinePrefixSymbol(arg_280_1.text_)

				local var_283_4 = 38
				local var_283_5 = utf8.len(var_283_3)
				local var_283_6 = var_283_4 <= 0 and var_283_1 or var_283_1 * (var_283_5 / var_283_4)

				if var_283_6 > 0 and var_283_1 < var_283_6 then
					arg_280_1.talkMaxDuration = var_283_6

					if var_283_6 + var_283_0 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_6 + var_283_0
					end
				end

				arg_280_1.text_.text = var_283_3
				arg_280_1.typewritter.percent = 0

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(false)
				arg_280_1:RecordContent(arg_280_1.text_.text)
			end

			local var_283_7 = math.max(var_283_1, arg_280_1.talkMaxDuration)

			if var_283_0 <= arg_280_1.time_ and arg_280_1.time_ < var_283_0 + var_283_7 then
				arg_280_1.typewritter.percent = (arg_280_1.time_ - var_283_0) / var_283_7

				arg_280_1.typewritter:SetDirty()
			end

			if arg_280_1.time_ >= var_283_0 + var_283_7 and arg_280_1.time_ < var_283_0 + var_283_7 + arg_283_0 then
				arg_280_1.typewritter.percent = 1

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(true)
			end
		end

		arg_280_1.nodeConfigList_ = {}

		arg_280_1:InitPlayNodeList()
	end,
	Play121521069 = function(arg_284_0, arg_284_1)
		arg_284_1.time_ = 0
		arg_284_1.frameCnt_ = 0
		arg_284_1.state_ = "playing"
		arg_284_1.curTalkId_ = 121521069
		arg_284_1.duration_ = 5.5

		local var_284_0 = {
			ja = 5.5,
			ko = 2.466666666666,
			zh = 2.466666666666
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
				arg_284_0:Play121521070(arg_284_1)
			end
		end

		function arg_284_1.onSingleLineUpdate_(arg_287_0)
			local var_287_0 = arg_284_1.actors_["1084ui_story"].transform
			local var_287_1 = 0

			if var_287_1 < arg_284_1.time_ and arg_284_1.time_ <= var_287_1 + arg_287_0 then
				arg_284_1.var_.moveOldPos1084ui_story = var_287_0.localPosition
			end

			local var_287_2 = 0.001

			if var_287_1 <= arg_284_1.time_ and arg_284_1.time_ < var_287_1 + var_287_2 then
				local var_287_3 = (arg_284_1.time_ - var_287_1) / var_287_2
				local var_287_4 = Vector3.New(-0.7, -0.97, -6)

				var_287_0.localPosition = Vector3.Lerp(arg_284_1.var_.moveOldPos1084ui_story, var_287_4, var_287_3)

				local var_287_5 = manager.ui.mainCamera.transform.position - var_287_0.position

				var_287_0.forward = Vector3.New(var_287_5.x, var_287_5.y, var_287_5.z)

				local var_287_6 = var_287_0.localEulerAngles

				var_287_6.z = 0
				var_287_6.x = 0
				var_287_0.localEulerAngles = var_287_6
			end

			if arg_284_1.time_ >= var_287_1 + var_287_2 and arg_284_1.time_ < var_287_1 + var_287_2 + arg_287_0 then
				var_287_0.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_287_7 = manager.ui.mainCamera.transform.position - var_287_0.position

				var_287_0.forward = Vector3.New(var_287_7.x, var_287_7.y, var_287_7.z)

				local var_287_8 = var_287_0.localEulerAngles

				var_287_8.z = 0
				var_287_8.x = 0
				var_287_0.localEulerAngles = var_287_8
			end

			local var_287_9 = arg_284_1.actors_["1084ui_story"]
			local var_287_10 = 0

			if var_287_10 < arg_284_1.time_ and arg_284_1.time_ <= var_287_10 + arg_287_0 and not isNil(var_287_9) and arg_284_1.var_.characterEffect1084ui_story == nil then
				arg_284_1.var_.characterEffect1084ui_story = var_287_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_287_11 = 0.200000002980232

			if var_287_10 <= arg_284_1.time_ and arg_284_1.time_ < var_287_10 + var_287_11 and not isNil(var_287_9) then
				local var_287_12 = (arg_284_1.time_ - var_287_10) / var_287_11

				if arg_284_1.var_.characterEffect1084ui_story and not isNil(var_287_9) then
					arg_284_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_284_1.time_ >= var_287_10 + var_287_11 and arg_284_1.time_ < var_287_10 + var_287_11 + arg_287_0 and not isNil(var_287_9) and arg_284_1.var_.characterEffect1084ui_story then
				arg_284_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_287_13 = 0

			if var_287_13 < arg_284_1.time_ and arg_284_1.time_ <= var_287_13 + arg_287_0 then
				arg_284_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			local var_287_14 = 0

			if var_287_14 < arg_284_1.time_ and arg_284_1.time_ <= var_287_14 + arg_287_0 then
				arg_284_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_287_15 = arg_284_1.actors_["1075ui_story"].transform
			local var_287_16 = 0

			if var_287_16 < arg_284_1.time_ and arg_284_1.time_ <= var_287_16 + arg_287_0 then
				arg_284_1.var_.moveOldPos1075ui_story = var_287_15.localPosition
			end

			local var_287_17 = 0.001

			if var_287_16 <= arg_284_1.time_ and arg_284_1.time_ < var_287_16 + var_287_17 then
				local var_287_18 = (arg_284_1.time_ - var_287_16) / var_287_17
				local var_287_19 = Vector3.New(0.7, -1.055, -6.16)

				var_287_15.localPosition = Vector3.Lerp(arg_284_1.var_.moveOldPos1075ui_story, var_287_19, var_287_18)

				local var_287_20 = manager.ui.mainCamera.transform.position - var_287_15.position

				var_287_15.forward = Vector3.New(var_287_20.x, var_287_20.y, var_287_20.z)

				local var_287_21 = var_287_15.localEulerAngles

				var_287_21.z = 0
				var_287_21.x = 0
				var_287_15.localEulerAngles = var_287_21
			end

			if arg_284_1.time_ >= var_287_16 + var_287_17 and arg_284_1.time_ < var_287_16 + var_287_17 + arg_287_0 then
				var_287_15.localPosition = Vector3.New(0.7, -1.055, -6.16)

				local var_287_22 = manager.ui.mainCamera.transform.position - var_287_15.position

				var_287_15.forward = Vector3.New(var_287_22.x, var_287_22.y, var_287_22.z)

				local var_287_23 = var_287_15.localEulerAngles

				var_287_23.z = 0
				var_287_23.x = 0
				var_287_15.localEulerAngles = var_287_23
			end

			local var_287_24 = arg_284_1.actors_["1075ui_story"]
			local var_287_25 = 0

			if var_287_25 < arg_284_1.time_ and arg_284_1.time_ <= var_287_25 + arg_287_0 and not isNil(var_287_24) and arg_284_1.var_.characterEffect1075ui_story == nil then
				arg_284_1.var_.characterEffect1075ui_story = var_287_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_287_26 = 0.200000002980232

			if var_287_25 <= arg_284_1.time_ and arg_284_1.time_ < var_287_25 + var_287_26 and not isNil(var_287_24) then
				local var_287_27 = (arg_284_1.time_ - var_287_25) / var_287_26

				if arg_284_1.var_.characterEffect1075ui_story and not isNil(var_287_24) then
					local var_287_28 = Mathf.Lerp(0, 0.5, var_287_27)

					arg_284_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_284_1.var_.characterEffect1075ui_story.fillRatio = var_287_28
				end
			end

			if arg_284_1.time_ >= var_287_25 + var_287_26 and arg_284_1.time_ < var_287_25 + var_287_26 + arg_287_0 and not isNil(var_287_24) and arg_284_1.var_.characterEffect1075ui_story then
				local var_287_29 = 0.5

				arg_284_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_284_1.var_.characterEffect1075ui_story.fillRatio = var_287_29
			end

			local var_287_30 = 0
			local var_287_31 = 0.15

			if var_287_30 < arg_284_1.time_ and arg_284_1.time_ <= var_287_30 + arg_287_0 then
				arg_284_1.talkMaxDuration = 0
				arg_284_1.dialogCg_.alpha = 1

				arg_284_1.dialog_:SetActive(true)
				SetActive(arg_284_1.leftNameGo_, true)

				local var_287_32 = arg_284_1:FormatText(StoryNameCfg[6].name)

				arg_284_1.leftNameTxt_.text = var_287_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_284_1.leftNameTxt_.transform)

				arg_284_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_284_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_284_1:RecordName(arg_284_1.leftNameTxt_.text)
				SetActive(arg_284_1.iconTrs_.gameObject, false)
				arg_284_1.callingController_:SetSelectedState("normal")

				local var_287_33 = arg_284_1:GetWordFromCfg(121521069)
				local var_287_34 = arg_284_1:FormatText(var_287_33.content)

				arg_284_1.text_.text = var_287_34

				LuaForUtil.ClearLinePrefixSymbol(arg_284_1.text_)

				local var_287_35 = 6
				local var_287_36 = utf8.len(var_287_34)
				local var_287_37 = var_287_35 <= 0 and var_287_31 or var_287_31 * (var_287_36 / var_287_35)

				if var_287_37 > 0 and var_287_31 < var_287_37 then
					arg_284_1.talkMaxDuration = var_287_37

					if var_287_37 + var_287_30 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_37 + var_287_30
					end
				end

				arg_284_1.text_.text = var_287_34
				arg_284_1.typewritter.percent = 0

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121521", "121521069", "story_v_out_121521.awb") ~= 0 then
					local var_287_38 = manager.audio:GetVoiceLength("story_v_out_121521", "121521069", "story_v_out_121521.awb") / 1000

					if var_287_38 + var_287_30 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_38 + var_287_30
					end

					if var_287_33.prefab_name ~= "" and arg_284_1.actors_[var_287_33.prefab_name] ~= nil then
						local var_287_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_284_1.actors_[var_287_33.prefab_name].transform, "story_v_out_121521", "121521069", "story_v_out_121521.awb")

						arg_284_1:RecordAudio("121521069", var_287_39)
						arg_284_1:RecordAudio("121521069", var_287_39)
					else
						arg_284_1:AudioAction("play", "voice", "story_v_out_121521", "121521069", "story_v_out_121521.awb")
					end

					arg_284_1:RecordHistoryTalkVoice("story_v_out_121521", "121521069", "story_v_out_121521.awb")
				end

				arg_284_1:RecordContent(arg_284_1.text_.text)
			end

			local var_287_40 = math.max(var_287_31, arg_284_1.talkMaxDuration)

			if var_287_30 <= arg_284_1.time_ and arg_284_1.time_ < var_287_30 + var_287_40 then
				arg_284_1.typewritter.percent = (arg_284_1.time_ - var_287_30) / var_287_40

				arg_284_1.typewritter:SetDirty()
			end

			if arg_284_1.time_ >= var_287_30 + var_287_40 and arg_284_1.time_ < var_287_30 + var_287_40 + arg_287_0 then
				arg_284_1.typewritter.percent = 1

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(true)
			end
		end

		arg_284_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1075ui_story",
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
	Play121521070 = function(arg_288_0, arg_288_1)
		arg_288_1.time_ = 0
		arg_288_1.frameCnt_ = 0
		arg_288_1.state_ = "playing"
		arg_288_1.curTalkId_ = 121521070
		arg_288_1.duration_ = 5

		SetActive(arg_288_1.tipsGo_, false)

		function arg_288_1.onSingleLineFinish_()
			arg_288_1.onSingleLineUpdate_ = nil
			arg_288_1.onSingleLineFinish_ = nil
			arg_288_1.state_ = "waiting"
		end

		function arg_288_1.playNext_(arg_290_0)
			if arg_290_0 == 1 then
				arg_288_0:Play121521071(arg_288_1)
			end
		end

		function arg_288_1.onSingleLineUpdate_(arg_291_0)
			local var_291_0 = arg_288_1.actors_["1084ui_story"]
			local var_291_1 = 0

			if var_291_1 < arg_288_1.time_ and arg_288_1.time_ <= var_291_1 + arg_291_0 and not isNil(var_291_0) and arg_288_1.var_.characterEffect1084ui_story == nil then
				arg_288_1.var_.characterEffect1084ui_story = var_291_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_291_2 = 0.200000002980232

			if var_291_1 <= arg_288_1.time_ and arg_288_1.time_ < var_291_1 + var_291_2 and not isNil(var_291_0) then
				local var_291_3 = (arg_288_1.time_ - var_291_1) / var_291_2

				if arg_288_1.var_.characterEffect1084ui_story and not isNil(var_291_0) then
					local var_291_4 = Mathf.Lerp(0, 0.5, var_291_3)

					arg_288_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_288_1.var_.characterEffect1084ui_story.fillRatio = var_291_4
				end
			end

			if arg_288_1.time_ >= var_291_1 + var_291_2 and arg_288_1.time_ < var_291_1 + var_291_2 + arg_291_0 and not isNil(var_291_0) and arg_288_1.var_.characterEffect1084ui_story then
				local var_291_5 = 0.5

				arg_288_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_288_1.var_.characterEffect1084ui_story.fillRatio = var_291_5
			end

			local var_291_6 = 0
			local var_291_7 = 0.633333333333333

			if var_291_6 < arg_288_1.time_ and arg_288_1.time_ <= var_291_6 + arg_291_0 then
				local var_291_8 = "stop"
				local var_291_9 = "effect"

				arg_288_1:AudioAction(var_291_8, var_291_9, "se_story_121_04", "se_story_121_04_crowd_loop", "")
			end

			local var_291_10 = 0
			local var_291_11 = 0.375

			if var_291_10 < arg_288_1.time_ and arg_288_1.time_ <= var_291_10 + arg_291_0 then
				arg_288_1.talkMaxDuration = 0
				arg_288_1.dialogCg_.alpha = 1

				arg_288_1.dialog_:SetActive(true)
				SetActive(arg_288_1.leftNameGo_, true)

				local var_291_12 = arg_288_1:FormatText(StoryNameCfg[7].name)

				arg_288_1.leftNameTxt_.text = var_291_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_288_1.leftNameTxt_.transform)

				arg_288_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_288_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_288_1:RecordName(arg_288_1.leftNameTxt_.text)
				SetActive(arg_288_1.iconTrs_.gameObject, true)
				arg_288_1.iconController_:SetSelectedState("hero")

				arg_288_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_288_1.callingController_:SetSelectedState("normal")

				arg_288_1.keyicon_.color = Color.New(1, 1, 1)
				arg_288_1.icon_.color = Color.New(1, 1, 1)

				local var_291_13 = arg_288_1:GetWordFromCfg(121521070)
				local var_291_14 = arg_288_1:FormatText(var_291_13.content)

				arg_288_1.text_.text = var_291_14

				LuaForUtil.ClearLinePrefixSymbol(arg_288_1.text_)

				local var_291_15 = 15
				local var_291_16 = utf8.len(var_291_14)
				local var_291_17 = var_291_15 <= 0 and var_291_11 or var_291_11 * (var_291_16 / var_291_15)

				if var_291_17 > 0 and var_291_11 < var_291_17 then
					arg_288_1.talkMaxDuration = var_291_17

					if var_291_17 + var_291_10 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_17 + var_291_10
					end
				end

				arg_288_1.text_.text = var_291_14
				arg_288_1.typewritter.percent = 0

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(false)
				arg_288_1:RecordContent(arg_288_1.text_.text)
			end

			local var_291_18 = math.max(var_291_11, arg_288_1.talkMaxDuration)

			if var_291_10 <= arg_288_1.time_ and arg_288_1.time_ < var_291_10 + var_291_18 then
				arg_288_1.typewritter.percent = (arg_288_1.time_ - var_291_10) / var_291_18

				arg_288_1.typewritter:SetDirty()
			end

			if arg_288_1.time_ >= var_291_10 + var_291_18 and arg_288_1.time_ < var_291_10 + var_291_18 + arg_291_0 then
				arg_288_1.typewritter.percent = 1

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(true)
			end
		end

		arg_288_1.nodeConfigList_ = {}

		arg_288_1:InitPlayNodeList()
	end,
	Play121521071 = function(arg_292_0, arg_292_1)
		arg_292_1.time_ = 0
		arg_292_1.frameCnt_ = 0
		arg_292_1.state_ = "playing"
		arg_292_1.curTalkId_ = 121521071
		arg_292_1.duration_ = 5

		SetActive(arg_292_1.tipsGo_, false)

		function arg_292_1.onSingleLineFinish_()
			arg_292_1.onSingleLineUpdate_ = nil
			arg_292_1.onSingleLineFinish_ = nil
			arg_292_1.state_ = "waiting"
		end

		function arg_292_1.playNext_(arg_294_0)
			if arg_294_0 == 1 then
				arg_292_0:Play121521072(arg_292_1)
			end
		end

		function arg_292_1.onSingleLineUpdate_(arg_295_0)
			local var_295_0 = 0
			local var_295_1 = 0.425

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

				local var_295_3 = arg_292_1:GetWordFromCfg(121521071)
				local var_295_4 = arg_292_1:FormatText(var_295_3.content)

				arg_292_1.text_.text = var_295_4

				LuaForUtil.ClearLinePrefixSymbol(arg_292_1.text_)

				local var_295_5 = 17
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
	Play121521072 = function(arg_296_0, arg_296_1)
		arg_296_1.time_ = 0
		arg_296_1.frameCnt_ = 0
		arg_296_1.state_ = "playing"
		arg_296_1.curTalkId_ = 121521072
		arg_296_1.duration_ = 11.6

		local var_296_0 = {
			ja = 8.866,
			ko = 11.6,
			zh = 11.6
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
				arg_296_0:Play121521073(arg_296_1)
			end
		end

		function arg_296_1.onSingleLineUpdate_(arg_299_0)
			local var_299_0 = arg_296_1.actors_["1075ui_story"]
			local var_299_1 = 0

			if var_299_1 < arg_296_1.time_ and arg_296_1.time_ <= var_299_1 + arg_299_0 and not isNil(var_299_0) and arg_296_1.var_.characterEffect1075ui_story == nil then
				arg_296_1.var_.characterEffect1075ui_story = var_299_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_299_2 = 0.200000002980232

			if var_299_1 <= arg_296_1.time_ and arg_296_1.time_ < var_299_1 + var_299_2 and not isNil(var_299_0) then
				local var_299_3 = (arg_296_1.time_ - var_299_1) / var_299_2

				if arg_296_1.var_.characterEffect1075ui_story and not isNil(var_299_0) then
					arg_296_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_296_1.time_ >= var_299_1 + var_299_2 and arg_296_1.time_ < var_299_1 + var_299_2 + arg_299_0 and not isNil(var_299_0) and arg_296_1.var_.characterEffect1075ui_story then
				arg_296_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_299_4 = 0

			if var_299_4 < arg_296_1.time_ and arg_296_1.time_ <= var_299_4 + arg_299_0 then
				arg_296_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action5_1")
			end

			local var_299_5 = 0

			if var_299_5 < arg_296_1.time_ and arg_296_1.time_ <= var_299_5 + arg_299_0 then
				arg_296_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_299_6 = 0
			local var_299_7 = 1.4

			if var_299_6 < arg_296_1.time_ and arg_296_1.time_ <= var_299_6 + arg_299_0 then
				arg_296_1.talkMaxDuration = 0
				arg_296_1.dialogCg_.alpha = 1

				arg_296_1.dialog_:SetActive(true)
				SetActive(arg_296_1.leftNameGo_, true)

				local var_299_8 = arg_296_1:FormatText(StoryNameCfg[381].name)

				arg_296_1.leftNameTxt_.text = var_299_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_296_1.leftNameTxt_.transform)

				arg_296_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_296_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_296_1:RecordName(arg_296_1.leftNameTxt_.text)
				SetActive(arg_296_1.iconTrs_.gameObject, false)
				arg_296_1.callingController_:SetSelectedState("normal")

				local var_299_9 = arg_296_1:GetWordFromCfg(121521072)
				local var_299_10 = arg_296_1:FormatText(var_299_9.content)

				arg_296_1.text_.text = var_299_10

				LuaForUtil.ClearLinePrefixSymbol(arg_296_1.text_)

				local var_299_11 = 56
				local var_299_12 = utf8.len(var_299_10)
				local var_299_13 = var_299_11 <= 0 and var_299_7 or var_299_7 * (var_299_12 / var_299_11)

				if var_299_13 > 0 and var_299_7 < var_299_13 then
					arg_296_1.talkMaxDuration = var_299_13

					if var_299_13 + var_299_6 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_13 + var_299_6
					end
				end

				arg_296_1.text_.text = var_299_10
				arg_296_1.typewritter.percent = 0

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121521", "121521072", "story_v_out_121521.awb") ~= 0 then
					local var_299_14 = manager.audio:GetVoiceLength("story_v_out_121521", "121521072", "story_v_out_121521.awb") / 1000

					if var_299_14 + var_299_6 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_14 + var_299_6
					end

					if var_299_9.prefab_name ~= "" and arg_296_1.actors_[var_299_9.prefab_name] ~= nil then
						local var_299_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_296_1.actors_[var_299_9.prefab_name].transform, "story_v_out_121521", "121521072", "story_v_out_121521.awb")

						arg_296_1:RecordAudio("121521072", var_299_15)
						arg_296_1:RecordAudio("121521072", var_299_15)
					else
						arg_296_1:AudioAction("play", "voice", "story_v_out_121521", "121521072", "story_v_out_121521.awb")
					end

					arg_296_1:RecordHistoryTalkVoice("story_v_out_121521", "121521072", "story_v_out_121521.awb")
				end

				arg_296_1:RecordContent(arg_296_1.text_.text)
			end

			local var_299_16 = math.max(var_299_7, arg_296_1.talkMaxDuration)

			if var_299_6 <= arg_296_1.time_ and arg_296_1.time_ < var_299_6 + var_299_16 then
				arg_296_1.typewritter.percent = (arg_296_1.time_ - var_299_6) / var_299_16

				arg_296_1.typewritter:SetDirty()
			end

			if arg_296_1.time_ >= var_299_6 + var_299_16 and arg_296_1.time_ < var_299_6 + var_299_16 + arg_299_0 then
				arg_296_1.typewritter.percent = 1

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(true)
			end
		end

		arg_296_1.nodeConfigList_ = {}

		arg_296_1:InitPlayNodeList()
	end,
	Play121521073 = function(arg_300_0, arg_300_1)
		arg_300_1.time_ = 0
		arg_300_1.frameCnt_ = 0
		arg_300_1.state_ = "playing"
		arg_300_1.curTalkId_ = 121521073
		arg_300_1.duration_ = 12.43

		local var_300_0 = {
			ja = 12.333,
			ko = 12.433,
			zh = 12.433
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
				arg_300_0:Play121521074(arg_300_1)
			end
		end

		function arg_300_1.onSingleLineUpdate_(arg_303_0)
			local var_303_0 = 0

			if var_303_0 < arg_300_1.time_ and arg_300_1.time_ <= var_303_0 + arg_303_0 then
				arg_300_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0203cva")
			end

			local var_303_1 = 0
			local var_303_2 = 1.225

			if var_303_1 < arg_300_1.time_ and arg_300_1.time_ <= var_303_1 + arg_303_0 then
				arg_300_1.talkMaxDuration = 0
				arg_300_1.dialogCg_.alpha = 1

				arg_300_1.dialog_:SetActive(true)
				SetActive(arg_300_1.leftNameGo_, true)

				local var_303_3 = arg_300_1:FormatText(StoryNameCfg[381].name)

				arg_300_1.leftNameTxt_.text = var_303_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_300_1.leftNameTxt_.transform)

				arg_300_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_300_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_300_1:RecordName(arg_300_1.leftNameTxt_.text)
				SetActive(arg_300_1.iconTrs_.gameObject, false)
				arg_300_1.callingController_:SetSelectedState("normal")

				local var_303_4 = arg_300_1:GetWordFromCfg(121521073)
				local var_303_5 = arg_300_1:FormatText(var_303_4.content)

				arg_300_1.text_.text = var_303_5

				LuaForUtil.ClearLinePrefixSymbol(arg_300_1.text_)

				local var_303_6 = 49
				local var_303_7 = utf8.len(var_303_5)
				local var_303_8 = var_303_6 <= 0 and var_303_2 or var_303_2 * (var_303_7 / var_303_6)

				if var_303_8 > 0 and var_303_2 < var_303_8 then
					arg_300_1.talkMaxDuration = var_303_8

					if var_303_8 + var_303_1 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_8 + var_303_1
					end
				end

				arg_300_1.text_.text = var_303_5
				arg_300_1.typewritter.percent = 0

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121521", "121521073", "story_v_out_121521.awb") ~= 0 then
					local var_303_9 = manager.audio:GetVoiceLength("story_v_out_121521", "121521073", "story_v_out_121521.awb") / 1000

					if var_303_9 + var_303_1 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_9 + var_303_1
					end

					if var_303_4.prefab_name ~= "" and arg_300_1.actors_[var_303_4.prefab_name] ~= nil then
						local var_303_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_300_1.actors_[var_303_4.prefab_name].transform, "story_v_out_121521", "121521073", "story_v_out_121521.awb")

						arg_300_1:RecordAudio("121521073", var_303_10)
						arg_300_1:RecordAudio("121521073", var_303_10)
					else
						arg_300_1:AudioAction("play", "voice", "story_v_out_121521", "121521073", "story_v_out_121521.awb")
					end

					arg_300_1:RecordHistoryTalkVoice("story_v_out_121521", "121521073", "story_v_out_121521.awb")
				end

				arg_300_1:RecordContent(arg_300_1.text_.text)
			end

			local var_303_11 = math.max(var_303_2, arg_300_1.talkMaxDuration)

			if var_303_1 <= arg_300_1.time_ and arg_300_1.time_ < var_303_1 + var_303_11 then
				arg_300_1.typewritter.percent = (arg_300_1.time_ - var_303_1) / var_303_11

				arg_300_1.typewritter:SetDirty()
			end

			if arg_300_1.time_ >= var_303_1 + var_303_11 and arg_300_1.time_ < var_303_1 + var_303_11 + arg_303_0 then
				arg_300_1.typewritter.percent = 1

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(true)
			end
		end

		arg_300_1.nodeConfigList_ = {}

		arg_300_1:InitPlayNodeList()
	end,
	Play121521074 = function(arg_304_0, arg_304_1)
		arg_304_1.time_ = 0
		arg_304_1.frameCnt_ = 0
		arg_304_1.state_ = "playing"
		arg_304_1.curTalkId_ = 121521074
		arg_304_1.duration_ = 5

		SetActive(arg_304_1.tipsGo_, false)

		function arg_304_1.onSingleLineFinish_()
			arg_304_1.onSingleLineUpdate_ = nil
			arg_304_1.onSingleLineFinish_ = nil
			arg_304_1.state_ = "waiting"
		end

		function arg_304_1.playNext_(arg_306_0)
			if arg_306_0 == 1 then
				arg_304_0:Play121521075(arg_304_1)
			end
		end

		function arg_304_1.onSingleLineUpdate_(arg_307_0)
			local var_307_0 = arg_304_1.actors_["1075ui_story"]
			local var_307_1 = 0

			if var_307_1 < arg_304_1.time_ and arg_304_1.time_ <= var_307_1 + arg_307_0 and not isNil(var_307_0) and arg_304_1.var_.characterEffect1075ui_story == nil then
				arg_304_1.var_.characterEffect1075ui_story = var_307_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_307_2 = 0.200000002980232

			if var_307_1 <= arg_304_1.time_ and arg_304_1.time_ < var_307_1 + var_307_2 and not isNil(var_307_0) then
				local var_307_3 = (arg_304_1.time_ - var_307_1) / var_307_2

				if arg_304_1.var_.characterEffect1075ui_story and not isNil(var_307_0) then
					local var_307_4 = Mathf.Lerp(0, 0.5, var_307_3)

					arg_304_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_304_1.var_.characterEffect1075ui_story.fillRatio = var_307_4
				end
			end

			if arg_304_1.time_ >= var_307_1 + var_307_2 and arg_304_1.time_ < var_307_1 + var_307_2 + arg_307_0 and not isNil(var_307_0) and arg_304_1.var_.characterEffect1075ui_story then
				local var_307_5 = 0.5

				arg_304_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_304_1.var_.characterEffect1075ui_story.fillRatio = var_307_5
			end

			local var_307_6 = 0
			local var_307_7 = 0.225

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

				local var_307_9 = arg_304_1:GetWordFromCfg(121521074)
				local var_307_10 = arg_304_1:FormatText(var_307_9.content)

				arg_304_1.text_.text = var_307_10

				LuaForUtil.ClearLinePrefixSymbol(arg_304_1.text_)

				local var_307_11 = 9
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
	Play121521075 = function(arg_308_0, arg_308_1)
		arg_308_1.time_ = 0
		arg_308_1.frameCnt_ = 0
		arg_308_1.state_ = "playing"
		arg_308_1.curTalkId_ = 121521075
		arg_308_1.duration_ = 5

		SetActive(arg_308_1.tipsGo_, false)

		function arg_308_1.onSingleLineFinish_()
			arg_308_1.onSingleLineUpdate_ = nil
			arg_308_1.onSingleLineFinish_ = nil
			arg_308_1.state_ = "waiting"
		end

		function arg_308_1.playNext_(arg_310_0)
			if arg_310_0 == 1 then
				arg_308_0:Play121521076(arg_308_1)
			end
		end

		function arg_308_1.onSingleLineUpdate_(arg_311_0)
			local var_311_0 = arg_308_1.actors_["1075ui_story"].transform
			local var_311_1 = 0

			if var_311_1 < arg_308_1.time_ and arg_308_1.time_ <= var_311_1 + arg_311_0 then
				arg_308_1.var_.moveOldPos1075ui_story = var_311_0.localPosition
			end

			local var_311_2 = 0.001

			if var_311_1 <= arg_308_1.time_ and arg_308_1.time_ < var_311_1 + var_311_2 then
				local var_311_3 = (arg_308_1.time_ - var_311_1) / var_311_2
				local var_311_4 = Vector3.New(0, 100, 0)

				var_311_0.localPosition = Vector3.Lerp(arg_308_1.var_.moveOldPos1075ui_story, var_311_4, var_311_3)

				local var_311_5 = manager.ui.mainCamera.transform.position - var_311_0.position

				var_311_0.forward = Vector3.New(var_311_5.x, var_311_5.y, var_311_5.z)

				local var_311_6 = var_311_0.localEulerAngles

				var_311_6.z = 0
				var_311_6.x = 0
				var_311_0.localEulerAngles = var_311_6
			end

			if arg_308_1.time_ >= var_311_1 + var_311_2 and arg_308_1.time_ < var_311_1 + var_311_2 + arg_311_0 then
				var_311_0.localPosition = Vector3.New(0, 100, 0)

				local var_311_7 = manager.ui.mainCamera.transform.position - var_311_0.position

				var_311_0.forward = Vector3.New(var_311_7.x, var_311_7.y, var_311_7.z)

				local var_311_8 = var_311_0.localEulerAngles

				var_311_8.z = 0
				var_311_8.x = 0
				var_311_0.localEulerAngles = var_311_8
			end

			local var_311_9 = arg_308_1.actors_["1075ui_story"]
			local var_311_10 = 0

			if var_311_10 < arg_308_1.time_ and arg_308_1.time_ <= var_311_10 + arg_311_0 and not isNil(var_311_9) and arg_308_1.var_.characterEffect1075ui_story == nil then
				arg_308_1.var_.characterEffect1075ui_story = var_311_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_311_11 = 0.200000002980232

			if var_311_10 <= arg_308_1.time_ and arg_308_1.time_ < var_311_10 + var_311_11 and not isNil(var_311_9) then
				local var_311_12 = (arg_308_1.time_ - var_311_10) / var_311_11

				if arg_308_1.var_.characterEffect1075ui_story and not isNil(var_311_9) then
					local var_311_13 = Mathf.Lerp(0, 0.5, var_311_12)

					arg_308_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_308_1.var_.characterEffect1075ui_story.fillRatio = var_311_13
				end
			end

			if arg_308_1.time_ >= var_311_10 + var_311_11 and arg_308_1.time_ < var_311_10 + var_311_11 + arg_311_0 and not isNil(var_311_9) and arg_308_1.var_.characterEffect1075ui_story then
				local var_311_14 = 0.5

				arg_308_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_308_1.var_.characterEffect1075ui_story.fillRatio = var_311_14
			end

			local var_311_15 = arg_308_1.actors_["1084ui_story"].transform
			local var_311_16 = 0

			if var_311_16 < arg_308_1.time_ and arg_308_1.time_ <= var_311_16 + arg_311_0 then
				arg_308_1.var_.moveOldPos1084ui_story = var_311_15.localPosition
			end

			local var_311_17 = 0.001

			if var_311_16 <= arg_308_1.time_ and arg_308_1.time_ < var_311_16 + var_311_17 then
				local var_311_18 = (arg_308_1.time_ - var_311_16) / var_311_17
				local var_311_19 = Vector3.New(0, 100, 0)

				var_311_15.localPosition = Vector3.Lerp(arg_308_1.var_.moveOldPos1084ui_story, var_311_19, var_311_18)

				local var_311_20 = manager.ui.mainCamera.transform.position - var_311_15.position

				var_311_15.forward = Vector3.New(var_311_20.x, var_311_20.y, var_311_20.z)

				local var_311_21 = var_311_15.localEulerAngles

				var_311_21.z = 0
				var_311_21.x = 0
				var_311_15.localEulerAngles = var_311_21
			end

			if arg_308_1.time_ >= var_311_16 + var_311_17 and arg_308_1.time_ < var_311_16 + var_311_17 + arg_311_0 then
				var_311_15.localPosition = Vector3.New(0, 100, 0)

				local var_311_22 = manager.ui.mainCamera.transform.position - var_311_15.position

				var_311_15.forward = Vector3.New(var_311_22.x, var_311_22.y, var_311_22.z)

				local var_311_23 = var_311_15.localEulerAngles

				var_311_23.z = 0
				var_311_23.x = 0
				var_311_15.localEulerAngles = var_311_23
			end

			local var_311_24 = arg_308_1.actors_["1084ui_story"]
			local var_311_25 = 0

			if var_311_25 < arg_308_1.time_ and arg_308_1.time_ <= var_311_25 + arg_311_0 and not isNil(var_311_24) and arg_308_1.var_.characterEffect1084ui_story == nil then
				arg_308_1.var_.characterEffect1084ui_story = var_311_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_311_26 = 0.200000002980232

			if var_311_25 <= arg_308_1.time_ and arg_308_1.time_ < var_311_25 + var_311_26 and not isNil(var_311_24) then
				local var_311_27 = (arg_308_1.time_ - var_311_25) / var_311_26

				if arg_308_1.var_.characterEffect1084ui_story and not isNil(var_311_24) then
					local var_311_28 = Mathf.Lerp(0, 0.5, var_311_27)

					arg_308_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_308_1.var_.characterEffect1084ui_story.fillRatio = var_311_28
				end
			end

			if arg_308_1.time_ >= var_311_25 + var_311_26 and arg_308_1.time_ < var_311_25 + var_311_26 + arg_311_0 and not isNil(var_311_24) and arg_308_1.var_.characterEffect1084ui_story then
				local var_311_29 = 0.5

				arg_308_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_308_1.var_.characterEffect1084ui_story.fillRatio = var_311_29
			end

			local var_311_30 = 0
			local var_311_31 = 0.425

			if var_311_30 < arg_308_1.time_ and arg_308_1.time_ <= var_311_30 + arg_311_0 then
				arg_308_1.talkMaxDuration = 0
				arg_308_1.dialogCg_.alpha = 1

				arg_308_1.dialog_:SetActive(true)
				SetActive(arg_308_1.leftNameGo_, false)

				arg_308_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_308_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_308_1:RecordName(arg_308_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_308_1.iconTrs_.gameObject, false)
				arg_308_1.callingController_:SetSelectedState("normal")

				local var_311_32 = arg_308_1:GetWordFromCfg(121521075)
				local var_311_33 = arg_308_1:FormatText(var_311_32.content)

				arg_308_1.text_.text = var_311_33

				LuaForUtil.ClearLinePrefixSymbol(arg_308_1.text_)

				local var_311_34 = 17
				local var_311_35 = utf8.len(var_311_33)
				local var_311_36 = var_311_34 <= 0 and var_311_31 or var_311_31 * (var_311_35 / var_311_34)

				if var_311_36 > 0 and var_311_31 < var_311_36 then
					arg_308_1.talkMaxDuration = var_311_36

					if var_311_36 + var_311_30 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_36 + var_311_30
					end
				end

				arg_308_1.text_.text = var_311_33
				arg_308_1.typewritter.percent = 0

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(false)
				arg_308_1:RecordContent(arg_308_1.text_.text)
			end

			local var_311_37 = math.max(var_311_31, arg_308_1.talkMaxDuration)

			if var_311_30 <= arg_308_1.time_ and arg_308_1.time_ < var_311_30 + var_311_37 then
				arg_308_1.typewritter.percent = (arg_308_1.time_ - var_311_30) / var_311_37

				arg_308_1.typewritter:SetDirty()
			end

			if arg_308_1.time_ >= var_311_30 + var_311_37 and arg_308_1.time_ < var_311_30 + var_311_37 + arg_311_0 then
				arg_308_1.typewritter.percent = 1

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(true)
			end
		end

		arg_308_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
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
	Play121521076 = function(arg_312_0, arg_312_1)
		arg_312_1.time_ = 0
		arg_312_1.frameCnt_ = 0
		arg_312_1.state_ = "playing"
		arg_312_1.curTalkId_ = 121521076
		arg_312_1.duration_ = 5

		SetActive(arg_312_1.tipsGo_, false)

		function arg_312_1.onSingleLineFinish_()
			arg_312_1.onSingleLineUpdate_ = nil
			arg_312_1.onSingleLineFinish_ = nil
			arg_312_1.state_ = "waiting"
		end

		function arg_312_1.playNext_(arg_314_0)
			if arg_314_0 == 1 then
				arg_312_0:Play121521077(arg_312_1)
			end
		end

		function arg_312_1.onSingleLineUpdate_(arg_315_0)
			local var_315_0 = 0
			local var_315_1 = 1.425

			if var_315_0 < arg_312_1.time_ and arg_312_1.time_ <= var_315_0 + arg_315_0 then
				arg_312_1.talkMaxDuration = 0
				arg_312_1.dialogCg_.alpha = 1

				arg_312_1.dialog_:SetActive(true)
				SetActive(arg_312_1.leftNameGo_, false)

				arg_312_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_312_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_312_1:RecordName(arg_312_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_312_1.iconTrs_.gameObject, false)
				arg_312_1.callingController_:SetSelectedState("normal")

				local var_315_2 = arg_312_1:GetWordFromCfg(121521076)
				local var_315_3 = arg_312_1:FormatText(var_315_2.content)

				arg_312_1.text_.text = var_315_3

				LuaForUtil.ClearLinePrefixSymbol(arg_312_1.text_)

				local var_315_4 = 57
				local var_315_5 = utf8.len(var_315_3)
				local var_315_6 = var_315_4 <= 0 and var_315_1 or var_315_1 * (var_315_5 / var_315_4)

				if var_315_6 > 0 and var_315_1 < var_315_6 then
					arg_312_1.talkMaxDuration = var_315_6

					if var_315_6 + var_315_0 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_6 + var_315_0
					end
				end

				arg_312_1.text_.text = var_315_3
				arg_312_1.typewritter.percent = 0

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(false)
				arg_312_1:RecordContent(arg_312_1.text_.text)
			end

			local var_315_7 = math.max(var_315_1, arg_312_1.talkMaxDuration)

			if var_315_0 <= arg_312_1.time_ and arg_312_1.time_ < var_315_0 + var_315_7 then
				arg_312_1.typewritter.percent = (arg_312_1.time_ - var_315_0) / var_315_7

				arg_312_1.typewritter:SetDirty()
			end

			if arg_312_1.time_ >= var_315_0 + var_315_7 and arg_312_1.time_ < var_315_0 + var_315_7 + arg_315_0 then
				arg_312_1.typewritter.percent = 1

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(true)
			end
		end

		arg_312_1.nodeConfigList_ = {}

		arg_312_1:InitPlayNodeList()
	end,
	Play121521077 = function(arg_316_0, arg_316_1)
		arg_316_1.time_ = 0
		arg_316_1.frameCnt_ = 0
		arg_316_1.state_ = "playing"
		arg_316_1.curTalkId_ = 121521077
		arg_316_1.duration_ = 5

		SetActive(arg_316_1.tipsGo_, false)

		function arg_316_1.onSingleLineFinish_()
			arg_316_1.onSingleLineUpdate_ = nil
			arg_316_1.onSingleLineFinish_ = nil
			arg_316_1.state_ = "waiting"
		end

		function arg_316_1.playNext_(arg_318_0)
			if arg_318_0 == 1 then
				arg_316_0:Play121521078(arg_316_1)
			end
		end

		function arg_316_1.onSingleLineUpdate_(arg_319_0)
			local var_319_0 = 0
			local var_319_1 = 0.633333333333333

			if var_319_0 < arg_316_1.time_ and arg_316_1.time_ <= var_319_0 + arg_319_0 then
				local var_319_2 = "play"
				local var_319_3 = "effect"

				arg_316_1:AudioAction(var_319_2, var_319_3, "se_story_121_04", "se_story_121_04_cannonhit1", "")
			end

			local var_319_4 = 0
			local var_319_5 = 0.925

			if var_319_4 < arg_316_1.time_ and arg_316_1.time_ <= var_319_4 + arg_319_0 then
				arg_316_1.talkMaxDuration = 0
				arg_316_1.dialogCg_.alpha = 1

				arg_316_1.dialog_:SetActive(true)
				SetActive(arg_316_1.leftNameGo_, false)

				arg_316_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_316_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_316_1:RecordName(arg_316_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_316_1.iconTrs_.gameObject, false)
				arg_316_1.callingController_:SetSelectedState("normal")

				local var_319_6 = arg_316_1:GetWordFromCfg(121521077)
				local var_319_7 = arg_316_1:FormatText(var_319_6.content)

				arg_316_1.text_.text = var_319_7

				LuaForUtil.ClearLinePrefixSymbol(arg_316_1.text_)

				local var_319_8 = 37
				local var_319_9 = utf8.len(var_319_7)
				local var_319_10 = var_319_8 <= 0 and var_319_5 or var_319_5 * (var_319_9 / var_319_8)

				if var_319_10 > 0 and var_319_5 < var_319_10 then
					arg_316_1.talkMaxDuration = var_319_10

					if var_319_10 + var_319_4 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_10 + var_319_4
					end
				end

				arg_316_1.text_.text = var_319_7
				arg_316_1.typewritter.percent = 0

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(false)
				arg_316_1:RecordContent(arg_316_1.text_.text)
			end

			local var_319_11 = math.max(var_319_5, arg_316_1.talkMaxDuration)

			if var_319_4 <= arg_316_1.time_ and arg_316_1.time_ < var_319_4 + var_319_11 then
				arg_316_1.typewritter.percent = (arg_316_1.time_ - var_319_4) / var_319_11

				arg_316_1.typewritter:SetDirty()
			end

			if arg_316_1.time_ >= var_319_4 + var_319_11 and arg_316_1.time_ < var_319_4 + var_319_11 + arg_319_0 then
				arg_316_1.typewritter.percent = 1

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(true)
			end
		end

		arg_316_1.nodeConfigList_ = {}

		arg_316_1:InitPlayNodeList()
	end,
	Play121521078 = function(arg_320_0, arg_320_1)
		arg_320_1.time_ = 0
		arg_320_1.frameCnt_ = 0
		arg_320_1.state_ = "playing"
		arg_320_1.curTalkId_ = 121521078
		arg_320_1.duration_ = 7.67

		SetActive(arg_320_1.tipsGo_, false)

		function arg_320_1.onSingleLineFinish_()
			arg_320_1.onSingleLineUpdate_ = nil
			arg_320_1.onSingleLineFinish_ = nil
			arg_320_1.state_ = "waiting"
		end

		function arg_320_1.playNext_(arg_322_0)
			if arg_322_0 == 1 then
				arg_320_0:Play121521079(arg_320_1)
			end
		end

		function arg_320_1.onSingleLineUpdate_(arg_323_0)
			local var_323_0 = 0

			if var_323_0 < arg_320_1.time_ and arg_320_1.time_ <= var_323_0 + arg_323_0 then
				arg_320_1.mask_.enabled = true
				arg_320_1.mask_.raycastTarget = true

				arg_320_1:SetGaussion(false)
			end

			local var_323_1 = 1.5

			if var_323_0 <= arg_320_1.time_ and arg_320_1.time_ < var_323_0 + var_323_1 then
				local var_323_2 = (arg_320_1.time_ - var_323_0) / var_323_1
				local var_323_3 = Color.New(1, 1, 1)

				var_323_3.a = Mathf.Lerp(1, 0, var_323_2)
				arg_320_1.mask_.color = var_323_3
			end

			if arg_320_1.time_ >= var_323_0 + var_323_1 and arg_320_1.time_ < var_323_0 + var_323_1 + arg_323_0 then
				local var_323_4 = Color.New(1, 1, 1)
				local var_323_5 = 0

				arg_320_1.mask_.enabled = false
				var_323_4.a = var_323_5
				arg_320_1.mask_.color = var_323_4
			end

			local var_323_6 = 1.6682193024084

			if var_323_6 < arg_320_1.time_ and arg_320_1.time_ <= var_323_6 + arg_323_0 then
				arg_320_1.mask_.enabled = true
				arg_320_1.mask_.raycastTarget = true

				arg_320_1:SetGaussion(false)
			end

			local var_323_7 = 1

			if var_323_6 <= arg_320_1.time_ and arg_320_1.time_ < var_323_6 + var_323_7 then
				local var_323_8 = (arg_320_1.time_ - var_323_6) / var_323_7
				local var_323_9 = Color.New(1, 1, 1)

				var_323_9.a = Mathf.Lerp(1, 0, var_323_8)
				arg_320_1.mask_.color = var_323_9
			end

			if arg_320_1.time_ >= var_323_6 + var_323_7 and arg_320_1.time_ < var_323_6 + var_323_7 + arg_323_0 then
				local var_323_10 = Color.New(1, 1, 1)
				local var_323_11 = 0

				arg_320_1.mask_.enabled = false
				var_323_10.a = var_323_11
				arg_320_1.mask_.color = var_323_10
			end

			local var_323_12 = manager.ui.mainCamera.transform
			local var_323_13 = 0

			if var_323_13 < arg_320_1.time_ and arg_320_1.time_ <= var_323_13 + arg_323_0 then
				arg_320_1.var_.shakeOldPos = var_323_12.localPosition
			end

			local var_323_14 = 1.5

			if var_323_13 <= arg_320_1.time_ and arg_320_1.time_ < var_323_13 + var_323_14 then
				local var_323_15 = (arg_320_1.time_ - var_323_13) / 0.066
				local var_323_16, var_323_17 = math.modf(var_323_15)

				var_323_12.localPosition = Vector3.New(var_323_17 * 0.13, var_323_17 * 0.13, var_323_17 * 0.13) + arg_320_1.var_.shakeOldPos
			end

			if arg_320_1.time_ >= var_323_13 + var_323_14 and arg_320_1.time_ < var_323_13 + var_323_14 + arg_323_0 then
				var_323_12.localPosition = arg_320_1.var_.shakeOldPos
			end

			local var_323_18 = manager.ui.mainCamera.transform
			local var_323_19 = 1.66666666666667

			if var_323_19 < arg_320_1.time_ and arg_320_1.time_ <= var_323_19 + arg_323_0 then
				arg_320_1.var_.shakeOldPos = var_323_18.localPosition
			end

			local var_323_20 = 1.00155263574173

			if var_323_19 <= arg_320_1.time_ and arg_320_1.time_ < var_323_19 + var_323_20 then
				local var_323_21 = (arg_320_1.time_ - var_323_19) / 0.066
				local var_323_22, var_323_23 = math.modf(var_323_21)

				var_323_18.localPosition = Vector3.New(var_323_23 * 0.13, var_323_23 * 0.13, var_323_23 * 0.13) + arg_320_1.var_.shakeOldPos
			end

			if arg_320_1.time_ >= var_323_19 + var_323_20 and arg_320_1.time_ < var_323_19 + var_323_20 + arg_323_0 then
				var_323_18.localPosition = arg_320_1.var_.shakeOldPos
			end

			local var_323_24 = 0

			if var_323_24 < arg_320_1.time_ and arg_320_1.time_ <= var_323_24 + arg_323_0 then
				arg_320_1.allBtn_.enabled = false
			end

			local var_323_25 = 2.6682193024084

			if arg_320_1.time_ >= var_323_24 + var_323_25 and arg_320_1.time_ < var_323_24 + var_323_25 + arg_323_0 then
				arg_320_1.allBtn_.enabled = true
			end

			if arg_320_1.frameCnt_ <= 1 then
				arg_320_1.dialog_:SetActive(false)
			end

			local var_323_26 = 2.6682193024084
			local var_323_27 = 1.325

			if var_323_26 < arg_320_1.time_ and arg_320_1.time_ <= var_323_26 + arg_323_0 then
				arg_320_1.talkMaxDuration = 0

				arg_320_1.dialog_:SetActive(true)

				arg_320_1.dialogCg_.alpha = 0

				local var_323_28 = LeanTween.value(arg_320_1.dialog_, 0, 1, 0.3)

				var_323_28:setOnUpdate(LuaHelper.FloatAction(function(arg_324_0)
					arg_320_1.dialogCg_.alpha = arg_324_0
				end))
				var_323_28:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_320_1.dialog_)
					var_323_28:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_320_1.duration_ = arg_320_1.duration_ + 0.3

				SetActive(arg_320_1.leftNameGo_, false)

				arg_320_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_320_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_320_1:RecordName(arg_320_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_320_1.iconTrs_.gameObject, false)
				arg_320_1.callingController_:SetSelectedState("normal")

				local var_323_29 = arg_320_1:GetWordFromCfg(121521078)
				local var_323_30 = arg_320_1:FormatText(var_323_29.content)

				arg_320_1.text_.text = var_323_30

				LuaForUtil.ClearLinePrefixSymbol(arg_320_1.text_)

				local var_323_31 = 54
				local var_323_32 = utf8.len(var_323_30)
				local var_323_33 = var_323_31 <= 0 and var_323_27 or var_323_27 * (var_323_32 / var_323_31)

				if var_323_33 > 0 and var_323_27 < var_323_33 then
					arg_320_1.talkMaxDuration = var_323_33
					var_323_26 = var_323_26 + 0.3

					if var_323_33 + var_323_26 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_33 + var_323_26
					end
				end

				arg_320_1.text_.text = var_323_30
				arg_320_1.typewritter.percent = 0

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(false)
				arg_320_1:RecordContent(arg_320_1.text_.text)
			end

			local var_323_34 = var_323_26 + 0.3
			local var_323_35 = math.max(var_323_27, arg_320_1.talkMaxDuration)

			if var_323_34 <= arg_320_1.time_ and arg_320_1.time_ < var_323_34 + var_323_35 then
				arg_320_1.typewritter.percent = (arg_320_1.time_ - var_323_34) / var_323_35

				arg_320_1.typewritter:SetDirty()
			end

			if arg_320_1.time_ >= var_323_34 + var_323_35 and arg_320_1.time_ < var_323_34 + var_323_35 + arg_323_0 then
				arg_320_1.typewritter.percent = 1

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(true)
			end
		end

		arg_320_1.nodeConfigList_ = {}

		arg_320_1:InitPlayNodeList()
	end,
	Play121521079 = function(arg_326_0, arg_326_1)
		arg_326_1.time_ = 0
		arg_326_1.frameCnt_ = 0
		arg_326_1.state_ = "playing"
		arg_326_1.curTalkId_ = 121521079
		arg_326_1.duration_ = 2.93

		local var_326_0 = {
			ja = 2.933,
			ko = 1.866,
			zh = 1.866
		}
		local var_326_1 = manager.audio:GetLocalizationFlag()

		if var_326_0[var_326_1] ~= nil then
			arg_326_1.duration_ = var_326_0[var_326_1]
		end

		SetActive(arg_326_1.tipsGo_, false)

		function arg_326_1.onSingleLineFinish_()
			arg_326_1.onSingleLineUpdate_ = nil
			arg_326_1.onSingleLineFinish_ = nil
			arg_326_1.state_ = "waiting"
		end

		function arg_326_1.playNext_(arg_328_0)
			if arg_328_0 == 1 then
				arg_326_0:Play121521080(arg_326_1)
			end
		end

		function arg_326_1.onSingleLineUpdate_(arg_329_0)
			local var_329_0 = 0
			local var_329_1 = 0.225

			if var_329_0 < arg_326_1.time_ and arg_326_1.time_ <= var_329_0 + arg_329_0 then
				arg_326_1.talkMaxDuration = 0
				arg_326_1.dialogCg_.alpha = 1

				arg_326_1.dialog_:SetActive(true)
				SetActive(arg_326_1.leftNameGo_, true)

				local var_329_2 = arg_326_1:FormatText(StoryNameCfg[406].name)

				arg_326_1.leftNameTxt_.text = var_329_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_326_1.leftNameTxt_.transform)

				arg_326_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_326_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_326_1:RecordName(arg_326_1.leftNameTxt_.text)
				SetActive(arg_326_1.iconTrs_.gameObject, true)
				arg_326_1.iconController_:SetSelectedState("hero")

				arg_326_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_sifang")

				arg_326_1.callingController_:SetSelectedState("normal")

				arg_326_1.keyicon_.color = Color.New(1, 1, 1)
				arg_326_1.icon_.color = Color.New(1, 1, 1)

				local var_329_3 = arg_326_1:GetWordFromCfg(121521079)
				local var_329_4 = arg_326_1:FormatText(var_329_3.content)

				arg_326_1.text_.text = var_329_4

				LuaForUtil.ClearLinePrefixSymbol(arg_326_1.text_)

				local var_329_5 = 9
				local var_329_6 = utf8.len(var_329_4)
				local var_329_7 = var_329_5 <= 0 and var_329_1 or var_329_1 * (var_329_6 / var_329_5)

				if var_329_7 > 0 and var_329_1 < var_329_7 then
					arg_326_1.talkMaxDuration = var_329_7

					if var_329_7 + var_329_0 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_7 + var_329_0
					end
				end

				arg_326_1.text_.text = var_329_4
				arg_326_1.typewritter.percent = 0

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121521", "121521079", "story_v_out_121521.awb") ~= 0 then
					local var_329_8 = manager.audio:GetVoiceLength("story_v_out_121521", "121521079", "story_v_out_121521.awb") / 1000

					if var_329_8 + var_329_0 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_8 + var_329_0
					end

					if var_329_3.prefab_name ~= "" and arg_326_1.actors_[var_329_3.prefab_name] ~= nil then
						local var_329_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_326_1.actors_[var_329_3.prefab_name].transform, "story_v_out_121521", "121521079", "story_v_out_121521.awb")

						arg_326_1:RecordAudio("121521079", var_329_9)
						arg_326_1:RecordAudio("121521079", var_329_9)
					else
						arg_326_1:AudioAction("play", "voice", "story_v_out_121521", "121521079", "story_v_out_121521.awb")
					end

					arg_326_1:RecordHistoryTalkVoice("story_v_out_121521", "121521079", "story_v_out_121521.awb")
				end

				arg_326_1:RecordContent(arg_326_1.text_.text)
			end

			local var_329_10 = math.max(var_329_1, arg_326_1.talkMaxDuration)

			if var_329_0 <= arg_326_1.time_ and arg_326_1.time_ < var_329_0 + var_329_10 then
				arg_326_1.typewritter.percent = (arg_326_1.time_ - var_329_0) / var_329_10

				arg_326_1.typewritter:SetDirty()
			end

			if arg_326_1.time_ >= var_329_0 + var_329_10 and arg_326_1.time_ < var_329_0 + var_329_10 + arg_329_0 then
				arg_326_1.typewritter.percent = 1

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(true)
			end
		end

		arg_326_1.nodeConfigList_ = {}

		arg_326_1:InitPlayNodeList()
	end,
	Play121521080 = function(arg_330_0, arg_330_1)
		arg_330_1.time_ = 0
		arg_330_1.frameCnt_ = 0
		arg_330_1.state_ = "playing"
		arg_330_1.curTalkId_ = 121521080
		arg_330_1.duration_ = 6.73

		local var_330_0 = {
			ja = 6.733,
			ko = 2.9,
			zh = 2.9
		}
		local var_330_1 = manager.audio:GetLocalizationFlag()

		if var_330_0[var_330_1] ~= nil then
			arg_330_1.duration_ = var_330_0[var_330_1]
		end

		SetActive(arg_330_1.tipsGo_, false)

		function arg_330_1.onSingleLineFinish_()
			arg_330_1.onSingleLineUpdate_ = nil
			arg_330_1.onSingleLineFinish_ = nil
			arg_330_1.state_ = "waiting"
		end

		function arg_330_1.playNext_(arg_332_0)
			if arg_332_0 == 1 then
				arg_330_0:Play121521081(arg_330_1)
			end
		end

		function arg_330_1.onSingleLineUpdate_(arg_333_0)
			local var_333_0 = 0
			local var_333_1 = 0.425

			if var_333_0 < arg_330_1.time_ and arg_330_1.time_ <= var_333_0 + arg_333_0 then
				arg_330_1.talkMaxDuration = 0
				arg_330_1.dialogCg_.alpha = 1

				arg_330_1.dialog_:SetActive(true)
				SetActive(arg_330_1.leftNameGo_, true)

				local var_333_2 = arg_330_1:FormatText(StoryNameCfg[381].name)

				arg_330_1.leftNameTxt_.text = var_333_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_330_1.leftNameTxt_.transform)

				arg_330_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_330_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_330_1:RecordName(arg_330_1.leftNameTxt_.text)
				SetActive(arg_330_1.iconTrs_.gameObject, true)
				arg_330_1.iconController_:SetSelectedState("hero")

				arg_330_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1075")

				arg_330_1.callingController_:SetSelectedState("normal")

				arg_330_1.keyicon_.color = Color.New(1, 1, 1)
				arg_330_1.icon_.color = Color.New(1, 1, 1)

				local var_333_3 = arg_330_1:GetWordFromCfg(121521080)
				local var_333_4 = arg_330_1:FormatText(var_333_3.content)

				arg_330_1.text_.text = var_333_4

				LuaForUtil.ClearLinePrefixSymbol(arg_330_1.text_)

				local var_333_5 = 17
				local var_333_6 = utf8.len(var_333_4)
				local var_333_7 = var_333_5 <= 0 and var_333_1 or var_333_1 * (var_333_6 / var_333_5)

				if var_333_7 > 0 and var_333_1 < var_333_7 then
					arg_330_1.talkMaxDuration = var_333_7

					if var_333_7 + var_333_0 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_7 + var_333_0
					end
				end

				arg_330_1.text_.text = var_333_4
				arg_330_1.typewritter.percent = 0

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121521", "121521080", "story_v_out_121521.awb") ~= 0 then
					local var_333_8 = manager.audio:GetVoiceLength("story_v_out_121521", "121521080", "story_v_out_121521.awb") / 1000

					if var_333_8 + var_333_0 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_8 + var_333_0
					end

					if var_333_3.prefab_name ~= "" and arg_330_1.actors_[var_333_3.prefab_name] ~= nil then
						local var_333_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_330_1.actors_[var_333_3.prefab_name].transform, "story_v_out_121521", "121521080", "story_v_out_121521.awb")

						arg_330_1:RecordAudio("121521080", var_333_9)
						arg_330_1:RecordAudio("121521080", var_333_9)
					else
						arg_330_1:AudioAction("play", "voice", "story_v_out_121521", "121521080", "story_v_out_121521.awb")
					end

					arg_330_1:RecordHistoryTalkVoice("story_v_out_121521", "121521080", "story_v_out_121521.awb")
				end

				arg_330_1:RecordContent(arg_330_1.text_.text)
			end

			local var_333_10 = math.max(var_333_1, arg_330_1.talkMaxDuration)

			if var_333_0 <= arg_330_1.time_ and arg_330_1.time_ < var_333_0 + var_333_10 then
				arg_330_1.typewritter.percent = (arg_330_1.time_ - var_333_0) / var_333_10

				arg_330_1.typewritter:SetDirty()
			end

			if arg_330_1.time_ >= var_333_0 + var_333_10 and arg_330_1.time_ < var_333_0 + var_333_10 + arg_333_0 then
				arg_330_1.typewritter.percent = 1

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(true)
			end
		end

		arg_330_1.nodeConfigList_ = {}

		arg_330_1:InitPlayNodeList()
	end,
	Play121521081 = function(arg_334_0, arg_334_1)
		arg_334_1.time_ = 0
		arg_334_1.frameCnt_ = 0
		arg_334_1.state_ = "playing"
		arg_334_1.curTalkId_ = 121521081
		arg_334_1.duration_ = 5

		SetActive(arg_334_1.tipsGo_, false)

		function arg_334_1.onSingleLineFinish_()
			arg_334_1.onSingleLineUpdate_ = nil
			arg_334_1.onSingleLineFinish_ = nil
			arg_334_1.state_ = "waiting"
		end

		function arg_334_1.playNext_(arg_336_0)
			if arg_336_0 == 1 then
				arg_334_0:Play121521082(arg_334_1)
			end
		end

		function arg_334_1.onSingleLineUpdate_(arg_337_0)
			local var_337_0 = 0
			local var_337_1 = 0.8

			if var_337_0 < arg_334_1.time_ and arg_334_1.time_ <= var_337_0 + arg_337_0 then
				arg_334_1.talkMaxDuration = 0
				arg_334_1.dialogCg_.alpha = 1

				arg_334_1.dialog_:SetActive(true)
				SetActive(arg_334_1.leftNameGo_, false)

				arg_334_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_334_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_334_1:RecordName(arg_334_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_334_1.iconTrs_.gameObject, false)
				arg_334_1.callingController_:SetSelectedState("normal")

				local var_337_2 = arg_334_1:GetWordFromCfg(121521081)
				local var_337_3 = arg_334_1:FormatText(var_337_2.content)

				arg_334_1.text_.text = var_337_3

				LuaForUtil.ClearLinePrefixSymbol(arg_334_1.text_)

				local var_337_4 = 32
				local var_337_5 = utf8.len(var_337_3)
				local var_337_6 = var_337_4 <= 0 and var_337_1 or var_337_1 * (var_337_5 / var_337_4)

				if var_337_6 > 0 and var_337_1 < var_337_6 then
					arg_334_1.talkMaxDuration = var_337_6

					if var_337_6 + var_337_0 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_6 + var_337_0
					end
				end

				arg_334_1.text_.text = var_337_3
				arg_334_1.typewritter.percent = 0

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(false)
				arg_334_1:RecordContent(arg_334_1.text_.text)
			end

			local var_337_7 = math.max(var_337_1, arg_334_1.talkMaxDuration)

			if var_337_0 <= arg_334_1.time_ and arg_334_1.time_ < var_337_0 + var_337_7 then
				arg_334_1.typewritter.percent = (arg_334_1.time_ - var_337_0) / var_337_7

				arg_334_1.typewritter:SetDirty()
			end

			if arg_334_1.time_ >= var_337_0 + var_337_7 and arg_334_1.time_ < var_337_0 + var_337_7 + arg_337_0 then
				arg_334_1.typewritter.percent = 1

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(true)
			end
		end

		arg_334_1.nodeConfigList_ = {}

		arg_334_1:InitPlayNodeList()
	end,
	Play121521082 = function(arg_338_0, arg_338_1)
		arg_338_1.time_ = 0
		arg_338_1.frameCnt_ = 0
		arg_338_1.state_ = "playing"
		arg_338_1.curTalkId_ = 121521082
		arg_338_1.duration_ = 5

		SetActive(arg_338_1.tipsGo_, false)

		function arg_338_1.onSingleLineFinish_()
			arg_338_1.onSingleLineUpdate_ = nil
			arg_338_1.onSingleLineFinish_ = nil
			arg_338_1.state_ = "waiting"
		end

		function arg_338_1.playNext_(arg_340_0)
			if arg_340_0 == 1 then
				arg_338_0:Play121521083(arg_338_1)
			end
		end

		function arg_338_1.onSingleLineUpdate_(arg_341_0)
			local var_341_0 = 0
			local var_341_1 = 1.125

			if var_341_0 < arg_338_1.time_ and arg_338_1.time_ <= var_341_0 + arg_341_0 then
				arg_338_1.talkMaxDuration = 0
				arg_338_1.dialogCg_.alpha = 1

				arg_338_1.dialog_:SetActive(true)
				SetActive(arg_338_1.leftNameGo_, false)

				arg_338_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_338_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_338_1:RecordName(arg_338_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_338_1.iconTrs_.gameObject, false)
				arg_338_1.callingController_:SetSelectedState("normal")

				local var_341_2 = arg_338_1:GetWordFromCfg(121521082)
				local var_341_3 = arg_338_1:FormatText(var_341_2.content)

				arg_338_1.text_.text = var_341_3

				LuaForUtil.ClearLinePrefixSymbol(arg_338_1.text_)

				local var_341_4 = 45
				local var_341_5 = utf8.len(var_341_3)
				local var_341_6 = var_341_4 <= 0 and var_341_1 or var_341_1 * (var_341_5 / var_341_4)

				if var_341_6 > 0 and var_341_1 < var_341_6 then
					arg_338_1.talkMaxDuration = var_341_6

					if var_341_6 + var_341_0 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_6 + var_341_0
					end
				end

				arg_338_1.text_.text = var_341_3
				arg_338_1.typewritter.percent = 0

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(false)
				arg_338_1:RecordContent(arg_338_1.text_.text)
			end

			local var_341_7 = math.max(var_341_1, arg_338_1.talkMaxDuration)

			if var_341_0 <= arg_338_1.time_ and arg_338_1.time_ < var_341_0 + var_341_7 then
				arg_338_1.typewritter.percent = (arg_338_1.time_ - var_341_0) / var_341_7

				arg_338_1.typewritter:SetDirty()
			end

			if arg_338_1.time_ >= var_341_0 + var_341_7 and arg_338_1.time_ < var_341_0 + var_341_7 + arg_341_0 then
				arg_338_1.typewritter.percent = 1

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(true)
			end
		end

		arg_338_1.nodeConfigList_ = {}

		arg_338_1:InitPlayNodeList()
	end,
	Play121521083 = function(arg_342_0, arg_342_1)
		arg_342_1.time_ = 0
		arg_342_1.frameCnt_ = 0
		arg_342_1.state_ = "playing"
		arg_342_1.curTalkId_ = 121521083
		arg_342_1.duration_ = 10.17

		local var_342_0 = {
			ja = 8.666,
			ko = 10.166,
			zh = 10.166
		}
		local var_342_1 = manager.audio:GetLocalizationFlag()

		if var_342_0[var_342_1] ~= nil then
			arg_342_1.duration_ = var_342_0[var_342_1]
		end

		SetActive(arg_342_1.tipsGo_, false)

		function arg_342_1.onSingleLineFinish_()
			arg_342_1.onSingleLineUpdate_ = nil
			arg_342_1.onSingleLineFinish_ = nil
			arg_342_1.state_ = "waiting"
		end

		function arg_342_1.playNext_(arg_344_0)
			if arg_344_0 == 1 then
				arg_342_0:Play121521084(arg_342_1)
			end
		end

		function arg_342_1.onSingleLineUpdate_(arg_345_0)
			local var_345_0 = 0
			local var_345_1 = 1.375

			if var_345_0 < arg_342_1.time_ and arg_342_1.time_ <= var_345_0 + arg_345_0 then
				arg_342_1.talkMaxDuration = 0
				arg_342_1.dialogCg_.alpha = 1

				arg_342_1.dialog_:SetActive(true)
				SetActive(arg_342_1.leftNameGo_, true)

				local var_345_2 = arg_342_1:FormatText(StoryNameCfg[406].name)

				arg_342_1.leftNameTxt_.text = var_345_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_342_1.leftNameTxt_.transform)

				arg_342_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_342_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_342_1:RecordName(arg_342_1.leftNameTxt_.text)
				SetActive(arg_342_1.iconTrs_.gameObject, true)
				arg_342_1.iconController_:SetSelectedState("hero")

				arg_342_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_sifang")

				arg_342_1.callingController_:SetSelectedState("normal")

				arg_342_1.keyicon_.color = Color.New(1, 1, 1)
				arg_342_1.icon_.color = Color.New(1, 1, 1)

				local var_345_3 = arg_342_1:GetWordFromCfg(121521083)
				local var_345_4 = arg_342_1:FormatText(var_345_3.content)

				arg_342_1.text_.text = var_345_4

				LuaForUtil.ClearLinePrefixSymbol(arg_342_1.text_)

				local var_345_5 = 55
				local var_345_6 = utf8.len(var_345_4)
				local var_345_7 = var_345_5 <= 0 and var_345_1 or var_345_1 * (var_345_6 / var_345_5)

				if var_345_7 > 0 and var_345_1 < var_345_7 then
					arg_342_1.talkMaxDuration = var_345_7

					if var_345_7 + var_345_0 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_7 + var_345_0
					end
				end

				arg_342_1.text_.text = var_345_4
				arg_342_1.typewritter.percent = 0

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121521", "121521083", "story_v_out_121521.awb") ~= 0 then
					local var_345_8 = manager.audio:GetVoiceLength("story_v_out_121521", "121521083", "story_v_out_121521.awb") / 1000

					if var_345_8 + var_345_0 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_8 + var_345_0
					end

					if var_345_3.prefab_name ~= "" and arg_342_1.actors_[var_345_3.prefab_name] ~= nil then
						local var_345_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_342_1.actors_[var_345_3.prefab_name].transform, "story_v_out_121521", "121521083", "story_v_out_121521.awb")

						arg_342_1:RecordAudio("121521083", var_345_9)
						arg_342_1:RecordAudio("121521083", var_345_9)
					else
						arg_342_1:AudioAction("play", "voice", "story_v_out_121521", "121521083", "story_v_out_121521.awb")
					end

					arg_342_1:RecordHistoryTalkVoice("story_v_out_121521", "121521083", "story_v_out_121521.awb")
				end

				arg_342_1:RecordContent(arg_342_1.text_.text)
			end

			local var_345_10 = math.max(var_345_1, arg_342_1.talkMaxDuration)

			if var_345_0 <= arg_342_1.time_ and arg_342_1.time_ < var_345_0 + var_345_10 then
				arg_342_1.typewritter.percent = (arg_342_1.time_ - var_345_0) / var_345_10

				arg_342_1.typewritter:SetDirty()
			end

			if arg_342_1.time_ >= var_345_0 + var_345_10 and arg_342_1.time_ < var_345_0 + var_345_10 + arg_345_0 then
				arg_342_1.typewritter.percent = 1

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(true)
			end
		end

		arg_342_1.nodeConfigList_ = {}

		arg_342_1:InitPlayNodeList()
	end,
	Play121521084 = function(arg_346_0, arg_346_1)
		arg_346_1.time_ = 0
		arg_346_1.frameCnt_ = 0
		arg_346_1.state_ = "playing"
		arg_346_1.curTalkId_ = 121521084
		arg_346_1.duration_ = 9.83

		local var_346_0 = {
			ja = 9.833,
			ko = 6.666,
			zh = 6.666
		}
		local var_346_1 = manager.audio:GetLocalizationFlag()

		if var_346_0[var_346_1] ~= nil then
			arg_346_1.duration_ = var_346_0[var_346_1]
		end

		SetActive(arg_346_1.tipsGo_, false)

		function arg_346_1.onSingleLineFinish_()
			arg_346_1.onSingleLineUpdate_ = nil
			arg_346_1.onSingleLineFinish_ = nil
			arg_346_1.state_ = "waiting"
		end

		function arg_346_1.playNext_(arg_348_0)
			if arg_348_0 == 1 then
				arg_346_0:Play121521085(arg_346_1)
			end
		end

		function arg_346_1.onSingleLineUpdate_(arg_349_0)
			local var_349_0 = 0
			local var_349_1 = 0.9

			if var_349_0 < arg_346_1.time_ and arg_346_1.time_ <= var_349_0 + arg_349_0 then
				arg_346_1.talkMaxDuration = 0
				arg_346_1.dialogCg_.alpha = 1

				arg_346_1.dialog_:SetActive(true)
				SetActive(arg_346_1.leftNameGo_, true)

				local var_349_2 = arg_346_1:FormatText(StoryNameCfg[406].name)

				arg_346_1.leftNameTxt_.text = var_349_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_346_1.leftNameTxt_.transform)

				arg_346_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_346_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_346_1:RecordName(arg_346_1.leftNameTxt_.text)
				SetActive(arg_346_1.iconTrs_.gameObject, true)
				arg_346_1.iconController_:SetSelectedState("hero")

				arg_346_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_sifang")

				arg_346_1.callingController_:SetSelectedState("normal")

				arg_346_1.keyicon_.color = Color.New(1, 1, 1)
				arg_346_1.icon_.color = Color.New(1, 1, 1)

				local var_349_3 = arg_346_1:GetWordFromCfg(121521084)
				local var_349_4 = arg_346_1:FormatText(var_349_3.content)

				arg_346_1.text_.text = var_349_4

				LuaForUtil.ClearLinePrefixSymbol(arg_346_1.text_)

				local var_349_5 = 36
				local var_349_6 = utf8.len(var_349_4)
				local var_349_7 = var_349_5 <= 0 and var_349_1 or var_349_1 * (var_349_6 / var_349_5)

				if var_349_7 > 0 and var_349_1 < var_349_7 then
					arg_346_1.talkMaxDuration = var_349_7

					if var_349_7 + var_349_0 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_7 + var_349_0
					end
				end

				arg_346_1.text_.text = var_349_4
				arg_346_1.typewritter.percent = 0

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121521", "121521084", "story_v_out_121521.awb") ~= 0 then
					local var_349_8 = manager.audio:GetVoiceLength("story_v_out_121521", "121521084", "story_v_out_121521.awb") / 1000

					if var_349_8 + var_349_0 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_8 + var_349_0
					end

					if var_349_3.prefab_name ~= "" and arg_346_1.actors_[var_349_3.prefab_name] ~= nil then
						local var_349_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_346_1.actors_[var_349_3.prefab_name].transform, "story_v_out_121521", "121521084", "story_v_out_121521.awb")

						arg_346_1:RecordAudio("121521084", var_349_9)
						arg_346_1:RecordAudio("121521084", var_349_9)
					else
						arg_346_1:AudioAction("play", "voice", "story_v_out_121521", "121521084", "story_v_out_121521.awb")
					end

					arg_346_1:RecordHistoryTalkVoice("story_v_out_121521", "121521084", "story_v_out_121521.awb")
				end

				arg_346_1:RecordContent(arg_346_1.text_.text)
			end

			local var_349_10 = math.max(var_349_1, arg_346_1.talkMaxDuration)

			if var_349_0 <= arg_346_1.time_ and arg_346_1.time_ < var_349_0 + var_349_10 then
				arg_346_1.typewritter.percent = (arg_346_1.time_ - var_349_0) / var_349_10

				arg_346_1.typewritter:SetDirty()
			end

			if arg_346_1.time_ >= var_349_0 + var_349_10 and arg_346_1.time_ < var_349_0 + var_349_10 + arg_349_0 then
				arg_346_1.typewritter.percent = 1

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(true)
			end
		end

		arg_346_1.nodeConfigList_ = {}

		arg_346_1:InitPlayNodeList()
	end,
	Play121521085 = function(arg_350_0, arg_350_1)
		arg_350_1.time_ = 0
		arg_350_1.frameCnt_ = 0
		arg_350_1.state_ = "playing"
		arg_350_1.curTalkId_ = 121521085
		arg_350_1.duration_ = 5

		SetActive(arg_350_1.tipsGo_, false)

		function arg_350_1.onSingleLineFinish_()
			arg_350_1.onSingleLineUpdate_ = nil
			arg_350_1.onSingleLineFinish_ = nil
			arg_350_1.state_ = "waiting"
		end

		function arg_350_1.playNext_(arg_352_0)
			if arg_352_0 == 1 then
				arg_350_0:Play121521086(arg_350_1)
			end
		end

		function arg_350_1.onSingleLineUpdate_(arg_353_0)
			local var_353_0 = 0
			local var_353_1 = 0.875

			if var_353_0 < arg_350_1.time_ and arg_350_1.time_ <= var_353_0 + arg_353_0 then
				arg_350_1.talkMaxDuration = 0
				arg_350_1.dialogCg_.alpha = 1

				arg_350_1.dialog_:SetActive(true)
				SetActive(arg_350_1.leftNameGo_, true)

				local var_353_2 = arg_350_1:FormatText(StoryNameCfg[7].name)

				arg_350_1.leftNameTxt_.text = var_353_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_350_1.leftNameTxt_.transform)

				arg_350_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_350_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_350_1:RecordName(arg_350_1.leftNameTxt_.text)
				SetActive(arg_350_1.iconTrs_.gameObject, true)
				arg_350_1.iconController_:SetSelectedState("hero")

				arg_350_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_350_1.callingController_:SetSelectedState("normal")

				arg_350_1.keyicon_.color = Color.New(1, 1, 1)
				arg_350_1.icon_.color = Color.New(1, 1, 1)

				local var_353_3 = arg_350_1:GetWordFromCfg(121521085)
				local var_353_4 = arg_350_1:FormatText(var_353_3.content)

				arg_350_1.text_.text = var_353_4

				LuaForUtil.ClearLinePrefixSymbol(arg_350_1.text_)

				local var_353_5 = 35
				local var_353_6 = utf8.len(var_353_4)
				local var_353_7 = var_353_5 <= 0 and var_353_1 or var_353_1 * (var_353_6 / var_353_5)

				if var_353_7 > 0 and var_353_1 < var_353_7 then
					arg_350_1.talkMaxDuration = var_353_7

					if var_353_7 + var_353_0 > arg_350_1.duration_ then
						arg_350_1.duration_ = var_353_7 + var_353_0
					end
				end

				arg_350_1.text_.text = var_353_4
				arg_350_1.typewritter.percent = 0

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(false)
				arg_350_1:RecordContent(arg_350_1.text_.text)
			end

			local var_353_8 = math.max(var_353_1, arg_350_1.talkMaxDuration)

			if var_353_0 <= arg_350_1.time_ and arg_350_1.time_ < var_353_0 + var_353_8 then
				arg_350_1.typewritter.percent = (arg_350_1.time_ - var_353_0) / var_353_8

				arg_350_1.typewritter:SetDirty()
			end

			if arg_350_1.time_ >= var_353_0 + var_353_8 and arg_350_1.time_ < var_353_0 + var_353_8 + arg_353_0 then
				arg_350_1.typewritter.percent = 1

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(true)
			end
		end

		arg_350_1.nodeConfigList_ = {}

		arg_350_1:InitPlayNodeList()
	end,
	Play121521086 = function(arg_354_0, arg_354_1)
		arg_354_1.time_ = 0
		arg_354_1.frameCnt_ = 0
		arg_354_1.state_ = "playing"
		arg_354_1.curTalkId_ = 121521086
		arg_354_1.duration_ = 3.53

		local var_354_0 = {
			ja = 3.533,
			ko = 3.166,
			zh = 3.166
		}
		local var_354_1 = manager.audio:GetLocalizationFlag()

		if var_354_0[var_354_1] ~= nil then
			arg_354_1.duration_ = var_354_0[var_354_1]
		end

		SetActive(arg_354_1.tipsGo_, false)

		function arg_354_1.onSingleLineFinish_()
			arg_354_1.onSingleLineUpdate_ = nil
			arg_354_1.onSingleLineFinish_ = nil
			arg_354_1.state_ = "waiting"
		end

		function arg_354_1.playNext_(arg_356_0)
			if arg_356_0 == 1 then
				arg_354_0:Play121521087(arg_354_1)
			end
		end

		function arg_354_1.onSingleLineUpdate_(arg_357_0)
			local var_357_0 = arg_354_1.actors_["1075ui_story"].transform
			local var_357_1 = 0

			if var_357_1 < arg_354_1.time_ and arg_354_1.time_ <= var_357_1 + arg_357_0 then
				arg_354_1.var_.moveOldPos1075ui_story = var_357_0.localPosition
			end

			local var_357_2 = 0.001

			if var_357_1 <= arg_354_1.time_ and arg_354_1.time_ < var_357_1 + var_357_2 then
				local var_357_3 = (arg_354_1.time_ - var_357_1) / var_357_2
				local var_357_4 = Vector3.New(0, -1.055, -6.16)

				var_357_0.localPosition = Vector3.Lerp(arg_354_1.var_.moveOldPos1075ui_story, var_357_4, var_357_3)

				local var_357_5 = manager.ui.mainCamera.transform.position - var_357_0.position

				var_357_0.forward = Vector3.New(var_357_5.x, var_357_5.y, var_357_5.z)

				local var_357_6 = var_357_0.localEulerAngles

				var_357_6.z = 0
				var_357_6.x = 0
				var_357_0.localEulerAngles = var_357_6
			end

			if arg_354_1.time_ >= var_357_1 + var_357_2 and arg_354_1.time_ < var_357_1 + var_357_2 + arg_357_0 then
				var_357_0.localPosition = Vector3.New(0, -1.055, -6.16)

				local var_357_7 = manager.ui.mainCamera.transform.position - var_357_0.position

				var_357_0.forward = Vector3.New(var_357_7.x, var_357_7.y, var_357_7.z)

				local var_357_8 = var_357_0.localEulerAngles

				var_357_8.z = 0
				var_357_8.x = 0
				var_357_0.localEulerAngles = var_357_8
			end

			local var_357_9 = arg_354_1.actors_["1075ui_story"]
			local var_357_10 = 0

			if var_357_10 < arg_354_1.time_ and arg_354_1.time_ <= var_357_10 + arg_357_0 and not isNil(var_357_9) and arg_354_1.var_.characterEffect1075ui_story == nil then
				arg_354_1.var_.characterEffect1075ui_story = var_357_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_357_11 = 0.200000002980232

			if var_357_10 <= arg_354_1.time_ and arg_354_1.time_ < var_357_10 + var_357_11 and not isNil(var_357_9) then
				local var_357_12 = (arg_354_1.time_ - var_357_10) / var_357_11

				if arg_354_1.var_.characterEffect1075ui_story and not isNil(var_357_9) then
					arg_354_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_354_1.time_ >= var_357_10 + var_357_11 and arg_354_1.time_ < var_357_10 + var_357_11 + arg_357_0 and not isNil(var_357_9) and arg_354_1.var_.characterEffect1075ui_story then
				arg_354_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_357_13 = 0

			if var_357_13 < arg_354_1.time_ and arg_354_1.time_ <= var_357_13 + arg_357_0 then
				arg_354_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action1_1")
			end

			local var_357_14 = 0

			if var_357_14 < arg_354_1.time_ and arg_354_1.time_ <= var_357_14 + arg_357_0 then
				arg_354_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_357_15 = 0
			local var_357_16 = 0.375

			if var_357_15 < arg_354_1.time_ and arg_354_1.time_ <= var_357_15 + arg_357_0 then
				arg_354_1.talkMaxDuration = 0
				arg_354_1.dialogCg_.alpha = 1

				arg_354_1.dialog_:SetActive(true)
				SetActive(arg_354_1.leftNameGo_, true)

				local var_357_17 = arg_354_1:FormatText(StoryNameCfg[381].name)

				arg_354_1.leftNameTxt_.text = var_357_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_354_1.leftNameTxt_.transform)

				arg_354_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_354_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_354_1:RecordName(arg_354_1.leftNameTxt_.text)
				SetActive(arg_354_1.iconTrs_.gameObject, false)
				arg_354_1.callingController_:SetSelectedState("normal")

				local var_357_18 = arg_354_1:GetWordFromCfg(121521086)
				local var_357_19 = arg_354_1:FormatText(var_357_18.content)

				arg_354_1.text_.text = var_357_19

				LuaForUtil.ClearLinePrefixSymbol(arg_354_1.text_)

				local var_357_20 = 15
				local var_357_21 = utf8.len(var_357_19)
				local var_357_22 = var_357_20 <= 0 and var_357_16 or var_357_16 * (var_357_21 / var_357_20)

				if var_357_22 > 0 and var_357_16 < var_357_22 then
					arg_354_1.talkMaxDuration = var_357_22

					if var_357_22 + var_357_15 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_22 + var_357_15
					end
				end

				arg_354_1.text_.text = var_357_19
				arg_354_1.typewritter.percent = 0

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121521", "121521086", "story_v_out_121521.awb") ~= 0 then
					local var_357_23 = manager.audio:GetVoiceLength("story_v_out_121521", "121521086", "story_v_out_121521.awb") / 1000

					if var_357_23 + var_357_15 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_23 + var_357_15
					end

					if var_357_18.prefab_name ~= "" and arg_354_1.actors_[var_357_18.prefab_name] ~= nil then
						local var_357_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_354_1.actors_[var_357_18.prefab_name].transform, "story_v_out_121521", "121521086", "story_v_out_121521.awb")

						arg_354_1:RecordAudio("121521086", var_357_24)
						arg_354_1:RecordAudio("121521086", var_357_24)
					else
						arg_354_1:AudioAction("play", "voice", "story_v_out_121521", "121521086", "story_v_out_121521.awb")
					end

					arg_354_1:RecordHistoryTalkVoice("story_v_out_121521", "121521086", "story_v_out_121521.awb")
				end

				arg_354_1:RecordContent(arg_354_1.text_.text)
			end

			local var_357_25 = math.max(var_357_16, arg_354_1.talkMaxDuration)

			if var_357_15 <= arg_354_1.time_ and arg_354_1.time_ < var_357_15 + var_357_25 then
				arg_354_1.typewritter.percent = (arg_354_1.time_ - var_357_15) / var_357_25

				arg_354_1.typewritter:SetDirty()
			end

			if arg_354_1.time_ >= var_357_15 + var_357_25 and arg_354_1.time_ < var_357_15 + var_357_25 + arg_357_0 then
				arg_354_1.typewritter.percent = 1

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(true)
			end
		end

		arg_354_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_354_1:InitPlayNodeList()
	end,
	Play121521087 = function(arg_358_0, arg_358_1)
		arg_358_1.time_ = 0
		arg_358_1.frameCnt_ = 0
		arg_358_1.state_ = "playing"
		arg_358_1.curTalkId_ = 121521087
		arg_358_1.duration_ = 17.9

		local var_358_0 = {
			ja = 17.9,
			ko = 12.266,
			zh = 12.266
		}
		local var_358_1 = manager.audio:GetLocalizationFlag()

		if var_358_0[var_358_1] ~= nil then
			arg_358_1.duration_ = var_358_0[var_358_1]
		end

		SetActive(arg_358_1.tipsGo_, false)

		function arg_358_1.onSingleLineFinish_()
			arg_358_1.onSingleLineUpdate_ = nil
			arg_358_1.onSingleLineFinish_ = nil
			arg_358_1.state_ = "waiting"
		end

		function arg_358_1.playNext_(arg_360_0)
			if arg_360_0 == 1 then
				arg_358_0:Play121521088(arg_358_1)
			end
		end

		function arg_358_1.onSingleLineUpdate_(arg_361_0)
			local var_361_0 = arg_358_1.actors_["1075ui_story"]
			local var_361_1 = 0

			if var_361_1 < arg_358_1.time_ and arg_358_1.time_ <= var_361_1 + arg_361_0 and not isNil(var_361_0) and arg_358_1.var_.characterEffect1075ui_story == nil then
				arg_358_1.var_.characterEffect1075ui_story = var_361_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_361_2 = 0.200000002980232

			if var_361_1 <= arg_358_1.time_ and arg_358_1.time_ < var_361_1 + var_361_2 and not isNil(var_361_0) then
				local var_361_3 = (arg_358_1.time_ - var_361_1) / var_361_2

				if arg_358_1.var_.characterEffect1075ui_story and not isNil(var_361_0) then
					local var_361_4 = Mathf.Lerp(0, 0.5, var_361_3)

					arg_358_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_358_1.var_.characterEffect1075ui_story.fillRatio = var_361_4
				end
			end

			if arg_358_1.time_ >= var_361_1 + var_361_2 and arg_358_1.time_ < var_361_1 + var_361_2 + arg_361_0 and not isNil(var_361_0) and arg_358_1.var_.characterEffect1075ui_story then
				local var_361_5 = 0.5

				arg_358_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_358_1.var_.characterEffect1075ui_story.fillRatio = var_361_5
			end

			local var_361_6 = 0
			local var_361_7 = 1.25

			if var_361_6 < arg_358_1.time_ and arg_358_1.time_ <= var_361_6 + arg_361_0 then
				arg_358_1.talkMaxDuration = 0
				arg_358_1.dialogCg_.alpha = 1

				arg_358_1.dialog_:SetActive(true)
				SetActive(arg_358_1.leftNameGo_, true)

				local var_361_8 = arg_358_1:FormatText(StoryNameCfg[406].name)

				arg_358_1.leftNameTxt_.text = var_361_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_358_1.leftNameTxt_.transform)

				arg_358_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_358_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_358_1:RecordName(arg_358_1.leftNameTxt_.text)
				SetActive(arg_358_1.iconTrs_.gameObject, true)
				arg_358_1.iconController_:SetSelectedState("hero")

				arg_358_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_sifang")

				arg_358_1.callingController_:SetSelectedState("normal")

				arg_358_1.keyicon_.color = Color.New(1, 1, 1)
				arg_358_1.icon_.color = Color.New(1, 1, 1)

				local var_361_9 = arg_358_1:GetWordFromCfg(121521087)
				local var_361_10 = arg_358_1:FormatText(var_361_9.content)

				arg_358_1.text_.text = var_361_10

				LuaForUtil.ClearLinePrefixSymbol(arg_358_1.text_)

				local var_361_11 = 50
				local var_361_12 = utf8.len(var_361_10)
				local var_361_13 = var_361_11 <= 0 and var_361_7 or var_361_7 * (var_361_12 / var_361_11)

				if var_361_13 > 0 and var_361_7 < var_361_13 then
					arg_358_1.talkMaxDuration = var_361_13

					if var_361_13 + var_361_6 > arg_358_1.duration_ then
						arg_358_1.duration_ = var_361_13 + var_361_6
					end
				end

				arg_358_1.text_.text = var_361_10
				arg_358_1.typewritter.percent = 0

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121521", "121521087", "story_v_out_121521.awb") ~= 0 then
					local var_361_14 = manager.audio:GetVoiceLength("story_v_out_121521", "121521087", "story_v_out_121521.awb") / 1000

					if var_361_14 + var_361_6 > arg_358_1.duration_ then
						arg_358_1.duration_ = var_361_14 + var_361_6
					end

					if var_361_9.prefab_name ~= "" and arg_358_1.actors_[var_361_9.prefab_name] ~= nil then
						local var_361_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_358_1.actors_[var_361_9.prefab_name].transform, "story_v_out_121521", "121521087", "story_v_out_121521.awb")

						arg_358_1:RecordAudio("121521087", var_361_15)
						arg_358_1:RecordAudio("121521087", var_361_15)
					else
						arg_358_1:AudioAction("play", "voice", "story_v_out_121521", "121521087", "story_v_out_121521.awb")
					end

					arg_358_1:RecordHistoryTalkVoice("story_v_out_121521", "121521087", "story_v_out_121521.awb")
				end

				arg_358_1:RecordContent(arg_358_1.text_.text)
			end

			local var_361_16 = math.max(var_361_7, arg_358_1.talkMaxDuration)

			if var_361_6 <= arg_358_1.time_ and arg_358_1.time_ < var_361_6 + var_361_16 then
				arg_358_1.typewritter.percent = (arg_358_1.time_ - var_361_6) / var_361_16

				arg_358_1.typewritter:SetDirty()
			end

			if arg_358_1.time_ >= var_361_6 + var_361_16 and arg_358_1.time_ < var_361_6 + var_361_16 + arg_361_0 then
				arg_358_1.typewritter.percent = 1

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(true)
			end
		end

		arg_358_1.nodeConfigList_ = {}

		arg_358_1:InitPlayNodeList()
	end,
	Play121521088 = function(arg_362_0, arg_362_1)
		arg_362_1.time_ = 0
		arg_362_1.frameCnt_ = 0
		arg_362_1.state_ = "playing"
		arg_362_1.curTalkId_ = 121521088
		arg_362_1.duration_ = 10.03

		local var_362_0 = {
			ja = 10.033,
			ko = 5.566,
			zh = 5.566
		}
		local var_362_1 = manager.audio:GetLocalizationFlag()

		if var_362_0[var_362_1] ~= nil then
			arg_362_1.duration_ = var_362_0[var_362_1]
		end

		SetActive(arg_362_1.tipsGo_, false)

		function arg_362_1.onSingleLineFinish_()
			arg_362_1.onSingleLineUpdate_ = nil
			arg_362_1.onSingleLineFinish_ = nil
			arg_362_1.state_ = "waiting"
		end

		function arg_362_1.playNext_(arg_364_0)
			if arg_364_0 == 1 then
				arg_362_0:Play121521089(arg_362_1)
			end
		end

		function arg_362_1.onSingleLineUpdate_(arg_365_0)
			local var_365_0 = arg_362_1.actors_["1075ui_story"]
			local var_365_1 = 0

			if var_365_1 < arg_362_1.time_ and arg_362_1.time_ <= var_365_1 + arg_365_0 and not isNil(var_365_0) and arg_362_1.var_.characterEffect1075ui_story == nil then
				arg_362_1.var_.characterEffect1075ui_story = var_365_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_365_2 = 0.200000002980232

			if var_365_1 <= arg_362_1.time_ and arg_362_1.time_ < var_365_1 + var_365_2 and not isNil(var_365_0) then
				local var_365_3 = (arg_362_1.time_ - var_365_1) / var_365_2

				if arg_362_1.var_.characterEffect1075ui_story and not isNil(var_365_0) then
					arg_362_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_362_1.time_ >= var_365_1 + var_365_2 and arg_362_1.time_ < var_365_1 + var_365_2 + arg_365_0 and not isNil(var_365_0) and arg_362_1.var_.characterEffect1075ui_story then
				arg_362_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_365_4 = 0

			if var_365_4 < arg_362_1.time_ and arg_362_1.time_ <= var_365_4 + arg_365_0 then
				arg_362_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action5_1")
			end

			local var_365_5 = 0

			if var_365_5 < arg_362_1.time_ and arg_362_1.time_ <= var_365_5 + arg_365_0 then
				arg_362_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_365_6 = 0
			local var_365_7 = 0.575

			if var_365_6 < arg_362_1.time_ and arg_362_1.time_ <= var_365_6 + arg_365_0 then
				arg_362_1.talkMaxDuration = 0
				arg_362_1.dialogCg_.alpha = 1

				arg_362_1.dialog_:SetActive(true)
				SetActive(arg_362_1.leftNameGo_, true)

				local var_365_8 = arg_362_1:FormatText(StoryNameCfg[381].name)

				arg_362_1.leftNameTxt_.text = var_365_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_362_1.leftNameTxt_.transform)

				arg_362_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_362_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_362_1:RecordName(arg_362_1.leftNameTxt_.text)
				SetActive(arg_362_1.iconTrs_.gameObject, false)
				arg_362_1.callingController_:SetSelectedState("normal")

				local var_365_9 = arg_362_1:GetWordFromCfg(121521088)
				local var_365_10 = arg_362_1:FormatText(var_365_9.content)

				arg_362_1.text_.text = var_365_10

				LuaForUtil.ClearLinePrefixSymbol(arg_362_1.text_)

				local var_365_11 = 23
				local var_365_12 = utf8.len(var_365_10)
				local var_365_13 = var_365_11 <= 0 and var_365_7 or var_365_7 * (var_365_12 / var_365_11)

				if var_365_13 > 0 and var_365_7 < var_365_13 then
					arg_362_1.talkMaxDuration = var_365_13

					if var_365_13 + var_365_6 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_13 + var_365_6
					end
				end

				arg_362_1.text_.text = var_365_10
				arg_362_1.typewritter.percent = 0

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121521", "121521088", "story_v_out_121521.awb") ~= 0 then
					local var_365_14 = manager.audio:GetVoiceLength("story_v_out_121521", "121521088", "story_v_out_121521.awb") / 1000

					if var_365_14 + var_365_6 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_14 + var_365_6
					end

					if var_365_9.prefab_name ~= "" and arg_362_1.actors_[var_365_9.prefab_name] ~= nil then
						local var_365_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_362_1.actors_[var_365_9.prefab_name].transform, "story_v_out_121521", "121521088", "story_v_out_121521.awb")

						arg_362_1:RecordAudio("121521088", var_365_15)
						arg_362_1:RecordAudio("121521088", var_365_15)
					else
						arg_362_1:AudioAction("play", "voice", "story_v_out_121521", "121521088", "story_v_out_121521.awb")
					end

					arg_362_1:RecordHistoryTalkVoice("story_v_out_121521", "121521088", "story_v_out_121521.awb")
				end

				arg_362_1:RecordContent(arg_362_1.text_.text)
			end

			local var_365_16 = math.max(var_365_7, arg_362_1.talkMaxDuration)

			if var_365_6 <= arg_362_1.time_ and arg_362_1.time_ < var_365_6 + var_365_16 then
				arg_362_1.typewritter.percent = (arg_362_1.time_ - var_365_6) / var_365_16

				arg_362_1.typewritter:SetDirty()
			end

			if arg_362_1.time_ >= var_365_6 + var_365_16 and arg_362_1.time_ < var_365_6 + var_365_16 + arg_365_0 then
				arg_362_1.typewritter.percent = 1

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(true)
			end
		end

		arg_362_1.nodeConfigList_ = {}

		arg_362_1:InitPlayNodeList()
	end,
	Play121521089 = function(arg_366_0, arg_366_1)
		arg_366_1.time_ = 0
		arg_366_1.frameCnt_ = 0
		arg_366_1.state_ = "playing"
		arg_366_1.curTalkId_ = 121521089
		arg_366_1.duration_ = 9.23

		local var_366_0 = {
			ja = 5.633,
			ko = 9.233,
			zh = 9.233
		}
		local var_366_1 = manager.audio:GetLocalizationFlag()

		if var_366_0[var_366_1] ~= nil then
			arg_366_1.duration_ = var_366_0[var_366_1]
		end

		SetActive(arg_366_1.tipsGo_, false)

		function arg_366_1.onSingleLineFinish_()
			arg_366_1.onSingleLineUpdate_ = nil
			arg_366_1.onSingleLineFinish_ = nil
			arg_366_1.state_ = "waiting"
		end

		function arg_366_1.playNext_(arg_368_0)
			if arg_368_0 == 1 then
				arg_366_0:Play121521090(arg_366_1)
			end
		end

		function arg_366_1.onSingleLineUpdate_(arg_369_0)
			local var_369_0 = 0
			local var_369_1 = 1.1

			if var_369_0 < arg_366_1.time_ and arg_366_1.time_ <= var_369_0 + arg_369_0 then
				arg_366_1.talkMaxDuration = 0
				arg_366_1.dialogCg_.alpha = 1

				arg_366_1.dialog_:SetActive(true)
				SetActive(arg_366_1.leftNameGo_, true)

				local var_369_2 = arg_366_1:FormatText(StoryNameCfg[381].name)

				arg_366_1.leftNameTxt_.text = var_369_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_366_1.leftNameTxt_.transform)

				arg_366_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_366_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_366_1:RecordName(arg_366_1.leftNameTxt_.text)
				SetActive(arg_366_1.iconTrs_.gameObject, false)
				arg_366_1.callingController_:SetSelectedState("normal")

				local var_369_3 = arg_366_1:GetWordFromCfg(121521089)
				local var_369_4 = arg_366_1:FormatText(var_369_3.content)

				arg_366_1.text_.text = var_369_4

				LuaForUtil.ClearLinePrefixSymbol(arg_366_1.text_)

				local var_369_5 = 44
				local var_369_6 = utf8.len(var_369_4)
				local var_369_7 = var_369_5 <= 0 and var_369_1 or var_369_1 * (var_369_6 / var_369_5)

				if var_369_7 > 0 and var_369_1 < var_369_7 then
					arg_366_1.talkMaxDuration = var_369_7

					if var_369_7 + var_369_0 > arg_366_1.duration_ then
						arg_366_1.duration_ = var_369_7 + var_369_0
					end
				end

				arg_366_1.text_.text = var_369_4
				arg_366_1.typewritter.percent = 0

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121521", "121521089", "story_v_out_121521.awb") ~= 0 then
					local var_369_8 = manager.audio:GetVoiceLength("story_v_out_121521", "121521089", "story_v_out_121521.awb") / 1000

					if var_369_8 + var_369_0 > arg_366_1.duration_ then
						arg_366_1.duration_ = var_369_8 + var_369_0
					end

					if var_369_3.prefab_name ~= "" and arg_366_1.actors_[var_369_3.prefab_name] ~= nil then
						local var_369_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_366_1.actors_[var_369_3.prefab_name].transform, "story_v_out_121521", "121521089", "story_v_out_121521.awb")

						arg_366_1:RecordAudio("121521089", var_369_9)
						arg_366_1:RecordAudio("121521089", var_369_9)
					else
						arg_366_1:AudioAction("play", "voice", "story_v_out_121521", "121521089", "story_v_out_121521.awb")
					end

					arg_366_1:RecordHistoryTalkVoice("story_v_out_121521", "121521089", "story_v_out_121521.awb")
				end

				arg_366_1:RecordContent(arg_366_1.text_.text)
			end

			local var_369_10 = math.max(var_369_1, arg_366_1.talkMaxDuration)

			if var_369_0 <= arg_366_1.time_ and arg_366_1.time_ < var_369_0 + var_369_10 then
				arg_366_1.typewritter.percent = (arg_366_1.time_ - var_369_0) / var_369_10

				arg_366_1.typewritter:SetDirty()
			end

			if arg_366_1.time_ >= var_369_0 + var_369_10 and arg_366_1.time_ < var_369_0 + var_369_10 + arg_369_0 then
				arg_366_1.typewritter.percent = 1

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(true)
			end
		end

		arg_366_1.nodeConfigList_ = {}

		arg_366_1:InitPlayNodeList()
	end,
	Play121521090 = function(arg_370_0, arg_370_1)
		arg_370_1.time_ = 0
		arg_370_1.frameCnt_ = 0
		arg_370_1.state_ = "playing"
		arg_370_1.curTalkId_ = 121521090
		arg_370_1.duration_ = 8.5

		local var_370_0 = {
			ja = 8.5,
			ko = 6.4,
			zh = 6.4
		}
		local var_370_1 = manager.audio:GetLocalizationFlag()

		if var_370_0[var_370_1] ~= nil then
			arg_370_1.duration_ = var_370_0[var_370_1]
		end

		SetActive(arg_370_1.tipsGo_, false)

		function arg_370_1.onSingleLineFinish_()
			arg_370_1.onSingleLineUpdate_ = nil
			arg_370_1.onSingleLineFinish_ = nil
			arg_370_1.state_ = "waiting"
		end

		function arg_370_1.playNext_(arg_372_0)
			if arg_372_0 == 1 then
				arg_370_0:Play121521091(arg_370_1)
			end
		end

		function arg_370_1.onSingleLineUpdate_(arg_373_0)
			local var_373_0 = arg_370_1.actors_["1075ui_story"].transform
			local var_373_1 = 0

			if var_373_1 < arg_370_1.time_ and arg_370_1.time_ <= var_373_1 + arg_373_0 then
				arg_370_1.var_.moveOldPos1075ui_story = var_373_0.localPosition
			end

			local var_373_2 = 0.001

			if var_373_1 <= arg_370_1.time_ and arg_370_1.time_ < var_373_1 + var_373_2 then
				local var_373_3 = (arg_370_1.time_ - var_373_1) / var_373_2
				local var_373_4 = Vector3.New(0, 100, 0)

				var_373_0.localPosition = Vector3.Lerp(arg_370_1.var_.moveOldPos1075ui_story, var_373_4, var_373_3)

				local var_373_5 = manager.ui.mainCamera.transform.position - var_373_0.position

				var_373_0.forward = Vector3.New(var_373_5.x, var_373_5.y, var_373_5.z)

				local var_373_6 = var_373_0.localEulerAngles

				var_373_6.z = 0
				var_373_6.x = 0
				var_373_0.localEulerAngles = var_373_6
			end

			if arg_370_1.time_ >= var_373_1 + var_373_2 and arg_370_1.time_ < var_373_1 + var_373_2 + arg_373_0 then
				var_373_0.localPosition = Vector3.New(0, 100, 0)

				local var_373_7 = manager.ui.mainCamera.transform.position - var_373_0.position

				var_373_0.forward = Vector3.New(var_373_7.x, var_373_7.y, var_373_7.z)

				local var_373_8 = var_373_0.localEulerAngles

				var_373_8.z = 0
				var_373_8.x = 0
				var_373_0.localEulerAngles = var_373_8
			end

			local var_373_9 = arg_370_1.actors_["1075ui_story"]
			local var_373_10 = 0

			if var_373_10 < arg_370_1.time_ and arg_370_1.time_ <= var_373_10 + arg_373_0 and not isNil(var_373_9) and arg_370_1.var_.characterEffect1075ui_story == nil then
				arg_370_1.var_.characterEffect1075ui_story = var_373_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_373_11 = 0.200000002980232

			if var_373_10 <= arg_370_1.time_ and arg_370_1.time_ < var_373_10 + var_373_11 and not isNil(var_373_9) then
				local var_373_12 = (arg_370_1.time_ - var_373_10) / var_373_11

				if arg_370_1.var_.characterEffect1075ui_story and not isNil(var_373_9) then
					local var_373_13 = Mathf.Lerp(0, 0.5, var_373_12)

					arg_370_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_370_1.var_.characterEffect1075ui_story.fillRatio = var_373_13
				end
			end

			if arg_370_1.time_ >= var_373_10 + var_373_11 and arg_370_1.time_ < var_373_10 + var_373_11 + arg_373_0 and not isNil(var_373_9) and arg_370_1.var_.characterEffect1075ui_story then
				local var_373_14 = 0.5

				arg_370_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_370_1.var_.characterEffect1075ui_story.fillRatio = var_373_14
			end

			local var_373_15 = manager.ui.mainCamera.transform
			local var_373_16 = 0

			if var_373_16 < arg_370_1.time_ and arg_370_1.time_ <= var_373_16 + arg_373_0 then
				arg_370_1.var_.shakeOldPos = var_373_15.localPosition
			end

			local var_373_17 = 0.6

			if var_373_16 <= arg_370_1.time_ and arg_370_1.time_ < var_373_16 + var_373_17 then
				local var_373_18 = (arg_370_1.time_ - var_373_16) / 0.066
				local var_373_19, var_373_20 = math.modf(var_373_18)

				var_373_15.localPosition = Vector3.New(var_373_20 * 0.13, var_373_20 * 0.13, var_373_20 * 0.13) + arg_370_1.var_.shakeOldPos
			end

			if arg_370_1.time_ >= var_373_16 + var_373_17 and arg_370_1.time_ < var_373_16 + var_373_17 + arg_373_0 then
				var_373_15.localPosition = arg_370_1.var_.shakeOldPos
			end

			local var_373_21 = 0

			if var_373_21 < arg_370_1.time_ and arg_370_1.time_ <= var_373_21 + arg_373_0 then
				arg_370_1.allBtn_.enabled = false
			end

			local var_373_22 = 0.6

			if arg_370_1.time_ >= var_373_21 + var_373_22 and arg_370_1.time_ < var_373_21 + var_373_22 + arg_373_0 then
				arg_370_1.allBtn_.enabled = true
			end

			local var_373_23 = 0
			local var_373_24 = 0.433333333333333

			if var_373_23 < arg_370_1.time_ and arg_370_1.time_ <= var_373_23 + arg_373_0 then
				local var_373_25 = "play"
				local var_373_26 = "effect"

				arg_370_1:AudioAction(var_373_25, var_373_26, "se_story_17", "se_story_17_messenger", "")
			end

			local var_373_27 = 0
			local var_373_28 = 0.7

			if var_373_27 < arg_370_1.time_ and arg_370_1.time_ <= var_373_27 + arg_373_0 then
				arg_370_1.talkMaxDuration = 0
				arg_370_1.dialogCg_.alpha = 1

				arg_370_1.dialog_:SetActive(true)
				SetActive(arg_370_1.leftNameGo_, true)

				local var_373_29 = arg_370_1:FormatText(StoryNameCfg[10].name)

				arg_370_1.leftNameTxt_.text = var_373_29

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_370_1.leftNameTxt_.transform)

				arg_370_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_370_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_370_1:RecordName(arg_370_1.leftNameTxt_.text)
				SetActive(arg_370_1.iconTrs_.gameObject, true)
				arg_370_1.iconController_:SetSelectedState("hero")

				arg_370_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_370_1.callingController_:SetSelectedState("normal")

				arg_370_1.keyicon_.color = Color.New(1, 1, 1)
				arg_370_1.icon_.color = Color.New(1, 1, 1)

				local var_373_30 = arg_370_1:GetWordFromCfg(121521090)
				local var_373_31 = arg_370_1:FormatText(var_373_30.content)

				arg_370_1.text_.text = var_373_31

				LuaForUtil.ClearLinePrefixSymbol(arg_370_1.text_)

				local var_373_32 = 28
				local var_373_33 = utf8.len(var_373_31)
				local var_373_34 = var_373_32 <= 0 and var_373_28 or var_373_28 * (var_373_33 / var_373_32)

				if var_373_34 > 0 and var_373_28 < var_373_34 then
					arg_370_1.talkMaxDuration = var_373_34

					if var_373_34 + var_373_27 > arg_370_1.duration_ then
						arg_370_1.duration_ = var_373_34 + var_373_27
					end
				end

				arg_370_1.text_.text = var_373_31
				arg_370_1.typewritter.percent = 0

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121521", "121521090", "story_v_out_121521.awb") ~= 0 then
					local var_373_35 = manager.audio:GetVoiceLength("story_v_out_121521", "121521090", "story_v_out_121521.awb") / 1000

					if var_373_35 + var_373_27 > arg_370_1.duration_ then
						arg_370_1.duration_ = var_373_35 + var_373_27
					end

					if var_373_30.prefab_name ~= "" and arg_370_1.actors_[var_373_30.prefab_name] ~= nil then
						local var_373_36 = LuaForUtil.PlayVoiceWithCriLipsync(arg_370_1.actors_[var_373_30.prefab_name].transform, "story_v_out_121521", "121521090", "story_v_out_121521.awb")

						arg_370_1:RecordAudio("121521090", var_373_36)
						arg_370_1:RecordAudio("121521090", var_373_36)
					else
						arg_370_1:AudioAction("play", "voice", "story_v_out_121521", "121521090", "story_v_out_121521.awb")
					end

					arg_370_1:RecordHistoryTalkVoice("story_v_out_121521", "121521090", "story_v_out_121521.awb")
				end

				arg_370_1:RecordContent(arg_370_1.text_.text)
			end

			local var_373_37 = math.max(var_373_28, arg_370_1.talkMaxDuration)

			if var_373_27 <= arg_370_1.time_ and arg_370_1.time_ < var_373_27 + var_373_37 then
				arg_370_1.typewritter.percent = (arg_370_1.time_ - var_373_27) / var_373_37

				arg_370_1.typewritter:SetDirty()
			end

			if arg_370_1.time_ >= var_373_27 + var_373_37 and arg_370_1.time_ < var_373_27 + var_373_37 + arg_373_0 then
				arg_370_1.typewritter.percent = 1

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(true)
			end
		end

		arg_370_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_370_1:InitPlayNodeList()
	end,
	Play121521091 = function(arg_374_0, arg_374_1)
		arg_374_1.time_ = 0
		arg_374_1.frameCnt_ = 0
		arg_374_1.state_ = "playing"
		arg_374_1.curTalkId_ = 121521091
		arg_374_1.duration_ = 5.3

		local var_374_0 = {
			ja = 5.3,
			ko = 4.066,
			zh = 4.066
		}
		local var_374_1 = manager.audio:GetLocalizationFlag()

		if var_374_0[var_374_1] ~= nil then
			arg_374_1.duration_ = var_374_0[var_374_1]
		end

		SetActive(arg_374_1.tipsGo_, false)

		function arg_374_1.onSingleLineFinish_()
			arg_374_1.onSingleLineUpdate_ = nil
			arg_374_1.onSingleLineFinish_ = nil
			arg_374_1.state_ = "waiting"
		end

		function arg_374_1.playNext_(arg_376_0)
			if arg_376_0 == 1 then
				arg_374_0:Play121521092(arg_374_1)
			end
		end

		function arg_374_1.onSingleLineUpdate_(arg_377_0)
			local var_377_0 = 0
			local var_377_1 = 0.633333333333333

			if var_377_0 < arg_374_1.time_ and arg_374_1.time_ <= var_377_0 + arg_377_0 then
				local var_377_2 = "play"
				local var_377_3 = "effect"

				arg_374_1:AudioAction(var_377_2, var_377_3, "se_story_121_04", "se_story_121_04_warnning", "")
			end

			local var_377_4 = 0
			local var_377_5 = 0.425

			if var_377_4 < arg_374_1.time_ and arg_374_1.time_ <= var_377_4 + arg_377_0 then
				arg_374_1.talkMaxDuration = 0
				arg_374_1.dialogCg_.alpha = 1

				arg_374_1.dialog_:SetActive(true)
				SetActive(arg_374_1.leftNameGo_, true)

				local var_377_6 = arg_374_1:FormatText(StoryNameCfg[10].name)

				arg_374_1.leftNameTxt_.text = var_377_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_374_1.leftNameTxt_.transform)

				arg_374_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_374_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_374_1:RecordName(arg_374_1.leftNameTxt_.text)
				SetActive(arg_374_1.iconTrs_.gameObject, true)
				arg_374_1.iconController_:SetSelectedState("hero")

				arg_374_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_374_1.callingController_:SetSelectedState("normal")

				arg_374_1.keyicon_.color = Color.New(1, 1, 1)
				arg_374_1.icon_.color = Color.New(1, 1, 1)

				local var_377_7 = arg_374_1:GetWordFromCfg(121521091)
				local var_377_8 = arg_374_1:FormatText(var_377_7.content)

				arg_374_1.text_.text = var_377_8

				LuaForUtil.ClearLinePrefixSymbol(arg_374_1.text_)

				local var_377_9 = 17
				local var_377_10 = utf8.len(var_377_8)
				local var_377_11 = var_377_9 <= 0 and var_377_5 or var_377_5 * (var_377_10 / var_377_9)

				if var_377_11 > 0 and var_377_5 < var_377_11 then
					arg_374_1.talkMaxDuration = var_377_11

					if var_377_11 + var_377_4 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_11 + var_377_4
					end
				end

				arg_374_1.text_.text = var_377_8
				arg_374_1.typewritter.percent = 0

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121521", "121521091", "story_v_out_121521.awb") ~= 0 then
					local var_377_12 = manager.audio:GetVoiceLength("story_v_out_121521", "121521091", "story_v_out_121521.awb") / 1000

					if var_377_12 + var_377_4 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_12 + var_377_4
					end

					if var_377_7.prefab_name ~= "" and arg_374_1.actors_[var_377_7.prefab_name] ~= nil then
						local var_377_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_374_1.actors_[var_377_7.prefab_name].transform, "story_v_out_121521", "121521091", "story_v_out_121521.awb")

						arg_374_1:RecordAudio("121521091", var_377_13)
						arg_374_1:RecordAudio("121521091", var_377_13)
					else
						arg_374_1:AudioAction("play", "voice", "story_v_out_121521", "121521091", "story_v_out_121521.awb")
					end

					arg_374_1:RecordHistoryTalkVoice("story_v_out_121521", "121521091", "story_v_out_121521.awb")
				end

				arg_374_1:RecordContent(arg_374_1.text_.text)
			end

			local var_377_14 = math.max(var_377_5, arg_374_1.talkMaxDuration)

			if var_377_4 <= arg_374_1.time_ and arg_374_1.time_ < var_377_4 + var_377_14 then
				arg_374_1.typewritter.percent = (arg_374_1.time_ - var_377_4) / var_377_14

				arg_374_1.typewritter:SetDirty()
			end

			if arg_374_1.time_ >= var_377_4 + var_377_14 and arg_374_1.time_ < var_377_4 + var_377_14 + arg_377_0 then
				arg_374_1.typewritter.percent = 1

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(true)
			end
		end

		arg_374_1.nodeConfigList_ = {}

		arg_374_1:InitPlayNodeList()
	end,
	Play121521092 = function(arg_378_0, arg_378_1)
		arg_378_1.time_ = 0
		arg_378_1.frameCnt_ = 0
		arg_378_1.state_ = "playing"
		arg_378_1.curTalkId_ = 121521092
		arg_378_1.duration_ = 2.63

		local var_378_0 = {
			ja = 2.633,
			ko = 1.999999999999,
			zh = 1.999999999999
		}
		local var_378_1 = manager.audio:GetLocalizationFlag()

		if var_378_0[var_378_1] ~= nil then
			arg_378_1.duration_ = var_378_0[var_378_1]
		end

		SetActive(arg_378_1.tipsGo_, false)

		function arg_378_1.onSingleLineFinish_()
			arg_378_1.onSingleLineUpdate_ = nil
			arg_378_1.onSingleLineFinish_ = nil
			arg_378_1.state_ = "waiting"
		end

		function arg_378_1.playNext_(arg_380_0)
			if arg_380_0 == 1 then
				arg_378_0:Play121521093(arg_378_1)
			end
		end

		function arg_378_1.onSingleLineUpdate_(arg_381_0)
			local var_381_0 = arg_378_1.actors_["1084ui_story"].transform
			local var_381_1 = 0

			if var_381_1 < arg_378_1.time_ and arg_378_1.time_ <= var_381_1 + arg_381_0 then
				arg_378_1.var_.moveOldPos1084ui_story = var_381_0.localPosition
			end

			local var_381_2 = 0.001

			if var_381_1 <= arg_378_1.time_ and arg_378_1.time_ < var_381_1 + var_381_2 then
				local var_381_3 = (arg_378_1.time_ - var_381_1) / var_381_2
				local var_381_4 = Vector3.New(0, -0.97, -6)

				var_381_0.localPosition = Vector3.Lerp(arg_378_1.var_.moveOldPos1084ui_story, var_381_4, var_381_3)

				local var_381_5 = manager.ui.mainCamera.transform.position - var_381_0.position

				var_381_0.forward = Vector3.New(var_381_5.x, var_381_5.y, var_381_5.z)

				local var_381_6 = var_381_0.localEulerAngles

				var_381_6.z = 0
				var_381_6.x = 0
				var_381_0.localEulerAngles = var_381_6
			end

			if arg_378_1.time_ >= var_381_1 + var_381_2 and arg_378_1.time_ < var_381_1 + var_381_2 + arg_381_0 then
				var_381_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_381_7 = manager.ui.mainCamera.transform.position - var_381_0.position

				var_381_0.forward = Vector3.New(var_381_7.x, var_381_7.y, var_381_7.z)

				local var_381_8 = var_381_0.localEulerAngles

				var_381_8.z = 0
				var_381_8.x = 0
				var_381_0.localEulerAngles = var_381_8
			end

			local var_381_9 = arg_378_1.actors_["1084ui_story"]
			local var_381_10 = 0

			if var_381_10 < arg_378_1.time_ and arg_378_1.time_ <= var_381_10 + arg_381_0 and not isNil(var_381_9) and arg_378_1.var_.characterEffect1084ui_story == nil then
				arg_378_1.var_.characterEffect1084ui_story = var_381_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_381_11 = 0.200000002980232

			if var_381_10 <= arg_378_1.time_ and arg_378_1.time_ < var_381_10 + var_381_11 and not isNil(var_381_9) then
				local var_381_12 = (arg_378_1.time_ - var_381_10) / var_381_11

				if arg_378_1.var_.characterEffect1084ui_story and not isNil(var_381_9) then
					arg_378_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_378_1.time_ >= var_381_10 + var_381_11 and arg_378_1.time_ < var_381_10 + var_381_11 + arg_381_0 and not isNil(var_381_9) and arg_378_1.var_.characterEffect1084ui_story then
				arg_378_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_381_13 = 0

			if var_381_13 < arg_378_1.time_ and arg_378_1.time_ <= var_381_13 + arg_381_0 then
				arg_378_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			local var_381_14 = 0

			if var_381_14 < arg_378_1.time_ and arg_378_1.time_ <= var_381_14 + arg_381_0 then
				arg_378_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_381_15 = 0
			local var_381_16 = 0.1

			if var_381_15 < arg_378_1.time_ and arg_378_1.time_ <= var_381_15 + arg_381_0 then
				arg_378_1.talkMaxDuration = 0
				arg_378_1.dialogCg_.alpha = 1

				arg_378_1.dialog_:SetActive(true)
				SetActive(arg_378_1.leftNameGo_, true)

				local var_381_17 = arg_378_1:FormatText(StoryNameCfg[6].name)

				arg_378_1.leftNameTxt_.text = var_381_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_378_1.leftNameTxt_.transform)

				arg_378_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_378_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_378_1:RecordName(arg_378_1.leftNameTxt_.text)
				SetActive(arg_378_1.iconTrs_.gameObject, false)
				arg_378_1.callingController_:SetSelectedState("normal")

				local var_381_18 = arg_378_1:GetWordFromCfg(121521092)
				local var_381_19 = arg_378_1:FormatText(var_381_18.content)

				arg_378_1.text_.text = var_381_19

				LuaForUtil.ClearLinePrefixSymbol(arg_378_1.text_)

				local var_381_20 = 4
				local var_381_21 = utf8.len(var_381_19)
				local var_381_22 = var_381_20 <= 0 and var_381_16 or var_381_16 * (var_381_21 / var_381_20)

				if var_381_22 > 0 and var_381_16 < var_381_22 then
					arg_378_1.talkMaxDuration = var_381_22

					if var_381_22 + var_381_15 > arg_378_1.duration_ then
						arg_378_1.duration_ = var_381_22 + var_381_15
					end
				end

				arg_378_1.text_.text = var_381_19
				arg_378_1.typewritter.percent = 0

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121521", "121521092", "story_v_out_121521.awb") ~= 0 then
					local var_381_23 = manager.audio:GetVoiceLength("story_v_out_121521", "121521092", "story_v_out_121521.awb") / 1000

					if var_381_23 + var_381_15 > arg_378_1.duration_ then
						arg_378_1.duration_ = var_381_23 + var_381_15
					end

					if var_381_18.prefab_name ~= "" and arg_378_1.actors_[var_381_18.prefab_name] ~= nil then
						local var_381_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_378_1.actors_[var_381_18.prefab_name].transform, "story_v_out_121521", "121521092", "story_v_out_121521.awb")

						arg_378_1:RecordAudio("121521092", var_381_24)
						arg_378_1:RecordAudio("121521092", var_381_24)
					else
						arg_378_1:AudioAction("play", "voice", "story_v_out_121521", "121521092", "story_v_out_121521.awb")
					end

					arg_378_1:RecordHistoryTalkVoice("story_v_out_121521", "121521092", "story_v_out_121521.awb")
				end

				arg_378_1:RecordContent(arg_378_1.text_.text)
			end

			local var_381_25 = math.max(var_381_16, arg_378_1.talkMaxDuration)

			if var_381_15 <= arg_378_1.time_ and arg_378_1.time_ < var_381_15 + var_381_25 then
				arg_378_1.typewritter.percent = (arg_378_1.time_ - var_381_15) / var_381_25

				arg_378_1.typewritter:SetDirty()
			end

			if arg_378_1.time_ >= var_381_15 + var_381_25 and arg_378_1.time_ < var_381_15 + var_381_25 + arg_381_0 then
				arg_378_1.typewritter.percent = 1

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(true)
			end
		end

		arg_378_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_378_1:InitPlayNodeList()
	end,
	Play121521093 = function(arg_382_0, arg_382_1)
		arg_382_1.time_ = 0
		arg_382_1.frameCnt_ = 0
		arg_382_1.state_ = "playing"
		arg_382_1.curTalkId_ = 121521093
		arg_382_1.duration_ = 5

		SetActive(arg_382_1.tipsGo_, false)

		function arg_382_1.onSingleLineFinish_()
			arg_382_1.onSingleLineUpdate_ = nil
			arg_382_1.onSingleLineFinish_ = nil
			arg_382_1.state_ = "waiting"
		end

		function arg_382_1.playNext_(arg_384_0)
			if arg_384_0 == 1 then
				arg_382_0:Play121521094(arg_382_1)
			end
		end

		function arg_382_1.onSingleLineUpdate_(arg_385_0)
			local var_385_0 = arg_382_1.actors_["1084ui_story"].transform
			local var_385_1 = 0

			if var_385_1 < arg_382_1.time_ and arg_382_1.time_ <= var_385_1 + arg_385_0 then
				arg_382_1.var_.moveOldPos1084ui_story = var_385_0.localPosition
			end

			local var_385_2 = 0.001

			if var_385_1 <= arg_382_1.time_ and arg_382_1.time_ < var_385_1 + var_385_2 then
				local var_385_3 = (arg_382_1.time_ - var_385_1) / var_385_2
				local var_385_4 = Vector3.New(0, 100, 0)

				var_385_0.localPosition = Vector3.Lerp(arg_382_1.var_.moveOldPos1084ui_story, var_385_4, var_385_3)

				local var_385_5 = manager.ui.mainCamera.transform.position - var_385_0.position

				var_385_0.forward = Vector3.New(var_385_5.x, var_385_5.y, var_385_5.z)

				local var_385_6 = var_385_0.localEulerAngles

				var_385_6.z = 0
				var_385_6.x = 0
				var_385_0.localEulerAngles = var_385_6
			end

			if arg_382_1.time_ >= var_385_1 + var_385_2 and arg_382_1.time_ < var_385_1 + var_385_2 + arg_385_0 then
				var_385_0.localPosition = Vector3.New(0, 100, 0)

				local var_385_7 = manager.ui.mainCamera.transform.position - var_385_0.position

				var_385_0.forward = Vector3.New(var_385_7.x, var_385_7.y, var_385_7.z)

				local var_385_8 = var_385_0.localEulerAngles

				var_385_8.z = 0
				var_385_8.x = 0
				var_385_0.localEulerAngles = var_385_8
			end

			local var_385_9 = arg_382_1.actors_["1084ui_story"]
			local var_385_10 = 0

			if var_385_10 < arg_382_1.time_ and arg_382_1.time_ <= var_385_10 + arg_385_0 and not isNil(var_385_9) and arg_382_1.var_.characterEffect1084ui_story == nil then
				arg_382_1.var_.characterEffect1084ui_story = var_385_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_385_11 = 0.200000002980232

			if var_385_10 <= arg_382_1.time_ and arg_382_1.time_ < var_385_10 + var_385_11 and not isNil(var_385_9) then
				local var_385_12 = (arg_382_1.time_ - var_385_10) / var_385_11

				if arg_382_1.var_.characterEffect1084ui_story and not isNil(var_385_9) then
					local var_385_13 = Mathf.Lerp(0, 0.5, var_385_12)

					arg_382_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_382_1.var_.characterEffect1084ui_story.fillRatio = var_385_13
				end
			end

			if arg_382_1.time_ >= var_385_10 + var_385_11 and arg_382_1.time_ < var_385_10 + var_385_11 + arg_385_0 and not isNil(var_385_9) and arg_382_1.var_.characterEffect1084ui_story then
				local var_385_14 = 0.5

				arg_382_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_382_1.var_.characterEffect1084ui_story.fillRatio = var_385_14
			end

			local var_385_15 = 0
			local var_385_16 = 1.25

			if var_385_15 < arg_382_1.time_ and arg_382_1.time_ <= var_385_15 + arg_385_0 then
				arg_382_1.talkMaxDuration = 0
				arg_382_1.dialogCg_.alpha = 1

				arg_382_1.dialog_:SetActive(true)
				SetActive(arg_382_1.leftNameGo_, false)

				arg_382_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_382_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_382_1:RecordName(arg_382_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_382_1.iconTrs_.gameObject, false)
				arg_382_1.callingController_:SetSelectedState("normal")

				local var_385_17 = arg_382_1:GetWordFromCfg(121521093)
				local var_385_18 = arg_382_1:FormatText(var_385_17.content)

				arg_382_1.text_.text = var_385_18

				LuaForUtil.ClearLinePrefixSymbol(arg_382_1.text_)

				local var_385_19 = 50
				local var_385_20 = utf8.len(var_385_18)
				local var_385_21 = var_385_19 <= 0 and var_385_16 or var_385_16 * (var_385_20 / var_385_19)

				if var_385_21 > 0 and var_385_16 < var_385_21 then
					arg_382_1.talkMaxDuration = var_385_21

					if var_385_21 + var_385_15 > arg_382_1.duration_ then
						arg_382_1.duration_ = var_385_21 + var_385_15
					end
				end

				arg_382_1.text_.text = var_385_18
				arg_382_1.typewritter.percent = 0

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(false)
				arg_382_1:RecordContent(arg_382_1.text_.text)
			end

			local var_385_22 = math.max(var_385_16, arg_382_1.talkMaxDuration)

			if var_385_15 <= arg_382_1.time_ and arg_382_1.time_ < var_385_15 + var_385_22 then
				arg_382_1.typewritter.percent = (arg_382_1.time_ - var_385_15) / var_385_22

				arg_382_1.typewritter:SetDirty()
			end

			if arg_382_1.time_ >= var_385_15 + var_385_22 and arg_382_1.time_ < var_385_15 + var_385_22 + arg_385_0 then
				arg_382_1.typewritter.percent = 1

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(true)
			end
		end

		arg_382_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_382_1:InitPlayNodeList()
	end,
	Play121521094 = function(arg_386_0, arg_386_1)
		arg_386_1.time_ = 0
		arg_386_1.frameCnt_ = 0
		arg_386_1.state_ = "playing"
		arg_386_1.curTalkId_ = 121521094
		arg_386_1.duration_ = 5

		SetActive(arg_386_1.tipsGo_, false)

		function arg_386_1.onSingleLineFinish_()
			arg_386_1.onSingleLineUpdate_ = nil
			arg_386_1.onSingleLineFinish_ = nil
			arg_386_1.state_ = "waiting"
		end

		function arg_386_1.playNext_(arg_388_0)
			if arg_388_0 == 1 then
				arg_386_0:Play121521095(arg_386_1)
			end
		end

		function arg_386_1.onSingleLineUpdate_(arg_389_0)
			local var_389_0 = 0.7
			local var_389_1 = 0.166666666666667

			if var_389_0 < arg_386_1.time_ and arg_386_1.time_ <= var_389_0 + arg_389_0 then
				local var_389_2 = "play"
				local var_389_3 = "effect"

				arg_386_1:AudioAction(var_389_2, var_389_3, "se_story_121_04", "se_story_121_04_monsterappear", "")
			end

			local var_389_4 = 0
			local var_389_5 = 0.65

			if var_389_4 < arg_386_1.time_ and arg_386_1.time_ <= var_389_4 + arg_389_0 then
				arg_386_1.talkMaxDuration = 0
				arg_386_1.dialogCg_.alpha = 1

				arg_386_1.dialog_:SetActive(true)
				SetActive(arg_386_1.leftNameGo_, true)

				local var_389_6 = arg_386_1:FormatText(StoryNameCfg[7].name)

				arg_386_1.leftNameTxt_.text = var_389_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_386_1.leftNameTxt_.transform)

				arg_386_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_386_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_386_1:RecordName(arg_386_1.leftNameTxt_.text)
				SetActive(arg_386_1.iconTrs_.gameObject, true)
				arg_386_1.iconController_:SetSelectedState("hero")

				arg_386_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_386_1.callingController_:SetSelectedState("normal")

				arg_386_1.keyicon_.color = Color.New(1, 1, 1)
				arg_386_1.icon_.color = Color.New(1, 1, 1)

				local var_389_7 = arg_386_1:GetWordFromCfg(121521094)
				local var_389_8 = arg_386_1:FormatText(var_389_7.content)

				arg_386_1.text_.text = var_389_8

				LuaForUtil.ClearLinePrefixSymbol(arg_386_1.text_)

				local var_389_9 = 26
				local var_389_10 = utf8.len(var_389_8)
				local var_389_11 = var_389_9 <= 0 and var_389_5 or var_389_5 * (var_389_10 / var_389_9)

				if var_389_11 > 0 and var_389_5 < var_389_11 then
					arg_386_1.talkMaxDuration = var_389_11

					if var_389_11 + var_389_4 > arg_386_1.duration_ then
						arg_386_1.duration_ = var_389_11 + var_389_4
					end
				end

				arg_386_1.text_.text = var_389_8
				arg_386_1.typewritter.percent = 0

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(false)
				arg_386_1:RecordContent(arg_386_1.text_.text)
			end

			local var_389_12 = math.max(var_389_5, arg_386_1.talkMaxDuration)

			if var_389_4 <= arg_386_1.time_ and arg_386_1.time_ < var_389_4 + var_389_12 then
				arg_386_1.typewritter.percent = (arg_386_1.time_ - var_389_4) / var_389_12

				arg_386_1.typewritter:SetDirty()
			end

			if arg_386_1.time_ >= var_389_4 + var_389_12 and arg_386_1.time_ < var_389_4 + var_389_12 + arg_389_0 then
				arg_386_1.typewritter.percent = 1

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(true)
			end
		end

		arg_386_1.nodeConfigList_ = {}

		arg_386_1:InitPlayNodeList()
	end,
	Play121521095 = function(arg_390_0, arg_390_1)
		arg_390_1.time_ = 0
		arg_390_1.frameCnt_ = 0
		arg_390_1.state_ = "playing"
		arg_390_1.curTalkId_ = 121521095
		arg_390_1.duration_ = 7

		SetActive(arg_390_1.tipsGo_, false)

		function arg_390_1.onSingleLineFinish_()
			arg_390_1.onSingleLineUpdate_ = nil
			arg_390_1.onSingleLineFinish_ = nil
			arg_390_1.state_ = "waiting"
		end

		function arg_390_1.playNext_(arg_392_0)
			if arg_392_0 == 1 then
				arg_390_0:Play121521096(arg_390_1)
			end
		end

		function arg_390_1.onSingleLineUpdate_(arg_393_0)
			local var_393_0 = 0

			if var_393_0 < arg_390_1.time_ and arg_390_1.time_ <= var_393_0 + arg_393_0 then
				arg_390_1.mask_.enabled = true
				arg_390_1.mask_.raycastTarget = true

				arg_390_1:SetGaussion(false)
			end

			local var_393_1 = 2

			if var_393_0 <= arg_390_1.time_ and arg_390_1.time_ < var_393_0 + var_393_1 then
				local var_393_2 = (arg_390_1.time_ - var_393_0) / var_393_1
				local var_393_3 = Color.New(1, 1, 1)

				var_393_3.a = Mathf.Lerp(1, 0, var_393_2)
				arg_390_1.mask_.color = var_393_3
			end

			if arg_390_1.time_ >= var_393_0 + var_393_1 and arg_390_1.time_ < var_393_0 + var_393_1 + arg_393_0 then
				local var_393_4 = Color.New(1, 1, 1)
				local var_393_5 = 0

				arg_390_1.mask_.enabled = false
				var_393_4.a = var_393_5
				arg_390_1.mask_.color = var_393_4
			end

			local var_393_6 = manager.ui.mainCamera.transform
			local var_393_7 = 0

			if var_393_7 < arg_390_1.time_ and arg_390_1.time_ <= var_393_7 + arg_393_0 then
				arg_390_1.var_.shakeOldPos = var_393_6.localPosition
			end

			local var_393_8 = 2

			if var_393_7 <= arg_390_1.time_ and arg_390_1.time_ < var_393_7 + var_393_8 then
				local var_393_9 = (arg_390_1.time_ - var_393_7) / 0.066
				local var_393_10, var_393_11 = math.modf(var_393_9)

				var_393_6.localPosition = Vector3.New(var_393_11 * 0.13, var_393_11 * 0.13, var_393_11 * 0.13) + arg_390_1.var_.shakeOldPos
			end

			if arg_390_1.time_ >= var_393_7 + var_393_8 and arg_390_1.time_ < var_393_7 + var_393_8 + arg_393_0 then
				var_393_6.localPosition = arg_390_1.var_.shakeOldPos
			end

			local var_393_12 = manager.ui.mainCamera.transform
			local var_393_13 = 2

			if var_393_13 < arg_390_1.time_ and arg_390_1.time_ <= var_393_13 + arg_393_0 then
				local var_393_14 = arg_390_1.var_.effectkuangzhen1
				local var_393_15
				local var_393_16 = var_393_12

				if not var_393_14 then
					var_393_14 = Object.Instantiate(Asset.Load("Effect/Scene/fx_ripple"), var_393_16)
					var_393_14.name = "kuangzhen1"
					arg_390_1.var_.effectkuangzhen1 = var_393_14
				else
					var_393_14.transform:SetParent(var_393_16)
				end

				var_393_14.transform.localPosition = Vector3.New(0, 0, 0)
				var_393_14.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_393_17 = 2
			local var_393_18 = 1.425

			if var_393_17 < arg_390_1.time_ and arg_390_1.time_ <= var_393_17 + arg_393_0 then
				arg_390_1.talkMaxDuration = 0
				arg_390_1.dialogCg_.alpha = 1

				arg_390_1.dialog_:SetActive(true)
				SetActive(arg_390_1.leftNameGo_, false)

				arg_390_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_390_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_390_1:RecordName(arg_390_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_390_1.iconTrs_.gameObject, false)
				arg_390_1.callingController_:SetSelectedState("normal")

				local var_393_19 = arg_390_1:GetWordFromCfg(121521095)
				local var_393_20 = arg_390_1:FormatText(var_393_19.content)

				arg_390_1.text_.text = var_393_20

				LuaForUtil.ClearLinePrefixSymbol(arg_390_1.text_)

				local var_393_21 = 57
				local var_393_22 = utf8.len(var_393_20)
				local var_393_23 = var_393_21 <= 0 and var_393_18 or var_393_18 * (var_393_22 / var_393_21)

				if var_393_23 > 0 and var_393_18 < var_393_23 then
					arg_390_1.talkMaxDuration = var_393_23

					if var_393_23 + var_393_17 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_23 + var_393_17
					end
				end

				arg_390_1.text_.text = var_393_20
				arg_390_1.typewritter.percent = 0

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(false)
				arg_390_1:RecordContent(arg_390_1.text_.text)
			end

			local var_393_24 = math.max(var_393_18, arg_390_1.talkMaxDuration)

			if var_393_17 <= arg_390_1.time_ and arg_390_1.time_ < var_393_17 + var_393_24 then
				arg_390_1.typewritter.percent = (arg_390_1.time_ - var_393_17) / var_393_24

				arg_390_1.typewritter:SetDirty()
			end

			if arg_390_1.time_ >= var_393_17 + var_393_24 and arg_390_1.time_ < var_393_17 + var_393_24 + arg_393_0 then
				arg_390_1.typewritter.percent = 1

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(true)
			end
		end

		arg_390_1.nodeConfigList_ = {}

		arg_390_1:InitPlayNodeList()
	end,
	Play121521096 = function(arg_394_0, arg_394_1)
		arg_394_1.time_ = 0
		arg_394_1.frameCnt_ = 0
		arg_394_1.state_ = "playing"
		arg_394_1.curTalkId_ = 121521096
		arg_394_1.duration_ = 7

		SetActive(arg_394_1.tipsGo_, false)

		function arg_394_1.onSingleLineFinish_()
			arg_394_1.onSingleLineUpdate_ = nil
			arg_394_1.onSingleLineFinish_ = nil
			arg_394_1.state_ = "waiting"
			arg_394_1.auto_ = false
		end

		function arg_394_1.playNext_(arg_396_0)
			arg_394_1.onStoryFinished_()
		end

		function arg_394_1.onSingleLineUpdate_(arg_397_0)
			local var_397_0 = 2

			if var_397_0 < arg_394_1.time_ and arg_394_1.time_ <= var_397_0 + arg_397_0 then
				local var_397_1 = manager.ui.mainCamera.transform.localPosition
				local var_397_2 = Vector3.New(0, 0, 10) + Vector3.New(var_397_1.x, var_397_1.y, 0)
				local var_397_3 = arg_394_1.bgs_.STblack

				var_397_3.transform.localPosition = var_397_2
				var_397_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_397_4 = var_397_3:GetComponent("SpriteRenderer")

				if var_397_4 and var_397_4.sprite then
					local var_397_5 = (var_397_3.transform.localPosition - var_397_1).z
					local var_397_6 = manager.ui.mainCameraCom_
					local var_397_7 = 2 * var_397_5 * Mathf.Tan(var_397_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_397_8 = var_397_7 * var_397_6.aspect
					local var_397_9 = var_397_4.sprite.bounds.size.x
					local var_397_10 = var_397_4.sprite.bounds.size.y
					local var_397_11 = var_397_8 / var_397_9
					local var_397_12 = var_397_7 / var_397_10
					local var_397_13 = var_397_12 < var_397_11 and var_397_11 or var_397_12

					var_397_3.transform.localScale = Vector3.New(var_397_13, var_397_13, 0)
				end

				for iter_397_0, iter_397_1 in pairs(arg_394_1.bgs_) do
					if iter_397_0 ~= "STblack" then
						iter_397_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_397_14 = 0

			if var_397_14 < arg_394_1.time_ and arg_394_1.time_ <= var_397_14 + arg_397_0 then
				arg_394_1.mask_.enabled = true
				arg_394_1.mask_.raycastTarget = true

				arg_394_1:SetGaussion(false)
			end

			local var_397_15 = 2

			if var_397_14 <= arg_394_1.time_ and arg_394_1.time_ < var_397_14 + var_397_15 then
				local var_397_16 = (arg_394_1.time_ - var_397_14) / var_397_15
				local var_397_17 = Color.New(0, 0, 0)

				var_397_17.a = Mathf.Lerp(0, 1, var_397_16)
				arg_394_1.mask_.color = var_397_17
			end

			if arg_394_1.time_ >= var_397_14 + var_397_15 and arg_394_1.time_ < var_397_14 + var_397_15 + arg_397_0 then
				local var_397_18 = Color.New(0, 0, 0)

				var_397_18.a = 1
				arg_394_1.mask_.color = var_397_18
			end

			local var_397_19 = 2

			if var_397_19 < arg_394_1.time_ and arg_394_1.time_ <= var_397_19 + arg_397_0 then
				arg_394_1.mask_.enabled = true
				arg_394_1.mask_.raycastTarget = true

				arg_394_1:SetGaussion(false)
			end

			local var_397_20 = 0.5

			if var_397_19 <= arg_394_1.time_ and arg_394_1.time_ < var_397_19 + var_397_20 then
				local var_397_21 = (arg_394_1.time_ - var_397_19) / var_397_20
				local var_397_22 = Color.New(0, 0, 0)

				var_397_22.a = Mathf.Lerp(1, 0, var_397_21)
				arg_394_1.mask_.color = var_397_22
			end

			if arg_394_1.time_ >= var_397_19 + var_397_20 and arg_394_1.time_ < var_397_19 + var_397_20 + arg_397_0 then
				local var_397_23 = Color.New(0, 0, 0)
				local var_397_24 = 0

				arg_394_1.mask_.enabled = false
				var_397_23.a = var_397_24
				arg_394_1.mask_.color = var_397_23
			end

			local var_397_25 = manager.ui.mainCamera.transform
			local var_397_26 = 2

			if var_397_26 < arg_394_1.time_ and arg_394_1.time_ <= var_397_26 + arg_397_0 then
				local var_397_27 = arg_394_1.var_.effectkuaangzhen2

				if var_397_27 then
					Object.Destroy(var_397_27)

					arg_394_1.var_.effectkuaangzhen2 = nil
				end
			end

			if arg_394_1.frameCnt_ <= 1 then
				arg_394_1.dialog_:SetActive(false)
			end

			local var_397_28 = 2
			local var_397_29 = 0.125

			if var_397_28 < arg_394_1.time_ and arg_394_1.time_ <= var_397_28 + arg_397_0 then
				arg_394_1.talkMaxDuration = 0

				arg_394_1.dialog_:SetActive(true)

				arg_394_1.dialogCg_.alpha = 0

				local var_397_30 = LeanTween.value(arg_394_1.dialog_, 0, 1, 0.3)

				var_397_30:setOnUpdate(LuaHelper.FloatAction(function(arg_398_0)
					arg_394_1.dialogCg_.alpha = arg_398_0
				end))
				var_397_30:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_394_1.dialog_)
					var_397_30:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_394_1.duration_ = arg_394_1.duration_ + 0.3

				SetActive(arg_394_1.leftNameGo_, false)

				arg_394_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_394_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_394_1:RecordName(arg_394_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_394_1.iconTrs_.gameObject, false)
				arg_394_1.callingController_:SetSelectedState("normal")

				local var_397_31 = arg_394_1:GetWordFromCfg(121521096)
				local var_397_32 = arg_394_1:FormatText(var_397_31.content)

				arg_394_1.text_.text = var_397_32

				LuaForUtil.ClearLinePrefixSymbol(arg_394_1.text_)

				local var_397_33 = 5
				local var_397_34 = utf8.len(var_397_32)
				local var_397_35 = var_397_33 <= 0 and var_397_29 or var_397_29 * (var_397_34 / var_397_33)

				if var_397_35 > 0 and var_397_29 < var_397_35 then
					arg_394_1.talkMaxDuration = var_397_35
					var_397_28 = var_397_28 + 0.3

					if var_397_35 + var_397_28 > arg_394_1.duration_ then
						arg_394_1.duration_ = var_397_35 + var_397_28
					end
				end

				arg_394_1.text_.text = var_397_32
				arg_394_1.typewritter.percent = 0

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(false)
				arg_394_1:RecordContent(arg_394_1.text_.text)
			end

			local var_397_36 = var_397_28 + 0.3
			local var_397_37 = math.max(var_397_29, arg_394_1.talkMaxDuration)

			if var_397_36 <= arg_394_1.time_ and arg_394_1.time_ < var_397_36 + var_397_37 then
				arg_394_1.typewritter.percent = (arg_394_1.time_ - var_397_36) / var_397_37

				arg_394_1.typewritter:SetDirty()
			end

			if arg_394_1.time_ >= var_397_36 + var_397_37 and arg_394_1.time_ < var_397_36 + var_397_37 + arg_397_0 then
				arg_394_1.typewritter.percent = 1

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(true)
			end
		end

		arg_394_1.nodeConfigList_ = {}

		arg_394_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/J12f",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/J12g",
		"TextureConfig/Background/XH0306"
	},
	voices = {
		"story_v_out_121521.awb"
	}
}
