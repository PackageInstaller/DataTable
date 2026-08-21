return {
	Play116291001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 116291001
		arg_1_1.duration_ = 14

		local var_1_0 = {
			zh = 10.7,
			ja = 14
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
				arg_1_0:Play116291002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "I03"

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
				local var_4_5 = arg_1_1.bgs_.I03

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
					if iter_4_0 ~= "I03" then
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
			local var_4_23 = 0.15

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

			local var_4_28 = 0.266666666666667
			local var_4_29 = 0.733333333333333

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				local var_4_30 = "play"
				local var_4_31 = "music"

				arg_1_1:AudioAction(var_4_30, var_4_31, "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1.awb")

				local var_4_32 = ""
				local var_4_33 = manager.audio:GetAudioName("bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1")

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

			local var_4_34 = 2
			local var_4_35 = 1

			if var_4_34 < arg_1_1.time_ and arg_1_1.time_ <= var_4_34 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0
				arg_1_1.dialogCg_.alpha = 1

				arg_1_1.dialog_:SetActive(true)
				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_36 = arg_1_1:FormatText(StoryNameCfg[8].name)

				arg_1_1.leftNameTxt_.text = var_4_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1148")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_37 = arg_1_1:GetWordFromCfg(116291001)
				local var_4_38 = arg_1_1:FormatText(var_4_37.content)

				arg_1_1.text_.text = var_4_38

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_39 = 40
				local var_4_40 = utf8.len(var_4_38)
				local var_4_41 = var_4_39 <= 0 and var_4_35 or var_4_35 * (var_4_40 / var_4_39)

				if var_4_41 > 0 and var_4_35 < var_4_41 then
					arg_1_1.talkMaxDuration = var_4_41

					if var_4_41 + var_4_34 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_41 + var_4_34
					end
				end

				arg_1_1.text_.text = var_4_38
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116291", "116291001", "story_v_out_116291.awb") ~= 0 then
					local var_4_42 = manager.audio:GetVoiceLength("story_v_out_116291", "116291001", "story_v_out_116291.awb") / 1000

					if var_4_42 + var_4_34 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_42 + var_4_34
					end

					if var_4_37.prefab_name ~= "" and arg_1_1.actors_[var_4_37.prefab_name] ~= nil then
						local var_4_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_37.prefab_name].transform, "story_v_out_116291", "116291001", "story_v_out_116291.awb")

						arg_1_1:RecordAudio("116291001", var_4_43)
						arg_1_1:RecordAudio("116291001", var_4_43)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_116291", "116291001", "story_v_out_116291.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_116291", "116291001", "story_v_out_116291.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_44 = math.max(var_4_35, arg_1_1.talkMaxDuration)

			if var_4_34 <= arg_1_1.time_ and arg_1_1.time_ < var_4_34 + var_4_44 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_34) / var_4_44

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_34 + var_4_44 and arg_1_1.time_ < var_4_34 + var_4_44 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play116291002 = function(arg_7_0, arg_7_1)
		arg_7_1.time_ = 0
		arg_7_1.frameCnt_ = 0
		arg_7_1.state_ = "playing"
		arg_7_1.curTalkId_ = 116291002
		arg_7_1.duration_ = 5

		SetActive(arg_7_1.tipsGo_, false)

		function arg_7_1.onSingleLineFinish_()
			arg_7_1.onSingleLineUpdate_ = nil
			arg_7_1.onSingleLineFinish_ = nil
			arg_7_1.state_ = "waiting"
		end

		function arg_7_1.playNext_(arg_9_0)
			if arg_9_0 == 1 then
				arg_7_0:Play116291003(arg_7_1)
			end
		end

		function arg_7_1.onSingleLineUpdate_(arg_10_0)
			local var_10_0 = "1148ui_story"

			if arg_7_1.actors_[var_10_0] == nil then
				local var_10_1 = Asset.Load("Char/" .. "1148ui_story")

				if not isNil(var_10_1) then
					local var_10_2 = Object.Instantiate(Asset.Load("Char/" .. "1148ui_story"), arg_7_1.stage_.transform)

					var_10_2.name = var_10_0
					var_10_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_7_1.actors_[var_10_0] = var_10_2

					local var_10_3 = var_10_2:GetComponentInChildren(typeof(CharacterEffect))

					var_10_3.enabled = true

					local var_10_4 = GameObjectTools.GetOrAddComponent(var_10_2, typeof(DynamicBoneHelper))

					if var_10_4 then
						var_10_4:EnableDynamicBone(false)
					end

					arg_7_1:ShowWeapon(var_10_3.transform, false)

					arg_7_1.var_[var_10_0 .. "Animator"] = var_10_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_7_1.var_[var_10_0 .. "Animator"].applyRootMotion = true
					arg_7_1.var_[var_10_0 .. "LipSync"] = var_10_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_10_5 = arg_7_1.actors_["1148ui_story"].transform
			local var_10_6 = 0

			if var_10_6 < arg_7_1.time_ and arg_7_1.time_ <= var_10_6 + arg_10_0 then
				arg_7_1.var_.moveOldPos1148ui_story = var_10_5.localPosition
			end

			local var_10_7 = 0.001

			if var_10_6 <= arg_7_1.time_ and arg_7_1.time_ < var_10_6 + var_10_7 then
				local var_10_8 = (arg_7_1.time_ - var_10_6) / var_10_7
				local var_10_9 = Vector3.New(0, 100, 0)

				var_10_5.localPosition = Vector3.Lerp(arg_7_1.var_.moveOldPos1148ui_story, var_10_9, var_10_8)

				local var_10_10 = manager.ui.mainCamera.transform.position - var_10_5.position

				var_10_5.forward = Vector3.New(var_10_10.x, var_10_10.y, var_10_10.z)

				local var_10_11 = var_10_5.localEulerAngles

				var_10_11.z = 0
				var_10_11.x = 0
				var_10_5.localEulerAngles = var_10_11
			end

			if arg_7_1.time_ >= var_10_6 + var_10_7 and arg_7_1.time_ < var_10_6 + var_10_7 + arg_10_0 then
				var_10_5.localPosition = Vector3.New(0, 100, 0)

				local var_10_12 = manager.ui.mainCamera.transform.position - var_10_5.position

				var_10_5.forward = Vector3.New(var_10_12.x, var_10_12.y, var_10_12.z)

				local var_10_13 = var_10_5.localEulerAngles

				var_10_13.z = 0
				var_10_13.x = 0
				var_10_5.localEulerAngles = var_10_13
			end

			local var_10_14 = 0
			local var_10_15 = 1.025

			if var_10_14 < arg_7_1.time_ and arg_7_1.time_ <= var_10_14 + arg_10_0 then
				arg_7_1.talkMaxDuration = 0
				arg_7_1.dialogCg_.alpha = 1

				arg_7_1.dialog_:SetActive(true)
				SetActive(arg_7_1.leftNameGo_, false)

				arg_7_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_7_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_7_1:RecordName(arg_7_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_7_1.iconTrs_.gameObject, false)
				arg_7_1.callingController_:SetSelectedState("normal")

				local var_10_16 = arg_7_1:GetWordFromCfg(116291002)
				local var_10_17 = arg_7_1:FormatText(var_10_16.content)

				arg_7_1.text_.text = var_10_17

				LuaForUtil.ClearLinePrefixSymbol(arg_7_1.text_)

				local var_10_18 = 41
				local var_10_19 = utf8.len(var_10_17)
				local var_10_20 = var_10_18 <= 0 and var_10_15 or var_10_15 * (var_10_19 / var_10_18)

				if var_10_20 > 0 and var_10_15 < var_10_20 then
					arg_7_1.talkMaxDuration = var_10_20

					if var_10_20 + var_10_14 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_20 + var_10_14
					end
				end

				arg_7_1.text_.text = var_10_17
				arg_7_1.typewritter.percent = 0

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(false)
				arg_7_1:RecordContent(arg_7_1.text_.text)
			end

			local var_10_21 = math.max(var_10_15, arg_7_1.talkMaxDuration)

			if var_10_14 <= arg_7_1.time_ and arg_7_1.time_ < var_10_14 + var_10_21 then
				arg_7_1.typewritter.percent = (arg_7_1.time_ - var_10_14) / var_10_21

				arg_7_1.typewritter:SetDirty()
			end

			if arg_7_1.time_ >= var_10_14 + var_10_21 and arg_7_1.time_ < var_10_14 + var_10_21 + arg_10_0 then
				arg_7_1.typewritter.percent = 1

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(true)
			end
		end

		arg_7_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_7_1:InitPlayNodeList()
	end,
	Play116291003 = function(arg_11_0, arg_11_1)
		arg_11_1.time_ = 0
		arg_11_1.frameCnt_ = 0
		arg_11_1.state_ = "playing"
		arg_11_1.curTalkId_ = 116291003
		arg_11_1.duration_ = 5

		SetActive(arg_11_1.tipsGo_, false)

		function arg_11_1.onSingleLineFinish_()
			arg_11_1.onSingleLineUpdate_ = nil
			arg_11_1.onSingleLineFinish_ = nil
			arg_11_1.state_ = "waiting"
		end

		function arg_11_1.playNext_(arg_13_0)
			if arg_13_0 == 1 then
				arg_11_0:Play116291004(arg_11_1)
			end
		end

		function arg_11_1.onSingleLineUpdate_(arg_14_0)
			local var_14_0 = 0
			local var_14_1 = 1.6

			if var_14_0 < arg_11_1.time_ and arg_11_1.time_ <= var_14_0 + arg_14_0 then
				arg_11_1.talkMaxDuration = 0
				arg_11_1.dialogCg_.alpha = 1

				arg_11_1.dialog_:SetActive(true)
				SetActive(arg_11_1.leftNameGo_, false)

				arg_11_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_11_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_11_1:RecordName(arg_11_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_11_1.iconTrs_.gameObject, false)
				arg_11_1.callingController_:SetSelectedState("normal")

				local var_14_2 = arg_11_1:GetWordFromCfg(116291003)
				local var_14_3 = arg_11_1:FormatText(var_14_2.content)

				arg_11_1.text_.text = var_14_3

				LuaForUtil.ClearLinePrefixSymbol(arg_11_1.text_)

				local var_14_4 = 64
				local var_14_5 = utf8.len(var_14_3)
				local var_14_6 = var_14_4 <= 0 and var_14_1 or var_14_1 * (var_14_5 / var_14_4)

				if var_14_6 > 0 and var_14_1 < var_14_6 then
					arg_11_1.talkMaxDuration = var_14_6

					if var_14_6 + var_14_0 > arg_11_1.duration_ then
						arg_11_1.duration_ = var_14_6 + var_14_0
					end
				end

				arg_11_1.text_.text = var_14_3
				arg_11_1.typewritter.percent = 0

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(false)
				arg_11_1:RecordContent(arg_11_1.text_.text)
			end

			local var_14_7 = math.max(var_14_1, arg_11_1.talkMaxDuration)

			if var_14_0 <= arg_11_1.time_ and arg_11_1.time_ < var_14_0 + var_14_7 then
				arg_11_1.typewritter.percent = (arg_11_1.time_ - var_14_0) / var_14_7

				arg_11_1.typewritter:SetDirty()
			end

			if arg_11_1.time_ >= var_14_0 + var_14_7 and arg_11_1.time_ < var_14_0 + var_14_7 + arg_14_0 then
				arg_11_1.typewritter.percent = 1

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(true)
			end
		end

		arg_11_1.nodeConfigList_ = {}

		arg_11_1:InitPlayNodeList()
	end,
	Play116291004 = function(arg_15_0, arg_15_1)
		arg_15_1.time_ = 0
		arg_15_1.frameCnt_ = 0
		arg_15_1.state_ = "playing"
		arg_15_1.curTalkId_ = 116291004
		arg_15_1.duration_ = 5

		SetActive(arg_15_1.tipsGo_, false)

		function arg_15_1.onSingleLineFinish_()
			arg_15_1.onSingleLineUpdate_ = nil
			arg_15_1.onSingleLineFinish_ = nil
			arg_15_1.state_ = "waiting"
		end

		function arg_15_1.playNext_(arg_17_0)
			if arg_17_0 == 1 then
				arg_15_0:Play116291005(arg_15_1)
			end
		end

		function arg_15_1.onSingleLineUpdate_(arg_18_0)
			local var_18_0 = 0
			local var_18_1 = 0.45

			if var_18_0 < arg_15_1.time_ and arg_15_1.time_ <= var_18_0 + arg_18_0 then
				arg_15_1.talkMaxDuration = 0
				arg_15_1.dialogCg_.alpha = 1

				arg_15_1.dialog_:SetActive(true)
				SetActive(arg_15_1.leftNameGo_, true)

				local var_18_2 = arg_15_1:FormatText(StoryNameCfg[7].name)

				arg_15_1.leftNameTxt_.text = var_18_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_15_1.leftNameTxt_.transform)

				arg_15_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_15_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_15_1:RecordName(arg_15_1.leftNameTxt_.text)
				SetActive(arg_15_1.iconTrs_.gameObject, true)
				arg_15_1.iconController_:SetSelectedState("hero")

				arg_15_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_15_1.callingController_:SetSelectedState("normal")

				arg_15_1.keyicon_.color = Color.New(1, 1, 1)
				arg_15_1.icon_.color = Color.New(1, 1, 1)

				local var_18_3 = arg_15_1:GetWordFromCfg(116291004)
				local var_18_4 = arg_15_1:FormatText(var_18_3.content)

				arg_15_1.text_.text = var_18_4

				LuaForUtil.ClearLinePrefixSymbol(arg_15_1.text_)

				local var_18_5 = 18
				local var_18_6 = utf8.len(var_18_4)
				local var_18_7 = var_18_5 <= 0 and var_18_1 or var_18_1 * (var_18_6 / var_18_5)

				if var_18_7 > 0 and var_18_1 < var_18_7 then
					arg_15_1.talkMaxDuration = var_18_7

					if var_18_7 + var_18_0 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_7 + var_18_0
					end
				end

				arg_15_1.text_.text = var_18_4
				arg_15_1.typewritter.percent = 0

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(false)
				arg_15_1:RecordContent(arg_15_1.text_.text)
			end

			local var_18_8 = math.max(var_18_1, arg_15_1.talkMaxDuration)

			if var_18_0 <= arg_15_1.time_ and arg_15_1.time_ < var_18_0 + var_18_8 then
				arg_15_1.typewritter.percent = (arg_15_1.time_ - var_18_0) / var_18_8

				arg_15_1.typewritter:SetDirty()
			end

			if arg_15_1.time_ >= var_18_0 + var_18_8 and arg_15_1.time_ < var_18_0 + var_18_8 + arg_18_0 then
				arg_15_1.typewritter.percent = 1

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(true)
			end
		end

		arg_15_1.nodeConfigList_ = {}

		arg_15_1:InitPlayNodeList()
	end,
	Play116291005 = function(arg_19_0, arg_19_1)
		arg_19_1.time_ = 0
		arg_19_1.frameCnt_ = 0
		arg_19_1.state_ = "playing"
		arg_19_1.curTalkId_ = 116291005
		arg_19_1.duration_ = 3.07

		local var_19_0 = {
			zh = 2.833,
			ja = 3.066
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
				arg_19_0:Play116291006(arg_19_1)
			end
		end

		function arg_19_1.onSingleLineUpdate_(arg_22_0)
			local var_22_0 = "10025ui_story"

			if arg_19_1.actors_[var_22_0] == nil then
				local var_22_1 = Asset.Load("Char/" .. "10025ui_story")

				if not isNil(var_22_1) then
					local var_22_2 = Object.Instantiate(Asset.Load("Char/" .. "10025ui_story"), arg_19_1.stage_.transform)

					var_22_2.name = var_22_0
					var_22_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_19_1.actors_[var_22_0] = var_22_2

					local var_22_3 = var_22_2:GetComponentInChildren(typeof(CharacterEffect))

					var_22_3.enabled = true

					local var_22_4 = GameObjectTools.GetOrAddComponent(var_22_2, typeof(DynamicBoneHelper))

					if var_22_4 then
						var_22_4:EnableDynamicBone(false)
					end

					arg_19_1:ShowWeapon(var_22_3.transform, false)

					arg_19_1.var_[var_22_0 .. "Animator"] = var_22_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_19_1.var_[var_22_0 .. "Animator"].applyRootMotion = true
					arg_19_1.var_[var_22_0 .. "LipSync"] = var_22_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_22_5 = arg_19_1.actors_["10025ui_story"].transform
			local var_22_6 = 0

			if var_22_6 < arg_19_1.time_ and arg_19_1.time_ <= var_22_6 + arg_22_0 then
				arg_19_1.var_.moveOldPos10025ui_story = var_22_5.localPosition
			end

			local var_22_7 = 0.001

			if var_22_6 <= arg_19_1.time_ and arg_19_1.time_ < var_22_6 + var_22_7 then
				local var_22_8 = (arg_19_1.time_ - var_22_6) / var_22_7
				local var_22_9 = Vector3.New(0, -1.1, -5.9)

				var_22_5.localPosition = Vector3.Lerp(arg_19_1.var_.moveOldPos10025ui_story, var_22_9, var_22_8)

				local var_22_10 = manager.ui.mainCamera.transform.position - var_22_5.position

				var_22_5.forward = Vector3.New(var_22_10.x, var_22_10.y, var_22_10.z)

				local var_22_11 = var_22_5.localEulerAngles

				var_22_11.z = 0
				var_22_11.x = 0
				var_22_5.localEulerAngles = var_22_11
			end

			if arg_19_1.time_ >= var_22_6 + var_22_7 and arg_19_1.time_ < var_22_6 + var_22_7 + arg_22_0 then
				var_22_5.localPosition = Vector3.New(0, -1.1, -5.9)

				local var_22_12 = manager.ui.mainCamera.transform.position - var_22_5.position

				var_22_5.forward = Vector3.New(var_22_12.x, var_22_12.y, var_22_12.z)

				local var_22_13 = var_22_5.localEulerAngles

				var_22_13.z = 0
				var_22_13.x = 0
				var_22_5.localEulerAngles = var_22_13
			end

			local var_22_14 = arg_19_1.actors_["10025ui_story"]
			local var_22_15 = 0

			if var_22_15 < arg_19_1.time_ and arg_19_1.time_ <= var_22_15 + arg_22_0 and not isNil(var_22_14) and arg_19_1.var_.characterEffect10025ui_story == nil then
				arg_19_1.var_.characterEffect10025ui_story = var_22_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_22_16 = 0.2

			if var_22_15 <= arg_19_1.time_ and arg_19_1.time_ < var_22_15 + var_22_16 and not isNil(var_22_14) then
				local var_22_17 = (arg_19_1.time_ - var_22_15) / var_22_16

				if arg_19_1.var_.characterEffect10025ui_story and not isNil(var_22_14) then
					arg_19_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_19_1.time_ >= var_22_15 + var_22_16 and arg_19_1.time_ < var_22_15 + var_22_16 + arg_22_0 and not isNil(var_22_14) and arg_19_1.var_.characterEffect10025ui_story then
				arg_19_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			local var_22_18 = 0

			if var_22_18 < arg_19_1.time_ and arg_19_1.time_ <= var_22_18 + arg_22_0 then
				arg_19_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action1_1")
			end

			local var_22_19 = 0

			if var_22_19 < arg_19_1.time_ and arg_19_1.time_ <= var_22_19 + arg_22_0 then
				arg_19_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_22_20 = 0
			local var_22_21 = 0.25

			if var_22_20 < arg_19_1.time_ and arg_19_1.time_ <= var_22_20 + arg_22_0 then
				arg_19_1.talkMaxDuration = 0
				arg_19_1.dialogCg_.alpha = 1

				arg_19_1.dialog_:SetActive(true)
				SetActive(arg_19_1.leftNameGo_, true)

				local var_22_22 = arg_19_1:FormatText(StoryNameCfg[328].name)

				arg_19_1.leftNameTxt_.text = var_22_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_19_1.leftNameTxt_.transform)

				arg_19_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_19_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_19_1:RecordName(arg_19_1.leftNameTxt_.text)
				SetActive(arg_19_1.iconTrs_.gameObject, false)
				arg_19_1.callingController_:SetSelectedState("normal")

				local var_22_23 = arg_19_1:GetWordFromCfg(116291005)
				local var_22_24 = arg_19_1:FormatText(var_22_23.content)

				arg_19_1.text_.text = var_22_24

				LuaForUtil.ClearLinePrefixSymbol(arg_19_1.text_)

				local var_22_25 = 10
				local var_22_26 = utf8.len(var_22_24)
				local var_22_27 = var_22_25 <= 0 and var_22_21 or var_22_21 * (var_22_26 / var_22_25)

				if var_22_27 > 0 and var_22_21 < var_22_27 then
					arg_19_1.talkMaxDuration = var_22_27

					if var_22_27 + var_22_20 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_27 + var_22_20
					end
				end

				arg_19_1.text_.text = var_22_24
				arg_19_1.typewritter.percent = 0

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116291", "116291005", "story_v_out_116291.awb") ~= 0 then
					local var_22_28 = manager.audio:GetVoiceLength("story_v_out_116291", "116291005", "story_v_out_116291.awb") / 1000

					if var_22_28 + var_22_20 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_28 + var_22_20
					end

					if var_22_23.prefab_name ~= "" and arg_19_1.actors_[var_22_23.prefab_name] ~= nil then
						local var_22_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_19_1.actors_[var_22_23.prefab_name].transform, "story_v_out_116291", "116291005", "story_v_out_116291.awb")

						arg_19_1:RecordAudio("116291005", var_22_29)
						arg_19_1:RecordAudio("116291005", var_22_29)
					else
						arg_19_1:AudioAction("play", "voice", "story_v_out_116291", "116291005", "story_v_out_116291.awb")
					end

					arg_19_1:RecordHistoryTalkVoice("story_v_out_116291", "116291005", "story_v_out_116291.awb")
				end

				arg_19_1:RecordContent(arg_19_1.text_.text)
			end

			local var_22_30 = math.max(var_22_21, arg_19_1.talkMaxDuration)

			if var_22_20 <= arg_19_1.time_ and arg_19_1.time_ < var_22_20 + var_22_30 then
				arg_19_1.typewritter.percent = (arg_19_1.time_ - var_22_20) / var_22_30

				arg_19_1.typewritter:SetDirty()
			end

			if arg_19_1.time_ >= var_22_20 + var_22_30 and arg_19_1.time_ < var_22_20 + var_22_30 + arg_22_0 then
				arg_19_1.typewritter.percent = 1

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(true)
			end
		end

		arg_19_1.nodeConfigList_ = {
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

		arg_19_1:InitPlayNodeList()
	end,
	Play116291006 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 116291006
		arg_23_1.duration_ = 5

		SetActive(arg_23_1.tipsGo_, false)

		function arg_23_1.onSingleLineFinish_()
			arg_23_1.onSingleLineUpdate_ = nil
			arg_23_1.onSingleLineFinish_ = nil
			arg_23_1.state_ = "waiting"
		end

		function arg_23_1.playNext_(arg_25_0)
			if arg_25_0 == 1 then
				arg_23_0:Play116291007(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			local var_26_0 = arg_23_1.actors_["10025ui_story"]
			local var_26_1 = 0

			if var_26_1 < arg_23_1.time_ and arg_23_1.time_ <= var_26_1 + arg_26_0 and not isNil(var_26_0) and arg_23_1.var_.characterEffect10025ui_story == nil then
				arg_23_1.var_.characterEffect10025ui_story = var_26_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_26_2 = 0.2

			if var_26_1 <= arg_23_1.time_ and arg_23_1.time_ < var_26_1 + var_26_2 and not isNil(var_26_0) then
				local var_26_3 = (arg_23_1.time_ - var_26_1) / var_26_2

				if arg_23_1.var_.characterEffect10025ui_story and not isNil(var_26_0) then
					local var_26_4 = Mathf.Lerp(0, 0.5, var_26_3)

					arg_23_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_23_1.var_.characterEffect10025ui_story.fillRatio = var_26_4
				end
			end

			if arg_23_1.time_ >= var_26_1 + var_26_2 and arg_23_1.time_ < var_26_1 + var_26_2 + arg_26_0 and not isNil(var_26_0) and arg_23_1.var_.characterEffect10025ui_story then
				local var_26_5 = 0.5

				arg_23_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_23_1.var_.characterEffect10025ui_story.fillRatio = var_26_5
			end

			local var_26_6 = 0
			local var_26_7 = 0.325

			if var_26_6 < arg_23_1.time_ and arg_23_1.time_ <= var_26_6 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0
				arg_23_1.dialogCg_.alpha = 1

				arg_23_1.dialog_:SetActive(true)
				SetActive(arg_23_1.leftNameGo_, true)

				local var_26_8 = arg_23_1:FormatText(StoryNameCfg[7].name)

				arg_23_1.leftNameTxt_.text = var_26_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_23_1.leftNameTxt_.transform)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1.leftNameTxt_.text)
				SetActive(arg_23_1.iconTrs_.gameObject, true)
				arg_23_1.iconController_:SetSelectedState("hero")

				arg_23_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_23_1.callingController_:SetSelectedState("normal")

				arg_23_1.keyicon_.color = Color.New(1, 1, 1)
				arg_23_1.icon_.color = Color.New(1, 1, 1)

				local var_26_9 = arg_23_1:GetWordFromCfg(116291006)
				local var_26_10 = arg_23_1:FormatText(var_26_9.content)

				arg_23_1.text_.text = var_26_10

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_11 = 13
				local var_26_12 = utf8.len(var_26_10)
				local var_26_13 = var_26_11 <= 0 and var_26_7 or var_26_7 * (var_26_12 / var_26_11)

				if var_26_13 > 0 and var_26_7 < var_26_13 then
					arg_23_1.talkMaxDuration = var_26_13

					if var_26_13 + var_26_6 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_13 + var_26_6
					end
				end

				arg_23_1.text_.text = var_26_10
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)
				arg_23_1:RecordContent(arg_23_1.text_.text)
			end

			local var_26_14 = math.max(var_26_7, arg_23_1.talkMaxDuration)

			if var_26_6 <= arg_23_1.time_ and arg_23_1.time_ < var_26_6 + var_26_14 then
				arg_23_1.typewritter.percent = (arg_23_1.time_ - var_26_6) / var_26_14

				arg_23_1.typewritter:SetDirty()
			end

			if arg_23_1.time_ >= var_26_6 + var_26_14 and arg_23_1.time_ < var_26_6 + var_26_14 + arg_26_0 then
				arg_23_1.typewritter.percent = 1

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(true)
			end
		end

		arg_23_1.nodeConfigList_ = {}

		arg_23_1:InitPlayNodeList()
	end,
	Play116291007 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 116291007
		arg_27_1.duration_ = 5

		SetActive(arg_27_1.tipsGo_, false)

		function arg_27_1.onSingleLineFinish_()
			arg_27_1.onSingleLineUpdate_ = nil
			arg_27_1.onSingleLineFinish_ = nil
			arg_27_1.state_ = "waiting"
		end

		function arg_27_1.playNext_(arg_29_0)
			if arg_29_0 == 1 then
				arg_27_0:Play116291008(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			local var_30_0 = 0
			local var_30_1 = 0.6

			if var_30_0 < arg_27_1.time_ and arg_27_1.time_ <= var_30_0 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, true)

				local var_30_2 = arg_27_1:FormatText(StoryNameCfg[7].name)

				arg_27_1.leftNameTxt_.text = var_30_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_27_1.leftNameTxt_.transform)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1.leftNameTxt_.text)
				SetActive(arg_27_1.iconTrs_.gameObject, true)
				arg_27_1.iconController_:SetSelectedState("hero")

				arg_27_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_27_1.callingController_:SetSelectedState("normal")

				arg_27_1.keyicon_.color = Color.New(1, 1, 1)
				arg_27_1.icon_.color = Color.New(1, 1, 1)

				local var_30_3 = arg_27_1:GetWordFromCfg(116291007)
				local var_30_4 = arg_27_1:FormatText(var_30_3.content)

				arg_27_1.text_.text = var_30_4

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_5 = 24
				local var_30_6 = utf8.len(var_30_4)
				local var_30_7 = var_30_5 <= 0 and var_30_1 or var_30_1 * (var_30_6 / var_30_5)

				if var_30_7 > 0 and var_30_1 < var_30_7 then
					arg_27_1.talkMaxDuration = var_30_7

					if var_30_7 + var_30_0 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_7 + var_30_0
					end
				end

				arg_27_1.text_.text = var_30_4
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)
				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_8 = math.max(var_30_1, arg_27_1.talkMaxDuration)

			if var_30_0 <= arg_27_1.time_ and arg_27_1.time_ < var_30_0 + var_30_8 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_0) / var_30_8

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_0 + var_30_8 and arg_27_1.time_ < var_30_0 + var_30_8 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end

		arg_27_1.nodeConfigList_ = {}

		arg_27_1:InitPlayNodeList()
	end,
	Play116291008 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 116291008
		arg_31_1.duration_ = 5

		SetActive(arg_31_1.tipsGo_, false)

		function arg_31_1.onSingleLineFinish_()
			arg_31_1.onSingleLineUpdate_ = nil
			arg_31_1.onSingleLineFinish_ = nil
			arg_31_1.state_ = "waiting"
		end

		function arg_31_1.playNext_(arg_33_0)
			if arg_33_0 == 1 then
				arg_31_0:Play116291009(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			local var_34_0 = arg_31_1.actors_["10025ui_story"].transform
			local var_34_1 = 0

			if var_34_1 < arg_31_1.time_ and arg_31_1.time_ <= var_34_1 + arg_34_0 then
				arg_31_1.var_.moveOldPos10025ui_story = var_34_0.localPosition
			end

			local var_34_2 = 0.001

			if var_34_1 <= arg_31_1.time_ and arg_31_1.time_ < var_34_1 + var_34_2 then
				local var_34_3 = (arg_31_1.time_ - var_34_1) / var_34_2
				local var_34_4 = Vector3.New(0, 100, 0)

				var_34_0.localPosition = Vector3.Lerp(arg_31_1.var_.moveOldPos10025ui_story, var_34_4, var_34_3)

				local var_34_5 = manager.ui.mainCamera.transform.position - var_34_0.position

				var_34_0.forward = Vector3.New(var_34_5.x, var_34_5.y, var_34_5.z)

				local var_34_6 = var_34_0.localEulerAngles

				var_34_6.z = 0
				var_34_6.x = 0
				var_34_0.localEulerAngles = var_34_6
			end

			if arg_31_1.time_ >= var_34_1 + var_34_2 and arg_31_1.time_ < var_34_1 + var_34_2 + arg_34_0 then
				var_34_0.localPosition = Vector3.New(0, 100, 0)

				local var_34_7 = manager.ui.mainCamera.transform.position - var_34_0.position

				var_34_0.forward = Vector3.New(var_34_7.x, var_34_7.y, var_34_7.z)

				local var_34_8 = var_34_0.localEulerAngles

				var_34_8.z = 0
				var_34_8.x = 0
				var_34_0.localEulerAngles = var_34_8
			end

			local var_34_9 = 0
			local var_34_10 = 0.575

			if var_34_9 < arg_31_1.time_ and arg_31_1.time_ <= var_34_9 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, false)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_31_1.iconTrs_.gameObject, false)
				arg_31_1.callingController_:SetSelectedState("normal")

				local var_34_11 = arg_31_1:GetWordFromCfg(116291008)
				local var_34_12 = arg_31_1:FormatText(var_34_11.content)

				arg_31_1.text_.text = var_34_12

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_13 = 23
				local var_34_14 = utf8.len(var_34_12)
				local var_34_15 = var_34_13 <= 0 and var_34_10 or var_34_10 * (var_34_14 / var_34_13)

				if var_34_15 > 0 and var_34_10 < var_34_15 then
					arg_31_1.talkMaxDuration = var_34_15

					if var_34_15 + var_34_9 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_15 + var_34_9
					end
				end

				arg_31_1.text_.text = var_34_12
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)
				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_16 = math.max(var_34_10, arg_31_1.talkMaxDuration)

			if var_34_9 <= arg_31_1.time_ and arg_31_1.time_ < var_34_9 + var_34_16 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - var_34_9) / var_34_16

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= var_34_9 + var_34_16 and arg_31_1.time_ < var_34_9 + var_34_16 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {
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

		arg_31_1:InitPlayNodeList()
	end,
	Play116291009 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 116291009
		arg_35_1.duration_ = 7.02

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play116291010(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			local var_38_0 = "STblack"

			if arg_35_1.bgs_[var_38_0] == nil then
				local var_38_1 = Object.Instantiate(arg_35_1.paintGo_)

				var_38_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_38_0)
				var_38_1.name = var_38_0
				var_38_1.transform.parent = arg_35_1.stage_.transform
				var_38_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_35_1.bgs_[var_38_0] = var_38_1
			end

			local var_38_2 = 2

			if var_38_2 < arg_35_1.time_ and arg_35_1.time_ <= var_38_2 + arg_38_0 then
				local var_38_3 = manager.ui.mainCamera.transform.localPosition
				local var_38_4 = Vector3.New(0, 0, 10) + Vector3.New(var_38_3.x, var_38_3.y, 0)
				local var_38_5 = arg_35_1.bgs_.STblack

				var_38_5.transform.localPosition = var_38_4
				var_38_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_38_6 = var_38_5:GetComponent("SpriteRenderer")

				if var_38_6 and var_38_6.sprite then
					local var_38_7 = (var_38_5.transform.localPosition - var_38_3).z
					local var_38_8 = manager.ui.mainCameraCom_
					local var_38_9 = 2 * var_38_7 * Mathf.Tan(var_38_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_38_10 = var_38_9 * var_38_8.aspect
					local var_38_11 = var_38_6.sprite.bounds.size.x
					local var_38_12 = var_38_6.sprite.bounds.size.y
					local var_38_13 = var_38_10 / var_38_11
					local var_38_14 = var_38_9 / var_38_12
					local var_38_15 = var_38_14 < var_38_13 and var_38_13 or var_38_14

					var_38_5.transform.localScale = Vector3.New(var_38_15, var_38_15, 0)
				end

				for iter_38_0, iter_38_1 in pairs(arg_35_1.bgs_) do
					if iter_38_0 ~= "STblack" then
						iter_38_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_38_16 = 0

			if var_38_16 < arg_35_1.time_ and arg_35_1.time_ <= var_38_16 + arg_38_0 then
				arg_35_1.mask_.enabled = true
				arg_35_1.mask_.raycastTarget = true

				arg_35_1:SetGaussion(false)
			end

			local var_38_17 = 2

			if var_38_16 <= arg_35_1.time_ and arg_35_1.time_ < var_38_16 + var_38_17 then
				local var_38_18 = (arg_35_1.time_ - var_38_16) / var_38_17
				local var_38_19 = Color.New(0, 0, 0)

				var_38_19.a = Mathf.Lerp(0, 1, var_38_18)
				arg_35_1.mask_.color = var_38_19
			end

			if arg_35_1.time_ >= var_38_16 + var_38_17 and arg_35_1.time_ < var_38_16 + var_38_17 + arg_38_0 then
				local var_38_20 = Color.New(0, 0, 0)

				var_38_20.a = 1
				arg_35_1.mask_.color = var_38_20
			end

			local var_38_21 = 2

			if var_38_21 < arg_35_1.time_ and arg_35_1.time_ <= var_38_21 + arg_38_0 then
				arg_35_1.mask_.enabled = true
				arg_35_1.mask_.raycastTarget = true

				arg_35_1:SetGaussion(false)
			end

			local var_38_22 = 2

			if var_38_21 <= arg_35_1.time_ and arg_35_1.time_ < var_38_21 + var_38_22 then
				local var_38_23 = (arg_35_1.time_ - var_38_21) / var_38_22
				local var_38_24 = Color.New(0, 0, 0)

				var_38_24.a = Mathf.Lerp(1, 0, var_38_23)
				arg_35_1.mask_.color = var_38_24
			end

			if arg_35_1.time_ >= var_38_21 + var_38_22 and arg_35_1.time_ < var_38_21 + var_38_22 + arg_38_0 then
				local var_38_25 = Color.New(0, 0, 0)
				local var_38_26 = 0

				arg_35_1.mask_.enabled = false
				var_38_25.a = var_38_26
				arg_35_1.mask_.color = var_38_25
			end

			local var_38_27 = 0

			if var_38_27 < arg_35_1.time_ and arg_35_1.time_ <= var_38_27 + arg_38_0 then
				arg_35_1.fswbg_:SetActive(true)
				arg_35_1.dialog_:SetActive(false)

				arg_35_1.fswtw_.percent = 0

				local var_38_28 = arg_35_1:GetWordFromCfg(116291009)
				local var_38_29 = arg_35_1:FormatText(var_38_28.content)

				arg_35_1.fswt_.text = var_38_29

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.fswt_)

				arg_35_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_35_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_35_1.fswtw_:SetDirty()

				arg_35_1.typewritterCharCountI18N = 0

				SetActive(arg_35_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_35_1:ShowNextGo(false)
			end

			local var_38_30 = 4

			if var_38_30 < arg_35_1.time_ and arg_35_1.time_ <= var_38_30 + arg_38_0 then
				arg_35_1.var_.oldValueTypewriter = arg_35_1.fswtw_.percent

				SetActive(arg_35_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_35_1:ShowNextGo(false)
			end

			local var_38_31 = 45
			local var_38_32 = 3
			local var_38_33 = arg_35_1:GetWordFromCfg(116291009)
			local var_38_34 = arg_35_1:FormatText(var_38_33.content)
			local var_38_35, var_38_36 = arg_35_1:GetPercentByPara(var_38_34, 1)

			if var_38_30 < arg_35_1.time_ and arg_35_1.time_ <= var_38_30 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0

				local var_38_37 = var_38_31 <= 0 and var_38_32 or var_38_32 * ((var_38_36 - arg_35_1.typewritterCharCountI18N) / var_38_31)

				if var_38_37 > 0 and var_38_32 < var_38_37 then
					arg_35_1.talkMaxDuration = var_38_37

					if var_38_37 + var_38_30 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_37 + var_38_30
					end
				end
			end

			local var_38_38 = 3
			local var_38_39 = math.max(var_38_38, arg_35_1.talkMaxDuration)

			if var_38_30 <= arg_35_1.time_ and arg_35_1.time_ < var_38_30 + var_38_39 then
				local var_38_40 = (arg_35_1.time_ - var_38_30) / var_38_39

				arg_35_1.fswtw_.percent = Mathf.Lerp(arg_35_1.var_.oldValueTypewriter, var_38_35, var_38_40)
				arg_35_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_35_1.fswtw_:SetDirty()
			end

			if arg_35_1.time_ >= var_38_30 + var_38_39 and arg_35_1.time_ < var_38_30 + var_38_39 + arg_38_0 then
				arg_35_1.fswtw_.percent = var_38_35

				arg_35_1.fswtw_:SetDirty()
				arg_35_1:ShowNextGo(true)

				arg_35_1.typewritterCharCountI18N = var_38_36
			end

			local var_38_41 = 4

			if var_38_41 < arg_35_1.time_ and arg_35_1.time_ <= var_38_41 + arg_38_0 then
				local var_38_42 = arg_35_1.fswbg_.transform:Find("textbox/adapt/content") or arg_35_1.fswbg_.transform:Find("textbox/content")
				local var_38_43 = arg_35_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_38_44 = var_38_42:GetComponent("Text")
				local var_38_45 = var_38_42:GetComponent("RectTransform")

				var_38_44.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_38_45.offsetMin = Vector2.New(0, 0)
				var_38_45.offsetMax = Vector2.New(0, 0)
			end

			local var_38_46 = 4

			if var_38_46 < arg_35_1.time_ and arg_35_1.time_ <= var_38_46 + arg_38_0 then
				arg_35_1.allBtn_.enabled = false
			end

			local var_38_47 = 3.01666666666667

			if arg_35_1.time_ >= var_38_46 + var_38_47 and arg_35_1.time_ < var_38_46 + var_38_47 + arg_38_0 then
				arg_35_1.allBtn_.enabled = true
			end
		end

		arg_35_1.nodeConfigList_ = {}

		arg_35_1:InitPlayNodeList()
	end,
	Play116291010 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 116291010
		arg_39_1.duration_ = 6.97

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play116291011(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			local var_42_0 = "B13"

			if arg_39_1.bgs_[var_42_0] == nil then
				local var_42_1 = Object.Instantiate(arg_39_1.paintGo_)

				var_42_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_42_0)
				var_42_1.name = var_42_0
				var_42_1.transform.parent = arg_39_1.stage_.transform
				var_42_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_39_1.bgs_[var_42_0] = var_42_1
			end

			local var_42_2 = 0

			if var_42_2 < arg_39_1.time_ and arg_39_1.time_ <= var_42_2 + arg_42_0 then
				local var_42_3 = manager.ui.mainCamera.transform.localPosition
				local var_42_4 = Vector3.New(0, 0, 10) + Vector3.New(var_42_3.x, var_42_3.y, 0)
				local var_42_5 = arg_39_1.bgs_.B13

				var_42_5.transform.localPosition = var_42_4
				var_42_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_42_6 = var_42_5:GetComponent("SpriteRenderer")

				if var_42_6 and var_42_6.sprite then
					local var_42_7 = (var_42_5.transform.localPosition - var_42_3).z
					local var_42_8 = manager.ui.mainCameraCom_
					local var_42_9 = 2 * var_42_7 * Mathf.Tan(var_42_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_42_10 = var_42_9 * var_42_8.aspect
					local var_42_11 = var_42_6.sprite.bounds.size.x
					local var_42_12 = var_42_6.sprite.bounds.size.y
					local var_42_13 = var_42_10 / var_42_11
					local var_42_14 = var_42_9 / var_42_12
					local var_42_15 = var_42_14 < var_42_13 and var_42_13 or var_42_14

					var_42_5.transform.localScale = Vector3.New(var_42_15, var_42_15, 0)
				end

				for iter_42_0, iter_42_1 in pairs(arg_39_1.bgs_) do
					if iter_42_0 ~= "B13" then
						iter_42_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_42_16 = 0

			if var_42_16 < arg_39_1.time_ and arg_39_1.time_ <= var_42_16 + arg_42_0 then
				arg_39_1.mask_.enabled = true
				arg_39_1.mask_.raycastTarget = false

				arg_39_1:SetGaussion(false)
			end

			local var_42_17 = 2

			if var_42_16 <= arg_39_1.time_ and arg_39_1.time_ < var_42_16 + var_42_17 then
				local var_42_18 = (arg_39_1.time_ - var_42_16) / var_42_17
				local var_42_19 = Color.New(0, 0, 0)

				var_42_19.a = Mathf.Lerp(1, 0, var_42_18)
				arg_39_1.mask_.color = var_42_19
			end

			if arg_39_1.time_ >= var_42_16 + var_42_17 and arg_39_1.time_ < var_42_16 + var_42_17 + arg_42_0 then
				local var_42_20 = Color.New(0, 0, 0)
				local var_42_21 = 0

				arg_39_1.mask_.enabled = false
				var_42_20.a = var_42_21
				arg_39_1.mask_.color = var_42_20
			end

			local var_42_22 = 0

			if var_42_22 < arg_39_1.time_ and arg_39_1.time_ <= var_42_22 + arg_42_0 then
				arg_39_1.fswbg_:SetActive(false)
				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_39_1:ShowNextGo(false)
			end

			if arg_39_1.frameCnt_ <= 1 then
				arg_39_1.dialog_:SetActive(false)
			end

			local var_42_23 = 1.96666666666667
			local var_42_24 = 0.225

			if var_42_23 < arg_39_1.time_ and arg_39_1.time_ <= var_42_23 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0

				arg_39_1.dialog_:SetActive(true)

				arg_39_1.dialogCg_.alpha = 0

				local var_42_25 = LeanTween.value(arg_39_1.dialog_, 0, 1, 0.3)

				var_42_25:setOnUpdate(LuaHelper.FloatAction(function(arg_43_0)
					arg_39_1.dialogCg_.alpha = arg_43_0
				end))
				var_42_25:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_39_1.dialog_)
					var_42_25:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_39_1.duration_ = arg_39_1.duration_ + 0.3

				SetActive(arg_39_1.leftNameGo_, true)

				local var_42_26 = arg_39_1:FormatText(StoryNameCfg[7].name)

				arg_39_1.leftNameTxt_.text = var_42_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, true)
				arg_39_1.iconController_:SetSelectedState("hero")

				arg_39_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_39_1.callingController_:SetSelectedState("normal")

				arg_39_1.keyicon_.color = Color.New(1, 1, 1)
				arg_39_1.icon_.color = Color.New(1, 1, 1)

				local var_42_27 = arg_39_1:GetWordFromCfg(116291010)
				local var_42_28 = arg_39_1:FormatText(var_42_27.content)

				arg_39_1.text_.text = var_42_28

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_29 = 9
				local var_42_30 = utf8.len(var_42_28)
				local var_42_31 = var_42_29 <= 0 and var_42_24 or var_42_24 * (var_42_30 / var_42_29)

				if var_42_31 > 0 and var_42_24 < var_42_31 then
					arg_39_1.talkMaxDuration = var_42_31
					var_42_23 = var_42_23 + 0.3

					if var_42_31 + var_42_23 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_31 + var_42_23
					end
				end

				arg_39_1.text_.text = var_42_28
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)
				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_32 = var_42_23 + 0.3
			local var_42_33 = math.max(var_42_24, arg_39_1.talkMaxDuration)

			if var_42_32 <= arg_39_1.time_ and arg_39_1.time_ < var_42_32 + var_42_33 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_32) / var_42_33

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_32 + var_42_33 and arg_39_1.time_ < var_42_32 + var_42_33 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {}

		arg_39_1:InitPlayNodeList()
	end,
	Play116291011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 116291011
		arg_45_1.duration_ = 5.53

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play116291012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 0
			local var_48_1 = 1

			if var_48_0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_0 + arg_48_0 then
				local var_48_2 = "play"
				local var_48_3 = "effect"

				arg_45_1:AudioAction(var_48_2, var_48_3, "se_story_16", "se_story_16_gun04", "")
			end

			local var_48_4 = manager.ui.mainCamera.transform
			local var_48_5 = 0

			if var_48_5 < arg_45_1.time_ and arg_45_1.time_ <= var_48_5 + arg_48_0 then
				arg_45_1.var_.shakeOldPos = var_48_4.localPosition
			end

			local var_48_6 = 1

			if var_48_5 <= arg_45_1.time_ and arg_45_1.time_ < var_48_5 + var_48_6 then
				local var_48_7 = (arg_45_1.time_ - var_48_5) / 0.066
				local var_48_8, var_48_9 = math.modf(var_48_7)

				var_48_4.localPosition = Vector3.New(var_48_9 * 0.13, var_48_9 * 0.13, var_48_9 * 0.13) + arg_45_1.var_.shakeOldPos
			end

			if arg_45_1.time_ >= var_48_5 + var_48_6 and arg_45_1.time_ < var_48_5 + var_48_6 + arg_48_0 then
				var_48_4.localPosition = arg_45_1.var_.shakeOldPos
			end

			local var_48_10 = 0

			if var_48_10 < arg_45_1.time_ and arg_45_1.time_ <= var_48_10 + arg_48_0 then
				arg_45_1.allBtn_.enabled = false
			end

			local var_48_11 = 1

			if arg_45_1.time_ >= var_48_10 + var_48_11 and arg_45_1.time_ < var_48_10 + var_48_11 + arg_48_0 then
				arg_45_1.allBtn_.enabled = true
			end

			if arg_45_1.frameCnt_ <= 1 then
				arg_45_1.dialog_:SetActive(false)
			end

			local var_48_12 = 0.533333333333333
			local var_48_13 = 1.275

			if var_48_12 < arg_45_1.time_ and arg_45_1.time_ <= var_48_12 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0

				arg_45_1.dialog_:SetActive(true)

				arg_45_1.dialogCg_.alpha = 0

				local var_48_14 = LeanTween.value(arg_45_1.dialog_, 0, 1, 0.3)

				var_48_14:setOnUpdate(LuaHelper.FloatAction(function(arg_49_0)
					arg_45_1.dialogCg_.alpha = arg_49_0
				end))
				var_48_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_45_1.dialog_)
					var_48_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_45_1.duration_ = arg_45_1.duration_ + 0.3

				SetActive(arg_45_1.leftNameGo_, false)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_15 = arg_45_1:GetWordFromCfg(116291011)
				local var_48_16 = arg_45_1:FormatText(var_48_15.content)

				arg_45_1.text_.text = var_48_16

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_17 = 51
				local var_48_18 = utf8.len(var_48_16)
				local var_48_19 = var_48_17 <= 0 and var_48_13 or var_48_13 * (var_48_18 / var_48_17)

				if var_48_19 > 0 and var_48_13 < var_48_19 then
					arg_45_1.talkMaxDuration = var_48_19
					var_48_12 = var_48_12 + 0.3

					if var_48_19 + var_48_12 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_19 + var_48_12
					end
				end

				arg_45_1.text_.text = var_48_16
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)
				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_20 = var_48_12 + 0.3
			local var_48_21 = math.max(var_48_13, arg_45_1.talkMaxDuration)

			if var_48_20 <= arg_45_1.time_ and arg_45_1.time_ < var_48_20 + var_48_21 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_20) / var_48_21

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_20 + var_48_21 and arg_45_1.time_ < var_48_20 + var_48_21 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play116291012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 116291012
		arg_51_1.duration_ = 5

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play116291013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			local var_54_0 = 0
			local var_54_1 = 0.1

			if var_54_0 < arg_51_1.time_ and arg_51_1.time_ <= var_54_0 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				local var_54_2 = arg_51_1:FormatText(StoryNameCfg[7].name)

				arg_51_1.leftNameTxt_.text = var_54_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, true)
				arg_51_1.iconController_:SetSelectedState("hero")

				arg_51_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_51_1.callingController_:SetSelectedState("normal")

				arg_51_1.keyicon_.color = Color.New(1, 1, 1)
				arg_51_1.icon_.color = Color.New(1, 1, 1)

				local var_54_3 = arg_51_1:GetWordFromCfg(116291012)
				local var_54_4 = arg_51_1:FormatText(var_54_3.content)

				arg_51_1.text_.text = var_54_4

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_5 = 4
				local var_54_6 = utf8.len(var_54_4)
				local var_54_7 = var_54_5 <= 0 and var_54_1 or var_54_1 * (var_54_6 / var_54_5)

				if var_54_7 > 0 and var_54_1 < var_54_7 then
					arg_51_1.talkMaxDuration = var_54_7

					if var_54_7 + var_54_0 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_7 + var_54_0
					end
				end

				arg_51_1.text_.text = var_54_4
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)
				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_8 = math.max(var_54_1, arg_51_1.talkMaxDuration)

			if var_54_0 <= arg_51_1.time_ and arg_51_1.time_ < var_54_0 + var_54_8 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_0) / var_54_8

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_0 + var_54_8 and arg_51_1.time_ < var_54_0 + var_54_8 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {}

		arg_51_1:InitPlayNodeList()
	end,
	Play116291013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 116291013
		arg_55_1.duration_ = 6.4

		local var_55_0 = {
			zh = 4.6,
			ja = 6.4
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
				arg_55_0:Play116291014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			local var_58_0 = arg_55_1.actors_["1148ui_story"].transform
			local var_58_1 = 0

			if var_58_1 < arg_55_1.time_ and arg_55_1.time_ <= var_58_1 + arg_58_0 then
				arg_55_1.var_.moveOldPos1148ui_story = var_58_0.localPosition
			end

			local var_58_2 = 0.001

			if var_58_1 <= arg_55_1.time_ and arg_55_1.time_ < var_58_1 + var_58_2 then
				local var_58_3 = (arg_55_1.time_ - var_58_1) / var_58_2
				local var_58_4 = Vector3.New(0, -0.8, -6.2)

				var_58_0.localPosition = Vector3.Lerp(arg_55_1.var_.moveOldPos1148ui_story, var_58_4, var_58_3)

				local var_58_5 = manager.ui.mainCamera.transform.position - var_58_0.position

				var_58_0.forward = Vector3.New(var_58_5.x, var_58_5.y, var_58_5.z)

				local var_58_6 = var_58_0.localEulerAngles

				var_58_6.z = 0
				var_58_6.x = 0
				var_58_0.localEulerAngles = var_58_6
			end

			if arg_55_1.time_ >= var_58_1 + var_58_2 and arg_55_1.time_ < var_58_1 + var_58_2 + arg_58_0 then
				var_58_0.localPosition = Vector3.New(0, -0.8, -6.2)

				local var_58_7 = manager.ui.mainCamera.transform.position - var_58_0.position

				var_58_0.forward = Vector3.New(var_58_7.x, var_58_7.y, var_58_7.z)

				local var_58_8 = var_58_0.localEulerAngles

				var_58_8.z = 0
				var_58_8.x = 0
				var_58_0.localEulerAngles = var_58_8
			end

			local var_58_9 = arg_55_1.actors_["1148ui_story"]
			local var_58_10 = 0.000666666666666593

			if var_58_10 < arg_55_1.time_ and arg_55_1.time_ <= var_58_10 + arg_58_0 and not isNil(var_58_9) and arg_55_1.var_.characterEffect1148ui_story == nil then
				arg_55_1.var_.characterEffect1148ui_story = var_58_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_58_11 = 0.2

			if var_58_10 <= arg_55_1.time_ and arg_55_1.time_ < var_58_10 + var_58_11 and not isNil(var_58_9) then
				local var_58_12 = (arg_55_1.time_ - var_58_10) / var_58_11

				if arg_55_1.var_.characterEffect1148ui_story and not isNil(var_58_9) then
					arg_55_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_55_1.time_ >= var_58_10 + var_58_11 and arg_55_1.time_ < var_58_10 + var_58_11 + arg_58_0 and not isNil(var_58_9) and arg_55_1.var_.characterEffect1148ui_story then
				arg_55_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_58_13 = 0.000666666666666593

			if var_58_13 < arg_55_1.time_ and arg_55_1.time_ <= var_58_13 + arg_58_0 then
				arg_55_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action7_1")
			end

			local var_58_14 = 0.000666666666666593

			if var_58_14 < arg_55_1.time_ and arg_55_1.time_ <= var_58_14 + arg_58_0 then
				arg_55_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_58_15 = 0
			local var_58_16 = 0.55

			if var_58_15 < arg_55_1.time_ and arg_55_1.time_ <= var_58_15 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				local var_58_17 = arg_55_1:FormatText(StoryNameCfg[8].name)

				arg_55_1.leftNameTxt_.text = var_58_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_18 = arg_55_1:GetWordFromCfg(116291013)
				local var_58_19 = arg_55_1:FormatText(var_58_18.content)

				arg_55_1.text_.text = var_58_19

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_20 = 22
				local var_58_21 = utf8.len(var_58_19)
				local var_58_22 = var_58_20 <= 0 and var_58_16 or var_58_16 * (var_58_21 / var_58_20)

				if var_58_22 > 0 and var_58_16 < var_58_22 then
					arg_55_1.talkMaxDuration = var_58_22

					if var_58_22 + var_58_15 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_22 + var_58_15
					end
				end

				arg_55_1.text_.text = var_58_19
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116291", "116291013", "story_v_out_116291.awb") ~= 0 then
					local var_58_23 = manager.audio:GetVoiceLength("story_v_out_116291", "116291013", "story_v_out_116291.awb") / 1000

					if var_58_23 + var_58_15 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_23 + var_58_15
					end

					if var_58_18.prefab_name ~= "" and arg_55_1.actors_[var_58_18.prefab_name] ~= nil then
						local var_58_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_55_1.actors_[var_58_18.prefab_name].transform, "story_v_out_116291", "116291013", "story_v_out_116291.awb")

						arg_55_1:RecordAudio("116291013", var_58_24)
						arg_55_1:RecordAudio("116291013", var_58_24)
					else
						arg_55_1:AudioAction("play", "voice", "story_v_out_116291", "116291013", "story_v_out_116291.awb")
					end

					arg_55_1:RecordHistoryTalkVoice("story_v_out_116291", "116291013", "story_v_out_116291.awb")
				end

				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_25 = math.max(var_58_16, arg_55_1.talkMaxDuration)

			if var_58_15 <= arg_55_1.time_ and arg_55_1.time_ < var_58_15 + var_58_25 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_15) / var_58_25

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_15 + var_58_25 and arg_55_1.time_ < var_58_15 + var_58_25 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_55_1:InitPlayNodeList()
	end,
	Play116291014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 116291014
		arg_59_1.duration_ = 5

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play116291015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = arg_59_1.actors_["1148ui_story"].transform
			local var_62_1 = 0

			if var_62_1 < arg_59_1.time_ and arg_59_1.time_ <= var_62_1 + arg_62_0 then
				arg_59_1.var_.moveOldPos1148ui_story = var_62_0.localPosition
			end

			local var_62_2 = 0.001

			if var_62_1 <= arg_59_1.time_ and arg_59_1.time_ < var_62_1 + var_62_2 then
				local var_62_3 = (arg_59_1.time_ - var_62_1) / var_62_2
				local var_62_4 = Vector3.New(0, 100, 0)

				var_62_0.localPosition = Vector3.Lerp(arg_59_1.var_.moveOldPos1148ui_story, var_62_4, var_62_3)

				local var_62_5 = manager.ui.mainCamera.transform.position - var_62_0.position

				var_62_0.forward = Vector3.New(var_62_5.x, var_62_5.y, var_62_5.z)

				local var_62_6 = var_62_0.localEulerAngles

				var_62_6.z = 0
				var_62_6.x = 0
				var_62_0.localEulerAngles = var_62_6
			end

			if arg_59_1.time_ >= var_62_1 + var_62_2 and arg_59_1.time_ < var_62_1 + var_62_2 + arg_62_0 then
				var_62_0.localPosition = Vector3.New(0, 100, 0)

				local var_62_7 = manager.ui.mainCamera.transform.position - var_62_0.position

				var_62_0.forward = Vector3.New(var_62_7.x, var_62_7.y, var_62_7.z)

				local var_62_8 = var_62_0.localEulerAngles

				var_62_8.z = 0
				var_62_8.x = 0
				var_62_0.localEulerAngles = var_62_8
			end

			local var_62_9 = 0
			local var_62_10 = 0.75

			if var_62_9 < arg_59_1.time_ and arg_59_1.time_ <= var_62_9 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, false)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_11 = arg_59_1:GetWordFromCfg(116291014)
				local var_62_12 = arg_59_1:FormatText(var_62_11.content)

				arg_59_1.text_.text = var_62_12

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_13 = 30
				local var_62_14 = utf8.len(var_62_12)
				local var_62_15 = var_62_13 <= 0 and var_62_10 or var_62_10 * (var_62_14 / var_62_13)

				if var_62_15 > 0 and var_62_10 < var_62_15 then
					arg_59_1.talkMaxDuration = var_62_15

					if var_62_15 + var_62_9 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_15 + var_62_9
					end
				end

				arg_59_1.text_.text = var_62_12
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)
				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_16 = math.max(var_62_10, arg_59_1.talkMaxDuration)

			if var_62_9 <= arg_59_1.time_ and arg_59_1.time_ < var_62_9 + var_62_16 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_9) / var_62_16

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_9 + var_62_16 and arg_59_1.time_ < var_62_9 + var_62_16 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_59_1:InitPlayNodeList()
	end,
	Play116291015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 116291015
		arg_63_1.duration_ = 9

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play116291016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = "B13e"

			if arg_63_1.bgs_[var_66_0] == nil then
				local var_66_1 = Object.Instantiate(arg_63_1.paintGo_)

				var_66_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_66_0)
				var_66_1.name = var_66_0
				var_66_1.transform.parent = arg_63_1.stage_.transform
				var_66_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_63_1.bgs_[var_66_0] = var_66_1
			end

			local var_66_2 = 2

			if var_66_2 < arg_63_1.time_ and arg_63_1.time_ <= var_66_2 + arg_66_0 then
				local var_66_3 = manager.ui.mainCamera.transform.localPosition
				local var_66_4 = Vector3.New(0, 0, 10) + Vector3.New(var_66_3.x, var_66_3.y, 0)
				local var_66_5 = arg_63_1.bgs_.B13e

				var_66_5.transform.localPosition = var_66_4
				var_66_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_66_6 = var_66_5:GetComponent("SpriteRenderer")

				if var_66_6 and var_66_6.sprite then
					local var_66_7 = (var_66_5.transform.localPosition - var_66_3).z
					local var_66_8 = manager.ui.mainCameraCom_
					local var_66_9 = 2 * var_66_7 * Mathf.Tan(var_66_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_66_10 = var_66_9 * var_66_8.aspect
					local var_66_11 = var_66_6.sprite.bounds.size.x
					local var_66_12 = var_66_6.sprite.bounds.size.y
					local var_66_13 = var_66_10 / var_66_11
					local var_66_14 = var_66_9 / var_66_12
					local var_66_15 = var_66_14 < var_66_13 and var_66_13 or var_66_14

					var_66_5.transform.localScale = Vector3.New(var_66_15, var_66_15, 0)
				end

				for iter_66_0, iter_66_1 in pairs(arg_63_1.bgs_) do
					if iter_66_0 ~= "B13e" then
						iter_66_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_66_16 = 0

			if var_66_16 < arg_63_1.time_ and arg_63_1.time_ <= var_66_16 + arg_66_0 then
				arg_63_1.mask_.enabled = true
				arg_63_1.mask_.raycastTarget = false

				arg_63_1:SetGaussion(false)
			end

			local var_66_17 = 2

			if var_66_16 <= arg_63_1.time_ and arg_63_1.time_ < var_66_16 + var_66_17 then
				local var_66_18 = (arg_63_1.time_ - var_66_16) / var_66_17
				local var_66_19 = Color.New(0, 0, 0)

				var_66_19.a = Mathf.Lerp(0, 1, var_66_18)
				arg_63_1.mask_.color = var_66_19
			end

			if arg_63_1.time_ >= var_66_16 + var_66_17 and arg_63_1.time_ < var_66_16 + var_66_17 + arg_66_0 then
				local var_66_20 = Color.New(0, 0, 0)

				var_66_20.a = 1
				arg_63_1.mask_.color = var_66_20
			end

			local var_66_21 = 2

			if var_66_21 < arg_63_1.time_ and arg_63_1.time_ <= var_66_21 + arg_66_0 then
				arg_63_1.mask_.enabled = true
				arg_63_1.mask_.raycastTarget = false

				arg_63_1:SetGaussion(false)
			end

			local var_66_22 = 2

			if var_66_21 <= arg_63_1.time_ and arg_63_1.time_ < var_66_21 + var_66_22 then
				local var_66_23 = (arg_63_1.time_ - var_66_21) / var_66_22
				local var_66_24 = Color.New(0, 0, 0)

				var_66_24.a = Mathf.Lerp(1, 0, var_66_23)
				arg_63_1.mask_.color = var_66_24
			end

			if arg_63_1.time_ >= var_66_21 + var_66_22 and arg_63_1.time_ < var_66_21 + var_66_22 + arg_66_0 then
				local var_66_25 = Color.New(0, 0, 0)
				local var_66_26 = 0

				arg_63_1.mask_.enabled = false
				var_66_25.a = var_66_26
				arg_63_1.mask_.color = var_66_25
			end

			if arg_63_1.frameCnt_ <= 1 then
				arg_63_1.dialog_:SetActive(false)
			end

			local var_66_27 = 4
			local var_66_28 = 0.65

			if var_66_27 < arg_63_1.time_ and arg_63_1.time_ <= var_66_27 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0

				arg_63_1.dialog_:SetActive(true)

				arg_63_1.dialogCg_.alpha = 0

				local var_66_29 = LeanTween.value(arg_63_1.dialog_, 0, 1, 0.3)

				var_66_29:setOnUpdate(LuaHelper.FloatAction(function(arg_67_0)
					arg_63_1.dialogCg_.alpha = arg_67_0
				end))
				var_66_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_63_1.dialog_)
					var_66_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_63_1.duration_ = arg_63_1.duration_ + 0.3

				SetActive(arg_63_1.leftNameGo_, false)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_30 = arg_63_1:GetWordFromCfg(116291015)
				local var_66_31 = arg_63_1:FormatText(var_66_30.content)

				arg_63_1.text_.text = var_66_31

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_32 = 26
				local var_66_33 = utf8.len(var_66_31)
				local var_66_34 = var_66_32 <= 0 and var_66_28 or var_66_28 * (var_66_33 / var_66_32)

				if var_66_34 > 0 and var_66_28 < var_66_34 then
					arg_63_1.talkMaxDuration = var_66_34
					var_66_27 = var_66_27 + 0.3

					if var_66_34 + var_66_27 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_34 + var_66_27
					end
				end

				arg_63_1.text_.text = var_66_31
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)
				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_35 = var_66_27 + 0.3
			local var_66_36 = math.max(var_66_28, arg_63_1.talkMaxDuration)

			if var_66_35 <= arg_63_1.time_ and arg_63_1.time_ < var_66_35 + var_66_36 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_35) / var_66_36

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_35 + var_66_36 and arg_63_1.time_ < var_66_35 + var_66_36 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	Play116291016 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 116291016
		arg_69_1.duration_ = 2.77

		local var_69_0 = {
			zh = 2.766,
			ja = 2.6
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
				arg_69_0:Play116291017(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = "1184ui_story"

			if arg_69_1.actors_[var_72_0] == nil then
				local var_72_1 = Asset.Load("Char/" .. "1184ui_story")

				if not isNil(var_72_1) then
					local var_72_2 = Object.Instantiate(Asset.Load("Char/" .. "1184ui_story"), arg_69_1.stage_.transform)

					var_72_2.name = var_72_0
					var_72_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_69_1.actors_[var_72_0] = var_72_2

					local var_72_3 = var_72_2:GetComponentInChildren(typeof(CharacterEffect))

					var_72_3.enabled = true

					local var_72_4 = GameObjectTools.GetOrAddComponent(var_72_2, typeof(DynamicBoneHelper))

					if var_72_4 then
						var_72_4:EnableDynamicBone(false)
					end

					arg_69_1:ShowWeapon(var_72_3.transform, false)

					arg_69_1.var_[var_72_0 .. "Animator"] = var_72_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_69_1.var_[var_72_0 .. "Animator"].applyRootMotion = true
					arg_69_1.var_[var_72_0 .. "LipSync"] = var_72_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_72_5 = arg_69_1.actors_["1184ui_story"].transform
			local var_72_6 = 0

			if var_72_6 < arg_69_1.time_ and arg_69_1.time_ <= var_72_6 + arg_72_0 then
				arg_69_1.var_.moveOldPos1184ui_story = var_72_5.localPosition
			end

			local var_72_7 = 0.001

			if var_72_6 <= arg_69_1.time_ and arg_69_1.time_ < var_72_6 + var_72_7 then
				local var_72_8 = (arg_69_1.time_ - var_72_6) / var_72_7
				local var_72_9 = Vector3.New(0, -0.97, -6)

				var_72_5.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos1184ui_story, var_72_9, var_72_8)

				local var_72_10 = manager.ui.mainCamera.transform.position - var_72_5.position

				var_72_5.forward = Vector3.New(var_72_10.x, var_72_10.y, var_72_10.z)

				local var_72_11 = var_72_5.localEulerAngles

				var_72_11.z = 0
				var_72_11.x = 0
				var_72_5.localEulerAngles = var_72_11
			end

			if arg_69_1.time_ >= var_72_6 + var_72_7 and arg_69_1.time_ < var_72_6 + var_72_7 + arg_72_0 then
				var_72_5.localPosition = Vector3.New(0, -0.97, -6)

				local var_72_12 = manager.ui.mainCamera.transform.position - var_72_5.position

				var_72_5.forward = Vector3.New(var_72_12.x, var_72_12.y, var_72_12.z)

				local var_72_13 = var_72_5.localEulerAngles

				var_72_13.z = 0
				var_72_13.x = 0
				var_72_5.localEulerAngles = var_72_13
			end

			local var_72_14 = arg_69_1.actors_["1184ui_story"]
			local var_72_15 = 0

			if var_72_15 < arg_69_1.time_ and arg_69_1.time_ <= var_72_15 + arg_72_0 and not isNil(var_72_14) and arg_69_1.var_.characterEffect1184ui_story == nil then
				arg_69_1.var_.characterEffect1184ui_story = var_72_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_16 = 0.2

			if var_72_15 <= arg_69_1.time_ and arg_69_1.time_ < var_72_15 + var_72_16 and not isNil(var_72_14) then
				local var_72_17 = (arg_69_1.time_ - var_72_15) / var_72_16

				if arg_69_1.var_.characterEffect1184ui_story and not isNil(var_72_14) then
					arg_69_1.var_.characterEffect1184ui_story.fillFlat = false
				end
			end

			if arg_69_1.time_ >= var_72_15 + var_72_16 and arg_69_1.time_ < var_72_15 + var_72_16 + arg_72_0 and not isNil(var_72_14) and arg_69_1.var_.characterEffect1184ui_story then
				arg_69_1.var_.characterEffect1184ui_story.fillFlat = false
			end

			local var_72_18 = 0

			if var_72_18 < arg_69_1.time_ and arg_69_1.time_ <= var_72_18 + arg_72_0 then
				arg_69_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action5_1")
			end

			local var_72_19 = 0

			if var_72_19 < arg_69_1.time_ and arg_69_1.time_ <= var_72_19 + arg_72_0 then
				arg_69_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_72_20 = 0
			local var_72_21 = 0.3

			if var_72_20 < arg_69_1.time_ and arg_69_1.time_ <= var_72_20 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_22 = arg_69_1:FormatText(StoryNameCfg[6].name)

				arg_69_1.leftNameTxt_.text = var_72_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_23 = arg_69_1:GetWordFromCfg(116291016)
				local var_72_24 = arg_69_1:FormatText(var_72_23.content)

				arg_69_1.text_.text = var_72_24

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_25 = 12
				local var_72_26 = utf8.len(var_72_24)
				local var_72_27 = var_72_25 <= 0 and var_72_21 or var_72_21 * (var_72_26 / var_72_25)

				if var_72_27 > 0 and var_72_21 < var_72_27 then
					arg_69_1.talkMaxDuration = var_72_27

					if var_72_27 + var_72_20 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_27 + var_72_20
					end
				end

				arg_69_1.text_.text = var_72_24
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116291", "116291016", "story_v_out_116291.awb") ~= 0 then
					local var_72_28 = manager.audio:GetVoiceLength("story_v_out_116291", "116291016", "story_v_out_116291.awb") / 1000

					if var_72_28 + var_72_20 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_28 + var_72_20
					end

					if var_72_23.prefab_name ~= "" and arg_69_1.actors_[var_72_23.prefab_name] ~= nil then
						local var_72_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_23.prefab_name].transform, "story_v_out_116291", "116291016", "story_v_out_116291.awb")

						arg_69_1:RecordAudio("116291016", var_72_29)
						arg_69_1:RecordAudio("116291016", var_72_29)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_116291", "116291016", "story_v_out_116291.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_116291", "116291016", "story_v_out_116291.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_30 = math.max(var_72_21, arg_69_1.talkMaxDuration)

			if var_72_20 <= arg_69_1.time_ and arg_69_1.time_ < var_72_20 + var_72_30 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_20) / var_72_30

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_20 + var_72_30 and arg_69_1.time_ < var_72_20 + var_72_30 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_69_1:InitPlayNodeList()
	end,
	Play116291017 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 116291017
		arg_73_1.duration_ = 5

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play116291018(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = arg_73_1.actors_["1184ui_story"]
			local var_76_1 = 0

			if var_76_1 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 and not isNil(var_76_0) and arg_73_1.var_.characterEffect1184ui_story == nil then
				arg_73_1.var_.characterEffect1184ui_story = var_76_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_2 = 0.2

			if var_76_1 <= arg_73_1.time_ and arg_73_1.time_ < var_76_1 + var_76_2 and not isNil(var_76_0) then
				local var_76_3 = (arg_73_1.time_ - var_76_1) / var_76_2

				if arg_73_1.var_.characterEffect1184ui_story and not isNil(var_76_0) then
					local var_76_4 = Mathf.Lerp(0, 0.5, var_76_3)

					arg_73_1.var_.characterEffect1184ui_story.fillFlat = true
					arg_73_1.var_.characterEffect1184ui_story.fillRatio = var_76_4
				end
			end

			if arg_73_1.time_ >= var_76_1 + var_76_2 and arg_73_1.time_ < var_76_1 + var_76_2 + arg_76_0 and not isNil(var_76_0) and arg_73_1.var_.characterEffect1184ui_story then
				local var_76_5 = 0.5

				arg_73_1.var_.characterEffect1184ui_story.fillFlat = true
				arg_73_1.var_.characterEffect1184ui_story.fillRatio = var_76_5
			end

			local var_76_6 = 0
			local var_76_7 = 0.875

			if var_76_6 < arg_73_1.time_ and arg_73_1.time_ <= var_76_6 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				local var_76_8 = arg_73_1:FormatText(StoryNameCfg[7].name)

				arg_73_1.leftNameTxt_.text = var_76_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, true)
				arg_73_1.iconController_:SetSelectedState("hero")

				arg_73_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_73_1.callingController_:SetSelectedState("normal")

				arg_73_1.keyicon_.color = Color.New(1, 1, 1)
				arg_73_1.icon_.color = Color.New(1, 1, 1)

				local var_76_9 = arg_73_1:GetWordFromCfg(116291017)
				local var_76_10 = arg_73_1:FormatText(var_76_9.content)

				arg_73_1.text_.text = var_76_10

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_11 = 35
				local var_76_12 = utf8.len(var_76_10)
				local var_76_13 = var_76_11 <= 0 and var_76_7 or var_76_7 * (var_76_12 / var_76_11)

				if var_76_13 > 0 and var_76_7 < var_76_13 then
					arg_73_1.talkMaxDuration = var_76_13

					if var_76_13 + var_76_6 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_13 + var_76_6
					end
				end

				arg_73_1.text_.text = var_76_10
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)
				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_14 = math.max(var_76_7, arg_73_1.talkMaxDuration)

			if var_76_6 <= arg_73_1.time_ and arg_73_1.time_ < var_76_6 + var_76_14 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_6) / var_76_14

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_6 + var_76_14 and arg_73_1.time_ < var_76_6 + var_76_14 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play116291018 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 116291018
		arg_77_1.duration_ = 5

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play116291019(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = arg_77_1.actors_["1184ui_story"].transform
			local var_80_1 = 0

			if var_80_1 < arg_77_1.time_ and arg_77_1.time_ <= var_80_1 + arg_80_0 then
				arg_77_1.var_.moveOldPos1184ui_story = var_80_0.localPosition
			end

			local var_80_2 = 0.001

			if var_80_1 <= arg_77_1.time_ and arg_77_1.time_ < var_80_1 + var_80_2 then
				local var_80_3 = (arg_77_1.time_ - var_80_1) / var_80_2
				local var_80_4 = Vector3.New(0, 100, 0)

				var_80_0.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos1184ui_story, var_80_4, var_80_3)

				local var_80_5 = manager.ui.mainCamera.transform.position - var_80_0.position

				var_80_0.forward = Vector3.New(var_80_5.x, var_80_5.y, var_80_5.z)

				local var_80_6 = var_80_0.localEulerAngles

				var_80_6.z = 0
				var_80_6.x = 0
				var_80_0.localEulerAngles = var_80_6
			end

			if arg_77_1.time_ >= var_80_1 + var_80_2 and arg_77_1.time_ < var_80_1 + var_80_2 + arg_80_0 then
				var_80_0.localPosition = Vector3.New(0, 100, 0)

				local var_80_7 = manager.ui.mainCamera.transform.position - var_80_0.position

				var_80_0.forward = Vector3.New(var_80_7.x, var_80_7.y, var_80_7.z)

				local var_80_8 = var_80_0.localEulerAngles

				var_80_8.z = 0
				var_80_8.x = 0
				var_80_0.localEulerAngles = var_80_8
			end

			local var_80_9 = 0
			local var_80_10 = 0.9

			if var_80_9 < arg_77_1.time_ and arg_77_1.time_ <= var_80_9 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, false)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_11 = arg_77_1:GetWordFromCfg(116291018)
				local var_80_12 = arg_77_1:FormatText(var_80_11.content)

				arg_77_1.text_.text = var_80_12

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_13 = 36
				local var_80_14 = utf8.len(var_80_12)
				local var_80_15 = var_80_13 <= 0 and var_80_10 or var_80_10 * (var_80_14 / var_80_13)

				if var_80_15 > 0 and var_80_10 < var_80_15 then
					arg_77_1.talkMaxDuration = var_80_15

					if var_80_15 + var_80_9 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_15 + var_80_9
					end
				end

				arg_77_1.text_.text = var_80_12
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)
				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_16 = math.max(var_80_10, arg_77_1.talkMaxDuration)

			if var_80_9 <= arg_77_1.time_ and arg_77_1.time_ < var_80_9 + var_80_16 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_9) / var_80_16

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_9 + var_80_16 and arg_77_1.time_ < var_80_9 + var_80_16 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_77_1:InitPlayNodeList()
	end,
	Play116291019 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 116291019
		arg_81_1.duration_ = 5

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play116291020(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = 0
			local var_84_1 = 0.65

			if var_84_0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_0 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				local var_84_2 = arg_81_1:FormatText(StoryNameCfg[7].name)

				arg_81_1.leftNameTxt_.text = var_84_2

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

				local var_84_3 = arg_81_1:GetWordFromCfg(116291019)
				local var_84_4 = arg_81_1:FormatText(var_84_3.content)

				arg_81_1.text_.text = var_84_4

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_5 = 26
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
				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_8 = math.max(var_84_1, arg_81_1.talkMaxDuration)

			if var_84_0 <= arg_81_1.time_ and arg_81_1.time_ < var_84_0 + var_84_8 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_0) / var_84_8

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_0 + var_84_8 and arg_81_1.time_ < var_84_0 + var_84_8 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play116291020 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 116291020
		arg_85_1.duration_ = 5

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play116291021(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = 0
			local var_88_1 = 1

			if var_88_0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_0 + arg_88_0 then
				local var_88_2 = "play"
				local var_88_3 = "effect"

				arg_85_1:AudioAction(var_88_2, var_88_3, "se_story_16", "se_story_16_engine", "")
			end

			local var_88_4 = 0
			local var_88_5 = 0.525

			if var_88_4 < arg_85_1.time_ and arg_85_1.time_ <= var_88_4 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, false)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_6 = arg_85_1:GetWordFromCfg(116291020)
				local var_88_7 = arg_85_1:FormatText(var_88_6.content)

				arg_85_1.text_.text = var_88_7

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_8 = 21
				local var_88_9 = utf8.len(var_88_7)
				local var_88_10 = var_88_8 <= 0 and var_88_5 or var_88_5 * (var_88_9 / var_88_8)

				if var_88_10 > 0 and var_88_5 < var_88_10 then
					arg_85_1.talkMaxDuration = var_88_10

					if var_88_10 + var_88_4 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_10 + var_88_4
					end
				end

				arg_85_1.text_.text = var_88_7
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)
				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_11 = math.max(var_88_5, arg_85_1.talkMaxDuration)

			if var_88_4 <= arg_85_1.time_ and arg_85_1.time_ < var_88_4 + var_88_11 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_4) / var_88_11

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_4 + var_88_11 and arg_85_1.time_ < var_88_4 + var_88_11 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play116291021 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 116291021
		arg_89_1.duration_ = 5

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play116291022(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = 0
			local var_92_1 = 1.05

			if var_92_0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_0 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, false)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_2 = arg_89_1:GetWordFromCfg(116291021)
				local var_92_3 = arg_89_1:FormatText(var_92_2.content)

				arg_89_1.text_.text = var_92_3

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_4 = 42
				local var_92_5 = utf8.len(var_92_3)
				local var_92_6 = var_92_4 <= 0 and var_92_1 or var_92_1 * (var_92_5 / var_92_4)

				if var_92_6 > 0 and var_92_1 < var_92_6 then
					arg_89_1.talkMaxDuration = var_92_6

					if var_92_6 + var_92_0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_6 + var_92_0
					end
				end

				arg_89_1.text_.text = var_92_3
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)
				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_7 = math.max(var_92_1, arg_89_1.talkMaxDuration)

			if var_92_0 <= arg_89_1.time_ and arg_89_1.time_ < var_92_0 + var_92_7 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_0) / var_92_7

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_0 + var_92_7 and arg_89_1.time_ < var_92_0 + var_92_7 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play116291022 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 116291022
		arg_93_1.duration_ = 7.5

		local var_93_0 = {
			zh = 4.433,
			ja = 7.5
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
				arg_93_0:Play116291023(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = arg_93_1.actors_["1148ui_story"].transform
			local var_96_1 = 0

			if var_96_1 < arg_93_1.time_ and arg_93_1.time_ <= var_96_1 + arg_96_0 then
				arg_93_1.var_.moveOldPos1148ui_story = var_96_0.localPosition
			end

			local var_96_2 = 0.001

			if var_96_1 <= arg_93_1.time_ and arg_93_1.time_ < var_96_1 + var_96_2 then
				local var_96_3 = (arg_93_1.time_ - var_96_1) / var_96_2
				local var_96_4 = Vector3.New(0, -0.8, -6.2)

				var_96_0.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos1148ui_story, var_96_4, var_96_3)

				local var_96_5 = manager.ui.mainCamera.transform.position - var_96_0.position

				var_96_0.forward = Vector3.New(var_96_5.x, var_96_5.y, var_96_5.z)

				local var_96_6 = var_96_0.localEulerAngles

				var_96_6.z = 0
				var_96_6.x = 0
				var_96_0.localEulerAngles = var_96_6
			end

			if arg_93_1.time_ >= var_96_1 + var_96_2 and arg_93_1.time_ < var_96_1 + var_96_2 + arg_96_0 then
				var_96_0.localPosition = Vector3.New(0, -0.8, -6.2)

				local var_96_7 = manager.ui.mainCamera.transform.position - var_96_0.position

				var_96_0.forward = Vector3.New(var_96_7.x, var_96_7.y, var_96_7.z)

				local var_96_8 = var_96_0.localEulerAngles

				var_96_8.z = 0
				var_96_8.x = 0
				var_96_0.localEulerAngles = var_96_8
			end

			local var_96_9 = arg_93_1.actors_["1148ui_story"]
			local var_96_10 = 0.000666666666666593

			if var_96_10 < arg_93_1.time_ and arg_93_1.time_ <= var_96_10 + arg_96_0 and not isNil(var_96_9) and arg_93_1.var_.characterEffect1148ui_story == nil then
				arg_93_1.var_.characterEffect1148ui_story = var_96_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_11 = 0.2

			if var_96_10 <= arg_93_1.time_ and arg_93_1.time_ < var_96_10 + var_96_11 and not isNil(var_96_9) then
				local var_96_12 = (arg_93_1.time_ - var_96_10) / var_96_11

				if arg_93_1.var_.characterEffect1148ui_story and not isNil(var_96_9) then
					arg_93_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_93_1.time_ >= var_96_10 + var_96_11 and arg_93_1.time_ < var_96_10 + var_96_11 + arg_96_0 and not isNil(var_96_9) and arg_93_1.var_.characterEffect1148ui_story then
				arg_93_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_96_13 = 0.000666666666666593

			if var_96_13 < arg_93_1.time_ and arg_93_1.time_ <= var_96_13 + arg_96_0 then
				arg_93_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action4_1")
			end

			local var_96_14 = 0.000666666666666593

			if var_96_14 < arg_93_1.time_ and arg_93_1.time_ <= var_96_14 + arg_96_0 then
				arg_93_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_96_15 = 0
			local var_96_16 = 0.475

			if var_96_15 < arg_93_1.time_ and arg_93_1.time_ <= var_96_15 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				local var_96_17 = arg_93_1:FormatText(StoryNameCfg[8].name)

				arg_93_1.leftNameTxt_.text = var_96_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_18 = arg_93_1:GetWordFromCfg(116291022)
				local var_96_19 = arg_93_1:FormatText(var_96_18.content)

				arg_93_1.text_.text = var_96_19

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_20 = 19
				local var_96_21 = utf8.len(var_96_19)
				local var_96_22 = var_96_20 <= 0 and var_96_16 or var_96_16 * (var_96_21 / var_96_20)

				if var_96_22 > 0 and var_96_16 < var_96_22 then
					arg_93_1.talkMaxDuration = var_96_22

					if var_96_22 + var_96_15 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_22 + var_96_15
					end
				end

				arg_93_1.text_.text = var_96_19
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116291", "116291022", "story_v_out_116291.awb") ~= 0 then
					local var_96_23 = manager.audio:GetVoiceLength("story_v_out_116291", "116291022", "story_v_out_116291.awb") / 1000

					if var_96_23 + var_96_15 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_23 + var_96_15
					end

					if var_96_18.prefab_name ~= "" and arg_93_1.actors_[var_96_18.prefab_name] ~= nil then
						local var_96_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_18.prefab_name].transform, "story_v_out_116291", "116291022", "story_v_out_116291.awb")

						arg_93_1:RecordAudio("116291022", var_96_24)
						arg_93_1:RecordAudio("116291022", var_96_24)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_116291", "116291022", "story_v_out_116291.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_116291", "116291022", "story_v_out_116291.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_25 = math.max(var_96_16, arg_93_1.talkMaxDuration)

			if var_96_15 <= arg_93_1.time_ and arg_93_1.time_ < var_96_15 + var_96_25 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_15) / var_96_25

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_15 + var_96_25 and arg_93_1.time_ < var_96_15 + var_96_25 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_93_1:InitPlayNodeList()
	end,
	Play116291023 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 116291023
		arg_97_1.duration_ = 5

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play116291024(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = arg_97_1.actors_["1148ui_story"].transform
			local var_100_1 = 0

			if var_100_1 < arg_97_1.time_ and arg_97_1.time_ <= var_100_1 + arg_100_0 then
				arg_97_1.var_.moveOldPos1148ui_story = var_100_0.localPosition
			end

			local var_100_2 = 0.001

			if var_100_1 <= arg_97_1.time_ and arg_97_1.time_ < var_100_1 + var_100_2 then
				local var_100_3 = (arg_97_1.time_ - var_100_1) / var_100_2
				local var_100_4 = Vector3.New(0, 100, 0)

				var_100_0.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos1148ui_story, var_100_4, var_100_3)

				local var_100_5 = manager.ui.mainCamera.transform.position - var_100_0.position

				var_100_0.forward = Vector3.New(var_100_5.x, var_100_5.y, var_100_5.z)

				local var_100_6 = var_100_0.localEulerAngles

				var_100_6.z = 0
				var_100_6.x = 0
				var_100_0.localEulerAngles = var_100_6
			end

			if arg_97_1.time_ >= var_100_1 + var_100_2 and arg_97_1.time_ < var_100_1 + var_100_2 + arg_100_0 then
				var_100_0.localPosition = Vector3.New(0, 100, 0)

				local var_100_7 = manager.ui.mainCamera.transform.position - var_100_0.position

				var_100_0.forward = Vector3.New(var_100_7.x, var_100_7.y, var_100_7.z)

				local var_100_8 = var_100_0.localEulerAngles

				var_100_8.z = 0
				var_100_8.x = 0
				var_100_0.localEulerAngles = var_100_8
			end

			local var_100_9 = 0
			local var_100_10 = 0.725

			if var_100_9 < arg_97_1.time_ and arg_97_1.time_ <= var_100_9 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, false)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_11 = arg_97_1:GetWordFromCfg(116291023)
				local var_100_12 = arg_97_1:FormatText(var_100_11.content)

				arg_97_1.text_.text = var_100_12

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_13 = 29
				local var_100_14 = utf8.len(var_100_12)
				local var_100_15 = var_100_13 <= 0 and var_100_10 or var_100_10 * (var_100_14 / var_100_13)

				if var_100_15 > 0 and var_100_10 < var_100_15 then
					arg_97_1.talkMaxDuration = var_100_15

					if var_100_15 + var_100_9 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_15 + var_100_9
					end
				end

				arg_97_1.text_.text = var_100_12
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)
				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_16 = math.max(var_100_10, arg_97_1.talkMaxDuration)

			if var_100_9 <= arg_97_1.time_ and arg_97_1.time_ < var_100_9 + var_100_16 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_9) / var_100_16

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_9 + var_100_16 and arg_97_1.time_ < var_100_9 + var_100_16 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_97_1:InitPlayNodeList()
	end,
	Play116291024 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 116291024
		arg_101_1.duration_ = 5

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play116291025(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = 0
			local var_104_1 = 0.975

			if var_104_0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_0 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, false)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_2 = arg_101_1:GetWordFromCfg(116291024)
				local var_104_3 = arg_101_1:FormatText(var_104_2.content)

				arg_101_1.text_.text = var_104_3

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_4 = 39
				local var_104_5 = utf8.len(var_104_3)
				local var_104_6 = var_104_4 <= 0 and var_104_1 or var_104_1 * (var_104_5 / var_104_4)

				if var_104_6 > 0 and var_104_1 < var_104_6 then
					arg_101_1.talkMaxDuration = var_104_6

					if var_104_6 + var_104_0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_6 + var_104_0
					end
				end

				arg_101_1.text_.text = var_104_3
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)
				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_7 = math.max(var_104_1, arg_101_1.talkMaxDuration)

			if var_104_0 <= arg_101_1.time_ and arg_101_1.time_ < var_104_0 + var_104_7 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_0) / var_104_7

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_0 + var_104_7 and arg_101_1.time_ < var_104_0 + var_104_7 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play116291025 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 116291025
		arg_105_1.duration_ = 11

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play116291026(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = "B13c"

			if arg_105_1.bgs_[var_108_0] == nil then
				local var_108_1 = Object.Instantiate(arg_105_1.paintGo_)

				var_108_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_108_0)
				var_108_1.name = var_108_0
				var_108_1.transform.parent = arg_105_1.stage_.transform
				var_108_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_105_1.bgs_[var_108_0] = var_108_1
			end

			local var_108_2 = 3

			if var_108_2 < arg_105_1.time_ and arg_105_1.time_ <= var_108_2 + arg_108_0 then
				local var_108_3 = manager.ui.mainCamera.transform.localPosition
				local var_108_4 = Vector3.New(0, 0, 10) + Vector3.New(var_108_3.x, var_108_3.y, 0)
				local var_108_5 = arg_105_1.bgs_.B13c

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
					if iter_108_0 ~= "B13c" then
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

			local var_108_17 = 3

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

			local var_108_21 = 3

			if var_108_21 < arg_105_1.time_ and arg_105_1.time_ <= var_108_21 + arg_108_0 then
				arg_105_1.mask_.enabled = true
				arg_105_1.mask_.raycastTarget = true

				arg_105_1:SetGaussion(false)
			end

			local var_108_22 = 3

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

			if arg_105_1.frameCnt_ <= 1 then
				arg_105_1.dialog_:SetActive(false)
			end

			local var_108_27 = 6
			local var_108_28 = 0.875

			if var_108_27 < arg_105_1.time_ and arg_105_1.time_ <= var_108_27 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0

				arg_105_1.dialog_:SetActive(true)

				arg_105_1.dialogCg_.alpha = 0

				local var_108_29 = LeanTween.value(arg_105_1.dialog_, 0, 1, 0.3)

				var_108_29:setOnUpdate(LuaHelper.FloatAction(function(arg_109_0)
					arg_105_1.dialogCg_.alpha = arg_109_0
				end))
				var_108_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_105_1.dialog_)
					var_108_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_105_1.duration_ = arg_105_1.duration_ + 0.3

				SetActive(arg_105_1.leftNameGo_, false)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_30 = arg_105_1:GetWordFromCfg(116291025)
				local var_108_31 = arg_105_1:FormatText(var_108_30.content)

				arg_105_1.text_.text = var_108_31

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_32 = 35
				local var_108_33 = utf8.len(var_108_31)
				local var_108_34 = var_108_32 <= 0 and var_108_28 or var_108_28 * (var_108_33 / var_108_32)

				if var_108_34 > 0 and var_108_28 < var_108_34 then
					arg_105_1.talkMaxDuration = var_108_34
					var_108_27 = var_108_27 + 0.3

					if var_108_34 + var_108_27 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_34 + var_108_27
					end
				end

				arg_105_1.text_.text = var_108_31
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)
				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_35 = var_108_27 + 0.3
			local var_108_36 = math.max(var_108_28, arg_105_1.talkMaxDuration)

			if var_108_35 <= arg_105_1.time_ and arg_105_1.time_ < var_108_35 + var_108_36 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_35) / var_108_36

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_35 + var_108_36 and arg_105_1.time_ < var_108_35 + var_108_36 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play116291026 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 116291026
		arg_111_1.duration_ = 2

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play116291027(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = "1059ui_story"

			if arg_111_1.actors_[var_114_0] == nil then
				local var_114_1 = Asset.Load("Char/" .. "1059ui_story")

				if not isNil(var_114_1) then
					local var_114_2 = Object.Instantiate(Asset.Load("Char/" .. "1059ui_story"), arg_111_1.stage_.transform)

					var_114_2.name = var_114_0
					var_114_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_111_1.actors_[var_114_0] = var_114_2

					local var_114_3 = var_114_2:GetComponentInChildren(typeof(CharacterEffect))

					var_114_3.enabled = true

					local var_114_4 = GameObjectTools.GetOrAddComponent(var_114_2, typeof(DynamicBoneHelper))

					if var_114_4 then
						var_114_4:EnableDynamicBone(false)
					end

					arg_111_1:ShowWeapon(var_114_3.transform, false)

					arg_111_1.var_[var_114_0 .. "Animator"] = var_114_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_111_1.var_[var_114_0 .. "Animator"].applyRootMotion = true
					arg_111_1.var_[var_114_0 .. "LipSync"] = var_114_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_114_5 = arg_111_1.actors_["1059ui_story"].transform
			local var_114_6 = 0

			if var_114_6 < arg_111_1.time_ and arg_111_1.time_ <= var_114_6 + arg_114_0 then
				arg_111_1.var_.moveOldPos1059ui_story = var_114_5.localPosition
			end

			local var_114_7 = 0.001

			if var_114_6 <= arg_111_1.time_ and arg_111_1.time_ < var_114_6 + var_114_7 then
				local var_114_8 = (arg_111_1.time_ - var_114_6) / var_114_7
				local var_114_9 = Vector3.New(0, -1.05, -6)

				var_114_5.localPosition = Vector3.Lerp(arg_111_1.var_.moveOldPos1059ui_story, var_114_9, var_114_8)

				local var_114_10 = manager.ui.mainCamera.transform.position - var_114_5.position

				var_114_5.forward = Vector3.New(var_114_10.x, var_114_10.y, var_114_10.z)

				local var_114_11 = var_114_5.localEulerAngles

				var_114_11.z = 0
				var_114_11.x = 0
				var_114_5.localEulerAngles = var_114_11
			end

			if arg_111_1.time_ >= var_114_6 + var_114_7 and arg_111_1.time_ < var_114_6 + var_114_7 + arg_114_0 then
				var_114_5.localPosition = Vector3.New(0, -1.05, -6)

				local var_114_12 = manager.ui.mainCamera.transform.position - var_114_5.position

				var_114_5.forward = Vector3.New(var_114_12.x, var_114_12.y, var_114_12.z)

				local var_114_13 = var_114_5.localEulerAngles

				var_114_13.z = 0
				var_114_13.x = 0
				var_114_5.localEulerAngles = var_114_13
			end

			local var_114_14 = arg_111_1.actors_["1059ui_story"]
			local var_114_15 = 0

			if var_114_15 < arg_111_1.time_ and arg_111_1.time_ <= var_114_15 + arg_114_0 and not isNil(var_114_14) and arg_111_1.var_.characterEffect1059ui_story == nil then
				arg_111_1.var_.characterEffect1059ui_story = var_114_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_16 = 0.2

			if var_114_15 <= arg_111_1.time_ and arg_111_1.time_ < var_114_15 + var_114_16 and not isNil(var_114_14) then
				local var_114_17 = (arg_111_1.time_ - var_114_15) / var_114_16

				if arg_111_1.var_.characterEffect1059ui_story and not isNil(var_114_14) then
					arg_111_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_111_1.time_ >= var_114_15 + var_114_16 and arg_111_1.time_ < var_114_15 + var_114_16 + arg_114_0 and not isNil(var_114_14) and arg_111_1.var_.characterEffect1059ui_story then
				arg_111_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_114_18 = 0

			if var_114_18 < arg_111_1.time_ and arg_111_1.time_ <= var_114_18 + arg_114_0 then
				arg_111_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action1_1")
			end

			local var_114_19 = 0

			if var_114_19 < arg_111_1.time_ and arg_111_1.time_ <= var_114_19 + arg_114_0 then
				arg_111_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_114_20 = 0
			local var_114_21 = 0.1

			if var_114_20 < arg_111_1.time_ and arg_111_1.time_ <= var_114_20 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				local var_114_22 = arg_111_1:FormatText(StoryNameCfg[28].name)

				arg_111_1.leftNameTxt_.text = var_114_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_23 = arg_111_1:GetWordFromCfg(116291026)
				local var_114_24 = arg_111_1:FormatText(var_114_23.content)

				arg_111_1.text_.text = var_114_24

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_25 = 4
				local var_114_26 = utf8.len(var_114_24)
				local var_114_27 = var_114_25 <= 0 and var_114_21 or var_114_21 * (var_114_26 / var_114_25)

				if var_114_27 > 0 and var_114_21 < var_114_27 then
					arg_111_1.talkMaxDuration = var_114_27

					if var_114_27 + var_114_20 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_27 + var_114_20
					end
				end

				arg_111_1.text_.text = var_114_24
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116291", "116291026", "story_v_out_116291.awb") ~= 0 then
					local var_114_28 = manager.audio:GetVoiceLength("story_v_out_116291", "116291026", "story_v_out_116291.awb") / 1000

					if var_114_28 + var_114_20 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_28 + var_114_20
					end

					if var_114_23.prefab_name ~= "" and arg_111_1.actors_[var_114_23.prefab_name] ~= nil then
						local var_114_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_23.prefab_name].transform, "story_v_out_116291", "116291026", "story_v_out_116291.awb")

						arg_111_1:RecordAudio("116291026", var_114_29)
						arg_111_1:RecordAudio("116291026", var_114_29)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_116291", "116291026", "story_v_out_116291.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_116291", "116291026", "story_v_out_116291.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_30 = math.max(var_114_21, arg_111_1.talkMaxDuration)

			if var_114_20 <= arg_111_1.time_ and arg_111_1.time_ < var_114_20 + var_114_30 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_20) / var_114_30

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_20 + var_114_30 and arg_111_1.time_ < var_114_20 + var_114_30 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_111_1:InitPlayNodeList()
	end,
	Play116291027 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 116291027
		arg_115_1.duration_ = 3.43

		local var_115_0 = {
			zh = 3.433,
			ja = 1.999999999999
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
				arg_115_0:Play116291028(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = 0

			if var_118_0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_0 + arg_118_0 then
				arg_115_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action6_1")
			end

			local var_118_1 = 0

			if var_118_1 < arg_115_1.time_ and arg_115_1.time_ <= var_118_1 + arg_118_0 then
				arg_115_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_118_2 = arg_115_1.actors_["1059ui_story"].transform
			local var_118_3 = 0

			if var_118_3 < arg_115_1.time_ and arg_115_1.time_ <= var_118_3 + arg_118_0 then
				arg_115_1.var_.moveOldPos1059ui_story = var_118_2.localPosition
			end

			local var_118_4 = 0.001

			if var_118_3 <= arg_115_1.time_ and arg_115_1.time_ < var_118_3 + var_118_4 then
				local var_118_5 = (arg_115_1.time_ - var_118_3) / var_118_4
				local var_118_6 = Vector3.New(0, 100, 0)

				var_118_2.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos1059ui_story, var_118_6, var_118_5)

				local var_118_7 = manager.ui.mainCamera.transform.position - var_118_2.position

				var_118_2.forward = Vector3.New(var_118_7.x, var_118_7.y, var_118_7.z)

				local var_118_8 = var_118_2.localEulerAngles

				var_118_8.z = 0
				var_118_8.x = 0
				var_118_2.localEulerAngles = var_118_8
			end

			if arg_115_1.time_ >= var_118_3 + var_118_4 and arg_115_1.time_ < var_118_3 + var_118_4 + arg_118_0 then
				var_118_2.localPosition = Vector3.New(0, 100, 0)

				local var_118_9 = manager.ui.mainCamera.transform.position - var_118_2.position

				var_118_2.forward = Vector3.New(var_118_9.x, var_118_9.y, var_118_9.z)

				local var_118_10 = var_118_2.localEulerAngles

				var_118_10.z = 0
				var_118_10.x = 0
				var_118_2.localEulerAngles = var_118_10
			end

			local var_118_11 = arg_115_1.actors_["10025ui_story"].transform
			local var_118_12 = 0

			if var_118_12 < arg_115_1.time_ and arg_115_1.time_ <= var_118_12 + arg_118_0 then
				arg_115_1.var_.moveOldPos10025ui_story = var_118_11.localPosition
			end

			local var_118_13 = 0.001

			if var_118_12 <= arg_115_1.time_ and arg_115_1.time_ < var_118_12 + var_118_13 then
				local var_118_14 = (arg_115_1.time_ - var_118_12) / var_118_13
				local var_118_15 = Vector3.New(0, -1.1, -5.9)

				var_118_11.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos10025ui_story, var_118_15, var_118_14)

				local var_118_16 = manager.ui.mainCamera.transform.position - var_118_11.position

				var_118_11.forward = Vector3.New(var_118_16.x, var_118_16.y, var_118_16.z)

				local var_118_17 = var_118_11.localEulerAngles

				var_118_17.z = 0
				var_118_17.x = 0
				var_118_11.localEulerAngles = var_118_17
			end

			if arg_115_1.time_ >= var_118_12 + var_118_13 and arg_115_1.time_ < var_118_12 + var_118_13 + arg_118_0 then
				var_118_11.localPosition = Vector3.New(0, -1.1, -5.9)

				local var_118_18 = manager.ui.mainCamera.transform.position - var_118_11.position

				var_118_11.forward = Vector3.New(var_118_18.x, var_118_18.y, var_118_18.z)

				local var_118_19 = var_118_11.localEulerAngles

				var_118_19.z = 0
				var_118_19.x = 0
				var_118_11.localEulerAngles = var_118_19
			end

			local var_118_20 = arg_115_1.actors_["10025ui_story"]
			local var_118_21 = 0

			if var_118_21 < arg_115_1.time_ and arg_115_1.time_ <= var_118_21 + arg_118_0 and not isNil(var_118_20) and arg_115_1.var_.characterEffect10025ui_story == nil then
				arg_115_1.var_.characterEffect10025ui_story = var_118_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_22 = 0.2

			if var_118_21 <= arg_115_1.time_ and arg_115_1.time_ < var_118_21 + var_118_22 and not isNil(var_118_20) then
				local var_118_23 = (arg_115_1.time_ - var_118_21) / var_118_22

				if arg_115_1.var_.characterEffect10025ui_story and not isNil(var_118_20) then
					arg_115_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_115_1.time_ >= var_118_21 + var_118_22 and arg_115_1.time_ < var_118_21 + var_118_22 + arg_118_0 and not isNil(var_118_20) and arg_115_1.var_.characterEffect10025ui_story then
				arg_115_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			local var_118_24 = 0
			local var_118_25 = 0.1

			if var_118_24 < arg_115_1.time_ and arg_115_1.time_ <= var_118_24 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				local var_118_26 = arg_115_1:FormatText(StoryNameCfg[328].name)

				arg_115_1.leftNameTxt_.text = var_118_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_27 = arg_115_1:GetWordFromCfg(116291027)
				local var_118_28 = arg_115_1:FormatText(var_118_27.content)

				arg_115_1.text_.text = var_118_28

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_29 = 4
				local var_118_30 = utf8.len(var_118_28)
				local var_118_31 = var_118_29 <= 0 and var_118_25 or var_118_25 * (var_118_30 / var_118_29)

				if var_118_31 > 0 and var_118_25 < var_118_31 then
					arg_115_1.talkMaxDuration = var_118_31

					if var_118_31 + var_118_24 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_31 + var_118_24
					end
				end

				arg_115_1.text_.text = var_118_28
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116291", "116291027", "story_v_out_116291.awb") ~= 0 then
					local var_118_32 = manager.audio:GetVoiceLength("story_v_out_116291", "116291027", "story_v_out_116291.awb") / 1000

					if var_118_32 + var_118_24 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_32 + var_118_24
					end

					if var_118_27.prefab_name ~= "" and arg_115_1.actors_[var_118_27.prefab_name] ~= nil then
						local var_118_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_27.prefab_name].transform, "story_v_out_116291", "116291027", "story_v_out_116291.awb")

						arg_115_1:RecordAudio("116291027", var_118_33)
						arg_115_1:RecordAudio("116291027", var_118_33)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_116291", "116291027", "story_v_out_116291.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_116291", "116291027", "story_v_out_116291.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_34 = math.max(var_118_25, arg_115_1.talkMaxDuration)

			if var_118_24 <= arg_115_1.time_ and arg_115_1.time_ < var_118_24 + var_118_34 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_24) / var_118_34

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_24 + var_118_34 and arg_115_1.time_ < var_118_24 + var_118_34 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_115_1:InitPlayNodeList()
	end,
	Play116291028 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 116291028
		arg_119_1.duration_ = 5

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play116291029(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = 0
			local var_122_1 = 1

			if var_122_0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_0 + arg_122_0 then
				local var_122_2 = "play"
				local var_122_3 = "effect"

				arg_119_1:AudioAction(var_122_2, var_122_3, "se_story_16", "se_story_16_metal", "")
			end

			local var_122_4 = arg_119_1.actors_["10025ui_story"].transform
			local var_122_5 = 0

			if var_122_5 < arg_119_1.time_ and arg_119_1.time_ <= var_122_5 + arg_122_0 then
				arg_119_1.var_.moveOldPos10025ui_story = var_122_4.localPosition
			end

			local var_122_6 = 0.001

			if var_122_5 <= arg_119_1.time_ and arg_119_1.time_ < var_122_5 + var_122_6 then
				local var_122_7 = (arg_119_1.time_ - var_122_5) / var_122_6
				local var_122_8 = Vector3.New(0, 100, 0)

				var_122_4.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos10025ui_story, var_122_8, var_122_7)

				local var_122_9 = manager.ui.mainCamera.transform.position - var_122_4.position

				var_122_4.forward = Vector3.New(var_122_9.x, var_122_9.y, var_122_9.z)

				local var_122_10 = var_122_4.localEulerAngles

				var_122_10.z = 0
				var_122_10.x = 0
				var_122_4.localEulerAngles = var_122_10
			end

			if arg_119_1.time_ >= var_122_5 + var_122_6 and arg_119_1.time_ < var_122_5 + var_122_6 + arg_122_0 then
				var_122_4.localPosition = Vector3.New(0, 100, 0)

				local var_122_11 = manager.ui.mainCamera.transform.position - var_122_4.position

				var_122_4.forward = Vector3.New(var_122_11.x, var_122_11.y, var_122_11.z)

				local var_122_12 = var_122_4.localEulerAngles

				var_122_12.z = 0
				var_122_12.x = 0
				var_122_4.localEulerAngles = var_122_12
			end

			local var_122_13 = manager.ui.mainCamera.transform
			local var_122_14 = 0

			if var_122_14 < arg_119_1.time_ and arg_119_1.time_ <= var_122_14 + arg_122_0 then
				arg_119_1.var_.shakeOldPos = var_122_13.localPosition
			end

			local var_122_15 = 1

			if var_122_14 <= arg_119_1.time_ and arg_119_1.time_ < var_122_14 + var_122_15 then
				local var_122_16 = (arg_119_1.time_ - var_122_14) / 0.066
				local var_122_17, var_122_18 = math.modf(var_122_16)

				var_122_13.localPosition = Vector3.New(var_122_18 * 0.13, var_122_18 * 0.13, var_122_18 * 0.13) + arg_119_1.var_.shakeOldPos
			end

			if arg_119_1.time_ >= var_122_14 + var_122_15 and arg_119_1.time_ < var_122_14 + var_122_15 + arg_122_0 then
				var_122_13.localPosition = arg_119_1.var_.shakeOldPos
			end

			local var_122_19 = 0
			local var_122_20 = 1.15

			if var_122_19 < arg_119_1.time_ and arg_119_1.time_ <= var_122_19 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, false)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_21 = arg_119_1:GetWordFromCfg(116291028)
				local var_122_22 = arg_119_1:FormatText(var_122_21.content)

				arg_119_1.text_.text = var_122_22

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_23 = 46
				local var_122_24 = utf8.len(var_122_22)
				local var_122_25 = var_122_23 <= 0 and var_122_20 or var_122_20 * (var_122_24 / var_122_23)

				if var_122_25 > 0 and var_122_20 < var_122_25 then
					arg_119_1.talkMaxDuration = var_122_25

					if var_122_25 + var_122_19 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_25 + var_122_19
					end
				end

				arg_119_1.text_.text = var_122_22
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)
				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_26 = math.max(var_122_20, arg_119_1.talkMaxDuration)

			if var_122_19 <= arg_119_1.time_ and arg_119_1.time_ < var_122_19 + var_122_26 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_19) / var_122_26

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_19 + var_122_26 and arg_119_1.time_ < var_122_19 + var_122_26 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {
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

		arg_119_1:InitPlayNodeList()
	end,
	Play116291029 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 116291029
		arg_123_1.duration_ = 5

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play116291030(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = 0
			local var_126_1 = 0.875

			if var_126_0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_0 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, false)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_2 = arg_123_1:GetWordFromCfg(116291029)
				local var_126_3 = arg_123_1:FormatText(var_126_2.content)

				arg_123_1.text_.text = var_126_3

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_4 = 35
				local var_126_5 = utf8.len(var_126_3)
				local var_126_6 = var_126_4 <= 0 and var_126_1 or var_126_1 * (var_126_5 / var_126_4)

				if var_126_6 > 0 and var_126_1 < var_126_6 then
					arg_123_1.talkMaxDuration = var_126_6

					if var_126_6 + var_126_0 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_6 + var_126_0
					end
				end

				arg_123_1.text_.text = var_126_3
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)
				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_7 = math.max(var_126_1, arg_123_1.talkMaxDuration)

			if var_126_0 <= arg_123_1.time_ and arg_123_1.time_ < var_126_0 + var_126_7 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_0) / var_126_7

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_0 + var_126_7 and arg_123_1.time_ < var_126_0 + var_126_7 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play116291030 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 116291030
		arg_127_1.duration_ = 5

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play116291031(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = 0
			local var_130_1 = 0.9

			if var_130_0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_0 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, false)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_2 = arg_127_1:GetWordFromCfg(116291030)
				local var_130_3 = arg_127_1:FormatText(var_130_2.content)

				arg_127_1.text_.text = var_130_3

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_4 = 36
				local var_130_5 = utf8.len(var_130_3)
				local var_130_6 = var_130_4 <= 0 and var_130_1 or var_130_1 * (var_130_5 / var_130_4)

				if var_130_6 > 0 and var_130_1 < var_130_6 then
					arg_127_1.talkMaxDuration = var_130_6

					if var_130_6 + var_130_0 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_6 + var_130_0
					end
				end

				arg_127_1.text_.text = var_130_3
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)
				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_7 = math.max(var_130_1, arg_127_1.talkMaxDuration)

			if var_130_0 <= arg_127_1.time_ and arg_127_1.time_ < var_130_0 + var_130_7 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_0) / var_130_7

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_0 + var_130_7 and arg_127_1.time_ < var_130_0 + var_130_7 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play116291031 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 116291031
		arg_131_1.duration_ = 10.63

		local var_131_0 = {
			zh = 10.633,
			ja = 6.066
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
				arg_131_0:Play116291032(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = "1028ui_story"

			if arg_131_1.actors_[var_134_0] == nil then
				local var_134_1 = Asset.Load("Char/" .. "1028ui_story")

				if not isNil(var_134_1) then
					local var_134_2 = Object.Instantiate(Asset.Load("Char/" .. "1028ui_story"), arg_131_1.stage_.transform)

					var_134_2.name = var_134_0
					var_134_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_131_1.actors_[var_134_0] = var_134_2

					local var_134_3 = var_134_2:GetComponentInChildren(typeof(CharacterEffect))

					var_134_3.enabled = true

					local var_134_4 = GameObjectTools.GetOrAddComponent(var_134_2, typeof(DynamicBoneHelper))

					if var_134_4 then
						var_134_4:EnableDynamicBone(false)
					end

					arg_131_1:ShowWeapon(var_134_3.transform, false)

					arg_131_1.var_[var_134_0 .. "Animator"] = var_134_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_131_1.var_[var_134_0 .. "Animator"].applyRootMotion = true
					arg_131_1.var_[var_134_0 .. "LipSync"] = var_134_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_134_5 = arg_131_1.actors_["1028ui_story"].transform
			local var_134_6 = 0

			if var_134_6 < arg_131_1.time_ and arg_131_1.time_ <= var_134_6 + arg_134_0 then
				arg_131_1.var_.moveOldPos1028ui_story = var_134_5.localPosition
			end

			local var_134_7 = 0.001

			if var_134_6 <= arg_131_1.time_ and arg_131_1.time_ < var_134_6 + var_134_7 then
				local var_134_8 = (arg_131_1.time_ - var_134_6) / var_134_7
				local var_134_9 = Vector3.New(-0.7, -0.9, -5.9)

				var_134_5.localPosition = Vector3.Lerp(arg_131_1.var_.moveOldPos1028ui_story, var_134_9, var_134_8)

				local var_134_10 = manager.ui.mainCamera.transform.position - var_134_5.position

				var_134_5.forward = Vector3.New(var_134_10.x, var_134_10.y, var_134_10.z)

				local var_134_11 = var_134_5.localEulerAngles

				var_134_11.z = 0
				var_134_11.x = 0
				var_134_5.localEulerAngles = var_134_11
			end

			if arg_131_1.time_ >= var_134_6 + var_134_7 and arg_131_1.time_ < var_134_6 + var_134_7 + arg_134_0 then
				var_134_5.localPosition = Vector3.New(-0.7, -0.9, -5.9)

				local var_134_12 = manager.ui.mainCamera.transform.position - var_134_5.position

				var_134_5.forward = Vector3.New(var_134_12.x, var_134_12.y, var_134_12.z)

				local var_134_13 = var_134_5.localEulerAngles

				var_134_13.z = 0
				var_134_13.x = 0
				var_134_5.localEulerAngles = var_134_13
			end

			local var_134_14 = "10024ui_story"

			if arg_131_1.actors_[var_134_14] == nil then
				local var_134_15 = Asset.Load("Char/" .. "10024ui_story")

				if not isNil(var_134_15) then
					local var_134_16 = Object.Instantiate(Asset.Load("Char/" .. "10024ui_story"), arg_131_1.stage_.transform)

					var_134_16.name = var_134_14
					var_134_16.transform.localPosition = Vector3.New(0, 100, 0)
					arg_131_1.actors_[var_134_14] = var_134_16

					local var_134_17 = var_134_16:GetComponentInChildren(typeof(CharacterEffect))

					var_134_17.enabled = true

					local var_134_18 = GameObjectTools.GetOrAddComponent(var_134_16, typeof(DynamicBoneHelper))

					if var_134_18 then
						var_134_18:EnableDynamicBone(false)
					end

					arg_131_1:ShowWeapon(var_134_17.transform, false)

					arg_131_1.var_[var_134_14 .. "Animator"] = var_134_17.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_131_1.var_[var_134_14 .. "Animator"].applyRootMotion = true
					arg_131_1.var_[var_134_14 .. "LipSync"] = var_134_17.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_134_19 = arg_131_1.actors_["10024ui_story"].transform
			local var_134_20 = 0

			if var_134_20 < arg_131_1.time_ and arg_131_1.time_ <= var_134_20 + arg_134_0 then
				arg_131_1.var_.moveOldPos10024ui_story = var_134_19.localPosition
			end

			local var_134_21 = 0.001

			if var_134_20 <= arg_131_1.time_ and arg_131_1.time_ < var_134_20 + var_134_21 then
				local var_134_22 = (arg_131_1.time_ - var_134_20) / var_134_21
				local var_134_23 = Vector3.New(0.7, -1, -6)

				var_134_19.localPosition = Vector3.Lerp(arg_131_1.var_.moveOldPos10024ui_story, var_134_23, var_134_22)

				local var_134_24 = manager.ui.mainCamera.transform.position - var_134_19.position

				var_134_19.forward = Vector3.New(var_134_24.x, var_134_24.y, var_134_24.z)

				local var_134_25 = var_134_19.localEulerAngles

				var_134_25.z = 0
				var_134_25.x = 0
				var_134_19.localEulerAngles = var_134_25
			end

			if arg_131_1.time_ >= var_134_20 + var_134_21 and arg_131_1.time_ < var_134_20 + var_134_21 + arg_134_0 then
				var_134_19.localPosition = Vector3.New(0.7, -1, -6)

				local var_134_26 = manager.ui.mainCamera.transform.position - var_134_19.position

				var_134_19.forward = Vector3.New(var_134_26.x, var_134_26.y, var_134_26.z)

				local var_134_27 = var_134_19.localEulerAngles

				var_134_27.z = 0
				var_134_27.x = 0
				var_134_19.localEulerAngles = var_134_27
			end

			local var_134_28 = arg_131_1.actors_["1028ui_story"]
			local var_134_29 = 0

			if var_134_29 < arg_131_1.time_ and arg_131_1.time_ <= var_134_29 + arg_134_0 and not isNil(var_134_28) and arg_131_1.var_.characterEffect1028ui_story == nil then
				arg_131_1.var_.characterEffect1028ui_story = var_134_28:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_30 = 0.2

			if var_134_29 <= arg_131_1.time_ and arg_131_1.time_ < var_134_29 + var_134_30 and not isNil(var_134_28) then
				local var_134_31 = (arg_131_1.time_ - var_134_29) / var_134_30

				if arg_131_1.var_.characterEffect1028ui_story and not isNil(var_134_28) then
					arg_131_1.var_.characterEffect1028ui_story.fillFlat = false
				end
			end

			if arg_131_1.time_ >= var_134_29 + var_134_30 and arg_131_1.time_ < var_134_29 + var_134_30 + arg_134_0 and not isNil(var_134_28) and arg_131_1.var_.characterEffect1028ui_story then
				arg_131_1.var_.characterEffect1028ui_story.fillFlat = false
			end

			local var_134_32 = 0

			if var_134_32 < arg_131_1.time_ and arg_131_1.time_ <= var_134_32 + arg_134_0 then
				arg_131_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/story1028/story1028action/1028action7_1")
			end

			local var_134_33 = 0

			if var_134_33 < arg_131_1.time_ and arg_131_1.time_ <= var_134_33 + arg_134_0 then
				arg_131_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_134_34 = arg_131_1.actors_["10024ui_story"]
			local var_134_35 = 0

			if var_134_35 < arg_131_1.time_ and arg_131_1.time_ <= var_134_35 + arg_134_0 and not isNil(var_134_34) and arg_131_1.var_.characterEffect10024ui_story == nil then
				arg_131_1.var_.characterEffect10024ui_story = var_134_34:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_36 = 0.034

			if var_134_35 <= arg_131_1.time_ and arg_131_1.time_ < var_134_35 + var_134_36 and not isNil(var_134_34) then
				local var_134_37 = (arg_131_1.time_ - var_134_35) / var_134_36

				if arg_131_1.var_.characterEffect10024ui_story and not isNil(var_134_34) then
					local var_134_38 = Mathf.Lerp(0, 0.5, var_134_37)

					arg_131_1.var_.characterEffect10024ui_story.fillFlat = true
					arg_131_1.var_.characterEffect10024ui_story.fillRatio = var_134_38
				end
			end

			if arg_131_1.time_ >= var_134_35 + var_134_36 and arg_131_1.time_ < var_134_35 + var_134_36 + arg_134_0 and not isNil(var_134_34) and arg_131_1.var_.characterEffect10024ui_story then
				local var_134_39 = 0.5

				arg_131_1.var_.characterEffect10024ui_story.fillFlat = true
				arg_131_1.var_.characterEffect10024ui_story.fillRatio = var_134_39
			end

			local var_134_40 = 0

			if var_134_40 < arg_131_1.time_ and arg_131_1.time_ <= var_134_40 + arg_134_0 then
				arg_131_1:PlayTimeline("10024ui_story", "StoryTimeline/CharAction/story10024/story10024action/10024action1_1")
			end

			local var_134_41 = 0

			if var_134_41 < arg_131_1.time_ and arg_131_1.time_ <= var_134_41 + arg_134_0 then
				arg_131_1:PlayTimeline("10024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_134_42 = 0
			local var_134_43 = 1.075

			if var_134_42 < arg_131_1.time_ and arg_131_1.time_ <= var_134_42 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				local var_134_44 = arg_131_1:FormatText(StoryNameCfg[327].name)

				arg_131_1.leftNameTxt_.text = var_134_44

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_45 = arg_131_1:GetWordFromCfg(116291031)
				local var_134_46 = arg_131_1:FormatText(var_134_45.content)

				arg_131_1.text_.text = var_134_46

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_47 = 43
				local var_134_48 = utf8.len(var_134_46)
				local var_134_49 = var_134_47 <= 0 and var_134_43 or var_134_43 * (var_134_48 / var_134_47)

				if var_134_49 > 0 and var_134_43 < var_134_49 then
					arg_131_1.talkMaxDuration = var_134_49

					if var_134_49 + var_134_42 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_49 + var_134_42
					end
				end

				arg_131_1.text_.text = var_134_46
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116291", "116291031", "story_v_out_116291.awb") ~= 0 then
					local var_134_50 = manager.audio:GetVoiceLength("story_v_out_116291", "116291031", "story_v_out_116291.awb") / 1000

					if var_134_50 + var_134_42 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_50 + var_134_42
					end

					if var_134_45.prefab_name ~= "" and arg_131_1.actors_[var_134_45.prefab_name] ~= nil then
						local var_134_51 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_45.prefab_name].transform, "story_v_out_116291", "116291031", "story_v_out_116291.awb")

						arg_131_1:RecordAudio("116291031", var_134_51)
						arg_131_1:RecordAudio("116291031", var_134_51)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_116291", "116291031", "story_v_out_116291.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_116291", "116291031", "story_v_out_116291.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_52 = math.max(var_134_43, arg_131_1.talkMaxDuration)

			if var_134_42 <= arg_131_1.time_ and arg_131_1.time_ < var_134_42 + var_134_52 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_42) / var_134_52

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_42 + var_134_52 and arg_131_1.time_ < var_134_42 + var_134_52 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_131_1:InitPlayNodeList()
	end,
	Play116291032 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 116291032
		arg_135_1.duration_ = 5

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play116291033(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = arg_135_1.actors_["1028ui_story"]
			local var_138_1 = 0

			if var_138_1 < arg_135_1.time_ and arg_135_1.time_ <= var_138_1 + arg_138_0 and not isNil(var_138_0) and arg_135_1.var_.characterEffect1028ui_story == nil then
				arg_135_1.var_.characterEffect1028ui_story = var_138_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_2 = 0.2

			if var_138_1 <= arg_135_1.time_ and arg_135_1.time_ < var_138_1 + var_138_2 and not isNil(var_138_0) then
				local var_138_3 = (arg_135_1.time_ - var_138_1) / var_138_2

				if arg_135_1.var_.characterEffect1028ui_story and not isNil(var_138_0) then
					local var_138_4 = Mathf.Lerp(0, 0.5, var_138_3)

					arg_135_1.var_.characterEffect1028ui_story.fillFlat = true
					arg_135_1.var_.characterEffect1028ui_story.fillRatio = var_138_4
				end
			end

			if arg_135_1.time_ >= var_138_1 + var_138_2 and arg_135_1.time_ < var_138_1 + var_138_2 + arg_138_0 and not isNil(var_138_0) and arg_135_1.var_.characterEffect1028ui_story then
				local var_138_5 = 0.5

				arg_135_1.var_.characterEffect1028ui_story.fillFlat = true
				arg_135_1.var_.characterEffect1028ui_story.fillRatio = var_138_5
			end

			local var_138_6 = 0
			local var_138_7 = 1.35

			if var_138_6 < arg_135_1.time_ and arg_135_1.time_ <= var_138_6 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, false)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_8 = arg_135_1:GetWordFromCfg(116291032)
				local var_138_9 = arg_135_1:FormatText(var_138_8.content)

				arg_135_1.text_.text = var_138_9

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_10 = 54
				local var_138_11 = utf8.len(var_138_9)
				local var_138_12 = var_138_10 <= 0 and var_138_7 or var_138_7 * (var_138_11 / var_138_10)

				if var_138_12 > 0 and var_138_7 < var_138_12 then
					arg_135_1.talkMaxDuration = var_138_12

					if var_138_12 + var_138_6 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_12 + var_138_6
					end
				end

				arg_135_1.text_.text = var_138_9
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)
				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_13 = math.max(var_138_7, arg_135_1.talkMaxDuration)

			if var_138_6 <= arg_135_1.time_ and arg_135_1.time_ < var_138_6 + var_138_13 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_6) / var_138_13

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_6 + var_138_13 and arg_135_1.time_ < var_138_6 + var_138_13 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play116291033 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 116291033
		arg_139_1.duration_ = 6.4

		local var_139_0 = {
			zh = 6.4,
			ja = 4.733
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
				arg_139_0:Play116291034(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = arg_139_1.actors_["10024ui_story"]
			local var_142_1 = 0

			if var_142_1 < arg_139_1.time_ and arg_139_1.time_ <= var_142_1 + arg_142_0 and not isNil(var_142_0) and arg_139_1.var_.characterEffect10024ui_story == nil then
				arg_139_1.var_.characterEffect10024ui_story = var_142_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_2 = 0.2

			if var_142_1 <= arg_139_1.time_ and arg_139_1.time_ < var_142_1 + var_142_2 and not isNil(var_142_0) then
				local var_142_3 = (arg_139_1.time_ - var_142_1) / var_142_2

				if arg_139_1.var_.characterEffect10024ui_story and not isNil(var_142_0) then
					arg_139_1.var_.characterEffect10024ui_story.fillFlat = false
				end
			end

			if arg_139_1.time_ >= var_142_1 + var_142_2 and arg_139_1.time_ < var_142_1 + var_142_2 + arg_142_0 and not isNil(var_142_0) and arg_139_1.var_.characterEffect10024ui_story then
				arg_139_1.var_.characterEffect10024ui_story.fillFlat = false
			end

			local var_142_4 = 0

			if var_142_4 < arg_139_1.time_ and arg_139_1.time_ <= var_142_4 + arg_142_0 then
				arg_139_1:PlayTimeline("10024ui_story", "StoryTimeline/CharAction/story10024/story10024action/10024action1_1")
			end

			local var_142_5 = 0

			if var_142_5 < arg_139_1.time_ and arg_139_1.time_ <= var_142_5 + arg_142_0 then
				arg_139_1:PlayTimeline("10024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_142_6 = 0
			local var_142_7 = 0.5

			if var_142_6 < arg_139_1.time_ and arg_139_1.time_ <= var_142_6 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				local var_142_8 = arg_139_1:FormatText(StoryNameCfg[332].name)

				arg_139_1.leftNameTxt_.text = var_142_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_9 = arg_139_1:GetWordFromCfg(116291033)
				local var_142_10 = arg_139_1:FormatText(var_142_9.content)

				arg_139_1.text_.text = var_142_10

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_11 = 20
				local var_142_12 = utf8.len(var_142_10)
				local var_142_13 = var_142_11 <= 0 and var_142_7 or var_142_7 * (var_142_12 / var_142_11)

				if var_142_13 > 0 and var_142_7 < var_142_13 then
					arg_139_1.talkMaxDuration = var_142_13

					if var_142_13 + var_142_6 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_13 + var_142_6
					end
				end

				arg_139_1.text_.text = var_142_10
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116291", "116291033", "story_v_out_116291.awb") ~= 0 then
					local var_142_14 = manager.audio:GetVoiceLength("story_v_out_116291", "116291033", "story_v_out_116291.awb") / 1000

					if var_142_14 + var_142_6 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_14 + var_142_6
					end

					if var_142_9.prefab_name ~= "" and arg_139_1.actors_[var_142_9.prefab_name] ~= nil then
						local var_142_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_9.prefab_name].transform, "story_v_out_116291", "116291033", "story_v_out_116291.awb")

						arg_139_1:RecordAudio("116291033", var_142_15)
						arg_139_1:RecordAudio("116291033", var_142_15)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_116291", "116291033", "story_v_out_116291.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_116291", "116291033", "story_v_out_116291.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_16 = math.max(var_142_7, arg_139_1.talkMaxDuration)

			if var_142_6 <= arg_139_1.time_ and arg_139_1.time_ < var_142_6 + var_142_16 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_6) / var_142_16

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_6 + var_142_16 and arg_139_1.time_ < var_142_6 + var_142_16 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {}

		arg_139_1:InitPlayNodeList()
	end,
	Play116291034 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 116291034
		arg_143_1.duration_ = 13.87

		local var_143_0 = {
			zh = 8.133,
			ja = 13.866
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
				arg_143_0:Play116291035(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = arg_143_1.actors_["1028ui_story"]
			local var_146_1 = 0

			if var_146_1 < arg_143_1.time_ and arg_143_1.time_ <= var_146_1 + arg_146_0 and not isNil(var_146_0) and arg_143_1.var_.characterEffect1028ui_story == nil then
				arg_143_1.var_.characterEffect1028ui_story = var_146_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_2 = 0.2

			if var_146_1 <= arg_143_1.time_ and arg_143_1.time_ < var_146_1 + var_146_2 and not isNil(var_146_0) then
				local var_146_3 = (arg_143_1.time_ - var_146_1) / var_146_2

				if arg_143_1.var_.characterEffect1028ui_story and not isNil(var_146_0) then
					arg_143_1.var_.characterEffect1028ui_story.fillFlat = false
				end
			end

			if arg_143_1.time_ >= var_146_1 + var_146_2 and arg_143_1.time_ < var_146_1 + var_146_2 + arg_146_0 and not isNil(var_146_0) and arg_143_1.var_.characterEffect1028ui_story then
				arg_143_1.var_.characterEffect1028ui_story.fillFlat = false
			end

			local var_146_4 = arg_143_1.actors_["10024ui_story"]
			local var_146_5 = 0

			if var_146_5 < arg_143_1.time_ and arg_143_1.time_ <= var_146_5 + arg_146_0 and not isNil(var_146_4) and arg_143_1.var_.characterEffect10024ui_story == nil then
				arg_143_1.var_.characterEffect10024ui_story = var_146_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_6 = 0.2

			if var_146_5 <= arg_143_1.time_ and arg_143_1.time_ < var_146_5 + var_146_6 and not isNil(var_146_4) then
				local var_146_7 = (arg_143_1.time_ - var_146_5) / var_146_6

				if arg_143_1.var_.characterEffect10024ui_story and not isNil(var_146_4) then
					local var_146_8 = Mathf.Lerp(0, 0.5, var_146_7)

					arg_143_1.var_.characterEffect10024ui_story.fillFlat = true
					arg_143_1.var_.characterEffect10024ui_story.fillRatio = var_146_8
				end
			end

			if arg_143_1.time_ >= var_146_5 + var_146_6 and arg_143_1.time_ < var_146_5 + var_146_6 + arg_146_0 and not isNil(var_146_4) and arg_143_1.var_.characterEffect10024ui_story then
				local var_146_9 = 0.5

				arg_143_1.var_.characterEffect10024ui_story.fillFlat = true
				arg_143_1.var_.characterEffect10024ui_story.fillRatio = var_146_9
			end

			local var_146_10 = 0

			if var_146_10 < arg_143_1.time_ and arg_143_1.time_ <= var_146_10 + arg_146_0 then
				arg_143_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/story1028/story1028action/1028action7_2")
			end

			local var_146_11 = 0

			if var_146_11 < arg_143_1.time_ and arg_143_1.time_ <= var_146_11 + arg_146_0 then
				arg_143_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_146_12 = 0
			local var_146_13 = 0.8

			if var_146_12 < arg_143_1.time_ and arg_143_1.time_ <= var_146_12 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				local var_146_14 = arg_143_1:FormatText(StoryNameCfg[327].name)

				arg_143_1.leftNameTxt_.text = var_146_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_15 = arg_143_1:GetWordFromCfg(116291034)
				local var_146_16 = arg_143_1:FormatText(var_146_15.content)

				arg_143_1.text_.text = var_146_16

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_17 = 32
				local var_146_18 = utf8.len(var_146_16)
				local var_146_19 = var_146_17 <= 0 and var_146_13 or var_146_13 * (var_146_18 / var_146_17)

				if var_146_19 > 0 and var_146_13 < var_146_19 then
					arg_143_1.talkMaxDuration = var_146_19

					if var_146_19 + var_146_12 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_19 + var_146_12
					end
				end

				arg_143_1.text_.text = var_146_16
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116291", "116291034", "story_v_out_116291.awb") ~= 0 then
					local var_146_20 = manager.audio:GetVoiceLength("story_v_out_116291", "116291034", "story_v_out_116291.awb") / 1000

					if var_146_20 + var_146_12 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_20 + var_146_12
					end

					if var_146_15.prefab_name ~= "" and arg_143_1.actors_[var_146_15.prefab_name] ~= nil then
						local var_146_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_15.prefab_name].transform, "story_v_out_116291", "116291034", "story_v_out_116291.awb")

						arg_143_1:RecordAudio("116291034", var_146_21)
						arg_143_1:RecordAudio("116291034", var_146_21)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_116291", "116291034", "story_v_out_116291.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_116291", "116291034", "story_v_out_116291.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_22 = math.max(var_146_13, arg_143_1.talkMaxDuration)

			if var_146_12 <= arg_143_1.time_ and arg_143_1.time_ < var_146_12 + var_146_22 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_12) / var_146_22

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_12 + var_146_22 and arg_143_1.time_ < var_146_12 + var_146_22 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play116291035 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 116291035
		arg_147_1.duration_ = 6.57

		local var_147_0 = {
			zh = 4.133,
			ja = 6.566
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
				arg_147_0:Play116291036(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = arg_147_1.actors_["1148ui_story"].transform
			local var_150_1 = 0

			if var_150_1 < arg_147_1.time_ and arg_147_1.time_ <= var_150_1 + arg_150_0 then
				arg_147_1.var_.moveOldPos1148ui_story = var_150_0.localPosition
			end

			local var_150_2 = 0.001

			if var_150_1 <= arg_147_1.time_ and arg_147_1.time_ < var_150_1 + var_150_2 then
				local var_150_3 = (arg_147_1.time_ - var_150_1) / var_150_2
				local var_150_4 = Vector3.New(0.7, -0.8, -6.2)

				var_150_0.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos1148ui_story, var_150_4, var_150_3)

				local var_150_5 = manager.ui.mainCamera.transform.position - var_150_0.position

				var_150_0.forward = Vector3.New(var_150_5.x, var_150_5.y, var_150_5.z)

				local var_150_6 = var_150_0.localEulerAngles

				var_150_6.z = 0
				var_150_6.x = 0
				var_150_0.localEulerAngles = var_150_6
			end

			if arg_147_1.time_ >= var_150_1 + var_150_2 and arg_147_1.time_ < var_150_1 + var_150_2 + arg_150_0 then
				var_150_0.localPosition = Vector3.New(0.7, -0.8, -6.2)

				local var_150_7 = manager.ui.mainCamera.transform.position - var_150_0.position

				var_150_0.forward = Vector3.New(var_150_7.x, var_150_7.y, var_150_7.z)

				local var_150_8 = var_150_0.localEulerAngles

				var_150_8.z = 0
				var_150_8.x = 0
				var_150_0.localEulerAngles = var_150_8
			end

			local var_150_9 = arg_147_1.actors_["1028ui_story"]
			local var_150_10 = 0

			if var_150_10 < arg_147_1.time_ and arg_147_1.time_ <= var_150_10 + arg_150_0 and not isNil(var_150_9) and arg_147_1.var_.characterEffect1028ui_story == nil then
				arg_147_1.var_.characterEffect1028ui_story = var_150_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_11 = 0.2

			if var_150_10 <= arg_147_1.time_ and arg_147_1.time_ < var_150_10 + var_150_11 and not isNil(var_150_9) then
				local var_150_12 = (arg_147_1.time_ - var_150_10) / var_150_11

				if arg_147_1.var_.characterEffect1028ui_story and not isNil(var_150_9) then
					local var_150_13 = Mathf.Lerp(0, 0.5, var_150_12)

					arg_147_1.var_.characterEffect1028ui_story.fillFlat = true
					arg_147_1.var_.characterEffect1028ui_story.fillRatio = var_150_13
				end
			end

			if arg_147_1.time_ >= var_150_10 + var_150_11 and arg_147_1.time_ < var_150_10 + var_150_11 + arg_150_0 and not isNil(var_150_9) and arg_147_1.var_.characterEffect1028ui_story then
				local var_150_14 = 0.5

				arg_147_1.var_.characterEffect1028ui_story.fillFlat = true
				arg_147_1.var_.characterEffect1028ui_story.fillRatio = var_150_14
			end

			local var_150_15 = arg_147_1.actors_["1148ui_story"]
			local var_150_16 = 0

			if var_150_16 < arg_147_1.time_ and arg_147_1.time_ <= var_150_16 + arg_150_0 and not isNil(var_150_15) and arg_147_1.var_.characterEffect1148ui_story == nil then
				arg_147_1.var_.characterEffect1148ui_story = var_150_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_17 = 0.2

			if var_150_16 <= arg_147_1.time_ and arg_147_1.time_ < var_150_16 + var_150_17 and not isNil(var_150_15) then
				local var_150_18 = (arg_147_1.time_ - var_150_16) / var_150_17

				if arg_147_1.var_.characterEffect1148ui_story and not isNil(var_150_15) then
					arg_147_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_147_1.time_ >= var_150_16 + var_150_17 and arg_147_1.time_ < var_150_16 + var_150_17 + arg_150_0 and not isNil(var_150_15) and arg_147_1.var_.characterEffect1148ui_story then
				arg_147_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_150_19 = 0

			if var_150_19 < arg_147_1.time_ and arg_147_1.time_ <= var_150_19 + arg_150_0 then
				arg_147_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action1_1")
			end

			local var_150_20 = 0

			if var_150_20 < arg_147_1.time_ and arg_147_1.time_ <= var_150_20 + arg_150_0 then
				arg_147_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_150_21 = arg_147_1.actors_["10024ui_story"].transform
			local var_150_22 = 0

			if var_150_22 < arg_147_1.time_ and arg_147_1.time_ <= var_150_22 + arg_150_0 then
				arg_147_1.var_.moveOldPos10024ui_story = var_150_21.localPosition
			end

			local var_150_23 = 0.001

			if var_150_22 <= arg_147_1.time_ and arg_147_1.time_ < var_150_22 + var_150_23 then
				local var_150_24 = (arg_147_1.time_ - var_150_22) / var_150_23
				local var_150_25 = Vector3.New(0, 100, 0)

				var_150_21.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos10024ui_story, var_150_25, var_150_24)

				local var_150_26 = manager.ui.mainCamera.transform.position - var_150_21.position

				var_150_21.forward = Vector3.New(var_150_26.x, var_150_26.y, var_150_26.z)

				local var_150_27 = var_150_21.localEulerAngles

				var_150_27.z = 0
				var_150_27.x = 0
				var_150_21.localEulerAngles = var_150_27
			end

			if arg_147_1.time_ >= var_150_22 + var_150_23 and arg_147_1.time_ < var_150_22 + var_150_23 + arg_150_0 then
				var_150_21.localPosition = Vector3.New(0, 100, 0)

				local var_150_28 = manager.ui.mainCamera.transform.position - var_150_21.position

				var_150_21.forward = Vector3.New(var_150_28.x, var_150_28.y, var_150_28.z)

				local var_150_29 = var_150_21.localEulerAngles

				var_150_29.z = 0
				var_150_29.x = 0
				var_150_21.localEulerAngles = var_150_29
			end

			local var_150_30 = 0
			local var_150_31 = 0.55

			if var_150_30 < arg_147_1.time_ and arg_147_1.time_ <= var_150_30 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				local var_150_32 = arg_147_1:FormatText(StoryNameCfg[8].name)

				arg_147_1.leftNameTxt_.text = var_150_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_33 = arg_147_1:GetWordFromCfg(116291035)
				local var_150_34 = arg_147_1:FormatText(var_150_33.content)

				arg_147_1.text_.text = var_150_34

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_35 = 22
				local var_150_36 = utf8.len(var_150_34)
				local var_150_37 = var_150_35 <= 0 and var_150_31 or var_150_31 * (var_150_36 / var_150_35)

				if var_150_37 > 0 and var_150_31 < var_150_37 then
					arg_147_1.talkMaxDuration = var_150_37

					if var_150_37 + var_150_30 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_37 + var_150_30
					end
				end

				arg_147_1.text_.text = var_150_34
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116291", "116291035", "story_v_out_116291.awb") ~= 0 then
					local var_150_38 = manager.audio:GetVoiceLength("story_v_out_116291", "116291035", "story_v_out_116291.awb") / 1000

					if var_150_38 + var_150_30 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_38 + var_150_30
					end

					if var_150_33.prefab_name ~= "" and arg_147_1.actors_[var_150_33.prefab_name] ~= nil then
						local var_150_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_33.prefab_name].transform, "story_v_out_116291", "116291035", "story_v_out_116291.awb")

						arg_147_1:RecordAudio("116291035", var_150_39)
						arg_147_1:RecordAudio("116291035", var_150_39)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_116291", "116291035", "story_v_out_116291.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_116291", "116291035", "story_v_out_116291.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_40 = math.max(var_150_31, arg_147_1.talkMaxDuration)

			if var_150_30 <= arg_147_1.time_ and arg_147_1.time_ < var_150_30 + var_150_40 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_30) / var_150_40

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_30 + var_150_40 and arg_147_1.time_ < var_150_30 + var_150_40 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_147_1:InitPlayNodeList()
	end,
	Play116291036 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 116291036
		arg_151_1.duration_ = 4.13

		local var_151_0 = {
			zh = 4.133,
			ja = 3.2
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
				arg_151_0:Play116291037(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = arg_151_1.actors_["1028ui_story"]
			local var_154_1 = 0

			if var_154_1 < arg_151_1.time_ and arg_151_1.time_ <= var_154_1 + arg_154_0 and not isNil(var_154_0) and arg_151_1.var_.characterEffect1028ui_story == nil then
				arg_151_1.var_.characterEffect1028ui_story = var_154_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_2 = 0.2

			if var_154_1 <= arg_151_1.time_ and arg_151_1.time_ < var_154_1 + var_154_2 and not isNil(var_154_0) then
				local var_154_3 = (arg_151_1.time_ - var_154_1) / var_154_2

				if arg_151_1.var_.characterEffect1028ui_story and not isNil(var_154_0) then
					arg_151_1.var_.characterEffect1028ui_story.fillFlat = false
				end
			end

			if arg_151_1.time_ >= var_154_1 + var_154_2 and arg_151_1.time_ < var_154_1 + var_154_2 + arg_154_0 and not isNil(var_154_0) and arg_151_1.var_.characterEffect1028ui_story then
				arg_151_1.var_.characterEffect1028ui_story.fillFlat = false
			end

			local var_154_4 = arg_151_1.actors_["1148ui_story"]
			local var_154_5 = 0

			if var_154_5 < arg_151_1.time_ and arg_151_1.time_ <= var_154_5 + arg_154_0 and not isNil(var_154_4) and arg_151_1.var_.characterEffect1148ui_story == nil then
				arg_151_1.var_.characterEffect1148ui_story = var_154_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_6 = 0.2

			if var_154_5 <= arg_151_1.time_ and arg_151_1.time_ < var_154_5 + var_154_6 and not isNil(var_154_4) then
				local var_154_7 = (arg_151_1.time_ - var_154_5) / var_154_6

				if arg_151_1.var_.characterEffect1148ui_story and not isNil(var_154_4) then
					local var_154_8 = Mathf.Lerp(0, 0.5, var_154_7)

					arg_151_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_151_1.var_.characterEffect1148ui_story.fillRatio = var_154_8
				end
			end

			if arg_151_1.time_ >= var_154_5 + var_154_6 and arg_151_1.time_ < var_154_5 + var_154_6 + arg_154_0 and not isNil(var_154_4) and arg_151_1.var_.characterEffect1148ui_story then
				local var_154_9 = 0.5

				arg_151_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_151_1.var_.characterEffect1148ui_story.fillRatio = var_154_9
			end

			local var_154_10 = 0

			if var_154_10 < arg_151_1.time_ and arg_151_1.time_ <= var_154_10 + arg_154_0 then
				arg_151_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_154_11 = 0
			local var_154_12 = 0.125

			if var_154_11 < arg_151_1.time_ and arg_151_1.time_ <= var_154_11 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				local var_154_13 = arg_151_1:FormatText(StoryNameCfg[327].name)

				arg_151_1.leftNameTxt_.text = var_154_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_14 = arg_151_1:GetWordFromCfg(116291036)
				local var_154_15 = arg_151_1:FormatText(var_154_14.content)

				arg_151_1.text_.text = var_154_15

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_16 = 5
				local var_154_17 = utf8.len(var_154_15)
				local var_154_18 = var_154_16 <= 0 and var_154_12 or var_154_12 * (var_154_17 / var_154_16)

				if var_154_18 > 0 and var_154_12 < var_154_18 then
					arg_151_1.talkMaxDuration = var_154_18

					if var_154_18 + var_154_11 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_18 + var_154_11
					end
				end

				arg_151_1.text_.text = var_154_15
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116291", "116291036", "story_v_out_116291.awb") ~= 0 then
					local var_154_19 = manager.audio:GetVoiceLength("story_v_out_116291", "116291036", "story_v_out_116291.awb") / 1000

					if var_154_19 + var_154_11 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_19 + var_154_11
					end

					if var_154_14.prefab_name ~= "" and arg_151_1.actors_[var_154_14.prefab_name] ~= nil then
						local var_154_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_14.prefab_name].transform, "story_v_out_116291", "116291036", "story_v_out_116291.awb")

						arg_151_1:RecordAudio("116291036", var_154_20)
						arg_151_1:RecordAudio("116291036", var_154_20)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_116291", "116291036", "story_v_out_116291.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_116291", "116291036", "story_v_out_116291.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_21 = math.max(var_154_12, arg_151_1.talkMaxDuration)

			if var_154_11 <= arg_151_1.time_ and arg_151_1.time_ < var_154_11 + var_154_21 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_11) / var_154_21

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_11 + var_154_21 and arg_151_1.time_ < var_154_11 + var_154_21 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play116291037 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 116291037
		arg_155_1.duration_ = 5

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play116291038(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = arg_155_1.actors_["1148ui_story"].transform
			local var_158_1 = 0

			if var_158_1 < arg_155_1.time_ and arg_155_1.time_ <= var_158_1 + arg_158_0 then
				arg_155_1.var_.moveOldPos1148ui_story = var_158_0.localPosition
			end

			local var_158_2 = 0.001

			if var_158_1 <= arg_155_1.time_ and arg_155_1.time_ < var_158_1 + var_158_2 then
				local var_158_3 = (arg_155_1.time_ - var_158_1) / var_158_2
				local var_158_4 = Vector3.New(0, 100, 0)

				var_158_0.localPosition = Vector3.Lerp(arg_155_1.var_.moveOldPos1148ui_story, var_158_4, var_158_3)

				local var_158_5 = manager.ui.mainCamera.transform.position - var_158_0.position

				var_158_0.forward = Vector3.New(var_158_5.x, var_158_5.y, var_158_5.z)

				local var_158_6 = var_158_0.localEulerAngles

				var_158_6.z = 0
				var_158_6.x = 0
				var_158_0.localEulerAngles = var_158_6
			end

			if arg_155_1.time_ >= var_158_1 + var_158_2 and arg_155_1.time_ < var_158_1 + var_158_2 + arg_158_0 then
				var_158_0.localPosition = Vector3.New(0, 100, 0)

				local var_158_7 = manager.ui.mainCamera.transform.position - var_158_0.position

				var_158_0.forward = Vector3.New(var_158_7.x, var_158_7.y, var_158_7.z)

				local var_158_8 = var_158_0.localEulerAngles

				var_158_8.z = 0
				var_158_8.x = 0
				var_158_0.localEulerAngles = var_158_8
			end

			local var_158_9 = arg_155_1.actors_["1028ui_story"].transform
			local var_158_10 = 0

			if var_158_10 < arg_155_1.time_ and arg_155_1.time_ <= var_158_10 + arg_158_0 then
				arg_155_1.var_.moveOldPos1028ui_story = var_158_9.localPosition
			end

			local var_158_11 = 0.001

			if var_158_10 <= arg_155_1.time_ and arg_155_1.time_ < var_158_10 + var_158_11 then
				local var_158_12 = (arg_155_1.time_ - var_158_10) / var_158_11
				local var_158_13 = Vector3.New(0, 100, 0)

				var_158_9.localPosition = Vector3.Lerp(arg_155_1.var_.moveOldPos1028ui_story, var_158_13, var_158_12)

				local var_158_14 = manager.ui.mainCamera.transform.position - var_158_9.position

				var_158_9.forward = Vector3.New(var_158_14.x, var_158_14.y, var_158_14.z)

				local var_158_15 = var_158_9.localEulerAngles

				var_158_15.z = 0
				var_158_15.x = 0
				var_158_9.localEulerAngles = var_158_15
			end

			if arg_155_1.time_ >= var_158_10 + var_158_11 and arg_155_1.time_ < var_158_10 + var_158_11 + arg_158_0 then
				var_158_9.localPosition = Vector3.New(0, 100, 0)

				local var_158_16 = manager.ui.mainCamera.transform.position - var_158_9.position

				var_158_9.forward = Vector3.New(var_158_16.x, var_158_16.y, var_158_16.z)

				local var_158_17 = var_158_9.localEulerAngles

				var_158_17.z = 0
				var_158_17.x = 0
				var_158_9.localEulerAngles = var_158_17
			end

			local var_158_18 = 0
			local var_158_19 = 0.6

			if var_158_18 < arg_155_1.time_ and arg_155_1.time_ <= var_158_18 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, false)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_20 = arg_155_1:GetWordFromCfg(116291037)
				local var_158_21 = arg_155_1:FormatText(var_158_20.content)

				arg_155_1.text_.text = var_158_21

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_22 = 24
				local var_158_23 = utf8.len(var_158_21)
				local var_158_24 = var_158_22 <= 0 and var_158_19 or var_158_19 * (var_158_23 / var_158_22)

				if var_158_24 > 0 and var_158_19 < var_158_24 then
					arg_155_1.talkMaxDuration = var_158_24

					if var_158_24 + var_158_18 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_24 + var_158_18
					end
				end

				arg_155_1.text_.text = var_158_21
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)
				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_25 = math.max(var_158_19, arg_155_1.talkMaxDuration)

			if var_158_18 <= arg_155_1.time_ and arg_155_1.time_ < var_158_18 + var_158_25 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_18) / var_158_25

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_18 + var_158_25 and arg_155_1.time_ < var_158_18 + var_158_25 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1028ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_155_1:InitPlayNodeList()
	end,
	Play116291038 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 116291038
		arg_159_1.duration_ = 5.7

		local var_159_0 = {
			zh = 2.433,
			ja = 5.7
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
				arg_159_0:Play116291039(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = arg_159_1.actors_["1028ui_story"].transform
			local var_162_1 = 0

			if var_162_1 < arg_159_1.time_ and arg_159_1.time_ <= var_162_1 + arg_162_0 then
				arg_159_1.var_.moveOldPos1028ui_story = var_162_0.localPosition
			end

			local var_162_2 = 0.001

			if var_162_1 <= arg_159_1.time_ and arg_159_1.time_ < var_162_1 + var_162_2 then
				local var_162_3 = (arg_159_1.time_ - var_162_1) / var_162_2
				local var_162_4 = Vector3.New(0, -0.9, -5.9)

				var_162_0.localPosition = Vector3.Lerp(arg_159_1.var_.moveOldPos1028ui_story, var_162_4, var_162_3)

				local var_162_5 = manager.ui.mainCamera.transform.position - var_162_0.position

				var_162_0.forward = Vector3.New(var_162_5.x, var_162_5.y, var_162_5.z)

				local var_162_6 = var_162_0.localEulerAngles

				var_162_6.z = 0
				var_162_6.x = 0
				var_162_0.localEulerAngles = var_162_6
			end

			if arg_159_1.time_ >= var_162_1 + var_162_2 and arg_159_1.time_ < var_162_1 + var_162_2 + arg_162_0 then
				var_162_0.localPosition = Vector3.New(0, -0.9, -5.9)

				local var_162_7 = manager.ui.mainCamera.transform.position - var_162_0.position

				var_162_0.forward = Vector3.New(var_162_7.x, var_162_7.y, var_162_7.z)

				local var_162_8 = var_162_0.localEulerAngles

				var_162_8.z = 0
				var_162_8.x = 0
				var_162_0.localEulerAngles = var_162_8
			end

			local var_162_9 = arg_159_1.actors_["1028ui_story"]
			local var_162_10 = 0

			if var_162_10 < arg_159_1.time_ and arg_159_1.time_ <= var_162_10 + arg_162_0 and not isNil(var_162_9) and arg_159_1.var_.characterEffect1028ui_story == nil then
				arg_159_1.var_.characterEffect1028ui_story = var_162_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_11 = 0.2

			if var_162_10 <= arg_159_1.time_ and arg_159_1.time_ < var_162_10 + var_162_11 and not isNil(var_162_9) then
				local var_162_12 = (arg_159_1.time_ - var_162_10) / var_162_11

				if arg_159_1.var_.characterEffect1028ui_story and not isNil(var_162_9) then
					arg_159_1.var_.characterEffect1028ui_story.fillFlat = false
				end
			end

			if arg_159_1.time_ >= var_162_10 + var_162_11 and arg_159_1.time_ < var_162_10 + var_162_11 + arg_162_0 and not isNil(var_162_9) and arg_159_1.var_.characterEffect1028ui_story then
				arg_159_1.var_.characterEffect1028ui_story.fillFlat = false
			end

			local var_162_13 = 0

			if var_162_13 < arg_159_1.time_ and arg_159_1.time_ <= var_162_13 + arg_162_0 then
				arg_159_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/story1028/story1028action/1028action6_1")
			end

			local var_162_14 = 0

			if var_162_14 < arg_159_1.time_ and arg_159_1.time_ <= var_162_14 + arg_162_0 then
				arg_159_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_162_15 = 0
			local var_162_16 = 0.3

			if var_162_15 < arg_159_1.time_ and arg_159_1.time_ <= var_162_15 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				local var_162_17 = arg_159_1:FormatText(StoryNameCfg[327].name)

				arg_159_1.leftNameTxt_.text = var_162_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_18 = arg_159_1:GetWordFromCfg(116291038)
				local var_162_19 = arg_159_1:FormatText(var_162_18.content)

				arg_159_1.text_.text = var_162_19

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_20 = 12
				local var_162_21 = utf8.len(var_162_19)
				local var_162_22 = var_162_20 <= 0 and var_162_16 or var_162_16 * (var_162_21 / var_162_20)

				if var_162_22 > 0 and var_162_16 < var_162_22 then
					arg_159_1.talkMaxDuration = var_162_22

					if var_162_22 + var_162_15 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_22 + var_162_15
					end
				end

				arg_159_1.text_.text = var_162_19
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116291", "116291038", "story_v_out_116291.awb") ~= 0 then
					local var_162_23 = manager.audio:GetVoiceLength("story_v_out_116291", "116291038", "story_v_out_116291.awb") / 1000

					if var_162_23 + var_162_15 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_23 + var_162_15
					end

					if var_162_18.prefab_name ~= "" and arg_159_1.actors_[var_162_18.prefab_name] ~= nil then
						local var_162_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_18.prefab_name].transform, "story_v_out_116291", "116291038", "story_v_out_116291.awb")

						arg_159_1:RecordAudio("116291038", var_162_24)
						arg_159_1:RecordAudio("116291038", var_162_24)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_116291", "116291038", "story_v_out_116291.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_116291", "116291038", "story_v_out_116291.awb")
				end

				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_25 = math.max(var_162_16, arg_159_1.talkMaxDuration)

			if var_162_15 <= arg_159_1.time_ and arg_159_1.time_ < var_162_15 + var_162_25 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_15) / var_162_25

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_15 + var_162_25 and arg_159_1.time_ < var_162_15 + var_162_25 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_159_1:InitPlayNodeList()
	end,
	Play116291039 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 116291039
		arg_163_1.duration_ = 6.1

		local var_163_0 = {
			zh = 4.366,
			ja = 6.1
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
				arg_163_0:Play116291040(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = arg_163_1.actors_["1028ui_story"].transform
			local var_166_1 = 0

			if var_166_1 < arg_163_1.time_ and arg_163_1.time_ <= var_166_1 + arg_166_0 then
				arg_163_1.var_.moveOldPos1028ui_story = var_166_0.localPosition
			end

			local var_166_2 = 0.001

			if var_166_1 <= arg_163_1.time_ and arg_163_1.time_ < var_166_1 + var_166_2 then
				local var_166_3 = (arg_163_1.time_ - var_166_1) / var_166_2
				local var_166_4 = Vector3.New(0, 100, 0)

				var_166_0.localPosition = Vector3.Lerp(arg_163_1.var_.moveOldPos1028ui_story, var_166_4, var_166_3)

				local var_166_5 = manager.ui.mainCamera.transform.position - var_166_0.position

				var_166_0.forward = Vector3.New(var_166_5.x, var_166_5.y, var_166_5.z)

				local var_166_6 = var_166_0.localEulerAngles

				var_166_6.z = 0
				var_166_6.x = 0
				var_166_0.localEulerAngles = var_166_6
			end

			if arg_163_1.time_ >= var_166_1 + var_166_2 and arg_163_1.time_ < var_166_1 + var_166_2 + arg_166_0 then
				var_166_0.localPosition = Vector3.New(0, 100, 0)

				local var_166_7 = manager.ui.mainCamera.transform.position - var_166_0.position

				var_166_0.forward = Vector3.New(var_166_7.x, var_166_7.y, var_166_7.z)

				local var_166_8 = var_166_0.localEulerAngles

				var_166_8.z = 0
				var_166_8.x = 0
				var_166_0.localEulerAngles = var_166_8
			end

			local var_166_9 = arg_163_1.actors_["1059ui_story"].transform
			local var_166_10 = 0

			if var_166_10 < arg_163_1.time_ and arg_163_1.time_ <= var_166_10 + arg_166_0 then
				arg_163_1.var_.moveOldPos1059ui_story = var_166_9.localPosition
			end

			local var_166_11 = 0.001

			if var_166_10 <= arg_163_1.time_ and arg_163_1.time_ < var_166_10 + var_166_11 then
				local var_166_12 = (arg_163_1.time_ - var_166_10) / var_166_11
				local var_166_13 = Vector3.New(0.7, -1.05, -6)

				var_166_9.localPosition = Vector3.Lerp(arg_163_1.var_.moveOldPos1059ui_story, var_166_13, var_166_12)

				local var_166_14 = manager.ui.mainCamera.transform.position - var_166_9.position

				var_166_9.forward = Vector3.New(var_166_14.x, var_166_14.y, var_166_14.z)

				local var_166_15 = var_166_9.localEulerAngles

				var_166_15.z = 0
				var_166_15.x = 0
				var_166_9.localEulerAngles = var_166_15
			end

			if arg_163_1.time_ >= var_166_10 + var_166_11 and arg_163_1.time_ < var_166_10 + var_166_11 + arg_166_0 then
				var_166_9.localPosition = Vector3.New(0.7, -1.05, -6)

				local var_166_16 = manager.ui.mainCamera.transform.position - var_166_9.position

				var_166_9.forward = Vector3.New(var_166_16.x, var_166_16.y, var_166_16.z)

				local var_166_17 = var_166_9.localEulerAngles

				var_166_17.z = 0
				var_166_17.x = 0
				var_166_9.localEulerAngles = var_166_17
			end

			local var_166_18 = arg_163_1.actors_["1148ui_story"].transform
			local var_166_19 = 0

			if var_166_19 < arg_163_1.time_ and arg_163_1.time_ <= var_166_19 + arg_166_0 then
				arg_163_1.var_.moveOldPos1148ui_story = var_166_18.localPosition
			end

			local var_166_20 = 0.001

			if var_166_19 <= arg_163_1.time_ and arg_163_1.time_ < var_166_19 + var_166_20 then
				local var_166_21 = (arg_163_1.time_ - var_166_19) / var_166_20
				local var_166_22 = Vector3.New(-0.7, -0.8, -6.2)

				var_166_18.localPosition = Vector3.Lerp(arg_163_1.var_.moveOldPos1148ui_story, var_166_22, var_166_21)

				local var_166_23 = manager.ui.mainCamera.transform.position - var_166_18.position

				var_166_18.forward = Vector3.New(var_166_23.x, var_166_23.y, var_166_23.z)

				local var_166_24 = var_166_18.localEulerAngles

				var_166_24.z = 0
				var_166_24.x = 0
				var_166_18.localEulerAngles = var_166_24
			end

			if arg_163_1.time_ >= var_166_19 + var_166_20 and arg_163_1.time_ < var_166_19 + var_166_20 + arg_166_0 then
				var_166_18.localPosition = Vector3.New(-0.7, -0.8, -6.2)

				local var_166_25 = manager.ui.mainCamera.transform.position - var_166_18.position

				var_166_18.forward = Vector3.New(var_166_25.x, var_166_25.y, var_166_25.z)

				local var_166_26 = var_166_18.localEulerAngles

				var_166_26.z = 0
				var_166_26.x = 0
				var_166_18.localEulerAngles = var_166_26
			end

			local var_166_27 = arg_163_1.actors_["1059ui_story"]
			local var_166_28 = 0

			if var_166_28 < arg_163_1.time_ and arg_163_1.time_ <= var_166_28 + arg_166_0 and not isNil(var_166_27) and arg_163_1.var_.characterEffect1059ui_story == nil then
				arg_163_1.var_.characterEffect1059ui_story = var_166_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_29 = 0.2

			if var_166_28 <= arg_163_1.time_ and arg_163_1.time_ < var_166_28 + var_166_29 and not isNil(var_166_27) then
				local var_166_30 = (arg_163_1.time_ - var_166_28) / var_166_29

				if arg_163_1.var_.characterEffect1059ui_story and not isNil(var_166_27) then
					arg_163_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_163_1.time_ >= var_166_28 + var_166_29 and arg_163_1.time_ < var_166_28 + var_166_29 + arg_166_0 and not isNil(var_166_27) and arg_163_1.var_.characterEffect1059ui_story then
				arg_163_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_166_31 = arg_163_1.actors_["1148ui_story"]
			local var_166_32 = 0

			if var_166_32 < arg_163_1.time_ and arg_163_1.time_ <= var_166_32 + arg_166_0 and not isNil(var_166_31) and arg_163_1.var_.characterEffect1148ui_story == nil then
				arg_163_1.var_.characterEffect1148ui_story = var_166_31:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_33 = 0.034

			if var_166_32 <= arg_163_1.time_ and arg_163_1.time_ < var_166_32 + var_166_33 and not isNil(var_166_31) then
				local var_166_34 = (arg_163_1.time_ - var_166_32) / var_166_33

				if arg_163_1.var_.characterEffect1148ui_story and not isNil(var_166_31) then
					local var_166_35 = Mathf.Lerp(0, 0.5, var_166_34)

					arg_163_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_163_1.var_.characterEffect1148ui_story.fillRatio = var_166_35
				end
			end

			if arg_163_1.time_ >= var_166_32 + var_166_33 and arg_163_1.time_ < var_166_32 + var_166_33 + arg_166_0 and not isNil(var_166_31) and arg_163_1.var_.characterEffect1148ui_story then
				local var_166_36 = 0.5

				arg_163_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_163_1.var_.characterEffect1148ui_story.fillRatio = var_166_36
			end

			local var_166_37 = 0

			if var_166_37 < arg_163_1.time_ and arg_163_1.time_ <= var_166_37 + arg_166_0 then
				arg_163_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action5_1")
			end

			local var_166_38 = 0

			if var_166_38 < arg_163_1.time_ and arg_163_1.time_ <= var_166_38 + arg_166_0 then
				arg_163_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_166_39 = 0

			if var_166_39 < arg_163_1.time_ and arg_163_1.time_ <= var_166_39 + arg_166_0 then
				arg_163_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action1_1")
			end

			local var_166_40 = 0
			local var_166_41 = 0.525

			if var_166_40 < arg_163_1.time_ and arg_163_1.time_ <= var_166_40 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				local var_166_42 = arg_163_1:FormatText(StoryNameCfg[28].name)

				arg_163_1.leftNameTxt_.text = var_166_42

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_43 = arg_163_1:GetWordFromCfg(116291039)
				local var_166_44 = arg_163_1:FormatText(var_166_43.content)

				arg_163_1.text_.text = var_166_44

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_45 = 21
				local var_166_46 = utf8.len(var_166_44)
				local var_166_47 = var_166_45 <= 0 and var_166_41 or var_166_41 * (var_166_46 / var_166_45)

				if var_166_47 > 0 and var_166_41 < var_166_47 then
					arg_163_1.talkMaxDuration = var_166_47

					if var_166_47 + var_166_40 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_47 + var_166_40
					end
				end

				arg_163_1.text_.text = var_166_44
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116291", "116291039", "story_v_out_116291.awb") ~= 0 then
					local var_166_48 = manager.audio:GetVoiceLength("story_v_out_116291", "116291039", "story_v_out_116291.awb") / 1000

					if var_166_48 + var_166_40 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_48 + var_166_40
					end

					if var_166_43.prefab_name ~= "" and arg_163_1.actors_[var_166_43.prefab_name] ~= nil then
						local var_166_49 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_43.prefab_name].transform, "story_v_out_116291", "116291039", "story_v_out_116291.awb")

						arg_163_1:RecordAudio("116291039", var_166_49)
						arg_163_1:RecordAudio("116291039", var_166_49)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_116291", "116291039", "story_v_out_116291.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_116291", "116291039", "story_v_out_116291.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_50 = math.max(var_166_41, arg_163_1.talkMaxDuration)

			if var_166_40 <= arg_163_1.time_ and arg_163_1.time_ < var_166_40 + var_166_50 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_40) / var_166_50

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_40 + var_166_50 and arg_163_1.time_ < var_166_40 + var_166_50 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_163_1:InitPlayNodeList()
	end,
	Play116291040 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 116291040
		arg_167_1.duration_ = 3.5

		local var_167_0 = {
			zh = 2.466,
			ja = 3.5
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
				arg_167_0:Play116291041(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = arg_167_1.actors_["1059ui_story"]
			local var_170_1 = 0

			if var_170_1 < arg_167_1.time_ and arg_167_1.time_ <= var_170_1 + arg_170_0 and not isNil(var_170_0) and arg_167_1.var_.characterEffect1059ui_story == nil then
				arg_167_1.var_.characterEffect1059ui_story = var_170_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_170_2 = 0.2

			if var_170_1 <= arg_167_1.time_ and arg_167_1.time_ < var_170_1 + var_170_2 and not isNil(var_170_0) then
				local var_170_3 = (arg_167_1.time_ - var_170_1) / var_170_2

				if arg_167_1.var_.characterEffect1059ui_story and not isNil(var_170_0) then
					local var_170_4 = Mathf.Lerp(0, 0.5, var_170_3)

					arg_167_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_167_1.var_.characterEffect1059ui_story.fillRatio = var_170_4
				end
			end

			if arg_167_1.time_ >= var_170_1 + var_170_2 and arg_167_1.time_ < var_170_1 + var_170_2 + arg_170_0 and not isNil(var_170_0) and arg_167_1.var_.characterEffect1059ui_story then
				local var_170_5 = 0.5

				arg_167_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_167_1.var_.characterEffect1059ui_story.fillRatio = var_170_5
			end

			local var_170_6 = arg_167_1.actors_["1148ui_story"]
			local var_170_7 = 0

			if var_170_7 < arg_167_1.time_ and arg_167_1.time_ <= var_170_7 + arg_170_0 and not isNil(var_170_6) and arg_167_1.var_.characterEffect1148ui_story == nil then
				arg_167_1.var_.characterEffect1148ui_story = var_170_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_170_8 = 0.2

			if var_170_7 <= arg_167_1.time_ and arg_167_1.time_ < var_170_7 + var_170_8 and not isNil(var_170_6) then
				local var_170_9 = (arg_167_1.time_ - var_170_7) / var_170_8

				if arg_167_1.var_.characterEffect1148ui_story and not isNil(var_170_6) then
					arg_167_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_167_1.time_ >= var_170_7 + var_170_8 and arg_167_1.time_ < var_170_7 + var_170_8 + arg_170_0 and not isNil(var_170_6) and arg_167_1.var_.characterEffect1148ui_story then
				arg_167_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_170_10 = 0

			if var_170_10 < arg_167_1.time_ and arg_167_1.time_ <= var_170_10 + arg_170_0 then
				arg_167_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1048/story1048action/1048action2_1")
			end

			local var_170_11 = 0

			if var_170_11 < arg_167_1.time_ and arg_167_1.time_ <= var_170_11 + arg_170_0 then
				arg_167_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_170_12 = 0
			local var_170_13 = 0.3

			if var_170_12 < arg_167_1.time_ and arg_167_1.time_ <= var_170_12 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				local var_170_14 = arg_167_1:FormatText(StoryNameCfg[8].name)

				arg_167_1.leftNameTxt_.text = var_170_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_15 = arg_167_1:GetWordFromCfg(116291040)
				local var_170_16 = arg_167_1:FormatText(var_170_15.content)

				arg_167_1.text_.text = var_170_16

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_17 = 12
				local var_170_18 = utf8.len(var_170_16)
				local var_170_19 = var_170_17 <= 0 and var_170_13 or var_170_13 * (var_170_18 / var_170_17)

				if var_170_19 > 0 and var_170_13 < var_170_19 then
					arg_167_1.talkMaxDuration = var_170_19

					if var_170_19 + var_170_12 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_19 + var_170_12
					end
				end

				arg_167_1.text_.text = var_170_16
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116291", "116291040", "story_v_out_116291.awb") ~= 0 then
					local var_170_20 = manager.audio:GetVoiceLength("story_v_out_116291", "116291040", "story_v_out_116291.awb") / 1000

					if var_170_20 + var_170_12 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_20 + var_170_12
					end

					if var_170_15.prefab_name ~= "" and arg_167_1.actors_[var_170_15.prefab_name] ~= nil then
						local var_170_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_15.prefab_name].transform, "story_v_out_116291", "116291040", "story_v_out_116291.awb")

						arg_167_1:RecordAudio("116291040", var_170_21)
						arg_167_1:RecordAudio("116291040", var_170_21)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_116291", "116291040", "story_v_out_116291.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_116291", "116291040", "story_v_out_116291.awb")
				end

				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_22 = math.max(var_170_13, arg_167_1.talkMaxDuration)

			if var_170_12 <= arg_167_1.time_ and arg_167_1.time_ < var_170_12 + var_170_22 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_12) / var_170_22

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_12 + var_170_22 and arg_167_1.time_ < var_170_12 + var_170_22 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	Play116291041 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 116291041
		arg_171_1.duration_ = 5.33

		local var_171_0 = {
			zh = 4.733,
			ja = 5.333
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
				arg_171_0:Play116291042(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = arg_171_1.actors_["1059ui_story"]
			local var_174_1 = 0

			if var_174_1 < arg_171_1.time_ and arg_171_1.time_ <= var_174_1 + arg_174_0 and not isNil(var_174_0) and arg_171_1.var_.characterEffect1059ui_story == nil then
				arg_171_1.var_.characterEffect1059ui_story = var_174_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_2 = 0.2

			if var_174_1 <= arg_171_1.time_ and arg_171_1.time_ < var_174_1 + var_174_2 and not isNil(var_174_0) then
				local var_174_3 = (arg_171_1.time_ - var_174_1) / var_174_2

				if arg_171_1.var_.characterEffect1059ui_story and not isNil(var_174_0) then
					arg_171_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_171_1.time_ >= var_174_1 + var_174_2 and arg_171_1.time_ < var_174_1 + var_174_2 + arg_174_0 and not isNil(var_174_0) and arg_171_1.var_.characterEffect1059ui_story then
				arg_171_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_174_4 = arg_171_1.actors_["1148ui_story"]
			local var_174_5 = 0

			if var_174_5 < arg_171_1.time_ and arg_171_1.time_ <= var_174_5 + arg_174_0 and not isNil(var_174_4) and arg_171_1.var_.characterEffect1148ui_story == nil then
				arg_171_1.var_.characterEffect1148ui_story = var_174_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_6 = 0.2

			if var_174_5 <= arg_171_1.time_ and arg_171_1.time_ < var_174_5 + var_174_6 and not isNil(var_174_4) then
				local var_174_7 = (arg_171_1.time_ - var_174_5) / var_174_6

				if arg_171_1.var_.characterEffect1148ui_story and not isNil(var_174_4) then
					local var_174_8 = Mathf.Lerp(0, 0.5, var_174_7)

					arg_171_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_171_1.var_.characterEffect1148ui_story.fillRatio = var_174_8
				end
			end

			if arg_171_1.time_ >= var_174_5 + var_174_6 and arg_171_1.time_ < var_174_5 + var_174_6 + arg_174_0 and not isNil(var_174_4) and arg_171_1.var_.characterEffect1148ui_story then
				local var_174_9 = 0.5

				arg_171_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_171_1.var_.characterEffect1148ui_story.fillRatio = var_174_9
			end

			local var_174_10 = 0

			if var_174_10 < arg_171_1.time_ and arg_171_1.time_ <= var_174_10 + arg_174_0 then
				arg_171_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059actionlink/1059action452")
			end

			local var_174_11 = 0

			if var_174_11 < arg_171_1.time_ and arg_171_1.time_ <= var_174_11 + arg_174_0 then
				arg_171_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_174_12 = 0
			local var_174_13 = 0.55

			if var_174_12 < arg_171_1.time_ and arg_171_1.time_ <= var_174_12 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				local var_174_14 = arg_171_1:FormatText(StoryNameCfg[28].name)

				arg_171_1.leftNameTxt_.text = var_174_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_15 = arg_171_1:GetWordFromCfg(116291041)
				local var_174_16 = arg_171_1:FormatText(var_174_15.content)

				arg_171_1.text_.text = var_174_16

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_17 = 22
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

				if manager.audio:GetVoiceLength("story_v_out_116291", "116291041", "story_v_out_116291.awb") ~= 0 then
					local var_174_20 = manager.audio:GetVoiceLength("story_v_out_116291", "116291041", "story_v_out_116291.awb") / 1000

					if var_174_20 + var_174_12 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_20 + var_174_12
					end

					if var_174_15.prefab_name ~= "" and arg_171_1.actors_[var_174_15.prefab_name] ~= nil then
						local var_174_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_15.prefab_name].transform, "story_v_out_116291", "116291041", "story_v_out_116291.awb")

						arg_171_1:RecordAudio("116291041", var_174_21)
						arg_171_1:RecordAudio("116291041", var_174_21)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_out_116291", "116291041", "story_v_out_116291.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_out_116291", "116291041", "story_v_out_116291.awb")
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
	Play116291042 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 116291042
		arg_175_1.duration_ = 5.63

		local var_175_0 = {
			zh = 5.166,
			ja = 5.633
		}
		local var_175_1 = manager.audio:GetLocalizationFlag()

		if var_175_0[var_175_1] ~= nil then
			arg_175_1.duration_ = var_175_0[var_175_1]
		end

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play116291043(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = arg_175_1.actors_["1059ui_story"]
			local var_178_1 = 0

			if var_178_1 < arg_175_1.time_ and arg_175_1.time_ <= var_178_1 + arg_178_0 and not isNil(var_178_0) and arg_175_1.var_.characterEffect1059ui_story == nil then
				arg_175_1.var_.characterEffect1059ui_story = var_178_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_178_2 = 0.2

			if var_178_1 <= arg_175_1.time_ and arg_175_1.time_ < var_178_1 + var_178_2 and not isNil(var_178_0) then
				local var_178_3 = (arg_175_1.time_ - var_178_1) / var_178_2

				if arg_175_1.var_.characterEffect1059ui_story and not isNil(var_178_0) then
					local var_178_4 = Mathf.Lerp(0, 0.5, var_178_3)

					arg_175_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_175_1.var_.characterEffect1059ui_story.fillRatio = var_178_4
				end
			end

			if arg_175_1.time_ >= var_178_1 + var_178_2 and arg_175_1.time_ < var_178_1 + var_178_2 + arg_178_0 and not isNil(var_178_0) and arg_175_1.var_.characterEffect1059ui_story then
				local var_178_5 = 0.5

				arg_175_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_175_1.var_.characterEffect1059ui_story.fillRatio = var_178_5
			end

			local var_178_6 = arg_175_1.actors_["1148ui_story"]
			local var_178_7 = 0

			if var_178_7 < arg_175_1.time_ and arg_175_1.time_ <= var_178_7 + arg_178_0 and not isNil(var_178_6) and arg_175_1.var_.characterEffect1148ui_story == nil then
				arg_175_1.var_.characterEffect1148ui_story = var_178_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_178_8 = 0.2

			if var_178_7 <= arg_175_1.time_ and arg_175_1.time_ < var_178_7 + var_178_8 and not isNil(var_178_6) then
				local var_178_9 = (arg_175_1.time_ - var_178_7) / var_178_8

				if arg_175_1.var_.characterEffect1148ui_story and not isNil(var_178_6) then
					arg_175_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_175_1.time_ >= var_178_7 + var_178_8 and arg_175_1.time_ < var_178_7 + var_178_8 + arg_178_0 and not isNil(var_178_6) and arg_175_1.var_.characterEffect1148ui_story then
				arg_175_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_178_10 = 0

			if var_178_10 < arg_175_1.time_ and arg_175_1.time_ <= var_178_10 + arg_178_0 then
				arg_175_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1048/story1048actionlink/1048action427")
			end

			local var_178_11 = 0

			if var_178_11 < arg_175_1.time_ and arg_175_1.time_ <= var_178_11 + arg_178_0 then
				arg_175_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_178_12 = 0
			local var_178_13 = 0.55

			if var_178_12 < arg_175_1.time_ and arg_175_1.time_ <= var_178_12 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				local var_178_14 = arg_175_1:FormatText(StoryNameCfg[8].name)

				arg_175_1.leftNameTxt_.text = var_178_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_15 = arg_175_1:GetWordFromCfg(116291042)
				local var_178_16 = arg_175_1:FormatText(var_178_15.content)

				arg_175_1.text_.text = var_178_16

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_17 = 22
				local var_178_18 = utf8.len(var_178_16)
				local var_178_19 = var_178_17 <= 0 and var_178_13 or var_178_13 * (var_178_18 / var_178_17)

				if var_178_19 > 0 and var_178_13 < var_178_19 then
					arg_175_1.talkMaxDuration = var_178_19

					if var_178_19 + var_178_12 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_19 + var_178_12
					end
				end

				arg_175_1.text_.text = var_178_16
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116291", "116291042", "story_v_out_116291.awb") ~= 0 then
					local var_178_20 = manager.audio:GetVoiceLength("story_v_out_116291", "116291042", "story_v_out_116291.awb") / 1000

					if var_178_20 + var_178_12 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_20 + var_178_12
					end

					if var_178_15.prefab_name ~= "" and arg_175_1.actors_[var_178_15.prefab_name] ~= nil then
						local var_178_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_15.prefab_name].transform, "story_v_out_116291", "116291042", "story_v_out_116291.awb")

						arg_175_1:RecordAudio("116291042", var_178_21)
						arg_175_1:RecordAudio("116291042", var_178_21)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_out_116291", "116291042", "story_v_out_116291.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_out_116291", "116291042", "story_v_out_116291.awb")
				end

				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_22 = math.max(var_178_13, arg_175_1.talkMaxDuration)

			if var_178_12 <= arg_175_1.time_ and arg_175_1.time_ < var_178_12 + var_178_22 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_12) / var_178_22

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_12 + var_178_22 and arg_175_1.time_ < var_178_12 + var_178_22 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {}

		arg_175_1:InitPlayNodeList()
	end,
	Play116291043 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 116291043
		arg_179_1.duration_ = 3.27

		local var_179_0 = {
			zh = 1.999999999999,
			ja = 3.266
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
				arg_179_0:Play116291044(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = arg_179_1.actors_["1059ui_story"]
			local var_182_1 = 0

			if var_182_1 < arg_179_1.time_ and arg_179_1.time_ <= var_182_1 + arg_182_0 and not isNil(var_182_0) and arg_179_1.var_.characterEffect1059ui_story == nil then
				arg_179_1.var_.characterEffect1059ui_story = var_182_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_182_2 = 0.2

			if var_182_1 <= arg_179_1.time_ and arg_179_1.time_ < var_182_1 + var_182_2 and not isNil(var_182_0) then
				local var_182_3 = (arg_179_1.time_ - var_182_1) / var_182_2

				if arg_179_1.var_.characterEffect1059ui_story and not isNil(var_182_0) then
					arg_179_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_179_1.time_ >= var_182_1 + var_182_2 and arg_179_1.time_ < var_182_1 + var_182_2 + arg_182_0 and not isNil(var_182_0) and arg_179_1.var_.characterEffect1059ui_story then
				arg_179_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_182_4 = arg_179_1.actors_["1148ui_story"]
			local var_182_5 = 0

			if var_182_5 < arg_179_1.time_ and arg_179_1.time_ <= var_182_5 + arg_182_0 and not isNil(var_182_4) and arg_179_1.var_.characterEffect1148ui_story == nil then
				arg_179_1.var_.characterEffect1148ui_story = var_182_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_182_6 = 0.2

			if var_182_5 <= arg_179_1.time_ and arg_179_1.time_ < var_182_5 + var_182_6 and not isNil(var_182_4) then
				local var_182_7 = (arg_179_1.time_ - var_182_5) / var_182_6

				if arg_179_1.var_.characterEffect1148ui_story and not isNil(var_182_4) then
					local var_182_8 = Mathf.Lerp(0, 0.5, var_182_7)

					arg_179_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_179_1.var_.characterEffect1148ui_story.fillRatio = var_182_8
				end
			end

			if arg_179_1.time_ >= var_182_5 + var_182_6 and arg_179_1.time_ < var_182_5 + var_182_6 + arg_182_0 and not isNil(var_182_4) and arg_179_1.var_.characterEffect1148ui_story then
				local var_182_9 = 0.5

				arg_179_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_179_1.var_.characterEffect1148ui_story.fillRatio = var_182_9
			end

			local var_182_10 = 0

			if var_182_10 < arg_179_1.time_ and arg_179_1.time_ <= var_182_10 + arg_182_0 then
				arg_179_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action2_2")
			end

			local var_182_11 = 0

			if var_182_11 < arg_179_1.time_ and arg_179_1.time_ <= var_182_11 + arg_182_0 then
				arg_179_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_182_12 = 0
			local var_182_13 = 0.25

			if var_182_12 < arg_179_1.time_ and arg_179_1.time_ <= var_182_12 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				local var_182_14 = arg_179_1:FormatText(StoryNameCfg[28].name)

				arg_179_1.leftNameTxt_.text = var_182_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_15 = arg_179_1:GetWordFromCfg(116291043)
				local var_182_16 = arg_179_1:FormatText(var_182_15.content)

				arg_179_1.text_.text = var_182_16

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_17 = 10
				local var_182_18 = utf8.len(var_182_16)
				local var_182_19 = var_182_17 <= 0 and var_182_13 or var_182_13 * (var_182_18 / var_182_17)

				if var_182_19 > 0 and var_182_13 < var_182_19 then
					arg_179_1.talkMaxDuration = var_182_19

					if var_182_19 + var_182_12 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_19 + var_182_12
					end
				end

				arg_179_1.text_.text = var_182_16
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116291", "116291043", "story_v_out_116291.awb") ~= 0 then
					local var_182_20 = manager.audio:GetVoiceLength("story_v_out_116291", "116291043", "story_v_out_116291.awb") / 1000

					if var_182_20 + var_182_12 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_20 + var_182_12
					end

					if var_182_15.prefab_name ~= "" and arg_179_1.actors_[var_182_15.prefab_name] ~= nil then
						local var_182_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_15.prefab_name].transform, "story_v_out_116291", "116291043", "story_v_out_116291.awb")

						arg_179_1:RecordAudio("116291043", var_182_21)
						arg_179_1:RecordAudio("116291043", var_182_21)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_out_116291", "116291043", "story_v_out_116291.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_out_116291", "116291043", "story_v_out_116291.awb")
				end

				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_22 = math.max(var_182_13, arg_179_1.talkMaxDuration)

			if var_182_12 <= arg_179_1.time_ and arg_179_1.time_ < var_182_12 + var_182_22 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_12) / var_182_22

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_12 + var_182_22 and arg_179_1.time_ < var_182_12 + var_182_22 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play116291044 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 116291044
		arg_183_1.duration_ = 5

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play116291045(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = arg_183_1.actors_["1059ui_story"]
			local var_186_1 = 0

			if var_186_1 < arg_183_1.time_ and arg_183_1.time_ <= var_186_1 + arg_186_0 and not isNil(var_186_0) and arg_183_1.var_.characterEffect1059ui_story == nil then
				arg_183_1.var_.characterEffect1059ui_story = var_186_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_186_2 = 0.2

			if var_186_1 <= arg_183_1.time_ and arg_183_1.time_ < var_186_1 + var_186_2 and not isNil(var_186_0) then
				local var_186_3 = (arg_183_1.time_ - var_186_1) / var_186_2

				if arg_183_1.var_.characterEffect1059ui_story and not isNil(var_186_0) then
					local var_186_4 = Mathf.Lerp(0, 0.5, var_186_3)

					arg_183_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_183_1.var_.characterEffect1059ui_story.fillRatio = var_186_4
				end
			end

			if arg_183_1.time_ >= var_186_1 + var_186_2 and arg_183_1.time_ < var_186_1 + var_186_2 + arg_186_0 and not isNil(var_186_0) and arg_183_1.var_.characterEffect1059ui_story then
				local var_186_5 = 0.5

				arg_183_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_183_1.var_.characterEffect1059ui_story.fillRatio = var_186_5
			end

			local var_186_6 = 0

			if var_186_6 < arg_183_1.time_ and arg_183_1.time_ <= var_186_6 + arg_186_0 then
				arg_183_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action479")
			end

			local var_186_7 = 0

			if var_186_7 < arg_183_1.time_ and arg_183_1.time_ <= var_186_7 + arg_186_0 then
				arg_183_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_186_8 = 0
			local var_186_9 = 0.55

			if var_186_8 < arg_183_1.time_ and arg_183_1.time_ <= var_186_8 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, false)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_10 = arg_183_1:GetWordFromCfg(116291044)
				local var_186_11 = arg_183_1:FormatText(var_186_10.content)

				arg_183_1.text_.text = var_186_11

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_12 = 22
				local var_186_13 = utf8.len(var_186_11)
				local var_186_14 = var_186_12 <= 0 and var_186_9 or var_186_9 * (var_186_13 / var_186_12)

				if var_186_14 > 0 and var_186_9 < var_186_14 then
					arg_183_1.talkMaxDuration = var_186_14

					if var_186_14 + var_186_8 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_14 + var_186_8
					end
				end

				arg_183_1.text_.text = var_186_11
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)
				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_15 = math.max(var_186_9, arg_183_1.talkMaxDuration)

			if var_186_8 <= arg_183_1.time_ and arg_183_1.time_ < var_186_8 + var_186_15 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_8) / var_186_15

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_8 + var_186_15 and arg_183_1.time_ < var_186_8 + var_186_15 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {}

		arg_183_1:InitPlayNodeList()
	end,
	Play116291045 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 116291045
		arg_187_1.duration_ = 5.23

		local var_187_0 = {
			zh = 5.233,
			ja = 5.133
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
				arg_187_0:Play116291046(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = arg_187_1.actors_["1059ui_story"]
			local var_190_1 = 0

			if var_190_1 < arg_187_1.time_ and arg_187_1.time_ <= var_190_1 + arg_190_0 and not isNil(var_190_0) and arg_187_1.var_.characterEffect1059ui_story == nil then
				arg_187_1.var_.characterEffect1059ui_story = var_190_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_2 = 0.2

			if var_190_1 <= arg_187_1.time_ and arg_187_1.time_ < var_190_1 + var_190_2 and not isNil(var_190_0) then
				local var_190_3 = (arg_187_1.time_ - var_190_1) / var_190_2

				if arg_187_1.var_.characterEffect1059ui_story and not isNil(var_190_0) then
					arg_187_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_187_1.time_ >= var_190_1 + var_190_2 and arg_187_1.time_ < var_190_1 + var_190_2 + arg_190_0 and not isNil(var_190_0) and arg_187_1.var_.characterEffect1059ui_story then
				arg_187_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_190_4 = 0

			if var_190_4 < arg_187_1.time_ and arg_187_1.time_ <= var_190_4 + arg_190_0 then
				arg_187_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action1_1")
			end

			local var_190_5 = 0

			if var_190_5 < arg_187_1.time_ and arg_187_1.time_ <= var_190_5 + arg_190_0 then
				arg_187_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_190_6 = 0
			local var_190_7 = 0.725

			if var_190_6 < arg_187_1.time_ and arg_187_1.time_ <= var_190_6 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				local var_190_8 = arg_187_1:FormatText(StoryNameCfg[28].name)

				arg_187_1.leftNameTxt_.text = var_190_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_9 = arg_187_1:GetWordFromCfg(116291045)
				local var_190_10 = arg_187_1:FormatText(var_190_9.content)

				arg_187_1.text_.text = var_190_10

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_11 = 29
				local var_190_12 = utf8.len(var_190_10)
				local var_190_13 = var_190_11 <= 0 and var_190_7 or var_190_7 * (var_190_12 / var_190_11)

				if var_190_13 > 0 and var_190_7 < var_190_13 then
					arg_187_1.talkMaxDuration = var_190_13

					if var_190_13 + var_190_6 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_13 + var_190_6
					end
				end

				arg_187_1.text_.text = var_190_10
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116291", "116291045", "story_v_out_116291.awb") ~= 0 then
					local var_190_14 = manager.audio:GetVoiceLength("story_v_out_116291", "116291045", "story_v_out_116291.awb") / 1000

					if var_190_14 + var_190_6 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_14 + var_190_6
					end

					if var_190_9.prefab_name ~= "" and arg_187_1.actors_[var_190_9.prefab_name] ~= nil then
						local var_190_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_187_1.actors_[var_190_9.prefab_name].transform, "story_v_out_116291", "116291045", "story_v_out_116291.awb")

						arg_187_1:RecordAudio("116291045", var_190_15)
						arg_187_1:RecordAudio("116291045", var_190_15)
					else
						arg_187_1:AudioAction("play", "voice", "story_v_out_116291", "116291045", "story_v_out_116291.awb")
					end

					arg_187_1:RecordHistoryTalkVoice("story_v_out_116291", "116291045", "story_v_out_116291.awb")
				end

				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_16 = math.max(var_190_7, arg_187_1.talkMaxDuration)

			if var_190_6 <= arg_187_1.time_ and arg_187_1.time_ < var_190_6 + var_190_16 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_6) / var_190_16

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_6 + var_190_16 and arg_187_1.time_ < var_190_6 + var_190_16 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play116291046 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 116291046
		arg_191_1.duration_ = 7.33

		local var_191_0 = {
			zh = 5.2,
			ja = 7.333
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
				arg_191_0:Play116291047(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = 0

			if var_194_0 < arg_191_1.time_ and arg_191_1.time_ <= var_194_0 + arg_194_0 then
				arg_191_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_194_1 = 0
			local var_194_2 = 0.775

			if var_194_1 < arg_191_1.time_ and arg_191_1.time_ <= var_194_1 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				local var_194_3 = arg_191_1:FormatText(StoryNameCfg[28].name)

				arg_191_1.leftNameTxt_.text = var_194_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_4 = arg_191_1:GetWordFromCfg(116291046)
				local var_194_5 = arg_191_1:FormatText(var_194_4.content)

				arg_191_1.text_.text = var_194_5

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_6 = 31
				local var_194_7 = utf8.len(var_194_5)
				local var_194_8 = var_194_6 <= 0 and var_194_2 or var_194_2 * (var_194_7 / var_194_6)

				if var_194_8 > 0 and var_194_2 < var_194_8 then
					arg_191_1.talkMaxDuration = var_194_8

					if var_194_8 + var_194_1 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_8 + var_194_1
					end
				end

				arg_191_1.text_.text = var_194_5
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116291", "116291046", "story_v_out_116291.awb") ~= 0 then
					local var_194_9 = manager.audio:GetVoiceLength("story_v_out_116291", "116291046", "story_v_out_116291.awb") / 1000

					if var_194_9 + var_194_1 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_9 + var_194_1
					end

					if var_194_4.prefab_name ~= "" and arg_191_1.actors_[var_194_4.prefab_name] ~= nil then
						local var_194_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_4.prefab_name].transform, "story_v_out_116291", "116291046", "story_v_out_116291.awb")

						arg_191_1:RecordAudio("116291046", var_194_10)
						arg_191_1:RecordAudio("116291046", var_194_10)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_out_116291", "116291046", "story_v_out_116291.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_out_116291", "116291046", "story_v_out_116291.awb")
				end

				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_11 = math.max(var_194_2, arg_191_1.talkMaxDuration)

			if var_194_1 <= arg_191_1.time_ and arg_191_1.time_ < var_194_1 + var_194_11 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_1) / var_194_11

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_1 + var_194_11 and arg_191_1.time_ < var_194_1 + var_194_11 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {}

		arg_191_1:InitPlayNodeList()
	end,
	Play116291047 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 116291047
		arg_195_1.duration_ = 0.02

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"

			SetActive(arg_195_1.choicesGo_, true)

			for iter_196_0, iter_196_1 in ipairs(arg_195_1.choices_) do
				local var_196_0 = iter_196_0 <= 2

				SetActive(iter_196_1.go, var_196_0)
			end

			arg_195_1.choices_[1].txt.text = arg_195_1:FormatText(StoryChoiceCfg[269].name)
			arg_195_1.choices_[2].txt.text = arg_195_1:FormatText(StoryChoiceCfg[270].name)
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play116291048(arg_195_1)
			end

			if arg_197_0 == 2 then
				arg_195_0:Play116291048(arg_195_1)
			end

			arg_195_1:RecordChoiceLog(116291047, 269, 270)
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			return
		end

		arg_195_1.nodeConfigList_ = {}

		arg_195_1:InitPlayNodeList()
	end,
	Play116291048 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 116291048
		arg_199_1.duration_ = 3.03

		local var_199_0 = {
			zh = 3.033,
			ja = 2.833
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
				arg_199_0:Play116291049(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = "1059ui_story"

			if arg_199_1.actors_[var_202_0] == nil then
				local var_202_1 = Asset.Load("Char/" .. "1059ui_story")

				if not isNil(var_202_1) then
					local var_202_2 = Object.Instantiate(Asset.Load("Char/" .. "1059ui_story"), arg_199_1.stage_.transform)

					var_202_2.name = var_202_0
					var_202_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_199_1.actors_[var_202_0] = var_202_2

					local var_202_3 = var_202_2:GetComponentInChildren(typeof(CharacterEffect))

					var_202_3.enabled = true

					local var_202_4 = GameObjectTools.GetOrAddComponent(var_202_2, typeof(DynamicBoneHelper))

					if var_202_4 then
						var_202_4:EnableDynamicBone(false)
					end

					arg_199_1:ShowWeapon(var_202_3.transform, false)

					arg_199_1.var_[var_202_0 .. "Animator"] = var_202_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_199_1.var_[var_202_0 .. "Animator"].applyRootMotion = true
					arg_199_1.var_[var_202_0 .. "LipSync"] = var_202_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_202_5 = 0

			if var_202_5 < arg_199_1.time_ and arg_199_1.time_ <= var_202_5 + arg_202_0 then
				arg_199_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action5_1")
			end

			local var_202_6 = "1059ui_story"

			if arg_199_1.actors_[var_202_6] == nil then
				local var_202_7 = Asset.Load("Char/" .. "1059ui_story")

				if not isNil(var_202_7) then
					local var_202_8 = Object.Instantiate(Asset.Load("Char/" .. "1059ui_story"), arg_199_1.stage_.transform)

					var_202_8.name = var_202_6
					var_202_8.transform.localPosition = Vector3.New(0, 100, 0)
					arg_199_1.actors_[var_202_6] = var_202_8

					local var_202_9 = var_202_8:GetComponentInChildren(typeof(CharacterEffect))

					var_202_9.enabled = true

					local var_202_10 = GameObjectTools.GetOrAddComponent(var_202_8, typeof(DynamicBoneHelper))

					if var_202_10 then
						var_202_10:EnableDynamicBone(false)
					end

					arg_199_1:ShowWeapon(var_202_9.transform, false)

					arg_199_1.var_[var_202_6 .. "Animator"] = var_202_9.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_199_1.var_[var_202_6 .. "Animator"].applyRootMotion = true
					arg_199_1.var_[var_202_6 .. "LipSync"] = var_202_9.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_202_11 = 0

			if var_202_11 < arg_199_1.time_ and arg_199_1.time_ <= var_202_11 + arg_202_0 then
				arg_199_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_202_12 = 0
			local var_202_13 = 0.35

			if var_202_12 < arg_199_1.time_ and arg_199_1.time_ <= var_202_12 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				local var_202_14 = arg_199_1:FormatText(StoryNameCfg[28].name)

				arg_199_1.leftNameTxt_.text = var_202_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_15 = arg_199_1:GetWordFromCfg(116291048)
				local var_202_16 = arg_199_1:FormatText(var_202_15.content)

				arg_199_1.text_.text = var_202_16

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_17 = 14
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

				if manager.audio:GetVoiceLength("story_v_out_116291", "116291048", "story_v_out_116291.awb") ~= 0 then
					local var_202_20 = manager.audio:GetVoiceLength("story_v_out_116291", "116291048", "story_v_out_116291.awb") / 1000

					if var_202_20 + var_202_12 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_20 + var_202_12
					end

					if var_202_15.prefab_name ~= "" and arg_199_1.actors_[var_202_15.prefab_name] ~= nil then
						local var_202_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_199_1.actors_[var_202_15.prefab_name].transform, "story_v_out_116291", "116291048", "story_v_out_116291.awb")

						arg_199_1:RecordAudio("116291048", var_202_21)
						arg_199_1:RecordAudio("116291048", var_202_21)
					else
						arg_199_1:AudioAction("play", "voice", "story_v_out_116291", "116291048", "story_v_out_116291.awb")
					end

					arg_199_1:RecordHistoryTalkVoice("story_v_out_116291", "116291048", "story_v_out_116291.awb")
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
	Play116291049 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 116291049
		arg_203_1.duration_ = 7.23

		local var_203_0 = {
			zh = 7.233,
			ja = 5.2
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
				arg_203_0:Play116291050(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			local var_206_0 = arg_203_1.actors_["1028ui_story"].transform
			local var_206_1 = 0

			if var_206_1 < arg_203_1.time_ and arg_203_1.time_ <= var_206_1 + arg_206_0 then
				arg_203_1.var_.moveOldPos1028ui_story = var_206_0.localPosition

				local var_206_2 = "1028ui_story"

				arg_203_1:ShowWeapon(arg_203_1.var_[var_206_2 .. "Animator"].transform, true)
			end

			local var_206_3 = 0.001

			if var_206_1 <= arg_203_1.time_ and arg_203_1.time_ < var_206_1 + var_206_3 then
				local var_206_4 = (arg_203_1.time_ - var_206_1) / var_206_3
				local var_206_5 = Vector3.New(0, -0.9, -5.9)

				var_206_0.localPosition = Vector3.Lerp(arg_203_1.var_.moveOldPos1028ui_story, var_206_5, var_206_4)

				local var_206_6 = manager.ui.mainCamera.transform.position - var_206_0.position

				var_206_0.forward = Vector3.New(var_206_6.x, var_206_6.y, var_206_6.z)

				local var_206_7 = var_206_0.localEulerAngles

				var_206_7.z = 0
				var_206_7.x = 0
				var_206_0.localEulerAngles = var_206_7
			end

			if arg_203_1.time_ >= var_206_1 + var_206_3 and arg_203_1.time_ < var_206_1 + var_206_3 + arg_206_0 then
				var_206_0.localPosition = Vector3.New(0, -0.9, -5.9)

				local var_206_8 = manager.ui.mainCamera.transform.position - var_206_0.position

				var_206_0.forward = Vector3.New(var_206_8.x, var_206_8.y, var_206_8.z)

				local var_206_9 = var_206_0.localEulerAngles

				var_206_9.z = 0
				var_206_9.x = 0
				var_206_0.localEulerAngles = var_206_9
			end

			local var_206_10 = arg_203_1.actors_["1059ui_story"].transform
			local var_206_11 = 0

			if var_206_11 < arg_203_1.time_ and arg_203_1.time_ <= var_206_11 + arg_206_0 then
				arg_203_1.var_.moveOldPos1059ui_story = var_206_10.localPosition
			end

			local var_206_12 = 0.001

			if var_206_11 <= arg_203_1.time_ and arg_203_1.time_ < var_206_11 + var_206_12 then
				local var_206_13 = (arg_203_1.time_ - var_206_11) / var_206_12
				local var_206_14 = Vector3.New(0, 100, 0)

				var_206_10.localPosition = Vector3.Lerp(arg_203_1.var_.moveOldPos1059ui_story, var_206_14, var_206_13)

				local var_206_15 = manager.ui.mainCamera.transform.position - var_206_10.position

				var_206_10.forward = Vector3.New(var_206_15.x, var_206_15.y, var_206_15.z)

				local var_206_16 = var_206_10.localEulerAngles

				var_206_16.z = 0
				var_206_16.x = 0
				var_206_10.localEulerAngles = var_206_16
			end

			if arg_203_1.time_ >= var_206_11 + var_206_12 and arg_203_1.time_ < var_206_11 + var_206_12 + arg_206_0 then
				var_206_10.localPosition = Vector3.New(0, 100, 0)

				local var_206_17 = manager.ui.mainCamera.transform.position - var_206_10.position

				var_206_10.forward = Vector3.New(var_206_17.x, var_206_17.y, var_206_17.z)

				local var_206_18 = var_206_10.localEulerAngles

				var_206_18.z = 0
				var_206_18.x = 0
				var_206_10.localEulerAngles = var_206_18
			end

			local var_206_19 = arg_203_1.actors_["1148ui_story"].transform
			local var_206_20 = 0

			if var_206_20 < arg_203_1.time_ and arg_203_1.time_ <= var_206_20 + arg_206_0 then
				arg_203_1.var_.moveOldPos1148ui_story = var_206_19.localPosition
			end

			local var_206_21 = 0.001

			if var_206_20 <= arg_203_1.time_ and arg_203_1.time_ < var_206_20 + var_206_21 then
				local var_206_22 = (arg_203_1.time_ - var_206_20) / var_206_21
				local var_206_23 = Vector3.New(0, 100, 0)

				var_206_19.localPosition = Vector3.Lerp(arg_203_1.var_.moveOldPos1148ui_story, var_206_23, var_206_22)

				local var_206_24 = manager.ui.mainCamera.transform.position - var_206_19.position

				var_206_19.forward = Vector3.New(var_206_24.x, var_206_24.y, var_206_24.z)

				local var_206_25 = var_206_19.localEulerAngles

				var_206_25.z = 0
				var_206_25.x = 0
				var_206_19.localEulerAngles = var_206_25
			end

			if arg_203_1.time_ >= var_206_20 + var_206_21 and arg_203_1.time_ < var_206_20 + var_206_21 + arg_206_0 then
				var_206_19.localPosition = Vector3.New(0, 100, 0)

				local var_206_26 = manager.ui.mainCamera.transform.position - var_206_19.position

				var_206_19.forward = Vector3.New(var_206_26.x, var_206_26.y, var_206_26.z)

				local var_206_27 = var_206_19.localEulerAngles

				var_206_27.z = 0
				var_206_27.x = 0
				var_206_19.localEulerAngles = var_206_27
			end

			local var_206_28 = arg_203_1.actors_["1028ui_story"]
			local var_206_29 = 0

			if var_206_29 < arg_203_1.time_ and arg_203_1.time_ <= var_206_29 + arg_206_0 and not isNil(var_206_28) and arg_203_1.var_.characterEffect1028ui_story == nil then
				arg_203_1.var_.characterEffect1028ui_story = var_206_28:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_206_30 = 0.2

			if var_206_29 <= arg_203_1.time_ and arg_203_1.time_ < var_206_29 + var_206_30 and not isNil(var_206_28) then
				local var_206_31 = (arg_203_1.time_ - var_206_29) / var_206_30

				if arg_203_1.var_.characterEffect1028ui_story and not isNil(var_206_28) then
					arg_203_1.var_.characterEffect1028ui_story.fillFlat = false
				end
			end

			if arg_203_1.time_ >= var_206_29 + var_206_30 and arg_203_1.time_ < var_206_29 + var_206_30 + arg_206_0 and not isNil(var_206_28) and arg_203_1.var_.characterEffect1028ui_story then
				arg_203_1.var_.characterEffect1028ui_story.fillFlat = false
			end

			local var_206_32 = 0

			if var_206_32 < arg_203_1.time_ and arg_203_1.time_ <= var_206_32 + arg_206_0 then
				arg_203_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/story1028/story1028action/1028action2_1")
			end

			local var_206_33 = 0

			if var_206_33 < arg_203_1.time_ and arg_203_1.time_ <= var_206_33 + arg_206_0 then
				arg_203_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_206_34 = 0
			local var_206_35 = 0.65

			if var_206_34 < arg_203_1.time_ and arg_203_1.time_ <= var_206_34 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				local var_206_36 = arg_203_1:FormatText(StoryNameCfg[327].name)

				arg_203_1.leftNameTxt_.text = var_206_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_37 = arg_203_1:GetWordFromCfg(116291049)
				local var_206_38 = arg_203_1:FormatText(var_206_37.content)

				arg_203_1.text_.text = var_206_38

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_39 = 26
				local var_206_40 = utf8.len(var_206_38)
				local var_206_41 = var_206_39 <= 0 and var_206_35 or var_206_35 * (var_206_40 / var_206_39)

				if var_206_41 > 0 and var_206_35 < var_206_41 then
					arg_203_1.talkMaxDuration = var_206_41

					if var_206_41 + var_206_34 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_41 + var_206_34
					end
				end

				arg_203_1.text_.text = var_206_38
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116291", "116291049", "story_v_out_116291.awb") ~= 0 then
					local var_206_42 = manager.audio:GetVoiceLength("story_v_out_116291", "116291049", "story_v_out_116291.awb") / 1000

					if var_206_42 + var_206_34 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_42 + var_206_34
					end

					if var_206_37.prefab_name ~= "" and arg_203_1.actors_[var_206_37.prefab_name] ~= nil then
						local var_206_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_37.prefab_name].transform, "story_v_out_116291", "116291049", "story_v_out_116291.awb")

						arg_203_1:RecordAudio("116291049", var_206_43)
						arg_203_1:RecordAudio("116291049", var_206_43)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_out_116291", "116291049", "story_v_out_116291.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_out_116291", "116291049", "story_v_out_116291.awb")
				end

				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_44 = math.max(var_206_35, arg_203_1.talkMaxDuration)

			if var_206_34 <= arg_203_1.time_ and arg_203_1.time_ < var_206_34 + var_206_44 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_34) / var_206_44

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_34 + var_206_44 and arg_203_1.time_ < var_206_34 + var_206_44 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_203_1:InitPlayNodeList()
	end,
	Play116291050 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 116291050
		arg_207_1.duration_ = 5.57

		local var_207_0 = {
			zh = 5.566,
			ja = 5.166
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
				arg_207_0:Play116291051(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			local var_210_0 = 0

			if var_210_0 < arg_207_1.time_ and arg_207_1.time_ <= var_210_0 + arg_210_0 then
				arg_207_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_210_1 = 0
			local var_210_2 = 0.425

			if var_210_1 < arg_207_1.time_ and arg_207_1.time_ <= var_210_1 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				local var_210_3 = arg_207_1:FormatText(StoryNameCfg[327].name)

				arg_207_1.leftNameTxt_.text = var_210_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_4 = arg_207_1:GetWordFromCfg(116291050)
				local var_210_5 = arg_207_1:FormatText(var_210_4.content)

				arg_207_1.text_.text = var_210_5

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_6 = 17
				local var_210_7 = utf8.len(var_210_5)
				local var_210_8 = var_210_6 <= 0 and var_210_2 or var_210_2 * (var_210_7 / var_210_6)

				if var_210_8 > 0 and var_210_2 < var_210_8 then
					arg_207_1.talkMaxDuration = var_210_8

					if var_210_8 + var_210_1 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_8 + var_210_1
					end
				end

				arg_207_1.text_.text = var_210_5
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116291", "116291050", "story_v_out_116291.awb") ~= 0 then
					local var_210_9 = manager.audio:GetVoiceLength("story_v_out_116291", "116291050", "story_v_out_116291.awb") / 1000

					if var_210_9 + var_210_1 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_9 + var_210_1
					end

					if var_210_4.prefab_name ~= "" and arg_207_1.actors_[var_210_4.prefab_name] ~= nil then
						local var_210_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_207_1.actors_[var_210_4.prefab_name].transform, "story_v_out_116291", "116291050", "story_v_out_116291.awb")

						arg_207_1:RecordAudio("116291050", var_210_10)
						arg_207_1:RecordAudio("116291050", var_210_10)
					else
						arg_207_1:AudioAction("play", "voice", "story_v_out_116291", "116291050", "story_v_out_116291.awb")
					end

					arg_207_1:RecordHistoryTalkVoice("story_v_out_116291", "116291050", "story_v_out_116291.awb")
				end

				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_11 = math.max(var_210_2, arg_207_1.talkMaxDuration)

			if var_210_1 <= arg_207_1.time_ and arg_207_1.time_ < var_210_1 + var_210_11 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_1) / var_210_11

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_1 + var_210_11 and arg_207_1.time_ < var_210_1 + var_210_11 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {}

		arg_207_1:InitPlayNodeList()
	end,
	Play116291051 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 116291051
		arg_211_1.duration_ = 5

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play116291052(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			local var_214_0 = arg_211_1.actors_["1028ui_story"].transform
			local var_214_1 = 0

			if var_214_1 < arg_211_1.time_ and arg_211_1.time_ <= var_214_1 + arg_214_0 then
				arg_211_1.var_.moveOldPos1028ui_story = var_214_0.localPosition
			end

			local var_214_2 = 0.001

			if var_214_1 <= arg_211_1.time_ and arg_211_1.time_ < var_214_1 + var_214_2 then
				local var_214_3 = (arg_211_1.time_ - var_214_1) / var_214_2
				local var_214_4 = Vector3.New(0, 100, 0)

				var_214_0.localPosition = Vector3.Lerp(arg_211_1.var_.moveOldPos1028ui_story, var_214_4, var_214_3)

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

			local var_214_9 = 0
			local var_214_10 = 0.45

			if var_214_9 < arg_211_1.time_ and arg_211_1.time_ <= var_214_9 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, false)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_11 = arg_211_1:GetWordFromCfg(116291051)
				local var_214_12 = arg_211_1:FormatText(var_214_11.content)

				arg_211_1.text_.text = var_214_12

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_13 = 18
				local var_214_14 = utf8.len(var_214_12)
				local var_214_15 = var_214_13 <= 0 and var_214_10 or var_214_10 * (var_214_14 / var_214_13)

				if var_214_15 > 0 and var_214_10 < var_214_15 then
					arg_211_1.talkMaxDuration = var_214_15

					if var_214_15 + var_214_9 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_15 + var_214_9
					end
				end

				arg_211_1.text_.text = var_214_12
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)
				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_16 = math.max(var_214_10, arg_211_1.talkMaxDuration)

			if var_214_9 <= arg_211_1.time_ and arg_211_1.time_ < var_214_9 + var_214_16 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_9) / var_214_16

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_9 + var_214_16 and arg_211_1.time_ < var_214_9 + var_214_16 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_211_1:InitPlayNodeList()
	end,
	Play116291052 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 116291052
		arg_215_1.duration_ = 6.3

		local var_215_0 = {
			zh = 6.3,
			ja = 5.166
		}
		local var_215_1 = manager.audio:GetLocalizationFlag()

		if var_215_0[var_215_1] ~= nil then
			arg_215_1.duration_ = var_215_0[var_215_1]
		end

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play116291053(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			local var_218_0 = arg_215_1.actors_["1059ui_story"].transform
			local var_218_1 = 0

			if var_218_1 < arg_215_1.time_ and arg_215_1.time_ <= var_218_1 + arg_218_0 then
				arg_215_1.var_.moveOldPos1059ui_story = var_218_0.localPosition
			end

			local var_218_2 = 0.001

			if var_218_1 <= arg_215_1.time_ and arg_215_1.time_ < var_218_1 + var_218_2 then
				local var_218_3 = (arg_215_1.time_ - var_218_1) / var_218_2
				local var_218_4 = Vector3.New(0, -1.05, -6)

				var_218_0.localPosition = Vector3.Lerp(arg_215_1.var_.moveOldPos1059ui_story, var_218_4, var_218_3)

				local var_218_5 = manager.ui.mainCamera.transform.position - var_218_0.position

				var_218_0.forward = Vector3.New(var_218_5.x, var_218_5.y, var_218_5.z)

				local var_218_6 = var_218_0.localEulerAngles

				var_218_6.z = 0
				var_218_6.x = 0
				var_218_0.localEulerAngles = var_218_6
			end

			if arg_215_1.time_ >= var_218_1 + var_218_2 and arg_215_1.time_ < var_218_1 + var_218_2 + arg_218_0 then
				var_218_0.localPosition = Vector3.New(0, -1.05, -6)

				local var_218_7 = manager.ui.mainCamera.transform.position - var_218_0.position

				var_218_0.forward = Vector3.New(var_218_7.x, var_218_7.y, var_218_7.z)

				local var_218_8 = var_218_0.localEulerAngles

				var_218_8.z = 0
				var_218_8.x = 0
				var_218_0.localEulerAngles = var_218_8
			end

			local var_218_9 = arg_215_1.actors_["1059ui_story"]
			local var_218_10 = 0

			if var_218_10 < arg_215_1.time_ and arg_215_1.time_ <= var_218_10 + arg_218_0 and not isNil(var_218_9) and arg_215_1.var_.characterEffect1059ui_story == nil then
				arg_215_1.var_.characterEffect1059ui_story = var_218_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_218_11 = 0.2

			if var_218_10 <= arg_215_1.time_ and arg_215_1.time_ < var_218_10 + var_218_11 and not isNil(var_218_9) then
				local var_218_12 = (arg_215_1.time_ - var_218_10) / var_218_11

				if arg_215_1.var_.characterEffect1059ui_story and not isNil(var_218_9) then
					arg_215_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_215_1.time_ >= var_218_10 + var_218_11 and arg_215_1.time_ < var_218_10 + var_218_11 + arg_218_0 and not isNil(var_218_9) and arg_215_1.var_.characterEffect1059ui_story then
				arg_215_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_218_13 = 0

			if var_218_13 < arg_215_1.time_ and arg_215_1.time_ <= var_218_13 + arg_218_0 then
				arg_215_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action7_1")
			end

			local var_218_14 = 0

			if var_218_14 < arg_215_1.time_ and arg_215_1.time_ <= var_218_14 + arg_218_0 then
				arg_215_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_218_15 = 0
			local var_218_16 = 0.9

			if var_218_15 < arg_215_1.time_ and arg_215_1.time_ <= var_218_15 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				local var_218_17 = arg_215_1:FormatText(StoryNameCfg[28].name)

				arg_215_1.leftNameTxt_.text = var_218_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_18 = arg_215_1:GetWordFromCfg(116291052)
				local var_218_19 = arg_215_1:FormatText(var_218_18.content)

				arg_215_1.text_.text = var_218_19

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_20 = 36
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

				if manager.audio:GetVoiceLength("story_v_out_116291", "116291052", "story_v_out_116291.awb") ~= 0 then
					local var_218_23 = manager.audio:GetVoiceLength("story_v_out_116291", "116291052", "story_v_out_116291.awb") / 1000

					if var_218_23 + var_218_15 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_23 + var_218_15
					end

					if var_218_18.prefab_name ~= "" and arg_215_1.actors_[var_218_18.prefab_name] ~= nil then
						local var_218_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_215_1.actors_[var_218_18.prefab_name].transform, "story_v_out_116291", "116291052", "story_v_out_116291.awb")

						arg_215_1:RecordAudio("116291052", var_218_24)
						arg_215_1:RecordAudio("116291052", var_218_24)
					else
						arg_215_1:AudioAction("play", "voice", "story_v_out_116291", "116291052", "story_v_out_116291.awb")
					end

					arg_215_1:RecordHistoryTalkVoice("story_v_out_116291", "116291052", "story_v_out_116291.awb")
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
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_215_1:InitPlayNodeList()
	end,
	Play116291053 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 116291053
		arg_219_1.duration_ = 5.13

		local var_219_0 = {
			zh = 4.1,
			ja = 5.133
		}
		local var_219_1 = manager.audio:GetLocalizationFlag()

		if var_219_0[var_219_1] ~= nil then
			arg_219_1.duration_ = var_219_0[var_219_1]
		end

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play116291054(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			local var_222_0 = 0

			if var_222_0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_0 + arg_222_0 then
				arg_219_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action7_2")
			end

			local var_222_1 = 0

			if var_222_1 < arg_219_1.time_ and arg_219_1.time_ <= var_222_1 + arg_222_0 then
				arg_219_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_222_2 = 0
			local var_222_3 = 0.575

			if var_222_2 < arg_219_1.time_ and arg_219_1.time_ <= var_222_2 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				local var_222_4 = arg_219_1:FormatText(StoryNameCfg[28].name)

				arg_219_1.leftNameTxt_.text = var_222_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_5 = arg_219_1:GetWordFromCfg(116291053)
				local var_222_6 = arg_219_1:FormatText(var_222_5.content)

				arg_219_1.text_.text = var_222_6

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_7 = 23
				local var_222_8 = utf8.len(var_222_6)
				local var_222_9 = var_222_7 <= 0 and var_222_3 or var_222_3 * (var_222_8 / var_222_7)

				if var_222_9 > 0 and var_222_3 < var_222_9 then
					arg_219_1.talkMaxDuration = var_222_9

					if var_222_9 + var_222_2 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_9 + var_222_2
					end
				end

				arg_219_1.text_.text = var_222_6
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116291", "116291053", "story_v_out_116291.awb") ~= 0 then
					local var_222_10 = manager.audio:GetVoiceLength("story_v_out_116291", "116291053", "story_v_out_116291.awb") / 1000

					if var_222_10 + var_222_2 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_10 + var_222_2
					end

					if var_222_5.prefab_name ~= "" and arg_219_1.actors_[var_222_5.prefab_name] ~= nil then
						local var_222_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_219_1.actors_[var_222_5.prefab_name].transform, "story_v_out_116291", "116291053", "story_v_out_116291.awb")

						arg_219_1:RecordAudio("116291053", var_222_11)
						arg_219_1:RecordAudio("116291053", var_222_11)
					else
						arg_219_1:AudioAction("play", "voice", "story_v_out_116291", "116291053", "story_v_out_116291.awb")
					end

					arg_219_1:RecordHistoryTalkVoice("story_v_out_116291", "116291053", "story_v_out_116291.awb")
				end

				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_12 = math.max(var_222_3, arg_219_1.talkMaxDuration)

			if var_222_2 <= arg_219_1.time_ and arg_219_1.time_ < var_222_2 + var_222_12 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_2) / var_222_12

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_2 + var_222_12 and arg_219_1.time_ < var_222_2 + var_222_12 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {}

		arg_219_1:InitPlayNodeList()
	end,
	Play116291054 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 116291054
		arg_223_1.duration_ = 3.87

		local var_223_0 = {
			zh = 3.866,
			ja = 2.7
		}
		local var_223_1 = manager.audio:GetLocalizationFlag()

		if var_223_0[var_223_1] ~= nil then
			arg_223_1.duration_ = var_223_0[var_223_1]
		end

		SetActive(arg_223_1.tipsGo_, false)

		function arg_223_1.onSingleLineFinish_()
			arg_223_1.onSingleLineUpdate_ = nil
			arg_223_1.onSingleLineFinish_ = nil
			arg_223_1.state_ = "waiting"
		end

		function arg_223_1.playNext_(arg_225_0)
			if arg_225_0 == 1 then
				arg_223_0:Play116291055(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			local var_226_0 = arg_223_1.actors_["1028ui_story"]
			local var_226_1 = 0

			if var_226_1 < arg_223_1.time_ and arg_223_1.time_ <= var_226_1 + arg_226_0 and not isNil(var_226_0) and arg_223_1.var_.characterEffect1028ui_story == nil then
				arg_223_1.var_.characterEffect1028ui_story = var_226_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_226_2 = 0.2

			if var_226_1 <= arg_223_1.time_ and arg_223_1.time_ < var_226_1 + var_226_2 and not isNil(var_226_0) then
				local var_226_3 = (arg_223_1.time_ - var_226_1) / var_226_2

				if arg_223_1.var_.characterEffect1028ui_story and not isNil(var_226_0) then
					arg_223_1.var_.characterEffect1028ui_story.fillFlat = false
				end
			end

			if arg_223_1.time_ >= var_226_1 + var_226_2 and arg_223_1.time_ < var_226_1 + var_226_2 + arg_226_0 and not isNil(var_226_0) and arg_223_1.var_.characterEffect1028ui_story then
				arg_223_1.var_.characterEffect1028ui_story.fillFlat = false
			end

			local var_226_4 = 0

			if var_226_4 < arg_223_1.time_ and arg_223_1.time_ <= var_226_4 + arg_226_0 then
				arg_223_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_226_5 = arg_223_1.actors_["1059ui_story"]
			local var_226_6 = 0

			if var_226_6 < arg_223_1.time_ and arg_223_1.time_ <= var_226_6 + arg_226_0 and not isNil(var_226_5) and arg_223_1.var_.characterEffect1059ui_story == nil then
				arg_223_1.var_.characterEffect1059ui_story = var_226_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_226_7 = 0.2

			if var_226_6 <= arg_223_1.time_ and arg_223_1.time_ < var_226_6 + var_226_7 and not isNil(var_226_5) then
				local var_226_8 = (arg_223_1.time_ - var_226_6) / var_226_7

				if arg_223_1.var_.characterEffect1059ui_story and not isNil(var_226_5) then
					local var_226_9 = Mathf.Lerp(0, 0.5, var_226_8)

					arg_223_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_223_1.var_.characterEffect1059ui_story.fillRatio = var_226_9
				end
			end

			if arg_223_1.time_ >= var_226_6 + var_226_7 and arg_223_1.time_ < var_226_6 + var_226_7 + arg_226_0 and not isNil(var_226_5) and arg_223_1.var_.characterEffect1059ui_story then
				local var_226_10 = 0.5

				arg_223_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_223_1.var_.characterEffect1059ui_story.fillRatio = var_226_10
			end

			local var_226_11 = arg_223_1.actors_["1059ui_story"].transform
			local var_226_12 = 0

			if var_226_12 < arg_223_1.time_ and arg_223_1.time_ <= var_226_12 + arg_226_0 then
				arg_223_1.var_.moveOldPos1059ui_story = var_226_11.localPosition
			end

			local var_226_13 = 0.001

			if var_226_12 <= arg_223_1.time_ and arg_223_1.time_ < var_226_12 + var_226_13 then
				local var_226_14 = (arg_223_1.time_ - var_226_12) / var_226_13
				local var_226_15 = Vector3.New(0, 100, 0)

				var_226_11.localPosition = Vector3.Lerp(arg_223_1.var_.moveOldPos1059ui_story, var_226_15, var_226_14)

				local var_226_16 = manager.ui.mainCamera.transform.position - var_226_11.position

				var_226_11.forward = Vector3.New(var_226_16.x, var_226_16.y, var_226_16.z)

				local var_226_17 = var_226_11.localEulerAngles

				var_226_17.z = 0
				var_226_17.x = 0
				var_226_11.localEulerAngles = var_226_17
			end

			if arg_223_1.time_ >= var_226_12 + var_226_13 and arg_223_1.time_ < var_226_12 + var_226_13 + arg_226_0 then
				var_226_11.localPosition = Vector3.New(0, 100, 0)

				local var_226_18 = manager.ui.mainCamera.transform.position - var_226_11.position

				var_226_11.forward = Vector3.New(var_226_18.x, var_226_18.y, var_226_18.z)

				local var_226_19 = var_226_11.localEulerAngles

				var_226_19.z = 0
				var_226_19.x = 0
				var_226_11.localEulerAngles = var_226_19
			end

			local var_226_20 = arg_223_1.actors_["1028ui_story"].transform
			local var_226_21 = 0

			if var_226_21 < arg_223_1.time_ and arg_223_1.time_ <= var_226_21 + arg_226_0 then
				arg_223_1.var_.moveOldPos1028ui_story = var_226_20.localPosition

				local var_226_22 = "1028ui_story"

				arg_223_1:ShowWeapon(arg_223_1.var_[var_226_22 .. "Animator"].transform, false)
			end

			local var_226_23 = 0.001

			if var_226_21 <= arg_223_1.time_ and arg_223_1.time_ < var_226_21 + var_226_23 then
				local var_226_24 = (arg_223_1.time_ - var_226_21) / var_226_23
				local var_226_25 = Vector3.New(0, -0.9, -5.9)

				var_226_20.localPosition = Vector3.Lerp(arg_223_1.var_.moveOldPos1028ui_story, var_226_25, var_226_24)

				local var_226_26 = manager.ui.mainCamera.transform.position - var_226_20.position

				var_226_20.forward = Vector3.New(var_226_26.x, var_226_26.y, var_226_26.z)

				local var_226_27 = var_226_20.localEulerAngles

				var_226_27.z = 0
				var_226_27.x = 0
				var_226_20.localEulerAngles = var_226_27
			end

			if arg_223_1.time_ >= var_226_21 + var_226_23 and arg_223_1.time_ < var_226_21 + var_226_23 + arg_226_0 then
				var_226_20.localPosition = Vector3.New(0, -0.9, -5.9)

				local var_226_28 = manager.ui.mainCamera.transform.position - var_226_20.position

				var_226_20.forward = Vector3.New(var_226_28.x, var_226_28.y, var_226_28.z)

				local var_226_29 = var_226_20.localEulerAngles

				var_226_29.z = 0
				var_226_29.x = 0
				var_226_20.localEulerAngles = var_226_29
			end

			local var_226_30 = 0

			if var_226_30 < arg_223_1.time_ and arg_223_1.time_ <= var_226_30 + arg_226_0 then
				arg_223_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/story1028/story1028action/1028action1_1")
			end

			local var_226_31 = 0
			local var_226_32 = 0.45

			if var_226_31 < arg_223_1.time_ and arg_223_1.time_ <= var_226_31 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				local var_226_33 = arg_223_1:FormatText(StoryNameCfg[327].name)

				arg_223_1.leftNameTxt_.text = var_226_33

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_34 = arg_223_1:GetWordFromCfg(116291054)
				local var_226_35 = arg_223_1:FormatText(var_226_34.content)

				arg_223_1.text_.text = var_226_35

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_36 = 18
				local var_226_37 = utf8.len(var_226_35)
				local var_226_38 = var_226_36 <= 0 and var_226_32 or var_226_32 * (var_226_37 / var_226_36)

				if var_226_38 > 0 and var_226_32 < var_226_38 then
					arg_223_1.talkMaxDuration = var_226_38

					if var_226_38 + var_226_31 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_38 + var_226_31
					end
				end

				arg_223_1.text_.text = var_226_35
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116291", "116291054", "story_v_out_116291.awb") ~= 0 then
					local var_226_39 = manager.audio:GetVoiceLength("story_v_out_116291", "116291054", "story_v_out_116291.awb") / 1000

					if var_226_39 + var_226_31 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_39 + var_226_31
					end

					if var_226_34.prefab_name ~= "" and arg_223_1.actors_[var_226_34.prefab_name] ~= nil then
						local var_226_40 = LuaForUtil.PlayVoiceWithCriLipsync(arg_223_1.actors_[var_226_34.prefab_name].transform, "story_v_out_116291", "116291054", "story_v_out_116291.awb")

						arg_223_1:RecordAudio("116291054", var_226_40)
						arg_223_1:RecordAudio("116291054", var_226_40)
					else
						arg_223_1:AudioAction("play", "voice", "story_v_out_116291", "116291054", "story_v_out_116291.awb")
					end

					arg_223_1:RecordHistoryTalkVoice("story_v_out_116291", "116291054", "story_v_out_116291.awb")
				end

				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_41 = math.max(var_226_32, arg_223_1.talkMaxDuration)

			if var_226_31 <= arg_223_1.time_ and arg_223_1.time_ < var_226_31 + var_226_41 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_31) / var_226_41

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_31 + var_226_41 and arg_223_1.time_ < var_226_31 + var_226_41 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1028ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_223_1:InitPlayNodeList()
	end,
	Play116291055 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 116291055
		arg_227_1.duration_ = 5

		SetActive(arg_227_1.tipsGo_, false)

		function arg_227_1.onSingleLineFinish_()
			arg_227_1.onSingleLineUpdate_ = nil
			arg_227_1.onSingleLineFinish_ = nil
			arg_227_1.state_ = "waiting"
		end

		function arg_227_1.playNext_(arg_229_0)
			if arg_229_0 == 1 then
				arg_227_0:Play116291056(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			local var_230_0 = 0
			local var_230_1 = 0.55

			if var_230_0 < arg_227_1.time_ and arg_227_1.time_ <= var_230_0 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, false)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_2 = arg_227_1:GetWordFromCfg(116291055)
				local var_230_3 = arg_227_1:FormatText(var_230_2.content)

				arg_227_1.text_.text = var_230_3

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_4 = 22
				local var_230_5 = utf8.len(var_230_3)
				local var_230_6 = var_230_4 <= 0 and var_230_1 or var_230_1 * (var_230_5 / var_230_4)

				if var_230_6 > 0 and var_230_1 < var_230_6 then
					arg_227_1.talkMaxDuration = var_230_6

					if var_230_6 + var_230_0 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_6 + var_230_0
					end
				end

				arg_227_1.text_.text = var_230_3
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)
				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_7 = math.max(var_230_1, arg_227_1.talkMaxDuration)

			if var_230_0 <= arg_227_1.time_ and arg_227_1.time_ < var_230_0 + var_230_7 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_0) / var_230_7

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_0 + var_230_7 and arg_227_1.time_ < var_230_0 + var_230_7 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {}

		arg_227_1:InitPlayNodeList()
	end,
	Play116291056 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 116291056
		arg_231_1.duration_ = 8.1

		local var_231_0 = {
			zh = 8.1,
			ja = 5.366
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
				arg_231_0:Play116291057(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			local var_234_0 = arg_231_1.actors_["1059ui_story"]
			local var_234_1 = 0

			if var_234_1 < arg_231_1.time_ and arg_231_1.time_ <= var_234_1 + arg_234_0 and not isNil(var_234_0) and arg_231_1.var_.characterEffect1059ui_story == nil then
				arg_231_1.var_.characterEffect1059ui_story = var_234_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_234_2 = 0.2

			if var_234_1 <= arg_231_1.time_ and arg_231_1.time_ < var_234_1 + var_234_2 and not isNil(var_234_0) then
				local var_234_3 = (arg_231_1.time_ - var_234_1) / var_234_2

				if arg_231_1.var_.characterEffect1059ui_story and not isNil(var_234_0) then
					arg_231_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_231_1.time_ >= var_234_1 + var_234_2 and arg_231_1.time_ < var_234_1 + var_234_2 + arg_234_0 and not isNil(var_234_0) and arg_231_1.var_.characterEffect1059ui_story then
				arg_231_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_234_4 = 0

			if var_234_4 < arg_231_1.time_ and arg_231_1.time_ <= var_234_4 + arg_234_0 then
				arg_231_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action4_1")
			end

			local var_234_5 = 0

			if var_234_5 < arg_231_1.time_ and arg_231_1.time_ <= var_234_5 + arg_234_0 then
				arg_231_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_234_6 = arg_231_1.actors_["1028ui_story"].transform
			local var_234_7 = 0

			if var_234_7 < arg_231_1.time_ and arg_231_1.time_ <= var_234_7 + arg_234_0 then
				arg_231_1.var_.moveOldPos1028ui_story = var_234_6.localPosition

				local var_234_8 = "1028ui_story"

				arg_231_1:ShowWeapon(arg_231_1.var_[var_234_8 .. "Animator"].transform, false)
			end

			local var_234_9 = 0.001

			if var_234_7 <= arg_231_1.time_ and arg_231_1.time_ < var_234_7 + var_234_9 then
				local var_234_10 = (arg_231_1.time_ - var_234_7) / var_234_9
				local var_234_11 = Vector3.New(0, 100, 0)

				var_234_6.localPosition = Vector3.Lerp(arg_231_1.var_.moveOldPos1028ui_story, var_234_11, var_234_10)

				local var_234_12 = manager.ui.mainCamera.transform.position - var_234_6.position

				var_234_6.forward = Vector3.New(var_234_12.x, var_234_12.y, var_234_12.z)

				local var_234_13 = var_234_6.localEulerAngles

				var_234_13.z = 0
				var_234_13.x = 0
				var_234_6.localEulerAngles = var_234_13
			end

			if arg_231_1.time_ >= var_234_7 + var_234_9 and arg_231_1.time_ < var_234_7 + var_234_9 + arg_234_0 then
				var_234_6.localPosition = Vector3.New(0, 100, 0)

				local var_234_14 = manager.ui.mainCamera.transform.position - var_234_6.position

				var_234_6.forward = Vector3.New(var_234_14.x, var_234_14.y, var_234_14.z)

				local var_234_15 = var_234_6.localEulerAngles

				var_234_15.z = 0
				var_234_15.x = 0
				var_234_6.localEulerAngles = var_234_15
			end

			local var_234_16 = arg_231_1.actors_["1059ui_story"].transform
			local var_234_17 = 0

			if var_234_17 < arg_231_1.time_ and arg_231_1.time_ <= var_234_17 + arg_234_0 then
				arg_231_1.var_.moveOldPos1059ui_story = var_234_16.localPosition
			end

			local var_234_18 = 0.001

			if var_234_17 <= arg_231_1.time_ and arg_231_1.time_ < var_234_17 + var_234_18 then
				local var_234_19 = (arg_231_1.time_ - var_234_17) / var_234_18
				local var_234_20 = Vector3.New(0, -1.05, -6)

				var_234_16.localPosition = Vector3.Lerp(arg_231_1.var_.moveOldPos1059ui_story, var_234_20, var_234_19)

				local var_234_21 = manager.ui.mainCamera.transform.position - var_234_16.position

				var_234_16.forward = Vector3.New(var_234_21.x, var_234_21.y, var_234_21.z)

				local var_234_22 = var_234_16.localEulerAngles

				var_234_22.z = 0
				var_234_22.x = 0
				var_234_16.localEulerAngles = var_234_22
			end

			if arg_231_1.time_ >= var_234_17 + var_234_18 and arg_231_1.time_ < var_234_17 + var_234_18 + arg_234_0 then
				var_234_16.localPosition = Vector3.New(0, -1.05, -6)

				local var_234_23 = manager.ui.mainCamera.transform.position - var_234_16.position

				var_234_16.forward = Vector3.New(var_234_23.x, var_234_23.y, var_234_23.z)

				local var_234_24 = var_234_16.localEulerAngles

				var_234_24.z = 0
				var_234_24.x = 0
				var_234_16.localEulerAngles = var_234_24
			end

			local var_234_25 = 0
			local var_234_26 = 1

			if var_234_25 < arg_231_1.time_ and arg_231_1.time_ <= var_234_25 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				local var_234_27 = arg_231_1:FormatText(StoryNameCfg[28].name)

				arg_231_1.leftNameTxt_.text = var_234_27

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_28 = arg_231_1:GetWordFromCfg(116291056)
				local var_234_29 = arg_231_1:FormatText(var_234_28.content)

				arg_231_1.text_.text = var_234_29

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_30 = 40
				local var_234_31 = utf8.len(var_234_29)
				local var_234_32 = var_234_30 <= 0 and var_234_26 or var_234_26 * (var_234_31 / var_234_30)

				if var_234_32 > 0 and var_234_26 < var_234_32 then
					arg_231_1.talkMaxDuration = var_234_32

					if var_234_32 + var_234_25 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_32 + var_234_25
					end
				end

				arg_231_1.text_.text = var_234_29
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116291", "116291056", "story_v_out_116291.awb") ~= 0 then
					local var_234_33 = manager.audio:GetVoiceLength("story_v_out_116291", "116291056", "story_v_out_116291.awb") / 1000

					if var_234_33 + var_234_25 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_33 + var_234_25
					end

					if var_234_28.prefab_name ~= "" and arg_231_1.actors_[var_234_28.prefab_name] ~= nil then
						local var_234_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_231_1.actors_[var_234_28.prefab_name].transform, "story_v_out_116291", "116291056", "story_v_out_116291.awb")

						arg_231_1:RecordAudio("116291056", var_234_34)
						arg_231_1:RecordAudio("116291056", var_234_34)
					else
						arg_231_1:AudioAction("play", "voice", "story_v_out_116291", "116291056", "story_v_out_116291.awb")
					end

					arg_231_1:RecordHistoryTalkVoice("story_v_out_116291", "116291056", "story_v_out_116291.awb")
				end

				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_35 = math.max(var_234_26, arg_231_1.talkMaxDuration)

			if var_234_25 <= arg_231_1.time_ and arg_231_1.time_ < var_234_25 + var_234_35 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_25) / var_234_35

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_25 + var_234_35 and arg_231_1.time_ < var_234_25 + var_234_35 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_231_1:InitPlayNodeList()
	end,
	Play116291057 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 116291057
		arg_235_1.duration_ = 6.8

		local var_235_0 = {
			zh = 6.766,
			ja = 6.8
		}
		local var_235_1 = manager.audio:GetLocalizationFlag()

		if var_235_0[var_235_1] ~= nil then
			arg_235_1.duration_ = var_235_0[var_235_1]
		end

		SetActive(arg_235_1.tipsGo_, false)

		function arg_235_1.onSingleLineFinish_()
			arg_235_1.onSingleLineUpdate_ = nil
			arg_235_1.onSingleLineFinish_ = nil
			arg_235_1.state_ = "waiting"
		end

		function arg_235_1.playNext_(arg_237_0)
			if arg_237_0 == 1 then
				arg_235_0:Play116291058(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			local var_238_0 = 0

			if var_238_0 < arg_235_1.time_ and arg_235_1.time_ <= var_238_0 + arg_238_0 then
				arg_235_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_238_1 = 0

			if var_238_1 < arg_235_1.time_ and arg_235_1.time_ <= var_238_1 + arg_238_0 then
				arg_235_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action4_2")
			end

			local var_238_2 = 0
			local var_238_3 = 0.925

			if var_238_2 < arg_235_1.time_ and arg_235_1.time_ <= var_238_2 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				local var_238_4 = arg_235_1:FormatText(StoryNameCfg[28].name)

				arg_235_1.leftNameTxt_.text = var_238_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_5 = arg_235_1:GetWordFromCfg(116291057)
				local var_238_6 = arg_235_1:FormatText(var_238_5.content)

				arg_235_1.text_.text = var_238_6

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_7 = 37
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

				if manager.audio:GetVoiceLength("story_v_out_116291", "116291057", "story_v_out_116291.awb") ~= 0 then
					local var_238_10 = manager.audio:GetVoiceLength("story_v_out_116291", "116291057", "story_v_out_116291.awb") / 1000

					if var_238_10 + var_238_2 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_10 + var_238_2
					end

					if var_238_5.prefab_name ~= "" and arg_235_1.actors_[var_238_5.prefab_name] ~= nil then
						local var_238_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_235_1.actors_[var_238_5.prefab_name].transform, "story_v_out_116291", "116291057", "story_v_out_116291.awb")

						arg_235_1:RecordAudio("116291057", var_238_11)
						arg_235_1:RecordAudio("116291057", var_238_11)
					else
						arg_235_1:AudioAction("play", "voice", "story_v_out_116291", "116291057", "story_v_out_116291.awb")
					end

					arg_235_1:RecordHistoryTalkVoice("story_v_out_116291", "116291057", "story_v_out_116291.awb")
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
	Play116291058 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 116291058
		arg_239_1.duration_ = 5

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play116291059(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			local var_242_0 = arg_239_1.actors_["1028ui_story"].transform
			local var_242_1 = 0

			if var_242_1 < arg_239_1.time_ and arg_239_1.time_ <= var_242_1 + arg_242_0 then
				arg_239_1.var_.moveOldPos1028ui_story = var_242_0.localPosition
			end

			local var_242_2 = 0.001

			if var_242_1 <= arg_239_1.time_ and arg_239_1.time_ < var_242_1 + var_242_2 then
				local var_242_3 = (arg_239_1.time_ - var_242_1) / var_242_2
				local var_242_4 = Vector3.New(0, 100, 0)

				var_242_0.localPosition = Vector3.Lerp(arg_239_1.var_.moveOldPos1028ui_story, var_242_4, var_242_3)

				local var_242_5 = manager.ui.mainCamera.transform.position - var_242_0.position

				var_242_0.forward = Vector3.New(var_242_5.x, var_242_5.y, var_242_5.z)

				local var_242_6 = var_242_0.localEulerAngles

				var_242_6.z = 0
				var_242_6.x = 0
				var_242_0.localEulerAngles = var_242_6
			end

			if arg_239_1.time_ >= var_242_1 + var_242_2 and arg_239_1.time_ < var_242_1 + var_242_2 + arg_242_0 then
				var_242_0.localPosition = Vector3.New(0, 100, 0)

				local var_242_7 = manager.ui.mainCamera.transform.position - var_242_0.position

				var_242_0.forward = Vector3.New(var_242_7.x, var_242_7.y, var_242_7.z)

				local var_242_8 = var_242_0.localEulerAngles

				var_242_8.z = 0
				var_242_8.x = 0
				var_242_0.localEulerAngles = var_242_8
			end

			local var_242_9 = arg_239_1.actors_["1059ui_story"].transform
			local var_242_10 = 0

			if var_242_10 < arg_239_1.time_ and arg_239_1.time_ <= var_242_10 + arg_242_0 then
				arg_239_1.var_.moveOldPos1059ui_story = var_242_9.localPosition
			end

			local var_242_11 = 0.001

			if var_242_10 <= arg_239_1.time_ and arg_239_1.time_ < var_242_10 + var_242_11 then
				local var_242_12 = (arg_239_1.time_ - var_242_10) / var_242_11
				local var_242_13 = Vector3.New(0, 100, 0)

				var_242_9.localPosition = Vector3.Lerp(arg_239_1.var_.moveOldPos1059ui_story, var_242_13, var_242_12)

				local var_242_14 = manager.ui.mainCamera.transform.position - var_242_9.position

				var_242_9.forward = Vector3.New(var_242_14.x, var_242_14.y, var_242_14.z)

				local var_242_15 = var_242_9.localEulerAngles

				var_242_15.z = 0
				var_242_15.x = 0
				var_242_9.localEulerAngles = var_242_15
			end

			if arg_239_1.time_ >= var_242_10 + var_242_11 and arg_239_1.time_ < var_242_10 + var_242_11 + arg_242_0 then
				var_242_9.localPosition = Vector3.New(0, 100, 0)

				local var_242_16 = manager.ui.mainCamera.transform.position - var_242_9.position

				var_242_9.forward = Vector3.New(var_242_16.x, var_242_16.y, var_242_16.z)

				local var_242_17 = var_242_9.localEulerAngles

				var_242_17.z = 0
				var_242_17.x = 0
				var_242_9.localEulerAngles = var_242_17
			end

			local var_242_18 = 0
			local var_242_19 = 1.45

			if var_242_18 < arg_239_1.time_ and arg_239_1.time_ <= var_242_18 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, false)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_20 = arg_239_1:GetWordFromCfg(116291058)
				local var_242_21 = arg_239_1:FormatText(var_242_20.content)

				arg_239_1.text_.text = var_242_21

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_22 = 58
				local var_242_23 = utf8.len(var_242_21)
				local var_242_24 = var_242_22 <= 0 and var_242_19 or var_242_19 * (var_242_23 / var_242_22)

				if var_242_24 > 0 and var_242_19 < var_242_24 then
					arg_239_1.talkMaxDuration = var_242_24

					if var_242_24 + var_242_18 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_24 + var_242_18
					end
				end

				arg_239_1.text_.text = var_242_21
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)
				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_25 = math.max(var_242_19, arg_239_1.talkMaxDuration)

			if var_242_18 <= arg_239_1.time_ and arg_239_1.time_ < var_242_18 + var_242_25 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_18) / var_242_25

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_18 + var_242_25 and arg_239_1.time_ < var_242_18 + var_242_25 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_239_1:InitPlayNodeList()
	end,
	Play116291059 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 116291059
		arg_243_1.duration_ = 6.1

		local var_243_0 = {
			zh = 6.1,
			ja = 4.066
		}
		local var_243_1 = manager.audio:GetLocalizationFlag()

		if var_243_0[var_243_1] ~= nil then
			arg_243_1.duration_ = var_243_0[var_243_1]
		end

		SetActive(arg_243_1.tipsGo_, false)

		function arg_243_1.onSingleLineFinish_()
			arg_243_1.onSingleLineUpdate_ = nil
			arg_243_1.onSingleLineFinish_ = nil
			arg_243_1.state_ = "waiting"
		end

		function arg_243_1.playNext_(arg_245_0)
			if arg_245_0 == 1 then
				arg_243_0:Play116291060(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			local var_246_0 = arg_243_1.actors_["1028ui_story"].transform
			local var_246_1 = 0

			if var_246_1 < arg_243_1.time_ and arg_243_1.time_ <= var_246_1 + arg_246_0 then
				arg_243_1.var_.moveOldPos1028ui_story = var_246_0.localPosition
			end

			local var_246_2 = 0.001

			if var_246_1 <= arg_243_1.time_ and arg_243_1.time_ < var_246_1 + var_246_2 then
				local var_246_3 = (arg_243_1.time_ - var_246_1) / var_246_2
				local var_246_4 = Vector3.New(-0.7, -0.9, -5.9)

				var_246_0.localPosition = Vector3.Lerp(arg_243_1.var_.moveOldPos1028ui_story, var_246_4, var_246_3)

				local var_246_5 = manager.ui.mainCamera.transform.position - var_246_0.position

				var_246_0.forward = Vector3.New(var_246_5.x, var_246_5.y, var_246_5.z)

				local var_246_6 = var_246_0.localEulerAngles

				var_246_6.z = 0
				var_246_6.x = 0
				var_246_0.localEulerAngles = var_246_6
			end

			if arg_243_1.time_ >= var_246_1 + var_246_2 and arg_243_1.time_ < var_246_1 + var_246_2 + arg_246_0 then
				var_246_0.localPosition = Vector3.New(-0.7, -0.9, -5.9)

				local var_246_7 = manager.ui.mainCamera.transform.position - var_246_0.position

				var_246_0.forward = Vector3.New(var_246_7.x, var_246_7.y, var_246_7.z)

				local var_246_8 = var_246_0.localEulerAngles

				var_246_8.z = 0
				var_246_8.x = 0
				var_246_0.localEulerAngles = var_246_8
			end

			local var_246_9 = arg_243_1.actors_["1059ui_story"].transform
			local var_246_10 = 0

			if var_246_10 < arg_243_1.time_ and arg_243_1.time_ <= var_246_10 + arg_246_0 then
				arg_243_1.var_.moveOldPos1059ui_story = var_246_9.localPosition
			end

			local var_246_11 = 0.001

			if var_246_10 <= arg_243_1.time_ and arg_243_1.time_ < var_246_10 + var_246_11 then
				local var_246_12 = (arg_243_1.time_ - var_246_10) / var_246_11
				local var_246_13 = Vector3.New(0.7, -1.05, -6)

				var_246_9.localPosition = Vector3.Lerp(arg_243_1.var_.moveOldPos1059ui_story, var_246_13, var_246_12)

				local var_246_14 = manager.ui.mainCamera.transform.position - var_246_9.position

				var_246_9.forward = Vector3.New(var_246_14.x, var_246_14.y, var_246_14.z)

				local var_246_15 = var_246_9.localEulerAngles

				var_246_15.z = 0
				var_246_15.x = 0
				var_246_9.localEulerAngles = var_246_15
			end

			if arg_243_1.time_ >= var_246_10 + var_246_11 and arg_243_1.time_ < var_246_10 + var_246_11 + arg_246_0 then
				var_246_9.localPosition = Vector3.New(0.7, -1.05, -6)

				local var_246_16 = manager.ui.mainCamera.transform.position - var_246_9.position

				var_246_9.forward = Vector3.New(var_246_16.x, var_246_16.y, var_246_16.z)

				local var_246_17 = var_246_9.localEulerAngles

				var_246_17.z = 0
				var_246_17.x = 0
				var_246_9.localEulerAngles = var_246_17
			end

			local var_246_18 = arg_243_1.actors_["1059ui_story"]
			local var_246_19 = 0

			if var_246_19 < arg_243_1.time_ and arg_243_1.time_ <= var_246_19 + arg_246_0 and not isNil(var_246_18) and arg_243_1.var_.characterEffect1059ui_story == nil then
				arg_243_1.var_.characterEffect1059ui_story = var_246_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_246_20 = 0.2

			if var_246_19 <= arg_243_1.time_ and arg_243_1.time_ < var_246_19 + var_246_20 and not isNil(var_246_18) then
				local var_246_21 = (arg_243_1.time_ - var_246_19) / var_246_20

				if arg_243_1.var_.characterEffect1059ui_story and not isNil(var_246_18) then
					arg_243_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_243_1.time_ >= var_246_19 + var_246_20 and arg_243_1.time_ < var_246_19 + var_246_20 + arg_246_0 and not isNil(var_246_18) and arg_243_1.var_.characterEffect1059ui_story then
				arg_243_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_246_22 = arg_243_1.actors_["1028ui_story"]
			local var_246_23 = 0

			if var_246_23 < arg_243_1.time_ and arg_243_1.time_ <= var_246_23 + arg_246_0 and not isNil(var_246_22) and arg_243_1.var_.characterEffect1028ui_story == nil then
				arg_243_1.var_.characterEffect1028ui_story = var_246_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_246_24 = 0.034

			if var_246_23 <= arg_243_1.time_ and arg_243_1.time_ < var_246_23 + var_246_24 and not isNil(var_246_22) then
				local var_246_25 = (arg_243_1.time_ - var_246_23) / var_246_24

				if arg_243_1.var_.characterEffect1028ui_story and not isNil(var_246_22) then
					local var_246_26 = Mathf.Lerp(0, 0.5, var_246_25)

					arg_243_1.var_.characterEffect1028ui_story.fillFlat = true
					arg_243_1.var_.characterEffect1028ui_story.fillRatio = var_246_26
				end
			end

			if arg_243_1.time_ >= var_246_23 + var_246_24 and arg_243_1.time_ < var_246_23 + var_246_24 + arg_246_0 and not isNil(var_246_22) and arg_243_1.var_.characterEffect1028ui_story then
				local var_246_27 = 0.5

				arg_243_1.var_.characterEffect1028ui_story.fillFlat = true
				arg_243_1.var_.characterEffect1028ui_story.fillRatio = var_246_27
			end

			local var_246_28 = 0

			if var_246_28 < arg_243_1.time_ and arg_243_1.time_ <= var_246_28 + arg_246_0 then
				arg_243_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action5_1")
			end

			local var_246_29 = 0

			if var_246_29 < arg_243_1.time_ and arg_243_1.time_ <= var_246_29 + arg_246_0 then
				arg_243_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_246_30 = 0
			local var_246_31 = 0.8

			if var_246_30 < arg_243_1.time_ and arg_243_1.time_ <= var_246_30 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				local var_246_32 = arg_243_1:FormatText(StoryNameCfg[28].name)

				arg_243_1.leftNameTxt_.text = var_246_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_33 = arg_243_1:GetWordFromCfg(116291059)
				local var_246_34 = arg_243_1:FormatText(var_246_33.content)

				arg_243_1.text_.text = var_246_34

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_35 = 32
				local var_246_36 = utf8.len(var_246_34)
				local var_246_37 = var_246_35 <= 0 and var_246_31 or var_246_31 * (var_246_36 / var_246_35)

				if var_246_37 > 0 and var_246_31 < var_246_37 then
					arg_243_1.talkMaxDuration = var_246_37

					if var_246_37 + var_246_30 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_37 + var_246_30
					end
				end

				arg_243_1.text_.text = var_246_34
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116291", "116291059", "story_v_out_116291.awb") ~= 0 then
					local var_246_38 = manager.audio:GetVoiceLength("story_v_out_116291", "116291059", "story_v_out_116291.awb") / 1000

					if var_246_38 + var_246_30 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_38 + var_246_30
					end

					if var_246_33.prefab_name ~= "" and arg_243_1.actors_[var_246_33.prefab_name] ~= nil then
						local var_246_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_243_1.actors_[var_246_33.prefab_name].transform, "story_v_out_116291", "116291059", "story_v_out_116291.awb")

						arg_243_1:RecordAudio("116291059", var_246_39)
						arg_243_1:RecordAudio("116291059", var_246_39)
					else
						arg_243_1:AudioAction("play", "voice", "story_v_out_116291", "116291059", "story_v_out_116291.awb")
					end

					arg_243_1:RecordHistoryTalkVoice("story_v_out_116291", "116291059", "story_v_out_116291.awb")
				end

				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_40 = math.max(var_246_31, arg_243_1.talkMaxDuration)

			if var_246_30 <= arg_243_1.time_ and arg_243_1.time_ < var_246_30 + var_246_40 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_30) / var_246_40

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_30 + var_246_40 and arg_243_1.time_ < var_246_30 + var_246_40 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_243_1:InitPlayNodeList()
	end,
	Play116291060 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 116291060
		arg_247_1.duration_ = 7.03

		local var_247_0 = {
			zh = 3.7,
			ja = 7.033
		}
		local var_247_1 = manager.audio:GetLocalizationFlag()

		if var_247_0[var_247_1] ~= nil then
			arg_247_1.duration_ = var_247_0[var_247_1]
		end

		SetActive(arg_247_1.tipsGo_, false)

		function arg_247_1.onSingleLineFinish_()
			arg_247_1.onSingleLineUpdate_ = nil
			arg_247_1.onSingleLineFinish_ = nil
			arg_247_1.state_ = "waiting"
		end

		function arg_247_1.playNext_(arg_249_0)
			if arg_249_0 == 1 then
				arg_247_0:Play116291061(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			local var_250_0 = 0

			if var_250_0 < arg_247_1.time_ and arg_247_1.time_ <= var_250_0 + arg_250_0 then
				arg_247_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_250_1 = 0
			local var_250_2 = 0.35

			if var_250_1 < arg_247_1.time_ and arg_247_1.time_ <= var_250_1 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				local var_250_3 = arg_247_1:FormatText(StoryNameCfg[28].name)

				arg_247_1.leftNameTxt_.text = var_250_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_4 = arg_247_1:GetWordFromCfg(116291060)
				local var_250_5 = arg_247_1:FormatText(var_250_4.content)

				arg_247_1.text_.text = var_250_5

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_6 = 14
				local var_250_7 = utf8.len(var_250_5)
				local var_250_8 = var_250_6 <= 0 and var_250_2 or var_250_2 * (var_250_7 / var_250_6)

				if var_250_8 > 0 and var_250_2 < var_250_8 then
					arg_247_1.talkMaxDuration = var_250_8

					if var_250_8 + var_250_1 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_8 + var_250_1
					end
				end

				arg_247_1.text_.text = var_250_5
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116291", "116291060", "story_v_out_116291.awb") ~= 0 then
					local var_250_9 = manager.audio:GetVoiceLength("story_v_out_116291", "116291060", "story_v_out_116291.awb") / 1000

					if var_250_9 + var_250_1 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_9 + var_250_1
					end

					if var_250_4.prefab_name ~= "" and arg_247_1.actors_[var_250_4.prefab_name] ~= nil then
						local var_250_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_4.prefab_name].transform, "story_v_out_116291", "116291060", "story_v_out_116291.awb")

						arg_247_1:RecordAudio("116291060", var_250_10)
						arg_247_1:RecordAudio("116291060", var_250_10)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_out_116291", "116291060", "story_v_out_116291.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_out_116291", "116291060", "story_v_out_116291.awb")
				end

				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_11 = math.max(var_250_2, arg_247_1.talkMaxDuration)

			if var_250_1 <= arg_247_1.time_ and arg_247_1.time_ < var_250_1 + var_250_11 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_1) / var_250_11

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_1 + var_250_11 and arg_247_1.time_ < var_250_1 + var_250_11 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {}

		arg_247_1:InitPlayNodeList()
	end,
	Play116291061 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 116291061
		arg_251_1.duration_ = 3.2

		local var_251_0 = {
			zh = 3.2,
			ja = 2.633333333332
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
				arg_251_0:Play116291062(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			local var_254_0 = arg_251_1.actors_["1059ui_story"]
			local var_254_1 = 0

			if var_254_1 < arg_251_1.time_ and arg_251_1.time_ <= var_254_1 + arg_254_0 and not isNil(var_254_0) and arg_251_1.var_.characterEffect1059ui_story == nil then
				arg_251_1.var_.characterEffect1059ui_story = var_254_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_254_2 = 0.2

			if var_254_1 <= arg_251_1.time_ and arg_251_1.time_ < var_254_1 + var_254_2 and not isNil(var_254_0) then
				local var_254_3 = (arg_251_1.time_ - var_254_1) / var_254_2

				if arg_251_1.var_.characterEffect1059ui_story and not isNil(var_254_0) then
					local var_254_4 = Mathf.Lerp(0, 0.5, var_254_3)

					arg_251_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_251_1.var_.characterEffect1059ui_story.fillRatio = var_254_4
				end
			end

			if arg_251_1.time_ >= var_254_1 + var_254_2 and arg_251_1.time_ < var_254_1 + var_254_2 + arg_254_0 and not isNil(var_254_0) and arg_251_1.var_.characterEffect1059ui_story then
				local var_254_5 = 0.5

				arg_251_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_251_1.var_.characterEffect1059ui_story.fillRatio = var_254_5
			end

			local var_254_6 = arg_251_1.actors_["1028ui_story"]
			local var_254_7 = 0

			if var_254_7 < arg_251_1.time_ and arg_251_1.time_ <= var_254_7 + arg_254_0 and not isNil(var_254_6) and arg_251_1.var_.characterEffect1028ui_story == nil then
				arg_251_1.var_.characterEffect1028ui_story = var_254_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_254_8 = 0.2

			if var_254_7 <= arg_251_1.time_ and arg_251_1.time_ < var_254_7 + var_254_8 and not isNil(var_254_6) then
				local var_254_9 = (arg_251_1.time_ - var_254_7) / var_254_8

				if arg_251_1.var_.characterEffect1028ui_story and not isNil(var_254_6) then
					arg_251_1.var_.characterEffect1028ui_story.fillFlat = false
				end
			end

			if arg_251_1.time_ >= var_254_7 + var_254_8 and arg_251_1.time_ < var_254_7 + var_254_8 + arg_254_0 and not isNil(var_254_6) and arg_251_1.var_.characterEffect1028ui_story then
				arg_251_1.var_.characterEffect1028ui_story.fillFlat = false
			end

			local var_254_10 = 0

			if var_254_10 < arg_251_1.time_ and arg_251_1.time_ <= var_254_10 + arg_254_0 then
				arg_251_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/story1028/story1028action/1028action7_1")
			end

			local var_254_11 = 0

			if var_254_11 < arg_251_1.time_ and arg_251_1.time_ <= var_254_11 + arg_254_0 then
				arg_251_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_254_12 = arg_251_1.actors_["1028ui_story"].transform
			local var_254_13 = 0

			if var_254_13 < arg_251_1.time_ and arg_251_1.time_ <= var_254_13 + arg_254_0 then
				arg_251_1.var_.moveOldPos1028ui_story = var_254_12.localPosition

				local var_254_14 = "1028ui_story"

				arg_251_1:ShowWeapon(arg_251_1.var_[var_254_14 .. "Animator"].transform, false)
			end

			local var_254_15 = 0.001

			if var_254_13 <= arg_251_1.time_ and arg_251_1.time_ < var_254_13 + var_254_15 then
				local var_254_16 = (arg_251_1.time_ - var_254_13) / var_254_15
				local var_254_17 = Vector3.New(-0.7, -0.9, -5.9)

				var_254_12.localPosition = Vector3.Lerp(arg_251_1.var_.moveOldPos1028ui_story, var_254_17, var_254_16)

				local var_254_18 = manager.ui.mainCamera.transform.position - var_254_12.position

				var_254_12.forward = Vector3.New(var_254_18.x, var_254_18.y, var_254_18.z)

				local var_254_19 = var_254_12.localEulerAngles

				var_254_19.z = 0
				var_254_19.x = 0
				var_254_12.localEulerAngles = var_254_19
			end

			if arg_251_1.time_ >= var_254_13 + var_254_15 and arg_251_1.time_ < var_254_13 + var_254_15 + arg_254_0 then
				var_254_12.localPosition = Vector3.New(-0.7, -0.9, -5.9)

				local var_254_20 = manager.ui.mainCamera.transform.position - var_254_12.position

				var_254_12.forward = Vector3.New(var_254_20.x, var_254_20.y, var_254_20.z)

				local var_254_21 = var_254_12.localEulerAngles

				var_254_21.z = 0
				var_254_21.x = 0
				var_254_12.localEulerAngles = var_254_21
			end

			local var_254_22 = 0
			local var_254_23 = 0.15

			if var_254_22 < arg_251_1.time_ and arg_251_1.time_ <= var_254_22 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				local var_254_24 = arg_251_1:FormatText(StoryNameCfg[327].name)

				arg_251_1.leftNameTxt_.text = var_254_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, false)
				arg_251_1.callingController_:SetSelectedState("normal")

				local var_254_25 = arg_251_1:GetWordFromCfg(116291061)
				local var_254_26 = arg_251_1:FormatText(var_254_25.content)

				arg_251_1.text_.text = var_254_26

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_27 = 6
				local var_254_28 = utf8.len(var_254_26)
				local var_254_29 = var_254_27 <= 0 and var_254_23 or var_254_23 * (var_254_28 / var_254_27)

				if var_254_29 > 0 and var_254_23 < var_254_29 then
					arg_251_1.talkMaxDuration = var_254_29

					if var_254_29 + var_254_22 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_29 + var_254_22
					end
				end

				arg_251_1.text_.text = var_254_26
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116291", "116291061", "story_v_out_116291.awb") ~= 0 then
					local var_254_30 = manager.audio:GetVoiceLength("story_v_out_116291", "116291061", "story_v_out_116291.awb") / 1000

					if var_254_30 + var_254_22 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_30 + var_254_22
					end

					if var_254_25.prefab_name ~= "" and arg_251_1.actors_[var_254_25.prefab_name] ~= nil then
						local var_254_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_251_1.actors_[var_254_25.prefab_name].transform, "story_v_out_116291", "116291061", "story_v_out_116291.awb")

						arg_251_1:RecordAudio("116291061", var_254_31)
						arg_251_1:RecordAudio("116291061", var_254_31)
					else
						arg_251_1:AudioAction("play", "voice", "story_v_out_116291", "116291061", "story_v_out_116291.awb")
					end

					arg_251_1:RecordHistoryTalkVoice("story_v_out_116291", "116291061", "story_v_out_116291.awb")
				end

				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_32 = math.max(var_254_23, arg_251_1.talkMaxDuration)

			if var_254_22 <= arg_251_1.time_ and arg_251_1.time_ < var_254_22 + var_254_32 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_22) / var_254_32

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_22 + var_254_32 and arg_251_1.time_ < var_254_22 + var_254_32 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_251_1:InitPlayNodeList()
	end,
	Play116291062 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 116291062
		arg_255_1.duration_ = 5

		SetActive(arg_255_1.tipsGo_, false)

		function arg_255_1.onSingleLineFinish_()
			arg_255_1.onSingleLineUpdate_ = nil
			arg_255_1.onSingleLineFinish_ = nil
			arg_255_1.state_ = "waiting"
		end

		function arg_255_1.playNext_(arg_257_0)
			if arg_257_0 == 1 then
				arg_255_0:Play116291063(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			local var_258_0 = arg_255_1.actors_["1028ui_story"].transform
			local var_258_1 = 0

			if var_258_1 < arg_255_1.time_ and arg_255_1.time_ <= var_258_1 + arg_258_0 then
				arg_255_1.var_.moveOldPos1028ui_story = var_258_0.localPosition
			end

			local var_258_2 = 0.001

			if var_258_1 <= arg_255_1.time_ and arg_255_1.time_ < var_258_1 + var_258_2 then
				local var_258_3 = (arg_255_1.time_ - var_258_1) / var_258_2
				local var_258_4 = Vector3.New(0, 100, 0)

				var_258_0.localPosition = Vector3.Lerp(arg_255_1.var_.moveOldPos1028ui_story, var_258_4, var_258_3)

				local var_258_5 = manager.ui.mainCamera.transform.position - var_258_0.position

				var_258_0.forward = Vector3.New(var_258_5.x, var_258_5.y, var_258_5.z)

				local var_258_6 = var_258_0.localEulerAngles

				var_258_6.z = 0
				var_258_6.x = 0
				var_258_0.localEulerAngles = var_258_6
			end

			if arg_255_1.time_ >= var_258_1 + var_258_2 and arg_255_1.time_ < var_258_1 + var_258_2 + arg_258_0 then
				var_258_0.localPosition = Vector3.New(0, 100, 0)

				local var_258_7 = manager.ui.mainCamera.transform.position - var_258_0.position

				var_258_0.forward = Vector3.New(var_258_7.x, var_258_7.y, var_258_7.z)

				local var_258_8 = var_258_0.localEulerAngles

				var_258_8.z = 0
				var_258_8.x = 0
				var_258_0.localEulerAngles = var_258_8
			end

			local var_258_9 = arg_255_1.actors_["1059ui_story"].transform
			local var_258_10 = 0

			if var_258_10 < arg_255_1.time_ and arg_255_1.time_ <= var_258_10 + arg_258_0 then
				arg_255_1.var_.moveOldPos1059ui_story = var_258_9.localPosition
			end

			local var_258_11 = 0.001

			if var_258_10 <= arg_255_1.time_ and arg_255_1.time_ < var_258_10 + var_258_11 then
				local var_258_12 = (arg_255_1.time_ - var_258_10) / var_258_11
				local var_258_13 = Vector3.New(0, 100, 0)

				var_258_9.localPosition = Vector3.Lerp(arg_255_1.var_.moveOldPos1059ui_story, var_258_13, var_258_12)

				local var_258_14 = manager.ui.mainCamera.transform.position - var_258_9.position

				var_258_9.forward = Vector3.New(var_258_14.x, var_258_14.y, var_258_14.z)

				local var_258_15 = var_258_9.localEulerAngles

				var_258_15.z = 0
				var_258_15.x = 0
				var_258_9.localEulerAngles = var_258_15
			end

			if arg_255_1.time_ >= var_258_10 + var_258_11 and arg_255_1.time_ < var_258_10 + var_258_11 + arg_258_0 then
				var_258_9.localPosition = Vector3.New(0, 100, 0)

				local var_258_16 = manager.ui.mainCamera.transform.position - var_258_9.position

				var_258_9.forward = Vector3.New(var_258_16.x, var_258_16.y, var_258_16.z)

				local var_258_17 = var_258_9.localEulerAngles

				var_258_17.z = 0
				var_258_17.x = 0
				var_258_9.localEulerAngles = var_258_17
			end

			local var_258_18 = 0
			local var_258_19 = 1.525

			if var_258_18 < arg_255_1.time_ and arg_255_1.time_ <= var_258_18 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, false)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_255_1.iconTrs_.gameObject, false)
				arg_255_1.callingController_:SetSelectedState("normal")

				local var_258_20 = arg_255_1:GetWordFromCfg(116291062)
				local var_258_21 = arg_255_1:FormatText(var_258_20.content)

				arg_255_1.text_.text = var_258_21

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_22 = 61
				local var_258_23 = utf8.len(var_258_21)
				local var_258_24 = var_258_22 <= 0 and var_258_19 or var_258_19 * (var_258_23 / var_258_22)

				if var_258_24 > 0 and var_258_19 < var_258_24 then
					arg_255_1.talkMaxDuration = var_258_24

					if var_258_24 + var_258_18 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_24 + var_258_18
					end
				end

				arg_255_1.text_.text = var_258_21
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)
				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_25 = math.max(var_258_19, arg_255_1.talkMaxDuration)

			if var_258_18 <= arg_255_1.time_ and arg_255_1.time_ < var_258_18 + var_258_25 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - var_258_18) / var_258_25

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= var_258_18 + var_258_25 and arg_255_1.time_ < var_258_18 + var_258_25 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_255_1:InitPlayNodeList()
	end,
	Play116291063 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 116291063
		arg_259_1.duration_ = 5

		SetActive(arg_259_1.tipsGo_, false)

		function arg_259_1.onSingleLineFinish_()
			arg_259_1.onSingleLineUpdate_ = nil
			arg_259_1.onSingleLineFinish_ = nil
			arg_259_1.state_ = "waiting"
		end

		function arg_259_1.playNext_(arg_261_0)
			if arg_261_0 == 1 then
				arg_259_0:Play116291064(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			local var_262_0 = 0
			local var_262_1 = 0.55

			if var_262_0 < arg_259_1.time_ and arg_259_1.time_ <= var_262_0 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, false)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_259_1.iconTrs_.gameObject, false)
				arg_259_1.callingController_:SetSelectedState("normal")

				local var_262_2 = arg_259_1:GetWordFromCfg(116291063)
				local var_262_3 = arg_259_1:FormatText(var_262_2.content)

				arg_259_1.text_.text = var_262_3

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_4 = 22
				local var_262_5 = utf8.len(var_262_3)
				local var_262_6 = var_262_4 <= 0 and var_262_1 or var_262_1 * (var_262_5 / var_262_4)

				if var_262_6 > 0 and var_262_1 < var_262_6 then
					arg_259_1.talkMaxDuration = var_262_6

					if var_262_6 + var_262_0 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_6 + var_262_0
					end
				end

				arg_259_1.text_.text = var_262_3
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)
				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_7 = math.max(var_262_1, arg_259_1.talkMaxDuration)

			if var_262_0 <= arg_259_1.time_ and arg_259_1.time_ < var_262_0 + var_262_7 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - var_262_0) / var_262_7

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= var_262_0 + var_262_7 and arg_259_1.time_ < var_262_0 + var_262_7 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {}

		arg_259_1:InitPlayNodeList()
	end,
	Play116291064 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 116291064
		arg_263_1.duration_ = 3.27

		local var_263_0 = {
			zh = 2.399999999999,
			ja = 3.266
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
				arg_263_0:Play116291065(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			local var_266_0 = arg_263_1.actors_["1059ui_story"].transform
			local var_266_1 = 0

			if var_266_1 < arg_263_1.time_ and arg_263_1.time_ <= var_266_1 + arg_266_0 then
				arg_263_1.var_.moveOldPos1059ui_story = var_266_0.localPosition
			end

			local var_266_2 = 0.001

			if var_266_1 <= arg_263_1.time_ and arg_263_1.time_ < var_266_1 + var_266_2 then
				local var_266_3 = (arg_263_1.time_ - var_266_1) / var_266_2
				local var_266_4 = Vector3.New(-0.7, -1.05, -6)

				var_266_0.localPosition = Vector3.Lerp(arg_263_1.var_.moveOldPos1059ui_story, var_266_4, var_266_3)

				local var_266_5 = manager.ui.mainCamera.transform.position - var_266_0.position

				var_266_0.forward = Vector3.New(var_266_5.x, var_266_5.y, var_266_5.z)

				local var_266_6 = var_266_0.localEulerAngles

				var_266_6.z = 0
				var_266_6.x = 0
				var_266_0.localEulerAngles = var_266_6
			end

			if arg_263_1.time_ >= var_266_1 + var_266_2 and arg_263_1.time_ < var_266_1 + var_266_2 + arg_266_0 then
				var_266_0.localPosition = Vector3.New(-0.7, -1.05, -6)

				local var_266_7 = manager.ui.mainCamera.transform.position - var_266_0.position

				var_266_0.forward = Vector3.New(var_266_7.x, var_266_7.y, var_266_7.z)

				local var_266_8 = var_266_0.localEulerAngles

				var_266_8.z = 0
				var_266_8.x = 0
				var_266_0.localEulerAngles = var_266_8
			end

			local var_266_9 = arg_263_1.actors_["1059ui_story"]
			local var_266_10 = 0

			if var_266_10 < arg_263_1.time_ and arg_263_1.time_ <= var_266_10 + arg_266_0 and not isNil(var_266_9) and arg_263_1.var_.characterEffect1059ui_story == nil then
				arg_263_1.var_.characterEffect1059ui_story = var_266_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_266_11 = 0.2

			if var_266_10 <= arg_263_1.time_ and arg_263_1.time_ < var_266_10 + var_266_11 and not isNil(var_266_9) then
				local var_266_12 = (arg_263_1.time_ - var_266_10) / var_266_11

				if arg_263_1.var_.characterEffect1059ui_story and not isNil(var_266_9) then
					arg_263_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_263_1.time_ >= var_266_10 + var_266_11 and arg_263_1.time_ < var_266_10 + var_266_11 + arg_266_0 and not isNil(var_266_9) and arg_263_1.var_.characterEffect1059ui_story then
				arg_263_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_266_13 = 0

			if var_266_13 < arg_263_1.time_ and arg_263_1.time_ <= var_266_13 + arg_266_0 then
				arg_263_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action6_1")
			end

			local var_266_14 = 0

			if var_266_14 < arg_263_1.time_ and arg_263_1.time_ <= var_266_14 + arg_266_0 then
				arg_263_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_266_15 = 0
			local var_266_16 = 0.2

			if var_266_15 < arg_263_1.time_ and arg_263_1.time_ <= var_266_15 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, true)

				local var_266_17 = arg_263_1:FormatText(StoryNameCfg[28].name)

				arg_263_1.leftNameTxt_.text = var_266_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_263_1.leftNameTxt_.transform)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1.leftNameTxt_.text)
				SetActive(arg_263_1.iconTrs_.gameObject, false)
				arg_263_1.callingController_:SetSelectedState("normal")

				local var_266_18 = arg_263_1:GetWordFromCfg(116291064)
				local var_266_19 = arg_263_1:FormatText(var_266_18.content)

				arg_263_1.text_.text = var_266_19

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_20 = 8
				local var_266_21 = utf8.len(var_266_19)
				local var_266_22 = var_266_20 <= 0 and var_266_16 or var_266_16 * (var_266_21 / var_266_20)

				if var_266_22 > 0 and var_266_16 < var_266_22 then
					arg_263_1.talkMaxDuration = var_266_22

					if var_266_22 + var_266_15 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_22 + var_266_15
					end
				end

				arg_263_1.text_.text = var_266_19
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116291", "116291064", "story_v_out_116291.awb") ~= 0 then
					local var_266_23 = manager.audio:GetVoiceLength("story_v_out_116291", "116291064", "story_v_out_116291.awb") / 1000

					if var_266_23 + var_266_15 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_23 + var_266_15
					end

					if var_266_18.prefab_name ~= "" and arg_263_1.actors_[var_266_18.prefab_name] ~= nil then
						local var_266_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_263_1.actors_[var_266_18.prefab_name].transform, "story_v_out_116291", "116291064", "story_v_out_116291.awb")

						arg_263_1:RecordAudio("116291064", var_266_24)
						arg_263_1:RecordAudio("116291064", var_266_24)
					else
						arg_263_1:AudioAction("play", "voice", "story_v_out_116291", "116291064", "story_v_out_116291.awb")
					end

					arg_263_1:RecordHistoryTalkVoice("story_v_out_116291", "116291064", "story_v_out_116291.awb")
				end

				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_25 = math.max(var_266_16, arg_263_1.talkMaxDuration)

			if var_266_15 <= arg_263_1.time_ and arg_263_1.time_ < var_266_15 + var_266_25 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - var_266_15) / var_266_25

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= var_266_15 + var_266_25 and arg_263_1.time_ < var_266_15 + var_266_25 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_263_1:InitPlayNodeList()
	end,
	Play116291065 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 116291065
		arg_267_1.duration_ = 5.73

		local var_267_0 = {
			zh = 4.4,
			ja = 5.733
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
				arg_267_0:Play116291066(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			local var_270_0 = arg_267_1.actors_["1148ui_story"].transform
			local var_270_1 = 0

			if var_270_1 < arg_267_1.time_ and arg_267_1.time_ <= var_270_1 + arg_270_0 then
				arg_267_1.var_.moveOldPos1148ui_story = var_270_0.localPosition
			end

			local var_270_2 = 0.001

			if var_270_1 <= arg_267_1.time_ and arg_267_1.time_ < var_270_1 + var_270_2 then
				local var_270_3 = (arg_267_1.time_ - var_270_1) / var_270_2
				local var_270_4 = Vector3.New(0.7, -0.8, -6.2)

				var_270_0.localPosition = Vector3.Lerp(arg_267_1.var_.moveOldPos1148ui_story, var_270_4, var_270_3)

				local var_270_5 = manager.ui.mainCamera.transform.position - var_270_0.position

				var_270_0.forward = Vector3.New(var_270_5.x, var_270_5.y, var_270_5.z)

				local var_270_6 = var_270_0.localEulerAngles

				var_270_6.z = 0
				var_270_6.x = 0
				var_270_0.localEulerAngles = var_270_6
			end

			if arg_267_1.time_ >= var_270_1 + var_270_2 and arg_267_1.time_ < var_270_1 + var_270_2 + arg_270_0 then
				var_270_0.localPosition = Vector3.New(0.7, -0.8, -6.2)

				local var_270_7 = manager.ui.mainCamera.transform.position - var_270_0.position

				var_270_0.forward = Vector3.New(var_270_7.x, var_270_7.y, var_270_7.z)

				local var_270_8 = var_270_0.localEulerAngles

				var_270_8.z = 0
				var_270_8.x = 0
				var_270_0.localEulerAngles = var_270_8
			end

			local var_270_9 = arg_267_1.actors_["1059ui_story"]
			local var_270_10 = 0

			if var_270_10 < arg_267_1.time_ and arg_267_1.time_ <= var_270_10 + arg_270_0 and not isNil(var_270_9) and arg_267_1.var_.characterEffect1059ui_story == nil then
				arg_267_1.var_.characterEffect1059ui_story = var_270_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_270_11 = 0.2

			if var_270_10 <= arg_267_1.time_ and arg_267_1.time_ < var_270_10 + var_270_11 and not isNil(var_270_9) then
				local var_270_12 = (arg_267_1.time_ - var_270_10) / var_270_11

				if arg_267_1.var_.characterEffect1059ui_story and not isNil(var_270_9) then
					local var_270_13 = Mathf.Lerp(0, 0.5, var_270_12)

					arg_267_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_267_1.var_.characterEffect1059ui_story.fillRatio = var_270_13
				end
			end

			if arg_267_1.time_ >= var_270_10 + var_270_11 and arg_267_1.time_ < var_270_10 + var_270_11 + arg_270_0 and not isNil(var_270_9) and arg_267_1.var_.characterEffect1059ui_story then
				local var_270_14 = 0.5

				arg_267_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_267_1.var_.characterEffect1059ui_story.fillRatio = var_270_14
			end

			local var_270_15 = 0

			if var_270_15 < arg_267_1.time_ and arg_267_1.time_ <= var_270_15 + arg_270_0 then
				arg_267_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action3_1")
			end

			local var_270_16 = 0

			if var_270_16 < arg_267_1.time_ and arg_267_1.time_ <= var_270_16 + arg_270_0 then
				arg_267_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_270_17 = arg_267_1.actors_["1148ui_story"]
			local var_270_18 = 0

			if var_270_18 < arg_267_1.time_ and arg_267_1.time_ <= var_270_18 + arg_270_0 and not isNil(var_270_17) and arg_267_1.var_.characterEffect1148ui_story == nil then
				arg_267_1.var_.characterEffect1148ui_story = var_270_17:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_270_19 = 0.2

			if var_270_18 <= arg_267_1.time_ and arg_267_1.time_ < var_270_18 + var_270_19 and not isNil(var_270_17) then
				local var_270_20 = (arg_267_1.time_ - var_270_18) / var_270_19

				if arg_267_1.var_.characterEffect1148ui_story and not isNil(var_270_17) then
					arg_267_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_267_1.time_ >= var_270_18 + var_270_19 and arg_267_1.time_ < var_270_18 + var_270_19 + arg_270_0 and not isNil(var_270_17) and arg_267_1.var_.characterEffect1148ui_story then
				arg_267_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_270_21 = 0
			local var_270_22 = 0.525

			if var_270_21 < arg_267_1.time_ and arg_267_1.time_ <= var_270_21 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, true)

				local var_270_23 = arg_267_1:FormatText(StoryNameCfg[8].name)

				arg_267_1.leftNameTxt_.text = var_270_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_267_1.leftNameTxt_.transform)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1.leftNameTxt_.text)
				SetActive(arg_267_1.iconTrs_.gameObject, false)
				arg_267_1.callingController_:SetSelectedState("normal")

				local var_270_24 = arg_267_1:GetWordFromCfg(116291065)
				local var_270_25 = arg_267_1:FormatText(var_270_24.content)

				arg_267_1.text_.text = var_270_25

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_26 = 22
				local var_270_27 = utf8.len(var_270_25)
				local var_270_28 = var_270_26 <= 0 and var_270_22 or var_270_22 * (var_270_27 / var_270_26)

				if var_270_28 > 0 and var_270_22 < var_270_28 then
					arg_267_1.talkMaxDuration = var_270_28

					if var_270_28 + var_270_21 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_28 + var_270_21
					end
				end

				arg_267_1.text_.text = var_270_25
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116291", "116291065", "story_v_out_116291.awb") ~= 0 then
					local var_270_29 = manager.audio:GetVoiceLength("story_v_out_116291", "116291065", "story_v_out_116291.awb") / 1000

					if var_270_29 + var_270_21 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_29 + var_270_21
					end

					if var_270_24.prefab_name ~= "" and arg_267_1.actors_[var_270_24.prefab_name] ~= nil then
						local var_270_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_267_1.actors_[var_270_24.prefab_name].transform, "story_v_out_116291", "116291065", "story_v_out_116291.awb")

						arg_267_1:RecordAudio("116291065", var_270_30)
						arg_267_1:RecordAudio("116291065", var_270_30)
					else
						arg_267_1:AudioAction("play", "voice", "story_v_out_116291", "116291065", "story_v_out_116291.awb")
					end

					arg_267_1:RecordHistoryTalkVoice("story_v_out_116291", "116291065", "story_v_out_116291.awb")
				end

				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_31 = math.max(var_270_22, arg_267_1.talkMaxDuration)

			if var_270_21 <= arg_267_1.time_ and arg_267_1.time_ < var_270_21 + var_270_31 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - var_270_21) / var_270_31

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= var_270_21 + var_270_31 and arg_267_1.time_ < var_270_21 + var_270_31 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_267_1:InitPlayNodeList()
	end,
	Play116291066 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 116291066
		arg_271_1.duration_ = 3.9

		local var_271_0 = {
			zh = 3.266,
			ja = 3.9
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
			arg_271_1.auto_ = false
		end

		function arg_271_1.playNext_(arg_273_0)
			arg_271_1.onStoryFinished_()
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			local var_274_0 = arg_271_1.actors_["1148ui_story"]
			local var_274_1 = 0

			if var_274_1 < arg_271_1.time_ and arg_271_1.time_ <= var_274_1 + arg_274_0 and not isNil(var_274_0) and arg_271_1.var_.characterEffect1148ui_story == nil then
				arg_271_1.var_.characterEffect1148ui_story = var_274_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_274_2 = 0.2

			if var_274_1 <= arg_271_1.time_ and arg_271_1.time_ < var_274_1 + var_274_2 and not isNil(var_274_0) then
				local var_274_3 = (arg_271_1.time_ - var_274_1) / var_274_2

				if arg_271_1.var_.characterEffect1148ui_story and not isNil(var_274_0) then
					local var_274_4 = Mathf.Lerp(0, 0.5, var_274_3)

					arg_271_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_271_1.var_.characterEffect1148ui_story.fillRatio = var_274_4
				end
			end

			if arg_271_1.time_ >= var_274_1 + var_274_2 and arg_271_1.time_ < var_274_1 + var_274_2 + arg_274_0 and not isNil(var_274_0) and arg_271_1.var_.characterEffect1148ui_story then
				local var_274_5 = 0.5

				arg_271_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_271_1.var_.characterEffect1148ui_story.fillRatio = var_274_5
			end

			local var_274_6 = arg_271_1.actors_["1059ui_story"]
			local var_274_7 = 0

			if var_274_7 < arg_271_1.time_ and arg_271_1.time_ <= var_274_7 + arg_274_0 and not isNil(var_274_6) and arg_271_1.var_.characterEffect1059ui_story == nil then
				arg_271_1.var_.characterEffect1059ui_story = var_274_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_274_8 = 0.2

			if var_274_7 <= arg_271_1.time_ and arg_271_1.time_ < var_274_7 + var_274_8 and not isNil(var_274_6) then
				local var_274_9 = (arg_271_1.time_ - var_274_7) / var_274_8

				if arg_271_1.var_.characterEffect1059ui_story and not isNil(var_274_6) then
					arg_271_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_271_1.time_ >= var_274_7 + var_274_8 and arg_271_1.time_ < var_274_7 + var_274_8 + arg_274_0 and not isNil(var_274_6) and arg_271_1.var_.characterEffect1059ui_story then
				arg_271_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_274_10 = 0

			if var_274_10 < arg_271_1.time_ and arg_271_1.time_ <= var_274_10 + arg_274_0 then
				arg_271_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059actionlink/1059action463")
			end

			local var_274_11 = 0

			if var_274_11 < arg_271_1.time_ and arg_271_1.time_ <= var_274_11 + arg_274_0 then
				arg_271_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0203cva")
			end

			local var_274_12 = 0
			local var_274_13 = 0.4

			if var_274_12 < arg_271_1.time_ and arg_271_1.time_ <= var_274_12 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, true)

				local var_274_14 = arg_271_1:FormatText(StoryNameCfg[28].name)

				arg_271_1.leftNameTxt_.text = var_274_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_271_1.leftNameTxt_.transform)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1.leftNameTxt_.text)
				SetActive(arg_271_1.iconTrs_.gameObject, false)
				arg_271_1.callingController_:SetSelectedState("normal")

				local var_274_15 = arg_271_1:GetWordFromCfg(116291066)
				local var_274_16 = arg_271_1:FormatText(var_274_15.content)

				arg_271_1.text_.text = var_274_16

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_17 = 16
				local var_274_18 = utf8.len(var_274_16)
				local var_274_19 = var_274_17 <= 0 and var_274_13 or var_274_13 * (var_274_18 / var_274_17)

				if var_274_19 > 0 and var_274_13 < var_274_19 then
					arg_271_1.talkMaxDuration = var_274_19

					if var_274_19 + var_274_12 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_19 + var_274_12
					end
				end

				arg_271_1.text_.text = var_274_16
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116291", "116291066", "story_v_out_116291.awb") ~= 0 then
					local var_274_20 = manager.audio:GetVoiceLength("story_v_out_116291", "116291066", "story_v_out_116291.awb") / 1000

					if var_274_20 + var_274_12 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_20 + var_274_12
					end

					if var_274_15.prefab_name ~= "" and arg_271_1.actors_[var_274_15.prefab_name] ~= nil then
						local var_274_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_271_1.actors_[var_274_15.prefab_name].transform, "story_v_out_116291", "116291066", "story_v_out_116291.awb")

						arg_271_1:RecordAudio("116291066", var_274_21)
						arg_271_1:RecordAudio("116291066", var_274_21)
					else
						arg_271_1:AudioAction("play", "voice", "story_v_out_116291", "116291066", "story_v_out_116291.awb")
					end

					arg_271_1:RecordHistoryTalkVoice("story_v_out_116291", "116291066", "story_v_out_116291.awb")
				end

				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_22 = math.max(var_274_13, arg_271_1.talkMaxDuration)

			if var_274_12 <= arg_271_1.time_ and arg_271_1.time_ < var_274_12 + var_274_22 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - var_274_12) / var_274_22

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= var_274_12 + var_274_22 and arg_271_1.time_ < var_274_12 + var_274_22 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {}

		arg_271_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/I03",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/B13",
		"TextureConfig/Background/B13e",
		"TextureConfig/Background/B13c"
	},
	voices = {
		"story_v_out_116291.awb"
	}
}
