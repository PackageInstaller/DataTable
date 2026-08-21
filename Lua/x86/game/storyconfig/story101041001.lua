return {
	Play104101001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 104101001
		arg_1_1.duration_ = 4.67

		local var_1_0 = {
			ja = 3.933,
			ko = 4.666,
			zh = 4,
			en = 4.166
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
				arg_1_0:Play104101002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = 0
			local var_4_1 = 1

			if var_4_0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_0 + arg_4_0 then
				local var_4_2 = "play"
				local var_4_3 = "music"

				arg_1_1:AudioAction(var_4_2, var_4_3, "bgm_story_office", "bgm_story_office", "bgm_story_office")

				local var_4_4 = ""
				local var_4_5 = manager.audio:GetAudioName("bgm_story_office", "bgm_story_office")

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

			local var_4_6 = "B13"

			if arg_1_1.bgs_[var_4_6] == nil then
				local var_4_7 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_7:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_6)
				var_4_7.name = var_4_6
				var_4_7.transform.parent = arg_1_1.stage_.transform
				var_4_7.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_6] = var_4_7
			end

			local var_4_8 = arg_1_1.bgs_.B13
			local var_4_9 = 0

			if var_4_9 < arg_1_1.time_ and arg_1_1.time_ <= var_4_9 + arg_4_0 then
				local var_4_10 = var_4_8:GetComponent("SpriteRenderer")

				if var_4_10 then
					arg_1_1.var_.alphaOldValueB13 = var_4_10.color.a
					arg_1_1.var_.alphaMatValueB13 = var_4_10
				end

				arg_1_1.var_.alphaOldValueB13 = 0
			end

			local var_4_11 = 1.5

			if var_4_9 <= arg_1_1.time_ and arg_1_1.time_ < var_4_9 + var_4_11 then
				local var_4_12 = (arg_1_1.time_ - var_4_9) / var_4_11
				local var_4_13 = Mathf.Lerp(arg_1_1.var_.alphaOldValueB13, 1, var_4_12)

				if arg_1_1.var_.alphaMatValueB13 then
					local var_4_14 = arg_1_1.var_.alphaMatValueB13.color

					var_4_14.a = var_4_13
					arg_1_1.var_.alphaMatValueB13.color = var_4_14
				end
			end

			if arg_1_1.time_ >= var_4_9 + var_4_11 and arg_1_1.time_ < var_4_9 + var_4_11 + arg_4_0 and arg_1_1.var_.alphaMatValueB13 then
				local var_4_15 = arg_1_1.var_.alphaMatValueB13
				local var_4_16 = var_4_15.color

				var_4_16.a = 1
				var_4_15.color = var_4_16
			end

			local var_4_17 = 0

			if var_4_17 < arg_1_1.time_ and arg_1_1.time_ <= var_4_17 + arg_4_0 then
				local var_4_18 = manager.ui.mainCamera.transform.localPosition
				local var_4_19 = Vector3.New(0, 0, 10) + Vector3.New(var_4_18.x, var_4_18.y, 0)
				local var_4_20 = arg_1_1.bgs_.B13

				var_4_20.transform.localPosition = var_4_19
				var_4_20.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_21 = var_4_20:GetComponent("SpriteRenderer")

				if var_4_21 and var_4_21.sprite then
					local var_4_22 = (var_4_20.transform.localPosition - var_4_18).z
					local var_4_23 = manager.ui.mainCameraCom_
					local var_4_24 = 2 * var_4_22 * Mathf.Tan(var_4_23.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_4_25 = var_4_24 * var_4_23.aspect
					local var_4_26 = var_4_21.sprite.bounds.size.x
					local var_4_27 = var_4_21.sprite.bounds.size.y
					local var_4_28 = var_4_25 / var_4_26
					local var_4_29 = var_4_24 / var_4_27
					local var_4_30 = var_4_29 < var_4_28 and var_4_28 or var_4_29

					var_4_20.transform.localScale = Vector3.New(var_4_30, var_4_30, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "B13" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_31 = "2070_tpose"

			if arg_1_1.actors_[var_4_31] == nil then
				local var_4_32 = Asset.Load("Char/" .. "2070_tpose")

				if not isNil(var_4_32) then
					local var_4_33 = Object.Instantiate(Asset.Load("Char/" .. "2070_tpose"), arg_1_1.stage_.transform)

					var_4_33.name = var_4_31
					var_4_33.transform.localPosition = Vector3.New(0, 100, 0)
					arg_1_1.actors_[var_4_31] = var_4_33

					local var_4_34 = var_4_33:GetComponentInChildren(typeof(CharacterEffect))

					var_4_34.enabled = true

					local var_4_35 = GameObjectTools.GetOrAddComponent(var_4_33, typeof(DynamicBoneHelper))

					if var_4_35 then
						var_4_35:EnableDynamicBone(false)
					end

					arg_1_1:ShowWeapon(var_4_34.transform, false)

					arg_1_1.var_[var_4_31 .. "Animator"] = var_4_34.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_1_1.var_[var_4_31 .. "Animator"].applyRootMotion = true
					arg_1_1.var_[var_4_31 .. "LipSync"] = var_4_34.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_4_36 = arg_1_1.actors_["2070_tpose"].transform
			local var_4_37 = 1.79999995231628

			if var_4_37 < arg_1_1.time_ and arg_1_1.time_ <= var_4_37 + arg_4_0 then
				arg_1_1.var_.moveOldPos2070_tpose = var_4_36.localPosition

				local var_4_38 = GameObjectTools.GetOrAddComponent(var_4_36.gameObject, typeof(DynamicBoneHelper))

				if var_4_38 then
					var_4_38:EnableDynamicBone(false)
				end
			end

			local var_4_39 = 0.001

			if var_4_37 <= arg_1_1.time_ and arg_1_1.time_ < var_4_37 + var_4_39 then
				local var_4_40 = (arg_1_1.time_ - var_4_37) / var_4_39
				local var_4_41 = Vector3.New(0, -0.49, -3.1)

				var_4_36.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos2070_tpose, var_4_41, var_4_40)

				local var_4_42 = manager.ui.mainCamera.transform.position - var_4_36.position

				var_4_36.forward = Vector3.New(var_4_42.x, var_4_42.y, var_4_42.z)

				local var_4_43 = var_4_36.localEulerAngles

				var_4_43.z = 0
				var_4_43.x = 0
				var_4_36.localEulerAngles = var_4_43
			end

			if arg_1_1.time_ >= var_4_37 + var_4_39 and arg_1_1.time_ < var_4_37 + var_4_39 + arg_4_0 then
				var_4_36.localPosition = Vector3.New(0, -0.49, -3.1)

				local var_4_44 = manager.ui.mainCamera.transform.position - var_4_36.position

				var_4_36.forward = Vector3.New(var_4_44.x, var_4_44.y, var_4_44.z)

				local var_4_45 = var_4_36.localEulerAngles

				var_4_45.z = 0
				var_4_45.x = 0
				var_4_36.localEulerAngles = var_4_45

				local var_4_46 = GameObjectTools.GetOrAddComponent(var_4_36.gameObject, typeof(DynamicBoneHelper))

				if var_4_46 then
					var_4_46:EnableDynamicBone(true)
				end
			end

			local var_4_47 = 0

			if var_4_47 < arg_1_1.time_ and arg_1_1.time_ <= var_4_47 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_48 = 2

			if arg_1_1.time_ >= var_4_47 + var_4_48 and arg_1_1.time_ < var_4_47 + var_4_48 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_49 = 2
			local var_4_50 = 0.225

			if var_4_49 < arg_1_1.time_ and arg_1_1.time_ <= var_4_49 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_51 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_51:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_51:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_51:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_52 = arg_1_1:FormatText(StoryNameCfg[15].name)

				arg_1_1.leftNameTxt_.text = var_4_52

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1037")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_53 = arg_1_1:GetWordFromCfg(104101001)
				local var_4_54 = arg_1_1:FormatText(var_4_53.content)

				arg_1_1.text_.text = var_4_54

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_55 = 9
				local var_4_56 = utf8.len(var_4_54)
				local var_4_57 = var_4_55 <= 0 and var_4_50 or var_4_50 * (var_4_56 / var_4_55)

				if var_4_57 > 0 and var_4_50 < var_4_57 then
					arg_1_1.talkMaxDuration = var_4_57
					var_4_49 = var_4_49 + 0.3

					if var_4_57 + var_4_49 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_57 + var_4_49
					end
				end

				arg_1_1.text_.text = var_4_54
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104101", "104101001", "story_v_out_104101.awb") ~= 0 then
					local var_4_58 = manager.audio:GetVoiceLength("story_v_out_104101", "104101001", "story_v_out_104101.awb") / 1000

					if var_4_58 + var_4_49 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_58 + var_4_49
					end

					if var_4_53.prefab_name ~= "" and arg_1_1.actors_[var_4_53.prefab_name] ~= nil then
						local var_4_59 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_53.prefab_name].transform, "story_v_out_104101", "104101001", "story_v_out_104101.awb")

						arg_1_1:RecordAudio("104101001", var_4_59)
						arg_1_1:RecordAudio("104101001", var_4_59)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_104101", "104101001", "story_v_out_104101.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_104101", "104101001", "story_v_out_104101.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_60 = var_4_49 + 0.3
			local var_4_61 = math.max(var_4_50, arg_1_1.talkMaxDuration)

			if var_4_60 <= arg_1_1.time_ and arg_1_1.time_ < var_4_60 + var_4_61 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_60) / var_4_61

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_60 + var_4_61 and arg_1_1.time_ < var_4_60 + var_4_61 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2070_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 1.79999995231628,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play104101002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 104101002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play104101003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0
			local var_11_1 = 1

			if var_11_0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_0 + arg_11_0 then
				local var_11_2 = "play"
				local var_11_3 = "effect"

				arg_8_1:AudioAction(var_11_2, var_11_3, "se_story", "se_story_fight_normalgun", "")
			end

			local var_11_4 = 0
			local var_11_5 = 1

			if var_11_4 < arg_8_1.time_ and arg_8_1.time_ <= var_11_4 + arg_11_0 then
				local var_11_6 = "play"
				local var_11_7 = "effect"

				arg_8_1:AudioAction(var_11_6, var_11_7, "se_story", "se_story_fight_normalgun", "")
			end

			local var_11_8 = 0

			if var_11_8 < arg_8_1.time_ and arg_8_1.time_ <= var_11_8 + arg_11_0 then
				arg_8_1.mask_.enabled = true
				arg_8_1.mask_.raycastTarget = true

				arg_8_1:SetGaussion(false)
			end

			local var_11_9 = 0.5

			if var_11_8 <= arg_8_1.time_ and arg_8_1.time_ < var_11_8 + var_11_9 then
				local var_11_10 = (arg_8_1.time_ - var_11_8) / var_11_9
				local var_11_11 = Color.New(1, 1, 1)

				var_11_11.a = Mathf.Lerp(1, 0, var_11_10)
				arg_8_1.mask_.color = var_11_11
			end

			if arg_8_1.time_ >= var_11_8 + var_11_9 and arg_8_1.time_ < var_11_8 + var_11_9 + arg_11_0 then
				local var_11_12 = Color.New(1, 1, 1)
				local var_11_13 = 0

				arg_8_1.mask_.enabled = false
				var_11_12.a = var_11_13
				arg_8_1.mask_.color = var_11_12
			end

			local var_11_14 = manager.ui.mainCamera.transform
			local var_11_15 = 0

			if var_11_15 < arg_8_1.time_ and arg_8_1.time_ <= var_11_15 + arg_11_0 then
				arg_8_1.var_.shakeOldPosMainCamera = var_11_14.localPosition
			end

			local var_11_16 = 0.600000023841858

			if var_11_15 <= arg_8_1.time_ and arg_8_1.time_ < var_11_15 + var_11_16 then
				local var_11_17 = (arg_8_1.time_ - var_11_15) / 0.066
				local var_11_18, var_11_19 = math.modf(var_11_17)

				var_11_14.localPosition = Vector3.New(var_11_19 * 0.13, var_11_19 * 0.13, var_11_19 * 0.13) + arg_8_1.var_.shakeOldPosMainCamera
			end

			if arg_8_1.time_ >= var_11_15 + var_11_16 and arg_8_1.time_ < var_11_15 + var_11_16 + arg_11_0 then
				var_11_14.localPosition = arg_8_1.var_.shakeOldPosMainCamera
			end

			local var_11_20 = 0
			local var_11_21 = 0.2

			if var_11_20 < arg_8_1.time_ and arg_8_1.time_ <= var_11_20 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, false)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_22 = arg_8_1:GetWordFromCfg(104101002)
				local var_11_23 = arg_8_1:FormatText(var_11_22.content)

				arg_8_1.text_.text = var_11_23

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_24 = 8
				local var_11_25 = utf8.len(var_11_23)
				local var_11_26 = var_11_24 <= 0 and var_11_21 or var_11_21 * (var_11_25 / var_11_24)

				if var_11_26 > 0 and var_11_21 < var_11_26 then
					arg_8_1.talkMaxDuration = var_11_26

					if var_11_26 + var_11_20 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_26 + var_11_20
					end
				end

				arg_8_1.text_.text = var_11_23
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)
				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_27 = math.max(var_11_21, arg_8_1.talkMaxDuration)

			if var_11_20 <= arg_8_1.time_ and arg_8_1.time_ < var_11_20 + var_11_27 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_20) / var_11_27

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_20 + var_11_27 and arg_8_1.time_ < var_11_20 + var_11_27 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play104101003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 104101003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play104101004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = arg_12_1.actors_["2070_tpose"].transform
			local var_15_1 = 0

			if var_15_1 < arg_12_1.time_ and arg_12_1.time_ <= var_15_1 + arg_15_0 then
				arg_12_1.var_.moveOldPos2070_tpose = var_15_0.localPosition

				local var_15_2 = GameObjectTools.GetOrAddComponent(var_15_0.gameObject, typeof(DynamicBoneHelper))

				if var_15_2 then
					var_15_2:EnableDynamicBone(false)
				end
			end

			local var_15_3 = 0.001

			if var_15_1 <= arg_12_1.time_ and arg_12_1.time_ < var_15_1 + var_15_3 then
				local var_15_4 = (arg_12_1.time_ - var_15_1) / var_15_3
				local var_15_5 = Vector3.New(0, 100, 0)

				var_15_0.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos2070_tpose, var_15_5, var_15_4)

				local var_15_6 = manager.ui.mainCamera.transform.position - var_15_0.position

				var_15_0.forward = Vector3.New(var_15_6.x, var_15_6.y, var_15_6.z)

				local var_15_7 = var_15_0.localEulerAngles

				var_15_7.z = 0
				var_15_7.x = 0
				var_15_0.localEulerAngles = var_15_7
			end

			if arg_12_1.time_ >= var_15_1 + var_15_3 and arg_12_1.time_ < var_15_1 + var_15_3 + arg_15_0 then
				var_15_0.localPosition = Vector3.New(0, 100, 0)

				local var_15_8 = manager.ui.mainCamera.transform.position - var_15_0.position

				var_15_0.forward = Vector3.New(var_15_8.x, var_15_8.y, var_15_8.z)

				local var_15_9 = var_15_0.localEulerAngles

				var_15_9.z = 0
				var_15_9.x = 0
				var_15_0.localEulerAngles = var_15_9

				local var_15_10 = GameObjectTools.GetOrAddComponent(var_15_0.gameObject, typeof(DynamicBoneHelper))

				if var_15_10 then
					var_15_10:EnableDynamicBone(true)
				end
			end

			local var_15_11 = 0
			local var_15_12 = 0.375

			if var_15_11 < arg_12_1.time_ and arg_12_1.time_ <= var_15_11 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, false)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_13 = arg_12_1:GetWordFromCfg(104101003)
				local var_15_14 = arg_12_1:FormatText(var_15_13.content)

				arg_12_1.text_.text = var_15_14

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_15 = 15
				local var_15_16 = utf8.len(var_15_14)
				local var_15_17 = var_15_15 <= 0 and var_15_12 or var_15_12 * (var_15_16 / var_15_15)

				if var_15_17 > 0 and var_15_12 < var_15_17 then
					arg_12_1.talkMaxDuration = var_15_17

					if var_15_17 + var_15_11 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_17 + var_15_11
					end
				end

				arg_12_1.text_.text = var_15_14
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)
				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_18 = math.max(var_15_12, arg_12_1.talkMaxDuration)

			if var_15_11 <= arg_12_1.time_ and arg_12_1.time_ < var_15_11 + var_15_18 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_11) / var_15_18

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_11 + var_15_18 and arg_12_1.time_ < var_15_11 + var_15_18 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2070_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_12_1:InitPlayNodeList()
	end,
	Play104101004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 104101004
		arg_16_1.duration_ = 5

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play104101005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = 0
			local var_19_1 = 0.775

			if var_19_0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_0 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				local var_19_2 = arg_16_1:FormatText(StoryNameCfg[7].name)

				arg_16_1.leftNameTxt_.text = var_19_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, true)
				arg_16_1.iconController_:SetSelectedState("hero")

				arg_16_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_16_1.callingController_:SetSelectedState("normal")

				arg_16_1.keyicon_.color = Color.New(1, 1, 1)
				arg_16_1.icon_.color = Color.New(1, 1, 1)

				local var_19_3 = arg_16_1:GetWordFromCfg(104101004)
				local var_19_4 = arg_16_1:FormatText(var_19_3.content)

				arg_16_1.text_.text = var_19_4

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_5 = 31
				local var_19_6 = utf8.len(var_19_4)
				local var_19_7 = var_19_5 <= 0 and var_19_1 or var_19_1 * (var_19_6 / var_19_5)

				if var_19_7 > 0 and var_19_1 < var_19_7 then
					arg_16_1.talkMaxDuration = var_19_7

					if var_19_7 + var_19_0 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_7 + var_19_0
					end
				end

				arg_16_1.text_.text = var_19_4
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)
				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_8 = math.max(var_19_1, arg_16_1.talkMaxDuration)

			if var_19_0 <= arg_16_1.time_ and arg_16_1.time_ < var_19_0 + var_19_8 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_0) / var_19_8

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_0 + var_19_8 and arg_16_1.time_ < var_19_0 + var_19_8 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play104101005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 104101005
		arg_20_1.duration_ = 12.4

		local var_20_0 = {
			ja = 12,
			ko = 10.766,
			zh = 12.4,
			en = 8.766
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
				arg_20_0:Play104101006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = 3
			local var_23_1 = 1

			if var_23_0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_0 + arg_23_0 then
				local var_23_2 = "play"
				local var_23_3 = "effect"

				arg_20_1:AudioAction(var_23_2, var_23_3, "se_story", "se_story_robot_long", "")
			end

			local var_23_4 = "S0408"

			if arg_20_1.bgs_[var_23_4] == nil then
				local var_23_5 = Object.Instantiate(arg_20_1.paintGo_)

				var_23_5:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_23_4)
				var_23_5.name = var_23_4
				var_23_5.transform.parent = arg_20_1.stage_.transform
				var_23_5.transform.localPosition = Vector3.New(0, 100, 0)
				arg_20_1.bgs_[var_23_4] = var_23_5
			end

			local var_23_6 = 1.5

			if var_23_6 < arg_20_1.time_ and arg_20_1.time_ <= var_23_6 + arg_23_0 then
				local var_23_7 = manager.ui.mainCamera.transform.localPosition
				local var_23_8 = Vector3.New(0, 0, 10) + Vector3.New(var_23_7.x, var_23_7.y, 0)
				local var_23_9 = arg_20_1.bgs_.S0408

				var_23_9.transform.localPosition = var_23_8
				var_23_9.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_23_10 = var_23_9:GetComponent("SpriteRenderer")

				if var_23_10 and var_23_10.sprite then
					local var_23_11 = (var_23_9.transform.localPosition - var_23_7).z
					local var_23_12 = manager.ui.mainCameraCom_
					local var_23_13 = 2 * var_23_11 * Mathf.Tan(var_23_12.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_23_14 = var_23_13 * var_23_12.aspect
					local var_23_15 = var_23_10.sprite.bounds.size.x
					local var_23_16 = var_23_10.sprite.bounds.size.y
					local var_23_17 = var_23_14 / var_23_15
					local var_23_18 = var_23_13 / var_23_16
					local var_23_19 = var_23_18 < var_23_17 and var_23_17 or var_23_18

					var_23_9.transform.localScale = Vector3.New(var_23_19, var_23_19, 0)
				end

				for iter_23_0, iter_23_1 in pairs(arg_20_1.bgs_) do
					if iter_23_0 ~= "S0408" then
						iter_23_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_23_20 = arg_20_1.bgs_.S0408
			local var_23_21 = 1.5

			if var_23_21 < arg_20_1.time_ and arg_20_1.time_ <= var_23_21 + arg_23_0 then
				local var_23_22 = var_23_20:GetComponent("SpriteRenderer")

				if var_23_22 then
					arg_20_1.var_.alphaOldValueS0408 = var_23_22.color.a
					arg_20_1.var_.alphaMatValueS0408 = var_23_22
				end

				arg_20_1.var_.alphaOldValueS0408 = 0
			end

			local var_23_23 = 1.5

			if var_23_21 <= arg_20_1.time_ and arg_20_1.time_ < var_23_21 + var_23_23 then
				local var_23_24 = (arg_20_1.time_ - var_23_21) / var_23_23
				local var_23_25 = Mathf.Lerp(arg_20_1.var_.alphaOldValueS0408, 1, var_23_24)

				if arg_20_1.var_.alphaMatValueS0408 then
					local var_23_26 = arg_20_1.var_.alphaMatValueS0408.color

					var_23_26.a = var_23_25
					arg_20_1.var_.alphaMatValueS0408.color = var_23_26
				end
			end

			if arg_20_1.time_ >= var_23_21 + var_23_23 and arg_20_1.time_ < var_23_21 + var_23_23 + arg_23_0 and arg_20_1.var_.alphaMatValueS0408 then
				local var_23_27 = arg_20_1.var_.alphaMatValueS0408
				local var_23_28 = var_23_27.color

				var_23_28.a = 1
				var_23_27.color = var_23_28
			end

			local var_23_29 = arg_20_1.bgs_.B13
			local var_23_30 = 0

			if var_23_30 < arg_20_1.time_ and arg_20_1.time_ <= var_23_30 + arg_23_0 then
				local var_23_31 = var_23_29:GetComponent("SpriteRenderer")

				if var_23_31 then
					arg_20_1.var_.alphaOldValueB13 = var_23_31.color.a
					arg_20_1.var_.alphaMatValueB13 = var_23_31
				end

				arg_20_1.var_.alphaOldValueB13 = 1
			end

			local var_23_32 = 1.5

			if var_23_30 <= arg_20_1.time_ and arg_20_1.time_ < var_23_30 + var_23_32 then
				local var_23_33 = (arg_20_1.time_ - var_23_30) / var_23_32
				local var_23_34 = Mathf.Lerp(arg_20_1.var_.alphaOldValueB13, 0, var_23_33)

				if arg_20_1.var_.alphaMatValueB13 then
					local var_23_35 = arg_20_1.var_.alphaMatValueB13.color

					var_23_35.a = var_23_34
					arg_20_1.var_.alphaMatValueB13.color = var_23_35
				end
			end

			if arg_20_1.time_ >= var_23_30 + var_23_32 and arg_20_1.time_ < var_23_30 + var_23_32 + arg_23_0 and arg_20_1.var_.alphaMatValueB13 then
				local var_23_36 = arg_20_1.var_.alphaMatValueB13
				local var_23_37 = var_23_36.color

				var_23_37.a = 0
				var_23_36.color = var_23_37
			end

			local var_23_38 = 0

			if var_23_38 < arg_20_1.time_ and arg_20_1.time_ <= var_23_38 + arg_23_0 then
				arg_20_1.allBtn_.enabled = false
			end

			local var_23_39 = 3

			if arg_20_1.time_ >= var_23_38 + var_23_39 and arg_20_1.time_ < var_23_38 + var_23_39 + arg_23_0 then
				arg_20_1.allBtn_.enabled = true
			end

			local var_23_40 = 3
			local var_23_41 = 0.625

			if var_23_40 < arg_20_1.time_ and arg_20_1.time_ <= var_23_40 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				local var_23_42 = arg_20_1:FormatText(StoryNameCfg[29].name)

				arg_20_1.leftNameTxt_.text = var_23_42

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_43 = arg_20_1:GetWordFromCfg(104101005)
				local var_23_44 = arg_20_1:FormatText(var_23_43.content)

				arg_20_1.text_.text = var_23_44

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_45 = 25
				local var_23_46 = utf8.len(var_23_44)
				local var_23_47 = var_23_45 <= 0 and var_23_41 or var_23_41 * (var_23_46 / var_23_45)

				if var_23_47 > 0 and var_23_41 < var_23_47 then
					arg_20_1.talkMaxDuration = var_23_47

					if var_23_47 + var_23_40 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_47 + var_23_40
					end
				end

				arg_20_1.text_.text = var_23_44
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104101", "104101005", "story_v_out_104101.awb") ~= 0 then
					local var_23_48 = manager.audio:GetVoiceLength("story_v_out_104101", "104101005", "story_v_out_104101.awb") / 1000

					if var_23_48 + var_23_40 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_48 + var_23_40
					end

					if var_23_43.prefab_name ~= "" and arg_20_1.actors_[var_23_43.prefab_name] ~= nil then
						local var_23_49 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_43.prefab_name].transform, "story_v_out_104101", "104101005", "story_v_out_104101.awb")

						arg_20_1:RecordAudio("104101005", var_23_49)
						arg_20_1:RecordAudio("104101005", var_23_49)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_104101", "104101005", "story_v_out_104101.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_104101", "104101005", "story_v_out_104101.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_50 = math.max(var_23_41, arg_20_1.talkMaxDuration)

			if var_23_40 <= arg_20_1.time_ and arg_20_1.time_ < var_23_40 + var_23_50 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_40) / var_23_50

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_40 + var_23_50 and arg_20_1.time_ < var_23_40 + var_23_50 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play104101006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 104101006
		arg_24_1.duration_ = 5

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play104101007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = "2019_tpose"

			if arg_24_1.actors_[var_27_0] == nil then
				local var_27_1 = Asset.Load("Char/" .. "2019_tpose")

				if not isNil(var_27_1) then
					local var_27_2 = Object.Instantiate(Asset.Load("Char/" .. "2019_tpose"), arg_24_1.stage_.transform)

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

			local var_27_5 = arg_24_1.actors_["2019_tpose"]
			local var_27_6 = 0

			if var_27_6 < arg_24_1.time_ and arg_24_1.time_ <= var_27_6 + arg_27_0 and not isNil(var_27_5) and arg_24_1.var_.characterEffect2019_tpose == nil then
				arg_24_1.var_.characterEffect2019_tpose = var_27_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_7 = 0.1

			if var_27_6 <= arg_24_1.time_ and arg_24_1.time_ < var_27_6 + var_27_7 and not isNil(var_27_5) then
				local var_27_8 = (arg_24_1.time_ - var_27_6) / var_27_7

				if arg_24_1.var_.characterEffect2019_tpose and not isNil(var_27_5) then
					local var_27_9 = Mathf.Lerp(0, 0.5, var_27_8)

					arg_24_1.var_.characterEffect2019_tpose.fillFlat = true
					arg_24_1.var_.characterEffect2019_tpose.fillRatio = var_27_9
				end
			end

			if arg_24_1.time_ >= var_27_6 + var_27_7 and arg_24_1.time_ < var_27_6 + var_27_7 + arg_27_0 and not isNil(var_27_5) and arg_24_1.var_.characterEffect2019_tpose then
				local var_27_10 = 0.5

				arg_24_1.var_.characterEffect2019_tpose.fillFlat = true
				arg_24_1.var_.characterEffect2019_tpose.fillRatio = var_27_10
			end

			local var_27_11 = arg_24_1.actors_["2019_tpose"].transform
			local var_27_12 = 0

			if var_27_12 < arg_24_1.time_ and arg_24_1.time_ <= var_27_12 + arg_27_0 then
				arg_24_1.var_.moveOldPos2019_tpose = var_27_11.localPosition

				local var_27_13 = GameObjectTools.GetOrAddComponent(var_27_11.gameObject, typeof(DynamicBoneHelper))

				if var_27_13 then
					var_27_13:EnableDynamicBone(false)
				end
			end

			local var_27_14 = 0.001

			if var_27_12 <= arg_24_1.time_ and arg_24_1.time_ < var_27_12 + var_27_14 then
				local var_27_15 = (arg_24_1.time_ - var_27_12) / var_27_14
				local var_27_16 = Vector3.New(0, 100, 0)

				var_27_11.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos2019_tpose, var_27_16, var_27_15)

				local var_27_17 = manager.ui.mainCamera.transform.position - var_27_11.position

				var_27_11.forward = Vector3.New(var_27_17.x, var_27_17.y, var_27_17.z)

				local var_27_18 = var_27_11.localEulerAngles

				var_27_18.z = 0
				var_27_18.x = 0
				var_27_11.localEulerAngles = var_27_18
			end

			if arg_24_1.time_ >= var_27_12 + var_27_14 and arg_24_1.time_ < var_27_12 + var_27_14 + arg_27_0 then
				var_27_11.localPosition = Vector3.New(0, 100, 0)

				local var_27_19 = manager.ui.mainCamera.transform.position - var_27_11.position

				var_27_11.forward = Vector3.New(var_27_19.x, var_27_19.y, var_27_19.z)

				local var_27_20 = var_27_11.localEulerAngles

				var_27_20.z = 0
				var_27_20.x = 0
				var_27_11.localEulerAngles = var_27_20

				local var_27_21 = GameObjectTools.GetOrAddComponent(var_27_11.gameObject, typeof(DynamicBoneHelper))

				if var_27_21 then
					var_27_21:EnableDynamicBone(true)
				end
			end

			local var_27_22 = 0
			local var_27_23 = 0.1

			if var_27_22 < arg_24_1.time_ and arg_24_1.time_ <= var_27_22 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				local var_27_24 = arg_24_1:FormatText(StoryNameCfg[7].name)

				arg_24_1.leftNameTxt_.text = var_27_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, true)
				arg_24_1.iconController_:SetSelectedState("hero")

				arg_24_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_24_1.callingController_:SetSelectedState("normal")

				arg_24_1.keyicon_.color = Color.New(1, 1, 1)
				arg_24_1.icon_.color = Color.New(1, 1, 1)

				local var_27_25 = arg_24_1:GetWordFromCfg(104101006)
				local var_27_26 = arg_24_1:FormatText(var_27_25.content)

				arg_24_1.text_.text = var_27_26

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_27 = 4
				local var_27_28 = utf8.len(var_27_26)
				local var_27_29 = var_27_27 <= 0 and var_27_23 or var_27_23 * (var_27_28 / var_27_27)

				if var_27_29 > 0 and var_27_23 < var_27_29 then
					arg_24_1.talkMaxDuration = var_27_29

					if var_27_29 + var_27_22 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_29 + var_27_22
					end
				end

				arg_24_1.text_.text = var_27_26
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)
				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_30 = math.max(var_27_23, arg_24_1.talkMaxDuration)

			if var_27_22 <= arg_24_1.time_ and arg_24_1.time_ < var_27_22 + var_27_30 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_22) / var_27_30

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_22 + var_27_30 and arg_24_1.time_ < var_27_22 + var_27_30 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2019_tpose",
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
	Play104101007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 104101007
		arg_28_1.duration_ = 5

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play104101008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = 0
			local var_31_1 = 1.025

			if var_31_0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_0 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, false)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_2 = arg_28_1:GetWordFromCfg(104101007)
				local var_31_3 = arg_28_1:FormatText(var_31_2.content)

				arg_28_1.text_.text = var_31_3

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_4 = 41
				local var_31_5 = utf8.len(var_31_3)
				local var_31_6 = var_31_4 <= 0 and var_31_1 or var_31_1 * (var_31_5 / var_31_4)

				if var_31_6 > 0 and var_31_1 < var_31_6 then
					arg_28_1.talkMaxDuration = var_31_6

					if var_31_6 + var_31_0 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_6 + var_31_0
					end
				end

				arg_28_1.text_.text = var_31_3
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)
				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_7 = math.max(var_31_1, arg_28_1.talkMaxDuration)

			if var_31_0 <= arg_28_1.time_ and arg_28_1.time_ < var_31_0 + var_31_7 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_0) / var_31_7

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_0 + var_31_7 and arg_28_1.time_ < var_31_0 + var_31_7 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play104101008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 104101008
		arg_32_1.duration_ = 8.8

		local var_32_0 = {
			ja = 8.8,
			ko = 5.5,
			zh = 5.733,
			en = 7.3
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
				arg_32_0:Play104101009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = 0
			local var_35_1 = 0.675

			if var_35_0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_0 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				local var_35_2 = arg_32_1:FormatText(StoryNameCfg[10].name)

				arg_32_1.leftNameTxt_.text = var_35_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, true)
				arg_32_1.iconController_:SetSelectedState("hero")

				arg_32_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_32_1.callingController_:SetSelectedState("normal")

				arg_32_1.keyicon_.color = Color.New(1, 1, 1)
				arg_32_1.icon_.color = Color.New(1, 1, 1)

				local var_35_3 = arg_32_1:GetWordFromCfg(104101008)
				local var_35_4 = arg_32_1:FormatText(var_35_3.content)

				arg_32_1.text_.text = var_35_4

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_5 = 27
				local var_35_6 = utf8.len(var_35_4)
				local var_35_7 = var_35_5 <= 0 and var_35_1 or var_35_1 * (var_35_6 / var_35_5)

				if var_35_7 > 0 and var_35_1 < var_35_7 then
					arg_32_1.talkMaxDuration = var_35_7

					if var_35_7 + var_35_0 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_7 + var_35_0
					end
				end

				arg_32_1.text_.text = var_35_4
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104101", "104101008", "story_v_out_104101.awb") ~= 0 then
					local var_35_8 = manager.audio:GetVoiceLength("story_v_out_104101", "104101008", "story_v_out_104101.awb") / 1000

					if var_35_8 + var_35_0 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_8 + var_35_0
					end

					if var_35_3.prefab_name ~= "" and arg_32_1.actors_[var_35_3.prefab_name] ~= nil then
						local var_35_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_3.prefab_name].transform, "story_v_out_104101", "104101008", "story_v_out_104101.awb")

						arg_32_1:RecordAudio("104101008", var_35_9)
						arg_32_1:RecordAudio("104101008", var_35_9)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_104101", "104101008", "story_v_out_104101.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_104101", "104101008", "story_v_out_104101.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_10 = math.max(var_35_1, arg_32_1.talkMaxDuration)

			if var_35_0 <= arg_32_1.time_ and arg_32_1.time_ < var_35_0 + var_35_10 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_0) / var_35_10

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_0 + var_35_10 and arg_32_1.time_ < var_35_0 + var_35_10 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play104101009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 104101009
		arg_36_1.duration_ = 8.83

		local var_36_0 = {
			ja = 3.8,
			ko = 8.3,
			zh = 8.833,
			en = 7.733
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
				arg_36_0:Play104101010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = 0
			local var_39_1 = 1

			if var_39_0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_0 + arg_39_0 then
				local var_39_2 = "play"
				local var_39_3 = "effect"

				arg_36_1:AudioAction(var_39_2, var_39_3, "se_story", "se_story_robot_long", "")
			end

			local var_39_4 = 0
			local var_39_5 = 0.575

			if var_39_4 < arg_36_1.time_ and arg_36_1.time_ <= var_39_4 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				local var_39_6 = arg_36_1:FormatText(StoryNameCfg[29].name)

				arg_36_1.leftNameTxt_.text = var_39_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_7 = arg_36_1:GetWordFromCfg(104101009)
				local var_39_8 = arg_36_1:FormatText(var_39_7.content)

				arg_36_1.text_.text = var_39_8

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_9 = 23
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

				if manager.audio:GetVoiceLength("story_v_out_104101", "104101009", "story_v_out_104101.awb") ~= 0 then
					local var_39_12 = manager.audio:GetVoiceLength("story_v_out_104101", "104101009", "story_v_out_104101.awb") / 1000

					if var_39_12 + var_39_4 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_12 + var_39_4
					end

					if var_39_7.prefab_name ~= "" and arg_36_1.actors_[var_39_7.prefab_name] ~= nil then
						local var_39_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_7.prefab_name].transform, "story_v_out_104101", "104101009", "story_v_out_104101.awb")

						arg_36_1:RecordAudio("104101009", var_39_13)
						arg_36_1:RecordAudio("104101009", var_39_13)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_104101", "104101009", "story_v_out_104101.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_104101", "104101009", "story_v_out_104101.awb")
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
	Play104101010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 104101010
		arg_40_1.duration_ = 0.1

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"

			SetActive(arg_40_1.choicesGo_, true)

			for iter_41_0, iter_41_1 in ipairs(arg_40_1.choices_) do
				local var_41_0 = iter_41_0 <= 1

				SetActive(iter_41_1.go, var_41_0)
			end

			arg_40_1.choices_[1].txt.text = arg_40_1:FormatText(StoryChoiceCfg[27].name)
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play104101011(arg_40_1)
			end

			arg_40_1:RecordChoiceLog(104101010, 27)
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			return
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play104101011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 104101011
		arg_44_1.duration_ = 5

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play104101012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = 0
			local var_47_1 = 1

			if var_47_0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_0 + arg_47_0 then
				local var_47_2 = "play"
				local var_47_3 = "effect"

				arg_44_1:AudioAction(var_47_2, var_47_3, "se_story", "se_story_fight_normalgun", "")
			end

			local var_47_4 = 0

			if var_47_4 < arg_44_1.time_ and arg_44_1.time_ <= var_47_4 + arg_47_0 then
				arg_44_1.mask_.enabled = true
				arg_44_1.mask_.raycastTarget = true

				arg_44_1:SetGaussion(false)
			end

			local var_47_5 = 0.5

			if var_47_4 <= arg_44_1.time_ and arg_44_1.time_ < var_47_4 + var_47_5 then
				local var_47_6 = (arg_44_1.time_ - var_47_4) / var_47_5
				local var_47_7 = Color.New(1, 1, 1)

				var_47_7.a = Mathf.Lerp(1, 0, var_47_6)
				arg_44_1.mask_.color = var_47_7
			end

			if arg_44_1.time_ >= var_47_4 + var_47_5 and arg_44_1.time_ < var_47_4 + var_47_5 + arg_47_0 then
				local var_47_8 = Color.New(1, 1, 1)
				local var_47_9 = 0

				arg_44_1.mask_.enabled = false
				var_47_8.a = var_47_9
				arg_44_1.mask_.color = var_47_8
			end

			local var_47_10 = manager.ui.mainCamera.transform
			local var_47_11 = 0

			if var_47_11 < arg_44_1.time_ and arg_44_1.time_ <= var_47_11 + arg_47_0 then
				arg_44_1.var_.shakeOldPosMainCamera = var_47_10.localPosition
			end

			local var_47_12 = 0.600000023841858

			if var_47_11 <= arg_44_1.time_ and arg_44_1.time_ < var_47_11 + var_47_12 then
				local var_47_13 = (arg_44_1.time_ - var_47_11) / 0.066
				local var_47_14, var_47_15 = math.modf(var_47_13)

				var_47_10.localPosition = Vector3.New(var_47_15 * 0.13, var_47_15 * 0.13, var_47_15 * 0.13) + arg_44_1.var_.shakeOldPosMainCamera
			end

			if arg_44_1.time_ >= var_47_11 + var_47_12 and arg_44_1.time_ < var_47_11 + var_47_12 + arg_47_0 then
				var_47_10.localPosition = arg_44_1.var_.shakeOldPosMainCamera
			end

			local var_47_16 = "S0408a"

			if arg_44_1.bgs_[var_47_16] == nil then
				local var_47_17 = Object.Instantiate(arg_44_1.paintGo_)

				var_47_17:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_47_16)
				var_47_17.name = var_47_16
				var_47_17.transform.parent = arg_44_1.stage_.transform
				var_47_17.transform.localPosition = Vector3.New(0, 100, 0)
				arg_44_1.bgs_[var_47_16] = var_47_17
			end

			local var_47_18 = 0

			if var_47_18 < arg_44_1.time_ and arg_44_1.time_ <= var_47_18 + arg_47_0 then
				local var_47_19 = manager.ui.mainCamera.transform.localPosition
				local var_47_20 = Vector3.New(0, 0, 10) + Vector3.New(var_47_19.x, var_47_19.y, 0)
				local var_47_21 = arg_44_1.bgs_.S0408a

				var_47_21.transform.localPosition = var_47_20
				var_47_21.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_47_22 = var_47_21:GetComponent("SpriteRenderer")

				if var_47_22 and var_47_22.sprite then
					local var_47_23 = (var_47_21.transform.localPosition - var_47_19).z
					local var_47_24 = manager.ui.mainCameraCom_
					local var_47_25 = 2 * var_47_23 * Mathf.Tan(var_47_24.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_47_26 = var_47_25 * var_47_24.aspect
					local var_47_27 = var_47_22.sprite.bounds.size.x
					local var_47_28 = var_47_22.sprite.bounds.size.y
					local var_47_29 = var_47_26 / var_47_27
					local var_47_30 = var_47_25 / var_47_28
					local var_47_31 = var_47_30 < var_47_29 and var_47_29 or var_47_30

					var_47_21.transform.localScale = Vector3.New(var_47_31, var_47_31, 0)
				end

				for iter_47_0, iter_47_1 in pairs(arg_44_1.bgs_) do
					if iter_47_0 ~= "S0408a" then
						iter_47_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_47_32 = 0
			local var_47_33 = 0.1

			if var_47_32 < arg_44_1.time_ and arg_44_1.time_ <= var_47_32 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				local var_47_34 = arg_44_1:FormatText(StoryNameCfg[64].name)

				arg_44_1.leftNameTxt_.text = var_47_34

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_35 = arg_44_1:GetWordFromCfg(104101011)
				local var_47_36 = arg_44_1:FormatText(var_47_35.content)

				arg_44_1.text_.text = var_47_36

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_37 = 4
				local var_47_38 = utf8.len(var_47_36)
				local var_47_39 = var_47_37 <= 0 and var_47_33 or var_47_33 * (var_47_38 / var_47_37)

				if var_47_39 > 0 and var_47_33 < var_47_39 then
					arg_44_1.talkMaxDuration = var_47_39

					if var_47_39 + var_47_32 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_39 + var_47_32
					end
				end

				arg_44_1.text_.text = var_47_36
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)
				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_40 = math.max(var_47_33, arg_44_1.talkMaxDuration)

			if var_47_32 <= arg_44_1.time_ and arg_44_1.time_ < var_47_32 + var_47_40 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_32) / var_47_40

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_32 + var_47_40 and arg_44_1.time_ < var_47_32 + var_47_40 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play104101012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 104101012
		arg_48_1.duration_ = 5

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play104101013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = 0
			local var_51_1 = 1

			if var_51_0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_0 + arg_51_0 then
				local var_51_2 = "play"
				local var_51_3 = "effect"

				arg_48_1:AudioAction(var_51_2, var_51_3, "se_story", "se_story_robot_short", "")
			end

			local var_51_4 = 0
			local var_51_5 = 0.3

			if var_51_4 < arg_48_1.time_ and arg_48_1.time_ <= var_51_4 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				local var_51_6 = arg_48_1:FormatText(StoryNameCfg[29].name)

				arg_48_1.leftNameTxt_.text = var_51_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_7 = arg_48_1:GetWordFromCfg(104101012)
				local var_51_8 = arg_48_1:FormatText(var_51_7.content)

				arg_48_1.text_.text = var_51_8

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_9 = 12
				local var_51_10 = utf8.len(var_51_8)
				local var_51_11 = var_51_9 <= 0 and var_51_5 or var_51_5 * (var_51_10 / var_51_9)

				if var_51_11 > 0 and var_51_5 < var_51_11 then
					arg_48_1.talkMaxDuration = var_51_11

					if var_51_11 + var_51_4 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_11 + var_51_4
					end
				end

				arg_48_1.text_.text = var_51_8
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)
				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_12 = math.max(var_51_5, arg_48_1.talkMaxDuration)

			if var_51_4 <= arg_48_1.time_ and arg_48_1.time_ < var_51_4 + var_51_12 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_4) / var_51_12

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_4 + var_51_12 and arg_48_1.time_ < var_51_4 + var_51_12 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play104101013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 104101013
		arg_52_1.duration_ = 5

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play104101014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = 0
			local var_55_1 = 0.325

			if var_55_0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_0 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				local var_55_2 = arg_52_1:FormatText(StoryNameCfg[7].name)

				arg_52_1.leftNameTxt_.text = var_55_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, true)
				arg_52_1.iconController_:SetSelectedState("hero")

				arg_52_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_52_1.callingController_:SetSelectedState("normal")

				arg_52_1.keyicon_.color = Color.New(1, 1, 1)
				arg_52_1.icon_.color = Color.New(1, 1, 1)

				local var_55_3 = arg_52_1:GetWordFromCfg(104101013)
				local var_55_4 = arg_52_1:FormatText(var_55_3.content)

				arg_52_1.text_.text = var_55_4

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_5 = 13
				local var_55_6 = utf8.len(var_55_4)
				local var_55_7 = var_55_5 <= 0 and var_55_1 or var_55_1 * (var_55_6 / var_55_5)

				if var_55_7 > 0 and var_55_1 < var_55_7 then
					arg_52_1.talkMaxDuration = var_55_7

					if var_55_7 + var_55_0 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_7 + var_55_0
					end
				end

				arg_52_1.text_.text = var_55_4
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)
				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_8 = math.max(var_55_1, arg_52_1.talkMaxDuration)

			if var_55_0 <= arg_52_1.time_ and arg_52_1.time_ < var_55_0 + var_55_8 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_0) / var_55_8

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_0 + var_55_8 and arg_52_1.time_ < var_55_0 + var_55_8 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play104101014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 104101014
		arg_56_1.duration_ = 6.8

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play104101015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = 1.5

			if var_59_0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_0 + arg_59_0 then
				local var_59_1 = manager.ui.mainCamera.transform.localPosition
				local var_59_2 = Vector3.New(0, 0, 10) + Vector3.New(var_59_1.x, var_59_1.y, 0)
				local var_59_3 = arg_56_1.bgs_.B13

				var_59_3.transform.localPosition = var_59_2
				var_59_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_59_4 = var_59_3:GetComponent("SpriteRenderer")

				if var_59_4 and var_59_4.sprite then
					local var_59_5 = (var_59_3.transform.localPosition - var_59_1).z
					local var_59_6 = manager.ui.mainCameraCom_
					local var_59_7 = 2 * var_59_5 * Mathf.Tan(var_59_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_59_8 = var_59_7 * var_59_6.aspect
					local var_59_9 = var_59_4.sprite.bounds.size.x
					local var_59_10 = var_59_4.sprite.bounds.size.y
					local var_59_11 = var_59_8 / var_59_9
					local var_59_12 = var_59_7 / var_59_10
					local var_59_13 = var_59_12 < var_59_11 and var_59_11 or var_59_12

					var_59_3.transform.localScale = Vector3.New(var_59_13, var_59_13, 0)
				end

				for iter_59_0, iter_59_1 in pairs(arg_56_1.bgs_) do
					if iter_59_0 ~= "B13" then
						iter_59_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_59_14 = arg_56_1.bgs_.S0408a
			local var_59_15 = 0

			if var_59_15 < arg_56_1.time_ and arg_56_1.time_ <= var_59_15 + arg_59_0 then
				local var_59_16 = var_59_14:GetComponent("SpriteRenderer")

				if var_59_16 then
					arg_56_1.var_.alphaOldValueS0408a = var_59_16.color.a
					arg_56_1.var_.alphaMatValueS0408a = var_59_16
				end

				arg_56_1.var_.alphaOldValueS0408a = 1
			end

			local var_59_17 = 1.5

			if var_59_15 <= arg_56_1.time_ and arg_56_1.time_ < var_59_15 + var_59_17 then
				local var_59_18 = (arg_56_1.time_ - var_59_15) / var_59_17
				local var_59_19 = Mathf.Lerp(arg_56_1.var_.alphaOldValueS0408a, 0, var_59_18)

				if arg_56_1.var_.alphaMatValueS0408a then
					local var_59_20 = arg_56_1.var_.alphaMatValueS0408a.color

					var_59_20.a = var_59_19
					arg_56_1.var_.alphaMatValueS0408a.color = var_59_20
				end
			end

			if arg_56_1.time_ >= var_59_15 + var_59_17 and arg_56_1.time_ < var_59_15 + var_59_17 + arg_59_0 and arg_56_1.var_.alphaMatValueS0408a then
				local var_59_21 = arg_56_1.var_.alphaMatValueS0408a
				local var_59_22 = var_59_21.color

				var_59_22.a = 0
				var_59_21.color = var_59_22
			end

			local var_59_23 = arg_56_1.bgs_.B13
			local var_59_24 = 1.5

			if var_59_24 < arg_56_1.time_ and arg_56_1.time_ <= var_59_24 + arg_59_0 then
				local var_59_25 = var_59_23:GetComponent("SpriteRenderer")

				if var_59_25 then
					arg_56_1.var_.alphaOldValueB13 = var_59_25.color.a
					arg_56_1.var_.alphaMatValueB13 = var_59_25
				end

				arg_56_1.var_.alphaOldValueB13 = 0
			end

			local var_59_26 = 1.5

			if var_59_24 <= arg_56_1.time_ and arg_56_1.time_ < var_59_24 + var_59_26 then
				local var_59_27 = (arg_56_1.time_ - var_59_24) / var_59_26
				local var_59_28 = Mathf.Lerp(arg_56_1.var_.alphaOldValueB13, 1, var_59_27)

				if arg_56_1.var_.alphaMatValueB13 then
					local var_59_29 = arg_56_1.var_.alphaMatValueB13.color

					var_59_29.a = var_59_28
					arg_56_1.var_.alphaMatValueB13.color = var_59_29
				end
			end

			if arg_56_1.time_ >= var_59_24 + var_59_26 and arg_56_1.time_ < var_59_24 + var_59_26 + arg_59_0 and arg_56_1.var_.alphaMatValueB13 then
				local var_59_30 = arg_56_1.var_.alphaMatValueB13
				local var_59_31 = var_59_30.color

				var_59_31.a = 1
				var_59_30.color = var_59_31
			end

			local var_59_32 = arg_56_1.bgs_.S0408a.transform
			local var_59_33 = 1.5

			if var_59_33 < arg_56_1.time_ and arg_56_1.time_ <= var_59_33 + arg_59_0 then
				arg_56_1.var_.moveOldPosS0408a = var_59_32.localPosition
			end

			local var_59_34 = 0.1

			if var_59_33 <= arg_56_1.time_ and arg_56_1.time_ < var_59_33 + var_59_34 then
				local var_59_35 = (arg_56_1.time_ - var_59_33) / var_59_34
				local var_59_36 = Vector3.New(0, -100, 0)

				var_59_32.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPosS0408a, var_59_36, var_59_35)
			end

			if arg_56_1.time_ >= var_59_33 + var_59_34 and arg_56_1.time_ < var_59_33 + var_59_34 + arg_59_0 then
				var_59_32.localPosition = Vector3.New(0, -100, 0)
			end

			local var_59_37 = 0

			if var_59_37 < arg_56_1.time_ and arg_56_1.time_ <= var_59_37 + arg_59_0 then
				arg_56_1.allBtn_.enabled = false
			end

			local var_59_38 = 1.8

			if arg_56_1.time_ >= var_59_37 + var_59_38 and arg_56_1.time_ < var_59_37 + var_59_38 + arg_59_0 then
				arg_56_1.allBtn_.enabled = true
			end

			if arg_56_1.frameCnt_ <= 1 then
				arg_56_1.dialog_:SetActive(false)
			end

			local var_59_39 = 1.8
			local var_59_40 = 0.2

			if var_59_39 < arg_56_1.time_ and arg_56_1.time_ <= var_59_39 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0

				arg_56_1.dialog_:SetActive(true)

				arg_56_1.dialogCg_.alpha = 0

				local var_59_41 = LeanTween.value(arg_56_1.dialog_, 0, 1, 0.3)

				var_59_41:setOnUpdate(LuaHelper.FloatAction(function(arg_60_0)
					arg_56_1.dialogCg_.alpha = arg_60_0
				end))
				var_59_41:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_56_1.dialog_)
					var_59_41:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_56_1.duration_ = arg_56_1.duration_ + 0.3

				SetActive(arg_56_1.leftNameGo_, true)

				local var_59_42 = arg_56_1:FormatText(StoryNameCfg[7].name)

				arg_56_1.leftNameTxt_.text = var_59_42

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, true)
				arg_56_1.iconController_:SetSelectedState("hero")

				arg_56_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_56_1.callingController_:SetSelectedState("normal")

				arg_56_1.keyicon_.color = Color.New(1, 1, 1)
				arg_56_1.icon_.color = Color.New(1, 1, 1)

				local var_59_43 = arg_56_1:GetWordFromCfg(104101014)
				local var_59_44 = arg_56_1:FormatText(var_59_43.content)

				arg_56_1.text_.text = var_59_44

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_45 = 8
				local var_59_46 = utf8.len(var_59_44)
				local var_59_47 = var_59_45 <= 0 and var_59_40 or var_59_40 * (var_59_46 / var_59_45)

				if var_59_47 > 0 and var_59_40 < var_59_47 then
					arg_56_1.talkMaxDuration = var_59_47
					var_59_39 = var_59_39 + 0.3

					if var_59_47 + var_59_39 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_47 + var_59_39
					end
				end

				arg_56_1.text_.text = var_59_44
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)
				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_48 = var_59_39 + 0.3
			local var_59_49 = math.max(var_59_40, arg_56_1.talkMaxDuration)

			if var_59_48 <= arg_56_1.time_ and arg_56_1.time_ < var_59_48 + var_59_49 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_48) / var_59_49

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_48 + var_59_49 and arg_56_1.time_ < var_59_48 + var_59_49 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "S0408a",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.1,
				className = "StoryMoveNode",
				startTime = 1.5,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_56_1:InitPlayNodeList()
	end,
	Play104101015 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 104101015
		arg_62_1.duration_ = 8.1

		local var_62_0 = {
			ja = 8.1,
			ko = 4.3,
			zh = 3.766,
			en = 5.133
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
				arg_62_0:Play104101016(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			local var_65_0 = "1037ui_story"

			if arg_62_1.actors_[var_65_0] == nil then
				local var_65_1 = Asset.Load("Char/" .. "1037ui_story")

				if not isNil(var_65_1) then
					local var_65_2 = Object.Instantiate(Asset.Load("Char/" .. "1037ui_story"), arg_62_1.stage_.transform)

					var_65_2.name = var_65_0
					var_65_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_62_1.actors_[var_65_0] = var_65_2

					local var_65_3 = var_65_2:GetComponentInChildren(typeof(CharacterEffect))

					var_65_3.enabled = true

					local var_65_4 = GameObjectTools.GetOrAddComponent(var_65_2, typeof(DynamicBoneHelper))

					if var_65_4 then
						var_65_4:EnableDynamicBone(false)
					end

					arg_62_1:ShowWeapon(var_65_3.transform, false)

					arg_62_1.var_[var_65_0 .. "Animator"] = var_65_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_62_1.var_[var_65_0 .. "Animator"].applyRootMotion = true
					arg_62_1.var_[var_65_0 .. "LipSync"] = var_65_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_65_5 = arg_62_1.actors_["1037ui_story"]
			local var_65_6 = 0

			if var_65_6 < arg_62_1.time_ and arg_62_1.time_ <= var_65_6 + arg_65_0 and not isNil(var_65_5) and arg_62_1.var_.characterEffect1037ui_story == nil then
				arg_62_1.var_.characterEffect1037ui_story = var_65_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_65_7 = 0.1

			if var_65_6 <= arg_62_1.time_ and arg_62_1.time_ < var_65_6 + var_65_7 and not isNil(var_65_5) then
				local var_65_8 = (arg_62_1.time_ - var_65_6) / var_65_7

				if arg_62_1.var_.characterEffect1037ui_story and not isNil(var_65_5) then
					arg_62_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_62_1.time_ >= var_65_6 + var_65_7 and arg_62_1.time_ < var_65_6 + var_65_7 + arg_65_0 and not isNil(var_65_5) and arg_62_1.var_.characterEffect1037ui_story then
				arg_62_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_65_9 = arg_62_1.actors_["1037ui_story"].transform
			local var_65_10 = 0

			if var_65_10 < arg_62_1.time_ and arg_62_1.time_ <= var_65_10 + arg_65_0 then
				arg_62_1.var_.moveOldPos1037ui_story = var_65_9.localPosition
			end

			local var_65_11 = 0.001

			if var_65_10 <= arg_62_1.time_ and arg_62_1.time_ < var_65_10 + var_65_11 then
				local var_65_12 = (arg_62_1.time_ - var_65_10) / var_65_11
				local var_65_13 = Vector3.New(0, -1.09, -5.81)

				var_65_9.localPosition = Vector3.Lerp(arg_62_1.var_.moveOldPos1037ui_story, var_65_13, var_65_12)

				local var_65_14 = manager.ui.mainCamera.transform.position - var_65_9.position

				var_65_9.forward = Vector3.New(var_65_14.x, var_65_14.y, var_65_14.z)

				local var_65_15 = var_65_9.localEulerAngles

				var_65_15.z = 0
				var_65_15.x = 0
				var_65_9.localEulerAngles = var_65_15
			end

			if arg_62_1.time_ >= var_65_10 + var_65_11 and arg_62_1.time_ < var_65_10 + var_65_11 + arg_65_0 then
				var_65_9.localPosition = Vector3.New(0, -1.09, -5.81)

				local var_65_16 = manager.ui.mainCamera.transform.position - var_65_9.position

				var_65_9.forward = Vector3.New(var_65_16.x, var_65_16.y, var_65_16.z)

				local var_65_17 = var_65_9.localEulerAngles

				var_65_17.z = 0
				var_65_17.x = 0
				var_65_9.localEulerAngles = var_65_17
			end

			local var_65_18 = 0

			if var_65_18 < arg_62_1.time_ and arg_62_1.time_ <= var_65_18 + arg_65_0 then
				arg_62_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action2_1")
			end

			local var_65_19 = 0

			if var_65_19 < arg_62_1.time_ and arg_62_1.time_ <= var_65_19 + arg_65_0 then
				arg_62_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_65_20 = 0
			local var_65_21 = 0.35

			if var_65_20 < arg_62_1.time_ and arg_62_1.time_ <= var_65_20 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, true)

				local var_65_22 = arg_62_1:FormatText(StoryNameCfg[15].name)

				arg_62_1.leftNameTxt_.text = var_65_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_62_1.leftNameTxt_.transform)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1.leftNameTxt_.text)
				SetActive(arg_62_1.iconTrs_.gameObject, false)
				arg_62_1.callingController_:SetSelectedState("normal")

				local var_65_23 = arg_62_1:GetWordFromCfg(104101015)
				local var_65_24 = arg_62_1:FormatText(var_65_23.content)

				arg_62_1.text_.text = var_65_24

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_25 = 14
				local var_65_26 = utf8.len(var_65_24)
				local var_65_27 = var_65_25 <= 0 and var_65_21 or var_65_21 * (var_65_26 / var_65_25)

				if var_65_27 > 0 and var_65_21 < var_65_27 then
					arg_62_1.talkMaxDuration = var_65_27

					if var_65_27 + var_65_20 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_27 + var_65_20
					end
				end

				arg_62_1.text_.text = var_65_24
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104101", "104101015", "story_v_out_104101.awb") ~= 0 then
					local var_65_28 = manager.audio:GetVoiceLength("story_v_out_104101", "104101015", "story_v_out_104101.awb") / 1000

					if var_65_28 + var_65_20 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_28 + var_65_20
					end

					if var_65_23.prefab_name ~= "" and arg_62_1.actors_[var_65_23.prefab_name] ~= nil then
						local var_65_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_62_1.actors_[var_65_23.prefab_name].transform, "story_v_out_104101", "104101015", "story_v_out_104101.awb")

						arg_62_1:RecordAudio("104101015", var_65_29)
						arg_62_1:RecordAudio("104101015", var_65_29)
					else
						arg_62_1:AudioAction("play", "voice", "story_v_out_104101", "104101015", "story_v_out_104101.awb")
					end

					arg_62_1:RecordHistoryTalkVoice("story_v_out_104101", "104101015", "story_v_out_104101.awb")
				end

				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_30 = math.max(var_65_21, arg_62_1.talkMaxDuration)

			if var_65_20 <= arg_62_1.time_ and arg_62_1.time_ < var_65_20 + var_65_30 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - var_65_20) / var_65_30

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= var_65_20 + var_65_30 and arg_62_1.time_ < var_65_20 + var_65_30 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_62_1:InitPlayNodeList()
	end,
	Play104101016 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 104101016
		arg_66_1.duration_ = 5

		SetActive(arg_66_1.tipsGo_, false)

		function arg_66_1.onSingleLineFinish_()
			arg_66_1.onSingleLineUpdate_ = nil
			arg_66_1.onSingleLineFinish_ = nil
			arg_66_1.state_ = "waiting"
		end

		function arg_66_1.playNext_(arg_68_0)
			if arg_68_0 == 1 then
				arg_66_0:Play104101017(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			local var_69_0 = arg_66_1.actors_["1037ui_story"]
			local var_69_1 = 0

			if var_69_1 < arg_66_1.time_ and arg_66_1.time_ <= var_69_1 + arg_69_0 and not isNil(var_69_0) and arg_66_1.var_.characterEffect1037ui_story == nil then
				arg_66_1.var_.characterEffect1037ui_story = var_69_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_69_2 = 0.1

			if var_69_1 <= arg_66_1.time_ and arg_66_1.time_ < var_69_1 + var_69_2 and not isNil(var_69_0) then
				local var_69_3 = (arg_66_1.time_ - var_69_1) / var_69_2

				if arg_66_1.var_.characterEffect1037ui_story and not isNil(var_69_0) then
					local var_69_4 = Mathf.Lerp(0, 0.5, var_69_3)

					arg_66_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_66_1.var_.characterEffect1037ui_story.fillRatio = var_69_4
				end
			end

			if arg_66_1.time_ >= var_69_1 + var_69_2 and arg_66_1.time_ < var_69_1 + var_69_2 + arg_69_0 and not isNil(var_69_0) and arg_66_1.var_.characterEffect1037ui_story then
				local var_69_5 = 0.5

				arg_66_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_66_1.var_.characterEffect1037ui_story.fillRatio = var_69_5
			end

			local var_69_6 = 0
			local var_69_7 = 0.9

			if var_69_6 < arg_66_1.time_ and arg_66_1.time_ <= var_69_6 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				local var_69_8 = arg_66_1:FormatText(StoryNameCfg[7].name)

				arg_66_1.leftNameTxt_.text = var_69_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, true)
				arg_66_1.iconController_:SetSelectedState("hero")

				arg_66_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_66_1.callingController_:SetSelectedState("normal")

				arg_66_1.keyicon_.color = Color.New(1, 1, 1)
				arg_66_1.icon_.color = Color.New(1, 1, 1)

				local var_69_9 = arg_66_1:GetWordFromCfg(104101016)
				local var_69_10 = arg_66_1:FormatText(var_69_9.content)

				arg_66_1.text_.text = var_69_10

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_11 = 36
				local var_69_12 = utf8.len(var_69_10)
				local var_69_13 = var_69_11 <= 0 and var_69_7 or var_69_7 * (var_69_12 / var_69_11)

				if var_69_13 > 0 and var_69_7 < var_69_13 then
					arg_66_1.talkMaxDuration = var_69_13

					if var_69_13 + var_69_6 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_13 + var_69_6
					end
				end

				arg_66_1.text_.text = var_69_10
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)
				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_14 = math.max(var_69_7, arg_66_1.talkMaxDuration)

			if var_69_6 <= arg_66_1.time_ and arg_66_1.time_ < var_69_6 + var_69_14 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_6) / var_69_14

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_6 + var_69_14 and arg_66_1.time_ < var_69_6 + var_69_14 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {}

		arg_66_1:InitPlayNodeList()
	end,
	Play104101017 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 104101017
		arg_70_1.duration_ = 3.13

		local var_70_0 = {
			ja = 3.133,
			ko = 1.999999999999,
			zh = 1.999999999999,
			en = 2.2
		}
		local var_70_1 = manager.audio:GetLocalizationFlag()

		if var_70_0[var_70_1] ~= nil then
			arg_70_1.duration_ = var_70_0[var_70_1]
		end

		SetActive(arg_70_1.tipsGo_, false)

		function arg_70_1.onSingleLineFinish_()
			arg_70_1.onSingleLineUpdate_ = nil
			arg_70_1.onSingleLineFinish_ = nil
			arg_70_1.state_ = "waiting"
		end

		function arg_70_1.playNext_(arg_72_0)
			if arg_72_0 == 1 then
				arg_70_0:Play104101018(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			local var_73_0 = arg_70_1.actors_["1037ui_story"]
			local var_73_1 = 0

			if var_73_1 < arg_70_1.time_ and arg_70_1.time_ <= var_73_1 + arg_73_0 and not isNil(var_73_0) and arg_70_1.var_.characterEffect1037ui_story == nil then
				arg_70_1.var_.characterEffect1037ui_story = var_73_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_73_2 = 0.1

			if var_73_1 <= arg_70_1.time_ and arg_70_1.time_ < var_73_1 + var_73_2 and not isNil(var_73_0) then
				local var_73_3 = (arg_70_1.time_ - var_73_1) / var_73_2

				if arg_70_1.var_.characterEffect1037ui_story and not isNil(var_73_0) then
					arg_70_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_70_1.time_ >= var_73_1 + var_73_2 and arg_70_1.time_ < var_73_1 + var_73_2 + arg_73_0 and not isNil(var_73_0) and arg_70_1.var_.characterEffect1037ui_story then
				arg_70_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_73_4 = 0

			if var_73_4 < arg_70_1.time_ and arg_70_1.time_ <= var_73_4 + arg_73_0 then
				arg_70_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action2_2")
			end

			local var_73_5 = 0

			if var_73_5 < arg_70_1.time_ and arg_70_1.time_ <= var_73_5 + arg_73_0 then
				arg_70_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_73_6 = 0
			local var_73_7 = 0.125

			if var_73_6 < arg_70_1.time_ and arg_70_1.time_ <= var_73_6 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, true)

				local var_73_8 = arg_70_1:FormatText(StoryNameCfg[15].name)

				arg_70_1.leftNameTxt_.text = var_73_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_70_1.leftNameTxt_.transform)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1.leftNameTxt_.text)
				SetActive(arg_70_1.iconTrs_.gameObject, false)
				arg_70_1.callingController_:SetSelectedState("normal")

				local var_73_9 = arg_70_1:GetWordFromCfg(104101017)
				local var_73_10 = arg_70_1:FormatText(var_73_9.content)

				arg_70_1.text_.text = var_73_10

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_11 = 5
				local var_73_12 = utf8.len(var_73_10)
				local var_73_13 = var_73_11 <= 0 and var_73_7 or var_73_7 * (var_73_12 / var_73_11)

				if var_73_13 > 0 and var_73_7 < var_73_13 then
					arg_70_1.talkMaxDuration = var_73_13

					if var_73_13 + var_73_6 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_13 + var_73_6
					end
				end

				arg_70_1.text_.text = var_73_10
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104101", "104101017", "story_v_out_104101.awb") ~= 0 then
					local var_73_14 = manager.audio:GetVoiceLength("story_v_out_104101", "104101017", "story_v_out_104101.awb") / 1000

					if var_73_14 + var_73_6 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_14 + var_73_6
					end

					if var_73_9.prefab_name ~= "" and arg_70_1.actors_[var_73_9.prefab_name] ~= nil then
						local var_73_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_70_1.actors_[var_73_9.prefab_name].transform, "story_v_out_104101", "104101017", "story_v_out_104101.awb")

						arg_70_1:RecordAudio("104101017", var_73_15)
						arg_70_1:RecordAudio("104101017", var_73_15)
					else
						arg_70_1:AudioAction("play", "voice", "story_v_out_104101", "104101017", "story_v_out_104101.awb")
					end

					arg_70_1:RecordHistoryTalkVoice("story_v_out_104101", "104101017", "story_v_out_104101.awb")
				end

				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_16 = math.max(var_73_7, arg_70_1.talkMaxDuration)

			if var_73_6 <= arg_70_1.time_ and arg_70_1.time_ < var_73_6 + var_73_16 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_6) / var_73_16

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_6 + var_73_16 and arg_70_1.time_ < var_73_6 + var_73_16 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {}

		arg_70_1:InitPlayNodeList()
	end,
	Play104101018 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 104101018
		arg_74_1.duration_ = 11.03

		local var_74_0 = {
			ja = 9.8,
			ko = 6.9,
			zh = 8.3,
			en = 11.033
		}
		local var_74_1 = manager.audio:GetLocalizationFlag()

		if var_74_0[var_74_1] ~= nil then
			arg_74_1.duration_ = var_74_0[var_74_1]
		end

		SetActive(arg_74_1.tipsGo_, false)

		function arg_74_1.onSingleLineFinish_()
			arg_74_1.onSingleLineUpdate_ = nil
			arg_74_1.onSingleLineFinish_ = nil
			arg_74_1.state_ = "waiting"
		end

		function arg_74_1.playNext_(arg_76_0)
			if arg_76_0 == 1 then
				arg_74_0:Play104101019(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			local var_77_0 = 0

			if var_77_0 < arg_74_1.time_ and arg_74_1.time_ <= var_77_0 + arg_77_0 then
				arg_74_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_77_1 = 0
			local var_77_2 = 0.975

			if var_77_1 < arg_74_1.time_ and arg_74_1.time_ <= var_77_1 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, true)

				local var_77_3 = arg_74_1:FormatText(StoryNameCfg[15].name)

				arg_74_1.leftNameTxt_.text = var_77_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_74_1.leftNameTxt_.transform)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1.leftNameTxt_.text)
				SetActive(arg_74_1.iconTrs_.gameObject, false)
				arg_74_1.callingController_:SetSelectedState("normal")

				local var_77_4 = arg_74_1:GetWordFromCfg(104101018)
				local var_77_5 = arg_74_1:FormatText(var_77_4.content)

				arg_74_1.text_.text = var_77_5

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_6 = 39
				local var_77_7 = utf8.len(var_77_5)
				local var_77_8 = var_77_6 <= 0 and var_77_2 or var_77_2 * (var_77_7 / var_77_6)

				if var_77_8 > 0 and var_77_2 < var_77_8 then
					arg_74_1.talkMaxDuration = var_77_8

					if var_77_8 + var_77_1 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_8 + var_77_1
					end
				end

				arg_74_1.text_.text = var_77_5
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104101", "104101018", "story_v_out_104101.awb") ~= 0 then
					local var_77_9 = manager.audio:GetVoiceLength("story_v_out_104101", "104101018", "story_v_out_104101.awb") / 1000

					if var_77_9 + var_77_1 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_9 + var_77_1
					end

					if var_77_4.prefab_name ~= "" and arg_74_1.actors_[var_77_4.prefab_name] ~= nil then
						local var_77_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_74_1.actors_[var_77_4.prefab_name].transform, "story_v_out_104101", "104101018", "story_v_out_104101.awb")

						arg_74_1:RecordAudio("104101018", var_77_10)
						arg_74_1:RecordAudio("104101018", var_77_10)
					else
						arg_74_1:AudioAction("play", "voice", "story_v_out_104101", "104101018", "story_v_out_104101.awb")
					end

					arg_74_1:RecordHistoryTalkVoice("story_v_out_104101", "104101018", "story_v_out_104101.awb")
				end

				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_11 = math.max(var_77_2, arg_74_1.talkMaxDuration)

			if var_77_1 <= arg_74_1.time_ and arg_74_1.time_ < var_77_1 + var_77_11 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_1) / var_77_11

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_1 + var_77_11 and arg_74_1.time_ < var_77_1 + var_77_11 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {}

		arg_74_1:InitPlayNodeList()
	end,
	Play104101019 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 104101019
		arg_78_1.duration_ = 5

		SetActive(arg_78_1.tipsGo_, false)

		function arg_78_1.onSingleLineFinish_()
			arg_78_1.onSingleLineUpdate_ = nil
			arg_78_1.onSingleLineFinish_ = nil
			arg_78_1.state_ = "waiting"
		end

		function arg_78_1.playNext_(arg_80_0)
			if arg_80_0 == 1 then
				arg_78_0:Play104101020(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			local var_81_0 = arg_78_1.actors_["1037ui_story"]
			local var_81_1 = 0

			if var_81_1 < arg_78_1.time_ and arg_78_1.time_ <= var_81_1 + arg_81_0 and not isNil(var_81_0) and arg_78_1.var_.characterEffect1037ui_story == nil then
				arg_78_1.var_.characterEffect1037ui_story = var_81_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_81_2 = 0.1

			if var_81_1 <= arg_78_1.time_ and arg_78_1.time_ < var_81_1 + var_81_2 and not isNil(var_81_0) then
				local var_81_3 = (arg_78_1.time_ - var_81_1) / var_81_2

				if arg_78_1.var_.characterEffect1037ui_story and not isNil(var_81_0) then
					local var_81_4 = Mathf.Lerp(0, 0.5, var_81_3)

					arg_78_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_78_1.var_.characterEffect1037ui_story.fillRatio = var_81_4
				end
			end

			if arg_78_1.time_ >= var_81_1 + var_81_2 and arg_78_1.time_ < var_81_1 + var_81_2 + arg_81_0 and not isNil(var_81_0) and arg_78_1.var_.characterEffect1037ui_story then
				local var_81_5 = 0.5

				arg_78_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_78_1.var_.characterEffect1037ui_story.fillRatio = var_81_5
			end

			local var_81_6 = 0
			local var_81_7 = 0.725

			if var_81_6 < arg_78_1.time_ and arg_78_1.time_ <= var_81_6 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, true)

				local var_81_8 = arg_78_1:FormatText(StoryNameCfg[7].name)

				arg_78_1.leftNameTxt_.text = var_81_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_78_1.leftNameTxt_.transform)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1.leftNameTxt_.text)
				SetActive(arg_78_1.iconTrs_.gameObject, true)
				arg_78_1.iconController_:SetSelectedState("hero")

				arg_78_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_78_1.callingController_:SetSelectedState("normal")

				arg_78_1.keyicon_.color = Color.New(1, 1, 1)
				arg_78_1.icon_.color = Color.New(1, 1, 1)

				local var_81_9 = arg_78_1:GetWordFromCfg(104101019)
				local var_81_10 = arg_78_1:FormatText(var_81_9.content)

				arg_78_1.text_.text = var_81_10

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_11 = 29
				local var_81_12 = utf8.len(var_81_10)
				local var_81_13 = var_81_11 <= 0 and var_81_7 or var_81_7 * (var_81_12 / var_81_11)

				if var_81_13 > 0 and var_81_7 < var_81_13 then
					arg_78_1.talkMaxDuration = var_81_13

					if var_81_13 + var_81_6 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_13 + var_81_6
					end
				end

				arg_78_1.text_.text = var_81_10
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)
				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_14 = math.max(var_81_7, arg_78_1.talkMaxDuration)

			if var_81_6 <= arg_78_1.time_ and arg_78_1.time_ < var_81_6 + var_81_14 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_6) / var_81_14

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_6 + var_81_14 and arg_78_1.time_ < var_81_6 + var_81_14 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {}

		arg_78_1:InitPlayNodeList()
	end,
	Play104101020 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 104101020
		arg_82_1.duration_ = 3.67

		local var_82_0 = {
			ja = 3.666,
			ko = 3.333,
			zh = 2.766,
			en = 3
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
			arg_82_1.auto_ = false
		end

		function arg_82_1.playNext_(arg_84_0)
			arg_82_1.onStoryFinished_()
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			local var_85_0 = 0
			local var_85_1 = 0.3

			if var_85_0 < arg_82_1.time_ and arg_82_1.time_ <= var_85_0 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				local var_85_2 = arg_82_1:FormatText(StoryNameCfg[10].name)

				arg_82_1.leftNameTxt_.text = var_85_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, true)
				arg_82_1.iconController_:SetSelectedState("hero")

				arg_82_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_82_1.callingController_:SetSelectedState("normal")

				arg_82_1.keyicon_.color = Color.New(1, 1, 1)
				arg_82_1.icon_.color = Color.New(1, 1, 1)

				local var_85_3 = arg_82_1:GetWordFromCfg(104101020)
				local var_85_4 = arg_82_1:FormatText(var_85_3.content)

				arg_82_1.text_.text = var_85_4

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_5 = 12
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

				if manager.audio:GetVoiceLength("story_v_out_104101", "104101020", "story_v_out_104101.awb") ~= 0 then
					local var_85_8 = manager.audio:GetVoiceLength("story_v_out_104101", "104101020", "story_v_out_104101.awb") / 1000

					if var_85_8 + var_85_0 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_8 + var_85_0
					end

					if var_85_3.prefab_name ~= "" and arg_82_1.actors_[var_85_3.prefab_name] ~= nil then
						local var_85_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_82_1.actors_[var_85_3.prefab_name].transform, "story_v_out_104101", "104101020", "story_v_out_104101.awb")

						arg_82_1:RecordAudio("104101020", var_85_9)
						arg_82_1:RecordAudio("104101020", var_85_9)
					else
						arg_82_1:AudioAction("play", "voice", "story_v_out_104101", "104101020", "story_v_out_104101.awb")
					end

					arg_82_1:RecordHistoryTalkVoice("story_v_out_104101", "104101020", "story_v_out_104101.awb")
				end

				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_10 = math.max(var_85_1, arg_82_1.talkMaxDuration)

			if var_85_0 <= arg_82_1.time_ and arg_82_1.time_ < var_85_0 + var_85_10 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_0) / var_85_10

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_0 + var_85_10 and arg_82_1.time_ < var_85_0 + var_85_10 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {}

		arg_82_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/B13",
		"TextureConfig/Background/S0408",
		"TextureConfig/Background/S0408a"
	},
	voices = {
		"story_v_out_104101.awb"
	}
}
