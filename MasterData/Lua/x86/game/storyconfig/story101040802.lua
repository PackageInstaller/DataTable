return {
	Play104082001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 104082001
		arg_1_1.duration_ = 9.5

		local var_1_0 = {
			ja = 6.666,
			ko = 7.1,
			zh = 9.5,
			en = 7.933
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
				arg_1_0:Play104082002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_story_office", "bgm_story_office", "bgm_story_office")

				local var_4_2 = manager.audio:GetAudioName("bgm_story_office", "bgm_story_office")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_2 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_2

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_2
						arg_1_1.bgmTxt2_.text = var_4_2
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

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story", "se_story_robot_excited", "")
			end

			local var_4_4 = "2070_tpose"

			if arg_1_1.actors_["2070_tpose"] == nil and not isNil((Asset.Load("Char/" .. "2070_tpose"))) then
				local var_4_5 = Object.Instantiate(Asset.Load("Char/" .. "2070_tpose"), arg_1_1.stage_.transform)

				var_4_5.name = var_4_4
				var_4_5.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.actors_[var_4_4] = var_4_5

				local var_4_6 = var_4_5:GetComponentInChildren(typeof(CharacterEffect))

				var_4_6.enabled = true

				local var_4_7 = GameObjectTools.GetOrAddComponent(var_4_5, typeof(DynamicBoneHelper))

				if var_4_7 then
					var_4_7:EnableDynamicBone(false)
				end

				arg_1_1:ShowWeapon(var_4_6.transform, false)

				arg_1_1.var_[var_4_4 .. "Animator"] = var_4_6.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_1_1.var_[var_4_4 .. "Animator"].applyRootMotion = true
				arg_1_1.var_[var_4_4 .. "LipSync"] = var_4_6.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_4_8 = arg_1_1.actors_["2070_tpose"]

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 and not isNil(var_4_8) and arg_1_1.var_.characterEffect2070_tpose == nil then
				arg_1_1.var_.characterEffect2070_tpose = var_4_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_9 = 0.1

			if 2 <= arg_1_1.time_ and arg_1_1.time_ < 2 + var_4_9 and not isNil(var_4_8) then
				if arg_1_1.var_.characterEffect2070_tpose and not isNil(var_4_8) then
					arg_1_1.var_.characterEffect2070_tpose.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 2 + var_4_9 and arg_1_1.time_ < 2 + var_4_9 + arg_4_0 and not isNil(var_4_8) and arg_1_1.var_.characterEffect2070_tpose then
				arg_1_1.var_.characterEffect2070_tpose.fillFlat = false
			end

			local var_4_11 = "B13"

			if arg_1_1.bgs_.B13 == nil then
				local var_4_12 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_12:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_11)
				var_4_12.name = var_4_11
				var_4_12.transform.parent = arg_1_1.stage_.transform
				var_4_12.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_11] = var_4_12
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_13 = arg_1_1.bgs_.B13:GetComponent("SpriteRenderer")

				if var_4_13 then
					arg_1_1.var_.alphaOldValueB13 = var_4_13.color.a
					arg_1_1.var_.alphaMatValueB13 = var_4_13
				end

				arg_1_1.var_.alphaOldValueB13 = 0
			end

			local var_4_14 = 1.5

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_14 then
				if arg_1_1.var_.alphaMatValueB13 then
					arg_1_1.var_.alphaMatValueB13.color.a = Mathf.Lerp(arg_1_1.var_.alphaOldValueB13, 1, (arg_1_1.time_ - 0) / var_4_14)
					arg_1_1.var_.alphaMatValueB13.color = arg_1_1.var_.alphaMatValueB13.color
				end
			end

			if arg_1_1.time_ >= 0 + var_4_14 and arg_1_1.time_ < 0 + var_4_14 + arg_4_0 and arg_1_1.var_.alphaMatValueB13 then
				arg_1_1.var_.alphaMatValueB13.color.a = 1
				arg_1_1.var_.alphaMatValueB13.color = arg_1_1.var_.alphaMatValueB13.color
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_15 = arg_1_1.bgs_.B13

				arg_1_1.bgs_.B13.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_15.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_16 = var_4_15:GetComponent("SpriteRenderer")

				if var_4_16 and var_4_16.sprite then
					local var_4_17 = 2 * (var_4_15.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_15.transform.localScale = Vector3.New(var_4_17 / var_4_16.sprite.bounds.size.y < var_4_17 * manager.ui.mainCameraCom_.aspect / var_4_16.sprite.bounds.size.x and var_4_17 * manager.ui.mainCameraCom_.aspect / var_4_16.sprite.bounds.size.x or var_4_17 / var_4_16.sprite.bounds.size.y, var_4_17 / var_4_16.sprite.bounds.size.y < var_4_17 * manager.ui.mainCameraCom_.aspect / var_4_16.sprite.bounds.size.x and var_4_17 * manager.ui.mainCameraCom_.aspect / var_4_16.sprite.bounds.size.x or var_4_17 / var_4_16.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "B13" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_18 = arg_1_1.actors_["2070_tpose"].transform

			if 1.79999995231628 < arg_1_1.time_ and arg_1_1.time_ <= 1.79999995231628 + arg_4_0 then
				arg_1_1.var_.moveOldPos2070_tpose = var_4_18.localPosition

				local var_4_19 = GameObjectTools.GetOrAddComponent(var_4_18.gameObject, typeof(DynamicBoneHelper))

				if var_4_19 then
					var_4_19:EnableDynamicBone(false)
				end
			end

			local var_4_20 = 0.001

			if 1.79999995231628 <= arg_1_1.time_ and arg_1_1.time_ < 1.79999995231628 + var_4_20 then
				var_4_18.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos2070_tpose, Vector3.New(0, -0.49, -3.1), (arg_1_1.time_ - 1.79999995231628) / var_4_20)
				var_4_18.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_18.position).x, (manager.ui.mainCamera.transform.position - var_4_18.position).y, (manager.ui.mainCamera.transform.position - var_4_18.position).z)
				var_4_18.localEulerAngles.z = 0
				var_4_18.localEulerAngles.x = 0
				var_4_18.localEulerAngles = var_4_18.localEulerAngles
			end

			if arg_1_1.time_ >= 1.79999995231628 + var_4_20 and arg_1_1.time_ < 1.79999995231628 + var_4_20 + arg_4_0 then
				var_4_18.localPosition = Vector3.New(0, -0.49, -3.1)
				var_4_18.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_18.position).x, (manager.ui.mainCamera.transform.position - var_4_18.position).y, (manager.ui.mainCamera.transform.position - var_4_18.position).z)
				var_4_18.localEulerAngles.z = 0
				var_4_18.localEulerAngles.x = 0
				var_4_18.localEulerAngles = var_4_18.localEulerAngles

				local var_4_21 = GameObjectTools.GetOrAddComponent(var_4_18.gameObject, typeof(DynamicBoneHelper))

				if var_4_21 then
					var_4_21:EnableDynamicBone(true)
				end
			end

			local var_4_22 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_22 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_22 + 2 and arg_1_1.time_ < var_4_22 + 2 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_23 = 2
			local var_4_24 = 0.475

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_23 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_25 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_25:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_25:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_25:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[60].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_26 = arg_1_1:GetWordFromCfg(104082001)
				local var_4_27 = arg_1_1:FormatText(var_4_26.content)

				arg_1_1.text_.text = var_4_27

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_29 = 19 <= 0 and var_4_24 or var_4_24 * (utf8.len(var_4_27) / 19)

				if (19 <= 0 and var_4_24 or var_4_24 * (utf8.len(var_4_27) / 19)) > 0 and var_4_24 < var_4_29 then
					arg_1_1.talkMaxDuration = var_4_29
					var_4_23 = var_4_23 + 0.3

					if var_4_29 + var_4_23 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_29 + var_4_23
					end
				end

				arg_1_1.text_.text = var_4_27
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104082", "104082001", "story_v_out_104082.awb") ~= 0 then
					local var_4_30 = manager.audio:GetVoiceLength("story_v_out_104082", "104082001", "story_v_out_104082.awb") / 1000

					if var_4_30 + var_4_23 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_30 + var_4_23
					end

					if var_4_26.prefab_name ~= "" and arg_1_1.actors_[var_4_26.prefab_name] ~= nil then
						local var_4_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_26.prefab_name].transform, "story_v_out_104082", "104082001", "story_v_out_104082.awb")

						arg_1_1:RecordAudio("104082001", var_4_31)
						arg_1_1:RecordAudio("104082001", var_4_31)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_104082", "104082001", "story_v_out_104082.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_104082", "104082001", "story_v_out_104082.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_32 = var_4_23 + 0.3
			local var_4_33 = math.max(var_4_24, arg_1_1.talkMaxDuration)

			if var_4_23 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_32 + var_4_33 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_32) / var_4_33

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_32 + var_4_33 and arg_1_1.time_ < var_4_32 + var_4_33 + arg_4_0 then
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
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.79999995231628,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play104082002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 104082002
		arg_8_1.duration_ = 6.27

		local var_8_0 = {
			ja = 2.8,
			ko = 3.666,
			zh = 4.6,
			en = 6.266
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
				arg_8_0:Play104082004(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			if arg_8_1.actors_["2019_tpose"] == nil and not isNil((Asset.Load("Char/" .. "2019_tpose"))) then
				local var_11_0 = Object.Instantiate(Asset.Load("Char/" .. "2019_tpose"), arg_8_1.stage_.transform)

				var_11_0.name = "2019_tpose"
				var_11_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_8_1.actors_["2019_tpose"] = var_11_0

				local var_11_1 = var_11_0:GetComponentInChildren(typeof(CharacterEffect))

				var_11_1.enabled = true

				local var_11_2 = GameObjectTools.GetOrAddComponent(var_11_0, typeof(DynamicBoneHelper))

				if var_11_2 then
					var_11_2:EnableDynamicBone(false)
				end

				arg_8_1:ShowWeapon(var_11_1.transform, false)

				arg_8_1.var_["2019_tpose" .. "Animator"] = var_11_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_8_1.var_["2019_tpose" .. "Animator"].applyRootMotion = true
				arg_8_1.var_["2019_tpose" .. "LipSync"] = var_11_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_11_3 = arg_8_1.actors_["2019_tpose"]

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 and not isNil(var_11_3) and arg_8_1.var_.characterEffect2019_tpose == nil then
				arg_8_1.var_.characterEffect2019_tpose = var_11_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_4 = 0.1

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_4 and not isNil(var_11_3) then
				if arg_8_1.var_.characterEffect2019_tpose and not isNil(var_11_3) then
					arg_8_1.var_.characterEffect2019_tpose.fillFlat = true
					arg_8_1.var_.characterEffect2019_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_8_1.time_ - 0) / var_11_4)
				end
			end

			if arg_8_1.time_ >= 0 + var_11_4 and arg_8_1.time_ < 0 + var_11_4 + arg_11_0 and not isNil(var_11_3) and arg_8_1.var_.characterEffect2019_tpose then
				arg_8_1.var_.characterEffect2019_tpose.fillFlat = true
				arg_8_1.var_.characterEffect2019_tpose.fillRatio = 0.5
			end

			local var_11_5 = 0

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_5 + arg_11_0 then
				arg_8_1.mask_.enabled = true
				arg_8_1.mask_.raycastTarget = false

				arg_8_1:SetGaussion(false)
			end

			local var_11_6 = 0.5

			if var_11_5 <= arg_8_1.time_ and arg_8_1.time_ < var_11_5 + var_11_6 then
				local var_11_7 = Color.New(1, 1, 1)

				var_11_7.a = Mathf.Lerp(1, 0, (arg_8_1.time_ - var_11_5) / var_11_6)
				arg_8_1.mask_.color = var_11_7
			end

			if arg_8_1.time_ >= var_11_5 + var_11_6 and arg_8_1.time_ < var_11_5 + var_11_6 + arg_11_0 then
				local var_11_8 = Color.New(1, 1, 1)

				arg_8_1.mask_.enabled = false
				var_11_8.a = 0
				arg_8_1.mask_.color = var_11_8
			end

			local var_11_9 = manager.ui.mainCamera.transform

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1.var_.shakeOldPosMainCamera = var_11_9.localPosition
			end

			local var_11_10 = 0.600000023841858

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_10 then
				local var_11_11, var_11_12 = math.modf((arg_8_1.time_ - 0) / 0.066)

				var_11_9.localPosition = Vector3.New(var_11_12 * 0.13, var_11_12 * 0.13, var_11_12 * 0.13) + arg_8_1.var_.shakeOldPosMainCamera
			end

			if arg_8_1.time_ >= 0 + var_11_10 and arg_8_1.time_ < 0 + var_11_10 + arg_11_0 then
				var_11_9.localPosition = arg_8_1.var_.shakeOldPosMainCamera
			end

			local var_11_13 = arg_8_1.actors_["2070_tpose"].transform

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1.var_.moveOldPos2070_tpose = var_11_13.localPosition

				local var_11_14 = GameObjectTools.GetOrAddComponent(var_11_13.gameObject, typeof(DynamicBoneHelper))

				if var_11_14 then
					var_11_14:EnableDynamicBone(false)
				end
			end

			local var_11_15 = 0.001

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_15 then
				var_11_13.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos2070_tpose, Vector3.New(0, 100, 0), (arg_8_1.time_ - 0) / var_11_15)
				var_11_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_11_13.position).x, (manager.ui.mainCamera.transform.position - var_11_13.position).y, (manager.ui.mainCamera.transform.position - var_11_13.position).z)
				var_11_13.localEulerAngles.z = 0
				var_11_13.localEulerAngles.x = 0
				var_11_13.localEulerAngles = var_11_13.localEulerAngles
			end

			if arg_8_1.time_ >= 0 + var_11_15 and arg_8_1.time_ < 0 + var_11_15 + arg_11_0 then
				var_11_13.localPosition = Vector3.New(0, 100, 0)
				var_11_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_11_13.position).x, (manager.ui.mainCamera.transform.position - var_11_13.position).y, (manager.ui.mainCamera.transform.position - var_11_13.position).z)
				var_11_13.localEulerAngles.z = 0
				var_11_13.localEulerAngles.x = 0
				var_11_13.localEulerAngles = var_11_13.localEulerAngles

				local var_11_16 = GameObjectTools.GetOrAddComponent(var_11_13.gameObject, typeof(DynamicBoneHelper))

				if var_11_16 then
					var_11_16:EnableDynamicBone(true)
				end
			end

			local var_11_17 = 0
			local var_11_18 = 0.55

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_17 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				arg_8_1.leftNameTxt_.text = arg_8_1:FormatText(StoryNameCfg[59].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_19 = arg_8_1:GetWordFromCfg(104082002)
				local var_11_20 = arg_8_1:FormatText(var_11_19.content)

				arg_8_1.text_.text = var_11_20

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_22 = 22 <= 0 and var_11_18 or var_11_18 * (utf8.len(var_11_20) / 22)

				if (22 <= 0 and var_11_18 or var_11_18 * (utf8.len(var_11_20) / 22)) > 0 and var_11_18 < var_11_22 then
					arg_8_1.talkMaxDuration = var_11_22

					if var_11_22 + var_11_17 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_22 + var_11_17
					end
				end

				arg_8_1.text_.text = var_11_20
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104082", "104082002", "story_v_out_104082.awb") ~= 0 then
					local var_11_23 = manager.audio:GetVoiceLength("story_v_out_104082", "104082002", "story_v_out_104082.awb") / 1000

					if var_11_23 + var_11_17 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_23 + var_11_17
					end

					if var_11_19.prefab_name ~= "" and arg_8_1.actors_[var_11_19.prefab_name] ~= nil then
						local var_11_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_19.prefab_name].transform, "story_v_out_104082", "104082002", "story_v_out_104082.awb")

						arg_8_1:RecordAudio("104082002", var_11_24)
						arg_8_1:RecordAudio("104082002", var_11_24)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_104082", "104082002", "story_v_out_104082.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_104082", "104082002", "story_v_out_104082.awb")
				end

				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_25 = math.max(var_11_18, arg_8_1.talkMaxDuration)

			if var_11_17 <= arg_8_1.time_ and arg_8_1.time_ < var_11_17 + var_11_25 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_17) / var_11_25

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_17 + var_11_25 and arg_8_1.time_ < var_11_17 + var_11_25 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2070_tpose",
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
	Play104082004 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 104082004
		arg_12_1.duration_ = 8.4

		local var_12_0 = {
			ja = 8.3,
			ko = 5.966,
			zh = 8.4,
			en = 7.566
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
				arg_12_0:Play104082005(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1.mask_.enabled = true
				arg_12_1.mask_.raycastTarget = true

				arg_12_1:SetGaussion(false)
			end

			local var_15_0 = 1.5

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_0 then
				local var_15_1 = Color.New(1, 1, 1)

				var_15_1.a = Mathf.Lerp(0, 1, (arg_12_1.time_ - 0) / var_15_0)
				arg_12_1.mask_.color = var_15_1
			end

			if arg_12_1.time_ >= 0 + var_15_0 and arg_12_1.time_ < 0 + var_15_0 + arg_15_0 then
				local var_15_2 = Color.New(1, 1, 1)

				var_15_2.a = 1
				arg_12_1.mask_.color = var_15_2
			end

			local var_15_3 = arg_12_1.bgs_.B13.transform

			if 1.5 < arg_12_1.time_ and arg_12_1.time_ <= 1.5 + arg_15_0 then
				arg_12_1.var_.moveOldPosB13 = var_15_3.localPosition
			end

			local var_15_4 = 0.001

			if 1.5 <= arg_12_1.time_ and arg_12_1.time_ < 1.5 + var_15_4 then
				var_15_3.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPosB13, Vector3.New(0, -100, 10), (arg_12_1.time_ - 1.5) / var_15_4)
			end

			if arg_12_1.time_ >= 1.5 + var_15_4 and arg_12_1.time_ < 1.5 + var_15_4 + arg_15_0 then
				var_15_3.localPosition = Vector3.New(0, -100, 10)
			end

			local var_15_5 = 2

			if 2 < arg_12_1.time_ and arg_12_1.time_ <= var_15_5 + arg_15_0 then
				arg_12_1.mask_.enabled = true
				arg_12_1.mask_.raycastTarget = false

				arg_12_1:SetGaussion(false)
			end

			local var_15_6 = 1.5

			if var_15_5 <= arg_12_1.time_ and arg_12_1.time_ < var_15_5 + var_15_6 then
				local var_15_7 = Color.New(1, 1, 1)

				var_15_7.a = Mathf.Lerp(1, 0, (arg_12_1.time_ - var_15_5) / var_15_6)
				arg_12_1.mask_.color = var_15_7
			end

			if arg_12_1.time_ >= var_15_5 + var_15_6 and arg_12_1.time_ < var_15_5 + var_15_6 + arg_15_0 then
				local var_15_8 = Color.New(1, 1, 1)

				arg_12_1.mask_.enabled = false
				var_15_8.a = 0
				arg_12_1.mask_.color = var_15_8
			end

			local var_15_9 = "S0405"

			if arg_12_1.bgs_.S0405 == nil then
				local var_15_10 = Object.Instantiate(arg_12_1.paintGo_)

				var_15_10:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_15_9)
				var_15_10.name = var_15_9
				var_15_10.transform.parent = arg_12_1.stage_.transform
				var_15_10.transform.localPosition = Vector3.New(0, 100, 0)
				arg_12_1.bgs_[var_15_9] = var_15_10
			end

			if 2 < arg_12_1.time_ and arg_12_1.time_ <= 2 + arg_15_0 then
				local var_15_11 = arg_12_1.bgs_.S0405

				arg_12_1.bgs_.S0405.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_15_11.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_15_12 = var_15_11:GetComponent("SpriteRenderer")

				if var_15_12 and var_15_12.sprite then
					local var_15_13 = 2 * (var_15_11.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_15_11.transform.localScale = Vector3.New(var_15_13 / var_15_12.sprite.bounds.size.y < var_15_13 * manager.ui.mainCameraCom_.aspect / var_15_12.sprite.bounds.size.x and var_15_13 * manager.ui.mainCameraCom_.aspect / var_15_12.sprite.bounds.size.x or var_15_13 / var_15_12.sprite.bounds.size.y, var_15_13 / var_15_12.sprite.bounds.size.y < var_15_13 * manager.ui.mainCameraCom_.aspect / var_15_12.sprite.bounds.size.x and var_15_13 * manager.ui.mainCameraCom_.aspect / var_15_12.sprite.bounds.size.x or var_15_13 / var_15_12.sprite.bounds.size.y, 0)
				end

				for iter_15_0, iter_15_1 in pairs(arg_12_1.bgs_) do
					if iter_15_0 ~= "S0405" then
						iter_15_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_15_14 = manager.ui.mainCamera.transform

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1.var_.shakeOldPosMainCamera = var_15_14.localPosition
			end

			local var_15_15 = 0.600000023841858

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_15 then
				local var_15_16, var_15_17 = math.modf((arg_12_1.time_ - 0) / 0.066)

				var_15_14.localPosition = Vector3.New(var_15_17 * 0.13, var_15_17 * 0.13, var_15_17 * 0.13) + arg_12_1.var_.shakeOldPosMainCamera
			end

			if arg_12_1.time_ >= 0 + var_15_15 and arg_12_1.time_ < 0 + var_15_15 + arg_15_0 then
				var_15_14.localPosition = arg_12_1.var_.shakeOldPosMainCamera
			end

			local var_15_18 = 0

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_18 + arg_15_0 then
				arg_12_1.allBtn_.enabled = false
			end

			if arg_12_1.time_ >= var_15_18 + 2.5 and arg_12_1.time_ < var_15_18 + 2.5 + arg_15_0 then
				arg_12_1.allBtn_.enabled = true
			end

			if arg_12_1.frameCnt_ <= 1 then
				arg_12_1.dialog_:SetActive(false)
			end

			local var_15_19 = 2.5
			local var_15_20 = 0.25

			if 2.5 < arg_12_1.time_ and arg_12_1.time_ <= var_15_19 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0

				arg_12_1.dialog_:SetActive(true)

				arg_12_1.dialogCg_.alpha = 0

				local var_15_21 = LeanTween.value(arg_12_1.dialog_, 0, 1, 0.3)

				var_15_21:setOnUpdate(LuaHelper.FloatAction(function(arg_16_0)
					arg_12_1.dialogCg_.alpha = arg_16_0
				end))
				var_15_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_12_1.dialog_)
					var_15_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_12_1.duration_ = arg_12_1.duration_ + 0.3

				SetActive(arg_12_1.leftNameGo_, true)

				arg_12_1.leftNameTxt_.text = arg_12_1:FormatText(StoryNameCfg[59].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_22 = arg_12_1:GetWordFromCfg(104082004)
				local var_15_23 = arg_12_1:FormatText(var_15_22.content)

				arg_12_1.text_.text = var_15_23

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_25 = 10 <= 0 and var_15_20 or var_15_20 * (utf8.len(var_15_23) / 10)

				if (10 <= 0 and var_15_20 or var_15_20 * (utf8.len(var_15_23) / 10)) > 0 and var_15_20 < var_15_25 then
					arg_12_1.talkMaxDuration = var_15_25
					var_15_19 = var_15_19 + 0.3

					if var_15_25 + var_15_19 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_25 + var_15_19
					end
				end

				arg_12_1.text_.text = var_15_23
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104082", "104082004", "story_v_out_104082.awb") ~= 0 then
					local var_15_26 = manager.audio:GetVoiceLength("story_v_out_104082", "104082004", "story_v_out_104082.awb") / 1000

					if var_15_26 + var_15_19 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_26 + var_15_19
					end

					if var_15_22.prefab_name ~= "" and arg_12_1.actors_[var_15_22.prefab_name] ~= nil then
						local var_15_27 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_22.prefab_name].transform, "story_v_out_104082", "104082004", "story_v_out_104082.awb")

						arg_12_1:RecordAudio("104082004", var_15_27)
						arg_12_1:RecordAudio("104082004", var_15_27)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_104082", "104082004", "story_v_out_104082.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_104082", "104082004", "story_v_out_104082.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_28 = var_15_19 + 0.3
			local var_15_29 = math.max(var_15_20, arg_12_1.talkMaxDuration)

			if var_15_19 + 0.3 <= arg_12_1.time_ and arg_12_1.time_ < var_15_28 + var_15_29 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_28) / var_15_29

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_28 + var_15_29 and arg_12_1.time_ < var_15_28 + var_15_29 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "B13",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 1.5,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_12_1:InitPlayNodeList()
	end,
	Play104082005 = function(arg_18_0, arg_18_1)
		arg_18_1.time_ = 0
		arg_18_1.frameCnt_ = 0
		arg_18_1.state_ = "playing"
		arg_18_1.curTalkId_ = 104082005
		arg_18_1.duration_ = 1.37

		local var_18_0 = {
			ja = 1.366,
			ko = 0.9,
			zh = 1.3,
			en = 1.233
		}
		local var_18_1 = manager.audio:GetLocalizationFlag()

		if var_18_0[var_18_1] ~= nil then
			arg_18_1.duration_ = var_18_0[var_18_1]
		end

		SetActive(arg_18_1.tipsGo_, false)

		function arg_18_1.onSingleLineFinish_()
			arg_18_1.onSingleLineUpdate_ = nil
			arg_18_1.onSingleLineFinish_ = nil
			arg_18_1.state_ = "waiting"
		end

		function arg_18_1.playNext_(arg_20_0)
			if arg_20_0 == 1 then
				arg_18_0:Play104082006(arg_18_1)
			end
		end

		function arg_18_1.onSingleLineUpdate_(arg_21_0)
			local var_21_0 = 0.125

			if 0 < arg_18_1.time_ and arg_18_1.time_ <= 0 + arg_21_0 then
				arg_18_1.talkMaxDuration = 0
				arg_18_1.dialogCg_.alpha = 1

				arg_18_1.dialog_:SetActive(true)
				SetActive(arg_18_1.leftNameGo_, true)

				arg_18_1.leftNameTxt_.text = arg_18_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_18_1.leftNameTxt_.transform)

				arg_18_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_18_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_18_1:RecordName(arg_18_1.leftNameTxt_.text)
				SetActive(arg_18_1.iconTrs_.gameObject, false)
				arg_18_1.callingController_:SetSelectedState("normal")

				local var_21_1 = arg_18_1:GetWordFromCfg(104082005)
				local var_21_2 = arg_18_1:FormatText(var_21_1.content)

				arg_18_1.text_.text = var_21_2

				LuaForUtil.ClearLinePrefixSymbol(arg_18_1.text_)

				local var_21_4 = 5 <= 0 and var_21_0 or var_21_0 * (utf8.len(var_21_2) / 5)

				if (5 <= 0 and var_21_0 or var_21_0 * (utf8.len(var_21_2) / 5)) > 0 and var_21_0 < var_21_4 then
					arg_18_1.talkMaxDuration = var_21_4

					if var_21_4 + 0 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_4 + 0
					end
				end

				arg_18_1.text_.text = var_21_2
				arg_18_1.typewritter.percent = 0

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104082", "104082005", "story_v_out_104082.awb") ~= 0 then
					local var_21_5 = manager.audio:GetVoiceLength("story_v_out_104082", "104082005", "story_v_out_104082.awb") / 1000

					if var_21_5 + 0 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_5 + 0
					end

					if var_21_1.prefab_name ~= "" and arg_18_1.actors_[var_21_1.prefab_name] ~= nil then
						local var_21_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_18_1.actors_[var_21_1.prefab_name].transform, "story_v_out_104082", "104082005", "story_v_out_104082.awb")

						arg_18_1:RecordAudio("104082005", var_21_6)
						arg_18_1:RecordAudio("104082005", var_21_6)
					else
						arg_18_1:AudioAction("play", "voice", "story_v_out_104082", "104082005", "story_v_out_104082.awb")
					end

					arg_18_1:RecordHistoryTalkVoice("story_v_out_104082", "104082005", "story_v_out_104082.awb")
				end

				arg_18_1:RecordContent(arg_18_1.text_.text)
			end

			local var_21_7 = math.max(var_21_0, arg_18_1.talkMaxDuration)

			if 0 <= arg_18_1.time_ and arg_18_1.time_ < 0 + var_21_7 then
				arg_18_1.typewritter.percent = (arg_18_1.time_ - 0) / var_21_7

				arg_18_1.typewritter:SetDirty()
			end

			if arg_18_1.time_ >= 0 + var_21_7 and arg_18_1.time_ < 0 + var_21_7 + arg_21_0 then
				arg_18_1.typewritter.percent = 1

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(true)
			end
		end

		arg_18_1.nodeConfigList_ = {}

		arg_18_1:InitPlayNodeList()
	end,
	Play104082006 = function(arg_22_0, arg_22_1)
		arg_22_1.time_ = 0
		arg_22_1.frameCnt_ = 0
		arg_22_1.state_ = "playing"
		arg_22_1.curTalkId_ = 104082006
		arg_22_1.duration_ = 5

		SetActive(arg_22_1.tipsGo_, false)

		function arg_22_1.onSingleLineFinish_()
			arg_22_1.onSingleLineUpdate_ = nil
			arg_22_1.onSingleLineFinish_ = nil
			arg_22_1.state_ = "waiting"
		end

		function arg_22_1.playNext_(arg_24_0)
			if arg_24_0 == 1 then
				arg_22_0:Play104082007(arg_22_1)
			end
		end

		function arg_22_1.onSingleLineUpdate_(arg_25_0)
			local var_25_0 = 0.975

			if 0 < arg_22_1.time_ and arg_22_1.time_ <= 0 + arg_25_0 then
				arg_22_1.talkMaxDuration = 0
				arg_22_1.dialogCg_.alpha = 1

				arg_22_1.dialog_:SetActive(true)
				SetActive(arg_22_1.leftNameGo_, false)

				arg_22_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_22_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_22_1:RecordName(arg_22_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_22_1.iconTrs_.gameObject, false)
				arg_22_1.callingController_:SetSelectedState("normal")

				local var_25_1 = arg_22_1:FormatText(arg_22_1:GetWordFromCfg(104082006).content)

				arg_22_1.text_.text = var_25_1

				LuaForUtil.ClearLinePrefixSymbol(arg_22_1.text_)

				local var_25_3 = 39 <= 0 and var_25_0 or var_25_0 * (utf8.len(var_25_1) / 39)

				if (39 <= 0 and var_25_0 or var_25_0 * (utf8.len(var_25_1) / 39)) > 0 and var_25_0 < var_25_3 then
					arg_22_1.talkMaxDuration = var_25_3

					if var_25_3 + 0 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_3 + 0
					end
				end

				arg_22_1.text_.text = var_25_1
				arg_22_1.typewritter.percent = 0

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(false)
				arg_22_1:RecordContent(arg_22_1.text_.text)
			end

			local var_25_4 = math.max(var_25_0, arg_22_1.talkMaxDuration)

			if 0 <= arg_22_1.time_ and arg_22_1.time_ < 0 + var_25_4 then
				arg_22_1.typewritter.percent = (arg_22_1.time_ - 0) / var_25_4

				arg_22_1.typewritter:SetDirty()
			end

			if arg_22_1.time_ >= 0 + var_25_4 and arg_22_1.time_ < 0 + var_25_4 + arg_25_0 then
				arg_22_1.typewritter.percent = 1

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(true)
			end
		end

		arg_22_1.nodeConfigList_ = {}

		arg_22_1:InitPlayNodeList()
	end,
	Play104082007 = function(arg_26_0, arg_26_1)
		arg_26_1.time_ = 0
		arg_26_1.frameCnt_ = 0
		arg_26_1.state_ = "playing"
		arg_26_1.curTalkId_ = 104082007
		arg_26_1.duration_ = 3.17

		local var_26_0 = {
			ja = 3.1,
			ko = 2.6,
			zh = 2.833,
			en = 3.166
		}
		local var_26_1 = manager.audio:GetLocalizationFlag()

		if var_26_0[var_26_1] ~= nil then
			arg_26_1.duration_ = var_26_0[var_26_1]
		end

		SetActive(arg_26_1.tipsGo_, false)

		function arg_26_1.onSingleLineFinish_()
			arg_26_1.onSingleLineUpdate_ = nil
			arg_26_1.onSingleLineFinish_ = nil
			arg_26_1.state_ = "waiting"
		end

		function arg_26_1.playNext_(arg_28_0)
			if arg_28_0 == 1 then
				arg_26_0:Play104082008(arg_26_1)
			end
		end

		function arg_26_1.onSingleLineUpdate_(arg_29_0)
			local var_29_0 = 0.15

			if 0 < arg_26_1.time_ and arg_26_1.time_ <= 0 + arg_29_0 then
				arg_26_1.talkMaxDuration = 0
				arg_26_1.dialogCg_.alpha = 1

				arg_26_1.dialog_:SetActive(true)
				SetActive(arg_26_1.leftNameGo_, true)

				arg_26_1.leftNameTxt_.text = arg_26_1:FormatText(StoryNameCfg[59].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_26_1.leftNameTxt_.transform)

				arg_26_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_26_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_26_1:RecordName(arg_26_1.leftNameTxt_.text)
				SetActive(arg_26_1.iconTrs_.gameObject, false)
				arg_26_1.callingController_:SetSelectedState("normal")

				local var_29_1 = arg_26_1:GetWordFromCfg(104082007)
				local var_29_2 = arg_26_1:FormatText(var_29_1.content)

				arg_26_1.text_.text = var_29_2

				LuaForUtil.ClearLinePrefixSymbol(arg_26_1.text_)

				local var_29_4 = 6 <= 0 and var_29_0 or var_29_0 * (utf8.len(var_29_2) / 6)

				if (6 <= 0 and var_29_0 or var_29_0 * (utf8.len(var_29_2) / 6)) > 0 and var_29_0 < var_29_4 then
					arg_26_1.talkMaxDuration = var_29_4

					if var_29_4 + 0 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_4 + 0
					end
				end

				arg_26_1.text_.text = var_29_2
				arg_26_1.typewritter.percent = 0

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104082", "104082007", "story_v_out_104082.awb") ~= 0 then
					local var_29_5 = manager.audio:GetVoiceLength("story_v_out_104082", "104082007", "story_v_out_104082.awb") / 1000

					if var_29_5 + 0 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_5 + 0
					end

					if var_29_1.prefab_name ~= "" and arg_26_1.actors_[var_29_1.prefab_name] ~= nil then
						local var_29_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_26_1.actors_[var_29_1.prefab_name].transform, "story_v_out_104082", "104082007", "story_v_out_104082.awb")

						arg_26_1:RecordAudio("104082007", var_29_6)
						arg_26_1:RecordAudio("104082007", var_29_6)
					else
						arg_26_1:AudioAction("play", "voice", "story_v_out_104082", "104082007", "story_v_out_104082.awb")
					end

					arg_26_1:RecordHistoryTalkVoice("story_v_out_104082", "104082007", "story_v_out_104082.awb")
				end

				arg_26_1:RecordContent(arg_26_1.text_.text)
			end

			local var_29_7 = math.max(var_29_0, arg_26_1.talkMaxDuration)

			if 0 <= arg_26_1.time_ and arg_26_1.time_ < 0 + var_29_7 then
				arg_26_1.typewritter.percent = (arg_26_1.time_ - 0) / var_29_7

				arg_26_1.typewritter:SetDirty()
			end

			if arg_26_1.time_ >= 0 + var_29_7 and arg_26_1.time_ < 0 + var_29_7 + arg_29_0 then
				arg_26_1.typewritter.percent = 1

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(true)
			end
		end

		arg_26_1.nodeConfigList_ = {}

		arg_26_1:InitPlayNodeList()
	end,
	Play104082008 = function(arg_30_0, arg_30_1)
		arg_30_1.time_ = 0
		arg_30_1.frameCnt_ = 0
		arg_30_1.state_ = "playing"
		arg_30_1.curTalkId_ = 104082008
		arg_30_1.duration_ = 5

		SetActive(arg_30_1.tipsGo_, false)

		function arg_30_1.onSingleLineFinish_()
			arg_30_1.onSingleLineUpdate_ = nil
			arg_30_1.onSingleLineFinish_ = nil
			arg_30_1.state_ = "waiting"
		end

		function arg_30_1.playNext_(arg_32_0)
			if arg_32_0 == 1 then
				arg_30_0:Play104082009(arg_30_1)
			end
		end

		function arg_30_1.onSingleLineUpdate_(arg_33_0)
			if 0 < arg_30_1.time_ and arg_30_1.time_ <= 0 + arg_33_0 then
				arg_30_1:AudioAction("play", "effect", "se_story_4", "se_story_4_pullsword", "")
			end

			local var_33_1 = 0
			local var_33_2 = 1.275

			if 0 < arg_30_1.time_ and arg_30_1.time_ <= var_33_1 + arg_33_0 then
				arg_30_1.talkMaxDuration = 0
				arg_30_1.dialogCg_.alpha = 1

				arg_30_1.dialog_:SetActive(true)
				SetActive(arg_30_1.leftNameGo_, false)

				arg_30_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_30_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_30_1:RecordName(arg_30_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_30_1.iconTrs_.gameObject, false)
				arg_30_1.callingController_:SetSelectedState("normal")

				local var_33_3 = arg_30_1:FormatText(arg_30_1:GetWordFromCfg(104082008).content)

				arg_30_1.text_.text = var_33_3

				LuaForUtil.ClearLinePrefixSymbol(arg_30_1.text_)

				local var_33_5 = 51 <= 0 and var_33_2 or var_33_2 * (utf8.len(var_33_3) / 51)

				if (51 <= 0 and var_33_2 or var_33_2 * (utf8.len(var_33_3) / 51)) > 0 and var_33_2 < var_33_5 then
					arg_30_1.talkMaxDuration = var_33_5

					if var_33_5 + var_33_1 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_5 + var_33_1
					end
				end

				arg_30_1.text_.text = var_33_3
				arg_30_1.typewritter.percent = 0

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(false)
				arg_30_1:RecordContent(arg_30_1.text_.text)
			end

			local var_33_6 = math.max(var_33_2, arg_30_1.talkMaxDuration)

			if var_33_1 <= arg_30_1.time_ and arg_30_1.time_ < var_33_1 + var_33_6 then
				arg_30_1.typewritter.percent = (arg_30_1.time_ - var_33_1) / var_33_6

				arg_30_1.typewritter:SetDirty()
			end

			if arg_30_1.time_ >= var_33_1 + var_33_6 and arg_30_1.time_ < var_33_1 + var_33_6 + arg_33_0 then
				arg_30_1.typewritter.percent = 1

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(true)
			end
		end

		arg_30_1.nodeConfigList_ = {}

		arg_30_1:InitPlayNodeList()
	end,
	Play104082009 = function(arg_34_0, arg_34_1)
		arg_34_1.time_ = 0
		arg_34_1.frameCnt_ = 0
		arg_34_1.state_ = "playing"
		arg_34_1.curTalkId_ = 104082009
		arg_34_1.duration_ = 5.4

		local var_34_0 = {
			ja = 5.4,
			ko = 3.2,
			zh = 4.833,
			en = 4.9
		}
		local var_34_1 = manager.audio:GetLocalizationFlag()

		if var_34_0[var_34_1] ~= nil then
			arg_34_1.duration_ = var_34_0[var_34_1]
		end

		SetActive(arg_34_1.tipsGo_, false)

		function arg_34_1.onSingleLineFinish_()
			arg_34_1.onSingleLineUpdate_ = nil
			arg_34_1.onSingleLineFinish_ = nil
			arg_34_1.state_ = "waiting"
		end

		function arg_34_1.playNext_(arg_36_0)
			if arg_36_0 == 1 then
				arg_34_0:Play104082010(arg_34_1)
			end
		end

		function arg_34_1.onSingleLineUpdate_(arg_37_0)
			local var_37_0 = 0.35

			if 0 < arg_34_1.time_ and arg_34_1.time_ <= 0 + arg_37_0 then
				arg_34_1.talkMaxDuration = 0
				arg_34_1.dialogCg_.alpha = 1

				arg_34_1.dialog_:SetActive(true)
				SetActive(arg_34_1.leftNameGo_, true)

				arg_34_1.leftNameTxt_.text = arg_34_1:FormatText(StoryNameCfg[59].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_34_1.leftNameTxt_.transform)

				arg_34_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_34_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_34_1:RecordName(arg_34_1.leftNameTxt_.text)
				SetActive(arg_34_1.iconTrs_.gameObject, false)
				arg_34_1.callingController_:SetSelectedState("normal")

				local var_37_1 = arg_34_1:GetWordFromCfg(104082009)
				local var_37_2 = arg_34_1:FormatText(var_37_1.content)

				arg_34_1.text_.text = var_37_2

				LuaForUtil.ClearLinePrefixSymbol(arg_34_1.text_)

				local var_37_4 = 14 <= 0 and var_37_0 or var_37_0 * (utf8.len(var_37_2) / 14)

				if (14 <= 0 and var_37_0 or var_37_0 * (utf8.len(var_37_2) / 14)) > 0 and var_37_0 < var_37_4 then
					arg_34_1.talkMaxDuration = var_37_4

					if var_37_4 + 0 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_4 + 0
					end
				end

				arg_34_1.text_.text = var_37_2
				arg_34_1.typewritter.percent = 0

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104082", "104082009", "story_v_out_104082.awb") ~= 0 then
					local var_37_5 = manager.audio:GetVoiceLength("story_v_out_104082", "104082009", "story_v_out_104082.awb") / 1000

					if var_37_5 + 0 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_5 + 0
					end

					if var_37_1.prefab_name ~= "" and arg_34_1.actors_[var_37_1.prefab_name] ~= nil then
						local var_37_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_34_1.actors_[var_37_1.prefab_name].transform, "story_v_out_104082", "104082009", "story_v_out_104082.awb")

						arg_34_1:RecordAudio("104082009", var_37_6)
						arg_34_1:RecordAudio("104082009", var_37_6)
					else
						arg_34_1:AudioAction("play", "voice", "story_v_out_104082", "104082009", "story_v_out_104082.awb")
					end

					arg_34_1:RecordHistoryTalkVoice("story_v_out_104082", "104082009", "story_v_out_104082.awb")
				end

				arg_34_1:RecordContent(arg_34_1.text_.text)
			end

			local var_37_7 = math.max(var_37_0, arg_34_1.talkMaxDuration)

			if 0 <= arg_34_1.time_ and arg_34_1.time_ < 0 + var_37_7 then
				arg_34_1.typewritter.percent = (arg_34_1.time_ - 0) / var_37_7

				arg_34_1.typewritter:SetDirty()
			end

			if arg_34_1.time_ >= 0 + var_37_7 and arg_34_1.time_ < 0 + var_37_7 + arg_37_0 then
				arg_34_1.typewritter.percent = 1

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(true)
			end
		end

		arg_34_1.nodeConfigList_ = {}

		arg_34_1:InitPlayNodeList()
	end,
	Play104082010 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 104082010
		arg_38_1.duration_ = 5

		SetActive(arg_38_1.tipsGo_, false)

		function arg_38_1.onSingleLineFinish_()
			arg_38_1.onSingleLineUpdate_ = nil
			arg_38_1.onSingleLineFinish_ = nil
			arg_38_1.state_ = "waiting"
		end

		function arg_38_1.playNext_(arg_40_0)
			if arg_40_0 == 1 then
				arg_38_0:Play104082011(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			local var_41_0 = 0.575

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= 0 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0
				arg_38_1.dialogCg_.alpha = 1

				arg_38_1.dialog_:SetActive(true)
				SetActive(arg_38_1.leftNameGo_, false)

				arg_38_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_38_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_38_1:RecordName(arg_38_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_38_1.iconTrs_.gameObject, false)
				arg_38_1.callingController_:SetSelectedState("normal")

				local var_41_1 = arg_38_1:FormatText(arg_38_1:GetWordFromCfg(104082010).content)

				arg_38_1.text_.text = var_41_1

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_3 = 23 <= 0 and var_41_0 or var_41_0 * (utf8.len(var_41_1) / 23)

				if (23 <= 0 and var_41_0 or var_41_0 * (utf8.len(var_41_1) / 23)) > 0 and var_41_0 < var_41_3 then
					arg_38_1.talkMaxDuration = var_41_3

					if var_41_3 + 0 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_3 + 0
					end
				end

				arg_38_1.text_.text = var_41_1
				arg_38_1.typewritter.percent = 0

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(false)
				arg_38_1:RecordContent(arg_38_1.text_.text)
			end

			local var_41_4 = math.max(var_41_0, arg_38_1.talkMaxDuration)

			if 0 <= arg_38_1.time_ and arg_38_1.time_ < 0 + var_41_4 then
				arg_38_1.typewritter.percent = (arg_38_1.time_ - 0) / var_41_4

				arg_38_1.typewritter:SetDirty()
			end

			if arg_38_1.time_ >= 0 + var_41_4 and arg_38_1.time_ < 0 + var_41_4 + arg_41_0 then
				arg_38_1.typewritter.percent = 1

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(true)
			end
		end

		arg_38_1.nodeConfigList_ = {}

		arg_38_1:InitPlayNodeList()
	end,
	Play104082011 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 104082011
		arg_42_1.duration_ = 6.6

		local var_42_0 = {
			ja = 6.6,
			ko = 3.066,
			zh = 3.766,
			en = 3.833
		}
		local var_42_1 = manager.audio:GetLocalizationFlag()

		if var_42_0[var_42_1] ~= nil then
			arg_42_1.duration_ = var_42_0[var_42_1]
		end

		SetActive(arg_42_1.tipsGo_, false)

		function arg_42_1.onSingleLineFinish_()
			arg_42_1.onSingleLineUpdate_ = nil
			arg_42_1.onSingleLineFinish_ = nil
			arg_42_1.state_ = "waiting"
		end

		function arg_42_1.playNext_(arg_44_0)
			if arg_44_0 == 1 then
				arg_42_0:Play104082012(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			local var_45_0 = 0.425

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0
				arg_42_1.dialogCg_.alpha = 1

				arg_42_1.dialog_:SetActive(true)
				SetActive(arg_42_1.leftNameGo_, true)

				arg_42_1.leftNameTxt_.text = arg_42_1:FormatText(StoryNameCfg[61].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_42_1.leftNameTxt_.transform)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1.leftNameTxt_.text)
				SetActive(arg_42_1.iconTrs_.gameObject, false)
				arg_42_1.callingController_:SetSelectedState("normal")

				local var_45_1 = arg_42_1:GetWordFromCfg(104082011)
				local var_45_2 = arg_42_1:FormatText(var_45_1.content)

				arg_42_1.text_.text = var_45_2

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_4 = 17 <= 0 and var_45_0 or var_45_0 * (utf8.len(var_45_2) / 17)

				if (17 <= 0 and var_45_0 or var_45_0 * (utf8.len(var_45_2) / 17)) > 0 and var_45_0 < var_45_4 then
					arg_42_1.talkMaxDuration = var_45_4

					if var_45_4 + 0 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_4 + 0
					end
				end

				arg_42_1.text_.text = var_45_2
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104082", "104082011", "story_v_out_104082.awb") ~= 0 then
					local var_45_5 = manager.audio:GetVoiceLength("story_v_out_104082", "104082011", "story_v_out_104082.awb") / 1000

					if var_45_5 + 0 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_5 + 0
					end

					if var_45_1.prefab_name ~= "" and arg_42_1.actors_[var_45_1.prefab_name] ~= nil then
						local var_45_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_42_1.actors_[var_45_1.prefab_name].transform, "story_v_out_104082", "104082011", "story_v_out_104082.awb")

						arg_42_1:RecordAudio("104082011", var_45_6)
						arg_42_1:RecordAudio("104082011", var_45_6)
					else
						arg_42_1:AudioAction("play", "voice", "story_v_out_104082", "104082011", "story_v_out_104082.awb")
					end

					arg_42_1:RecordHistoryTalkVoice("story_v_out_104082", "104082011", "story_v_out_104082.awb")
				end

				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_7 = math.max(var_45_0, arg_42_1.talkMaxDuration)

			if 0 <= arg_42_1.time_ and arg_42_1.time_ < 0 + var_45_7 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - 0) / var_45_7

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= 0 + var_45_7 and arg_42_1.time_ < 0 + var_45_7 + arg_45_0 then
				arg_42_1.typewritter.percent = 1

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(true)
			end
		end

		arg_42_1.nodeConfigList_ = {}

		arg_42_1:InitPlayNodeList()
	end,
	Play104082012 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 104082012
		arg_46_1.duration_ = 4.2

		local var_46_0 = {
			ja = 4.2,
			ko = 2.066,
			zh = 1.266,
			en = 1.433
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
				arg_46_0:Play104082013(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			local var_49_0 = 0.125

			if 0 < arg_46_1.time_ and arg_46_1.time_ <= 0 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0
				arg_46_1.dialogCg_.alpha = 1

				arg_46_1.dialog_:SetActive(true)
				SetActive(arg_46_1.leftNameGo_, true)

				arg_46_1.leftNameTxt_.text = arg_46_1:FormatText(StoryNameCfg[59].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_46_1.leftNameTxt_.transform)

				arg_46_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_46_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_46_1:RecordName(arg_46_1.leftNameTxt_.text)
				SetActive(arg_46_1.iconTrs_.gameObject, false)
				arg_46_1.callingController_:SetSelectedState("normal")

				local var_49_1 = arg_46_1:GetWordFromCfg(104082012)
				local var_49_2 = arg_46_1:FormatText(var_49_1.content)

				arg_46_1.text_.text = var_49_2

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_4 = 5 <= 0 and var_49_0 or var_49_0 * (utf8.len(var_49_2) / 5)

				if (5 <= 0 and var_49_0 or var_49_0 * (utf8.len(var_49_2) / 5)) > 0 and var_49_0 < var_49_4 then
					arg_46_1.talkMaxDuration = var_49_4

					if var_49_4 + 0 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_4 + 0
					end
				end

				arg_46_1.text_.text = var_49_2
				arg_46_1.typewritter.percent = 0

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104082", "104082012", "story_v_out_104082.awb") ~= 0 then
					local var_49_5 = manager.audio:GetVoiceLength("story_v_out_104082", "104082012", "story_v_out_104082.awb") / 1000

					if var_49_5 + 0 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_5 + 0
					end

					if var_49_1.prefab_name ~= "" and arg_46_1.actors_[var_49_1.prefab_name] ~= nil then
						local var_49_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_46_1.actors_[var_49_1.prefab_name].transform, "story_v_out_104082", "104082012", "story_v_out_104082.awb")

						arg_46_1:RecordAudio("104082012", var_49_6)
						arg_46_1:RecordAudio("104082012", var_49_6)
					else
						arg_46_1:AudioAction("play", "voice", "story_v_out_104082", "104082012", "story_v_out_104082.awb")
					end

					arg_46_1:RecordHistoryTalkVoice("story_v_out_104082", "104082012", "story_v_out_104082.awb")
				end

				arg_46_1:RecordContent(arg_46_1.text_.text)
			end

			local var_49_7 = math.max(var_49_0, arg_46_1.talkMaxDuration)

			if 0 <= arg_46_1.time_ and arg_46_1.time_ < 0 + var_49_7 then
				arg_46_1.typewritter.percent = (arg_46_1.time_ - 0) / var_49_7

				arg_46_1.typewritter:SetDirty()
			end

			if arg_46_1.time_ >= 0 + var_49_7 and arg_46_1.time_ < 0 + var_49_7 + arg_49_0 then
				arg_46_1.typewritter.percent = 1

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(true)
			end
		end

		arg_46_1.nodeConfigList_ = {}

		arg_46_1:InitPlayNodeList()
	end,
	Play104082013 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 104082013
		arg_50_1.duration_ = 5.1

		local var_50_0 = {
			ja = 4.833,
			ko = 3.9,
			zh = 3.666,
			en = 5.1
		}
		local var_50_1 = manager.audio:GetLocalizationFlag()

		if var_50_0[var_50_1] ~= nil then
			arg_50_1.duration_ = var_50_0[var_50_1]
		end

		SetActive(arg_50_1.tipsGo_, false)

		function arg_50_1.onSingleLineFinish_()
			arg_50_1.onSingleLineUpdate_ = nil
			arg_50_1.onSingleLineFinish_ = nil
			arg_50_1.state_ = "waiting"
		end

		function arg_50_1.playNext_(arg_52_0)
			if arg_52_0 == 1 then
				arg_50_0:Play104082014(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			local var_53_0 = 0.5

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, true)

				arg_50_1.leftNameTxt_.text = arg_50_1:FormatText(StoryNameCfg[61].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_50_1.leftNameTxt_.transform)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1.leftNameTxt_.text)
				SetActive(arg_50_1.iconTrs_.gameObject, false)
				arg_50_1.callingController_:SetSelectedState("normal")

				local var_53_1 = arg_50_1:GetWordFromCfg(104082013)
				local var_53_2 = arg_50_1:FormatText(var_53_1.content)

				arg_50_1.text_.text = var_53_2

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_4 = 20 <= 0 and var_53_0 or var_53_0 * (utf8.len(var_53_2) / 20)

				if (20 <= 0 and var_53_0 or var_53_0 * (utf8.len(var_53_2) / 20)) > 0 and var_53_0 < var_53_4 then
					arg_50_1.talkMaxDuration = var_53_4

					if var_53_4 + 0 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_4 + 0
					end
				end

				arg_50_1.text_.text = var_53_2
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104082", "104082013", "story_v_out_104082.awb") ~= 0 then
					local var_53_5 = manager.audio:GetVoiceLength("story_v_out_104082", "104082013", "story_v_out_104082.awb") / 1000

					if var_53_5 + 0 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_5 + 0
					end

					if var_53_1.prefab_name ~= "" and arg_50_1.actors_[var_53_1.prefab_name] ~= nil then
						local var_53_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_50_1.actors_[var_53_1.prefab_name].transform, "story_v_out_104082", "104082013", "story_v_out_104082.awb")

						arg_50_1:RecordAudio("104082013", var_53_6)
						arg_50_1:RecordAudio("104082013", var_53_6)
					else
						arg_50_1:AudioAction("play", "voice", "story_v_out_104082", "104082013", "story_v_out_104082.awb")
					end

					arg_50_1:RecordHistoryTalkVoice("story_v_out_104082", "104082013", "story_v_out_104082.awb")
				end

				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_7 = math.max(var_53_0, arg_50_1.talkMaxDuration)

			if 0 <= arg_50_1.time_ and arg_50_1.time_ < 0 + var_53_7 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - 0) / var_53_7

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= 0 + var_53_7 and arg_50_1.time_ < 0 + var_53_7 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {}

		arg_50_1:InitPlayNodeList()
	end,
	Play104082014 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 104082014
		arg_54_1.duration_ = 6

		local var_54_0 = {
			ja = 6,
			ko = 4.633,
			zh = 3.666,
			en = 5.233
		}
		local var_54_1 = manager.audio:GetLocalizationFlag()

		if var_54_0[var_54_1] ~= nil then
			arg_54_1.duration_ = var_54_0[var_54_1]
		end

		SetActive(arg_54_1.tipsGo_, false)

		function arg_54_1.onSingleLineFinish_()
			arg_54_1.onSingleLineUpdate_ = nil
			arg_54_1.onSingleLineFinish_ = nil
			arg_54_1.state_ = "waiting"
		end

		function arg_54_1.playNext_(arg_56_0)
			if arg_56_0 == 1 then
				arg_54_0:Play104082015(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			local var_57_0 = 0.425

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, true)

				arg_54_1.leftNameTxt_.text = arg_54_1:FormatText(StoryNameCfg[61].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_54_1.leftNameTxt_.transform)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1.leftNameTxt_.text)
				SetActive(arg_54_1.iconTrs_.gameObject, false)
				arg_54_1.callingController_:SetSelectedState("normal")

				local var_57_1 = arg_54_1:GetWordFromCfg(104082014)
				local var_57_2 = arg_54_1:FormatText(var_57_1.content)

				arg_54_1.text_.text = var_57_2

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_4 = 17 <= 0 and var_57_0 or var_57_0 * (utf8.len(var_57_2) / 17)

				if (17 <= 0 and var_57_0 or var_57_0 * (utf8.len(var_57_2) / 17)) > 0 and var_57_0 < var_57_4 then
					arg_54_1.talkMaxDuration = var_57_4

					if var_57_4 + 0 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_4 + 0
					end
				end

				arg_54_1.text_.text = var_57_2
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104082", "104082014", "story_v_out_104082.awb") ~= 0 then
					local var_57_5 = manager.audio:GetVoiceLength("story_v_out_104082", "104082014", "story_v_out_104082.awb") / 1000

					if var_57_5 + 0 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_5 + 0
					end

					if var_57_1.prefab_name ~= "" and arg_54_1.actors_[var_57_1.prefab_name] ~= nil then
						local var_57_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_54_1.actors_[var_57_1.prefab_name].transform, "story_v_out_104082", "104082014", "story_v_out_104082.awb")

						arg_54_1:RecordAudio("104082014", var_57_6)
						arg_54_1:RecordAudio("104082014", var_57_6)
					else
						arg_54_1:AudioAction("play", "voice", "story_v_out_104082", "104082014", "story_v_out_104082.awb")
					end

					arg_54_1:RecordHistoryTalkVoice("story_v_out_104082", "104082014", "story_v_out_104082.awb")
				end

				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_7 = math.max(var_57_0, arg_54_1.talkMaxDuration)

			if 0 <= arg_54_1.time_ and arg_54_1.time_ < 0 + var_57_7 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - 0) / var_57_7

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= 0 + var_57_7 and arg_54_1.time_ < 0 + var_57_7 + arg_57_0 then
				arg_54_1.typewritter.percent = 1

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(true)
			end
		end

		arg_54_1.nodeConfigList_ = {}

		arg_54_1:InitPlayNodeList()
	end,
	Play104082015 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 104082015
		arg_58_1.duration_ = 2.33

		local var_58_0 = {
			ja = 2.1,
			ko = 2.333,
			zh = 1.9,
			en = 1.833
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
				arg_58_0:Play104082016(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			local var_61_0 = 0.25

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, true)

				arg_58_1.leftNameTxt_.text = arg_58_1:FormatText(StoryNameCfg[59].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, false)
				arg_58_1.callingController_:SetSelectedState("normal")

				local var_61_1 = arg_58_1:GetWordFromCfg(104082015)
				local var_61_2 = arg_58_1:FormatText(var_61_1.content)

				arg_58_1.text_.text = var_61_2

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_4 = 10 <= 0 and var_61_0 or var_61_0 * (utf8.len(var_61_2) / 10)

				if (10 <= 0 and var_61_0 or var_61_0 * (utf8.len(var_61_2) / 10)) > 0 and var_61_0 < var_61_4 then
					arg_58_1.talkMaxDuration = var_61_4

					if var_61_4 + 0 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_4 + 0
					end
				end

				arg_58_1.text_.text = var_61_2
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104082", "104082015", "story_v_out_104082.awb") ~= 0 then
					local var_61_5 = manager.audio:GetVoiceLength("story_v_out_104082", "104082015", "story_v_out_104082.awb") / 1000

					if var_61_5 + 0 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_5 + 0
					end

					if var_61_1.prefab_name ~= "" and arg_58_1.actors_[var_61_1.prefab_name] ~= nil then
						local var_61_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_58_1.actors_[var_61_1.prefab_name].transform, "story_v_out_104082", "104082015", "story_v_out_104082.awb")

						arg_58_1:RecordAudio("104082015", var_61_6)
						arg_58_1:RecordAudio("104082015", var_61_6)
					else
						arg_58_1:AudioAction("play", "voice", "story_v_out_104082", "104082015", "story_v_out_104082.awb")
					end

					arg_58_1:RecordHistoryTalkVoice("story_v_out_104082", "104082015", "story_v_out_104082.awb")
				end

				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_7 = math.max(var_61_0, arg_58_1.talkMaxDuration)

			if 0 <= arg_58_1.time_ and arg_58_1.time_ < 0 + var_61_7 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - 0) / var_61_7

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= 0 + var_61_7 and arg_58_1.time_ < 0 + var_61_7 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {}

		arg_58_1:InitPlayNodeList()
	end,
	Play104082016 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 104082016
		arg_62_1.duration_ = 5

		SetActive(arg_62_1.tipsGo_, false)

		function arg_62_1.onSingleLineFinish_()
			arg_62_1.onSingleLineUpdate_ = nil
			arg_62_1.onSingleLineFinish_ = nil
			arg_62_1.state_ = "waiting"
			arg_62_1.auto_ = false
		end

		function arg_62_1.playNext_(arg_64_0)
			arg_62_1.onStoryFinished_()
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			local var_65_0 = 1.2

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, false)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_62_1.iconTrs_.gameObject, false)
				arg_62_1.callingController_:SetSelectedState("normal")

				local var_65_1 = arg_62_1:FormatText(arg_62_1:GetWordFromCfg(104082016).content)

				arg_62_1.text_.text = var_65_1

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_3 = 47 <= 0 and var_65_0 or var_65_0 * (utf8.len(var_65_1) / 47)

				if (47 <= 0 and var_65_0 or var_65_0 * (utf8.len(var_65_1) / 47)) > 0 and var_65_0 < var_65_3 then
					arg_62_1.talkMaxDuration = var_65_3

					if var_65_3 + 0 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_3 + 0
					end
				end

				arg_62_1.text_.text = var_65_1
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)
				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_4 = math.max(var_65_0, arg_62_1.talkMaxDuration)

			if 0 <= arg_62_1.time_ and arg_62_1.time_ < 0 + var_65_4 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - 0) / var_65_4

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= 0 + var_65_4 and arg_62_1.time_ < 0 + var_65_4 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {}

		arg_62_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/B13",
		"TextureConfig/Background/S0405"
	},
	voices = {
		"story_v_out_104082.awb"
	}
}
