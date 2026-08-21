return {
	Play318161001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 318161001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play318161002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "A00"

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
				local var_4_5 = arg_1_1.bgs_.A00

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
					if iter_4_0 ~= "A00" then
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

			local var_4_22 = 0
			local var_4_23 = 0.533333333333333

			if var_4_22 < arg_1_1.time_ and arg_1_1.time_ <= var_4_22 + arg_4_0 then
				local var_4_24 = "play"
				local var_4_25 = "music"

				arg_1_1:AudioAction(var_4_24, var_4_25, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_26 = ""
				local var_4_27 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_27 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_27 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_27

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_27
						arg_1_1.bgmTxt2_.text = var_4_27
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

			local var_4_28 = 0.8
			local var_4_29 = 1

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				local var_4_30 = "play"
				local var_4_31 = "music"

				arg_1_1:AudioAction(var_4_30, var_4_31, "bgm_story_office", "bgm_story_office", "bgm_story_office.awb")

				local var_4_32 = ""
				local var_4_33 = manager.audio:GetAudioName("bgm_story_office", "bgm_story_office")

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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_34 = 2
			local var_4_35 = 0.625

			if var_4_34 < arg_1_1.time_ and arg_1_1.time_ <= var_4_34 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_36 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_36:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_36:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_36:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_37 = arg_1_1:GetWordFromCfg(318161001)
				local var_4_38 = arg_1_1:FormatText(var_4_37.content)

				arg_1_1.text_.text = var_4_38

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_39 = 25
				local var_4_40 = utf8.len(var_4_38)
				local var_4_41 = var_4_39 <= 0 and var_4_35 or var_4_35 * (var_4_40 / var_4_39)

				if var_4_41 > 0 and var_4_35 < var_4_41 then
					arg_1_1.talkMaxDuration = var_4_41
					var_4_34 = var_4_34 + 0.3

					if var_4_41 + var_4_34 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_41 + var_4_34
					end
				end

				arg_1_1.text_.text = var_4_38
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_42 = var_4_34 + 0.3
			local var_4_43 = math.max(var_4_35, arg_1_1.talkMaxDuration)

			if var_4_42 <= arg_1_1.time_ and arg_1_1.time_ < var_4_42 + var_4_43 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_42) / var_4_43

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_42 + var_4_43 and arg_1_1.time_ < var_4_42 + var_4_43 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play318161002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 318161002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play318161003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0
			local var_12_1 = 0.533333333333333

			if var_12_0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_0 + arg_12_0 then
				local var_12_2 = "play"
				local var_12_3 = "effect"

				arg_9_1:AudioAction(var_12_2, var_12_3, "se_story_128", "se_story_128_knock", "")
			end

			local var_12_4 = 0
			local var_12_5 = 0.9

			if var_12_4 < arg_9_1.time_ and arg_9_1.time_ <= var_12_4 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, false)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_6 = arg_9_1:GetWordFromCfg(318161002)
				local var_12_7 = arg_9_1:FormatText(var_12_6.content)

				arg_9_1.text_.text = var_12_7

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_8 = 36
				local var_12_9 = utf8.len(var_12_7)
				local var_12_10 = var_12_8 <= 0 and var_12_5 or var_12_5 * (var_12_9 / var_12_8)

				if var_12_10 > 0 and var_12_5 < var_12_10 then
					arg_9_1.talkMaxDuration = var_12_10

					if var_12_10 + var_12_4 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_10 + var_12_4
					end
				end

				arg_9_1.text_.text = var_12_7
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_11 = math.max(var_12_5, arg_9_1.talkMaxDuration)

			if var_12_4 <= arg_9_1.time_ and arg_9_1.time_ < var_12_4 + var_12_11 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_4) / var_12_11

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_4 + var_12_11 and arg_9_1.time_ < var_12_4 + var_12_11 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play318161003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 318161003
		arg_13_1.duration_ = 1.23

		local var_13_0 = {
			zh = 0.999999999999,
			ja = 1.233
		}
		local var_13_1 = manager.audio:GetLocalizationFlag()

		if var_13_0[var_13_1] ~= nil then
			arg_13_1.duration_ = var_13_0[var_13_1]
		end

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play318161004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = "1019ui_story"

			if arg_13_1.actors_[var_16_0] == nil then
				local var_16_1 = Asset.Load("Char/" .. "1019ui_story")

				if not isNil(var_16_1) then
					local var_16_2 = Object.Instantiate(Asset.Load("Char/" .. "1019ui_story"), arg_13_1.stage_.transform)

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

			local var_16_5 = arg_13_1.actors_["1019ui_story"].transform
			local var_16_6 = 0

			if var_16_6 < arg_13_1.time_ and arg_13_1.time_ <= var_16_6 + arg_16_0 then
				arg_13_1.var_.moveOldPos1019ui_story = var_16_5.localPosition
			end

			local var_16_7 = 0.001

			if var_16_6 <= arg_13_1.time_ and arg_13_1.time_ < var_16_6 + var_16_7 then
				local var_16_8 = (arg_13_1.time_ - var_16_6) / var_16_7
				local var_16_9 = Vector3.New(-0.2, -1.08, -5.9)

				var_16_5.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1019ui_story, var_16_9, var_16_8)

				local var_16_10 = manager.ui.mainCamera.transform.position - var_16_5.position

				var_16_5.forward = Vector3.New(var_16_10.x, var_16_10.y, var_16_10.z)

				local var_16_11 = var_16_5.localEulerAngles

				var_16_11.z = 0
				var_16_11.x = 0
				var_16_5.localEulerAngles = var_16_11
			end

			if arg_13_1.time_ >= var_16_6 + var_16_7 and arg_13_1.time_ < var_16_6 + var_16_7 + arg_16_0 then
				var_16_5.localPosition = Vector3.New(-0.2, -1.08, -5.9)

				local var_16_12 = manager.ui.mainCamera.transform.position - var_16_5.position

				var_16_5.forward = Vector3.New(var_16_12.x, var_16_12.y, var_16_12.z)

				local var_16_13 = var_16_5.localEulerAngles

				var_16_13.z = 0
				var_16_13.x = 0
				var_16_5.localEulerAngles = var_16_13
			end

			local var_16_14 = arg_13_1.actors_["1019ui_story"]
			local var_16_15 = 0

			if var_16_15 < arg_13_1.time_ and arg_13_1.time_ <= var_16_15 + arg_16_0 and not isNil(var_16_14) and arg_13_1.var_.characterEffect1019ui_story == nil then
				arg_13_1.var_.characterEffect1019ui_story = var_16_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_16 = 0.200000002980232

			if var_16_15 <= arg_13_1.time_ and arg_13_1.time_ < var_16_15 + var_16_16 and not isNil(var_16_14) then
				local var_16_17 = (arg_13_1.time_ - var_16_15) / var_16_16

				if arg_13_1.var_.characterEffect1019ui_story and not isNil(var_16_14) then
					arg_13_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= var_16_15 + var_16_16 and arg_13_1.time_ < var_16_15 + var_16_16 + arg_16_0 and not isNil(var_16_14) and arg_13_1.var_.characterEffect1019ui_story then
				arg_13_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_16_18 = 0

			if var_16_18 < arg_13_1.time_ and arg_13_1.time_ <= var_16_18 + arg_16_0 then
				arg_13_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action1_1")
			end

			local var_16_19 = 0

			if var_16_19 < arg_13_1.time_ and arg_13_1.time_ <= var_16_19 + arg_16_0 then
				arg_13_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_16_20 = 0
			local var_16_21 = 0.1

			if var_16_20 < arg_13_1.time_ and arg_13_1.time_ <= var_16_20 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_22 = arg_13_1:FormatText(StoryNameCfg[13].name)

				arg_13_1.leftNameTxt_.text = var_16_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_23 = arg_13_1:GetWordFromCfg(318161003)
				local var_16_24 = arg_13_1:FormatText(var_16_23.content)

				arg_13_1.text_.text = var_16_24

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_25 = 4
				local var_16_26 = utf8.len(var_16_24)
				local var_16_27 = var_16_25 <= 0 and var_16_21 or var_16_21 * (var_16_26 / var_16_25)

				if var_16_27 > 0 and var_16_21 < var_16_27 then
					arg_13_1.talkMaxDuration = var_16_27

					if var_16_27 + var_16_20 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_27 + var_16_20
					end
				end

				arg_13_1.text_.text = var_16_24
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318161", "318161003", "story_v_out_318161.awb") ~= 0 then
					local var_16_28 = manager.audio:GetVoiceLength("story_v_out_318161", "318161003", "story_v_out_318161.awb") / 1000

					if var_16_28 + var_16_20 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_28 + var_16_20
					end

					if var_16_23.prefab_name ~= "" and arg_13_1.actors_[var_16_23.prefab_name] ~= nil then
						local var_16_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_23.prefab_name].transform, "story_v_out_318161", "318161003", "story_v_out_318161.awb")

						arg_13_1:RecordAudio("318161003", var_16_29)
						arg_13_1:RecordAudio("318161003", var_16_29)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_318161", "318161003", "story_v_out_318161.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_318161", "318161003", "story_v_out_318161.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_30 = math.max(var_16_21, arg_13_1.talkMaxDuration)

			if var_16_20 <= arg_13_1.time_ and arg_13_1.time_ < var_16_20 + var_16_30 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_20) / var_16_30

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_20 + var_16_30 and arg_13_1.time_ < var_16_20 + var_16_30 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
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

		arg_13_1:InitPlayNodeList()
	end,
	Play318161004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 318161004
		arg_17_1.duration_ = 4.4

		local var_17_0 = {
			zh = 4.133,
			ja = 4.4
		}
		local var_17_1 = manager.audio:GetLocalizationFlag()

		if var_17_0[var_17_1] ~= nil then
			arg_17_1.duration_ = var_17_0[var_17_1]
		end

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play318161005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = "1028ui_story"

			if arg_17_1.actors_[var_20_0] == nil then
				local var_20_1 = Asset.Load("Char/" .. "1028ui_story")

				if not isNil(var_20_1) then
					local var_20_2 = Object.Instantiate(Asset.Load("Char/" .. "1028ui_story"), arg_17_1.stage_.transform)

					var_20_2.name = var_20_0
					var_20_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_17_1.actors_[var_20_0] = var_20_2

					local var_20_3 = var_20_2:GetComponentInChildren(typeof(CharacterEffect))

					var_20_3.enabled = true

					local var_20_4 = GameObjectTools.GetOrAddComponent(var_20_2, typeof(DynamicBoneHelper))

					if var_20_4 then
						var_20_4:EnableDynamicBone(false)
					end

					arg_17_1:ShowWeapon(var_20_3.transform, false)

					arg_17_1.var_[var_20_0 .. "Animator"] = var_20_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_17_1.var_[var_20_0 .. "Animator"].applyRootMotion = true
					arg_17_1.var_[var_20_0 .. "LipSync"] = var_20_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_20_5 = arg_17_1.actors_["1028ui_story"].transform
			local var_20_6 = 0

			if var_20_6 < arg_17_1.time_ and arg_17_1.time_ <= var_20_6 + arg_20_0 then
				arg_17_1.var_.moveOldPos1028ui_story = var_20_5.localPosition
			end

			local var_20_7 = 0.001

			if var_20_6 <= arg_17_1.time_ and arg_17_1.time_ < var_20_6 + var_20_7 then
				local var_20_8 = (arg_17_1.time_ - var_20_6) / var_20_7
				local var_20_9 = Vector3.New(0.7, -0.9, -5.9)

				var_20_5.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1028ui_story, var_20_9, var_20_8)

				local var_20_10 = manager.ui.mainCamera.transform.position - var_20_5.position

				var_20_5.forward = Vector3.New(var_20_10.x, var_20_10.y, var_20_10.z)

				local var_20_11 = var_20_5.localEulerAngles

				var_20_11.z = 0
				var_20_11.x = 0
				var_20_5.localEulerAngles = var_20_11
			end

			if arg_17_1.time_ >= var_20_6 + var_20_7 and arg_17_1.time_ < var_20_6 + var_20_7 + arg_20_0 then
				var_20_5.localPosition = Vector3.New(0.7, -0.9, -5.9)

				local var_20_12 = manager.ui.mainCamera.transform.position - var_20_5.position

				var_20_5.forward = Vector3.New(var_20_12.x, var_20_12.y, var_20_12.z)

				local var_20_13 = var_20_5.localEulerAngles

				var_20_13.z = 0
				var_20_13.x = 0
				var_20_5.localEulerAngles = var_20_13
			end

			local var_20_14 = arg_17_1.actors_["1028ui_story"]
			local var_20_15 = 0

			if var_20_15 < arg_17_1.time_ and arg_17_1.time_ <= var_20_15 + arg_20_0 and not isNil(var_20_14) and arg_17_1.var_.characterEffect1028ui_story == nil then
				arg_17_1.var_.characterEffect1028ui_story = var_20_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_16 = 0.200000002980232

			if var_20_15 <= arg_17_1.time_ and arg_17_1.time_ < var_20_15 + var_20_16 and not isNil(var_20_14) then
				local var_20_17 = (arg_17_1.time_ - var_20_15) / var_20_16

				if arg_17_1.var_.characterEffect1028ui_story and not isNil(var_20_14) then
					arg_17_1.var_.characterEffect1028ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= var_20_15 + var_20_16 and arg_17_1.time_ < var_20_15 + var_20_16 + arg_20_0 and not isNil(var_20_14) and arg_17_1.var_.characterEffect1028ui_story then
				arg_17_1.var_.characterEffect1028ui_story.fillFlat = false
			end

			local var_20_18 = 0

			if var_20_18 < arg_17_1.time_ and arg_17_1.time_ <= var_20_18 + arg_20_0 then
				arg_17_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/story1028/story1028action/1028action1_1")
			end

			local var_20_19 = 0

			if var_20_19 < arg_17_1.time_ and arg_17_1.time_ <= var_20_19 + arg_20_0 then
				arg_17_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_20_20 = arg_17_1.actors_["1019ui_story"].transform
			local var_20_21 = 0

			if var_20_21 < arg_17_1.time_ and arg_17_1.time_ <= var_20_21 + arg_20_0 then
				arg_17_1.var_.moveOldPos1019ui_story = var_20_20.localPosition
			end

			local var_20_22 = 0.001

			if var_20_21 <= arg_17_1.time_ and arg_17_1.time_ < var_20_21 + var_20_22 then
				local var_20_23 = (arg_17_1.time_ - var_20_21) / var_20_22
				local var_20_24 = Vector3.New(-0.7, -1.08, -5.9)

				var_20_20.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1019ui_story, var_20_24, var_20_23)

				local var_20_25 = manager.ui.mainCamera.transform.position - var_20_20.position

				var_20_20.forward = Vector3.New(var_20_25.x, var_20_25.y, var_20_25.z)

				local var_20_26 = var_20_20.localEulerAngles

				var_20_26.z = 0
				var_20_26.x = 0
				var_20_20.localEulerAngles = var_20_26
			end

			if arg_17_1.time_ >= var_20_21 + var_20_22 and arg_17_1.time_ < var_20_21 + var_20_22 + arg_20_0 then
				var_20_20.localPosition = Vector3.New(-0.7, -1.08, -5.9)

				local var_20_27 = manager.ui.mainCamera.transform.position - var_20_20.position

				var_20_20.forward = Vector3.New(var_20_27.x, var_20_27.y, var_20_27.z)

				local var_20_28 = var_20_20.localEulerAngles

				var_20_28.z = 0
				var_20_28.x = 0
				var_20_20.localEulerAngles = var_20_28
			end

			local var_20_29 = arg_17_1.actors_["1019ui_story"]
			local var_20_30 = 0

			if var_20_30 < arg_17_1.time_ and arg_17_1.time_ <= var_20_30 + arg_20_0 and not isNil(var_20_29) and arg_17_1.var_.characterEffect1019ui_story == nil then
				arg_17_1.var_.characterEffect1019ui_story = var_20_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_31 = 0.200000002980232

			if var_20_30 <= arg_17_1.time_ and arg_17_1.time_ < var_20_30 + var_20_31 and not isNil(var_20_29) then
				local var_20_32 = (arg_17_1.time_ - var_20_30) / var_20_31

				if arg_17_1.var_.characterEffect1019ui_story and not isNil(var_20_29) then
					local var_20_33 = Mathf.Lerp(0, 0.5, var_20_32)

					arg_17_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_17_1.var_.characterEffect1019ui_story.fillRatio = var_20_33
				end
			end

			if arg_17_1.time_ >= var_20_30 + var_20_31 and arg_17_1.time_ < var_20_30 + var_20_31 + arg_20_0 and not isNil(var_20_29) and arg_17_1.var_.characterEffect1019ui_story then
				local var_20_34 = 0.5

				arg_17_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_17_1.var_.characterEffect1019ui_story.fillRatio = var_20_34
			end

			local var_20_35 = 0
			local var_20_36 = 0.45

			if var_20_35 < arg_17_1.time_ and arg_17_1.time_ <= var_20_35 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_37 = arg_17_1:FormatText(StoryNameCfg[327].name)

				arg_17_1.leftNameTxt_.text = var_20_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_38 = arg_17_1:GetWordFromCfg(318161004)
				local var_20_39 = arg_17_1:FormatText(var_20_38.content)

				arg_17_1.text_.text = var_20_39

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_40 = 18
				local var_20_41 = utf8.len(var_20_39)
				local var_20_42 = var_20_40 <= 0 and var_20_36 or var_20_36 * (var_20_41 / var_20_40)

				if var_20_42 > 0 and var_20_36 < var_20_42 then
					arg_17_1.talkMaxDuration = var_20_42

					if var_20_42 + var_20_35 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_42 + var_20_35
					end
				end

				arg_17_1.text_.text = var_20_39
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318161", "318161004", "story_v_out_318161.awb") ~= 0 then
					local var_20_43 = manager.audio:GetVoiceLength("story_v_out_318161", "318161004", "story_v_out_318161.awb") / 1000

					if var_20_43 + var_20_35 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_43 + var_20_35
					end

					if var_20_38.prefab_name ~= "" and arg_17_1.actors_[var_20_38.prefab_name] ~= nil then
						local var_20_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_38.prefab_name].transform, "story_v_out_318161", "318161004", "story_v_out_318161.awb")

						arg_17_1:RecordAudio("318161004", var_20_44)
						arg_17_1:RecordAudio("318161004", var_20_44)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_318161", "318161004", "story_v_out_318161.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_318161", "318161004", "story_v_out_318161.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_45 = math.max(var_20_36, arg_17_1.talkMaxDuration)

			if var_20_35 <= arg_17_1.time_ and arg_17_1.time_ < var_20_35 + var_20_45 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_35) / var_20_45

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_35 + var_20_45 and arg_17_1.time_ < var_20_35 + var_20_45 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_17_1:InitPlayNodeList()
	end,
	Play318161005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 318161005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play318161006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = arg_21_1.actors_["1028ui_story"]
			local var_24_1 = 0

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.characterEffect1028ui_story == nil then
				arg_21_1.var_.characterEffect1028ui_story = var_24_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_2 = 0.200000002980232

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_2 and not isNil(var_24_0) then
				local var_24_3 = (arg_21_1.time_ - var_24_1) / var_24_2

				if arg_21_1.var_.characterEffect1028ui_story and not isNil(var_24_0) then
					local var_24_4 = Mathf.Lerp(0, 0.5, var_24_3)

					arg_21_1.var_.characterEffect1028ui_story.fillFlat = true
					arg_21_1.var_.characterEffect1028ui_story.fillRatio = var_24_4
				end
			end

			if arg_21_1.time_ >= var_24_1 + var_24_2 and arg_21_1.time_ < var_24_1 + var_24_2 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.characterEffect1028ui_story then
				local var_24_5 = 0.5

				arg_21_1.var_.characterEffect1028ui_story.fillFlat = true
				arg_21_1.var_.characterEffect1028ui_story.fillRatio = var_24_5
			end

			local var_24_6 = 0
			local var_24_7 = 1

			if var_24_6 < arg_21_1.time_ and arg_21_1.time_ <= var_24_6 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, false)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_8 = arg_21_1:GetWordFromCfg(318161005)
				local var_24_9 = arg_21_1:FormatText(var_24_8.content)

				arg_21_1.text_.text = var_24_9

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_10 = 40
				local var_24_11 = utf8.len(var_24_9)
				local var_24_12 = var_24_10 <= 0 and var_24_7 or var_24_7 * (var_24_11 / var_24_10)

				if var_24_12 > 0 and var_24_7 < var_24_12 then
					arg_21_1.talkMaxDuration = var_24_12

					if var_24_12 + var_24_6 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_12 + var_24_6
					end
				end

				arg_21_1.text_.text = var_24_9
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_13 = math.max(var_24_7, arg_21_1.talkMaxDuration)

			if var_24_6 <= arg_21_1.time_ and arg_21_1.time_ < var_24_6 + var_24_13 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_6) / var_24_13

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_6 + var_24_13 and arg_21_1.time_ < var_24_6 + var_24_13 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play318161006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 318161006
		arg_25_1.duration_ = 10.77

		local var_25_0 = {
			zh = 10.1,
			ja = 10.766
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
				arg_25_0:Play318161007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = arg_25_1.actors_["1019ui_story"]
			local var_28_1 = 0

			if var_28_1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.characterEffect1019ui_story == nil then
				arg_25_1.var_.characterEffect1019ui_story = var_28_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_2 = 0.200000002980232

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_2 and not isNil(var_28_0) then
				local var_28_3 = (arg_25_1.time_ - var_28_1) / var_28_2

				if arg_25_1.var_.characterEffect1019ui_story and not isNil(var_28_0) then
					arg_25_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= var_28_1 + var_28_2 and arg_25_1.time_ < var_28_1 + var_28_2 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.characterEffect1019ui_story then
				arg_25_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_28_4 = 0

			if var_28_4 < arg_25_1.time_ and arg_25_1.time_ <= var_28_4 + arg_28_0 then
				arg_25_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action5_1")
			end

			local var_28_5 = 0

			if var_28_5 < arg_25_1.time_ and arg_25_1.time_ <= var_28_5 + arg_28_0 then
				arg_25_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_28_6 = arg_25_1.actors_["1019ui_story"]
			local var_28_7 = 0

			if var_28_7 < arg_25_1.time_ and arg_25_1.time_ <= var_28_7 + arg_28_0 and not isNil(var_28_6) and arg_25_1.var_.characterEffect1019ui_story == nil then
				arg_25_1.var_.characterEffect1019ui_story = var_28_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_8 = 0.200000002980232

			if var_28_7 <= arg_25_1.time_ and arg_25_1.time_ < var_28_7 + var_28_8 and not isNil(var_28_6) then
				local var_28_9 = (arg_25_1.time_ - var_28_7) / var_28_8

				if arg_25_1.var_.characterEffect1019ui_story and not isNil(var_28_6) then
					arg_25_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= var_28_7 + var_28_8 and arg_25_1.time_ < var_28_7 + var_28_8 + arg_28_0 and not isNil(var_28_6) and arg_25_1.var_.characterEffect1019ui_story then
				arg_25_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_28_10 = 0
			local var_28_11 = 1.3

			if var_28_10 < arg_25_1.time_ and arg_25_1.time_ <= var_28_10 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_12 = arg_25_1:FormatText(StoryNameCfg[13].name)

				arg_25_1.leftNameTxt_.text = var_28_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_13 = arg_25_1:GetWordFromCfg(318161006)
				local var_28_14 = arg_25_1:FormatText(var_28_13.content)

				arg_25_1.text_.text = var_28_14

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_15 = 52
				local var_28_16 = utf8.len(var_28_14)
				local var_28_17 = var_28_15 <= 0 and var_28_11 or var_28_11 * (var_28_16 / var_28_15)

				if var_28_17 > 0 and var_28_11 < var_28_17 then
					arg_25_1.talkMaxDuration = var_28_17

					if var_28_17 + var_28_10 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_17 + var_28_10
					end
				end

				arg_25_1.text_.text = var_28_14
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318161", "318161006", "story_v_out_318161.awb") ~= 0 then
					local var_28_18 = manager.audio:GetVoiceLength("story_v_out_318161", "318161006", "story_v_out_318161.awb") / 1000

					if var_28_18 + var_28_10 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_18 + var_28_10
					end

					if var_28_13.prefab_name ~= "" and arg_25_1.actors_[var_28_13.prefab_name] ~= nil then
						local var_28_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_13.prefab_name].transform, "story_v_out_318161", "318161006", "story_v_out_318161.awb")

						arg_25_1:RecordAudio("318161006", var_28_19)
						arg_25_1:RecordAudio("318161006", var_28_19)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_318161", "318161006", "story_v_out_318161.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_318161", "318161006", "story_v_out_318161.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_20 = math.max(var_28_11, arg_25_1.talkMaxDuration)

			if var_28_10 <= arg_25_1.time_ and arg_25_1.time_ < var_28_10 + var_28_20 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_10) / var_28_20

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_10 + var_28_20 and arg_25_1.time_ < var_28_10 + var_28_20 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play318161007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 318161007
		arg_29_1.duration_ = 7.63

		local var_29_0 = {
			zh = 7.3,
			ja = 7.633
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
				arg_29_0:Play318161008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = arg_29_1.actors_["1028ui_story"]
			local var_32_1 = 0

			if var_32_1 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.characterEffect1028ui_story == nil then
				arg_29_1.var_.characterEffect1028ui_story = var_32_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_2 = 0.200000002980232

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_2 and not isNil(var_32_0) then
				local var_32_3 = (arg_29_1.time_ - var_32_1) / var_32_2

				if arg_29_1.var_.characterEffect1028ui_story and not isNil(var_32_0) then
					arg_29_1.var_.characterEffect1028ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= var_32_1 + var_32_2 and arg_29_1.time_ < var_32_1 + var_32_2 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.characterEffect1028ui_story then
				arg_29_1.var_.characterEffect1028ui_story.fillFlat = false
			end

			local var_32_4 = 0

			if var_32_4 < arg_29_1.time_ and arg_29_1.time_ <= var_32_4 + arg_32_0 then
				arg_29_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0201cva")
			end

			local var_32_5 = arg_29_1.actors_["1019ui_story"]
			local var_32_6 = 0

			if var_32_6 < arg_29_1.time_ and arg_29_1.time_ <= var_32_6 + arg_32_0 and not isNil(var_32_5) and arg_29_1.var_.characterEffect1019ui_story == nil then
				arg_29_1.var_.characterEffect1019ui_story = var_32_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_7 = 0.200000002980232

			if var_32_6 <= arg_29_1.time_ and arg_29_1.time_ < var_32_6 + var_32_7 and not isNil(var_32_5) then
				local var_32_8 = (arg_29_1.time_ - var_32_6) / var_32_7

				if arg_29_1.var_.characterEffect1019ui_story and not isNil(var_32_5) then
					local var_32_9 = Mathf.Lerp(0, 0.5, var_32_8)

					arg_29_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_29_1.var_.characterEffect1019ui_story.fillRatio = var_32_9
				end
			end

			if arg_29_1.time_ >= var_32_6 + var_32_7 and arg_29_1.time_ < var_32_6 + var_32_7 + arg_32_0 and not isNil(var_32_5) and arg_29_1.var_.characterEffect1019ui_story then
				local var_32_10 = 0.5

				arg_29_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_29_1.var_.characterEffect1019ui_story.fillRatio = var_32_10
			end

			local var_32_11 = 0

			if var_32_11 < arg_29_1.time_ and arg_29_1.time_ <= var_32_11 + arg_32_0 then
				arg_29_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/story1028/story1028action/1028action5_1")
			end

			local var_32_12 = 0
			local var_32_13 = 0.775

			if var_32_12 < arg_29_1.time_ and arg_29_1.time_ <= var_32_12 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_14 = arg_29_1:FormatText(StoryNameCfg[327].name)

				arg_29_1.leftNameTxt_.text = var_32_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_15 = arg_29_1:GetWordFromCfg(318161007)
				local var_32_16 = arg_29_1:FormatText(var_32_15.content)

				arg_29_1.text_.text = var_32_16

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_17 = 31
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

				if manager.audio:GetVoiceLength("story_v_out_318161", "318161007", "story_v_out_318161.awb") ~= 0 then
					local var_32_20 = manager.audio:GetVoiceLength("story_v_out_318161", "318161007", "story_v_out_318161.awb") / 1000

					if var_32_20 + var_32_12 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_20 + var_32_12
					end

					if var_32_15.prefab_name ~= "" and arg_29_1.actors_[var_32_15.prefab_name] ~= nil then
						local var_32_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_15.prefab_name].transform, "story_v_out_318161", "318161007", "story_v_out_318161.awb")

						arg_29_1:RecordAudio("318161007", var_32_21)
						arg_29_1:RecordAudio("318161007", var_32_21)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_318161", "318161007", "story_v_out_318161.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_318161", "318161007", "story_v_out_318161.awb")
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
	Play318161008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 318161008
		arg_33_1.duration_ = 12.67

		local var_33_0 = {
			zh = 12.666,
			ja = 8.733
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
				arg_33_0:Play318161009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 0

			if var_36_0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_0 + arg_36_0 then
				arg_33_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_36_1 = 0
			local var_36_2 = 1.5

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_3 = arg_33_1:FormatText(StoryNameCfg[327].name)

				arg_33_1.leftNameTxt_.text = var_36_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_4 = arg_33_1:GetWordFromCfg(318161008)
				local var_36_5 = arg_33_1:FormatText(var_36_4.content)

				arg_33_1.text_.text = var_36_5

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_6 = 60
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

				if manager.audio:GetVoiceLength("story_v_out_318161", "318161008", "story_v_out_318161.awb") ~= 0 then
					local var_36_9 = manager.audio:GetVoiceLength("story_v_out_318161", "318161008", "story_v_out_318161.awb") / 1000

					if var_36_9 + var_36_1 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_9 + var_36_1
					end

					if var_36_4.prefab_name ~= "" and arg_33_1.actors_[var_36_4.prefab_name] ~= nil then
						local var_36_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_4.prefab_name].transform, "story_v_out_318161", "318161008", "story_v_out_318161.awb")

						arg_33_1:RecordAudio("318161008", var_36_10)
						arg_33_1:RecordAudio("318161008", var_36_10)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_318161", "318161008", "story_v_out_318161.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_318161", "318161008", "story_v_out_318161.awb")
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
	Play318161009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 318161009
		arg_37_1.duration_ = 7.63

		local var_37_0 = {
			zh = 5.7,
			ja = 7.633
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
				arg_37_0:Play318161010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 0

			if var_40_0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_0 + arg_40_0 then
				arg_37_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/story1028/story1028actionlink/1028action456")
			end

			local var_40_1 = 0
			local var_40_2 = 0.825

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_3 = arg_37_1:FormatText(StoryNameCfg[327].name)

				arg_37_1.leftNameTxt_.text = var_40_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_4 = arg_37_1:GetWordFromCfg(318161009)
				local var_40_5 = arg_37_1:FormatText(var_40_4.content)

				arg_37_1.text_.text = var_40_5

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_6 = 33
				local var_40_7 = utf8.len(var_40_5)
				local var_40_8 = var_40_6 <= 0 and var_40_2 or var_40_2 * (var_40_7 / var_40_6)

				if var_40_8 > 0 and var_40_2 < var_40_8 then
					arg_37_1.talkMaxDuration = var_40_8

					if var_40_8 + var_40_1 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_8 + var_40_1
					end
				end

				arg_37_1.text_.text = var_40_5
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318161", "318161009", "story_v_out_318161.awb") ~= 0 then
					local var_40_9 = manager.audio:GetVoiceLength("story_v_out_318161", "318161009", "story_v_out_318161.awb") / 1000

					if var_40_9 + var_40_1 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_9 + var_40_1
					end

					if var_40_4.prefab_name ~= "" and arg_37_1.actors_[var_40_4.prefab_name] ~= nil then
						local var_40_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_4.prefab_name].transform, "story_v_out_318161", "318161009", "story_v_out_318161.awb")

						arg_37_1:RecordAudio("318161009", var_40_10)
						arg_37_1:RecordAudio("318161009", var_40_10)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_318161", "318161009", "story_v_out_318161.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_318161", "318161009", "story_v_out_318161.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_11 = math.max(var_40_2, arg_37_1.talkMaxDuration)

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_11 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_1) / var_40_11

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_1 + var_40_11 and arg_37_1.time_ < var_40_1 + var_40_11 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play318161010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 318161010
		arg_41_1.duration_ = 8.67

		local var_41_0 = {
			zh = 4.633,
			ja = 8.666
		}
		local var_41_1 = manager.audio:GetLocalizationFlag()

		if var_41_0[var_41_1] ~= nil then
			arg_41_1.duration_ = var_41_0[var_41_1]
		end

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play318161011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = arg_41_1.actors_["1019ui_story"]
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect1019ui_story == nil then
				arg_41_1.var_.characterEffect1019ui_story = var_44_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_2 = 0.200000002980232

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_2 and not isNil(var_44_0) then
				local var_44_3 = (arg_41_1.time_ - var_44_1) / var_44_2

				if arg_41_1.var_.characterEffect1019ui_story and not isNil(var_44_0) then
					arg_41_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= var_44_1 + var_44_2 and arg_41_1.time_ < var_44_1 + var_44_2 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect1019ui_story then
				arg_41_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_44_4 = arg_41_1.actors_["1028ui_story"]
			local var_44_5 = 0

			if var_44_5 < arg_41_1.time_ and arg_41_1.time_ <= var_44_5 + arg_44_0 and not isNil(var_44_4) and arg_41_1.var_.characterEffect1028ui_story == nil then
				arg_41_1.var_.characterEffect1028ui_story = var_44_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_6 = 0.200000002980232

			if var_44_5 <= arg_41_1.time_ and arg_41_1.time_ < var_44_5 + var_44_6 and not isNil(var_44_4) then
				local var_44_7 = (arg_41_1.time_ - var_44_5) / var_44_6

				if arg_41_1.var_.characterEffect1028ui_story and not isNil(var_44_4) then
					local var_44_8 = Mathf.Lerp(0, 0.5, var_44_7)

					arg_41_1.var_.characterEffect1028ui_story.fillFlat = true
					arg_41_1.var_.characterEffect1028ui_story.fillRatio = var_44_8
				end
			end

			if arg_41_1.time_ >= var_44_5 + var_44_6 and arg_41_1.time_ < var_44_5 + var_44_6 + arg_44_0 and not isNil(var_44_4) and arg_41_1.var_.characterEffect1028ui_story then
				local var_44_9 = 0.5

				arg_41_1.var_.characterEffect1028ui_story.fillFlat = true
				arg_41_1.var_.characterEffect1028ui_story.fillRatio = var_44_9
			end

			local var_44_10 = 0

			if var_44_10 < arg_41_1.time_ and arg_41_1.time_ <= var_44_10 + arg_44_0 then
				arg_41_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action5_2")
			end

			local var_44_11 = 0
			local var_44_12 = 0.675

			if var_44_11 < arg_41_1.time_ and arg_41_1.time_ <= var_44_11 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_13 = arg_41_1:FormatText(StoryNameCfg[13].name)

				arg_41_1.leftNameTxt_.text = var_44_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_14 = arg_41_1:GetWordFromCfg(318161010)
				local var_44_15 = arg_41_1:FormatText(var_44_14.content)

				arg_41_1.text_.text = var_44_15

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_16 = 27
				local var_44_17 = utf8.len(var_44_15)
				local var_44_18 = var_44_16 <= 0 and var_44_12 or var_44_12 * (var_44_17 / var_44_16)

				if var_44_18 > 0 and var_44_12 < var_44_18 then
					arg_41_1.talkMaxDuration = var_44_18

					if var_44_18 + var_44_11 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_18 + var_44_11
					end
				end

				arg_41_1.text_.text = var_44_15
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318161", "318161010", "story_v_out_318161.awb") ~= 0 then
					local var_44_19 = manager.audio:GetVoiceLength("story_v_out_318161", "318161010", "story_v_out_318161.awb") / 1000

					if var_44_19 + var_44_11 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_19 + var_44_11
					end

					if var_44_14.prefab_name ~= "" and arg_41_1.actors_[var_44_14.prefab_name] ~= nil then
						local var_44_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_14.prefab_name].transform, "story_v_out_318161", "318161010", "story_v_out_318161.awb")

						arg_41_1:RecordAudio("318161010", var_44_20)
						arg_41_1:RecordAudio("318161010", var_44_20)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_318161", "318161010", "story_v_out_318161.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_318161", "318161010", "story_v_out_318161.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_21 = math.max(var_44_12, arg_41_1.talkMaxDuration)

			if var_44_11 <= arg_41_1.time_ and arg_41_1.time_ < var_44_11 + var_44_21 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_11) / var_44_21

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_11 + var_44_21 and arg_41_1.time_ < var_44_11 + var_44_21 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play318161011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 318161011
		arg_45_1.duration_ = 8.13

		local var_45_0 = {
			zh = 3.3,
			ja = 8.133
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
				arg_45_0:Play318161012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = arg_45_1.actors_["1028ui_story"]
			local var_48_1 = 0

			if var_48_1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.characterEffect1028ui_story == nil then
				arg_45_1.var_.characterEffect1028ui_story = var_48_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_2 = 0.200000002980232

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_2 and not isNil(var_48_0) then
				local var_48_3 = (arg_45_1.time_ - var_48_1) / var_48_2

				if arg_45_1.var_.characterEffect1028ui_story and not isNil(var_48_0) then
					arg_45_1.var_.characterEffect1028ui_story.fillFlat = false
				end
			end

			if arg_45_1.time_ >= var_48_1 + var_48_2 and arg_45_1.time_ < var_48_1 + var_48_2 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.characterEffect1028ui_story then
				arg_45_1.var_.characterEffect1028ui_story.fillFlat = false
			end

			local var_48_4 = 0

			if var_48_4 < arg_45_1.time_ and arg_45_1.time_ <= var_48_4 + arg_48_0 then
				arg_45_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/story1028/story1028action/1028action6_2")
			end

			local var_48_5 = arg_45_1.actors_["1019ui_story"]
			local var_48_6 = 0

			if var_48_6 < arg_45_1.time_ and arg_45_1.time_ <= var_48_6 + arg_48_0 and not isNil(var_48_5) and arg_45_1.var_.characterEffect1019ui_story == nil then
				arg_45_1.var_.characterEffect1019ui_story = var_48_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_7 = 0.200000002980232

			if var_48_6 <= arg_45_1.time_ and arg_45_1.time_ < var_48_6 + var_48_7 and not isNil(var_48_5) then
				local var_48_8 = (arg_45_1.time_ - var_48_6) / var_48_7

				if arg_45_1.var_.characterEffect1019ui_story and not isNil(var_48_5) then
					local var_48_9 = Mathf.Lerp(0, 0.5, var_48_8)

					arg_45_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_45_1.var_.characterEffect1019ui_story.fillRatio = var_48_9
				end
			end

			if arg_45_1.time_ >= var_48_6 + var_48_7 and arg_45_1.time_ < var_48_6 + var_48_7 + arg_48_0 and not isNil(var_48_5) and arg_45_1.var_.characterEffect1019ui_story then
				local var_48_10 = 0.5

				arg_45_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_45_1.var_.characterEffect1019ui_story.fillRatio = var_48_10
			end

			local var_48_11 = 0
			local var_48_12 = 0.475

			if var_48_11 < arg_45_1.time_ and arg_45_1.time_ <= var_48_11 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_13 = arg_45_1:FormatText(StoryNameCfg[327].name)

				arg_45_1.leftNameTxt_.text = var_48_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_14 = arg_45_1:GetWordFromCfg(318161011)
				local var_48_15 = arg_45_1:FormatText(var_48_14.content)

				arg_45_1.text_.text = var_48_15

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_16 = 19
				local var_48_17 = utf8.len(var_48_15)
				local var_48_18 = var_48_16 <= 0 and var_48_12 or var_48_12 * (var_48_17 / var_48_16)

				if var_48_18 > 0 and var_48_12 < var_48_18 then
					arg_45_1.talkMaxDuration = var_48_18

					if var_48_18 + var_48_11 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_18 + var_48_11
					end
				end

				arg_45_1.text_.text = var_48_15
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318161", "318161011", "story_v_out_318161.awb") ~= 0 then
					local var_48_19 = manager.audio:GetVoiceLength("story_v_out_318161", "318161011", "story_v_out_318161.awb") / 1000

					if var_48_19 + var_48_11 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_19 + var_48_11
					end

					if var_48_14.prefab_name ~= "" and arg_45_1.actors_[var_48_14.prefab_name] ~= nil then
						local var_48_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_14.prefab_name].transform, "story_v_out_318161", "318161011", "story_v_out_318161.awb")

						arg_45_1:RecordAudio("318161011", var_48_20)
						arg_45_1:RecordAudio("318161011", var_48_20)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_318161", "318161011", "story_v_out_318161.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_318161", "318161011", "story_v_out_318161.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_21 = math.max(var_48_12, arg_45_1.talkMaxDuration)

			if var_48_11 <= arg_45_1.time_ and arg_45_1.time_ < var_48_11 + var_48_21 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_11) / var_48_21

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_11 + var_48_21 and arg_45_1.time_ < var_48_11 + var_48_21 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play318161012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 318161012
		arg_49_1.duration_ = 7.03

		local var_49_0 = {
			zh = 7.033,
			ja = 5.533
		}
		local var_49_1 = manager.audio:GetLocalizationFlag()

		if var_49_0[var_49_1] ~= nil then
			arg_49_1.duration_ = var_49_0[var_49_1]
		end

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play318161013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = arg_49_1.actors_["1028ui_story"]
			local var_52_1 = 0

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.characterEffect1028ui_story == nil then
				arg_49_1.var_.characterEffect1028ui_story = var_52_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_2 = 0.200000002980232

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_2 and not isNil(var_52_0) then
				local var_52_3 = (arg_49_1.time_ - var_52_1) / var_52_2

				if arg_49_1.var_.characterEffect1028ui_story and not isNil(var_52_0) then
					arg_49_1.var_.characterEffect1028ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= var_52_1 + var_52_2 and arg_49_1.time_ < var_52_1 + var_52_2 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.characterEffect1028ui_story then
				arg_49_1.var_.characterEffect1028ui_story.fillFlat = false
			end

			local var_52_4 = 0
			local var_52_5 = 0.875

			if var_52_4 < arg_49_1.time_ and arg_49_1.time_ <= var_52_4 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_6 = arg_49_1:FormatText(StoryNameCfg[327].name)

				arg_49_1.leftNameTxt_.text = var_52_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_7 = arg_49_1:GetWordFromCfg(318161012)
				local var_52_8 = arg_49_1:FormatText(var_52_7.content)

				arg_49_1.text_.text = var_52_8

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_9 = 35
				local var_52_10 = utf8.len(var_52_8)
				local var_52_11 = var_52_9 <= 0 and var_52_5 or var_52_5 * (var_52_10 / var_52_9)

				if var_52_11 > 0 and var_52_5 < var_52_11 then
					arg_49_1.talkMaxDuration = var_52_11

					if var_52_11 + var_52_4 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_11 + var_52_4
					end
				end

				arg_49_1.text_.text = var_52_8
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318161", "318161012", "story_v_out_318161.awb") ~= 0 then
					local var_52_12 = manager.audio:GetVoiceLength("story_v_out_318161", "318161012", "story_v_out_318161.awb") / 1000

					if var_52_12 + var_52_4 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_12 + var_52_4
					end

					if var_52_7.prefab_name ~= "" and arg_49_1.actors_[var_52_7.prefab_name] ~= nil then
						local var_52_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_7.prefab_name].transform, "story_v_out_318161", "318161012", "story_v_out_318161.awb")

						arg_49_1:RecordAudio("318161012", var_52_13)
						arg_49_1:RecordAudio("318161012", var_52_13)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_318161", "318161012", "story_v_out_318161.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_318161", "318161012", "story_v_out_318161.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_14 = math.max(var_52_5, arg_49_1.talkMaxDuration)

			if var_52_4 <= arg_49_1.time_ and arg_49_1.time_ < var_52_4 + var_52_14 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_4) / var_52_14

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_4 + var_52_14 and arg_49_1.time_ < var_52_4 + var_52_14 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play318161013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 318161013
		arg_53_1.duration_ = 10.57

		local var_53_0 = {
			zh = 9.866,
			ja = 10.566
		}
		local var_53_1 = manager.audio:GetLocalizationFlag()

		if var_53_0[var_53_1] ~= nil then
			arg_53_1.duration_ = var_53_0[var_53_1]
		end

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play318161014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = arg_53_1.actors_["1028ui_story"]
			local var_56_1 = 0

			if var_56_1 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 and not isNil(var_56_0) and arg_53_1.var_.characterEffect1028ui_story == nil then
				arg_53_1.var_.characterEffect1028ui_story = var_56_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_2 = 0.200000002980232

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_2 and not isNil(var_56_0) then
				local var_56_3 = (arg_53_1.time_ - var_56_1) / var_56_2

				if arg_53_1.var_.characterEffect1028ui_story and not isNil(var_56_0) then
					arg_53_1.var_.characterEffect1028ui_story.fillFlat = false
				end
			end

			if arg_53_1.time_ >= var_56_1 + var_56_2 and arg_53_1.time_ < var_56_1 + var_56_2 + arg_56_0 and not isNil(var_56_0) and arg_53_1.var_.characterEffect1028ui_story then
				arg_53_1.var_.characterEffect1028ui_story.fillFlat = false
			end

			local var_56_4 = 0
			local var_56_5 = 1.275

			if var_56_4 < arg_53_1.time_ and arg_53_1.time_ <= var_56_4 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_6 = arg_53_1:FormatText(StoryNameCfg[327].name)

				arg_53_1.leftNameTxt_.text = var_56_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_7 = arg_53_1:GetWordFromCfg(318161013)
				local var_56_8 = arg_53_1:FormatText(var_56_7.content)

				arg_53_1.text_.text = var_56_8

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_9 = 51
				local var_56_10 = utf8.len(var_56_8)
				local var_56_11 = var_56_9 <= 0 and var_56_5 or var_56_5 * (var_56_10 / var_56_9)

				if var_56_11 > 0 and var_56_5 < var_56_11 then
					arg_53_1.talkMaxDuration = var_56_11

					if var_56_11 + var_56_4 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_11 + var_56_4
					end
				end

				arg_53_1.text_.text = var_56_8
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318161", "318161013", "story_v_out_318161.awb") ~= 0 then
					local var_56_12 = manager.audio:GetVoiceLength("story_v_out_318161", "318161013", "story_v_out_318161.awb") / 1000

					if var_56_12 + var_56_4 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_12 + var_56_4
					end

					if var_56_7.prefab_name ~= "" and arg_53_1.actors_[var_56_7.prefab_name] ~= nil then
						local var_56_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_7.prefab_name].transform, "story_v_out_318161", "318161013", "story_v_out_318161.awb")

						arg_53_1:RecordAudio("318161013", var_56_13)
						arg_53_1:RecordAudio("318161013", var_56_13)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_318161", "318161013", "story_v_out_318161.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_318161", "318161013", "story_v_out_318161.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_14 = math.max(var_56_5, arg_53_1.talkMaxDuration)

			if var_56_4 <= arg_53_1.time_ and arg_53_1.time_ < var_56_4 + var_56_14 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_4) / var_56_14

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_4 + var_56_14 and arg_53_1.time_ < var_56_4 + var_56_14 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play318161014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 318161014
		arg_57_1.duration_ = 11.1

		local var_57_0 = {
			zh = 4.6,
			ja = 11.1
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
				arg_57_0:Play318161015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = arg_57_1.actors_["1028ui_story"]
			local var_60_1 = 0

			if var_60_1 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 and not isNil(var_60_0) and arg_57_1.var_.characterEffect1028ui_story == nil then
				arg_57_1.var_.characterEffect1028ui_story = var_60_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_2 = 0.200000002980232

			if var_60_1 <= arg_57_1.time_ and arg_57_1.time_ < var_60_1 + var_60_2 and not isNil(var_60_0) then
				local var_60_3 = (arg_57_1.time_ - var_60_1) / var_60_2

				if arg_57_1.var_.characterEffect1028ui_story and not isNil(var_60_0) then
					arg_57_1.var_.characterEffect1028ui_story.fillFlat = false
				end
			end

			if arg_57_1.time_ >= var_60_1 + var_60_2 and arg_57_1.time_ < var_60_1 + var_60_2 + arg_60_0 and not isNil(var_60_0) and arg_57_1.var_.characterEffect1028ui_story then
				arg_57_1.var_.characterEffect1028ui_story.fillFlat = false
			end

			local var_60_4 = 0
			local var_60_5 = 0.55

			if var_60_4 < arg_57_1.time_ and arg_57_1.time_ <= var_60_4 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_6 = arg_57_1:FormatText(StoryNameCfg[327].name)

				arg_57_1.leftNameTxt_.text = var_60_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_7 = arg_57_1:GetWordFromCfg(318161014)
				local var_60_8 = arg_57_1:FormatText(var_60_7.content)

				arg_57_1.text_.text = var_60_8

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_9 = 22
				local var_60_10 = utf8.len(var_60_8)
				local var_60_11 = var_60_9 <= 0 and var_60_5 or var_60_5 * (var_60_10 / var_60_9)

				if var_60_11 > 0 and var_60_5 < var_60_11 then
					arg_57_1.talkMaxDuration = var_60_11

					if var_60_11 + var_60_4 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_11 + var_60_4
					end
				end

				arg_57_1.text_.text = var_60_8
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318161", "318161014", "story_v_out_318161.awb") ~= 0 then
					local var_60_12 = manager.audio:GetVoiceLength("story_v_out_318161", "318161014", "story_v_out_318161.awb") / 1000

					if var_60_12 + var_60_4 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_12 + var_60_4
					end

					if var_60_7.prefab_name ~= "" and arg_57_1.actors_[var_60_7.prefab_name] ~= nil then
						local var_60_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_7.prefab_name].transform, "story_v_out_318161", "318161014", "story_v_out_318161.awb")

						arg_57_1:RecordAudio("318161014", var_60_13)
						arg_57_1:RecordAudio("318161014", var_60_13)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_318161", "318161014", "story_v_out_318161.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_318161", "318161014", "story_v_out_318161.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_14 = math.max(var_60_5, arg_57_1.talkMaxDuration)

			if var_60_4 <= arg_57_1.time_ and arg_57_1.time_ < var_60_4 + var_60_14 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_4) / var_60_14

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_4 + var_60_14 and arg_57_1.time_ < var_60_4 + var_60_14 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play318161015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 318161015
		arg_61_1.duration_ = 4.4

		local var_61_0 = {
			zh = 2.433,
			ja = 4.4
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
				arg_61_0:Play318161016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = arg_61_1.actors_["1019ui_story"]
			local var_64_1 = 0

			if var_64_1 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 and not isNil(var_64_0) and arg_61_1.var_.characterEffect1019ui_story == nil then
				arg_61_1.var_.characterEffect1019ui_story = var_64_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_2 = 0.200000002980232

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_2 and not isNil(var_64_0) then
				local var_64_3 = (arg_61_1.time_ - var_64_1) / var_64_2

				if arg_61_1.var_.characterEffect1019ui_story and not isNil(var_64_0) then
					arg_61_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_61_1.time_ >= var_64_1 + var_64_2 and arg_61_1.time_ < var_64_1 + var_64_2 + arg_64_0 and not isNil(var_64_0) and arg_61_1.var_.characterEffect1019ui_story then
				arg_61_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_64_4 = arg_61_1.actors_["1028ui_story"]
			local var_64_5 = 0

			if var_64_5 < arg_61_1.time_ and arg_61_1.time_ <= var_64_5 + arg_64_0 and not isNil(var_64_4) and arg_61_1.var_.characterEffect1028ui_story == nil then
				arg_61_1.var_.characterEffect1028ui_story = var_64_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_6 = 0.200000002980232

			if var_64_5 <= arg_61_1.time_ and arg_61_1.time_ < var_64_5 + var_64_6 and not isNil(var_64_4) then
				local var_64_7 = (arg_61_1.time_ - var_64_5) / var_64_6

				if arg_61_1.var_.characterEffect1028ui_story and not isNil(var_64_4) then
					local var_64_8 = Mathf.Lerp(0, 0.5, var_64_7)

					arg_61_1.var_.characterEffect1028ui_story.fillFlat = true
					arg_61_1.var_.characterEffect1028ui_story.fillRatio = var_64_8
				end
			end

			if arg_61_1.time_ >= var_64_5 + var_64_6 and arg_61_1.time_ < var_64_5 + var_64_6 + arg_64_0 and not isNil(var_64_4) and arg_61_1.var_.characterEffect1028ui_story then
				local var_64_9 = 0.5

				arg_61_1.var_.characterEffect1028ui_story.fillFlat = true
				arg_61_1.var_.characterEffect1028ui_story.fillRatio = var_64_9
			end

			local var_64_10 = 0
			local var_64_11 = 0.35

			if var_64_10 < arg_61_1.time_ and arg_61_1.time_ <= var_64_10 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_12 = arg_61_1:FormatText(StoryNameCfg[13].name)

				arg_61_1.leftNameTxt_.text = var_64_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_13 = arg_61_1:GetWordFromCfg(318161015)
				local var_64_14 = arg_61_1:FormatText(var_64_13.content)

				arg_61_1.text_.text = var_64_14

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_15 = 14
				local var_64_16 = utf8.len(var_64_14)
				local var_64_17 = var_64_15 <= 0 and var_64_11 or var_64_11 * (var_64_16 / var_64_15)

				if var_64_17 > 0 and var_64_11 < var_64_17 then
					arg_61_1.talkMaxDuration = var_64_17

					if var_64_17 + var_64_10 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_17 + var_64_10
					end
				end

				arg_61_1.text_.text = var_64_14
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318161", "318161015", "story_v_out_318161.awb") ~= 0 then
					local var_64_18 = manager.audio:GetVoiceLength("story_v_out_318161", "318161015", "story_v_out_318161.awb") / 1000

					if var_64_18 + var_64_10 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_18 + var_64_10
					end

					if var_64_13.prefab_name ~= "" and arg_61_1.actors_[var_64_13.prefab_name] ~= nil then
						local var_64_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_13.prefab_name].transform, "story_v_out_318161", "318161015", "story_v_out_318161.awb")

						arg_61_1:RecordAudio("318161015", var_64_19)
						arg_61_1:RecordAudio("318161015", var_64_19)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_318161", "318161015", "story_v_out_318161.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_318161", "318161015", "story_v_out_318161.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_20 = math.max(var_64_11, arg_61_1.talkMaxDuration)

			if var_64_10 <= arg_61_1.time_ and arg_61_1.time_ < var_64_10 + var_64_20 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_10) / var_64_20

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_10 + var_64_20 and arg_61_1.time_ < var_64_10 + var_64_20 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play318161016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 318161016
		arg_65_1.duration_ = 8.4

		local var_65_0 = {
			zh = 5.066,
			ja = 8.4
		}
		local var_65_1 = manager.audio:GetLocalizationFlag()

		if var_65_0[var_65_1] ~= nil then
			arg_65_1.duration_ = var_65_0[var_65_1]
		end

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play318161017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = arg_65_1.actors_["1028ui_story"]
			local var_68_1 = 0

			if var_68_1 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.characterEffect1028ui_story == nil then
				arg_65_1.var_.characterEffect1028ui_story = var_68_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_2 = 0.200000002980232

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_2 and not isNil(var_68_0) then
				local var_68_3 = (arg_65_1.time_ - var_68_1) / var_68_2

				if arg_65_1.var_.characterEffect1028ui_story and not isNil(var_68_0) then
					arg_65_1.var_.characterEffect1028ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= var_68_1 + var_68_2 and arg_65_1.time_ < var_68_1 + var_68_2 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.characterEffect1028ui_story then
				arg_65_1.var_.characterEffect1028ui_story.fillFlat = false
			end

			local var_68_4 = arg_65_1.actors_["1019ui_story"]
			local var_68_5 = 0

			if var_68_5 < arg_65_1.time_ and arg_65_1.time_ <= var_68_5 + arg_68_0 and not isNil(var_68_4) and arg_65_1.var_.characterEffect1019ui_story == nil then
				arg_65_1.var_.characterEffect1019ui_story = var_68_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_6 = 0.200000002980232

			if var_68_5 <= arg_65_1.time_ and arg_65_1.time_ < var_68_5 + var_68_6 and not isNil(var_68_4) then
				local var_68_7 = (arg_65_1.time_ - var_68_5) / var_68_6

				if arg_65_1.var_.characterEffect1019ui_story and not isNil(var_68_4) then
					local var_68_8 = Mathf.Lerp(0, 0.5, var_68_7)

					arg_65_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_65_1.var_.characterEffect1019ui_story.fillRatio = var_68_8
				end
			end

			if arg_65_1.time_ >= var_68_5 + var_68_6 and arg_65_1.time_ < var_68_5 + var_68_6 + arg_68_0 and not isNil(var_68_4) and arg_65_1.var_.characterEffect1019ui_story then
				local var_68_9 = 0.5

				arg_65_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_65_1.var_.characterEffect1019ui_story.fillRatio = var_68_9
			end

			local var_68_10 = 0

			if var_68_10 < arg_65_1.time_ and arg_65_1.time_ <= var_68_10 + arg_68_0 then
				arg_65_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/story1028/story1028action/1028action5_1")
			end

			local var_68_11 = 0

			if var_68_11 < arg_65_1.time_ and arg_65_1.time_ <= var_68_11 + arg_68_0 then
				arg_65_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_68_12 = 0
			local var_68_13 = 0.675

			if var_68_12 < arg_65_1.time_ and arg_65_1.time_ <= var_68_12 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_14 = arg_65_1:FormatText(StoryNameCfg[327].name)

				arg_65_1.leftNameTxt_.text = var_68_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_15 = arg_65_1:GetWordFromCfg(318161016)
				local var_68_16 = arg_65_1:FormatText(var_68_15.content)

				arg_65_1.text_.text = var_68_16

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_17 = 27
				local var_68_18 = utf8.len(var_68_16)
				local var_68_19 = var_68_17 <= 0 and var_68_13 or var_68_13 * (var_68_18 / var_68_17)

				if var_68_19 > 0 and var_68_13 < var_68_19 then
					arg_65_1.talkMaxDuration = var_68_19

					if var_68_19 + var_68_12 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_19 + var_68_12
					end
				end

				arg_65_1.text_.text = var_68_16
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318161", "318161016", "story_v_out_318161.awb") ~= 0 then
					local var_68_20 = manager.audio:GetVoiceLength("story_v_out_318161", "318161016", "story_v_out_318161.awb") / 1000

					if var_68_20 + var_68_12 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_20 + var_68_12
					end

					if var_68_15.prefab_name ~= "" and arg_65_1.actors_[var_68_15.prefab_name] ~= nil then
						local var_68_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_15.prefab_name].transform, "story_v_out_318161", "318161016", "story_v_out_318161.awb")

						arg_65_1:RecordAudio("318161016", var_68_21)
						arg_65_1:RecordAudio("318161016", var_68_21)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_318161", "318161016", "story_v_out_318161.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_318161", "318161016", "story_v_out_318161.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_22 = math.max(var_68_13, arg_65_1.talkMaxDuration)

			if var_68_12 <= arg_65_1.time_ and arg_65_1.time_ < var_68_12 + var_68_22 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_12) / var_68_22

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_12 + var_68_22 and arg_65_1.time_ < var_68_12 + var_68_22 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play318161017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 318161017
		arg_69_1.duration_ = 2

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play318161018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = arg_69_1.actors_["1019ui_story"]
			local var_72_1 = 0

			if var_72_1 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 and not isNil(var_72_0) and arg_69_1.var_.characterEffect1019ui_story == nil then
				arg_69_1.var_.characterEffect1019ui_story = var_72_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_2 = 0.200000002980232

			if var_72_1 <= arg_69_1.time_ and arg_69_1.time_ < var_72_1 + var_72_2 and not isNil(var_72_0) then
				local var_72_3 = (arg_69_1.time_ - var_72_1) / var_72_2

				if arg_69_1.var_.characterEffect1019ui_story and not isNil(var_72_0) then
					arg_69_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_69_1.time_ >= var_72_1 + var_72_2 and arg_69_1.time_ < var_72_1 + var_72_2 + arg_72_0 and not isNil(var_72_0) and arg_69_1.var_.characterEffect1019ui_story then
				arg_69_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_72_4 = 0

			if var_72_4 < arg_69_1.time_ and arg_69_1.time_ <= var_72_4 + arg_72_0 then
				arg_69_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action2_1")
			end

			local var_72_5 = 0

			if var_72_5 < arg_69_1.time_ and arg_69_1.time_ <= var_72_5 + arg_72_0 then
				arg_69_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_72_6 = arg_69_1.actors_["1028ui_story"]
			local var_72_7 = 0

			if var_72_7 < arg_69_1.time_ and arg_69_1.time_ <= var_72_7 + arg_72_0 and not isNil(var_72_6) and arg_69_1.var_.characterEffect1028ui_story == nil then
				arg_69_1.var_.characterEffect1028ui_story = var_72_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_8 = 0.200000002980232

			if var_72_7 <= arg_69_1.time_ and arg_69_1.time_ < var_72_7 + var_72_8 and not isNil(var_72_6) then
				local var_72_9 = (arg_69_1.time_ - var_72_7) / var_72_8

				if arg_69_1.var_.characterEffect1028ui_story and not isNil(var_72_6) then
					local var_72_10 = Mathf.Lerp(0, 0.5, var_72_9)

					arg_69_1.var_.characterEffect1028ui_story.fillFlat = true
					arg_69_1.var_.characterEffect1028ui_story.fillRatio = var_72_10
				end
			end

			if arg_69_1.time_ >= var_72_7 + var_72_8 and arg_69_1.time_ < var_72_7 + var_72_8 + arg_72_0 and not isNil(var_72_6) and arg_69_1.var_.characterEffect1028ui_story then
				local var_72_11 = 0.5

				arg_69_1.var_.characterEffect1028ui_story.fillFlat = true
				arg_69_1.var_.characterEffect1028ui_story.fillRatio = var_72_11
			end

			local var_72_12 = 0
			local var_72_13 = 0.075

			if var_72_12 < arg_69_1.time_ and arg_69_1.time_ <= var_72_12 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_14 = arg_69_1:FormatText(StoryNameCfg[13].name)

				arg_69_1.leftNameTxt_.text = var_72_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_15 = arg_69_1:GetWordFromCfg(318161017)
				local var_72_16 = arg_69_1:FormatText(var_72_15.content)

				arg_69_1.text_.text = var_72_16

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_17 = 3
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

				if manager.audio:GetVoiceLength("story_v_out_318161", "318161017", "story_v_out_318161.awb") ~= 0 then
					local var_72_20 = manager.audio:GetVoiceLength("story_v_out_318161", "318161017", "story_v_out_318161.awb") / 1000

					if var_72_20 + var_72_12 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_20 + var_72_12
					end

					if var_72_15.prefab_name ~= "" and arg_69_1.actors_[var_72_15.prefab_name] ~= nil then
						local var_72_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_15.prefab_name].transform, "story_v_out_318161", "318161017", "story_v_out_318161.awb")

						arg_69_1:RecordAudio("318161017", var_72_21)
						arg_69_1:RecordAudio("318161017", var_72_21)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_318161", "318161017", "story_v_out_318161.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_318161", "318161017", "story_v_out_318161.awb")
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
	Play318161018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 318161018
		arg_73_1.duration_ = 4.5

		local var_73_0 = {
			zh = 4.5,
			ja = 2.5
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
				arg_73_0:Play318161019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = arg_73_1.actors_["1028ui_story"]
			local var_76_1 = 0

			if var_76_1 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 and not isNil(var_76_0) and arg_73_1.var_.characterEffect1028ui_story == nil then
				arg_73_1.var_.characterEffect1028ui_story = var_76_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_2 = 0.200000002980232

			if var_76_1 <= arg_73_1.time_ and arg_73_1.time_ < var_76_1 + var_76_2 and not isNil(var_76_0) then
				local var_76_3 = (arg_73_1.time_ - var_76_1) / var_76_2

				if arg_73_1.var_.characterEffect1028ui_story and not isNil(var_76_0) then
					arg_73_1.var_.characterEffect1028ui_story.fillFlat = false
				end
			end

			if arg_73_1.time_ >= var_76_1 + var_76_2 and arg_73_1.time_ < var_76_1 + var_76_2 + arg_76_0 and not isNil(var_76_0) and arg_73_1.var_.characterEffect1028ui_story then
				arg_73_1.var_.characterEffect1028ui_story.fillFlat = false
			end

			local var_76_4 = 0

			if var_76_4 < arg_73_1.time_ and arg_73_1.time_ <= var_76_4 + arg_76_0 then
				arg_73_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_76_5 = arg_73_1.actors_["1019ui_story"]
			local var_76_6 = 0

			if var_76_6 < arg_73_1.time_ and arg_73_1.time_ <= var_76_6 + arg_76_0 and not isNil(var_76_5) and arg_73_1.var_.characterEffect1019ui_story == nil then
				arg_73_1.var_.characterEffect1019ui_story = var_76_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_7 = 0.200000002980232

			if var_76_6 <= arg_73_1.time_ and arg_73_1.time_ < var_76_6 + var_76_7 and not isNil(var_76_5) then
				local var_76_8 = (arg_73_1.time_ - var_76_6) / var_76_7

				if arg_73_1.var_.characterEffect1019ui_story and not isNil(var_76_5) then
					local var_76_9 = Mathf.Lerp(0, 0.5, var_76_8)

					arg_73_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_73_1.var_.characterEffect1019ui_story.fillRatio = var_76_9
				end
			end

			if arg_73_1.time_ >= var_76_6 + var_76_7 and arg_73_1.time_ < var_76_6 + var_76_7 + arg_76_0 and not isNil(var_76_5) and arg_73_1.var_.characterEffect1019ui_story then
				local var_76_10 = 0.5

				arg_73_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_73_1.var_.characterEffect1019ui_story.fillRatio = var_76_10
			end

			local var_76_11 = 0
			local var_76_12 = 0.35

			if var_76_11 < arg_73_1.time_ and arg_73_1.time_ <= var_76_11 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				local var_76_13 = arg_73_1:FormatText(StoryNameCfg[327].name)

				arg_73_1.leftNameTxt_.text = var_76_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_14 = arg_73_1:GetWordFromCfg(318161018)
				local var_76_15 = arg_73_1:FormatText(var_76_14.content)

				arg_73_1.text_.text = var_76_15

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_16 = 14
				local var_76_17 = utf8.len(var_76_15)
				local var_76_18 = var_76_16 <= 0 and var_76_12 or var_76_12 * (var_76_17 / var_76_16)

				if var_76_18 > 0 and var_76_12 < var_76_18 then
					arg_73_1.talkMaxDuration = var_76_18

					if var_76_18 + var_76_11 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_18 + var_76_11
					end
				end

				arg_73_1.text_.text = var_76_15
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318161", "318161018", "story_v_out_318161.awb") ~= 0 then
					local var_76_19 = manager.audio:GetVoiceLength("story_v_out_318161", "318161018", "story_v_out_318161.awb") / 1000

					if var_76_19 + var_76_11 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_19 + var_76_11
					end

					if var_76_14.prefab_name ~= "" and arg_73_1.actors_[var_76_14.prefab_name] ~= nil then
						local var_76_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_14.prefab_name].transform, "story_v_out_318161", "318161018", "story_v_out_318161.awb")

						arg_73_1:RecordAudio("318161018", var_76_20)
						arg_73_1:RecordAudio("318161018", var_76_20)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_318161", "318161018", "story_v_out_318161.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_318161", "318161018", "story_v_out_318161.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_21 = math.max(var_76_12, arg_73_1.talkMaxDuration)

			if var_76_11 <= arg_73_1.time_ and arg_73_1.time_ < var_76_11 + var_76_21 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_11) / var_76_21

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_11 + var_76_21 and arg_73_1.time_ < var_76_11 + var_76_21 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play318161019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 318161019
		arg_77_1.duration_ = 12.1

		local var_77_0 = {
			zh = 7.2,
			ja = 12.1
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
				arg_77_0:Play318161020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = arg_77_1.actors_["1019ui_story"]
			local var_80_1 = 0

			if var_80_1 < arg_77_1.time_ and arg_77_1.time_ <= var_80_1 + arg_80_0 and not isNil(var_80_0) and arg_77_1.var_.characterEffect1019ui_story == nil then
				arg_77_1.var_.characterEffect1019ui_story = var_80_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_2 = 0.200000002980232

			if var_80_1 <= arg_77_1.time_ and arg_77_1.time_ < var_80_1 + var_80_2 and not isNil(var_80_0) then
				local var_80_3 = (arg_77_1.time_ - var_80_1) / var_80_2

				if arg_77_1.var_.characterEffect1019ui_story and not isNil(var_80_0) then
					arg_77_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_77_1.time_ >= var_80_1 + var_80_2 and arg_77_1.time_ < var_80_1 + var_80_2 + arg_80_0 and not isNil(var_80_0) and arg_77_1.var_.characterEffect1019ui_story then
				arg_77_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_80_4 = arg_77_1.actors_["1028ui_story"]
			local var_80_5 = 0

			if var_80_5 < arg_77_1.time_ and arg_77_1.time_ <= var_80_5 + arg_80_0 and not isNil(var_80_4) and arg_77_1.var_.characterEffect1028ui_story == nil then
				arg_77_1.var_.characterEffect1028ui_story = var_80_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_6 = 0.200000002980232

			if var_80_5 <= arg_77_1.time_ and arg_77_1.time_ < var_80_5 + var_80_6 and not isNil(var_80_4) then
				local var_80_7 = (arg_77_1.time_ - var_80_5) / var_80_6

				if arg_77_1.var_.characterEffect1028ui_story and not isNil(var_80_4) then
					local var_80_8 = Mathf.Lerp(0, 0.5, var_80_7)

					arg_77_1.var_.characterEffect1028ui_story.fillFlat = true
					arg_77_1.var_.characterEffect1028ui_story.fillRatio = var_80_8
				end
			end

			if arg_77_1.time_ >= var_80_5 + var_80_6 and arg_77_1.time_ < var_80_5 + var_80_6 + arg_80_0 and not isNil(var_80_4) and arg_77_1.var_.characterEffect1028ui_story then
				local var_80_9 = 0.5

				arg_77_1.var_.characterEffect1028ui_story.fillFlat = true
				arg_77_1.var_.characterEffect1028ui_story.fillRatio = var_80_9
			end

			local var_80_10 = 0
			local var_80_11 = 0.775

			if var_80_10 < arg_77_1.time_ and arg_77_1.time_ <= var_80_10 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				local var_80_12 = arg_77_1:FormatText(StoryNameCfg[13].name)

				arg_77_1.leftNameTxt_.text = var_80_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_13 = arg_77_1:GetWordFromCfg(318161019)
				local var_80_14 = arg_77_1:FormatText(var_80_13.content)

				arg_77_1.text_.text = var_80_14

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_15 = 31
				local var_80_16 = utf8.len(var_80_14)
				local var_80_17 = var_80_15 <= 0 and var_80_11 or var_80_11 * (var_80_16 / var_80_15)

				if var_80_17 > 0 and var_80_11 < var_80_17 then
					arg_77_1.talkMaxDuration = var_80_17

					if var_80_17 + var_80_10 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_17 + var_80_10
					end
				end

				arg_77_1.text_.text = var_80_14
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318161", "318161019", "story_v_out_318161.awb") ~= 0 then
					local var_80_18 = manager.audio:GetVoiceLength("story_v_out_318161", "318161019", "story_v_out_318161.awb") / 1000

					if var_80_18 + var_80_10 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_18 + var_80_10
					end

					if var_80_13.prefab_name ~= "" and arg_77_1.actors_[var_80_13.prefab_name] ~= nil then
						local var_80_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_13.prefab_name].transform, "story_v_out_318161", "318161019", "story_v_out_318161.awb")

						arg_77_1:RecordAudio("318161019", var_80_19)
						arg_77_1:RecordAudio("318161019", var_80_19)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_318161", "318161019", "story_v_out_318161.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_318161", "318161019", "story_v_out_318161.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_20 = math.max(var_80_11, arg_77_1.talkMaxDuration)

			if var_80_10 <= arg_77_1.time_ and arg_77_1.time_ < var_80_10 + var_80_20 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_10) / var_80_20

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_10 + var_80_20 and arg_77_1.time_ < var_80_10 + var_80_20 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play318161020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 318161020
		arg_81_1.duration_ = 6.47

		local var_81_0 = {
			zh = 2.6,
			ja = 6.466
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
				arg_81_0:Play318161021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = arg_81_1.actors_["1019ui_story"]
			local var_84_1 = 0

			if var_84_1 < arg_81_1.time_ and arg_81_1.time_ <= var_84_1 + arg_84_0 and not isNil(var_84_0) and arg_81_1.var_.characterEffect1019ui_story == nil then
				arg_81_1.var_.characterEffect1019ui_story = var_84_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_2 = 0.200000002980232

			if var_84_1 <= arg_81_1.time_ and arg_81_1.time_ < var_84_1 + var_84_2 and not isNil(var_84_0) then
				local var_84_3 = (arg_81_1.time_ - var_84_1) / var_84_2

				if arg_81_1.var_.characterEffect1019ui_story and not isNil(var_84_0) then
					arg_81_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_81_1.time_ >= var_84_1 + var_84_2 and arg_81_1.time_ < var_84_1 + var_84_2 + arg_84_0 and not isNil(var_84_0) and arg_81_1.var_.characterEffect1019ui_story then
				arg_81_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_84_4 = 0
			local var_84_5 = 0.35

			if var_84_4 < arg_81_1.time_ and arg_81_1.time_ <= var_84_4 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				local var_84_6 = arg_81_1:FormatText(StoryNameCfg[13].name)

				arg_81_1.leftNameTxt_.text = var_84_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_7 = arg_81_1:GetWordFromCfg(318161020)
				local var_84_8 = arg_81_1:FormatText(var_84_7.content)

				arg_81_1.text_.text = var_84_8

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_9 = 14
				local var_84_10 = utf8.len(var_84_8)
				local var_84_11 = var_84_9 <= 0 and var_84_5 or var_84_5 * (var_84_10 / var_84_9)

				if var_84_11 > 0 and var_84_5 < var_84_11 then
					arg_81_1.talkMaxDuration = var_84_11

					if var_84_11 + var_84_4 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_11 + var_84_4
					end
				end

				arg_81_1.text_.text = var_84_8
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318161", "318161020", "story_v_out_318161.awb") ~= 0 then
					local var_84_12 = manager.audio:GetVoiceLength("story_v_out_318161", "318161020", "story_v_out_318161.awb") / 1000

					if var_84_12 + var_84_4 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_12 + var_84_4
					end

					if var_84_7.prefab_name ~= "" and arg_81_1.actors_[var_84_7.prefab_name] ~= nil then
						local var_84_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_7.prefab_name].transform, "story_v_out_318161", "318161020", "story_v_out_318161.awb")

						arg_81_1:RecordAudio("318161020", var_84_13)
						arg_81_1:RecordAudio("318161020", var_84_13)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_318161", "318161020", "story_v_out_318161.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_318161", "318161020", "story_v_out_318161.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_14 = math.max(var_84_5, arg_81_1.talkMaxDuration)

			if var_84_4 <= arg_81_1.time_ and arg_81_1.time_ < var_84_4 + var_84_14 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_4) / var_84_14

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_4 + var_84_14 and arg_81_1.time_ < var_84_4 + var_84_14 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play318161021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 318161021
		arg_85_1.duration_ = 5

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play318161022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = arg_85_1.actors_["1019ui_story"]
			local var_88_1 = 0

			if var_88_1 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 and not isNil(var_88_0) and arg_85_1.var_.characterEffect1019ui_story == nil then
				arg_85_1.var_.characterEffect1019ui_story = var_88_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_2 = 0.200000002980232

			if var_88_1 <= arg_85_1.time_ and arg_85_1.time_ < var_88_1 + var_88_2 and not isNil(var_88_0) then
				local var_88_3 = (arg_85_1.time_ - var_88_1) / var_88_2

				if arg_85_1.var_.characterEffect1019ui_story and not isNil(var_88_0) then
					local var_88_4 = Mathf.Lerp(0, 0.5, var_88_3)

					arg_85_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_85_1.var_.characterEffect1019ui_story.fillRatio = var_88_4
				end
			end

			if arg_85_1.time_ >= var_88_1 + var_88_2 and arg_85_1.time_ < var_88_1 + var_88_2 + arg_88_0 and not isNil(var_88_0) and arg_85_1.var_.characterEffect1019ui_story then
				local var_88_5 = 0.5

				arg_85_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_85_1.var_.characterEffect1019ui_story.fillRatio = var_88_5
			end

			local var_88_6 = 0

			if var_88_6 < arg_85_1.time_ and arg_85_1.time_ <= var_88_6 + arg_88_0 then
				arg_85_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/story1028/story1028action/1028action5_2")
			end

			local var_88_7 = 0

			if var_88_7 < arg_85_1.time_ and arg_85_1.time_ <= var_88_7 + arg_88_0 then
				arg_85_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_88_8 = 0
			local var_88_9 = 1.3

			if var_88_8 < arg_85_1.time_ and arg_85_1.time_ <= var_88_8 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, false)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_10 = arg_85_1:GetWordFromCfg(318161021)
				local var_88_11 = arg_85_1:FormatText(var_88_10.content)

				arg_85_1.text_.text = var_88_11

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_12 = 52
				local var_88_13 = utf8.len(var_88_11)
				local var_88_14 = var_88_12 <= 0 and var_88_9 or var_88_9 * (var_88_13 / var_88_12)

				if var_88_14 > 0 and var_88_9 < var_88_14 then
					arg_85_1.talkMaxDuration = var_88_14

					if var_88_14 + var_88_8 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_14 + var_88_8
					end
				end

				arg_85_1.text_.text = var_88_11
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)
				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_15 = math.max(var_88_9, arg_85_1.talkMaxDuration)

			if var_88_8 <= arg_85_1.time_ and arg_85_1.time_ < var_88_8 + var_88_15 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_8) / var_88_15

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_8 + var_88_15 and arg_85_1.time_ < var_88_8 + var_88_15 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play318161022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 318161022
		arg_89_1.duration_ = 5.33

		local var_89_0 = {
			zh = 5.333,
			ja = 4.766
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
				arg_89_0:Play318161023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = arg_89_1.actors_["1028ui_story"]
			local var_92_1 = 0

			if var_92_1 < arg_89_1.time_ and arg_89_1.time_ <= var_92_1 + arg_92_0 and not isNil(var_92_0) and arg_89_1.var_.characterEffect1028ui_story == nil then
				arg_89_1.var_.characterEffect1028ui_story = var_92_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_2 = 0.200000002980232

			if var_92_1 <= arg_89_1.time_ and arg_89_1.time_ < var_92_1 + var_92_2 and not isNil(var_92_0) then
				local var_92_3 = (arg_89_1.time_ - var_92_1) / var_92_2

				if arg_89_1.var_.characterEffect1028ui_story and not isNil(var_92_0) then
					arg_89_1.var_.characterEffect1028ui_story.fillFlat = false
				end
			end

			if arg_89_1.time_ >= var_92_1 + var_92_2 and arg_89_1.time_ < var_92_1 + var_92_2 + arg_92_0 and not isNil(var_92_0) and arg_89_1.var_.characterEffect1028ui_story then
				arg_89_1.var_.characterEffect1028ui_story.fillFlat = false
			end

			local var_92_4 = 0

			if var_92_4 < arg_89_1.time_ and arg_89_1.time_ <= var_92_4 + arg_92_0 then
				arg_89_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_92_5 = 0
			local var_92_6 = 0.6

			if var_92_5 < arg_89_1.time_ and arg_89_1.time_ <= var_92_5 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				local var_92_7 = arg_89_1:FormatText(StoryNameCfg[327].name)

				arg_89_1.leftNameTxt_.text = var_92_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_8 = arg_89_1:GetWordFromCfg(318161022)
				local var_92_9 = arg_89_1:FormatText(var_92_8.content)

				arg_89_1.text_.text = var_92_9

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_10 = 24
				local var_92_11 = utf8.len(var_92_9)
				local var_92_12 = var_92_10 <= 0 and var_92_6 or var_92_6 * (var_92_11 / var_92_10)

				if var_92_12 > 0 and var_92_6 < var_92_12 then
					arg_89_1.talkMaxDuration = var_92_12

					if var_92_12 + var_92_5 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_12 + var_92_5
					end
				end

				arg_89_1.text_.text = var_92_9
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318161", "318161022", "story_v_out_318161.awb") ~= 0 then
					local var_92_13 = manager.audio:GetVoiceLength("story_v_out_318161", "318161022", "story_v_out_318161.awb") / 1000

					if var_92_13 + var_92_5 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_13 + var_92_5
					end

					if var_92_8.prefab_name ~= "" and arg_89_1.actors_[var_92_8.prefab_name] ~= nil then
						local var_92_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_8.prefab_name].transform, "story_v_out_318161", "318161022", "story_v_out_318161.awb")

						arg_89_1:RecordAudio("318161022", var_92_14)
						arg_89_1:RecordAudio("318161022", var_92_14)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_318161", "318161022", "story_v_out_318161.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_318161", "318161022", "story_v_out_318161.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_15 = math.max(var_92_6, arg_89_1.talkMaxDuration)

			if var_92_5 <= arg_89_1.time_ and arg_89_1.time_ < var_92_5 + var_92_15 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_5) / var_92_15

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_5 + var_92_15 and arg_89_1.time_ < var_92_5 + var_92_15 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play318161023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 318161023
		arg_93_1.duration_ = 7.37

		local var_93_0 = {
			zh = 5.466,
			ja = 7.366
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
				arg_93_0:Play318161024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = arg_93_1.actors_["1019ui_story"]
			local var_96_1 = 0

			if var_96_1 < arg_93_1.time_ and arg_93_1.time_ <= var_96_1 + arg_96_0 and not isNil(var_96_0) and arg_93_1.var_.characterEffect1019ui_story == nil then
				arg_93_1.var_.characterEffect1019ui_story = var_96_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_2 = 0.200000002980232

			if var_96_1 <= arg_93_1.time_ and arg_93_1.time_ < var_96_1 + var_96_2 and not isNil(var_96_0) then
				local var_96_3 = (arg_93_1.time_ - var_96_1) / var_96_2

				if arg_93_1.var_.characterEffect1019ui_story and not isNil(var_96_0) then
					arg_93_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_93_1.time_ >= var_96_1 + var_96_2 and arg_93_1.time_ < var_96_1 + var_96_2 + arg_96_0 and not isNil(var_96_0) and arg_93_1.var_.characterEffect1019ui_story then
				arg_93_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_96_4 = 0

			if var_96_4 < arg_93_1.time_ and arg_93_1.time_ <= var_96_4 + arg_96_0 then
				arg_93_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_96_5 = arg_93_1.actors_["1028ui_story"]
			local var_96_6 = 0

			if var_96_6 < arg_93_1.time_ and arg_93_1.time_ <= var_96_6 + arg_96_0 and not isNil(var_96_5) and arg_93_1.var_.characterEffect1028ui_story == nil then
				arg_93_1.var_.characterEffect1028ui_story = var_96_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_7 = 0.200000002980232

			if var_96_6 <= arg_93_1.time_ and arg_93_1.time_ < var_96_6 + var_96_7 and not isNil(var_96_5) then
				local var_96_8 = (arg_93_1.time_ - var_96_6) / var_96_7

				if arg_93_1.var_.characterEffect1028ui_story and not isNil(var_96_5) then
					local var_96_9 = Mathf.Lerp(0, 0.5, var_96_8)

					arg_93_1.var_.characterEffect1028ui_story.fillFlat = true
					arg_93_1.var_.characterEffect1028ui_story.fillRatio = var_96_9
				end
			end

			if arg_93_1.time_ >= var_96_6 + var_96_7 and arg_93_1.time_ < var_96_6 + var_96_7 + arg_96_0 and not isNil(var_96_5) and arg_93_1.var_.characterEffect1028ui_story then
				local var_96_10 = 0.5

				arg_93_1.var_.characterEffect1028ui_story.fillFlat = true
				arg_93_1.var_.characterEffect1028ui_story.fillRatio = var_96_10
			end

			local var_96_11 = 0
			local var_96_12 = 0.6

			if var_96_11 < arg_93_1.time_ and arg_93_1.time_ <= var_96_11 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				local var_96_13 = arg_93_1:FormatText(StoryNameCfg[13].name)

				arg_93_1.leftNameTxt_.text = var_96_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_14 = arg_93_1:GetWordFromCfg(318161023)
				local var_96_15 = arg_93_1:FormatText(var_96_14.content)

				arg_93_1.text_.text = var_96_15

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_16 = 24
				local var_96_17 = utf8.len(var_96_15)
				local var_96_18 = var_96_16 <= 0 and var_96_12 or var_96_12 * (var_96_17 / var_96_16)

				if var_96_18 > 0 and var_96_12 < var_96_18 then
					arg_93_1.talkMaxDuration = var_96_18

					if var_96_18 + var_96_11 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_18 + var_96_11
					end
				end

				arg_93_1.text_.text = var_96_15
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318161", "318161023", "story_v_out_318161.awb") ~= 0 then
					local var_96_19 = manager.audio:GetVoiceLength("story_v_out_318161", "318161023", "story_v_out_318161.awb") / 1000

					if var_96_19 + var_96_11 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_19 + var_96_11
					end

					if var_96_14.prefab_name ~= "" and arg_93_1.actors_[var_96_14.prefab_name] ~= nil then
						local var_96_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_14.prefab_name].transform, "story_v_out_318161", "318161023", "story_v_out_318161.awb")

						arg_93_1:RecordAudio("318161023", var_96_20)
						arg_93_1:RecordAudio("318161023", var_96_20)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_318161", "318161023", "story_v_out_318161.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_318161", "318161023", "story_v_out_318161.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_21 = math.max(var_96_12, arg_93_1.talkMaxDuration)

			if var_96_11 <= arg_93_1.time_ and arg_93_1.time_ < var_96_11 + var_96_21 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_11) / var_96_21

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_11 + var_96_21 and arg_93_1.time_ < var_96_11 + var_96_21 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play318161024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 318161024
		arg_97_1.duration_ = 8.6

		local var_97_0 = {
			zh = 8.6,
			ja = 5.833
		}
		local var_97_1 = manager.audio:GetLocalizationFlag()

		if var_97_0[var_97_1] ~= nil then
			arg_97_1.duration_ = var_97_0[var_97_1]
		end

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play318161025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = 0
			local var_100_1 = 1.15

			if var_100_0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_0 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				local var_100_2 = arg_97_1:FormatText(StoryNameCfg[13].name)

				arg_97_1.leftNameTxt_.text = var_100_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_3 = arg_97_1:GetWordFromCfg(318161024)
				local var_100_4 = arg_97_1:FormatText(var_100_3.content)

				arg_97_1.text_.text = var_100_4

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_5 = 46
				local var_100_6 = utf8.len(var_100_4)
				local var_100_7 = var_100_5 <= 0 and var_100_1 or var_100_1 * (var_100_6 / var_100_5)

				if var_100_7 > 0 and var_100_1 < var_100_7 then
					arg_97_1.talkMaxDuration = var_100_7

					if var_100_7 + var_100_0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_7 + var_100_0
					end
				end

				arg_97_1.text_.text = var_100_4
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318161", "318161024", "story_v_out_318161.awb") ~= 0 then
					local var_100_8 = manager.audio:GetVoiceLength("story_v_out_318161", "318161024", "story_v_out_318161.awb") / 1000

					if var_100_8 + var_100_0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_8 + var_100_0
					end

					if var_100_3.prefab_name ~= "" and arg_97_1.actors_[var_100_3.prefab_name] ~= nil then
						local var_100_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_3.prefab_name].transform, "story_v_out_318161", "318161024", "story_v_out_318161.awb")

						arg_97_1:RecordAudio("318161024", var_100_9)
						arg_97_1:RecordAudio("318161024", var_100_9)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_318161", "318161024", "story_v_out_318161.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_318161", "318161024", "story_v_out_318161.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_10 = math.max(var_100_1, arg_97_1.talkMaxDuration)

			if var_100_0 <= arg_97_1.time_ and arg_97_1.time_ < var_100_0 + var_100_10 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_0) / var_100_10

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_0 + var_100_10 and arg_97_1.time_ < var_100_0 + var_100_10 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play318161025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 318161025
		arg_101_1.duration_ = 8.27

		local var_101_0 = {
			zh = 8.266,
			ja = 6.666
		}
		local var_101_1 = manager.audio:GetLocalizationFlag()

		if var_101_0[var_101_1] ~= nil then
			arg_101_1.duration_ = var_101_0[var_101_1]
		end

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play318161026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = 0
			local var_104_1 = 0.85

			if var_104_0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_0 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				local var_104_2 = arg_101_1:FormatText(StoryNameCfg[13].name)

				arg_101_1.leftNameTxt_.text = var_104_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_3 = arg_101_1:GetWordFromCfg(318161025)
				local var_104_4 = arg_101_1:FormatText(var_104_3.content)

				arg_101_1.text_.text = var_104_4

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_5 = 34
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

				if manager.audio:GetVoiceLength("story_v_out_318161", "318161025", "story_v_out_318161.awb") ~= 0 then
					local var_104_8 = manager.audio:GetVoiceLength("story_v_out_318161", "318161025", "story_v_out_318161.awb") / 1000

					if var_104_8 + var_104_0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_8 + var_104_0
					end

					if var_104_3.prefab_name ~= "" and arg_101_1.actors_[var_104_3.prefab_name] ~= nil then
						local var_104_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_3.prefab_name].transform, "story_v_out_318161", "318161025", "story_v_out_318161.awb")

						arg_101_1:RecordAudio("318161025", var_104_9)
						arg_101_1:RecordAudio("318161025", var_104_9)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_318161", "318161025", "story_v_out_318161.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_318161", "318161025", "story_v_out_318161.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_10 = math.max(var_104_1, arg_101_1.talkMaxDuration)

			if var_104_0 <= arg_101_1.time_ and arg_101_1.time_ < var_104_0 + var_104_10 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_0) / var_104_10

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_0 + var_104_10 and arg_101_1.time_ < var_104_0 + var_104_10 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play318161026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 318161026
		arg_105_1.duration_ = 5

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play318161027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = arg_105_1.actors_["1019ui_story"]
			local var_108_1 = 0

			if var_108_1 < arg_105_1.time_ and arg_105_1.time_ <= var_108_1 + arg_108_0 and not isNil(var_108_0) and arg_105_1.var_.characterEffect1019ui_story == nil then
				arg_105_1.var_.characterEffect1019ui_story = var_108_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_2 = 0.200000002980232

			if var_108_1 <= arg_105_1.time_ and arg_105_1.time_ < var_108_1 + var_108_2 and not isNil(var_108_0) then
				local var_108_3 = (arg_105_1.time_ - var_108_1) / var_108_2

				if arg_105_1.var_.characterEffect1019ui_story and not isNil(var_108_0) then
					local var_108_4 = Mathf.Lerp(0, 0.5, var_108_3)

					arg_105_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_105_1.var_.characterEffect1019ui_story.fillRatio = var_108_4
				end
			end

			if arg_105_1.time_ >= var_108_1 + var_108_2 and arg_105_1.time_ < var_108_1 + var_108_2 + arg_108_0 and not isNil(var_108_0) and arg_105_1.var_.characterEffect1019ui_story then
				local var_108_5 = 0.5

				arg_105_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_105_1.var_.characterEffect1019ui_story.fillRatio = var_108_5
			end

			local var_108_6 = 0
			local var_108_7 = 1.075

			if var_108_6 < arg_105_1.time_ and arg_105_1.time_ <= var_108_6 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, false)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_8 = arg_105_1:GetWordFromCfg(318161026)
				local var_108_9 = arg_105_1:FormatText(var_108_8.content)

				arg_105_1.text_.text = var_108_9

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_10 = 43
				local var_108_11 = utf8.len(var_108_9)
				local var_108_12 = var_108_10 <= 0 and var_108_7 or var_108_7 * (var_108_11 / var_108_10)

				if var_108_12 > 0 and var_108_7 < var_108_12 then
					arg_105_1.talkMaxDuration = var_108_12

					if var_108_12 + var_108_6 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_12 + var_108_6
					end
				end

				arg_105_1.text_.text = var_108_9
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)
				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_13 = math.max(var_108_7, arg_105_1.talkMaxDuration)

			if var_108_6 <= arg_105_1.time_ and arg_105_1.time_ < var_108_6 + var_108_13 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_6) / var_108_13

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_6 + var_108_13 and arg_105_1.time_ < var_108_6 + var_108_13 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play318161027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 318161027
		arg_109_1.duration_ = 8.03

		local var_109_0 = {
			zh = 3.6,
			ja = 8.033
		}
		local var_109_1 = manager.audio:GetLocalizationFlag()

		if var_109_0[var_109_1] ~= nil then
			arg_109_1.duration_ = var_109_0[var_109_1]
		end

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play318161028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = arg_109_1.actors_["1028ui_story"]
			local var_112_1 = 0

			if var_112_1 < arg_109_1.time_ and arg_109_1.time_ <= var_112_1 + arg_112_0 and not isNil(var_112_0) and arg_109_1.var_.characterEffect1028ui_story == nil then
				arg_109_1.var_.characterEffect1028ui_story = var_112_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_2 = 0.200000002980232

			if var_112_1 <= arg_109_1.time_ and arg_109_1.time_ < var_112_1 + var_112_2 and not isNil(var_112_0) then
				local var_112_3 = (arg_109_1.time_ - var_112_1) / var_112_2

				if arg_109_1.var_.characterEffect1028ui_story and not isNil(var_112_0) then
					arg_109_1.var_.characterEffect1028ui_story.fillFlat = false
				end
			end

			if arg_109_1.time_ >= var_112_1 + var_112_2 and arg_109_1.time_ < var_112_1 + var_112_2 + arg_112_0 and not isNil(var_112_0) and arg_109_1.var_.characterEffect1028ui_story then
				arg_109_1.var_.characterEffect1028ui_story.fillFlat = false
			end

			local var_112_4 = 0

			if var_112_4 < arg_109_1.time_ and arg_109_1.time_ <= var_112_4 + arg_112_0 then
				arg_109_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_112_5 = 0
			local var_112_6 = 0.45

			if var_112_5 < arg_109_1.time_ and arg_109_1.time_ <= var_112_5 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				local var_112_7 = arg_109_1:FormatText(StoryNameCfg[327].name)

				arg_109_1.leftNameTxt_.text = var_112_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_8 = arg_109_1:GetWordFromCfg(318161027)
				local var_112_9 = arg_109_1:FormatText(var_112_8.content)

				arg_109_1.text_.text = var_112_9

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_10 = 18
				local var_112_11 = utf8.len(var_112_9)
				local var_112_12 = var_112_10 <= 0 and var_112_6 or var_112_6 * (var_112_11 / var_112_10)

				if var_112_12 > 0 and var_112_6 < var_112_12 then
					arg_109_1.talkMaxDuration = var_112_12

					if var_112_12 + var_112_5 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_12 + var_112_5
					end
				end

				arg_109_1.text_.text = var_112_9
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318161", "318161027", "story_v_out_318161.awb") ~= 0 then
					local var_112_13 = manager.audio:GetVoiceLength("story_v_out_318161", "318161027", "story_v_out_318161.awb") / 1000

					if var_112_13 + var_112_5 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_13 + var_112_5
					end

					if var_112_8.prefab_name ~= "" and arg_109_1.actors_[var_112_8.prefab_name] ~= nil then
						local var_112_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_8.prefab_name].transform, "story_v_out_318161", "318161027", "story_v_out_318161.awb")

						arg_109_1:RecordAudio("318161027", var_112_14)
						arg_109_1:RecordAudio("318161027", var_112_14)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_318161", "318161027", "story_v_out_318161.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_318161", "318161027", "story_v_out_318161.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_15 = math.max(var_112_6, arg_109_1.talkMaxDuration)

			if var_112_5 <= arg_109_1.time_ and arg_109_1.time_ < var_112_5 + var_112_15 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_5) / var_112_15

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_5 + var_112_15 and arg_109_1.time_ < var_112_5 + var_112_15 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play318161028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 318161028
		arg_113_1.duration_ = 10.7

		local var_113_0 = {
			zh = 3.866,
			ja = 10.7
		}
		local var_113_1 = manager.audio:GetLocalizationFlag()

		if var_113_0[var_113_1] ~= nil then
			arg_113_1.duration_ = var_113_0[var_113_1]
		end

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play318161029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = arg_113_1.actors_["1019ui_story"]
			local var_116_1 = 0

			if var_116_1 < arg_113_1.time_ and arg_113_1.time_ <= var_116_1 + arg_116_0 and not isNil(var_116_0) and arg_113_1.var_.characterEffect1019ui_story == nil then
				arg_113_1.var_.characterEffect1019ui_story = var_116_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_2 = 0.200000002980232

			if var_116_1 <= arg_113_1.time_ and arg_113_1.time_ < var_116_1 + var_116_2 and not isNil(var_116_0) then
				local var_116_3 = (arg_113_1.time_ - var_116_1) / var_116_2

				if arg_113_1.var_.characterEffect1019ui_story and not isNil(var_116_0) then
					arg_113_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_113_1.time_ >= var_116_1 + var_116_2 and arg_113_1.time_ < var_116_1 + var_116_2 + arg_116_0 and not isNil(var_116_0) and arg_113_1.var_.characterEffect1019ui_story then
				arg_113_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_116_4 = 0

			if var_116_4 < arg_113_1.time_ and arg_113_1.time_ <= var_116_4 + arg_116_0 then
				arg_113_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action2_2")
			end

			local var_116_5 = arg_113_1.actors_["1028ui_story"]
			local var_116_6 = 0

			if var_116_6 < arg_113_1.time_ and arg_113_1.time_ <= var_116_6 + arg_116_0 and not isNil(var_116_5) and arg_113_1.var_.characterEffect1028ui_story == nil then
				arg_113_1.var_.characterEffect1028ui_story = var_116_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_7 = 0.200000002980232

			if var_116_6 <= arg_113_1.time_ and arg_113_1.time_ < var_116_6 + var_116_7 and not isNil(var_116_5) then
				local var_116_8 = (arg_113_1.time_ - var_116_6) / var_116_7

				if arg_113_1.var_.characterEffect1028ui_story and not isNil(var_116_5) then
					local var_116_9 = Mathf.Lerp(0, 0.5, var_116_8)

					arg_113_1.var_.characterEffect1028ui_story.fillFlat = true
					arg_113_1.var_.characterEffect1028ui_story.fillRatio = var_116_9
				end
			end

			if arg_113_1.time_ >= var_116_6 + var_116_7 and arg_113_1.time_ < var_116_6 + var_116_7 + arg_116_0 and not isNil(var_116_5) and arg_113_1.var_.characterEffect1028ui_story then
				local var_116_10 = 0.5

				arg_113_1.var_.characterEffect1028ui_story.fillFlat = true
				arg_113_1.var_.characterEffect1028ui_story.fillRatio = var_116_10
			end

			local var_116_11 = 0
			local var_116_12 = 0.575

			if var_116_11 < arg_113_1.time_ and arg_113_1.time_ <= var_116_11 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				local var_116_13 = arg_113_1:FormatText(StoryNameCfg[13].name)

				arg_113_1.leftNameTxt_.text = var_116_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_14 = arg_113_1:GetWordFromCfg(318161028)
				local var_116_15 = arg_113_1:FormatText(var_116_14.content)

				arg_113_1.text_.text = var_116_15

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_16 = 23
				local var_116_17 = utf8.len(var_116_15)
				local var_116_18 = var_116_16 <= 0 and var_116_12 or var_116_12 * (var_116_17 / var_116_16)

				if var_116_18 > 0 and var_116_12 < var_116_18 then
					arg_113_1.talkMaxDuration = var_116_18

					if var_116_18 + var_116_11 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_18 + var_116_11
					end
				end

				arg_113_1.text_.text = var_116_15
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318161", "318161028", "story_v_out_318161.awb") ~= 0 then
					local var_116_19 = manager.audio:GetVoiceLength("story_v_out_318161", "318161028", "story_v_out_318161.awb") / 1000

					if var_116_19 + var_116_11 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_19 + var_116_11
					end

					if var_116_14.prefab_name ~= "" and arg_113_1.actors_[var_116_14.prefab_name] ~= nil then
						local var_116_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_14.prefab_name].transform, "story_v_out_318161", "318161028", "story_v_out_318161.awb")

						arg_113_1:RecordAudio("318161028", var_116_20)
						arg_113_1:RecordAudio("318161028", var_116_20)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_318161", "318161028", "story_v_out_318161.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_318161", "318161028", "story_v_out_318161.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_21 = math.max(var_116_12, arg_113_1.talkMaxDuration)

			if var_116_11 <= arg_113_1.time_ and arg_113_1.time_ < var_116_11 + var_116_21 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_11) / var_116_21

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_11 + var_116_21 and arg_113_1.time_ < var_116_11 + var_116_21 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play318161029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 318161029
		arg_117_1.duration_ = 9.13

		local var_117_0 = {
			zh = 8.6,
			ja = 9.133
		}
		local var_117_1 = manager.audio:GetLocalizationFlag()

		if var_117_0[var_117_1] ~= nil then
			arg_117_1.duration_ = var_117_0[var_117_1]
		end

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play318161030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = arg_117_1.actors_["1028ui_story"]
			local var_120_1 = 0

			if var_120_1 < arg_117_1.time_ and arg_117_1.time_ <= var_120_1 + arg_120_0 and not isNil(var_120_0) and arg_117_1.var_.characterEffect1028ui_story == nil then
				arg_117_1.var_.characterEffect1028ui_story = var_120_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_2 = 0.200000002980232

			if var_120_1 <= arg_117_1.time_ and arg_117_1.time_ < var_120_1 + var_120_2 and not isNil(var_120_0) then
				local var_120_3 = (arg_117_1.time_ - var_120_1) / var_120_2

				if arg_117_1.var_.characterEffect1028ui_story and not isNil(var_120_0) then
					arg_117_1.var_.characterEffect1028ui_story.fillFlat = false
				end
			end

			if arg_117_1.time_ >= var_120_1 + var_120_2 and arg_117_1.time_ < var_120_1 + var_120_2 + arg_120_0 and not isNil(var_120_0) and arg_117_1.var_.characterEffect1028ui_story then
				arg_117_1.var_.characterEffect1028ui_story.fillFlat = false
			end

			local var_120_4 = 0

			if var_120_4 < arg_117_1.time_ and arg_117_1.time_ <= var_120_4 + arg_120_0 then
				arg_117_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/story1028/story1028action/1028action7_1")
			end

			local var_120_5 = arg_117_1.actors_["1019ui_story"]
			local var_120_6 = 0

			if var_120_6 < arg_117_1.time_ and arg_117_1.time_ <= var_120_6 + arg_120_0 and not isNil(var_120_5) and arg_117_1.var_.characterEffect1019ui_story == nil then
				arg_117_1.var_.characterEffect1019ui_story = var_120_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_7 = 0.200000002980232

			if var_120_6 <= arg_117_1.time_ and arg_117_1.time_ < var_120_6 + var_120_7 and not isNil(var_120_5) then
				local var_120_8 = (arg_117_1.time_ - var_120_6) / var_120_7

				if arg_117_1.var_.characterEffect1019ui_story and not isNil(var_120_5) then
					local var_120_9 = Mathf.Lerp(0, 0.5, var_120_8)

					arg_117_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_117_1.var_.characterEffect1019ui_story.fillRatio = var_120_9
				end
			end

			if arg_117_1.time_ >= var_120_6 + var_120_7 and arg_117_1.time_ < var_120_6 + var_120_7 + arg_120_0 and not isNil(var_120_5) and arg_117_1.var_.characterEffect1019ui_story then
				local var_120_10 = 0.5

				arg_117_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_117_1.var_.characterEffect1019ui_story.fillRatio = var_120_10
			end

			local var_120_11 = 0

			if var_120_11 < arg_117_1.time_ and arg_117_1.time_ <= var_120_11 + arg_120_0 then
				arg_117_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_120_12 = 0
			local var_120_13 = 0.85

			if var_120_12 < arg_117_1.time_ and arg_117_1.time_ <= var_120_12 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				local var_120_14 = arg_117_1:FormatText(StoryNameCfg[327].name)

				arg_117_1.leftNameTxt_.text = var_120_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_15 = arg_117_1:GetWordFromCfg(318161029)
				local var_120_16 = arg_117_1:FormatText(var_120_15.content)

				arg_117_1.text_.text = var_120_16

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_17 = 34
				local var_120_18 = utf8.len(var_120_16)
				local var_120_19 = var_120_17 <= 0 and var_120_13 or var_120_13 * (var_120_18 / var_120_17)

				if var_120_19 > 0 and var_120_13 < var_120_19 then
					arg_117_1.talkMaxDuration = var_120_19

					if var_120_19 + var_120_12 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_19 + var_120_12
					end
				end

				arg_117_1.text_.text = var_120_16
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318161", "318161029", "story_v_out_318161.awb") ~= 0 then
					local var_120_20 = manager.audio:GetVoiceLength("story_v_out_318161", "318161029", "story_v_out_318161.awb") / 1000

					if var_120_20 + var_120_12 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_20 + var_120_12
					end

					if var_120_15.prefab_name ~= "" and arg_117_1.actors_[var_120_15.prefab_name] ~= nil then
						local var_120_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_15.prefab_name].transform, "story_v_out_318161", "318161029", "story_v_out_318161.awb")

						arg_117_1:RecordAudio("318161029", var_120_21)
						arg_117_1:RecordAudio("318161029", var_120_21)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_318161", "318161029", "story_v_out_318161.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_318161", "318161029", "story_v_out_318161.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_22 = math.max(var_120_13, arg_117_1.talkMaxDuration)

			if var_120_12 <= arg_117_1.time_ and arg_117_1.time_ < var_120_12 + var_120_22 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_12) / var_120_22

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_12 + var_120_22 and arg_117_1.time_ < var_120_12 + var_120_22 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play318161030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 318161030
		arg_121_1.duration_ = 7.43

		local var_121_0 = {
			zh = 7.433,
			ja = 7.1
		}
		local var_121_1 = manager.audio:GetLocalizationFlag()

		if var_121_0[var_121_1] ~= nil then
			arg_121_1.duration_ = var_121_0[var_121_1]
		end

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play318161031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = arg_121_1.actors_["1019ui_story"]
			local var_124_1 = 0

			if var_124_1 < arg_121_1.time_ and arg_121_1.time_ <= var_124_1 + arg_124_0 and not isNil(var_124_0) and arg_121_1.var_.characterEffect1019ui_story == nil then
				arg_121_1.var_.characterEffect1019ui_story = var_124_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_2 = 0.200000002980232

			if var_124_1 <= arg_121_1.time_ and arg_121_1.time_ < var_124_1 + var_124_2 and not isNil(var_124_0) then
				local var_124_3 = (arg_121_1.time_ - var_124_1) / var_124_2

				if arg_121_1.var_.characterEffect1019ui_story and not isNil(var_124_0) then
					arg_121_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_121_1.time_ >= var_124_1 + var_124_2 and arg_121_1.time_ < var_124_1 + var_124_2 + arg_124_0 and not isNil(var_124_0) and arg_121_1.var_.characterEffect1019ui_story then
				arg_121_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_124_4 = arg_121_1.actors_["1028ui_story"]
			local var_124_5 = 0

			if var_124_5 < arg_121_1.time_ and arg_121_1.time_ <= var_124_5 + arg_124_0 and not isNil(var_124_4) and arg_121_1.var_.characterEffect1028ui_story == nil then
				arg_121_1.var_.characterEffect1028ui_story = var_124_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_6 = 0.200000002980232

			if var_124_5 <= arg_121_1.time_ and arg_121_1.time_ < var_124_5 + var_124_6 and not isNil(var_124_4) then
				local var_124_7 = (arg_121_1.time_ - var_124_5) / var_124_6

				if arg_121_1.var_.characterEffect1028ui_story and not isNil(var_124_4) then
					local var_124_8 = Mathf.Lerp(0, 0.5, var_124_7)

					arg_121_1.var_.characterEffect1028ui_story.fillFlat = true
					arg_121_1.var_.characterEffect1028ui_story.fillRatio = var_124_8
				end
			end

			if arg_121_1.time_ >= var_124_5 + var_124_6 and arg_121_1.time_ < var_124_5 + var_124_6 + arg_124_0 and not isNil(var_124_4) and arg_121_1.var_.characterEffect1028ui_story then
				local var_124_9 = 0.5

				arg_121_1.var_.characterEffect1028ui_story.fillFlat = true
				arg_121_1.var_.characterEffect1028ui_story.fillRatio = var_124_9
			end

			local var_124_10 = 0
			local var_124_11 = 1

			if var_124_10 < arg_121_1.time_ and arg_121_1.time_ <= var_124_10 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				local var_124_12 = arg_121_1:FormatText(StoryNameCfg[13].name)

				arg_121_1.leftNameTxt_.text = var_124_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_13 = arg_121_1:GetWordFromCfg(318161030)
				local var_124_14 = arg_121_1:FormatText(var_124_13.content)

				arg_121_1.text_.text = var_124_14

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_15 = 40
				local var_124_16 = utf8.len(var_124_14)
				local var_124_17 = var_124_15 <= 0 and var_124_11 or var_124_11 * (var_124_16 / var_124_15)

				if var_124_17 > 0 and var_124_11 < var_124_17 then
					arg_121_1.talkMaxDuration = var_124_17

					if var_124_17 + var_124_10 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_17 + var_124_10
					end
				end

				arg_121_1.text_.text = var_124_14
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318161", "318161030", "story_v_out_318161.awb") ~= 0 then
					local var_124_18 = manager.audio:GetVoiceLength("story_v_out_318161", "318161030", "story_v_out_318161.awb") / 1000

					if var_124_18 + var_124_10 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_18 + var_124_10
					end

					if var_124_13.prefab_name ~= "" and arg_121_1.actors_[var_124_13.prefab_name] ~= nil then
						local var_124_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_13.prefab_name].transform, "story_v_out_318161", "318161030", "story_v_out_318161.awb")

						arg_121_1:RecordAudio("318161030", var_124_19)
						arg_121_1:RecordAudio("318161030", var_124_19)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_318161", "318161030", "story_v_out_318161.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_318161", "318161030", "story_v_out_318161.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_20 = math.max(var_124_11, arg_121_1.talkMaxDuration)

			if var_124_10 <= arg_121_1.time_ and arg_121_1.time_ < var_124_10 + var_124_20 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_10) / var_124_20

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_10 + var_124_20 and arg_121_1.time_ < var_124_10 + var_124_20 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play318161031 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 318161031
		arg_125_1.duration_ = 9.13

		local var_125_0 = {
			zh = 6.2,
			ja = 9.133
		}
		local var_125_1 = manager.audio:GetLocalizationFlag()

		if var_125_0[var_125_1] ~= nil then
			arg_125_1.duration_ = var_125_0[var_125_1]
		end

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play318161032(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = 0
			local var_128_1 = 0.725

			if var_128_0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_0 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				local var_128_2 = arg_125_1:FormatText(StoryNameCfg[13].name)

				arg_125_1.leftNameTxt_.text = var_128_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_3 = arg_125_1:GetWordFromCfg(318161031)
				local var_128_4 = arg_125_1:FormatText(var_128_3.content)

				arg_125_1.text_.text = var_128_4

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_5 = 29
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

				if manager.audio:GetVoiceLength("story_v_out_318161", "318161031", "story_v_out_318161.awb") ~= 0 then
					local var_128_8 = manager.audio:GetVoiceLength("story_v_out_318161", "318161031", "story_v_out_318161.awb") / 1000

					if var_128_8 + var_128_0 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_8 + var_128_0
					end

					if var_128_3.prefab_name ~= "" and arg_125_1.actors_[var_128_3.prefab_name] ~= nil then
						local var_128_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_3.prefab_name].transform, "story_v_out_318161", "318161031", "story_v_out_318161.awb")

						arg_125_1:RecordAudio("318161031", var_128_9)
						arg_125_1:RecordAudio("318161031", var_128_9)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_318161", "318161031", "story_v_out_318161.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_318161", "318161031", "story_v_out_318161.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_10 = math.max(var_128_1, arg_125_1.talkMaxDuration)

			if var_128_0 <= arg_125_1.time_ and arg_125_1.time_ < var_128_0 + var_128_10 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_0) / var_128_10

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_0 + var_128_10 and arg_125_1.time_ < var_128_0 + var_128_10 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play318161032 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 318161032
		arg_129_1.duration_ = 8.63

		local var_129_0 = {
			zh = 8.633,
			ja = 7.466
		}
		local var_129_1 = manager.audio:GetLocalizationFlag()

		if var_129_0[var_129_1] ~= nil then
			arg_129_1.duration_ = var_129_0[var_129_1]
		end

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play318161033(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = arg_129_1.actors_["1028ui_story"]
			local var_132_1 = 0

			if var_132_1 < arg_129_1.time_ and arg_129_1.time_ <= var_132_1 + arg_132_0 and not isNil(var_132_0) and arg_129_1.var_.characterEffect1028ui_story == nil then
				arg_129_1.var_.characterEffect1028ui_story = var_132_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_2 = 0.200000002980232

			if var_132_1 <= arg_129_1.time_ and arg_129_1.time_ < var_132_1 + var_132_2 and not isNil(var_132_0) then
				local var_132_3 = (arg_129_1.time_ - var_132_1) / var_132_2

				if arg_129_1.var_.characterEffect1028ui_story and not isNil(var_132_0) then
					arg_129_1.var_.characterEffect1028ui_story.fillFlat = false
				end
			end

			if arg_129_1.time_ >= var_132_1 + var_132_2 and arg_129_1.time_ < var_132_1 + var_132_2 + arg_132_0 and not isNil(var_132_0) and arg_129_1.var_.characterEffect1028ui_story then
				arg_129_1.var_.characterEffect1028ui_story.fillFlat = false
			end

			local var_132_4 = 0

			if var_132_4 < arg_129_1.time_ and arg_129_1.time_ <= var_132_4 + arg_132_0 then
				arg_129_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/story1028/story1028actionlink/1028action475")
			end

			local var_132_5 = arg_129_1.actors_["1019ui_story"]
			local var_132_6 = 0

			if var_132_6 < arg_129_1.time_ and arg_129_1.time_ <= var_132_6 + arg_132_0 and not isNil(var_132_5) and arg_129_1.var_.characterEffect1019ui_story == nil then
				arg_129_1.var_.characterEffect1019ui_story = var_132_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_7 = 0.200000002980232

			if var_132_6 <= arg_129_1.time_ and arg_129_1.time_ < var_132_6 + var_132_7 and not isNil(var_132_5) then
				local var_132_8 = (arg_129_1.time_ - var_132_6) / var_132_7

				if arg_129_1.var_.characterEffect1019ui_story and not isNil(var_132_5) then
					local var_132_9 = Mathf.Lerp(0, 0.5, var_132_8)

					arg_129_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_129_1.var_.characterEffect1019ui_story.fillRatio = var_132_9
				end
			end

			if arg_129_1.time_ >= var_132_6 + var_132_7 and arg_129_1.time_ < var_132_6 + var_132_7 + arg_132_0 and not isNil(var_132_5) and arg_129_1.var_.characterEffect1019ui_story then
				local var_132_10 = 0.5

				arg_129_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_129_1.var_.characterEffect1019ui_story.fillRatio = var_132_10
			end

			local var_132_11 = 0
			local var_132_12 = 0.575

			if var_132_11 < arg_129_1.time_ and arg_129_1.time_ <= var_132_11 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				local var_132_13 = arg_129_1:FormatText(StoryNameCfg[327].name)

				arg_129_1.leftNameTxt_.text = var_132_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_14 = arg_129_1:GetWordFromCfg(318161032)
				local var_132_15 = arg_129_1:FormatText(var_132_14.content)

				arg_129_1.text_.text = var_132_15

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_16 = 23
				local var_132_17 = utf8.len(var_132_15)
				local var_132_18 = var_132_16 <= 0 and var_132_12 or var_132_12 * (var_132_17 / var_132_16)

				if var_132_18 > 0 and var_132_12 < var_132_18 then
					arg_129_1.talkMaxDuration = var_132_18

					if var_132_18 + var_132_11 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_18 + var_132_11
					end
				end

				arg_129_1.text_.text = var_132_15
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318161", "318161032", "story_v_out_318161.awb") ~= 0 then
					local var_132_19 = manager.audio:GetVoiceLength("story_v_out_318161", "318161032", "story_v_out_318161.awb") / 1000

					if var_132_19 + var_132_11 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_19 + var_132_11
					end

					if var_132_14.prefab_name ~= "" and arg_129_1.actors_[var_132_14.prefab_name] ~= nil then
						local var_132_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_14.prefab_name].transform, "story_v_out_318161", "318161032", "story_v_out_318161.awb")

						arg_129_1:RecordAudio("318161032", var_132_20)
						arg_129_1:RecordAudio("318161032", var_132_20)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_318161", "318161032", "story_v_out_318161.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_318161", "318161032", "story_v_out_318161.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_21 = math.max(var_132_12, arg_129_1.talkMaxDuration)

			if var_132_11 <= arg_129_1.time_ and arg_129_1.time_ < var_132_11 + var_132_21 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_11) / var_132_21

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_11 + var_132_21 and arg_129_1.time_ < var_132_11 + var_132_21 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play318161033 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 318161033
		arg_133_1.duration_ = 5

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play318161034(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = arg_133_1.actors_["1028ui_story"]
			local var_136_1 = 0

			if var_136_1 < arg_133_1.time_ and arg_133_1.time_ <= var_136_1 + arg_136_0 and not isNil(var_136_0) and arg_133_1.var_.characterEffect1028ui_story == nil then
				arg_133_1.var_.characterEffect1028ui_story = var_136_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_2 = 0.200000002980232

			if var_136_1 <= arg_133_1.time_ and arg_133_1.time_ < var_136_1 + var_136_2 and not isNil(var_136_0) then
				local var_136_3 = (arg_133_1.time_ - var_136_1) / var_136_2

				if arg_133_1.var_.characterEffect1028ui_story and not isNil(var_136_0) then
					local var_136_4 = Mathf.Lerp(0, 0.5, var_136_3)

					arg_133_1.var_.characterEffect1028ui_story.fillFlat = true
					arg_133_1.var_.characterEffect1028ui_story.fillRatio = var_136_4
				end
			end

			if arg_133_1.time_ >= var_136_1 + var_136_2 and arg_133_1.time_ < var_136_1 + var_136_2 + arg_136_0 and not isNil(var_136_0) and arg_133_1.var_.characterEffect1028ui_story then
				local var_136_5 = 0.5

				arg_133_1.var_.characterEffect1028ui_story.fillFlat = true
				arg_133_1.var_.characterEffect1028ui_story.fillRatio = var_136_5
			end

			local var_136_6 = 0
			local var_136_7 = 0.575

			if var_136_6 < arg_133_1.time_ and arg_133_1.time_ <= var_136_6 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, false)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_8 = arg_133_1:GetWordFromCfg(318161033)
				local var_136_9 = arg_133_1:FormatText(var_136_8.content)

				arg_133_1.text_.text = var_136_9

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_10 = 23
				local var_136_11 = utf8.len(var_136_9)
				local var_136_12 = var_136_10 <= 0 and var_136_7 or var_136_7 * (var_136_11 / var_136_10)

				if var_136_12 > 0 and var_136_7 < var_136_12 then
					arg_133_1.talkMaxDuration = var_136_12

					if var_136_12 + var_136_6 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_12 + var_136_6
					end
				end

				arg_133_1.text_.text = var_136_9
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)
				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_13 = math.max(var_136_7, arg_133_1.talkMaxDuration)

			if var_136_6 <= arg_133_1.time_ and arg_133_1.time_ < var_136_6 + var_136_13 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_6) / var_136_13

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_6 + var_136_13 and arg_133_1.time_ < var_136_6 + var_136_13 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play318161034 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 318161034
		arg_137_1.duration_ = 6.6

		local var_137_0 = {
			zh = 5.966,
			ja = 6.6
		}
		local var_137_1 = manager.audio:GetLocalizationFlag()

		if var_137_0[var_137_1] ~= nil then
			arg_137_1.duration_ = var_137_0[var_137_1]
		end

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play318161035(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = arg_137_1.actors_["1028ui_story"]
			local var_140_1 = 0

			if var_140_1 < arg_137_1.time_ and arg_137_1.time_ <= var_140_1 + arg_140_0 and not isNil(var_140_0) and arg_137_1.var_.characterEffect1028ui_story == nil then
				arg_137_1.var_.characterEffect1028ui_story = var_140_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_2 = 0.200000002980232

			if var_140_1 <= arg_137_1.time_ and arg_137_1.time_ < var_140_1 + var_140_2 and not isNil(var_140_0) then
				local var_140_3 = (arg_137_1.time_ - var_140_1) / var_140_2

				if arg_137_1.var_.characterEffect1028ui_story and not isNil(var_140_0) then
					arg_137_1.var_.characterEffect1028ui_story.fillFlat = false
				end
			end

			if arg_137_1.time_ >= var_140_1 + var_140_2 and arg_137_1.time_ < var_140_1 + var_140_2 + arg_140_0 and not isNil(var_140_0) and arg_137_1.var_.characterEffect1028ui_story then
				arg_137_1.var_.characterEffect1028ui_story.fillFlat = false
			end

			local var_140_4 = 0

			if var_140_4 < arg_137_1.time_ and arg_137_1.time_ <= var_140_4 + arg_140_0 then
				arg_137_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/story1028/story1028action/1028action5_2")
			end

			local var_140_5 = 0

			if var_140_5 < arg_137_1.time_ and arg_137_1.time_ <= var_140_5 + arg_140_0 then
				arg_137_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_140_6 = 0
			local var_140_7 = 0.825

			if var_140_6 < arg_137_1.time_ and arg_137_1.time_ <= var_140_6 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				local var_140_8 = arg_137_1:FormatText(StoryNameCfg[327].name)

				arg_137_1.leftNameTxt_.text = var_140_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_9 = arg_137_1:GetWordFromCfg(318161034)
				local var_140_10 = arg_137_1:FormatText(var_140_9.content)

				arg_137_1.text_.text = var_140_10

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_11 = 33
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

				if manager.audio:GetVoiceLength("story_v_out_318161", "318161034", "story_v_out_318161.awb") ~= 0 then
					local var_140_14 = manager.audio:GetVoiceLength("story_v_out_318161", "318161034", "story_v_out_318161.awb") / 1000

					if var_140_14 + var_140_6 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_14 + var_140_6
					end

					if var_140_9.prefab_name ~= "" and arg_137_1.actors_[var_140_9.prefab_name] ~= nil then
						local var_140_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_9.prefab_name].transform, "story_v_out_318161", "318161034", "story_v_out_318161.awb")

						arg_137_1:RecordAudio("318161034", var_140_15)
						arg_137_1:RecordAudio("318161034", var_140_15)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_318161", "318161034", "story_v_out_318161.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_318161", "318161034", "story_v_out_318161.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_16 = math.max(var_140_7, arg_137_1.talkMaxDuration)

			if var_140_6 <= arg_137_1.time_ and arg_137_1.time_ < var_140_6 + var_140_16 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_6) / var_140_16

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_6 + var_140_16 and arg_137_1.time_ < var_140_6 + var_140_16 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play318161035 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 318161035
		arg_141_1.duration_ = 9.3

		local var_141_0 = {
			zh = 4.533,
			ja = 9.3
		}
		local var_141_1 = manager.audio:GetLocalizationFlag()

		if var_141_0[var_141_1] ~= nil then
			arg_141_1.duration_ = var_141_0[var_141_1]
		end

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play318161036(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = arg_141_1.actors_["1019ui_story"]
			local var_144_1 = 0

			if var_144_1 < arg_141_1.time_ and arg_141_1.time_ <= var_144_1 + arg_144_0 and not isNil(var_144_0) and arg_141_1.var_.characterEffect1019ui_story == nil then
				arg_141_1.var_.characterEffect1019ui_story = var_144_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_2 = 0.200000002980232

			if var_144_1 <= arg_141_1.time_ and arg_141_1.time_ < var_144_1 + var_144_2 and not isNil(var_144_0) then
				local var_144_3 = (arg_141_1.time_ - var_144_1) / var_144_2

				if arg_141_1.var_.characterEffect1019ui_story and not isNil(var_144_0) then
					arg_141_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_141_1.time_ >= var_144_1 + var_144_2 and arg_141_1.time_ < var_144_1 + var_144_2 + arg_144_0 and not isNil(var_144_0) and arg_141_1.var_.characterEffect1019ui_story then
				arg_141_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_144_4 = 0

			if var_144_4 < arg_141_1.time_ and arg_141_1.time_ <= var_144_4 + arg_144_0 then
				arg_141_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action1_1")
			end

			local var_144_5 = 0

			if var_144_5 < arg_141_1.time_ and arg_141_1.time_ <= var_144_5 + arg_144_0 then
				arg_141_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_144_6 = arg_141_1.actors_["1028ui_story"]
			local var_144_7 = 0

			if var_144_7 < arg_141_1.time_ and arg_141_1.time_ <= var_144_7 + arg_144_0 and not isNil(var_144_6) and arg_141_1.var_.characterEffect1028ui_story == nil then
				arg_141_1.var_.characterEffect1028ui_story = var_144_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_8 = 0.200000002980232

			if var_144_7 <= arg_141_1.time_ and arg_141_1.time_ < var_144_7 + var_144_8 and not isNil(var_144_6) then
				local var_144_9 = (arg_141_1.time_ - var_144_7) / var_144_8

				if arg_141_1.var_.characterEffect1028ui_story and not isNil(var_144_6) then
					local var_144_10 = Mathf.Lerp(0, 0.5, var_144_9)

					arg_141_1.var_.characterEffect1028ui_story.fillFlat = true
					arg_141_1.var_.characterEffect1028ui_story.fillRatio = var_144_10
				end
			end

			if arg_141_1.time_ >= var_144_7 + var_144_8 and arg_141_1.time_ < var_144_7 + var_144_8 + arg_144_0 and not isNil(var_144_6) and arg_141_1.var_.characterEffect1028ui_story then
				local var_144_11 = 0.5

				arg_141_1.var_.characterEffect1028ui_story.fillFlat = true
				arg_141_1.var_.characterEffect1028ui_story.fillRatio = var_144_11
			end

			local var_144_12 = 0
			local var_144_13 = 0.625

			if var_144_12 < arg_141_1.time_ and arg_141_1.time_ <= var_144_12 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				local var_144_14 = arg_141_1:FormatText(StoryNameCfg[13].name)

				arg_141_1.leftNameTxt_.text = var_144_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_15 = arg_141_1:GetWordFromCfg(318161035)
				local var_144_16 = arg_141_1:FormatText(var_144_15.content)

				arg_141_1.text_.text = var_144_16

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_17 = 25
				local var_144_18 = utf8.len(var_144_16)
				local var_144_19 = var_144_17 <= 0 and var_144_13 or var_144_13 * (var_144_18 / var_144_17)

				if var_144_19 > 0 and var_144_13 < var_144_19 then
					arg_141_1.talkMaxDuration = var_144_19

					if var_144_19 + var_144_12 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_19 + var_144_12
					end
				end

				arg_141_1.text_.text = var_144_16
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318161", "318161035", "story_v_out_318161.awb") ~= 0 then
					local var_144_20 = manager.audio:GetVoiceLength("story_v_out_318161", "318161035", "story_v_out_318161.awb") / 1000

					if var_144_20 + var_144_12 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_20 + var_144_12
					end

					if var_144_15.prefab_name ~= "" and arg_141_1.actors_[var_144_15.prefab_name] ~= nil then
						local var_144_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_15.prefab_name].transform, "story_v_out_318161", "318161035", "story_v_out_318161.awb")

						arg_141_1:RecordAudio("318161035", var_144_21)
						arg_141_1:RecordAudio("318161035", var_144_21)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_318161", "318161035", "story_v_out_318161.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_318161", "318161035", "story_v_out_318161.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_22 = math.max(var_144_13, arg_141_1.talkMaxDuration)

			if var_144_12 <= arg_141_1.time_ and arg_141_1.time_ < var_144_12 + var_144_22 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_12) / var_144_22

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_12 + var_144_22 and arg_141_1.time_ < var_144_12 + var_144_22 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play318161036 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 318161036
		arg_145_1.duration_ = 5

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play318161037(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = arg_145_1.actors_["1019ui_story"]
			local var_148_1 = 0

			if var_148_1 < arg_145_1.time_ and arg_145_1.time_ <= var_148_1 + arg_148_0 and not isNil(var_148_0) and arg_145_1.var_.characterEffect1019ui_story == nil then
				arg_145_1.var_.characterEffect1019ui_story = var_148_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_2 = 0.200000002980232

			if var_148_1 <= arg_145_1.time_ and arg_145_1.time_ < var_148_1 + var_148_2 and not isNil(var_148_0) then
				local var_148_3 = (arg_145_1.time_ - var_148_1) / var_148_2

				if arg_145_1.var_.characterEffect1019ui_story and not isNil(var_148_0) then
					local var_148_4 = Mathf.Lerp(0, 0.5, var_148_3)

					arg_145_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_145_1.var_.characterEffect1019ui_story.fillRatio = var_148_4
				end
			end

			if arg_145_1.time_ >= var_148_1 + var_148_2 and arg_145_1.time_ < var_148_1 + var_148_2 + arg_148_0 and not isNil(var_148_0) and arg_145_1.var_.characterEffect1019ui_story then
				local var_148_5 = 0.5

				arg_145_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_145_1.var_.characterEffect1019ui_story.fillRatio = var_148_5
			end

			local var_148_6 = 0
			local var_148_7 = 0.675

			if var_148_6 < arg_145_1.time_ and arg_145_1.time_ <= var_148_6 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, false)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_8 = arg_145_1:GetWordFromCfg(318161036)
				local var_148_9 = arg_145_1:FormatText(var_148_8.content)

				arg_145_1.text_.text = var_148_9

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_10 = 27
				local var_148_11 = utf8.len(var_148_9)
				local var_148_12 = var_148_10 <= 0 and var_148_7 or var_148_7 * (var_148_11 / var_148_10)

				if var_148_12 > 0 and var_148_7 < var_148_12 then
					arg_145_1.talkMaxDuration = var_148_12

					if var_148_12 + var_148_6 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_12 + var_148_6
					end
				end

				arg_145_1.text_.text = var_148_9
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)
				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_13 = math.max(var_148_7, arg_145_1.talkMaxDuration)

			if var_148_6 <= arg_145_1.time_ and arg_145_1.time_ < var_148_6 + var_148_13 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_6) / var_148_13

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_6 + var_148_13 and arg_145_1.time_ < var_148_6 + var_148_13 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {}

		arg_145_1:InitPlayNodeList()
	end,
	Play318161037 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 318161037
		arg_149_1.duration_ = 6.7

		local var_149_0 = {
			zh = 6.7,
			ja = 5.033
		}
		local var_149_1 = manager.audio:GetLocalizationFlag()

		if var_149_0[var_149_1] ~= nil then
			arg_149_1.duration_ = var_149_0[var_149_1]
		end

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play318161038(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = arg_149_1.actors_["1028ui_story"]
			local var_152_1 = 0

			if var_152_1 < arg_149_1.time_ and arg_149_1.time_ <= var_152_1 + arg_152_0 and not isNil(var_152_0) and arg_149_1.var_.characterEffect1028ui_story == nil then
				arg_149_1.var_.characterEffect1028ui_story = var_152_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_2 = 0.200000002980232

			if var_152_1 <= arg_149_1.time_ and arg_149_1.time_ < var_152_1 + var_152_2 and not isNil(var_152_0) then
				local var_152_3 = (arg_149_1.time_ - var_152_1) / var_152_2

				if arg_149_1.var_.characterEffect1028ui_story and not isNil(var_152_0) then
					arg_149_1.var_.characterEffect1028ui_story.fillFlat = false
				end
			end

			if arg_149_1.time_ >= var_152_1 + var_152_2 and arg_149_1.time_ < var_152_1 + var_152_2 + arg_152_0 and not isNil(var_152_0) and arg_149_1.var_.characterEffect1028ui_story then
				arg_149_1.var_.characterEffect1028ui_story.fillFlat = false
			end

			local var_152_4 = 0

			if var_152_4 < arg_149_1.time_ and arg_149_1.time_ <= var_152_4 + arg_152_0 then
				arg_149_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_152_5 = 0
			local var_152_6 = 0.775

			if var_152_5 < arg_149_1.time_ and arg_149_1.time_ <= var_152_5 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				local var_152_7 = arg_149_1:FormatText(StoryNameCfg[327].name)

				arg_149_1.leftNameTxt_.text = var_152_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_8 = arg_149_1:GetWordFromCfg(318161037)
				local var_152_9 = arg_149_1:FormatText(var_152_8.content)

				arg_149_1.text_.text = var_152_9

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_10 = 31
				local var_152_11 = utf8.len(var_152_9)
				local var_152_12 = var_152_10 <= 0 and var_152_6 or var_152_6 * (var_152_11 / var_152_10)

				if var_152_12 > 0 and var_152_6 < var_152_12 then
					arg_149_1.talkMaxDuration = var_152_12

					if var_152_12 + var_152_5 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_12 + var_152_5
					end
				end

				arg_149_1.text_.text = var_152_9
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318161", "318161037", "story_v_out_318161.awb") ~= 0 then
					local var_152_13 = manager.audio:GetVoiceLength("story_v_out_318161", "318161037", "story_v_out_318161.awb") / 1000

					if var_152_13 + var_152_5 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_13 + var_152_5
					end

					if var_152_8.prefab_name ~= "" and arg_149_1.actors_[var_152_8.prefab_name] ~= nil then
						local var_152_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_8.prefab_name].transform, "story_v_out_318161", "318161037", "story_v_out_318161.awb")

						arg_149_1:RecordAudio("318161037", var_152_14)
						arg_149_1:RecordAudio("318161037", var_152_14)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_318161", "318161037", "story_v_out_318161.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_318161", "318161037", "story_v_out_318161.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_15 = math.max(var_152_6, arg_149_1.talkMaxDuration)

			if var_152_5 <= arg_149_1.time_ and arg_149_1.time_ < var_152_5 + var_152_15 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_5) / var_152_15

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_5 + var_152_15 and arg_149_1.time_ < var_152_5 + var_152_15 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play318161038 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 318161038
		arg_153_1.duration_ = 12.1

		local var_153_0 = {
			zh = 9.266,
			ja = 12.1
		}
		local var_153_1 = manager.audio:GetLocalizationFlag()

		if var_153_0[var_153_1] ~= nil then
			arg_153_1.duration_ = var_153_0[var_153_1]
		end

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play318161039(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = 0
			local var_156_1 = 1.175

			if var_156_0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_0 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				local var_156_2 = arg_153_1:FormatText(StoryNameCfg[327].name)

				arg_153_1.leftNameTxt_.text = var_156_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_3 = arg_153_1:GetWordFromCfg(318161038)
				local var_156_4 = arg_153_1:FormatText(var_156_3.content)

				arg_153_1.text_.text = var_156_4

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_5 = 47
				local var_156_6 = utf8.len(var_156_4)
				local var_156_7 = var_156_5 <= 0 and var_156_1 or var_156_1 * (var_156_6 / var_156_5)

				if var_156_7 > 0 and var_156_1 < var_156_7 then
					arg_153_1.talkMaxDuration = var_156_7

					if var_156_7 + var_156_0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_7 + var_156_0
					end
				end

				arg_153_1.text_.text = var_156_4
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318161", "318161038", "story_v_out_318161.awb") ~= 0 then
					local var_156_8 = manager.audio:GetVoiceLength("story_v_out_318161", "318161038", "story_v_out_318161.awb") / 1000

					if var_156_8 + var_156_0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_8 + var_156_0
					end

					if var_156_3.prefab_name ~= "" and arg_153_1.actors_[var_156_3.prefab_name] ~= nil then
						local var_156_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_3.prefab_name].transform, "story_v_out_318161", "318161038", "story_v_out_318161.awb")

						arg_153_1:RecordAudio("318161038", var_156_9)
						arg_153_1:RecordAudio("318161038", var_156_9)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_318161", "318161038", "story_v_out_318161.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_318161", "318161038", "story_v_out_318161.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_10 = math.max(var_156_1, arg_153_1.talkMaxDuration)

			if var_156_0 <= arg_153_1.time_ and arg_153_1.time_ < var_156_0 + var_156_10 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_0) / var_156_10

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_0 + var_156_10 and arg_153_1.time_ < var_156_0 + var_156_10 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play318161039 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 318161039
		arg_157_1.duration_ = 5

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play318161040(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = arg_157_1.actors_["1028ui_story"]
			local var_160_1 = 0

			if var_160_1 < arg_157_1.time_ and arg_157_1.time_ <= var_160_1 + arg_160_0 and not isNil(var_160_0) and arg_157_1.var_.characterEffect1028ui_story == nil then
				arg_157_1.var_.characterEffect1028ui_story = var_160_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_2 = 0.200000002980232

			if var_160_1 <= arg_157_1.time_ and arg_157_1.time_ < var_160_1 + var_160_2 and not isNil(var_160_0) then
				local var_160_3 = (arg_157_1.time_ - var_160_1) / var_160_2

				if arg_157_1.var_.characterEffect1028ui_story and not isNil(var_160_0) then
					local var_160_4 = Mathf.Lerp(0, 0.5, var_160_3)

					arg_157_1.var_.characterEffect1028ui_story.fillFlat = true
					arg_157_1.var_.characterEffect1028ui_story.fillRatio = var_160_4
				end
			end

			if arg_157_1.time_ >= var_160_1 + var_160_2 and arg_157_1.time_ < var_160_1 + var_160_2 + arg_160_0 and not isNil(var_160_0) and arg_157_1.var_.characterEffect1028ui_story then
				local var_160_5 = 0.5

				arg_157_1.var_.characterEffect1028ui_story.fillFlat = true
				arg_157_1.var_.characterEffect1028ui_story.fillRatio = var_160_5
			end

			local var_160_6 = 0
			local var_160_7 = 0.95

			if var_160_6 < arg_157_1.time_ and arg_157_1.time_ <= var_160_6 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, false)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_8 = arg_157_1:GetWordFromCfg(318161039)
				local var_160_9 = arg_157_1:FormatText(var_160_8.content)

				arg_157_1.text_.text = var_160_9

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_10 = 38
				local var_160_11 = utf8.len(var_160_9)
				local var_160_12 = var_160_10 <= 0 and var_160_7 or var_160_7 * (var_160_11 / var_160_10)

				if var_160_12 > 0 and var_160_7 < var_160_12 then
					arg_157_1.talkMaxDuration = var_160_12

					if var_160_12 + var_160_6 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_12 + var_160_6
					end
				end

				arg_157_1.text_.text = var_160_9
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)
				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_13 = math.max(var_160_7, arg_157_1.talkMaxDuration)

			if var_160_6 <= arg_157_1.time_ and arg_157_1.time_ < var_160_6 + var_160_13 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_6) / var_160_13

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_6 + var_160_13 and arg_157_1.time_ < var_160_6 + var_160_13 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play318161040 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 318161040
		arg_161_1.duration_ = 7.63

		local var_161_0 = {
			zh = 7.633,
			ja = 5.133
		}
		local var_161_1 = manager.audio:GetLocalizationFlag()

		if var_161_0[var_161_1] ~= nil then
			arg_161_1.duration_ = var_161_0[var_161_1]
		end

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play318161041(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = arg_161_1.actors_["1019ui_story"]
			local var_164_1 = 0

			if var_164_1 < arg_161_1.time_ and arg_161_1.time_ <= var_164_1 + arg_164_0 and not isNil(var_164_0) and arg_161_1.var_.characterEffect1019ui_story == nil then
				arg_161_1.var_.characterEffect1019ui_story = var_164_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_2 = 0.200000002980232

			if var_164_1 <= arg_161_1.time_ and arg_161_1.time_ < var_164_1 + var_164_2 and not isNil(var_164_0) then
				local var_164_3 = (arg_161_1.time_ - var_164_1) / var_164_2

				if arg_161_1.var_.characterEffect1019ui_story and not isNil(var_164_0) then
					arg_161_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_161_1.time_ >= var_164_1 + var_164_2 and arg_161_1.time_ < var_164_1 + var_164_2 + arg_164_0 and not isNil(var_164_0) and arg_161_1.var_.characterEffect1019ui_story then
				arg_161_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_164_4 = 0

			if var_164_4 < arg_161_1.time_ and arg_161_1.time_ <= var_164_4 + arg_164_0 then
				arg_161_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action1_1")
			end

			local var_164_5 = 0

			if var_164_5 < arg_161_1.time_ and arg_161_1.time_ <= var_164_5 + arg_164_0 then
				arg_161_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_164_6 = 0
			local var_164_7 = 0.75

			if var_164_6 < arg_161_1.time_ and arg_161_1.time_ <= var_164_6 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				local var_164_8 = arg_161_1:FormatText(StoryNameCfg[13].name)

				arg_161_1.leftNameTxt_.text = var_164_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_9 = arg_161_1:GetWordFromCfg(318161040)
				local var_164_10 = arg_161_1:FormatText(var_164_9.content)

				arg_161_1.text_.text = var_164_10

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_11 = 30
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

				if manager.audio:GetVoiceLength("story_v_out_318161", "318161040", "story_v_out_318161.awb") ~= 0 then
					local var_164_14 = manager.audio:GetVoiceLength("story_v_out_318161", "318161040", "story_v_out_318161.awb") / 1000

					if var_164_14 + var_164_6 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_14 + var_164_6
					end

					if var_164_9.prefab_name ~= "" and arg_161_1.actors_[var_164_9.prefab_name] ~= nil then
						local var_164_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_9.prefab_name].transform, "story_v_out_318161", "318161040", "story_v_out_318161.awb")

						arg_161_1:RecordAudio("318161040", var_164_15)
						arg_161_1:RecordAudio("318161040", var_164_15)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_318161", "318161040", "story_v_out_318161.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_318161", "318161040", "story_v_out_318161.awb")
				end

				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_16 = math.max(var_164_7, arg_161_1.talkMaxDuration)

			if var_164_6 <= arg_161_1.time_ and arg_161_1.time_ < var_164_6 + var_164_16 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_6) / var_164_16

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_6 + var_164_16 and arg_161_1.time_ < var_164_6 + var_164_16 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play318161041 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 318161041
		arg_165_1.duration_ = 5.6

		local var_165_0 = {
			zh = 1.5,
			ja = 5.6
		}
		local var_165_1 = manager.audio:GetLocalizationFlag()

		if var_165_0[var_165_1] ~= nil then
			arg_165_1.duration_ = var_165_0[var_165_1]
		end

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play318161042(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = 0
			local var_168_1 = 0.15

			if var_168_0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_0 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				local var_168_2 = arg_165_1:FormatText(StoryNameCfg[13].name)

				arg_165_1.leftNameTxt_.text = var_168_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_3 = arg_165_1:GetWordFromCfg(318161041)
				local var_168_4 = arg_165_1:FormatText(var_168_3.content)

				arg_165_1.text_.text = var_168_4

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_5 = 6
				local var_168_6 = utf8.len(var_168_4)
				local var_168_7 = var_168_5 <= 0 and var_168_1 or var_168_1 * (var_168_6 / var_168_5)

				if var_168_7 > 0 and var_168_1 < var_168_7 then
					arg_165_1.talkMaxDuration = var_168_7

					if var_168_7 + var_168_0 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_7 + var_168_0
					end
				end

				arg_165_1.text_.text = var_168_4
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318161", "318161041", "story_v_out_318161.awb") ~= 0 then
					local var_168_8 = manager.audio:GetVoiceLength("story_v_out_318161", "318161041", "story_v_out_318161.awb") / 1000

					if var_168_8 + var_168_0 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_8 + var_168_0
					end

					if var_168_3.prefab_name ~= "" and arg_165_1.actors_[var_168_3.prefab_name] ~= nil then
						local var_168_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_3.prefab_name].transform, "story_v_out_318161", "318161041", "story_v_out_318161.awb")

						arg_165_1:RecordAudio("318161041", var_168_9)
						arg_165_1:RecordAudio("318161041", var_168_9)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_318161", "318161041", "story_v_out_318161.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_318161", "318161041", "story_v_out_318161.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_10 = math.max(var_168_1, arg_165_1.talkMaxDuration)

			if var_168_0 <= arg_165_1.time_ and arg_165_1.time_ < var_168_0 + var_168_10 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_0) / var_168_10

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_0 + var_168_10 and arg_165_1.time_ < var_168_0 + var_168_10 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play318161042 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 318161042
		arg_169_1.duration_ = 9

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play318161043(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = "ST12"

			if arg_169_1.bgs_[var_172_0] == nil then
				local var_172_1 = Object.Instantiate(arg_169_1.paintGo_)

				var_172_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_172_0)
				var_172_1.name = var_172_0
				var_172_1.transform.parent = arg_169_1.stage_.transform
				var_172_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_169_1.bgs_[var_172_0] = var_172_1
			end

			local var_172_2 = 2

			if var_172_2 < arg_169_1.time_ and arg_169_1.time_ <= var_172_2 + arg_172_0 then
				local var_172_3 = manager.ui.mainCamera.transform.localPosition
				local var_172_4 = Vector3.New(0, 0, 10) + Vector3.New(var_172_3.x, var_172_3.y, 0)
				local var_172_5 = arg_169_1.bgs_.ST12

				var_172_5.transform.localPosition = var_172_4
				var_172_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_172_6 = var_172_5:GetComponent("SpriteRenderer")

				if var_172_6 and var_172_6.sprite then
					local var_172_7 = (var_172_5.transform.localPosition - var_172_3).z
					local var_172_8 = manager.ui.mainCameraCom_
					local var_172_9 = 2 * var_172_7 * Mathf.Tan(var_172_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_172_10 = var_172_9 * var_172_8.aspect
					local var_172_11 = var_172_6.sprite.bounds.size.x
					local var_172_12 = var_172_6.sprite.bounds.size.y
					local var_172_13 = var_172_10 / var_172_11
					local var_172_14 = var_172_9 / var_172_12
					local var_172_15 = var_172_14 < var_172_13 and var_172_13 or var_172_14

					var_172_5.transform.localScale = Vector3.New(var_172_15, var_172_15, 0)
				end

				for iter_172_0, iter_172_1 in pairs(arg_169_1.bgs_) do
					if iter_172_0 ~= "ST12" then
						iter_172_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_172_16 = 0

			if var_172_16 < arg_169_1.time_ and arg_169_1.time_ <= var_172_16 + arg_172_0 then
				arg_169_1.mask_.enabled = true
				arg_169_1.mask_.raycastTarget = true

				arg_169_1:SetGaussion(false)
			end

			local var_172_17 = 2

			if var_172_16 <= arg_169_1.time_ and arg_169_1.time_ < var_172_16 + var_172_17 then
				local var_172_18 = (arg_169_1.time_ - var_172_16) / var_172_17
				local var_172_19 = Color.New(0, 0, 0)

				var_172_19.a = Mathf.Lerp(0, 1, var_172_18)
				arg_169_1.mask_.color = var_172_19
			end

			if arg_169_1.time_ >= var_172_16 + var_172_17 and arg_169_1.time_ < var_172_16 + var_172_17 + arg_172_0 then
				local var_172_20 = Color.New(0, 0, 0)

				var_172_20.a = 1
				arg_169_1.mask_.color = var_172_20
			end

			local var_172_21 = 2

			if var_172_21 < arg_169_1.time_ and arg_169_1.time_ <= var_172_21 + arg_172_0 then
				arg_169_1.mask_.enabled = true
				arg_169_1.mask_.raycastTarget = true

				arg_169_1:SetGaussion(false)
			end

			local var_172_22 = 2

			if var_172_21 <= arg_169_1.time_ and arg_169_1.time_ < var_172_21 + var_172_22 then
				local var_172_23 = (arg_169_1.time_ - var_172_21) / var_172_22
				local var_172_24 = Color.New(0, 0, 0)

				var_172_24.a = Mathf.Lerp(1, 0, var_172_23)
				arg_169_1.mask_.color = var_172_24
			end

			if arg_169_1.time_ >= var_172_21 + var_172_22 and arg_169_1.time_ < var_172_21 + var_172_22 + arg_172_0 then
				local var_172_25 = Color.New(0, 0, 0)
				local var_172_26 = 0

				arg_169_1.mask_.enabled = false
				var_172_25.a = var_172_26
				arg_169_1.mask_.color = var_172_25
			end

			local var_172_27 = arg_169_1.actors_["1019ui_story"].transform
			local var_172_28 = 2

			if var_172_28 < arg_169_1.time_ and arg_169_1.time_ <= var_172_28 + arg_172_0 then
				arg_169_1.var_.moveOldPos1019ui_story = var_172_27.localPosition
			end

			local var_172_29 = 0.001

			if var_172_28 <= arg_169_1.time_ and arg_169_1.time_ < var_172_28 + var_172_29 then
				local var_172_30 = (arg_169_1.time_ - var_172_28) / var_172_29
				local var_172_31 = Vector3.New(0, 100, 0)

				var_172_27.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPos1019ui_story, var_172_31, var_172_30)

				local var_172_32 = manager.ui.mainCamera.transform.position - var_172_27.position

				var_172_27.forward = Vector3.New(var_172_32.x, var_172_32.y, var_172_32.z)

				local var_172_33 = var_172_27.localEulerAngles

				var_172_33.z = 0
				var_172_33.x = 0
				var_172_27.localEulerAngles = var_172_33
			end

			if arg_169_1.time_ >= var_172_28 + var_172_29 and arg_169_1.time_ < var_172_28 + var_172_29 + arg_172_0 then
				var_172_27.localPosition = Vector3.New(0, 100, 0)

				local var_172_34 = manager.ui.mainCamera.transform.position - var_172_27.position

				var_172_27.forward = Vector3.New(var_172_34.x, var_172_34.y, var_172_34.z)

				local var_172_35 = var_172_27.localEulerAngles

				var_172_35.z = 0
				var_172_35.x = 0
				var_172_27.localEulerAngles = var_172_35
			end

			local var_172_36 = arg_169_1.actors_["1019ui_story"]
			local var_172_37 = 2

			if var_172_37 < arg_169_1.time_ and arg_169_1.time_ <= var_172_37 + arg_172_0 and not isNil(var_172_36) and arg_169_1.var_.characterEffect1019ui_story == nil then
				arg_169_1.var_.characterEffect1019ui_story = var_172_36:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_38 = 0.200000002980232

			if var_172_37 <= arg_169_1.time_ and arg_169_1.time_ < var_172_37 + var_172_38 and not isNil(var_172_36) then
				local var_172_39 = (arg_169_1.time_ - var_172_37) / var_172_38

				if arg_169_1.var_.characterEffect1019ui_story and not isNil(var_172_36) then
					local var_172_40 = Mathf.Lerp(0, 0.5, var_172_39)

					arg_169_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_169_1.var_.characterEffect1019ui_story.fillRatio = var_172_40
				end
			end

			if arg_169_1.time_ >= var_172_37 + var_172_38 and arg_169_1.time_ < var_172_37 + var_172_38 + arg_172_0 and not isNil(var_172_36) and arg_169_1.var_.characterEffect1019ui_story then
				local var_172_41 = 0.5

				arg_169_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_169_1.var_.characterEffect1019ui_story.fillRatio = var_172_41
			end

			local var_172_42 = arg_169_1.actors_["1028ui_story"].transform
			local var_172_43 = 2

			if var_172_43 < arg_169_1.time_ and arg_169_1.time_ <= var_172_43 + arg_172_0 then
				arg_169_1.var_.moveOldPos1028ui_story = var_172_42.localPosition
			end

			local var_172_44 = 0.001

			if var_172_43 <= arg_169_1.time_ and arg_169_1.time_ < var_172_43 + var_172_44 then
				local var_172_45 = (arg_169_1.time_ - var_172_43) / var_172_44
				local var_172_46 = Vector3.New(0, 100, 0)

				var_172_42.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPos1028ui_story, var_172_46, var_172_45)

				local var_172_47 = manager.ui.mainCamera.transform.position - var_172_42.position

				var_172_42.forward = Vector3.New(var_172_47.x, var_172_47.y, var_172_47.z)

				local var_172_48 = var_172_42.localEulerAngles

				var_172_48.z = 0
				var_172_48.x = 0
				var_172_42.localEulerAngles = var_172_48
			end

			if arg_169_1.time_ >= var_172_43 + var_172_44 and arg_169_1.time_ < var_172_43 + var_172_44 + arg_172_0 then
				var_172_42.localPosition = Vector3.New(0, 100, 0)

				local var_172_49 = manager.ui.mainCamera.transform.position - var_172_42.position

				var_172_42.forward = Vector3.New(var_172_49.x, var_172_49.y, var_172_49.z)

				local var_172_50 = var_172_42.localEulerAngles

				var_172_50.z = 0
				var_172_50.x = 0
				var_172_42.localEulerAngles = var_172_50
			end

			if arg_169_1.frameCnt_ <= 1 then
				arg_169_1.dialog_:SetActive(false)
			end

			local var_172_51 = 4
			local var_172_52 = 0.475

			if var_172_51 < arg_169_1.time_ and arg_169_1.time_ <= var_172_51 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0

				arg_169_1.dialog_:SetActive(true)

				arg_169_1.dialogCg_.alpha = 0

				local var_172_53 = LeanTween.value(arg_169_1.dialog_, 0, 1, 0.3)

				var_172_53:setOnUpdate(LuaHelper.FloatAction(function(arg_173_0)
					arg_169_1.dialogCg_.alpha = arg_173_0
				end))
				var_172_53:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_169_1.dialog_)
					var_172_53:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_169_1.duration_ = arg_169_1.duration_ + 0.3

				SetActive(arg_169_1.leftNameGo_, false)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_54 = arg_169_1:GetWordFromCfg(318161042)
				local var_172_55 = arg_169_1:FormatText(var_172_54.content)

				arg_169_1.text_.text = var_172_55

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_56 = 19
				local var_172_57 = utf8.len(var_172_55)
				local var_172_58 = var_172_56 <= 0 and var_172_52 or var_172_52 * (var_172_57 / var_172_56)

				if var_172_58 > 0 and var_172_52 < var_172_58 then
					arg_169_1.talkMaxDuration = var_172_58
					var_172_51 = var_172_51 + 0.3

					if var_172_58 + var_172_51 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_58 + var_172_51
					end
				end

				arg_169_1.text_.text = var_172_55
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)
				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_59 = var_172_51 + 0.3
			local var_172_60 = math.max(var_172_52, arg_169_1.talkMaxDuration)

			if var_172_59 <= arg_169_1.time_ and arg_169_1.time_ < var_172_59 + var_172_60 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_59) / var_172_60

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_59 + var_172_60 and arg_169_1.time_ < var_172_59 + var_172_60 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1028ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_169_1:InitPlayNodeList()
	end,
	Play318161043 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 318161043
		arg_175_1.duration_ = 5

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play318161044(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = 0
			local var_178_1 = 0.825

			if var_178_0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_0 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, false)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_2 = arg_175_1:GetWordFromCfg(318161043)
				local var_178_3 = arg_175_1:FormatText(var_178_2.content)

				arg_175_1.text_.text = var_178_3

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_4 = 33
				local var_178_5 = utf8.len(var_178_3)
				local var_178_6 = var_178_4 <= 0 and var_178_1 or var_178_1 * (var_178_5 / var_178_4)

				if var_178_6 > 0 and var_178_1 < var_178_6 then
					arg_175_1.talkMaxDuration = var_178_6

					if var_178_6 + var_178_0 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_6 + var_178_0
					end
				end

				arg_175_1.text_.text = var_178_3
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)
				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_7 = math.max(var_178_1, arg_175_1.talkMaxDuration)

			if var_178_0 <= arg_175_1.time_ and arg_175_1.time_ < var_178_0 + var_178_7 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_0) / var_178_7

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_0 + var_178_7 and arg_175_1.time_ < var_178_0 + var_178_7 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {}

		arg_175_1:InitPlayNodeList()
	end,
	Play318161044 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 318161044
		arg_179_1.duration_ = 9.73

		local var_179_0 = {
			zh = 9.733,
			ja = 7.666
		}
		local var_179_1 = manager.audio:GetLocalizationFlag()

		if var_179_0[var_179_1] ~= nil then
			arg_179_1.duration_ = var_179_0[var_179_1]
		end

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play318161045(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = arg_179_1.actors_["1019ui_story"].transform
			local var_182_1 = 0

			if var_182_1 < arg_179_1.time_ and arg_179_1.time_ <= var_182_1 + arg_182_0 then
				arg_179_1.var_.moveOldPos1019ui_story = var_182_0.localPosition
			end

			local var_182_2 = 0.001

			if var_182_1 <= arg_179_1.time_ and arg_179_1.time_ < var_182_1 + var_182_2 then
				local var_182_3 = (arg_179_1.time_ - var_182_1) / var_182_2
				local var_182_4 = Vector3.New(-0.2, -1.08, -5.9)

				var_182_0.localPosition = Vector3.Lerp(arg_179_1.var_.moveOldPos1019ui_story, var_182_4, var_182_3)

				local var_182_5 = manager.ui.mainCamera.transform.position - var_182_0.position

				var_182_0.forward = Vector3.New(var_182_5.x, var_182_5.y, var_182_5.z)

				local var_182_6 = var_182_0.localEulerAngles

				var_182_6.z = 0
				var_182_6.x = 0
				var_182_0.localEulerAngles = var_182_6
			end

			if arg_179_1.time_ >= var_182_1 + var_182_2 and arg_179_1.time_ < var_182_1 + var_182_2 + arg_182_0 then
				var_182_0.localPosition = Vector3.New(-0.2, -1.08, -5.9)

				local var_182_7 = manager.ui.mainCamera.transform.position - var_182_0.position

				var_182_0.forward = Vector3.New(var_182_7.x, var_182_7.y, var_182_7.z)

				local var_182_8 = var_182_0.localEulerAngles

				var_182_8.z = 0
				var_182_8.x = 0
				var_182_0.localEulerAngles = var_182_8
			end

			local var_182_9 = arg_179_1.actors_["1019ui_story"]
			local var_182_10 = 0

			if var_182_10 < arg_179_1.time_ and arg_179_1.time_ <= var_182_10 + arg_182_0 and not isNil(var_182_9) and arg_179_1.var_.characterEffect1019ui_story == nil then
				arg_179_1.var_.characterEffect1019ui_story = var_182_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_182_11 = 0.200000002980232

			if var_182_10 <= arg_179_1.time_ and arg_179_1.time_ < var_182_10 + var_182_11 and not isNil(var_182_9) then
				local var_182_12 = (arg_179_1.time_ - var_182_10) / var_182_11

				if arg_179_1.var_.characterEffect1019ui_story and not isNil(var_182_9) then
					arg_179_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_179_1.time_ >= var_182_10 + var_182_11 and arg_179_1.time_ < var_182_10 + var_182_11 + arg_182_0 and not isNil(var_182_9) and arg_179_1.var_.characterEffect1019ui_story then
				arg_179_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_182_13 = 0

			if var_182_13 < arg_179_1.time_ and arg_179_1.time_ <= var_182_13 + arg_182_0 then
				arg_179_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action6_1")
			end

			local var_182_14 = 0
			local var_182_15 = 0.85

			if var_182_14 < arg_179_1.time_ and arg_179_1.time_ <= var_182_14 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				local var_182_16 = arg_179_1:FormatText(StoryNameCfg[13].name)

				arg_179_1.leftNameTxt_.text = var_182_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_17 = arg_179_1:GetWordFromCfg(318161044)
				local var_182_18 = arg_179_1:FormatText(var_182_17.content)

				arg_179_1.text_.text = var_182_18

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_19 = 34
				local var_182_20 = utf8.len(var_182_18)
				local var_182_21 = var_182_19 <= 0 and var_182_15 or var_182_15 * (var_182_20 / var_182_19)

				if var_182_21 > 0 and var_182_15 < var_182_21 then
					arg_179_1.talkMaxDuration = var_182_21

					if var_182_21 + var_182_14 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_21 + var_182_14
					end
				end

				arg_179_1.text_.text = var_182_18
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318161", "318161044", "story_v_out_318161.awb") ~= 0 then
					local var_182_22 = manager.audio:GetVoiceLength("story_v_out_318161", "318161044", "story_v_out_318161.awb") / 1000

					if var_182_22 + var_182_14 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_22 + var_182_14
					end

					if var_182_17.prefab_name ~= "" and arg_179_1.actors_[var_182_17.prefab_name] ~= nil then
						local var_182_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_17.prefab_name].transform, "story_v_out_318161", "318161044", "story_v_out_318161.awb")

						arg_179_1:RecordAudio("318161044", var_182_23)
						arg_179_1:RecordAudio("318161044", var_182_23)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_out_318161", "318161044", "story_v_out_318161.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_out_318161", "318161044", "story_v_out_318161.awb")
				end

				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_24 = math.max(var_182_15, arg_179_1.talkMaxDuration)

			if var_182_14 <= arg_179_1.time_ and arg_179_1.time_ < var_182_14 + var_182_24 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_14) / var_182_24

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_14 + var_182_24 and arg_179_1.time_ < var_182_14 + var_182_24 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {
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

		arg_179_1:InitPlayNodeList()
	end,
	Play318161045 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 318161045
		arg_183_1.duration_ = 5

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play318161046(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = arg_183_1.actors_["1019ui_story"]
			local var_186_1 = 0

			if var_186_1 < arg_183_1.time_ and arg_183_1.time_ <= var_186_1 + arg_186_0 and not isNil(var_186_0) and arg_183_1.var_.characterEffect1019ui_story == nil then
				arg_183_1.var_.characterEffect1019ui_story = var_186_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_186_2 = 0.200000002980232

			if var_186_1 <= arg_183_1.time_ and arg_183_1.time_ < var_186_1 + var_186_2 and not isNil(var_186_0) then
				local var_186_3 = (arg_183_1.time_ - var_186_1) / var_186_2

				if arg_183_1.var_.characterEffect1019ui_story and not isNil(var_186_0) then
					local var_186_4 = Mathf.Lerp(0, 0.5, var_186_3)

					arg_183_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_183_1.var_.characterEffect1019ui_story.fillRatio = var_186_4
				end
			end

			if arg_183_1.time_ >= var_186_1 + var_186_2 and arg_183_1.time_ < var_186_1 + var_186_2 + arg_186_0 and not isNil(var_186_0) and arg_183_1.var_.characterEffect1019ui_story then
				local var_186_5 = 0.5

				arg_183_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_183_1.var_.characterEffect1019ui_story.fillRatio = var_186_5
			end

			local var_186_6 = 0
			local var_186_7 = 0.975

			if var_186_6 < arg_183_1.time_ and arg_183_1.time_ <= var_186_6 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, false)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_8 = arg_183_1:GetWordFromCfg(318161045)
				local var_186_9 = arg_183_1:FormatText(var_186_8.content)

				arg_183_1.text_.text = var_186_9

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_10 = 39
				local var_186_11 = utf8.len(var_186_9)
				local var_186_12 = var_186_10 <= 0 and var_186_7 or var_186_7 * (var_186_11 / var_186_10)

				if var_186_12 > 0 and var_186_7 < var_186_12 then
					arg_183_1.talkMaxDuration = var_186_12

					if var_186_12 + var_186_6 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_12 + var_186_6
					end
				end

				arg_183_1.text_.text = var_186_9
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)
				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_13 = math.max(var_186_7, arg_183_1.talkMaxDuration)

			if var_186_6 <= arg_183_1.time_ and arg_183_1.time_ < var_186_6 + var_186_13 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_6) / var_186_13

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_6 + var_186_13 and arg_183_1.time_ < var_186_6 + var_186_13 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {}

		arg_183_1:InitPlayNodeList()
	end,
	Play318161046 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 318161046
		arg_187_1.duration_ = 5

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play318161047(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = 0
			local var_190_1 = 1.05

			if var_190_0 < arg_187_1.time_ and arg_187_1.time_ <= var_190_0 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, false)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_2 = arg_187_1:GetWordFromCfg(318161046)
				local var_190_3 = arg_187_1:FormatText(var_190_2.content)

				arg_187_1.text_.text = var_190_3

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_4 = 42
				local var_190_5 = utf8.len(var_190_3)
				local var_190_6 = var_190_4 <= 0 and var_190_1 or var_190_1 * (var_190_5 / var_190_4)

				if var_190_6 > 0 and var_190_1 < var_190_6 then
					arg_187_1.talkMaxDuration = var_190_6

					if var_190_6 + var_190_0 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_6 + var_190_0
					end
				end

				arg_187_1.text_.text = var_190_3
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)
				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_7 = math.max(var_190_1, arg_187_1.talkMaxDuration)

			if var_190_0 <= arg_187_1.time_ and arg_187_1.time_ < var_190_0 + var_190_7 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_0) / var_190_7

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_0 + var_190_7 and arg_187_1.time_ < var_190_0 + var_190_7 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play318161047 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 318161047
		arg_191_1.duration_ = 5

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play318161048(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = 0

			if var_194_0 < arg_191_1.time_ and arg_191_1.time_ <= var_194_0 + arg_194_0 then
				arg_191_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action6_2")
			end

			local var_194_1 = 0

			if var_194_1 < arg_191_1.time_ and arg_191_1.time_ <= var_194_1 + arg_194_0 then
				arg_191_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_194_2 = 0
			local var_194_3 = 1

			if var_194_2 < arg_191_1.time_ and arg_191_1.time_ <= var_194_2 + arg_194_0 then
				local var_194_4 = "play"
				local var_194_5 = "effect"

				arg_191_1:AudioAction(var_194_4, var_194_5, "se_story_17", "se_story_17_ui", "")
			end

			local var_194_6 = 0
			local var_194_7 = 0.775

			if var_194_6 < arg_191_1.time_ and arg_191_1.time_ <= var_194_6 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, false)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_8 = arg_191_1:GetWordFromCfg(318161047)
				local var_194_9 = arg_191_1:FormatText(var_194_8.content)

				arg_191_1.text_.text = var_194_9

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_10 = 31
				local var_194_11 = utf8.len(var_194_9)
				local var_194_12 = var_194_10 <= 0 and var_194_7 or var_194_7 * (var_194_11 / var_194_10)

				if var_194_12 > 0 and var_194_7 < var_194_12 then
					arg_191_1.talkMaxDuration = var_194_12

					if var_194_12 + var_194_6 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_12 + var_194_6
					end
				end

				arg_191_1.text_.text = var_194_9
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)
				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_13 = math.max(var_194_7, arg_191_1.talkMaxDuration)

			if var_194_6 <= arg_191_1.time_ and arg_191_1.time_ < var_194_6 + var_194_13 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_6) / var_194_13

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_6 + var_194_13 and arg_191_1.time_ < var_194_6 + var_194_13 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {}

		arg_191_1:InitPlayNodeList()
	end,
	Play318161048 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 318161048
		arg_195_1.duration_ = 2.67

		local var_195_0 = {
			zh = 2.666,
			ja = 2.633
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
				arg_195_0:Play318161049(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = arg_195_1.actors_["1019ui_story"]
			local var_198_1 = 0

			if var_198_1 < arg_195_1.time_ and arg_195_1.time_ <= var_198_1 + arg_198_0 and not isNil(var_198_0) and arg_195_1.var_.characterEffect1019ui_story == nil then
				arg_195_1.var_.characterEffect1019ui_story = var_198_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_198_2 = 0.200000002980232

			if var_198_1 <= arg_195_1.time_ and arg_195_1.time_ < var_198_1 + var_198_2 and not isNil(var_198_0) then
				local var_198_3 = (arg_195_1.time_ - var_198_1) / var_198_2

				if arg_195_1.var_.characterEffect1019ui_story and not isNil(var_198_0) then
					arg_195_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_195_1.time_ >= var_198_1 + var_198_2 and arg_195_1.time_ < var_198_1 + var_198_2 + arg_198_0 and not isNil(var_198_0) and arg_195_1.var_.characterEffect1019ui_story then
				arg_195_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_198_4 = 0
			local var_198_5 = 0.2

			if var_198_4 < arg_195_1.time_ and arg_195_1.time_ <= var_198_4 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				local var_198_6 = arg_195_1:FormatText(StoryNameCfg[13].name)

				arg_195_1.leftNameTxt_.text = var_198_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_7 = arg_195_1:GetWordFromCfg(318161048)
				local var_198_8 = arg_195_1:FormatText(var_198_7.content)

				arg_195_1.text_.text = var_198_8

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_9 = 8
				local var_198_10 = utf8.len(var_198_8)
				local var_198_11 = var_198_9 <= 0 and var_198_5 or var_198_5 * (var_198_10 / var_198_9)

				if var_198_11 > 0 and var_198_5 < var_198_11 then
					arg_195_1.talkMaxDuration = var_198_11

					if var_198_11 + var_198_4 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_11 + var_198_4
					end
				end

				arg_195_1.text_.text = var_198_8
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318161", "318161048", "story_v_out_318161.awb") ~= 0 then
					local var_198_12 = manager.audio:GetVoiceLength("story_v_out_318161", "318161048", "story_v_out_318161.awb") / 1000

					if var_198_12 + var_198_4 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_12 + var_198_4
					end

					if var_198_7.prefab_name ~= "" and arg_195_1.actors_[var_198_7.prefab_name] ~= nil then
						local var_198_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_7.prefab_name].transform, "story_v_out_318161", "318161048", "story_v_out_318161.awb")

						arg_195_1:RecordAudio("318161048", var_198_13)
						arg_195_1:RecordAudio("318161048", var_198_13)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_out_318161", "318161048", "story_v_out_318161.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_out_318161", "318161048", "story_v_out_318161.awb")
				end

				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_14 = math.max(var_198_5, arg_195_1.talkMaxDuration)

			if var_198_4 <= arg_195_1.time_ and arg_195_1.time_ < var_198_4 + var_198_14 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_4) / var_198_14

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_4 + var_198_14 and arg_195_1.time_ < var_198_4 + var_198_14 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {}

		arg_195_1:InitPlayNodeList()
	end,
	Play318161049 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 318161049
		arg_199_1.duration_ = 5

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play318161050(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = arg_199_1.actors_["1019ui_story"]
			local var_202_1 = 0

			if var_202_1 < arg_199_1.time_ and arg_199_1.time_ <= var_202_1 + arg_202_0 and not isNil(var_202_0) and arg_199_1.var_.characterEffect1019ui_story == nil then
				arg_199_1.var_.characterEffect1019ui_story = var_202_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_202_2 = 0.200000002980232

			if var_202_1 <= arg_199_1.time_ and arg_199_1.time_ < var_202_1 + var_202_2 and not isNil(var_202_0) then
				local var_202_3 = (arg_199_1.time_ - var_202_1) / var_202_2

				if arg_199_1.var_.characterEffect1019ui_story and not isNil(var_202_0) then
					local var_202_4 = Mathf.Lerp(0, 0.5, var_202_3)

					arg_199_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_199_1.var_.characterEffect1019ui_story.fillRatio = var_202_4
				end
			end

			if arg_199_1.time_ >= var_202_1 + var_202_2 and arg_199_1.time_ < var_202_1 + var_202_2 + arg_202_0 and not isNil(var_202_0) and arg_199_1.var_.characterEffect1019ui_story then
				local var_202_5 = 0.5

				arg_199_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_199_1.var_.characterEffect1019ui_story.fillRatio = var_202_5
			end

			local var_202_6 = 0
			local var_202_7 = 0.675

			if var_202_6 < arg_199_1.time_ and arg_199_1.time_ <= var_202_6 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, false)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_8 = arg_199_1:GetWordFromCfg(318161049)
				local var_202_9 = arg_199_1:FormatText(var_202_8.content)

				arg_199_1.text_.text = var_202_9

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_10 = 27
				local var_202_11 = utf8.len(var_202_9)
				local var_202_12 = var_202_10 <= 0 and var_202_7 or var_202_7 * (var_202_11 / var_202_10)

				if var_202_12 > 0 and var_202_7 < var_202_12 then
					arg_199_1.talkMaxDuration = var_202_12

					if var_202_12 + var_202_6 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_12 + var_202_6
					end
				end

				arg_199_1.text_.text = var_202_9
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)
				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_13 = math.max(var_202_7, arg_199_1.talkMaxDuration)

			if var_202_6 <= arg_199_1.time_ and arg_199_1.time_ < var_202_6 + var_202_13 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_6) / var_202_13

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_6 + var_202_13 and arg_199_1.time_ < var_202_6 + var_202_13 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {}

		arg_199_1:InitPlayNodeList()
	end,
	Play318161050 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 318161050
		arg_203_1.duration_ = 9.9

		local var_203_0 = {
			zh = 9.9,
			ja = 8.2
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
				arg_203_0:Play318161051(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			local var_206_0 = arg_203_1.actors_["1019ui_story"].transform
			local var_206_1 = 0

			if var_206_1 < arg_203_1.time_ and arg_203_1.time_ <= var_206_1 + arg_206_0 then
				arg_203_1.var_.moveOldPos1019ui_story = var_206_0.localPosition
			end

			local var_206_2 = 0.001

			if var_206_1 <= arg_203_1.time_ and arg_203_1.time_ < var_206_1 + var_206_2 then
				local var_206_3 = (arg_203_1.time_ - var_206_1) / var_206_2
				local var_206_4 = Vector3.New(-0.2, -1.08, -5.9)

				var_206_0.localPosition = Vector3.Lerp(arg_203_1.var_.moveOldPos1019ui_story, var_206_4, var_206_3)

				local var_206_5 = manager.ui.mainCamera.transform.position - var_206_0.position

				var_206_0.forward = Vector3.New(var_206_5.x, var_206_5.y, var_206_5.z)

				local var_206_6 = var_206_0.localEulerAngles

				var_206_6.z = 0
				var_206_6.x = 0
				var_206_0.localEulerAngles = var_206_6
			end

			if arg_203_1.time_ >= var_206_1 + var_206_2 and arg_203_1.time_ < var_206_1 + var_206_2 + arg_206_0 then
				var_206_0.localPosition = Vector3.New(-0.2, -1.08, -5.9)

				local var_206_7 = manager.ui.mainCamera.transform.position - var_206_0.position

				var_206_0.forward = Vector3.New(var_206_7.x, var_206_7.y, var_206_7.z)

				local var_206_8 = var_206_0.localEulerAngles

				var_206_8.z = 0
				var_206_8.x = 0
				var_206_0.localEulerAngles = var_206_8
			end

			local var_206_9 = arg_203_1.actors_["1019ui_story"]
			local var_206_10 = 0

			if var_206_10 < arg_203_1.time_ and arg_203_1.time_ <= var_206_10 + arg_206_0 and not isNil(var_206_9) and arg_203_1.var_.characterEffect1019ui_story == nil then
				arg_203_1.var_.characterEffect1019ui_story = var_206_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_206_11 = 0.200000002980232

			if var_206_10 <= arg_203_1.time_ and arg_203_1.time_ < var_206_10 + var_206_11 and not isNil(var_206_9) then
				local var_206_12 = (arg_203_1.time_ - var_206_10) / var_206_11

				if arg_203_1.var_.characterEffect1019ui_story and not isNil(var_206_9) then
					arg_203_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_203_1.time_ >= var_206_10 + var_206_11 and arg_203_1.time_ < var_206_10 + var_206_11 + arg_206_0 and not isNil(var_206_9) and arg_203_1.var_.characterEffect1019ui_story then
				arg_203_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_206_13 = 0

			if var_206_13 < arg_203_1.time_ and arg_203_1.time_ <= var_206_13 + arg_206_0 then
				arg_203_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_206_14 = 0
			local var_206_15 = 0.95

			if var_206_14 < arg_203_1.time_ and arg_203_1.time_ <= var_206_14 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				local var_206_16 = arg_203_1:FormatText(StoryNameCfg[13].name)

				arg_203_1.leftNameTxt_.text = var_206_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_17 = arg_203_1:GetWordFromCfg(318161050)
				local var_206_18 = arg_203_1:FormatText(var_206_17.content)

				arg_203_1.text_.text = var_206_18

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_19 = 38
				local var_206_20 = utf8.len(var_206_18)
				local var_206_21 = var_206_19 <= 0 and var_206_15 or var_206_15 * (var_206_20 / var_206_19)

				if var_206_21 > 0 and var_206_15 < var_206_21 then
					arg_203_1.talkMaxDuration = var_206_21

					if var_206_21 + var_206_14 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_21 + var_206_14
					end
				end

				arg_203_1.text_.text = var_206_18
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318161", "318161050", "story_v_out_318161.awb") ~= 0 then
					local var_206_22 = manager.audio:GetVoiceLength("story_v_out_318161", "318161050", "story_v_out_318161.awb") / 1000

					if var_206_22 + var_206_14 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_22 + var_206_14
					end

					if var_206_17.prefab_name ~= "" and arg_203_1.actors_[var_206_17.prefab_name] ~= nil then
						local var_206_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_17.prefab_name].transform, "story_v_out_318161", "318161050", "story_v_out_318161.awb")

						arg_203_1:RecordAudio("318161050", var_206_23)
						arg_203_1:RecordAudio("318161050", var_206_23)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_out_318161", "318161050", "story_v_out_318161.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_out_318161", "318161050", "story_v_out_318161.awb")
				end

				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_24 = math.max(var_206_15, arg_203_1.talkMaxDuration)

			if var_206_14 <= arg_203_1.time_ and arg_203_1.time_ < var_206_14 + var_206_24 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_14) / var_206_24

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_14 + var_206_24 and arg_203_1.time_ < var_206_14 + var_206_24 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {
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

		arg_203_1:InitPlayNodeList()
	end,
	Play318161051 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 318161051
		arg_207_1.duration_ = 5

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play318161052(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			local var_210_0 = arg_207_1.actors_["1019ui_story"].transform
			local var_210_1 = 0

			if var_210_1 < arg_207_1.time_ and arg_207_1.time_ <= var_210_1 + arg_210_0 then
				arg_207_1.var_.moveOldPos1019ui_story = var_210_0.localPosition
			end

			local var_210_2 = 0.001

			if var_210_1 <= arg_207_1.time_ and arg_207_1.time_ < var_210_1 + var_210_2 then
				local var_210_3 = (arg_207_1.time_ - var_210_1) / var_210_2
				local var_210_4 = Vector3.New(0, 100, 0)

				var_210_0.localPosition = Vector3.Lerp(arg_207_1.var_.moveOldPos1019ui_story, var_210_4, var_210_3)

				local var_210_5 = manager.ui.mainCamera.transform.position - var_210_0.position

				var_210_0.forward = Vector3.New(var_210_5.x, var_210_5.y, var_210_5.z)

				local var_210_6 = var_210_0.localEulerAngles

				var_210_6.z = 0
				var_210_6.x = 0
				var_210_0.localEulerAngles = var_210_6
			end

			if arg_207_1.time_ >= var_210_1 + var_210_2 and arg_207_1.time_ < var_210_1 + var_210_2 + arg_210_0 then
				var_210_0.localPosition = Vector3.New(0, 100, 0)

				local var_210_7 = manager.ui.mainCamera.transform.position - var_210_0.position

				var_210_0.forward = Vector3.New(var_210_7.x, var_210_7.y, var_210_7.z)

				local var_210_8 = var_210_0.localEulerAngles

				var_210_8.z = 0
				var_210_8.x = 0
				var_210_0.localEulerAngles = var_210_8
			end

			local var_210_9 = arg_207_1.actors_["1019ui_story"]
			local var_210_10 = 0

			if var_210_10 < arg_207_1.time_ and arg_207_1.time_ <= var_210_10 + arg_210_0 and not isNil(var_210_9) and arg_207_1.var_.characterEffect1019ui_story == nil then
				arg_207_1.var_.characterEffect1019ui_story = var_210_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_11 = 0.200000002980232

			if var_210_10 <= arg_207_1.time_ and arg_207_1.time_ < var_210_10 + var_210_11 and not isNil(var_210_9) then
				local var_210_12 = (arg_207_1.time_ - var_210_10) / var_210_11

				if arg_207_1.var_.characterEffect1019ui_story and not isNil(var_210_9) then
					local var_210_13 = Mathf.Lerp(0, 0.5, var_210_12)

					arg_207_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_207_1.var_.characterEffect1019ui_story.fillRatio = var_210_13
				end
			end

			if arg_207_1.time_ >= var_210_10 + var_210_11 and arg_207_1.time_ < var_210_10 + var_210_11 + arg_210_0 and not isNil(var_210_9) and arg_207_1.var_.characterEffect1019ui_story then
				local var_210_14 = 0.5

				arg_207_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_207_1.var_.characterEffect1019ui_story.fillRatio = var_210_14
			end

			local var_210_15 = 0
			local var_210_16 = 0.675

			if var_210_15 < arg_207_1.time_ and arg_207_1.time_ <= var_210_15 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, false)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_17 = arg_207_1:GetWordFromCfg(318161051)
				local var_210_18 = arg_207_1:FormatText(var_210_17.content)

				arg_207_1.text_.text = var_210_18

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_19 = 27
				local var_210_20 = utf8.len(var_210_18)
				local var_210_21 = var_210_19 <= 0 and var_210_16 or var_210_16 * (var_210_20 / var_210_19)

				if var_210_21 > 0 and var_210_16 < var_210_21 then
					arg_207_1.talkMaxDuration = var_210_21

					if var_210_21 + var_210_15 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_21 + var_210_15
					end
				end

				arg_207_1.text_.text = var_210_18
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)
				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_22 = math.max(var_210_16, arg_207_1.talkMaxDuration)

			if var_210_15 <= arg_207_1.time_ and arg_207_1.time_ < var_210_15 + var_210_22 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_15) / var_210_22

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_15 + var_210_22 and arg_207_1.time_ < var_210_15 + var_210_22 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {
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

		arg_207_1:InitPlayNodeList()
	end,
	Play318161052 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 318161052
		arg_211_1.duration_ = 5

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play318161053(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			local var_214_0 = 0
			local var_214_1 = 0.25

			if var_214_0 < arg_211_1.time_ and arg_211_1.time_ <= var_214_0 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, false)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_2 = arg_211_1:GetWordFromCfg(318161052)
				local var_214_3 = arg_211_1:FormatText(var_214_2.content)

				arg_211_1.text_.text = var_214_3

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_4 = 10
				local var_214_5 = utf8.len(var_214_3)
				local var_214_6 = var_214_4 <= 0 and var_214_1 or var_214_1 * (var_214_5 / var_214_4)

				if var_214_6 > 0 and var_214_1 < var_214_6 then
					arg_211_1.talkMaxDuration = var_214_6

					if var_214_6 + var_214_0 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_6 + var_214_0
					end
				end

				arg_211_1.text_.text = var_214_3
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)
				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_7 = math.max(var_214_1, arg_211_1.talkMaxDuration)

			if var_214_0 <= arg_211_1.time_ and arg_211_1.time_ < var_214_0 + var_214_7 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_0) / var_214_7

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_0 + var_214_7 and arg_211_1.time_ < var_214_0 + var_214_7 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {}

		arg_211_1:InitPlayNodeList()
	end,
	Play318161053 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 318161053
		arg_215_1.duration_ = 2

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play318161054(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			local var_218_0 = arg_215_1.actors_["1019ui_story"].transform
			local var_218_1 = 0

			if var_218_1 < arg_215_1.time_ and arg_215_1.time_ <= var_218_1 + arg_218_0 then
				arg_215_1.var_.moveOldPos1019ui_story = var_218_0.localPosition
			end

			local var_218_2 = 0.001

			if var_218_1 <= arg_215_1.time_ and arg_215_1.time_ < var_218_1 + var_218_2 then
				local var_218_3 = (arg_215_1.time_ - var_218_1) / var_218_2
				local var_218_4 = Vector3.New(-0.2, -1.08, -5.9)

				var_218_0.localPosition = Vector3.Lerp(arg_215_1.var_.moveOldPos1019ui_story, var_218_4, var_218_3)

				local var_218_5 = manager.ui.mainCamera.transform.position - var_218_0.position

				var_218_0.forward = Vector3.New(var_218_5.x, var_218_5.y, var_218_5.z)

				local var_218_6 = var_218_0.localEulerAngles

				var_218_6.z = 0
				var_218_6.x = 0
				var_218_0.localEulerAngles = var_218_6
			end

			if arg_215_1.time_ >= var_218_1 + var_218_2 and arg_215_1.time_ < var_218_1 + var_218_2 + arg_218_0 then
				var_218_0.localPosition = Vector3.New(-0.2, -1.08, -5.9)

				local var_218_7 = manager.ui.mainCamera.transform.position - var_218_0.position

				var_218_0.forward = Vector3.New(var_218_7.x, var_218_7.y, var_218_7.z)

				local var_218_8 = var_218_0.localEulerAngles

				var_218_8.z = 0
				var_218_8.x = 0
				var_218_0.localEulerAngles = var_218_8
			end

			local var_218_9 = arg_215_1.actors_["1019ui_story"]
			local var_218_10 = 0

			if var_218_10 < arg_215_1.time_ and arg_215_1.time_ <= var_218_10 + arg_218_0 and not isNil(var_218_9) and arg_215_1.var_.characterEffect1019ui_story == nil then
				arg_215_1.var_.characterEffect1019ui_story = var_218_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_218_11 = 0.200000002980232

			if var_218_10 <= arg_215_1.time_ and arg_215_1.time_ < var_218_10 + var_218_11 and not isNil(var_218_9) then
				local var_218_12 = (arg_215_1.time_ - var_218_10) / var_218_11

				if arg_215_1.var_.characterEffect1019ui_story and not isNil(var_218_9) then
					arg_215_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_215_1.time_ >= var_218_10 + var_218_11 and arg_215_1.time_ < var_218_10 + var_218_11 + arg_218_0 and not isNil(var_218_9) and arg_215_1.var_.characterEffect1019ui_story then
				arg_215_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_218_13 = 0

			if var_218_13 < arg_215_1.time_ and arg_215_1.time_ <= var_218_13 + arg_218_0 then
				arg_215_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action1_1")
			end

			local var_218_14 = 0

			if var_218_14 < arg_215_1.time_ and arg_215_1.time_ <= var_218_14 + arg_218_0 then
				arg_215_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_218_15 = 0
			local var_218_16 = 0.175

			if var_218_15 < arg_215_1.time_ and arg_215_1.time_ <= var_218_15 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				local var_218_17 = arg_215_1:FormatText(StoryNameCfg[13].name)

				arg_215_1.leftNameTxt_.text = var_218_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_18 = arg_215_1:GetWordFromCfg(318161053)
				local var_218_19 = arg_215_1:FormatText(var_218_18.content)

				arg_215_1.text_.text = var_218_19

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_20 = 7
				local var_218_21 = utf8.len(var_218_19)
				local var_218_22 = var_218_20 <= 0 and var_218_16 or var_218_16 * (var_218_21 / var_218_20)

				if var_218_22 > 0 and var_218_16 < var_218_22 then
					arg_215_1.talkMaxDuration = var_218_22

					if var_218_22 + var_218_15 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_22 + var_218_15
					end
				end

				arg_215_1.text_.text = var_218_19
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318161", "318161053", "story_v_out_318161.awb") ~= 0 then
					local var_218_23 = manager.audio:GetVoiceLength("story_v_out_318161", "318161053", "story_v_out_318161.awb") / 1000

					if var_218_23 + var_218_15 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_23 + var_218_15
					end

					if var_218_18.prefab_name ~= "" and arg_215_1.actors_[var_218_18.prefab_name] ~= nil then
						local var_218_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_215_1.actors_[var_218_18.prefab_name].transform, "story_v_out_318161", "318161053", "story_v_out_318161.awb")

						arg_215_1:RecordAudio("318161053", var_218_24)
						arg_215_1:RecordAudio("318161053", var_218_24)
					else
						arg_215_1:AudioAction("play", "voice", "story_v_out_318161", "318161053", "story_v_out_318161.awb")
					end

					arg_215_1:RecordHistoryTalkVoice("story_v_out_318161", "318161053", "story_v_out_318161.awb")
				end

				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_25 = math.max(var_218_16, arg_215_1.talkMaxDuration)

			if var_218_15 <= arg_215_1.time_ and arg_215_1.time_ < var_218_15 + var_218_25 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_15) / var_218_25

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_15 + var_218_25 and arg_215_1.time_ < var_218_15 + var_218_25 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {
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

		arg_215_1:InitPlayNodeList()
	end,
	Play318161054 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 318161054
		arg_219_1.duration_ = 5

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play318161055(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			local var_222_0 = arg_219_1.actors_["1019ui_story"]
			local var_222_1 = 0

			if var_222_1 < arg_219_1.time_ and arg_219_1.time_ <= var_222_1 + arg_222_0 and not isNil(var_222_0) and arg_219_1.var_.characterEffect1019ui_story == nil then
				arg_219_1.var_.characterEffect1019ui_story = var_222_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_222_2 = 0.200000002980232

			if var_222_1 <= arg_219_1.time_ and arg_219_1.time_ < var_222_1 + var_222_2 and not isNil(var_222_0) then
				local var_222_3 = (arg_219_1.time_ - var_222_1) / var_222_2

				if arg_219_1.var_.characterEffect1019ui_story and not isNil(var_222_0) then
					local var_222_4 = Mathf.Lerp(0, 0.5, var_222_3)

					arg_219_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_219_1.var_.characterEffect1019ui_story.fillRatio = var_222_4
				end
			end

			if arg_219_1.time_ >= var_222_1 + var_222_2 and arg_219_1.time_ < var_222_1 + var_222_2 + arg_222_0 and not isNil(var_222_0) and arg_219_1.var_.characterEffect1019ui_story then
				local var_222_5 = 0.5

				arg_219_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_219_1.var_.characterEffect1019ui_story.fillRatio = var_222_5
			end

			local var_222_6 = "1033ui_story"

			if arg_219_1.actors_[var_222_6] == nil then
				local var_222_7 = Asset.Load("Char/" .. "1033ui_story")

				if not isNil(var_222_7) then
					local var_222_8 = Object.Instantiate(Asset.Load("Char/" .. "1033ui_story"), arg_219_1.stage_.transform)

					var_222_8.name = var_222_6
					var_222_8.transform.localPosition = Vector3.New(0, 100, 0)
					arg_219_1.actors_[var_222_6] = var_222_8

					local var_222_9 = var_222_8:GetComponentInChildren(typeof(CharacterEffect))

					var_222_9.enabled = true

					local var_222_10 = GameObjectTools.GetOrAddComponent(var_222_8, typeof(DynamicBoneHelper))

					if var_222_10 then
						var_222_10:EnableDynamicBone(false)
					end

					arg_219_1:ShowWeapon(var_222_9.transform, false)

					arg_219_1.var_[var_222_6 .. "Animator"] = var_222_9.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_219_1.var_[var_222_6 .. "Animator"].applyRootMotion = true
					arg_219_1.var_[var_222_6 .. "LipSync"] = var_222_9.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_222_11 = arg_219_1.actors_["1033ui_story"].transform
			local var_222_12 = 0

			if var_222_12 < arg_219_1.time_ and arg_219_1.time_ <= var_222_12 + arg_222_0 then
				arg_219_1.var_.moveOldPos1033ui_story = var_222_11.localPosition
			end

			local var_222_13 = 0.001

			if var_222_12 <= arg_219_1.time_ and arg_219_1.time_ < var_222_12 + var_222_13 then
				local var_222_14 = (arg_219_1.time_ - var_222_12) / var_222_13
				local var_222_15 = Vector3.New(0.7, -1.01, -6.13)

				var_222_11.localPosition = Vector3.Lerp(arg_219_1.var_.moveOldPos1033ui_story, var_222_15, var_222_14)

				local var_222_16 = manager.ui.mainCamera.transform.position - var_222_11.position

				var_222_11.forward = Vector3.New(var_222_16.x, var_222_16.y, var_222_16.z)

				local var_222_17 = var_222_11.localEulerAngles

				var_222_17.z = 0
				var_222_17.x = 0
				var_222_11.localEulerAngles = var_222_17
			end

			if arg_219_1.time_ >= var_222_12 + var_222_13 and arg_219_1.time_ < var_222_12 + var_222_13 + arg_222_0 then
				var_222_11.localPosition = Vector3.New(0.7, -1.01, -6.13)

				local var_222_18 = manager.ui.mainCamera.transform.position - var_222_11.position

				var_222_11.forward = Vector3.New(var_222_18.x, var_222_18.y, var_222_18.z)

				local var_222_19 = var_222_11.localEulerAngles

				var_222_19.z = 0
				var_222_19.x = 0
				var_222_11.localEulerAngles = var_222_19
			end

			local var_222_20 = arg_219_1.actors_["1019ui_story"].transform
			local var_222_21 = 0

			if var_222_21 < arg_219_1.time_ and arg_219_1.time_ <= var_222_21 + arg_222_0 then
				arg_219_1.var_.moveOldPos1019ui_story = var_222_20.localPosition
			end

			local var_222_22 = 0.001

			if var_222_21 <= arg_219_1.time_ and arg_219_1.time_ < var_222_21 + var_222_22 then
				local var_222_23 = (arg_219_1.time_ - var_222_21) / var_222_22
				local var_222_24 = Vector3.New(-0.7, -1.08, -5.9)

				var_222_20.localPosition = Vector3.Lerp(arg_219_1.var_.moveOldPos1019ui_story, var_222_24, var_222_23)

				local var_222_25 = manager.ui.mainCamera.transform.position - var_222_20.position

				var_222_20.forward = Vector3.New(var_222_25.x, var_222_25.y, var_222_25.z)

				local var_222_26 = var_222_20.localEulerAngles

				var_222_26.z = 0
				var_222_26.x = 0
				var_222_20.localEulerAngles = var_222_26
			end

			if arg_219_1.time_ >= var_222_21 + var_222_22 and arg_219_1.time_ < var_222_21 + var_222_22 + arg_222_0 then
				var_222_20.localPosition = Vector3.New(-0.7, -1.08, -5.9)

				local var_222_27 = manager.ui.mainCamera.transform.position - var_222_20.position

				var_222_20.forward = Vector3.New(var_222_27.x, var_222_27.y, var_222_27.z)

				local var_222_28 = var_222_20.localEulerAngles

				var_222_28.z = 0
				var_222_28.x = 0
				var_222_20.localEulerAngles = var_222_28
			end

			local var_222_29 = 0

			if var_222_29 < arg_219_1.time_ and arg_219_1.time_ <= var_222_29 + arg_222_0 then
				arg_219_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033action/1033action1_1")
			end

			local var_222_30 = 0
			local var_222_31 = 0.525

			if var_222_30 < arg_219_1.time_ and arg_219_1.time_ <= var_222_30 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, false)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_32 = arg_219_1:GetWordFromCfg(318161054)
				local var_222_33 = arg_219_1:FormatText(var_222_32.content)

				arg_219_1.text_.text = var_222_33

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_34 = 21
				local var_222_35 = utf8.len(var_222_33)
				local var_222_36 = var_222_34 <= 0 and var_222_31 or var_222_31 * (var_222_35 / var_222_34)

				if var_222_36 > 0 and var_222_31 < var_222_36 then
					arg_219_1.talkMaxDuration = var_222_36

					if var_222_36 + var_222_30 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_36 + var_222_30
					end
				end

				arg_219_1.text_.text = var_222_33
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)
				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_37 = math.max(var_222_31, arg_219_1.talkMaxDuration)

			if var_222_30 <= arg_219_1.time_ and arg_219_1.time_ < var_222_30 + var_222_37 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_30) / var_222_37

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_30 + var_222_37 and arg_219_1.time_ < var_222_30 + var_222_37 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_219_1:InitPlayNodeList()
	end,
	Play318161055 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 318161055
		arg_223_1.duration_ = 5

		SetActive(arg_223_1.tipsGo_, false)

		function arg_223_1.onSingleLineFinish_()
			arg_223_1.onSingleLineUpdate_ = nil
			arg_223_1.onSingleLineFinish_ = nil
			arg_223_1.state_ = "waiting"
		end

		function arg_223_1.playNext_(arg_225_0)
			if arg_225_0 == 1 then
				arg_223_0:Play318161056(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			local var_226_0 = 0
			local var_226_1 = 0.925

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

				local var_226_2 = arg_223_1:GetWordFromCfg(318161055)
				local var_226_3 = arg_223_1:FormatText(var_226_2.content)

				arg_223_1.text_.text = var_226_3

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_4 = 37
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
	Play318161056 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 318161056
		arg_227_1.duration_ = 3.23

		local var_227_0 = {
			zh = 3.233,
			ja = 3.166
		}
		local var_227_1 = manager.audio:GetLocalizationFlag()

		if var_227_0[var_227_1] ~= nil then
			arg_227_1.duration_ = var_227_0[var_227_1]
		end

		SetActive(arg_227_1.tipsGo_, false)

		function arg_227_1.onSingleLineFinish_()
			arg_227_1.onSingleLineUpdate_ = nil
			arg_227_1.onSingleLineFinish_ = nil
			arg_227_1.state_ = "waiting"
		end

		function arg_227_1.playNext_(arg_229_0)
			if arg_229_0 == 1 then
				arg_227_0:Play318161057(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			local var_230_0 = arg_227_1.actors_["1033ui_story"]
			local var_230_1 = 0

			if var_230_1 < arg_227_1.time_ and arg_227_1.time_ <= var_230_1 + arg_230_0 and not isNil(var_230_0) and arg_227_1.var_.characterEffect1033ui_story == nil then
				arg_227_1.var_.characterEffect1033ui_story = var_230_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_230_2 = 0.200000002980232

			if var_230_1 <= arg_227_1.time_ and arg_227_1.time_ < var_230_1 + var_230_2 and not isNil(var_230_0) then
				local var_230_3 = (arg_227_1.time_ - var_230_1) / var_230_2

				if arg_227_1.var_.characterEffect1033ui_story and not isNil(var_230_0) then
					arg_227_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_227_1.time_ >= var_230_1 + var_230_2 and arg_227_1.time_ < var_230_1 + var_230_2 + arg_230_0 and not isNil(var_230_0) and arg_227_1.var_.characterEffect1033ui_story then
				arg_227_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			local var_230_4 = 0

			if var_230_4 < arg_227_1.time_ and arg_227_1.time_ <= var_230_4 + arg_230_0 then
				arg_227_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033action/1033action3_1")
			end

			local var_230_5 = 0

			if var_230_5 < arg_227_1.time_ and arg_227_1.time_ <= var_230_5 + arg_230_0 then
				arg_227_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_230_6 = 0
			local var_230_7 = 0.425

			if var_230_6 < arg_227_1.time_ and arg_227_1.time_ <= var_230_6 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				local var_230_8 = arg_227_1:FormatText(StoryNameCfg[236].name)

				arg_227_1.leftNameTxt_.text = var_230_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_9 = arg_227_1:GetWordFromCfg(318161056)
				local var_230_10 = arg_227_1:FormatText(var_230_9.content)

				arg_227_1.text_.text = var_230_10

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_11 = 17
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

				if manager.audio:GetVoiceLength("story_v_out_318161", "318161056", "story_v_out_318161.awb") ~= 0 then
					local var_230_14 = manager.audio:GetVoiceLength("story_v_out_318161", "318161056", "story_v_out_318161.awb") / 1000

					if var_230_14 + var_230_6 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_14 + var_230_6
					end

					if var_230_9.prefab_name ~= "" and arg_227_1.actors_[var_230_9.prefab_name] ~= nil then
						local var_230_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_227_1.actors_[var_230_9.prefab_name].transform, "story_v_out_318161", "318161056", "story_v_out_318161.awb")

						arg_227_1:RecordAudio("318161056", var_230_15)
						arg_227_1:RecordAudio("318161056", var_230_15)
					else
						arg_227_1:AudioAction("play", "voice", "story_v_out_318161", "318161056", "story_v_out_318161.awb")
					end

					arg_227_1:RecordHistoryTalkVoice("story_v_out_318161", "318161056", "story_v_out_318161.awb")
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
	Play318161057 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 318161057
		arg_231_1.duration_ = 2.37

		local var_231_0 = {
			zh = 2.1,
			ja = 2.366
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
				arg_231_0:Play318161058(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			local var_234_0 = 0
			local var_234_1 = 0.275

			if var_234_0 < arg_231_1.time_ and arg_231_1.time_ <= var_234_0 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				local var_234_2 = arg_231_1:FormatText(StoryNameCfg[236].name)

				arg_231_1.leftNameTxt_.text = var_234_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_3 = arg_231_1:GetWordFromCfg(318161057)
				local var_234_4 = arg_231_1:FormatText(var_234_3.content)

				arg_231_1.text_.text = var_234_4

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_5 = 11
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

				if manager.audio:GetVoiceLength("story_v_out_318161", "318161057", "story_v_out_318161.awb") ~= 0 then
					local var_234_8 = manager.audio:GetVoiceLength("story_v_out_318161", "318161057", "story_v_out_318161.awb") / 1000

					if var_234_8 + var_234_0 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_8 + var_234_0
					end

					if var_234_3.prefab_name ~= "" and arg_231_1.actors_[var_234_3.prefab_name] ~= nil then
						local var_234_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_231_1.actors_[var_234_3.prefab_name].transform, "story_v_out_318161", "318161057", "story_v_out_318161.awb")

						arg_231_1:RecordAudio("318161057", var_234_9)
						arg_231_1:RecordAudio("318161057", var_234_9)
					else
						arg_231_1:AudioAction("play", "voice", "story_v_out_318161", "318161057", "story_v_out_318161.awb")
					end

					arg_231_1:RecordHistoryTalkVoice("story_v_out_318161", "318161057", "story_v_out_318161.awb")
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
	Play318161058 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 318161058
		arg_235_1.duration_ = 9

		SetActive(arg_235_1.tipsGo_, false)

		function arg_235_1.onSingleLineFinish_()
			arg_235_1.onSingleLineUpdate_ = nil
			arg_235_1.onSingleLineFinish_ = nil
			arg_235_1.state_ = "waiting"
		end

		function arg_235_1.playNext_(arg_237_0)
			if arg_237_0 == 1 then
				arg_235_0:Play318161059(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			local var_238_0 = "K16f"

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
				local var_238_5 = arg_235_1.bgs_.K16f

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
					if iter_238_0 ~= "K16f" then
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

			local var_238_27 = arg_235_1.actors_["1033ui_story"].transform
			local var_238_28 = 1.96599999815226

			if var_238_28 < arg_235_1.time_ and arg_235_1.time_ <= var_238_28 + arg_238_0 then
				arg_235_1.var_.moveOldPos1033ui_story = var_238_27.localPosition
			end

			local var_238_29 = 0.001

			if var_238_28 <= arg_235_1.time_ and arg_235_1.time_ < var_238_28 + var_238_29 then
				local var_238_30 = (arg_235_1.time_ - var_238_28) / var_238_29
				local var_238_31 = Vector3.New(0, 100, 0)

				var_238_27.localPosition = Vector3.Lerp(arg_235_1.var_.moveOldPos1033ui_story, var_238_31, var_238_30)

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

			local var_238_36 = arg_235_1.actors_["1033ui_story"]
			local var_238_37 = 1.96599999815226

			if var_238_37 < arg_235_1.time_ and arg_235_1.time_ <= var_238_37 + arg_238_0 and not isNil(var_238_36) and arg_235_1.var_.characterEffect1033ui_story == nil then
				arg_235_1.var_.characterEffect1033ui_story = var_238_36:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_238_38 = 0.034000001847744

			if var_238_37 <= arg_235_1.time_ and arg_235_1.time_ < var_238_37 + var_238_38 and not isNil(var_238_36) then
				local var_238_39 = (arg_235_1.time_ - var_238_37) / var_238_38

				if arg_235_1.var_.characterEffect1033ui_story and not isNil(var_238_36) then
					local var_238_40 = Mathf.Lerp(0, 0.5, var_238_39)

					arg_235_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_235_1.var_.characterEffect1033ui_story.fillRatio = var_238_40
				end
			end

			if arg_235_1.time_ >= var_238_37 + var_238_38 and arg_235_1.time_ < var_238_37 + var_238_38 + arg_238_0 and not isNil(var_238_36) and arg_235_1.var_.characterEffect1033ui_story then
				local var_238_41 = 0.5

				arg_235_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_235_1.var_.characterEffect1033ui_story.fillRatio = var_238_41
			end

			local var_238_42 = 0
			local var_238_43 = 0.533333333333333

			if var_238_42 < arg_235_1.time_ and arg_235_1.time_ <= var_238_42 + arg_238_0 then
				local var_238_44 = "play"
				local var_238_45 = "music"

				arg_235_1:AudioAction(var_238_44, var_238_45, "ui_battle", "ui_battle_stopbgm", "")

				local var_238_46 = ""
				local var_238_47 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_238_47 ~= "" then
					if arg_235_1.bgmTxt_.text ~= var_238_47 and arg_235_1.bgmTxt_.text ~= "" then
						if arg_235_1.bgmTxt2_.text ~= "" then
							arg_235_1.bgmTxt_.text = arg_235_1.bgmTxt2_.text
						end

						arg_235_1.bgmTxt2_.text = var_238_47

						arg_235_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_235_1.bgmTxt_.text = var_238_47
						arg_235_1.bgmTxt2_.text = var_238_47
					end

					if arg_235_1.bgmTimer then
						arg_235_1.bgmTimer:Stop()

						arg_235_1.bgmTimer = nil
					end

					if arg_235_1.settingData.show_music_name == 1 then
						arg_235_1.musicController:SetSelectedState("show")
						arg_235_1.musicAnimator_:Play("open", 0, 0)

						if arg_235_1.settingData.music_time ~= 0 then
							arg_235_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_235_1.settingData.music_time), function()
								if arg_235_1 == nil or isNil(arg_235_1.bgmTxt_) then
									return
								end

								arg_235_1.musicController:SetSelectedState("hide")
								arg_235_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_238_48 = 0.8
			local var_238_49 = 1

			if var_238_48 < arg_235_1.time_ and arg_235_1.time_ <= var_238_48 + arg_238_0 then
				local var_238_50 = "play"
				local var_238_51 = "music"

				arg_235_1:AudioAction(var_238_50, var_238_51, "bgm_activity_2_10_story_sasanami_photonrail", "bgm_activity_2_10_story_sasanami_photonrail", "bgm_activity_2_10_story_sasanami_photonrail.awb")

				local var_238_52 = ""
				local var_238_53 = manager.audio:GetAudioName("bgm_activity_2_10_story_sasanami_photonrail", "bgm_activity_2_10_story_sasanami_photonrail")

				if var_238_53 ~= "" then
					if arg_235_1.bgmTxt_.text ~= var_238_53 and arg_235_1.bgmTxt_.text ~= "" then
						if arg_235_1.bgmTxt2_.text ~= "" then
							arg_235_1.bgmTxt_.text = arg_235_1.bgmTxt2_.text
						end

						arg_235_1.bgmTxt2_.text = var_238_53

						arg_235_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_235_1.bgmTxt_.text = var_238_53
						arg_235_1.bgmTxt2_.text = var_238_53
					end

					if arg_235_1.bgmTimer then
						arg_235_1.bgmTimer:Stop()

						arg_235_1.bgmTimer = nil
					end

					if arg_235_1.settingData.show_music_name == 1 then
						arg_235_1.musicController:SetSelectedState("show")
						arg_235_1.musicAnimator_:Play("open", 0, 0)

						if arg_235_1.settingData.music_time ~= 0 then
							arg_235_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_235_1.settingData.music_time), function()
								if arg_235_1 == nil or isNil(arg_235_1.bgmTxt_) then
									return
								end

								arg_235_1.musicController:SetSelectedState("hide")
								arg_235_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_238_54 = arg_235_1.actors_["1019ui_story"].transform
			local var_238_55 = 1.96599999815226

			if var_238_55 < arg_235_1.time_ and arg_235_1.time_ <= var_238_55 + arg_238_0 then
				arg_235_1.var_.moveOldPos1019ui_story = var_238_54.localPosition
			end

			local var_238_56 = 0.001

			if var_238_55 <= arg_235_1.time_ and arg_235_1.time_ < var_238_55 + var_238_56 then
				local var_238_57 = (arg_235_1.time_ - var_238_55) / var_238_56
				local var_238_58 = Vector3.New(0, 100, 0)

				var_238_54.localPosition = Vector3.Lerp(arg_235_1.var_.moveOldPos1019ui_story, var_238_58, var_238_57)

				local var_238_59 = manager.ui.mainCamera.transform.position - var_238_54.position

				var_238_54.forward = Vector3.New(var_238_59.x, var_238_59.y, var_238_59.z)

				local var_238_60 = var_238_54.localEulerAngles

				var_238_60.z = 0
				var_238_60.x = 0
				var_238_54.localEulerAngles = var_238_60
			end

			if arg_235_1.time_ >= var_238_55 + var_238_56 and arg_235_1.time_ < var_238_55 + var_238_56 + arg_238_0 then
				var_238_54.localPosition = Vector3.New(0, 100, 0)

				local var_238_61 = manager.ui.mainCamera.transform.position - var_238_54.position

				var_238_54.forward = Vector3.New(var_238_61.x, var_238_61.y, var_238_61.z)

				local var_238_62 = var_238_54.localEulerAngles

				var_238_62.z = 0
				var_238_62.x = 0
				var_238_54.localEulerAngles = var_238_62
			end

			if arg_235_1.frameCnt_ <= 1 then
				arg_235_1.dialog_:SetActive(false)
			end

			local var_238_63 = 4
			local var_238_64 = 0.625

			if var_238_63 < arg_235_1.time_ and arg_235_1.time_ <= var_238_63 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0

				arg_235_1.dialog_:SetActive(true)

				arg_235_1.dialogCg_.alpha = 0

				local var_238_65 = LeanTween.value(arg_235_1.dialog_, 0, 1, 0.3)

				var_238_65:setOnUpdate(LuaHelper.FloatAction(function(arg_241_0)
					arg_235_1.dialogCg_.alpha = arg_241_0
				end))
				var_238_65:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_235_1.dialog_)
					var_238_65:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_235_1.duration_ = arg_235_1.duration_ + 0.3

				SetActive(arg_235_1.leftNameGo_, false)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_66 = arg_235_1:GetWordFromCfg(318161058)
				local var_238_67 = arg_235_1:FormatText(var_238_66.content)

				arg_235_1.text_.text = var_238_67

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_68 = 25
				local var_238_69 = utf8.len(var_238_67)
				local var_238_70 = var_238_68 <= 0 and var_238_64 or var_238_64 * (var_238_69 / var_238_68)

				if var_238_70 > 0 and var_238_64 < var_238_70 then
					arg_235_1.talkMaxDuration = var_238_70
					var_238_63 = var_238_63 + 0.3

					if var_238_70 + var_238_63 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_70 + var_238_63
					end
				end

				arg_235_1.text_.text = var_238_67
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)
				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_71 = var_238_63 + 0.3
			local var_238_72 = math.max(var_238_64, arg_235_1.talkMaxDuration)

			if var_238_71 <= arg_235_1.time_ and arg_235_1.time_ < var_238_71 + var_238_72 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_71) / var_238_72

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_71 + var_238_72 and arg_235_1.time_ < var_238_71 + var_238_72 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_235_1:InitPlayNodeList()
	end,
	Play318161059 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 318161059
		arg_243_1.duration_ = 5

		SetActive(arg_243_1.tipsGo_, false)

		function arg_243_1.onSingleLineFinish_()
			arg_243_1.onSingleLineUpdate_ = nil
			arg_243_1.onSingleLineFinish_ = nil
			arg_243_1.state_ = "waiting"
		end

		function arg_243_1.playNext_(arg_245_0)
			if arg_245_0 == 1 then
				arg_243_0:Play318161060(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			local var_246_0 = 0
			local var_246_1 = 1.375

			if var_246_0 < arg_243_1.time_ and arg_243_1.time_ <= var_246_0 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, false)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_2 = arg_243_1:GetWordFromCfg(318161059)
				local var_246_3 = arg_243_1:FormatText(var_246_2.content)

				arg_243_1.text_.text = var_246_3

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_4 = 55
				local var_246_5 = utf8.len(var_246_3)
				local var_246_6 = var_246_4 <= 0 and var_246_1 or var_246_1 * (var_246_5 / var_246_4)

				if var_246_6 > 0 and var_246_1 < var_246_6 then
					arg_243_1.talkMaxDuration = var_246_6

					if var_246_6 + var_246_0 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_6 + var_246_0
					end
				end

				arg_243_1.text_.text = var_246_3
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)
				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_7 = math.max(var_246_1, arg_243_1.talkMaxDuration)

			if var_246_0 <= arg_243_1.time_ and arg_243_1.time_ < var_246_0 + var_246_7 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_0) / var_246_7

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_0 + var_246_7 and arg_243_1.time_ < var_246_0 + var_246_7 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {}

		arg_243_1:InitPlayNodeList()
	end,
	Play318161060 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 318161060
		arg_247_1.duration_ = 5

		SetActive(arg_247_1.tipsGo_, false)

		function arg_247_1.onSingleLineFinish_()
			arg_247_1.onSingleLineUpdate_ = nil
			arg_247_1.onSingleLineFinish_ = nil
			arg_247_1.state_ = "waiting"
		end

		function arg_247_1.playNext_(arg_249_0)
			if arg_249_0 == 1 then
				arg_247_0:Play318161061(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			local var_250_0 = 0
			local var_250_1 = 1.15

			if var_250_0 < arg_247_1.time_ and arg_247_1.time_ <= var_250_0 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, false)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_2 = arg_247_1:GetWordFromCfg(318161060)
				local var_250_3 = arg_247_1:FormatText(var_250_2.content)

				arg_247_1.text_.text = var_250_3

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_4 = 46
				local var_250_5 = utf8.len(var_250_3)
				local var_250_6 = var_250_4 <= 0 and var_250_1 or var_250_1 * (var_250_5 / var_250_4)

				if var_250_6 > 0 and var_250_1 < var_250_6 then
					arg_247_1.talkMaxDuration = var_250_6

					if var_250_6 + var_250_0 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_6 + var_250_0
					end
				end

				arg_247_1.text_.text = var_250_3
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)
				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_7 = math.max(var_250_1, arg_247_1.talkMaxDuration)

			if var_250_0 <= arg_247_1.time_ and arg_247_1.time_ < var_250_0 + var_250_7 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_0) / var_250_7

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_0 + var_250_7 and arg_247_1.time_ < var_250_0 + var_250_7 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {}

		arg_247_1:InitPlayNodeList()
	end,
	Play318161061 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 318161061
		arg_251_1.duration_ = 7.2

		local var_251_0 = {
			zh = 3.433,
			ja = 7.2
		}
		local var_251_1 = manager.audio:GetLocalizationFlag()

		if var_251_0[var_251_1] ~= nil then
			arg_251_1.duration_ = var_251_0[var_251_1]
		end

		SetActive(arg_251_1.tipsGo_, false)

		function arg_251_1.onSingleLineFinish_()
			arg_251_1.onSingleLineUpdate_ = nil
			arg_251_1.onSingleLineFinish_ = nil
			arg_251_1.state_ = "waiting"
		end

		function arg_251_1.playNext_(arg_253_0)
			if arg_253_0 == 1 then
				arg_251_0:Play318161062(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			local var_254_0 = "1049ui_story"

			if arg_251_1.actors_[var_254_0] == nil then
				local var_254_1 = Asset.Load("Char/" .. "1049ui_story")

				if not isNil(var_254_1) then
					local var_254_2 = Object.Instantiate(Asset.Load("Char/" .. "1049ui_story"), arg_251_1.stage_.transform)

					var_254_2.name = var_254_0
					var_254_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_251_1.actors_[var_254_0] = var_254_2

					local var_254_3 = var_254_2:GetComponentInChildren(typeof(CharacterEffect))

					var_254_3.enabled = true

					local var_254_4 = GameObjectTools.GetOrAddComponent(var_254_2, typeof(DynamicBoneHelper))

					if var_254_4 then
						var_254_4:EnableDynamicBone(false)
					end

					arg_251_1:ShowWeapon(var_254_3.transform, false)

					arg_251_1.var_[var_254_0 .. "Animator"] = var_254_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_251_1.var_[var_254_0 .. "Animator"].applyRootMotion = true
					arg_251_1.var_[var_254_0 .. "LipSync"] = var_254_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_254_5 = arg_251_1.actors_["1049ui_story"].transform
			local var_254_6 = 0

			if var_254_6 < arg_251_1.time_ and arg_251_1.time_ <= var_254_6 + arg_254_0 then
				arg_251_1.var_.moveOldPos1049ui_story = var_254_5.localPosition
			end

			local var_254_7 = 0.001

			if var_254_6 <= arg_251_1.time_ and arg_251_1.time_ < var_254_6 + var_254_7 then
				local var_254_8 = (arg_251_1.time_ - var_254_6) / var_254_7
				local var_254_9 = Vector3.New(0, -1.2, -6)

				var_254_5.localPosition = Vector3.Lerp(arg_251_1.var_.moveOldPos1049ui_story, var_254_9, var_254_8)

				local var_254_10 = manager.ui.mainCamera.transform.position - var_254_5.position

				var_254_5.forward = Vector3.New(var_254_10.x, var_254_10.y, var_254_10.z)

				local var_254_11 = var_254_5.localEulerAngles

				var_254_11.z = 0
				var_254_11.x = 0
				var_254_5.localEulerAngles = var_254_11
			end

			if arg_251_1.time_ >= var_254_6 + var_254_7 and arg_251_1.time_ < var_254_6 + var_254_7 + arg_254_0 then
				var_254_5.localPosition = Vector3.New(0, -1.2, -6)

				local var_254_12 = manager.ui.mainCamera.transform.position - var_254_5.position

				var_254_5.forward = Vector3.New(var_254_12.x, var_254_12.y, var_254_12.z)

				local var_254_13 = var_254_5.localEulerAngles

				var_254_13.z = 0
				var_254_13.x = 0
				var_254_5.localEulerAngles = var_254_13
			end

			local var_254_14 = arg_251_1.actors_["1049ui_story"]
			local var_254_15 = 0

			if var_254_15 < arg_251_1.time_ and arg_251_1.time_ <= var_254_15 + arg_254_0 and not isNil(var_254_14) and arg_251_1.var_.characterEffect1049ui_story == nil then
				arg_251_1.var_.characterEffect1049ui_story = var_254_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_254_16 = 0.200000002980232

			if var_254_15 <= arg_251_1.time_ and arg_251_1.time_ < var_254_15 + var_254_16 and not isNil(var_254_14) then
				local var_254_17 = (arg_251_1.time_ - var_254_15) / var_254_16

				if arg_251_1.var_.characterEffect1049ui_story and not isNil(var_254_14) then
					arg_251_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_251_1.time_ >= var_254_15 + var_254_16 and arg_251_1.time_ < var_254_15 + var_254_16 + arg_254_0 and not isNil(var_254_14) and arg_251_1.var_.characterEffect1049ui_story then
				arg_251_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_254_18 = 0

			if var_254_18 < arg_251_1.time_ and arg_251_1.time_ <= var_254_18 + arg_254_0 then
				arg_251_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action1_1")
			end

			local var_254_19 = 0

			if var_254_19 < arg_251_1.time_ and arg_251_1.time_ <= var_254_19 + arg_254_0 then
				arg_251_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_254_20 = 0
			local var_254_21 = 0.425

			if var_254_20 < arg_251_1.time_ and arg_251_1.time_ <= var_254_20 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				local var_254_22 = arg_251_1:FormatText(StoryNameCfg[562].name)

				arg_251_1.leftNameTxt_.text = var_254_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, false)
				arg_251_1.callingController_:SetSelectedState("normal")

				local var_254_23 = arg_251_1:GetWordFromCfg(318161061)
				local var_254_24 = arg_251_1:FormatText(var_254_23.content)

				arg_251_1.text_.text = var_254_24

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_25 = 17
				local var_254_26 = utf8.len(var_254_24)
				local var_254_27 = var_254_25 <= 0 and var_254_21 or var_254_21 * (var_254_26 / var_254_25)

				if var_254_27 > 0 and var_254_21 < var_254_27 then
					arg_251_1.talkMaxDuration = var_254_27

					if var_254_27 + var_254_20 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_27 + var_254_20
					end
				end

				arg_251_1.text_.text = var_254_24
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318161", "318161061", "story_v_out_318161.awb") ~= 0 then
					local var_254_28 = manager.audio:GetVoiceLength("story_v_out_318161", "318161061", "story_v_out_318161.awb") / 1000

					if var_254_28 + var_254_20 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_28 + var_254_20
					end

					if var_254_23.prefab_name ~= "" and arg_251_1.actors_[var_254_23.prefab_name] ~= nil then
						local var_254_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_251_1.actors_[var_254_23.prefab_name].transform, "story_v_out_318161", "318161061", "story_v_out_318161.awb")

						arg_251_1:RecordAudio("318161061", var_254_29)
						arg_251_1:RecordAudio("318161061", var_254_29)
					else
						arg_251_1:AudioAction("play", "voice", "story_v_out_318161", "318161061", "story_v_out_318161.awb")
					end

					arg_251_1:RecordHistoryTalkVoice("story_v_out_318161", "318161061", "story_v_out_318161.awb")
				end

				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_30 = math.max(var_254_21, arg_251_1.talkMaxDuration)

			if var_254_20 <= arg_251_1.time_ and arg_251_1.time_ < var_254_20 + var_254_30 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_20) / var_254_30

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_20 + var_254_30 and arg_251_1.time_ < var_254_20 + var_254_30 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
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
	Play318161062 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 318161062
		arg_255_1.duration_ = 1

		SetActive(arg_255_1.tipsGo_, false)

		function arg_255_1.onSingleLineFinish_()
			arg_255_1.onSingleLineUpdate_ = nil
			arg_255_1.onSingleLineFinish_ = nil
			arg_255_1.state_ = "waiting"

			SetActive(arg_255_1.choicesGo_, true)

			for iter_256_0, iter_256_1 in ipairs(arg_255_1.choices_) do
				local var_256_0 = iter_256_0 <= 2

				SetActive(iter_256_1.go, var_256_0)
			end

			arg_255_1.choices_[1].txt.text = arg_255_1:FormatText(StoryChoiceCfg[674].name)
			arg_255_1.choices_[2].txt.text = arg_255_1:FormatText(StoryChoiceCfg[675].name)
		end

		function arg_255_1.playNext_(arg_257_0)
			if arg_257_0 == 1 then
				arg_255_0:Play318161063(arg_255_1)
			end

			if arg_257_0 == 2 then
				arg_255_0:Play318161064(arg_255_1)
			end

			arg_255_1:RecordChoiceLog(318161062, 674, 675)
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			local var_258_0 = arg_255_1.actors_["1049ui_story"]
			local var_258_1 = 0

			if var_258_1 < arg_255_1.time_ and arg_255_1.time_ <= var_258_1 + arg_258_0 and not isNil(var_258_0) and arg_255_1.var_.characterEffect1049ui_story == nil then
				arg_255_1.var_.characterEffect1049ui_story = var_258_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_258_2 = 0.200000002980232

			if var_258_1 <= arg_255_1.time_ and arg_255_1.time_ < var_258_1 + var_258_2 and not isNil(var_258_0) then
				local var_258_3 = (arg_255_1.time_ - var_258_1) / var_258_2

				if arg_255_1.var_.characterEffect1049ui_story and not isNil(var_258_0) then
					local var_258_4 = Mathf.Lerp(0, 0.5, var_258_3)

					arg_255_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_255_1.var_.characterEffect1049ui_story.fillRatio = var_258_4
				end
			end

			if arg_255_1.time_ >= var_258_1 + var_258_2 and arg_255_1.time_ < var_258_1 + var_258_2 + arg_258_0 and not isNil(var_258_0) and arg_255_1.var_.characterEffect1049ui_story then
				local var_258_5 = 0.5

				arg_255_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_255_1.var_.characterEffect1049ui_story.fillRatio = var_258_5
			end

			local var_258_6 = 0

			if var_258_6 < arg_255_1.time_ and arg_255_1.time_ <= var_258_6 + arg_258_0 then
				arg_255_1.allBtn_.enabled = false
			end

			local var_258_7 = 0.5

			if arg_255_1.time_ >= var_258_6 + var_258_7 and arg_255_1.time_ < var_258_6 + var_258_7 + arg_258_0 then
				arg_255_1.allBtn_.enabled = true
			end
		end

		arg_255_1.nodeConfigList_ = {}

		arg_255_1:InitPlayNodeList()
	end,
	Play318161063 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 318161063
		arg_259_1.duration_ = 5

		SetActive(arg_259_1.tipsGo_, false)

		function arg_259_1.onSingleLineFinish_()
			arg_259_1.onSingleLineUpdate_ = nil
			arg_259_1.onSingleLineFinish_ = nil
			arg_259_1.state_ = "waiting"
		end

		function arg_259_1.playNext_(arg_261_0)
			if arg_261_0 == 1 then
				arg_259_0:Play318161065(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			local var_262_0 = 0
			local var_262_1 = 0.375

			if var_262_0 < arg_259_1.time_ and arg_259_1.time_ <= var_262_0 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, true)

				local var_262_2 = arg_259_1:FormatText(StoryNameCfg[7].name)

				arg_259_1.leftNameTxt_.text = var_262_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_259_1.leftNameTxt_.transform)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1.leftNameTxt_.text)
				SetActive(arg_259_1.iconTrs_.gameObject, true)
				arg_259_1.iconController_:SetSelectedState("hero")

				arg_259_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_259_1.callingController_:SetSelectedState("normal")

				arg_259_1.keyicon_.color = Color.New(1, 1, 1)
				arg_259_1.icon_.color = Color.New(1, 1, 1)

				local var_262_3 = arg_259_1:GetWordFromCfg(318161063)
				local var_262_4 = arg_259_1:FormatText(var_262_3.content)

				arg_259_1.text_.text = var_262_4

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_5 = 16
				local var_262_6 = utf8.len(var_262_4)
				local var_262_7 = var_262_5 <= 0 and var_262_1 or var_262_1 * (var_262_6 / var_262_5)

				if var_262_7 > 0 and var_262_1 < var_262_7 then
					arg_259_1.talkMaxDuration = var_262_7

					if var_262_7 + var_262_0 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_7 + var_262_0
					end
				end

				arg_259_1.text_.text = var_262_4
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)
				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_8 = math.max(var_262_1, arg_259_1.talkMaxDuration)

			if var_262_0 <= arg_259_1.time_ and arg_259_1.time_ < var_262_0 + var_262_8 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - var_262_0) / var_262_8

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= var_262_0 + var_262_8 and arg_259_1.time_ < var_262_0 + var_262_8 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {}

		arg_259_1:InitPlayNodeList()
	end,
	Play318161065 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 318161065
		arg_263_1.duration_ = 5.47

		local var_263_0 = {
			zh = 2.5,
			ja = 5.466
		}
		local var_263_1 = manager.audio:GetLocalizationFlag()

		if var_263_0[var_263_1] ~= nil then
			arg_263_1.duration_ = var_263_0[var_263_1]
		end

		SetActive(arg_263_1.tipsGo_, false)

		function arg_263_1.onSingleLineFinish_()
			arg_263_1.onSingleLineUpdate_ = nil
			arg_263_1.onSingleLineFinish_ = nil
			arg_263_1.state_ = "waiting"
		end

		function arg_263_1.playNext_(arg_265_0)
			if arg_265_0 == 1 then
				arg_263_0:Play318161066(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			local var_266_0 = arg_263_1.actors_["1049ui_story"]
			local var_266_1 = 0

			if var_266_1 < arg_263_1.time_ and arg_263_1.time_ <= var_266_1 + arg_266_0 and not isNil(var_266_0) and arg_263_1.var_.characterEffect1049ui_story == nil then
				arg_263_1.var_.characterEffect1049ui_story = var_266_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_266_2 = 0.200000002980232

			if var_266_1 <= arg_263_1.time_ and arg_263_1.time_ < var_266_1 + var_266_2 and not isNil(var_266_0) then
				local var_266_3 = (arg_263_1.time_ - var_266_1) / var_266_2

				if arg_263_1.var_.characterEffect1049ui_story and not isNil(var_266_0) then
					arg_263_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_263_1.time_ >= var_266_1 + var_266_2 and arg_263_1.time_ < var_266_1 + var_266_2 + arg_266_0 and not isNil(var_266_0) and arg_263_1.var_.characterEffect1049ui_story then
				arg_263_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_266_4 = 0
			local var_266_5 = 0.225

			if var_266_4 < arg_263_1.time_ and arg_263_1.time_ <= var_266_4 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, true)

				local var_266_6 = arg_263_1:FormatText(StoryNameCfg[562].name)

				arg_263_1.leftNameTxt_.text = var_266_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_263_1.leftNameTxt_.transform)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1.leftNameTxt_.text)
				SetActive(arg_263_1.iconTrs_.gameObject, false)
				arg_263_1.callingController_:SetSelectedState("normal")

				local var_266_7 = arg_263_1:GetWordFromCfg(318161065)
				local var_266_8 = arg_263_1:FormatText(var_266_7.content)

				arg_263_1.text_.text = var_266_8

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_9 = 9
				local var_266_10 = utf8.len(var_266_8)
				local var_266_11 = var_266_9 <= 0 and var_266_5 or var_266_5 * (var_266_10 / var_266_9)

				if var_266_11 > 0 and var_266_5 < var_266_11 then
					arg_263_1.talkMaxDuration = var_266_11

					if var_266_11 + var_266_4 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_11 + var_266_4
					end
				end

				arg_263_1.text_.text = var_266_8
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318161", "318161065", "story_v_out_318161.awb") ~= 0 then
					local var_266_12 = manager.audio:GetVoiceLength("story_v_out_318161", "318161065", "story_v_out_318161.awb") / 1000

					if var_266_12 + var_266_4 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_12 + var_266_4
					end

					if var_266_7.prefab_name ~= "" and arg_263_1.actors_[var_266_7.prefab_name] ~= nil then
						local var_266_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_263_1.actors_[var_266_7.prefab_name].transform, "story_v_out_318161", "318161065", "story_v_out_318161.awb")

						arg_263_1:RecordAudio("318161065", var_266_13)
						arg_263_1:RecordAudio("318161065", var_266_13)
					else
						arg_263_1:AudioAction("play", "voice", "story_v_out_318161", "318161065", "story_v_out_318161.awb")
					end

					arg_263_1:RecordHistoryTalkVoice("story_v_out_318161", "318161065", "story_v_out_318161.awb")
				end

				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_14 = math.max(var_266_5, arg_263_1.talkMaxDuration)

			if var_266_4 <= arg_263_1.time_ and arg_263_1.time_ < var_266_4 + var_266_14 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - var_266_4) / var_266_14

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= var_266_4 + var_266_14 and arg_263_1.time_ < var_266_4 + var_266_14 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {}

		arg_263_1:InitPlayNodeList()
	end,
	Play318161066 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 318161066
		arg_267_1.duration_ = 4.6

		local var_267_0 = {
			zh = 3,
			ja = 4.6
		}
		local var_267_1 = manager.audio:GetLocalizationFlag()

		if var_267_0[var_267_1] ~= nil then
			arg_267_1.duration_ = var_267_0[var_267_1]
		end

		SetActive(arg_267_1.tipsGo_, false)

		function arg_267_1.onSingleLineFinish_()
			arg_267_1.onSingleLineUpdate_ = nil
			arg_267_1.onSingleLineFinish_ = nil
			arg_267_1.state_ = "waiting"
		end

		function arg_267_1.playNext_(arg_269_0)
			if arg_269_0 == 1 then
				arg_267_0:Play318161067(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			local var_270_0 = "1015ui_story"

			if arg_267_1.actors_[var_270_0] == nil then
				local var_270_1 = Asset.Load("Char/" .. "1015ui_story")

				if not isNil(var_270_1) then
					local var_270_2 = Object.Instantiate(Asset.Load("Char/" .. "1015ui_story"), arg_267_1.stage_.transform)

					var_270_2.name = var_270_0
					var_270_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_267_1.actors_[var_270_0] = var_270_2

					local var_270_3 = var_270_2:GetComponentInChildren(typeof(CharacterEffect))

					var_270_3.enabled = true

					local var_270_4 = GameObjectTools.GetOrAddComponent(var_270_2, typeof(DynamicBoneHelper))

					if var_270_4 then
						var_270_4:EnableDynamicBone(false)
					end

					arg_267_1:ShowWeapon(var_270_3.transform, false)

					arg_267_1.var_[var_270_0 .. "Animator"] = var_270_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_267_1.var_[var_270_0 .. "Animator"].applyRootMotion = true
					arg_267_1.var_[var_270_0 .. "LipSync"] = var_270_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_270_5 = arg_267_1.actors_["1015ui_story"].transform
			local var_270_6 = 0

			if var_270_6 < arg_267_1.time_ and arg_267_1.time_ <= var_270_6 + arg_270_0 then
				arg_267_1.var_.moveOldPos1015ui_story = var_270_5.localPosition
			end

			local var_270_7 = 0.001

			if var_270_6 <= arg_267_1.time_ and arg_267_1.time_ < var_270_6 + var_270_7 then
				local var_270_8 = (arg_267_1.time_ - var_270_6) / var_270_7
				local var_270_9 = Vector3.New(0, -1.15, -6.2)

				var_270_5.localPosition = Vector3.Lerp(arg_267_1.var_.moveOldPos1015ui_story, var_270_9, var_270_8)

				local var_270_10 = manager.ui.mainCamera.transform.position - var_270_5.position

				var_270_5.forward = Vector3.New(var_270_10.x, var_270_10.y, var_270_10.z)

				local var_270_11 = var_270_5.localEulerAngles

				var_270_11.z = 0
				var_270_11.x = 0
				var_270_5.localEulerAngles = var_270_11
			end

			if arg_267_1.time_ >= var_270_6 + var_270_7 and arg_267_1.time_ < var_270_6 + var_270_7 + arg_270_0 then
				var_270_5.localPosition = Vector3.New(0, -1.15, -6.2)

				local var_270_12 = manager.ui.mainCamera.transform.position - var_270_5.position

				var_270_5.forward = Vector3.New(var_270_12.x, var_270_12.y, var_270_12.z)

				local var_270_13 = var_270_5.localEulerAngles

				var_270_13.z = 0
				var_270_13.x = 0
				var_270_5.localEulerAngles = var_270_13
			end

			local var_270_14 = arg_267_1.actors_["1015ui_story"]
			local var_270_15 = 0

			if var_270_15 < arg_267_1.time_ and arg_267_1.time_ <= var_270_15 + arg_270_0 and not isNil(var_270_14) and arg_267_1.var_.characterEffect1015ui_story == nil then
				arg_267_1.var_.characterEffect1015ui_story = var_270_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_270_16 = 0.200000002980232

			if var_270_15 <= arg_267_1.time_ and arg_267_1.time_ < var_270_15 + var_270_16 and not isNil(var_270_14) then
				local var_270_17 = (arg_267_1.time_ - var_270_15) / var_270_16

				if arg_267_1.var_.characterEffect1015ui_story and not isNil(var_270_14) then
					arg_267_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_267_1.time_ >= var_270_15 + var_270_16 and arg_267_1.time_ < var_270_15 + var_270_16 + arg_270_0 and not isNil(var_270_14) and arg_267_1.var_.characterEffect1015ui_story then
				arg_267_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			local var_270_18 = 0

			if var_270_18 < arg_267_1.time_ and arg_267_1.time_ <= var_270_18 + arg_270_0 then
				arg_267_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action5_1")
			end

			local var_270_19 = 0

			if var_270_19 < arg_267_1.time_ and arg_267_1.time_ <= var_270_19 + arg_270_0 then
				arg_267_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_270_20 = arg_267_1.actors_["1049ui_story"].transform
			local var_270_21 = 0

			if var_270_21 < arg_267_1.time_ and arg_267_1.time_ <= var_270_21 + arg_270_0 then
				arg_267_1.var_.moveOldPos1049ui_story = var_270_20.localPosition
			end

			local var_270_22 = 0.001

			if var_270_21 <= arg_267_1.time_ and arg_267_1.time_ < var_270_21 + var_270_22 then
				local var_270_23 = (arg_267_1.time_ - var_270_21) / var_270_22
				local var_270_24 = Vector3.New(0, 100, 0)

				var_270_20.localPosition = Vector3.Lerp(arg_267_1.var_.moveOldPos1049ui_story, var_270_24, var_270_23)

				local var_270_25 = manager.ui.mainCamera.transform.position - var_270_20.position

				var_270_20.forward = Vector3.New(var_270_25.x, var_270_25.y, var_270_25.z)

				local var_270_26 = var_270_20.localEulerAngles

				var_270_26.z = 0
				var_270_26.x = 0
				var_270_20.localEulerAngles = var_270_26
			end

			if arg_267_1.time_ >= var_270_21 + var_270_22 and arg_267_1.time_ < var_270_21 + var_270_22 + arg_270_0 then
				var_270_20.localPosition = Vector3.New(0, 100, 0)

				local var_270_27 = manager.ui.mainCamera.transform.position - var_270_20.position

				var_270_20.forward = Vector3.New(var_270_27.x, var_270_27.y, var_270_27.z)

				local var_270_28 = var_270_20.localEulerAngles

				var_270_28.z = 0
				var_270_28.x = 0
				var_270_20.localEulerAngles = var_270_28
			end

			local var_270_29 = arg_267_1.actors_["1049ui_story"]
			local var_270_30 = 0

			if var_270_30 < arg_267_1.time_ and arg_267_1.time_ <= var_270_30 + arg_270_0 and not isNil(var_270_29) and arg_267_1.var_.characterEffect1049ui_story == nil then
				arg_267_1.var_.characterEffect1049ui_story = var_270_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_270_31 = 0.200000002980232

			if var_270_30 <= arg_267_1.time_ and arg_267_1.time_ < var_270_30 + var_270_31 and not isNil(var_270_29) then
				local var_270_32 = (arg_267_1.time_ - var_270_30) / var_270_31

				if arg_267_1.var_.characterEffect1049ui_story and not isNil(var_270_29) then
					local var_270_33 = Mathf.Lerp(0, 0.5, var_270_32)

					arg_267_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_267_1.var_.characterEffect1049ui_story.fillRatio = var_270_33
				end
			end

			if arg_267_1.time_ >= var_270_30 + var_270_31 and arg_267_1.time_ < var_270_30 + var_270_31 + arg_270_0 and not isNil(var_270_29) and arg_267_1.var_.characterEffect1049ui_story then
				local var_270_34 = 0.5

				arg_267_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_267_1.var_.characterEffect1049ui_story.fillRatio = var_270_34
			end

			local var_270_35 = 0
			local var_270_36 = 0.6

			if var_270_35 < arg_267_1.time_ and arg_267_1.time_ <= var_270_35 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, true)

				local var_270_37 = arg_267_1:FormatText(StoryNameCfg[479].name)

				arg_267_1.leftNameTxt_.text = var_270_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_267_1.leftNameTxt_.transform)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1.leftNameTxt_.text)
				SetActive(arg_267_1.iconTrs_.gameObject, false)
				arg_267_1.callingController_:SetSelectedState("normal")

				local var_270_38 = arg_267_1:GetWordFromCfg(318161066)
				local var_270_39 = arg_267_1:FormatText(var_270_38.content)

				arg_267_1.text_.text = var_270_39

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_40 = 24
				local var_270_41 = utf8.len(var_270_39)
				local var_270_42 = var_270_40 <= 0 and var_270_36 or var_270_36 * (var_270_41 / var_270_40)

				if var_270_42 > 0 and var_270_36 < var_270_42 then
					arg_267_1.talkMaxDuration = var_270_42

					if var_270_42 + var_270_35 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_42 + var_270_35
					end
				end

				arg_267_1.text_.text = var_270_39
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318161", "318161066", "story_v_out_318161.awb") ~= 0 then
					local var_270_43 = manager.audio:GetVoiceLength("story_v_out_318161", "318161066", "story_v_out_318161.awb") / 1000

					if var_270_43 + var_270_35 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_43 + var_270_35
					end

					if var_270_38.prefab_name ~= "" and arg_267_1.actors_[var_270_38.prefab_name] ~= nil then
						local var_270_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_267_1.actors_[var_270_38.prefab_name].transform, "story_v_out_318161", "318161066", "story_v_out_318161.awb")

						arg_267_1:RecordAudio("318161066", var_270_44)
						arg_267_1:RecordAudio("318161066", var_270_44)
					else
						arg_267_1:AudioAction("play", "voice", "story_v_out_318161", "318161066", "story_v_out_318161.awb")
					end

					arg_267_1:RecordHistoryTalkVoice("story_v_out_318161", "318161066", "story_v_out_318161.awb")
				end

				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_45 = math.max(var_270_36, arg_267_1.talkMaxDuration)

			if var_270_35 <= arg_267_1.time_ and arg_267_1.time_ < var_270_35 + var_270_45 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - var_270_35) / var_270_45

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= var_270_35 + var_270_45 and arg_267_1.time_ < var_270_35 + var_270_45 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_267_1:InitPlayNodeList()
	end,
	Play318161067 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 318161067
		arg_271_1.duration_ = 3.53

		local var_271_0 = {
			zh = 2.566,
			ja = 3.533
		}
		local var_271_1 = manager.audio:GetLocalizationFlag()

		if var_271_0[var_271_1] ~= nil then
			arg_271_1.duration_ = var_271_0[var_271_1]
		end

		SetActive(arg_271_1.tipsGo_, false)

		function arg_271_1.onSingleLineFinish_()
			arg_271_1.onSingleLineUpdate_ = nil
			arg_271_1.onSingleLineFinish_ = nil
			arg_271_1.state_ = "waiting"
		end

		function arg_271_1.playNext_(arg_273_0)
			if arg_273_0 == 1 then
				arg_271_0:Play318161068(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			local var_274_0 = "10066ui_story"

			if arg_271_1.actors_[var_274_0] == nil then
				local var_274_1 = Asset.Load("Char/" .. "10066ui_story")

				if not isNil(var_274_1) then
					local var_274_2 = Object.Instantiate(Asset.Load("Char/" .. "10066ui_story"), arg_271_1.stage_.transform)

					var_274_2.name = var_274_0
					var_274_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_271_1.actors_[var_274_0] = var_274_2

					local var_274_3 = var_274_2:GetComponentInChildren(typeof(CharacterEffect))

					var_274_3.enabled = true

					local var_274_4 = GameObjectTools.GetOrAddComponent(var_274_2, typeof(DynamicBoneHelper))

					if var_274_4 then
						var_274_4:EnableDynamicBone(false)
					end

					arg_271_1:ShowWeapon(var_274_3.transform, false)

					arg_271_1.var_[var_274_0 .. "Animator"] = var_274_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_271_1.var_[var_274_0 .. "Animator"].applyRootMotion = true
					arg_271_1.var_[var_274_0 .. "LipSync"] = var_274_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_274_5 = arg_271_1.actors_["10066ui_story"].transform
			local var_274_6 = 0

			if var_274_6 < arg_271_1.time_ and arg_271_1.time_ <= var_274_6 + arg_274_0 then
				arg_271_1.var_.moveOldPos10066ui_story = var_274_5.localPosition
			end

			local var_274_7 = 0.001

			if var_274_6 <= arg_271_1.time_ and arg_271_1.time_ < var_274_6 + var_274_7 then
				local var_274_8 = (arg_271_1.time_ - var_274_6) / var_274_7
				local var_274_9 = Vector3.New(0.7, -0.99, -5.83)

				var_274_5.localPosition = Vector3.Lerp(arg_271_1.var_.moveOldPos10066ui_story, var_274_9, var_274_8)

				local var_274_10 = manager.ui.mainCamera.transform.position - var_274_5.position

				var_274_5.forward = Vector3.New(var_274_10.x, var_274_10.y, var_274_10.z)

				local var_274_11 = var_274_5.localEulerAngles

				var_274_11.z = 0
				var_274_11.x = 0
				var_274_5.localEulerAngles = var_274_11
			end

			if arg_271_1.time_ >= var_274_6 + var_274_7 and arg_271_1.time_ < var_274_6 + var_274_7 + arg_274_0 then
				var_274_5.localPosition = Vector3.New(0.7, -0.99, -5.83)

				local var_274_12 = manager.ui.mainCamera.transform.position - var_274_5.position

				var_274_5.forward = Vector3.New(var_274_12.x, var_274_12.y, var_274_12.z)

				local var_274_13 = var_274_5.localEulerAngles

				var_274_13.z = 0
				var_274_13.x = 0
				var_274_5.localEulerAngles = var_274_13
			end

			local var_274_14 = arg_271_1.actors_["10066ui_story"]
			local var_274_15 = 0

			if var_274_15 < arg_271_1.time_ and arg_271_1.time_ <= var_274_15 + arg_274_0 and not isNil(var_274_14) and arg_271_1.var_.characterEffect10066ui_story == nil then
				arg_271_1.var_.characterEffect10066ui_story = var_274_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_274_16 = 0.200000002980232

			if var_274_15 <= arg_271_1.time_ and arg_271_1.time_ < var_274_15 + var_274_16 and not isNil(var_274_14) then
				local var_274_17 = (arg_271_1.time_ - var_274_15) / var_274_16

				if arg_271_1.var_.characterEffect10066ui_story and not isNil(var_274_14) then
					arg_271_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_271_1.time_ >= var_274_15 + var_274_16 and arg_271_1.time_ < var_274_15 + var_274_16 + arg_274_0 and not isNil(var_274_14) and arg_271_1.var_.characterEffect10066ui_story then
				arg_271_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_274_18 = 0

			if var_274_18 < arg_271_1.time_ and arg_271_1.time_ <= var_274_18 + arg_274_0 then
				arg_271_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action4_1")
			end

			local var_274_19 = 0

			if var_274_19 < arg_271_1.time_ and arg_271_1.time_ <= var_274_19 + arg_274_0 then
				arg_271_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_274_20 = arg_271_1.actors_["1015ui_story"].transform
			local var_274_21 = 0

			if var_274_21 < arg_271_1.time_ and arg_271_1.time_ <= var_274_21 + arg_274_0 then
				arg_271_1.var_.moveOldPos1015ui_story = var_274_20.localPosition
			end

			local var_274_22 = 0.001

			if var_274_21 <= arg_271_1.time_ and arg_271_1.time_ < var_274_21 + var_274_22 then
				local var_274_23 = (arg_271_1.time_ - var_274_21) / var_274_22
				local var_274_24 = Vector3.New(-0.7, -1.15, -6.2)

				var_274_20.localPosition = Vector3.Lerp(arg_271_1.var_.moveOldPos1015ui_story, var_274_24, var_274_23)

				local var_274_25 = manager.ui.mainCamera.transform.position - var_274_20.position

				var_274_20.forward = Vector3.New(var_274_25.x, var_274_25.y, var_274_25.z)

				local var_274_26 = var_274_20.localEulerAngles

				var_274_26.z = 0
				var_274_26.x = 0
				var_274_20.localEulerAngles = var_274_26
			end

			if arg_271_1.time_ >= var_274_21 + var_274_22 and arg_271_1.time_ < var_274_21 + var_274_22 + arg_274_0 then
				var_274_20.localPosition = Vector3.New(-0.7, -1.15, -6.2)

				local var_274_27 = manager.ui.mainCamera.transform.position - var_274_20.position

				var_274_20.forward = Vector3.New(var_274_27.x, var_274_27.y, var_274_27.z)

				local var_274_28 = var_274_20.localEulerAngles

				var_274_28.z = 0
				var_274_28.x = 0
				var_274_20.localEulerAngles = var_274_28
			end

			local var_274_29 = arg_271_1.actors_["1015ui_story"]
			local var_274_30 = 0

			if var_274_30 < arg_271_1.time_ and arg_271_1.time_ <= var_274_30 + arg_274_0 and not isNil(var_274_29) and arg_271_1.var_.characterEffect1015ui_story == nil then
				arg_271_1.var_.characterEffect1015ui_story = var_274_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_274_31 = 0.200000002980232

			if var_274_30 <= arg_271_1.time_ and arg_271_1.time_ < var_274_30 + var_274_31 and not isNil(var_274_29) then
				local var_274_32 = (arg_271_1.time_ - var_274_30) / var_274_31

				if arg_271_1.var_.characterEffect1015ui_story and not isNil(var_274_29) then
					local var_274_33 = Mathf.Lerp(0, 0.5, var_274_32)

					arg_271_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_271_1.var_.characterEffect1015ui_story.fillRatio = var_274_33
				end
			end

			if arg_271_1.time_ >= var_274_30 + var_274_31 and arg_271_1.time_ < var_274_30 + var_274_31 + arg_274_0 and not isNil(var_274_29) and arg_271_1.var_.characterEffect1015ui_story then
				local var_274_34 = 0.5

				arg_271_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_271_1.var_.characterEffect1015ui_story.fillRatio = var_274_34
			end

			local var_274_35 = 0
			local var_274_36 = 0.125

			if var_274_35 < arg_271_1.time_ and arg_271_1.time_ <= var_274_35 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, true)

				local var_274_37 = arg_271_1:FormatText(StoryNameCfg[640].name)

				arg_271_1.leftNameTxt_.text = var_274_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_271_1.leftNameTxt_.transform)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1.leftNameTxt_.text)
				SetActive(arg_271_1.iconTrs_.gameObject, false)
				arg_271_1.callingController_:SetSelectedState("normal")

				local var_274_38 = arg_271_1:GetWordFromCfg(318161067)
				local var_274_39 = arg_271_1:FormatText(var_274_38.content)

				arg_271_1.text_.text = var_274_39

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_40 = 5
				local var_274_41 = utf8.len(var_274_39)
				local var_274_42 = var_274_40 <= 0 and var_274_36 or var_274_36 * (var_274_41 / var_274_40)

				if var_274_42 > 0 and var_274_36 < var_274_42 then
					arg_271_1.talkMaxDuration = var_274_42

					if var_274_42 + var_274_35 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_42 + var_274_35
					end
				end

				arg_271_1.text_.text = var_274_39
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318161", "318161067", "story_v_out_318161.awb") ~= 0 then
					local var_274_43 = manager.audio:GetVoiceLength("story_v_out_318161", "318161067", "story_v_out_318161.awb") / 1000

					if var_274_43 + var_274_35 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_43 + var_274_35
					end

					if var_274_38.prefab_name ~= "" and arg_271_1.actors_[var_274_38.prefab_name] ~= nil then
						local var_274_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_271_1.actors_[var_274_38.prefab_name].transform, "story_v_out_318161", "318161067", "story_v_out_318161.awb")

						arg_271_1:RecordAudio("318161067", var_274_44)
						arg_271_1:RecordAudio("318161067", var_274_44)
					else
						arg_271_1:AudioAction("play", "voice", "story_v_out_318161", "318161067", "story_v_out_318161.awb")
					end

					arg_271_1:RecordHistoryTalkVoice("story_v_out_318161", "318161067", "story_v_out_318161.awb")
				end

				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_45 = math.max(var_274_36, arg_271_1.talkMaxDuration)

			if var_274_35 <= arg_271_1.time_ and arg_271_1.time_ < var_274_35 + var_274_45 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - var_274_35) / var_274_45

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= var_274_35 + var_274_45 and arg_271_1.time_ < var_274_35 + var_274_45 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1015ui_story",
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
	Play318161068 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 318161068
		arg_275_1.duration_ = 5

		SetActive(arg_275_1.tipsGo_, false)

		function arg_275_1.onSingleLineFinish_()
			arg_275_1.onSingleLineUpdate_ = nil
			arg_275_1.onSingleLineFinish_ = nil
			arg_275_1.state_ = "waiting"
		end

		function arg_275_1.playNext_(arg_277_0)
			if arg_277_0 == 1 then
				arg_275_0:Play318161069(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			local var_278_0 = arg_275_1.actors_["10066ui_story"]
			local var_278_1 = 0

			if var_278_1 < arg_275_1.time_ and arg_275_1.time_ <= var_278_1 + arg_278_0 and not isNil(var_278_0) and arg_275_1.var_.characterEffect10066ui_story == nil then
				arg_275_1.var_.characterEffect10066ui_story = var_278_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_278_2 = 0.200000002980232

			if var_278_1 <= arg_275_1.time_ and arg_275_1.time_ < var_278_1 + var_278_2 and not isNil(var_278_0) then
				local var_278_3 = (arg_275_1.time_ - var_278_1) / var_278_2

				if arg_275_1.var_.characterEffect10066ui_story and not isNil(var_278_0) then
					local var_278_4 = Mathf.Lerp(0, 0.5, var_278_3)

					arg_275_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_275_1.var_.characterEffect10066ui_story.fillRatio = var_278_4
				end
			end

			if arg_275_1.time_ >= var_278_1 + var_278_2 and arg_275_1.time_ < var_278_1 + var_278_2 + arg_278_0 and not isNil(var_278_0) and arg_275_1.var_.characterEffect10066ui_story then
				local var_278_5 = 0.5

				arg_275_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_275_1.var_.characterEffect10066ui_story.fillRatio = var_278_5
			end

			local var_278_6 = 0
			local var_278_7 = 0.725

			if var_278_6 < arg_275_1.time_ and arg_275_1.time_ <= var_278_6 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, false)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_275_1.iconTrs_.gameObject, false)
				arg_275_1.callingController_:SetSelectedState("normal")

				local var_278_8 = arg_275_1:GetWordFromCfg(318161068)
				local var_278_9 = arg_275_1:FormatText(var_278_8.content)

				arg_275_1.text_.text = var_278_9

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_10 = 29
				local var_278_11 = utf8.len(var_278_9)
				local var_278_12 = var_278_10 <= 0 and var_278_7 or var_278_7 * (var_278_11 / var_278_10)

				if var_278_12 > 0 and var_278_7 < var_278_12 then
					arg_275_1.talkMaxDuration = var_278_12

					if var_278_12 + var_278_6 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_12 + var_278_6
					end
				end

				arg_275_1.text_.text = var_278_9
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)
				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_13 = math.max(var_278_7, arg_275_1.talkMaxDuration)

			if var_278_6 <= arg_275_1.time_ and arg_275_1.time_ < var_278_6 + var_278_13 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - var_278_6) / var_278_13

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= var_278_6 + var_278_13 and arg_275_1.time_ < var_278_6 + var_278_13 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {}

		arg_275_1:InitPlayNodeList()
	end,
	Play318161069 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 318161069
		arg_279_1.duration_ = 5

		SetActive(arg_279_1.tipsGo_, false)

		function arg_279_1.onSingleLineFinish_()
			arg_279_1.onSingleLineUpdate_ = nil
			arg_279_1.onSingleLineFinish_ = nil
			arg_279_1.state_ = "waiting"
		end

		function arg_279_1.playNext_(arg_281_0)
			if arg_281_0 == 1 then
				arg_279_0:Play318161070(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			local var_282_0 = 0
			local var_282_1 = 1.625

			if var_282_0 < arg_279_1.time_ and arg_279_1.time_ <= var_282_0 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, false)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_279_1.iconTrs_.gameObject, false)
				arg_279_1.callingController_:SetSelectedState("normal")

				local var_282_2 = arg_279_1:GetWordFromCfg(318161069)
				local var_282_3 = arg_279_1:FormatText(var_282_2.content)

				arg_279_1.text_.text = var_282_3

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_4 = 65
				local var_282_5 = utf8.len(var_282_3)
				local var_282_6 = var_282_4 <= 0 and var_282_1 or var_282_1 * (var_282_5 / var_282_4)

				if var_282_6 > 0 and var_282_1 < var_282_6 then
					arg_279_1.talkMaxDuration = var_282_6

					if var_282_6 + var_282_0 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_6 + var_282_0
					end
				end

				arg_279_1.text_.text = var_282_3
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)
				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_7 = math.max(var_282_1, arg_279_1.talkMaxDuration)

			if var_282_0 <= arg_279_1.time_ and arg_279_1.time_ < var_282_0 + var_282_7 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - var_282_0) / var_282_7

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= var_282_0 + var_282_7 and arg_279_1.time_ < var_282_0 + var_282_7 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {}

		arg_279_1:InitPlayNodeList()
	end,
	Play318161070 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 318161070
		arg_283_1.duration_ = 3.67

		local var_283_0 = {
			zh = 3.5,
			ja = 3.666
		}
		local var_283_1 = manager.audio:GetLocalizationFlag()

		if var_283_0[var_283_1] ~= nil then
			arg_283_1.duration_ = var_283_0[var_283_1]
		end

		SetActive(arg_283_1.tipsGo_, false)

		function arg_283_1.onSingleLineFinish_()
			arg_283_1.onSingleLineUpdate_ = nil
			arg_283_1.onSingleLineFinish_ = nil
			arg_283_1.state_ = "waiting"
		end

		function arg_283_1.playNext_(arg_285_0)
			if arg_285_0 == 1 then
				arg_283_0:Play318161071(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			local var_286_0 = arg_283_1.actors_["1015ui_story"]
			local var_286_1 = 0

			if var_286_1 < arg_283_1.time_ and arg_283_1.time_ <= var_286_1 + arg_286_0 and not isNil(var_286_0) and arg_283_1.var_.characterEffect1015ui_story == nil then
				arg_283_1.var_.characterEffect1015ui_story = var_286_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_286_2 = 0.200000002980232

			if var_286_1 <= arg_283_1.time_ and arg_283_1.time_ < var_286_1 + var_286_2 and not isNil(var_286_0) then
				local var_286_3 = (arg_283_1.time_ - var_286_1) / var_286_2

				if arg_283_1.var_.characterEffect1015ui_story and not isNil(var_286_0) then
					arg_283_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_283_1.time_ >= var_286_1 + var_286_2 and arg_283_1.time_ < var_286_1 + var_286_2 + arg_286_0 and not isNil(var_286_0) and arg_283_1.var_.characterEffect1015ui_story then
				arg_283_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			local var_286_4 = 0

			if var_286_4 < arg_283_1.time_ and arg_283_1.time_ <= var_286_4 + arg_286_0 then
				arg_283_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015actionlink/1015action452")
			end

			local var_286_5 = 0

			if var_286_5 < arg_283_1.time_ and arg_283_1.time_ <= var_286_5 + arg_286_0 then
				arg_283_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_286_6 = 0
			local var_286_7 = 0.475

			if var_286_6 < arg_283_1.time_ and arg_283_1.time_ <= var_286_6 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, true)

				local var_286_8 = arg_283_1:FormatText(StoryNameCfg[479].name)

				arg_283_1.leftNameTxt_.text = var_286_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_283_1.leftNameTxt_.transform)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1.leftNameTxt_.text)
				SetActive(arg_283_1.iconTrs_.gameObject, false)
				arg_283_1.callingController_:SetSelectedState("normal")

				local var_286_9 = arg_283_1:GetWordFromCfg(318161070)
				local var_286_10 = arg_283_1:FormatText(var_286_9.content)

				arg_283_1.text_.text = var_286_10

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_11 = 19
				local var_286_12 = utf8.len(var_286_10)
				local var_286_13 = var_286_11 <= 0 and var_286_7 or var_286_7 * (var_286_12 / var_286_11)

				if var_286_13 > 0 and var_286_7 < var_286_13 then
					arg_283_1.talkMaxDuration = var_286_13

					if var_286_13 + var_286_6 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_13 + var_286_6
					end
				end

				arg_283_1.text_.text = var_286_10
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318161", "318161070", "story_v_out_318161.awb") ~= 0 then
					local var_286_14 = manager.audio:GetVoiceLength("story_v_out_318161", "318161070", "story_v_out_318161.awb") / 1000

					if var_286_14 + var_286_6 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_14 + var_286_6
					end

					if var_286_9.prefab_name ~= "" and arg_283_1.actors_[var_286_9.prefab_name] ~= nil then
						local var_286_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_283_1.actors_[var_286_9.prefab_name].transform, "story_v_out_318161", "318161070", "story_v_out_318161.awb")

						arg_283_1:RecordAudio("318161070", var_286_15)
						arg_283_1:RecordAudio("318161070", var_286_15)
					else
						arg_283_1:AudioAction("play", "voice", "story_v_out_318161", "318161070", "story_v_out_318161.awb")
					end

					arg_283_1:RecordHistoryTalkVoice("story_v_out_318161", "318161070", "story_v_out_318161.awb")
				end

				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_16 = math.max(var_286_7, arg_283_1.talkMaxDuration)

			if var_286_6 <= arg_283_1.time_ and arg_283_1.time_ < var_286_6 + var_286_16 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - var_286_6) / var_286_16

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= var_286_6 + var_286_16 and arg_283_1.time_ < var_286_6 + var_286_16 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {}

		arg_283_1:InitPlayNodeList()
	end,
	Play318161071 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 318161071
		arg_287_1.duration_ = 5.6

		local var_287_0 = {
			zh = 5.3,
			ja = 5.6
		}
		local var_287_1 = manager.audio:GetLocalizationFlag()

		if var_287_0[var_287_1] ~= nil then
			arg_287_1.duration_ = var_287_0[var_287_1]
		end

		SetActive(arg_287_1.tipsGo_, false)

		function arg_287_1.onSingleLineFinish_()
			arg_287_1.onSingleLineUpdate_ = nil
			arg_287_1.onSingleLineFinish_ = nil
			arg_287_1.state_ = "waiting"
		end

		function arg_287_1.playNext_(arg_289_0)
			if arg_289_0 == 1 then
				arg_287_0:Play318161072(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			local var_290_0 = arg_287_1.actors_["10066ui_story"]
			local var_290_1 = 0

			if var_290_1 < arg_287_1.time_ and arg_287_1.time_ <= var_290_1 + arg_290_0 and not isNil(var_290_0) and arg_287_1.var_.characterEffect10066ui_story == nil then
				arg_287_1.var_.characterEffect10066ui_story = var_290_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_290_2 = 0.200000002980232

			if var_290_1 <= arg_287_1.time_ and arg_287_1.time_ < var_290_1 + var_290_2 and not isNil(var_290_0) then
				local var_290_3 = (arg_287_1.time_ - var_290_1) / var_290_2

				if arg_287_1.var_.characterEffect10066ui_story and not isNil(var_290_0) then
					arg_287_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_287_1.time_ >= var_290_1 + var_290_2 and arg_287_1.time_ < var_290_1 + var_290_2 + arg_290_0 and not isNil(var_290_0) and arg_287_1.var_.characterEffect10066ui_story then
				arg_287_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_290_4 = arg_287_1.actors_["1015ui_story"]
			local var_290_5 = 0

			if var_290_5 < arg_287_1.time_ and arg_287_1.time_ <= var_290_5 + arg_290_0 and not isNil(var_290_4) and arg_287_1.var_.characterEffect1015ui_story == nil then
				arg_287_1.var_.characterEffect1015ui_story = var_290_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_290_6 = 0.200000002980232

			if var_290_5 <= arg_287_1.time_ and arg_287_1.time_ < var_290_5 + var_290_6 and not isNil(var_290_4) then
				local var_290_7 = (arg_287_1.time_ - var_290_5) / var_290_6

				if arg_287_1.var_.characterEffect1015ui_story and not isNil(var_290_4) then
					local var_290_8 = Mathf.Lerp(0, 0.5, var_290_7)

					arg_287_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_287_1.var_.characterEffect1015ui_story.fillRatio = var_290_8
				end
			end

			if arg_287_1.time_ >= var_290_5 + var_290_6 and arg_287_1.time_ < var_290_5 + var_290_6 + arg_290_0 and not isNil(var_290_4) and arg_287_1.var_.characterEffect1015ui_story then
				local var_290_9 = 0.5

				arg_287_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_287_1.var_.characterEffect1015ui_story.fillRatio = var_290_9
			end

			local var_290_10 = 0

			if var_290_10 < arg_287_1.time_ and arg_287_1.time_ <= var_290_10 + arg_290_0 then
				arg_287_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066actionlink/10066action443")
			end

			local var_290_11 = 0

			if var_290_11 < arg_287_1.time_ and arg_287_1.time_ <= var_290_11 + arg_290_0 then
				arg_287_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_290_12 = 0
			local var_290_13 = 0.625

			if var_290_12 < arg_287_1.time_ and arg_287_1.time_ <= var_290_12 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, true)

				local var_290_14 = arg_287_1:FormatText(StoryNameCfg[640].name)

				arg_287_1.leftNameTxt_.text = var_290_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_287_1.leftNameTxt_.transform)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1.leftNameTxt_.text)
				SetActive(arg_287_1.iconTrs_.gameObject, false)
				arg_287_1.callingController_:SetSelectedState("normal")

				local var_290_15 = arg_287_1:GetWordFromCfg(318161071)
				local var_290_16 = arg_287_1:FormatText(var_290_15.content)

				arg_287_1.text_.text = var_290_16

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_17 = 25
				local var_290_18 = utf8.len(var_290_16)
				local var_290_19 = var_290_17 <= 0 and var_290_13 or var_290_13 * (var_290_18 / var_290_17)

				if var_290_19 > 0 and var_290_13 < var_290_19 then
					arg_287_1.talkMaxDuration = var_290_19

					if var_290_19 + var_290_12 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_19 + var_290_12
					end
				end

				arg_287_1.text_.text = var_290_16
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318161", "318161071", "story_v_out_318161.awb") ~= 0 then
					local var_290_20 = manager.audio:GetVoiceLength("story_v_out_318161", "318161071", "story_v_out_318161.awb") / 1000

					if var_290_20 + var_290_12 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_20 + var_290_12
					end

					if var_290_15.prefab_name ~= "" and arg_287_1.actors_[var_290_15.prefab_name] ~= nil then
						local var_290_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_287_1.actors_[var_290_15.prefab_name].transform, "story_v_out_318161", "318161071", "story_v_out_318161.awb")

						arg_287_1:RecordAudio("318161071", var_290_21)
						arg_287_1:RecordAudio("318161071", var_290_21)
					else
						arg_287_1:AudioAction("play", "voice", "story_v_out_318161", "318161071", "story_v_out_318161.awb")
					end

					arg_287_1:RecordHistoryTalkVoice("story_v_out_318161", "318161071", "story_v_out_318161.awb")
				end

				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_22 = math.max(var_290_13, arg_287_1.talkMaxDuration)

			if var_290_12 <= arg_287_1.time_ and arg_287_1.time_ < var_290_12 + var_290_22 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - var_290_12) / var_290_22

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= var_290_12 + var_290_22 and arg_287_1.time_ < var_290_12 + var_290_22 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {}

		arg_287_1:InitPlayNodeList()
	end,
	Play318161072 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 318161072
		arg_291_1.duration_ = 3.4

		local var_291_0 = {
			zh = 3.4,
			ja = 3.033
		}
		local var_291_1 = manager.audio:GetLocalizationFlag()

		if var_291_0[var_291_1] ~= nil then
			arg_291_1.duration_ = var_291_0[var_291_1]
		end

		SetActive(arg_291_1.tipsGo_, false)

		function arg_291_1.onSingleLineFinish_()
			arg_291_1.onSingleLineUpdate_ = nil
			arg_291_1.onSingleLineFinish_ = nil
			arg_291_1.state_ = "waiting"
		end

		function arg_291_1.playNext_(arg_293_0)
			if arg_293_0 == 1 then
				arg_291_0:Play318161073(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			local var_294_0 = arg_291_1.actors_["1015ui_story"]
			local var_294_1 = 0

			if var_294_1 < arg_291_1.time_ and arg_291_1.time_ <= var_294_1 + arg_294_0 and not isNil(var_294_0) and arg_291_1.var_.characterEffect1015ui_story == nil then
				arg_291_1.var_.characterEffect1015ui_story = var_294_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_294_2 = 0.200000002980232

			if var_294_1 <= arg_291_1.time_ and arg_291_1.time_ < var_294_1 + var_294_2 and not isNil(var_294_0) then
				local var_294_3 = (arg_291_1.time_ - var_294_1) / var_294_2

				if arg_291_1.var_.characterEffect1015ui_story and not isNil(var_294_0) then
					arg_291_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_291_1.time_ >= var_294_1 + var_294_2 and arg_291_1.time_ < var_294_1 + var_294_2 + arg_294_0 and not isNil(var_294_0) and arg_291_1.var_.characterEffect1015ui_story then
				arg_291_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			local var_294_4 = arg_291_1.actors_["10066ui_story"]
			local var_294_5 = 0

			if var_294_5 < arg_291_1.time_ and arg_291_1.time_ <= var_294_5 + arg_294_0 and not isNil(var_294_4) and arg_291_1.var_.characterEffect10066ui_story == nil then
				arg_291_1.var_.characterEffect10066ui_story = var_294_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_294_6 = 0.200000002980232

			if var_294_5 <= arg_291_1.time_ and arg_291_1.time_ < var_294_5 + var_294_6 and not isNil(var_294_4) then
				local var_294_7 = (arg_291_1.time_ - var_294_5) / var_294_6

				if arg_291_1.var_.characterEffect10066ui_story and not isNil(var_294_4) then
					local var_294_8 = Mathf.Lerp(0, 0.5, var_294_7)

					arg_291_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_291_1.var_.characterEffect10066ui_story.fillRatio = var_294_8
				end
			end

			if arg_291_1.time_ >= var_294_5 + var_294_6 and arg_291_1.time_ < var_294_5 + var_294_6 + arg_294_0 and not isNil(var_294_4) and arg_291_1.var_.characterEffect10066ui_story then
				local var_294_9 = 0.5

				arg_291_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_291_1.var_.characterEffect10066ui_story.fillRatio = var_294_9
			end

			local var_294_10 = 0

			if var_294_10 < arg_291_1.time_ and arg_291_1.time_ <= var_294_10 + arg_294_0 then
				arg_291_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action2_2")
			end

			local var_294_11 = 0
			local var_294_12 = 0.45

			if var_294_11 < arg_291_1.time_ and arg_291_1.time_ <= var_294_11 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0
				arg_291_1.dialogCg_.alpha = 1

				arg_291_1.dialog_:SetActive(true)
				SetActive(arg_291_1.leftNameGo_, true)

				local var_294_13 = arg_291_1:FormatText(StoryNameCfg[479].name)

				arg_291_1.leftNameTxt_.text = var_294_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_291_1.leftNameTxt_.transform)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1.leftNameTxt_.text)
				SetActive(arg_291_1.iconTrs_.gameObject, false)
				arg_291_1.callingController_:SetSelectedState("normal")

				local var_294_14 = arg_291_1:GetWordFromCfg(318161072)
				local var_294_15 = arg_291_1:FormatText(var_294_14.content)

				arg_291_1.text_.text = var_294_15

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_16 = 18
				local var_294_17 = utf8.len(var_294_15)
				local var_294_18 = var_294_16 <= 0 and var_294_12 or var_294_12 * (var_294_17 / var_294_16)

				if var_294_18 > 0 and var_294_12 < var_294_18 then
					arg_291_1.talkMaxDuration = var_294_18

					if var_294_18 + var_294_11 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_18 + var_294_11
					end
				end

				arg_291_1.text_.text = var_294_15
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318161", "318161072", "story_v_out_318161.awb") ~= 0 then
					local var_294_19 = manager.audio:GetVoiceLength("story_v_out_318161", "318161072", "story_v_out_318161.awb") / 1000

					if var_294_19 + var_294_11 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_19 + var_294_11
					end

					if var_294_14.prefab_name ~= "" and arg_291_1.actors_[var_294_14.prefab_name] ~= nil then
						local var_294_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_291_1.actors_[var_294_14.prefab_name].transform, "story_v_out_318161", "318161072", "story_v_out_318161.awb")

						arg_291_1:RecordAudio("318161072", var_294_20)
						arg_291_1:RecordAudio("318161072", var_294_20)
					else
						arg_291_1:AudioAction("play", "voice", "story_v_out_318161", "318161072", "story_v_out_318161.awb")
					end

					arg_291_1:RecordHistoryTalkVoice("story_v_out_318161", "318161072", "story_v_out_318161.awb")
				end

				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_21 = math.max(var_294_12, arg_291_1.talkMaxDuration)

			if var_294_11 <= arg_291_1.time_ and arg_291_1.time_ < var_294_11 + var_294_21 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - var_294_11) / var_294_21

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= var_294_11 + var_294_21 and arg_291_1.time_ < var_294_11 + var_294_21 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {}

		arg_291_1:InitPlayNodeList()
	end,
	Play318161073 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 318161073
		arg_295_1.duration_ = 8.7

		local var_295_0 = {
			zh = 7.666,
			ja = 8.7
		}
		local var_295_1 = manager.audio:GetLocalizationFlag()

		if var_295_0[var_295_1] ~= nil then
			arg_295_1.duration_ = var_295_0[var_295_1]
		end

		SetActive(arg_295_1.tipsGo_, false)

		function arg_295_1.onSingleLineFinish_()
			arg_295_1.onSingleLineUpdate_ = nil
			arg_295_1.onSingleLineFinish_ = nil
			arg_295_1.state_ = "waiting"
		end

		function arg_295_1.playNext_(arg_297_0)
			if arg_297_0 == 1 then
				arg_295_0:Play318161074(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			local var_298_0 = 0
			local var_298_1 = 0.825

			if var_298_0 < arg_295_1.time_ and arg_295_1.time_ <= var_298_0 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, true)

				local var_298_2 = arg_295_1:FormatText(StoryNameCfg[479].name)

				arg_295_1.leftNameTxt_.text = var_298_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_295_1.leftNameTxt_.transform)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1.leftNameTxt_.text)
				SetActive(arg_295_1.iconTrs_.gameObject, false)
				arg_295_1.callingController_:SetSelectedState("normal")

				local var_298_3 = arg_295_1:GetWordFromCfg(318161073)
				local var_298_4 = arg_295_1:FormatText(var_298_3.content)

				arg_295_1.text_.text = var_298_4

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_5 = 33
				local var_298_6 = utf8.len(var_298_4)
				local var_298_7 = var_298_5 <= 0 and var_298_1 or var_298_1 * (var_298_6 / var_298_5)

				if var_298_7 > 0 and var_298_1 < var_298_7 then
					arg_295_1.talkMaxDuration = var_298_7

					if var_298_7 + var_298_0 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_7 + var_298_0
					end
				end

				arg_295_1.text_.text = var_298_4
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318161", "318161073", "story_v_out_318161.awb") ~= 0 then
					local var_298_8 = manager.audio:GetVoiceLength("story_v_out_318161", "318161073", "story_v_out_318161.awb") / 1000

					if var_298_8 + var_298_0 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_8 + var_298_0
					end

					if var_298_3.prefab_name ~= "" and arg_295_1.actors_[var_298_3.prefab_name] ~= nil then
						local var_298_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_295_1.actors_[var_298_3.prefab_name].transform, "story_v_out_318161", "318161073", "story_v_out_318161.awb")

						arg_295_1:RecordAudio("318161073", var_298_9)
						arg_295_1:RecordAudio("318161073", var_298_9)
					else
						arg_295_1:AudioAction("play", "voice", "story_v_out_318161", "318161073", "story_v_out_318161.awb")
					end

					arg_295_1:RecordHistoryTalkVoice("story_v_out_318161", "318161073", "story_v_out_318161.awb")
				end

				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_10 = math.max(var_298_1, arg_295_1.talkMaxDuration)

			if var_298_0 <= arg_295_1.time_ and arg_295_1.time_ < var_298_0 + var_298_10 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - var_298_0) / var_298_10

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= var_298_0 + var_298_10 and arg_295_1.time_ < var_298_0 + var_298_10 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {}

		arg_295_1:InitPlayNodeList()
	end,
	Play318161074 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 318161074
		arg_299_1.duration_ = 5.53

		local var_299_0 = {
			zh = 2.8,
			ja = 5.533
		}
		local var_299_1 = manager.audio:GetLocalizationFlag()

		if var_299_0[var_299_1] ~= nil then
			arg_299_1.duration_ = var_299_0[var_299_1]
		end

		SetActive(arg_299_1.tipsGo_, false)

		function arg_299_1.onSingleLineFinish_()
			arg_299_1.onSingleLineUpdate_ = nil
			arg_299_1.onSingleLineFinish_ = nil
			arg_299_1.state_ = "waiting"
		end

		function arg_299_1.playNext_(arg_301_0)
			if arg_301_0 == 1 then
				arg_299_0:Play318161075(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			local var_302_0 = arg_299_1.actors_["10066ui_story"]
			local var_302_1 = 0

			if var_302_1 < arg_299_1.time_ and arg_299_1.time_ <= var_302_1 + arg_302_0 and not isNil(var_302_0) and arg_299_1.var_.characterEffect10066ui_story == nil then
				arg_299_1.var_.characterEffect10066ui_story = var_302_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_302_2 = 0.200000002980232

			if var_302_1 <= arg_299_1.time_ and arg_299_1.time_ < var_302_1 + var_302_2 and not isNil(var_302_0) then
				local var_302_3 = (arg_299_1.time_ - var_302_1) / var_302_2

				if arg_299_1.var_.characterEffect10066ui_story and not isNil(var_302_0) then
					arg_299_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_299_1.time_ >= var_302_1 + var_302_2 and arg_299_1.time_ < var_302_1 + var_302_2 + arg_302_0 and not isNil(var_302_0) and arg_299_1.var_.characterEffect10066ui_story then
				arg_299_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_302_4 = arg_299_1.actors_["1015ui_story"]
			local var_302_5 = 0

			if var_302_5 < arg_299_1.time_ and arg_299_1.time_ <= var_302_5 + arg_302_0 and not isNil(var_302_4) and arg_299_1.var_.characterEffect1015ui_story == nil then
				arg_299_1.var_.characterEffect1015ui_story = var_302_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_302_6 = 0.200000002980232

			if var_302_5 <= arg_299_1.time_ and arg_299_1.time_ < var_302_5 + var_302_6 and not isNil(var_302_4) then
				local var_302_7 = (arg_299_1.time_ - var_302_5) / var_302_6

				if arg_299_1.var_.characterEffect1015ui_story and not isNil(var_302_4) then
					local var_302_8 = Mathf.Lerp(0, 0.5, var_302_7)

					arg_299_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_299_1.var_.characterEffect1015ui_story.fillRatio = var_302_8
				end
			end

			if arg_299_1.time_ >= var_302_5 + var_302_6 and arg_299_1.time_ < var_302_5 + var_302_6 + arg_302_0 and not isNil(var_302_4) and arg_299_1.var_.characterEffect1015ui_story then
				local var_302_9 = 0.5

				arg_299_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_299_1.var_.characterEffect1015ui_story.fillRatio = var_302_9
			end

			local var_302_10 = 0

			if var_302_10 < arg_299_1.time_ and arg_299_1.time_ <= var_302_10 + arg_302_0 then
				arg_299_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066actionlink/10066action434")
			end

			local var_302_11 = 0

			if var_302_11 < arg_299_1.time_ and arg_299_1.time_ <= var_302_11 + arg_302_0 then
				arg_299_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_302_12 = 0
			local var_302_13 = 0.175

			if var_302_12 < arg_299_1.time_ and arg_299_1.time_ <= var_302_12 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0
				arg_299_1.dialogCg_.alpha = 1

				arg_299_1.dialog_:SetActive(true)
				SetActive(arg_299_1.leftNameGo_, true)

				local var_302_14 = arg_299_1:FormatText(StoryNameCfg[640].name)

				arg_299_1.leftNameTxt_.text = var_302_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_299_1.leftNameTxt_.transform)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1.leftNameTxt_.text)
				SetActive(arg_299_1.iconTrs_.gameObject, false)
				arg_299_1.callingController_:SetSelectedState("normal")

				local var_302_15 = arg_299_1:GetWordFromCfg(318161074)
				local var_302_16 = arg_299_1:FormatText(var_302_15.content)

				arg_299_1.text_.text = var_302_16

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_17 = 7
				local var_302_18 = utf8.len(var_302_16)
				local var_302_19 = var_302_17 <= 0 and var_302_13 or var_302_13 * (var_302_18 / var_302_17)

				if var_302_19 > 0 and var_302_13 < var_302_19 then
					arg_299_1.talkMaxDuration = var_302_19

					if var_302_19 + var_302_12 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_19 + var_302_12
					end
				end

				arg_299_1.text_.text = var_302_16
				arg_299_1.typewritter.percent = 0

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318161", "318161074", "story_v_out_318161.awb") ~= 0 then
					local var_302_20 = manager.audio:GetVoiceLength("story_v_out_318161", "318161074", "story_v_out_318161.awb") / 1000

					if var_302_20 + var_302_12 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_20 + var_302_12
					end

					if var_302_15.prefab_name ~= "" and arg_299_1.actors_[var_302_15.prefab_name] ~= nil then
						local var_302_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_299_1.actors_[var_302_15.prefab_name].transform, "story_v_out_318161", "318161074", "story_v_out_318161.awb")

						arg_299_1:RecordAudio("318161074", var_302_21)
						arg_299_1:RecordAudio("318161074", var_302_21)
					else
						arg_299_1:AudioAction("play", "voice", "story_v_out_318161", "318161074", "story_v_out_318161.awb")
					end

					arg_299_1:RecordHistoryTalkVoice("story_v_out_318161", "318161074", "story_v_out_318161.awb")
				end

				arg_299_1:RecordContent(arg_299_1.text_.text)
			end

			local var_302_22 = math.max(var_302_13, arg_299_1.talkMaxDuration)

			if var_302_12 <= arg_299_1.time_ and arg_299_1.time_ < var_302_12 + var_302_22 then
				arg_299_1.typewritter.percent = (arg_299_1.time_ - var_302_12) / var_302_22

				arg_299_1.typewritter:SetDirty()
			end

			if arg_299_1.time_ >= var_302_12 + var_302_22 and arg_299_1.time_ < var_302_12 + var_302_22 + arg_302_0 then
				arg_299_1.typewritter.percent = 1

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(true)
			end
		end

		arg_299_1.nodeConfigList_ = {}

		arg_299_1:InitPlayNodeList()
	end,
	Play318161075 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 318161075
		arg_303_1.duration_ = 5

		SetActive(arg_303_1.tipsGo_, false)

		function arg_303_1.onSingleLineFinish_()
			arg_303_1.onSingleLineUpdate_ = nil
			arg_303_1.onSingleLineFinish_ = nil
			arg_303_1.state_ = "waiting"
			arg_303_1.auto_ = false
		end

		function arg_303_1.playNext_(arg_305_0)
			arg_303_1.onStoryFinished_()
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			local var_306_0 = arg_303_1.actors_["10066ui_story"]
			local var_306_1 = 0

			if var_306_1 < arg_303_1.time_ and arg_303_1.time_ <= var_306_1 + arg_306_0 and not isNil(var_306_0) and arg_303_1.var_.characterEffect10066ui_story == nil then
				arg_303_1.var_.characterEffect10066ui_story = var_306_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_306_2 = 0.200000002980232

			if var_306_1 <= arg_303_1.time_ and arg_303_1.time_ < var_306_1 + var_306_2 and not isNil(var_306_0) then
				local var_306_3 = (arg_303_1.time_ - var_306_1) / var_306_2

				if arg_303_1.var_.characterEffect10066ui_story and not isNil(var_306_0) then
					local var_306_4 = Mathf.Lerp(0, 0.5, var_306_3)

					arg_303_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_303_1.var_.characterEffect10066ui_story.fillRatio = var_306_4
				end
			end

			if arg_303_1.time_ >= var_306_1 + var_306_2 and arg_303_1.time_ < var_306_1 + var_306_2 + arg_306_0 and not isNil(var_306_0) and arg_303_1.var_.characterEffect10066ui_story then
				local var_306_5 = 0.5

				arg_303_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_303_1.var_.characterEffect10066ui_story.fillRatio = var_306_5
			end

			local var_306_6 = 0
			local var_306_7 = 0.225

			if var_306_6 < arg_303_1.time_ and arg_303_1.time_ <= var_306_6 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, true)

				local var_306_8 = arg_303_1:FormatText(StoryNameCfg[7].name)

				arg_303_1.leftNameTxt_.text = var_306_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_303_1.leftNameTxt_.transform)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1.leftNameTxt_.text)
				SetActive(arg_303_1.iconTrs_.gameObject, true)
				arg_303_1.iconController_:SetSelectedState("hero")

				arg_303_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_303_1.callingController_:SetSelectedState("normal")

				arg_303_1.keyicon_.color = Color.New(1, 1, 1)
				arg_303_1.icon_.color = Color.New(1, 1, 1)

				local var_306_9 = arg_303_1:GetWordFromCfg(318161075)
				local var_306_10 = arg_303_1:FormatText(var_306_9.content)

				arg_303_1.text_.text = var_306_10

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_11 = 9
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
				arg_303_1:RecordContent(arg_303_1.text_.text)
			end

			local var_306_14 = math.max(var_306_7, arg_303_1.talkMaxDuration)

			if var_306_6 <= arg_303_1.time_ and arg_303_1.time_ < var_306_6 + var_306_14 then
				arg_303_1.typewritter.percent = (arg_303_1.time_ - var_306_6) / var_306_14

				arg_303_1.typewritter:SetDirty()
			end

			if arg_303_1.time_ >= var_306_6 + var_306_14 and arg_303_1.time_ < var_306_6 + var_306_14 + arg_306_0 then
				arg_303_1.typewritter.percent = 1

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(true)
			end
		end

		arg_303_1.nodeConfigList_ = {}

		arg_303_1:InitPlayNodeList()
	end,
	Play318161064 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 318161064
		arg_307_1.duration_ = 5

		SetActive(arg_307_1.tipsGo_, false)

		function arg_307_1.onSingleLineFinish_()
			arg_307_1.onSingleLineUpdate_ = nil
			arg_307_1.onSingleLineFinish_ = nil
			arg_307_1.state_ = "waiting"
		end

		function arg_307_1.playNext_(arg_309_0)
			if arg_309_0 == 1 then
				arg_307_0:Play318161065(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			local var_310_0 = 0
			local var_310_1 = 0.45

			if var_310_0 < arg_307_1.time_ and arg_307_1.time_ <= var_310_0 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0
				arg_307_1.dialogCg_.alpha = 1

				arg_307_1.dialog_:SetActive(true)
				SetActive(arg_307_1.leftNameGo_, true)

				local var_310_2 = arg_307_1:FormatText(StoryNameCfg[7].name)

				arg_307_1.leftNameTxt_.text = var_310_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_307_1.leftNameTxt_.transform)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1.leftNameTxt_.text)
				SetActive(arg_307_1.iconTrs_.gameObject, true)
				arg_307_1.iconController_:SetSelectedState("hero")

				arg_307_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_307_1.callingController_:SetSelectedState("normal")

				arg_307_1.keyicon_.color = Color.New(1, 1, 1)
				arg_307_1.icon_.color = Color.New(1, 1, 1)

				local var_310_3 = arg_307_1:GetWordFromCfg(318161064)
				local var_310_4 = arg_307_1:FormatText(var_310_3.content)

				arg_307_1.text_.text = var_310_4

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_5 = 18
				local var_310_6 = utf8.len(var_310_4)
				local var_310_7 = var_310_5 <= 0 and var_310_1 or var_310_1 * (var_310_6 / var_310_5)

				if var_310_7 > 0 and var_310_1 < var_310_7 then
					arg_307_1.talkMaxDuration = var_310_7

					if var_310_7 + var_310_0 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_7 + var_310_0
					end
				end

				arg_307_1.text_.text = var_310_4
				arg_307_1.typewritter.percent = 0

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(false)
				arg_307_1:RecordContent(arg_307_1.text_.text)
			end

			local var_310_8 = math.max(var_310_1, arg_307_1.talkMaxDuration)

			if var_310_0 <= arg_307_1.time_ and arg_307_1.time_ < var_310_0 + var_310_8 then
				arg_307_1.typewritter.percent = (arg_307_1.time_ - var_310_0) / var_310_8

				arg_307_1.typewritter:SetDirty()
			end

			if arg_307_1.time_ >= var_310_0 + var_310_8 and arg_307_1.time_ < var_310_0 + var_310_8 + arg_310_0 then
				arg_307_1.typewritter.percent = 1

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(true)
			end
		end

		arg_307_1.nodeConfigList_ = {}

		arg_307_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/A00",
		"TextureConfig/Background/ST12",
		"TextureConfig/Background/K16f"
	},
	voices = {
		"story_v_out_318161.awb"
	}
}
