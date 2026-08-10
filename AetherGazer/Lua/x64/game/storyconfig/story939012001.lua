return {
	Play939012001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 939012001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play939012002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "I05a"

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
				local var_4_5 = arg_1_1.bgs_.I05a

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
					if iter_4_0 ~= "I05a" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = 2

			if var_4_16 < arg_1_1.time_ and arg_1_1.time_ <= var_4_16 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_17 = 0.3

			if arg_1_1.time_ >= var_4_16 + var_4_17 and arg_1_1.time_ < var_4_16 + var_4_17 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_18 = 0

			if var_4_18 < arg_1_1.time_ and arg_1_1.time_ <= var_4_18 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_19 = 2

			if var_4_18 <= arg_1_1.time_ and arg_1_1.time_ < var_4_18 + var_4_19 then
				local var_4_20 = (arg_1_1.time_ - var_4_18) / var_4_19
				local var_4_21 = Color.New(0, 0, 0)

				var_4_21.a = Mathf.Lerp(1, 0, var_4_20)
				arg_1_1.mask_.color = var_4_21
			end

			if arg_1_1.time_ >= var_4_18 + var_4_19 and arg_1_1.time_ < var_4_18 + var_4_19 + arg_4_0 then
				local var_4_22 = Color.New(0, 0, 0)
				local var_4_23 = 0

				arg_1_1.mask_.enabled = false
				var_4_22.a = var_4_23
				arg_1_1.mask_.color = var_4_22
			end

			local var_4_24 = "1054ui_story"

			if arg_1_1.actors_[var_4_24] == nil then
				local var_4_25 = Asset.Load("Char/" .. "1054ui_story")

				if not isNil(var_4_25) then
					local var_4_26 = Object.Instantiate(Asset.Load("Char/" .. "1054ui_story"), arg_1_1.stage_.transform)

					var_4_26.name = var_4_24
					var_4_26.transform.localPosition = Vector3.New(0, 100, 0)
					arg_1_1.actors_[var_4_24] = var_4_26

					local var_4_27 = var_4_26:GetComponentInChildren(typeof(CharacterEffect))

					var_4_27.enabled = true

					local var_4_28 = GameObjectTools.GetOrAddComponent(var_4_26, typeof(DynamicBoneHelper))

					if var_4_28 then
						var_4_28:EnableDynamicBone(false)
					end

					arg_1_1:ShowWeapon(var_4_27.transform, false)

					arg_1_1.var_[var_4_24 .. "Animator"] = var_4_27.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_1_1.var_[var_4_24 .. "Animator"].applyRootMotion = true
					arg_1_1.var_[var_4_24 .. "LipSync"] = var_4_27.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_4_29 = arg_1_1.actors_["1054ui_story"].transform
			local var_4_30 = 1.8

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				arg_1_1.var_.moveOldPos1054ui_story = var_4_29.localPosition

				local var_4_31 = GameObjectTools.GetOrAddComponent(var_4_29.gameObject, typeof(DynamicBoneHelper))

				if var_4_31 then
					var_4_31:EnableDynamicBone(false)
				end
			end

			local var_4_32 = 0.001

			if var_4_30 <= arg_1_1.time_ and arg_1_1.time_ < var_4_30 + var_4_32 then
				local var_4_33 = (arg_1_1.time_ - var_4_30) / var_4_32
				local var_4_34 = Vector3.New(0, -0.985, -6)

				var_4_29.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1054ui_story, var_4_34, var_4_33)

				local var_4_35 = manager.ui.mainCamera.transform.position - var_4_29.position

				var_4_29.forward = Vector3.New(var_4_35.x, var_4_35.y, var_4_35.z)

				local var_4_36 = var_4_29.localEulerAngles

				var_4_36.z = 0
				var_4_36.x = 0
				var_4_29.localEulerAngles = var_4_36
			end

			if arg_1_1.time_ >= var_4_30 + var_4_32 and arg_1_1.time_ < var_4_30 + var_4_32 + arg_4_0 then
				var_4_29.localPosition = Vector3.New(0, -0.985, -6)

				local var_4_37 = manager.ui.mainCamera.transform.position - var_4_29.position

				var_4_29.forward = Vector3.New(var_4_37.x, var_4_37.y, var_4_37.z)

				local var_4_38 = var_4_29.localEulerAngles

				var_4_38.z = 0
				var_4_38.x = 0
				var_4_29.localEulerAngles = var_4_38

				local var_4_39 = GameObjectTools.GetOrAddComponent(var_4_29.gameObject, typeof(DynamicBoneHelper))

				if var_4_39 then
					var_4_39:EnableDynamicBone(true)
				end
			end

			local var_4_40 = arg_1_1.actors_["1054ui_story"]
			local var_4_41 = 1.8

			if var_4_41 < arg_1_1.time_ and arg_1_1.time_ <= var_4_41 + arg_4_0 and not isNil(var_4_40) and arg_1_1.var_.characterEffect1054ui_story == nil then
				arg_1_1.var_.characterEffect1054ui_story = var_4_40:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_42 = 0.200000002980232

			if var_4_41 <= arg_1_1.time_ and arg_1_1.time_ < var_4_41 + var_4_42 and not isNil(var_4_40) then
				local var_4_43 = (arg_1_1.time_ - var_4_41) / var_4_42

				if arg_1_1.var_.characterEffect1054ui_story and not isNil(var_4_40) then
					arg_1_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= var_4_41 + var_4_42 and arg_1_1.time_ < var_4_41 + var_4_42 + arg_4_0 and not isNil(var_4_40) and arg_1_1.var_.characterEffect1054ui_story then
				arg_1_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_4_44 = 1.8

			if var_4_44 < arg_1_1.time_ and arg_1_1.time_ <= var_4_44 + arg_4_0 then
				arg_1_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action4_1")
			end

			local var_4_45 = 1.8

			if var_4_45 < arg_1_1.time_ and arg_1_1.time_ <= var_4_45 + arg_4_0 then
				arg_1_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_4_46 = 0
			local var_4_47 = 1

			if var_4_46 < arg_1_1.time_ and arg_1_1.time_ <= var_4_46 + arg_4_0 then
				local var_4_48 = "play"
				local var_4_49 = "music"

				arg_1_1:AudioAction(var_4_48, var_4_49, "ui_battle", "ui_battle_stopbgm", "ui_battle.awb")

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

			local var_4_52 = 1
			local var_4_53 = 1

			if var_4_52 < arg_1_1.time_ and arg_1_1.time_ <= var_4_52 + arg_4_0 then
				local var_4_54 = "play"
				local var_4_55 = "music"

				arg_1_1:AudioAction(var_4_54, var_4_55, "bgm_side_daily05", "bgm_side_daily05", "bgm_side_daily05.awb")

				local var_4_56 = ""
				local var_4_57 = manager.audio:GetAudioName("bgm_side_daily05", "bgm_side_daily05")

				if var_4_57 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_57 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_57

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_57
						arg_1_1.bgmTxt2_.text = var_4_57
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

			local var_4_58 = 2
			local var_4_59 = 0.7

			if var_4_58 < arg_1_1.time_ and arg_1_1.time_ <= var_4_58 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_60 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_60:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_60:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_60:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_61 = arg_1_1:FormatText(StoryNameCfg[1487].name)

				arg_1_1.leftNameTxt_.text = var_4_61

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_62 = arg_1_1:GetWordFromCfg(939012001)
				local var_4_63 = arg_1_1:FormatText(var_4_62.content)

				arg_1_1.text_.text = var_4_63

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_64 = 28
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
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_67 = var_4_58 + 0.3
			local var_4_68 = math.max(var_4_59, arg_1_1.talkMaxDuration)

			if var_4_67 <= arg_1_1.time_ and arg_1_1.time_ < var_4_67 + var_4_68 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_67) / var_4_68

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_67 + var_4_68 and arg_1_1.time_ < var_4_67 + var_4_68 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
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
	Play939012002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 939012002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play939012003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = arg_9_1.actors_["1054ui_story"]
			local var_12_1 = 0

			if var_12_1 < arg_9_1.time_ and arg_9_1.time_ <= var_12_1 + arg_12_0 and not isNil(var_12_0) and arg_9_1.var_.characterEffect1054ui_story == nil then
				arg_9_1.var_.characterEffect1054ui_story = var_12_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_2 = 0.200000002980232

			if var_12_1 <= arg_9_1.time_ and arg_9_1.time_ < var_12_1 + var_12_2 and not isNil(var_12_0) then
				local var_12_3 = (arg_9_1.time_ - var_12_1) / var_12_2

				if arg_9_1.var_.characterEffect1054ui_story and not isNil(var_12_0) then
					local var_12_4 = Mathf.Lerp(0, 0.5, var_12_3)

					arg_9_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_9_1.var_.characterEffect1054ui_story.fillRatio = var_12_4
				end
			end

			if arg_9_1.time_ >= var_12_1 + var_12_2 and arg_9_1.time_ < var_12_1 + var_12_2 + arg_12_0 and not isNil(var_12_0) and arg_9_1.var_.characterEffect1054ui_story then
				local var_12_5 = 0.5

				arg_9_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_9_1.var_.characterEffect1054ui_story.fillRatio = var_12_5
			end

			local var_12_6 = 0
			local var_12_7 = 0.35

			if var_12_6 < arg_9_1.time_ and arg_9_1.time_ <= var_12_6 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_8 = arg_9_1:FormatText(StoryNameCfg[7].name)

				arg_9_1.leftNameTxt_.text = var_12_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, true)
				arg_9_1.iconController_:SetSelectedState("hero")

				arg_9_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_9_1.callingController_:SetSelectedState("normal")

				arg_9_1.keyicon_.color = Color.New(1, 1, 1)
				arg_9_1.icon_.color = Color.New(1, 1, 1)

				local var_12_9 = arg_9_1:GetWordFromCfg(939012002)
				local var_12_10 = arg_9_1:FormatText(var_12_9.content)

				arg_9_1.text_.text = var_12_10

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_11 = 14
				local var_12_12 = utf8.len(var_12_10)
				local var_12_13 = var_12_11 <= 0 and var_12_7 or var_12_7 * (var_12_12 / var_12_11)

				if var_12_13 > 0 and var_12_7 < var_12_13 then
					arg_9_1.talkMaxDuration = var_12_13

					if var_12_13 + var_12_6 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_13 + var_12_6
					end
				end

				arg_9_1.text_.text = var_12_10
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_14 = math.max(var_12_7, arg_9_1.talkMaxDuration)

			if var_12_6 <= arg_9_1.time_ and arg_9_1.time_ < var_12_6 + var_12_14 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_6) / var_12_14

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_6 + var_12_14 and arg_9_1.time_ < var_12_6 + var_12_14 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play939012003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 939012003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play939012004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = arg_13_1.actors_["1054ui_story"].transform
			local var_16_1 = 0

			if var_16_1 < arg_13_1.time_ and arg_13_1.time_ <= var_16_1 + arg_16_0 then
				arg_13_1.var_.moveOldPos1054ui_story = var_16_0.localPosition

				local var_16_2 = GameObjectTools.GetOrAddComponent(var_16_0.gameObject, typeof(DynamicBoneHelper))

				if var_16_2 then
					var_16_2:EnableDynamicBone(false)
				end
			end

			local var_16_3 = 0.001

			if var_16_1 <= arg_13_1.time_ and arg_13_1.time_ < var_16_1 + var_16_3 then
				local var_16_4 = (arg_13_1.time_ - var_16_1) / var_16_3
				local var_16_5 = Vector3.New(0, 100, 0)

				var_16_0.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1054ui_story, var_16_5, var_16_4)

				local var_16_6 = manager.ui.mainCamera.transform.position - var_16_0.position

				var_16_0.forward = Vector3.New(var_16_6.x, var_16_6.y, var_16_6.z)

				local var_16_7 = var_16_0.localEulerAngles

				var_16_7.z = 0
				var_16_7.x = 0
				var_16_0.localEulerAngles = var_16_7
			end

			if arg_13_1.time_ >= var_16_1 + var_16_3 and arg_13_1.time_ < var_16_1 + var_16_3 + arg_16_0 then
				var_16_0.localPosition = Vector3.New(0, 100, 0)

				local var_16_8 = manager.ui.mainCamera.transform.position - var_16_0.position

				var_16_0.forward = Vector3.New(var_16_8.x, var_16_8.y, var_16_8.z)

				local var_16_9 = var_16_0.localEulerAngles

				var_16_9.z = 0
				var_16_9.x = 0
				var_16_0.localEulerAngles = var_16_9

				local var_16_10 = GameObjectTools.GetOrAddComponent(var_16_0.gameObject, typeof(DynamicBoneHelper))

				if var_16_10 then
					var_16_10:EnableDynamicBone(true)
				end
			end

			local var_16_11 = 0
			local var_16_12 = 0.6

			if var_16_11 < arg_13_1.time_ and arg_13_1.time_ <= var_16_11 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, false)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_13 = arg_13_1:GetWordFromCfg(939012003)
				local var_16_14 = arg_13_1:FormatText(var_16_13.content)

				arg_13_1.text_.text = var_16_14

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_15 = 24
				local var_16_16 = utf8.len(var_16_14)
				local var_16_17 = var_16_15 <= 0 and var_16_12 or var_16_12 * (var_16_16 / var_16_15)

				if var_16_17 > 0 and var_16_12 < var_16_17 then
					arg_13_1.talkMaxDuration = var_16_17

					if var_16_17 + var_16_11 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_17 + var_16_11
					end
				end

				arg_13_1.text_.text = var_16_14
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_18 = math.max(var_16_12, arg_13_1.talkMaxDuration)

			if var_16_11 <= arg_13_1.time_ and arg_13_1.time_ < var_16_11 + var_16_18 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_11) / var_16_18

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_11 + var_16_18 and arg_13_1.time_ < var_16_11 + var_16_18 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_13_1:InitPlayNodeList()
	end,
	Play939012004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 939012004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play939012005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = arg_17_1.actors_["1054ui_story"].transform
			local var_20_1 = 0

			if var_20_1 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 then
				arg_17_1.var_.moveOldPos1054ui_story = var_20_0.localPosition

				local var_20_2 = GameObjectTools.GetOrAddComponent(var_20_0.gameObject, typeof(DynamicBoneHelper))

				if var_20_2 then
					var_20_2:EnableDynamicBone(false)
				end
			end

			local var_20_3 = 0.001

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_3 then
				local var_20_4 = (arg_17_1.time_ - var_20_1) / var_20_3
				local var_20_5 = Vector3.New(0, -0.985, -6)

				var_20_0.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1054ui_story, var_20_5, var_20_4)

				local var_20_6 = manager.ui.mainCamera.transform.position - var_20_0.position

				var_20_0.forward = Vector3.New(var_20_6.x, var_20_6.y, var_20_6.z)

				local var_20_7 = var_20_0.localEulerAngles

				var_20_7.z = 0
				var_20_7.x = 0
				var_20_0.localEulerAngles = var_20_7
			end

			if arg_17_1.time_ >= var_20_1 + var_20_3 and arg_17_1.time_ < var_20_1 + var_20_3 + arg_20_0 then
				var_20_0.localPosition = Vector3.New(0, -0.985, -6)

				local var_20_8 = manager.ui.mainCamera.transform.position - var_20_0.position

				var_20_0.forward = Vector3.New(var_20_8.x, var_20_8.y, var_20_8.z)

				local var_20_9 = var_20_0.localEulerAngles

				var_20_9.z = 0
				var_20_9.x = 0
				var_20_0.localEulerAngles = var_20_9

				local var_20_10 = GameObjectTools.GetOrAddComponent(var_20_0.gameObject, typeof(DynamicBoneHelper))

				if var_20_10 then
					var_20_10:EnableDynamicBone(true)
				end
			end

			local var_20_11 = arg_17_1.actors_["1054ui_story"]
			local var_20_12 = 0

			if var_20_12 < arg_17_1.time_ and arg_17_1.time_ <= var_20_12 + arg_20_0 and not isNil(var_20_11) and arg_17_1.var_.characterEffect1054ui_story == nil then
				arg_17_1.var_.characterEffect1054ui_story = var_20_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_13 = 0.200000002980232

			if var_20_12 <= arg_17_1.time_ and arg_17_1.time_ < var_20_12 + var_20_13 and not isNil(var_20_11) then
				local var_20_14 = (arg_17_1.time_ - var_20_12) / var_20_13

				if arg_17_1.var_.characterEffect1054ui_story and not isNil(var_20_11) then
					arg_17_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= var_20_12 + var_20_13 and arg_17_1.time_ < var_20_12 + var_20_13 + arg_20_0 and not isNil(var_20_11) and arg_17_1.var_.characterEffect1054ui_story then
				arg_17_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_20_15 = 0

			if var_20_15 < arg_17_1.time_ and arg_17_1.time_ <= var_20_15 + arg_20_0 then
				arg_17_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054actionlink/1054action445")
			end

			local var_20_16 = 0

			if var_20_16 < arg_17_1.time_ and arg_17_1.time_ <= var_20_16 + arg_20_0 then
				arg_17_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_20_17 = 0
			local var_20_18 = 0.375

			if var_20_17 < arg_17_1.time_ and arg_17_1.time_ <= var_20_17 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_19 = arg_17_1:FormatText(StoryNameCfg[1487].name)

				arg_17_1.leftNameTxt_.text = var_20_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_20 = arg_17_1:GetWordFromCfg(939012004)
				local var_20_21 = arg_17_1:FormatText(var_20_20.content)

				arg_17_1.text_.text = var_20_21

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_22 = 15
				local var_20_23 = utf8.len(var_20_21)
				local var_20_24 = var_20_22 <= 0 and var_20_18 or var_20_18 * (var_20_23 / var_20_22)

				if var_20_24 > 0 and var_20_18 < var_20_24 then
					arg_17_1.talkMaxDuration = var_20_24

					if var_20_24 + var_20_17 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_24 + var_20_17
					end
				end

				arg_17_1.text_.text = var_20_21
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_25 = math.max(var_20_18, arg_17_1.talkMaxDuration)

			if var_20_17 <= arg_17_1.time_ and arg_17_1.time_ < var_20_17 + var_20_25 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_17) / var_20_25

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_17 + var_20_25 and arg_17_1.time_ < var_20_17 + var_20_25 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_17_1:InitPlayNodeList()
	end,
	Play939012005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 939012005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play939012006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = arg_21_1.actors_["1054ui_story"]
			local var_24_1 = 0

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.characterEffect1054ui_story == nil then
				arg_21_1.var_.characterEffect1054ui_story = var_24_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_2 = 0.200000002980232

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_2 and not isNil(var_24_0) then
				local var_24_3 = (arg_21_1.time_ - var_24_1) / var_24_2

				if arg_21_1.var_.characterEffect1054ui_story and not isNil(var_24_0) then
					local var_24_4 = Mathf.Lerp(0, 0.5, var_24_3)

					arg_21_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_21_1.var_.characterEffect1054ui_story.fillRatio = var_24_4
				end
			end

			if arg_21_1.time_ >= var_24_1 + var_24_2 and arg_21_1.time_ < var_24_1 + var_24_2 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.characterEffect1054ui_story then
				local var_24_5 = 0.5

				arg_21_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_21_1.var_.characterEffect1054ui_story.fillRatio = var_24_5
			end

			local var_24_6 = 0
			local var_24_7 = 0.6

			if var_24_6 < arg_21_1.time_ and arg_21_1.time_ <= var_24_6 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_8 = arg_21_1:FormatText(StoryNameCfg[7].name)

				arg_21_1.leftNameTxt_.text = var_24_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, true)
				arg_21_1.iconController_:SetSelectedState("hero")

				arg_21_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_21_1.callingController_:SetSelectedState("normal")

				arg_21_1.keyicon_.color = Color.New(1, 1, 1)
				arg_21_1.icon_.color = Color.New(1, 1, 1)

				local var_24_9 = arg_21_1:GetWordFromCfg(939012005)
				local var_24_10 = arg_21_1:FormatText(var_24_9.content)

				arg_21_1.text_.text = var_24_10

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_11 = 24
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
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_14 = math.max(var_24_7, arg_21_1.talkMaxDuration)

			if var_24_6 <= arg_21_1.time_ and arg_21_1.time_ < var_24_6 + var_24_14 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_6) / var_24_14

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_6 + var_24_14 and arg_21_1.time_ < var_24_6 + var_24_14 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play939012006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 939012006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play939012007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = arg_25_1.actors_["1054ui_story"].transform
			local var_28_1 = 0

			if var_28_1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 then
				arg_25_1.var_.moveOldPos1054ui_story = var_28_0.localPosition

				local var_28_2 = GameObjectTools.GetOrAddComponent(var_28_0.gameObject, typeof(DynamicBoneHelper))

				if var_28_2 then
					var_28_2:EnableDynamicBone(false)
				end
			end

			local var_28_3 = 0.001

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_3 then
				local var_28_4 = (arg_25_1.time_ - var_28_1) / var_28_3
				local var_28_5 = Vector3.New(0, 100, 0)

				var_28_0.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1054ui_story, var_28_5, var_28_4)

				local var_28_6 = manager.ui.mainCamera.transform.position - var_28_0.position

				var_28_0.forward = Vector3.New(var_28_6.x, var_28_6.y, var_28_6.z)

				local var_28_7 = var_28_0.localEulerAngles

				var_28_7.z = 0
				var_28_7.x = 0
				var_28_0.localEulerAngles = var_28_7
			end

			if arg_25_1.time_ >= var_28_1 + var_28_3 and arg_25_1.time_ < var_28_1 + var_28_3 + arg_28_0 then
				var_28_0.localPosition = Vector3.New(0, 100, 0)

				local var_28_8 = manager.ui.mainCamera.transform.position - var_28_0.position

				var_28_0.forward = Vector3.New(var_28_8.x, var_28_8.y, var_28_8.z)

				local var_28_9 = var_28_0.localEulerAngles

				var_28_9.z = 0
				var_28_9.x = 0
				var_28_0.localEulerAngles = var_28_9

				local var_28_10 = GameObjectTools.GetOrAddComponent(var_28_0.gameObject, typeof(DynamicBoneHelper))

				if var_28_10 then
					var_28_10:EnableDynamicBone(true)
				end
			end

			local var_28_11 = 0
			local var_28_12 = 0.425

			if var_28_11 < arg_25_1.time_ and arg_25_1.time_ <= var_28_11 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_13 = arg_25_1:FormatText(StoryNameCfg[8].name)

				arg_25_1.leftNameTxt_.text = var_28_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, true)
				arg_25_1.iconController_:SetSelectedState("hero")

				arg_25_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1248")

				arg_25_1.callingController_:SetSelectedState("calling")

				arg_25_1.keyicon_.color = Color.New(1, 1, 1)
				arg_25_1.icon_.color = Color.New(1, 1, 1)

				local var_28_14 = arg_25_1:GetWordFromCfg(939012006)
				local var_28_15 = arg_25_1:FormatText(var_28_14.content)

				arg_25_1.text_.text = var_28_15

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_16 = 17
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
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_19 = math.max(var_28_12, arg_25_1.talkMaxDuration)

			if var_28_11 <= arg_25_1.time_ and arg_25_1.time_ < var_28_11 + var_28_19 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_11) / var_28_19

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_11 + var_28_19 and arg_25_1.time_ < var_28_11 + var_28_19 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_25_1:InitPlayNodeList()
	end,
	Play939012007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 939012007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play939012008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 0
			local var_32_1 = 1.325

			if var_32_0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_2 = arg_29_1:FormatText(StoryNameCfg[8].name)

				arg_29_1.leftNameTxt_.text = var_32_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, true)
				arg_29_1.iconController_:SetSelectedState("hero")

				arg_29_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1248")

				arg_29_1.callingController_:SetSelectedState("calling")

				arg_29_1.keyicon_.color = Color.New(1, 1, 1)
				arg_29_1.icon_.color = Color.New(1, 1, 1)

				local var_32_3 = arg_29_1:GetWordFromCfg(939012007)
				local var_32_4 = arg_29_1:FormatText(var_32_3.content)

				arg_29_1.text_.text = var_32_4

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_5 = 53
				local var_32_6 = utf8.len(var_32_4)
				local var_32_7 = var_32_5 <= 0 and var_32_1 or var_32_1 * (var_32_6 / var_32_5)

				if var_32_7 > 0 and var_32_1 < var_32_7 then
					arg_29_1.talkMaxDuration = var_32_7

					if var_32_7 + var_32_0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_7 + var_32_0
					end
				end

				arg_29_1.text_.text = var_32_4
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_8 = math.max(var_32_1, arg_29_1.talkMaxDuration)

			if var_32_0 <= arg_29_1.time_ and arg_29_1.time_ < var_32_0 + var_32_8 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_0) / var_32_8

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_0 + var_32_8 and arg_29_1.time_ < var_32_0 + var_32_8 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play939012008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 939012008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play939012009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = "1248ui_story"

			if arg_33_1.actors_[var_36_0] == nil then
				local var_36_1 = Asset.Load("Char/" .. "1248ui_story")

				if not isNil(var_36_1) then
					local var_36_2 = Object.Instantiate(Asset.Load("Char/" .. "1248ui_story"), arg_33_1.stage_.transform)

					var_36_2.name = var_36_0
					var_36_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_33_1.actors_[var_36_0] = var_36_2

					local var_36_3 = var_36_2:GetComponentInChildren(typeof(CharacterEffect))

					var_36_3.enabled = true

					local var_36_4 = GameObjectTools.GetOrAddComponent(var_36_2, typeof(DynamicBoneHelper))

					if var_36_4 then
						var_36_4:EnableDynamicBone(false)
					end

					arg_33_1:ShowWeapon(var_36_3.transform, false)

					arg_33_1.var_[var_36_0 .. "Animator"] = var_36_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_33_1.var_[var_36_0 .. "Animator"].applyRootMotion = true
					arg_33_1.var_[var_36_0 .. "LipSync"] = var_36_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_36_5 = arg_33_1.actors_["1248ui_story"]
			local var_36_6 = 0

			if var_36_6 < arg_33_1.time_ and arg_33_1.time_ <= var_36_6 + arg_36_0 and not isNil(var_36_5) and arg_33_1.var_.characterEffect1248ui_story == nil then
				arg_33_1.var_.characterEffect1248ui_story = var_36_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_7 = 0.200000002980232

			if var_36_6 <= arg_33_1.time_ and arg_33_1.time_ < var_36_6 + var_36_7 and not isNil(var_36_5) then
				local var_36_8 = (arg_33_1.time_ - var_36_6) / var_36_7

				if arg_33_1.var_.characterEffect1248ui_story and not isNil(var_36_5) then
					local var_36_9 = Mathf.Lerp(0, 0.5, var_36_8)

					arg_33_1.var_.characterEffect1248ui_story.fillFlat = true
					arg_33_1.var_.characterEffect1248ui_story.fillRatio = var_36_9
				end
			end

			if arg_33_1.time_ >= var_36_6 + var_36_7 and arg_33_1.time_ < var_36_6 + var_36_7 + arg_36_0 and not isNil(var_36_5) and arg_33_1.var_.characterEffect1248ui_story then
				local var_36_10 = 0.5

				arg_33_1.var_.characterEffect1248ui_story.fillFlat = true
				arg_33_1.var_.characterEffect1248ui_story.fillRatio = var_36_10
			end

			local var_36_11 = 0
			local var_36_12 = 0.125

			if var_36_11 < arg_33_1.time_ and arg_33_1.time_ <= var_36_11 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_13 = arg_33_1:FormatText(StoryNameCfg[7].name)

				arg_33_1.leftNameTxt_.text = var_36_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, true)
				arg_33_1.iconController_:SetSelectedState("hero")

				arg_33_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_33_1.callingController_:SetSelectedState("normal")

				arg_33_1.keyicon_.color = Color.New(1, 1, 1)
				arg_33_1.icon_.color = Color.New(1, 1, 1)

				local var_36_14 = arg_33_1:GetWordFromCfg(939012008)
				local var_36_15 = arg_33_1:FormatText(var_36_14.content)

				arg_33_1.text_.text = var_36_15

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_16 = 5
				local var_36_17 = utf8.len(var_36_15)
				local var_36_18 = var_36_16 <= 0 and var_36_12 or var_36_12 * (var_36_17 / var_36_16)

				if var_36_18 > 0 and var_36_12 < var_36_18 then
					arg_33_1.talkMaxDuration = var_36_18

					if var_36_18 + var_36_11 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_18 + var_36_11
					end
				end

				arg_33_1.text_.text = var_36_15
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_19 = math.max(var_36_12, arg_33_1.talkMaxDuration)

			if var_36_11 <= arg_33_1.time_ and arg_33_1.time_ < var_36_11 + var_36_19 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_11) / var_36_19

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_11 + var_36_19 and arg_33_1.time_ < var_36_11 + var_36_19 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play939012009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 939012009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play939012010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 0
			local var_40_1 = 1.325

			if var_40_0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_0 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_2 = arg_37_1:FormatText(StoryNameCfg[8].name)

				arg_37_1.leftNameTxt_.text = var_40_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, true)
				arg_37_1.iconController_:SetSelectedState("hero")

				arg_37_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1248")

				arg_37_1.callingController_:SetSelectedState("calling")

				arg_37_1.keyicon_.color = Color.New(1, 1, 1)
				arg_37_1.icon_.color = Color.New(1, 1, 1)

				local var_40_3 = arg_37_1:GetWordFromCfg(939012009)
				local var_40_4 = arg_37_1:FormatText(var_40_3.content)

				arg_37_1.text_.text = var_40_4

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_5 = 53
				local var_40_6 = utf8.len(var_40_4)
				local var_40_7 = var_40_5 <= 0 and var_40_1 or var_40_1 * (var_40_6 / var_40_5)

				if var_40_7 > 0 and var_40_1 < var_40_7 then
					arg_37_1.talkMaxDuration = var_40_7

					if var_40_7 + var_40_0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_7 + var_40_0
					end
				end

				arg_37_1.text_.text = var_40_4
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_8 = math.max(var_40_1, arg_37_1.talkMaxDuration)

			if var_40_0 <= arg_37_1.time_ and arg_37_1.time_ < var_40_0 + var_40_8 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_0) / var_40_8

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_0 + var_40_8 and arg_37_1.time_ < var_40_0 + var_40_8 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play939012010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 939012010
		arg_41_1.duration_ = 5

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play939012011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = arg_41_1.actors_["1248ui_story"]
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect1248ui_story == nil then
				arg_41_1.var_.characterEffect1248ui_story = var_44_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_2 = 0.200000002980232

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_2 and not isNil(var_44_0) then
				local var_44_3 = (arg_41_1.time_ - var_44_1) / var_44_2

				if arg_41_1.var_.characterEffect1248ui_story and not isNil(var_44_0) then
					local var_44_4 = Mathf.Lerp(0, 0.5, var_44_3)

					arg_41_1.var_.characterEffect1248ui_story.fillFlat = true
					arg_41_1.var_.characterEffect1248ui_story.fillRatio = var_44_4
				end
			end

			if arg_41_1.time_ >= var_44_1 + var_44_2 and arg_41_1.time_ < var_44_1 + var_44_2 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect1248ui_story then
				local var_44_5 = 0.5

				arg_41_1.var_.characterEffect1248ui_story.fillFlat = true
				arg_41_1.var_.characterEffect1248ui_story.fillRatio = var_44_5
			end

			local var_44_6 = 0
			local var_44_7 = 0.4

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

				arg_41_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_41_1.callingController_:SetSelectedState("normal")

				arg_41_1.keyicon_.color = Color.New(1, 1, 1)
				arg_41_1.icon_.color = Color.New(1, 1, 1)

				local var_44_9 = arg_41_1:GetWordFromCfg(939012010)
				local var_44_10 = arg_41_1:FormatText(var_44_9.content)

				arg_41_1.text_.text = var_44_10

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_11 = 16
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
	Play939012011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 939012011
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play939012012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 0
			local var_48_1 = 1.35

			if var_48_0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_0 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_2 = arg_45_1:FormatText(StoryNameCfg[8].name)

				arg_45_1.leftNameTxt_.text = var_48_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, true)
				arg_45_1.iconController_:SetSelectedState("hero")

				arg_45_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1248")

				arg_45_1.callingController_:SetSelectedState("calling")

				arg_45_1.keyicon_.color = Color.New(1, 1, 1)
				arg_45_1.icon_.color = Color.New(1, 1, 1)

				local var_48_3 = arg_45_1:GetWordFromCfg(939012011)
				local var_48_4 = arg_45_1:FormatText(var_48_3.content)

				arg_45_1.text_.text = var_48_4

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_5 = 54
				local var_48_6 = utf8.len(var_48_4)
				local var_48_7 = var_48_5 <= 0 and var_48_1 or var_48_1 * (var_48_6 / var_48_5)

				if var_48_7 > 0 and var_48_1 < var_48_7 then
					arg_45_1.talkMaxDuration = var_48_7

					if var_48_7 + var_48_0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_7 + var_48_0
					end
				end

				arg_45_1.text_.text = var_48_4
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)
				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_8 = math.max(var_48_1, arg_45_1.talkMaxDuration)

			if var_48_0 <= arg_45_1.time_ and arg_45_1.time_ < var_48_0 + var_48_8 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_0) / var_48_8

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_0 + var_48_8 and arg_45_1.time_ < var_48_0 + var_48_8 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play939012012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 939012012
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play939012013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = arg_49_1.actors_["1248ui_story"]
			local var_52_1 = 0

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.characterEffect1248ui_story == nil then
				arg_49_1.var_.characterEffect1248ui_story = var_52_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_2 = 0.200000002980232

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_2 and not isNil(var_52_0) then
				local var_52_3 = (arg_49_1.time_ - var_52_1) / var_52_2

				if arg_49_1.var_.characterEffect1248ui_story and not isNil(var_52_0) then
					local var_52_4 = Mathf.Lerp(0, 0.5, var_52_3)

					arg_49_1.var_.characterEffect1248ui_story.fillFlat = true
					arg_49_1.var_.characterEffect1248ui_story.fillRatio = var_52_4
				end
			end

			if arg_49_1.time_ >= var_52_1 + var_52_2 and arg_49_1.time_ < var_52_1 + var_52_2 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.characterEffect1248ui_story then
				local var_52_5 = 0.5

				arg_49_1.var_.characterEffect1248ui_story.fillFlat = true
				arg_49_1.var_.characterEffect1248ui_story.fillRatio = var_52_5
			end

			local var_52_6 = 0
			local var_52_7 = 0.6

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

				arg_49_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_49_1.callingController_:SetSelectedState("normal")

				arg_49_1.keyicon_.color = Color.New(1, 1, 1)
				arg_49_1.icon_.color = Color.New(1, 1, 1)

				local var_52_9 = arg_49_1:GetWordFromCfg(939012012)
				local var_52_10 = arg_49_1:FormatText(var_52_9.content)

				arg_49_1.text_.text = var_52_10

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_11 = 24
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
	Play939012013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 939012013
		arg_53_1.duration_ = 5

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play939012014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 0
			local var_56_1 = 0.35

			if var_56_0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_2 = arg_53_1:FormatText(StoryNameCfg[8].name)

				arg_53_1.leftNameTxt_.text = var_56_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, true)
				arg_53_1.iconController_:SetSelectedState("hero")

				arg_53_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1248")

				arg_53_1.callingController_:SetSelectedState("calling")

				arg_53_1.keyicon_.color = Color.New(1, 1, 1)
				arg_53_1.icon_.color = Color.New(1, 1, 1)

				local var_56_3 = arg_53_1:GetWordFromCfg(939012013)
				local var_56_4 = arg_53_1:FormatText(var_56_3.content)

				arg_53_1.text_.text = var_56_4

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_5 = 14
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
	Play939012014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 939012014
		arg_57_1.duration_ = 5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play939012015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = arg_57_1.actors_["1248ui_story"]
			local var_60_1 = 0

			if var_60_1 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 and not isNil(var_60_0) and arg_57_1.var_.characterEffect1248ui_story == nil then
				arg_57_1.var_.characterEffect1248ui_story = var_60_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_2 = 0.200000002980232

			if var_60_1 <= arg_57_1.time_ and arg_57_1.time_ < var_60_1 + var_60_2 and not isNil(var_60_0) then
				local var_60_3 = (arg_57_1.time_ - var_60_1) / var_60_2

				if arg_57_1.var_.characterEffect1248ui_story and not isNil(var_60_0) then
					local var_60_4 = Mathf.Lerp(0, 0.5, var_60_3)

					arg_57_1.var_.characterEffect1248ui_story.fillFlat = true
					arg_57_1.var_.characterEffect1248ui_story.fillRatio = var_60_4
				end
			end

			if arg_57_1.time_ >= var_60_1 + var_60_2 and arg_57_1.time_ < var_60_1 + var_60_2 + arg_60_0 and not isNil(var_60_0) and arg_57_1.var_.characterEffect1248ui_story then
				local var_60_5 = 0.5

				arg_57_1.var_.characterEffect1248ui_story.fillFlat = true
				arg_57_1.var_.characterEffect1248ui_story.fillRatio = var_60_5
			end

			local var_60_6 = 0
			local var_60_7 = 0.225

			if var_60_6 < arg_57_1.time_ and arg_57_1.time_ <= var_60_6 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_8 = arg_57_1:FormatText(StoryNameCfg[7].name)

				arg_57_1.leftNameTxt_.text = var_60_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, true)
				arg_57_1.iconController_:SetSelectedState("hero")

				arg_57_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_57_1.callingController_:SetSelectedState("normal")

				arg_57_1.keyicon_.color = Color.New(1, 1, 1)
				arg_57_1.icon_.color = Color.New(1, 1, 1)

				local var_60_9 = arg_57_1:GetWordFromCfg(939012014)
				local var_60_10 = arg_57_1:FormatText(var_60_9.content)

				arg_57_1.text_.text = var_60_10

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_11 = 9
				local var_60_12 = utf8.len(var_60_10)
				local var_60_13 = var_60_11 <= 0 and var_60_7 or var_60_7 * (var_60_12 / var_60_11)

				if var_60_13 > 0 and var_60_7 < var_60_13 then
					arg_57_1.talkMaxDuration = var_60_13

					if var_60_13 + var_60_6 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_13 + var_60_6
					end
				end

				arg_57_1.text_.text = var_60_10
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)
				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_14 = math.max(var_60_7, arg_57_1.talkMaxDuration)

			if var_60_6 <= arg_57_1.time_ and arg_57_1.time_ < var_60_6 + var_60_14 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_6) / var_60_14

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_6 + var_60_14 and arg_57_1.time_ < var_60_6 + var_60_14 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play939012015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 939012015
		arg_61_1.duration_ = 5

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play939012016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = "6148ui_story"

			if arg_61_1.actors_[var_64_0] == nil then
				local var_64_1 = Asset.Load("Char/" .. "6148ui_story")

				if not isNil(var_64_1) then
					local var_64_2 = Object.Instantiate(Asset.Load("Char/" .. "6148ui_story"), arg_61_1.stage_.transform)

					var_64_2.name = var_64_0
					var_64_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_61_1.actors_[var_64_0] = var_64_2

					local var_64_3 = var_64_2:GetComponentInChildren(typeof(CharacterEffect))

					var_64_3.enabled = true

					local var_64_4 = GameObjectTools.GetOrAddComponent(var_64_2, typeof(DynamicBoneHelper))

					if var_64_4 then
						var_64_4:EnableDynamicBone(false)
					end

					arg_61_1:ShowWeapon(var_64_3.transform, false)

					arg_61_1.var_[var_64_0 .. "Animator"] = var_64_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_61_1.var_[var_64_0 .. "Animator"].applyRootMotion = true
					arg_61_1.var_[var_64_0 .. "LipSync"] = var_64_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_64_5 = arg_61_1.actors_["6148ui_story"].transform
			local var_64_6 = 0

			if var_64_6 < arg_61_1.time_ and arg_61_1.time_ <= var_64_6 + arg_64_0 then
				arg_61_1.var_.moveOldPos6148ui_story = var_64_5.localPosition

				local var_64_7 = GameObjectTools.GetOrAddComponent(var_64_5.gameObject, typeof(DynamicBoneHelper))

				if var_64_7 then
					var_64_7:EnableDynamicBone(false)
				end
			end

			local var_64_8 = 0.001

			if var_64_6 <= arg_61_1.time_ and arg_61_1.time_ < var_64_6 + var_64_8 then
				local var_64_9 = (arg_61_1.time_ - var_64_6) / var_64_8
				local var_64_10 = Vector3.New(-0.7, -0.985, -6)

				var_64_5.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos6148ui_story, var_64_10, var_64_9)

				local var_64_11 = manager.ui.mainCamera.transform.position - var_64_5.position

				var_64_5.forward = Vector3.New(var_64_11.x, var_64_11.y, var_64_11.z)

				local var_64_12 = var_64_5.localEulerAngles

				var_64_12.z = 0
				var_64_12.x = 0
				var_64_5.localEulerAngles = var_64_12
			end

			if arg_61_1.time_ >= var_64_6 + var_64_8 and arg_61_1.time_ < var_64_6 + var_64_8 + arg_64_0 then
				var_64_5.localPosition = Vector3.New(-0.7, -0.985, -6)

				local var_64_13 = manager.ui.mainCamera.transform.position - var_64_5.position

				var_64_5.forward = Vector3.New(var_64_13.x, var_64_13.y, var_64_13.z)

				local var_64_14 = var_64_5.localEulerAngles

				var_64_14.z = 0
				var_64_14.x = 0
				var_64_5.localEulerAngles = var_64_14

				local var_64_15 = GameObjectTools.GetOrAddComponent(var_64_5.gameObject, typeof(DynamicBoneHelper))

				if var_64_15 then
					var_64_15:EnableDynamicBone(true)
				end
			end

			local var_64_16 = arg_61_1.actors_["1248ui_story"].transform
			local var_64_17 = 0

			if var_64_17 < arg_61_1.time_ and arg_61_1.time_ <= var_64_17 + arg_64_0 then
				arg_61_1.var_.moveOldPos1248ui_story = var_64_16.localPosition
			end

			local var_64_18 = 0.001

			if var_64_17 <= arg_61_1.time_ and arg_61_1.time_ < var_64_17 + var_64_18 then
				local var_64_19 = (arg_61_1.time_ - var_64_17) / var_64_18
				local var_64_20 = Vector3.New(0, 100, 0)

				var_64_16.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos1248ui_story, var_64_20, var_64_19)

				local var_64_21 = manager.ui.mainCamera.transform.position - var_64_16.position

				var_64_16.forward = Vector3.New(var_64_21.x, var_64_21.y, var_64_21.z)

				local var_64_22 = var_64_16.localEulerAngles

				var_64_22.z = 0
				var_64_22.x = 0
				var_64_16.localEulerAngles = var_64_22
			end

			if arg_61_1.time_ >= var_64_17 + var_64_18 and arg_61_1.time_ < var_64_17 + var_64_18 + arg_64_0 then
				var_64_16.localPosition = Vector3.New(0, 100, 0)

				local var_64_23 = manager.ui.mainCamera.transform.position - var_64_16.position

				var_64_16.forward = Vector3.New(var_64_23.x, var_64_23.y, var_64_23.z)

				local var_64_24 = var_64_16.localEulerAngles

				var_64_24.z = 0
				var_64_24.x = 0
				var_64_16.localEulerAngles = var_64_24
			end

			local var_64_25 = arg_61_1.actors_["6148ui_story"]
			local var_64_26 = 0

			if var_64_26 < arg_61_1.time_ and arg_61_1.time_ <= var_64_26 + arg_64_0 and not isNil(var_64_25) and arg_61_1.var_.characterEffect6148ui_story == nil then
				arg_61_1.var_.characterEffect6148ui_story = var_64_25:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_27 = 0.200000002980232

			if var_64_26 <= arg_61_1.time_ and arg_61_1.time_ < var_64_26 + var_64_27 and not isNil(var_64_25) then
				local var_64_28 = (arg_61_1.time_ - var_64_26) / var_64_27

				if arg_61_1.var_.characterEffect6148ui_story and not isNil(var_64_25) then
					arg_61_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_61_1.time_ >= var_64_26 + var_64_27 and arg_61_1.time_ < var_64_26 + var_64_27 + arg_64_0 and not isNil(var_64_25) and arg_61_1.var_.characterEffect6148ui_story then
				arg_61_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_64_29 = 0

			if var_64_29 < arg_61_1.time_ and arg_61_1.time_ <= var_64_29 + arg_64_0 then
				arg_61_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action2_1")
			end

			local var_64_30 = 0

			if var_64_30 < arg_61_1.time_ and arg_61_1.time_ <= var_64_30 + arg_64_0 then
				arg_61_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_64_31 = 0
			local var_64_32 = 1.525

			if var_64_31 < arg_61_1.time_ and arg_61_1.time_ <= var_64_31 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_33 = arg_61_1:FormatText(StoryNameCfg[1488].name)

				arg_61_1.leftNameTxt_.text = var_64_33

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_34 = arg_61_1:GetWordFromCfg(939012015)
				local var_64_35 = arg_61_1:FormatText(var_64_34.content)

				arg_61_1.text_.text = var_64_35

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_36 = 61
				local var_64_37 = utf8.len(var_64_35)
				local var_64_38 = var_64_36 <= 0 and var_64_32 or var_64_32 * (var_64_37 / var_64_36)

				if var_64_38 > 0 and var_64_32 < var_64_38 then
					arg_61_1.talkMaxDuration = var_64_38

					if var_64_38 + var_64_31 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_38 + var_64_31
					end
				end

				arg_61_1.text_.text = var_64_35
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)
				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_39 = math.max(var_64_32, arg_61_1.talkMaxDuration)

			if var_64_31 <= arg_61_1.time_ and arg_61_1.time_ < var_64_31 + var_64_39 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_31) / var_64_39

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_31 + var_64_39 and arg_61_1.time_ < var_64_31 + var_64_39 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1248ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_61_1:InitPlayNodeList()
	end,
	Play939012016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 939012016
		arg_65_1.duration_ = 5

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play939012017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = arg_65_1.actors_["1054ui_story"].transform
			local var_68_1 = 0

			if var_68_1 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 then
				arg_65_1.var_.moveOldPos1054ui_story = var_68_0.localPosition

				local var_68_2 = GameObjectTools.GetOrAddComponent(var_68_0.gameObject, typeof(DynamicBoneHelper))

				if var_68_2 then
					var_68_2:EnableDynamicBone(false)
				end
			end

			local var_68_3 = 0.001

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_3 then
				local var_68_4 = (arg_65_1.time_ - var_68_1) / var_68_3
				local var_68_5 = Vector3.New(0.7, -0.985, -6)

				var_68_0.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos1054ui_story, var_68_5, var_68_4)

				local var_68_6 = manager.ui.mainCamera.transform.position - var_68_0.position

				var_68_0.forward = Vector3.New(var_68_6.x, var_68_6.y, var_68_6.z)

				local var_68_7 = var_68_0.localEulerAngles

				var_68_7.z = 0
				var_68_7.x = 0
				var_68_0.localEulerAngles = var_68_7
			end

			if arg_65_1.time_ >= var_68_1 + var_68_3 and arg_65_1.time_ < var_68_1 + var_68_3 + arg_68_0 then
				var_68_0.localPosition = Vector3.New(0.7, -0.985, -6)

				local var_68_8 = manager.ui.mainCamera.transform.position - var_68_0.position

				var_68_0.forward = Vector3.New(var_68_8.x, var_68_8.y, var_68_8.z)

				local var_68_9 = var_68_0.localEulerAngles

				var_68_9.z = 0
				var_68_9.x = 0
				var_68_0.localEulerAngles = var_68_9

				local var_68_10 = GameObjectTools.GetOrAddComponent(var_68_0.gameObject, typeof(DynamicBoneHelper))

				if var_68_10 then
					var_68_10:EnableDynamicBone(true)
				end
			end

			local var_68_11 = arg_65_1.actors_["1054ui_story"]
			local var_68_12 = 0

			if var_68_12 < arg_65_1.time_ and arg_65_1.time_ <= var_68_12 + arg_68_0 and not isNil(var_68_11) and arg_65_1.var_.characterEffect1054ui_story == nil then
				arg_65_1.var_.characterEffect1054ui_story = var_68_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_13 = 0.200000002980232

			if var_68_12 <= arg_65_1.time_ and arg_65_1.time_ < var_68_12 + var_68_13 and not isNil(var_68_11) then
				local var_68_14 = (arg_65_1.time_ - var_68_12) / var_68_13

				if arg_65_1.var_.characterEffect1054ui_story and not isNil(var_68_11) then
					arg_65_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= var_68_12 + var_68_13 and arg_65_1.time_ < var_68_12 + var_68_13 + arg_68_0 and not isNil(var_68_11) and arg_65_1.var_.characterEffect1054ui_story then
				arg_65_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_68_15 = arg_65_1.actors_["6148ui_story"]
			local var_68_16 = 0

			if var_68_16 < arg_65_1.time_ and arg_65_1.time_ <= var_68_16 + arg_68_0 and not isNil(var_68_15) and arg_65_1.var_.characterEffect6148ui_story == nil then
				arg_65_1.var_.characterEffect6148ui_story = var_68_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_17 = 0.200000002980232

			if var_68_16 <= arg_65_1.time_ and arg_65_1.time_ < var_68_16 + var_68_17 and not isNil(var_68_15) then
				local var_68_18 = (arg_65_1.time_ - var_68_16) / var_68_17

				if arg_65_1.var_.characterEffect6148ui_story and not isNil(var_68_15) then
					local var_68_19 = Mathf.Lerp(0, 0.5, var_68_18)

					arg_65_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_65_1.var_.characterEffect6148ui_story.fillRatio = var_68_19
				end
			end

			if arg_65_1.time_ >= var_68_16 + var_68_17 and arg_65_1.time_ < var_68_16 + var_68_17 + arg_68_0 and not isNil(var_68_15) and arg_65_1.var_.characterEffect6148ui_story then
				local var_68_20 = 0.5

				arg_65_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_65_1.var_.characterEffect6148ui_story.fillRatio = var_68_20
			end

			local var_68_21 = 0

			if var_68_21 < arg_65_1.time_ and arg_65_1.time_ <= var_68_21 + arg_68_0 then
				arg_65_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action1_1")
			end

			local var_68_22 = 0

			if var_68_22 < arg_65_1.time_ and arg_65_1.time_ <= var_68_22 + arg_68_0 then
				arg_65_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_68_23 = 0
			local var_68_24 = 0.7

			if var_68_23 < arg_65_1.time_ and arg_65_1.time_ <= var_68_23 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_25 = arg_65_1:FormatText(StoryNameCfg[1487].name)

				arg_65_1.leftNameTxt_.text = var_68_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_26 = arg_65_1:GetWordFromCfg(939012016)
				local var_68_27 = arg_65_1:FormatText(var_68_26.content)

				arg_65_1.text_.text = var_68_27

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_28 = 28
				local var_68_29 = utf8.len(var_68_27)
				local var_68_30 = var_68_28 <= 0 and var_68_24 or var_68_24 * (var_68_29 / var_68_28)

				if var_68_30 > 0 and var_68_24 < var_68_30 then
					arg_65_1.talkMaxDuration = var_68_30

					if var_68_30 + var_68_23 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_30 + var_68_23
					end
				end

				arg_65_1.text_.text = var_68_27
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)
				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_31 = math.max(var_68_24, arg_65_1.talkMaxDuration)

			if var_68_23 <= arg_65_1.time_ and arg_65_1.time_ < var_68_23 + var_68_31 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_23) / var_68_31

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_23 + var_68_31 and arg_65_1.time_ < var_68_23 + var_68_31 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_65_1:InitPlayNodeList()
	end,
	Play939012017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 939012017
		arg_69_1.duration_ = 5

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play939012018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = arg_69_1.actors_["1054ui_story"]
			local var_72_1 = 0

			if var_72_1 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 and not isNil(var_72_0) and arg_69_1.var_.characterEffect1054ui_story == nil then
				arg_69_1.var_.characterEffect1054ui_story = var_72_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_2 = 0.200000002980232

			if var_72_1 <= arg_69_1.time_ and arg_69_1.time_ < var_72_1 + var_72_2 and not isNil(var_72_0) then
				local var_72_3 = (arg_69_1.time_ - var_72_1) / var_72_2

				if arg_69_1.var_.characterEffect1054ui_story and not isNil(var_72_0) then
					local var_72_4 = Mathf.Lerp(0, 0.5, var_72_3)

					arg_69_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_69_1.var_.characterEffect1054ui_story.fillRatio = var_72_4
				end
			end

			if arg_69_1.time_ >= var_72_1 + var_72_2 and arg_69_1.time_ < var_72_1 + var_72_2 + arg_72_0 and not isNil(var_72_0) and arg_69_1.var_.characterEffect1054ui_story then
				local var_72_5 = 0.5

				arg_69_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_69_1.var_.characterEffect1054ui_story.fillRatio = var_72_5
			end

			local var_72_6 = 0
			local var_72_7 = 1.15

			if var_72_6 < arg_69_1.time_ and arg_69_1.time_ <= var_72_6 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_8 = arg_69_1:FormatText(StoryNameCfg[7].name)

				arg_69_1.leftNameTxt_.text = var_72_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, true)
				arg_69_1.iconController_:SetSelectedState("hero")

				arg_69_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_69_1.callingController_:SetSelectedState("normal")

				arg_69_1.keyicon_.color = Color.New(1, 1, 1)
				arg_69_1.icon_.color = Color.New(1, 1, 1)

				local var_72_9 = arg_69_1:GetWordFromCfg(939012017)
				local var_72_10 = arg_69_1:FormatText(var_72_9.content)

				arg_69_1.text_.text = var_72_10

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_11 = 46
				local var_72_12 = utf8.len(var_72_10)
				local var_72_13 = var_72_11 <= 0 and var_72_7 or var_72_7 * (var_72_12 / var_72_11)

				if var_72_13 > 0 and var_72_7 < var_72_13 then
					arg_69_1.talkMaxDuration = var_72_13

					if var_72_13 + var_72_6 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_13 + var_72_6
					end
				end

				arg_69_1.text_.text = var_72_10
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)
				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_14 = math.max(var_72_7, arg_69_1.talkMaxDuration)

			if var_72_6 <= arg_69_1.time_ and arg_69_1.time_ < var_72_6 + var_72_14 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_6) / var_72_14

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_6 + var_72_14 and arg_69_1.time_ < var_72_6 + var_72_14 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play939012018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 939012018
		arg_73_1.duration_ = 6.77

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play939012019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = arg_73_1.actors_["1054ui_story"].transform
			local var_76_1 = 0

			if var_76_1 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 then
				arg_73_1.var_.moveOldPos1054ui_story = var_76_0.localPosition

				local var_76_2 = GameObjectTools.GetOrAddComponent(var_76_0.gameObject, typeof(DynamicBoneHelper))

				if var_76_2 then
					var_76_2:EnableDynamicBone(false)
				end
			end

			local var_76_3 = 0.001

			if var_76_1 <= arg_73_1.time_ and arg_73_1.time_ < var_76_1 + var_76_3 then
				local var_76_4 = (arg_73_1.time_ - var_76_1) / var_76_3
				local var_76_5 = Vector3.New(0, 100, 0)

				var_76_0.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos1054ui_story, var_76_5, var_76_4)

				local var_76_6 = manager.ui.mainCamera.transform.position - var_76_0.position

				var_76_0.forward = Vector3.New(var_76_6.x, var_76_6.y, var_76_6.z)

				local var_76_7 = var_76_0.localEulerAngles

				var_76_7.z = 0
				var_76_7.x = 0
				var_76_0.localEulerAngles = var_76_7
			end

			if arg_73_1.time_ >= var_76_1 + var_76_3 and arg_73_1.time_ < var_76_1 + var_76_3 + arg_76_0 then
				var_76_0.localPosition = Vector3.New(0, 100, 0)

				local var_76_8 = manager.ui.mainCamera.transform.position - var_76_0.position

				var_76_0.forward = Vector3.New(var_76_8.x, var_76_8.y, var_76_8.z)

				local var_76_9 = var_76_0.localEulerAngles

				var_76_9.z = 0
				var_76_9.x = 0
				var_76_0.localEulerAngles = var_76_9

				local var_76_10 = GameObjectTools.GetOrAddComponent(var_76_0.gameObject, typeof(DynamicBoneHelper))

				if var_76_10 then
					var_76_10:EnableDynamicBone(true)
				end
			end

			local var_76_11 = arg_73_1.actors_["6148ui_story"].transform
			local var_76_12 = 0

			if var_76_12 < arg_73_1.time_ and arg_73_1.time_ <= var_76_12 + arg_76_0 then
				arg_73_1.var_.moveOldPos6148ui_story = var_76_11.localPosition

				local var_76_13 = GameObjectTools.GetOrAddComponent(var_76_11.gameObject, typeof(DynamicBoneHelper))

				if var_76_13 then
					var_76_13:EnableDynamicBone(false)
				end
			end

			local var_76_14 = 0.001

			if var_76_12 <= arg_73_1.time_ and arg_73_1.time_ < var_76_12 + var_76_14 then
				local var_76_15 = (arg_73_1.time_ - var_76_12) / var_76_14
				local var_76_16 = Vector3.New(0, 100, 0)

				var_76_11.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos6148ui_story, var_76_16, var_76_15)

				local var_76_17 = manager.ui.mainCamera.transform.position - var_76_11.position

				var_76_11.forward = Vector3.New(var_76_17.x, var_76_17.y, var_76_17.z)

				local var_76_18 = var_76_11.localEulerAngles

				var_76_18.z = 0
				var_76_18.x = 0
				var_76_11.localEulerAngles = var_76_18
			end

			if arg_73_1.time_ >= var_76_12 + var_76_14 and arg_73_1.time_ < var_76_12 + var_76_14 + arg_76_0 then
				var_76_11.localPosition = Vector3.New(0, 100, 0)

				local var_76_19 = manager.ui.mainCamera.transform.position - var_76_11.position

				var_76_11.forward = Vector3.New(var_76_19.x, var_76_19.y, var_76_19.z)

				local var_76_20 = var_76_11.localEulerAngles

				var_76_20.z = 0
				var_76_20.x = 0
				var_76_11.localEulerAngles = var_76_20

				local var_76_21 = GameObjectTools.GetOrAddComponent(var_76_11.gameObject, typeof(DynamicBoneHelper))

				if var_76_21 then
					var_76_21:EnableDynamicBone(true)
				end
			end

			local var_76_22 = manager.ui.mainCamera.transform
			local var_76_23 = 0

			if var_76_23 < arg_73_1.time_ and arg_73_1.time_ <= var_76_23 + arg_76_0 then
				local var_76_24 = arg_73_1.var_.effectzhezhuyanjing1
				local var_76_25
				local var_76_26 = var_76_22

				if not var_76_24 then
					var_76_24 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_snapshut"), var_76_26)
					var_76_24.name = "zhezhuyanjing1"
					arg_73_1.var_.effectzhezhuyanjing1 = var_76_24
				else
					var_76_24.transform:SetParent(var_76_26)
				end

				var_76_24.transform.localPosition = Vector3.New(0, 0, 0)
				var_76_24.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_76_27 = 1.7777777777777777
				local var_76_28 = Screen.width / Screen.height
				local var_76_29 = var_76_28 / var_76_27
				local var_76_30 = Mathf.Max(var_76_27 / var_76_28, 1)
				local var_76_31 = Mathf.Max(var_76_29, var_76_30)

				var_76_24.transform.localScale = Vector3.New(var_76_24.transform.localScale.x * var_76_31, var_76_24.transform.localScale.y * var_76_31, var_76_24.transform.localScale.z * var_76_31)
			end

			local var_76_32 = 0

			if var_76_32 < arg_73_1.time_ and arg_73_1.time_ <= var_76_32 + arg_76_0 then
				arg_73_1.allBtn_.enabled = false
			end

			local var_76_33 = 1.76896430058405

			if arg_73_1.time_ >= var_76_32 + var_76_33 and arg_73_1.time_ < var_76_32 + var_76_33 + arg_76_0 then
				arg_73_1.allBtn_.enabled = true
			end

			if arg_73_1.frameCnt_ <= 1 then
				arg_73_1.dialog_:SetActive(false)
			end

			local var_76_34 = 1.76896430058405
			local var_76_35 = 0.95

			if var_76_34 < arg_73_1.time_ and arg_73_1.time_ <= var_76_34 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0

				arg_73_1.dialog_:SetActive(true)

				arg_73_1.dialogCg_.alpha = 0

				local var_76_36 = LeanTween.value(arg_73_1.dialog_, 0, 1, 0.3)

				var_76_36:setOnUpdate(LuaHelper.FloatAction(function(arg_77_0)
					arg_73_1.dialogCg_.alpha = arg_77_0
				end))
				var_76_36:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_73_1.dialog_)
					var_76_36:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_73_1.duration_ = arg_73_1.duration_ + 0.3

				SetActive(arg_73_1.leftNameGo_, false)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_37 = arg_73_1:GetWordFromCfg(939012018)
				local var_76_38 = arg_73_1:FormatText(var_76_37.content)

				arg_73_1.text_.text = var_76_38

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_39 = 38
				local var_76_40 = utf8.len(var_76_38)
				local var_76_41 = var_76_39 <= 0 and var_76_35 or var_76_35 * (var_76_40 / var_76_39)

				if var_76_41 > 0 and var_76_35 < var_76_41 then
					arg_73_1.talkMaxDuration = var_76_41
					var_76_34 = var_76_34 + 0.3

					if var_76_41 + var_76_34 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_41 + var_76_34
					end
				end

				arg_73_1.text_.text = var_76_38
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)
				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_42 = var_76_34 + 0.3
			local var_76_43 = math.max(var_76_35, arg_73_1.talkMaxDuration)

			if var_76_42 <= arg_73_1.time_ and arg_73_1.time_ < var_76_42 + var_76_43 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_42) / var_76_43

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_42 + var_76_43 and arg_73_1.time_ < var_76_42 + var_76_43 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_73_1:InitPlayNodeList()
	end,
	Play939012019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 939012019
		arg_79_1.duration_ = 5

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play939012020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = 0
			local var_82_1 = 0.25

			if var_82_0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_0 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				local var_82_2 = arg_79_1:FormatText(StoryNameCfg[36].name)

				arg_79_1.leftNameTxt_.text = var_82_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_3 = arg_79_1:GetWordFromCfg(939012019)
				local var_82_4 = arg_79_1:FormatText(var_82_3.content)

				arg_79_1.text_.text = var_82_4

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_5 = 10
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
				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_8 = math.max(var_82_1, arg_79_1.talkMaxDuration)

			if var_82_0 <= arg_79_1.time_ and arg_79_1.time_ < var_82_0 + var_82_8 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_0) / var_82_8

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_0 + var_82_8 and arg_79_1.time_ < var_82_0 + var_82_8 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play939012020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 939012020
		arg_83_1.duration_ = 5

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play939012021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = arg_83_1.actors_["1054ui_story"]
			local var_86_1 = 0

			if var_86_1 < arg_83_1.time_ and arg_83_1.time_ <= var_86_1 + arg_86_0 and not isNil(var_86_0) and arg_83_1.var_.characterEffect1054ui_story == nil then
				arg_83_1.var_.characterEffect1054ui_story = var_86_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_86_2 = 0.200000002980232

			if var_86_1 <= arg_83_1.time_ and arg_83_1.time_ < var_86_1 + var_86_2 and not isNil(var_86_0) then
				local var_86_3 = (arg_83_1.time_ - var_86_1) / var_86_2

				if arg_83_1.var_.characterEffect1054ui_story and not isNil(var_86_0) then
					arg_83_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_83_1.time_ >= var_86_1 + var_86_2 and arg_83_1.time_ < var_86_1 + var_86_2 + arg_86_0 and not isNil(var_86_0) and arg_83_1.var_.characterEffect1054ui_story then
				arg_83_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_86_4 = 0
			local var_86_5 = 0.225

			if var_86_4 < arg_83_1.time_ and arg_83_1.time_ <= var_86_4 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				local var_86_6 = arg_83_1:FormatText(StoryNameCfg[1487].name)

				arg_83_1.leftNameTxt_.text = var_86_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, true)
				arg_83_1.iconController_:SetSelectedState("hero")

				arg_83_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1054")

				arg_83_1.callingController_:SetSelectedState("normal")

				arg_83_1.keyicon_.color = Color.New(1, 1, 1)
				arg_83_1.icon_.color = Color.New(1, 1, 1)

				local var_86_7 = arg_83_1:GetWordFromCfg(939012020)
				local var_86_8 = arg_83_1:FormatText(var_86_7.content)

				arg_83_1.text_.text = var_86_8

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_9 = 9
				local var_86_10 = utf8.len(var_86_8)
				local var_86_11 = var_86_9 <= 0 and var_86_5 or var_86_5 * (var_86_10 / var_86_9)

				if var_86_11 > 0 and var_86_5 < var_86_11 then
					arg_83_1.talkMaxDuration = var_86_11

					if var_86_11 + var_86_4 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_11 + var_86_4
					end
				end

				arg_83_1.text_.text = var_86_8
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)
				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_12 = math.max(var_86_5, arg_83_1.talkMaxDuration)

			if var_86_4 <= arg_83_1.time_ and arg_83_1.time_ < var_86_4 + var_86_12 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_4) / var_86_12

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_4 + var_86_12 and arg_83_1.time_ < var_86_4 + var_86_12 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play939012021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 939012021
		arg_87_1.duration_ = 5

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play939012022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = arg_87_1.actors_["1054ui_story"]
			local var_90_1 = 0

			if var_90_1 < arg_87_1.time_ and arg_87_1.time_ <= var_90_1 + arg_90_0 and not isNil(var_90_0) and arg_87_1.var_.characterEffect1054ui_story == nil then
				arg_87_1.var_.characterEffect1054ui_story = var_90_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_2 = 0.200000002980232

			if var_90_1 <= arg_87_1.time_ and arg_87_1.time_ < var_90_1 + var_90_2 and not isNil(var_90_0) then
				local var_90_3 = (arg_87_1.time_ - var_90_1) / var_90_2

				if arg_87_1.var_.characterEffect1054ui_story and not isNil(var_90_0) then
					local var_90_4 = Mathf.Lerp(0, 0.5, var_90_3)

					arg_87_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_87_1.var_.characterEffect1054ui_story.fillRatio = var_90_4
				end
			end

			if arg_87_1.time_ >= var_90_1 + var_90_2 and arg_87_1.time_ < var_90_1 + var_90_2 + arg_90_0 and not isNil(var_90_0) and arg_87_1.var_.characterEffect1054ui_story then
				local var_90_5 = 0.5

				arg_87_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_87_1.var_.characterEffect1054ui_story.fillRatio = var_90_5
			end

			local var_90_6 = 0
			local var_90_7 = 0.875

			if var_90_6 < arg_87_1.time_ and arg_87_1.time_ <= var_90_6 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, false)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_8 = arg_87_1:GetWordFromCfg(939012021)
				local var_90_9 = arg_87_1:FormatText(var_90_8.content)

				arg_87_1.text_.text = var_90_9

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_10 = 35
				local var_90_11 = utf8.len(var_90_9)
				local var_90_12 = var_90_10 <= 0 and var_90_7 or var_90_7 * (var_90_11 / var_90_10)

				if var_90_12 > 0 and var_90_7 < var_90_12 then
					arg_87_1.talkMaxDuration = var_90_12

					if var_90_12 + var_90_6 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_12 + var_90_6
					end
				end

				arg_87_1.text_.text = var_90_9
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)
				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_13 = math.max(var_90_7, arg_87_1.talkMaxDuration)

			if var_90_6 <= arg_87_1.time_ and arg_87_1.time_ < var_90_6 + var_90_13 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_6) / var_90_13

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_6 + var_90_13 and arg_87_1.time_ < var_90_6 + var_90_13 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {}

		arg_87_1:InitPlayNodeList()
	end,
	Play939012022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 939012022
		arg_91_1.duration_ = 5

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play939012023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			local var_94_0 = 0
			local var_94_1 = 0.3

			if var_94_0 < arg_91_1.time_ and arg_91_1.time_ <= var_94_0 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				local var_94_2 = arg_91_1:FormatText(StoryNameCfg[7].name)

				arg_91_1.leftNameTxt_.text = var_94_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, true)
				arg_91_1.iconController_:SetSelectedState("hero")

				arg_91_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_91_1.callingController_:SetSelectedState("normal")

				arg_91_1.keyicon_.color = Color.New(1, 1, 1)
				arg_91_1.icon_.color = Color.New(1, 1, 1)

				local var_94_3 = arg_91_1:GetWordFromCfg(939012022)
				local var_94_4 = arg_91_1:FormatText(var_94_3.content)

				arg_91_1.text_.text = var_94_4

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_5 = 12
				local var_94_6 = utf8.len(var_94_4)
				local var_94_7 = var_94_5 <= 0 and var_94_1 or var_94_1 * (var_94_6 / var_94_5)

				if var_94_7 > 0 and var_94_1 < var_94_7 then
					arg_91_1.talkMaxDuration = var_94_7

					if var_94_7 + var_94_0 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_7 + var_94_0
					end
				end

				arg_91_1.text_.text = var_94_4
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)
				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_8 = math.max(var_94_1, arg_91_1.talkMaxDuration)

			if var_94_0 <= arg_91_1.time_ and arg_91_1.time_ < var_94_0 + var_94_8 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_0) / var_94_8

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_0 + var_94_8 and arg_91_1.time_ < var_94_0 + var_94_8 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {}

		arg_91_1:InitPlayNodeList()
	end,
	Play939012023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 939012023
		arg_95_1.duration_ = 6.8

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play939012024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			local var_98_0 = "1034ui_story"

			if arg_95_1.actors_[var_98_0] == nil then
				local var_98_1 = Asset.Load("Char/" .. "1034ui_story")

				if not isNil(var_98_1) then
					local var_98_2 = Object.Instantiate(Asset.Load("Char/" .. "1034ui_story"), arg_95_1.stage_.transform)

					var_98_2.name = var_98_0
					var_98_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_95_1.actors_[var_98_0] = var_98_2

					local var_98_3 = var_98_2:GetComponentInChildren(typeof(CharacterEffect))

					var_98_3.enabled = true

					local var_98_4 = GameObjectTools.GetOrAddComponent(var_98_2, typeof(DynamicBoneHelper))

					if var_98_4 then
						var_98_4:EnableDynamicBone(false)
					end

					arg_95_1:ShowWeapon(var_98_3.transform, false)

					arg_95_1.var_[var_98_0 .. "Animator"] = var_98_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_95_1.var_[var_98_0 .. "Animator"].applyRootMotion = true
					arg_95_1.var_[var_98_0 .. "LipSync"] = var_98_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_98_5 = arg_95_1.actors_["1034ui_story"].transform
			local var_98_6 = 2

			if var_98_6 < arg_95_1.time_ and arg_95_1.time_ <= var_98_6 + arg_98_0 then
				arg_95_1.var_.moveOldPos1034ui_story = var_98_5.localPosition
			end

			local var_98_7 = 0.001

			if var_98_6 <= arg_95_1.time_ and arg_95_1.time_ < var_98_6 + var_98_7 then
				local var_98_8 = (arg_95_1.time_ - var_98_6) / var_98_7
				local var_98_9 = Vector3.New(0, -0.93, -6)

				var_98_5.localPosition = Vector3.Lerp(arg_95_1.var_.moveOldPos1034ui_story, var_98_9, var_98_8)

				local var_98_10 = manager.ui.mainCamera.transform.position - var_98_5.position

				var_98_5.forward = Vector3.New(var_98_10.x, var_98_10.y, var_98_10.z)

				local var_98_11 = var_98_5.localEulerAngles

				var_98_11.z = 0
				var_98_11.x = 0
				var_98_5.localEulerAngles = var_98_11
			end

			if arg_95_1.time_ >= var_98_6 + var_98_7 and arg_95_1.time_ < var_98_6 + var_98_7 + arg_98_0 then
				var_98_5.localPosition = Vector3.New(0, -0.93, -6)

				local var_98_12 = manager.ui.mainCamera.transform.position - var_98_5.position

				var_98_5.forward = Vector3.New(var_98_12.x, var_98_12.y, var_98_12.z)

				local var_98_13 = var_98_5.localEulerAngles

				var_98_13.z = 0
				var_98_13.x = 0
				var_98_5.localEulerAngles = var_98_13
			end

			local var_98_14 = arg_95_1.actors_["1034ui_story"]
			local var_98_15 = 2

			if var_98_15 < arg_95_1.time_ and arg_95_1.time_ <= var_98_15 + arg_98_0 and not isNil(var_98_14) and arg_95_1.var_.characterEffect1034ui_story == nil then
				arg_95_1.var_.characterEffect1034ui_story = var_98_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_98_16 = 0.200000002980232

			if var_98_15 <= arg_95_1.time_ and arg_95_1.time_ < var_98_15 + var_98_16 and not isNil(var_98_14) then
				local var_98_17 = (arg_95_1.time_ - var_98_15) / var_98_16

				if arg_95_1.var_.characterEffect1034ui_story and not isNil(var_98_14) then
					arg_95_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_95_1.time_ >= var_98_15 + var_98_16 and arg_95_1.time_ < var_98_15 + var_98_16 + arg_98_0 and not isNil(var_98_14) and arg_95_1.var_.characterEffect1034ui_story then
				arg_95_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			local var_98_18 = 2

			if var_98_18 < arg_95_1.time_ and arg_95_1.time_ <= var_98_18 + arg_98_0 then
				arg_95_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action1_1")
			end

			local var_98_19 = 2

			if var_98_19 < arg_95_1.time_ and arg_95_1.time_ <= var_98_19 + arg_98_0 then
				arg_95_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_98_20 = manager.ui.mainCamera.transform
			local var_98_21 = 0

			if var_98_21 < arg_95_1.time_ and arg_95_1.time_ <= var_98_21 + arg_98_0 then
				local var_98_22 = arg_95_1.var_.effectzhezhuyanjing1

				if var_98_22 then
					Object.Destroy(var_98_22)

					arg_95_1.var_.effectzhezhuyanjing1 = nil
				end
			end

			local var_98_23 = manager.ui.mainCamera.transform
			local var_98_24 = 0

			if var_98_24 < arg_95_1.time_ and arg_95_1.time_ <= var_98_24 + arg_98_0 then
				local var_98_25 = arg_95_1.var_.effectzhezhuyanjing2
				local var_98_26
				local var_98_27 = var_98_23

				if not var_98_25 then
					var_98_25 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_snapopen"), var_98_27)
					var_98_25.name = "zhezhuyanjing2"
					arg_95_1.var_.effectzhezhuyanjing2 = var_98_25
				else
					var_98_25.transform:SetParent(var_98_27)
				end

				var_98_25.transform.localPosition = Vector3.New(0, 0, 0)
				var_98_25.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_98_28 = 1.7777777777777777
				local var_98_29 = Screen.width / Screen.height
				local var_98_30 = var_98_29 / var_98_28
				local var_98_31 = Mathf.Max(var_98_28 / var_98_29, 1)
				local var_98_32 = Mathf.Max(var_98_30, var_98_31)

				var_98_25.transform.localScale = Vector3.New(var_98_25.transform.localScale.x * var_98_32, var_98_25.transform.localScale.y * var_98_32, var_98_25.transform.localScale.z * var_98_32)
			end

			local var_98_33 = 0

			if var_98_33 < arg_95_1.time_ and arg_95_1.time_ <= var_98_33 + arg_98_0 then
				arg_95_1.allBtn_.enabled = false
			end

			local var_98_34 = 2

			if arg_95_1.time_ >= var_98_33 + var_98_34 and arg_95_1.time_ < var_98_33 + var_98_34 + arg_98_0 then
				arg_95_1.allBtn_.enabled = true
			end

			if arg_95_1.frameCnt_ <= 1 then
				arg_95_1.dialog_:SetActive(false)
			end

			local var_98_35 = 1.79999999701977
			local var_98_36 = 1.1

			if var_98_35 < arg_95_1.time_ and arg_95_1.time_ <= var_98_35 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0

				arg_95_1.dialog_:SetActive(true)

				arg_95_1.dialogCg_.alpha = 0

				local var_98_37 = LeanTween.value(arg_95_1.dialog_, 0, 1, 0.3)

				var_98_37:setOnUpdate(LuaHelper.FloatAction(function(arg_99_0)
					arg_95_1.dialogCg_.alpha = arg_99_0
				end))
				var_98_37:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_95_1.dialog_)
					var_98_37:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_95_1.duration_ = arg_95_1.duration_ + 0.3

				SetActive(arg_95_1.leftNameGo_, true)

				local var_98_38 = arg_95_1:FormatText(StoryNameCfg[1109].name)

				arg_95_1.leftNameTxt_.text = var_98_38

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_39 = arg_95_1:GetWordFromCfg(939012023)
				local var_98_40 = arg_95_1:FormatText(var_98_39.content)

				arg_95_1.text_.text = var_98_40

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_41 = 44
				local var_98_42 = utf8.len(var_98_40)
				local var_98_43 = var_98_41 <= 0 and var_98_36 or var_98_36 * (var_98_42 / var_98_41)

				if var_98_43 > 0 and var_98_36 < var_98_43 then
					arg_95_1.talkMaxDuration = var_98_43
					var_98_35 = var_98_35 + 0.3

					if var_98_43 + var_98_35 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_43 + var_98_35
					end
				end

				arg_95_1.text_.text = var_98_40
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)
				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_44 = var_98_35 + 0.3
			local var_98_45 = math.max(var_98_36, arg_95_1.talkMaxDuration)

			if var_98_44 <= arg_95_1.time_ and arg_95_1.time_ < var_98_44 + var_98_45 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_44) / var_98_45

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_44 + var_98_45 and arg_95_1.time_ < var_98_44 + var_98_45 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_95_1:InitPlayNodeList()
	end,
	Play939012024 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 939012024
		arg_101_1.duration_ = 5

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play939012025(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = arg_101_1.actors_["1034ui_story"]
			local var_104_1 = 0

			if var_104_1 < arg_101_1.time_ and arg_101_1.time_ <= var_104_1 + arg_104_0 and not isNil(var_104_0) and arg_101_1.var_.characterEffect1034ui_story == nil then
				arg_101_1.var_.characterEffect1034ui_story = var_104_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_2 = 0.200000002980232

			if var_104_1 <= arg_101_1.time_ and arg_101_1.time_ < var_104_1 + var_104_2 and not isNil(var_104_0) then
				local var_104_3 = (arg_101_1.time_ - var_104_1) / var_104_2

				if arg_101_1.var_.characterEffect1034ui_story and not isNil(var_104_0) then
					local var_104_4 = Mathf.Lerp(0, 0.5, var_104_3)

					arg_101_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_101_1.var_.characterEffect1034ui_story.fillRatio = var_104_4
				end
			end

			if arg_101_1.time_ >= var_104_1 + var_104_2 and arg_101_1.time_ < var_104_1 + var_104_2 + arg_104_0 and not isNil(var_104_0) and arg_101_1.var_.characterEffect1034ui_story then
				local var_104_5 = 0.5

				arg_101_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_101_1.var_.characterEffect1034ui_story.fillRatio = var_104_5
			end

			local var_104_6 = 0
			local var_104_7 = 0.4

			if var_104_6 < arg_101_1.time_ and arg_101_1.time_ <= var_104_6 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				local var_104_8 = arg_101_1:FormatText(StoryNameCfg[7].name)

				arg_101_1.leftNameTxt_.text = var_104_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, true)
				arg_101_1.iconController_:SetSelectedState("hero")

				arg_101_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_101_1.callingController_:SetSelectedState("normal")

				arg_101_1.keyicon_.color = Color.New(1, 1, 1)
				arg_101_1.icon_.color = Color.New(1, 1, 1)

				local var_104_9 = arg_101_1:GetWordFromCfg(939012024)
				local var_104_10 = arg_101_1:FormatText(var_104_9.content)

				arg_101_1.text_.text = var_104_10

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_11 = 16
				local var_104_12 = utf8.len(var_104_10)
				local var_104_13 = var_104_11 <= 0 and var_104_7 or var_104_7 * (var_104_12 / var_104_11)

				if var_104_13 > 0 and var_104_7 < var_104_13 then
					arg_101_1.talkMaxDuration = var_104_13

					if var_104_13 + var_104_6 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_13 + var_104_6
					end
				end

				arg_101_1.text_.text = var_104_10
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)
				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_14 = math.max(var_104_7, arg_101_1.talkMaxDuration)

			if var_104_6 <= arg_101_1.time_ and arg_101_1.time_ < var_104_6 + var_104_14 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_6) / var_104_14

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_6 + var_104_14 and arg_101_1.time_ < var_104_6 + var_104_14 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play939012025 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 939012025
		arg_105_1.duration_ = 5

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play939012026(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = arg_105_1.actors_["1054ui_story"].transform
			local var_108_1 = 0

			if var_108_1 < arg_105_1.time_ and arg_105_1.time_ <= var_108_1 + arg_108_0 then
				arg_105_1.var_.moveOldPos1054ui_story = var_108_0.localPosition

				local var_108_2 = GameObjectTools.GetOrAddComponent(var_108_0.gameObject, typeof(DynamicBoneHelper))

				if var_108_2 then
					var_108_2:EnableDynamicBone(false)
				end
			end

			local var_108_3 = 0.001

			if var_108_1 <= arg_105_1.time_ and arg_105_1.time_ < var_108_1 + var_108_3 then
				local var_108_4 = (arg_105_1.time_ - var_108_1) / var_108_3
				local var_108_5 = Vector3.New(0.7, -0.985, -6)

				var_108_0.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos1054ui_story, var_108_5, var_108_4)

				local var_108_6 = manager.ui.mainCamera.transform.position - var_108_0.position

				var_108_0.forward = Vector3.New(var_108_6.x, var_108_6.y, var_108_6.z)

				local var_108_7 = var_108_0.localEulerAngles

				var_108_7.z = 0
				var_108_7.x = 0
				var_108_0.localEulerAngles = var_108_7
			end

			if arg_105_1.time_ >= var_108_1 + var_108_3 and arg_105_1.time_ < var_108_1 + var_108_3 + arg_108_0 then
				var_108_0.localPosition = Vector3.New(0.7, -0.985, -6)

				local var_108_8 = manager.ui.mainCamera.transform.position - var_108_0.position

				var_108_0.forward = Vector3.New(var_108_8.x, var_108_8.y, var_108_8.z)

				local var_108_9 = var_108_0.localEulerAngles

				var_108_9.z = 0
				var_108_9.x = 0
				var_108_0.localEulerAngles = var_108_9

				local var_108_10 = GameObjectTools.GetOrAddComponent(var_108_0.gameObject, typeof(DynamicBoneHelper))

				if var_108_10 then
					var_108_10:EnableDynamicBone(true)
				end
			end

			local var_108_11 = arg_105_1.actors_["1034ui_story"].transform
			local var_108_12 = 0

			if var_108_12 < arg_105_1.time_ and arg_105_1.time_ <= var_108_12 + arg_108_0 then
				arg_105_1.var_.moveOldPos1034ui_story = var_108_11.localPosition
			end

			local var_108_13 = 0.001

			if var_108_12 <= arg_105_1.time_ and arg_105_1.time_ < var_108_12 + var_108_13 then
				local var_108_14 = (arg_105_1.time_ - var_108_12) / var_108_13
				local var_108_15 = Vector3.New(-0.7, -0.93, -6)

				var_108_11.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos1034ui_story, var_108_15, var_108_14)

				local var_108_16 = manager.ui.mainCamera.transform.position - var_108_11.position

				var_108_11.forward = Vector3.New(var_108_16.x, var_108_16.y, var_108_16.z)

				local var_108_17 = var_108_11.localEulerAngles

				var_108_17.z = 0
				var_108_17.x = 0
				var_108_11.localEulerAngles = var_108_17
			end

			if arg_105_1.time_ >= var_108_12 + var_108_13 and arg_105_1.time_ < var_108_12 + var_108_13 + arg_108_0 then
				var_108_11.localPosition = Vector3.New(-0.7, -0.93, -6)

				local var_108_18 = manager.ui.mainCamera.transform.position - var_108_11.position

				var_108_11.forward = Vector3.New(var_108_18.x, var_108_18.y, var_108_18.z)

				local var_108_19 = var_108_11.localEulerAngles

				var_108_19.z = 0
				var_108_19.x = 0
				var_108_11.localEulerAngles = var_108_19
			end

			local var_108_20 = arg_105_1.actors_["1054ui_story"]
			local var_108_21 = 0

			if var_108_21 < arg_105_1.time_ and arg_105_1.time_ <= var_108_21 + arg_108_0 and not isNil(var_108_20) and arg_105_1.var_.characterEffect1054ui_story == nil then
				arg_105_1.var_.characterEffect1054ui_story = var_108_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_22 = 0.200000002980232

			if var_108_21 <= arg_105_1.time_ and arg_105_1.time_ < var_108_21 + var_108_22 and not isNil(var_108_20) then
				local var_108_23 = (arg_105_1.time_ - var_108_21) / var_108_22

				if arg_105_1.var_.characterEffect1054ui_story and not isNil(var_108_20) then
					arg_105_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_105_1.time_ >= var_108_21 + var_108_22 and arg_105_1.time_ < var_108_21 + var_108_22 + arg_108_0 and not isNil(var_108_20) and arg_105_1.var_.characterEffect1054ui_story then
				arg_105_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_108_24 = 0

			if var_108_24 < arg_105_1.time_ and arg_105_1.time_ <= var_108_24 + arg_108_0 then
				arg_105_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action1_1")
			end

			local var_108_25 = 0

			if var_108_25 < arg_105_1.time_ and arg_105_1.time_ <= var_108_25 + arg_108_0 then
				arg_105_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_108_26 = 0
			local var_108_27 = 0.2

			if var_108_26 < arg_105_1.time_ and arg_105_1.time_ <= var_108_26 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				local var_108_28 = arg_105_1:FormatText(StoryNameCfg[1487].name)

				arg_105_1.leftNameTxt_.text = var_108_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_29 = arg_105_1:GetWordFromCfg(939012025)
				local var_108_30 = arg_105_1:FormatText(var_108_29.content)

				arg_105_1.text_.text = var_108_30

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_31 = 8
				local var_108_32 = utf8.len(var_108_30)
				local var_108_33 = var_108_31 <= 0 and var_108_27 or var_108_27 * (var_108_32 / var_108_31)

				if var_108_33 > 0 and var_108_27 < var_108_33 then
					arg_105_1.talkMaxDuration = var_108_33

					if var_108_33 + var_108_26 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_33 + var_108_26
					end
				end

				arg_105_1.text_.text = var_108_30
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)
				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_34 = math.max(var_108_27, arg_105_1.talkMaxDuration)

			if var_108_26 <= arg_105_1.time_ and arg_105_1.time_ < var_108_26 + var_108_34 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_26) / var_108_34

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_26 + var_108_34 and arg_105_1.time_ < var_108_26 + var_108_34 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1034ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_105_1:InitPlayNodeList()
	end,
	Play939012026 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 939012026
		arg_109_1.duration_ = 5

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play939012027(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = arg_109_1.actors_["1054ui_story"]
			local var_112_1 = 0

			if var_112_1 < arg_109_1.time_ and arg_109_1.time_ <= var_112_1 + arg_112_0 and not isNil(var_112_0) and arg_109_1.var_.characterEffect1054ui_story == nil then
				arg_109_1.var_.characterEffect1054ui_story = var_112_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_2 = 0.200000002980232

			if var_112_1 <= arg_109_1.time_ and arg_109_1.time_ < var_112_1 + var_112_2 and not isNil(var_112_0) then
				local var_112_3 = (arg_109_1.time_ - var_112_1) / var_112_2

				if arg_109_1.var_.characterEffect1054ui_story and not isNil(var_112_0) then
					local var_112_4 = Mathf.Lerp(0, 0.5, var_112_3)

					arg_109_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_109_1.var_.characterEffect1054ui_story.fillRatio = var_112_4
				end
			end

			if arg_109_1.time_ >= var_112_1 + var_112_2 and arg_109_1.time_ < var_112_1 + var_112_2 + arg_112_0 and not isNil(var_112_0) and arg_109_1.var_.characterEffect1054ui_story then
				local var_112_5 = 0.5

				arg_109_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_109_1.var_.characterEffect1054ui_story.fillRatio = var_112_5
			end

			local var_112_6 = 0
			local var_112_7 = 0.525

			if var_112_6 < arg_109_1.time_ and arg_109_1.time_ <= var_112_6 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				local var_112_8 = arg_109_1:FormatText(StoryNameCfg[7].name)

				arg_109_1.leftNameTxt_.text = var_112_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, true)
				arg_109_1.iconController_:SetSelectedState("hero")

				arg_109_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_109_1.callingController_:SetSelectedState("normal")

				arg_109_1.keyicon_.color = Color.New(1, 1, 1)
				arg_109_1.icon_.color = Color.New(1, 1, 1)

				local var_112_9 = arg_109_1:GetWordFromCfg(939012026)
				local var_112_10 = arg_109_1:FormatText(var_112_9.content)

				arg_109_1.text_.text = var_112_10

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_11 = 21
				local var_112_12 = utf8.len(var_112_10)
				local var_112_13 = var_112_11 <= 0 and var_112_7 or var_112_7 * (var_112_12 / var_112_11)

				if var_112_13 > 0 and var_112_7 < var_112_13 then
					arg_109_1.talkMaxDuration = var_112_13

					if var_112_13 + var_112_6 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_13 + var_112_6
					end
				end

				arg_109_1.text_.text = var_112_10
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)
				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_14 = math.max(var_112_7, arg_109_1.talkMaxDuration)

			if var_112_6 <= arg_109_1.time_ and arg_109_1.time_ < var_112_6 + var_112_14 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_6) / var_112_14

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_6 + var_112_14 and arg_109_1.time_ < var_112_6 + var_112_14 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play939012027 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 939012027
		arg_113_1.duration_ = 5

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play939012028(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = arg_113_1.actors_["1034ui_story"].transform
			local var_116_1 = 0

			if var_116_1 < arg_113_1.time_ and arg_113_1.time_ <= var_116_1 + arg_116_0 then
				arg_113_1.var_.moveOldPos1034ui_story = var_116_0.localPosition
			end

			local var_116_2 = 0.001

			if var_116_1 <= arg_113_1.time_ and arg_113_1.time_ < var_116_1 + var_116_2 then
				local var_116_3 = (arg_113_1.time_ - var_116_1) / var_116_2
				local var_116_4 = Vector3.New(-0.7, -0.93, -6)

				var_116_0.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos1034ui_story, var_116_4, var_116_3)

				local var_116_5 = manager.ui.mainCamera.transform.position - var_116_0.position

				var_116_0.forward = Vector3.New(var_116_5.x, var_116_5.y, var_116_5.z)

				local var_116_6 = var_116_0.localEulerAngles

				var_116_6.z = 0
				var_116_6.x = 0
				var_116_0.localEulerAngles = var_116_6
			end

			if arg_113_1.time_ >= var_116_1 + var_116_2 and arg_113_1.time_ < var_116_1 + var_116_2 + arg_116_0 then
				var_116_0.localPosition = Vector3.New(-0.7, -0.93, -6)

				local var_116_7 = manager.ui.mainCamera.transform.position - var_116_0.position

				var_116_0.forward = Vector3.New(var_116_7.x, var_116_7.y, var_116_7.z)

				local var_116_8 = var_116_0.localEulerAngles

				var_116_8.z = 0
				var_116_8.x = 0
				var_116_0.localEulerAngles = var_116_8
			end

			local var_116_9 = arg_113_1.actors_["1034ui_story"]
			local var_116_10 = 0

			if var_116_10 < arg_113_1.time_ and arg_113_1.time_ <= var_116_10 + arg_116_0 and not isNil(var_116_9) and arg_113_1.var_.characterEffect1034ui_story == nil then
				arg_113_1.var_.characterEffect1034ui_story = var_116_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_11 = 0.200000002980232

			if var_116_10 <= arg_113_1.time_ and arg_113_1.time_ < var_116_10 + var_116_11 and not isNil(var_116_9) then
				local var_116_12 = (arg_113_1.time_ - var_116_10) / var_116_11

				if arg_113_1.var_.characterEffect1034ui_story and not isNil(var_116_9) then
					arg_113_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_113_1.time_ >= var_116_10 + var_116_11 and arg_113_1.time_ < var_116_10 + var_116_11 + arg_116_0 and not isNil(var_116_9) and arg_113_1.var_.characterEffect1034ui_story then
				arg_113_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			local var_116_13 = 0

			if var_116_13 < arg_113_1.time_ and arg_113_1.time_ <= var_116_13 + arg_116_0 then
				arg_113_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action5_1")
			end

			local var_116_14 = 0

			if var_116_14 < arg_113_1.time_ and arg_113_1.time_ <= var_116_14 + arg_116_0 then
				arg_113_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileC_biyan", "EmotionTimelineAnimator")
			end

			local var_116_15 = 0
			local var_116_16 = 0.2

			if var_116_15 < arg_113_1.time_ and arg_113_1.time_ <= var_116_15 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				local var_116_17 = arg_113_1:FormatText(StoryNameCfg[1109].name)

				arg_113_1.leftNameTxt_.text = var_116_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_18 = arg_113_1:GetWordFromCfg(939012027)
				local var_116_19 = arg_113_1:FormatText(var_116_18.content)

				arg_113_1.text_.text = var_116_19

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_20 = 8
				local var_116_21 = utf8.len(var_116_19)
				local var_116_22 = var_116_20 <= 0 and var_116_16 or var_116_16 * (var_116_21 / var_116_20)

				if var_116_22 > 0 and var_116_16 < var_116_22 then
					arg_113_1.talkMaxDuration = var_116_22

					if var_116_22 + var_116_15 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_22 + var_116_15
					end
				end

				arg_113_1.text_.text = var_116_19
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)
				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_23 = math.max(var_116_16, arg_113_1.talkMaxDuration)

			if var_116_15 <= arg_113_1.time_ and arg_113_1.time_ < var_116_15 + var_116_23 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_15) / var_116_23

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_15 + var_116_23 and arg_113_1.time_ < var_116_15 + var_116_23 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_113_1:InitPlayNodeList()
	end,
	Play939012028 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 939012028
		arg_117_1.duration_ = 5

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play939012029(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = arg_117_1.actors_["1054ui_story"].transform
			local var_120_1 = 0

			if var_120_1 < arg_117_1.time_ and arg_117_1.time_ <= var_120_1 + arg_120_0 then
				arg_117_1.var_.moveOldPos1054ui_story = var_120_0.localPosition

				local var_120_2 = GameObjectTools.GetOrAddComponent(var_120_0.gameObject, typeof(DynamicBoneHelper))

				if var_120_2 then
					var_120_2:EnableDynamicBone(false)
				end
			end

			local var_120_3 = 0.001

			if var_120_1 <= arg_117_1.time_ and arg_117_1.time_ < var_120_1 + var_120_3 then
				local var_120_4 = (arg_117_1.time_ - var_120_1) / var_120_3
				local var_120_5 = Vector3.New(0.7, -0.985, -6)

				var_120_0.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos1054ui_story, var_120_5, var_120_4)

				local var_120_6 = manager.ui.mainCamera.transform.position - var_120_0.position

				var_120_0.forward = Vector3.New(var_120_6.x, var_120_6.y, var_120_6.z)

				local var_120_7 = var_120_0.localEulerAngles

				var_120_7.z = 0
				var_120_7.x = 0
				var_120_0.localEulerAngles = var_120_7
			end

			if arg_117_1.time_ >= var_120_1 + var_120_3 and arg_117_1.time_ < var_120_1 + var_120_3 + arg_120_0 then
				var_120_0.localPosition = Vector3.New(0.7, -0.985, -6)

				local var_120_8 = manager.ui.mainCamera.transform.position - var_120_0.position

				var_120_0.forward = Vector3.New(var_120_8.x, var_120_8.y, var_120_8.z)

				local var_120_9 = var_120_0.localEulerAngles

				var_120_9.z = 0
				var_120_9.x = 0
				var_120_0.localEulerAngles = var_120_9

				local var_120_10 = GameObjectTools.GetOrAddComponent(var_120_0.gameObject, typeof(DynamicBoneHelper))

				if var_120_10 then
					var_120_10:EnableDynamicBone(true)
				end
			end

			local var_120_11 = arg_117_1.actors_["1054ui_story"]
			local var_120_12 = 0

			if var_120_12 < arg_117_1.time_ and arg_117_1.time_ <= var_120_12 + arg_120_0 and not isNil(var_120_11) and arg_117_1.var_.characterEffect1054ui_story == nil then
				arg_117_1.var_.characterEffect1054ui_story = var_120_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_13 = 0.200000002980232

			if var_120_12 <= arg_117_1.time_ and arg_117_1.time_ < var_120_12 + var_120_13 and not isNil(var_120_11) then
				local var_120_14 = (arg_117_1.time_ - var_120_12) / var_120_13

				if arg_117_1.var_.characterEffect1054ui_story and not isNil(var_120_11) then
					arg_117_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_117_1.time_ >= var_120_12 + var_120_13 and arg_117_1.time_ < var_120_12 + var_120_13 + arg_120_0 and not isNil(var_120_11) and arg_117_1.var_.characterEffect1054ui_story then
				arg_117_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_120_15 = arg_117_1.actors_["1034ui_story"]
			local var_120_16 = 0

			if var_120_16 < arg_117_1.time_ and arg_117_1.time_ <= var_120_16 + arg_120_0 and not isNil(var_120_15) and arg_117_1.var_.characterEffect1034ui_story == nil then
				arg_117_1.var_.characterEffect1034ui_story = var_120_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_17 = 0.200000002980232

			if var_120_16 <= arg_117_1.time_ and arg_117_1.time_ < var_120_16 + var_120_17 and not isNil(var_120_15) then
				local var_120_18 = (arg_117_1.time_ - var_120_16) / var_120_17

				if arg_117_1.var_.characterEffect1034ui_story and not isNil(var_120_15) then
					local var_120_19 = Mathf.Lerp(0, 0.5, var_120_18)

					arg_117_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_117_1.var_.characterEffect1034ui_story.fillRatio = var_120_19
				end
			end

			if arg_117_1.time_ >= var_120_16 + var_120_17 and arg_117_1.time_ < var_120_16 + var_120_17 + arg_120_0 and not isNil(var_120_15) and arg_117_1.var_.characterEffect1034ui_story then
				local var_120_20 = 0.5

				arg_117_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_117_1.var_.characterEffect1034ui_story.fillRatio = var_120_20
			end

			local var_120_21 = 0

			if var_120_21 < arg_117_1.time_ and arg_117_1.time_ <= var_120_21 + arg_120_0 then
				arg_117_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action1_1")
			end

			local var_120_22 = 0

			if var_120_22 < arg_117_1.time_ and arg_117_1.time_ <= var_120_22 + arg_120_0 then
				arg_117_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_120_23 = 0
			local var_120_24 = 0.275

			if var_120_23 < arg_117_1.time_ and arg_117_1.time_ <= var_120_23 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				local var_120_25 = arg_117_1:FormatText(StoryNameCfg[1487].name)

				arg_117_1.leftNameTxt_.text = var_120_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_26 = arg_117_1:GetWordFromCfg(939012028)
				local var_120_27 = arg_117_1:FormatText(var_120_26.content)

				arg_117_1.text_.text = var_120_27

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_28 = 11
				local var_120_29 = utf8.len(var_120_27)
				local var_120_30 = var_120_28 <= 0 and var_120_24 or var_120_24 * (var_120_29 / var_120_28)

				if var_120_30 > 0 and var_120_24 < var_120_30 then
					arg_117_1.talkMaxDuration = var_120_30

					if var_120_30 + var_120_23 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_30 + var_120_23
					end
				end

				arg_117_1.text_.text = var_120_27
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)
				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_31 = math.max(var_120_24, arg_117_1.talkMaxDuration)

			if var_120_23 <= arg_117_1.time_ and arg_117_1.time_ < var_120_23 + var_120_31 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_23) / var_120_31

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_23 + var_120_31 and arg_117_1.time_ < var_120_23 + var_120_31 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_117_1:InitPlayNodeList()
	end,
	Play939012029 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 939012029
		arg_121_1.duration_ = 5

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play939012030(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = arg_121_1.actors_["6148ui_story"].transform
			local var_124_1 = 0

			if var_124_1 < arg_121_1.time_ and arg_121_1.time_ <= var_124_1 + arg_124_0 then
				arg_121_1.var_.moveOldPos6148ui_story = var_124_0.localPosition

				local var_124_2 = GameObjectTools.GetOrAddComponent(var_124_0.gameObject, typeof(DynamicBoneHelper))

				if var_124_2 then
					var_124_2:EnableDynamicBone(false)
				end
			end

			local var_124_3 = 0.001

			if var_124_1 <= arg_121_1.time_ and arg_121_1.time_ < var_124_1 + var_124_3 then
				local var_124_4 = (arg_121_1.time_ - var_124_1) / var_124_3
				local var_124_5 = Vector3.New(0.7, -0.985, -6)

				var_124_0.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos6148ui_story, var_124_5, var_124_4)

				local var_124_6 = manager.ui.mainCamera.transform.position - var_124_0.position

				var_124_0.forward = Vector3.New(var_124_6.x, var_124_6.y, var_124_6.z)

				local var_124_7 = var_124_0.localEulerAngles

				var_124_7.z = 0
				var_124_7.x = 0
				var_124_0.localEulerAngles = var_124_7
			end

			if arg_121_1.time_ >= var_124_1 + var_124_3 and arg_121_1.time_ < var_124_1 + var_124_3 + arg_124_0 then
				var_124_0.localPosition = Vector3.New(0.7, -0.985, -6)

				local var_124_8 = manager.ui.mainCamera.transform.position - var_124_0.position

				var_124_0.forward = Vector3.New(var_124_8.x, var_124_8.y, var_124_8.z)

				local var_124_9 = var_124_0.localEulerAngles

				var_124_9.z = 0
				var_124_9.x = 0
				var_124_0.localEulerAngles = var_124_9

				local var_124_10 = GameObjectTools.GetOrAddComponent(var_124_0.gameObject, typeof(DynamicBoneHelper))

				if var_124_10 then
					var_124_10:EnableDynamicBone(true)
				end
			end

			local var_124_11 = arg_121_1.actors_["1054ui_story"].transform
			local var_124_12 = 0

			if var_124_12 < arg_121_1.time_ and arg_121_1.time_ <= var_124_12 + arg_124_0 then
				arg_121_1.var_.moveOldPos1054ui_story = var_124_11.localPosition

				local var_124_13 = GameObjectTools.GetOrAddComponent(var_124_11.gameObject, typeof(DynamicBoneHelper))

				if var_124_13 then
					var_124_13:EnableDynamicBone(false)
				end
			end

			local var_124_14 = 0.001

			if var_124_12 <= arg_121_1.time_ and arg_121_1.time_ < var_124_12 + var_124_14 then
				local var_124_15 = (arg_121_1.time_ - var_124_12) / var_124_14
				local var_124_16 = Vector3.New(0, 100, 0)

				var_124_11.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos1054ui_story, var_124_16, var_124_15)

				local var_124_17 = manager.ui.mainCamera.transform.position - var_124_11.position

				var_124_11.forward = Vector3.New(var_124_17.x, var_124_17.y, var_124_17.z)

				local var_124_18 = var_124_11.localEulerAngles

				var_124_18.z = 0
				var_124_18.x = 0
				var_124_11.localEulerAngles = var_124_18
			end

			if arg_121_1.time_ >= var_124_12 + var_124_14 and arg_121_1.time_ < var_124_12 + var_124_14 + arg_124_0 then
				var_124_11.localPosition = Vector3.New(0, 100, 0)

				local var_124_19 = manager.ui.mainCamera.transform.position - var_124_11.position

				var_124_11.forward = Vector3.New(var_124_19.x, var_124_19.y, var_124_19.z)

				local var_124_20 = var_124_11.localEulerAngles

				var_124_20.z = 0
				var_124_20.x = 0
				var_124_11.localEulerAngles = var_124_20

				local var_124_21 = GameObjectTools.GetOrAddComponent(var_124_11.gameObject, typeof(DynamicBoneHelper))

				if var_124_21 then
					var_124_21:EnableDynamicBone(true)
				end
			end

			local var_124_22 = arg_121_1.actors_["6148ui_story"]
			local var_124_23 = 0

			if var_124_23 < arg_121_1.time_ and arg_121_1.time_ <= var_124_23 + arg_124_0 and not isNil(var_124_22) and arg_121_1.var_.characterEffect6148ui_story == nil then
				arg_121_1.var_.characterEffect6148ui_story = var_124_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_24 = 0.200000002980232

			if var_124_23 <= arg_121_1.time_ and arg_121_1.time_ < var_124_23 + var_124_24 and not isNil(var_124_22) then
				local var_124_25 = (arg_121_1.time_ - var_124_23) / var_124_24

				if arg_121_1.var_.characterEffect6148ui_story and not isNil(var_124_22) then
					arg_121_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_121_1.time_ >= var_124_23 + var_124_24 and arg_121_1.time_ < var_124_23 + var_124_24 + arg_124_0 and not isNil(var_124_22) and arg_121_1.var_.characterEffect6148ui_story then
				arg_121_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_124_26 = arg_121_1.actors_["1054ui_story"]
			local var_124_27 = 0

			if var_124_27 < arg_121_1.time_ and arg_121_1.time_ <= var_124_27 + arg_124_0 and not isNil(var_124_26) and arg_121_1.var_.characterEffect1054ui_story == nil then
				arg_121_1.var_.characterEffect1054ui_story = var_124_26:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_28 = 0.200000002980232

			if var_124_27 <= arg_121_1.time_ and arg_121_1.time_ < var_124_27 + var_124_28 and not isNil(var_124_26) then
				local var_124_29 = (arg_121_1.time_ - var_124_27) / var_124_28

				if arg_121_1.var_.characterEffect1054ui_story and not isNil(var_124_26) then
					local var_124_30 = Mathf.Lerp(0, 0.5, var_124_29)

					arg_121_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_121_1.var_.characterEffect1054ui_story.fillRatio = var_124_30
				end
			end

			if arg_121_1.time_ >= var_124_27 + var_124_28 and arg_121_1.time_ < var_124_27 + var_124_28 + arg_124_0 and not isNil(var_124_26) and arg_121_1.var_.characterEffect1054ui_story then
				local var_124_31 = 0.5

				arg_121_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_121_1.var_.characterEffect1054ui_story.fillRatio = var_124_31
			end

			local var_124_32 = 0

			if var_124_32 < arg_121_1.time_ and arg_121_1.time_ <= var_124_32 + arg_124_0 then
				arg_121_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action1_1")
			end

			local var_124_33 = 0

			if var_124_33 < arg_121_1.time_ and arg_121_1.time_ <= var_124_33 + arg_124_0 then
				arg_121_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_124_34 = 0
			local var_124_35 = 0.925

			if var_124_34 < arg_121_1.time_ and arg_121_1.time_ <= var_124_34 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				local var_124_36 = arg_121_1:FormatText(StoryNameCfg[1488].name)

				arg_121_1.leftNameTxt_.text = var_124_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_37 = arg_121_1:GetWordFromCfg(939012029)
				local var_124_38 = arg_121_1:FormatText(var_124_37.content)

				arg_121_1.text_.text = var_124_38

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_39 = 37
				local var_124_40 = utf8.len(var_124_38)
				local var_124_41 = var_124_39 <= 0 and var_124_35 or var_124_35 * (var_124_40 / var_124_39)

				if var_124_41 > 0 and var_124_35 < var_124_41 then
					arg_121_1.talkMaxDuration = var_124_41

					if var_124_41 + var_124_34 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_41 + var_124_34
					end
				end

				arg_121_1.text_.text = var_124_38
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)
				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_42 = math.max(var_124_35, arg_121_1.talkMaxDuration)

			if var_124_34 <= arg_121_1.time_ and arg_121_1.time_ < var_124_34 + var_124_42 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_34) / var_124_42

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_34 + var_124_42 and arg_121_1.time_ < var_124_34 + var_124_42 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_121_1:InitPlayNodeList()
	end,
	Play939012030 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 939012030
		arg_125_1.duration_ = 5

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play939012031(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = arg_125_1.actors_["1034ui_story"].transform
			local var_128_1 = 0

			if var_128_1 < arg_125_1.time_ and arg_125_1.time_ <= var_128_1 + arg_128_0 then
				arg_125_1.var_.moveOldPos1034ui_story = var_128_0.localPosition
			end

			local var_128_2 = 0.001

			if var_128_1 <= arg_125_1.time_ and arg_125_1.time_ < var_128_1 + var_128_2 then
				local var_128_3 = (arg_125_1.time_ - var_128_1) / var_128_2
				local var_128_4 = Vector3.New(-0.7, -0.93, -6)

				var_128_0.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos1034ui_story, var_128_4, var_128_3)

				local var_128_5 = manager.ui.mainCamera.transform.position - var_128_0.position

				var_128_0.forward = Vector3.New(var_128_5.x, var_128_5.y, var_128_5.z)

				local var_128_6 = var_128_0.localEulerAngles

				var_128_6.z = 0
				var_128_6.x = 0
				var_128_0.localEulerAngles = var_128_6
			end

			if arg_125_1.time_ >= var_128_1 + var_128_2 and arg_125_1.time_ < var_128_1 + var_128_2 + arg_128_0 then
				var_128_0.localPosition = Vector3.New(-0.7, -0.93, -6)

				local var_128_7 = manager.ui.mainCamera.transform.position - var_128_0.position

				var_128_0.forward = Vector3.New(var_128_7.x, var_128_7.y, var_128_7.z)

				local var_128_8 = var_128_0.localEulerAngles

				var_128_8.z = 0
				var_128_8.x = 0
				var_128_0.localEulerAngles = var_128_8
			end

			local var_128_9 = arg_125_1.actors_["1034ui_story"]
			local var_128_10 = 0

			if var_128_10 < arg_125_1.time_ and arg_125_1.time_ <= var_128_10 + arg_128_0 and not isNil(var_128_9) and arg_125_1.var_.characterEffect1034ui_story == nil then
				arg_125_1.var_.characterEffect1034ui_story = var_128_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_11 = 0.200000002980232

			if var_128_10 <= arg_125_1.time_ and arg_125_1.time_ < var_128_10 + var_128_11 and not isNil(var_128_9) then
				local var_128_12 = (arg_125_1.time_ - var_128_10) / var_128_11

				if arg_125_1.var_.characterEffect1034ui_story and not isNil(var_128_9) then
					arg_125_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_125_1.time_ >= var_128_10 + var_128_11 and arg_125_1.time_ < var_128_10 + var_128_11 + arg_128_0 and not isNil(var_128_9) and arg_125_1.var_.characterEffect1034ui_story then
				arg_125_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			local var_128_13 = arg_125_1.actors_["6148ui_story"]
			local var_128_14 = 0

			if var_128_14 < arg_125_1.time_ and arg_125_1.time_ <= var_128_14 + arg_128_0 and not isNil(var_128_13) and arg_125_1.var_.characterEffect6148ui_story == nil then
				arg_125_1.var_.characterEffect6148ui_story = var_128_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_15 = 0.200000002980232

			if var_128_14 <= arg_125_1.time_ and arg_125_1.time_ < var_128_14 + var_128_15 and not isNil(var_128_13) then
				local var_128_16 = (arg_125_1.time_ - var_128_14) / var_128_15

				if arg_125_1.var_.characterEffect6148ui_story and not isNil(var_128_13) then
					local var_128_17 = Mathf.Lerp(0, 0.5, var_128_16)

					arg_125_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_125_1.var_.characterEffect6148ui_story.fillRatio = var_128_17
				end
			end

			if arg_125_1.time_ >= var_128_14 + var_128_15 and arg_125_1.time_ < var_128_14 + var_128_15 + arg_128_0 and not isNil(var_128_13) and arg_125_1.var_.characterEffect6148ui_story then
				local var_128_18 = 0.5

				arg_125_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_125_1.var_.characterEffect6148ui_story.fillRatio = var_128_18
			end

			local var_128_19 = 0

			if var_128_19 < arg_125_1.time_ and arg_125_1.time_ <= var_128_19 + arg_128_0 then
				arg_125_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action5_2")
			end

			local var_128_20 = 0

			if var_128_20 < arg_125_1.time_ and arg_125_1.time_ <= var_128_20 + arg_128_0 then
				arg_125_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_128_21 = 0
			local var_128_22 = 1

			if var_128_21 < arg_125_1.time_ and arg_125_1.time_ <= var_128_21 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				local var_128_23 = arg_125_1:FormatText(StoryNameCfg[1109].name)

				arg_125_1.leftNameTxt_.text = var_128_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_24 = arg_125_1:GetWordFromCfg(939012030)
				local var_128_25 = arg_125_1:FormatText(var_128_24.content)

				arg_125_1.text_.text = var_128_25

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_26 = 40
				local var_128_27 = utf8.len(var_128_25)
				local var_128_28 = var_128_26 <= 0 and var_128_22 or var_128_22 * (var_128_27 / var_128_26)

				if var_128_28 > 0 and var_128_22 < var_128_28 then
					arg_125_1.talkMaxDuration = var_128_28

					if var_128_28 + var_128_21 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_28 + var_128_21
					end
				end

				arg_125_1.text_.text = var_128_25
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)
				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_29 = math.max(var_128_22, arg_125_1.talkMaxDuration)

			if var_128_21 <= arg_125_1.time_ and arg_125_1.time_ < var_128_21 + var_128_29 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_21) / var_128_29

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_21 + var_128_29 and arg_125_1.time_ < var_128_21 + var_128_29 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_125_1:InitPlayNodeList()
	end,
	Play939012031 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 939012031
		arg_129_1.duration_ = 5

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play939012032(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = arg_129_1.actors_["1034ui_story"]
			local var_132_1 = 0

			if var_132_1 < arg_129_1.time_ and arg_129_1.time_ <= var_132_1 + arg_132_0 and not isNil(var_132_0) and arg_129_1.var_.characterEffect1034ui_story == nil then
				arg_129_1.var_.characterEffect1034ui_story = var_132_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_2 = 0.200000002980232

			if var_132_1 <= arg_129_1.time_ and arg_129_1.time_ < var_132_1 + var_132_2 and not isNil(var_132_0) then
				local var_132_3 = (arg_129_1.time_ - var_132_1) / var_132_2

				if arg_129_1.var_.characterEffect1034ui_story and not isNil(var_132_0) then
					local var_132_4 = Mathf.Lerp(0, 0.5, var_132_3)

					arg_129_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_129_1.var_.characterEffect1034ui_story.fillRatio = var_132_4
				end
			end

			if arg_129_1.time_ >= var_132_1 + var_132_2 and arg_129_1.time_ < var_132_1 + var_132_2 + arg_132_0 and not isNil(var_132_0) and arg_129_1.var_.characterEffect1034ui_story then
				local var_132_5 = 0.5

				arg_129_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_129_1.var_.characterEffect1034ui_story.fillRatio = var_132_5
			end

			local var_132_6 = 0
			local var_132_7 = 0.15

			if var_132_6 < arg_129_1.time_ and arg_129_1.time_ <= var_132_6 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				local var_132_8 = arg_129_1:FormatText(StoryNameCfg[7].name)

				arg_129_1.leftNameTxt_.text = var_132_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, true)
				arg_129_1.iconController_:SetSelectedState("hero")

				arg_129_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_129_1.callingController_:SetSelectedState("normal")

				arg_129_1.keyicon_.color = Color.New(1, 1, 1)
				arg_129_1.icon_.color = Color.New(1, 1, 1)

				local var_132_9 = arg_129_1:GetWordFromCfg(939012031)
				local var_132_10 = arg_129_1:FormatText(var_132_9.content)

				arg_129_1.text_.text = var_132_10

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_11 = 6
				local var_132_12 = utf8.len(var_132_10)
				local var_132_13 = var_132_11 <= 0 and var_132_7 or var_132_7 * (var_132_12 / var_132_11)

				if var_132_13 > 0 and var_132_7 < var_132_13 then
					arg_129_1.talkMaxDuration = var_132_13

					if var_132_13 + var_132_6 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_13 + var_132_6
					end
				end

				arg_129_1.text_.text = var_132_10
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)
				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_14 = math.max(var_132_7, arg_129_1.talkMaxDuration)

			if var_132_6 <= arg_129_1.time_ and arg_129_1.time_ < var_132_6 + var_132_14 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_6) / var_132_14

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_6 + var_132_14 and arg_129_1.time_ < var_132_6 + var_132_14 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play939012032 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 939012032
		arg_133_1.duration_ = 5

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play939012033(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = arg_133_1.actors_["1034ui_story"]
			local var_136_1 = 0

			if var_136_1 < arg_133_1.time_ and arg_133_1.time_ <= var_136_1 + arg_136_0 and not isNil(var_136_0) and arg_133_1.var_.characterEffect1034ui_story == nil then
				arg_133_1.var_.characterEffect1034ui_story = var_136_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_2 = 0.200000002980232

			if var_136_1 <= arg_133_1.time_ and arg_133_1.time_ < var_136_1 + var_136_2 and not isNil(var_136_0) then
				local var_136_3 = (arg_133_1.time_ - var_136_1) / var_136_2

				if arg_133_1.var_.characterEffect1034ui_story and not isNil(var_136_0) then
					arg_133_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_133_1.time_ >= var_136_1 + var_136_2 and arg_133_1.time_ < var_136_1 + var_136_2 + arg_136_0 and not isNil(var_136_0) and arg_133_1.var_.characterEffect1034ui_story then
				arg_133_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			local var_136_4 = 0
			local var_136_5 = 1.35

			if var_136_4 < arg_133_1.time_ and arg_133_1.time_ <= var_136_4 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				local var_136_6 = arg_133_1:FormatText(StoryNameCfg[1109].name)

				arg_133_1.leftNameTxt_.text = var_136_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_7 = arg_133_1:GetWordFromCfg(939012032)
				local var_136_8 = arg_133_1:FormatText(var_136_7.content)

				arg_133_1.text_.text = var_136_8

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_9 = 54
				local var_136_10 = utf8.len(var_136_8)
				local var_136_11 = var_136_9 <= 0 and var_136_5 or var_136_5 * (var_136_10 / var_136_9)

				if var_136_11 > 0 and var_136_5 < var_136_11 then
					arg_133_1.talkMaxDuration = var_136_11

					if var_136_11 + var_136_4 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_11 + var_136_4
					end
				end

				arg_133_1.text_.text = var_136_8
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)
				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_12 = math.max(var_136_5, arg_133_1.talkMaxDuration)

			if var_136_4 <= arg_133_1.time_ and arg_133_1.time_ < var_136_4 + var_136_12 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_4) / var_136_12

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_4 + var_136_12 and arg_133_1.time_ < var_136_4 + var_136_12 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play939012033 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 939012033
		arg_137_1.duration_ = 5

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play939012034(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = arg_137_1.actors_["1034ui_story"].transform
			local var_140_1 = 0

			if var_140_1 < arg_137_1.time_ and arg_137_1.time_ <= var_140_1 + arg_140_0 then
				arg_137_1.var_.moveOldPos1034ui_story = var_140_0.localPosition
			end

			local var_140_2 = 0.001

			if var_140_1 <= arg_137_1.time_ and arg_137_1.time_ < var_140_1 + var_140_2 then
				local var_140_3 = (arg_137_1.time_ - var_140_1) / var_140_2
				local var_140_4 = Vector3.New(-0.7, -0.93, -6)

				var_140_0.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos1034ui_story, var_140_4, var_140_3)

				local var_140_5 = manager.ui.mainCamera.transform.position - var_140_0.position

				var_140_0.forward = Vector3.New(var_140_5.x, var_140_5.y, var_140_5.z)

				local var_140_6 = var_140_0.localEulerAngles

				var_140_6.z = 0
				var_140_6.x = 0
				var_140_0.localEulerAngles = var_140_6
			end

			if arg_137_1.time_ >= var_140_1 + var_140_2 and arg_137_1.time_ < var_140_1 + var_140_2 + arg_140_0 then
				var_140_0.localPosition = Vector3.New(-0.7, -0.93, -6)

				local var_140_7 = manager.ui.mainCamera.transform.position - var_140_0.position

				var_140_0.forward = Vector3.New(var_140_7.x, var_140_7.y, var_140_7.z)

				local var_140_8 = var_140_0.localEulerAngles

				var_140_8.z = 0
				var_140_8.x = 0
				var_140_0.localEulerAngles = var_140_8
			end

			local var_140_9 = 0

			if var_140_9 < arg_137_1.time_ and arg_137_1.time_ <= var_140_9 + arg_140_0 then
				arg_137_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action7_1")
			end

			local var_140_10 = 0

			if var_140_10 < arg_137_1.time_ and arg_137_1.time_ <= var_140_10 + arg_140_0 then
				arg_137_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_140_11 = 0
			local var_140_12 = 0.4

			if var_140_11 < arg_137_1.time_ and arg_137_1.time_ <= var_140_11 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				local var_140_13 = arg_137_1:FormatText(StoryNameCfg[1109].name)

				arg_137_1.leftNameTxt_.text = var_140_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_14 = arg_137_1:GetWordFromCfg(939012033)
				local var_140_15 = arg_137_1:FormatText(var_140_14.content)

				arg_137_1.text_.text = var_140_15

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_16 = 16
				local var_140_17 = utf8.len(var_140_15)
				local var_140_18 = var_140_16 <= 0 and var_140_12 or var_140_12 * (var_140_17 / var_140_16)

				if var_140_18 > 0 and var_140_12 < var_140_18 then
					arg_137_1.talkMaxDuration = var_140_18

					if var_140_18 + var_140_11 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_18 + var_140_11
					end
				end

				arg_137_1.text_.text = var_140_15
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)
				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_19 = math.max(var_140_12, arg_137_1.talkMaxDuration)

			if var_140_11 <= arg_137_1.time_ and arg_137_1.time_ < var_140_11 + var_140_19 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_11) / var_140_19

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_11 + var_140_19 and arg_137_1.time_ < var_140_11 + var_140_19 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_137_1:InitPlayNodeList()
	end,
	Play939012034 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 939012034
		arg_141_1.duration_ = 5

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play939012035(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = arg_141_1.actors_["1034ui_story"]
			local var_144_1 = 0

			if var_144_1 < arg_141_1.time_ and arg_141_1.time_ <= var_144_1 + arg_144_0 and not isNil(var_144_0) and arg_141_1.var_.characterEffect1034ui_story == nil then
				arg_141_1.var_.characterEffect1034ui_story = var_144_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_2 = 0.200000002980232

			if var_144_1 <= arg_141_1.time_ and arg_141_1.time_ < var_144_1 + var_144_2 and not isNil(var_144_0) then
				local var_144_3 = (arg_141_1.time_ - var_144_1) / var_144_2

				if arg_141_1.var_.characterEffect1034ui_story and not isNil(var_144_0) then
					local var_144_4 = Mathf.Lerp(0, 0.5, var_144_3)

					arg_141_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_141_1.var_.characterEffect1034ui_story.fillRatio = var_144_4
				end
			end

			if arg_141_1.time_ >= var_144_1 + var_144_2 and arg_141_1.time_ < var_144_1 + var_144_2 + arg_144_0 and not isNil(var_144_0) and arg_141_1.var_.characterEffect1034ui_story then
				local var_144_5 = 0.5

				arg_141_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_141_1.var_.characterEffect1034ui_story.fillRatio = var_144_5
			end

			local var_144_6 = 0
			local var_144_7 = 0.25

			if var_144_6 < arg_141_1.time_ and arg_141_1.time_ <= var_144_6 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				local var_144_8 = arg_141_1:FormatText(StoryNameCfg[7].name)

				arg_141_1.leftNameTxt_.text = var_144_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, true)
				arg_141_1.iconController_:SetSelectedState("hero")

				arg_141_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_141_1.callingController_:SetSelectedState("normal")

				arg_141_1.keyicon_.color = Color.New(1, 1, 1)
				arg_141_1.icon_.color = Color.New(1, 1, 1)

				local var_144_9 = arg_141_1:GetWordFromCfg(939012034)
				local var_144_10 = arg_141_1:FormatText(var_144_9.content)

				arg_141_1.text_.text = var_144_10

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_11 = 10
				local var_144_12 = utf8.len(var_144_10)
				local var_144_13 = var_144_11 <= 0 and var_144_7 or var_144_7 * (var_144_12 / var_144_11)

				if var_144_13 > 0 and var_144_7 < var_144_13 then
					arg_141_1.talkMaxDuration = var_144_13

					if var_144_13 + var_144_6 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_13 + var_144_6
					end
				end

				arg_141_1.text_.text = var_144_10
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)
				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_14 = math.max(var_144_7, arg_141_1.talkMaxDuration)

			if var_144_6 <= arg_141_1.time_ and arg_141_1.time_ < var_144_6 + var_144_14 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_6) / var_144_14

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_6 + var_144_14 and arg_141_1.time_ < var_144_6 + var_144_14 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play939012035 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 939012035
		arg_145_1.duration_ = 5

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play939012036(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = arg_145_1.actors_["1034ui_story"].transform
			local var_148_1 = 0

			if var_148_1 < arg_145_1.time_ and arg_145_1.time_ <= var_148_1 + arg_148_0 then
				arg_145_1.var_.moveOldPos1034ui_story = var_148_0.localPosition
			end

			local var_148_2 = 0.001

			if var_148_1 <= arg_145_1.time_ and arg_145_1.time_ < var_148_1 + var_148_2 then
				local var_148_3 = (arg_145_1.time_ - var_148_1) / var_148_2
				local var_148_4 = Vector3.New(0, 100, 0)

				var_148_0.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos1034ui_story, var_148_4, var_148_3)

				local var_148_5 = manager.ui.mainCamera.transform.position - var_148_0.position

				var_148_0.forward = Vector3.New(var_148_5.x, var_148_5.y, var_148_5.z)

				local var_148_6 = var_148_0.localEulerAngles

				var_148_6.z = 0
				var_148_6.x = 0
				var_148_0.localEulerAngles = var_148_6
			end

			if arg_145_1.time_ >= var_148_1 + var_148_2 and arg_145_1.time_ < var_148_1 + var_148_2 + arg_148_0 then
				var_148_0.localPosition = Vector3.New(0, 100, 0)

				local var_148_7 = manager.ui.mainCamera.transform.position - var_148_0.position

				var_148_0.forward = Vector3.New(var_148_7.x, var_148_7.y, var_148_7.z)

				local var_148_8 = var_148_0.localEulerAngles

				var_148_8.z = 0
				var_148_8.x = 0
				var_148_0.localEulerAngles = var_148_8
			end

			local var_148_9 = arg_145_1.actors_["6148ui_story"].transform
			local var_148_10 = 0

			if var_148_10 < arg_145_1.time_ and arg_145_1.time_ <= var_148_10 + arg_148_0 then
				arg_145_1.var_.moveOldPos6148ui_story = var_148_9.localPosition

				local var_148_11 = GameObjectTools.GetOrAddComponent(var_148_9.gameObject, typeof(DynamicBoneHelper))

				if var_148_11 then
					var_148_11:EnableDynamicBone(false)
				end
			end

			local var_148_12 = 0.001

			if var_148_10 <= arg_145_1.time_ and arg_145_1.time_ < var_148_10 + var_148_12 then
				local var_148_13 = (arg_145_1.time_ - var_148_10) / var_148_12
				local var_148_14 = Vector3.New(0, 100, 0)

				var_148_9.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos6148ui_story, var_148_14, var_148_13)

				local var_148_15 = manager.ui.mainCamera.transform.position - var_148_9.position

				var_148_9.forward = Vector3.New(var_148_15.x, var_148_15.y, var_148_15.z)

				local var_148_16 = var_148_9.localEulerAngles

				var_148_16.z = 0
				var_148_16.x = 0
				var_148_9.localEulerAngles = var_148_16
			end

			if arg_145_1.time_ >= var_148_10 + var_148_12 and arg_145_1.time_ < var_148_10 + var_148_12 + arg_148_0 then
				var_148_9.localPosition = Vector3.New(0, 100, 0)

				local var_148_17 = manager.ui.mainCamera.transform.position - var_148_9.position

				var_148_9.forward = Vector3.New(var_148_17.x, var_148_17.y, var_148_17.z)

				local var_148_18 = var_148_9.localEulerAngles

				var_148_18.z = 0
				var_148_18.x = 0
				var_148_9.localEulerAngles = var_148_18

				local var_148_19 = GameObjectTools.GetOrAddComponent(var_148_9.gameObject, typeof(DynamicBoneHelper))

				if var_148_19 then
					var_148_19:EnableDynamicBone(true)
				end
			end

			local var_148_20 = 0
			local var_148_21 = 0.725

			if var_148_20 < arg_145_1.time_ and arg_145_1.time_ <= var_148_20 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, false)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_22 = arg_145_1:GetWordFromCfg(939012035)
				local var_148_23 = arg_145_1:FormatText(var_148_22.content)

				arg_145_1.text_.text = var_148_23

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_24 = 29
				local var_148_25 = utf8.len(var_148_23)
				local var_148_26 = var_148_24 <= 0 and var_148_21 or var_148_21 * (var_148_25 / var_148_24)

				if var_148_26 > 0 and var_148_21 < var_148_26 then
					arg_145_1.talkMaxDuration = var_148_26

					if var_148_26 + var_148_20 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_26 + var_148_20
					end
				end

				arg_145_1.text_.text = var_148_23
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)
				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_27 = math.max(var_148_21, arg_145_1.talkMaxDuration)

			if var_148_20 <= arg_145_1.time_ and arg_145_1.time_ < var_148_20 + var_148_27 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_20) / var_148_27

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_20 + var_148_27 and arg_145_1.time_ < var_148_20 + var_148_27 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_145_1:InitPlayNodeList()
	end,
	Play939012036 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 939012036
		arg_149_1.duration_ = 5

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play939012037(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = arg_149_1.actors_["1034ui_story"].transform
			local var_152_1 = 0

			if var_152_1 < arg_149_1.time_ and arg_149_1.time_ <= var_152_1 + arg_152_0 then
				arg_149_1.var_.moveOldPos1034ui_story = var_152_0.localPosition
			end

			local var_152_2 = 0.001

			if var_152_1 <= arg_149_1.time_ and arg_149_1.time_ < var_152_1 + var_152_2 then
				local var_152_3 = (arg_149_1.time_ - var_152_1) / var_152_2
				local var_152_4 = Vector3.New(0, -0.93, -6)

				var_152_0.localPosition = Vector3.Lerp(arg_149_1.var_.moveOldPos1034ui_story, var_152_4, var_152_3)

				local var_152_5 = manager.ui.mainCamera.transform.position - var_152_0.position

				var_152_0.forward = Vector3.New(var_152_5.x, var_152_5.y, var_152_5.z)

				local var_152_6 = var_152_0.localEulerAngles

				var_152_6.z = 0
				var_152_6.x = 0
				var_152_0.localEulerAngles = var_152_6
			end

			if arg_149_1.time_ >= var_152_1 + var_152_2 and arg_149_1.time_ < var_152_1 + var_152_2 + arg_152_0 then
				var_152_0.localPosition = Vector3.New(0, -0.93, -6)

				local var_152_7 = manager.ui.mainCamera.transform.position - var_152_0.position

				var_152_0.forward = Vector3.New(var_152_7.x, var_152_7.y, var_152_7.z)

				local var_152_8 = var_152_0.localEulerAngles

				var_152_8.z = 0
				var_152_8.x = 0
				var_152_0.localEulerAngles = var_152_8
			end

			local var_152_9 = arg_149_1.actors_["1034ui_story"]
			local var_152_10 = 0

			if var_152_10 < arg_149_1.time_ and arg_149_1.time_ <= var_152_10 + arg_152_0 and not isNil(var_152_9) and arg_149_1.var_.characterEffect1034ui_story == nil then
				arg_149_1.var_.characterEffect1034ui_story = var_152_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_11 = 0.200000002980232

			if var_152_10 <= arg_149_1.time_ and arg_149_1.time_ < var_152_10 + var_152_11 and not isNil(var_152_9) then
				local var_152_12 = (arg_149_1.time_ - var_152_10) / var_152_11

				if arg_149_1.var_.characterEffect1034ui_story and not isNil(var_152_9) then
					arg_149_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_149_1.time_ >= var_152_10 + var_152_11 and arg_149_1.time_ < var_152_10 + var_152_11 + arg_152_0 and not isNil(var_152_9) and arg_149_1.var_.characterEffect1034ui_story then
				arg_149_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			local var_152_13 = 0

			if var_152_13 < arg_149_1.time_ and arg_149_1.time_ <= var_152_13 + arg_152_0 then
				arg_149_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action4_1")
			end

			local var_152_14 = 0

			if var_152_14 < arg_149_1.time_ and arg_149_1.time_ <= var_152_14 + arg_152_0 then
				arg_149_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_152_15 = 0
			local var_152_16 = 1.275

			if var_152_15 < arg_149_1.time_ and arg_149_1.time_ <= var_152_15 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				local var_152_17 = arg_149_1:FormatText(StoryNameCfg[1109].name)

				arg_149_1.leftNameTxt_.text = var_152_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_18 = arg_149_1:GetWordFromCfg(939012036)
				local var_152_19 = arg_149_1:FormatText(var_152_18.content)

				arg_149_1.text_.text = var_152_19

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_20 = 51
				local var_152_21 = utf8.len(var_152_19)
				local var_152_22 = var_152_20 <= 0 and var_152_16 or var_152_16 * (var_152_21 / var_152_20)

				if var_152_22 > 0 and var_152_16 < var_152_22 then
					arg_149_1.talkMaxDuration = var_152_22

					if var_152_22 + var_152_15 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_22 + var_152_15
					end
				end

				arg_149_1.text_.text = var_152_19
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)
				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_23 = math.max(var_152_16, arg_149_1.talkMaxDuration)

			if var_152_15 <= arg_149_1.time_ and arg_149_1.time_ < var_152_15 + var_152_23 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_15) / var_152_23

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_15 + var_152_23 and arg_149_1.time_ < var_152_15 + var_152_23 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_149_1:InitPlayNodeList()
	end,
	Play939012037 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 939012037
		arg_153_1.duration_ = 5

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play939012038(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = arg_153_1.actors_["1034ui_story"]
			local var_156_1 = 0

			if var_156_1 < arg_153_1.time_ and arg_153_1.time_ <= var_156_1 + arg_156_0 and not isNil(var_156_0) and arg_153_1.var_.characterEffect1034ui_story == nil then
				arg_153_1.var_.characterEffect1034ui_story = var_156_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_2 = 0.200000002980232

			if var_156_1 <= arg_153_1.time_ and arg_153_1.time_ < var_156_1 + var_156_2 and not isNil(var_156_0) then
				local var_156_3 = (arg_153_1.time_ - var_156_1) / var_156_2

				if arg_153_1.var_.characterEffect1034ui_story and not isNil(var_156_0) then
					local var_156_4 = Mathf.Lerp(0, 0.5, var_156_3)

					arg_153_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_153_1.var_.characterEffect1034ui_story.fillRatio = var_156_4
				end
			end

			if arg_153_1.time_ >= var_156_1 + var_156_2 and arg_153_1.time_ < var_156_1 + var_156_2 + arg_156_0 and not isNil(var_156_0) and arg_153_1.var_.characterEffect1034ui_story then
				local var_156_5 = 0.5

				arg_153_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_153_1.var_.characterEffect1034ui_story.fillRatio = var_156_5
			end

			local var_156_6 = 0
			local var_156_7 = 0.325

			if var_156_6 < arg_153_1.time_ and arg_153_1.time_ <= var_156_6 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				local var_156_8 = arg_153_1:FormatText(StoryNameCfg[7].name)

				arg_153_1.leftNameTxt_.text = var_156_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, true)
				arg_153_1.iconController_:SetSelectedState("hero")

				arg_153_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_153_1.callingController_:SetSelectedState("normal")

				arg_153_1.keyicon_.color = Color.New(1, 1, 1)
				arg_153_1.icon_.color = Color.New(1, 1, 1)

				local var_156_9 = arg_153_1:GetWordFromCfg(939012037)
				local var_156_10 = arg_153_1:FormatText(var_156_9.content)

				arg_153_1.text_.text = var_156_10

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_11 = 13
				local var_156_12 = utf8.len(var_156_10)
				local var_156_13 = var_156_11 <= 0 and var_156_7 or var_156_7 * (var_156_12 / var_156_11)

				if var_156_13 > 0 and var_156_7 < var_156_13 then
					arg_153_1.talkMaxDuration = var_156_13

					if var_156_13 + var_156_6 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_13 + var_156_6
					end
				end

				arg_153_1.text_.text = var_156_10
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)
				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_14 = math.max(var_156_7, arg_153_1.talkMaxDuration)

			if var_156_6 <= arg_153_1.time_ and arg_153_1.time_ < var_156_6 + var_156_14 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_6) / var_156_14

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_6 + var_156_14 and arg_153_1.time_ < var_156_6 + var_156_14 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play939012038 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 939012038
		arg_157_1.duration_ = 5

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play939012039(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = arg_157_1.actors_["1034ui_story"].transform
			local var_160_1 = 0

			if var_160_1 < arg_157_1.time_ and arg_157_1.time_ <= var_160_1 + arg_160_0 then
				arg_157_1.var_.moveOldPos1034ui_story = var_160_0.localPosition
			end

			local var_160_2 = 0.001

			if var_160_1 <= arg_157_1.time_ and arg_157_1.time_ < var_160_1 + var_160_2 then
				local var_160_3 = (arg_157_1.time_ - var_160_1) / var_160_2
				local var_160_4 = Vector3.New(0, -0.93, -6)

				var_160_0.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos1034ui_story, var_160_4, var_160_3)

				local var_160_5 = manager.ui.mainCamera.transform.position - var_160_0.position

				var_160_0.forward = Vector3.New(var_160_5.x, var_160_5.y, var_160_5.z)

				local var_160_6 = var_160_0.localEulerAngles

				var_160_6.z = 0
				var_160_6.x = 0
				var_160_0.localEulerAngles = var_160_6
			end

			if arg_157_1.time_ >= var_160_1 + var_160_2 and arg_157_1.time_ < var_160_1 + var_160_2 + arg_160_0 then
				var_160_0.localPosition = Vector3.New(0, -0.93, -6)

				local var_160_7 = manager.ui.mainCamera.transform.position - var_160_0.position

				var_160_0.forward = Vector3.New(var_160_7.x, var_160_7.y, var_160_7.z)

				local var_160_8 = var_160_0.localEulerAngles

				var_160_8.z = 0
				var_160_8.x = 0
				var_160_0.localEulerAngles = var_160_8
			end

			local var_160_9 = arg_157_1.actors_["1034ui_story"]
			local var_160_10 = 0

			if var_160_10 < arg_157_1.time_ and arg_157_1.time_ <= var_160_10 + arg_160_0 and not isNil(var_160_9) and arg_157_1.var_.characterEffect1034ui_story == nil then
				arg_157_1.var_.characterEffect1034ui_story = var_160_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_11 = 0.200000002980232

			if var_160_10 <= arg_157_1.time_ and arg_157_1.time_ < var_160_10 + var_160_11 and not isNil(var_160_9) then
				local var_160_12 = (arg_157_1.time_ - var_160_10) / var_160_11

				if arg_157_1.var_.characterEffect1034ui_story and not isNil(var_160_9) then
					arg_157_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_157_1.time_ >= var_160_10 + var_160_11 and arg_157_1.time_ < var_160_10 + var_160_11 + arg_160_0 and not isNil(var_160_9) and arg_157_1.var_.characterEffect1034ui_story then
				arg_157_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			local var_160_13 = 0

			if var_160_13 < arg_157_1.time_ and arg_157_1.time_ <= var_160_13 + arg_160_0 then
				arg_157_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034actionlink/1034action447")
			end

			local var_160_14 = 0

			if var_160_14 < arg_157_1.time_ and arg_157_1.time_ <= var_160_14 + arg_160_0 then
				arg_157_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_160_15 = 0
			local var_160_16 = 0.5

			if var_160_15 < arg_157_1.time_ and arg_157_1.time_ <= var_160_15 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				local var_160_17 = arg_157_1:FormatText(StoryNameCfg[1109].name)

				arg_157_1.leftNameTxt_.text = var_160_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_18 = arg_157_1:GetWordFromCfg(939012038)
				local var_160_19 = arg_157_1:FormatText(var_160_18.content)

				arg_157_1.text_.text = var_160_19

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_20 = 20
				local var_160_21 = utf8.len(var_160_19)
				local var_160_22 = var_160_20 <= 0 and var_160_16 or var_160_16 * (var_160_21 / var_160_20)

				if var_160_22 > 0 and var_160_16 < var_160_22 then
					arg_157_1.talkMaxDuration = var_160_22

					if var_160_22 + var_160_15 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_22 + var_160_15
					end
				end

				arg_157_1.text_.text = var_160_19
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)
				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_23 = math.max(var_160_16, arg_157_1.talkMaxDuration)

			if var_160_15 <= arg_157_1.time_ and arg_157_1.time_ < var_160_15 + var_160_23 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_15) / var_160_23

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_15 + var_160_23 and arg_157_1.time_ < var_160_15 + var_160_23 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_157_1:InitPlayNodeList()
	end,
	Play939012039 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 939012039
		arg_161_1.duration_ = 5

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play939012040(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = arg_161_1.actors_["6148ui_story"].transform
			local var_164_1 = 0

			if var_164_1 < arg_161_1.time_ and arg_161_1.time_ <= var_164_1 + arg_164_0 then
				arg_161_1.var_.moveOldPos6148ui_story = var_164_0.localPosition

				local var_164_2 = GameObjectTools.GetOrAddComponent(var_164_0.gameObject, typeof(DynamicBoneHelper))

				if var_164_2 then
					var_164_2:EnableDynamicBone(false)
				end
			end

			local var_164_3 = 0.001

			if var_164_1 <= arg_161_1.time_ and arg_161_1.time_ < var_164_1 + var_164_3 then
				local var_164_4 = (arg_161_1.time_ - var_164_1) / var_164_3
				local var_164_5 = Vector3.New(0.7, -0.985, -6)

				var_164_0.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos6148ui_story, var_164_5, var_164_4)

				local var_164_6 = manager.ui.mainCamera.transform.position - var_164_0.position

				var_164_0.forward = Vector3.New(var_164_6.x, var_164_6.y, var_164_6.z)

				local var_164_7 = var_164_0.localEulerAngles

				var_164_7.z = 0
				var_164_7.x = 0
				var_164_0.localEulerAngles = var_164_7
			end

			if arg_161_1.time_ >= var_164_1 + var_164_3 and arg_161_1.time_ < var_164_1 + var_164_3 + arg_164_0 then
				var_164_0.localPosition = Vector3.New(0.7, -0.985, -6)

				local var_164_8 = manager.ui.mainCamera.transform.position - var_164_0.position

				var_164_0.forward = Vector3.New(var_164_8.x, var_164_8.y, var_164_8.z)

				local var_164_9 = var_164_0.localEulerAngles

				var_164_9.z = 0
				var_164_9.x = 0
				var_164_0.localEulerAngles = var_164_9

				local var_164_10 = GameObjectTools.GetOrAddComponent(var_164_0.gameObject, typeof(DynamicBoneHelper))

				if var_164_10 then
					var_164_10:EnableDynamicBone(true)
				end
			end

			local var_164_11 = arg_161_1.actors_["1034ui_story"].transform
			local var_164_12 = 0

			if var_164_12 < arg_161_1.time_ and arg_161_1.time_ <= var_164_12 + arg_164_0 then
				arg_161_1.var_.moveOldPos1034ui_story = var_164_11.localPosition
			end

			local var_164_13 = 0.001

			if var_164_12 <= arg_161_1.time_ and arg_161_1.time_ < var_164_12 + var_164_13 then
				local var_164_14 = (arg_161_1.time_ - var_164_12) / var_164_13
				local var_164_15 = Vector3.New(-0.7, -0.93, -6)

				var_164_11.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos1034ui_story, var_164_15, var_164_14)

				local var_164_16 = manager.ui.mainCamera.transform.position - var_164_11.position

				var_164_11.forward = Vector3.New(var_164_16.x, var_164_16.y, var_164_16.z)

				local var_164_17 = var_164_11.localEulerAngles

				var_164_17.z = 0
				var_164_17.x = 0
				var_164_11.localEulerAngles = var_164_17
			end

			if arg_161_1.time_ >= var_164_12 + var_164_13 and arg_161_1.time_ < var_164_12 + var_164_13 + arg_164_0 then
				var_164_11.localPosition = Vector3.New(-0.7, -0.93, -6)

				local var_164_18 = manager.ui.mainCamera.transform.position - var_164_11.position

				var_164_11.forward = Vector3.New(var_164_18.x, var_164_18.y, var_164_18.z)

				local var_164_19 = var_164_11.localEulerAngles

				var_164_19.z = 0
				var_164_19.x = 0
				var_164_11.localEulerAngles = var_164_19
			end

			local var_164_20 = arg_161_1.actors_["6148ui_story"]
			local var_164_21 = 0

			if var_164_21 < arg_161_1.time_ and arg_161_1.time_ <= var_164_21 + arg_164_0 and not isNil(var_164_20) and arg_161_1.var_.characterEffect6148ui_story == nil then
				arg_161_1.var_.characterEffect6148ui_story = var_164_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_22 = 0.200000002980232

			if var_164_21 <= arg_161_1.time_ and arg_161_1.time_ < var_164_21 + var_164_22 and not isNil(var_164_20) then
				local var_164_23 = (arg_161_1.time_ - var_164_21) / var_164_22

				if arg_161_1.var_.characterEffect6148ui_story and not isNil(var_164_20) then
					arg_161_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_161_1.time_ >= var_164_21 + var_164_22 and arg_161_1.time_ < var_164_21 + var_164_22 + arg_164_0 and not isNil(var_164_20) and arg_161_1.var_.characterEffect6148ui_story then
				arg_161_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_164_24 = arg_161_1.actors_["1034ui_story"]
			local var_164_25 = 0

			if var_164_25 < arg_161_1.time_ and arg_161_1.time_ <= var_164_25 + arg_164_0 and not isNil(var_164_24) and arg_161_1.var_.characterEffect1034ui_story == nil then
				arg_161_1.var_.characterEffect1034ui_story = var_164_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_26 = 0.200000002980232

			if var_164_25 <= arg_161_1.time_ and arg_161_1.time_ < var_164_25 + var_164_26 and not isNil(var_164_24) then
				local var_164_27 = (arg_161_1.time_ - var_164_25) / var_164_26

				if arg_161_1.var_.characterEffect1034ui_story and not isNil(var_164_24) then
					local var_164_28 = Mathf.Lerp(0, 0.5, var_164_27)

					arg_161_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_161_1.var_.characterEffect1034ui_story.fillRatio = var_164_28
				end
			end

			if arg_161_1.time_ >= var_164_25 + var_164_26 and arg_161_1.time_ < var_164_25 + var_164_26 + arg_164_0 and not isNil(var_164_24) and arg_161_1.var_.characterEffect1034ui_story then
				local var_164_29 = 0.5

				arg_161_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_161_1.var_.characterEffect1034ui_story.fillRatio = var_164_29
			end

			local var_164_30 = 0

			if var_164_30 < arg_161_1.time_ and arg_161_1.time_ <= var_164_30 + arg_164_0 then
				arg_161_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action5_1")
			end

			local var_164_31 = 0

			if var_164_31 < arg_161_1.time_ and arg_161_1.time_ <= var_164_31 + arg_164_0 then
				arg_161_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_164_32 = 0
			local var_164_33 = 0.375

			if var_164_32 < arg_161_1.time_ and arg_161_1.time_ <= var_164_32 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				local var_164_34 = arg_161_1:FormatText(StoryNameCfg[1488].name)

				arg_161_1.leftNameTxt_.text = var_164_34

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_35 = arg_161_1:GetWordFromCfg(939012039)
				local var_164_36 = arg_161_1:FormatText(var_164_35.content)

				arg_161_1.text_.text = var_164_36

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_37 = 15
				local var_164_38 = utf8.len(var_164_36)
				local var_164_39 = var_164_37 <= 0 and var_164_33 or var_164_33 * (var_164_38 / var_164_37)

				if var_164_39 > 0 and var_164_33 < var_164_39 then
					arg_161_1.talkMaxDuration = var_164_39

					if var_164_39 + var_164_32 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_39 + var_164_32
					end
				end

				arg_161_1.text_.text = var_164_36
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)
				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_40 = math.max(var_164_33, arg_161_1.talkMaxDuration)

			if var_164_32 <= arg_161_1.time_ and arg_161_1.time_ < var_164_32 + var_164_40 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_32) / var_164_40

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_32 + var_164_40 and arg_161_1.time_ < var_164_32 + var_164_40 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1034ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_161_1:InitPlayNodeList()
	end,
	Play939012040 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 939012040
		arg_165_1.duration_ = 5

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play939012041(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = arg_165_1.actors_["1034ui_story"].transform
			local var_168_1 = 0

			if var_168_1 < arg_165_1.time_ and arg_165_1.time_ <= var_168_1 + arg_168_0 then
				arg_165_1.var_.moveOldPos1034ui_story = var_168_0.localPosition
			end

			local var_168_2 = 0.001

			if var_168_1 <= arg_165_1.time_ and arg_165_1.time_ < var_168_1 + var_168_2 then
				local var_168_3 = (arg_165_1.time_ - var_168_1) / var_168_2
				local var_168_4 = Vector3.New(-0.7, -0.93, -6)

				var_168_0.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPos1034ui_story, var_168_4, var_168_3)

				local var_168_5 = manager.ui.mainCamera.transform.position - var_168_0.position

				var_168_0.forward = Vector3.New(var_168_5.x, var_168_5.y, var_168_5.z)

				local var_168_6 = var_168_0.localEulerAngles

				var_168_6.z = 0
				var_168_6.x = 0
				var_168_0.localEulerAngles = var_168_6
			end

			if arg_165_1.time_ >= var_168_1 + var_168_2 and arg_165_1.time_ < var_168_1 + var_168_2 + arg_168_0 then
				var_168_0.localPosition = Vector3.New(-0.7, -0.93, -6)

				local var_168_7 = manager.ui.mainCamera.transform.position - var_168_0.position

				var_168_0.forward = Vector3.New(var_168_7.x, var_168_7.y, var_168_7.z)

				local var_168_8 = var_168_0.localEulerAngles

				var_168_8.z = 0
				var_168_8.x = 0
				var_168_0.localEulerAngles = var_168_8
			end

			local var_168_9 = arg_165_1.actors_["1034ui_story"]
			local var_168_10 = 0

			if var_168_10 < arg_165_1.time_ and arg_165_1.time_ <= var_168_10 + arg_168_0 and not isNil(var_168_9) and arg_165_1.var_.characterEffect1034ui_story == nil then
				arg_165_1.var_.characterEffect1034ui_story = var_168_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_11 = 0.200000002980232

			if var_168_10 <= arg_165_1.time_ and arg_165_1.time_ < var_168_10 + var_168_11 and not isNil(var_168_9) then
				local var_168_12 = (arg_165_1.time_ - var_168_10) / var_168_11

				if arg_165_1.var_.characterEffect1034ui_story and not isNil(var_168_9) then
					arg_165_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_165_1.time_ >= var_168_10 + var_168_11 and arg_165_1.time_ < var_168_10 + var_168_11 + arg_168_0 and not isNil(var_168_9) and arg_165_1.var_.characterEffect1034ui_story then
				arg_165_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			local var_168_13 = arg_165_1.actors_["6148ui_story"]
			local var_168_14 = 0

			if var_168_14 < arg_165_1.time_ and arg_165_1.time_ <= var_168_14 + arg_168_0 and not isNil(var_168_13) and arg_165_1.var_.characterEffect6148ui_story == nil then
				arg_165_1.var_.characterEffect6148ui_story = var_168_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_15 = 0.200000002980232

			if var_168_14 <= arg_165_1.time_ and arg_165_1.time_ < var_168_14 + var_168_15 and not isNil(var_168_13) then
				local var_168_16 = (arg_165_1.time_ - var_168_14) / var_168_15

				if arg_165_1.var_.characterEffect6148ui_story and not isNil(var_168_13) then
					local var_168_17 = Mathf.Lerp(0, 0.5, var_168_16)

					arg_165_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_165_1.var_.characterEffect6148ui_story.fillRatio = var_168_17
				end
			end

			if arg_165_1.time_ >= var_168_14 + var_168_15 and arg_165_1.time_ < var_168_14 + var_168_15 + arg_168_0 and not isNil(var_168_13) and arg_165_1.var_.characterEffect6148ui_story then
				local var_168_18 = 0.5

				arg_165_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_165_1.var_.characterEffect6148ui_story.fillRatio = var_168_18
			end

			local var_168_19 = 0

			if var_168_19 < arg_165_1.time_ and arg_165_1.time_ <= var_168_19 + arg_168_0 then
				arg_165_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action7_2")
			end

			local var_168_20 = 0

			if var_168_20 < arg_165_1.time_ and arg_165_1.time_ <= var_168_20 + arg_168_0 then
				arg_165_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_xinwei", "EmotionTimelineAnimator")
			end

			local var_168_21 = 0
			local var_168_22 = 0.375

			if var_168_21 < arg_165_1.time_ and arg_165_1.time_ <= var_168_21 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				local var_168_23 = arg_165_1:FormatText(StoryNameCfg[1109].name)

				arg_165_1.leftNameTxt_.text = var_168_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_24 = arg_165_1:GetWordFromCfg(939012040)
				local var_168_25 = arg_165_1:FormatText(var_168_24.content)

				arg_165_1.text_.text = var_168_25

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_26 = 15
				local var_168_27 = utf8.len(var_168_25)
				local var_168_28 = var_168_26 <= 0 and var_168_22 or var_168_22 * (var_168_27 / var_168_26)

				if var_168_28 > 0 and var_168_22 < var_168_28 then
					arg_165_1.talkMaxDuration = var_168_28

					if var_168_28 + var_168_21 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_28 + var_168_21
					end
				end

				arg_165_1.text_.text = var_168_25
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)
				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_29 = math.max(var_168_22, arg_165_1.talkMaxDuration)

			if var_168_21 <= arg_165_1.time_ and arg_165_1.time_ < var_168_21 + var_168_29 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_21) / var_168_29

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_21 + var_168_29 and arg_165_1.time_ < var_168_21 + var_168_29 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_165_1:InitPlayNodeList()
	end,
	Play939012041 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 939012041
		arg_169_1.duration_ = 5

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play939012042(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = arg_169_1.actors_["1034ui_story"].transform
			local var_172_1 = 0

			if var_172_1 < arg_169_1.time_ and arg_169_1.time_ <= var_172_1 + arg_172_0 then
				arg_169_1.var_.moveOldPos1034ui_story = var_172_0.localPosition
			end

			local var_172_2 = 0.001

			if var_172_1 <= arg_169_1.time_ and arg_169_1.time_ < var_172_1 + var_172_2 then
				local var_172_3 = (arg_169_1.time_ - var_172_1) / var_172_2
				local var_172_4 = Vector3.New(0, 100, 0)

				var_172_0.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPos1034ui_story, var_172_4, var_172_3)

				local var_172_5 = manager.ui.mainCamera.transform.position - var_172_0.position

				var_172_0.forward = Vector3.New(var_172_5.x, var_172_5.y, var_172_5.z)

				local var_172_6 = var_172_0.localEulerAngles

				var_172_6.z = 0
				var_172_6.x = 0
				var_172_0.localEulerAngles = var_172_6
			end

			if arg_169_1.time_ >= var_172_1 + var_172_2 and arg_169_1.time_ < var_172_1 + var_172_2 + arg_172_0 then
				var_172_0.localPosition = Vector3.New(0, 100, 0)

				local var_172_7 = manager.ui.mainCamera.transform.position - var_172_0.position

				var_172_0.forward = Vector3.New(var_172_7.x, var_172_7.y, var_172_7.z)

				local var_172_8 = var_172_0.localEulerAngles

				var_172_8.z = 0
				var_172_8.x = 0
				var_172_0.localEulerAngles = var_172_8
			end

			local var_172_9 = arg_169_1.actors_["6148ui_story"].transform
			local var_172_10 = 0

			if var_172_10 < arg_169_1.time_ and arg_169_1.time_ <= var_172_10 + arg_172_0 then
				arg_169_1.var_.moveOldPos6148ui_story = var_172_9.localPosition

				local var_172_11 = GameObjectTools.GetOrAddComponent(var_172_9.gameObject, typeof(DynamicBoneHelper))

				if var_172_11 then
					var_172_11:EnableDynamicBone(false)
				end
			end

			local var_172_12 = 0.001

			if var_172_10 <= arg_169_1.time_ and arg_169_1.time_ < var_172_10 + var_172_12 then
				local var_172_13 = (arg_169_1.time_ - var_172_10) / var_172_12
				local var_172_14 = Vector3.New(0, 100, 0)

				var_172_9.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPos6148ui_story, var_172_14, var_172_13)

				local var_172_15 = manager.ui.mainCamera.transform.position - var_172_9.position

				var_172_9.forward = Vector3.New(var_172_15.x, var_172_15.y, var_172_15.z)

				local var_172_16 = var_172_9.localEulerAngles

				var_172_16.z = 0
				var_172_16.x = 0
				var_172_9.localEulerAngles = var_172_16
			end

			if arg_169_1.time_ >= var_172_10 + var_172_12 and arg_169_1.time_ < var_172_10 + var_172_12 + arg_172_0 then
				var_172_9.localPosition = Vector3.New(0, 100, 0)

				local var_172_17 = manager.ui.mainCamera.transform.position - var_172_9.position

				var_172_9.forward = Vector3.New(var_172_17.x, var_172_17.y, var_172_17.z)

				local var_172_18 = var_172_9.localEulerAngles

				var_172_18.z = 0
				var_172_18.x = 0
				var_172_9.localEulerAngles = var_172_18

				local var_172_19 = GameObjectTools.GetOrAddComponent(var_172_9.gameObject, typeof(DynamicBoneHelper))

				if var_172_19 then
					var_172_19:EnableDynamicBone(true)
				end
			end

			local var_172_20 = arg_169_1.actors_["1034ui_story"]
			local var_172_21 = 0

			if var_172_21 < arg_169_1.time_ and arg_169_1.time_ <= var_172_21 + arg_172_0 and not isNil(var_172_20) and arg_169_1.var_.characterEffect1034ui_story == nil then
				arg_169_1.var_.characterEffect1034ui_story = var_172_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_22 = 0.200000002980232

			if var_172_21 <= arg_169_1.time_ and arg_169_1.time_ < var_172_21 + var_172_22 and not isNil(var_172_20) then
				local var_172_23 = (arg_169_1.time_ - var_172_21) / var_172_22

				if arg_169_1.var_.characterEffect1034ui_story and not isNil(var_172_20) then
					local var_172_24 = Mathf.Lerp(0, 0.5, var_172_23)

					arg_169_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_169_1.var_.characterEffect1034ui_story.fillRatio = var_172_24
				end
			end

			if arg_169_1.time_ >= var_172_21 + var_172_22 and arg_169_1.time_ < var_172_21 + var_172_22 + arg_172_0 and not isNil(var_172_20) and arg_169_1.var_.characterEffect1034ui_story then
				local var_172_25 = 0.5

				arg_169_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_169_1.var_.characterEffect1034ui_story.fillRatio = var_172_25
			end

			local var_172_26 = 0
			local var_172_27 = 0.475

			if var_172_26 < arg_169_1.time_ and arg_169_1.time_ <= var_172_26 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, false)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_28 = arg_169_1:GetWordFromCfg(939012041)
				local var_172_29 = arg_169_1:FormatText(var_172_28.content)

				arg_169_1.text_.text = var_172_29

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_30 = 19
				local var_172_31 = utf8.len(var_172_29)
				local var_172_32 = var_172_30 <= 0 and var_172_27 or var_172_27 * (var_172_31 / var_172_30)

				if var_172_32 > 0 and var_172_27 < var_172_32 then
					arg_169_1.talkMaxDuration = var_172_32

					if var_172_32 + var_172_26 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_32 + var_172_26
					end
				end

				arg_169_1.text_.text = var_172_29
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)
				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_33 = math.max(var_172_27, arg_169_1.talkMaxDuration)

			if var_172_26 <= arg_169_1.time_ and arg_169_1.time_ < var_172_26 + var_172_33 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_26) / var_172_33

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_26 + var_172_33 and arg_169_1.time_ < var_172_26 + var_172_33 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_169_1:InitPlayNodeList()
	end,
	Play939012042 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 939012042
		arg_173_1.duration_ = 5

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play939012043(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = arg_173_1.actors_["1034ui_story"].transform
			local var_176_1 = 0

			if var_176_1 < arg_173_1.time_ and arg_173_1.time_ <= var_176_1 + arg_176_0 then
				arg_173_1.var_.moveOldPos1034ui_story = var_176_0.localPosition
			end

			local var_176_2 = 0.001

			if var_176_1 <= arg_173_1.time_ and arg_173_1.time_ < var_176_1 + var_176_2 then
				local var_176_3 = (arg_173_1.time_ - var_176_1) / var_176_2
				local var_176_4 = Vector3.New(0, -0.93, -6)

				var_176_0.localPosition = Vector3.Lerp(arg_173_1.var_.moveOldPos1034ui_story, var_176_4, var_176_3)

				local var_176_5 = manager.ui.mainCamera.transform.position - var_176_0.position

				var_176_0.forward = Vector3.New(var_176_5.x, var_176_5.y, var_176_5.z)

				local var_176_6 = var_176_0.localEulerAngles

				var_176_6.z = 0
				var_176_6.x = 0
				var_176_0.localEulerAngles = var_176_6
			end

			if arg_173_1.time_ >= var_176_1 + var_176_2 and arg_173_1.time_ < var_176_1 + var_176_2 + arg_176_0 then
				var_176_0.localPosition = Vector3.New(0, -0.93, -6)

				local var_176_7 = manager.ui.mainCamera.transform.position - var_176_0.position

				var_176_0.forward = Vector3.New(var_176_7.x, var_176_7.y, var_176_7.z)

				local var_176_8 = var_176_0.localEulerAngles

				var_176_8.z = 0
				var_176_8.x = 0
				var_176_0.localEulerAngles = var_176_8
			end

			local var_176_9 = arg_173_1.actors_["1034ui_story"]
			local var_176_10 = 0

			if var_176_10 < arg_173_1.time_ and arg_173_1.time_ <= var_176_10 + arg_176_0 and not isNil(var_176_9) and arg_173_1.var_.characterEffect1034ui_story == nil then
				arg_173_1.var_.characterEffect1034ui_story = var_176_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_11 = 0.200000002980232

			if var_176_10 <= arg_173_1.time_ and arg_173_1.time_ < var_176_10 + var_176_11 and not isNil(var_176_9) then
				local var_176_12 = (arg_173_1.time_ - var_176_10) / var_176_11

				if arg_173_1.var_.characterEffect1034ui_story and not isNil(var_176_9) then
					arg_173_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_173_1.time_ >= var_176_10 + var_176_11 and arg_173_1.time_ < var_176_10 + var_176_11 + arg_176_0 and not isNil(var_176_9) and arg_173_1.var_.characterEffect1034ui_story then
				arg_173_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			local var_176_13 = 0

			if var_176_13 < arg_173_1.time_ and arg_173_1.time_ <= var_176_13 + arg_176_0 then
				arg_173_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action1_1")
			end

			local var_176_14 = 0

			if var_176_14 < arg_173_1.time_ and arg_173_1.time_ <= var_176_14 + arg_176_0 then
				arg_173_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_176_15 = 0
			local var_176_16 = 0.15

			if var_176_15 < arg_173_1.time_ and arg_173_1.time_ <= var_176_15 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				local var_176_17 = arg_173_1:FormatText(StoryNameCfg[1109].name)

				arg_173_1.leftNameTxt_.text = var_176_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_18 = arg_173_1:GetWordFromCfg(939012042)
				local var_176_19 = arg_173_1:FormatText(var_176_18.content)

				arg_173_1.text_.text = var_176_19

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_20 = 6
				local var_176_21 = utf8.len(var_176_19)
				local var_176_22 = var_176_20 <= 0 and var_176_16 or var_176_16 * (var_176_21 / var_176_20)

				if var_176_22 > 0 and var_176_16 < var_176_22 then
					arg_173_1.talkMaxDuration = var_176_22

					if var_176_22 + var_176_15 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_22 + var_176_15
					end
				end

				arg_173_1.text_.text = var_176_19
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)
				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_23 = math.max(var_176_16, arg_173_1.talkMaxDuration)

			if var_176_15 <= arg_173_1.time_ and arg_173_1.time_ < var_176_15 + var_176_23 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_15) / var_176_23

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_15 + var_176_23 and arg_173_1.time_ < var_176_15 + var_176_23 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_173_1:InitPlayNodeList()
	end,
	Play939012043 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 939012043
		arg_177_1.duration_ = 5

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play939012044(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = "1012ui_story"

			if arg_177_1.actors_[var_180_0] == nil then
				local var_180_1 = Asset.Load("Char/" .. "1012ui_story")

				if not isNil(var_180_1) then
					local var_180_2 = Object.Instantiate(Asset.Load("Char/" .. "1012ui_story"), arg_177_1.stage_.transform)

					var_180_2.name = var_180_0
					var_180_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_177_1.actors_[var_180_0] = var_180_2

					local var_180_3 = var_180_2:GetComponentInChildren(typeof(CharacterEffect))

					var_180_3.enabled = true

					local var_180_4 = GameObjectTools.GetOrAddComponent(var_180_2, typeof(DynamicBoneHelper))

					if var_180_4 then
						var_180_4:EnableDynamicBone(false)
					end

					arg_177_1:ShowWeapon(var_180_3.transform, false)

					arg_177_1.var_[var_180_0 .. "Animator"] = var_180_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_177_1.var_[var_180_0 .. "Animator"].applyRootMotion = true
					arg_177_1.var_[var_180_0 .. "LipSync"] = var_180_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_180_5 = arg_177_1.actors_["1012ui_story"]
			local var_180_6 = 0

			if var_180_6 < arg_177_1.time_ and arg_177_1.time_ <= var_180_6 + arg_180_0 and not isNil(var_180_5) and arg_177_1.var_.characterEffect1012ui_story == nil then
				arg_177_1.var_.characterEffect1012ui_story = var_180_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_7 = 0.200000002980232

			if var_180_6 <= arg_177_1.time_ and arg_177_1.time_ < var_180_6 + var_180_7 and not isNil(var_180_5) then
				local var_180_8 = (arg_177_1.time_ - var_180_6) / var_180_7

				if arg_177_1.var_.characterEffect1012ui_story and not isNil(var_180_5) then
					arg_177_1.var_.characterEffect1012ui_story.fillFlat = false
				end
			end

			if arg_177_1.time_ >= var_180_6 + var_180_7 and arg_177_1.time_ < var_180_6 + var_180_7 + arg_180_0 and not isNil(var_180_5) and arg_177_1.var_.characterEffect1012ui_story then
				arg_177_1.var_.characterEffect1012ui_story.fillFlat = false
			end

			local var_180_9 = arg_177_1.actors_["1034ui_story"]
			local var_180_10 = 0

			if var_180_10 < arg_177_1.time_ and arg_177_1.time_ <= var_180_10 + arg_180_0 and not isNil(var_180_9) and arg_177_1.var_.characterEffect1034ui_story == nil then
				arg_177_1.var_.characterEffect1034ui_story = var_180_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_11 = 0.200000002980232

			if var_180_10 <= arg_177_1.time_ and arg_177_1.time_ < var_180_10 + var_180_11 and not isNil(var_180_9) then
				local var_180_12 = (arg_177_1.time_ - var_180_10) / var_180_11

				if arg_177_1.var_.characterEffect1034ui_story and not isNil(var_180_9) then
					local var_180_13 = Mathf.Lerp(0, 0.5, var_180_12)

					arg_177_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_177_1.var_.characterEffect1034ui_story.fillRatio = var_180_13
				end
			end

			if arg_177_1.time_ >= var_180_10 + var_180_11 and arg_177_1.time_ < var_180_10 + var_180_11 + arg_180_0 and not isNil(var_180_9) and arg_177_1.var_.characterEffect1034ui_story then
				local var_180_14 = 0.5

				arg_177_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_177_1.var_.characterEffect1034ui_story.fillRatio = var_180_14
			end

			local var_180_15 = 0
			local var_180_16 = 0.425

			if var_180_15 < arg_177_1.time_ and arg_177_1.time_ <= var_180_15 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				local var_180_17 = arg_177_1:FormatText(StoryNameCfg[595].name)

				arg_177_1.leftNameTxt_.text = var_180_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, true)
				arg_177_1.iconController_:SetSelectedState("hero")

				arg_177_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1012")

				arg_177_1.callingController_:SetSelectedState("calling")

				arg_177_1.keyicon_.color = Color.New(1, 1, 1)
				arg_177_1.icon_.color = Color.New(1, 1, 1)

				local var_180_18 = arg_177_1:GetWordFromCfg(939012043)
				local var_180_19 = arg_177_1:FormatText(var_180_18.content)

				arg_177_1.text_.text = var_180_19

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_20 = 17
				local var_180_21 = utf8.len(var_180_19)
				local var_180_22 = var_180_20 <= 0 and var_180_16 or var_180_16 * (var_180_21 / var_180_20)

				if var_180_22 > 0 and var_180_16 < var_180_22 then
					arg_177_1.talkMaxDuration = var_180_22

					if var_180_22 + var_180_15 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_22 + var_180_15
					end
				end

				arg_177_1.text_.text = var_180_19
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)
				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_23 = math.max(var_180_16, arg_177_1.talkMaxDuration)

			if var_180_15 <= arg_177_1.time_ and arg_177_1.time_ < var_180_15 + var_180_23 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_15) / var_180_23

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_15 + var_180_23 and arg_177_1.time_ < var_180_15 + var_180_23 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {}

		arg_177_1:InitPlayNodeList()
	end,
	Play939012044 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 939012044
		arg_181_1.duration_ = 5

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play939012045(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = arg_181_1.actors_["1034ui_story"].transform
			local var_184_1 = 0

			if var_184_1 < arg_181_1.time_ and arg_181_1.time_ <= var_184_1 + arg_184_0 then
				arg_181_1.var_.moveOldPos1034ui_story = var_184_0.localPosition
			end

			local var_184_2 = 0.001

			if var_184_1 <= arg_181_1.time_ and arg_181_1.time_ < var_184_1 + var_184_2 then
				local var_184_3 = (arg_181_1.time_ - var_184_1) / var_184_2
				local var_184_4 = Vector3.New(0, -0.93, -6)

				var_184_0.localPosition = Vector3.Lerp(arg_181_1.var_.moveOldPos1034ui_story, var_184_4, var_184_3)

				local var_184_5 = manager.ui.mainCamera.transform.position - var_184_0.position

				var_184_0.forward = Vector3.New(var_184_5.x, var_184_5.y, var_184_5.z)

				local var_184_6 = var_184_0.localEulerAngles

				var_184_6.z = 0
				var_184_6.x = 0
				var_184_0.localEulerAngles = var_184_6
			end

			if arg_181_1.time_ >= var_184_1 + var_184_2 and arg_181_1.time_ < var_184_1 + var_184_2 + arg_184_0 then
				var_184_0.localPosition = Vector3.New(0, -0.93, -6)

				local var_184_7 = manager.ui.mainCamera.transform.position - var_184_0.position

				var_184_0.forward = Vector3.New(var_184_7.x, var_184_7.y, var_184_7.z)

				local var_184_8 = var_184_0.localEulerAngles

				var_184_8.z = 0
				var_184_8.x = 0
				var_184_0.localEulerAngles = var_184_8
			end

			local var_184_9 = arg_181_1.actors_["1034ui_story"]
			local var_184_10 = 0

			if var_184_10 < arg_181_1.time_ and arg_181_1.time_ <= var_184_10 + arg_184_0 and not isNil(var_184_9) and arg_181_1.var_.characterEffect1034ui_story == nil then
				arg_181_1.var_.characterEffect1034ui_story = var_184_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_11 = 0.200000002980232

			if var_184_10 <= arg_181_1.time_ and arg_181_1.time_ < var_184_10 + var_184_11 and not isNil(var_184_9) then
				local var_184_12 = (arg_181_1.time_ - var_184_10) / var_184_11

				if arg_181_1.var_.characterEffect1034ui_story and not isNil(var_184_9) then
					arg_181_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_181_1.time_ >= var_184_10 + var_184_11 and arg_181_1.time_ < var_184_10 + var_184_11 + arg_184_0 and not isNil(var_184_9) and arg_181_1.var_.characterEffect1034ui_story then
				arg_181_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			local var_184_13 = arg_181_1.actors_["1012ui_story"]
			local var_184_14 = 0

			if var_184_14 < arg_181_1.time_ and arg_181_1.time_ <= var_184_14 + arg_184_0 and not isNil(var_184_13) and arg_181_1.var_.characterEffect1012ui_story == nil then
				arg_181_1.var_.characterEffect1012ui_story = var_184_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_15 = 0.200000002980232

			if var_184_14 <= arg_181_1.time_ and arg_181_1.time_ < var_184_14 + var_184_15 and not isNil(var_184_13) then
				local var_184_16 = (arg_181_1.time_ - var_184_14) / var_184_15

				if arg_181_1.var_.characterEffect1012ui_story and not isNil(var_184_13) then
					local var_184_17 = Mathf.Lerp(0, 0.5, var_184_16)

					arg_181_1.var_.characterEffect1012ui_story.fillFlat = true
					arg_181_1.var_.characterEffect1012ui_story.fillRatio = var_184_17
				end
			end

			if arg_181_1.time_ >= var_184_14 + var_184_15 and arg_181_1.time_ < var_184_14 + var_184_15 + arg_184_0 and not isNil(var_184_13) and arg_181_1.var_.characterEffect1012ui_story then
				local var_184_18 = 0.5

				arg_181_1.var_.characterEffect1012ui_story.fillFlat = true
				arg_181_1.var_.characterEffect1012ui_story.fillRatio = var_184_18
			end

			local var_184_19 = 0

			if var_184_19 < arg_181_1.time_ and arg_181_1.time_ <= var_184_19 + arg_184_0 then
				arg_181_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action5_1")
			end

			local var_184_20 = 0

			if var_184_20 < arg_181_1.time_ and arg_181_1.time_ <= var_184_20 + arg_184_0 then
				arg_181_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileC_biyan", "EmotionTimelineAnimator")
			end

			local var_184_21 = 0
			local var_184_22 = 0.75

			if var_184_21 < arg_181_1.time_ and arg_181_1.time_ <= var_184_21 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				local var_184_23 = arg_181_1:FormatText(StoryNameCfg[1109].name)

				arg_181_1.leftNameTxt_.text = var_184_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_24 = arg_181_1:GetWordFromCfg(939012044)
				local var_184_25 = arg_181_1:FormatText(var_184_24.content)

				arg_181_1.text_.text = var_184_25

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_26 = 30
				local var_184_27 = utf8.len(var_184_25)
				local var_184_28 = var_184_26 <= 0 and var_184_22 or var_184_22 * (var_184_27 / var_184_26)

				if var_184_28 > 0 and var_184_22 < var_184_28 then
					arg_181_1.talkMaxDuration = var_184_28

					if var_184_28 + var_184_21 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_28 + var_184_21
					end
				end

				arg_181_1.text_.text = var_184_25
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)
				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_29 = math.max(var_184_22, arg_181_1.talkMaxDuration)

			if var_184_21 <= arg_181_1.time_ and arg_181_1.time_ < var_184_21 + var_184_29 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_21) / var_184_29

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_21 + var_184_29 and arg_181_1.time_ < var_184_21 + var_184_29 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_181_1:InitPlayNodeList()
	end,
	Play939012045 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 939012045
		arg_185_1.duration_ = 9

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play939012046(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = 2

			if var_188_0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_0 + arg_188_0 then
				local var_188_1 = manager.ui.mainCamera.transform.localPosition
				local var_188_2 = Vector3.New(0, 0, 10) + Vector3.New(var_188_1.x, var_188_1.y, 0)
				local var_188_3 = arg_185_1.bgs_.I05a

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
					if iter_188_0 ~= "I05a" then
						iter_188_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_188_14 = 3.9666666696469

			if var_188_14 < arg_185_1.time_ and arg_185_1.time_ <= var_188_14 + arg_188_0 then
				arg_185_1.allBtn_.enabled = false
			end

			local var_188_15 = 0.3

			if arg_185_1.time_ >= var_188_14 + var_188_15 and arg_185_1.time_ < var_188_14 + var_188_15 + arg_188_0 then
				arg_185_1.allBtn_.enabled = true
			end

			local var_188_16 = 0

			if var_188_16 < arg_185_1.time_ and arg_185_1.time_ <= var_188_16 + arg_188_0 then
				arg_185_1.mask_.enabled = true
				arg_185_1.mask_.raycastTarget = true

				arg_185_1:SetGaussion(false)
			end

			local var_188_17 = 2

			if var_188_16 <= arg_185_1.time_ and arg_185_1.time_ < var_188_16 + var_188_17 then
				local var_188_18 = (arg_185_1.time_ - var_188_16) / var_188_17
				local var_188_19 = Color.New(0, 0, 0)

				var_188_19.a = Mathf.Lerp(0, 1, var_188_18)
				arg_185_1.mask_.color = var_188_19
			end

			if arg_185_1.time_ >= var_188_16 + var_188_17 and arg_185_1.time_ < var_188_16 + var_188_17 + arg_188_0 then
				local var_188_20 = Color.New(0, 0, 0)

				var_188_20.a = 1
				arg_185_1.mask_.color = var_188_20
			end

			local var_188_21 = 2

			if var_188_21 < arg_185_1.time_ and arg_185_1.time_ <= var_188_21 + arg_188_0 then
				arg_185_1.mask_.enabled = true
				arg_185_1.mask_.raycastTarget = true

				arg_185_1:SetGaussion(false)
			end

			local var_188_22 = 2

			if var_188_21 <= arg_185_1.time_ and arg_185_1.time_ < var_188_21 + var_188_22 then
				local var_188_23 = (arg_185_1.time_ - var_188_21) / var_188_22
				local var_188_24 = Color.New(0, 0, 0)

				var_188_24.a = Mathf.Lerp(1, 0, var_188_23)
				arg_185_1.mask_.color = var_188_24
			end

			if arg_185_1.time_ >= var_188_21 + var_188_22 and arg_185_1.time_ < var_188_21 + var_188_22 + arg_188_0 then
				local var_188_25 = Color.New(0, 0, 0)
				local var_188_26 = 0

				arg_185_1.mask_.enabled = false
				var_188_25.a = var_188_26
				arg_185_1.mask_.color = var_188_25
			end

			local var_188_27 = arg_185_1.actors_["1034ui_story"].transform
			local var_188_28 = 1.96599999815226

			if var_188_28 < arg_185_1.time_ and arg_185_1.time_ <= var_188_28 + arg_188_0 then
				arg_185_1.var_.moveOldPos1034ui_story = var_188_27.localPosition
			end

			local var_188_29 = 0.001

			if var_188_28 <= arg_185_1.time_ and arg_185_1.time_ < var_188_28 + var_188_29 then
				local var_188_30 = (arg_185_1.time_ - var_188_28) / var_188_29
				local var_188_31 = Vector3.New(0, 100, 0)

				var_188_27.localPosition = Vector3.Lerp(arg_185_1.var_.moveOldPos1034ui_story, var_188_31, var_188_30)

				local var_188_32 = manager.ui.mainCamera.transform.position - var_188_27.position

				var_188_27.forward = Vector3.New(var_188_32.x, var_188_32.y, var_188_32.z)

				local var_188_33 = var_188_27.localEulerAngles

				var_188_33.z = 0
				var_188_33.x = 0
				var_188_27.localEulerAngles = var_188_33
			end

			if arg_185_1.time_ >= var_188_28 + var_188_29 and arg_185_1.time_ < var_188_28 + var_188_29 + arg_188_0 then
				var_188_27.localPosition = Vector3.New(0, 100, 0)

				local var_188_34 = manager.ui.mainCamera.transform.position - var_188_27.position

				var_188_27.forward = Vector3.New(var_188_34.x, var_188_34.y, var_188_34.z)

				local var_188_35 = var_188_27.localEulerAngles

				var_188_35.z = 0
				var_188_35.x = 0
				var_188_27.localEulerAngles = var_188_35
			end

			local var_188_36 = arg_185_1.actors_["1012ui_story"].transform
			local var_188_37 = 3.76666666666667

			if var_188_37 < arg_185_1.time_ and arg_185_1.time_ <= var_188_37 + arg_188_0 then
				arg_185_1.var_.moveOldPos1012ui_story = var_188_36.localPosition
			end

			local var_188_38 = 0.001

			if var_188_37 <= arg_185_1.time_ and arg_185_1.time_ < var_188_37 + var_188_38 then
				local var_188_39 = (arg_185_1.time_ - var_188_37) / var_188_38
				local var_188_40 = Vector3.New(0, -1.05, -6.24)

				var_188_36.localPosition = Vector3.Lerp(arg_185_1.var_.moveOldPos1012ui_story, var_188_40, var_188_39)

				local var_188_41 = manager.ui.mainCamera.transform.position - var_188_36.position

				var_188_36.forward = Vector3.New(var_188_41.x, var_188_41.y, var_188_41.z)

				local var_188_42 = var_188_36.localEulerAngles

				var_188_42.z = 0
				var_188_42.x = 0
				var_188_36.localEulerAngles = var_188_42
			end

			if arg_185_1.time_ >= var_188_37 + var_188_38 and arg_185_1.time_ < var_188_37 + var_188_38 + arg_188_0 then
				var_188_36.localPosition = Vector3.New(0, -1.05, -6.24)

				local var_188_43 = manager.ui.mainCamera.transform.position - var_188_36.position

				var_188_36.forward = Vector3.New(var_188_43.x, var_188_43.y, var_188_43.z)

				local var_188_44 = var_188_36.localEulerAngles

				var_188_44.z = 0
				var_188_44.x = 0
				var_188_36.localEulerAngles = var_188_44
			end

			local var_188_45 = arg_185_1.actors_["1012ui_story"]
			local var_188_46 = 3.76666666666667

			if var_188_46 < arg_185_1.time_ and arg_185_1.time_ <= var_188_46 + arg_188_0 and not isNil(var_188_45) and arg_185_1.var_.characterEffect1012ui_story == nil then
				arg_185_1.var_.characterEffect1012ui_story = var_188_45:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_188_47 = 0.200000002980232

			if var_188_46 <= arg_185_1.time_ and arg_185_1.time_ < var_188_46 + var_188_47 and not isNil(var_188_45) then
				local var_188_48 = (arg_185_1.time_ - var_188_46) / var_188_47

				if arg_185_1.var_.characterEffect1012ui_story and not isNil(var_188_45) then
					arg_185_1.var_.characterEffect1012ui_story.fillFlat = false
				end
			end

			if arg_185_1.time_ >= var_188_46 + var_188_47 and arg_185_1.time_ < var_188_46 + var_188_47 + arg_188_0 and not isNil(var_188_45) and arg_185_1.var_.characterEffect1012ui_story then
				arg_185_1.var_.characterEffect1012ui_story.fillFlat = false
			end

			local var_188_49 = arg_185_1.actors_["1034ui_story"]
			local var_188_50 = 3.76666666666667

			if var_188_50 < arg_185_1.time_ and arg_185_1.time_ <= var_188_50 + arg_188_0 and not isNil(var_188_49) and arg_185_1.var_.characterEffect1034ui_story == nil then
				arg_185_1.var_.characterEffect1034ui_story = var_188_49:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_188_51 = 0.200000002980232

			if var_188_50 <= arg_185_1.time_ and arg_185_1.time_ < var_188_50 + var_188_51 and not isNil(var_188_49) then
				local var_188_52 = (arg_185_1.time_ - var_188_50) / var_188_51

				if arg_185_1.var_.characterEffect1034ui_story and not isNil(var_188_49) then
					local var_188_53 = Mathf.Lerp(0, 0.5, var_188_52)

					arg_185_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_185_1.var_.characterEffect1034ui_story.fillRatio = var_188_53
				end
			end

			if arg_185_1.time_ >= var_188_50 + var_188_51 and arg_185_1.time_ < var_188_50 + var_188_51 + arg_188_0 and not isNil(var_188_49) and arg_185_1.var_.characterEffect1034ui_story then
				local var_188_54 = 0.5

				arg_185_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_185_1.var_.characterEffect1034ui_story.fillRatio = var_188_54
			end

			local var_188_55 = 3.76666666666667

			if var_188_55 < arg_185_1.time_ and arg_185_1.time_ <= var_188_55 + arg_188_0 then
				arg_185_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/story1012/story1012action/1012action1_1")
			end

			local var_188_56 = 3.76666666666667

			if var_188_56 < arg_185_1.time_ and arg_185_1.time_ <= var_188_56 + arg_188_0 then
				arg_185_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			if arg_185_1.frameCnt_ <= 1 then
				arg_185_1.dialog_:SetActive(false)
			end

			local var_188_57 = 4
			local var_188_58 = 0.85

			if var_188_57 < arg_185_1.time_ and arg_185_1.time_ <= var_188_57 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0

				arg_185_1.dialog_:SetActive(true)

				arg_185_1.dialogCg_.alpha = 0

				local var_188_59 = LeanTween.value(arg_185_1.dialog_, 0, 1, 0.3)

				var_188_59:setOnUpdate(LuaHelper.FloatAction(function(arg_189_0)
					arg_185_1.dialogCg_.alpha = arg_189_0
				end))
				var_188_59:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_185_1.dialog_)
					var_188_59:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_185_1.duration_ = arg_185_1.duration_ + 0.3

				SetActive(arg_185_1.leftNameGo_, true)

				local var_188_60 = arg_185_1:FormatText(StoryNameCfg[595].name)

				arg_185_1.leftNameTxt_.text = var_188_60

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_61 = arg_185_1:GetWordFromCfg(939012045)
				local var_188_62 = arg_185_1:FormatText(var_188_61.content)

				arg_185_1.text_.text = var_188_62

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_63 = 34
				local var_188_64 = utf8.len(var_188_62)
				local var_188_65 = var_188_63 <= 0 and var_188_58 or var_188_58 * (var_188_64 / var_188_63)

				if var_188_65 > 0 and var_188_58 < var_188_65 then
					arg_185_1.talkMaxDuration = var_188_65
					var_188_57 = var_188_57 + 0.3

					if var_188_65 + var_188_57 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_65 + var_188_57
					end
				end

				arg_185_1.text_.text = var_188_62
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)
				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_66 = var_188_57 + 0.3
			local var_188_67 = math.max(var_188_58, arg_185_1.talkMaxDuration)

			if var_188_66 <= arg_185_1.time_ and arg_185_1.time_ < var_188_66 + var_188_67 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_66) / var_188_67

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_66 + var_188_67 and arg_185_1.time_ < var_188_66 + var_188_67 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1012ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.76666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_185_1:InitPlayNodeList()
	end,
	Play939012046 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 939012046
		arg_191_1.duration_ = 5

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play939012047(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = arg_191_1.actors_["1012ui_story"].transform
			local var_194_1 = 0

			if var_194_1 < arg_191_1.time_ and arg_191_1.time_ <= var_194_1 + arg_194_0 then
				arg_191_1.var_.moveOldPos1012ui_story = var_194_0.localPosition
			end

			local var_194_2 = 0.001

			if var_194_1 <= arg_191_1.time_ and arg_191_1.time_ < var_194_1 + var_194_2 then
				local var_194_3 = (arg_191_1.time_ - var_194_1) / var_194_2
				local var_194_4 = Vector3.New(0, -1.05, -6.24)

				var_194_0.localPosition = Vector3.Lerp(arg_191_1.var_.moveOldPos1012ui_story, var_194_4, var_194_3)

				local var_194_5 = manager.ui.mainCamera.transform.position - var_194_0.position

				var_194_0.forward = Vector3.New(var_194_5.x, var_194_5.y, var_194_5.z)

				local var_194_6 = var_194_0.localEulerAngles

				var_194_6.z = 0
				var_194_6.x = 0
				var_194_0.localEulerAngles = var_194_6
			end

			if arg_191_1.time_ >= var_194_1 + var_194_2 and arg_191_1.time_ < var_194_1 + var_194_2 + arg_194_0 then
				var_194_0.localPosition = Vector3.New(0, -1.05, -6.24)

				local var_194_7 = manager.ui.mainCamera.transform.position - var_194_0.position

				var_194_0.forward = Vector3.New(var_194_7.x, var_194_7.y, var_194_7.z)

				local var_194_8 = var_194_0.localEulerAngles

				var_194_8.z = 0
				var_194_8.x = 0
				var_194_0.localEulerAngles = var_194_8
			end

			local var_194_9 = 0

			if var_194_9 < arg_191_1.time_ and arg_191_1.time_ <= var_194_9 + arg_194_0 then
				arg_191_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/story1012/story1012action/1012action2_1")
			end

			local var_194_10 = 0

			if var_194_10 < arg_191_1.time_ and arg_191_1.time_ <= var_194_10 + arg_194_0 then
				arg_191_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_194_11 = 0
			local var_194_12 = 0.6

			if var_194_11 < arg_191_1.time_ and arg_191_1.time_ <= var_194_11 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				local var_194_13 = arg_191_1:FormatText(StoryNameCfg[595].name)

				arg_191_1.leftNameTxt_.text = var_194_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_14 = arg_191_1:GetWordFromCfg(939012046)
				local var_194_15 = arg_191_1:FormatText(var_194_14.content)

				arg_191_1.text_.text = var_194_15

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_16 = 24
				local var_194_17 = utf8.len(var_194_15)
				local var_194_18 = var_194_16 <= 0 and var_194_12 or var_194_12 * (var_194_17 / var_194_16)

				if var_194_18 > 0 and var_194_12 < var_194_18 then
					arg_191_1.talkMaxDuration = var_194_18

					if var_194_18 + var_194_11 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_18 + var_194_11
					end
				end

				arg_191_1.text_.text = var_194_15
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)
				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_19 = math.max(var_194_12, arg_191_1.talkMaxDuration)

			if var_194_11 <= arg_191_1.time_ and arg_191_1.time_ < var_194_11 + var_194_19 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_11) / var_194_19

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_11 + var_194_19 and arg_191_1.time_ < var_194_11 + var_194_19 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_191_1:InitPlayNodeList()
	end,
	Play939012047 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 939012047
		arg_195_1.duration_ = 5

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play939012048(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = arg_195_1.actors_["1012ui_story"].transform
			local var_198_1 = 0

			if var_198_1 < arg_195_1.time_ and arg_195_1.time_ <= var_198_1 + arg_198_0 then
				arg_195_1.var_.moveOldPos1012ui_story = var_198_0.localPosition
			end

			local var_198_2 = 0.001

			if var_198_1 <= arg_195_1.time_ and arg_195_1.time_ < var_198_1 + var_198_2 then
				local var_198_3 = (arg_195_1.time_ - var_198_1) / var_198_2
				local var_198_4 = Vector3.New(0, 100, 0)

				var_198_0.localPosition = Vector3.Lerp(arg_195_1.var_.moveOldPos1012ui_story, var_198_4, var_198_3)

				local var_198_5 = manager.ui.mainCamera.transform.position - var_198_0.position

				var_198_0.forward = Vector3.New(var_198_5.x, var_198_5.y, var_198_5.z)

				local var_198_6 = var_198_0.localEulerAngles

				var_198_6.z = 0
				var_198_6.x = 0
				var_198_0.localEulerAngles = var_198_6
			end

			if arg_195_1.time_ >= var_198_1 + var_198_2 and arg_195_1.time_ < var_198_1 + var_198_2 + arg_198_0 then
				var_198_0.localPosition = Vector3.New(0, 100, 0)

				local var_198_7 = manager.ui.mainCamera.transform.position - var_198_0.position

				var_198_0.forward = Vector3.New(var_198_7.x, var_198_7.y, var_198_7.z)

				local var_198_8 = var_198_0.localEulerAngles

				var_198_8.z = 0
				var_198_8.x = 0
				var_198_0.localEulerAngles = var_198_8
			end

			local var_198_9 = arg_195_1.actors_["1012ui_story"]
			local var_198_10 = 0

			if var_198_10 < arg_195_1.time_ and arg_195_1.time_ <= var_198_10 + arg_198_0 and not isNil(var_198_9) and arg_195_1.var_.characterEffect1012ui_story == nil then
				arg_195_1.var_.characterEffect1012ui_story = var_198_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_198_11 = 0.200000002980232

			if var_198_10 <= arg_195_1.time_ and arg_195_1.time_ < var_198_10 + var_198_11 and not isNil(var_198_9) then
				local var_198_12 = (arg_195_1.time_ - var_198_10) / var_198_11

				if arg_195_1.var_.characterEffect1012ui_story and not isNil(var_198_9) then
					local var_198_13 = Mathf.Lerp(0, 0.5, var_198_12)

					arg_195_1.var_.characterEffect1012ui_story.fillFlat = true
					arg_195_1.var_.characterEffect1012ui_story.fillRatio = var_198_13
				end
			end

			if arg_195_1.time_ >= var_198_10 + var_198_11 and arg_195_1.time_ < var_198_10 + var_198_11 + arg_198_0 and not isNil(var_198_9) and arg_195_1.var_.characterEffect1012ui_story then
				local var_198_14 = 0.5

				arg_195_1.var_.characterEffect1012ui_story.fillFlat = true
				arg_195_1.var_.characterEffect1012ui_story.fillRatio = var_198_14
			end

			local var_198_15 = 0
			local var_198_16 = 1.025

			if var_198_15 < arg_195_1.time_ and arg_195_1.time_ <= var_198_15 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, false)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_17 = arg_195_1:GetWordFromCfg(939012047)
				local var_198_18 = arg_195_1:FormatText(var_198_17.content)

				arg_195_1.text_.text = var_198_18

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_19 = 41
				local var_198_20 = utf8.len(var_198_18)
				local var_198_21 = var_198_19 <= 0 and var_198_16 or var_198_16 * (var_198_20 / var_198_19)

				if var_198_21 > 0 and var_198_16 < var_198_21 then
					arg_195_1.talkMaxDuration = var_198_21

					if var_198_21 + var_198_15 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_21 + var_198_15
					end
				end

				arg_195_1.text_.text = var_198_18
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)
				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_22 = math.max(var_198_16, arg_195_1.talkMaxDuration)

			if var_198_15 <= arg_195_1.time_ and arg_195_1.time_ < var_198_15 + var_198_22 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_15) / var_198_22

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_15 + var_198_22 and arg_195_1.time_ < var_198_15 + var_198_22 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_195_1:InitPlayNodeList()
	end,
	Play939012048 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 939012048
		arg_199_1.duration_ = 5

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play939012049(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = arg_199_1.actors_["1034ui_story"].transform
			local var_202_1 = 0

			if var_202_1 < arg_199_1.time_ and arg_199_1.time_ <= var_202_1 + arg_202_0 then
				arg_199_1.var_.moveOldPos1034ui_story = var_202_0.localPosition
			end

			local var_202_2 = 0.001

			if var_202_1 <= arg_199_1.time_ and arg_199_1.time_ < var_202_1 + var_202_2 then
				local var_202_3 = (arg_199_1.time_ - var_202_1) / var_202_2
				local var_202_4 = Vector3.New(0, -0.93, -6)

				var_202_0.localPosition = Vector3.Lerp(arg_199_1.var_.moveOldPos1034ui_story, var_202_4, var_202_3)

				local var_202_5 = manager.ui.mainCamera.transform.position - var_202_0.position

				var_202_0.forward = Vector3.New(var_202_5.x, var_202_5.y, var_202_5.z)

				local var_202_6 = var_202_0.localEulerAngles

				var_202_6.z = 0
				var_202_6.x = 0
				var_202_0.localEulerAngles = var_202_6
			end

			if arg_199_1.time_ >= var_202_1 + var_202_2 and arg_199_1.time_ < var_202_1 + var_202_2 + arg_202_0 then
				var_202_0.localPosition = Vector3.New(0, -0.93, -6)

				local var_202_7 = manager.ui.mainCamera.transform.position - var_202_0.position

				var_202_0.forward = Vector3.New(var_202_7.x, var_202_7.y, var_202_7.z)

				local var_202_8 = var_202_0.localEulerAngles

				var_202_8.z = 0
				var_202_8.x = 0
				var_202_0.localEulerAngles = var_202_8
			end

			local var_202_9 = arg_199_1.actors_["1034ui_story"]
			local var_202_10 = 0

			if var_202_10 < arg_199_1.time_ and arg_199_1.time_ <= var_202_10 + arg_202_0 and not isNil(var_202_9) and arg_199_1.var_.characterEffect1034ui_story == nil then
				arg_199_1.var_.characterEffect1034ui_story = var_202_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_202_11 = 0.200000002980232

			if var_202_10 <= arg_199_1.time_ and arg_199_1.time_ < var_202_10 + var_202_11 and not isNil(var_202_9) then
				local var_202_12 = (arg_199_1.time_ - var_202_10) / var_202_11

				if arg_199_1.var_.characterEffect1034ui_story and not isNil(var_202_9) then
					arg_199_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_199_1.time_ >= var_202_10 + var_202_11 and arg_199_1.time_ < var_202_10 + var_202_11 + arg_202_0 and not isNil(var_202_9) and arg_199_1.var_.characterEffect1034ui_story then
				arg_199_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			local var_202_13 = 0

			if var_202_13 < arg_199_1.time_ and arg_199_1.time_ <= var_202_13 + arg_202_0 then
				arg_199_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action3_1")
			end

			local var_202_14 = 0

			if var_202_14 < arg_199_1.time_ and arg_199_1.time_ <= var_202_14 + arg_202_0 then
				arg_199_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileC_biyan", "EmotionTimelineAnimator")
			end

			local var_202_15 = 0
			local var_202_16 = 0.6

			if var_202_15 < arg_199_1.time_ and arg_199_1.time_ <= var_202_15 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				local var_202_17 = arg_199_1:FormatText(StoryNameCfg[1109].name)

				arg_199_1.leftNameTxt_.text = var_202_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_18 = arg_199_1:GetWordFromCfg(939012048)
				local var_202_19 = arg_199_1:FormatText(var_202_18.content)

				arg_199_1.text_.text = var_202_19

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_20 = 24
				local var_202_21 = utf8.len(var_202_19)
				local var_202_22 = var_202_20 <= 0 and var_202_16 or var_202_16 * (var_202_21 / var_202_20)

				if var_202_22 > 0 and var_202_16 < var_202_22 then
					arg_199_1.talkMaxDuration = var_202_22

					if var_202_22 + var_202_15 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_22 + var_202_15
					end
				end

				arg_199_1.text_.text = var_202_19
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)
				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_23 = math.max(var_202_16, arg_199_1.talkMaxDuration)

			if var_202_15 <= arg_199_1.time_ and arg_199_1.time_ < var_202_15 + var_202_23 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_15) / var_202_23

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_15 + var_202_23 and arg_199_1.time_ < var_202_15 + var_202_23 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_199_1:InitPlayNodeList()
	end,
	Play939012049 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 939012049
		arg_203_1.duration_ = 5

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play939012050(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			local var_206_0 = arg_203_1.actors_["1034ui_story"]
			local var_206_1 = 0

			if var_206_1 < arg_203_1.time_ and arg_203_1.time_ <= var_206_1 + arg_206_0 and not isNil(var_206_0) and arg_203_1.var_.characterEffect1034ui_story == nil then
				arg_203_1.var_.characterEffect1034ui_story = var_206_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_206_2 = 0.200000002980232

			if var_206_1 <= arg_203_1.time_ and arg_203_1.time_ < var_206_1 + var_206_2 and not isNil(var_206_0) then
				local var_206_3 = (arg_203_1.time_ - var_206_1) / var_206_2

				if arg_203_1.var_.characterEffect1034ui_story and not isNil(var_206_0) then
					local var_206_4 = Mathf.Lerp(0, 0.5, var_206_3)

					arg_203_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_203_1.var_.characterEffect1034ui_story.fillRatio = var_206_4
				end
			end

			if arg_203_1.time_ >= var_206_1 + var_206_2 and arg_203_1.time_ < var_206_1 + var_206_2 + arg_206_0 and not isNil(var_206_0) and arg_203_1.var_.characterEffect1034ui_story then
				local var_206_5 = 0.5

				arg_203_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_203_1.var_.characterEffect1034ui_story.fillRatio = var_206_5
			end

			local var_206_6 = 0
			local var_206_7 = 0.5

			if var_206_6 < arg_203_1.time_ and arg_203_1.time_ <= var_206_6 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				local var_206_8 = arg_203_1:FormatText(StoryNameCfg[7].name)

				arg_203_1.leftNameTxt_.text = var_206_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, true)
				arg_203_1.iconController_:SetSelectedState("hero")

				arg_203_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_203_1.callingController_:SetSelectedState("normal")

				arg_203_1.keyicon_.color = Color.New(1, 1, 1)
				arg_203_1.icon_.color = Color.New(1, 1, 1)

				local var_206_9 = arg_203_1:GetWordFromCfg(939012049)
				local var_206_10 = arg_203_1:FormatText(var_206_9.content)

				arg_203_1.text_.text = var_206_10

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_11 = 20
				local var_206_12 = utf8.len(var_206_10)
				local var_206_13 = var_206_11 <= 0 and var_206_7 or var_206_7 * (var_206_12 / var_206_11)

				if var_206_13 > 0 and var_206_7 < var_206_13 then
					arg_203_1.talkMaxDuration = var_206_13

					if var_206_13 + var_206_6 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_13 + var_206_6
					end
				end

				arg_203_1.text_.text = var_206_10
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)
				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_14 = math.max(var_206_7, arg_203_1.talkMaxDuration)

			if var_206_6 <= arg_203_1.time_ and arg_203_1.time_ < var_206_6 + var_206_14 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_6) / var_206_14

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_6 + var_206_14 and arg_203_1.time_ < var_206_6 + var_206_14 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {}

		arg_203_1:InitPlayNodeList()
	end,
	Play939012050 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 939012050
		arg_207_1.duration_ = 5

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play939012051(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			local var_210_0 = 0
			local var_210_1 = 0.425

			if var_210_0 < arg_207_1.time_ and arg_207_1.time_ <= var_210_0 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				local var_210_2 = arg_207_1:FormatText(StoryNameCfg[7].name)

				arg_207_1.leftNameTxt_.text = var_210_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, true)
				arg_207_1.iconController_:SetSelectedState("hero")

				arg_207_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_207_1.callingController_:SetSelectedState("normal")

				arg_207_1.keyicon_.color = Color.New(1, 1, 1)
				arg_207_1.icon_.color = Color.New(1, 1, 1)

				local var_210_3 = arg_207_1:GetWordFromCfg(939012050)
				local var_210_4 = arg_207_1:FormatText(var_210_3.content)

				arg_207_1.text_.text = var_210_4

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_5 = 17
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
				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_8 = math.max(var_210_1, arg_207_1.talkMaxDuration)

			if var_210_0 <= arg_207_1.time_ and arg_207_1.time_ < var_210_0 + var_210_8 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_0) / var_210_8

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_0 + var_210_8 and arg_207_1.time_ < var_210_0 + var_210_8 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {}

		arg_207_1:InitPlayNodeList()
	end,
	Play939012051 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 939012051
		arg_211_1.duration_ = 5

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play939012052(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			local var_214_0 = "1284ui_story"

			if arg_211_1.actors_[var_214_0] == nil then
				local var_214_1 = Asset.Load("Char/" .. "1284ui_story")

				if not isNil(var_214_1) then
					local var_214_2 = Object.Instantiate(Asset.Load("Char/" .. "1284ui_story"), arg_211_1.stage_.transform)

					var_214_2.name = var_214_0
					var_214_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_211_1.actors_[var_214_0] = var_214_2

					local var_214_3 = var_214_2:GetComponentInChildren(typeof(CharacterEffect))

					var_214_3.enabled = true

					local var_214_4 = GameObjectTools.GetOrAddComponent(var_214_2, typeof(DynamicBoneHelper))

					if var_214_4 then
						var_214_4:EnableDynamicBone(false)
					end

					arg_211_1:ShowWeapon(var_214_3.transform, false)

					arg_211_1.var_[var_214_0 .. "Animator"] = var_214_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_211_1.var_[var_214_0 .. "Animator"].applyRootMotion = true
					arg_211_1.var_[var_214_0 .. "LipSync"] = var_214_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_214_5 = arg_211_1.actors_["1284ui_story"].transform
			local var_214_6 = 0

			if var_214_6 < arg_211_1.time_ and arg_211_1.time_ <= var_214_6 + arg_214_0 then
				arg_211_1.var_.moveOldPos1284ui_story = var_214_5.localPosition
			end

			local var_214_7 = 0.001

			if var_214_6 <= arg_211_1.time_ and arg_211_1.time_ < var_214_6 + var_214_7 then
				local var_214_8 = (arg_211_1.time_ - var_214_6) / var_214_7
				local var_214_9 = Vector3.New(0.7, -0.985, -6.22)

				var_214_5.localPosition = Vector3.Lerp(arg_211_1.var_.moveOldPos1284ui_story, var_214_9, var_214_8)

				local var_214_10 = manager.ui.mainCamera.transform.position - var_214_5.position

				var_214_5.forward = Vector3.New(var_214_10.x, var_214_10.y, var_214_10.z)

				local var_214_11 = var_214_5.localEulerAngles

				var_214_11.z = 0
				var_214_11.x = 0
				var_214_5.localEulerAngles = var_214_11
			end

			if arg_211_1.time_ >= var_214_6 + var_214_7 and arg_211_1.time_ < var_214_6 + var_214_7 + arg_214_0 then
				var_214_5.localPosition = Vector3.New(0.7, -0.985, -6.22)

				local var_214_12 = manager.ui.mainCamera.transform.position - var_214_5.position

				var_214_5.forward = Vector3.New(var_214_12.x, var_214_12.y, var_214_12.z)

				local var_214_13 = var_214_5.localEulerAngles

				var_214_13.z = 0
				var_214_13.x = 0
				var_214_5.localEulerAngles = var_214_13
			end

			local var_214_14 = arg_211_1.actors_["1034ui_story"].transform
			local var_214_15 = 0

			if var_214_15 < arg_211_1.time_ and arg_211_1.time_ <= var_214_15 + arg_214_0 then
				arg_211_1.var_.moveOldPos1034ui_story = var_214_14.localPosition
			end

			local var_214_16 = 0.001

			if var_214_15 <= arg_211_1.time_ and arg_211_1.time_ < var_214_15 + var_214_16 then
				local var_214_17 = (arg_211_1.time_ - var_214_15) / var_214_16
				local var_214_18 = Vector3.New(-0.7, -0.93, -6)

				var_214_14.localPosition = Vector3.Lerp(arg_211_1.var_.moveOldPos1034ui_story, var_214_18, var_214_17)

				local var_214_19 = manager.ui.mainCamera.transform.position - var_214_14.position

				var_214_14.forward = Vector3.New(var_214_19.x, var_214_19.y, var_214_19.z)

				local var_214_20 = var_214_14.localEulerAngles

				var_214_20.z = 0
				var_214_20.x = 0
				var_214_14.localEulerAngles = var_214_20
			end

			if arg_211_1.time_ >= var_214_15 + var_214_16 and arg_211_1.time_ < var_214_15 + var_214_16 + arg_214_0 then
				var_214_14.localPosition = Vector3.New(-0.7, -0.93, -6)

				local var_214_21 = manager.ui.mainCamera.transform.position - var_214_14.position

				var_214_14.forward = Vector3.New(var_214_21.x, var_214_21.y, var_214_21.z)

				local var_214_22 = var_214_14.localEulerAngles

				var_214_22.z = 0
				var_214_22.x = 0
				var_214_14.localEulerAngles = var_214_22
			end

			local var_214_23 = arg_211_1.actors_["1284ui_story"]
			local var_214_24 = 0

			if var_214_24 < arg_211_1.time_ and arg_211_1.time_ <= var_214_24 + arg_214_0 and not isNil(var_214_23) and arg_211_1.var_.characterEffect1284ui_story == nil then
				arg_211_1.var_.characterEffect1284ui_story = var_214_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_214_25 = 0.200000002980232

			if var_214_24 <= arg_211_1.time_ and arg_211_1.time_ < var_214_24 + var_214_25 and not isNil(var_214_23) then
				local var_214_26 = (arg_211_1.time_ - var_214_24) / var_214_25

				if arg_211_1.var_.characterEffect1284ui_story and not isNil(var_214_23) then
					arg_211_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_211_1.time_ >= var_214_24 + var_214_25 and arg_211_1.time_ < var_214_24 + var_214_25 + arg_214_0 and not isNil(var_214_23) and arg_211_1.var_.characterEffect1284ui_story then
				arg_211_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_214_27 = 0

			if var_214_27 < arg_211_1.time_ and arg_211_1.time_ <= var_214_27 + arg_214_0 then
				arg_211_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action3_1")
			end

			local var_214_28 = 0

			if var_214_28 < arg_211_1.time_ and arg_211_1.time_ <= var_214_28 + arg_214_0 then
				arg_211_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_214_29 = 0
			local var_214_30 = 0.475

			if var_214_29 < arg_211_1.time_ and arg_211_1.time_ <= var_214_29 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, true)

				local var_214_31 = arg_211_1:FormatText(StoryNameCfg[6].name)

				arg_211_1.leftNameTxt_.text = var_214_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_211_1.leftNameTxt_.transform)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1.leftNameTxt_.text)
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_32 = arg_211_1:GetWordFromCfg(939012051)
				local var_214_33 = arg_211_1:FormatText(var_214_32.content)

				arg_211_1.text_.text = var_214_33

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_34 = 19
				local var_214_35 = utf8.len(var_214_33)
				local var_214_36 = var_214_34 <= 0 and var_214_30 or var_214_30 * (var_214_35 / var_214_34)

				if var_214_36 > 0 and var_214_30 < var_214_36 then
					arg_211_1.talkMaxDuration = var_214_36

					if var_214_36 + var_214_29 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_36 + var_214_29
					end
				end

				arg_211_1.text_.text = var_214_33
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)
				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_37 = math.max(var_214_30, arg_211_1.talkMaxDuration)

			if var_214_29 <= arg_211_1.time_ and arg_211_1.time_ < var_214_29 + var_214_37 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_29) / var_214_37

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_29 + var_214_37 and arg_211_1.time_ < var_214_29 + var_214_37 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1034ui_story",
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
	Play939012052 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 939012052
		arg_215_1.duration_ = 5

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play939012053(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			local var_218_0 = arg_215_1.actors_["1034ui_story"].transform
			local var_218_1 = 0

			if var_218_1 < arg_215_1.time_ and arg_215_1.time_ <= var_218_1 + arg_218_0 then
				arg_215_1.var_.moveOldPos1034ui_story = var_218_0.localPosition
			end

			local var_218_2 = 0.001

			if var_218_1 <= arg_215_1.time_ and arg_215_1.time_ < var_218_1 + var_218_2 then
				local var_218_3 = (arg_215_1.time_ - var_218_1) / var_218_2
				local var_218_4 = Vector3.New(-0.7, -0.93, -6)

				var_218_0.localPosition = Vector3.Lerp(arg_215_1.var_.moveOldPos1034ui_story, var_218_4, var_218_3)

				local var_218_5 = manager.ui.mainCamera.transform.position - var_218_0.position

				var_218_0.forward = Vector3.New(var_218_5.x, var_218_5.y, var_218_5.z)

				local var_218_6 = var_218_0.localEulerAngles

				var_218_6.z = 0
				var_218_6.x = 0
				var_218_0.localEulerAngles = var_218_6
			end

			if arg_215_1.time_ >= var_218_1 + var_218_2 and arg_215_1.time_ < var_218_1 + var_218_2 + arg_218_0 then
				var_218_0.localPosition = Vector3.New(-0.7, -0.93, -6)

				local var_218_7 = manager.ui.mainCamera.transform.position - var_218_0.position

				var_218_0.forward = Vector3.New(var_218_7.x, var_218_7.y, var_218_7.z)

				local var_218_8 = var_218_0.localEulerAngles

				var_218_8.z = 0
				var_218_8.x = 0
				var_218_0.localEulerAngles = var_218_8
			end

			local var_218_9 = arg_215_1.actors_["1034ui_story"]
			local var_218_10 = 0

			if var_218_10 < arg_215_1.time_ and arg_215_1.time_ <= var_218_10 + arg_218_0 and not isNil(var_218_9) and arg_215_1.var_.characterEffect1034ui_story == nil then
				arg_215_1.var_.characterEffect1034ui_story = var_218_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_218_11 = 0.200000002980232

			if var_218_10 <= arg_215_1.time_ and arg_215_1.time_ < var_218_10 + var_218_11 and not isNil(var_218_9) then
				local var_218_12 = (arg_215_1.time_ - var_218_10) / var_218_11

				if arg_215_1.var_.characterEffect1034ui_story and not isNil(var_218_9) then
					arg_215_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_215_1.time_ >= var_218_10 + var_218_11 and arg_215_1.time_ < var_218_10 + var_218_11 + arg_218_0 and not isNil(var_218_9) and arg_215_1.var_.characterEffect1034ui_story then
				arg_215_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			local var_218_13 = arg_215_1.actors_["1284ui_story"]
			local var_218_14 = 0

			if var_218_14 < arg_215_1.time_ and arg_215_1.time_ <= var_218_14 + arg_218_0 and not isNil(var_218_13) and arg_215_1.var_.characterEffect1284ui_story == nil then
				arg_215_1.var_.characterEffect1284ui_story = var_218_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_218_15 = 0.200000002980232

			if var_218_14 <= arg_215_1.time_ and arg_215_1.time_ < var_218_14 + var_218_15 and not isNil(var_218_13) then
				local var_218_16 = (arg_215_1.time_ - var_218_14) / var_218_15

				if arg_215_1.var_.characterEffect1284ui_story and not isNil(var_218_13) then
					local var_218_17 = Mathf.Lerp(0, 0.5, var_218_16)

					arg_215_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_215_1.var_.characterEffect1284ui_story.fillRatio = var_218_17
				end
			end

			if arg_215_1.time_ >= var_218_14 + var_218_15 and arg_215_1.time_ < var_218_14 + var_218_15 + arg_218_0 and not isNil(var_218_13) and arg_215_1.var_.characterEffect1284ui_story then
				local var_218_18 = 0.5

				arg_215_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_215_1.var_.characterEffect1284ui_story.fillRatio = var_218_18
			end

			local var_218_19 = 0

			if var_218_19 < arg_215_1.time_ and arg_215_1.time_ <= var_218_19 + arg_218_0 then
				arg_215_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action3_2")
			end

			local var_218_20 = 0

			if var_218_20 < arg_215_1.time_ and arg_215_1.time_ <= var_218_20 + arg_218_0 then
				arg_215_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_218_21 = 0
			local var_218_22 = 1.175

			if var_218_21 < arg_215_1.time_ and arg_215_1.time_ <= var_218_21 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				local var_218_23 = arg_215_1:FormatText(StoryNameCfg[1109].name)

				arg_215_1.leftNameTxt_.text = var_218_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_24 = arg_215_1:GetWordFromCfg(939012052)
				local var_218_25 = arg_215_1:FormatText(var_218_24.content)

				arg_215_1.text_.text = var_218_25

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_26 = 47
				local var_218_27 = utf8.len(var_218_25)
				local var_218_28 = var_218_26 <= 0 and var_218_22 or var_218_22 * (var_218_27 / var_218_26)

				if var_218_28 > 0 and var_218_22 < var_218_28 then
					arg_215_1.talkMaxDuration = var_218_28

					if var_218_28 + var_218_21 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_28 + var_218_21
					end
				end

				arg_215_1.text_.text = var_218_25
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)
				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_29 = math.max(var_218_22, arg_215_1.talkMaxDuration)

			if var_218_21 <= arg_215_1.time_ and arg_215_1.time_ < var_218_21 + var_218_29 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_21) / var_218_29

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_21 + var_218_29 and arg_215_1.time_ < var_218_21 + var_218_29 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_215_1:InitPlayNodeList()
	end,
	Play939012053 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 939012053
		arg_219_1.duration_ = 5

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play939012054(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			local var_222_0 = arg_219_1.actors_["1012ui_story"].transform
			local var_222_1 = 0

			if var_222_1 < arg_219_1.time_ and arg_219_1.time_ <= var_222_1 + arg_222_0 then
				arg_219_1.var_.moveOldPos1012ui_story = var_222_0.localPosition
			end

			local var_222_2 = 0.001

			if var_222_1 <= arg_219_1.time_ and arg_219_1.time_ < var_222_1 + var_222_2 then
				local var_222_3 = (arg_219_1.time_ - var_222_1) / var_222_2
				local var_222_4 = Vector3.New(0.7, -1.05, -6.24)

				var_222_0.localPosition = Vector3.Lerp(arg_219_1.var_.moveOldPos1012ui_story, var_222_4, var_222_3)

				local var_222_5 = manager.ui.mainCamera.transform.position - var_222_0.position

				var_222_0.forward = Vector3.New(var_222_5.x, var_222_5.y, var_222_5.z)

				local var_222_6 = var_222_0.localEulerAngles

				var_222_6.z = 0
				var_222_6.x = 0
				var_222_0.localEulerAngles = var_222_6
			end

			if arg_219_1.time_ >= var_222_1 + var_222_2 and arg_219_1.time_ < var_222_1 + var_222_2 + arg_222_0 then
				var_222_0.localPosition = Vector3.New(0.7, -1.05, -6.24)

				local var_222_7 = manager.ui.mainCamera.transform.position - var_222_0.position

				var_222_0.forward = Vector3.New(var_222_7.x, var_222_7.y, var_222_7.z)

				local var_222_8 = var_222_0.localEulerAngles

				var_222_8.z = 0
				var_222_8.x = 0
				var_222_0.localEulerAngles = var_222_8
			end

			local var_222_9 = arg_219_1.actors_["1284ui_story"].transform
			local var_222_10 = 0

			if var_222_10 < arg_219_1.time_ and arg_219_1.time_ <= var_222_10 + arg_222_0 then
				arg_219_1.var_.moveOldPos1284ui_story = var_222_9.localPosition
			end

			local var_222_11 = 0.001

			if var_222_10 <= arg_219_1.time_ and arg_219_1.time_ < var_222_10 + var_222_11 then
				local var_222_12 = (arg_219_1.time_ - var_222_10) / var_222_11
				local var_222_13 = Vector3.New(0, 100, 0)

				var_222_9.localPosition = Vector3.Lerp(arg_219_1.var_.moveOldPos1284ui_story, var_222_13, var_222_12)

				local var_222_14 = manager.ui.mainCamera.transform.position - var_222_9.position

				var_222_9.forward = Vector3.New(var_222_14.x, var_222_14.y, var_222_14.z)

				local var_222_15 = var_222_9.localEulerAngles

				var_222_15.z = 0
				var_222_15.x = 0
				var_222_9.localEulerAngles = var_222_15
			end

			if arg_219_1.time_ >= var_222_10 + var_222_11 and arg_219_1.time_ < var_222_10 + var_222_11 + arg_222_0 then
				var_222_9.localPosition = Vector3.New(0, 100, 0)

				local var_222_16 = manager.ui.mainCamera.transform.position - var_222_9.position

				var_222_9.forward = Vector3.New(var_222_16.x, var_222_16.y, var_222_16.z)

				local var_222_17 = var_222_9.localEulerAngles

				var_222_17.z = 0
				var_222_17.x = 0
				var_222_9.localEulerAngles = var_222_17
			end

			local var_222_18 = arg_219_1.actors_["1012ui_story"]
			local var_222_19 = 0

			if var_222_19 < arg_219_1.time_ and arg_219_1.time_ <= var_222_19 + arg_222_0 and not isNil(var_222_18) and arg_219_1.var_.characterEffect1012ui_story == nil then
				arg_219_1.var_.characterEffect1012ui_story = var_222_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_222_20 = 0.200000002980232

			if var_222_19 <= arg_219_1.time_ and arg_219_1.time_ < var_222_19 + var_222_20 and not isNil(var_222_18) then
				local var_222_21 = (arg_219_1.time_ - var_222_19) / var_222_20

				if arg_219_1.var_.characterEffect1012ui_story and not isNil(var_222_18) then
					arg_219_1.var_.characterEffect1012ui_story.fillFlat = false
				end
			end

			if arg_219_1.time_ >= var_222_19 + var_222_20 and arg_219_1.time_ < var_222_19 + var_222_20 + arg_222_0 and not isNil(var_222_18) and arg_219_1.var_.characterEffect1012ui_story then
				arg_219_1.var_.characterEffect1012ui_story.fillFlat = false
			end

			local var_222_22 = arg_219_1.actors_["1034ui_story"]
			local var_222_23 = 0

			if var_222_23 < arg_219_1.time_ and arg_219_1.time_ <= var_222_23 + arg_222_0 and not isNil(var_222_22) and arg_219_1.var_.characterEffect1034ui_story == nil then
				arg_219_1.var_.characterEffect1034ui_story = var_222_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_222_24 = 0.200000002980232

			if var_222_23 <= arg_219_1.time_ and arg_219_1.time_ < var_222_23 + var_222_24 and not isNil(var_222_22) then
				local var_222_25 = (arg_219_1.time_ - var_222_23) / var_222_24

				if arg_219_1.var_.characterEffect1034ui_story and not isNil(var_222_22) then
					local var_222_26 = Mathf.Lerp(0, 0.5, var_222_25)

					arg_219_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_219_1.var_.characterEffect1034ui_story.fillRatio = var_222_26
				end
			end

			if arg_219_1.time_ >= var_222_23 + var_222_24 and arg_219_1.time_ < var_222_23 + var_222_24 + arg_222_0 and not isNil(var_222_22) and arg_219_1.var_.characterEffect1034ui_story then
				local var_222_27 = 0.5

				arg_219_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_219_1.var_.characterEffect1034ui_story.fillRatio = var_222_27
			end

			local var_222_28 = 0

			if var_222_28 < arg_219_1.time_ and arg_219_1.time_ <= var_222_28 + arg_222_0 then
				arg_219_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/story1012/story1012actionlink/1012action424")
			end

			local var_222_29 = 0

			if var_222_29 < arg_219_1.time_ and arg_219_1.time_ <= var_222_29 + arg_222_0 then
				arg_219_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/public_expression/expr_wuganA", "EmotionTimelineAnimator")
			end

			local var_222_30 = 0
			local var_222_31 = 0.275

			if var_222_30 < arg_219_1.time_ and arg_219_1.time_ <= var_222_30 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				local var_222_32 = arg_219_1:FormatText(StoryNameCfg[595].name)

				arg_219_1.leftNameTxt_.text = var_222_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_33 = arg_219_1:GetWordFromCfg(939012053)
				local var_222_34 = arg_219_1:FormatText(var_222_33.content)

				arg_219_1.text_.text = var_222_34

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_35 = 11
				local var_222_36 = utf8.len(var_222_34)
				local var_222_37 = var_222_35 <= 0 and var_222_31 or var_222_31 * (var_222_36 / var_222_35)

				if var_222_37 > 0 and var_222_31 < var_222_37 then
					arg_219_1.talkMaxDuration = var_222_37

					if var_222_37 + var_222_30 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_37 + var_222_30
					end
				end

				arg_219_1.text_.text = var_222_34
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)
				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_38 = math.max(var_222_31, arg_219_1.talkMaxDuration)

			if var_222_30 <= arg_219_1.time_ and arg_219_1.time_ < var_222_30 + var_222_38 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_30) / var_222_38

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_30 + var_222_38 and arg_219_1.time_ < var_222_30 + var_222_38 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_219_1:InitPlayNodeList()
	end,
	Play939012054 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 939012054
		arg_223_1.duration_ = 5

		SetActive(arg_223_1.tipsGo_, false)

		function arg_223_1.onSingleLineFinish_()
			arg_223_1.onSingleLineUpdate_ = nil
			arg_223_1.onSingleLineFinish_ = nil
			arg_223_1.state_ = "waiting"
		end

		function arg_223_1.playNext_(arg_225_0)
			if arg_225_0 == 1 then
				arg_223_0:Play939012055(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			local var_226_0 = arg_223_1.actors_["1012ui_story"]
			local var_226_1 = 0

			if var_226_1 < arg_223_1.time_ and arg_223_1.time_ <= var_226_1 + arg_226_0 and not isNil(var_226_0) and arg_223_1.var_.characterEffect1012ui_story == nil then
				arg_223_1.var_.characterEffect1012ui_story = var_226_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_226_2 = 0.200000002980232

			if var_226_1 <= arg_223_1.time_ and arg_223_1.time_ < var_226_1 + var_226_2 and not isNil(var_226_0) then
				local var_226_3 = (arg_223_1.time_ - var_226_1) / var_226_2

				if arg_223_1.var_.characterEffect1012ui_story and not isNil(var_226_0) then
					local var_226_4 = Mathf.Lerp(0, 0.5, var_226_3)

					arg_223_1.var_.characterEffect1012ui_story.fillFlat = true
					arg_223_1.var_.characterEffect1012ui_story.fillRatio = var_226_4
				end
			end

			if arg_223_1.time_ >= var_226_1 + var_226_2 and arg_223_1.time_ < var_226_1 + var_226_2 + arg_226_0 and not isNil(var_226_0) and arg_223_1.var_.characterEffect1012ui_story then
				local var_226_5 = 0.5

				arg_223_1.var_.characterEffect1012ui_story.fillFlat = true
				arg_223_1.var_.characterEffect1012ui_story.fillRatio = var_226_5
			end

			local var_226_6 = 0
			local var_226_7 = 0.85

			if var_226_6 < arg_223_1.time_ and arg_223_1.time_ <= var_226_6 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				local var_226_8 = arg_223_1:FormatText(StoryNameCfg[7].name)

				arg_223_1.leftNameTxt_.text = var_226_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, true)
				arg_223_1.iconController_:SetSelectedState("hero")

				arg_223_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_223_1.callingController_:SetSelectedState("normal")

				arg_223_1.keyicon_.color = Color.New(1, 1, 1)
				arg_223_1.icon_.color = Color.New(1, 1, 1)

				local var_226_9 = arg_223_1:GetWordFromCfg(939012054)
				local var_226_10 = arg_223_1:FormatText(var_226_9.content)

				arg_223_1.text_.text = var_226_10

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_11 = 34
				local var_226_12 = utf8.len(var_226_10)
				local var_226_13 = var_226_11 <= 0 and var_226_7 or var_226_7 * (var_226_12 / var_226_11)

				if var_226_13 > 0 and var_226_7 < var_226_13 then
					arg_223_1.talkMaxDuration = var_226_13

					if var_226_13 + var_226_6 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_13 + var_226_6
					end
				end

				arg_223_1.text_.text = var_226_10
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)
				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_14 = math.max(var_226_7, arg_223_1.talkMaxDuration)

			if var_226_6 <= arg_223_1.time_ and arg_223_1.time_ < var_226_6 + var_226_14 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_6) / var_226_14

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_6 + var_226_14 and arg_223_1.time_ < var_226_6 + var_226_14 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {}

		arg_223_1:InitPlayNodeList()
	end,
	Play939012055 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 939012055
		arg_227_1.duration_ = 5

		SetActive(arg_227_1.tipsGo_, false)

		function arg_227_1.onSingleLineFinish_()
			arg_227_1.onSingleLineUpdate_ = nil
			arg_227_1.onSingleLineFinish_ = nil
			arg_227_1.state_ = "waiting"
		end

		function arg_227_1.playNext_(arg_229_0)
			if arg_229_0 == 1 then
				arg_227_0:Play939012056(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			local var_230_0 = arg_227_1.actors_["6148ui_story"].transform
			local var_230_1 = 0

			if var_230_1 < arg_227_1.time_ and arg_227_1.time_ <= var_230_1 + arg_230_0 then
				arg_227_1.var_.moveOldPos6148ui_story = var_230_0.localPosition

				local var_230_2 = GameObjectTools.GetOrAddComponent(var_230_0.gameObject, typeof(DynamicBoneHelper))

				if var_230_2 then
					var_230_2:EnableDynamicBone(false)
				end
			end

			local var_230_3 = 0.001

			if var_230_1 <= arg_227_1.time_ and arg_227_1.time_ < var_230_1 + var_230_3 then
				local var_230_4 = (arg_227_1.time_ - var_230_1) / var_230_3
				local var_230_5 = Vector3.New(-0.7, -0.985, -6)

				var_230_0.localPosition = Vector3.Lerp(arg_227_1.var_.moveOldPos6148ui_story, var_230_5, var_230_4)

				local var_230_6 = manager.ui.mainCamera.transform.position - var_230_0.position

				var_230_0.forward = Vector3.New(var_230_6.x, var_230_6.y, var_230_6.z)

				local var_230_7 = var_230_0.localEulerAngles

				var_230_7.z = 0
				var_230_7.x = 0
				var_230_0.localEulerAngles = var_230_7
			end

			if arg_227_1.time_ >= var_230_1 + var_230_3 and arg_227_1.time_ < var_230_1 + var_230_3 + arg_230_0 then
				var_230_0.localPosition = Vector3.New(-0.7, -0.985, -6)

				local var_230_8 = manager.ui.mainCamera.transform.position - var_230_0.position

				var_230_0.forward = Vector3.New(var_230_8.x, var_230_8.y, var_230_8.z)

				local var_230_9 = var_230_0.localEulerAngles

				var_230_9.z = 0
				var_230_9.x = 0
				var_230_0.localEulerAngles = var_230_9

				local var_230_10 = GameObjectTools.GetOrAddComponent(var_230_0.gameObject, typeof(DynamicBoneHelper))

				if var_230_10 then
					var_230_10:EnableDynamicBone(true)
				end
			end

			local var_230_11 = arg_227_1.actors_["1034ui_story"].transform
			local var_230_12 = 0

			if var_230_12 < arg_227_1.time_ and arg_227_1.time_ <= var_230_12 + arg_230_0 then
				arg_227_1.var_.moveOldPos1034ui_story = var_230_11.localPosition
			end

			local var_230_13 = 0.001

			if var_230_12 <= arg_227_1.time_ and arg_227_1.time_ < var_230_12 + var_230_13 then
				local var_230_14 = (arg_227_1.time_ - var_230_12) / var_230_13
				local var_230_15 = Vector3.New(0, 100, 0)

				var_230_11.localPosition = Vector3.Lerp(arg_227_1.var_.moveOldPos1034ui_story, var_230_15, var_230_14)

				local var_230_16 = manager.ui.mainCamera.transform.position - var_230_11.position

				var_230_11.forward = Vector3.New(var_230_16.x, var_230_16.y, var_230_16.z)

				local var_230_17 = var_230_11.localEulerAngles

				var_230_17.z = 0
				var_230_17.x = 0
				var_230_11.localEulerAngles = var_230_17
			end

			if arg_227_1.time_ >= var_230_12 + var_230_13 and arg_227_1.time_ < var_230_12 + var_230_13 + arg_230_0 then
				var_230_11.localPosition = Vector3.New(0, 100, 0)

				local var_230_18 = manager.ui.mainCamera.transform.position - var_230_11.position

				var_230_11.forward = Vector3.New(var_230_18.x, var_230_18.y, var_230_18.z)

				local var_230_19 = var_230_11.localEulerAngles

				var_230_19.z = 0
				var_230_19.x = 0
				var_230_11.localEulerAngles = var_230_19
			end

			local var_230_20 = arg_227_1.actors_["6148ui_story"]
			local var_230_21 = 0

			if var_230_21 < arg_227_1.time_ and arg_227_1.time_ <= var_230_21 + arg_230_0 and not isNil(var_230_20) and arg_227_1.var_.characterEffect6148ui_story == nil then
				arg_227_1.var_.characterEffect6148ui_story = var_230_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_230_22 = 0.200000002980232

			if var_230_21 <= arg_227_1.time_ and arg_227_1.time_ < var_230_21 + var_230_22 and not isNil(var_230_20) then
				local var_230_23 = (arg_227_1.time_ - var_230_21) / var_230_22

				if arg_227_1.var_.characterEffect6148ui_story and not isNil(var_230_20) then
					arg_227_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_227_1.time_ >= var_230_21 + var_230_22 and arg_227_1.time_ < var_230_21 + var_230_22 + arg_230_0 and not isNil(var_230_20) and arg_227_1.var_.characterEffect6148ui_story then
				arg_227_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_230_24 = 0

			if var_230_24 < arg_227_1.time_ and arg_227_1.time_ <= var_230_24 + arg_230_0 then
				arg_227_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action2_1")
			end

			local var_230_25 = 0

			if var_230_25 < arg_227_1.time_ and arg_227_1.time_ <= var_230_25 + arg_230_0 then
				arg_227_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_230_26 = 0
			local var_230_27 = 0.9

			if var_230_26 < arg_227_1.time_ and arg_227_1.time_ <= var_230_26 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				local var_230_28 = arg_227_1:FormatText(StoryNameCfg[1488].name)

				arg_227_1.leftNameTxt_.text = var_230_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_29 = arg_227_1:GetWordFromCfg(939012055)
				local var_230_30 = arg_227_1:FormatText(var_230_29.content)

				arg_227_1.text_.text = var_230_30

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_31 = 36
				local var_230_32 = utf8.len(var_230_30)
				local var_230_33 = var_230_31 <= 0 and var_230_27 or var_230_27 * (var_230_32 / var_230_31)

				if var_230_33 > 0 and var_230_27 < var_230_33 then
					arg_227_1.talkMaxDuration = var_230_33

					if var_230_33 + var_230_26 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_33 + var_230_26
					end
				end

				arg_227_1.text_.text = var_230_30
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)
				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_34 = math.max(var_230_27, arg_227_1.talkMaxDuration)

			if var_230_26 <= arg_227_1.time_ and arg_227_1.time_ < var_230_26 + var_230_34 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_26) / var_230_34

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_26 + var_230_34 and arg_227_1.time_ < var_230_26 + var_230_34 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1034ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_227_1:InitPlayNodeList()
	end,
	Play939012056 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 939012056
		arg_231_1.duration_ = 5

		SetActive(arg_231_1.tipsGo_, false)

		function arg_231_1.onSingleLineFinish_()
			arg_231_1.onSingleLineUpdate_ = nil
			arg_231_1.onSingleLineFinish_ = nil
			arg_231_1.state_ = "waiting"
		end

		function arg_231_1.playNext_(arg_233_0)
			if arg_233_0 == 1 then
				arg_231_0:Play939012057(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			local var_234_0 = arg_231_1.actors_["1012ui_story"].transform
			local var_234_1 = 0

			if var_234_1 < arg_231_1.time_ and arg_231_1.time_ <= var_234_1 + arg_234_0 then
				arg_231_1.var_.moveOldPos1012ui_story = var_234_0.localPosition
			end

			local var_234_2 = 0.001

			if var_234_1 <= arg_231_1.time_ and arg_231_1.time_ < var_234_1 + var_234_2 then
				local var_234_3 = (arg_231_1.time_ - var_234_1) / var_234_2
				local var_234_4 = Vector3.New(0.7, -1.05, -6.24)

				var_234_0.localPosition = Vector3.Lerp(arg_231_1.var_.moveOldPos1012ui_story, var_234_4, var_234_3)

				local var_234_5 = manager.ui.mainCamera.transform.position - var_234_0.position

				var_234_0.forward = Vector3.New(var_234_5.x, var_234_5.y, var_234_5.z)

				local var_234_6 = var_234_0.localEulerAngles

				var_234_6.z = 0
				var_234_6.x = 0
				var_234_0.localEulerAngles = var_234_6
			end

			if arg_231_1.time_ >= var_234_1 + var_234_2 and arg_231_1.time_ < var_234_1 + var_234_2 + arg_234_0 then
				var_234_0.localPosition = Vector3.New(0.7, -1.05, -6.24)

				local var_234_7 = manager.ui.mainCamera.transform.position - var_234_0.position

				var_234_0.forward = Vector3.New(var_234_7.x, var_234_7.y, var_234_7.z)

				local var_234_8 = var_234_0.localEulerAngles

				var_234_8.z = 0
				var_234_8.x = 0
				var_234_0.localEulerAngles = var_234_8
			end

			local var_234_9 = arg_231_1.actors_["1012ui_story"]
			local var_234_10 = 0

			if var_234_10 < arg_231_1.time_ and arg_231_1.time_ <= var_234_10 + arg_234_0 and not isNil(var_234_9) and arg_231_1.var_.characterEffect1012ui_story == nil then
				arg_231_1.var_.characterEffect1012ui_story = var_234_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_234_11 = 0.200000002980232

			if var_234_10 <= arg_231_1.time_ and arg_231_1.time_ < var_234_10 + var_234_11 and not isNil(var_234_9) then
				local var_234_12 = (arg_231_1.time_ - var_234_10) / var_234_11

				if arg_231_1.var_.characterEffect1012ui_story and not isNil(var_234_9) then
					arg_231_1.var_.characterEffect1012ui_story.fillFlat = false
				end
			end

			if arg_231_1.time_ >= var_234_10 + var_234_11 and arg_231_1.time_ < var_234_10 + var_234_11 + arg_234_0 and not isNil(var_234_9) and arg_231_1.var_.characterEffect1012ui_story then
				arg_231_1.var_.characterEffect1012ui_story.fillFlat = false
			end

			local var_234_13 = arg_231_1.actors_["6148ui_story"]
			local var_234_14 = 0

			if var_234_14 < arg_231_1.time_ and arg_231_1.time_ <= var_234_14 + arg_234_0 and not isNil(var_234_13) and arg_231_1.var_.characterEffect6148ui_story == nil then
				arg_231_1.var_.characterEffect6148ui_story = var_234_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_234_15 = 0.200000002980232

			if var_234_14 <= arg_231_1.time_ and arg_231_1.time_ < var_234_14 + var_234_15 and not isNil(var_234_13) then
				local var_234_16 = (arg_231_1.time_ - var_234_14) / var_234_15

				if arg_231_1.var_.characterEffect6148ui_story and not isNil(var_234_13) then
					local var_234_17 = Mathf.Lerp(0, 0.5, var_234_16)

					arg_231_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_231_1.var_.characterEffect6148ui_story.fillRatio = var_234_17
				end
			end

			if arg_231_1.time_ >= var_234_14 + var_234_15 and arg_231_1.time_ < var_234_14 + var_234_15 + arg_234_0 and not isNil(var_234_13) and arg_231_1.var_.characterEffect6148ui_story then
				local var_234_18 = 0.5

				arg_231_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_231_1.var_.characterEffect6148ui_story.fillRatio = var_234_18
			end

			local var_234_19 = 0

			if var_234_19 < arg_231_1.time_ and arg_231_1.time_ <= var_234_19 + arg_234_0 then
				arg_231_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/story1012/story1012action/1012action4_2")
			end

			local var_234_20 = 0

			if var_234_20 < arg_231_1.time_ and arg_231_1.time_ <= var_234_20 + arg_234_0 then
				arg_231_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_234_21 = 0
			local var_234_22 = 0.55

			if var_234_21 < arg_231_1.time_ and arg_231_1.time_ <= var_234_21 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				local var_234_23 = arg_231_1:FormatText(StoryNameCfg[595].name)

				arg_231_1.leftNameTxt_.text = var_234_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_24 = arg_231_1:GetWordFromCfg(939012056)
				local var_234_25 = arg_231_1:FormatText(var_234_24.content)

				arg_231_1.text_.text = var_234_25

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_26 = 22
				local var_234_27 = utf8.len(var_234_25)
				local var_234_28 = var_234_26 <= 0 and var_234_22 or var_234_22 * (var_234_27 / var_234_26)

				if var_234_28 > 0 and var_234_22 < var_234_28 then
					arg_231_1.talkMaxDuration = var_234_28

					if var_234_28 + var_234_21 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_28 + var_234_21
					end
				end

				arg_231_1.text_.text = var_234_25
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)
				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_29 = math.max(var_234_22, arg_231_1.talkMaxDuration)

			if var_234_21 <= arg_231_1.time_ and arg_231_1.time_ < var_234_21 + var_234_29 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_21) / var_234_29

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_21 + var_234_29 and arg_231_1.time_ < var_234_21 + var_234_29 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012ui_story",
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
	Play939012057 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 939012057
		arg_235_1.duration_ = 5

		SetActive(arg_235_1.tipsGo_, false)

		function arg_235_1.onSingleLineFinish_()
			arg_235_1.onSingleLineUpdate_ = nil
			arg_235_1.onSingleLineFinish_ = nil
			arg_235_1.state_ = "waiting"
		end

		function arg_235_1.playNext_(arg_237_0)
			if arg_237_0 == 1 then
				arg_235_0:Play939012058(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			local var_238_0 = arg_235_1.actors_["1034ui_story"].transform
			local var_238_1 = 0

			if var_238_1 < arg_235_1.time_ and arg_235_1.time_ <= var_238_1 + arg_238_0 then
				arg_235_1.var_.moveOldPos1034ui_story = var_238_0.localPosition
			end

			local var_238_2 = 0.001

			if var_238_1 <= arg_235_1.time_ and arg_235_1.time_ < var_238_1 + var_238_2 then
				local var_238_3 = (arg_235_1.time_ - var_238_1) / var_238_2
				local var_238_4 = Vector3.New(-0.7, -0.93, -6)

				var_238_0.localPosition = Vector3.Lerp(arg_235_1.var_.moveOldPos1034ui_story, var_238_4, var_238_3)

				local var_238_5 = manager.ui.mainCamera.transform.position - var_238_0.position

				var_238_0.forward = Vector3.New(var_238_5.x, var_238_5.y, var_238_5.z)

				local var_238_6 = var_238_0.localEulerAngles

				var_238_6.z = 0
				var_238_6.x = 0
				var_238_0.localEulerAngles = var_238_6
			end

			if arg_235_1.time_ >= var_238_1 + var_238_2 and arg_235_1.time_ < var_238_1 + var_238_2 + arg_238_0 then
				var_238_0.localPosition = Vector3.New(-0.7, -0.93, -6)

				local var_238_7 = manager.ui.mainCamera.transform.position - var_238_0.position

				var_238_0.forward = Vector3.New(var_238_7.x, var_238_7.y, var_238_7.z)

				local var_238_8 = var_238_0.localEulerAngles

				var_238_8.z = 0
				var_238_8.x = 0
				var_238_0.localEulerAngles = var_238_8
			end

			local var_238_9 = arg_235_1.actors_["6148ui_story"].transform
			local var_238_10 = 0

			if var_238_10 < arg_235_1.time_ and arg_235_1.time_ <= var_238_10 + arg_238_0 then
				arg_235_1.var_.moveOldPos6148ui_story = var_238_9.localPosition

				local var_238_11 = GameObjectTools.GetOrAddComponent(var_238_9.gameObject, typeof(DynamicBoneHelper))

				if var_238_11 then
					var_238_11:EnableDynamicBone(false)
				end
			end

			local var_238_12 = 0.001

			if var_238_10 <= arg_235_1.time_ and arg_235_1.time_ < var_238_10 + var_238_12 then
				local var_238_13 = (arg_235_1.time_ - var_238_10) / var_238_12
				local var_238_14 = Vector3.New(0, 100, 0)

				var_238_9.localPosition = Vector3.Lerp(arg_235_1.var_.moveOldPos6148ui_story, var_238_14, var_238_13)

				local var_238_15 = manager.ui.mainCamera.transform.position - var_238_9.position

				var_238_9.forward = Vector3.New(var_238_15.x, var_238_15.y, var_238_15.z)

				local var_238_16 = var_238_9.localEulerAngles

				var_238_16.z = 0
				var_238_16.x = 0
				var_238_9.localEulerAngles = var_238_16
			end

			if arg_235_1.time_ >= var_238_10 + var_238_12 and arg_235_1.time_ < var_238_10 + var_238_12 + arg_238_0 then
				var_238_9.localPosition = Vector3.New(0, 100, 0)

				local var_238_17 = manager.ui.mainCamera.transform.position - var_238_9.position

				var_238_9.forward = Vector3.New(var_238_17.x, var_238_17.y, var_238_17.z)

				local var_238_18 = var_238_9.localEulerAngles

				var_238_18.z = 0
				var_238_18.x = 0
				var_238_9.localEulerAngles = var_238_18

				local var_238_19 = GameObjectTools.GetOrAddComponent(var_238_9.gameObject, typeof(DynamicBoneHelper))

				if var_238_19 then
					var_238_19:EnableDynamicBone(true)
				end
			end

			local var_238_20 = arg_235_1.actors_["1034ui_story"]
			local var_238_21 = 0

			if var_238_21 < arg_235_1.time_ and arg_235_1.time_ <= var_238_21 + arg_238_0 and not isNil(var_238_20) and arg_235_1.var_.characterEffect1034ui_story == nil then
				arg_235_1.var_.characterEffect1034ui_story = var_238_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_238_22 = 0.200000002980232

			if var_238_21 <= arg_235_1.time_ and arg_235_1.time_ < var_238_21 + var_238_22 and not isNil(var_238_20) then
				local var_238_23 = (arg_235_1.time_ - var_238_21) / var_238_22

				if arg_235_1.var_.characterEffect1034ui_story and not isNil(var_238_20) then
					arg_235_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_235_1.time_ >= var_238_21 + var_238_22 and arg_235_1.time_ < var_238_21 + var_238_22 + arg_238_0 and not isNil(var_238_20) and arg_235_1.var_.characterEffect1034ui_story then
				arg_235_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			local var_238_24 = arg_235_1.actors_["1012ui_story"]
			local var_238_25 = 0

			if var_238_25 < arg_235_1.time_ and arg_235_1.time_ <= var_238_25 + arg_238_0 and not isNil(var_238_24) and arg_235_1.var_.characterEffect1012ui_story == nil then
				arg_235_1.var_.characterEffect1012ui_story = var_238_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_238_26 = 0.200000002980232

			if var_238_25 <= arg_235_1.time_ and arg_235_1.time_ < var_238_25 + var_238_26 and not isNil(var_238_24) then
				local var_238_27 = (arg_235_1.time_ - var_238_25) / var_238_26

				if arg_235_1.var_.characterEffect1012ui_story and not isNil(var_238_24) then
					local var_238_28 = Mathf.Lerp(0, 0.5, var_238_27)

					arg_235_1.var_.characterEffect1012ui_story.fillFlat = true
					arg_235_1.var_.characterEffect1012ui_story.fillRatio = var_238_28
				end
			end

			if arg_235_1.time_ >= var_238_25 + var_238_26 and arg_235_1.time_ < var_238_25 + var_238_26 + arg_238_0 and not isNil(var_238_24) and arg_235_1.var_.characterEffect1012ui_story then
				local var_238_29 = 0.5

				arg_235_1.var_.characterEffect1012ui_story.fillFlat = true
				arg_235_1.var_.characterEffect1012ui_story.fillRatio = var_238_29
			end

			local var_238_30 = 0

			if var_238_30 < arg_235_1.time_ and arg_235_1.time_ <= var_238_30 + arg_238_0 then
				arg_235_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action1_1")
			end

			local var_238_31 = 0

			if var_238_31 < arg_235_1.time_ and arg_235_1.time_ <= var_238_31 + arg_238_0 then
				arg_235_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_238_32 = 0
			local var_238_33 = 0.85

			if var_238_32 < arg_235_1.time_ and arg_235_1.time_ <= var_238_32 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				local var_238_34 = arg_235_1:FormatText(StoryNameCfg[1109].name)

				arg_235_1.leftNameTxt_.text = var_238_34

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_35 = arg_235_1:GetWordFromCfg(939012057)
				local var_238_36 = arg_235_1:FormatText(var_238_35.content)

				arg_235_1.text_.text = var_238_36

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_37 = 34
				local var_238_38 = utf8.len(var_238_36)
				local var_238_39 = var_238_37 <= 0 and var_238_33 or var_238_33 * (var_238_38 / var_238_37)

				if var_238_39 > 0 and var_238_33 < var_238_39 then
					arg_235_1.talkMaxDuration = var_238_39

					if var_238_39 + var_238_32 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_39 + var_238_32
					end
				end

				arg_235_1.text_.text = var_238_36
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)
				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_40 = math.max(var_238_33, arg_235_1.talkMaxDuration)

			if var_238_32 <= arg_235_1.time_ and arg_235_1.time_ < var_238_32 + var_238_40 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_32) / var_238_40

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_32 + var_238_40 and arg_235_1.time_ < var_238_32 + var_238_40 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_235_1:InitPlayNodeList()
	end,
	Play939012058 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 939012058
		arg_239_1.duration_ = 5

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play939012059(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			local var_242_0 = arg_239_1.actors_["1034ui_story"].transform
			local var_242_1 = 0

			if var_242_1 < arg_239_1.time_ and arg_239_1.time_ <= var_242_1 + arg_242_0 then
				arg_239_1.var_.moveOldPos1034ui_story = var_242_0.localPosition
			end

			local var_242_2 = 0.001

			if var_242_1 <= arg_239_1.time_ and arg_239_1.time_ < var_242_1 + var_242_2 then
				local var_242_3 = (arg_239_1.time_ - var_242_1) / var_242_2
				local var_242_4 = Vector3.New(-0.7, -0.93, -6)

				var_242_0.localPosition = Vector3.Lerp(arg_239_1.var_.moveOldPos1034ui_story, var_242_4, var_242_3)

				local var_242_5 = manager.ui.mainCamera.transform.position - var_242_0.position

				var_242_0.forward = Vector3.New(var_242_5.x, var_242_5.y, var_242_5.z)

				local var_242_6 = var_242_0.localEulerAngles

				var_242_6.z = 0
				var_242_6.x = 0
				var_242_0.localEulerAngles = var_242_6
			end

			if arg_239_1.time_ >= var_242_1 + var_242_2 and arg_239_1.time_ < var_242_1 + var_242_2 + arg_242_0 then
				var_242_0.localPosition = Vector3.New(-0.7, -0.93, -6)

				local var_242_7 = manager.ui.mainCamera.transform.position - var_242_0.position

				var_242_0.forward = Vector3.New(var_242_7.x, var_242_7.y, var_242_7.z)

				local var_242_8 = var_242_0.localEulerAngles

				var_242_8.z = 0
				var_242_8.x = 0
				var_242_0.localEulerAngles = var_242_8
			end

			local var_242_9 = 0

			if var_242_9 < arg_239_1.time_ and arg_239_1.time_ <= var_242_9 + arg_242_0 then
				arg_239_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action2_1")
			end

			local var_242_10 = 0

			if var_242_10 < arg_239_1.time_ and arg_239_1.time_ <= var_242_10 + arg_242_0 then
				arg_239_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_zhayanR", "EmotionTimelineAnimator")
			end

			local var_242_11 = 0
			local var_242_12 = 0.225

			if var_242_11 < arg_239_1.time_ and arg_239_1.time_ <= var_242_11 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				local var_242_13 = arg_239_1:FormatText(StoryNameCfg[1109].name)

				arg_239_1.leftNameTxt_.text = var_242_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_14 = arg_239_1:GetWordFromCfg(939012058)
				local var_242_15 = arg_239_1:FormatText(var_242_14.content)

				arg_239_1.text_.text = var_242_15

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_16 = 9
				local var_242_17 = utf8.len(var_242_15)
				local var_242_18 = var_242_16 <= 0 and var_242_12 or var_242_12 * (var_242_17 / var_242_16)

				if var_242_18 > 0 and var_242_12 < var_242_18 then
					arg_239_1.talkMaxDuration = var_242_18

					if var_242_18 + var_242_11 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_18 + var_242_11
					end
				end

				arg_239_1.text_.text = var_242_15
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)
				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_19 = math.max(var_242_12, arg_239_1.talkMaxDuration)

			if var_242_11 <= arg_239_1.time_ and arg_239_1.time_ < var_242_11 + var_242_19 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_11) / var_242_19

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_11 + var_242_19 and arg_239_1.time_ < var_242_11 + var_242_19 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_239_1:InitPlayNodeList()
	end,
	Play939012059 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 939012059
		arg_243_1.duration_ = 5

		SetActive(arg_243_1.tipsGo_, false)

		function arg_243_1.onSingleLineFinish_()
			arg_243_1.onSingleLineUpdate_ = nil
			arg_243_1.onSingleLineFinish_ = nil
			arg_243_1.state_ = "waiting"
		end

		function arg_243_1.playNext_(arg_245_0)
			if arg_245_0 == 1 then
				arg_243_0:Play939012060(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			local var_246_0 = arg_243_1.actors_["1012ui_story"].transform
			local var_246_1 = 0

			if var_246_1 < arg_243_1.time_ and arg_243_1.time_ <= var_246_1 + arg_246_0 then
				arg_243_1.var_.moveOldPos1012ui_story = var_246_0.localPosition
			end

			local var_246_2 = 0.001

			if var_246_1 <= arg_243_1.time_ and arg_243_1.time_ < var_246_1 + var_246_2 then
				local var_246_3 = (arg_243_1.time_ - var_246_1) / var_246_2
				local var_246_4 = Vector3.New(0.7, -1.05, -6.24)

				var_246_0.localPosition = Vector3.Lerp(arg_243_1.var_.moveOldPos1012ui_story, var_246_4, var_246_3)

				local var_246_5 = manager.ui.mainCamera.transform.position - var_246_0.position

				var_246_0.forward = Vector3.New(var_246_5.x, var_246_5.y, var_246_5.z)

				local var_246_6 = var_246_0.localEulerAngles

				var_246_6.z = 0
				var_246_6.x = 0
				var_246_0.localEulerAngles = var_246_6
			end

			if arg_243_1.time_ >= var_246_1 + var_246_2 and arg_243_1.time_ < var_246_1 + var_246_2 + arg_246_0 then
				var_246_0.localPosition = Vector3.New(0.7, -1.05, -6.24)

				local var_246_7 = manager.ui.mainCamera.transform.position - var_246_0.position

				var_246_0.forward = Vector3.New(var_246_7.x, var_246_7.y, var_246_7.z)

				local var_246_8 = var_246_0.localEulerAngles

				var_246_8.z = 0
				var_246_8.x = 0
				var_246_0.localEulerAngles = var_246_8
			end

			local var_246_9 = arg_243_1.actors_["1012ui_story"]
			local var_246_10 = 0

			if var_246_10 < arg_243_1.time_ and arg_243_1.time_ <= var_246_10 + arg_246_0 and not isNil(var_246_9) and arg_243_1.var_.characterEffect1012ui_story == nil then
				arg_243_1.var_.characterEffect1012ui_story = var_246_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_246_11 = 0.200000002980232

			if var_246_10 <= arg_243_1.time_ and arg_243_1.time_ < var_246_10 + var_246_11 and not isNil(var_246_9) then
				local var_246_12 = (arg_243_1.time_ - var_246_10) / var_246_11

				if arg_243_1.var_.characterEffect1012ui_story and not isNil(var_246_9) then
					arg_243_1.var_.characterEffect1012ui_story.fillFlat = false
				end
			end

			if arg_243_1.time_ >= var_246_10 + var_246_11 and arg_243_1.time_ < var_246_10 + var_246_11 + arg_246_0 and not isNil(var_246_9) and arg_243_1.var_.characterEffect1012ui_story then
				arg_243_1.var_.characterEffect1012ui_story.fillFlat = false
			end

			local var_246_13 = arg_243_1.actors_["1034ui_story"]
			local var_246_14 = 0

			if var_246_14 < arg_243_1.time_ and arg_243_1.time_ <= var_246_14 + arg_246_0 and not isNil(var_246_13) and arg_243_1.var_.characterEffect1034ui_story == nil then
				arg_243_1.var_.characterEffect1034ui_story = var_246_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_246_15 = 0.200000002980232

			if var_246_14 <= arg_243_1.time_ and arg_243_1.time_ < var_246_14 + var_246_15 and not isNil(var_246_13) then
				local var_246_16 = (arg_243_1.time_ - var_246_14) / var_246_15

				if arg_243_1.var_.characterEffect1034ui_story and not isNil(var_246_13) then
					local var_246_17 = Mathf.Lerp(0, 0.5, var_246_16)

					arg_243_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_243_1.var_.characterEffect1034ui_story.fillRatio = var_246_17
				end
			end

			if arg_243_1.time_ >= var_246_14 + var_246_15 and arg_243_1.time_ < var_246_14 + var_246_15 + arg_246_0 and not isNil(var_246_13) and arg_243_1.var_.characterEffect1034ui_story then
				local var_246_18 = 0.5

				arg_243_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_243_1.var_.characterEffect1034ui_story.fillRatio = var_246_18
			end

			local var_246_19 = 0

			if var_246_19 < arg_243_1.time_ and arg_243_1.time_ <= var_246_19 + arg_246_0 then
				arg_243_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/story1012/story1012action/1012action1_1")
			end

			local var_246_20 = 0

			if var_246_20 < arg_243_1.time_ and arg_243_1.time_ <= var_246_20 + arg_246_0 then
				arg_243_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_246_21 = 0
			local var_246_22 = 0.35

			if var_246_21 < arg_243_1.time_ and arg_243_1.time_ <= var_246_21 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				local var_246_23 = arg_243_1:FormatText(StoryNameCfg[595].name)

				arg_243_1.leftNameTxt_.text = var_246_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_24 = arg_243_1:GetWordFromCfg(939012059)
				local var_246_25 = arg_243_1:FormatText(var_246_24.content)

				arg_243_1.text_.text = var_246_25

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_26 = 14
				local var_246_27 = utf8.len(var_246_25)
				local var_246_28 = var_246_26 <= 0 and var_246_22 or var_246_22 * (var_246_27 / var_246_26)

				if var_246_28 > 0 and var_246_22 < var_246_28 then
					arg_243_1.talkMaxDuration = var_246_28

					if var_246_28 + var_246_21 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_28 + var_246_21
					end
				end

				arg_243_1.text_.text = var_246_25
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)
				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_29 = math.max(var_246_22, arg_243_1.talkMaxDuration)

			if var_246_21 <= arg_243_1.time_ and arg_243_1.time_ < var_246_21 + var_246_29 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_21) / var_246_29

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_21 + var_246_29 and arg_243_1.time_ < var_246_21 + var_246_29 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_243_1:InitPlayNodeList()
	end,
	Play939012060 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 939012060
		arg_247_1.duration_ = 5

		SetActive(arg_247_1.tipsGo_, false)

		function arg_247_1.onSingleLineFinish_()
			arg_247_1.onSingleLineUpdate_ = nil
			arg_247_1.onSingleLineFinish_ = nil
			arg_247_1.state_ = "waiting"
		end

		function arg_247_1.playNext_(arg_249_0)
			if arg_249_0 == 1 then
				arg_247_0:Play939012061(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			local var_250_0 = arg_247_1.actors_["1034ui_story"].transform
			local var_250_1 = 0

			if var_250_1 < arg_247_1.time_ and arg_247_1.time_ <= var_250_1 + arg_250_0 then
				arg_247_1.var_.moveOldPos1034ui_story = var_250_0.localPosition
			end

			local var_250_2 = 0.001

			if var_250_1 <= arg_247_1.time_ and arg_247_1.time_ < var_250_1 + var_250_2 then
				local var_250_3 = (arg_247_1.time_ - var_250_1) / var_250_2
				local var_250_4 = Vector3.New(-0.7, -0.93, -6)

				var_250_0.localPosition = Vector3.Lerp(arg_247_1.var_.moveOldPos1034ui_story, var_250_4, var_250_3)

				local var_250_5 = manager.ui.mainCamera.transform.position - var_250_0.position

				var_250_0.forward = Vector3.New(var_250_5.x, var_250_5.y, var_250_5.z)

				local var_250_6 = var_250_0.localEulerAngles

				var_250_6.z = 0
				var_250_6.x = 0
				var_250_0.localEulerAngles = var_250_6
			end

			if arg_247_1.time_ >= var_250_1 + var_250_2 and arg_247_1.time_ < var_250_1 + var_250_2 + arg_250_0 then
				var_250_0.localPosition = Vector3.New(-0.7, -0.93, -6)

				local var_250_7 = manager.ui.mainCamera.transform.position - var_250_0.position

				var_250_0.forward = Vector3.New(var_250_7.x, var_250_7.y, var_250_7.z)

				local var_250_8 = var_250_0.localEulerAngles

				var_250_8.z = 0
				var_250_8.x = 0
				var_250_0.localEulerAngles = var_250_8
			end

			local var_250_9 = arg_247_1.actors_["1034ui_story"]
			local var_250_10 = 0

			if var_250_10 < arg_247_1.time_ and arg_247_1.time_ <= var_250_10 + arg_250_0 and not isNil(var_250_9) and arg_247_1.var_.characterEffect1034ui_story == nil then
				arg_247_1.var_.characterEffect1034ui_story = var_250_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_250_11 = 0.200000002980232

			if var_250_10 <= arg_247_1.time_ and arg_247_1.time_ < var_250_10 + var_250_11 and not isNil(var_250_9) then
				local var_250_12 = (arg_247_1.time_ - var_250_10) / var_250_11

				if arg_247_1.var_.characterEffect1034ui_story and not isNil(var_250_9) then
					arg_247_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_247_1.time_ >= var_250_10 + var_250_11 and arg_247_1.time_ < var_250_10 + var_250_11 + arg_250_0 and not isNil(var_250_9) and arg_247_1.var_.characterEffect1034ui_story then
				arg_247_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			local var_250_13 = arg_247_1.actors_["1012ui_story"]
			local var_250_14 = 0

			if var_250_14 < arg_247_1.time_ and arg_247_1.time_ <= var_250_14 + arg_250_0 and not isNil(var_250_13) and arg_247_1.var_.characterEffect1012ui_story == nil then
				arg_247_1.var_.characterEffect1012ui_story = var_250_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_250_15 = 0.200000002980232

			if var_250_14 <= arg_247_1.time_ and arg_247_1.time_ < var_250_14 + var_250_15 and not isNil(var_250_13) then
				local var_250_16 = (arg_247_1.time_ - var_250_14) / var_250_15

				if arg_247_1.var_.characterEffect1012ui_story and not isNil(var_250_13) then
					local var_250_17 = Mathf.Lerp(0, 0.5, var_250_16)

					arg_247_1.var_.characterEffect1012ui_story.fillFlat = true
					arg_247_1.var_.characterEffect1012ui_story.fillRatio = var_250_17
				end
			end

			if arg_247_1.time_ >= var_250_14 + var_250_15 and arg_247_1.time_ < var_250_14 + var_250_15 + arg_250_0 and not isNil(var_250_13) and arg_247_1.var_.characterEffect1012ui_story then
				local var_250_18 = 0.5

				arg_247_1.var_.characterEffect1012ui_story.fillFlat = true
				arg_247_1.var_.characterEffect1012ui_story.fillRatio = var_250_18
			end

			local var_250_19 = 0

			if var_250_19 < arg_247_1.time_ and arg_247_1.time_ <= var_250_19 + arg_250_0 then
				arg_247_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action2_2")
			end

			local var_250_20 = 0

			if var_250_20 < arg_247_1.time_ and arg_247_1.time_ <= var_250_20 + arg_250_0 then
				arg_247_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_250_21 = 0
			local var_250_22 = 1.525

			if var_250_21 < arg_247_1.time_ and arg_247_1.time_ <= var_250_21 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				local var_250_23 = arg_247_1:FormatText(StoryNameCfg[1109].name)

				arg_247_1.leftNameTxt_.text = var_250_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_24 = arg_247_1:GetWordFromCfg(939012060)
				local var_250_25 = arg_247_1:FormatText(var_250_24.content)

				arg_247_1.text_.text = var_250_25

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_26 = 61
				local var_250_27 = utf8.len(var_250_25)
				local var_250_28 = var_250_26 <= 0 and var_250_22 or var_250_22 * (var_250_27 / var_250_26)

				if var_250_28 > 0 and var_250_22 < var_250_28 then
					arg_247_1.talkMaxDuration = var_250_28

					if var_250_28 + var_250_21 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_28 + var_250_21
					end
				end

				arg_247_1.text_.text = var_250_25
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)
				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_29 = math.max(var_250_22, arg_247_1.talkMaxDuration)

			if var_250_21 <= arg_247_1.time_ and arg_247_1.time_ < var_250_21 + var_250_29 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_21) / var_250_29

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_21 + var_250_29 and arg_247_1.time_ < var_250_21 + var_250_29 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_247_1:InitPlayNodeList()
	end,
	Play939012061 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 939012061
		arg_251_1.duration_ = 5

		SetActive(arg_251_1.tipsGo_, false)

		function arg_251_1.onSingleLineFinish_()
			arg_251_1.onSingleLineUpdate_ = nil
			arg_251_1.onSingleLineFinish_ = nil
			arg_251_1.state_ = "waiting"
		end

		function arg_251_1.playNext_(arg_253_0)
			if arg_253_0 == 1 then
				arg_251_0:Play939012062(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			local var_254_0 = arg_251_1.actors_["1012ui_story"].transform
			local var_254_1 = 0

			if var_254_1 < arg_251_1.time_ and arg_251_1.time_ <= var_254_1 + arg_254_0 then
				arg_251_1.var_.moveOldPos1012ui_story = var_254_0.localPosition
			end

			local var_254_2 = 0.001

			if var_254_1 <= arg_251_1.time_ and arg_251_1.time_ < var_254_1 + var_254_2 then
				local var_254_3 = (arg_251_1.time_ - var_254_1) / var_254_2
				local var_254_4 = Vector3.New(0.7, -1.05, -6.24)

				var_254_0.localPosition = Vector3.Lerp(arg_251_1.var_.moveOldPos1012ui_story, var_254_4, var_254_3)

				local var_254_5 = manager.ui.mainCamera.transform.position - var_254_0.position

				var_254_0.forward = Vector3.New(var_254_5.x, var_254_5.y, var_254_5.z)

				local var_254_6 = var_254_0.localEulerAngles

				var_254_6.z = 0
				var_254_6.x = 0
				var_254_0.localEulerAngles = var_254_6
			end

			if arg_251_1.time_ >= var_254_1 + var_254_2 and arg_251_1.time_ < var_254_1 + var_254_2 + arg_254_0 then
				var_254_0.localPosition = Vector3.New(0.7, -1.05, -6.24)

				local var_254_7 = manager.ui.mainCamera.transform.position - var_254_0.position

				var_254_0.forward = Vector3.New(var_254_7.x, var_254_7.y, var_254_7.z)

				local var_254_8 = var_254_0.localEulerAngles

				var_254_8.z = 0
				var_254_8.x = 0
				var_254_0.localEulerAngles = var_254_8
			end

			local var_254_9 = arg_251_1.actors_["1012ui_story"]
			local var_254_10 = 0

			if var_254_10 < arg_251_1.time_ and arg_251_1.time_ <= var_254_10 + arg_254_0 and not isNil(var_254_9) and arg_251_1.var_.characterEffect1012ui_story == nil then
				arg_251_1.var_.characterEffect1012ui_story = var_254_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_254_11 = 0.200000002980232

			if var_254_10 <= arg_251_1.time_ and arg_251_1.time_ < var_254_10 + var_254_11 and not isNil(var_254_9) then
				local var_254_12 = (arg_251_1.time_ - var_254_10) / var_254_11

				if arg_251_1.var_.characterEffect1012ui_story and not isNil(var_254_9) then
					arg_251_1.var_.characterEffect1012ui_story.fillFlat = false
				end
			end

			if arg_251_1.time_ >= var_254_10 + var_254_11 and arg_251_1.time_ < var_254_10 + var_254_11 + arg_254_0 and not isNil(var_254_9) and arg_251_1.var_.characterEffect1012ui_story then
				arg_251_1.var_.characterEffect1012ui_story.fillFlat = false
			end

			local var_254_13 = arg_251_1.actors_["1034ui_story"]
			local var_254_14 = 0

			if var_254_14 < arg_251_1.time_ and arg_251_1.time_ <= var_254_14 + arg_254_0 and not isNil(var_254_13) and arg_251_1.var_.characterEffect1034ui_story == nil then
				arg_251_1.var_.characterEffect1034ui_story = var_254_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_254_15 = 0.200000002980232

			if var_254_14 <= arg_251_1.time_ and arg_251_1.time_ < var_254_14 + var_254_15 and not isNil(var_254_13) then
				local var_254_16 = (arg_251_1.time_ - var_254_14) / var_254_15

				if arg_251_1.var_.characterEffect1034ui_story and not isNil(var_254_13) then
					local var_254_17 = Mathf.Lerp(0, 0.5, var_254_16)

					arg_251_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_251_1.var_.characterEffect1034ui_story.fillRatio = var_254_17
				end
			end

			if arg_251_1.time_ >= var_254_14 + var_254_15 and arg_251_1.time_ < var_254_14 + var_254_15 + arg_254_0 and not isNil(var_254_13) and arg_251_1.var_.characterEffect1034ui_story then
				local var_254_18 = 0.5

				arg_251_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_251_1.var_.characterEffect1034ui_story.fillRatio = var_254_18
			end

			local var_254_19 = 0

			if var_254_19 < arg_251_1.time_ and arg_251_1.time_ <= var_254_19 + arg_254_0 then
				arg_251_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/story1012/story1012action/1012action2_1")
			end

			local var_254_20 = 0

			if var_254_20 < arg_251_1.time_ and arg_251_1.time_ <= var_254_20 + arg_254_0 then
				arg_251_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_254_21 = 0
			local var_254_22 = 0.2

			if var_254_21 < arg_251_1.time_ and arg_251_1.time_ <= var_254_21 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				local var_254_23 = arg_251_1:FormatText(StoryNameCfg[595].name)

				arg_251_1.leftNameTxt_.text = var_254_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, false)
				arg_251_1.callingController_:SetSelectedState("normal")

				local var_254_24 = arg_251_1:GetWordFromCfg(939012061)
				local var_254_25 = arg_251_1:FormatText(var_254_24.content)

				arg_251_1.text_.text = var_254_25

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_26 = 8
				local var_254_27 = utf8.len(var_254_25)
				local var_254_28 = var_254_26 <= 0 and var_254_22 or var_254_22 * (var_254_27 / var_254_26)

				if var_254_28 > 0 and var_254_22 < var_254_28 then
					arg_251_1.talkMaxDuration = var_254_28

					if var_254_28 + var_254_21 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_28 + var_254_21
					end
				end

				arg_251_1.text_.text = var_254_25
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)
				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_29 = math.max(var_254_22, arg_251_1.talkMaxDuration)

			if var_254_21 <= arg_251_1.time_ and arg_251_1.time_ < var_254_21 + var_254_29 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_21) / var_254_29

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_21 + var_254_29 and arg_251_1.time_ < var_254_21 + var_254_29 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_251_1:InitPlayNodeList()
	end,
	Play939012062 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 939012062
		arg_255_1.duration_ = 5

		SetActive(arg_255_1.tipsGo_, false)

		function arg_255_1.onSingleLineFinish_()
			arg_255_1.onSingleLineUpdate_ = nil
			arg_255_1.onSingleLineFinish_ = nil
			arg_255_1.state_ = "waiting"
		end

		function arg_255_1.playNext_(arg_257_0)
			if arg_257_0 == 1 then
				arg_255_0:Play939012063(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			local var_258_0 = arg_255_1.actors_["1034ui_story"].transform
			local var_258_1 = 0

			if var_258_1 < arg_255_1.time_ and arg_255_1.time_ <= var_258_1 + arg_258_0 then
				arg_255_1.var_.moveOldPos1034ui_story = var_258_0.localPosition
			end

			local var_258_2 = 0.001

			if var_258_1 <= arg_255_1.time_ and arg_255_1.time_ < var_258_1 + var_258_2 then
				local var_258_3 = (arg_255_1.time_ - var_258_1) / var_258_2
				local var_258_4 = Vector3.New(-0.7, -0.93, -6)

				var_258_0.localPosition = Vector3.Lerp(arg_255_1.var_.moveOldPos1034ui_story, var_258_4, var_258_3)

				local var_258_5 = manager.ui.mainCamera.transform.position - var_258_0.position

				var_258_0.forward = Vector3.New(var_258_5.x, var_258_5.y, var_258_5.z)

				local var_258_6 = var_258_0.localEulerAngles

				var_258_6.z = 0
				var_258_6.x = 0
				var_258_0.localEulerAngles = var_258_6
			end

			if arg_255_1.time_ >= var_258_1 + var_258_2 and arg_255_1.time_ < var_258_1 + var_258_2 + arg_258_0 then
				var_258_0.localPosition = Vector3.New(-0.7, -0.93, -6)

				local var_258_7 = manager.ui.mainCamera.transform.position - var_258_0.position

				var_258_0.forward = Vector3.New(var_258_7.x, var_258_7.y, var_258_7.z)

				local var_258_8 = var_258_0.localEulerAngles

				var_258_8.z = 0
				var_258_8.x = 0
				var_258_0.localEulerAngles = var_258_8
			end

			local var_258_9 = arg_255_1.actors_["1034ui_story"]
			local var_258_10 = 0

			if var_258_10 < arg_255_1.time_ and arg_255_1.time_ <= var_258_10 + arg_258_0 and not isNil(var_258_9) and arg_255_1.var_.characterEffect1034ui_story == nil then
				arg_255_1.var_.characterEffect1034ui_story = var_258_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_258_11 = 0.200000002980232

			if var_258_10 <= arg_255_1.time_ and arg_255_1.time_ < var_258_10 + var_258_11 and not isNil(var_258_9) then
				local var_258_12 = (arg_255_1.time_ - var_258_10) / var_258_11

				if arg_255_1.var_.characterEffect1034ui_story and not isNil(var_258_9) then
					arg_255_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_255_1.time_ >= var_258_10 + var_258_11 and arg_255_1.time_ < var_258_10 + var_258_11 + arg_258_0 and not isNil(var_258_9) and arg_255_1.var_.characterEffect1034ui_story then
				arg_255_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			local var_258_13 = arg_255_1.actors_["1012ui_story"]
			local var_258_14 = 0

			if var_258_14 < arg_255_1.time_ and arg_255_1.time_ <= var_258_14 + arg_258_0 and not isNil(var_258_13) and arg_255_1.var_.characterEffect1012ui_story == nil then
				arg_255_1.var_.characterEffect1012ui_story = var_258_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_258_15 = 0.200000002980232

			if var_258_14 <= arg_255_1.time_ and arg_255_1.time_ < var_258_14 + var_258_15 and not isNil(var_258_13) then
				local var_258_16 = (arg_255_1.time_ - var_258_14) / var_258_15

				if arg_255_1.var_.characterEffect1012ui_story and not isNil(var_258_13) then
					local var_258_17 = Mathf.Lerp(0, 0.5, var_258_16)

					arg_255_1.var_.characterEffect1012ui_story.fillFlat = true
					arg_255_1.var_.characterEffect1012ui_story.fillRatio = var_258_17
				end
			end

			if arg_255_1.time_ >= var_258_14 + var_258_15 and arg_255_1.time_ < var_258_14 + var_258_15 + arg_258_0 and not isNil(var_258_13) and arg_255_1.var_.characterEffect1012ui_story then
				local var_258_18 = 0.5

				arg_255_1.var_.characterEffect1012ui_story.fillFlat = true
				arg_255_1.var_.characterEffect1012ui_story.fillRatio = var_258_18
			end

			local var_258_19 = 0

			if var_258_19 < arg_255_1.time_ and arg_255_1.time_ <= var_258_19 + arg_258_0 then
				arg_255_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action5_1")
			end

			local var_258_20 = 0

			if var_258_20 < arg_255_1.time_ and arg_255_1.time_ <= var_258_20 + arg_258_0 then
				arg_255_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_258_21 = 0
			local var_258_22 = 0.975

			if var_258_21 < arg_255_1.time_ and arg_255_1.time_ <= var_258_21 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, true)

				local var_258_23 = arg_255_1:FormatText(StoryNameCfg[1109].name)

				arg_255_1.leftNameTxt_.text = var_258_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_255_1.leftNameTxt_.transform)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1.leftNameTxt_.text)
				SetActive(arg_255_1.iconTrs_.gameObject, false)
				arg_255_1.callingController_:SetSelectedState("normal")

				local var_258_24 = arg_255_1:GetWordFromCfg(939012062)
				local var_258_25 = arg_255_1:FormatText(var_258_24.content)

				arg_255_1.text_.text = var_258_25

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_26 = 39
				local var_258_27 = utf8.len(var_258_25)
				local var_258_28 = var_258_26 <= 0 and var_258_22 or var_258_22 * (var_258_27 / var_258_26)

				if var_258_28 > 0 and var_258_22 < var_258_28 then
					arg_255_1.talkMaxDuration = var_258_28

					if var_258_28 + var_258_21 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_28 + var_258_21
					end
				end

				arg_255_1.text_.text = var_258_25
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)
				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_29 = math.max(var_258_22, arg_255_1.talkMaxDuration)

			if var_258_21 <= arg_255_1.time_ and arg_255_1.time_ < var_258_21 + var_258_29 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - var_258_21) / var_258_29

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= var_258_21 + var_258_29 and arg_255_1.time_ < var_258_21 + var_258_29 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_255_1:InitPlayNodeList()
	end,
	Play939012063 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 939012063
		arg_259_1.duration_ = 5

		SetActive(arg_259_1.tipsGo_, false)

		function arg_259_1.onSingleLineFinish_()
			arg_259_1.onSingleLineUpdate_ = nil
			arg_259_1.onSingleLineFinish_ = nil
			arg_259_1.state_ = "waiting"
		end

		function arg_259_1.playNext_(arg_261_0)
			if arg_261_0 == 1 then
				arg_259_0:Play939012064(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			local var_262_0 = arg_259_1.actors_["6148ui_story"].transform
			local var_262_1 = 0

			if var_262_1 < arg_259_1.time_ and arg_259_1.time_ <= var_262_1 + arg_262_0 then
				arg_259_1.var_.moveOldPos6148ui_story = var_262_0.localPosition

				local var_262_2 = GameObjectTools.GetOrAddComponent(var_262_0.gameObject, typeof(DynamicBoneHelper))

				if var_262_2 then
					var_262_2:EnableDynamicBone(false)
				end
			end

			local var_262_3 = 0.001

			if var_262_1 <= arg_259_1.time_ and arg_259_1.time_ < var_262_1 + var_262_3 then
				local var_262_4 = (arg_259_1.time_ - var_262_1) / var_262_3
				local var_262_5 = Vector3.New(0.7, -0.985, -6)

				var_262_0.localPosition = Vector3.Lerp(arg_259_1.var_.moveOldPos6148ui_story, var_262_5, var_262_4)

				local var_262_6 = manager.ui.mainCamera.transform.position - var_262_0.position

				var_262_0.forward = Vector3.New(var_262_6.x, var_262_6.y, var_262_6.z)

				local var_262_7 = var_262_0.localEulerAngles

				var_262_7.z = 0
				var_262_7.x = 0
				var_262_0.localEulerAngles = var_262_7
			end

			if arg_259_1.time_ >= var_262_1 + var_262_3 and arg_259_1.time_ < var_262_1 + var_262_3 + arg_262_0 then
				var_262_0.localPosition = Vector3.New(0.7, -0.985, -6)

				local var_262_8 = manager.ui.mainCamera.transform.position - var_262_0.position

				var_262_0.forward = Vector3.New(var_262_8.x, var_262_8.y, var_262_8.z)

				local var_262_9 = var_262_0.localEulerAngles

				var_262_9.z = 0
				var_262_9.x = 0
				var_262_0.localEulerAngles = var_262_9

				local var_262_10 = GameObjectTools.GetOrAddComponent(var_262_0.gameObject, typeof(DynamicBoneHelper))

				if var_262_10 then
					var_262_10:EnableDynamicBone(true)
				end
			end

			local var_262_11 = arg_259_1.actors_["1012ui_story"].transform
			local var_262_12 = 0

			if var_262_12 < arg_259_1.time_ and arg_259_1.time_ <= var_262_12 + arg_262_0 then
				arg_259_1.var_.moveOldPos1012ui_story = var_262_11.localPosition
			end

			local var_262_13 = 0.001

			if var_262_12 <= arg_259_1.time_ and arg_259_1.time_ < var_262_12 + var_262_13 then
				local var_262_14 = (arg_259_1.time_ - var_262_12) / var_262_13
				local var_262_15 = Vector3.New(0, 100, 0)

				var_262_11.localPosition = Vector3.Lerp(arg_259_1.var_.moveOldPos1012ui_story, var_262_15, var_262_14)

				local var_262_16 = manager.ui.mainCamera.transform.position - var_262_11.position

				var_262_11.forward = Vector3.New(var_262_16.x, var_262_16.y, var_262_16.z)

				local var_262_17 = var_262_11.localEulerAngles

				var_262_17.z = 0
				var_262_17.x = 0
				var_262_11.localEulerAngles = var_262_17
			end

			if arg_259_1.time_ >= var_262_12 + var_262_13 and arg_259_1.time_ < var_262_12 + var_262_13 + arg_262_0 then
				var_262_11.localPosition = Vector3.New(0, 100, 0)

				local var_262_18 = manager.ui.mainCamera.transform.position - var_262_11.position

				var_262_11.forward = Vector3.New(var_262_18.x, var_262_18.y, var_262_18.z)

				local var_262_19 = var_262_11.localEulerAngles

				var_262_19.z = 0
				var_262_19.x = 0
				var_262_11.localEulerAngles = var_262_19
			end

			local var_262_20 = arg_259_1.actors_["6148ui_story"]
			local var_262_21 = 0

			if var_262_21 < arg_259_1.time_ and arg_259_1.time_ <= var_262_21 + arg_262_0 and not isNil(var_262_20) and arg_259_1.var_.characterEffect6148ui_story == nil then
				arg_259_1.var_.characterEffect6148ui_story = var_262_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_262_22 = 0.200000002980232

			if var_262_21 <= arg_259_1.time_ and arg_259_1.time_ < var_262_21 + var_262_22 and not isNil(var_262_20) then
				local var_262_23 = (arg_259_1.time_ - var_262_21) / var_262_22

				if arg_259_1.var_.characterEffect6148ui_story and not isNil(var_262_20) then
					arg_259_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_259_1.time_ >= var_262_21 + var_262_22 and arg_259_1.time_ < var_262_21 + var_262_22 + arg_262_0 and not isNil(var_262_20) and arg_259_1.var_.characterEffect6148ui_story then
				arg_259_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_262_24 = arg_259_1.actors_["1034ui_story"]
			local var_262_25 = 0

			if var_262_25 < arg_259_1.time_ and arg_259_1.time_ <= var_262_25 + arg_262_0 and not isNil(var_262_24) and arg_259_1.var_.characterEffect1034ui_story == nil then
				arg_259_1.var_.characterEffect1034ui_story = var_262_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_262_26 = 0.200000002980232

			if var_262_25 <= arg_259_1.time_ and arg_259_1.time_ < var_262_25 + var_262_26 and not isNil(var_262_24) then
				local var_262_27 = (arg_259_1.time_ - var_262_25) / var_262_26

				if arg_259_1.var_.characterEffect1034ui_story and not isNil(var_262_24) then
					local var_262_28 = Mathf.Lerp(0, 0.5, var_262_27)

					arg_259_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_259_1.var_.characterEffect1034ui_story.fillRatio = var_262_28
				end
			end

			if arg_259_1.time_ >= var_262_25 + var_262_26 and arg_259_1.time_ < var_262_25 + var_262_26 + arg_262_0 and not isNil(var_262_24) and arg_259_1.var_.characterEffect1034ui_story then
				local var_262_29 = 0.5

				arg_259_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_259_1.var_.characterEffect1034ui_story.fillRatio = var_262_29
			end

			local var_262_30 = 0

			if var_262_30 < arg_259_1.time_ and arg_259_1.time_ <= var_262_30 + arg_262_0 then
				arg_259_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action1_1")
			end

			local var_262_31 = 0

			if var_262_31 < arg_259_1.time_ and arg_259_1.time_ <= var_262_31 + arg_262_0 then
				arg_259_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_262_32 = 0
			local var_262_33 = 0.125

			if var_262_32 < arg_259_1.time_ and arg_259_1.time_ <= var_262_32 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, true)

				local var_262_34 = arg_259_1:FormatText(StoryNameCfg[1488].name)

				arg_259_1.leftNameTxt_.text = var_262_34

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_259_1.leftNameTxt_.transform)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1.leftNameTxt_.text)
				SetActive(arg_259_1.iconTrs_.gameObject, false)
				arg_259_1.callingController_:SetSelectedState("normal")

				local var_262_35 = arg_259_1:GetWordFromCfg(939012063)
				local var_262_36 = arg_259_1:FormatText(var_262_35.content)

				arg_259_1.text_.text = var_262_36

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_37 = 5
				local var_262_38 = utf8.len(var_262_36)
				local var_262_39 = var_262_37 <= 0 and var_262_33 or var_262_33 * (var_262_38 / var_262_37)

				if var_262_39 > 0 and var_262_33 < var_262_39 then
					arg_259_1.talkMaxDuration = var_262_39

					if var_262_39 + var_262_32 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_39 + var_262_32
					end
				end

				arg_259_1.text_.text = var_262_36
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)
				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_40 = math.max(var_262_33, arg_259_1.talkMaxDuration)

			if var_262_32 <= arg_259_1.time_ and arg_259_1.time_ < var_262_32 + var_262_40 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - var_262_32) / var_262_40

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= var_262_32 + var_262_40 and arg_259_1.time_ < var_262_32 + var_262_40 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1012ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_259_1:InitPlayNodeList()
	end,
	Play939012064 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 939012064
		arg_263_1.duration_ = 5

		SetActive(arg_263_1.tipsGo_, false)

		function arg_263_1.onSingleLineFinish_()
			arg_263_1.onSingleLineUpdate_ = nil
			arg_263_1.onSingleLineFinish_ = nil
			arg_263_1.state_ = "waiting"
		end

		function arg_263_1.playNext_(arg_265_0)
			if arg_265_0 == 1 then
				arg_263_0:Play939012065(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			local var_266_0 = arg_263_1.actors_["1034ui_story"].transform
			local var_266_1 = 0

			if var_266_1 < arg_263_1.time_ and arg_263_1.time_ <= var_266_1 + arg_266_0 then
				arg_263_1.var_.moveOldPos1034ui_story = var_266_0.localPosition
			end

			local var_266_2 = 0.001

			if var_266_1 <= arg_263_1.time_ and arg_263_1.time_ < var_266_1 + var_266_2 then
				local var_266_3 = (arg_263_1.time_ - var_266_1) / var_266_2
				local var_266_4 = Vector3.New(-0.7, -0.93, -6)

				var_266_0.localPosition = Vector3.Lerp(arg_263_1.var_.moveOldPos1034ui_story, var_266_4, var_266_3)

				local var_266_5 = manager.ui.mainCamera.transform.position - var_266_0.position

				var_266_0.forward = Vector3.New(var_266_5.x, var_266_5.y, var_266_5.z)

				local var_266_6 = var_266_0.localEulerAngles

				var_266_6.z = 0
				var_266_6.x = 0
				var_266_0.localEulerAngles = var_266_6
			end

			if arg_263_1.time_ >= var_266_1 + var_266_2 and arg_263_1.time_ < var_266_1 + var_266_2 + arg_266_0 then
				var_266_0.localPosition = Vector3.New(-0.7, -0.93, -6)

				local var_266_7 = manager.ui.mainCamera.transform.position - var_266_0.position

				var_266_0.forward = Vector3.New(var_266_7.x, var_266_7.y, var_266_7.z)

				local var_266_8 = var_266_0.localEulerAngles

				var_266_8.z = 0
				var_266_8.x = 0
				var_266_0.localEulerAngles = var_266_8
			end

			local var_266_9 = arg_263_1.actors_["1034ui_story"]
			local var_266_10 = 0

			if var_266_10 < arg_263_1.time_ and arg_263_1.time_ <= var_266_10 + arg_266_0 and not isNil(var_266_9) and arg_263_1.var_.characterEffect1034ui_story == nil then
				arg_263_1.var_.characterEffect1034ui_story = var_266_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_266_11 = 0.200000002980232

			if var_266_10 <= arg_263_1.time_ and arg_263_1.time_ < var_266_10 + var_266_11 and not isNil(var_266_9) then
				local var_266_12 = (arg_263_1.time_ - var_266_10) / var_266_11

				if arg_263_1.var_.characterEffect1034ui_story and not isNil(var_266_9) then
					arg_263_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_263_1.time_ >= var_266_10 + var_266_11 and arg_263_1.time_ < var_266_10 + var_266_11 + arg_266_0 and not isNil(var_266_9) and arg_263_1.var_.characterEffect1034ui_story then
				arg_263_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			local var_266_13 = arg_263_1.actors_["6148ui_story"]
			local var_266_14 = 0

			if var_266_14 < arg_263_1.time_ and arg_263_1.time_ <= var_266_14 + arg_266_0 and not isNil(var_266_13) and arg_263_1.var_.characterEffect6148ui_story == nil then
				arg_263_1.var_.characterEffect6148ui_story = var_266_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_266_15 = 0.200000002980232

			if var_266_14 <= arg_263_1.time_ and arg_263_1.time_ < var_266_14 + var_266_15 and not isNil(var_266_13) then
				local var_266_16 = (arg_263_1.time_ - var_266_14) / var_266_15

				if arg_263_1.var_.characterEffect6148ui_story and not isNil(var_266_13) then
					local var_266_17 = Mathf.Lerp(0, 0.5, var_266_16)

					arg_263_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_263_1.var_.characterEffect6148ui_story.fillRatio = var_266_17
				end
			end

			if arg_263_1.time_ >= var_266_14 + var_266_15 and arg_263_1.time_ < var_266_14 + var_266_15 + arg_266_0 and not isNil(var_266_13) and arg_263_1.var_.characterEffect6148ui_story then
				local var_266_18 = 0.5

				arg_263_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_263_1.var_.characterEffect6148ui_story.fillRatio = var_266_18
			end

			local var_266_19 = 0

			if var_266_19 < arg_263_1.time_ and arg_263_1.time_ <= var_266_19 + arg_266_0 then
				arg_263_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action5_2")
			end

			local var_266_20 = 0

			if var_266_20 < arg_263_1.time_ and arg_263_1.time_ <= var_266_20 + arg_266_0 then
				arg_263_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_266_21 = 0
			local var_266_22 = 0.425

			if var_266_21 < arg_263_1.time_ and arg_263_1.time_ <= var_266_21 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, true)

				local var_266_23 = arg_263_1:FormatText(StoryNameCfg[1109].name)

				arg_263_1.leftNameTxt_.text = var_266_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_263_1.leftNameTxt_.transform)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1.leftNameTxt_.text)
				SetActive(arg_263_1.iconTrs_.gameObject, false)
				arg_263_1.callingController_:SetSelectedState("normal")

				local var_266_24 = arg_263_1:GetWordFromCfg(939012064)
				local var_266_25 = arg_263_1:FormatText(var_266_24.content)

				arg_263_1.text_.text = var_266_25

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_26 = 17
				local var_266_27 = utf8.len(var_266_25)
				local var_266_28 = var_266_26 <= 0 and var_266_22 or var_266_22 * (var_266_27 / var_266_26)

				if var_266_28 > 0 and var_266_22 < var_266_28 then
					arg_263_1.talkMaxDuration = var_266_28

					if var_266_28 + var_266_21 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_28 + var_266_21
					end
				end

				arg_263_1.text_.text = var_266_25
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)
				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_29 = math.max(var_266_22, arg_263_1.talkMaxDuration)

			if var_266_21 <= arg_263_1.time_ and arg_263_1.time_ < var_266_21 + var_266_29 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - var_266_21) / var_266_29

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= var_266_21 + var_266_29 and arg_263_1.time_ < var_266_21 + var_266_29 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_263_1:InitPlayNodeList()
	end,
	Play939012065 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 939012065
		arg_267_1.duration_ = 5

		SetActive(arg_267_1.tipsGo_, false)

		function arg_267_1.onSingleLineFinish_()
			arg_267_1.onSingleLineUpdate_ = nil
			arg_267_1.onSingleLineFinish_ = nil
			arg_267_1.state_ = "waiting"
		end

		function arg_267_1.playNext_(arg_269_0)
			if arg_269_0 == 1 then
				arg_267_0:Play939012066(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			local var_270_0 = arg_267_1.actors_["1034ui_story"]
			local var_270_1 = 0

			if var_270_1 < arg_267_1.time_ and arg_267_1.time_ <= var_270_1 + arg_270_0 and not isNil(var_270_0) and arg_267_1.var_.characterEffect1034ui_story == nil then
				arg_267_1.var_.characterEffect1034ui_story = var_270_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_270_2 = 0.200000002980232

			if var_270_1 <= arg_267_1.time_ and arg_267_1.time_ < var_270_1 + var_270_2 and not isNil(var_270_0) then
				local var_270_3 = (arg_267_1.time_ - var_270_1) / var_270_2

				if arg_267_1.var_.characterEffect1034ui_story and not isNil(var_270_0) then
					local var_270_4 = Mathf.Lerp(0, 0.5, var_270_3)

					arg_267_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_267_1.var_.characterEffect1034ui_story.fillRatio = var_270_4
				end
			end

			if arg_267_1.time_ >= var_270_1 + var_270_2 and arg_267_1.time_ < var_270_1 + var_270_2 + arg_270_0 and not isNil(var_270_0) and arg_267_1.var_.characterEffect1034ui_story then
				local var_270_5 = 0.5

				arg_267_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_267_1.var_.characterEffect1034ui_story.fillRatio = var_270_5
			end

			local var_270_6 = 0
			local var_270_7 = 0.575

			if var_270_6 < arg_267_1.time_ and arg_267_1.time_ <= var_270_6 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, false)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_267_1.iconTrs_.gameObject, false)
				arg_267_1.callingController_:SetSelectedState("normal")

				local var_270_8 = arg_267_1:GetWordFromCfg(939012065)
				local var_270_9 = arg_267_1:FormatText(var_270_8.content)

				arg_267_1.text_.text = var_270_9

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_10 = 23
				local var_270_11 = utf8.len(var_270_9)
				local var_270_12 = var_270_10 <= 0 and var_270_7 or var_270_7 * (var_270_11 / var_270_10)

				if var_270_12 > 0 and var_270_7 < var_270_12 then
					arg_267_1.talkMaxDuration = var_270_12

					if var_270_12 + var_270_6 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_12 + var_270_6
					end
				end

				arg_267_1.text_.text = var_270_9
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)
				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_13 = math.max(var_270_7, arg_267_1.talkMaxDuration)

			if var_270_6 <= arg_267_1.time_ and arg_267_1.time_ < var_270_6 + var_270_13 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - var_270_6) / var_270_13

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= var_270_6 + var_270_13 and arg_267_1.time_ < var_270_6 + var_270_13 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {}

		arg_267_1:InitPlayNodeList()
	end,
	Play939012066 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 939012066
		arg_271_1.duration_ = 5

		SetActive(arg_271_1.tipsGo_, false)

		function arg_271_1.onSingleLineFinish_()
			arg_271_1.onSingleLineUpdate_ = nil
			arg_271_1.onSingleLineFinish_ = nil
			arg_271_1.state_ = "waiting"
		end

		function arg_271_1.playNext_(arg_273_0)
			if arg_273_0 == 1 then
				arg_271_0:Play939012067(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			local var_274_0 = arg_271_1.actors_["6148ui_story"].transform
			local var_274_1 = 0

			if var_274_1 < arg_271_1.time_ and arg_271_1.time_ <= var_274_1 + arg_274_0 then
				arg_271_1.var_.moveOldPos6148ui_story = var_274_0.localPosition

				local var_274_2 = GameObjectTools.GetOrAddComponent(var_274_0.gameObject, typeof(DynamicBoneHelper))

				if var_274_2 then
					var_274_2:EnableDynamicBone(false)
				end
			end

			local var_274_3 = 0.001

			if var_274_1 <= arg_271_1.time_ and arg_271_1.time_ < var_274_1 + var_274_3 then
				local var_274_4 = (arg_271_1.time_ - var_274_1) / var_274_3
				local var_274_5 = Vector3.New(0.7, -0.985, -6)

				var_274_0.localPosition = Vector3.Lerp(arg_271_1.var_.moveOldPos6148ui_story, var_274_5, var_274_4)

				local var_274_6 = manager.ui.mainCamera.transform.position - var_274_0.position

				var_274_0.forward = Vector3.New(var_274_6.x, var_274_6.y, var_274_6.z)

				local var_274_7 = var_274_0.localEulerAngles

				var_274_7.z = 0
				var_274_7.x = 0
				var_274_0.localEulerAngles = var_274_7
			end

			if arg_271_1.time_ >= var_274_1 + var_274_3 and arg_271_1.time_ < var_274_1 + var_274_3 + arg_274_0 then
				var_274_0.localPosition = Vector3.New(0.7, -0.985, -6)

				local var_274_8 = manager.ui.mainCamera.transform.position - var_274_0.position

				var_274_0.forward = Vector3.New(var_274_8.x, var_274_8.y, var_274_8.z)

				local var_274_9 = var_274_0.localEulerAngles

				var_274_9.z = 0
				var_274_9.x = 0
				var_274_0.localEulerAngles = var_274_9

				local var_274_10 = GameObjectTools.GetOrAddComponent(var_274_0.gameObject, typeof(DynamicBoneHelper))

				if var_274_10 then
					var_274_10:EnableDynamicBone(true)
				end
			end

			local var_274_11 = arg_271_1.actors_["6148ui_story"]
			local var_274_12 = 0

			if var_274_12 < arg_271_1.time_ and arg_271_1.time_ <= var_274_12 + arg_274_0 and not isNil(var_274_11) and arg_271_1.var_.characterEffect6148ui_story == nil then
				arg_271_1.var_.characterEffect6148ui_story = var_274_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_274_13 = 0.200000002980232

			if var_274_12 <= arg_271_1.time_ and arg_271_1.time_ < var_274_12 + var_274_13 and not isNil(var_274_11) then
				local var_274_14 = (arg_271_1.time_ - var_274_12) / var_274_13

				if arg_271_1.var_.characterEffect6148ui_story and not isNil(var_274_11) then
					arg_271_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_271_1.time_ >= var_274_12 + var_274_13 and arg_271_1.time_ < var_274_12 + var_274_13 + arg_274_0 and not isNil(var_274_11) and arg_271_1.var_.characterEffect6148ui_story then
				arg_271_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_274_15 = 0

			if var_274_15 < arg_271_1.time_ and arg_271_1.time_ <= var_274_15 + arg_274_0 then
				arg_271_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action2_1")
			end

			local var_274_16 = 0

			if var_274_16 < arg_271_1.time_ and arg_271_1.time_ <= var_274_16 + arg_274_0 then
				arg_271_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_274_17 = 0
			local var_274_18 = 1.075

			if var_274_17 < arg_271_1.time_ and arg_271_1.time_ <= var_274_17 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, true)

				local var_274_19 = arg_271_1:FormatText(StoryNameCfg[1488].name)

				arg_271_1.leftNameTxt_.text = var_274_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_271_1.leftNameTxt_.transform)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1.leftNameTxt_.text)
				SetActive(arg_271_1.iconTrs_.gameObject, false)
				arg_271_1.callingController_:SetSelectedState("normal")

				local var_274_20 = arg_271_1:GetWordFromCfg(939012066)
				local var_274_21 = arg_271_1:FormatText(var_274_20.content)

				arg_271_1.text_.text = var_274_21

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_22 = 43
				local var_274_23 = utf8.len(var_274_21)
				local var_274_24 = var_274_22 <= 0 and var_274_18 or var_274_18 * (var_274_23 / var_274_22)

				if var_274_24 > 0 and var_274_18 < var_274_24 then
					arg_271_1.talkMaxDuration = var_274_24

					if var_274_24 + var_274_17 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_24 + var_274_17
					end
				end

				arg_271_1.text_.text = var_274_21
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)
				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_25 = math.max(var_274_18, arg_271_1.talkMaxDuration)

			if var_274_17 <= arg_271_1.time_ and arg_271_1.time_ < var_274_17 + var_274_25 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - var_274_17) / var_274_25

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= var_274_17 + var_274_25 and arg_271_1.time_ < var_274_17 + var_274_25 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_271_1:InitPlayNodeList()
	end,
	Play939012067 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 939012067
		arg_275_1.duration_ = 5

		SetActive(arg_275_1.tipsGo_, false)

		function arg_275_1.onSingleLineFinish_()
			arg_275_1.onSingleLineUpdate_ = nil
			arg_275_1.onSingleLineFinish_ = nil
			arg_275_1.state_ = "waiting"
		end

		function arg_275_1.playNext_(arg_277_0)
			if arg_277_0 == 1 then
				arg_275_0:Play939012068(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			local var_278_0 = arg_275_1.actors_["1034ui_story"].transform
			local var_278_1 = 0

			if var_278_1 < arg_275_1.time_ and arg_275_1.time_ <= var_278_1 + arg_278_0 then
				arg_275_1.var_.moveOldPos1034ui_story = var_278_0.localPosition
			end

			local var_278_2 = 0.001

			if var_278_1 <= arg_275_1.time_ and arg_275_1.time_ < var_278_1 + var_278_2 then
				local var_278_3 = (arg_275_1.time_ - var_278_1) / var_278_2
				local var_278_4 = Vector3.New(-0.7, -0.93, -6)

				var_278_0.localPosition = Vector3.Lerp(arg_275_1.var_.moveOldPos1034ui_story, var_278_4, var_278_3)

				local var_278_5 = manager.ui.mainCamera.transform.position - var_278_0.position

				var_278_0.forward = Vector3.New(var_278_5.x, var_278_5.y, var_278_5.z)

				local var_278_6 = var_278_0.localEulerAngles

				var_278_6.z = 0
				var_278_6.x = 0
				var_278_0.localEulerAngles = var_278_6
			end

			if arg_275_1.time_ >= var_278_1 + var_278_2 and arg_275_1.time_ < var_278_1 + var_278_2 + arg_278_0 then
				var_278_0.localPosition = Vector3.New(-0.7, -0.93, -6)

				local var_278_7 = manager.ui.mainCamera.transform.position - var_278_0.position

				var_278_0.forward = Vector3.New(var_278_7.x, var_278_7.y, var_278_7.z)

				local var_278_8 = var_278_0.localEulerAngles

				var_278_8.z = 0
				var_278_8.x = 0
				var_278_0.localEulerAngles = var_278_8
			end

			local var_278_9 = arg_275_1.actors_["1034ui_story"]
			local var_278_10 = 0

			if var_278_10 < arg_275_1.time_ and arg_275_1.time_ <= var_278_10 + arg_278_0 and not isNil(var_278_9) and arg_275_1.var_.characterEffect1034ui_story == nil then
				arg_275_1.var_.characterEffect1034ui_story = var_278_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_278_11 = 0.200000002980232

			if var_278_10 <= arg_275_1.time_ and arg_275_1.time_ < var_278_10 + var_278_11 and not isNil(var_278_9) then
				local var_278_12 = (arg_275_1.time_ - var_278_10) / var_278_11

				if arg_275_1.var_.characterEffect1034ui_story and not isNil(var_278_9) then
					arg_275_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_275_1.time_ >= var_278_10 + var_278_11 and arg_275_1.time_ < var_278_10 + var_278_11 + arg_278_0 and not isNil(var_278_9) and arg_275_1.var_.characterEffect1034ui_story then
				arg_275_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			local var_278_13 = arg_275_1.actors_["6148ui_story"]
			local var_278_14 = 0

			if var_278_14 < arg_275_1.time_ and arg_275_1.time_ <= var_278_14 + arg_278_0 and not isNil(var_278_13) and arg_275_1.var_.characterEffect6148ui_story == nil then
				arg_275_1.var_.characterEffect6148ui_story = var_278_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_278_15 = 0.200000002980232

			if var_278_14 <= arg_275_1.time_ and arg_275_1.time_ < var_278_14 + var_278_15 and not isNil(var_278_13) then
				local var_278_16 = (arg_275_1.time_ - var_278_14) / var_278_15

				if arg_275_1.var_.characterEffect6148ui_story and not isNil(var_278_13) then
					local var_278_17 = Mathf.Lerp(0, 0.5, var_278_16)

					arg_275_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_275_1.var_.characterEffect6148ui_story.fillRatio = var_278_17
				end
			end

			if arg_275_1.time_ >= var_278_14 + var_278_15 and arg_275_1.time_ < var_278_14 + var_278_15 + arg_278_0 and not isNil(var_278_13) and arg_275_1.var_.characterEffect6148ui_story then
				local var_278_18 = 0.5

				arg_275_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_275_1.var_.characterEffect6148ui_story.fillRatio = var_278_18
			end

			local var_278_19 = 0

			if var_278_19 < arg_275_1.time_ and arg_275_1.time_ <= var_278_19 + arg_278_0 then
				arg_275_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action7_1")
			end

			local var_278_20 = 0

			if var_278_20 < arg_275_1.time_ and arg_275_1.time_ <= var_278_20 + arg_278_0 then
				arg_275_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_278_21 = 0
			local var_278_22 = 0.55

			if var_278_21 < arg_275_1.time_ and arg_275_1.time_ <= var_278_21 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, true)

				local var_278_23 = arg_275_1:FormatText(StoryNameCfg[1109].name)

				arg_275_1.leftNameTxt_.text = var_278_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_275_1.leftNameTxt_.transform)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1.leftNameTxt_.text)
				SetActive(arg_275_1.iconTrs_.gameObject, false)
				arg_275_1.callingController_:SetSelectedState("normal")

				local var_278_24 = arg_275_1:GetWordFromCfg(939012067)
				local var_278_25 = arg_275_1:FormatText(var_278_24.content)

				arg_275_1.text_.text = var_278_25

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_26 = 22
				local var_278_27 = utf8.len(var_278_25)
				local var_278_28 = var_278_26 <= 0 and var_278_22 or var_278_22 * (var_278_27 / var_278_26)

				if var_278_28 > 0 and var_278_22 < var_278_28 then
					arg_275_1.talkMaxDuration = var_278_28

					if var_278_28 + var_278_21 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_28 + var_278_21
					end
				end

				arg_275_1.text_.text = var_278_25
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)
				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_29 = math.max(var_278_22, arg_275_1.talkMaxDuration)

			if var_278_21 <= arg_275_1.time_ and arg_275_1.time_ < var_278_21 + var_278_29 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - var_278_21) / var_278_29

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= var_278_21 + var_278_29 and arg_275_1.time_ < var_278_21 + var_278_29 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_275_1:InitPlayNodeList()
	end,
	Play939012068 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 939012068
		arg_279_1.duration_ = 5

		SetActive(arg_279_1.tipsGo_, false)

		function arg_279_1.onSingleLineFinish_()
			arg_279_1.onSingleLineUpdate_ = nil
			arg_279_1.onSingleLineFinish_ = nil
			arg_279_1.state_ = "waiting"
		end

		function arg_279_1.playNext_(arg_281_0)
			if arg_281_0 == 1 then
				arg_279_0:Play939012069(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			local var_282_0 = arg_279_1.actors_["6148ui_story"].transform
			local var_282_1 = 0

			if var_282_1 < arg_279_1.time_ and arg_279_1.time_ <= var_282_1 + arg_282_0 then
				arg_279_1.var_.moveOldPos6148ui_story = var_282_0.localPosition

				local var_282_2 = GameObjectTools.GetOrAddComponent(var_282_0.gameObject, typeof(DynamicBoneHelper))

				if var_282_2 then
					var_282_2:EnableDynamicBone(false)
				end
			end

			local var_282_3 = 0.001

			if var_282_1 <= arg_279_1.time_ and arg_279_1.time_ < var_282_1 + var_282_3 then
				local var_282_4 = (arg_279_1.time_ - var_282_1) / var_282_3
				local var_282_5 = Vector3.New(0.7, -0.985, -6)

				var_282_0.localPosition = Vector3.Lerp(arg_279_1.var_.moveOldPos6148ui_story, var_282_5, var_282_4)

				local var_282_6 = manager.ui.mainCamera.transform.position - var_282_0.position

				var_282_0.forward = Vector3.New(var_282_6.x, var_282_6.y, var_282_6.z)

				local var_282_7 = var_282_0.localEulerAngles

				var_282_7.z = 0
				var_282_7.x = 0
				var_282_0.localEulerAngles = var_282_7
			end

			if arg_279_1.time_ >= var_282_1 + var_282_3 and arg_279_1.time_ < var_282_1 + var_282_3 + arg_282_0 then
				var_282_0.localPosition = Vector3.New(0.7, -0.985, -6)

				local var_282_8 = manager.ui.mainCamera.transform.position - var_282_0.position

				var_282_0.forward = Vector3.New(var_282_8.x, var_282_8.y, var_282_8.z)

				local var_282_9 = var_282_0.localEulerAngles

				var_282_9.z = 0
				var_282_9.x = 0
				var_282_0.localEulerAngles = var_282_9

				local var_282_10 = GameObjectTools.GetOrAddComponent(var_282_0.gameObject, typeof(DynamicBoneHelper))

				if var_282_10 then
					var_282_10:EnableDynamicBone(true)
				end
			end

			local var_282_11 = arg_279_1.actors_["6148ui_story"]
			local var_282_12 = 0

			if var_282_12 < arg_279_1.time_ and arg_279_1.time_ <= var_282_12 + arg_282_0 and not isNil(var_282_11) and arg_279_1.var_.characterEffect6148ui_story == nil then
				arg_279_1.var_.characterEffect6148ui_story = var_282_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_282_13 = 0.200000002980232

			if var_282_12 <= arg_279_1.time_ and arg_279_1.time_ < var_282_12 + var_282_13 and not isNil(var_282_11) then
				local var_282_14 = (arg_279_1.time_ - var_282_12) / var_282_13

				if arg_279_1.var_.characterEffect6148ui_story and not isNil(var_282_11) then
					arg_279_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_279_1.time_ >= var_282_12 + var_282_13 and arg_279_1.time_ < var_282_12 + var_282_13 + arg_282_0 and not isNil(var_282_11) and arg_279_1.var_.characterEffect6148ui_story then
				arg_279_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_282_15 = arg_279_1.actors_["1034ui_story"]
			local var_282_16 = 0

			if var_282_16 < arg_279_1.time_ and arg_279_1.time_ <= var_282_16 + arg_282_0 and not isNil(var_282_15) and arg_279_1.var_.characterEffect1034ui_story == nil then
				arg_279_1.var_.characterEffect1034ui_story = var_282_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_282_17 = 0.200000002980232

			if var_282_16 <= arg_279_1.time_ and arg_279_1.time_ < var_282_16 + var_282_17 and not isNil(var_282_15) then
				local var_282_18 = (arg_279_1.time_ - var_282_16) / var_282_17

				if arg_279_1.var_.characterEffect1034ui_story and not isNil(var_282_15) then
					local var_282_19 = Mathf.Lerp(0, 0.5, var_282_18)

					arg_279_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_279_1.var_.characterEffect1034ui_story.fillRatio = var_282_19
				end
			end

			if arg_279_1.time_ >= var_282_16 + var_282_17 and arg_279_1.time_ < var_282_16 + var_282_17 + arg_282_0 and not isNil(var_282_15) and arg_279_1.var_.characterEffect1034ui_story then
				local var_282_20 = 0.5

				arg_279_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_279_1.var_.characterEffect1034ui_story.fillRatio = var_282_20
			end

			local var_282_21 = 0

			if var_282_21 < arg_279_1.time_ and arg_279_1.time_ <= var_282_21 + arg_282_0 then
				arg_279_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action2_2")
			end

			local var_282_22 = 0

			if var_282_22 < arg_279_1.time_ and arg_279_1.time_ <= var_282_22 + arg_282_0 then
				arg_279_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_282_23 = 0
			local var_282_24 = 1.15

			if var_282_23 < arg_279_1.time_ and arg_279_1.time_ <= var_282_23 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, true)

				local var_282_25 = arg_279_1:FormatText(StoryNameCfg[1488].name)

				arg_279_1.leftNameTxt_.text = var_282_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_279_1.leftNameTxt_.transform)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1.leftNameTxt_.text)
				SetActive(arg_279_1.iconTrs_.gameObject, false)
				arg_279_1.callingController_:SetSelectedState("normal")

				local var_282_26 = arg_279_1:GetWordFromCfg(939012068)
				local var_282_27 = arg_279_1:FormatText(var_282_26.content)

				arg_279_1.text_.text = var_282_27

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_28 = 46
				local var_282_29 = utf8.len(var_282_27)
				local var_282_30 = var_282_28 <= 0 and var_282_24 or var_282_24 * (var_282_29 / var_282_28)

				if var_282_30 > 0 and var_282_24 < var_282_30 then
					arg_279_1.talkMaxDuration = var_282_30

					if var_282_30 + var_282_23 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_30 + var_282_23
					end
				end

				arg_279_1.text_.text = var_282_27
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)
				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_31 = math.max(var_282_24, arg_279_1.talkMaxDuration)

			if var_282_23 <= arg_279_1.time_ and arg_279_1.time_ < var_282_23 + var_282_31 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - var_282_23) / var_282_31

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= var_282_23 + var_282_31 and arg_279_1.time_ < var_282_23 + var_282_31 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_279_1:InitPlayNodeList()
	end,
	Play939012069 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 939012069
		arg_283_1.duration_ = 5

		SetActive(arg_283_1.tipsGo_, false)

		function arg_283_1.onSingleLineFinish_()
			arg_283_1.onSingleLineUpdate_ = nil
			arg_283_1.onSingleLineFinish_ = nil
			arg_283_1.state_ = "waiting"
		end

		function arg_283_1.playNext_(arg_285_0)
			if arg_285_0 == 1 then
				arg_283_0:Play939012070(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			local var_286_0 = arg_283_1.actors_["1054ui_story"].transform
			local var_286_1 = 0

			if var_286_1 < arg_283_1.time_ and arg_283_1.time_ <= var_286_1 + arg_286_0 then
				arg_283_1.var_.moveOldPos1054ui_story = var_286_0.localPosition

				local var_286_2 = GameObjectTools.GetOrAddComponent(var_286_0.gameObject, typeof(DynamicBoneHelper))

				if var_286_2 then
					var_286_2:EnableDynamicBone(false)
				end
			end

			local var_286_3 = 0.001

			if var_286_1 <= arg_283_1.time_ and arg_283_1.time_ < var_286_1 + var_286_3 then
				local var_286_4 = (arg_283_1.time_ - var_286_1) / var_286_3
				local var_286_5 = Vector3.New(-0.7, -0.985, -6)

				var_286_0.localPosition = Vector3.Lerp(arg_283_1.var_.moveOldPos1054ui_story, var_286_5, var_286_4)

				local var_286_6 = manager.ui.mainCamera.transform.position - var_286_0.position

				var_286_0.forward = Vector3.New(var_286_6.x, var_286_6.y, var_286_6.z)

				local var_286_7 = var_286_0.localEulerAngles

				var_286_7.z = 0
				var_286_7.x = 0
				var_286_0.localEulerAngles = var_286_7
			end

			if arg_283_1.time_ >= var_286_1 + var_286_3 and arg_283_1.time_ < var_286_1 + var_286_3 + arg_286_0 then
				var_286_0.localPosition = Vector3.New(-0.7, -0.985, -6)

				local var_286_8 = manager.ui.mainCamera.transform.position - var_286_0.position

				var_286_0.forward = Vector3.New(var_286_8.x, var_286_8.y, var_286_8.z)

				local var_286_9 = var_286_0.localEulerAngles

				var_286_9.z = 0
				var_286_9.x = 0
				var_286_0.localEulerAngles = var_286_9

				local var_286_10 = GameObjectTools.GetOrAddComponent(var_286_0.gameObject, typeof(DynamicBoneHelper))

				if var_286_10 then
					var_286_10:EnableDynamicBone(true)
				end
			end

			local var_286_11 = arg_283_1.actors_["1034ui_story"].transform
			local var_286_12 = 0

			if var_286_12 < arg_283_1.time_ and arg_283_1.time_ <= var_286_12 + arg_286_0 then
				arg_283_1.var_.moveOldPos1034ui_story = var_286_11.localPosition
			end

			local var_286_13 = 0.001

			if var_286_12 <= arg_283_1.time_ and arg_283_1.time_ < var_286_12 + var_286_13 then
				local var_286_14 = (arg_283_1.time_ - var_286_12) / var_286_13
				local var_286_15 = Vector3.New(0, 100, 0)

				var_286_11.localPosition = Vector3.Lerp(arg_283_1.var_.moveOldPos1034ui_story, var_286_15, var_286_14)

				local var_286_16 = manager.ui.mainCamera.transform.position - var_286_11.position

				var_286_11.forward = Vector3.New(var_286_16.x, var_286_16.y, var_286_16.z)

				local var_286_17 = var_286_11.localEulerAngles

				var_286_17.z = 0
				var_286_17.x = 0
				var_286_11.localEulerAngles = var_286_17
			end

			if arg_283_1.time_ >= var_286_12 + var_286_13 and arg_283_1.time_ < var_286_12 + var_286_13 + arg_286_0 then
				var_286_11.localPosition = Vector3.New(0, 100, 0)

				local var_286_18 = manager.ui.mainCamera.transform.position - var_286_11.position

				var_286_11.forward = Vector3.New(var_286_18.x, var_286_18.y, var_286_18.z)

				local var_286_19 = var_286_11.localEulerAngles

				var_286_19.z = 0
				var_286_19.x = 0
				var_286_11.localEulerAngles = var_286_19
			end

			local var_286_20 = arg_283_1.actors_["1054ui_story"]
			local var_286_21 = 0

			if var_286_21 < arg_283_1.time_ and arg_283_1.time_ <= var_286_21 + arg_286_0 and not isNil(var_286_20) and arg_283_1.var_.characterEffect1054ui_story == nil then
				arg_283_1.var_.characterEffect1054ui_story = var_286_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_286_22 = 0.200000002980232

			if var_286_21 <= arg_283_1.time_ and arg_283_1.time_ < var_286_21 + var_286_22 and not isNil(var_286_20) then
				local var_286_23 = (arg_283_1.time_ - var_286_21) / var_286_22

				if arg_283_1.var_.characterEffect1054ui_story and not isNil(var_286_20) then
					arg_283_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_283_1.time_ >= var_286_21 + var_286_22 and arg_283_1.time_ < var_286_21 + var_286_22 + arg_286_0 and not isNil(var_286_20) and arg_283_1.var_.characterEffect1054ui_story then
				arg_283_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_286_24 = arg_283_1.actors_["6148ui_story"]
			local var_286_25 = 0

			if var_286_25 < arg_283_1.time_ and arg_283_1.time_ <= var_286_25 + arg_286_0 and not isNil(var_286_24) and arg_283_1.var_.characterEffect6148ui_story == nil then
				arg_283_1.var_.characterEffect6148ui_story = var_286_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_286_26 = 0.200000002980232

			if var_286_25 <= arg_283_1.time_ and arg_283_1.time_ < var_286_25 + var_286_26 and not isNil(var_286_24) then
				local var_286_27 = (arg_283_1.time_ - var_286_25) / var_286_26

				if arg_283_1.var_.characterEffect6148ui_story and not isNil(var_286_24) then
					local var_286_28 = Mathf.Lerp(0, 0.5, var_286_27)

					arg_283_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_283_1.var_.characterEffect6148ui_story.fillRatio = var_286_28
				end
			end

			if arg_283_1.time_ >= var_286_25 + var_286_26 and arg_283_1.time_ < var_286_25 + var_286_26 + arg_286_0 and not isNil(var_286_24) and arg_283_1.var_.characterEffect6148ui_story then
				local var_286_29 = 0.5

				arg_283_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_283_1.var_.characterEffect6148ui_story.fillRatio = var_286_29
			end

			local var_286_30 = 0

			if var_286_30 < arg_283_1.time_ and arg_283_1.time_ <= var_286_30 + arg_286_0 then
				arg_283_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action4_1")
			end

			local var_286_31 = 0

			if var_286_31 < arg_283_1.time_ and arg_283_1.time_ <= var_286_31 + arg_286_0 then
				arg_283_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_286_32 = 0
			local var_286_33 = 0.55

			if var_286_32 < arg_283_1.time_ and arg_283_1.time_ <= var_286_32 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, true)

				local var_286_34 = arg_283_1:FormatText(StoryNameCfg[1487].name)

				arg_283_1.leftNameTxt_.text = var_286_34

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_283_1.leftNameTxt_.transform)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1.leftNameTxt_.text)
				SetActive(arg_283_1.iconTrs_.gameObject, false)
				arg_283_1.callingController_:SetSelectedState("normal")

				local var_286_35 = arg_283_1:GetWordFromCfg(939012069)
				local var_286_36 = arg_283_1:FormatText(var_286_35.content)

				arg_283_1.text_.text = var_286_36

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_37 = 22
				local var_286_38 = utf8.len(var_286_36)
				local var_286_39 = var_286_37 <= 0 and var_286_33 or var_286_33 * (var_286_38 / var_286_37)

				if var_286_39 > 0 and var_286_33 < var_286_39 then
					arg_283_1.talkMaxDuration = var_286_39

					if var_286_39 + var_286_32 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_39 + var_286_32
					end
				end

				arg_283_1.text_.text = var_286_36
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)
				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_40 = math.max(var_286_33, arg_283_1.talkMaxDuration)

			if var_286_32 <= arg_283_1.time_ and arg_283_1.time_ < var_286_32 + var_286_40 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - var_286_32) / var_286_40

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= var_286_32 + var_286_40 and arg_283_1.time_ < var_286_32 + var_286_40 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1034ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_283_1:InitPlayNodeList()
	end,
	Play939012070 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 939012070
		arg_287_1.duration_ = 5

		SetActive(arg_287_1.tipsGo_, false)

		function arg_287_1.onSingleLineFinish_()
			arg_287_1.onSingleLineUpdate_ = nil
			arg_287_1.onSingleLineFinish_ = nil
			arg_287_1.state_ = "waiting"
		end

		function arg_287_1.playNext_(arg_289_0)
			if arg_289_0 == 1 then
				arg_287_0:Play939012071(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			local var_290_0 = arg_287_1.actors_["6148ui_story"].transform
			local var_290_1 = 0

			if var_290_1 < arg_287_1.time_ and arg_287_1.time_ <= var_290_1 + arg_290_0 then
				arg_287_1.var_.moveOldPos6148ui_story = var_290_0.localPosition

				local var_290_2 = GameObjectTools.GetOrAddComponent(var_290_0.gameObject, typeof(DynamicBoneHelper))

				if var_290_2 then
					var_290_2:EnableDynamicBone(false)
				end
			end

			local var_290_3 = 0.001

			if var_290_1 <= arg_287_1.time_ and arg_287_1.time_ < var_290_1 + var_290_3 then
				local var_290_4 = (arg_287_1.time_ - var_290_1) / var_290_3
				local var_290_5 = Vector3.New(0.7, -0.985, -6)

				var_290_0.localPosition = Vector3.Lerp(arg_287_1.var_.moveOldPos6148ui_story, var_290_5, var_290_4)

				local var_290_6 = manager.ui.mainCamera.transform.position - var_290_0.position

				var_290_0.forward = Vector3.New(var_290_6.x, var_290_6.y, var_290_6.z)

				local var_290_7 = var_290_0.localEulerAngles

				var_290_7.z = 0
				var_290_7.x = 0
				var_290_0.localEulerAngles = var_290_7
			end

			if arg_287_1.time_ >= var_290_1 + var_290_3 and arg_287_1.time_ < var_290_1 + var_290_3 + arg_290_0 then
				var_290_0.localPosition = Vector3.New(0.7, -0.985, -6)

				local var_290_8 = manager.ui.mainCamera.transform.position - var_290_0.position

				var_290_0.forward = Vector3.New(var_290_8.x, var_290_8.y, var_290_8.z)

				local var_290_9 = var_290_0.localEulerAngles

				var_290_9.z = 0
				var_290_9.x = 0
				var_290_0.localEulerAngles = var_290_9

				local var_290_10 = GameObjectTools.GetOrAddComponent(var_290_0.gameObject, typeof(DynamicBoneHelper))

				if var_290_10 then
					var_290_10:EnableDynamicBone(true)
				end
			end

			local var_290_11 = arg_287_1.actors_["6148ui_story"]
			local var_290_12 = 0

			if var_290_12 < arg_287_1.time_ and arg_287_1.time_ <= var_290_12 + arg_290_0 and not isNil(var_290_11) and arg_287_1.var_.characterEffect6148ui_story == nil then
				arg_287_1.var_.characterEffect6148ui_story = var_290_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_290_13 = 0.200000002980232

			if var_290_12 <= arg_287_1.time_ and arg_287_1.time_ < var_290_12 + var_290_13 and not isNil(var_290_11) then
				local var_290_14 = (arg_287_1.time_ - var_290_12) / var_290_13

				if arg_287_1.var_.characterEffect6148ui_story and not isNil(var_290_11) then
					arg_287_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_287_1.time_ >= var_290_12 + var_290_13 and arg_287_1.time_ < var_290_12 + var_290_13 + arg_290_0 and not isNil(var_290_11) and arg_287_1.var_.characterEffect6148ui_story then
				arg_287_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_290_15 = arg_287_1.actors_["1054ui_story"]
			local var_290_16 = 0

			if var_290_16 < arg_287_1.time_ and arg_287_1.time_ <= var_290_16 + arg_290_0 and not isNil(var_290_15) and arg_287_1.var_.characterEffect1054ui_story == nil then
				arg_287_1.var_.characterEffect1054ui_story = var_290_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_290_17 = 0.200000002980232

			if var_290_16 <= arg_287_1.time_ and arg_287_1.time_ < var_290_16 + var_290_17 and not isNil(var_290_15) then
				local var_290_18 = (arg_287_1.time_ - var_290_16) / var_290_17

				if arg_287_1.var_.characterEffect1054ui_story and not isNil(var_290_15) then
					local var_290_19 = Mathf.Lerp(0, 0.5, var_290_18)

					arg_287_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_287_1.var_.characterEffect1054ui_story.fillRatio = var_290_19
				end
			end

			if arg_287_1.time_ >= var_290_16 + var_290_17 and arg_287_1.time_ < var_290_16 + var_290_17 + arg_290_0 and not isNil(var_290_15) and arg_287_1.var_.characterEffect1054ui_story then
				local var_290_20 = 0.5

				arg_287_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_287_1.var_.characterEffect1054ui_story.fillRatio = var_290_20
			end

			local var_290_21 = 0

			if var_290_21 < arg_287_1.time_ and arg_287_1.time_ <= var_290_21 + arg_290_0 then
				arg_287_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action5_1")
			end

			local var_290_22 = 0

			if var_290_22 < arg_287_1.time_ and arg_287_1.time_ <= var_290_22 + arg_290_0 then
				arg_287_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_290_23 = 0
			local var_290_24 = 0.5

			if var_290_23 < arg_287_1.time_ and arg_287_1.time_ <= var_290_23 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, true)

				local var_290_25 = arg_287_1:FormatText(StoryNameCfg[1488].name)

				arg_287_1.leftNameTxt_.text = var_290_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_287_1.leftNameTxt_.transform)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1.leftNameTxt_.text)
				SetActive(arg_287_1.iconTrs_.gameObject, false)
				arg_287_1.callingController_:SetSelectedState("normal")

				local var_290_26 = arg_287_1:GetWordFromCfg(939012070)
				local var_290_27 = arg_287_1:FormatText(var_290_26.content)

				arg_287_1.text_.text = var_290_27

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_28 = 20
				local var_290_29 = utf8.len(var_290_27)
				local var_290_30 = var_290_28 <= 0 and var_290_24 or var_290_24 * (var_290_29 / var_290_28)

				if var_290_30 > 0 and var_290_24 < var_290_30 then
					arg_287_1.talkMaxDuration = var_290_30

					if var_290_30 + var_290_23 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_30 + var_290_23
					end
				end

				arg_287_1.text_.text = var_290_27
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)
				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_31 = math.max(var_290_24, arg_287_1.talkMaxDuration)

			if var_290_23 <= arg_287_1.time_ and arg_287_1.time_ < var_290_23 + var_290_31 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - var_290_23) / var_290_31

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= var_290_23 + var_290_31 and arg_287_1.time_ < var_290_23 + var_290_31 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_287_1:InitPlayNodeList()
	end,
	Play939012071 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 939012071
		arg_291_1.duration_ = 5

		SetActive(arg_291_1.tipsGo_, false)

		function arg_291_1.onSingleLineFinish_()
			arg_291_1.onSingleLineUpdate_ = nil
			arg_291_1.onSingleLineFinish_ = nil
			arg_291_1.state_ = "waiting"
		end

		function arg_291_1.playNext_(arg_293_0)
			if arg_293_0 == 1 then
				arg_291_0:Play939012072(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			local var_294_0 = arg_291_1.actors_["1034ui_story"].transform
			local var_294_1 = 0

			if var_294_1 < arg_291_1.time_ and arg_291_1.time_ <= var_294_1 + arg_294_0 then
				arg_291_1.var_.moveOldPos1034ui_story = var_294_0.localPosition
			end

			local var_294_2 = 0.001

			if var_294_1 <= arg_291_1.time_ and arg_291_1.time_ < var_294_1 + var_294_2 then
				local var_294_3 = (arg_291_1.time_ - var_294_1) / var_294_2
				local var_294_4 = Vector3.New(0.7, -0.93, -6)

				var_294_0.localPosition = Vector3.Lerp(arg_291_1.var_.moveOldPos1034ui_story, var_294_4, var_294_3)

				local var_294_5 = manager.ui.mainCamera.transform.position - var_294_0.position

				var_294_0.forward = Vector3.New(var_294_5.x, var_294_5.y, var_294_5.z)

				local var_294_6 = var_294_0.localEulerAngles

				var_294_6.z = 0
				var_294_6.x = 0
				var_294_0.localEulerAngles = var_294_6
			end

			if arg_291_1.time_ >= var_294_1 + var_294_2 and arg_291_1.time_ < var_294_1 + var_294_2 + arg_294_0 then
				var_294_0.localPosition = Vector3.New(0.7, -0.93, -6)

				local var_294_7 = manager.ui.mainCamera.transform.position - var_294_0.position

				var_294_0.forward = Vector3.New(var_294_7.x, var_294_7.y, var_294_7.z)

				local var_294_8 = var_294_0.localEulerAngles

				var_294_8.z = 0
				var_294_8.x = 0
				var_294_0.localEulerAngles = var_294_8
			end

			local var_294_9 = arg_291_1.actors_["6148ui_story"].transform
			local var_294_10 = 0

			if var_294_10 < arg_291_1.time_ and arg_291_1.time_ <= var_294_10 + arg_294_0 then
				arg_291_1.var_.moveOldPos6148ui_story = var_294_9.localPosition

				local var_294_11 = GameObjectTools.GetOrAddComponent(var_294_9.gameObject, typeof(DynamicBoneHelper))

				if var_294_11 then
					var_294_11:EnableDynamicBone(false)
				end
			end

			local var_294_12 = 0.001

			if var_294_10 <= arg_291_1.time_ and arg_291_1.time_ < var_294_10 + var_294_12 then
				local var_294_13 = (arg_291_1.time_ - var_294_10) / var_294_12
				local var_294_14 = Vector3.New(0, 100, 0)

				var_294_9.localPosition = Vector3.Lerp(arg_291_1.var_.moveOldPos6148ui_story, var_294_14, var_294_13)

				local var_294_15 = manager.ui.mainCamera.transform.position - var_294_9.position

				var_294_9.forward = Vector3.New(var_294_15.x, var_294_15.y, var_294_15.z)

				local var_294_16 = var_294_9.localEulerAngles

				var_294_16.z = 0
				var_294_16.x = 0
				var_294_9.localEulerAngles = var_294_16
			end

			if arg_291_1.time_ >= var_294_10 + var_294_12 and arg_291_1.time_ < var_294_10 + var_294_12 + arg_294_0 then
				var_294_9.localPosition = Vector3.New(0, 100, 0)

				local var_294_17 = manager.ui.mainCamera.transform.position - var_294_9.position

				var_294_9.forward = Vector3.New(var_294_17.x, var_294_17.y, var_294_17.z)

				local var_294_18 = var_294_9.localEulerAngles

				var_294_18.z = 0
				var_294_18.x = 0
				var_294_9.localEulerAngles = var_294_18

				local var_294_19 = GameObjectTools.GetOrAddComponent(var_294_9.gameObject, typeof(DynamicBoneHelper))

				if var_294_19 then
					var_294_19:EnableDynamicBone(true)
				end
			end

			local var_294_20 = arg_291_1.actors_["1034ui_story"]
			local var_294_21 = 0

			if var_294_21 < arg_291_1.time_ and arg_291_1.time_ <= var_294_21 + arg_294_0 and not isNil(var_294_20) and arg_291_1.var_.characterEffect1034ui_story == nil then
				arg_291_1.var_.characterEffect1034ui_story = var_294_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_294_22 = 0.200000002980232

			if var_294_21 <= arg_291_1.time_ and arg_291_1.time_ < var_294_21 + var_294_22 and not isNil(var_294_20) then
				local var_294_23 = (arg_291_1.time_ - var_294_21) / var_294_22

				if arg_291_1.var_.characterEffect1034ui_story and not isNil(var_294_20) then
					arg_291_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_291_1.time_ >= var_294_21 + var_294_22 and arg_291_1.time_ < var_294_21 + var_294_22 + arg_294_0 and not isNil(var_294_20) and arg_291_1.var_.characterEffect1034ui_story then
				arg_291_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			local var_294_24 = arg_291_1.actors_["6148ui_story"]
			local var_294_25 = 0

			if var_294_25 < arg_291_1.time_ and arg_291_1.time_ <= var_294_25 + arg_294_0 and not isNil(var_294_24) and arg_291_1.var_.characterEffect6148ui_story == nil then
				arg_291_1.var_.characterEffect6148ui_story = var_294_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_294_26 = 0.200000002980232

			if var_294_25 <= arg_291_1.time_ and arg_291_1.time_ < var_294_25 + var_294_26 and not isNil(var_294_24) then
				local var_294_27 = (arg_291_1.time_ - var_294_25) / var_294_26

				if arg_291_1.var_.characterEffect6148ui_story and not isNil(var_294_24) then
					local var_294_28 = Mathf.Lerp(0, 0.5, var_294_27)

					arg_291_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_291_1.var_.characterEffect6148ui_story.fillRatio = var_294_28
				end
			end

			if arg_291_1.time_ >= var_294_25 + var_294_26 and arg_291_1.time_ < var_294_25 + var_294_26 + arg_294_0 and not isNil(var_294_24) and arg_291_1.var_.characterEffect6148ui_story then
				local var_294_29 = 0.5

				arg_291_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_291_1.var_.characterEffect6148ui_story.fillRatio = var_294_29
			end

			local var_294_30 = 0

			if var_294_30 < arg_291_1.time_ and arg_291_1.time_ <= var_294_30 + arg_294_0 then
				arg_291_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action1_1")
			end

			local var_294_31 = 0

			if var_294_31 < arg_291_1.time_ and arg_291_1.time_ <= var_294_31 + arg_294_0 then
				arg_291_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_294_32 = 0
			local var_294_33 = 0.65

			if var_294_32 < arg_291_1.time_ and arg_291_1.time_ <= var_294_32 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0
				arg_291_1.dialogCg_.alpha = 1

				arg_291_1.dialog_:SetActive(true)
				SetActive(arg_291_1.leftNameGo_, true)

				local var_294_34 = arg_291_1:FormatText(StoryNameCfg[1109].name)

				arg_291_1.leftNameTxt_.text = var_294_34

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_291_1.leftNameTxt_.transform)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1.leftNameTxt_.text)
				SetActive(arg_291_1.iconTrs_.gameObject, false)
				arg_291_1.callingController_:SetSelectedState("normal")

				local var_294_35 = arg_291_1:GetWordFromCfg(939012071)
				local var_294_36 = arg_291_1:FormatText(var_294_35.content)

				arg_291_1.text_.text = var_294_36

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_37 = 26
				local var_294_38 = utf8.len(var_294_36)
				local var_294_39 = var_294_37 <= 0 and var_294_33 or var_294_33 * (var_294_38 / var_294_37)

				if var_294_39 > 0 and var_294_33 < var_294_39 then
					arg_291_1.talkMaxDuration = var_294_39

					if var_294_39 + var_294_32 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_39 + var_294_32
					end
				end

				arg_291_1.text_.text = var_294_36
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)
				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_40 = math.max(var_294_33, arg_291_1.talkMaxDuration)

			if var_294_32 <= arg_291_1.time_ and arg_291_1.time_ < var_294_32 + var_294_40 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - var_294_32) / var_294_40

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= var_294_32 + var_294_40 and arg_291_1.time_ < var_294_32 + var_294_40 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_291_1:InitPlayNodeList()
	end,
	Play939012072 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 939012072
		arg_295_1.duration_ = 5

		SetActive(arg_295_1.tipsGo_, false)

		function arg_295_1.onSingleLineFinish_()
			arg_295_1.onSingleLineUpdate_ = nil
			arg_295_1.onSingleLineFinish_ = nil
			arg_295_1.state_ = "waiting"
		end

		function arg_295_1.playNext_(arg_297_0)
			if arg_297_0 == 1 then
				arg_295_0:Play939012073(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			local var_298_0 = arg_295_1.actors_["1054ui_story"].transform
			local var_298_1 = 0

			if var_298_1 < arg_295_1.time_ and arg_295_1.time_ <= var_298_1 + arg_298_0 then
				arg_295_1.var_.moveOldPos1054ui_story = var_298_0.localPosition

				local var_298_2 = GameObjectTools.GetOrAddComponent(var_298_0.gameObject, typeof(DynamicBoneHelper))

				if var_298_2 then
					var_298_2:EnableDynamicBone(false)
				end
			end

			local var_298_3 = 0.001

			if var_298_1 <= arg_295_1.time_ and arg_295_1.time_ < var_298_1 + var_298_3 then
				local var_298_4 = (arg_295_1.time_ - var_298_1) / var_298_3
				local var_298_5 = Vector3.New(-0.7, -0.985, -6)

				var_298_0.localPosition = Vector3.Lerp(arg_295_1.var_.moveOldPos1054ui_story, var_298_5, var_298_4)

				local var_298_6 = manager.ui.mainCamera.transform.position - var_298_0.position

				var_298_0.forward = Vector3.New(var_298_6.x, var_298_6.y, var_298_6.z)

				local var_298_7 = var_298_0.localEulerAngles

				var_298_7.z = 0
				var_298_7.x = 0
				var_298_0.localEulerAngles = var_298_7
			end

			if arg_295_1.time_ >= var_298_1 + var_298_3 and arg_295_1.time_ < var_298_1 + var_298_3 + arg_298_0 then
				var_298_0.localPosition = Vector3.New(-0.7, -0.985, -6)

				local var_298_8 = manager.ui.mainCamera.transform.position - var_298_0.position

				var_298_0.forward = Vector3.New(var_298_8.x, var_298_8.y, var_298_8.z)

				local var_298_9 = var_298_0.localEulerAngles

				var_298_9.z = 0
				var_298_9.x = 0
				var_298_0.localEulerAngles = var_298_9

				local var_298_10 = GameObjectTools.GetOrAddComponent(var_298_0.gameObject, typeof(DynamicBoneHelper))

				if var_298_10 then
					var_298_10:EnableDynamicBone(true)
				end
			end

			local var_298_11 = arg_295_1.actors_["1054ui_story"]
			local var_298_12 = 0

			if var_298_12 < arg_295_1.time_ and arg_295_1.time_ <= var_298_12 + arg_298_0 and not isNil(var_298_11) and arg_295_1.var_.characterEffect1054ui_story == nil then
				arg_295_1.var_.characterEffect1054ui_story = var_298_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_298_13 = 0.200000002980232

			if var_298_12 <= arg_295_1.time_ and arg_295_1.time_ < var_298_12 + var_298_13 and not isNil(var_298_11) then
				local var_298_14 = (arg_295_1.time_ - var_298_12) / var_298_13

				if arg_295_1.var_.characterEffect1054ui_story and not isNil(var_298_11) then
					arg_295_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_295_1.time_ >= var_298_12 + var_298_13 and arg_295_1.time_ < var_298_12 + var_298_13 + arg_298_0 and not isNil(var_298_11) and arg_295_1.var_.characterEffect1054ui_story then
				arg_295_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_298_15 = arg_295_1.actors_["1034ui_story"]
			local var_298_16 = 0

			if var_298_16 < arg_295_1.time_ and arg_295_1.time_ <= var_298_16 + arg_298_0 and not isNil(var_298_15) and arg_295_1.var_.characterEffect1034ui_story == nil then
				arg_295_1.var_.characterEffect1034ui_story = var_298_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_298_17 = 0.200000002980232

			if var_298_16 <= arg_295_1.time_ and arg_295_1.time_ < var_298_16 + var_298_17 and not isNil(var_298_15) then
				local var_298_18 = (arg_295_1.time_ - var_298_16) / var_298_17

				if arg_295_1.var_.characterEffect1034ui_story and not isNil(var_298_15) then
					local var_298_19 = Mathf.Lerp(0, 0.5, var_298_18)

					arg_295_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_295_1.var_.characterEffect1034ui_story.fillRatio = var_298_19
				end
			end

			if arg_295_1.time_ >= var_298_16 + var_298_17 and arg_295_1.time_ < var_298_16 + var_298_17 + arg_298_0 and not isNil(var_298_15) and arg_295_1.var_.characterEffect1034ui_story then
				local var_298_20 = 0.5

				arg_295_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_295_1.var_.characterEffect1034ui_story.fillRatio = var_298_20
			end

			local var_298_21 = 0

			if var_298_21 < arg_295_1.time_ and arg_295_1.time_ <= var_298_21 + arg_298_0 then
				arg_295_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action4_2")
			end

			local var_298_22 = 0

			if var_298_22 < arg_295_1.time_ and arg_295_1.time_ <= var_298_22 + arg_298_0 then
				arg_295_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_298_23 = 0
			local var_298_24 = 0.75

			if var_298_23 < arg_295_1.time_ and arg_295_1.time_ <= var_298_23 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, true)

				local var_298_25 = arg_295_1:FormatText(StoryNameCfg[1487].name)

				arg_295_1.leftNameTxt_.text = var_298_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_295_1.leftNameTxt_.transform)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1.leftNameTxt_.text)
				SetActive(arg_295_1.iconTrs_.gameObject, false)
				arg_295_1.callingController_:SetSelectedState("normal")

				local var_298_26 = arg_295_1:GetWordFromCfg(939012072)
				local var_298_27 = arg_295_1:FormatText(var_298_26.content)

				arg_295_1.text_.text = var_298_27

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_28 = 30
				local var_298_29 = utf8.len(var_298_27)
				local var_298_30 = var_298_28 <= 0 and var_298_24 or var_298_24 * (var_298_29 / var_298_28)

				if var_298_30 > 0 and var_298_24 < var_298_30 then
					arg_295_1.talkMaxDuration = var_298_30

					if var_298_30 + var_298_23 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_30 + var_298_23
					end
				end

				arg_295_1.text_.text = var_298_27
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)
				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_31 = math.max(var_298_24, arg_295_1.talkMaxDuration)

			if var_298_23 <= arg_295_1.time_ and arg_295_1.time_ < var_298_23 + var_298_31 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - var_298_23) / var_298_31

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= var_298_23 + var_298_31 and arg_295_1.time_ < var_298_23 + var_298_31 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_295_1:InitPlayNodeList()
	end,
	Play939012073 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 939012073
		arg_299_1.duration_ = 5

		SetActive(arg_299_1.tipsGo_, false)

		function arg_299_1.onSingleLineFinish_()
			arg_299_1.onSingleLineUpdate_ = nil
			arg_299_1.onSingleLineFinish_ = nil
			arg_299_1.state_ = "waiting"
		end

		function arg_299_1.playNext_(arg_301_0)
			if arg_301_0 == 1 then
				arg_299_0:Play939012074(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			local var_302_0 = arg_299_1.actors_["6148ui_story"].transform
			local var_302_1 = 0

			if var_302_1 < arg_299_1.time_ and arg_299_1.time_ <= var_302_1 + arg_302_0 then
				arg_299_1.var_.moveOldPos6148ui_story = var_302_0.localPosition

				local var_302_2 = GameObjectTools.GetOrAddComponent(var_302_0.gameObject, typeof(DynamicBoneHelper))

				if var_302_2 then
					var_302_2:EnableDynamicBone(false)
				end
			end

			local var_302_3 = 0.001

			if var_302_1 <= arg_299_1.time_ and arg_299_1.time_ < var_302_1 + var_302_3 then
				local var_302_4 = (arg_299_1.time_ - var_302_1) / var_302_3
				local var_302_5 = Vector3.New(0.7, -0.985, -6)

				var_302_0.localPosition = Vector3.Lerp(arg_299_1.var_.moveOldPos6148ui_story, var_302_5, var_302_4)

				local var_302_6 = manager.ui.mainCamera.transform.position - var_302_0.position

				var_302_0.forward = Vector3.New(var_302_6.x, var_302_6.y, var_302_6.z)

				local var_302_7 = var_302_0.localEulerAngles

				var_302_7.z = 0
				var_302_7.x = 0
				var_302_0.localEulerAngles = var_302_7
			end

			if arg_299_1.time_ >= var_302_1 + var_302_3 and arg_299_1.time_ < var_302_1 + var_302_3 + arg_302_0 then
				var_302_0.localPosition = Vector3.New(0.7, -0.985, -6)

				local var_302_8 = manager.ui.mainCamera.transform.position - var_302_0.position

				var_302_0.forward = Vector3.New(var_302_8.x, var_302_8.y, var_302_8.z)

				local var_302_9 = var_302_0.localEulerAngles

				var_302_9.z = 0
				var_302_9.x = 0
				var_302_0.localEulerAngles = var_302_9

				local var_302_10 = GameObjectTools.GetOrAddComponent(var_302_0.gameObject, typeof(DynamicBoneHelper))

				if var_302_10 then
					var_302_10:EnableDynamicBone(true)
				end
			end

			local var_302_11 = arg_299_1.actors_["1034ui_story"].transform
			local var_302_12 = 0

			if var_302_12 < arg_299_1.time_ and arg_299_1.time_ <= var_302_12 + arg_302_0 then
				arg_299_1.var_.moveOldPos1034ui_story = var_302_11.localPosition
			end

			local var_302_13 = 0.001

			if var_302_12 <= arg_299_1.time_ and arg_299_1.time_ < var_302_12 + var_302_13 then
				local var_302_14 = (arg_299_1.time_ - var_302_12) / var_302_13
				local var_302_15 = Vector3.New(0, 100, 0)

				var_302_11.localPosition = Vector3.Lerp(arg_299_1.var_.moveOldPos1034ui_story, var_302_15, var_302_14)

				local var_302_16 = manager.ui.mainCamera.transform.position - var_302_11.position

				var_302_11.forward = Vector3.New(var_302_16.x, var_302_16.y, var_302_16.z)

				local var_302_17 = var_302_11.localEulerAngles

				var_302_17.z = 0
				var_302_17.x = 0
				var_302_11.localEulerAngles = var_302_17
			end

			if arg_299_1.time_ >= var_302_12 + var_302_13 and arg_299_1.time_ < var_302_12 + var_302_13 + arg_302_0 then
				var_302_11.localPosition = Vector3.New(0, 100, 0)

				local var_302_18 = manager.ui.mainCamera.transform.position - var_302_11.position

				var_302_11.forward = Vector3.New(var_302_18.x, var_302_18.y, var_302_18.z)

				local var_302_19 = var_302_11.localEulerAngles

				var_302_19.z = 0
				var_302_19.x = 0
				var_302_11.localEulerAngles = var_302_19
			end

			local var_302_20 = arg_299_1.actors_["6148ui_story"]
			local var_302_21 = 0

			if var_302_21 < arg_299_1.time_ and arg_299_1.time_ <= var_302_21 + arg_302_0 and not isNil(var_302_20) and arg_299_1.var_.characterEffect6148ui_story == nil then
				arg_299_1.var_.characterEffect6148ui_story = var_302_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_302_22 = 0.200000002980232

			if var_302_21 <= arg_299_1.time_ and arg_299_1.time_ < var_302_21 + var_302_22 and not isNil(var_302_20) then
				local var_302_23 = (arg_299_1.time_ - var_302_21) / var_302_22

				if arg_299_1.var_.characterEffect6148ui_story and not isNil(var_302_20) then
					arg_299_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_299_1.time_ >= var_302_21 + var_302_22 and arg_299_1.time_ < var_302_21 + var_302_22 + arg_302_0 and not isNil(var_302_20) and arg_299_1.var_.characterEffect6148ui_story then
				arg_299_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_302_24 = arg_299_1.actors_["1054ui_story"]
			local var_302_25 = 0

			if var_302_25 < arg_299_1.time_ and arg_299_1.time_ <= var_302_25 + arg_302_0 and not isNil(var_302_24) and arg_299_1.var_.characterEffect1054ui_story == nil then
				arg_299_1.var_.characterEffect1054ui_story = var_302_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_302_26 = 0.200000002980232

			if var_302_25 <= arg_299_1.time_ and arg_299_1.time_ < var_302_25 + var_302_26 and not isNil(var_302_24) then
				local var_302_27 = (arg_299_1.time_ - var_302_25) / var_302_26

				if arg_299_1.var_.characterEffect1054ui_story and not isNil(var_302_24) then
					local var_302_28 = Mathf.Lerp(0, 0.5, var_302_27)

					arg_299_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_299_1.var_.characterEffect1054ui_story.fillRatio = var_302_28
				end
			end

			if arg_299_1.time_ >= var_302_25 + var_302_26 and arg_299_1.time_ < var_302_25 + var_302_26 + arg_302_0 and not isNil(var_302_24) and arg_299_1.var_.characterEffect1054ui_story then
				local var_302_29 = 0.5

				arg_299_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_299_1.var_.characterEffect1054ui_story.fillRatio = var_302_29
			end

			local var_302_30 = 0

			if var_302_30 < arg_299_1.time_ and arg_299_1.time_ <= var_302_30 + arg_302_0 then
				arg_299_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action1_1")
			end

			local var_302_31 = 0

			if var_302_31 < arg_299_1.time_ and arg_299_1.time_ <= var_302_31 + arg_302_0 then
				arg_299_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_302_32 = 0
			local var_302_33 = 1.2

			if var_302_32 < arg_299_1.time_ and arg_299_1.time_ <= var_302_32 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0
				arg_299_1.dialogCg_.alpha = 1

				arg_299_1.dialog_:SetActive(true)
				SetActive(arg_299_1.leftNameGo_, true)

				local var_302_34 = arg_299_1:FormatText(StoryNameCfg[1488].name)

				arg_299_1.leftNameTxt_.text = var_302_34

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_299_1.leftNameTxt_.transform)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1.leftNameTxt_.text)
				SetActive(arg_299_1.iconTrs_.gameObject, false)
				arg_299_1.callingController_:SetSelectedState("normal")

				local var_302_35 = arg_299_1:GetWordFromCfg(939012073)
				local var_302_36 = arg_299_1:FormatText(var_302_35.content)

				arg_299_1.text_.text = var_302_36

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_37 = 48
				local var_302_38 = utf8.len(var_302_36)
				local var_302_39 = var_302_37 <= 0 and var_302_33 or var_302_33 * (var_302_38 / var_302_37)

				if var_302_39 > 0 and var_302_33 < var_302_39 then
					arg_299_1.talkMaxDuration = var_302_39

					if var_302_39 + var_302_32 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_39 + var_302_32
					end
				end

				arg_299_1.text_.text = var_302_36
				arg_299_1.typewritter.percent = 0

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(false)
				arg_299_1:RecordContent(arg_299_1.text_.text)
			end

			local var_302_40 = math.max(var_302_33, arg_299_1.talkMaxDuration)

			if var_302_32 <= arg_299_1.time_ and arg_299_1.time_ < var_302_32 + var_302_40 then
				arg_299_1.typewritter.percent = (arg_299_1.time_ - var_302_32) / var_302_40

				arg_299_1.typewritter:SetDirty()
			end

			if arg_299_1.time_ >= var_302_32 + var_302_40 and arg_299_1.time_ < var_302_32 + var_302_40 + arg_302_0 then
				arg_299_1.typewritter.percent = 1

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(true)
			end
		end

		arg_299_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1034ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_299_1:InitPlayNodeList()
	end,
	Play939012074 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 939012074
		arg_303_1.duration_ = 5

		SetActive(arg_303_1.tipsGo_, false)

		function arg_303_1.onSingleLineFinish_()
			arg_303_1.onSingleLineUpdate_ = nil
			arg_303_1.onSingleLineFinish_ = nil
			arg_303_1.state_ = "waiting"
		end

		function arg_303_1.playNext_(arg_305_0)
			if arg_305_0 == 1 then
				arg_303_0:Play939012075(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			local var_306_0 = arg_303_1.actors_["1012ui_story"].transform
			local var_306_1 = 0

			if var_306_1 < arg_303_1.time_ and arg_303_1.time_ <= var_306_1 + arg_306_0 then
				arg_303_1.var_.moveOldPos1012ui_story = var_306_0.localPosition
			end

			local var_306_2 = 0.001

			if var_306_1 <= arg_303_1.time_ and arg_303_1.time_ < var_306_1 + var_306_2 then
				local var_306_3 = (arg_303_1.time_ - var_306_1) / var_306_2
				local var_306_4 = Vector3.New(-0.7, -1.05, -6.24)

				var_306_0.localPosition = Vector3.Lerp(arg_303_1.var_.moveOldPos1012ui_story, var_306_4, var_306_3)

				local var_306_5 = manager.ui.mainCamera.transform.position - var_306_0.position

				var_306_0.forward = Vector3.New(var_306_5.x, var_306_5.y, var_306_5.z)

				local var_306_6 = var_306_0.localEulerAngles

				var_306_6.z = 0
				var_306_6.x = 0
				var_306_0.localEulerAngles = var_306_6
			end

			if arg_303_1.time_ >= var_306_1 + var_306_2 and arg_303_1.time_ < var_306_1 + var_306_2 + arg_306_0 then
				var_306_0.localPosition = Vector3.New(-0.7, -1.05, -6.24)

				local var_306_7 = manager.ui.mainCamera.transform.position - var_306_0.position

				var_306_0.forward = Vector3.New(var_306_7.x, var_306_7.y, var_306_7.z)

				local var_306_8 = var_306_0.localEulerAngles

				var_306_8.z = 0
				var_306_8.x = 0
				var_306_0.localEulerAngles = var_306_8
			end

			local var_306_9 = arg_303_1.actors_["1054ui_story"].transform
			local var_306_10 = 0

			if var_306_10 < arg_303_1.time_ and arg_303_1.time_ <= var_306_10 + arg_306_0 then
				arg_303_1.var_.moveOldPos1054ui_story = var_306_9.localPosition

				local var_306_11 = GameObjectTools.GetOrAddComponent(var_306_9.gameObject, typeof(DynamicBoneHelper))

				if var_306_11 then
					var_306_11:EnableDynamicBone(false)
				end
			end

			local var_306_12 = 0.001

			if var_306_10 <= arg_303_1.time_ and arg_303_1.time_ < var_306_10 + var_306_12 then
				local var_306_13 = (arg_303_1.time_ - var_306_10) / var_306_12
				local var_306_14 = Vector3.New(0, 100, 0)

				var_306_9.localPosition = Vector3.Lerp(arg_303_1.var_.moveOldPos1054ui_story, var_306_14, var_306_13)

				local var_306_15 = manager.ui.mainCamera.transform.position - var_306_9.position

				var_306_9.forward = Vector3.New(var_306_15.x, var_306_15.y, var_306_15.z)

				local var_306_16 = var_306_9.localEulerAngles

				var_306_16.z = 0
				var_306_16.x = 0
				var_306_9.localEulerAngles = var_306_16
			end

			if arg_303_1.time_ >= var_306_10 + var_306_12 and arg_303_1.time_ < var_306_10 + var_306_12 + arg_306_0 then
				var_306_9.localPosition = Vector3.New(0, 100, 0)

				local var_306_17 = manager.ui.mainCamera.transform.position - var_306_9.position

				var_306_9.forward = Vector3.New(var_306_17.x, var_306_17.y, var_306_17.z)

				local var_306_18 = var_306_9.localEulerAngles

				var_306_18.z = 0
				var_306_18.x = 0
				var_306_9.localEulerAngles = var_306_18

				local var_306_19 = GameObjectTools.GetOrAddComponent(var_306_9.gameObject, typeof(DynamicBoneHelper))

				if var_306_19 then
					var_306_19:EnableDynamicBone(true)
				end
			end

			local var_306_20 = arg_303_1.actors_["1012ui_story"]
			local var_306_21 = 0

			if var_306_21 < arg_303_1.time_ and arg_303_1.time_ <= var_306_21 + arg_306_0 and not isNil(var_306_20) and arg_303_1.var_.characterEffect1012ui_story == nil then
				arg_303_1.var_.characterEffect1012ui_story = var_306_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_306_22 = 0.200000002980232

			if var_306_21 <= arg_303_1.time_ and arg_303_1.time_ < var_306_21 + var_306_22 and not isNil(var_306_20) then
				local var_306_23 = (arg_303_1.time_ - var_306_21) / var_306_22

				if arg_303_1.var_.characterEffect1012ui_story and not isNil(var_306_20) then
					arg_303_1.var_.characterEffect1012ui_story.fillFlat = false
				end
			end

			if arg_303_1.time_ >= var_306_21 + var_306_22 and arg_303_1.time_ < var_306_21 + var_306_22 + arg_306_0 and not isNil(var_306_20) and arg_303_1.var_.characterEffect1012ui_story then
				arg_303_1.var_.characterEffect1012ui_story.fillFlat = false
			end

			local var_306_24 = arg_303_1.actors_["6148ui_story"]
			local var_306_25 = 0

			if var_306_25 < arg_303_1.time_ and arg_303_1.time_ <= var_306_25 + arg_306_0 and not isNil(var_306_24) and arg_303_1.var_.characterEffect6148ui_story == nil then
				arg_303_1.var_.characterEffect6148ui_story = var_306_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_306_26 = 0.200000002980232

			if var_306_25 <= arg_303_1.time_ and arg_303_1.time_ < var_306_25 + var_306_26 and not isNil(var_306_24) then
				local var_306_27 = (arg_303_1.time_ - var_306_25) / var_306_26

				if arg_303_1.var_.characterEffect6148ui_story and not isNil(var_306_24) then
					local var_306_28 = Mathf.Lerp(0, 0.5, var_306_27)

					arg_303_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_303_1.var_.characterEffect6148ui_story.fillRatio = var_306_28
				end
			end

			if arg_303_1.time_ >= var_306_25 + var_306_26 and arg_303_1.time_ < var_306_25 + var_306_26 + arg_306_0 and not isNil(var_306_24) and arg_303_1.var_.characterEffect6148ui_story then
				local var_306_29 = 0.5

				arg_303_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_303_1.var_.characterEffect6148ui_story.fillRatio = var_306_29
			end

			local var_306_30 = 0

			if var_306_30 < arg_303_1.time_ and arg_303_1.time_ <= var_306_30 + arg_306_0 then
				arg_303_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/story1012/story1012action/1012action1_1")
			end

			local var_306_31 = 0

			if var_306_31 < arg_303_1.time_ and arg_303_1.time_ <= var_306_31 + arg_306_0 then
				arg_303_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_306_32 = 0
			local var_306_33 = 0.3

			if var_306_32 < arg_303_1.time_ and arg_303_1.time_ <= var_306_32 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, true)

				local var_306_34 = arg_303_1:FormatText(StoryNameCfg[595].name)

				arg_303_1.leftNameTxt_.text = var_306_34

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_303_1.leftNameTxt_.transform)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1.leftNameTxt_.text)
				SetActive(arg_303_1.iconTrs_.gameObject, false)
				arg_303_1.callingController_:SetSelectedState("normal")

				local var_306_35 = arg_303_1:GetWordFromCfg(939012074)
				local var_306_36 = arg_303_1:FormatText(var_306_35.content)

				arg_303_1.text_.text = var_306_36

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_37 = 12
				local var_306_38 = utf8.len(var_306_36)
				local var_306_39 = var_306_37 <= 0 and var_306_33 or var_306_33 * (var_306_38 / var_306_37)

				if var_306_39 > 0 and var_306_33 < var_306_39 then
					arg_303_1.talkMaxDuration = var_306_39

					if var_306_39 + var_306_32 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_39 + var_306_32
					end
				end

				arg_303_1.text_.text = var_306_36
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)
				arg_303_1:RecordContent(arg_303_1.text_.text)
			end

			local var_306_40 = math.max(var_306_33, arg_303_1.talkMaxDuration)

			if var_306_32 <= arg_303_1.time_ and arg_303_1.time_ < var_306_32 + var_306_40 then
				arg_303_1.typewritter.percent = (arg_303_1.time_ - var_306_32) / var_306_40

				arg_303_1.typewritter:SetDirty()
			end

			if arg_303_1.time_ >= var_306_32 + var_306_40 and arg_303_1.time_ < var_306_32 + var_306_40 + arg_306_0 then
				arg_303_1.typewritter.percent = 1

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(true)
			end
		end

		arg_303_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_303_1:InitPlayNodeList()
	end,
	Play939012075 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 939012075
		arg_307_1.duration_ = 5

		SetActive(arg_307_1.tipsGo_, false)

		function arg_307_1.onSingleLineFinish_()
			arg_307_1.onSingleLineUpdate_ = nil
			arg_307_1.onSingleLineFinish_ = nil
			arg_307_1.state_ = "waiting"
		end

		function arg_307_1.playNext_(arg_309_0)
			if arg_309_0 == 1 then
				arg_307_0:Play939012076(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			local var_310_0 = arg_307_1.actors_["1012ui_story"]
			local var_310_1 = 0

			if var_310_1 < arg_307_1.time_ and arg_307_1.time_ <= var_310_1 + arg_310_0 and not isNil(var_310_0) and arg_307_1.var_.characterEffect1012ui_story == nil then
				arg_307_1.var_.characterEffect1012ui_story = var_310_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_310_2 = 0.200000002980232

			if var_310_1 <= arg_307_1.time_ and arg_307_1.time_ < var_310_1 + var_310_2 and not isNil(var_310_0) then
				local var_310_3 = (arg_307_1.time_ - var_310_1) / var_310_2

				if arg_307_1.var_.characterEffect1012ui_story and not isNil(var_310_0) then
					local var_310_4 = Mathf.Lerp(0, 0.5, var_310_3)

					arg_307_1.var_.characterEffect1012ui_story.fillFlat = true
					arg_307_1.var_.characterEffect1012ui_story.fillRatio = var_310_4
				end
			end

			if arg_307_1.time_ >= var_310_1 + var_310_2 and arg_307_1.time_ < var_310_1 + var_310_2 + arg_310_0 and not isNil(var_310_0) and arg_307_1.var_.characterEffect1012ui_story then
				local var_310_5 = 0.5

				arg_307_1.var_.characterEffect1012ui_story.fillFlat = true
				arg_307_1.var_.characterEffect1012ui_story.fillRatio = var_310_5
			end

			local var_310_6 = 0
			local var_310_7 = 0.775

			if var_310_6 < arg_307_1.time_ and arg_307_1.time_ <= var_310_6 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0
				arg_307_1.dialogCg_.alpha = 1

				arg_307_1.dialog_:SetActive(true)
				SetActive(arg_307_1.leftNameGo_, true)

				local var_310_8 = arg_307_1:FormatText(StoryNameCfg[7].name)

				arg_307_1.leftNameTxt_.text = var_310_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_307_1.leftNameTxt_.transform)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1.leftNameTxt_.text)
				SetActive(arg_307_1.iconTrs_.gameObject, true)
				arg_307_1.iconController_:SetSelectedState("hero")

				arg_307_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_307_1.callingController_:SetSelectedState("normal")

				arg_307_1.keyicon_.color = Color.New(1, 1, 1)
				arg_307_1.icon_.color = Color.New(1, 1, 1)

				local var_310_9 = arg_307_1:GetWordFromCfg(939012075)
				local var_310_10 = arg_307_1:FormatText(var_310_9.content)

				arg_307_1.text_.text = var_310_10

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_11 = 31
				local var_310_12 = utf8.len(var_310_10)
				local var_310_13 = var_310_11 <= 0 and var_310_7 or var_310_7 * (var_310_12 / var_310_11)

				if var_310_13 > 0 and var_310_7 < var_310_13 then
					arg_307_1.talkMaxDuration = var_310_13

					if var_310_13 + var_310_6 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_13 + var_310_6
					end
				end

				arg_307_1.text_.text = var_310_10
				arg_307_1.typewritter.percent = 0

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(false)
				arg_307_1:RecordContent(arg_307_1.text_.text)
			end

			local var_310_14 = math.max(var_310_7, arg_307_1.talkMaxDuration)

			if var_310_6 <= arg_307_1.time_ and arg_307_1.time_ < var_310_6 + var_310_14 then
				arg_307_1.typewritter.percent = (arg_307_1.time_ - var_310_6) / var_310_14

				arg_307_1.typewritter:SetDirty()
			end

			if arg_307_1.time_ >= var_310_6 + var_310_14 and arg_307_1.time_ < var_310_6 + var_310_14 + arg_310_0 then
				arg_307_1.typewritter.percent = 1

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(true)
			end
		end

		arg_307_1.nodeConfigList_ = {}

		arg_307_1:InitPlayNodeList()
	end,
	Play939012076 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 939012076
		arg_311_1.duration_ = 5

		SetActive(arg_311_1.tipsGo_, false)

		function arg_311_1.onSingleLineFinish_()
			arg_311_1.onSingleLineUpdate_ = nil
			arg_311_1.onSingleLineFinish_ = nil
			arg_311_1.state_ = "waiting"
		end

		function arg_311_1.playNext_(arg_313_0)
			if arg_313_0 == 1 then
				arg_311_0:Play939012077(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			local var_314_0 = 0
			local var_314_1 = 0.75

			if var_314_0 < arg_311_1.time_ and arg_311_1.time_ <= var_314_0 + arg_314_0 then
				arg_311_1.talkMaxDuration = 0
				arg_311_1.dialogCg_.alpha = 1

				arg_311_1.dialog_:SetActive(true)
				SetActive(arg_311_1.leftNameGo_, false)

				arg_311_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_311_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_311_1:RecordName(arg_311_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_311_1.iconTrs_.gameObject, false)
				arg_311_1.callingController_:SetSelectedState("normal")

				local var_314_2 = arg_311_1:GetWordFromCfg(939012076)
				local var_314_3 = arg_311_1:FormatText(var_314_2.content)

				arg_311_1.text_.text = var_314_3

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_4 = 30
				local var_314_5 = utf8.len(var_314_3)
				local var_314_6 = var_314_4 <= 0 and var_314_1 or var_314_1 * (var_314_5 / var_314_4)

				if var_314_6 > 0 and var_314_1 < var_314_6 then
					arg_311_1.talkMaxDuration = var_314_6

					if var_314_6 + var_314_0 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_6 + var_314_0
					end
				end

				arg_311_1.text_.text = var_314_3
				arg_311_1.typewritter.percent = 0

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(false)
				arg_311_1:RecordContent(arg_311_1.text_.text)
			end

			local var_314_7 = math.max(var_314_1, arg_311_1.talkMaxDuration)

			if var_314_0 <= arg_311_1.time_ and arg_311_1.time_ < var_314_0 + var_314_7 then
				arg_311_1.typewritter.percent = (arg_311_1.time_ - var_314_0) / var_314_7

				arg_311_1.typewritter:SetDirty()
			end

			if arg_311_1.time_ >= var_314_0 + var_314_7 and arg_311_1.time_ < var_314_0 + var_314_7 + arg_314_0 then
				arg_311_1.typewritter.percent = 1

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(true)
			end
		end

		arg_311_1.nodeConfigList_ = {}

		arg_311_1:InitPlayNodeList()
	end,
	Play939012077 = function(arg_315_0, arg_315_1)
		arg_315_1.time_ = 0
		arg_315_1.frameCnt_ = 0
		arg_315_1.state_ = "playing"
		arg_315_1.curTalkId_ = 939012077
		arg_315_1.duration_ = 5

		SetActive(arg_315_1.tipsGo_, false)

		function arg_315_1.onSingleLineFinish_()
			arg_315_1.onSingleLineUpdate_ = nil
			arg_315_1.onSingleLineFinish_ = nil
			arg_315_1.state_ = "waiting"
			arg_315_1.auto_ = false
		end

		function arg_315_1.playNext_(arg_317_0)
			arg_315_1.onStoryFinished_()
		end

		function arg_315_1.onSingleLineUpdate_(arg_318_0)
			local var_318_0 = 0
			local var_318_1 = 5

			if var_318_0 < arg_315_1.time_ and arg_315_1.time_ <= var_318_0 + arg_318_0 then
				local var_318_2 = "1"

				arg_315_1.marker = "luntantiezi2"

				if not arg_315_1.actionList["1"] then
					arg_315_1.actionList["1"] = StoryInteractionRogueCardForumGame.New(arg_315_1, "Widget/System/Activity_JokerCard/Activity_JokerCard_ForunPopUI")
				end

				arg_315_1.actionList["1"]:SetData({
					hideOnEndGame = false,
					type = 2,
					postId = 201,
					enterClipName = "",
					completeShowStoryUI = false,
					isNeedInteraction = true,
					uiBtnName = "postBtn_",
					enterHideStoryUI = true,
					completeClipName = "",
					enterController = {},
					completeController = {}
				})
			end
		end

		arg_315_1.nodeConfigList_ = {}

		arg_315_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/I05a"
	},
	voices = {},
	skipMarkers = {
		939012077
	}
}
