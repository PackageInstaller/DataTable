return {
	Play109031001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 109031001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play109031002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "ST06a"

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
				local var_4_5 = arg_1_1.bgs_.ST06a

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
					if iter_4_0 ~= "ST06a" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = arg_1_1.bgs_.ST06a
			local var_4_17 = 0

			if var_4_17 < arg_1_1.time_ and arg_1_1.time_ <= var_4_17 + arg_4_0 then
				local var_4_18 = var_4_16:GetComponent("SpriteRenderer")

				if var_4_18 then
					arg_1_1.var_.alphaOldValueST06a = var_4_18.color.a
					arg_1_1.var_.alphaMatValueST06a = var_4_18
				end

				arg_1_1.var_.alphaOldValueST06a = 0
			end

			local var_4_19 = 1.5

			if var_4_17 <= arg_1_1.time_ and arg_1_1.time_ < var_4_17 + var_4_19 then
				local var_4_20 = (arg_1_1.time_ - var_4_17) / var_4_19
				local var_4_21 = Mathf.Lerp(arg_1_1.var_.alphaOldValueST06a, 1, var_4_20)

				if arg_1_1.var_.alphaMatValueST06a then
					local var_4_22 = arg_1_1.var_.alphaMatValueST06a.color

					var_4_22.a = var_4_21
					arg_1_1.var_.alphaMatValueST06a.color = var_4_22
				end
			end

			if arg_1_1.time_ >= var_4_17 + var_4_19 and arg_1_1.time_ < var_4_17 + var_4_19 + arg_4_0 and arg_1_1.var_.alphaMatValueST06a then
				local var_4_23 = arg_1_1.var_.alphaMatValueST06a
				local var_4_24 = var_4_23.color

				var_4_24.a = 1
				var_4_23.color = var_4_24
			end

			local var_4_25 = 0
			local var_4_26 = 1

			if var_4_25 < arg_1_1.time_ and arg_1_1.time_ <= var_4_25 + arg_4_0 then
				local var_4_27 = "play"
				local var_4_28 = "music"

				arg_1_1:AudioAction(var_4_27, var_4_28, "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1.awb")

				local var_4_29 = ""
				local var_4_30 = manager.audio:GetAudioName("bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1")

				if var_4_30 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_30 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_30

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_30
						arg_1_1.bgmTxt2_.text = var_4_30
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

			local var_4_31 = 0

			if var_4_31 < arg_1_1.time_ and arg_1_1.time_ <= var_4_31 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_32 = 2

			if arg_1_1.time_ >= var_4_31 + var_4_32 and arg_1_1.time_ < var_4_31 + var_4_32 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_33 = 2
			local var_4_34 = 0.15

			if var_4_33 < arg_1_1.time_ and arg_1_1.time_ <= var_4_33 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_35 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_35:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_35:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_35:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_36 = arg_1_1:GetWordFromCfg(109031001)
				local var_4_37 = arg_1_1:FormatText(var_4_36.content)

				arg_1_1.text_.text = var_4_37

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_38 = 6
				local var_4_39 = utf8.len(var_4_37)
				local var_4_40 = var_4_38 <= 0 and var_4_34 or var_4_34 * (var_4_39 / var_4_38)

				if var_4_40 > 0 and var_4_34 < var_4_40 then
					arg_1_1.talkMaxDuration = var_4_40
					var_4_33 = var_4_33 + 0.3

					if var_4_40 + var_4_33 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_40 + var_4_33
					end
				end

				arg_1_1.text_.text = var_4_37
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_41 = var_4_33 + 0.3
			local var_4_42 = math.max(var_4_34, arg_1_1.talkMaxDuration)

			if var_4_41 <= arg_1_1.time_ and arg_1_1.time_ < var_4_41 + var_4_42 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_41) / var_4_42

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_41 + var_4_42 and arg_1_1.time_ < var_4_41 + var_4_42 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play109031002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 109031002
		arg_8_1.duration_ = 3.43

		local var_8_0 = {
			ja = 2.666,
			ko = 2.433,
			zh = 3.433,
			en = 3.133
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
				arg_8_0:Play109031003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = "2032_tpose"

			if arg_8_1.actors_[var_11_0] == nil then
				local var_11_1 = Asset.Load("Char/" .. "2032_tpose")

				if not isNil(var_11_1) then
					local var_11_2 = Object.Instantiate(Asset.Load("Char/" .. "2032_tpose"), arg_8_1.stage_.transform)

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

			local var_11_5 = arg_8_1.actors_["2032_tpose"]
			local var_11_6 = 0

			if var_11_6 < arg_8_1.time_ and arg_8_1.time_ <= var_11_6 + arg_11_0 and not isNil(var_11_5) and arg_8_1.var_.characterEffect2032_tpose == nil then
				arg_8_1.var_.characterEffect2032_tpose = var_11_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_7 = 0.2

			if var_11_6 <= arg_8_1.time_ and arg_8_1.time_ < var_11_6 + var_11_7 and not isNil(var_11_5) then
				local var_11_8 = (arg_8_1.time_ - var_11_6) / var_11_7

				if arg_8_1.var_.characterEffect2032_tpose and not isNil(var_11_5) then
					arg_8_1.var_.characterEffect2032_tpose.fillFlat = false
				end
			end

			if arg_8_1.time_ >= var_11_6 + var_11_7 and arg_8_1.time_ < var_11_6 + var_11_7 + arg_11_0 and not isNil(var_11_5) and arg_8_1.var_.characterEffect2032_tpose then
				arg_8_1.var_.characterEffect2032_tpose.fillFlat = false
			end

			local var_11_9 = arg_8_1.actors_["2032_tpose"].transform
			local var_11_10 = 0

			if var_11_10 < arg_8_1.time_ and arg_8_1.time_ <= var_11_10 + arg_11_0 then
				arg_8_1.var_.moveOldPos2032_tpose = var_11_9.localPosition

				local var_11_11 = GameObjectTools.GetOrAddComponent(var_11_9.gameObject, typeof(DynamicBoneHelper))

				if var_11_11 then
					var_11_11:EnableDynamicBone(false)
				end
			end

			local var_11_12 = 0.001

			if var_11_10 <= arg_8_1.time_ and arg_8_1.time_ < var_11_10 + var_11_12 then
				local var_11_13 = (arg_8_1.time_ - var_11_10) / var_11_12
				local var_11_14 = Vector3.New(-0.7, -1.15, -4.2)

				var_11_9.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos2032_tpose, var_11_14, var_11_13)

				local var_11_15 = manager.ui.mainCamera.transform.position - var_11_9.position

				var_11_9.forward = Vector3.New(var_11_15.x, var_11_15.y, var_11_15.z)

				local var_11_16 = var_11_9.localEulerAngles

				var_11_16.z = 0
				var_11_16.x = 0
				var_11_9.localEulerAngles = var_11_16
			end

			if arg_8_1.time_ >= var_11_10 + var_11_12 and arg_8_1.time_ < var_11_10 + var_11_12 + arg_11_0 then
				var_11_9.localPosition = Vector3.New(-0.7, -1.15, -4.2)

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
				arg_8_1:PlayTimeline("2032_tpose", "StoryTimeline/CharAction/story2032/story2032action/2032action1_1")
			end

			local var_11_21 = 0
			local var_11_22 = 0.15

			if var_11_21 < arg_8_1.time_ and arg_8_1.time_ <= var_11_21 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				local var_11_23 = arg_8_1:FormatText(StoryNameCfg[157].name)

				arg_8_1.leftNameTxt_.text = var_11_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, true)
				arg_8_1.iconController_:SetSelectedState("hero")

				arg_8_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2032")

				arg_8_1.callingController_:SetSelectedState("normal")

				arg_8_1.keyicon_.color = Color.New(1, 1, 1)
				arg_8_1.icon_.color = Color.New(1, 1, 1)

				local var_11_24 = arg_8_1:GetWordFromCfg(109031002)
				local var_11_25 = arg_8_1:FormatText(var_11_24.content)

				arg_8_1.text_.text = var_11_25

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_26 = 6
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

				if manager.audio:GetVoiceLength("story_v_out_109031", "109031002", "story_v_out_109031.awb") ~= 0 then
					local var_11_29 = manager.audio:GetVoiceLength("story_v_out_109031", "109031002", "story_v_out_109031.awb") / 1000

					if var_11_29 + var_11_21 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_29 + var_11_21
					end

					if var_11_24.prefab_name ~= "" and arg_8_1.actors_[var_11_24.prefab_name] ~= nil then
						local var_11_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_24.prefab_name].transform, "story_v_out_109031", "109031002", "story_v_out_109031.awb")

						arg_8_1:RecordAudio("109031002", var_11_30)
						arg_8_1:RecordAudio("109031002", var_11_30)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_109031", "109031002", "story_v_out_109031.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_109031", "109031002", "story_v_out_109031.awb")
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
				actorName = "2032_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_8_1:InitPlayNodeList()
	end,
	Play109031003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 109031003
		arg_12_1.duration_ = 2.2

		local var_12_0 = {
			ja = 2.2,
			ko = 1.999999999999,
			zh = 1.999999999999,
			en = 1.999999999999
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
				arg_12_0:Play109031004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = "3004_tpose"

			if arg_12_1.actors_[var_15_0] == nil then
				local var_15_1 = Asset.Load("Char/" .. "3004_tpose")

				if not isNil(var_15_1) then
					local var_15_2 = Object.Instantiate(Asset.Load("Char/" .. "3004_tpose"), arg_12_1.stage_.transform)

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

			local var_15_5 = arg_12_1.actors_["3004_tpose"].transform
			local var_15_6 = 0

			if var_15_6 < arg_12_1.time_ and arg_12_1.time_ <= var_15_6 + arg_15_0 then
				arg_12_1.var_.moveOldPos3004_tpose = var_15_5.localPosition

				local var_15_7 = GameObjectTools.GetOrAddComponent(var_15_5.gameObject, typeof(DynamicBoneHelper))

				if var_15_7 then
					var_15_7:EnableDynamicBone(false)
				end
			end

			local var_15_8 = 0.001

			if var_15_6 <= arg_12_1.time_ and arg_12_1.time_ < var_15_6 + var_15_8 then
				local var_15_9 = (arg_12_1.time_ - var_15_6) / var_15_8
				local var_15_10 = Vector3.New(0.7, -2.22, -3.1)

				var_15_5.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos3004_tpose, var_15_10, var_15_9)

				local var_15_11 = manager.ui.mainCamera.transform.position - var_15_5.position

				var_15_5.forward = Vector3.New(var_15_11.x, var_15_11.y, var_15_11.z)

				local var_15_12 = var_15_5.localEulerAngles

				var_15_12.z = 0
				var_15_12.x = 0
				var_15_5.localEulerAngles = var_15_12
			end

			if arg_12_1.time_ >= var_15_6 + var_15_8 and arg_12_1.time_ < var_15_6 + var_15_8 + arg_15_0 then
				var_15_5.localPosition = Vector3.New(0.7, -2.22, -3.1)

				local var_15_13 = manager.ui.mainCamera.transform.position - var_15_5.position

				var_15_5.forward = Vector3.New(var_15_13.x, var_15_13.y, var_15_13.z)

				local var_15_14 = var_15_5.localEulerAngles

				var_15_14.z = 0
				var_15_14.x = 0
				var_15_5.localEulerAngles = var_15_14

				local var_15_15 = GameObjectTools.GetOrAddComponent(var_15_5.gameObject, typeof(DynamicBoneHelper))

				if var_15_15 then
					var_15_15:EnableDynamicBone(true)
				end
			end

			local var_15_16 = arg_12_1.actors_["3004_tpose"]
			local var_15_17 = 0

			if var_15_17 < arg_12_1.time_ and arg_12_1.time_ <= var_15_17 + arg_15_0 and not isNil(var_15_16) and arg_12_1.var_.characterEffect3004_tpose == nil then
				arg_12_1.var_.characterEffect3004_tpose = var_15_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_18 = 0.2

			if var_15_17 <= arg_12_1.time_ and arg_12_1.time_ < var_15_17 + var_15_18 and not isNil(var_15_16) then
				local var_15_19 = (arg_12_1.time_ - var_15_17) / var_15_18

				if arg_12_1.var_.characterEffect3004_tpose and not isNil(var_15_16) then
					arg_12_1.var_.characterEffect3004_tpose.fillFlat = false
				end
			end

			if arg_12_1.time_ >= var_15_17 + var_15_18 and arg_12_1.time_ < var_15_17 + var_15_18 + arg_15_0 and not isNil(var_15_16) and arg_12_1.var_.characterEffect3004_tpose then
				arg_12_1.var_.characterEffect3004_tpose.fillFlat = false
			end

			local var_15_20 = 0

			if var_15_20 < arg_12_1.time_ and arg_12_1.time_ <= var_15_20 + arg_15_0 then
				arg_12_1:PlayTimeline("3004_tpose", "StoryTimeline/CharAction/story3004/story3004action/3004action1_1")
			end

			local var_15_21 = arg_12_1.actors_["2032_tpose"]
			local var_15_22 = 0

			if var_15_22 < arg_12_1.time_ and arg_12_1.time_ <= var_15_22 + arg_15_0 and not isNil(var_15_21) and arg_12_1.var_.characterEffect2032_tpose == nil then
				arg_12_1.var_.characterEffect2032_tpose = var_15_21:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_23 = 0.2

			if var_15_22 <= arg_12_1.time_ and arg_12_1.time_ < var_15_22 + var_15_23 and not isNil(var_15_21) then
				local var_15_24 = (arg_12_1.time_ - var_15_22) / var_15_23

				if arg_12_1.var_.characterEffect2032_tpose and not isNil(var_15_21) then
					local var_15_25 = Mathf.Lerp(0, 0.5, var_15_24)

					arg_12_1.var_.characterEffect2032_tpose.fillFlat = true
					arg_12_1.var_.characterEffect2032_tpose.fillRatio = var_15_25
				end
			end

			if arg_12_1.time_ >= var_15_22 + var_15_23 and arg_12_1.time_ < var_15_22 + var_15_23 + arg_15_0 and not isNil(var_15_21) and arg_12_1.var_.characterEffect2032_tpose then
				local var_15_26 = 0.5

				arg_12_1.var_.characterEffect2032_tpose.fillFlat = true
				arg_12_1.var_.characterEffect2032_tpose.fillRatio = var_15_26
			end

			local var_15_27 = 0
			local var_15_28 = 0.1

			if var_15_27 < arg_12_1.time_ and arg_12_1.time_ <= var_15_27 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				local var_15_29 = arg_12_1:FormatText(StoryNameCfg[82].name)

				arg_12_1.leftNameTxt_.text = var_15_29

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_30 = arg_12_1:GetWordFromCfg(109031003)
				local var_15_31 = arg_12_1:FormatText(var_15_30.content)

				arg_12_1.text_.text = var_15_31

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_32 = 4
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

				if manager.audio:GetVoiceLength("story_v_out_109031", "109031003", "story_v_out_109031.awb") ~= 0 then
					local var_15_35 = manager.audio:GetVoiceLength("story_v_out_109031", "109031003", "story_v_out_109031.awb") / 1000

					if var_15_35 + var_15_27 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_35 + var_15_27
					end

					if var_15_30.prefab_name ~= "" and arg_12_1.actors_[var_15_30.prefab_name] ~= nil then
						local var_15_36 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_30.prefab_name].transform, "story_v_out_109031", "109031003", "story_v_out_109031.awb")

						arg_12_1:RecordAudio("109031003", var_15_36)
						arg_12_1:RecordAudio("109031003", var_15_36)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_109031", "109031003", "story_v_out_109031.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_109031", "109031003", "story_v_out_109031.awb")
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
				actorName = "3004_tpose",
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
	Play109031004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 109031004
		arg_16_1.duration_ = 5

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play109031005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = arg_16_1.actors_["3004_tpose"]
			local var_19_1 = 0

			if var_19_1 < arg_16_1.time_ and arg_16_1.time_ <= var_19_1 + arg_19_0 and not isNil(var_19_0) and arg_16_1.var_.characterEffect3004_tpose == nil then
				arg_16_1.var_.characterEffect3004_tpose = var_19_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_2 = 0.2

			if var_19_1 <= arg_16_1.time_ and arg_16_1.time_ < var_19_1 + var_19_2 and not isNil(var_19_0) then
				local var_19_3 = (arg_16_1.time_ - var_19_1) / var_19_2

				if arg_16_1.var_.characterEffect3004_tpose and not isNil(var_19_0) then
					local var_19_4 = Mathf.Lerp(0, 0.5, var_19_3)

					arg_16_1.var_.characterEffect3004_tpose.fillFlat = true
					arg_16_1.var_.characterEffect3004_tpose.fillRatio = var_19_4
				end
			end

			if arg_16_1.time_ >= var_19_1 + var_19_2 and arg_16_1.time_ < var_19_1 + var_19_2 + arg_19_0 and not isNil(var_19_0) and arg_16_1.var_.characterEffect3004_tpose then
				local var_19_5 = 0.5

				arg_16_1.var_.characterEffect3004_tpose.fillFlat = true
				arg_16_1.var_.characterEffect3004_tpose.fillRatio = var_19_5
			end

			local var_19_6 = arg_16_1.actors_["2032_tpose"]
			local var_19_7 = 0

			if var_19_7 < arg_16_1.time_ and arg_16_1.time_ <= var_19_7 + arg_19_0 and not isNil(var_19_6) and arg_16_1.var_.characterEffect2032_tpose == nil then
				arg_16_1.var_.characterEffect2032_tpose = var_19_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_8 = 0.2

			if var_19_7 <= arg_16_1.time_ and arg_16_1.time_ < var_19_7 + var_19_8 and not isNil(var_19_6) then
				local var_19_9 = (arg_16_1.time_ - var_19_7) / var_19_8

				if arg_16_1.var_.characterEffect2032_tpose and not isNil(var_19_6) then
					local var_19_10 = Mathf.Lerp(0, 0.5, var_19_9)

					arg_16_1.var_.characterEffect2032_tpose.fillFlat = true
					arg_16_1.var_.characterEffect2032_tpose.fillRatio = var_19_10
				end
			end

			if arg_16_1.time_ >= var_19_7 + var_19_8 and arg_16_1.time_ < var_19_7 + var_19_8 + arg_19_0 and not isNil(var_19_6) and arg_16_1.var_.characterEffect2032_tpose then
				local var_19_11 = 0.5

				arg_16_1.var_.characterEffect2032_tpose.fillFlat = true
				arg_16_1.var_.characterEffect2032_tpose.fillRatio = var_19_11
			end

			local var_19_12 = arg_16_1.actors_["2032_tpose"].transform
			local var_19_13 = 0

			if var_19_13 < arg_16_1.time_ and arg_16_1.time_ <= var_19_13 + arg_19_0 then
				arg_16_1.var_.moveOldPos2032_tpose = var_19_12.localPosition

				local var_19_14 = GameObjectTools.GetOrAddComponent(var_19_12.gameObject, typeof(DynamicBoneHelper))

				if var_19_14 then
					var_19_14:EnableDynamicBone(false)
				end
			end

			local var_19_15 = 0.1

			if var_19_13 <= arg_16_1.time_ and arg_16_1.time_ < var_19_13 + var_19_15 then
				local var_19_16 = (arg_16_1.time_ - var_19_13) / var_19_15
				local var_19_17 = Vector3.New(0, 100, 0)

				var_19_12.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos2032_tpose, var_19_17, var_19_16)

				local var_19_18 = manager.ui.mainCamera.transform.position - var_19_12.position

				var_19_12.forward = Vector3.New(var_19_18.x, var_19_18.y, var_19_18.z)

				local var_19_19 = var_19_12.localEulerAngles

				var_19_19.z = 0
				var_19_19.x = 0
				var_19_12.localEulerAngles = var_19_19
			end

			if arg_16_1.time_ >= var_19_13 + var_19_15 and arg_16_1.time_ < var_19_13 + var_19_15 + arg_19_0 then
				var_19_12.localPosition = Vector3.New(0, 100, 0)

				local var_19_20 = manager.ui.mainCamera.transform.position - var_19_12.position

				var_19_12.forward = Vector3.New(var_19_20.x, var_19_20.y, var_19_20.z)

				local var_19_21 = var_19_12.localEulerAngles

				var_19_21.z = 0
				var_19_21.x = 0
				var_19_12.localEulerAngles = var_19_21

				local var_19_22 = GameObjectTools.GetOrAddComponent(var_19_12.gameObject, typeof(DynamicBoneHelper))

				if var_19_22 then
					var_19_22:EnableDynamicBone(true)
				end
			end

			local var_19_23 = arg_16_1.actors_["3004_tpose"].transform
			local var_19_24 = 0

			if var_19_24 < arg_16_1.time_ and arg_16_1.time_ <= var_19_24 + arg_19_0 then
				arg_16_1.var_.moveOldPos3004_tpose = var_19_23.localPosition

				local var_19_25 = GameObjectTools.GetOrAddComponent(var_19_23.gameObject, typeof(DynamicBoneHelper))

				if var_19_25 then
					var_19_25:EnableDynamicBone(false)
				end
			end

			local var_19_26 = 0.1

			if var_19_24 <= arg_16_1.time_ and arg_16_1.time_ < var_19_24 + var_19_26 then
				local var_19_27 = (arg_16_1.time_ - var_19_24) / var_19_26
				local var_19_28 = Vector3.New(0, 100, 0)

				var_19_23.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos3004_tpose, var_19_28, var_19_27)

				local var_19_29 = manager.ui.mainCamera.transform.position - var_19_23.position

				var_19_23.forward = Vector3.New(var_19_29.x, var_19_29.y, var_19_29.z)

				local var_19_30 = var_19_23.localEulerAngles

				var_19_30.z = 0
				var_19_30.x = 0
				var_19_23.localEulerAngles = var_19_30
			end

			if arg_16_1.time_ >= var_19_24 + var_19_26 and arg_16_1.time_ < var_19_24 + var_19_26 + arg_19_0 then
				var_19_23.localPosition = Vector3.New(0, 100, 0)

				local var_19_31 = manager.ui.mainCamera.transform.position - var_19_23.position

				var_19_23.forward = Vector3.New(var_19_31.x, var_19_31.y, var_19_31.z)

				local var_19_32 = var_19_23.localEulerAngles

				var_19_32.z = 0
				var_19_32.x = 0
				var_19_23.localEulerAngles = var_19_32

				local var_19_33 = GameObjectTools.GetOrAddComponent(var_19_23.gameObject, typeof(DynamicBoneHelper))

				if var_19_33 then
					var_19_33:EnableDynamicBone(true)
				end
			end

			local var_19_34 = 0
			local var_19_35 = 1.25

			if var_19_34 < arg_16_1.time_ and arg_16_1.time_ <= var_19_34 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, false)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_36 = arg_16_1:GetWordFromCfg(109031004)
				local var_19_37 = arg_16_1:FormatText(var_19_36.content)

				arg_16_1.text_.text = var_19_37

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_38 = 50
				local var_19_39 = utf8.len(var_19_37)
				local var_19_40 = var_19_38 <= 0 and var_19_35 or var_19_35 * (var_19_39 / var_19_38)

				if var_19_40 > 0 and var_19_35 < var_19_40 then
					arg_16_1.talkMaxDuration = var_19_40

					if var_19_40 + var_19_34 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_40 + var_19_34
					end
				end

				arg_16_1.text_.text = var_19_37
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)
				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_41 = math.max(var_19_35, arg_16_1.talkMaxDuration)

			if var_19_34 <= arg_16_1.time_ and arg_16_1.time_ < var_19_34 + var_19_41 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_34) / var_19_41

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_34 + var_19_41 and arg_16_1.time_ < var_19_34 + var_19_41 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2032_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.1,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "3004_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.1,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_16_1:InitPlayNodeList()
	end,
	Play109031005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 109031005
		arg_20_1.duration_ = 8

		local var_20_0 = {
			ja = 8,
			ko = 4.5,
			zh = 4.5,
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
				arg_20_0:Play109031006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = arg_20_1.actors_["3004_tpose"]
			local var_23_1 = 0

			if var_23_1 < arg_20_1.time_ and arg_20_1.time_ <= var_23_1 + arg_23_0 and not isNil(var_23_0) and arg_20_1.var_.characterEffect3004_tpose == nil then
				arg_20_1.var_.characterEffect3004_tpose = var_23_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_2 = 0.2

			if var_23_1 <= arg_20_1.time_ and arg_20_1.time_ < var_23_1 + var_23_2 and not isNil(var_23_0) then
				local var_23_3 = (arg_20_1.time_ - var_23_1) / var_23_2

				if arg_20_1.var_.characterEffect3004_tpose and not isNil(var_23_0) then
					arg_20_1.var_.characterEffect3004_tpose.fillFlat = false
				end
			end

			if arg_20_1.time_ >= var_23_1 + var_23_2 and arg_20_1.time_ < var_23_1 + var_23_2 + arg_23_0 and not isNil(var_23_0) and arg_20_1.var_.characterEffect3004_tpose then
				arg_20_1.var_.characterEffect3004_tpose.fillFlat = false
			end

			local var_23_4 = 0
			local var_23_5 = 0.45

			if var_23_4 < arg_20_1.time_ and arg_20_1.time_ <= var_23_4 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				local var_23_6 = arg_20_1:FormatText(StoryNameCfg[82].name)

				arg_20_1.leftNameTxt_.text = var_23_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, true)
				arg_20_1.iconController_:SetSelectedState("hero")

				arg_20_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3004")

				arg_20_1.callingController_:SetSelectedState("normal")

				arg_20_1.keyicon_.color = Color.New(1, 1, 1)
				arg_20_1.icon_.color = Color.New(1, 1, 1)

				local var_23_7 = arg_20_1:GetWordFromCfg(109031005)
				local var_23_8 = arg_20_1:FormatText(var_23_7.content)

				arg_20_1.text_.text = var_23_8

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_9 = 18
				local var_23_10 = utf8.len(var_23_8)
				local var_23_11 = var_23_9 <= 0 and var_23_5 or var_23_5 * (var_23_10 / var_23_9)

				if var_23_11 > 0 and var_23_5 < var_23_11 then
					arg_20_1.talkMaxDuration = var_23_11

					if var_23_11 + var_23_4 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_11 + var_23_4
					end
				end

				arg_20_1.text_.text = var_23_8
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109031", "109031005", "story_v_out_109031.awb") ~= 0 then
					local var_23_12 = manager.audio:GetVoiceLength("story_v_out_109031", "109031005", "story_v_out_109031.awb") / 1000

					if var_23_12 + var_23_4 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_12 + var_23_4
					end

					if var_23_7.prefab_name ~= "" and arg_20_1.actors_[var_23_7.prefab_name] ~= nil then
						local var_23_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_7.prefab_name].transform, "story_v_out_109031", "109031005", "story_v_out_109031.awb")

						arg_20_1:RecordAudio("109031005", var_23_13)
						arg_20_1:RecordAudio("109031005", var_23_13)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_109031", "109031005", "story_v_out_109031.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_109031", "109031005", "story_v_out_109031.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_14 = math.max(var_23_5, arg_20_1.talkMaxDuration)

			if var_23_4 <= arg_20_1.time_ and arg_20_1.time_ < var_23_4 + var_23_14 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_4) / var_23_14

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_4 + var_23_14 and arg_20_1.time_ < var_23_4 + var_23_14 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play109031006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 109031006
		arg_24_1.duration_ = 5

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play109031007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = arg_24_1.actors_["3004_tpose"]
			local var_27_1 = 0

			if var_27_1 < arg_24_1.time_ and arg_24_1.time_ <= var_27_1 + arg_27_0 and not isNil(var_27_0) and arg_24_1.var_.characterEffect3004_tpose == nil then
				arg_24_1.var_.characterEffect3004_tpose = var_27_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_2 = 0.2

			if var_27_1 <= arg_24_1.time_ and arg_24_1.time_ < var_27_1 + var_27_2 and not isNil(var_27_0) then
				local var_27_3 = (arg_24_1.time_ - var_27_1) / var_27_2

				if arg_24_1.var_.characterEffect3004_tpose and not isNil(var_27_0) then
					local var_27_4 = Mathf.Lerp(0, 0.5, var_27_3)

					arg_24_1.var_.characterEffect3004_tpose.fillFlat = true
					arg_24_1.var_.characterEffect3004_tpose.fillRatio = var_27_4
				end
			end

			if arg_24_1.time_ >= var_27_1 + var_27_2 and arg_24_1.time_ < var_27_1 + var_27_2 + arg_27_0 and not isNil(var_27_0) and arg_24_1.var_.characterEffect3004_tpose then
				local var_27_5 = 0.5

				arg_24_1.var_.characterEffect3004_tpose.fillFlat = true
				arg_24_1.var_.characterEffect3004_tpose.fillRatio = var_27_5
			end

			local var_27_6 = 0
			local var_27_7 = 0.625

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

				local var_27_8 = arg_24_1:GetWordFromCfg(109031006)
				local var_27_9 = arg_24_1:FormatText(var_27_8.content)

				arg_24_1.text_.text = var_27_9

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_10 = 25
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
	Play109031007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 109031007
		arg_28_1.duration_ = 2.5

		local var_28_0 = {
			ja = 2.5,
			ko = 1.966,
			zh = 2.066,
			en = 2.133
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
				arg_28_0:Play109031008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = arg_28_1.actors_["3004_tpose"]
			local var_31_1 = 0

			if var_31_1 < arg_28_1.time_ and arg_28_1.time_ <= var_31_1 + arg_31_0 and not isNil(var_31_0) and arg_28_1.var_.characterEffect3004_tpose == nil then
				arg_28_1.var_.characterEffect3004_tpose = var_31_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_2 = 0.2

			if var_31_1 <= arg_28_1.time_ and arg_28_1.time_ < var_31_1 + var_31_2 and not isNil(var_31_0) then
				local var_31_3 = (arg_28_1.time_ - var_31_1) / var_31_2

				if arg_28_1.var_.characterEffect3004_tpose and not isNil(var_31_0) then
					arg_28_1.var_.characterEffect3004_tpose.fillFlat = false
				end
			end

			if arg_28_1.time_ >= var_31_1 + var_31_2 and arg_28_1.time_ < var_31_1 + var_31_2 + arg_31_0 and not isNil(var_31_0) and arg_28_1.var_.characterEffect3004_tpose then
				arg_28_1.var_.characterEffect3004_tpose.fillFlat = false
			end

			local var_31_4 = arg_28_1.actors_["3004_tpose"].transform
			local var_31_5 = 0

			if var_31_5 < arg_28_1.time_ and arg_28_1.time_ <= var_31_5 + arg_31_0 then
				arg_28_1.var_.moveOldPos3004_tpose = var_31_4.localPosition

				local var_31_6 = GameObjectTools.GetOrAddComponent(var_31_4.gameObject, typeof(DynamicBoneHelper))

				if var_31_6 then
					var_31_6:EnableDynamicBone(false)
				end
			end

			local var_31_7 = 0.001

			if var_31_5 <= arg_28_1.time_ and arg_28_1.time_ < var_31_5 + var_31_7 then
				local var_31_8 = (arg_28_1.time_ - var_31_5) / var_31_7
				local var_31_9 = Vector3.New(0, -2.22, -3.1)

				var_31_4.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos3004_tpose, var_31_9, var_31_8)

				local var_31_10 = manager.ui.mainCamera.transform.position - var_31_4.position

				var_31_4.forward = Vector3.New(var_31_10.x, var_31_10.y, var_31_10.z)

				local var_31_11 = var_31_4.localEulerAngles

				var_31_11.z = 0
				var_31_11.x = 0
				var_31_4.localEulerAngles = var_31_11
			end

			if arg_28_1.time_ >= var_31_5 + var_31_7 and arg_28_1.time_ < var_31_5 + var_31_7 + arg_31_0 then
				var_31_4.localPosition = Vector3.New(0, -2.22, -3.1)

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
			local var_31_16 = 0.175

			if var_31_15 < arg_28_1.time_ and arg_28_1.time_ <= var_31_15 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				local var_31_17 = arg_28_1:FormatText(StoryNameCfg[82].name)

				arg_28_1.leftNameTxt_.text = var_31_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_18 = arg_28_1:GetWordFromCfg(109031007)
				local var_31_19 = arg_28_1:FormatText(var_31_18.content)

				arg_28_1.text_.text = var_31_19

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_20 = 7
				local var_31_21 = utf8.len(var_31_19)
				local var_31_22 = var_31_20 <= 0 and var_31_16 or var_31_16 * (var_31_21 / var_31_20)

				if var_31_22 > 0 and var_31_16 < var_31_22 then
					arg_28_1.talkMaxDuration = var_31_22

					if var_31_22 + var_31_15 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_22 + var_31_15
					end
				end

				arg_28_1.text_.text = var_31_19
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109031", "109031007", "story_v_out_109031.awb") ~= 0 then
					local var_31_23 = manager.audio:GetVoiceLength("story_v_out_109031", "109031007", "story_v_out_109031.awb") / 1000

					if var_31_23 + var_31_15 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_23 + var_31_15
					end

					if var_31_18.prefab_name ~= "" and arg_28_1.actors_[var_31_18.prefab_name] ~= nil then
						local var_31_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_18.prefab_name].transform, "story_v_out_109031", "109031007", "story_v_out_109031.awb")

						arg_28_1:RecordAudio("109031007", var_31_24)
						arg_28_1:RecordAudio("109031007", var_31_24)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_109031", "109031007", "story_v_out_109031.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_109031", "109031007", "story_v_out_109031.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_25 = math.max(var_31_16, arg_28_1.talkMaxDuration)

			if var_31_15 <= arg_28_1.time_ and arg_28_1.time_ < var_31_15 + var_31_25 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_15) / var_31_25

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_15 + var_31_25 and arg_28_1.time_ < var_31_15 + var_31_25 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3004_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_28_1:InitPlayNodeList()
	end,
	Play109031008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 109031008
		arg_32_1.duration_ = 13.73

		local var_32_0 = {
			ja = 13.733,
			ko = 6.6,
			zh = 7.6,
			en = 6.966
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
				arg_32_0:Play109031009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = arg_32_1.actors_["2032_tpose"]
			local var_35_1 = 0

			if var_35_1 < arg_32_1.time_ and arg_32_1.time_ <= var_35_1 + arg_35_0 and not isNil(var_35_0) and arg_32_1.var_.characterEffect2032_tpose == nil then
				arg_32_1.var_.characterEffect2032_tpose = var_35_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_2 = 0.2

			if var_35_1 <= arg_32_1.time_ and arg_32_1.time_ < var_35_1 + var_35_2 and not isNil(var_35_0) then
				local var_35_3 = (arg_32_1.time_ - var_35_1) / var_35_2

				if arg_32_1.var_.characterEffect2032_tpose and not isNil(var_35_0) then
					arg_32_1.var_.characterEffect2032_tpose.fillFlat = false
				end
			end

			if arg_32_1.time_ >= var_35_1 + var_35_2 and arg_32_1.time_ < var_35_1 + var_35_2 + arg_35_0 and not isNil(var_35_0) and arg_32_1.var_.characterEffect2032_tpose then
				arg_32_1.var_.characterEffect2032_tpose.fillFlat = false
			end

			local var_35_4 = arg_32_1.actors_["3004_tpose"]
			local var_35_5 = 0

			if var_35_5 < arg_32_1.time_ and arg_32_1.time_ <= var_35_5 + arg_35_0 and not isNil(var_35_4) and arg_32_1.var_.characterEffect3004_tpose == nil then
				arg_32_1.var_.characterEffect3004_tpose = var_35_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_6 = 0.2

			if var_35_5 <= arg_32_1.time_ and arg_32_1.time_ < var_35_5 + var_35_6 and not isNil(var_35_4) then
				local var_35_7 = (arg_32_1.time_ - var_35_5) / var_35_6

				if arg_32_1.var_.characterEffect3004_tpose and not isNil(var_35_4) then
					local var_35_8 = Mathf.Lerp(0, 0.5, var_35_7)

					arg_32_1.var_.characterEffect3004_tpose.fillFlat = true
					arg_32_1.var_.characterEffect3004_tpose.fillRatio = var_35_8
				end
			end

			if arg_32_1.time_ >= var_35_5 + var_35_6 and arg_32_1.time_ < var_35_5 + var_35_6 + arg_35_0 and not isNil(var_35_4) and arg_32_1.var_.characterEffect3004_tpose then
				local var_35_9 = 0.5

				arg_32_1.var_.characterEffect3004_tpose.fillFlat = true
				arg_32_1.var_.characterEffect3004_tpose.fillRatio = var_35_9
			end

			local var_35_10 = 0
			local var_35_11 = 0.575

			if var_35_10 < arg_32_1.time_ and arg_32_1.time_ <= var_35_10 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				local var_35_12 = arg_32_1:FormatText(StoryNameCfg[157].name)

				arg_32_1.leftNameTxt_.text = var_35_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, true)
				arg_32_1.iconController_:SetSelectedState("hero")

				arg_32_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2032")

				arg_32_1.callingController_:SetSelectedState("normal")

				arg_32_1.keyicon_.color = Color.New(1, 1, 1)
				arg_32_1.icon_.color = Color.New(1, 1, 1)

				local var_35_13 = arg_32_1:GetWordFromCfg(109031008)
				local var_35_14 = arg_32_1:FormatText(var_35_13.content)

				arg_32_1.text_.text = var_35_14

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_15 = 23
				local var_35_16 = utf8.len(var_35_14)
				local var_35_17 = var_35_15 <= 0 and var_35_11 or var_35_11 * (var_35_16 / var_35_15)

				if var_35_17 > 0 and var_35_11 < var_35_17 then
					arg_32_1.talkMaxDuration = var_35_17

					if var_35_17 + var_35_10 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_17 + var_35_10
					end
				end

				arg_32_1.text_.text = var_35_14
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109031", "109031008", "story_v_out_109031.awb") ~= 0 then
					local var_35_18 = manager.audio:GetVoiceLength("story_v_out_109031", "109031008", "story_v_out_109031.awb") / 1000

					if var_35_18 + var_35_10 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_18 + var_35_10
					end

					if var_35_13.prefab_name ~= "" and arg_32_1.actors_[var_35_13.prefab_name] ~= nil then
						local var_35_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_13.prefab_name].transform, "story_v_out_109031", "109031008", "story_v_out_109031.awb")

						arg_32_1:RecordAudio("109031008", var_35_19)
						arg_32_1:RecordAudio("109031008", var_35_19)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_109031", "109031008", "story_v_out_109031.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_109031", "109031008", "story_v_out_109031.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_20 = math.max(var_35_11, arg_32_1.talkMaxDuration)

			if var_35_10 <= arg_32_1.time_ and arg_32_1.time_ < var_35_10 + var_35_20 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_10) / var_35_20

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_10 + var_35_20 and arg_32_1.time_ < var_35_10 + var_35_20 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play109031009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 109031009
		arg_36_1.duration_ = 5.97

		local var_36_0 = {
			ja = 5.733,
			ko = 5.8,
			zh = 5.9,
			en = 5.966
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
				arg_36_0:Play109031010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = arg_36_1.actors_["3004_tpose"]
			local var_39_1 = 0

			if var_39_1 < arg_36_1.time_ and arg_36_1.time_ <= var_39_1 + arg_39_0 and not isNil(var_39_0) and arg_36_1.var_.characterEffect3004_tpose == nil then
				arg_36_1.var_.characterEffect3004_tpose = var_39_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_2 = 0.2

			if var_39_1 <= arg_36_1.time_ and arg_36_1.time_ < var_39_1 + var_39_2 and not isNil(var_39_0) then
				local var_39_3 = (arg_36_1.time_ - var_39_1) / var_39_2

				if arg_36_1.var_.characterEffect3004_tpose and not isNil(var_39_0) then
					arg_36_1.var_.characterEffect3004_tpose.fillFlat = false
				end
			end

			if arg_36_1.time_ >= var_39_1 + var_39_2 and arg_36_1.time_ < var_39_1 + var_39_2 + arg_39_0 and not isNil(var_39_0) and arg_36_1.var_.characterEffect3004_tpose then
				arg_36_1.var_.characterEffect3004_tpose.fillFlat = false
			end

			local var_39_4 = 0
			local var_39_5 = 0.475

			if var_39_4 < arg_36_1.time_ and arg_36_1.time_ <= var_39_4 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				local var_39_6 = arg_36_1:FormatText(StoryNameCfg[82].name)

				arg_36_1.leftNameTxt_.text = var_39_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_7 = arg_36_1:GetWordFromCfg(109031009)
				local var_39_8 = arg_36_1:FormatText(var_39_7.content)

				arg_36_1.text_.text = var_39_8

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_9 = 19
				local var_39_10 = utf8.len(var_39_8)
				local var_39_11 = var_39_9 <= 0 and var_39_5 or var_39_5 * (var_39_10 / var_39_9)

				if var_39_11 > 0 and var_39_5 < var_39_11 then
					arg_36_1.talkMaxDuration = var_39_11

					if var_39_11 + var_39_4 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_11 + var_39_4
					end
				end

				arg_36_1.text_.text = var_39_8
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109031", "109031009", "story_v_out_109031.awb") ~= 0 then
					local var_39_12 = manager.audio:GetVoiceLength("story_v_out_109031", "109031009", "story_v_out_109031.awb") / 1000

					if var_39_12 + var_39_4 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_12 + var_39_4
					end

					if var_39_7.prefab_name ~= "" and arg_36_1.actors_[var_39_7.prefab_name] ~= nil then
						local var_39_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_7.prefab_name].transform, "story_v_out_109031", "109031009", "story_v_out_109031.awb")

						arg_36_1:RecordAudio("109031009", var_39_13)
						arg_36_1:RecordAudio("109031009", var_39_13)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_109031", "109031009", "story_v_out_109031.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_109031", "109031009", "story_v_out_109031.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_14 = math.max(var_39_5, arg_36_1.talkMaxDuration)

			if var_39_4 <= arg_36_1.time_ and arg_36_1.time_ < var_39_4 + var_39_14 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_4) / var_39_14

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_4 + var_39_14 and arg_36_1.time_ < var_39_4 + var_39_14 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play109031010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 109031010
		arg_40_1.duration_ = 4.17

		local var_40_0 = {
			ja = 2.9,
			ko = 3.333,
			zh = 4.166,
			en = 2.5
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
				arg_40_0:Play109031011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = arg_40_1.actors_["3004_tpose"]
			local var_43_1 = 0

			if var_43_1 < arg_40_1.time_ and arg_40_1.time_ <= var_43_1 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.characterEffect3004_tpose == nil then
				arg_40_1.var_.characterEffect3004_tpose = var_43_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_2 = 0.2

			if var_43_1 <= arg_40_1.time_ and arg_40_1.time_ < var_43_1 + var_43_2 and not isNil(var_43_0) then
				local var_43_3 = (arg_40_1.time_ - var_43_1) / var_43_2

				if arg_40_1.var_.characterEffect3004_tpose and not isNil(var_43_0) then
					local var_43_4 = Mathf.Lerp(0, 0.5, var_43_3)

					arg_40_1.var_.characterEffect3004_tpose.fillFlat = true
					arg_40_1.var_.characterEffect3004_tpose.fillRatio = var_43_4
				end
			end

			if arg_40_1.time_ >= var_43_1 + var_43_2 and arg_40_1.time_ < var_43_1 + var_43_2 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.characterEffect3004_tpose then
				local var_43_5 = 0.5

				arg_40_1.var_.characterEffect3004_tpose.fillFlat = true
				arg_40_1.var_.characterEffect3004_tpose.fillRatio = var_43_5
			end

			local var_43_6 = 0
			local var_43_7 = 0.275

			if var_43_6 < arg_40_1.time_ and arg_40_1.time_ <= var_43_6 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				local var_43_8 = arg_40_1:FormatText(StoryNameCfg[157].name)

				arg_40_1.leftNameTxt_.text = var_43_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, true)
				arg_40_1.iconController_:SetSelectedState("hero")

				arg_40_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2032")

				arg_40_1.callingController_:SetSelectedState("normal")

				arg_40_1.keyicon_.color = Color.New(1, 1, 1)
				arg_40_1.icon_.color = Color.New(1, 1, 1)

				local var_43_9 = arg_40_1:GetWordFromCfg(109031010)
				local var_43_10 = arg_40_1:FormatText(var_43_9.content)

				arg_40_1.text_.text = var_43_10

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_11 = 11
				local var_43_12 = utf8.len(var_43_10)
				local var_43_13 = var_43_11 <= 0 and var_43_7 or var_43_7 * (var_43_12 / var_43_11)

				if var_43_13 > 0 and var_43_7 < var_43_13 then
					arg_40_1.talkMaxDuration = var_43_13

					if var_43_13 + var_43_6 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_13 + var_43_6
					end
				end

				arg_40_1.text_.text = var_43_10
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109031", "109031010", "story_v_out_109031.awb") ~= 0 then
					local var_43_14 = manager.audio:GetVoiceLength("story_v_out_109031", "109031010", "story_v_out_109031.awb") / 1000

					if var_43_14 + var_43_6 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_14 + var_43_6
					end

					if var_43_9.prefab_name ~= "" and arg_40_1.actors_[var_43_9.prefab_name] ~= nil then
						local var_43_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_9.prefab_name].transform, "story_v_out_109031", "109031010", "story_v_out_109031.awb")

						arg_40_1:RecordAudio("109031010", var_43_15)
						arg_40_1:RecordAudio("109031010", var_43_15)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_109031", "109031010", "story_v_out_109031.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_109031", "109031010", "story_v_out_109031.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_16 = math.max(var_43_7, arg_40_1.talkMaxDuration)

			if var_43_6 <= arg_40_1.time_ and arg_40_1.time_ < var_43_6 + var_43_16 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_6) / var_43_16

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_6 + var_43_16 and arg_40_1.time_ < var_43_6 + var_43_16 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play109031011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 109031011
		arg_44_1.duration_ = 5

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play109031012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = arg_44_1.actors_["2032_tpose"].transform
			local var_47_1 = 0

			if var_47_1 < arg_44_1.time_ and arg_44_1.time_ <= var_47_1 + arg_47_0 then
				arg_44_1.var_.moveOldPos2032_tpose = var_47_0.localPosition

				local var_47_2 = GameObjectTools.GetOrAddComponent(var_47_0.gameObject, typeof(DynamicBoneHelper))

				if var_47_2 then
					var_47_2:EnableDynamicBone(false)
				end
			end

			local var_47_3 = 0.001

			if var_47_1 <= arg_44_1.time_ and arg_44_1.time_ < var_47_1 + var_47_3 then
				local var_47_4 = (arg_44_1.time_ - var_47_1) / var_47_3
				local var_47_5 = Vector3.New(0, 100, 0)

				var_47_0.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos2032_tpose, var_47_5, var_47_4)

				local var_47_6 = manager.ui.mainCamera.transform.position - var_47_0.position

				var_47_0.forward = Vector3.New(var_47_6.x, var_47_6.y, var_47_6.z)

				local var_47_7 = var_47_0.localEulerAngles

				var_47_7.z = 0
				var_47_7.x = 0
				var_47_0.localEulerAngles = var_47_7
			end

			if arg_44_1.time_ >= var_47_1 + var_47_3 and arg_44_1.time_ < var_47_1 + var_47_3 + arg_47_0 then
				var_47_0.localPosition = Vector3.New(0, 100, 0)

				local var_47_8 = manager.ui.mainCamera.transform.position - var_47_0.position

				var_47_0.forward = Vector3.New(var_47_8.x, var_47_8.y, var_47_8.z)

				local var_47_9 = var_47_0.localEulerAngles

				var_47_9.z = 0
				var_47_9.x = 0
				var_47_0.localEulerAngles = var_47_9

				local var_47_10 = GameObjectTools.GetOrAddComponent(var_47_0.gameObject, typeof(DynamicBoneHelper))

				if var_47_10 then
					var_47_10:EnableDynamicBone(true)
				end
			end

			local var_47_11 = arg_44_1.actors_["3004_tpose"].transform
			local var_47_12 = 0

			if var_47_12 < arg_44_1.time_ and arg_44_1.time_ <= var_47_12 + arg_47_0 then
				arg_44_1.var_.moveOldPos3004_tpose = var_47_11.localPosition

				local var_47_13 = GameObjectTools.GetOrAddComponent(var_47_11.gameObject, typeof(DynamicBoneHelper))

				if var_47_13 then
					var_47_13:EnableDynamicBone(false)
				end
			end

			local var_47_14 = 0.001

			if var_47_12 <= arg_44_1.time_ and arg_44_1.time_ < var_47_12 + var_47_14 then
				local var_47_15 = (arg_44_1.time_ - var_47_12) / var_47_14
				local var_47_16 = Vector3.New(0, 100, 0)

				var_47_11.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos3004_tpose, var_47_16, var_47_15)

				local var_47_17 = manager.ui.mainCamera.transform.position - var_47_11.position

				var_47_11.forward = Vector3.New(var_47_17.x, var_47_17.y, var_47_17.z)

				local var_47_18 = var_47_11.localEulerAngles

				var_47_18.z = 0
				var_47_18.x = 0
				var_47_11.localEulerAngles = var_47_18
			end

			if arg_44_1.time_ >= var_47_12 + var_47_14 and arg_44_1.time_ < var_47_12 + var_47_14 + arg_47_0 then
				var_47_11.localPosition = Vector3.New(0, 100, 0)

				local var_47_19 = manager.ui.mainCamera.transform.position - var_47_11.position

				var_47_11.forward = Vector3.New(var_47_19.x, var_47_19.y, var_47_19.z)

				local var_47_20 = var_47_11.localEulerAngles

				var_47_20.z = 0
				var_47_20.x = 0
				var_47_11.localEulerAngles = var_47_20

				local var_47_21 = GameObjectTools.GetOrAddComponent(var_47_11.gameObject, typeof(DynamicBoneHelper))

				if var_47_21 then
					var_47_21:EnableDynamicBone(true)
				end
			end

			local var_47_22 = 0
			local var_47_23 = 0.625

			if var_47_22 < arg_44_1.time_ and arg_44_1.time_ <= var_47_22 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, false)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_24 = arg_44_1:GetWordFromCfg(109031011)
				local var_47_25 = arg_44_1:FormatText(var_47_24.content)

				arg_44_1.text_.text = var_47_25

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_26 = 25
				local var_47_27 = utf8.len(var_47_25)
				local var_47_28 = var_47_26 <= 0 and var_47_23 or var_47_23 * (var_47_27 / var_47_26)

				if var_47_28 > 0 and var_47_23 < var_47_28 then
					arg_44_1.talkMaxDuration = var_47_28

					if var_47_28 + var_47_22 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_28 + var_47_22
					end
				end

				arg_44_1.text_.text = var_47_25
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)
				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_29 = math.max(var_47_23, arg_44_1.talkMaxDuration)

			if var_47_22 <= arg_44_1.time_ and arg_44_1.time_ < var_47_22 + var_47_29 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_22) / var_47_29

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_22 + var_47_29 and arg_44_1.time_ < var_47_22 + var_47_29 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2032_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "3004_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_44_1:InitPlayNodeList()
	end,
	Play109031012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 109031012
		arg_48_1.duration_ = 5

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play109031013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = 0

			if var_51_0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_0 + arg_51_0 then
				local var_51_1 = manager.ui.mainCamera.transform.localPosition
				local var_51_2 = Vector3.New(0, 0, 10) + Vector3.New(var_51_1.x, var_51_1.y, 0)
				local var_51_3 = arg_48_1.bgs_.ST06a

				var_51_3.transform.localPosition = var_51_2
				var_51_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_51_4 = var_51_3:GetComponent("SpriteRenderer")

				if var_51_4 and var_51_4.sprite then
					local var_51_5 = (var_51_3.transform.localPosition - var_51_1).z
					local var_51_6 = manager.ui.mainCameraCom_
					local var_51_7 = 2 * var_51_5 * Mathf.Tan(var_51_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_51_8 = var_51_7 * var_51_6.aspect
					local var_51_9 = var_51_4.sprite.bounds.size.x
					local var_51_10 = var_51_4.sprite.bounds.size.y
					local var_51_11 = var_51_8 / var_51_9
					local var_51_12 = var_51_7 / var_51_10
					local var_51_13 = var_51_12 < var_51_11 and var_51_11 or var_51_12

					var_51_3.transform.localScale = Vector3.New(var_51_13, var_51_13, 0)
				end

				for iter_51_0, iter_51_1 in pairs(arg_48_1.bgs_) do
					if iter_51_0 ~= "ST06a" then
						iter_51_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_51_14 = arg_48_1.bgs_.ST06a.transform
			local var_51_15 = 0

			if var_51_15 < arg_48_1.time_ and arg_48_1.time_ <= var_51_15 + arg_51_0 then
				arg_48_1.var_.shakeOldPosST06a = var_51_14.localPosition
			end

			local var_51_16 = 0.2

			if var_51_15 <= arg_48_1.time_ and arg_48_1.time_ < var_51_15 + var_51_16 then
				local var_51_17 = (arg_48_1.time_ - var_51_15) / 0.066
				local var_51_18, var_51_19 = math.modf(var_51_17)

				var_51_14.localPosition = Vector3.New(var_51_19 * 0.05, var_51_19 * 0.05, var_51_19 * 0) + arg_48_1.var_.shakeOldPosST06a
			end

			if arg_48_1.time_ >= var_51_15 + var_51_16 and arg_48_1.time_ < var_51_15 + var_51_16 + arg_51_0 then
				var_51_14.localPosition = arg_48_1.var_.shakeOldPosST06a
			end

			local var_51_20 = arg_48_1.bgs_.ST06a.transform
			local var_51_21 = 0.85

			if var_51_21 < arg_48_1.time_ and arg_48_1.time_ <= var_51_21 + arg_51_0 then
				arg_48_1.var_.shakeOldPosST06a = var_51_20.localPosition
			end

			local var_51_22 = 0.2

			if var_51_21 <= arg_48_1.time_ and arg_48_1.time_ < var_51_21 + var_51_22 then
				local var_51_23 = (arg_48_1.time_ - var_51_21) / 0.066
				local var_51_24, var_51_25 = math.modf(var_51_23)

				var_51_20.localPosition = Vector3.New(var_51_25 * 0.05, var_51_25 * 0.05, var_51_25 * 0) + arg_48_1.var_.shakeOldPosST06a
			end

			if arg_48_1.time_ >= var_51_21 + var_51_22 and arg_48_1.time_ < var_51_21 + var_51_22 + arg_51_0 then
				var_51_20.localPosition = arg_48_1.var_.shakeOldPosST06a
			end

			local var_51_26 = arg_48_1.bgs_.ST06a.transform
			local var_51_27 = 1.7

			if var_51_27 < arg_48_1.time_ and arg_48_1.time_ <= var_51_27 + arg_51_0 then
				arg_48_1.var_.shakeOldPosST06a = var_51_26.localPosition
			end

			local var_51_28 = 0.2

			if var_51_27 <= arg_48_1.time_ and arg_48_1.time_ < var_51_27 + var_51_28 then
				local var_51_29 = (arg_48_1.time_ - var_51_27) / 0.066
				local var_51_30, var_51_31 = math.modf(var_51_29)

				var_51_26.localPosition = Vector3.New(var_51_31 * 0.05, var_51_31 * 0.05, var_51_31 * 0) + arg_48_1.var_.shakeOldPosST06a
			end

			if arg_48_1.time_ >= var_51_27 + var_51_28 and arg_48_1.time_ < var_51_27 + var_51_28 + arg_51_0 then
				var_51_26.localPosition = arg_48_1.var_.shakeOldPosST06a
			end

			local var_51_32 = 0
			local var_51_33 = 1.05

			if var_51_32 < arg_48_1.time_ and arg_48_1.time_ <= var_51_32 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, false)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_34 = arg_48_1:GetWordFromCfg(109031012)
				local var_51_35 = arg_48_1:FormatText(var_51_34.content)

				arg_48_1.text_.text = var_51_35

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_36 = 42
				local var_51_37 = utf8.len(var_51_35)
				local var_51_38 = var_51_36 <= 0 and var_51_33 or var_51_33 * (var_51_37 / var_51_36)

				if var_51_38 > 0 and var_51_33 < var_51_38 then
					arg_48_1.talkMaxDuration = var_51_38

					if var_51_38 + var_51_32 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_38 + var_51_32
					end
				end

				arg_48_1.text_.text = var_51_35
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)
				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_39 = math.max(var_51_33, arg_48_1.talkMaxDuration)

			if var_51_32 <= arg_48_1.time_ and arg_48_1.time_ < var_51_32 + var_51_39 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_32) / var_51_39

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_32 + var_51_39 and arg_48_1.time_ < var_51_32 + var_51_39 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play109031013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 109031013
		arg_52_1.duration_ = 3.77

		local var_52_0 = {
			ja = 2.533,
			ko = 1.999999999999,
			zh = 3.766,
			en = 3.533
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
				arg_52_0:Play109031014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = arg_52_1.actors_["3004_tpose"].transform
			local var_55_1 = 0

			if var_55_1 < arg_52_1.time_ and arg_52_1.time_ <= var_55_1 + arg_55_0 then
				arg_52_1.var_.moveOldPos3004_tpose = var_55_0.localPosition

				local var_55_2 = GameObjectTools.GetOrAddComponent(var_55_0.gameObject, typeof(DynamicBoneHelper))

				if var_55_2 then
					var_55_2:EnableDynamicBone(false)
				end
			end

			local var_55_3 = 0.001

			if var_55_1 <= arg_52_1.time_ and arg_52_1.time_ < var_55_1 + var_55_3 then
				local var_55_4 = (arg_52_1.time_ - var_55_1) / var_55_3
				local var_55_5 = Vector3.New(0, -2.22, -3.1)

				var_55_0.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPos3004_tpose, var_55_5, var_55_4)

				local var_55_6 = manager.ui.mainCamera.transform.position - var_55_0.position

				var_55_0.forward = Vector3.New(var_55_6.x, var_55_6.y, var_55_6.z)

				local var_55_7 = var_55_0.localEulerAngles

				var_55_7.z = 0
				var_55_7.x = 0
				var_55_0.localEulerAngles = var_55_7
			end

			if arg_52_1.time_ >= var_55_1 + var_55_3 and arg_52_1.time_ < var_55_1 + var_55_3 + arg_55_0 then
				var_55_0.localPosition = Vector3.New(0, -2.22, -3.1)

				local var_55_8 = manager.ui.mainCamera.transform.position - var_55_0.position

				var_55_0.forward = Vector3.New(var_55_8.x, var_55_8.y, var_55_8.z)

				local var_55_9 = var_55_0.localEulerAngles

				var_55_9.z = 0
				var_55_9.x = 0
				var_55_0.localEulerAngles = var_55_9

				local var_55_10 = GameObjectTools.GetOrAddComponent(var_55_0.gameObject, typeof(DynamicBoneHelper))

				if var_55_10 then
					var_55_10:EnableDynamicBone(true)
				end
			end

			local var_55_11 = arg_52_1.actors_["3004_tpose"]
			local var_55_12 = 0

			if var_55_12 < arg_52_1.time_ and arg_52_1.time_ <= var_55_12 + arg_55_0 and not isNil(var_55_11) and arg_52_1.var_.characterEffect3004_tpose == nil then
				arg_52_1.var_.characterEffect3004_tpose = var_55_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_13 = 0.2

			if var_55_12 <= arg_52_1.time_ and arg_52_1.time_ < var_55_12 + var_55_13 and not isNil(var_55_11) then
				local var_55_14 = (arg_52_1.time_ - var_55_12) / var_55_13

				if arg_52_1.var_.characterEffect3004_tpose and not isNil(var_55_11) then
					arg_52_1.var_.characterEffect3004_tpose.fillFlat = false
				end
			end

			if arg_52_1.time_ >= var_55_12 + var_55_13 and arg_52_1.time_ < var_55_12 + var_55_13 + arg_55_0 and not isNil(var_55_11) and arg_52_1.var_.characterEffect3004_tpose then
				arg_52_1.var_.characterEffect3004_tpose.fillFlat = false
			end

			local var_55_15 = 0

			if var_55_15 < arg_52_1.time_ and arg_52_1.time_ <= var_55_15 + arg_55_0 then
				arg_52_1:PlayTimeline("3004_tpose", "StoryTimeline/CharAction/story3004/story3004action/3004action1_1")
			end

			local var_55_16 = 0
			local var_55_17 = 0.225

			if var_55_16 < arg_52_1.time_ and arg_52_1.time_ <= var_55_16 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				local var_55_18 = arg_52_1:FormatText(StoryNameCfg[82].name)

				arg_52_1.leftNameTxt_.text = var_55_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_19 = arg_52_1:GetWordFromCfg(109031013)
				local var_55_20 = arg_52_1:FormatText(var_55_19.content)

				arg_52_1.text_.text = var_55_20

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_21 = 9
				local var_55_22 = utf8.len(var_55_20)
				local var_55_23 = var_55_21 <= 0 and var_55_17 or var_55_17 * (var_55_22 / var_55_21)

				if var_55_23 > 0 and var_55_17 < var_55_23 then
					arg_52_1.talkMaxDuration = var_55_23

					if var_55_23 + var_55_16 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_23 + var_55_16
					end
				end

				arg_52_1.text_.text = var_55_20
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109031", "109031013", "story_v_out_109031.awb") ~= 0 then
					local var_55_24 = manager.audio:GetVoiceLength("story_v_out_109031", "109031013", "story_v_out_109031.awb") / 1000

					if var_55_24 + var_55_16 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_24 + var_55_16
					end

					if var_55_19.prefab_name ~= "" and arg_52_1.actors_[var_55_19.prefab_name] ~= nil then
						local var_55_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_19.prefab_name].transform, "story_v_out_109031", "109031013", "story_v_out_109031.awb")

						arg_52_1:RecordAudio("109031013", var_55_25)
						arg_52_1:RecordAudio("109031013", var_55_25)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_109031", "109031013", "story_v_out_109031.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_109031", "109031013", "story_v_out_109031.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_26 = math.max(var_55_17, arg_52_1.talkMaxDuration)

			if var_55_16 <= arg_52_1.time_ and arg_52_1.time_ < var_55_16 + var_55_26 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_16) / var_55_26

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_16 + var_55_26 and arg_52_1.time_ < var_55_16 + var_55_26 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3004_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_52_1:InitPlayNodeList()
	end,
	Play109031014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 109031014
		arg_56_1.duration_ = 19.13

		local var_56_0 = {
			ja = 19.133,
			ko = 6.366,
			zh = 7.466,
			en = 12.3
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
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play109031015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = "3007_tpose"

			if arg_56_1.actors_[var_59_0] == nil then
				local var_59_1 = Asset.Load("Char/" .. "3007_tpose")

				if not isNil(var_59_1) then
					local var_59_2 = Object.Instantiate(Asset.Load("Char/" .. "3007_tpose"), arg_56_1.stage_.transform)

					var_59_2.name = var_59_0
					var_59_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_56_1.actors_[var_59_0] = var_59_2

					local var_59_3 = var_59_2:GetComponentInChildren(typeof(CharacterEffect))

					var_59_3.enabled = true

					local var_59_4 = GameObjectTools.GetOrAddComponent(var_59_2, typeof(DynamicBoneHelper))

					if var_59_4 then
						var_59_4:EnableDynamicBone(false)
					end

					arg_56_1:ShowWeapon(var_59_3.transform, false)

					arg_56_1.var_[var_59_0 .. "Animator"] = var_59_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_56_1.var_[var_59_0 .. "Animator"].applyRootMotion = true
					arg_56_1.var_[var_59_0 .. "LipSync"] = var_59_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_59_5 = arg_56_1.actors_["3007_tpose"].transform
			local var_59_6 = 0

			if var_59_6 < arg_56_1.time_ and arg_56_1.time_ <= var_59_6 + arg_59_0 then
				arg_56_1.var_.moveOldPos3007_tpose = var_59_5.localPosition

				local var_59_7 = GameObjectTools.GetOrAddComponent(var_59_5.gameObject, typeof(DynamicBoneHelper))

				if var_59_7 then
					var_59_7:EnableDynamicBone(false)
				end
			end

			local var_59_8 = 0.001

			if var_59_6 <= arg_56_1.time_ and arg_56_1.time_ < var_59_6 + var_59_8 then
				local var_59_9 = (arg_56_1.time_ - var_59_6) / var_59_8
				local var_59_10 = Vector3.New(0, -2.25, -1.9)

				var_59_5.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos3007_tpose, var_59_10, var_59_9)

				local var_59_11 = manager.ui.mainCamera.transform.position - var_59_5.position

				var_59_5.forward = Vector3.New(var_59_11.x, var_59_11.y, var_59_11.z)

				local var_59_12 = var_59_5.localEulerAngles

				var_59_12.z = 0
				var_59_12.x = 0
				var_59_5.localEulerAngles = var_59_12
			end

			if arg_56_1.time_ >= var_59_6 + var_59_8 and arg_56_1.time_ < var_59_6 + var_59_8 + arg_59_0 then
				var_59_5.localPosition = Vector3.New(0, -2.25, -1.9)

				local var_59_13 = manager.ui.mainCamera.transform.position - var_59_5.position

				var_59_5.forward = Vector3.New(var_59_13.x, var_59_13.y, var_59_13.z)

				local var_59_14 = var_59_5.localEulerAngles

				var_59_14.z = 0
				var_59_14.x = 0
				var_59_5.localEulerAngles = var_59_14

				local var_59_15 = GameObjectTools.GetOrAddComponent(var_59_5.gameObject, typeof(DynamicBoneHelper))

				if var_59_15 then
					var_59_15:EnableDynamicBone(true)
				end
			end

			local var_59_16 = arg_56_1.actors_["3007_tpose"]
			local var_59_17 = 0

			if var_59_17 < arg_56_1.time_ and arg_56_1.time_ <= var_59_17 + arg_59_0 and not isNil(var_59_16) and arg_56_1.var_.characterEffect3007_tpose == nil then
				arg_56_1.var_.characterEffect3007_tpose = var_59_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_18 = 0.2

			if var_59_17 <= arg_56_1.time_ and arg_56_1.time_ < var_59_17 + var_59_18 and not isNil(var_59_16) then
				local var_59_19 = (arg_56_1.time_ - var_59_17) / var_59_18

				if arg_56_1.var_.characterEffect3007_tpose and not isNil(var_59_16) then
					arg_56_1.var_.characterEffect3007_tpose.fillFlat = false
				end
			end

			if arg_56_1.time_ >= var_59_17 + var_59_18 and arg_56_1.time_ < var_59_17 + var_59_18 + arg_59_0 and not isNil(var_59_16) and arg_56_1.var_.characterEffect3007_tpose then
				arg_56_1.var_.characterEffect3007_tpose.fillFlat = false
			end

			local var_59_20 = 0

			if var_59_20 < arg_56_1.time_ and arg_56_1.time_ <= var_59_20 + arg_59_0 then
				arg_56_1:PlayTimeline("3007_tpose", "StoryTimeline/CharAction/story3007/story3007action/3007action1_1")
			end

			local var_59_21 = arg_56_1.actors_["3004_tpose"].transform
			local var_59_22 = 0

			if var_59_22 < arg_56_1.time_ and arg_56_1.time_ <= var_59_22 + arg_59_0 then
				arg_56_1.var_.moveOldPos3004_tpose = var_59_21.localPosition

				local var_59_23 = GameObjectTools.GetOrAddComponent(var_59_21.gameObject, typeof(DynamicBoneHelper))

				if var_59_23 then
					var_59_23:EnableDynamicBone(false)
				end
			end

			local var_59_24 = 0.001

			if var_59_22 <= arg_56_1.time_ and arg_56_1.time_ < var_59_22 + var_59_24 then
				local var_59_25 = (arg_56_1.time_ - var_59_22) / var_59_24
				local var_59_26 = Vector3.New(0, 100, 0)

				var_59_21.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos3004_tpose, var_59_26, var_59_25)

				local var_59_27 = manager.ui.mainCamera.transform.position - var_59_21.position

				var_59_21.forward = Vector3.New(var_59_27.x, var_59_27.y, var_59_27.z)

				local var_59_28 = var_59_21.localEulerAngles

				var_59_28.z = 0
				var_59_28.x = 0
				var_59_21.localEulerAngles = var_59_28
			end

			if arg_56_1.time_ >= var_59_22 + var_59_24 and arg_56_1.time_ < var_59_22 + var_59_24 + arg_59_0 then
				var_59_21.localPosition = Vector3.New(0, 100, 0)

				local var_59_29 = manager.ui.mainCamera.transform.position - var_59_21.position

				var_59_21.forward = Vector3.New(var_59_29.x, var_59_29.y, var_59_29.z)

				local var_59_30 = var_59_21.localEulerAngles

				var_59_30.z = 0
				var_59_30.x = 0
				var_59_21.localEulerAngles = var_59_30

				local var_59_31 = GameObjectTools.GetOrAddComponent(var_59_21.gameObject, typeof(DynamicBoneHelper))

				if var_59_31 then
					var_59_31:EnableDynamicBone(true)
				end
			end

			local var_59_32 = 0
			local var_59_33 = 0.4

			if var_59_32 < arg_56_1.time_ and arg_56_1.time_ <= var_59_32 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				local var_59_34 = arg_56_1:FormatText(StoryNameCfg[158].name)

				arg_56_1.leftNameTxt_.text = var_59_34

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_35 = arg_56_1:GetWordFromCfg(109031014)
				local var_59_36 = arg_56_1:FormatText(var_59_35.content)

				arg_56_1.text_.text = var_59_36

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_37 = 16
				local var_59_38 = utf8.len(var_59_36)
				local var_59_39 = var_59_37 <= 0 and var_59_33 or var_59_33 * (var_59_38 / var_59_37)

				if var_59_39 > 0 and var_59_33 < var_59_39 then
					arg_56_1.talkMaxDuration = var_59_39

					if var_59_39 + var_59_32 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_39 + var_59_32
					end
				end

				arg_56_1.text_.text = var_59_36
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109031", "109031014", "story_v_out_109031.awb") ~= 0 then
					local var_59_40 = manager.audio:GetVoiceLength("story_v_out_109031", "109031014", "story_v_out_109031.awb") / 1000

					if var_59_40 + var_59_32 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_40 + var_59_32
					end

					if var_59_35.prefab_name ~= "" and arg_56_1.actors_[var_59_35.prefab_name] ~= nil then
						local var_59_41 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_35.prefab_name].transform, "story_v_out_109031", "109031014", "story_v_out_109031.awb")

						arg_56_1:RecordAudio("109031014", var_59_41)
						arg_56_1:RecordAudio("109031014", var_59_41)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_109031", "109031014", "story_v_out_109031.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_109031", "109031014", "story_v_out_109031.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_42 = math.max(var_59_33, arg_56_1.talkMaxDuration)

			if var_59_32 <= arg_56_1.time_ and arg_56_1.time_ < var_59_32 + var_59_42 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_32) / var_59_42

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_32 + var_59_42 and arg_56_1.time_ < var_59_32 + var_59_42 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3007_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "3004_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_56_1:InitPlayNodeList()
	end,
	Play109031015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 109031015
		arg_60_1.duration_ = 7.3

		local var_60_0 = {
			ja = 5.4,
			ko = 6.066,
			zh = 6.5,
			en = 7.3
		}
		local var_60_1 = manager.audio:GetLocalizationFlag()

		if var_60_0[var_60_1] ~= nil then
			arg_60_1.duration_ = var_60_0[var_60_1]
		end

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play109031016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = arg_60_1.actors_["3007_tpose"].transform
			local var_63_1 = 0

			if var_63_1 < arg_60_1.time_ and arg_60_1.time_ <= var_63_1 + arg_63_0 then
				arg_60_1.var_.moveOldPos3007_tpose = var_63_0.localPosition

				local var_63_2 = GameObjectTools.GetOrAddComponent(var_63_0.gameObject, typeof(DynamicBoneHelper))

				if var_63_2 then
					var_63_2:EnableDynamicBone(false)
				end
			end

			local var_63_3 = 0.001

			if var_63_1 <= arg_60_1.time_ and arg_60_1.time_ < var_63_1 + var_63_3 then
				local var_63_4 = (arg_60_1.time_ - var_63_1) / var_63_3
				local var_63_5 = Vector3.New(0, 100, 0)

				var_63_0.localPosition = Vector3.Lerp(arg_60_1.var_.moveOldPos3007_tpose, var_63_5, var_63_4)

				local var_63_6 = manager.ui.mainCamera.transform.position - var_63_0.position

				var_63_0.forward = Vector3.New(var_63_6.x, var_63_6.y, var_63_6.z)

				local var_63_7 = var_63_0.localEulerAngles

				var_63_7.z = 0
				var_63_7.x = 0
				var_63_0.localEulerAngles = var_63_7
			end

			if arg_60_1.time_ >= var_63_1 + var_63_3 and arg_60_1.time_ < var_63_1 + var_63_3 + arg_63_0 then
				var_63_0.localPosition = Vector3.New(0, 100, 0)

				local var_63_8 = manager.ui.mainCamera.transform.position - var_63_0.position

				var_63_0.forward = Vector3.New(var_63_8.x, var_63_8.y, var_63_8.z)

				local var_63_9 = var_63_0.localEulerAngles

				var_63_9.z = 0
				var_63_9.x = 0
				var_63_0.localEulerAngles = var_63_9

				local var_63_10 = GameObjectTools.GetOrAddComponent(var_63_0.gameObject, typeof(DynamicBoneHelper))

				if var_63_10 then
					var_63_10:EnableDynamicBone(true)
				end
			end

			local var_63_11 = arg_60_1.actors_["3004_tpose"].transform
			local var_63_12 = 0

			if var_63_12 < arg_60_1.time_ and arg_60_1.time_ <= var_63_12 + arg_63_0 then
				arg_60_1.var_.moveOldPos3004_tpose = var_63_11.localPosition

				local var_63_13 = GameObjectTools.GetOrAddComponent(var_63_11.gameObject, typeof(DynamicBoneHelper))

				if var_63_13 then
					var_63_13:EnableDynamicBone(false)
				end
			end

			local var_63_14 = 0.001

			if var_63_12 <= arg_60_1.time_ and arg_60_1.time_ < var_63_12 + var_63_14 then
				local var_63_15 = (arg_60_1.time_ - var_63_12) / var_63_14
				local var_63_16 = Vector3.New(0, -2.22, -3.1)

				var_63_11.localPosition = Vector3.Lerp(arg_60_1.var_.moveOldPos3004_tpose, var_63_16, var_63_15)

				local var_63_17 = manager.ui.mainCamera.transform.position - var_63_11.position

				var_63_11.forward = Vector3.New(var_63_17.x, var_63_17.y, var_63_17.z)

				local var_63_18 = var_63_11.localEulerAngles

				var_63_18.z = 0
				var_63_18.x = 0
				var_63_11.localEulerAngles = var_63_18
			end

			if arg_60_1.time_ >= var_63_12 + var_63_14 and arg_60_1.time_ < var_63_12 + var_63_14 + arg_63_0 then
				var_63_11.localPosition = Vector3.New(0, -2.22, -3.1)

				local var_63_19 = manager.ui.mainCamera.transform.position - var_63_11.position

				var_63_11.forward = Vector3.New(var_63_19.x, var_63_19.y, var_63_19.z)

				local var_63_20 = var_63_11.localEulerAngles

				var_63_20.z = 0
				var_63_20.x = 0
				var_63_11.localEulerAngles = var_63_20

				local var_63_21 = GameObjectTools.GetOrAddComponent(var_63_11.gameObject, typeof(DynamicBoneHelper))

				if var_63_21 then
					var_63_21:EnableDynamicBone(true)
				end
			end

			local var_63_22 = 0

			if var_63_22 < arg_60_1.time_ and arg_60_1.time_ <= var_63_22 + arg_63_0 then
				arg_60_1:PlayTimeline("3004_tpose", "StoryTimeline/CharAction/story3004/story3004action/3004action1_1")
			end

			local var_63_23 = arg_60_1.actors_["3004_tpose"]
			local var_63_24 = 0

			if var_63_24 < arg_60_1.time_ and arg_60_1.time_ <= var_63_24 + arg_63_0 and not isNil(var_63_23) and arg_60_1.var_.characterEffect3004_tpose == nil then
				arg_60_1.var_.characterEffect3004_tpose = var_63_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_25 = 0.2

			if var_63_24 <= arg_60_1.time_ and arg_60_1.time_ < var_63_24 + var_63_25 and not isNil(var_63_23) then
				local var_63_26 = (arg_60_1.time_ - var_63_24) / var_63_25

				if arg_60_1.var_.characterEffect3004_tpose and not isNil(var_63_23) then
					arg_60_1.var_.characterEffect3004_tpose.fillFlat = false
				end
			end

			if arg_60_1.time_ >= var_63_24 + var_63_25 and arg_60_1.time_ < var_63_24 + var_63_25 + arg_63_0 and not isNil(var_63_23) and arg_60_1.var_.characterEffect3004_tpose then
				arg_60_1.var_.characterEffect3004_tpose.fillFlat = false
			end

			local var_63_27 = 0
			local var_63_28 = 0.625

			if var_63_27 < arg_60_1.time_ and arg_60_1.time_ <= var_63_27 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				local var_63_29 = arg_60_1:FormatText(StoryNameCfg[82].name)

				arg_60_1.leftNameTxt_.text = var_63_29

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_30 = arg_60_1:GetWordFromCfg(109031015)
				local var_63_31 = arg_60_1:FormatText(var_63_30.content)

				arg_60_1.text_.text = var_63_31

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_32 = 25
				local var_63_33 = utf8.len(var_63_31)
				local var_63_34 = var_63_32 <= 0 and var_63_28 or var_63_28 * (var_63_33 / var_63_32)

				if var_63_34 > 0 and var_63_28 < var_63_34 then
					arg_60_1.talkMaxDuration = var_63_34

					if var_63_34 + var_63_27 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_34 + var_63_27
					end
				end

				arg_60_1.text_.text = var_63_31
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109031", "109031015", "story_v_out_109031.awb") ~= 0 then
					local var_63_35 = manager.audio:GetVoiceLength("story_v_out_109031", "109031015", "story_v_out_109031.awb") / 1000

					if var_63_35 + var_63_27 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_35 + var_63_27
					end

					if var_63_30.prefab_name ~= "" and arg_60_1.actors_[var_63_30.prefab_name] ~= nil then
						local var_63_36 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_30.prefab_name].transform, "story_v_out_109031", "109031015", "story_v_out_109031.awb")

						arg_60_1:RecordAudio("109031015", var_63_36)
						arg_60_1:RecordAudio("109031015", var_63_36)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_109031", "109031015", "story_v_out_109031.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_109031", "109031015", "story_v_out_109031.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_37 = math.max(var_63_28, arg_60_1.talkMaxDuration)

			if var_63_27 <= arg_60_1.time_ and arg_60_1.time_ < var_63_27 + var_63_37 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_27) / var_63_37

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_27 + var_63_37 and arg_60_1.time_ < var_63_27 + var_63_37 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3007_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "3004_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_60_1:InitPlayNodeList()
	end,
	Play109031016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 109031016
		arg_64_1.duration_ = 6.97

		local var_64_0 = {
			ja = 6.966,
			ko = 6.3,
			zh = 5.733,
			en = 6.6
		}
		local var_64_1 = manager.audio:GetLocalizationFlag()

		if var_64_0[var_64_1] ~= nil then
			arg_64_1.duration_ = var_64_0[var_64_1]
		end

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play109031017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = 0
			local var_67_1 = 0.675

			if var_67_0 < arg_64_1.time_ and arg_64_1.time_ <= var_67_0 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				local var_67_2 = arg_64_1:FormatText(StoryNameCfg[82].name)

				arg_64_1.leftNameTxt_.text = var_67_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_3 = arg_64_1:GetWordFromCfg(109031016)
				local var_67_4 = arg_64_1:FormatText(var_67_3.content)

				arg_64_1.text_.text = var_67_4

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_5 = 27
				local var_67_6 = utf8.len(var_67_4)
				local var_67_7 = var_67_5 <= 0 and var_67_1 or var_67_1 * (var_67_6 / var_67_5)

				if var_67_7 > 0 and var_67_1 < var_67_7 then
					arg_64_1.talkMaxDuration = var_67_7

					if var_67_7 + var_67_0 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_7 + var_67_0
					end
				end

				arg_64_1.text_.text = var_67_4
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109031", "109031016", "story_v_out_109031.awb") ~= 0 then
					local var_67_8 = manager.audio:GetVoiceLength("story_v_out_109031", "109031016", "story_v_out_109031.awb") / 1000

					if var_67_8 + var_67_0 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_8 + var_67_0
					end

					if var_67_3.prefab_name ~= "" and arg_64_1.actors_[var_67_3.prefab_name] ~= nil then
						local var_67_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_3.prefab_name].transform, "story_v_out_109031", "109031016", "story_v_out_109031.awb")

						arg_64_1:RecordAudio("109031016", var_67_9)
						arg_64_1:RecordAudio("109031016", var_67_9)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_109031", "109031016", "story_v_out_109031.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_109031", "109031016", "story_v_out_109031.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_10 = math.max(var_67_1, arg_64_1.talkMaxDuration)

			if var_67_0 <= arg_64_1.time_ and arg_64_1.time_ < var_67_0 + var_67_10 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_0) / var_67_10

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_0 + var_67_10 and arg_64_1.time_ < var_67_0 + var_67_10 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {}

		arg_64_1:InitPlayNodeList()
	end,
	Play109031017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 109031017
		arg_68_1.duration_ = 1.93

		local var_68_0 = {
			ja = 1.4,
			ko = 1.8,
			zh = 1.5,
			en = 1.933
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
				arg_68_0:Play109031018(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = arg_68_1.actors_["3004_tpose"].transform
			local var_71_1 = 0

			if var_71_1 < arg_68_1.time_ and arg_68_1.time_ <= var_71_1 + arg_71_0 then
				arg_68_1.var_.moveOldPos3004_tpose = var_71_0.localPosition

				local var_71_2 = GameObjectTools.GetOrAddComponent(var_71_0.gameObject, typeof(DynamicBoneHelper))

				if var_71_2 then
					var_71_2:EnableDynamicBone(false)
				end
			end

			local var_71_3 = 0.001

			if var_71_1 <= arg_68_1.time_ and arg_68_1.time_ < var_71_1 + var_71_3 then
				local var_71_4 = (arg_68_1.time_ - var_71_1) / var_71_3
				local var_71_5 = Vector3.New(0, 100, 0)

				var_71_0.localPosition = Vector3.Lerp(arg_68_1.var_.moveOldPos3004_tpose, var_71_5, var_71_4)

				local var_71_6 = manager.ui.mainCamera.transform.position - var_71_0.position

				var_71_0.forward = Vector3.New(var_71_6.x, var_71_6.y, var_71_6.z)

				local var_71_7 = var_71_0.localEulerAngles

				var_71_7.z = 0
				var_71_7.x = 0
				var_71_0.localEulerAngles = var_71_7
			end

			if arg_68_1.time_ >= var_71_1 + var_71_3 and arg_68_1.time_ < var_71_1 + var_71_3 + arg_71_0 then
				var_71_0.localPosition = Vector3.New(0, 100, 0)

				local var_71_8 = manager.ui.mainCamera.transform.position - var_71_0.position

				var_71_0.forward = Vector3.New(var_71_8.x, var_71_8.y, var_71_8.z)

				local var_71_9 = var_71_0.localEulerAngles

				var_71_9.z = 0
				var_71_9.x = 0
				var_71_0.localEulerAngles = var_71_9

				local var_71_10 = GameObjectTools.GetOrAddComponent(var_71_0.gameObject, typeof(DynamicBoneHelper))

				if var_71_10 then
					var_71_10:EnableDynamicBone(true)
				end
			end

			local var_71_11 = 0
			local var_71_12 = 0.125

			if var_71_11 < arg_68_1.time_ and arg_68_1.time_ <= var_71_11 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				local var_71_13 = arg_68_1:FormatText(StoryNameCfg[99].name)

				arg_68_1.leftNameTxt_.text = var_71_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, true)
				arg_68_1.iconController_:SetSelectedState("hero")

				arg_68_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_68_1.callingController_:SetSelectedState("normal")

				arg_68_1.keyicon_.color = Color.New(1, 1, 1)
				arg_68_1.icon_.color = Color.New(1, 1, 1)

				local var_71_14 = arg_68_1:GetWordFromCfg(109031017)
				local var_71_15 = arg_68_1:FormatText(var_71_14.content)

				arg_68_1.text_.text = var_71_15

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_16 = 5
				local var_71_17 = utf8.len(var_71_15)
				local var_71_18 = var_71_16 <= 0 and var_71_12 or var_71_12 * (var_71_17 / var_71_16)

				if var_71_18 > 0 and var_71_12 < var_71_18 then
					arg_68_1.talkMaxDuration = var_71_18

					if var_71_18 + var_71_11 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_18 + var_71_11
					end
				end

				arg_68_1.text_.text = var_71_15
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109031", "109031017", "story_v_out_109031.awb") ~= 0 then
					local var_71_19 = manager.audio:GetVoiceLength("story_v_out_109031", "109031017", "story_v_out_109031.awb") / 1000

					if var_71_19 + var_71_11 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_19 + var_71_11
					end

					if var_71_14.prefab_name ~= "" and arg_68_1.actors_[var_71_14.prefab_name] ~= nil then
						local var_71_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_14.prefab_name].transform, "story_v_out_109031", "109031017", "story_v_out_109031.awb")

						arg_68_1:RecordAudio("109031017", var_71_20)
						arg_68_1:RecordAudio("109031017", var_71_20)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_109031", "109031017", "story_v_out_109031.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_109031", "109031017", "story_v_out_109031.awb")
				end

				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_21 = math.max(var_71_12, arg_68_1.talkMaxDuration)

			if var_71_11 <= arg_68_1.time_ and arg_68_1.time_ < var_71_11 + var_71_21 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_11) / var_71_21

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_11 + var_71_21 and arg_68_1.time_ < var_71_11 + var_71_21 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3004_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_68_1:InitPlayNodeList()
	end,
	Play109031018 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 109031018
		arg_72_1.duration_ = 5

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play109031019(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = 0
			local var_75_1 = 0.35

			if var_75_0 < arg_72_1.time_ and arg_72_1.time_ <= var_75_0 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, false)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_2 = arg_72_1:GetWordFromCfg(109031018)
				local var_75_3 = arg_72_1:FormatText(var_75_2.content)

				arg_72_1.text_.text = var_75_3

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_4 = 14
				local var_75_5 = utf8.len(var_75_3)
				local var_75_6 = var_75_4 <= 0 and var_75_1 or var_75_1 * (var_75_5 / var_75_4)

				if var_75_6 > 0 and var_75_1 < var_75_6 then
					arg_72_1.talkMaxDuration = var_75_6

					if var_75_6 + var_75_0 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_6 + var_75_0
					end
				end

				arg_72_1.text_.text = var_75_3
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)
				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_7 = math.max(var_75_1, arg_72_1.talkMaxDuration)

			if var_75_0 <= arg_72_1.time_ and arg_72_1.time_ < var_75_0 + var_75_7 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_0) / var_75_7

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_0 + var_75_7 and arg_72_1.time_ < var_75_0 + var_75_7 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {}

		arg_72_1:InitPlayNodeList()
	end,
	Play109031019 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 109031019
		arg_76_1.duration_ = 5

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play109031020(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = 0
			local var_79_1 = 0.975

			if var_79_0 < arg_76_1.time_ and arg_76_1.time_ <= var_79_0 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, false)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_2 = arg_76_1:GetWordFromCfg(109031019)
				local var_79_3 = arg_76_1:FormatText(var_79_2.content)

				arg_76_1.text_.text = var_79_3

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_4 = 39
				local var_79_5 = utf8.len(var_79_3)
				local var_79_6 = var_79_4 <= 0 and var_79_1 or var_79_1 * (var_79_5 / var_79_4)

				if var_79_6 > 0 and var_79_1 < var_79_6 then
					arg_76_1.talkMaxDuration = var_79_6

					if var_79_6 + var_79_0 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_6 + var_79_0
					end
				end

				arg_76_1.text_.text = var_79_3
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)
				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_7 = math.max(var_79_1, arg_76_1.talkMaxDuration)

			if var_79_0 <= arg_76_1.time_ and arg_76_1.time_ < var_79_0 + var_79_7 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_0) / var_79_7

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_0 + var_79_7 and arg_76_1.time_ < var_79_0 + var_79_7 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {}

		arg_76_1:InitPlayNodeList()
	end,
	Play109031020 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 109031020
		arg_80_1.duration_ = 3.4

		local var_80_0 = {
			ja = 3.033,
			ko = 3.166,
			zh = 3.4,
			en = 2.666
		}
		local var_80_1 = manager.audio:GetLocalizationFlag()

		if var_80_0[var_80_1] ~= nil then
			arg_80_1.duration_ = var_80_0[var_80_1]
		end

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play109031021(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = 0
			local var_83_1 = 0.275

			if var_83_0 < arg_80_1.time_ and arg_80_1.time_ <= var_83_0 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				local var_83_2 = arg_80_1:FormatText(StoryNameCfg[99].name)

				arg_80_1.leftNameTxt_.text = var_83_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, true)
				arg_80_1.iconController_:SetSelectedState("hero")

				arg_80_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_80_1.callingController_:SetSelectedState("normal")

				arg_80_1.keyicon_.color = Color.New(1, 1, 1)
				arg_80_1.icon_.color = Color.New(1, 1, 1)

				local var_83_3 = arg_80_1:GetWordFromCfg(109031020)
				local var_83_4 = arg_80_1:FormatText(var_83_3.content)

				arg_80_1.text_.text = var_83_4

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_5 = 11
				local var_83_6 = utf8.len(var_83_4)
				local var_83_7 = var_83_5 <= 0 and var_83_1 or var_83_1 * (var_83_6 / var_83_5)

				if var_83_7 > 0 and var_83_1 < var_83_7 then
					arg_80_1.talkMaxDuration = var_83_7

					if var_83_7 + var_83_0 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_7 + var_83_0
					end
				end

				arg_80_1.text_.text = var_83_4
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109031", "109031020", "story_v_out_109031.awb") ~= 0 then
					local var_83_8 = manager.audio:GetVoiceLength("story_v_out_109031", "109031020", "story_v_out_109031.awb") / 1000

					if var_83_8 + var_83_0 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_8 + var_83_0
					end

					if var_83_3.prefab_name ~= "" and arg_80_1.actors_[var_83_3.prefab_name] ~= nil then
						local var_83_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_3.prefab_name].transform, "story_v_out_109031", "109031020", "story_v_out_109031.awb")

						arg_80_1:RecordAudio("109031020", var_83_9)
						arg_80_1:RecordAudio("109031020", var_83_9)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_out_109031", "109031020", "story_v_out_109031.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_out_109031", "109031020", "story_v_out_109031.awb")
				end

				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_10 = math.max(var_83_1, arg_80_1.talkMaxDuration)

			if var_83_0 <= arg_80_1.time_ and arg_80_1.time_ < var_83_0 + var_83_10 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_0) / var_83_10

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_0 + var_83_10 and arg_80_1.time_ < var_83_0 + var_83_10 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {}

		arg_80_1:InitPlayNodeList()
	end,
	Play109031021 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 109031021
		arg_84_1.duration_ = 5.3

		local var_84_0 = {
			ja = 3.633,
			ko = 2.5,
			zh = 3.7,
			en = 5.3
		}
		local var_84_1 = manager.audio:GetLocalizationFlag()

		if var_84_0[var_84_1] ~= nil then
			arg_84_1.duration_ = var_84_0[var_84_1]
		end

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
			arg_84_1.auto_ = false
		end

		function arg_84_1.playNext_(arg_86_0)
			arg_84_1.onStoryFinished_()
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = arg_84_1.actors_["3004_tpose"].transform
			local var_87_1 = 0

			if var_87_1 < arg_84_1.time_ and arg_84_1.time_ <= var_87_1 + arg_87_0 then
				arg_84_1.var_.moveOldPos3004_tpose = var_87_0.localPosition

				local var_87_2 = GameObjectTools.GetOrAddComponent(var_87_0.gameObject, typeof(DynamicBoneHelper))

				if var_87_2 then
					var_87_2:EnableDynamicBone(false)
				end
			end

			local var_87_3 = 0.001

			if var_87_1 <= arg_84_1.time_ and arg_84_1.time_ < var_87_1 + var_87_3 then
				local var_87_4 = (arg_84_1.time_ - var_87_1) / var_87_3
				local var_87_5 = Vector3.New(0, -2.22, -3.1)

				var_87_0.localPosition = Vector3.Lerp(arg_84_1.var_.moveOldPos3004_tpose, var_87_5, var_87_4)

				local var_87_6 = manager.ui.mainCamera.transform.position - var_87_0.position

				var_87_0.forward = Vector3.New(var_87_6.x, var_87_6.y, var_87_6.z)

				local var_87_7 = var_87_0.localEulerAngles

				var_87_7.z = 0
				var_87_7.x = 0
				var_87_0.localEulerAngles = var_87_7
			end

			if arg_84_1.time_ >= var_87_1 + var_87_3 and arg_84_1.time_ < var_87_1 + var_87_3 + arg_87_0 then
				var_87_0.localPosition = Vector3.New(0, -2.22, -3.1)

				local var_87_8 = manager.ui.mainCamera.transform.position - var_87_0.position

				var_87_0.forward = Vector3.New(var_87_8.x, var_87_8.y, var_87_8.z)

				local var_87_9 = var_87_0.localEulerAngles

				var_87_9.z = 0
				var_87_9.x = 0
				var_87_0.localEulerAngles = var_87_9

				local var_87_10 = GameObjectTools.GetOrAddComponent(var_87_0.gameObject, typeof(DynamicBoneHelper))

				if var_87_10 then
					var_87_10:EnableDynamicBone(true)
				end
			end

			local var_87_11 = arg_84_1.actors_["3004_tpose"]
			local var_87_12 = 0

			if var_87_12 < arg_84_1.time_ and arg_84_1.time_ <= var_87_12 + arg_87_0 and not isNil(var_87_11) and arg_84_1.var_.characterEffect3004_tpose == nil then
				arg_84_1.var_.characterEffect3004_tpose = var_87_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_13 = 0.2

			if var_87_12 <= arg_84_1.time_ and arg_84_1.time_ < var_87_12 + var_87_13 and not isNil(var_87_11) then
				local var_87_14 = (arg_84_1.time_ - var_87_12) / var_87_13

				if arg_84_1.var_.characterEffect3004_tpose and not isNil(var_87_11) then
					arg_84_1.var_.characterEffect3004_tpose.fillFlat = false
				end
			end

			if arg_84_1.time_ >= var_87_12 + var_87_13 and arg_84_1.time_ < var_87_12 + var_87_13 + arg_87_0 and not isNil(var_87_11) and arg_84_1.var_.characterEffect3004_tpose then
				arg_84_1.var_.characterEffect3004_tpose.fillFlat = false
			end

			local var_87_15 = 0

			if var_87_15 < arg_84_1.time_ and arg_84_1.time_ <= var_87_15 + arg_87_0 then
				arg_84_1:PlayTimeline("3004_tpose", "StoryTimeline/CharAction/story3004/story3004action/3004action1_1")
			end

			local var_87_16 = 0
			local var_87_17 = 0.225

			if var_87_16 < arg_84_1.time_ and arg_84_1.time_ <= var_87_16 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				local var_87_18 = arg_84_1:FormatText(StoryNameCfg[82].name)

				arg_84_1.leftNameTxt_.text = var_87_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_19 = arg_84_1:GetWordFromCfg(109031021)
				local var_87_20 = arg_84_1:FormatText(var_87_19.content)

				arg_84_1.text_.text = var_87_20

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_21 = 9
				local var_87_22 = utf8.len(var_87_20)
				local var_87_23 = var_87_21 <= 0 and var_87_17 or var_87_17 * (var_87_22 / var_87_21)

				if var_87_23 > 0 and var_87_17 < var_87_23 then
					arg_84_1.talkMaxDuration = var_87_23

					if var_87_23 + var_87_16 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_23 + var_87_16
					end
				end

				arg_84_1.text_.text = var_87_20
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109031", "109031021", "story_v_out_109031.awb") ~= 0 then
					local var_87_24 = manager.audio:GetVoiceLength("story_v_out_109031", "109031021", "story_v_out_109031.awb") / 1000

					if var_87_24 + var_87_16 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_24 + var_87_16
					end

					if var_87_19.prefab_name ~= "" and arg_84_1.actors_[var_87_19.prefab_name] ~= nil then
						local var_87_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_19.prefab_name].transform, "story_v_out_109031", "109031021", "story_v_out_109031.awb")

						arg_84_1:RecordAudio("109031021", var_87_25)
						arg_84_1:RecordAudio("109031021", var_87_25)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_out_109031", "109031021", "story_v_out_109031.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_out_109031", "109031021", "story_v_out_109031.awb")
				end

				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_26 = math.max(var_87_17, arg_84_1.talkMaxDuration)

			if var_87_16 <= arg_84_1.time_ and arg_84_1.time_ < var_87_16 + var_87_26 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_16) / var_87_26

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_16 + var_87_26 and arg_84_1.time_ < var_87_16 + var_87_26 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3004_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_84_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST06a"
	},
	voices = {
		"story_v_out_109031.awb"
	}
}
