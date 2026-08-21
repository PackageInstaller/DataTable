return {
	Play1107505001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 1107505001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play1107505002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "ST32"

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
				local var_4_5 = arg_1_1.bgs_.ST32

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
					if iter_4_0 ~= "ST32" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = 1.999999999999

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

			local var_4_24 = arg_1_1.actors_.ui_story
			local var_4_25 = 1.999999999999

			if var_4_25 < arg_1_1.time_ and arg_1_1.time_ <= var_4_25 + arg_4_0 and not isNil(var_4_24) and arg_1_1.var_.characterEffectui_story == nil then
				arg_1_1.var_.characterEffectui_story = var_4_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_26 = 0.200000002980232

			if var_4_25 <= arg_1_1.time_ and arg_1_1.time_ < var_4_25 + var_4_26 and not isNil(var_4_24) then
				local var_4_27 = (arg_1_1.time_ - var_4_25) / var_4_26

				if arg_1_1.var_.characterEffectui_story and not isNil(var_4_24) then
					arg_1_1.var_.characterEffectui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= var_4_25 + var_4_26 and arg_1_1.time_ < var_4_25 + var_4_26 + arg_4_0 and not isNil(var_4_24) and arg_1_1.var_.characterEffectui_story then
				arg_1_1.var_.characterEffectui_story.fillFlat = false
			end

			local var_4_28 = 0
			local var_4_29 = 0.616666666666667

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				local var_4_30 = "play"
				local var_4_31 = "music"

				arg_1_1:AudioAction(var_4_30, var_4_31, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_32 = ""
				local var_4_33 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_33 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_33 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_33

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_33
						arg_1_1.bgmTxt2_.text = var_4_33
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

			local var_4_34 = 0.8
			local var_4_35 = 1

			if var_4_34 < arg_1_1.time_ and arg_1_1.time_ <= var_4_34 + arg_4_0 then
				local var_4_36 = "play"
				local var_4_37 = "music"

				arg_1_1:AudioAction(var_4_36, var_4_37, "bgm_activity_2_1_story_sifangyuan", "bgm_activity_2_1_story_sifangyuan", "bgm_activity_2_1_story_sifangyuan.awb")

				local var_4_38 = ""
				local var_4_39 = manager.audio:GetAudioName("bgm_activity_2_1_story_sifangyuan", "bgm_activity_2_1_story_sifangyuan")

				if var_4_39 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_39 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_39

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_39
						arg_1_1.bgmTxt2_.text = var_4_39
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

			local var_4_40 = 2.05398989934474
			local var_4_41 = 1

			if var_4_40 < arg_1_1.time_ and arg_1_1.time_ <= var_4_40 + arg_4_0 then
				local var_4_42 = "play"
				local var_4_43 = "effect"

				arg_1_1:AudioAction(var_4_42, var_4_43, "se_story_1310", "se_story_1310_tea", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_44 = 1.999999999999
			local var_4_45 = 1.225

			if var_4_44 < arg_1_1.time_ and arg_1_1.time_ <= var_4_44 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_46 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_46:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_46:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_46:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_47 = arg_1_1:GetWordFromCfg(1107505001)
				local var_4_48 = arg_1_1:FormatText(var_4_47.content)

				arg_1_1.text_.text = var_4_48

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_49 = 49
				local var_4_50 = utf8.len(var_4_48)
				local var_4_51 = var_4_49 <= 0 and var_4_45 or var_4_45 * (var_4_50 / var_4_49)

				if var_4_51 > 0 and var_4_45 < var_4_51 then
					arg_1_1.talkMaxDuration = var_4_51
					var_4_44 = var_4_44 + 0.3

					if var_4_51 + var_4_44 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_51 + var_4_44
					end
				end

				arg_1_1.text_.text = var_4_48
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_52 = var_4_44 + 0.3
			local var_4_53 = math.max(var_4_45, arg_1_1.talkMaxDuration)

			if var_4_52 <= arg_1_1.time_ and arg_1_1.time_ < var_4_52 + var_4_53 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_52) / var_4_53

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_52 + var_4_53 and arg_1_1.time_ < var_4_52 + var_4_53 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play1107505002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 1107505002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play1107505003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0
			local var_12_1 = 0.625

			if var_12_0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_2 = arg_9_1:FormatText(StoryNameCfg[7].name)

				arg_9_1.leftNameTxt_.text = var_12_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, true)
				arg_9_1.iconController_:SetSelectedState("hero")

				arg_9_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_9_1.callingController_:SetSelectedState("normal")

				arg_9_1.keyicon_.color = Color.New(1, 1, 1)
				arg_9_1.icon_.color = Color.New(1, 1, 1)

				local var_12_3 = arg_9_1:GetWordFromCfg(1107505002)
				local var_12_4 = arg_9_1:FormatText(var_12_3.content)

				arg_9_1.text_.text = var_12_4

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_5 = 25
				local var_12_6 = utf8.len(var_12_4)
				local var_12_7 = var_12_5 <= 0 and var_12_1 or var_12_1 * (var_12_6 / var_12_5)

				if var_12_7 > 0 and var_12_1 < var_12_7 then
					arg_9_1.talkMaxDuration = var_12_7

					if var_12_7 + var_12_0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_7 + var_12_0
					end
				end

				arg_9_1.text_.text = var_12_4
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_8 = math.max(var_12_1, arg_9_1.talkMaxDuration)

			if var_12_0 <= arg_9_1.time_ and arg_9_1.time_ < var_12_0 + var_12_8 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_0) / var_12_8

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_0 + var_12_8 and arg_9_1.time_ < var_12_0 + var_12_8 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play1107505003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 1107505003
		arg_13_1.duration_ = 6.57

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play1107505004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = "1075ui_actor"

			if arg_13_1.actors_[var_16_0] == nil then
				local var_16_1 = Asset.Load("Char/" .. "1075ui_actor")

				if not isNil(var_16_1) then
					local var_16_2 = Object.Instantiate(Asset.Load("Char/" .. "1075ui_actor"), arg_13_1.stage_.transform)

					var_16_2.name = var_16_0
					var_16_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_13_1.actors_[var_16_0] = var_16_2

					local var_16_3 = var_16_2:GetComponentInChildren(typeof(CharacterEffect))

					var_16_3.enabled = true

					local var_16_4 = GameObjectTools.GetOrAddComponent(var_16_2, typeof(DynamicBoneHelper))

					if var_16_4 then
						var_16_4:EnableDynamicBone(false)
					end

					arg_13_1:ShowWeapon(var_16_3.transform, false)

					arg_13_1.var_[var_16_0 .. "Animator"] = var_16_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_13_1.var_[var_16_0 .. "Animator"].applyRootMotion = true
					arg_13_1.var_[var_16_0 .. "LipSync"] = var_16_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_16_5 = arg_13_1.actors_["1075ui_actor"].transform
			local var_16_6 = 0

			if var_16_6 < arg_13_1.time_ and arg_13_1.time_ <= var_16_6 + arg_16_0 then
				arg_13_1.var_.moveOldPos1075ui_actor = var_16_5.localPosition

				local var_16_7 = GameObjectTools.GetOrAddComponent(var_16_5.gameObject, typeof(DynamicBoneHelper))

				if var_16_7 then
					var_16_7:EnableDynamicBone(false)
				end
			end

			local var_16_8 = 0.001

			if var_16_6 <= arg_13_1.time_ and arg_13_1.time_ < var_16_6 + var_16_8 then
				local var_16_9 = (arg_13_1.time_ - var_16_6) / var_16_8
				local var_16_10 = Vector3.New(0, -1.055, -6.16)

				var_16_5.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1075ui_actor, var_16_10, var_16_9)

				local var_16_11 = manager.ui.mainCamera.transform.position - var_16_5.position

				var_16_5.forward = Vector3.New(var_16_11.x, var_16_11.y, var_16_11.z)

				local var_16_12 = var_16_5.localEulerAngles

				var_16_12.z = 0
				var_16_12.x = 0
				var_16_5.localEulerAngles = var_16_12
			end

			if arg_13_1.time_ >= var_16_6 + var_16_8 and arg_13_1.time_ < var_16_6 + var_16_8 + arg_16_0 then
				var_16_5.localPosition = Vector3.New(0, -1.055, -6.16)

				local var_16_13 = manager.ui.mainCamera.transform.position - var_16_5.position

				var_16_5.forward = Vector3.New(var_16_13.x, var_16_13.y, var_16_13.z)

				local var_16_14 = var_16_5.localEulerAngles

				var_16_14.z = 0
				var_16_14.x = 0
				var_16_5.localEulerAngles = var_16_14

				local var_16_15 = GameObjectTools.GetOrAddComponent(var_16_5.gameObject, typeof(DynamicBoneHelper))

				if var_16_15 then
					var_16_15:EnableDynamicBone(true)
				end
			end

			local var_16_16 = arg_13_1.actors_["1075ui_actor"]
			local var_16_17 = 0

			if var_16_17 < arg_13_1.time_ and arg_13_1.time_ <= var_16_17 + arg_16_0 and not isNil(var_16_16) and arg_13_1.var_.characterEffect1075ui_actor == nil then
				arg_13_1.var_.characterEffect1075ui_actor = var_16_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_18 = 0.200000002980232

			if var_16_17 <= arg_13_1.time_ and arg_13_1.time_ < var_16_17 + var_16_18 and not isNil(var_16_16) then
				local var_16_19 = (arg_13_1.time_ - var_16_17) / var_16_18

				if arg_13_1.var_.characterEffect1075ui_actor and not isNil(var_16_16) then
					arg_13_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_13_1.time_ >= var_16_17 + var_16_18 and arg_13_1.time_ < var_16_17 + var_16_18 + arg_16_0 and not isNil(var_16_16) and arg_13_1.var_.characterEffect1075ui_actor then
				arg_13_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			local var_16_20 = 0

			if var_16_20 < arg_13_1.time_ and arg_13_1.time_ <= var_16_20 + arg_16_0 then
				arg_13_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075action/1075action5_1")
			end

			local var_16_21 = 0

			if var_16_21 < arg_13_1.time_ and arg_13_1.time_ <= var_16_21 + arg_16_0 then
				arg_13_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_16_22 = 0
			local var_16_23 = 0.675

			if var_16_22 < arg_13_1.time_ and arg_13_1.time_ <= var_16_22 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_24 = arg_13_1:FormatText(StoryNameCfg[381].name)

				arg_13_1.leftNameTxt_.text = var_16_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_25 = arg_13_1:GetWordFromCfg(1107505003)
				local var_16_26 = arg_13_1:FormatText(var_16_25.content)

				arg_13_1.text_.text = var_16_26

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_27 = 27
				local var_16_28 = utf8.len(var_16_26)
				local var_16_29 = var_16_27 <= 0 and var_16_23 or var_16_23 * (var_16_28 / var_16_27)

				if var_16_29 > 0 and var_16_23 < var_16_29 then
					arg_13_1.talkMaxDuration = var_16_29

					if var_16_29 + var_16_22 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_29 + var_16_22
					end
				end

				arg_13_1.text_.text = var_16_26
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107505", "1107505003", "story_v_side_new_1107505.awb") ~= 0 then
					local var_16_30 = manager.audio:GetVoiceLength("story_v_side_new_1107505", "1107505003", "story_v_side_new_1107505.awb") / 1000

					if var_16_30 + var_16_22 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_30 + var_16_22
					end

					if var_16_25.prefab_name ~= "" and arg_13_1.actors_[var_16_25.prefab_name] ~= nil then
						local var_16_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_25.prefab_name].transform, "story_v_side_new_1107505", "1107505003", "story_v_side_new_1107505.awb")

						arg_13_1:RecordAudio("1107505003", var_16_31)
						arg_13_1:RecordAudio("1107505003", var_16_31)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_side_new_1107505", "1107505003", "story_v_side_new_1107505.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_side_new_1107505", "1107505003", "story_v_side_new_1107505.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_32 = math.max(var_16_23, arg_13_1.talkMaxDuration)

			if var_16_22 <= arg_13_1.time_ and arg_13_1.time_ < var_16_22 + var_16_32 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_22) / var_16_32

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_22 + var_16_32 and arg_13_1.time_ < var_16_22 + var_16_32 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_actor",
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
	Play1107505004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 1107505004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play1107505005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = arg_17_1.actors_["1075ui_actor"].transform
			local var_20_1 = 0

			if var_20_1 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 then
				arg_17_1.var_.moveOldPos1075ui_actor = var_20_0.localPosition

				local var_20_2 = GameObjectTools.GetOrAddComponent(var_20_0.gameObject, typeof(DynamicBoneHelper))

				if var_20_2 then
					var_20_2:EnableDynamicBone(false)
				end
			end

			local var_20_3 = 0.001

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_3 then
				local var_20_4 = (arg_17_1.time_ - var_20_1) / var_20_3
				local var_20_5 = Vector3.New(0, 100, 0)

				var_20_0.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1075ui_actor, var_20_5, var_20_4)

				local var_20_6 = manager.ui.mainCamera.transform.position - var_20_0.position

				var_20_0.forward = Vector3.New(var_20_6.x, var_20_6.y, var_20_6.z)

				local var_20_7 = var_20_0.localEulerAngles

				var_20_7.z = 0
				var_20_7.x = 0
				var_20_0.localEulerAngles = var_20_7
			end

			if arg_17_1.time_ >= var_20_1 + var_20_3 and arg_17_1.time_ < var_20_1 + var_20_3 + arg_20_0 then
				var_20_0.localPosition = Vector3.New(0, 100, 0)

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

			local var_20_11 = arg_17_1.actors_["1075ui_actor"]
			local var_20_12 = 0

			if var_20_12 < arg_17_1.time_ and arg_17_1.time_ <= var_20_12 + arg_20_0 and not isNil(var_20_11) and arg_17_1.var_.characterEffect1075ui_actor == nil then
				arg_17_1.var_.characterEffect1075ui_actor = var_20_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_13 = 0.200000002980232

			if var_20_12 <= arg_17_1.time_ and arg_17_1.time_ < var_20_12 + var_20_13 and not isNil(var_20_11) then
				local var_20_14 = (arg_17_1.time_ - var_20_12) / var_20_13

				if arg_17_1.var_.characterEffect1075ui_actor and not isNil(var_20_11) then
					local var_20_15 = Mathf.Lerp(0, 0.5, var_20_14)

					arg_17_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_17_1.var_.characterEffect1075ui_actor.fillRatio = var_20_15
				end
			end

			if arg_17_1.time_ >= var_20_12 + var_20_13 and arg_17_1.time_ < var_20_12 + var_20_13 + arg_20_0 and not isNil(var_20_11) and arg_17_1.var_.characterEffect1075ui_actor then
				local var_20_16 = 0.5

				arg_17_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_17_1.var_.characterEffect1075ui_actor.fillRatio = var_20_16
			end

			local var_20_17 = 0
			local var_20_18 = 0.725

			if var_20_17 < arg_17_1.time_ and arg_17_1.time_ <= var_20_17 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, false)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_19 = arg_17_1:GetWordFromCfg(1107505004)
				local var_20_20 = arg_17_1:FormatText(var_20_19.content)

				arg_17_1.text_.text = var_20_20

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_21 = 29
				local var_20_22 = utf8.len(var_20_20)
				local var_20_23 = var_20_21 <= 0 and var_20_18 or var_20_18 * (var_20_22 / var_20_21)

				if var_20_23 > 0 and var_20_18 < var_20_23 then
					arg_17_1.talkMaxDuration = var_20_23

					if var_20_23 + var_20_17 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_23 + var_20_17
					end
				end

				arg_17_1.text_.text = var_20_20
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_24 = math.max(var_20_18, arg_17_1.talkMaxDuration)

			if var_20_17 <= arg_17_1.time_ and arg_17_1.time_ < var_20_17 + var_20_24 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_17) / var_20_24

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_17 + var_20_24 and arg_17_1.time_ < var_20_17 + var_20_24 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_actor",
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
	Play1107505005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 1107505005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play1107505006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0
			local var_24_1 = 0.625

			if var_24_0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_0 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, false)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_2 = arg_21_1:GetWordFromCfg(1107505005)
				local var_24_3 = arg_21_1:FormatText(var_24_2.content)

				arg_21_1.text_.text = var_24_3

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_4 = 25
				local var_24_5 = utf8.len(var_24_3)
				local var_24_6 = var_24_4 <= 0 and var_24_1 or var_24_1 * (var_24_5 / var_24_4)

				if var_24_6 > 0 and var_24_1 < var_24_6 then
					arg_21_1.talkMaxDuration = var_24_6

					if var_24_6 + var_24_0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_6 + var_24_0
					end
				end

				arg_21_1.text_.text = var_24_3
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_7 = math.max(var_24_1, arg_21_1.talkMaxDuration)

			if var_24_0 <= arg_21_1.time_ and arg_21_1.time_ < var_24_0 + var_24_7 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_0) / var_24_7

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_0 + var_24_7 and arg_21_1.time_ < var_24_0 + var_24_7 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play1107505006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 1107505006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play1107505007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0
			local var_28_1 = 0.45

			if var_28_0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_0 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_2 = arg_25_1:FormatText(StoryNameCfg[7].name)

				arg_25_1.leftNameTxt_.text = var_28_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, true)
				arg_25_1.iconController_:SetSelectedState("hero")

				arg_25_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_25_1.callingController_:SetSelectedState("normal")

				arg_25_1.keyicon_.color = Color.New(1, 1, 1)
				arg_25_1.icon_.color = Color.New(1, 1, 1)

				local var_28_3 = arg_25_1:GetWordFromCfg(1107505006)
				local var_28_4 = arg_25_1:FormatText(var_28_3.content)

				arg_25_1.text_.text = var_28_4

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_5 = 18
				local var_28_6 = utf8.len(var_28_4)
				local var_28_7 = var_28_5 <= 0 and var_28_1 or var_28_1 * (var_28_6 / var_28_5)

				if var_28_7 > 0 and var_28_1 < var_28_7 then
					arg_25_1.talkMaxDuration = var_28_7

					if var_28_7 + var_28_0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_7 + var_28_0
					end
				end

				arg_25_1.text_.text = var_28_4
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_8 = math.max(var_28_1, arg_25_1.talkMaxDuration)

			if var_28_0 <= arg_25_1.time_ and arg_25_1.time_ < var_28_0 + var_28_8 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_0) / var_28_8

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_0 + var_28_8 and arg_25_1.time_ < var_28_0 + var_28_8 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play1107505007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 1107505007
		arg_29_1.duration_ = 4.13

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play1107505008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = arg_29_1.actors_["1075ui_actor"].transform
			local var_32_1 = 0

			if var_32_1 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 then
				arg_29_1.var_.moveOldPos1075ui_actor = var_32_0.localPosition

				local var_32_2 = GameObjectTools.GetOrAddComponent(var_32_0.gameObject, typeof(DynamicBoneHelper))

				if var_32_2 then
					var_32_2:EnableDynamicBone(false)
				end
			end

			local var_32_3 = 0.001

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_3 then
				local var_32_4 = (arg_29_1.time_ - var_32_1) / var_32_3
				local var_32_5 = Vector3.New(0, -1.055, -6.16)

				var_32_0.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos1075ui_actor, var_32_5, var_32_4)

				local var_32_6 = manager.ui.mainCamera.transform.position - var_32_0.position

				var_32_0.forward = Vector3.New(var_32_6.x, var_32_6.y, var_32_6.z)

				local var_32_7 = var_32_0.localEulerAngles

				var_32_7.z = 0
				var_32_7.x = 0
				var_32_0.localEulerAngles = var_32_7
			end

			if arg_29_1.time_ >= var_32_1 + var_32_3 and arg_29_1.time_ < var_32_1 + var_32_3 + arg_32_0 then
				var_32_0.localPosition = Vector3.New(0, -1.055, -6.16)

				local var_32_8 = manager.ui.mainCamera.transform.position - var_32_0.position

				var_32_0.forward = Vector3.New(var_32_8.x, var_32_8.y, var_32_8.z)

				local var_32_9 = var_32_0.localEulerAngles

				var_32_9.z = 0
				var_32_9.x = 0
				var_32_0.localEulerAngles = var_32_9

				local var_32_10 = GameObjectTools.GetOrAddComponent(var_32_0.gameObject, typeof(DynamicBoneHelper))

				if var_32_10 then
					var_32_10:EnableDynamicBone(true)
				end
			end

			local var_32_11 = arg_29_1.actors_["1075ui_actor"]
			local var_32_12 = 0

			if var_32_12 < arg_29_1.time_ and arg_29_1.time_ <= var_32_12 + arg_32_0 and not isNil(var_32_11) and arg_29_1.var_.characterEffect1075ui_actor == nil then
				arg_29_1.var_.characterEffect1075ui_actor = var_32_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_13 = 0.200000002980232

			if var_32_12 <= arg_29_1.time_ and arg_29_1.time_ < var_32_12 + var_32_13 and not isNil(var_32_11) then
				local var_32_14 = (arg_29_1.time_ - var_32_12) / var_32_13

				if arg_29_1.var_.characterEffect1075ui_actor and not isNil(var_32_11) then
					arg_29_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_29_1.time_ >= var_32_12 + var_32_13 and arg_29_1.time_ < var_32_12 + var_32_13 + arg_32_0 and not isNil(var_32_11) and arg_29_1.var_.characterEffect1075ui_actor then
				arg_29_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			local var_32_15 = 0

			if var_32_15 < arg_29_1.time_ and arg_29_1.time_ <= var_32_15 + arg_32_0 then
				arg_29_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075action/1075action5_2")
			end

			local var_32_16 = 0

			if var_32_16 < arg_29_1.time_ and arg_29_1.time_ <= var_32_16 + arg_32_0 then
				arg_29_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_32_17 = 0
			local var_32_18 = 0.425

			if var_32_17 < arg_29_1.time_ and arg_29_1.time_ <= var_32_17 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_19 = arg_29_1:FormatText(StoryNameCfg[381].name)

				arg_29_1.leftNameTxt_.text = var_32_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_20 = arg_29_1:GetWordFromCfg(1107505007)
				local var_32_21 = arg_29_1:FormatText(var_32_20.content)

				arg_29_1.text_.text = var_32_21

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_22 = 17
				local var_32_23 = utf8.len(var_32_21)
				local var_32_24 = var_32_22 <= 0 and var_32_18 or var_32_18 * (var_32_23 / var_32_22)

				if var_32_24 > 0 and var_32_18 < var_32_24 then
					arg_29_1.talkMaxDuration = var_32_24

					if var_32_24 + var_32_17 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_24 + var_32_17
					end
				end

				arg_29_1.text_.text = var_32_21
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107505", "1107505007", "story_v_side_new_1107505.awb") ~= 0 then
					local var_32_25 = manager.audio:GetVoiceLength("story_v_side_new_1107505", "1107505007", "story_v_side_new_1107505.awb") / 1000

					if var_32_25 + var_32_17 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_25 + var_32_17
					end

					if var_32_20.prefab_name ~= "" and arg_29_1.actors_[var_32_20.prefab_name] ~= nil then
						local var_32_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_20.prefab_name].transform, "story_v_side_new_1107505", "1107505007", "story_v_side_new_1107505.awb")

						arg_29_1:RecordAudio("1107505007", var_32_26)
						arg_29_1:RecordAudio("1107505007", var_32_26)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_side_new_1107505", "1107505007", "story_v_side_new_1107505.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_side_new_1107505", "1107505007", "story_v_side_new_1107505.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_27 = math.max(var_32_18, arg_29_1.talkMaxDuration)

			if var_32_17 <= arg_29_1.time_ and arg_29_1.time_ < var_32_17 + var_32_27 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_17) / var_32_27

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_17 + var_32_27 and arg_29_1.time_ < var_32_17 + var_32_27 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_actor",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_29_1:InitPlayNodeList()
	end,
	Play1107505008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 1107505008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play1107505009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = arg_33_1.actors_["1075ui_actor"]
			local var_36_1 = 0

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.characterEffect1075ui_actor == nil then
				arg_33_1.var_.characterEffect1075ui_actor = var_36_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_2 = 0.200000002980232

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_2 and not isNil(var_36_0) then
				local var_36_3 = (arg_33_1.time_ - var_36_1) / var_36_2

				if arg_33_1.var_.characterEffect1075ui_actor and not isNil(var_36_0) then
					local var_36_4 = Mathf.Lerp(0, 0.5, var_36_3)

					arg_33_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_33_1.var_.characterEffect1075ui_actor.fillRatio = var_36_4
				end
			end

			if arg_33_1.time_ >= var_36_1 + var_36_2 and arg_33_1.time_ < var_36_1 + var_36_2 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.characterEffect1075ui_actor then
				local var_36_5 = 0.5

				arg_33_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_33_1.var_.characterEffect1075ui_actor.fillRatio = var_36_5
			end

			local var_36_6 = 0
			local var_36_7 = 0.8

			if var_36_6 < arg_33_1.time_ and arg_33_1.time_ <= var_36_6 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, false)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_8 = arg_33_1:GetWordFromCfg(1107505008)
				local var_36_9 = arg_33_1:FormatText(var_36_8.content)

				arg_33_1.text_.text = var_36_9

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_10 = 32
				local var_36_11 = utf8.len(var_36_9)
				local var_36_12 = var_36_10 <= 0 and var_36_7 or var_36_7 * (var_36_11 / var_36_10)

				if var_36_12 > 0 and var_36_7 < var_36_12 then
					arg_33_1.talkMaxDuration = var_36_12

					if var_36_12 + var_36_6 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_12 + var_36_6
					end
				end

				arg_33_1.text_.text = var_36_9
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_13 = math.max(var_36_7, arg_33_1.talkMaxDuration)

			if var_36_6 <= arg_33_1.time_ and arg_33_1.time_ < var_36_6 + var_36_13 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_6) / var_36_13

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_6 + var_36_13 and arg_33_1.time_ < var_36_6 + var_36_13 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play1107505009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 1107505009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play1107505010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 0
			local var_40_1 = 0.625

			if var_40_0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_0 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_2 = arg_37_1:FormatText(StoryNameCfg[7].name)

				arg_37_1.leftNameTxt_.text = var_40_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, true)
				arg_37_1.iconController_:SetSelectedState("hero")

				arg_37_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_37_1.callingController_:SetSelectedState("normal")

				arg_37_1.keyicon_.color = Color.New(1, 1, 1)
				arg_37_1.icon_.color = Color.New(1, 1, 1)

				local var_40_3 = arg_37_1:GetWordFromCfg(1107505009)
				local var_40_4 = arg_37_1:FormatText(var_40_3.content)

				arg_37_1.text_.text = var_40_4

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_5 = 25
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
	Play1107505010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 1107505010
		arg_41_1.duration_ = 5

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play1107505011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = arg_41_1.actors_["1075ui_actor"]
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect1075ui_actor == nil then
				arg_41_1.var_.characterEffect1075ui_actor = var_44_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_2 = 0.200000002980232

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_2 and not isNil(var_44_0) then
				local var_44_3 = (arg_41_1.time_ - var_44_1) / var_44_2

				if arg_41_1.var_.characterEffect1075ui_actor and not isNil(var_44_0) then
					arg_41_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_41_1.time_ >= var_44_1 + var_44_2 and arg_41_1.time_ < var_44_1 + var_44_2 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect1075ui_actor then
				arg_41_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			local var_44_4 = 0

			if var_44_4 < arg_41_1.time_ and arg_41_1.time_ <= var_44_4 + arg_44_0 then
				arg_41_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075action/1075action4_1")
			end

			local var_44_5 = 0

			if var_44_5 < arg_41_1.time_ and arg_41_1.time_ <= var_44_5 + arg_44_0 then
				arg_41_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_44_6 = 0
			local var_44_7 = 0.475

			if var_44_6 < arg_41_1.time_ and arg_41_1.time_ <= var_44_6 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_8 = arg_41_1:FormatText(StoryNameCfg[381].name)

				arg_41_1.leftNameTxt_.text = var_44_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_9 = arg_41_1:GetWordFromCfg(1107505010)
				local var_44_10 = arg_41_1:FormatText(var_44_9.content)

				arg_41_1.text_.text = var_44_10

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_11 = 19
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

				if manager.audio:GetVoiceLength("story_v_side_new_1107505", "1107505010", "story_v_side_new_1107505.awb") ~= 0 then
					local var_44_14 = manager.audio:GetVoiceLength("story_v_side_new_1107505", "1107505010", "story_v_side_new_1107505.awb") / 1000

					if var_44_14 + var_44_6 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_14 + var_44_6
					end

					if var_44_9.prefab_name ~= "" and arg_41_1.actors_[var_44_9.prefab_name] ~= nil then
						local var_44_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_9.prefab_name].transform, "story_v_side_new_1107505", "1107505010", "story_v_side_new_1107505.awb")

						arg_41_1:RecordAudio("1107505010", var_44_15)
						arg_41_1:RecordAudio("1107505010", var_44_15)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_side_new_1107505", "1107505010", "story_v_side_new_1107505.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_side_new_1107505", "1107505010", "story_v_side_new_1107505.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_16 = math.max(var_44_7, arg_41_1.talkMaxDuration)

			if var_44_6 <= arg_41_1.time_ and arg_41_1.time_ < var_44_6 + var_44_16 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_6) / var_44_16

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_6 + var_44_16 and arg_41_1.time_ < var_44_6 + var_44_16 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play1107505011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 1107505011
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play1107505012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = arg_45_1.actors_["1075ui_actor"]
			local var_48_1 = 0

			if var_48_1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.characterEffect1075ui_actor == nil then
				arg_45_1.var_.characterEffect1075ui_actor = var_48_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_2 = 0.200000002980232

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_2 and not isNil(var_48_0) then
				local var_48_3 = (arg_45_1.time_ - var_48_1) / var_48_2

				if arg_45_1.var_.characterEffect1075ui_actor and not isNil(var_48_0) then
					local var_48_4 = Mathf.Lerp(0, 0.5, var_48_3)

					arg_45_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_45_1.var_.characterEffect1075ui_actor.fillRatio = var_48_4
				end
			end

			if arg_45_1.time_ >= var_48_1 + var_48_2 and arg_45_1.time_ < var_48_1 + var_48_2 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.characterEffect1075ui_actor then
				local var_48_5 = 0.5

				arg_45_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_45_1.var_.characterEffect1075ui_actor.fillRatio = var_48_5
			end

			local var_48_6 = 0
			local var_48_7 = 0.6

			if var_48_6 < arg_45_1.time_ and arg_45_1.time_ <= var_48_6 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_8 = arg_45_1:FormatText(StoryNameCfg[7].name)

				arg_45_1.leftNameTxt_.text = var_48_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, true)
				arg_45_1.iconController_:SetSelectedState("hero")

				arg_45_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_45_1.callingController_:SetSelectedState("normal")

				arg_45_1.keyicon_.color = Color.New(1, 1, 1)
				arg_45_1.icon_.color = Color.New(1, 1, 1)

				local var_48_9 = arg_45_1:GetWordFromCfg(1107505011)
				local var_48_10 = arg_45_1:FormatText(var_48_9.content)

				arg_45_1.text_.text = var_48_10

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_11 = 24
				local var_48_12 = utf8.len(var_48_10)
				local var_48_13 = var_48_11 <= 0 and var_48_7 or var_48_7 * (var_48_12 / var_48_11)

				if var_48_13 > 0 and var_48_7 < var_48_13 then
					arg_45_1.talkMaxDuration = var_48_13

					if var_48_13 + var_48_6 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_13 + var_48_6
					end
				end

				arg_45_1.text_.text = var_48_10
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)
				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_14 = math.max(var_48_7, arg_45_1.talkMaxDuration)

			if var_48_6 <= arg_45_1.time_ and arg_45_1.time_ < var_48_6 + var_48_14 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_6) / var_48_14

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_6 + var_48_14 and arg_45_1.time_ < var_48_6 + var_48_14 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play1107505012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 1107505012
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play1107505013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = arg_49_1.actors_["1075ui_actor"].transform
			local var_52_1 = 0

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 then
				arg_49_1.var_.moveOldPos1075ui_actor = var_52_0.localPosition

				local var_52_2 = GameObjectTools.GetOrAddComponent(var_52_0.gameObject, typeof(DynamicBoneHelper))

				if var_52_2 then
					var_52_2:EnableDynamicBone(false)
				end
			end

			local var_52_3 = 0.001

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_3 then
				local var_52_4 = (arg_49_1.time_ - var_52_1) / var_52_3
				local var_52_5 = Vector3.New(0, 100, 0)

				var_52_0.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos1075ui_actor, var_52_5, var_52_4)

				local var_52_6 = manager.ui.mainCamera.transform.position - var_52_0.position

				var_52_0.forward = Vector3.New(var_52_6.x, var_52_6.y, var_52_6.z)

				local var_52_7 = var_52_0.localEulerAngles

				var_52_7.z = 0
				var_52_7.x = 0
				var_52_0.localEulerAngles = var_52_7
			end

			if arg_49_1.time_ >= var_52_1 + var_52_3 and arg_49_1.time_ < var_52_1 + var_52_3 + arg_52_0 then
				var_52_0.localPosition = Vector3.New(0, 100, 0)

				local var_52_8 = manager.ui.mainCamera.transform.position - var_52_0.position

				var_52_0.forward = Vector3.New(var_52_8.x, var_52_8.y, var_52_8.z)

				local var_52_9 = var_52_0.localEulerAngles

				var_52_9.z = 0
				var_52_9.x = 0
				var_52_0.localEulerAngles = var_52_9

				local var_52_10 = GameObjectTools.GetOrAddComponent(var_52_0.gameObject, typeof(DynamicBoneHelper))

				if var_52_10 then
					var_52_10:EnableDynamicBone(true)
				end
			end

			local var_52_11 = 0
			local var_52_12 = 0.625

			if var_52_11 < arg_49_1.time_ and arg_49_1.time_ <= var_52_11 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, false)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_13 = arg_49_1:GetWordFromCfg(1107505012)
				local var_52_14 = arg_49_1:FormatText(var_52_13.content)

				arg_49_1.text_.text = var_52_14

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_15 = 25
				local var_52_16 = utf8.len(var_52_14)
				local var_52_17 = var_52_15 <= 0 and var_52_12 or var_52_12 * (var_52_16 / var_52_15)

				if var_52_17 > 0 and var_52_12 < var_52_17 then
					arg_49_1.talkMaxDuration = var_52_17

					if var_52_17 + var_52_11 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_17 + var_52_11
					end
				end

				arg_49_1.text_.text = var_52_14
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)
				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_18 = math.max(var_52_12, arg_49_1.talkMaxDuration)

			if var_52_11 <= arg_49_1.time_ and arg_49_1.time_ < var_52_11 + var_52_18 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_11) / var_52_18

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_11 + var_52_18 and arg_49_1.time_ < var_52_11 + var_52_18 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_actor",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_49_1:InitPlayNodeList()
	end,
	Play1107505013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 1107505013
		arg_53_1.duration_ = 3.57

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play1107505014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = arg_53_1.actors_["1075ui_actor"].transform
			local var_56_1 = 0

			if var_56_1 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 then
				arg_53_1.var_.moveOldPos1075ui_actor = var_56_0.localPosition

				local var_56_2 = GameObjectTools.GetOrAddComponent(var_56_0.gameObject, typeof(DynamicBoneHelper))

				if var_56_2 then
					var_56_2:EnableDynamicBone(false)
				end
			end

			local var_56_3 = 0.001

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_3 then
				local var_56_4 = (arg_53_1.time_ - var_56_1) / var_56_3
				local var_56_5 = Vector3.New(0, -1.055, -6.16)

				var_56_0.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos1075ui_actor, var_56_5, var_56_4)

				local var_56_6 = manager.ui.mainCamera.transform.position - var_56_0.position

				var_56_0.forward = Vector3.New(var_56_6.x, var_56_6.y, var_56_6.z)

				local var_56_7 = var_56_0.localEulerAngles

				var_56_7.z = 0
				var_56_7.x = 0
				var_56_0.localEulerAngles = var_56_7
			end

			if arg_53_1.time_ >= var_56_1 + var_56_3 and arg_53_1.time_ < var_56_1 + var_56_3 + arg_56_0 then
				var_56_0.localPosition = Vector3.New(0, -1.055, -6.16)

				local var_56_8 = manager.ui.mainCamera.transform.position - var_56_0.position

				var_56_0.forward = Vector3.New(var_56_8.x, var_56_8.y, var_56_8.z)

				local var_56_9 = var_56_0.localEulerAngles

				var_56_9.z = 0
				var_56_9.x = 0
				var_56_0.localEulerAngles = var_56_9

				local var_56_10 = GameObjectTools.GetOrAddComponent(var_56_0.gameObject, typeof(DynamicBoneHelper))

				if var_56_10 then
					var_56_10:EnableDynamicBone(true)
				end
			end

			local var_56_11 = arg_53_1.actors_["1075ui_actor"]
			local var_56_12 = 0

			if var_56_12 < arg_53_1.time_ and arg_53_1.time_ <= var_56_12 + arg_56_0 and not isNil(var_56_11) and arg_53_1.var_.characterEffect1075ui_actor == nil then
				arg_53_1.var_.characterEffect1075ui_actor = var_56_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_13 = 0.200000002980232

			if var_56_12 <= arg_53_1.time_ and arg_53_1.time_ < var_56_12 + var_56_13 and not isNil(var_56_11) then
				local var_56_14 = (arg_53_1.time_ - var_56_12) / var_56_13

				if arg_53_1.var_.characterEffect1075ui_actor and not isNil(var_56_11) then
					arg_53_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_53_1.time_ >= var_56_12 + var_56_13 and arg_53_1.time_ < var_56_12 + var_56_13 + arg_56_0 and not isNil(var_56_11) and arg_53_1.var_.characterEffect1075ui_actor then
				arg_53_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			local var_56_15 = 0

			if var_56_15 < arg_53_1.time_ and arg_53_1.time_ <= var_56_15 + arg_56_0 then
				arg_53_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075action/1075action4_2")
			end

			local var_56_16 = 0

			if var_56_16 < arg_53_1.time_ and arg_53_1.time_ <= var_56_16 + arg_56_0 then
				arg_53_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_56_17 = 0
			local var_56_18 = 0.125

			if var_56_17 < arg_53_1.time_ and arg_53_1.time_ <= var_56_17 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_19 = arg_53_1:FormatText(StoryNameCfg[381].name)

				arg_53_1.leftNameTxt_.text = var_56_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_20 = arg_53_1:GetWordFromCfg(1107505013)
				local var_56_21 = arg_53_1:FormatText(var_56_20.content)

				arg_53_1.text_.text = var_56_21

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_22 = 5
				local var_56_23 = utf8.len(var_56_21)
				local var_56_24 = var_56_22 <= 0 and var_56_18 or var_56_18 * (var_56_23 / var_56_22)

				if var_56_24 > 0 and var_56_18 < var_56_24 then
					arg_53_1.talkMaxDuration = var_56_24

					if var_56_24 + var_56_17 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_24 + var_56_17
					end
				end

				arg_53_1.text_.text = var_56_21
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107505", "1107505013", "story_v_side_new_1107505.awb") ~= 0 then
					local var_56_25 = manager.audio:GetVoiceLength("story_v_side_new_1107505", "1107505013", "story_v_side_new_1107505.awb") / 1000

					if var_56_25 + var_56_17 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_25 + var_56_17
					end

					if var_56_20.prefab_name ~= "" and arg_53_1.actors_[var_56_20.prefab_name] ~= nil then
						local var_56_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_20.prefab_name].transform, "story_v_side_new_1107505", "1107505013", "story_v_side_new_1107505.awb")

						arg_53_1:RecordAudio("1107505013", var_56_26)
						arg_53_1:RecordAudio("1107505013", var_56_26)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_side_new_1107505", "1107505013", "story_v_side_new_1107505.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_side_new_1107505", "1107505013", "story_v_side_new_1107505.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_27 = math.max(var_56_18, arg_53_1.talkMaxDuration)

			if var_56_17 <= arg_53_1.time_ and arg_53_1.time_ < var_56_17 + var_56_27 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_17) / var_56_27

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_17 + var_56_27 and arg_53_1.time_ < var_56_17 + var_56_27 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_actor",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_53_1:InitPlayNodeList()
	end,
	Play1107505014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 1107505014
		arg_57_1.duration_ = 5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play1107505015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = arg_57_1.actors_["1075ui_actor"]
			local var_60_1 = 0

			if var_60_1 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 and not isNil(var_60_0) and arg_57_1.var_.characterEffect1075ui_actor == nil then
				arg_57_1.var_.characterEffect1075ui_actor = var_60_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_2 = 0.200000002980232

			if var_60_1 <= arg_57_1.time_ and arg_57_1.time_ < var_60_1 + var_60_2 and not isNil(var_60_0) then
				local var_60_3 = (arg_57_1.time_ - var_60_1) / var_60_2

				if arg_57_1.var_.characterEffect1075ui_actor and not isNil(var_60_0) then
					local var_60_4 = Mathf.Lerp(0, 0.5, var_60_3)

					arg_57_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_57_1.var_.characterEffect1075ui_actor.fillRatio = var_60_4
				end
			end

			if arg_57_1.time_ >= var_60_1 + var_60_2 and arg_57_1.time_ < var_60_1 + var_60_2 + arg_60_0 and not isNil(var_60_0) and arg_57_1.var_.characterEffect1075ui_actor then
				local var_60_5 = 0.5

				arg_57_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_57_1.var_.characterEffect1075ui_actor.fillRatio = var_60_5
			end

			local var_60_6 = 0
			local var_60_7 = 0.75

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

				arg_57_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_57_1.callingController_:SetSelectedState("normal")

				arg_57_1.keyicon_.color = Color.New(1, 1, 1)
				arg_57_1.icon_.color = Color.New(1, 1, 1)

				local var_60_9 = arg_57_1:GetWordFromCfg(1107505014)
				local var_60_10 = arg_57_1:FormatText(var_60_9.content)

				arg_57_1.text_.text = var_60_10

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_11 = 30
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
	Play1107505015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 1107505015
		arg_61_1.duration_ = 5.7

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play1107505016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = arg_61_1.actors_["1075ui_actor"]
			local var_64_1 = 0

			if var_64_1 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 and not isNil(var_64_0) and arg_61_1.var_.characterEffect1075ui_actor == nil then
				arg_61_1.var_.characterEffect1075ui_actor = var_64_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_2 = 0.200000002980232

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_2 and not isNil(var_64_0) then
				local var_64_3 = (arg_61_1.time_ - var_64_1) / var_64_2

				if arg_61_1.var_.characterEffect1075ui_actor and not isNil(var_64_0) then
					arg_61_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_61_1.time_ >= var_64_1 + var_64_2 and arg_61_1.time_ < var_64_1 + var_64_2 + arg_64_0 and not isNil(var_64_0) and arg_61_1.var_.characterEffect1075ui_actor then
				arg_61_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			local var_64_4 = 0

			if var_64_4 < arg_61_1.time_ and arg_61_1.time_ <= var_64_4 + arg_64_0 then
				arg_61_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075action/1075action1_1")
			end

			local var_64_5 = 0

			if var_64_5 < arg_61_1.time_ and arg_61_1.time_ <= var_64_5 + arg_64_0 then
				arg_61_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_64_6 = 0
			local var_64_7 = 0.575

			if var_64_6 < arg_61_1.time_ and arg_61_1.time_ <= var_64_6 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_8 = arg_61_1:FormatText(StoryNameCfg[381].name)

				arg_61_1.leftNameTxt_.text = var_64_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_9 = arg_61_1:GetWordFromCfg(1107505015)
				local var_64_10 = arg_61_1:FormatText(var_64_9.content)

				arg_61_1.text_.text = var_64_10

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_11 = 23
				local var_64_12 = utf8.len(var_64_10)
				local var_64_13 = var_64_11 <= 0 and var_64_7 or var_64_7 * (var_64_12 / var_64_11)

				if var_64_13 > 0 and var_64_7 < var_64_13 then
					arg_61_1.talkMaxDuration = var_64_13

					if var_64_13 + var_64_6 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_13 + var_64_6
					end
				end

				arg_61_1.text_.text = var_64_10
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107505", "1107505015", "story_v_side_new_1107505.awb") ~= 0 then
					local var_64_14 = manager.audio:GetVoiceLength("story_v_side_new_1107505", "1107505015", "story_v_side_new_1107505.awb") / 1000

					if var_64_14 + var_64_6 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_14 + var_64_6
					end

					if var_64_9.prefab_name ~= "" and arg_61_1.actors_[var_64_9.prefab_name] ~= nil then
						local var_64_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_9.prefab_name].transform, "story_v_side_new_1107505", "1107505015", "story_v_side_new_1107505.awb")

						arg_61_1:RecordAudio("1107505015", var_64_15)
						arg_61_1:RecordAudio("1107505015", var_64_15)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_side_new_1107505", "1107505015", "story_v_side_new_1107505.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_side_new_1107505", "1107505015", "story_v_side_new_1107505.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_16 = math.max(var_64_7, arg_61_1.talkMaxDuration)

			if var_64_6 <= arg_61_1.time_ and arg_61_1.time_ < var_64_6 + var_64_16 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_6) / var_64_16

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_6 + var_64_16 and arg_61_1.time_ < var_64_6 + var_64_16 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play1107505016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 1107505016
		arg_65_1.duration_ = 5

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play1107505017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = arg_65_1.actors_["1075ui_actor"].transform
			local var_68_1 = 0

			if var_68_1 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 then
				arg_65_1.var_.moveOldPos1075ui_actor = var_68_0.localPosition

				local var_68_2 = GameObjectTools.GetOrAddComponent(var_68_0.gameObject, typeof(DynamicBoneHelper))

				if var_68_2 then
					var_68_2:EnableDynamicBone(false)
				end
			end

			local var_68_3 = 0.001

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_3 then
				local var_68_4 = (arg_65_1.time_ - var_68_1) / var_68_3
				local var_68_5 = Vector3.New(0, 100, 0)

				var_68_0.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos1075ui_actor, var_68_5, var_68_4)

				local var_68_6 = manager.ui.mainCamera.transform.position - var_68_0.position

				var_68_0.forward = Vector3.New(var_68_6.x, var_68_6.y, var_68_6.z)

				local var_68_7 = var_68_0.localEulerAngles

				var_68_7.z = 0
				var_68_7.x = 0
				var_68_0.localEulerAngles = var_68_7
			end

			if arg_65_1.time_ >= var_68_1 + var_68_3 and arg_65_1.time_ < var_68_1 + var_68_3 + arg_68_0 then
				var_68_0.localPosition = Vector3.New(0, 100, 0)

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

			local var_68_11 = arg_65_1.actors_["1075ui_actor"]
			local var_68_12 = 0

			if var_68_12 < arg_65_1.time_ and arg_65_1.time_ <= var_68_12 + arg_68_0 and not isNil(var_68_11) and arg_65_1.var_.characterEffect1075ui_actor == nil then
				arg_65_1.var_.characterEffect1075ui_actor = var_68_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_13 = 0.200000002980232

			if var_68_12 <= arg_65_1.time_ and arg_65_1.time_ < var_68_12 + var_68_13 and not isNil(var_68_11) then
				local var_68_14 = (arg_65_1.time_ - var_68_12) / var_68_13

				if arg_65_1.var_.characterEffect1075ui_actor and not isNil(var_68_11) then
					local var_68_15 = Mathf.Lerp(0, 0.5, var_68_14)

					arg_65_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_65_1.var_.characterEffect1075ui_actor.fillRatio = var_68_15
				end
			end

			if arg_65_1.time_ >= var_68_12 + var_68_13 and arg_65_1.time_ < var_68_12 + var_68_13 + arg_68_0 and not isNil(var_68_11) and arg_65_1.var_.characterEffect1075ui_actor then
				local var_68_16 = 0.5

				arg_65_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_65_1.var_.characterEffect1075ui_actor.fillRatio = var_68_16
			end

			local var_68_17 = 0
			local var_68_18 = 0.575

			if var_68_17 < arg_65_1.time_ and arg_65_1.time_ <= var_68_17 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, false)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_19 = arg_65_1:GetWordFromCfg(1107505016)
				local var_68_20 = arg_65_1:FormatText(var_68_19.content)

				arg_65_1.text_.text = var_68_20

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_21 = 23
				local var_68_22 = utf8.len(var_68_20)
				local var_68_23 = var_68_21 <= 0 and var_68_18 or var_68_18 * (var_68_22 / var_68_21)

				if var_68_23 > 0 and var_68_18 < var_68_23 then
					arg_65_1.talkMaxDuration = var_68_23

					if var_68_23 + var_68_17 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_23 + var_68_17
					end
				end

				arg_65_1.text_.text = var_68_20
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)
				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_24 = math.max(var_68_18, arg_65_1.talkMaxDuration)

			if var_68_17 <= arg_65_1.time_ and arg_65_1.time_ < var_68_17 + var_68_24 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_17) / var_68_24

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_17 + var_68_24 and arg_65_1.time_ < var_68_17 + var_68_24 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_actor",
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
	Play1107505017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 1107505017
		arg_69_1.duration_ = 5

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play1107505018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = 0
			local var_72_1 = 0.675

			if var_72_0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_0 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, false)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_2 = arg_69_1:GetWordFromCfg(1107505017)
				local var_72_3 = arg_69_1:FormatText(var_72_2.content)

				arg_69_1.text_.text = var_72_3

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_4 = 27
				local var_72_5 = utf8.len(var_72_3)
				local var_72_6 = var_72_4 <= 0 and var_72_1 or var_72_1 * (var_72_5 / var_72_4)

				if var_72_6 > 0 and var_72_1 < var_72_6 then
					arg_69_1.talkMaxDuration = var_72_6

					if var_72_6 + var_72_0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_6 + var_72_0
					end
				end

				arg_69_1.text_.text = var_72_3
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)
				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_7 = math.max(var_72_1, arg_69_1.talkMaxDuration)

			if var_72_0 <= arg_69_1.time_ and arg_69_1.time_ < var_72_0 + var_72_7 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_0) / var_72_7

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_0 + var_72_7 and arg_69_1.time_ < var_72_0 + var_72_7 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play1107505018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 1107505018
		arg_73_1.duration_ = 5

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play1107505019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = 0
			local var_76_1 = 1.025

			if var_76_0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_0 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, false)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_2 = arg_73_1:GetWordFromCfg(1107505018)
				local var_76_3 = arg_73_1:FormatText(var_76_2.content)

				arg_73_1.text_.text = var_76_3

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_4 = 41
				local var_76_5 = utf8.len(var_76_3)
				local var_76_6 = var_76_4 <= 0 and var_76_1 or var_76_1 * (var_76_5 / var_76_4)

				if var_76_6 > 0 and var_76_1 < var_76_6 then
					arg_73_1.talkMaxDuration = var_76_6

					if var_76_6 + var_76_0 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_6 + var_76_0
					end
				end

				arg_73_1.text_.text = var_76_3
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)
				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_7 = math.max(var_76_1, arg_73_1.talkMaxDuration)

			if var_76_0 <= arg_73_1.time_ and arg_73_1.time_ < var_76_0 + var_76_7 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_0) / var_76_7

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_0 + var_76_7 and arg_73_1.time_ < var_76_0 + var_76_7 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play1107505019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 1107505019
		arg_77_1.duration_ = 3.47

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play1107505020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = arg_77_1.actors_["1075ui_actor"].transform
			local var_80_1 = 0

			if var_80_1 < arg_77_1.time_ and arg_77_1.time_ <= var_80_1 + arg_80_0 then
				arg_77_1.var_.moveOldPos1075ui_actor = var_80_0.localPosition

				local var_80_2 = GameObjectTools.GetOrAddComponent(var_80_0.gameObject, typeof(DynamicBoneHelper))

				if var_80_2 then
					var_80_2:EnableDynamicBone(false)
				end
			end

			local var_80_3 = 0.001

			if var_80_1 <= arg_77_1.time_ and arg_77_1.time_ < var_80_1 + var_80_3 then
				local var_80_4 = (arg_77_1.time_ - var_80_1) / var_80_3
				local var_80_5 = Vector3.New(0, -1.055, -6.16)

				var_80_0.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos1075ui_actor, var_80_5, var_80_4)

				local var_80_6 = manager.ui.mainCamera.transform.position - var_80_0.position

				var_80_0.forward = Vector3.New(var_80_6.x, var_80_6.y, var_80_6.z)

				local var_80_7 = var_80_0.localEulerAngles

				var_80_7.z = 0
				var_80_7.x = 0
				var_80_0.localEulerAngles = var_80_7
			end

			if arg_77_1.time_ >= var_80_1 + var_80_3 and arg_77_1.time_ < var_80_1 + var_80_3 + arg_80_0 then
				var_80_0.localPosition = Vector3.New(0, -1.055, -6.16)

				local var_80_8 = manager.ui.mainCamera.transform.position - var_80_0.position

				var_80_0.forward = Vector3.New(var_80_8.x, var_80_8.y, var_80_8.z)

				local var_80_9 = var_80_0.localEulerAngles

				var_80_9.z = 0
				var_80_9.x = 0
				var_80_0.localEulerAngles = var_80_9

				local var_80_10 = GameObjectTools.GetOrAddComponent(var_80_0.gameObject, typeof(DynamicBoneHelper))

				if var_80_10 then
					var_80_10:EnableDynamicBone(true)
				end
			end

			local var_80_11 = arg_77_1.actors_["1075ui_actor"]
			local var_80_12 = 0

			if var_80_12 < arg_77_1.time_ and arg_77_1.time_ <= var_80_12 + arg_80_0 and not isNil(var_80_11) and arg_77_1.var_.characterEffect1075ui_actor == nil then
				arg_77_1.var_.characterEffect1075ui_actor = var_80_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_13 = 0.200000002980232

			if var_80_12 <= arg_77_1.time_ and arg_77_1.time_ < var_80_12 + var_80_13 and not isNil(var_80_11) then
				local var_80_14 = (arg_77_1.time_ - var_80_12) / var_80_13

				if arg_77_1.var_.characterEffect1075ui_actor and not isNil(var_80_11) then
					arg_77_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_77_1.time_ >= var_80_12 + var_80_13 and arg_77_1.time_ < var_80_12 + var_80_13 + arg_80_0 and not isNil(var_80_11) and arg_77_1.var_.characterEffect1075ui_actor then
				arg_77_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			local var_80_15 = 0

			if var_80_15 < arg_77_1.time_ and arg_77_1.time_ <= var_80_15 + arg_80_0 then
				arg_77_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075action/1075action1_1")
			end

			local var_80_16 = 0

			if var_80_16 < arg_77_1.time_ and arg_77_1.time_ <= var_80_16 + arg_80_0 then
				arg_77_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_80_17 = 0
			local var_80_18 = 0.3

			if var_80_17 < arg_77_1.time_ and arg_77_1.time_ <= var_80_17 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				local var_80_19 = arg_77_1:FormatText(StoryNameCfg[381].name)

				arg_77_1.leftNameTxt_.text = var_80_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_20 = arg_77_1:GetWordFromCfg(1107505019)
				local var_80_21 = arg_77_1:FormatText(var_80_20.content)

				arg_77_1.text_.text = var_80_21

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_22 = 12
				local var_80_23 = utf8.len(var_80_21)
				local var_80_24 = var_80_22 <= 0 and var_80_18 or var_80_18 * (var_80_23 / var_80_22)

				if var_80_24 > 0 and var_80_18 < var_80_24 then
					arg_77_1.talkMaxDuration = var_80_24

					if var_80_24 + var_80_17 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_24 + var_80_17
					end
				end

				arg_77_1.text_.text = var_80_21
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107505", "1107505019", "story_v_side_new_1107505.awb") ~= 0 then
					local var_80_25 = manager.audio:GetVoiceLength("story_v_side_new_1107505", "1107505019", "story_v_side_new_1107505.awb") / 1000

					if var_80_25 + var_80_17 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_25 + var_80_17
					end

					if var_80_20.prefab_name ~= "" and arg_77_1.actors_[var_80_20.prefab_name] ~= nil then
						local var_80_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_20.prefab_name].transform, "story_v_side_new_1107505", "1107505019", "story_v_side_new_1107505.awb")

						arg_77_1:RecordAudio("1107505019", var_80_26)
						arg_77_1:RecordAudio("1107505019", var_80_26)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_side_new_1107505", "1107505019", "story_v_side_new_1107505.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_side_new_1107505", "1107505019", "story_v_side_new_1107505.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_27 = math.max(var_80_18, arg_77_1.talkMaxDuration)

			if var_80_17 <= arg_77_1.time_ and arg_77_1.time_ < var_80_17 + var_80_27 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_17) / var_80_27

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_17 + var_80_27 and arg_77_1.time_ < var_80_17 + var_80_27 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_actor",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_77_1:InitPlayNodeList()
	end,
	Play1107505020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 1107505020
		arg_81_1.duration_ = 5

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play1107505021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = arg_81_1.actors_["1075ui_actor"]
			local var_84_1 = 0

			if var_84_1 < arg_81_1.time_ and arg_81_1.time_ <= var_84_1 + arg_84_0 and not isNil(var_84_0) and arg_81_1.var_.characterEffect1075ui_actor == nil then
				arg_81_1.var_.characterEffect1075ui_actor = var_84_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_2 = 0.200000002980232

			if var_84_1 <= arg_81_1.time_ and arg_81_1.time_ < var_84_1 + var_84_2 and not isNil(var_84_0) then
				local var_84_3 = (arg_81_1.time_ - var_84_1) / var_84_2

				if arg_81_1.var_.characterEffect1075ui_actor and not isNil(var_84_0) then
					local var_84_4 = Mathf.Lerp(0, 0.5, var_84_3)

					arg_81_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_81_1.var_.characterEffect1075ui_actor.fillRatio = var_84_4
				end
			end

			if arg_81_1.time_ >= var_84_1 + var_84_2 and arg_81_1.time_ < var_84_1 + var_84_2 + arg_84_0 and not isNil(var_84_0) and arg_81_1.var_.characterEffect1075ui_actor then
				local var_84_5 = 0.5

				arg_81_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_81_1.var_.characterEffect1075ui_actor.fillRatio = var_84_5
			end

			local var_84_6 = 0
			local var_84_7 = 0.55

			if var_84_6 < arg_81_1.time_ and arg_81_1.time_ <= var_84_6 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				local var_84_8 = arg_81_1:FormatText(StoryNameCfg[7].name)

				arg_81_1.leftNameTxt_.text = var_84_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, true)
				arg_81_1.iconController_:SetSelectedState("hero")

				arg_81_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_81_1.callingController_:SetSelectedState("normal")

				arg_81_1.keyicon_.color = Color.New(1, 1, 1)
				arg_81_1.icon_.color = Color.New(1, 1, 1)

				local var_84_9 = arg_81_1:GetWordFromCfg(1107505020)
				local var_84_10 = arg_81_1:FormatText(var_84_9.content)

				arg_81_1.text_.text = var_84_10

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_11 = 22
				local var_84_12 = utf8.len(var_84_10)
				local var_84_13 = var_84_11 <= 0 and var_84_7 or var_84_7 * (var_84_12 / var_84_11)

				if var_84_13 > 0 and var_84_7 < var_84_13 then
					arg_81_1.talkMaxDuration = var_84_13

					if var_84_13 + var_84_6 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_13 + var_84_6
					end
				end

				arg_81_1.text_.text = var_84_10
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)
				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_14 = math.max(var_84_7, arg_81_1.talkMaxDuration)

			if var_84_6 <= arg_81_1.time_ and arg_81_1.time_ < var_84_6 + var_84_14 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_6) / var_84_14

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_6 + var_84_14 and arg_81_1.time_ < var_84_6 + var_84_14 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play1107505021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 1107505021
		arg_85_1.duration_ = 6.27

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play1107505022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = arg_85_1.actors_["1075ui_actor"]
			local var_88_1 = 0

			if var_88_1 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 and not isNil(var_88_0) and arg_85_1.var_.characterEffect1075ui_actor == nil then
				arg_85_1.var_.characterEffect1075ui_actor = var_88_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_2 = 0.200000002980232

			if var_88_1 <= arg_85_1.time_ and arg_85_1.time_ < var_88_1 + var_88_2 and not isNil(var_88_0) then
				local var_88_3 = (arg_85_1.time_ - var_88_1) / var_88_2

				if arg_85_1.var_.characterEffect1075ui_actor and not isNil(var_88_0) then
					arg_85_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_85_1.time_ >= var_88_1 + var_88_2 and arg_85_1.time_ < var_88_1 + var_88_2 + arg_88_0 and not isNil(var_88_0) and arg_85_1.var_.characterEffect1075ui_actor then
				arg_85_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			local var_88_4 = 0

			if var_88_4 < arg_85_1.time_ and arg_85_1.time_ <= var_88_4 + arg_88_0 then
				arg_85_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075action/1075action2_1")
			end

			local var_88_5 = 0
			local var_88_6 = 0.6

			if var_88_5 < arg_85_1.time_ and arg_85_1.time_ <= var_88_5 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				local var_88_7 = arg_85_1:FormatText(StoryNameCfg[381].name)

				arg_85_1.leftNameTxt_.text = var_88_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_8 = arg_85_1:GetWordFromCfg(1107505021)
				local var_88_9 = arg_85_1:FormatText(var_88_8.content)

				arg_85_1.text_.text = var_88_9

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_10 = 24
				local var_88_11 = utf8.len(var_88_9)
				local var_88_12 = var_88_10 <= 0 and var_88_6 or var_88_6 * (var_88_11 / var_88_10)

				if var_88_12 > 0 and var_88_6 < var_88_12 then
					arg_85_1.talkMaxDuration = var_88_12

					if var_88_12 + var_88_5 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_12 + var_88_5
					end
				end

				arg_85_1.text_.text = var_88_9
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107505", "1107505021", "story_v_side_new_1107505.awb") ~= 0 then
					local var_88_13 = manager.audio:GetVoiceLength("story_v_side_new_1107505", "1107505021", "story_v_side_new_1107505.awb") / 1000

					if var_88_13 + var_88_5 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_13 + var_88_5
					end

					if var_88_8.prefab_name ~= "" and arg_85_1.actors_[var_88_8.prefab_name] ~= nil then
						local var_88_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_8.prefab_name].transform, "story_v_side_new_1107505", "1107505021", "story_v_side_new_1107505.awb")

						arg_85_1:RecordAudio("1107505021", var_88_14)
						arg_85_1:RecordAudio("1107505021", var_88_14)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_side_new_1107505", "1107505021", "story_v_side_new_1107505.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_side_new_1107505", "1107505021", "story_v_side_new_1107505.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_15 = math.max(var_88_6, arg_85_1.talkMaxDuration)

			if var_88_5 <= arg_85_1.time_ and arg_85_1.time_ < var_88_5 + var_88_15 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_5) / var_88_15

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_5 + var_88_15 and arg_85_1.time_ < var_88_5 + var_88_15 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play1107505022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 1107505022
		arg_89_1.duration_ = 5

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play1107505023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = arg_89_1.actors_["1075ui_actor"].transform
			local var_92_1 = 0

			if var_92_1 < arg_89_1.time_ and arg_89_1.time_ <= var_92_1 + arg_92_0 then
				arg_89_1.var_.moveOldPos1075ui_actor = var_92_0.localPosition

				local var_92_2 = GameObjectTools.GetOrAddComponent(var_92_0.gameObject, typeof(DynamicBoneHelper))

				if var_92_2 then
					var_92_2:EnableDynamicBone(false)
				end
			end

			local var_92_3 = 0.001

			if var_92_1 <= arg_89_1.time_ and arg_89_1.time_ < var_92_1 + var_92_3 then
				local var_92_4 = (arg_89_1.time_ - var_92_1) / var_92_3
				local var_92_5 = Vector3.New(0, 100, 0)

				var_92_0.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos1075ui_actor, var_92_5, var_92_4)

				local var_92_6 = manager.ui.mainCamera.transform.position - var_92_0.position

				var_92_0.forward = Vector3.New(var_92_6.x, var_92_6.y, var_92_6.z)

				local var_92_7 = var_92_0.localEulerAngles

				var_92_7.z = 0
				var_92_7.x = 0
				var_92_0.localEulerAngles = var_92_7
			end

			if arg_89_1.time_ >= var_92_1 + var_92_3 and arg_89_1.time_ < var_92_1 + var_92_3 + arg_92_0 then
				var_92_0.localPosition = Vector3.New(0, 100, 0)

				local var_92_8 = manager.ui.mainCamera.transform.position - var_92_0.position

				var_92_0.forward = Vector3.New(var_92_8.x, var_92_8.y, var_92_8.z)

				local var_92_9 = var_92_0.localEulerAngles

				var_92_9.z = 0
				var_92_9.x = 0
				var_92_0.localEulerAngles = var_92_9

				local var_92_10 = GameObjectTools.GetOrAddComponent(var_92_0.gameObject, typeof(DynamicBoneHelper))

				if var_92_10 then
					var_92_10:EnableDynamicBone(true)
				end
			end

			local var_92_11 = arg_89_1.actors_["1075ui_actor"]
			local var_92_12 = 0

			if var_92_12 < arg_89_1.time_ and arg_89_1.time_ <= var_92_12 + arg_92_0 and not isNil(var_92_11) and arg_89_1.var_.characterEffect1075ui_actor == nil then
				arg_89_1.var_.characterEffect1075ui_actor = var_92_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_13 = 0.200000002980232

			if var_92_12 <= arg_89_1.time_ and arg_89_1.time_ < var_92_12 + var_92_13 and not isNil(var_92_11) then
				local var_92_14 = (arg_89_1.time_ - var_92_12) / var_92_13

				if arg_89_1.var_.characterEffect1075ui_actor and not isNil(var_92_11) then
					local var_92_15 = Mathf.Lerp(0, 0.5, var_92_14)

					arg_89_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_89_1.var_.characterEffect1075ui_actor.fillRatio = var_92_15
				end
			end

			if arg_89_1.time_ >= var_92_12 + var_92_13 and arg_89_1.time_ < var_92_12 + var_92_13 + arg_92_0 and not isNil(var_92_11) and arg_89_1.var_.characterEffect1075ui_actor then
				local var_92_16 = 0.5

				arg_89_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_89_1.var_.characterEffect1075ui_actor.fillRatio = var_92_16
			end

			local var_92_17 = 0
			local var_92_18 = 0.65

			if var_92_17 < arg_89_1.time_ and arg_89_1.time_ <= var_92_17 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, false)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_19 = arg_89_1:GetWordFromCfg(1107505022)
				local var_92_20 = arg_89_1:FormatText(var_92_19.content)

				arg_89_1.text_.text = var_92_20

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_21 = 26
				local var_92_22 = utf8.len(var_92_20)
				local var_92_23 = var_92_21 <= 0 and var_92_18 or var_92_18 * (var_92_22 / var_92_21)

				if var_92_23 > 0 and var_92_18 < var_92_23 then
					arg_89_1.talkMaxDuration = var_92_23

					if var_92_23 + var_92_17 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_23 + var_92_17
					end
				end

				arg_89_1.text_.text = var_92_20
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)
				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_24 = math.max(var_92_18, arg_89_1.talkMaxDuration)

			if var_92_17 <= arg_89_1.time_ and arg_89_1.time_ < var_92_17 + var_92_24 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_17) / var_92_24

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_17 + var_92_24 and arg_89_1.time_ < var_92_17 + var_92_24 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_actor",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_89_1:InitPlayNodeList()
	end,
	Play1107505023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 1107505023
		arg_93_1.duration_ = 2.2

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play1107505024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = arg_93_1.actors_["1075ui_actor"].transform
			local var_96_1 = 0

			if var_96_1 < arg_93_1.time_ and arg_93_1.time_ <= var_96_1 + arg_96_0 then
				arg_93_1.var_.moveOldPos1075ui_actor = var_96_0.localPosition

				local var_96_2 = GameObjectTools.GetOrAddComponent(var_96_0.gameObject, typeof(DynamicBoneHelper))

				if var_96_2 then
					var_96_2:EnableDynamicBone(false)
				end
			end

			local var_96_3 = 0.001

			if var_96_1 <= arg_93_1.time_ and arg_93_1.time_ < var_96_1 + var_96_3 then
				local var_96_4 = (arg_93_1.time_ - var_96_1) / var_96_3
				local var_96_5 = Vector3.New(0, -1.055, -6.16)

				var_96_0.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos1075ui_actor, var_96_5, var_96_4)

				local var_96_6 = manager.ui.mainCamera.transform.position - var_96_0.position

				var_96_0.forward = Vector3.New(var_96_6.x, var_96_6.y, var_96_6.z)

				local var_96_7 = var_96_0.localEulerAngles

				var_96_7.z = 0
				var_96_7.x = 0
				var_96_0.localEulerAngles = var_96_7
			end

			if arg_93_1.time_ >= var_96_1 + var_96_3 and arg_93_1.time_ < var_96_1 + var_96_3 + arg_96_0 then
				var_96_0.localPosition = Vector3.New(0, -1.055, -6.16)

				local var_96_8 = manager.ui.mainCamera.transform.position - var_96_0.position

				var_96_0.forward = Vector3.New(var_96_8.x, var_96_8.y, var_96_8.z)

				local var_96_9 = var_96_0.localEulerAngles

				var_96_9.z = 0
				var_96_9.x = 0
				var_96_0.localEulerAngles = var_96_9

				local var_96_10 = GameObjectTools.GetOrAddComponent(var_96_0.gameObject, typeof(DynamicBoneHelper))

				if var_96_10 then
					var_96_10:EnableDynamicBone(true)
				end
			end

			local var_96_11 = arg_93_1.actors_["1075ui_actor"]
			local var_96_12 = 0

			if var_96_12 < arg_93_1.time_ and arg_93_1.time_ <= var_96_12 + arg_96_0 and not isNil(var_96_11) and arg_93_1.var_.characterEffect1075ui_actor == nil then
				arg_93_1.var_.characterEffect1075ui_actor = var_96_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_13 = 0.200000002980232

			if var_96_12 <= arg_93_1.time_ and arg_93_1.time_ < var_96_12 + var_96_13 and not isNil(var_96_11) then
				local var_96_14 = (arg_93_1.time_ - var_96_12) / var_96_13

				if arg_93_1.var_.characterEffect1075ui_actor and not isNil(var_96_11) then
					arg_93_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_93_1.time_ >= var_96_12 + var_96_13 and arg_93_1.time_ < var_96_12 + var_96_13 + arg_96_0 and not isNil(var_96_11) and arg_93_1.var_.characterEffect1075ui_actor then
				arg_93_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			local var_96_15 = 0

			if var_96_15 < arg_93_1.time_ and arg_93_1.time_ <= var_96_15 + arg_96_0 then
				arg_93_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075actionlink/1075action423")
			end

			local var_96_16 = 0

			if var_96_16 < arg_93_1.time_ and arg_93_1.time_ <= var_96_16 + arg_96_0 then
				arg_93_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_96_17 = 0
			local var_96_18 = 0.225

			if var_96_17 < arg_93_1.time_ and arg_93_1.time_ <= var_96_17 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				local var_96_19 = arg_93_1:FormatText(StoryNameCfg[381].name)

				arg_93_1.leftNameTxt_.text = var_96_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_20 = arg_93_1:GetWordFromCfg(1107505023)
				local var_96_21 = arg_93_1:FormatText(var_96_20.content)

				arg_93_1.text_.text = var_96_21

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_22 = 9
				local var_96_23 = utf8.len(var_96_21)
				local var_96_24 = var_96_22 <= 0 and var_96_18 or var_96_18 * (var_96_23 / var_96_22)

				if var_96_24 > 0 and var_96_18 < var_96_24 then
					arg_93_1.talkMaxDuration = var_96_24

					if var_96_24 + var_96_17 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_24 + var_96_17
					end
				end

				arg_93_1.text_.text = var_96_21
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107505", "1107505023", "story_v_side_new_1107505.awb") ~= 0 then
					local var_96_25 = manager.audio:GetVoiceLength("story_v_side_new_1107505", "1107505023", "story_v_side_new_1107505.awb") / 1000

					if var_96_25 + var_96_17 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_25 + var_96_17
					end

					if var_96_20.prefab_name ~= "" and arg_93_1.actors_[var_96_20.prefab_name] ~= nil then
						local var_96_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_20.prefab_name].transform, "story_v_side_new_1107505", "1107505023", "story_v_side_new_1107505.awb")

						arg_93_1:RecordAudio("1107505023", var_96_26)
						arg_93_1:RecordAudio("1107505023", var_96_26)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_side_new_1107505", "1107505023", "story_v_side_new_1107505.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_side_new_1107505", "1107505023", "story_v_side_new_1107505.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_27 = math.max(var_96_18, arg_93_1.talkMaxDuration)

			if var_96_17 <= arg_93_1.time_ and arg_93_1.time_ < var_96_17 + var_96_27 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_17) / var_96_27

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_17 + var_96_27 and arg_93_1.time_ < var_96_17 + var_96_27 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_actor",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_93_1:InitPlayNodeList()
	end,
	Play1107505024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 1107505024
		arg_97_1.duration_ = 5

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play1107505025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = arg_97_1.actors_["1075ui_actor"]
			local var_100_1 = 0

			if var_100_1 < arg_97_1.time_ and arg_97_1.time_ <= var_100_1 + arg_100_0 and not isNil(var_100_0) and arg_97_1.var_.characterEffect1075ui_actor == nil then
				arg_97_1.var_.characterEffect1075ui_actor = var_100_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_2 = 0.200000002980232

			if var_100_1 <= arg_97_1.time_ and arg_97_1.time_ < var_100_1 + var_100_2 and not isNil(var_100_0) then
				local var_100_3 = (arg_97_1.time_ - var_100_1) / var_100_2

				if arg_97_1.var_.characterEffect1075ui_actor and not isNil(var_100_0) then
					local var_100_4 = Mathf.Lerp(0, 0.5, var_100_3)

					arg_97_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_97_1.var_.characterEffect1075ui_actor.fillRatio = var_100_4
				end
			end

			if arg_97_1.time_ >= var_100_1 + var_100_2 and arg_97_1.time_ < var_100_1 + var_100_2 + arg_100_0 and not isNil(var_100_0) and arg_97_1.var_.characterEffect1075ui_actor then
				local var_100_5 = 0.5

				arg_97_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_97_1.var_.characterEffect1075ui_actor.fillRatio = var_100_5
			end

			local var_100_6 = 0
			local var_100_7 = 0.725

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

				local var_100_9 = arg_97_1:GetWordFromCfg(1107505024)
				local var_100_10 = arg_97_1:FormatText(var_100_9.content)

				arg_97_1.text_.text = var_100_10

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_11 = 29
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
	Play1107505025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 1107505025
		arg_101_1.duration_ = 5

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play1107505026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = 0
			local var_104_1 = 0.5

			if var_104_0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_0 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				local var_104_2 = arg_101_1:FormatText(StoryNameCfg[7].name)

				arg_101_1.leftNameTxt_.text = var_104_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, true)
				arg_101_1.iconController_:SetSelectedState("hero")

				arg_101_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_101_1.callingController_:SetSelectedState("normal")

				arg_101_1.keyicon_.color = Color.New(1, 1, 1)
				arg_101_1.icon_.color = Color.New(1, 1, 1)

				local var_104_3 = arg_101_1:GetWordFromCfg(1107505025)
				local var_104_4 = arg_101_1:FormatText(var_104_3.content)

				arg_101_1.text_.text = var_104_4

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_5 = 20
				local var_104_6 = utf8.len(var_104_4)
				local var_104_7 = var_104_5 <= 0 and var_104_1 or var_104_1 * (var_104_6 / var_104_5)

				if var_104_7 > 0 and var_104_1 < var_104_7 then
					arg_101_1.talkMaxDuration = var_104_7

					if var_104_7 + var_104_0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_7 + var_104_0
					end
				end

				arg_101_1.text_.text = var_104_4
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)
				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_8 = math.max(var_104_1, arg_101_1.talkMaxDuration)

			if var_104_0 <= arg_101_1.time_ and arg_101_1.time_ < var_104_0 + var_104_8 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_0) / var_104_8

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_0 + var_104_8 and arg_101_1.time_ < var_104_0 + var_104_8 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play1107505026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 1107505026
		arg_105_1.duration_ = 5

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play1107505027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = 0
			local var_108_1 = 0.525

			if var_108_0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_0 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, false)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_2 = arg_105_1:GetWordFromCfg(1107505026)
				local var_108_3 = arg_105_1:FormatText(var_108_2.content)

				arg_105_1.text_.text = var_108_3

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_4 = 21
				local var_108_5 = utf8.len(var_108_3)
				local var_108_6 = var_108_4 <= 0 and var_108_1 or var_108_1 * (var_108_5 / var_108_4)

				if var_108_6 > 0 and var_108_1 < var_108_6 then
					arg_105_1.talkMaxDuration = var_108_6

					if var_108_6 + var_108_0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_6 + var_108_0
					end
				end

				arg_105_1.text_.text = var_108_3
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)
				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_7 = math.max(var_108_1, arg_105_1.talkMaxDuration)

			if var_108_0 <= arg_105_1.time_ and arg_105_1.time_ < var_108_0 + var_108_7 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_0) / var_108_7

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_0 + var_108_7 and arg_105_1.time_ < var_108_0 + var_108_7 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play1107505027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 1107505027
		arg_109_1.duration_ = 2.67

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play1107505028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = arg_109_1.actors_["1075ui_actor"]
			local var_112_1 = 0

			if var_112_1 < arg_109_1.time_ and arg_109_1.time_ <= var_112_1 + arg_112_0 and not isNil(var_112_0) and arg_109_1.var_.characterEffect1075ui_actor == nil then
				arg_109_1.var_.characterEffect1075ui_actor = var_112_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_2 = 0.200000002980232

			if var_112_1 <= arg_109_1.time_ and arg_109_1.time_ < var_112_1 + var_112_2 and not isNil(var_112_0) then
				local var_112_3 = (arg_109_1.time_ - var_112_1) / var_112_2

				if arg_109_1.var_.characterEffect1075ui_actor and not isNil(var_112_0) then
					arg_109_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_109_1.time_ >= var_112_1 + var_112_2 and arg_109_1.time_ < var_112_1 + var_112_2 + arg_112_0 and not isNil(var_112_0) and arg_109_1.var_.characterEffect1075ui_actor then
				arg_109_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			local var_112_4 = 0

			if var_112_4 < arg_109_1.time_ and arg_109_1.time_ <= var_112_4 + arg_112_0 then
				arg_109_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075action/1075action3_2")
			end

			local var_112_5 = 0

			if var_112_5 < arg_109_1.time_ and arg_109_1.time_ <= var_112_5 + arg_112_0 then
				arg_109_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_112_6 = 0
			local var_112_7 = 0.3

			if var_112_6 < arg_109_1.time_ and arg_109_1.time_ <= var_112_6 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				local var_112_8 = arg_109_1:FormatText(StoryNameCfg[381].name)

				arg_109_1.leftNameTxt_.text = var_112_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_9 = arg_109_1:GetWordFromCfg(1107505027)
				local var_112_10 = arg_109_1:FormatText(var_112_9.content)

				arg_109_1.text_.text = var_112_10

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_11 = 12
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

				if manager.audio:GetVoiceLength("story_v_side_new_1107505", "1107505027", "story_v_side_new_1107505.awb") ~= 0 then
					local var_112_14 = manager.audio:GetVoiceLength("story_v_side_new_1107505", "1107505027", "story_v_side_new_1107505.awb") / 1000

					if var_112_14 + var_112_6 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_14 + var_112_6
					end

					if var_112_9.prefab_name ~= "" and arg_109_1.actors_[var_112_9.prefab_name] ~= nil then
						local var_112_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_9.prefab_name].transform, "story_v_side_new_1107505", "1107505027", "story_v_side_new_1107505.awb")

						arg_109_1:RecordAudio("1107505027", var_112_15)
						arg_109_1:RecordAudio("1107505027", var_112_15)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_side_new_1107505", "1107505027", "story_v_side_new_1107505.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_side_new_1107505", "1107505027", "story_v_side_new_1107505.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_16 = math.max(var_112_7, arg_109_1.talkMaxDuration)

			if var_112_6 <= arg_109_1.time_ and arg_109_1.time_ < var_112_6 + var_112_16 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_6) / var_112_16

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_6 + var_112_16 and arg_109_1.time_ < var_112_6 + var_112_16 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play1107505028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 1107505028
		arg_113_1.duration_ = 5

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play1107505029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = arg_113_1.actors_["1075ui_actor"]
			local var_116_1 = 0

			if var_116_1 < arg_113_1.time_ and arg_113_1.time_ <= var_116_1 + arg_116_0 and not isNil(var_116_0) and arg_113_1.var_.characterEffect1075ui_actor == nil then
				arg_113_1.var_.characterEffect1075ui_actor = var_116_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_2 = 0.200000002980232

			if var_116_1 <= arg_113_1.time_ and arg_113_1.time_ < var_116_1 + var_116_2 and not isNil(var_116_0) then
				local var_116_3 = (arg_113_1.time_ - var_116_1) / var_116_2

				if arg_113_1.var_.characterEffect1075ui_actor and not isNil(var_116_0) then
					local var_116_4 = Mathf.Lerp(0, 0.5, var_116_3)

					arg_113_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_113_1.var_.characterEffect1075ui_actor.fillRatio = var_116_4
				end
			end

			if arg_113_1.time_ >= var_116_1 + var_116_2 and arg_113_1.time_ < var_116_1 + var_116_2 + arg_116_0 and not isNil(var_116_0) and arg_113_1.var_.characterEffect1075ui_actor then
				local var_116_5 = 0.5

				arg_113_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_113_1.var_.characterEffect1075ui_actor.fillRatio = var_116_5
			end

			local var_116_6 = 0
			local var_116_7 = 0.35

			if var_116_6 < arg_113_1.time_ and arg_113_1.time_ <= var_116_6 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				local var_116_8 = arg_113_1:FormatText(StoryNameCfg[7].name)

				arg_113_1.leftNameTxt_.text = var_116_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, true)
				arg_113_1.iconController_:SetSelectedState("hero")

				arg_113_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_113_1.callingController_:SetSelectedState("normal")

				arg_113_1.keyicon_.color = Color.New(1, 1, 1)
				arg_113_1.icon_.color = Color.New(1, 1, 1)

				local var_116_9 = arg_113_1:GetWordFromCfg(1107505028)
				local var_116_10 = arg_113_1:FormatText(var_116_9.content)

				arg_113_1.text_.text = var_116_10

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_11 = 14
				local var_116_12 = utf8.len(var_116_10)
				local var_116_13 = var_116_11 <= 0 and var_116_7 or var_116_7 * (var_116_12 / var_116_11)

				if var_116_13 > 0 and var_116_7 < var_116_13 then
					arg_113_1.talkMaxDuration = var_116_13

					if var_116_13 + var_116_6 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_13 + var_116_6
					end
				end

				arg_113_1.text_.text = var_116_10
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)
				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_14 = math.max(var_116_7, arg_113_1.talkMaxDuration)

			if var_116_6 <= arg_113_1.time_ and arg_113_1.time_ < var_116_6 + var_116_14 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_6) / var_116_14

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_6 + var_116_14 and arg_113_1.time_ < var_116_6 + var_116_14 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play1107505029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 1107505029
		arg_117_1.duration_ = 2.87

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play1107505030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = arg_117_1.actors_["1075ui_actor"]
			local var_120_1 = 0

			if var_120_1 < arg_117_1.time_ and arg_117_1.time_ <= var_120_1 + arg_120_0 and not isNil(var_120_0) and arg_117_1.var_.characterEffect1075ui_actor == nil then
				arg_117_1.var_.characterEffect1075ui_actor = var_120_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_2 = 0.200000002980232

			if var_120_1 <= arg_117_1.time_ and arg_117_1.time_ < var_120_1 + var_120_2 and not isNil(var_120_0) then
				local var_120_3 = (arg_117_1.time_ - var_120_1) / var_120_2

				if arg_117_1.var_.characterEffect1075ui_actor and not isNil(var_120_0) then
					arg_117_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_117_1.time_ >= var_120_1 + var_120_2 and arg_117_1.time_ < var_120_1 + var_120_2 + arg_120_0 and not isNil(var_120_0) and arg_117_1.var_.characterEffect1075ui_actor then
				arg_117_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			local var_120_4 = 0

			if var_120_4 < arg_117_1.time_ and arg_117_1.time_ <= var_120_4 + arg_120_0 then
				arg_117_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_120_5 = 0
			local var_120_6 = 0.3

			if var_120_5 < arg_117_1.time_ and arg_117_1.time_ <= var_120_5 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				local var_120_7 = arg_117_1:FormatText(StoryNameCfg[381].name)

				arg_117_1.leftNameTxt_.text = var_120_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_8 = arg_117_1:GetWordFromCfg(1107505029)
				local var_120_9 = arg_117_1:FormatText(var_120_8.content)

				arg_117_1.text_.text = var_120_9

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_10 = 12
				local var_120_11 = utf8.len(var_120_9)
				local var_120_12 = var_120_10 <= 0 and var_120_6 or var_120_6 * (var_120_11 / var_120_10)

				if var_120_12 > 0 and var_120_6 < var_120_12 then
					arg_117_1.talkMaxDuration = var_120_12

					if var_120_12 + var_120_5 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_12 + var_120_5
					end
				end

				arg_117_1.text_.text = var_120_9
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107505", "1107505029", "story_v_side_new_1107505.awb") ~= 0 then
					local var_120_13 = manager.audio:GetVoiceLength("story_v_side_new_1107505", "1107505029", "story_v_side_new_1107505.awb") / 1000

					if var_120_13 + var_120_5 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_13 + var_120_5
					end

					if var_120_8.prefab_name ~= "" and arg_117_1.actors_[var_120_8.prefab_name] ~= nil then
						local var_120_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_8.prefab_name].transform, "story_v_side_new_1107505", "1107505029", "story_v_side_new_1107505.awb")

						arg_117_1:RecordAudio("1107505029", var_120_14)
						arg_117_1:RecordAudio("1107505029", var_120_14)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_side_new_1107505", "1107505029", "story_v_side_new_1107505.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_side_new_1107505", "1107505029", "story_v_side_new_1107505.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_15 = math.max(var_120_6, arg_117_1.talkMaxDuration)

			if var_120_5 <= arg_117_1.time_ and arg_117_1.time_ < var_120_5 + var_120_15 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_5) / var_120_15

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_5 + var_120_15 and arg_117_1.time_ < var_120_5 + var_120_15 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play1107505030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 1107505030
		arg_121_1.duration_ = 5

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play1107505031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = arg_121_1.actors_["1075ui_actor"]
			local var_124_1 = 0

			if var_124_1 < arg_121_1.time_ and arg_121_1.time_ <= var_124_1 + arg_124_0 and not isNil(var_124_0) and arg_121_1.var_.characterEffect1075ui_actor == nil then
				arg_121_1.var_.characterEffect1075ui_actor = var_124_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_2 = 0.200000002980232

			if var_124_1 <= arg_121_1.time_ and arg_121_1.time_ < var_124_1 + var_124_2 and not isNil(var_124_0) then
				local var_124_3 = (arg_121_1.time_ - var_124_1) / var_124_2

				if arg_121_1.var_.characterEffect1075ui_actor and not isNil(var_124_0) then
					local var_124_4 = Mathf.Lerp(0, 0.5, var_124_3)

					arg_121_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_121_1.var_.characterEffect1075ui_actor.fillRatio = var_124_4
				end
			end

			if arg_121_1.time_ >= var_124_1 + var_124_2 and arg_121_1.time_ < var_124_1 + var_124_2 + arg_124_0 and not isNil(var_124_0) and arg_121_1.var_.characterEffect1075ui_actor then
				local var_124_5 = 0.5

				arg_121_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_121_1.var_.characterEffect1075ui_actor.fillRatio = var_124_5
			end

			local var_124_6 = 0
			local var_124_7 = 0.4

			if var_124_6 < arg_121_1.time_ and arg_121_1.time_ <= var_124_6 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				local var_124_8 = arg_121_1:FormatText(StoryNameCfg[7].name)

				arg_121_1.leftNameTxt_.text = var_124_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, true)
				arg_121_1.iconController_:SetSelectedState("hero")

				arg_121_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_121_1.callingController_:SetSelectedState("normal")

				arg_121_1.keyicon_.color = Color.New(1, 1, 1)
				arg_121_1.icon_.color = Color.New(1, 1, 1)

				local var_124_9 = arg_121_1:GetWordFromCfg(1107505030)
				local var_124_10 = arg_121_1:FormatText(var_124_9.content)

				arg_121_1.text_.text = var_124_10

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_11 = 16
				local var_124_12 = utf8.len(var_124_10)
				local var_124_13 = var_124_11 <= 0 and var_124_7 or var_124_7 * (var_124_12 / var_124_11)

				if var_124_13 > 0 and var_124_7 < var_124_13 then
					arg_121_1.talkMaxDuration = var_124_13

					if var_124_13 + var_124_6 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_13 + var_124_6
					end
				end

				arg_121_1.text_.text = var_124_10
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)
				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_14 = math.max(var_124_7, arg_121_1.talkMaxDuration)

			if var_124_6 <= arg_121_1.time_ and arg_121_1.time_ < var_124_6 + var_124_14 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_6) / var_124_14

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_6 + var_124_14 and arg_121_1.time_ < var_124_6 + var_124_14 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play1107505031 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 1107505031
		arg_125_1.duration_ = 5

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play1107505032(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = 0
			local var_128_1 = 0.65

			if var_128_0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_0 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				local var_128_2 = arg_125_1:FormatText(StoryNameCfg[7].name)

				arg_125_1.leftNameTxt_.text = var_128_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, true)
				arg_125_1.iconController_:SetSelectedState("hero")

				arg_125_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_125_1.callingController_:SetSelectedState("normal")

				arg_125_1.keyicon_.color = Color.New(1, 1, 1)
				arg_125_1.icon_.color = Color.New(1, 1, 1)

				local var_128_3 = arg_125_1:GetWordFromCfg(1107505031)
				local var_128_4 = arg_125_1:FormatText(var_128_3.content)

				arg_125_1.text_.text = var_128_4

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_5 = 26
				local var_128_6 = utf8.len(var_128_4)
				local var_128_7 = var_128_5 <= 0 and var_128_1 or var_128_1 * (var_128_6 / var_128_5)

				if var_128_7 > 0 and var_128_1 < var_128_7 then
					arg_125_1.talkMaxDuration = var_128_7

					if var_128_7 + var_128_0 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_7 + var_128_0
					end
				end

				arg_125_1.text_.text = var_128_4
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)
				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_8 = math.max(var_128_1, arg_125_1.talkMaxDuration)

			if var_128_0 <= arg_125_1.time_ and arg_125_1.time_ < var_128_0 + var_128_8 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_0) / var_128_8

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_0 + var_128_8 and arg_125_1.time_ < var_128_0 + var_128_8 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play1107505032 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 1107505032
		arg_129_1.duration_ = 5

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play1107505033(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = 0
			local var_132_1 = 0.925

			if var_132_0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_0 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				local var_132_2 = arg_129_1:FormatText(StoryNameCfg[7].name)

				arg_129_1.leftNameTxt_.text = var_132_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, true)
				arg_129_1.iconController_:SetSelectedState("hero")

				arg_129_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_129_1.callingController_:SetSelectedState("normal")

				arg_129_1.keyicon_.color = Color.New(1, 1, 1)
				arg_129_1.icon_.color = Color.New(1, 1, 1)

				local var_132_3 = arg_129_1:GetWordFromCfg(1107505032)
				local var_132_4 = arg_129_1:FormatText(var_132_3.content)

				arg_129_1.text_.text = var_132_4

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_5 = 37
				local var_132_6 = utf8.len(var_132_4)
				local var_132_7 = var_132_5 <= 0 and var_132_1 or var_132_1 * (var_132_6 / var_132_5)

				if var_132_7 > 0 and var_132_1 < var_132_7 then
					arg_129_1.talkMaxDuration = var_132_7

					if var_132_7 + var_132_0 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_7 + var_132_0
					end
				end

				arg_129_1.text_.text = var_132_4
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)
				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_8 = math.max(var_132_1, arg_129_1.talkMaxDuration)

			if var_132_0 <= arg_129_1.time_ and arg_129_1.time_ < var_132_0 + var_132_8 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_0) / var_132_8

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_0 + var_132_8 and arg_129_1.time_ < var_132_0 + var_132_8 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play1107505033 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 1107505033
		arg_133_1.duration_ = 5.23

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play1107505034(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = arg_133_1.actors_["1075ui_actor"]
			local var_136_1 = 0

			if var_136_1 < arg_133_1.time_ and arg_133_1.time_ <= var_136_1 + arg_136_0 and not isNil(var_136_0) and arg_133_1.var_.characterEffect1075ui_actor == nil then
				arg_133_1.var_.characterEffect1075ui_actor = var_136_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_2 = 0.200000002980232

			if var_136_1 <= arg_133_1.time_ and arg_133_1.time_ < var_136_1 + var_136_2 and not isNil(var_136_0) then
				local var_136_3 = (arg_133_1.time_ - var_136_1) / var_136_2

				if arg_133_1.var_.characterEffect1075ui_actor and not isNil(var_136_0) then
					arg_133_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_133_1.time_ >= var_136_1 + var_136_2 and arg_133_1.time_ < var_136_1 + var_136_2 + arg_136_0 and not isNil(var_136_0) and arg_133_1.var_.characterEffect1075ui_actor then
				arg_133_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			local var_136_4 = 0

			if var_136_4 < arg_133_1.time_ and arg_133_1.time_ <= var_136_4 + arg_136_0 then
				arg_133_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075action/1075action4_1")
			end

			local var_136_5 = 0

			if var_136_5 < arg_133_1.time_ and arg_133_1.time_ <= var_136_5 + arg_136_0 then
				arg_133_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_136_6 = 0
			local var_136_7 = 0.65

			if var_136_6 < arg_133_1.time_ and arg_133_1.time_ <= var_136_6 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				local var_136_8 = arg_133_1:FormatText(StoryNameCfg[381].name)

				arg_133_1.leftNameTxt_.text = var_136_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_9 = arg_133_1:GetWordFromCfg(1107505033)
				local var_136_10 = arg_133_1:FormatText(var_136_9.content)

				arg_133_1.text_.text = var_136_10

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_11 = 26
				local var_136_12 = utf8.len(var_136_10)
				local var_136_13 = var_136_11 <= 0 and var_136_7 or var_136_7 * (var_136_12 / var_136_11)

				if var_136_13 > 0 and var_136_7 < var_136_13 then
					arg_133_1.talkMaxDuration = var_136_13

					if var_136_13 + var_136_6 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_13 + var_136_6
					end
				end

				arg_133_1.text_.text = var_136_10
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107505", "1107505033", "story_v_side_new_1107505.awb") ~= 0 then
					local var_136_14 = manager.audio:GetVoiceLength("story_v_side_new_1107505", "1107505033", "story_v_side_new_1107505.awb") / 1000

					if var_136_14 + var_136_6 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_14 + var_136_6
					end

					if var_136_9.prefab_name ~= "" and arg_133_1.actors_[var_136_9.prefab_name] ~= nil then
						local var_136_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_9.prefab_name].transform, "story_v_side_new_1107505", "1107505033", "story_v_side_new_1107505.awb")

						arg_133_1:RecordAudio("1107505033", var_136_15)
						arg_133_1:RecordAudio("1107505033", var_136_15)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_side_new_1107505", "1107505033", "story_v_side_new_1107505.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_side_new_1107505", "1107505033", "story_v_side_new_1107505.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_16 = math.max(var_136_7, arg_133_1.talkMaxDuration)

			if var_136_6 <= arg_133_1.time_ and arg_133_1.time_ < var_136_6 + var_136_16 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_6) / var_136_16

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_6 + var_136_16 and arg_133_1.time_ < var_136_6 + var_136_16 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play1107505034 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 1107505034
		arg_137_1.duration_ = 5

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play1107505035(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = arg_137_1.actors_["1075ui_actor"]
			local var_140_1 = 0

			if var_140_1 < arg_137_1.time_ and arg_137_1.time_ <= var_140_1 + arg_140_0 and not isNil(var_140_0) and arg_137_1.var_.characterEffect1075ui_actor == nil then
				arg_137_1.var_.characterEffect1075ui_actor = var_140_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_2 = 0.200000002980232

			if var_140_1 <= arg_137_1.time_ and arg_137_1.time_ < var_140_1 + var_140_2 and not isNil(var_140_0) then
				local var_140_3 = (arg_137_1.time_ - var_140_1) / var_140_2

				if arg_137_1.var_.characterEffect1075ui_actor and not isNil(var_140_0) then
					local var_140_4 = Mathf.Lerp(0, 0.5, var_140_3)

					arg_137_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_137_1.var_.characterEffect1075ui_actor.fillRatio = var_140_4
				end
			end

			if arg_137_1.time_ >= var_140_1 + var_140_2 and arg_137_1.time_ < var_140_1 + var_140_2 + arg_140_0 and not isNil(var_140_0) and arg_137_1.var_.characterEffect1075ui_actor then
				local var_140_5 = 0.5

				arg_137_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_137_1.var_.characterEffect1075ui_actor.fillRatio = var_140_5
			end

			local var_140_6 = 0
			local var_140_7 = 1.05

			if var_140_6 < arg_137_1.time_ and arg_137_1.time_ <= var_140_6 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				local var_140_8 = arg_137_1:FormatText(StoryNameCfg[7].name)

				arg_137_1.leftNameTxt_.text = var_140_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, true)
				arg_137_1.iconController_:SetSelectedState("hero")

				arg_137_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_137_1.callingController_:SetSelectedState("normal")

				arg_137_1.keyicon_.color = Color.New(1, 1, 1)
				arg_137_1.icon_.color = Color.New(1, 1, 1)

				local var_140_9 = arg_137_1:GetWordFromCfg(1107505034)
				local var_140_10 = arg_137_1:FormatText(var_140_9.content)

				arg_137_1.text_.text = var_140_10

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_11 = 42
				local var_140_12 = utf8.len(var_140_10)
				local var_140_13 = var_140_11 <= 0 and var_140_7 or var_140_7 * (var_140_12 / var_140_11)

				if var_140_13 > 0 and var_140_7 < var_140_13 then
					arg_137_1.talkMaxDuration = var_140_13

					if var_140_13 + var_140_6 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_13 + var_140_6
					end
				end

				arg_137_1.text_.text = var_140_10
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)
				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_14 = math.max(var_140_7, arg_137_1.talkMaxDuration)

			if var_140_6 <= arg_137_1.time_ and arg_137_1.time_ < var_140_6 + var_140_14 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_6) / var_140_14

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_6 + var_140_14 and arg_137_1.time_ < var_140_6 + var_140_14 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play1107505035 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 1107505035
		arg_141_1.duration_ = 5

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play1107505036(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = arg_141_1.actors_["1075ui_actor"].transform
			local var_144_1 = 0

			if var_144_1 < arg_141_1.time_ and arg_141_1.time_ <= var_144_1 + arg_144_0 then
				arg_141_1.var_.moveOldPos1075ui_actor = var_144_0.localPosition

				local var_144_2 = GameObjectTools.GetOrAddComponent(var_144_0.gameObject, typeof(DynamicBoneHelper))

				if var_144_2 then
					var_144_2:EnableDynamicBone(false)
				end
			end

			local var_144_3 = 0.001

			if var_144_1 <= arg_141_1.time_ and arg_141_1.time_ < var_144_1 + var_144_3 then
				local var_144_4 = (arg_141_1.time_ - var_144_1) / var_144_3
				local var_144_5 = Vector3.New(0, 100, 0)

				var_144_0.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos1075ui_actor, var_144_5, var_144_4)

				local var_144_6 = manager.ui.mainCamera.transform.position - var_144_0.position

				var_144_0.forward = Vector3.New(var_144_6.x, var_144_6.y, var_144_6.z)

				local var_144_7 = var_144_0.localEulerAngles

				var_144_7.z = 0
				var_144_7.x = 0
				var_144_0.localEulerAngles = var_144_7
			end

			if arg_141_1.time_ >= var_144_1 + var_144_3 and arg_141_1.time_ < var_144_1 + var_144_3 + arg_144_0 then
				var_144_0.localPosition = Vector3.New(0, 100, 0)

				local var_144_8 = manager.ui.mainCamera.transform.position - var_144_0.position

				var_144_0.forward = Vector3.New(var_144_8.x, var_144_8.y, var_144_8.z)

				local var_144_9 = var_144_0.localEulerAngles

				var_144_9.z = 0
				var_144_9.x = 0
				var_144_0.localEulerAngles = var_144_9

				local var_144_10 = GameObjectTools.GetOrAddComponent(var_144_0.gameObject, typeof(DynamicBoneHelper))

				if var_144_10 then
					var_144_10:EnableDynamicBone(true)
				end
			end

			local var_144_11 = 0
			local var_144_12 = 0.6

			if var_144_11 < arg_141_1.time_ and arg_141_1.time_ <= var_144_11 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, false)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_13 = arg_141_1:GetWordFromCfg(1107505035)
				local var_144_14 = arg_141_1:FormatText(var_144_13.content)

				arg_141_1.text_.text = var_144_14

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_15 = 24
				local var_144_16 = utf8.len(var_144_14)
				local var_144_17 = var_144_15 <= 0 and var_144_12 or var_144_12 * (var_144_16 / var_144_15)

				if var_144_17 > 0 and var_144_12 < var_144_17 then
					arg_141_1.talkMaxDuration = var_144_17

					if var_144_17 + var_144_11 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_17 + var_144_11
					end
				end

				arg_141_1.text_.text = var_144_14
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)
				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_18 = math.max(var_144_12, arg_141_1.talkMaxDuration)

			if var_144_11 <= arg_141_1.time_ and arg_141_1.time_ < var_144_11 + var_144_18 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_11) / var_144_18

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_11 + var_144_18 and arg_141_1.time_ < var_144_11 + var_144_18 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_actor",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_141_1:InitPlayNodeList()
	end,
	Play1107505036 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 1107505036
		arg_145_1.duration_ = 2.97

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play1107505037(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = arg_145_1.actors_["1075ui_actor"].transform
			local var_148_1 = 0

			if var_148_1 < arg_145_1.time_ and arg_145_1.time_ <= var_148_1 + arg_148_0 then
				arg_145_1.var_.moveOldPos1075ui_actor = var_148_0.localPosition

				local var_148_2 = GameObjectTools.GetOrAddComponent(var_148_0.gameObject, typeof(DynamicBoneHelper))

				if var_148_2 then
					var_148_2:EnableDynamicBone(false)
				end
			end

			local var_148_3 = 0.001

			if var_148_1 <= arg_145_1.time_ and arg_145_1.time_ < var_148_1 + var_148_3 then
				local var_148_4 = (arg_145_1.time_ - var_148_1) / var_148_3
				local var_148_5 = Vector3.New(0, -1.055, -6.16)

				var_148_0.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos1075ui_actor, var_148_5, var_148_4)

				local var_148_6 = manager.ui.mainCamera.transform.position - var_148_0.position

				var_148_0.forward = Vector3.New(var_148_6.x, var_148_6.y, var_148_6.z)

				local var_148_7 = var_148_0.localEulerAngles

				var_148_7.z = 0
				var_148_7.x = 0
				var_148_0.localEulerAngles = var_148_7
			end

			if arg_145_1.time_ >= var_148_1 + var_148_3 and arg_145_1.time_ < var_148_1 + var_148_3 + arg_148_0 then
				var_148_0.localPosition = Vector3.New(0, -1.055, -6.16)

				local var_148_8 = manager.ui.mainCamera.transform.position - var_148_0.position

				var_148_0.forward = Vector3.New(var_148_8.x, var_148_8.y, var_148_8.z)

				local var_148_9 = var_148_0.localEulerAngles

				var_148_9.z = 0
				var_148_9.x = 0
				var_148_0.localEulerAngles = var_148_9

				local var_148_10 = GameObjectTools.GetOrAddComponent(var_148_0.gameObject, typeof(DynamicBoneHelper))

				if var_148_10 then
					var_148_10:EnableDynamicBone(true)
				end
			end

			local var_148_11 = arg_145_1.actors_["1075ui_actor"]
			local var_148_12 = 0

			if var_148_12 < arg_145_1.time_ and arg_145_1.time_ <= var_148_12 + arg_148_0 and not isNil(var_148_11) and arg_145_1.var_.characterEffect1075ui_actor == nil then
				arg_145_1.var_.characterEffect1075ui_actor = var_148_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_13 = 0.200000002980232

			if var_148_12 <= arg_145_1.time_ and arg_145_1.time_ < var_148_12 + var_148_13 and not isNil(var_148_11) then
				local var_148_14 = (arg_145_1.time_ - var_148_12) / var_148_13

				if arg_145_1.var_.characterEffect1075ui_actor and not isNil(var_148_11) then
					arg_145_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_145_1.time_ >= var_148_12 + var_148_13 and arg_145_1.time_ < var_148_12 + var_148_13 + arg_148_0 and not isNil(var_148_11) and arg_145_1.var_.characterEffect1075ui_actor then
				arg_145_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			local var_148_15 = 0

			if var_148_15 < arg_145_1.time_ and arg_145_1.time_ <= var_148_15 + arg_148_0 then
				arg_145_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075actionlink/1075action442")
			end

			local var_148_16 = 0

			if var_148_16 < arg_145_1.time_ and arg_145_1.time_ <= var_148_16 + arg_148_0 then
				arg_145_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_148_17 = 0
			local var_148_18 = 0.3

			if var_148_17 < arg_145_1.time_ and arg_145_1.time_ <= var_148_17 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				local var_148_19 = arg_145_1:FormatText(StoryNameCfg[381].name)

				arg_145_1.leftNameTxt_.text = var_148_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_20 = arg_145_1:GetWordFromCfg(1107505036)
				local var_148_21 = arg_145_1:FormatText(var_148_20.content)

				arg_145_1.text_.text = var_148_21

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_22 = 12
				local var_148_23 = utf8.len(var_148_21)
				local var_148_24 = var_148_22 <= 0 and var_148_18 or var_148_18 * (var_148_23 / var_148_22)

				if var_148_24 > 0 and var_148_18 < var_148_24 then
					arg_145_1.talkMaxDuration = var_148_24

					if var_148_24 + var_148_17 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_24 + var_148_17
					end
				end

				arg_145_1.text_.text = var_148_21
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107505", "1107505036", "story_v_side_new_1107505.awb") ~= 0 then
					local var_148_25 = manager.audio:GetVoiceLength("story_v_side_new_1107505", "1107505036", "story_v_side_new_1107505.awb") / 1000

					if var_148_25 + var_148_17 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_25 + var_148_17
					end

					if var_148_20.prefab_name ~= "" and arg_145_1.actors_[var_148_20.prefab_name] ~= nil then
						local var_148_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_20.prefab_name].transform, "story_v_side_new_1107505", "1107505036", "story_v_side_new_1107505.awb")

						arg_145_1:RecordAudio("1107505036", var_148_26)
						arg_145_1:RecordAudio("1107505036", var_148_26)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_side_new_1107505", "1107505036", "story_v_side_new_1107505.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_side_new_1107505", "1107505036", "story_v_side_new_1107505.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_27 = math.max(var_148_18, arg_145_1.talkMaxDuration)

			if var_148_17 <= arg_145_1.time_ and arg_145_1.time_ < var_148_17 + var_148_27 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_17) / var_148_27

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_17 + var_148_27 and arg_145_1.time_ < var_148_17 + var_148_27 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_actor",
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
	Play1107505037 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 1107505037
		arg_149_1.duration_ = 5

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play1107505038(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = arg_149_1.actors_["1075ui_actor"].transform
			local var_152_1 = 0

			if var_152_1 < arg_149_1.time_ and arg_149_1.time_ <= var_152_1 + arg_152_0 then
				arg_149_1.var_.moveOldPos1075ui_actor = var_152_0.localPosition

				local var_152_2 = GameObjectTools.GetOrAddComponent(var_152_0.gameObject, typeof(DynamicBoneHelper))

				if var_152_2 then
					var_152_2:EnableDynamicBone(false)
				end
			end

			local var_152_3 = 0.001

			if var_152_1 <= arg_149_1.time_ and arg_149_1.time_ < var_152_1 + var_152_3 then
				local var_152_4 = (arg_149_1.time_ - var_152_1) / var_152_3
				local var_152_5 = Vector3.New(0, 100, 0)

				var_152_0.localPosition = Vector3.Lerp(arg_149_1.var_.moveOldPos1075ui_actor, var_152_5, var_152_4)

				local var_152_6 = manager.ui.mainCamera.transform.position - var_152_0.position

				var_152_0.forward = Vector3.New(var_152_6.x, var_152_6.y, var_152_6.z)

				local var_152_7 = var_152_0.localEulerAngles

				var_152_7.z = 0
				var_152_7.x = 0
				var_152_0.localEulerAngles = var_152_7
			end

			if arg_149_1.time_ >= var_152_1 + var_152_3 and arg_149_1.time_ < var_152_1 + var_152_3 + arg_152_0 then
				var_152_0.localPosition = Vector3.New(0, 100, 0)

				local var_152_8 = manager.ui.mainCamera.transform.position - var_152_0.position

				var_152_0.forward = Vector3.New(var_152_8.x, var_152_8.y, var_152_8.z)

				local var_152_9 = var_152_0.localEulerAngles

				var_152_9.z = 0
				var_152_9.x = 0
				var_152_0.localEulerAngles = var_152_9

				local var_152_10 = GameObjectTools.GetOrAddComponent(var_152_0.gameObject, typeof(DynamicBoneHelper))

				if var_152_10 then
					var_152_10:EnableDynamicBone(true)
				end
			end

			local var_152_11 = arg_149_1.actors_["1075ui_actor"]
			local var_152_12 = 0

			if var_152_12 < arg_149_1.time_ and arg_149_1.time_ <= var_152_12 + arg_152_0 and not isNil(var_152_11) and arg_149_1.var_.characterEffect1075ui_actor == nil then
				arg_149_1.var_.characterEffect1075ui_actor = var_152_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_13 = 0.200000002980232

			if var_152_12 <= arg_149_1.time_ and arg_149_1.time_ < var_152_12 + var_152_13 and not isNil(var_152_11) then
				local var_152_14 = (arg_149_1.time_ - var_152_12) / var_152_13

				if arg_149_1.var_.characterEffect1075ui_actor and not isNil(var_152_11) then
					local var_152_15 = Mathf.Lerp(0, 0.5, var_152_14)

					arg_149_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_149_1.var_.characterEffect1075ui_actor.fillRatio = var_152_15
				end
			end

			if arg_149_1.time_ >= var_152_12 + var_152_13 and arg_149_1.time_ < var_152_12 + var_152_13 + arg_152_0 and not isNil(var_152_11) and arg_149_1.var_.characterEffect1075ui_actor then
				local var_152_16 = 0.5

				arg_149_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_149_1.var_.characterEffect1075ui_actor.fillRatio = var_152_16
			end

			local var_152_17 = 0
			local var_152_18 = 1.1

			if var_152_17 < arg_149_1.time_ and arg_149_1.time_ <= var_152_17 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, false)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_19 = arg_149_1:GetWordFromCfg(1107505037)
				local var_152_20 = arg_149_1:FormatText(var_152_19.content)

				arg_149_1.text_.text = var_152_20

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_21 = 44
				local var_152_22 = utf8.len(var_152_20)
				local var_152_23 = var_152_21 <= 0 and var_152_18 or var_152_18 * (var_152_22 / var_152_21)

				if var_152_23 > 0 and var_152_18 < var_152_23 then
					arg_149_1.talkMaxDuration = var_152_23

					if var_152_23 + var_152_17 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_23 + var_152_17
					end
				end

				arg_149_1.text_.text = var_152_20
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)
				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_24 = math.max(var_152_18, arg_149_1.talkMaxDuration)

			if var_152_17 <= arg_149_1.time_ and arg_149_1.time_ < var_152_17 + var_152_24 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_17) / var_152_24

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_17 + var_152_24 and arg_149_1.time_ < var_152_17 + var_152_24 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_actor",
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
	Play1107505038 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 1107505038
		arg_153_1.duration_ = 1

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"

			SetActive(arg_153_1.choicesGo_, true)

			for iter_154_0, iter_154_1 in ipairs(arg_153_1.choices_) do
				local var_154_0 = iter_154_0 <= 2

				SetActive(iter_154_1.go, var_154_0)
			end

			arg_153_1.choices_[1].txt.text = arg_153_1:FormatText(StoryChoiceCfg[1161].name)
			arg_153_1.choices_[2].txt.text = arg_153_1:FormatText(StoryChoiceCfg[1162].name)
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play1107505039(arg_153_1)
			end

			if arg_155_0 == 2 then
				arg_153_0:Play1107505039(arg_153_1)
			end

			arg_153_1:RecordChoiceLog(1107505038, 1161, 1162)
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = 0

			if var_156_0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_0 + arg_156_0 then
				arg_153_1.allBtn_.enabled = false
			end

			local var_156_1 = 0.5

			if arg_153_1.time_ >= var_156_0 + var_156_1 and arg_153_1.time_ < var_156_0 + var_156_1 + arg_156_0 then
				arg_153_1.allBtn_.enabled = true
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play1107505039 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 1107505039
		arg_157_1.duration_ = 5.27

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play1107505040(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = arg_157_1.actors_["1075ui_actor"].transform
			local var_160_1 = 0

			if var_160_1 < arg_157_1.time_ and arg_157_1.time_ <= var_160_1 + arg_160_0 then
				arg_157_1.var_.moveOldPos1075ui_actor = var_160_0.localPosition

				local var_160_2 = GameObjectTools.GetOrAddComponent(var_160_0.gameObject, typeof(DynamicBoneHelper))

				if var_160_2 then
					var_160_2:EnableDynamicBone(false)
				end
			end

			local var_160_3 = 0.001

			if var_160_1 <= arg_157_1.time_ and arg_157_1.time_ < var_160_1 + var_160_3 then
				local var_160_4 = (arg_157_1.time_ - var_160_1) / var_160_3
				local var_160_5 = Vector3.New(0, -1.055, -6.16)

				var_160_0.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos1075ui_actor, var_160_5, var_160_4)

				local var_160_6 = manager.ui.mainCamera.transform.position - var_160_0.position

				var_160_0.forward = Vector3.New(var_160_6.x, var_160_6.y, var_160_6.z)

				local var_160_7 = var_160_0.localEulerAngles

				var_160_7.z = 0
				var_160_7.x = 0
				var_160_0.localEulerAngles = var_160_7
			end

			if arg_157_1.time_ >= var_160_1 + var_160_3 and arg_157_1.time_ < var_160_1 + var_160_3 + arg_160_0 then
				var_160_0.localPosition = Vector3.New(0, -1.055, -6.16)

				local var_160_8 = manager.ui.mainCamera.transform.position - var_160_0.position

				var_160_0.forward = Vector3.New(var_160_8.x, var_160_8.y, var_160_8.z)

				local var_160_9 = var_160_0.localEulerAngles

				var_160_9.z = 0
				var_160_9.x = 0
				var_160_0.localEulerAngles = var_160_9

				local var_160_10 = GameObjectTools.GetOrAddComponent(var_160_0.gameObject, typeof(DynamicBoneHelper))

				if var_160_10 then
					var_160_10:EnableDynamicBone(true)
				end
			end

			local var_160_11 = arg_157_1.actors_["1075ui_actor"]
			local var_160_12 = 0

			if var_160_12 < arg_157_1.time_ and arg_157_1.time_ <= var_160_12 + arg_160_0 and not isNil(var_160_11) and arg_157_1.var_.characterEffect1075ui_actor == nil then
				arg_157_1.var_.characterEffect1075ui_actor = var_160_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_13 = 0.200000002980232

			if var_160_12 <= arg_157_1.time_ and arg_157_1.time_ < var_160_12 + var_160_13 and not isNil(var_160_11) then
				local var_160_14 = (arg_157_1.time_ - var_160_12) / var_160_13

				if arg_157_1.var_.characterEffect1075ui_actor and not isNil(var_160_11) then
					arg_157_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_157_1.time_ >= var_160_12 + var_160_13 and arg_157_1.time_ < var_160_12 + var_160_13 + arg_160_0 and not isNil(var_160_11) and arg_157_1.var_.characterEffect1075ui_actor then
				arg_157_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			local var_160_15 = "1075ui_actor"

			if arg_157_1.actors_[var_160_15] == nil then
				local var_160_16 = Asset.Load("Char/" .. "1075ui_actor")

				if not isNil(var_160_16) then
					local var_160_17 = Object.Instantiate(Asset.Load("Char/" .. "1075ui_actor"), arg_157_1.stage_.transform)

					var_160_17.name = var_160_15
					var_160_17.transform.localPosition = Vector3.New(0, 100, 0)
					arg_157_1.actors_[var_160_15] = var_160_17

					local var_160_18 = var_160_17:GetComponentInChildren(typeof(CharacterEffect))

					var_160_18.enabled = true

					local var_160_19 = GameObjectTools.GetOrAddComponent(var_160_17, typeof(DynamicBoneHelper))

					if var_160_19 then
						var_160_19:EnableDynamicBone(false)
					end

					arg_157_1:ShowWeapon(var_160_18.transform, false)

					arg_157_1.var_[var_160_15 .. "Animator"] = var_160_18.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_157_1.var_[var_160_15 .. "Animator"].applyRootMotion = true
					arg_157_1.var_[var_160_15 .. "LipSync"] = var_160_18.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_160_20 = 0

			if var_160_20 < arg_157_1.time_ and arg_157_1.time_ <= var_160_20 + arg_160_0 then
				arg_157_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075action/1075action2_2")
			end

			local var_160_21 = "1075ui_actor"

			if arg_157_1.actors_[var_160_21] == nil then
				local var_160_22 = Asset.Load("Char/" .. "1075ui_actor")

				if not isNil(var_160_22) then
					local var_160_23 = Object.Instantiate(Asset.Load("Char/" .. "1075ui_actor"), arg_157_1.stage_.transform)

					var_160_23.name = var_160_21
					var_160_23.transform.localPosition = Vector3.New(0, 100, 0)
					arg_157_1.actors_[var_160_21] = var_160_23

					local var_160_24 = var_160_23:GetComponentInChildren(typeof(CharacterEffect))

					var_160_24.enabled = true

					local var_160_25 = GameObjectTools.GetOrAddComponent(var_160_23, typeof(DynamicBoneHelper))

					if var_160_25 then
						var_160_25:EnableDynamicBone(false)
					end

					arg_157_1:ShowWeapon(var_160_24.transform, false)

					arg_157_1.var_[var_160_21 .. "Animator"] = var_160_24.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_157_1.var_[var_160_21 .. "Animator"].applyRootMotion = true
					arg_157_1.var_[var_160_21 .. "LipSync"] = var_160_24.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_160_26 = 0

			if var_160_26 < arg_157_1.time_ and arg_157_1.time_ <= var_160_26 + arg_160_0 then
				arg_157_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_160_27 = 0
			local var_160_28 = 0.525

			if var_160_27 < arg_157_1.time_ and arg_157_1.time_ <= var_160_27 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				local var_160_29 = arg_157_1:FormatText(StoryNameCfg[381].name)

				arg_157_1.leftNameTxt_.text = var_160_29

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_30 = arg_157_1:GetWordFromCfg(1107505039)
				local var_160_31 = arg_157_1:FormatText(var_160_30.content)

				arg_157_1.text_.text = var_160_31

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_32 = 21
				local var_160_33 = utf8.len(var_160_31)
				local var_160_34 = var_160_32 <= 0 and var_160_28 or var_160_28 * (var_160_33 / var_160_32)

				if var_160_34 > 0 and var_160_28 < var_160_34 then
					arg_157_1.talkMaxDuration = var_160_34

					if var_160_34 + var_160_27 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_34 + var_160_27
					end
				end

				arg_157_1.text_.text = var_160_31
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107505", "1107505039", "story_v_side_new_1107505.awb") ~= 0 then
					local var_160_35 = manager.audio:GetVoiceLength("story_v_side_new_1107505", "1107505039", "story_v_side_new_1107505.awb") / 1000

					if var_160_35 + var_160_27 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_35 + var_160_27
					end

					if var_160_30.prefab_name ~= "" and arg_157_1.actors_[var_160_30.prefab_name] ~= nil then
						local var_160_36 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_30.prefab_name].transform, "story_v_side_new_1107505", "1107505039", "story_v_side_new_1107505.awb")

						arg_157_1:RecordAudio("1107505039", var_160_36)
						arg_157_1:RecordAudio("1107505039", var_160_36)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_side_new_1107505", "1107505039", "story_v_side_new_1107505.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_side_new_1107505", "1107505039", "story_v_side_new_1107505.awb")
				end

				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_37 = math.max(var_160_28, arg_157_1.talkMaxDuration)

			if var_160_27 <= arg_157_1.time_ and arg_157_1.time_ < var_160_27 + var_160_37 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_27) / var_160_37

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_27 + var_160_37 and arg_157_1.time_ < var_160_27 + var_160_37 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_actor",
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
	Play1107505040 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 1107505040
		arg_161_1.duration_ = 5

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play1107505041(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = arg_161_1.actors_["1075ui_actor"]
			local var_164_1 = 0

			if var_164_1 < arg_161_1.time_ and arg_161_1.time_ <= var_164_1 + arg_164_0 and not isNil(var_164_0) and arg_161_1.var_.characterEffect1075ui_actor == nil then
				arg_161_1.var_.characterEffect1075ui_actor = var_164_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_2 = 0.200000002980232

			if var_164_1 <= arg_161_1.time_ and arg_161_1.time_ < var_164_1 + var_164_2 and not isNil(var_164_0) then
				local var_164_3 = (arg_161_1.time_ - var_164_1) / var_164_2

				if arg_161_1.var_.characterEffect1075ui_actor and not isNil(var_164_0) then
					local var_164_4 = Mathf.Lerp(0, 0.5, var_164_3)

					arg_161_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_161_1.var_.characterEffect1075ui_actor.fillRatio = var_164_4
				end
			end

			if arg_161_1.time_ >= var_164_1 + var_164_2 and arg_161_1.time_ < var_164_1 + var_164_2 + arg_164_0 and not isNil(var_164_0) and arg_161_1.var_.characterEffect1075ui_actor then
				local var_164_5 = 0.5

				arg_161_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_161_1.var_.characterEffect1075ui_actor.fillRatio = var_164_5
			end

			local var_164_6 = 0
			local var_164_7 = 0.45

			if var_164_6 < arg_161_1.time_ and arg_161_1.time_ <= var_164_6 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				local var_164_8 = arg_161_1:FormatText(StoryNameCfg[7].name)

				arg_161_1.leftNameTxt_.text = var_164_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, true)
				arg_161_1.iconController_:SetSelectedState("hero")

				arg_161_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_161_1.callingController_:SetSelectedState("normal")

				arg_161_1.keyicon_.color = Color.New(1, 1, 1)
				arg_161_1.icon_.color = Color.New(1, 1, 1)

				local var_164_9 = arg_161_1:GetWordFromCfg(1107505040)
				local var_164_10 = arg_161_1:FormatText(var_164_9.content)

				arg_161_1.text_.text = var_164_10

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_11 = 18
				local var_164_12 = utf8.len(var_164_10)
				local var_164_13 = var_164_11 <= 0 and var_164_7 or var_164_7 * (var_164_12 / var_164_11)

				if var_164_13 > 0 and var_164_7 < var_164_13 then
					arg_161_1.talkMaxDuration = var_164_13

					if var_164_13 + var_164_6 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_13 + var_164_6
					end
				end

				arg_161_1.text_.text = var_164_10
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)
				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_14 = math.max(var_164_7, arg_161_1.talkMaxDuration)

			if var_164_6 <= arg_161_1.time_ and arg_161_1.time_ < var_164_6 + var_164_14 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_6) / var_164_14

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_6 + var_164_14 and arg_161_1.time_ < var_164_6 + var_164_14 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play1107505041 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 1107505041
		arg_165_1.duration_ = 9

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play1107505042(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = "ST42"

			if arg_165_1.bgs_[var_168_0] == nil then
				local var_168_1 = Object.Instantiate(arg_165_1.paintGo_)

				var_168_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_168_0)
				var_168_1.name = var_168_0
				var_168_1.transform.parent = arg_165_1.stage_.transform
				var_168_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_165_1.bgs_[var_168_0] = var_168_1
			end

			local var_168_2 = 2

			if var_168_2 < arg_165_1.time_ and arg_165_1.time_ <= var_168_2 + arg_168_0 then
				local var_168_3 = manager.ui.mainCamera.transform.localPosition
				local var_168_4 = Vector3.New(0, 0, 10) + Vector3.New(var_168_3.x, var_168_3.y, 0)
				local var_168_5 = arg_165_1.bgs_.ST42

				var_168_5.transform.localPosition = var_168_4
				var_168_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_168_6 = var_168_5:GetComponent("SpriteRenderer")

				if var_168_6 and var_168_6.sprite then
					local var_168_7 = (var_168_5.transform.localPosition - var_168_3).z
					local var_168_8 = manager.ui.mainCameraCom_
					local var_168_9 = 2 * var_168_7 * Mathf.Tan(var_168_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_168_10 = var_168_9 * var_168_8.aspect
					local var_168_11 = var_168_6.sprite.bounds.size.x
					local var_168_12 = var_168_6.sprite.bounds.size.y
					local var_168_13 = var_168_10 / var_168_11
					local var_168_14 = var_168_9 / var_168_12
					local var_168_15 = var_168_14 < var_168_13 and var_168_13 or var_168_14

					var_168_5.transform.localScale = Vector3.New(var_168_15, var_168_15, 0)
				end

				for iter_168_0, iter_168_1 in pairs(arg_165_1.bgs_) do
					if iter_168_0 ~= "ST42" then
						iter_168_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_168_16 = 4

			if var_168_16 < arg_165_1.time_ and arg_165_1.time_ <= var_168_16 + arg_168_0 then
				arg_165_1.allBtn_.enabled = false
			end

			local var_168_17 = 0.3

			if arg_165_1.time_ >= var_168_16 + var_168_17 and arg_165_1.time_ < var_168_16 + var_168_17 + arg_168_0 then
				arg_165_1.allBtn_.enabled = true
			end

			local var_168_18 = 0

			if var_168_18 < arg_165_1.time_ and arg_165_1.time_ <= var_168_18 + arg_168_0 then
				arg_165_1.mask_.enabled = true
				arg_165_1.mask_.raycastTarget = true

				arg_165_1:SetGaussion(false)
			end

			local var_168_19 = 2

			if var_168_18 <= arg_165_1.time_ and arg_165_1.time_ < var_168_18 + var_168_19 then
				local var_168_20 = (arg_165_1.time_ - var_168_18) / var_168_19
				local var_168_21 = Color.New(0, 0, 0)

				var_168_21.a = Mathf.Lerp(0, 1, var_168_20)
				arg_165_1.mask_.color = var_168_21
			end

			if arg_165_1.time_ >= var_168_18 + var_168_19 and arg_165_1.time_ < var_168_18 + var_168_19 + arg_168_0 then
				local var_168_22 = Color.New(0, 0, 0)

				var_168_22.a = 1
				arg_165_1.mask_.color = var_168_22
			end

			local var_168_23 = 2

			if var_168_23 < arg_165_1.time_ and arg_165_1.time_ <= var_168_23 + arg_168_0 then
				arg_165_1.mask_.enabled = true
				arg_165_1.mask_.raycastTarget = true

				arg_165_1:SetGaussion(false)
			end

			local var_168_24 = 2

			if var_168_23 <= arg_165_1.time_ and arg_165_1.time_ < var_168_23 + var_168_24 then
				local var_168_25 = (arg_165_1.time_ - var_168_23) / var_168_24
				local var_168_26 = Color.New(0, 0, 0)

				var_168_26.a = Mathf.Lerp(1, 0, var_168_25)
				arg_165_1.mask_.color = var_168_26
			end

			if arg_165_1.time_ >= var_168_23 + var_168_24 and arg_165_1.time_ < var_168_23 + var_168_24 + arg_168_0 then
				local var_168_27 = Color.New(0, 0, 0)
				local var_168_28 = 0

				arg_165_1.mask_.enabled = false
				var_168_27.a = var_168_28
				arg_165_1.mask_.color = var_168_27
			end

			local var_168_29 = arg_165_1.actors_["1075ui_actor"].transform
			local var_168_30 = 1.96599999815226

			if var_168_30 < arg_165_1.time_ and arg_165_1.time_ <= var_168_30 + arg_168_0 then
				arg_165_1.var_.moveOldPos1075ui_actor = var_168_29.localPosition

				local var_168_31 = GameObjectTools.GetOrAddComponent(var_168_29.gameObject, typeof(DynamicBoneHelper))

				if var_168_31 then
					var_168_31:EnableDynamicBone(false)
				end
			end

			local var_168_32 = 0.001

			if var_168_30 <= arg_165_1.time_ and arg_165_1.time_ < var_168_30 + var_168_32 then
				local var_168_33 = (arg_165_1.time_ - var_168_30) / var_168_32
				local var_168_34 = Vector3.New(0, 100, 0)

				var_168_29.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPos1075ui_actor, var_168_34, var_168_33)

				local var_168_35 = manager.ui.mainCamera.transform.position - var_168_29.position

				var_168_29.forward = Vector3.New(var_168_35.x, var_168_35.y, var_168_35.z)

				local var_168_36 = var_168_29.localEulerAngles

				var_168_36.z = 0
				var_168_36.x = 0
				var_168_29.localEulerAngles = var_168_36
			end

			if arg_165_1.time_ >= var_168_30 + var_168_32 and arg_165_1.time_ < var_168_30 + var_168_32 + arg_168_0 then
				var_168_29.localPosition = Vector3.New(0, 100, 0)

				local var_168_37 = manager.ui.mainCamera.transform.position - var_168_29.position

				var_168_29.forward = Vector3.New(var_168_37.x, var_168_37.y, var_168_37.z)

				local var_168_38 = var_168_29.localEulerAngles

				var_168_38.z = 0
				var_168_38.x = 0
				var_168_29.localEulerAngles = var_168_38

				local var_168_39 = GameObjectTools.GetOrAddComponent(var_168_29.gameObject, typeof(DynamicBoneHelper))

				if var_168_39 then
					var_168_39:EnableDynamicBone(true)
				end
			end

			if arg_165_1.frameCnt_ <= 1 then
				arg_165_1.dialog_:SetActive(false)
			end

			local var_168_40 = 4
			local var_168_41 = 0.725

			if var_168_40 < arg_165_1.time_ and arg_165_1.time_ <= var_168_40 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0

				arg_165_1.dialog_:SetActive(true)

				arg_165_1.dialogCg_.alpha = 0

				local var_168_42 = LeanTween.value(arg_165_1.dialog_, 0, 1, 0.3)

				var_168_42:setOnUpdate(LuaHelper.FloatAction(function(arg_169_0)
					arg_165_1.dialogCg_.alpha = arg_169_0
				end))
				var_168_42:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_165_1.dialog_)
					var_168_42:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_165_1.duration_ = arg_165_1.duration_ + 0.3

				SetActive(arg_165_1.leftNameGo_, false)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_43 = arg_165_1:GetWordFromCfg(1107505041)
				local var_168_44 = arg_165_1:FormatText(var_168_43.content)

				arg_165_1.text_.text = var_168_44

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_45 = 28
				local var_168_46 = utf8.len(var_168_44)
				local var_168_47 = var_168_45 <= 0 and var_168_41 or var_168_41 * (var_168_46 / var_168_45)

				if var_168_47 > 0 and var_168_41 < var_168_47 then
					arg_165_1.talkMaxDuration = var_168_47
					var_168_40 = var_168_40 + 0.3

					if var_168_47 + var_168_40 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_47 + var_168_40
					end
				end

				arg_165_1.text_.text = var_168_44
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)
				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_48 = var_168_40 + 0.3
			local var_168_49 = math.max(var_168_41, arg_165_1.talkMaxDuration)

			if var_168_48 <= arg_165_1.time_ and arg_165_1.time_ < var_168_48 + var_168_49 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_48) / var_168_49

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_48 + var_168_49 and arg_165_1.time_ < var_168_48 + var_168_49 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_actor",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_165_1:InitPlayNodeList()
	end,
	Play1107505042 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 1107505042
		arg_171_1.duration_ = 5

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play1107505043(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = 0
			local var_174_1 = 0.775

			if var_174_0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_0 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, false)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_2 = arg_171_1:GetWordFromCfg(1107505042)
				local var_174_3 = arg_171_1:FormatText(var_174_2.content)

				arg_171_1.text_.text = var_174_3

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_4 = 31
				local var_174_5 = utf8.len(var_174_3)
				local var_174_6 = var_174_4 <= 0 and var_174_1 or var_174_1 * (var_174_5 / var_174_4)

				if var_174_6 > 0 and var_174_1 < var_174_6 then
					arg_171_1.talkMaxDuration = var_174_6

					if var_174_6 + var_174_0 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_6 + var_174_0
					end
				end

				arg_171_1.text_.text = var_174_3
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)
				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_7 = math.max(var_174_1, arg_171_1.talkMaxDuration)

			if var_174_0 <= arg_171_1.time_ and arg_171_1.time_ < var_174_0 + var_174_7 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_0) / var_174_7

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_0 + var_174_7 and arg_171_1.time_ < var_174_0 + var_174_7 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {}

		arg_171_1:InitPlayNodeList()
	end,
	Play1107505043 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 1107505043
		arg_175_1.duration_ = 5

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play1107505044(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = 0
			local var_178_1 = 0.25

			if var_178_0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_0 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				local var_178_2 = arg_175_1:FormatText(StoryNameCfg[7].name)

				arg_175_1.leftNameTxt_.text = var_178_2

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

				local var_178_3 = arg_175_1:GetWordFromCfg(1107505043)
				local var_178_4 = arg_175_1:FormatText(var_178_3.content)

				arg_175_1.text_.text = var_178_4

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_5 = 10
				local var_178_6 = utf8.len(var_178_4)
				local var_178_7 = var_178_5 <= 0 and var_178_1 or var_178_1 * (var_178_6 / var_178_5)

				if var_178_7 > 0 and var_178_1 < var_178_7 then
					arg_175_1.talkMaxDuration = var_178_7

					if var_178_7 + var_178_0 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_7 + var_178_0
					end
				end

				arg_175_1.text_.text = var_178_4
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)
				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_8 = math.max(var_178_1, arg_175_1.talkMaxDuration)

			if var_178_0 <= arg_175_1.time_ and arg_175_1.time_ < var_178_0 + var_178_8 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_0) / var_178_8

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_0 + var_178_8 and arg_175_1.time_ < var_178_0 + var_178_8 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {}

		arg_175_1:InitPlayNodeList()
	end,
	Play1107505044 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 1107505044
		arg_179_1.duration_ = 4.1

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play1107505045(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = 0
			local var_182_1 = 0.475

			if var_182_0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_0 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				local var_182_2 = arg_179_1:FormatText(StoryNameCfg[36].name)

				arg_179_1.leftNameTxt_.text = var_182_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, true)
				arg_179_1.iconController_:SetSelectedState("hero")

				arg_179_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_179_1.callingController_:SetSelectedState("normal")

				arg_179_1.keyicon_.color = Color.New(1, 1, 1)
				arg_179_1.icon_.color = Color.New(1, 1, 1)

				local var_182_3 = arg_179_1:GetWordFromCfg(1107505044)
				local var_182_4 = arg_179_1:FormatText(var_182_3.content)

				arg_179_1.text_.text = var_182_4

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_5 = 19
				local var_182_6 = utf8.len(var_182_4)
				local var_182_7 = var_182_5 <= 0 and var_182_1 or var_182_1 * (var_182_6 / var_182_5)

				if var_182_7 > 0 and var_182_1 < var_182_7 then
					arg_179_1.talkMaxDuration = var_182_7

					if var_182_7 + var_182_0 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_7 + var_182_0
					end
				end

				arg_179_1.text_.text = var_182_4
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107505", "1107505044", "story_v_side_new_1107505.awb") ~= 0 then
					local var_182_8 = manager.audio:GetVoiceLength("story_v_side_new_1107505", "1107505044", "story_v_side_new_1107505.awb") / 1000

					if var_182_8 + var_182_0 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_8 + var_182_0
					end

					if var_182_3.prefab_name ~= "" and arg_179_1.actors_[var_182_3.prefab_name] ~= nil then
						local var_182_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_3.prefab_name].transform, "story_v_side_new_1107505", "1107505044", "story_v_side_new_1107505.awb")

						arg_179_1:RecordAudio("1107505044", var_182_9)
						arg_179_1:RecordAudio("1107505044", var_182_9)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_side_new_1107505", "1107505044", "story_v_side_new_1107505.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_side_new_1107505", "1107505044", "story_v_side_new_1107505.awb")
				end

				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_10 = math.max(var_182_1, arg_179_1.talkMaxDuration)

			if var_182_0 <= arg_179_1.time_ and arg_179_1.time_ < var_182_0 + var_182_10 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_0) / var_182_10

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_0 + var_182_10 and arg_179_1.time_ < var_182_0 + var_182_10 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play1107505045 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 1107505045
		arg_183_1.duration_ = 5

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play1107505046(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = 0
			local var_186_1 = 0.4

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

				local var_186_2 = arg_183_1:GetWordFromCfg(1107505045)
				local var_186_3 = arg_183_1:FormatText(var_186_2.content)

				arg_183_1.text_.text = var_186_3

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_4 = 16
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
	Play1107505046 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 1107505046
		arg_187_1.duration_ = 7.87

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play1107505047(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = "10044ui_story"

			if arg_187_1.actors_[var_190_0] == nil then
				local var_190_1 = Asset.Load("Char/" .. "10044ui_story")

				if not isNil(var_190_1) then
					local var_190_2 = Object.Instantiate(Asset.Load("Char/" .. "10044ui_story"), arg_187_1.stage_.transform)

					var_190_2.name = var_190_0
					var_190_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_187_1.actors_[var_190_0] = var_190_2

					local var_190_3 = var_190_2:GetComponentInChildren(typeof(CharacterEffect))

					var_190_3.enabled = true

					local var_190_4 = GameObjectTools.GetOrAddComponent(var_190_2, typeof(DynamicBoneHelper))

					if var_190_4 then
						var_190_4:EnableDynamicBone(false)
					end

					arg_187_1:ShowWeapon(var_190_3.transform, false)

					arg_187_1.var_[var_190_0 .. "Animator"] = var_190_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_187_1.var_[var_190_0 .. "Animator"].applyRootMotion = true
					arg_187_1.var_[var_190_0 .. "LipSync"] = var_190_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_190_5 = arg_187_1.actors_["10044ui_story"].transform
			local var_190_6 = 0

			if var_190_6 < arg_187_1.time_ and arg_187_1.time_ <= var_190_6 + arg_190_0 then
				arg_187_1.var_.moveOldPos10044ui_story = var_190_5.localPosition
			end

			local var_190_7 = 0.001

			if var_190_6 <= arg_187_1.time_ and arg_187_1.time_ < var_190_6 + var_190_7 then
				local var_190_8 = (arg_187_1.time_ - var_190_6) / var_190_7
				local var_190_9 = Vector3.New(0, -0.72, -6.3)

				var_190_5.localPosition = Vector3.Lerp(arg_187_1.var_.moveOldPos10044ui_story, var_190_9, var_190_8)

				local var_190_10 = manager.ui.mainCamera.transform.position - var_190_5.position

				var_190_5.forward = Vector3.New(var_190_10.x, var_190_10.y, var_190_10.z)

				local var_190_11 = var_190_5.localEulerAngles

				var_190_11.z = 0
				var_190_11.x = 0
				var_190_5.localEulerAngles = var_190_11
			end

			if arg_187_1.time_ >= var_190_6 + var_190_7 and arg_187_1.time_ < var_190_6 + var_190_7 + arg_190_0 then
				var_190_5.localPosition = Vector3.New(0, -0.72, -6.3)

				local var_190_12 = manager.ui.mainCamera.transform.position - var_190_5.position

				var_190_5.forward = Vector3.New(var_190_12.x, var_190_12.y, var_190_12.z)

				local var_190_13 = var_190_5.localEulerAngles

				var_190_13.z = 0
				var_190_13.x = 0
				var_190_5.localEulerAngles = var_190_13
			end

			local var_190_14 = arg_187_1.actors_["10044ui_story"]
			local var_190_15 = 0

			if var_190_15 < arg_187_1.time_ and arg_187_1.time_ <= var_190_15 + arg_190_0 and not isNil(var_190_14) and arg_187_1.var_.characterEffect10044ui_story == nil then
				arg_187_1.var_.characterEffect10044ui_story = var_190_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_16 = 0.200000002980232

			if var_190_15 <= arg_187_1.time_ and arg_187_1.time_ < var_190_15 + var_190_16 and not isNil(var_190_14) then
				local var_190_17 = (arg_187_1.time_ - var_190_15) / var_190_16

				if arg_187_1.var_.characterEffect10044ui_story and not isNil(var_190_14) then
					arg_187_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_187_1.time_ >= var_190_15 + var_190_16 and arg_187_1.time_ < var_190_15 + var_190_16 + arg_190_0 and not isNil(var_190_14) and arg_187_1.var_.characterEffect10044ui_story then
				arg_187_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			local var_190_18 = 0

			if var_190_18 < arg_187_1.time_ and arg_187_1.time_ <= var_190_18 + arg_190_0 then
				arg_187_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action3_1")
			end

			local var_190_19 = 0

			if var_190_19 < arg_187_1.time_ and arg_187_1.time_ <= var_190_19 + arg_190_0 then
				arg_187_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva", "EmotionTimelineAnimator")
			end

			local var_190_20 = 0
			local var_190_21 = 0.825

			if var_190_20 < arg_187_1.time_ and arg_187_1.time_ <= var_190_20 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				local var_190_22 = arg_187_1:FormatText(StoryNameCfg[380].name)

				arg_187_1.leftNameTxt_.text = var_190_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_23 = arg_187_1:GetWordFromCfg(1107505046)
				local var_190_24 = arg_187_1:FormatText(var_190_23.content)

				arg_187_1.text_.text = var_190_24

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_25 = 33
				local var_190_26 = utf8.len(var_190_24)
				local var_190_27 = var_190_25 <= 0 and var_190_21 or var_190_21 * (var_190_26 / var_190_25)

				if var_190_27 > 0 and var_190_21 < var_190_27 then
					arg_187_1.talkMaxDuration = var_190_27

					if var_190_27 + var_190_20 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_27 + var_190_20
					end
				end

				arg_187_1.text_.text = var_190_24
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107505", "1107505046", "story_v_side_new_1107505.awb") ~= 0 then
					local var_190_28 = manager.audio:GetVoiceLength("story_v_side_new_1107505", "1107505046", "story_v_side_new_1107505.awb") / 1000

					if var_190_28 + var_190_20 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_28 + var_190_20
					end

					if var_190_23.prefab_name ~= "" and arg_187_1.actors_[var_190_23.prefab_name] ~= nil then
						local var_190_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_187_1.actors_[var_190_23.prefab_name].transform, "story_v_side_new_1107505", "1107505046", "story_v_side_new_1107505.awb")

						arg_187_1:RecordAudio("1107505046", var_190_29)
						arg_187_1:RecordAudio("1107505046", var_190_29)
					else
						arg_187_1:AudioAction("play", "voice", "story_v_side_new_1107505", "1107505046", "story_v_side_new_1107505.awb")
					end

					arg_187_1:RecordHistoryTalkVoice("story_v_side_new_1107505", "1107505046", "story_v_side_new_1107505.awb")
				end

				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_30 = math.max(var_190_21, arg_187_1.talkMaxDuration)

			if var_190_20 <= arg_187_1.time_ and arg_187_1.time_ < var_190_20 + var_190_30 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_20) / var_190_30

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_20 + var_190_30 and arg_187_1.time_ < var_190_20 + var_190_30 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_187_1:InitPlayNodeList()
	end,
	Play1107505047 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 1107505047
		arg_191_1.duration_ = 5

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play1107505048(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = arg_191_1.actors_["10044ui_story"]
			local var_194_1 = 0

			if var_194_1 < arg_191_1.time_ and arg_191_1.time_ <= var_194_1 + arg_194_0 and not isNil(var_194_0) and arg_191_1.var_.characterEffect10044ui_story == nil then
				arg_191_1.var_.characterEffect10044ui_story = var_194_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_194_2 = 0.200000002980232

			if var_194_1 <= arg_191_1.time_ and arg_191_1.time_ < var_194_1 + var_194_2 and not isNil(var_194_0) then
				local var_194_3 = (arg_191_1.time_ - var_194_1) / var_194_2

				if arg_191_1.var_.characterEffect10044ui_story and not isNil(var_194_0) then
					local var_194_4 = Mathf.Lerp(0, 0.5, var_194_3)

					arg_191_1.var_.characterEffect10044ui_story.fillFlat = true
					arg_191_1.var_.characterEffect10044ui_story.fillRatio = var_194_4
				end
			end

			if arg_191_1.time_ >= var_194_1 + var_194_2 and arg_191_1.time_ < var_194_1 + var_194_2 + arg_194_0 and not isNil(var_194_0) and arg_191_1.var_.characterEffect10044ui_story then
				local var_194_5 = 0.5

				arg_191_1.var_.characterEffect10044ui_story.fillFlat = true
				arg_191_1.var_.characterEffect10044ui_story.fillRatio = var_194_5
			end

			local var_194_6 = 0
			local var_194_7 = 0.525

			if var_194_6 < arg_191_1.time_ and arg_191_1.time_ <= var_194_6 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				local var_194_8 = arg_191_1:FormatText(StoryNameCfg[7].name)

				arg_191_1.leftNameTxt_.text = var_194_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, true)
				arg_191_1.iconController_:SetSelectedState("hero")

				arg_191_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_191_1.callingController_:SetSelectedState("normal")

				arg_191_1.keyicon_.color = Color.New(1, 1, 1)
				arg_191_1.icon_.color = Color.New(1, 1, 1)

				local var_194_9 = arg_191_1:GetWordFromCfg(1107505047)
				local var_194_10 = arg_191_1:FormatText(var_194_9.content)

				arg_191_1.text_.text = var_194_10

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_11 = 21
				local var_194_12 = utf8.len(var_194_10)
				local var_194_13 = var_194_11 <= 0 and var_194_7 or var_194_7 * (var_194_12 / var_194_11)

				if var_194_13 > 0 and var_194_7 < var_194_13 then
					arg_191_1.talkMaxDuration = var_194_13

					if var_194_13 + var_194_6 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_13 + var_194_6
					end
				end

				arg_191_1.text_.text = var_194_10
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)
				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_14 = math.max(var_194_7, arg_191_1.talkMaxDuration)

			if var_194_6 <= arg_191_1.time_ and arg_191_1.time_ < var_194_6 + var_194_14 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_6) / var_194_14

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_6 + var_194_14 and arg_191_1.time_ < var_194_6 + var_194_14 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {}

		arg_191_1:InitPlayNodeList()
	end,
	Play1107505048 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 1107505048
		arg_195_1.duration_ = 5.77

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play1107505049(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = arg_195_1.actors_["10044ui_story"]
			local var_198_1 = 0

			if var_198_1 < arg_195_1.time_ and arg_195_1.time_ <= var_198_1 + arg_198_0 and not isNil(var_198_0) and arg_195_1.var_.characterEffect10044ui_story == nil then
				arg_195_1.var_.characterEffect10044ui_story = var_198_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_198_2 = 0.200000002980232

			if var_198_1 <= arg_195_1.time_ and arg_195_1.time_ < var_198_1 + var_198_2 and not isNil(var_198_0) then
				local var_198_3 = (arg_195_1.time_ - var_198_1) / var_198_2

				if arg_195_1.var_.characterEffect10044ui_story and not isNil(var_198_0) then
					arg_195_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_195_1.time_ >= var_198_1 + var_198_2 and arg_195_1.time_ < var_198_1 + var_198_2 + arg_198_0 and not isNil(var_198_0) and arg_195_1.var_.characterEffect10044ui_story then
				arg_195_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			local var_198_4 = 0

			if var_198_4 < arg_195_1.time_ and arg_195_1.time_ <= var_198_4 + arg_198_0 then
				arg_195_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action3_2")
			end

			local var_198_5 = 0

			if var_198_5 < arg_195_1.time_ and arg_195_1.time_ <= var_198_5 + arg_198_0 then
				arg_195_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_198_6 = 0
			local var_198_7 = 0.8

			if var_198_6 < arg_195_1.time_ and arg_195_1.time_ <= var_198_6 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				local var_198_8 = arg_195_1:FormatText(StoryNameCfg[380].name)

				arg_195_1.leftNameTxt_.text = var_198_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_9 = arg_195_1:GetWordFromCfg(1107505048)
				local var_198_10 = arg_195_1:FormatText(var_198_9.content)

				arg_195_1.text_.text = var_198_10

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_11 = 32
				local var_198_12 = utf8.len(var_198_10)
				local var_198_13 = var_198_11 <= 0 and var_198_7 or var_198_7 * (var_198_12 / var_198_11)

				if var_198_13 > 0 and var_198_7 < var_198_13 then
					arg_195_1.talkMaxDuration = var_198_13

					if var_198_13 + var_198_6 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_13 + var_198_6
					end
				end

				arg_195_1.text_.text = var_198_10
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107505", "1107505048", "story_v_side_new_1107505.awb") ~= 0 then
					local var_198_14 = manager.audio:GetVoiceLength("story_v_side_new_1107505", "1107505048", "story_v_side_new_1107505.awb") / 1000

					if var_198_14 + var_198_6 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_14 + var_198_6
					end

					if var_198_9.prefab_name ~= "" and arg_195_1.actors_[var_198_9.prefab_name] ~= nil then
						local var_198_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_9.prefab_name].transform, "story_v_side_new_1107505", "1107505048", "story_v_side_new_1107505.awb")

						arg_195_1:RecordAudio("1107505048", var_198_15)
						arg_195_1:RecordAudio("1107505048", var_198_15)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_side_new_1107505", "1107505048", "story_v_side_new_1107505.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_side_new_1107505", "1107505048", "story_v_side_new_1107505.awb")
				end

				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_16 = math.max(var_198_7, arg_195_1.talkMaxDuration)

			if var_198_6 <= arg_195_1.time_ and arg_195_1.time_ < var_198_6 + var_198_16 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_6) / var_198_16

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_6 + var_198_16 and arg_195_1.time_ < var_198_6 + var_198_16 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {}

		arg_195_1:InitPlayNodeList()
	end,
	Play1107505049 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 1107505049
		arg_199_1.duration_ = 4.67

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play1107505050(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = 0
			local var_202_1 = 0.525

			if var_202_0 < arg_199_1.time_ and arg_199_1.time_ <= var_202_0 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				local var_202_2 = arg_199_1:FormatText(StoryNameCfg[380].name)

				arg_199_1.leftNameTxt_.text = var_202_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_3 = arg_199_1:GetWordFromCfg(1107505049)
				local var_202_4 = arg_199_1:FormatText(var_202_3.content)

				arg_199_1.text_.text = var_202_4

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_5 = 21
				local var_202_6 = utf8.len(var_202_4)
				local var_202_7 = var_202_5 <= 0 and var_202_1 or var_202_1 * (var_202_6 / var_202_5)

				if var_202_7 > 0 and var_202_1 < var_202_7 then
					arg_199_1.talkMaxDuration = var_202_7

					if var_202_7 + var_202_0 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_7 + var_202_0
					end
				end

				arg_199_1.text_.text = var_202_4
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107505", "1107505049", "story_v_side_new_1107505.awb") ~= 0 then
					local var_202_8 = manager.audio:GetVoiceLength("story_v_side_new_1107505", "1107505049", "story_v_side_new_1107505.awb") / 1000

					if var_202_8 + var_202_0 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_8 + var_202_0
					end

					if var_202_3.prefab_name ~= "" and arg_199_1.actors_[var_202_3.prefab_name] ~= nil then
						local var_202_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_199_1.actors_[var_202_3.prefab_name].transform, "story_v_side_new_1107505", "1107505049", "story_v_side_new_1107505.awb")

						arg_199_1:RecordAudio("1107505049", var_202_9)
						arg_199_1:RecordAudio("1107505049", var_202_9)
					else
						arg_199_1:AudioAction("play", "voice", "story_v_side_new_1107505", "1107505049", "story_v_side_new_1107505.awb")
					end

					arg_199_1:RecordHistoryTalkVoice("story_v_side_new_1107505", "1107505049", "story_v_side_new_1107505.awb")
				end

				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_10 = math.max(var_202_1, arg_199_1.talkMaxDuration)

			if var_202_0 <= arg_199_1.time_ and arg_199_1.time_ < var_202_0 + var_202_10 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_0) / var_202_10

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_0 + var_202_10 and arg_199_1.time_ < var_202_0 + var_202_10 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {}

		arg_199_1:InitPlayNodeList()
	end,
	Play1107505050 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 1107505050
		arg_203_1.duration_ = 9.57

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play1107505051(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			local var_206_0 = 0
			local var_206_1 = 1.175

			if var_206_0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_0 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				local var_206_2 = arg_203_1:FormatText(StoryNameCfg[380].name)

				arg_203_1.leftNameTxt_.text = var_206_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_3 = arg_203_1:GetWordFromCfg(1107505050)
				local var_206_4 = arg_203_1:FormatText(var_206_3.content)

				arg_203_1.text_.text = var_206_4

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_5 = 47
				local var_206_6 = utf8.len(var_206_4)
				local var_206_7 = var_206_5 <= 0 and var_206_1 or var_206_1 * (var_206_6 / var_206_5)

				if var_206_7 > 0 and var_206_1 < var_206_7 then
					arg_203_1.talkMaxDuration = var_206_7

					if var_206_7 + var_206_0 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_7 + var_206_0
					end
				end

				arg_203_1.text_.text = var_206_4
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107505", "1107505050", "story_v_side_new_1107505.awb") ~= 0 then
					local var_206_8 = manager.audio:GetVoiceLength("story_v_side_new_1107505", "1107505050", "story_v_side_new_1107505.awb") / 1000

					if var_206_8 + var_206_0 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_8 + var_206_0
					end

					if var_206_3.prefab_name ~= "" and arg_203_1.actors_[var_206_3.prefab_name] ~= nil then
						local var_206_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_3.prefab_name].transform, "story_v_side_new_1107505", "1107505050", "story_v_side_new_1107505.awb")

						arg_203_1:RecordAudio("1107505050", var_206_9)
						arg_203_1:RecordAudio("1107505050", var_206_9)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_side_new_1107505", "1107505050", "story_v_side_new_1107505.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_side_new_1107505", "1107505050", "story_v_side_new_1107505.awb")
				end

				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_10 = math.max(var_206_1, arg_203_1.talkMaxDuration)

			if var_206_0 <= arg_203_1.time_ and arg_203_1.time_ < var_206_0 + var_206_10 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_0) / var_206_10

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_0 + var_206_10 and arg_203_1.time_ < var_206_0 + var_206_10 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {}

		arg_203_1:InitPlayNodeList()
	end,
	Play1107505051 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 1107505051
		arg_207_1.duration_ = 5

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play1107505052(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			local var_210_0 = arg_207_1.actors_["10044ui_story"]
			local var_210_1 = 0

			if var_210_1 < arg_207_1.time_ and arg_207_1.time_ <= var_210_1 + arg_210_0 and not isNil(var_210_0) and arg_207_1.var_.characterEffect10044ui_story == nil then
				arg_207_1.var_.characterEffect10044ui_story = var_210_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_2 = 0.200000002980232

			if var_210_1 <= arg_207_1.time_ and arg_207_1.time_ < var_210_1 + var_210_2 and not isNil(var_210_0) then
				local var_210_3 = (arg_207_1.time_ - var_210_1) / var_210_2

				if arg_207_1.var_.characterEffect10044ui_story and not isNil(var_210_0) then
					local var_210_4 = Mathf.Lerp(0, 0.5, var_210_3)

					arg_207_1.var_.characterEffect10044ui_story.fillFlat = true
					arg_207_1.var_.characterEffect10044ui_story.fillRatio = var_210_4
				end
			end

			if arg_207_1.time_ >= var_210_1 + var_210_2 and arg_207_1.time_ < var_210_1 + var_210_2 + arg_210_0 and not isNil(var_210_0) and arg_207_1.var_.characterEffect10044ui_story then
				local var_210_5 = 0.5

				arg_207_1.var_.characterEffect10044ui_story.fillFlat = true
				arg_207_1.var_.characterEffect10044ui_story.fillRatio = var_210_5
			end

			local var_210_6 = 0
			local var_210_7 = 0.275

			if var_210_6 < arg_207_1.time_ and arg_207_1.time_ <= var_210_6 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				local var_210_8 = arg_207_1:FormatText(StoryNameCfg[7].name)

				arg_207_1.leftNameTxt_.text = var_210_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, true)
				arg_207_1.iconController_:SetSelectedState("hero")

				arg_207_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_207_1.callingController_:SetSelectedState("normal")

				arg_207_1.keyicon_.color = Color.New(1, 1, 1)
				arg_207_1.icon_.color = Color.New(1, 1, 1)

				local var_210_9 = arg_207_1:GetWordFromCfg(1107505051)
				local var_210_10 = arg_207_1:FormatText(var_210_9.content)

				arg_207_1.text_.text = var_210_10

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_11 = 11
				local var_210_12 = utf8.len(var_210_10)
				local var_210_13 = var_210_11 <= 0 and var_210_7 or var_210_7 * (var_210_12 / var_210_11)

				if var_210_13 > 0 and var_210_7 < var_210_13 then
					arg_207_1.talkMaxDuration = var_210_13

					if var_210_13 + var_210_6 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_13 + var_210_6
					end
				end

				arg_207_1.text_.text = var_210_10
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)
				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_14 = math.max(var_210_7, arg_207_1.talkMaxDuration)

			if var_210_6 <= arg_207_1.time_ and arg_207_1.time_ < var_210_6 + var_210_14 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_6) / var_210_14

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_6 + var_210_14 and arg_207_1.time_ < var_210_6 + var_210_14 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {}

		arg_207_1:InitPlayNodeList()
	end,
	Play1107505052 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 1107505052
		arg_211_1.duration_ = 4.83

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play1107505053(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			local var_214_0 = arg_211_1.actors_["10044ui_story"]
			local var_214_1 = 0

			if var_214_1 < arg_211_1.time_ and arg_211_1.time_ <= var_214_1 + arg_214_0 and not isNil(var_214_0) and arg_211_1.var_.characterEffect10044ui_story == nil then
				arg_211_1.var_.characterEffect10044ui_story = var_214_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_214_2 = 0.200000002980232

			if var_214_1 <= arg_211_1.time_ and arg_211_1.time_ < var_214_1 + var_214_2 and not isNil(var_214_0) then
				local var_214_3 = (arg_211_1.time_ - var_214_1) / var_214_2

				if arg_211_1.var_.characterEffect10044ui_story and not isNil(var_214_0) then
					arg_211_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_211_1.time_ >= var_214_1 + var_214_2 and arg_211_1.time_ < var_214_1 + var_214_2 + arg_214_0 and not isNil(var_214_0) and arg_211_1.var_.characterEffect10044ui_story then
				arg_211_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			local var_214_4 = 0

			if var_214_4 < arg_211_1.time_ and arg_211_1.time_ <= var_214_4 + arg_214_0 then
				arg_211_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action5_1")
			end

			local var_214_5 = 0

			if var_214_5 < arg_211_1.time_ and arg_211_1.time_ <= var_214_5 + arg_214_0 then
				arg_211_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_214_6 = 0
			local var_214_7 = 0.625

			if var_214_6 < arg_211_1.time_ and arg_211_1.time_ <= var_214_6 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, true)

				local var_214_8 = arg_211_1:FormatText(StoryNameCfg[380].name)

				arg_211_1.leftNameTxt_.text = var_214_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_211_1.leftNameTxt_.transform)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1.leftNameTxt_.text)
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_9 = arg_211_1:GetWordFromCfg(1107505052)
				local var_214_10 = arg_211_1:FormatText(var_214_9.content)

				arg_211_1.text_.text = var_214_10

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_11 = 25
				local var_214_12 = utf8.len(var_214_10)
				local var_214_13 = var_214_11 <= 0 and var_214_7 or var_214_7 * (var_214_12 / var_214_11)

				if var_214_13 > 0 and var_214_7 < var_214_13 then
					arg_211_1.talkMaxDuration = var_214_13

					if var_214_13 + var_214_6 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_13 + var_214_6
					end
				end

				arg_211_1.text_.text = var_214_10
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107505", "1107505052", "story_v_side_new_1107505.awb") ~= 0 then
					local var_214_14 = manager.audio:GetVoiceLength("story_v_side_new_1107505", "1107505052", "story_v_side_new_1107505.awb") / 1000

					if var_214_14 + var_214_6 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_14 + var_214_6
					end

					if var_214_9.prefab_name ~= "" and arg_211_1.actors_[var_214_9.prefab_name] ~= nil then
						local var_214_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_211_1.actors_[var_214_9.prefab_name].transform, "story_v_side_new_1107505", "1107505052", "story_v_side_new_1107505.awb")

						arg_211_1:RecordAudio("1107505052", var_214_15)
						arg_211_1:RecordAudio("1107505052", var_214_15)
					else
						arg_211_1:AudioAction("play", "voice", "story_v_side_new_1107505", "1107505052", "story_v_side_new_1107505.awb")
					end

					arg_211_1:RecordHistoryTalkVoice("story_v_side_new_1107505", "1107505052", "story_v_side_new_1107505.awb")
				end

				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_16 = math.max(var_214_7, arg_211_1.talkMaxDuration)

			if var_214_6 <= arg_211_1.time_ and arg_211_1.time_ < var_214_6 + var_214_16 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_6) / var_214_16

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_6 + var_214_16 and arg_211_1.time_ < var_214_6 + var_214_16 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {}

		arg_211_1:InitPlayNodeList()
	end,
	Play1107505053 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 1107505053
		arg_215_1.duration_ = 5

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play1107505054(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			local var_218_0 = arg_215_1.actors_["10044ui_story"]
			local var_218_1 = 0

			if var_218_1 < arg_215_1.time_ and arg_215_1.time_ <= var_218_1 + arg_218_0 and not isNil(var_218_0) and arg_215_1.var_.characterEffect10044ui_story == nil then
				arg_215_1.var_.characterEffect10044ui_story = var_218_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_218_2 = 0.200000002980232

			if var_218_1 <= arg_215_1.time_ and arg_215_1.time_ < var_218_1 + var_218_2 and not isNil(var_218_0) then
				local var_218_3 = (arg_215_1.time_ - var_218_1) / var_218_2

				if arg_215_1.var_.characterEffect10044ui_story and not isNil(var_218_0) then
					local var_218_4 = Mathf.Lerp(0, 0.5, var_218_3)

					arg_215_1.var_.characterEffect10044ui_story.fillFlat = true
					arg_215_1.var_.characterEffect10044ui_story.fillRatio = var_218_4
				end
			end

			if arg_215_1.time_ >= var_218_1 + var_218_2 and arg_215_1.time_ < var_218_1 + var_218_2 + arg_218_0 and not isNil(var_218_0) and arg_215_1.var_.characterEffect10044ui_story then
				local var_218_5 = 0.5

				arg_215_1.var_.characterEffect10044ui_story.fillFlat = true
				arg_215_1.var_.characterEffect10044ui_story.fillRatio = var_218_5
			end

			local var_218_6 = 0
			local var_218_7 = 0.875

			if var_218_6 < arg_215_1.time_ and arg_215_1.time_ <= var_218_6 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				local var_218_8 = arg_215_1:FormatText(StoryNameCfg[7].name)

				arg_215_1.leftNameTxt_.text = var_218_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, true)
				arg_215_1.iconController_:SetSelectedState("hero")

				arg_215_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_215_1.callingController_:SetSelectedState("normal")

				arg_215_1.keyicon_.color = Color.New(1, 1, 1)
				arg_215_1.icon_.color = Color.New(1, 1, 1)

				local var_218_9 = arg_215_1:GetWordFromCfg(1107505053)
				local var_218_10 = arg_215_1:FormatText(var_218_9.content)

				arg_215_1.text_.text = var_218_10

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_11 = 35
				local var_218_12 = utf8.len(var_218_10)
				local var_218_13 = var_218_11 <= 0 and var_218_7 or var_218_7 * (var_218_12 / var_218_11)

				if var_218_13 > 0 and var_218_7 < var_218_13 then
					arg_215_1.talkMaxDuration = var_218_13

					if var_218_13 + var_218_6 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_13 + var_218_6
					end
				end

				arg_215_1.text_.text = var_218_10
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)
				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_14 = math.max(var_218_7, arg_215_1.talkMaxDuration)

			if var_218_6 <= arg_215_1.time_ and arg_215_1.time_ < var_218_6 + var_218_14 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_6) / var_218_14

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_6 + var_218_14 and arg_215_1.time_ < var_218_6 + var_218_14 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {}

		arg_215_1:InitPlayNodeList()
	end,
	Play1107505054 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 1107505054
		arg_219_1.duration_ = 8.43

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play1107505055(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			local var_222_0 = arg_219_1.actors_["10044ui_story"]
			local var_222_1 = 0

			if var_222_1 < arg_219_1.time_ and arg_219_1.time_ <= var_222_1 + arg_222_0 and not isNil(var_222_0) and arg_219_1.var_.characterEffect10044ui_story == nil then
				arg_219_1.var_.characterEffect10044ui_story = var_222_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_222_2 = 0.200000002980232

			if var_222_1 <= arg_219_1.time_ and arg_219_1.time_ < var_222_1 + var_222_2 and not isNil(var_222_0) then
				local var_222_3 = (arg_219_1.time_ - var_222_1) / var_222_2

				if arg_219_1.var_.characterEffect10044ui_story and not isNil(var_222_0) then
					arg_219_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_219_1.time_ >= var_222_1 + var_222_2 and arg_219_1.time_ < var_222_1 + var_222_2 + arg_222_0 and not isNil(var_222_0) and arg_219_1.var_.characterEffect10044ui_story then
				arg_219_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			local var_222_4 = 0

			if var_222_4 < arg_219_1.time_ and arg_219_1.time_ <= var_222_4 + arg_222_0 then
				arg_219_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action5_2")
			end

			local var_222_5 = 0

			if var_222_5 < arg_219_1.time_ and arg_219_1.time_ <= var_222_5 + arg_222_0 then
				arg_219_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_222_6 = 0
			local var_222_7 = 0.975

			if var_222_6 < arg_219_1.time_ and arg_219_1.time_ <= var_222_6 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				local var_222_8 = arg_219_1:FormatText(StoryNameCfg[380].name)

				arg_219_1.leftNameTxt_.text = var_222_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_9 = arg_219_1:GetWordFromCfg(1107505054)
				local var_222_10 = arg_219_1:FormatText(var_222_9.content)

				arg_219_1.text_.text = var_222_10

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_11 = 39
				local var_222_12 = utf8.len(var_222_10)
				local var_222_13 = var_222_11 <= 0 and var_222_7 or var_222_7 * (var_222_12 / var_222_11)

				if var_222_13 > 0 and var_222_7 < var_222_13 then
					arg_219_1.talkMaxDuration = var_222_13

					if var_222_13 + var_222_6 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_13 + var_222_6
					end
				end

				arg_219_1.text_.text = var_222_10
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107505", "1107505054", "story_v_side_new_1107505.awb") ~= 0 then
					local var_222_14 = manager.audio:GetVoiceLength("story_v_side_new_1107505", "1107505054", "story_v_side_new_1107505.awb") / 1000

					if var_222_14 + var_222_6 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_14 + var_222_6
					end

					if var_222_9.prefab_name ~= "" and arg_219_1.actors_[var_222_9.prefab_name] ~= nil then
						local var_222_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_219_1.actors_[var_222_9.prefab_name].transform, "story_v_side_new_1107505", "1107505054", "story_v_side_new_1107505.awb")

						arg_219_1:RecordAudio("1107505054", var_222_15)
						arg_219_1:RecordAudio("1107505054", var_222_15)
					else
						arg_219_1:AudioAction("play", "voice", "story_v_side_new_1107505", "1107505054", "story_v_side_new_1107505.awb")
					end

					arg_219_1:RecordHistoryTalkVoice("story_v_side_new_1107505", "1107505054", "story_v_side_new_1107505.awb")
				end

				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_16 = math.max(var_222_7, arg_219_1.talkMaxDuration)

			if var_222_6 <= arg_219_1.time_ and arg_219_1.time_ < var_222_6 + var_222_16 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_6) / var_222_16

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_6 + var_222_16 and arg_219_1.time_ < var_222_6 + var_222_16 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {}

		arg_219_1:InitPlayNodeList()
	end,
	Play1107505055 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 1107505055
		arg_223_1.duration_ = 5

		SetActive(arg_223_1.tipsGo_, false)

		function arg_223_1.onSingleLineFinish_()
			arg_223_1.onSingleLineUpdate_ = nil
			arg_223_1.onSingleLineFinish_ = nil
			arg_223_1.state_ = "waiting"
		end

		function arg_223_1.playNext_(arg_225_0)
			if arg_225_0 == 1 then
				arg_223_0:Play1107505056(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			local var_226_0 = arg_223_1.actors_["10044ui_story"]
			local var_226_1 = 0

			if var_226_1 < arg_223_1.time_ and arg_223_1.time_ <= var_226_1 + arg_226_0 and not isNil(var_226_0) and arg_223_1.var_.characterEffect10044ui_story == nil then
				arg_223_1.var_.characterEffect10044ui_story = var_226_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_226_2 = 0.200000002980232

			if var_226_1 <= arg_223_1.time_ and arg_223_1.time_ < var_226_1 + var_226_2 and not isNil(var_226_0) then
				local var_226_3 = (arg_223_1.time_ - var_226_1) / var_226_2

				if arg_223_1.var_.characterEffect10044ui_story and not isNil(var_226_0) then
					local var_226_4 = Mathf.Lerp(0, 0.5, var_226_3)

					arg_223_1.var_.characterEffect10044ui_story.fillFlat = true
					arg_223_1.var_.characterEffect10044ui_story.fillRatio = var_226_4
				end
			end

			if arg_223_1.time_ >= var_226_1 + var_226_2 and arg_223_1.time_ < var_226_1 + var_226_2 + arg_226_0 and not isNil(var_226_0) and arg_223_1.var_.characterEffect10044ui_story then
				local var_226_5 = 0.5

				arg_223_1.var_.characterEffect10044ui_story.fillFlat = true
				arg_223_1.var_.characterEffect10044ui_story.fillRatio = var_226_5
			end

			local var_226_6 = 0
			local var_226_7 = 0.175

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

				arg_223_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_223_1.callingController_:SetSelectedState("normal")

				arg_223_1.keyicon_.color = Color.New(1, 1, 1)
				arg_223_1.icon_.color = Color.New(1, 1, 1)

				local var_226_9 = arg_223_1:GetWordFromCfg(1107505055)
				local var_226_10 = arg_223_1:FormatText(var_226_9.content)

				arg_223_1.text_.text = var_226_10

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_11 = 7
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
	Play1107505056 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 1107505056
		arg_227_1.duration_ = 6.97

		SetActive(arg_227_1.tipsGo_, false)

		function arg_227_1.onSingleLineFinish_()
			arg_227_1.onSingleLineUpdate_ = nil
			arg_227_1.onSingleLineFinish_ = nil
			arg_227_1.state_ = "waiting"
		end

		function arg_227_1.playNext_(arg_229_0)
			if arg_229_0 == 1 then
				arg_227_0:Play1107505057(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			local var_230_0 = arg_227_1.actors_["10044ui_story"]
			local var_230_1 = 0

			if var_230_1 < arg_227_1.time_ and arg_227_1.time_ <= var_230_1 + arg_230_0 and not isNil(var_230_0) and arg_227_1.var_.characterEffect10044ui_story == nil then
				arg_227_1.var_.characterEffect10044ui_story = var_230_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_230_2 = 0.200000002980232

			if var_230_1 <= arg_227_1.time_ and arg_227_1.time_ < var_230_1 + var_230_2 and not isNil(var_230_0) then
				local var_230_3 = (arg_227_1.time_ - var_230_1) / var_230_2

				if arg_227_1.var_.characterEffect10044ui_story and not isNil(var_230_0) then
					arg_227_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_227_1.time_ >= var_230_1 + var_230_2 and arg_227_1.time_ < var_230_1 + var_230_2 + arg_230_0 and not isNil(var_230_0) and arg_227_1.var_.characterEffect10044ui_story then
				arg_227_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			local var_230_4 = 0

			if var_230_4 < arg_227_1.time_ and arg_227_1.time_ <= var_230_4 + arg_230_0 then
				arg_227_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action1_1")
			end

			local var_230_5 = 0

			if var_230_5 < arg_227_1.time_ and arg_227_1.time_ <= var_230_5 + arg_230_0 then
				arg_227_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_230_6 = 0
			local var_230_7 = 0.85

			if var_230_6 < arg_227_1.time_ and arg_227_1.time_ <= var_230_6 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				local var_230_8 = arg_227_1:FormatText(StoryNameCfg[380].name)

				arg_227_1.leftNameTxt_.text = var_230_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_9 = arg_227_1:GetWordFromCfg(1107505056)
				local var_230_10 = arg_227_1:FormatText(var_230_9.content)

				arg_227_1.text_.text = var_230_10

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_11 = 34
				local var_230_12 = utf8.len(var_230_10)
				local var_230_13 = var_230_11 <= 0 and var_230_7 or var_230_7 * (var_230_12 / var_230_11)

				if var_230_13 > 0 and var_230_7 < var_230_13 then
					arg_227_1.talkMaxDuration = var_230_13

					if var_230_13 + var_230_6 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_13 + var_230_6
					end
				end

				arg_227_1.text_.text = var_230_10
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107505", "1107505056", "story_v_side_new_1107505.awb") ~= 0 then
					local var_230_14 = manager.audio:GetVoiceLength("story_v_side_new_1107505", "1107505056", "story_v_side_new_1107505.awb") / 1000

					if var_230_14 + var_230_6 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_14 + var_230_6
					end

					if var_230_9.prefab_name ~= "" and arg_227_1.actors_[var_230_9.prefab_name] ~= nil then
						local var_230_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_227_1.actors_[var_230_9.prefab_name].transform, "story_v_side_new_1107505", "1107505056", "story_v_side_new_1107505.awb")

						arg_227_1:RecordAudio("1107505056", var_230_15)
						arg_227_1:RecordAudio("1107505056", var_230_15)
					else
						arg_227_1:AudioAction("play", "voice", "story_v_side_new_1107505", "1107505056", "story_v_side_new_1107505.awb")
					end

					arg_227_1:RecordHistoryTalkVoice("story_v_side_new_1107505", "1107505056", "story_v_side_new_1107505.awb")
				end

				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_16 = math.max(var_230_7, arg_227_1.talkMaxDuration)

			if var_230_6 <= arg_227_1.time_ and arg_227_1.time_ < var_230_6 + var_230_16 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_6) / var_230_16

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_6 + var_230_16 and arg_227_1.time_ < var_230_6 + var_230_16 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {}

		arg_227_1:InitPlayNodeList()
	end,
	Play1107505057 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 1107505057
		arg_231_1.duration_ = 7.17

		SetActive(arg_231_1.tipsGo_, false)

		function arg_231_1.onSingleLineFinish_()
			arg_231_1.onSingleLineUpdate_ = nil
			arg_231_1.onSingleLineFinish_ = nil
			arg_231_1.state_ = "waiting"
		end

		function arg_231_1.playNext_(arg_233_0)
			if arg_233_0 == 1 then
				arg_231_0:Play1107505058(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			local var_234_0 = 0
			local var_234_1 = 0.9

			if var_234_0 < arg_231_1.time_ and arg_231_1.time_ <= var_234_0 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				local var_234_2 = arg_231_1:FormatText(StoryNameCfg[380].name)

				arg_231_1.leftNameTxt_.text = var_234_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_3 = arg_231_1:GetWordFromCfg(1107505057)
				local var_234_4 = arg_231_1:FormatText(var_234_3.content)

				arg_231_1.text_.text = var_234_4

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_5 = 36
				local var_234_6 = utf8.len(var_234_4)
				local var_234_7 = var_234_5 <= 0 and var_234_1 or var_234_1 * (var_234_6 / var_234_5)

				if var_234_7 > 0 and var_234_1 < var_234_7 then
					arg_231_1.talkMaxDuration = var_234_7

					if var_234_7 + var_234_0 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_7 + var_234_0
					end
				end

				arg_231_1.text_.text = var_234_4
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107505", "1107505057", "story_v_side_new_1107505.awb") ~= 0 then
					local var_234_8 = manager.audio:GetVoiceLength("story_v_side_new_1107505", "1107505057", "story_v_side_new_1107505.awb") / 1000

					if var_234_8 + var_234_0 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_8 + var_234_0
					end

					if var_234_3.prefab_name ~= "" and arg_231_1.actors_[var_234_3.prefab_name] ~= nil then
						local var_234_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_231_1.actors_[var_234_3.prefab_name].transform, "story_v_side_new_1107505", "1107505057", "story_v_side_new_1107505.awb")

						arg_231_1:RecordAudio("1107505057", var_234_9)
						arg_231_1:RecordAudio("1107505057", var_234_9)
					else
						arg_231_1:AudioAction("play", "voice", "story_v_side_new_1107505", "1107505057", "story_v_side_new_1107505.awb")
					end

					arg_231_1:RecordHistoryTalkVoice("story_v_side_new_1107505", "1107505057", "story_v_side_new_1107505.awb")
				end

				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_10 = math.max(var_234_1, arg_231_1.talkMaxDuration)

			if var_234_0 <= arg_231_1.time_ and arg_231_1.time_ < var_234_0 + var_234_10 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_0) / var_234_10

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_0 + var_234_10 and arg_231_1.time_ < var_234_0 + var_234_10 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {}

		arg_231_1:InitPlayNodeList()
	end,
	Play1107505058 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 1107505058
		arg_235_1.duration_ = 5.63

		SetActive(arg_235_1.tipsGo_, false)

		function arg_235_1.onSingleLineFinish_()
			arg_235_1.onSingleLineUpdate_ = nil
			arg_235_1.onSingleLineFinish_ = nil
			arg_235_1.state_ = "waiting"
		end

		function arg_235_1.playNext_(arg_237_0)
			if arg_237_0 == 1 then
				arg_235_0:Play1107505059(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			local var_238_0 = 0

			if var_238_0 < arg_235_1.time_ and arg_235_1.time_ <= var_238_0 + arg_238_0 then
				arg_235_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action5_1")
			end

			local var_238_1 = 0

			if var_238_1 < arg_235_1.time_ and arg_235_1.time_ <= var_238_1 + arg_238_0 then
				arg_235_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_238_2 = 0
			local var_238_3 = 0.675

			if var_238_2 < arg_235_1.time_ and arg_235_1.time_ <= var_238_2 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				local var_238_4 = arg_235_1:FormatText(StoryNameCfg[380].name)

				arg_235_1.leftNameTxt_.text = var_238_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_5 = arg_235_1:GetWordFromCfg(1107505058)
				local var_238_6 = arg_235_1:FormatText(var_238_5.content)

				arg_235_1.text_.text = var_238_6

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_7 = 27
				local var_238_8 = utf8.len(var_238_6)
				local var_238_9 = var_238_7 <= 0 and var_238_3 or var_238_3 * (var_238_8 / var_238_7)

				if var_238_9 > 0 and var_238_3 < var_238_9 then
					arg_235_1.talkMaxDuration = var_238_9

					if var_238_9 + var_238_2 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_9 + var_238_2
					end
				end

				arg_235_1.text_.text = var_238_6
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107505", "1107505058", "story_v_side_new_1107505.awb") ~= 0 then
					local var_238_10 = manager.audio:GetVoiceLength("story_v_side_new_1107505", "1107505058", "story_v_side_new_1107505.awb") / 1000

					if var_238_10 + var_238_2 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_10 + var_238_2
					end

					if var_238_5.prefab_name ~= "" and arg_235_1.actors_[var_238_5.prefab_name] ~= nil then
						local var_238_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_235_1.actors_[var_238_5.prefab_name].transform, "story_v_side_new_1107505", "1107505058", "story_v_side_new_1107505.awb")

						arg_235_1:RecordAudio("1107505058", var_238_11)
						arg_235_1:RecordAudio("1107505058", var_238_11)
					else
						arg_235_1:AudioAction("play", "voice", "story_v_side_new_1107505", "1107505058", "story_v_side_new_1107505.awb")
					end

					arg_235_1:RecordHistoryTalkVoice("story_v_side_new_1107505", "1107505058", "story_v_side_new_1107505.awb")
				end

				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_12 = math.max(var_238_3, arg_235_1.talkMaxDuration)

			if var_238_2 <= arg_235_1.time_ and arg_235_1.time_ < var_238_2 + var_238_12 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_2) / var_238_12

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_2 + var_238_12 and arg_235_1.time_ < var_238_2 + var_238_12 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {}

		arg_235_1:InitPlayNodeList()
	end,
	Play1107505059 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 1107505059
		arg_239_1.duration_ = 5

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play1107505060(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			local var_242_0 = arg_239_1.actors_["10044ui_story"]
			local var_242_1 = 0

			if var_242_1 < arg_239_1.time_ and arg_239_1.time_ <= var_242_1 + arg_242_0 and not isNil(var_242_0) and arg_239_1.var_.characterEffect10044ui_story == nil then
				arg_239_1.var_.characterEffect10044ui_story = var_242_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_242_2 = 0.200000002980232

			if var_242_1 <= arg_239_1.time_ and arg_239_1.time_ < var_242_1 + var_242_2 and not isNil(var_242_0) then
				local var_242_3 = (arg_239_1.time_ - var_242_1) / var_242_2

				if arg_239_1.var_.characterEffect10044ui_story and not isNil(var_242_0) then
					local var_242_4 = Mathf.Lerp(0, 0.5, var_242_3)

					arg_239_1.var_.characterEffect10044ui_story.fillFlat = true
					arg_239_1.var_.characterEffect10044ui_story.fillRatio = var_242_4
				end
			end

			if arg_239_1.time_ >= var_242_1 + var_242_2 and arg_239_1.time_ < var_242_1 + var_242_2 + arg_242_0 and not isNil(var_242_0) and arg_239_1.var_.characterEffect10044ui_story then
				local var_242_5 = 0.5

				arg_239_1.var_.characterEffect10044ui_story.fillFlat = true
				arg_239_1.var_.characterEffect10044ui_story.fillRatio = var_242_5
			end

			local var_242_6 = 0
			local var_242_7 = 0.75

			if var_242_6 < arg_239_1.time_ and arg_239_1.time_ <= var_242_6 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				local var_242_8 = arg_239_1:FormatText(StoryNameCfg[7].name)

				arg_239_1.leftNameTxt_.text = var_242_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, true)
				arg_239_1.iconController_:SetSelectedState("hero")

				arg_239_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_239_1.callingController_:SetSelectedState("normal")

				arg_239_1.keyicon_.color = Color.New(1, 1, 1)
				arg_239_1.icon_.color = Color.New(1, 1, 1)

				local var_242_9 = arg_239_1:GetWordFromCfg(1107505059)
				local var_242_10 = arg_239_1:FormatText(var_242_9.content)

				arg_239_1.text_.text = var_242_10

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_11 = 30
				local var_242_12 = utf8.len(var_242_10)
				local var_242_13 = var_242_11 <= 0 and var_242_7 or var_242_7 * (var_242_12 / var_242_11)

				if var_242_13 > 0 and var_242_7 < var_242_13 then
					arg_239_1.talkMaxDuration = var_242_13

					if var_242_13 + var_242_6 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_13 + var_242_6
					end
				end

				arg_239_1.text_.text = var_242_10
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)
				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_14 = math.max(var_242_7, arg_239_1.talkMaxDuration)

			if var_242_6 <= arg_239_1.time_ and arg_239_1.time_ < var_242_6 + var_242_14 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_6) / var_242_14

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_6 + var_242_14 and arg_239_1.time_ < var_242_6 + var_242_14 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {}

		arg_239_1:InitPlayNodeList()
	end,
	Play1107505060 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 1107505060
		arg_243_1.duration_ = 9

		SetActive(arg_243_1.tipsGo_, false)

		function arg_243_1.onSingleLineFinish_()
			arg_243_1.onSingleLineUpdate_ = nil
			arg_243_1.onSingleLineFinish_ = nil
			arg_243_1.state_ = "waiting"
		end

		function arg_243_1.playNext_(arg_245_0)
			if arg_245_0 == 1 then
				arg_243_0:Play1107505061(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			local var_246_0 = "ST31"

			if arg_243_1.bgs_[var_246_0] == nil then
				local var_246_1 = Object.Instantiate(arg_243_1.paintGo_)

				var_246_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_246_0)
				var_246_1.name = var_246_0
				var_246_1.transform.parent = arg_243_1.stage_.transform
				var_246_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_243_1.bgs_[var_246_0] = var_246_1
			end

			local var_246_2 = 2

			if var_246_2 < arg_243_1.time_ and arg_243_1.time_ <= var_246_2 + arg_246_0 then
				local var_246_3 = manager.ui.mainCamera.transform.localPosition
				local var_246_4 = Vector3.New(0, 0, 10) + Vector3.New(var_246_3.x, var_246_3.y, 0)
				local var_246_5 = arg_243_1.bgs_.ST31

				var_246_5.transform.localPosition = var_246_4
				var_246_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_246_6 = var_246_5:GetComponent("SpriteRenderer")

				if var_246_6 and var_246_6.sprite then
					local var_246_7 = (var_246_5.transform.localPosition - var_246_3).z
					local var_246_8 = manager.ui.mainCameraCom_
					local var_246_9 = 2 * var_246_7 * Mathf.Tan(var_246_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_246_10 = var_246_9 * var_246_8.aspect
					local var_246_11 = var_246_6.sprite.bounds.size.x
					local var_246_12 = var_246_6.sprite.bounds.size.y
					local var_246_13 = var_246_10 / var_246_11
					local var_246_14 = var_246_9 / var_246_12
					local var_246_15 = var_246_14 < var_246_13 and var_246_13 or var_246_14

					var_246_5.transform.localScale = Vector3.New(var_246_15, var_246_15, 0)
				end

				for iter_246_0, iter_246_1 in pairs(arg_243_1.bgs_) do
					if iter_246_0 ~= "ST31" then
						iter_246_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_246_16 = 3.999999999999

			if var_246_16 < arg_243_1.time_ and arg_243_1.time_ <= var_246_16 + arg_246_0 then
				arg_243_1.allBtn_.enabled = false
			end

			local var_246_17 = 0.3

			if arg_243_1.time_ >= var_246_16 + var_246_17 and arg_243_1.time_ < var_246_16 + var_246_17 + arg_246_0 then
				arg_243_1.allBtn_.enabled = true
			end

			local var_246_18 = 0

			if var_246_18 < arg_243_1.time_ and arg_243_1.time_ <= var_246_18 + arg_246_0 then
				arg_243_1.mask_.enabled = true
				arg_243_1.mask_.raycastTarget = true

				arg_243_1:SetGaussion(false)
			end

			local var_246_19 = 2

			if var_246_18 <= arg_243_1.time_ and arg_243_1.time_ < var_246_18 + var_246_19 then
				local var_246_20 = (arg_243_1.time_ - var_246_18) / var_246_19
				local var_246_21 = Color.New(0, 0, 0)

				var_246_21.a = Mathf.Lerp(0, 1, var_246_20)
				arg_243_1.mask_.color = var_246_21
			end

			if arg_243_1.time_ >= var_246_18 + var_246_19 and arg_243_1.time_ < var_246_18 + var_246_19 + arg_246_0 then
				local var_246_22 = Color.New(0, 0, 0)

				var_246_22.a = 1
				arg_243_1.mask_.color = var_246_22
			end

			local var_246_23 = 2

			if var_246_23 < arg_243_1.time_ and arg_243_1.time_ <= var_246_23 + arg_246_0 then
				arg_243_1.mask_.enabled = true
				arg_243_1.mask_.raycastTarget = true

				arg_243_1:SetGaussion(false)
			end

			local var_246_24 = 2

			if var_246_23 <= arg_243_1.time_ and arg_243_1.time_ < var_246_23 + var_246_24 then
				local var_246_25 = (arg_243_1.time_ - var_246_23) / var_246_24
				local var_246_26 = Color.New(0, 0, 0)

				var_246_26.a = Mathf.Lerp(1, 0, var_246_25)
				arg_243_1.mask_.color = var_246_26
			end

			if arg_243_1.time_ >= var_246_23 + var_246_24 and arg_243_1.time_ < var_246_23 + var_246_24 + arg_246_0 then
				local var_246_27 = Color.New(0, 0, 0)
				local var_246_28 = 0

				arg_243_1.mask_.enabled = false
				var_246_27.a = var_246_28
				arg_243_1.mask_.color = var_246_27
			end

			local var_246_29 = arg_243_1.actors_["10044ui_story"].transform
			local var_246_30 = 1.96599999815226

			if var_246_30 < arg_243_1.time_ and arg_243_1.time_ <= var_246_30 + arg_246_0 then
				arg_243_1.var_.moveOldPos10044ui_story = var_246_29.localPosition
			end

			local var_246_31 = 0.001

			if var_246_30 <= arg_243_1.time_ and arg_243_1.time_ < var_246_30 + var_246_31 then
				local var_246_32 = (arg_243_1.time_ - var_246_30) / var_246_31
				local var_246_33 = Vector3.New(0, 100, 0)

				var_246_29.localPosition = Vector3.Lerp(arg_243_1.var_.moveOldPos10044ui_story, var_246_33, var_246_32)

				local var_246_34 = manager.ui.mainCamera.transform.position - var_246_29.position

				var_246_29.forward = Vector3.New(var_246_34.x, var_246_34.y, var_246_34.z)

				local var_246_35 = var_246_29.localEulerAngles

				var_246_35.z = 0
				var_246_35.x = 0
				var_246_29.localEulerAngles = var_246_35
			end

			if arg_243_1.time_ >= var_246_30 + var_246_31 and arg_243_1.time_ < var_246_30 + var_246_31 + arg_246_0 then
				var_246_29.localPosition = Vector3.New(0, 100, 0)

				local var_246_36 = manager.ui.mainCamera.transform.position - var_246_29.position

				var_246_29.forward = Vector3.New(var_246_36.x, var_246_36.y, var_246_36.z)

				local var_246_37 = var_246_29.localEulerAngles

				var_246_37.z = 0
				var_246_37.x = 0
				var_246_29.localEulerAngles = var_246_37
			end

			local var_246_38 = 4.9
			local var_246_39 = 1

			if var_246_38 < arg_243_1.time_ and arg_243_1.time_ <= var_246_38 + arg_246_0 then
				local var_246_40 = "play"
				local var_246_41 = "effect"

				arg_243_1:AudioAction(var_246_40, var_246_41, "se_story_side_1075", "se_story_side_1075_door", "")
			end

			if arg_243_1.frameCnt_ <= 1 then
				arg_243_1.dialog_:SetActive(false)
			end

			local var_246_42 = 4
			local var_246_43 = 1.1

			if var_246_42 < arg_243_1.time_ and arg_243_1.time_ <= var_246_42 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0

				arg_243_1.dialog_:SetActive(true)

				arg_243_1.dialogCg_.alpha = 0

				local var_246_44 = LeanTween.value(arg_243_1.dialog_, 0, 1, 0.3)

				var_246_44:setOnUpdate(LuaHelper.FloatAction(function(arg_247_0)
					arg_243_1.dialogCg_.alpha = arg_247_0
				end))
				var_246_44:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_243_1.dialog_)
					var_246_44:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_243_1.duration_ = arg_243_1.duration_ + 0.3

				SetActive(arg_243_1.leftNameGo_, false)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_45 = arg_243_1:GetWordFromCfg(1107505060)
				local var_246_46 = arg_243_1:FormatText(var_246_45.content)

				arg_243_1.text_.text = var_246_46

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_47 = 44
				local var_246_48 = utf8.len(var_246_46)
				local var_246_49 = var_246_47 <= 0 and var_246_43 or var_246_43 * (var_246_48 / var_246_47)

				if var_246_49 > 0 and var_246_43 < var_246_49 then
					arg_243_1.talkMaxDuration = var_246_49
					var_246_42 = var_246_42 + 0.3

					if var_246_49 + var_246_42 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_49 + var_246_42
					end
				end

				arg_243_1.text_.text = var_246_46
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)
				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_50 = var_246_42 + 0.3
			local var_246_51 = math.max(var_246_43, arg_243_1.talkMaxDuration)

			if var_246_50 <= arg_243_1.time_ and arg_243_1.time_ < var_246_50 + var_246_51 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_50) / var_246_51

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_50 + var_246_51 and arg_243_1.time_ < var_246_50 + var_246_51 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_243_1:InitPlayNodeList()
	end,
	Play1107505061 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 1107505061
		arg_249_1.duration_ = 6.27

		SetActive(arg_249_1.tipsGo_, false)

		function arg_249_1.onSingleLineFinish_()
			arg_249_1.onSingleLineUpdate_ = nil
			arg_249_1.onSingleLineFinish_ = nil
			arg_249_1.state_ = "waiting"
		end

		function arg_249_1.playNext_(arg_251_0)
			if arg_251_0 == 1 then
				arg_249_0:Play1107505062(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			local var_252_0 = arg_249_1.actors_["1075ui_actor"].transform
			local var_252_1 = 0

			if var_252_1 < arg_249_1.time_ and arg_249_1.time_ <= var_252_1 + arg_252_0 then
				arg_249_1.var_.moveOldPos1075ui_actor = var_252_0.localPosition

				local var_252_2 = GameObjectTools.GetOrAddComponent(var_252_0.gameObject, typeof(DynamicBoneHelper))

				if var_252_2 then
					var_252_2:EnableDynamicBone(false)
				end
			end

			local var_252_3 = 0.001

			if var_252_1 <= arg_249_1.time_ and arg_249_1.time_ < var_252_1 + var_252_3 then
				local var_252_4 = (arg_249_1.time_ - var_252_1) / var_252_3
				local var_252_5 = Vector3.New(0, -1.055, -6.16)

				var_252_0.localPosition = Vector3.Lerp(arg_249_1.var_.moveOldPos1075ui_actor, var_252_5, var_252_4)

				local var_252_6 = manager.ui.mainCamera.transform.position - var_252_0.position

				var_252_0.forward = Vector3.New(var_252_6.x, var_252_6.y, var_252_6.z)

				local var_252_7 = var_252_0.localEulerAngles

				var_252_7.z = 0
				var_252_7.x = 0
				var_252_0.localEulerAngles = var_252_7
			end

			if arg_249_1.time_ >= var_252_1 + var_252_3 and arg_249_1.time_ < var_252_1 + var_252_3 + arg_252_0 then
				var_252_0.localPosition = Vector3.New(0, -1.055, -6.16)

				local var_252_8 = manager.ui.mainCamera.transform.position - var_252_0.position

				var_252_0.forward = Vector3.New(var_252_8.x, var_252_8.y, var_252_8.z)

				local var_252_9 = var_252_0.localEulerAngles

				var_252_9.z = 0
				var_252_9.x = 0
				var_252_0.localEulerAngles = var_252_9

				local var_252_10 = GameObjectTools.GetOrAddComponent(var_252_0.gameObject, typeof(DynamicBoneHelper))

				if var_252_10 then
					var_252_10:EnableDynamicBone(true)
				end
			end

			local var_252_11 = arg_249_1.actors_["1075ui_actor"]
			local var_252_12 = 0

			if var_252_12 < arg_249_1.time_ and arg_249_1.time_ <= var_252_12 + arg_252_0 and not isNil(var_252_11) and arg_249_1.var_.characterEffect1075ui_actor == nil then
				arg_249_1.var_.characterEffect1075ui_actor = var_252_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_252_13 = 0.200000002980232

			if var_252_12 <= arg_249_1.time_ and arg_249_1.time_ < var_252_12 + var_252_13 and not isNil(var_252_11) then
				local var_252_14 = (arg_249_1.time_ - var_252_12) / var_252_13

				if arg_249_1.var_.characterEffect1075ui_actor and not isNil(var_252_11) then
					arg_249_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_249_1.time_ >= var_252_12 + var_252_13 and arg_249_1.time_ < var_252_12 + var_252_13 + arg_252_0 and not isNil(var_252_11) and arg_249_1.var_.characterEffect1075ui_actor then
				arg_249_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			local var_252_15 = 0

			if var_252_15 < arg_249_1.time_ and arg_249_1.time_ <= var_252_15 + arg_252_0 then
				arg_249_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075action/1075action4_1")
			end

			local var_252_16 = 0

			if var_252_16 < arg_249_1.time_ and arg_249_1.time_ <= var_252_16 + arg_252_0 then
				arg_249_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_gandong", "EmotionTimelineAnimator")
			end

			local var_252_17 = 0
			local var_252_18 = 0.4

			if var_252_17 < arg_249_1.time_ and arg_249_1.time_ <= var_252_17 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				local var_252_19 = arg_249_1:FormatText(StoryNameCfg[381].name)

				arg_249_1.leftNameTxt_.text = var_252_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_20 = arg_249_1:GetWordFromCfg(1107505061)
				local var_252_21 = arg_249_1:FormatText(var_252_20.content)

				arg_249_1.text_.text = var_252_21

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_22 = 16
				local var_252_23 = utf8.len(var_252_21)
				local var_252_24 = var_252_22 <= 0 and var_252_18 or var_252_18 * (var_252_23 / var_252_22)

				if var_252_24 > 0 and var_252_18 < var_252_24 then
					arg_249_1.talkMaxDuration = var_252_24

					if var_252_24 + var_252_17 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_24 + var_252_17
					end
				end

				arg_249_1.text_.text = var_252_21
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107505", "1107505061", "story_v_side_new_1107505.awb") ~= 0 then
					local var_252_25 = manager.audio:GetVoiceLength("story_v_side_new_1107505", "1107505061", "story_v_side_new_1107505.awb") / 1000

					if var_252_25 + var_252_17 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_25 + var_252_17
					end

					if var_252_20.prefab_name ~= "" and arg_249_1.actors_[var_252_20.prefab_name] ~= nil then
						local var_252_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_249_1.actors_[var_252_20.prefab_name].transform, "story_v_side_new_1107505", "1107505061", "story_v_side_new_1107505.awb")

						arg_249_1:RecordAudio("1107505061", var_252_26)
						arg_249_1:RecordAudio("1107505061", var_252_26)
					else
						arg_249_1:AudioAction("play", "voice", "story_v_side_new_1107505", "1107505061", "story_v_side_new_1107505.awb")
					end

					arg_249_1:RecordHistoryTalkVoice("story_v_side_new_1107505", "1107505061", "story_v_side_new_1107505.awb")
				end

				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_27 = math.max(var_252_18, arg_249_1.talkMaxDuration)

			if var_252_17 <= arg_249_1.time_ and arg_249_1.time_ < var_252_17 + var_252_27 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_17) / var_252_27

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_17 + var_252_27 and arg_249_1.time_ < var_252_17 + var_252_27 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_actor",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_249_1:InitPlayNodeList()
	end,
	Play1107505062 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 1107505062
		arg_253_1.duration_ = 6.6

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play1107505063(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			local var_256_0 = 0

			if var_256_0 < arg_253_1.time_ and arg_253_1.time_ <= var_256_0 + arg_256_0 then
				arg_253_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075actionlink/1075action443")
			end

			local var_256_1 = 0

			if var_256_1 < arg_253_1.time_ and arg_253_1.time_ <= var_256_1 + arg_256_0 then
				arg_253_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_biyanbiaozhun", "EmotionTimelineAnimator")
			end

			local var_256_2 = 0
			local var_256_3 = 0.7

			if var_256_2 < arg_253_1.time_ and arg_253_1.time_ <= var_256_2 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				local var_256_4 = arg_253_1:FormatText(StoryNameCfg[381].name)

				arg_253_1.leftNameTxt_.text = var_256_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_5 = arg_253_1:GetWordFromCfg(1107505062)
				local var_256_6 = arg_253_1:FormatText(var_256_5.content)

				arg_253_1.text_.text = var_256_6

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_7 = 28
				local var_256_8 = utf8.len(var_256_6)
				local var_256_9 = var_256_7 <= 0 and var_256_3 or var_256_3 * (var_256_8 / var_256_7)

				if var_256_9 > 0 and var_256_3 < var_256_9 then
					arg_253_1.talkMaxDuration = var_256_9

					if var_256_9 + var_256_2 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_9 + var_256_2
					end
				end

				arg_253_1.text_.text = var_256_6
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107505", "1107505062", "story_v_side_new_1107505.awb") ~= 0 then
					local var_256_10 = manager.audio:GetVoiceLength("story_v_side_new_1107505", "1107505062", "story_v_side_new_1107505.awb") / 1000

					if var_256_10 + var_256_2 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_10 + var_256_2
					end

					if var_256_5.prefab_name ~= "" and arg_253_1.actors_[var_256_5.prefab_name] ~= nil then
						local var_256_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_253_1.actors_[var_256_5.prefab_name].transform, "story_v_side_new_1107505", "1107505062", "story_v_side_new_1107505.awb")

						arg_253_1:RecordAudio("1107505062", var_256_11)
						arg_253_1:RecordAudio("1107505062", var_256_11)
					else
						arg_253_1:AudioAction("play", "voice", "story_v_side_new_1107505", "1107505062", "story_v_side_new_1107505.awb")
					end

					arg_253_1:RecordHistoryTalkVoice("story_v_side_new_1107505", "1107505062", "story_v_side_new_1107505.awb")
				end

				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_12 = math.max(var_256_3, arg_253_1.talkMaxDuration)

			if var_256_2 <= arg_253_1.time_ and arg_253_1.time_ < var_256_2 + var_256_12 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_2) / var_256_12

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_2 + var_256_12 and arg_253_1.time_ < var_256_2 + var_256_12 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {}

		arg_253_1:InitPlayNodeList()
	end,
	Play1107505063 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 1107505063
		arg_257_1.duration_ = 5

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
		end

		function arg_257_1.playNext_(arg_259_0)
			if arg_259_0 == 1 then
				arg_257_0:Play1107505064(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			local var_260_0 = arg_257_1.actors_["1075ui_actor"]
			local var_260_1 = 0

			if var_260_1 < arg_257_1.time_ and arg_257_1.time_ <= var_260_1 + arg_260_0 and not isNil(var_260_0) and arg_257_1.var_.characterEffect1075ui_actor == nil then
				arg_257_1.var_.characterEffect1075ui_actor = var_260_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_260_2 = 0.200000002980232

			if var_260_1 <= arg_257_1.time_ and arg_257_1.time_ < var_260_1 + var_260_2 and not isNil(var_260_0) then
				local var_260_3 = (arg_257_1.time_ - var_260_1) / var_260_2

				if arg_257_1.var_.characterEffect1075ui_actor and not isNil(var_260_0) then
					local var_260_4 = Mathf.Lerp(0, 0.5, var_260_3)

					arg_257_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_257_1.var_.characterEffect1075ui_actor.fillRatio = var_260_4
				end
			end

			if arg_257_1.time_ >= var_260_1 + var_260_2 and arg_257_1.time_ < var_260_1 + var_260_2 + arg_260_0 and not isNil(var_260_0) and arg_257_1.var_.characterEffect1075ui_actor then
				local var_260_5 = 0.5

				arg_257_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_257_1.var_.characterEffect1075ui_actor.fillRatio = var_260_5
			end

			local var_260_6 = 0
			local var_260_7 = 0.475

			if var_260_6 < arg_257_1.time_ and arg_257_1.time_ <= var_260_6 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				local var_260_8 = arg_257_1:FormatText(StoryNameCfg[7].name)

				arg_257_1.leftNameTxt_.text = var_260_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, true)
				arg_257_1.iconController_:SetSelectedState("hero")

				arg_257_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_257_1.callingController_:SetSelectedState("normal")

				arg_257_1.keyicon_.color = Color.New(1, 1, 1)
				arg_257_1.icon_.color = Color.New(1, 1, 1)

				local var_260_9 = arg_257_1:GetWordFromCfg(1107505063)
				local var_260_10 = arg_257_1:FormatText(var_260_9.content)

				arg_257_1.text_.text = var_260_10

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_11 = 19
				local var_260_12 = utf8.len(var_260_10)
				local var_260_13 = var_260_11 <= 0 and var_260_7 or var_260_7 * (var_260_12 / var_260_11)

				if var_260_13 > 0 and var_260_7 < var_260_13 then
					arg_257_1.talkMaxDuration = var_260_13

					if var_260_13 + var_260_6 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_13 + var_260_6
					end
				end

				arg_257_1.text_.text = var_260_10
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)
				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_14 = math.max(var_260_7, arg_257_1.talkMaxDuration)

			if var_260_6 <= arg_257_1.time_ and arg_257_1.time_ < var_260_6 + var_260_14 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_6) / var_260_14

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_6 + var_260_14 and arg_257_1.time_ < var_260_6 + var_260_14 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {}

		arg_257_1:InitPlayNodeList()
	end,
	Play1107505064 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 1107505064
		arg_261_1.duration_ = 8.57

		SetActive(arg_261_1.tipsGo_, false)

		function arg_261_1.onSingleLineFinish_()
			arg_261_1.onSingleLineUpdate_ = nil
			arg_261_1.onSingleLineFinish_ = nil
			arg_261_1.state_ = "waiting"
		end

		function arg_261_1.playNext_(arg_263_0)
			if arg_263_0 == 1 then
				arg_261_0:Play1107505065(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			local var_264_0 = arg_261_1.actors_["1075ui_actor"]
			local var_264_1 = 0

			if var_264_1 < arg_261_1.time_ and arg_261_1.time_ <= var_264_1 + arg_264_0 and not isNil(var_264_0) and arg_261_1.var_.characterEffect1075ui_actor == nil then
				arg_261_1.var_.characterEffect1075ui_actor = var_264_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_264_2 = 0.200000002980232

			if var_264_1 <= arg_261_1.time_ and arg_261_1.time_ < var_264_1 + var_264_2 and not isNil(var_264_0) then
				local var_264_3 = (arg_261_1.time_ - var_264_1) / var_264_2

				if arg_261_1.var_.characterEffect1075ui_actor and not isNil(var_264_0) then
					arg_261_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_261_1.time_ >= var_264_1 + var_264_2 and arg_261_1.time_ < var_264_1 + var_264_2 + arg_264_0 and not isNil(var_264_0) and arg_261_1.var_.characterEffect1075ui_actor then
				arg_261_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			local var_264_4 = 0

			if var_264_4 < arg_261_1.time_ and arg_261_1.time_ <= var_264_4 + arg_264_0 then
				arg_261_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075action/1075action3_2")
			end

			local var_264_5 = 0

			if var_264_5 < arg_261_1.time_ and arg_261_1.time_ <= var_264_5 + arg_264_0 then
				arg_261_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_264_6 = 0
			local var_264_7 = 0.7

			if var_264_6 < arg_261_1.time_ and arg_261_1.time_ <= var_264_6 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				local var_264_8 = arg_261_1:FormatText(StoryNameCfg[381].name)

				arg_261_1.leftNameTxt_.text = var_264_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_9 = arg_261_1:GetWordFromCfg(1107505064)
				local var_264_10 = arg_261_1:FormatText(var_264_9.content)

				arg_261_1.text_.text = var_264_10

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_11 = 28
				local var_264_12 = utf8.len(var_264_10)
				local var_264_13 = var_264_11 <= 0 and var_264_7 or var_264_7 * (var_264_12 / var_264_11)

				if var_264_13 > 0 and var_264_7 < var_264_13 then
					arg_261_1.talkMaxDuration = var_264_13

					if var_264_13 + var_264_6 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_13 + var_264_6
					end
				end

				arg_261_1.text_.text = var_264_10
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107505", "1107505064", "story_v_side_new_1107505.awb") ~= 0 then
					local var_264_14 = manager.audio:GetVoiceLength("story_v_side_new_1107505", "1107505064", "story_v_side_new_1107505.awb") / 1000

					if var_264_14 + var_264_6 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_14 + var_264_6
					end

					if var_264_9.prefab_name ~= "" and arg_261_1.actors_[var_264_9.prefab_name] ~= nil then
						local var_264_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_261_1.actors_[var_264_9.prefab_name].transform, "story_v_side_new_1107505", "1107505064", "story_v_side_new_1107505.awb")

						arg_261_1:RecordAudio("1107505064", var_264_15)
						arg_261_1:RecordAudio("1107505064", var_264_15)
					else
						arg_261_1:AudioAction("play", "voice", "story_v_side_new_1107505", "1107505064", "story_v_side_new_1107505.awb")
					end

					arg_261_1:RecordHistoryTalkVoice("story_v_side_new_1107505", "1107505064", "story_v_side_new_1107505.awb")
				end

				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_16 = math.max(var_264_7, arg_261_1.talkMaxDuration)

			if var_264_6 <= arg_261_1.time_ and arg_261_1.time_ < var_264_6 + var_264_16 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_6) / var_264_16

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_6 + var_264_16 and arg_261_1.time_ < var_264_6 + var_264_16 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {}

		arg_261_1:InitPlayNodeList()
	end,
	Play1107505065 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 1107505065
		arg_265_1.duration_ = 5

		SetActive(arg_265_1.tipsGo_, false)

		function arg_265_1.onSingleLineFinish_()
			arg_265_1.onSingleLineUpdate_ = nil
			arg_265_1.onSingleLineFinish_ = nil
			arg_265_1.state_ = "waiting"
		end

		function arg_265_1.playNext_(arg_267_0)
			if arg_267_0 == 1 then
				arg_265_0:Play1107505066(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			local var_268_0 = arg_265_1.actors_["1075ui_actor"]
			local var_268_1 = 0

			if var_268_1 < arg_265_1.time_ and arg_265_1.time_ <= var_268_1 + arg_268_0 and not isNil(var_268_0) and arg_265_1.var_.characterEffect1075ui_actor == nil then
				arg_265_1.var_.characterEffect1075ui_actor = var_268_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_268_2 = 0.200000002980232

			if var_268_1 <= arg_265_1.time_ and arg_265_1.time_ < var_268_1 + var_268_2 and not isNil(var_268_0) then
				local var_268_3 = (arg_265_1.time_ - var_268_1) / var_268_2

				if arg_265_1.var_.characterEffect1075ui_actor and not isNil(var_268_0) then
					local var_268_4 = Mathf.Lerp(0, 0.5, var_268_3)

					arg_265_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_265_1.var_.characterEffect1075ui_actor.fillRatio = var_268_4
				end
			end

			if arg_265_1.time_ >= var_268_1 + var_268_2 and arg_265_1.time_ < var_268_1 + var_268_2 + arg_268_0 and not isNil(var_268_0) and arg_265_1.var_.characterEffect1075ui_actor then
				local var_268_5 = 0.5

				arg_265_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_265_1.var_.characterEffect1075ui_actor.fillRatio = var_268_5
			end

			local var_268_6 = arg_265_1.actors_["1075ui_actor"].transform
			local var_268_7 = 0

			if var_268_7 < arg_265_1.time_ and arg_265_1.time_ <= var_268_7 + arg_268_0 then
				arg_265_1.var_.moveOldPos1075ui_actor = var_268_6.localPosition

				local var_268_8 = GameObjectTools.GetOrAddComponent(var_268_6.gameObject, typeof(DynamicBoneHelper))

				if var_268_8 then
					var_268_8:EnableDynamicBone(false)
				end
			end

			local var_268_9 = 0.001

			if var_268_7 <= arg_265_1.time_ and arg_265_1.time_ < var_268_7 + var_268_9 then
				local var_268_10 = (arg_265_1.time_ - var_268_7) / var_268_9
				local var_268_11 = Vector3.New(0, 100, 0)

				var_268_6.localPosition = Vector3.Lerp(arg_265_1.var_.moveOldPos1075ui_actor, var_268_11, var_268_10)

				local var_268_12 = manager.ui.mainCamera.transform.position - var_268_6.position

				var_268_6.forward = Vector3.New(var_268_12.x, var_268_12.y, var_268_12.z)

				local var_268_13 = var_268_6.localEulerAngles

				var_268_13.z = 0
				var_268_13.x = 0
				var_268_6.localEulerAngles = var_268_13
			end

			if arg_265_1.time_ >= var_268_7 + var_268_9 and arg_265_1.time_ < var_268_7 + var_268_9 + arg_268_0 then
				var_268_6.localPosition = Vector3.New(0, 100, 0)

				local var_268_14 = manager.ui.mainCamera.transform.position - var_268_6.position

				var_268_6.forward = Vector3.New(var_268_14.x, var_268_14.y, var_268_14.z)

				local var_268_15 = var_268_6.localEulerAngles

				var_268_15.z = 0
				var_268_15.x = 0
				var_268_6.localEulerAngles = var_268_15

				local var_268_16 = GameObjectTools.GetOrAddComponent(var_268_6.gameObject, typeof(DynamicBoneHelper))

				if var_268_16 then
					var_268_16:EnableDynamicBone(true)
				end
			end

			local var_268_17 = 0.5
			local var_268_18 = 1

			if var_268_17 < arg_265_1.time_ and arg_265_1.time_ <= var_268_17 + arg_268_0 then
				local var_268_19 = "play"
				local var_268_20 = "effect"

				arg_265_1:AudioAction(var_268_19, var_268_20, "se_story_side_1049", "se_story_side_1049_hug", "")
			end

			local var_268_21 = 0
			local var_268_22 = 0.8

			if var_268_21 < arg_265_1.time_ and arg_265_1.time_ <= var_268_21 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, false)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_23 = arg_265_1:GetWordFromCfg(1107505065)
				local var_268_24 = arg_265_1:FormatText(var_268_23.content)

				arg_265_1.text_.text = var_268_24

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_25 = 32
				local var_268_26 = utf8.len(var_268_24)
				local var_268_27 = var_268_25 <= 0 and var_268_22 or var_268_22 * (var_268_26 / var_268_25)

				if var_268_27 > 0 and var_268_22 < var_268_27 then
					arg_265_1.talkMaxDuration = var_268_27

					if var_268_27 + var_268_21 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_27 + var_268_21
					end
				end

				arg_265_1.text_.text = var_268_24
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)
				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_28 = math.max(var_268_22, arg_265_1.talkMaxDuration)

			if var_268_21 <= arg_265_1.time_ and arg_265_1.time_ < var_268_21 + var_268_28 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_21) / var_268_28

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_21 + var_268_28 and arg_265_1.time_ < var_268_21 + var_268_28 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_actor",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_265_1:InitPlayNodeList()
	end,
	Play1107505066 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 1107505066
		arg_269_1.duration_ = 5

		SetActive(arg_269_1.tipsGo_, false)

		function arg_269_1.onSingleLineFinish_()
			arg_269_1.onSingleLineUpdate_ = nil
			arg_269_1.onSingleLineFinish_ = nil
			arg_269_1.state_ = "waiting"
		end

		function arg_269_1.playNext_(arg_271_0)
			if arg_271_0 == 1 then
				arg_269_0:Play1107505067(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			local var_272_0 = 0
			local var_272_1 = 0.85

			if var_272_0 < arg_269_1.time_ and arg_269_1.time_ <= var_272_0 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				local var_272_2 = arg_269_1:FormatText(StoryNameCfg[7].name)

				arg_269_1.leftNameTxt_.text = var_272_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, true)
				arg_269_1.iconController_:SetSelectedState("hero")

				arg_269_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_269_1.callingController_:SetSelectedState("normal")

				arg_269_1.keyicon_.color = Color.New(1, 1, 1)
				arg_269_1.icon_.color = Color.New(1, 1, 1)

				local var_272_3 = arg_269_1:GetWordFromCfg(1107505066)
				local var_272_4 = arg_269_1:FormatText(var_272_3.content)

				arg_269_1.text_.text = var_272_4

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_5 = 34
				local var_272_6 = utf8.len(var_272_4)
				local var_272_7 = var_272_5 <= 0 and var_272_1 or var_272_1 * (var_272_6 / var_272_5)

				if var_272_7 > 0 and var_272_1 < var_272_7 then
					arg_269_1.talkMaxDuration = var_272_7

					if var_272_7 + var_272_0 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_7 + var_272_0
					end
				end

				arg_269_1.text_.text = var_272_4
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)
				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_8 = math.max(var_272_1, arg_269_1.talkMaxDuration)

			if var_272_0 <= arg_269_1.time_ and arg_269_1.time_ < var_272_0 + var_272_8 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_0) / var_272_8

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_0 + var_272_8 and arg_269_1.time_ < var_272_0 + var_272_8 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {}

		arg_269_1:InitPlayNodeList()
	end,
	Play1107505067 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 1107505067
		arg_273_1.duration_ = 3.97

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play1107505068(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			local var_276_0 = arg_273_1.actors_["1075ui_actor"]
			local var_276_1 = 0

			if var_276_1 < arg_273_1.time_ and arg_273_1.time_ <= var_276_1 + arg_276_0 and not isNil(var_276_0) and arg_273_1.var_.characterEffect1075ui_actor == nil then
				arg_273_1.var_.characterEffect1075ui_actor = var_276_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_276_2 = 0.200000002980232

			if var_276_1 <= arg_273_1.time_ and arg_273_1.time_ < var_276_1 + var_276_2 and not isNil(var_276_0) then
				local var_276_3 = (arg_273_1.time_ - var_276_1) / var_276_2

				if arg_273_1.var_.characterEffect1075ui_actor and not isNil(var_276_0) then
					arg_273_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_273_1.time_ >= var_276_1 + var_276_2 and arg_273_1.time_ < var_276_1 + var_276_2 + arg_276_0 and not isNil(var_276_0) and arg_273_1.var_.characterEffect1075ui_actor then
				arg_273_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			local var_276_4 = 0

			if var_276_4 < arg_273_1.time_ and arg_273_1.time_ <= var_276_4 + arg_276_0 then
				arg_273_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075action/1075action3_1")
			end

			local var_276_5 = 0

			if var_276_5 < arg_273_1.time_ and arg_273_1.time_ <= var_276_5 + arg_276_0 then
				arg_273_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_276_6 = arg_273_1.actors_["1075ui_actor"].transform
			local var_276_7 = 0

			if var_276_7 < arg_273_1.time_ and arg_273_1.time_ <= var_276_7 + arg_276_0 then
				arg_273_1.var_.moveOldPos1075ui_actor = var_276_6.localPosition

				local var_276_8 = GameObjectTools.GetOrAddComponent(var_276_6.gameObject, typeof(DynamicBoneHelper))

				if var_276_8 then
					var_276_8:EnableDynamicBone(false)
				end
			end

			local var_276_9 = 0.001

			if var_276_7 <= arg_273_1.time_ and arg_273_1.time_ < var_276_7 + var_276_9 then
				local var_276_10 = (arg_273_1.time_ - var_276_7) / var_276_9
				local var_276_11 = Vector3.New(0, -1.055, -6.16)

				var_276_6.localPosition = Vector3.Lerp(arg_273_1.var_.moveOldPos1075ui_actor, var_276_11, var_276_10)

				local var_276_12 = manager.ui.mainCamera.transform.position - var_276_6.position

				var_276_6.forward = Vector3.New(var_276_12.x, var_276_12.y, var_276_12.z)

				local var_276_13 = var_276_6.localEulerAngles

				var_276_13.z = 0
				var_276_13.x = 0
				var_276_6.localEulerAngles = var_276_13
			end

			if arg_273_1.time_ >= var_276_7 + var_276_9 and arg_273_1.time_ < var_276_7 + var_276_9 + arg_276_0 then
				var_276_6.localPosition = Vector3.New(0, -1.055, -6.16)

				local var_276_14 = manager.ui.mainCamera.transform.position - var_276_6.position

				var_276_6.forward = Vector3.New(var_276_14.x, var_276_14.y, var_276_14.z)

				local var_276_15 = var_276_6.localEulerAngles

				var_276_15.z = 0
				var_276_15.x = 0
				var_276_6.localEulerAngles = var_276_15

				local var_276_16 = GameObjectTools.GetOrAddComponent(var_276_6.gameObject, typeof(DynamicBoneHelper))

				if var_276_16 then
					var_276_16:EnableDynamicBone(true)
				end
			end

			local var_276_17 = 0
			local var_276_18 = 0.375

			if var_276_17 < arg_273_1.time_ and arg_273_1.time_ <= var_276_17 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, true)

				local var_276_19 = arg_273_1:FormatText(StoryNameCfg[381].name)

				arg_273_1.leftNameTxt_.text = var_276_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_20 = arg_273_1:GetWordFromCfg(1107505067)
				local var_276_21 = arg_273_1:FormatText(var_276_20.content)

				arg_273_1.text_.text = var_276_21

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_22 = 15
				local var_276_23 = utf8.len(var_276_21)
				local var_276_24 = var_276_22 <= 0 and var_276_18 or var_276_18 * (var_276_23 / var_276_22)

				if var_276_24 > 0 and var_276_18 < var_276_24 then
					arg_273_1.talkMaxDuration = var_276_24

					if var_276_24 + var_276_17 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_24 + var_276_17
					end
				end

				arg_273_1.text_.text = var_276_21
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107505", "1107505067", "story_v_side_new_1107505.awb") ~= 0 then
					local var_276_25 = manager.audio:GetVoiceLength("story_v_side_new_1107505", "1107505067", "story_v_side_new_1107505.awb") / 1000

					if var_276_25 + var_276_17 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_25 + var_276_17
					end

					if var_276_20.prefab_name ~= "" and arg_273_1.actors_[var_276_20.prefab_name] ~= nil then
						local var_276_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_273_1.actors_[var_276_20.prefab_name].transform, "story_v_side_new_1107505", "1107505067", "story_v_side_new_1107505.awb")

						arg_273_1:RecordAudio("1107505067", var_276_26)
						arg_273_1:RecordAudio("1107505067", var_276_26)
					else
						arg_273_1:AudioAction("play", "voice", "story_v_side_new_1107505", "1107505067", "story_v_side_new_1107505.awb")
					end

					arg_273_1:RecordHistoryTalkVoice("story_v_side_new_1107505", "1107505067", "story_v_side_new_1107505.awb")
				end

				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_27 = math.max(var_276_18, arg_273_1.talkMaxDuration)

			if var_276_17 <= arg_273_1.time_ and arg_273_1.time_ < var_276_17 + var_276_27 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_17) / var_276_27

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_17 + var_276_27 and arg_273_1.time_ < var_276_17 + var_276_27 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_actor",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_273_1:InitPlayNodeList()
	end,
	Play1107505068 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 1107505068
		arg_277_1.duration_ = 5

		SetActive(arg_277_1.tipsGo_, false)

		function arg_277_1.onSingleLineFinish_()
			arg_277_1.onSingleLineUpdate_ = nil
			arg_277_1.onSingleLineFinish_ = nil
			arg_277_1.state_ = "waiting"
		end

		function arg_277_1.playNext_(arg_279_0)
			if arg_279_0 == 1 then
				arg_277_0:Play1107505069(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			local var_280_0 = arg_277_1.actors_["1075ui_actor"]
			local var_280_1 = 0

			if var_280_1 < arg_277_1.time_ and arg_277_1.time_ <= var_280_1 + arg_280_0 and not isNil(var_280_0) and arg_277_1.var_.characterEffect1075ui_actor == nil then
				arg_277_1.var_.characterEffect1075ui_actor = var_280_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_280_2 = 0.200000002980232

			if var_280_1 <= arg_277_1.time_ and arg_277_1.time_ < var_280_1 + var_280_2 and not isNil(var_280_0) then
				local var_280_3 = (arg_277_1.time_ - var_280_1) / var_280_2

				if arg_277_1.var_.characterEffect1075ui_actor and not isNil(var_280_0) then
					local var_280_4 = Mathf.Lerp(0, 0.5, var_280_3)

					arg_277_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_277_1.var_.characterEffect1075ui_actor.fillRatio = var_280_4
				end
			end

			if arg_277_1.time_ >= var_280_1 + var_280_2 and arg_277_1.time_ < var_280_1 + var_280_2 + arg_280_0 and not isNil(var_280_0) and arg_277_1.var_.characterEffect1075ui_actor then
				local var_280_5 = 0.5

				arg_277_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_277_1.var_.characterEffect1075ui_actor.fillRatio = var_280_5
			end

			local var_280_6 = 0
			local var_280_7 = 0.425

			if var_280_6 < arg_277_1.time_ and arg_277_1.time_ <= var_280_6 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				local var_280_8 = arg_277_1:FormatText(StoryNameCfg[7].name)

				arg_277_1.leftNameTxt_.text = var_280_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, true)
				arg_277_1.iconController_:SetSelectedState("hero")

				arg_277_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_277_1.callingController_:SetSelectedState("normal")

				arg_277_1.keyicon_.color = Color.New(1, 1, 1)
				arg_277_1.icon_.color = Color.New(1, 1, 1)

				local var_280_9 = arg_277_1:GetWordFromCfg(1107505068)
				local var_280_10 = arg_277_1:FormatText(var_280_9.content)

				arg_277_1.text_.text = var_280_10

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_11 = 17
				local var_280_12 = utf8.len(var_280_10)
				local var_280_13 = var_280_11 <= 0 and var_280_7 or var_280_7 * (var_280_12 / var_280_11)

				if var_280_13 > 0 and var_280_7 < var_280_13 then
					arg_277_1.talkMaxDuration = var_280_13

					if var_280_13 + var_280_6 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_13 + var_280_6
					end
				end

				arg_277_1.text_.text = var_280_10
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)
				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_14 = math.max(var_280_7, arg_277_1.talkMaxDuration)

			if var_280_6 <= arg_277_1.time_ and arg_277_1.time_ < var_280_6 + var_280_14 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_6) / var_280_14

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_6 + var_280_14 and arg_277_1.time_ < var_280_6 + var_280_14 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {}

		arg_277_1:InitPlayNodeList()
	end,
	Play1107505069 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 1107505069
		arg_281_1.duration_ = 5

		SetActive(arg_281_1.tipsGo_, false)

		function arg_281_1.onSingleLineFinish_()
			arg_281_1.onSingleLineUpdate_ = nil
			arg_281_1.onSingleLineFinish_ = nil
			arg_281_1.state_ = "waiting"
		end

		function arg_281_1.playNext_(arg_283_0)
			if arg_283_0 == 1 then
				arg_281_0:Play1107505070(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			local var_284_0 = arg_281_1.actors_["1075ui_actor"].transform
			local var_284_1 = 0

			if var_284_1 < arg_281_1.time_ and arg_281_1.time_ <= var_284_1 + arg_284_0 then
				arg_281_1.var_.moveOldPos1075ui_actor = var_284_0.localPosition

				local var_284_2 = GameObjectTools.GetOrAddComponent(var_284_0.gameObject, typeof(DynamicBoneHelper))

				if var_284_2 then
					var_284_2:EnableDynamicBone(false)
				end
			end

			local var_284_3 = 0.001

			if var_284_1 <= arg_281_1.time_ and arg_281_1.time_ < var_284_1 + var_284_3 then
				local var_284_4 = (arg_281_1.time_ - var_284_1) / var_284_3
				local var_284_5 = Vector3.New(0, 100, 0)

				var_284_0.localPosition = Vector3.Lerp(arg_281_1.var_.moveOldPos1075ui_actor, var_284_5, var_284_4)

				local var_284_6 = manager.ui.mainCamera.transform.position - var_284_0.position

				var_284_0.forward = Vector3.New(var_284_6.x, var_284_6.y, var_284_6.z)

				local var_284_7 = var_284_0.localEulerAngles

				var_284_7.z = 0
				var_284_7.x = 0
				var_284_0.localEulerAngles = var_284_7
			end

			if arg_281_1.time_ >= var_284_1 + var_284_3 and arg_281_1.time_ < var_284_1 + var_284_3 + arg_284_0 then
				var_284_0.localPosition = Vector3.New(0, 100, 0)

				local var_284_8 = manager.ui.mainCamera.transform.position - var_284_0.position

				var_284_0.forward = Vector3.New(var_284_8.x, var_284_8.y, var_284_8.z)

				local var_284_9 = var_284_0.localEulerAngles

				var_284_9.z = 0
				var_284_9.x = 0
				var_284_0.localEulerAngles = var_284_9

				local var_284_10 = GameObjectTools.GetOrAddComponent(var_284_0.gameObject, typeof(DynamicBoneHelper))

				if var_284_10 then
					var_284_10:EnableDynamicBone(true)
				end
			end

			local var_284_11 = 0
			local var_284_12 = 1

			if var_284_11 < arg_281_1.time_ and arg_281_1.time_ <= var_284_11 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, false)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_13 = arg_281_1:GetWordFromCfg(1107505069)
				local var_284_14 = arg_281_1:FormatText(var_284_13.content)

				arg_281_1.text_.text = var_284_14

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_15 = 40
				local var_284_16 = utf8.len(var_284_14)
				local var_284_17 = var_284_15 <= 0 and var_284_12 or var_284_12 * (var_284_16 / var_284_15)

				if var_284_17 > 0 and var_284_12 < var_284_17 then
					arg_281_1.talkMaxDuration = var_284_17

					if var_284_17 + var_284_11 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_17 + var_284_11
					end
				end

				arg_281_1.text_.text = var_284_14
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)
				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_18 = math.max(var_284_12, arg_281_1.talkMaxDuration)

			if var_284_11 <= arg_281_1.time_ and arg_281_1.time_ < var_284_11 + var_284_18 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_11) / var_284_18

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_11 + var_284_18 and arg_281_1.time_ < var_284_11 + var_284_18 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_actor",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_281_1:InitPlayNodeList()
	end,
	Play1107505070 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 1107505070
		arg_285_1.duration_ = 9

		SetActive(arg_285_1.tipsGo_, false)

		function arg_285_1.onSingleLineFinish_()
			arg_285_1.onSingleLineUpdate_ = nil
			arg_285_1.onSingleLineFinish_ = nil
			arg_285_1.state_ = "waiting"
		end

		function arg_285_1.playNext_(arg_287_0)
			if arg_287_0 == 1 then
				arg_285_0:Play1107505071(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			local var_288_0 = "ST37"

			if arg_285_1.bgs_[var_288_0] == nil then
				local var_288_1 = Object.Instantiate(arg_285_1.paintGo_)

				var_288_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_288_0)
				var_288_1.name = var_288_0
				var_288_1.transform.parent = arg_285_1.stage_.transform
				var_288_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_285_1.bgs_[var_288_0] = var_288_1
			end

			local var_288_2 = 2

			if var_288_2 < arg_285_1.time_ and arg_285_1.time_ <= var_288_2 + arg_288_0 then
				local var_288_3 = manager.ui.mainCamera.transform.localPosition
				local var_288_4 = Vector3.New(0, 0, 10) + Vector3.New(var_288_3.x, var_288_3.y, 0)
				local var_288_5 = arg_285_1.bgs_.ST37

				var_288_5.transform.localPosition = var_288_4
				var_288_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_288_6 = var_288_5:GetComponent("SpriteRenderer")

				if var_288_6 and var_288_6.sprite then
					local var_288_7 = (var_288_5.transform.localPosition - var_288_3).z
					local var_288_8 = manager.ui.mainCameraCom_
					local var_288_9 = 2 * var_288_7 * Mathf.Tan(var_288_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_288_10 = var_288_9 * var_288_8.aspect
					local var_288_11 = var_288_6.sprite.bounds.size.x
					local var_288_12 = var_288_6.sprite.bounds.size.y
					local var_288_13 = var_288_10 / var_288_11
					local var_288_14 = var_288_9 / var_288_12
					local var_288_15 = var_288_14 < var_288_13 and var_288_13 or var_288_14

					var_288_5.transform.localScale = Vector3.New(var_288_15, var_288_15, 0)
				end

				for iter_288_0, iter_288_1 in pairs(arg_285_1.bgs_) do
					if iter_288_0 ~= "ST37" then
						iter_288_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_288_16 = 4

			if var_288_16 < arg_285_1.time_ and arg_285_1.time_ <= var_288_16 + arg_288_0 then
				arg_285_1.allBtn_.enabled = false
			end

			local var_288_17 = 0.3

			if arg_285_1.time_ >= var_288_16 + var_288_17 and arg_285_1.time_ < var_288_16 + var_288_17 + arg_288_0 then
				arg_285_1.allBtn_.enabled = true
			end

			local var_288_18 = 0

			if var_288_18 < arg_285_1.time_ and arg_285_1.time_ <= var_288_18 + arg_288_0 then
				arg_285_1.mask_.enabled = true
				arg_285_1.mask_.raycastTarget = true

				arg_285_1:SetGaussion(false)
			end

			local var_288_19 = 2

			if var_288_18 <= arg_285_1.time_ and arg_285_1.time_ < var_288_18 + var_288_19 then
				local var_288_20 = (arg_285_1.time_ - var_288_18) / var_288_19
				local var_288_21 = Color.New(0, 0, 0)

				var_288_21.a = Mathf.Lerp(0, 1, var_288_20)
				arg_285_1.mask_.color = var_288_21
			end

			if arg_285_1.time_ >= var_288_18 + var_288_19 and arg_285_1.time_ < var_288_18 + var_288_19 + arg_288_0 then
				local var_288_22 = Color.New(0, 0, 0)

				var_288_22.a = 1
				arg_285_1.mask_.color = var_288_22
			end

			local var_288_23 = 2

			if var_288_23 < arg_285_1.time_ and arg_285_1.time_ <= var_288_23 + arg_288_0 then
				arg_285_1.mask_.enabled = true
				arg_285_1.mask_.raycastTarget = true

				arg_285_1:SetGaussion(false)
			end

			local var_288_24 = 2

			if var_288_23 <= arg_285_1.time_ and arg_285_1.time_ < var_288_23 + var_288_24 then
				local var_288_25 = (arg_285_1.time_ - var_288_23) / var_288_24
				local var_288_26 = Color.New(0, 0, 0)

				var_288_26.a = Mathf.Lerp(1, 0, var_288_25)
				arg_285_1.mask_.color = var_288_26
			end

			if arg_285_1.time_ >= var_288_23 + var_288_24 and arg_285_1.time_ < var_288_23 + var_288_24 + arg_288_0 then
				local var_288_27 = Color.New(0, 0, 0)
				local var_288_28 = 0

				arg_285_1.mask_.enabled = false
				var_288_27.a = var_288_28
				arg_285_1.mask_.color = var_288_27
			end

			if arg_285_1.frameCnt_ <= 1 then
				arg_285_1.dialog_:SetActive(false)
			end

			local var_288_29 = 4
			local var_288_30 = 0.9

			if var_288_29 < arg_285_1.time_ and arg_285_1.time_ <= var_288_29 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0

				arg_285_1.dialog_:SetActive(true)

				arg_285_1.dialogCg_.alpha = 0

				local var_288_31 = LeanTween.value(arg_285_1.dialog_, 0, 1, 0.3)

				var_288_31:setOnUpdate(LuaHelper.FloatAction(function(arg_289_0)
					arg_285_1.dialogCg_.alpha = arg_289_0
				end))
				var_288_31:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_285_1.dialog_)
					var_288_31:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_285_1.duration_ = arg_285_1.duration_ + 0.3

				SetActive(arg_285_1.leftNameGo_, false)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_32 = arg_285_1:GetWordFromCfg(1107505070)
				local var_288_33 = arg_285_1:FormatText(var_288_32.content)

				arg_285_1.text_.text = var_288_33

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_34 = 36
				local var_288_35 = utf8.len(var_288_33)
				local var_288_36 = var_288_34 <= 0 and var_288_30 or var_288_30 * (var_288_35 / var_288_34)

				if var_288_36 > 0 and var_288_30 < var_288_36 then
					arg_285_1.talkMaxDuration = var_288_36
					var_288_29 = var_288_29 + 0.3

					if var_288_36 + var_288_29 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_36 + var_288_29
					end
				end

				arg_285_1.text_.text = var_288_33
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)
				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_37 = var_288_29 + 0.3
			local var_288_38 = math.max(var_288_30, arg_285_1.talkMaxDuration)

			if var_288_37 <= arg_285_1.time_ and arg_285_1.time_ < var_288_37 + var_288_38 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_37) / var_288_38

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_37 + var_288_38 and arg_285_1.time_ < var_288_37 + var_288_38 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {}

		arg_285_1:InitPlayNodeList()
	end,
	Play1107505071 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 1107505071
		arg_291_1.duration_ = 5

		SetActive(arg_291_1.tipsGo_, false)

		function arg_291_1.onSingleLineFinish_()
			arg_291_1.onSingleLineUpdate_ = nil
			arg_291_1.onSingleLineFinish_ = nil
			arg_291_1.state_ = "waiting"
		end

		function arg_291_1.playNext_(arg_293_0)
			if arg_293_0 == 1 then
				arg_291_0:Play1107505072(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			local var_294_0 = 0
			local var_294_1 = 0.725

			if var_294_0 < arg_291_1.time_ and arg_291_1.time_ <= var_294_0 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0
				arg_291_1.dialogCg_.alpha = 1

				arg_291_1.dialog_:SetActive(true)
				SetActive(arg_291_1.leftNameGo_, true)

				local var_294_2 = arg_291_1:FormatText(StoryNameCfg[7].name)

				arg_291_1.leftNameTxt_.text = var_294_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_291_1.leftNameTxt_.transform)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1.leftNameTxt_.text)
				SetActive(arg_291_1.iconTrs_.gameObject, true)
				arg_291_1.iconController_:SetSelectedState("hero")

				arg_291_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_291_1.callingController_:SetSelectedState("normal")

				arg_291_1.keyicon_.color = Color.New(1, 1, 1)
				arg_291_1.icon_.color = Color.New(1, 1, 1)

				local var_294_3 = arg_291_1:GetWordFromCfg(1107505071)
				local var_294_4 = arg_291_1:FormatText(var_294_3.content)

				arg_291_1.text_.text = var_294_4

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_5 = 29
				local var_294_6 = utf8.len(var_294_4)
				local var_294_7 = var_294_5 <= 0 and var_294_1 or var_294_1 * (var_294_6 / var_294_5)

				if var_294_7 > 0 and var_294_1 < var_294_7 then
					arg_291_1.talkMaxDuration = var_294_7

					if var_294_7 + var_294_0 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_7 + var_294_0
					end
				end

				arg_291_1.text_.text = var_294_4
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)
				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_8 = math.max(var_294_1, arg_291_1.talkMaxDuration)

			if var_294_0 <= arg_291_1.time_ and arg_291_1.time_ < var_294_0 + var_294_8 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - var_294_0) / var_294_8

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= var_294_0 + var_294_8 and arg_291_1.time_ < var_294_0 + var_294_8 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {}

		arg_291_1:InitPlayNodeList()
	end,
	Play1107505072 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 1107505072
		arg_295_1.duration_ = 8.6

		SetActive(arg_295_1.tipsGo_, false)

		function arg_295_1.onSingleLineFinish_()
			arg_295_1.onSingleLineUpdate_ = nil
			arg_295_1.onSingleLineFinish_ = nil
			arg_295_1.state_ = "waiting"
		end

		function arg_295_1.playNext_(arg_297_0)
			if arg_297_0 == 1 then
				arg_295_0:Play1107505073(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			local var_298_0 = arg_295_1.actors_["1075ui_actor"].transform
			local var_298_1 = 0

			if var_298_1 < arg_295_1.time_ and arg_295_1.time_ <= var_298_1 + arg_298_0 then
				arg_295_1.var_.moveOldPos1075ui_actor = var_298_0.localPosition

				local var_298_2 = GameObjectTools.GetOrAddComponent(var_298_0.gameObject, typeof(DynamicBoneHelper))

				if var_298_2 then
					var_298_2:EnableDynamicBone(false)
				end
			end

			local var_298_3 = 0.001

			if var_298_1 <= arg_295_1.time_ and arg_295_1.time_ < var_298_1 + var_298_3 then
				local var_298_4 = (arg_295_1.time_ - var_298_1) / var_298_3
				local var_298_5 = Vector3.New(0, -1.055, -6.16)

				var_298_0.localPosition = Vector3.Lerp(arg_295_1.var_.moveOldPos1075ui_actor, var_298_5, var_298_4)

				local var_298_6 = manager.ui.mainCamera.transform.position - var_298_0.position

				var_298_0.forward = Vector3.New(var_298_6.x, var_298_6.y, var_298_6.z)

				local var_298_7 = var_298_0.localEulerAngles

				var_298_7.z = 0
				var_298_7.x = 0
				var_298_0.localEulerAngles = var_298_7
			end

			if arg_295_1.time_ >= var_298_1 + var_298_3 and arg_295_1.time_ < var_298_1 + var_298_3 + arg_298_0 then
				var_298_0.localPosition = Vector3.New(0, -1.055, -6.16)

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

			local var_298_11 = arg_295_1.actors_["1075ui_actor"]
			local var_298_12 = 0

			if var_298_12 < arg_295_1.time_ and arg_295_1.time_ <= var_298_12 + arg_298_0 and not isNil(var_298_11) and arg_295_1.var_.characterEffect1075ui_actor == nil then
				arg_295_1.var_.characterEffect1075ui_actor = var_298_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_298_13 = 0.200000002980232

			if var_298_12 <= arg_295_1.time_ and arg_295_1.time_ < var_298_12 + var_298_13 and not isNil(var_298_11) then
				local var_298_14 = (arg_295_1.time_ - var_298_12) / var_298_13

				if arg_295_1.var_.characterEffect1075ui_actor and not isNil(var_298_11) then
					arg_295_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_295_1.time_ >= var_298_12 + var_298_13 and arg_295_1.time_ < var_298_12 + var_298_13 + arg_298_0 and not isNil(var_298_11) and arg_295_1.var_.characterEffect1075ui_actor then
				arg_295_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			local var_298_15 = 0

			if var_298_15 < arg_295_1.time_ and arg_295_1.time_ <= var_298_15 + arg_298_0 then
				arg_295_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075action/1075action2_1")
			end

			local var_298_16 = 0

			if var_298_16 < arg_295_1.time_ and arg_295_1.time_ <= var_298_16 + arg_298_0 then
				arg_295_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_298_17 = 0
			local var_298_18 = 0.8

			if var_298_17 < arg_295_1.time_ and arg_295_1.time_ <= var_298_17 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, true)

				local var_298_19 = arg_295_1:FormatText(StoryNameCfg[381].name)

				arg_295_1.leftNameTxt_.text = var_298_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_295_1.leftNameTxt_.transform)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1.leftNameTxt_.text)
				SetActive(arg_295_1.iconTrs_.gameObject, false)
				arg_295_1.callingController_:SetSelectedState("normal")

				local var_298_20 = arg_295_1:GetWordFromCfg(1107505072)
				local var_298_21 = arg_295_1:FormatText(var_298_20.content)

				arg_295_1.text_.text = var_298_21

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_22 = 32
				local var_298_23 = utf8.len(var_298_21)
				local var_298_24 = var_298_22 <= 0 and var_298_18 or var_298_18 * (var_298_23 / var_298_22)

				if var_298_24 > 0 and var_298_18 < var_298_24 then
					arg_295_1.talkMaxDuration = var_298_24

					if var_298_24 + var_298_17 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_24 + var_298_17
					end
				end

				arg_295_1.text_.text = var_298_21
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107505", "1107505072", "story_v_side_new_1107505.awb") ~= 0 then
					local var_298_25 = manager.audio:GetVoiceLength("story_v_side_new_1107505", "1107505072", "story_v_side_new_1107505.awb") / 1000

					if var_298_25 + var_298_17 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_25 + var_298_17
					end

					if var_298_20.prefab_name ~= "" and arg_295_1.actors_[var_298_20.prefab_name] ~= nil then
						local var_298_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_295_1.actors_[var_298_20.prefab_name].transform, "story_v_side_new_1107505", "1107505072", "story_v_side_new_1107505.awb")

						arg_295_1:RecordAudio("1107505072", var_298_26)
						arg_295_1:RecordAudio("1107505072", var_298_26)
					else
						arg_295_1:AudioAction("play", "voice", "story_v_side_new_1107505", "1107505072", "story_v_side_new_1107505.awb")
					end

					arg_295_1:RecordHistoryTalkVoice("story_v_side_new_1107505", "1107505072", "story_v_side_new_1107505.awb")
				end

				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_27 = math.max(var_298_18, arg_295_1.talkMaxDuration)

			if var_298_17 <= arg_295_1.time_ and arg_295_1.time_ < var_298_17 + var_298_27 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - var_298_17) / var_298_27

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= var_298_17 + var_298_27 and arg_295_1.time_ < var_298_17 + var_298_27 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_actor",
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
	Play1107505073 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 1107505073
		arg_299_1.duration_ = 5

		SetActive(arg_299_1.tipsGo_, false)

		function arg_299_1.onSingleLineFinish_()
			arg_299_1.onSingleLineUpdate_ = nil
			arg_299_1.onSingleLineFinish_ = nil
			arg_299_1.state_ = "waiting"
		end

		function arg_299_1.playNext_(arg_301_0)
			if arg_301_0 == 1 then
				arg_299_0:Play1107505074(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			local var_302_0 = arg_299_1.actors_["1075ui_actor"]
			local var_302_1 = 0

			if var_302_1 < arg_299_1.time_ and arg_299_1.time_ <= var_302_1 + arg_302_0 and not isNil(var_302_0) and arg_299_1.var_.characterEffect1075ui_actor == nil then
				arg_299_1.var_.characterEffect1075ui_actor = var_302_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_302_2 = 0.200000002980232

			if var_302_1 <= arg_299_1.time_ and arg_299_1.time_ < var_302_1 + var_302_2 and not isNil(var_302_0) then
				local var_302_3 = (arg_299_1.time_ - var_302_1) / var_302_2

				if arg_299_1.var_.characterEffect1075ui_actor and not isNil(var_302_0) then
					local var_302_4 = Mathf.Lerp(0, 0.5, var_302_3)

					arg_299_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_299_1.var_.characterEffect1075ui_actor.fillRatio = var_302_4
				end
			end

			if arg_299_1.time_ >= var_302_1 + var_302_2 and arg_299_1.time_ < var_302_1 + var_302_2 + arg_302_0 and not isNil(var_302_0) and arg_299_1.var_.characterEffect1075ui_actor then
				local var_302_5 = 0.5

				arg_299_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_299_1.var_.characterEffect1075ui_actor.fillRatio = var_302_5
			end

			local var_302_6 = 0
			local var_302_7 = 0.4

			if var_302_6 < arg_299_1.time_ and arg_299_1.time_ <= var_302_6 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0
				arg_299_1.dialogCg_.alpha = 1

				arg_299_1.dialog_:SetActive(true)
				SetActive(arg_299_1.leftNameGo_, true)

				local var_302_8 = arg_299_1:FormatText(StoryNameCfg[7].name)

				arg_299_1.leftNameTxt_.text = var_302_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_299_1.leftNameTxt_.transform)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1.leftNameTxt_.text)
				SetActive(arg_299_1.iconTrs_.gameObject, true)
				arg_299_1.iconController_:SetSelectedState("hero")

				arg_299_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_299_1.callingController_:SetSelectedState("normal")

				arg_299_1.keyicon_.color = Color.New(1, 1, 1)
				arg_299_1.icon_.color = Color.New(1, 1, 1)

				local var_302_9 = arg_299_1:GetWordFromCfg(1107505073)
				local var_302_10 = arg_299_1:FormatText(var_302_9.content)

				arg_299_1.text_.text = var_302_10

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_11 = 16
				local var_302_12 = utf8.len(var_302_10)
				local var_302_13 = var_302_11 <= 0 and var_302_7 or var_302_7 * (var_302_12 / var_302_11)

				if var_302_13 > 0 and var_302_7 < var_302_13 then
					arg_299_1.talkMaxDuration = var_302_13

					if var_302_13 + var_302_6 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_13 + var_302_6
					end
				end

				arg_299_1.text_.text = var_302_10
				arg_299_1.typewritter.percent = 0

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(false)
				arg_299_1:RecordContent(arg_299_1.text_.text)
			end

			local var_302_14 = math.max(var_302_7, arg_299_1.talkMaxDuration)

			if var_302_6 <= arg_299_1.time_ and arg_299_1.time_ < var_302_6 + var_302_14 then
				arg_299_1.typewritter.percent = (arg_299_1.time_ - var_302_6) / var_302_14

				arg_299_1.typewritter:SetDirty()
			end

			if arg_299_1.time_ >= var_302_6 + var_302_14 and arg_299_1.time_ < var_302_6 + var_302_14 + arg_302_0 then
				arg_299_1.typewritter.percent = 1

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(true)
			end
		end

		arg_299_1.nodeConfigList_ = {}

		arg_299_1:InitPlayNodeList()
	end,
	Play1107505074 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 1107505074
		arg_303_1.duration_ = 6.5

		SetActive(arg_303_1.tipsGo_, false)

		function arg_303_1.onSingleLineFinish_()
			arg_303_1.onSingleLineUpdate_ = nil
			arg_303_1.onSingleLineFinish_ = nil
			arg_303_1.state_ = "waiting"
		end

		function arg_303_1.playNext_(arg_305_0)
			if arg_305_0 == 1 then
				arg_303_0:Play1107505075(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			local var_306_0 = arg_303_1.actors_["1075ui_actor"]
			local var_306_1 = 0

			if var_306_1 < arg_303_1.time_ and arg_303_1.time_ <= var_306_1 + arg_306_0 and not isNil(var_306_0) and arg_303_1.var_.characterEffect1075ui_actor == nil then
				arg_303_1.var_.characterEffect1075ui_actor = var_306_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_306_2 = 0.200000002980232

			if var_306_1 <= arg_303_1.time_ and arg_303_1.time_ < var_306_1 + var_306_2 and not isNil(var_306_0) then
				local var_306_3 = (arg_303_1.time_ - var_306_1) / var_306_2

				if arg_303_1.var_.characterEffect1075ui_actor and not isNil(var_306_0) then
					arg_303_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_303_1.time_ >= var_306_1 + var_306_2 and arg_303_1.time_ < var_306_1 + var_306_2 + arg_306_0 and not isNil(var_306_0) and arg_303_1.var_.characterEffect1075ui_actor then
				arg_303_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			local var_306_4 = 0

			if var_306_4 < arg_303_1.time_ and arg_303_1.time_ <= var_306_4 + arg_306_0 then
				arg_303_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075actionlink/1075action424")
			end

			local var_306_5 = 0

			if var_306_5 < arg_303_1.time_ and arg_303_1.time_ <= var_306_5 + arg_306_0 then
				arg_303_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_306_6 = 0
			local var_306_7 = 0.625

			if var_306_6 < arg_303_1.time_ and arg_303_1.time_ <= var_306_6 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, true)

				local var_306_8 = arg_303_1:FormatText(StoryNameCfg[381].name)

				arg_303_1.leftNameTxt_.text = var_306_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_303_1.leftNameTxt_.transform)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1.leftNameTxt_.text)
				SetActive(arg_303_1.iconTrs_.gameObject, false)
				arg_303_1.callingController_:SetSelectedState("normal")

				local var_306_9 = arg_303_1:GetWordFromCfg(1107505074)
				local var_306_10 = arg_303_1:FormatText(var_306_9.content)

				arg_303_1.text_.text = var_306_10

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_11 = 25
				local var_306_12 = utf8.len(var_306_10)
				local var_306_13 = var_306_11 <= 0 and var_306_7 or var_306_7 * (var_306_12 / var_306_11)

				if var_306_13 > 0 and var_306_7 < var_306_13 then
					arg_303_1.talkMaxDuration = var_306_13

					if var_306_13 + var_306_6 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_13 + var_306_6
					end
				end

				arg_303_1.text_.text = var_306_10
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107505", "1107505074", "story_v_side_new_1107505.awb") ~= 0 then
					local var_306_14 = manager.audio:GetVoiceLength("story_v_side_new_1107505", "1107505074", "story_v_side_new_1107505.awb") / 1000

					if var_306_14 + var_306_6 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_14 + var_306_6
					end

					if var_306_9.prefab_name ~= "" and arg_303_1.actors_[var_306_9.prefab_name] ~= nil then
						local var_306_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_303_1.actors_[var_306_9.prefab_name].transform, "story_v_side_new_1107505", "1107505074", "story_v_side_new_1107505.awb")

						arg_303_1:RecordAudio("1107505074", var_306_15)
						arg_303_1:RecordAudio("1107505074", var_306_15)
					else
						arg_303_1:AudioAction("play", "voice", "story_v_side_new_1107505", "1107505074", "story_v_side_new_1107505.awb")
					end

					arg_303_1:RecordHistoryTalkVoice("story_v_side_new_1107505", "1107505074", "story_v_side_new_1107505.awb")
				end

				arg_303_1:RecordContent(arg_303_1.text_.text)
			end

			local var_306_16 = math.max(var_306_7, arg_303_1.talkMaxDuration)

			if var_306_6 <= arg_303_1.time_ and arg_303_1.time_ < var_306_6 + var_306_16 then
				arg_303_1.typewritter.percent = (arg_303_1.time_ - var_306_6) / var_306_16

				arg_303_1.typewritter:SetDirty()
			end

			if arg_303_1.time_ >= var_306_6 + var_306_16 and arg_303_1.time_ < var_306_6 + var_306_16 + arg_306_0 then
				arg_303_1.typewritter.percent = 1

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(true)
			end
		end

		arg_303_1.nodeConfigList_ = {}

		arg_303_1:InitPlayNodeList()
	end,
	Play1107505075 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 1107505075
		arg_307_1.duration_ = 1

		SetActive(arg_307_1.tipsGo_, true)

		arg_307_1.tipsText_.text = StoryTipsCfg[107501].name

		function arg_307_1.onSingleLineFinish_()
			arg_307_1.onSingleLineUpdate_ = nil
			arg_307_1.onSingleLineFinish_ = nil
			arg_307_1.state_ = "waiting"

			SetActive(arg_307_1.choicesGo_, true)

			for iter_308_0, iter_308_1 in ipairs(arg_307_1.choices_) do
				local var_308_0 = iter_308_0 <= 2

				SetActive(iter_308_1.go, var_308_0)
			end

			arg_307_1.choices_[1].txt.text = arg_307_1:FormatText(StoryChoiceCfg[1163].name)
			arg_307_1.choices_[2].txt.text = arg_307_1:FormatText(StoryChoiceCfg[1164].name)
		end

		function arg_307_1.playNext_(arg_309_0)
			if arg_309_0 == 1 then
				arg_307_0:Play1107505076(arg_307_1)
			end

			if arg_309_0 == 2 then
				PlayerAction.UseStoryTrigger(1075011, 210750105, 1107505075, 2)
				arg_307_0:Play1107505078(arg_307_1)
			end

			arg_307_1:RecordChoiceLog(1107505075, 1163, 1164)
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			local var_310_0 = arg_307_1.actors_["1075ui_actor"]
			local var_310_1 = 0

			if var_310_1 < arg_307_1.time_ and arg_307_1.time_ <= var_310_1 + arg_310_0 and not isNil(var_310_0) and arg_307_1.var_.characterEffect1075ui_actor == nil then
				arg_307_1.var_.characterEffect1075ui_actor = var_310_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_310_2 = 0.200000002980232

			if var_310_1 <= arg_307_1.time_ and arg_307_1.time_ < var_310_1 + var_310_2 and not isNil(var_310_0) then
				local var_310_3 = (arg_307_1.time_ - var_310_1) / var_310_2

				if arg_307_1.var_.characterEffect1075ui_actor and not isNil(var_310_0) then
					local var_310_4 = Mathf.Lerp(0, 0.5, var_310_3)

					arg_307_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_307_1.var_.characterEffect1075ui_actor.fillRatio = var_310_4
				end
			end

			if arg_307_1.time_ >= var_310_1 + var_310_2 and arg_307_1.time_ < var_310_1 + var_310_2 + arg_310_0 and not isNil(var_310_0) and arg_307_1.var_.characterEffect1075ui_actor then
				local var_310_5 = 0.5

				arg_307_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_307_1.var_.characterEffect1075ui_actor.fillRatio = var_310_5
			end

			local var_310_6 = 0

			if var_310_6 < arg_307_1.time_ and arg_307_1.time_ <= var_310_6 + arg_310_0 then
				arg_307_1.allBtn_.enabled = false
			end

			local var_310_7 = 0.5

			if arg_307_1.time_ >= var_310_6 + var_310_7 and arg_307_1.time_ < var_310_6 + var_310_7 + arg_310_0 then
				arg_307_1.allBtn_.enabled = true
			end
		end

		arg_307_1.nodeConfigList_ = {}

		arg_307_1:InitPlayNodeList()
	end,
	Play1107505076 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 1107505076
		arg_311_1.duration_ = 4.93

		SetActive(arg_311_1.tipsGo_, false)

		function arg_311_1.onSingleLineFinish_()
			arg_311_1.onSingleLineUpdate_ = nil
			arg_311_1.onSingleLineFinish_ = nil
			arg_311_1.state_ = "waiting"
		end

		function arg_311_1.playNext_(arg_313_0)
			if arg_313_0 == 1 then
				arg_311_0:Play1107505077(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			local var_314_0 = arg_311_1.actors_["1075ui_actor"]
			local var_314_1 = 0

			if var_314_1 < arg_311_1.time_ and arg_311_1.time_ <= var_314_1 + arg_314_0 and not isNil(var_314_0) and arg_311_1.var_.characterEffect1075ui_actor == nil then
				arg_311_1.var_.characterEffect1075ui_actor = var_314_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_314_2 = 0.200000002980232

			if var_314_1 <= arg_311_1.time_ and arg_311_1.time_ < var_314_1 + var_314_2 and not isNil(var_314_0) then
				local var_314_3 = (arg_311_1.time_ - var_314_1) / var_314_2

				if arg_311_1.var_.characterEffect1075ui_actor and not isNil(var_314_0) then
					arg_311_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_311_1.time_ >= var_314_1 + var_314_2 and arg_311_1.time_ < var_314_1 + var_314_2 + arg_314_0 and not isNil(var_314_0) and arg_311_1.var_.characterEffect1075ui_actor then
				arg_311_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			local var_314_4 = 0

			if var_314_4 < arg_311_1.time_ and arg_311_1.time_ <= var_314_4 + arg_314_0 then
				arg_311_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075action/1075action4_2")
			end

			local var_314_5 = 0

			if var_314_5 < arg_311_1.time_ and arg_311_1.time_ <= var_314_5 + arg_314_0 then
				arg_311_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_314_6 = 0
			local var_314_7 = 0.375

			if var_314_6 < arg_311_1.time_ and arg_311_1.time_ <= var_314_6 + arg_314_0 then
				arg_311_1.talkMaxDuration = 0
				arg_311_1.dialogCg_.alpha = 1

				arg_311_1.dialog_:SetActive(true)
				SetActive(arg_311_1.leftNameGo_, true)

				local var_314_8 = arg_311_1:FormatText(StoryNameCfg[381].name)

				arg_311_1.leftNameTxt_.text = var_314_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_311_1.leftNameTxt_.transform)

				arg_311_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_311_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_311_1:RecordName(arg_311_1.leftNameTxt_.text)
				SetActive(arg_311_1.iconTrs_.gameObject, false)
				arg_311_1.callingController_:SetSelectedState("normal")

				local var_314_9 = arg_311_1:GetWordFromCfg(1107505076)
				local var_314_10 = arg_311_1:FormatText(var_314_9.content)

				arg_311_1.text_.text = var_314_10

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_11 = 15
				local var_314_12 = utf8.len(var_314_10)
				local var_314_13 = var_314_11 <= 0 and var_314_7 or var_314_7 * (var_314_12 / var_314_11)

				if var_314_13 > 0 and var_314_7 < var_314_13 then
					arg_311_1.talkMaxDuration = var_314_13

					if var_314_13 + var_314_6 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_13 + var_314_6
					end
				end

				arg_311_1.text_.text = var_314_10
				arg_311_1.typewritter.percent = 0

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107505", "1107505076", "story_v_side_new_1107505.awb") ~= 0 then
					local var_314_14 = manager.audio:GetVoiceLength("story_v_side_new_1107505", "1107505076", "story_v_side_new_1107505.awb") / 1000

					if var_314_14 + var_314_6 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_14 + var_314_6
					end

					if var_314_9.prefab_name ~= "" and arg_311_1.actors_[var_314_9.prefab_name] ~= nil then
						local var_314_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_311_1.actors_[var_314_9.prefab_name].transform, "story_v_side_new_1107505", "1107505076", "story_v_side_new_1107505.awb")

						arg_311_1:RecordAudio("1107505076", var_314_15)
						arg_311_1:RecordAudio("1107505076", var_314_15)
					else
						arg_311_1:AudioAction("play", "voice", "story_v_side_new_1107505", "1107505076", "story_v_side_new_1107505.awb")
					end

					arg_311_1:RecordHistoryTalkVoice("story_v_side_new_1107505", "1107505076", "story_v_side_new_1107505.awb")
				end

				arg_311_1:RecordContent(arg_311_1.text_.text)
			end

			local var_314_16 = math.max(var_314_7, arg_311_1.talkMaxDuration)

			if var_314_6 <= arg_311_1.time_ and arg_311_1.time_ < var_314_6 + var_314_16 then
				arg_311_1.typewritter.percent = (arg_311_1.time_ - var_314_6) / var_314_16

				arg_311_1.typewritter:SetDirty()
			end

			if arg_311_1.time_ >= var_314_6 + var_314_16 and arg_311_1.time_ < var_314_6 + var_314_16 + arg_314_0 then
				arg_311_1.typewritter.percent = 1

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(true)
			end
		end

		arg_311_1.nodeConfigList_ = {}

		arg_311_1:InitPlayNodeList()
	end,
	Play1107505077 = function(arg_315_0, arg_315_1)
		arg_315_1.time_ = 0
		arg_315_1.frameCnt_ = 0
		arg_315_1.state_ = "playing"
		arg_315_1.curTalkId_ = 1107505077
		arg_315_1.duration_ = 5

		SetActive(arg_315_1.tipsGo_, false)

		function arg_315_1.onSingleLineFinish_()
			arg_315_1.onSingleLineUpdate_ = nil
			arg_315_1.onSingleLineFinish_ = nil
			arg_315_1.state_ = "waiting"
		end

		function arg_315_1.playNext_(arg_317_0)
			if arg_317_0 == 1 then
				arg_315_0:Play1107505083(arg_315_1)
			end
		end

		function arg_315_1.onSingleLineUpdate_(arg_318_0)
			local var_318_0 = arg_315_1.actors_["1075ui_actor"]
			local var_318_1 = 0

			if var_318_1 < arg_315_1.time_ and arg_315_1.time_ <= var_318_1 + arg_318_0 and not isNil(var_318_0) and arg_315_1.var_.characterEffect1075ui_actor == nil then
				arg_315_1.var_.characterEffect1075ui_actor = var_318_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_318_2 = 0.200000002980232

			if var_318_1 <= arg_315_1.time_ and arg_315_1.time_ < var_318_1 + var_318_2 and not isNil(var_318_0) then
				local var_318_3 = (arg_315_1.time_ - var_318_1) / var_318_2

				if arg_315_1.var_.characterEffect1075ui_actor and not isNil(var_318_0) then
					local var_318_4 = Mathf.Lerp(0, 0.5, var_318_3)

					arg_315_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_315_1.var_.characterEffect1075ui_actor.fillRatio = var_318_4
				end
			end

			if arg_315_1.time_ >= var_318_1 + var_318_2 and arg_315_1.time_ < var_318_1 + var_318_2 + arg_318_0 and not isNil(var_318_0) and arg_315_1.var_.characterEffect1075ui_actor then
				local var_318_5 = 0.5

				arg_315_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_315_1.var_.characterEffect1075ui_actor.fillRatio = var_318_5
			end

			local var_318_6 = 0
			local var_318_7 = 0.55

			if var_318_6 < arg_315_1.time_ and arg_315_1.time_ <= var_318_6 + arg_318_0 then
				arg_315_1.talkMaxDuration = 0
				arg_315_1.dialogCg_.alpha = 1

				arg_315_1.dialog_:SetActive(true)
				SetActive(arg_315_1.leftNameGo_, true)

				local var_318_8 = arg_315_1:FormatText(StoryNameCfg[7].name)

				arg_315_1.leftNameTxt_.text = var_318_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_315_1.leftNameTxt_.transform)

				arg_315_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_315_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_315_1:RecordName(arg_315_1.leftNameTxt_.text)
				SetActive(arg_315_1.iconTrs_.gameObject, true)
				arg_315_1.iconController_:SetSelectedState("hero")

				arg_315_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_315_1.callingController_:SetSelectedState("normal")

				arg_315_1.keyicon_.color = Color.New(1, 1, 1)
				arg_315_1.icon_.color = Color.New(1, 1, 1)

				local var_318_9 = arg_315_1:GetWordFromCfg(1107505077)
				local var_318_10 = arg_315_1:FormatText(var_318_9.content)

				arg_315_1.text_.text = var_318_10

				LuaForUtil.ClearLinePrefixSymbol(arg_315_1.text_)

				local var_318_11 = 22
				local var_318_12 = utf8.len(var_318_10)
				local var_318_13 = var_318_11 <= 0 and var_318_7 or var_318_7 * (var_318_12 / var_318_11)

				if var_318_13 > 0 and var_318_7 < var_318_13 then
					arg_315_1.talkMaxDuration = var_318_13

					if var_318_13 + var_318_6 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_13 + var_318_6
					end
				end

				arg_315_1.text_.text = var_318_10
				arg_315_1.typewritter.percent = 0

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(false)
				arg_315_1:RecordContent(arg_315_1.text_.text)
			end

			local var_318_14 = math.max(var_318_7, arg_315_1.talkMaxDuration)

			if var_318_6 <= arg_315_1.time_ and arg_315_1.time_ < var_318_6 + var_318_14 then
				arg_315_1.typewritter.percent = (arg_315_1.time_ - var_318_6) / var_318_14

				arg_315_1.typewritter:SetDirty()
			end

			if arg_315_1.time_ >= var_318_6 + var_318_14 and arg_315_1.time_ < var_318_6 + var_318_14 + arg_318_0 then
				arg_315_1.typewritter.percent = 1

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(true)
			end
		end

		arg_315_1.nodeConfigList_ = {}

		arg_315_1:InitPlayNodeList()
	end,
	Play1107505083 = function(arg_319_0, arg_319_1)
		arg_319_1.time_ = 0
		arg_319_1.frameCnt_ = 0
		arg_319_1.state_ = "playing"
		arg_319_1.curTalkId_ = 1107505083
		arg_319_1.duration_ = 5

		SetActive(arg_319_1.tipsGo_, false)

		function arg_319_1.onSingleLineFinish_()
			arg_319_1.onSingleLineUpdate_ = nil
			arg_319_1.onSingleLineFinish_ = nil
			arg_319_1.state_ = "waiting"
		end

		function arg_319_1.playNext_(arg_321_0)
			if arg_321_0 == 1 then
				arg_319_0:Play1107505084(arg_319_1)
			end
		end

		function arg_319_1.onSingleLineUpdate_(arg_322_0)
			local var_322_0 = arg_319_1.actors_["1075ui_actor"].transform
			local var_322_1 = 0

			if var_322_1 < arg_319_1.time_ and arg_319_1.time_ <= var_322_1 + arg_322_0 then
				arg_319_1.var_.moveOldPos1075ui_actor = var_322_0.localPosition

				local var_322_2 = GameObjectTools.GetOrAddComponent(var_322_0.gameObject, typeof(DynamicBoneHelper))

				if var_322_2 then
					var_322_2:EnableDynamicBone(false)
				end
			end

			local var_322_3 = 0.001

			if var_322_1 <= arg_319_1.time_ and arg_319_1.time_ < var_322_1 + var_322_3 then
				local var_322_4 = (arg_319_1.time_ - var_322_1) / var_322_3
				local var_322_5 = Vector3.New(0, 100, 0)

				var_322_0.localPosition = Vector3.Lerp(arg_319_1.var_.moveOldPos1075ui_actor, var_322_5, var_322_4)

				local var_322_6 = manager.ui.mainCamera.transform.position - var_322_0.position

				var_322_0.forward = Vector3.New(var_322_6.x, var_322_6.y, var_322_6.z)

				local var_322_7 = var_322_0.localEulerAngles

				var_322_7.z = 0
				var_322_7.x = 0
				var_322_0.localEulerAngles = var_322_7
			end

			if arg_319_1.time_ >= var_322_1 + var_322_3 and arg_319_1.time_ < var_322_1 + var_322_3 + arg_322_0 then
				var_322_0.localPosition = Vector3.New(0, 100, 0)

				local var_322_8 = manager.ui.mainCamera.transform.position - var_322_0.position

				var_322_0.forward = Vector3.New(var_322_8.x, var_322_8.y, var_322_8.z)

				local var_322_9 = var_322_0.localEulerAngles

				var_322_9.z = 0
				var_322_9.x = 0
				var_322_0.localEulerAngles = var_322_9

				local var_322_10 = GameObjectTools.GetOrAddComponent(var_322_0.gameObject, typeof(DynamicBoneHelper))

				if var_322_10 then
					var_322_10:EnableDynamicBone(true)
				end
			end

			local var_322_11 = 0
			local var_322_12 = 0.6

			if var_322_11 < arg_319_1.time_ and arg_319_1.time_ <= var_322_11 + arg_322_0 then
				arg_319_1.talkMaxDuration = 0
				arg_319_1.dialogCg_.alpha = 1

				arg_319_1.dialog_:SetActive(true)
				SetActive(arg_319_1.leftNameGo_, true)

				local var_322_13 = arg_319_1:FormatText(StoryNameCfg[7].name)

				arg_319_1.leftNameTxt_.text = var_322_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_319_1.leftNameTxt_.transform)

				arg_319_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_319_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_319_1:RecordName(arg_319_1.leftNameTxt_.text)
				SetActive(arg_319_1.iconTrs_.gameObject, true)
				arg_319_1.iconController_:SetSelectedState("hero")

				arg_319_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_319_1.callingController_:SetSelectedState("normal")

				arg_319_1.keyicon_.color = Color.New(1, 1, 1)
				arg_319_1.icon_.color = Color.New(1, 1, 1)

				local var_322_14 = arg_319_1:GetWordFromCfg(1107505083)
				local var_322_15 = arg_319_1:FormatText(var_322_14.content)

				arg_319_1.text_.text = var_322_15

				LuaForUtil.ClearLinePrefixSymbol(arg_319_1.text_)

				local var_322_16 = 24
				local var_322_17 = utf8.len(var_322_15)
				local var_322_18 = var_322_16 <= 0 and var_322_12 or var_322_12 * (var_322_17 / var_322_16)

				if var_322_18 > 0 and var_322_12 < var_322_18 then
					arg_319_1.talkMaxDuration = var_322_18

					if var_322_18 + var_322_11 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_18 + var_322_11
					end
				end

				arg_319_1.text_.text = var_322_15
				arg_319_1.typewritter.percent = 0

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(false)
				arg_319_1:RecordContent(arg_319_1.text_.text)
			end

			local var_322_19 = math.max(var_322_12, arg_319_1.talkMaxDuration)

			if var_322_11 <= arg_319_1.time_ and arg_319_1.time_ < var_322_11 + var_322_19 then
				arg_319_1.typewritter.percent = (arg_319_1.time_ - var_322_11) / var_322_19

				arg_319_1.typewritter:SetDirty()
			end

			if arg_319_1.time_ >= var_322_11 + var_322_19 and arg_319_1.time_ < var_322_11 + var_322_19 + arg_322_0 then
				arg_319_1.typewritter.percent = 1

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(true)
			end
		end

		arg_319_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_actor",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_319_1:InitPlayNodeList()
	end,
	Play1107505084 = function(arg_323_0, arg_323_1)
		arg_323_1.time_ = 0
		arg_323_1.frameCnt_ = 0
		arg_323_1.state_ = "playing"
		arg_323_1.curTalkId_ = 1107505084
		arg_323_1.duration_ = 7.7

		SetActive(arg_323_1.tipsGo_, false)

		function arg_323_1.onSingleLineFinish_()
			arg_323_1.onSingleLineUpdate_ = nil
			arg_323_1.onSingleLineFinish_ = nil
			arg_323_1.state_ = "waiting"
		end

		function arg_323_1.playNext_(arg_325_0)
			if arg_325_0 == 1 then
				arg_323_0:Play1107505085(arg_323_1)
			end
		end

		function arg_323_1.onSingleLineUpdate_(arg_326_0)
			local var_326_0 = arg_323_1.actors_["1075ui_actor"]
			local var_326_1 = 0

			if var_326_1 < arg_323_1.time_ and arg_323_1.time_ <= var_326_1 + arg_326_0 and not isNil(var_326_0) and arg_323_1.var_.characterEffect1075ui_actor == nil then
				arg_323_1.var_.characterEffect1075ui_actor = var_326_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_326_2 = 0.200000002980232

			if var_326_1 <= arg_323_1.time_ and arg_323_1.time_ < var_326_1 + var_326_2 and not isNil(var_326_0) then
				local var_326_3 = (arg_323_1.time_ - var_326_1) / var_326_2

				if arg_323_1.var_.characterEffect1075ui_actor and not isNil(var_326_0) then
					arg_323_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_323_1.time_ >= var_326_1 + var_326_2 and arg_323_1.time_ < var_326_1 + var_326_2 + arg_326_0 and not isNil(var_326_0) and arg_323_1.var_.characterEffect1075ui_actor then
				arg_323_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			local var_326_4 = 0
			local var_326_5 = 0.675

			if var_326_4 < arg_323_1.time_ and arg_323_1.time_ <= var_326_4 + arg_326_0 then
				arg_323_1.talkMaxDuration = 0
				arg_323_1.dialogCg_.alpha = 1

				arg_323_1.dialog_:SetActive(true)
				SetActive(arg_323_1.leftNameGo_, true)

				local var_326_6 = arg_323_1:FormatText(StoryNameCfg[381].name)

				arg_323_1.leftNameTxt_.text = var_326_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_323_1.leftNameTxt_.transform)

				arg_323_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_323_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_323_1:RecordName(arg_323_1.leftNameTxt_.text)
				SetActive(arg_323_1.iconTrs_.gameObject, true)
				arg_323_1.iconController_:SetSelectedState("hero")

				arg_323_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1075")

				arg_323_1.callingController_:SetSelectedState("normal")

				arg_323_1.keyicon_.color = Color.New(1, 1, 1)
				arg_323_1.icon_.color = Color.New(1, 1, 1)

				local var_326_7 = arg_323_1:GetWordFromCfg(1107505084)
				local var_326_8 = arg_323_1:FormatText(var_326_7.content)

				arg_323_1.text_.text = var_326_8

				LuaForUtil.ClearLinePrefixSymbol(arg_323_1.text_)

				local var_326_9 = 27
				local var_326_10 = utf8.len(var_326_8)
				local var_326_11 = var_326_9 <= 0 and var_326_5 or var_326_5 * (var_326_10 / var_326_9)

				if var_326_11 > 0 and var_326_5 < var_326_11 then
					arg_323_1.talkMaxDuration = var_326_11

					if var_326_11 + var_326_4 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_11 + var_326_4
					end
				end

				arg_323_1.text_.text = var_326_8
				arg_323_1.typewritter.percent = 0

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107505", "1107505084", "story_v_side_new_1107505.awb") ~= 0 then
					local var_326_12 = manager.audio:GetVoiceLength("story_v_side_new_1107505", "1107505084", "story_v_side_new_1107505.awb") / 1000

					if var_326_12 + var_326_4 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_12 + var_326_4
					end

					if var_326_7.prefab_name ~= "" and arg_323_1.actors_[var_326_7.prefab_name] ~= nil then
						local var_326_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_323_1.actors_[var_326_7.prefab_name].transform, "story_v_side_new_1107505", "1107505084", "story_v_side_new_1107505.awb")

						arg_323_1:RecordAudio("1107505084", var_326_13)
						arg_323_1:RecordAudio("1107505084", var_326_13)
					else
						arg_323_1:AudioAction("play", "voice", "story_v_side_new_1107505", "1107505084", "story_v_side_new_1107505.awb")
					end

					arg_323_1:RecordHistoryTalkVoice("story_v_side_new_1107505", "1107505084", "story_v_side_new_1107505.awb")
				end

				arg_323_1:RecordContent(arg_323_1.text_.text)
			end

			local var_326_14 = math.max(var_326_5, arg_323_1.talkMaxDuration)

			if var_326_4 <= arg_323_1.time_ and arg_323_1.time_ < var_326_4 + var_326_14 then
				arg_323_1.typewritter.percent = (arg_323_1.time_ - var_326_4) / var_326_14

				arg_323_1.typewritter:SetDirty()
			end

			if arg_323_1.time_ >= var_326_4 + var_326_14 and arg_323_1.time_ < var_326_4 + var_326_14 + arg_326_0 then
				arg_323_1.typewritter.percent = 1

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(true)
			end
		end

		arg_323_1.nodeConfigList_ = {}

		arg_323_1:InitPlayNodeList()
	end,
	Play1107505085 = function(arg_327_0, arg_327_1)
		arg_327_1.time_ = 0
		arg_327_1.frameCnt_ = 0
		arg_327_1.state_ = "playing"
		arg_327_1.curTalkId_ = 1107505085
		arg_327_1.duration_ = 6.17

		SetActive(arg_327_1.tipsGo_, false)

		function arg_327_1.onSingleLineFinish_()
			arg_327_1.onSingleLineUpdate_ = nil
			arg_327_1.onSingleLineFinish_ = nil
			arg_327_1.state_ = "waiting"
		end

		function arg_327_1.playNext_(arg_329_0)
			if arg_329_0 == 1 then
				arg_327_0:Play1107505086(arg_327_1)
			end
		end

		function arg_327_1.onSingleLineUpdate_(arg_330_0)
			local var_330_0 = 0
			local var_330_1 = 0.55

			if var_330_0 < arg_327_1.time_ and arg_327_1.time_ <= var_330_0 + arg_330_0 then
				arg_327_1.talkMaxDuration = 0
				arg_327_1.dialogCg_.alpha = 1

				arg_327_1.dialog_:SetActive(true)
				SetActive(arg_327_1.leftNameGo_, true)

				local var_330_2 = arg_327_1:FormatText(StoryNameCfg[381].name)

				arg_327_1.leftNameTxt_.text = var_330_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_327_1.leftNameTxt_.transform)

				arg_327_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_327_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_327_1:RecordName(arg_327_1.leftNameTxt_.text)
				SetActive(arg_327_1.iconTrs_.gameObject, true)
				arg_327_1.iconController_:SetSelectedState("hero")

				arg_327_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1075")

				arg_327_1.callingController_:SetSelectedState("normal")

				arg_327_1.keyicon_.color = Color.New(1, 1, 1)
				arg_327_1.icon_.color = Color.New(1, 1, 1)

				local var_330_3 = arg_327_1:GetWordFromCfg(1107505085)
				local var_330_4 = arg_327_1:FormatText(var_330_3.content)

				arg_327_1.text_.text = var_330_4

				LuaForUtil.ClearLinePrefixSymbol(arg_327_1.text_)

				local var_330_5 = 22
				local var_330_6 = utf8.len(var_330_4)
				local var_330_7 = var_330_5 <= 0 and var_330_1 or var_330_1 * (var_330_6 / var_330_5)

				if var_330_7 > 0 and var_330_1 < var_330_7 then
					arg_327_1.talkMaxDuration = var_330_7

					if var_330_7 + var_330_0 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_7 + var_330_0
					end
				end

				arg_327_1.text_.text = var_330_4
				arg_327_1.typewritter.percent = 0

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107505", "1107505085", "story_v_side_new_1107505.awb") ~= 0 then
					local var_330_8 = manager.audio:GetVoiceLength("story_v_side_new_1107505", "1107505085", "story_v_side_new_1107505.awb") / 1000

					if var_330_8 + var_330_0 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_8 + var_330_0
					end

					if var_330_3.prefab_name ~= "" and arg_327_1.actors_[var_330_3.prefab_name] ~= nil then
						local var_330_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_327_1.actors_[var_330_3.prefab_name].transform, "story_v_side_new_1107505", "1107505085", "story_v_side_new_1107505.awb")

						arg_327_1:RecordAudio("1107505085", var_330_9)
						arg_327_1:RecordAudio("1107505085", var_330_9)
					else
						arg_327_1:AudioAction("play", "voice", "story_v_side_new_1107505", "1107505085", "story_v_side_new_1107505.awb")
					end

					arg_327_1:RecordHistoryTalkVoice("story_v_side_new_1107505", "1107505085", "story_v_side_new_1107505.awb")
				end

				arg_327_1:RecordContent(arg_327_1.text_.text)
			end

			local var_330_10 = math.max(var_330_1, arg_327_1.talkMaxDuration)

			if var_330_0 <= arg_327_1.time_ and arg_327_1.time_ < var_330_0 + var_330_10 then
				arg_327_1.typewritter.percent = (arg_327_1.time_ - var_330_0) / var_330_10

				arg_327_1.typewritter:SetDirty()
			end

			if arg_327_1.time_ >= var_330_0 + var_330_10 and arg_327_1.time_ < var_330_0 + var_330_10 + arg_330_0 then
				arg_327_1.typewritter.percent = 1

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(true)
			end
		end

		arg_327_1.nodeConfigList_ = {}

		arg_327_1:InitPlayNodeList()
	end,
	Play1107505086 = function(arg_331_0, arg_331_1)
		arg_331_1.time_ = 0
		arg_331_1.frameCnt_ = 0
		arg_331_1.state_ = "playing"
		arg_331_1.curTalkId_ = 1107505086
		arg_331_1.duration_ = 5

		SetActive(arg_331_1.tipsGo_, false)

		function arg_331_1.onSingleLineFinish_()
			arg_331_1.onSingleLineUpdate_ = nil
			arg_331_1.onSingleLineFinish_ = nil
			arg_331_1.state_ = "waiting"
		end

		function arg_331_1.playNext_(arg_333_0)
			if arg_333_0 == 1 then
				arg_331_0:Play1107505087(arg_331_1)
			end
		end

		function arg_331_1.onSingleLineUpdate_(arg_334_0)
			local var_334_0 = arg_331_1.actors_["1075ui_actor"]
			local var_334_1 = 0

			if var_334_1 < arg_331_1.time_ and arg_331_1.time_ <= var_334_1 + arg_334_0 and not isNil(var_334_0) and arg_331_1.var_.characterEffect1075ui_actor == nil then
				arg_331_1.var_.characterEffect1075ui_actor = var_334_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_334_2 = 0.200000002980232

			if var_334_1 <= arg_331_1.time_ and arg_331_1.time_ < var_334_1 + var_334_2 and not isNil(var_334_0) then
				local var_334_3 = (arg_331_1.time_ - var_334_1) / var_334_2

				if arg_331_1.var_.characterEffect1075ui_actor and not isNil(var_334_0) then
					local var_334_4 = Mathf.Lerp(0, 0.5, var_334_3)

					arg_331_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_331_1.var_.characterEffect1075ui_actor.fillRatio = var_334_4
				end
			end

			if arg_331_1.time_ >= var_334_1 + var_334_2 and arg_331_1.time_ < var_334_1 + var_334_2 + arg_334_0 and not isNil(var_334_0) and arg_331_1.var_.characterEffect1075ui_actor then
				local var_334_5 = 0.5

				arg_331_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_331_1.var_.characterEffect1075ui_actor.fillRatio = var_334_5
			end

			local var_334_6 = 0
			local var_334_7 = 0.5

			if var_334_6 < arg_331_1.time_ and arg_331_1.time_ <= var_334_6 + arg_334_0 then
				arg_331_1.talkMaxDuration = 0
				arg_331_1.dialogCg_.alpha = 1

				arg_331_1.dialog_:SetActive(true)
				SetActive(arg_331_1.leftNameGo_, true)

				local var_334_8 = arg_331_1:FormatText(StoryNameCfg[7].name)

				arg_331_1.leftNameTxt_.text = var_334_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_331_1.leftNameTxt_.transform)

				arg_331_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_331_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_331_1:RecordName(arg_331_1.leftNameTxt_.text)
				SetActive(arg_331_1.iconTrs_.gameObject, true)
				arg_331_1.iconController_:SetSelectedState("hero")

				arg_331_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_331_1.callingController_:SetSelectedState("normal")

				arg_331_1.keyicon_.color = Color.New(1, 1, 1)
				arg_331_1.icon_.color = Color.New(1, 1, 1)

				local var_334_9 = arg_331_1:GetWordFromCfg(1107505086)
				local var_334_10 = arg_331_1:FormatText(var_334_9.content)

				arg_331_1.text_.text = var_334_10

				LuaForUtil.ClearLinePrefixSymbol(arg_331_1.text_)

				local var_334_11 = 20
				local var_334_12 = utf8.len(var_334_10)
				local var_334_13 = var_334_11 <= 0 and var_334_7 or var_334_7 * (var_334_12 / var_334_11)

				if var_334_13 > 0 and var_334_7 < var_334_13 then
					arg_331_1.talkMaxDuration = var_334_13

					if var_334_13 + var_334_6 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_13 + var_334_6
					end
				end

				arg_331_1.text_.text = var_334_10
				arg_331_1.typewritter.percent = 0

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(false)
				arg_331_1:RecordContent(arg_331_1.text_.text)
			end

			local var_334_14 = math.max(var_334_7, arg_331_1.talkMaxDuration)

			if var_334_6 <= arg_331_1.time_ and arg_331_1.time_ < var_334_6 + var_334_14 then
				arg_331_1.typewritter.percent = (arg_331_1.time_ - var_334_6) / var_334_14

				arg_331_1.typewritter:SetDirty()
			end

			if arg_331_1.time_ >= var_334_6 + var_334_14 and arg_331_1.time_ < var_334_6 + var_334_14 + arg_334_0 then
				arg_331_1.typewritter.percent = 1

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(true)
			end
		end

		arg_331_1.nodeConfigList_ = {}

		arg_331_1:InitPlayNodeList()
	end,
	Play1107505087 = function(arg_335_0, arg_335_1)
		arg_335_1.time_ = 0
		arg_335_1.frameCnt_ = 0
		arg_335_1.state_ = "playing"
		arg_335_1.curTalkId_ = 1107505087
		arg_335_1.duration_ = 2.43

		SetActive(arg_335_1.tipsGo_, false)

		function arg_335_1.onSingleLineFinish_()
			arg_335_1.onSingleLineUpdate_ = nil
			arg_335_1.onSingleLineFinish_ = nil
			arg_335_1.state_ = "waiting"
		end

		function arg_335_1.playNext_(arg_337_0)
			if arg_337_0 == 1 then
				arg_335_0:Play1107505088(arg_335_1)
			end
		end

		function arg_335_1.onSingleLineUpdate_(arg_338_0)
			local var_338_0 = arg_335_1.actors_["1075ui_actor"]
			local var_338_1 = 0

			if var_338_1 < arg_335_1.time_ and arg_335_1.time_ <= var_338_1 + arg_338_0 and not isNil(var_338_0) and arg_335_1.var_.characterEffect1075ui_actor == nil then
				arg_335_1.var_.characterEffect1075ui_actor = var_338_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_338_2 = 0.200000002980232

			if var_338_1 <= arg_335_1.time_ and arg_335_1.time_ < var_338_1 + var_338_2 and not isNil(var_338_0) then
				local var_338_3 = (arg_335_1.time_ - var_338_1) / var_338_2

				if arg_335_1.var_.characterEffect1075ui_actor and not isNil(var_338_0) then
					arg_335_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_335_1.time_ >= var_338_1 + var_338_2 and arg_335_1.time_ < var_338_1 + var_338_2 + arg_338_0 and not isNil(var_338_0) and arg_335_1.var_.characterEffect1075ui_actor then
				arg_335_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			local var_338_4 = 0
			local var_338_5 = 0.25

			if var_338_4 < arg_335_1.time_ and arg_335_1.time_ <= var_338_4 + arg_338_0 then
				arg_335_1.talkMaxDuration = 0
				arg_335_1.dialogCg_.alpha = 1

				arg_335_1.dialog_:SetActive(true)
				SetActive(arg_335_1.leftNameGo_, true)

				local var_338_6 = arg_335_1:FormatText(StoryNameCfg[381].name)

				arg_335_1.leftNameTxt_.text = var_338_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_335_1.leftNameTxt_.transform)

				arg_335_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_335_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_335_1:RecordName(arg_335_1.leftNameTxt_.text)
				SetActive(arg_335_1.iconTrs_.gameObject, true)
				arg_335_1.iconController_:SetSelectedState("hero")

				arg_335_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1075")

				arg_335_1.callingController_:SetSelectedState("normal")

				arg_335_1.keyicon_.color = Color.New(1, 1, 1)
				arg_335_1.icon_.color = Color.New(1, 1, 1)

				local var_338_7 = arg_335_1:GetWordFromCfg(1107505087)
				local var_338_8 = arg_335_1:FormatText(var_338_7.content)

				arg_335_1.text_.text = var_338_8

				LuaForUtil.ClearLinePrefixSymbol(arg_335_1.text_)

				local var_338_9 = 10
				local var_338_10 = utf8.len(var_338_8)
				local var_338_11 = var_338_9 <= 0 and var_338_5 or var_338_5 * (var_338_10 / var_338_9)

				if var_338_11 > 0 and var_338_5 < var_338_11 then
					arg_335_1.talkMaxDuration = var_338_11

					if var_338_11 + var_338_4 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_11 + var_338_4
					end
				end

				arg_335_1.text_.text = var_338_8
				arg_335_1.typewritter.percent = 0

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107505", "1107505087", "story_v_side_new_1107505.awb") ~= 0 then
					local var_338_12 = manager.audio:GetVoiceLength("story_v_side_new_1107505", "1107505087", "story_v_side_new_1107505.awb") / 1000

					if var_338_12 + var_338_4 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_12 + var_338_4
					end

					if var_338_7.prefab_name ~= "" and arg_335_1.actors_[var_338_7.prefab_name] ~= nil then
						local var_338_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_335_1.actors_[var_338_7.prefab_name].transform, "story_v_side_new_1107505", "1107505087", "story_v_side_new_1107505.awb")

						arg_335_1:RecordAudio("1107505087", var_338_13)
						arg_335_1:RecordAudio("1107505087", var_338_13)
					else
						arg_335_1:AudioAction("play", "voice", "story_v_side_new_1107505", "1107505087", "story_v_side_new_1107505.awb")
					end

					arg_335_1:RecordHistoryTalkVoice("story_v_side_new_1107505", "1107505087", "story_v_side_new_1107505.awb")
				end

				arg_335_1:RecordContent(arg_335_1.text_.text)
			end

			local var_338_14 = math.max(var_338_5, arg_335_1.talkMaxDuration)

			if var_338_4 <= arg_335_1.time_ and arg_335_1.time_ < var_338_4 + var_338_14 then
				arg_335_1.typewritter.percent = (arg_335_1.time_ - var_338_4) / var_338_14

				arg_335_1.typewritter:SetDirty()
			end

			if arg_335_1.time_ >= var_338_4 + var_338_14 and arg_335_1.time_ < var_338_4 + var_338_14 + arg_338_0 then
				arg_335_1.typewritter.percent = 1

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(true)
			end
		end

		arg_335_1.nodeConfigList_ = {}

		arg_335_1:InitPlayNodeList()
	end,
	Play1107505088 = function(arg_339_0, arg_339_1)
		arg_339_1.time_ = 0
		arg_339_1.frameCnt_ = 0
		arg_339_1.state_ = "playing"
		arg_339_1.curTalkId_ = 1107505088
		arg_339_1.duration_ = 5

		SetActive(arg_339_1.tipsGo_, false)

		function arg_339_1.onSingleLineFinish_()
			arg_339_1.onSingleLineUpdate_ = nil
			arg_339_1.onSingleLineFinish_ = nil
			arg_339_1.state_ = "waiting"
		end

		function arg_339_1.playNext_(arg_341_0)
			if arg_341_0 == 1 then
				arg_339_0:Play1107505089(arg_339_1)
			end
		end

		function arg_339_1.onSingleLineUpdate_(arg_342_0)
			local var_342_0 = arg_339_1.actors_["1075ui_actor"]
			local var_342_1 = 0

			if var_342_1 < arg_339_1.time_ and arg_339_1.time_ <= var_342_1 + arg_342_0 and not isNil(var_342_0) and arg_339_1.var_.characterEffect1075ui_actor == nil then
				arg_339_1.var_.characterEffect1075ui_actor = var_342_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_342_2 = 0.200000002980232

			if var_342_1 <= arg_339_1.time_ and arg_339_1.time_ < var_342_1 + var_342_2 and not isNil(var_342_0) then
				local var_342_3 = (arg_339_1.time_ - var_342_1) / var_342_2

				if arg_339_1.var_.characterEffect1075ui_actor and not isNil(var_342_0) then
					local var_342_4 = Mathf.Lerp(0, 0.5, var_342_3)

					arg_339_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_339_1.var_.characterEffect1075ui_actor.fillRatio = var_342_4
				end
			end

			if arg_339_1.time_ >= var_342_1 + var_342_2 and arg_339_1.time_ < var_342_1 + var_342_2 + arg_342_0 and not isNil(var_342_0) and arg_339_1.var_.characterEffect1075ui_actor then
				local var_342_5 = 0.5

				arg_339_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_339_1.var_.characterEffect1075ui_actor.fillRatio = var_342_5
			end

			local var_342_6 = 0
			local var_342_7 = 0.55

			if var_342_6 < arg_339_1.time_ and arg_339_1.time_ <= var_342_6 + arg_342_0 then
				arg_339_1.talkMaxDuration = 0
				arg_339_1.dialogCg_.alpha = 1

				arg_339_1.dialog_:SetActive(true)
				SetActive(arg_339_1.leftNameGo_, true)

				local var_342_8 = arg_339_1:FormatText(StoryNameCfg[7].name)

				arg_339_1.leftNameTxt_.text = var_342_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_339_1.leftNameTxt_.transform)

				arg_339_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_339_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_339_1:RecordName(arg_339_1.leftNameTxt_.text)
				SetActive(arg_339_1.iconTrs_.gameObject, true)
				arg_339_1.iconController_:SetSelectedState("hero")

				arg_339_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_339_1.callingController_:SetSelectedState("normal")

				arg_339_1.keyicon_.color = Color.New(1, 1, 1)
				arg_339_1.icon_.color = Color.New(1, 1, 1)

				local var_342_9 = arg_339_1:GetWordFromCfg(1107505088)
				local var_342_10 = arg_339_1:FormatText(var_342_9.content)

				arg_339_1.text_.text = var_342_10

				LuaForUtil.ClearLinePrefixSymbol(arg_339_1.text_)

				local var_342_11 = 22
				local var_342_12 = utf8.len(var_342_10)
				local var_342_13 = var_342_11 <= 0 and var_342_7 or var_342_7 * (var_342_12 / var_342_11)

				if var_342_13 > 0 and var_342_7 < var_342_13 then
					arg_339_1.talkMaxDuration = var_342_13

					if var_342_13 + var_342_6 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_13 + var_342_6
					end
				end

				arg_339_1.text_.text = var_342_10
				arg_339_1.typewritter.percent = 0

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(false)
				arg_339_1:RecordContent(arg_339_1.text_.text)
			end

			local var_342_14 = math.max(var_342_7, arg_339_1.talkMaxDuration)

			if var_342_6 <= arg_339_1.time_ and arg_339_1.time_ < var_342_6 + var_342_14 then
				arg_339_1.typewritter.percent = (arg_339_1.time_ - var_342_6) / var_342_14

				arg_339_1.typewritter:SetDirty()
			end

			if arg_339_1.time_ >= var_342_6 + var_342_14 and arg_339_1.time_ < var_342_6 + var_342_14 + arg_342_0 then
				arg_339_1.typewritter.percent = 1

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(true)
			end
		end

		arg_339_1.nodeConfigList_ = {}

		arg_339_1:InitPlayNodeList()
	end,
	Play1107505089 = function(arg_343_0, arg_343_1)
		arg_343_1.time_ = 0
		arg_343_1.frameCnt_ = 0
		arg_343_1.state_ = "playing"
		arg_343_1.curTalkId_ = 1107505089
		arg_343_1.duration_ = 5

		SetActive(arg_343_1.tipsGo_, false)

		function arg_343_1.onSingleLineFinish_()
			arg_343_1.onSingleLineUpdate_ = nil
			arg_343_1.onSingleLineFinish_ = nil
			arg_343_1.state_ = "waiting"
		end

		function arg_343_1.playNext_(arg_345_0)
			if arg_345_0 == 1 then
				arg_343_0:Play1107505090(arg_343_1)
			end
		end

		function arg_343_1.onSingleLineUpdate_(arg_346_0)
			local var_346_0 = 0
			local var_346_1 = 0.5

			if var_346_0 < arg_343_1.time_ and arg_343_1.time_ <= var_346_0 + arg_346_0 then
				arg_343_1.talkMaxDuration = 0
				arg_343_1.dialogCg_.alpha = 1

				arg_343_1.dialog_:SetActive(true)
				SetActive(arg_343_1.leftNameGo_, false)

				arg_343_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_343_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_343_1:RecordName(arg_343_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_343_1.iconTrs_.gameObject, false)
				arg_343_1.callingController_:SetSelectedState("normal")

				local var_346_2 = arg_343_1:GetWordFromCfg(1107505089)
				local var_346_3 = arg_343_1:FormatText(var_346_2.content)

				arg_343_1.text_.text = var_346_3

				LuaForUtil.ClearLinePrefixSymbol(arg_343_1.text_)

				local var_346_4 = 20
				local var_346_5 = utf8.len(var_346_3)
				local var_346_6 = var_346_4 <= 0 and var_346_1 or var_346_1 * (var_346_5 / var_346_4)

				if var_346_6 > 0 and var_346_1 < var_346_6 then
					arg_343_1.talkMaxDuration = var_346_6

					if var_346_6 + var_346_0 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_6 + var_346_0
					end
				end

				arg_343_1.text_.text = var_346_3
				arg_343_1.typewritter.percent = 0

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(false)
				arg_343_1:RecordContent(arg_343_1.text_.text)
			end

			local var_346_7 = math.max(var_346_1, arg_343_1.talkMaxDuration)

			if var_346_0 <= arg_343_1.time_ and arg_343_1.time_ < var_346_0 + var_346_7 then
				arg_343_1.typewritter.percent = (arg_343_1.time_ - var_346_0) / var_346_7

				arg_343_1.typewritter:SetDirty()
			end

			if arg_343_1.time_ >= var_346_0 + var_346_7 and arg_343_1.time_ < var_346_0 + var_346_7 + arg_346_0 then
				arg_343_1.typewritter.percent = 1

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(true)
			end
		end

		arg_343_1.nodeConfigList_ = {}

		arg_343_1:InitPlayNodeList()
	end,
	Play1107505090 = function(arg_347_0, arg_347_1)
		arg_347_1.time_ = 0
		arg_347_1.frameCnt_ = 0
		arg_347_1.state_ = "playing"
		arg_347_1.curTalkId_ = 1107505090
		arg_347_1.duration_ = 5

		SetActive(arg_347_1.tipsGo_, false)

		function arg_347_1.onSingleLineFinish_()
			arg_347_1.onSingleLineUpdate_ = nil
			arg_347_1.onSingleLineFinish_ = nil
			arg_347_1.state_ = "waiting"
		end

		function arg_347_1.playNext_(arg_349_0)
			if arg_349_0 == 1 then
				arg_347_0:Play1107505091(arg_347_1)
			end
		end

		function arg_347_1.onSingleLineUpdate_(arg_350_0)
			local var_350_0 = 0
			local var_350_1 = 0.75

			if var_350_0 < arg_347_1.time_ and arg_347_1.time_ <= var_350_0 + arg_350_0 then
				arg_347_1.talkMaxDuration = 0
				arg_347_1.dialogCg_.alpha = 1

				arg_347_1.dialog_:SetActive(true)
				SetActive(arg_347_1.leftNameGo_, true)

				local var_350_2 = arg_347_1:FormatText(StoryNameCfg[7].name)

				arg_347_1.leftNameTxt_.text = var_350_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_347_1.leftNameTxt_.transform)

				arg_347_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_347_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_347_1:RecordName(arg_347_1.leftNameTxt_.text)
				SetActive(arg_347_1.iconTrs_.gameObject, true)
				arg_347_1.iconController_:SetSelectedState("hero")

				arg_347_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_347_1.callingController_:SetSelectedState("normal")

				arg_347_1.keyicon_.color = Color.New(1, 1, 1)
				arg_347_1.icon_.color = Color.New(1, 1, 1)

				local var_350_3 = arg_347_1:GetWordFromCfg(1107505090)
				local var_350_4 = arg_347_1:FormatText(var_350_3.content)

				arg_347_1.text_.text = var_350_4

				LuaForUtil.ClearLinePrefixSymbol(arg_347_1.text_)

				local var_350_5 = 30
				local var_350_6 = utf8.len(var_350_4)
				local var_350_7 = var_350_5 <= 0 and var_350_1 or var_350_1 * (var_350_6 / var_350_5)

				if var_350_7 > 0 and var_350_1 < var_350_7 then
					arg_347_1.talkMaxDuration = var_350_7

					if var_350_7 + var_350_0 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_7 + var_350_0
					end
				end

				arg_347_1.text_.text = var_350_4
				arg_347_1.typewritter.percent = 0

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(false)
				arg_347_1:RecordContent(arg_347_1.text_.text)
			end

			local var_350_8 = math.max(var_350_1, arg_347_1.talkMaxDuration)

			if var_350_0 <= arg_347_1.time_ and arg_347_1.time_ < var_350_0 + var_350_8 then
				arg_347_1.typewritter.percent = (arg_347_1.time_ - var_350_0) / var_350_8

				arg_347_1.typewritter:SetDirty()
			end

			if arg_347_1.time_ >= var_350_0 + var_350_8 and arg_347_1.time_ < var_350_0 + var_350_8 + arg_350_0 then
				arg_347_1.typewritter.percent = 1

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(true)
			end
		end

		arg_347_1.nodeConfigList_ = {}

		arg_347_1:InitPlayNodeList()
	end,
	Play1107505091 = function(arg_351_0, arg_351_1)
		arg_351_1.time_ = 0
		arg_351_1.frameCnt_ = 0
		arg_351_1.state_ = "playing"
		arg_351_1.curTalkId_ = 1107505091
		arg_351_1.duration_ = 6.1

		SetActive(arg_351_1.tipsGo_, false)

		function arg_351_1.onSingleLineFinish_()
			arg_351_1.onSingleLineUpdate_ = nil
			arg_351_1.onSingleLineFinish_ = nil
			arg_351_1.state_ = "waiting"
		end

		function arg_351_1.playNext_(arg_353_0)
			if arg_353_0 == 1 then
				arg_351_0:Play1107505092(arg_351_1)
			end
		end

		function arg_351_1.onSingleLineUpdate_(arg_354_0)
			local var_354_0 = arg_351_1.actors_["1075ui_actor"]
			local var_354_1 = 0

			if var_354_1 < arg_351_1.time_ and arg_351_1.time_ <= var_354_1 + arg_354_0 and not isNil(var_354_0) and arg_351_1.var_.characterEffect1075ui_actor == nil then
				arg_351_1.var_.characterEffect1075ui_actor = var_354_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_354_2 = 0.200000002980232

			if var_354_1 <= arg_351_1.time_ and arg_351_1.time_ < var_354_1 + var_354_2 and not isNil(var_354_0) then
				local var_354_3 = (arg_351_1.time_ - var_354_1) / var_354_2

				if arg_351_1.var_.characterEffect1075ui_actor and not isNil(var_354_0) then
					arg_351_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_351_1.time_ >= var_354_1 + var_354_2 and arg_351_1.time_ < var_354_1 + var_354_2 + arg_354_0 and not isNil(var_354_0) and arg_351_1.var_.characterEffect1075ui_actor then
				arg_351_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			local var_354_4 = 0
			local var_354_5 = 0.525

			if var_354_4 < arg_351_1.time_ and arg_351_1.time_ <= var_354_4 + arg_354_0 then
				arg_351_1.talkMaxDuration = 0
				arg_351_1.dialogCg_.alpha = 1

				arg_351_1.dialog_:SetActive(true)
				SetActive(arg_351_1.leftNameGo_, true)

				local var_354_6 = arg_351_1:FormatText(StoryNameCfg[381].name)

				arg_351_1.leftNameTxt_.text = var_354_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_351_1.leftNameTxt_.transform)

				arg_351_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_351_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_351_1:RecordName(arg_351_1.leftNameTxt_.text)
				SetActive(arg_351_1.iconTrs_.gameObject, true)
				arg_351_1.iconController_:SetSelectedState("hero")

				arg_351_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1075")

				arg_351_1.callingController_:SetSelectedState("normal")

				arg_351_1.keyicon_.color = Color.New(1, 1, 1)
				arg_351_1.icon_.color = Color.New(1, 1, 1)

				local var_354_7 = arg_351_1:GetWordFromCfg(1107505091)
				local var_354_8 = arg_351_1:FormatText(var_354_7.content)

				arg_351_1.text_.text = var_354_8

				LuaForUtil.ClearLinePrefixSymbol(arg_351_1.text_)

				local var_354_9 = 21
				local var_354_10 = utf8.len(var_354_8)
				local var_354_11 = var_354_9 <= 0 and var_354_5 or var_354_5 * (var_354_10 / var_354_9)

				if var_354_11 > 0 and var_354_5 < var_354_11 then
					arg_351_1.talkMaxDuration = var_354_11

					if var_354_11 + var_354_4 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_11 + var_354_4
					end
				end

				arg_351_1.text_.text = var_354_8
				arg_351_1.typewritter.percent = 0

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107505", "1107505091", "story_v_side_new_1107505.awb") ~= 0 then
					local var_354_12 = manager.audio:GetVoiceLength("story_v_side_new_1107505", "1107505091", "story_v_side_new_1107505.awb") / 1000

					if var_354_12 + var_354_4 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_12 + var_354_4
					end

					if var_354_7.prefab_name ~= "" and arg_351_1.actors_[var_354_7.prefab_name] ~= nil then
						local var_354_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_351_1.actors_[var_354_7.prefab_name].transform, "story_v_side_new_1107505", "1107505091", "story_v_side_new_1107505.awb")

						arg_351_1:RecordAudio("1107505091", var_354_13)
						arg_351_1:RecordAudio("1107505091", var_354_13)
					else
						arg_351_1:AudioAction("play", "voice", "story_v_side_new_1107505", "1107505091", "story_v_side_new_1107505.awb")
					end

					arg_351_1:RecordHistoryTalkVoice("story_v_side_new_1107505", "1107505091", "story_v_side_new_1107505.awb")
				end

				arg_351_1:RecordContent(arg_351_1.text_.text)
			end

			local var_354_14 = math.max(var_354_5, arg_351_1.talkMaxDuration)

			if var_354_4 <= arg_351_1.time_ and arg_351_1.time_ < var_354_4 + var_354_14 then
				arg_351_1.typewritter.percent = (arg_351_1.time_ - var_354_4) / var_354_14

				arg_351_1.typewritter:SetDirty()
			end

			if arg_351_1.time_ >= var_354_4 + var_354_14 and arg_351_1.time_ < var_354_4 + var_354_14 + arg_354_0 then
				arg_351_1.typewritter.percent = 1

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(true)
			end
		end

		arg_351_1.nodeConfigList_ = {}

		arg_351_1:InitPlayNodeList()
	end,
	Play1107505092 = function(arg_355_0, arg_355_1)
		arg_355_1.time_ = 0
		arg_355_1.frameCnt_ = 0
		arg_355_1.state_ = "playing"
		arg_355_1.curTalkId_ = 1107505092
		arg_355_1.duration_ = 5

		SetActive(arg_355_1.tipsGo_, false)

		function arg_355_1.onSingleLineFinish_()
			arg_355_1.onSingleLineUpdate_ = nil
			arg_355_1.onSingleLineFinish_ = nil
			arg_355_1.state_ = "waiting"
		end

		function arg_355_1.playNext_(arg_357_0)
			if arg_357_0 == 1 then
				arg_355_0:Play1107505093(arg_355_1)
			end
		end

		function arg_355_1.onSingleLineUpdate_(arg_358_0)
			local var_358_0 = arg_355_1.actors_["1075ui_actor"]
			local var_358_1 = 0

			if var_358_1 < arg_355_1.time_ and arg_355_1.time_ <= var_358_1 + arg_358_0 and not isNil(var_358_0) and arg_355_1.var_.characterEffect1075ui_actor == nil then
				arg_355_1.var_.characterEffect1075ui_actor = var_358_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_358_2 = 0.200000002980232

			if var_358_1 <= arg_355_1.time_ and arg_355_1.time_ < var_358_1 + var_358_2 and not isNil(var_358_0) then
				local var_358_3 = (arg_355_1.time_ - var_358_1) / var_358_2

				if arg_355_1.var_.characterEffect1075ui_actor and not isNil(var_358_0) then
					local var_358_4 = Mathf.Lerp(0, 0.5, var_358_3)

					arg_355_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_355_1.var_.characterEffect1075ui_actor.fillRatio = var_358_4
				end
			end

			if arg_355_1.time_ >= var_358_1 + var_358_2 and arg_355_1.time_ < var_358_1 + var_358_2 + arg_358_0 and not isNil(var_358_0) and arg_355_1.var_.characterEffect1075ui_actor then
				local var_358_5 = 0.5

				arg_355_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_355_1.var_.characterEffect1075ui_actor.fillRatio = var_358_5
			end

			local var_358_6 = 0
			local var_358_7 = 0.8

			if var_358_6 < arg_355_1.time_ and arg_355_1.time_ <= var_358_6 + arg_358_0 then
				arg_355_1.talkMaxDuration = 0
				arg_355_1.dialogCg_.alpha = 1

				arg_355_1.dialog_:SetActive(true)
				SetActive(arg_355_1.leftNameGo_, false)

				arg_355_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_355_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_355_1:RecordName(arg_355_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_355_1.iconTrs_.gameObject, false)
				arg_355_1.callingController_:SetSelectedState("normal")

				local var_358_8 = arg_355_1:GetWordFromCfg(1107505092)
				local var_358_9 = arg_355_1:FormatText(var_358_8.content)

				arg_355_1.text_.text = var_358_9

				LuaForUtil.ClearLinePrefixSymbol(arg_355_1.text_)

				local var_358_10 = 32
				local var_358_11 = utf8.len(var_358_9)
				local var_358_12 = var_358_10 <= 0 and var_358_7 or var_358_7 * (var_358_11 / var_358_10)

				if var_358_12 > 0 and var_358_7 < var_358_12 then
					arg_355_1.talkMaxDuration = var_358_12

					if var_358_12 + var_358_6 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_12 + var_358_6
					end
				end

				arg_355_1.text_.text = var_358_9
				arg_355_1.typewritter.percent = 0

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(false)
				arg_355_1:RecordContent(arg_355_1.text_.text)
			end

			local var_358_13 = math.max(var_358_7, arg_355_1.talkMaxDuration)

			if var_358_6 <= arg_355_1.time_ and arg_355_1.time_ < var_358_6 + var_358_13 then
				arg_355_1.typewritter.percent = (arg_355_1.time_ - var_358_6) / var_358_13

				arg_355_1.typewritter:SetDirty()
			end

			if arg_355_1.time_ >= var_358_6 + var_358_13 and arg_355_1.time_ < var_358_6 + var_358_13 + arg_358_0 then
				arg_355_1.typewritter.percent = 1

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(true)
			end
		end

		arg_355_1.nodeConfigList_ = {}

		arg_355_1:InitPlayNodeList()
	end,
	Play1107505093 = function(arg_359_0, arg_359_1)
		arg_359_1.time_ = 0
		arg_359_1.frameCnt_ = 0
		arg_359_1.state_ = "playing"
		arg_359_1.curTalkId_ = 1107505093
		arg_359_1.duration_ = 5

		SetActive(arg_359_1.tipsGo_, false)

		function arg_359_1.onSingleLineFinish_()
			arg_359_1.onSingleLineUpdate_ = nil
			arg_359_1.onSingleLineFinish_ = nil
			arg_359_1.state_ = "waiting"
		end

		function arg_359_1.playNext_(arg_361_0)
			if arg_361_0 == 1 then
				arg_359_0:Play1107505094(arg_359_1)
			end
		end

		function arg_359_1.onSingleLineUpdate_(arg_362_0)
			local var_362_0 = 0
			local var_362_1 = 0.725

			if var_362_0 < arg_359_1.time_ and arg_359_1.time_ <= var_362_0 + arg_362_0 then
				arg_359_1.talkMaxDuration = 0
				arg_359_1.dialogCg_.alpha = 1

				arg_359_1.dialog_:SetActive(true)
				SetActive(arg_359_1.leftNameGo_, false)

				arg_359_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_359_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_359_1:RecordName(arg_359_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_359_1.iconTrs_.gameObject, false)
				arg_359_1.callingController_:SetSelectedState("normal")

				local var_362_2 = arg_359_1:GetWordFromCfg(1107505093)
				local var_362_3 = arg_359_1:FormatText(var_362_2.content)

				arg_359_1.text_.text = var_362_3

				LuaForUtil.ClearLinePrefixSymbol(arg_359_1.text_)

				local var_362_4 = 29
				local var_362_5 = utf8.len(var_362_3)
				local var_362_6 = var_362_4 <= 0 and var_362_1 or var_362_1 * (var_362_5 / var_362_4)

				if var_362_6 > 0 and var_362_1 < var_362_6 then
					arg_359_1.talkMaxDuration = var_362_6

					if var_362_6 + var_362_0 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_6 + var_362_0
					end
				end

				arg_359_1.text_.text = var_362_3
				arg_359_1.typewritter.percent = 0

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(false)
				arg_359_1:RecordContent(arg_359_1.text_.text)
			end

			local var_362_7 = math.max(var_362_1, arg_359_1.talkMaxDuration)

			if var_362_0 <= arg_359_1.time_ and arg_359_1.time_ < var_362_0 + var_362_7 then
				arg_359_1.typewritter.percent = (arg_359_1.time_ - var_362_0) / var_362_7

				arg_359_1.typewritter:SetDirty()
			end

			if arg_359_1.time_ >= var_362_0 + var_362_7 and arg_359_1.time_ < var_362_0 + var_362_7 + arg_362_0 then
				arg_359_1.typewritter.percent = 1

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(true)
			end
		end

		arg_359_1.nodeConfigList_ = {}

		arg_359_1:InitPlayNodeList()
	end,
	Play1107505094 = function(arg_363_0, arg_363_1)
		arg_363_1.time_ = 0
		arg_363_1.frameCnt_ = 0
		arg_363_1.state_ = "playing"
		arg_363_1.curTalkId_ = 1107505094
		arg_363_1.duration_ = 5

		SetActive(arg_363_1.tipsGo_, false)

		function arg_363_1.onSingleLineFinish_()
			arg_363_1.onSingleLineUpdate_ = nil
			arg_363_1.onSingleLineFinish_ = nil
			arg_363_1.state_ = "waiting"
		end

		function arg_363_1.playNext_(arg_365_0)
			if arg_365_0 == 1 then
				arg_363_0:Play1107505095(arg_363_1)
			end
		end

		function arg_363_1.onSingleLineUpdate_(arg_366_0)
			local var_366_0 = 0
			local var_366_1 = 0.5

			if var_366_0 < arg_363_1.time_ and arg_363_1.time_ <= var_366_0 + arg_366_0 then
				arg_363_1.talkMaxDuration = 0
				arg_363_1.dialogCg_.alpha = 1

				arg_363_1.dialog_:SetActive(true)
				SetActive(arg_363_1.leftNameGo_, true)

				local var_366_2 = arg_363_1:FormatText(StoryNameCfg[7].name)

				arg_363_1.leftNameTxt_.text = var_366_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_363_1.leftNameTxt_.transform)

				arg_363_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_363_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_363_1:RecordName(arg_363_1.leftNameTxt_.text)
				SetActive(arg_363_1.iconTrs_.gameObject, true)
				arg_363_1.iconController_:SetSelectedState("hero")

				arg_363_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_363_1.callingController_:SetSelectedState("normal")

				arg_363_1.keyicon_.color = Color.New(1, 1, 1)
				arg_363_1.icon_.color = Color.New(1, 1, 1)

				local var_366_3 = arg_363_1:GetWordFromCfg(1107505094)
				local var_366_4 = arg_363_1:FormatText(var_366_3.content)

				arg_363_1.text_.text = var_366_4

				LuaForUtil.ClearLinePrefixSymbol(arg_363_1.text_)

				local var_366_5 = 20
				local var_366_6 = utf8.len(var_366_4)
				local var_366_7 = var_366_5 <= 0 and var_366_1 or var_366_1 * (var_366_6 / var_366_5)

				if var_366_7 > 0 and var_366_1 < var_366_7 then
					arg_363_1.talkMaxDuration = var_366_7

					if var_366_7 + var_366_0 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_7 + var_366_0
					end
				end

				arg_363_1.text_.text = var_366_4
				arg_363_1.typewritter.percent = 0

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(false)
				arg_363_1:RecordContent(arg_363_1.text_.text)
			end

			local var_366_8 = math.max(var_366_1, arg_363_1.talkMaxDuration)

			if var_366_0 <= arg_363_1.time_ and arg_363_1.time_ < var_366_0 + var_366_8 then
				arg_363_1.typewritter.percent = (arg_363_1.time_ - var_366_0) / var_366_8

				arg_363_1.typewritter:SetDirty()
			end

			if arg_363_1.time_ >= var_366_0 + var_366_8 and arg_363_1.time_ < var_366_0 + var_366_8 + arg_366_0 then
				arg_363_1.typewritter.percent = 1

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(true)
			end
		end

		arg_363_1.nodeConfigList_ = {}

		arg_363_1:InitPlayNodeList()
	end,
	Play1107505095 = function(arg_367_0, arg_367_1)
		arg_367_1.time_ = 0
		arg_367_1.frameCnt_ = 0
		arg_367_1.state_ = "playing"
		arg_367_1.curTalkId_ = 1107505095
		arg_367_1.duration_ = 5

		SetActive(arg_367_1.tipsGo_, false)

		function arg_367_1.onSingleLineFinish_()
			arg_367_1.onSingleLineUpdate_ = nil
			arg_367_1.onSingleLineFinish_ = nil
			arg_367_1.state_ = "waiting"
		end

		function arg_367_1.playNext_(arg_369_0)
			if arg_369_0 == 1 then
				arg_367_0:Play1107505096(arg_367_1)
			end
		end

		function arg_367_1.onSingleLineUpdate_(arg_370_0)
			local var_370_0 = 0
			local var_370_1 = 0.4

			if var_370_0 < arg_367_1.time_ and arg_367_1.time_ <= var_370_0 + arg_370_0 then
				arg_367_1.talkMaxDuration = 0
				arg_367_1.dialogCg_.alpha = 1

				arg_367_1.dialog_:SetActive(true)
				SetActive(arg_367_1.leftNameGo_, true)

				local var_370_2 = arg_367_1:FormatText(StoryNameCfg[7].name)

				arg_367_1.leftNameTxt_.text = var_370_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_367_1.leftNameTxt_.transform)

				arg_367_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_367_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_367_1:RecordName(arg_367_1.leftNameTxt_.text)
				SetActive(arg_367_1.iconTrs_.gameObject, true)
				arg_367_1.iconController_:SetSelectedState("hero")

				arg_367_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_367_1.callingController_:SetSelectedState("normal")

				arg_367_1.keyicon_.color = Color.New(1, 1, 1)
				arg_367_1.icon_.color = Color.New(1, 1, 1)

				local var_370_3 = arg_367_1:GetWordFromCfg(1107505095)
				local var_370_4 = arg_367_1:FormatText(var_370_3.content)

				arg_367_1.text_.text = var_370_4

				LuaForUtil.ClearLinePrefixSymbol(arg_367_1.text_)

				local var_370_5 = 16
				local var_370_6 = utf8.len(var_370_4)
				local var_370_7 = var_370_5 <= 0 and var_370_1 or var_370_1 * (var_370_6 / var_370_5)

				if var_370_7 > 0 and var_370_1 < var_370_7 then
					arg_367_1.talkMaxDuration = var_370_7

					if var_370_7 + var_370_0 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_7 + var_370_0
					end
				end

				arg_367_1.text_.text = var_370_4
				arg_367_1.typewritter.percent = 0

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(false)
				arg_367_1:RecordContent(arg_367_1.text_.text)
			end

			local var_370_8 = math.max(var_370_1, arg_367_1.talkMaxDuration)

			if var_370_0 <= arg_367_1.time_ and arg_367_1.time_ < var_370_0 + var_370_8 then
				arg_367_1.typewritter.percent = (arg_367_1.time_ - var_370_0) / var_370_8

				arg_367_1.typewritter:SetDirty()
			end

			if arg_367_1.time_ >= var_370_0 + var_370_8 and arg_367_1.time_ < var_370_0 + var_370_8 + arg_370_0 then
				arg_367_1.typewritter.percent = 1

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(true)
			end
		end

		arg_367_1.nodeConfigList_ = {}

		arg_367_1:InitPlayNodeList()
	end,
	Play1107505096 = function(arg_371_0, arg_371_1)
		arg_371_1.time_ = 0
		arg_371_1.frameCnt_ = 0
		arg_371_1.state_ = "playing"
		arg_371_1.curTalkId_ = 1107505096
		arg_371_1.duration_ = 5

		SetActive(arg_371_1.tipsGo_, false)

		function arg_371_1.onSingleLineFinish_()
			arg_371_1.onSingleLineUpdate_ = nil
			arg_371_1.onSingleLineFinish_ = nil
			arg_371_1.state_ = "waiting"
		end

		function arg_371_1.playNext_(arg_373_0)
			if arg_373_0 == 1 then
				arg_371_0:Play1107505097(arg_371_1)
			end
		end

		function arg_371_1.onSingleLineUpdate_(arg_374_0)
			local var_374_0 = 0
			local var_374_1 = 1.125

			if var_374_0 < arg_371_1.time_ and arg_371_1.time_ <= var_374_0 + arg_374_0 then
				arg_371_1.talkMaxDuration = 0
				arg_371_1.dialogCg_.alpha = 1

				arg_371_1.dialog_:SetActive(true)
				SetActive(arg_371_1.leftNameGo_, false)

				arg_371_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_371_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_371_1:RecordName(arg_371_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_371_1.iconTrs_.gameObject, false)
				arg_371_1.callingController_:SetSelectedState("normal")

				local var_374_2 = arg_371_1:GetWordFromCfg(1107505096)
				local var_374_3 = arg_371_1:FormatText(var_374_2.content)

				arg_371_1.text_.text = var_374_3

				LuaForUtil.ClearLinePrefixSymbol(arg_371_1.text_)

				local var_374_4 = 45
				local var_374_5 = utf8.len(var_374_3)
				local var_374_6 = var_374_4 <= 0 and var_374_1 or var_374_1 * (var_374_5 / var_374_4)

				if var_374_6 > 0 and var_374_1 < var_374_6 then
					arg_371_1.talkMaxDuration = var_374_6

					if var_374_6 + var_374_0 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_6 + var_374_0
					end
				end

				arg_371_1.text_.text = var_374_3
				arg_371_1.typewritter.percent = 0

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(false)
				arg_371_1:RecordContent(arg_371_1.text_.text)
			end

			local var_374_7 = math.max(var_374_1, arg_371_1.talkMaxDuration)

			if var_374_0 <= arg_371_1.time_ and arg_371_1.time_ < var_374_0 + var_374_7 then
				arg_371_1.typewritter.percent = (arg_371_1.time_ - var_374_0) / var_374_7

				arg_371_1.typewritter:SetDirty()
			end

			if arg_371_1.time_ >= var_374_0 + var_374_7 and arg_371_1.time_ < var_374_0 + var_374_7 + arg_374_0 then
				arg_371_1.typewritter.percent = 1

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(true)
			end
		end

		arg_371_1.nodeConfigList_ = {}

		arg_371_1:InitPlayNodeList()
	end,
	Play1107505097 = function(arg_375_0, arg_375_1)
		arg_375_1.time_ = 0
		arg_375_1.frameCnt_ = 0
		arg_375_1.state_ = "playing"
		arg_375_1.curTalkId_ = 1107505097
		arg_375_1.duration_ = 1.17

		SetActive(arg_375_1.tipsGo_, false)

		function arg_375_1.onSingleLineFinish_()
			arg_375_1.onSingleLineUpdate_ = nil
			arg_375_1.onSingleLineFinish_ = nil
			arg_375_1.state_ = "waiting"
		end

		function arg_375_1.playNext_(arg_377_0)
			if arg_377_0 == 1 then
				arg_375_0:Play1107505098(arg_375_1)
			end
		end

		function arg_375_1.onSingleLineUpdate_(arg_378_0)
			local var_378_0 = 0
			local var_378_1 = 0.1

			if var_378_0 < arg_375_1.time_ and arg_375_1.time_ <= var_378_0 + arg_378_0 then
				arg_375_1.talkMaxDuration = 0
				arg_375_1.dialogCg_.alpha = 1

				arg_375_1.dialog_:SetActive(true)
				SetActive(arg_375_1.leftNameGo_, true)

				local var_378_2 = arg_375_1:FormatText(StoryNameCfg[381].name)

				arg_375_1.leftNameTxt_.text = var_378_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_375_1.leftNameTxt_.transform)

				arg_375_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_375_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_375_1:RecordName(arg_375_1.leftNameTxt_.text)
				SetActive(arg_375_1.iconTrs_.gameObject, true)
				arg_375_1.iconController_:SetSelectedState("hero")

				arg_375_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1075")

				arg_375_1.callingController_:SetSelectedState("normal")

				arg_375_1.keyicon_.color = Color.New(1, 1, 1)
				arg_375_1.icon_.color = Color.New(1, 1, 1)

				local var_378_3 = arg_375_1:GetWordFromCfg(1107505097)
				local var_378_4 = arg_375_1:FormatText(var_378_3.content)

				arg_375_1.text_.text = var_378_4

				LuaForUtil.ClearLinePrefixSymbol(arg_375_1.text_)

				local var_378_5 = 4
				local var_378_6 = utf8.len(var_378_4)
				local var_378_7 = var_378_5 <= 0 and var_378_1 or var_378_1 * (var_378_6 / var_378_5)

				if var_378_7 > 0 and var_378_1 < var_378_7 then
					arg_375_1.talkMaxDuration = var_378_7

					if var_378_7 + var_378_0 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_7 + var_378_0
					end
				end

				arg_375_1.text_.text = var_378_4
				arg_375_1.typewritter.percent = 0

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107505", "1107505097", "story_v_side_new_1107505.awb") ~= 0 then
					local var_378_8 = manager.audio:GetVoiceLength("story_v_side_new_1107505", "1107505097", "story_v_side_new_1107505.awb") / 1000

					if var_378_8 + var_378_0 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_8 + var_378_0
					end

					if var_378_3.prefab_name ~= "" and arg_375_1.actors_[var_378_3.prefab_name] ~= nil then
						local var_378_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_375_1.actors_[var_378_3.prefab_name].transform, "story_v_side_new_1107505", "1107505097", "story_v_side_new_1107505.awb")

						arg_375_1:RecordAudio("1107505097", var_378_9)
						arg_375_1:RecordAudio("1107505097", var_378_9)
					else
						arg_375_1:AudioAction("play", "voice", "story_v_side_new_1107505", "1107505097", "story_v_side_new_1107505.awb")
					end

					arg_375_1:RecordHistoryTalkVoice("story_v_side_new_1107505", "1107505097", "story_v_side_new_1107505.awb")
				end

				arg_375_1:RecordContent(arg_375_1.text_.text)
			end

			local var_378_10 = math.max(var_378_1, arg_375_1.talkMaxDuration)

			if var_378_0 <= arg_375_1.time_ and arg_375_1.time_ < var_378_0 + var_378_10 then
				arg_375_1.typewritter.percent = (arg_375_1.time_ - var_378_0) / var_378_10

				arg_375_1.typewritter:SetDirty()
			end

			if arg_375_1.time_ >= var_378_0 + var_378_10 and arg_375_1.time_ < var_378_0 + var_378_10 + arg_378_0 then
				arg_375_1.typewritter.percent = 1

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(true)
			end
		end

		arg_375_1.nodeConfigList_ = {}

		arg_375_1:InitPlayNodeList()
	end,
	Play1107505098 = function(arg_379_0, arg_379_1)
		arg_379_1.time_ = 0
		arg_379_1.frameCnt_ = 0
		arg_379_1.state_ = "playing"
		arg_379_1.curTalkId_ = 1107505098
		arg_379_1.duration_ = 5

		SetActive(arg_379_1.tipsGo_, false)

		function arg_379_1.onSingleLineFinish_()
			arg_379_1.onSingleLineUpdate_ = nil
			arg_379_1.onSingleLineFinish_ = nil
			arg_379_1.state_ = "waiting"
		end

		function arg_379_1.playNext_(arg_381_0)
			if arg_381_0 == 1 then
				arg_379_0:Play1107505099(arg_379_1)
			end
		end

		function arg_379_1.onSingleLineUpdate_(arg_382_0)
			local var_382_0 = 0
			local var_382_1 = 0.175

			if var_382_0 < arg_379_1.time_ and arg_379_1.time_ <= var_382_0 + arg_382_0 then
				arg_379_1.talkMaxDuration = 0
				arg_379_1.dialogCg_.alpha = 1

				arg_379_1.dialog_:SetActive(true)
				SetActive(arg_379_1.leftNameGo_, true)

				local var_382_2 = arg_379_1:FormatText(StoryNameCfg[7].name)

				arg_379_1.leftNameTxt_.text = var_382_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_379_1.leftNameTxt_.transform)

				arg_379_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_379_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_379_1:RecordName(arg_379_1.leftNameTxt_.text)
				SetActive(arg_379_1.iconTrs_.gameObject, true)
				arg_379_1.iconController_:SetSelectedState("hero")

				arg_379_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_379_1.callingController_:SetSelectedState("normal")

				arg_379_1.keyicon_.color = Color.New(1, 1, 1)
				arg_379_1.icon_.color = Color.New(1, 1, 1)

				local var_382_3 = arg_379_1:GetWordFromCfg(1107505098)
				local var_382_4 = arg_379_1:FormatText(var_382_3.content)

				arg_379_1.text_.text = var_382_4

				LuaForUtil.ClearLinePrefixSymbol(arg_379_1.text_)

				local var_382_5 = 7
				local var_382_6 = utf8.len(var_382_4)
				local var_382_7 = var_382_5 <= 0 and var_382_1 or var_382_1 * (var_382_6 / var_382_5)

				if var_382_7 > 0 and var_382_1 < var_382_7 then
					arg_379_1.talkMaxDuration = var_382_7

					if var_382_7 + var_382_0 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_7 + var_382_0
					end
				end

				arg_379_1.text_.text = var_382_4
				arg_379_1.typewritter.percent = 0

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(false)
				arg_379_1:RecordContent(arg_379_1.text_.text)
			end

			local var_382_8 = math.max(var_382_1, arg_379_1.talkMaxDuration)

			if var_382_0 <= arg_379_1.time_ and arg_379_1.time_ < var_382_0 + var_382_8 then
				arg_379_1.typewritter.percent = (arg_379_1.time_ - var_382_0) / var_382_8

				arg_379_1.typewritter:SetDirty()
			end

			if arg_379_1.time_ >= var_382_0 + var_382_8 and arg_379_1.time_ < var_382_0 + var_382_8 + arg_382_0 then
				arg_379_1.typewritter.percent = 1

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(true)
			end
		end

		arg_379_1.nodeConfigList_ = {}

		arg_379_1:InitPlayNodeList()
	end,
	Play1107505099 = function(arg_383_0, arg_383_1)
		arg_383_1.time_ = 0
		arg_383_1.frameCnt_ = 0
		arg_383_1.state_ = "playing"
		arg_383_1.curTalkId_ = 1107505099
		arg_383_1.duration_ = 11.2

		SetActive(arg_383_1.tipsGo_, false)

		function arg_383_1.onSingleLineFinish_()
			arg_383_1.onSingleLineUpdate_ = nil
			arg_383_1.onSingleLineFinish_ = nil
			arg_383_1.state_ = "waiting"
		end

		function arg_383_1.playNext_(arg_385_0)
			if arg_385_0 == 1 then
				arg_383_0:Play1107505100(arg_383_1)
			end
		end

		function arg_383_1.onSingleLineUpdate_(arg_386_0)
			local var_386_0 = "ST39"

			if arg_383_1.bgs_[var_386_0] == nil then
				local var_386_1 = Object.Instantiate(arg_383_1.paintGo_)

				var_386_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_386_0)
				var_386_1.name = var_386_0
				var_386_1.transform.parent = arg_383_1.stage_.transform
				var_386_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_383_1.bgs_[var_386_0] = var_386_1
			end

			local var_386_2 = 3

			if var_386_2 < arg_383_1.time_ and arg_383_1.time_ <= var_386_2 + arg_386_0 then
				local var_386_3 = manager.ui.mainCamera.transform.localPosition
				local var_386_4 = Vector3.New(0, 0, 10) + Vector3.New(var_386_3.x, var_386_3.y, 0)
				local var_386_5 = arg_383_1.bgs_.ST39

				var_386_5.transform.localPosition = var_386_4
				var_386_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_386_6 = var_386_5:GetComponent("SpriteRenderer")

				if var_386_6 and var_386_6.sprite then
					local var_386_7 = (var_386_5.transform.localPosition - var_386_3).z
					local var_386_8 = manager.ui.mainCameraCom_
					local var_386_9 = 2 * var_386_7 * Mathf.Tan(var_386_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_386_10 = var_386_9 * var_386_8.aspect
					local var_386_11 = var_386_6.sprite.bounds.size.x
					local var_386_12 = var_386_6.sprite.bounds.size.y
					local var_386_13 = var_386_10 / var_386_11
					local var_386_14 = var_386_9 / var_386_12
					local var_386_15 = var_386_14 < var_386_13 and var_386_13 or var_386_14

					var_386_5.transform.localScale = Vector3.New(var_386_15, var_386_15, 0)
				end

				for iter_386_0, iter_386_1 in pairs(arg_383_1.bgs_) do
					if iter_386_0 ~= "ST39" then
						iter_386_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_386_16 = 6.00000000298023

			if var_386_16 < arg_383_1.time_ and arg_383_1.time_ <= var_386_16 + arg_386_0 then
				arg_383_1.allBtn_.enabled = false
			end

			local var_386_17 = 0.3

			if arg_383_1.time_ >= var_386_16 + var_386_17 and arg_383_1.time_ < var_386_16 + var_386_17 + arg_386_0 then
				arg_383_1.allBtn_.enabled = true
			end

			local var_386_18 = 0

			if var_386_18 < arg_383_1.time_ and arg_383_1.time_ <= var_386_18 + arg_386_0 then
				arg_383_1.mask_.enabled = true
				arg_383_1.mask_.raycastTarget = true

				arg_383_1:SetGaussion(false)
			end

			local var_386_19 = 3

			if var_386_18 <= arg_383_1.time_ and arg_383_1.time_ < var_386_18 + var_386_19 then
				local var_386_20 = (arg_383_1.time_ - var_386_18) / var_386_19
				local var_386_21 = Color.New(0, 0, 0)

				var_386_21.a = Mathf.Lerp(0, 1, var_386_20)
				arg_383_1.mask_.color = var_386_21
			end

			if arg_383_1.time_ >= var_386_18 + var_386_19 and arg_383_1.time_ < var_386_18 + var_386_19 + arg_386_0 then
				local var_386_22 = Color.New(0, 0, 0)

				var_386_22.a = 1
				arg_383_1.mask_.color = var_386_22
			end

			local var_386_23 = 3

			if var_386_23 < arg_383_1.time_ and arg_383_1.time_ <= var_386_23 + arg_386_0 then
				arg_383_1.mask_.enabled = true
				arg_383_1.mask_.raycastTarget = true

				arg_383_1:SetGaussion(false)
			end

			local var_386_24 = 3

			if var_386_23 <= arg_383_1.time_ and arg_383_1.time_ < var_386_23 + var_386_24 then
				local var_386_25 = (arg_383_1.time_ - var_386_23) / var_386_24
				local var_386_26 = Color.New(0, 0, 0)

				var_386_26.a = Mathf.Lerp(1, 0, var_386_25)
				arg_383_1.mask_.color = var_386_26
			end

			if arg_383_1.time_ >= var_386_23 + var_386_24 and arg_383_1.time_ < var_386_23 + var_386_24 + arg_386_0 then
				local var_386_27 = Color.New(0, 0, 0)
				local var_386_28 = 0

				arg_383_1.mask_.enabled = false
				var_386_27.a = var_386_28
				arg_383_1.mask_.color = var_386_27
			end

			local var_386_29 = arg_383_1.actors_["1075ui_actor"]
			local var_386_30 = 5.8

			if var_386_30 < arg_383_1.time_ and arg_383_1.time_ <= var_386_30 + arg_386_0 and not isNil(var_386_29) and arg_383_1.var_.characterEffect1075ui_actor == nil then
				arg_383_1.var_.characterEffect1075ui_actor = var_386_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_386_31 = 0.200000002980232

			if var_386_30 <= arg_383_1.time_ and arg_383_1.time_ < var_386_30 + var_386_31 and not isNil(var_386_29) then
				local var_386_32 = (arg_383_1.time_ - var_386_30) / var_386_31

				if arg_383_1.var_.characterEffect1075ui_actor and not isNil(var_386_29) then
					arg_383_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_383_1.time_ >= var_386_30 + var_386_31 and arg_383_1.time_ < var_386_30 + var_386_31 + arg_386_0 and not isNil(var_386_29) and arg_383_1.var_.characterEffect1075ui_actor then
				arg_383_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			local var_386_33 = 5.8

			if var_386_33 < arg_383_1.time_ and arg_383_1.time_ <= var_386_33 + arg_386_0 then
				arg_383_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075action/1075action1_1")
			end

			local var_386_34 = 5.8

			if var_386_34 < arg_383_1.time_ and arg_383_1.time_ <= var_386_34 + arg_386_0 then
				arg_383_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_nanguoC", "EmotionTimelineAnimator")
			end

			local var_386_35 = arg_383_1.actors_["1075ui_actor"].transform
			local var_386_36 = 5.8

			if var_386_36 < arg_383_1.time_ and arg_383_1.time_ <= var_386_36 + arg_386_0 then
				arg_383_1.var_.moveOldPos1075ui_actor = var_386_35.localPosition

				local var_386_37 = GameObjectTools.GetOrAddComponent(var_386_35.gameObject, typeof(DynamicBoneHelper))

				if var_386_37 then
					var_386_37:EnableDynamicBone(false)
				end
			end

			local var_386_38 = 0.001

			if var_386_36 <= arg_383_1.time_ and arg_383_1.time_ < var_386_36 + var_386_38 then
				local var_386_39 = (arg_383_1.time_ - var_386_36) / var_386_38
				local var_386_40 = Vector3.New(0, -1.055, -6.16)

				var_386_35.localPosition = Vector3.Lerp(arg_383_1.var_.moveOldPos1075ui_actor, var_386_40, var_386_39)

				local var_386_41 = manager.ui.mainCamera.transform.position - var_386_35.position

				var_386_35.forward = Vector3.New(var_386_41.x, var_386_41.y, var_386_41.z)

				local var_386_42 = var_386_35.localEulerAngles

				var_386_42.z = 0
				var_386_42.x = 0
				var_386_35.localEulerAngles = var_386_42
			end

			if arg_383_1.time_ >= var_386_36 + var_386_38 and arg_383_1.time_ < var_386_36 + var_386_38 + arg_386_0 then
				var_386_35.localPosition = Vector3.New(0, -1.055, -6.16)

				local var_386_43 = manager.ui.mainCamera.transform.position - var_386_35.position

				var_386_35.forward = Vector3.New(var_386_43.x, var_386_43.y, var_386_43.z)

				local var_386_44 = var_386_35.localEulerAngles

				var_386_44.z = 0
				var_386_44.x = 0
				var_386_35.localEulerAngles = var_386_44

				local var_386_45 = GameObjectTools.GetOrAddComponent(var_386_35.gameObject, typeof(DynamicBoneHelper))

				if var_386_45 then
					var_386_45:EnableDynamicBone(true)
				end
			end

			local var_386_46 = "ST39_blur"

			if arg_383_1.bgs_[var_386_46] == nil then
				local var_386_47 = Object.Instantiate(arg_383_1.blurPaintGo_)
				local var_386_48 = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_386_46)

				var_386_47:GetComponent("SpriteRenderer").sprite = var_386_48
				var_386_47.name = var_386_46
				var_386_47.transform.parent = arg_383_1.stage_.transform
				var_386_47.transform.localPosition = Vector3.New(0, 100, 0)
				arg_383_1.bgs_[var_386_46] = var_386_47
			end

			local var_386_49 = 3
			local var_386_50 = arg_383_1.bgs_[var_386_46]

			if var_386_49 < arg_383_1.time_ and arg_383_1.time_ <= var_386_49 + arg_386_0 then
				local var_386_51 = manager.ui.mainCamera.transform.localPosition
				local var_386_52 = Vector3.New(0, 0, 10) + Vector3.New(var_386_51.x, var_386_51.y, 0)

				var_386_50.transform.localPosition = var_386_52
				var_386_50.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_386_53 = var_386_50:GetComponent("SpriteRenderer")

				if var_386_53 and var_386_53.sprite then
					local var_386_54 = (var_386_50.transform.localPosition - var_386_51).z
					local var_386_55 = manager.ui.mainCameraCom_
					local var_386_56 = 2 * var_386_54 * Mathf.Tan(var_386_55.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_386_57 = var_386_56 * var_386_55.aspect
					local var_386_58 = var_386_53.sprite.bounds.size.x
					local var_386_59 = var_386_53.sprite.bounds.size.y
					local var_386_60 = var_386_57 / var_386_58
					local var_386_61 = var_386_56 / var_386_59
					local var_386_62 = var_386_61 < var_386_60 and var_386_60 or var_386_61

					var_386_50.transform.localScale = Vector3.New(var_386_62, var_386_62, 0)
				end
			end

			local var_386_63 = 1

			if var_386_49 <= arg_383_1.time_ and arg_383_1.time_ < var_386_49 + var_386_63 then
				local var_386_64 = (arg_383_1.time_ - var_386_49) / var_386_63
				local var_386_65 = Color.New(1, 1, 1)

				var_386_65.a = Mathf.Lerp(0, 1, var_386_64)

				var_386_50:GetComponent("SpriteRenderer").material:SetColor("_Color", var_386_65)
			end

			local var_386_66 = 1.23333333333333
			local var_386_67 = 0.616666666666667

			if var_386_66 < arg_383_1.time_ and arg_383_1.time_ <= var_386_66 + arg_386_0 then
				local var_386_68 = "play"
				local var_386_69 = "music"

				arg_383_1:AudioAction(var_386_68, var_386_69, "ui_battle", "ui_battle_stopbgm", "")

				local var_386_70 = ""
				local var_386_71 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_386_71 ~= "" then
					if arg_383_1.bgmTxt_.text ~= var_386_71 and arg_383_1.bgmTxt_.text ~= "" then
						if arg_383_1.bgmTxt2_.text ~= "" then
							arg_383_1.bgmTxt_.text = arg_383_1.bgmTxt2_.text
						end

						arg_383_1.bgmTxt2_.text = var_386_71

						arg_383_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_383_1.bgmTxt_.text = var_386_71
						arg_383_1.bgmTxt2_.text = var_386_71
					end

					if arg_383_1.bgmTimer then
						arg_383_1.bgmTimer:Stop()

						arg_383_1.bgmTimer = nil
					end

					if arg_383_1.settingData.show_music_name == 1 then
						arg_383_1.musicController:SetSelectedState("show")
						arg_383_1.musicAnimator_:Play("open", 0, 0)

						if arg_383_1.settingData.music_time ~= 0 then
							arg_383_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_383_1.settingData.music_time), function()
								if arg_383_1 == nil or isNil(arg_383_1.bgmTxt_) then
									return
								end

								arg_383_1.musicController:SetSelectedState("hide")
								arg_383_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_386_72 = 2.56666666666667
			local var_386_73 = 1

			if var_386_72 < arg_383_1.time_ and arg_383_1.time_ <= var_386_72 + arg_386_0 then
				local var_386_74 = "play"
				local var_386_75 = "music"

				arg_383_1:AudioAction(var_386_74, var_386_75, "bgm_side_daily10", "bgm_side_daily10", "bgm_side_daily10.awb")

				local var_386_76 = ""
				local var_386_77 = manager.audio:GetAudioName("bgm_side_daily10", "bgm_side_daily10")

				if var_386_77 ~= "" then
					if arg_383_1.bgmTxt_.text ~= var_386_77 and arg_383_1.bgmTxt_.text ~= "" then
						if arg_383_1.bgmTxt2_.text ~= "" then
							arg_383_1.bgmTxt_.text = arg_383_1.bgmTxt2_.text
						end

						arg_383_1.bgmTxt2_.text = var_386_77

						arg_383_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_383_1.bgmTxt_.text = var_386_77
						arg_383_1.bgmTxt2_.text = var_386_77
					end

					if arg_383_1.bgmTimer then
						arg_383_1.bgmTimer:Stop()

						arg_383_1.bgmTimer = nil
					end

					if arg_383_1.settingData.show_music_name == 1 then
						arg_383_1.musicController:SetSelectedState("show")
						arg_383_1.musicAnimator_:Play("open", 0, 0)

						if arg_383_1.settingData.music_time ~= 0 then
							arg_383_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_383_1.settingData.music_time), function()
								if arg_383_1 == nil or isNil(arg_383_1.bgmTxt_) then
									return
								end

								arg_383_1.musicController:SetSelectedState("hide")
								arg_383_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_383_1.frameCnt_ <= 1 then
				arg_383_1.dialog_:SetActive(false)
			end

			local var_386_78 = 6
			local var_386_79 = 0.35

			if var_386_78 < arg_383_1.time_ and arg_383_1.time_ <= var_386_78 + arg_386_0 then
				arg_383_1.talkMaxDuration = 0

				arg_383_1.dialog_:SetActive(true)

				arg_383_1.dialogCg_.alpha = 0

				local var_386_80 = LeanTween.value(arg_383_1.dialog_, 0, 1, 0.3)

				var_386_80:setOnUpdate(LuaHelper.FloatAction(function(arg_389_0)
					arg_383_1.dialogCg_.alpha = arg_389_0
				end))
				var_386_80:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_383_1.dialog_)
					var_386_80:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_383_1.duration_ = arg_383_1.duration_ + 0.3

				SetActive(arg_383_1.leftNameGo_, true)

				local var_386_81 = arg_383_1:FormatText(StoryNameCfg[381].name)

				arg_383_1.leftNameTxt_.text = var_386_81

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_383_1.leftNameTxt_.transform)

				arg_383_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_383_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_383_1:RecordName(arg_383_1.leftNameTxt_.text)
				SetActive(arg_383_1.iconTrs_.gameObject, false)
				arg_383_1.callingController_:SetSelectedState("normal")

				local var_386_82 = arg_383_1:GetWordFromCfg(1107505099)
				local var_386_83 = arg_383_1:FormatText(var_386_82.content)

				arg_383_1.text_.text = var_386_83

				LuaForUtil.ClearLinePrefixSymbol(arg_383_1.text_)

				local var_386_84 = 14
				local var_386_85 = utf8.len(var_386_83)
				local var_386_86 = var_386_84 <= 0 and var_386_79 or var_386_79 * (var_386_85 / var_386_84)

				if var_386_86 > 0 and var_386_79 < var_386_86 then
					arg_383_1.talkMaxDuration = var_386_86
					var_386_78 = var_386_78 + 0.3

					if var_386_86 + var_386_78 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_86 + var_386_78
					end
				end

				arg_383_1.text_.text = var_386_83
				arg_383_1.typewritter.percent = 0

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107505", "1107505099", "story_v_side_new_1107505.awb") ~= 0 then
					local var_386_87 = manager.audio:GetVoiceLength("story_v_side_new_1107505", "1107505099", "story_v_side_new_1107505.awb") / 1000

					if var_386_87 + var_386_78 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_87 + var_386_78
					end

					if var_386_82.prefab_name ~= "" and arg_383_1.actors_[var_386_82.prefab_name] ~= nil then
						local var_386_88 = LuaForUtil.PlayVoiceWithCriLipsync(arg_383_1.actors_[var_386_82.prefab_name].transform, "story_v_side_new_1107505", "1107505099", "story_v_side_new_1107505.awb")

						arg_383_1:RecordAudio("1107505099", var_386_88)
						arg_383_1:RecordAudio("1107505099", var_386_88)
					else
						arg_383_1:AudioAction("play", "voice", "story_v_side_new_1107505", "1107505099", "story_v_side_new_1107505.awb")
					end

					arg_383_1:RecordHistoryTalkVoice("story_v_side_new_1107505", "1107505099", "story_v_side_new_1107505.awb")
				end

				arg_383_1:RecordContent(arg_383_1.text_.text)
			end

			local var_386_89 = var_386_78 + 0.3
			local var_386_90 = math.max(var_386_79, arg_383_1.talkMaxDuration)

			if var_386_89 <= arg_383_1.time_ and arg_383_1.time_ < var_386_89 + var_386_90 then
				arg_383_1.typewritter.percent = (arg_383_1.time_ - var_386_89) / var_386_90

				arg_383_1.typewritter:SetDirty()
			end

			if arg_383_1.time_ >= var_386_89 + var_386_90 and arg_383_1.time_ < var_386_89 + var_386_90 + arg_386_0 then
				arg_383_1.typewritter.percent = 1

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(true)
			end
		end

		arg_383_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_actor",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 5.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_383_1:InitPlayNodeList()
	end,
	Play1107505100 = function(arg_391_0, arg_391_1)
		arg_391_1.time_ = 0
		arg_391_1.frameCnt_ = 0
		arg_391_1.state_ = "playing"
		arg_391_1.curTalkId_ = 1107505100
		arg_391_1.duration_ = 5

		SetActive(arg_391_1.tipsGo_, false)

		function arg_391_1.onSingleLineFinish_()
			arg_391_1.onSingleLineUpdate_ = nil
			arg_391_1.onSingleLineFinish_ = nil
			arg_391_1.state_ = "waiting"
		end

		function arg_391_1.playNext_(arg_393_0)
			if arg_393_0 == 1 then
				arg_391_0:Play1107505101(arg_391_1)
			end
		end

		function arg_391_1.onSingleLineUpdate_(arg_394_0)
			local var_394_0 = arg_391_1.actors_["1075ui_actor"].transform
			local var_394_1 = 0

			if var_394_1 < arg_391_1.time_ and arg_391_1.time_ <= var_394_1 + arg_394_0 then
				arg_391_1.var_.moveOldPos1075ui_actor = var_394_0.localPosition

				local var_394_2 = GameObjectTools.GetOrAddComponent(var_394_0.gameObject, typeof(DynamicBoneHelper))

				if var_394_2 then
					var_394_2:EnableDynamicBone(false)
				end
			end

			local var_394_3 = 0.001

			if var_394_1 <= arg_391_1.time_ and arg_391_1.time_ < var_394_1 + var_394_3 then
				local var_394_4 = (arg_391_1.time_ - var_394_1) / var_394_3
				local var_394_5 = Vector3.New(0, 100, 0)

				var_394_0.localPosition = Vector3.Lerp(arg_391_1.var_.moveOldPos1075ui_actor, var_394_5, var_394_4)

				local var_394_6 = manager.ui.mainCamera.transform.position - var_394_0.position

				var_394_0.forward = Vector3.New(var_394_6.x, var_394_6.y, var_394_6.z)

				local var_394_7 = var_394_0.localEulerAngles

				var_394_7.z = 0
				var_394_7.x = 0
				var_394_0.localEulerAngles = var_394_7
			end

			if arg_391_1.time_ >= var_394_1 + var_394_3 and arg_391_1.time_ < var_394_1 + var_394_3 + arg_394_0 then
				var_394_0.localPosition = Vector3.New(0, 100, 0)

				local var_394_8 = manager.ui.mainCamera.transform.position - var_394_0.position

				var_394_0.forward = Vector3.New(var_394_8.x, var_394_8.y, var_394_8.z)

				local var_394_9 = var_394_0.localEulerAngles

				var_394_9.z = 0
				var_394_9.x = 0
				var_394_0.localEulerAngles = var_394_9

				local var_394_10 = GameObjectTools.GetOrAddComponent(var_394_0.gameObject, typeof(DynamicBoneHelper))

				if var_394_10 then
					var_394_10:EnableDynamicBone(true)
				end
			end

			local var_394_11 = arg_391_1.actors_["1075ui_actor"]
			local var_394_12 = 0

			if var_394_12 < arg_391_1.time_ and arg_391_1.time_ <= var_394_12 + arg_394_0 and not isNil(var_394_11) and arg_391_1.var_.characterEffect1075ui_actor == nil then
				arg_391_1.var_.characterEffect1075ui_actor = var_394_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_394_13 = 0.200000002980232

			if var_394_12 <= arg_391_1.time_ and arg_391_1.time_ < var_394_12 + var_394_13 and not isNil(var_394_11) then
				local var_394_14 = (arg_391_1.time_ - var_394_12) / var_394_13

				if arg_391_1.var_.characterEffect1075ui_actor and not isNil(var_394_11) then
					local var_394_15 = Mathf.Lerp(0, 0.5, var_394_14)

					arg_391_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_391_1.var_.characterEffect1075ui_actor.fillRatio = var_394_15
				end
			end

			if arg_391_1.time_ >= var_394_12 + var_394_13 and arg_391_1.time_ < var_394_12 + var_394_13 + arg_394_0 and not isNil(var_394_11) and arg_391_1.var_.characterEffect1075ui_actor then
				local var_394_16 = 0.5

				arg_391_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_391_1.var_.characterEffect1075ui_actor.fillRatio = var_394_16
			end

			local var_394_17 = 0
			local var_394_18 = 0.85

			if var_394_17 < arg_391_1.time_ and arg_391_1.time_ <= var_394_17 + arg_394_0 then
				arg_391_1.talkMaxDuration = 0
				arg_391_1.dialogCg_.alpha = 1

				arg_391_1.dialog_:SetActive(true)
				SetActive(arg_391_1.leftNameGo_, false)

				arg_391_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_391_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_391_1:RecordName(arg_391_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_391_1.iconTrs_.gameObject, false)
				arg_391_1.callingController_:SetSelectedState("normal")

				local var_394_19 = arg_391_1:GetWordFromCfg(1107505100)
				local var_394_20 = arg_391_1:FormatText(var_394_19.content)

				arg_391_1.text_.text = var_394_20

				LuaForUtil.ClearLinePrefixSymbol(arg_391_1.text_)

				local var_394_21 = 34
				local var_394_22 = utf8.len(var_394_20)
				local var_394_23 = var_394_21 <= 0 and var_394_18 or var_394_18 * (var_394_22 / var_394_21)

				if var_394_23 > 0 and var_394_18 < var_394_23 then
					arg_391_1.talkMaxDuration = var_394_23

					if var_394_23 + var_394_17 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_23 + var_394_17
					end
				end

				arg_391_1.text_.text = var_394_20
				arg_391_1.typewritter.percent = 0

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(false)
				arg_391_1:RecordContent(arg_391_1.text_.text)
			end

			local var_394_24 = math.max(var_394_18, arg_391_1.talkMaxDuration)

			if var_394_17 <= arg_391_1.time_ and arg_391_1.time_ < var_394_17 + var_394_24 then
				arg_391_1.typewritter.percent = (arg_391_1.time_ - var_394_17) / var_394_24

				arg_391_1.typewritter:SetDirty()
			end

			if arg_391_1.time_ >= var_394_17 + var_394_24 and arg_391_1.time_ < var_394_17 + var_394_24 + arg_394_0 then
				arg_391_1.typewritter.percent = 1

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(true)
			end
		end

		arg_391_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_actor",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_391_1:InitPlayNodeList()
	end,
	Play1107505101 = function(arg_395_0, arg_395_1)
		arg_395_1.time_ = 0
		arg_395_1.frameCnt_ = 0
		arg_395_1.state_ = "playing"
		arg_395_1.curTalkId_ = 1107505101
		arg_395_1.duration_ = 5

		SetActive(arg_395_1.tipsGo_, false)

		function arg_395_1.onSingleLineFinish_()
			arg_395_1.onSingleLineUpdate_ = nil
			arg_395_1.onSingleLineFinish_ = nil
			arg_395_1.state_ = "waiting"
		end

		function arg_395_1.playNext_(arg_397_0)
			if arg_397_0 == 1 then
				arg_395_0:Play1107505102(arg_395_1)
			end
		end

		function arg_395_1.onSingleLineUpdate_(arg_398_0)
			local var_398_0 = 0
			local var_398_1 = 1.05

			if var_398_0 < arg_395_1.time_ and arg_395_1.time_ <= var_398_0 + arg_398_0 then
				arg_395_1.talkMaxDuration = 0
				arg_395_1.dialogCg_.alpha = 1

				arg_395_1.dialog_:SetActive(true)
				SetActive(arg_395_1.leftNameGo_, false)

				arg_395_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_395_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_395_1:RecordName(arg_395_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_395_1.iconTrs_.gameObject, false)
				arg_395_1.callingController_:SetSelectedState("normal")

				local var_398_2 = arg_395_1:GetWordFromCfg(1107505101)
				local var_398_3 = arg_395_1:FormatText(var_398_2.content)

				arg_395_1.text_.text = var_398_3

				LuaForUtil.ClearLinePrefixSymbol(arg_395_1.text_)

				local var_398_4 = 42
				local var_398_5 = utf8.len(var_398_3)
				local var_398_6 = var_398_4 <= 0 and var_398_1 or var_398_1 * (var_398_5 / var_398_4)

				if var_398_6 > 0 and var_398_1 < var_398_6 then
					arg_395_1.talkMaxDuration = var_398_6

					if var_398_6 + var_398_0 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_6 + var_398_0
					end
				end

				arg_395_1.text_.text = var_398_3
				arg_395_1.typewritter.percent = 0

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(false)
				arg_395_1:RecordContent(arg_395_1.text_.text)
			end

			local var_398_7 = math.max(var_398_1, arg_395_1.talkMaxDuration)

			if var_398_0 <= arg_395_1.time_ and arg_395_1.time_ < var_398_0 + var_398_7 then
				arg_395_1.typewritter.percent = (arg_395_1.time_ - var_398_0) / var_398_7

				arg_395_1.typewritter:SetDirty()
			end

			if arg_395_1.time_ >= var_398_0 + var_398_7 and arg_395_1.time_ < var_398_0 + var_398_7 + arg_398_0 then
				arg_395_1.typewritter.percent = 1

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(true)
			end
		end

		arg_395_1.nodeConfigList_ = {}

		arg_395_1:InitPlayNodeList()
	end,
	Play1107505102 = function(arg_399_0, arg_399_1)
		arg_399_1.time_ = 0
		arg_399_1.frameCnt_ = 0
		arg_399_1.state_ = "playing"
		arg_399_1.curTalkId_ = 1107505102
		arg_399_1.duration_ = 5

		SetActive(arg_399_1.tipsGo_, false)

		function arg_399_1.onSingleLineFinish_()
			arg_399_1.onSingleLineUpdate_ = nil
			arg_399_1.onSingleLineFinish_ = nil
			arg_399_1.state_ = "waiting"
		end

		function arg_399_1.playNext_(arg_401_0)
			if arg_401_0 == 1 then
				arg_399_0:Play1107505103(arg_399_1)
			end
		end

		function arg_399_1.onSingleLineUpdate_(arg_402_0)
			local var_402_0 = 0
			local var_402_1 = 1.1

			if var_402_0 < arg_399_1.time_ and arg_399_1.time_ <= var_402_0 + arg_402_0 then
				arg_399_1.talkMaxDuration = 0
				arg_399_1.dialogCg_.alpha = 1

				arg_399_1.dialog_:SetActive(true)
				SetActive(arg_399_1.leftNameGo_, false)

				arg_399_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_399_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_399_1:RecordName(arg_399_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_399_1.iconTrs_.gameObject, false)
				arg_399_1.callingController_:SetSelectedState("normal")

				local var_402_2 = arg_399_1:GetWordFromCfg(1107505102)
				local var_402_3 = arg_399_1:FormatText(var_402_2.content)

				arg_399_1.text_.text = var_402_3

				LuaForUtil.ClearLinePrefixSymbol(arg_399_1.text_)

				local var_402_4 = 44
				local var_402_5 = utf8.len(var_402_3)
				local var_402_6 = var_402_4 <= 0 and var_402_1 or var_402_1 * (var_402_5 / var_402_4)

				if var_402_6 > 0 and var_402_1 < var_402_6 then
					arg_399_1.talkMaxDuration = var_402_6

					if var_402_6 + var_402_0 > arg_399_1.duration_ then
						arg_399_1.duration_ = var_402_6 + var_402_0
					end
				end

				arg_399_1.text_.text = var_402_3
				arg_399_1.typewritter.percent = 0

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(false)
				arg_399_1:RecordContent(arg_399_1.text_.text)
			end

			local var_402_7 = math.max(var_402_1, arg_399_1.talkMaxDuration)

			if var_402_0 <= arg_399_1.time_ and arg_399_1.time_ < var_402_0 + var_402_7 then
				arg_399_1.typewritter.percent = (arg_399_1.time_ - var_402_0) / var_402_7

				arg_399_1.typewritter:SetDirty()
			end

			if arg_399_1.time_ >= var_402_0 + var_402_7 and arg_399_1.time_ < var_402_0 + var_402_7 + arg_402_0 then
				arg_399_1.typewritter.percent = 1

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(true)
			end
		end

		arg_399_1.nodeConfigList_ = {}

		arg_399_1:InitPlayNodeList()
	end,
	Play1107505103 = function(arg_403_0, arg_403_1)
		arg_403_1.time_ = 0
		arg_403_1.frameCnt_ = 0
		arg_403_1.state_ = "playing"
		arg_403_1.curTalkId_ = 1107505103
		arg_403_1.duration_ = 3.73

		SetActive(arg_403_1.tipsGo_, false)

		function arg_403_1.onSingleLineFinish_()
			arg_403_1.onSingleLineUpdate_ = nil
			arg_403_1.onSingleLineFinish_ = nil
			arg_403_1.state_ = "waiting"
		end

		function arg_403_1.playNext_(arg_405_0)
			if arg_405_0 == 1 then
				arg_403_0:Play1107505104(arg_403_1)
			end
		end

		function arg_403_1.onSingleLineUpdate_(arg_406_0)
			local var_406_0 = arg_403_1.actors_["1075ui_actor"].transform
			local var_406_1 = 0

			if var_406_1 < arg_403_1.time_ and arg_403_1.time_ <= var_406_1 + arg_406_0 then
				arg_403_1.var_.moveOldPos1075ui_actor = var_406_0.localPosition

				local var_406_2 = GameObjectTools.GetOrAddComponent(var_406_0.gameObject, typeof(DynamicBoneHelper))

				if var_406_2 then
					var_406_2:EnableDynamicBone(false)
				end
			end

			local var_406_3 = 0.001

			if var_406_1 <= arg_403_1.time_ and arg_403_1.time_ < var_406_1 + var_406_3 then
				local var_406_4 = (arg_403_1.time_ - var_406_1) / var_406_3
				local var_406_5 = Vector3.New(0, -1.055, -6.16)

				var_406_0.localPosition = Vector3.Lerp(arg_403_1.var_.moveOldPos1075ui_actor, var_406_5, var_406_4)

				local var_406_6 = manager.ui.mainCamera.transform.position - var_406_0.position

				var_406_0.forward = Vector3.New(var_406_6.x, var_406_6.y, var_406_6.z)

				local var_406_7 = var_406_0.localEulerAngles

				var_406_7.z = 0
				var_406_7.x = 0
				var_406_0.localEulerAngles = var_406_7
			end

			if arg_403_1.time_ >= var_406_1 + var_406_3 and arg_403_1.time_ < var_406_1 + var_406_3 + arg_406_0 then
				var_406_0.localPosition = Vector3.New(0, -1.055, -6.16)

				local var_406_8 = manager.ui.mainCamera.transform.position - var_406_0.position

				var_406_0.forward = Vector3.New(var_406_8.x, var_406_8.y, var_406_8.z)

				local var_406_9 = var_406_0.localEulerAngles

				var_406_9.z = 0
				var_406_9.x = 0
				var_406_0.localEulerAngles = var_406_9

				local var_406_10 = GameObjectTools.GetOrAddComponent(var_406_0.gameObject, typeof(DynamicBoneHelper))

				if var_406_10 then
					var_406_10:EnableDynamicBone(true)
				end
			end

			local var_406_11 = arg_403_1.actors_["1075ui_actor"]
			local var_406_12 = 0

			if var_406_12 < arg_403_1.time_ and arg_403_1.time_ <= var_406_12 + arg_406_0 and not isNil(var_406_11) and arg_403_1.var_.characterEffect1075ui_actor == nil then
				arg_403_1.var_.characterEffect1075ui_actor = var_406_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_406_13 = 0.200000002980232

			if var_406_12 <= arg_403_1.time_ and arg_403_1.time_ < var_406_12 + var_406_13 and not isNil(var_406_11) then
				local var_406_14 = (arg_403_1.time_ - var_406_12) / var_406_13

				if arg_403_1.var_.characterEffect1075ui_actor and not isNil(var_406_11) then
					arg_403_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_403_1.time_ >= var_406_12 + var_406_13 and arg_403_1.time_ < var_406_12 + var_406_13 + arg_406_0 and not isNil(var_406_11) and arg_403_1.var_.characterEffect1075ui_actor then
				arg_403_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			local var_406_15 = 0

			if var_406_15 < arg_403_1.time_ and arg_403_1.time_ <= var_406_15 + arg_406_0 then
				arg_403_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075action/1075action5_1")
			end

			local var_406_16 = 0

			if var_406_16 < arg_403_1.time_ and arg_403_1.time_ <= var_406_16 + arg_406_0 then
				arg_403_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_406_17 = 0
			local var_406_18 = 0.35

			if var_406_17 < arg_403_1.time_ and arg_403_1.time_ <= var_406_17 + arg_406_0 then
				arg_403_1.talkMaxDuration = 0
				arg_403_1.dialogCg_.alpha = 1

				arg_403_1.dialog_:SetActive(true)
				SetActive(arg_403_1.leftNameGo_, true)

				local var_406_19 = arg_403_1:FormatText(StoryNameCfg[381].name)

				arg_403_1.leftNameTxt_.text = var_406_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_403_1.leftNameTxt_.transform)

				arg_403_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_403_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_403_1:RecordName(arg_403_1.leftNameTxt_.text)
				SetActive(arg_403_1.iconTrs_.gameObject, false)
				arg_403_1.callingController_:SetSelectedState("normal")

				local var_406_20 = arg_403_1:GetWordFromCfg(1107505103)
				local var_406_21 = arg_403_1:FormatText(var_406_20.content)

				arg_403_1.text_.text = var_406_21

				LuaForUtil.ClearLinePrefixSymbol(arg_403_1.text_)

				local var_406_22 = 14
				local var_406_23 = utf8.len(var_406_21)
				local var_406_24 = var_406_22 <= 0 and var_406_18 or var_406_18 * (var_406_23 / var_406_22)

				if var_406_24 > 0 and var_406_18 < var_406_24 then
					arg_403_1.talkMaxDuration = var_406_24

					if var_406_24 + var_406_17 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_24 + var_406_17
					end
				end

				arg_403_1.text_.text = var_406_21
				arg_403_1.typewritter.percent = 0

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107505", "1107505103", "story_v_side_new_1107505.awb") ~= 0 then
					local var_406_25 = manager.audio:GetVoiceLength("story_v_side_new_1107505", "1107505103", "story_v_side_new_1107505.awb") / 1000

					if var_406_25 + var_406_17 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_25 + var_406_17
					end

					if var_406_20.prefab_name ~= "" and arg_403_1.actors_[var_406_20.prefab_name] ~= nil then
						local var_406_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_403_1.actors_[var_406_20.prefab_name].transform, "story_v_side_new_1107505", "1107505103", "story_v_side_new_1107505.awb")

						arg_403_1:RecordAudio("1107505103", var_406_26)
						arg_403_1:RecordAudio("1107505103", var_406_26)
					else
						arg_403_1:AudioAction("play", "voice", "story_v_side_new_1107505", "1107505103", "story_v_side_new_1107505.awb")
					end

					arg_403_1:RecordHistoryTalkVoice("story_v_side_new_1107505", "1107505103", "story_v_side_new_1107505.awb")
				end

				arg_403_1:RecordContent(arg_403_1.text_.text)
			end

			local var_406_27 = math.max(var_406_18, arg_403_1.talkMaxDuration)

			if var_406_17 <= arg_403_1.time_ and arg_403_1.time_ < var_406_17 + var_406_27 then
				arg_403_1.typewritter.percent = (arg_403_1.time_ - var_406_17) / var_406_27

				arg_403_1.typewritter:SetDirty()
			end

			if arg_403_1.time_ >= var_406_17 + var_406_27 and arg_403_1.time_ < var_406_17 + var_406_27 + arg_406_0 then
				arg_403_1.typewritter.percent = 1

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(true)
			end
		end

		arg_403_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_actor",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_403_1:InitPlayNodeList()
	end,
	Play1107505104 = function(arg_407_0, arg_407_1)
		arg_407_1.time_ = 0
		arg_407_1.frameCnt_ = 0
		arg_407_1.state_ = "playing"
		arg_407_1.curTalkId_ = 1107505104
		arg_407_1.duration_ = 5

		SetActive(arg_407_1.tipsGo_, false)

		function arg_407_1.onSingleLineFinish_()
			arg_407_1.onSingleLineUpdate_ = nil
			arg_407_1.onSingleLineFinish_ = nil
			arg_407_1.state_ = "waiting"
		end

		function arg_407_1.playNext_(arg_409_0)
			if arg_409_0 == 1 then
				arg_407_0:Play1107505105(arg_407_1)
			end
		end

		function arg_407_1.onSingleLineUpdate_(arg_410_0)
			local var_410_0 = arg_407_1.actors_["1075ui_actor"]
			local var_410_1 = 0

			if var_410_1 < arg_407_1.time_ and arg_407_1.time_ <= var_410_1 + arg_410_0 and not isNil(var_410_0) and arg_407_1.var_.characterEffect1075ui_actor == nil then
				arg_407_1.var_.characterEffect1075ui_actor = var_410_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_410_2 = 0.200000002980232

			if var_410_1 <= arg_407_1.time_ and arg_407_1.time_ < var_410_1 + var_410_2 and not isNil(var_410_0) then
				local var_410_3 = (arg_407_1.time_ - var_410_1) / var_410_2

				if arg_407_1.var_.characterEffect1075ui_actor and not isNil(var_410_0) then
					local var_410_4 = Mathf.Lerp(0, 0.5, var_410_3)

					arg_407_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_407_1.var_.characterEffect1075ui_actor.fillRatio = var_410_4
				end
			end

			if arg_407_1.time_ >= var_410_1 + var_410_2 and arg_407_1.time_ < var_410_1 + var_410_2 + arg_410_0 and not isNil(var_410_0) and arg_407_1.var_.characterEffect1075ui_actor then
				local var_410_5 = 0.5

				arg_407_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_407_1.var_.characterEffect1075ui_actor.fillRatio = var_410_5
			end

			local var_410_6 = 0
			local var_410_7 = 0.95

			if var_410_6 < arg_407_1.time_ and arg_407_1.time_ <= var_410_6 + arg_410_0 then
				arg_407_1.talkMaxDuration = 0
				arg_407_1.dialogCg_.alpha = 1

				arg_407_1.dialog_:SetActive(true)
				SetActive(arg_407_1.leftNameGo_, false)

				arg_407_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_407_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_407_1:RecordName(arg_407_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_407_1.iconTrs_.gameObject, false)
				arg_407_1.callingController_:SetSelectedState("normal")

				local var_410_8 = arg_407_1:GetWordFromCfg(1107505104)
				local var_410_9 = arg_407_1:FormatText(var_410_8.content)

				arg_407_1.text_.text = var_410_9

				LuaForUtil.ClearLinePrefixSymbol(arg_407_1.text_)

				local var_410_10 = 38
				local var_410_11 = utf8.len(var_410_9)
				local var_410_12 = var_410_10 <= 0 and var_410_7 or var_410_7 * (var_410_11 / var_410_10)

				if var_410_12 > 0 and var_410_7 < var_410_12 then
					arg_407_1.talkMaxDuration = var_410_12

					if var_410_12 + var_410_6 > arg_407_1.duration_ then
						arg_407_1.duration_ = var_410_12 + var_410_6
					end
				end

				arg_407_1.text_.text = var_410_9
				arg_407_1.typewritter.percent = 0

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(false)
				arg_407_1:RecordContent(arg_407_1.text_.text)
			end

			local var_410_13 = math.max(var_410_7, arg_407_1.talkMaxDuration)

			if var_410_6 <= arg_407_1.time_ and arg_407_1.time_ < var_410_6 + var_410_13 then
				arg_407_1.typewritter.percent = (arg_407_1.time_ - var_410_6) / var_410_13

				arg_407_1.typewritter:SetDirty()
			end

			if arg_407_1.time_ >= var_410_6 + var_410_13 and arg_407_1.time_ < var_410_6 + var_410_13 + arg_410_0 then
				arg_407_1.typewritter.percent = 1

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(true)
			end
		end

		arg_407_1.nodeConfigList_ = {}

		arg_407_1:InitPlayNodeList()
	end,
	Play1107505105 = function(arg_411_0, arg_411_1)
		arg_411_1.time_ = 0
		arg_411_1.frameCnt_ = 0
		arg_411_1.state_ = "playing"
		arg_411_1.curTalkId_ = 1107505105
		arg_411_1.duration_ = 8.83

		SetActive(arg_411_1.tipsGo_, false)

		function arg_411_1.onSingleLineFinish_()
			arg_411_1.onSingleLineUpdate_ = nil
			arg_411_1.onSingleLineFinish_ = nil
			arg_411_1.state_ = "waiting"
		end

		function arg_411_1.playNext_(arg_413_0)
			if arg_413_0 == 1 then
				arg_411_0:Play1107505106(arg_411_1)
			end
		end

		function arg_411_1.onSingleLineUpdate_(arg_414_0)
			local var_414_0 = arg_411_1.actors_["1075ui_actor"]
			local var_414_1 = 0

			if var_414_1 < arg_411_1.time_ and arg_411_1.time_ <= var_414_1 + arg_414_0 and not isNil(var_414_0) and arg_411_1.var_.characterEffect1075ui_actor == nil then
				arg_411_1.var_.characterEffect1075ui_actor = var_414_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_414_2 = 0.200000002980232

			if var_414_1 <= arg_411_1.time_ and arg_411_1.time_ < var_414_1 + var_414_2 and not isNil(var_414_0) then
				local var_414_3 = (arg_411_1.time_ - var_414_1) / var_414_2

				if arg_411_1.var_.characterEffect1075ui_actor and not isNil(var_414_0) then
					arg_411_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_411_1.time_ >= var_414_1 + var_414_2 and arg_411_1.time_ < var_414_1 + var_414_2 + arg_414_0 and not isNil(var_414_0) and arg_411_1.var_.characterEffect1075ui_actor then
				arg_411_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			local var_414_4 = 0

			if var_414_4 < arg_411_1.time_ and arg_411_1.time_ <= var_414_4 + arg_414_0 then
				arg_411_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075action/1075action5_2")
			end

			local var_414_5 = 0

			if var_414_5 < arg_411_1.time_ and arg_411_1.time_ <= var_414_5 + arg_414_0 then
				arg_411_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_414_6 = 0
			local var_414_7 = 0.55

			if var_414_6 < arg_411_1.time_ and arg_411_1.time_ <= var_414_6 + arg_414_0 then
				arg_411_1.talkMaxDuration = 0
				arg_411_1.dialogCg_.alpha = 1

				arg_411_1.dialog_:SetActive(true)
				SetActive(arg_411_1.leftNameGo_, true)

				local var_414_8 = arg_411_1:FormatText(StoryNameCfg[381].name)

				arg_411_1.leftNameTxt_.text = var_414_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_411_1.leftNameTxt_.transform)

				arg_411_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_411_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_411_1:RecordName(arg_411_1.leftNameTxt_.text)
				SetActive(arg_411_1.iconTrs_.gameObject, false)
				arg_411_1.callingController_:SetSelectedState("normal")

				local var_414_9 = arg_411_1:GetWordFromCfg(1107505105)
				local var_414_10 = arg_411_1:FormatText(var_414_9.content)

				arg_411_1.text_.text = var_414_10

				LuaForUtil.ClearLinePrefixSymbol(arg_411_1.text_)

				local var_414_11 = 22
				local var_414_12 = utf8.len(var_414_10)
				local var_414_13 = var_414_11 <= 0 and var_414_7 or var_414_7 * (var_414_12 / var_414_11)

				if var_414_13 > 0 and var_414_7 < var_414_13 then
					arg_411_1.talkMaxDuration = var_414_13

					if var_414_13 + var_414_6 > arg_411_1.duration_ then
						arg_411_1.duration_ = var_414_13 + var_414_6
					end
				end

				arg_411_1.text_.text = var_414_10
				arg_411_1.typewritter.percent = 0

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107505", "1107505105", "story_v_side_new_1107505.awb") ~= 0 then
					local var_414_14 = manager.audio:GetVoiceLength("story_v_side_new_1107505", "1107505105", "story_v_side_new_1107505.awb") / 1000

					if var_414_14 + var_414_6 > arg_411_1.duration_ then
						arg_411_1.duration_ = var_414_14 + var_414_6
					end

					if var_414_9.prefab_name ~= "" and arg_411_1.actors_[var_414_9.prefab_name] ~= nil then
						local var_414_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_411_1.actors_[var_414_9.prefab_name].transform, "story_v_side_new_1107505", "1107505105", "story_v_side_new_1107505.awb")

						arg_411_1:RecordAudio("1107505105", var_414_15)
						arg_411_1:RecordAudio("1107505105", var_414_15)
					else
						arg_411_1:AudioAction("play", "voice", "story_v_side_new_1107505", "1107505105", "story_v_side_new_1107505.awb")
					end

					arg_411_1:RecordHistoryTalkVoice("story_v_side_new_1107505", "1107505105", "story_v_side_new_1107505.awb")
				end

				arg_411_1:RecordContent(arg_411_1.text_.text)
			end

			local var_414_16 = math.max(var_414_7, arg_411_1.talkMaxDuration)

			if var_414_6 <= arg_411_1.time_ and arg_411_1.time_ < var_414_6 + var_414_16 then
				arg_411_1.typewritter.percent = (arg_411_1.time_ - var_414_6) / var_414_16

				arg_411_1.typewritter:SetDirty()
			end

			if arg_411_1.time_ >= var_414_6 + var_414_16 and arg_411_1.time_ < var_414_6 + var_414_16 + arg_414_0 then
				arg_411_1.typewritter.percent = 1

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(true)
			end
		end

		arg_411_1.nodeConfigList_ = {}

		arg_411_1:InitPlayNodeList()
	end,
	Play1107505106 = function(arg_415_0, arg_415_1)
		arg_415_1.time_ = 0
		arg_415_1.frameCnt_ = 0
		arg_415_1.state_ = "playing"
		arg_415_1.curTalkId_ = 1107505106
		arg_415_1.duration_ = 5

		SetActive(arg_415_1.tipsGo_, false)

		function arg_415_1.onSingleLineFinish_()
			arg_415_1.onSingleLineUpdate_ = nil
			arg_415_1.onSingleLineFinish_ = nil
			arg_415_1.state_ = "waiting"
		end

		function arg_415_1.playNext_(arg_417_0)
			if arg_417_0 == 1 then
				arg_415_0:Play1107505107(arg_415_1)
			end
		end

		function arg_415_1.onSingleLineUpdate_(arg_418_0)
			local var_418_0 = arg_415_1.actors_["1075ui_actor"]
			local var_418_1 = 0

			if var_418_1 < arg_415_1.time_ and arg_415_1.time_ <= var_418_1 + arg_418_0 and not isNil(var_418_0) and arg_415_1.var_.characterEffect1075ui_actor == nil then
				arg_415_1.var_.characterEffect1075ui_actor = var_418_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_418_2 = 0.200000002980232

			if var_418_1 <= arg_415_1.time_ and arg_415_1.time_ < var_418_1 + var_418_2 and not isNil(var_418_0) then
				local var_418_3 = (arg_415_1.time_ - var_418_1) / var_418_2

				if arg_415_1.var_.characterEffect1075ui_actor and not isNil(var_418_0) then
					local var_418_4 = Mathf.Lerp(0, 0.5, var_418_3)

					arg_415_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_415_1.var_.characterEffect1075ui_actor.fillRatio = var_418_4
				end
			end

			if arg_415_1.time_ >= var_418_1 + var_418_2 and arg_415_1.time_ < var_418_1 + var_418_2 + arg_418_0 and not isNil(var_418_0) and arg_415_1.var_.characterEffect1075ui_actor then
				local var_418_5 = 0.5

				arg_415_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_415_1.var_.characterEffect1075ui_actor.fillRatio = var_418_5
			end

			local var_418_6 = arg_415_1.actors_["1075ui_actor"].transform
			local var_418_7 = 0

			if var_418_7 < arg_415_1.time_ and arg_415_1.time_ <= var_418_7 + arg_418_0 then
				arg_415_1.var_.moveOldPos1075ui_actor = var_418_6.localPosition

				local var_418_8 = GameObjectTools.GetOrAddComponent(var_418_6.gameObject, typeof(DynamicBoneHelper))

				if var_418_8 then
					var_418_8:EnableDynamicBone(false)
				end
			end

			local var_418_9 = 0.001

			if var_418_7 <= arg_415_1.time_ and arg_415_1.time_ < var_418_7 + var_418_9 then
				local var_418_10 = (arg_415_1.time_ - var_418_7) / var_418_9
				local var_418_11 = Vector3.New(0, 100, 0)

				var_418_6.localPosition = Vector3.Lerp(arg_415_1.var_.moveOldPos1075ui_actor, var_418_11, var_418_10)

				local var_418_12 = manager.ui.mainCamera.transform.position - var_418_6.position

				var_418_6.forward = Vector3.New(var_418_12.x, var_418_12.y, var_418_12.z)

				local var_418_13 = var_418_6.localEulerAngles

				var_418_13.z = 0
				var_418_13.x = 0
				var_418_6.localEulerAngles = var_418_13
			end

			if arg_415_1.time_ >= var_418_7 + var_418_9 and arg_415_1.time_ < var_418_7 + var_418_9 + arg_418_0 then
				var_418_6.localPosition = Vector3.New(0, 100, 0)

				local var_418_14 = manager.ui.mainCamera.transform.position - var_418_6.position

				var_418_6.forward = Vector3.New(var_418_14.x, var_418_14.y, var_418_14.z)

				local var_418_15 = var_418_6.localEulerAngles

				var_418_15.z = 0
				var_418_15.x = 0
				var_418_6.localEulerAngles = var_418_15

				local var_418_16 = GameObjectTools.GetOrAddComponent(var_418_6.gameObject, typeof(DynamicBoneHelper))

				if var_418_16 then
					var_418_16:EnableDynamicBone(true)
				end
			end

			local var_418_17 = 0
			local var_418_18 = 0.675

			if var_418_17 < arg_415_1.time_ and arg_415_1.time_ <= var_418_17 + arg_418_0 then
				arg_415_1.talkMaxDuration = 0
				arg_415_1.dialogCg_.alpha = 1

				arg_415_1.dialog_:SetActive(true)
				SetActive(arg_415_1.leftNameGo_, false)

				arg_415_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_415_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_415_1:RecordName(arg_415_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_415_1.iconTrs_.gameObject, false)
				arg_415_1.callingController_:SetSelectedState("normal")

				local var_418_19 = arg_415_1:GetWordFromCfg(1107505106)
				local var_418_20 = arg_415_1:FormatText(var_418_19.content)

				arg_415_1.text_.text = var_418_20

				LuaForUtil.ClearLinePrefixSymbol(arg_415_1.text_)

				local var_418_21 = 27
				local var_418_22 = utf8.len(var_418_20)
				local var_418_23 = var_418_21 <= 0 and var_418_18 or var_418_18 * (var_418_22 / var_418_21)

				if var_418_23 > 0 and var_418_18 < var_418_23 then
					arg_415_1.talkMaxDuration = var_418_23

					if var_418_23 + var_418_17 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_23 + var_418_17
					end
				end

				arg_415_1.text_.text = var_418_20
				arg_415_1.typewritter.percent = 0

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(false)
				arg_415_1:RecordContent(arg_415_1.text_.text)
			end

			local var_418_24 = math.max(var_418_18, arg_415_1.talkMaxDuration)

			if var_418_17 <= arg_415_1.time_ and arg_415_1.time_ < var_418_17 + var_418_24 then
				arg_415_1.typewritter.percent = (arg_415_1.time_ - var_418_17) / var_418_24

				arg_415_1.typewritter:SetDirty()
			end

			if arg_415_1.time_ >= var_418_17 + var_418_24 and arg_415_1.time_ < var_418_17 + var_418_24 + arg_418_0 then
				arg_415_1.typewritter.percent = 1

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(true)
			end
		end

		arg_415_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_actor",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_415_1:InitPlayNodeList()
	end,
	Play1107505107 = function(arg_419_0, arg_419_1)
		arg_419_1.time_ = 0
		arg_419_1.frameCnt_ = 0
		arg_419_1.state_ = "playing"
		arg_419_1.curTalkId_ = 1107505107
		arg_419_1.duration_ = 8.07

		SetActive(arg_419_1.tipsGo_, false)

		function arg_419_1.onSingleLineFinish_()
			arg_419_1.onSingleLineUpdate_ = nil
			arg_419_1.onSingleLineFinish_ = nil
			arg_419_1.state_ = "waiting"
		end

		function arg_419_1.playNext_(arg_421_0)
			if arg_421_0 == 1 then
				arg_419_0:Play1107505108(arg_419_1)
			end
		end

		function arg_419_1.onSingleLineUpdate_(arg_422_0)
			local var_422_0 = "ST45"

			if arg_419_1.bgs_[var_422_0] == nil then
				local var_422_1 = Object.Instantiate(arg_419_1.paintGo_)

				var_422_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_422_0)
				var_422_1.name = var_422_0
				var_422_1.transform.parent = arg_419_1.stage_.transform
				var_422_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_419_1.bgs_[var_422_0] = var_422_1
			end

			local var_422_2 = 2

			if var_422_2 < arg_419_1.time_ and arg_419_1.time_ <= var_422_2 + arg_422_0 then
				local var_422_3 = manager.ui.mainCamera.transform.localPosition
				local var_422_4 = Vector3.New(0, 0, 10) + Vector3.New(var_422_3.x, var_422_3.y, 0)
				local var_422_5 = arg_419_1.bgs_.ST45

				var_422_5.transform.localPosition = var_422_4
				var_422_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_422_6 = var_422_5:GetComponent("SpriteRenderer")

				if var_422_6 and var_422_6.sprite then
					local var_422_7 = (var_422_5.transform.localPosition - var_422_3).z
					local var_422_8 = manager.ui.mainCameraCom_
					local var_422_9 = 2 * var_422_7 * Mathf.Tan(var_422_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_422_10 = var_422_9 * var_422_8.aspect
					local var_422_11 = var_422_6.sprite.bounds.size.x
					local var_422_12 = var_422_6.sprite.bounds.size.y
					local var_422_13 = var_422_10 / var_422_11
					local var_422_14 = var_422_9 / var_422_12
					local var_422_15 = var_422_14 < var_422_13 and var_422_13 or var_422_14

					var_422_5.transform.localScale = Vector3.New(var_422_15, var_422_15, 0)
				end

				for iter_422_0, iter_422_1 in pairs(arg_419_1.bgs_) do
					if iter_422_0 ~= "ST45" then
						iter_422_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_422_16 = 4

			if var_422_16 < arg_419_1.time_ and arg_419_1.time_ <= var_422_16 + arg_422_0 then
				arg_419_1.allBtn_.enabled = false
			end

			local var_422_17 = 0.3

			if arg_419_1.time_ >= var_422_16 + var_422_17 and arg_419_1.time_ < var_422_16 + var_422_17 + arg_422_0 then
				arg_419_1.allBtn_.enabled = true
			end

			local var_422_18 = 0

			if var_422_18 < arg_419_1.time_ and arg_419_1.time_ <= var_422_18 + arg_422_0 then
				arg_419_1.mask_.enabled = true
				arg_419_1.mask_.raycastTarget = true

				arg_419_1:SetGaussion(false)
			end

			local var_422_19 = 2

			if var_422_18 <= arg_419_1.time_ and arg_419_1.time_ < var_422_18 + var_422_19 then
				local var_422_20 = (arg_419_1.time_ - var_422_18) / var_422_19
				local var_422_21 = Color.New(0, 0, 0)

				var_422_21.a = Mathf.Lerp(0, 1, var_422_20)
				arg_419_1.mask_.color = var_422_21
			end

			if arg_419_1.time_ >= var_422_18 + var_422_19 and arg_419_1.time_ < var_422_18 + var_422_19 + arg_422_0 then
				local var_422_22 = Color.New(0, 0, 0)

				var_422_22.a = 1
				arg_419_1.mask_.color = var_422_22
			end

			local var_422_23 = 2

			if var_422_23 < arg_419_1.time_ and arg_419_1.time_ <= var_422_23 + arg_422_0 then
				arg_419_1.mask_.enabled = true
				arg_419_1.mask_.raycastTarget = true

				arg_419_1:SetGaussion(false)
			end

			local var_422_24 = 2

			if var_422_23 <= arg_419_1.time_ and arg_419_1.time_ < var_422_23 + var_422_24 then
				local var_422_25 = (arg_419_1.time_ - var_422_23) / var_422_24
				local var_422_26 = Color.New(0, 0, 0)

				var_422_26.a = Mathf.Lerp(1, 0, var_422_25)
				arg_419_1.mask_.color = var_422_26
			end

			if arg_419_1.time_ >= var_422_23 + var_422_24 and arg_419_1.time_ < var_422_23 + var_422_24 + arg_422_0 then
				local var_422_27 = Color.New(0, 0, 0)
				local var_422_28 = 0

				arg_419_1.mask_.enabled = false
				var_422_27.a = var_422_28
				arg_419_1.mask_.color = var_422_27
			end

			local var_422_29 = arg_419_1.actors_["1075ui_actor"]
			local var_422_30 = 4

			if var_422_30 < arg_419_1.time_ and arg_419_1.time_ <= var_422_30 + arg_422_0 and not isNil(var_422_29) and arg_419_1.var_.characterEffect1075ui_actor == nil then
				arg_419_1.var_.characterEffect1075ui_actor = var_422_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_422_31 = 0.200000002980232

			if var_422_30 <= arg_419_1.time_ and arg_419_1.time_ < var_422_30 + var_422_31 and not isNil(var_422_29) then
				local var_422_32 = (arg_419_1.time_ - var_422_30) / var_422_31

				if arg_419_1.var_.characterEffect1075ui_actor and not isNil(var_422_29) then
					arg_419_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_419_1.time_ >= var_422_30 + var_422_31 and arg_419_1.time_ < var_422_30 + var_422_31 + arg_422_0 and not isNil(var_422_29) and arg_419_1.var_.characterEffect1075ui_actor then
				arg_419_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			local var_422_33 = 4

			if var_422_33 < arg_419_1.time_ and arg_419_1.time_ <= var_422_33 + arg_422_0 then
				arg_419_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075action/1075action2_1")
			end

			local var_422_34 = 4

			if var_422_34 < arg_419_1.time_ and arg_419_1.time_ <= var_422_34 + arg_422_0 then
				arg_419_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_422_35 = arg_419_1.actors_["1075ui_actor"].transform
			local var_422_36 = 4

			if var_422_36 < arg_419_1.time_ and arg_419_1.time_ <= var_422_36 + arg_422_0 then
				arg_419_1.var_.moveOldPos1075ui_actor = var_422_35.localPosition

				local var_422_37 = GameObjectTools.GetOrAddComponent(var_422_35.gameObject, typeof(DynamicBoneHelper))

				if var_422_37 then
					var_422_37:EnableDynamicBone(false)
				end
			end

			local var_422_38 = 0.001

			if var_422_36 <= arg_419_1.time_ and arg_419_1.time_ < var_422_36 + var_422_38 then
				local var_422_39 = (arg_419_1.time_ - var_422_36) / var_422_38
				local var_422_40 = Vector3.New(0, -1.055, -6.16)

				var_422_35.localPosition = Vector3.Lerp(arg_419_1.var_.moveOldPos1075ui_actor, var_422_40, var_422_39)

				local var_422_41 = manager.ui.mainCamera.transform.position - var_422_35.position

				var_422_35.forward = Vector3.New(var_422_41.x, var_422_41.y, var_422_41.z)

				local var_422_42 = var_422_35.localEulerAngles

				var_422_42.z = 0
				var_422_42.x = 0
				var_422_35.localEulerAngles = var_422_42
			end

			if arg_419_1.time_ >= var_422_36 + var_422_38 and arg_419_1.time_ < var_422_36 + var_422_38 + arg_422_0 then
				var_422_35.localPosition = Vector3.New(0, -1.055, -6.16)

				local var_422_43 = manager.ui.mainCamera.transform.position - var_422_35.position

				var_422_35.forward = Vector3.New(var_422_43.x, var_422_43.y, var_422_43.z)

				local var_422_44 = var_422_35.localEulerAngles

				var_422_44.z = 0
				var_422_44.x = 0
				var_422_35.localEulerAngles = var_422_44

				local var_422_45 = GameObjectTools.GetOrAddComponent(var_422_35.gameObject, typeof(DynamicBoneHelper))

				if var_422_45 then
					var_422_45:EnableDynamicBone(true)
				end
			end

			local var_422_46 = "ST45_blur"

			if arg_419_1.bgs_[var_422_46] == nil then
				local var_422_47 = Object.Instantiate(arg_419_1.blurPaintGo_)
				local var_422_48 = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_422_46)

				var_422_47:GetComponent("SpriteRenderer").sprite = var_422_48
				var_422_47.name = var_422_46
				var_422_47.transform.parent = arg_419_1.stage_.transform
				var_422_47.transform.localPosition = Vector3.New(0, 100, 0)
				arg_419_1.bgs_[var_422_46] = var_422_47
			end

			local var_422_49 = 2
			local var_422_50 = arg_419_1.bgs_[var_422_46]

			if var_422_49 < arg_419_1.time_ and arg_419_1.time_ <= var_422_49 + arg_422_0 then
				local var_422_51 = manager.ui.mainCamera.transform.localPosition
				local var_422_52 = Vector3.New(0, 0, 10) + Vector3.New(var_422_51.x, var_422_51.y, 0)

				var_422_50.transform.localPosition = var_422_52
				var_422_50.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_422_53 = var_422_50:GetComponent("SpriteRenderer")

				if var_422_53 and var_422_53.sprite then
					local var_422_54 = (var_422_50.transform.localPosition - var_422_51).z
					local var_422_55 = manager.ui.mainCameraCom_
					local var_422_56 = 2 * var_422_54 * Mathf.Tan(var_422_55.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_422_57 = var_422_56 * var_422_55.aspect
					local var_422_58 = var_422_53.sprite.bounds.size.x
					local var_422_59 = var_422_53.sprite.bounds.size.y
					local var_422_60 = var_422_57 / var_422_58
					local var_422_61 = var_422_56 / var_422_59
					local var_422_62 = var_422_61 < var_422_60 and var_422_60 or var_422_61

					var_422_50.transform.localScale = Vector3.New(var_422_62, var_422_62, 0)
				end
			end

			local var_422_63 = 1

			if var_422_49 <= arg_419_1.time_ and arg_419_1.time_ < var_422_49 + var_422_63 then
				local var_422_64 = (arg_419_1.time_ - var_422_49) / var_422_63
				local var_422_65 = Color.New(1, 1, 1)

				var_422_65.a = Mathf.Lerp(0, 1, var_422_64)

				var_422_50:GetComponent("SpriteRenderer").material:SetColor("_Color", var_422_65)
			end

			if arg_419_1.frameCnt_ <= 1 then
				arg_419_1.dialog_:SetActive(false)
			end

			local var_422_66 = 4
			local var_422_67 = 0.475

			if var_422_66 < arg_419_1.time_ and arg_419_1.time_ <= var_422_66 + arg_422_0 then
				arg_419_1.talkMaxDuration = 0

				arg_419_1.dialog_:SetActive(true)

				arg_419_1.dialogCg_.alpha = 0

				local var_422_68 = LeanTween.value(arg_419_1.dialog_, 0, 1, 0.3)

				var_422_68:setOnUpdate(LuaHelper.FloatAction(function(arg_423_0)
					arg_419_1.dialogCg_.alpha = arg_423_0
				end))
				var_422_68:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_419_1.dialog_)
					var_422_68:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_419_1.duration_ = arg_419_1.duration_ + 0.3

				SetActive(arg_419_1.leftNameGo_, true)

				local var_422_69 = arg_419_1:FormatText(StoryNameCfg[381].name)

				arg_419_1.leftNameTxt_.text = var_422_69

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_419_1.leftNameTxt_.transform)

				arg_419_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_419_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_419_1:RecordName(arg_419_1.leftNameTxt_.text)
				SetActive(arg_419_1.iconTrs_.gameObject, false)
				arg_419_1.callingController_:SetSelectedState("normal")

				local var_422_70 = arg_419_1:GetWordFromCfg(1107505107)
				local var_422_71 = arg_419_1:FormatText(var_422_70.content)

				arg_419_1.text_.text = var_422_71

				LuaForUtil.ClearLinePrefixSymbol(arg_419_1.text_)

				local var_422_72 = 19
				local var_422_73 = utf8.len(var_422_71)
				local var_422_74 = var_422_72 <= 0 and var_422_67 or var_422_67 * (var_422_73 / var_422_72)

				if var_422_74 > 0 and var_422_67 < var_422_74 then
					arg_419_1.talkMaxDuration = var_422_74
					var_422_66 = var_422_66 + 0.3

					if var_422_74 + var_422_66 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_74 + var_422_66
					end
				end

				arg_419_1.text_.text = var_422_71
				arg_419_1.typewritter.percent = 0

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107505", "1107505107", "story_v_side_new_1107505.awb") ~= 0 then
					local var_422_75 = manager.audio:GetVoiceLength("story_v_side_new_1107505", "1107505107", "story_v_side_new_1107505.awb") / 1000

					if var_422_75 + var_422_66 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_75 + var_422_66
					end

					if var_422_70.prefab_name ~= "" and arg_419_1.actors_[var_422_70.prefab_name] ~= nil then
						local var_422_76 = LuaForUtil.PlayVoiceWithCriLipsync(arg_419_1.actors_[var_422_70.prefab_name].transform, "story_v_side_new_1107505", "1107505107", "story_v_side_new_1107505.awb")

						arg_419_1:RecordAudio("1107505107", var_422_76)
						arg_419_1:RecordAudio("1107505107", var_422_76)
					else
						arg_419_1:AudioAction("play", "voice", "story_v_side_new_1107505", "1107505107", "story_v_side_new_1107505.awb")
					end

					arg_419_1:RecordHistoryTalkVoice("story_v_side_new_1107505", "1107505107", "story_v_side_new_1107505.awb")
				end

				arg_419_1:RecordContent(arg_419_1.text_.text)
			end

			local var_422_77 = var_422_66 + 0.3
			local var_422_78 = math.max(var_422_67, arg_419_1.talkMaxDuration)

			if var_422_77 <= arg_419_1.time_ and arg_419_1.time_ < var_422_77 + var_422_78 then
				arg_419_1.typewritter.percent = (arg_419_1.time_ - var_422_77) / var_422_78

				arg_419_1.typewritter:SetDirty()
			end

			if arg_419_1.time_ >= var_422_77 + var_422_78 and arg_419_1.time_ < var_422_77 + var_422_78 + arg_422_0 then
				arg_419_1.typewritter.percent = 1

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(true)
			end
		end

		arg_419_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_actor",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_419_1:InitPlayNodeList()
	end,
	Play1107505108 = function(arg_425_0, arg_425_1)
		arg_425_1.time_ = 0
		arg_425_1.frameCnt_ = 0
		arg_425_1.state_ = "playing"
		arg_425_1.curTalkId_ = 1107505108
		arg_425_1.duration_ = 5

		SetActive(arg_425_1.tipsGo_, false)

		function arg_425_1.onSingleLineFinish_()
			arg_425_1.onSingleLineUpdate_ = nil
			arg_425_1.onSingleLineFinish_ = nil
			arg_425_1.state_ = "waiting"
		end

		function arg_425_1.playNext_(arg_427_0)
			if arg_427_0 == 1 then
				arg_425_0:Play1107505109(arg_425_1)
			end
		end

		function arg_425_1.onSingleLineUpdate_(arg_428_0)
			local var_428_0 = arg_425_1.actors_["1075ui_actor"].transform
			local var_428_1 = 0

			if var_428_1 < arg_425_1.time_ and arg_425_1.time_ <= var_428_1 + arg_428_0 then
				arg_425_1.var_.moveOldPos1075ui_actor = var_428_0.localPosition

				local var_428_2 = GameObjectTools.GetOrAddComponent(var_428_0.gameObject, typeof(DynamicBoneHelper))

				if var_428_2 then
					var_428_2:EnableDynamicBone(false)
				end
			end

			local var_428_3 = 0.001

			if var_428_1 <= arg_425_1.time_ and arg_425_1.time_ < var_428_1 + var_428_3 then
				local var_428_4 = (arg_425_1.time_ - var_428_1) / var_428_3
				local var_428_5 = Vector3.New(0, 100, 0)

				var_428_0.localPosition = Vector3.Lerp(arg_425_1.var_.moveOldPos1075ui_actor, var_428_5, var_428_4)

				local var_428_6 = manager.ui.mainCamera.transform.position - var_428_0.position

				var_428_0.forward = Vector3.New(var_428_6.x, var_428_6.y, var_428_6.z)

				local var_428_7 = var_428_0.localEulerAngles

				var_428_7.z = 0
				var_428_7.x = 0
				var_428_0.localEulerAngles = var_428_7
			end

			if arg_425_1.time_ >= var_428_1 + var_428_3 and arg_425_1.time_ < var_428_1 + var_428_3 + arg_428_0 then
				var_428_0.localPosition = Vector3.New(0, 100, 0)

				local var_428_8 = manager.ui.mainCamera.transform.position - var_428_0.position

				var_428_0.forward = Vector3.New(var_428_8.x, var_428_8.y, var_428_8.z)

				local var_428_9 = var_428_0.localEulerAngles

				var_428_9.z = 0
				var_428_9.x = 0
				var_428_0.localEulerAngles = var_428_9

				local var_428_10 = GameObjectTools.GetOrAddComponent(var_428_0.gameObject, typeof(DynamicBoneHelper))

				if var_428_10 then
					var_428_10:EnableDynamicBone(true)
				end
			end

			local var_428_11 = arg_425_1.actors_["1075ui_actor"]
			local var_428_12 = 0

			if var_428_12 < arg_425_1.time_ and arg_425_1.time_ <= var_428_12 + arg_428_0 and not isNil(var_428_11) and arg_425_1.var_.characterEffect1075ui_actor == nil then
				arg_425_1.var_.characterEffect1075ui_actor = var_428_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_428_13 = 0.200000002980232

			if var_428_12 <= arg_425_1.time_ and arg_425_1.time_ < var_428_12 + var_428_13 and not isNil(var_428_11) then
				local var_428_14 = (arg_425_1.time_ - var_428_12) / var_428_13

				if arg_425_1.var_.characterEffect1075ui_actor and not isNil(var_428_11) then
					local var_428_15 = Mathf.Lerp(0, 0.5, var_428_14)

					arg_425_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_425_1.var_.characterEffect1075ui_actor.fillRatio = var_428_15
				end
			end

			if arg_425_1.time_ >= var_428_12 + var_428_13 and arg_425_1.time_ < var_428_12 + var_428_13 + arg_428_0 and not isNil(var_428_11) and arg_425_1.var_.characterEffect1075ui_actor then
				local var_428_16 = 0.5

				arg_425_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_425_1.var_.characterEffect1075ui_actor.fillRatio = var_428_16
			end

			local var_428_17 = 0
			local var_428_18 = 0.75

			if var_428_17 < arg_425_1.time_ and arg_425_1.time_ <= var_428_17 + arg_428_0 then
				arg_425_1.talkMaxDuration = 0
				arg_425_1.dialogCg_.alpha = 1

				arg_425_1.dialog_:SetActive(true)
				SetActive(arg_425_1.leftNameGo_, false)

				arg_425_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_425_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_425_1:RecordName(arg_425_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_425_1.iconTrs_.gameObject, false)
				arg_425_1.callingController_:SetSelectedState("normal")

				local var_428_19 = arg_425_1:GetWordFromCfg(1107505108)
				local var_428_20 = arg_425_1:FormatText(var_428_19.content)

				arg_425_1.text_.text = var_428_20

				LuaForUtil.ClearLinePrefixSymbol(arg_425_1.text_)

				local var_428_21 = 30
				local var_428_22 = utf8.len(var_428_20)
				local var_428_23 = var_428_21 <= 0 and var_428_18 or var_428_18 * (var_428_22 / var_428_21)

				if var_428_23 > 0 and var_428_18 < var_428_23 then
					arg_425_1.talkMaxDuration = var_428_23

					if var_428_23 + var_428_17 > arg_425_1.duration_ then
						arg_425_1.duration_ = var_428_23 + var_428_17
					end
				end

				arg_425_1.text_.text = var_428_20
				arg_425_1.typewritter.percent = 0

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(false)
				arg_425_1:RecordContent(arg_425_1.text_.text)
			end

			local var_428_24 = math.max(var_428_18, arg_425_1.talkMaxDuration)

			if var_428_17 <= arg_425_1.time_ and arg_425_1.time_ < var_428_17 + var_428_24 then
				arg_425_1.typewritter.percent = (arg_425_1.time_ - var_428_17) / var_428_24

				arg_425_1.typewritter:SetDirty()
			end

			if arg_425_1.time_ >= var_428_17 + var_428_24 and arg_425_1.time_ < var_428_17 + var_428_24 + arg_428_0 then
				arg_425_1.typewritter.percent = 1

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(true)
			end
		end

		arg_425_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_actor",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_425_1:InitPlayNodeList()
	end,
	Play1107505109 = function(arg_429_0, arg_429_1)
		arg_429_1.time_ = 0
		arg_429_1.frameCnt_ = 0
		arg_429_1.state_ = "playing"
		arg_429_1.curTalkId_ = 1107505109
		arg_429_1.duration_ = 5

		SetActive(arg_429_1.tipsGo_, false)

		function arg_429_1.onSingleLineFinish_()
			arg_429_1.onSingleLineUpdate_ = nil
			arg_429_1.onSingleLineFinish_ = nil
			arg_429_1.state_ = "waiting"
		end

		function arg_429_1.playNext_(arg_431_0)
			if arg_431_0 == 1 then
				arg_429_0:Play1107505110(arg_429_1)
			end
		end

		function arg_429_1.onSingleLineUpdate_(arg_432_0)
			local var_432_0 = 0
			local var_432_1 = 0.775

			if var_432_0 < arg_429_1.time_ and arg_429_1.time_ <= var_432_0 + arg_432_0 then
				arg_429_1.talkMaxDuration = 0
				arg_429_1.dialogCg_.alpha = 1

				arg_429_1.dialog_:SetActive(true)
				SetActive(arg_429_1.leftNameGo_, false)

				arg_429_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_429_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_429_1:RecordName(arg_429_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_429_1.iconTrs_.gameObject, false)
				arg_429_1.callingController_:SetSelectedState("normal")

				local var_432_2 = arg_429_1:GetWordFromCfg(1107505109)
				local var_432_3 = arg_429_1:FormatText(var_432_2.content)

				arg_429_1.text_.text = var_432_3

				LuaForUtil.ClearLinePrefixSymbol(arg_429_1.text_)

				local var_432_4 = 31
				local var_432_5 = utf8.len(var_432_3)
				local var_432_6 = var_432_4 <= 0 and var_432_1 or var_432_1 * (var_432_5 / var_432_4)

				if var_432_6 > 0 and var_432_1 < var_432_6 then
					arg_429_1.talkMaxDuration = var_432_6

					if var_432_6 + var_432_0 > arg_429_1.duration_ then
						arg_429_1.duration_ = var_432_6 + var_432_0
					end
				end

				arg_429_1.text_.text = var_432_3
				arg_429_1.typewritter.percent = 0

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(false)
				arg_429_1:RecordContent(arg_429_1.text_.text)
			end

			local var_432_7 = math.max(var_432_1, arg_429_1.talkMaxDuration)

			if var_432_0 <= arg_429_1.time_ and arg_429_1.time_ < var_432_0 + var_432_7 then
				arg_429_1.typewritter.percent = (arg_429_1.time_ - var_432_0) / var_432_7

				arg_429_1.typewritter:SetDirty()
			end

			if arg_429_1.time_ >= var_432_0 + var_432_7 and arg_429_1.time_ < var_432_0 + var_432_7 + arg_432_0 then
				arg_429_1.typewritter.percent = 1

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(true)
			end
		end

		arg_429_1.nodeConfigList_ = {}

		arg_429_1:InitPlayNodeList()
	end,
	Play1107505110 = function(arg_433_0, arg_433_1)
		arg_433_1.time_ = 0
		arg_433_1.frameCnt_ = 0
		arg_433_1.state_ = "playing"
		arg_433_1.curTalkId_ = 1107505110
		arg_433_1.duration_ = 5

		SetActive(arg_433_1.tipsGo_, false)

		function arg_433_1.onSingleLineFinish_()
			arg_433_1.onSingleLineUpdate_ = nil
			arg_433_1.onSingleLineFinish_ = nil
			arg_433_1.state_ = "waiting"
		end

		function arg_433_1.playNext_(arg_435_0)
			if arg_435_0 == 1 then
				arg_433_0:Play1107505111(arg_433_1)
			end
		end

		function arg_433_1.onSingleLineUpdate_(arg_436_0)
			local var_436_0 = arg_433_1.actors_["1075ui_actor"].transform
			local var_436_1 = 0

			if var_436_1 < arg_433_1.time_ and arg_433_1.time_ <= var_436_1 + arg_436_0 then
				arg_433_1.var_.moveOldPos1075ui_actor = var_436_0.localPosition

				local var_436_2 = GameObjectTools.GetOrAddComponent(var_436_0.gameObject, typeof(DynamicBoneHelper))

				if var_436_2 then
					var_436_2:EnableDynamicBone(false)
				end
			end

			local var_436_3 = 0.001

			if var_436_1 <= arg_433_1.time_ and arg_433_1.time_ < var_436_1 + var_436_3 then
				local var_436_4 = (arg_433_1.time_ - var_436_1) / var_436_3
				local var_436_5 = Vector3.New(0, -1.055, -6.16)

				var_436_0.localPosition = Vector3.Lerp(arg_433_1.var_.moveOldPos1075ui_actor, var_436_5, var_436_4)

				local var_436_6 = manager.ui.mainCamera.transform.position - var_436_0.position

				var_436_0.forward = Vector3.New(var_436_6.x, var_436_6.y, var_436_6.z)

				local var_436_7 = var_436_0.localEulerAngles

				var_436_7.z = 0
				var_436_7.x = 0
				var_436_0.localEulerAngles = var_436_7
			end

			if arg_433_1.time_ >= var_436_1 + var_436_3 and arg_433_1.time_ < var_436_1 + var_436_3 + arg_436_0 then
				var_436_0.localPosition = Vector3.New(0, -1.055, -6.16)

				local var_436_8 = manager.ui.mainCamera.transform.position - var_436_0.position

				var_436_0.forward = Vector3.New(var_436_8.x, var_436_8.y, var_436_8.z)

				local var_436_9 = var_436_0.localEulerAngles

				var_436_9.z = 0
				var_436_9.x = 0
				var_436_0.localEulerAngles = var_436_9

				local var_436_10 = GameObjectTools.GetOrAddComponent(var_436_0.gameObject, typeof(DynamicBoneHelper))

				if var_436_10 then
					var_436_10:EnableDynamicBone(true)
				end
			end

			local var_436_11 = arg_433_1.actors_["1075ui_actor"]
			local var_436_12 = 0

			if var_436_12 < arg_433_1.time_ and arg_433_1.time_ <= var_436_12 + arg_436_0 and not isNil(var_436_11) and arg_433_1.var_.characterEffect1075ui_actor == nil then
				arg_433_1.var_.characterEffect1075ui_actor = var_436_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_436_13 = 0.200000002980232

			if var_436_12 <= arg_433_1.time_ and arg_433_1.time_ < var_436_12 + var_436_13 and not isNil(var_436_11) then
				local var_436_14 = (arg_433_1.time_ - var_436_12) / var_436_13

				if arg_433_1.var_.characterEffect1075ui_actor and not isNil(var_436_11) then
					arg_433_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_433_1.time_ >= var_436_12 + var_436_13 and arg_433_1.time_ < var_436_12 + var_436_13 + arg_436_0 and not isNil(var_436_11) and arg_433_1.var_.characterEffect1075ui_actor then
				arg_433_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			local var_436_15 = 0

			if var_436_15 < arg_433_1.time_ and arg_433_1.time_ <= var_436_15 + arg_436_0 then
				arg_433_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075actionlink/1075action423")
			end

			local var_436_16 = 0

			if var_436_16 < arg_433_1.time_ and arg_433_1.time_ <= var_436_16 + arg_436_0 then
				arg_433_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_436_17 = 0
			local var_436_18 = 0.375

			if var_436_17 < arg_433_1.time_ and arg_433_1.time_ <= var_436_17 + arg_436_0 then
				arg_433_1.talkMaxDuration = 0
				arg_433_1.dialogCg_.alpha = 1

				arg_433_1.dialog_:SetActive(true)
				SetActive(arg_433_1.leftNameGo_, true)

				local var_436_19 = arg_433_1:FormatText(StoryNameCfg[381].name)

				arg_433_1.leftNameTxt_.text = var_436_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_433_1.leftNameTxt_.transform)

				arg_433_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_433_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_433_1:RecordName(arg_433_1.leftNameTxt_.text)
				SetActive(arg_433_1.iconTrs_.gameObject, false)
				arg_433_1.callingController_:SetSelectedState("normal")

				local var_436_20 = arg_433_1:GetWordFromCfg(1107505110)
				local var_436_21 = arg_433_1:FormatText(var_436_20.content)

				arg_433_1.text_.text = var_436_21

				LuaForUtil.ClearLinePrefixSymbol(arg_433_1.text_)

				local var_436_22 = 15
				local var_436_23 = utf8.len(var_436_21)
				local var_436_24 = var_436_22 <= 0 and var_436_18 or var_436_18 * (var_436_23 / var_436_22)

				if var_436_24 > 0 and var_436_18 < var_436_24 then
					arg_433_1.talkMaxDuration = var_436_24

					if var_436_24 + var_436_17 > arg_433_1.duration_ then
						arg_433_1.duration_ = var_436_24 + var_436_17
					end
				end

				arg_433_1.text_.text = var_436_21
				arg_433_1.typewritter.percent = 0

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107505", "1107505110", "story_v_side_new_1107505.awb") ~= 0 then
					local var_436_25 = manager.audio:GetVoiceLength("story_v_side_new_1107505", "1107505110", "story_v_side_new_1107505.awb") / 1000

					if var_436_25 + var_436_17 > arg_433_1.duration_ then
						arg_433_1.duration_ = var_436_25 + var_436_17
					end

					if var_436_20.prefab_name ~= "" and arg_433_1.actors_[var_436_20.prefab_name] ~= nil then
						local var_436_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_433_1.actors_[var_436_20.prefab_name].transform, "story_v_side_new_1107505", "1107505110", "story_v_side_new_1107505.awb")

						arg_433_1:RecordAudio("1107505110", var_436_26)
						arg_433_1:RecordAudio("1107505110", var_436_26)
					else
						arg_433_1:AudioAction("play", "voice", "story_v_side_new_1107505", "1107505110", "story_v_side_new_1107505.awb")
					end

					arg_433_1:RecordHistoryTalkVoice("story_v_side_new_1107505", "1107505110", "story_v_side_new_1107505.awb")
				end

				arg_433_1:RecordContent(arg_433_1.text_.text)
			end

			local var_436_27 = math.max(var_436_18, arg_433_1.talkMaxDuration)

			if var_436_17 <= arg_433_1.time_ and arg_433_1.time_ < var_436_17 + var_436_27 then
				arg_433_1.typewritter.percent = (arg_433_1.time_ - var_436_17) / var_436_27

				arg_433_1.typewritter:SetDirty()
			end

			if arg_433_1.time_ >= var_436_17 + var_436_27 and arg_433_1.time_ < var_436_17 + var_436_27 + arg_436_0 then
				arg_433_1.typewritter.percent = 1

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(true)
			end
		end

		arg_433_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_actor",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_433_1:InitPlayNodeList()
	end,
	Play1107505111 = function(arg_437_0, arg_437_1)
		arg_437_1.time_ = 0
		arg_437_1.frameCnt_ = 0
		arg_437_1.state_ = "playing"
		arg_437_1.curTalkId_ = 1107505111
		arg_437_1.duration_ = 7.13

		SetActive(arg_437_1.tipsGo_, false)

		function arg_437_1.onSingleLineFinish_()
			arg_437_1.onSingleLineUpdate_ = nil
			arg_437_1.onSingleLineFinish_ = nil
			arg_437_1.state_ = "waiting"
		end

		function arg_437_1.playNext_(arg_439_0)
			if arg_439_0 == 1 then
				arg_437_0:Play1107505112(arg_437_1)
			end
		end

		function arg_437_1.onSingleLineUpdate_(arg_440_0)
			local var_440_0 = 0
			local var_440_1 = 0.7

			if var_440_0 < arg_437_1.time_ and arg_437_1.time_ <= var_440_0 + arg_440_0 then
				arg_437_1.talkMaxDuration = 0
				arg_437_1.dialogCg_.alpha = 1

				arg_437_1.dialog_:SetActive(true)
				SetActive(arg_437_1.leftNameGo_, true)

				local var_440_2 = arg_437_1:FormatText(StoryNameCfg[381].name)

				arg_437_1.leftNameTxt_.text = var_440_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_437_1.leftNameTxt_.transform)

				arg_437_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_437_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_437_1:RecordName(arg_437_1.leftNameTxt_.text)
				SetActive(arg_437_1.iconTrs_.gameObject, false)
				arg_437_1.callingController_:SetSelectedState("normal")

				local var_440_3 = arg_437_1:GetWordFromCfg(1107505111)
				local var_440_4 = arg_437_1:FormatText(var_440_3.content)

				arg_437_1.text_.text = var_440_4

				LuaForUtil.ClearLinePrefixSymbol(arg_437_1.text_)

				local var_440_5 = 28
				local var_440_6 = utf8.len(var_440_4)
				local var_440_7 = var_440_5 <= 0 and var_440_1 or var_440_1 * (var_440_6 / var_440_5)

				if var_440_7 > 0 and var_440_1 < var_440_7 then
					arg_437_1.talkMaxDuration = var_440_7

					if var_440_7 + var_440_0 > arg_437_1.duration_ then
						arg_437_1.duration_ = var_440_7 + var_440_0
					end
				end

				arg_437_1.text_.text = var_440_4
				arg_437_1.typewritter.percent = 0

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107505", "1107505111", "story_v_side_new_1107505.awb") ~= 0 then
					local var_440_8 = manager.audio:GetVoiceLength("story_v_side_new_1107505", "1107505111", "story_v_side_new_1107505.awb") / 1000

					if var_440_8 + var_440_0 > arg_437_1.duration_ then
						arg_437_1.duration_ = var_440_8 + var_440_0
					end

					if var_440_3.prefab_name ~= "" and arg_437_1.actors_[var_440_3.prefab_name] ~= nil then
						local var_440_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_437_1.actors_[var_440_3.prefab_name].transform, "story_v_side_new_1107505", "1107505111", "story_v_side_new_1107505.awb")

						arg_437_1:RecordAudio("1107505111", var_440_9)
						arg_437_1:RecordAudio("1107505111", var_440_9)
					else
						arg_437_1:AudioAction("play", "voice", "story_v_side_new_1107505", "1107505111", "story_v_side_new_1107505.awb")
					end

					arg_437_1:RecordHistoryTalkVoice("story_v_side_new_1107505", "1107505111", "story_v_side_new_1107505.awb")
				end

				arg_437_1:RecordContent(arg_437_1.text_.text)
			end

			local var_440_10 = math.max(var_440_1, arg_437_1.talkMaxDuration)

			if var_440_0 <= arg_437_1.time_ and arg_437_1.time_ < var_440_0 + var_440_10 then
				arg_437_1.typewritter.percent = (arg_437_1.time_ - var_440_0) / var_440_10

				arg_437_1.typewritter:SetDirty()
			end

			if arg_437_1.time_ >= var_440_0 + var_440_10 and arg_437_1.time_ < var_440_0 + var_440_10 + arg_440_0 then
				arg_437_1.typewritter.percent = 1

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(true)
			end
		end

		arg_437_1.nodeConfigList_ = {}

		arg_437_1:InitPlayNodeList()
	end,
	Play1107505112 = function(arg_441_0, arg_441_1)
		arg_441_1.time_ = 0
		arg_441_1.frameCnt_ = 0
		arg_441_1.state_ = "playing"
		arg_441_1.curTalkId_ = 1107505112
		arg_441_1.duration_ = 5

		SetActive(arg_441_1.tipsGo_, false)

		function arg_441_1.onSingleLineFinish_()
			arg_441_1.onSingleLineUpdate_ = nil
			arg_441_1.onSingleLineFinish_ = nil
			arg_441_1.state_ = "waiting"
		end

		function arg_441_1.playNext_(arg_443_0)
			if arg_443_0 == 1 then
				arg_441_0:Play1107505113(arg_441_1)
			end
		end

		function arg_441_1.onSingleLineUpdate_(arg_444_0)
			local var_444_0 = arg_441_1.actors_["1075ui_actor"].transform
			local var_444_1 = 0

			if var_444_1 < arg_441_1.time_ and arg_441_1.time_ <= var_444_1 + arg_444_0 then
				arg_441_1.var_.moveOldPos1075ui_actor = var_444_0.localPosition

				local var_444_2 = GameObjectTools.GetOrAddComponent(var_444_0.gameObject, typeof(DynamicBoneHelper))

				if var_444_2 then
					var_444_2:EnableDynamicBone(false)
				end
			end

			local var_444_3 = 0.001

			if var_444_1 <= arg_441_1.time_ and arg_441_1.time_ < var_444_1 + var_444_3 then
				local var_444_4 = (arg_441_1.time_ - var_444_1) / var_444_3
				local var_444_5 = Vector3.New(0, 100, 0)

				var_444_0.localPosition = Vector3.Lerp(arg_441_1.var_.moveOldPos1075ui_actor, var_444_5, var_444_4)

				local var_444_6 = manager.ui.mainCamera.transform.position - var_444_0.position

				var_444_0.forward = Vector3.New(var_444_6.x, var_444_6.y, var_444_6.z)

				local var_444_7 = var_444_0.localEulerAngles

				var_444_7.z = 0
				var_444_7.x = 0
				var_444_0.localEulerAngles = var_444_7
			end

			if arg_441_1.time_ >= var_444_1 + var_444_3 and arg_441_1.time_ < var_444_1 + var_444_3 + arg_444_0 then
				var_444_0.localPosition = Vector3.New(0, 100, 0)

				local var_444_8 = manager.ui.mainCamera.transform.position - var_444_0.position

				var_444_0.forward = Vector3.New(var_444_8.x, var_444_8.y, var_444_8.z)

				local var_444_9 = var_444_0.localEulerAngles

				var_444_9.z = 0
				var_444_9.x = 0
				var_444_0.localEulerAngles = var_444_9

				local var_444_10 = GameObjectTools.GetOrAddComponent(var_444_0.gameObject, typeof(DynamicBoneHelper))

				if var_444_10 then
					var_444_10:EnableDynamicBone(true)
				end
			end

			local var_444_11 = arg_441_1.actors_["1075ui_actor"]
			local var_444_12 = 0

			if var_444_12 < arg_441_1.time_ and arg_441_1.time_ <= var_444_12 + arg_444_0 and not isNil(var_444_11) and arg_441_1.var_.characterEffect1075ui_actor == nil then
				arg_441_1.var_.characterEffect1075ui_actor = var_444_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_444_13 = 0.200000002980232

			if var_444_12 <= arg_441_1.time_ and arg_441_1.time_ < var_444_12 + var_444_13 and not isNil(var_444_11) then
				local var_444_14 = (arg_441_1.time_ - var_444_12) / var_444_13

				if arg_441_1.var_.characterEffect1075ui_actor and not isNil(var_444_11) then
					local var_444_15 = Mathf.Lerp(0, 0.5, var_444_14)

					arg_441_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_441_1.var_.characterEffect1075ui_actor.fillRatio = var_444_15
				end
			end

			if arg_441_1.time_ >= var_444_12 + var_444_13 and arg_441_1.time_ < var_444_12 + var_444_13 + arg_444_0 and not isNil(var_444_11) and arg_441_1.var_.characterEffect1075ui_actor then
				local var_444_16 = 0.5

				arg_441_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_441_1.var_.characterEffect1075ui_actor.fillRatio = var_444_16
			end

			local var_444_17 = 0
			local var_444_18 = 1

			if var_444_17 < arg_441_1.time_ and arg_441_1.time_ <= var_444_17 + arg_444_0 then
				arg_441_1.talkMaxDuration = 0
				arg_441_1.dialogCg_.alpha = 1

				arg_441_1.dialog_:SetActive(true)
				SetActive(arg_441_1.leftNameGo_, false)

				arg_441_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_441_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_441_1:RecordName(arg_441_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_441_1.iconTrs_.gameObject, false)
				arg_441_1.callingController_:SetSelectedState("normal")

				local var_444_19 = arg_441_1:GetWordFromCfg(1107505112)
				local var_444_20 = arg_441_1:FormatText(var_444_19.content)

				arg_441_1.text_.text = var_444_20

				LuaForUtil.ClearLinePrefixSymbol(arg_441_1.text_)

				local var_444_21 = 40
				local var_444_22 = utf8.len(var_444_20)
				local var_444_23 = var_444_21 <= 0 and var_444_18 or var_444_18 * (var_444_22 / var_444_21)

				if var_444_23 > 0 and var_444_18 < var_444_23 then
					arg_441_1.talkMaxDuration = var_444_23

					if var_444_23 + var_444_17 > arg_441_1.duration_ then
						arg_441_1.duration_ = var_444_23 + var_444_17
					end
				end

				arg_441_1.text_.text = var_444_20
				arg_441_1.typewritter.percent = 0

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(false)
				arg_441_1:RecordContent(arg_441_1.text_.text)
			end

			local var_444_24 = math.max(var_444_18, arg_441_1.talkMaxDuration)

			if var_444_17 <= arg_441_1.time_ and arg_441_1.time_ < var_444_17 + var_444_24 then
				arg_441_1.typewritter.percent = (arg_441_1.time_ - var_444_17) / var_444_24

				arg_441_1.typewritter:SetDirty()
			end

			if arg_441_1.time_ >= var_444_17 + var_444_24 and arg_441_1.time_ < var_444_17 + var_444_24 + arg_444_0 then
				arg_441_1.typewritter.percent = 1

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(true)
			end
		end

		arg_441_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_actor",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_441_1:InitPlayNodeList()
	end,
	Play1107505113 = function(arg_445_0, arg_445_1)
		arg_445_1.time_ = 0
		arg_445_1.frameCnt_ = 0
		arg_445_1.state_ = "playing"
		arg_445_1.curTalkId_ = 1107505113
		arg_445_1.duration_ = 3.63

		SetActive(arg_445_1.tipsGo_, false)

		function arg_445_1.onSingleLineFinish_()
			arg_445_1.onSingleLineUpdate_ = nil
			arg_445_1.onSingleLineFinish_ = nil
			arg_445_1.state_ = "waiting"
		end

		function arg_445_1.playNext_(arg_447_0)
			if arg_447_0 == 1 then
				arg_445_0:Play1107505114(arg_445_1)
			end
		end

		function arg_445_1.onSingleLineUpdate_(arg_448_0)
			local var_448_0 = arg_445_1.actors_["1075ui_actor"].transform
			local var_448_1 = 0

			if var_448_1 < arg_445_1.time_ and arg_445_1.time_ <= var_448_1 + arg_448_0 then
				arg_445_1.var_.moveOldPos1075ui_actor = var_448_0.localPosition

				local var_448_2 = GameObjectTools.GetOrAddComponent(var_448_0.gameObject, typeof(DynamicBoneHelper))

				if var_448_2 then
					var_448_2:EnableDynamicBone(false)
				end
			end

			local var_448_3 = 0.001

			if var_448_1 <= arg_445_1.time_ and arg_445_1.time_ < var_448_1 + var_448_3 then
				local var_448_4 = (arg_445_1.time_ - var_448_1) / var_448_3
				local var_448_5 = Vector3.New(0, -1.055, -6.16)

				var_448_0.localPosition = Vector3.Lerp(arg_445_1.var_.moveOldPos1075ui_actor, var_448_5, var_448_4)

				local var_448_6 = manager.ui.mainCamera.transform.position - var_448_0.position

				var_448_0.forward = Vector3.New(var_448_6.x, var_448_6.y, var_448_6.z)

				local var_448_7 = var_448_0.localEulerAngles

				var_448_7.z = 0
				var_448_7.x = 0
				var_448_0.localEulerAngles = var_448_7
			end

			if arg_445_1.time_ >= var_448_1 + var_448_3 and arg_445_1.time_ < var_448_1 + var_448_3 + arg_448_0 then
				var_448_0.localPosition = Vector3.New(0, -1.055, -6.16)

				local var_448_8 = manager.ui.mainCamera.transform.position - var_448_0.position

				var_448_0.forward = Vector3.New(var_448_8.x, var_448_8.y, var_448_8.z)

				local var_448_9 = var_448_0.localEulerAngles

				var_448_9.z = 0
				var_448_9.x = 0
				var_448_0.localEulerAngles = var_448_9

				local var_448_10 = GameObjectTools.GetOrAddComponent(var_448_0.gameObject, typeof(DynamicBoneHelper))

				if var_448_10 then
					var_448_10:EnableDynamicBone(true)
				end
			end

			local var_448_11 = arg_445_1.actors_["1075ui_actor"]
			local var_448_12 = 0

			if var_448_12 < arg_445_1.time_ and arg_445_1.time_ <= var_448_12 + arg_448_0 and not isNil(var_448_11) and arg_445_1.var_.characterEffect1075ui_actor == nil then
				arg_445_1.var_.characterEffect1075ui_actor = var_448_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_448_13 = 0.200000002980232

			if var_448_12 <= arg_445_1.time_ and arg_445_1.time_ < var_448_12 + var_448_13 and not isNil(var_448_11) then
				local var_448_14 = (arg_445_1.time_ - var_448_12) / var_448_13

				if arg_445_1.var_.characterEffect1075ui_actor and not isNil(var_448_11) then
					arg_445_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_445_1.time_ >= var_448_12 + var_448_13 and arg_445_1.time_ < var_448_12 + var_448_13 + arg_448_0 and not isNil(var_448_11) and arg_445_1.var_.characterEffect1075ui_actor then
				arg_445_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			local var_448_15 = 0

			if var_448_15 < arg_445_1.time_ and arg_445_1.time_ <= var_448_15 + arg_448_0 then
				arg_445_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075actionlink/1075action434")
			end

			local var_448_16 = 0

			if var_448_16 < arg_445_1.time_ and arg_445_1.time_ <= var_448_16 + arg_448_0 then
				arg_445_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_448_17 = 0
			local var_448_18 = 0.25

			if var_448_17 < arg_445_1.time_ and arg_445_1.time_ <= var_448_17 + arg_448_0 then
				arg_445_1.talkMaxDuration = 0
				arg_445_1.dialogCg_.alpha = 1

				arg_445_1.dialog_:SetActive(true)
				SetActive(arg_445_1.leftNameGo_, true)

				local var_448_19 = arg_445_1:FormatText(StoryNameCfg[381].name)

				arg_445_1.leftNameTxt_.text = var_448_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_445_1.leftNameTxt_.transform)

				arg_445_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_445_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_445_1:RecordName(arg_445_1.leftNameTxt_.text)
				SetActive(arg_445_1.iconTrs_.gameObject, false)
				arg_445_1.callingController_:SetSelectedState("normal")

				local var_448_20 = arg_445_1:GetWordFromCfg(1107505113)
				local var_448_21 = arg_445_1:FormatText(var_448_20.content)

				arg_445_1.text_.text = var_448_21

				LuaForUtil.ClearLinePrefixSymbol(arg_445_1.text_)

				local var_448_22 = 15
				local var_448_23 = utf8.len(var_448_21)
				local var_448_24 = var_448_22 <= 0 and var_448_18 or var_448_18 * (var_448_23 / var_448_22)

				if var_448_24 > 0 and var_448_18 < var_448_24 then
					arg_445_1.talkMaxDuration = var_448_24

					if var_448_24 + var_448_17 > arg_445_1.duration_ then
						arg_445_1.duration_ = var_448_24 + var_448_17
					end
				end

				arg_445_1.text_.text = var_448_21
				arg_445_1.typewritter.percent = 0

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107505", "1107505113", "story_v_side_new_1107505.awb") ~= 0 then
					local var_448_25 = manager.audio:GetVoiceLength("story_v_side_new_1107505", "1107505113", "story_v_side_new_1107505.awb") / 1000

					if var_448_25 + var_448_17 > arg_445_1.duration_ then
						arg_445_1.duration_ = var_448_25 + var_448_17
					end

					if var_448_20.prefab_name ~= "" and arg_445_1.actors_[var_448_20.prefab_name] ~= nil then
						local var_448_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_445_1.actors_[var_448_20.prefab_name].transform, "story_v_side_new_1107505", "1107505113", "story_v_side_new_1107505.awb")

						arg_445_1:RecordAudio("1107505113", var_448_26)
						arg_445_1:RecordAudio("1107505113", var_448_26)
					else
						arg_445_1:AudioAction("play", "voice", "story_v_side_new_1107505", "1107505113", "story_v_side_new_1107505.awb")
					end

					arg_445_1:RecordHistoryTalkVoice("story_v_side_new_1107505", "1107505113", "story_v_side_new_1107505.awb")
				end

				arg_445_1:RecordContent(arg_445_1.text_.text)
			end

			local var_448_27 = math.max(var_448_18, arg_445_1.talkMaxDuration)

			if var_448_17 <= arg_445_1.time_ and arg_445_1.time_ < var_448_17 + var_448_27 then
				arg_445_1.typewritter.percent = (arg_445_1.time_ - var_448_17) / var_448_27

				arg_445_1.typewritter:SetDirty()
			end

			if arg_445_1.time_ >= var_448_17 + var_448_27 and arg_445_1.time_ < var_448_17 + var_448_27 + arg_448_0 then
				arg_445_1.typewritter.percent = 1

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(true)
			end
		end

		arg_445_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_actor",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_445_1:InitPlayNodeList()
	end,
	Play1107505114 = function(arg_449_0, arg_449_1)
		arg_449_1.time_ = 0
		arg_449_1.frameCnt_ = 0
		arg_449_1.state_ = "playing"
		arg_449_1.curTalkId_ = 1107505114
		arg_449_1.duration_ = 7.3

		SetActive(arg_449_1.tipsGo_, false)

		function arg_449_1.onSingleLineFinish_()
			arg_449_1.onSingleLineUpdate_ = nil
			arg_449_1.onSingleLineFinish_ = nil
			arg_449_1.state_ = "waiting"
		end

		function arg_449_1.playNext_(arg_451_0)
			if arg_451_0 == 1 then
				arg_449_0:Play1107505115(arg_449_1)
			end
		end

		function arg_449_1.onSingleLineUpdate_(arg_452_0)
			local var_452_0 = "STblack"

			if arg_449_1.bgs_[var_452_0] == nil then
				local var_452_1 = Object.Instantiate(arg_449_1.paintGo_)

				var_452_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_452_0)
				var_452_1.name = var_452_0
				var_452_1.transform.parent = arg_449_1.stage_.transform
				var_452_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_449_1.bgs_[var_452_0] = var_452_1
			end

			local var_452_2 = 0.3

			if var_452_2 < arg_449_1.time_ and arg_449_1.time_ <= var_452_2 + arg_452_0 then
				local var_452_3 = manager.ui.mainCamera.transform.localPosition
				local var_452_4 = Vector3.New(0, 0, 10) + Vector3.New(var_452_3.x, var_452_3.y, 0)
				local var_452_5 = arg_449_1.bgs_.STblack

				var_452_5.transform.localPosition = var_452_4
				var_452_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_452_6 = var_452_5:GetComponent("SpriteRenderer")

				if var_452_6 and var_452_6.sprite then
					local var_452_7 = (var_452_5.transform.localPosition - var_452_3).z
					local var_452_8 = manager.ui.mainCameraCom_
					local var_452_9 = 2 * var_452_7 * Mathf.Tan(var_452_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_452_10 = var_452_9 * var_452_8.aspect
					local var_452_11 = var_452_6.sprite.bounds.size.x
					local var_452_12 = var_452_6.sprite.bounds.size.y
					local var_452_13 = var_452_10 / var_452_11
					local var_452_14 = var_452_9 / var_452_12
					local var_452_15 = var_452_14 < var_452_13 and var_452_13 or var_452_14

					var_452_5.transform.localScale = Vector3.New(var_452_15, var_452_15, 0)
				end

				for iter_452_0, iter_452_1 in pairs(arg_449_1.bgs_) do
					if iter_452_0 ~= "STblack" then
						iter_452_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_452_16 = 2.3

			if var_452_16 < arg_449_1.time_ and arg_449_1.time_ <= var_452_16 + arg_452_0 then
				arg_449_1.allBtn_.enabled = false
			end

			local var_452_17 = 0.3

			if arg_449_1.time_ >= var_452_16 + var_452_17 and arg_449_1.time_ < var_452_16 + var_452_17 + arg_452_0 then
				arg_449_1.allBtn_.enabled = true
			end

			local var_452_18 = 0.3

			if var_452_18 < arg_449_1.time_ and arg_449_1.time_ <= var_452_18 + arg_452_0 then
				arg_449_1.mask_.enabled = true
				arg_449_1.mask_.raycastTarget = true

				arg_449_1:SetGaussion(false)
			end

			local var_452_19 = 2

			if var_452_18 <= arg_449_1.time_ and arg_449_1.time_ < var_452_18 + var_452_19 then
				local var_452_20 = (arg_449_1.time_ - var_452_18) / var_452_19
				local var_452_21 = Color.New(1, 1, 1)

				var_452_21.a = Mathf.Lerp(1, 0, var_452_20)
				arg_449_1.mask_.color = var_452_21
			end

			if arg_449_1.time_ >= var_452_18 + var_452_19 and arg_449_1.time_ < var_452_18 + var_452_19 + arg_452_0 then
				local var_452_22 = Color.New(1, 1, 1)
				local var_452_23 = 0

				arg_449_1.mask_.enabled = false
				var_452_22.a = var_452_23
				arg_449_1.mask_.color = var_452_22
			end

			local var_452_24 = arg_449_1.actors_["1075ui_actor"].transform
			local var_452_25 = 0.3

			if var_452_25 < arg_449_1.time_ and arg_449_1.time_ <= var_452_25 + arg_452_0 then
				arg_449_1.var_.moveOldPos1075ui_actor = var_452_24.localPosition

				local var_452_26 = GameObjectTools.GetOrAddComponent(var_452_24.gameObject, typeof(DynamicBoneHelper))

				if var_452_26 then
					var_452_26:EnableDynamicBone(false)
				end
			end

			local var_452_27 = 0.001

			if var_452_25 <= arg_449_1.time_ and arg_449_1.time_ < var_452_25 + var_452_27 then
				local var_452_28 = (arg_449_1.time_ - var_452_25) / var_452_27
				local var_452_29 = Vector3.New(0, 100, 0)

				var_452_24.localPosition = Vector3.Lerp(arg_449_1.var_.moveOldPos1075ui_actor, var_452_29, var_452_28)

				local var_452_30 = manager.ui.mainCamera.transform.position - var_452_24.position

				var_452_24.forward = Vector3.New(var_452_30.x, var_452_30.y, var_452_30.z)

				local var_452_31 = var_452_24.localEulerAngles

				var_452_31.z = 0
				var_452_31.x = 0
				var_452_24.localEulerAngles = var_452_31
			end

			if arg_449_1.time_ >= var_452_25 + var_452_27 and arg_449_1.time_ < var_452_25 + var_452_27 + arg_452_0 then
				var_452_24.localPosition = Vector3.New(0, 100, 0)

				local var_452_32 = manager.ui.mainCamera.transform.position - var_452_24.position

				var_452_24.forward = Vector3.New(var_452_32.x, var_452_32.y, var_452_32.z)

				local var_452_33 = var_452_24.localEulerAngles

				var_452_33.z = 0
				var_452_33.x = 0
				var_452_24.localEulerAngles = var_452_33

				local var_452_34 = GameObjectTools.GetOrAddComponent(var_452_24.gameObject, typeof(DynamicBoneHelper))

				if var_452_34 then
					var_452_34:EnableDynamicBone(true)
				end
			end

			local var_452_35 = arg_449_1.actors_["1075ui_actor"]
			local var_452_36 = 0.3

			if var_452_36 < arg_449_1.time_ and arg_449_1.time_ <= var_452_36 + arg_452_0 and not isNil(var_452_35) and arg_449_1.var_.characterEffect1075ui_actor == nil then
				arg_449_1.var_.characterEffect1075ui_actor = var_452_35:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_452_37 = 0.034000001847744

			if var_452_36 <= arg_449_1.time_ and arg_449_1.time_ < var_452_36 + var_452_37 and not isNil(var_452_35) then
				local var_452_38 = (arg_449_1.time_ - var_452_36) / var_452_37

				if arg_449_1.var_.characterEffect1075ui_actor and not isNil(var_452_35) then
					local var_452_39 = Mathf.Lerp(0, 0.5, var_452_38)

					arg_449_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_449_1.var_.characterEffect1075ui_actor.fillRatio = var_452_39
				end
			end

			if arg_449_1.time_ >= var_452_36 + var_452_37 and arg_449_1.time_ < var_452_36 + var_452_37 + arg_452_0 and not isNil(var_452_35) and arg_449_1.var_.characterEffect1075ui_actor then
				local var_452_40 = 0.5

				arg_449_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_449_1.var_.characterEffect1075ui_actor.fillRatio = var_452_40
			end

			local var_452_41 = 0

			if var_452_41 < arg_449_1.time_ and arg_449_1.time_ <= var_452_41 + arg_452_0 then
				arg_449_1.allBtn_.enabled = false
			end

			local var_452_42 = 0.3

			if arg_449_1.time_ >= var_452_41 + var_452_42 and arg_449_1.time_ < var_452_41 + var_452_42 + arg_452_0 then
				arg_449_1.allBtn_.enabled = true
			end

			local var_452_43 = 0.3
			local var_452_44 = 1

			if var_452_43 < arg_449_1.time_ and arg_449_1.time_ <= var_452_43 + arg_452_0 then
				local var_452_45 = "play"
				local var_452_46 = "effect"

				arg_449_1:AudioAction(var_452_45, var_452_46, "se_story_side_1075", "se_story_side_1075_glass", "")
			end

			local var_452_47 = 0.3
			local var_452_48 = 1

			if var_452_47 < arg_449_1.time_ and arg_449_1.time_ <= var_452_47 + arg_452_0 then
				local var_452_49 = "play"
				local var_452_50 = "effect"

				arg_449_1:AudioAction(var_452_49, var_452_50, "se_story_122_01", "se_story_122_01_dizzy_loop", "")
			end

			if arg_449_1.frameCnt_ <= 1 then
				arg_449_1.dialog_:SetActive(false)
			end

			local var_452_51 = 2.3
			local var_452_52 = 0.575

			if var_452_51 < arg_449_1.time_ and arg_449_1.time_ <= var_452_51 + arg_452_0 then
				arg_449_1.talkMaxDuration = 0

				arg_449_1.dialog_:SetActive(true)

				arg_449_1.dialogCg_.alpha = 0

				local var_452_53 = LeanTween.value(arg_449_1.dialog_, 0, 1, 0.3)

				var_452_53:setOnUpdate(LuaHelper.FloatAction(function(arg_453_0)
					arg_449_1.dialogCg_.alpha = arg_453_0
				end))
				var_452_53:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_449_1.dialog_)
					var_452_53:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_449_1.duration_ = arg_449_1.duration_ + 0.3

				SetActive(arg_449_1.leftNameGo_, false)

				arg_449_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_449_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_449_1:RecordName(arg_449_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_449_1.iconTrs_.gameObject, false)
				arg_449_1.callingController_:SetSelectedState("normal")

				local var_452_54 = arg_449_1:GetWordFromCfg(1107505114)
				local var_452_55 = arg_449_1:FormatText(var_452_54.content)

				arg_449_1.text_.text = var_452_55

				LuaForUtil.ClearLinePrefixSymbol(arg_449_1.text_)

				local var_452_56 = 23
				local var_452_57 = utf8.len(var_452_55)
				local var_452_58 = var_452_56 <= 0 and var_452_52 or var_452_52 * (var_452_57 / var_452_56)

				if var_452_58 > 0 and var_452_52 < var_452_58 then
					arg_449_1.talkMaxDuration = var_452_58
					var_452_51 = var_452_51 + 0.3

					if var_452_58 + var_452_51 > arg_449_1.duration_ then
						arg_449_1.duration_ = var_452_58 + var_452_51
					end
				end

				arg_449_1.text_.text = var_452_55
				arg_449_1.typewritter.percent = 0

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(false)
				arg_449_1:RecordContent(arg_449_1.text_.text)
			end

			local var_452_59 = var_452_51 + 0.3
			local var_452_60 = math.max(var_452_52, arg_449_1.talkMaxDuration)

			if var_452_59 <= arg_449_1.time_ and arg_449_1.time_ < var_452_59 + var_452_60 then
				arg_449_1.typewritter.percent = (arg_449_1.time_ - var_452_59) / var_452_60

				arg_449_1.typewritter:SetDirty()
			end

			if arg_449_1.time_ >= var_452_59 + var_452_60 and arg_449_1.time_ < var_452_59 + var_452_60 + arg_452_0 then
				arg_449_1.typewritter.percent = 1

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(true)
			end
		end

		arg_449_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_actor",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0.3,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_449_1:InitPlayNodeList()
	end,
	Play1107505115 = function(arg_455_0, arg_455_1)
		arg_455_1.time_ = 0
		arg_455_1.frameCnt_ = 0
		arg_455_1.state_ = "playing"
		arg_455_1.curTalkId_ = 1107505115
		arg_455_1.duration_ = 5

		SetActive(arg_455_1.tipsGo_, false)

		function arg_455_1.onSingleLineFinish_()
			arg_455_1.onSingleLineUpdate_ = nil
			arg_455_1.onSingleLineFinish_ = nil
			arg_455_1.state_ = "waiting"
		end

		function arg_455_1.playNext_(arg_457_0)
			if arg_457_0 == 1 then
				arg_455_0:Play1107505116(arg_455_1)
			end
		end

		function arg_455_1.onSingleLineUpdate_(arg_458_0)
			local var_458_0 = 0
			local var_458_1 = 1.1

			if var_458_0 < arg_455_1.time_ and arg_455_1.time_ <= var_458_0 + arg_458_0 then
				arg_455_1.talkMaxDuration = 0
				arg_455_1.dialogCg_.alpha = 1

				arg_455_1.dialog_:SetActive(true)
				SetActive(arg_455_1.leftNameGo_, false)

				arg_455_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_455_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_455_1:RecordName(arg_455_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_455_1.iconTrs_.gameObject, false)
				arg_455_1.callingController_:SetSelectedState("normal")

				local var_458_2 = arg_455_1:GetWordFromCfg(1107505115)
				local var_458_3 = arg_455_1:FormatText(var_458_2.content)

				arg_455_1.text_.text = var_458_3

				LuaForUtil.ClearLinePrefixSymbol(arg_455_1.text_)

				local var_458_4 = 44
				local var_458_5 = utf8.len(var_458_3)
				local var_458_6 = var_458_4 <= 0 and var_458_1 or var_458_1 * (var_458_5 / var_458_4)

				if var_458_6 > 0 and var_458_1 < var_458_6 then
					arg_455_1.talkMaxDuration = var_458_6

					if var_458_6 + var_458_0 > arg_455_1.duration_ then
						arg_455_1.duration_ = var_458_6 + var_458_0
					end
				end

				arg_455_1.text_.text = var_458_3
				arg_455_1.typewritter.percent = 0

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(false)
				arg_455_1:RecordContent(arg_455_1.text_.text)
			end

			local var_458_7 = math.max(var_458_1, arg_455_1.talkMaxDuration)

			if var_458_0 <= arg_455_1.time_ and arg_455_1.time_ < var_458_0 + var_458_7 then
				arg_455_1.typewritter.percent = (arg_455_1.time_ - var_458_0) / var_458_7

				arg_455_1.typewritter:SetDirty()
			end

			if arg_455_1.time_ >= var_458_0 + var_458_7 and arg_455_1.time_ < var_458_0 + var_458_7 + arg_458_0 then
				arg_455_1.typewritter.percent = 1

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(true)
			end
		end

		arg_455_1.nodeConfigList_ = {}

		arg_455_1:InitPlayNodeList()
	end,
	Play1107505116 = function(arg_459_0, arg_459_1)
		arg_459_1.time_ = 0
		arg_459_1.frameCnt_ = 0
		arg_459_1.state_ = "playing"
		arg_459_1.curTalkId_ = 1107505116
		arg_459_1.duration_ = 5

		SetActive(arg_459_1.tipsGo_, false)

		function arg_459_1.onSingleLineFinish_()
			arg_459_1.onSingleLineUpdate_ = nil
			arg_459_1.onSingleLineFinish_ = nil
			arg_459_1.state_ = "waiting"
		end

		function arg_459_1.playNext_(arg_461_0)
			if arg_461_0 == 1 then
				arg_459_0:Play1107505117(arg_459_1)
			end
		end

		function arg_459_1.onSingleLineUpdate_(arg_462_0)
			local var_462_0 = 0
			local var_462_1 = 1

			if var_462_0 < arg_459_1.time_ and arg_459_1.time_ <= var_462_0 + arg_462_0 then
				arg_459_1.talkMaxDuration = 0
				arg_459_1.dialogCg_.alpha = 1

				arg_459_1.dialog_:SetActive(true)
				SetActive(arg_459_1.leftNameGo_, false)

				arg_459_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_459_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_459_1:RecordName(arg_459_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_459_1.iconTrs_.gameObject, false)
				arg_459_1.callingController_:SetSelectedState("normal")

				local var_462_2 = arg_459_1:GetWordFromCfg(1107505116)
				local var_462_3 = arg_459_1:FormatText(var_462_2.content)

				arg_459_1.text_.text = var_462_3

				LuaForUtil.ClearLinePrefixSymbol(arg_459_1.text_)

				local var_462_4 = 40
				local var_462_5 = utf8.len(var_462_3)
				local var_462_6 = var_462_4 <= 0 and var_462_1 or var_462_1 * (var_462_5 / var_462_4)

				if var_462_6 > 0 and var_462_1 < var_462_6 then
					arg_459_1.talkMaxDuration = var_462_6

					if var_462_6 + var_462_0 > arg_459_1.duration_ then
						arg_459_1.duration_ = var_462_6 + var_462_0
					end
				end

				arg_459_1.text_.text = var_462_3
				arg_459_1.typewritter.percent = 0

				arg_459_1.typewritter:SetDirty()
				arg_459_1:ShowNextGo(false)
				arg_459_1:RecordContent(arg_459_1.text_.text)
			end

			local var_462_7 = math.max(var_462_1, arg_459_1.talkMaxDuration)

			if var_462_0 <= arg_459_1.time_ and arg_459_1.time_ < var_462_0 + var_462_7 then
				arg_459_1.typewritter.percent = (arg_459_1.time_ - var_462_0) / var_462_7

				arg_459_1.typewritter:SetDirty()
			end

			if arg_459_1.time_ >= var_462_0 + var_462_7 and arg_459_1.time_ < var_462_0 + var_462_7 + arg_462_0 then
				arg_459_1.typewritter.percent = 1

				arg_459_1.typewritter:SetDirty()
				arg_459_1:ShowNextGo(true)
			end
		end

		arg_459_1.nodeConfigList_ = {}

		arg_459_1:InitPlayNodeList()
	end,
	Play1107505117 = function(arg_463_0, arg_463_1)
		arg_463_1.time_ = 0
		arg_463_1.frameCnt_ = 0
		arg_463_1.state_ = "playing"
		arg_463_1.curTalkId_ = 1107505117
		arg_463_1.duration_ = 7.77

		SetActive(arg_463_1.tipsGo_, false)

		function arg_463_1.onSingleLineFinish_()
			arg_463_1.onSingleLineUpdate_ = nil
			arg_463_1.onSingleLineFinish_ = nil
			arg_463_1.state_ = "waiting"
		end

		function arg_463_1.playNext_(arg_465_0)
			if arg_465_0 == 1 then
				arg_463_0:Play1107505118(arg_463_1)
			end
		end

		function arg_463_1.onSingleLineUpdate_(arg_466_0)
			local var_466_0 = 0

			if var_466_0 < arg_463_1.time_ and arg_463_1.time_ <= var_466_0 + arg_466_0 then
				local var_466_1 = manager.ui.mainCamera.transform.localPosition
				local var_466_2 = Vector3.New(0, 0, 10) + Vector3.New(var_466_1.x, var_466_1.y, 0)
				local var_466_3 = arg_463_1.bgs_.ST37

				var_466_3.transform.localPosition = var_466_2
				var_466_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_466_4 = var_466_3:GetComponent("SpriteRenderer")

				if var_466_4 and var_466_4.sprite then
					local var_466_5 = (var_466_3.transform.localPosition - var_466_1).z
					local var_466_6 = manager.ui.mainCameraCom_
					local var_466_7 = 2 * var_466_5 * Mathf.Tan(var_466_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_466_8 = var_466_7 * var_466_6.aspect
					local var_466_9 = var_466_4.sprite.bounds.size.x
					local var_466_10 = var_466_4.sprite.bounds.size.y
					local var_466_11 = var_466_8 / var_466_9
					local var_466_12 = var_466_7 / var_466_10
					local var_466_13 = var_466_12 < var_466_11 and var_466_11 or var_466_12

					var_466_3.transform.localScale = Vector3.New(var_466_13, var_466_13, 0)
				end

				for iter_466_0, iter_466_1 in pairs(arg_463_1.bgs_) do
					if iter_466_0 ~= "ST37" then
						iter_466_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_466_14 = 2.5

			if var_466_14 < arg_463_1.time_ and arg_463_1.time_ <= var_466_14 + arg_466_0 then
				arg_463_1.allBtn_.enabled = false
			end

			local var_466_15 = 0.3

			if arg_463_1.time_ >= var_466_14 + var_466_15 and arg_463_1.time_ < var_466_14 + var_466_15 + arg_466_0 then
				arg_463_1.allBtn_.enabled = true
			end

			local var_466_16 = 0

			if var_466_16 < arg_463_1.time_ and arg_463_1.time_ <= var_466_16 + arg_466_0 then
				arg_463_1.mask_.enabled = true
				arg_463_1.mask_.raycastTarget = true

				arg_463_1:SetGaussion(false)
			end

			local var_466_17 = 2.5

			if var_466_16 <= arg_463_1.time_ and arg_463_1.time_ < var_466_16 + var_466_17 then
				local var_466_18 = (arg_463_1.time_ - var_466_16) / var_466_17
				local var_466_19 = Color.New(0, 0, 0)

				var_466_19.a = Mathf.Lerp(1, 0, var_466_18)
				arg_463_1.mask_.color = var_466_19
			end

			if arg_463_1.time_ >= var_466_16 + var_466_17 and arg_463_1.time_ < var_466_16 + var_466_17 + arg_466_0 then
				local var_466_20 = Color.New(0, 0, 0)
				local var_466_21 = 0

				arg_463_1.mask_.enabled = false
				var_466_20.a = var_466_21
				arg_463_1.mask_.color = var_466_20
			end

			local var_466_22 = 0.233333333333333
			local var_466_23 = 1

			if var_466_22 < arg_463_1.time_ and arg_463_1.time_ <= var_466_22 + arg_466_0 then
				local var_466_24 = "stop"
				local var_466_25 = "effect"

				arg_463_1:AudioAction(var_466_24, var_466_25, "se_story_122_01", "se_story_122_01_dizzy_loop", "")
			end

			if arg_463_1.frameCnt_ <= 1 then
				arg_463_1.dialog_:SetActive(false)
			end

			local var_466_26 = 2.499999999999
			local var_466_27 = 0.275

			if var_466_26 < arg_463_1.time_ and arg_463_1.time_ <= var_466_26 + arg_466_0 then
				arg_463_1.talkMaxDuration = 0

				arg_463_1.dialog_:SetActive(true)

				arg_463_1.dialogCg_.alpha = 0

				local var_466_28 = LeanTween.value(arg_463_1.dialog_, 0, 1, 0.3)

				var_466_28:setOnUpdate(LuaHelper.FloatAction(function(arg_467_0)
					arg_463_1.dialogCg_.alpha = arg_467_0
				end))
				var_466_28:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_463_1.dialog_)
					var_466_28:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_463_1.duration_ = arg_463_1.duration_ + 0.3

				SetActive(arg_463_1.leftNameGo_, true)

				local var_466_29 = arg_463_1:FormatText(StoryNameCfg[381].name)

				arg_463_1.leftNameTxt_.text = var_466_29

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_463_1.leftNameTxt_.transform)

				arg_463_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_463_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_463_1:RecordName(arg_463_1.leftNameTxt_.text)
				SetActive(arg_463_1.iconTrs_.gameObject, true)
				arg_463_1.iconController_:SetSelectedState("hero")

				arg_463_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1075")

				arg_463_1.callingController_:SetSelectedState("normal")

				arg_463_1.keyicon_.color = Color.New(1, 1, 1)
				arg_463_1.icon_.color = Color.New(1, 1, 1)

				local var_466_30 = arg_463_1:GetWordFromCfg(1107505117)
				local var_466_31 = arg_463_1:FormatText(var_466_30.content)

				arg_463_1.text_.text = var_466_31

				LuaForUtil.ClearLinePrefixSymbol(arg_463_1.text_)

				local var_466_32 = 11
				local var_466_33 = utf8.len(var_466_31)
				local var_466_34 = var_466_32 <= 0 and var_466_27 or var_466_27 * (var_466_33 / var_466_32)

				if var_466_34 > 0 and var_466_27 < var_466_34 then
					arg_463_1.talkMaxDuration = var_466_34
					var_466_26 = var_466_26 + 0.3

					if var_466_34 + var_466_26 > arg_463_1.duration_ then
						arg_463_1.duration_ = var_466_34 + var_466_26
					end
				end

				arg_463_1.text_.text = var_466_31
				arg_463_1.typewritter.percent = 0

				arg_463_1.typewritter:SetDirty()
				arg_463_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107505", "1107505117", "story_v_side_new_1107505.awb") ~= 0 then
					local var_466_35 = manager.audio:GetVoiceLength("story_v_side_new_1107505", "1107505117", "story_v_side_new_1107505.awb") / 1000

					if var_466_35 + var_466_26 > arg_463_1.duration_ then
						arg_463_1.duration_ = var_466_35 + var_466_26
					end

					if var_466_30.prefab_name ~= "" and arg_463_1.actors_[var_466_30.prefab_name] ~= nil then
						local var_466_36 = LuaForUtil.PlayVoiceWithCriLipsync(arg_463_1.actors_[var_466_30.prefab_name].transform, "story_v_side_new_1107505", "1107505117", "story_v_side_new_1107505.awb")

						arg_463_1:RecordAudio("1107505117", var_466_36)
						arg_463_1:RecordAudio("1107505117", var_466_36)
					else
						arg_463_1:AudioAction("play", "voice", "story_v_side_new_1107505", "1107505117", "story_v_side_new_1107505.awb")
					end

					arg_463_1:RecordHistoryTalkVoice("story_v_side_new_1107505", "1107505117", "story_v_side_new_1107505.awb")
				end

				arg_463_1:RecordContent(arg_463_1.text_.text)
			end

			local var_466_37 = var_466_26 + 0.3
			local var_466_38 = math.max(var_466_27, arg_463_1.talkMaxDuration)

			if var_466_37 <= arg_463_1.time_ and arg_463_1.time_ < var_466_37 + var_466_38 then
				arg_463_1.typewritter.percent = (arg_463_1.time_ - var_466_37) / var_466_38

				arg_463_1.typewritter:SetDirty()
			end

			if arg_463_1.time_ >= var_466_37 + var_466_38 and arg_463_1.time_ < var_466_37 + var_466_38 + arg_466_0 then
				arg_463_1.typewritter.percent = 1

				arg_463_1.typewritter:SetDirty()
				arg_463_1:ShowNextGo(true)
			end
		end

		arg_463_1.nodeConfigList_ = {}

		arg_463_1:InitPlayNodeList()
	end,
	Play1107505118 = function(arg_469_0, arg_469_1)
		arg_469_1.time_ = 0
		arg_469_1.frameCnt_ = 0
		arg_469_1.state_ = "playing"
		arg_469_1.curTalkId_ = 1107505118
		arg_469_1.duration_ = 5

		SetActive(arg_469_1.tipsGo_, false)

		function arg_469_1.onSingleLineFinish_()
			arg_469_1.onSingleLineUpdate_ = nil
			arg_469_1.onSingleLineFinish_ = nil
			arg_469_1.state_ = "waiting"
		end

		function arg_469_1.playNext_(arg_471_0)
			if arg_471_0 == 1 then
				arg_469_0:Play1107505119(arg_469_1)
			end
		end

		function arg_469_1.onSingleLineUpdate_(arg_472_0)
			local var_472_0 = arg_469_1.actors_["1075ui_actor"]
			local var_472_1 = 0

			if var_472_1 < arg_469_1.time_ and arg_469_1.time_ <= var_472_1 + arg_472_0 and not isNil(var_472_0) and arg_469_1.var_.characterEffect1075ui_actor == nil then
				arg_469_1.var_.characterEffect1075ui_actor = var_472_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_472_2 = 0.200000002980232

			if var_472_1 <= arg_469_1.time_ and arg_469_1.time_ < var_472_1 + var_472_2 and not isNil(var_472_0) then
				local var_472_3 = (arg_469_1.time_ - var_472_1) / var_472_2

				if arg_469_1.var_.characterEffect1075ui_actor and not isNil(var_472_0) then
					local var_472_4 = Mathf.Lerp(0, 0.5, var_472_3)

					arg_469_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_469_1.var_.characterEffect1075ui_actor.fillRatio = var_472_4
				end
			end

			if arg_469_1.time_ >= var_472_1 + var_472_2 and arg_469_1.time_ < var_472_1 + var_472_2 + arg_472_0 and not isNil(var_472_0) and arg_469_1.var_.characterEffect1075ui_actor then
				local var_472_5 = 0.5

				arg_469_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_469_1.var_.characterEffect1075ui_actor.fillRatio = var_472_5
			end

			local var_472_6 = 0
			local var_472_7 = 0.725

			if var_472_6 < arg_469_1.time_ and arg_469_1.time_ <= var_472_6 + arg_472_0 then
				arg_469_1.talkMaxDuration = 0
				arg_469_1.dialogCg_.alpha = 1

				arg_469_1.dialog_:SetActive(true)
				SetActive(arg_469_1.leftNameGo_, false)

				arg_469_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_469_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_469_1:RecordName(arg_469_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_469_1.iconTrs_.gameObject, false)
				arg_469_1.callingController_:SetSelectedState("normal")

				local var_472_8 = arg_469_1:GetWordFromCfg(1107505118)
				local var_472_9 = arg_469_1:FormatText(var_472_8.content)

				arg_469_1.text_.text = var_472_9

				LuaForUtil.ClearLinePrefixSymbol(arg_469_1.text_)

				local var_472_10 = 29
				local var_472_11 = utf8.len(var_472_9)
				local var_472_12 = var_472_10 <= 0 and var_472_7 or var_472_7 * (var_472_11 / var_472_10)

				if var_472_12 > 0 and var_472_7 < var_472_12 then
					arg_469_1.talkMaxDuration = var_472_12

					if var_472_12 + var_472_6 > arg_469_1.duration_ then
						arg_469_1.duration_ = var_472_12 + var_472_6
					end
				end

				arg_469_1.text_.text = var_472_9
				arg_469_1.typewritter.percent = 0

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(false)
				arg_469_1:RecordContent(arg_469_1.text_.text)
			end

			local var_472_13 = math.max(var_472_7, arg_469_1.talkMaxDuration)

			if var_472_6 <= arg_469_1.time_ and arg_469_1.time_ < var_472_6 + var_472_13 then
				arg_469_1.typewritter.percent = (arg_469_1.time_ - var_472_6) / var_472_13

				arg_469_1.typewritter:SetDirty()
			end

			if arg_469_1.time_ >= var_472_6 + var_472_13 and arg_469_1.time_ < var_472_6 + var_472_13 + arg_472_0 then
				arg_469_1.typewritter.percent = 1

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(true)
			end
		end

		arg_469_1.nodeConfigList_ = {}

		arg_469_1:InitPlayNodeList()
	end,
	Play1107505119 = function(arg_473_0, arg_473_1)
		arg_473_1.time_ = 0
		arg_473_1.frameCnt_ = 0
		arg_473_1.state_ = "playing"
		arg_473_1.curTalkId_ = 1107505119
		arg_473_1.duration_ = 5

		SetActive(arg_473_1.tipsGo_, false)

		function arg_473_1.onSingleLineFinish_()
			arg_473_1.onSingleLineUpdate_ = nil
			arg_473_1.onSingleLineFinish_ = nil
			arg_473_1.state_ = "waiting"
		end

		function arg_473_1.playNext_(arg_475_0)
			if arg_475_0 == 1 then
				arg_473_0:Play1107505120(arg_473_1)
			end
		end

		function arg_473_1.onSingleLineUpdate_(arg_476_0)
			local var_476_0 = 0
			local var_476_1 = 0.2

			if var_476_0 < arg_473_1.time_ and arg_473_1.time_ <= var_476_0 + arg_476_0 then
				arg_473_1.talkMaxDuration = 0
				arg_473_1.dialogCg_.alpha = 1

				arg_473_1.dialog_:SetActive(true)
				SetActive(arg_473_1.leftNameGo_, true)

				local var_476_2 = arg_473_1:FormatText(StoryNameCfg[7].name)

				arg_473_1.leftNameTxt_.text = var_476_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_473_1.leftNameTxt_.transform)

				arg_473_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_473_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_473_1:RecordName(arg_473_1.leftNameTxt_.text)
				SetActive(arg_473_1.iconTrs_.gameObject, true)
				arg_473_1.iconController_:SetSelectedState("hero")

				arg_473_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_473_1.callingController_:SetSelectedState("normal")

				arg_473_1.keyicon_.color = Color.New(1, 1, 1)
				arg_473_1.icon_.color = Color.New(1, 1, 1)

				local var_476_3 = arg_473_1:GetWordFromCfg(1107505119)
				local var_476_4 = arg_473_1:FormatText(var_476_3.content)

				arg_473_1.text_.text = var_476_4

				LuaForUtil.ClearLinePrefixSymbol(arg_473_1.text_)

				local var_476_5 = 8
				local var_476_6 = utf8.len(var_476_4)
				local var_476_7 = var_476_5 <= 0 and var_476_1 or var_476_1 * (var_476_6 / var_476_5)

				if var_476_7 > 0 and var_476_1 < var_476_7 then
					arg_473_1.talkMaxDuration = var_476_7

					if var_476_7 + var_476_0 > arg_473_1.duration_ then
						arg_473_1.duration_ = var_476_7 + var_476_0
					end
				end

				arg_473_1.text_.text = var_476_4
				arg_473_1.typewritter.percent = 0

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(false)
				arg_473_1:RecordContent(arg_473_1.text_.text)
			end

			local var_476_8 = math.max(var_476_1, arg_473_1.talkMaxDuration)

			if var_476_0 <= arg_473_1.time_ and arg_473_1.time_ < var_476_0 + var_476_8 then
				arg_473_1.typewritter.percent = (arg_473_1.time_ - var_476_0) / var_476_8

				arg_473_1.typewritter:SetDirty()
			end

			if arg_473_1.time_ >= var_476_0 + var_476_8 and arg_473_1.time_ < var_476_0 + var_476_8 + arg_476_0 then
				arg_473_1.typewritter.percent = 1

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(true)
			end
		end

		arg_473_1.nodeConfigList_ = {}

		arg_473_1:InitPlayNodeList()
	end,
	Play1107505120 = function(arg_477_0, arg_477_1)
		arg_477_1.time_ = 0
		arg_477_1.frameCnt_ = 0
		arg_477_1.state_ = "playing"
		arg_477_1.curTalkId_ = 1107505120
		arg_477_1.duration_ = 3.23

		SetActive(arg_477_1.tipsGo_, false)

		function arg_477_1.onSingleLineFinish_()
			arg_477_1.onSingleLineUpdate_ = nil
			arg_477_1.onSingleLineFinish_ = nil
			arg_477_1.state_ = "waiting"
		end

		function arg_477_1.playNext_(arg_479_0)
			if arg_479_0 == 1 then
				arg_477_0:Play1107505121(arg_477_1)
			end
		end

		function arg_477_1.onSingleLineUpdate_(arg_480_0)
			local var_480_0 = arg_477_1.actors_["1075ui_actor"].transform
			local var_480_1 = 0

			if var_480_1 < arg_477_1.time_ and arg_477_1.time_ <= var_480_1 + arg_480_0 then
				arg_477_1.var_.moveOldPos1075ui_actor = var_480_0.localPosition

				local var_480_2 = GameObjectTools.GetOrAddComponent(var_480_0.gameObject, typeof(DynamicBoneHelper))

				if var_480_2 then
					var_480_2:EnableDynamicBone(false)
				end
			end

			local var_480_3 = 0.001

			if var_480_1 <= arg_477_1.time_ and arg_477_1.time_ < var_480_1 + var_480_3 then
				local var_480_4 = (arg_477_1.time_ - var_480_1) / var_480_3
				local var_480_5 = Vector3.New(0, -1.055, -6.16)

				var_480_0.localPosition = Vector3.Lerp(arg_477_1.var_.moveOldPos1075ui_actor, var_480_5, var_480_4)

				local var_480_6 = manager.ui.mainCamera.transform.position - var_480_0.position

				var_480_0.forward = Vector3.New(var_480_6.x, var_480_6.y, var_480_6.z)

				local var_480_7 = var_480_0.localEulerAngles

				var_480_7.z = 0
				var_480_7.x = 0
				var_480_0.localEulerAngles = var_480_7
			end

			if arg_477_1.time_ >= var_480_1 + var_480_3 and arg_477_1.time_ < var_480_1 + var_480_3 + arg_480_0 then
				var_480_0.localPosition = Vector3.New(0, -1.055, -6.16)

				local var_480_8 = manager.ui.mainCamera.transform.position - var_480_0.position

				var_480_0.forward = Vector3.New(var_480_8.x, var_480_8.y, var_480_8.z)

				local var_480_9 = var_480_0.localEulerAngles

				var_480_9.z = 0
				var_480_9.x = 0
				var_480_0.localEulerAngles = var_480_9

				local var_480_10 = GameObjectTools.GetOrAddComponent(var_480_0.gameObject, typeof(DynamicBoneHelper))

				if var_480_10 then
					var_480_10:EnableDynamicBone(true)
				end
			end

			local var_480_11 = arg_477_1.actors_["1075ui_actor"]
			local var_480_12 = 0

			if var_480_12 < arg_477_1.time_ and arg_477_1.time_ <= var_480_12 + arg_480_0 and not isNil(var_480_11) and arg_477_1.var_.characterEffect1075ui_actor == nil then
				arg_477_1.var_.characterEffect1075ui_actor = var_480_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_480_13 = 0.200000002980232

			if var_480_12 <= arg_477_1.time_ and arg_477_1.time_ < var_480_12 + var_480_13 and not isNil(var_480_11) then
				local var_480_14 = (arg_477_1.time_ - var_480_12) / var_480_13

				if arg_477_1.var_.characterEffect1075ui_actor and not isNil(var_480_11) then
					arg_477_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_477_1.time_ >= var_480_12 + var_480_13 and arg_477_1.time_ < var_480_12 + var_480_13 + arg_480_0 and not isNil(var_480_11) and arg_477_1.var_.characterEffect1075ui_actor then
				arg_477_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			local var_480_15 = 0

			if var_480_15 < arg_477_1.time_ and arg_477_1.time_ <= var_480_15 + arg_480_0 then
				arg_477_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075action/1075action5_1")
			end

			local var_480_16 = 0

			if var_480_16 < arg_477_1.time_ and arg_477_1.time_ <= var_480_16 + arg_480_0 then
				arg_477_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_nanguoC", "EmotionTimelineAnimator")
			end

			local var_480_17 = 0
			local var_480_18 = 0.15

			if var_480_17 < arg_477_1.time_ and arg_477_1.time_ <= var_480_17 + arg_480_0 then
				arg_477_1.talkMaxDuration = 0
				arg_477_1.dialogCg_.alpha = 1

				arg_477_1.dialog_:SetActive(true)
				SetActive(arg_477_1.leftNameGo_, true)

				local var_480_19 = arg_477_1:FormatText(StoryNameCfg[381].name)

				arg_477_1.leftNameTxt_.text = var_480_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_477_1.leftNameTxt_.transform)

				arg_477_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_477_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_477_1:RecordName(arg_477_1.leftNameTxt_.text)
				SetActive(arg_477_1.iconTrs_.gameObject, false)
				arg_477_1.callingController_:SetSelectedState("normal")

				local var_480_20 = arg_477_1:GetWordFromCfg(1107505120)
				local var_480_21 = arg_477_1:FormatText(var_480_20.content)

				arg_477_1.text_.text = var_480_21

				LuaForUtil.ClearLinePrefixSymbol(arg_477_1.text_)

				local var_480_22 = 6
				local var_480_23 = utf8.len(var_480_21)
				local var_480_24 = var_480_22 <= 0 and var_480_18 or var_480_18 * (var_480_23 / var_480_22)

				if var_480_24 > 0 and var_480_18 < var_480_24 then
					arg_477_1.talkMaxDuration = var_480_24

					if var_480_24 + var_480_17 > arg_477_1.duration_ then
						arg_477_1.duration_ = var_480_24 + var_480_17
					end
				end

				arg_477_1.text_.text = var_480_21
				arg_477_1.typewritter.percent = 0

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107505", "1107505120", "story_v_side_new_1107505.awb") ~= 0 then
					local var_480_25 = manager.audio:GetVoiceLength("story_v_side_new_1107505", "1107505120", "story_v_side_new_1107505.awb") / 1000

					if var_480_25 + var_480_17 > arg_477_1.duration_ then
						arg_477_1.duration_ = var_480_25 + var_480_17
					end

					if var_480_20.prefab_name ~= "" and arg_477_1.actors_[var_480_20.prefab_name] ~= nil then
						local var_480_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_477_1.actors_[var_480_20.prefab_name].transform, "story_v_side_new_1107505", "1107505120", "story_v_side_new_1107505.awb")

						arg_477_1:RecordAudio("1107505120", var_480_26)
						arg_477_1:RecordAudio("1107505120", var_480_26)
					else
						arg_477_1:AudioAction("play", "voice", "story_v_side_new_1107505", "1107505120", "story_v_side_new_1107505.awb")
					end

					arg_477_1:RecordHistoryTalkVoice("story_v_side_new_1107505", "1107505120", "story_v_side_new_1107505.awb")
				end

				arg_477_1:RecordContent(arg_477_1.text_.text)
			end

			local var_480_27 = math.max(var_480_18, arg_477_1.talkMaxDuration)

			if var_480_17 <= arg_477_1.time_ and arg_477_1.time_ < var_480_17 + var_480_27 then
				arg_477_1.typewritter.percent = (arg_477_1.time_ - var_480_17) / var_480_27

				arg_477_1.typewritter:SetDirty()
			end

			if arg_477_1.time_ >= var_480_17 + var_480_27 and arg_477_1.time_ < var_480_17 + var_480_27 + arg_480_0 then
				arg_477_1.typewritter.percent = 1

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(true)
			end
		end

		arg_477_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_actor",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_477_1:InitPlayNodeList()
	end,
	Play1107505121 = function(arg_481_0, arg_481_1)
		arg_481_1.time_ = 0
		arg_481_1.frameCnt_ = 0
		arg_481_1.state_ = "playing"
		arg_481_1.curTalkId_ = 1107505121
		arg_481_1.duration_ = 5

		SetActive(arg_481_1.tipsGo_, false)

		function arg_481_1.onSingleLineFinish_()
			arg_481_1.onSingleLineUpdate_ = nil
			arg_481_1.onSingleLineFinish_ = nil
			arg_481_1.state_ = "waiting"
		end

		function arg_481_1.playNext_(arg_483_0)
			if arg_483_0 == 1 then
				arg_481_0:Play1107505122(arg_481_1)
			end
		end

		function arg_481_1.onSingleLineUpdate_(arg_484_0)
			local var_484_0 = arg_481_1.actors_["1075ui_actor"].transform
			local var_484_1 = 0

			if var_484_1 < arg_481_1.time_ and arg_481_1.time_ <= var_484_1 + arg_484_0 then
				arg_481_1.var_.moveOldPos1075ui_actor = var_484_0.localPosition

				local var_484_2 = GameObjectTools.GetOrAddComponent(var_484_0.gameObject, typeof(DynamicBoneHelper))

				if var_484_2 then
					var_484_2:EnableDynamicBone(false)
				end
			end

			local var_484_3 = 0.001

			if var_484_1 <= arg_481_1.time_ and arg_481_1.time_ < var_484_1 + var_484_3 then
				local var_484_4 = (arg_481_1.time_ - var_484_1) / var_484_3
				local var_484_5 = Vector3.New(0, 100, 0)

				var_484_0.localPosition = Vector3.Lerp(arg_481_1.var_.moveOldPos1075ui_actor, var_484_5, var_484_4)

				local var_484_6 = manager.ui.mainCamera.transform.position - var_484_0.position

				var_484_0.forward = Vector3.New(var_484_6.x, var_484_6.y, var_484_6.z)

				local var_484_7 = var_484_0.localEulerAngles

				var_484_7.z = 0
				var_484_7.x = 0
				var_484_0.localEulerAngles = var_484_7
			end

			if arg_481_1.time_ >= var_484_1 + var_484_3 and arg_481_1.time_ < var_484_1 + var_484_3 + arg_484_0 then
				var_484_0.localPosition = Vector3.New(0, 100, 0)

				local var_484_8 = manager.ui.mainCamera.transform.position - var_484_0.position

				var_484_0.forward = Vector3.New(var_484_8.x, var_484_8.y, var_484_8.z)

				local var_484_9 = var_484_0.localEulerAngles

				var_484_9.z = 0
				var_484_9.x = 0
				var_484_0.localEulerAngles = var_484_9

				local var_484_10 = GameObjectTools.GetOrAddComponent(var_484_0.gameObject, typeof(DynamicBoneHelper))

				if var_484_10 then
					var_484_10:EnableDynamicBone(true)
				end
			end

			local var_484_11 = arg_481_1.actors_["1075ui_actor"]
			local var_484_12 = 0

			if var_484_12 < arg_481_1.time_ and arg_481_1.time_ <= var_484_12 + arg_484_0 and not isNil(var_484_11) and arg_481_1.var_.characterEffect1075ui_actor == nil then
				arg_481_1.var_.characterEffect1075ui_actor = var_484_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_484_13 = 0.200000002980232

			if var_484_12 <= arg_481_1.time_ and arg_481_1.time_ < var_484_12 + var_484_13 and not isNil(var_484_11) then
				local var_484_14 = (arg_481_1.time_ - var_484_12) / var_484_13

				if arg_481_1.var_.characterEffect1075ui_actor and not isNil(var_484_11) then
					local var_484_15 = Mathf.Lerp(0, 0.5, var_484_14)

					arg_481_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_481_1.var_.characterEffect1075ui_actor.fillRatio = var_484_15
				end
			end

			if arg_481_1.time_ >= var_484_12 + var_484_13 and arg_481_1.time_ < var_484_12 + var_484_13 + arg_484_0 and not isNil(var_484_11) and arg_481_1.var_.characterEffect1075ui_actor then
				local var_484_16 = 0.5

				arg_481_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_481_1.var_.characterEffect1075ui_actor.fillRatio = var_484_16
			end

			local var_484_17 = 0
			local var_484_18 = 0.8

			if var_484_17 < arg_481_1.time_ and arg_481_1.time_ <= var_484_17 + arg_484_0 then
				arg_481_1.talkMaxDuration = 0
				arg_481_1.dialogCg_.alpha = 1

				arg_481_1.dialog_:SetActive(true)
				SetActive(arg_481_1.leftNameGo_, false)

				arg_481_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_481_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_481_1:RecordName(arg_481_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_481_1.iconTrs_.gameObject, false)
				arg_481_1.callingController_:SetSelectedState("normal")

				local var_484_19 = arg_481_1:GetWordFromCfg(1107505121)
				local var_484_20 = arg_481_1:FormatText(var_484_19.content)

				arg_481_1.text_.text = var_484_20

				LuaForUtil.ClearLinePrefixSymbol(arg_481_1.text_)

				local var_484_21 = 32
				local var_484_22 = utf8.len(var_484_20)
				local var_484_23 = var_484_21 <= 0 and var_484_18 or var_484_18 * (var_484_22 / var_484_21)

				if var_484_23 > 0 and var_484_18 < var_484_23 then
					arg_481_1.talkMaxDuration = var_484_23

					if var_484_23 + var_484_17 > arg_481_1.duration_ then
						arg_481_1.duration_ = var_484_23 + var_484_17
					end
				end

				arg_481_1.text_.text = var_484_20
				arg_481_1.typewritter.percent = 0

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(false)
				arg_481_1:RecordContent(arg_481_1.text_.text)
			end

			local var_484_24 = math.max(var_484_18, arg_481_1.talkMaxDuration)

			if var_484_17 <= arg_481_1.time_ and arg_481_1.time_ < var_484_17 + var_484_24 then
				arg_481_1.typewritter.percent = (arg_481_1.time_ - var_484_17) / var_484_24

				arg_481_1.typewritter:SetDirty()
			end

			if arg_481_1.time_ >= var_484_17 + var_484_24 and arg_481_1.time_ < var_484_17 + var_484_24 + arg_484_0 then
				arg_481_1.typewritter.percent = 1

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(true)
			end
		end

		arg_481_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_actor",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_481_1:InitPlayNodeList()
	end,
	Play1107505122 = function(arg_485_0, arg_485_1)
		arg_485_1.time_ = 0
		arg_485_1.frameCnt_ = 0
		arg_485_1.state_ = "playing"
		arg_485_1.curTalkId_ = 1107505122
		arg_485_1.duration_ = 5

		SetActive(arg_485_1.tipsGo_, false)

		function arg_485_1.onSingleLineFinish_()
			arg_485_1.onSingleLineUpdate_ = nil
			arg_485_1.onSingleLineFinish_ = nil
			arg_485_1.state_ = "waiting"
		end

		function arg_485_1.playNext_(arg_487_0)
			if arg_487_0 == 1 then
				arg_485_0:Play1107505123(arg_485_1)
			end
		end

		function arg_485_1.onSingleLineUpdate_(arg_488_0)
			local var_488_0 = 0
			local var_488_1 = 0.75

			if var_488_0 < arg_485_1.time_ and arg_485_1.time_ <= var_488_0 + arg_488_0 then
				arg_485_1.talkMaxDuration = 0
				arg_485_1.dialogCg_.alpha = 1

				arg_485_1.dialog_:SetActive(true)
				SetActive(arg_485_1.leftNameGo_, true)

				local var_488_2 = arg_485_1:FormatText(StoryNameCfg[7].name)

				arg_485_1.leftNameTxt_.text = var_488_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_485_1.leftNameTxt_.transform)

				arg_485_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_485_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_485_1:RecordName(arg_485_1.leftNameTxt_.text)
				SetActive(arg_485_1.iconTrs_.gameObject, true)
				arg_485_1.iconController_:SetSelectedState("hero")

				arg_485_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_485_1.callingController_:SetSelectedState("normal")

				arg_485_1.keyicon_.color = Color.New(1, 1, 1)
				arg_485_1.icon_.color = Color.New(1, 1, 1)

				local var_488_3 = arg_485_1:GetWordFromCfg(1107505122)
				local var_488_4 = arg_485_1:FormatText(var_488_3.content)

				arg_485_1.text_.text = var_488_4

				LuaForUtil.ClearLinePrefixSymbol(arg_485_1.text_)

				local var_488_5 = 30
				local var_488_6 = utf8.len(var_488_4)
				local var_488_7 = var_488_5 <= 0 and var_488_1 or var_488_1 * (var_488_6 / var_488_5)

				if var_488_7 > 0 and var_488_1 < var_488_7 then
					arg_485_1.talkMaxDuration = var_488_7

					if var_488_7 + var_488_0 > arg_485_1.duration_ then
						arg_485_1.duration_ = var_488_7 + var_488_0
					end
				end

				arg_485_1.text_.text = var_488_4
				arg_485_1.typewritter.percent = 0

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(false)
				arg_485_1:RecordContent(arg_485_1.text_.text)
			end

			local var_488_8 = math.max(var_488_1, arg_485_1.talkMaxDuration)

			if var_488_0 <= arg_485_1.time_ and arg_485_1.time_ < var_488_0 + var_488_8 then
				arg_485_1.typewritter.percent = (arg_485_1.time_ - var_488_0) / var_488_8

				arg_485_1.typewritter:SetDirty()
			end

			if arg_485_1.time_ >= var_488_0 + var_488_8 and arg_485_1.time_ < var_488_0 + var_488_8 + arg_488_0 then
				arg_485_1.typewritter.percent = 1

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(true)
			end
		end

		arg_485_1.nodeConfigList_ = {}

		arg_485_1:InitPlayNodeList()
	end,
	Play1107505123 = function(arg_489_0, arg_489_1)
		arg_489_1.time_ = 0
		arg_489_1.frameCnt_ = 0
		arg_489_1.state_ = "playing"
		arg_489_1.curTalkId_ = 1107505123
		arg_489_1.duration_ = 5.73

		SetActive(arg_489_1.tipsGo_, false)

		function arg_489_1.onSingleLineFinish_()
			arg_489_1.onSingleLineUpdate_ = nil
			arg_489_1.onSingleLineFinish_ = nil
			arg_489_1.state_ = "waiting"
		end

		function arg_489_1.playNext_(arg_491_0)
			if arg_491_0 == 1 then
				arg_489_0:Play1107505124(arg_489_1)
			end
		end

		function arg_489_1.onSingleLineUpdate_(arg_492_0)
			local var_492_0 = arg_489_1.actors_["1075ui_actor"].transform
			local var_492_1 = 0

			if var_492_1 < arg_489_1.time_ and arg_489_1.time_ <= var_492_1 + arg_492_0 then
				arg_489_1.var_.moveOldPos1075ui_actor = var_492_0.localPosition

				local var_492_2 = GameObjectTools.GetOrAddComponent(var_492_0.gameObject, typeof(DynamicBoneHelper))

				if var_492_2 then
					var_492_2:EnableDynamicBone(false)
				end
			end

			local var_492_3 = 0.001

			if var_492_1 <= arg_489_1.time_ and arg_489_1.time_ < var_492_1 + var_492_3 then
				local var_492_4 = (arg_489_1.time_ - var_492_1) / var_492_3
				local var_492_5 = Vector3.New(0, -1.055, -6.16)

				var_492_0.localPosition = Vector3.Lerp(arg_489_1.var_.moveOldPos1075ui_actor, var_492_5, var_492_4)

				local var_492_6 = manager.ui.mainCamera.transform.position - var_492_0.position

				var_492_0.forward = Vector3.New(var_492_6.x, var_492_6.y, var_492_6.z)

				local var_492_7 = var_492_0.localEulerAngles

				var_492_7.z = 0
				var_492_7.x = 0
				var_492_0.localEulerAngles = var_492_7
			end

			if arg_489_1.time_ >= var_492_1 + var_492_3 and arg_489_1.time_ < var_492_1 + var_492_3 + arg_492_0 then
				var_492_0.localPosition = Vector3.New(0, -1.055, -6.16)

				local var_492_8 = manager.ui.mainCamera.transform.position - var_492_0.position

				var_492_0.forward = Vector3.New(var_492_8.x, var_492_8.y, var_492_8.z)

				local var_492_9 = var_492_0.localEulerAngles

				var_492_9.z = 0
				var_492_9.x = 0
				var_492_0.localEulerAngles = var_492_9

				local var_492_10 = GameObjectTools.GetOrAddComponent(var_492_0.gameObject, typeof(DynamicBoneHelper))

				if var_492_10 then
					var_492_10:EnableDynamicBone(true)
				end
			end

			local var_492_11 = arg_489_1.actors_["1075ui_actor"]
			local var_492_12 = 0

			if var_492_12 < arg_489_1.time_ and arg_489_1.time_ <= var_492_12 + arg_492_0 and not isNil(var_492_11) and arg_489_1.var_.characterEffect1075ui_actor == nil then
				arg_489_1.var_.characterEffect1075ui_actor = var_492_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_492_13 = 0.200000002980232

			if var_492_12 <= arg_489_1.time_ and arg_489_1.time_ < var_492_12 + var_492_13 and not isNil(var_492_11) then
				local var_492_14 = (arg_489_1.time_ - var_492_12) / var_492_13

				if arg_489_1.var_.characterEffect1075ui_actor and not isNil(var_492_11) then
					arg_489_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_489_1.time_ >= var_492_12 + var_492_13 and arg_489_1.time_ < var_492_12 + var_492_13 + arg_492_0 and not isNil(var_492_11) and arg_489_1.var_.characterEffect1075ui_actor then
				arg_489_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			local var_492_15 = 0

			if var_492_15 < arg_489_1.time_ and arg_489_1.time_ <= var_492_15 + arg_492_0 then
				arg_489_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075action/1075action5_2")
			end

			local var_492_16 = 0

			if var_492_16 < arg_489_1.time_ and arg_489_1.time_ <= var_492_16 + arg_492_0 then
				arg_489_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_492_17 = 0
			local var_492_18 = 0.475

			if var_492_17 < arg_489_1.time_ and arg_489_1.time_ <= var_492_17 + arg_492_0 then
				arg_489_1.talkMaxDuration = 0
				arg_489_1.dialogCg_.alpha = 1

				arg_489_1.dialog_:SetActive(true)
				SetActive(arg_489_1.leftNameGo_, true)

				local var_492_19 = arg_489_1:FormatText(StoryNameCfg[381].name)

				arg_489_1.leftNameTxt_.text = var_492_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_489_1.leftNameTxt_.transform)

				arg_489_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_489_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_489_1:RecordName(arg_489_1.leftNameTxt_.text)
				SetActive(arg_489_1.iconTrs_.gameObject, false)
				arg_489_1.callingController_:SetSelectedState("normal")

				local var_492_20 = arg_489_1:GetWordFromCfg(1107505123)
				local var_492_21 = arg_489_1:FormatText(var_492_20.content)

				arg_489_1.text_.text = var_492_21

				LuaForUtil.ClearLinePrefixSymbol(arg_489_1.text_)

				local var_492_22 = 19
				local var_492_23 = utf8.len(var_492_21)
				local var_492_24 = var_492_22 <= 0 and var_492_18 or var_492_18 * (var_492_23 / var_492_22)

				if var_492_24 > 0 and var_492_18 < var_492_24 then
					arg_489_1.talkMaxDuration = var_492_24

					if var_492_24 + var_492_17 > arg_489_1.duration_ then
						arg_489_1.duration_ = var_492_24 + var_492_17
					end
				end

				arg_489_1.text_.text = var_492_21
				arg_489_1.typewritter.percent = 0

				arg_489_1.typewritter:SetDirty()
				arg_489_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107505", "1107505123", "story_v_side_new_1107505.awb") ~= 0 then
					local var_492_25 = manager.audio:GetVoiceLength("story_v_side_new_1107505", "1107505123", "story_v_side_new_1107505.awb") / 1000

					if var_492_25 + var_492_17 > arg_489_1.duration_ then
						arg_489_1.duration_ = var_492_25 + var_492_17
					end

					if var_492_20.prefab_name ~= "" and arg_489_1.actors_[var_492_20.prefab_name] ~= nil then
						local var_492_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_489_1.actors_[var_492_20.prefab_name].transform, "story_v_side_new_1107505", "1107505123", "story_v_side_new_1107505.awb")

						arg_489_1:RecordAudio("1107505123", var_492_26)
						arg_489_1:RecordAudio("1107505123", var_492_26)
					else
						arg_489_1:AudioAction("play", "voice", "story_v_side_new_1107505", "1107505123", "story_v_side_new_1107505.awb")
					end

					arg_489_1:RecordHistoryTalkVoice("story_v_side_new_1107505", "1107505123", "story_v_side_new_1107505.awb")
				end

				arg_489_1:RecordContent(arg_489_1.text_.text)
			end

			local var_492_27 = math.max(var_492_18, arg_489_1.talkMaxDuration)

			if var_492_17 <= arg_489_1.time_ and arg_489_1.time_ < var_492_17 + var_492_27 then
				arg_489_1.typewritter.percent = (arg_489_1.time_ - var_492_17) / var_492_27

				arg_489_1.typewritter:SetDirty()
			end

			if arg_489_1.time_ >= var_492_17 + var_492_27 and arg_489_1.time_ < var_492_17 + var_492_27 + arg_492_0 then
				arg_489_1.typewritter.percent = 1

				arg_489_1.typewritter:SetDirty()
				arg_489_1:ShowNextGo(true)
			end
		end

		arg_489_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_actor",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_489_1:InitPlayNodeList()
	end,
	Play1107505124 = function(arg_493_0, arg_493_1)
		arg_493_1.time_ = 0
		arg_493_1.frameCnt_ = 0
		arg_493_1.state_ = "playing"
		arg_493_1.curTalkId_ = 1107505124
		arg_493_1.duration_ = 5

		SetActive(arg_493_1.tipsGo_, false)

		function arg_493_1.onSingleLineFinish_()
			arg_493_1.onSingleLineUpdate_ = nil
			arg_493_1.onSingleLineFinish_ = nil
			arg_493_1.state_ = "waiting"
		end

		function arg_493_1.playNext_(arg_495_0)
			if arg_495_0 == 1 then
				arg_493_0:Play1107505125(arg_493_1)
			end
		end

		function arg_493_1.onSingleLineUpdate_(arg_496_0)
			local var_496_0 = arg_493_1.actors_["1075ui_actor"]
			local var_496_1 = 0

			if var_496_1 < arg_493_1.time_ and arg_493_1.time_ <= var_496_1 + arg_496_0 and not isNil(var_496_0) and arg_493_1.var_.characterEffect1075ui_actor == nil then
				arg_493_1.var_.characterEffect1075ui_actor = var_496_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_496_2 = 0.200000002980232

			if var_496_1 <= arg_493_1.time_ and arg_493_1.time_ < var_496_1 + var_496_2 and not isNil(var_496_0) then
				local var_496_3 = (arg_493_1.time_ - var_496_1) / var_496_2

				if arg_493_1.var_.characterEffect1075ui_actor and not isNil(var_496_0) then
					local var_496_4 = Mathf.Lerp(0, 0.5, var_496_3)

					arg_493_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_493_1.var_.characterEffect1075ui_actor.fillRatio = var_496_4
				end
			end

			if arg_493_1.time_ >= var_496_1 + var_496_2 and arg_493_1.time_ < var_496_1 + var_496_2 + arg_496_0 and not isNil(var_496_0) and arg_493_1.var_.characterEffect1075ui_actor then
				local var_496_5 = 0.5

				arg_493_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_493_1.var_.characterEffect1075ui_actor.fillRatio = var_496_5
			end

			local var_496_6 = 0
			local var_496_7 = 0.325

			if var_496_6 < arg_493_1.time_ and arg_493_1.time_ <= var_496_6 + arg_496_0 then
				arg_493_1.talkMaxDuration = 0
				arg_493_1.dialogCg_.alpha = 1

				arg_493_1.dialog_:SetActive(true)
				SetActive(arg_493_1.leftNameGo_, true)

				local var_496_8 = arg_493_1:FormatText(StoryNameCfg[7].name)

				arg_493_1.leftNameTxt_.text = var_496_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_493_1.leftNameTxt_.transform)

				arg_493_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_493_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_493_1:RecordName(arg_493_1.leftNameTxt_.text)
				SetActive(arg_493_1.iconTrs_.gameObject, true)
				arg_493_1.iconController_:SetSelectedState("hero")

				arg_493_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_493_1.callingController_:SetSelectedState("normal")

				arg_493_1.keyicon_.color = Color.New(1, 1, 1)
				arg_493_1.icon_.color = Color.New(1, 1, 1)

				local var_496_9 = arg_493_1:GetWordFromCfg(1107505124)
				local var_496_10 = arg_493_1:FormatText(var_496_9.content)

				arg_493_1.text_.text = var_496_10

				LuaForUtil.ClearLinePrefixSymbol(arg_493_1.text_)

				local var_496_11 = 13
				local var_496_12 = utf8.len(var_496_10)
				local var_496_13 = var_496_11 <= 0 and var_496_7 or var_496_7 * (var_496_12 / var_496_11)

				if var_496_13 > 0 and var_496_7 < var_496_13 then
					arg_493_1.talkMaxDuration = var_496_13

					if var_496_13 + var_496_6 > arg_493_1.duration_ then
						arg_493_1.duration_ = var_496_13 + var_496_6
					end
				end

				arg_493_1.text_.text = var_496_10
				arg_493_1.typewritter.percent = 0

				arg_493_1.typewritter:SetDirty()
				arg_493_1:ShowNextGo(false)
				arg_493_1:RecordContent(arg_493_1.text_.text)
			end

			local var_496_14 = math.max(var_496_7, arg_493_1.talkMaxDuration)

			if var_496_6 <= arg_493_1.time_ and arg_493_1.time_ < var_496_6 + var_496_14 then
				arg_493_1.typewritter.percent = (arg_493_1.time_ - var_496_6) / var_496_14

				arg_493_1.typewritter:SetDirty()
			end

			if arg_493_1.time_ >= var_496_6 + var_496_14 and arg_493_1.time_ < var_496_6 + var_496_14 + arg_496_0 then
				arg_493_1.typewritter.percent = 1

				arg_493_1.typewritter:SetDirty()
				arg_493_1:ShowNextGo(true)
			end
		end

		arg_493_1.nodeConfigList_ = {}

		arg_493_1:InitPlayNodeList()
	end,
	Play1107505125 = function(arg_497_0, arg_497_1)
		arg_497_1.time_ = 0
		arg_497_1.frameCnt_ = 0
		arg_497_1.state_ = "playing"
		arg_497_1.curTalkId_ = 1107505125
		arg_497_1.duration_ = 2

		SetActive(arg_497_1.tipsGo_, false)

		function arg_497_1.onSingleLineFinish_()
			arg_497_1.onSingleLineUpdate_ = nil
			arg_497_1.onSingleLineFinish_ = nil
			arg_497_1.state_ = "waiting"
		end

		function arg_497_1.playNext_(arg_499_0)
			if arg_499_0 == 1 then
				arg_497_0:Play1107505126(arg_497_1)
			end
		end

		function arg_497_1.onSingleLineUpdate_(arg_500_0)
			local var_500_0 = arg_497_1.actors_["1075ui_actor"]
			local var_500_1 = 0

			if var_500_1 < arg_497_1.time_ and arg_497_1.time_ <= var_500_1 + arg_500_0 and not isNil(var_500_0) and arg_497_1.var_.characterEffect1075ui_actor == nil then
				arg_497_1.var_.characterEffect1075ui_actor = var_500_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_500_2 = 0.200000002980232

			if var_500_1 <= arg_497_1.time_ and arg_497_1.time_ < var_500_1 + var_500_2 and not isNil(var_500_0) then
				local var_500_3 = (arg_497_1.time_ - var_500_1) / var_500_2

				if arg_497_1.var_.characterEffect1075ui_actor and not isNil(var_500_0) then
					arg_497_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_497_1.time_ >= var_500_1 + var_500_2 and arg_497_1.time_ < var_500_1 + var_500_2 + arg_500_0 and not isNil(var_500_0) and arg_497_1.var_.characterEffect1075ui_actor then
				arg_497_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			local var_500_4 = 0

			if var_500_4 < arg_497_1.time_ and arg_497_1.time_ <= var_500_4 + arg_500_0 then
				arg_497_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075action/1075action2_1")
			end

			local var_500_5 = 0

			if var_500_5 < arg_497_1.time_ and arg_497_1.time_ <= var_500_5 + arg_500_0 then
				arg_497_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_500_6 = 0
			local var_500_7 = 0.15

			if var_500_6 < arg_497_1.time_ and arg_497_1.time_ <= var_500_6 + arg_500_0 then
				arg_497_1.talkMaxDuration = 0
				arg_497_1.dialogCg_.alpha = 1

				arg_497_1.dialog_:SetActive(true)
				SetActive(arg_497_1.leftNameGo_, true)

				local var_500_8 = arg_497_1:FormatText(StoryNameCfg[381].name)

				arg_497_1.leftNameTxt_.text = var_500_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_497_1.leftNameTxt_.transform)

				arg_497_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_497_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_497_1:RecordName(arg_497_1.leftNameTxt_.text)
				SetActive(arg_497_1.iconTrs_.gameObject, false)
				arg_497_1.callingController_:SetSelectedState("normal")

				local var_500_9 = arg_497_1:GetWordFromCfg(1107505125)
				local var_500_10 = arg_497_1:FormatText(var_500_9.content)

				arg_497_1.text_.text = var_500_10

				LuaForUtil.ClearLinePrefixSymbol(arg_497_1.text_)

				local var_500_11 = 6
				local var_500_12 = utf8.len(var_500_10)
				local var_500_13 = var_500_11 <= 0 and var_500_7 or var_500_7 * (var_500_12 / var_500_11)

				if var_500_13 > 0 and var_500_7 < var_500_13 then
					arg_497_1.talkMaxDuration = var_500_13

					if var_500_13 + var_500_6 > arg_497_1.duration_ then
						arg_497_1.duration_ = var_500_13 + var_500_6
					end
				end

				arg_497_1.text_.text = var_500_10
				arg_497_1.typewritter.percent = 0

				arg_497_1.typewritter:SetDirty()
				arg_497_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107505", "1107505125", "story_v_side_new_1107505.awb") ~= 0 then
					local var_500_14 = manager.audio:GetVoiceLength("story_v_side_new_1107505", "1107505125", "story_v_side_new_1107505.awb") / 1000

					if var_500_14 + var_500_6 > arg_497_1.duration_ then
						arg_497_1.duration_ = var_500_14 + var_500_6
					end

					if var_500_9.prefab_name ~= "" and arg_497_1.actors_[var_500_9.prefab_name] ~= nil then
						local var_500_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_497_1.actors_[var_500_9.prefab_name].transform, "story_v_side_new_1107505", "1107505125", "story_v_side_new_1107505.awb")

						arg_497_1:RecordAudio("1107505125", var_500_15)
						arg_497_1:RecordAudio("1107505125", var_500_15)
					else
						arg_497_1:AudioAction("play", "voice", "story_v_side_new_1107505", "1107505125", "story_v_side_new_1107505.awb")
					end

					arg_497_1:RecordHistoryTalkVoice("story_v_side_new_1107505", "1107505125", "story_v_side_new_1107505.awb")
				end

				arg_497_1:RecordContent(arg_497_1.text_.text)
			end

			local var_500_16 = math.max(var_500_7, arg_497_1.talkMaxDuration)

			if var_500_6 <= arg_497_1.time_ and arg_497_1.time_ < var_500_6 + var_500_16 then
				arg_497_1.typewritter.percent = (arg_497_1.time_ - var_500_6) / var_500_16

				arg_497_1.typewritter:SetDirty()
			end

			if arg_497_1.time_ >= var_500_6 + var_500_16 and arg_497_1.time_ < var_500_6 + var_500_16 + arg_500_0 then
				arg_497_1.typewritter.percent = 1

				arg_497_1.typewritter:SetDirty()
				arg_497_1:ShowNextGo(true)
			end
		end

		arg_497_1.nodeConfigList_ = {}

		arg_497_1:InitPlayNodeList()
	end,
	Play1107505126 = function(arg_501_0, arg_501_1)
		arg_501_1.time_ = 0
		arg_501_1.frameCnt_ = 0
		arg_501_1.state_ = "playing"
		arg_501_1.curTalkId_ = 1107505126
		arg_501_1.duration_ = 5

		SetActive(arg_501_1.tipsGo_, false)

		function arg_501_1.onSingleLineFinish_()
			arg_501_1.onSingleLineUpdate_ = nil
			arg_501_1.onSingleLineFinish_ = nil
			arg_501_1.state_ = "waiting"
		end

		function arg_501_1.playNext_(arg_503_0)
			if arg_503_0 == 1 then
				arg_501_0:Play1107505127(arg_501_1)
			end
		end

		function arg_501_1.onSingleLineUpdate_(arg_504_0)
			local var_504_0 = arg_501_1.actors_["1075ui_actor"].transform
			local var_504_1 = 0

			if var_504_1 < arg_501_1.time_ and arg_501_1.time_ <= var_504_1 + arg_504_0 then
				arg_501_1.var_.moveOldPos1075ui_actor = var_504_0.localPosition

				local var_504_2 = GameObjectTools.GetOrAddComponent(var_504_0.gameObject, typeof(DynamicBoneHelper))

				if var_504_2 then
					var_504_2:EnableDynamicBone(false)
				end
			end

			local var_504_3 = 0.001

			if var_504_1 <= arg_501_1.time_ and arg_501_1.time_ < var_504_1 + var_504_3 then
				local var_504_4 = (arg_501_1.time_ - var_504_1) / var_504_3
				local var_504_5 = Vector3.New(0, 100, 0)

				var_504_0.localPosition = Vector3.Lerp(arg_501_1.var_.moveOldPos1075ui_actor, var_504_5, var_504_4)

				local var_504_6 = manager.ui.mainCamera.transform.position - var_504_0.position

				var_504_0.forward = Vector3.New(var_504_6.x, var_504_6.y, var_504_6.z)

				local var_504_7 = var_504_0.localEulerAngles

				var_504_7.z = 0
				var_504_7.x = 0
				var_504_0.localEulerAngles = var_504_7
			end

			if arg_501_1.time_ >= var_504_1 + var_504_3 and arg_501_1.time_ < var_504_1 + var_504_3 + arg_504_0 then
				var_504_0.localPosition = Vector3.New(0, 100, 0)

				local var_504_8 = manager.ui.mainCamera.transform.position - var_504_0.position

				var_504_0.forward = Vector3.New(var_504_8.x, var_504_8.y, var_504_8.z)

				local var_504_9 = var_504_0.localEulerAngles

				var_504_9.z = 0
				var_504_9.x = 0
				var_504_0.localEulerAngles = var_504_9

				local var_504_10 = GameObjectTools.GetOrAddComponent(var_504_0.gameObject, typeof(DynamicBoneHelper))

				if var_504_10 then
					var_504_10:EnableDynamicBone(true)
				end
			end

			local var_504_11 = arg_501_1.actors_["1075ui_actor"]
			local var_504_12 = 0

			if var_504_12 < arg_501_1.time_ and arg_501_1.time_ <= var_504_12 + arg_504_0 and not isNil(var_504_11) and arg_501_1.var_.characterEffect1075ui_actor == nil then
				arg_501_1.var_.characterEffect1075ui_actor = var_504_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_504_13 = 0.200000002980232

			if var_504_12 <= arg_501_1.time_ and arg_501_1.time_ < var_504_12 + var_504_13 and not isNil(var_504_11) then
				local var_504_14 = (arg_501_1.time_ - var_504_12) / var_504_13

				if arg_501_1.var_.characterEffect1075ui_actor and not isNil(var_504_11) then
					local var_504_15 = Mathf.Lerp(0, 0.5, var_504_14)

					arg_501_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_501_1.var_.characterEffect1075ui_actor.fillRatio = var_504_15
				end
			end

			if arg_501_1.time_ >= var_504_12 + var_504_13 and arg_501_1.time_ < var_504_12 + var_504_13 + arg_504_0 and not isNil(var_504_11) and arg_501_1.var_.characterEffect1075ui_actor then
				local var_504_16 = 0.5

				arg_501_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_501_1.var_.characterEffect1075ui_actor.fillRatio = var_504_16
			end

			local var_504_17 = 0.034000001847744
			local var_504_18 = 1

			if var_504_17 < arg_501_1.time_ and arg_501_1.time_ <= var_504_17 + arg_504_0 then
				local var_504_19 = "play"
				local var_504_20 = "effect"

				arg_501_1:AudioAction(var_504_19, var_504_20, "se_story_1310", "se_story_1310_plate", "")
			end

			local var_504_21 = 0
			local var_504_22 = 0.725

			if var_504_21 < arg_501_1.time_ and arg_501_1.time_ <= var_504_21 + arg_504_0 then
				arg_501_1.talkMaxDuration = 0
				arg_501_1.dialogCg_.alpha = 1

				arg_501_1.dialog_:SetActive(true)
				SetActive(arg_501_1.leftNameGo_, false)

				arg_501_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_501_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_501_1:RecordName(arg_501_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_501_1.iconTrs_.gameObject, false)
				arg_501_1.callingController_:SetSelectedState("normal")

				local var_504_23 = arg_501_1:GetWordFromCfg(1107505126)
				local var_504_24 = arg_501_1:FormatText(var_504_23.content)

				arg_501_1.text_.text = var_504_24

				LuaForUtil.ClearLinePrefixSymbol(arg_501_1.text_)

				local var_504_25 = 29
				local var_504_26 = utf8.len(var_504_24)
				local var_504_27 = var_504_25 <= 0 and var_504_22 or var_504_22 * (var_504_26 / var_504_25)

				if var_504_27 > 0 and var_504_22 < var_504_27 then
					arg_501_1.talkMaxDuration = var_504_27

					if var_504_27 + var_504_21 > arg_501_1.duration_ then
						arg_501_1.duration_ = var_504_27 + var_504_21
					end
				end

				arg_501_1.text_.text = var_504_24
				arg_501_1.typewritter.percent = 0

				arg_501_1.typewritter:SetDirty()
				arg_501_1:ShowNextGo(false)
				arg_501_1:RecordContent(arg_501_1.text_.text)
			end

			local var_504_28 = math.max(var_504_22, arg_501_1.talkMaxDuration)

			if var_504_21 <= arg_501_1.time_ and arg_501_1.time_ < var_504_21 + var_504_28 then
				arg_501_1.typewritter.percent = (arg_501_1.time_ - var_504_21) / var_504_28

				arg_501_1.typewritter:SetDirty()
			end

			if arg_501_1.time_ >= var_504_21 + var_504_28 and arg_501_1.time_ < var_504_21 + var_504_28 + arg_504_0 then
				arg_501_1.typewritter.percent = 1

				arg_501_1.typewritter:SetDirty()
				arg_501_1:ShowNextGo(true)
			end
		end

		arg_501_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_actor",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_501_1:InitPlayNodeList()
	end,
	Play1107505127 = function(arg_505_0, arg_505_1)
		arg_505_1.time_ = 0
		arg_505_1.frameCnt_ = 0
		arg_505_1.state_ = "playing"
		arg_505_1.curTalkId_ = 1107505127
		arg_505_1.duration_ = 5

		SetActive(arg_505_1.tipsGo_, false)

		function arg_505_1.onSingleLineFinish_()
			arg_505_1.onSingleLineUpdate_ = nil
			arg_505_1.onSingleLineFinish_ = nil
			arg_505_1.state_ = "waiting"
		end

		function arg_505_1.playNext_(arg_507_0)
			if arg_507_0 == 1 then
				arg_505_0:Play1107505128(arg_505_1)
			end
		end

		function arg_505_1.onSingleLineUpdate_(arg_508_0)
			local var_508_0 = 0
			local var_508_1 = 0.65

			if var_508_0 < arg_505_1.time_ and arg_505_1.time_ <= var_508_0 + arg_508_0 then
				arg_505_1.talkMaxDuration = 0
				arg_505_1.dialogCg_.alpha = 1

				arg_505_1.dialog_:SetActive(true)
				SetActive(arg_505_1.leftNameGo_, true)

				local var_508_2 = arg_505_1:FormatText(StoryNameCfg[7].name)

				arg_505_1.leftNameTxt_.text = var_508_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_505_1.leftNameTxt_.transform)

				arg_505_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_505_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_505_1:RecordName(arg_505_1.leftNameTxt_.text)
				SetActive(arg_505_1.iconTrs_.gameObject, true)
				arg_505_1.iconController_:SetSelectedState("hero")

				arg_505_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_505_1.callingController_:SetSelectedState("normal")

				arg_505_1.keyicon_.color = Color.New(1, 1, 1)
				arg_505_1.icon_.color = Color.New(1, 1, 1)

				local var_508_3 = arg_505_1:GetWordFromCfg(1107505127)
				local var_508_4 = arg_505_1:FormatText(var_508_3.content)

				arg_505_1.text_.text = var_508_4

				LuaForUtil.ClearLinePrefixSymbol(arg_505_1.text_)

				local var_508_5 = 26
				local var_508_6 = utf8.len(var_508_4)
				local var_508_7 = var_508_5 <= 0 and var_508_1 or var_508_1 * (var_508_6 / var_508_5)

				if var_508_7 > 0 and var_508_1 < var_508_7 then
					arg_505_1.talkMaxDuration = var_508_7

					if var_508_7 + var_508_0 > arg_505_1.duration_ then
						arg_505_1.duration_ = var_508_7 + var_508_0
					end
				end

				arg_505_1.text_.text = var_508_4
				arg_505_1.typewritter.percent = 0

				arg_505_1.typewritter:SetDirty()
				arg_505_1:ShowNextGo(false)
				arg_505_1:RecordContent(arg_505_1.text_.text)
			end

			local var_508_8 = math.max(var_508_1, arg_505_1.talkMaxDuration)

			if var_508_0 <= arg_505_1.time_ and arg_505_1.time_ < var_508_0 + var_508_8 then
				arg_505_1.typewritter.percent = (arg_505_1.time_ - var_508_0) / var_508_8

				arg_505_1.typewritter:SetDirty()
			end

			if arg_505_1.time_ >= var_508_0 + var_508_8 and arg_505_1.time_ < var_508_0 + var_508_8 + arg_508_0 then
				arg_505_1.typewritter.percent = 1

				arg_505_1.typewritter:SetDirty()
				arg_505_1:ShowNextGo(true)
			end
		end

		arg_505_1.nodeConfigList_ = {}

		arg_505_1:InitPlayNodeList()
	end,
	Play1107505128 = function(arg_509_0, arg_509_1)
		arg_509_1.time_ = 0
		arg_509_1.frameCnt_ = 0
		arg_509_1.state_ = "playing"
		arg_509_1.curTalkId_ = 1107505128
		arg_509_1.duration_ = 5

		SetActive(arg_509_1.tipsGo_, false)

		function arg_509_1.onSingleLineFinish_()
			arg_509_1.onSingleLineUpdate_ = nil
			arg_509_1.onSingleLineFinish_ = nil
			arg_509_1.state_ = "waiting"
		end

		function arg_509_1.playNext_(arg_511_0)
			if arg_511_0 == 1 then
				arg_509_0:Play1107505129(arg_509_1)
			end
		end

		function arg_509_1.onSingleLineUpdate_(arg_512_0)
			local var_512_0 = 0
			local var_512_1 = 0.925

			if var_512_0 < arg_509_1.time_ and arg_509_1.time_ <= var_512_0 + arg_512_0 then
				arg_509_1.talkMaxDuration = 0
				arg_509_1.dialogCg_.alpha = 1

				arg_509_1.dialog_:SetActive(true)
				SetActive(arg_509_1.leftNameGo_, false)

				arg_509_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_509_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_509_1:RecordName(arg_509_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_509_1.iconTrs_.gameObject, false)
				arg_509_1.callingController_:SetSelectedState("normal")

				local var_512_2 = arg_509_1:GetWordFromCfg(1107505128)
				local var_512_3 = arg_509_1:FormatText(var_512_2.content)

				arg_509_1.text_.text = var_512_3

				LuaForUtil.ClearLinePrefixSymbol(arg_509_1.text_)

				local var_512_4 = 37
				local var_512_5 = utf8.len(var_512_3)
				local var_512_6 = var_512_4 <= 0 and var_512_1 or var_512_1 * (var_512_5 / var_512_4)

				if var_512_6 > 0 and var_512_1 < var_512_6 then
					arg_509_1.talkMaxDuration = var_512_6

					if var_512_6 + var_512_0 > arg_509_1.duration_ then
						arg_509_1.duration_ = var_512_6 + var_512_0
					end
				end

				arg_509_1.text_.text = var_512_3
				arg_509_1.typewritter.percent = 0

				arg_509_1.typewritter:SetDirty()
				arg_509_1:ShowNextGo(false)
				arg_509_1:RecordContent(arg_509_1.text_.text)
			end

			local var_512_7 = math.max(var_512_1, arg_509_1.talkMaxDuration)

			if var_512_0 <= arg_509_1.time_ and arg_509_1.time_ < var_512_0 + var_512_7 then
				arg_509_1.typewritter.percent = (arg_509_1.time_ - var_512_0) / var_512_7

				arg_509_1.typewritter:SetDirty()
			end

			if arg_509_1.time_ >= var_512_0 + var_512_7 and arg_509_1.time_ < var_512_0 + var_512_7 + arg_512_0 then
				arg_509_1.typewritter.percent = 1

				arg_509_1.typewritter:SetDirty()
				arg_509_1:ShowNextGo(true)
			end
		end

		arg_509_1.nodeConfigList_ = {}

		arg_509_1:InitPlayNodeList()
	end,
	Play1107505129 = function(arg_513_0, arg_513_1)
		arg_513_1.time_ = 0
		arg_513_1.frameCnt_ = 0
		arg_513_1.state_ = "playing"
		arg_513_1.curTalkId_ = 1107505129
		arg_513_1.duration_ = 1

		SetActive(arg_513_1.tipsGo_, false)

		function arg_513_1.onSingleLineFinish_()
			arg_513_1.onSingleLineUpdate_ = nil
			arg_513_1.onSingleLineFinish_ = nil
			arg_513_1.state_ = "waiting"

			SetActive(arg_513_1.choicesGo_, true)

			for iter_514_0, iter_514_1 in ipairs(arg_513_1.choices_) do
				local var_514_0 = iter_514_0 <= 1

				SetActive(iter_514_1.go, var_514_0)
			end

			arg_513_1.choices_[1].txt.text = arg_513_1:FormatText(StoryChoiceCfg[1165].name)
		end

		function arg_513_1.playNext_(arg_515_0)
			if arg_515_0 == 1 then
				arg_513_0:Play1107505130(arg_513_1)
			end

			arg_513_1:RecordChoiceLog(1107505129, 1165)
		end

		function arg_513_1.onSingleLineUpdate_(arg_516_0)
			local var_516_0 = 0

			if var_516_0 < arg_513_1.time_ and arg_513_1.time_ <= var_516_0 + arg_516_0 then
				arg_513_1.allBtn_.enabled = false
			end

			local var_516_1 = 0.5

			if arg_513_1.time_ >= var_516_0 + var_516_1 and arg_513_1.time_ < var_516_0 + var_516_1 + arg_516_0 then
				arg_513_1.allBtn_.enabled = true
			end
		end

		arg_513_1.nodeConfigList_ = {}

		arg_513_1:InitPlayNodeList()
	end,
	Play1107505130 = function(arg_517_0, arg_517_1)
		arg_517_1.time_ = 0
		arg_517_1.frameCnt_ = 0
		arg_517_1.state_ = "playing"
		arg_517_1.curTalkId_ = 1107505130
		arg_517_1.duration_ = 5

		SetActive(arg_517_1.tipsGo_, false)

		function arg_517_1.onSingleLineFinish_()
			arg_517_1.onSingleLineUpdate_ = nil
			arg_517_1.onSingleLineFinish_ = nil
			arg_517_1.state_ = "waiting"
		end

		function arg_517_1.playNext_(arg_519_0)
			if arg_519_0 == 1 then
				arg_517_0:Play1107505131(arg_517_1)
			end
		end

		function arg_517_1.onSingleLineUpdate_(arg_520_0)
			local var_520_0 = 0
			local var_520_1 = 1.125

			if var_520_0 < arg_517_1.time_ and arg_517_1.time_ <= var_520_0 + arg_520_0 then
				arg_517_1.talkMaxDuration = 0
				arg_517_1.dialogCg_.alpha = 1

				arg_517_1.dialog_:SetActive(true)
				SetActive(arg_517_1.leftNameGo_, false)

				arg_517_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_517_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_517_1:RecordName(arg_517_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_517_1.iconTrs_.gameObject, false)
				arg_517_1.callingController_:SetSelectedState("normal")

				local var_520_2 = arg_517_1:GetWordFromCfg(1107505130)
				local var_520_3 = arg_517_1:FormatText(var_520_2.content)

				arg_517_1.text_.text = var_520_3

				LuaForUtil.ClearLinePrefixSymbol(arg_517_1.text_)

				local var_520_4 = 45
				local var_520_5 = utf8.len(var_520_3)
				local var_520_6 = var_520_4 <= 0 and var_520_1 or var_520_1 * (var_520_5 / var_520_4)

				if var_520_6 > 0 and var_520_1 < var_520_6 then
					arg_517_1.talkMaxDuration = var_520_6

					if var_520_6 + var_520_0 > arg_517_1.duration_ then
						arg_517_1.duration_ = var_520_6 + var_520_0
					end
				end

				arg_517_1.text_.text = var_520_3
				arg_517_1.typewritter.percent = 0

				arg_517_1.typewritter:SetDirty()
				arg_517_1:ShowNextGo(false)
				arg_517_1:RecordContent(arg_517_1.text_.text)
			end

			local var_520_7 = math.max(var_520_1, arg_517_1.talkMaxDuration)

			if var_520_0 <= arg_517_1.time_ and arg_517_1.time_ < var_520_0 + var_520_7 then
				arg_517_1.typewritter.percent = (arg_517_1.time_ - var_520_0) / var_520_7

				arg_517_1.typewritter:SetDirty()
			end

			if arg_517_1.time_ >= var_520_0 + var_520_7 and arg_517_1.time_ < var_520_0 + var_520_7 + arg_520_0 then
				arg_517_1.typewritter.percent = 1

				arg_517_1.typewritter:SetDirty()
				arg_517_1:ShowNextGo(true)
			end
		end

		arg_517_1.nodeConfigList_ = {}

		arg_517_1:InitPlayNodeList()
	end,
	Play1107505131 = function(arg_521_0, arg_521_1)
		arg_521_1.time_ = 0
		arg_521_1.frameCnt_ = 0
		arg_521_1.state_ = "playing"
		arg_521_1.curTalkId_ = 1107505131
		arg_521_1.duration_ = 3.67

		SetActive(arg_521_1.tipsGo_, false)

		function arg_521_1.onSingleLineFinish_()
			arg_521_1.onSingleLineUpdate_ = nil
			arg_521_1.onSingleLineFinish_ = nil
			arg_521_1.state_ = "waiting"
		end

		function arg_521_1.playNext_(arg_523_0)
			if arg_523_0 == 1 then
				arg_521_0:Play1107505132(arg_521_1)
			end
		end

		function arg_521_1.onSingleLineUpdate_(arg_524_0)
			local var_524_0 = arg_521_1.actors_["1075ui_actor"].transform
			local var_524_1 = 0

			if var_524_1 < arg_521_1.time_ and arg_521_1.time_ <= var_524_1 + arg_524_0 then
				arg_521_1.var_.moveOldPos1075ui_actor = var_524_0.localPosition

				local var_524_2 = GameObjectTools.GetOrAddComponent(var_524_0.gameObject, typeof(DynamicBoneHelper))

				if var_524_2 then
					var_524_2:EnableDynamicBone(false)
				end
			end

			local var_524_3 = 0.001

			if var_524_1 <= arg_521_1.time_ and arg_521_1.time_ < var_524_1 + var_524_3 then
				local var_524_4 = (arg_521_1.time_ - var_524_1) / var_524_3
				local var_524_5 = Vector3.New(0, -1.055, -6.16)

				var_524_0.localPosition = Vector3.Lerp(arg_521_1.var_.moveOldPos1075ui_actor, var_524_5, var_524_4)

				local var_524_6 = manager.ui.mainCamera.transform.position - var_524_0.position

				var_524_0.forward = Vector3.New(var_524_6.x, var_524_6.y, var_524_6.z)

				local var_524_7 = var_524_0.localEulerAngles

				var_524_7.z = 0
				var_524_7.x = 0
				var_524_0.localEulerAngles = var_524_7
			end

			if arg_521_1.time_ >= var_524_1 + var_524_3 and arg_521_1.time_ < var_524_1 + var_524_3 + arg_524_0 then
				var_524_0.localPosition = Vector3.New(0, -1.055, -6.16)

				local var_524_8 = manager.ui.mainCamera.transform.position - var_524_0.position

				var_524_0.forward = Vector3.New(var_524_8.x, var_524_8.y, var_524_8.z)

				local var_524_9 = var_524_0.localEulerAngles

				var_524_9.z = 0
				var_524_9.x = 0
				var_524_0.localEulerAngles = var_524_9

				local var_524_10 = GameObjectTools.GetOrAddComponent(var_524_0.gameObject, typeof(DynamicBoneHelper))

				if var_524_10 then
					var_524_10:EnableDynamicBone(true)
				end
			end

			local var_524_11 = arg_521_1.actors_["1075ui_actor"]
			local var_524_12 = 0

			if var_524_12 < arg_521_1.time_ and arg_521_1.time_ <= var_524_12 + arg_524_0 and not isNil(var_524_11) and arg_521_1.var_.characterEffect1075ui_actor == nil then
				arg_521_1.var_.characterEffect1075ui_actor = var_524_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_524_13 = 0.200000002980232

			if var_524_12 <= arg_521_1.time_ and arg_521_1.time_ < var_524_12 + var_524_13 and not isNil(var_524_11) then
				local var_524_14 = (arg_521_1.time_ - var_524_12) / var_524_13

				if arg_521_1.var_.characterEffect1075ui_actor and not isNil(var_524_11) then
					arg_521_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_521_1.time_ >= var_524_12 + var_524_13 and arg_521_1.time_ < var_524_12 + var_524_13 + arg_524_0 and not isNil(var_524_11) and arg_521_1.var_.characterEffect1075ui_actor then
				arg_521_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			local var_524_15 = 0

			if var_524_15 < arg_521_1.time_ and arg_521_1.time_ <= var_524_15 + arg_524_0 then
				arg_521_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075action/1075action4_1")
			end

			local var_524_16 = 0

			if var_524_16 < arg_521_1.time_ and arg_521_1.time_ <= var_524_16 + arg_524_0 then
				arg_521_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_524_17 = 0
			local var_524_18 = 0.375

			if var_524_17 < arg_521_1.time_ and arg_521_1.time_ <= var_524_17 + arg_524_0 then
				arg_521_1.talkMaxDuration = 0
				arg_521_1.dialogCg_.alpha = 1

				arg_521_1.dialog_:SetActive(true)
				SetActive(arg_521_1.leftNameGo_, true)

				local var_524_19 = arg_521_1:FormatText(StoryNameCfg[381].name)

				arg_521_1.leftNameTxt_.text = var_524_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_521_1.leftNameTxt_.transform)

				arg_521_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_521_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_521_1:RecordName(arg_521_1.leftNameTxt_.text)
				SetActive(arg_521_1.iconTrs_.gameObject, false)
				arg_521_1.callingController_:SetSelectedState("normal")

				local var_524_20 = arg_521_1:GetWordFromCfg(1107505131)
				local var_524_21 = arg_521_1:FormatText(var_524_20.content)

				arg_521_1.text_.text = var_524_21

				LuaForUtil.ClearLinePrefixSymbol(arg_521_1.text_)

				local var_524_22 = 15
				local var_524_23 = utf8.len(var_524_21)
				local var_524_24 = var_524_22 <= 0 and var_524_18 or var_524_18 * (var_524_23 / var_524_22)

				if var_524_24 > 0 and var_524_18 < var_524_24 then
					arg_521_1.talkMaxDuration = var_524_24

					if var_524_24 + var_524_17 > arg_521_1.duration_ then
						arg_521_1.duration_ = var_524_24 + var_524_17
					end
				end

				arg_521_1.text_.text = var_524_21
				arg_521_1.typewritter.percent = 0

				arg_521_1.typewritter:SetDirty()
				arg_521_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107505", "1107505131", "story_v_side_new_1107505.awb") ~= 0 then
					local var_524_25 = manager.audio:GetVoiceLength("story_v_side_new_1107505", "1107505131", "story_v_side_new_1107505.awb") / 1000

					if var_524_25 + var_524_17 > arg_521_1.duration_ then
						arg_521_1.duration_ = var_524_25 + var_524_17
					end

					if var_524_20.prefab_name ~= "" and arg_521_1.actors_[var_524_20.prefab_name] ~= nil then
						local var_524_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_521_1.actors_[var_524_20.prefab_name].transform, "story_v_side_new_1107505", "1107505131", "story_v_side_new_1107505.awb")

						arg_521_1:RecordAudio("1107505131", var_524_26)
						arg_521_1:RecordAudio("1107505131", var_524_26)
					else
						arg_521_1:AudioAction("play", "voice", "story_v_side_new_1107505", "1107505131", "story_v_side_new_1107505.awb")
					end

					arg_521_1:RecordHistoryTalkVoice("story_v_side_new_1107505", "1107505131", "story_v_side_new_1107505.awb")
				end

				arg_521_1:RecordContent(arg_521_1.text_.text)
			end

			local var_524_27 = math.max(var_524_18, arg_521_1.talkMaxDuration)

			if var_524_17 <= arg_521_1.time_ and arg_521_1.time_ < var_524_17 + var_524_27 then
				arg_521_1.typewritter.percent = (arg_521_1.time_ - var_524_17) / var_524_27

				arg_521_1.typewritter:SetDirty()
			end

			if arg_521_1.time_ >= var_524_17 + var_524_27 and arg_521_1.time_ < var_524_17 + var_524_27 + arg_524_0 then
				arg_521_1.typewritter.percent = 1

				arg_521_1.typewritter:SetDirty()
				arg_521_1:ShowNextGo(true)
			end
		end

		arg_521_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_actor",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_521_1:InitPlayNodeList()
	end,
	Play1107505132 = function(arg_525_0, arg_525_1)
		arg_525_1.time_ = 0
		arg_525_1.frameCnt_ = 0
		arg_525_1.state_ = "playing"
		arg_525_1.curTalkId_ = 1107505132
		arg_525_1.duration_ = 5

		SetActive(arg_525_1.tipsGo_, false)

		function arg_525_1.onSingleLineFinish_()
			arg_525_1.onSingleLineUpdate_ = nil
			arg_525_1.onSingleLineFinish_ = nil
			arg_525_1.state_ = "waiting"
		end

		function arg_525_1.playNext_(arg_527_0)
			if arg_527_0 == 1 then
				arg_525_0:Play1107505133(arg_525_1)
			end
		end

		function arg_525_1.onSingleLineUpdate_(arg_528_0)
			local var_528_0 = arg_525_1.actors_["1075ui_actor"]
			local var_528_1 = 0

			if var_528_1 < arg_525_1.time_ and arg_525_1.time_ <= var_528_1 + arg_528_0 and not isNil(var_528_0) and arg_525_1.var_.characterEffect1075ui_actor == nil then
				arg_525_1.var_.characterEffect1075ui_actor = var_528_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_528_2 = 0.200000002980232

			if var_528_1 <= arg_525_1.time_ and arg_525_1.time_ < var_528_1 + var_528_2 and not isNil(var_528_0) then
				local var_528_3 = (arg_525_1.time_ - var_528_1) / var_528_2

				if arg_525_1.var_.characterEffect1075ui_actor and not isNil(var_528_0) then
					local var_528_4 = Mathf.Lerp(0, 0.5, var_528_3)

					arg_525_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_525_1.var_.characterEffect1075ui_actor.fillRatio = var_528_4
				end
			end

			if arg_525_1.time_ >= var_528_1 + var_528_2 and arg_525_1.time_ < var_528_1 + var_528_2 + arg_528_0 and not isNil(var_528_0) and arg_525_1.var_.characterEffect1075ui_actor then
				local var_528_5 = 0.5

				arg_525_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_525_1.var_.characterEffect1075ui_actor.fillRatio = var_528_5
			end

			local var_528_6 = 0
			local var_528_7 = 0.45

			if var_528_6 < arg_525_1.time_ and arg_525_1.time_ <= var_528_6 + arg_528_0 then
				arg_525_1.talkMaxDuration = 0
				arg_525_1.dialogCg_.alpha = 1

				arg_525_1.dialog_:SetActive(true)
				SetActive(arg_525_1.leftNameGo_, true)

				local var_528_8 = arg_525_1:FormatText(StoryNameCfg[7].name)

				arg_525_1.leftNameTxt_.text = var_528_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_525_1.leftNameTxt_.transform)

				arg_525_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_525_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_525_1:RecordName(arg_525_1.leftNameTxt_.text)
				SetActive(arg_525_1.iconTrs_.gameObject, true)
				arg_525_1.iconController_:SetSelectedState("hero")

				arg_525_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_525_1.callingController_:SetSelectedState("normal")

				arg_525_1.keyicon_.color = Color.New(1, 1, 1)
				arg_525_1.icon_.color = Color.New(1, 1, 1)

				local var_528_9 = arg_525_1:GetWordFromCfg(1107505132)
				local var_528_10 = arg_525_1:FormatText(var_528_9.content)

				arg_525_1.text_.text = var_528_10

				LuaForUtil.ClearLinePrefixSymbol(arg_525_1.text_)

				local var_528_11 = 18
				local var_528_12 = utf8.len(var_528_10)
				local var_528_13 = var_528_11 <= 0 and var_528_7 or var_528_7 * (var_528_12 / var_528_11)

				if var_528_13 > 0 and var_528_7 < var_528_13 then
					arg_525_1.talkMaxDuration = var_528_13

					if var_528_13 + var_528_6 > arg_525_1.duration_ then
						arg_525_1.duration_ = var_528_13 + var_528_6
					end
				end

				arg_525_1.text_.text = var_528_10
				arg_525_1.typewritter.percent = 0

				arg_525_1.typewritter:SetDirty()
				arg_525_1:ShowNextGo(false)
				arg_525_1:RecordContent(arg_525_1.text_.text)
			end

			local var_528_14 = math.max(var_528_7, arg_525_1.talkMaxDuration)

			if var_528_6 <= arg_525_1.time_ and arg_525_1.time_ < var_528_6 + var_528_14 then
				arg_525_1.typewritter.percent = (arg_525_1.time_ - var_528_6) / var_528_14

				arg_525_1.typewritter:SetDirty()
			end

			if arg_525_1.time_ >= var_528_6 + var_528_14 and arg_525_1.time_ < var_528_6 + var_528_14 + arg_528_0 then
				arg_525_1.typewritter.percent = 1

				arg_525_1.typewritter:SetDirty()
				arg_525_1:ShowNextGo(true)
			end
		end

		arg_525_1.nodeConfigList_ = {}

		arg_525_1:InitPlayNodeList()
	end,
	Play1107505133 = function(arg_529_0, arg_529_1)
		arg_529_1.time_ = 0
		arg_529_1.frameCnt_ = 0
		arg_529_1.state_ = "playing"
		arg_529_1.curTalkId_ = 1107505133
		arg_529_1.duration_ = 2

		SetActive(arg_529_1.tipsGo_, false)

		function arg_529_1.onSingleLineFinish_()
			arg_529_1.onSingleLineUpdate_ = nil
			arg_529_1.onSingleLineFinish_ = nil
			arg_529_1.state_ = "waiting"
		end

		function arg_529_1.playNext_(arg_531_0)
			if arg_531_0 == 1 then
				arg_529_0:Play1107505134(arg_529_1)
			end
		end

		function arg_529_1.onSingleLineUpdate_(arg_532_0)
			local var_532_0 = arg_529_1.actors_["1075ui_actor"]
			local var_532_1 = 0

			if var_532_1 < arg_529_1.time_ and arg_529_1.time_ <= var_532_1 + arg_532_0 and not isNil(var_532_0) and arg_529_1.var_.characterEffect1075ui_actor == nil then
				arg_529_1.var_.characterEffect1075ui_actor = var_532_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_532_2 = 0.200000002980232

			if var_532_1 <= arg_529_1.time_ and arg_529_1.time_ < var_532_1 + var_532_2 and not isNil(var_532_0) then
				local var_532_3 = (arg_529_1.time_ - var_532_1) / var_532_2

				if arg_529_1.var_.characterEffect1075ui_actor and not isNil(var_532_0) then
					arg_529_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_529_1.time_ >= var_532_1 + var_532_2 and arg_529_1.time_ < var_532_1 + var_532_2 + arg_532_0 and not isNil(var_532_0) and arg_529_1.var_.characterEffect1075ui_actor then
				arg_529_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			local var_532_4 = 0

			if var_532_4 < arg_529_1.time_ and arg_529_1.time_ <= var_532_4 + arg_532_0 then
				arg_529_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075action/1075action4_2")
			end

			local var_532_5 = 0

			if var_532_5 < arg_529_1.time_ and arg_529_1.time_ <= var_532_5 + arg_532_0 then
				arg_529_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_532_6 = 0
			local var_532_7 = 0.225

			if var_532_6 < arg_529_1.time_ and arg_529_1.time_ <= var_532_6 + arg_532_0 then
				arg_529_1.talkMaxDuration = 0
				arg_529_1.dialogCg_.alpha = 1

				arg_529_1.dialog_:SetActive(true)
				SetActive(arg_529_1.leftNameGo_, true)

				local var_532_8 = arg_529_1:FormatText(StoryNameCfg[381].name)

				arg_529_1.leftNameTxt_.text = var_532_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_529_1.leftNameTxt_.transform)

				arg_529_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_529_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_529_1:RecordName(arg_529_1.leftNameTxt_.text)
				SetActive(arg_529_1.iconTrs_.gameObject, false)
				arg_529_1.callingController_:SetSelectedState("normal")

				local var_532_9 = arg_529_1:GetWordFromCfg(1107505133)
				local var_532_10 = arg_529_1:FormatText(var_532_9.content)

				arg_529_1.text_.text = var_532_10

				LuaForUtil.ClearLinePrefixSymbol(arg_529_1.text_)

				local var_532_11 = 9
				local var_532_12 = utf8.len(var_532_10)
				local var_532_13 = var_532_11 <= 0 and var_532_7 or var_532_7 * (var_532_12 / var_532_11)

				if var_532_13 > 0 and var_532_7 < var_532_13 then
					arg_529_1.talkMaxDuration = var_532_13

					if var_532_13 + var_532_6 > arg_529_1.duration_ then
						arg_529_1.duration_ = var_532_13 + var_532_6
					end
				end

				arg_529_1.text_.text = var_532_10
				arg_529_1.typewritter.percent = 0

				arg_529_1.typewritter:SetDirty()
				arg_529_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107505", "1107505133", "story_v_side_new_1107505.awb") ~= 0 then
					local var_532_14 = manager.audio:GetVoiceLength("story_v_side_new_1107505", "1107505133", "story_v_side_new_1107505.awb") / 1000

					if var_532_14 + var_532_6 > arg_529_1.duration_ then
						arg_529_1.duration_ = var_532_14 + var_532_6
					end

					if var_532_9.prefab_name ~= "" and arg_529_1.actors_[var_532_9.prefab_name] ~= nil then
						local var_532_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_529_1.actors_[var_532_9.prefab_name].transform, "story_v_side_new_1107505", "1107505133", "story_v_side_new_1107505.awb")

						arg_529_1:RecordAudio("1107505133", var_532_15)
						arg_529_1:RecordAudio("1107505133", var_532_15)
					else
						arg_529_1:AudioAction("play", "voice", "story_v_side_new_1107505", "1107505133", "story_v_side_new_1107505.awb")
					end

					arg_529_1:RecordHistoryTalkVoice("story_v_side_new_1107505", "1107505133", "story_v_side_new_1107505.awb")
				end

				arg_529_1:RecordContent(arg_529_1.text_.text)
			end

			local var_532_16 = math.max(var_532_7, arg_529_1.talkMaxDuration)

			if var_532_6 <= arg_529_1.time_ and arg_529_1.time_ < var_532_6 + var_532_16 then
				arg_529_1.typewritter.percent = (arg_529_1.time_ - var_532_6) / var_532_16

				arg_529_1.typewritter:SetDirty()
			end

			if arg_529_1.time_ >= var_532_6 + var_532_16 and arg_529_1.time_ < var_532_6 + var_532_16 + arg_532_0 then
				arg_529_1.typewritter.percent = 1

				arg_529_1.typewritter:SetDirty()
				arg_529_1:ShowNextGo(true)
			end
		end

		arg_529_1.nodeConfigList_ = {}

		arg_529_1:InitPlayNodeList()
	end,
	Play1107505134 = function(arg_533_0, arg_533_1)
		arg_533_1.time_ = 0
		arg_533_1.frameCnt_ = 0
		arg_533_1.state_ = "playing"
		arg_533_1.curTalkId_ = 1107505134
		arg_533_1.duration_ = 5

		SetActive(arg_533_1.tipsGo_, false)

		function arg_533_1.onSingleLineFinish_()
			arg_533_1.onSingleLineUpdate_ = nil
			arg_533_1.onSingleLineFinish_ = nil
			arg_533_1.state_ = "waiting"
		end

		function arg_533_1.playNext_(arg_535_0)
			if arg_535_0 == 1 then
				arg_533_0:Play1107505135(arg_533_1)
			end
		end

		function arg_533_1.onSingleLineUpdate_(arg_536_0)
			local var_536_0 = arg_533_1.actors_["1075ui_actor"]
			local var_536_1 = 0

			if var_536_1 < arg_533_1.time_ and arg_533_1.time_ <= var_536_1 + arg_536_0 and not isNil(var_536_0) and arg_533_1.var_.characterEffect1075ui_actor == nil then
				arg_533_1.var_.characterEffect1075ui_actor = var_536_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_536_2 = 0.200000002980232

			if var_536_1 <= arg_533_1.time_ and arg_533_1.time_ < var_536_1 + var_536_2 and not isNil(var_536_0) then
				local var_536_3 = (arg_533_1.time_ - var_536_1) / var_536_2

				if arg_533_1.var_.characterEffect1075ui_actor and not isNil(var_536_0) then
					local var_536_4 = Mathf.Lerp(0, 0.5, var_536_3)

					arg_533_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_533_1.var_.characterEffect1075ui_actor.fillRatio = var_536_4
				end
			end

			if arg_533_1.time_ >= var_536_1 + var_536_2 and arg_533_1.time_ < var_536_1 + var_536_2 + arg_536_0 and not isNil(var_536_0) and arg_533_1.var_.characterEffect1075ui_actor then
				local var_536_5 = 0.5

				arg_533_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_533_1.var_.characterEffect1075ui_actor.fillRatio = var_536_5
			end

			local var_536_6 = 0
			local var_536_7 = 0.975

			if var_536_6 < arg_533_1.time_ and arg_533_1.time_ <= var_536_6 + arg_536_0 then
				arg_533_1.talkMaxDuration = 0
				arg_533_1.dialogCg_.alpha = 1

				arg_533_1.dialog_:SetActive(true)
				SetActive(arg_533_1.leftNameGo_, false)

				arg_533_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_533_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_533_1:RecordName(arg_533_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_533_1.iconTrs_.gameObject, false)
				arg_533_1.callingController_:SetSelectedState("normal")

				local var_536_8 = arg_533_1:GetWordFromCfg(1107505134)
				local var_536_9 = arg_533_1:FormatText(var_536_8.content)

				arg_533_1.text_.text = var_536_9

				LuaForUtil.ClearLinePrefixSymbol(arg_533_1.text_)

				local var_536_10 = 39
				local var_536_11 = utf8.len(var_536_9)
				local var_536_12 = var_536_10 <= 0 and var_536_7 or var_536_7 * (var_536_11 / var_536_10)

				if var_536_12 > 0 and var_536_7 < var_536_12 then
					arg_533_1.talkMaxDuration = var_536_12

					if var_536_12 + var_536_6 > arg_533_1.duration_ then
						arg_533_1.duration_ = var_536_12 + var_536_6
					end
				end

				arg_533_1.text_.text = var_536_9
				arg_533_1.typewritter.percent = 0

				arg_533_1.typewritter:SetDirty()
				arg_533_1:ShowNextGo(false)
				arg_533_1:RecordContent(arg_533_1.text_.text)
			end

			local var_536_13 = math.max(var_536_7, arg_533_1.talkMaxDuration)

			if var_536_6 <= arg_533_1.time_ and arg_533_1.time_ < var_536_6 + var_536_13 then
				arg_533_1.typewritter.percent = (arg_533_1.time_ - var_536_6) / var_536_13

				arg_533_1.typewritter:SetDirty()
			end

			if arg_533_1.time_ >= var_536_6 + var_536_13 and arg_533_1.time_ < var_536_6 + var_536_13 + arg_536_0 then
				arg_533_1.typewritter.percent = 1

				arg_533_1.typewritter:SetDirty()
				arg_533_1:ShowNextGo(true)
			end
		end

		arg_533_1.nodeConfigList_ = {}

		arg_533_1:InitPlayNodeList()
	end,
	Play1107505135 = function(arg_537_0, arg_537_1)
		arg_537_1.time_ = 0
		arg_537_1.frameCnt_ = 0
		arg_537_1.state_ = "playing"
		arg_537_1.curTalkId_ = 1107505135
		arg_537_1.duration_ = 5

		SetActive(arg_537_1.tipsGo_, false)

		function arg_537_1.onSingleLineFinish_()
			arg_537_1.onSingleLineUpdate_ = nil
			arg_537_1.onSingleLineFinish_ = nil
			arg_537_1.state_ = "waiting"
		end

		function arg_537_1.playNext_(arg_539_0)
			if arg_539_0 == 1 then
				arg_537_0:Play1107505136(arg_537_1)
			end
		end

		function arg_537_1.onSingleLineUpdate_(arg_540_0)
			local var_540_0 = 0
			local var_540_1 = 0.4

			if var_540_0 < arg_537_1.time_ and arg_537_1.time_ <= var_540_0 + arg_540_0 then
				arg_537_1.talkMaxDuration = 0
				arg_537_1.dialogCg_.alpha = 1

				arg_537_1.dialog_:SetActive(true)
				SetActive(arg_537_1.leftNameGo_, true)

				local var_540_2 = arg_537_1:FormatText(StoryNameCfg[7].name)

				arg_537_1.leftNameTxt_.text = var_540_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_537_1.leftNameTxt_.transform)

				arg_537_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_537_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_537_1:RecordName(arg_537_1.leftNameTxt_.text)
				SetActive(arg_537_1.iconTrs_.gameObject, true)
				arg_537_1.iconController_:SetSelectedState("hero")

				arg_537_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_537_1.callingController_:SetSelectedState("normal")

				arg_537_1.keyicon_.color = Color.New(1, 1, 1)
				arg_537_1.icon_.color = Color.New(1, 1, 1)

				local var_540_3 = arg_537_1:GetWordFromCfg(1107505135)
				local var_540_4 = arg_537_1:FormatText(var_540_3.content)

				arg_537_1.text_.text = var_540_4

				LuaForUtil.ClearLinePrefixSymbol(arg_537_1.text_)

				local var_540_5 = 16
				local var_540_6 = utf8.len(var_540_4)
				local var_540_7 = var_540_5 <= 0 and var_540_1 or var_540_1 * (var_540_6 / var_540_5)

				if var_540_7 > 0 and var_540_1 < var_540_7 then
					arg_537_1.talkMaxDuration = var_540_7

					if var_540_7 + var_540_0 > arg_537_1.duration_ then
						arg_537_1.duration_ = var_540_7 + var_540_0
					end
				end

				arg_537_1.text_.text = var_540_4
				arg_537_1.typewritter.percent = 0

				arg_537_1.typewritter:SetDirty()
				arg_537_1:ShowNextGo(false)
				arg_537_1:RecordContent(arg_537_1.text_.text)
			end

			local var_540_8 = math.max(var_540_1, arg_537_1.talkMaxDuration)

			if var_540_0 <= arg_537_1.time_ and arg_537_1.time_ < var_540_0 + var_540_8 then
				arg_537_1.typewritter.percent = (arg_537_1.time_ - var_540_0) / var_540_8

				arg_537_1.typewritter:SetDirty()
			end

			if arg_537_1.time_ >= var_540_0 + var_540_8 and arg_537_1.time_ < var_540_0 + var_540_8 + arg_540_0 then
				arg_537_1.typewritter.percent = 1

				arg_537_1.typewritter:SetDirty()
				arg_537_1:ShowNextGo(true)
			end
		end

		arg_537_1.nodeConfigList_ = {}

		arg_537_1:InitPlayNodeList()
	end,
	Play1107505136 = function(arg_541_0, arg_541_1)
		arg_541_1.time_ = 0
		arg_541_1.frameCnt_ = 0
		arg_541_1.state_ = "playing"
		arg_541_1.curTalkId_ = 1107505136
		arg_541_1.duration_ = 5.1

		SetActive(arg_541_1.tipsGo_, false)

		function arg_541_1.onSingleLineFinish_()
			arg_541_1.onSingleLineUpdate_ = nil
			arg_541_1.onSingleLineFinish_ = nil
			arg_541_1.state_ = "waiting"
		end

		function arg_541_1.playNext_(arg_543_0)
			if arg_543_0 == 1 then
				arg_541_0:Play1107505137(arg_541_1)
			end
		end

		function arg_541_1.onSingleLineUpdate_(arg_544_0)
			local var_544_0 = arg_541_1.actors_["1075ui_actor"]
			local var_544_1 = 0

			if var_544_1 < arg_541_1.time_ and arg_541_1.time_ <= var_544_1 + arg_544_0 and not isNil(var_544_0) and arg_541_1.var_.characterEffect1075ui_actor == nil then
				arg_541_1.var_.characterEffect1075ui_actor = var_544_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_544_2 = 0.200000002980232

			if var_544_1 <= arg_541_1.time_ and arg_541_1.time_ < var_544_1 + var_544_2 and not isNil(var_544_0) then
				local var_544_3 = (arg_541_1.time_ - var_544_1) / var_544_2

				if arg_541_1.var_.characterEffect1075ui_actor and not isNil(var_544_0) then
					arg_541_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_541_1.time_ >= var_544_1 + var_544_2 and arg_541_1.time_ < var_544_1 + var_544_2 + arg_544_0 and not isNil(var_544_0) and arg_541_1.var_.characterEffect1075ui_actor then
				arg_541_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			local var_544_4 = 0

			if var_544_4 < arg_541_1.time_ and arg_541_1.time_ <= var_544_4 + arg_544_0 then
				arg_541_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075action/1075action1_1")
			end

			local var_544_5 = 0

			if var_544_5 < arg_541_1.time_ and arg_541_1.time_ <= var_544_5 + arg_544_0 then
				arg_541_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_544_6 = 0
			local var_544_7 = 0.65

			if var_544_6 < arg_541_1.time_ and arg_541_1.time_ <= var_544_6 + arg_544_0 then
				arg_541_1.talkMaxDuration = 0
				arg_541_1.dialogCg_.alpha = 1

				arg_541_1.dialog_:SetActive(true)
				SetActive(arg_541_1.leftNameGo_, true)

				local var_544_8 = arg_541_1:FormatText(StoryNameCfg[381].name)

				arg_541_1.leftNameTxt_.text = var_544_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_541_1.leftNameTxt_.transform)

				arg_541_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_541_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_541_1:RecordName(arg_541_1.leftNameTxt_.text)
				SetActive(arg_541_1.iconTrs_.gameObject, false)
				arg_541_1.callingController_:SetSelectedState("normal")

				local var_544_9 = arg_541_1:GetWordFromCfg(1107505136)
				local var_544_10 = arg_541_1:FormatText(var_544_9.content)

				arg_541_1.text_.text = var_544_10

				LuaForUtil.ClearLinePrefixSymbol(arg_541_1.text_)

				local var_544_11 = 26
				local var_544_12 = utf8.len(var_544_10)
				local var_544_13 = var_544_11 <= 0 and var_544_7 or var_544_7 * (var_544_12 / var_544_11)

				if var_544_13 > 0 and var_544_7 < var_544_13 then
					arg_541_1.talkMaxDuration = var_544_13

					if var_544_13 + var_544_6 > arg_541_1.duration_ then
						arg_541_1.duration_ = var_544_13 + var_544_6
					end
				end

				arg_541_1.text_.text = var_544_10
				arg_541_1.typewritter.percent = 0

				arg_541_1.typewritter:SetDirty()
				arg_541_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107505", "1107505136", "story_v_side_new_1107505.awb") ~= 0 then
					local var_544_14 = manager.audio:GetVoiceLength("story_v_side_new_1107505", "1107505136", "story_v_side_new_1107505.awb") / 1000

					if var_544_14 + var_544_6 > arg_541_1.duration_ then
						arg_541_1.duration_ = var_544_14 + var_544_6
					end

					if var_544_9.prefab_name ~= "" and arg_541_1.actors_[var_544_9.prefab_name] ~= nil then
						local var_544_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_541_1.actors_[var_544_9.prefab_name].transform, "story_v_side_new_1107505", "1107505136", "story_v_side_new_1107505.awb")

						arg_541_1:RecordAudio("1107505136", var_544_15)
						arg_541_1:RecordAudio("1107505136", var_544_15)
					else
						arg_541_1:AudioAction("play", "voice", "story_v_side_new_1107505", "1107505136", "story_v_side_new_1107505.awb")
					end

					arg_541_1:RecordHistoryTalkVoice("story_v_side_new_1107505", "1107505136", "story_v_side_new_1107505.awb")
				end

				arg_541_1:RecordContent(arg_541_1.text_.text)
			end

			local var_544_16 = math.max(var_544_7, arg_541_1.talkMaxDuration)

			if var_544_6 <= arg_541_1.time_ and arg_541_1.time_ < var_544_6 + var_544_16 then
				arg_541_1.typewritter.percent = (arg_541_1.time_ - var_544_6) / var_544_16

				arg_541_1.typewritter:SetDirty()
			end

			if arg_541_1.time_ >= var_544_6 + var_544_16 and arg_541_1.time_ < var_544_6 + var_544_16 + arg_544_0 then
				arg_541_1.typewritter.percent = 1

				arg_541_1.typewritter:SetDirty()
				arg_541_1:ShowNextGo(true)
			end
		end

		arg_541_1.nodeConfigList_ = {}

		arg_541_1:InitPlayNodeList()
	end,
	Play1107505137 = function(arg_545_0, arg_545_1)
		arg_545_1.time_ = 0
		arg_545_1.frameCnt_ = 0
		arg_545_1.state_ = "playing"
		arg_545_1.curTalkId_ = 1107505137
		arg_545_1.duration_ = 5

		SetActive(arg_545_1.tipsGo_, false)

		function arg_545_1.onSingleLineFinish_()
			arg_545_1.onSingleLineUpdate_ = nil
			arg_545_1.onSingleLineFinish_ = nil
			arg_545_1.state_ = "waiting"
		end

		function arg_545_1.playNext_(arg_547_0)
			if arg_547_0 == 1 then
				arg_545_0:Play1107505138(arg_545_1)
			end
		end

		function arg_545_1.onSingleLineUpdate_(arg_548_0)
			local var_548_0 = arg_545_1.actors_["1075ui_actor"]
			local var_548_1 = 0

			if var_548_1 < arg_545_1.time_ and arg_545_1.time_ <= var_548_1 + arg_548_0 and not isNil(var_548_0) and arg_545_1.var_.characterEffect1075ui_actor == nil then
				arg_545_1.var_.characterEffect1075ui_actor = var_548_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_548_2 = 0.200000002980232

			if var_548_1 <= arg_545_1.time_ and arg_545_1.time_ < var_548_1 + var_548_2 and not isNil(var_548_0) then
				local var_548_3 = (arg_545_1.time_ - var_548_1) / var_548_2

				if arg_545_1.var_.characterEffect1075ui_actor and not isNil(var_548_0) then
					local var_548_4 = Mathf.Lerp(0, 0.5, var_548_3)

					arg_545_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_545_1.var_.characterEffect1075ui_actor.fillRatio = var_548_4
				end
			end

			if arg_545_1.time_ >= var_548_1 + var_548_2 and arg_545_1.time_ < var_548_1 + var_548_2 + arg_548_0 and not isNil(var_548_0) and arg_545_1.var_.characterEffect1075ui_actor then
				local var_548_5 = 0.5

				arg_545_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_545_1.var_.characterEffect1075ui_actor.fillRatio = var_548_5
			end

			local var_548_6 = 0
			local var_548_7 = 0.275

			if var_548_6 < arg_545_1.time_ and arg_545_1.time_ <= var_548_6 + arg_548_0 then
				arg_545_1.talkMaxDuration = 0
				arg_545_1.dialogCg_.alpha = 1

				arg_545_1.dialog_:SetActive(true)
				SetActive(arg_545_1.leftNameGo_, true)

				local var_548_8 = arg_545_1:FormatText(StoryNameCfg[7].name)

				arg_545_1.leftNameTxt_.text = var_548_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_545_1.leftNameTxt_.transform)

				arg_545_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_545_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_545_1:RecordName(arg_545_1.leftNameTxt_.text)
				SetActive(arg_545_1.iconTrs_.gameObject, true)
				arg_545_1.iconController_:SetSelectedState("hero")

				arg_545_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_545_1.callingController_:SetSelectedState("normal")

				arg_545_1.keyicon_.color = Color.New(1, 1, 1)
				arg_545_1.icon_.color = Color.New(1, 1, 1)

				local var_548_9 = arg_545_1:GetWordFromCfg(1107505137)
				local var_548_10 = arg_545_1:FormatText(var_548_9.content)

				arg_545_1.text_.text = var_548_10

				LuaForUtil.ClearLinePrefixSymbol(arg_545_1.text_)

				local var_548_11 = 11
				local var_548_12 = utf8.len(var_548_10)
				local var_548_13 = var_548_11 <= 0 and var_548_7 or var_548_7 * (var_548_12 / var_548_11)

				if var_548_13 > 0 and var_548_7 < var_548_13 then
					arg_545_1.talkMaxDuration = var_548_13

					if var_548_13 + var_548_6 > arg_545_1.duration_ then
						arg_545_1.duration_ = var_548_13 + var_548_6
					end
				end

				arg_545_1.text_.text = var_548_10
				arg_545_1.typewritter.percent = 0

				arg_545_1.typewritter:SetDirty()
				arg_545_1:ShowNextGo(false)
				arg_545_1:RecordContent(arg_545_1.text_.text)
			end

			local var_548_14 = math.max(var_548_7, arg_545_1.talkMaxDuration)

			if var_548_6 <= arg_545_1.time_ and arg_545_1.time_ < var_548_6 + var_548_14 then
				arg_545_1.typewritter.percent = (arg_545_1.time_ - var_548_6) / var_548_14

				arg_545_1.typewritter:SetDirty()
			end

			if arg_545_1.time_ >= var_548_6 + var_548_14 and arg_545_1.time_ < var_548_6 + var_548_14 + arg_548_0 then
				arg_545_1.typewritter.percent = 1

				arg_545_1.typewritter:SetDirty()
				arg_545_1:ShowNextGo(true)
			end
		end

		arg_545_1.nodeConfigList_ = {}

		arg_545_1:InitPlayNodeList()
	end,
	Play1107505138 = function(arg_549_0, arg_549_1)
		arg_549_1.time_ = 0
		arg_549_1.frameCnt_ = 0
		arg_549_1.state_ = "playing"
		arg_549_1.curTalkId_ = 1107505138
		arg_549_1.duration_ = 5

		SetActive(arg_549_1.tipsGo_, false)

		function arg_549_1.onSingleLineFinish_()
			arg_549_1.onSingleLineUpdate_ = nil
			arg_549_1.onSingleLineFinish_ = nil
			arg_549_1.state_ = "waiting"
		end

		function arg_549_1.playNext_(arg_551_0)
			if arg_551_0 == 1 then
				arg_549_0:Play1107505139(arg_549_1)
			end
		end

		function arg_549_1.onSingleLineUpdate_(arg_552_0)
			local var_552_0 = 0
			local var_552_1 = 0.975

			if var_552_0 < arg_549_1.time_ and arg_549_1.time_ <= var_552_0 + arg_552_0 then
				arg_549_1.talkMaxDuration = 0
				arg_549_1.dialogCg_.alpha = 1

				arg_549_1.dialog_:SetActive(true)
				SetActive(arg_549_1.leftNameGo_, false)

				arg_549_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_549_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_549_1:RecordName(arg_549_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_549_1.iconTrs_.gameObject, false)
				arg_549_1.callingController_:SetSelectedState("normal")

				local var_552_2 = arg_549_1:GetWordFromCfg(1107505138)
				local var_552_3 = arg_549_1:FormatText(var_552_2.content)

				arg_549_1.text_.text = var_552_3

				LuaForUtil.ClearLinePrefixSymbol(arg_549_1.text_)

				local var_552_4 = 39
				local var_552_5 = utf8.len(var_552_3)
				local var_552_6 = var_552_4 <= 0 and var_552_1 or var_552_1 * (var_552_5 / var_552_4)

				if var_552_6 > 0 and var_552_1 < var_552_6 then
					arg_549_1.talkMaxDuration = var_552_6

					if var_552_6 + var_552_0 > arg_549_1.duration_ then
						arg_549_1.duration_ = var_552_6 + var_552_0
					end
				end

				arg_549_1.text_.text = var_552_3
				arg_549_1.typewritter.percent = 0

				arg_549_1.typewritter:SetDirty()
				arg_549_1:ShowNextGo(false)
				arg_549_1:RecordContent(arg_549_1.text_.text)
			end

			local var_552_7 = math.max(var_552_1, arg_549_1.talkMaxDuration)

			if var_552_0 <= arg_549_1.time_ and arg_549_1.time_ < var_552_0 + var_552_7 then
				arg_549_1.typewritter.percent = (arg_549_1.time_ - var_552_0) / var_552_7

				arg_549_1.typewritter:SetDirty()
			end

			if arg_549_1.time_ >= var_552_0 + var_552_7 and arg_549_1.time_ < var_552_0 + var_552_7 + arg_552_0 then
				arg_549_1.typewritter.percent = 1

				arg_549_1.typewritter:SetDirty()
				arg_549_1:ShowNextGo(true)
			end
		end

		arg_549_1.nodeConfigList_ = {}

		arg_549_1:InitPlayNodeList()
	end,
	Play1107505139 = function(arg_553_0, arg_553_1)
		arg_553_1.time_ = 0
		arg_553_1.frameCnt_ = 0
		arg_553_1.state_ = "playing"
		arg_553_1.curTalkId_ = 1107505139
		arg_553_1.duration_ = 5

		SetActive(arg_553_1.tipsGo_, false)

		function arg_553_1.onSingleLineFinish_()
			arg_553_1.onSingleLineUpdate_ = nil
			arg_553_1.onSingleLineFinish_ = nil
			arg_553_1.state_ = "waiting"
		end

		function arg_553_1.playNext_(arg_555_0)
			if arg_555_0 == 1 then
				arg_553_0:Play1107505140(arg_553_1)
			end
		end

		function arg_553_1.onSingleLineUpdate_(arg_556_0)
			local var_556_0 = 0
			local var_556_1 = 0.35

			if var_556_0 < arg_553_1.time_ and arg_553_1.time_ <= var_556_0 + arg_556_0 then
				arg_553_1.talkMaxDuration = 0
				arg_553_1.dialogCg_.alpha = 1

				arg_553_1.dialog_:SetActive(true)
				SetActive(arg_553_1.leftNameGo_, true)

				local var_556_2 = arg_553_1:FormatText(StoryNameCfg[7].name)

				arg_553_1.leftNameTxt_.text = var_556_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_553_1.leftNameTxt_.transform)

				arg_553_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_553_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_553_1:RecordName(arg_553_1.leftNameTxt_.text)
				SetActive(arg_553_1.iconTrs_.gameObject, true)
				arg_553_1.iconController_:SetSelectedState("hero")

				arg_553_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_553_1.callingController_:SetSelectedState("normal")

				arg_553_1.keyicon_.color = Color.New(1, 1, 1)
				arg_553_1.icon_.color = Color.New(1, 1, 1)

				local var_556_3 = arg_553_1:GetWordFromCfg(1107505139)
				local var_556_4 = arg_553_1:FormatText(var_556_3.content)

				arg_553_1.text_.text = var_556_4

				LuaForUtil.ClearLinePrefixSymbol(arg_553_1.text_)

				local var_556_5 = 14
				local var_556_6 = utf8.len(var_556_4)
				local var_556_7 = var_556_5 <= 0 and var_556_1 or var_556_1 * (var_556_6 / var_556_5)

				if var_556_7 > 0 and var_556_1 < var_556_7 then
					arg_553_1.talkMaxDuration = var_556_7

					if var_556_7 + var_556_0 > arg_553_1.duration_ then
						arg_553_1.duration_ = var_556_7 + var_556_0
					end
				end

				arg_553_1.text_.text = var_556_4
				arg_553_1.typewritter.percent = 0

				arg_553_1.typewritter:SetDirty()
				arg_553_1:ShowNextGo(false)
				arg_553_1:RecordContent(arg_553_1.text_.text)
			end

			local var_556_8 = math.max(var_556_1, arg_553_1.talkMaxDuration)

			if var_556_0 <= arg_553_1.time_ and arg_553_1.time_ < var_556_0 + var_556_8 then
				arg_553_1.typewritter.percent = (arg_553_1.time_ - var_556_0) / var_556_8

				arg_553_1.typewritter:SetDirty()
			end

			if arg_553_1.time_ >= var_556_0 + var_556_8 and arg_553_1.time_ < var_556_0 + var_556_8 + arg_556_0 then
				arg_553_1.typewritter.percent = 1

				arg_553_1.typewritter:SetDirty()
				arg_553_1:ShowNextGo(true)
			end
		end

		arg_553_1.nodeConfigList_ = {}

		arg_553_1:InitPlayNodeList()
	end,
	Play1107505140 = function(arg_557_0, arg_557_1)
		arg_557_1.time_ = 0
		arg_557_1.frameCnt_ = 0
		arg_557_1.state_ = "playing"
		arg_557_1.curTalkId_ = 1107505140
		arg_557_1.duration_ = 6.27

		SetActive(arg_557_1.tipsGo_, false)

		function arg_557_1.onSingleLineFinish_()
			arg_557_1.onSingleLineUpdate_ = nil
			arg_557_1.onSingleLineFinish_ = nil
			arg_557_1.state_ = "waiting"
		end

		function arg_557_1.playNext_(arg_559_0)
			if arg_559_0 == 1 then
				arg_557_0:Play1107505141(arg_557_1)
			end
		end

		function arg_557_1.onSingleLineUpdate_(arg_560_0)
			local var_560_0 = arg_557_1.actors_["1075ui_actor"]
			local var_560_1 = 0

			if var_560_1 < arg_557_1.time_ and arg_557_1.time_ <= var_560_1 + arg_560_0 and not isNil(var_560_0) and arg_557_1.var_.characterEffect1075ui_actor == nil then
				arg_557_1.var_.characterEffect1075ui_actor = var_560_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_560_2 = 0.200000002980232

			if var_560_1 <= arg_557_1.time_ and arg_557_1.time_ < var_560_1 + var_560_2 and not isNil(var_560_0) then
				local var_560_3 = (arg_557_1.time_ - var_560_1) / var_560_2

				if arg_557_1.var_.characterEffect1075ui_actor and not isNil(var_560_0) then
					arg_557_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_557_1.time_ >= var_560_1 + var_560_2 and arg_557_1.time_ < var_560_1 + var_560_2 + arg_560_0 and not isNil(var_560_0) and arg_557_1.var_.characterEffect1075ui_actor then
				arg_557_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			local var_560_4 = 0

			if var_560_4 < arg_557_1.time_ and arg_557_1.time_ <= var_560_4 + arg_560_0 then
				arg_557_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075action/1075action4_1")
			end

			local var_560_5 = 0

			if var_560_5 < arg_557_1.time_ and arg_557_1.time_ <= var_560_5 + arg_560_0 then
				arg_557_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_560_6 = 0
			local var_560_7 = 0.575

			if var_560_6 < arg_557_1.time_ and arg_557_1.time_ <= var_560_6 + arg_560_0 then
				arg_557_1.talkMaxDuration = 0
				arg_557_1.dialogCg_.alpha = 1

				arg_557_1.dialog_:SetActive(true)
				SetActive(arg_557_1.leftNameGo_, true)

				local var_560_8 = arg_557_1:FormatText(StoryNameCfg[381].name)

				arg_557_1.leftNameTxt_.text = var_560_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_557_1.leftNameTxt_.transform)

				arg_557_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_557_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_557_1:RecordName(arg_557_1.leftNameTxt_.text)
				SetActive(arg_557_1.iconTrs_.gameObject, false)
				arg_557_1.callingController_:SetSelectedState("normal")

				local var_560_9 = arg_557_1:GetWordFromCfg(1107505140)
				local var_560_10 = arg_557_1:FormatText(var_560_9.content)

				arg_557_1.text_.text = var_560_10

				LuaForUtil.ClearLinePrefixSymbol(arg_557_1.text_)

				local var_560_11 = 23
				local var_560_12 = utf8.len(var_560_10)
				local var_560_13 = var_560_11 <= 0 and var_560_7 or var_560_7 * (var_560_12 / var_560_11)

				if var_560_13 > 0 and var_560_7 < var_560_13 then
					arg_557_1.talkMaxDuration = var_560_13

					if var_560_13 + var_560_6 > arg_557_1.duration_ then
						arg_557_1.duration_ = var_560_13 + var_560_6
					end
				end

				arg_557_1.text_.text = var_560_10
				arg_557_1.typewritter.percent = 0

				arg_557_1.typewritter:SetDirty()
				arg_557_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107505", "1107505140", "story_v_side_new_1107505.awb") ~= 0 then
					local var_560_14 = manager.audio:GetVoiceLength("story_v_side_new_1107505", "1107505140", "story_v_side_new_1107505.awb") / 1000

					if var_560_14 + var_560_6 > arg_557_1.duration_ then
						arg_557_1.duration_ = var_560_14 + var_560_6
					end

					if var_560_9.prefab_name ~= "" and arg_557_1.actors_[var_560_9.prefab_name] ~= nil then
						local var_560_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_557_1.actors_[var_560_9.prefab_name].transform, "story_v_side_new_1107505", "1107505140", "story_v_side_new_1107505.awb")

						arg_557_1:RecordAudio("1107505140", var_560_15)
						arg_557_1:RecordAudio("1107505140", var_560_15)
					else
						arg_557_1:AudioAction("play", "voice", "story_v_side_new_1107505", "1107505140", "story_v_side_new_1107505.awb")
					end

					arg_557_1:RecordHistoryTalkVoice("story_v_side_new_1107505", "1107505140", "story_v_side_new_1107505.awb")
				end

				arg_557_1:RecordContent(arg_557_1.text_.text)
			end

			local var_560_16 = math.max(var_560_7, arg_557_1.talkMaxDuration)

			if var_560_6 <= arg_557_1.time_ and arg_557_1.time_ < var_560_6 + var_560_16 then
				arg_557_1.typewritter.percent = (arg_557_1.time_ - var_560_6) / var_560_16

				arg_557_1.typewritter:SetDirty()
			end

			if arg_557_1.time_ >= var_560_6 + var_560_16 and arg_557_1.time_ < var_560_6 + var_560_16 + arg_560_0 then
				arg_557_1.typewritter.percent = 1

				arg_557_1.typewritter:SetDirty()
				arg_557_1:ShowNextGo(true)
			end
		end

		arg_557_1.nodeConfigList_ = {}

		arg_557_1:InitPlayNodeList()
	end,
	Play1107505141 = function(arg_561_0, arg_561_1)
		arg_561_1.time_ = 0
		arg_561_1.frameCnt_ = 0
		arg_561_1.state_ = "playing"
		arg_561_1.curTalkId_ = 1107505141
		arg_561_1.duration_ = 5

		SetActive(arg_561_1.tipsGo_, false)

		function arg_561_1.onSingleLineFinish_()
			arg_561_1.onSingleLineUpdate_ = nil
			arg_561_1.onSingleLineFinish_ = nil
			arg_561_1.state_ = "waiting"
		end

		function arg_561_1.playNext_(arg_563_0)
			if arg_563_0 == 1 then
				arg_561_0:Play1107505142(arg_561_1)
			end
		end

		function arg_561_1.onSingleLineUpdate_(arg_564_0)
			local var_564_0 = arg_561_1.actors_["1075ui_actor"]
			local var_564_1 = 0

			if var_564_1 < arg_561_1.time_ and arg_561_1.time_ <= var_564_1 + arg_564_0 and not isNil(var_564_0) and arg_561_1.var_.characterEffect1075ui_actor == nil then
				arg_561_1.var_.characterEffect1075ui_actor = var_564_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_564_2 = 0.200000002980232

			if var_564_1 <= arg_561_1.time_ and arg_561_1.time_ < var_564_1 + var_564_2 and not isNil(var_564_0) then
				local var_564_3 = (arg_561_1.time_ - var_564_1) / var_564_2

				if arg_561_1.var_.characterEffect1075ui_actor and not isNil(var_564_0) then
					local var_564_4 = Mathf.Lerp(0, 0.5, var_564_3)

					arg_561_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_561_1.var_.characterEffect1075ui_actor.fillRatio = var_564_4
				end
			end

			if arg_561_1.time_ >= var_564_1 + var_564_2 and arg_561_1.time_ < var_564_1 + var_564_2 + arg_564_0 and not isNil(var_564_0) and arg_561_1.var_.characterEffect1075ui_actor then
				local var_564_5 = 0.5

				arg_561_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_561_1.var_.characterEffect1075ui_actor.fillRatio = var_564_5
			end

			local var_564_6 = 0

			if var_564_6 < arg_561_1.time_ and arg_561_1.time_ <= var_564_6 + arg_564_0 then
				arg_561_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075action/1075action4_2")
			end

			local var_564_7 = 0

			if var_564_7 < arg_561_1.time_ and arg_561_1.time_ <= var_564_7 + arg_564_0 then
				arg_561_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_564_8 = 0
			local var_564_9 = 0.9

			if var_564_8 < arg_561_1.time_ and arg_561_1.time_ <= var_564_8 + arg_564_0 then
				arg_561_1.talkMaxDuration = 0
				arg_561_1.dialogCg_.alpha = 1

				arg_561_1.dialog_:SetActive(true)
				SetActive(arg_561_1.leftNameGo_, false)

				arg_561_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_561_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_561_1:RecordName(arg_561_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_561_1.iconTrs_.gameObject, false)
				arg_561_1.callingController_:SetSelectedState("normal")

				local var_564_10 = arg_561_1:GetWordFromCfg(1107505141)
				local var_564_11 = arg_561_1:FormatText(var_564_10.content)

				arg_561_1.text_.text = var_564_11

				LuaForUtil.ClearLinePrefixSymbol(arg_561_1.text_)

				local var_564_12 = 36
				local var_564_13 = utf8.len(var_564_11)
				local var_564_14 = var_564_12 <= 0 and var_564_9 or var_564_9 * (var_564_13 / var_564_12)

				if var_564_14 > 0 and var_564_9 < var_564_14 then
					arg_561_1.talkMaxDuration = var_564_14

					if var_564_14 + var_564_8 > arg_561_1.duration_ then
						arg_561_1.duration_ = var_564_14 + var_564_8
					end
				end

				arg_561_1.text_.text = var_564_11
				arg_561_1.typewritter.percent = 0

				arg_561_1.typewritter:SetDirty()
				arg_561_1:ShowNextGo(false)
				arg_561_1:RecordContent(arg_561_1.text_.text)
			end

			local var_564_15 = math.max(var_564_9, arg_561_1.talkMaxDuration)

			if var_564_8 <= arg_561_1.time_ and arg_561_1.time_ < var_564_8 + var_564_15 then
				arg_561_1.typewritter.percent = (arg_561_1.time_ - var_564_8) / var_564_15

				arg_561_1.typewritter:SetDirty()
			end

			if arg_561_1.time_ >= var_564_8 + var_564_15 and arg_561_1.time_ < var_564_8 + var_564_15 + arg_564_0 then
				arg_561_1.typewritter.percent = 1

				arg_561_1.typewritter:SetDirty()
				arg_561_1:ShowNextGo(true)
			end
		end

		arg_561_1.nodeConfigList_ = {}

		arg_561_1:InitPlayNodeList()
	end,
	Play1107505142 = function(arg_565_0, arg_565_1)
		arg_565_1.time_ = 0
		arg_565_1.frameCnt_ = 0
		arg_565_1.state_ = "playing"
		arg_565_1.curTalkId_ = 1107505142
		arg_565_1.duration_ = 5

		SetActive(arg_565_1.tipsGo_, false)

		function arg_565_1.onSingleLineFinish_()
			arg_565_1.onSingleLineUpdate_ = nil
			arg_565_1.onSingleLineFinish_ = nil
			arg_565_1.state_ = "waiting"
		end

		function arg_565_1.playNext_(arg_567_0)
			if arg_567_0 == 1 then
				arg_565_0:Play1107505143(arg_565_1)
			end
		end

		function arg_565_1.onSingleLineUpdate_(arg_568_0)
			local var_568_0 = 0
			local var_568_1 = 0.4

			if var_568_0 < arg_565_1.time_ and arg_565_1.time_ <= var_568_0 + arg_568_0 then
				arg_565_1.talkMaxDuration = 0
				arg_565_1.dialogCg_.alpha = 1

				arg_565_1.dialog_:SetActive(true)
				SetActive(arg_565_1.leftNameGo_, true)

				local var_568_2 = arg_565_1:FormatText(StoryNameCfg[7].name)

				arg_565_1.leftNameTxt_.text = var_568_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_565_1.leftNameTxt_.transform)

				arg_565_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_565_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_565_1:RecordName(arg_565_1.leftNameTxt_.text)
				SetActive(arg_565_1.iconTrs_.gameObject, true)
				arg_565_1.iconController_:SetSelectedState("hero")

				arg_565_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_565_1.callingController_:SetSelectedState("normal")

				arg_565_1.keyicon_.color = Color.New(1, 1, 1)
				arg_565_1.icon_.color = Color.New(1, 1, 1)

				local var_568_3 = arg_565_1:GetWordFromCfg(1107505142)
				local var_568_4 = arg_565_1:FormatText(var_568_3.content)

				arg_565_1.text_.text = var_568_4

				LuaForUtil.ClearLinePrefixSymbol(arg_565_1.text_)

				local var_568_5 = 16
				local var_568_6 = utf8.len(var_568_4)
				local var_568_7 = var_568_5 <= 0 and var_568_1 or var_568_1 * (var_568_6 / var_568_5)

				if var_568_7 > 0 and var_568_1 < var_568_7 then
					arg_565_1.talkMaxDuration = var_568_7

					if var_568_7 + var_568_0 > arg_565_1.duration_ then
						arg_565_1.duration_ = var_568_7 + var_568_0
					end
				end

				arg_565_1.text_.text = var_568_4
				arg_565_1.typewritter.percent = 0

				arg_565_1.typewritter:SetDirty()
				arg_565_1:ShowNextGo(false)
				arg_565_1:RecordContent(arg_565_1.text_.text)
			end

			local var_568_8 = math.max(var_568_1, arg_565_1.talkMaxDuration)

			if var_568_0 <= arg_565_1.time_ and arg_565_1.time_ < var_568_0 + var_568_8 then
				arg_565_1.typewritter.percent = (arg_565_1.time_ - var_568_0) / var_568_8

				arg_565_1.typewritter:SetDirty()
			end

			if arg_565_1.time_ >= var_568_0 + var_568_8 and arg_565_1.time_ < var_568_0 + var_568_8 + arg_568_0 then
				arg_565_1.typewritter.percent = 1

				arg_565_1.typewritter:SetDirty()
				arg_565_1:ShowNextGo(true)
			end
		end

		arg_565_1.nodeConfigList_ = {}

		arg_565_1:InitPlayNodeList()
	end,
	Play1107505143 = function(arg_569_0, arg_569_1)
		arg_569_1.time_ = 0
		arg_569_1.frameCnt_ = 0
		arg_569_1.state_ = "playing"
		arg_569_1.curTalkId_ = 1107505143
		arg_569_1.duration_ = 5

		SetActive(arg_569_1.tipsGo_, false)

		function arg_569_1.onSingleLineFinish_()
			arg_569_1.onSingleLineUpdate_ = nil
			arg_569_1.onSingleLineFinish_ = nil
			arg_569_1.state_ = "waiting"
		end

		function arg_569_1.playNext_(arg_571_0)
			if arg_571_0 == 1 then
				arg_569_0:Play1107505144(arg_569_1)
			end
		end

		function arg_569_1.onSingleLineUpdate_(arg_572_0)
			local var_572_0 = arg_569_1.actors_["1075ui_actor"].transform
			local var_572_1 = 0

			if var_572_1 < arg_569_1.time_ and arg_569_1.time_ <= var_572_1 + arg_572_0 then
				arg_569_1.var_.moveOldPos1075ui_actor = var_572_0.localPosition

				local var_572_2 = GameObjectTools.GetOrAddComponent(var_572_0.gameObject, typeof(DynamicBoneHelper))

				if var_572_2 then
					var_572_2:EnableDynamicBone(false)
				end
			end

			local var_572_3 = 0.001

			if var_572_1 <= arg_569_1.time_ and arg_569_1.time_ < var_572_1 + var_572_3 then
				local var_572_4 = (arg_569_1.time_ - var_572_1) / var_572_3
				local var_572_5 = Vector3.New(0, 100, 0)

				var_572_0.localPosition = Vector3.Lerp(arg_569_1.var_.moveOldPos1075ui_actor, var_572_5, var_572_4)

				local var_572_6 = manager.ui.mainCamera.transform.position - var_572_0.position

				var_572_0.forward = Vector3.New(var_572_6.x, var_572_6.y, var_572_6.z)

				local var_572_7 = var_572_0.localEulerAngles

				var_572_7.z = 0
				var_572_7.x = 0
				var_572_0.localEulerAngles = var_572_7
			end

			if arg_569_1.time_ >= var_572_1 + var_572_3 and arg_569_1.time_ < var_572_1 + var_572_3 + arg_572_0 then
				var_572_0.localPosition = Vector3.New(0, 100, 0)

				local var_572_8 = manager.ui.mainCamera.transform.position - var_572_0.position

				var_572_0.forward = Vector3.New(var_572_8.x, var_572_8.y, var_572_8.z)

				local var_572_9 = var_572_0.localEulerAngles

				var_572_9.z = 0
				var_572_9.x = 0
				var_572_0.localEulerAngles = var_572_9

				local var_572_10 = GameObjectTools.GetOrAddComponent(var_572_0.gameObject, typeof(DynamicBoneHelper))

				if var_572_10 then
					var_572_10:EnableDynamicBone(true)
				end
			end

			local var_572_11 = 0
			local var_572_12 = 0.85

			if var_572_11 < arg_569_1.time_ and arg_569_1.time_ <= var_572_11 + arg_572_0 then
				arg_569_1.talkMaxDuration = 0
				arg_569_1.dialogCg_.alpha = 1

				arg_569_1.dialog_:SetActive(true)
				SetActive(arg_569_1.leftNameGo_, false)

				arg_569_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_569_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_569_1:RecordName(arg_569_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_569_1.iconTrs_.gameObject, false)
				arg_569_1.callingController_:SetSelectedState("normal")

				local var_572_13 = arg_569_1:GetWordFromCfg(1107505143)
				local var_572_14 = arg_569_1:FormatText(var_572_13.content)

				arg_569_1.text_.text = var_572_14

				LuaForUtil.ClearLinePrefixSymbol(arg_569_1.text_)

				local var_572_15 = 34
				local var_572_16 = utf8.len(var_572_14)
				local var_572_17 = var_572_15 <= 0 and var_572_12 or var_572_12 * (var_572_16 / var_572_15)

				if var_572_17 > 0 and var_572_12 < var_572_17 then
					arg_569_1.talkMaxDuration = var_572_17

					if var_572_17 + var_572_11 > arg_569_1.duration_ then
						arg_569_1.duration_ = var_572_17 + var_572_11
					end
				end

				arg_569_1.text_.text = var_572_14
				arg_569_1.typewritter.percent = 0

				arg_569_1.typewritter:SetDirty()
				arg_569_1:ShowNextGo(false)
				arg_569_1:RecordContent(arg_569_1.text_.text)
			end

			local var_572_18 = math.max(var_572_12, arg_569_1.talkMaxDuration)

			if var_572_11 <= arg_569_1.time_ and arg_569_1.time_ < var_572_11 + var_572_18 then
				arg_569_1.typewritter.percent = (arg_569_1.time_ - var_572_11) / var_572_18

				arg_569_1.typewritter:SetDirty()
			end

			if arg_569_1.time_ >= var_572_11 + var_572_18 and arg_569_1.time_ < var_572_11 + var_572_18 + arg_572_0 then
				arg_569_1.typewritter.percent = 1

				arg_569_1.typewritter:SetDirty()
				arg_569_1:ShowNextGo(true)
			end
		end

		arg_569_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_actor",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_569_1:InitPlayNodeList()
	end,
	Play1107505144 = function(arg_573_0, arg_573_1)
		arg_573_1.time_ = 0
		arg_573_1.frameCnt_ = 0
		arg_573_1.state_ = "playing"
		arg_573_1.curTalkId_ = 1107505144
		arg_573_1.duration_ = 5

		SetActive(arg_573_1.tipsGo_, false)

		function arg_573_1.onSingleLineFinish_()
			arg_573_1.onSingleLineUpdate_ = nil
			arg_573_1.onSingleLineFinish_ = nil
			arg_573_1.state_ = "waiting"
		end

		function arg_573_1.playNext_(arg_575_0)
			if arg_575_0 == 1 then
				arg_573_0:Play1107505145(arg_573_1)
			end
		end

		function arg_573_1.onSingleLineUpdate_(arg_576_0)
			local var_576_0 = 0
			local var_576_1 = 0.275

			if var_576_0 < arg_573_1.time_ and arg_573_1.time_ <= var_576_0 + arg_576_0 then
				arg_573_1.talkMaxDuration = 0
				arg_573_1.dialogCg_.alpha = 1

				arg_573_1.dialog_:SetActive(true)
				SetActive(arg_573_1.leftNameGo_, true)

				local var_576_2 = arg_573_1:FormatText(StoryNameCfg[7].name)

				arg_573_1.leftNameTxt_.text = var_576_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_573_1.leftNameTxt_.transform)

				arg_573_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_573_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_573_1:RecordName(arg_573_1.leftNameTxt_.text)
				SetActive(arg_573_1.iconTrs_.gameObject, true)
				arg_573_1.iconController_:SetSelectedState("hero")

				arg_573_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_573_1.callingController_:SetSelectedState("normal")

				arg_573_1.keyicon_.color = Color.New(1, 1, 1)
				arg_573_1.icon_.color = Color.New(1, 1, 1)

				local var_576_3 = arg_573_1:GetWordFromCfg(1107505144)
				local var_576_4 = arg_573_1:FormatText(var_576_3.content)

				arg_573_1.text_.text = var_576_4

				LuaForUtil.ClearLinePrefixSymbol(arg_573_1.text_)

				local var_576_5 = 11
				local var_576_6 = utf8.len(var_576_4)
				local var_576_7 = var_576_5 <= 0 and var_576_1 or var_576_1 * (var_576_6 / var_576_5)

				if var_576_7 > 0 and var_576_1 < var_576_7 then
					arg_573_1.talkMaxDuration = var_576_7

					if var_576_7 + var_576_0 > arg_573_1.duration_ then
						arg_573_1.duration_ = var_576_7 + var_576_0
					end
				end

				arg_573_1.text_.text = var_576_4
				arg_573_1.typewritter.percent = 0

				arg_573_1.typewritter:SetDirty()
				arg_573_1:ShowNextGo(false)
				arg_573_1:RecordContent(arg_573_1.text_.text)
			end

			local var_576_8 = math.max(var_576_1, arg_573_1.talkMaxDuration)

			if var_576_0 <= arg_573_1.time_ and arg_573_1.time_ < var_576_0 + var_576_8 then
				arg_573_1.typewritter.percent = (arg_573_1.time_ - var_576_0) / var_576_8

				arg_573_1.typewritter:SetDirty()
			end

			if arg_573_1.time_ >= var_576_0 + var_576_8 and arg_573_1.time_ < var_576_0 + var_576_8 + arg_576_0 then
				arg_573_1.typewritter.percent = 1

				arg_573_1.typewritter:SetDirty()
				arg_573_1:ShowNextGo(true)
			end
		end

		arg_573_1.nodeConfigList_ = {}

		arg_573_1:InitPlayNodeList()
	end,
	Play1107505145 = function(arg_577_0, arg_577_1)
		arg_577_1.time_ = 0
		arg_577_1.frameCnt_ = 0
		arg_577_1.state_ = "playing"
		arg_577_1.curTalkId_ = 1107505145
		arg_577_1.duration_ = 5.17

		SetActive(arg_577_1.tipsGo_, false)

		function arg_577_1.onSingleLineFinish_()
			arg_577_1.onSingleLineUpdate_ = nil
			arg_577_1.onSingleLineFinish_ = nil
			arg_577_1.state_ = "waiting"
		end

		function arg_577_1.playNext_(arg_579_0)
			if arg_579_0 == 1 then
				arg_577_0:Play1107505146(arg_577_1)
			end
		end

		function arg_577_1.onSingleLineUpdate_(arg_580_0)
			local var_580_0 = arg_577_1.actors_["1075ui_actor"].transform
			local var_580_1 = 0

			if var_580_1 < arg_577_1.time_ and arg_577_1.time_ <= var_580_1 + arg_580_0 then
				arg_577_1.var_.moveOldPos1075ui_actor = var_580_0.localPosition

				local var_580_2 = GameObjectTools.GetOrAddComponent(var_580_0.gameObject, typeof(DynamicBoneHelper))

				if var_580_2 then
					var_580_2:EnableDynamicBone(false)
				end
			end

			local var_580_3 = 0.001

			if var_580_1 <= arg_577_1.time_ and arg_577_1.time_ < var_580_1 + var_580_3 then
				local var_580_4 = (arg_577_1.time_ - var_580_1) / var_580_3
				local var_580_5 = Vector3.New(0, -1.055, -6.16)

				var_580_0.localPosition = Vector3.Lerp(arg_577_1.var_.moveOldPos1075ui_actor, var_580_5, var_580_4)

				local var_580_6 = manager.ui.mainCamera.transform.position - var_580_0.position

				var_580_0.forward = Vector3.New(var_580_6.x, var_580_6.y, var_580_6.z)

				local var_580_7 = var_580_0.localEulerAngles

				var_580_7.z = 0
				var_580_7.x = 0
				var_580_0.localEulerAngles = var_580_7
			end

			if arg_577_1.time_ >= var_580_1 + var_580_3 and arg_577_1.time_ < var_580_1 + var_580_3 + arg_580_0 then
				var_580_0.localPosition = Vector3.New(0, -1.055, -6.16)

				local var_580_8 = manager.ui.mainCamera.transform.position - var_580_0.position

				var_580_0.forward = Vector3.New(var_580_8.x, var_580_8.y, var_580_8.z)

				local var_580_9 = var_580_0.localEulerAngles

				var_580_9.z = 0
				var_580_9.x = 0
				var_580_0.localEulerAngles = var_580_9

				local var_580_10 = GameObjectTools.GetOrAddComponent(var_580_0.gameObject, typeof(DynamicBoneHelper))

				if var_580_10 then
					var_580_10:EnableDynamicBone(true)
				end
			end

			local var_580_11 = arg_577_1.actors_["1075ui_actor"]
			local var_580_12 = 0

			if var_580_12 < arg_577_1.time_ and arg_577_1.time_ <= var_580_12 + arg_580_0 and not isNil(var_580_11) and arg_577_1.var_.characterEffect1075ui_actor == nil then
				arg_577_1.var_.characterEffect1075ui_actor = var_580_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_580_13 = 0.200000002980232

			if var_580_12 <= arg_577_1.time_ and arg_577_1.time_ < var_580_12 + var_580_13 and not isNil(var_580_11) then
				local var_580_14 = (arg_577_1.time_ - var_580_12) / var_580_13

				if arg_577_1.var_.characterEffect1075ui_actor and not isNil(var_580_11) then
					arg_577_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_577_1.time_ >= var_580_12 + var_580_13 and arg_577_1.time_ < var_580_12 + var_580_13 + arg_580_0 and not isNil(var_580_11) and arg_577_1.var_.characterEffect1075ui_actor then
				arg_577_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			local var_580_15 = 0

			if var_580_15 < arg_577_1.time_ and arg_577_1.time_ <= var_580_15 + arg_580_0 then
				arg_577_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075action/1075action5_1")
			end

			local var_580_16 = 0

			if var_580_16 < arg_577_1.time_ and arg_577_1.time_ <= var_580_16 + arg_580_0 then
				arg_577_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_580_17 = 0
			local var_580_18 = 0.575

			if var_580_17 < arg_577_1.time_ and arg_577_1.time_ <= var_580_17 + arg_580_0 then
				arg_577_1.talkMaxDuration = 0
				arg_577_1.dialogCg_.alpha = 1

				arg_577_1.dialog_:SetActive(true)
				SetActive(arg_577_1.leftNameGo_, true)

				local var_580_19 = arg_577_1:FormatText(StoryNameCfg[381].name)

				arg_577_1.leftNameTxt_.text = var_580_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_577_1.leftNameTxt_.transform)

				arg_577_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_577_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_577_1:RecordName(arg_577_1.leftNameTxt_.text)
				SetActive(arg_577_1.iconTrs_.gameObject, false)
				arg_577_1.callingController_:SetSelectedState("normal")

				local var_580_20 = arg_577_1:GetWordFromCfg(1107505145)
				local var_580_21 = arg_577_1:FormatText(var_580_20.content)

				arg_577_1.text_.text = var_580_21

				LuaForUtil.ClearLinePrefixSymbol(arg_577_1.text_)

				local var_580_22 = 23
				local var_580_23 = utf8.len(var_580_21)
				local var_580_24 = var_580_22 <= 0 and var_580_18 or var_580_18 * (var_580_23 / var_580_22)

				if var_580_24 > 0 and var_580_18 < var_580_24 then
					arg_577_1.talkMaxDuration = var_580_24

					if var_580_24 + var_580_17 > arg_577_1.duration_ then
						arg_577_1.duration_ = var_580_24 + var_580_17
					end
				end

				arg_577_1.text_.text = var_580_21
				arg_577_1.typewritter.percent = 0

				arg_577_1.typewritter:SetDirty()
				arg_577_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107505", "1107505145", "story_v_side_new_1107505.awb") ~= 0 then
					local var_580_25 = manager.audio:GetVoiceLength("story_v_side_new_1107505", "1107505145", "story_v_side_new_1107505.awb") / 1000

					if var_580_25 + var_580_17 > arg_577_1.duration_ then
						arg_577_1.duration_ = var_580_25 + var_580_17
					end

					if var_580_20.prefab_name ~= "" and arg_577_1.actors_[var_580_20.prefab_name] ~= nil then
						local var_580_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_577_1.actors_[var_580_20.prefab_name].transform, "story_v_side_new_1107505", "1107505145", "story_v_side_new_1107505.awb")

						arg_577_1:RecordAudio("1107505145", var_580_26)
						arg_577_1:RecordAudio("1107505145", var_580_26)
					else
						arg_577_1:AudioAction("play", "voice", "story_v_side_new_1107505", "1107505145", "story_v_side_new_1107505.awb")
					end

					arg_577_1:RecordHistoryTalkVoice("story_v_side_new_1107505", "1107505145", "story_v_side_new_1107505.awb")
				end

				arg_577_1:RecordContent(arg_577_1.text_.text)
			end

			local var_580_27 = math.max(var_580_18, arg_577_1.talkMaxDuration)

			if var_580_17 <= arg_577_1.time_ and arg_577_1.time_ < var_580_17 + var_580_27 then
				arg_577_1.typewritter.percent = (arg_577_1.time_ - var_580_17) / var_580_27

				arg_577_1.typewritter:SetDirty()
			end

			if arg_577_1.time_ >= var_580_17 + var_580_27 and arg_577_1.time_ < var_580_17 + var_580_27 + arg_580_0 then
				arg_577_1.typewritter.percent = 1

				arg_577_1.typewritter:SetDirty()
				arg_577_1:ShowNextGo(true)
			end
		end

		arg_577_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_actor",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_577_1:InitPlayNodeList()
	end,
	Play1107505146 = function(arg_581_0, arg_581_1)
		arg_581_1.time_ = 0
		arg_581_1.frameCnt_ = 0
		arg_581_1.state_ = "playing"
		arg_581_1.curTalkId_ = 1107505146
		arg_581_1.duration_ = 5

		SetActive(arg_581_1.tipsGo_, false)

		function arg_581_1.onSingleLineFinish_()
			arg_581_1.onSingleLineUpdate_ = nil
			arg_581_1.onSingleLineFinish_ = nil
			arg_581_1.state_ = "waiting"
		end

		function arg_581_1.playNext_(arg_583_0)
			if arg_583_0 == 1 then
				arg_581_0:Play1107505147(arg_581_1)
			end
		end

		function arg_581_1.onSingleLineUpdate_(arg_584_0)
			local var_584_0 = arg_581_1.actors_["1075ui_actor"]
			local var_584_1 = 0

			if var_584_1 < arg_581_1.time_ and arg_581_1.time_ <= var_584_1 + arg_584_0 and not isNil(var_584_0) and arg_581_1.var_.characterEffect1075ui_actor == nil then
				arg_581_1.var_.characterEffect1075ui_actor = var_584_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_584_2 = 0.200000002980232

			if var_584_1 <= arg_581_1.time_ and arg_581_1.time_ < var_584_1 + var_584_2 and not isNil(var_584_0) then
				local var_584_3 = (arg_581_1.time_ - var_584_1) / var_584_2

				if arg_581_1.var_.characterEffect1075ui_actor and not isNil(var_584_0) then
					local var_584_4 = Mathf.Lerp(0, 0.5, var_584_3)

					arg_581_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_581_1.var_.characterEffect1075ui_actor.fillRatio = var_584_4
				end
			end

			if arg_581_1.time_ >= var_584_1 + var_584_2 and arg_581_1.time_ < var_584_1 + var_584_2 + arg_584_0 and not isNil(var_584_0) and arg_581_1.var_.characterEffect1075ui_actor then
				local var_584_5 = 0.5

				arg_581_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_581_1.var_.characterEffect1075ui_actor.fillRatio = var_584_5
			end

			local var_584_6 = 0
			local var_584_7 = 0.575

			if var_584_6 < arg_581_1.time_ and arg_581_1.time_ <= var_584_6 + arg_584_0 then
				arg_581_1.talkMaxDuration = 0
				arg_581_1.dialogCg_.alpha = 1

				arg_581_1.dialog_:SetActive(true)
				SetActive(arg_581_1.leftNameGo_, true)

				local var_584_8 = arg_581_1:FormatText(StoryNameCfg[7].name)

				arg_581_1.leftNameTxt_.text = var_584_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_581_1.leftNameTxt_.transform)

				arg_581_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_581_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_581_1:RecordName(arg_581_1.leftNameTxt_.text)
				SetActive(arg_581_1.iconTrs_.gameObject, true)
				arg_581_1.iconController_:SetSelectedState("hero")

				arg_581_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_581_1.callingController_:SetSelectedState("normal")

				arg_581_1.keyicon_.color = Color.New(1, 1, 1)
				arg_581_1.icon_.color = Color.New(1, 1, 1)

				local var_584_9 = arg_581_1:GetWordFromCfg(1107505146)
				local var_584_10 = arg_581_1:FormatText(var_584_9.content)

				arg_581_1.text_.text = var_584_10

				LuaForUtil.ClearLinePrefixSymbol(arg_581_1.text_)

				local var_584_11 = 23
				local var_584_12 = utf8.len(var_584_10)
				local var_584_13 = var_584_11 <= 0 and var_584_7 or var_584_7 * (var_584_12 / var_584_11)

				if var_584_13 > 0 and var_584_7 < var_584_13 then
					arg_581_1.talkMaxDuration = var_584_13

					if var_584_13 + var_584_6 > arg_581_1.duration_ then
						arg_581_1.duration_ = var_584_13 + var_584_6
					end
				end

				arg_581_1.text_.text = var_584_10
				arg_581_1.typewritter.percent = 0

				arg_581_1.typewritter:SetDirty()
				arg_581_1:ShowNextGo(false)
				arg_581_1:RecordContent(arg_581_1.text_.text)
			end

			local var_584_14 = math.max(var_584_7, arg_581_1.talkMaxDuration)

			if var_584_6 <= arg_581_1.time_ and arg_581_1.time_ < var_584_6 + var_584_14 then
				arg_581_1.typewritter.percent = (arg_581_1.time_ - var_584_6) / var_584_14

				arg_581_1.typewritter:SetDirty()
			end

			if arg_581_1.time_ >= var_584_6 + var_584_14 and arg_581_1.time_ < var_584_6 + var_584_14 + arg_584_0 then
				arg_581_1.typewritter.percent = 1

				arg_581_1.typewritter:SetDirty()
				arg_581_1:ShowNextGo(true)
			end
		end

		arg_581_1.nodeConfigList_ = {}

		arg_581_1:InitPlayNodeList()
	end,
	Play1107505147 = function(arg_585_0, arg_585_1)
		arg_585_1.time_ = 0
		arg_585_1.frameCnt_ = 0
		arg_585_1.state_ = "playing"
		arg_585_1.curTalkId_ = 1107505147
		arg_585_1.duration_ = 1

		SetActive(arg_585_1.tipsGo_, false)

		function arg_585_1.onSingleLineFinish_()
			arg_585_1.onSingleLineUpdate_ = nil
			arg_585_1.onSingleLineFinish_ = nil
			arg_585_1.state_ = "waiting"

			SetActive(arg_585_1.choicesGo_, true)

			for iter_586_0, iter_586_1 in ipairs(arg_585_1.choices_) do
				local var_586_0 = iter_586_0 <= 1

				SetActive(iter_586_1.go, var_586_0)
			end

			arg_585_1.choices_[1].txt.text = arg_585_1:FormatText(StoryChoiceCfg[1166].name)
		end

		function arg_585_1.playNext_(arg_587_0)
			if arg_587_0 == 1 then
				arg_585_0:Play1107505148(arg_585_1)
			end

			arg_585_1:RecordChoiceLog(1107505147, 1166)
		end

		function arg_585_1.onSingleLineUpdate_(arg_588_0)
			local var_588_0 = 0

			if var_588_0 < arg_585_1.time_ and arg_585_1.time_ <= var_588_0 + arg_588_0 then
				arg_585_1.allBtn_.enabled = false
			end

			local var_588_1 = 0.5

			if arg_585_1.time_ >= var_588_0 + var_588_1 and arg_585_1.time_ < var_588_0 + var_588_1 + arg_588_0 then
				arg_585_1.allBtn_.enabled = true
			end
		end

		arg_585_1.nodeConfigList_ = {}

		arg_585_1:InitPlayNodeList()
	end,
	Play1107505148 = function(arg_589_0, arg_589_1)
		arg_589_1.time_ = 0
		arg_589_1.frameCnt_ = 0
		arg_589_1.state_ = "playing"
		arg_589_1.curTalkId_ = 1107505148
		arg_589_1.duration_ = 9

		SetActive(arg_589_1.tipsGo_, false)

		function arg_589_1.onSingleLineFinish_()
			arg_589_1.onSingleLineUpdate_ = nil
			arg_589_1.onSingleLineFinish_ = nil
			arg_589_1.state_ = "waiting"
		end

		function arg_589_1.playNext_(arg_591_0)
			if arg_591_0 == 1 then
				arg_589_0:Play1107505149(arg_589_1)
			end
		end

		function arg_589_1.onSingleLineUpdate_(arg_592_0)
			local var_592_0 = "ST37a"

			if arg_589_1.bgs_[var_592_0] == nil then
				local var_592_1 = Object.Instantiate(arg_589_1.paintGo_)

				var_592_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_592_0)
				var_592_1.name = var_592_0
				var_592_1.transform.parent = arg_589_1.stage_.transform
				var_592_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_589_1.bgs_[var_592_0] = var_592_1
			end

			local var_592_2 = 2

			if var_592_2 < arg_589_1.time_ and arg_589_1.time_ <= var_592_2 + arg_592_0 then
				local var_592_3 = manager.ui.mainCamera.transform.localPosition
				local var_592_4 = Vector3.New(0, 0, 10) + Vector3.New(var_592_3.x, var_592_3.y, 0)
				local var_592_5 = arg_589_1.bgs_.ST37a

				var_592_5.transform.localPosition = var_592_4
				var_592_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_592_6 = var_592_5:GetComponent("SpriteRenderer")

				if var_592_6 and var_592_6.sprite then
					local var_592_7 = (var_592_5.transform.localPosition - var_592_3).z
					local var_592_8 = manager.ui.mainCameraCom_
					local var_592_9 = 2 * var_592_7 * Mathf.Tan(var_592_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_592_10 = var_592_9 * var_592_8.aspect
					local var_592_11 = var_592_6.sprite.bounds.size.x
					local var_592_12 = var_592_6.sprite.bounds.size.y
					local var_592_13 = var_592_10 / var_592_11
					local var_592_14 = var_592_9 / var_592_12
					local var_592_15 = var_592_14 < var_592_13 and var_592_13 or var_592_14

					var_592_5.transform.localScale = Vector3.New(var_592_15, var_592_15, 0)
				end

				for iter_592_0, iter_592_1 in pairs(arg_589_1.bgs_) do
					if iter_592_0 ~= "ST37a" then
						iter_592_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_592_16 = 4

			if var_592_16 < arg_589_1.time_ and arg_589_1.time_ <= var_592_16 + arg_592_0 then
				arg_589_1.allBtn_.enabled = false
			end

			local var_592_17 = 0.3

			if arg_589_1.time_ >= var_592_16 + var_592_17 and arg_589_1.time_ < var_592_16 + var_592_17 + arg_592_0 then
				arg_589_1.allBtn_.enabled = true
			end

			local var_592_18 = 0

			if var_592_18 < arg_589_1.time_ and arg_589_1.time_ <= var_592_18 + arg_592_0 then
				arg_589_1.mask_.enabled = true
				arg_589_1.mask_.raycastTarget = true

				arg_589_1:SetGaussion(false)
			end

			local var_592_19 = 2

			if var_592_18 <= arg_589_1.time_ and arg_589_1.time_ < var_592_18 + var_592_19 then
				local var_592_20 = (arg_589_1.time_ - var_592_18) / var_592_19
				local var_592_21 = Color.New(0, 0, 0)

				var_592_21.a = Mathf.Lerp(0, 1, var_592_20)
				arg_589_1.mask_.color = var_592_21
			end

			if arg_589_1.time_ >= var_592_18 + var_592_19 and arg_589_1.time_ < var_592_18 + var_592_19 + arg_592_0 then
				local var_592_22 = Color.New(0, 0, 0)

				var_592_22.a = 1
				arg_589_1.mask_.color = var_592_22
			end

			local var_592_23 = 2

			if var_592_23 < arg_589_1.time_ and arg_589_1.time_ <= var_592_23 + arg_592_0 then
				arg_589_1.mask_.enabled = true
				arg_589_1.mask_.raycastTarget = true

				arg_589_1:SetGaussion(false)
			end

			local var_592_24 = 2

			if var_592_23 <= arg_589_1.time_ and arg_589_1.time_ < var_592_23 + var_592_24 then
				local var_592_25 = (arg_589_1.time_ - var_592_23) / var_592_24
				local var_592_26 = Color.New(0, 0, 0)

				var_592_26.a = Mathf.Lerp(1, 0, var_592_25)
				arg_589_1.mask_.color = var_592_26
			end

			if arg_589_1.time_ >= var_592_23 + var_592_24 and arg_589_1.time_ < var_592_23 + var_592_24 + arg_592_0 then
				local var_592_27 = Color.New(0, 0, 0)
				local var_592_28 = 0

				arg_589_1.mask_.enabled = false
				var_592_27.a = var_592_28
				arg_589_1.mask_.color = var_592_27
			end

			local var_592_29 = arg_589_1.actors_["1075ui_actor"].transform
			local var_592_30 = 1.96599999815226

			if var_592_30 < arg_589_1.time_ and arg_589_1.time_ <= var_592_30 + arg_592_0 then
				arg_589_1.var_.moveOldPos1075ui_actor = var_592_29.localPosition

				local var_592_31 = GameObjectTools.GetOrAddComponent(var_592_29.gameObject, typeof(DynamicBoneHelper))

				if var_592_31 then
					var_592_31:EnableDynamicBone(false)
				end
			end

			local var_592_32 = 0.001

			if var_592_30 <= arg_589_1.time_ and arg_589_1.time_ < var_592_30 + var_592_32 then
				local var_592_33 = (arg_589_1.time_ - var_592_30) / var_592_32
				local var_592_34 = Vector3.New(0, 100, 0)

				var_592_29.localPosition = Vector3.Lerp(arg_589_1.var_.moveOldPos1075ui_actor, var_592_34, var_592_33)

				local var_592_35 = manager.ui.mainCamera.transform.position - var_592_29.position

				var_592_29.forward = Vector3.New(var_592_35.x, var_592_35.y, var_592_35.z)

				local var_592_36 = var_592_29.localEulerAngles

				var_592_36.z = 0
				var_592_36.x = 0
				var_592_29.localEulerAngles = var_592_36
			end

			if arg_589_1.time_ >= var_592_30 + var_592_32 and arg_589_1.time_ < var_592_30 + var_592_32 + arg_592_0 then
				var_592_29.localPosition = Vector3.New(0, 100, 0)

				local var_592_37 = manager.ui.mainCamera.transform.position - var_592_29.position

				var_592_29.forward = Vector3.New(var_592_37.x, var_592_37.y, var_592_37.z)

				local var_592_38 = var_592_29.localEulerAngles

				var_592_38.z = 0
				var_592_38.x = 0
				var_592_29.localEulerAngles = var_592_38

				local var_592_39 = GameObjectTools.GetOrAddComponent(var_592_29.gameObject, typeof(DynamicBoneHelper))

				if var_592_39 then
					var_592_39:EnableDynamicBone(true)
				end
			end

			if arg_589_1.frameCnt_ <= 1 then
				arg_589_1.dialog_:SetActive(false)
			end

			local var_592_40 = 4
			local var_592_41 = 1.075

			if var_592_40 < arg_589_1.time_ and arg_589_1.time_ <= var_592_40 + arg_592_0 then
				arg_589_1.talkMaxDuration = 0

				arg_589_1.dialog_:SetActive(true)

				arg_589_1.dialogCg_.alpha = 0

				local var_592_42 = LeanTween.value(arg_589_1.dialog_, 0, 1, 0.3)

				var_592_42:setOnUpdate(LuaHelper.FloatAction(function(arg_593_0)
					arg_589_1.dialogCg_.alpha = arg_593_0
				end))
				var_592_42:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_589_1.dialog_)
					var_592_42:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_589_1.duration_ = arg_589_1.duration_ + 0.3

				SetActive(arg_589_1.leftNameGo_, false)

				arg_589_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_589_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_589_1:RecordName(arg_589_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_589_1.iconTrs_.gameObject, false)
				arg_589_1.callingController_:SetSelectedState("normal")

				local var_592_43 = arg_589_1:GetWordFromCfg(1107505148)
				local var_592_44 = arg_589_1:FormatText(var_592_43.content)

				arg_589_1.text_.text = var_592_44

				LuaForUtil.ClearLinePrefixSymbol(arg_589_1.text_)

				local var_592_45 = 43
				local var_592_46 = utf8.len(var_592_44)
				local var_592_47 = var_592_45 <= 0 and var_592_41 or var_592_41 * (var_592_46 / var_592_45)

				if var_592_47 > 0 and var_592_41 < var_592_47 then
					arg_589_1.talkMaxDuration = var_592_47
					var_592_40 = var_592_40 + 0.3

					if var_592_47 + var_592_40 > arg_589_1.duration_ then
						arg_589_1.duration_ = var_592_47 + var_592_40
					end
				end

				arg_589_1.text_.text = var_592_44
				arg_589_1.typewritter.percent = 0

				arg_589_1.typewritter:SetDirty()
				arg_589_1:ShowNextGo(false)
				arg_589_1:RecordContent(arg_589_1.text_.text)
			end

			local var_592_48 = var_592_40 + 0.3
			local var_592_49 = math.max(var_592_41, arg_589_1.talkMaxDuration)

			if var_592_48 <= arg_589_1.time_ and arg_589_1.time_ < var_592_48 + var_592_49 then
				arg_589_1.typewritter.percent = (arg_589_1.time_ - var_592_48) / var_592_49

				arg_589_1.typewritter:SetDirty()
			end

			if arg_589_1.time_ >= var_592_48 + var_592_49 and arg_589_1.time_ < var_592_48 + var_592_49 + arg_592_0 then
				arg_589_1.typewritter.percent = 1

				arg_589_1.typewritter:SetDirty()
				arg_589_1:ShowNextGo(true)
			end
		end

		arg_589_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_actor",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_589_1:InitPlayNodeList()
	end,
	Play1107505149 = function(arg_595_0, arg_595_1)
		arg_595_1.time_ = 0
		arg_595_1.frameCnt_ = 0
		arg_595_1.state_ = "playing"
		arg_595_1.curTalkId_ = 1107505149
		arg_595_1.duration_ = 4.4

		SetActive(arg_595_1.tipsGo_, false)

		function arg_595_1.onSingleLineFinish_()
			arg_595_1.onSingleLineUpdate_ = nil
			arg_595_1.onSingleLineFinish_ = nil
			arg_595_1.state_ = "waiting"
		end

		function arg_595_1.playNext_(arg_597_0)
			if arg_597_0 == 1 then
				arg_595_0:Play1107505150(arg_595_1)
			end
		end

		function arg_595_1.onSingleLineUpdate_(arg_598_0)
			local var_598_0 = arg_595_1.actors_["1075ui_actor"].transform
			local var_598_1 = 0

			if var_598_1 < arg_595_1.time_ and arg_595_1.time_ <= var_598_1 + arg_598_0 then
				arg_595_1.var_.moveOldPos1075ui_actor = var_598_0.localPosition

				local var_598_2 = GameObjectTools.GetOrAddComponent(var_598_0.gameObject, typeof(DynamicBoneHelper))

				if var_598_2 then
					var_598_2:EnableDynamicBone(false)
				end
			end

			local var_598_3 = 0.001

			if var_598_1 <= arg_595_1.time_ and arg_595_1.time_ < var_598_1 + var_598_3 then
				local var_598_4 = (arg_595_1.time_ - var_598_1) / var_598_3
				local var_598_5 = Vector3.New(0, -1.055, -6.16)

				var_598_0.localPosition = Vector3.Lerp(arg_595_1.var_.moveOldPos1075ui_actor, var_598_5, var_598_4)

				local var_598_6 = manager.ui.mainCamera.transform.position - var_598_0.position

				var_598_0.forward = Vector3.New(var_598_6.x, var_598_6.y, var_598_6.z)

				local var_598_7 = var_598_0.localEulerAngles

				var_598_7.z = 0
				var_598_7.x = 0
				var_598_0.localEulerAngles = var_598_7
			end

			if arg_595_1.time_ >= var_598_1 + var_598_3 and arg_595_1.time_ < var_598_1 + var_598_3 + arg_598_0 then
				var_598_0.localPosition = Vector3.New(0, -1.055, -6.16)

				local var_598_8 = manager.ui.mainCamera.transform.position - var_598_0.position

				var_598_0.forward = Vector3.New(var_598_8.x, var_598_8.y, var_598_8.z)

				local var_598_9 = var_598_0.localEulerAngles

				var_598_9.z = 0
				var_598_9.x = 0
				var_598_0.localEulerAngles = var_598_9

				local var_598_10 = GameObjectTools.GetOrAddComponent(var_598_0.gameObject, typeof(DynamicBoneHelper))

				if var_598_10 then
					var_598_10:EnableDynamicBone(true)
				end
			end

			local var_598_11 = arg_595_1.actors_["1075ui_actor"]
			local var_598_12 = 0

			if var_598_12 < arg_595_1.time_ and arg_595_1.time_ <= var_598_12 + arg_598_0 and not isNil(var_598_11) and arg_595_1.var_.characterEffect1075ui_actor == nil then
				arg_595_1.var_.characterEffect1075ui_actor = var_598_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_598_13 = 0.200000002980232

			if var_598_12 <= arg_595_1.time_ and arg_595_1.time_ < var_598_12 + var_598_13 and not isNil(var_598_11) then
				local var_598_14 = (arg_595_1.time_ - var_598_12) / var_598_13

				if arg_595_1.var_.characterEffect1075ui_actor and not isNil(var_598_11) then
					arg_595_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_595_1.time_ >= var_598_12 + var_598_13 and arg_595_1.time_ < var_598_12 + var_598_13 + arg_598_0 and not isNil(var_598_11) and arg_595_1.var_.characterEffect1075ui_actor then
				arg_595_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			local var_598_15 = 0

			if var_598_15 < arg_595_1.time_ and arg_595_1.time_ <= var_598_15 + arg_598_0 then
				arg_595_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075action/1075action1_1")
			end

			local var_598_16 = 0

			if var_598_16 < arg_595_1.time_ and arg_595_1.time_ <= var_598_16 + arg_598_0 then
				arg_595_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_598_17 = 0
			local var_598_18 = 0.275

			if var_598_17 < arg_595_1.time_ and arg_595_1.time_ <= var_598_17 + arg_598_0 then
				arg_595_1.talkMaxDuration = 0
				arg_595_1.dialogCg_.alpha = 1

				arg_595_1.dialog_:SetActive(true)
				SetActive(arg_595_1.leftNameGo_, true)

				local var_598_19 = arg_595_1:FormatText(StoryNameCfg[381].name)

				arg_595_1.leftNameTxt_.text = var_598_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_595_1.leftNameTxt_.transform)

				arg_595_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_595_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_595_1:RecordName(arg_595_1.leftNameTxt_.text)
				SetActive(arg_595_1.iconTrs_.gameObject, false)
				arg_595_1.callingController_:SetSelectedState("normal")

				local var_598_20 = arg_595_1:GetWordFromCfg(1107505149)
				local var_598_21 = arg_595_1:FormatText(var_598_20.content)

				arg_595_1.text_.text = var_598_21

				LuaForUtil.ClearLinePrefixSymbol(arg_595_1.text_)

				local var_598_22 = 11
				local var_598_23 = utf8.len(var_598_21)
				local var_598_24 = var_598_22 <= 0 and var_598_18 or var_598_18 * (var_598_23 / var_598_22)

				if var_598_24 > 0 and var_598_18 < var_598_24 then
					arg_595_1.talkMaxDuration = var_598_24

					if var_598_24 + var_598_17 > arg_595_1.duration_ then
						arg_595_1.duration_ = var_598_24 + var_598_17
					end
				end

				arg_595_1.text_.text = var_598_21
				arg_595_1.typewritter.percent = 0

				arg_595_1.typewritter:SetDirty()
				arg_595_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107505", "1107505149", "story_v_side_new_1107505.awb") ~= 0 then
					local var_598_25 = manager.audio:GetVoiceLength("story_v_side_new_1107505", "1107505149", "story_v_side_new_1107505.awb") / 1000

					if var_598_25 + var_598_17 > arg_595_1.duration_ then
						arg_595_1.duration_ = var_598_25 + var_598_17
					end

					if var_598_20.prefab_name ~= "" and arg_595_1.actors_[var_598_20.prefab_name] ~= nil then
						local var_598_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_595_1.actors_[var_598_20.prefab_name].transform, "story_v_side_new_1107505", "1107505149", "story_v_side_new_1107505.awb")

						arg_595_1:RecordAudio("1107505149", var_598_26)
						arg_595_1:RecordAudio("1107505149", var_598_26)
					else
						arg_595_1:AudioAction("play", "voice", "story_v_side_new_1107505", "1107505149", "story_v_side_new_1107505.awb")
					end

					arg_595_1:RecordHistoryTalkVoice("story_v_side_new_1107505", "1107505149", "story_v_side_new_1107505.awb")
				end

				arg_595_1:RecordContent(arg_595_1.text_.text)
			end

			local var_598_27 = math.max(var_598_18, arg_595_1.talkMaxDuration)

			if var_598_17 <= arg_595_1.time_ and arg_595_1.time_ < var_598_17 + var_598_27 then
				arg_595_1.typewritter.percent = (arg_595_1.time_ - var_598_17) / var_598_27

				arg_595_1.typewritter:SetDirty()
			end

			if arg_595_1.time_ >= var_598_17 + var_598_27 and arg_595_1.time_ < var_598_17 + var_598_27 + arg_598_0 then
				arg_595_1.typewritter.percent = 1

				arg_595_1.typewritter:SetDirty()
				arg_595_1:ShowNextGo(true)
			end
		end

		arg_595_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_actor",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_595_1:InitPlayNodeList()
	end,
	Play1107505150 = function(arg_599_0, arg_599_1)
		arg_599_1.time_ = 0
		arg_599_1.frameCnt_ = 0
		arg_599_1.state_ = "playing"
		arg_599_1.curTalkId_ = 1107505150
		arg_599_1.duration_ = 5

		SetActive(arg_599_1.tipsGo_, false)

		function arg_599_1.onSingleLineFinish_()
			arg_599_1.onSingleLineUpdate_ = nil
			arg_599_1.onSingleLineFinish_ = nil
			arg_599_1.state_ = "waiting"
		end

		function arg_599_1.playNext_(arg_601_0)
			if arg_601_0 == 1 then
				arg_599_0:Play1107505151(arg_599_1)
			end
		end

		function arg_599_1.onSingleLineUpdate_(arg_602_0)
			local var_602_0 = arg_599_1.actors_["1075ui_actor"]
			local var_602_1 = 0

			if var_602_1 < arg_599_1.time_ and arg_599_1.time_ <= var_602_1 + arg_602_0 and not isNil(var_602_0) and arg_599_1.var_.characterEffect1075ui_actor == nil then
				arg_599_1.var_.characterEffect1075ui_actor = var_602_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_602_2 = 0.200000002980232

			if var_602_1 <= arg_599_1.time_ and arg_599_1.time_ < var_602_1 + var_602_2 and not isNil(var_602_0) then
				local var_602_3 = (arg_599_1.time_ - var_602_1) / var_602_2

				if arg_599_1.var_.characterEffect1075ui_actor and not isNil(var_602_0) then
					local var_602_4 = Mathf.Lerp(0, 0.5, var_602_3)

					arg_599_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_599_1.var_.characterEffect1075ui_actor.fillRatio = var_602_4
				end
			end

			if arg_599_1.time_ >= var_602_1 + var_602_2 and arg_599_1.time_ < var_602_1 + var_602_2 + arg_602_0 and not isNil(var_602_0) and arg_599_1.var_.characterEffect1075ui_actor then
				local var_602_5 = 0.5

				arg_599_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_599_1.var_.characterEffect1075ui_actor.fillRatio = var_602_5
			end

			local var_602_6 = 0
			local var_602_7 = 0.125

			if var_602_6 < arg_599_1.time_ and arg_599_1.time_ <= var_602_6 + arg_602_0 then
				arg_599_1.talkMaxDuration = 0
				arg_599_1.dialogCg_.alpha = 1

				arg_599_1.dialog_:SetActive(true)
				SetActive(arg_599_1.leftNameGo_, true)

				local var_602_8 = arg_599_1:FormatText(StoryNameCfg[7].name)

				arg_599_1.leftNameTxt_.text = var_602_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_599_1.leftNameTxt_.transform)

				arg_599_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_599_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_599_1:RecordName(arg_599_1.leftNameTxt_.text)
				SetActive(arg_599_1.iconTrs_.gameObject, true)
				arg_599_1.iconController_:SetSelectedState("hero")

				arg_599_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_599_1.callingController_:SetSelectedState("normal")

				arg_599_1.keyicon_.color = Color.New(1, 1, 1)
				arg_599_1.icon_.color = Color.New(1, 1, 1)

				local var_602_9 = arg_599_1:GetWordFromCfg(1107505150)
				local var_602_10 = arg_599_1:FormatText(var_602_9.content)

				arg_599_1.text_.text = var_602_10

				LuaForUtil.ClearLinePrefixSymbol(arg_599_1.text_)

				local var_602_11 = 5
				local var_602_12 = utf8.len(var_602_10)
				local var_602_13 = var_602_11 <= 0 and var_602_7 or var_602_7 * (var_602_12 / var_602_11)

				if var_602_13 > 0 and var_602_7 < var_602_13 then
					arg_599_1.talkMaxDuration = var_602_13

					if var_602_13 + var_602_6 > arg_599_1.duration_ then
						arg_599_1.duration_ = var_602_13 + var_602_6
					end
				end

				arg_599_1.text_.text = var_602_10
				arg_599_1.typewritter.percent = 0

				arg_599_1.typewritter:SetDirty()
				arg_599_1:ShowNextGo(false)
				arg_599_1:RecordContent(arg_599_1.text_.text)
			end

			local var_602_14 = math.max(var_602_7, arg_599_1.talkMaxDuration)

			if var_602_6 <= arg_599_1.time_ and arg_599_1.time_ < var_602_6 + var_602_14 then
				arg_599_1.typewritter.percent = (arg_599_1.time_ - var_602_6) / var_602_14

				arg_599_1.typewritter:SetDirty()
			end

			if arg_599_1.time_ >= var_602_6 + var_602_14 and arg_599_1.time_ < var_602_6 + var_602_14 + arg_602_0 then
				arg_599_1.typewritter.percent = 1

				arg_599_1.typewritter:SetDirty()
				arg_599_1:ShowNextGo(true)
			end
		end

		arg_599_1.nodeConfigList_ = {}

		arg_599_1:InitPlayNodeList()
	end,
	Play1107505151 = function(arg_603_0, arg_603_1)
		arg_603_1.time_ = 0
		arg_603_1.frameCnt_ = 0
		arg_603_1.state_ = "playing"
		arg_603_1.curTalkId_ = 1107505151
		arg_603_1.duration_ = 7.17

		SetActive(arg_603_1.tipsGo_, false)

		function arg_603_1.onSingleLineFinish_()
			arg_603_1.onSingleLineUpdate_ = nil
			arg_603_1.onSingleLineFinish_ = nil
			arg_603_1.state_ = "waiting"
		end

		function arg_603_1.playNext_(arg_605_0)
			if arg_605_0 == 1 then
				arg_603_0:Play1107505152(arg_603_1)
			end
		end

		function arg_603_1.onSingleLineUpdate_(arg_606_0)
			local var_606_0 = arg_603_1.actors_["1075ui_actor"]
			local var_606_1 = 0

			if var_606_1 < arg_603_1.time_ and arg_603_1.time_ <= var_606_1 + arg_606_0 and not isNil(var_606_0) and arg_603_1.var_.characterEffect1075ui_actor == nil then
				arg_603_1.var_.characterEffect1075ui_actor = var_606_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_606_2 = 0.200000002980232

			if var_606_1 <= arg_603_1.time_ and arg_603_1.time_ < var_606_1 + var_606_2 and not isNil(var_606_0) then
				local var_606_3 = (arg_603_1.time_ - var_606_1) / var_606_2

				if arg_603_1.var_.characterEffect1075ui_actor and not isNil(var_606_0) then
					arg_603_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_603_1.time_ >= var_606_1 + var_606_2 and arg_603_1.time_ < var_606_1 + var_606_2 + arg_606_0 and not isNil(var_606_0) and arg_603_1.var_.characterEffect1075ui_actor then
				arg_603_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			local var_606_4 = 0

			if var_606_4 < arg_603_1.time_ and arg_603_1.time_ <= var_606_4 + arg_606_0 then
				arg_603_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075action/1075action4_1")
			end

			local var_606_5 = 0

			if var_606_5 < arg_603_1.time_ and arg_603_1.time_ <= var_606_5 + arg_606_0 then
				arg_603_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_606_6 = 0
			local var_606_7 = 0.6

			if var_606_6 < arg_603_1.time_ and arg_603_1.time_ <= var_606_6 + arg_606_0 then
				arg_603_1.talkMaxDuration = 0
				arg_603_1.dialogCg_.alpha = 1

				arg_603_1.dialog_:SetActive(true)
				SetActive(arg_603_1.leftNameGo_, true)

				local var_606_8 = arg_603_1:FormatText(StoryNameCfg[381].name)

				arg_603_1.leftNameTxt_.text = var_606_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_603_1.leftNameTxt_.transform)

				arg_603_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_603_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_603_1:RecordName(arg_603_1.leftNameTxt_.text)
				SetActive(arg_603_1.iconTrs_.gameObject, false)
				arg_603_1.callingController_:SetSelectedState("normal")

				local var_606_9 = arg_603_1:GetWordFromCfg(1107505151)
				local var_606_10 = arg_603_1:FormatText(var_606_9.content)

				arg_603_1.text_.text = var_606_10

				LuaForUtil.ClearLinePrefixSymbol(arg_603_1.text_)

				local var_606_11 = 24
				local var_606_12 = utf8.len(var_606_10)
				local var_606_13 = var_606_11 <= 0 and var_606_7 or var_606_7 * (var_606_12 / var_606_11)

				if var_606_13 > 0 and var_606_7 < var_606_13 then
					arg_603_1.talkMaxDuration = var_606_13

					if var_606_13 + var_606_6 > arg_603_1.duration_ then
						arg_603_1.duration_ = var_606_13 + var_606_6
					end
				end

				arg_603_1.text_.text = var_606_10
				arg_603_1.typewritter.percent = 0

				arg_603_1.typewritter:SetDirty()
				arg_603_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107505", "1107505151", "story_v_side_new_1107505.awb") ~= 0 then
					local var_606_14 = manager.audio:GetVoiceLength("story_v_side_new_1107505", "1107505151", "story_v_side_new_1107505.awb") / 1000

					if var_606_14 + var_606_6 > arg_603_1.duration_ then
						arg_603_1.duration_ = var_606_14 + var_606_6
					end

					if var_606_9.prefab_name ~= "" and arg_603_1.actors_[var_606_9.prefab_name] ~= nil then
						local var_606_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_603_1.actors_[var_606_9.prefab_name].transform, "story_v_side_new_1107505", "1107505151", "story_v_side_new_1107505.awb")

						arg_603_1:RecordAudio("1107505151", var_606_15)
						arg_603_1:RecordAudio("1107505151", var_606_15)
					else
						arg_603_1:AudioAction("play", "voice", "story_v_side_new_1107505", "1107505151", "story_v_side_new_1107505.awb")
					end

					arg_603_1:RecordHistoryTalkVoice("story_v_side_new_1107505", "1107505151", "story_v_side_new_1107505.awb")
				end

				arg_603_1:RecordContent(arg_603_1.text_.text)
			end

			local var_606_16 = math.max(var_606_7, arg_603_1.talkMaxDuration)

			if var_606_6 <= arg_603_1.time_ and arg_603_1.time_ < var_606_6 + var_606_16 then
				arg_603_1.typewritter.percent = (arg_603_1.time_ - var_606_6) / var_606_16

				arg_603_1.typewritter:SetDirty()
			end

			if arg_603_1.time_ >= var_606_6 + var_606_16 and arg_603_1.time_ < var_606_6 + var_606_16 + arg_606_0 then
				arg_603_1.typewritter.percent = 1

				arg_603_1.typewritter:SetDirty()
				arg_603_1:ShowNextGo(true)
			end
		end

		arg_603_1.nodeConfigList_ = {}

		arg_603_1:InitPlayNodeList()
	end,
	Play1107505152 = function(arg_607_0, arg_607_1)
		arg_607_1.time_ = 0
		arg_607_1.frameCnt_ = 0
		arg_607_1.state_ = "playing"
		arg_607_1.curTalkId_ = 1107505152
		arg_607_1.duration_ = 5

		SetActive(arg_607_1.tipsGo_, false)

		function arg_607_1.onSingleLineFinish_()
			arg_607_1.onSingleLineUpdate_ = nil
			arg_607_1.onSingleLineFinish_ = nil
			arg_607_1.state_ = "waiting"
		end

		function arg_607_1.playNext_(arg_609_0)
			if arg_609_0 == 1 then
				arg_607_0:Play1107505153(arg_607_1)
			end
		end

		function arg_607_1.onSingleLineUpdate_(arg_610_0)
			local var_610_0 = arg_607_1.actors_["1075ui_actor"]
			local var_610_1 = 0

			if var_610_1 < arg_607_1.time_ and arg_607_1.time_ <= var_610_1 + arg_610_0 and not isNil(var_610_0) and arg_607_1.var_.characterEffect1075ui_actor == nil then
				arg_607_1.var_.characterEffect1075ui_actor = var_610_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_610_2 = 0.200000002980232

			if var_610_1 <= arg_607_1.time_ and arg_607_1.time_ < var_610_1 + var_610_2 and not isNil(var_610_0) then
				local var_610_3 = (arg_607_1.time_ - var_610_1) / var_610_2

				if arg_607_1.var_.characterEffect1075ui_actor and not isNil(var_610_0) then
					local var_610_4 = Mathf.Lerp(0, 0.5, var_610_3)

					arg_607_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_607_1.var_.characterEffect1075ui_actor.fillRatio = var_610_4
				end
			end

			if arg_607_1.time_ >= var_610_1 + var_610_2 and arg_607_1.time_ < var_610_1 + var_610_2 + arg_610_0 and not isNil(var_610_0) and arg_607_1.var_.characterEffect1075ui_actor then
				local var_610_5 = 0.5

				arg_607_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_607_1.var_.characterEffect1075ui_actor.fillRatio = var_610_5
			end

			local var_610_6 = 0
			local var_610_7 = 0.375

			if var_610_6 < arg_607_1.time_ and arg_607_1.time_ <= var_610_6 + arg_610_0 then
				arg_607_1.talkMaxDuration = 0
				arg_607_1.dialogCg_.alpha = 1

				arg_607_1.dialog_:SetActive(true)
				SetActive(arg_607_1.leftNameGo_, true)

				local var_610_8 = arg_607_1:FormatText(StoryNameCfg[7].name)

				arg_607_1.leftNameTxt_.text = var_610_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_607_1.leftNameTxt_.transform)

				arg_607_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_607_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_607_1:RecordName(arg_607_1.leftNameTxt_.text)
				SetActive(arg_607_1.iconTrs_.gameObject, true)
				arg_607_1.iconController_:SetSelectedState("hero")

				arg_607_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_607_1.callingController_:SetSelectedState("normal")

				arg_607_1.keyicon_.color = Color.New(1, 1, 1)
				arg_607_1.icon_.color = Color.New(1, 1, 1)

				local var_610_9 = arg_607_1:GetWordFromCfg(1107505152)
				local var_610_10 = arg_607_1:FormatText(var_610_9.content)

				arg_607_1.text_.text = var_610_10

				LuaForUtil.ClearLinePrefixSymbol(arg_607_1.text_)

				local var_610_11 = 15
				local var_610_12 = utf8.len(var_610_10)
				local var_610_13 = var_610_11 <= 0 and var_610_7 or var_610_7 * (var_610_12 / var_610_11)

				if var_610_13 > 0 and var_610_7 < var_610_13 then
					arg_607_1.talkMaxDuration = var_610_13

					if var_610_13 + var_610_6 > arg_607_1.duration_ then
						arg_607_1.duration_ = var_610_13 + var_610_6
					end
				end

				arg_607_1.text_.text = var_610_10
				arg_607_1.typewritter.percent = 0

				arg_607_1.typewritter:SetDirty()
				arg_607_1:ShowNextGo(false)
				arg_607_1:RecordContent(arg_607_1.text_.text)
			end

			local var_610_14 = math.max(var_610_7, arg_607_1.talkMaxDuration)

			if var_610_6 <= arg_607_1.time_ and arg_607_1.time_ < var_610_6 + var_610_14 then
				arg_607_1.typewritter.percent = (arg_607_1.time_ - var_610_6) / var_610_14

				arg_607_1.typewritter:SetDirty()
			end

			if arg_607_1.time_ >= var_610_6 + var_610_14 and arg_607_1.time_ < var_610_6 + var_610_14 + arg_610_0 then
				arg_607_1.typewritter.percent = 1

				arg_607_1.typewritter:SetDirty()
				arg_607_1:ShowNextGo(true)
			end
		end

		arg_607_1.nodeConfigList_ = {}

		arg_607_1:InitPlayNodeList()
	end,
	Play1107505153 = function(arg_611_0, arg_611_1)
		arg_611_1.time_ = 0
		arg_611_1.frameCnt_ = 0
		arg_611_1.state_ = "playing"
		arg_611_1.curTalkId_ = 1107505153
		arg_611_1.duration_ = 8.63

		SetActive(arg_611_1.tipsGo_, false)

		function arg_611_1.onSingleLineFinish_()
			arg_611_1.onSingleLineUpdate_ = nil
			arg_611_1.onSingleLineFinish_ = nil
			arg_611_1.state_ = "waiting"
		end

		function arg_611_1.playNext_(arg_613_0)
			if arg_613_0 == 1 then
				arg_611_0:Play1107505154(arg_611_1)
			end
		end

		function arg_611_1.onSingleLineUpdate_(arg_614_0)
			local var_614_0 = arg_611_1.actors_["1075ui_actor"]
			local var_614_1 = 0

			if var_614_1 < arg_611_1.time_ and arg_611_1.time_ <= var_614_1 + arg_614_0 and not isNil(var_614_0) and arg_611_1.var_.characterEffect1075ui_actor == nil then
				arg_611_1.var_.characterEffect1075ui_actor = var_614_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_614_2 = 0.200000002980232

			if var_614_1 <= arg_611_1.time_ and arg_611_1.time_ < var_614_1 + var_614_2 and not isNil(var_614_0) then
				local var_614_3 = (arg_611_1.time_ - var_614_1) / var_614_2

				if arg_611_1.var_.characterEffect1075ui_actor and not isNil(var_614_0) then
					arg_611_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_611_1.time_ >= var_614_1 + var_614_2 and arg_611_1.time_ < var_614_1 + var_614_2 + arg_614_0 and not isNil(var_614_0) and arg_611_1.var_.characterEffect1075ui_actor then
				arg_611_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			local var_614_4 = 0

			if var_614_4 < arg_611_1.time_ and arg_611_1.time_ <= var_614_4 + arg_614_0 then
				arg_611_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075actionlink/1075action442")
			end

			local var_614_5 = 0

			if var_614_5 < arg_611_1.time_ and arg_611_1.time_ <= var_614_5 + arg_614_0 then
				arg_611_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_614_6 = 0
			local var_614_7 = 0.85

			if var_614_6 < arg_611_1.time_ and arg_611_1.time_ <= var_614_6 + arg_614_0 then
				arg_611_1.talkMaxDuration = 0
				arg_611_1.dialogCg_.alpha = 1

				arg_611_1.dialog_:SetActive(true)
				SetActive(arg_611_1.leftNameGo_, true)

				local var_614_8 = arg_611_1:FormatText(StoryNameCfg[381].name)

				arg_611_1.leftNameTxt_.text = var_614_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_611_1.leftNameTxt_.transform)

				arg_611_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_611_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_611_1:RecordName(arg_611_1.leftNameTxt_.text)
				SetActive(arg_611_1.iconTrs_.gameObject, false)
				arg_611_1.callingController_:SetSelectedState("normal")

				local var_614_9 = arg_611_1:GetWordFromCfg(1107505153)
				local var_614_10 = arg_611_1:FormatText(var_614_9.content)

				arg_611_1.text_.text = var_614_10

				LuaForUtil.ClearLinePrefixSymbol(arg_611_1.text_)

				local var_614_11 = 34
				local var_614_12 = utf8.len(var_614_10)
				local var_614_13 = var_614_11 <= 0 and var_614_7 or var_614_7 * (var_614_12 / var_614_11)

				if var_614_13 > 0 and var_614_7 < var_614_13 then
					arg_611_1.talkMaxDuration = var_614_13

					if var_614_13 + var_614_6 > arg_611_1.duration_ then
						arg_611_1.duration_ = var_614_13 + var_614_6
					end
				end

				arg_611_1.text_.text = var_614_10
				arg_611_1.typewritter.percent = 0

				arg_611_1.typewritter:SetDirty()
				arg_611_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107505", "1107505153", "story_v_side_new_1107505.awb") ~= 0 then
					local var_614_14 = manager.audio:GetVoiceLength("story_v_side_new_1107505", "1107505153", "story_v_side_new_1107505.awb") / 1000

					if var_614_14 + var_614_6 > arg_611_1.duration_ then
						arg_611_1.duration_ = var_614_14 + var_614_6
					end

					if var_614_9.prefab_name ~= "" and arg_611_1.actors_[var_614_9.prefab_name] ~= nil then
						local var_614_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_611_1.actors_[var_614_9.prefab_name].transform, "story_v_side_new_1107505", "1107505153", "story_v_side_new_1107505.awb")

						arg_611_1:RecordAudio("1107505153", var_614_15)
						arg_611_1:RecordAudio("1107505153", var_614_15)
					else
						arg_611_1:AudioAction("play", "voice", "story_v_side_new_1107505", "1107505153", "story_v_side_new_1107505.awb")
					end

					arg_611_1:RecordHistoryTalkVoice("story_v_side_new_1107505", "1107505153", "story_v_side_new_1107505.awb")
				end

				arg_611_1:RecordContent(arg_611_1.text_.text)
			end

			local var_614_16 = math.max(var_614_7, arg_611_1.talkMaxDuration)

			if var_614_6 <= arg_611_1.time_ and arg_611_1.time_ < var_614_6 + var_614_16 then
				arg_611_1.typewritter.percent = (arg_611_1.time_ - var_614_6) / var_614_16

				arg_611_1.typewritter:SetDirty()
			end

			if arg_611_1.time_ >= var_614_6 + var_614_16 and arg_611_1.time_ < var_614_6 + var_614_16 + arg_614_0 then
				arg_611_1.typewritter.percent = 1

				arg_611_1.typewritter:SetDirty()
				arg_611_1:ShowNextGo(true)
			end
		end

		arg_611_1.nodeConfigList_ = {}

		arg_611_1:InitPlayNodeList()
	end,
	Play1107505154 = function(arg_615_0, arg_615_1)
		arg_615_1.time_ = 0
		arg_615_1.frameCnt_ = 0
		arg_615_1.state_ = "playing"
		arg_615_1.curTalkId_ = 1107505154
		arg_615_1.duration_ = 4.33

		SetActive(arg_615_1.tipsGo_, false)

		function arg_615_1.onSingleLineFinish_()
			arg_615_1.onSingleLineUpdate_ = nil
			arg_615_1.onSingleLineFinish_ = nil
			arg_615_1.state_ = "waiting"
		end

		function arg_615_1.playNext_(arg_617_0)
			if arg_617_0 == 1 then
				arg_615_0:Play1107505155(arg_615_1)
			end
		end

		function arg_615_1.onSingleLineUpdate_(arg_618_0)
			local var_618_0 = 0

			if var_618_0 < arg_615_1.time_ and arg_615_1.time_ <= var_618_0 + arg_618_0 then
				arg_615_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075actionlink/1075action425")
			end

			local var_618_1 = 0

			if var_618_1 < arg_615_1.time_ and arg_615_1.time_ <= var_618_1 + arg_618_0 then
				arg_615_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_618_2 = 0
			local var_618_3 = 0.35

			if var_618_2 < arg_615_1.time_ and arg_615_1.time_ <= var_618_2 + arg_618_0 then
				arg_615_1.talkMaxDuration = 0
				arg_615_1.dialogCg_.alpha = 1

				arg_615_1.dialog_:SetActive(true)
				SetActive(arg_615_1.leftNameGo_, true)

				local var_618_4 = arg_615_1:FormatText(StoryNameCfg[381].name)

				arg_615_1.leftNameTxt_.text = var_618_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_615_1.leftNameTxt_.transform)

				arg_615_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_615_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_615_1:RecordName(arg_615_1.leftNameTxt_.text)
				SetActive(arg_615_1.iconTrs_.gameObject, false)
				arg_615_1.callingController_:SetSelectedState("normal")

				local var_618_5 = arg_615_1:GetWordFromCfg(1107505154)
				local var_618_6 = arg_615_1:FormatText(var_618_5.content)

				arg_615_1.text_.text = var_618_6

				LuaForUtil.ClearLinePrefixSymbol(arg_615_1.text_)

				local var_618_7 = 14
				local var_618_8 = utf8.len(var_618_6)
				local var_618_9 = var_618_7 <= 0 and var_618_3 or var_618_3 * (var_618_8 / var_618_7)

				if var_618_9 > 0 and var_618_3 < var_618_9 then
					arg_615_1.talkMaxDuration = var_618_9

					if var_618_9 + var_618_2 > arg_615_1.duration_ then
						arg_615_1.duration_ = var_618_9 + var_618_2
					end
				end

				arg_615_1.text_.text = var_618_6
				arg_615_1.typewritter.percent = 0

				arg_615_1.typewritter:SetDirty()
				arg_615_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107505", "1107505154", "story_v_side_new_1107505.awb") ~= 0 then
					local var_618_10 = manager.audio:GetVoiceLength("story_v_side_new_1107505", "1107505154", "story_v_side_new_1107505.awb") / 1000

					if var_618_10 + var_618_2 > arg_615_1.duration_ then
						arg_615_1.duration_ = var_618_10 + var_618_2
					end

					if var_618_5.prefab_name ~= "" and arg_615_1.actors_[var_618_5.prefab_name] ~= nil then
						local var_618_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_615_1.actors_[var_618_5.prefab_name].transform, "story_v_side_new_1107505", "1107505154", "story_v_side_new_1107505.awb")

						arg_615_1:RecordAudio("1107505154", var_618_11)
						arg_615_1:RecordAudio("1107505154", var_618_11)
					else
						arg_615_1:AudioAction("play", "voice", "story_v_side_new_1107505", "1107505154", "story_v_side_new_1107505.awb")
					end

					arg_615_1:RecordHistoryTalkVoice("story_v_side_new_1107505", "1107505154", "story_v_side_new_1107505.awb")
				end

				arg_615_1:RecordContent(arg_615_1.text_.text)
			end

			local var_618_12 = math.max(var_618_3, arg_615_1.talkMaxDuration)

			if var_618_2 <= arg_615_1.time_ and arg_615_1.time_ < var_618_2 + var_618_12 then
				arg_615_1.typewritter.percent = (arg_615_1.time_ - var_618_2) / var_618_12

				arg_615_1.typewritter:SetDirty()
			end

			if arg_615_1.time_ >= var_618_2 + var_618_12 and arg_615_1.time_ < var_618_2 + var_618_12 + arg_618_0 then
				arg_615_1.typewritter.percent = 1

				arg_615_1.typewritter:SetDirty()
				arg_615_1:ShowNextGo(true)
			end
		end

		arg_615_1.nodeConfigList_ = {}

		arg_615_1:InitPlayNodeList()
	end,
	Play1107505155 = function(arg_619_0, arg_619_1)
		arg_619_1.time_ = 0
		arg_619_1.frameCnt_ = 0
		arg_619_1.state_ = "playing"
		arg_619_1.curTalkId_ = 1107505155
		arg_619_1.duration_ = 5

		SetActive(arg_619_1.tipsGo_, false)

		function arg_619_1.onSingleLineFinish_()
			arg_619_1.onSingleLineUpdate_ = nil
			arg_619_1.onSingleLineFinish_ = nil
			arg_619_1.state_ = "waiting"
		end

		function arg_619_1.playNext_(arg_621_0)
			if arg_621_0 == 1 then
				arg_619_0:Play1107505156(arg_619_1)
			end
		end

		function arg_619_1.onSingleLineUpdate_(arg_622_0)
			local var_622_0 = arg_619_1.actors_["1075ui_actor"]
			local var_622_1 = 0

			if var_622_1 < arg_619_1.time_ and arg_619_1.time_ <= var_622_1 + arg_622_0 and not isNil(var_622_0) and arg_619_1.var_.characterEffect1075ui_actor == nil then
				arg_619_1.var_.characterEffect1075ui_actor = var_622_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_622_2 = 0.200000002980232

			if var_622_1 <= arg_619_1.time_ and arg_619_1.time_ < var_622_1 + var_622_2 and not isNil(var_622_0) then
				local var_622_3 = (arg_619_1.time_ - var_622_1) / var_622_2

				if arg_619_1.var_.characterEffect1075ui_actor and not isNil(var_622_0) then
					local var_622_4 = Mathf.Lerp(0, 0.5, var_622_3)

					arg_619_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_619_1.var_.characterEffect1075ui_actor.fillRatio = var_622_4
				end
			end

			if arg_619_1.time_ >= var_622_1 + var_622_2 and arg_619_1.time_ < var_622_1 + var_622_2 + arg_622_0 and not isNil(var_622_0) and arg_619_1.var_.characterEffect1075ui_actor then
				local var_622_5 = 0.5

				arg_619_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_619_1.var_.characterEffect1075ui_actor.fillRatio = var_622_5
			end

			local var_622_6 = 0
			local var_622_7 = 0.1

			if var_622_6 < arg_619_1.time_ and arg_619_1.time_ <= var_622_6 + arg_622_0 then
				arg_619_1.talkMaxDuration = 0
				arg_619_1.dialogCg_.alpha = 1

				arg_619_1.dialog_:SetActive(true)
				SetActive(arg_619_1.leftNameGo_, true)

				local var_622_8 = arg_619_1:FormatText(StoryNameCfg[7].name)

				arg_619_1.leftNameTxt_.text = var_622_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_619_1.leftNameTxt_.transform)

				arg_619_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_619_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_619_1:RecordName(arg_619_1.leftNameTxt_.text)
				SetActive(arg_619_1.iconTrs_.gameObject, true)
				arg_619_1.iconController_:SetSelectedState("hero")

				arg_619_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_619_1.callingController_:SetSelectedState("normal")

				arg_619_1.keyicon_.color = Color.New(1, 1, 1)
				arg_619_1.icon_.color = Color.New(1, 1, 1)

				local var_622_9 = arg_619_1:GetWordFromCfg(1107505155)
				local var_622_10 = arg_619_1:FormatText(var_622_9.content)

				arg_619_1.text_.text = var_622_10

				LuaForUtil.ClearLinePrefixSymbol(arg_619_1.text_)

				local var_622_11 = 4
				local var_622_12 = utf8.len(var_622_10)
				local var_622_13 = var_622_11 <= 0 and var_622_7 or var_622_7 * (var_622_12 / var_622_11)

				if var_622_13 > 0 and var_622_7 < var_622_13 then
					arg_619_1.talkMaxDuration = var_622_13

					if var_622_13 + var_622_6 > arg_619_1.duration_ then
						arg_619_1.duration_ = var_622_13 + var_622_6
					end
				end

				arg_619_1.text_.text = var_622_10
				arg_619_1.typewritter.percent = 0

				arg_619_1.typewritter:SetDirty()
				arg_619_1:ShowNextGo(false)
				arg_619_1:RecordContent(arg_619_1.text_.text)
			end

			local var_622_14 = math.max(var_622_7, arg_619_1.talkMaxDuration)

			if var_622_6 <= arg_619_1.time_ and arg_619_1.time_ < var_622_6 + var_622_14 then
				arg_619_1.typewritter.percent = (arg_619_1.time_ - var_622_6) / var_622_14

				arg_619_1.typewritter:SetDirty()
			end

			if arg_619_1.time_ >= var_622_6 + var_622_14 and arg_619_1.time_ < var_622_6 + var_622_14 + arg_622_0 then
				arg_619_1.typewritter.percent = 1

				arg_619_1.typewritter:SetDirty()
				arg_619_1:ShowNextGo(true)
			end
		end

		arg_619_1.nodeConfigList_ = {}

		arg_619_1:InitPlayNodeList()
	end,
	Play1107505156 = function(arg_623_0, arg_623_1)
		arg_623_1.time_ = 0
		arg_623_1.frameCnt_ = 0
		arg_623_1.state_ = "playing"
		arg_623_1.curTalkId_ = 1107505156
		arg_623_1.duration_ = 5

		SetActive(arg_623_1.tipsGo_, false)

		function arg_623_1.onSingleLineFinish_()
			arg_623_1.onSingleLineUpdate_ = nil
			arg_623_1.onSingleLineFinish_ = nil
			arg_623_1.state_ = "waiting"
		end

		function arg_623_1.playNext_(arg_625_0)
			if arg_625_0 == 1 then
				arg_623_0:Play1107505157(arg_623_1)
			end
		end

		function arg_623_1.onSingleLineUpdate_(arg_626_0)
			local var_626_0 = arg_623_1.actors_["1075ui_actor"].transform
			local var_626_1 = 0

			if var_626_1 < arg_623_1.time_ and arg_623_1.time_ <= var_626_1 + arg_626_0 then
				arg_623_1.var_.moveOldPos1075ui_actor = var_626_0.localPosition

				local var_626_2 = GameObjectTools.GetOrAddComponent(var_626_0.gameObject, typeof(DynamicBoneHelper))

				if var_626_2 then
					var_626_2:EnableDynamicBone(false)
				end
			end

			local var_626_3 = 0.001

			if var_626_1 <= arg_623_1.time_ and arg_623_1.time_ < var_626_1 + var_626_3 then
				local var_626_4 = (arg_623_1.time_ - var_626_1) / var_626_3
				local var_626_5 = Vector3.New(0, 100, 0)

				var_626_0.localPosition = Vector3.Lerp(arg_623_1.var_.moveOldPos1075ui_actor, var_626_5, var_626_4)

				local var_626_6 = manager.ui.mainCamera.transform.position - var_626_0.position

				var_626_0.forward = Vector3.New(var_626_6.x, var_626_6.y, var_626_6.z)

				local var_626_7 = var_626_0.localEulerAngles

				var_626_7.z = 0
				var_626_7.x = 0
				var_626_0.localEulerAngles = var_626_7
			end

			if arg_623_1.time_ >= var_626_1 + var_626_3 and arg_623_1.time_ < var_626_1 + var_626_3 + arg_626_0 then
				var_626_0.localPosition = Vector3.New(0, 100, 0)

				local var_626_8 = manager.ui.mainCamera.transform.position - var_626_0.position

				var_626_0.forward = Vector3.New(var_626_8.x, var_626_8.y, var_626_8.z)

				local var_626_9 = var_626_0.localEulerAngles

				var_626_9.z = 0
				var_626_9.x = 0
				var_626_0.localEulerAngles = var_626_9

				local var_626_10 = GameObjectTools.GetOrAddComponent(var_626_0.gameObject, typeof(DynamicBoneHelper))

				if var_626_10 then
					var_626_10:EnableDynamicBone(true)
				end
			end

			local var_626_11 = 0
			local var_626_12 = 0.525

			if var_626_11 < arg_623_1.time_ and arg_623_1.time_ <= var_626_11 + arg_626_0 then
				arg_623_1.talkMaxDuration = 0
				arg_623_1.dialogCg_.alpha = 1

				arg_623_1.dialog_:SetActive(true)
				SetActive(arg_623_1.leftNameGo_, false)

				arg_623_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_623_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_623_1:RecordName(arg_623_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_623_1.iconTrs_.gameObject, false)
				arg_623_1.callingController_:SetSelectedState("normal")

				local var_626_13 = arg_623_1:GetWordFromCfg(1107505156)
				local var_626_14 = arg_623_1:FormatText(var_626_13.content)

				arg_623_1.text_.text = var_626_14

				LuaForUtil.ClearLinePrefixSymbol(arg_623_1.text_)

				local var_626_15 = 21
				local var_626_16 = utf8.len(var_626_14)
				local var_626_17 = var_626_15 <= 0 and var_626_12 or var_626_12 * (var_626_16 / var_626_15)

				if var_626_17 > 0 and var_626_12 < var_626_17 then
					arg_623_1.talkMaxDuration = var_626_17

					if var_626_17 + var_626_11 > arg_623_1.duration_ then
						arg_623_1.duration_ = var_626_17 + var_626_11
					end
				end

				arg_623_1.text_.text = var_626_14
				arg_623_1.typewritter.percent = 0

				arg_623_1.typewritter:SetDirty()
				arg_623_1:ShowNextGo(false)
				arg_623_1:RecordContent(arg_623_1.text_.text)
			end

			local var_626_18 = math.max(var_626_12, arg_623_1.talkMaxDuration)

			if var_626_11 <= arg_623_1.time_ and arg_623_1.time_ < var_626_11 + var_626_18 then
				arg_623_1.typewritter.percent = (arg_623_1.time_ - var_626_11) / var_626_18

				arg_623_1.typewritter:SetDirty()
			end

			if arg_623_1.time_ >= var_626_11 + var_626_18 and arg_623_1.time_ < var_626_11 + var_626_18 + arg_626_0 then
				arg_623_1.typewritter.percent = 1

				arg_623_1.typewritter:SetDirty()
				arg_623_1:ShowNextGo(true)
			end
		end

		arg_623_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_actor",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_623_1:InitPlayNodeList()
	end,
	Play1107505157 = function(arg_627_0, arg_627_1)
		arg_627_1.time_ = 0
		arg_627_1.frameCnt_ = 0
		arg_627_1.state_ = "playing"
		arg_627_1.curTalkId_ = 1107505157
		arg_627_1.duration_ = 12.13

		SetActive(arg_627_1.tipsGo_, false)

		function arg_627_1.onSingleLineFinish_()
			arg_627_1.onSingleLineUpdate_ = nil
			arg_627_1.onSingleLineFinish_ = nil
			arg_627_1.state_ = "waiting"
		end

		function arg_627_1.playNext_(arg_629_0)
			if arg_629_0 == 1 then
				arg_627_0:Play1107505158(arg_627_1)
			end
		end

		function arg_627_1.onSingleLineUpdate_(arg_630_0)
			local var_630_0 = arg_627_1.actors_["1075ui_actor"].transform
			local var_630_1 = 0

			if var_630_1 < arg_627_1.time_ and arg_627_1.time_ <= var_630_1 + arg_630_0 then
				arg_627_1.var_.moveOldPos1075ui_actor = var_630_0.localPosition

				local var_630_2 = GameObjectTools.GetOrAddComponent(var_630_0.gameObject, typeof(DynamicBoneHelper))

				if var_630_2 then
					var_630_2:EnableDynamicBone(false)
				end
			end

			local var_630_3 = 0.001

			if var_630_1 <= arg_627_1.time_ and arg_627_1.time_ < var_630_1 + var_630_3 then
				local var_630_4 = (arg_627_1.time_ - var_630_1) / var_630_3
				local var_630_5 = Vector3.New(0, -1.055, -6.16)

				var_630_0.localPosition = Vector3.Lerp(arg_627_1.var_.moveOldPos1075ui_actor, var_630_5, var_630_4)

				local var_630_6 = manager.ui.mainCamera.transform.position - var_630_0.position

				var_630_0.forward = Vector3.New(var_630_6.x, var_630_6.y, var_630_6.z)

				local var_630_7 = var_630_0.localEulerAngles

				var_630_7.z = 0
				var_630_7.x = 0
				var_630_0.localEulerAngles = var_630_7
			end

			if arg_627_1.time_ >= var_630_1 + var_630_3 and arg_627_1.time_ < var_630_1 + var_630_3 + arg_630_0 then
				var_630_0.localPosition = Vector3.New(0, -1.055, -6.16)

				local var_630_8 = manager.ui.mainCamera.transform.position - var_630_0.position

				var_630_0.forward = Vector3.New(var_630_8.x, var_630_8.y, var_630_8.z)

				local var_630_9 = var_630_0.localEulerAngles

				var_630_9.z = 0
				var_630_9.x = 0
				var_630_0.localEulerAngles = var_630_9

				local var_630_10 = GameObjectTools.GetOrAddComponent(var_630_0.gameObject, typeof(DynamicBoneHelper))

				if var_630_10 then
					var_630_10:EnableDynamicBone(true)
				end
			end

			local var_630_11 = arg_627_1.actors_["1075ui_actor"]
			local var_630_12 = 0

			if var_630_12 < arg_627_1.time_ and arg_627_1.time_ <= var_630_12 + arg_630_0 and not isNil(var_630_11) and arg_627_1.var_.characterEffect1075ui_actor == nil then
				arg_627_1.var_.characterEffect1075ui_actor = var_630_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_630_13 = 0.200000002980232

			if var_630_12 <= arg_627_1.time_ and arg_627_1.time_ < var_630_12 + var_630_13 and not isNil(var_630_11) then
				local var_630_14 = (arg_627_1.time_ - var_630_12) / var_630_13

				if arg_627_1.var_.characterEffect1075ui_actor and not isNil(var_630_11) then
					arg_627_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_627_1.time_ >= var_630_12 + var_630_13 and arg_627_1.time_ < var_630_12 + var_630_13 + arg_630_0 and not isNil(var_630_11) and arg_627_1.var_.characterEffect1075ui_actor then
				arg_627_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			local var_630_15 = 0

			if var_630_15 < arg_627_1.time_ and arg_627_1.time_ <= var_630_15 + arg_630_0 then
				arg_627_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075action/1075action5_2")
			end

			local var_630_16 = 0

			if var_630_16 < arg_627_1.time_ and arg_627_1.time_ <= var_630_16 + arg_630_0 then
				arg_627_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_nanguoC", "EmotionTimelineAnimator")
			end

			local var_630_17 = 0
			local var_630_18 = 1.05

			if var_630_17 < arg_627_1.time_ and arg_627_1.time_ <= var_630_17 + arg_630_0 then
				arg_627_1.talkMaxDuration = 0
				arg_627_1.dialogCg_.alpha = 1

				arg_627_1.dialog_:SetActive(true)
				SetActive(arg_627_1.leftNameGo_, true)

				local var_630_19 = arg_627_1:FormatText(StoryNameCfg[381].name)

				arg_627_1.leftNameTxt_.text = var_630_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_627_1.leftNameTxt_.transform)

				arg_627_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_627_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_627_1:RecordName(arg_627_1.leftNameTxt_.text)
				SetActive(arg_627_1.iconTrs_.gameObject, false)
				arg_627_1.callingController_:SetSelectedState("normal")

				local var_630_20 = arg_627_1:GetWordFromCfg(1107505157)
				local var_630_21 = arg_627_1:FormatText(var_630_20.content)

				arg_627_1.text_.text = var_630_21

				LuaForUtil.ClearLinePrefixSymbol(arg_627_1.text_)

				local var_630_22 = 42
				local var_630_23 = utf8.len(var_630_21)
				local var_630_24 = var_630_22 <= 0 and var_630_18 or var_630_18 * (var_630_23 / var_630_22)

				if var_630_24 > 0 and var_630_18 < var_630_24 then
					arg_627_1.talkMaxDuration = var_630_24

					if var_630_24 + var_630_17 > arg_627_1.duration_ then
						arg_627_1.duration_ = var_630_24 + var_630_17
					end
				end

				arg_627_1.text_.text = var_630_21
				arg_627_1.typewritter.percent = 0

				arg_627_1.typewritter:SetDirty()
				arg_627_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107505", "1107505157", "story_v_side_new_1107505.awb") ~= 0 then
					local var_630_25 = manager.audio:GetVoiceLength("story_v_side_new_1107505", "1107505157", "story_v_side_new_1107505.awb") / 1000

					if var_630_25 + var_630_17 > arg_627_1.duration_ then
						arg_627_1.duration_ = var_630_25 + var_630_17
					end

					if var_630_20.prefab_name ~= "" and arg_627_1.actors_[var_630_20.prefab_name] ~= nil then
						local var_630_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_627_1.actors_[var_630_20.prefab_name].transform, "story_v_side_new_1107505", "1107505157", "story_v_side_new_1107505.awb")

						arg_627_1:RecordAudio("1107505157", var_630_26)
						arg_627_1:RecordAudio("1107505157", var_630_26)
					else
						arg_627_1:AudioAction("play", "voice", "story_v_side_new_1107505", "1107505157", "story_v_side_new_1107505.awb")
					end

					arg_627_1:RecordHistoryTalkVoice("story_v_side_new_1107505", "1107505157", "story_v_side_new_1107505.awb")
				end

				arg_627_1:RecordContent(arg_627_1.text_.text)
			end

			local var_630_27 = math.max(var_630_18, arg_627_1.talkMaxDuration)

			if var_630_17 <= arg_627_1.time_ and arg_627_1.time_ < var_630_17 + var_630_27 then
				arg_627_1.typewritter.percent = (arg_627_1.time_ - var_630_17) / var_630_27

				arg_627_1.typewritter:SetDirty()
			end

			if arg_627_1.time_ >= var_630_17 + var_630_27 and arg_627_1.time_ < var_630_17 + var_630_27 + arg_630_0 then
				arg_627_1.typewritter.percent = 1

				arg_627_1.typewritter:SetDirty()
				arg_627_1:ShowNextGo(true)
			end
		end

		arg_627_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_actor",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_627_1:InitPlayNodeList()
	end,
	Play1107505158 = function(arg_631_0, arg_631_1)
		arg_631_1.time_ = 0
		arg_631_1.frameCnt_ = 0
		arg_631_1.state_ = "playing"
		arg_631_1.curTalkId_ = 1107505158
		arg_631_1.duration_ = 9

		SetActive(arg_631_1.tipsGo_, false)

		function arg_631_1.onSingleLineFinish_()
			arg_631_1.onSingleLineUpdate_ = nil
			arg_631_1.onSingleLineFinish_ = nil
			arg_631_1.state_ = "waiting"
		end

		function arg_631_1.playNext_(arg_633_0)
			if arg_633_0 == 1 then
				arg_631_0:Play1107505159(arg_631_1)
			end
		end

		function arg_631_1.onSingleLineUpdate_(arg_634_0)
			local var_634_0 = 2

			if var_634_0 < arg_631_1.time_ and arg_631_1.time_ <= var_634_0 + arg_634_0 then
				local var_634_1 = manager.ui.mainCamera.transform.localPosition
				local var_634_2 = Vector3.New(0, 0, 10) + Vector3.New(var_634_1.x, var_634_1.y, 0)
				local var_634_3 = arg_631_1.bgs_.ST37a

				var_634_3.transform.localPosition = var_634_2
				var_634_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_634_4 = var_634_3:GetComponent("SpriteRenderer")

				if var_634_4 and var_634_4.sprite then
					local var_634_5 = (var_634_3.transform.localPosition - var_634_1).z
					local var_634_6 = manager.ui.mainCameraCom_
					local var_634_7 = 2 * var_634_5 * Mathf.Tan(var_634_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_634_8 = var_634_7 * var_634_6.aspect
					local var_634_9 = var_634_4.sprite.bounds.size.x
					local var_634_10 = var_634_4.sprite.bounds.size.y
					local var_634_11 = var_634_8 / var_634_9
					local var_634_12 = var_634_7 / var_634_10
					local var_634_13 = var_634_12 < var_634_11 and var_634_11 or var_634_12

					var_634_3.transform.localScale = Vector3.New(var_634_13, var_634_13, 0)
				end

				for iter_634_0, iter_634_1 in pairs(arg_631_1.bgs_) do
					if iter_634_0 ~= "ST37a" then
						iter_634_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_634_14 = 3.999999999999

			if var_634_14 < arg_631_1.time_ and arg_631_1.time_ <= var_634_14 + arg_634_0 then
				arg_631_1.allBtn_.enabled = false
			end

			local var_634_15 = 0.3

			if arg_631_1.time_ >= var_634_14 + var_634_15 and arg_631_1.time_ < var_634_14 + var_634_15 + arg_634_0 then
				arg_631_1.allBtn_.enabled = true
			end

			local var_634_16 = 0

			if var_634_16 < arg_631_1.time_ and arg_631_1.time_ <= var_634_16 + arg_634_0 then
				arg_631_1.mask_.enabled = true
				arg_631_1.mask_.raycastTarget = true

				arg_631_1:SetGaussion(false)
			end

			local var_634_17 = 2

			if var_634_16 <= arg_631_1.time_ and arg_631_1.time_ < var_634_16 + var_634_17 then
				local var_634_18 = (arg_631_1.time_ - var_634_16) / var_634_17
				local var_634_19 = Color.New(0, 0, 0)

				var_634_19.a = Mathf.Lerp(0, 1, var_634_18)
				arg_631_1.mask_.color = var_634_19
			end

			if arg_631_1.time_ >= var_634_16 + var_634_17 and arg_631_1.time_ < var_634_16 + var_634_17 + arg_634_0 then
				local var_634_20 = Color.New(0, 0, 0)

				var_634_20.a = 1
				arg_631_1.mask_.color = var_634_20
			end

			local var_634_21 = 2

			if var_634_21 < arg_631_1.time_ and arg_631_1.time_ <= var_634_21 + arg_634_0 then
				arg_631_1.mask_.enabled = true
				arg_631_1.mask_.raycastTarget = true

				arg_631_1:SetGaussion(false)
			end

			local var_634_22 = 2

			if var_634_21 <= arg_631_1.time_ and arg_631_1.time_ < var_634_21 + var_634_22 then
				local var_634_23 = (arg_631_1.time_ - var_634_21) / var_634_22
				local var_634_24 = Color.New(0, 0, 0)

				var_634_24.a = Mathf.Lerp(1, 0, var_634_23)
				arg_631_1.mask_.color = var_634_24
			end

			if arg_631_1.time_ >= var_634_21 + var_634_22 and arg_631_1.time_ < var_634_21 + var_634_22 + arg_634_0 then
				local var_634_25 = Color.New(0, 0, 0)
				local var_634_26 = 0

				arg_631_1.mask_.enabled = false
				var_634_25.a = var_634_26
				arg_631_1.mask_.color = var_634_25
			end

			local var_634_27 = arg_631_1.actors_["1075ui_actor"].transform
			local var_634_28 = 1.96599999815226

			if var_634_28 < arg_631_1.time_ and arg_631_1.time_ <= var_634_28 + arg_634_0 then
				arg_631_1.var_.moveOldPos1075ui_actor = var_634_27.localPosition

				local var_634_29 = GameObjectTools.GetOrAddComponent(var_634_27.gameObject, typeof(DynamicBoneHelper))

				if var_634_29 then
					var_634_29:EnableDynamicBone(false)
				end
			end

			local var_634_30 = 0.001

			if var_634_28 <= arg_631_1.time_ and arg_631_1.time_ < var_634_28 + var_634_30 then
				local var_634_31 = (arg_631_1.time_ - var_634_28) / var_634_30
				local var_634_32 = Vector3.New(0, 100, 0)

				var_634_27.localPosition = Vector3.Lerp(arg_631_1.var_.moveOldPos1075ui_actor, var_634_32, var_634_31)

				local var_634_33 = manager.ui.mainCamera.transform.position - var_634_27.position

				var_634_27.forward = Vector3.New(var_634_33.x, var_634_33.y, var_634_33.z)

				local var_634_34 = var_634_27.localEulerAngles

				var_634_34.z = 0
				var_634_34.x = 0
				var_634_27.localEulerAngles = var_634_34
			end

			if arg_631_1.time_ >= var_634_28 + var_634_30 and arg_631_1.time_ < var_634_28 + var_634_30 + arg_634_0 then
				var_634_27.localPosition = Vector3.New(0, 100, 0)

				local var_634_35 = manager.ui.mainCamera.transform.position - var_634_27.position

				var_634_27.forward = Vector3.New(var_634_35.x, var_634_35.y, var_634_35.z)

				local var_634_36 = var_634_27.localEulerAngles

				var_634_36.z = 0
				var_634_36.x = 0
				var_634_27.localEulerAngles = var_634_36

				local var_634_37 = GameObjectTools.GetOrAddComponent(var_634_27.gameObject, typeof(DynamicBoneHelper))

				if var_634_37 then
					var_634_37:EnableDynamicBone(true)
				end
			end

			local var_634_38 = arg_631_1.actors_["1075ui_actor"]
			local var_634_39 = 1.96599999815226

			if var_634_39 < arg_631_1.time_ and arg_631_1.time_ <= var_634_39 + arg_634_0 and not isNil(var_634_38) and arg_631_1.var_.characterEffect1075ui_actor == nil then
				arg_631_1.var_.characterEffect1075ui_actor = var_634_38:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_634_40 = 0.034000001847744

			if var_634_39 <= arg_631_1.time_ and arg_631_1.time_ < var_634_39 + var_634_40 and not isNil(var_634_38) then
				local var_634_41 = (arg_631_1.time_ - var_634_39) / var_634_40

				if arg_631_1.var_.characterEffect1075ui_actor and not isNil(var_634_38) then
					local var_634_42 = Mathf.Lerp(0, 0.5, var_634_41)

					arg_631_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_631_1.var_.characterEffect1075ui_actor.fillRatio = var_634_42
				end
			end

			if arg_631_1.time_ >= var_634_39 + var_634_40 and arg_631_1.time_ < var_634_39 + var_634_40 + arg_634_0 and not isNil(var_634_38) and arg_631_1.var_.characterEffect1075ui_actor then
				local var_634_43 = 0.5

				arg_631_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_631_1.var_.characterEffect1075ui_actor.fillRatio = var_634_43
			end

			if arg_631_1.frameCnt_ <= 1 then
				arg_631_1.dialog_:SetActive(false)
			end

			local var_634_44 = 4
			local var_634_45 = 0.85

			if var_634_44 < arg_631_1.time_ and arg_631_1.time_ <= var_634_44 + arg_634_0 then
				arg_631_1.talkMaxDuration = 0

				arg_631_1.dialog_:SetActive(true)

				arg_631_1.dialogCg_.alpha = 0

				local var_634_46 = LeanTween.value(arg_631_1.dialog_, 0, 1, 0.3)

				var_634_46:setOnUpdate(LuaHelper.FloatAction(function(arg_635_0)
					arg_631_1.dialogCg_.alpha = arg_635_0
				end))
				var_634_46:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_631_1.dialog_)
					var_634_46:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_631_1.duration_ = arg_631_1.duration_ + 0.3

				SetActive(arg_631_1.leftNameGo_, false)

				arg_631_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_631_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_631_1:RecordName(arg_631_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_631_1.iconTrs_.gameObject, false)
				arg_631_1.callingController_:SetSelectedState("normal")

				local var_634_47 = arg_631_1:GetWordFromCfg(1107505158)
				local var_634_48 = arg_631_1:FormatText(var_634_47.content)

				arg_631_1.text_.text = var_634_48

				LuaForUtil.ClearLinePrefixSymbol(arg_631_1.text_)

				local var_634_49 = 34
				local var_634_50 = utf8.len(var_634_48)
				local var_634_51 = var_634_49 <= 0 and var_634_45 or var_634_45 * (var_634_50 / var_634_49)

				if var_634_51 > 0 and var_634_45 < var_634_51 then
					arg_631_1.talkMaxDuration = var_634_51
					var_634_44 = var_634_44 + 0.3

					if var_634_51 + var_634_44 > arg_631_1.duration_ then
						arg_631_1.duration_ = var_634_51 + var_634_44
					end
				end

				arg_631_1.text_.text = var_634_48
				arg_631_1.typewritter.percent = 0

				arg_631_1.typewritter:SetDirty()
				arg_631_1:ShowNextGo(false)
				arg_631_1:RecordContent(arg_631_1.text_.text)
			end

			local var_634_52 = var_634_44 + 0.3
			local var_634_53 = math.max(var_634_45, arg_631_1.talkMaxDuration)

			if var_634_52 <= arg_631_1.time_ and arg_631_1.time_ < var_634_52 + var_634_53 then
				arg_631_1.typewritter.percent = (arg_631_1.time_ - var_634_52) / var_634_53

				arg_631_1.typewritter:SetDirty()
			end

			if arg_631_1.time_ >= var_634_52 + var_634_53 and arg_631_1.time_ < var_634_52 + var_634_53 + arg_634_0 then
				arg_631_1.typewritter.percent = 1

				arg_631_1.typewritter:SetDirty()
				arg_631_1:ShowNextGo(true)
			end
		end

		arg_631_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_actor",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_631_1:InitPlayNodeList()
	end,
	Play1107505159 = function(arg_637_0, arg_637_1)
		arg_637_1.time_ = 0
		arg_637_1.frameCnt_ = 0
		arg_637_1.state_ = "playing"
		arg_637_1.curTalkId_ = 1107505159
		arg_637_1.duration_ = 5

		SetActive(arg_637_1.tipsGo_, false)

		function arg_637_1.onSingleLineFinish_()
			arg_637_1.onSingleLineUpdate_ = nil
			arg_637_1.onSingleLineFinish_ = nil
			arg_637_1.state_ = "waiting"
		end

		function arg_637_1.playNext_(arg_639_0)
			if arg_639_0 == 1 then
				arg_637_0:Play1107505160(arg_637_1)
			end
		end

		function arg_637_1.onSingleLineUpdate_(arg_640_0)
			local var_640_0 = 0
			local var_640_1 = 0.625

			if var_640_0 < arg_637_1.time_ and arg_637_1.time_ <= var_640_0 + arg_640_0 then
				arg_637_1.talkMaxDuration = 0
				arg_637_1.dialogCg_.alpha = 1

				arg_637_1.dialog_:SetActive(true)
				SetActive(arg_637_1.leftNameGo_, true)

				local var_640_2 = arg_637_1:FormatText(StoryNameCfg[7].name)

				arg_637_1.leftNameTxt_.text = var_640_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_637_1.leftNameTxt_.transform)

				arg_637_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_637_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_637_1:RecordName(arg_637_1.leftNameTxt_.text)
				SetActive(arg_637_1.iconTrs_.gameObject, true)
				arg_637_1.iconController_:SetSelectedState("hero")

				arg_637_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_637_1.callingController_:SetSelectedState("normal")

				arg_637_1.keyicon_.color = Color.New(1, 1, 1)
				arg_637_1.icon_.color = Color.New(1, 1, 1)

				local var_640_3 = arg_637_1:GetWordFromCfg(1107505159)
				local var_640_4 = arg_637_1:FormatText(var_640_3.content)

				arg_637_1.text_.text = var_640_4

				LuaForUtil.ClearLinePrefixSymbol(arg_637_1.text_)

				local var_640_5 = 25
				local var_640_6 = utf8.len(var_640_4)
				local var_640_7 = var_640_5 <= 0 and var_640_1 or var_640_1 * (var_640_6 / var_640_5)

				if var_640_7 > 0 and var_640_1 < var_640_7 then
					arg_637_1.talkMaxDuration = var_640_7

					if var_640_7 + var_640_0 > arg_637_1.duration_ then
						arg_637_1.duration_ = var_640_7 + var_640_0
					end
				end

				arg_637_1.text_.text = var_640_4
				arg_637_1.typewritter.percent = 0

				arg_637_1.typewritter:SetDirty()
				arg_637_1:ShowNextGo(false)
				arg_637_1:RecordContent(arg_637_1.text_.text)
			end

			local var_640_8 = math.max(var_640_1, arg_637_1.talkMaxDuration)

			if var_640_0 <= arg_637_1.time_ and arg_637_1.time_ < var_640_0 + var_640_8 then
				arg_637_1.typewritter.percent = (arg_637_1.time_ - var_640_0) / var_640_8

				arg_637_1.typewritter:SetDirty()
			end

			if arg_637_1.time_ >= var_640_0 + var_640_8 and arg_637_1.time_ < var_640_0 + var_640_8 + arg_640_0 then
				arg_637_1.typewritter.percent = 1

				arg_637_1.typewritter:SetDirty()
				arg_637_1:ShowNextGo(true)
			end
		end

		arg_637_1.nodeConfigList_ = {}

		arg_637_1:InitPlayNodeList()
	end,
	Play1107505160 = function(arg_641_0, arg_641_1)
		arg_641_1.time_ = 0
		arg_641_1.frameCnt_ = 0
		arg_641_1.state_ = "playing"
		arg_641_1.curTalkId_ = 1107505160
		arg_641_1.duration_ = 5

		SetActive(arg_641_1.tipsGo_, false)

		function arg_641_1.onSingleLineFinish_()
			arg_641_1.onSingleLineUpdate_ = nil
			arg_641_1.onSingleLineFinish_ = nil
			arg_641_1.state_ = "waiting"
		end

		function arg_641_1.playNext_(arg_643_0)
			if arg_643_0 == 1 then
				arg_641_0:Play1107505161(arg_641_1)
			end
		end

		function arg_641_1.onSingleLineUpdate_(arg_644_0)
			local var_644_0 = 0
			local var_644_1 = 0.8

			if var_644_0 < arg_641_1.time_ and arg_641_1.time_ <= var_644_0 + arg_644_0 then
				arg_641_1.talkMaxDuration = 0
				arg_641_1.dialogCg_.alpha = 1

				arg_641_1.dialog_:SetActive(true)
				SetActive(arg_641_1.leftNameGo_, false)

				arg_641_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_641_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_641_1:RecordName(arg_641_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_641_1.iconTrs_.gameObject, false)
				arg_641_1.callingController_:SetSelectedState("normal")

				local var_644_2 = arg_641_1:GetWordFromCfg(1107505160)
				local var_644_3 = arg_641_1:FormatText(var_644_2.content)

				arg_641_1.text_.text = var_644_3

				LuaForUtil.ClearLinePrefixSymbol(arg_641_1.text_)

				local var_644_4 = 32
				local var_644_5 = utf8.len(var_644_3)
				local var_644_6 = var_644_4 <= 0 and var_644_1 or var_644_1 * (var_644_5 / var_644_4)

				if var_644_6 > 0 and var_644_1 < var_644_6 then
					arg_641_1.talkMaxDuration = var_644_6

					if var_644_6 + var_644_0 > arg_641_1.duration_ then
						arg_641_1.duration_ = var_644_6 + var_644_0
					end
				end

				arg_641_1.text_.text = var_644_3
				arg_641_1.typewritter.percent = 0

				arg_641_1.typewritter:SetDirty()
				arg_641_1:ShowNextGo(false)
				arg_641_1:RecordContent(arg_641_1.text_.text)
			end

			local var_644_7 = math.max(var_644_1, arg_641_1.talkMaxDuration)

			if var_644_0 <= arg_641_1.time_ and arg_641_1.time_ < var_644_0 + var_644_7 then
				arg_641_1.typewritter.percent = (arg_641_1.time_ - var_644_0) / var_644_7

				arg_641_1.typewritter:SetDirty()
			end

			if arg_641_1.time_ >= var_644_0 + var_644_7 and arg_641_1.time_ < var_644_0 + var_644_7 + arg_644_0 then
				arg_641_1.typewritter.percent = 1

				arg_641_1.typewritter:SetDirty()
				arg_641_1:ShowNextGo(true)
			end
		end

		arg_641_1.nodeConfigList_ = {}

		arg_641_1:InitPlayNodeList()
	end,
	Play1107505161 = function(arg_645_0, arg_645_1)
		arg_645_1.time_ = 0
		arg_645_1.frameCnt_ = 0
		arg_645_1.state_ = "playing"
		arg_645_1.curTalkId_ = 1107505161
		arg_645_1.duration_ = 5

		SetActive(arg_645_1.tipsGo_, false)

		function arg_645_1.onSingleLineFinish_()
			arg_645_1.onSingleLineUpdate_ = nil
			arg_645_1.onSingleLineFinish_ = nil
			arg_645_1.state_ = "waiting"
			arg_645_1.auto_ = false
		end

		function arg_645_1.playNext_(arg_647_0)
			arg_645_1.onStoryFinished_()
		end

		function arg_645_1.onSingleLineUpdate_(arg_648_0)
			local var_648_0 = 0
			local var_648_1 = 0.25

			if var_648_0 < arg_645_1.time_ and arg_645_1.time_ <= var_648_0 + arg_648_0 then
				arg_645_1.talkMaxDuration = 0
				arg_645_1.dialogCg_.alpha = 1

				arg_645_1.dialog_:SetActive(true)
				SetActive(arg_645_1.leftNameGo_, true)

				local var_648_2 = arg_645_1:FormatText(StoryNameCfg[7].name)

				arg_645_1.leftNameTxt_.text = var_648_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_645_1.leftNameTxt_.transform)

				arg_645_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_645_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_645_1:RecordName(arg_645_1.leftNameTxt_.text)
				SetActive(arg_645_1.iconTrs_.gameObject, true)
				arg_645_1.iconController_:SetSelectedState("hero")

				arg_645_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_645_1.callingController_:SetSelectedState("normal")

				arg_645_1.keyicon_.color = Color.New(1, 1, 1)
				arg_645_1.icon_.color = Color.New(1, 1, 1)

				local var_648_3 = arg_645_1:GetWordFromCfg(1107505161)
				local var_648_4 = arg_645_1:FormatText(var_648_3.content)

				arg_645_1.text_.text = var_648_4

				LuaForUtil.ClearLinePrefixSymbol(arg_645_1.text_)

				local var_648_5 = 10
				local var_648_6 = utf8.len(var_648_4)
				local var_648_7 = var_648_5 <= 0 and var_648_1 or var_648_1 * (var_648_6 / var_648_5)

				if var_648_7 > 0 and var_648_1 < var_648_7 then
					arg_645_1.talkMaxDuration = var_648_7

					if var_648_7 + var_648_0 > arg_645_1.duration_ then
						arg_645_1.duration_ = var_648_7 + var_648_0
					end
				end

				arg_645_1.text_.text = var_648_4
				arg_645_1.typewritter.percent = 0

				arg_645_1.typewritter:SetDirty()
				arg_645_1:ShowNextGo(false)
				arg_645_1:RecordContent(arg_645_1.text_.text)
			end

			local var_648_8 = math.max(var_648_1, arg_645_1.talkMaxDuration)

			if var_648_0 <= arg_645_1.time_ and arg_645_1.time_ < var_648_0 + var_648_8 then
				arg_645_1.typewritter.percent = (arg_645_1.time_ - var_648_0) / var_648_8

				arg_645_1.typewritter:SetDirty()
			end

			if arg_645_1.time_ >= var_648_0 + var_648_8 and arg_645_1.time_ < var_648_0 + var_648_8 + arg_648_0 then
				arg_645_1.typewritter.percent = 1

				arg_645_1.typewritter:SetDirty()
				arg_645_1:ShowNextGo(true)
			end
		end

		arg_645_1.nodeConfigList_ = {}

		arg_645_1:InitPlayNodeList()
	end,
	Play1107505078 = function(arg_649_0, arg_649_1)
		arg_649_1.time_ = 0
		arg_649_1.frameCnt_ = 0
		arg_649_1.state_ = "playing"
		arg_649_1.curTalkId_ = 1107505078
		arg_649_1.duration_ = 3.6

		SetActive(arg_649_1.tipsGo_, false)

		function arg_649_1.onSingleLineFinish_()
			arg_649_1.onSingleLineUpdate_ = nil
			arg_649_1.onSingleLineFinish_ = nil
			arg_649_1.state_ = "waiting"
		end

		function arg_649_1.playNext_(arg_651_0)
			if arg_651_0 == 1 then
				arg_649_0:Play1107505079(arg_649_1)
			end
		end

		function arg_649_1.onSingleLineUpdate_(arg_652_0)
			local var_652_0 = arg_649_1.actors_["1075ui_actor"]
			local var_652_1 = 0

			if var_652_1 < arg_649_1.time_ and arg_649_1.time_ <= var_652_1 + arg_652_0 and not isNil(var_652_0) and arg_649_1.var_.characterEffect1075ui_actor == nil then
				arg_649_1.var_.characterEffect1075ui_actor = var_652_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_652_2 = 0.200000002980232

			if var_652_1 <= arg_649_1.time_ and arg_649_1.time_ < var_652_1 + var_652_2 and not isNil(var_652_0) then
				local var_652_3 = (arg_649_1.time_ - var_652_1) / var_652_2

				if arg_649_1.var_.characterEffect1075ui_actor and not isNil(var_652_0) then
					arg_649_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_649_1.time_ >= var_652_1 + var_652_2 and arg_649_1.time_ < var_652_1 + var_652_2 + arg_652_0 and not isNil(var_652_0) and arg_649_1.var_.characterEffect1075ui_actor then
				arg_649_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			local var_652_4 = "1075ui_actor"

			if arg_649_1.actors_[var_652_4] == nil then
				local var_652_5 = Asset.Load("Char/" .. "1075ui_actor")

				if not isNil(var_652_5) then
					local var_652_6 = Object.Instantiate(Asset.Load("Char/" .. "1075ui_actor"), arg_649_1.stage_.transform)

					var_652_6.name = var_652_4
					var_652_6.transform.localPosition = Vector3.New(0, 100, 0)
					arg_649_1.actors_[var_652_4] = var_652_6

					local var_652_7 = var_652_6:GetComponentInChildren(typeof(CharacterEffect))

					var_652_7.enabled = true

					local var_652_8 = GameObjectTools.GetOrAddComponent(var_652_6, typeof(DynamicBoneHelper))

					if var_652_8 then
						var_652_8:EnableDynamicBone(false)
					end

					arg_649_1:ShowWeapon(var_652_7.transform, false)

					arg_649_1.var_[var_652_4 .. "Animator"] = var_652_7.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_649_1.var_[var_652_4 .. "Animator"].applyRootMotion = true
					arg_649_1.var_[var_652_4 .. "LipSync"] = var_652_7.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_652_9 = 0

			if var_652_9 < arg_649_1.time_ and arg_649_1.time_ <= var_652_9 + arg_652_0 then
				arg_649_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075actionlink/1075action443")
			end

			local var_652_10 = "1075ui_actor"

			if arg_649_1.actors_[var_652_10] == nil then
				local var_652_11 = Asset.Load("Char/" .. "1075ui_actor")

				if not isNil(var_652_11) then
					local var_652_12 = Object.Instantiate(Asset.Load("Char/" .. "1075ui_actor"), arg_649_1.stage_.transform)

					var_652_12.name = var_652_10
					var_652_12.transform.localPosition = Vector3.New(0, 100, 0)
					arg_649_1.actors_[var_652_10] = var_652_12

					local var_652_13 = var_652_12:GetComponentInChildren(typeof(CharacterEffect))

					var_652_13.enabled = true

					local var_652_14 = GameObjectTools.GetOrAddComponent(var_652_12, typeof(DynamicBoneHelper))

					if var_652_14 then
						var_652_14:EnableDynamicBone(false)
					end

					arg_649_1:ShowWeapon(var_652_13.transform, false)

					arg_649_1.var_[var_652_10 .. "Animator"] = var_652_13.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_649_1.var_[var_652_10 .. "Animator"].applyRootMotion = true
					arg_649_1.var_[var_652_10 .. "LipSync"] = var_652_13.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_652_15 = 0

			if var_652_15 < arg_649_1.time_ and arg_649_1.time_ <= var_652_15 + arg_652_0 then
				arg_649_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_652_16 = 0
			local var_652_17 = 0.375

			if var_652_16 < arg_649_1.time_ and arg_649_1.time_ <= var_652_16 + arg_652_0 then
				arg_649_1.talkMaxDuration = 0
				arg_649_1.dialogCg_.alpha = 1

				arg_649_1.dialog_:SetActive(true)
				SetActive(arg_649_1.leftNameGo_, true)

				local var_652_18 = arg_649_1:FormatText(StoryNameCfg[381].name)

				arg_649_1.leftNameTxt_.text = var_652_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_649_1.leftNameTxt_.transform)

				arg_649_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_649_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_649_1:RecordName(arg_649_1.leftNameTxt_.text)
				SetActive(arg_649_1.iconTrs_.gameObject, false)
				arg_649_1.callingController_:SetSelectedState("normal")

				local var_652_19 = arg_649_1:GetWordFromCfg(1107505078)
				local var_652_20 = arg_649_1:FormatText(var_652_19.content)

				arg_649_1.text_.text = var_652_20

				LuaForUtil.ClearLinePrefixSymbol(arg_649_1.text_)

				local var_652_21 = 15
				local var_652_22 = utf8.len(var_652_20)
				local var_652_23 = var_652_21 <= 0 and var_652_17 or var_652_17 * (var_652_22 / var_652_21)

				if var_652_23 > 0 and var_652_17 < var_652_23 then
					arg_649_1.talkMaxDuration = var_652_23

					if var_652_23 + var_652_16 > arg_649_1.duration_ then
						arg_649_1.duration_ = var_652_23 + var_652_16
					end
				end

				arg_649_1.text_.text = var_652_20
				arg_649_1.typewritter.percent = 0

				arg_649_1.typewritter:SetDirty()
				arg_649_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107505", "1107505078", "story_v_side_new_1107505.awb") ~= 0 then
					local var_652_24 = manager.audio:GetVoiceLength("story_v_side_new_1107505", "1107505078", "story_v_side_new_1107505.awb") / 1000

					if var_652_24 + var_652_16 > arg_649_1.duration_ then
						arg_649_1.duration_ = var_652_24 + var_652_16
					end

					if var_652_19.prefab_name ~= "" and arg_649_1.actors_[var_652_19.prefab_name] ~= nil then
						local var_652_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_649_1.actors_[var_652_19.prefab_name].transform, "story_v_side_new_1107505", "1107505078", "story_v_side_new_1107505.awb")

						arg_649_1:RecordAudio("1107505078", var_652_25)
						arg_649_1:RecordAudio("1107505078", var_652_25)
					else
						arg_649_1:AudioAction("play", "voice", "story_v_side_new_1107505", "1107505078", "story_v_side_new_1107505.awb")
					end

					arg_649_1:RecordHistoryTalkVoice("story_v_side_new_1107505", "1107505078", "story_v_side_new_1107505.awb")
				end

				arg_649_1:RecordContent(arg_649_1.text_.text)
			end

			local var_652_26 = math.max(var_652_17, arg_649_1.talkMaxDuration)

			if var_652_16 <= arg_649_1.time_ and arg_649_1.time_ < var_652_16 + var_652_26 then
				arg_649_1.typewritter.percent = (arg_649_1.time_ - var_652_16) / var_652_26

				arg_649_1.typewritter:SetDirty()
			end

			if arg_649_1.time_ >= var_652_16 + var_652_26 and arg_649_1.time_ < var_652_16 + var_652_26 + arg_652_0 then
				arg_649_1.typewritter.percent = 1

				arg_649_1.typewritter:SetDirty()
				arg_649_1:ShowNextGo(true)
			end
		end

		arg_649_1.nodeConfigList_ = {}

		arg_649_1:InitPlayNodeList()
	end,
	Play1107505079 = function(arg_653_0, arg_653_1)
		arg_653_1.time_ = 0
		arg_653_1.frameCnt_ = 0
		arg_653_1.state_ = "playing"
		arg_653_1.curTalkId_ = 1107505079
		arg_653_1.duration_ = 5

		SetActive(arg_653_1.tipsGo_, false)

		function arg_653_1.onSingleLineFinish_()
			arg_653_1.onSingleLineUpdate_ = nil
			arg_653_1.onSingleLineFinish_ = nil
			arg_653_1.state_ = "waiting"
		end

		function arg_653_1.playNext_(arg_655_0)
			if arg_655_0 == 1 then
				arg_653_0:Play1107505080(arg_653_1)
			end
		end

		function arg_653_1.onSingleLineUpdate_(arg_656_0)
			local var_656_0 = arg_653_1.actors_["1075ui_actor"]
			local var_656_1 = 0

			if var_656_1 < arg_653_1.time_ and arg_653_1.time_ <= var_656_1 + arg_656_0 and not isNil(var_656_0) and arg_653_1.var_.characterEffect1075ui_actor == nil then
				arg_653_1.var_.characterEffect1075ui_actor = var_656_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_656_2 = 0.200000002980232

			if var_656_1 <= arg_653_1.time_ and arg_653_1.time_ < var_656_1 + var_656_2 and not isNil(var_656_0) then
				local var_656_3 = (arg_653_1.time_ - var_656_1) / var_656_2

				if arg_653_1.var_.characterEffect1075ui_actor and not isNil(var_656_0) then
					local var_656_4 = Mathf.Lerp(0, 0.5, var_656_3)

					arg_653_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_653_1.var_.characterEffect1075ui_actor.fillRatio = var_656_4
				end
			end

			if arg_653_1.time_ >= var_656_1 + var_656_2 and arg_653_1.time_ < var_656_1 + var_656_2 + arg_656_0 and not isNil(var_656_0) and arg_653_1.var_.characterEffect1075ui_actor then
				local var_656_5 = 0.5

				arg_653_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_653_1.var_.characterEffect1075ui_actor.fillRatio = var_656_5
			end

			local var_656_6 = 0
			local var_656_7 = 0.55

			if var_656_6 < arg_653_1.time_ and arg_653_1.time_ <= var_656_6 + arg_656_0 then
				arg_653_1.talkMaxDuration = 0
				arg_653_1.dialogCg_.alpha = 1

				arg_653_1.dialog_:SetActive(true)
				SetActive(arg_653_1.leftNameGo_, true)

				local var_656_8 = arg_653_1:FormatText(StoryNameCfg[7].name)

				arg_653_1.leftNameTxt_.text = var_656_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_653_1.leftNameTxt_.transform)

				arg_653_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_653_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_653_1:RecordName(arg_653_1.leftNameTxt_.text)
				SetActive(arg_653_1.iconTrs_.gameObject, true)
				arg_653_1.iconController_:SetSelectedState("hero")

				arg_653_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_653_1.callingController_:SetSelectedState("normal")

				arg_653_1.keyicon_.color = Color.New(1, 1, 1)
				arg_653_1.icon_.color = Color.New(1, 1, 1)

				local var_656_9 = arg_653_1:GetWordFromCfg(1107505079)
				local var_656_10 = arg_653_1:FormatText(var_656_9.content)

				arg_653_1.text_.text = var_656_10

				LuaForUtil.ClearLinePrefixSymbol(arg_653_1.text_)

				local var_656_11 = 22
				local var_656_12 = utf8.len(var_656_10)
				local var_656_13 = var_656_11 <= 0 and var_656_7 or var_656_7 * (var_656_12 / var_656_11)

				if var_656_13 > 0 and var_656_7 < var_656_13 then
					arg_653_1.talkMaxDuration = var_656_13

					if var_656_13 + var_656_6 > arg_653_1.duration_ then
						arg_653_1.duration_ = var_656_13 + var_656_6
					end
				end

				arg_653_1.text_.text = var_656_10
				arg_653_1.typewritter.percent = 0

				arg_653_1.typewritter:SetDirty()
				arg_653_1:ShowNextGo(false)
				arg_653_1:RecordContent(arg_653_1.text_.text)
			end

			local var_656_14 = math.max(var_656_7, arg_653_1.talkMaxDuration)

			if var_656_6 <= arg_653_1.time_ and arg_653_1.time_ < var_656_6 + var_656_14 then
				arg_653_1.typewritter.percent = (arg_653_1.time_ - var_656_6) / var_656_14

				arg_653_1.typewritter:SetDirty()
			end

			if arg_653_1.time_ >= var_656_6 + var_656_14 and arg_653_1.time_ < var_656_6 + var_656_14 + arg_656_0 then
				arg_653_1.typewritter.percent = 1

				arg_653_1.typewritter:SetDirty()
				arg_653_1:ShowNextGo(true)
			end
		end

		arg_653_1.nodeConfigList_ = {}

		arg_653_1:InitPlayNodeList()
	end,
	Play1107505080 = function(arg_657_0, arg_657_1)
		arg_657_1.time_ = 0
		arg_657_1.frameCnt_ = 0
		arg_657_1.state_ = "playing"
		arg_657_1.curTalkId_ = 1107505080
		arg_657_1.duration_ = 4.93

		SetActive(arg_657_1.tipsGo_, false)

		function arg_657_1.onSingleLineFinish_()
			arg_657_1.onSingleLineUpdate_ = nil
			arg_657_1.onSingleLineFinish_ = nil
			arg_657_1.state_ = "waiting"
		end

		function arg_657_1.playNext_(arg_659_0)
			if arg_659_0 == 1 then
				arg_657_0:Play1107505081(arg_657_1)
			end
		end

		function arg_657_1.onSingleLineUpdate_(arg_660_0)
			local var_660_0 = arg_657_1.actors_["1075ui_actor"]
			local var_660_1 = 0

			if var_660_1 < arg_657_1.time_ and arg_657_1.time_ <= var_660_1 + arg_660_0 and not isNil(var_660_0) and arg_657_1.var_.characterEffect1075ui_actor == nil then
				arg_657_1.var_.characterEffect1075ui_actor = var_660_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_660_2 = 0.200000002980232

			if var_660_1 <= arg_657_1.time_ and arg_657_1.time_ < var_660_1 + var_660_2 and not isNil(var_660_0) then
				local var_660_3 = (arg_657_1.time_ - var_660_1) / var_660_2

				if arg_657_1.var_.characterEffect1075ui_actor and not isNil(var_660_0) then
					arg_657_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_657_1.time_ >= var_660_1 + var_660_2 and arg_657_1.time_ < var_660_1 + var_660_2 + arg_660_0 and not isNil(var_660_0) and arg_657_1.var_.characterEffect1075ui_actor then
				arg_657_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			local var_660_4 = 0

			if var_660_4 < arg_657_1.time_ and arg_657_1.time_ <= var_660_4 + arg_660_0 then
				arg_657_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075action/1075action3_2")
			end

			local var_660_5 = 0

			if var_660_5 < arg_657_1.time_ and arg_657_1.time_ <= var_660_5 + arg_660_0 then
				arg_657_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_660_6 = 0
			local var_660_7 = 0.45

			if var_660_6 < arg_657_1.time_ and arg_657_1.time_ <= var_660_6 + arg_660_0 then
				arg_657_1.talkMaxDuration = 0
				arg_657_1.dialogCg_.alpha = 1

				arg_657_1.dialog_:SetActive(true)
				SetActive(arg_657_1.leftNameGo_, true)

				local var_660_8 = arg_657_1:FormatText(StoryNameCfg[381].name)

				arg_657_1.leftNameTxt_.text = var_660_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_657_1.leftNameTxt_.transform)

				arg_657_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_657_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_657_1:RecordName(arg_657_1.leftNameTxt_.text)
				SetActive(arg_657_1.iconTrs_.gameObject, false)
				arg_657_1.callingController_:SetSelectedState("normal")

				local var_660_9 = arg_657_1:GetWordFromCfg(1107505080)
				local var_660_10 = arg_657_1:FormatText(var_660_9.content)

				arg_657_1.text_.text = var_660_10

				LuaForUtil.ClearLinePrefixSymbol(arg_657_1.text_)

				local var_660_11 = 18
				local var_660_12 = utf8.len(var_660_10)
				local var_660_13 = var_660_11 <= 0 and var_660_7 or var_660_7 * (var_660_12 / var_660_11)

				if var_660_13 > 0 and var_660_7 < var_660_13 then
					arg_657_1.talkMaxDuration = var_660_13

					if var_660_13 + var_660_6 > arg_657_1.duration_ then
						arg_657_1.duration_ = var_660_13 + var_660_6
					end
				end

				arg_657_1.text_.text = var_660_10
				arg_657_1.typewritter.percent = 0

				arg_657_1.typewritter:SetDirty()
				arg_657_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107505", "1107505080", "story_v_side_new_1107505.awb") ~= 0 then
					local var_660_14 = manager.audio:GetVoiceLength("story_v_side_new_1107505", "1107505080", "story_v_side_new_1107505.awb") / 1000

					if var_660_14 + var_660_6 > arg_657_1.duration_ then
						arg_657_1.duration_ = var_660_14 + var_660_6
					end

					if var_660_9.prefab_name ~= "" and arg_657_1.actors_[var_660_9.prefab_name] ~= nil then
						local var_660_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_657_1.actors_[var_660_9.prefab_name].transform, "story_v_side_new_1107505", "1107505080", "story_v_side_new_1107505.awb")

						arg_657_1:RecordAudio("1107505080", var_660_15)
						arg_657_1:RecordAudio("1107505080", var_660_15)
					else
						arg_657_1:AudioAction("play", "voice", "story_v_side_new_1107505", "1107505080", "story_v_side_new_1107505.awb")
					end

					arg_657_1:RecordHistoryTalkVoice("story_v_side_new_1107505", "1107505080", "story_v_side_new_1107505.awb")
				end

				arg_657_1:RecordContent(arg_657_1.text_.text)
			end

			local var_660_16 = math.max(var_660_7, arg_657_1.talkMaxDuration)

			if var_660_6 <= arg_657_1.time_ and arg_657_1.time_ < var_660_6 + var_660_16 then
				arg_657_1.typewritter.percent = (arg_657_1.time_ - var_660_6) / var_660_16

				arg_657_1.typewritter:SetDirty()
			end

			if arg_657_1.time_ >= var_660_6 + var_660_16 and arg_657_1.time_ < var_660_6 + var_660_16 + arg_660_0 then
				arg_657_1.typewritter.percent = 1

				arg_657_1.typewritter:SetDirty()
				arg_657_1:ShowNextGo(true)
			end
		end

		arg_657_1.nodeConfigList_ = {}

		arg_657_1:InitPlayNodeList()
	end,
	Play1107505081 = function(arg_661_0, arg_661_1)
		arg_661_1.time_ = 0
		arg_661_1.frameCnt_ = 0
		arg_661_1.state_ = "playing"
		arg_661_1.curTalkId_ = 1107505081
		arg_661_1.duration_ = 5

		SetActive(arg_661_1.tipsGo_, false)

		function arg_661_1.onSingleLineFinish_()
			arg_661_1.onSingleLineUpdate_ = nil
			arg_661_1.onSingleLineFinish_ = nil
			arg_661_1.state_ = "waiting"
		end

		function arg_661_1.playNext_(arg_663_0)
			if arg_663_0 == 1 then
				arg_661_0:Play1107505082(arg_661_1)
			end
		end

		function arg_661_1.onSingleLineUpdate_(arg_664_0)
			local var_664_0 = arg_661_1.actors_["1075ui_actor"]
			local var_664_1 = 0

			if var_664_1 < arg_661_1.time_ and arg_661_1.time_ <= var_664_1 + arg_664_0 and not isNil(var_664_0) and arg_661_1.var_.characterEffect1075ui_actor == nil then
				arg_661_1.var_.characterEffect1075ui_actor = var_664_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_664_2 = 0.200000002980232

			if var_664_1 <= arg_661_1.time_ and arg_661_1.time_ < var_664_1 + var_664_2 and not isNil(var_664_0) then
				local var_664_3 = (arg_661_1.time_ - var_664_1) / var_664_2

				if arg_661_1.var_.characterEffect1075ui_actor and not isNil(var_664_0) then
					local var_664_4 = Mathf.Lerp(0, 0.5, var_664_3)

					arg_661_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_661_1.var_.characterEffect1075ui_actor.fillRatio = var_664_4
				end
			end

			if arg_661_1.time_ >= var_664_1 + var_664_2 and arg_661_1.time_ < var_664_1 + var_664_2 + arg_664_0 and not isNil(var_664_0) and arg_661_1.var_.characterEffect1075ui_actor then
				local var_664_5 = 0.5

				arg_661_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_661_1.var_.characterEffect1075ui_actor.fillRatio = var_664_5
			end

			local var_664_6 = 0
			local var_664_7 = 0.225

			if var_664_6 < arg_661_1.time_ and arg_661_1.time_ <= var_664_6 + arg_664_0 then
				arg_661_1.talkMaxDuration = 0
				arg_661_1.dialogCg_.alpha = 1

				arg_661_1.dialog_:SetActive(true)
				SetActive(arg_661_1.leftNameGo_, true)

				local var_664_8 = arg_661_1:FormatText(StoryNameCfg[7].name)

				arg_661_1.leftNameTxt_.text = var_664_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_661_1.leftNameTxt_.transform)

				arg_661_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_661_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_661_1:RecordName(arg_661_1.leftNameTxt_.text)
				SetActive(arg_661_1.iconTrs_.gameObject, true)
				arg_661_1.iconController_:SetSelectedState("hero")

				arg_661_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_661_1.callingController_:SetSelectedState("normal")

				arg_661_1.keyicon_.color = Color.New(1, 1, 1)
				arg_661_1.icon_.color = Color.New(1, 1, 1)

				local var_664_9 = arg_661_1:GetWordFromCfg(1107505081)
				local var_664_10 = arg_661_1:FormatText(var_664_9.content)

				arg_661_1.text_.text = var_664_10

				LuaForUtil.ClearLinePrefixSymbol(arg_661_1.text_)

				local var_664_11 = 9
				local var_664_12 = utf8.len(var_664_10)
				local var_664_13 = var_664_11 <= 0 and var_664_7 or var_664_7 * (var_664_12 / var_664_11)

				if var_664_13 > 0 and var_664_7 < var_664_13 then
					arg_661_1.talkMaxDuration = var_664_13

					if var_664_13 + var_664_6 > arg_661_1.duration_ then
						arg_661_1.duration_ = var_664_13 + var_664_6
					end
				end

				arg_661_1.text_.text = var_664_10
				arg_661_1.typewritter.percent = 0

				arg_661_1.typewritter:SetDirty()
				arg_661_1:ShowNextGo(false)
				arg_661_1:RecordContent(arg_661_1.text_.text)
			end

			local var_664_14 = math.max(var_664_7, arg_661_1.talkMaxDuration)

			if var_664_6 <= arg_661_1.time_ and arg_661_1.time_ < var_664_6 + var_664_14 then
				arg_661_1.typewritter.percent = (arg_661_1.time_ - var_664_6) / var_664_14

				arg_661_1.typewritter:SetDirty()
			end

			if arg_661_1.time_ >= var_664_6 + var_664_14 and arg_661_1.time_ < var_664_6 + var_664_14 + arg_664_0 then
				arg_661_1.typewritter.percent = 1

				arg_661_1.typewritter:SetDirty()
				arg_661_1:ShowNextGo(true)
			end
		end

		arg_661_1.nodeConfigList_ = {}

		arg_661_1:InitPlayNodeList()
	end,
	Play1107505082 = function(arg_665_0, arg_665_1)
		arg_665_1.time_ = 0
		arg_665_1.frameCnt_ = 0
		arg_665_1.state_ = "playing"
		arg_665_1.curTalkId_ = 1107505082
		arg_665_1.duration_ = 5

		SetActive(arg_665_1.tipsGo_, false)

		function arg_665_1.onSingleLineFinish_()
			arg_665_1.onSingleLineUpdate_ = nil
			arg_665_1.onSingleLineFinish_ = nil
			arg_665_1.state_ = "waiting"
		end

		function arg_665_1.playNext_(arg_667_0)
			if arg_667_0 == 1 then
				arg_665_0:Play1107505083(arg_665_1)
			end
		end

		function arg_665_1.onSingleLineUpdate_(arg_668_0)
			local var_668_0 = 0
			local var_668_1 = 0.825

			if var_668_0 < arg_665_1.time_ and arg_665_1.time_ <= var_668_0 + arg_668_0 then
				arg_665_1.talkMaxDuration = 0
				arg_665_1.dialogCg_.alpha = 1

				arg_665_1.dialog_:SetActive(true)
				SetActive(arg_665_1.leftNameGo_, false)

				arg_665_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_665_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_665_1:RecordName(arg_665_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_665_1.iconTrs_.gameObject, false)
				arg_665_1.callingController_:SetSelectedState("normal")

				local var_668_2 = arg_665_1:GetWordFromCfg(1107505082)
				local var_668_3 = arg_665_1:FormatText(var_668_2.content)

				arg_665_1.text_.text = var_668_3

				LuaForUtil.ClearLinePrefixSymbol(arg_665_1.text_)

				local var_668_4 = 33
				local var_668_5 = utf8.len(var_668_3)
				local var_668_6 = var_668_4 <= 0 and var_668_1 or var_668_1 * (var_668_5 / var_668_4)

				if var_668_6 > 0 and var_668_1 < var_668_6 then
					arg_665_1.talkMaxDuration = var_668_6

					if var_668_6 + var_668_0 > arg_665_1.duration_ then
						arg_665_1.duration_ = var_668_6 + var_668_0
					end
				end

				arg_665_1.text_.text = var_668_3
				arg_665_1.typewritter.percent = 0

				arg_665_1.typewritter:SetDirty()
				arg_665_1:ShowNextGo(false)
				arg_665_1:RecordContent(arg_665_1.text_.text)
			end

			local var_668_7 = math.max(var_668_1, arg_665_1.talkMaxDuration)

			if var_668_0 <= arg_665_1.time_ and arg_665_1.time_ < var_668_0 + var_668_7 then
				arg_665_1.typewritter.percent = (arg_665_1.time_ - var_668_0) / var_668_7

				arg_665_1.typewritter:SetDirty()
			end

			if arg_665_1.time_ >= var_668_0 + var_668_7 and arg_665_1.time_ < var_668_0 + var_668_7 + arg_668_0 then
				arg_665_1.typewritter.percent = 1

				arg_665_1.typewritter:SetDirty()
				arg_665_1:ShowNextGo(true)
			end
		end

		arg_665_1.nodeConfigList_ = {}

		arg_665_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST32",
		"TextureConfig/Background/ST42",
		"TextureConfig/Background/ST31",
		"TextureConfig/Background/ST37",
		"TextureConfig/Background/ST39",
		"TextureConfig/Background/ST45",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/ST37a"
	},
	voices = {
		"story_v_side_new_1107505.awb"
	}
}
