return {
	Play101131001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 101131001
		arg_1_1.duration_ = 7.3

		local var_1_0 = {
			ja = 7.3,
			ko = 5.5,
			zh = 7.133,
			en = 4.366
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
				arg_1_0:Play101131002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1.awb")

				local var_4_2 = manager.audio:GetAudioName("bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1")

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
				arg_1_1:AudioAction("play", "effect", "se_story_v1_environment_factory", "se_story_v1_environment_factory", "se_story_v1_environment_factory.awb")
			end

			local var_4_4 = "2020_tpose"

			if arg_1_1.actors_["2020_tpose"] == nil and not isNil((Asset.Load("Char/" .. "2020_tpose"))) then
				local var_4_5 = Object.Instantiate(Asset.Load("Char/" .. "2020_tpose"), arg_1_1.stage_.transform)

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

			local var_4_8 = arg_1_1.actors_["2020_tpose"]

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 and not isNil(var_4_8) and arg_1_1.var_.characterEffect2020_tpose == nil then
				arg_1_1.var_.characterEffect2020_tpose = var_4_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_9 = 0.1

			if 2 <= arg_1_1.time_ and arg_1_1.time_ < 2 + var_4_9 and not isNil(var_4_8) then
				if arg_1_1.var_.characterEffect2020_tpose and not isNil(var_4_8) then
					arg_1_1.var_.characterEffect2020_tpose.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 2 + var_4_9 and arg_1_1.time_ < 2 + var_4_9 + arg_4_0 and not isNil(var_4_8) and arg_1_1.var_.characterEffect2020_tpose then
				arg_1_1.var_.characterEffect2020_tpose.fillFlat = false
			end

			local var_4_11 = "B02f"

			if arg_1_1.bgs_.B02f == nil then
				local var_4_12 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_12:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_11)
				var_4_12.name = var_4_11
				var_4_12.transform.parent = arg_1_1.stage_.transform
				var_4_12.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_11] = var_4_12
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_13 = arg_1_1.bgs_.B02f:GetComponent("SpriteRenderer")

				if var_4_13 then
					arg_1_1.var_.alphaOldValueB02f = var_4_13.color.a
					arg_1_1.var_.alphaMatValueB02f = var_4_13
				end

				arg_1_1.var_.alphaOldValueB02f = 0
			end

			local var_4_14 = 1.5

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_14 then
				if arg_1_1.var_.alphaMatValueB02f then
					arg_1_1.var_.alphaMatValueB02f.color.a = Mathf.Lerp(arg_1_1.var_.alphaOldValueB02f, 1, (arg_1_1.time_ - 0) / var_4_14)
					arg_1_1.var_.alphaMatValueB02f.color = arg_1_1.var_.alphaMatValueB02f.color
				end
			end

			if arg_1_1.time_ >= 0 + var_4_14 and arg_1_1.time_ < 0 + var_4_14 + arg_4_0 and arg_1_1.var_.alphaMatValueB02f then
				arg_1_1.var_.alphaMatValueB02f.color.a = 1
				arg_1_1.var_.alphaMatValueB02f.color = arg_1_1.var_.alphaMatValueB02f.color
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_15 = arg_1_1.bgs_.B02f

				arg_1_1.bgs_.B02f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_15.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_16 = var_4_15:GetComponent("SpriteRenderer")

				if var_4_16 and var_4_16.sprite then
					local var_4_17 = 2 * (var_4_15.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_15.transform.localScale = Vector3.New(var_4_17 / var_4_16.sprite.bounds.size.y < var_4_17 * manager.ui.mainCameraCom_.aspect / var_4_16.sprite.bounds.size.x and var_4_17 * manager.ui.mainCameraCom_.aspect / var_4_16.sprite.bounds.size.x or var_4_17 / var_4_16.sprite.bounds.size.y, var_4_17 / var_4_16.sprite.bounds.size.y < var_4_17 * manager.ui.mainCameraCom_.aspect / var_4_16.sprite.bounds.size.x and var_4_17 * manager.ui.mainCameraCom_.aspect / var_4_16.sprite.bounds.size.x or var_4_17 / var_4_16.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "B02f" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_18 = arg_1_1.actors_["2020_tpose"].transform

			if 1.79999995231628 < arg_1_1.time_ and arg_1_1.time_ <= 1.79999995231628 + arg_4_0 then
				arg_1_1.var_.moveOldPos2020_tpose = var_4_18.localPosition

				local var_4_19 = GameObjectTools.GetOrAddComponent(var_4_18.gameObject, typeof(DynamicBoneHelper))

				if var_4_19 then
					var_4_19:EnableDynamicBone(false)
				end
			end

			local var_4_20 = 0.001

			if 1.79999995231628 <= arg_1_1.time_ and arg_1_1.time_ < 1.79999995231628 + var_4_20 then
				var_4_18.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos2020_tpose, Vector3.New(0, -1.2, -4.1), (arg_1_1.time_ - 1.79999995231628) / var_4_20)
				var_4_18.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_18.position).x, (manager.ui.mainCamera.transform.position - var_4_18.position).y, (manager.ui.mainCamera.transform.position - var_4_18.position).z)
				var_4_18.localEulerAngles.z = 0
				var_4_18.localEulerAngles.x = 0
				var_4_18.localEulerAngles = var_4_18.localEulerAngles
			end

			if arg_1_1.time_ >= 1.79999995231628 + var_4_20 and arg_1_1.time_ < 1.79999995231628 + var_4_20 + arg_4_0 then
				var_4_18.localPosition = Vector3.New(0, -1.2, -4.1)
				var_4_18.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_18.position).x, (manager.ui.mainCamera.transform.position - var_4_18.position).y, (manager.ui.mainCamera.transform.position - var_4_18.position).z)
				var_4_18.localEulerAngles.z = 0
				var_4_18.localEulerAngles.x = 0
				var_4_18.localEulerAngles = var_4_18.localEulerAngles

				local var_4_21 = GameObjectTools.GetOrAddComponent(var_4_18.gameObject, typeof(DynamicBoneHelper))

				if var_4_21 then
					var_4_21:EnableDynamicBone(true)
				end
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:PlayTimeline("2020_tpose", "StoryTimeline/CharAction/story2020/story2020action/2020action1_1")
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
			local var_4_24 = 0.375

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

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[19].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_26 = arg_1_1:GetWordFromCfg(101131001)
				local var_4_27 = arg_1_1:FormatText(var_4_26.content)

				arg_1_1.text_.text = var_4_27

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_29 = 15 <= 0 and var_4_24 or var_4_24 * (utf8.len(var_4_27) / 15)

				if (15 <= 0 and var_4_24 or var_4_24 * (utf8.len(var_4_27) / 15)) > 0 and var_4_24 < var_4_29 then
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

				if manager.audio:GetVoiceLength("story_v_out_101131", "101131001", "story_v_out_101131.awb") ~= 0 then
					local var_4_30 = manager.audio:GetVoiceLength("story_v_out_101131", "101131001", "story_v_out_101131.awb") / 1000

					if var_4_30 + var_4_23 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_30 + var_4_23
					end

					if var_4_26.prefab_name ~= "" and arg_1_1.actors_[var_4_26.prefab_name] ~= nil then
						local var_4_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_26.prefab_name].transform, "story_v_out_101131", "101131001", "story_v_out_101131.awb")

						arg_1_1:RecordAudio("101131001", var_4_31)
						arg_1_1:RecordAudio("101131001", var_4_31)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_101131", "101131001", "story_v_out_101131.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_101131", "101131001", "story_v_out_101131.awb")
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
				actorName = "2020_tpose",
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
	Play101131002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 101131002
		arg_8_1.duration_ = 5.3

		local var_8_0 = {
			ja = 5.3,
			ko = 4.2,
			zh = 3,
			en = 3.533
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
				arg_8_0:Play101131003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			if arg_8_1.actors_["1084ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1084ui_story"))) then
				local var_11_0 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_8_1.stage_.transform)

				var_11_0.name = "1084ui_story"
				var_11_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_8_1.actors_["1084ui_story"] = var_11_0

				local var_11_1 = var_11_0:GetComponentInChildren(typeof(CharacterEffect))

				var_11_1.enabled = true

				local var_11_2 = GameObjectTools.GetOrAddComponent(var_11_0, typeof(DynamicBoneHelper))

				if var_11_2 then
					var_11_2:EnableDynamicBone(false)
				end

				arg_8_1:ShowWeapon(var_11_1.transform, false)

				arg_8_1.var_["1084ui_story" .. "Animator"] = var_11_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_8_1.var_["1084ui_story" .. "Animator"].applyRootMotion = true
				arg_8_1.var_["1084ui_story" .. "LipSync"] = var_11_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_11_3 = arg_8_1.actors_["1084ui_story"]

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 and not isNil(var_11_3) and arg_8_1.var_.characterEffect1084ui_story == nil then
				arg_8_1.var_.characterEffect1084ui_story = var_11_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_4 = 0.1

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_4 and not isNil(var_11_3) then
				if arg_8_1.var_.characterEffect1084ui_story and not isNil(var_11_3) then
					arg_8_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_8_1.time_ >= 0 + var_11_4 and arg_8_1.time_ < 0 + var_11_4 + arg_11_0 and not isNil(var_11_3) and arg_8_1.var_.characterEffect1084ui_story then
				arg_8_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_11_6 = arg_8_1.actors_["2020_tpose"]

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 and not isNil(var_11_6) and arg_8_1.var_.characterEffect2020_tpose == nil then
				arg_8_1.var_.characterEffect2020_tpose = var_11_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_7 = 0.1

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_7 and not isNil(var_11_6) then
				if arg_8_1.var_.characterEffect2020_tpose and not isNil(var_11_6) then
					arg_8_1.var_.characterEffect2020_tpose.fillFlat = true
					arg_8_1.var_.characterEffect2020_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_8_1.time_ - 0) / var_11_7)
				end
			end

			if arg_8_1.time_ >= 0 + var_11_7 and arg_8_1.time_ < 0 + var_11_7 + arg_11_0 and not isNil(var_11_6) and arg_8_1.var_.characterEffect2020_tpose then
				arg_8_1.var_.characterEffect2020_tpose.fillFlat = true
				arg_8_1.var_.characterEffect2020_tpose.fillRatio = 0.5
			end

			local var_11_8 = arg_8_1.actors_["2020_tpose"].transform

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1.var_.moveOldPos2020_tpose = var_11_8.localPosition

				local var_11_9 = GameObjectTools.GetOrAddComponent(var_11_8.gameObject, typeof(DynamicBoneHelper))

				if var_11_9 then
					var_11_9:EnableDynamicBone(false)
				end
			end

			local var_11_10 = 0.001

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_10 then
				var_11_8.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos2020_tpose, Vector3.New(0.7, -1.2, -4.1), (arg_8_1.time_ - 0) / var_11_10)
				var_11_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_11_8.position).x, (manager.ui.mainCamera.transform.position - var_11_8.position).y, (manager.ui.mainCamera.transform.position - var_11_8.position).z)
				var_11_8.localEulerAngles.z = 0
				var_11_8.localEulerAngles.x = 0
				var_11_8.localEulerAngles = var_11_8.localEulerAngles
			end

			if arg_8_1.time_ >= 0 + var_11_10 and arg_8_1.time_ < 0 + var_11_10 + arg_11_0 then
				var_11_8.localPosition = Vector3.New(0.7, -1.2, -4.1)
				var_11_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_11_8.position).x, (manager.ui.mainCamera.transform.position - var_11_8.position).y, (manager.ui.mainCamera.transform.position - var_11_8.position).z)
				var_11_8.localEulerAngles.z = 0
				var_11_8.localEulerAngles.x = 0
				var_11_8.localEulerAngles = var_11_8.localEulerAngles

				local var_11_11 = GameObjectTools.GetOrAddComponent(var_11_8.gameObject, typeof(DynamicBoneHelper))

				if var_11_11 then
					var_11_11:EnableDynamicBone(true)
				end
			end

			local var_11_12 = arg_8_1.actors_["1084ui_story"].transform

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1.var_.moveOldPos1084ui_story = var_11_12.localPosition
			end

			local var_11_13 = 0.001

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_13 then
				var_11_12.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos1084ui_story, Vector3.New(-0.7, -0.97, -6), (arg_8_1.time_ - 0) / var_11_13)
				var_11_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_11_12.position).x, (manager.ui.mainCamera.transform.position - var_11_12.position).y, (manager.ui.mainCamera.transform.position - var_11_12.position).z)
				var_11_12.localEulerAngles.z = 0
				var_11_12.localEulerAngles.x = 0
				var_11_12.localEulerAngles = var_11_12.localEulerAngles
			end

			if arg_8_1.time_ >= 0 + var_11_13 and arg_8_1.time_ < 0 + var_11_13 + arg_11_0 then
				var_11_12.localPosition = Vector3.New(-0.7, -0.97, -6)
				var_11_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_11_12.position).x, (manager.ui.mainCamera.transform.position - var_11_12.position).y, (manager.ui.mainCamera.transform.position - var_11_12.position).z)
				var_11_12.localEulerAngles.z = 0
				var_11_12.localEulerAngles.x = 0
				var_11_12.localEulerAngles = var_11_12.localEulerAngles
			end

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action12_1")
			end

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_11_14 = 0
			local var_11_15 = 0.35

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_14 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				arg_8_1.leftNameTxt_.text = arg_8_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_16 = arg_8_1:GetWordFromCfg(101131002)
				local var_11_17 = arg_8_1:FormatText(var_11_16.content)

				arg_8_1.text_.text = var_11_17

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_19 = 12 <= 0 and var_11_15 or var_11_15 * (utf8.len(var_11_17) / 12)

				if (12 <= 0 and var_11_15 or var_11_15 * (utf8.len(var_11_17) / 12)) > 0 and var_11_15 < var_11_19 then
					arg_8_1.talkMaxDuration = var_11_19

					if var_11_19 + var_11_14 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_19 + var_11_14
					end
				end

				arg_8_1.text_.text = var_11_17
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101131", "101131002", "story_v_out_101131.awb") ~= 0 then
					local var_11_20 = manager.audio:GetVoiceLength("story_v_out_101131", "101131002", "story_v_out_101131.awb") / 1000

					if var_11_20 + var_11_14 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_20 + var_11_14
					end

					if var_11_16.prefab_name ~= "" and arg_8_1.actors_[var_11_16.prefab_name] ~= nil then
						local var_11_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_16.prefab_name].transform, "story_v_out_101131", "101131002", "story_v_out_101131.awb")

						arg_8_1:RecordAudio("101131002", var_11_21)
						arg_8_1:RecordAudio("101131002", var_11_21)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_101131", "101131002", "story_v_out_101131.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_101131", "101131002", "story_v_out_101131.awb")
				end

				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_22 = math.max(var_11_15, arg_8_1.talkMaxDuration)

			if var_11_14 <= arg_8_1.time_ and arg_8_1.time_ < var_11_14 + var_11_22 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_14) / var_11_22

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_14 + var_11_22 and arg_8_1.time_ < var_11_14 + var_11_22 + arg_11_0 then
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
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
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
	Play101131003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 101131003
		arg_12_1.duration_ = 4.6

		local var_12_0 = {
			ja = 4.6,
			ko = 1.999999999999,
			zh = 2,
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
				arg_12_0:Play101131004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 and not isNil(arg_12_1.actors_["2020_tpose"]) and arg_12_1.var_.characterEffect2020_tpose == nil then
				arg_12_1.var_.characterEffect2020_tpose = arg_12_1.actors_["2020_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_0 = 0.1

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_0 and not isNil(arg_12_1.actors_["2020_tpose"]) then
				if arg_12_1.var_.characterEffect2020_tpose and not isNil(arg_12_1.actors_["2020_tpose"]) then
					arg_12_1.var_.characterEffect2020_tpose.fillFlat = false
				end
			end

			if arg_12_1.time_ >= 0 + var_15_0 and arg_12_1.time_ < 0 + var_15_0 + arg_15_0 and not isNil(arg_12_1.actors_["2020_tpose"]) and arg_12_1.var_.characterEffect2020_tpose then
				arg_12_1.var_.characterEffect2020_tpose.fillFlat = false
			end

			local var_15_2 = arg_12_1.actors_["1084ui_story"]

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 and not isNil(var_15_2) and arg_12_1.var_.characterEffect1084ui_story == nil then
				arg_12_1.var_.characterEffect1084ui_story = var_15_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_3 = 0.1

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_3 and not isNil(var_15_2) then
				if arg_12_1.var_.characterEffect1084ui_story and not isNil(var_15_2) then
					arg_12_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_12_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_12_1.time_ - 0) / var_15_3)
				end
			end

			if arg_12_1.time_ >= 0 + var_15_3 and arg_12_1.time_ < 0 + var_15_3 + arg_15_0 and not isNil(var_15_2) and arg_12_1.var_.characterEffect1084ui_story then
				arg_12_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_12_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_15_4 = arg_12_1.actors_["2020_tpose"].transform

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1.var_.moveOldPos2020_tpose = var_15_4.localPosition

				local var_15_5 = GameObjectTools.GetOrAddComponent(var_15_4.gameObject, typeof(DynamicBoneHelper))

				if var_15_5 then
					var_15_5:EnableDynamicBone(false)
				end
			end

			local var_15_6 = 0.001

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_6 then
				var_15_4.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos2020_tpose, Vector3.New(0.7, -1.2, -4.1), (arg_12_1.time_ - 0) / var_15_6)
				var_15_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_15_4.position).x, (manager.ui.mainCamera.transform.position - var_15_4.position).y, (manager.ui.mainCamera.transform.position - var_15_4.position).z)
				var_15_4.localEulerAngles.z = 0
				var_15_4.localEulerAngles.x = 0
				var_15_4.localEulerAngles = var_15_4.localEulerAngles
			end

			if arg_12_1.time_ >= 0 + var_15_6 and arg_12_1.time_ < 0 + var_15_6 + arg_15_0 then
				var_15_4.localPosition = Vector3.New(0.7, -1.2, -4.1)
				var_15_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_15_4.position).x, (manager.ui.mainCamera.transform.position - var_15_4.position).y, (manager.ui.mainCamera.transform.position - var_15_4.position).z)
				var_15_4.localEulerAngles.z = 0
				var_15_4.localEulerAngles.x = 0
				var_15_4.localEulerAngles = var_15_4.localEulerAngles

				local var_15_7 = GameObjectTools.GetOrAddComponent(var_15_4.gameObject, typeof(DynamicBoneHelper))

				if var_15_7 then
					var_15_7:EnableDynamicBone(true)
				end
			end

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1:PlayTimeline("2020_tpose", "StoryTimeline/CharAction/story2020/story2020action/2020action1_1")
			end

			local var_15_8 = 0
			local var_15_9 = 0.15

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_8 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				arg_12_1.leftNameTxt_.text = arg_12_1:FormatText(StoryNameCfg[19].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_10 = arg_12_1:GetWordFromCfg(101131003)
				local var_15_11 = arg_12_1:FormatText(var_15_10.content)

				arg_12_1.text_.text = var_15_11

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_13 = 6 <= 0 and var_15_9 or var_15_9 * (utf8.len(var_15_11) / 6)

				if (6 <= 0 and var_15_9 or var_15_9 * (utf8.len(var_15_11) / 6)) > 0 and var_15_9 < var_15_13 then
					arg_12_1.talkMaxDuration = var_15_13

					if var_15_13 + var_15_8 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_13 + var_15_8
					end
				end

				arg_12_1.text_.text = var_15_11
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101131", "101131003", "story_v_out_101131.awb") ~= 0 then
					local var_15_14 = manager.audio:GetVoiceLength("story_v_out_101131", "101131003", "story_v_out_101131.awb") / 1000

					if var_15_14 + var_15_8 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_14 + var_15_8
					end

					if var_15_10.prefab_name ~= "" and arg_12_1.actors_[var_15_10.prefab_name] ~= nil then
						local var_15_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_10.prefab_name].transform, "story_v_out_101131", "101131003", "story_v_out_101131.awb")

						arg_12_1:RecordAudio("101131003", var_15_15)
						arg_12_1:RecordAudio("101131003", var_15_15)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_101131", "101131003", "story_v_out_101131.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_101131", "101131003", "story_v_out_101131.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_16 = math.max(var_15_9, arg_12_1.talkMaxDuration)

			if var_15_8 <= arg_12_1.time_ and arg_12_1.time_ < var_15_8 + var_15_16 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_8) / var_15_16

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_8 + var_15_16 and arg_12_1.time_ < var_15_8 + var_15_16 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {
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

		arg_12_1:InitPlayNodeList()
	end,
	Play101131004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 101131004
		arg_16_1.duration_ = 7.5

		local var_16_0 = {
			ja = 7.5,
			ko = 6.566,
			zh = 6.6,
			en = 6.333
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
				arg_16_0:Play101131005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			if arg_16_1.actors_["1011ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1011ui_story"))) then
				local var_19_0 = Object.Instantiate(Asset.Load("Char/" .. "1011ui_story"), arg_16_1.stage_.transform)

				var_19_0.name = "1011ui_story"
				var_19_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_16_1.actors_["1011ui_story"] = var_19_0

				local var_19_1 = var_19_0:GetComponentInChildren(typeof(CharacterEffect))

				var_19_1.enabled = true

				local var_19_2 = GameObjectTools.GetOrAddComponent(var_19_0, typeof(DynamicBoneHelper))

				if var_19_2 then
					var_19_2:EnableDynamicBone(false)
				end

				arg_16_1:ShowWeapon(var_19_1.transform, false)

				arg_16_1.var_["1011ui_story" .. "Animator"] = var_19_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_16_1.var_["1011ui_story" .. "Animator"].applyRootMotion = true
				arg_16_1.var_["1011ui_story" .. "LipSync"] = var_19_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_19_3 = arg_16_1.actors_["1011ui_story"]

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 and not isNil(var_19_3) and arg_16_1.var_.characterEffect1011ui_story == nil then
				arg_16_1.var_.characterEffect1011ui_story = var_19_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_4 = 0.1

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_4 and not isNil(var_19_3) then
				if arg_16_1.var_.characterEffect1011ui_story and not isNil(var_19_3) then
					arg_16_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_16_1.time_ >= 0 + var_19_4 and arg_16_1.time_ < 0 + var_19_4 + arg_19_0 and not isNil(var_19_3) and arg_16_1.var_.characterEffect1011ui_story then
				arg_16_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_19_6 = arg_16_1.actors_["2020_tpose"]

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 and not isNil(var_19_6) and arg_16_1.var_.characterEffect2020_tpose == nil then
				arg_16_1.var_.characterEffect2020_tpose = var_19_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_7 = 0.1

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_7 and not isNil(var_19_6) then
				if arg_16_1.var_.characterEffect2020_tpose and not isNil(var_19_6) then
					arg_16_1.var_.characterEffect2020_tpose.fillFlat = true
					arg_16_1.var_.characterEffect2020_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_16_1.time_ - 0) / var_19_7)
				end
			end

			if arg_16_1.time_ >= 0 + var_19_7 and arg_16_1.time_ < 0 + var_19_7 + arg_19_0 and not isNil(var_19_6) and arg_16_1.var_.characterEffect2020_tpose then
				arg_16_1.var_.characterEffect2020_tpose.fillFlat = true
				arg_16_1.var_.characterEffect2020_tpose.fillRatio = 0.5
			end

			local var_19_8 = arg_16_1.actors_["1084ui_story"].transform

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.var_.moveOldPos1084ui_story = var_19_8.localPosition
			end

			local var_19_9 = 0.001

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_9 then
				var_19_8.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_16_1.time_ - 0) / var_19_9)
				var_19_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_19_8.position).x, (manager.ui.mainCamera.transform.position - var_19_8.position).y, (manager.ui.mainCamera.transform.position - var_19_8.position).z)
				var_19_8.localEulerAngles.z = 0
				var_19_8.localEulerAngles.x = 0
				var_19_8.localEulerAngles = var_19_8.localEulerAngles
			end

			if arg_16_1.time_ >= 0 + var_19_9 and arg_16_1.time_ < 0 + var_19_9 + arg_19_0 then
				var_19_8.localPosition = Vector3.New(0, 100, 0)
				var_19_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_19_8.position).x, (manager.ui.mainCamera.transform.position - var_19_8.position).y, (manager.ui.mainCamera.transform.position - var_19_8.position).z)
				var_19_8.localEulerAngles.z = 0
				var_19_8.localEulerAngles.x = 0
				var_19_8.localEulerAngles = var_19_8.localEulerAngles
			end

			local var_19_10 = arg_16_1.actors_["1011ui_story"].transform

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.var_.moveOldPos1011ui_story = var_19_10.localPosition
			end

			local var_19_11 = 0.001

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_11 then
				var_19_10.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos1011ui_story, Vector3.New(-0.7, -0.71, -6), (arg_16_1.time_ - 0) / var_19_11)
				var_19_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_19_10.position).x, (manager.ui.mainCamera.transform.position - var_19_10.position).y, (manager.ui.mainCamera.transform.position - var_19_10.position).z)
				var_19_10.localEulerAngles.z = 0
				var_19_10.localEulerAngles.x = 0
				var_19_10.localEulerAngles = var_19_10.localEulerAngles
			end

			if arg_16_1.time_ >= 0 + var_19_11 and arg_16_1.time_ < 0 + var_19_11 + arg_19_0 then
				var_19_10.localPosition = Vector3.New(-0.7, -0.71, -6)
				var_19_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_19_10.position).x, (manager.ui.mainCamera.transform.position - var_19_10.position).y, (manager.ui.mainCamera.transform.position - var_19_10.position).z)
				var_19_10.localEulerAngles.z = 0
				var_19_10.localEulerAngles.x = 0
				var_19_10.localEulerAngles = var_19_10.localEulerAngles
			end

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action2_1")
			end

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_19_12 = 0
			local var_19_13 = 0.8

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_12 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				arg_16_1.leftNameTxt_.text = arg_16_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_14 = arg_16_1:GetWordFromCfg(101131004)
				local var_19_15 = arg_16_1:FormatText(var_19_14.content)

				arg_16_1.text_.text = var_19_15

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_17 = 30 <= 0 and var_19_13 or var_19_13 * (utf8.len(var_19_15) / 30)

				if (30 <= 0 and var_19_13 or var_19_13 * (utf8.len(var_19_15) / 30)) > 0 and var_19_13 < var_19_17 then
					arg_16_1.talkMaxDuration = var_19_17

					if var_19_17 + var_19_12 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_17 + var_19_12
					end
				end

				arg_16_1.text_.text = var_19_15
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101131", "101131004", "story_v_out_101131.awb") ~= 0 then
					local var_19_18 = manager.audio:GetVoiceLength("story_v_out_101131", "101131004", "story_v_out_101131.awb") / 1000

					if var_19_18 + var_19_12 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_18 + var_19_12
					end

					if var_19_14.prefab_name ~= "" and arg_16_1.actors_[var_19_14.prefab_name] ~= nil then
						local var_19_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_14.prefab_name].transform, "story_v_out_101131", "101131004", "story_v_out_101131.awb")

						arg_16_1:RecordAudio("101131004", var_19_19)
						arg_16_1:RecordAudio("101131004", var_19_19)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_101131", "101131004", "story_v_out_101131.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_101131", "101131004", "story_v_out_101131.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_20 = math.max(var_19_13, arg_16_1.talkMaxDuration)

			if var_19_12 <= arg_16_1.time_ and arg_16_1.time_ < var_19_12 + var_19_20 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_12) / var_19_20

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_12 + var_19_20 and arg_16_1.time_ < var_19_12 + var_19_20 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
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

		arg_16_1:InitPlayNodeList()
	end,
	Play101131005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 101131005
		arg_20_1.duration_ = 6.67

		local var_20_0 = {
			ja = 5.966,
			ko = 5.6,
			zh = 6.466,
			en = 6.666
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
				arg_20_0:Play101131006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			if arg_20_1.actors_["1019ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1019ui_story"))) then
				local var_23_0 = Object.Instantiate(Asset.Load("Char/" .. "1019ui_story"), arg_20_1.stage_.transform)

				var_23_0.name = "1019ui_story"
				var_23_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_20_1.actors_["1019ui_story"] = var_23_0

				local var_23_1 = var_23_0:GetComponentInChildren(typeof(CharacterEffect))

				var_23_1.enabled = true

				local var_23_2 = GameObjectTools.GetOrAddComponent(var_23_0, typeof(DynamicBoneHelper))

				if var_23_2 then
					var_23_2:EnableDynamicBone(false)
				end

				arg_20_1:ShowWeapon(var_23_1.transform, false)

				arg_20_1.var_["1019ui_story" .. "Animator"] = var_23_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_20_1.var_["1019ui_story" .. "Animator"].applyRootMotion = true
				arg_20_1.var_["1019ui_story" .. "LipSync"] = var_23_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_23_3 = arg_20_1.actors_["1019ui_story"]

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 and not isNil(var_23_3) and arg_20_1.var_.characterEffect1019ui_story == nil then
				arg_20_1.var_.characterEffect1019ui_story = var_23_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_4 = 0.1

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_4 and not isNil(var_23_3) then
				if arg_20_1.var_.characterEffect1019ui_story and not isNil(var_23_3) then
					arg_20_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_20_1.time_ >= 0 + var_23_4 and arg_20_1.time_ < 0 + var_23_4 + arg_23_0 and not isNil(var_23_3) and arg_20_1.var_.characterEffect1019ui_story then
				arg_20_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_23_6 = arg_20_1.actors_["2020_tpose"]

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 and not isNil(var_23_6) and arg_20_1.var_.characterEffect2020_tpose == nil then
				arg_20_1.var_.characterEffect2020_tpose = var_23_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_7 = 0.1

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_7 and not isNil(var_23_6) then
				if arg_20_1.var_.characterEffect2020_tpose and not isNil(var_23_6) then
					arg_20_1.var_.characterEffect2020_tpose.fillFlat = true
					arg_20_1.var_.characterEffect2020_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_20_1.time_ - 0) / var_23_7)
				end
			end

			if arg_20_1.time_ >= 0 + var_23_7 and arg_20_1.time_ < 0 + var_23_7 + arg_23_0 and not isNil(var_23_6) and arg_20_1.var_.characterEffect2020_tpose then
				arg_20_1.var_.characterEffect2020_tpose.fillFlat = true
				arg_20_1.var_.characterEffect2020_tpose.fillRatio = 0.5
			end

			local var_23_8 = arg_20_1.actors_["1011ui_story"].transform

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1.var_.moveOldPos1011ui_story = var_23_8.localPosition
			end

			local var_23_9 = 0.001

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_9 then
				var_23_8.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos1011ui_story, Vector3.New(0.7, -0.71, -6), (arg_20_1.time_ - 0) / var_23_9)
				var_23_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_23_8.position).x, (manager.ui.mainCamera.transform.position - var_23_8.position).y, (manager.ui.mainCamera.transform.position - var_23_8.position).z)
				var_23_8.localEulerAngles.z = 0
				var_23_8.localEulerAngles.x = 0
				var_23_8.localEulerAngles = var_23_8.localEulerAngles
			end

			if arg_20_1.time_ >= 0 + var_23_9 and arg_20_1.time_ < 0 + var_23_9 + arg_23_0 then
				var_23_8.localPosition = Vector3.New(0.7, -0.71, -6)
				var_23_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_23_8.position).x, (manager.ui.mainCamera.transform.position - var_23_8.position).y, (manager.ui.mainCamera.transform.position - var_23_8.position).z)
				var_23_8.localEulerAngles.z = 0
				var_23_8.localEulerAngles.x = 0
				var_23_8.localEulerAngles = var_23_8.localEulerAngles
			end

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action5_1")
			end

			local var_23_10 = arg_20_1.actors_["1019ui_story"].transform

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1.var_.moveOldPos1019ui_story = var_23_10.localPosition
			end

			local var_23_11 = 0.001

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_11 then
				var_23_10.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos1019ui_story, Vector3.New(-0.7, -1.08, -5.9), (arg_20_1.time_ - 0) / var_23_11)
				var_23_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_23_10.position).x, (manager.ui.mainCamera.transform.position - var_23_10.position).y, (manager.ui.mainCamera.transform.position - var_23_10.position).z)
				var_23_10.localEulerAngles.z = 0
				var_23_10.localEulerAngles.x = 0
				var_23_10.localEulerAngles = var_23_10.localEulerAngles
			end

			if arg_20_1.time_ >= 0 + var_23_11 and arg_20_1.time_ < 0 + var_23_11 + arg_23_0 then
				var_23_10.localPosition = Vector3.New(-0.7, -1.08, -5.9)
				var_23_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_23_10.position).x, (manager.ui.mainCamera.transform.position - var_23_10.position).y, (manager.ui.mainCamera.transform.position - var_23_10.position).z)
				var_23_10.localEulerAngles.z = 0
				var_23_10.localEulerAngles.x = 0
				var_23_10.localEulerAngles = var_23_10.localEulerAngles
			end

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_23_12 = arg_20_1.actors_["2020_tpose"].transform

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1.var_.moveOldPos2020_tpose = var_23_12.localPosition

				local var_23_13 = GameObjectTools.GetOrAddComponent(var_23_12.gameObject, typeof(DynamicBoneHelper))

				if var_23_13 then
					var_23_13:EnableDynamicBone(false)
				end
			end

			local var_23_14 = 0.001

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_14 then
				var_23_12.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos2020_tpose, Vector3.New(0, 100, 0), (arg_20_1.time_ - 0) / var_23_14)
				var_23_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_23_12.position).x, (manager.ui.mainCamera.transform.position - var_23_12.position).y, (manager.ui.mainCamera.transform.position - var_23_12.position).z)
				var_23_12.localEulerAngles.z = 0
				var_23_12.localEulerAngles.x = 0
				var_23_12.localEulerAngles = var_23_12.localEulerAngles
			end

			if arg_20_1.time_ >= 0 + var_23_14 and arg_20_1.time_ < 0 + var_23_14 + arg_23_0 then
				var_23_12.localPosition = Vector3.New(0, 100, 0)
				var_23_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_23_12.position).x, (manager.ui.mainCamera.transform.position - var_23_12.position).y, (manager.ui.mainCamera.transform.position - var_23_12.position).z)
				var_23_12.localEulerAngles.z = 0
				var_23_12.localEulerAngles.x = 0
				var_23_12.localEulerAngles = var_23_12.localEulerAngles

				local var_23_15 = GameObjectTools.GetOrAddComponent(var_23_12.gameObject, typeof(DynamicBoneHelper))

				if var_23_15 then
					var_23_15:EnableDynamicBone(true)
				end
			end

			local var_23_16 = 0
			local var_23_17 = 0.8

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_16 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				arg_20_1.leftNameTxt_.text = arg_20_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_18 = arg_20_1:GetWordFromCfg(101131005)
				local var_23_19 = arg_20_1:FormatText(var_23_18.content)

				arg_20_1.text_.text = var_23_19

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_21 = 32 <= 0 and var_23_17 or var_23_17 * (utf8.len(var_23_19) / 32)

				if (32 <= 0 and var_23_17 or var_23_17 * (utf8.len(var_23_19) / 32)) > 0 and var_23_17 < var_23_21 then
					arg_20_1.talkMaxDuration = var_23_21

					if var_23_21 + var_23_16 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_21 + var_23_16
					end
				end

				arg_20_1.text_.text = var_23_19
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101131", "101131005", "story_v_out_101131.awb") ~= 0 then
					local var_23_22 = manager.audio:GetVoiceLength("story_v_out_101131", "101131005", "story_v_out_101131.awb") / 1000

					if var_23_22 + var_23_16 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_22 + var_23_16
					end

					if var_23_18.prefab_name ~= "" and arg_20_1.actors_[var_23_18.prefab_name] ~= nil then
						local var_23_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_18.prefab_name].transform, "story_v_out_101131", "101131005", "story_v_out_101131.awb")

						arg_20_1:RecordAudio("101131005", var_23_23)
						arg_20_1:RecordAudio("101131005", var_23_23)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_101131", "101131005", "story_v_out_101131.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_101131", "101131005", "story_v_out_101131.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_24 = math.max(var_23_17, arg_20_1.talkMaxDuration)

			if var_23_16 <= arg_20_1.time_ and arg_20_1.time_ < var_23_16 + var_23_24 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_16) / var_23_24

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_16 + var_23_24 and arg_20_1.time_ < var_23_16 + var_23_24 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {
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
			},
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

		arg_20_1:InitPlayNodeList()
	end,
	Play101131006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 101131006
		arg_24_1.duration_ = 2.93

		local var_24_0 = {
			ja = 2.933,
			ko = 2.7,
			zh = 2.833,
			en = 2.733
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
				arg_24_0:Play101131007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 and not isNil(arg_24_1.actors_["2020_tpose"]) and arg_24_1.var_.characterEffect2020_tpose == nil then
				arg_24_1.var_.characterEffect2020_tpose = arg_24_1.actors_["2020_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_0 = 0.1

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_0 and not isNil(arg_24_1.actors_["2020_tpose"]) then
				if arg_24_1.var_.characterEffect2020_tpose and not isNil(arg_24_1.actors_["2020_tpose"]) then
					arg_24_1.var_.characterEffect2020_tpose.fillFlat = false
				end
			end

			if arg_24_1.time_ >= 0 + var_27_0 and arg_24_1.time_ < 0 + var_27_0 + arg_27_0 and not isNil(arg_24_1.actors_["2020_tpose"]) and arg_24_1.var_.characterEffect2020_tpose then
				arg_24_1.var_.characterEffect2020_tpose.fillFlat = false
			end

			local var_27_2 = arg_24_1.actors_["1019ui_story"]

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 and not isNil(var_27_2) and arg_24_1.var_.characterEffect1019ui_story == nil then
				arg_24_1.var_.characterEffect1019ui_story = var_27_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_3 = 0.1

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_3 and not isNil(var_27_2) then
				if arg_24_1.var_.characterEffect1019ui_story and not isNil(var_27_2) then
					arg_24_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_24_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_24_1.time_ - 0) / var_27_3)
				end
			end

			if arg_24_1.time_ >= 0 + var_27_3 and arg_24_1.time_ < 0 + var_27_3 + arg_27_0 and not isNil(var_27_2) and arg_24_1.var_.characterEffect1019ui_story then
				arg_24_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_24_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_27_4 = arg_24_1.actors_["2020_tpose"].transform

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1.var_.moveOldPos2020_tpose = var_27_4.localPosition

				local var_27_5 = GameObjectTools.GetOrAddComponent(var_27_4.gameObject, typeof(DynamicBoneHelper))

				if var_27_5 then
					var_27_5:EnableDynamicBone(false)
				end
			end

			local var_27_6 = 0.001

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_6 then
				var_27_4.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos2020_tpose, Vector3.New(0, -1.2, -4.1), (arg_24_1.time_ - 0) / var_27_6)
				var_27_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_27_4.position).x, (manager.ui.mainCamera.transform.position - var_27_4.position).y, (manager.ui.mainCamera.transform.position - var_27_4.position).z)
				var_27_4.localEulerAngles.z = 0
				var_27_4.localEulerAngles.x = 0
				var_27_4.localEulerAngles = var_27_4.localEulerAngles
			end

			if arg_24_1.time_ >= 0 + var_27_6 and arg_24_1.time_ < 0 + var_27_6 + arg_27_0 then
				var_27_4.localPosition = Vector3.New(0, -1.2, -4.1)
				var_27_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_27_4.position).x, (manager.ui.mainCamera.transform.position - var_27_4.position).y, (manager.ui.mainCamera.transform.position - var_27_4.position).z)
				var_27_4.localEulerAngles.z = 0
				var_27_4.localEulerAngles.x = 0
				var_27_4.localEulerAngles = var_27_4.localEulerAngles

				local var_27_7 = GameObjectTools.GetOrAddComponent(var_27_4.gameObject, typeof(DynamicBoneHelper))

				if var_27_7 then
					var_27_7:EnableDynamicBone(true)
				end
			end

			local var_27_8 = arg_24_1.actors_["1019ui_story"].transform

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1.var_.moveOldPos1019ui_story = var_27_8.localPosition
			end

			local var_27_9 = 0.001

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_9 then
				var_27_8.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos1019ui_story, Vector3.New(0, 100, 0), (arg_24_1.time_ - 0) / var_27_9)
				var_27_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_27_8.position).x, (manager.ui.mainCamera.transform.position - var_27_8.position).y, (manager.ui.mainCamera.transform.position - var_27_8.position).z)
				var_27_8.localEulerAngles.z = 0
				var_27_8.localEulerAngles.x = 0
				var_27_8.localEulerAngles = var_27_8.localEulerAngles
			end

			if arg_24_1.time_ >= 0 + var_27_9 and arg_24_1.time_ < 0 + var_27_9 + arg_27_0 then
				var_27_8.localPosition = Vector3.New(0, 100, 0)
				var_27_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_27_8.position).x, (manager.ui.mainCamera.transform.position - var_27_8.position).y, (manager.ui.mainCamera.transform.position - var_27_8.position).z)
				var_27_8.localEulerAngles.z = 0
				var_27_8.localEulerAngles.x = 0
				var_27_8.localEulerAngles = var_27_8.localEulerAngles
			end

			local var_27_10 = arg_24_1.actors_["1011ui_story"].transform

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1.var_.moveOldPos1011ui_story = var_27_10.localPosition
			end

			local var_27_11 = 0.001

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_11 then
				var_27_10.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_24_1.time_ - 0) / var_27_11)
				var_27_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_27_10.position).x, (manager.ui.mainCamera.transform.position - var_27_10.position).y, (manager.ui.mainCamera.transform.position - var_27_10.position).z)
				var_27_10.localEulerAngles.z = 0
				var_27_10.localEulerAngles.x = 0
				var_27_10.localEulerAngles = var_27_10.localEulerAngles
			end

			if arg_24_1.time_ >= 0 + var_27_11 and arg_24_1.time_ < 0 + var_27_11 + arg_27_0 then
				var_27_10.localPosition = Vector3.New(0, 100, 0)
				var_27_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_27_10.position).x, (manager.ui.mainCamera.transform.position - var_27_10.position).y, (manager.ui.mainCamera.transform.position - var_27_10.position).z)
				var_27_10.localEulerAngles.z = 0
				var_27_10.localEulerAngles.x = 0
				var_27_10.localEulerAngles = var_27_10.localEulerAngles
			end

			local var_27_12 = 0
			local var_27_13 = 0.325

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_12 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				arg_24_1.leftNameTxt_.text = arg_24_1:FormatText(StoryNameCfg[19].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_14 = arg_24_1:GetWordFromCfg(101131006)
				local var_27_15 = arg_24_1:FormatText(var_27_14.content)

				arg_24_1.text_.text = var_27_15

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_17 = 12 <= 0 and var_27_13 or var_27_13 * (utf8.len(var_27_15) / 12)

				if (12 <= 0 and var_27_13 or var_27_13 * (utf8.len(var_27_15) / 12)) > 0 and var_27_13 < var_27_17 then
					arg_24_1.talkMaxDuration = var_27_17

					if var_27_17 + var_27_12 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_17 + var_27_12
					end
				end

				arg_24_1.text_.text = var_27_15
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101131", "101131006", "story_v_out_101131.awb") ~= 0 then
					local var_27_18 = manager.audio:GetVoiceLength("story_v_out_101131", "101131006", "story_v_out_101131.awb") / 1000

					if var_27_18 + var_27_12 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_18 + var_27_12
					end

					if var_27_14.prefab_name ~= "" and arg_24_1.actors_[var_27_14.prefab_name] ~= nil then
						local var_27_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_14.prefab_name].transform, "story_v_out_101131", "101131006", "story_v_out_101131.awb")

						arg_24_1:RecordAudio("101131006", var_27_19)
						arg_24_1:RecordAudio("101131006", var_27_19)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_101131", "101131006", "story_v_out_101131.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_101131", "101131006", "story_v_out_101131.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_20 = math.max(var_27_13, arg_24_1.talkMaxDuration)

			if var_27_12 <= arg_24_1.time_ and arg_24_1.time_ < var_27_12 + var_27_20 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_12) / var_27_20

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_12 + var_27_20 and arg_24_1.time_ < var_27_12 + var_27_20 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {
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

		arg_24_1:InitPlayNodeList()
	end,
	Play101131007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 101131007
		arg_28_1.duration_ = 7.73

		local var_28_0 = {
			ja = 7.733,
			ko = 6.033,
			zh = 5,
			en = 3.766
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
				arg_28_0:Play101131008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 and not isNil(arg_28_1.actors_["1019ui_story"]) and arg_28_1.var_.characterEffect1019ui_story == nil then
				arg_28_1.var_.characterEffect1019ui_story = arg_28_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_0 = 0.1

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_0 and not isNil(arg_28_1.actors_["1019ui_story"]) then
				if arg_28_1.var_.characterEffect1019ui_story and not isNil(arg_28_1.actors_["1019ui_story"]) then
					arg_28_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_28_1.time_ >= 0 + var_31_0 and arg_28_1.time_ < 0 + var_31_0 + arg_31_0 and not isNil(arg_28_1.actors_["1019ui_story"]) and arg_28_1.var_.characterEffect1019ui_story then
				arg_28_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_31_2 = arg_28_1.actors_["2020_tpose"]

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 and not isNil(var_31_2) and arg_28_1.var_.characterEffect2020_tpose == nil then
				arg_28_1.var_.characterEffect2020_tpose = var_31_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_3 = 0.1

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_3 and not isNil(var_31_2) then
				if arg_28_1.var_.characterEffect2020_tpose and not isNil(var_31_2) then
					arg_28_1.var_.characterEffect2020_tpose.fillFlat = true
					arg_28_1.var_.characterEffect2020_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_28_1.time_ - 0) / var_31_3)
				end
			end

			if arg_28_1.time_ >= 0 + var_31_3 and arg_28_1.time_ < 0 + var_31_3 + arg_31_0 and not isNil(var_31_2) and arg_28_1.var_.characterEffect2020_tpose then
				arg_28_1.var_.characterEffect2020_tpose.fillFlat = true
				arg_28_1.var_.characterEffect2020_tpose.fillRatio = 0.5
			end

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_31_4 = arg_28_1.actors_["1019ui_story"].transform

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1.var_.moveOldPos1019ui_story = var_31_4.localPosition
			end

			local var_31_5 = 0.001

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_5 then
				var_31_4.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos1019ui_story, Vector3.New(-0.7, -1.08, -5.9), (arg_28_1.time_ - 0) / var_31_5)
				var_31_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_31_4.position).x, (manager.ui.mainCamera.transform.position - var_31_4.position).y, (manager.ui.mainCamera.transform.position - var_31_4.position).z)
				var_31_4.localEulerAngles.z = 0
				var_31_4.localEulerAngles.x = 0
				var_31_4.localEulerAngles = var_31_4.localEulerAngles
			end

			if arg_28_1.time_ >= 0 + var_31_5 and arg_28_1.time_ < 0 + var_31_5 + arg_31_0 then
				var_31_4.localPosition = Vector3.New(-0.7, -1.08, -5.9)
				var_31_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_31_4.position).x, (manager.ui.mainCamera.transform.position - var_31_4.position).y, (manager.ui.mainCamera.transform.position - var_31_4.position).z)
				var_31_4.localEulerAngles.z = 0
				var_31_4.localEulerAngles.x = 0
				var_31_4.localEulerAngles = var_31_4.localEulerAngles
			end

			local var_31_6 = arg_28_1.actors_["1011ui_story"].transform

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1.var_.moveOldPos1011ui_story = var_31_6.localPosition
			end

			local var_31_7 = 0.001

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_7 then
				var_31_6.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos1011ui_story, Vector3.New(0.7, -0.71, -6), (arg_28_1.time_ - 0) / var_31_7)
				var_31_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_31_6.position).x, (manager.ui.mainCamera.transform.position - var_31_6.position).y, (manager.ui.mainCamera.transform.position - var_31_6.position).z)
				var_31_6.localEulerAngles.z = 0
				var_31_6.localEulerAngles.x = 0
				var_31_6.localEulerAngles = var_31_6.localEulerAngles
			end

			if arg_28_1.time_ >= 0 + var_31_7 and arg_28_1.time_ < 0 + var_31_7 + arg_31_0 then
				var_31_6.localPosition = Vector3.New(0.7, -0.71, -6)
				var_31_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_31_6.position).x, (manager.ui.mainCamera.transform.position - var_31_6.position).y, (manager.ui.mainCamera.transform.position - var_31_6.position).z)
				var_31_6.localEulerAngles.z = 0
				var_31_6.localEulerAngles.x = 0
				var_31_6.localEulerAngles = var_31_6.localEulerAngles
			end

			local var_31_8 = arg_28_1.actors_["2020_tpose"].transform

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1.var_.moveOldPos2020_tpose = var_31_8.localPosition

				local var_31_9 = GameObjectTools.GetOrAddComponent(var_31_8.gameObject, typeof(DynamicBoneHelper))

				if var_31_9 then
					var_31_9:EnableDynamicBone(false)
				end
			end

			local var_31_10 = 0.001

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_10 then
				var_31_8.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos2020_tpose, Vector3.New(0, 100, 0), (arg_28_1.time_ - 0) / var_31_10)
				var_31_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_31_8.position).x, (manager.ui.mainCamera.transform.position - var_31_8.position).y, (manager.ui.mainCamera.transform.position - var_31_8.position).z)
				var_31_8.localEulerAngles.z = 0
				var_31_8.localEulerAngles.x = 0
				var_31_8.localEulerAngles = var_31_8.localEulerAngles
			end

			if arg_28_1.time_ >= 0 + var_31_10 and arg_28_1.time_ < 0 + var_31_10 + arg_31_0 then
				var_31_8.localPosition = Vector3.New(0, 100, 0)
				var_31_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_31_8.position).x, (manager.ui.mainCamera.transform.position - var_31_8.position).y, (manager.ui.mainCamera.transform.position - var_31_8.position).z)
				var_31_8.localEulerAngles.z = 0
				var_31_8.localEulerAngles.x = 0
				var_31_8.localEulerAngles = var_31_8.localEulerAngles

				local var_31_11 = GameObjectTools.GetOrAddComponent(var_31_8.gameObject, typeof(DynamicBoneHelper))

				if var_31_11 then
					var_31_11:EnableDynamicBone(true)
				end
			end

			local var_31_12 = 0
			local var_31_13 = 0.725

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_12 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				arg_28_1.leftNameTxt_.text = arg_28_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_14 = arg_28_1:GetWordFromCfg(101131007)
				local var_31_15 = arg_28_1:FormatText(var_31_14.content)

				arg_28_1.text_.text = var_31_15

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_17 = 27 <= 0 and var_31_13 or var_31_13 * (utf8.len(var_31_15) / 27)

				if (27 <= 0 and var_31_13 or var_31_13 * (utf8.len(var_31_15) / 27)) > 0 and var_31_13 < var_31_17 then
					arg_28_1.talkMaxDuration = var_31_17

					if var_31_17 + var_31_12 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_17 + var_31_12
					end
				end

				arg_28_1.text_.text = var_31_15
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101131", "101131007", "story_v_out_101131.awb") ~= 0 then
					local var_31_18 = manager.audio:GetVoiceLength("story_v_out_101131", "101131007", "story_v_out_101131.awb") / 1000

					if var_31_18 + var_31_12 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_18 + var_31_12
					end

					if var_31_14.prefab_name ~= "" and arg_28_1.actors_[var_31_14.prefab_name] ~= nil then
						local var_31_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_14.prefab_name].transform, "story_v_out_101131", "101131007", "story_v_out_101131.awb")

						arg_28_1:RecordAudio("101131007", var_31_19)
						arg_28_1:RecordAudio("101131007", var_31_19)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_101131", "101131007", "story_v_out_101131.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_101131", "101131007", "story_v_out_101131.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_20 = math.max(var_31_13, arg_28_1.talkMaxDuration)

			if var_31_12 <= arg_28_1.time_ and arg_28_1.time_ < var_31_12 + var_31_20 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_12) / var_31_20

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_12 + var_31_20 and arg_28_1.time_ < var_31_12 + var_31_20 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {
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
			},
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

		arg_28_1:InitPlayNodeList()
	end,
	Play101131008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 101131008
		arg_32_1.duration_ = 7.63

		local var_32_0 = {
			ja = 5.833,
			ko = 7.633,
			zh = 5.933,
			en = 6.166
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
				arg_32_0:Play101131009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 and not isNil(arg_32_1.actors_["2020_tpose"]) and arg_32_1.var_.characterEffect2020_tpose == nil then
				arg_32_1.var_.characterEffect2020_tpose = arg_32_1.actors_["2020_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_0 = 0.1

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_0 and not isNil(arg_32_1.actors_["2020_tpose"]) then
				if arg_32_1.var_.characterEffect2020_tpose and not isNil(arg_32_1.actors_["2020_tpose"]) then
					arg_32_1.var_.characterEffect2020_tpose.fillFlat = false
				end
			end

			if arg_32_1.time_ >= 0 + var_35_0 and arg_32_1.time_ < 0 + var_35_0 + arg_35_0 and not isNil(arg_32_1.actors_["2020_tpose"]) and arg_32_1.var_.characterEffect2020_tpose then
				arg_32_1.var_.characterEffect2020_tpose.fillFlat = false
			end

			local var_35_2 = arg_32_1.actors_["1019ui_story"]

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 and not isNil(var_35_2) and arg_32_1.var_.characterEffect1019ui_story == nil then
				arg_32_1.var_.characterEffect1019ui_story = var_35_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_3 = 0.1

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_3 and not isNil(var_35_2) then
				if arg_32_1.var_.characterEffect1019ui_story and not isNil(var_35_2) then
					arg_32_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_32_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_32_1.time_ - 0) / var_35_3)
				end
			end

			if arg_32_1.time_ >= 0 + var_35_3 and arg_32_1.time_ < 0 + var_35_3 + arg_35_0 and not isNil(var_35_2) and arg_32_1.var_.characterEffect1019ui_story then
				arg_32_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_32_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_35_4 = arg_32_1.actors_["1019ui_story"].transform

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1.var_.moveOldPos1019ui_story = var_35_4.localPosition
			end

			local var_35_5 = 0.001

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_5 then
				var_35_4.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos1019ui_story, Vector3.New(0, 100, 0), (arg_32_1.time_ - 0) / var_35_5)
				var_35_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_35_4.position).x, (manager.ui.mainCamera.transform.position - var_35_4.position).y, (manager.ui.mainCamera.transform.position - var_35_4.position).z)
				var_35_4.localEulerAngles.z = 0
				var_35_4.localEulerAngles.x = 0
				var_35_4.localEulerAngles = var_35_4.localEulerAngles
			end

			if arg_32_1.time_ >= 0 + var_35_5 and arg_32_1.time_ < 0 + var_35_5 + arg_35_0 then
				var_35_4.localPosition = Vector3.New(0, 100, 0)
				var_35_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_35_4.position).x, (manager.ui.mainCamera.transform.position - var_35_4.position).y, (manager.ui.mainCamera.transform.position - var_35_4.position).z)
				var_35_4.localEulerAngles.z = 0
				var_35_4.localEulerAngles.x = 0
				var_35_4.localEulerAngles = var_35_4.localEulerAngles
			end

			local var_35_6 = arg_32_1.actors_["1011ui_story"].transform

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1.var_.moveOldPos1011ui_story = var_35_6.localPosition
			end

			local var_35_7 = 0.001

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_7 then
				var_35_6.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_32_1.time_ - 0) / var_35_7)
				var_35_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_35_6.position).x, (manager.ui.mainCamera.transform.position - var_35_6.position).y, (manager.ui.mainCamera.transform.position - var_35_6.position).z)
				var_35_6.localEulerAngles.z = 0
				var_35_6.localEulerAngles.x = 0
				var_35_6.localEulerAngles = var_35_6.localEulerAngles
			end

			if arg_32_1.time_ >= 0 + var_35_7 and arg_32_1.time_ < 0 + var_35_7 + arg_35_0 then
				var_35_6.localPosition = Vector3.New(0, 100, 0)
				var_35_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_35_6.position).x, (manager.ui.mainCamera.transform.position - var_35_6.position).y, (manager.ui.mainCamera.transform.position - var_35_6.position).z)
				var_35_6.localEulerAngles.z = 0
				var_35_6.localEulerAngles.x = 0
				var_35_6.localEulerAngles = var_35_6.localEulerAngles
			end

			local var_35_8 = arg_32_1.actors_["2020_tpose"].transform

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1.var_.moveOldPos2020_tpose = var_35_8.localPosition

				local var_35_9 = GameObjectTools.GetOrAddComponent(var_35_8.gameObject, typeof(DynamicBoneHelper))

				if var_35_9 then
					var_35_9:EnableDynamicBone(false)
				end
			end

			local var_35_10 = 0.001

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_10 then
				var_35_8.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos2020_tpose, Vector3.New(0, -1.2, -4.1), (arg_32_1.time_ - 0) / var_35_10)
				var_35_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_35_8.position).x, (manager.ui.mainCamera.transform.position - var_35_8.position).y, (manager.ui.mainCamera.transform.position - var_35_8.position).z)
				var_35_8.localEulerAngles.z = 0
				var_35_8.localEulerAngles.x = 0
				var_35_8.localEulerAngles = var_35_8.localEulerAngles
			end

			if arg_32_1.time_ >= 0 + var_35_10 and arg_32_1.time_ < 0 + var_35_10 + arg_35_0 then
				var_35_8.localPosition = Vector3.New(0, -1.2, -4.1)
				var_35_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_35_8.position).x, (manager.ui.mainCamera.transform.position - var_35_8.position).y, (manager.ui.mainCamera.transform.position - var_35_8.position).z)
				var_35_8.localEulerAngles.z = 0
				var_35_8.localEulerAngles.x = 0
				var_35_8.localEulerAngles = var_35_8.localEulerAngles

				local var_35_11 = GameObjectTools.GetOrAddComponent(var_35_8.gameObject, typeof(DynamicBoneHelper))

				if var_35_11 then
					var_35_11:EnableDynamicBone(true)
				end
			end

			local var_35_12 = 0
			local var_35_13 = 0.875

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_12 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				arg_32_1.leftNameTxt_.text = arg_32_1:FormatText(StoryNameCfg[19].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_14 = arg_32_1:GetWordFromCfg(101131008)
				local var_35_15 = arg_32_1:FormatText(var_35_14.content)

				arg_32_1.text_.text = var_35_15

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_17 = 33 <= 0 and var_35_13 or var_35_13 * (utf8.len(var_35_15) / 33)

				if (33 <= 0 and var_35_13 or var_35_13 * (utf8.len(var_35_15) / 33)) > 0 and var_35_13 < var_35_17 then
					arg_32_1.talkMaxDuration = var_35_17

					if var_35_17 + var_35_12 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_17 + var_35_12
					end
				end

				arg_32_1.text_.text = var_35_15
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101131", "101131008", "story_v_out_101131.awb") ~= 0 then
					local var_35_18 = manager.audio:GetVoiceLength("story_v_out_101131", "101131008", "story_v_out_101131.awb") / 1000

					if var_35_18 + var_35_12 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_18 + var_35_12
					end

					if var_35_14.prefab_name ~= "" and arg_32_1.actors_[var_35_14.prefab_name] ~= nil then
						local var_35_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_14.prefab_name].transform, "story_v_out_101131", "101131008", "story_v_out_101131.awb")

						arg_32_1:RecordAudio("101131008", var_35_19)
						arg_32_1:RecordAudio("101131008", var_35_19)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_101131", "101131008", "story_v_out_101131.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_101131", "101131008", "story_v_out_101131.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_20 = math.max(var_35_13, arg_32_1.talkMaxDuration)

			if var_35_12 <= arg_32_1.time_ and arg_32_1.time_ < var_35_12 + var_35_20 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_12) / var_35_20

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_12 + var_35_20 and arg_32_1.time_ < var_35_12 + var_35_20 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {
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
			},
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

		arg_32_1:InitPlayNodeList()
	end,
	Play101131009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 101131009
		arg_36_1.duration_ = 5

		local var_36_0 = {
			ja = 5,
			ko = 4.166,
			zh = 3.5,
			en = 4.333
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
				arg_36_0:Play101131010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 and not isNil(arg_36_1.actors_["1019ui_story"]) and arg_36_1.var_.characterEffect1019ui_story == nil then
				arg_36_1.var_.characterEffect1019ui_story = arg_36_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_0 = 0.1

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_0 and not isNil(arg_36_1.actors_["1019ui_story"]) then
				if arg_36_1.var_.characterEffect1019ui_story and not isNil(arg_36_1.actors_["1019ui_story"]) then
					arg_36_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_36_1.time_ >= 0 + var_39_0 and arg_36_1.time_ < 0 + var_39_0 + arg_39_0 and not isNil(arg_36_1.actors_["1019ui_story"]) and arg_36_1.var_.characterEffect1019ui_story then
				arg_36_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_39_2 = arg_36_1.actors_["2020_tpose"]

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 and not isNil(var_39_2) and arg_36_1.var_.characterEffect2020_tpose == nil then
				arg_36_1.var_.characterEffect2020_tpose = var_39_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_3 = 0.1

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_3 and not isNil(var_39_2) then
				if arg_36_1.var_.characterEffect2020_tpose and not isNil(var_39_2) then
					arg_36_1.var_.characterEffect2020_tpose.fillFlat = true
					arg_36_1.var_.characterEffect2020_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_36_1.time_ - 0) / var_39_3)
				end
			end

			if arg_36_1.time_ >= 0 + var_39_3 and arg_36_1.time_ < 0 + var_39_3 + arg_39_0 and not isNil(var_39_2) and arg_36_1.var_.characterEffect2020_tpose then
				arg_36_1.var_.characterEffect2020_tpose.fillFlat = true
				arg_36_1.var_.characterEffect2020_tpose.fillRatio = 0.5
			end

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_39_4 = arg_36_1.actors_["1019ui_story"].transform

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1.var_.moveOldPos1019ui_story = var_39_4.localPosition
			end

			local var_39_5 = 0.001

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_5 then
				var_39_4.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos1019ui_story, Vector3.New(-0.7, -1.08, -5.9), (arg_36_1.time_ - 0) / var_39_5)
				var_39_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_39_4.position).x, (manager.ui.mainCamera.transform.position - var_39_4.position).y, (manager.ui.mainCamera.transform.position - var_39_4.position).z)
				var_39_4.localEulerAngles.z = 0
				var_39_4.localEulerAngles.x = 0
				var_39_4.localEulerAngles = var_39_4.localEulerAngles
			end

			if arg_36_1.time_ >= 0 + var_39_5 and arg_36_1.time_ < 0 + var_39_5 + arg_39_0 then
				var_39_4.localPosition = Vector3.New(-0.7, -1.08, -5.9)
				var_39_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_39_4.position).x, (manager.ui.mainCamera.transform.position - var_39_4.position).y, (manager.ui.mainCamera.transform.position - var_39_4.position).z)
				var_39_4.localEulerAngles.z = 0
				var_39_4.localEulerAngles.x = 0
				var_39_4.localEulerAngles = var_39_4.localEulerAngles
			end

			local var_39_6 = arg_36_1.actors_["1011ui_story"].transform

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1.var_.moveOldPos1011ui_story = var_39_6.localPosition
			end

			local var_39_7 = 0.001

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_7 then
				var_39_6.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos1011ui_story, Vector3.New(0.7, -0.71, -6), (arg_36_1.time_ - 0) / var_39_7)
				var_39_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_39_6.position).x, (manager.ui.mainCamera.transform.position - var_39_6.position).y, (manager.ui.mainCamera.transform.position - var_39_6.position).z)
				var_39_6.localEulerAngles.z = 0
				var_39_6.localEulerAngles.x = 0
				var_39_6.localEulerAngles = var_39_6.localEulerAngles
			end

			if arg_36_1.time_ >= 0 + var_39_7 and arg_36_1.time_ < 0 + var_39_7 + arg_39_0 then
				var_39_6.localPosition = Vector3.New(0.7, -0.71, -6)
				var_39_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_39_6.position).x, (manager.ui.mainCamera.transform.position - var_39_6.position).y, (manager.ui.mainCamera.transform.position - var_39_6.position).z)
				var_39_6.localEulerAngles.z = 0
				var_39_6.localEulerAngles.x = 0
				var_39_6.localEulerAngles = var_39_6.localEulerAngles
			end

			local var_39_8 = arg_36_1.actors_["2020_tpose"].transform

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1.var_.moveOldPos2020_tpose = var_39_8.localPosition

				local var_39_9 = GameObjectTools.GetOrAddComponent(var_39_8.gameObject, typeof(DynamicBoneHelper))

				if var_39_9 then
					var_39_9:EnableDynamicBone(false)
				end
			end

			local var_39_10 = 0.001

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_10 then
				var_39_8.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos2020_tpose, Vector3.New(0, 100, 0), (arg_36_1.time_ - 0) / var_39_10)
				var_39_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_39_8.position).x, (manager.ui.mainCamera.transform.position - var_39_8.position).y, (manager.ui.mainCamera.transform.position - var_39_8.position).z)
				var_39_8.localEulerAngles.z = 0
				var_39_8.localEulerAngles.x = 0
				var_39_8.localEulerAngles = var_39_8.localEulerAngles
			end

			if arg_36_1.time_ >= 0 + var_39_10 and arg_36_1.time_ < 0 + var_39_10 + arg_39_0 then
				var_39_8.localPosition = Vector3.New(0, 100, 0)
				var_39_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_39_8.position).x, (manager.ui.mainCamera.transform.position - var_39_8.position).y, (manager.ui.mainCamera.transform.position - var_39_8.position).z)
				var_39_8.localEulerAngles.z = 0
				var_39_8.localEulerAngles.x = 0
				var_39_8.localEulerAngles = var_39_8.localEulerAngles

				local var_39_11 = GameObjectTools.GetOrAddComponent(var_39_8.gameObject, typeof(DynamicBoneHelper))

				if var_39_11 then
					var_39_11:EnableDynamicBone(true)
				end
			end

			local var_39_12 = 0
			local var_39_13 = 0.375

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_12 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				arg_36_1.leftNameTxt_.text = arg_36_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_14 = arg_36_1:GetWordFromCfg(101131009)
				local var_39_15 = arg_36_1:FormatText(var_39_14.content)

				arg_36_1.text_.text = var_39_15

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_17 = 15 <= 0 and var_39_13 or var_39_13 * (utf8.len(var_39_15) / 15)

				if (15 <= 0 and var_39_13 or var_39_13 * (utf8.len(var_39_15) / 15)) > 0 and var_39_13 < var_39_17 then
					arg_36_1.talkMaxDuration = var_39_17

					if var_39_17 + var_39_12 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_17 + var_39_12
					end
				end

				arg_36_1.text_.text = var_39_15
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101131", "101131009", "story_v_out_101131.awb") ~= 0 then
					local var_39_18 = manager.audio:GetVoiceLength("story_v_out_101131", "101131009", "story_v_out_101131.awb") / 1000

					if var_39_18 + var_39_12 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_18 + var_39_12
					end

					if var_39_14.prefab_name ~= "" and arg_36_1.actors_[var_39_14.prefab_name] ~= nil then
						local var_39_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_14.prefab_name].transform, "story_v_out_101131", "101131009", "story_v_out_101131.awb")

						arg_36_1:RecordAudio("101131009", var_39_19)
						arg_36_1:RecordAudio("101131009", var_39_19)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_101131", "101131009", "story_v_out_101131.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_101131", "101131009", "story_v_out_101131.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_20 = math.max(var_39_13, arg_36_1.talkMaxDuration)

			if var_39_12 <= arg_36_1.time_ and arg_36_1.time_ < var_39_12 + var_39_20 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_12) / var_39_20

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_12 + var_39_20 and arg_36_1.time_ < var_39_12 + var_39_20 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {
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
			},
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

		arg_36_1:InitPlayNodeList()
	end,
	Play101131010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 101131010
		arg_40_1.duration_ = 2.2

		local var_40_0 = {
			ja = 1.766,
			ko = 1.8,
			zh = 1.666,
			en = 2.2
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
				arg_40_0:Play101131011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 and not isNil(arg_40_1.actors_["1019ui_story"]) and arg_40_1.var_.characterEffect1019ui_story == nil then
				arg_40_1.var_.characterEffect1019ui_story = arg_40_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_0 = 0.1

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_0 and not isNil(arg_40_1.actors_["1019ui_story"]) then
				if arg_40_1.var_.characterEffect1019ui_story and not isNil(arg_40_1.actors_["1019ui_story"]) then
					arg_40_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_40_1.time_ >= 0 + var_43_0 and arg_40_1.time_ < 0 + var_43_0 + arg_43_0 and not isNil(arg_40_1.actors_["1019ui_story"]) and arg_40_1.var_.characterEffect1019ui_story then
				arg_40_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_43_2 = arg_40_1.actors_["2020_tpose"]

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 and not isNil(var_43_2) and arg_40_1.var_.characterEffect2020_tpose == nil then
				arg_40_1.var_.characterEffect2020_tpose = var_43_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_3 = 0.1

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_3 and not isNil(var_43_2) then
				if arg_40_1.var_.characterEffect2020_tpose and not isNil(var_43_2) then
					arg_40_1.var_.characterEffect2020_tpose.fillFlat = true
					arg_40_1.var_.characterEffect2020_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_40_1.time_ - 0) / var_43_3)
				end
			end

			if arg_40_1.time_ >= 0 + var_43_3 and arg_40_1.time_ < 0 + var_43_3 + arg_43_0 and not isNil(var_43_2) and arg_40_1.var_.characterEffect2020_tpose then
				arg_40_1.var_.characterEffect2020_tpose.fillFlat = true
				arg_40_1.var_.characterEffect2020_tpose.fillRatio = 0.5
			end

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_43_4 = 0
			local var_43_5 = 0.175

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_4 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				arg_40_1.leftNameTxt_.text = arg_40_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_6 = arg_40_1:GetWordFromCfg(101131010)
				local var_43_7 = arg_40_1:FormatText(var_43_6.content)

				arg_40_1.text_.text = var_43_7

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_9 = 7 <= 0 and var_43_5 or var_43_5 * (utf8.len(var_43_7) / 7)

				if (7 <= 0 and var_43_5 or var_43_5 * (utf8.len(var_43_7) / 7)) > 0 and var_43_5 < var_43_9 then
					arg_40_1.talkMaxDuration = var_43_9

					if var_43_9 + var_43_4 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_9 + var_43_4
					end
				end

				arg_40_1.text_.text = var_43_7
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101131", "101131010", "story_v_out_101131.awb") ~= 0 then
					local var_43_10 = manager.audio:GetVoiceLength("story_v_out_101131", "101131010", "story_v_out_101131.awb") / 1000

					if var_43_10 + var_43_4 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_10 + var_43_4
					end

					if var_43_6.prefab_name ~= "" and arg_40_1.actors_[var_43_6.prefab_name] ~= nil then
						local var_43_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_6.prefab_name].transform, "story_v_out_101131", "101131010", "story_v_out_101131.awb")

						arg_40_1:RecordAudio("101131010", var_43_11)
						arg_40_1:RecordAudio("101131010", var_43_11)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_101131", "101131010", "story_v_out_101131.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_101131", "101131010", "story_v_out_101131.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_12 = math.max(var_43_5, arg_40_1.talkMaxDuration)

			if var_43_4 <= arg_40_1.time_ and arg_40_1.time_ < var_43_4 + var_43_12 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_4) / var_43_12

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_4 + var_43_12 and arg_40_1.time_ < var_43_4 + var_43_12 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play101131011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 101131011
		arg_44_1.duration_ = 9.23

		local var_44_0 = {
			ja = 9.233,
			ko = 7.966,
			zh = 7.133,
			en = 6.433
		}
		local var_44_1 = manager.audio:GetLocalizationFlag()

		if var_44_0[var_44_1] ~= nil then
			arg_44_1.duration_ = var_44_0[var_44_1]
		end

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play101131012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 and not isNil(arg_44_1.actors_["2020_tpose"]) and arg_44_1.var_.characterEffect2020_tpose == nil then
				arg_44_1.var_.characterEffect2020_tpose = arg_44_1.actors_["2020_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_0 = 0.1

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_0 and not isNil(arg_44_1.actors_["2020_tpose"]) then
				if arg_44_1.var_.characterEffect2020_tpose and not isNil(arg_44_1.actors_["2020_tpose"]) then
					arg_44_1.var_.characterEffect2020_tpose.fillFlat = false
				end
			end

			if arg_44_1.time_ >= 0 + var_47_0 and arg_44_1.time_ < 0 + var_47_0 + arg_47_0 and not isNil(arg_44_1.actors_["2020_tpose"]) and arg_44_1.var_.characterEffect2020_tpose then
				arg_44_1.var_.characterEffect2020_tpose.fillFlat = false
			end

			local var_47_2 = arg_44_1.actors_["1019ui_story"]

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 and not isNil(var_47_2) and arg_44_1.var_.characterEffect1019ui_story == nil then
				arg_44_1.var_.characterEffect1019ui_story = var_47_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_3 = 0.1

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_3 and not isNil(var_47_2) then
				if arg_44_1.var_.characterEffect1019ui_story and not isNil(var_47_2) then
					arg_44_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_44_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_44_1.time_ - 0) / var_47_3)
				end
			end

			if arg_44_1.time_ >= 0 + var_47_3 and arg_44_1.time_ < 0 + var_47_3 + arg_47_0 and not isNil(var_47_2) and arg_44_1.var_.characterEffect1019ui_story then
				arg_44_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_44_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_47_4 = arg_44_1.actors_["1019ui_story"].transform

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1.var_.moveOldPos1019ui_story = var_47_4.localPosition
			end

			local var_47_5 = 0.001

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_5 then
				var_47_4.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos1019ui_story, Vector3.New(0, 100, 0), (arg_44_1.time_ - 0) / var_47_5)
				var_47_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_47_4.position).x, (manager.ui.mainCamera.transform.position - var_47_4.position).y, (manager.ui.mainCamera.transform.position - var_47_4.position).z)
				var_47_4.localEulerAngles.z = 0
				var_47_4.localEulerAngles.x = 0
				var_47_4.localEulerAngles = var_47_4.localEulerAngles
			end

			if arg_44_1.time_ >= 0 + var_47_5 and arg_44_1.time_ < 0 + var_47_5 + arg_47_0 then
				var_47_4.localPosition = Vector3.New(0, 100, 0)
				var_47_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_47_4.position).x, (manager.ui.mainCamera.transform.position - var_47_4.position).y, (manager.ui.mainCamera.transform.position - var_47_4.position).z)
				var_47_4.localEulerAngles.z = 0
				var_47_4.localEulerAngles.x = 0
				var_47_4.localEulerAngles = var_47_4.localEulerAngles
			end

			local var_47_6 = arg_44_1.actors_["1011ui_story"].transform

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1.var_.moveOldPos1011ui_story = var_47_6.localPosition
			end

			local var_47_7 = 0.001

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_7 then
				var_47_6.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_44_1.time_ - 0) / var_47_7)
				var_47_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_47_6.position).x, (manager.ui.mainCamera.transform.position - var_47_6.position).y, (manager.ui.mainCamera.transform.position - var_47_6.position).z)
				var_47_6.localEulerAngles.z = 0
				var_47_6.localEulerAngles.x = 0
				var_47_6.localEulerAngles = var_47_6.localEulerAngles
			end

			if arg_44_1.time_ >= 0 + var_47_7 and arg_44_1.time_ < 0 + var_47_7 + arg_47_0 then
				var_47_6.localPosition = Vector3.New(0, 100, 0)
				var_47_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_47_6.position).x, (manager.ui.mainCamera.transform.position - var_47_6.position).y, (manager.ui.mainCamera.transform.position - var_47_6.position).z)
				var_47_6.localEulerAngles.z = 0
				var_47_6.localEulerAngles.x = 0
				var_47_6.localEulerAngles = var_47_6.localEulerAngles
			end

			local var_47_8 = arg_44_1.actors_["2020_tpose"].transform

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1.var_.moveOldPos2020_tpose = var_47_8.localPosition

				local var_47_9 = GameObjectTools.GetOrAddComponent(var_47_8.gameObject, typeof(DynamicBoneHelper))

				if var_47_9 then
					var_47_9:EnableDynamicBone(false)
				end
			end

			local var_47_10 = 0.001

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_10 then
				var_47_8.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos2020_tpose, Vector3.New(0, -1.2, -4.1), (arg_44_1.time_ - 0) / var_47_10)
				var_47_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_47_8.position).x, (manager.ui.mainCamera.transform.position - var_47_8.position).y, (manager.ui.mainCamera.transform.position - var_47_8.position).z)
				var_47_8.localEulerAngles.z = 0
				var_47_8.localEulerAngles.x = 0
				var_47_8.localEulerAngles = var_47_8.localEulerAngles
			end

			if arg_44_1.time_ >= 0 + var_47_10 and arg_44_1.time_ < 0 + var_47_10 + arg_47_0 then
				var_47_8.localPosition = Vector3.New(0, -1.2, -4.1)
				var_47_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_47_8.position).x, (manager.ui.mainCamera.transform.position - var_47_8.position).y, (manager.ui.mainCamera.transform.position - var_47_8.position).z)
				var_47_8.localEulerAngles.z = 0
				var_47_8.localEulerAngles.x = 0
				var_47_8.localEulerAngles = var_47_8.localEulerAngles

				local var_47_11 = GameObjectTools.GetOrAddComponent(var_47_8.gameObject, typeof(DynamicBoneHelper))

				if var_47_11 then
					var_47_11:EnableDynamicBone(true)
				end
			end

			local var_47_12 = 0
			local var_47_13 = 0.75

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_12 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				arg_44_1.leftNameTxt_.text = arg_44_1:FormatText(StoryNameCfg[19].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_14 = arg_44_1:GetWordFromCfg(101131011)
				local var_47_15 = arg_44_1:FormatText(var_47_14.content)

				arg_44_1.text_.text = var_47_15

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_17 = 30 <= 0 and var_47_13 or var_47_13 * (utf8.len(var_47_15) / 30)

				if (30 <= 0 and var_47_13 or var_47_13 * (utf8.len(var_47_15) / 30)) > 0 and var_47_13 < var_47_17 then
					arg_44_1.talkMaxDuration = var_47_17

					if var_47_17 + var_47_12 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_17 + var_47_12
					end
				end

				arg_44_1.text_.text = var_47_15
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101131", "101131011", "story_v_out_101131.awb") ~= 0 then
					local var_47_18 = manager.audio:GetVoiceLength("story_v_out_101131", "101131011", "story_v_out_101131.awb") / 1000

					if var_47_18 + var_47_12 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_18 + var_47_12
					end

					if var_47_14.prefab_name ~= "" and arg_44_1.actors_[var_47_14.prefab_name] ~= nil then
						local var_47_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_14.prefab_name].transform, "story_v_out_101131", "101131011", "story_v_out_101131.awb")

						arg_44_1:RecordAudio("101131011", var_47_19)
						arg_44_1:RecordAudio("101131011", var_47_19)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_101131", "101131011", "story_v_out_101131.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_101131", "101131011", "story_v_out_101131.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_20 = math.max(var_47_13, arg_44_1.talkMaxDuration)

			if var_47_12 <= arg_44_1.time_ and arg_44_1.time_ < var_47_12 + var_47_20 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_12) / var_47_20

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_12 + var_47_20 and arg_44_1.time_ < var_47_12 + var_47_20 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {
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
			},
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

		arg_44_1:InitPlayNodeList()
	end,
	Play101131012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 101131012
		arg_48_1.duration_ = 4.3

		local var_48_0 = {
			ja = 4.3,
			ko = 3.8,
			zh = 3.7,
			en = 4.1
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
				arg_48_0:Play101131013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 and not isNil(arg_48_1.actors_["1019ui_story"]) and arg_48_1.var_.characterEffect1019ui_story == nil then
				arg_48_1.var_.characterEffect1019ui_story = arg_48_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_0 = 0.1

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_0 and not isNil(arg_48_1.actors_["1019ui_story"]) then
				if arg_48_1.var_.characterEffect1019ui_story and not isNil(arg_48_1.actors_["1019ui_story"]) then
					arg_48_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_48_1.time_ >= 0 + var_51_0 and arg_48_1.time_ < 0 + var_51_0 + arg_51_0 and not isNil(arg_48_1.actors_["1019ui_story"]) and arg_48_1.var_.characterEffect1019ui_story then
				arg_48_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_51_2 = arg_48_1.actors_["1011ui_story"]

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 and not isNil(var_51_2) and arg_48_1.var_.characterEffect1011ui_story == nil then
				arg_48_1.var_.characterEffect1011ui_story = var_51_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_3 = 0.1

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_3 and not isNil(var_51_2) then
				if arg_48_1.var_.characterEffect1011ui_story and not isNil(var_51_2) then
					arg_48_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_48_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_48_1.time_ - 0) / var_51_3)
				end
			end

			if arg_48_1.time_ >= 0 + var_51_3 and arg_48_1.time_ < 0 + var_51_3 + arg_51_0 and not isNil(var_51_2) and arg_48_1.var_.characterEffect1011ui_story then
				arg_48_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_48_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_51_4 = arg_48_1.actors_["1019ui_story"].transform

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1.var_.moveOldPos1019ui_story = var_51_4.localPosition
			end

			local var_51_5 = 0.001

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_5 then
				var_51_4.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos1019ui_story, Vector3.New(-0.7, -1.08, -5.9), (arg_48_1.time_ - 0) / var_51_5)
				var_51_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_51_4.position).x, (manager.ui.mainCamera.transform.position - var_51_4.position).y, (manager.ui.mainCamera.transform.position - var_51_4.position).z)
				var_51_4.localEulerAngles.z = 0
				var_51_4.localEulerAngles.x = 0
				var_51_4.localEulerAngles = var_51_4.localEulerAngles
			end

			if arg_48_1.time_ >= 0 + var_51_5 and arg_48_1.time_ < 0 + var_51_5 + arg_51_0 then
				var_51_4.localPosition = Vector3.New(-0.7, -1.08, -5.9)
				var_51_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_51_4.position).x, (manager.ui.mainCamera.transform.position - var_51_4.position).y, (manager.ui.mainCamera.transform.position - var_51_4.position).z)
				var_51_4.localEulerAngles.z = 0
				var_51_4.localEulerAngles.x = 0
				var_51_4.localEulerAngles = var_51_4.localEulerAngles
			end

			local var_51_6 = arg_48_1.actors_["1011ui_story"].transform

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1.var_.moveOldPos1011ui_story = var_51_6.localPosition
			end

			local var_51_7 = 0.001

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_7 then
				var_51_6.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos1011ui_story, Vector3.New(0.7, -0.71, -6), (arg_48_1.time_ - 0) / var_51_7)
				var_51_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_51_6.position).x, (manager.ui.mainCamera.transform.position - var_51_6.position).y, (manager.ui.mainCamera.transform.position - var_51_6.position).z)
				var_51_6.localEulerAngles.z = 0
				var_51_6.localEulerAngles.x = 0
				var_51_6.localEulerAngles = var_51_6.localEulerAngles
			end

			if arg_48_1.time_ >= 0 + var_51_7 and arg_48_1.time_ < 0 + var_51_7 + arg_51_0 then
				var_51_6.localPosition = Vector3.New(0.7, -0.71, -6)
				var_51_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_51_6.position).x, (manager.ui.mainCamera.transform.position - var_51_6.position).y, (manager.ui.mainCamera.transform.position - var_51_6.position).z)
				var_51_6.localEulerAngles.z = 0
				var_51_6.localEulerAngles.x = 0
				var_51_6.localEulerAngles = var_51_6.localEulerAngles
			end

			local var_51_8 = arg_48_1.actors_["2020_tpose"].transform

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1.var_.moveOldPos2020_tpose = var_51_8.localPosition

				local var_51_9 = GameObjectTools.GetOrAddComponent(var_51_8.gameObject, typeof(DynamicBoneHelper))

				if var_51_9 then
					var_51_9:EnableDynamicBone(false)
				end
			end

			local var_51_10 = 0.001

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_10 then
				var_51_8.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos2020_tpose, Vector3.New(0, 100, 0), (arg_48_1.time_ - 0) / var_51_10)
				var_51_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_51_8.position).x, (manager.ui.mainCamera.transform.position - var_51_8.position).y, (manager.ui.mainCamera.transform.position - var_51_8.position).z)
				var_51_8.localEulerAngles.z = 0
				var_51_8.localEulerAngles.x = 0
				var_51_8.localEulerAngles = var_51_8.localEulerAngles
			end

			if arg_48_1.time_ >= 0 + var_51_10 and arg_48_1.time_ < 0 + var_51_10 + arg_51_0 then
				var_51_8.localPosition = Vector3.New(0, 100, 0)
				var_51_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_51_8.position).x, (manager.ui.mainCamera.transform.position - var_51_8.position).y, (manager.ui.mainCamera.transform.position - var_51_8.position).z)
				var_51_8.localEulerAngles.z = 0
				var_51_8.localEulerAngles.x = 0
				var_51_8.localEulerAngles = var_51_8.localEulerAngles

				local var_51_11 = GameObjectTools.GetOrAddComponent(var_51_8.gameObject, typeof(DynamicBoneHelper))

				if var_51_11 then
					var_51_11:EnableDynamicBone(true)
				end
			end

			local var_51_12 = 0
			local var_51_13 = 0.55

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_12 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				arg_48_1.leftNameTxt_.text = arg_48_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_14 = arg_48_1:GetWordFromCfg(101131012)
				local var_51_15 = arg_48_1:FormatText(var_51_14.content)

				arg_48_1.text_.text = var_51_15

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_17 = 22 <= 0 and var_51_13 or var_51_13 * (utf8.len(var_51_15) / 22)

				if (22 <= 0 and var_51_13 or var_51_13 * (utf8.len(var_51_15) / 22)) > 0 and var_51_13 < var_51_17 then
					arg_48_1.talkMaxDuration = var_51_17

					if var_51_17 + var_51_12 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_17 + var_51_12
					end
				end

				arg_48_1.text_.text = var_51_15
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101131", "101131012", "story_v_out_101131.awb") ~= 0 then
					local var_51_18 = manager.audio:GetVoiceLength("story_v_out_101131", "101131012", "story_v_out_101131.awb") / 1000

					if var_51_18 + var_51_12 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_18 + var_51_12
					end

					if var_51_14.prefab_name ~= "" and arg_48_1.actors_[var_51_14.prefab_name] ~= nil then
						local var_51_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_14.prefab_name].transform, "story_v_out_101131", "101131012", "story_v_out_101131.awb")

						arg_48_1:RecordAudio("101131012", var_51_19)
						arg_48_1:RecordAudio("101131012", var_51_19)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_101131", "101131012", "story_v_out_101131.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_101131", "101131012", "story_v_out_101131.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_20 = math.max(var_51_13, arg_48_1.talkMaxDuration)

			if var_51_12 <= arg_48_1.time_ and arg_48_1.time_ < var_51_12 + var_51_20 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_12) / var_51_20

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_12 + var_51_20 and arg_48_1.time_ < var_51_12 + var_51_20 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {
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
			},
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

		arg_48_1:InitPlayNodeList()
	end,
	Play101131013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 101131013
		arg_52_1.duration_ = 15.23

		local var_52_0 = {
			ja = 15.233,
			ko = 11.566,
			zh = 12.3,
			en = 13.433
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
				arg_52_0:Play101131014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 and not isNil(arg_52_1.actors_["2020_tpose"]) and arg_52_1.var_.characterEffect2020_tpose == nil then
				arg_52_1.var_.characterEffect2020_tpose = arg_52_1.actors_["2020_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_0 = 0.1

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_0 and not isNil(arg_52_1.actors_["2020_tpose"]) then
				if arg_52_1.var_.characterEffect2020_tpose and not isNil(arg_52_1.actors_["2020_tpose"]) then
					arg_52_1.var_.characterEffect2020_tpose.fillFlat = false
				end
			end

			if arg_52_1.time_ >= 0 + var_55_0 and arg_52_1.time_ < 0 + var_55_0 + arg_55_0 and not isNil(arg_52_1.actors_["2020_tpose"]) and arg_52_1.var_.characterEffect2020_tpose then
				arg_52_1.var_.characterEffect2020_tpose.fillFlat = false
			end

			local var_55_2 = arg_52_1.actors_["1019ui_story"]

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 and not isNil(var_55_2) and arg_52_1.var_.characterEffect1019ui_story == nil then
				arg_52_1.var_.characterEffect1019ui_story = var_55_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_3 = 0.1

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_3 and not isNil(var_55_2) then
				if arg_52_1.var_.characterEffect1019ui_story and not isNil(var_55_2) then
					arg_52_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_52_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_52_1.time_ - 0) / var_55_3)
				end
			end

			if arg_52_1.time_ >= 0 + var_55_3 and arg_52_1.time_ < 0 + var_55_3 + arg_55_0 and not isNil(var_55_2) and arg_52_1.var_.characterEffect1019ui_story then
				arg_52_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_52_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_55_4 = 0
			local var_55_5 = 1.425

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_4 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				arg_52_1.leftNameTxt_.text = arg_52_1:FormatText(StoryNameCfg[19].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, true)
				arg_52_1.iconController_:SetSelectedState("hero")

				arg_52_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_20301")

				arg_52_1.callingController_:SetSelectedState("normal")

				arg_52_1.keyicon_.color = Color.New(1, 1, 1)
				arg_52_1.icon_.color = Color.New(1, 1, 1)

				local var_55_6 = arg_52_1:GetWordFromCfg(101131013)
				local var_55_7 = arg_52_1:FormatText(var_55_6.content)

				arg_52_1.text_.text = var_55_7

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_9 = 57 <= 0 and var_55_5 or var_55_5 * (utf8.len(var_55_7) / 57)

				if (57 <= 0 and var_55_5 or var_55_5 * (utf8.len(var_55_7) / 57)) > 0 and var_55_5 < var_55_9 then
					arg_52_1.talkMaxDuration = var_55_9

					if var_55_9 + var_55_4 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_9 + var_55_4
					end
				end

				arg_52_1.text_.text = var_55_7
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101131", "101131013", "story_v_out_101131.awb") ~= 0 then
					local var_55_10 = manager.audio:GetVoiceLength("story_v_out_101131", "101131013", "story_v_out_101131.awb") / 1000

					if var_55_10 + var_55_4 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_10 + var_55_4
					end

					if var_55_6.prefab_name ~= "" and arg_52_1.actors_[var_55_6.prefab_name] ~= nil then
						local var_55_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_6.prefab_name].transform, "story_v_out_101131", "101131013", "story_v_out_101131.awb")

						arg_52_1:RecordAudio("101131013", var_55_11)
						arg_52_1:RecordAudio("101131013", var_55_11)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_101131", "101131013", "story_v_out_101131.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_101131", "101131013", "story_v_out_101131.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_12 = math.max(var_55_5, arg_52_1.talkMaxDuration)

			if var_55_4 <= arg_52_1.time_ and arg_52_1.time_ < var_55_4 + var_55_12 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_4) / var_55_12

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_4 + var_55_12 and arg_52_1.time_ < var_55_4 + var_55_12 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play101131014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 101131014
		arg_56_1.duration_ = 15.1

		local var_56_0 = {
			ja = 7.633,
			ko = 14.8,
			zh = 14,
			en = 15.1
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
				arg_56_0:Play101131015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 and not isNil(arg_56_1.actors_["2020_tpose"]) and arg_56_1.var_.characterEffect2020_tpose == nil then
				arg_56_1.var_.characterEffect2020_tpose = arg_56_1.actors_["2020_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_0 = 0.1

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_0 and not isNil(arg_56_1.actors_["2020_tpose"]) then
				if arg_56_1.var_.characterEffect2020_tpose and not isNil(arg_56_1.actors_["2020_tpose"]) then
					arg_56_1.var_.characterEffect2020_tpose.fillFlat = false
				end
			end

			if arg_56_1.time_ >= 0 + var_59_0 and arg_56_1.time_ < 0 + var_59_0 + arg_59_0 and not isNil(arg_56_1.actors_["2020_tpose"]) and arg_56_1.var_.characterEffect2020_tpose then
				arg_56_1.var_.characterEffect2020_tpose.fillFlat = false
			end

			local var_59_2 = arg_56_1.actors_["2020_tpose"]

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 and not isNil(var_59_2) and arg_56_1.var_.characterEffect2020_tpose == nil then
				arg_56_1.var_.characterEffect2020_tpose = var_59_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_3 = 0.1

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_3 and not isNil(var_59_2) then
				if arg_56_1.var_.characterEffect2020_tpose and not isNil(var_59_2) then
					arg_56_1.var_.characterEffect2020_tpose.fillFlat = true
					arg_56_1.var_.characterEffect2020_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_56_1.time_ - 0) / var_59_3)
				end
			end

			if arg_56_1.time_ >= 0 + var_59_3 and arg_56_1.time_ < 0 + var_59_3 + arg_59_0 and not isNil(var_59_2) and arg_56_1.var_.characterEffect2020_tpose then
				arg_56_1.var_.characterEffect2020_tpose.fillFlat = true
				arg_56_1.var_.characterEffect2020_tpose.fillRatio = 0.5
			end

			local var_59_4 = 0
			local var_59_5 = 1.65

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_4 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				arg_56_1.leftNameTxt_.text = arg_56_1:FormatText(StoryNameCfg[19].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, true)
				arg_56_1.iconController_:SetSelectedState("hero")

				arg_56_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_20301")

				arg_56_1.callingController_:SetSelectedState("normal")

				arg_56_1.keyicon_.color = Color.New(1, 1, 1)
				arg_56_1.icon_.color = Color.New(1, 1, 1)

				local var_59_6 = arg_56_1:GetWordFromCfg(101131014)
				local var_59_7 = arg_56_1:FormatText(var_59_6.content)

				arg_56_1.text_.text = var_59_7

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_9 = 66 <= 0 and var_59_5 or var_59_5 * (utf8.len(var_59_7) / 66)

				if (66 <= 0 and var_59_5 or var_59_5 * (utf8.len(var_59_7) / 66)) > 0 and var_59_5 < var_59_9 then
					arg_56_1.talkMaxDuration = var_59_9

					if var_59_9 + var_59_4 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_9 + var_59_4
					end
				end

				arg_56_1.text_.text = var_59_7
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101131", "101131014", "story_v_out_101131.awb") ~= 0 then
					local var_59_10 = manager.audio:GetVoiceLength("story_v_out_101131", "101131014", "story_v_out_101131.awb") / 1000

					if var_59_10 + var_59_4 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_10 + var_59_4
					end

					if var_59_6.prefab_name ~= "" and arg_56_1.actors_[var_59_6.prefab_name] ~= nil then
						local var_59_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_6.prefab_name].transform, "story_v_out_101131", "101131014", "story_v_out_101131.awb")

						arg_56_1:RecordAudio("101131014", var_59_11)
						arg_56_1:RecordAudio("101131014", var_59_11)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_101131", "101131014", "story_v_out_101131.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_101131", "101131014", "story_v_out_101131.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_12 = math.max(var_59_5, arg_56_1.talkMaxDuration)

			if var_59_4 <= arg_56_1.time_ and arg_56_1.time_ < var_59_4 + var_59_12 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_4) / var_59_12

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_4 + var_59_12 and arg_56_1.time_ < var_59_4 + var_59_12 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play101131015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 101131015
		arg_60_1.duration_ = 2.67

		local var_60_0 = {
			ja = 1.999999999999,
			ko = 2.666,
			zh = 2.033,
			en = 1.999999999999
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
				arg_60_0:Play101131016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 and not isNil(arg_60_1.actors_["1019ui_story"]) and arg_60_1.var_.characterEffect1019ui_story == nil then
				arg_60_1.var_.characterEffect1019ui_story = arg_60_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_0 = 0.1

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_0 and not isNil(arg_60_1.actors_["1019ui_story"]) then
				if arg_60_1.var_.characterEffect1019ui_story and not isNil(arg_60_1.actors_["1019ui_story"]) then
					arg_60_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_60_1.time_ >= 0 + var_63_0 and arg_60_1.time_ < 0 + var_63_0 + arg_63_0 and not isNil(arg_60_1.actors_["1019ui_story"]) and arg_60_1.var_.characterEffect1019ui_story then
				arg_60_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_63_2 = arg_60_1.actors_["2020_tpose"]

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 and not isNil(var_63_2) and arg_60_1.var_.characterEffect2020_tpose == nil then
				arg_60_1.var_.characterEffect2020_tpose = var_63_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_3 = 0.1

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_3 and not isNil(var_63_2) then
				if arg_60_1.var_.characterEffect2020_tpose and not isNil(var_63_2) then
					arg_60_1.var_.characterEffect2020_tpose.fillFlat = true
					arg_60_1.var_.characterEffect2020_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_60_1.time_ - 0) / var_63_3)
				end
			end

			if arg_60_1.time_ >= 0 + var_63_3 and arg_60_1.time_ < 0 + var_63_3 + arg_63_0 and not isNil(var_63_2) and arg_60_1.var_.characterEffect2020_tpose then
				arg_60_1.var_.characterEffect2020_tpose.fillFlat = true
				arg_60_1.var_.characterEffect2020_tpose.fillRatio = 0.5
			end

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action456")
			end

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_63_4 = 0
			local var_63_5 = 0.2

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= var_63_4 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				arg_60_1.leftNameTxt_.text = arg_60_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_6 = arg_60_1:GetWordFromCfg(101131015)
				local var_63_7 = arg_60_1:FormatText(var_63_6.content)

				arg_60_1.text_.text = var_63_7

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_9 = 8 <= 0 and var_63_5 or var_63_5 * (utf8.len(var_63_7) / 8)

				if (8 <= 0 and var_63_5 or var_63_5 * (utf8.len(var_63_7) / 8)) > 0 and var_63_5 < var_63_9 then
					arg_60_1.talkMaxDuration = var_63_9

					if var_63_9 + var_63_4 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_9 + var_63_4
					end
				end

				arg_60_1.text_.text = var_63_7
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101131", "101131015", "story_v_out_101131.awb") ~= 0 then
					local var_63_10 = manager.audio:GetVoiceLength("story_v_out_101131", "101131015", "story_v_out_101131.awb") / 1000

					if var_63_10 + var_63_4 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_10 + var_63_4
					end

					if var_63_6.prefab_name ~= "" and arg_60_1.actors_[var_63_6.prefab_name] ~= nil then
						local var_63_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_6.prefab_name].transform, "story_v_out_101131", "101131015", "story_v_out_101131.awb")

						arg_60_1:RecordAudio("101131015", var_63_11)
						arg_60_1:RecordAudio("101131015", var_63_11)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_101131", "101131015", "story_v_out_101131.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_101131", "101131015", "story_v_out_101131.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_12 = math.max(var_63_5, arg_60_1.talkMaxDuration)

			if var_63_4 <= arg_60_1.time_ and arg_60_1.time_ < var_63_4 + var_63_12 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_4) / var_63_12

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_4 + var_63_12 and arg_60_1.time_ < var_63_4 + var_63_12 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play101131016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 101131016
		arg_64_1.duration_ = 6.13

		local var_64_0 = {
			ja = 6.133,
			ko = 5.333,
			zh = 4.366,
			en = 4.5
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
				arg_64_0:Play101131017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 and not isNil(arg_64_1.actors_["1084ui_story"]) and arg_64_1.var_.characterEffect1084ui_story == nil then
				arg_64_1.var_.characterEffect1084ui_story = arg_64_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_0 = 0.1

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_0 and not isNil(arg_64_1.actors_["1084ui_story"]) then
				if arg_64_1.var_.characterEffect1084ui_story and not isNil(arg_64_1.actors_["1084ui_story"]) then
					arg_64_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_64_1.time_ >= 0 + var_67_0 and arg_64_1.time_ < 0 + var_67_0 + arg_67_0 and not isNil(arg_64_1.actors_["1084ui_story"]) and arg_64_1.var_.characterEffect1084ui_story then
				arg_64_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_67_2 = arg_64_1.actors_["1019ui_story"]

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 and not isNil(var_67_2) and arg_64_1.var_.characterEffect1019ui_story == nil then
				arg_64_1.var_.characterEffect1019ui_story = var_67_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_3 = 0.1

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_3 and not isNil(var_67_2) then
				if arg_64_1.var_.characterEffect1019ui_story and not isNil(var_67_2) then
					arg_64_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_64_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_64_1.time_ - 0) / var_67_3)
				end
			end

			if arg_64_1.time_ >= 0 + var_67_3 and arg_64_1.time_ < 0 + var_67_3 + arg_67_0 and not isNil(var_67_2) and arg_64_1.var_.characterEffect1019ui_story then
				arg_64_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_64_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_67_4 = arg_64_1.actors_["1019ui_story"].transform

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1.var_.moveOldPos1019ui_story = var_67_4.localPosition
			end

			local var_67_5 = 0.001

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_5 then
				var_67_4.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos1019ui_story, Vector3.New(-0.7, -1.08, -5.9), (arg_64_1.time_ - 0) / var_67_5)
				var_67_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_67_4.position).x, (manager.ui.mainCamera.transform.position - var_67_4.position).y, (manager.ui.mainCamera.transform.position - var_67_4.position).z)
				var_67_4.localEulerAngles.z = 0
				var_67_4.localEulerAngles.x = 0
				var_67_4.localEulerAngles = var_67_4.localEulerAngles
			end

			if arg_64_1.time_ >= 0 + var_67_5 and arg_64_1.time_ < 0 + var_67_5 + arg_67_0 then
				var_67_4.localPosition = Vector3.New(-0.7, -1.08, -5.9)
				var_67_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_67_4.position).x, (manager.ui.mainCamera.transform.position - var_67_4.position).y, (manager.ui.mainCamera.transform.position - var_67_4.position).z)
				var_67_4.localEulerAngles.z = 0
				var_67_4.localEulerAngles.x = 0
				var_67_4.localEulerAngles = var_67_4.localEulerAngles
			end

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			local var_67_6 = arg_64_1.actors_["1084ui_story"].transform

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1.var_.moveOldPos1084ui_story = var_67_6.localPosition
			end

			local var_67_7 = 0.001

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_7 then
				var_67_6.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos1084ui_story, Vector3.New(0.7, -0.97, -6), (arg_64_1.time_ - 0) / var_67_7)
				var_67_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_67_6.position).x, (manager.ui.mainCamera.transform.position - var_67_6.position).y, (manager.ui.mainCamera.transform.position - var_67_6.position).z)
				var_67_6.localEulerAngles.z = 0
				var_67_6.localEulerAngles.x = 0
				var_67_6.localEulerAngles = var_67_6.localEulerAngles
			end

			if arg_64_1.time_ >= 0 + var_67_7 and arg_64_1.time_ < 0 + var_67_7 + arg_67_0 then
				var_67_6.localPosition = Vector3.New(0.7, -0.97, -6)
				var_67_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_67_6.position).x, (manager.ui.mainCamera.transform.position - var_67_6.position).y, (manager.ui.mainCamera.transform.position - var_67_6.position).z)
				var_67_6.localEulerAngles.z = 0
				var_67_6.localEulerAngles.x = 0
				var_67_6.localEulerAngles = var_67_6.localEulerAngles
			end

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_67_8 = arg_64_1.actors_["1011ui_story"].transform

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1.var_.moveOldPos1011ui_story = var_67_8.localPosition
			end

			local var_67_9 = 0.001

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_9 then
				var_67_8.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_64_1.time_ - 0) / var_67_9)
				var_67_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_67_8.position).x, (manager.ui.mainCamera.transform.position - var_67_8.position).y, (manager.ui.mainCamera.transform.position - var_67_8.position).z)
				var_67_8.localEulerAngles.z = 0
				var_67_8.localEulerAngles.x = 0
				var_67_8.localEulerAngles = var_67_8.localEulerAngles
			end

			if arg_64_1.time_ >= 0 + var_67_9 and arg_64_1.time_ < 0 + var_67_9 + arg_67_0 then
				var_67_8.localPosition = Vector3.New(0, 100, 0)
				var_67_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_67_8.position).x, (manager.ui.mainCamera.transform.position - var_67_8.position).y, (manager.ui.mainCamera.transform.position - var_67_8.position).z)
				var_67_8.localEulerAngles.z = 0
				var_67_8.localEulerAngles.x = 0
				var_67_8.localEulerAngles = var_67_8.localEulerAngles
			end

			local var_67_10 = 0
			local var_67_11 = 0.725

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= var_67_10 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				arg_64_1.leftNameTxt_.text = arg_64_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_12 = arg_64_1:GetWordFromCfg(101131016)
				local var_67_13 = arg_64_1:FormatText(var_67_12.content)

				arg_64_1.text_.text = var_67_13

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_15 = 25 <= 0 and var_67_11 or var_67_11 * (utf8.len(var_67_13) / 25)

				if (25 <= 0 and var_67_11 or var_67_11 * (utf8.len(var_67_13) / 25)) > 0 and var_67_11 < var_67_15 then
					arg_64_1.talkMaxDuration = var_67_15

					if var_67_15 + var_67_10 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_15 + var_67_10
					end
				end

				arg_64_1.text_.text = var_67_13
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101131", "101131016", "story_v_out_101131.awb") ~= 0 then
					local var_67_16 = manager.audio:GetVoiceLength("story_v_out_101131", "101131016", "story_v_out_101131.awb") / 1000

					if var_67_16 + var_67_10 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_16 + var_67_10
					end

					if var_67_12.prefab_name ~= "" and arg_64_1.actors_[var_67_12.prefab_name] ~= nil then
						local var_67_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_12.prefab_name].transform, "story_v_out_101131", "101131016", "story_v_out_101131.awb")

						arg_64_1:RecordAudio("101131016", var_67_17)
						arg_64_1:RecordAudio("101131016", var_67_17)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_101131", "101131016", "story_v_out_101131.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_101131", "101131016", "story_v_out_101131.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_18 = math.max(var_67_11, arg_64_1.talkMaxDuration)

			if var_67_10 <= arg_64_1.time_ and arg_64_1.time_ < var_67_10 + var_67_18 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_10) / var_67_18

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_10 + var_67_18 and arg_64_1.time_ < var_67_10 + var_67_18 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {
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
				actorName = "1084ui_story",
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

		arg_64_1:InitPlayNodeList()
	end,
	Play101131017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 101131017
		arg_68_1.duration_ = 4.47

		local var_68_0 = {
			ja = 4.466,
			ko = 2.8,
			zh = 2.5,
			en = 2.666
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
				arg_68_0:Play101131018(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			if arg_68_1.actors_["3010_tpose"] == nil and not isNil((Asset.Load("Char/" .. "3010_tpose"))) then
				local var_71_0 = Object.Instantiate(Asset.Load("Char/" .. "3010_tpose"), arg_68_1.stage_.transform)

				var_71_0.name = "3010_tpose"
				var_71_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_68_1.actors_["3010_tpose"] = var_71_0

				local var_71_1 = var_71_0:GetComponentInChildren(typeof(CharacterEffect))

				var_71_1.enabled = true

				local var_71_2 = GameObjectTools.GetOrAddComponent(var_71_0, typeof(DynamicBoneHelper))

				if var_71_2 then
					var_71_2:EnableDynamicBone(false)
				end

				arg_68_1:ShowWeapon(var_71_1.transform, false)

				arg_68_1.var_["3010_tpose" .. "Animator"] = var_71_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_68_1.var_["3010_tpose" .. "Animator"].applyRootMotion = true
				arg_68_1.var_["3010_tpose" .. "LipSync"] = var_71_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_71_3 = arg_68_1.actors_["3010_tpose"]

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 and not isNil(var_71_3) and arg_68_1.var_.characterEffect3010_tpose == nil then
				arg_68_1.var_.characterEffect3010_tpose = var_71_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_4 = 0.1

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_4 and not isNil(var_71_3) then
				if arg_68_1.var_.characterEffect3010_tpose and not isNil(var_71_3) then
					arg_68_1.var_.characterEffect3010_tpose.fillFlat = false
				end
			end

			if arg_68_1.time_ >= 0 + var_71_4 and arg_68_1.time_ < 0 + var_71_4 + arg_71_0 and not isNil(var_71_3) and arg_68_1.var_.characterEffect3010_tpose then
				arg_68_1.var_.characterEffect3010_tpose.fillFlat = false
			end

			local var_71_6 = arg_68_1.actors_["1084ui_story"].transform

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1.var_.moveOldPos1084ui_story = var_71_6.localPosition
			end

			local var_71_7 = 0.001

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_7 then
				var_71_6.localPosition = Vector3.Lerp(arg_68_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_68_1.time_ - 0) / var_71_7)
				var_71_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_71_6.position).x, (manager.ui.mainCamera.transform.position - var_71_6.position).y, (manager.ui.mainCamera.transform.position - var_71_6.position).z)
				var_71_6.localEulerAngles.z = 0
				var_71_6.localEulerAngles.x = 0
				var_71_6.localEulerAngles = var_71_6.localEulerAngles
			end

			if arg_68_1.time_ >= 0 + var_71_7 and arg_68_1.time_ < 0 + var_71_7 + arg_71_0 then
				var_71_6.localPosition = Vector3.New(0, 100, 0)
				var_71_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_71_6.position).x, (manager.ui.mainCamera.transform.position - var_71_6.position).y, (manager.ui.mainCamera.transform.position - var_71_6.position).z)
				var_71_6.localEulerAngles.z = 0
				var_71_6.localEulerAngles.x = 0
				var_71_6.localEulerAngles = var_71_6.localEulerAngles
			end

			local var_71_8 = arg_68_1.actors_["1019ui_story"].transform

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1.var_.moveOldPos1019ui_story = var_71_8.localPosition
			end

			local var_71_9 = 0.001

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_9 then
				var_71_8.localPosition = Vector3.Lerp(arg_68_1.var_.moveOldPos1019ui_story, Vector3.New(0, 100, 0), (arg_68_1.time_ - 0) / var_71_9)
				var_71_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_71_8.position).x, (manager.ui.mainCamera.transform.position - var_71_8.position).y, (manager.ui.mainCamera.transform.position - var_71_8.position).z)
				var_71_8.localEulerAngles.z = 0
				var_71_8.localEulerAngles.x = 0
				var_71_8.localEulerAngles = var_71_8.localEulerAngles
			end

			if arg_68_1.time_ >= 0 + var_71_9 and arg_68_1.time_ < 0 + var_71_9 + arg_71_0 then
				var_71_8.localPosition = Vector3.New(0, 100, 0)
				var_71_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_71_8.position).x, (manager.ui.mainCamera.transform.position - var_71_8.position).y, (manager.ui.mainCamera.transform.position - var_71_8.position).z)
				var_71_8.localEulerAngles.z = 0
				var_71_8.localEulerAngles.x = 0
				var_71_8.localEulerAngles = var_71_8.localEulerAngles
			end

			local var_71_10 = arg_68_1.actors_["3010_tpose"].transform

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1.var_.moveOldPos3010_tpose = var_71_10.localPosition

				local var_71_11 = GameObjectTools.GetOrAddComponent(var_71_10.gameObject, typeof(DynamicBoneHelper))

				if var_71_11 then
					var_71_11:EnableDynamicBone(false)
				end
			end

			local var_71_12 = 0.001

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_12 then
				var_71_10.localPosition = Vector3.Lerp(arg_68_1.var_.moveOldPos3010_tpose, Vector3.New(0, -1.59, -1.6), (arg_68_1.time_ - 0) / var_71_12)
				var_71_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_71_10.position).x, (manager.ui.mainCamera.transform.position - var_71_10.position).y, (manager.ui.mainCamera.transform.position - var_71_10.position).z)
				var_71_10.localEulerAngles.z = 0
				var_71_10.localEulerAngles.x = 0
				var_71_10.localEulerAngles = var_71_10.localEulerAngles
			end

			if arg_68_1.time_ >= 0 + var_71_12 and arg_68_1.time_ < 0 + var_71_12 + arg_71_0 then
				var_71_10.localPosition = Vector3.New(0, -1.59, -1.6)
				var_71_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_71_10.position).x, (manager.ui.mainCamera.transform.position - var_71_10.position).y, (manager.ui.mainCamera.transform.position - var_71_10.position).z)
				var_71_10.localEulerAngles.z = 0
				var_71_10.localEulerAngles.x = 0
				var_71_10.localEulerAngles = var_71_10.localEulerAngles

				local var_71_13 = GameObjectTools.GetOrAddComponent(var_71_10.gameObject, typeof(DynamicBoneHelper))

				if var_71_13 then
					var_71_13:EnableDynamicBone(true)
				end
			end

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1:PlayTimeline("3010_tpose", "StoryTimeline/CharAction/story3010/story3010action/3010action1_1")
			end

			local var_71_14 = 0
			local var_71_15 = 0.25

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= var_71_14 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				arg_68_1.leftNameTxt_.text = arg_68_1:FormatText(StoryNameCfg[40].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_16 = arg_68_1:GetWordFromCfg(101131017)
				local var_71_17 = arg_68_1:FormatText(var_71_16.content)

				arg_68_1.text_.text = var_71_17

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_19 = 10 <= 0 and var_71_15 or var_71_15 * (utf8.len(var_71_17) / 10)

				if (10 <= 0 and var_71_15 or var_71_15 * (utf8.len(var_71_17) / 10)) > 0 and var_71_15 < var_71_19 then
					arg_68_1.talkMaxDuration = var_71_19

					if var_71_19 + var_71_14 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_19 + var_71_14
					end
				end

				arg_68_1.text_.text = var_71_17
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101131", "101131017", "story_v_out_101131.awb") ~= 0 then
					local var_71_20 = manager.audio:GetVoiceLength("story_v_out_101131", "101131017", "story_v_out_101131.awb") / 1000

					if var_71_20 + var_71_14 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_20 + var_71_14
					end

					if var_71_16.prefab_name ~= "" and arg_68_1.actors_[var_71_16.prefab_name] ~= nil then
						local var_71_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_16.prefab_name].transform, "story_v_out_101131", "101131017", "story_v_out_101131.awb")

						arg_68_1:RecordAudio("101131017", var_71_21)
						arg_68_1:RecordAudio("101131017", var_71_21)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_101131", "101131017", "story_v_out_101131.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_101131", "101131017", "story_v_out_101131.awb")
				end

				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_22 = math.max(var_71_15, arg_68_1.talkMaxDuration)

			if var_71_14 <= arg_68_1.time_ and arg_68_1.time_ < var_71_14 + var_71_22 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_14) / var_71_22

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_14 + var_71_22 and arg_68_1.time_ < var_71_14 + var_71_22 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
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
				actorName = "3010_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_68_1:InitPlayNodeList()
	end,
	Play101131018 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 101131018
		arg_72_1.duration_ = 3.4

		local var_72_0 = {
			ja = 3.4,
			ko = 1.533,
			zh = 1.8,
			en = 1.633
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
				arg_72_0:Play101131019(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 and not isNil(arg_72_1.actors_["3010_tpose"]) and arg_72_1.var_.characterEffect3010_tpose == nil then
				arg_72_1.var_.characterEffect3010_tpose = arg_72_1.actors_["3010_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_0 = 0.1

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_0 and not isNil(arg_72_1.actors_["3010_tpose"]) then
				if arg_72_1.var_.characterEffect3010_tpose and not isNil(arg_72_1.actors_["3010_tpose"]) then
					arg_72_1.var_.characterEffect3010_tpose.fillFlat = true
					arg_72_1.var_.characterEffect3010_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_72_1.time_ - 0) / var_75_0)
				end
			end

			if arg_72_1.time_ >= 0 + var_75_0 and arg_72_1.time_ < 0 + var_75_0 + arg_75_0 and not isNil(arg_72_1.actors_["3010_tpose"]) and arg_72_1.var_.characterEffect3010_tpose then
				arg_72_1.var_.characterEffect3010_tpose.fillFlat = true
				arg_72_1.var_.characterEffect3010_tpose.fillRatio = 0.5
			end

			local var_75_1 = 0
			local var_75_2 = 0.2

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= var_75_1 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				arg_72_1.leftNameTxt_.text = arg_72_1:FormatText(StoryNameCfg[41].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, true)
				arg_72_1.iconController_:SetSelectedState("hero")

				arg_72_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_20301")

				arg_72_1.callingController_:SetSelectedState("normal")

				arg_72_1.keyicon_.color = Color.New(1, 1, 1)
				arg_72_1.icon_.color = Color.New(1, 1, 1)

				local var_75_3 = arg_72_1:GetWordFromCfg(101131018)
				local var_75_4 = arg_72_1:FormatText(var_75_3.content)

				arg_72_1.text_.text = var_75_4

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_6 = 8 <= 0 and var_75_2 or var_75_2 * (utf8.len(var_75_4) / 8)

				if (8 <= 0 and var_75_2 or var_75_2 * (utf8.len(var_75_4) / 8)) > 0 and var_75_2 < var_75_6 then
					arg_72_1.talkMaxDuration = var_75_6

					if var_75_6 + var_75_1 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_6 + var_75_1
					end
				end

				arg_72_1.text_.text = var_75_4
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101131", "101131018", "story_v_out_101131.awb") ~= 0 then
					local var_75_7 = manager.audio:GetVoiceLength("story_v_out_101131", "101131018", "story_v_out_101131.awb") / 1000

					if var_75_7 + var_75_1 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_7 + var_75_1
					end

					if var_75_3.prefab_name ~= "" and arg_72_1.actors_[var_75_3.prefab_name] ~= nil then
						local var_75_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_3.prefab_name].transform, "story_v_out_101131", "101131018", "story_v_out_101131.awb")

						arg_72_1:RecordAudio("101131018", var_75_8)
						arg_72_1:RecordAudio("101131018", var_75_8)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_101131", "101131018", "story_v_out_101131.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_101131", "101131018", "story_v_out_101131.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_9 = math.max(var_75_2, arg_72_1.talkMaxDuration)

			if var_75_1 <= arg_72_1.time_ and arg_72_1.time_ < var_75_1 + var_75_9 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_1) / var_75_9

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_1 + var_75_9 and arg_72_1.time_ < var_75_1 + var_75_9 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {}

		arg_72_1:InitPlayNodeList()
	end,
	Play101131019 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 101131019
		arg_76_1.duration_ = 5.8

		local var_76_0 = {
			ja = 5.8,
			ko = 3.6,
			zh = 4.866,
			en = 4.833
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
				arg_76_0:Play101131020(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 and not isNil(arg_76_1.actors_["3010_tpose"]) and arg_76_1.var_.characterEffect3010_tpose == nil then
				arg_76_1.var_.characterEffect3010_tpose = arg_76_1.actors_["3010_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_0 = 0.1

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_0 and not isNil(arg_76_1.actors_["3010_tpose"]) then
				if arg_76_1.var_.characterEffect3010_tpose and not isNil(arg_76_1.actors_["3010_tpose"]) then
					arg_76_1.var_.characterEffect3010_tpose.fillFlat = false
				end
			end

			if arg_76_1.time_ >= 0 + var_79_0 and arg_76_1.time_ < 0 + var_79_0 + arg_79_0 and not isNil(arg_76_1.actors_["3010_tpose"]) and arg_76_1.var_.characterEffect3010_tpose then
				arg_76_1.var_.characterEffect3010_tpose.fillFlat = false
			end

			local var_79_2 = 0
			local var_79_3 = 0.55

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= var_79_2 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				arg_76_1.leftNameTxt_.text = arg_76_1:FormatText(StoryNameCfg[40].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_4 = arg_76_1:GetWordFromCfg(101131019)
				local var_79_5 = arg_76_1:FormatText(var_79_4.content)

				arg_76_1.text_.text = var_79_5

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_7 = 20 <= 0 and var_79_3 or var_79_3 * (utf8.len(var_79_5) / 20)

				if (20 <= 0 and var_79_3 or var_79_3 * (utf8.len(var_79_5) / 20)) > 0 and var_79_3 < var_79_7 then
					arg_76_1.talkMaxDuration = var_79_7

					if var_79_7 + var_79_2 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_7 + var_79_2
					end
				end

				arg_76_1.text_.text = var_79_5
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101131", "101131019", "story_v_out_101131.awb") ~= 0 then
					local var_79_8 = manager.audio:GetVoiceLength("story_v_out_101131", "101131019", "story_v_out_101131.awb") / 1000

					if var_79_8 + var_79_2 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_8 + var_79_2
					end

					if var_79_4.prefab_name ~= "" and arg_76_1.actors_[var_79_4.prefab_name] ~= nil then
						local var_79_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_4.prefab_name].transform, "story_v_out_101131", "101131019", "story_v_out_101131.awb")

						arg_76_1:RecordAudio("101131019", var_79_9)
						arg_76_1:RecordAudio("101131019", var_79_9)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_101131", "101131019", "story_v_out_101131.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_101131", "101131019", "story_v_out_101131.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_10 = math.max(var_79_3, arg_76_1.talkMaxDuration)

			if var_79_2 <= arg_76_1.time_ and arg_76_1.time_ < var_79_2 + var_79_10 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_2) / var_79_10

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_2 + var_79_10 and arg_76_1.time_ < var_79_2 + var_79_10 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {}

		arg_76_1:InitPlayNodeList()
	end,
	Play101131020 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 101131020
		arg_80_1.duration_ = 4.13

		local var_80_0 = {
			ja = 2.933,
			ko = 3.2,
			zh = 3.233,
			en = 4.133
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
				arg_80_0:Play101131021(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 and not isNil(arg_80_1.actors_["1011ui_story"]) and arg_80_1.var_.characterEffect1011ui_story == nil then
				arg_80_1.var_.characterEffect1011ui_story = arg_80_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_0 = 0.1

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_0 and not isNil(arg_80_1.actors_["1011ui_story"]) then
				if arg_80_1.var_.characterEffect1011ui_story and not isNil(arg_80_1.actors_["1011ui_story"]) then
					arg_80_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_80_1.time_ >= 0 + var_83_0 and arg_80_1.time_ < 0 + var_83_0 + arg_83_0 and not isNil(arg_80_1.actors_["1011ui_story"]) and arg_80_1.var_.characterEffect1011ui_story then
				arg_80_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_83_2 = arg_80_1.actors_["3010_tpose"]

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 and not isNil(var_83_2) and arg_80_1.var_.characterEffect3010_tpose == nil then
				arg_80_1.var_.characterEffect3010_tpose = var_83_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_3 = 0.1

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_3 and not isNil(var_83_2) then
				if arg_80_1.var_.characterEffect3010_tpose and not isNil(var_83_2) then
					arg_80_1.var_.characterEffect3010_tpose.fillFlat = true
					arg_80_1.var_.characterEffect3010_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_80_1.time_ - 0) / var_83_3)
				end
			end

			if arg_80_1.time_ >= 0 + var_83_3 and arg_80_1.time_ < 0 + var_83_3 + arg_83_0 and not isNil(var_83_2) and arg_80_1.var_.characterEffect3010_tpose then
				arg_80_1.var_.characterEffect3010_tpose.fillFlat = true
				arg_80_1.var_.characterEffect3010_tpose.fillRatio = 0.5
			end

			local var_83_4 = arg_80_1.actors_["3010_tpose"].transform

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1.var_.moveOldPos3010_tpose = var_83_4.localPosition

				local var_83_5 = GameObjectTools.GetOrAddComponent(var_83_4.gameObject, typeof(DynamicBoneHelper))

				if var_83_5 then
					var_83_5:EnableDynamicBone(false)
				end
			end

			local var_83_6 = 0.001

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_6 then
				var_83_4.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPos3010_tpose, Vector3.New(0, 100, 0), (arg_80_1.time_ - 0) / var_83_6)
				var_83_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_83_4.position).x, (manager.ui.mainCamera.transform.position - var_83_4.position).y, (manager.ui.mainCamera.transform.position - var_83_4.position).z)
				var_83_4.localEulerAngles.z = 0
				var_83_4.localEulerAngles.x = 0
				var_83_4.localEulerAngles = var_83_4.localEulerAngles
			end

			if arg_80_1.time_ >= 0 + var_83_6 and arg_80_1.time_ < 0 + var_83_6 + arg_83_0 then
				var_83_4.localPosition = Vector3.New(0, 100, 0)
				var_83_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_83_4.position).x, (manager.ui.mainCamera.transform.position - var_83_4.position).y, (manager.ui.mainCamera.transform.position - var_83_4.position).z)
				var_83_4.localEulerAngles.z = 0
				var_83_4.localEulerAngles.x = 0
				var_83_4.localEulerAngles = var_83_4.localEulerAngles

				local var_83_7 = GameObjectTools.GetOrAddComponent(var_83_4.gameObject, typeof(DynamicBoneHelper))

				if var_83_7 then
					var_83_7:EnableDynamicBone(true)
				end
			end

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action2_1")
			end

			local var_83_8 = arg_80_1.actors_["1011ui_story"].transform

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1.var_.moveOldPos1011ui_story = var_83_8.localPosition
			end

			local var_83_9 = 0.001

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_9 then
				var_83_8.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_80_1.time_ - 0) / var_83_9)
				var_83_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_83_8.position).x, (manager.ui.mainCamera.transform.position - var_83_8.position).y, (manager.ui.mainCamera.transform.position - var_83_8.position).z)
				var_83_8.localEulerAngles.z = 0
				var_83_8.localEulerAngles.x = 0
				var_83_8.localEulerAngles = var_83_8.localEulerAngles
			end

			if arg_80_1.time_ >= 0 + var_83_9 and arg_80_1.time_ < 0 + var_83_9 + arg_83_0 then
				var_83_8.localPosition = Vector3.New(0, -0.71, -6)
				var_83_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_83_8.position).x, (manager.ui.mainCamera.transform.position - var_83_8.position).y, (manager.ui.mainCamera.transform.position - var_83_8.position).z)
				var_83_8.localEulerAngles.z = 0
				var_83_8.localEulerAngles.x = 0
				var_83_8.localEulerAngles = var_83_8.localEulerAngles
			end

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_83_10 = 0
			local var_83_11 = 0.325

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= var_83_10 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				arg_80_1.leftNameTxt_.text = arg_80_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_12 = arg_80_1:GetWordFromCfg(101131020)
				local var_83_13 = arg_80_1:FormatText(var_83_12.content)

				arg_80_1.text_.text = var_83_13

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_15 = 13 <= 0 and var_83_11 or var_83_11 * (utf8.len(var_83_13) / 13)

				if (13 <= 0 and var_83_11 or var_83_11 * (utf8.len(var_83_13) / 13)) > 0 and var_83_11 < var_83_15 then
					arg_80_1.talkMaxDuration = var_83_15

					if var_83_15 + var_83_10 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_15 + var_83_10
					end
				end

				arg_80_1.text_.text = var_83_13
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101131", "101131020", "story_v_out_101131.awb") ~= 0 then
					local var_83_16 = manager.audio:GetVoiceLength("story_v_out_101131", "101131020", "story_v_out_101131.awb") / 1000

					if var_83_16 + var_83_10 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_16 + var_83_10
					end

					if var_83_12.prefab_name ~= "" and arg_80_1.actors_[var_83_12.prefab_name] ~= nil then
						local var_83_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_12.prefab_name].transform, "story_v_out_101131", "101131020", "story_v_out_101131.awb")

						arg_80_1:RecordAudio("101131020", var_83_17)
						arg_80_1:RecordAudio("101131020", var_83_17)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_out_101131", "101131020", "story_v_out_101131.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_out_101131", "101131020", "story_v_out_101131.awb")
				end

				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_18 = math.max(var_83_11, arg_80_1.talkMaxDuration)

			if var_83_10 <= arg_80_1.time_ and arg_80_1.time_ < var_83_10 + var_83_18 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_10) / var_83_18

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_10 + var_83_18 and arg_80_1.time_ < var_83_10 + var_83_18 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3010_tpose",
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

		arg_80_1:InitPlayNodeList()
	end,
	Play101131021 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 101131021
		arg_84_1.duration_ = 7.67

		local var_84_0 = {
			ja = 7.566,
			ko = 4.4,
			zh = 7.666,
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
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play101131022(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 and not isNil(arg_84_1.actors_["3010_tpose"]) and arg_84_1.var_.characterEffect3010_tpose == nil then
				arg_84_1.var_.characterEffect3010_tpose = arg_84_1.actors_["3010_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_0 = 0.1

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_0 and not isNil(arg_84_1.actors_["3010_tpose"]) then
				if arg_84_1.var_.characterEffect3010_tpose and not isNil(arg_84_1.actors_["3010_tpose"]) then
					arg_84_1.var_.characterEffect3010_tpose.fillFlat = false
				end
			end

			if arg_84_1.time_ >= 0 + var_87_0 and arg_84_1.time_ < 0 + var_87_0 + arg_87_0 and not isNil(arg_84_1.actors_["3010_tpose"]) and arg_84_1.var_.characterEffect3010_tpose then
				arg_84_1.var_.characterEffect3010_tpose.fillFlat = false
			end

			local var_87_2 = arg_84_1.actors_["1011ui_story"]

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 and not isNil(var_87_2) and arg_84_1.var_.characterEffect1011ui_story == nil then
				arg_84_1.var_.characterEffect1011ui_story = var_87_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_3 = 0.1

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_3 and not isNil(var_87_2) then
				if arg_84_1.var_.characterEffect1011ui_story and not isNil(var_87_2) then
					arg_84_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_84_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_84_1.time_ - 0) / var_87_3)
				end
			end

			if arg_84_1.time_ >= 0 + var_87_3 and arg_84_1.time_ < 0 + var_87_3 + arg_87_0 and not isNil(var_87_2) and arg_84_1.var_.characterEffect1011ui_story then
				arg_84_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_84_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_87_4 = arg_84_1.actors_["1011ui_story"].transform

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1.var_.moveOldPos1011ui_story = var_87_4.localPosition
			end

			local var_87_5 = 0.001

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_5 then
				var_87_4.localPosition = Vector3.Lerp(arg_84_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_84_1.time_ - 0) / var_87_5)
				var_87_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_87_4.position).x, (manager.ui.mainCamera.transform.position - var_87_4.position).y, (manager.ui.mainCamera.transform.position - var_87_4.position).z)
				var_87_4.localEulerAngles.z = 0
				var_87_4.localEulerAngles.x = 0
				var_87_4.localEulerAngles = var_87_4.localEulerAngles
			end

			if arg_84_1.time_ >= 0 + var_87_5 and arg_84_1.time_ < 0 + var_87_5 + arg_87_0 then
				var_87_4.localPosition = Vector3.New(0, 100, 0)
				var_87_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_87_4.position).x, (manager.ui.mainCamera.transform.position - var_87_4.position).y, (manager.ui.mainCamera.transform.position - var_87_4.position).z)
				var_87_4.localEulerAngles.z = 0
				var_87_4.localEulerAngles.x = 0
				var_87_4.localEulerAngles = var_87_4.localEulerAngles
			end

			local var_87_6 = arg_84_1.actors_["1084ui_story"].transform

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1.var_.moveOldPos1084ui_story = var_87_6.localPosition
			end

			local var_87_7 = 0.001

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_7 then
				var_87_6.localPosition = Vector3.Lerp(arg_84_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_84_1.time_ - 0) / var_87_7)
				var_87_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_87_6.position).x, (manager.ui.mainCamera.transform.position - var_87_6.position).y, (manager.ui.mainCamera.transform.position - var_87_6.position).z)
				var_87_6.localEulerAngles.z = 0
				var_87_6.localEulerAngles.x = 0
				var_87_6.localEulerAngles = var_87_6.localEulerAngles
			end

			if arg_84_1.time_ >= 0 + var_87_7 and arg_84_1.time_ < 0 + var_87_7 + arg_87_0 then
				var_87_6.localPosition = Vector3.New(0, 100, 0)
				var_87_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_87_6.position).x, (manager.ui.mainCamera.transform.position - var_87_6.position).y, (manager.ui.mainCamera.transform.position - var_87_6.position).z)
				var_87_6.localEulerAngles.z = 0
				var_87_6.localEulerAngles.x = 0
				var_87_6.localEulerAngles = var_87_6.localEulerAngles
			end

			local var_87_8 = arg_84_1.actors_["3010_tpose"].transform

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1.var_.moveOldPos3010_tpose = var_87_8.localPosition

				local var_87_9 = GameObjectTools.GetOrAddComponent(var_87_8.gameObject, typeof(DynamicBoneHelper))

				if var_87_9 then
					var_87_9:EnableDynamicBone(false)
				end
			end

			local var_87_10 = 0.001

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_10 then
				var_87_8.localPosition = Vector3.Lerp(arg_84_1.var_.moveOldPos3010_tpose, Vector3.New(0, -1.59, -1.6), (arg_84_1.time_ - 0) / var_87_10)
				var_87_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_87_8.position).x, (manager.ui.mainCamera.transform.position - var_87_8.position).y, (manager.ui.mainCamera.transform.position - var_87_8.position).z)
				var_87_8.localEulerAngles.z = 0
				var_87_8.localEulerAngles.x = 0
				var_87_8.localEulerAngles = var_87_8.localEulerAngles
			end

			if arg_84_1.time_ >= 0 + var_87_10 and arg_84_1.time_ < 0 + var_87_10 + arg_87_0 then
				var_87_8.localPosition = Vector3.New(0, -1.59, -1.6)
				var_87_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_87_8.position).x, (manager.ui.mainCamera.transform.position - var_87_8.position).y, (manager.ui.mainCamera.transform.position - var_87_8.position).z)
				var_87_8.localEulerAngles.z = 0
				var_87_8.localEulerAngles.x = 0
				var_87_8.localEulerAngles = var_87_8.localEulerAngles

				local var_87_11 = GameObjectTools.GetOrAddComponent(var_87_8.gameObject, typeof(DynamicBoneHelper))

				if var_87_11 then
					var_87_11:EnableDynamicBone(true)
				end
			end

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1:PlayTimeline("3010_tpose", "StoryTimeline/CharAction/story3010/story3010action/3010action1_1")
			end

			local var_87_12 = 0
			local var_87_13 = 0.85

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= var_87_12 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				arg_84_1.leftNameTxt_.text = arg_84_1:FormatText(StoryNameCfg[40].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_14 = arg_84_1:GetWordFromCfg(101131021)
				local var_87_15 = arg_84_1:FormatText(var_87_14.content)

				arg_84_1.text_.text = var_87_15

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_17 = 32 <= 0 and var_87_13 or var_87_13 * (utf8.len(var_87_15) / 32)

				if (32 <= 0 and var_87_13 or var_87_13 * (utf8.len(var_87_15) / 32)) > 0 and var_87_13 < var_87_17 then
					arg_84_1.talkMaxDuration = var_87_17

					if var_87_17 + var_87_12 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_17 + var_87_12
					end
				end

				arg_84_1.text_.text = var_87_15
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101131", "101131021", "story_v_out_101131.awb") ~= 0 then
					local var_87_18 = manager.audio:GetVoiceLength("story_v_out_101131", "101131021", "story_v_out_101131.awb") / 1000

					if var_87_18 + var_87_12 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_18 + var_87_12
					end

					if var_87_14.prefab_name ~= "" and arg_84_1.actors_[var_87_14.prefab_name] ~= nil then
						local var_87_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_14.prefab_name].transform, "story_v_out_101131", "101131021", "story_v_out_101131.awb")

						arg_84_1:RecordAudio("101131021", var_87_19)
						arg_84_1:RecordAudio("101131021", var_87_19)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_out_101131", "101131021", "story_v_out_101131.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_out_101131", "101131021", "story_v_out_101131.awb")
				end

				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_20 = math.max(var_87_13, arg_84_1.talkMaxDuration)

			if var_87_12 <= arg_84_1.time_ and arg_84_1.time_ < var_87_12 + var_87_20 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_12) / var_87_20

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_12 + var_87_20 and arg_84_1.time_ < var_87_12 + var_87_20 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {
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
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "3010_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_84_1:InitPlayNodeList()
	end,
	Play101131022 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 101131022
		arg_88_1.duration_ = 3.77

		local var_88_0 = {
			ja = 3.766,
			ko = 2.933,
			zh = 2.833,
			en = 2.933
		}
		local var_88_1 = manager.audio:GetLocalizationFlag()

		if var_88_0[var_88_1] ~= nil then
			arg_88_1.duration_ = var_88_0[var_88_1]
		end

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play101131023(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 and not isNil(arg_88_1.actors_["3010_tpose"]) and arg_88_1.var_.characterEffect3010_tpose == nil then
				arg_88_1.var_.characterEffect3010_tpose = arg_88_1.actors_["3010_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_0 = 0.1

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_0 and not isNil(arg_88_1.actors_["3010_tpose"]) then
				if arg_88_1.var_.characterEffect3010_tpose and not isNil(arg_88_1.actors_["3010_tpose"]) then
					arg_88_1.var_.characterEffect3010_tpose.fillFlat = true
					arg_88_1.var_.characterEffect3010_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_88_1.time_ - 0) / var_91_0)
				end
			end

			if arg_88_1.time_ >= 0 + var_91_0 and arg_88_1.time_ < 0 + var_91_0 + arg_91_0 and not isNil(arg_88_1.actors_["3010_tpose"]) and arg_88_1.var_.characterEffect3010_tpose then
				arg_88_1.var_.characterEffect3010_tpose.fillFlat = true
				arg_88_1.var_.characterEffect3010_tpose.fillRatio = 0.5
			end

			local var_91_1 = 0
			local var_91_2 = 0.35

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= var_91_1 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				arg_88_1.leftNameTxt_.text = arg_88_1:FormatText(StoryNameCfg[19].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, true)
				arg_88_1.iconController_:SetSelectedState("hero")

				arg_88_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_20301")

				arg_88_1.callingController_:SetSelectedState("normal")

				arg_88_1.keyicon_.color = Color.New(1, 1, 1)
				arg_88_1.icon_.color = Color.New(1, 1, 1)

				local var_91_3 = arg_88_1:GetWordFromCfg(101131022)
				local var_91_4 = arg_88_1:FormatText(var_91_3.content)

				arg_88_1.text_.text = var_91_4

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_6 = 12 <= 0 and var_91_2 or var_91_2 * (utf8.len(var_91_4) / 12)

				if (12 <= 0 and var_91_2 or var_91_2 * (utf8.len(var_91_4) / 12)) > 0 and var_91_2 < var_91_6 then
					arg_88_1.talkMaxDuration = var_91_6

					if var_91_6 + var_91_1 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_6 + var_91_1
					end
				end

				arg_88_1.text_.text = var_91_4
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101131", "101131022", "story_v_out_101131.awb") ~= 0 then
					local var_91_7 = manager.audio:GetVoiceLength("story_v_out_101131", "101131022", "story_v_out_101131.awb") / 1000

					if var_91_7 + var_91_1 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_7 + var_91_1
					end

					if var_91_3.prefab_name ~= "" and arg_88_1.actors_[var_91_3.prefab_name] ~= nil then
						local var_91_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_88_1.actors_[var_91_3.prefab_name].transform, "story_v_out_101131", "101131022", "story_v_out_101131.awb")

						arg_88_1:RecordAudio("101131022", var_91_8)
						arg_88_1:RecordAudio("101131022", var_91_8)
					else
						arg_88_1:AudioAction("play", "voice", "story_v_out_101131", "101131022", "story_v_out_101131.awb")
					end

					arg_88_1:RecordHistoryTalkVoice("story_v_out_101131", "101131022", "story_v_out_101131.awb")
				end

				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_9 = math.max(var_91_2, arg_88_1.talkMaxDuration)

			if var_91_1 <= arg_88_1.time_ and arg_88_1.time_ < var_91_1 + var_91_9 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_1) / var_91_9

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_1 + var_91_9 and arg_88_1.time_ < var_91_1 + var_91_9 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {}

		arg_88_1:InitPlayNodeList()
	end,
	Play101131023 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 101131023
		arg_92_1.duration_ = 4.37

		local var_92_0 = {
			ja = 4.366,
			ko = 3.233,
			zh = 3.066,
			en = 2.8
		}
		local var_92_1 = manager.audio:GetLocalizationFlag()

		if var_92_0[var_92_1] ~= nil then
			arg_92_1.duration_ = var_92_0[var_92_1]
		end

		SetActive(arg_92_1.tipsGo_, false)

		function arg_92_1.onSingleLineFinish_()
			arg_92_1.onSingleLineUpdate_ = nil
			arg_92_1.onSingleLineFinish_ = nil
			arg_92_1.state_ = "waiting"
		end

		function arg_92_1.playNext_(arg_94_0)
			if arg_94_0 == 1 then
				arg_92_0:Play101131024(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			local var_95_0 = 0.425

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				arg_92_1.leftNameTxt_.text = arg_92_1:FormatText(StoryNameCfg[33].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, true)
				arg_92_1.iconController_:SetSelectedState("hero")

				arg_92_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_20302")

				arg_92_1.callingController_:SetSelectedState("normal")

				arg_92_1.keyicon_.color = Color.New(1, 1, 1)
				arg_92_1.icon_.color = Color.New(1, 1, 1)

				local var_95_1 = arg_92_1:GetWordFromCfg(101131023)
				local var_95_2 = arg_92_1:FormatText(var_95_1.content)

				arg_92_1.text_.text = var_95_2

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_4 = 17 <= 0 and var_95_0 or var_95_0 * (utf8.len(var_95_2) / 17)

				if (17 <= 0 and var_95_0 or var_95_0 * (utf8.len(var_95_2) / 17)) > 0 and var_95_0 < var_95_4 then
					arg_92_1.talkMaxDuration = var_95_4

					if var_95_4 + 0 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_4 + 0
					end
				end

				arg_92_1.text_.text = var_95_2
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101131", "101131023", "story_v_out_101131.awb") ~= 0 then
					local var_95_5 = manager.audio:GetVoiceLength("story_v_out_101131", "101131023", "story_v_out_101131.awb") / 1000

					if var_95_5 + 0 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_5 + 0
					end

					if var_95_1.prefab_name ~= "" and arg_92_1.actors_[var_95_1.prefab_name] ~= nil then
						local var_95_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_1.prefab_name].transform, "story_v_out_101131", "101131023", "story_v_out_101131.awb")

						arg_92_1:RecordAudio("101131023", var_95_6)
						arg_92_1:RecordAudio("101131023", var_95_6)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_out_101131", "101131023", "story_v_out_101131.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_out_101131", "101131023", "story_v_out_101131.awb")
				end

				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_7 = math.max(var_95_0, arg_92_1.talkMaxDuration)

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_7 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - 0) / var_95_7

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= 0 + var_95_7 and arg_92_1.time_ < 0 + var_95_7 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {}

		arg_92_1:InitPlayNodeList()
	end,
	Play101131024 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 101131024
		arg_96_1.duration_ = 4.23

		local var_96_0 = {
			ja = 3.6,
			ko = 3.1,
			zh = 2.8,
			en = 4.233
		}
		local var_96_1 = manager.audio:GetLocalizationFlag()

		if var_96_0[var_96_1] ~= nil then
			arg_96_1.duration_ = var_96_0[var_96_1]
		end

		SetActive(arg_96_1.tipsGo_, false)

		function arg_96_1.onSingleLineFinish_()
			arg_96_1.onSingleLineUpdate_ = nil
			arg_96_1.onSingleLineFinish_ = nil
			arg_96_1.state_ = "waiting"
			arg_96_1.auto_ = false
		end

		function arg_96_1.playNext_(arg_98_0)
			arg_96_1.onStoryFinished_()
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1:AudioAction("play", "effect", "ui_battle", "ui_battle_stopbgm", "")
			end

			local var_99_1 = arg_96_1.actors_["1084ui_story"]

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 and not isNil(var_99_1) and arg_96_1.var_.characterEffect1084ui_story == nil then
				arg_96_1.var_.characterEffect1084ui_story = var_99_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_2 = 0.1

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_2 and not isNil(var_99_1) then
				if arg_96_1.var_.characterEffect1084ui_story and not isNil(var_99_1) then
					arg_96_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_96_1.time_ >= 0 + var_99_2 and arg_96_1.time_ < 0 + var_99_2 + arg_99_0 and not isNil(var_99_1) and arg_96_1.var_.characterEffect1084ui_story then
				arg_96_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_99_4 = arg_96_1.actors_["3010_tpose"].transform

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1.var_.moveOldPos3010_tpose = var_99_4.localPosition

				local var_99_5 = GameObjectTools.GetOrAddComponent(var_99_4.gameObject, typeof(DynamicBoneHelper))

				if var_99_5 then
					var_99_5:EnableDynamicBone(false)
				end
			end

			local var_99_6 = 0.001

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_6 then
				var_99_4.localPosition = Vector3.Lerp(arg_96_1.var_.moveOldPos3010_tpose, Vector3.New(0, 100, 0), (arg_96_1.time_ - 0) / var_99_6)
				var_99_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_99_4.position).x, (manager.ui.mainCamera.transform.position - var_99_4.position).y, (manager.ui.mainCamera.transform.position - var_99_4.position).z)
				var_99_4.localEulerAngles.z = 0
				var_99_4.localEulerAngles.x = 0
				var_99_4.localEulerAngles = var_99_4.localEulerAngles
			end

			if arg_96_1.time_ >= 0 + var_99_6 and arg_96_1.time_ < 0 + var_99_6 + arg_99_0 then
				var_99_4.localPosition = Vector3.New(0, 100, 0)
				var_99_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_99_4.position).x, (manager.ui.mainCamera.transform.position - var_99_4.position).y, (manager.ui.mainCamera.transform.position - var_99_4.position).z)
				var_99_4.localEulerAngles.z = 0
				var_99_4.localEulerAngles.x = 0
				var_99_4.localEulerAngles = var_99_4.localEulerAngles

				local var_99_7 = GameObjectTools.GetOrAddComponent(var_99_4.gameObject, typeof(DynamicBoneHelper))

				if var_99_7 then
					var_99_7:EnableDynamicBone(true)
				end
			end

			local var_99_8 = arg_96_1.actors_["1084ui_story"].transform

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1.var_.moveOldPos1084ui_story = var_99_8.localPosition
			end

			local var_99_9 = 0.001

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_9 then
				var_99_8.localPosition = Vector3.Lerp(arg_96_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_96_1.time_ - 0) / var_99_9)
				var_99_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_99_8.position).x, (manager.ui.mainCamera.transform.position - var_99_8.position).y, (manager.ui.mainCamera.transform.position - var_99_8.position).z)
				var_99_8.localEulerAngles.z = 0
				var_99_8.localEulerAngles.x = 0
				var_99_8.localEulerAngles = var_99_8.localEulerAngles
			end

			if arg_96_1.time_ >= 0 + var_99_9 and arg_96_1.time_ < 0 + var_99_9 + arg_99_0 then
				var_99_8.localPosition = Vector3.New(0, -0.97, -6)
				var_99_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_99_8.position).x, (manager.ui.mainCamera.transform.position - var_99_8.position).y, (manager.ui.mainCamera.transform.position - var_99_8.position).z)
				var_99_8.localEulerAngles.z = 0
				var_99_8.localEulerAngles.x = 0
				var_99_8.localEulerAngles = var_99_8.localEulerAngles
			end

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action6_1")
			end

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_99_10 = 0
			local var_99_11 = 0.3

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= var_99_10 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				arg_96_1.leftNameTxt_.text = arg_96_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_12 = arg_96_1:GetWordFromCfg(101131024)
				local var_99_13 = arg_96_1:FormatText(var_99_12.content)

				arg_96_1.text_.text = var_99_13

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_15 = 12 <= 0 and var_99_11 or var_99_11 * (utf8.len(var_99_13) / 12)

				if (12 <= 0 and var_99_11 or var_99_11 * (utf8.len(var_99_13) / 12)) > 0 and var_99_11 < var_99_15 then
					arg_96_1.talkMaxDuration = var_99_15

					if var_99_15 + var_99_10 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_15 + var_99_10
					end
				end

				arg_96_1.text_.text = var_99_13
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101131", "101131024", "story_v_out_101131.awb") ~= 0 then
					local var_99_16 = manager.audio:GetVoiceLength("story_v_out_101131", "101131024", "story_v_out_101131.awb") / 1000

					if var_99_16 + var_99_10 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_16 + var_99_10
					end

					if var_99_12.prefab_name ~= "" and arg_96_1.actors_[var_99_12.prefab_name] ~= nil then
						local var_99_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_96_1.actors_[var_99_12.prefab_name].transform, "story_v_out_101131", "101131024", "story_v_out_101131.awb")

						arg_96_1:RecordAudio("101131024", var_99_17)
						arg_96_1:RecordAudio("101131024", var_99_17)
					else
						arg_96_1:AudioAction("play", "voice", "story_v_out_101131", "101131024", "story_v_out_101131.awb")
					end

					arg_96_1:RecordHistoryTalkVoice("story_v_out_101131", "101131024", "story_v_out_101131.awb")
				end

				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_18 = math.max(var_99_11, arg_96_1.talkMaxDuration)

			if var_99_10 <= arg_96_1.time_ and arg_96_1.time_ < var_99_10 + var_99_18 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_10) / var_99_18

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_10 + var_99_18 and arg_96_1.time_ < var_99_10 + var_99_18 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3010_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_96_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/B02f"
	},
	voices = {
		"story_v_out_101131.awb"
	}
}
