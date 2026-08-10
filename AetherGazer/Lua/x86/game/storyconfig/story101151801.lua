return {
	Play115181001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 115181001
		arg_1_1.duration_ = 5

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play115181002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "G02b"

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
				local var_4_5 = arg_1_1.bgs_.G02b

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
					if iter_4_0 ~= "G02b" then
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
			local var_4_23 = 0.333333333333333

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

			local var_4_28 = 0.433333333333333
			local var_4_29 = 0.566666666666667

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				local var_4_30 = "play"
				local var_4_31 = "music"

				arg_1_1:AudioAction(var_4_30, var_4_31, "bgm_activity_1_5_story_2", "bgm_activity_1_5_story_2", "bgm_activity_1_5_story_2.awb")

				local var_4_32 = ""
				local var_4_33 = manager.audio:GetAudioName("bgm_activity_1_5_story_2", "bgm_activity_1_5_story_2")

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

			local var_4_34 = 0
			local var_4_35 = 0.725

			if var_4_34 < arg_1_1.time_ and arg_1_1.time_ <= var_4_34 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0
				arg_1_1.dialogCg_.alpha = 1

				arg_1_1.dialog_:SetActive(true)
				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_36 = arg_1_1:GetWordFromCfg(115181001)
				local var_4_37 = arg_1_1:FormatText(var_4_36.content)

				arg_1_1.text_.text = var_4_37

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_38 = 29
				local var_4_39 = utf8.len(var_4_37)
				local var_4_40 = var_4_38 <= 0 and var_4_35 or var_4_35 * (var_4_39 / var_4_38)

				if var_4_40 > 0 and var_4_35 < var_4_40 then
					arg_1_1.talkMaxDuration = var_4_40

					if var_4_40 + var_4_34 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_40 + var_4_34
					end
				end

				arg_1_1.text_.text = var_4_37
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_41 = math.max(var_4_35, arg_1_1.talkMaxDuration)

			if var_4_34 <= arg_1_1.time_ and arg_1_1.time_ < var_4_34 + var_4_41 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_34) / var_4_41

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_34 + var_4_41 and arg_1_1.time_ < var_4_34 + var_4_41 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play115181002 = function(arg_7_0, arg_7_1)
		arg_7_1.time_ = 0
		arg_7_1.frameCnt_ = 0
		arg_7_1.state_ = "playing"
		arg_7_1.curTalkId_ = 115181002
		arg_7_1.duration_ = 4.53

		local var_7_0 = {
			ja = 4.533,
			ko = 2.833,
			zh = 1.966,
			en = 2.566
		}
		local var_7_1 = manager.audio:GetLocalizationFlag()

		if var_7_0[var_7_1] ~= nil then
			arg_7_1.duration_ = var_7_0[var_7_1]
		end

		SetActive(arg_7_1.tipsGo_, false)

		function arg_7_1.onSingleLineFinish_()
			arg_7_1.onSingleLineUpdate_ = nil
			arg_7_1.onSingleLineFinish_ = nil
			arg_7_1.state_ = "waiting"
		end

		function arg_7_1.playNext_(arg_9_0)
			if arg_9_0 == 1 then
				arg_7_0:Play115181003(arg_7_1)
			end
		end

		function arg_7_1.onSingleLineUpdate_(arg_10_0)
			local var_10_0 = 0
			local var_10_1 = 0.2

			if var_10_0 < arg_7_1.time_ and arg_7_1.time_ <= var_10_0 + arg_10_0 then
				arg_7_1.talkMaxDuration = 0
				arg_7_1.dialogCg_.alpha = 1

				arg_7_1.dialog_:SetActive(true)
				SetActive(arg_7_1.leftNameGo_, true)

				local var_10_2 = arg_7_1:FormatText(StoryNameCfg[273].name)

				arg_7_1.leftNameTxt_.text = var_10_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_7_1.leftNameTxt_.transform)

				arg_7_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_7_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_7_1:RecordName(arg_7_1.leftNameTxt_.text)
				SetActive(arg_7_1.iconTrs_.gameObject, true)
				arg_7_1.iconController_:SetSelectedState("hero")

				arg_7_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1017")

				arg_7_1.callingController_:SetSelectedState("normal")

				arg_7_1.keyicon_.color = Color.New(1, 1, 1)
				arg_7_1.icon_.color = Color.New(1, 1, 1)

				local var_10_3 = arg_7_1:GetWordFromCfg(115181002)
				local var_10_4 = arg_7_1:FormatText(var_10_3.content)

				arg_7_1.text_.text = var_10_4

				LuaForUtil.ClearLinePrefixSymbol(arg_7_1.text_)

				local var_10_5 = 8
				local var_10_6 = utf8.len(var_10_4)
				local var_10_7 = var_10_5 <= 0 and var_10_1 or var_10_1 * (var_10_6 / var_10_5)

				if var_10_7 > 0 and var_10_1 < var_10_7 then
					arg_7_1.talkMaxDuration = var_10_7

					if var_10_7 + var_10_0 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_7 + var_10_0
					end
				end

				arg_7_1.text_.text = var_10_4
				arg_7_1.typewritter.percent = 0

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115181", "115181002", "story_v_out_115181.awb") ~= 0 then
					local var_10_8 = manager.audio:GetVoiceLength("story_v_out_115181", "115181002", "story_v_out_115181.awb") / 1000

					if var_10_8 + var_10_0 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_8 + var_10_0
					end

					if var_10_3.prefab_name ~= "" and arg_7_1.actors_[var_10_3.prefab_name] ~= nil then
						local var_10_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_7_1.actors_[var_10_3.prefab_name].transform, "story_v_out_115181", "115181002", "story_v_out_115181.awb")

						arg_7_1:RecordAudio("115181002", var_10_9)
						arg_7_1:RecordAudio("115181002", var_10_9)
					else
						arg_7_1:AudioAction("play", "voice", "story_v_out_115181", "115181002", "story_v_out_115181.awb")
					end

					arg_7_1:RecordHistoryTalkVoice("story_v_out_115181", "115181002", "story_v_out_115181.awb")
				end

				arg_7_1:RecordContent(arg_7_1.text_.text)
			end

			local var_10_10 = math.max(var_10_1, arg_7_1.talkMaxDuration)

			if var_10_0 <= arg_7_1.time_ and arg_7_1.time_ < var_10_0 + var_10_10 then
				arg_7_1.typewritter.percent = (arg_7_1.time_ - var_10_0) / var_10_10

				arg_7_1.typewritter:SetDirty()
			end

			if arg_7_1.time_ >= var_10_0 + var_10_10 and arg_7_1.time_ < var_10_0 + var_10_10 + arg_10_0 then
				arg_7_1.typewritter.percent = 1

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(true)
			end
		end

		arg_7_1.nodeConfigList_ = {}

		arg_7_1:InitPlayNodeList()
	end,
	Play115181003 = function(arg_11_0, arg_11_1)
		arg_11_1.time_ = 0
		arg_11_1.frameCnt_ = 0
		arg_11_1.state_ = "playing"
		arg_11_1.curTalkId_ = 115181003
		arg_11_1.duration_ = 2

		local var_11_0 = {
			ja = 1.999999999999,
			ko = 1.999999999999,
			zh = 2,
			en = 1.999999999999
		}
		local var_11_1 = manager.audio:GetLocalizationFlag()

		if var_11_0[var_11_1] ~= nil then
			arg_11_1.duration_ = var_11_0[var_11_1]
		end

		SetActive(arg_11_1.tipsGo_, false)

		function arg_11_1.onSingleLineFinish_()
			arg_11_1.onSingleLineUpdate_ = nil
			arg_11_1.onSingleLineFinish_ = nil
			arg_11_1.state_ = "waiting"
		end

		function arg_11_1.playNext_(arg_13_0)
			if arg_13_0 == 1 then
				arg_11_0:Play115181004(arg_11_1)
			end
		end

		function arg_11_1.onSingleLineUpdate_(arg_14_0)
			local var_14_0 = "1024ui_story"

			if arg_11_1.actors_[var_14_0] == nil then
				local var_14_1 = Asset.Load("Char/" .. "1024ui_story")

				if not isNil(var_14_1) then
					local var_14_2 = Object.Instantiate(Asset.Load("Char/" .. "1024ui_story"), arg_11_1.stage_.transform)

					var_14_2.name = var_14_0
					var_14_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_11_1.actors_[var_14_0] = var_14_2

					local var_14_3 = var_14_2:GetComponentInChildren(typeof(CharacterEffect))

					var_14_3.enabled = true

					local var_14_4 = GameObjectTools.GetOrAddComponent(var_14_2, typeof(DynamicBoneHelper))

					if var_14_4 then
						var_14_4:EnableDynamicBone(false)
					end

					arg_11_1:ShowWeapon(var_14_3.transform, false)

					arg_11_1.var_[var_14_0 .. "Animator"] = var_14_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_11_1.var_[var_14_0 .. "Animator"].applyRootMotion = true
					arg_11_1.var_[var_14_0 .. "LipSync"] = var_14_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_14_5 = arg_11_1.actors_["1024ui_story"].transform
			local var_14_6 = 0

			if var_14_6 < arg_11_1.time_ and arg_11_1.time_ <= var_14_6 + arg_14_0 then
				arg_11_1.var_.moveOldPos1024ui_story = var_14_5.localPosition
			end

			local var_14_7 = 0.001

			if var_14_6 <= arg_11_1.time_ and arg_11_1.time_ < var_14_6 + var_14_7 then
				local var_14_8 = (arg_11_1.time_ - var_14_6) / var_14_7
				local var_14_9 = Vector3.New(-0.7, -1, -6.05)

				var_14_5.localPosition = Vector3.Lerp(arg_11_1.var_.moveOldPos1024ui_story, var_14_9, var_14_8)

				local var_14_10 = manager.ui.mainCamera.transform.position - var_14_5.position

				var_14_5.forward = Vector3.New(var_14_10.x, var_14_10.y, var_14_10.z)

				local var_14_11 = var_14_5.localEulerAngles

				var_14_11.z = 0
				var_14_11.x = 0
				var_14_5.localEulerAngles = var_14_11
			end

			if arg_11_1.time_ >= var_14_6 + var_14_7 and arg_11_1.time_ < var_14_6 + var_14_7 + arg_14_0 then
				var_14_5.localPosition = Vector3.New(-0.7, -1, -6.05)

				local var_14_12 = manager.ui.mainCamera.transform.position - var_14_5.position

				var_14_5.forward = Vector3.New(var_14_12.x, var_14_12.y, var_14_12.z)

				local var_14_13 = var_14_5.localEulerAngles

				var_14_13.z = 0
				var_14_13.x = 0
				var_14_5.localEulerAngles = var_14_13
			end

			local var_14_14 = 0

			if var_14_14 < arg_11_1.time_ and arg_11_1.time_ <= var_14_14 + arg_14_0 then
				arg_11_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/story1024/story1024action/1024action1_1")
			end

			local var_14_15 = 0

			if var_14_15 < arg_11_1.time_ and arg_11_1.time_ <= var_14_15 + arg_14_0 then
				arg_11_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_14_16 = arg_11_1.actors_["1024ui_story"]
			local var_14_17 = 0

			if var_14_17 < arg_11_1.time_ and arg_11_1.time_ <= var_14_17 + arg_14_0 and not isNil(var_14_16) and arg_11_1.var_.characterEffect1024ui_story == nil then
				arg_11_1.var_.characterEffect1024ui_story = var_14_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_14_18 = 0.2

			if var_14_17 <= arg_11_1.time_ and arg_11_1.time_ < var_14_17 + var_14_18 and not isNil(var_14_16) then
				local var_14_19 = (arg_11_1.time_ - var_14_17) / var_14_18

				if arg_11_1.var_.characterEffect1024ui_story and not isNil(var_14_16) then
					arg_11_1.var_.characterEffect1024ui_story.fillFlat = false
				end
			end

			if arg_11_1.time_ >= var_14_17 + var_14_18 and arg_11_1.time_ < var_14_17 + var_14_18 + arg_14_0 and not isNil(var_14_16) and arg_11_1.var_.characterEffect1024ui_story then
				arg_11_1.var_.characterEffect1024ui_story.fillFlat = false
			end

			local var_14_20 = 0
			local var_14_21 = 0.15

			if var_14_20 < arg_11_1.time_ and arg_11_1.time_ <= var_14_20 + arg_14_0 then
				arg_11_1.talkMaxDuration = 0
				arg_11_1.dialogCg_.alpha = 1

				arg_11_1.dialog_:SetActive(true)
				SetActive(arg_11_1.leftNameGo_, true)

				local var_14_22 = arg_11_1:FormatText(StoryNameCfg[265].name)

				arg_11_1.leftNameTxt_.text = var_14_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_11_1.leftNameTxt_.transform)

				arg_11_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_11_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_11_1:RecordName(arg_11_1.leftNameTxt_.text)
				SetActive(arg_11_1.iconTrs_.gameObject, false)
				arg_11_1.callingController_:SetSelectedState("normal")

				local var_14_23 = arg_11_1:GetWordFromCfg(115181003)
				local var_14_24 = arg_11_1:FormatText(var_14_23.content)

				arg_11_1.text_.text = var_14_24

				LuaForUtil.ClearLinePrefixSymbol(arg_11_1.text_)

				local var_14_25 = 5
				local var_14_26 = utf8.len(var_14_24)
				local var_14_27 = var_14_25 <= 0 and var_14_21 or var_14_21 * (var_14_26 / var_14_25)

				if var_14_27 > 0 and var_14_21 < var_14_27 then
					arg_11_1.talkMaxDuration = var_14_27

					if var_14_27 + var_14_20 > arg_11_1.duration_ then
						arg_11_1.duration_ = var_14_27 + var_14_20
					end
				end

				arg_11_1.text_.text = var_14_24
				arg_11_1.typewritter.percent = 0

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115181", "115181003", "story_v_out_115181.awb") ~= 0 then
					local var_14_28 = manager.audio:GetVoiceLength("story_v_out_115181", "115181003", "story_v_out_115181.awb") / 1000

					if var_14_28 + var_14_20 > arg_11_1.duration_ then
						arg_11_1.duration_ = var_14_28 + var_14_20
					end

					if var_14_23.prefab_name ~= "" and arg_11_1.actors_[var_14_23.prefab_name] ~= nil then
						local var_14_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_11_1.actors_[var_14_23.prefab_name].transform, "story_v_out_115181", "115181003", "story_v_out_115181.awb")

						arg_11_1:RecordAudio("115181003", var_14_29)
						arg_11_1:RecordAudio("115181003", var_14_29)
					else
						arg_11_1:AudioAction("play", "voice", "story_v_out_115181", "115181003", "story_v_out_115181.awb")
					end

					arg_11_1:RecordHistoryTalkVoice("story_v_out_115181", "115181003", "story_v_out_115181.awb")
				end

				arg_11_1:RecordContent(arg_11_1.text_.text)
			end

			local var_14_30 = math.max(var_14_21, arg_11_1.talkMaxDuration)

			if var_14_20 <= arg_11_1.time_ and arg_11_1.time_ < var_14_20 + var_14_30 then
				arg_11_1.typewritter.percent = (arg_11_1.time_ - var_14_20) / var_14_30

				arg_11_1.typewritter:SetDirty()
			end

			if arg_11_1.time_ >= var_14_20 + var_14_30 and arg_11_1.time_ < var_14_20 + var_14_30 + arg_14_0 then
				arg_11_1.typewritter.percent = 1

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(true)
			end
		end

		arg_11_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_11_1:InitPlayNodeList()
	end,
	Play115181004 = function(arg_15_0, arg_15_1)
		arg_15_1.time_ = 0
		arg_15_1.frameCnt_ = 0
		arg_15_1.state_ = "playing"
		arg_15_1.curTalkId_ = 115181004
		arg_15_1.duration_ = 7.77

		local var_15_0 = {
			ja = 5.7,
			ko = 7.766,
			zh = 6.9,
			en = 6.9
		}
		local var_15_1 = manager.audio:GetLocalizationFlag()

		if var_15_0[var_15_1] ~= nil then
			arg_15_1.duration_ = var_15_0[var_15_1]
		end

		SetActive(arg_15_1.tipsGo_, false)

		function arg_15_1.onSingleLineFinish_()
			arg_15_1.onSingleLineUpdate_ = nil
			arg_15_1.onSingleLineFinish_ = nil
			arg_15_1.state_ = "waiting"
		end

		function arg_15_1.playNext_(arg_17_0)
			if arg_17_0 == 1 then
				arg_15_0:Play115181005(arg_15_1)
			end
		end

		function arg_15_1.onSingleLineUpdate_(arg_18_0)
			local var_18_0 = "1017ui_story"

			if arg_15_1.actors_[var_18_0] == nil then
				local var_18_1 = Asset.Load("Char/" .. "1017ui_story")

				if not isNil(var_18_1) then
					local var_18_2 = Object.Instantiate(Asset.Load("Char/" .. "1017ui_story"), arg_15_1.stage_.transform)

					var_18_2.name = var_18_0
					var_18_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_15_1.actors_[var_18_0] = var_18_2

					local var_18_3 = var_18_2:GetComponentInChildren(typeof(CharacterEffect))

					var_18_3.enabled = true

					local var_18_4 = GameObjectTools.GetOrAddComponent(var_18_2, typeof(DynamicBoneHelper))

					if var_18_4 then
						var_18_4:EnableDynamicBone(false)
					end

					arg_15_1:ShowWeapon(var_18_3.transform, false)

					arg_15_1.var_[var_18_0 .. "Animator"] = var_18_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_15_1.var_[var_18_0 .. "Animator"].applyRootMotion = true
					arg_15_1.var_[var_18_0 .. "LipSync"] = var_18_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_18_5 = arg_15_1.actors_["1017ui_story"].transform
			local var_18_6 = 0

			if var_18_6 < arg_15_1.time_ and arg_15_1.time_ <= var_18_6 + arg_18_0 then
				arg_15_1.var_.moveOldPos1017ui_story = var_18_5.localPosition
			end

			local var_18_7 = 0.001

			if var_18_6 <= arg_15_1.time_ and arg_15_1.time_ < var_18_6 + var_18_7 then
				local var_18_8 = (arg_15_1.time_ - var_18_6) / var_18_7
				local var_18_9 = Vector3.New(0.7, -1.01, -6.05)

				var_18_5.localPosition = Vector3.Lerp(arg_15_1.var_.moveOldPos1017ui_story, var_18_9, var_18_8)

				local var_18_10 = manager.ui.mainCamera.transform.position - var_18_5.position

				var_18_5.forward = Vector3.New(var_18_10.x, var_18_10.y, var_18_10.z)

				local var_18_11 = var_18_5.localEulerAngles

				var_18_11.z = 0
				var_18_11.x = 0
				var_18_5.localEulerAngles = var_18_11
			end

			if arg_15_1.time_ >= var_18_6 + var_18_7 and arg_15_1.time_ < var_18_6 + var_18_7 + arg_18_0 then
				var_18_5.localPosition = Vector3.New(0.7, -1.01, -6.05)

				local var_18_12 = manager.ui.mainCamera.transform.position - var_18_5.position

				var_18_5.forward = Vector3.New(var_18_12.x, var_18_12.y, var_18_12.z)

				local var_18_13 = var_18_5.localEulerAngles

				var_18_13.z = 0
				var_18_13.x = 0
				var_18_5.localEulerAngles = var_18_13
			end

			local var_18_14 = 0

			if var_18_14 < arg_15_1.time_ and arg_15_1.time_ <= var_18_14 + arg_18_0 then
				arg_15_1:PlayTimeline("1017ui_story", "StoryTimeline/CharAction/story1017/story1017action/1017action3_1")
			end

			local var_18_15 = arg_15_1.actors_["1024ui_story"]
			local var_18_16 = 0

			if var_18_16 < arg_15_1.time_ and arg_15_1.time_ <= var_18_16 + arg_18_0 and not isNil(var_18_15) and arg_15_1.var_.characterEffect1024ui_story == nil then
				arg_15_1.var_.characterEffect1024ui_story = var_18_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_18_17 = 0.2

			if var_18_16 <= arg_15_1.time_ and arg_15_1.time_ < var_18_16 + var_18_17 and not isNil(var_18_15) then
				local var_18_18 = (arg_15_1.time_ - var_18_16) / var_18_17

				if arg_15_1.var_.characterEffect1024ui_story and not isNil(var_18_15) then
					local var_18_19 = Mathf.Lerp(0, 0.5, var_18_18)

					arg_15_1.var_.characterEffect1024ui_story.fillFlat = true
					arg_15_1.var_.characterEffect1024ui_story.fillRatio = var_18_19
				end
			end

			if arg_15_1.time_ >= var_18_16 + var_18_17 and arg_15_1.time_ < var_18_16 + var_18_17 + arg_18_0 and not isNil(var_18_15) and arg_15_1.var_.characterEffect1024ui_story then
				local var_18_20 = 0.5

				arg_15_1.var_.characterEffect1024ui_story.fillFlat = true
				arg_15_1.var_.characterEffect1024ui_story.fillRatio = var_18_20
			end

			local var_18_21 = 0

			if var_18_21 < arg_15_1.time_ and arg_15_1.time_ <= var_18_21 + arg_18_0 then
				arg_15_1:PlayTimeline("1017ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_18_22 = arg_15_1.actors_["1017ui_story"]
			local var_18_23 = 0

			if var_18_23 < arg_15_1.time_ and arg_15_1.time_ <= var_18_23 + arg_18_0 and not isNil(var_18_22) and arg_15_1.var_.characterEffect1017ui_story == nil then
				arg_15_1.var_.characterEffect1017ui_story = var_18_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_18_24 = 0.2

			if var_18_23 <= arg_15_1.time_ and arg_15_1.time_ < var_18_23 + var_18_24 and not isNil(var_18_22) then
				local var_18_25 = (arg_15_1.time_ - var_18_23) / var_18_24

				if arg_15_1.var_.characterEffect1017ui_story and not isNil(var_18_22) then
					arg_15_1.var_.characterEffect1017ui_story.fillFlat = false
				end
			end

			if arg_15_1.time_ >= var_18_23 + var_18_24 and arg_15_1.time_ < var_18_23 + var_18_24 + arg_18_0 and not isNil(var_18_22) and arg_15_1.var_.characterEffect1017ui_story then
				arg_15_1.var_.characterEffect1017ui_story.fillFlat = false
			end

			local var_18_26 = 0
			local var_18_27 = 0.8

			if var_18_26 < arg_15_1.time_ and arg_15_1.time_ <= var_18_26 + arg_18_0 then
				arg_15_1.talkMaxDuration = 0
				arg_15_1.dialogCg_.alpha = 1

				arg_15_1.dialog_:SetActive(true)
				SetActive(arg_15_1.leftNameGo_, true)

				local var_18_28 = arg_15_1:FormatText(StoryNameCfg[273].name)

				arg_15_1.leftNameTxt_.text = var_18_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_15_1.leftNameTxt_.transform)

				arg_15_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_15_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_15_1:RecordName(arg_15_1.leftNameTxt_.text)
				SetActive(arg_15_1.iconTrs_.gameObject, false)
				arg_15_1.callingController_:SetSelectedState("normal")

				local var_18_29 = arg_15_1:GetWordFromCfg(115181004)
				local var_18_30 = arg_15_1:FormatText(var_18_29.content)

				arg_15_1.text_.text = var_18_30

				LuaForUtil.ClearLinePrefixSymbol(arg_15_1.text_)

				local var_18_31 = 32
				local var_18_32 = utf8.len(var_18_30)
				local var_18_33 = var_18_31 <= 0 and var_18_27 or var_18_27 * (var_18_32 / var_18_31)

				if var_18_33 > 0 and var_18_27 < var_18_33 then
					arg_15_1.talkMaxDuration = var_18_33

					if var_18_33 + var_18_26 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_33 + var_18_26
					end
				end

				arg_15_1.text_.text = var_18_30
				arg_15_1.typewritter.percent = 0

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115181", "115181004", "story_v_out_115181.awb") ~= 0 then
					local var_18_34 = manager.audio:GetVoiceLength("story_v_out_115181", "115181004", "story_v_out_115181.awb") / 1000

					if var_18_34 + var_18_26 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_34 + var_18_26
					end

					if var_18_29.prefab_name ~= "" and arg_15_1.actors_[var_18_29.prefab_name] ~= nil then
						local var_18_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_15_1.actors_[var_18_29.prefab_name].transform, "story_v_out_115181", "115181004", "story_v_out_115181.awb")

						arg_15_1:RecordAudio("115181004", var_18_35)
						arg_15_1:RecordAudio("115181004", var_18_35)
					else
						arg_15_1:AudioAction("play", "voice", "story_v_out_115181", "115181004", "story_v_out_115181.awb")
					end

					arg_15_1:RecordHistoryTalkVoice("story_v_out_115181", "115181004", "story_v_out_115181.awb")
				end

				arg_15_1:RecordContent(arg_15_1.text_.text)
			end

			local var_18_36 = math.max(var_18_27, arg_15_1.talkMaxDuration)

			if var_18_26 <= arg_15_1.time_ and arg_15_1.time_ < var_18_26 + var_18_36 then
				arg_15_1.typewritter.percent = (arg_15_1.time_ - var_18_26) / var_18_36

				arg_15_1.typewritter:SetDirty()
			end

			if arg_15_1.time_ >= var_18_26 + var_18_36 and arg_15_1.time_ < var_18_26 + var_18_36 + arg_18_0 then
				arg_15_1.typewritter.percent = 1

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(true)
			end
		end

		arg_15_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1017ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_15_1:InitPlayNodeList()
	end,
	Play115181005 = function(arg_19_0, arg_19_1)
		arg_19_1.time_ = 0
		arg_19_1.frameCnt_ = 0
		arg_19_1.state_ = "playing"
		arg_19_1.curTalkId_ = 115181005
		arg_19_1.duration_ = 2.17

		local var_19_0 = {
			ja = 2.166,
			ko = 1.999999999999,
			zh = 1.999999999999,
			en = 1.999999999999
		}
		local var_19_1 = manager.audio:GetLocalizationFlag()

		if var_19_0[var_19_1] ~= nil then
			arg_19_1.duration_ = var_19_0[var_19_1]
		end

		SetActive(arg_19_1.tipsGo_, false)

		function arg_19_1.onSingleLineFinish_()
			arg_19_1.onSingleLineUpdate_ = nil
			arg_19_1.onSingleLineFinish_ = nil
			arg_19_1.state_ = "waiting"
		end

		function arg_19_1.playNext_(arg_21_0)
			if arg_21_0 == 1 then
				arg_19_0:Play115181006(arg_19_1)
			end
		end

		function arg_19_1.onSingleLineUpdate_(arg_22_0)
			local var_22_0 = arg_19_1.actors_["1017ui_story"]
			local var_22_1 = 0

			if var_22_1 < arg_19_1.time_ and arg_19_1.time_ <= var_22_1 + arg_22_0 and not isNil(var_22_0) and arg_19_1.var_.characterEffect1017ui_story == nil then
				arg_19_1.var_.characterEffect1017ui_story = var_22_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_22_2 = 0.2

			if var_22_1 <= arg_19_1.time_ and arg_19_1.time_ < var_22_1 + var_22_2 and not isNil(var_22_0) then
				local var_22_3 = (arg_19_1.time_ - var_22_1) / var_22_2

				if arg_19_1.var_.characterEffect1017ui_story and not isNil(var_22_0) then
					local var_22_4 = Mathf.Lerp(0, 0.5, var_22_3)

					arg_19_1.var_.characterEffect1017ui_story.fillFlat = true
					arg_19_1.var_.characterEffect1017ui_story.fillRatio = var_22_4
				end
			end

			if arg_19_1.time_ >= var_22_1 + var_22_2 and arg_19_1.time_ < var_22_1 + var_22_2 + arg_22_0 and not isNil(var_22_0) and arg_19_1.var_.characterEffect1017ui_story then
				local var_22_5 = 0.5

				arg_19_1.var_.characterEffect1017ui_story.fillFlat = true
				arg_19_1.var_.characterEffect1017ui_story.fillRatio = var_22_5
			end

			local var_22_6 = arg_19_1.actors_["1024ui_story"]
			local var_22_7 = 0

			if var_22_7 < arg_19_1.time_ and arg_19_1.time_ <= var_22_7 + arg_22_0 and not isNil(var_22_6) and arg_19_1.var_.characterEffect1024ui_story == nil then
				arg_19_1.var_.characterEffect1024ui_story = var_22_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_22_8 = 0.2

			if var_22_7 <= arg_19_1.time_ and arg_19_1.time_ < var_22_7 + var_22_8 and not isNil(var_22_6) then
				local var_22_9 = (arg_19_1.time_ - var_22_7) / var_22_8

				if arg_19_1.var_.characterEffect1024ui_story and not isNil(var_22_6) then
					arg_19_1.var_.characterEffect1024ui_story.fillFlat = false
				end
			end

			if arg_19_1.time_ >= var_22_7 + var_22_8 and arg_19_1.time_ < var_22_7 + var_22_8 + arg_22_0 and not isNil(var_22_6) and arg_19_1.var_.characterEffect1024ui_story then
				arg_19_1.var_.characterEffect1024ui_story.fillFlat = false
			end

			local var_22_10 = 0

			if var_22_10 < arg_19_1.time_ and arg_19_1.time_ <= var_22_10 + arg_22_0 then
				arg_19_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_22_11 = 0
			local var_22_12 = 0.075

			if var_22_11 < arg_19_1.time_ and arg_19_1.time_ <= var_22_11 + arg_22_0 then
				arg_19_1.talkMaxDuration = 0
				arg_19_1.dialogCg_.alpha = 1

				arg_19_1.dialog_:SetActive(true)
				SetActive(arg_19_1.leftNameGo_, true)

				local var_22_13 = arg_19_1:FormatText(StoryNameCfg[265].name)

				arg_19_1.leftNameTxt_.text = var_22_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_19_1.leftNameTxt_.transform)

				arg_19_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_19_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_19_1:RecordName(arg_19_1.leftNameTxt_.text)
				SetActive(arg_19_1.iconTrs_.gameObject, false)
				arg_19_1.callingController_:SetSelectedState("normal")

				local var_22_14 = arg_19_1:GetWordFromCfg(115181005)
				local var_22_15 = arg_19_1:FormatText(var_22_14.content)

				arg_19_1.text_.text = var_22_15

				LuaForUtil.ClearLinePrefixSymbol(arg_19_1.text_)

				local var_22_16 = 3
				local var_22_17 = utf8.len(var_22_15)
				local var_22_18 = var_22_16 <= 0 and var_22_12 or var_22_12 * (var_22_17 / var_22_16)

				if var_22_18 > 0 and var_22_12 < var_22_18 then
					arg_19_1.talkMaxDuration = var_22_18

					if var_22_18 + var_22_11 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_18 + var_22_11
					end
				end

				arg_19_1.text_.text = var_22_15
				arg_19_1.typewritter.percent = 0

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115181", "115181005", "story_v_out_115181.awb") ~= 0 then
					local var_22_19 = manager.audio:GetVoiceLength("story_v_out_115181", "115181005", "story_v_out_115181.awb") / 1000

					if var_22_19 + var_22_11 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_19 + var_22_11
					end

					if var_22_14.prefab_name ~= "" and arg_19_1.actors_[var_22_14.prefab_name] ~= nil then
						local var_22_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_19_1.actors_[var_22_14.prefab_name].transform, "story_v_out_115181", "115181005", "story_v_out_115181.awb")

						arg_19_1:RecordAudio("115181005", var_22_20)
						arg_19_1:RecordAudio("115181005", var_22_20)
					else
						arg_19_1:AudioAction("play", "voice", "story_v_out_115181", "115181005", "story_v_out_115181.awb")
					end

					arg_19_1:RecordHistoryTalkVoice("story_v_out_115181", "115181005", "story_v_out_115181.awb")
				end

				arg_19_1:RecordContent(arg_19_1.text_.text)
			end

			local var_22_21 = math.max(var_22_12, arg_19_1.talkMaxDuration)

			if var_22_11 <= arg_19_1.time_ and arg_19_1.time_ < var_22_11 + var_22_21 then
				arg_19_1.typewritter.percent = (arg_19_1.time_ - var_22_11) / var_22_21

				arg_19_1.typewritter:SetDirty()
			end

			if arg_19_1.time_ >= var_22_11 + var_22_21 and arg_19_1.time_ < var_22_11 + var_22_21 + arg_22_0 then
				arg_19_1.typewritter.percent = 1

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(true)
			end
		end

		arg_19_1.nodeConfigList_ = {}

		arg_19_1:InitPlayNodeList()
	end,
	Play115181006 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 115181006
		arg_23_1.duration_ = 7.93

		local var_23_0 = {
			ja = 7.133,
			ko = 7.933,
			zh = 4.4,
			en = 6.233
		}
		local var_23_1 = manager.audio:GetLocalizationFlag()

		if var_23_0[var_23_1] ~= nil then
			arg_23_1.duration_ = var_23_0[var_23_1]
		end

		SetActive(arg_23_1.tipsGo_, false)

		function arg_23_1.onSingleLineFinish_()
			arg_23_1.onSingleLineUpdate_ = nil
			arg_23_1.onSingleLineFinish_ = nil
			arg_23_1.state_ = "waiting"
		end

		function arg_23_1.playNext_(arg_25_0)
			if arg_25_0 == 1 then
				arg_23_0:Play115181007(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			local var_26_0 = arg_23_1.actors_["1024ui_story"]
			local var_26_1 = 0

			if var_26_1 < arg_23_1.time_ and arg_23_1.time_ <= var_26_1 + arg_26_0 and not isNil(var_26_0) and arg_23_1.var_.characterEffect1024ui_story == nil then
				arg_23_1.var_.characterEffect1024ui_story = var_26_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_26_2 = 0.2

			if var_26_1 <= arg_23_1.time_ and arg_23_1.time_ < var_26_1 + var_26_2 and not isNil(var_26_0) then
				local var_26_3 = (arg_23_1.time_ - var_26_1) / var_26_2

				if arg_23_1.var_.characterEffect1024ui_story and not isNil(var_26_0) then
					local var_26_4 = Mathf.Lerp(0, 0.5, var_26_3)

					arg_23_1.var_.characterEffect1024ui_story.fillFlat = true
					arg_23_1.var_.characterEffect1024ui_story.fillRatio = var_26_4
				end
			end

			if arg_23_1.time_ >= var_26_1 + var_26_2 and arg_23_1.time_ < var_26_1 + var_26_2 + arg_26_0 and not isNil(var_26_0) and arg_23_1.var_.characterEffect1024ui_story then
				local var_26_5 = 0.5

				arg_23_1.var_.characterEffect1024ui_story.fillFlat = true
				arg_23_1.var_.characterEffect1024ui_story.fillRatio = var_26_5
			end

			local var_26_6 = 0

			if var_26_6 < arg_23_1.time_ and arg_23_1.time_ <= var_26_6 + arg_26_0 then
				arg_23_1:PlayTimeline("1017ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_26_7 = arg_23_1.actors_["1017ui_story"]
			local var_26_8 = 0

			if var_26_8 < arg_23_1.time_ and arg_23_1.time_ <= var_26_8 + arg_26_0 and not isNil(var_26_7) and arg_23_1.var_.characterEffect1017ui_story == nil then
				arg_23_1.var_.characterEffect1017ui_story = var_26_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_26_9 = 0.2

			if var_26_8 <= arg_23_1.time_ and arg_23_1.time_ < var_26_8 + var_26_9 and not isNil(var_26_7) then
				local var_26_10 = (arg_23_1.time_ - var_26_8) / var_26_9

				if arg_23_1.var_.characterEffect1017ui_story and not isNil(var_26_7) then
					arg_23_1.var_.characterEffect1017ui_story.fillFlat = false
				end
			end

			if arg_23_1.time_ >= var_26_8 + var_26_9 and arg_23_1.time_ < var_26_8 + var_26_9 + arg_26_0 and not isNil(var_26_7) and arg_23_1.var_.characterEffect1017ui_story then
				arg_23_1.var_.characterEffect1017ui_story.fillFlat = false
			end

			local var_26_11 = 0
			local var_26_12 = 0.625

			if var_26_11 < arg_23_1.time_ and arg_23_1.time_ <= var_26_11 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0
				arg_23_1.dialogCg_.alpha = 1

				arg_23_1.dialog_:SetActive(true)
				SetActive(arg_23_1.leftNameGo_, true)

				local var_26_13 = arg_23_1:FormatText(StoryNameCfg[273].name)

				arg_23_1.leftNameTxt_.text = var_26_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_23_1.leftNameTxt_.transform)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1.leftNameTxt_.text)
				SetActive(arg_23_1.iconTrs_.gameObject, false)
				arg_23_1.callingController_:SetSelectedState("normal")

				local var_26_14 = arg_23_1:GetWordFromCfg(115181006)
				local var_26_15 = arg_23_1:FormatText(var_26_14.content)

				arg_23_1.text_.text = var_26_15

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_16 = 25
				local var_26_17 = utf8.len(var_26_15)
				local var_26_18 = var_26_16 <= 0 and var_26_12 or var_26_12 * (var_26_17 / var_26_16)

				if var_26_18 > 0 and var_26_12 < var_26_18 then
					arg_23_1.talkMaxDuration = var_26_18

					if var_26_18 + var_26_11 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_18 + var_26_11
					end
				end

				arg_23_1.text_.text = var_26_15
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115181", "115181006", "story_v_out_115181.awb") ~= 0 then
					local var_26_19 = manager.audio:GetVoiceLength("story_v_out_115181", "115181006", "story_v_out_115181.awb") / 1000

					if var_26_19 + var_26_11 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_19 + var_26_11
					end

					if var_26_14.prefab_name ~= "" and arg_23_1.actors_[var_26_14.prefab_name] ~= nil then
						local var_26_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_23_1.actors_[var_26_14.prefab_name].transform, "story_v_out_115181", "115181006", "story_v_out_115181.awb")

						arg_23_1:RecordAudio("115181006", var_26_20)
						arg_23_1:RecordAudio("115181006", var_26_20)
					else
						arg_23_1:AudioAction("play", "voice", "story_v_out_115181", "115181006", "story_v_out_115181.awb")
					end

					arg_23_1:RecordHistoryTalkVoice("story_v_out_115181", "115181006", "story_v_out_115181.awb")
				end

				arg_23_1:RecordContent(arg_23_1.text_.text)
			end

			local var_26_21 = math.max(var_26_12, arg_23_1.talkMaxDuration)

			if var_26_11 <= arg_23_1.time_ and arg_23_1.time_ < var_26_11 + var_26_21 then
				arg_23_1.typewritter.percent = (arg_23_1.time_ - var_26_11) / var_26_21

				arg_23_1.typewritter:SetDirty()
			end

			if arg_23_1.time_ >= var_26_11 + var_26_21 and arg_23_1.time_ < var_26_11 + var_26_21 + arg_26_0 then
				arg_23_1.typewritter.percent = 1

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(true)
			end
		end

		arg_23_1.nodeConfigList_ = {}

		arg_23_1:InitPlayNodeList()
	end,
	Play115181007 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 115181007
		arg_27_1.duration_ = 2.17

		local var_27_0 = {
			ja = 1.999999999999,
			ko = 1.999999999999,
			zh = 1.999999999999,
			en = 2.166
		}
		local var_27_1 = manager.audio:GetLocalizationFlag()

		if var_27_0[var_27_1] ~= nil then
			arg_27_1.duration_ = var_27_0[var_27_1]
		end

		SetActive(arg_27_1.tipsGo_, false)

		function arg_27_1.onSingleLineFinish_()
			arg_27_1.onSingleLineUpdate_ = nil
			arg_27_1.onSingleLineFinish_ = nil
			arg_27_1.state_ = "waiting"
		end

		function arg_27_1.playNext_(arg_29_0)
			if arg_29_0 == 1 then
				arg_27_0:Play115181008(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			local var_30_0 = arg_27_1.actors_["1017ui_story"]
			local var_30_1 = 0

			if var_30_1 < arg_27_1.time_ and arg_27_1.time_ <= var_30_1 + arg_30_0 and not isNil(var_30_0) and arg_27_1.var_.characterEffect1017ui_story == nil then
				arg_27_1.var_.characterEffect1017ui_story = var_30_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_30_2 = 0.2

			if var_30_1 <= arg_27_1.time_ and arg_27_1.time_ < var_30_1 + var_30_2 and not isNil(var_30_0) then
				local var_30_3 = (arg_27_1.time_ - var_30_1) / var_30_2

				if arg_27_1.var_.characterEffect1017ui_story and not isNil(var_30_0) then
					local var_30_4 = Mathf.Lerp(0, 0.5, var_30_3)

					arg_27_1.var_.characterEffect1017ui_story.fillFlat = true
					arg_27_1.var_.characterEffect1017ui_story.fillRatio = var_30_4
				end
			end

			if arg_27_1.time_ >= var_30_1 + var_30_2 and arg_27_1.time_ < var_30_1 + var_30_2 + arg_30_0 and not isNil(var_30_0) and arg_27_1.var_.characterEffect1017ui_story then
				local var_30_5 = 0.5

				arg_27_1.var_.characterEffect1017ui_story.fillFlat = true
				arg_27_1.var_.characterEffect1017ui_story.fillRatio = var_30_5
			end

			local var_30_6 = arg_27_1.actors_["1024ui_story"]
			local var_30_7 = 0

			if var_30_7 < arg_27_1.time_ and arg_27_1.time_ <= var_30_7 + arg_30_0 and not isNil(var_30_6) and arg_27_1.var_.characterEffect1024ui_story == nil then
				arg_27_1.var_.characterEffect1024ui_story = var_30_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_30_8 = 0.2

			if var_30_7 <= arg_27_1.time_ and arg_27_1.time_ < var_30_7 + var_30_8 and not isNil(var_30_6) then
				local var_30_9 = (arg_27_1.time_ - var_30_7) / var_30_8

				if arg_27_1.var_.characterEffect1024ui_story and not isNil(var_30_6) then
					arg_27_1.var_.characterEffect1024ui_story.fillFlat = false
				end
			end

			if arg_27_1.time_ >= var_30_7 + var_30_8 and arg_27_1.time_ < var_30_7 + var_30_8 + arg_30_0 and not isNil(var_30_6) and arg_27_1.var_.characterEffect1024ui_story then
				arg_27_1.var_.characterEffect1024ui_story.fillFlat = false
			end

			local var_30_10 = 0

			if var_30_10 < arg_27_1.time_ and arg_27_1.time_ <= var_30_10 + arg_30_0 then
				arg_27_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_30_11 = 0

			if var_30_11 < arg_27_1.time_ and arg_27_1.time_ <= var_30_11 + arg_30_0 then
				arg_27_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/story1024/story1024action/1024action5_1")
			end

			local var_30_12 = 0
			local var_30_13 = 0.125

			if var_30_12 < arg_27_1.time_ and arg_27_1.time_ <= var_30_12 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, true)

				local var_30_14 = arg_27_1:FormatText(StoryNameCfg[265].name)

				arg_27_1.leftNameTxt_.text = var_30_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_27_1.leftNameTxt_.transform)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1.leftNameTxt_.text)
				SetActive(arg_27_1.iconTrs_.gameObject, false)
				arg_27_1.callingController_:SetSelectedState("normal")

				local var_30_15 = arg_27_1:GetWordFromCfg(115181007)
				local var_30_16 = arg_27_1:FormatText(var_30_15.content)

				arg_27_1.text_.text = var_30_16

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_17 = 5
				local var_30_18 = utf8.len(var_30_16)
				local var_30_19 = var_30_17 <= 0 and var_30_13 or var_30_13 * (var_30_18 / var_30_17)

				if var_30_19 > 0 and var_30_13 < var_30_19 then
					arg_27_1.talkMaxDuration = var_30_19

					if var_30_19 + var_30_12 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_19 + var_30_12
					end
				end

				arg_27_1.text_.text = var_30_16
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115181", "115181007", "story_v_out_115181.awb") ~= 0 then
					local var_30_20 = manager.audio:GetVoiceLength("story_v_out_115181", "115181007", "story_v_out_115181.awb") / 1000

					if var_30_20 + var_30_12 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_20 + var_30_12
					end

					if var_30_15.prefab_name ~= "" and arg_27_1.actors_[var_30_15.prefab_name] ~= nil then
						local var_30_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_27_1.actors_[var_30_15.prefab_name].transform, "story_v_out_115181", "115181007", "story_v_out_115181.awb")

						arg_27_1:RecordAudio("115181007", var_30_21)
						arg_27_1:RecordAudio("115181007", var_30_21)
					else
						arg_27_1:AudioAction("play", "voice", "story_v_out_115181", "115181007", "story_v_out_115181.awb")
					end

					arg_27_1:RecordHistoryTalkVoice("story_v_out_115181", "115181007", "story_v_out_115181.awb")
				end

				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_22 = math.max(var_30_13, arg_27_1.talkMaxDuration)

			if var_30_12 <= arg_27_1.time_ and arg_27_1.time_ < var_30_12 + var_30_22 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_12) / var_30_22

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_12 + var_30_22 and arg_27_1.time_ < var_30_12 + var_30_22 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end

		arg_27_1.nodeConfigList_ = {}

		arg_27_1:InitPlayNodeList()
	end,
	Play115181008 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 115181008
		arg_31_1.duration_ = 2

		SetActive(arg_31_1.tipsGo_, false)

		function arg_31_1.onSingleLineFinish_()
			arg_31_1.onSingleLineUpdate_ = nil
			arg_31_1.onSingleLineFinish_ = nil
			arg_31_1.state_ = "waiting"
		end

		function arg_31_1.playNext_(arg_33_0)
			if arg_33_0 == 1 then
				arg_31_0:Play115181009(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			local var_34_0 = arg_31_1.actors_["1024ui_story"]
			local var_34_1 = 0

			if var_34_1 < arg_31_1.time_ and arg_31_1.time_ <= var_34_1 + arg_34_0 and not isNil(var_34_0) and arg_31_1.var_.characterEffect1024ui_story == nil then
				arg_31_1.var_.characterEffect1024ui_story = var_34_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_34_2 = 0.2

			if var_34_1 <= arg_31_1.time_ and arg_31_1.time_ < var_34_1 + var_34_2 and not isNil(var_34_0) then
				local var_34_3 = (arg_31_1.time_ - var_34_1) / var_34_2

				if arg_31_1.var_.characterEffect1024ui_story and not isNil(var_34_0) then
					local var_34_4 = Mathf.Lerp(0, 0.5, var_34_3)

					arg_31_1.var_.characterEffect1024ui_story.fillFlat = true
					arg_31_1.var_.characterEffect1024ui_story.fillRatio = var_34_4
				end
			end

			if arg_31_1.time_ >= var_34_1 + var_34_2 and arg_31_1.time_ < var_34_1 + var_34_2 + arg_34_0 and not isNil(var_34_0) and arg_31_1.var_.characterEffect1024ui_story then
				local var_34_5 = 0.5

				arg_31_1.var_.characterEffect1024ui_story.fillFlat = true
				arg_31_1.var_.characterEffect1024ui_story.fillRatio = var_34_5
			end

			local var_34_6 = 0

			if var_34_6 < arg_31_1.time_ and arg_31_1.time_ <= var_34_6 + arg_34_0 then
				arg_31_1:PlayTimeline("1017ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_34_7 = arg_31_1.actors_["1017ui_story"]
			local var_34_8 = 0

			if var_34_8 < arg_31_1.time_ and arg_31_1.time_ <= var_34_8 + arg_34_0 and not isNil(var_34_7) and arg_31_1.var_.characterEffect1017ui_story == nil then
				arg_31_1.var_.characterEffect1017ui_story = var_34_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_34_9 = 0.2

			if var_34_8 <= arg_31_1.time_ and arg_31_1.time_ < var_34_8 + var_34_9 and not isNil(var_34_7) then
				local var_34_10 = (arg_31_1.time_ - var_34_8) / var_34_9

				if arg_31_1.var_.characterEffect1017ui_story and not isNil(var_34_7) then
					arg_31_1.var_.characterEffect1017ui_story.fillFlat = false
				end
			end

			if arg_31_1.time_ >= var_34_8 + var_34_9 and arg_31_1.time_ < var_34_8 + var_34_9 + arg_34_0 and not isNil(var_34_7) and arg_31_1.var_.characterEffect1017ui_story then
				arg_31_1.var_.characterEffect1017ui_story.fillFlat = false
			end

			local var_34_11 = 0
			local var_34_12 = 0.05

			if var_34_11 < arg_31_1.time_ and arg_31_1.time_ <= var_34_11 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, true)

				local var_34_13 = arg_31_1:FormatText(StoryNameCfg[273].name)

				arg_31_1.leftNameTxt_.text = var_34_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_31_1.leftNameTxt_.transform)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1.leftNameTxt_.text)
				SetActive(arg_31_1.iconTrs_.gameObject, false)
				arg_31_1.callingController_:SetSelectedState("normal")

				local var_34_14 = arg_31_1:GetWordFromCfg(115181008)
				local var_34_15 = arg_31_1:FormatText(var_34_14.content)

				arg_31_1.text_.text = var_34_15

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_16 = 2
				local var_34_17 = utf8.len(var_34_15)
				local var_34_18 = var_34_16 <= 0 and var_34_12 or var_34_12 * (var_34_17 / var_34_16)

				if var_34_18 > 0 and var_34_12 < var_34_18 then
					arg_31_1.talkMaxDuration = var_34_18

					if var_34_18 + var_34_11 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_18 + var_34_11
					end
				end

				arg_31_1.text_.text = var_34_15
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115181", "115181008", "story_v_out_115181.awb") ~= 0 then
					local var_34_19 = manager.audio:GetVoiceLength("story_v_out_115181", "115181008", "story_v_out_115181.awb") / 1000

					if var_34_19 + var_34_11 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_19 + var_34_11
					end

					if var_34_14.prefab_name ~= "" and arg_31_1.actors_[var_34_14.prefab_name] ~= nil then
						local var_34_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_31_1.actors_[var_34_14.prefab_name].transform, "story_v_out_115181", "115181008", "story_v_out_115181.awb")

						arg_31_1:RecordAudio("115181008", var_34_20)
						arg_31_1:RecordAudio("115181008", var_34_20)
					else
						arg_31_1:AudioAction("play", "voice", "story_v_out_115181", "115181008", "story_v_out_115181.awb")
					end

					arg_31_1:RecordHistoryTalkVoice("story_v_out_115181", "115181008", "story_v_out_115181.awb")
				end

				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_21 = math.max(var_34_12, arg_31_1.talkMaxDuration)

			if var_34_11 <= arg_31_1.time_ and arg_31_1.time_ < var_34_11 + var_34_21 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - var_34_11) / var_34_21

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= var_34_11 + var_34_21 and arg_31_1.time_ < var_34_11 + var_34_21 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {}

		arg_31_1:InitPlayNodeList()
	end,
	Play115181009 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 115181009
		arg_35_1.duration_ = 5

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play115181010(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			local var_38_0 = arg_35_1.actors_["1017ui_story"]
			local var_38_1 = 0

			if var_38_1 < arg_35_1.time_ and arg_35_1.time_ <= var_38_1 + arg_38_0 and not isNil(var_38_0) and arg_35_1.var_.characterEffect1017ui_story == nil then
				arg_35_1.var_.characterEffect1017ui_story = var_38_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_38_2 = 0.2

			if var_38_1 <= arg_35_1.time_ and arg_35_1.time_ < var_38_1 + var_38_2 and not isNil(var_38_0) then
				local var_38_3 = (arg_35_1.time_ - var_38_1) / var_38_2

				if arg_35_1.var_.characterEffect1017ui_story and not isNil(var_38_0) then
					local var_38_4 = Mathf.Lerp(0, 0.5, var_38_3)

					arg_35_1.var_.characterEffect1017ui_story.fillFlat = true
					arg_35_1.var_.characterEffect1017ui_story.fillRatio = var_38_4
				end
			end

			if arg_35_1.time_ >= var_38_1 + var_38_2 and arg_35_1.time_ < var_38_1 + var_38_2 + arg_38_0 and not isNil(var_38_0) and arg_35_1.var_.characterEffect1017ui_story then
				local var_38_5 = 0.5

				arg_35_1.var_.characterEffect1017ui_story.fillFlat = true
				arg_35_1.var_.characterEffect1017ui_story.fillRatio = var_38_5
			end

			local var_38_6 = 0

			if var_38_6 < arg_35_1.time_ and arg_35_1.time_ <= var_38_6 + arg_38_0 then
				arg_35_1:PlayTimeline("1017ui_story", "StoryTimeline/CharAction/story1017/story1017action/1017action3_2")
			end

			local var_38_7 = 0
			local var_38_8 = 0.675

			if var_38_7 < arg_35_1.time_ and arg_35_1.time_ <= var_38_7 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, false)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_9 = arg_35_1:GetWordFromCfg(115181009)
				local var_38_10 = arg_35_1:FormatText(var_38_9.content)

				arg_35_1.text_.text = var_38_10

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_11 = 27
				local var_38_12 = utf8.len(var_38_10)
				local var_38_13 = var_38_11 <= 0 and var_38_8 or var_38_8 * (var_38_12 / var_38_11)

				if var_38_13 > 0 and var_38_8 < var_38_13 then
					arg_35_1.talkMaxDuration = var_38_13

					if var_38_13 + var_38_7 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_13 + var_38_7
					end
				end

				arg_35_1.text_.text = var_38_10
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)
				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_14 = math.max(var_38_8, arg_35_1.talkMaxDuration)

			if var_38_7 <= arg_35_1.time_ and arg_35_1.time_ < var_38_7 + var_38_14 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_7) / var_38_14

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_7 + var_38_14 and arg_35_1.time_ < var_38_7 + var_38_14 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {}

		arg_35_1:InitPlayNodeList()
	end,
	Play115181010 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 115181010
		arg_39_1.duration_ = 5.6

		local var_39_0 = {
			ja = 5.233,
			ko = 5.4,
			zh = 5.6,
			en = 5
		}
		local var_39_1 = manager.audio:GetLocalizationFlag()

		if var_39_0[var_39_1] ~= nil then
			arg_39_1.duration_ = var_39_0[var_39_1]
		end

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play115181011(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			local var_42_0 = 0

			if var_42_0 < arg_39_1.time_ and arg_39_1.time_ <= var_42_0 + arg_42_0 then
				arg_39_1:PlayTimeline("1017ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_42_1 = arg_39_1.actors_["1017ui_story"]
			local var_42_2 = 0

			if var_42_2 < arg_39_1.time_ and arg_39_1.time_ <= var_42_2 + arg_42_0 and not isNil(var_42_1) and arg_39_1.var_.characterEffect1017ui_story == nil then
				arg_39_1.var_.characterEffect1017ui_story = var_42_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_42_3 = 0.2

			if var_42_2 <= arg_39_1.time_ and arg_39_1.time_ < var_42_2 + var_42_3 and not isNil(var_42_1) then
				local var_42_4 = (arg_39_1.time_ - var_42_2) / var_42_3

				if arg_39_1.var_.characterEffect1017ui_story and not isNil(var_42_1) then
					arg_39_1.var_.characterEffect1017ui_story.fillFlat = false
				end
			end

			if arg_39_1.time_ >= var_42_2 + var_42_3 and arg_39_1.time_ < var_42_2 + var_42_3 + arg_42_0 and not isNil(var_42_1) and arg_39_1.var_.characterEffect1017ui_story then
				arg_39_1.var_.characterEffect1017ui_story.fillFlat = false
			end

			local var_42_5 = 0
			local var_42_6 = 0.575

			if var_42_5 < arg_39_1.time_ and arg_39_1.time_ <= var_42_5 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, true)

				local var_42_7 = arg_39_1:FormatText(StoryNameCfg[273].name)

				arg_39_1.leftNameTxt_.text = var_42_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_8 = arg_39_1:GetWordFromCfg(115181010)
				local var_42_9 = arg_39_1:FormatText(var_42_8.content)

				arg_39_1.text_.text = var_42_9

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_10 = 23
				local var_42_11 = utf8.len(var_42_9)
				local var_42_12 = var_42_10 <= 0 and var_42_6 or var_42_6 * (var_42_11 / var_42_10)

				if var_42_12 > 0 and var_42_6 < var_42_12 then
					arg_39_1.talkMaxDuration = var_42_12

					if var_42_12 + var_42_5 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_12 + var_42_5
					end
				end

				arg_39_1.text_.text = var_42_9
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115181", "115181010", "story_v_out_115181.awb") ~= 0 then
					local var_42_13 = manager.audio:GetVoiceLength("story_v_out_115181", "115181010", "story_v_out_115181.awb") / 1000

					if var_42_13 + var_42_5 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_13 + var_42_5
					end

					if var_42_8.prefab_name ~= "" and arg_39_1.actors_[var_42_8.prefab_name] ~= nil then
						local var_42_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_39_1.actors_[var_42_8.prefab_name].transform, "story_v_out_115181", "115181010", "story_v_out_115181.awb")

						arg_39_1:RecordAudio("115181010", var_42_14)
						arg_39_1:RecordAudio("115181010", var_42_14)
					else
						arg_39_1:AudioAction("play", "voice", "story_v_out_115181", "115181010", "story_v_out_115181.awb")
					end

					arg_39_1:RecordHistoryTalkVoice("story_v_out_115181", "115181010", "story_v_out_115181.awb")
				end

				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_15 = math.max(var_42_6, arg_39_1.talkMaxDuration)

			if var_42_5 <= arg_39_1.time_ and arg_39_1.time_ < var_42_5 + var_42_15 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_5) / var_42_15

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_5 + var_42_15 and arg_39_1.time_ < var_42_5 + var_42_15 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {}

		arg_39_1:InitPlayNodeList()
	end,
	Play115181011 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 115181011
		arg_43_1.duration_ = 5

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play115181012(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			local var_46_0 = arg_43_1.actors_["1024ui_story"].transform
			local var_46_1 = 0

			if var_46_1 < arg_43_1.time_ and arg_43_1.time_ <= var_46_1 + arg_46_0 then
				arg_43_1.var_.moveOldPos1024ui_story = var_46_0.localPosition
			end

			local var_46_2 = 0.001

			if var_46_1 <= arg_43_1.time_ and arg_43_1.time_ < var_46_1 + var_46_2 then
				local var_46_3 = (arg_43_1.time_ - var_46_1) / var_46_2
				local var_46_4 = Vector3.New(0, 100, 0)

				var_46_0.localPosition = Vector3.Lerp(arg_43_1.var_.moveOldPos1024ui_story, var_46_4, var_46_3)

				local var_46_5 = manager.ui.mainCamera.transform.position - var_46_0.position

				var_46_0.forward = Vector3.New(var_46_5.x, var_46_5.y, var_46_5.z)

				local var_46_6 = var_46_0.localEulerAngles

				var_46_6.z = 0
				var_46_6.x = 0
				var_46_0.localEulerAngles = var_46_6
			end

			if arg_43_1.time_ >= var_46_1 + var_46_2 and arg_43_1.time_ < var_46_1 + var_46_2 + arg_46_0 then
				var_46_0.localPosition = Vector3.New(0, 100, 0)

				local var_46_7 = manager.ui.mainCamera.transform.position - var_46_0.position

				var_46_0.forward = Vector3.New(var_46_7.x, var_46_7.y, var_46_7.z)

				local var_46_8 = var_46_0.localEulerAngles

				var_46_8.z = 0
				var_46_8.x = 0
				var_46_0.localEulerAngles = var_46_8
			end

			local var_46_9 = arg_43_1.actors_["1017ui_story"].transform
			local var_46_10 = 0

			if var_46_10 < arg_43_1.time_ and arg_43_1.time_ <= var_46_10 + arg_46_0 then
				arg_43_1.var_.moveOldPos1017ui_story = var_46_9.localPosition
			end

			local var_46_11 = 0.001

			if var_46_10 <= arg_43_1.time_ and arg_43_1.time_ < var_46_10 + var_46_11 then
				local var_46_12 = (arg_43_1.time_ - var_46_10) / var_46_11
				local var_46_13 = Vector3.New(0, 100, 0)

				var_46_9.localPosition = Vector3.Lerp(arg_43_1.var_.moveOldPos1017ui_story, var_46_13, var_46_12)

				local var_46_14 = manager.ui.mainCamera.transform.position - var_46_9.position

				var_46_9.forward = Vector3.New(var_46_14.x, var_46_14.y, var_46_14.z)

				local var_46_15 = var_46_9.localEulerAngles

				var_46_15.z = 0
				var_46_15.x = 0
				var_46_9.localEulerAngles = var_46_15
			end

			if arg_43_1.time_ >= var_46_10 + var_46_11 and arg_43_1.time_ < var_46_10 + var_46_11 + arg_46_0 then
				var_46_9.localPosition = Vector3.New(0, 100, 0)

				local var_46_16 = manager.ui.mainCamera.transform.position - var_46_9.position

				var_46_9.forward = Vector3.New(var_46_16.x, var_46_16.y, var_46_16.z)

				local var_46_17 = var_46_9.localEulerAngles

				var_46_17.z = 0
				var_46_17.x = 0
				var_46_9.localEulerAngles = var_46_17
			end

			local var_46_18 = 0
			local var_46_19 = 0.55

			if var_46_18 < arg_43_1.time_ and arg_43_1.time_ <= var_46_18 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, false)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_20 = arg_43_1:GetWordFromCfg(115181011)
				local var_46_21 = arg_43_1:FormatText(var_46_20.content)

				arg_43_1.text_.text = var_46_21

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_22 = 22
				local var_46_23 = utf8.len(var_46_21)
				local var_46_24 = var_46_22 <= 0 and var_46_19 or var_46_19 * (var_46_23 / var_46_22)

				if var_46_24 > 0 and var_46_19 < var_46_24 then
					arg_43_1.talkMaxDuration = var_46_24

					if var_46_24 + var_46_18 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_24 + var_46_18
					end
				end

				arg_43_1.text_.text = var_46_21
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)
				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_25 = math.max(var_46_19, arg_43_1.talkMaxDuration)

			if var_46_18 <= arg_43_1.time_ and arg_43_1.time_ < var_46_18 + var_46_25 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_18) / var_46_25

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_18 + var_46_25 and arg_43_1.time_ < var_46_18 + var_46_25 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1017ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_43_1:InitPlayNodeList()
	end,
	Play115181012 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 115181012
		arg_47_1.duration_ = 6.4

		local var_47_0 = {
			ja = 6.4,
			ko = 6.299999999999,
			zh = 6.299999999999,
			en = 6.299999999999
		}
		local var_47_1 = manager.audio:GetLocalizationFlag()

		if var_47_0[var_47_1] ~= nil then
			arg_47_1.duration_ = var_47_0[var_47_1]
		end

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play115181013(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			local var_50_0 = arg_47_1.actors_["1024ui_story"].transform
			local var_50_1 = 0

			if var_50_1 < arg_47_1.time_ and arg_47_1.time_ <= var_50_1 + arg_50_0 then
				arg_47_1.var_.moveOldPos1024ui_story = var_50_0.localPosition
			end

			local var_50_2 = 0.001

			if var_50_1 <= arg_47_1.time_ and arg_47_1.time_ < var_50_1 + var_50_2 then
				local var_50_3 = (arg_47_1.time_ - var_50_1) / var_50_2
				local var_50_4 = Vector3.New(0.7, -1, -6.05)

				var_50_0.localPosition = Vector3.Lerp(arg_47_1.var_.moveOldPos1024ui_story, var_50_4, var_50_3)

				local var_50_5 = manager.ui.mainCamera.transform.position - var_50_0.position

				var_50_0.forward = Vector3.New(var_50_5.x, var_50_5.y, var_50_5.z)

				local var_50_6 = var_50_0.localEulerAngles

				var_50_6.z = 0
				var_50_6.x = 0
				var_50_0.localEulerAngles = var_50_6
			end

			if arg_47_1.time_ >= var_50_1 + var_50_2 and arg_47_1.time_ < var_50_1 + var_50_2 + arg_50_0 then
				var_50_0.localPosition = Vector3.New(0.7, -1, -6.05)

				local var_50_7 = manager.ui.mainCamera.transform.position - var_50_0.position

				var_50_0.forward = Vector3.New(var_50_7.x, var_50_7.y, var_50_7.z)

				local var_50_8 = var_50_0.localEulerAngles

				var_50_8.z = 0
				var_50_8.x = 0
				var_50_0.localEulerAngles = var_50_8
			end

			local var_50_9 = 0

			if var_50_9 < arg_47_1.time_ and arg_47_1.time_ <= var_50_9 + arg_50_0 then
				arg_47_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/story1024/story1024action/1024action1_1")
			end

			local var_50_10 = 0

			if var_50_10 < arg_47_1.time_ and arg_47_1.time_ <= var_50_10 + arg_50_0 then
				arg_47_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_50_11 = arg_47_1.actors_["1024ui_story"]
			local var_50_12 = 0

			if var_50_12 < arg_47_1.time_ and arg_47_1.time_ <= var_50_12 + arg_50_0 and not isNil(var_50_11) and arg_47_1.var_.characterEffect1024ui_story == nil then
				arg_47_1.var_.characterEffect1024ui_story = var_50_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_50_13 = 0.2

			if var_50_12 <= arg_47_1.time_ and arg_47_1.time_ < var_50_12 + var_50_13 and not isNil(var_50_11) then
				local var_50_14 = (arg_47_1.time_ - var_50_12) / var_50_13

				if arg_47_1.var_.characterEffect1024ui_story and not isNil(var_50_11) then
					local var_50_15 = Mathf.Lerp(0, 0.5, var_50_14)

					arg_47_1.var_.characterEffect1024ui_story.fillFlat = true
					arg_47_1.var_.characterEffect1024ui_story.fillRatio = var_50_15
				end
			end

			if arg_47_1.time_ >= var_50_12 + var_50_13 and arg_47_1.time_ < var_50_12 + var_50_13 + arg_50_0 and not isNil(var_50_11) and arg_47_1.var_.characterEffect1024ui_story then
				local var_50_16 = 0.5

				arg_47_1.var_.characterEffect1024ui_story.fillFlat = true
				arg_47_1.var_.characterEffect1024ui_story.fillRatio = var_50_16
			end

			local var_50_17 = "10014ui_story"

			if arg_47_1.actors_[var_50_17] == nil then
				local var_50_18 = Asset.Load("Char/" .. "10014ui_story")

				if not isNil(var_50_18) then
					local var_50_19 = Object.Instantiate(Asset.Load("Char/" .. "10014ui_story"), arg_47_1.stage_.transform)

					var_50_19.name = var_50_17
					var_50_19.transform.localPosition = Vector3.New(0, 100, 0)
					arg_47_1.actors_[var_50_17] = var_50_19

					local var_50_20 = var_50_19:GetComponentInChildren(typeof(CharacterEffect))

					var_50_20.enabled = true

					local var_50_21 = GameObjectTools.GetOrAddComponent(var_50_19, typeof(DynamicBoneHelper))

					if var_50_21 then
						var_50_21:EnableDynamicBone(false)
					end

					arg_47_1:ShowWeapon(var_50_20.transform, false)

					arg_47_1.var_[var_50_17 .. "Animator"] = var_50_20.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_47_1.var_[var_50_17 .. "Animator"].applyRootMotion = true
					arg_47_1.var_[var_50_17 .. "LipSync"] = var_50_20.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_50_22 = arg_47_1.actors_["10014ui_story"].transform
			local var_50_23 = 0

			if var_50_23 < arg_47_1.time_ and arg_47_1.time_ <= var_50_23 + arg_50_0 then
				arg_47_1.var_.moveOldPos10014ui_story = var_50_22.localPosition
			end

			local var_50_24 = 0.001

			if var_50_23 <= arg_47_1.time_ and arg_47_1.time_ < var_50_23 + var_50_24 then
				local var_50_25 = (arg_47_1.time_ - var_50_23) / var_50_24
				local var_50_26 = Vector3.New(-0.7, -1.06, -6.2)

				var_50_22.localPosition = Vector3.Lerp(arg_47_1.var_.moveOldPos10014ui_story, var_50_26, var_50_25)

				local var_50_27 = manager.ui.mainCamera.transform.position - var_50_22.position

				var_50_22.forward = Vector3.New(var_50_27.x, var_50_27.y, var_50_27.z)

				local var_50_28 = var_50_22.localEulerAngles

				var_50_28.z = 0
				var_50_28.x = 0
				var_50_22.localEulerAngles = var_50_28
			end

			if arg_47_1.time_ >= var_50_23 + var_50_24 and arg_47_1.time_ < var_50_23 + var_50_24 + arg_50_0 then
				var_50_22.localPosition = Vector3.New(-0.7, -1.06, -6.2)

				local var_50_29 = manager.ui.mainCamera.transform.position - var_50_22.position

				var_50_22.forward = Vector3.New(var_50_29.x, var_50_29.y, var_50_29.z)

				local var_50_30 = var_50_22.localEulerAngles

				var_50_30.z = 0
				var_50_30.x = 0
				var_50_22.localEulerAngles = var_50_30
			end

			local var_50_31 = 0

			if var_50_31 < arg_47_1.time_ and arg_47_1.time_ <= var_50_31 + arg_50_0 then
				arg_47_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/story10014/story10014action/10014action1_1")
			end

			local var_50_32 = 0

			if var_50_32 < arg_47_1.time_ and arg_47_1.time_ <= var_50_32 + arg_50_0 then
				arg_47_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_50_33 = arg_47_1.actors_["10014ui_story"]
			local var_50_34 = 0

			if var_50_34 < arg_47_1.time_ and arg_47_1.time_ <= var_50_34 + arg_50_0 and not isNil(var_50_33) and arg_47_1.var_.characterEffect10014ui_story == nil then
				arg_47_1.var_.characterEffect10014ui_story = var_50_33:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_50_35 = 0.2

			if var_50_34 <= arg_47_1.time_ and arg_47_1.time_ < var_50_34 + var_50_35 and not isNil(var_50_33) then
				local var_50_36 = (arg_47_1.time_ - var_50_34) / var_50_35

				if arg_47_1.var_.characterEffect10014ui_story and not isNil(var_50_33) then
					arg_47_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_47_1.time_ >= var_50_34 + var_50_35 and arg_47_1.time_ < var_50_34 + var_50_35 + arg_50_0 and not isNil(var_50_33) and arg_47_1.var_.characterEffect10014ui_story then
				arg_47_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			local var_50_37 = arg_47_1.actors_["10014ui_story"]
			local var_50_38 = 0

			if var_50_38 < arg_47_1.time_ and arg_47_1.time_ <= var_50_38 + arg_50_0 then
				if arg_47_1.var_.characterEffect10014ui_story == nil then
					arg_47_1.var_.characterEffect10014ui_story = var_50_37:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_50_39 = arg_47_1.var_.characterEffect10014ui_story

				var_50_39.imageEffect:turnOff()

				var_50_39.interferenceEffect.enabled = true
				var_50_39.interferenceEffect.noise = 0.001
				var_50_39.interferenceEffect.simTimeScale = 1
				var_50_39.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			local var_50_40 = arg_47_1.actors_["10014ui_story"]
			local var_50_41 = 0
			local var_50_42 = 0.0166666666666667

			if var_50_41 < arg_47_1.time_ and arg_47_1.time_ <= var_50_41 + arg_50_0 then
				if arg_47_1.var_.characterEffect10014ui_story == nil then
					arg_47_1.var_.characterEffect10014ui_story = var_50_40:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_47_1.var_.characterEffect10014ui_story.imageEffect:turnOn(false)
			end

			local var_50_43 = 0
			local var_50_44 = 0.35

			if var_50_43 < arg_47_1.time_ and arg_47_1.time_ <= var_50_43 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				local var_50_45 = arg_47_1:FormatText(StoryNameCfg[264].name)

				arg_47_1.leftNameTxt_.text = var_50_45

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_46 = arg_47_1:GetWordFromCfg(115181012)
				local var_50_47 = arg_47_1:FormatText(var_50_46.content)

				arg_47_1.text_.text = var_50_47

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_48 = 14
				local var_50_49 = utf8.len(var_50_47)
				local var_50_50 = var_50_48 <= 0 and var_50_44 or var_50_44 * (var_50_49 / var_50_48)

				if var_50_50 > 0 and var_50_44 < var_50_50 then
					arg_47_1.talkMaxDuration = var_50_50

					if var_50_50 + var_50_43 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_50 + var_50_43
					end
				end

				arg_47_1.text_.text = var_50_47
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115181", "115181012", "story_v_out_115181.awb") ~= 0 then
					local var_50_51 = manager.audio:GetVoiceLength("story_v_out_115181", "115181012", "story_v_out_115181.awb") / 1000

					if var_50_51 + var_50_43 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_51 + var_50_43
					end

					if var_50_46.prefab_name ~= "" and arg_47_1.actors_[var_50_46.prefab_name] ~= nil then
						local var_50_52 = LuaForUtil.PlayVoiceWithCriLipsync(arg_47_1.actors_[var_50_46.prefab_name].transform, "story_v_out_115181", "115181012", "story_v_out_115181.awb")

						arg_47_1:RecordAudio("115181012", var_50_52)
						arg_47_1:RecordAudio("115181012", var_50_52)
					else
						arg_47_1:AudioAction("play", "voice", "story_v_out_115181", "115181012", "story_v_out_115181.awb")
					end

					arg_47_1:RecordHistoryTalkVoice("story_v_out_115181", "115181012", "story_v_out_115181.awb")
				end

				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_53 = math.max(var_50_44, arg_47_1.talkMaxDuration)

			if var_50_43 <= arg_47_1.time_ and arg_47_1.time_ < var_50_43 + var_50_53 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_43) / var_50_53

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_43 + var_50_53 and arg_47_1.time_ < var_50_43 + var_50_53 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10014ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_47_1:InitPlayNodeList()
	end,
	Play115181013 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 115181013
		arg_51_1.duration_ = 5.3

		local var_51_0 = {
			ja = 5.3,
			ko = 4.466,
			zh = 3.233,
			en = 3.333
		}
		local var_51_1 = manager.audio:GetLocalizationFlag()

		if var_51_0[var_51_1] ~= nil then
			arg_51_1.duration_ = var_51_0[var_51_1]
		end

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play115181014(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			local var_54_0 = arg_51_1.actors_["1024ui_story"]
			local var_54_1 = 0

			if var_54_1 < arg_51_1.time_ and arg_51_1.time_ <= var_54_1 + arg_54_0 and not isNil(var_54_0) and arg_51_1.var_.characterEffect1024ui_story == nil then
				arg_51_1.var_.characterEffect1024ui_story = var_54_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_54_2 = 0.2

			if var_54_1 <= arg_51_1.time_ and arg_51_1.time_ < var_54_1 + var_54_2 and not isNil(var_54_0) then
				local var_54_3 = (arg_51_1.time_ - var_54_1) / var_54_2

				if arg_51_1.var_.characterEffect1024ui_story and not isNil(var_54_0) then
					arg_51_1.var_.characterEffect1024ui_story.fillFlat = false
				end
			end

			if arg_51_1.time_ >= var_54_1 + var_54_2 and arg_51_1.time_ < var_54_1 + var_54_2 + arg_54_0 and not isNil(var_54_0) and arg_51_1.var_.characterEffect1024ui_story then
				arg_51_1.var_.characterEffect1024ui_story.fillFlat = false
			end

			local var_54_4 = 0

			if var_54_4 < arg_51_1.time_ and arg_51_1.time_ <= var_54_4 + arg_54_0 then
				arg_51_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_54_5 = 0
			local var_54_6 = 0.375

			if var_54_5 < arg_51_1.time_ and arg_51_1.time_ <= var_54_5 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				local var_54_7 = arg_51_1:FormatText(StoryNameCfg[265].name)

				arg_51_1.leftNameTxt_.text = var_54_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_8 = arg_51_1:GetWordFromCfg(115181013)
				local var_54_9 = arg_51_1:FormatText(var_54_8.content)

				arg_51_1.text_.text = var_54_9

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_10 = 15
				local var_54_11 = utf8.len(var_54_9)
				local var_54_12 = var_54_10 <= 0 and var_54_6 or var_54_6 * (var_54_11 / var_54_10)

				if var_54_12 > 0 and var_54_6 < var_54_12 then
					arg_51_1.talkMaxDuration = var_54_12

					if var_54_12 + var_54_5 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_12 + var_54_5
					end
				end

				arg_51_1.text_.text = var_54_9
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115181", "115181013", "story_v_out_115181.awb") ~= 0 then
					local var_54_13 = manager.audio:GetVoiceLength("story_v_out_115181", "115181013", "story_v_out_115181.awb") / 1000

					if var_54_13 + var_54_5 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_13 + var_54_5
					end

					if var_54_8.prefab_name ~= "" and arg_51_1.actors_[var_54_8.prefab_name] ~= nil then
						local var_54_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_51_1.actors_[var_54_8.prefab_name].transform, "story_v_out_115181", "115181013", "story_v_out_115181.awb")

						arg_51_1:RecordAudio("115181013", var_54_14)
						arg_51_1:RecordAudio("115181013", var_54_14)
					else
						arg_51_1:AudioAction("play", "voice", "story_v_out_115181", "115181013", "story_v_out_115181.awb")
					end

					arg_51_1:RecordHistoryTalkVoice("story_v_out_115181", "115181013", "story_v_out_115181.awb")
				end

				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_15 = math.max(var_54_6, arg_51_1.talkMaxDuration)

			if var_54_5 <= arg_51_1.time_ and arg_51_1.time_ < var_54_5 + var_54_15 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_5) / var_54_15

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_5 + var_54_15 and arg_51_1.time_ < var_54_5 + var_54_15 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {}

		arg_51_1:InitPlayNodeList()
	end,
	Play115181014 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 115181014
		arg_55_1.duration_ = 3.6

		local var_55_0 = {
			ja = 3.4,
			ko = 3.433,
			zh = 3.6,
			en = 3.3
		}
		local var_55_1 = manager.audio:GetLocalizationFlag()

		if var_55_0[var_55_1] ~= nil then
			arg_55_1.duration_ = var_55_0[var_55_1]
		end

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play115181015(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			local var_58_0 = arg_55_1.actors_["1024ui_story"]
			local var_58_1 = 0

			if var_58_1 < arg_55_1.time_ and arg_55_1.time_ <= var_58_1 + arg_58_0 and not isNil(var_58_0) and arg_55_1.var_.characterEffect1024ui_story == nil then
				arg_55_1.var_.characterEffect1024ui_story = var_58_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_58_2 = 0.2

			if var_58_1 <= arg_55_1.time_ and arg_55_1.time_ < var_58_1 + var_58_2 and not isNil(var_58_0) then
				local var_58_3 = (arg_55_1.time_ - var_58_1) / var_58_2

				if arg_55_1.var_.characterEffect1024ui_story and not isNil(var_58_0) then
					local var_58_4 = Mathf.Lerp(0, 0.5, var_58_3)

					arg_55_1.var_.characterEffect1024ui_story.fillFlat = true
					arg_55_1.var_.characterEffect1024ui_story.fillRatio = var_58_4
				end
			end

			if arg_55_1.time_ >= var_58_1 + var_58_2 and arg_55_1.time_ < var_58_1 + var_58_2 + arg_58_0 and not isNil(var_58_0) and arg_55_1.var_.characterEffect1024ui_story then
				local var_58_5 = 0.5

				arg_55_1.var_.characterEffect1024ui_story.fillFlat = true
				arg_55_1.var_.characterEffect1024ui_story.fillRatio = var_58_5
			end

			local var_58_6 = 0

			if var_58_6 < arg_55_1.time_ and arg_55_1.time_ <= var_58_6 + arg_58_0 then
				arg_55_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_58_7 = arg_55_1.actors_["10014ui_story"]
			local var_58_8 = 0

			if var_58_8 < arg_55_1.time_ and arg_55_1.time_ <= var_58_8 + arg_58_0 and not isNil(var_58_7) and arg_55_1.var_.characterEffect10014ui_story == nil then
				arg_55_1.var_.characterEffect10014ui_story = var_58_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_58_9 = 0.2

			if var_58_8 <= arg_55_1.time_ and arg_55_1.time_ < var_58_8 + var_58_9 and not isNil(var_58_7) then
				local var_58_10 = (arg_55_1.time_ - var_58_8) / var_58_9

				if arg_55_1.var_.characterEffect10014ui_story and not isNil(var_58_7) then
					arg_55_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_55_1.time_ >= var_58_8 + var_58_9 and arg_55_1.time_ < var_58_8 + var_58_9 + arg_58_0 and not isNil(var_58_7) and arg_55_1.var_.characterEffect10014ui_story then
				arg_55_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			local var_58_11 = 0
			local var_58_12 = 0.25

			if var_58_11 < arg_55_1.time_ and arg_55_1.time_ <= var_58_11 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				local var_58_13 = arg_55_1:FormatText(StoryNameCfg[264].name)

				arg_55_1.leftNameTxt_.text = var_58_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_14 = arg_55_1:GetWordFromCfg(115181014)
				local var_58_15 = arg_55_1:FormatText(var_58_14.content)

				arg_55_1.text_.text = var_58_15

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_16 = 10
				local var_58_17 = utf8.len(var_58_15)
				local var_58_18 = var_58_16 <= 0 and var_58_12 or var_58_12 * (var_58_17 / var_58_16)

				if var_58_18 > 0 and var_58_12 < var_58_18 then
					arg_55_1.talkMaxDuration = var_58_18

					if var_58_18 + var_58_11 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_18 + var_58_11
					end
				end

				arg_55_1.text_.text = var_58_15
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115181", "115181014", "story_v_out_115181.awb") ~= 0 then
					local var_58_19 = manager.audio:GetVoiceLength("story_v_out_115181", "115181014", "story_v_out_115181.awb") / 1000

					if var_58_19 + var_58_11 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_19 + var_58_11
					end

					if var_58_14.prefab_name ~= "" and arg_55_1.actors_[var_58_14.prefab_name] ~= nil then
						local var_58_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_55_1.actors_[var_58_14.prefab_name].transform, "story_v_out_115181", "115181014", "story_v_out_115181.awb")

						arg_55_1:RecordAudio("115181014", var_58_20)
						arg_55_1:RecordAudio("115181014", var_58_20)
					else
						arg_55_1:AudioAction("play", "voice", "story_v_out_115181", "115181014", "story_v_out_115181.awb")
					end

					arg_55_1:RecordHistoryTalkVoice("story_v_out_115181", "115181014", "story_v_out_115181.awb")
				end

				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_21 = math.max(var_58_12, arg_55_1.talkMaxDuration)

			if var_58_11 <= arg_55_1.time_ and arg_55_1.time_ < var_58_11 + var_58_21 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_11) / var_58_21

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_11 + var_58_21 and arg_55_1.time_ < var_58_11 + var_58_21 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {}

		arg_55_1:InitPlayNodeList()
	end,
	Play115181015 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 115181015
		arg_59_1.duration_ = 10.6

		local var_59_0 = {
			ja = 9.633,
			ko = 8.633,
			zh = 8.166,
			en = 10.6
		}
		local var_59_1 = manager.audio:GetLocalizationFlag()

		if var_59_0[var_59_1] ~= nil then
			arg_59_1.duration_ = var_59_0[var_59_1]
		end

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play115181016(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = 0

			if var_62_0 < arg_59_1.time_ and arg_59_1.time_ <= var_62_0 + arg_62_0 then
				arg_59_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_62_1 = 0
			local var_62_2 = 0.8

			if var_62_1 < arg_59_1.time_ and arg_59_1.time_ <= var_62_1 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				local var_62_3 = arg_59_1:FormatText(StoryNameCfg[264].name)

				arg_59_1.leftNameTxt_.text = var_62_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_4 = arg_59_1:GetWordFromCfg(115181015)
				local var_62_5 = arg_59_1:FormatText(var_62_4.content)

				arg_59_1.text_.text = var_62_5

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_6 = 32
				local var_62_7 = utf8.len(var_62_5)
				local var_62_8 = var_62_6 <= 0 and var_62_2 or var_62_2 * (var_62_7 / var_62_6)

				if var_62_8 > 0 and var_62_2 < var_62_8 then
					arg_59_1.talkMaxDuration = var_62_8

					if var_62_8 + var_62_1 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_8 + var_62_1
					end
				end

				arg_59_1.text_.text = var_62_5
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115181", "115181015", "story_v_out_115181.awb") ~= 0 then
					local var_62_9 = manager.audio:GetVoiceLength("story_v_out_115181", "115181015", "story_v_out_115181.awb") / 1000

					if var_62_9 + var_62_1 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_9 + var_62_1
					end

					if var_62_4.prefab_name ~= "" and arg_59_1.actors_[var_62_4.prefab_name] ~= nil then
						local var_62_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_4.prefab_name].transform, "story_v_out_115181", "115181015", "story_v_out_115181.awb")

						arg_59_1:RecordAudio("115181015", var_62_10)
						arg_59_1:RecordAudio("115181015", var_62_10)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_out_115181", "115181015", "story_v_out_115181.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_out_115181", "115181015", "story_v_out_115181.awb")
				end

				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_11 = math.max(var_62_2, arg_59_1.talkMaxDuration)

			if var_62_1 <= arg_59_1.time_ and arg_59_1.time_ < var_62_1 + var_62_11 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_1) / var_62_11

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_1 + var_62_11 and arg_59_1.time_ < var_62_1 + var_62_11 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {}

		arg_59_1:InitPlayNodeList()
	end,
	Play115181016 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 115181016
		arg_63_1.duration_ = 2.47

		local var_63_0 = {
			ja = 1.999999999999,
			ko = 1.999999999999,
			zh = 2.466,
			en = 1.999999999999
		}
		local var_63_1 = manager.audio:GetLocalizationFlag()

		if var_63_0[var_63_1] ~= nil then
			arg_63_1.duration_ = var_63_0[var_63_1]
		end

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play115181017(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = arg_63_1.actors_["1024ui_story"]
			local var_66_1 = 0

			if var_66_1 < arg_63_1.time_ and arg_63_1.time_ <= var_66_1 + arg_66_0 and not isNil(var_66_0) and arg_63_1.var_.characterEffect1024ui_story == nil then
				arg_63_1.var_.characterEffect1024ui_story = var_66_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_66_2 = 0.2

			if var_66_1 <= arg_63_1.time_ and arg_63_1.time_ < var_66_1 + var_66_2 and not isNil(var_66_0) then
				local var_66_3 = (arg_63_1.time_ - var_66_1) / var_66_2

				if arg_63_1.var_.characterEffect1024ui_story and not isNil(var_66_0) then
					arg_63_1.var_.characterEffect1024ui_story.fillFlat = false
				end
			end

			if arg_63_1.time_ >= var_66_1 + var_66_2 and arg_63_1.time_ < var_66_1 + var_66_2 + arg_66_0 and not isNil(var_66_0) and arg_63_1.var_.characterEffect1024ui_story then
				arg_63_1.var_.characterEffect1024ui_story.fillFlat = false
			end

			local var_66_4 = 0

			if var_66_4 < arg_63_1.time_ and arg_63_1.time_ <= var_66_4 + arg_66_0 then
				arg_63_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_66_5 = arg_63_1.actors_["10014ui_story"]
			local var_66_6 = 0

			if var_66_6 < arg_63_1.time_ and arg_63_1.time_ <= var_66_6 + arg_66_0 and not isNil(var_66_5) and arg_63_1.var_.characterEffect10014ui_story == nil then
				arg_63_1.var_.characterEffect10014ui_story = var_66_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_66_7 = 0.2

			if var_66_6 <= arg_63_1.time_ and arg_63_1.time_ < var_66_6 + var_66_7 and not isNil(var_66_5) then
				local var_66_8 = (arg_63_1.time_ - var_66_6) / var_66_7

				if arg_63_1.var_.characterEffect10014ui_story and not isNil(var_66_5) then
					local var_66_9 = Mathf.Lerp(0, 0.5, var_66_8)

					arg_63_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_63_1.var_.characterEffect10014ui_story.fillRatio = var_66_9
				end
			end

			if arg_63_1.time_ >= var_66_6 + var_66_7 and arg_63_1.time_ < var_66_6 + var_66_7 + arg_66_0 and not isNil(var_66_5) and arg_63_1.var_.characterEffect10014ui_story then
				local var_66_10 = 0.5

				arg_63_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_63_1.var_.characterEffect10014ui_story.fillRatio = var_66_10
			end

			local var_66_11 = 0
			local var_66_12 = 0.1

			if var_66_11 < arg_63_1.time_ and arg_63_1.time_ <= var_66_11 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				local var_66_13 = arg_63_1:FormatText(StoryNameCfg[265].name)

				arg_63_1.leftNameTxt_.text = var_66_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_14 = arg_63_1:GetWordFromCfg(115181016)
				local var_66_15 = arg_63_1:FormatText(var_66_14.content)

				arg_63_1.text_.text = var_66_15

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_16 = 4
				local var_66_17 = utf8.len(var_66_15)
				local var_66_18 = var_66_16 <= 0 and var_66_12 or var_66_12 * (var_66_17 / var_66_16)

				if var_66_18 > 0 and var_66_12 < var_66_18 then
					arg_63_1.talkMaxDuration = var_66_18

					if var_66_18 + var_66_11 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_18 + var_66_11
					end
				end

				arg_63_1.text_.text = var_66_15
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115181", "115181016", "story_v_out_115181.awb") ~= 0 then
					local var_66_19 = manager.audio:GetVoiceLength("story_v_out_115181", "115181016", "story_v_out_115181.awb") / 1000

					if var_66_19 + var_66_11 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_19 + var_66_11
					end

					if var_66_14.prefab_name ~= "" and arg_63_1.actors_[var_66_14.prefab_name] ~= nil then
						local var_66_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_14.prefab_name].transform, "story_v_out_115181", "115181016", "story_v_out_115181.awb")

						arg_63_1:RecordAudio("115181016", var_66_20)
						arg_63_1:RecordAudio("115181016", var_66_20)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_out_115181", "115181016", "story_v_out_115181.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_out_115181", "115181016", "story_v_out_115181.awb")
				end

				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_21 = math.max(var_66_12, arg_63_1.talkMaxDuration)

			if var_66_11 <= arg_63_1.time_ and arg_63_1.time_ < var_66_11 + var_66_21 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_11) / var_66_21

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_11 + var_66_21 and arg_63_1.time_ < var_66_11 + var_66_21 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	Play115181017 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 115181017
		arg_67_1.duration_ = 10.23

		local var_67_0 = {
			ja = 5.966,
			ko = 5.1,
			zh = 6.266,
			en = 10.233
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
				arg_67_0:Play115181018(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = arg_67_1.actors_["1024ui_story"]
			local var_70_1 = 0

			if var_70_1 < arg_67_1.time_ and arg_67_1.time_ <= var_70_1 + arg_70_0 and not isNil(var_70_0) and arg_67_1.var_.characterEffect1024ui_story == nil then
				arg_67_1.var_.characterEffect1024ui_story = var_70_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_70_2 = 0.2

			if var_70_1 <= arg_67_1.time_ and arg_67_1.time_ < var_70_1 + var_70_2 and not isNil(var_70_0) then
				local var_70_3 = (arg_67_1.time_ - var_70_1) / var_70_2

				if arg_67_1.var_.characterEffect1024ui_story and not isNil(var_70_0) then
					local var_70_4 = Mathf.Lerp(0, 0.5, var_70_3)

					arg_67_1.var_.characterEffect1024ui_story.fillFlat = true
					arg_67_1.var_.characterEffect1024ui_story.fillRatio = var_70_4
				end
			end

			if arg_67_1.time_ >= var_70_1 + var_70_2 and arg_67_1.time_ < var_70_1 + var_70_2 + arg_70_0 and not isNil(var_70_0) and arg_67_1.var_.characterEffect1024ui_story then
				local var_70_5 = 0.5

				arg_67_1.var_.characterEffect1024ui_story.fillFlat = true
				arg_67_1.var_.characterEffect1024ui_story.fillRatio = var_70_5
			end

			local var_70_6 = 0

			if var_70_6 < arg_67_1.time_ and arg_67_1.time_ <= var_70_6 + arg_70_0 then
				arg_67_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_70_7 = 0

			if var_70_7 < arg_67_1.time_ and arg_67_1.time_ <= var_70_7 + arg_70_0 then
				arg_67_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_70_8 = arg_67_1.actors_["10014ui_story"]
			local var_70_9 = 0

			if var_70_9 < arg_67_1.time_ and arg_67_1.time_ <= var_70_9 + arg_70_0 and not isNil(var_70_8) and arg_67_1.var_.characterEffect10014ui_story == nil then
				arg_67_1.var_.characterEffect10014ui_story = var_70_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_70_10 = 0.2

			if var_70_9 <= arg_67_1.time_ and arg_67_1.time_ < var_70_9 + var_70_10 and not isNil(var_70_8) then
				local var_70_11 = (arg_67_1.time_ - var_70_9) / var_70_10

				if arg_67_1.var_.characterEffect10014ui_story and not isNil(var_70_8) then
					arg_67_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_67_1.time_ >= var_70_9 + var_70_10 and arg_67_1.time_ < var_70_9 + var_70_10 + arg_70_0 and not isNil(var_70_8) and arg_67_1.var_.characterEffect10014ui_story then
				arg_67_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			local var_70_12 = 0

			if var_70_12 < arg_67_1.time_ and arg_67_1.time_ <= var_70_12 + arg_70_0 then
				arg_67_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/story10014/story10014action/10014action2_1")
			end

			local var_70_13 = 0
			local var_70_14 = 0.55

			if var_70_13 < arg_67_1.time_ and arg_67_1.time_ <= var_70_13 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				local var_70_15 = arg_67_1:FormatText(StoryNameCfg[264].name)

				arg_67_1.leftNameTxt_.text = var_70_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_16 = arg_67_1:GetWordFromCfg(115181017)
				local var_70_17 = arg_67_1:FormatText(var_70_16.content)

				arg_67_1.text_.text = var_70_17

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_18 = 22
				local var_70_19 = utf8.len(var_70_17)
				local var_70_20 = var_70_18 <= 0 and var_70_14 or var_70_14 * (var_70_19 / var_70_18)

				if var_70_20 > 0 and var_70_14 < var_70_20 then
					arg_67_1.talkMaxDuration = var_70_20

					if var_70_20 + var_70_13 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_20 + var_70_13
					end
				end

				arg_67_1.text_.text = var_70_17
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115181", "115181017", "story_v_out_115181.awb") ~= 0 then
					local var_70_21 = manager.audio:GetVoiceLength("story_v_out_115181", "115181017", "story_v_out_115181.awb") / 1000

					if var_70_21 + var_70_13 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_21 + var_70_13
					end

					if var_70_16.prefab_name ~= "" and arg_67_1.actors_[var_70_16.prefab_name] ~= nil then
						local var_70_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_16.prefab_name].transform, "story_v_out_115181", "115181017", "story_v_out_115181.awb")

						arg_67_1:RecordAudio("115181017", var_70_22)
						arg_67_1:RecordAudio("115181017", var_70_22)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_115181", "115181017", "story_v_out_115181.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_115181", "115181017", "story_v_out_115181.awb")
				end

				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_23 = math.max(var_70_14, arg_67_1.talkMaxDuration)

			if var_70_13 <= arg_67_1.time_ and arg_67_1.time_ < var_70_13 + var_70_23 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_13) / var_70_23

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_13 + var_70_23 and arg_67_1.time_ < var_70_13 + var_70_23 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {}

		arg_67_1:InitPlayNodeList()
	end,
	Play115181018 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 115181018
		arg_71_1.duration_ = 2.6

		local var_71_0 = {
			ja = 2.6,
			ko = 1.999999999999,
			zh = 1.999999999999,
			en = 1.999999999999
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
				arg_71_0:Play115181019(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = arg_71_1.actors_["1024ui_story"]
			local var_74_1 = 0

			if var_74_1 < arg_71_1.time_ and arg_71_1.time_ <= var_74_1 + arg_74_0 and not isNil(var_74_0) and arg_71_1.var_.characterEffect1024ui_story == nil then
				arg_71_1.var_.characterEffect1024ui_story = var_74_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_2 = 0.2

			if var_74_1 <= arg_71_1.time_ and arg_71_1.time_ < var_74_1 + var_74_2 and not isNil(var_74_0) then
				local var_74_3 = (arg_71_1.time_ - var_74_1) / var_74_2

				if arg_71_1.var_.characterEffect1024ui_story and not isNil(var_74_0) then
					arg_71_1.var_.characterEffect1024ui_story.fillFlat = false
				end
			end

			if arg_71_1.time_ >= var_74_1 + var_74_2 and arg_71_1.time_ < var_74_1 + var_74_2 + arg_74_0 and not isNil(var_74_0) and arg_71_1.var_.characterEffect1024ui_story then
				arg_71_1.var_.characterEffect1024ui_story.fillFlat = false
			end

			local var_74_4 = 0

			if var_74_4 < arg_71_1.time_ and arg_71_1.time_ <= var_74_4 + arg_74_0 then
				arg_71_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_74_5 = 0
			local var_74_6 = 0.175

			if var_74_5 < arg_71_1.time_ and arg_71_1.time_ <= var_74_5 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				local var_74_7 = arg_71_1:FormatText(StoryNameCfg[265].name)

				arg_71_1.leftNameTxt_.text = var_74_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_8 = arg_71_1:GetWordFromCfg(115181018)
				local var_74_9 = arg_71_1:FormatText(var_74_8.content)

				arg_71_1.text_.text = var_74_9

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_10 = 7
				local var_74_11 = utf8.len(var_74_9)
				local var_74_12 = var_74_10 <= 0 and var_74_6 or var_74_6 * (var_74_11 / var_74_10)

				if var_74_12 > 0 and var_74_6 < var_74_12 then
					arg_71_1.talkMaxDuration = var_74_12

					if var_74_12 + var_74_5 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_12 + var_74_5
					end
				end

				arg_71_1.text_.text = var_74_9
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115181", "115181018", "story_v_out_115181.awb") ~= 0 then
					local var_74_13 = manager.audio:GetVoiceLength("story_v_out_115181", "115181018", "story_v_out_115181.awb") / 1000

					if var_74_13 + var_74_5 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_13 + var_74_5
					end

					if var_74_8.prefab_name ~= "" and arg_71_1.actors_[var_74_8.prefab_name] ~= nil then
						local var_74_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_8.prefab_name].transform, "story_v_out_115181", "115181018", "story_v_out_115181.awb")

						arg_71_1:RecordAudio("115181018", var_74_14)
						arg_71_1:RecordAudio("115181018", var_74_14)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_115181", "115181018", "story_v_out_115181.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_115181", "115181018", "story_v_out_115181.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_15 = math.max(var_74_6, arg_71_1.talkMaxDuration)

			if var_74_5 <= arg_71_1.time_ and arg_71_1.time_ < var_74_5 + var_74_15 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_5) / var_74_15

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_5 + var_74_15 and arg_71_1.time_ < var_74_5 + var_74_15 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {}

		arg_71_1:InitPlayNodeList()
	end,
	Play115181019 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 115181019
		arg_75_1.duration_ = 11.47

		local var_75_0 = {
			ja = 11.466,
			ko = 10.2,
			zh = 8.066,
			en = 10.966
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
				arg_75_0:Play115181020(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = arg_75_1.actors_["1024ui_story"]
			local var_78_1 = 0

			if var_78_1 < arg_75_1.time_ and arg_75_1.time_ <= var_78_1 + arg_78_0 and not isNil(var_78_0) and arg_75_1.var_.characterEffect1024ui_story == nil then
				arg_75_1.var_.characterEffect1024ui_story = var_78_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_78_2 = 0.2

			if var_78_1 <= arg_75_1.time_ and arg_75_1.time_ < var_78_1 + var_78_2 and not isNil(var_78_0) then
				local var_78_3 = (arg_75_1.time_ - var_78_1) / var_78_2

				if arg_75_1.var_.characterEffect1024ui_story and not isNil(var_78_0) then
					local var_78_4 = Mathf.Lerp(0, 0.5, var_78_3)

					arg_75_1.var_.characterEffect1024ui_story.fillFlat = true
					arg_75_1.var_.characterEffect1024ui_story.fillRatio = var_78_4
				end
			end

			if arg_75_1.time_ >= var_78_1 + var_78_2 and arg_75_1.time_ < var_78_1 + var_78_2 + arg_78_0 and not isNil(var_78_0) and arg_75_1.var_.characterEffect1024ui_story then
				local var_78_5 = 0.5

				arg_75_1.var_.characterEffect1024ui_story.fillFlat = true
				arg_75_1.var_.characterEffect1024ui_story.fillRatio = var_78_5
			end

			local var_78_6 = 0

			if var_78_6 < arg_75_1.time_ and arg_75_1.time_ <= var_78_6 + arg_78_0 then
				arg_75_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_78_7 = arg_75_1.actors_["10014ui_story"]
			local var_78_8 = 0

			if var_78_8 < arg_75_1.time_ and arg_75_1.time_ <= var_78_8 + arg_78_0 and not isNil(var_78_7) and arg_75_1.var_.characterEffect10014ui_story == nil then
				arg_75_1.var_.characterEffect10014ui_story = var_78_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_78_9 = 0.2

			if var_78_8 <= arg_75_1.time_ and arg_75_1.time_ < var_78_8 + var_78_9 and not isNil(var_78_7) then
				local var_78_10 = (arg_75_1.time_ - var_78_8) / var_78_9

				if arg_75_1.var_.characterEffect10014ui_story and not isNil(var_78_7) then
					arg_75_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_75_1.time_ >= var_78_8 + var_78_9 and arg_75_1.time_ < var_78_8 + var_78_9 + arg_78_0 and not isNil(var_78_7) and arg_75_1.var_.characterEffect10014ui_story then
				arg_75_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			local var_78_11 = 0
			local var_78_12 = 1

			if var_78_11 < arg_75_1.time_ and arg_75_1.time_ <= var_78_11 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				local var_78_13 = arg_75_1:FormatText(StoryNameCfg[264].name)

				arg_75_1.leftNameTxt_.text = var_78_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_14 = arg_75_1:GetWordFromCfg(115181019)
				local var_78_15 = arg_75_1:FormatText(var_78_14.content)

				arg_75_1.text_.text = var_78_15

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_16 = 40
				local var_78_17 = utf8.len(var_78_15)
				local var_78_18 = var_78_16 <= 0 and var_78_12 or var_78_12 * (var_78_17 / var_78_16)

				if var_78_18 > 0 and var_78_12 < var_78_18 then
					arg_75_1.talkMaxDuration = var_78_18

					if var_78_18 + var_78_11 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_18 + var_78_11
					end
				end

				arg_75_1.text_.text = var_78_15
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115181", "115181019", "story_v_out_115181.awb") ~= 0 then
					local var_78_19 = manager.audio:GetVoiceLength("story_v_out_115181", "115181019", "story_v_out_115181.awb") / 1000

					if var_78_19 + var_78_11 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_19 + var_78_11
					end

					if var_78_14.prefab_name ~= "" and arg_75_1.actors_[var_78_14.prefab_name] ~= nil then
						local var_78_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_14.prefab_name].transform, "story_v_out_115181", "115181019", "story_v_out_115181.awb")

						arg_75_1:RecordAudio("115181019", var_78_20)
						arg_75_1:RecordAudio("115181019", var_78_20)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_out_115181", "115181019", "story_v_out_115181.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_out_115181", "115181019", "story_v_out_115181.awb")
				end

				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_21 = math.max(var_78_12, arg_75_1.talkMaxDuration)

			if var_78_11 <= arg_75_1.time_ and arg_75_1.time_ < var_78_11 + var_78_21 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_11) / var_78_21

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_11 + var_78_21 and arg_75_1.time_ < var_78_11 + var_78_21 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play115181020 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 115181020
		arg_79_1.duration_ = 10.97

		local var_79_0 = {
			ja = 10.966,
			ko = 8.1,
			zh = 8.2,
			en = 8.966
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
				arg_79_0:Play115181021(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = 0

			if var_82_0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_0 + arg_82_0 then
				arg_79_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_82_1 = 0
			local var_82_2 = 0.95

			if var_82_1 < arg_79_1.time_ and arg_79_1.time_ <= var_82_1 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				local var_82_3 = arg_79_1:FormatText(StoryNameCfg[264].name)

				arg_79_1.leftNameTxt_.text = var_82_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_4 = arg_79_1:GetWordFromCfg(115181020)
				local var_82_5 = arg_79_1:FormatText(var_82_4.content)

				arg_79_1.text_.text = var_82_5

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_6 = 38
				local var_82_7 = utf8.len(var_82_5)
				local var_82_8 = var_82_6 <= 0 and var_82_2 or var_82_2 * (var_82_7 / var_82_6)

				if var_82_8 > 0 and var_82_2 < var_82_8 then
					arg_79_1.talkMaxDuration = var_82_8

					if var_82_8 + var_82_1 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_8 + var_82_1
					end
				end

				arg_79_1.text_.text = var_82_5
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115181", "115181020", "story_v_out_115181.awb") ~= 0 then
					local var_82_9 = manager.audio:GetVoiceLength("story_v_out_115181", "115181020", "story_v_out_115181.awb") / 1000

					if var_82_9 + var_82_1 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_9 + var_82_1
					end

					if var_82_4.prefab_name ~= "" and arg_79_1.actors_[var_82_4.prefab_name] ~= nil then
						local var_82_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_4.prefab_name].transform, "story_v_out_115181", "115181020", "story_v_out_115181.awb")

						arg_79_1:RecordAudio("115181020", var_82_10)
						arg_79_1:RecordAudio("115181020", var_82_10)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_out_115181", "115181020", "story_v_out_115181.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_out_115181", "115181020", "story_v_out_115181.awb")
				end

				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_11 = math.max(var_82_2, arg_79_1.talkMaxDuration)

			if var_82_1 <= arg_79_1.time_ and arg_79_1.time_ < var_82_1 + var_82_11 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_1) / var_82_11

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_1 + var_82_11 and arg_79_1.time_ < var_82_1 + var_82_11 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play115181021 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 115181021
		arg_83_1.duration_ = 4.17

		local var_83_0 = {
			ja = 2.6,
			ko = 4.166,
			zh = 2.766,
			en = 1.999999999999
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
				arg_83_0:Play115181022(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = arg_83_1.actors_["1024ui_story"]
			local var_86_1 = 0

			if var_86_1 < arg_83_1.time_ and arg_83_1.time_ <= var_86_1 + arg_86_0 and not isNil(var_86_0) and arg_83_1.var_.characterEffect1024ui_story == nil then
				arg_83_1.var_.characterEffect1024ui_story = var_86_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_86_2 = 0.2

			if var_86_1 <= arg_83_1.time_ and arg_83_1.time_ < var_86_1 + var_86_2 and not isNil(var_86_0) then
				local var_86_3 = (arg_83_1.time_ - var_86_1) / var_86_2

				if arg_83_1.var_.characterEffect1024ui_story and not isNil(var_86_0) then
					arg_83_1.var_.characterEffect1024ui_story.fillFlat = false
				end
			end

			if arg_83_1.time_ >= var_86_1 + var_86_2 and arg_83_1.time_ < var_86_1 + var_86_2 + arg_86_0 and not isNil(var_86_0) and arg_83_1.var_.characterEffect1024ui_story then
				arg_83_1.var_.characterEffect1024ui_story.fillFlat = false
			end

			local var_86_4 = 0

			if var_86_4 < arg_83_1.time_ and arg_83_1.time_ <= var_86_4 + arg_86_0 then
				arg_83_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_86_5 = arg_83_1.actors_["10014ui_story"]
			local var_86_6 = 0

			if var_86_6 < arg_83_1.time_ and arg_83_1.time_ <= var_86_6 + arg_86_0 and not isNil(var_86_5) and arg_83_1.var_.characterEffect10014ui_story == nil then
				arg_83_1.var_.characterEffect10014ui_story = var_86_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_86_7 = 0.2

			if var_86_6 <= arg_83_1.time_ and arg_83_1.time_ < var_86_6 + var_86_7 and not isNil(var_86_5) then
				local var_86_8 = (arg_83_1.time_ - var_86_6) / var_86_7

				if arg_83_1.var_.characterEffect10014ui_story and not isNil(var_86_5) then
					local var_86_9 = Mathf.Lerp(0, 0.5, var_86_8)

					arg_83_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_83_1.var_.characterEffect10014ui_story.fillRatio = var_86_9
				end
			end

			if arg_83_1.time_ >= var_86_6 + var_86_7 and arg_83_1.time_ < var_86_6 + var_86_7 + arg_86_0 and not isNil(var_86_5) and arg_83_1.var_.characterEffect10014ui_story then
				local var_86_10 = 0.5

				arg_83_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_83_1.var_.characterEffect10014ui_story.fillRatio = var_86_10
			end

			local var_86_11 = 0
			local var_86_12 = 0.35

			if var_86_11 < arg_83_1.time_ and arg_83_1.time_ <= var_86_11 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				local var_86_13 = arg_83_1:FormatText(StoryNameCfg[265].name)

				arg_83_1.leftNameTxt_.text = var_86_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_14 = arg_83_1:GetWordFromCfg(115181021)
				local var_86_15 = arg_83_1:FormatText(var_86_14.content)

				arg_83_1.text_.text = var_86_15

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_16 = 14
				local var_86_17 = utf8.len(var_86_15)
				local var_86_18 = var_86_16 <= 0 and var_86_12 or var_86_12 * (var_86_17 / var_86_16)

				if var_86_18 > 0 and var_86_12 < var_86_18 then
					arg_83_1.talkMaxDuration = var_86_18

					if var_86_18 + var_86_11 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_18 + var_86_11
					end
				end

				arg_83_1.text_.text = var_86_15
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115181", "115181021", "story_v_out_115181.awb") ~= 0 then
					local var_86_19 = manager.audio:GetVoiceLength("story_v_out_115181", "115181021", "story_v_out_115181.awb") / 1000

					if var_86_19 + var_86_11 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_19 + var_86_11
					end

					if var_86_14.prefab_name ~= "" and arg_83_1.actors_[var_86_14.prefab_name] ~= nil then
						local var_86_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_14.prefab_name].transform, "story_v_out_115181", "115181021", "story_v_out_115181.awb")

						arg_83_1:RecordAudio("115181021", var_86_20)
						arg_83_1:RecordAudio("115181021", var_86_20)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_out_115181", "115181021", "story_v_out_115181.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_out_115181", "115181021", "story_v_out_115181.awb")
				end

				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_21 = math.max(var_86_12, arg_83_1.talkMaxDuration)

			if var_86_11 <= arg_83_1.time_ and arg_83_1.time_ < var_86_11 + var_86_21 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_11) / var_86_21

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_11 + var_86_21 and arg_83_1.time_ < var_86_11 + var_86_21 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play115181022 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 115181022
		arg_87_1.duration_ = 3.7

		local var_87_0 = {
			ja = 3.7,
			ko = 2.5,
			zh = 2.5,
			en = 3.633
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
				arg_87_0:Play115181023(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = arg_87_1.actors_["1017ui_story"].transform
			local var_90_1 = 0

			if var_90_1 < arg_87_1.time_ and arg_87_1.time_ <= var_90_1 + arg_90_0 then
				arg_87_1.var_.moveOldPos1017ui_story = var_90_0.localPosition
			end

			local var_90_2 = 0.001

			if var_90_1 <= arg_87_1.time_ and arg_87_1.time_ < var_90_1 + var_90_2 then
				local var_90_3 = (arg_87_1.time_ - var_90_1) / var_90_2
				local var_90_4 = Vector3.New(0.7, -1.01, -6.05)

				var_90_0.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos1017ui_story, var_90_4, var_90_3)

				local var_90_5 = manager.ui.mainCamera.transform.position - var_90_0.position

				var_90_0.forward = Vector3.New(var_90_5.x, var_90_5.y, var_90_5.z)

				local var_90_6 = var_90_0.localEulerAngles

				var_90_6.z = 0
				var_90_6.x = 0
				var_90_0.localEulerAngles = var_90_6
			end

			if arg_87_1.time_ >= var_90_1 + var_90_2 and arg_87_1.time_ < var_90_1 + var_90_2 + arg_90_0 then
				var_90_0.localPosition = Vector3.New(0.7, -1.01, -6.05)

				local var_90_7 = manager.ui.mainCamera.transform.position - var_90_0.position

				var_90_0.forward = Vector3.New(var_90_7.x, var_90_7.y, var_90_7.z)

				local var_90_8 = var_90_0.localEulerAngles

				var_90_8.z = 0
				var_90_8.x = 0
				var_90_0.localEulerAngles = var_90_8
			end

			local var_90_9 = 0

			if var_90_9 < arg_87_1.time_ and arg_87_1.time_ <= var_90_9 + arg_90_0 then
				arg_87_1:PlayTimeline("1017ui_story", "StoryTimeline/CharAction/story1017/story1017action/1017action3_1")
			end

			local var_90_10 = arg_87_1.actors_["1017ui_story"]
			local var_90_11 = 0

			if var_90_11 < arg_87_1.time_ and arg_87_1.time_ <= var_90_11 + arg_90_0 and not isNil(var_90_10) and arg_87_1.var_.characterEffect1017ui_story == nil then
				arg_87_1.var_.characterEffect1017ui_story = var_90_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_12 = 0.2

			if var_90_11 <= arg_87_1.time_ and arg_87_1.time_ < var_90_11 + var_90_12 and not isNil(var_90_10) then
				local var_90_13 = (arg_87_1.time_ - var_90_11) / var_90_12

				if arg_87_1.var_.characterEffect1017ui_story and not isNil(var_90_10) then
					arg_87_1.var_.characterEffect1017ui_story.fillFlat = false
				end
			end

			if arg_87_1.time_ >= var_90_11 + var_90_12 and arg_87_1.time_ < var_90_11 + var_90_12 + arg_90_0 and not isNil(var_90_10) and arg_87_1.var_.characterEffect1017ui_story then
				arg_87_1.var_.characterEffect1017ui_story.fillFlat = false
			end

			local var_90_14 = arg_87_1.actors_["1024ui_story"]
			local var_90_15 = 0

			if var_90_15 < arg_87_1.time_ and arg_87_1.time_ <= var_90_15 + arg_90_0 and not isNil(var_90_14) and arg_87_1.var_.characterEffect1024ui_story == nil then
				arg_87_1.var_.characterEffect1024ui_story = var_90_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_16 = 0.2

			if var_90_15 <= arg_87_1.time_ and arg_87_1.time_ < var_90_15 + var_90_16 and not isNil(var_90_14) then
				local var_90_17 = (arg_87_1.time_ - var_90_15) / var_90_16

				if arg_87_1.var_.characterEffect1024ui_story and not isNil(var_90_14) then
					local var_90_18 = Mathf.Lerp(0, 0.5, var_90_17)

					arg_87_1.var_.characterEffect1024ui_story.fillFlat = true
					arg_87_1.var_.characterEffect1024ui_story.fillRatio = var_90_18
				end
			end

			if arg_87_1.time_ >= var_90_15 + var_90_16 and arg_87_1.time_ < var_90_15 + var_90_16 + arg_90_0 and not isNil(var_90_14) and arg_87_1.var_.characterEffect1024ui_story then
				local var_90_19 = 0.5

				arg_87_1.var_.characterEffect1024ui_story.fillFlat = true
				arg_87_1.var_.characterEffect1024ui_story.fillRatio = var_90_19
			end

			local var_90_20 = 0

			if var_90_20 < arg_87_1.time_ and arg_87_1.time_ <= var_90_20 + arg_90_0 then
				arg_87_1:PlayTimeline("1017ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_90_21 = arg_87_1.actors_["1024ui_story"].transform
			local var_90_22 = 0

			if var_90_22 < arg_87_1.time_ and arg_87_1.time_ <= var_90_22 + arg_90_0 then
				arg_87_1.var_.moveOldPos1024ui_story = var_90_21.localPosition
			end

			local var_90_23 = 0.001

			if var_90_22 <= arg_87_1.time_ and arg_87_1.time_ < var_90_22 + var_90_23 then
				local var_90_24 = (arg_87_1.time_ - var_90_22) / var_90_23
				local var_90_25 = Vector3.New(0, 100, 0)

				var_90_21.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos1024ui_story, var_90_25, var_90_24)

				local var_90_26 = manager.ui.mainCamera.transform.position - var_90_21.position

				var_90_21.forward = Vector3.New(var_90_26.x, var_90_26.y, var_90_26.z)

				local var_90_27 = var_90_21.localEulerAngles

				var_90_27.z = 0
				var_90_27.x = 0
				var_90_21.localEulerAngles = var_90_27
			end

			if arg_87_1.time_ >= var_90_22 + var_90_23 and arg_87_1.time_ < var_90_22 + var_90_23 + arg_90_0 then
				var_90_21.localPosition = Vector3.New(0, 100, 0)

				local var_90_28 = manager.ui.mainCamera.transform.position - var_90_21.position

				var_90_21.forward = Vector3.New(var_90_28.x, var_90_28.y, var_90_28.z)

				local var_90_29 = var_90_21.localEulerAngles

				var_90_29.z = 0
				var_90_29.x = 0
				var_90_21.localEulerAngles = var_90_29
			end

			local var_90_30 = 0
			local var_90_31 = 0.3

			if var_90_30 < arg_87_1.time_ and arg_87_1.time_ <= var_90_30 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				local var_90_32 = arg_87_1:FormatText(StoryNameCfg[273].name)

				arg_87_1.leftNameTxt_.text = var_90_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_33 = arg_87_1:GetWordFromCfg(115181022)
				local var_90_34 = arg_87_1:FormatText(var_90_33.content)

				arg_87_1.text_.text = var_90_34

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_35 = 12
				local var_90_36 = utf8.len(var_90_34)
				local var_90_37 = var_90_35 <= 0 and var_90_31 or var_90_31 * (var_90_36 / var_90_35)

				if var_90_37 > 0 and var_90_31 < var_90_37 then
					arg_87_1.talkMaxDuration = var_90_37

					if var_90_37 + var_90_30 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_37 + var_90_30
					end
				end

				arg_87_1.text_.text = var_90_34
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115181", "115181022", "story_v_out_115181.awb") ~= 0 then
					local var_90_38 = manager.audio:GetVoiceLength("story_v_out_115181", "115181022", "story_v_out_115181.awb") / 1000

					if var_90_38 + var_90_30 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_38 + var_90_30
					end

					if var_90_33.prefab_name ~= "" and arg_87_1.actors_[var_90_33.prefab_name] ~= nil then
						local var_90_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_33.prefab_name].transform, "story_v_out_115181", "115181022", "story_v_out_115181.awb")

						arg_87_1:RecordAudio("115181022", var_90_39)
						arg_87_1:RecordAudio("115181022", var_90_39)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_115181", "115181022", "story_v_out_115181.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_115181", "115181022", "story_v_out_115181.awb")
				end

				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_40 = math.max(var_90_31, arg_87_1.talkMaxDuration)

			if var_90_30 <= arg_87_1.time_ and arg_87_1.time_ < var_90_30 + var_90_40 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_30) / var_90_40

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_30 + var_90_40 and arg_87_1.time_ < var_90_30 + var_90_40 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1017ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_87_1:InitPlayNodeList()
	end,
	Play115181023 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 115181023
		arg_91_1.duration_ = 11.73

		local var_91_0 = {
			ja = 11.733,
			ko = 7.766,
			zh = 8.033,
			en = 8.333
		}
		local var_91_1 = manager.audio:GetLocalizationFlag()

		if var_91_0[var_91_1] ~= nil then
			arg_91_1.duration_ = var_91_0[var_91_1]
		end

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play115181024(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			local var_94_0 = arg_91_1.actors_["1017ui_story"]
			local var_94_1 = 0

			if var_94_1 < arg_91_1.time_ and arg_91_1.time_ <= var_94_1 + arg_94_0 and not isNil(var_94_0) and arg_91_1.var_.characterEffect1017ui_story == nil then
				arg_91_1.var_.characterEffect1017ui_story = var_94_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_94_2 = 0.2

			if var_94_1 <= arg_91_1.time_ and arg_91_1.time_ < var_94_1 + var_94_2 and not isNil(var_94_0) then
				local var_94_3 = (arg_91_1.time_ - var_94_1) / var_94_2

				if arg_91_1.var_.characterEffect1017ui_story and not isNil(var_94_0) then
					local var_94_4 = Mathf.Lerp(0, 0.5, var_94_3)

					arg_91_1.var_.characterEffect1017ui_story.fillFlat = true
					arg_91_1.var_.characterEffect1017ui_story.fillRatio = var_94_4
				end
			end

			if arg_91_1.time_ >= var_94_1 + var_94_2 and arg_91_1.time_ < var_94_1 + var_94_2 + arg_94_0 and not isNil(var_94_0) and arg_91_1.var_.characterEffect1017ui_story then
				local var_94_5 = 0.5

				arg_91_1.var_.characterEffect1017ui_story.fillFlat = true
				arg_91_1.var_.characterEffect1017ui_story.fillRatio = var_94_5
			end

			local var_94_6 = 0

			if var_94_6 < arg_91_1.time_ and arg_91_1.time_ <= var_94_6 + arg_94_0 then
				arg_91_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_94_7 = arg_91_1.actors_["10014ui_story"]
			local var_94_8 = 0

			if var_94_8 < arg_91_1.time_ and arg_91_1.time_ <= var_94_8 + arg_94_0 and not isNil(var_94_7) and arg_91_1.var_.characterEffect10014ui_story == nil then
				arg_91_1.var_.characterEffect10014ui_story = var_94_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_94_9 = 0.2

			if var_94_8 <= arg_91_1.time_ and arg_91_1.time_ < var_94_8 + var_94_9 and not isNil(var_94_7) then
				local var_94_10 = (arg_91_1.time_ - var_94_8) / var_94_9

				if arg_91_1.var_.characterEffect10014ui_story and not isNil(var_94_7) then
					arg_91_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_91_1.time_ >= var_94_8 + var_94_9 and arg_91_1.time_ < var_94_8 + var_94_9 + arg_94_0 and not isNil(var_94_7) and arg_91_1.var_.characterEffect10014ui_story then
				arg_91_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			local var_94_11 = 0
			local var_94_12 = 0.875

			if var_94_11 < arg_91_1.time_ and arg_91_1.time_ <= var_94_11 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				local var_94_13 = arg_91_1:FormatText(StoryNameCfg[264].name)

				arg_91_1.leftNameTxt_.text = var_94_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_14 = arg_91_1:GetWordFromCfg(115181023)
				local var_94_15 = arg_91_1:FormatText(var_94_14.content)

				arg_91_1.text_.text = var_94_15

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_16 = 35
				local var_94_17 = utf8.len(var_94_15)
				local var_94_18 = var_94_16 <= 0 and var_94_12 or var_94_12 * (var_94_17 / var_94_16)

				if var_94_18 > 0 and var_94_12 < var_94_18 then
					arg_91_1.talkMaxDuration = var_94_18

					if var_94_18 + var_94_11 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_18 + var_94_11
					end
				end

				arg_91_1.text_.text = var_94_15
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115181", "115181023", "story_v_out_115181.awb") ~= 0 then
					local var_94_19 = manager.audio:GetVoiceLength("story_v_out_115181", "115181023", "story_v_out_115181.awb") / 1000

					if var_94_19 + var_94_11 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_19 + var_94_11
					end

					if var_94_14.prefab_name ~= "" and arg_91_1.actors_[var_94_14.prefab_name] ~= nil then
						local var_94_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_14.prefab_name].transform, "story_v_out_115181", "115181023", "story_v_out_115181.awb")

						arg_91_1:RecordAudio("115181023", var_94_20)
						arg_91_1:RecordAudio("115181023", var_94_20)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_out_115181", "115181023", "story_v_out_115181.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_out_115181", "115181023", "story_v_out_115181.awb")
				end

				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_21 = math.max(var_94_12, arg_91_1.talkMaxDuration)

			if var_94_11 <= arg_91_1.time_ and arg_91_1.time_ < var_94_11 + var_94_21 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_11) / var_94_21

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_11 + var_94_21 and arg_91_1.time_ < var_94_11 + var_94_21 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {}

		arg_91_1:InitPlayNodeList()
	end,
	Play115181024 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 115181024
		arg_95_1.duration_ = 14.07

		local var_95_0 = {
			ja = 14.066,
			ko = 9,
			zh = 7.7,
			en = 9.466
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
				arg_95_0:Play115181025(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			local var_98_0 = 0

			if var_98_0 < arg_95_1.time_ and arg_95_1.time_ <= var_98_0 + arg_98_0 then
				arg_95_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_98_1 = 0
			local var_98_2 = 0.875

			if var_98_1 < arg_95_1.time_ and arg_95_1.time_ <= var_98_1 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				local var_98_3 = arg_95_1:FormatText(StoryNameCfg[264].name)

				arg_95_1.leftNameTxt_.text = var_98_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_4 = arg_95_1:GetWordFromCfg(115181024)
				local var_98_5 = arg_95_1:FormatText(var_98_4.content)

				arg_95_1.text_.text = var_98_5

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_6 = 35
				local var_98_7 = utf8.len(var_98_5)
				local var_98_8 = var_98_6 <= 0 and var_98_2 or var_98_2 * (var_98_7 / var_98_6)

				if var_98_8 > 0 and var_98_2 < var_98_8 then
					arg_95_1.talkMaxDuration = var_98_8

					if var_98_8 + var_98_1 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_8 + var_98_1
					end
				end

				arg_95_1.text_.text = var_98_5
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115181", "115181024", "story_v_out_115181.awb") ~= 0 then
					local var_98_9 = manager.audio:GetVoiceLength("story_v_out_115181", "115181024", "story_v_out_115181.awb") / 1000

					if var_98_9 + var_98_1 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_9 + var_98_1
					end

					if var_98_4.prefab_name ~= "" and arg_95_1.actors_[var_98_4.prefab_name] ~= nil then
						local var_98_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_95_1.actors_[var_98_4.prefab_name].transform, "story_v_out_115181", "115181024", "story_v_out_115181.awb")

						arg_95_1:RecordAudio("115181024", var_98_10)
						arg_95_1:RecordAudio("115181024", var_98_10)
					else
						arg_95_1:AudioAction("play", "voice", "story_v_out_115181", "115181024", "story_v_out_115181.awb")
					end

					arg_95_1:RecordHistoryTalkVoice("story_v_out_115181", "115181024", "story_v_out_115181.awb")
				end

				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_11 = math.max(var_98_2, arg_95_1.talkMaxDuration)

			if var_98_1 <= arg_95_1.time_ and arg_95_1.time_ < var_98_1 + var_98_11 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_1) / var_98_11

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_1 + var_98_11 and arg_95_1.time_ < var_98_1 + var_98_11 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {}

		arg_95_1:InitPlayNodeList()
	end,
	Play115181025 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 115181025
		arg_99_1.duration_ = 5.47

		local var_99_0 = {
			ja = 5.466,
			ko = 3.566,
			zh = 2,
			en = 2.333
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
				arg_99_0:Play115181026(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = arg_99_1.actors_["1024ui_story"]
			local var_102_1 = 0

			if var_102_1 < arg_99_1.time_ and arg_99_1.time_ <= var_102_1 + arg_102_0 and not isNil(var_102_0) and arg_99_1.var_.characterEffect1024ui_story == nil then
				arg_99_1.var_.characterEffect1024ui_story = var_102_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_102_2 = 0.2

			if var_102_1 <= arg_99_1.time_ and arg_99_1.time_ < var_102_1 + var_102_2 and not isNil(var_102_0) then
				local var_102_3 = (arg_99_1.time_ - var_102_1) / var_102_2

				if arg_99_1.var_.characterEffect1024ui_story and not isNil(var_102_0) then
					arg_99_1.var_.characterEffect1024ui_story.fillFlat = false
				end
			end

			if arg_99_1.time_ >= var_102_1 + var_102_2 and arg_99_1.time_ < var_102_1 + var_102_2 + arg_102_0 and not isNil(var_102_0) and arg_99_1.var_.characterEffect1024ui_story then
				arg_99_1.var_.characterEffect1024ui_story.fillFlat = false
			end

			local var_102_4 = 0

			if var_102_4 < arg_99_1.time_ and arg_99_1.time_ <= var_102_4 + arg_102_0 then
				arg_99_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_102_5 = arg_99_1.actors_["1017ui_story"].transform
			local var_102_6 = 0

			if var_102_6 < arg_99_1.time_ and arg_99_1.time_ <= var_102_6 + arg_102_0 then
				arg_99_1.var_.moveOldPos1017ui_story = var_102_5.localPosition
			end

			local var_102_7 = 0.001

			if var_102_6 <= arg_99_1.time_ and arg_99_1.time_ < var_102_6 + var_102_7 then
				local var_102_8 = (arg_99_1.time_ - var_102_6) / var_102_7
				local var_102_9 = Vector3.New(0, 100, 0)

				var_102_5.localPosition = Vector3.Lerp(arg_99_1.var_.moveOldPos1017ui_story, var_102_9, var_102_8)

				local var_102_10 = manager.ui.mainCamera.transform.position - var_102_5.position

				var_102_5.forward = Vector3.New(var_102_10.x, var_102_10.y, var_102_10.z)

				local var_102_11 = var_102_5.localEulerAngles

				var_102_11.z = 0
				var_102_11.x = 0
				var_102_5.localEulerAngles = var_102_11
			end

			if arg_99_1.time_ >= var_102_6 + var_102_7 and arg_99_1.time_ < var_102_6 + var_102_7 + arg_102_0 then
				var_102_5.localPosition = Vector3.New(0, 100, 0)

				local var_102_12 = manager.ui.mainCamera.transform.position - var_102_5.position

				var_102_5.forward = Vector3.New(var_102_12.x, var_102_12.y, var_102_12.z)

				local var_102_13 = var_102_5.localEulerAngles

				var_102_13.z = 0
				var_102_13.x = 0
				var_102_5.localEulerAngles = var_102_13
			end

			local var_102_14 = arg_99_1.actors_["1024ui_story"].transform
			local var_102_15 = 0

			if var_102_15 < arg_99_1.time_ and arg_99_1.time_ <= var_102_15 + arg_102_0 then
				arg_99_1.var_.moveOldPos1024ui_story = var_102_14.localPosition
			end

			local var_102_16 = 0.001

			if var_102_15 <= arg_99_1.time_ and arg_99_1.time_ < var_102_15 + var_102_16 then
				local var_102_17 = (arg_99_1.time_ - var_102_15) / var_102_16
				local var_102_18 = Vector3.New(0.7, -1, -6.05)

				var_102_14.localPosition = Vector3.Lerp(arg_99_1.var_.moveOldPos1024ui_story, var_102_18, var_102_17)

				local var_102_19 = manager.ui.mainCamera.transform.position - var_102_14.position

				var_102_14.forward = Vector3.New(var_102_19.x, var_102_19.y, var_102_19.z)

				local var_102_20 = var_102_14.localEulerAngles

				var_102_20.z = 0
				var_102_20.x = 0
				var_102_14.localEulerAngles = var_102_20
			end

			if arg_99_1.time_ >= var_102_15 + var_102_16 and arg_99_1.time_ < var_102_15 + var_102_16 + arg_102_0 then
				var_102_14.localPosition = Vector3.New(0.7, -1, -6.05)

				local var_102_21 = manager.ui.mainCamera.transform.position - var_102_14.position

				var_102_14.forward = Vector3.New(var_102_21.x, var_102_21.y, var_102_21.z)

				local var_102_22 = var_102_14.localEulerAngles

				var_102_22.z = 0
				var_102_22.x = 0
				var_102_14.localEulerAngles = var_102_22
			end

			local var_102_23 = arg_99_1.actors_["10014ui_story"]
			local var_102_24 = 0

			if var_102_24 < arg_99_1.time_ and arg_99_1.time_ <= var_102_24 + arg_102_0 and not isNil(var_102_23) and arg_99_1.var_.characterEffect10014ui_story == nil then
				arg_99_1.var_.characterEffect10014ui_story = var_102_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_102_25 = 0.2

			if var_102_24 <= arg_99_1.time_ and arg_99_1.time_ < var_102_24 + var_102_25 and not isNil(var_102_23) then
				local var_102_26 = (arg_99_1.time_ - var_102_24) / var_102_25

				if arg_99_1.var_.characterEffect10014ui_story and not isNil(var_102_23) then
					local var_102_27 = Mathf.Lerp(0, 0.5, var_102_26)

					arg_99_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_99_1.var_.characterEffect10014ui_story.fillRatio = var_102_27
				end
			end

			if arg_99_1.time_ >= var_102_24 + var_102_25 and arg_99_1.time_ < var_102_24 + var_102_25 + arg_102_0 and not isNil(var_102_23) and arg_99_1.var_.characterEffect10014ui_story then
				local var_102_28 = 0.5

				arg_99_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_99_1.var_.characterEffect10014ui_story.fillRatio = var_102_28
			end

			local var_102_29 = 0
			local var_102_30 = 0.325

			if var_102_29 < arg_99_1.time_ and arg_99_1.time_ <= var_102_29 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				local var_102_31 = arg_99_1:FormatText(StoryNameCfg[265].name)

				arg_99_1.leftNameTxt_.text = var_102_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_32 = arg_99_1:GetWordFromCfg(115181025)
				local var_102_33 = arg_99_1:FormatText(var_102_32.content)

				arg_99_1.text_.text = var_102_33

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_34 = 13
				local var_102_35 = utf8.len(var_102_33)
				local var_102_36 = var_102_34 <= 0 and var_102_30 or var_102_30 * (var_102_35 / var_102_34)

				if var_102_36 > 0 and var_102_30 < var_102_36 then
					arg_99_1.talkMaxDuration = var_102_36

					if var_102_36 + var_102_29 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_36 + var_102_29
					end
				end

				arg_99_1.text_.text = var_102_33
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115181", "115181025", "story_v_out_115181.awb") ~= 0 then
					local var_102_37 = manager.audio:GetVoiceLength("story_v_out_115181", "115181025", "story_v_out_115181.awb") / 1000

					if var_102_37 + var_102_29 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_37 + var_102_29
					end

					if var_102_32.prefab_name ~= "" and arg_99_1.actors_[var_102_32.prefab_name] ~= nil then
						local var_102_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_99_1.actors_[var_102_32.prefab_name].transform, "story_v_out_115181", "115181025", "story_v_out_115181.awb")

						arg_99_1:RecordAudio("115181025", var_102_38)
						arg_99_1:RecordAudio("115181025", var_102_38)
					else
						arg_99_1:AudioAction("play", "voice", "story_v_out_115181", "115181025", "story_v_out_115181.awb")
					end

					arg_99_1:RecordHistoryTalkVoice("story_v_out_115181", "115181025", "story_v_out_115181.awb")
				end

				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_39 = math.max(var_102_30, arg_99_1.talkMaxDuration)

			if var_102_29 <= arg_99_1.time_ and arg_99_1.time_ < var_102_29 + var_102_39 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_29) / var_102_39

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_29 + var_102_39 and arg_99_1.time_ < var_102_29 + var_102_39 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1017ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1024ui_story",
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
	Play115181026 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 115181026
		arg_103_1.duration_ = 14.27

		local var_103_0 = {
			ja = 14.266,
			ko = 7.966,
			zh = 7.733,
			en = 10.266
		}
		local var_103_1 = manager.audio:GetLocalizationFlag()

		if var_103_0[var_103_1] ~= nil then
			arg_103_1.duration_ = var_103_0[var_103_1]
		end

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play115181027(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			local var_106_0 = arg_103_1.actors_["1024ui_story"]
			local var_106_1 = 0

			if var_106_1 < arg_103_1.time_ and arg_103_1.time_ <= var_106_1 + arg_106_0 and not isNil(var_106_0) and arg_103_1.var_.characterEffect1024ui_story == nil then
				arg_103_1.var_.characterEffect1024ui_story = var_106_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_106_2 = 0.2

			if var_106_1 <= arg_103_1.time_ and arg_103_1.time_ < var_106_1 + var_106_2 and not isNil(var_106_0) then
				local var_106_3 = (arg_103_1.time_ - var_106_1) / var_106_2

				if arg_103_1.var_.characterEffect1024ui_story and not isNil(var_106_0) then
					local var_106_4 = Mathf.Lerp(0, 0.5, var_106_3)

					arg_103_1.var_.characterEffect1024ui_story.fillFlat = true
					arg_103_1.var_.characterEffect1024ui_story.fillRatio = var_106_4
				end
			end

			if arg_103_1.time_ >= var_106_1 + var_106_2 and arg_103_1.time_ < var_106_1 + var_106_2 + arg_106_0 and not isNil(var_106_0) and arg_103_1.var_.characterEffect1024ui_story then
				local var_106_5 = 0.5

				arg_103_1.var_.characterEffect1024ui_story.fillFlat = true
				arg_103_1.var_.characterEffect1024ui_story.fillRatio = var_106_5
			end

			local var_106_6 = 0

			if var_106_6 < arg_103_1.time_ and arg_103_1.time_ <= var_106_6 + arg_106_0 then
				arg_103_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_106_7 = arg_103_1.actors_["10014ui_story"]
			local var_106_8 = 0

			if var_106_8 < arg_103_1.time_ and arg_103_1.time_ <= var_106_8 + arg_106_0 and not isNil(var_106_7) and arg_103_1.var_.characterEffect10014ui_story == nil then
				arg_103_1.var_.characterEffect10014ui_story = var_106_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_106_9 = 0.2

			if var_106_8 <= arg_103_1.time_ and arg_103_1.time_ < var_106_8 + var_106_9 and not isNil(var_106_7) then
				local var_106_10 = (arg_103_1.time_ - var_106_8) / var_106_9

				if arg_103_1.var_.characterEffect10014ui_story and not isNil(var_106_7) then
					arg_103_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_103_1.time_ >= var_106_8 + var_106_9 and arg_103_1.time_ < var_106_8 + var_106_9 + arg_106_0 and not isNil(var_106_7) and arg_103_1.var_.characterEffect10014ui_story then
				arg_103_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			local var_106_11 = 0
			local var_106_12 = 0.85

			if var_106_11 < arg_103_1.time_ and arg_103_1.time_ <= var_106_11 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				local var_106_13 = arg_103_1:FormatText(StoryNameCfg[264].name)

				arg_103_1.leftNameTxt_.text = var_106_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_14 = arg_103_1:GetWordFromCfg(115181026)
				local var_106_15 = arg_103_1:FormatText(var_106_14.content)

				arg_103_1.text_.text = var_106_15

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_16 = 34
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

				if manager.audio:GetVoiceLength("story_v_out_115181", "115181026", "story_v_out_115181.awb") ~= 0 then
					local var_106_19 = manager.audio:GetVoiceLength("story_v_out_115181", "115181026", "story_v_out_115181.awb") / 1000

					if var_106_19 + var_106_11 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_19 + var_106_11
					end

					if var_106_14.prefab_name ~= "" and arg_103_1.actors_[var_106_14.prefab_name] ~= nil then
						local var_106_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_14.prefab_name].transform, "story_v_out_115181", "115181026", "story_v_out_115181.awb")

						arg_103_1:RecordAudio("115181026", var_106_20)
						arg_103_1:RecordAudio("115181026", var_106_20)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_out_115181", "115181026", "story_v_out_115181.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_out_115181", "115181026", "story_v_out_115181.awb")
				end

				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_21 = math.max(var_106_12, arg_103_1.talkMaxDuration)

			if var_106_11 <= arg_103_1.time_ and arg_103_1.time_ < var_106_11 + var_106_21 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_11) / var_106_21

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_11 + var_106_21 and arg_103_1.time_ < var_106_11 + var_106_21 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {}

		arg_103_1:InitPlayNodeList()
	end,
	Play115181027 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 115181027
		arg_107_1.duration_ = 12.3

		local var_107_0 = {
			ja = 12.3,
			ko = 8.7,
			zh = 11.6,
			en = 8.3
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
				arg_107_0:Play115181028(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			local var_110_0 = 0

			if var_110_0 < arg_107_1.time_ and arg_107_1.time_ <= var_110_0 + arg_110_0 then
				arg_107_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_110_1 = 0
			local var_110_2 = 1.25

			if var_110_1 < arg_107_1.time_ and arg_107_1.time_ <= var_110_1 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				local var_110_3 = arg_107_1:FormatText(StoryNameCfg[264].name)

				arg_107_1.leftNameTxt_.text = var_110_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_4 = arg_107_1:GetWordFromCfg(115181027)
				local var_110_5 = arg_107_1:FormatText(var_110_4.content)

				arg_107_1.text_.text = var_110_5

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_6 = 50
				local var_110_7 = utf8.len(var_110_5)
				local var_110_8 = var_110_6 <= 0 and var_110_2 or var_110_2 * (var_110_7 / var_110_6)

				if var_110_8 > 0 and var_110_2 < var_110_8 then
					arg_107_1.talkMaxDuration = var_110_8

					if var_110_8 + var_110_1 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_8 + var_110_1
					end
				end

				arg_107_1.text_.text = var_110_5
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115181", "115181027", "story_v_out_115181.awb") ~= 0 then
					local var_110_9 = manager.audio:GetVoiceLength("story_v_out_115181", "115181027", "story_v_out_115181.awb") / 1000

					if var_110_9 + var_110_1 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_9 + var_110_1
					end

					if var_110_4.prefab_name ~= "" and arg_107_1.actors_[var_110_4.prefab_name] ~= nil then
						local var_110_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_4.prefab_name].transform, "story_v_out_115181", "115181027", "story_v_out_115181.awb")

						arg_107_1:RecordAudio("115181027", var_110_10)
						arg_107_1:RecordAudio("115181027", var_110_10)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_out_115181", "115181027", "story_v_out_115181.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_out_115181", "115181027", "story_v_out_115181.awb")
				end

				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_11 = math.max(var_110_2, arg_107_1.talkMaxDuration)

			if var_110_1 <= arg_107_1.time_ and arg_107_1.time_ < var_110_1 + var_110_11 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_1) / var_110_11

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_1 + var_110_11 and arg_107_1.time_ < var_110_1 + var_110_11 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {}

		arg_107_1:InitPlayNodeList()
	end,
	Play115181028 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 115181028
		arg_111_1.duration_ = 4.8

		local var_111_0 = {
			ja = 3.9,
			ko = 3.166,
			zh = 3.7,
			en = 4.8
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
				arg_111_0:Play115181029(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = 0

			if var_114_0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_0 + arg_114_0 then
				arg_111_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_114_1 = 0
			local var_114_2 = 0.375

			if var_114_1 < arg_111_1.time_ and arg_111_1.time_ <= var_114_1 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				local var_114_3 = arg_111_1:FormatText(StoryNameCfg[264].name)

				arg_111_1.leftNameTxt_.text = var_114_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_4 = arg_111_1:GetWordFromCfg(115181028)
				local var_114_5 = arg_111_1:FormatText(var_114_4.content)

				arg_111_1.text_.text = var_114_5

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_6 = 15
				local var_114_7 = utf8.len(var_114_5)
				local var_114_8 = var_114_6 <= 0 and var_114_2 or var_114_2 * (var_114_7 / var_114_6)

				if var_114_8 > 0 and var_114_2 < var_114_8 then
					arg_111_1.talkMaxDuration = var_114_8

					if var_114_8 + var_114_1 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_8 + var_114_1
					end
				end

				arg_111_1.text_.text = var_114_5
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115181", "115181028", "story_v_out_115181.awb") ~= 0 then
					local var_114_9 = manager.audio:GetVoiceLength("story_v_out_115181", "115181028", "story_v_out_115181.awb") / 1000

					if var_114_9 + var_114_1 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_9 + var_114_1
					end

					if var_114_4.prefab_name ~= "" and arg_111_1.actors_[var_114_4.prefab_name] ~= nil then
						local var_114_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_4.prefab_name].transform, "story_v_out_115181", "115181028", "story_v_out_115181.awb")

						arg_111_1:RecordAudio("115181028", var_114_10)
						arg_111_1:RecordAudio("115181028", var_114_10)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_115181", "115181028", "story_v_out_115181.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_115181", "115181028", "story_v_out_115181.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_11 = math.max(var_114_2, arg_111_1.talkMaxDuration)

			if var_114_1 <= arg_111_1.time_ and arg_111_1.time_ < var_114_1 + var_114_11 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_1) / var_114_11

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_1 + var_114_11 and arg_111_1.time_ < var_114_1 + var_114_11 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play115181029 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 115181029
		arg_115_1.duration_ = 2.67

		local var_115_0 = {
			ja = 2.166,
			ko = 1.999999999999,
			zh = 2.666,
			en = 1.999999999999
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
				arg_115_0:Play115181030(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = arg_115_1.actors_["1024ui_story"]
			local var_118_1 = 0

			if var_118_1 < arg_115_1.time_ and arg_115_1.time_ <= var_118_1 + arg_118_0 and not isNil(var_118_0) and arg_115_1.var_.characterEffect1024ui_story == nil then
				arg_115_1.var_.characterEffect1024ui_story = var_118_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_2 = 0.2

			if var_118_1 <= arg_115_1.time_ and arg_115_1.time_ < var_118_1 + var_118_2 and not isNil(var_118_0) then
				local var_118_3 = (arg_115_1.time_ - var_118_1) / var_118_2

				if arg_115_1.var_.characterEffect1024ui_story and not isNil(var_118_0) then
					arg_115_1.var_.characterEffect1024ui_story.fillFlat = false
				end
			end

			if arg_115_1.time_ >= var_118_1 + var_118_2 and arg_115_1.time_ < var_118_1 + var_118_2 + arg_118_0 and not isNil(var_118_0) and arg_115_1.var_.characterEffect1024ui_story then
				arg_115_1.var_.characterEffect1024ui_story.fillFlat = false
			end

			local var_118_4 = 0

			if var_118_4 < arg_115_1.time_ and arg_115_1.time_ <= var_118_4 + arg_118_0 then
				arg_115_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_118_5 = arg_115_1.actors_["10014ui_story"]
			local var_118_6 = 0

			if var_118_6 < arg_115_1.time_ and arg_115_1.time_ <= var_118_6 + arg_118_0 and not isNil(var_118_5) and arg_115_1.var_.characterEffect10014ui_story == nil then
				arg_115_1.var_.characterEffect10014ui_story = var_118_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_7 = 0.2

			if var_118_6 <= arg_115_1.time_ and arg_115_1.time_ < var_118_6 + var_118_7 and not isNil(var_118_5) then
				local var_118_8 = (arg_115_1.time_ - var_118_6) / var_118_7

				if arg_115_1.var_.characterEffect10014ui_story and not isNil(var_118_5) then
					arg_115_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_115_1.time_ >= var_118_6 + var_118_7 and arg_115_1.time_ < var_118_6 + var_118_7 + arg_118_0 and not isNil(var_118_5) and arg_115_1.var_.characterEffect10014ui_story then
				arg_115_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			local var_118_9 = 0
			local var_118_10 = 0.075

			if var_118_9 < arg_115_1.time_ and arg_115_1.time_ <= var_118_9 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				local var_118_11 = arg_115_1:FormatText(StoryNameCfg[265].name)

				arg_115_1.leftNameTxt_.text = var_118_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_12 = arg_115_1:GetWordFromCfg(115181029)
				local var_118_13 = arg_115_1:FormatText(var_118_12.content)

				arg_115_1.text_.text = var_118_13

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_14 = 3
				local var_118_15 = utf8.len(var_118_13)
				local var_118_16 = var_118_14 <= 0 and var_118_10 or var_118_10 * (var_118_15 / var_118_14)

				if var_118_16 > 0 and var_118_10 < var_118_16 then
					arg_115_1.talkMaxDuration = var_118_16

					if var_118_16 + var_118_9 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_16 + var_118_9
					end
				end

				arg_115_1.text_.text = var_118_13
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115181", "115181029", "story_v_out_115181.awb") ~= 0 then
					local var_118_17 = manager.audio:GetVoiceLength("story_v_out_115181", "115181029", "story_v_out_115181.awb") / 1000

					if var_118_17 + var_118_9 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_17 + var_118_9
					end

					if var_118_12.prefab_name ~= "" and arg_115_1.actors_[var_118_12.prefab_name] ~= nil then
						local var_118_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_12.prefab_name].transform, "story_v_out_115181", "115181029", "story_v_out_115181.awb")

						arg_115_1:RecordAudio("115181029", var_118_18)
						arg_115_1:RecordAudio("115181029", var_118_18)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_115181", "115181029", "story_v_out_115181.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_115181", "115181029", "story_v_out_115181.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_19 = math.max(var_118_10, arg_115_1.talkMaxDuration)

			if var_118_9 <= arg_115_1.time_ and arg_115_1.time_ < var_118_9 + var_118_19 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_9) / var_118_19

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_9 + var_118_19 and arg_115_1.time_ < var_118_9 + var_118_19 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {}

		arg_115_1:InitPlayNodeList()
	end,
	Play115181030 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 115181030
		arg_119_1.duration_ = 3.8

		local var_119_0 = {
			ja = 3.8,
			ko = 2.533,
			zh = 2.733,
			en = 2.733
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
				arg_119_0:Play115181031(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = 0

			if var_122_0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_0 + arg_122_0 then
				arg_119_1:PlayTimeline("1017ui_story", "StoryTimeline/CharAction/story1017/story1017action/1017action3_1")
			end

			local var_122_1 = arg_119_1.actors_["1017ui_story"]
			local var_122_2 = 0

			if var_122_2 < arg_119_1.time_ and arg_119_1.time_ <= var_122_2 + arg_122_0 and not isNil(var_122_1) and arg_119_1.var_.characterEffect1017ui_story == nil then
				arg_119_1.var_.characterEffect1017ui_story = var_122_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_3 = 0.2

			if var_122_2 <= arg_119_1.time_ and arg_119_1.time_ < var_122_2 + var_122_3 and not isNil(var_122_1) then
				local var_122_4 = (arg_119_1.time_ - var_122_2) / var_122_3

				if arg_119_1.var_.characterEffect1017ui_story and not isNil(var_122_1) then
					arg_119_1.var_.characterEffect1017ui_story.fillFlat = false
				end
			end

			if arg_119_1.time_ >= var_122_2 + var_122_3 and arg_119_1.time_ < var_122_2 + var_122_3 + arg_122_0 and not isNil(var_122_1) and arg_119_1.var_.characterEffect1017ui_story then
				arg_119_1.var_.characterEffect1017ui_story.fillFlat = false
			end

			local var_122_5 = 0

			if var_122_5 < arg_119_1.time_ and arg_119_1.time_ <= var_122_5 + arg_122_0 then
				arg_119_1:PlayTimeline("1017ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_122_6 = arg_119_1.actors_["1024ui_story"].transform
			local var_122_7 = 0

			if var_122_7 < arg_119_1.time_ and arg_119_1.time_ <= var_122_7 + arg_122_0 then
				arg_119_1.var_.moveOldPos1024ui_story = var_122_6.localPosition
			end

			local var_122_8 = 0.001

			if var_122_7 <= arg_119_1.time_ and arg_119_1.time_ < var_122_7 + var_122_8 then
				local var_122_9 = (arg_119_1.time_ - var_122_7) / var_122_8
				local var_122_10 = Vector3.New(0, 100, 0)

				var_122_6.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos1024ui_story, var_122_10, var_122_9)

				local var_122_11 = manager.ui.mainCamera.transform.position - var_122_6.position

				var_122_6.forward = Vector3.New(var_122_11.x, var_122_11.y, var_122_11.z)

				local var_122_12 = var_122_6.localEulerAngles

				var_122_12.z = 0
				var_122_12.x = 0
				var_122_6.localEulerAngles = var_122_12
			end

			if arg_119_1.time_ >= var_122_7 + var_122_8 and arg_119_1.time_ < var_122_7 + var_122_8 + arg_122_0 then
				var_122_6.localPosition = Vector3.New(0, 100, 0)

				local var_122_13 = manager.ui.mainCamera.transform.position - var_122_6.position

				var_122_6.forward = Vector3.New(var_122_13.x, var_122_13.y, var_122_13.z)

				local var_122_14 = var_122_6.localEulerAngles

				var_122_14.z = 0
				var_122_14.x = 0
				var_122_6.localEulerAngles = var_122_14
			end

			local var_122_15 = arg_119_1.actors_["1017ui_story"].transform
			local var_122_16 = 0

			if var_122_16 < arg_119_1.time_ and arg_119_1.time_ <= var_122_16 + arg_122_0 then
				arg_119_1.var_.moveOldPos1017ui_story = var_122_15.localPosition
			end

			local var_122_17 = 0.001

			if var_122_16 <= arg_119_1.time_ and arg_119_1.time_ < var_122_16 + var_122_17 then
				local var_122_18 = (arg_119_1.time_ - var_122_16) / var_122_17
				local var_122_19 = Vector3.New(0.7, -1.01, -6.05)

				var_122_15.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos1017ui_story, var_122_19, var_122_18)

				local var_122_20 = manager.ui.mainCamera.transform.position - var_122_15.position

				var_122_15.forward = Vector3.New(var_122_20.x, var_122_20.y, var_122_20.z)

				local var_122_21 = var_122_15.localEulerAngles

				var_122_21.z = 0
				var_122_21.x = 0
				var_122_15.localEulerAngles = var_122_21
			end

			if arg_119_1.time_ >= var_122_16 + var_122_17 and arg_119_1.time_ < var_122_16 + var_122_17 + arg_122_0 then
				var_122_15.localPosition = Vector3.New(0.7, -1.01, -6.05)

				local var_122_22 = manager.ui.mainCamera.transform.position - var_122_15.position

				var_122_15.forward = Vector3.New(var_122_22.x, var_122_22.y, var_122_22.z)

				local var_122_23 = var_122_15.localEulerAngles

				var_122_23.z = 0
				var_122_23.x = 0
				var_122_15.localEulerAngles = var_122_23
			end

			local var_122_24 = 0
			local var_122_25 = 0.325

			if var_122_24 < arg_119_1.time_ and arg_119_1.time_ <= var_122_24 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				local var_122_26 = arg_119_1:FormatText(StoryNameCfg[273].name)

				arg_119_1.leftNameTxt_.text = var_122_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_27 = arg_119_1:GetWordFromCfg(115181030)
				local var_122_28 = arg_119_1:FormatText(var_122_27.content)

				arg_119_1.text_.text = var_122_28

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_29 = 13
				local var_122_30 = utf8.len(var_122_28)
				local var_122_31 = var_122_29 <= 0 and var_122_25 or var_122_25 * (var_122_30 / var_122_29)

				if var_122_31 > 0 and var_122_25 < var_122_31 then
					arg_119_1.talkMaxDuration = var_122_31

					if var_122_31 + var_122_24 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_31 + var_122_24
					end
				end

				arg_119_1.text_.text = var_122_28
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115181", "115181030", "story_v_out_115181.awb") ~= 0 then
					local var_122_32 = manager.audio:GetVoiceLength("story_v_out_115181", "115181030", "story_v_out_115181.awb") / 1000

					if var_122_32 + var_122_24 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_32 + var_122_24
					end

					if var_122_27.prefab_name ~= "" and arg_119_1.actors_[var_122_27.prefab_name] ~= nil then
						local var_122_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_27.prefab_name].transform, "story_v_out_115181", "115181030", "story_v_out_115181.awb")

						arg_119_1:RecordAudio("115181030", var_122_33)
						arg_119_1:RecordAudio("115181030", var_122_33)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_115181", "115181030", "story_v_out_115181.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_115181", "115181030", "story_v_out_115181.awb")
				end

				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_34 = math.max(var_122_25, arg_119_1.talkMaxDuration)

			if var_122_24 <= arg_119_1.time_ and arg_119_1.time_ < var_122_24 + var_122_34 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_24) / var_122_34

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_24 + var_122_34 and arg_119_1.time_ < var_122_24 + var_122_34 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1017ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_119_1:InitPlayNodeList()
	end,
	Play115181031 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 115181031
		arg_123_1.duration_ = 4.73

		local var_123_0 = {
			ja = 4.566,
			ko = 3.533,
			zh = 3.2,
			en = 4.733
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
				arg_123_0:Play115181032(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = arg_123_1.actors_["1017ui_story"]
			local var_126_1 = 0

			if var_126_1 < arg_123_1.time_ and arg_123_1.time_ <= var_126_1 + arg_126_0 and not isNil(var_126_0) and arg_123_1.var_.characterEffect1017ui_story == nil then
				arg_123_1.var_.characterEffect1017ui_story = var_126_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_2 = 0.2

			if var_126_1 <= arg_123_1.time_ and arg_123_1.time_ < var_126_1 + var_126_2 and not isNil(var_126_0) then
				local var_126_3 = (arg_123_1.time_ - var_126_1) / var_126_2

				if arg_123_1.var_.characterEffect1017ui_story and not isNil(var_126_0) then
					local var_126_4 = Mathf.Lerp(0, 0.5, var_126_3)

					arg_123_1.var_.characterEffect1017ui_story.fillFlat = true
					arg_123_1.var_.characterEffect1017ui_story.fillRatio = var_126_4
				end
			end

			if arg_123_1.time_ >= var_126_1 + var_126_2 and arg_123_1.time_ < var_126_1 + var_126_2 + arg_126_0 and not isNil(var_126_0) and arg_123_1.var_.characterEffect1017ui_story then
				local var_126_5 = 0.5

				arg_123_1.var_.characterEffect1017ui_story.fillFlat = true
				arg_123_1.var_.characterEffect1017ui_story.fillRatio = var_126_5
			end

			local var_126_6 = arg_123_1.actors_["10014ui_story"]
			local var_126_7 = 0

			if var_126_7 < arg_123_1.time_ and arg_123_1.time_ <= var_126_7 + arg_126_0 and not isNil(var_126_6) and arg_123_1.var_.characterEffect10014ui_story == nil then
				arg_123_1.var_.characterEffect10014ui_story = var_126_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_8 = 0.2

			if var_126_7 <= arg_123_1.time_ and arg_123_1.time_ < var_126_7 + var_126_8 and not isNil(var_126_6) then
				local var_126_9 = (arg_123_1.time_ - var_126_7) / var_126_8

				if arg_123_1.var_.characterEffect10014ui_story and not isNil(var_126_6) then
					arg_123_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_123_1.time_ >= var_126_7 + var_126_8 and arg_123_1.time_ < var_126_7 + var_126_8 + arg_126_0 and not isNil(var_126_6) and arg_123_1.var_.characterEffect10014ui_story then
				arg_123_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			local var_126_10 = 0

			if var_126_10 < arg_123_1.time_ and arg_123_1.time_ <= var_126_10 + arg_126_0 then
				arg_123_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_126_11 = 0
			local var_126_12 = 0.325

			if var_126_11 < arg_123_1.time_ and arg_123_1.time_ <= var_126_11 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				local var_126_13 = arg_123_1:FormatText(StoryNameCfg[264].name)

				arg_123_1.leftNameTxt_.text = var_126_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_14 = arg_123_1:GetWordFromCfg(115181031)
				local var_126_15 = arg_123_1:FormatText(var_126_14.content)

				arg_123_1.text_.text = var_126_15

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_16 = 13
				local var_126_17 = utf8.len(var_126_15)
				local var_126_18 = var_126_16 <= 0 and var_126_12 or var_126_12 * (var_126_17 / var_126_16)

				if var_126_18 > 0 and var_126_12 < var_126_18 then
					arg_123_1.talkMaxDuration = var_126_18

					if var_126_18 + var_126_11 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_18 + var_126_11
					end
				end

				arg_123_1.text_.text = var_126_15
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115181", "115181031", "story_v_out_115181.awb") ~= 0 then
					local var_126_19 = manager.audio:GetVoiceLength("story_v_out_115181", "115181031", "story_v_out_115181.awb") / 1000

					if var_126_19 + var_126_11 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_19 + var_126_11
					end

					if var_126_14.prefab_name ~= "" and arg_123_1.actors_[var_126_14.prefab_name] ~= nil then
						local var_126_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_14.prefab_name].transform, "story_v_out_115181", "115181031", "story_v_out_115181.awb")

						arg_123_1:RecordAudio("115181031", var_126_20)
						arg_123_1:RecordAudio("115181031", var_126_20)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_115181", "115181031", "story_v_out_115181.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_115181", "115181031", "story_v_out_115181.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_21 = math.max(var_126_12, arg_123_1.talkMaxDuration)

			if var_126_11 <= arg_123_1.time_ and arg_123_1.time_ < var_126_11 + var_126_21 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_11) / var_126_21

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_11 + var_126_21 and arg_123_1.time_ < var_126_11 + var_126_21 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play115181032 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 115181032
		arg_127_1.duration_ = 2.17

		local var_127_0 = {
			ja = 2.166,
			ko = 1.999999999999,
			zh = 1.999999999999,
			en = 1.999999999999
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
				arg_127_0:Play115181033(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = arg_127_1.actors_["1017ui_story"]
			local var_130_1 = 0

			if var_130_1 < arg_127_1.time_ and arg_127_1.time_ <= var_130_1 + arg_130_0 and not isNil(var_130_0) and arg_127_1.var_.characterEffect1017ui_story == nil then
				arg_127_1.var_.characterEffect1017ui_story = var_130_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_2 = 0.2

			if var_130_1 <= arg_127_1.time_ and arg_127_1.time_ < var_130_1 + var_130_2 and not isNil(var_130_0) then
				local var_130_3 = (arg_127_1.time_ - var_130_1) / var_130_2

				if arg_127_1.var_.characterEffect1017ui_story and not isNil(var_130_0) then
					arg_127_1.var_.characterEffect1017ui_story.fillFlat = false
				end
			end

			if arg_127_1.time_ >= var_130_1 + var_130_2 and arg_127_1.time_ < var_130_1 + var_130_2 + arg_130_0 and not isNil(var_130_0) and arg_127_1.var_.characterEffect1017ui_story then
				arg_127_1.var_.characterEffect1017ui_story.fillFlat = false
			end

			local var_130_4 = 0

			if var_130_4 < arg_127_1.time_ and arg_127_1.time_ <= var_130_4 + arg_130_0 then
				arg_127_1:PlayTimeline("1017ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_130_5 = arg_127_1.actors_["10014ui_story"]
			local var_130_6 = 0

			if var_130_6 < arg_127_1.time_ and arg_127_1.time_ <= var_130_6 + arg_130_0 and not isNil(var_130_5) and arg_127_1.var_.characterEffect10014ui_story == nil then
				arg_127_1.var_.characterEffect10014ui_story = var_130_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_7 = 0.2

			if var_130_6 <= arg_127_1.time_ and arg_127_1.time_ < var_130_6 + var_130_7 and not isNil(var_130_5) then
				local var_130_8 = (arg_127_1.time_ - var_130_6) / var_130_7

				if arg_127_1.var_.characterEffect10014ui_story and not isNil(var_130_5) then
					local var_130_9 = Mathf.Lerp(0, 0.5, var_130_8)

					arg_127_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_127_1.var_.characterEffect10014ui_story.fillRatio = var_130_9
				end
			end

			if arg_127_1.time_ >= var_130_6 + var_130_7 and arg_127_1.time_ < var_130_6 + var_130_7 + arg_130_0 and not isNil(var_130_5) and arg_127_1.var_.characterEffect10014ui_story then
				local var_130_10 = 0.5

				arg_127_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_127_1.var_.characterEffect10014ui_story.fillRatio = var_130_10
			end

			local var_130_11 = 0
			local var_130_12 = 0.075

			if var_130_11 < arg_127_1.time_ and arg_127_1.time_ <= var_130_11 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				local var_130_13 = arg_127_1:FormatText(StoryNameCfg[273].name)

				arg_127_1.leftNameTxt_.text = var_130_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_14 = arg_127_1:GetWordFromCfg(115181032)
				local var_130_15 = arg_127_1:FormatText(var_130_14.content)

				arg_127_1.text_.text = var_130_15

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_16 = 3
				local var_130_17 = utf8.len(var_130_15)
				local var_130_18 = var_130_16 <= 0 and var_130_12 or var_130_12 * (var_130_17 / var_130_16)

				if var_130_18 > 0 and var_130_12 < var_130_18 then
					arg_127_1.talkMaxDuration = var_130_18

					if var_130_18 + var_130_11 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_18 + var_130_11
					end
				end

				arg_127_1.text_.text = var_130_15
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115181", "115181032", "story_v_out_115181.awb") ~= 0 then
					local var_130_19 = manager.audio:GetVoiceLength("story_v_out_115181", "115181032", "story_v_out_115181.awb") / 1000

					if var_130_19 + var_130_11 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_19 + var_130_11
					end

					if var_130_14.prefab_name ~= "" and arg_127_1.actors_[var_130_14.prefab_name] ~= nil then
						local var_130_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_14.prefab_name].transform, "story_v_out_115181", "115181032", "story_v_out_115181.awb")

						arg_127_1:RecordAudio("115181032", var_130_20)
						arg_127_1:RecordAudio("115181032", var_130_20)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_115181", "115181032", "story_v_out_115181.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_115181", "115181032", "story_v_out_115181.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_21 = math.max(var_130_12, arg_127_1.talkMaxDuration)

			if var_130_11 <= arg_127_1.time_ and arg_127_1.time_ < var_130_11 + var_130_21 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_11) / var_130_21

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_11 + var_130_21 and arg_127_1.time_ < var_130_11 + var_130_21 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play115181033 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 115181033
		arg_131_1.duration_ = 14.77

		local var_131_0 = {
			ja = 14.766,
			ko = 11.8,
			zh = 9.033,
			en = 12.133
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
				arg_131_0:Play115181034(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = arg_131_1.actors_["1017ui_story"]
			local var_134_1 = 0

			if var_134_1 < arg_131_1.time_ and arg_131_1.time_ <= var_134_1 + arg_134_0 and not isNil(var_134_0) and arg_131_1.var_.characterEffect1017ui_story == nil then
				arg_131_1.var_.characterEffect1017ui_story = var_134_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_2 = 0.2

			if var_134_1 <= arg_131_1.time_ and arg_131_1.time_ < var_134_1 + var_134_2 and not isNil(var_134_0) then
				local var_134_3 = (arg_131_1.time_ - var_134_1) / var_134_2

				if arg_131_1.var_.characterEffect1017ui_story and not isNil(var_134_0) then
					local var_134_4 = Mathf.Lerp(0, 0.5, var_134_3)

					arg_131_1.var_.characterEffect1017ui_story.fillFlat = true
					arg_131_1.var_.characterEffect1017ui_story.fillRatio = var_134_4
				end
			end

			if arg_131_1.time_ >= var_134_1 + var_134_2 and arg_131_1.time_ < var_134_1 + var_134_2 + arg_134_0 and not isNil(var_134_0) and arg_131_1.var_.characterEffect1017ui_story then
				local var_134_5 = 0.5

				arg_131_1.var_.characterEffect1017ui_story.fillFlat = true
				arg_131_1.var_.characterEffect1017ui_story.fillRatio = var_134_5
			end

			local var_134_6 = 0

			if var_134_6 < arg_131_1.time_ and arg_131_1.time_ <= var_134_6 + arg_134_0 then
				arg_131_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_134_7 = 0
			local var_134_8 = 0.9

			if var_134_7 < arg_131_1.time_ and arg_131_1.time_ <= var_134_7 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				local var_134_9 = arg_131_1:FormatText(StoryNameCfg[264].name)

				arg_131_1.leftNameTxt_.text = var_134_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_10 = arg_131_1:GetWordFromCfg(115181033)
				local var_134_11 = arg_131_1:FormatText(var_134_10.content)

				arg_131_1.text_.text = var_134_11

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_12 = 36
				local var_134_13 = utf8.len(var_134_11)
				local var_134_14 = var_134_12 <= 0 and var_134_8 or var_134_8 * (var_134_13 / var_134_12)

				if var_134_14 > 0 and var_134_8 < var_134_14 then
					arg_131_1.talkMaxDuration = var_134_14

					if var_134_14 + var_134_7 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_14 + var_134_7
					end
				end

				arg_131_1.text_.text = var_134_11
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115181", "115181033", "story_v_out_115181.awb") ~= 0 then
					local var_134_15 = manager.audio:GetVoiceLength("story_v_out_115181", "115181033", "story_v_out_115181.awb") / 1000

					if var_134_15 + var_134_7 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_15 + var_134_7
					end

					if var_134_10.prefab_name ~= "" and arg_131_1.actors_[var_134_10.prefab_name] ~= nil then
						local var_134_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_10.prefab_name].transform, "story_v_out_115181", "115181033", "story_v_out_115181.awb")

						arg_131_1:RecordAudio("115181033", var_134_16)
						arg_131_1:RecordAudio("115181033", var_134_16)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_115181", "115181033", "story_v_out_115181.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_115181", "115181033", "story_v_out_115181.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_17 = math.max(var_134_8, arg_131_1.talkMaxDuration)

			if var_134_7 <= arg_131_1.time_ and arg_131_1.time_ < var_134_7 + var_134_17 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_7) / var_134_17

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_7 + var_134_17 and arg_131_1.time_ < var_134_7 + var_134_17 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play115181034 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 115181034
		arg_135_1.duration_ = 13.93

		local var_135_0 = {
			ja = 13.933,
			ko = 8.1,
			zh = 8.4,
			en = 7.766
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
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play115181035(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = 0

			if var_138_0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_0 + arg_138_0 then
				arg_135_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_138_1 = 0
			local var_138_2 = 0.9

			if var_138_1 < arg_135_1.time_ and arg_135_1.time_ <= var_138_1 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				local var_138_3 = arg_135_1:FormatText(StoryNameCfg[264].name)

				arg_135_1.leftNameTxt_.text = var_138_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_4 = arg_135_1:GetWordFromCfg(115181034)
				local var_138_5 = arg_135_1:FormatText(var_138_4.content)

				arg_135_1.text_.text = var_138_5

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_6 = 36
				local var_138_7 = utf8.len(var_138_5)
				local var_138_8 = var_138_6 <= 0 and var_138_2 or var_138_2 * (var_138_7 / var_138_6)

				if var_138_8 > 0 and var_138_2 < var_138_8 then
					arg_135_1.talkMaxDuration = var_138_8

					if var_138_8 + var_138_1 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_8 + var_138_1
					end
				end

				arg_135_1.text_.text = var_138_5
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115181", "115181034", "story_v_out_115181.awb") ~= 0 then
					local var_138_9 = manager.audio:GetVoiceLength("story_v_out_115181", "115181034", "story_v_out_115181.awb") / 1000

					if var_138_9 + var_138_1 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_9 + var_138_1
					end

					if var_138_4.prefab_name ~= "" and arg_135_1.actors_[var_138_4.prefab_name] ~= nil then
						local var_138_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_4.prefab_name].transform, "story_v_out_115181", "115181034", "story_v_out_115181.awb")

						arg_135_1:RecordAudio("115181034", var_138_10)
						arg_135_1:RecordAudio("115181034", var_138_10)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_115181", "115181034", "story_v_out_115181.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_115181", "115181034", "story_v_out_115181.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_11 = math.max(var_138_2, arg_135_1.talkMaxDuration)

			if var_138_1 <= arg_135_1.time_ and arg_135_1.time_ < var_138_1 + var_138_11 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_1) / var_138_11

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_1 + var_138_11 and arg_135_1.time_ < var_138_1 + var_138_11 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play115181035 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 115181035
		arg_139_1.duration_ = 4.83

		local var_139_0 = {
			ja = 4.366,
			ko = 4.766,
			zh = 3.4,
			en = 4.833
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
				arg_139_0:Play115181036(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = 0

			if var_142_0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_0 + arg_142_0 then
				arg_139_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_142_1 = arg_139_1.actors_["1024ui_story"]
			local var_142_2 = 0

			if var_142_2 < arg_139_1.time_ and arg_139_1.time_ <= var_142_2 + arg_142_0 and not isNil(var_142_1) and arg_139_1.var_.characterEffect1024ui_story == nil then
				arg_139_1.var_.characterEffect1024ui_story = var_142_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_3 = 0.2

			if var_142_2 <= arg_139_1.time_ and arg_139_1.time_ < var_142_2 + var_142_3 and not isNil(var_142_1) then
				local var_142_4 = (arg_139_1.time_ - var_142_2) / var_142_3

				if arg_139_1.var_.characterEffect1024ui_story and not isNil(var_142_1) then
					arg_139_1.var_.characterEffect1024ui_story.fillFlat = false
				end
			end

			if arg_139_1.time_ >= var_142_2 + var_142_3 and arg_139_1.time_ < var_142_2 + var_142_3 + arg_142_0 and not isNil(var_142_1) and arg_139_1.var_.characterEffect1024ui_story then
				arg_139_1.var_.characterEffect1024ui_story.fillFlat = false
			end

			local var_142_5 = arg_139_1.actors_["1017ui_story"].transform
			local var_142_6 = 0

			if var_142_6 < arg_139_1.time_ and arg_139_1.time_ <= var_142_6 + arg_142_0 then
				arg_139_1.var_.moveOldPos1017ui_story = var_142_5.localPosition
			end

			local var_142_7 = 0.001

			if var_142_6 <= arg_139_1.time_ and arg_139_1.time_ < var_142_6 + var_142_7 then
				local var_142_8 = (arg_139_1.time_ - var_142_6) / var_142_7
				local var_142_9 = Vector3.New(0, 100, 0)

				var_142_5.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos1017ui_story, var_142_9, var_142_8)

				local var_142_10 = manager.ui.mainCamera.transform.position - var_142_5.position

				var_142_5.forward = Vector3.New(var_142_10.x, var_142_10.y, var_142_10.z)

				local var_142_11 = var_142_5.localEulerAngles

				var_142_11.z = 0
				var_142_11.x = 0
				var_142_5.localEulerAngles = var_142_11
			end

			if arg_139_1.time_ >= var_142_6 + var_142_7 and arg_139_1.time_ < var_142_6 + var_142_7 + arg_142_0 then
				var_142_5.localPosition = Vector3.New(0, 100, 0)

				local var_142_12 = manager.ui.mainCamera.transform.position - var_142_5.position

				var_142_5.forward = Vector3.New(var_142_12.x, var_142_12.y, var_142_12.z)

				local var_142_13 = var_142_5.localEulerAngles

				var_142_13.z = 0
				var_142_13.x = 0
				var_142_5.localEulerAngles = var_142_13
			end

			local var_142_14 = arg_139_1.actors_["1024ui_story"].transform
			local var_142_15 = 0

			if var_142_15 < arg_139_1.time_ and arg_139_1.time_ <= var_142_15 + arg_142_0 then
				arg_139_1.var_.moveOldPos1024ui_story = var_142_14.localPosition
			end

			local var_142_16 = 0.001

			if var_142_15 <= arg_139_1.time_ and arg_139_1.time_ < var_142_15 + var_142_16 then
				local var_142_17 = (arg_139_1.time_ - var_142_15) / var_142_16
				local var_142_18 = Vector3.New(0.7, -1, -6.05)

				var_142_14.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos1024ui_story, var_142_18, var_142_17)

				local var_142_19 = manager.ui.mainCamera.transform.position - var_142_14.position

				var_142_14.forward = Vector3.New(var_142_19.x, var_142_19.y, var_142_19.z)

				local var_142_20 = var_142_14.localEulerAngles

				var_142_20.z = 0
				var_142_20.x = 0
				var_142_14.localEulerAngles = var_142_20
			end

			if arg_139_1.time_ >= var_142_15 + var_142_16 and arg_139_1.time_ < var_142_15 + var_142_16 + arg_142_0 then
				var_142_14.localPosition = Vector3.New(0.7, -1, -6.05)

				local var_142_21 = manager.ui.mainCamera.transform.position - var_142_14.position

				var_142_14.forward = Vector3.New(var_142_21.x, var_142_21.y, var_142_21.z)

				local var_142_22 = var_142_14.localEulerAngles

				var_142_22.z = 0
				var_142_22.x = 0
				var_142_14.localEulerAngles = var_142_22
			end

			local var_142_23 = 0
			local var_142_24 = 0.5

			if var_142_23 < arg_139_1.time_ and arg_139_1.time_ <= var_142_23 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				local var_142_25 = arg_139_1:FormatText(StoryNameCfg[265].name)

				arg_139_1.leftNameTxt_.text = var_142_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_26 = arg_139_1:GetWordFromCfg(115181035)
				local var_142_27 = arg_139_1:FormatText(var_142_26.content)

				arg_139_1.text_.text = var_142_27

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_28 = 20
				local var_142_29 = utf8.len(var_142_27)
				local var_142_30 = var_142_28 <= 0 and var_142_24 or var_142_24 * (var_142_29 / var_142_28)

				if var_142_30 > 0 and var_142_24 < var_142_30 then
					arg_139_1.talkMaxDuration = var_142_30

					if var_142_30 + var_142_23 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_30 + var_142_23
					end
				end

				arg_139_1.text_.text = var_142_27
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115181", "115181035", "story_v_out_115181.awb") ~= 0 then
					local var_142_31 = manager.audio:GetVoiceLength("story_v_out_115181", "115181035", "story_v_out_115181.awb") / 1000

					if var_142_31 + var_142_23 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_31 + var_142_23
					end

					if var_142_26.prefab_name ~= "" and arg_139_1.actors_[var_142_26.prefab_name] ~= nil then
						local var_142_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_26.prefab_name].transform, "story_v_out_115181", "115181035", "story_v_out_115181.awb")

						arg_139_1:RecordAudio("115181035", var_142_32)
						arg_139_1:RecordAudio("115181035", var_142_32)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_115181", "115181035", "story_v_out_115181.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_115181", "115181035", "story_v_out_115181.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_33 = math.max(var_142_24, arg_139_1.talkMaxDuration)

			if var_142_23 <= arg_139_1.time_ and arg_139_1.time_ < var_142_23 + var_142_33 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_23) / var_142_33

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_23 + var_142_33 and arg_139_1.time_ < var_142_23 + var_142_33 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1017ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_139_1:InitPlayNodeList()
	end,
	Play115181036 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 115181036
		arg_143_1.duration_ = 9.53

		local var_143_0 = {
			ja = 9.533,
			ko = 4.933,
			zh = 4.1,
			en = 4.766
		}
		local var_143_1 = manager.audio:GetLocalizationFlag()

		if var_143_0[var_143_1] ~= nil then
			arg_143_1.duration_ = var_143_0[var_143_1]
		end

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play115181037(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = arg_143_1.actors_["1024ui_story"]
			local var_146_1 = 0

			if var_146_1 < arg_143_1.time_ and arg_143_1.time_ <= var_146_1 + arg_146_0 and not isNil(var_146_0) and arg_143_1.var_.characterEffect1024ui_story == nil then
				arg_143_1.var_.characterEffect1024ui_story = var_146_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_2 = 0.2

			if var_146_1 <= arg_143_1.time_ and arg_143_1.time_ < var_146_1 + var_146_2 and not isNil(var_146_0) then
				local var_146_3 = (arg_143_1.time_ - var_146_1) / var_146_2

				if arg_143_1.var_.characterEffect1024ui_story and not isNil(var_146_0) then
					local var_146_4 = Mathf.Lerp(0, 0.5, var_146_3)

					arg_143_1.var_.characterEffect1024ui_story.fillFlat = true
					arg_143_1.var_.characterEffect1024ui_story.fillRatio = var_146_4
				end
			end

			if arg_143_1.time_ >= var_146_1 + var_146_2 and arg_143_1.time_ < var_146_1 + var_146_2 + arg_146_0 and not isNil(var_146_0) and arg_143_1.var_.characterEffect1024ui_story then
				local var_146_5 = 0.5

				arg_143_1.var_.characterEffect1024ui_story.fillFlat = true
				arg_143_1.var_.characterEffect1024ui_story.fillRatio = var_146_5
			end

			local var_146_6 = 0

			if var_146_6 < arg_143_1.time_ and arg_143_1.time_ <= var_146_6 + arg_146_0 then
				arg_143_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_146_7 = arg_143_1.actors_["10014ui_story"]
			local var_146_8 = 0

			if var_146_8 < arg_143_1.time_ and arg_143_1.time_ <= var_146_8 + arg_146_0 and not isNil(var_146_7) and arg_143_1.var_.characterEffect10014ui_story == nil then
				arg_143_1.var_.characterEffect10014ui_story = var_146_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_9 = 0.2

			if var_146_8 <= arg_143_1.time_ and arg_143_1.time_ < var_146_8 + var_146_9 and not isNil(var_146_7) then
				local var_146_10 = (arg_143_1.time_ - var_146_8) / var_146_9

				if arg_143_1.var_.characterEffect10014ui_story and not isNil(var_146_7) then
					arg_143_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_143_1.time_ >= var_146_8 + var_146_9 and arg_143_1.time_ < var_146_8 + var_146_9 + arg_146_0 and not isNil(var_146_7) and arg_143_1.var_.characterEffect10014ui_story then
				arg_143_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			local var_146_11 = 0
			local var_146_12 = 0.45

			if var_146_11 < arg_143_1.time_ and arg_143_1.time_ <= var_146_11 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				local var_146_13 = arg_143_1:FormatText(StoryNameCfg[264].name)

				arg_143_1.leftNameTxt_.text = var_146_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_14 = arg_143_1:GetWordFromCfg(115181036)
				local var_146_15 = arg_143_1:FormatText(var_146_14.content)

				arg_143_1.text_.text = var_146_15

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_16 = 18
				local var_146_17 = utf8.len(var_146_15)
				local var_146_18 = var_146_16 <= 0 and var_146_12 or var_146_12 * (var_146_17 / var_146_16)

				if var_146_18 > 0 and var_146_12 < var_146_18 then
					arg_143_1.talkMaxDuration = var_146_18

					if var_146_18 + var_146_11 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_18 + var_146_11
					end
				end

				arg_143_1.text_.text = var_146_15
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115181", "115181036", "story_v_out_115181.awb") ~= 0 then
					local var_146_19 = manager.audio:GetVoiceLength("story_v_out_115181", "115181036", "story_v_out_115181.awb") / 1000

					if var_146_19 + var_146_11 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_19 + var_146_11
					end

					if var_146_14.prefab_name ~= "" and arg_143_1.actors_[var_146_14.prefab_name] ~= nil then
						local var_146_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_14.prefab_name].transform, "story_v_out_115181", "115181036", "story_v_out_115181.awb")

						arg_143_1:RecordAudio("115181036", var_146_20)
						arg_143_1:RecordAudio("115181036", var_146_20)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_115181", "115181036", "story_v_out_115181.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_115181", "115181036", "story_v_out_115181.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_21 = math.max(var_146_12, arg_143_1.talkMaxDuration)

			if var_146_11 <= arg_143_1.time_ and arg_143_1.time_ < var_146_11 + var_146_21 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_11) / var_146_21

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_11 + var_146_21 and arg_143_1.time_ < var_146_11 + var_146_21 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play115181037 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 115181037
		arg_147_1.duration_ = 3.37

		local var_147_0 = {
			ja = 3,
			ko = 3.366,
			zh = 3.033,
			en = 2.033
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
				arg_147_0:Play115181038(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = 0

			if var_150_0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_0 + arg_150_0 then
				arg_147_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_150_1 = 0
			local var_150_2 = 0.275

			if var_150_1 < arg_147_1.time_ and arg_147_1.time_ <= var_150_1 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				local var_150_3 = arg_147_1:FormatText(StoryNameCfg[264].name)

				arg_147_1.leftNameTxt_.text = var_150_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_4 = arg_147_1:GetWordFromCfg(115181037)
				local var_150_5 = arg_147_1:FormatText(var_150_4.content)

				arg_147_1.text_.text = var_150_5

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_6 = 11
				local var_150_7 = utf8.len(var_150_5)
				local var_150_8 = var_150_6 <= 0 and var_150_2 or var_150_2 * (var_150_7 / var_150_6)

				if var_150_8 > 0 and var_150_2 < var_150_8 then
					arg_147_1.talkMaxDuration = var_150_8

					if var_150_8 + var_150_1 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_8 + var_150_1
					end
				end

				arg_147_1.text_.text = var_150_5
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115181", "115181037", "story_v_out_115181.awb") ~= 0 then
					local var_150_9 = manager.audio:GetVoiceLength("story_v_out_115181", "115181037", "story_v_out_115181.awb") / 1000

					if var_150_9 + var_150_1 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_9 + var_150_1
					end

					if var_150_4.prefab_name ~= "" and arg_147_1.actors_[var_150_4.prefab_name] ~= nil then
						local var_150_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_4.prefab_name].transform, "story_v_out_115181", "115181037", "story_v_out_115181.awb")

						arg_147_1:RecordAudio("115181037", var_150_10)
						arg_147_1:RecordAudio("115181037", var_150_10)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_115181", "115181037", "story_v_out_115181.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_115181", "115181037", "story_v_out_115181.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_11 = math.max(var_150_2, arg_147_1.talkMaxDuration)

			if var_150_1 <= arg_147_1.time_ and arg_147_1.time_ < var_150_1 + var_150_11 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_1) / var_150_11

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_1 + var_150_11 and arg_147_1.time_ < var_150_1 + var_150_11 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play115181038 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 115181038
		arg_151_1.duration_ = 8.67

		local var_151_0 = {
			ja = 3.533,
			ko = 6.633,
			zh = 8.666,
			en = 5
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
				arg_151_0:Play115181039(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = arg_151_1.actors_["1017ui_story"]
			local var_154_1 = 0

			if var_154_1 < arg_151_1.time_ and arg_151_1.time_ <= var_154_1 + arg_154_0 and not isNil(var_154_0) and arg_151_1.var_.characterEffect1017ui_story == nil then
				arg_151_1.var_.characterEffect1017ui_story = var_154_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_2 = 0.2

			if var_154_1 <= arg_151_1.time_ and arg_151_1.time_ < var_154_1 + var_154_2 and not isNil(var_154_0) then
				local var_154_3 = (arg_151_1.time_ - var_154_1) / var_154_2

				if arg_151_1.var_.characterEffect1017ui_story and not isNil(var_154_0) then
					arg_151_1.var_.characterEffect1017ui_story.fillFlat = false
				end
			end

			if arg_151_1.time_ >= var_154_1 + var_154_2 and arg_151_1.time_ < var_154_1 + var_154_2 + arg_154_0 and not isNil(var_154_0) and arg_151_1.var_.characterEffect1017ui_story then
				arg_151_1.var_.characterEffect1017ui_story.fillFlat = false
			end

			local var_154_4 = 0

			if var_154_4 < arg_151_1.time_ and arg_151_1.time_ <= var_154_4 + arg_154_0 then
				arg_151_1:PlayTimeline("1017ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_154_5 = 0

			if var_154_5 < arg_151_1.time_ and arg_151_1.time_ <= var_154_5 + arg_154_0 then
				arg_151_1:PlayTimeline("1017ui_story", "StoryTimeline/CharAction/story1017/story1017action/1017action1_1")
			end

			local var_154_6 = arg_151_1.actors_["1017ui_story"].transform
			local var_154_7 = 0

			if var_154_7 < arg_151_1.time_ and arg_151_1.time_ <= var_154_7 + arg_154_0 then
				arg_151_1.var_.moveOldPos1017ui_story = var_154_6.localPosition
			end

			local var_154_8 = 0.001

			if var_154_7 <= arg_151_1.time_ and arg_151_1.time_ < var_154_7 + var_154_8 then
				local var_154_9 = (arg_151_1.time_ - var_154_7) / var_154_8
				local var_154_10 = Vector3.New(0.7, -1.01, -6.05)

				var_154_6.localPosition = Vector3.Lerp(arg_151_1.var_.moveOldPos1017ui_story, var_154_10, var_154_9)

				local var_154_11 = manager.ui.mainCamera.transform.position - var_154_6.position

				var_154_6.forward = Vector3.New(var_154_11.x, var_154_11.y, var_154_11.z)

				local var_154_12 = var_154_6.localEulerAngles

				var_154_12.z = 0
				var_154_12.x = 0
				var_154_6.localEulerAngles = var_154_12
			end

			if arg_151_1.time_ >= var_154_7 + var_154_8 and arg_151_1.time_ < var_154_7 + var_154_8 + arg_154_0 then
				var_154_6.localPosition = Vector3.New(0.7, -1.01, -6.05)

				local var_154_13 = manager.ui.mainCamera.transform.position - var_154_6.position

				var_154_6.forward = Vector3.New(var_154_13.x, var_154_13.y, var_154_13.z)

				local var_154_14 = var_154_6.localEulerAngles

				var_154_14.z = 0
				var_154_14.x = 0
				var_154_6.localEulerAngles = var_154_14
			end

			local var_154_15 = arg_151_1.actors_["1024ui_story"].transform
			local var_154_16 = 0

			if var_154_16 < arg_151_1.time_ and arg_151_1.time_ <= var_154_16 + arg_154_0 then
				arg_151_1.var_.moveOldPos1024ui_story = var_154_15.localPosition
			end

			local var_154_17 = 0.001

			if var_154_16 <= arg_151_1.time_ and arg_151_1.time_ < var_154_16 + var_154_17 then
				local var_154_18 = (arg_151_1.time_ - var_154_16) / var_154_17
				local var_154_19 = Vector3.New(0, 100, 0)

				var_154_15.localPosition = Vector3.Lerp(arg_151_1.var_.moveOldPos1024ui_story, var_154_19, var_154_18)

				local var_154_20 = manager.ui.mainCamera.transform.position - var_154_15.position

				var_154_15.forward = Vector3.New(var_154_20.x, var_154_20.y, var_154_20.z)

				local var_154_21 = var_154_15.localEulerAngles

				var_154_21.z = 0
				var_154_21.x = 0
				var_154_15.localEulerAngles = var_154_21
			end

			if arg_151_1.time_ >= var_154_16 + var_154_17 and arg_151_1.time_ < var_154_16 + var_154_17 + arg_154_0 then
				var_154_15.localPosition = Vector3.New(0, 100, 0)

				local var_154_22 = manager.ui.mainCamera.transform.position - var_154_15.position

				var_154_15.forward = Vector3.New(var_154_22.x, var_154_22.y, var_154_22.z)

				local var_154_23 = var_154_15.localEulerAngles

				var_154_23.z = 0
				var_154_23.x = 0
				var_154_15.localEulerAngles = var_154_23
			end

			local var_154_24 = arg_151_1.actors_["10014ui_story"]
			local var_154_25 = 0

			if var_154_25 < arg_151_1.time_ and arg_151_1.time_ <= var_154_25 + arg_154_0 and not isNil(var_154_24) and arg_151_1.var_.characterEffect10014ui_story == nil then
				arg_151_1.var_.characterEffect10014ui_story = var_154_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_26 = 0.2

			if var_154_25 <= arg_151_1.time_ and arg_151_1.time_ < var_154_25 + var_154_26 and not isNil(var_154_24) then
				local var_154_27 = (arg_151_1.time_ - var_154_25) / var_154_26

				if arg_151_1.var_.characterEffect10014ui_story and not isNil(var_154_24) then
					local var_154_28 = Mathf.Lerp(0, 0.5, var_154_27)

					arg_151_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_151_1.var_.characterEffect10014ui_story.fillRatio = var_154_28
				end
			end

			if arg_151_1.time_ >= var_154_25 + var_154_26 and arg_151_1.time_ < var_154_25 + var_154_26 + arg_154_0 and not isNil(var_154_24) and arg_151_1.var_.characterEffect10014ui_story then
				local var_154_29 = 0.5

				arg_151_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_151_1.var_.characterEffect10014ui_story.fillRatio = var_154_29
			end

			local var_154_30 = 0
			local var_154_31 = 0.575

			if var_154_30 < arg_151_1.time_ and arg_151_1.time_ <= var_154_30 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				local var_154_32 = arg_151_1:FormatText(StoryNameCfg[273].name)

				arg_151_1.leftNameTxt_.text = var_154_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_33 = arg_151_1:GetWordFromCfg(115181038)
				local var_154_34 = arg_151_1:FormatText(var_154_33.content)

				arg_151_1.text_.text = var_154_34

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_35 = 23
				local var_154_36 = utf8.len(var_154_34)
				local var_154_37 = var_154_35 <= 0 and var_154_31 or var_154_31 * (var_154_36 / var_154_35)

				if var_154_37 > 0 and var_154_31 < var_154_37 then
					arg_151_1.talkMaxDuration = var_154_37

					if var_154_37 + var_154_30 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_37 + var_154_30
					end
				end

				arg_151_1.text_.text = var_154_34
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115181", "115181038", "story_v_out_115181.awb") ~= 0 then
					local var_154_38 = manager.audio:GetVoiceLength("story_v_out_115181", "115181038", "story_v_out_115181.awb") / 1000

					if var_154_38 + var_154_30 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_38 + var_154_30
					end

					if var_154_33.prefab_name ~= "" and arg_151_1.actors_[var_154_33.prefab_name] ~= nil then
						local var_154_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_33.prefab_name].transform, "story_v_out_115181", "115181038", "story_v_out_115181.awb")

						arg_151_1:RecordAudio("115181038", var_154_39)
						arg_151_1:RecordAudio("115181038", var_154_39)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_115181", "115181038", "story_v_out_115181.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_115181", "115181038", "story_v_out_115181.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_40 = math.max(var_154_31, arg_151_1.talkMaxDuration)

			if var_154_30 <= arg_151_1.time_ and arg_151_1.time_ < var_154_30 + var_154_40 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_30) / var_154_40

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_30 + var_154_40 and arg_151_1.time_ < var_154_30 + var_154_40 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1017ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_151_1:InitPlayNodeList()
	end,
	Play115181039 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 115181039
		arg_155_1.duration_ = 7.3

		local var_155_0 = {
			ja = 4.866,
			ko = 6.6,
			zh = 7.3,
			en = 6.466
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
				arg_155_0:Play115181040(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = 0

			if var_158_0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_0 + arg_158_0 then
				arg_155_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_158_1 = arg_155_1.actors_["10014ui_story"]
			local var_158_2 = 0

			if var_158_2 < arg_155_1.time_ and arg_155_1.time_ <= var_158_2 + arg_158_0 and not isNil(var_158_1) and arg_155_1.var_.characterEffect10014ui_story == nil then
				arg_155_1.var_.characterEffect10014ui_story = var_158_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_158_3 = 0.2

			if var_158_2 <= arg_155_1.time_ and arg_155_1.time_ < var_158_2 + var_158_3 and not isNil(var_158_1) then
				local var_158_4 = (arg_155_1.time_ - var_158_2) / var_158_3

				if arg_155_1.var_.characterEffect10014ui_story and not isNil(var_158_1) then
					arg_155_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_155_1.time_ >= var_158_2 + var_158_3 and arg_155_1.time_ < var_158_2 + var_158_3 + arg_158_0 and not isNil(var_158_1) and arg_155_1.var_.characterEffect10014ui_story then
				arg_155_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			local var_158_5 = arg_155_1.actors_["1017ui_story"]
			local var_158_6 = 0

			if var_158_6 < arg_155_1.time_ and arg_155_1.time_ <= var_158_6 + arg_158_0 and not isNil(var_158_5) and arg_155_1.var_.characterEffect1017ui_story == nil then
				arg_155_1.var_.characterEffect1017ui_story = var_158_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_158_7 = 0.2

			if var_158_6 <= arg_155_1.time_ and arg_155_1.time_ < var_158_6 + var_158_7 and not isNil(var_158_5) then
				local var_158_8 = (arg_155_1.time_ - var_158_6) / var_158_7

				if arg_155_1.var_.characterEffect1017ui_story and not isNil(var_158_5) then
					local var_158_9 = Mathf.Lerp(0, 0.5, var_158_8)

					arg_155_1.var_.characterEffect1017ui_story.fillFlat = true
					arg_155_1.var_.characterEffect1017ui_story.fillRatio = var_158_9
				end
			end

			if arg_155_1.time_ >= var_158_6 + var_158_7 and arg_155_1.time_ < var_158_6 + var_158_7 + arg_158_0 and not isNil(var_158_5) and arg_155_1.var_.characterEffect1017ui_story then
				local var_158_10 = 0.5

				arg_155_1.var_.characterEffect1017ui_story.fillFlat = true
				arg_155_1.var_.characterEffect1017ui_story.fillRatio = var_158_10
			end

			local var_158_11 = 0
			local var_158_12 = 0.55

			if var_158_11 < arg_155_1.time_ and arg_155_1.time_ <= var_158_11 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				local var_158_13 = arg_155_1:FormatText(StoryNameCfg[264].name)

				arg_155_1.leftNameTxt_.text = var_158_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_14 = arg_155_1:GetWordFromCfg(115181039)
				local var_158_15 = arg_155_1:FormatText(var_158_14.content)

				arg_155_1.text_.text = var_158_15

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_16 = 22
				local var_158_17 = utf8.len(var_158_15)
				local var_158_18 = var_158_16 <= 0 and var_158_12 or var_158_12 * (var_158_17 / var_158_16)

				if var_158_18 > 0 and var_158_12 < var_158_18 then
					arg_155_1.talkMaxDuration = var_158_18

					if var_158_18 + var_158_11 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_18 + var_158_11
					end
				end

				arg_155_1.text_.text = var_158_15
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115181", "115181039", "story_v_out_115181.awb") ~= 0 then
					local var_158_19 = manager.audio:GetVoiceLength("story_v_out_115181", "115181039", "story_v_out_115181.awb") / 1000

					if var_158_19 + var_158_11 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_19 + var_158_11
					end

					if var_158_14.prefab_name ~= "" and arg_155_1.actors_[var_158_14.prefab_name] ~= nil then
						local var_158_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_14.prefab_name].transform, "story_v_out_115181", "115181039", "story_v_out_115181.awb")

						arg_155_1:RecordAudio("115181039", var_158_20)
						arg_155_1:RecordAudio("115181039", var_158_20)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_115181", "115181039", "story_v_out_115181.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_115181", "115181039", "story_v_out_115181.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_21 = math.max(var_158_12, arg_155_1.talkMaxDuration)

			if var_158_11 <= arg_155_1.time_ and arg_155_1.time_ < var_158_11 + var_158_21 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_11) / var_158_21

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_11 + var_158_21 and arg_155_1.time_ < var_158_11 + var_158_21 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {}

		arg_155_1:InitPlayNodeList()
	end,
	Play115181040 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 115181040
		arg_159_1.duration_ = 9

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play115181041(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = 0

			if var_162_0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_0 + arg_162_0 then
				arg_159_1.mask_.enabled = true
				arg_159_1.mask_.raycastTarget = true

				arg_159_1:SetGaussion(false)
			end

			local var_162_1 = 2

			if var_162_0 <= arg_159_1.time_ and arg_159_1.time_ < var_162_0 + var_162_1 then
				local var_162_2 = (arg_159_1.time_ - var_162_0) / var_162_1
				local var_162_3 = Color.New(0, 0, 0)

				var_162_3.a = Mathf.Lerp(0, 1, var_162_2)
				arg_159_1.mask_.color = var_162_3
			end

			if arg_159_1.time_ >= var_162_0 + var_162_1 and arg_159_1.time_ < var_162_0 + var_162_1 + arg_162_0 then
				local var_162_4 = Color.New(0, 0, 0)

				var_162_4.a = 1
				arg_159_1.mask_.color = var_162_4
			end

			local var_162_5 = 2

			if var_162_5 < arg_159_1.time_ and arg_159_1.time_ <= var_162_5 + arg_162_0 then
				arg_159_1.mask_.enabled = true
				arg_159_1.mask_.raycastTarget = true

				arg_159_1:SetGaussion(false)
			end

			local var_162_6 = 2

			if var_162_5 <= arg_159_1.time_ and arg_159_1.time_ < var_162_5 + var_162_6 then
				local var_162_7 = (arg_159_1.time_ - var_162_5) / var_162_6
				local var_162_8 = Color.New(0, 0, 0)

				var_162_8.a = Mathf.Lerp(1, 0, var_162_7)
				arg_159_1.mask_.color = var_162_8
			end

			if arg_159_1.time_ >= var_162_5 + var_162_6 and arg_159_1.time_ < var_162_5 + var_162_6 + arg_162_0 then
				local var_162_9 = Color.New(0, 0, 0)
				local var_162_10 = 0

				arg_159_1.mask_.enabled = false
				var_162_9.a = var_162_10
				arg_159_1.mask_.color = var_162_9
			end

			local var_162_11 = arg_159_1.actors_["1017ui_story"].transform
			local var_162_12 = 1.966

			if var_162_12 < arg_159_1.time_ and arg_159_1.time_ <= var_162_12 + arg_162_0 then
				arg_159_1.var_.moveOldPos1017ui_story = var_162_11.localPosition
			end

			local var_162_13 = 0.001

			if var_162_12 <= arg_159_1.time_ and arg_159_1.time_ < var_162_12 + var_162_13 then
				local var_162_14 = (arg_159_1.time_ - var_162_12) / var_162_13
				local var_162_15 = Vector3.New(0, 100, 0)

				var_162_11.localPosition = Vector3.Lerp(arg_159_1.var_.moveOldPos1017ui_story, var_162_15, var_162_14)

				local var_162_16 = manager.ui.mainCamera.transform.position - var_162_11.position

				var_162_11.forward = Vector3.New(var_162_16.x, var_162_16.y, var_162_16.z)

				local var_162_17 = var_162_11.localEulerAngles

				var_162_17.z = 0
				var_162_17.x = 0
				var_162_11.localEulerAngles = var_162_17
			end

			if arg_159_1.time_ >= var_162_12 + var_162_13 and arg_159_1.time_ < var_162_12 + var_162_13 + arg_162_0 then
				var_162_11.localPosition = Vector3.New(0, 100, 0)

				local var_162_18 = manager.ui.mainCamera.transform.position - var_162_11.position

				var_162_11.forward = Vector3.New(var_162_18.x, var_162_18.y, var_162_18.z)

				local var_162_19 = var_162_11.localEulerAngles

				var_162_19.z = 0
				var_162_19.x = 0
				var_162_11.localEulerAngles = var_162_19
			end

			local var_162_20 = arg_159_1.actors_["10014ui_story"].transform
			local var_162_21 = 1.966

			if var_162_21 < arg_159_1.time_ and arg_159_1.time_ <= var_162_21 + arg_162_0 then
				arg_159_1.var_.moveOldPos10014ui_story = var_162_20.localPosition
			end

			local var_162_22 = 0.001

			if var_162_21 <= arg_159_1.time_ and arg_159_1.time_ < var_162_21 + var_162_22 then
				local var_162_23 = (arg_159_1.time_ - var_162_21) / var_162_22
				local var_162_24 = Vector3.New(0, 100, 0)

				var_162_20.localPosition = Vector3.Lerp(arg_159_1.var_.moveOldPos10014ui_story, var_162_24, var_162_23)

				local var_162_25 = manager.ui.mainCamera.transform.position - var_162_20.position

				var_162_20.forward = Vector3.New(var_162_25.x, var_162_25.y, var_162_25.z)

				local var_162_26 = var_162_20.localEulerAngles

				var_162_26.z = 0
				var_162_26.x = 0
				var_162_20.localEulerAngles = var_162_26
			end

			if arg_159_1.time_ >= var_162_21 + var_162_22 and arg_159_1.time_ < var_162_21 + var_162_22 + arg_162_0 then
				var_162_20.localPosition = Vector3.New(0, 100, 0)

				local var_162_27 = manager.ui.mainCamera.transform.position - var_162_20.position

				var_162_20.forward = Vector3.New(var_162_27.x, var_162_27.y, var_162_27.z)

				local var_162_28 = var_162_20.localEulerAngles

				var_162_28.z = 0
				var_162_28.x = 0
				var_162_20.localEulerAngles = var_162_28
			end

			if arg_159_1.frameCnt_ <= 1 then
				arg_159_1.dialog_:SetActive(false)
			end

			local var_162_29 = 4
			local var_162_30 = 0.175

			if var_162_29 < arg_159_1.time_ and arg_159_1.time_ <= var_162_29 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0

				arg_159_1.dialog_:SetActive(true)

				arg_159_1.dialogCg_.alpha = 0

				local var_162_31 = LeanTween.value(arg_159_1.dialog_, 0, 1, 0.3)

				var_162_31:setOnUpdate(LuaHelper.FloatAction(function(arg_163_0)
					arg_159_1.dialogCg_.alpha = arg_163_0
				end))
				var_162_31:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_159_1.dialog_)
					var_162_31:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_159_1.duration_ = arg_159_1.duration_ + 0.3

				SetActive(arg_159_1.leftNameGo_, false)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_32 = arg_159_1:GetWordFromCfg(115181040)
				local var_162_33 = arg_159_1:FormatText(var_162_32.content)

				arg_159_1.text_.text = var_162_33

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_34 = 7
				local var_162_35 = utf8.len(var_162_33)
				local var_162_36 = var_162_34 <= 0 and var_162_30 or var_162_30 * (var_162_35 / var_162_34)

				if var_162_36 > 0 and var_162_30 < var_162_36 then
					arg_159_1.talkMaxDuration = var_162_36
					var_162_29 = var_162_29 + 0.3

					if var_162_36 + var_162_29 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_36 + var_162_29
					end
				end

				arg_159_1.text_.text = var_162_33
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)
				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_37 = var_162_29 + 0.3
			local var_162_38 = math.max(var_162_30, arg_159_1.talkMaxDuration)

			if var_162_37 <= arg_159_1.time_ and arg_159_1.time_ < var_162_37 + var_162_38 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_37) / var_162_38

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_37 + var_162_38 and arg_159_1.time_ < var_162_37 + var_162_38 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1017ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10014ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_159_1:InitPlayNodeList()
	end,
	Play115181041 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 115181041
		arg_165_1.duration_ = 3.23

		local var_165_0 = {
			ja = 2.866,
			ko = 2.6,
			zh = 2.7,
			en = 3.233
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
				arg_165_0:Play115181042(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = 0

			if var_168_0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_0 + arg_168_0 then
				arg_165_1:PlayTimeline("1017ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_168_1 = arg_165_1.actors_["1017ui_story"]
			local var_168_2 = 0

			if var_168_2 < arg_165_1.time_ and arg_165_1.time_ <= var_168_2 + arg_168_0 and not isNil(var_168_1) and arg_165_1.var_.characterEffect1017ui_story == nil then
				arg_165_1.var_.characterEffect1017ui_story = var_168_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_3 = 0.2

			if var_168_2 <= arg_165_1.time_ and arg_165_1.time_ < var_168_2 + var_168_3 and not isNil(var_168_1) then
				local var_168_4 = (arg_165_1.time_ - var_168_2) / var_168_3

				if arg_165_1.var_.characterEffect1017ui_story and not isNil(var_168_1) then
					arg_165_1.var_.characterEffect1017ui_story.fillFlat = false
				end
			end

			if arg_165_1.time_ >= var_168_2 + var_168_3 and arg_165_1.time_ < var_168_2 + var_168_3 + arg_168_0 and not isNil(var_168_1) and arg_165_1.var_.characterEffect1017ui_story then
				arg_165_1.var_.characterEffect1017ui_story.fillFlat = false
			end

			local var_168_5 = arg_165_1.actors_["1017ui_story"].transform
			local var_168_6 = 0

			if var_168_6 < arg_165_1.time_ and arg_165_1.time_ <= var_168_6 + arg_168_0 then
				arg_165_1.var_.moveOldPos1017ui_story = var_168_5.localPosition
			end

			local var_168_7 = 0.001

			if var_168_6 <= arg_165_1.time_ and arg_165_1.time_ < var_168_6 + var_168_7 then
				local var_168_8 = (arg_165_1.time_ - var_168_6) / var_168_7
				local var_168_9 = Vector3.New(-0.7, -1.01, -6.05)

				var_168_5.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPos1017ui_story, var_168_9, var_168_8)

				local var_168_10 = manager.ui.mainCamera.transform.position - var_168_5.position

				var_168_5.forward = Vector3.New(var_168_10.x, var_168_10.y, var_168_10.z)

				local var_168_11 = var_168_5.localEulerAngles

				var_168_11.z = 0
				var_168_11.x = 0
				var_168_5.localEulerAngles = var_168_11
			end

			if arg_165_1.time_ >= var_168_6 + var_168_7 and arg_165_1.time_ < var_168_6 + var_168_7 + arg_168_0 then
				var_168_5.localPosition = Vector3.New(-0.7, -1.01, -6.05)

				local var_168_12 = manager.ui.mainCamera.transform.position - var_168_5.position

				var_168_5.forward = Vector3.New(var_168_12.x, var_168_12.y, var_168_12.z)

				local var_168_13 = var_168_5.localEulerAngles

				var_168_13.z = 0
				var_168_13.x = 0
				var_168_5.localEulerAngles = var_168_13
			end

			local var_168_14 = 0
			local var_168_15 = 0.225

			if var_168_14 < arg_165_1.time_ and arg_165_1.time_ <= var_168_14 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				local var_168_16 = arg_165_1:FormatText(StoryNameCfg[273].name)

				arg_165_1.leftNameTxt_.text = var_168_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_17 = arg_165_1:GetWordFromCfg(115181041)
				local var_168_18 = arg_165_1:FormatText(var_168_17.content)

				arg_165_1.text_.text = var_168_18

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_19 = 9
				local var_168_20 = utf8.len(var_168_18)
				local var_168_21 = var_168_19 <= 0 and var_168_15 or var_168_15 * (var_168_20 / var_168_19)

				if var_168_21 > 0 and var_168_15 < var_168_21 then
					arg_165_1.talkMaxDuration = var_168_21

					if var_168_21 + var_168_14 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_21 + var_168_14
					end
				end

				arg_165_1.text_.text = var_168_18
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115181", "115181041", "story_v_out_115181.awb") ~= 0 then
					local var_168_22 = manager.audio:GetVoiceLength("story_v_out_115181", "115181041", "story_v_out_115181.awb") / 1000

					if var_168_22 + var_168_14 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_22 + var_168_14
					end

					if var_168_17.prefab_name ~= "" and arg_165_1.actors_[var_168_17.prefab_name] ~= nil then
						local var_168_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_17.prefab_name].transform, "story_v_out_115181", "115181041", "story_v_out_115181.awb")

						arg_165_1:RecordAudio("115181041", var_168_23)
						arg_165_1:RecordAudio("115181041", var_168_23)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_115181", "115181041", "story_v_out_115181.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_115181", "115181041", "story_v_out_115181.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_24 = math.max(var_168_15, arg_165_1.talkMaxDuration)

			if var_168_14 <= arg_165_1.time_ and arg_165_1.time_ < var_168_14 + var_168_24 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_14) / var_168_24

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_14 + var_168_24 and arg_165_1.time_ < var_168_14 + var_168_24 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1017ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_165_1:InitPlayNodeList()
	end,
	Play115181042 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 115181042
		arg_169_1.duration_ = 4.7

		local var_169_0 = {
			ja = 4.7,
			ko = 3.2,
			zh = 2.9,
			en = 2.566
		}
		local var_169_1 = manager.audio:GetLocalizationFlag()

		if var_169_0[var_169_1] ~= nil then
			arg_169_1.duration_ = var_169_0[var_169_1]
		end

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play115181043(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = arg_169_1.actors_["1017ui_story"]
			local var_172_1 = 0

			if var_172_1 < arg_169_1.time_ and arg_169_1.time_ <= var_172_1 + arg_172_0 and not isNil(var_172_0) and arg_169_1.var_.characterEffect1017ui_story == nil then
				arg_169_1.var_.characterEffect1017ui_story = var_172_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_2 = 0.2

			if var_172_1 <= arg_169_1.time_ and arg_169_1.time_ < var_172_1 + var_172_2 and not isNil(var_172_0) then
				local var_172_3 = (arg_169_1.time_ - var_172_1) / var_172_2

				if arg_169_1.var_.characterEffect1017ui_story and not isNil(var_172_0) then
					local var_172_4 = Mathf.Lerp(0, 0.5, var_172_3)

					arg_169_1.var_.characterEffect1017ui_story.fillFlat = true
					arg_169_1.var_.characterEffect1017ui_story.fillRatio = var_172_4
				end
			end

			if arg_169_1.time_ >= var_172_1 + var_172_2 and arg_169_1.time_ < var_172_1 + var_172_2 + arg_172_0 and not isNil(var_172_0) and arg_169_1.var_.characterEffect1017ui_story then
				local var_172_5 = 0.5

				arg_169_1.var_.characterEffect1017ui_story.fillFlat = true
				arg_169_1.var_.characterEffect1017ui_story.fillRatio = var_172_5
			end

			local var_172_6 = 0

			if var_172_6 < arg_169_1.time_ and arg_169_1.time_ <= var_172_6 + arg_172_0 then
				arg_169_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_172_7 = arg_169_1.actors_["1024ui_story"]
			local var_172_8 = 0

			if var_172_8 < arg_169_1.time_ and arg_169_1.time_ <= var_172_8 + arg_172_0 and not isNil(var_172_7) and arg_169_1.var_.characterEffect1024ui_story == nil then
				arg_169_1.var_.characterEffect1024ui_story = var_172_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_9 = 0.2

			if var_172_8 <= arg_169_1.time_ and arg_169_1.time_ < var_172_8 + var_172_9 and not isNil(var_172_7) then
				local var_172_10 = (arg_169_1.time_ - var_172_8) / var_172_9

				if arg_169_1.var_.characterEffect1024ui_story and not isNil(var_172_7) then
					arg_169_1.var_.characterEffect1024ui_story.fillFlat = false
				end
			end

			if arg_169_1.time_ >= var_172_8 + var_172_9 and arg_169_1.time_ < var_172_8 + var_172_9 + arg_172_0 and not isNil(var_172_7) and arg_169_1.var_.characterEffect1024ui_story then
				arg_169_1.var_.characterEffect1024ui_story.fillFlat = false
			end

			local var_172_11 = arg_169_1.actors_["1024ui_story"].transform
			local var_172_12 = 0

			if var_172_12 < arg_169_1.time_ and arg_169_1.time_ <= var_172_12 + arg_172_0 then
				arg_169_1.var_.moveOldPos1024ui_story = var_172_11.localPosition
			end

			local var_172_13 = 0.001

			if var_172_12 <= arg_169_1.time_ and arg_169_1.time_ < var_172_12 + var_172_13 then
				local var_172_14 = (arg_169_1.time_ - var_172_12) / var_172_13
				local var_172_15 = Vector3.New(0.7, -1, -6.05)

				var_172_11.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPos1024ui_story, var_172_15, var_172_14)

				local var_172_16 = manager.ui.mainCamera.transform.position - var_172_11.position

				var_172_11.forward = Vector3.New(var_172_16.x, var_172_16.y, var_172_16.z)

				local var_172_17 = var_172_11.localEulerAngles

				var_172_17.z = 0
				var_172_17.x = 0
				var_172_11.localEulerAngles = var_172_17
			end

			if arg_169_1.time_ >= var_172_12 + var_172_13 and arg_169_1.time_ < var_172_12 + var_172_13 + arg_172_0 then
				var_172_11.localPosition = Vector3.New(0.7, -1, -6.05)

				local var_172_18 = manager.ui.mainCamera.transform.position - var_172_11.position

				var_172_11.forward = Vector3.New(var_172_18.x, var_172_18.y, var_172_18.z)

				local var_172_19 = var_172_11.localEulerAngles

				var_172_19.z = 0
				var_172_19.x = 0
				var_172_11.localEulerAngles = var_172_19
			end

			local var_172_20 = 0
			local var_172_21 = 0.3

			if var_172_20 < arg_169_1.time_ and arg_169_1.time_ <= var_172_20 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				local var_172_22 = arg_169_1:FormatText(StoryNameCfg[265].name)

				arg_169_1.leftNameTxt_.text = var_172_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_23 = arg_169_1:GetWordFromCfg(115181042)
				local var_172_24 = arg_169_1:FormatText(var_172_23.content)

				arg_169_1.text_.text = var_172_24

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_25 = 12
				local var_172_26 = utf8.len(var_172_24)
				local var_172_27 = var_172_25 <= 0 and var_172_21 or var_172_21 * (var_172_26 / var_172_25)

				if var_172_27 > 0 and var_172_21 < var_172_27 then
					arg_169_1.talkMaxDuration = var_172_27

					if var_172_27 + var_172_20 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_27 + var_172_20
					end
				end

				arg_169_1.text_.text = var_172_24
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115181", "115181042", "story_v_out_115181.awb") ~= 0 then
					local var_172_28 = manager.audio:GetVoiceLength("story_v_out_115181", "115181042", "story_v_out_115181.awb") / 1000

					if var_172_28 + var_172_20 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_28 + var_172_20
					end

					if var_172_23.prefab_name ~= "" and arg_169_1.actors_[var_172_23.prefab_name] ~= nil then
						local var_172_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_23.prefab_name].transform, "story_v_out_115181", "115181042", "story_v_out_115181.awb")

						arg_169_1:RecordAudio("115181042", var_172_29)
						arg_169_1:RecordAudio("115181042", var_172_29)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_115181", "115181042", "story_v_out_115181.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_115181", "115181042", "story_v_out_115181.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_30 = math.max(var_172_21, arg_169_1.talkMaxDuration)

			if var_172_20 <= arg_169_1.time_ and arg_169_1.time_ < var_172_20 + var_172_30 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_20) / var_172_30

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_20 + var_172_30 and arg_169_1.time_ < var_172_20 + var_172_30 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_169_1:InitPlayNodeList()
	end,
	Play115181043 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 115181043
		arg_173_1.duration_ = 2

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
			arg_173_1.auto_ = false
		end

		function arg_173_1.playNext_(arg_175_0)
			arg_173_1.onStoryFinished_()
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = arg_173_1.actors_["1017ui_story"]
			local var_176_1 = 0

			if var_176_1 < arg_173_1.time_ and arg_173_1.time_ <= var_176_1 + arg_176_0 and not isNil(var_176_0) and arg_173_1.var_.characterEffect1017ui_story == nil then
				arg_173_1.var_.characterEffect1017ui_story = var_176_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_2 = 0.2

			if var_176_1 <= arg_173_1.time_ and arg_173_1.time_ < var_176_1 + var_176_2 and not isNil(var_176_0) then
				local var_176_3 = (arg_173_1.time_ - var_176_1) / var_176_2

				if arg_173_1.var_.characterEffect1017ui_story and not isNil(var_176_0) then
					arg_173_1.var_.characterEffect1017ui_story.fillFlat = false
				end
			end

			if arg_173_1.time_ >= var_176_1 + var_176_2 and arg_173_1.time_ < var_176_1 + var_176_2 + arg_176_0 and not isNil(var_176_0) and arg_173_1.var_.characterEffect1017ui_story then
				arg_173_1.var_.characterEffect1017ui_story.fillFlat = false
			end

			local var_176_4 = arg_173_1.actors_["1024ui_story"]
			local var_176_5 = 0

			if var_176_5 < arg_173_1.time_ and arg_173_1.time_ <= var_176_5 + arg_176_0 and not isNil(var_176_4) and arg_173_1.var_.characterEffect1024ui_story == nil then
				arg_173_1.var_.characterEffect1024ui_story = var_176_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_6 = 0.2

			if var_176_5 <= arg_173_1.time_ and arg_173_1.time_ < var_176_5 + var_176_6 and not isNil(var_176_4) then
				local var_176_7 = (arg_173_1.time_ - var_176_5) / var_176_6

				if arg_173_1.var_.characterEffect1024ui_story and not isNil(var_176_4) then
					local var_176_8 = Mathf.Lerp(0, 0.5, var_176_7)

					arg_173_1.var_.characterEffect1024ui_story.fillFlat = true
					arg_173_1.var_.characterEffect1024ui_story.fillRatio = var_176_8
				end
			end

			if arg_173_1.time_ >= var_176_5 + var_176_6 and arg_173_1.time_ < var_176_5 + var_176_6 + arg_176_0 and not isNil(var_176_4) and arg_173_1.var_.characterEffect1024ui_story then
				local var_176_9 = 0.5

				arg_173_1.var_.characterEffect1024ui_story.fillFlat = true
				arg_173_1.var_.characterEffect1024ui_story.fillRatio = var_176_9
			end

			local var_176_10 = 0

			if var_176_10 < arg_173_1.time_ and arg_173_1.time_ <= var_176_10 + arg_176_0 then
				arg_173_1:PlayTimeline("1017ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_176_11 = 0
			local var_176_12 = 0.05

			if var_176_11 < arg_173_1.time_ and arg_173_1.time_ <= var_176_11 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				local var_176_13 = arg_173_1:FormatText(StoryNameCfg[273].name)

				arg_173_1.leftNameTxt_.text = var_176_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_14 = arg_173_1:GetWordFromCfg(115181043)
				local var_176_15 = arg_173_1:FormatText(var_176_14.content)

				arg_173_1.text_.text = var_176_15

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_16 = 2
				local var_176_17 = utf8.len(var_176_15)
				local var_176_18 = var_176_16 <= 0 and var_176_12 or var_176_12 * (var_176_17 / var_176_16)

				if var_176_18 > 0 and var_176_12 < var_176_18 then
					arg_173_1.talkMaxDuration = var_176_18

					if var_176_18 + var_176_11 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_18 + var_176_11
					end
				end

				arg_173_1.text_.text = var_176_15
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115181", "115181043", "story_v_out_115181.awb") ~= 0 then
					local var_176_19 = manager.audio:GetVoiceLength("story_v_out_115181", "115181043", "story_v_out_115181.awb") / 1000

					if var_176_19 + var_176_11 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_19 + var_176_11
					end

					if var_176_14.prefab_name ~= "" and arg_173_1.actors_[var_176_14.prefab_name] ~= nil then
						local var_176_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_14.prefab_name].transform, "story_v_out_115181", "115181043", "story_v_out_115181.awb")

						arg_173_1:RecordAudio("115181043", var_176_20)
						arg_173_1:RecordAudio("115181043", var_176_20)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_115181", "115181043", "story_v_out_115181.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_115181", "115181043", "story_v_out_115181.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_21 = math.max(var_176_12, arg_173_1.talkMaxDuration)

			if var_176_11 <= arg_173_1.time_ and arg_173_1.time_ < var_176_11 + var_176_21 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_11) / var_176_21

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_11 + var_176_21 and arg_173_1.time_ < var_176_11 + var_176_21 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/G02b"
	},
	voices = {
		"story_v_out_115181.awb"
	}
}
