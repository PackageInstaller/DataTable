return {
	Play106122001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 106122001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play106122002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "C01b"

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
				local var_4_5 = arg_1_1.bgs_.C01b

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
					if iter_4_0 ~= "C01b" then
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
			local var_4_23 = 1

			if var_4_22 < arg_1_1.time_ and arg_1_1.time_ <= var_4_22 + arg_4_0 then
				local var_4_24 = "play"
				local var_4_25 = "music"

				arg_1_1:AudioAction(var_4_24, var_4_25, "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1.awb")

				local var_4_26 = ""
				local var_4_27 = manager.audio:GetAudioName("bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1")

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

			local var_4_28 = 0

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_29 = 2

			if arg_1_1.time_ >= var_4_28 + var_4_29 and arg_1_1.time_ < var_4_28 + var_4_29 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_30 = 2
			local var_4_31 = 1.225

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_32 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_32:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_32:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_32:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_33 = arg_1_1:GetWordFromCfg(106122001)
				local var_4_34 = arg_1_1:FormatText(var_4_33.content)

				arg_1_1.text_.text = var_4_34

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_35 = 49
				local var_4_36 = utf8.len(var_4_34)
				local var_4_37 = var_4_35 <= 0 and var_4_31 or var_4_31 * (var_4_36 / var_4_35)

				if var_4_37 > 0 and var_4_31 < var_4_37 then
					arg_1_1.talkMaxDuration = var_4_37
					var_4_30 = var_4_30 + 0.3

					if var_4_37 + var_4_30 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_37 + var_4_30
					end
				end

				arg_1_1.text_.text = var_4_34
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_38 = var_4_30 + 0.3
			local var_4_39 = math.max(var_4_31, arg_1_1.talkMaxDuration)

			if var_4_38 <= arg_1_1.time_ and arg_1_1.time_ < var_4_38 + var_4_39 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_38) / var_4_39

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_38 + var_4_39 and arg_1_1.time_ < var_4_38 + var_4_39 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play106122002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 106122002
		arg_8_1.duration_ = 6.93

		local var_8_0 = {
			ja = 4.333,
			ko = 5.6,
			zh = 4.833,
			en = 6.933
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
				arg_8_0:Play106122003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = "4014_tpose"

			if arg_8_1.actors_[var_11_0] == nil then
				local var_11_1 = Asset.Load("Char/" .. "4014_tpose")

				if not isNil(var_11_1) then
					local var_11_2 = Object.Instantiate(Asset.Load("Char/" .. "4014_tpose"), arg_8_1.stage_.transform)

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

			local var_11_5 = arg_8_1.actors_["4014_tpose"]
			local var_11_6 = 0

			if var_11_6 < arg_8_1.time_ and arg_8_1.time_ <= var_11_6 + arg_11_0 and not isNil(var_11_5) and arg_8_1.var_.characterEffect4014_tpose == nil then
				arg_8_1.var_.characterEffect4014_tpose = var_11_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_7 = 0.1

			if var_11_6 <= arg_8_1.time_ and arg_8_1.time_ < var_11_6 + var_11_7 and not isNil(var_11_5) then
				local var_11_8 = (arg_8_1.time_ - var_11_6) / var_11_7

				if arg_8_1.var_.characterEffect4014_tpose and not isNil(var_11_5) then
					arg_8_1.var_.characterEffect4014_tpose.fillFlat = false
				end
			end

			if arg_8_1.time_ >= var_11_6 + var_11_7 and arg_8_1.time_ < var_11_6 + var_11_7 + arg_11_0 and not isNil(var_11_5) and arg_8_1.var_.characterEffect4014_tpose then
				arg_8_1.var_.characterEffect4014_tpose.fillFlat = false
			end

			local var_11_9 = arg_8_1.actors_["4014_tpose"].transform
			local var_11_10 = 0

			if var_11_10 < arg_8_1.time_ and arg_8_1.time_ <= var_11_10 + arg_11_0 then
				arg_8_1.var_.moveOldPos4014_tpose = var_11_9.localPosition

				local var_11_11 = GameObjectTools.GetOrAddComponent(var_11_9.gameObject, typeof(DynamicBoneHelper))

				if var_11_11 then
					var_11_11:EnableDynamicBone(false)
				end
			end

			local var_11_12 = 0.001

			if var_11_10 <= arg_8_1.time_ and arg_8_1.time_ < var_11_10 + var_11_12 then
				local var_11_13 = (arg_8_1.time_ - var_11_10) / var_11_12
				local var_11_14 = Vector3.New(0, -1.95, -4.2)

				var_11_9.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos4014_tpose, var_11_14, var_11_13)

				local var_11_15 = manager.ui.mainCamera.transform.position - var_11_9.position

				var_11_9.forward = Vector3.New(var_11_15.x, var_11_15.y, var_11_15.z)

				local var_11_16 = var_11_9.localEulerAngles

				var_11_16.z = 0
				var_11_16.x = 0
				var_11_9.localEulerAngles = var_11_16
			end

			if arg_8_1.time_ >= var_11_10 + var_11_12 and arg_8_1.time_ < var_11_10 + var_11_12 + arg_11_0 then
				var_11_9.localPosition = Vector3.New(0, -1.95, -4.2)

				local var_11_17 = manager.ui.mainCamera.transform.position - var_11_9.position

				var_11_9.forward = Vector3.New(var_11_17.x, var_11_17.y, var_11_17.z)

				local var_11_18 = var_11_9.localEulerAngles

				var_11_18.z = 0
				var_11_18.x = 0
				var_11_9.localEulerAngles = var_11_18

				local var_11_19 = GameObjectTools.GetOrAddComponent(var_11_9.gameObject, typeof(DynamicBoneHelper))

				if var_11_19 then
					var_11_19:EnableDynamicBone(true)
				end
			end

			local var_11_20 = 0

			if var_11_20 < arg_8_1.time_ and arg_8_1.time_ <= var_11_20 + arg_11_0 then
				arg_8_1:PlayTimeline("4014_tpose", "StoryTimeline/CharAction/story4014/story4014action/4014action1_1")
			end

			local var_11_21 = 0
			local var_11_22 = 0.575

			if var_11_21 < arg_8_1.time_ and arg_8_1.time_ <= var_11_21 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				local var_11_23 = arg_8_1:FormatText(StoryNameCfg[87].name)

				arg_8_1.leftNameTxt_.text = var_11_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_24 = arg_8_1:GetWordFromCfg(106122002)
				local var_11_25 = arg_8_1:FormatText(var_11_24.content)

				arg_8_1.text_.text = var_11_25

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_26 = 23
				local var_11_27 = utf8.len(var_11_25)
				local var_11_28 = var_11_26 <= 0 and var_11_22 or var_11_22 * (var_11_27 / var_11_26)

				if var_11_28 > 0 and var_11_22 < var_11_28 then
					arg_8_1.talkMaxDuration = var_11_28

					if var_11_28 + var_11_21 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_28 + var_11_21
					end
				end

				arg_8_1.text_.text = var_11_25
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106122", "106122002", "story_v_out_106122.awb") ~= 0 then
					local var_11_29 = manager.audio:GetVoiceLength("story_v_out_106122", "106122002", "story_v_out_106122.awb") / 1000

					if var_11_29 + var_11_21 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_29 + var_11_21
					end

					if var_11_24.prefab_name ~= "" and arg_8_1.actors_[var_11_24.prefab_name] ~= nil then
						local var_11_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_24.prefab_name].transform, "story_v_out_106122", "106122002", "story_v_out_106122.awb")

						arg_8_1:RecordAudio("106122002", var_11_30)
						arg_8_1:RecordAudio("106122002", var_11_30)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_106122", "106122002", "story_v_out_106122.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_106122", "106122002", "story_v_out_106122.awb")
				end

				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_31 = math.max(var_11_22, arg_8_1.talkMaxDuration)

			if var_11_21 <= arg_8_1.time_ and arg_8_1.time_ < var_11_21 + var_11_31 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_21) / var_11_31

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_21 + var_11_31 and arg_8_1.time_ < var_11_21 + var_11_31 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4014_tpose",
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
	Play106122003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 106122003
		arg_12_1.duration_ = 11

		local var_12_0 = {
			ja = 9.733,
			ko = 11,
			zh = 7.3,
			en = 10.066
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
				arg_12_0:Play106122004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 0
			local var_15_1 = 0.775

			if var_15_0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_0 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				local var_15_2 = arg_12_1:FormatText(StoryNameCfg[87].name)

				arg_12_1.leftNameTxt_.text = var_15_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_3 = arg_12_1:GetWordFromCfg(106122003)
				local var_15_4 = arg_12_1:FormatText(var_15_3.content)

				arg_12_1.text_.text = var_15_4

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_5 = 31
				local var_15_6 = utf8.len(var_15_4)
				local var_15_7 = var_15_5 <= 0 and var_15_1 or var_15_1 * (var_15_6 / var_15_5)

				if var_15_7 > 0 and var_15_1 < var_15_7 then
					arg_12_1.talkMaxDuration = var_15_7

					if var_15_7 + var_15_0 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_7 + var_15_0
					end
				end

				arg_12_1.text_.text = var_15_4
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106122", "106122003", "story_v_out_106122.awb") ~= 0 then
					local var_15_8 = manager.audio:GetVoiceLength("story_v_out_106122", "106122003", "story_v_out_106122.awb") / 1000

					if var_15_8 + var_15_0 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_8 + var_15_0
					end

					if var_15_3.prefab_name ~= "" and arg_12_1.actors_[var_15_3.prefab_name] ~= nil then
						local var_15_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_3.prefab_name].transform, "story_v_out_106122", "106122003", "story_v_out_106122.awb")

						arg_12_1:RecordAudio("106122003", var_15_9)
						arg_12_1:RecordAudio("106122003", var_15_9)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_106122", "106122003", "story_v_out_106122.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_106122", "106122003", "story_v_out_106122.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_10 = math.max(var_15_1, arg_12_1.talkMaxDuration)

			if var_15_0 <= arg_12_1.time_ and arg_12_1.time_ < var_15_0 + var_15_10 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_0) / var_15_10

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_0 + var_15_10 and arg_12_1.time_ < var_15_0 + var_15_10 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play106122004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 106122004
		arg_16_1.duration_ = 5.8

		local var_16_0 = {
			ja = 5.8,
			ko = 5.2,
			zh = 5.133,
			en = 3.7
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
				arg_16_0:Play106122005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = "1093ui_story"

			if arg_16_1.actors_[var_19_0] == nil then
				local var_19_1 = Asset.Load("Char/" .. "1093ui_story")

				if not isNil(var_19_1) then
					local var_19_2 = Object.Instantiate(Asset.Load("Char/" .. "1093ui_story"), arg_16_1.stage_.transform)

					var_19_2.name = var_19_0
					var_19_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_16_1.actors_[var_19_0] = var_19_2

					local var_19_3 = var_19_2:GetComponentInChildren(typeof(CharacterEffect))

					var_19_3.enabled = true

					local var_19_4 = GameObjectTools.GetOrAddComponent(var_19_2, typeof(DynamicBoneHelper))

					if var_19_4 then
						var_19_4:EnableDynamicBone(false)
					end

					arg_16_1:ShowWeapon(var_19_3.transform, false)

					arg_16_1.var_[var_19_0 .. "Animator"] = var_19_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_16_1.var_[var_19_0 .. "Animator"].applyRootMotion = true
					arg_16_1.var_[var_19_0 .. "LipSync"] = var_19_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_19_5 = arg_16_1.actors_["1093ui_story"]
			local var_19_6 = 0

			if var_19_6 < arg_16_1.time_ and arg_16_1.time_ <= var_19_6 + arg_19_0 and not isNil(var_19_5) and arg_16_1.var_.characterEffect1093ui_story == nil then
				arg_16_1.var_.characterEffect1093ui_story = var_19_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_7 = 0.1

			if var_19_6 <= arg_16_1.time_ and arg_16_1.time_ < var_19_6 + var_19_7 and not isNil(var_19_5) then
				local var_19_8 = (arg_16_1.time_ - var_19_6) / var_19_7

				if arg_16_1.var_.characterEffect1093ui_story and not isNil(var_19_5) then
					arg_16_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_16_1.time_ >= var_19_6 + var_19_7 and arg_16_1.time_ < var_19_6 + var_19_7 + arg_19_0 and not isNil(var_19_5) and arg_16_1.var_.characterEffect1093ui_story then
				arg_16_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_19_9 = arg_16_1.actors_["4014_tpose"]
			local var_19_10 = 0

			if var_19_10 < arg_16_1.time_ and arg_16_1.time_ <= var_19_10 + arg_19_0 and not isNil(var_19_9) and arg_16_1.var_.characterEffect4014_tpose == nil then
				arg_16_1.var_.characterEffect4014_tpose = var_19_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_11 = 0.1

			if var_19_10 <= arg_16_1.time_ and arg_16_1.time_ < var_19_10 + var_19_11 and not isNil(var_19_9) then
				local var_19_12 = (arg_16_1.time_ - var_19_10) / var_19_11

				if arg_16_1.var_.characterEffect4014_tpose and not isNil(var_19_9) then
					local var_19_13 = Mathf.Lerp(0, 0.5, var_19_12)

					arg_16_1.var_.characterEffect4014_tpose.fillFlat = true
					arg_16_1.var_.characterEffect4014_tpose.fillRatio = var_19_13
				end
			end

			if arg_16_1.time_ >= var_19_10 + var_19_11 and arg_16_1.time_ < var_19_10 + var_19_11 + arg_19_0 and not isNil(var_19_9) and arg_16_1.var_.characterEffect4014_tpose then
				local var_19_14 = 0.5

				arg_16_1.var_.characterEffect4014_tpose.fillFlat = true
				arg_16_1.var_.characterEffect4014_tpose.fillRatio = var_19_14
			end

			local var_19_15 = arg_16_1.actors_["4014_tpose"].transform
			local var_19_16 = 0

			if var_19_16 < arg_16_1.time_ and arg_16_1.time_ <= var_19_16 + arg_19_0 then
				arg_16_1.var_.moveOldPos4014_tpose = var_19_15.localPosition

				local var_19_17 = GameObjectTools.GetOrAddComponent(var_19_15.gameObject, typeof(DynamicBoneHelper))

				if var_19_17 then
					var_19_17:EnableDynamicBone(false)
				end
			end

			local var_19_18 = 0.001

			if var_19_16 <= arg_16_1.time_ and arg_16_1.time_ < var_19_16 + var_19_18 then
				local var_19_19 = (arg_16_1.time_ - var_19_16) / var_19_18
				local var_19_20 = Vector3.New(0, 100, 0)

				var_19_15.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos4014_tpose, var_19_20, var_19_19)

				local var_19_21 = manager.ui.mainCamera.transform.position - var_19_15.position

				var_19_15.forward = Vector3.New(var_19_21.x, var_19_21.y, var_19_21.z)

				local var_19_22 = var_19_15.localEulerAngles

				var_19_22.z = 0
				var_19_22.x = 0
				var_19_15.localEulerAngles = var_19_22
			end

			if arg_16_1.time_ >= var_19_16 + var_19_18 and arg_16_1.time_ < var_19_16 + var_19_18 + arg_19_0 then
				var_19_15.localPosition = Vector3.New(0, 100, 0)

				local var_19_23 = manager.ui.mainCamera.transform.position - var_19_15.position

				var_19_15.forward = Vector3.New(var_19_23.x, var_19_23.y, var_19_23.z)

				local var_19_24 = var_19_15.localEulerAngles

				var_19_24.z = 0
				var_19_24.x = 0
				var_19_15.localEulerAngles = var_19_24

				local var_19_25 = GameObjectTools.GetOrAddComponent(var_19_15.gameObject, typeof(DynamicBoneHelper))

				if var_19_25 then
					var_19_25:EnableDynamicBone(true)
				end
			end

			local var_19_26 = arg_16_1.actors_["1093ui_story"].transform
			local var_19_27 = 0

			if var_19_27 < arg_16_1.time_ and arg_16_1.time_ <= var_19_27 + arg_19_0 then
				arg_16_1.var_.moveOldPos1093ui_story = var_19_26.localPosition

				local var_19_28 = "1093ui_story"

				arg_16_1:ShowWeapon(arg_16_1.var_[var_19_28 .. "Animator"].transform, true)
			end

			local var_19_29 = 0.001

			if var_19_27 <= arg_16_1.time_ and arg_16_1.time_ < var_19_27 + var_19_29 then
				local var_19_30 = (arg_16_1.time_ - var_19_27) / var_19_29
				local var_19_31 = Vector3.New(0, -1.11, -5.88)

				var_19_26.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos1093ui_story, var_19_31, var_19_30)

				local var_19_32 = manager.ui.mainCamera.transform.position - var_19_26.position

				var_19_26.forward = Vector3.New(var_19_32.x, var_19_32.y, var_19_32.z)

				local var_19_33 = var_19_26.localEulerAngles

				var_19_33.z = 0
				var_19_33.x = 0
				var_19_26.localEulerAngles = var_19_33
			end

			if arg_16_1.time_ >= var_19_27 + var_19_29 and arg_16_1.time_ < var_19_27 + var_19_29 + arg_19_0 then
				var_19_26.localPosition = Vector3.New(0, -1.11, -5.88)

				local var_19_34 = manager.ui.mainCamera.transform.position - var_19_26.position

				var_19_26.forward = Vector3.New(var_19_34.x, var_19_34.y, var_19_34.z)

				local var_19_35 = var_19_26.localEulerAngles

				var_19_35.z = 0
				var_19_35.x = 0
				var_19_26.localEulerAngles = var_19_35
			end

			local var_19_36 = 0

			if var_19_36 < arg_16_1.time_ and arg_16_1.time_ <= var_19_36 + arg_19_0 then
				arg_16_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action10_2")
			end

			local var_19_37 = 0

			if var_19_37 < arg_16_1.time_ and arg_16_1.time_ <= var_19_37 + arg_19_0 then
				arg_16_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_19_38 = 0
			local var_19_39 = 0.45

			if var_19_38 < arg_16_1.time_ and arg_16_1.time_ <= var_19_38 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				local var_19_40 = arg_16_1:FormatText(StoryNameCfg[73].name)

				arg_16_1.leftNameTxt_.text = var_19_40

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_41 = arg_16_1:GetWordFromCfg(106122004)
				local var_19_42 = arg_16_1:FormatText(var_19_41.content)

				arg_16_1.text_.text = var_19_42

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_43 = 17
				local var_19_44 = utf8.len(var_19_42)
				local var_19_45 = var_19_43 <= 0 and var_19_39 or var_19_39 * (var_19_44 / var_19_43)

				if var_19_45 > 0 and var_19_39 < var_19_45 then
					arg_16_1.talkMaxDuration = var_19_45

					if var_19_45 + var_19_38 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_45 + var_19_38
					end
				end

				arg_16_1.text_.text = var_19_42
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106122", "106122004", "story_v_out_106122.awb") ~= 0 then
					local var_19_46 = manager.audio:GetVoiceLength("story_v_out_106122", "106122004", "story_v_out_106122.awb") / 1000

					if var_19_46 + var_19_38 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_46 + var_19_38
					end

					if var_19_41.prefab_name ~= "" and arg_16_1.actors_[var_19_41.prefab_name] ~= nil then
						local var_19_47 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_41.prefab_name].transform, "story_v_out_106122", "106122004", "story_v_out_106122.awb")

						arg_16_1:RecordAudio("106122004", var_19_47)
						arg_16_1:RecordAudio("106122004", var_19_47)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_106122", "106122004", "story_v_out_106122.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_106122", "106122004", "story_v_out_106122.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_48 = math.max(var_19_39, arg_16_1.talkMaxDuration)

			if var_19_38 <= arg_16_1.time_ and arg_16_1.time_ < var_19_38 + var_19_48 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_38) / var_19_48

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_38 + var_19_48 and arg_16_1.time_ < var_19_38 + var_19_48 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4014_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_16_1:InitPlayNodeList()
	end,
	Play106122005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 106122005
		arg_20_1.duration_ = 4.43

		local var_20_0 = {
			ja = 2.3,
			ko = 1.999999999999,
			zh = 2.866,
			en = 4.433
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
				arg_20_0:Play106122006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = arg_20_1.actors_["4014_tpose"]
			local var_23_1 = 0

			if var_23_1 < arg_20_1.time_ and arg_20_1.time_ <= var_23_1 + arg_23_0 and not isNil(var_23_0) and arg_20_1.var_.characterEffect4014_tpose == nil then
				arg_20_1.var_.characterEffect4014_tpose = var_23_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_2 = 0.1

			if var_23_1 <= arg_20_1.time_ and arg_20_1.time_ < var_23_1 + var_23_2 and not isNil(var_23_0) then
				local var_23_3 = (arg_20_1.time_ - var_23_1) / var_23_2

				if arg_20_1.var_.characterEffect4014_tpose and not isNil(var_23_0) then
					arg_20_1.var_.characterEffect4014_tpose.fillFlat = false
				end
			end

			if arg_20_1.time_ >= var_23_1 + var_23_2 and arg_20_1.time_ < var_23_1 + var_23_2 + arg_23_0 and not isNil(var_23_0) and arg_20_1.var_.characterEffect4014_tpose then
				arg_20_1.var_.characterEffect4014_tpose.fillFlat = false
			end

			local var_23_4 = arg_20_1.actors_["1093ui_story"]
			local var_23_5 = 0

			if var_23_5 < arg_20_1.time_ and arg_20_1.time_ <= var_23_5 + arg_23_0 and not isNil(var_23_4) and arg_20_1.var_.characterEffect1093ui_story == nil then
				arg_20_1.var_.characterEffect1093ui_story = var_23_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_6 = 0.1

			if var_23_5 <= arg_20_1.time_ and arg_20_1.time_ < var_23_5 + var_23_6 and not isNil(var_23_4) then
				local var_23_7 = (arg_20_1.time_ - var_23_5) / var_23_6

				if arg_20_1.var_.characterEffect1093ui_story and not isNil(var_23_4) then
					local var_23_8 = Mathf.Lerp(0, 0.5, var_23_7)

					arg_20_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_20_1.var_.characterEffect1093ui_story.fillRatio = var_23_8
				end
			end

			if arg_20_1.time_ >= var_23_5 + var_23_6 and arg_20_1.time_ < var_23_5 + var_23_6 + arg_23_0 and not isNil(var_23_4) and arg_20_1.var_.characterEffect1093ui_story then
				local var_23_9 = 0.5

				arg_20_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_20_1.var_.characterEffect1093ui_story.fillRatio = var_23_9
			end

			local var_23_10 = arg_20_1.actors_["1093ui_story"].transform
			local var_23_11 = 0

			if var_23_11 < arg_20_1.time_ and arg_20_1.time_ <= var_23_11 + arg_23_0 then
				arg_20_1.var_.moveOldPos1093ui_story = var_23_10.localPosition
			end

			local var_23_12 = 0.001

			if var_23_11 <= arg_20_1.time_ and arg_20_1.time_ < var_23_11 + var_23_12 then
				local var_23_13 = (arg_20_1.time_ - var_23_11) / var_23_12
				local var_23_14 = Vector3.New(0, 100, 0)

				var_23_10.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos1093ui_story, var_23_14, var_23_13)

				local var_23_15 = manager.ui.mainCamera.transform.position - var_23_10.position

				var_23_10.forward = Vector3.New(var_23_15.x, var_23_15.y, var_23_15.z)

				local var_23_16 = var_23_10.localEulerAngles

				var_23_16.z = 0
				var_23_16.x = 0
				var_23_10.localEulerAngles = var_23_16
			end

			if arg_20_1.time_ >= var_23_11 + var_23_12 and arg_20_1.time_ < var_23_11 + var_23_12 + arg_23_0 then
				var_23_10.localPosition = Vector3.New(0, 100, 0)

				local var_23_17 = manager.ui.mainCamera.transform.position - var_23_10.position

				var_23_10.forward = Vector3.New(var_23_17.x, var_23_17.y, var_23_17.z)

				local var_23_18 = var_23_10.localEulerAngles

				var_23_18.z = 0
				var_23_18.x = 0
				var_23_10.localEulerAngles = var_23_18
			end

			local var_23_19 = arg_20_1.actors_["4014_tpose"].transform
			local var_23_20 = 0

			if var_23_20 < arg_20_1.time_ and arg_20_1.time_ <= var_23_20 + arg_23_0 then
				arg_20_1.var_.moveOldPos4014_tpose = var_23_19.localPosition

				local var_23_21 = GameObjectTools.GetOrAddComponent(var_23_19.gameObject, typeof(DynamicBoneHelper))

				if var_23_21 then
					var_23_21:EnableDynamicBone(false)
				end
			end

			local var_23_22 = 0.001

			if var_23_20 <= arg_20_1.time_ and arg_20_1.time_ < var_23_20 + var_23_22 then
				local var_23_23 = (arg_20_1.time_ - var_23_20) / var_23_22
				local var_23_24 = Vector3.New(0, -1.95, -4.2)

				var_23_19.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos4014_tpose, var_23_24, var_23_23)

				local var_23_25 = manager.ui.mainCamera.transform.position - var_23_19.position

				var_23_19.forward = Vector3.New(var_23_25.x, var_23_25.y, var_23_25.z)

				local var_23_26 = var_23_19.localEulerAngles

				var_23_26.z = 0
				var_23_26.x = 0
				var_23_19.localEulerAngles = var_23_26
			end

			if arg_20_1.time_ >= var_23_20 + var_23_22 and arg_20_1.time_ < var_23_20 + var_23_22 + arg_23_0 then
				var_23_19.localPosition = Vector3.New(0, -1.95, -4.2)

				local var_23_27 = manager.ui.mainCamera.transform.position - var_23_19.position

				var_23_19.forward = Vector3.New(var_23_27.x, var_23_27.y, var_23_27.z)

				local var_23_28 = var_23_19.localEulerAngles

				var_23_28.z = 0
				var_23_28.x = 0
				var_23_19.localEulerAngles = var_23_28

				local var_23_29 = GameObjectTools.GetOrAddComponent(var_23_19.gameObject, typeof(DynamicBoneHelper))

				if var_23_29 then
					var_23_29:EnableDynamicBone(true)
				end
			end

			local var_23_30 = 0

			if var_23_30 < arg_20_1.time_ and arg_20_1.time_ <= var_23_30 + arg_23_0 then
				arg_20_1:PlayTimeline("4014_tpose", "StoryTimeline/CharAction/story4014/story4014action/4014action1_1")
			end

			local var_23_31 = 0
			local var_23_32 = 0.225

			if var_23_31 < arg_20_1.time_ and arg_20_1.time_ <= var_23_31 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				local var_23_33 = arg_20_1:FormatText(StoryNameCfg[87].name)

				arg_20_1.leftNameTxt_.text = var_23_33

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_34 = arg_20_1:GetWordFromCfg(106122005)
				local var_23_35 = arg_20_1:FormatText(var_23_34.content)

				arg_20_1.text_.text = var_23_35

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_36 = 9
				local var_23_37 = utf8.len(var_23_35)
				local var_23_38 = var_23_36 <= 0 and var_23_32 or var_23_32 * (var_23_37 / var_23_36)

				if var_23_38 > 0 and var_23_32 < var_23_38 then
					arg_20_1.talkMaxDuration = var_23_38

					if var_23_38 + var_23_31 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_38 + var_23_31
					end
				end

				arg_20_1.text_.text = var_23_35
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106122", "106122005", "story_v_out_106122.awb") ~= 0 then
					local var_23_39 = manager.audio:GetVoiceLength("story_v_out_106122", "106122005", "story_v_out_106122.awb") / 1000

					if var_23_39 + var_23_31 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_39 + var_23_31
					end

					if var_23_34.prefab_name ~= "" and arg_20_1.actors_[var_23_34.prefab_name] ~= nil then
						local var_23_40 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_34.prefab_name].transform, "story_v_out_106122", "106122005", "story_v_out_106122.awb")

						arg_20_1:RecordAudio("106122005", var_23_40)
						arg_20_1:RecordAudio("106122005", var_23_40)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_106122", "106122005", "story_v_out_106122.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_106122", "106122005", "story_v_out_106122.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_41 = math.max(var_23_32, arg_20_1.talkMaxDuration)

			if var_23_31 <= arg_20_1.time_ and arg_20_1.time_ < var_23_31 + var_23_41 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_31) / var_23_41

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_31 + var_23_41 and arg_20_1.time_ < var_23_31 + var_23_41 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4014_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_20_1:InitPlayNodeList()
	end,
	Play106122006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 106122006
		arg_24_1.duration_ = 5

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play106122007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = arg_24_1.actors_["4014_tpose"]
			local var_27_1 = 0

			if var_27_1 < arg_24_1.time_ and arg_24_1.time_ <= var_27_1 + arg_27_0 and not isNil(var_27_0) and arg_24_1.var_.characterEffect4014_tpose == nil then
				arg_24_1.var_.characterEffect4014_tpose = var_27_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_2 = 0.1

			if var_27_1 <= arg_24_1.time_ and arg_24_1.time_ < var_27_1 + var_27_2 and not isNil(var_27_0) then
				local var_27_3 = (arg_24_1.time_ - var_27_1) / var_27_2

				if arg_24_1.var_.characterEffect4014_tpose and not isNil(var_27_0) then
					local var_27_4 = Mathf.Lerp(0, 0.5, var_27_3)

					arg_24_1.var_.characterEffect4014_tpose.fillFlat = true
					arg_24_1.var_.characterEffect4014_tpose.fillRatio = var_27_4
				end
			end

			if arg_24_1.time_ >= var_27_1 + var_27_2 and arg_24_1.time_ < var_27_1 + var_27_2 + arg_27_0 and not isNil(var_27_0) and arg_24_1.var_.characterEffect4014_tpose then
				local var_27_5 = 0.5

				arg_24_1.var_.characterEffect4014_tpose.fillFlat = true
				arg_24_1.var_.characterEffect4014_tpose.fillRatio = var_27_5
			end

			local var_27_6 = 0
			local var_27_7 = 0.75

			if var_27_6 < arg_24_1.time_ and arg_24_1.time_ <= var_27_6 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, false)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_8 = arg_24_1:GetWordFromCfg(106122006)
				local var_27_9 = arg_24_1:FormatText(var_27_8.content)

				arg_24_1.text_.text = var_27_9

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_10 = 30
				local var_27_11 = utf8.len(var_27_9)
				local var_27_12 = var_27_10 <= 0 and var_27_7 or var_27_7 * (var_27_11 / var_27_10)

				if var_27_12 > 0 and var_27_7 < var_27_12 then
					arg_24_1.talkMaxDuration = var_27_12

					if var_27_12 + var_27_6 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_12 + var_27_6
					end
				end

				arg_24_1.text_.text = var_27_9
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)
				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_13 = math.max(var_27_7, arg_24_1.talkMaxDuration)

			if var_27_6 <= arg_24_1.time_ and arg_24_1.time_ < var_27_6 + var_27_13 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_6) / var_27_13

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_6 + var_27_13 and arg_24_1.time_ < var_27_6 + var_27_13 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play106122007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 106122007
		arg_28_1.duration_ = 4.37

		local var_28_0 = {
			ja = 4.366,
			ko = 4.366,
			zh = 3.633,
			en = 3.1
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
				arg_28_0:Play106122008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = arg_28_1.actors_["4014_tpose"]
			local var_31_1 = 0

			if var_31_1 < arg_28_1.time_ and arg_28_1.time_ <= var_31_1 + arg_31_0 and not isNil(var_31_0) and arg_28_1.var_.characterEffect4014_tpose == nil then
				arg_28_1.var_.characterEffect4014_tpose = var_31_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_2 = 0.1

			if var_31_1 <= arg_28_1.time_ and arg_28_1.time_ < var_31_1 + var_31_2 and not isNil(var_31_0) then
				local var_31_3 = (arg_28_1.time_ - var_31_1) / var_31_2

				if arg_28_1.var_.characterEffect4014_tpose and not isNil(var_31_0) then
					arg_28_1.var_.characterEffect4014_tpose.fillFlat = false
				end
			end

			if arg_28_1.time_ >= var_31_1 + var_31_2 and arg_28_1.time_ < var_31_1 + var_31_2 + arg_31_0 and not isNil(var_31_0) and arg_28_1.var_.characterEffect4014_tpose then
				arg_28_1.var_.characterEffect4014_tpose.fillFlat = false
			end

			local var_31_4 = arg_28_1.actors_["4014_tpose"].transform
			local var_31_5 = 0

			if var_31_5 < arg_28_1.time_ and arg_28_1.time_ <= var_31_5 + arg_31_0 then
				arg_28_1.var_.moveOldPos4014_tpose = var_31_4.localPosition

				local var_31_6 = GameObjectTools.GetOrAddComponent(var_31_4.gameObject, typeof(DynamicBoneHelper))

				if var_31_6 then
					var_31_6:EnableDynamicBone(false)
				end
			end

			local var_31_7 = 0.001

			if var_31_5 <= arg_28_1.time_ and arg_28_1.time_ < var_31_5 + var_31_7 then
				local var_31_8 = (arg_28_1.time_ - var_31_5) / var_31_7
				local var_31_9 = Vector3.New(0, -1.95, -4.2)

				var_31_4.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos4014_tpose, var_31_9, var_31_8)

				local var_31_10 = manager.ui.mainCamera.transform.position - var_31_4.position

				var_31_4.forward = Vector3.New(var_31_10.x, var_31_10.y, var_31_10.z)

				local var_31_11 = var_31_4.localEulerAngles

				var_31_11.z = 0
				var_31_11.x = 0
				var_31_4.localEulerAngles = var_31_11
			end

			if arg_28_1.time_ >= var_31_5 + var_31_7 and arg_28_1.time_ < var_31_5 + var_31_7 + arg_31_0 then
				var_31_4.localPosition = Vector3.New(0, -1.95, -4.2)

				local var_31_12 = manager.ui.mainCamera.transform.position - var_31_4.position

				var_31_4.forward = Vector3.New(var_31_12.x, var_31_12.y, var_31_12.z)

				local var_31_13 = var_31_4.localEulerAngles

				var_31_13.z = 0
				var_31_13.x = 0
				var_31_4.localEulerAngles = var_31_13

				local var_31_14 = GameObjectTools.GetOrAddComponent(var_31_4.gameObject, typeof(DynamicBoneHelper))

				if var_31_14 then
					var_31_14:EnableDynamicBone(true)
				end
			end

			local var_31_15 = 0

			if var_31_15 < arg_28_1.time_ and arg_28_1.time_ <= var_31_15 + arg_31_0 then
				arg_28_1:PlayTimeline("4014_tpose", "StoryTimeline/CharAction/story4014/story4014action/4014action1_1")
			end

			local var_31_16 = 0
			local var_31_17 = 0.35

			if var_31_16 < arg_28_1.time_ and arg_28_1.time_ <= var_31_16 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				local var_31_18 = arg_28_1:FormatText(StoryNameCfg[87].name)

				arg_28_1.leftNameTxt_.text = var_31_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_19 = arg_28_1:GetWordFromCfg(106122007)
				local var_31_20 = arg_28_1:FormatText(var_31_19.content)

				arg_28_1.text_.text = var_31_20

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_21 = 14
				local var_31_22 = utf8.len(var_31_20)
				local var_31_23 = var_31_21 <= 0 and var_31_17 or var_31_17 * (var_31_22 / var_31_21)

				if var_31_23 > 0 and var_31_17 < var_31_23 then
					arg_28_1.talkMaxDuration = var_31_23

					if var_31_23 + var_31_16 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_23 + var_31_16
					end
				end

				arg_28_1.text_.text = var_31_20
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106122", "106122007", "story_v_out_106122.awb") ~= 0 then
					local var_31_24 = manager.audio:GetVoiceLength("story_v_out_106122", "106122007", "story_v_out_106122.awb") / 1000

					if var_31_24 + var_31_16 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_24 + var_31_16
					end

					if var_31_19.prefab_name ~= "" and arg_28_1.actors_[var_31_19.prefab_name] ~= nil then
						local var_31_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_19.prefab_name].transform, "story_v_out_106122", "106122007", "story_v_out_106122.awb")

						arg_28_1:RecordAudio("106122007", var_31_25)
						arg_28_1:RecordAudio("106122007", var_31_25)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_106122", "106122007", "story_v_out_106122.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_106122", "106122007", "story_v_out_106122.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_26 = math.max(var_31_17, arg_28_1.talkMaxDuration)

			if var_31_16 <= arg_28_1.time_ and arg_28_1.time_ < var_31_16 + var_31_26 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_16) / var_31_26

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_16 + var_31_26 and arg_28_1.time_ < var_31_16 + var_31_26 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4014_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_28_1:InitPlayNodeList()
	end,
	Play106122008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 106122008
		arg_32_1.duration_ = 3.2

		local var_32_0 = {
			ja = 2.866,
			ko = 1.6,
			zh = 1.9,
			en = 3.2
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
				arg_32_0:Play106122009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = arg_32_1.actors_["1093ui_story"]
			local var_35_1 = 0

			if var_35_1 < arg_32_1.time_ and arg_32_1.time_ <= var_35_1 + arg_35_0 and not isNil(var_35_0) and arg_32_1.var_.characterEffect1093ui_story == nil then
				arg_32_1.var_.characterEffect1093ui_story = var_35_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_2 = 0.1

			if var_35_1 <= arg_32_1.time_ and arg_32_1.time_ < var_35_1 + var_35_2 and not isNil(var_35_0) then
				local var_35_3 = (arg_32_1.time_ - var_35_1) / var_35_2

				if arg_32_1.var_.characterEffect1093ui_story and not isNil(var_35_0) then
					arg_32_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_32_1.time_ >= var_35_1 + var_35_2 and arg_32_1.time_ < var_35_1 + var_35_2 + arg_35_0 and not isNil(var_35_0) and arg_32_1.var_.characterEffect1093ui_story then
				arg_32_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_35_4 = arg_32_1.actors_["4014_tpose"]
			local var_35_5 = 0

			if var_35_5 < arg_32_1.time_ and arg_32_1.time_ <= var_35_5 + arg_35_0 and not isNil(var_35_4) and arg_32_1.var_.characterEffect4014_tpose == nil then
				arg_32_1.var_.characterEffect4014_tpose = var_35_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_6 = 0.1

			if var_35_5 <= arg_32_1.time_ and arg_32_1.time_ < var_35_5 + var_35_6 and not isNil(var_35_4) then
				local var_35_7 = (arg_32_1.time_ - var_35_5) / var_35_6

				if arg_32_1.var_.characterEffect4014_tpose and not isNil(var_35_4) then
					local var_35_8 = Mathf.Lerp(0, 0.5, var_35_7)

					arg_32_1.var_.characterEffect4014_tpose.fillFlat = true
					arg_32_1.var_.characterEffect4014_tpose.fillRatio = var_35_8
				end
			end

			if arg_32_1.time_ >= var_35_5 + var_35_6 and arg_32_1.time_ < var_35_5 + var_35_6 + arg_35_0 and not isNil(var_35_4) and arg_32_1.var_.characterEffect4014_tpose then
				local var_35_9 = 0.5

				arg_32_1.var_.characterEffect4014_tpose.fillFlat = true
				arg_32_1.var_.characterEffect4014_tpose.fillRatio = var_35_9
			end

			local var_35_10 = arg_32_1.actors_["4014_tpose"].transform
			local var_35_11 = 0

			if var_35_11 < arg_32_1.time_ and arg_32_1.time_ <= var_35_11 + arg_35_0 then
				arg_32_1.var_.moveOldPos4014_tpose = var_35_10.localPosition

				local var_35_12 = GameObjectTools.GetOrAddComponent(var_35_10.gameObject, typeof(DynamicBoneHelper))

				if var_35_12 then
					var_35_12:EnableDynamicBone(false)
				end

				local var_35_13 = "4014_tpose"

				arg_32_1:ShowWeapon(arg_32_1.var_[var_35_13 .. "Animator"].transform, true)
			end

			local var_35_14 = 0.001

			if var_35_11 <= arg_32_1.time_ and arg_32_1.time_ < var_35_11 + var_35_14 then
				local var_35_15 = (arg_32_1.time_ - var_35_11) / var_35_14
				local var_35_16 = Vector3.New(0, 100, 0)

				var_35_10.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos4014_tpose, var_35_16, var_35_15)

				local var_35_17 = manager.ui.mainCamera.transform.position - var_35_10.position

				var_35_10.forward = Vector3.New(var_35_17.x, var_35_17.y, var_35_17.z)

				local var_35_18 = var_35_10.localEulerAngles

				var_35_18.z = 0
				var_35_18.x = 0
				var_35_10.localEulerAngles = var_35_18
			end

			if arg_32_1.time_ >= var_35_11 + var_35_14 and arg_32_1.time_ < var_35_11 + var_35_14 + arg_35_0 then
				var_35_10.localPosition = Vector3.New(0, 100, 0)

				local var_35_19 = manager.ui.mainCamera.transform.position - var_35_10.position

				var_35_10.forward = Vector3.New(var_35_19.x, var_35_19.y, var_35_19.z)

				local var_35_20 = var_35_10.localEulerAngles

				var_35_20.z = 0
				var_35_20.x = 0
				var_35_10.localEulerAngles = var_35_20

				local var_35_21 = GameObjectTools.GetOrAddComponent(var_35_10.gameObject, typeof(DynamicBoneHelper))

				if var_35_21 then
					var_35_21:EnableDynamicBone(true)
				end
			end

			local var_35_22 = 0

			if var_35_22 < arg_32_1.time_ and arg_32_1.time_ <= var_35_22 + arg_35_0 then
				arg_32_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_35_23 = 0
			local var_35_24 = 0.175

			if var_35_23 < arg_32_1.time_ and arg_32_1.time_ <= var_35_23 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				local var_35_25 = arg_32_1:FormatText(StoryNameCfg[73].name)

				arg_32_1.leftNameTxt_.text = var_35_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, true)
				arg_32_1.iconController_:SetSelectedState("hero")

				arg_32_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1093")

				arg_32_1.callingController_:SetSelectedState("normal")

				arg_32_1.keyicon_.color = Color.New(1, 1, 1)
				arg_32_1.icon_.color = Color.New(1, 1, 1)

				local var_35_26 = arg_32_1:GetWordFromCfg(106122008)
				local var_35_27 = arg_32_1:FormatText(var_35_26.content)

				arg_32_1.text_.text = var_35_27

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_28 = 7
				local var_35_29 = utf8.len(var_35_27)
				local var_35_30 = var_35_28 <= 0 and var_35_24 or var_35_24 * (var_35_29 / var_35_28)

				if var_35_30 > 0 and var_35_24 < var_35_30 then
					arg_32_1.talkMaxDuration = var_35_30

					if var_35_30 + var_35_23 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_30 + var_35_23
					end
				end

				arg_32_1.text_.text = var_35_27
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106122", "106122008", "story_v_out_106122.awb") ~= 0 then
					local var_35_31 = manager.audio:GetVoiceLength("story_v_out_106122", "106122008", "story_v_out_106122.awb") / 1000

					if var_35_31 + var_35_23 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_31 + var_35_23
					end

					if var_35_26.prefab_name ~= "" and arg_32_1.actors_[var_35_26.prefab_name] ~= nil then
						local var_35_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_26.prefab_name].transform, "story_v_out_106122", "106122008", "story_v_out_106122.awb")

						arg_32_1:RecordAudio("106122008", var_35_32)
						arg_32_1:RecordAudio("106122008", var_35_32)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_106122", "106122008", "story_v_out_106122.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_106122", "106122008", "story_v_out_106122.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_33 = math.max(var_35_24, arg_32_1.talkMaxDuration)

			if var_35_23 <= arg_32_1.time_ and arg_32_1.time_ < var_35_23 + var_35_33 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_23) / var_35_33

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_23 + var_35_33 and arg_32_1.time_ < var_35_23 + var_35_33 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4014_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_32_1:InitPlayNodeList()
	end,
	Play106122009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 106122009
		arg_36_1.duration_ = 4.07

		local var_36_0 = {
			ja = 4.066,
			ko = 2.633,
			zh = 2.866,
			en = 2.9
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
				arg_36_0:Play106122010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = arg_36_1.actors_["4014_tpose"]
			local var_39_1 = 0

			if var_39_1 < arg_36_1.time_ and arg_36_1.time_ <= var_39_1 + arg_39_0 and not isNil(var_39_0) and arg_36_1.var_.characterEffect4014_tpose == nil then
				arg_36_1.var_.characterEffect4014_tpose = var_39_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_2 = 0.1

			if var_39_1 <= arg_36_1.time_ and arg_36_1.time_ < var_39_1 + var_39_2 and not isNil(var_39_0) then
				local var_39_3 = (arg_36_1.time_ - var_39_1) / var_39_2

				if arg_36_1.var_.characterEffect4014_tpose and not isNil(var_39_0) then
					arg_36_1.var_.characterEffect4014_tpose.fillFlat = false
				end
			end

			if arg_36_1.time_ >= var_39_1 + var_39_2 and arg_36_1.time_ < var_39_1 + var_39_2 + arg_39_0 and not isNil(var_39_0) and arg_36_1.var_.characterEffect4014_tpose then
				arg_36_1.var_.characterEffect4014_tpose.fillFlat = false
			end

			local var_39_4 = arg_36_1.actors_["1093ui_story"]
			local var_39_5 = 0

			if var_39_5 < arg_36_1.time_ and arg_36_1.time_ <= var_39_5 + arg_39_0 and not isNil(var_39_4) and arg_36_1.var_.characterEffect1093ui_story == nil then
				arg_36_1.var_.characterEffect1093ui_story = var_39_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_6 = 0.1

			if var_39_5 <= arg_36_1.time_ and arg_36_1.time_ < var_39_5 + var_39_6 and not isNil(var_39_4) then
				local var_39_7 = (arg_36_1.time_ - var_39_5) / var_39_6

				if arg_36_1.var_.characterEffect1093ui_story and not isNil(var_39_4) then
					local var_39_8 = Mathf.Lerp(0, 0.5, var_39_7)

					arg_36_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_36_1.var_.characterEffect1093ui_story.fillRatio = var_39_8
				end
			end

			if arg_36_1.time_ >= var_39_5 + var_39_6 and arg_36_1.time_ < var_39_5 + var_39_6 + arg_39_0 and not isNil(var_39_4) and arg_36_1.var_.characterEffect1093ui_story then
				local var_39_9 = 0.5

				arg_36_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_36_1.var_.characterEffect1093ui_story.fillRatio = var_39_9
			end

			local var_39_10 = arg_36_1.actors_["1093ui_story"].transform
			local var_39_11 = 0

			if var_39_11 < arg_36_1.time_ and arg_36_1.time_ <= var_39_11 + arg_39_0 then
				arg_36_1.var_.moveOldPos1093ui_story = var_39_10.localPosition

				local var_39_12 = "1093ui_story"

				arg_36_1:ShowWeapon(arg_36_1.var_[var_39_12 .. "Animator"].transform, true)
			end

			local var_39_13 = 0.001

			if var_39_11 <= arg_36_1.time_ and arg_36_1.time_ < var_39_11 + var_39_13 then
				local var_39_14 = (arg_36_1.time_ - var_39_11) / var_39_13
				local var_39_15 = Vector3.New(0, 100, 0)

				var_39_10.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos1093ui_story, var_39_15, var_39_14)

				local var_39_16 = manager.ui.mainCamera.transform.position - var_39_10.position

				var_39_10.forward = Vector3.New(var_39_16.x, var_39_16.y, var_39_16.z)

				local var_39_17 = var_39_10.localEulerAngles

				var_39_17.z = 0
				var_39_17.x = 0
				var_39_10.localEulerAngles = var_39_17
			end

			if arg_36_1.time_ >= var_39_11 + var_39_13 and arg_36_1.time_ < var_39_11 + var_39_13 + arg_39_0 then
				var_39_10.localPosition = Vector3.New(0, 100, 0)

				local var_39_18 = manager.ui.mainCamera.transform.position - var_39_10.position

				var_39_10.forward = Vector3.New(var_39_18.x, var_39_18.y, var_39_18.z)

				local var_39_19 = var_39_10.localEulerAngles

				var_39_19.z = 0
				var_39_19.x = 0
				var_39_10.localEulerAngles = var_39_19
			end

			local var_39_20 = arg_36_1.actors_["4014_tpose"].transform
			local var_39_21 = 0

			if var_39_21 < arg_36_1.time_ and arg_36_1.time_ <= var_39_21 + arg_39_0 then
				arg_36_1.var_.moveOldPos4014_tpose = var_39_20.localPosition

				local var_39_22 = GameObjectTools.GetOrAddComponent(var_39_20.gameObject, typeof(DynamicBoneHelper))

				if var_39_22 then
					var_39_22:EnableDynamicBone(false)
				end
			end

			local var_39_23 = 0.001

			if var_39_21 <= arg_36_1.time_ and arg_36_1.time_ < var_39_21 + var_39_23 then
				local var_39_24 = (arg_36_1.time_ - var_39_21) / var_39_23
				local var_39_25 = Vector3.New(0, -1.95, -4.2)

				var_39_20.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos4014_tpose, var_39_25, var_39_24)

				local var_39_26 = manager.ui.mainCamera.transform.position - var_39_20.position

				var_39_20.forward = Vector3.New(var_39_26.x, var_39_26.y, var_39_26.z)

				local var_39_27 = var_39_20.localEulerAngles

				var_39_27.z = 0
				var_39_27.x = 0
				var_39_20.localEulerAngles = var_39_27
			end

			if arg_36_1.time_ >= var_39_21 + var_39_23 and arg_36_1.time_ < var_39_21 + var_39_23 + arg_39_0 then
				var_39_20.localPosition = Vector3.New(0, -1.95, -4.2)

				local var_39_28 = manager.ui.mainCamera.transform.position - var_39_20.position

				var_39_20.forward = Vector3.New(var_39_28.x, var_39_28.y, var_39_28.z)

				local var_39_29 = var_39_20.localEulerAngles

				var_39_29.z = 0
				var_39_29.x = 0
				var_39_20.localEulerAngles = var_39_29

				local var_39_30 = GameObjectTools.GetOrAddComponent(var_39_20.gameObject, typeof(DynamicBoneHelper))

				if var_39_30 then
					var_39_30:EnableDynamicBone(true)
				end
			end

			local var_39_31 = 0

			if var_39_31 < arg_36_1.time_ and arg_36_1.time_ <= var_39_31 + arg_39_0 then
				arg_36_1:PlayTimeline("4014_tpose", "StoryTimeline/CharAction/story4014/story4014action/4014action1_1")
			end

			local var_39_32 = 0
			local var_39_33 = 0.3

			if var_39_32 < arg_36_1.time_ and arg_36_1.time_ <= var_39_32 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				local var_39_34 = arg_36_1:FormatText(StoryNameCfg[87].name)

				arg_36_1.leftNameTxt_.text = var_39_34

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_35 = arg_36_1:GetWordFromCfg(106122009)
				local var_39_36 = arg_36_1:FormatText(var_39_35.content)

				arg_36_1.text_.text = var_39_36

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_37 = 12
				local var_39_38 = utf8.len(var_39_36)
				local var_39_39 = var_39_37 <= 0 and var_39_33 or var_39_33 * (var_39_38 / var_39_37)

				if var_39_39 > 0 and var_39_33 < var_39_39 then
					arg_36_1.talkMaxDuration = var_39_39

					if var_39_39 + var_39_32 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_39 + var_39_32
					end
				end

				arg_36_1.text_.text = var_39_36
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106122", "106122009", "story_v_out_106122.awb") ~= 0 then
					local var_39_40 = manager.audio:GetVoiceLength("story_v_out_106122", "106122009", "story_v_out_106122.awb") / 1000

					if var_39_40 + var_39_32 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_40 + var_39_32
					end

					if var_39_35.prefab_name ~= "" and arg_36_1.actors_[var_39_35.prefab_name] ~= nil then
						local var_39_41 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_35.prefab_name].transform, "story_v_out_106122", "106122009", "story_v_out_106122.awb")

						arg_36_1:RecordAudio("106122009", var_39_41)
						arg_36_1:RecordAudio("106122009", var_39_41)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_106122", "106122009", "story_v_out_106122.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_106122", "106122009", "story_v_out_106122.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_42 = math.max(var_39_33, arg_36_1.talkMaxDuration)

			if var_39_32 <= arg_36_1.time_ and arg_36_1.time_ < var_39_32 + var_39_42 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_32) / var_39_42

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_32 + var_39_42 and arg_36_1.time_ < var_39_32 + var_39_42 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4014_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_36_1:InitPlayNodeList()
	end,
	Play106122010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 106122010
		arg_40_1.duration_ = 7

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play106122011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = arg_40_1.actors_["4014_tpose"]
			local var_43_1 = 0

			if var_43_1 < arg_40_1.time_ and arg_40_1.time_ <= var_43_1 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.characterEffect4014_tpose == nil then
				arg_40_1.var_.characterEffect4014_tpose = var_43_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_2 = 0.1

			if var_43_1 <= arg_40_1.time_ and arg_40_1.time_ < var_43_1 + var_43_2 and not isNil(var_43_0) then
				local var_43_3 = (arg_40_1.time_ - var_43_1) / var_43_2

				if arg_40_1.var_.characterEffect4014_tpose and not isNil(var_43_0) then
					local var_43_4 = Mathf.Lerp(0, 0.5, var_43_3)

					arg_40_1.var_.characterEffect4014_tpose.fillFlat = true
					arg_40_1.var_.characterEffect4014_tpose.fillRatio = var_43_4
				end
			end

			if arg_40_1.time_ >= var_43_1 + var_43_2 and arg_40_1.time_ < var_43_1 + var_43_2 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.characterEffect4014_tpose then
				local var_43_5 = 0.5

				arg_40_1.var_.characterEffect4014_tpose.fillFlat = true
				arg_40_1.var_.characterEffect4014_tpose.fillRatio = var_43_5
			end

			local var_43_6 = arg_40_1.actors_["4014_tpose"].transform
			local var_43_7 = 0

			if var_43_7 < arg_40_1.time_ and arg_40_1.time_ <= var_43_7 + arg_43_0 then
				arg_40_1.var_.moveOldPos4014_tpose = var_43_6.localPosition

				local var_43_8 = GameObjectTools.GetOrAddComponent(var_43_6.gameObject, typeof(DynamicBoneHelper))

				if var_43_8 then
					var_43_8:EnableDynamicBone(false)
				end
			end

			local var_43_9 = 0.001

			if var_43_7 <= arg_40_1.time_ and arg_40_1.time_ < var_43_7 + var_43_9 then
				local var_43_10 = (arg_40_1.time_ - var_43_7) / var_43_9
				local var_43_11 = Vector3.New(0, 100, 0)

				var_43_6.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos4014_tpose, var_43_11, var_43_10)

				local var_43_12 = manager.ui.mainCamera.transform.position - var_43_6.position

				var_43_6.forward = Vector3.New(var_43_12.x, var_43_12.y, var_43_12.z)

				local var_43_13 = var_43_6.localEulerAngles

				var_43_13.z = 0
				var_43_13.x = 0
				var_43_6.localEulerAngles = var_43_13
			end

			if arg_40_1.time_ >= var_43_7 + var_43_9 and arg_40_1.time_ < var_43_7 + var_43_9 + arg_43_0 then
				var_43_6.localPosition = Vector3.New(0, 100, 0)

				local var_43_14 = manager.ui.mainCamera.transform.position - var_43_6.position

				var_43_6.forward = Vector3.New(var_43_14.x, var_43_14.y, var_43_14.z)

				local var_43_15 = var_43_6.localEulerAngles

				var_43_15.z = 0
				var_43_15.x = 0
				var_43_6.localEulerAngles = var_43_15

				local var_43_16 = GameObjectTools.GetOrAddComponent(var_43_6.gameObject, typeof(DynamicBoneHelper))

				if var_43_16 then
					var_43_16:EnableDynamicBone(true)
				end
			end

			local var_43_17 = "STblack"

			if arg_40_1.bgs_[var_43_17] == nil then
				local var_43_18 = Object.Instantiate(arg_40_1.paintGo_)

				var_43_18:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_43_17)
				var_43_18.name = var_43_17
				var_43_18.transform.parent = arg_40_1.stage_.transform
				var_43_18.transform.localPosition = Vector3.New(0, 100, 0)
				arg_40_1.bgs_[var_43_17] = var_43_18
			end

			local var_43_19 = 0

			if var_43_19 < arg_40_1.time_ and arg_40_1.time_ <= var_43_19 + arg_43_0 then
				local var_43_20 = manager.ui.mainCamera.transform.localPosition
				local var_43_21 = Vector3.New(0, 0, 10) + Vector3.New(var_43_20.x, var_43_20.y, 0)
				local var_43_22 = arg_40_1.bgs_.STblack

				var_43_22.transform.localPosition = var_43_21
				var_43_22.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_43_23 = var_43_22:GetComponent("SpriteRenderer")

				if var_43_23 and var_43_23.sprite then
					local var_43_24 = (var_43_22.transform.localPosition - var_43_20).z
					local var_43_25 = manager.ui.mainCameraCom_
					local var_43_26 = 2 * var_43_24 * Mathf.Tan(var_43_25.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_43_27 = var_43_26 * var_43_25.aspect
					local var_43_28 = var_43_23.sprite.bounds.size.x
					local var_43_29 = var_43_23.sprite.bounds.size.y
					local var_43_30 = var_43_27 / var_43_28
					local var_43_31 = var_43_26 / var_43_29
					local var_43_32 = var_43_31 < var_43_30 and var_43_30 or var_43_31

					var_43_22.transform.localScale = Vector3.New(var_43_32, var_43_32, 0)
				end

				for iter_43_0, iter_43_1 in pairs(arg_40_1.bgs_) do
					if iter_43_0 ~= "STblack" then
						iter_43_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_43_33 = 0

			if var_43_33 < arg_40_1.time_ and arg_40_1.time_ <= var_43_33 + arg_43_0 then
				arg_40_1.mask_.enabled = true
				arg_40_1.mask_.raycastTarget = true

				arg_40_1:SetGaussion(false)
			end

			local var_43_34 = 2

			if var_43_33 <= arg_40_1.time_ and arg_40_1.time_ < var_43_33 + var_43_34 then
				local var_43_35 = (arg_40_1.time_ - var_43_33) / var_43_34
				local var_43_36 = Color.New(0, 0, 0)

				var_43_36.a = Mathf.Lerp(1, 0, var_43_35)
				arg_40_1.mask_.color = var_43_36
			end

			if arg_40_1.time_ >= var_43_33 + var_43_34 and arg_40_1.time_ < var_43_33 + var_43_34 + arg_43_0 then
				local var_43_37 = Color.New(0, 0, 0)
				local var_43_38 = 0

				arg_40_1.mask_.enabled = false
				var_43_37.a = var_43_38
				arg_40_1.mask_.color = var_43_37
			end

			if arg_40_1.frameCnt_ <= 1 then
				arg_40_1.dialog_:SetActive(false)
			end

			local var_43_39 = 2
			local var_43_40 = 0.925

			if var_43_39 < arg_40_1.time_ and arg_40_1.time_ <= var_43_39 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0

				arg_40_1.dialog_:SetActive(true)

				arg_40_1.dialogCg_.alpha = 0

				local var_43_41 = LeanTween.value(arg_40_1.dialog_, 0, 1, 0.3)

				var_43_41:setOnUpdate(LuaHelper.FloatAction(function(arg_44_0)
					arg_40_1.dialogCg_.alpha = arg_44_0
				end))
				var_43_41:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_40_1.dialog_)
					var_43_41:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_40_1.duration_ = arg_40_1.duration_ + 0.3

				SetActive(arg_40_1.leftNameGo_, false)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_42 = arg_40_1:GetWordFromCfg(106122010)
				local var_43_43 = arg_40_1:FormatText(var_43_42.content)

				arg_40_1.text_.text = var_43_43

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_44 = 38
				local var_43_45 = utf8.len(var_43_43)
				local var_43_46 = var_43_44 <= 0 and var_43_40 or var_43_40 * (var_43_45 / var_43_44)

				if var_43_46 > 0 and var_43_40 < var_43_46 then
					arg_40_1.talkMaxDuration = var_43_46
					var_43_39 = var_43_39 + 0.3

					if var_43_46 + var_43_39 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_46 + var_43_39
					end
				end

				arg_40_1.text_.text = var_43_43
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)
				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_47 = var_43_39 + 0.3
			local var_43_48 = math.max(var_43_40, arg_40_1.talkMaxDuration)

			if var_43_47 <= arg_40_1.time_ and arg_40_1.time_ < var_43_47 + var_43_48 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_47) / var_43_48

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_47 + var_43_48 and arg_40_1.time_ < var_43_47 + var_43_48 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4014_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_40_1:InitPlayNodeList()
	end,
	Play106122011 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 106122011
		arg_46_1.duration_ = 3.03

		local var_46_0 = {
			ja = 3.033,
			ko = 2.633,
			zh = 2.833,
			en = 2.833
		}
		local var_46_1 = manager.audio:GetLocalizationFlag()

		if var_46_0[var_46_1] ~= nil then
			arg_46_1.duration_ = var_46_0[var_46_1]
		end

		SetActive(arg_46_1.tipsGo_, false)

		function arg_46_1.onSingleLineFinish_()
			arg_46_1.onSingleLineUpdate_ = nil
			arg_46_1.onSingleLineFinish_ = nil
			arg_46_1.state_ = "waiting"
		end

		function arg_46_1.playNext_(arg_48_0)
			if arg_48_0 == 1 then
				arg_46_0:Play106122012(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			local var_49_0 = arg_46_1.actors_["1093ui_story"]
			local var_49_1 = 0

			if var_49_1 < arg_46_1.time_ and arg_46_1.time_ <= var_49_1 + arg_49_0 and not isNil(var_49_0) and arg_46_1.var_.characterEffect1093ui_story == nil then
				arg_46_1.var_.characterEffect1093ui_story = var_49_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_49_2 = 0.1

			if var_49_1 <= arg_46_1.time_ and arg_46_1.time_ < var_49_1 + var_49_2 and not isNil(var_49_0) then
				local var_49_3 = (arg_46_1.time_ - var_49_1) / var_49_2

				if arg_46_1.var_.characterEffect1093ui_story and not isNil(var_49_0) then
					arg_46_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_46_1.time_ >= var_49_1 + var_49_2 and arg_46_1.time_ < var_49_1 + var_49_2 + arg_49_0 and not isNil(var_49_0) and arg_46_1.var_.characterEffect1093ui_story then
				arg_46_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_49_4 = manager.ui.mainCamera.transform
			local var_49_5 = 0

			if var_49_5 < arg_46_1.time_ and arg_46_1.time_ <= var_49_5 + arg_49_0 then
				arg_46_1.var_.shakeOldPos = var_49_4.localPosition
			end

			local var_49_6 = 0.6

			if var_49_5 <= arg_46_1.time_ and arg_46_1.time_ < var_49_5 + var_49_6 then
				local var_49_7 = (arg_46_1.time_ - var_49_5) / 0.066
				local var_49_8, var_49_9 = math.modf(var_49_7)

				var_49_4.localPosition = Vector3.New(var_49_9 * 0.13, var_49_9 * 0.13, var_49_9 * 0.13) + arg_46_1.var_.shakeOldPos
			end

			if arg_46_1.time_ >= var_49_5 + var_49_6 and arg_46_1.time_ < var_49_5 + var_49_6 + arg_49_0 then
				var_49_4.localPosition = arg_46_1.var_.shakeOldPos
			end

			local var_49_10 = 0

			if var_49_10 < arg_46_1.time_ and arg_46_1.time_ <= var_49_10 + arg_49_0 then
				arg_46_1.mask_.enabled = true
				arg_46_1.mask_.raycastTarget = true

				arg_46_1:SetGaussion(false)
			end

			local var_49_11 = 0.5

			if var_49_10 <= arg_46_1.time_ and arg_46_1.time_ < var_49_10 + var_49_11 then
				local var_49_12 = (arg_46_1.time_ - var_49_10) / var_49_11
				local var_49_13 = Color.New(1, 1, 1)

				var_49_13.a = Mathf.Lerp(1, 0, var_49_12)
				arg_46_1.mask_.color = var_49_13
			end

			if arg_46_1.time_ >= var_49_10 + var_49_11 and arg_46_1.time_ < var_49_10 + var_49_11 + arg_49_0 then
				local var_49_14 = Color.New(1, 1, 1)
				local var_49_15 = 0

				arg_46_1.mask_.enabled = false
				var_49_14.a = var_49_15
				arg_46_1.mask_.color = var_49_14
			end

			local var_49_16 = 0

			if var_49_16 < arg_46_1.time_ and arg_46_1.time_ <= var_49_16 + arg_49_0 then
				arg_46_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2202cva")
			end

			if arg_46_1.frameCnt_ <= 1 then
				arg_46_1.dialog_:SetActive(false)
			end

			local var_49_17 = 0.6
			local var_49_18 = 0.25

			if var_49_17 < arg_46_1.time_ and arg_46_1.time_ <= var_49_17 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0

				arg_46_1.dialog_:SetActive(true)

				arg_46_1.dialogCg_.alpha = 0

				local var_49_19 = LeanTween.value(arg_46_1.dialog_, 0, 1, 0.3)

				var_49_19:setOnUpdate(LuaHelper.FloatAction(function(arg_50_0)
					arg_46_1.dialogCg_.alpha = arg_50_0
				end))
				var_49_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_46_1.dialog_)
					var_49_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_46_1.duration_ = arg_46_1.duration_ + 0.3

				SetActive(arg_46_1.leftNameGo_, true)

				local var_49_20 = arg_46_1:FormatText(StoryNameCfg[73].name)

				arg_46_1.leftNameTxt_.text = var_49_20

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_46_1.leftNameTxt_.transform)

				arg_46_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_46_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_46_1:RecordName(arg_46_1.leftNameTxt_.text)
				SetActive(arg_46_1.iconTrs_.gameObject, true)
				arg_46_1.iconController_:SetSelectedState("hero")

				arg_46_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1093")

				arg_46_1.callingController_:SetSelectedState("normal")

				arg_46_1.keyicon_.color = Color.New(1, 1, 1)
				arg_46_1.icon_.color = Color.New(1, 1, 1)

				local var_49_21 = arg_46_1:GetWordFromCfg(106122011)
				local var_49_22 = arg_46_1:FormatText(var_49_21.content)

				arg_46_1.text_.text = var_49_22

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_23 = 10
				local var_49_24 = utf8.len(var_49_22)
				local var_49_25 = var_49_23 <= 0 and var_49_18 or var_49_18 * (var_49_24 / var_49_23)

				if var_49_25 > 0 and var_49_18 < var_49_25 then
					arg_46_1.talkMaxDuration = var_49_25
					var_49_17 = var_49_17 + 0.3

					if var_49_25 + var_49_17 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_25 + var_49_17
					end
				end

				arg_46_1.text_.text = var_49_22
				arg_46_1.typewritter.percent = 0

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106122", "106122011", "story_v_out_106122.awb") ~= 0 then
					local var_49_26 = manager.audio:GetVoiceLength("story_v_out_106122", "106122011", "story_v_out_106122.awb") / 1000

					if var_49_26 + var_49_17 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_26 + var_49_17
					end

					if var_49_21.prefab_name ~= "" and arg_46_1.actors_[var_49_21.prefab_name] ~= nil then
						local var_49_27 = LuaForUtil.PlayVoiceWithCriLipsync(arg_46_1.actors_[var_49_21.prefab_name].transform, "story_v_out_106122", "106122011", "story_v_out_106122.awb")

						arg_46_1:RecordAudio("106122011", var_49_27)
						arg_46_1:RecordAudio("106122011", var_49_27)
					else
						arg_46_1:AudioAction("play", "voice", "story_v_out_106122", "106122011", "story_v_out_106122.awb")
					end

					arg_46_1:RecordHistoryTalkVoice("story_v_out_106122", "106122011", "story_v_out_106122.awb")
				end

				arg_46_1:RecordContent(arg_46_1.text_.text)
			end

			local var_49_28 = var_49_17 + 0.3
			local var_49_29 = math.max(var_49_18, arg_46_1.talkMaxDuration)

			if var_49_28 <= arg_46_1.time_ and arg_46_1.time_ < var_49_28 + var_49_29 then
				arg_46_1.typewritter.percent = (arg_46_1.time_ - var_49_28) / var_49_29

				arg_46_1.typewritter:SetDirty()
			end

			if arg_46_1.time_ >= var_49_28 + var_49_29 and arg_46_1.time_ < var_49_28 + var_49_29 + arg_49_0 then
				arg_46_1.typewritter.percent = 1

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(true)
			end
		end

		arg_46_1.nodeConfigList_ = {}

		arg_46_1:InitPlayNodeList()
	end,
	Play106122012 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 106122012
		arg_52_1.duration_ = 8.57

		local var_52_0 = {
			ja = 7.466,
			ko = 8.566,
			zh = 7,
			en = 7.966
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
				arg_52_0:Play106122013(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = "S0611"

			if arg_52_1.bgs_[var_55_0] == nil then
				local var_55_1 = Object.Instantiate(arg_52_1.paintGo_)

				var_55_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_55_0)
				var_55_1.name = var_55_0
				var_55_1.transform.parent = arg_52_1.stage_.transform
				var_55_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_52_1.bgs_[var_55_0] = var_55_1
			end

			local var_55_2 = 0

			if var_55_2 < arg_52_1.time_ and arg_52_1.time_ <= var_55_2 + arg_55_0 then
				local var_55_3 = manager.ui.mainCamera.transform.localPosition
				local var_55_4 = Vector3.New(0, 0, 10) + Vector3.New(var_55_3.x, var_55_3.y, 0)
				local var_55_5 = arg_52_1.bgs_.S0611

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
					if iter_55_0 ~= "S0611" then
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

				var_55_19.a = Mathf.Lerp(1, 0, var_55_18)
				arg_52_1.mask_.color = var_55_19
			end

			if arg_52_1.time_ >= var_55_16 + var_55_17 and arg_52_1.time_ < var_55_16 + var_55_17 + arg_55_0 then
				local var_55_20 = Color.New(0, 0, 0)
				local var_55_21 = 0

				arg_52_1.mask_.enabled = false
				var_55_20.a = var_55_21
				arg_52_1.mask_.color = var_55_20
			end

			local var_55_22 = arg_52_1.bgs_.S0611.transform
			local var_55_23 = 0

			if var_55_23 < arg_52_1.time_ and arg_52_1.time_ <= var_55_23 + arg_55_0 then
				arg_52_1.var_.moveOldPosS0611 = var_55_22.localPosition
			end

			local var_55_24 = 0.001

			if var_55_23 <= arg_52_1.time_ and arg_52_1.time_ < var_55_23 + var_55_24 then
				local var_55_25 = (arg_52_1.time_ - var_55_23) / var_55_24
				local var_55_26 = Vector3.New(0, 1, 9)

				var_55_22.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPosS0611, var_55_26, var_55_25)
			end

			if arg_52_1.time_ >= var_55_23 + var_55_24 and arg_52_1.time_ < var_55_23 + var_55_24 + arg_55_0 then
				var_55_22.localPosition = Vector3.New(0, 1, 9)
			end

			local var_55_27 = arg_52_1.bgs_.S0611.transform
			local var_55_28 = 0

			if var_55_28 < arg_52_1.time_ and arg_52_1.time_ <= var_55_28 + arg_55_0 then
				arg_52_1.var_.moveOldPosS0611 = var_55_27.localPosition
			end

			local var_55_29 = 2.466

			if var_55_28 <= arg_52_1.time_ and arg_52_1.time_ < var_55_28 + var_55_29 then
				local var_55_30 = (arg_52_1.time_ - var_55_28) / var_55_29
				local var_55_31 = Vector3.New(0, 1, 10)

				var_55_27.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPosS0611, var_55_31, var_55_30)
			end

			if arg_52_1.time_ >= var_55_28 + var_55_29 and arg_52_1.time_ < var_55_28 + var_55_29 + arg_55_0 then
				var_55_27.localPosition = Vector3.New(0, 1, 10)
			end

			if arg_52_1.frameCnt_ <= 1 then
				arg_52_1.dialog_:SetActive(false)
			end

			local var_55_32 = 2
			local var_55_33 = 0.5

			if var_55_32 < arg_52_1.time_ and arg_52_1.time_ <= var_55_32 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0

				arg_52_1.dialog_:SetActive(true)

				arg_52_1.dialogCg_.alpha = 0

				local var_55_34 = LeanTween.value(arg_52_1.dialog_, 0, 1, 0.3)

				var_55_34:setOnUpdate(LuaHelper.FloatAction(function(arg_56_0)
					arg_52_1.dialogCg_.alpha = arg_56_0
				end))
				var_55_34:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_52_1.dialog_)
					var_55_34:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_52_1.duration_ = arg_52_1.duration_ + 0.3

				SetActive(arg_52_1.leftNameGo_, true)

				local var_55_35 = arg_52_1:FormatText(StoryNameCfg[87].name)

				arg_52_1.leftNameTxt_.text = var_55_35

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_36 = arg_52_1:GetWordFromCfg(106122012)
				local var_55_37 = arg_52_1:FormatText(var_55_36.content)

				arg_52_1.text_.text = var_55_37

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_38 = 20
				local var_55_39 = utf8.len(var_55_37)
				local var_55_40 = var_55_38 <= 0 and var_55_33 or var_55_33 * (var_55_39 / var_55_38)

				if var_55_40 > 0 and var_55_33 < var_55_40 then
					arg_52_1.talkMaxDuration = var_55_40
					var_55_32 = var_55_32 + 0.3

					if var_55_40 + var_55_32 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_40 + var_55_32
					end
				end

				arg_52_1.text_.text = var_55_37
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106122", "106122012", "story_v_out_106122.awb") ~= 0 then
					local var_55_41 = manager.audio:GetVoiceLength("story_v_out_106122", "106122012", "story_v_out_106122.awb") / 1000

					if var_55_41 + var_55_32 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_41 + var_55_32
					end

					if var_55_36.prefab_name ~= "" and arg_52_1.actors_[var_55_36.prefab_name] ~= nil then
						local var_55_42 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_36.prefab_name].transform, "story_v_out_106122", "106122012", "story_v_out_106122.awb")

						arg_52_1:RecordAudio("106122012", var_55_42)
						arg_52_1:RecordAudio("106122012", var_55_42)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_106122", "106122012", "story_v_out_106122.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_106122", "106122012", "story_v_out_106122.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_43 = var_55_32 + 0.3
			local var_55_44 = math.max(var_55_33, arg_52_1.talkMaxDuration)

			if var_55_43 <= arg_52_1.time_ and arg_52_1.time_ < var_55_43 + var_55_44 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_43) / var_55_44

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_43 + var_55_44 and arg_52_1.time_ < var_55_43 + var_55_44 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "S0611",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "S0611",
				changeDisplayLayer = false,
				needEase = false,
				duration = 2.466,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_52_1:InitPlayNodeList()
	end,
	Play106122013 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 106122013
		arg_58_1.duration_ = 5.83

		local var_58_0 = {
			ja = 3.5,
			ko = 4.5,
			zh = 5.833,
			en = 4.2
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
				arg_58_0:Play106122014(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			local var_61_0 = 0
			local var_61_1 = 0.4

			if var_61_0 < arg_58_1.time_ and arg_58_1.time_ <= var_61_0 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0

				arg_58_1.dialog_:SetActive(true)

				arg_58_1.dialogCg_.alpha = 0

				local var_61_2 = LeanTween.value(arg_58_1.dialog_, 0, 1, 0.3)

				var_61_2:setOnUpdate(LuaHelper.FloatAction(function(arg_62_0)
					arg_58_1.dialogCg_.alpha = arg_62_0
				end))
				var_61_2:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_58_1.dialog_)
					var_61_2:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_58_1.duration_ = arg_58_1.duration_ + 0.3

				SetActive(arg_58_1.leftNameGo_, true)

				local var_61_3 = arg_58_1:FormatText(StoryNameCfg[73].name)

				arg_58_1.leftNameTxt_.text = var_61_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, false)
				arg_58_1.callingController_:SetSelectedState("normal")

				local var_61_4 = arg_58_1:GetWordFromCfg(106122013)
				local var_61_5 = arg_58_1:FormatText(var_61_4.content)

				arg_58_1.text_.text = var_61_5

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_6 = 16
				local var_61_7 = utf8.len(var_61_5)
				local var_61_8 = var_61_6 <= 0 and var_61_1 or var_61_1 * (var_61_7 / var_61_6)

				if var_61_8 > 0 and var_61_1 < var_61_8 then
					arg_58_1.talkMaxDuration = var_61_8
					var_61_0 = var_61_0 + 0.3

					if var_61_8 + var_61_0 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_8 + var_61_0
					end
				end

				arg_58_1.text_.text = var_61_5
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106122", "106122013", "story_v_out_106122.awb") ~= 0 then
					local var_61_9 = manager.audio:GetVoiceLength("story_v_out_106122", "106122013", "story_v_out_106122.awb") / 1000

					if var_61_9 + var_61_0 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_9 + var_61_0
					end

					if var_61_4.prefab_name ~= "" and arg_58_1.actors_[var_61_4.prefab_name] ~= nil then
						local var_61_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_58_1.actors_[var_61_4.prefab_name].transform, "story_v_out_106122", "106122013", "story_v_out_106122.awb")

						arg_58_1:RecordAudio("106122013", var_61_10)
						arg_58_1:RecordAudio("106122013", var_61_10)
					else
						arg_58_1:AudioAction("play", "voice", "story_v_out_106122", "106122013", "story_v_out_106122.awb")
					end

					arg_58_1:RecordHistoryTalkVoice("story_v_out_106122", "106122013", "story_v_out_106122.awb")
				end

				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_11 = var_61_0 + 0.3
			local var_61_12 = math.max(var_61_1, arg_58_1.talkMaxDuration)

			if var_61_11 <= arg_58_1.time_ and arg_58_1.time_ < var_61_11 + var_61_12 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_11) / var_61_12

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_11 + var_61_12 and arg_58_1.time_ < var_61_11 + var_61_12 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {}

		arg_58_1:InitPlayNodeList()
	end,
	Play106122014 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 106122014
		arg_64_1.duration_ = 5

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play106122015(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = 0
			local var_67_1 = 0.575

			if var_67_0 < arg_64_1.time_ and arg_64_1.time_ <= var_67_0 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, false)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_2 = arg_64_1:GetWordFromCfg(106122014)
				local var_67_3 = arg_64_1:FormatText(var_67_2.content)

				arg_64_1.text_.text = var_67_3

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_4 = 23
				local var_67_5 = utf8.len(var_67_3)
				local var_67_6 = var_67_4 <= 0 and var_67_1 or var_67_1 * (var_67_5 / var_67_4)

				if var_67_6 > 0 and var_67_1 < var_67_6 then
					arg_64_1.talkMaxDuration = var_67_6

					if var_67_6 + var_67_0 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_6 + var_67_0
					end
				end

				arg_64_1.text_.text = var_67_3
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)
				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_7 = math.max(var_67_1, arg_64_1.talkMaxDuration)

			if var_67_0 <= arg_64_1.time_ and arg_64_1.time_ < var_67_0 + var_67_7 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_0) / var_67_7

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_0 + var_67_7 and arg_64_1.time_ < var_67_0 + var_67_7 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {}

		arg_64_1:InitPlayNodeList()
	end,
	Play106122015 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 106122015
		arg_68_1.duration_ = 12.43

		local var_68_0 = {
			ja = 10.833,
			ko = 8.833,
			zh = 7.466,
			en = 12.433
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
				arg_68_0:Play106122016(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = 0
			local var_71_1 = 0.875

			if var_71_0 < arg_68_1.time_ and arg_68_1.time_ <= var_71_0 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				local var_71_2 = arg_68_1:FormatText(StoryNameCfg[87].name)

				arg_68_1.leftNameTxt_.text = var_71_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_3 = arg_68_1:GetWordFromCfg(106122015)
				local var_71_4 = arg_68_1:FormatText(var_71_3.content)

				arg_68_1.text_.text = var_71_4

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_5 = 35
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

				if manager.audio:GetVoiceLength("story_v_out_106122", "106122015", "story_v_out_106122.awb") ~= 0 then
					local var_71_8 = manager.audio:GetVoiceLength("story_v_out_106122", "106122015", "story_v_out_106122.awb") / 1000

					if var_71_8 + var_71_0 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_8 + var_71_0
					end

					if var_71_3.prefab_name ~= "" and arg_68_1.actors_[var_71_3.prefab_name] ~= nil then
						local var_71_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_3.prefab_name].transform, "story_v_out_106122", "106122015", "story_v_out_106122.awb")

						arg_68_1:RecordAudio("106122015", var_71_9)
						arg_68_1:RecordAudio("106122015", var_71_9)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_106122", "106122015", "story_v_out_106122.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_106122", "106122015", "story_v_out_106122.awb")
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
	Play106122016 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 106122016
		arg_72_1.duration_ = 11.83

		local var_72_0 = {
			ja = 11.833,
			ko = 8.733,
			zh = 7.4,
			en = 9.066
		}
		local var_72_1 = manager.audio:GetLocalizationFlag()

		if var_72_0[var_72_1] ~= nil then
			arg_72_1.duration_ = var_72_0[var_72_1]
		end

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play106122017(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = 0
			local var_75_1 = 0.9

			if var_75_0 < arg_72_1.time_ and arg_72_1.time_ <= var_75_0 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				local var_75_2 = arg_72_1:FormatText(StoryNameCfg[87].name)

				arg_72_1.leftNameTxt_.text = var_75_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_3 = arg_72_1:GetWordFromCfg(106122016)
				local var_75_4 = arg_72_1:FormatText(var_75_3.content)

				arg_72_1.text_.text = var_75_4

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_5 = 37
				local var_75_6 = utf8.len(var_75_4)
				local var_75_7 = var_75_5 <= 0 and var_75_1 or var_75_1 * (var_75_6 / var_75_5)

				if var_75_7 > 0 and var_75_1 < var_75_7 then
					arg_72_1.talkMaxDuration = var_75_7

					if var_75_7 + var_75_0 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_7 + var_75_0
					end
				end

				arg_72_1.text_.text = var_75_4
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106122", "106122016", "story_v_out_106122.awb") ~= 0 then
					local var_75_8 = manager.audio:GetVoiceLength("story_v_out_106122", "106122016", "story_v_out_106122.awb") / 1000

					if var_75_8 + var_75_0 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_8 + var_75_0
					end

					if var_75_3.prefab_name ~= "" and arg_72_1.actors_[var_75_3.prefab_name] ~= nil then
						local var_75_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_3.prefab_name].transform, "story_v_out_106122", "106122016", "story_v_out_106122.awb")

						arg_72_1:RecordAudio("106122016", var_75_9)
						arg_72_1:RecordAudio("106122016", var_75_9)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_106122", "106122016", "story_v_out_106122.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_106122", "106122016", "story_v_out_106122.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_10 = math.max(var_75_1, arg_72_1.talkMaxDuration)

			if var_75_0 <= arg_72_1.time_ and arg_72_1.time_ < var_75_0 + var_75_10 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_0) / var_75_10

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_0 + var_75_10 and arg_72_1.time_ < var_75_0 + var_75_10 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {}

		arg_72_1:InitPlayNodeList()
	end,
	Play106122017 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 106122017
		arg_76_1.duration_ = 13.43

		local var_76_0 = {
			ja = 13.166,
			ko = 7.933,
			zh = 8.4,
			en = 13.433
		}
		local var_76_1 = manager.audio:GetLocalizationFlag()

		if var_76_0[var_76_1] ~= nil then
			arg_76_1.duration_ = var_76_0[var_76_1]
		end

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play106122018(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = arg_76_1.actors_["1093ui_story"]
			local var_79_1 = 4

			if var_79_1 < arg_76_1.time_ and arg_76_1.time_ <= var_79_1 + arg_79_0 and not isNil(var_79_0) and arg_76_1.var_.characterEffect1093ui_story == nil then
				arg_76_1.var_.characterEffect1093ui_story = var_79_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_2 = 0.1

			if var_79_1 <= arg_76_1.time_ and arg_76_1.time_ < var_79_1 + var_79_2 and not isNil(var_79_0) then
				local var_79_3 = (arg_76_1.time_ - var_79_1) / var_79_2

				if arg_76_1.var_.characterEffect1093ui_story and not isNil(var_79_0) then
					arg_76_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_76_1.time_ >= var_79_1 + var_79_2 and arg_76_1.time_ < var_79_1 + var_79_2 + arg_79_0 and not isNil(var_79_0) and arg_76_1.var_.characterEffect1093ui_story then
				arg_76_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_79_4 = arg_76_1.actors_["4014_tpose"]
			local var_79_5 = 4

			if var_79_5 < arg_76_1.time_ and arg_76_1.time_ <= var_79_5 + arg_79_0 and not isNil(var_79_4) and arg_76_1.var_.characterEffect4014_tpose == nil then
				arg_76_1.var_.characterEffect4014_tpose = var_79_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_6 = 0.1

			if var_79_5 <= arg_76_1.time_ and arg_76_1.time_ < var_79_5 + var_79_6 and not isNil(var_79_4) then
				local var_79_7 = (arg_76_1.time_ - var_79_5) / var_79_6

				if arg_76_1.var_.characterEffect4014_tpose and not isNil(var_79_4) then
					local var_79_8 = Mathf.Lerp(0, 0.5, var_79_7)

					arg_76_1.var_.characterEffect4014_tpose.fillFlat = true
					arg_76_1.var_.characterEffect4014_tpose.fillRatio = var_79_8
				end
			end

			if arg_76_1.time_ >= var_79_5 + var_79_6 and arg_76_1.time_ < var_79_5 + var_79_6 + arg_79_0 and not isNil(var_79_4) and arg_76_1.var_.characterEffect4014_tpose then
				local var_79_9 = 0.5

				arg_76_1.var_.characterEffect4014_tpose.fillFlat = true
				arg_76_1.var_.characterEffect4014_tpose.fillRatio = var_79_9
			end

			local var_79_10 = arg_76_1.actors_["4014_tpose"].transform
			local var_79_11 = 4

			if var_79_11 < arg_76_1.time_ and arg_76_1.time_ <= var_79_11 + arg_79_0 then
				arg_76_1.var_.moveOldPos4014_tpose = var_79_10.localPosition

				local var_79_12 = GameObjectTools.GetOrAddComponent(var_79_10.gameObject, typeof(DynamicBoneHelper))

				if var_79_12 then
					var_79_12:EnableDynamicBone(false)
				end

				local var_79_13 = "4014_tpose"

				arg_76_1:ShowWeapon(arg_76_1.var_[var_79_13 .. "Animator"].transform, true)
			end

			local var_79_14 = 0.001

			if var_79_11 <= arg_76_1.time_ and arg_76_1.time_ < var_79_11 + var_79_14 then
				local var_79_15 = (arg_76_1.time_ - var_79_11) / var_79_14
				local var_79_16 = Vector3.New(0, 100, 0)

				var_79_10.localPosition = Vector3.Lerp(arg_76_1.var_.moveOldPos4014_tpose, var_79_16, var_79_15)

				local var_79_17 = manager.ui.mainCamera.transform.position - var_79_10.position

				var_79_10.forward = Vector3.New(var_79_17.x, var_79_17.y, var_79_17.z)

				local var_79_18 = var_79_10.localEulerAngles

				var_79_18.z = 0
				var_79_18.x = 0
				var_79_10.localEulerAngles = var_79_18
			end

			if arg_76_1.time_ >= var_79_11 + var_79_14 and arg_76_1.time_ < var_79_11 + var_79_14 + arg_79_0 then
				var_79_10.localPosition = Vector3.New(0, 100, 0)

				local var_79_19 = manager.ui.mainCamera.transform.position - var_79_10.position

				var_79_10.forward = Vector3.New(var_79_19.x, var_79_19.y, var_79_19.z)

				local var_79_20 = var_79_10.localEulerAngles

				var_79_20.z = 0
				var_79_20.x = 0
				var_79_10.localEulerAngles = var_79_20

				local var_79_21 = GameObjectTools.GetOrAddComponent(var_79_10.gameObject, typeof(DynamicBoneHelper))

				if var_79_21 then
					var_79_21:EnableDynamicBone(true)
				end
			end

			local var_79_22 = arg_76_1.actors_["1093ui_story"].transform
			local var_79_23 = 4

			if var_79_23 < arg_76_1.time_ and arg_76_1.time_ <= var_79_23 + arg_79_0 then
				arg_76_1.var_.moveOldPos1093ui_story = var_79_22.localPosition
			end

			local var_79_24 = 0.001

			if var_79_23 <= arg_76_1.time_ and arg_76_1.time_ < var_79_23 + var_79_24 then
				local var_79_25 = (arg_76_1.time_ - var_79_23) / var_79_24
				local var_79_26 = Vector3.New(0, -1.11, -5.88)

				var_79_22.localPosition = Vector3.Lerp(arg_76_1.var_.moveOldPos1093ui_story, var_79_26, var_79_25)

				local var_79_27 = manager.ui.mainCamera.transform.position - var_79_22.position

				var_79_22.forward = Vector3.New(var_79_27.x, var_79_27.y, var_79_27.z)

				local var_79_28 = var_79_22.localEulerAngles

				var_79_28.z = 0
				var_79_28.x = 0
				var_79_22.localEulerAngles = var_79_28
			end

			if arg_76_1.time_ >= var_79_23 + var_79_24 and arg_76_1.time_ < var_79_23 + var_79_24 + arg_79_0 then
				var_79_22.localPosition = Vector3.New(0, -1.11, -5.88)

				local var_79_29 = manager.ui.mainCamera.transform.position - var_79_22.position

				var_79_22.forward = Vector3.New(var_79_29.x, var_79_29.y, var_79_29.z)

				local var_79_30 = var_79_22.localEulerAngles

				var_79_30.z = 0
				var_79_30.x = 0
				var_79_22.localEulerAngles = var_79_30
			end

			local var_79_31 = 4

			if var_79_31 < arg_76_1.time_ and arg_76_1.time_ <= var_79_31 + arg_79_0 then
				arg_76_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action10_2")
			end

			local var_79_32 = 4

			if var_79_32 < arg_76_1.time_ and arg_76_1.time_ <= var_79_32 + arg_79_0 then
				arg_76_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2202cva")
			end

			local var_79_33 = 2

			if var_79_33 < arg_76_1.time_ and arg_76_1.time_ <= var_79_33 + arg_79_0 then
				local var_79_34 = manager.ui.mainCamera.transform.localPosition
				local var_79_35 = Vector3.New(0, 0, 10) + Vector3.New(var_79_34.x, var_79_34.y, 0)
				local var_79_36 = arg_76_1.bgs_.C01b

				var_79_36.transform.localPosition = var_79_35
				var_79_36.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_79_37 = var_79_36:GetComponent("SpriteRenderer")

				if var_79_37 and var_79_37.sprite then
					local var_79_38 = (var_79_36.transform.localPosition - var_79_34).z
					local var_79_39 = manager.ui.mainCameraCom_
					local var_79_40 = 2 * var_79_38 * Mathf.Tan(var_79_39.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_79_41 = var_79_40 * var_79_39.aspect
					local var_79_42 = var_79_37.sprite.bounds.size.x
					local var_79_43 = var_79_37.sprite.bounds.size.y
					local var_79_44 = var_79_41 / var_79_42
					local var_79_45 = var_79_40 / var_79_43
					local var_79_46 = var_79_45 < var_79_44 and var_79_44 or var_79_45

					var_79_36.transform.localScale = Vector3.New(var_79_46, var_79_46, 0)
				end

				for iter_79_0, iter_79_1 in pairs(arg_76_1.bgs_) do
					if iter_79_0 ~= "C01b" then
						iter_79_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_79_47 = 0

			if var_79_47 < arg_76_1.time_ and arg_76_1.time_ <= var_79_47 + arg_79_0 then
				arg_76_1.mask_.enabled = true
				arg_76_1.mask_.raycastTarget = true

				arg_76_1:SetGaussion(false)
			end

			local var_79_48 = 2

			if var_79_47 <= arg_76_1.time_ and arg_76_1.time_ < var_79_47 + var_79_48 then
				local var_79_49 = (arg_76_1.time_ - var_79_47) / var_79_48
				local var_79_50 = Color.New(0, 0, 0)

				var_79_50.a = Mathf.Lerp(0, 1, var_79_49)
				arg_76_1.mask_.color = var_79_50
			end

			if arg_76_1.time_ >= var_79_47 + var_79_48 and arg_76_1.time_ < var_79_47 + var_79_48 + arg_79_0 then
				local var_79_51 = Color.New(0, 0, 0)

				var_79_51.a = 1
				arg_76_1.mask_.color = var_79_51
			end

			local var_79_52 = 2

			if var_79_52 < arg_76_1.time_ and arg_76_1.time_ <= var_79_52 + arg_79_0 then
				arg_76_1.mask_.enabled = true
				arg_76_1.mask_.raycastTarget = true

				arg_76_1:SetGaussion(false)
			end

			local var_79_53 = 2

			if var_79_52 <= arg_76_1.time_ and arg_76_1.time_ < var_79_52 + var_79_53 then
				local var_79_54 = (arg_76_1.time_ - var_79_52) / var_79_53
				local var_79_55 = Color.New(0, 0, 0)

				var_79_55.a = Mathf.Lerp(1, 0, var_79_54)
				arg_76_1.mask_.color = var_79_55
			end

			if arg_76_1.time_ >= var_79_52 + var_79_53 and arg_76_1.time_ < var_79_52 + var_79_53 + arg_79_0 then
				local var_79_56 = Color.New(0, 0, 0)
				local var_79_57 = 0

				arg_76_1.mask_.enabled = false
				var_79_56.a = var_79_57
				arg_76_1.mask_.color = var_79_56
			end

			if arg_76_1.frameCnt_ <= 1 then
				arg_76_1.dialog_:SetActive(false)
			end

			local var_79_58 = 4
			local var_79_59 = 0.4

			if var_79_58 < arg_76_1.time_ and arg_76_1.time_ <= var_79_58 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0

				arg_76_1.dialog_:SetActive(true)

				arg_76_1.dialogCg_.alpha = 0

				local var_79_60 = LeanTween.value(arg_76_1.dialog_, 0, 1, 0.3)

				var_79_60:setOnUpdate(LuaHelper.FloatAction(function(arg_80_0)
					arg_76_1.dialogCg_.alpha = arg_80_0
				end))
				var_79_60:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_76_1.dialog_)
					var_79_60:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_76_1.duration_ = arg_76_1.duration_ + 0.3

				SetActive(arg_76_1.leftNameGo_, true)

				local var_79_61 = arg_76_1:FormatText(StoryNameCfg[73].name)

				arg_76_1.leftNameTxt_.text = var_79_61

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_62 = arg_76_1:GetWordFromCfg(106122017)
				local var_79_63 = arg_76_1:FormatText(var_79_62.content)

				arg_76_1.text_.text = var_79_63

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_64 = 16
				local var_79_65 = utf8.len(var_79_63)
				local var_79_66 = var_79_64 <= 0 and var_79_59 or var_79_59 * (var_79_65 / var_79_64)

				if var_79_66 > 0 and var_79_59 < var_79_66 then
					arg_76_1.talkMaxDuration = var_79_66
					var_79_58 = var_79_58 + 0.3

					if var_79_66 + var_79_58 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_66 + var_79_58
					end
				end

				arg_76_1.text_.text = var_79_63
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106122", "106122017", "story_v_out_106122.awb") ~= 0 then
					local var_79_67 = manager.audio:GetVoiceLength("story_v_out_106122", "106122017", "story_v_out_106122.awb") / 1000

					if var_79_67 + var_79_58 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_67 + var_79_58
					end

					if var_79_62.prefab_name ~= "" and arg_76_1.actors_[var_79_62.prefab_name] ~= nil then
						local var_79_68 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_62.prefab_name].transform, "story_v_out_106122", "106122017", "story_v_out_106122.awb")

						arg_76_1:RecordAudio("106122017", var_79_68)
						arg_76_1:RecordAudio("106122017", var_79_68)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_106122", "106122017", "story_v_out_106122.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_106122", "106122017", "story_v_out_106122.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_69 = var_79_58 + 0.3
			local var_79_70 = math.max(var_79_59, arg_76_1.talkMaxDuration)

			if var_79_69 <= arg_76_1.time_ and arg_76_1.time_ < var_79_69 + var_79_70 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_69) / var_79_70

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_69 + var_79_70 and arg_76_1.time_ < var_79_69 + var_79_70 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4014_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_76_1:InitPlayNodeList()
	end,
	Play106122018 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 106122018
		arg_82_1.duration_ = 7

		local var_82_0 = {
			ja = 5.6,
			ko = 6,
			zh = 5.4,
			en = 7
		}
		local var_82_1 = manager.audio:GetLocalizationFlag()

		if var_82_0[var_82_1] ~= nil then
			arg_82_1.duration_ = var_82_0[var_82_1]
		end

		SetActive(arg_82_1.tipsGo_, false)

		function arg_82_1.onSingleLineFinish_()
			arg_82_1.onSingleLineUpdate_ = nil
			arg_82_1.onSingleLineFinish_ = nil
			arg_82_1.state_ = "waiting"
		end

		function arg_82_1.playNext_(arg_84_0)
			if arg_84_0 == 1 then
				arg_82_0:Play106122019(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			local var_85_0 = arg_82_1.actors_["4014_tpose"]
			local var_85_1 = 0

			if var_85_1 < arg_82_1.time_ and arg_82_1.time_ <= var_85_1 + arg_85_0 and not isNil(var_85_0) and arg_82_1.var_.characterEffect4014_tpose == nil then
				arg_82_1.var_.characterEffect4014_tpose = var_85_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_85_2 = 0.1

			if var_85_1 <= arg_82_1.time_ and arg_82_1.time_ < var_85_1 + var_85_2 and not isNil(var_85_0) then
				local var_85_3 = (arg_82_1.time_ - var_85_1) / var_85_2

				if arg_82_1.var_.characterEffect4014_tpose and not isNil(var_85_0) then
					arg_82_1.var_.characterEffect4014_tpose.fillFlat = false
				end
			end

			if arg_82_1.time_ >= var_85_1 + var_85_2 and arg_82_1.time_ < var_85_1 + var_85_2 + arg_85_0 and not isNil(var_85_0) and arg_82_1.var_.characterEffect4014_tpose then
				arg_82_1.var_.characterEffect4014_tpose.fillFlat = false
			end

			local var_85_4 = arg_82_1.actors_["1093ui_story"].transform
			local var_85_5 = 0

			if var_85_5 < arg_82_1.time_ and arg_82_1.time_ <= var_85_5 + arg_85_0 then
				arg_82_1.var_.moveOldPos1093ui_story = var_85_4.localPosition
			end

			local var_85_6 = 0.001

			if var_85_5 <= arg_82_1.time_ and arg_82_1.time_ < var_85_5 + var_85_6 then
				local var_85_7 = (arg_82_1.time_ - var_85_5) / var_85_6
				local var_85_8 = Vector3.New(0, 100, 0)

				var_85_4.localPosition = Vector3.Lerp(arg_82_1.var_.moveOldPos1093ui_story, var_85_8, var_85_7)

				local var_85_9 = manager.ui.mainCamera.transform.position - var_85_4.position

				var_85_4.forward = Vector3.New(var_85_9.x, var_85_9.y, var_85_9.z)

				local var_85_10 = var_85_4.localEulerAngles

				var_85_10.z = 0
				var_85_10.x = 0
				var_85_4.localEulerAngles = var_85_10
			end

			if arg_82_1.time_ >= var_85_5 + var_85_6 and arg_82_1.time_ < var_85_5 + var_85_6 + arg_85_0 then
				var_85_4.localPosition = Vector3.New(0, 100, 0)

				local var_85_11 = manager.ui.mainCamera.transform.position - var_85_4.position

				var_85_4.forward = Vector3.New(var_85_11.x, var_85_11.y, var_85_11.z)

				local var_85_12 = var_85_4.localEulerAngles

				var_85_12.z = 0
				var_85_12.x = 0
				var_85_4.localEulerAngles = var_85_12
			end

			local var_85_13 = arg_82_1.actors_["4014_tpose"].transform
			local var_85_14 = 0

			if var_85_14 < arg_82_1.time_ and arg_82_1.time_ <= var_85_14 + arg_85_0 then
				arg_82_1.var_.moveOldPos4014_tpose = var_85_13.localPosition

				local var_85_15 = GameObjectTools.GetOrAddComponent(var_85_13.gameObject, typeof(DynamicBoneHelper))

				if var_85_15 then
					var_85_15:EnableDynamicBone(false)
				end
			end

			local var_85_16 = 0.001

			if var_85_14 <= arg_82_1.time_ and arg_82_1.time_ < var_85_14 + var_85_16 then
				local var_85_17 = (arg_82_1.time_ - var_85_14) / var_85_16
				local var_85_18 = Vector3.New(0, -1.95, -4.2)

				var_85_13.localPosition = Vector3.Lerp(arg_82_1.var_.moveOldPos4014_tpose, var_85_18, var_85_17)

				local var_85_19 = manager.ui.mainCamera.transform.position - var_85_13.position

				var_85_13.forward = Vector3.New(var_85_19.x, var_85_19.y, var_85_19.z)

				local var_85_20 = var_85_13.localEulerAngles

				var_85_20.z = 0
				var_85_20.x = 0
				var_85_13.localEulerAngles = var_85_20
			end

			if arg_82_1.time_ >= var_85_14 + var_85_16 and arg_82_1.time_ < var_85_14 + var_85_16 + arg_85_0 then
				var_85_13.localPosition = Vector3.New(0, -1.95, -4.2)

				local var_85_21 = manager.ui.mainCamera.transform.position - var_85_13.position

				var_85_13.forward = Vector3.New(var_85_21.x, var_85_21.y, var_85_21.z)

				local var_85_22 = var_85_13.localEulerAngles

				var_85_22.z = 0
				var_85_22.x = 0
				var_85_13.localEulerAngles = var_85_22

				local var_85_23 = GameObjectTools.GetOrAddComponent(var_85_13.gameObject, typeof(DynamicBoneHelper))

				if var_85_23 then
					var_85_23:EnableDynamicBone(true)
				end
			end

			local var_85_24 = 0

			if var_85_24 < arg_82_1.time_ and arg_82_1.time_ <= var_85_24 + arg_85_0 then
				arg_82_1:PlayTimeline("4014_tpose", "StoryTimeline/CharAction/story4014/story4014action/4014action1_1")
			end

			local var_85_25 = 0
			local var_85_26 = 0.55

			if var_85_25 < arg_82_1.time_ and arg_82_1.time_ <= var_85_25 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				local var_85_27 = arg_82_1:FormatText(StoryNameCfg[87].name)

				arg_82_1.leftNameTxt_.text = var_85_27

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_28 = arg_82_1:GetWordFromCfg(106122018)
				local var_85_29 = arg_82_1:FormatText(var_85_28.content)

				arg_82_1.text_.text = var_85_29

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_30 = 22
				local var_85_31 = utf8.len(var_85_29)
				local var_85_32 = var_85_30 <= 0 and var_85_26 or var_85_26 * (var_85_31 / var_85_30)

				if var_85_32 > 0 and var_85_26 < var_85_32 then
					arg_82_1.talkMaxDuration = var_85_32

					if var_85_32 + var_85_25 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_32 + var_85_25
					end
				end

				arg_82_1.text_.text = var_85_29
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106122", "106122018", "story_v_out_106122.awb") ~= 0 then
					local var_85_33 = manager.audio:GetVoiceLength("story_v_out_106122", "106122018", "story_v_out_106122.awb") / 1000

					if var_85_33 + var_85_25 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_33 + var_85_25
					end

					if var_85_28.prefab_name ~= "" and arg_82_1.actors_[var_85_28.prefab_name] ~= nil then
						local var_85_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_82_1.actors_[var_85_28.prefab_name].transform, "story_v_out_106122", "106122018", "story_v_out_106122.awb")

						arg_82_1:RecordAudio("106122018", var_85_34)
						arg_82_1:RecordAudio("106122018", var_85_34)
					else
						arg_82_1:AudioAction("play", "voice", "story_v_out_106122", "106122018", "story_v_out_106122.awb")
					end

					arg_82_1:RecordHistoryTalkVoice("story_v_out_106122", "106122018", "story_v_out_106122.awb")
				end

				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_35 = math.max(var_85_26, arg_82_1.talkMaxDuration)

			if var_85_25 <= arg_82_1.time_ and arg_82_1.time_ < var_85_25 + var_85_35 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_25) / var_85_35

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_25 + var_85_35 and arg_82_1.time_ < var_85_25 + var_85_35 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4014_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_82_1:InitPlayNodeList()
	end,
	Play106122019 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 106122019
		arg_86_1.duration_ = 12.53

		local var_86_0 = {
			ja = 9.8,
			ko = 12.533,
			zh = 10.6,
			en = 10.366
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
				arg_86_0:Play106122020(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			local var_89_0 = 0
			local var_89_1 = 1.05

			if var_89_0 < arg_86_1.time_ and arg_86_1.time_ <= var_89_0 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, true)

				local var_89_2 = arg_86_1:FormatText(StoryNameCfg[87].name)

				arg_86_1.leftNameTxt_.text = var_89_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_3 = arg_86_1:GetWordFromCfg(106122019)
				local var_89_4 = arg_86_1:FormatText(var_89_3.content)

				arg_86_1.text_.text = var_89_4

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_5 = 42
				local var_89_6 = utf8.len(var_89_4)
				local var_89_7 = var_89_5 <= 0 and var_89_1 or var_89_1 * (var_89_6 / var_89_5)

				if var_89_7 > 0 and var_89_1 < var_89_7 then
					arg_86_1.talkMaxDuration = var_89_7

					if var_89_7 + var_89_0 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_7 + var_89_0
					end
				end

				arg_86_1.text_.text = var_89_4
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106122", "106122019", "story_v_out_106122.awb") ~= 0 then
					local var_89_8 = manager.audio:GetVoiceLength("story_v_out_106122", "106122019", "story_v_out_106122.awb") / 1000

					if var_89_8 + var_89_0 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_8 + var_89_0
					end

					if var_89_3.prefab_name ~= "" and arg_86_1.actors_[var_89_3.prefab_name] ~= nil then
						local var_89_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_86_1.actors_[var_89_3.prefab_name].transform, "story_v_out_106122", "106122019", "story_v_out_106122.awb")

						arg_86_1:RecordAudio("106122019", var_89_9)
						arg_86_1:RecordAudio("106122019", var_89_9)
					else
						arg_86_1:AudioAction("play", "voice", "story_v_out_106122", "106122019", "story_v_out_106122.awb")
					end

					arg_86_1:RecordHistoryTalkVoice("story_v_out_106122", "106122019", "story_v_out_106122.awb")
				end

				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_10 = math.max(var_89_1, arg_86_1.talkMaxDuration)

			if var_89_0 <= arg_86_1.time_ and arg_86_1.time_ < var_89_0 + var_89_10 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_0) / var_89_10

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_0 + var_89_10 and arg_86_1.time_ < var_89_0 + var_89_10 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {}

		arg_86_1:InitPlayNodeList()
	end,
	Play106122020 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 106122020
		arg_90_1.duration_ = 5.7

		local var_90_0 = {
			ja = 5.7,
			ko = 4.8,
			zh = 4.333,
			en = 5.633
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
				arg_90_0:Play106122021(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			local var_93_0 = 0
			local var_93_1 = 0.475

			if var_93_0 < arg_90_1.time_ and arg_90_1.time_ <= var_93_0 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				local var_93_2 = arg_90_1:FormatText(StoryNameCfg[87].name)

				arg_90_1.leftNameTxt_.text = var_93_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_3 = arg_90_1:GetWordFromCfg(106122020)
				local var_93_4 = arg_90_1:FormatText(var_93_3.content)

				arg_90_1.text_.text = var_93_4

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_5 = 19
				local var_93_6 = utf8.len(var_93_4)
				local var_93_7 = var_93_5 <= 0 and var_93_1 or var_93_1 * (var_93_6 / var_93_5)

				if var_93_7 > 0 and var_93_1 < var_93_7 then
					arg_90_1.talkMaxDuration = var_93_7

					if var_93_7 + var_93_0 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_7 + var_93_0
					end
				end

				arg_90_1.text_.text = var_93_4
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106122", "106122020", "story_v_out_106122.awb") ~= 0 then
					local var_93_8 = manager.audio:GetVoiceLength("story_v_out_106122", "106122020", "story_v_out_106122.awb") / 1000

					if var_93_8 + var_93_0 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_8 + var_93_0
					end

					if var_93_3.prefab_name ~= "" and arg_90_1.actors_[var_93_3.prefab_name] ~= nil then
						local var_93_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_90_1.actors_[var_93_3.prefab_name].transform, "story_v_out_106122", "106122020", "story_v_out_106122.awb")

						arg_90_1:RecordAudio("106122020", var_93_9)
						arg_90_1:RecordAudio("106122020", var_93_9)
					else
						arg_90_1:AudioAction("play", "voice", "story_v_out_106122", "106122020", "story_v_out_106122.awb")
					end

					arg_90_1:RecordHistoryTalkVoice("story_v_out_106122", "106122020", "story_v_out_106122.awb")
				end

				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_10 = math.max(var_93_1, arg_90_1.talkMaxDuration)

			if var_93_0 <= arg_90_1.time_ and arg_90_1.time_ < var_93_0 + var_93_10 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_0) / var_93_10

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_0 + var_93_10 and arg_90_1.time_ < var_93_0 + var_93_10 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {}

		arg_90_1:InitPlayNodeList()
	end,
	Play106122021 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 106122021
		arg_94_1.duration_ = 5.63

		local var_94_0 = {
			ja = 4.366,
			ko = 3.633,
			zh = 2.733,
			en = 5.633
		}
		local var_94_1 = manager.audio:GetLocalizationFlag()

		if var_94_0[var_94_1] ~= nil then
			arg_94_1.duration_ = var_94_0[var_94_1]
		end

		SetActive(arg_94_1.tipsGo_, false)

		function arg_94_1.onSingleLineFinish_()
			arg_94_1.onSingleLineUpdate_ = nil
			arg_94_1.onSingleLineFinish_ = nil
			arg_94_1.state_ = "waiting"
		end

		function arg_94_1.playNext_(arg_96_0)
			if arg_96_0 == 1 then
				arg_94_0:Play106122022(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			local var_97_0 = arg_94_1.actors_["1093ui_story"]
			local var_97_1 = 0

			if var_97_1 < arg_94_1.time_ and arg_94_1.time_ <= var_97_1 + arg_97_0 and not isNil(var_97_0) and arg_94_1.var_.characterEffect1093ui_story == nil then
				arg_94_1.var_.characterEffect1093ui_story = var_97_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_97_2 = 0.1

			if var_97_1 <= arg_94_1.time_ and arg_94_1.time_ < var_97_1 + var_97_2 and not isNil(var_97_0) then
				local var_97_3 = (arg_94_1.time_ - var_97_1) / var_97_2

				if arg_94_1.var_.characterEffect1093ui_story and not isNil(var_97_0) then
					arg_94_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_94_1.time_ >= var_97_1 + var_97_2 and arg_94_1.time_ < var_97_1 + var_97_2 + arg_97_0 and not isNil(var_97_0) and arg_94_1.var_.characterEffect1093ui_story then
				arg_94_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_97_4 = arg_94_1.actors_["4014_tpose"]
			local var_97_5 = 0

			if var_97_5 < arg_94_1.time_ and arg_94_1.time_ <= var_97_5 + arg_97_0 and not isNil(var_97_4) and arg_94_1.var_.characterEffect4014_tpose == nil then
				arg_94_1.var_.characterEffect4014_tpose = var_97_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_97_6 = 0.1

			if var_97_5 <= arg_94_1.time_ and arg_94_1.time_ < var_97_5 + var_97_6 and not isNil(var_97_4) then
				local var_97_7 = (arg_94_1.time_ - var_97_5) / var_97_6

				if arg_94_1.var_.characterEffect4014_tpose and not isNil(var_97_4) then
					local var_97_8 = Mathf.Lerp(0, 0.5, var_97_7)

					arg_94_1.var_.characterEffect4014_tpose.fillFlat = true
					arg_94_1.var_.characterEffect4014_tpose.fillRatio = var_97_8
				end
			end

			if arg_94_1.time_ >= var_97_5 + var_97_6 and arg_94_1.time_ < var_97_5 + var_97_6 + arg_97_0 and not isNil(var_97_4) and arg_94_1.var_.characterEffect4014_tpose then
				local var_97_9 = 0.5

				arg_94_1.var_.characterEffect4014_tpose.fillFlat = true
				arg_94_1.var_.characterEffect4014_tpose.fillRatio = var_97_9
			end

			local var_97_10 = arg_94_1.actors_["4014_tpose"].transform
			local var_97_11 = 0

			if var_97_11 < arg_94_1.time_ and arg_94_1.time_ <= var_97_11 + arg_97_0 then
				arg_94_1.var_.moveOldPos4014_tpose = var_97_10.localPosition

				local var_97_12 = GameObjectTools.GetOrAddComponent(var_97_10.gameObject, typeof(DynamicBoneHelper))

				if var_97_12 then
					var_97_12:EnableDynamicBone(false)
				end
			end

			local var_97_13 = 0.001

			if var_97_11 <= arg_94_1.time_ and arg_94_1.time_ < var_97_11 + var_97_13 then
				local var_97_14 = (arg_94_1.time_ - var_97_11) / var_97_13
				local var_97_15 = Vector3.New(0, 100, 0)

				var_97_10.localPosition = Vector3.Lerp(arg_94_1.var_.moveOldPos4014_tpose, var_97_15, var_97_14)

				local var_97_16 = manager.ui.mainCamera.transform.position - var_97_10.position

				var_97_10.forward = Vector3.New(var_97_16.x, var_97_16.y, var_97_16.z)

				local var_97_17 = var_97_10.localEulerAngles

				var_97_17.z = 0
				var_97_17.x = 0
				var_97_10.localEulerAngles = var_97_17
			end

			if arg_94_1.time_ >= var_97_11 + var_97_13 and arg_94_1.time_ < var_97_11 + var_97_13 + arg_97_0 then
				var_97_10.localPosition = Vector3.New(0, 100, 0)

				local var_97_18 = manager.ui.mainCamera.transform.position - var_97_10.position

				var_97_10.forward = Vector3.New(var_97_18.x, var_97_18.y, var_97_18.z)

				local var_97_19 = var_97_10.localEulerAngles

				var_97_19.z = 0
				var_97_19.x = 0
				var_97_10.localEulerAngles = var_97_19

				local var_97_20 = GameObjectTools.GetOrAddComponent(var_97_10.gameObject, typeof(DynamicBoneHelper))

				if var_97_20 then
					var_97_20:EnableDynamicBone(true)
				end
			end

			local var_97_21 = arg_94_1.actors_["1093ui_story"].transform
			local var_97_22 = 0

			if var_97_22 < arg_94_1.time_ and arg_94_1.time_ <= var_97_22 + arg_97_0 then
				arg_94_1.var_.moveOldPos1093ui_story = var_97_21.localPosition

				local var_97_23 = "1093ui_story"

				arg_94_1:ShowWeapon(arg_94_1.var_[var_97_23 .. "Animator"].transform, true)
			end

			local var_97_24 = 0.001

			if var_97_22 <= arg_94_1.time_ and arg_94_1.time_ < var_97_22 + var_97_24 then
				local var_97_25 = (arg_94_1.time_ - var_97_22) / var_97_24
				local var_97_26 = Vector3.New(0, -1.11, -5.88)

				var_97_21.localPosition = Vector3.Lerp(arg_94_1.var_.moveOldPos1093ui_story, var_97_26, var_97_25)

				local var_97_27 = manager.ui.mainCamera.transform.position - var_97_21.position

				var_97_21.forward = Vector3.New(var_97_27.x, var_97_27.y, var_97_27.z)

				local var_97_28 = var_97_21.localEulerAngles

				var_97_28.z = 0
				var_97_28.x = 0
				var_97_21.localEulerAngles = var_97_28
			end

			if arg_94_1.time_ >= var_97_22 + var_97_24 and arg_94_1.time_ < var_97_22 + var_97_24 + arg_97_0 then
				var_97_21.localPosition = Vector3.New(0, -1.11, -5.88)

				local var_97_29 = manager.ui.mainCamera.transform.position - var_97_21.position

				var_97_21.forward = Vector3.New(var_97_29.x, var_97_29.y, var_97_29.z)

				local var_97_30 = var_97_21.localEulerAngles

				var_97_30.z = 0
				var_97_30.x = 0
				var_97_21.localEulerAngles = var_97_30
			end

			local var_97_31 = 0

			if var_97_31 < arg_94_1.time_ and arg_94_1.time_ <= var_97_31 + arg_97_0 then
				arg_94_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action10_2")
			end

			local var_97_32 = 0

			if var_97_32 < arg_94_1.time_ and arg_94_1.time_ <= var_97_32 + arg_97_0 then
				arg_94_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2202cva")
			end

			local var_97_33 = 0
			local var_97_34 = 0.35

			if var_97_33 < arg_94_1.time_ and arg_94_1.time_ <= var_97_33 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				local var_97_35 = arg_94_1:FormatText(StoryNameCfg[73].name)

				arg_94_1.leftNameTxt_.text = var_97_35

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_36 = arg_94_1:GetWordFromCfg(106122021)
				local var_97_37 = arg_94_1:FormatText(var_97_36.content)

				arg_94_1.text_.text = var_97_37

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_38 = 14
				local var_97_39 = utf8.len(var_97_37)
				local var_97_40 = var_97_38 <= 0 and var_97_34 or var_97_34 * (var_97_39 / var_97_38)

				if var_97_40 > 0 and var_97_34 < var_97_40 then
					arg_94_1.talkMaxDuration = var_97_40

					if var_97_40 + var_97_33 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_40 + var_97_33
					end
				end

				arg_94_1.text_.text = var_97_37
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106122", "106122021", "story_v_out_106122.awb") ~= 0 then
					local var_97_41 = manager.audio:GetVoiceLength("story_v_out_106122", "106122021", "story_v_out_106122.awb") / 1000

					if var_97_41 + var_97_33 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_41 + var_97_33
					end

					if var_97_36.prefab_name ~= "" and arg_94_1.actors_[var_97_36.prefab_name] ~= nil then
						local var_97_42 = LuaForUtil.PlayVoiceWithCriLipsync(arg_94_1.actors_[var_97_36.prefab_name].transform, "story_v_out_106122", "106122021", "story_v_out_106122.awb")

						arg_94_1:RecordAudio("106122021", var_97_42)
						arg_94_1:RecordAudio("106122021", var_97_42)
					else
						arg_94_1:AudioAction("play", "voice", "story_v_out_106122", "106122021", "story_v_out_106122.awb")
					end

					arg_94_1:RecordHistoryTalkVoice("story_v_out_106122", "106122021", "story_v_out_106122.awb")
				end

				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_43 = math.max(var_97_34, arg_94_1.talkMaxDuration)

			if var_97_33 <= arg_94_1.time_ and arg_94_1.time_ < var_97_33 + var_97_43 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_33) / var_97_43

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_33 + var_97_43 and arg_94_1.time_ < var_97_33 + var_97_43 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4014_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_94_1:InitPlayNodeList()
	end,
	Play106122022 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 106122022
		arg_98_1.duration_ = 10.07

		local var_98_0 = {
			ja = 4.033,
			ko = 10.066,
			zh = 7.7,
			en = 9.3
		}
		local var_98_1 = manager.audio:GetLocalizationFlag()

		if var_98_0[var_98_1] ~= nil then
			arg_98_1.duration_ = var_98_0[var_98_1]
		end

		SetActive(arg_98_1.tipsGo_, false)

		function arg_98_1.onSingleLineFinish_()
			arg_98_1.onSingleLineUpdate_ = nil
			arg_98_1.onSingleLineFinish_ = nil
			arg_98_1.state_ = "waiting"
		end

		function arg_98_1.playNext_(arg_100_0)
			if arg_100_0 == 1 then
				arg_98_0:Play106122023(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			local var_101_0 = arg_98_1.actors_["4014_tpose"]
			local var_101_1 = 0

			if var_101_1 < arg_98_1.time_ and arg_98_1.time_ <= var_101_1 + arg_101_0 and not isNil(var_101_0) and arg_98_1.var_.characterEffect4014_tpose == nil then
				arg_98_1.var_.characterEffect4014_tpose = var_101_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_101_2 = 0.1

			if var_101_1 <= arg_98_1.time_ and arg_98_1.time_ < var_101_1 + var_101_2 and not isNil(var_101_0) then
				local var_101_3 = (arg_98_1.time_ - var_101_1) / var_101_2

				if arg_98_1.var_.characterEffect4014_tpose and not isNil(var_101_0) then
					arg_98_1.var_.characterEffect4014_tpose.fillFlat = false
				end
			end

			if arg_98_1.time_ >= var_101_1 + var_101_2 and arg_98_1.time_ < var_101_1 + var_101_2 + arg_101_0 and not isNil(var_101_0) and arg_98_1.var_.characterEffect4014_tpose then
				arg_98_1.var_.characterEffect4014_tpose.fillFlat = false
			end

			local var_101_4 = arg_98_1.actors_["1093ui_story"]
			local var_101_5 = 0

			if var_101_5 < arg_98_1.time_ and arg_98_1.time_ <= var_101_5 + arg_101_0 and not isNil(var_101_4) and arg_98_1.var_.characterEffect1093ui_story == nil then
				arg_98_1.var_.characterEffect1093ui_story = var_101_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_101_6 = 0.1

			if var_101_5 <= arg_98_1.time_ and arg_98_1.time_ < var_101_5 + var_101_6 and not isNil(var_101_4) then
				local var_101_7 = (arg_98_1.time_ - var_101_5) / var_101_6

				if arg_98_1.var_.characterEffect1093ui_story and not isNil(var_101_4) then
					local var_101_8 = Mathf.Lerp(0, 0.5, var_101_7)

					arg_98_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_98_1.var_.characterEffect1093ui_story.fillRatio = var_101_8
				end
			end

			if arg_98_1.time_ >= var_101_5 + var_101_6 and arg_98_1.time_ < var_101_5 + var_101_6 + arg_101_0 and not isNil(var_101_4) and arg_98_1.var_.characterEffect1093ui_story then
				local var_101_9 = 0.5

				arg_98_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_98_1.var_.characterEffect1093ui_story.fillRatio = var_101_9
			end

			local var_101_10 = arg_98_1.actors_["1093ui_story"].transform
			local var_101_11 = 0

			if var_101_11 < arg_98_1.time_ and arg_98_1.time_ <= var_101_11 + arg_101_0 then
				arg_98_1.var_.moveOldPos1093ui_story = var_101_10.localPosition

				local var_101_12 = "1093ui_story"

				arg_98_1:ShowWeapon(arg_98_1.var_[var_101_12 .. "Animator"].transform, true)
			end

			local var_101_13 = 0.001

			if var_101_11 <= arg_98_1.time_ and arg_98_1.time_ < var_101_11 + var_101_13 then
				local var_101_14 = (arg_98_1.time_ - var_101_11) / var_101_13
				local var_101_15 = Vector3.New(0, 100, 0)

				var_101_10.localPosition = Vector3.Lerp(arg_98_1.var_.moveOldPos1093ui_story, var_101_15, var_101_14)

				local var_101_16 = manager.ui.mainCamera.transform.position - var_101_10.position

				var_101_10.forward = Vector3.New(var_101_16.x, var_101_16.y, var_101_16.z)

				local var_101_17 = var_101_10.localEulerAngles

				var_101_17.z = 0
				var_101_17.x = 0
				var_101_10.localEulerAngles = var_101_17
			end

			if arg_98_1.time_ >= var_101_11 + var_101_13 and arg_98_1.time_ < var_101_11 + var_101_13 + arg_101_0 then
				var_101_10.localPosition = Vector3.New(0, 100, 0)

				local var_101_18 = manager.ui.mainCamera.transform.position - var_101_10.position

				var_101_10.forward = Vector3.New(var_101_18.x, var_101_18.y, var_101_18.z)

				local var_101_19 = var_101_10.localEulerAngles

				var_101_19.z = 0
				var_101_19.x = 0
				var_101_10.localEulerAngles = var_101_19
			end

			local var_101_20 = arg_98_1.actors_["4014_tpose"].transform
			local var_101_21 = 0

			if var_101_21 < arg_98_1.time_ and arg_98_1.time_ <= var_101_21 + arg_101_0 then
				arg_98_1.var_.moveOldPos4014_tpose = var_101_20.localPosition

				local var_101_22 = GameObjectTools.GetOrAddComponent(var_101_20.gameObject, typeof(DynamicBoneHelper))

				if var_101_22 then
					var_101_22:EnableDynamicBone(false)
				end
			end

			local var_101_23 = 0.001

			if var_101_21 <= arg_98_1.time_ and arg_98_1.time_ < var_101_21 + var_101_23 then
				local var_101_24 = (arg_98_1.time_ - var_101_21) / var_101_23
				local var_101_25 = Vector3.New(0, -1.95, -4.2)

				var_101_20.localPosition = Vector3.Lerp(arg_98_1.var_.moveOldPos4014_tpose, var_101_25, var_101_24)

				local var_101_26 = manager.ui.mainCamera.transform.position - var_101_20.position

				var_101_20.forward = Vector3.New(var_101_26.x, var_101_26.y, var_101_26.z)

				local var_101_27 = var_101_20.localEulerAngles

				var_101_27.z = 0
				var_101_27.x = 0
				var_101_20.localEulerAngles = var_101_27
			end

			if arg_98_1.time_ >= var_101_21 + var_101_23 and arg_98_1.time_ < var_101_21 + var_101_23 + arg_101_0 then
				var_101_20.localPosition = Vector3.New(0, -1.95, -4.2)

				local var_101_28 = manager.ui.mainCamera.transform.position - var_101_20.position

				var_101_20.forward = Vector3.New(var_101_28.x, var_101_28.y, var_101_28.z)

				local var_101_29 = var_101_20.localEulerAngles

				var_101_29.z = 0
				var_101_29.x = 0
				var_101_20.localEulerAngles = var_101_29

				local var_101_30 = GameObjectTools.GetOrAddComponent(var_101_20.gameObject, typeof(DynamicBoneHelper))

				if var_101_30 then
					var_101_30:EnableDynamicBone(true)
				end
			end

			local var_101_31 = 0

			if var_101_31 < arg_98_1.time_ and arg_98_1.time_ <= var_101_31 + arg_101_0 then
				arg_98_1:PlayTimeline("4014_tpose", "StoryTimeline/CharAction/story4014/story4014action/4014action1_1")
			end

			local var_101_32 = 0
			local var_101_33 = 0.725

			if var_101_32 < arg_98_1.time_ and arg_98_1.time_ <= var_101_32 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				local var_101_34 = arg_98_1:FormatText(StoryNameCfg[87].name)

				arg_98_1.leftNameTxt_.text = var_101_34

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_35 = arg_98_1:GetWordFromCfg(106122022)
				local var_101_36 = arg_98_1:FormatText(var_101_35.content)

				arg_98_1.text_.text = var_101_36

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_37 = 29
				local var_101_38 = utf8.len(var_101_36)
				local var_101_39 = var_101_37 <= 0 and var_101_33 or var_101_33 * (var_101_38 / var_101_37)

				if var_101_39 > 0 and var_101_33 < var_101_39 then
					arg_98_1.talkMaxDuration = var_101_39

					if var_101_39 + var_101_32 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_39 + var_101_32
					end
				end

				arg_98_1.text_.text = var_101_36
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106122", "106122022", "story_v_out_106122.awb") ~= 0 then
					local var_101_40 = manager.audio:GetVoiceLength("story_v_out_106122", "106122022", "story_v_out_106122.awb") / 1000

					if var_101_40 + var_101_32 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_40 + var_101_32
					end

					if var_101_35.prefab_name ~= "" and arg_98_1.actors_[var_101_35.prefab_name] ~= nil then
						local var_101_41 = LuaForUtil.PlayVoiceWithCriLipsync(arg_98_1.actors_[var_101_35.prefab_name].transform, "story_v_out_106122", "106122022", "story_v_out_106122.awb")

						arg_98_1:RecordAudio("106122022", var_101_41)
						arg_98_1:RecordAudio("106122022", var_101_41)
					else
						arg_98_1:AudioAction("play", "voice", "story_v_out_106122", "106122022", "story_v_out_106122.awb")
					end

					arg_98_1:RecordHistoryTalkVoice("story_v_out_106122", "106122022", "story_v_out_106122.awb")
				end

				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_42 = math.max(var_101_33, arg_98_1.talkMaxDuration)

			if var_101_32 <= arg_98_1.time_ and arg_98_1.time_ < var_101_32 + var_101_42 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_32) / var_101_42

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_32 + var_101_42 and arg_98_1.time_ < var_101_32 + var_101_42 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4014_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_98_1:InitPlayNodeList()
	end,
	Play106122023 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 106122023
		arg_102_1.duration_ = 2.47

		local var_102_0 = {
			ja = 2.466,
			ko = 1.5,
			zh = 1.4,
			en = 1.4
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
				arg_102_0:Play106122024(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			local var_105_0 = arg_102_1.actors_["4014_tpose"]
			local var_105_1 = 0

			if var_105_1 < arg_102_1.time_ and arg_102_1.time_ <= var_105_1 + arg_105_0 and not isNil(var_105_0) and arg_102_1.var_.characterEffect4014_tpose == nil then
				arg_102_1.var_.characterEffect4014_tpose = var_105_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_105_2 = 0.1

			if var_105_1 <= arg_102_1.time_ and arg_102_1.time_ < var_105_1 + var_105_2 and not isNil(var_105_0) then
				local var_105_3 = (arg_102_1.time_ - var_105_1) / var_105_2

				if arg_102_1.var_.characterEffect4014_tpose and not isNil(var_105_0) then
					local var_105_4 = Mathf.Lerp(0, 0.5, var_105_3)

					arg_102_1.var_.characterEffect4014_tpose.fillFlat = true
					arg_102_1.var_.characterEffect4014_tpose.fillRatio = var_105_4
				end
			end

			if arg_102_1.time_ >= var_105_1 + var_105_2 and arg_102_1.time_ < var_105_1 + var_105_2 + arg_105_0 and not isNil(var_105_0) and arg_102_1.var_.characterEffect4014_tpose then
				local var_105_5 = 0.5

				arg_102_1.var_.characterEffect4014_tpose.fillFlat = true
				arg_102_1.var_.characterEffect4014_tpose.fillRatio = var_105_5
			end

			local var_105_6 = arg_102_1.actors_["4014_tpose"].transform
			local var_105_7 = 0

			if var_105_7 < arg_102_1.time_ and arg_102_1.time_ <= var_105_7 + arg_105_0 then
				arg_102_1.var_.moveOldPos4014_tpose = var_105_6.localPosition

				local var_105_8 = GameObjectTools.GetOrAddComponent(var_105_6.gameObject, typeof(DynamicBoneHelper))

				if var_105_8 then
					var_105_8:EnableDynamicBone(false)
				end
			end

			local var_105_9 = 0.001

			if var_105_7 <= arg_102_1.time_ and arg_102_1.time_ < var_105_7 + var_105_9 then
				local var_105_10 = (arg_102_1.time_ - var_105_7) / var_105_9
				local var_105_11 = Vector3.New(0, 100, 0)

				var_105_6.localPosition = Vector3.Lerp(arg_102_1.var_.moveOldPos4014_tpose, var_105_11, var_105_10)

				local var_105_12 = manager.ui.mainCamera.transform.position - var_105_6.position

				var_105_6.forward = Vector3.New(var_105_12.x, var_105_12.y, var_105_12.z)

				local var_105_13 = var_105_6.localEulerAngles

				var_105_13.z = 0
				var_105_13.x = 0
				var_105_6.localEulerAngles = var_105_13
			end

			if arg_102_1.time_ >= var_105_7 + var_105_9 and arg_102_1.time_ < var_105_7 + var_105_9 + arg_105_0 then
				var_105_6.localPosition = Vector3.New(0, 100, 0)

				local var_105_14 = manager.ui.mainCamera.transform.position - var_105_6.position

				var_105_6.forward = Vector3.New(var_105_14.x, var_105_14.y, var_105_14.z)

				local var_105_15 = var_105_6.localEulerAngles

				var_105_15.z = 0
				var_105_15.x = 0
				var_105_6.localEulerAngles = var_105_15

				local var_105_16 = GameObjectTools.GetOrAddComponent(var_105_6.gameObject, typeof(DynamicBoneHelper))

				if var_105_16 then
					var_105_16:EnableDynamicBone(true)
				end
			end

			local var_105_17 = 0
			local var_105_18 = 0.075

			if var_105_17 < arg_102_1.time_ and arg_102_1.time_ <= var_105_17 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				local var_105_19 = arg_102_1:FormatText(StoryNameCfg[73].name)

				arg_102_1.leftNameTxt_.text = var_105_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, true)
				arg_102_1.iconController_:SetSelectedState("hero")

				arg_102_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1093")

				arg_102_1.callingController_:SetSelectedState("normal")

				arg_102_1.keyicon_.color = Color.New(1, 1, 1)
				arg_102_1.icon_.color = Color.New(1, 1, 1)

				local var_105_20 = arg_102_1:GetWordFromCfg(106122023)
				local var_105_21 = arg_102_1:FormatText(var_105_20.content)

				arg_102_1.text_.text = var_105_21

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_22 = 3
				local var_105_23 = utf8.len(var_105_21)
				local var_105_24 = var_105_22 <= 0 and var_105_18 or var_105_18 * (var_105_23 / var_105_22)

				if var_105_24 > 0 and var_105_18 < var_105_24 then
					arg_102_1.talkMaxDuration = var_105_24

					if var_105_24 + var_105_17 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_24 + var_105_17
					end
				end

				arg_102_1.text_.text = var_105_21
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106122", "106122023", "story_v_out_106122.awb") ~= 0 then
					local var_105_25 = manager.audio:GetVoiceLength("story_v_out_106122", "106122023", "story_v_out_106122.awb") / 1000

					if var_105_25 + var_105_17 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_25 + var_105_17
					end

					if var_105_20.prefab_name ~= "" and arg_102_1.actors_[var_105_20.prefab_name] ~= nil then
						local var_105_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_102_1.actors_[var_105_20.prefab_name].transform, "story_v_out_106122", "106122023", "story_v_out_106122.awb")

						arg_102_1:RecordAudio("106122023", var_105_26)
						arg_102_1:RecordAudio("106122023", var_105_26)
					else
						arg_102_1:AudioAction("play", "voice", "story_v_out_106122", "106122023", "story_v_out_106122.awb")
					end

					arg_102_1:RecordHistoryTalkVoice("story_v_out_106122", "106122023", "story_v_out_106122.awb")
				end

				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_27 = math.max(var_105_18, arg_102_1.talkMaxDuration)

			if var_105_17 <= arg_102_1.time_ and arg_102_1.time_ < var_105_17 + var_105_27 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_17) / var_105_27

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_17 + var_105_27 and arg_102_1.time_ < var_105_17 + var_105_27 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4014_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_102_1:InitPlayNodeList()
	end,
	Play106122024 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 106122024
		arg_106_1.duration_ = 5

		SetActive(arg_106_1.tipsGo_, false)

		function arg_106_1.onSingleLineFinish_()
			arg_106_1.onSingleLineUpdate_ = nil
			arg_106_1.onSingleLineFinish_ = nil
			arg_106_1.state_ = "waiting"
		end

		function arg_106_1.playNext_(arg_108_0)
			if arg_108_0 == 1 then
				arg_106_0:Play106122025(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			local var_109_0 = manager.ui.mainCamera.transform
			local var_109_1 = 0

			if var_109_1 < arg_106_1.time_ and arg_106_1.time_ <= var_109_1 + arg_109_0 then
				arg_106_1.var_.shakeOldPos = var_109_0.localPosition
			end

			local var_109_2 = 0.6

			if var_109_1 <= arg_106_1.time_ and arg_106_1.time_ < var_109_1 + var_109_2 then
				local var_109_3 = (arg_106_1.time_ - var_109_1) / 0.066
				local var_109_4, var_109_5 = math.modf(var_109_3)

				var_109_0.localPosition = Vector3.New(var_109_5 * 0.13, var_109_5 * 0.13, var_109_5 * 0.13) + arg_106_1.var_.shakeOldPos
			end

			if arg_106_1.time_ >= var_109_1 + var_109_2 and arg_106_1.time_ < var_109_1 + var_109_2 + arg_109_0 then
				var_109_0.localPosition = arg_106_1.var_.shakeOldPos
			end

			local var_109_6 = 0

			if var_109_6 < arg_106_1.time_ and arg_106_1.time_ <= var_109_6 + arg_109_0 then
				arg_106_1.mask_.enabled = true
				arg_106_1.mask_.raycastTarget = true

				arg_106_1:SetGaussion(false)
			end

			local var_109_7 = 0.5

			if var_109_6 <= arg_106_1.time_ and arg_106_1.time_ < var_109_6 + var_109_7 then
				local var_109_8 = (arg_106_1.time_ - var_109_6) / var_109_7
				local var_109_9 = Color.New(1, 1, 1)

				var_109_9.a = Mathf.Lerp(1, 0, var_109_8)
				arg_106_1.mask_.color = var_109_9
			end

			if arg_106_1.time_ >= var_109_6 + var_109_7 and arg_106_1.time_ < var_109_6 + var_109_7 + arg_109_0 then
				local var_109_10 = Color.New(1, 1, 1)
				local var_109_11 = 0

				arg_106_1.mask_.enabled = false
				var_109_10.a = var_109_11
				arg_106_1.mask_.color = var_109_10
			end

			local var_109_12 = 0
			local var_109_13 = 1

			if var_109_12 < arg_106_1.time_ and arg_106_1.time_ <= var_109_12 + arg_109_0 then
				local var_109_14 = "play"
				local var_109_15 = "effect"

				arg_106_1:AudioAction(var_109_14, var_109_15, "se_story_6", "se_story_6_blast", "")
			end

			local var_109_16 = 0
			local var_109_17 = 0.775

			if var_109_16 < arg_106_1.time_ and arg_106_1.time_ <= var_109_16 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, false)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_18 = arg_106_1:GetWordFromCfg(106122024)
				local var_109_19 = arg_106_1:FormatText(var_109_18.content)

				arg_106_1.text_.text = var_109_19

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_20 = 31
				local var_109_21 = utf8.len(var_109_19)
				local var_109_22 = var_109_20 <= 0 and var_109_17 or var_109_17 * (var_109_21 / var_109_20)

				if var_109_22 > 0 and var_109_17 < var_109_22 then
					arg_106_1.talkMaxDuration = var_109_22

					if var_109_22 + var_109_16 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_22 + var_109_16
					end
				end

				arg_106_1.text_.text = var_109_19
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)
				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_23 = math.max(var_109_17, arg_106_1.talkMaxDuration)

			if var_109_16 <= arg_106_1.time_ and arg_106_1.time_ < var_109_16 + var_109_23 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_16) / var_109_23

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_16 + var_109_23 and arg_106_1.time_ < var_109_16 + var_109_23 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {}

		arg_106_1:InitPlayNodeList()
	end,
	Play106122025 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 106122025
		arg_110_1.duration_ = 5

		SetActive(arg_110_1.tipsGo_, false)

		function arg_110_1.onSingleLineFinish_()
			arg_110_1.onSingleLineUpdate_ = nil
			arg_110_1.onSingleLineFinish_ = nil
			arg_110_1.state_ = "waiting"
		end

		function arg_110_1.playNext_(arg_112_0)
			if arg_112_0 == 1 then
				arg_110_0:Play106122026(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			local var_113_0 = 0
			local var_113_1 = 1

			if var_113_0 < arg_110_1.time_ and arg_110_1.time_ <= var_113_0 + arg_113_0 then
				local var_113_2 = "play"
				local var_113_3 = "effect"

				arg_110_1:AudioAction(var_113_2, var_113_3, "se_story_6", "se_story_6_Impale", "")
			end

			local var_113_4 = 0
			local var_113_5 = 0.725

			if var_113_4 < arg_110_1.time_ and arg_110_1.time_ <= var_113_4 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, false)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_110_1.iconTrs_.gameObject, false)
				arg_110_1.callingController_:SetSelectedState("normal")

				local var_113_6 = arg_110_1:GetWordFromCfg(106122025)
				local var_113_7 = arg_110_1:FormatText(var_113_6.content)

				arg_110_1.text_.text = var_113_7

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_8 = 29
				local var_113_9 = utf8.len(var_113_7)
				local var_113_10 = var_113_8 <= 0 and var_113_5 or var_113_5 * (var_113_9 / var_113_8)

				if var_113_10 > 0 and var_113_5 < var_113_10 then
					arg_110_1.talkMaxDuration = var_113_10

					if var_113_10 + var_113_4 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_10 + var_113_4
					end
				end

				arg_110_1.text_.text = var_113_7
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)
				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_11 = math.max(var_113_5, arg_110_1.talkMaxDuration)

			if var_113_4 <= arg_110_1.time_ and arg_110_1.time_ < var_113_4 + var_113_11 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_4) / var_113_11

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_4 + var_113_11 and arg_110_1.time_ < var_113_4 + var_113_11 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {}

		arg_110_1:InitPlayNodeList()
	end,
	Play106122026 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 106122026
		arg_114_1.duration_ = 5

		SetActive(arg_114_1.tipsGo_, false)

		function arg_114_1.onSingleLineFinish_()
			arg_114_1.onSingleLineUpdate_ = nil
			arg_114_1.onSingleLineFinish_ = nil
			arg_114_1.state_ = "waiting"
		end

		function arg_114_1.playNext_(arg_116_0)
			if arg_116_0 == 1 then
				arg_114_0:Play106122027(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			local var_117_0 = 0
			local var_117_1 = 1

			if var_117_0 < arg_114_1.time_ and arg_114_1.time_ <= var_117_0 + arg_117_0 then
				local var_117_2 = "play"
				local var_117_3 = "effect"

				arg_114_1:AudioAction(var_117_2, var_117_3, "se_story_6", "se_story_6_black_fog02", "")
			end

			local var_117_4 = 0
			local var_117_5 = 1.025

			if var_117_4 < arg_114_1.time_ and arg_114_1.time_ <= var_117_4 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, false)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_114_1.iconTrs_.gameObject, false)
				arg_114_1.callingController_:SetSelectedState("normal")

				local var_117_6 = arg_114_1:GetWordFromCfg(106122026)
				local var_117_7 = arg_114_1:FormatText(var_117_6.content)

				arg_114_1.text_.text = var_117_7

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_8 = 41
				local var_117_9 = utf8.len(var_117_7)
				local var_117_10 = var_117_8 <= 0 and var_117_5 or var_117_5 * (var_117_9 / var_117_8)

				if var_117_10 > 0 and var_117_5 < var_117_10 then
					arg_114_1.talkMaxDuration = var_117_10

					if var_117_10 + var_117_4 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_10 + var_117_4
					end
				end

				arg_114_1.text_.text = var_117_7
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)
				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_11 = math.max(var_117_5, arg_114_1.talkMaxDuration)

			if var_117_4 <= arg_114_1.time_ and arg_114_1.time_ < var_117_4 + var_117_11 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - var_117_4) / var_117_11

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= var_117_4 + var_117_11 and arg_114_1.time_ < var_117_4 + var_117_11 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {}

		arg_114_1:InitPlayNodeList()
	end,
	Play106122027 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 106122027
		arg_118_1.duration_ = 5.47

		local var_118_0 = {
			ja = 5.233,
			ko = 3.6,
			zh = 2.966,
			en = 5.466
		}
		local var_118_1 = manager.audio:GetLocalizationFlag()

		if var_118_0[var_118_1] ~= nil then
			arg_118_1.duration_ = var_118_0[var_118_1]
		end

		SetActive(arg_118_1.tipsGo_, false)

		function arg_118_1.onSingleLineFinish_()
			arg_118_1.onSingleLineUpdate_ = nil
			arg_118_1.onSingleLineFinish_ = nil
			arg_118_1.state_ = "waiting"
		end

		function arg_118_1.playNext_(arg_120_0)
			if arg_120_0 == 1 then
				arg_118_0:Play106122028(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			local var_121_0 = arg_118_1.actors_["1093ui_story"]
			local var_121_1 = 0

			if var_121_1 < arg_118_1.time_ and arg_118_1.time_ <= var_121_1 + arg_121_0 and not isNil(var_121_0) and arg_118_1.var_.characterEffect1093ui_story == nil then
				arg_118_1.var_.characterEffect1093ui_story = var_121_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_121_2 = 0.1

			if var_121_1 <= arg_118_1.time_ and arg_118_1.time_ < var_121_1 + var_121_2 and not isNil(var_121_0) then
				local var_121_3 = (arg_118_1.time_ - var_121_1) / var_121_2

				if arg_118_1.var_.characterEffect1093ui_story and not isNil(var_121_0) then
					arg_118_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_118_1.time_ >= var_121_1 + var_121_2 and arg_118_1.time_ < var_121_1 + var_121_2 + arg_121_0 and not isNil(var_121_0) and arg_118_1.var_.characterEffect1093ui_story then
				arg_118_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_121_4 = arg_118_1.actors_["1093ui_story"].transform
			local var_121_5 = 0

			if var_121_5 < arg_118_1.time_ and arg_118_1.time_ <= var_121_5 + arg_121_0 then
				arg_118_1.var_.moveOldPos1093ui_story = var_121_4.localPosition
			end

			local var_121_6 = 0.001

			if var_121_5 <= arg_118_1.time_ and arg_118_1.time_ < var_121_5 + var_121_6 then
				local var_121_7 = (arg_118_1.time_ - var_121_5) / var_121_6
				local var_121_8 = Vector3.New(0, -1.11, -5.88)

				var_121_4.localPosition = Vector3.Lerp(arg_118_1.var_.moveOldPos1093ui_story, var_121_8, var_121_7)

				local var_121_9 = manager.ui.mainCamera.transform.position - var_121_4.position

				var_121_4.forward = Vector3.New(var_121_9.x, var_121_9.y, var_121_9.z)

				local var_121_10 = var_121_4.localEulerAngles

				var_121_10.z = 0
				var_121_10.x = 0
				var_121_4.localEulerAngles = var_121_10
			end

			if arg_118_1.time_ >= var_121_5 + var_121_6 and arg_118_1.time_ < var_121_5 + var_121_6 + arg_121_0 then
				var_121_4.localPosition = Vector3.New(0, -1.11, -5.88)

				local var_121_11 = manager.ui.mainCamera.transform.position - var_121_4.position

				var_121_4.forward = Vector3.New(var_121_11.x, var_121_11.y, var_121_11.z)

				local var_121_12 = var_121_4.localEulerAngles

				var_121_12.z = 0
				var_121_12.x = 0
				var_121_4.localEulerAngles = var_121_12
			end

			local var_121_13 = 0

			if var_121_13 < arg_118_1.time_ and arg_118_1.time_ <= var_121_13 + arg_121_0 then
				arg_118_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action10_2")
			end

			local var_121_14 = 0

			if var_121_14 < arg_118_1.time_ and arg_118_1.time_ <= var_121_14 + arg_121_0 then
				arg_118_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2202cva")
			end

			local var_121_15 = 0
			local var_121_16 = 0.225

			if var_121_15 < arg_118_1.time_ and arg_118_1.time_ <= var_121_15 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, true)

				local var_121_17 = arg_118_1:FormatText(StoryNameCfg[73].name)

				arg_118_1.leftNameTxt_.text = var_121_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_118_1.leftNameTxt_.transform)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1.leftNameTxt_.text)
				SetActive(arg_118_1.iconTrs_.gameObject, false)
				arg_118_1.callingController_:SetSelectedState("normal")

				local var_121_18 = arg_118_1:GetWordFromCfg(106122027)
				local var_121_19 = arg_118_1:FormatText(var_121_18.content)

				arg_118_1.text_.text = var_121_19

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_20 = 9
				local var_121_21 = utf8.len(var_121_19)
				local var_121_22 = var_121_20 <= 0 and var_121_16 or var_121_16 * (var_121_21 / var_121_20)

				if var_121_22 > 0 and var_121_16 < var_121_22 then
					arg_118_1.talkMaxDuration = var_121_22

					if var_121_22 + var_121_15 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_22 + var_121_15
					end
				end

				arg_118_1.text_.text = var_121_19
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106122", "106122027", "story_v_out_106122.awb") ~= 0 then
					local var_121_23 = manager.audio:GetVoiceLength("story_v_out_106122", "106122027", "story_v_out_106122.awb") / 1000

					if var_121_23 + var_121_15 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_23 + var_121_15
					end

					if var_121_18.prefab_name ~= "" and arg_118_1.actors_[var_121_18.prefab_name] ~= nil then
						local var_121_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_118_1.actors_[var_121_18.prefab_name].transform, "story_v_out_106122", "106122027", "story_v_out_106122.awb")

						arg_118_1:RecordAudio("106122027", var_121_24)
						arg_118_1:RecordAudio("106122027", var_121_24)
					else
						arg_118_1:AudioAction("play", "voice", "story_v_out_106122", "106122027", "story_v_out_106122.awb")
					end

					arg_118_1:RecordHistoryTalkVoice("story_v_out_106122", "106122027", "story_v_out_106122.awb")
				end

				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_25 = math.max(var_121_16, arg_118_1.talkMaxDuration)

			if var_121_15 <= arg_118_1.time_ and arg_118_1.time_ < var_121_15 + var_121_25 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - var_121_15) / var_121_25

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= var_121_15 + var_121_25 and arg_118_1.time_ < var_121_15 + var_121_25 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_118_1:InitPlayNodeList()
	end,
	Play106122028 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 106122028
		arg_122_1.duration_ = 6.1

		local var_122_0 = {
			ja = 5.566,
			ko = 3.933,
			zh = 5.866,
			en = 6.1
		}
		local var_122_1 = manager.audio:GetLocalizationFlag()

		if var_122_0[var_122_1] ~= nil then
			arg_122_1.duration_ = var_122_0[var_122_1]
		end

		SetActive(arg_122_1.tipsGo_, false)

		function arg_122_1.onSingleLineFinish_()
			arg_122_1.onSingleLineUpdate_ = nil
			arg_122_1.onSingleLineFinish_ = nil
			arg_122_1.state_ = "waiting"
		end

		function arg_122_1.playNext_(arg_124_0)
			if arg_124_0 == 1 then
				arg_122_0:Play106122029(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			local var_125_0 = "3004_tpose"

			if arg_122_1.actors_[var_125_0] == nil then
				local var_125_1 = Asset.Load("Char/" .. "3004_tpose")

				if not isNil(var_125_1) then
					local var_125_2 = Object.Instantiate(Asset.Load("Char/" .. "3004_tpose"), arg_122_1.stage_.transform)

					var_125_2.name = var_125_0
					var_125_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_122_1.actors_[var_125_0] = var_125_2

					local var_125_3 = var_125_2:GetComponentInChildren(typeof(CharacterEffect))

					var_125_3.enabled = true

					local var_125_4 = GameObjectTools.GetOrAddComponent(var_125_2, typeof(DynamicBoneHelper))

					if var_125_4 then
						var_125_4:EnableDynamicBone(false)
					end

					arg_122_1:ShowWeapon(var_125_3.transform, false)

					arg_122_1.var_[var_125_0 .. "Animator"] = var_125_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_122_1.var_[var_125_0 .. "Animator"].applyRootMotion = true
					arg_122_1.var_[var_125_0 .. "LipSync"] = var_125_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_125_5 = arg_122_1.actors_["3004_tpose"]
			local var_125_6 = 0

			if var_125_6 < arg_122_1.time_ and arg_122_1.time_ <= var_125_6 + arg_125_0 and not isNil(var_125_5) and arg_122_1.var_.characterEffect3004_tpose == nil then
				arg_122_1.var_.characterEffect3004_tpose = var_125_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_125_7 = 0.1

			if var_125_6 <= arg_122_1.time_ and arg_122_1.time_ < var_125_6 + var_125_7 and not isNil(var_125_5) then
				local var_125_8 = (arg_122_1.time_ - var_125_6) / var_125_7

				if arg_122_1.var_.characterEffect3004_tpose and not isNil(var_125_5) then
					arg_122_1.var_.characterEffect3004_tpose.fillFlat = false
				end
			end

			if arg_122_1.time_ >= var_125_6 + var_125_7 and arg_122_1.time_ < var_125_6 + var_125_7 + arg_125_0 and not isNil(var_125_5) and arg_122_1.var_.characterEffect3004_tpose then
				arg_122_1.var_.characterEffect3004_tpose.fillFlat = false
			end

			local var_125_9 = arg_122_1.actors_["1093ui_story"]
			local var_125_10 = 0

			if var_125_10 < arg_122_1.time_ and arg_122_1.time_ <= var_125_10 + arg_125_0 and not isNil(var_125_9) and arg_122_1.var_.characterEffect1093ui_story == nil then
				arg_122_1.var_.characterEffect1093ui_story = var_125_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_125_11 = 0.1

			if var_125_10 <= arg_122_1.time_ and arg_122_1.time_ < var_125_10 + var_125_11 and not isNil(var_125_9) then
				local var_125_12 = (arg_122_1.time_ - var_125_10) / var_125_11

				if arg_122_1.var_.characterEffect1093ui_story and not isNil(var_125_9) then
					local var_125_13 = Mathf.Lerp(0, 0.5, var_125_12)

					arg_122_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_122_1.var_.characterEffect1093ui_story.fillRatio = var_125_13
				end
			end

			if arg_122_1.time_ >= var_125_10 + var_125_11 and arg_122_1.time_ < var_125_10 + var_125_11 + arg_125_0 and not isNil(var_125_9) and arg_122_1.var_.characterEffect1093ui_story then
				local var_125_14 = 0.5

				arg_122_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_122_1.var_.characterEffect1093ui_story.fillRatio = var_125_14
			end

			local var_125_15 = arg_122_1.actors_["1093ui_story"].transform
			local var_125_16 = 0

			if var_125_16 < arg_122_1.time_ and arg_122_1.time_ <= var_125_16 + arg_125_0 then
				arg_122_1.var_.moveOldPos1093ui_story = var_125_15.localPosition
			end

			local var_125_17 = 0.001

			if var_125_16 <= arg_122_1.time_ and arg_122_1.time_ < var_125_16 + var_125_17 then
				local var_125_18 = (arg_122_1.time_ - var_125_16) / var_125_17
				local var_125_19 = Vector3.New(0, 100, 0)

				var_125_15.localPosition = Vector3.Lerp(arg_122_1.var_.moveOldPos1093ui_story, var_125_19, var_125_18)

				local var_125_20 = manager.ui.mainCamera.transform.position - var_125_15.position

				var_125_15.forward = Vector3.New(var_125_20.x, var_125_20.y, var_125_20.z)

				local var_125_21 = var_125_15.localEulerAngles

				var_125_21.z = 0
				var_125_21.x = 0
				var_125_15.localEulerAngles = var_125_21
			end

			if arg_122_1.time_ >= var_125_16 + var_125_17 and arg_122_1.time_ < var_125_16 + var_125_17 + arg_125_0 then
				var_125_15.localPosition = Vector3.New(0, 100, 0)

				local var_125_22 = manager.ui.mainCamera.transform.position - var_125_15.position

				var_125_15.forward = Vector3.New(var_125_22.x, var_125_22.y, var_125_22.z)

				local var_125_23 = var_125_15.localEulerAngles

				var_125_23.z = 0
				var_125_23.x = 0
				var_125_15.localEulerAngles = var_125_23
			end

			local var_125_24 = 0
			local var_125_25 = 0.4

			if var_125_24 < arg_122_1.time_ and arg_122_1.time_ <= var_125_24 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, true)

				local var_125_26 = arg_122_1:FormatText(StoryNameCfg[82].name)

				arg_122_1.leftNameTxt_.text = var_125_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_122_1.leftNameTxt_.transform)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1.leftNameTxt_.text)
				SetActive(arg_122_1.iconTrs_.gameObject, true)
				arg_122_1.iconController_:SetSelectedState("hero")

				arg_122_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3004")

				arg_122_1.callingController_:SetSelectedState("normal")

				arg_122_1.keyicon_.color = Color.New(1, 1, 1)
				arg_122_1.icon_.color = Color.New(1, 1, 1)

				local var_125_27 = arg_122_1:GetWordFromCfg(106122028)
				local var_125_28 = arg_122_1:FormatText(var_125_27.content)

				arg_122_1.text_.text = var_125_28

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_29 = 16
				local var_125_30 = utf8.len(var_125_28)
				local var_125_31 = var_125_29 <= 0 and var_125_25 or var_125_25 * (var_125_30 / var_125_29)

				if var_125_31 > 0 and var_125_25 < var_125_31 then
					arg_122_1.talkMaxDuration = var_125_31

					if var_125_31 + var_125_24 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_31 + var_125_24
					end
				end

				arg_122_1.text_.text = var_125_28
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106122", "106122028", "story_v_out_106122.awb") ~= 0 then
					local var_125_32 = manager.audio:GetVoiceLength("story_v_out_106122", "106122028", "story_v_out_106122.awb") / 1000

					if var_125_32 + var_125_24 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_32 + var_125_24
					end

					if var_125_27.prefab_name ~= "" and arg_122_1.actors_[var_125_27.prefab_name] ~= nil then
						local var_125_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_122_1.actors_[var_125_27.prefab_name].transform, "story_v_out_106122", "106122028", "story_v_out_106122.awb")

						arg_122_1:RecordAudio("106122028", var_125_33)
						arg_122_1:RecordAudio("106122028", var_125_33)
					else
						arg_122_1:AudioAction("play", "voice", "story_v_out_106122", "106122028", "story_v_out_106122.awb")
					end

					arg_122_1:RecordHistoryTalkVoice("story_v_out_106122", "106122028", "story_v_out_106122.awb")
				end

				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_34 = math.max(var_125_25, arg_122_1.talkMaxDuration)

			if var_125_24 <= arg_122_1.time_ and arg_122_1.time_ < var_125_24 + var_125_34 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_24) / var_125_34

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_24 + var_125_34 and arg_122_1.time_ < var_125_24 + var_125_34 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_122_1:InitPlayNodeList()
	end,
	Play106122029 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 106122029
		arg_126_1.duration_ = 5

		SetActive(arg_126_1.tipsGo_, false)

		function arg_126_1.onSingleLineFinish_()
			arg_126_1.onSingleLineUpdate_ = nil
			arg_126_1.onSingleLineFinish_ = nil
			arg_126_1.state_ = "waiting"
		end

		function arg_126_1.playNext_(arg_128_0)
			if arg_128_0 == 1 then
				arg_126_0:Play106122030(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			local var_129_0 = arg_126_1.actors_["3004_tpose"]
			local var_129_1 = 0

			if var_129_1 < arg_126_1.time_ and arg_126_1.time_ <= var_129_1 + arg_129_0 and not isNil(var_129_0) and arg_126_1.var_.characterEffect3004_tpose == nil then
				arg_126_1.var_.characterEffect3004_tpose = var_129_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_129_2 = 0.1

			if var_129_1 <= arg_126_1.time_ and arg_126_1.time_ < var_129_1 + var_129_2 and not isNil(var_129_0) then
				local var_129_3 = (arg_126_1.time_ - var_129_1) / var_129_2

				if arg_126_1.var_.characterEffect3004_tpose and not isNil(var_129_0) then
					local var_129_4 = Mathf.Lerp(0, 0.5, var_129_3)

					arg_126_1.var_.characterEffect3004_tpose.fillFlat = true
					arg_126_1.var_.characterEffect3004_tpose.fillRatio = var_129_4
				end
			end

			if arg_126_1.time_ >= var_129_1 + var_129_2 and arg_126_1.time_ < var_129_1 + var_129_2 + arg_129_0 and not isNil(var_129_0) and arg_126_1.var_.characterEffect3004_tpose then
				local var_129_5 = 0.5

				arg_126_1.var_.characterEffect3004_tpose.fillFlat = true
				arg_126_1.var_.characterEffect3004_tpose.fillRatio = var_129_5
			end

			local var_129_6 = 0
			local var_129_7 = 0.95

			if var_129_6 < arg_126_1.time_ and arg_126_1.time_ <= var_129_6 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, false)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_126_1.iconTrs_.gameObject, false)
				arg_126_1.callingController_:SetSelectedState("normal")

				local var_129_8 = arg_126_1:GetWordFromCfg(106122029)
				local var_129_9 = arg_126_1:FormatText(var_129_8.content)

				arg_126_1.text_.text = var_129_9

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_10 = 38
				local var_129_11 = utf8.len(var_129_9)
				local var_129_12 = var_129_10 <= 0 and var_129_7 or var_129_7 * (var_129_11 / var_129_10)

				if var_129_12 > 0 and var_129_7 < var_129_12 then
					arg_126_1.talkMaxDuration = var_129_12

					if var_129_12 + var_129_6 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_12 + var_129_6
					end
				end

				arg_126_1.text_.text = var_129_9
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)
				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_13 = math.max(var_129_7, arg_126_1.talkMaxDuration)

			if var_129_6 <= arg_126_1.time_ and arg_126_1.time_ < var_129_6 + var_129_13 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - var_129_6) / var_129_13

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= var_129_6 + var_129_13 and arg_126_1.time_ < var_129_6 + var_129_13 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {}

		arg_126_1:InitPlayNodeList()
	end,
	Play106122030 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 106122030
		arg_130_1.duration_ = 10.63

		local var_130_0 = {
			ja = 10.633,
			ko = 7.633,
			zh = 9.3,
			en = 10.333
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
			arg_130_1.auto_ = false
		end

		function arg_130_1.playNext_(arg_132_0)
			arg_130_1.onStoryFinished_()
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			local var_133_0 = arg_130_1.actors_["3004_tpose"]
			local var_133_1 = 0

			if var_133_1 < arg_130_1.time_ and arg_130_1.time_ <= var_133_1 + arg_133_0 and not isNil(var_133_0) and arg_130_1.var_.characterEffect3004_tpose == nil then
				arg_130_1.var_.characterEffect3004_tpose = var_133_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_133_2 = 0.1

			if var_133_1 <= arg_130_1.time_ and arg_130_1.time_ < var_133_1 + var_133_2 and not isNil(var_133_0) then
				local var_133_3 = (arg_130_1.time_ - var_133_1) / var_133_2

				if arg_130_1.var_.characterEffect3004_tpose and not isNil(var_133_0) then
					arg_130_1.var_.characterEffect3004_tpose.fillFlat = false
				end
			end

			if arg_130_1.time_ >= var_133_1 + var_133_2 and arg_130_1.time_ < var_133_1 + var_133_2 + arg_133_0 and not isNil(var_133_0) and arg_130_1.var_.characterEffect3004_tpose then
				arg_130_1.var_.characterEffect3004_tpose.fillFlat = false
			end

			local var_133_4 = arg_130_1.actors_["3004_tpose"].transform
			local var_133_5 = 0

			if var_133_5 < arg_130_1.time_ and arg_130_1.time_ <= var_133_5 + arg_133_0 then
				arg_130_1.var_.moveOldPos3004_tpose = var_133_4.localPosition

				local var_133_6 = GameObjectTools.GetOrAddComponent(var_133_4.gameObject, typeof(DynamicBoneHelper))

				if var_133_6 then
					var_133_6:EnableDynamicBone(false)
				end
			end

			local var_133_7 = 0.001

			if var_133_5 <= arg_130_1.time_ and arg_130_1.time_ < var_133_5 + var_133_7 then
				local var_133_8 = (arg_130_1.time_ - var_133_5) / var_133_7
				local var_133_9 = Vector3.New(0, -2.22, -3.1)

				var_133_4.localPosition = Vector3.Lerp(arg_130_1.var_.moveOldPos3004_tpose, var_133_9, var_133_8)

				local var_133_10 = manager.ui.mainCamera.transform.position - var_133_4.position

				var_133_4.forward = Vector3.New(var_133_10.x, var_133_10.y, var_133_10.z)

				local var_133_11 = var_133_4.localEulerAngles

				var_133_11.z = 0
				var_133_11.x = 0
				var_133_4.localEulerAngles = var_133_11
			end

			if arg_130_1.time_ >= var_133_5 + var_133_7 and arg_130_1.time_ < var_133_5 + var_133_7 + arg_133_0 then
				var_133_4.localPosition = Vector3.New(0, -2.22, -3.1)

				local var_133_12 = manager.ui.mainCamera.transform.position - var_133_4.position

				var_133_4.forward = Vector3.New(var_133_12.x, var_133_12.y, var_133_12.z)

				local var_133_13 = var_133_4.localEulerAngles

				var_133_13.z = 0
				var_133_13.x = 0
				var_133_4.localEulerAngles = var_133_13

				local var_133_14 = GameObjectTools.GetOrAddComponent(var_133_4.gameObject, typeof(DynamicBoneHelper))

				if var_133_14 then
					var_133_14:EnableDynamicBone(true)
				end
			end

			local var_133_15 = 0

			if var_133_15 < arg_130_1.time_ and arg_130_1.time_ <= var_133_15 + arg_133_0 then
				arg_130_1:PlayTimeline("3004_tpose", "StoryTimeline/CharAction/story3004/story3004action/3004action1_1")
			end

			local var_133_16 = 0
			local var_133_17 = 0.75

			if var_133_16 < arg_130_1.time_ and arg_130_1.time_ <= var_133_16 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, true)

				local var_133_18 = arg_130_1:FormatText(StoryNameCfg[82].name)

				arg_130_1.leftNameTxt_.text = var_133_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_130_1.leftNameTxt_.transform)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1.leftNameTxt_.text)
				SetActive(arg_130_1.iconTrs_.gameObject, false)
				arg_130_1.callingController_:SetSelectedState("normal")

				local var_133_19 = arg_130_1:GetWordFromCfg(106122030)
				local var_133_20 = arg_130_1:FormatText(var_133_19.content)

				arg_130_1.text_.text = var_133_20

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_21 = 30
				local var_133_22 = utf8.len(var_133_20)
				local var_133_23 = var_133_21 <= 0 and var_133_17 or var_133_17 * (var_133_22 / var_133_21)

				if var_133_23 > 0 and var_133_17 < var_133_23 then
					arg_130_1.talkMaxDuration = var_133_23

					if var_133_23 + var_133_16 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_23 + var_133_16
					end
				end

				arg_130_1.text_.text = var_133_20
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106122", "106122030", "story_v_out_106122.awb") ~= 0 then
					local var_133_24 = manager.audio:GetVoiceLength("story_v_out_106122", "106122030", "story_v_out_106122.awb") / 1000

					if var_133_24 + var_133_16 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_24 + var_133_16
					end

					if var_133_19.prefab_name ~= "" and arg_130_1.actors_[var_133_19.prefab_name] ~= nil then
						local var_133_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_130_1.actors_[var_133_19.prefab_name].transform, "story_v_out_106122", "106122030", "story_v_out_106122.awb")

						arg_130_1:RecordAudio("106122030", var_133_25)
						arg_130_1:RecordAudio("106122030", var_133_25)
					else
						arg_130_1:AudioAction("play", "voice", "story_v_out_106122", "106122030", "story_v_out_106122.awb")
					end

					arg_130_1:RecordHistoryTalkVoice("story_v_out_106122", "106122030", "story_v_out_106122.awb")
				end

				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_26 = math.max(var_133_17, arg_130_1.talkMaxDuration)

			if var_133_16 <= arg_130_1.time_ and arg_130_1.time_ < var_133_16 + var_133_26 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - var_133_16) / var_133_26

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= var_133_16 + var_133_26 and arg_130_1.time_ < var_133_16 + var_133_26 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3004_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_130_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/C01b",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/S0611"
	},
	voices = {
		"story_v_out_106122.awb"
	}
}
