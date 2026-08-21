return {
	Play103041001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 103041001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play103041002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = 0
			local var_4_1 = 1

			if var_4_0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_0 + arg_4_0 then
				local var_4_2 = "play"
				local var_4_3 = "music"

				arg_1_1:AudioAction(var_4_2, var_4_3, "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1")

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
			local var_4_7 = 1

			if var_4_6 < arg_1_1.time_ and arg_1_1.time_ <= var_4_6 + arg_4_0 then
				local var_4_8 = "play"
				local var_4_9 = "effect"

				arg_1_1:AudioAction(var_4_8, var_4_9, "se_story_v1_environment_factory", "se_story_v1_environment_factory", "se_story_v1_environment_factory")
			end

			local var_4_10 = 0
			local var_4_11 = 1

			if var_4_10 < arg_1_1.time_ and arg_1_1.time_ <= var_4_10 + arg_4_0 then
				local var_4_12 = "play"
				local var_4_13 = "effect"

				arg_1_1:AudioAction(var_4_12, var_4_13, "se_story", "se_story_fight_metal", "")
			end

			local var_4_14 = 0

			if var_4_14 < arg_1_1.time_ and arg_1_1.time_ <= var_4_14 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_15 = 2

			if var_4_14 <= arg_1_1.time_ and arg_1_1.time_ < var_4_14 + var_4_15 then
				local var_4_16 = (arg_1_1.time_ - var_4_14) / var_4_15
				local var_4_17 = Color.New(0, 0, 0)

				var_4_17.a = Mathf.Lerp(1, 0, var_4_16)
				arg_1_1.mask_.color = var_4_17
			end

			if arg_1_1.time_ >= var_4_14 + var_4_15 and arg_1_1.time_ < var_4_14 + var_4_15 + arg_4_0 then
				local var_4_18 = Color.New(0, 0, 0)
				local var_4_19 = 0

				arg_1_1.mask_.enabled = false
				var_4_18.a = var_4_19
				arg_1_1.mask_.color = var_4_18
			end

			local var_4_20 = "B08b"

			if arg_1_1.bgs_[var_4_20] == nil then
				local var_4_21 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_21:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_20)
				var_4_21.name = var_4_20
				var_4_21.transform.parent = arg_1_1.stage_.transform
				var_4_21.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_20] = var_4_21
			end

			local var_4_22 = 0

			if var_4_22 < arg_1_1.time_ and arg_1_1.time_ <= var_4_22 + arg_4_0 then
				local var_4_23 = manager.ui.mainCamera.transform.localPosition
				local var_4_24 = Vector3.New(0, 0, 10) + Vector3.New(var_4_23.x, var_4_23.y, 0)
				local var_4_25 = arg_1_1.bgs_.B08b

				var_4_25.transform.localPosition = var_4_24
				var_4_25.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_26 = var_4_25:GetComponent("SpriteRenderer")

				if var_4_26 and var_4_26.sprite then
					local var_4_27 = (var_4_25.transform.localPosition - var_4_23).z
					local var_4_28 = manager.ui.mainCameraCom_
					local var_4_29 = 2 * var_4_27 * Mathf.Tan(var_4_28.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_4_30 = var_4_29 * var_4_28.aspect
					local var_4_31 = var_4_26.sprite.bounds.size.x
					local var_4_32 = var_4_26.sprite.bounds.size.y
					local var_4_33 = var_4_30 / var_4_31
					local var_4_34 = var_4_29 / var_4_32
					local var_4_35 = var_4_34 < var_4_33 and var_4_33 or var_4_34

					var_4_25.transform.localScale = Vector3.New(var_4_35, var_4_35, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "B08b" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_36 = 2
			local var_4_37 = 0.3

			if var_4_36 < arg_1_1.time_ and arg_1_1.time_ <= var_4_36 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_38 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_38:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_38:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_38:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_39 = arg_1_1:GetWordFromCfg(103041001)
				local var_4_40 = arg_1_1:FormatText(var_4_39.content)

				arg_1_1.text_.text = var_4_40

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_41 = 11
				local var_4_42 = utf8.len(var_4_40)
				local var_4_43 = var_4_41 <= 0 and var_4_37 or var_4_37 * (var_4_42 / var_4_41)

				if var_4_43 > 0 and var_4_37 < var_4_43 then
					arg_1_1.talkMaxDuration = var_4_43
					var_4_36 = var_4_36 + 0.3

					if var_4_43 + var_4_36 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_43 + var_4_36
					end
				end

				arg_1_1.text_.text = var_4_40
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_44 = var_4_36 + 0.3
			local var_4_45 = math.max(var_4_37, arg_1_1.talkMaxDuration)

			if var_4_44 <= arg_1_1.time_ and arg_1_1.time_ < var_4_44 + var_4_45 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_44) / var_4_45

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_44 + var_4_45 and arg_1_1.time_ < var_4_44 + var_4_45 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play103041002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 103041002
		arg_8_1.duration_ = 2.43

		local var_8_0 = {
			ja = 2.433,
			ko = 2.133,
			zh = 2.433,
			en = 2.4
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
				arg_8_0:Play103041003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = "2020_tpose"

			if arg_8_1.actors_[var_11_0] == nil then
				local var_11_1 = Asset.Load("Char/" .. "2020_tpose")

				if not isNil(var_11_1) then
					local var_11_2 = Object.Instantiate(Asset.Load("Char/" .. "2020_tpose"), arg_8_1.stage_.transform)

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

			local var_11_5 = arg_8_1.actors_["2020_tpose"]
			local var_11_6 = 0

			if var_11_6 < arg_8_1.time_ and arg_8_1.time_ <= var_11_6 + arg_11_0 and not isNil(var_11_5) and arg_8_1.var_.characterEffect2020_tpose == nil then
				arg_8_1.var_.characterEffect2020_tpose = var_11_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_7 = 0.1

			if var_11_6 <= arg_8_1.time_ and arg_8_1.time_ < var_11_6 + var_11_7 and not isNil(var_11_5) then
				local var_11_8 = (arg_8_1.time_ - var_11_6) / var_11_7

				if arg_8_1.var_.characterEffect2020_tpose and not isNil(var_11_5) then
					arg_8_1.var_.characterEffect2020_tpose.fillFlat = false
				end
			end

			if arg_8_1.time_ >= var_11_6 + var_11_7 and arg_8_1.time_ < var_11_6 + var_11_7 + arg_11_0 and not isNil(var_11_5) and arg_8_1.var_.characterEffect2020_tpose then
				arg_8_1.var_.characterEffect2020_tpose.fillFlat = false
			end

			local var_11_9 = arg_8_1.actors_["2020_tpose"].transform
			local var_11_10 = 0

			if var_11_10 < arg_8_1.time_ and arg_8_1.time_ <= var_11_10 + arg_11_0 then
				arg_8_1.var_.moveOldPos2020_tpose = var_11_9.localPosition

				local var_11_11 = GameObjectTools.GetOrAddComponent(var_11_9.gameObject, typeof(DynamicBoneHelper))

				if var_11_11 then
					var_11_11:EnableDynamicBone(false)
				end
			end

			local var_11_12 = 0.001

			if var_11_10 <= arg_8_1.time_ and arg_8_1.time_ < var_11_10 + var_11_12 then
				local var_11_13 = (arg_8_1.time_ - var_11_10) / var_11_12
				local var_11_14 = Vector3.New(-0.7, -1.2, -4.1)

				var_11_9.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos2020_tpose, var_11_14, var_11_13)

				local var_11_15 = manager.ui.mainCamera.transform.position - var_11_9.position

				var_11_9.forward = Vector3.New(var_11_15.x, var_11_15.y, var_11_15.z)

				local var_11_16 = var_11_9.localEulerAngles

				var_11_16.z = 0
				var_11_16.x = 0
				var_11_9.localEulerAngles = var_11_16
			end

			if arg_8_1.time_ >= var_11_10 + var_11_12 and arg_8_1.time_ < var_11_10 + var_11_12 + arg_11_0 then
				var_11_9.localPosition = Vector3.New(-0.7, -1.2, -4.1)

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
				arg_8_1:PlayTimeline("2020_tpose", "StoryTimeline/CharAction/story2020/story2020action/2020action1_1")
			end

			local var_11_21 = 0
			local var_11_22 = 0.2

			if var_11_21 < arg_8_1.time_ and arg_8_1.time_ <= var_11_21 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				local var_11_23 = arg_8_1:FormatText(StoryNameCfg[34].name)

				arg_8_1.leftNameTxt_.text = var_11_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_24 = arg_8_1:GetWordFromCfg(103041002)
				local var_11_25 = arg_8_1:FormatText(var_11_24.content)

				arg_8_1.text_.text = var_11_25

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_26 = 8
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

				if manager.audio:GetVoiceLength("story_v_out_103041", "103041002", "story_v_out_103041.awb") ~= 0 then
					local var_11_29 = manager.audio:GetVoiceLength("story_v_out_103041", "103041002", "story_v_out_103041.awb") / 1000

					if var_11_29 + var_11_21 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_29 + var_11_21
					end

					if var_11_24.prefab_name ~= "" and arg_8_1.actors_[var_11_24.prefab_name] ~= nil then
						local var_11_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_24.prefab_name].transform, "story_v_out_103041", "103041002", "story_v_out_103041.awb")

						arg_8_1:RecordAudio("103041002", var_11_30)
						arg_8_1:RecordAudio("103041002", var_11_30)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_103041", "103041002", "story_v_out_103041.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_103041", "103041002", "story_v_out_103041.awb")
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
				actorName = "2020_tpose",
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
	Play103041003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 103041003
		arg_12_1.duration_ = 2.93

		local var_12_0 = {
			ja = 2.933,
			ko = 2.233,
			zh = 2.066,
			en = 2.366
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
				arg_12_0:Play103041004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = "2030_tpose"

			if arg_12_1.actors_[var_15_0] == nil then
				local var_15_1 = Asset.Load("Char/" .. "2030_tpose")

				if not isNil(var_15_1) then
					local var_15_2 = Object.Instantiate(Asset.Load("Char/" .. "2030_tpose"), arg_12_1.stage_.transform)

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

			local var_15_5 = arg_12_1.actors_["2030_tpose"]
			local var_15_6 = 0

			if var_15_6 < arg_12_1.time_ and arg_12_1.time_ <= var_15_6 + arg_15_0 and not isNil(var_15_5) and arg_12_1.var_.characterEffect2030_tpose == nil then
				arg_12_1.var_.characterEffect2030_tpose = var_15_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_7 = 0.1

			if var_15_6 <= arg_12_1.time_ and arg_12_1.time_ < var_15_6 + var_15_7 and not isNil(var_15_5) then
				local var_15_8 = (arg_12_1.time_ - var_15_6) / var_15_7

				if arg_12_1.var_.characterEffect2030_tpose and not isNil(var_15_5) then
					arg_12_1.var_.characterEffect2030_tpose.fillFlat = false
				end
			end

			if arg_12_1.time_ >= var_15_6 + var_15_7 and arg_12_1.time_ < var_15_6 + var_15_7 + arg_15_0 and not isNil(var_15_5) and arg_12_1.var_.characterEffect2030_tpose then
				arg_12_1.var_.characterEffect2030_tpose.fillFlat = false
			end

			local var_15_9 = arg_12_1.actors_["2020_tpose"]
			local var_15_10 = 0

			if var_15_10 < arg_12_1.time_ and arg_12_1.time_ <= var_15_10 + arg_15_0 and not isNil(var_15_9) and arg_12_1.var_.characterEffect2020_tpose == nil then
				arg_12_1.var_.characterEffect2020_tpose = var_15_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_11 = 0.1

			if var_15_10 <= arg_12_1.time_ and arg_12_1.time_ < var_15_10 + var_15_11 and not isNil(var_15_9) then
				local var_15_12 = (arg_12_1.time_ - var_15_10) / var_15_11

				if arg_12_1.var_.characterEffect2020_tpose and not isNil(var_15_9) then
					local var_15_13 = Mathf.Lerp(0, 0.5, var_15_12)

					arg_12_1.var_.characterEffect2020_tpose.fillFlat = true
					arg_12_1.var_.characterEffect2020_tpose.fillRatio = var_15_13
				end
			end

			if arg_12_1.time_ >= var_15_10 + var_15_11 and arg_12_1.time_ < var_15_10 + var_15_11 + arg_15_0 and not isNil(var_15_9) and arg_12_1.var_.characterEffect2020_tpose then
				local var_15_14 = 0.5

				arg_12_1.var_.characterEffect2020_tpose.fillFlat = true
				arg_12_1.var_.characterEffect2020_tpose.fillRatio = var_15_14
			end

			local var_15_15 = arg_12_1.actors_["2030_tpose"].transform
			local var_15_16 = 0

			if var_15_16 < arg_12_1.time_ and arg_12_1.time_ <= var_15_16 + arg_15_0 then
				arg_12_1.var_.moveOldPos2030_tpose = var_15_15.localPosition

				local var_15_17 = GameObjectTools.GetOrAddComponent(var_15_15.gameObject, typeof(DynamicBoneHelper))

				if var_15_17 then
					var_15_17:EnableDynamicBone(false)
				end
			end

			local var_15_18 = 0.001

			if var_15_16 <= arg_12_1.time_ and arg_12_1.time_ < var_15_16 + var_15_18 then
				local var_15_19 = (arg_12_1.time_ - var_15_16) / var_15_18
				local var_15_20 = Vector3.New(0.7, -1.2, -4.2)

				var_15_15.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos2030_tpose, var_15_20, var_15_19)

				local var_15_21 = manager.ui.mainCamera.transform.position - var_15_15.position

				var_15_15.forward = Vector3.New(var_15_21.x, var_15_21.y, var_15_21.z)

				local var_15_22 = var_15_15.localEulerAngles

				var_15_22.z = 0
				var_15_22.x = 0
				var_15_15.localEulerAngles = var_15_22
			end

			if arg_12_1.time_ >= var_15_16 + var_15_18 and arg_12_1.time_ < var_15_16 + var_15_18 + arg_15_0 then
				var_15_15.localPosition = Vector3.New(0.7, -1.2, -4.2)

				local var_15_23 = manager.ui.mainCamera.transform.position - var_15_15.position

				var_15_15.forward = Vector3.New(var_15_23.x, var_15_23.y, var_15_23.z)

				local var_15_24 = var_15_15.localEulerAngles

				var_15_24.z = 0
				var_15_24.x = 0
				var_15_15.localEulerAngles = var_15_24

				local var_15_25 = GameObjectTools.GetOrAddComponent(var_15_15.gameObject, typeof(DynamicBoneHelper))

				if var_15_25 then
					var_15_25:EnableDynamicBone(true)
				end
			end

			local var_15_26 = 0

			if var_15_26 < arg_12_1.time_ and arg_12_1.time_ <= var_15_26 + arg_15_0 then
				arg_12_1:PlayTimeline("2030_tpose", "StoryTimeline/CharAction/story2030/story2030action/2030action1_1")
			end

			local var_15_27 = 0
			local var_15_28 = 0.15

			if var_15_27 < arg_12_1.time_ and arg_12_1.time_ <= var_15_27 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				local var_15_29 = arg_12_1:FormatText(StoryNameCfg[34].name)

				arg_12_1.leftNameTxt_.text = var_15_29

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_30 = arg_12_1:GetWordFromCfg(103041003)
				local var_15_31 = arg_12_1:FormatText(var_15_30.content)

				arg_12_1.text_.text = var_15_31

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_32 = 6
				local var_15_33 = utf8.len(var_15_31)
				local var_15_34 = var_15_32 <= 0 and var_15_28 or var_15_28 * (var_15_33 / var_15_32)

				if var_15_34 > 0 and var_15_28 < var_15_34 then
					arg_12_1.talkMaxDuration = var_15_34

					if var_15_34 + var_15_27 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_34 + var_15_27
					end
				end

				arg_12_1.text_.text = var_15_31
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103041", "103041003", "story_v_out_103041.awb") ~= 0 then
					local var_15_35 = manager.audio:GetVoiceLength("story_v_out_103041", "103041003", "story_v_out_103041.awb") / 1000

					if var_15_35 + var_15_27 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_35 + var_15_27
					end

					if var_15_30.prefab_name ~= "" and arg_12_1.actors_[var_15_30.prefab_name] ~= nil then
						local var_15_36 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_30.prefab_name].transform, "story_v_out_103041", "103041003", "story_v_out_103041.awb")

						arg_12_1:RecordAudio("103041003", var_15_36)
						arg_12_1:RecordAudio("103041003", var_15_36)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_103041", "103041003", "story_v_out_103041.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_103041", "103041003", "story_v_out_103041.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_37 = math.max(var_15_28, arg_12_1.talkMaxDuration)

			if var_15_27 <= arg_12_1.time_ and arg_12_1.time_ < var_15_27 + var_15_37 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_27) / var_15_37

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_27 + var_15_37 and arg_12_1.time_ < var_15_27 + var_15_37 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2030_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_12_1:InitPlayNodeList()
	end,
	Play103041004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 103041004
		arg_16_1.duration_ = 5

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play103041005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = arg_16_1.actors_["2030_tpose"]
			local var_19_1 = 0

			if var_19_1 < arg_16_1.time_ and arg_16_1.time_ <= var_19_1 + arg_19_0 and not isNil(var_19_0) and arg_16_1.var_.characterEffect2030_tpose == nil then
				arg_16_1.var_.characterEffect2030_tpose = var_19_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_2 = 0.1

			if var_19_1 <= arg_16_1.time_ and arg_16_1.time_ < var_19_1 + var_19_2 and not isNil(var_19_0) then
				local var_19_3 = (arg_16_1.time_ - var_19_1) / var_19_2

				if arg_16_1.var_.characterEffect2030_tpose and not isNil(var_19_0) then
					local var_19_4 = Mathf.Lerp(0, 0.5, var_19_3)

					arg_16_1.var_.characterEffect2030_tpose.fillFlat = true
					arg_16_1.var_.characterEffect2030_tpose.fillRatio = var_19_4
				end
			end

			if arg_16_1.time_ >= var_19_1 + var_19_2 and arg_16_1.time_ < var_19_1 + var_19_2 + arg_19_0 and not isNil(var_19_0) and arg_16_1.var_.characterEffect2030_tpose then
				local var_19_5 = 0.5

				arg_16_1.var_.characterEffect2030_tpose.fillFlat = true
				arg_16_1.var_.characterEffect2030_tpose.fillRatio = var_19_5
			end

			local var_19_6 = arg_16_1.actors_["2020_tpose"].transform
			local var_19_7 = 0

			if var_19_7 < arg_16_1.time_ and arg_16_1.time_ <= var_19_7 + arg_19_0 then
				arg_16_1.var_.moveOldPos2020_tpose = var_19_6.localPosition

				local var_19_8 = GameObjectTools.GetOrAddComponent(var_19_6.gameObject, typeof(DynamicBoneHelper))

				if var_19_8 then
					var_19_8:EnableDynamicBone(false)
				end
			end

			local var_19_9 = 0.001

			if var_19_7 <= arg_16_1.time_ and arg_16_1.time_ < var_19_7 + var_19_9 then
				local var_19_10 = (arg_16_1.time_ - var_19_7) / var_19_9
				local var_19_11 = Vector3.New(0, 100, 0)

				var_19_6.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos2020_tpose, var_19_11, var_19_10)

				local var_19_12 = manager.ui.mainCamera.transform.position - var_19_6.position

				var_19_6.forward = Vector3.New(var_19_12.x, var_19_12.y, var_19_12.z)

				local var_19_13 = var_19_6.localEulerAngles

				var_19_13.z = 0
				var_19_13.x = 0
				var_19_6.localEulerAngles = var_19_13
			end

			if arg_16_1.time_ >= var_19_7 + var_19_9 and arg_16_1.time_ < var_19_7 + var_19_9 + arg_19_0 then
				var_19_6.localPosition = Vector3.New(0, 100, 0)

				local var_19_14 = manager.ui.mainCamera.transform.position - var_19_6.position

				var_19_6.forward = Vector3.New(var_19_14.x, var_19_14.y, var_19_14.z)

				local var_19_15 = var_19_6.localEulerAngles

				var_19_15.z = 0
				var_19_15.x = 0
				var_19_6.localEulerAngles = var_19_15

				local var_19_16 = GameObjectTools.GetOrAddComponent(var_19_6.gameObject, typeof(DynamicBoneHelper))

				if var_19_16 then
					var_19_16:EnableDynamicBone(true)
				end
			end

			local var_19_17 = arg_16_1.actors_["2030_tpose"].transform
			local var_19_18 = 0

			if var_19_18 < arg_16_1.time_ and arg_16_1.time_ <= var_19_18 + arg_19_0 then
				arg_16_1.var_.moveOldPos2030_tpose = var_19_17.localPosition

				local var_19_19 = GameObjectTools.GetOrAddComponent(var_19_17.gameObject, typeof(DynamicBoneHelper))

				if var_19_19 then
					var_19_19:EnableDynamicBone(false)
				end
			end

			local var_19_20 = 0.001

			if var_19_18 <= arg_16_1.time_ and arg_16_1.time_ < var_19_18 + var_19_20 then
				local var_19_21 = (arg_16_1.time_ - var_19_18) / var_19_20
				local var_19_22 = Vector3.New(0, 100, 0)

				var_19_17.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos2030_tpose, var_19_22, var_19_21)

				local var_19_23 = manager.ui.mainCamera.transform.position - var_19_17.position

				var_19_17.forward = Vector3.New(var_19_23.x, var_19_23.y, var_19_23.z)

				local var_19_24 = var_19_17.localEulerAngles

				var_19_24.z = 0
				var_19_24.x = 0
				var_19_17.localEulerAngles = var_19_24
			end

			if arg_16_1.time_ >= var_19_18 + var_19_20 and arg_16_1.time_ < var_19_18 + var_19_20 + arg_19_0 then
				var_19_17.localPosition = Vector3.New(0, 100, 0)

				local var_19_25 = manager.ui.mainCamera.transform.position - var_19_17.position

				var_19_17.forward = Vector3.New(var_19_25.x, var_19_25.y, var_19_25.z)

				local var_19_26 = var_19_17.localEulerAngles

				var_19_26.z = 0
				var_19_26.x = 0
				var_19_17.localEulerAngles = var_19_26

				local var_19_27 = GameObjectTools.GetOrAddComponent(var_19_17.gameObject, typeof(DynamicBoneHelper))

				if var_19_27 then
					var_19_27:EnableDynamicBone(true)
				end
			end

			local var_19_28 = 0
			local var_19_29 = 0.925

			if var_19_28 < arg_16_1.time_ and arg_16_1.time_ <= var_19_28 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, false)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_30 = arg_16_1:GetWordFromCfg(103041004)
				local var_19_31 = arg_16_1:FormatText(var_19_30.content)

				arg_16_1.text_.text = var_19_31

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_32 = 37
				local var_19_33 = utf8.len(var_19_31)
				local var_19_34 = var_19_32 <= 0 and var_19_29 or var_19_29 * (var_19_33 / var_19_32)

				if var_19_34 > 0 and var_19_29 < var_19_34 then
					arg_16_1.talkMaxDuration = var_19_34

					if var_19_34 + var_19_28 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_34 + var_19_28
					end
				end

				arg_16_1.text_.text = var_19_31
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)
				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_35 = math.max(var_19_29, arg_16_1.talkMaxDuration)

			if var_19_28 <= arg_16_1.time_ and arg_16_1.time_ < var_19_28 + var_19_35 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_28) / var_19_35

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_28 + var_19_35 and arg_16_1.time_ < var_19_28 + var_19_35 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2020_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "2030_tpose",
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
	Play103041005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 103041005
		arg_20_1.duration_ = 7.47

		local var_20_0 = {
			ja = 7.166,
			ko = 6.7,
			zh = 7.466,
			en = 5.566
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
				arg_20_0:Play103041006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = "4010ui_story"

			if arg_20_1.actors_[var_23_0] == nil then
				local var_23_1 = Asset.Load("Char/" .. "4010ui_story")

				if not isNil(var_23_1) then
					local var_23_2 = Object.Instantiate(Asset.Load("Char/" .. "4010ui_story"), arg_20_1.stage_.transform)

					var_23_2.name = var_23_0
					var_23_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_20_1.actors_[var_23_0] = var_23_2

					local var_23_3 = var_23_2:GetComponentInChildren(typeof(CharacterEffect))

					var_23_3.enabled = true

					local var_23_4 = GameObjectTools.GetOrAddComponent(var_23_2, typeof(DynamicBoneHelper))

					if var_23_4 then
						var_23_4:EnableDynamicBone(false)
					end

					arg_20_1:ShowWeapon(var_23_3.transform, false)

					arg_20_1.var_[var_23_0 .. "Animator"] = var_23_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_20_1.var_[var_23_0 .. "Animator"].applyRootMotion = true
					arg_20_1.var_[var_23_0 .. "LipSync"] = var_23_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_23_5 = arg_20_1.actors_["4010ui_story"]
			local var_23_6 = 0

			if var_23_6 < arg_20_1.time_ and arg_20_1.time_ <= var_23_6 + arg_23_0 and not isNil(var_23_5) and arg_20_1.var_.characterEffect4010ui_story == nil then
				arg_20_1.var_.characterEffect4010ui_story = var_23_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_7 = 0.1

			if var_23_6 <= arg_20_1.time_ and arg_20_1.time_ < var_23_6 + var_23_7 and not isNil(var_23_5) then
				local var_23_8 = (arg_20_1.time_ - var_23_6) / var_23_7

				if arg_20_1.var_.characterEffect4010ui_story and not isNil(var_23_5) then
					arg_20_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_20_1.time_ >= var_23_6 + var_23_7 and arg_20_1.time_ < var_23_6 + var_23_7 + arg_23_0 and not isNil(var_23_5) and arg_20_1.var_.characterEffect4010ui_story then
				arg_20_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_23_9 = arg_20_1.actors_["4010ui_story"].transform
			local var_23_10 = 0

			if var_23_10 < arg_20_1.time_ and arg_20_1.time_ <= var_23_10 + arg_23_0 then
				arg_20_1.var_.moveOldPos4010ui_story = var_23_9.localPosition
			end

			local var_23_11 = 0.001

			if var_23_10 <= arg_20_1.time_ and arg_20_1.time_ < var_23_10 + var_23_11 then
				local var_23_12 = (arg_20_1.time_ - var_23_10) / var_23_11
				local var_23_13 = Vector3.New(0, -1.59, -5.2)

				var_23_9.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos4010ui_story, var_23_13, var_23_12)

				local var_23_14 = manager.ui.mainCamera.transform.position - var_23_9.position

				var_23_9.forward = Vector3.New(var_23_14.x, var_23_14.y, var_23_14.z)

				local var_23_15 = var_23_9.localEulerAngles

				var_23_15.z = 0
				var_23_15.x = 0
				var_23_9.localEulerAngles = var_23_15
			end

			if arg_20_1.time_ >= var_23_10 + var_23_11 and arg_20_1.time_ < var_23_10 + var_23_11 + arg_23_0 then
				var_23_9.localPosition = Vector3.New(0, -1.59, -5.2)

				local var_23_16 = manager.ui.mainCamera.transform.position - var_23_9.position

				var_23_9.forward = Vector3.New(var_23_16.x, var_23_16.y, var_23_16.z)

				local var_23_17 = var_23_9.localEulerAngles

				var_23_17.z = 0
				var_23_17.x = 0
				var_23_9.localEulerAngles = var_23_17
			end

			local var_23_18 = 0

			if var_23_18 < arg_20_1.time_ and arg_20_1.time_ <= var_23_18 + arg_23_0 then
				arg_20_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action1_1")
			end

			local var_23_19 = 0

			if var_23_19 < arg_20_1.time_ and arg_20_1.time_ <= var_23_19 + arg_23_0 then
				arg_20_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_23_20 = 0
			local var_23_21 = 0.65

			if var_23_20 < arg_20_1.time_ and arg_20_1.time_ <= var_23_20 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				local var_23_22 = arg_20_1:FormatText(StoryNameCfg[42].name)

				arg_20_1.leftNameTxt_.text = var_23_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_23 = arg_20_1:GetWordFromCfg(103041005)
				local var_23_24 = arg_20_1:FormatText(var_23_23.content)

				arg_20_1.text_.text = var_23_24

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_25 = 26
				local var_23_26 = utf8.len(var_23_24)
				local var_23_27 = var_23_25 <= 0 and var_23_21 or var_23_21 * (var_23_26 / var_23_25)

				if var_23_27 > 0 and var_23_21 < var_23_27 then
					arg_20_1.talkMaxDuration = var_23_27

					if var_23_27 + var_23_20 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_27 + var_23_20
					end
				end

				arg_20_1.text_.text = var_23_24
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103041", "103041005", "story_v_out_103041.awb") ~= 0 then
					local var_23_28 = manager.audio:GetVoiceLength("story_v_out_103041", "103041005", "story_v_out_103041.awb") / 1000

					if var_23_28 + var_23_20 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_28 + var_23_20
					end

					if var_23_23.prefab_name ~= "" and arg_20_1.actors_[var_23_23.prefab_name] ~= nil then
						local var_23_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_23.prefab_name].transform, "story_v_out_103041", "103041005", "story_v_out_103041.awb")

						arg_20_1:RecordAudio("103041005", var_23_29)
						arg_20_1:RecordAudio("103041005", var_23_29)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_103041", "103041005", "story_v_out_103041.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_103041", "103041005", "story_v_out_103041.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_30 = math.max(var_23_21, arg_20_1.talkMaxDuration)

			if var_23_20 <= arg_20_1.time_ and arg_20_1.time_ < var_23_20 + var_23_30 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_20) / var_23_30

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_20 + var_23_30 and arg_20_1.time_ < var_23_20 + var_23_30 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4010ui_story",
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
	Play103041006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 103041006
		arg_24_1.duration_ = 3.57

		local var_24_0 = {
			ja = 3.566,
			ko = 2.2,
			zh = 2.366,
			en = 2.033
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
				arg_24_0:Play103041007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = "3009ui_story"

			if arg_24_1.actors_[var_27_0] == nil then
				local var_27_1 = Asset.Load("Char/" .. "3009ui_story")

				if not isNil(var_27_1) then
					local var_27_2 = Object.Instantiate(Asset.Load("Char/" .. "3009ui_story"), arg_24_1.stage_.transform)

					var_27_2.name = var_27_0
					var_27_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_24_1.actors_[var_27_0] = var_27_2

					local var_27_3 = var_27_2:GetComponentInChildren(typeof(CharacterEffect))

					var_27_3.enabled = true

					local var_27_4 = GameObjectTools.GetOrAddComponent(var_27_2, typeof(DynamicBoneHelper))

					if var_27_4 then
						var_27_4:EnableDynamicBone(false)
					end

					arg_24_1:ShowWeapon(var_27_3.transform, false)

					arg_24_1.var_[var_27_0 .. "Animator"] = var_27_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_24_1.var_[var_27_0 .. "Animator"].applyRootMotion = true
					arg_24_1.var_[var_27_0 .. "LipSync"] = var_27_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_27_5 = arg_24_1.actors_["3009ui_story"]
			local var_27_6 = 0

			if var_27_6 < arg_24_1.time_ and arg_24_1.time_ <= var_27_6 + arg_27_0 and not isNil(var_27_5) and arg_24_1.var_.characterEffect3009ui_story == nil then
				arg_24_1.var_.characterEffect3009ui_story = var_27_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_7 = 0.1

			if var_27_6 <= arg_24_1.time_ and arg_24_1.time_ < var_27_6 + var_27_7 and not isNil(var_27_5) then
				local var_27_8 = (arg_24_1.time_ - var_27_6) / var_27_7

				if arg_24_1.var_.characterEffect3009ui_story and not isNil(var_27_5) then
					arg_24_1.var_.characterEffect3009ui_story.fillFlat = false
				end
			end

			if arg_24_1.time_ >= var_27_6 + var_27_7 and arg_24_1.time_ < var_27_6 + var_27_7 + arg_27_0 and not isNil(var_27_5) and arg_24_1.var_.characterEffect3009ui_story then
				arg_24_1.var_.characterEffect3009ui_story.fillFlat = false
			end

			local var_27_9 = arg_24_1.actors_["4010ui_story"]
			local var_27_10 = 0

			if var_27_10 < arg_24_1.time_ and arg_24_1.time_ <= var_27_10 + arg_27_0 and not isNil(var_27_9) and arg_24_1.var_.characterEffect4010ui_story == nil then
				arg_24_1.var_.characterEffect4010ui_story = var_27_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_11 = 0.1

			if var_27_10 <= arg_24_1.time_ and arg_24_1.time_ < var_27_10 + var_27_11 and not isNil(var_27_9) then
				local var_27_12 = (arg_24_1.time_ - var_27_10) / var_27_11

				if arg_24_1.var_.characterEffect4010ui_story and not isNil(var_27_9) then
					local var_27_13 = Mathf.Lerp(0, 0.5, var_27_12)

					arg_24_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_24_1.var_.characterEffect4010ui_story.fillRatio = var_27_13
				end
			end

			if arg_24_1.time_ >= var_27_10 + var_27_11 and arg_24_1.time_ < var_27_10 + var_27_11 + arg_27_0 and not isNil(var_27_9) and arg_24_1.var_.characterEffect4010ui_story then
				local var_27_14 = 0.5

				arg_24_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_24_1.var_.characterEffect4010ui_story.fillRatio = var_27_14
			end

			local var_27_15 = arg_24_1.actors_["4010ui_story"].transform
			local var_27_16 = 0

			if var_27_16 < arg_24_1.time_ and arg_24_1.time_ <= var_27_16 + arg_27_0 then
				arg_24_1.var_.moveOldPos4010ui_story = var_27_15.localPosition
			end

			local var_27_17 = 0.001

			if var_27_16 <= arg_24_1.time_ and arg_24_1.time_ < var_27_16 + var_27_17 then
				local var_27_18 = (arg_24_1.time_ - var_27_16) / var_27_17
				local var_27_19 = Vector3.New(0, 100, 0)

				var_27_15.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos4010ui_story, var_27_19, var_27_18)

				local var_27_20 = manager.ui.mainCamera.transform.position - var_27_15.position

				var_27_15.forward = Vector3.New(var_27_20.x, var_27_20.y, var_27_20.z)

				local var_27_21 = var_27_15.localEulerAngles

				var_27_21.z = 0
				var_27_21.x = 0
				var_27_15.localEulerAngles = var_27_21
			end

			if arg_24_1.time_ >= var_27_16 + var_27_17 and arg_24_1.time_ < var_27_16 + var_27_17 + arg_27_0 then
				var_27_15.localPosition = Vector3.New(0, 100, 0)

				local var_27_22 = manager.ui.mainCamera.transform.position - var_27_15.position

				var_27_15.forward = Vector3.New(var_27_22.x, var_27_22.y, var_27_22.z)

				local var_27_23 = var_27_15.localEulerAngles

				var_27_23.z = 0
				var_27_23.x = 0
				var_27_15.localEulerAngles = var_27_23
			end

			local var_27_24 = arg_24_1.actors_["3009ui_story"].transform
			local var_27_25 = 0

			if var_27_25 < arg_24_1.time_ and arg_24_1.time_ <= var_27_25 + arg_27_0 then
				arg_24_1.var_.moveOldPos3009ui_story = var_27_24.localPosition

				local var_27_26 = "3009ui_story"

				arg_24_1:ShowWeapon(arg_24_1.var_[var_27_26 .. "Animator"].transform, true)
			end

			local var_27_27 = 0.001

			if var_27_25 <= arg_24_1.time_ and arg_24_1.time_ < var_27_25 + var_27_27 then
				local var_27_28 = (arg_24_1.time_ - var_27_25) / var_27_27
				local var_27_29 = Vector3.New(-0.7, -1.75, -4.8)

				var_27_24.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos3009ui_story, var_27_29, var_27_28)

				local var_27_30 = manager.ui.mainCamera.transform.position - var_27_24.position

				var_27_24.forward = Vector3.New(var_27_30.x, var_27_30.y, var_27_30.z)

				local var_27_31 = var_27_24.localEulerAngles

				var_27_31.z = 0
				var_27_31.x = 0
				var_27_24.localEulerAngles = var_27_31
			end

			if arg_24_1.time_ >= var_27_25 + var_27_27 and arg_24_1.time_ < var_27_25 + var_27_27 + arg_27_0 then
				var_27_24.localPosition = Vector3.New(-0.7, -1.75, -4.8)

				local var_27_32 = manager.ui.mainCamera.transform.position - var_27_24.position

				var_27_24.forward = Vector3.New(var_27_32.x, var_27_32.y, var_27_32.z)

				local var_27_33 = var_27_24.localEulerAngles

				var_27_33.z = 0
				var_27_33.x = 0
				var_27_24.localEulerAngles = var_27_33
			end

			local var_27_34 = 0

			if var_27_34 < arg_24_1.time_ and arg_24_1.time_ <= var_27_34 + arg_27_0 then
				arg_24_1:PlayTimeline("3009ui_story", "StoryTimeline/CharAction/story3009/story3009action/3009action1_1")
			end

			local var_27_35 = 0

			if var_27_35 < arg_24_1.time_ and arg_24_1.time_ <= var_27_35 + arg_27_0 then
				arg_24_1:PlayTimeline("3009ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_27_36 = 0
			local var_27_37 = 0.25

			if var_27_36 < arg_24_1.time_ and arg_24_1.time_ <= var_27_36 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				local var_27_38 = arg_24_1:FormatText(StoryNameCfg[43].name)

				arg_24_1.leftNameTxt_.text = var_27_38

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_39 = arg_24_1:GetWordFromCfg(103041006)
				local var_27_40 = arg_24_1:FormatText(var_27_39.content)

				arg_24_1.text_.text = var_27_40

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_41 = 10
				local var_27_42 = utf8.len(var_27_40)
				local var_27_43 = var_27_41 <= 0 and var_27_37 or var_27_37 * (var_27_42 / var_27_41)

				if var_27_43 > 0 and var_27_37 < var_27_43 then
					arg_24_1.talkMaxDuration = var_27_43

					if var_27_43 + var_27_36 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_43 + var_27_36
					end
				end

				arg_24_1.text_.text = var_27_40
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103041", "103041006", "story_v_out_103041.awb") ~= 0 then
					local var_27_44 = manager.audio:GetVoiceLength("story_v_out_103041", "103041006", "story_v_out_103041.awb") / 1000

					if var_27_44 + var_27_36 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_44 + var_27_36
					end

					if var_27_39.prefab_name ~= "" and arg_24_1.actors_[var_27_39.prefab_name] ~= nil then
						local var_27_45 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_39.prefab_name].transform, "story_v_out_103041", "103041006", "story_v_out_103041.awb")

						arg_24_1:RecordAudio("103041006", var_27_45)
						arg_24_1:RecordAudio("103041006", var_27_45)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_103041", "103041006", "story_v_out_103041.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_103041", "103041006", "story_v_out_103041.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_46 = math.max(var_27_37, arg_24_1.talkMaxDuration)

			if var_27_36 <= arg_24_1.time_ and arg_24_1.time_ < var_27_36 + var_27_46 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_36) / var_27_46

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_36 + var_27_46 and arg_24_1.time_ < var_27_36 + var_27_46 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "3009ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_24_1:InitPlayNodeList()
	end,
	Play103041007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 103041007
		arg_28_1.duration_ = 2.73

		local var_28_0 = {
			ja = 2.633,
			ko = 2.733,
			zh = 2,
			en = 2.666
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
				arg_28_0:Play103041008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = "3008ui_story"

			if arg_28_1.actors_[var_31_0] == nil then
				local var_31_1 = Asset.Load("Char/" .. "3008ui_story")

				if not isNil(var_31_1) then
					local var_31_2 = Object.Instantiate(Asset.Load("Char/" .. "3008ui_story"), arg_28_1.stage_.transform)

					var_31_2.name = var_31_0
					var_31_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_28_1.actors_[var_31_0] = var_31_2

					local var_31_3 = var_31_2:GetComponentInChildren(typeof(CharacterEffect))

					var_31_3.enabled = true

					local var_31_4 = GameObjectTools.GetOrAddComponent(var_31_2, typeof(DynamicBoneHelper))

					if var_31_4 then
						var_31_4:EnableDynamicBone(false)
					end

					arg_28_1:ShowWeapon(var_31_3.transform, false)

					arg_28_1.var_[var_31_0 .. "Animator"] = var_31_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_28_1.var_[var_31_0 .. "Animator"].applyRootMotion = true
					arg_28_1.var_[var_31_0 .. "LipSync"] = var_31_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_31_5 = arg_28_1.actors_["3008ui_story"]
			local var_31_6 = 0

			if var_31_6 < arg_28_1.time_ and arg_28_1.time_ <= var_31_6 + arg_31_0 and not isNil(var_31_5) and arg_28_1.var_.characterEffect3008ui_story == nil then
				arg_28_1.var_.characterEffect3008ui_story = var_31_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_7 = 0.1

			if var_31_6 <= arg_28_1.time_ and arg_28_1.time_ < var_31_6 + var_31_7 and not isNil(var_31_5) then
				local var_31_8 = (arg_28_1.time_ - var_31_6) / var_31_7

				if arg_28_1.var_.characterEffect3008ui_story and not isNil(var_31_5) then
					arg_28_1.var_.characterEffect3008ui_story.fillFlat = false
				end
			end

			if arg_28_1.time_ >= var_31_6 + var_31_7 and arg_28_1.time_ < var_31_6 + var_31_7 + arg_31_0 and not isNil(var_31_5) and arg_28_1.var_.characterEffect3008ui_story then
				arg_28_1.var_.characterEffect3008ui_story.fillFlat = false
			end

			local var_31_9 = arg_28_1.actors_["3009ui_story"]
			local var_31_10 = 0

			if var_31_10 < arg_28_1.time_ and arg_28_1.time_ <= var_31_10 + arg_31_0 and not isNil(var_31_9) and arg_28_1.var_.characterEffect3009ui_story == nil then
				arg_28_1.var_.characterEffect3009ui_story = var_31_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_11 = 0.1

			if var_31_10 <= arg_28_1.time_ and arg_28_1.time_ < var_31_10 + var_31_11 and not isNil(var_31_9) then
				local var_31_12 = (arg_28_1.time_ - var_31_10) / var_31_11

				if arg_28_1.var_.characterEffect3009ui_story and not isNil(var_31_9) then
					local var_31_13 = Mathf.Lerp(0, 0.5, var_31_12)

					arg_28_1.var_.characterEffect3009ui_story.fillFlat = true
					arg_28_1.var_.characterEffect3009ui_story.fillRatio = var_31_13
				end
			end

			if arg_28_1.time_ >= var_31_10 + var_31_11 and arg_28_1.time_ < var_31_10 + var_31_11 + arg_31_0 and not isNil(var_31_9) and arg_28_1.var_.characterEffect3009ui_story then
				local var_31_14 = 0.5

				arg_28_1.var_.characterEffect3009ui_story.fillFlat = true
				arg_28_1.var_.characterEffect3009ui_story.fillRatio = var_31_14
			end

			local var_31_15 = arg_28_1.actors_["3008ui_story"].transform
			local var_31_16 = 0

			if var_31_16 < arg_28_1.time_ and arg_28_1.time_ <= var_31_16 + arg_31_0 then
				arg_28_1.var_.moveOldPos3008ui_story = var_31_15.localPosition
			end

			local var_31_17 = 0.001

			if var_31_16 <= arg_28_1.time_ and arg_28_1.time_ < var_31_16 + var_31_17 then
				local var_31_18 = (arg_28_1.time_ - var_31_16) / var_31_17
				local var_31_19 = Vector3.New(0.7, -1.51, -4.3)

				var_31_15.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos3008ui_story, var_31_19, var_31_18)

				local var_31_20 = manager.ui.mainCamera.transform.position - var_31_15.position

				var_31_15.forward = Vector3.New(var_31_20.x, var_31_20.y, var_31_20.z)

				local var_31_21 = var_31_15.localEulerAngles

				var_31_21.z = 0
				var_31_21.x = 0
				var_31_15.localEulerAngles = var_31_21
			end

			if arg_28_1.time_ >= var_31_16 + var_31_17 and arg_28_1.time_ < var_31_16 + var_31_17 + arg_31_0 then
				var_31_15.localPosition = Vector3.New(0.7, -1.51, -4.3)

				local var_31_22 = manager.ui.mainCamera.transform.position - var_31_15.position

				var_31_15.forward = Vector3.New(var_31_22.x, var_31_22.y, var_31_22.z)

				local var_31_23 = var_31_15.localEulerAngles

				var_31_23.z = 0
				var_31_23.x = 0
				var_31_15.localEulerAngles = var_31_23
			end

			local var_31_24 = 0

			if var_31_24 < arg_28_1.time_ and arg_28_1.time_ <= var_31_24 + arg_31_0 then
				arg_28_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/story3008/story3008action/3008action1_1")
			end

			local var_31_25 = 0

			if var_31_25 < arg_28_1.time_ and arg_28_1.time_ <= var_31_25 + arg_31_0 then
				arg_28_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_31_26 = 0
			local var_31_27 = 0.2

			if var_31_26 < arg_28_1.time_ and arg_28_1.time_ <= var_31_26 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				local var_31_28 = arg_28_1:FormatText(StoryNameCfg[20].name)

				arg_28_1.leftNameTxt_.text = var_31_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_29 = arg_28_1:GetWordFromCfg(103041007)
				local var_31_30 = arg_28_1:FormatText(var_31_29.content)

				arg_28_1.text_.text = var_31_30

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_31 = 8
				local var_31_32 = utf8.len(var_31_30)
				local var_31_33 = var_31_31 <= 0 and var_31_27 or var_31_27 * (var_31_32 / var_31_31)

				if var_31_33 > 0 and var_31_27 < var_31_33 then
					arg_28_1.talkMaxDuration = var_31_33

					if var_31_33 + var_31_26 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_33 + var_31_26
					end
				end

				arg_28_1.text_.text = var_31_30
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103041", "103041007", "story_v_out_103041.awb") ~= 0 then
					local var_31_34 = manager.audio:GetVoiceLength("story_v_out_103041", "103041007", "story_v_out_103041.awb") / 1000

					if var_31_34 + var_31_26 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_34 + var_31_26
					end

					if var_31_29.prefab_name ~= "" and arg_28_1.actors_[var_31_29.prefab_name] ~= nil then
						local var_31_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_29.prefab_name].transform, "story_v_out_103041", "103041007", "story_v_out_103041.awb")

						arg_28_1:RecordAudio("103041007", var_31_35)
						arg_28_1:RecordAudio("103041007", var_31_35)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_103041", "103041007", "story_v_out_103041.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_103041", "103041007", "story_v_out_103041.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_36 = math.max(var_31_27, arg_28_1.talkMaxDuration)

			if var_31_26 <= arg_28_1.time_ and arg_28_1.time_ < var_31_26 + var_31_36 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_26) / var_31_36

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_26 + var_31_36 and arg_28_1.time_ < var_31_26 + var_31_36 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3008ui_story",
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
	Play103041008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 103041008
		arg_32_1.duration_ = 8.03

		local var_32_0 = {
			ja = 8.033,
			ko = 5.8,
			zh = 5.366,
			en = 5.566
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
				arg_32_0:Play103041009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = arg_32_1.actors_["4010ui_story"]
			local var_35_1 = 0

			if var_35_1 < arg_32_1.time_ and arg_32_1.time_ <= var_35_1 + arg_35_0 and not isNil(var_35_0) and arg_32_1.var_.characterEffect4010ui_story == nil then
				arg_32_1.var_.characterEffect4010ui_story = var_35_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_2 = 0.1

			if var_35_1 <= arg_32_1.time_ and arg_32_1.time_ < var_35_1 + var_35_2 and not isNil(var_35_0) then
				local var_35_3 = (arg_32_1.time_ - var_35_1) / var_35_2

				if arg_32_1.var_.characterEffect4010ui_story and not isNil(var_35_0) then
					arg_32_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_32_1.time_ >= var_35_1 + var_35_2 and arg_32_1.time_ < var_35_1 + var_35_2 + arg_35_0 and not isNil(var_35_0) and arg_32_1.var_.characterEffect4010ui_story then
				arg_32_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_35_4 = arg_32_1.actors_["3008ui_story"]
			local var_35_5 = 0

			if var_35_5 < arg_32_1.time_ and arg_32_1.time_ <= var_35_5 + arg_35_0 and not isNil(var_35_4) and arg_32_1.var_.characterEffect3008ui_story == nil then
				arg_32_1.var_.characterEffect3008ui_story = var_35_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_6 = 0.1

			if var_35_5 <= arg_32_1.time_ and arg_32_1.time_ < var_35_5 + var_35_6 and not isNil(var_35_4) then
				local var_35_7 = (arg_32_1.time_ - var_35_5) / var_35_6

				if arg_32_1.var_.characterEffect3008ui_story and not isNil(var_35_4) then
					local var_35_8 = Mathf.Lerp(0, 0.5, var_35_7)

					arg_32_1.var_.characterEffect3008ui_story.fillFlat = true
					arg_32_1.var_.characterEffect3008ui_story.fillRatio = var_35_8
				end
			end

			if arg_32_1.time_ >= var_35_5 + var_35_6 and arg_32_1.time_ < var_35_5 + var_35_6 + arg_35_0 and not isNil(var_35_4) and arg_32_1.var_.characterEffect3008ui_story then
				local var_35_9 = 0.5

				arg_32_1.var_.characterEffect3008ui_story.fillFlat = true
				arg_32_1.var_.characterEffect3008ui_story.fillRatio = var_35_9
			end

			local var_35_10 = arg_32_1.actors_["3008ui_story"].transform
			local var_35_11 = 0

			if var_35_11 < arg_32_1.time_ and arg_32_1.time_ <= var_35_11 + arg_35_0 then
				arg_32_1.var_.moveOldPos3008ui_story = var_35_10.localPosition
			end

			local var_35_12 = 0.001

			if var_35_11 <= arg_32_1.time_ and arg_32_1.time_ < var_35_11 + var_35_12 then
				local var_35_13 = (arg_32_1.time_ - var_35_11) / var_35_12
				local var_35_14 = Vector3.New(0, 100, 0)

				var_35_10.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos3008ui_story, var_35_14, var_35_13)

				local var_35_15 = manager.ui.mainCamera.transform.position - var_35_10.position

				var_35_10.forward = Vector3.New(var_35_15.x, var_35_15.y, var_35_15.z)

				local var_35_16 = var_35_10.localEulerAngles

				var_35_16.z = 0
				var_35_16.x = 0
				var_35_10.localEulerAngles = var_35_16
			end

			if arg_32_1.time_ >= var_35_11 + var_35_12 and arg_32_1.time_ < var_35_11 + var_35_12 + arg_35_0 then
				var_35_10.localPosition = Vector3.New(0, 100, 0)

				local var_35_17 = manager.ui.mainCamera.transform.position - var_35_10.position

				var_35_10.forward = Vector3.New(var_35_17.x, var_35_17.y, var_35_17.z)

				local var_35_18 = var_35_10.localEulerAngles

				var_35_18.z = 0
				var_35_18.x = 0
				var_35_10.localEulerAngles = var_35_18
			end

			local var_35_19 = arg_32_1.actors_["3009ui_story"].transform
			local var_35_20 = 0

			if var_35_20 < arg_32_1.time_ and arg_32_1.time_ <= var_35_20 + arg_35_0 then
				arg_32_1.var_.moveOldPos3009ui_story = var_35_19.localPosition
			end

			local var_35_21 = 0.001

			if var_35_20 <= arg_32_1.time_ and arg_32_1.time_ < var_35_20 + var_35_21 then
				local var_35_22 = (arg_32_1.time_ - var_35_20) / var_35_21
				local var_35_23 = Vector3.New(0, 100, 0)

				var_35_19.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos3009ui_story, var_35_23, var_35_22)

				local var_35_24 = manager.ui.mainCamera.transform.position - var_35_19.position

				var_35_19.forward = Vector3.New(var_35_24.x, var_35_24.y, var_35_24.z)

				local var_35_25 = var_35_19.localEulerAngles

				var_35_25.z = 0
				var_35_25.x = 0
				var_35_19.localEulerAngles = var_35_25
			end

			if arg_32_1.time_ >= var_35_20 + var_35_21 and arg_32_1.time_ < var_35_20 + var_35_21 + arg_35_0 then
				var_35_19.localPosition = Vector3.New(0, 100, 0)

				local var_35_26 = manager.ui.mainCamera.transform.position - var_35_19.position

				var_35_19.forward = Vector3.New(var_35_26.x, var_35_26.y, var_35_26.z)

				local var_35_27 = var_35_19.localEulerAngles

				var_35_27.z = 0
				var_35_27.x = 0
				var_35_19.localEulerAngles = var_35_27
			end

			local var_35_28 = arg_32_1.actors_["4010ui_story"].transform
			local var_35_29 = 0

			if var_35_29 < arg_32_1.time_ and arg_32_1.time_ <= var_35_29 + arg_35_0 then
				arg_32_1.var_.moveOldPos4010ui_story = var_35_28.localPosition
			end

			local var_35_30 = 0.001

			if var_35_29 <= arg_32_1.time_ and arg_32_1.time_ < var_35_29 + var_35_30 then
				local var_35_31 = (arg_32_1.time_ - var_35_29) / var_35_30
				local var_35_32 = Vector3.New(-0.7, -1.59, -5.2)

				var_35_28.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos4010ui_story, var_35_32, var_35_31)

				local var_35_33 = manager.ui.mainCamera.transform.position - var_35_28.position

				var_35_28.forward = Vector3.New(var_35_33.x, var_35_33.y, var_35_33.z)

				local var_35_34 = var_35_28.localEulerAngles

				var_35_34.z = 0
				var_35_34.x = 0
				var_35_28.localEulerAngles = var_35_34
			end

			if arg_32_1.time_ >= var_35_29 + var_35_30 and arg_32_1.time_ < var_35_29 + var_35_30 + arg_35_0 then
				var_35_28.localPosition = Vector3.New(-0.7, -1.59, -5.2)

				local var_35_35 = manager.ui.mainCamera.transform.position - var_35_28.position

				var_35_28.forward = Vector3.New(var_35_35.x, var_35_35.y, var_35_35.z)

				local var_35_36 = var_35_28.localEulerAngles

				var_35_36.z = 0
				var_35_36.x = 0
				var_35_28.localEulerAngles = var_35_36
			end

			local var_35_37 = 0

			if var_35_37 < arg_32_1.time_ and arg_32_1.time_ <= var_35_37 + arg_35_0 then
				arg_32_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action1_1")
			end

			local var_35_38 = 0

			if var_35_38 < arg_32_1.time_ and arg_32_1.time_ <= var_35_38 + arg_35_0 then
				arg_32_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_35_39 = 0
			local var_35_40 = 0.575

			if var_35_39 < arg_32_1.time_ and arg_32_1.time_ <= var_35_39 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				local var_35_41 = arg_32_1:FormatText(StoryNameCfg[42].name)

				arg_32_1.leftNameTxt_.text = var_35_41

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_42 = arg_32_1:GetWordFromCfg(103041008)
				local var_35_43 = arg_32_1:FormatText(var_35_42.content)

				arg_32_1.text_.text = var_35_43

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_44 = 23
				local var_35_45 = utf8.len(var_35_43)
				local var_35_46 = var_35_44 <= 0 and var_35_40 or var_35_40 * (var_35_45 / var_35_44)

				if var_35_46 > 0 and var_35_40 < var_35_46 then
					arg_32_1.talkMaxDuration = var_35_46

					if var_35_46 + var_35_39 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_46 + var_35_39
					end
				end

				arg_32_1.text_.text = var_35_43
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103041", "103041008", "story_v_out_103041.awb") ~= 0 then
					local var_35_47 = manager.audio:GetVoiceLength("story_v_out_103041", "103041008", "story_v_out_103041.awb") / 1000

					if var_35_47 + var_35_39 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_47 + var_35_39
					end

					if var_35_42.prefab_name ~= "" and arg_32_1.actors_[var_35_42.prefab_name] ~= nil then
						local var_35_48 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_42.prefab_name].transform, "story_v_out_103041", "103041008", "story_v_out_103041.awb")

						arg_32_1:RecordAudio("103041008", var_35_48)
						arg_32_1:RecordAudio("103041008", var_35_48)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_103041", "103041008", "story_v_out_103041.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_103041", "103041008", "story_v_out_103041.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_49 = math.max(var_35_40, arg_32_1.talkMaxDuration)

			if var_35_39 <= arg_32_1.time_ and arg_32_1.time_ < var_35_39 + var_35_49 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_39) / var_35_49

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_39 + var_35_49 and arg_32_1.time_ < var_35_39 + var_35_49 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3008ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "3009ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4010ui_story",
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
	Play103041009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 103041009
		arg_36_1.duration_ = 4.67

		local var_36_0 = {
			ja = 4.666,
			ko = 3.033,
			zh = 3.366,
			en = 3.066
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
				arg_36_0:Play103041010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = "1011ui_story"

			if arg_36_1.actors_[var_39_0] == nil then
				local var_39_1 = Asset.Load("Char/" .. "1011ui_story")

				if not isNil(var_39_1) then
					local var_39_2 = Object.Instantiate(Asset.Load("Char/" .. "1011ui_story"), arg_36_1.stage_.transform)

					var_39_2.name = var_39_0
					var_39_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_36_1.actors_[var_39_0] = var_39_2

					local var_39_3 = var_39_2:GetComponentInChildren(typeof(CharacterEffect))

					var_39_3.enabled = true

					local var_39_4 = GameObjectTools.GetOrAddComponent(var_39_2, typeof(DynamicBoneHelper))

					if var_39_4 then
						var_39_4:EnableDynamicBone(false)
					end

					arg_36_1:ShowWeapon(var_39_3.transform, false)

					arg_36_1.var_[var_39_0 .. "Animator"] = var_39_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_36_1.var_[var_39_0 .. "Animator"].applyRootMotion = true
					arg_36_1.var_[var_39_0 .. "LipSync"] = var_39_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_39_5 = arg_36_1.actors_["1011ui_story"]
			local var_39_6 = 0

			if var_39_6 < arg_36_1.time_ and arg_36_1.time_ <= var_39_6 + arg_39_0 and not isNil(var_39_5) and arg_36_1.var_.characterEffect1011ui_story == nil then
				arg_36_1.var_.characterEffect1011ui_story = var_39_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_7 = 0.1

			if var_39_6 <= arg_36_1.time_ and arg_36_1.time_ < var_39_6 + var_39_7 and not isNil(var_39_5) then
				local var_39_8 = (arg_36_1.time_ - var_39_6) / var_39_7

				if arg_36_1.var_.characterEffect1011ui_story and not isNil(var_39_5) then
					arg_36_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_36_1.time_ >= var_39_6 + var_39_7 and arg_36_1.time_ < var_39_6 + var_39_7 + arg_39_0 and not isNil(var_39_5) and arg_36_1.var_.characterEffect1011ui_story then
				arg_36_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_39_9 = arg_36_1.actors_["4010ui_story"]
			local var_39_10 = 0

			if var_39_10 < arg_36_1.time_ and arg_36_1.time_ <= var_39_10 + arg_39_0 and not isNil(var_39_9) and arg_36_1.var_.characterEffect4010ui_story == nil then
				arg_36_1.var_.characterEffect4010ui_story = var_39_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_11 = 0.1

			if var_39_10 <= arg_36_1.time_ and arg_36_1.time_ < var_39_10 + var_39_11 and not isNil(var_39_9) then
				local var_39_12 = (arg_36_1.time_ - var_39_10) / var_39_11

				if arg_36_1.var_.characterEffect4010ui_story and not isNil(var_39_9) then
					local var_39_13 = Mathf.Lerp(0, 0.5, var_39_12)

					arg_36_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_36_1.var_.characterEffect4010ui_story.fillRatio = var_39_13
				end
			end

			if arg_36_1.time_ >= var_39_10 + var_39_11 and arg_36_1.time_ < var_39_10 + var_39_11 + arg_39_0 and not isNil(var_39_9) and arg_36_1.var_.characterEffect4010ui_story then
				local var_39_14 = 0.5

				arg_36_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_36_1.var_.characterEffect4010ui_story.fillRatio = var_39_14
			end

			local var_39_15 = 0

			if var_39_15 < arg_36_1.time_ and arg_36_1.time_ <= var_39_15 + arg_39_0 then
				arg_36_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action2_1")
			end

			local var_39_16 = arg_36_1.actors_["1011ui_story"].transform
			local var_39_17 = 0

			if var_39_17 < arg_36_1.time_ and arg_36_1.time_ <= var_39_17 + arg_39_0 then
				arg_36_1.var_.moveOldPos1011ui_story = var_39_16.localPosition
			end

			local var_39_18 = 0.001

			if var_39_17 <= arg_36_1.time_ and arg_36_1.time_ < var_39_17 + var_39_18 then
				local var_39_19 = (arg_36_1.time_ - var_39_17) / var_39_18
				local var_39_20 = Vector3.New(0.7, -0.71, -6)

				var_39_16.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos1011ui_story, var_39_20, var_39_19)

				local var_39_21 = manager.ui.mainCamera.transform.position - var_39_16.position

				var_39_16.forward = Vector3.New(var_39_21.x, var_39_21.y, var_39_21.z)

				local var_39_22 = var_39_16.localEulerAngles

				var_39_22.z = 0
				var_39_22.x = 0
				var_39_16.localEulerAngles = var_39_22
			end

			if arg_36_1.time_ >= var_39_17 + var_39_18 and arg_36_1.time_ < var_39_17 + var_39_18 + arg_39_0 then
				var_39_16.localPosition = Vector3.New(0.7, -0.71, -6)

				local var_39_23 = manager.ui.mainCamera.transform.position - var_39_16.position

				var_39_16.forward = Vector3.New(var_39_23.x, var_39_23.y, var_39_23.z)

				local var_39_24 = var_39_16.localEulerAngles

				var_39_24.z = 0
				var_39_24.x = 0
				var_39_16.localEulerAngles = var_39_24
			end

			local var_39_25 = 0

			if var_39_25 < arg_36_1.time_ and arg_36_1.time_ <= var_39_25 + arg_39_0 then
				arg_36_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_39_26 = 0
			local var_39_27 = 0.325

			if var_39_26 < arg_36_1.time_ and arg_36_1.time_ <= var_39_26 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				local var_39_28 = arg_36_1:FormatText(StoryNameCfg[37].name)

				arg_36_1.leftNameTxt_.text = var_39_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_29 = arg_36_1:GetWordFromCfg(103041009)
				local var_39_30 = arg_36_1:FormatText(var_39_29.content)

				arg_36_1.text_.text = var_39_30

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_31 = 13
				local var_39_32 = utf8.len(var_39_30)
				local var_39_33 = var_39_31 <= 0 and var_39_27 or var_39_27 * (var_39_32 / var_39_31)

				if var_39_33 > 0 and var_39_27 < var_39_33 then
					arg_36_1.talkMaxDuration = var_39_33

					if var_39_33 + var_39_26 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_33 + var_39_26
					end
				end

				arg_36_1.text_.text = var_39_30
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103041", "103041009", "story_v_out_103041.awb") ~= 0 then
					local var_39_34 = manager.audio:GetVoiceLength("story_v_out_103041", "103041009", "story_v_out_103041.awb") / 1000

					if var_39_34 + var_39_26 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_34 + var_39_26
					end

					if var_39_29.prefab_name ~= "" and arg_36_1.actors_[var_39_29.prefab_name] ~= nil then
						local var_39_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_29.prefab_name].transform, "story_v_out_103041", "103041009", "story_v_out_103041.awb")

						arg_36_1:RecordAudio("103041009", var_39_35)
						arg_36_1:RecordAudio("103041009", var_39_35)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_103041", "103041009", "story_v_out_103041.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_103041", "103041009", "story_v_out_103041.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_36 = math.max(var_39_27, arg_36_1.talkMaxDuration)

			if var_39_26 <= arg_36_1.time_ and arg_36_1.time_ < var_39_26 + var_39_36 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_26) / var_39_36

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_26 + var_39_36 and arg_36_1.time_ < var_39_26 + var_39_36 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
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
	Play103041010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 103041010
		arg_40_1.duration_ = 10.5

		local var_40_0 = {
			ja = 10.5,
			ko = 7.7,
			zh = 7.5,
			en = 6.133
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
				arg_40_0:Play103041011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = arg_40_1.actors_["4010ui_story"]
			local var_43_1 = 0

			if var_43_1 < arg_40_1.time_ and arg_40_1.time_ <= var_43_1 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.characterEffect4010ui_story == nil then
				arg_40_1.var_.characterEffect4010ui_story = var_43_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_2 = 0.1

			if var_43_1 <= arg_40_1.time_ and arg_40_1.time_ < var_43_1 + var_43_2 and not isNil(var_43_0) then
				local var_43_3 = (arg_40_1.time_ - var_43_1) / var_43_2

				if arg_40_1.var_.characterEffect4010ui_story and not isNil(var_43_0) then
					arg_40_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_40_1.time_ >= var_43_1 + var_43_2 and arg_40_1.time_ < var_43_1 + var_43_2 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.characterEffect4010ui_story then
				arg_40_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_43_4 = arg_40_1.actors_["1011ui_story"]
			local var_43_5 = 0

			if var_43_5 < arg_40_1.time_ and arg_40_1.time_ <= var_43_5 + arg_43_0 and not isNil(var_43_4) and arg_40_1.var_.characterEffect1011ui_story == nil then
				arg_40_1.var_.characterEffect1011ui_story = var_43_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_6 = 0.1

			if var_43_5 <= arg_40_1.time_ and arg_40_1.time_ < var_43_5 + var_43_6 and not isNil(var_43_4) then
				local var_43_7 = (arg_40_1.time_ - var_43_5) / var_43_6

				if arg_40_1.var_.characterEffect1011ui_story and not isNil(var_43_4) then
					local var_43_8 = Mathf.Lerp(0, 0.5, var_43_7)

					arg_40_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_40_1.var_.characterEffect1011ui_story.fillRatio = var_43_8
				end
			end

			if arg_40_1.time_ >= var_43_5 + var_43_6 and arg_40_1.time_ < var_43_5 + var_43_6 + arg_43_0 and not isNil(var_43_4) and arg_40_1.var_.characterEffect1011ui_story then
				local var_43_9 = 0.5

				arg_40_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_40_1.var_.characterEffect1011ui_story.fillRatio = var_43_9
			end

			local var_43_10 = 0

			if var_43_10 < arg_40_1.time_ and arg_40_1.time_ <= var_43_10 + arg_43_0 then
				arg_40_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_43_11 = 0

			if var_43_11 < arg_40_1.time_ and arg_40_1.time_ <= var_43_11 + arg_43_0 then
				arg_40_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action2_1")
			end

			local var_43_12 = 0
			local var_43_13 = 0.825

			if var_43_12 < arg_40_1.time_ and arg_40_1.time_ <= var_43_12 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				local var_43_14 = arg_40_1:FormatText(StoryNameCfg[42].name)

				arg_40_1.leftNameTxt_.text = var_43_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_15 = arg_40_1:GetWordFromCfg(103041010)
				local var_43_16 = arg_40_1:FormatText(var_43_15.content)

				arg_40_1.text_.text = var_43_16

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_17 = 33
				local var_43_18 = utf8.len(var_43_16)
				local var_43_19 = var_43_17 <= 0 and var_43_13 or var_43_13 * (var_43_18 / var_43_17)

				if var_43_19 > 0 and var_43_13 < var_43_19 then
					arg_40_1.talkMaxDuration = var_43_19

					if var_43_19 + var_43_12 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_19 + var_43_12
					end
				end

				arg_40_1.text_.text = var_43_16
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103041", "103041010", "story_v_out_103041.awb") ~= 0 then
					local var_43_20 = manager.audio:GetVoiceLength("story_v_out_103041", "103041010", "story_v_out_103041.awb") / 1000

					if var_43_20 + var_43_12 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_20 + var_43_12
					end

					if var_43_15.prefab_name ~= "" and arg_40_1.actors_[var_43_15.prefab_name] ~= nil then
						local var_43_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_15.prefab_name].transform, "story_v_out_103041", "103041010", "story_v_out_103041.awb")

						arg_40_1:RecordAudio("103041010", var_43_21)
						arg_40_1:RecordAudio("103041010", var_43_21)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_103041", "103041010", "story_v_out_103041.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_103041", "103041010", "story_v_out_103041.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_22 = math.max(var_43_13, arg_40_1.talkMaxDuration)

			if var_43_12 <= arg_40_1.time_ and arg_40_1.time_ < var_43_12 + var_43_22 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_12) / var_43_22

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_12 + var_43_22 and arg_40_1.time_ < var_43_12 + var_43_22 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play103041011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 103041011
		arg_44_1.duration_ = 2

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play103041012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = "1019ui_story"

			if arg_44_1.actors_[var_47_0] == nil then
				local var_47_1 = Asset.Load("Char/" .. "1019ui_story")

				if not isNil(var_47_1) then
					local var_47_2 = Object.Instantiate(Asset.Load("Char/" .. "1019ui_story"), arg_44_1.stage_.transform)

					var_47_2.name = var_47_0
					var_47_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_44_1.actors_[var_47_0] = var_47_2

					local var_47_3 = var_47_2:GetComponentInChildren(typeof(CharacterEffect))

					var_47_3.enabled = true

					local var_47_4 = GameObjectTools.GetOrAddComponent(var_47_2, typeof(DynamicBoneHelper))

					if var_47_4 then
						var_47_4:EnableDynamicBone(false)
					end

					arg_44_1:ShowWeapon(var_47_3.transform, false)

					arg_44_1.var_[var_47_0 .. "Animator"] = var_47_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_44_1.var_[var_47_0 .. "Animator"].applyRootMotion = true
					arg_44_1.var_[var_47_0 .. "LipSync"] = var_47_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_47_5 = arg_44_1.actors_["1019ui_story"]
			local var_47_6 = 0

			if var_47_6 < arg_44_1.time_ and arg_44_1.time_ <= var_47_6 + arg_47_0 and not isNil(var_47_5) and arg_44_1.var_.characterEffect1019ui_story == nil then
				arg_44_1.var_.characterEffect1019ui_story = var_47_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_7 = 0.1

			if var_47_6 <= arg_44_1.time_ and arg_44_1.time_ < var_47_6 + var_47_7 and not isNil(var_47_5) then
				local var_47_8 = (arg_44_1.time_ - var_47_6) / var_47_7

				if arg_44_1.var_.characterEffect1019ui_story and not isNil(var_47_5) then
					arg_44_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_44_1.time_ >= var_47_6 + var_47_7 and arg_44_1.time_ < var_47_6 + var_47_7 + arg_47_0 and not isNil(var_47_5) and arg_44_1.var_.characterEffect1019ui_story then
				arg_44_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_47_9 = arg_44_1.actors_["4010ui_story"]
			local var_47_10 = 0

			if var_47_10 < arg_44_1.time_ and arg_44_1.time_ <= var_47_10 + arg_47_0 and not isNil(var_47_9) and arg_44_1.var_.characterEffect4010ui_story == nil then
				arg_44_1.var_.characterEffect4010ui_story = var_47_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_11 = 0.1

			if var_47_10 <= arg_44_1.time_ and arg_44_1.time_ < var_47_10 + var_47_11 and not isNil(var_47_9) then
				local var_47_12 = (arg_44_1.time_ - var_47_10) / var_47_11

				if arg_44_1.var_.characterEffect4010ui_story and not isNil(var_47_9) then
					local var_47_13 = Mathf.Lerp(0, 0.5, var_47_12)

					arg_44_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_44_1.var_.characterEffect4010ui_story.fillRatio = var_47_13
				end
			end

			if arg_44_1.time_ >= var_47_10 + var_47_11 and arg_44_1.time_ < var_47_10 + var_47_11 + arg_47_0 and not isNil(var_47_9) and arg_44_1.var_.characterEffect4010ui_story then
				local var_47_14 = 0.5

				arg_44_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_44_1.var_.characterEffect4010ui_story.fillRatio = var_47_14
			end

			local var_47_15 = arg_44_1.actors_["1011ui_story"].transform
			local var_47_16 = 0

			if var_47_16 < arg_44_1.time_ and arg_44_1.time_ <= var_47_16 + arg_47_0 then
				arg_44_1.var_.moveOldPos1011ui_story = var_47_15.localPosition
			end

			local var_47_17 = 0.001

			if var_47_16 <= arg_44_1.time_ and arg_44_1.time_ < var_47_16 + var_47_17 then
				local var_47_18 = (arg_44_1.time_ - var_47_16) / var_47_17
				local var_47_19 = Vector3.New(0, 100, 0)

				var_47_15.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos1011ui_story, var_47_19, var_47_18)

				local var_47_20 = manager.ui.mainCamera.transform.position - var_47_15.position

				var_47_15.forward = Vector3.New(var_47_20.x, var_47_20.y, var_47_20.z)

				local var_47_21 = var_47_15.localEulerAngles

				var_47_21.z = 0
				var_47_21.x = 0
				var_47_15.localEulerAngles = var_47_21
			end

			if arg_44_1.time_ >= var_47_16 + var_47_17 and arg_44_1.time_ < var_47_16 + var_47_17 + arg_47_0 then
				var_47_15.localPosition = Vector3.New(0, 100, 0)

				local var_47_22 = manager.ui.mainCamera.transform.position - var_47_15.position

				var_47_15.forward = Vector3.New(var_47_22.x, var_47_22.y, var_47_22.z)

				local var_47_23 = var_47_15.localEulerAngles

				var_47_23.z = 0
				var_47_23.x = 0
				var_47_15.localEulerAngles = var_47_23
			end

			local var_47_24 = arg_44_1.actors_["1019ui_story"].transform
			local var_47_25 = 0

			if var_47_25 < arg_44_1.time_ and arg_44_1.time_ <= var_47_25 + arg_47_0 then
				arg_44_1.var_.moveOldPos1019ui_story = var_47_24.localPosition
			end

			local var_47_26 = 0.001

			if var_47_25 <= arg_44_1.time_ and arg_44_1.time_ < var_47_25 + var_47_26 then
				local var_47_27 = (arg_44_1.time_ - var_47_25) / var_47_26
				local var_47_28 = Vector3.New(0.7, -1.08, -5.9)

				var_47_24.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos1019ui_story, var_47_28, var_47_27)

				local var_47_29 = manager.ui.mainCamera.transform.position - var_47_24.position

				var_47_24.forward = Vector3.New(var_47_29.x, var_47_29.y, var_47_29.z)

				local var_47_30 = var_47_24.localEulerAngles

				var_47_30.z = 0
				var_47_30.x = 0
				var_47_24.localEulerAngles = var_47_30
			end

			if arg_44_1.time_ >= var_47_25 + var_47_26 and arg_44_1.time_ < var_47_25 + var_47_26 + arg_47_0 then
				var_47_24.localPosition = Vector3.New(0.7, -1.08, -5.9)

				local var_47_31 = manager.ui.mainCamera.transform.position - var_47_24.position

				var_47_24.forward = Vector3.New(var_47_31.x, var_47_31.y, var_47_31.z)

				local var_47_32 = var_47_24.localEulerAngles

				var_47_32.z = 0
				var_47_32.x = 0
				var_47_24.localEulerAngles = var_47_32
			end

			local var_47_33 = 0

			if var_47_33 < arg_44_1.time_ and arg_44_1.time_ <= var_47_33 + arg_47_0 then
				arg_44_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action6_1")
			end

			local var_47_34 = 0

			if var_47_34 < arg_44_1.time_ and arg_44_1.time_ <= var_47_34 + arg_47_0 then
				arg_44_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_47_35 = 0
			local var_47_36 = 0.175

			if var_47_35 < arg_44_1.time_ and arg_44_1.time_ <= var_47_35 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				local var_47_37 = arg_44_1:FormatText(StoryNameCfg[13].name)

				arg_44_1.leftNameTxt_.text = var_47_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_38 = arg_44_1:GetWordFromCfg(103041011)
				local var_47_39 = arg_44_1:FormatText(var_47_38.content)

				arg_44_1.text_.text = var_47_39

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_40 = 7
				local var_47_41 = utf8.len(var_47_39)
				local var_47_42 = var_47_40 <= 0 and var_47_36 or var_47_36 * (var_47_41 / var_47_40)

				if var_47_42 > 0 and var_47_36 < var_47_42 then
					arg_44_1.talkMaxDuration = var_47_42

					if var_47_42 + var_47_35 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_42 + var_47_35
					end
				end

				arg_44_1.text_.text = var_47_39
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103041", "103041011", "story_v_out_103041.awb") ~= 0 then
					local var_47_43 = manager.audio:GetVoiceLength("story_v_out_103041", "103041011", "story_v_out_103041.awb") / 1000

					if var_47_43 + var_47_35 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_43 + var_47_35
					end

					if var_47_38.prefab_name ~= "" and arg_44_1.actors_[var_47_38.prefab_name] ~= nil then
						local var_47_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_38.prefab_name].transform, "story_v_out_103041", "103041011", "story_v_out_103041.awb")

						arg_44_1:RecordAudio("103041011", var_47_44)
						arg_44_1:RecordAudio("103041011", var_47_44)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_103041", "103041011", "story_v_out_103041.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_103041", "103041011", "story_v_out_103041.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_45 = math.max(var_47_36, arg_44_1.talkMaxDuration)

			if var_47_35 <= arg_44_1.time_ and arg_44_1.time_ < var_47_35 + var_47_45 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_35) / var_47_45

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_35 + var_47_45 and arg_44_1.time_ < var_47_35 + var_47_45 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_44_1:InitPlayNodeList()
	end,
	Play103041012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 103041012
		arg_48_1.duration_ = 4.97

		local var_48_0 = {
			ja = 4.966,
			ko = 3.266,
			zh = 3.6,
			en = 4.5
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
				arg_48_0:Play103041013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = arg_48_1.actors_["4010ui_story"]
			local var_51_1 = 0

			if var_51_1 < arg_48_1.time_ and arg_48_1.time_ <= var_51_1 + arg_51_0 and not isNil(var_51_0) and arg_48_1.var_.characterEffect4010ui_story == nil then
				arg_48_1.var_.characterEffect4010ui_story = var_51_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_2 = 0.1

			if var_51_1 <= arg_48_1.time_ and arg_48_1.time_ < var_51_1 + var_51_2 and not isNil(var_51_0) then
				local var_51_3 = (arg_48_1.time_ - var_51_1) / var_51_2

				if arg_48_1.var_.characterEffect4010ui_story and not isNil(var_51_0) then
					arg_48_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_48_1.time_ >= var_51_1 + var_51_2 and arg_48_1.time_ < var_51_1 + var_51_2 + arg_51_0 and not isNil(var_51_0) and arg_48_1.var_.characterEffect4010ui_story then
				arg_48_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_51_4 = arg_48_1.actors_["1019ui_story"]
			local var_51_5 = 0

			if var_51_5 < arg_48_1.time_ and arg_48_1.time_ <= var_51_5 + arg_51_0 and not isNil(var_51_4) and arg_48_1.var_.characterEffect1019ui_story == nil then
				arg_48_1.var_.characterEffect1019ui_story = var_51_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_6 = 0.1

			if var_51_5 <= arg_48_1.time_ and arg_48_1.time_ < var_51_5 + var_51_6 and not isNil(var_51_4) then
				local var_51_7 = (arg_48_1.time_ - var_51_5) / var_51_6

				if arg_48_1.var_.characterEffect1019ui_story and not isNil(var_51_4) then
					local var_51_8 = Mathf.Lerp(0, 0.5, var_51_7)

					arg_48_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_48_1.var_.characterEffect1019ui_story.fillRatio = var_51_8
				end
			end

			if arg_48_1.time_ >= var_51_5 + var_51_6 and arg_48_1.time_ < var_51_5 + var_51_6 + arg_51_0 and not isNil(var_51_4) and arg_48_1.var_.characterEffect1019ui_story then
				local var_51_9 = 0.5

				arg_48_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_48_1.var_.characterEffect1019ui_story.fillRatio = var_51_9
			end

			local var_51_10 = 0

			if var_51_10 < arg_48_1.time_ and arg_48_1.time_ <= var_51_10 + arg_51_0 then
				arg_48_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_51_11 = 0
			local var_51_12 = 0.275

			if var_51_11 < arg_48_1.time_ and arg_48_1.time_ <= var_51_11 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				local var_51_13 = arg_48_1:FormatText(StoryNameCfg[42].name)

				arg_48_1.leftNameTxt_.text = var_51_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_14 = arg_48_1:GetWordFromCfg(103041012)
				local var_51_15 = arg_48_1:FormatText(var_51_14.content)

				arg_48_1.text_.text = var_51_15

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_16 = 11
				local var_51_17 = utf8.len(var_51_15)
				local var_51_18 = var_51_16 <= 0 and var_51_12 or var_51_12 * (var_51_17 / var_51_16)

				if var_51_18 > 0 and var_51_12 < var_51_18 then
					arg_48_1.talkMaxDuration = var_51_18

					if var_51_18 + var_51_11 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_18 + var_51_11
					end
				end

				arg_48_1.text_.text = var_51_15
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103041", "103041012", "story_v_out_103041.awb") ~= 0 then
					local var_51_19 = manager.audio:GetVoiceLength("story_v_out_103041", "103041012", "story_v_out_103041.awb") / 1000

					if var_51_19 + var_51_11 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_19 + var_51_11
					end

					if var_51_14.prefab_name ~= "" and arg_48_1.actors_[var_51_14.prefab_name] ~= nil then
						local var_51_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_14.prefab_name].transform, "story_v_out_103041", "103041012", "story_v_out_103041.awb")

						arg_48_1:RecordAudio("103041012", var_51_20)
						arg_48_1:RecordAudio("103041012", var_51_20)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_103041", "103041012", "story_v_out_103041.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_103041", "103041012", "story_v_out_103041.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_21 = math.max(var_51_12, arg_48_1.talkMaxDuration)

			if var_51_11 <= arg_48_1.time_ and arg_48_1.time_ < var_51_11 + var_51_21 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_11) / var_51_21

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_11 + var_51_21 and arg_48_1.time_ < var_51_11 + var_51_21 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play103041013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 103041013
		arg_52_1.duration_ = 16.83

		local var_52_0 = {
			ja = 16.566,
			ko = 14.633,
			zh = 15.366,
			en = 16.833
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
				arg_52_0:Play103041014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = arg_52_1.actors_["4010ui_story"]
			local var_55_1 = 0

			if var_55_1 < arg_52_1.time_ and arg_52_1.time_ <= var_55_1 + arg_55_0 and not isNil(var_55_0) and arg_52_1.var_.characterEffect4010ui_story == nil then
				arg_52_1.var_.characterEffect4010ui_story = var_55_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_2 = 0.1

			if var_55_1 <= arg_52_1.time_ and arg_52_1.time_ < var_55_1 + var_55_2 and not isNil(var_55_0) then
				local var_55_3 = (arg_52_1.time_ - var_55_1) / var_55_2

				if arg_52_1.var_.characterEffect4010ui_story and not isNil(var_55_0) then
					arg_52_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_52_1.time_ >= var_55_1 + var_55_2 and arg_52_1.time_ < var_55_1 + var_55_2 + arg_55_0 and not isNil(var_55_0) and arg_52_1.var_.characterEffect4010ui_story then
				arg_52_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_55_4 = "1084ui_story"

			if arg_52_1.actors_[var_55_4] == nil then
				local var_55_5 = Asset.Load("Char/" .. "1084ui_story")

				if not isNil(var_55_5) then
					local var_55_6 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_52_1.stage_.transform)

					var_55_6.name = var_55_4
					var_55_6.transform.localPosition = Vector3.New(0, 100, 0)
					arg_52_1.actors_[var_55_4] = var_55_6

					local var_55_7 = var_55_6:GetComponentInChildren(typeof(CharacterEffect))

					var_55_7.enabled = true

					local var_55_8 = GameObjectTools.GetOrAddComponent(var_55_6, typeof(DynamicBoneHelper))

					if var_55_8 then
						var_55_8:EnableDynamicBone(false)
					end

					arg_52_1:ShowWeapon(var_55_7.transform, false)

					arg_52_1.var_[var_55_4 .. "Animator"] = var_55_7.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_52_1.var_[var_55_4 .. "Animator"].applyRootMotion = true
					arg_52_1.var_[var_55_4 .. "LipSync"] = var_55_7.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_55_9 = arg_52_1.actors_["1084ui_story"]
			local var_55_10 = 0

			if var_55_10 < arg_52_1.time_ and arg_52_1.time_ <= var_55_10 + arg_55_0 and not isNil(var_55_9) and arg_52_1.var_.characterEffect1084ui_story == nil then
				arg_52_1.var_.characterEffect1084ui_story = var_55_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_11 = 0.1

			if var_55_10 <= arg_52_1.time_ and arg_52_1.time_ < var_55_10 + var_55_11 and not isNil(var_55_9) then
				local var_55_12 = (arg_52_1.time_ - var_55_10) / var_55_11

				if arg_52_1.var_.characterEffect1084ui_story and not isNil(var_55_9) then
					local var_55_13 = Mathf.Lerp(0, 0.5, var_55_12)

					arg_52_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_52_1.var_.characterEffect1084ui_story.fillRatio = var_55_13
				end
			end

			if arg_52_1.time_ >= var_55_10 + var_55_11 and arg_52_1.time_ < var_55_10 + var_55_11 + arg_55_0 and not isNil(var_55_9) and arg_52_1.var_.characterEffect1084ui_story then
				local var_55_14 = 0.5

				arg_52_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_52_1.var_.characterEffect1084ui_story.fillRatio = var_55_14
			end

			local var_55_15 = 0

			if var_55_15 < arg_52_1.time_ and arg_52_1.time_ <= var_55_15 + arg_55_0 then
				arg_52_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_55_16 = 0

			if var_55_16 < arg_52_1.time_ and arg_52_1.time_ <= var_55_16 + arg_55_0 then
				arg_52_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010actionlink/4010action426")
			end

			local var_55_17 = 0
			local var_55_18 = 1.65

			if var_55_17 < arg_52_1.time_ and arg_52_1.time_ <= var_55_17 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				local var_55_19 = arg_52_1:FormatText(StoryNameCfg[42].name)

				arg_52_1.leftNameTxt_.text = var_55_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_20 = arg_52_1:GetWordFromCfg(103041013)
				local var_55_21 = arg_52_1:FormatText(var_55_20.content)

				arg_52_1.text_.text = var_55_21

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_22 = 66
				local var_55_23 = utf8.len(var_55_21)
				local var_55_24 = var_55_22 <= 0 and var_55_18 or var_55_18 * (var_55_23 / var_55_22)

				if var_55_24 > 0 and var_55_18 < var_55_24 then
					arg_52_1.talkMaxDuration = var_55_24

					if var_55_24 + var_55_17 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_24 + var_55_17
					end
				end

				arg_52_1.text_.text = var_55_21
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103041", "103041013", "story_v_out_103041.awb") ~= 0 then
					local var_55_25 = manager.audio:GetVoiceLength("story_v_out_103041", "103041013", "story_v_out_103041.awb") / 1000

					if var_55_25 + var_55_17 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_25 + var_55_17
					end

					if var_55_20.prefab_name ~= "" and arg_52_1.actors_[var_55_20.prefab_name] ~= nil then
						local var_55_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_20.prefab_name].transform, "story_v_out_103041", "103041013", "story_v_out_103041.awb")

						arg_52_1:RecordAudio("103041013", var_55_26)
						arg_52_1:RecordAudio("103041013", var_55_26)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_103041", "103041013", "story_v_out_103041.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_103041", "103041013", "story_v_out_103041.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_27 = math.max(var_55_18, arg_52_1.talkMaxDuration)

			if var_55_17 <= arg_52_1.time_ and arg_52_1.time_ < var_55_17 + var_55_27 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_17) / var_55_27

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_17 + var_55_27 and arg_52_1.time_ < var_55_17 + var_55_27 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play103041014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 103041014
		arg_56_1.duration_ = 7.1

		local var_56_0 = {
			ja = 7.1,
			ko = 3.666,
			zh = 3.833,
			en = 3.433
		}
		local var_56_1 = manager.audio:GetLocalizationFlag()

		if var_56_0[var_56_1] ~= nil then
			arg_56_1.duration_ = var_56_0[var_56_1]
		end

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
			arg_56_1.auto_ = false
		end

		function arg_56_1.playNext_(arg_58_0)
			arg_56_1.onStoryFinished_()
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = arg_56_1.actors_["1011ui_story"]
			local var_59_1 = 0

			if var_59_1 < arg_56_1.time_ and arg_56_1.time_ <= var_59_1 + arg_59_0 and not isNil(var_59_0) and arg_56_1.var_.characterEffect1011ui_story == nil then
				arg_56_1.var_.characterEffect1011ui_story = var_59_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_2 = 0.1

			if var_59_1 <= arg_56_1.time_ and arg_56_1.time_ < var_59_1 + var_59_2 and not isNil(var_59_0) then
				local var_59_3 = (arg_56_1.time_ - var_59_1) / var_59_2

				if arg_56_1.var_.characterEffect1011ui_story and not isNil(var_59_0) then
					arg_56_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_56_1.time_ >= var_59_1 + var_59_2 and arg_56_1.time_ < var_59_1 + var_59_2 + arg_59_0 and not isNil(var_59_0) and arg_56_1.var_.characterEffect1011ui_story then
				arg_56_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_59_4 = arg_56_1.actors_["4010ui_story"]
			local var_59_5 = 0

			if var_59_5 < arg_56_1.time_ and arg_56_1.time_ <= var_59_5 + arg_59_0 and not isNil(var_59_4) and arg_56_1.var_.characterEffect4010ui_story == nil then
				arg_56_1.var_.characterEffect4010ui_story = var_59_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_6 = 0.1

			if var_59_5 <= arg_56_1.time_ and arg_56_1.time_ < var_59_5 + var_59_6 and not isNil(var_59_4) then
				local var_59_7 = (arg_56_1.time_ - var_59_5) / var_59_6

				if arg_56_1.var_.characterEffect4010ui_story and not isNil(var_59_4) then
					local var_59_8 = Mathf.Lerp(0, 0.5, var_59_7)

					arg_56_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_56_1.var_.characterEffect4010ui_story.fillRatio = var_59_8
				end
			end

			if arg_56_1.time_ >= var_59_5 + var_59_6 and arg_56_1.time_ < var_59_5 + var_59_6 + arg_59_0 and not isNil(var_59_4) and arg_56_1.var_.characterEffect4010ui_story then
				local var_59_9 = 0.5

				arg_56_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_56_1.var_.characterEffect4010ui_story.fillRatio = var_59_9
			end

			local var_59_10 = arg_56_1.actors_["4010ui_story"].transform
			local var_59_11 = 0

			if var_59_11 < arg_56_1.time_ and arg_56_1.time_ <= var_59_11 + arg_59_0 then
				arg_56_1.var_.moveOldPos4010ui_story = var_59_10.localPosition
			end

			local var_59_12 = 0.001

			if var_59_11 <= arg_56_1.time_ and arg_56_1.time_ < var_59_11 + var_59_12 then
				local var_59_13 = (arg_56_1.time_ - var_59_11) / var_59_12
				local var_59_14 = Vector3.New(0, 100, 0)

				var_59_10.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos4010ui_story, var_59_14, var_59_13)

				local var_59_15 = manager.ui.mainCamera.transform.position - var_59_10.position

				var_59_10.forward = Vector3.New(var_59_15.x, var_59_15.y, var_59_15.z)

				local var_59_16 = var_59_10.localEulerAngles

				var_59_16.z = 0
				var_59_16.x = 0
				var_59_10.localEulerAngles = var_59_16
			end

			if arg_56_1.time_ >= var_59_11 + var_59_12 and arg_56_1.time_ < var_59_11 + var_59_12 + arg_59_0 then
				var_59_10.localPosition = Vector3.New(0, 100, 0)

				local var_59_17 = manager.ui.mainCamera.transform.position - var_59_10.position

				var_59_10.forward = Vector3.New(var_59_17.x, var_59_17.y, var_59_17.z)

				local var_59_18 = var_59_10.localEulerAngles

				var_59_18.z = 0
				var_59_18.x = 0
				var_59_10.localEulerAngles = var_59_18
			end

			local var_59_19 = arg_56_1.actors_["1019ui_story"].transform
			local var_59_20 = 0

			if var_59_20 < arg_56_1.time_ and arg_56_1.time_ <= var_59_20 + arg_59_0 then
				arg_56_1.var_.moveOldPos1019ui_story = var_59_19.localPosition
			end

			local var_59_21 = 0.001

			if var_59_20 <= arg_56_1.time_ and arg_56_1.time_ < var_59_20 + var_59_21 then
				local var_59_22 = (arg_56_1.time_ - var_59_20) / var_59_21
				local var_59_23 = Vector3.New(0, 100, 0)

				var_59_19.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos1019ui_story, var_59_23, var_59_22)

				local var_59_24 = manager.ui.mainCamera.transform.position - var_59_19.position

				var_59_19.forward = Vector3.New(var_59_24.x, var_59_24.y, var_59_24.z)

				local var_59_25 = var_59_19.localEulerAngles

				var_59_25.z = 0
				var_59_25.x = 0
				var_59_19.localEulerAngles = var_59_25
			end

			if arg_56_1.time_ >= var_59_20 + var_59_21 and arg_56_1.time_ < var_59_20 + var_59_21 + arg_59_0 then
				var_59_19.localPosition = Vector3.New(0, 100, 0)

				local var_59_26 = manager.ui.mainCamera.transform.position - var_59_19.position

				var_59_19.forward = Vector3.New(var_59_26.x, var_59_26.y, var_59_26.z)

				local var_59_27 = var_59_19.localEulerAngles

				var_59_27.z = 0
				var_59_27.x = 0
				var_59_19.localEulerAngles = var_59_27
			end

			local var_59_28 = arg_56_1.actors_["1011ui_story"].transform
			local var_59_29 = 0

			if var_59_29 < arg_56_1.time_ and arg_56_1.time_ <= var_59_29 + arg_59_0 then
				arg_56_1.var_.moveOldPos1011ui_story = var_59_28.localPosition
			end

			local var_59_30 = 0.001

			if var_59_29 <= arg_56_1.time_ and arg_56_1.time_ < var_59_29 + var_59_30 then
				local var_59_31 = (arg_56_1.time_ - var_59_29) / var_59_30
				local var_59_32 = Vector3.New(0, -0.71, -6)

				var_59_28.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos1011ui_story, var_59_32, var_59_31)

				local var_59_33 = manager.ui.mainCamera.transform.position - var_59_28.position

				var_59_28.forward = Vector3.New(var_59_33.x, var_59_33.y, var_59_33.z)

				local var_59_34 = var_59_28.localEulerAngles

				var_59_34.z = 0
				var_59_34.x = 0
				var_59_28.localEulerAngles = var_59_34
			end

			if arg_56_1.time_ >= var_59_29 + var_59_30 and arg_56_1.time_ < var_59_29 + var_59_30 + arg_59_0 then
				var_59_28.localPosition = Vector3.New(0, -0.71, -6)

				local var_59_35 = manager.ui.mainCamera.transform.position - var_59_28.position

				var_59_28.forward = Vector3.New(var_59_35.x, var_59_35.y, var_59_35.z)

				local var_59_36 = var_59_28.localEulerAngles

				var_59_36.z = 0
				var_59_36.x = 0
				var_59_28.localEulerAngles = var_59_36
			end

			local var_59_37 = 0

			if var_59_37 < arg_56_1.time_ and arg_56_1.time_ <= var_59_37 + arg_59_0 then
				arg_56_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action3_1")
			end

			local var_59_38 = 0

			if var_59_38 < arg_56_1.time_ and arg_56_1.time_ <= var_59_38 + arg_59_0 then
				arg_56_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_59_39 = 0
			local var_59_40 = 0.425

			if var_59_39 < arg_56_1.time_ and arg_56_1.time_ <= var_59_39 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				local var_59_41 = arg_56_1:FormatText(StoryNameCfg[37].name)

				arg_56_1.leftNameTxt_.text = var_59_41

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_42 = arg_56_1:GetWordFromCfg(103041014)
				local var_59_43 = arg_56_1:FormatText(var_59_42.content)

				arg_56_1.text_.text = var_59_43

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_44 = 17
				local var_59_45 = utf8.len(var_59_43)
				local var_59_46 = var_59_44 <= 0 and var_59_40 or var_59_40 * (var_59_45 / var_59_44)

				if var_59_46 > 0 and var_59_40 < var_59_46 then
					arg_56_1.talkMaxDuration = var_59_46

					if var_59_46 + var_59_39 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_46 + var_59_39
					end
				end

				arg_56_1.text_.text = var_59_43
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103041", "103041014", "story_v_out_103041.awb") ~= 0 then
					local var_59_47 = manager.audio:GetVoiceLength("story_v_out_103041", "103041014", "story_v_out_103041.awb") / 1000

					if var_59_47 + var_59_39 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_47 + var_59_39
					end

					if var_59_42.prefab_name ~= "" and arg_56_1.actors_[var_59_42.prefab_name] ~= nil then
						local var_59_48 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_42.prefab_name].transform, "story_v_out_103041", "103041014", "story_v_out_103041.awb")

						arg_56_1:RecordAudio("103041014", var_59_48)
						arg_56_1:RecordAudio("103041014", var_59_48)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_103041", "103041014", "story_v_out_103041.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_103041", "103041014", "story_v_out_103041.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_49 = math.max(var_59_40, arg_56_1.talkMaxDuration)

			if var_59_39 <= arg_56_1.time_ and arg_56_1.time_ < var_59_39 + var_59_49 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_39) / var_59_49

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_39 + var_59_49 and arg_56_1.time_ < var_59_39 + var_59_49 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_56_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/B08b"
	},
	voices = {
		"story_v_out_103041.awb"
	}
}
