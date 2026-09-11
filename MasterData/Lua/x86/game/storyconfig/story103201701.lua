return {
	Play320171001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 320171001
		arg_1_1.duration_ = 7.17

		local var_1_0 = {
			zh = 7.16600000298023,
			ja = 5.70000000298023
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
				arg_1_0:Play320171002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.L01f == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "L01f")
				var_4_0.name = "L01f"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.L01f = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.L01f

				arg_1_1.bgs_.L01f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "L01f" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 1.999999999999

			if 1.999999999999 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_4 + 0.3 and arg_1_1.time_ < var_4_4 + 0.3 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_5 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_5 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_6 = 2

			if var_4_5 <= arg_1_1.time_ and arg_1_1.time_ < var_4_5 + var_4_6 then
				local var_4_7 = Color.New(0, 0, 0)

				var_4_7.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - var_4_5) / var_4_6)
				arg_1_1.mask_.color = var_4_7
			end

			if arg_1_1.time_ >= var_4_5 + var_4_6 and arg_1_1.time_ < var_4_5 + var_4_6 + arg_4_0 then
				local var_4_8 = Color.New(0, 0, 0)

				arg_1_1.mask_.enabled = false
				var_4_8.a = 0
				arg_1_1.mask_.color = var_4_8
			end

			local var_4_9 = "1089ui_story"

			if arg_1_1.actors_["1089ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1089ui_story"))) then
				local var_4_10 = Object.Instantiate(Asset.Load("Char/" .. "1089ui_story"), arg_1_1.stage_.transform)

				var_4_10.name = var_4_9
				var_4_10.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.actors_[var_4_9] = var_4_10

				local var_4_11 = var_4_10:GetComponentInChildren(typeof(CharacterEffect))

				var_4_11.enabled = true

				local var_4_12 = GameObjectTools.GetOrAddComponent(var_4_10, typeof(DynamicBoneHelper))

				if var_4_12 then
					var_4_12:EnableDynamicBone(false)
				end

				arg_1_1:ShowWeapon(var_4_11.transform, false)

				arg_1_1.var_[var_4_9 .. "Animator"] = var_4_11.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_1_1.var_[var_4_9 .. "Animator"].applyRootMotion = true
				arg_1_1.var_[var_4_9 .. "LipSync"] = var_4_11.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_4_13 = arg_1_1.actors_["1089ui_story"].transform

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1.var_.moveOldPos1089ui_story = var_4_13.localPosition

				arg_1_1:ShowWeapon(arg_1_1.var_["1089ui_story" .. "Animator"].transform, false)
			end

			local var_4_14 = 0.001

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_14 then
				var_4_13.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1089ui_story, Vector3.New(0, -1.1, -6.17), (arg_1_1.time_ - 1.8) / var_4_14)
				var_4_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_13.position).x, (manager.ui.mainCamera.transform.position - var_4_13.position).y, (manager.ui.mainCamera.transform.position - var_4_13.position).z)
				var_4_13.localEulerAngles.z = 0
				var_4_13.localEulerAngles.x = 0
				var_4_13.localEulerAngles = var_4_13.localEulerAngles
			end

			if arg_1_1.time_ >= 1.8 + var_4_14 and arg_1_1.time_ < 1.8 + var_4_14 + arg_4_0 then
				var_4_13.localPosition = Vector3.New(0, -1.1, -6.17)
				var_4_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_13.position).x, (manager.ui.mainCamera.transform.position - var_4_13.position).y, (manager.ui.mainCamera.transform.position - var_4_13.position).z)
				var_4_13.localEulerAngles.z = 0
				var_4_13.localEulerAngles.x = 0
				var_4_13.localEulerAngles = var_4_13.localEulerAngles
			end

			local var_4_15 = arg_1_1.actors_["1089ui_story"]

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 and not isNil(var_4_15) and arg_1_1.var_.characterEffect1089ui_story == nil then
				arg_1_1.var_.characterEffect1089ui_story = var_4_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_16 = 0.200000002980232

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_16 and not isNil(var_4_15) then
				if arg_1_1.var_.characterEffect1089ui_story and not isNil(var_4_15) then
					arg_1_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 1.8 + var_4_16 and arg_1_1.time_ < 1.8 + var_4_16 + arg_4_0 and not isNil(var_4_15) and arg_1_1.var_.characterEffect1089ui_story then
				arg_1_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action3_1")
			end

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_20 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_20 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_20

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_20
						arg_1_1.bgmTxt2_.text = var_4_20
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

			if 0.333333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 0.333333333333333 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_2_8_story_jivitabad_slum", "bgm_activity_2_8_story_jivitabad_slum", "bgm_activity_2_8_story_jivitabad_slum.awb")

				local var_4_23 = manager.audio:GetAudioName("bgm_activity_2_8_story_jivitabad_slum", "bgm_activity_2_8_story_jivitabad_slum")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_23 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_23

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_23
						arg_1_1.bgmTxt2_.text = var_4_23
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

			local var_4_24 = 0

			arg_1_1.isInRecall_ = false

			if var_4_24 < arg_1_1.time_ and arg_1_1.time_ <= var_4_24 + arg_4_0 then
				arg_1_1.screenFilterGo_:SetActive(true)

				arg_1_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile")

				for iter_4_2, iter_4_3 in pairs(arg_1_1.actors_) do
					for iter_4_4, iter_4_5 in ipairs((iter_4_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_4_5.color = iter_4_5.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_4_25 = 0.2

			if var_4_24 <= arg_1_1.time_ and arg_1_1.time_ < var_4_24 + var_4_25 then
				arg_1_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, (arg_1_1.time_ - var_4_24) / var_4_25)
			end

			if arg_1_1.time_ >= var_4_24 + var_4_25 and arg_1_1.time_ < var_4_24 + var_4_25 + arg_4_0 then
				arg_1_1.screenFilterEffect_.weight = 1
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_26 = 2.00000000298023
			local var_4_27 = 0.55

			if 2.00000000298023 < arg_1_1.time_ and arg_1_1.time_ <= var_4_26 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_28 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_28:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_28:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_28:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_29 = arg_1_1:GetWordFromCfg(320171001)
				local var_4_30 = arg_1_1:FormatText(var_4_29.content)

				arg_1_1.text_.text = var_4_30

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_32 = 22 <= 0 and var_4_27 or var_4_27 * (utf8.len(var_4_30) / 22)

				if (22 <= 0 and var_4_27 or var_4_27 * (utf8.len(var_4_30) / 22)) > 0 and var_4_27 < var_4_32 then
					arg_1_1.talkMaxDuration = var_4_32
					var_4_26 = var_4_26 + 0.3

					if var_4_32 + var_4_26 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_32 + var_4_26
					end
				end

				arg_1_1.text_.text = var_4_30
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320171", "320171001", "story_v_out_320171.awb") ~= 0 then
					local var_4_33 = manager.audio:GetVoiceLength("story_v_out_320171", "320171001", "story_v_out_320171.awb") / 1000

					if var_4_33 + var_4_26 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_33 + var_4_26
					end

					if var_4_29.prefab_name ~= "" and arg_1_1.actors_[var_4_29.prefab_name] ~= nil then
						local var_4_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_29.prefab_name].transform, "story_v_out_320171", "320171001", "story_v_out_320171.awb")

						arg_1_1:RecordAudio("320171001", var_4_34)
						arg_1_1:RecordAudio("320171001", var_4_34)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_320171", "320171001", "story_v_out_320171.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_320171", "320171001", "story_v_out_320171.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_35 = var_4_26 + 0.3
			local var_4_36 = math.max(var_4_27, arg_1_1.talkMaxDuration)

			if var_4_26 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_35 + var_4_36 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_35) / var_4_36

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_35 + var_4_36 and arg_1_1.time_ < var_4_35 + var_4_36 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play320171002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 320171002
		arg_9_1.duration_ = 4.77

		local var_9_0 = {
			zh = 3.5,
			ja = 4.766
		}
		local var_9_1 = manager.audio:GetLocalizationFlag()

		if var_9_0[var_9_1] ~= nil then
			arg_9_1.duration_ = var_9_0[var_9_1]
		end

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play320171003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos1089ui_story = arg_9_1.actors_["1089ui_story"].transform.localPosition
			end

			local var_12_0 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_0 then
				arg_9_1.actors_["1089ui_story"].transform.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1089ui_story, Vector3.New(-0.7, -1.1, -6.17), (arg_9_1.time_ - 0) / var_12_0)
				arg_9_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_9_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_9_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_9_1.actors_["1089ui_story"].transform.position).z)
				arg_9_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_9_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_9_1.actors_["1089ui_story"].transform.localEulerAngles = arg_9_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			if arg_9_1.time_ >= 0 + var_12_0 and arg_9_1.time_ < 0 + var_12_0 + arg_12_0 then
				arg_9_1.actors_["1089ui_story"].transform.localPosition = Vector3.New(-0.7, -1.1, -6.17)
				arg_9_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_9_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_9_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_9_1.actors_["1089ui_story"].transform.position).z)
				arg_9_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_9_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_9_1.actors_["1089ui_story"].transform.localEulerAngles = arg_9_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			local var_12_1 = arg_9_1.actors_["1089ui_story"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_1) and arg_9_1.var_.characterEffect1089ui_story == nil then
				arg_9_1.var_.characterEffect1089ui_story = var_12_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_2 = 0.200000002980232

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_2 and not isNil(var_12_1) then
				if arg_9_1.var_.characterEffect1089ui_story and not isNil(var_12_1) then
					arg_9_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_9_1.var_.characterEffect1089ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_9_1.time_ - 0) / var_12_2)
				end
			end

			if arg_9_1.time_ >= 0 + var_12_2 and arg_9_1.time_ < 0 + var_12_2 + arg_12_0 and not isNil(var_12_1) and arg_9_1.var_.characterEffect1089ui_story then
				arg_9_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_9_1.var_.characterEffect1089ui_story.fillRatio = 0.5
			end

			local var_12_3 = "1056ui_story"

			if arg_9_1.actors_["1056ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1056ui_story"))) then
				local var_12_4 = Object.Instantiate(Asset.Load("Char/" .. "1056ui_story"), arg_9_1.stage_.transform)

				var_12_4.name = var_12_3
				var_12_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_9_1.actors_[var_12_3] = var_12_4

				local var_12_5 = var_12_4:GetComponentInChildren(typeof(CharacterEffect))

				var_12_5.enabled = true

				local var_12_6 = GameObjectTools.GetOrAddComponent(var_12_4, typeof(DynamicBoneHelper))

				if var_12_6 then
					var_12_6:EnableDynamicBone(false)
				end

				arg_9_1:ShowWeapon(var_12_5.transform, false)

				arg_9_1.var_[var_12_3 .. "Animator"] = var_12_5.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_9_1.var_[var_12_3 .. "Animator"].applyRootMotion = true
				arg_9_1.var_[var_12_3 .. "LipSync"] = var_12_5.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_12_7 = arg_9_1.actors_["1056ui_story"].transform

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos1056ui_story = var_12_7.localPosition
			end

			local var_12_8 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_8 then
				var_12_7.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1056ui_story, Vector3.New(0.7, -1, -5.75), (arg_9_1.time_ - 0) / var_12_8)
				var_12_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_7.position).x, (manager.ui.mainCamera.transform.position - var_12_7.position).y, (manager.ui.mainCamera.transform.position - var_12_7.position).z)
				var_12_7.localEulerAngles.z = 0
				var_12_7.localEulerAngles.x = 0
				var_12_7.localEulerAngles = var_12_7.localEulerAngles
			end

			if arg_9_1.time_ >= 0 + var_12_8 and arg_9_1.time_ < 0 + var_12_8 + arg_12_0 then
				var_12_7.localPosition = Vector3.New(0.7, -1, -5.75)
				var_12_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_7.position).x, (manager.ui.mainCamera.transform.position - var_12_7.position).y, (manager.ui.mainCamera.transform.position - var_12_7.position).z)
				var_12_7.localEulerAngles.z = 0
				var_12_7.localEulerAngles.x = 0
				var_12_7.localEulerAngles = var_12_7.localEulerAngles
			end

			local var_12_9 = arg_9_1.actors_["1056ui_story"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_9) and arg_9_1.var_.characterEffect1056ui_story == nil then
				arg_9_1.var_.characterEffect1056ui_story = var_12_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_10 = 0.200000002980232

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_10 and not isNil(var_12_9) then
				if arg_9_1.var_.characterEffect1056ui_story and not isNil(var_12_9) then
					arg_9_1.var_.characterEffect1056ui_story.fillFlat = false
				end
			end

			if arg_9_1.time_ >= 0 + var_12_10 and arg_9_1.time_ < 0 + var_12_10 + arg_12_0 and not isNil(var_12_9) and arg_9_1.var_.characterEffect1056ui_story then
				arg_9_1.var_.characterEffect1056ui_story.fillFlat = false
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/story1056/story1056action/1056action1_1")
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_12_12 = 0
			local var_12_13 = 0.35

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_12 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_14 = arg_9_1:GetWordFromCfg(320171002)
				local var_12_15 = arg_9_1:FormatText(var_12_14.content)

				arg_9_1.text_.text = var_12_15

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_17 = 14 <= 0 and var_12_13 or var_12_13 * (utf8.len(var_12_15) / 14)

				if (14 <= 0 and var_12_13 or var_12_13 * (utf8.len(var_12_15) / 14)) > 0 and var_12_13 < var_12_17 then
					arg_9_1.talkMaxDuration = var_12_17

					if var_12_17 + var_12_12 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_17 + var_12_12
					end
				end

				arg_9_1.text_.text = var_12_15
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320171", "320171002", "story_v_out_320171.awb") ~= 0 then
					local var_12_18 = manager.audio:GetVoiceLength("story_v_out_320171", "320171002", "story_v_out_320171.awb") / 1000

					if var_12_18 + var_12_12 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_18 + var_12_12
					end

					if var_12_14.prefab_name ~= "" and arg_9_1.actors_[var_12_14.prefab_name] ~= nil then
						local var_12_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_14.prefab_name].transform, "story_v_out_320171", "320171002", "story_v_out_320171.awb")

						arg_9_1:RecordAudio("320171002", var_12_19)
						arg_9_1:RecordAudio("320171002", var_12_19)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_320171", "320171002", "story_v_out_320171.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_320171", "320171002", "story_v_out_320171.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_20 = math.max(var_12_13, arg_9_1.talkMaxDuration)

			if var_12_12 <= arg_9_1.time_ and arg_9_1.time_ < var_12_12 + var_12_20 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_12) / var_12_20

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_12 + var_12_20 and arg_9_1.time_ < var_12_12 + var_12_20 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1056ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_9_1:InitPlayNodeList()
	end,
	Play320171003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 320171003
		arg_13_1.duration_ = 9.4

		local var_13_0 = {
			zh = 9.4,
			ja = 9.066
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
				arg_13_0:Play320171004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPos1089ui_story = arg_13_1.actors_["1089ui_story"].transform.localPosition
			end

			local var_16_0 = 0.001

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_0 then
				arg_13_1.actors_["1089ui_story"].transform.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1089ui_story, Vector3.New(-0.7, -1.1, -6.17), (arg_13_1.time_ - 0) / var_16_0)
				arg_13_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_13_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_13_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_13_1.actors_["1089ui_story"].transform.position).z)
				arg_13_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_13_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_13_1.actors_["1089ui_story"].transform.localEulerAngles = arg_13_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			if arg_13_1.time_ >= 0 + var_16_0 and arg_13_1.time_ < 0 + var_16_0 + arg_16_0 then
				arg_13_1.actors_["1089ui_story"].transform.localPosition = Vector3.New(-0.7, -1.1, -6.17)
				arg_13_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_13_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_13_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_13_1.actors_["1089ui_story"].transform.position).z)
				arg_13_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_13_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_13_1.actors_["1089ui_story"].transform.localEulerAngles = arg_13_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			local var_16_1 = arg_13_1.actors_["1089ui_story"]

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(var_16_1) and arg_13_1.var_.characterEffect1089ui_story == nil then
				arg_13_1.var_.characterEffect1089ui_story = var_16_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_2 = 0.200000002980232

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_2 and not isNil(var_16_1) then
				if arg_13_1.var_.characterEffect1089ui_story and not isNil(var_16_1) then
					arg_13_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= 0 + var_16_2 and arg_13_1.time_ < 0 + var_16_2 + arg_16_0 and not isNil(var_16_1) and arg_13_1.var_.characterEffect1089ui_story then
				arg_13_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089actionlink/1089action434")
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_16_4 = arg_13_1.actors_["1056ui_story"]

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(var_16_4) and arg_13_1.var_.characterEffect1056ui_story == nil then
				arg_13_1.var_.characterEffect1056ui_story = var_16_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_5 = 0.200000002980232

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_5 and not isNil(var_16_4) then
				if arg_13_1.var_.characterEffect1056ui_story and not isNil(var_16_4) then
					arg_13_1.var_.characterEffect1056ui_story.fillFlat = true
					arg_13_1.var_.characterEffect1056ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_13_1.time_ - 0) / var_16_5)
				end
			end

			if arg_13_1.time_ >= 0 + var_16_5 and arg_13_1.time_ < 0 + var_16_5 + arg_16_0 and not isNil(var_16_4) and arg_13_1.var_.characterEffect1056ui_story then
				arg_13_1.var_.characterEffect1056ui_story.fillFlat = true
				arg_13_1.var_.characterEffect1056ui_story.fillRatio = 0.5
			end

			local var_16_6 = 0
			local var_16_7 = 0.95

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_6 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_8 = arg_13_1:GetWordFromCfg(320171003)
				local var_16_9 = arg_13_1:FormatText(var_16_8.content)

				arg_13_1.text_.text = var_16_9

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_11 = 38 <= 0 and var_16_7 or var_16_7 * (utf8.len(var_16_9) / 38)

				if (38 <= 0 and var_16_7 or var_16_7 * (utf8.len(var_16_9) / 38)) > 0 and var_16_7 < var_16_11 then
					arg_13_1.talkMaxDuration = var_16_11

					if var_16_11 + var_16_6 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_11 + var_16_6
					end
				end

				arg_13_1.text_.text = var_16_9
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320171", "320171003", "story_v_out_320171.awb") ~= 0 then
					local var_16_12 = manager.audio:GetVoiceLength("story_v_out_320171", "320171003", "story_v_out_320171.awb") / 1000

					if var_16_12 + var_16_6 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_12 + var_16_6
					end

					if var_16_8.prefab_name ~= "" and arg_13_1.actors_[var_16_8.prefab_name] ~= nil then
						local var_16_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_8.prefab_name].transform, "story_v_out_320171", "320171003", "story_v_out_320171.awb")

						arg_13_1:RecordAudio("320171003", var_16_13)
						arg_13_1:RecordAudio("320171003", var_16_13)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_320171", "320171003", "story_v_out_320171.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_320171", "320171003", "story_v_out_320171.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_14 = math.max(var_16_7, arg_13_1.talkMaxDuration)

			if var_16_6 <= arg_13_1.time_ and arg_13_1.time_ < var_16_6 + var_16_14 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_6) / var_16_14

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_6 + var_16_14 and arg_13_1.time_ < var_16_6 + var_16_14 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
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
	Play320171004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 320171004
		arg_17_1.duration_ = 5.73

		local var_17_0 = {
			zh = 4.966,
			ja = 5.733
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
				arg_17_0:Play320171005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(arg_17_1.actors_["1056ui_story"]) and arg_17_1.var_.characterEffect1056ui_story == nil then
				arg_17_1.var_.characterEffect1056ui_story = arg_17_1.actors_["1056ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_0 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_0 and not isNil(arg_17_1.actors_["1056ui_story"]) then
				if arg_17_1.var_.characterEffect1056ui_story and not isNil(arg_17_1.actors_["1056ui_story"]) then
					arg_17_1.var_.characterEffect1056ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= 0 + var_20_0 and arg_17_1.time_ < 0 + var_20_0 + arg_20_0 and not isNil(arg_17_1.actors_["1056ui_story"]) and arg_17_1.var_.characterEffect1056ui_story then
				arg_17_1.var_.characterEffect1056ui_story.fillFlat = false
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva", "EmotionTimelineAnimator")
			end

			local var_20_2 = arg_17_1.actors_["1089ui_story"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_2) and arg_17_1.var_.characterEffect1089ui_story == nil then
				arg_17_1.var_.characterEffect1089ui_story = var_20_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_3 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_3 and not isNil(var_20_2) then
				if arg_17_1.var_.characterEffect1089ui_story and not isNil(var_20_2) then
					arg_17_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_17_1.var_.characterEffect1089ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_17_1.time_ - 0) / var_20_3)
				end
			end

			if arg_17_1.time_ >= 0 + var_20_3 and arg_17_1.time_ < 0 + var_20_3 + arg_20_0 and not isNil(var_20_2) and arg_17_1.var_.characterEffect1089ui_story then
				arg_17_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_17_1.var_.characterEffect1089ui_story.fillRatio = 0.5
			end

			local var_20_4 = 0
			local var_20_5 = 0.575

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_4 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_6 = arg_17_1:GetWordFromCfg(320171004)
				local var_20_7 = arg_17_1:FormatText(var_20_6.content)

				arg_17_1.text_.text = var_20_7

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_9 = 23 <= 0 and var_20_5 or var_20_5 * (utf8.len(var_20_7) / 23)

				if (23 <= 0 and var_20_5 or var_20_5 * (utf8.len(var_20_7) / 23)) > 0 and var_20_5 < var_20_9 then
					arg_17_1.talkMaxDuration = var_20_9

					if var_20_9 + var_20_4 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_9 + var_20_4
					end
				end

				arg_17_1.text_.text = var_20_7
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320171", "320171004", "story_v_out_320171.awb") ~= 0 then
					local var_20_10 = manager.audio:GetVoiceLength("story_v_out_320171", "320171004", "story_v_out_320171.awb") / 1000

					if var_20_10 + var_20_4 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_10 + var_20_4
					end

					if var_20_6.prefab_name ~= "" and arg_17_1.actors_[var_20_6.prefab_name] ~= nil then
						local var_20_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_6.prefab_name].transform, "story_v_out_320171", "320171004", "story_v_out_320171.awb")

						arg_17_1:RecordAudio("320171004", var_20_11)
						arg_17_1:RecordAudio("320171004", var_20_11)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_320171", "320171004", "story_v_out_320171.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_320171", "320171004", "story_v_out_320171.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_12 = math.max(var_20_5, arg_17_1.talkMaxDuration)

			if var_20_4 <= arg_17_1.time_ and arg_17_1.time_ < var_20_4 + var_20_12 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_4) / var_20_12

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_4 + var_20_12 and arg_17_1.time_ < var_20_4 + var_20_12 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play320171005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 320171005
		arg_21_1.duration_ = 6.37

		local var_21_0 = {
			zh = 6.366,
			ja = 4.7
		}
		local var_21_1 = manager.audio:GetLocalizationFlag()

		if var_21_0[var_21_1] ~= nil then
			arg_21_1.duration_ = var_21_0[var_21_1]
		end

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play320171006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(arg_21_1.actors_["1089ui_story"]) and arg_21_1.var_.characterEffect1089ui_story == nil then
				arg_21_1.var_.characterEffect1089ui_story = arg_21_1.actors_["1089ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_0 = 0.200000002980232

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_0 and not isNil(arg_21_1.actors_["1089ui_story"]) then
				if arg_21_1.var_.characterEffect1089ui_story and not isNil(arg_21_1.actors_["1089ui_story"]) then
					arg_21_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= 0 + var_24_0 and arg_21_1.time_ < 0 + var_24_0 + arg_24_0 and not isNil(arg_21_1.actors_["1089ui_story"]) and arg_21_1.var_.characterEffect1089ui_story then
				arg_21_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action4_2")
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_24_2 = arg_21_1.actors_["1056ui_story"]

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(var_24_2) and arg_21_1.var_.characterEffect1056ui_story == nil then
				arg_21_1.var_.characterEffect1056ui_story = var_24_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_3 = 0.200000002980232

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_3 and not isNil(var_24_2) then
				if arg_21_1.var_.characterEffect1056ui_story and not isNil(var_24_2) then
					arg_21_1.var_.characterEffect1056ui_story.fillFlat = true
					arg_21_1.var_.characterEffect1056ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_21_1.time_ - 0) / var_24_3)
				end
			end

			if arg_21_1.time_ >= 0 + var_24_3 and arg_21_1.time_ < 0 + var_24_3 + arg_24_0 and not isNil(var_24_2) and arg_21_1.var_.characterEffect1056ui_story then
				arg_21_1.var_.characterEffect1056ui_story.fillFlat = true
				arg_21_1.var_.characterEffect1056ui_story.fillRatio = 0.5
			end

			local var_24_4 = 0
			local var_24_5 = 0.6

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_4 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_6 = arg_21_1:GetWordFromCfg(320171005)
				local var_24_7 = arg_21_1:FormatText(var_24_6.content)

				arg_21_1.text_.text = var_24_7

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_9 = 24 <= 0 and var_24_5 or var_24_5 * (utf8.len(var_24_7) / 24)

				if (24 <= 0 and var_24_5 or var_24_5 * (utf8.len(var_24_7) / 24)) > 0 and var_24_5 < var_24_9 then
					arg_21_1.talkMaxDuration = var_24_9

					if var_24_9 + var_24_4 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_9 + var_24_4
					end
				end

				arg_21_1.text_.text = var_24_7
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320171", "320171005", "story_v_out_320171.awb") ~= 0 then
					local var_24_10 = manager.audio:GetVoiceLength("story_v_out_320171", "320171005", "story_v_out_320171.awb") / 1000

					if var_24_10 + var_24_4 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_10 + var_24_4
					end

					if var_24_6.prefab_name ~= "" and arg_21_1.actors_[var_24_6.prefab_name] ~= nil then
						local var_24_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_6.prefab_name].transform, "story_v_out_320171", "320171005", "story_v_out_320171.awb")

						arg_21_1:RecordAudio("320171005", var_24_11)
						arg_21_1:RecordAudio("320171005", var_24_11)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_320171", "320171005", "story_v_out_320171.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_320171", "320171005", "story_v_out_320171.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_12 = math.max(var_24_5, arg_21_1.talkMaxDuration)

			if var_24_4 <= arg_21_1.time_ and arg_21_1.time_ < var_24_4 + var_24_12 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_4) / var_24_12

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_4 + var_24_12 and arg_21_1.time_ < var_24_4 + var_24_12 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play320171006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 320171006
		arg_25_1.duration_ = 4

		local var_25_0 = {
			zh = 2.866,
			ja = 4
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
				arg_25_0:Play320171007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_28_0 = 0
			local var_28_1 = 0.2

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_0 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_2 = arg_25_1:GetWordFromCfg(320171006)
				local var_28_3 = arg_25_1:FormatText(var_28_2.content)

				arg_25_1.text_.text = var_28_3

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_5 = 8 <= 0 and var_28_1 or var_28_1 * (utf8.len(var_28_3) / 8)

				if (8 <= 0 and var_28_1 or var_28_1 * (utf8.len(var_28_3) / 8)) > 0 and var_28_1 < var_28_5 then
					arg_25_1.talkMaxDuration = var_28_5

					if var_28_5 + var_28_0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_5 + var_28_0
					end
				end

				arg_25_1.text_.text = var_28_3
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320171", "320171006", "story_v_out_320171.awb") ~= 0 then
					local var_28_6 = manager.audio:GetVoiceLength("story_v_out_320171", "320171006", "story_v_out_320171.awb") / 1000

					if var_28_6 + var_28_0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_6 + var_28_0
					end

					if var_28_2.prefab_name ~= "" and arg_25_1.actors_[var_28_2.prefab_name] ~= nil then
						local var_28_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_2.prefab_name].transform, "story_v_out_320171", "320171006", "story_v_out_320171.awb")

						arg_25_1:RecordAudio("320171006", var_28_7)
						arg_25_1:RecordAudio("320171006", var_28_7)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_320171", "320171006", "story_v_out_320171.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_320171", "320171006", "story_v_out_320171.awb")
				end

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
	Play320171007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 320171007
		arg_29_1.duration_ = 6.7

		local var_29_0 = {
			zh = 6.7,
			ja = 5.7
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
				arg_29_0:Play320171008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_9001
			local var_32_9000

			if arg_29_1.bgs_.XS0105 == nil then
				local var_32_0 = Object.Instantiate(arg_29_1.paintGo_)

				var_32_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "XS0105")
				var_32_0.name = "XS0105"
				var_32_0.transform.parent = arg_29_1.stage_.transform
				var_32_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_29_1.bgs_.XS0105 = var_32_0
			end

			if 1.96599999815226 < arg_29_1.time_ and arg_29_1.time_ <= 1.96599999815226 + arg_32_0 then
				local var_32_1 = arg_29_1.bgs_.XS0105

				arg_29_1.bgs_.XS0105.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_32_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_32_2 = var_32_1:GetComponent("SpriteRenderer")

				if var_32_2 and var_32_2.sprite then
					local var_32_3 = 2 * (var_32_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_32_1.transform.localScale = Vector3.New(var_32_3 / var_32_2.sprite.bounds.size.y < var_32_3 * manager.ui.mainCameraCom_.aspect / var_32_2.sprite.bounds.size.x and var_32_3 * manager.ui.mainCameraCom_.aspect / var_32_2.sprite.bounds.size.x or var_32_3 / var_32_2.sprite.bounds.size.y, var_32_3 / var_32_2.sprite.bounds.size.y < var_32_3 * manager.ui.mainCameraCom_.aspect / var_32_2.sprite.bounds.size.x and var_32_3 * manager.ui.mainCameraCom_.aspect / var_32_2.sprite.bounds.size.x or var_32_3 / var_32_2.sprite.bounds.size.y, 0)
				end

				for iter_32_0, iter_32_1 in pairs(arg_29_1.bgs_) do
					if iter_32_0 ~= "XS0105" then
						iter_32_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_32_4 = 4

			if 4 < arg_29_1.time_ and arg_29_1.time_ <= var_32_4 + arg_32_0 then
				arg_29_1.allBtn_.enabled = false
			end

			if arg_29_1.time_ >= var_32_4 + 0.3 and arg_29_1.time_ < var_32_4 + 0.3 + arg_32_0 then
				arg_29_1.allBtn_.enabled = true
			end

			local var_32_5 = 0

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_5 + arg_32_0 then
				arg_29_1.mask_.enabled = true
				arg_29_1.mask_.raycastTarget = true

				arg_29_1:SetGaussion(false)
			end

			local var_32_6 = 2

			if var_32_5 <= arg_29_1.time_ and arg_29_1.time_ < var_32_5 + var_32_6 then
				local var_32_7 = Color.New(0, 0, 0)

				var_32_7.a = Mathf.Lerp(0, 1, (arg_29_1.time_ - var_32_5) / var_32_6)
				arg_29_1.mask_.color = var_32_7
			end

			if arg_29_1.time_ >= var_32_5 + var_32_6 and arg_29_1.time_ < var_32_5 + var_32_6 + arg_32_0 then
				local var_32_8 = Color.New(0, 0, 0)

				var_32_8.a = 1
				arg_29_1.mask_.color = var_32_8
			end

			local var_32_9 = 2

			if 2 < arg_29_1.time_ and arg_29_1.time_ <= var_32_9 + arg_32_0 then
				arg_29_1.mask_.enabled = true
				arg_29_1.mask_.raycastTarget = true

				arg_29_1:SetGaussion(false)
			end

			local var_32_10 = 2

			if var_32_9 <= arg_29_1.time_ and arg_29_1.time_ < var_32_9 + var_32_10 then
				local var_32_11 = Color.New(0, 0, 0)

				var_32_11.a = Mathf.Lerp(1, 0, (arg_29_1.time_ - var_32_9) / var_32_10)
				arg_29_1.mask_.color = var_32_11
			end

			if arg_29_1.time_ >= var_32_9 + var_32_10 and arg_29_1.time_ < var_32_9 + var_32_10 + arg_32_0 then
				local var_32_12 = Color.New(0, 0, 0)

				arg_29_1.mask_.enabled = false
				var_32_12.a = 0
				arg_29_1.mask_.color = var_32_12
			end

			local var_32_13 = arg_29_1.actors_["1089ui_story"].transform

			if 1.96599999815226 < arg_29_1.time_ and arg_29_1.time_ <= 1.96599999815226 + arg_32_0 then
				arg_29_1.var_.moveOldPos1089ui_story = var_32_13.localPosition
			end

			local var_32_14 = 0.001

			if 1.96599999815226 <= arg_29_1.time_ and arg_29_1.time_ < 1.96599999815226 + var_32_14 then
				var_32_13.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos1089ui_story, Vector3.New(0, 100, 0), (arg_29_1.time_ - 1.96599999815226) / var_32_14)
				var_32_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_32_13.position).x, (manager.ui.mainCamera.transform.position - var_32_13.position).y, (manager.ui.mainCamera.transform.position - var_32_13.position).z)
				var_32_13.localEulerAngles.z = 0
				var_32_13.localEulerAngles.x = 0
				var_32_13.localEulerAngles = var_32_13.localEulerAngles
			end

			if arg_29_1.time_ >= 1.96599999815226 + var_32_14 and arg_29_1.time_ < 1.96599999815226 + var_32_14 + arg_32_0 then
				var_32_13.localPosition = Vector3.New(0, 100, 0)
				var_32_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_32_13.position).x, (manager.ui.mainCamera.transform.position - var_32_13.position).y, (manager.ui.mainCamera.transform.position - var_32_13.position).z)
				var_32_13.localEulerAngles.z = 0
				var_32_13.localEulerAngles.x = 0
				var_32_13.localEulerAngles = var_32_13.localEulerAngles
			end

			local var_32_15 = arg_29_1.actors_["1089ui_story"]

			if 1.96599999815226 < arg_29_1.time_ and arg_29_1.time_ <= 1.96599999815226 + arg_32_0 and not isNil(var_32_15) and arg_29_1.var_.characterEffect1089ui_story == nil then
				arg_29_1.var_.characterEffect1089ui_story = var_32_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_16 = 0.034000001847744

			if 1.96599999815226 <= arg_29_1.time_ and arg_29_1.time_ < 1.96599999815226 + var_32_16 and not isNil(var_32_15) then
				if arg_29_1.var_.characterEffect1089ui_story and not isNil(var_32_15) then
					arg_29_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_29_1.var_.characterEffect1089ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_29_1.time_ - 1.96599999815226) / var_32_16)
				end
			end

			if arg_29_1.time_ >= 1.96599999815226 + var_32_16 and arg_29_1.time_ < 1.96599999815226 + var_32_16 + arg_32_0 and not isNil(var_32_15) and arg_29_1.var_.characterEffect1089ui_story then
				arg_29_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_29_1.var_.characterEffect1089ui_story.fillRatio = 0.5
			end

			local var_32_17 = arg_29_1.actors_["1056ui_story"].transform

			if 1.96599999815226 < arg_29_1.time_ and arg_29_1.time_ <= 1.96599999815226 + arg_32_0 then
				arg_29_1.var_.moveOldPos1056ui_story = var_32_17.localPosition
			end

			local var_32_18 = 0.001

			if 1.96599999815226 <= arg_29_1.time_ and arg_29_1.time_ < 1.96599999815226 + var_32_18 then
				var_32_17.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos1056ui_story, Vector3.New(0, 100, 0), (arg_29_1.time_ - 1.96599999815226) / var_32_18)
				var_32_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_32_17.position).x, (manager.ui.mainCamera.transform.position - var_32_17.position).y, (manager.ui.mainCamera.transform.position - var_32_17.position).z)
				var_32_17.localEulerAngles.z = 0
				var_32_17.localEulerAngles.x = 0
				var_32_17.localEulerAngles = var_32_17.localEulerAngles
			end

			if arg_29_1.time_ >= 1.96599999815226 + var_32_18 and arg_29_1.time_ < 1.96599999815226 + var_32_18 + arg_32_0 then
				var_32_17.localPosition = Vector3.New(0, 100, 0)
				var_32_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_32_17.position).x, (manager.ui.mainCamera.transform.position - var_32_17.position).y, (manager.ui.mainCamera.transform.position - var_32_17.position).z)
				var_32_17.localEulerAngles.z = 0
				var_32_17.localEulerAngles.x = 0
				var_32_17.localEulerAngles = var_32_17.localEulerAngles
			end

			local var_32_19 = arg_29_1.actors_["1056ui_story"]

			if 1.96599999815226 < arg_29_1.time_ and arg_29_1.time_ <= 1.96599999815226 + arg_32_0 and not isNil(var_32_19) and arg_29_1.var_.characterEffect1056ui_story == nil then
				arg_29_1.var_.characterEffect1056ui_story = var_32_19:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_20 = 0.034000001847744

			if 1.96599999815226 <= arg_29_1.time_ and arg_29_1.time_ < 1.96599999815226 + var_32_20 and not isNil(var_32_19) then
				if arg_29_1.var_.characterEffect1056ui_story and not isNil(var_32_19) then
					arg_29_1.var_.characterEffect1056ui_story.fillFlat = true
					arg_29_1.var_.characterEffect1056ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_29_1.time_ - 1.96599999815226) / var_32_20)
				end
			end

			if arg_29_1.time_ >= 1.96599999815226 + var_32_20 and arg_29_1.time_ < 1.96599999815226 + var_32_20 + arg_32_0 and not isNil(var_32_19) and arg_29_1.var_.characterEffect1056ui_story then
				arg_29_1.var_.characterEffect1056ui_story.fillFlat = true
				arg_29_1.var_.characterEffect1056ui_story.fillRatio = 0.5
			end

			local var_32_21 = arg_29_1.bgs_.XS0105.transform

			if 2 < arg_29_1.time_ and arg_29_1.time_ <= 2 + arg_32_0 then
				arg_29_1.var_.moveOldPosXS0105 = var_32_21.localPosition
			end

			local var_32_22 = 0.001

			if 2 <= arg_29_1.time_ and arg_29_1.time_ < 2 + var_32_22 then
				var_32_21.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPosXS0105, Vector3.New(0, 1, 10), (arg_29_1.time_ - 2) / var_32_22)
			end

			if arg_29_1.time_ >= 2 + var_32_22 and arg_29_1.time_ < 2 + var_32_22 + arg_32_0 then
				var_32_21.localPosition = Vector3.New(0, 1, 10)
			end

			local var_32_23 = arg_29_1.bgs_.XS0105.transform

			if 2.034 < arg_29_1.time_ and arg_29_1.time_ <= 2.034 + arg_32_0 then
				arg_29_1.var_.moveOldPosXS0105 = var_32_23.localPosition
			end

			local var_32_24 = 2.266

			if 2.034 <= arg_29_1.time_ and arg_29_1.time_ < 2.034 + var_32_24 then
				var_32_23.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPosXS0105, Vector3.New(0, 1, 9), (arg_29_1.time_ - 2.034) / var_32_24)
			end

			if arg_29_1.time_ >= 2.034 + var_32_24 and arg_29_1.time_ < 2.034 + var_32_24 + arg_32_0 then
				var_32_23.localPosition = Vector3.New(0, 1, 9)
			end

			local var_32_25 = 1.86666666666667

			arg_29_1.isInRecall_ = false

			if var_32_25 < arg_29_1.time_ and arg_29_1.time_ <= var_32_25 + arg_32_0 then
				arg_29_1.screenFilterGo_:SetActive(false)

				for iter_32_2, iter_32_3 in pairs(arg_29_1.actors_) do
					for iter_32_4, iter_32_5 in ipairs((iter_32_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_32_5.color = iter_32_5.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_32_26 = 0.133333333333333

			if var_32_25 <= arg_29_1.time_ and arg_29_1.time_ < var_32_25 + var_32_26 then
				arg_29_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, (arg_29_1.time_ - var_32_25) / var_32_26)
			end

			if arg_29_1.time_ >= var_32_25 + var_32_26 and arg_29_1.time_ < var_32_25 + var_32_26 + arg_32_0 then
				arg_29_1.screenFilterEffect_.weight = 0
			end

			if 2 < arg_29_1.time_ and arg_29_1.time_ <= 2 + arg_32_0 then
				local var_32_27 = arg_29_1.var_.effectjialidayu1

				if not arg_29_1.var_.effectjialidayu1 then
					var_32_27 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_rain_heavy"), manager.ui.mainCamera.transform)
					var_32_27.name = "jialidayu1"
					arg_29_1.var_.effectjialidayu1 = var_32_27
				else
					var_32_27.transform:SetParent(var_32_9001)
				end

				var_32_27.transform.localPosition = Vector3.New(0, 0, 0)
				var_32_27.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 2 < arg_29_1.time_ and arg_29_1.time_ <= 2 + arg_32_0 then
				local var_32_29 = arg_29_1.var_.effectjialidayu2

				if not arg_29_1.var_.effectjialidayu2 then
					var_32_29 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_rain_light_ui"), manager.ui.mainCamera.transform)
					var_32_29.name = "jialidayu2"
					arg_29_1.var_.effectjialidayu2 = var_32_29
				else
					var_32_29.transform:SetParent(var_32_9000)
				end

				var_32_29.transform.localPosition = Vector3.New(0, 0, 0)
				var_32_29.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_32_31 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_32_32 = var_32_29.transform:GetComponentsInChildren(typeof(Transform), true)

				for iter_32_6, iter_32_7 in ipairs((var_32_32:ToTable())) do
					iter_32_7.transform.localScale = Vector3.New(iter_32_7.transform.localScale.x / var_32_31 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * var_32_32 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_32_7.transform.localScale.y / var_32_31, iter_32_7.transform.localScale.z)
				end
			end

			if arg_29_1.frameCnt_ <= 1 then
				arg_29_1.dialog_:SetActive(false)
			end

			local var_32_34 = 3.7
			local var_32_35 = 0.3

			if 3.7 < arg_29_1.time_ and arg_29_1.time_ <= var_32_34 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0

				arg_29_1.dialog_:SetActive(true)

				arg_29_1.dialogCg_.alpha = 0

				local var_32_36 = LeanTween.value(arg_29_1.dialog_, 0, 1, 0.3)

				var_32_36:setOnUpdate(LuaHelper.FloatAction(function(arg_33_0)
					arg_29_1.dialogCg_.alpha = arg_33_0
				end))
				var_32_36:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_29_1.dialog_)
					var_32_36:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_29_1.duration_ = arg_29_1.duration_ + 0.3

				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_37 = arg_29_1:GetWordFromCfg(320171007)
				local var_32_38 = arg_29_1:FormatText(var_32_37.content)

				arg_29_1.text_.text = var_32_38

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_40 = 14 <= 0 and var_32_35 or var_32_35 * (utf8.len(var_32_38) / 14)

				if (14 <= 0 and var_32_35 or var_32_35 * (utf8.len(var_32_38) / 14)) > 0 and var_32_35 < var_32_40 then
					arg_29_1.talkMaxDuration = var_32_40
					var_32_34 = var_32_34 + 0.3

					if var_32_40 + var_32_34 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_40 + var_32_34
					end
				end

				arg_29_1.text_.text = var_32_38
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320171", "320171007", "story_v_out_320171.awb") ~= 0 then
					local var_32_41 = manager.audio:GetVoiceLength("story_v_out_320171", "320171007", "story_v_out_320171.awb") / 1000

					if var_32_41 + var_32_34 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_41 + var_32_34
					end

					if var_32_37.prefab_name ~= "" and arg_29_1.actors_[var_32_37.prefab_name] ~= nil then
						local var_32_42 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_37.prefab_name].transform, "story_v_out_320171", "320171007", "story_v_out_320171.awb")

						arg_29_1:RecordAudio("320171007", var_32_42)
						arg_29_1:RecordAudio("320171007", var_32_42)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_320171", "320171007", "story_v_out_320171.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_320171", "320171007", "story_v_out_320171.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_43 = var_32_34 + 0.3
			local var_32_44 = math.max(var_32_35, arg_29_1.talkMaxDuration)

			if var_32_34 + 0.3 <= arg_29_1.time_ and arg_29_1.time_ < var_32_43 + var_32_44 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_43) / var_32_44

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_43 + var_32_44 and arg_29_1.time_ < var_32_43 + var_32_44 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1056ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "XS0105",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "XS0105",
				changeDisplayLayer = false,
				needEase = false,
				duration = 2.266,
				className = "StoryMoveNode",
				startTime = 2.034,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_29_1:InitPlayNodeList()
	end,
	Play320171008 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 320171008
		arg_35_1.duration_ = 5

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play320171009(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			if 0.3 < arg_35_1.time_ and arg_35_1.time_ <= 0.3 + arg_38_0 then
				arg_35_1:AudioAction("play", "effect", "se_story_activity_1_5_3", "se_story_activity_1_5_3_rain_loop", "")
			end

			if 0.275 < arg_35_1.time_ and arg_35_1.time_ <= 0.275 + arg_38_0 then
				arg_35_1:AudioAction("play", "effect", "se_story_136", "se_story_136_metalhit", "")
			end

			local var_38_2 = 0
			local var_38_3 = 1.275

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= var_38_2 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, false)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_4 = arg_35_1:FormatText(arg_35_1:GetWordFromCfg(320171008).content)

				arg_35_1.text_.text = var_38_4

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_6 = 51 <= 0 and var_38_3 or var_38_3 * (utf8.len(var_38_4) / 51)

				if (51 <= 0 and var_38_3 or var_38_3 * (utf8.len(var_38_4) / 51)) > 0 and var_38_3 < var_38_6 then
					arg_35_1.talkMaxDuration = var_38_6

					if var_38_6 + var_38_2 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_6 + var_38_2
					end
				end

				arg_35_1.text_.text = var_38_4
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)
				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_7 = math.max(var_38_3, arg_35_1.talkMaxDuration)

			if var_38_2 <= arg_35_1.time_ and arg_35_1.time_ < var_38_2 + var_38_7 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_2) / var_38_7

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_2 + var_38_7 and arg_35_1.time_ < var_38_2 + var_38_7 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {}

		arg_35_1:InitPlayNodeList()
	end,
	Play320171009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 320171009
		arg_39_1.duration_ = 1.23

		local var_39_0 = {
			zh = 1.233,
			ja = 1.033
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
				arg_39_0:Play320171010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			local var_42_0 = 0.1

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, true)

				arg_39_1.leftNameTxt_.text = arg_39_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_1 = arg_39_1:GetWordFromCfg(320171009)
				local var_42_2 = arg_39_1:FormatText(var_42_1.content)

				arg_39_1.text_.text = var_42_2

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_4 = 4 <= 0 and var_42_0 or var_42_0 * (utf8.len(var_42_2) / 4)

				if (4 <= 0 and var_42_0 or var_42_0 * (utf8.len(var_42_2) / 4)) > 0 and var_42_0 < var_42_4 then
					arg_39_1.talkMaxDuration = var_42_4

					if var_42_4 + 0 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_4 + 0
					end
				end

				arg_39_1.text_.text = var_42_2
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320171", "320171009", "story_v_out_320171.awb") ~= 0 then
					local var_42_5 = manager.audio:GetVoiceLength("story_v_out_320171", "320171009", "story_v_out_320171.awb") / 1000

					if var_42_5 + 0 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_5 + 0
					end

					if var_42_1.prefab_name ~= "" and arg_39_1.actors_[var_42_1.prefab_name] ~= nil then
						local var_42_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_39_1.actors_[var_42_1.prefab_name].transform, "story_v_out_320171", "320171009", "story_v_out_320171.awb")

						arg_39_1:RecordAudio("320171009", var_42_6)
						arg_39_1:RecordAudio("320171009", var_42_6)
					else
						arg_39_1:AudioAction("play", "voice", "story_v_out_320171", "320171009", "story_v_out_320171.awb")
					end

					arg_39_1:RecordHistoryTalkVoice("story_v_out_320171", "320171009", "story_v_out_320171.awb")
				end

				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_7 = math.max(var_42_0, arg_39_1.talkMaxDuration)

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_7 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - 0) / var_42_7

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= 0 + var_42_7 and arg_39_1.time_ < 0 + var_42_7 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {}

		arg_39_1:InitPlayNodeList()
	end,
	Play320171010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 320171010
		arg_43_1.duration_ = 5.03

		local var_43_0 = {
			zh = 3.033,
			ja = 5.033
		}
		local var_43_1 = manager.audio:GetLocalizationFlag()

		if var_43_0[var_43_1] ~= nil then
			arg_43_1.duration_ = var_43_0[var_43_1]
		end

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play320171011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			local var_46_0 = 0.4

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				arg_43_1.leftNameTxt_.text = arg_43_1:FormatText(StoryNameCfg[1025].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, true)
				arg_43_1.iconController_:SetSelectedState("hero")

				arg_43_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_wrestlingboss")

				arg_43_1.callingController_:SetSelectedState("normal")

				arg_43_1.keyicon_.color = Color.New(1, 1, 1)
				arg_43_1.icon_.color = Color.New(1, 1, 1)

				local var_46_1 = arg_43_1:GetWordFromCfg(320171010)
				local var_46_2 = arg_43_1:FormatText(var_46_1.content)

				arg_43_1.text_.text = var_46_2

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_4 = 16 <= 0 and var_46_0 or var_46_0 * (utf8.len(var_46_2) / 16)

				if (16 <= 0 and var_46_0 or var_46_0 * (utf8.len(var_46_2) / 16)) > 0 and var_46_0 < var_46_4 then
					arg_43_1.talkMaxDuration = var_46_4

					if var_46_4 + 0 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_4 + 0
					end
				end

				arg_43_1.text_.text = var_46_2
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320171", "320171010", "story_v_out_320171.awb") ~= 0 then
					local var_46_5 = manager.audio:GetVoiceLength("story_v_out_320171", "320171010", "story_v_out_320171.awb") / 1000

					if var_46_5 + 0 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_5 + 0
					end

					if var_46_1.prefab_name ~= "" and arg_43_1.actors_[var_46_1.prefab_name] ~= nil then
						local var_46_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_43_1.actors_[var_46_1.prefab_name].transform, "story_v_out_320171", "320171010", "story_v_out_320171.awb")

						arg_43_1:RecordAudio("320171010", var_46_6)
						arg_43_1:RecordAudio("320171010", var_46_6)
					else
						arg_43_1:AudioAction("play", "voice", "story_v_out_320171", "320171010", "story_v_out_320171.awb")
					end

					arg_43_1:RecordHistoryTalkVoice("story_v_out_320171", "320171010", "story_v_out_320171.awb")
				end

				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_7 = math.max(var_46_0, arg_43_1.talkMaxDuration)

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_7 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - 0) / var_46_7

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= 0 + var_46_7 and arg_43_1.time_ < 0 + var_46_7 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {}

		arg_43_1:InitPlayNodeList()
	end,
	Play320171011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 320171011
		arg_47_1.duration_ = 5.27

		local var_47_0 = {
			zh = 3.9,
			ja = 5.266
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
				arg_47_0:Play320171012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			local var_50_0 = 0.475

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				arg_47_1.leftNameTxt_.text = arg_47_1:FormatText(StoryNameCfg[1040].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, true)
				arg_47_1.iconController_:SetSelectedState("hero")

				arg_47_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2124")

				arg_47_1.callingController_:SetSelectedState("normal")

				arg_47_1.keyicon_.color = Color.New(1, 1, 1)
				arg_47_1.icon_.color = Color.New(1, 1, 1)

				local var_50_1 = arg_47_1:GetWordFromCfg(320171011)
				local var_50_2 = arg_47_1:FormatText(var_50_1.content)

				arg_47_1.text_.text = var_50_2

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_4 = 19 <= 0 and var_50_0 or var_50_0 * (utf8.len(var_50_2) / 19)

				if (19 <= 0 and var_50_0 or var_50_0 * (utf8.len(var_50_2) / 19)) > 0 and var_50_0 < var_50_4 then
					arg_47_1.talkMaxDuration = var_50_4

					if var_50_4 + 0 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_4 + 0
					end
				end

				arg_47_1.text_.text = var_50_2
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320171", "320171011", "story_v_out_320171.awb") ~= 0 then
					local var_50_5 = manager.audio:GetVoiceLength("story_v_out_320171", "320171011", "story_v_out_320171.awb") / 1000

					if var_50_5 + 0 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_5 + 0
					end

					if var_50_1.prefab_name ~= "" and arg_47_1.actors_[var_50_1.prefab_name] ~= nil then
						local var_50_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_47_1.actors_[var_50_1.prefab_name].transform, "story_v_out_320171", "320171011", "story_v_out_320171.awb")

						arg_47_1:RecordAudio("320171011", var_50_6)
						arg_47_1:RecordAudio("320171011", var_50_6)
					else
						arg_47_1:AudioAction("play", "voice", "story_v_out_320171", "320171011", "story_v_out_320171.awb")
					end

					arg_47_1:RecordHistoryTalkVoice("story_v_out_320171", "320171011", "story_v_out_320171.awb")
				end

				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_7 = math.max(var_50_0, arg_47_1.talkMaxDuration)

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_7 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - 0) / var_50_7

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= 0 + var_50_7 and arg_47_1.time_ < 0 + var_50_7 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {}

		arg_47_1:InitPlayNodeList()
	end,
	Play320171012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 320171012
		arg_51_1.duration_ = 6.2

		local var_51_0 = {
			zh = 3.166,
			ja = 6.2
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
				arg_51_0:Play320171013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			local var_54_0 = 0.475

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				arg_51_1.leftNameTxt_.text = arg_51_1:FormatText(StoryNameCfg[1025].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, true)
				arg_51_1.iconController_:SetSelectedState("hero")

				arg_51_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_wrestlingboss")

				arg_51_1.callingController_:SetSelectedState("normal")

				arg_51_1.keyicon_.color = Color.New(1, 1, 1)
				arg_51_1.icon_.color = Color.New(1, 1, 1)

				local var_54_1 = arg_51_1:GetWordFromCfg(320171012)
				local var_54_2 = arg_51_1:FormatText(var_54_1.content)

				arg_51_1.text_.text = var_54_2

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_4 = 19 <= 0 and var_54_0 or var_54_0 * (utf8.len(var_54_2) / 19)

				if (19 <= 0 and var_54_0 or var_54_0 * (utf8.len(var_54_2) / 19)) > 0 and var_54_0 < var_54_4 then
					arg_51_1.talkMaxDuration = var_54_4

					if var_54_4 + 0 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_4 + 0
					end
				end

				arg_51_1.text_.text = var_54_2
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320171", "320171012", "story_v_out_320171.awb") ~= 0 then
					local var_54_5 = manager.audio:GetVoiceLength("story_v_out_320171", "320171012", "story_v_out_320171.awb") / 1000

					if var_54_5 + 0 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_5 + 0
					end

					if var_54_1.prefab_name ~= "" and arg_51_1.actors_[var_54_1.prefab_name] ~= nil then
						local var_54_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_51_1.actors_[var_54_1.prefab_name].transform, "story_v_out_320171", "320171012", "story_v_out_320171.awb")

						arg_51_1:RecordAudio("320171012", var_54_6)
						arg_51_1:RecordAudio("320171012", var_54_6)
					else
						arg_51_1:AudioAction("play", "voice", "story_v_out_320171", "320171012", "story_v_out_320171.awb")
					end

					arg_51_1:RecordHistoryTalkVoice("story_v_out_320171", "320171012", "story_v_out_320171.awb")
				end

				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_7 = math.max(var_54_0, arg_51_1.talkMaxDuration)

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_7 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - 0) / var_54_7

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= 0 + var_54_7 and arg_51_1.time_ < 0 + var_54_7 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {}

		arg_51_1:InitPlayNodeList()
	end,
	Play320171013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 320171013
		arg_55_1.duration_ = 9.13

		local var_55_0 = {
			zh = 9.133,
			ja = 8.4
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
				arg_55_0:Play320171014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			local var_58_0 = 0.625

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				arg_55_1.leftNameTxt_.text = arg_55_1:FormatText(StoryNameCfg[1025].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, true)
				arg_55_1.iconController_:SetSelectedState("hero")

				arg_55_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_wrestlingboss")

				arg_55_1.callingController_:SetSelectedState("normal")

				arg_55_1.keyicon_.color = Color.New(1, 1, 1)
				arg_55_1.icon_.color = Color.New(1, 1, 1)

				local var_58_1 = arg_55_1:GetWordFromCfg(320171013)
				local var_58_2 = arg_55_1:FormatText(var_58_1.content)

				arg_55_1.text_.text = var_58_2

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_4 = 25 <= 0 and var_58_0 or var_58_0 * (utf8.len(var_58_2) / 25)

				if (25 <= 0 and var_58_0 or var_58_0 * (utf8.len(var_58_2) / 25)) > 0 and var_58_0 < var_58_4 then
					arg_55_1.talkMaxDuration = var_58_4

					if var_58_4 + 0 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_4 + 0
					end
				end

				arg_55_1.text_.text = var_58_2
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320171", "320171013", "story_v_out_320171.awb") ~= 0 then
					local var_58_5 = manager.audio:GetVoiceLength("story_v_out_320171", "320171013", "story_v_out_320171.awb") / 1000

					if var_58_5 + 0 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_5 + 0
					end

					if var_58_1.prefab_name ~= "" and arg_55_1.actors_[var_58_1.prefab_name] ~= nil then
						local var_58_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_55_1.actors_[var_58_1.prefab_name].transform, "story_v_out_320171", "320171013", "story_v_out_320171.awb")

						arg_55_1:RecordAudio("320171013", var_58_6)
						arg_55_1:RecordAudio("320171013", var_58_6)
					else
						arg_55_1:AudioAction("play", "voice", "story_v_out_320171", "320171013", "story_v_out_320171.awb")
					end

					arg_55_1:RecordHistoryTalkVoice("story_v_out_320171", "320171013", "story_v_out_320171.awb")
				end

				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_7 = math.max(var_58_0, arg_55_1.talkMaxDuration)

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_7 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - 0) / var_58_7

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= 0 + var_58_7 and arg_55_1.time_ < 0 + var_58_7 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {}

		arg_55_1:InitPlayNodeList()
	end,
	Play320171014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 320171014
		arg_59_1.duration_ = 5

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play320171015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = 1.2

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, false)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_1 = arg_59_1:FormatText(arg_59_1:GetWordFromCfg(320171014).content)

				arg_59_1.text_.text = var_62_1

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_3 = 48 <= 0 and var_62_0 or var_62_0 * (utf8.len(var_62_1) / 48)

				if (48 <= 0 and var_62_0 or var_62_0 * (utf8.len(var_62_1) / 48)) > 0 and var_62_0 < var_62_3 then
					arg_59_1.talkMaxDuration = var_62_3

					if var_62_3 + 0 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_3 + 0
					end
				end

				arg_59_1.text_.text = var_62_1
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)
				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_4 = math.max(var_62_0, arg_59_1.talkMaxDuration)

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_4 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - 0) / var_62_4

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= 0 + var_62_4 and arg_59_1.time_ < 0 + var_62_4 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {}

		arg_59_1:InitPlayNodeList()
	end,
	Play320171015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 320171015
		arg_63_1.duration_ = 5

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play320171016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = 1.05

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, false)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_1 = arg_63_1:FormatText(arg_63_1:GetWordFromCfg(320171015).content)

				arg_63_1.text_.text = var_66_1

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_3 = 42 <= 0 and var_66_0 or var_66_0 * (utf8.len(var_66_1) / 42)

				if (42 <= 0 and var_66_0 or var_66_0 * (utf8.len(var_66_1) / 42)) > 0 and var_66_0 < var_66_3 then
					arg_63_1.talkMaxDuration = var_66_3

					if var_66_3 + 0 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_3 + 0
					end
				end

				arg_63_1.text_.text = var_66_1
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)
				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_4 = math.max(var_66_0, arg_63_1.talkMaxDuration)

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_4 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - 0) / var_66_4

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= 0 + var_66_4 and arg_63_1.time_ < 0 + var_66_4 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	Play320171016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 320171016
		arg_67_1.duration_ = 6.8

		local var_67_0 = {
			zh = 5.7,
			ja = 6.8
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
				arg_67_0:Play320171017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = 0.625

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				arg_67_1.leftNameTxt_.text = arg_67_1:FormatText(StoryNameCfg[1023].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, true)
				arg_67_1.iconController_:SetSelectedState("hero")

				arg_67_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10101")

				arg_67_1.callingController_:SetSelectedState("normal")

				arg_67_1.keyicon_.color = Color.New(1, 1, 1)
				arg_67_1.icon_.color = Color.New(1, 1, 1)

				local var_70_1 = arg_67_1:GetWordFromCfg(320171016)
				local var_70_2 = arg_67_1:FormatText(var_70_1.content)

				arg_67_1.text_.text = var_70_2

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_4 = 25 <= 0 and var_70_0 or var_70_0 * (utf8.len(var_70_2) / 25)

				if (25 <= 0 and var_70_0 or var_70_0 * (utf8.len(var_70_2) / 25)) > 0 and var_70_0 < var_70_4 then
					arg_67_1.talkMaxDuration = var_70_4

					if var_70_4 + 0 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_4 + 0
					end
				end

				arg_67_1.text_.text = var_70_2
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320171", "320171016", "story_v_out_320171.awb") ~= 0 then
					local var_70_5 = manager.audio:GetVoiceLength("story_v_out_320171", "320171016", "story_v_out_320171.awb") / 1000

					if var_70_5 + 0 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_5 + 0
					end

					if var_70_1.prefab_name ~= "" and arg_67_1.actors_[var_70_1.prefab_name] ~= nil then
						local var_70_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_1.prefab_name].transform, "story_v_out_320171", "320171016", "story_v_out_320171.awb")

						arg_67_1:RecordAudio("320171016", var_70_6)
						arg_67_1:RecordAudio("320171016", var_70_6)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_320171", "320171016", "story_v_out_320171.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_320171", "320171016", "story_v_out_320171.awb")
				end

				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_7 = math.max(var_70_0, arg_67_1.talkMaxDuration)

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_7 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - 0) / var_70_7

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= 0 + var_70_7 and arg_67_1.time_ < 0 + var_70_7 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {}

		arg_67_1:InitPlayNodeList()
	end,
	Play320171017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 320171017
		arg_71_1.duration_ = 9.13

		local var_71_0 = {
			zh = 9.133,
			ja = 6
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
				arg_71_0:Play320171018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = 0.9

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				arg_71_1.leftNameTxt_.text = arg_71_1:FormatText(StoryNameCfg[1025].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, true)
				arg_71_1.iconController_:SetSelectedState("hero")

				arg_71_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_wrestlingboss")

				arg_71_1.callingController_:SetSelectedState("normal")

				arg_71_1.keyicon_.color = Color.New(1, 1, 1)
				arg_71_1.icon_.color = Color.New(1, 1, 1)

				local var_74_1 = arg_71_1:GetWordFromCfg(320171017)
				local var_74_2 = arg_71_1:FormatText(var_74_1.content)

				arg_71_1.text_.text = var_74_2

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_4 = 36 <= 0 and var_74_0 or var_74_0 * (utf8.len(var_74_2) / 36)

				if (36 <= 0 and var_74_0 or var_74_0 * (utf8.len(var_74_2) / 36)) > 0 and var_74_0 < var_74_4 then
					arg_71_1.talkMaxDuration = var_74_4

					if var_74_4 + 0 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_4 + 0
					end
				end

				arg_71_1.text_.text = var_74_2
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320171", "320171017", "story_v_out_320171.awb") ~= 0 then
					local var_74_5 = manager.audio:GetVoiceLength("story_v_out_320171", "320171017", "story_v_out_320171.awb") / 1000

					if var_74_5 + 0 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_5 + 0
					end

					if var_74_1.prefab_name ~= "" and arg_71_1.actors_[var_74_1.prefab_name] ~= nil then
						local var_74_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_1.prefab_name].transform, "story_v_out_320171", "320171017", "story_v_out_320171.awb")

						arg_71_1:RecordAudio("320171017", var_74_6)
						arg_71_1:RecordAudio("320171017", var_74_6)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_320171", "320171017", "story_v_out_320171.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_320171", "320171017", "story_v_out_320171.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_7 = math.max(var_74_0, arg_71_1.talkMaxDuration)

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_7 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - 0) / var_74_7

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= 0 + var_74_7 and arg_71_1.time_ < 0 + var_74_7 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {}

		arg_71_1:InitPlayNodeList()
	end,
	Play320171018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 320171018
		arg_75_1.duration_ = 5.6

		local var_75_0 = {
			zh = 3.766,
			ja = 5.6
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
				arg_75_0:Play320171019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_78_0 = 0.6

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_0 then
				local var_78_1, var_78_2 = math.modf((arg_75_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_78_2 * 0.13, var_78_2 * 0.13, var_78_2 * 0.13) + arg_75_1.var_.shakeOldPos
			end

			if arg_75_1.time_ >= 0 + var_78_0 and arg_75_1.time_ < 0 + var_78_0 + arg_78_0 then
				manager.ui.mainCamera.transform.localPosition = arg_75_1.var_.shakeOldPos
			end

			local var_78_3 = 0
			local var_78_4 = 0.45

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_3 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				arg_75_1.leftNameTxt_.text = arg_75_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_5 = arg_75_1:GetWordFromCfg(320171018)
				local var_78_6 = arg_75_1:FormatText(var_78_5.content)

				arg_75_1.text_.text = var_78_6

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_8 = 18 <= 0 and var_78_4 or var_78_4 * (utf8.len(var_78_6) / 18)

				if (18 <= 0 and var_78_4 or var_78_4 * (utf8.len(var_78_6) / 18)) > 0 and var_78_4 < var_78_8 then
					arg_75_1.talkMaxDuration = var_78_8

					if var_78_8 + var_78_3 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_8 + var_78_3
					end
				end

				arg_75_1.text_.text = var_78_6
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320171", "320171018", "story_v_out_320171.awb") ~= 0 then
					local var_78_9 = manager.audio:GetVoiceLength("story_v_out_320171", "320171018", "story_v_out_320171.awb") / 1000

					if var_78_9 + var_78_3 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_9 + var_78_3
					end

					if var_78_5.prefab_name ~= "" and arg_75_1.actors_[var_78_5.prefab_name] ~= nil then
						local var_78_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_5.prefab_name].transform, "story_v_out_320171", "320171018", "story_v_out_320171.awb")

						arg_75_1:RecordAudio("320171018", var_78_10)
						arg_75_1:RecordAudio("320171018", var_78_10)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_out_320171", "320171018", "story_v_out_320171.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_out_320171", "320171018", "story_v_out_320171.awb")
				end

				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_11 = math.max(var_78_4, arg_75_1.talkMaxDuration)

			if var_78_3 <= arg_75_1.time_ and arg_75_1.time_ < var_78_3 + var_78_11 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_3) / var_78_11

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_3 + var_78_11 and arg_75_1.time_ < var_78_3 + var_78_11 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play320171019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 320171019
		arg_79_1.duration_ = 6.43

		local var_79_0 = {
			zh = 2.533,
			ja = 6.433
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
				arg_79_0:Play320171020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = 0.275

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				arg_79_1.leftNameTxt_.text = arg_79_1:FormatText(StoryNameCfg[1025].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, true)
				arg_79_1.iconController_:SetSelectedState("hero")

				arg_79_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_wrestlingboss")

				arg_79_1.callingController_:SetSelectedState("normal")

				arg_79_1.keyicon_.color = Color.New(1, 1, 1)
				arg_79_1.icon_.color = Color.New(1, 1, 1)

				local var_82_1 = arg_79_1:GetWordFromCfg(320171019)
				local var_82_2 = arg_79_1:FormatText(var_82_1.content)

				arg_79_1.text_.text = var_82_2

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_4 = 11 <= 0 and var_82_0 or var_82_0 * (utf8.len(var_82_2) / 11)

				if (11 <= 0 and var_82_0 or var_82_0 * (utf8.len(var_82_2) / 11)) > 0 and var_82_0 < var_82_4 then
					arg_79_1.talkMaxDuration = var_82_4

					if var_82_4 + 0 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_4 + 0
					end
				end

				arg_79_1.text_.text = var_82_2
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320171", "320171019", "story_v_out_320171.awb") ~= 0 then
					local var_82_5 = manager.audio:GetVoiceLength("story_v_out_320171", "320171019", "story_v_out_320171.awb") / 1000

					if var_82_5 + 0 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_5 + 0
					end

					if var_82_1.prefab_name ~= "" and arg_79_1.actors_[var_82_1.prefab_name] ~= nil then
						local var_82_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_1.prefab_name].transform, "story_v_out_320171", "320171019", "story_v_out_320171.awb")

						arg_79_1:RecordAudio("320171019", var_82_6)
						arg_79_1:RecordAudio("320171019", var_82_6)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_out_320171", "320171019", "story_v_out_320171.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_out_320171", "320171019", "story_v_out_320171.awb")
				end

				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_7 = math.max(var_82_0, arg_79_1.talkMaxDuration)

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_7 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - 0) / var_82_7

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= 0 + var_82_7 and arg_79_1.time_ < 0 + var_82_7 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play320171020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 320171020
		arg_83_1.duration_ = 11.13

		local var_83_0 = {
			zh = 11.133,
			ja = 7.666
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
				arg_83_0:Play320171021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = 1.275

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				arg_83_1.leftNameTxt_.text = arg_83_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_1 = arg_83_1:GetWordFromCfg(320171020)
				local var_86_2 = arg_83_1:FormatText(var_86_1.content)

				arg_83_1.text_.text = var_86_2

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_4 = 51 <= 0 and var_86_0 or var_86_0 * (utf8.len(var_86_2) / 51)

				if (51 <= 0 and var_86_0 or var_86_0 * (utf8.len(var_86_2) / 51)) > 0 and var_86_0 < var_86_4 then
					arg_83_1.talkMaxDuration = var_86_4

					if var_86_4 + 0 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_4 + 0
					end
				end

				arg_83_1.text_.text = var_86_2
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320171", "320171020", "story_v_out_320171.awb") ~= 0 then
					local var_86_5 = manager.audio:GetVoiceLength("story_v_out_320171", "320171020", "story_v_out_320171.awb") / 1000

					if var_86_5 + 0 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_5 + 0
					end

					if var_86_1.prefab_name ~= "" and arg_83_1.actors_[var_86_1.prefab_name] ~= nil then
						local var_86_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_1.prefab_name].transform, "story_v_out_320171", "320171020", "story_v_out_320171.awb")

						arg_83_1:RecordAudio("320171020", var_86_6)
						arg_83_1:RecordAudio("320171020", var_86_6)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_out_320171", "320171020", "story_v_out_320171.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_out_320171", "320171020", "story_v_out_320171.awb")
				end

				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_7 = math.max(var_86_0, arg_83_1.talkMaxDuration)

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_7 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - 0) / var_86_7

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= 0 + var_86_7 and arg_83_1.time_ < 0 + var_86_7 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play320171021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 320171021
		arg_87_1.duration_ = 5

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play320171022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = 1.45

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, false)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_1 = arg_87_1:FormatText(arg_87_1:GetWordFromCfg(320171021).content)

				arg_87_1.text_.text = var_90_1

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_3 = 58 <= 0 and var_90_0 or var_90_0 * (utf8.len(var_90_1) / 58)

				if (58 <= 0 and var_90_0 or var_90_0 * (utf8.len(var_90_1) / 58)) > 0 and var_90_0 < var_90_3 then
					arg_87_1.talkMaxDuration = var_90_3

					if var_90_3 + 0 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_3 + 0
					end
				end

				arg_87_1.text_.text = var_90_1
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)
				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_4 = math.max(var_90_0, arg_87_1.talkMaxDuration)

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_4 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - 0) / var_90_4

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= 0 + var_90_4 and arg_87_1.time_ < 0 + var_90_4 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {}

		arg_87_1:InitPlayNodeList()
	end,
	Play320171022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 320171022
		arg_91_1.duration_ = 5.17

		local var_91_0 = {
			zh = 5.166,
			ja = 4.133
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
				arg_91_0:Play320171023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			local var_94_0 = 0.675

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				arg_91_1.leftNameTxt_.text = arg_91_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_1 = arg_91_1:GetWordFromCfg(320171022)
				local var_94_2 = arg_91_1:FormatText(var_94_1.content)

				arg_91_1.text_.text = var_94_2

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_4 = 27 <= 0 and var_94_0 or var_94_0 * (utf8.len(var_94_2) / 27)

				if (27 <= 0 and var_94_0 or var_94_0 * (utf8.len(var_94_2) / 27)) > 0 and var_94_0 < var_94_4 then
					arg_91_1.talkMaxDuration = var_94_4

					if var_94_4 + 0 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_4 + 0
					end
				end

				arg_91_1.text_.text = var_94_2
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320171", "320171022", "story_v_out_320171.awb") ~= 0 then
					local var_94_5 = manager.audio:GetVoiceLength("story_v_out_320171", "320171022", "story_v_out_320171.awb") / 1000

					if var_94_5 + 0 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_5 + 0
					end

					if var_94_1.prefab_name ~= "" and arg_91_1.actors_[var_94_1.prefab_name] ~= nil then
						local var_94_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_1.prefab_name].transform, "story_v_out_320171", "320171022", "story_v_out_320171.awb")

						arg_91_1:RecordAudio("320171022", var_94_6)
						arg_91_1:RecordAudio("320171022", var_94_6)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_out_320171", "320171022", "story_v_out_320171.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_out_320171", "320171022", "story_v_out_320171.awb")
				end

				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_7 = math.max(var_94_0, arg_91_1.talkMaxDuration)

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_7 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - 0) / var_94_7

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= 0 + var_94_7 and arg_91_1.time_ < 0 + var_94_7 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {}

		arg_91_1:InitPlayNodeList()
	end,
	Play320171023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 320171023
		arg_95_1.duration_ = 11.97

		local var_95_0 = {
			zh = 11.966,
			ja = 9.9
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
				arg_95_0:Play320171024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1.allBtn_.enabled = false
			end

			if arg_95_1.time_ >= 0 + 2.63333333333333 and arg_95_1.time_ < 0 + 2.63333333333333 + arg_98_0 then
				arg_95_1.allBtn_.enabled = true
			end

			local var_98_0 = 0

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= var_98_0 + arg_98_0 then
				arg_95_1.mask_.enabled = true
				arg_95_1.mask_.raycastTarget = true

				arg_95_1:SetGaussion(false)
			end

			local var_98_1 = 1

			if var_98_0 <= arg_95_1.time_ and arg_95_1.time_ < var_98_0 + var_98_1 then
				local var_98_2 = Color.New(0, 0, 0)

				var_98_2.a = Mathf.Lerp(0, 1, (arg_95_1.time_ - var_98_0) / var_98_1)
				arg_95_1.mask_.color = var_98_2
			end

			if arg_95_1.time_ >= var_98_0 + var_98_1 and arg_95_1.time_ < var_98_0 + var_98_1 + arg_98_0 then
				local var_98_3 = Color.New(0, 0, 0)

				var_98_3.a = 1
				arg_95_1.mask_.color = var_98_3
			end

			local var_98_4 = 1

			if 1 < arg_95_1.time_ and arg_95_1.time_ <= var_98_4 + arg_98_0 then
				arg_95_1.mask_.enabled = true
				arg_95_1.mask_.raycastTarget = true

				arg_95_1:SetGaussion(false)
			end

			local var_98_5 = 1

			if var_98_4 <= arg_95_1.time_ and arg_95_1.time_ < var_98_4 + var_98_5 then
				local var_98_6 = Color.New(0, 0, 0)

				var_98_6.a = Mathf.Lerp(1, 0, (arg_95_1.time_ - var_98_4) / var_98_5)
				arg_95_1.mask_.color = var_98_6
			end

			if arg_95_1.time_ >= var_98_4 + var_98_5 and arg_95_1.time_ < var_98_4 + var_98_5 + arg_98_0 then
				local var_98_7 = Color.New(0, 0, 0)

				arg_95_1.mask_.enabled = false
				var_98_7.a = 0
				arg_95_1.mask_.color = var_98_7
			end

			local var_98_8 = arg_95_1.bgs_.XS0105.transform

			if 1 < arg_95_1.time_ and arg_95_1.time_ <= 1 + arg_98_0 then
				arg_95_1.var_.moveOldPosXS0105 = var_98_8.localPosition
			end

			local var_98_9 = 0.001

			if 1 <= arg_95_1.time_ and arg_95_1.time_ < 1 + var_98_9 then
				var_98_8.localPosition = Vector3.Lerp(arg_95_1.var_.moveOldPosXS0105, Vector3.New(2, 0, 5), (arg_95_1.time_ - 1) / var_98_9)
			end

			if arg_95_1.time_ >= 1 + var_98_9 and arg_95_1.time_ < 1 + var_98_9 + arg_98_0 then
				var_98_8.localPosition = Vector3.New(2, 0, 5)
			end

			local var_98_10 = arg_95_1.bgs_.XS0105.transform

			if 1.01666666666667 < arg_95_1.time_ and arg_95_1.time_ <= 1.01666666666667 + arg_98_0 then
				arg_95_1.var_.moveOldPosXS0105 = var_98_10.localPosition
			end

			local var_98_11 = 2.4

			if 1.01666666666667 <= arg_95_1.time_ and arg_95_1.time_ < 1.01666666666667 + var_98_11 then
				var_98_10.localPosition = Vector3.Lerp(arg_95_1.var_.moveOldPosXS0105, Vector3.New(2, 0, 4.5), (arg_95_1.time_ - 1.01666666666667) / var_98_11)
			end

			if arg_95_1.time_ >= 1.01666666666667 + var_98_11 and arg_95_1.time_ < 1.01666666666667 + var_98_11 + arg_98_0 then
				var_98_10.localPosition = Vector3.New(2, 0, 4.5)
			end

			if arg_95_1.frameCnt_ <= 1 then
				arg_95_1.dialog_:SetActive(false)
			end

			local var_98_12 = 2
			local var_98_13 = 1.025

			if 2 < arg_95_1.time_ and arg_95_1.time_ <= var_98_12 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0

				arg_95_1.dialog_:SetActive(true)

				arg_95_1.dialogCg_.alpha = 0

				local var_98_14 = LeanTween.value(arg_95_1.dialog_, 0, 1, 0.3)

				var_98_14:setOnUpdate(LuaHelper.FloatAction(function(arg_99_0)
					arg_95_1.dialogCg_.alpha = arg_99_0
				end))
				var_98_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_95_1.dialog_)
					var_98_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_95_1.duration_ = arg_95_1.duration_ + 0.3

				SetActive(arg_95_1.leftNameGo_, true)

				arg_95_1.leftNameTxt_.text = arg_95_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_15 = arg_95_1:GetWordFromCfg(320171023)
				local var_98_16 = arg_95_1:FormatText(var_98_15.content)

				arg_95_1.text_.text = var_98_16

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_18 = 41 <= 0 and var_98_13 or var_98_13 * (utf8.len(var_98_16) / 41)

				if (41 <= 0 and var_98_13 or var_98_13 * (utf8.len(var_98_16) / 41)) > 0 and var_98_13 < var_98_18 then
					arg_95_1.talkMaxDuration = var_98_18
					var_98_12 = var_98_12 + 0.3

					if var_98_18 + var_98_12 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_18 + var_98_12
					end
				end

				arg_95_1.text_.text = var_98_16
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320171", "320171023", "story_v_out_320171.awb") ~= 0 then
					local var_98_19 = manager.audio:GetVoiceLength("story_v_out_320171", "320171023", "story_v_out_320171.awb") / 1000

					if var_98_19 + var_98_12 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_19 + var_98_12
					end

					if var_98_15.prefab_name ~= "" and arg_95_1.actors_[var_98_15.prefab_name] ~= nil then
						local var_98_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_95_1.actors_[var_98_15.prefab_name].transform, "story_v_out_320171", "320171023", "story_v_out_320171.awb")

						arg_95_1:RecordAudio("320171023", var_98_20)
						arg_95_1:RecordAudio("320171023", var_98_20)
					else
						arg_95_1:AudioAction("play", "voice", "story_v_out_320171", "320171023", "story_v_out_320171.awb")
					end

					arg_95_1:RecordHistoryTalkVoice("story_v_out_320171", "320171023", "story_v_out_320171.awb")
				end

				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_21 = var_98_12 + 0.3
			local var_98_22 = math.max(var_98_13, arg_95_1.talkMaxDuration)

			if var_98_12 + 0.3 <= arg_95_1.time_ and arg_95_1.time_ < var_98_21 + var_98_22 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_21) / var_98_22

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_21 + var_98_22 and arg_95_1.time_ < var_98_21 + var_98_22 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "XS0105",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "XS0105",
				changeDisplayLayer = false,
				needEase = false,
				duration = 2.4,
				className = "StoryMoveNode",
				startTime = 1.01666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_95_1:InitPlayNodeList()
	end,
	Play320171024 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 320171024
		arg_101_1.duration_ = 5

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play320171025(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = 1.1

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, false)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_1 = arg_101_1:FormatText(arg_101_1:GetWordFromCfg(320171024).content)

				arg_101_1.text_.text = var_104_1

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_3 = 44 <= 0 and var_104_0 or var_104_0 * (utf8.len(var_104_1) / 44)

				if (44 <= 0 and var_104_0 or var_104_0 * (utf8.len(var_104_1) / 44)) > 0 and var_104_0 < var_104_3 then
					arg_101_1.talkMaxDuration = var_104_3

					if var_104_3 + 0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_3 + 0
					end
				end

				arg_101_1.text_.text = var_104_1
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)
				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_4 = math.max(var_104_0, arg_101_1.talkMaxDuration)

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_4 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - 0) / var_104_4

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= 0 + var_104_4 and arg_101_1.time_ < 0 + var_104_4 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play320171025 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 320171025
		arg_105_1.duration_ = 5

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play320171026(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = 0.925

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, false)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_1 = arg_105_1:FormatText(arg_105_1:GetWordFromCfg(320171025).content)

				arg_105_1.text_.text = var_108_1

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_3 = 37 <= 0 and var_108_0 or var_108_0 * (utf8.len(var_108_1) / 37)

				if (37 <= 0 and var_108_0 or var_108_0 * (utf8.len(var_108_1) / 37)) > 0 and var_108_0 < var_108_3 then
					arg_105_1.talkMaxDuration = var_108_3

					if var_108_3 + 0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_3 + 0
					end
				end

				arg_105_1.text_.text = var_108_1
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)
				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_4 = math.max(var_108_0, arg_105_1.talkMaxDuration)

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_4 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - 0) / var_108_4

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= 0 + var_108_4 and arg_105_1.time_ < 0 + var_108_4 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play320171026 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 320171026
		arg_109_1.duration_ = 6.83

		local var_109_0 = {
			zh = 3.6,
			ja = 6.833
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
				arg_109_0:Play320171027(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = 0.425

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, true)
				arg_109_1.iconController_:SetSelectedState("hero")

				arg_109_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1020")

				arg_109_1.callingController_:SetSelectedState("normal")

				arg_109_1.keyicon_.color = Color.New(1, 1, 1)
				arg_109_1.icon_.color = Color.New(1, 1, 1)

				local var_112_1 = arg_109_1:GetWordFromCfg(320171026)
				local var_112_2 = arg_109_1:FormatText(var_112_1.content)

				arg_109_1.text_.text = var_112_2

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_4 = 17 <= 0 and var_112_0 or var_112_0 * (utf8.len(var_112_2) / 17)

				if (17 <= 0 and var_112_0 or var_112_0 * (utf8.len(var_112_2) / 17)) > 0 and var_112_0 < var_112_4 then
					arg_109_1.talkMaxDuration = var_112_4

					if var_112_4 + 0 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_4 + 0
					end
				end

				arg_109_1.text_.text = var_112_2
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320171", "320171026", "story_v_out_320171.awb") ~= 0 then
					local var_112_5 = manager.audio:GetVoiceLength("story_v_out_320171", "320171026", "story_v_out_320171.awb") / 1000

					if var_112_5 + 0 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_5 + 0
					end

					if var_112_1.prefab_name ~= "" and arg_109_1.actors_[var_112_1.prefab_name] ~= nil then
						local var_112_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_1.prefab_name].transform, "story_v_out_320171", "320171026", "story_v_out_320171.awb")

						arg_109_1:RecordAudio("320171026", var_112_6)
						arg_109_1:RecordAudio("320171026", var_112_6)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_320171", "320171026", "story_v_out_320171.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_320171", "320171026", "story_v_out_320171.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_7 = math.max(var_112_0, arg_109_1.talkMaxDuration)

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_7 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - 0) / var_112_7

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= 0 + var_112_7 and arg_109_1.time_ < 0 + var_112_7 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play320171027 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 320171027
		arg_113_1.duration_ = 9

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play320171028(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_9001
			local var_116_9000

			if arg_113_1.bgs_.L07i == nil then
				local var_116_0 = Object.Instantiate(arg_113_1.paintGo_)

				var_116_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "L07i")
				var_116_0.name = "L07i"
				var_116_0.transform.parent = arg_113_1.stage_.transform
				var_116_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_113_1.bgs_.L07i = var_116_0
			end

			if 1.999999999999 < arg_113_1.time_ and arg_113_1.time_ <= 1.999999999999 + arg_116_0 then
				local var_116_1 = arg_113_1.bgs_.L07i

				arg_113_1.bgs_.L07i.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_116_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_116_2 = var_116_1:GetComponent("SpriteRenderer")

				if var_116_2 and var_116_2.sprite then
					local var_116_3 = 2 * (var_116_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_116_1.transform.localScale = Vector3.New(var_116_3 / var_116_2.sprite.bounds.size.y < var_116_3 * manager.ui.mainCameraCom_.aspect / var_116_2.sprite.bounds.size.x and var_116_3 * manager.ui.mainCameraCom_.aspect / var_116_2.sprite.bounds.size.x or var_116_3 / var_116_2.sprite.bounds.size.y, var_116_3 / var_116_2.sprite.bounds.size.y < var_116_3 * manager.ui.mainCameraCom_.aspect / var_116_2.sprite.bounds.size.x and var_116_3 * manager.ui.mainCameraCom_.aspect / var_116_2.sprite.bounds.size.x or var_116_3 / var_116_2.sprite.bounds.size.y, 0)
				end

				for iter_116_0, iter_116_1 in pairs(arg_113_1.bgs_) do
					if iter_116_0 ~= "L07i" then
						iter_116_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_116_4 = 3.999999999999

			if 3.999999999999 < arg_113_1.time_ and arg_113_1.time_ <= var_116_4 + arg_116_0 then
				arg_113_1.allBtn_.enabled = false
			end

			if arg_113_1.time_ >= var_116_4 + 0.3 and arg_113_1.time_ < var_116_4 + 0.3 + arg_116_0 then
				arg_113_1.allBtn_.enabled = true
			end

			local var_116_5 = 0

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_5 + arg_116_0 then
				arg_113_1.mask_.enabled = true
				arg_113_1.mask_.raycastTarget = true

				arg_113_1:SetGaussion(false)
			end

			local var_116_6 = 2

			if var_116_5 <= arg_113_1.time_ and arg_113_1.time_ < var_116_5 + var_116_6 then
				local var_116_7 = Color.New(0, 0, 0)

				var_116_7.a = Mathf.Lerp(0, 1, (arg_113_1.time_ - var_116_5) / var_116_6)
				arg_113_1.mask_.color = var_116_7
			end

			if arg_113_1.time_ >= var_116_5 + var_116_6 and arg_113_1.time_ < var_116_5 + var_116_6 + arg_116_0 then
				local var_116_8 = Color.New(0, 0, 0)

				var_116_8.a = 1
				arg_113_1.mask_.color = var_116_8
			end

			local var_116_9 = 2

			if 2 < arg_113_1.time_ and arg_113_1.time_ <= var_116_9 + arg_116_0 then
				arg_113_1.mask_.enabled = true
				arg_113_1.mask_.raycastTarget = true

				arg_113_1:SetGaussion(false)
			end

			local var_116_10 = 2

			if var_116_9 <= arg_113_1.time_ and arg_113_1.time_ < var_116_9 + var_116_10 then
				local var_116_11 = Color.New(0, 0, 0)

				var_116_11.a = Mathf.Lerp(1, 0, (arg_113_1.time_ - var_116_9) / var_116_10)
				arg_113_1.mask_.color = var_116_11
			end

			if arg_113_1.time_ >= var_116_9 + var_116_10 and arg_113_1.time_ < var_116_9 + var_116_10 + arg_116_0 then
				local var_116_12 = Color.New(0, 0, 0)

				arg_113_1.mask_.enabled = false
				var_116_12.a = 0
				arg_113_1.mask_.color = var_116_12
			end

			if 2 < arg_113_1.time_ and arg_113_1.time_ <= 2 + arg_116_0 then
				local var_116_13 = arg_113_1.var_.effectxiayu18

				if not arg_113_1.var_.effectxiayu18 then
					var_116_13 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_rain_heavy"), manager.ui.mainCamera.transform)
					var_116_13.name = "xiayu18"
					arg_113_1.var_.effectxiayu18 = var_116_13
				else
					var_116_13.transform:SetParent(var_116_9001)
				end

				var_116_13.transform.localPosition = Vector3.New(0, 0, 0)
				var_116_13.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_116_17 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_113_1.bgmTxt_.text ~= var_116_17 and arg_113_1.bgmTxt_.text ~= "" then
						if arg_113_1.bgmTxt2_.text ~= "" then
							arg_113_1.bgmTxt_.text = arg_113_1.bgmTxt2_.text
						end

						arg_113_1.bgmTxt2_.text = var_116_17

						arg_113_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_113_1.bgmTxt_.text = var_116_17
						arg_113_1.bgmTxt2_.text = var_116_17
					end

					if arg_113_1.bgmTimer then
						arg_113_1.bgmTimer:Stop()

						arg_113_1.bgmTimer = nil
					end

					if arg_113_1.settingData.show_music_name == 1 then
						arg_113_1.musicController:SetSelectedState("show")
						arg_113_1.musicAnimator_:Play("open", 0, 0)

						if arg_113_1.settingData.music_time ~= 0 then
							arg_113_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_113_1.settingData.music_time), function()
								if arg_113_1 == nil or isNil(arg_113_1.bgmTxt_) then
									return
								end

								arg_113_1.musicController:SetSelectedState("hide")
								arg_113_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 1.16666666666667 < arg_113_1.time_ and arg_113_1.time_ <= 1.16666666666667 + arg_116_0 then
				arg_113_1:AudioAction("play", "music", "bgm_activity_3_6_story_new_industry", "bgm_activity_3_6_story_new_industry", "bgm_activity_3_6_story_new_industry.awb")

				local var_116_20 = manager.audio:GetAudioName("bgm_activity_3_6_story_new_industry", "bgm_activity_3_6_story_new_industry")

				if "" ~= "" then
					if arg_113_1.bgmTxt_.text ~= var_116_20 and arg_113_1.bgmTxt_.text ~= "" then
						if arg_113_1.bgmTxt2_.text ~= "" then
							arg_113_1.bgmTxt_.text = arg_113_1.bgmTxt2_.text
						end

						arg_113_1.bgmTxt2_.text = var_116_20

						arg_113_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_113_1.bgmTxt_.text = var_116_20
						arg_113_1.bgmTxt2_.text = var_116_20
					end

					if arg_113_1.bgmTimer then
						arg_113_1.bgmTimer:Stop()

						arg_113_1.bgmTimer = nil
					end

					if arg_113_1.settingData.show_music_name == 1 then
						arg_113_1.musicController:SetSelectedState("show")
						arg_113_1.musicAnimator_:Play("open", 0, 0)

						if arg_113_1.settingData.music_time ~= 0 then
							arg_113_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_113_1.settingData.music_time), function()
								if arg_113_1 == nil or isNil(arg_113_1.bgmTxt_) then
									return
								end

								arg_113_1.musicController:SetSelectedState("hide")
								arg_113_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 2 < arg_113_1.time_ and arg_113_1.time_ <= 2 + arg_116_0 then
				if arg_113_1.var_.effectjialidayu1 then
					Object.Destroy(arg_113_1.var_.effectjialidayu1)

					arg_113_1.var_.effectjialidayu1 = nil
				end
			end

			if 2 < arg_113_1.time_ and arg_113_1.time_ <= 2 + arg_116_0 then
				if arg_113_1.var_.effectjialidayu2 then
					Object.Destroy(arg_113_1.var_.effectjialidayu2)

					arg_113_1.var_.effectjialidayu2 = nil
				end
			end

			if 2 < arg_113_1.time_ and arg_113_1.time_ <= 2 + arg_116_0 then
				local var_116_23 = arg_113_1.var_.effectxiayu19

				if not arg_113_1.var_.effectxiayu19 then
					var_116_23 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_rain_light_ui"), manager.ui.mainCamera.transform)
					var_116_23.name = "xiayu19"
					arg_113_1.var_.effectxiayu19 = var_116_23
				else
					var_116_23.transform:SetParent(var_116_9000)
				end

				var_116_23.transform.localPosition = Vector3.New(0, 0, 0)
				var_116_23.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_116_25 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_116_26 = var_116_23.transform:GetComponentsInChildren(typeof(Transform), true)

				for iter_116_2, iter_116_3 in ipairs((var_116_26:ToTable())) do
					iter_116_3.transform.localScale = Vector3.New(iter_116_3.transform.localScale.x / var_116_25 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * var_116_26 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_116_3.transform.localScale.y / var_116_25, iter_116_3.transform.localScale.z)
				end
			end

			if arg_113_1.frameCnt_ <= 1 then
				arg_113_1.dialog_:SetActive(false)
			end

			local var_116_28 = 3.999999999999
			local var_116_29 = 1.275

			if 3.999999999999 < arg_113_1.time_ and arg_113_1.time_ <= var_116_28 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0

				arg_113_1.dialog_:SetActive(true)

				arg_113_1.dialogCg_.alpha = 0

				local var_116_30 = LeanTween.value(arg_113_1.dialog_, 0, 1, 0.3)

				var_116_30:setOnUpdate(LuaHelper.FloatAction(function(arg_119_0)
					arg_113_1.dialogCg_.alpha = arg_119_0
				end))
				var_116_30:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_113_1.dialog_)
					var_116_30:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_113_1.duration_ = arg_113_1.duration_ + 0.3

				SetActive(arg_113_1.leftNameGo_, false)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_31 = arg_113_1:FormatText(arg_113_1:GetWordFromCfg(320171027).content)

				arg_113_1.text_.text = var_116_31

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_33 = 51 <= 0 and var_116_29 or var_116_29 * (utf8.len(var_116_31) / 51)

				if (51 <= 0 and var_116_29 or var_116_29 * (utf8.len(var_116_31) / 51)) > 0 and var_116_29 < var_116_33 then
					arg_113_1.talkMaxDuration = var_116_33
					var_116_28 = var_116_28 + 0.3

					if var_116_33 + var_116_28 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_33 + var_116_28
					end
				end

				arg_113_1.text_.text = var_116_31
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)
				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_34 = var_116_28 + 0.3
			local var_116_35 = math.max(var_116_29, arg_113_1.talkMaxDuration)

			if var_116_28 + 0.3 <= arg_113_1.time_ and arg_113_1.time_ < var_116_34 + var_116_35 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_34) / var_116_35

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_34 + var_116_35 and arg_113_1.time_ < var_116_34 + var_116_35 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play320171028 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 320171028
		arg_121_1.duration_ = 5

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play320171029(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = 1.625

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, false)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_1 = arg_121_1:FormatText(arg_121_1:GetWordFromCfg(320171028).content)

				arg_121_1.text_.text = var_124_1

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_3 = 65 <= 0 and var_124_0 or var_124_0 * (utf8.len(var_124_1) / 65)

				if (65 <= 0 and var_124_0 or var_124_0 * (utf8.len(var_124_1) / 65)) > 0 and var_124_0 < var_124_3 then
					arg_121_1.talkMaxDuration = var_124_3

					if var_124_3 + 0 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_3 + 0
					end
				end

				arg_121_1.text_.text = var_124_1
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)
				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_4 = math.max(var_124_0, arg_121_1.talkMaxDuration)

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_4 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - 0) / var_124_4

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= 0 + var_124_4 and arg_121_1.time_ < 0 + var_124_4 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play320171029 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 320171029
		arg_125_1.duration_ = 10.47

		local var_125_0 = {
			zh = 5.7,
			ja = 10.466
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
				arg_125_0:Play320171030(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			if arg_125_1.actors_["1156ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1156ui_story"))) then
				local var_128_0 = Object.Instantiate(Asset.Load("Char/" .. "1156ui_story"), arg_125_1.stage_.transform)

				var_128_0.name = "1156ui_story"
				var_128_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_125_1.actors_["1156ui_story"] = var_128_0

				local var_128_1 = var_128_0:GetComponentInChildren(typeof(CharacterEffect))

				var_128_1.enabled = true

				local var_128_2 = GameObjectTools.GetOrAddComponent(var_128_0, typeof(DynamicBoneHelper))

				if var_128_2 then
					var_128_2:EnableDynamicBone(false)
				end

				arg_125_1:ShowWeapon(var_128_1.transform, false)

				arg_125_1.var_["1156ui_story" .. "Animator"] = var_128_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_125_1.var_["1156ui_story" .. "Animator"].applyRootMotion = true
				arg_125_1.var_["1156ui_story" .. "LipSync"] = var_128_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_128_3 = arg_125_1.actors_["1156ui_story"].transform

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.var_.moveOldPos1156ui_story = var_128_3.localPosition
			end

			local var_128_4 = 0.001

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_4 then
				var_128_3.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos1156ui_story, Vector3.New(0, -1.1, -6.18), (arg_125_1.time_ - 0) / var_128_4)
				var_128_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_128_3.position).x, (manager.ui.mainCamera.transform.position - var_128_3.position).y, (manager.ui.mainCamera.transform.position - var_128_3.position).z)
				var_128_3.localEulerAngles.z = 0
				var_128_3.localEulerAngles.x = 0
				var_128_3.localEulerAngles = var_128_3.localEulerAngles
			end

			if arg_125_1.time_ >= 0 + var_128_4 and arg_125_1.time_ < 0 + var_128_4 + arg_128_0 then
				var_128_3.localPosition = Vector3.New(0, -1.1, -6.18)
				var_128_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_128_3.position).x, (manager.ui.mainCamera.transform.position - var_128_3.position).y, (manager.ui.mainCamera.transform.position - var_128_3.position).z)
				var_128_3.localEulerAngles.z = 0
				var_128_3.localEulerAngles.x = 0
				var_128_3.localEulerAngles = var_128_3.localEulerAngles
			end

			local var_128_5 = arg_125_1.actors_["1156ui_story"]

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(var_128_5) and arg_125_1.var_.characterEffect1156ui_story == nil then
				arg_125_1.var_.characterEffect1156ui_story = var_128_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_6 = 0.200000002980232

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_6 and not isNil(var_128_5) then
				if arg_125_1.var_.characterEffect1156ui_story and not isNil(var_128_5) then
					arg_125_1.var_.characterEffect1156ui_story.fillFlat = false
				end
			end

			if arg_125_1.time_ >= 0 + var_128_6 and arg_125_1.time_ < 0 + var_128_6 + arg_128_0 and not isNil(var_128_5) and arg_125_1.var_.characterEffect1156ui_story then
				arg_125_1.var_.characterEffect1156ui_story.fillFlat = false
			end

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/story1156/story1156action/1156action1_1")
			end

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_128_8 = 0
			local var_128_9 = 0.625

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_8 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				arg_125_1.leftNameTxt_.text = arg_125_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_10 = arg_125_1:GetWordFromCfg(320171029)
				local var_128_11 = arg_125_1:FormatText(var_128_10.content)

				arg_125_1.text_.text = var_128_11

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_13 = 25 <= 0 and var_128_9 or var_128_9 * (utf8.len(var_128_11) / 25)

				if (25 <= 0 and var_128_9 or var_128_9 * (utf8.len(var_128_11) / 25)) > 0 and var_128_9 < var_128_13 then
					arg_125_1.talkMaxDuration = var_128_13

					if var_128_13 + var_128_8 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_13 + var_128_8
					end
				end

				arg_125_1.text_.text = var_128_11
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320171", "320171029", "story_v_out_320171.awb") ~= 0 then
					local var_128_14 = manager.audio:GetVoiceLength("story_v_out_320171", "320171029", "story_v_out_320171.awb") / 1000

					if var_128_14 + var_128_8 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_14 + var_128_8
					end

					if var_128_10.prefab_name ~= "" and arg_125_1.actors_[var_128_10.prefab_name] ~= nil then
						local var_128_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_10.prefab_name].transform, "story_v_out_320171", "320171029", "story_v_out_320171.awb")

						arg_125_1:RecordAudio("320171029", var_128_15)
						arg_125_1:RecordAudio("320171029", var_128_15)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_320171", "320171029", "story_v_out_320171.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_320171", "320171029", "story_v_out_320171.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_16 = math.max(var_128_9, arg_125_1.talkMaxDuration)

			if var_128_8 <= arg_125_1.time_ and arg_125_1.time_ < var_128_8 + var_128_16 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_8) / var_128_16

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_8 + var_128_16 and arg_125_1.time_ < var_128_8 + var_128_16 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1156ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_125_1:InitPlayNodeList()
	end,
	Play320171030 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 320171030
		arg_129_1.duration_ = 3.1

		local var_129_0 = {
			zh = 3.1,
			ja = 2.333
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
				arg_129_0:Play320171031(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 and not isNil(arg_129_1.actors_["1156ui_story"]) and arg_129_1.var_.characterEffect1156ui_story == nil then
				arg_129_1.var_.characterEffect1156ui_story = arg_129_1.actors_["1156ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_0 = 0.200000002980232

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_0 and not isNil(arg_129_1.actors_["1156ui_story"]) then
				if arg_129_1.var_.characterEffect1156ui_story and not isNil(arg_129_1.actors_["1156ui_story"]) then
					arg_129_1.var_.characterEffect1156ui_story.fillFlat = true
					arg_129_1.var_.characterEffect1156ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_129_1.time_ - 0) / var_132_0)
				end
			end

			if arg_129_1.time_ >= 0 + var_132_0 and arg_129_1.time_ < 0 + var_132_0 + arg_132_0 and not isNil(arg_129_1.actors_["1156ui_story"]) and arg_129_1.var_.characterEffect1156ui_story then
				arg_129_1.var_.characterEffect1156ui_story.fillFlat = true
				arg_129_1.var_.characterEffect1156ui_story.fillRatio = 0.5
			end

			local var_132_1 = 0
			local var_132_2 = 0.175

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_1 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				arg_129_1.leftNameTxt_.text = arg_129_1:FormatText(StoryNameCfg[1032].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, true)
				arg_129_1.iconController_:SetSelectedState("hero")

				arg_129_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_gangstera")

				arg_129_1.callingController_:SetSelectedState("normal")

				arg_129_1.keyicon_.color = Color.New(1, 1, 1)
				arg_129_1.icon_.color = Color.New(1, 1, 1)

				local var_132_3 = arg_129_1:GetWordFromCfg(320171030)
				local var_132_4 = arg_129_1:FormatText(var_132_3.content)

				arg_129_1.text_.text = var_132_4

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_6 = 7 <= 0 and var_132_2 or var_132_2 * (utf8.len(var_132_4) / 7)

				if (7 <= 0 and var_132_2 or var_132_2 * (utf8.len(var_132_4) / 7)) > 0 and var_132_2 < var_132_6 then
					arg_129_1.talkMaxDuration = var_132_6

					if var_132_6 + var_132_1 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_6 + var_132_1
					end
				end

				arg_129_1.text_.text = var_132_4
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320171", "320171030", "story_v_out_320171.awb") ~= 0 then
					local var_132_7 = manager.audio:GetVoiceLength("story_v_out_320171", "320171030", "story_v_out_320171.awb") / 1000

					if var_132_7 + var_132_1 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_7 + var_132_1
					end

					if var_132_3.prefab_name ~= "" and arg_129_1.actors_[var_132_3.prefab_name] ~= nil then
						local var_132_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_3.prefab_name].transform, "story_v_out_320171", "320171030", "story_v_out_320171.awb")

						arg_129_1:RecordAudio("320171030", var_132_8)
						arg_129_1:RecordAudio("320171030", var_132_8)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_320171", "320171030", "story_v_out_320171.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_320171", "320171030", "story_v_out_320171.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_9 = math.max(var_132_2, arg_129_1.talkMaxDuration)

			if var_132_1 <= arg_129_1.time_ and arg_129_1.time_ < var_132_1 + var_132_9 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_1) / var_132_9

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_1 + var_132_9 and arg_129_1.time_ < var_132_1 + var_132_9 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play320171031 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 320171031
		arg_133_1.duration_ = 5

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play320171032(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1.var_.moveOldPos1156ui_story = arg_133_1.actors_["1156ui_story"].transform.localPosition
			end

			local var_136_0 = 0.001

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_0 then
				arg_133_1.actors_["1156ui_story"].transform.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos1156ui_story, Vector3.New(0, 100, 0), (arg_133_1.time_ - 0) / var_136_0)
				arg_133_1.actors_["1156ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_133_1.actors_["1156ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["1156ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["1156ui_story"].transform.position).z)
				arg_133_1.actors_["1156ui_story"].transform.localEulerAngles.z = 0
				arg_133_1.actors_["1156ui_story"].transform.localEulerAngles.x = 0
				arg_133_1.actors_["1156ui_story"].transform.localEulerAngles = arg_133_1.actors_["1156ui_story"].transform.localEulerAngles
			end

			if arg_133_1.time_ >= 0 + var_136_0 and arg_133_1.time_ < 0 + var_136_0 + arg_136_0 then
				arg_133_1.actors_["1156ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_133_1.actors_["1156ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_133_1.actors_["1156ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["1156ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["1156ui_story"].transform.position).z)
				arg_133_1.actors_["1156ui_story"].transform.localEulerAngles.z = 0
				arg_133_1.actors_["1156ui_story"].transform.localEulerAngles.x = 0
				arg_133_1.actors_["1156ui_story"].transform.localEulerAngles = arg_133_1.actors_["1156ui_story"].transform.localEulerAngles
			end

			local var_136_1 = arg_133_1.actors_["1156ui_story"]

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 and not isNil(var_136_1) and arg_133_1.var_.characterEffect1156ui_story == nil then
				arg_133_1.var_.characterEffect1156ui_story = var_136_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_2 = 0.200000002980232

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_2 and not isNil(var_136_1) then
				if arg_133_1.var_.characterEffect1156ui_story and not isNil(var_136_1) then
					arg_133_1.var_.characterEffect1156ui_story.fillFlat = true
					arg_133_1.var_.characterEffect1156ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_133_1.time_ - 0) / var_136_2)
				end
			end

			if arg_133_1.time_ >= 0 + var_136_2 and arg_133_1.time_ < 0 + var_136_2 + arg_136_0 and not isNil(var_136_1) and arg_133_1.var_.characterEffect1156ui_story then
				arg_133_1.var_.characterEffect1156ui_story.fillFlat = true
				arg_133_1.var_.characterEffect1156ui_story.fillRatio = 0.5
			end

			local var_136_3 = 0
			local var_136_4 = 1.075

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_3 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, false)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_5 = arg_133_1:FormatText(arg_133_1:GetWordFromCfg(320171031).content)

				arg_133_1.text_.text = var_136_5

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_7 = 43 <= 0 and var_136_4 or var_136_4 * (utf8.len(var_136_5) / 43)

				if (43 <= 0 and var_136_4 or var_136_4 * (utf8.len(var_136_5) / 43)) > 0 and var_136_4 < var_136_7 then
					arg_133_1.talkMaxDuration = var_136_7

					if var_136_7 + var_136_3 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_7 + var_136_3
					end
				end

				arg_133_1.text_.text = var_136_5
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)
				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_8 = math.max(var_136_4, arg_133_1.talkMaxDuration)

			if var_136_3 <= arg_133_1.time_ and arg_133_1.time_ < var_136_3 + var_136_8 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_3) / var_136_8

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_3 + var_136_8 and arg_133_1.time_ < var_136_3 + var_136_8 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1156ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_133_1:InitPlayNodeList()
	end,
	Play320171032 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 320171032
		arg_137_1.duration_ = 5

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play320171033(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = 0.975

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, false)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_1 = arg_137_1:FormatText(arg_137_1:GetWordFromCfg(320171032).content)

				arg_137_1.text_.text = var_140_1

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_3 = 39 <= 0 and var_140_0 or var_140_0 * (utf8.len(var_140_1) / 39)

				if (39 <= 0 and var_140_0 or var_140_0 * (utf8.len(var_140_1) / 39)) > 0 and var_140_0 < var_140_3 then
					arg_137_1.talkMaxDuration = var_140_3

					if var_140_3 + 0 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_3 + 0
					end
				end

				arg_137_1.text_.text = var_140_1
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)
				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_4 = math.max(var_140_0, arg_137_1.talkMaxDuration)

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_4 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - 0) / var_140_4

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= 0 + var_140_4 and arg_137_1.time_ < 0 + var_140_4 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play320171033 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 320171033
		arg_141_1.duration_ = 3.37

		local var_141_0 = {
			zh = 3.366,
			ja = 2.4
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
				arg_141_0:Play320171034(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1.var_.moveOldPos1156ui_story = arg_141_1.actors_["1156ui_story"].transform.localPosition
			end

			local var_144_0 = 0.001

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_0 then
				arg_141_1.actors_["1156ui_story"].transform.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos1156ui_story, Vector3.New(0, -1.1, -6.18), (arg_141_1.time_ - 0) / var_144_0)
				arg_141_1.actors_["1156ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_141_1.actors_["1156ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["1156ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["1156ui_story"].transform.position).z)
				arg_141_1.actors_["1156ui_story"].transform.localEulerAngles.z = 0
				arg_141_1.actors_["1156ui_story"].transform.localEulerAngles.x = 0
				arg_141_1.actors_["1156ui_story"].transform.localEulerAngles = arg_141_1.actors_["1156ui_story"].transform.localEulerAngles
			end

			if arg_141_1.time_ >= 0 + var_144_0 and arg_141_1.time_ < 0 + var_144_0 + arg_144_0 then
				arg_141_1.actors_["1156ui_story"].transform.localPosition = Vector3.New(0, -1.1, -6.18)
				arg_141_1.actors_["1156ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_141_1.actors_["1156ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["1156ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["1156ui_story"].transform.position).z)
				arg_141_1.actors_["1156ui_story"].transform.localEulerAngles.z = 0
				arg_141_1.actors_["1156ui_story"].transform.localEulerAngles.x = 0
				arg_141_1.actors_["1156ui_story"].transform.localEulerAngles = arg_141_1.actors_["1156ui_story"].transform.localEulerAngles
			end

			local var_144_1 = arg_141_1.actors_["1156ui_story"]

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(var_144_1) and arg_141_1.var_.characterEffect1156ui_story == nil then
				arg_141_1.var_.characterEffect1156ui_story = var_144_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_2 = 0.200000002980232

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_2 and not isNil(var_144_1) then
				if arg_141_1.var_.characterEffect1156ui_story and not isNil(var_144_1) then
					arg_141_1.var_.characterEffect1156ui_story.fillFlat = false
				end
			end

			if arg_141_1.time_ >= 0 + var_144_2 and arg_141_1.time_ < 0 + var_144_2 + arg_144_0 and not isNil(var_144_1) and arg_141_1.var_.characterEffect1156ui_story then
				arg_141_1.var_.characterEffect1156ui_story.fillFlat = false
			end

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/story1156/story1156action/1156action6_1")
			end

			local var_144_4 = 0
			local var_144_5 = 0.375

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_4 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				arg_141_1.leftNameTxt_.text = arg_141_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_6 = arg_141_1:GetWordFromCfg(320171033)
				local var_144_7 = arg_141_1:FormatText(var_144_6.content)

				arg_141_1.text_.text = var_144_7

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_9 = 15 <= 0 and var_144_5 or var_144_5 * (utf8.len(var_144_7) / 15)

				if (15 <= 0 and var_144_5 or var_144_5 * (utf8.len(var_144_7) / 15)) > 0 and var_144_5 < var_144_9 then
					arg_141_1.talkMaxDuration = var_144_9

					if var_144_9 + var_144_4 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_9 + var_144_4
					end
				end

				arg_141_1.text_.text = var_144_7
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320171", "320171033", "story_v_out_320171.awb") ~= 0 then
					local var_144_10 = manager.audio:GetVoiceLength("story_v_out_320171", "320171033", "story_v_out_320171.awb") / 1000

					if var_144_10 + var_144_4 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_10 + var_144_4
					end

					if var_144_6.prefab_name ~= "" and arg_141_1.actors_[var_144_6.prefab_name] ~= nil then
						local var_144_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_6.prefab_name].transform, "story_v_out_320171", "320171033", "story_v_out_320171.awb")

						arg_141_1:RecordAudio("320171033", var_144_11)
						arg_141_1:RecordAudio("320171033", var_144_11)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_320171", "320171033", "story_v_out_320171.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_320171", "320171033", "story_v_out_320171.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_12 = math.max(var_144_5, arg_141_1.talkMaxDuration)

			if var_144_4 <= arg_141_1.time_ and arg_141_1.time_ < var_144_4 + var_144_12 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_4) / var_144_12

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_4 + var_144_12 and arg_141_1.time_ < var_144_4 + var_144_12 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1156ui_story",
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
	Play320171034 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 320171034
		arg_145_1.duration_ = 5.83

		local var_145_0 = {
			zh = 4.5,
			ja = 5.833
		}
		local var_145_1 = manager.audio:GetLocalizationFlag()

		if var_145_0[var_145_1] ~= nil then
			arg_145_1.duration_ = var_145_0[var_145_1]
		end

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play320171035(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 and not isNil(arg_145_1.actors_["1156ui_story"]) and arg_145_1.var_.characterEffect1156ui_story == nil then
				arg_145_1.var_.characterEffect1156ui_story = arg_145_1.actors_["1156ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_0 = 0.200000002980232

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_0 and not isNil(arg_145_1.actors_["1156ui_story"]) then
				if arg_145_1.var_.characterEffect1156ui_story and not isNil(arg_145_1.actors_["1156ui_story"]) then
					arg_145_1.var_.characterEffect1156ui_story.fillFlat = true
					arg_145_1.var_.characterEffect1156ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_145_1.time_ - 0) / var_148_0)
				end
			end

			if arg_145_1.time_ >= 0 + var_148_0 and arg_145_1.time_ < 0 + var_148_0 + arg_148_0 and not isNil(arg_145_1.actors_["1156ui_story"]) and arg_145_1.var_.characterEffect1156ui_story then
				arg_145_1.var_.characterEffect1156ui_story.fillFlat = true
				arg_145_1.var_.characterEffect1156ui_story.fillRatio = 0.5
			end

			local var_148_1 = 0
			local var_148_2 = 0.45

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_1 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				arg_145_1.leftNameTxt_.text = arg_145_1:FormatText(StoryNameCfg[1032].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, true)
				arg_145_1.iconController_:SetSelectedState("hero")

				arg_145_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_gangstera")

				arg_145_1.callingController_:SetSelectedState("normal")

				arg_145_1.keyicon_.color = Color.New(1, 1, 1)
				arg_145_1.icon_.color = Color.New(1, 1, 1)

				local var_148_3 = arg_145_1:GetWordFromCfg(320171034)
				local var_148_4 = arg_145_1:FormatText(var_148_3.content)

				arg_145_1.text_.text = var_148_4

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_6 = 18 <= 0 and var_148_2 or var_148_2 * (utf8.len(var_148_4) / 18)

				if (18 <= 0 and var_148_2 or var_148_2 * (utf8.len(var_148_4) / 18)) > 0 and var_148_2 < var_148_6 then
					arg_145_1.talkMaxDuration = var_148_6

					if var_148_6 + var_148_1 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_6 + var_148_1
					end
				end

				arg_145_1.text_.text = var_148_4
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320171", "320171034", "story_v_out_320171.awb") ~= 0 then
					local var_148_7 = manager.audio:GetVoiceLength("story_v_out_320171", "320171034", "story_v_out_320171.awb") / 1000

					if var_148_7 + var_148_1 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_7 + var_148_1
					end

					if var_148_3.prefab_name ~= "" and arg_145_1.actors_[var_148_3.prefab_name] ~= nil then
						local var_148_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_3.prefab_name].transform, "story_v_out_320171", "320171034", "story_v_out_320171.awb")

						arg_145_1:RecordAudio("320171034", var_148_8)
						arg_145_1:RecordAudio("320171034", var_148_8)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_320171", "320171034", "story_v_out_320171.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_320171", "320171034", "story_v_out_320171.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_9 = math.max(var_148_2, arg_145_1.talkMaxDuration)

			if var_148_1 <= arg_145_1.time_ and arg_145_1.time_ < var_148_1 + var_148_9 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_1) / var_148_9

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_1 + var_148_9 and arg_145_1.time_ < var_148_1 + var_148_9 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {}

		arg_145_1:InitPlayNodeList()
	end,
	Play320171035 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 320171035
		arg_149_1.duration_ = 2

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play320171036(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			if arg_149_1.actors_["10100ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10100ui_story"))) then
				local var_152_0 = Object.Instantiate(Asset.Load("Char/" .. "10100ui_story"), arg_149_1.stage_.transform)

				var_152_0.name = "10100ui_story"
				var_152_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_149_1.actors_["10100ui_story"] = var_152_0

				local var_152_1 = var_152_0:GetComponentInChildren(typeof(CharacterEffect))

				var_152_1.enabled = true

				local var_152_2 = GameObjectTools.GetOrAddComponent(var_152_0, typeof(DynamicBoneHelper))

				if var_152_2 then
					var_152_2:EnableDynamicBone(false)
				end

				arg_149_1:ShowWeapon(var_152_1.transform, false)

				arg_149_1.var_["10100ui_story" .. "Animator"] = var_152_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_149_1.var_["10100ui_story" .. "Animator"].applyRootMotion = true
				arg_149_1.var_["10100ui_story" .. "LipSync"] = var_152_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_152_3 = arg_149_1.actors_["10100ui_story"].transform

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1.var_.moveOldPos10100ui_story = var_152_3.localPosition
			end

			local var_152_4 = 0.001

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_4 then
				var_152_3.localPosition = Vector3.Lerp(arg_149_1.var_.moveOldPos10100ui_story, Vector3.New(0, -1.16, -6.25), (arg_149_1.time_ - 0) / var_152_4)
				var_152_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_152_3.position).x, (manager.ui.mainCamera.transform.position - var_152_3.position).y, (manager.ui.mainCamera.transform.position - var_152_3.position).z)
				var_152_3.localEulerAngles.z = 0
				var_152_3.localEulerAngles.x = 0
				var_152_3.localEulerAngles = var_152_3.localEulerAngles
			end

			if arg_149_1.time_ >= 0 + var_152_4 and arg_149_1.time_ < 0 + var_152_4 + arg_152_0 then
				var_152_3.localPosition = Vector3.New(0, -1.16, -6.25)
				var_152_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_152_3.position).x, (manager.ui.mainCamera.transform.position - var_152_3.position).y, (manager.ui.mainCamera.transform.position - var_152_3.position).z)
				var_152_3.localEulerAngles.z = 0
				var_152_3.localEulerAngles.x = 0
				var_152_3.localEulerAngles = var_152_3.localEulerAngles
			end

			local var_152_5 = arg_149_1.actors_["10100ui_story"]

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 and not isNil(var_152_5) and arg_149_1.var_.characterEffect10100ui_story == nil then
				arg_149_1.var_.characterEffect10100ui_story = var_152_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_6 = 0.200000002980232

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_6 and not isNil(var_152_5) then
				if arg_149_1.var_.characterEffect10100ui_story and not isNil(var_152_5) then
					arg_149_1.var_.characterEffect10100ui_story.fillFlat = false
				end
			end

			if arg_149_1.time_ >= 0 + var_152_6 and arg_149_1.time_ < 0 + var_152_6 + arg_152_0 and not isNil(var_152_5) and arg_149_1.var_.characterEffect10100ui_story then
				arg_149_1.var_.characterEffect10100ui_story.fillFlat = false
			end

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action20_1")
			end

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_152_8 = arg_149_1.actors_["1156ui_story"].transform

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1.var_.moveOldPos1156ui_story = var_152_8.localPosition
			end

			local var_152_9 = 0.001

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_9 then
				var_152_8.localPosition = Vector3.Lerp(arg_149_1.var_.moveOldPos1156ui_story, Vector3.New(0, 100, 0), (arg_149_1.time_ - 0) / var_152_9)
				var_152_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_152_8.position).x, (manager.ui.mainCamera.transform.position - var_152_8.position).y, (manager.ui.mainCamera.transform.position - var_152_8.position).z)
				var_152_8.localEulerAngles.z = 0
				var_152_8.localEulerAngles.x = 0
				var_152_8.localEulerAngles = var_152_8.localEulerAngles
			end

			if arg_149_1.time_ >= 0 + var_152_9 and arg_149_1.time_ < 0 + var_152_9 + arg_152_0 then
				var_152_8.localPosition = Vector3.New(0, 100, 0)
				var_152_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_152_8.position).x, (manager.ui.mainCamera.transform.position - var_152_8.position).y, (manager.ui.mainCamera.transform.position - var_152_8.position).z)
				var_152_8.localEulerAngles.z = 0
				var_152_8.localEulerAngles.x = 0
				var_152_8.localEulerAngles = var_152_8.localEulerAngles
			end

			local var_152_10 = arg_149_1.actors_["1156ui_story"]

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 and not isNil(var_152_10) and arg_149_1.var_.characterEffect1156ui_story == nil then
				arg_149_1.var_.characterEffect1156ui_story = var_152_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_11 = 0.200000002980232

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_11 and not isNil(var_152_10) then
				if arg_149_1.var_.characterEffect1156ui_story and not isNil(var_152_10) then
					arg_149_1.var_.characterEffect1156ui_story.fillFlat = true
					arg_149_1.var_.characterEffect1156ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_149_1.time_ - 0) / var_152_11)
				end
			end

			if arg_149_1.time_ >= 0 + var_152_11 and arg_149_1.time_ < 0 + var_152_11 + arg_152_0 and not isNil(var_152_10) and arg_149_1.var_.characterEffect1156ui_story then
				arg_149_1.var_.characterEffect1156ui_story.fillFlat = true
				arg_149_1.var_.characterEffect1156ui_story.fillRatio = 0.5
			end

			local var_152_12 = 0
			local var_152_13 = 0.175

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_12 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				arg_149_1.leftNameTxt_.text = arg_149_1:FormatText(StoryNameCfg[1021].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_14 = arg_149_1:GetWordFromCfg(320171035)
				local var_152_15 = arg_149_1:FormatText(var_152_14.content)

				arg_149_1.text_.text = var_152_15

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_17 = 7 <= 0 and var_152_13 or var_152_13 * (utf8.len(var_152_15) / 7)

				if (7 <= 0 and var_152_13 or var_152_13 * (utf8.len(var_152_15) / 7)) > 0 and var_152_13 < var_152_17 then
					arg_149_1.talkMaxDuration = var_152_17

					if var_152_17 + var_152_12 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_17 + var_152_12
					end
				end

				arg_149_1.text_.text = var_152_15
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320171", "320171035", "story_v_out_320171.awb") ~= 0 then
					local var_152_18 = manager.audio:GetVoiceLength("story_v_out_320171", "320171035", "story_v_out_320171.awb") / 1000

					if var_152_18 + var_152_12 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_18 + var_152_12
					end

					if var_152_14.prefab_name ~= "" and arg_149_1.actors_[var_152_14.prefab_name] ~= nil then
						local var_152_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_14.prefab_name].transform, "story_v_out_320171", "320171035", "story_v_out_320171.awb")

						arg_149_1:RecordAudio("320171035", var_152_19)
						arg_149_1:RecordAudio("320171035", var_152_19)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_320171", "320171035", "story_v_out_320171.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_320171", "320171035", "story_v_out_320171.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_20 = math.max(var_152_13, arg_149_1.talkMaxDuration)

			if var_152_12 <= arg_149_1.time_ and arg_149_1.time_ < var_152_12 + var_152_20 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_12) / var_152_20

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_12 + var_152_20 and arg_149_1.time_ < var_152_12 + var_152_20 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10100ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1156ui_story",
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
	Play320171036 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 320171036
		arg_153_1.duration_ = 5

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play320171037(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1.var_.moveOldPos10100ui_story = arg_153_1.actors_["10100ui_story"].transform.localPosition
			end

			local var_156_0 = 0.001

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_0 then
				arg_153_1.actors_["10100ui_story"].transform.localPosition = Vector3.Lerp(arg_153_1.var_.moveOldPos10100ui_story, Vector3.New(0, 100, 0), (arg_153_1.time_ - 0) / var_156_0)
				arg_153_1.actors_["10100ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_153_1.actors_["10100ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["10100ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["10100ui_story"].transform.position).z)
				arg_153_1.actors_["10100ui_story"].transform.localEulerAngles.z = 0
				arg_153_1.actors_["10100ui_story"].transform.localEulerAngles.x = 0
				arg_153_1.actors_["10100ui_story"].transform.localEulerAngles = arg_153_1.actors_["10100ui_story"].transform.localEulerAngles
			end

			if arg_153_1.time_ >= 0 + var_156_0 and arg_153_1.time_ < 0 + var_156_0 + arg_156_0 then
				arg_153_1.actors_["10100ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_153_1.actors_["10100ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_153_1.actors_["10100ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["10100ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["10100ui_story"].transform.position).z)
				arg_153_1.actors_["10100ui_story"].transform.localEulerAngles.z = 0
				arg_153_1.actors_["10100ui_story"].transform.localEulerAngles.x = 0
				arg_153_1.actors_["10100ui_story"].transform.localEulerAngles = arg_153_1.actors_["10100ui_story"].transform.localEulerAngles
			end

			local var_156_1 = arg_153_1.actors_["10100ui_story"]

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 and not isNil(var_156_1) and arg_153_1.var_.characterEffect10100ui_story == nil then
				arg_153_1.var_.characterEffect10100ui_story = var_156_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_2 = 0.200000002980232

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_2 and not isNil(var_156_1) then
				if arg_153_1.var_.characterEffect10100ui_story and not isNil(var_156_1) then
					arg_153_1.var_.characterEffect10100ui_story.fillFlat = true
					arg_153_1.var_.characterEffect10100ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_153_1.time_ - 0) / var_156_2)
				end
			end

			if arg_153_1.time_ >= 0 + var_156_2 and arg_153_1.time_ < 0 + var_156_2 + arg_156_0 and not isNil(var_156_1) and arg_153_1.var_.characterEffect10100ui_story then
				arg_153_1.var_.characterEffect10100ui_story.fillFlat = true
				arg_153_1.var_.characterEffect10100ui_story.fillRatio = 0.5
			end

			local var_156_3 = 0
			local var_156_4 = 1.4

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_3 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, false)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_5 = arg_153_1:FormatText(arg_153_1:GetWordFromCfg(320171036).content)

				arg_153_1.text_.text = var_156_5

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_7 = 56 <= 0 and var_156_4 or var_156_4 * (utf8.len(var_156_5) / 56)

				if (56 <= 0 and var_156_4 or var_156_4 * (utf8.len(var_156_5) / 56)) > 0 and var_156_4 < var_156_7 then
					arg_153_1.talkMaxDuration = var_156_7

					if var_156_7 + var_156_3 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_7 + var_156_3
					end
				end

				arg_153_1.text_.text = var_156_5
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)
				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_8 = math.max(var_156_4, arg_153_1.talkMaxDuration)

			if var_156_3 <= arg_153_1.time_ and arg_153_1.time_ < var_156_3 + var_156_8 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_3) / var_156_8

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_3 + var_156_8 and arg_153_1.time_ < var_156_3 + var_156_8 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10100ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_153_1:InitPlayNodeList()
	end,
	Play320171037 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 320171037
		arg_157_1.duration_ = 11.23

		local var_157_0 = {
			zh = 10.966,
			ja = 11.233
		}
		local var_157_1 = manager.audio:GetLocalizationFlag()

		if var_157_0[var_157_1] ~= nil then
			arg_157_1.duration_ = var_157_0[var_157_1]
		end

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play320171038(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			if arg_157_1.actors_["10101ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10101ui_story"))) then
				local var_160_0 = Object.Instantiate(Asset.Load("Char/" .. "10101ui_story"), arg_157_1.stage_.transform)

				var_160_0.name = "10101ui_story"
				var_160_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_157_1.actors_["10101ui_story"] = var_160_0

				local var_160_1 = var_160_0:GetComponentInChildren(typeof(CharacterEffect))

				var_160_1.enabled = true

				local var_160_2 = GameObjectTools.GetOrAddComponent(var_160_0, typeof(DynamicBoneHelper))

				if var_160_2 then
					var_160_2:EnableDynamicBone(false)
				end

				arg_157_1:ShowWeapon(var_160_1.transform, false)

				arg_157_1.var_["10101ui_story" .. "Animator"] = var_160_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_157_1.var_["10101ui_story" .. "Animator"].applyRootMotion = true
				arg_157_1.var_["10101ui_story" .. "LipSync"] = var_160_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_160_3 = arg_157_1.actors_["10101ui_story"].transform

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1.var_.moveOldPos10101ui_story = var_160_3.localPosition
			end

			local var_160_4 = 0.001

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_4 then
				var_160_3.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos10101ui_story, Vector3.New(0, -1.16, -6.01), (arg_157_1.time_ - 0) / var_160_4)
				var_160_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_160_3.position).x, (manager.ui.mainCamera.transform.position - var_160_3.position).y, (manager.ui.mainCamera.transform.position - var_160_3.position).z)
				var_160_3.localEulerAngles.z = 0
				var_160_3.localEulerAngles.x = 0
				var_160_3.localEulerAngles = var_160_3.localEulerAngles
			end

			if arg_157_1.time_ >= 0 + var_160_4 and arg_157_1.time_ < 0 + var_160_4 + arg_160_0 then
				var_160_3.localPosition = Vector3.New(0, -1.16, -6.01)
				var_160_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_160_3.position).x, (manager.ui.mainCamera.transform.position - var_160_3.position).y, (manager.ui.mainCamera.transform.position - var_160_3.position).z)
				var_160_3.localEulerAngles.z = 0
				var_160_3.localEulerAngles.x = 0
				var_160_3.localEulerAngles = var_160_3.localEulerAngles
			end

			local var_160_5 = arg_157_1.actors_["10101ui_story"]

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 and not isNil(var_160_5) and arg_157_1.var_.characterEffect10101ui_story == nil then
				arg_157_1.var_.characterEffect10101ui_story = var_160_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_6 = 0.200000002980232

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_6 and not isNil(var_160_5) then
				if arg_157_1.var_.characterEffect10101ui_story and not isNil(var_160_5) then
					arg_157_1.var_.characterEffect10101ui_story.fillFlat = false
				end
			end

			if arg_157_1.time_ >= 0 + var_160_6 and arg_157_1.time_ < 0 + var_160_6 + arg_160_0 and not isNil(var_160_5) and arg_157_1.var_.characterEffect10101ui_story then
				arg_157_1.var_.characterEffect10101ui_story.fillFlat = false
			end

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1:PlayTimeline("10101ui_story", "StoryTimeline/CharAction/story1022/story1022action/1022action3_1")
			end

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1:PlayTimeline("10101ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_160_8 = 0
			local var_160_9 = 1.325

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_8 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				arg_157_1.leftNameTxt_.text = arg_157_1:FormatText(StoryNameCfg[1023].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_10 = arg_157_1:GetWordFromCfg(320171037)
				local var_160_11 = arg_157_1:FormatText(var_160_10.content)

				arg_157_1.text_.text = var_160_11

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_13 = 53 <= 0 and var_160_9 or var_160_9 * (utf8.len(var_160_11) / 53)

				if (53 <= 0 and var_160_9 or var_160_9 * (utf8.len(var_160_11) / 53)) > 0 and var_160_9 < var_160_13 then
					arg_157_1.talkMaxDuration = var_160_13

					if var_160_13 + var_160_8 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_13 + var_160_8
					end
				end

				arg_157_1.text_.text = var_160_11
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320171", "320171037", "story_v_out_320171.awb") ~= 0 then
					local var_160_14 = manager.audio:GetVoiceLength("story_v_out_320171", "320171037", "story_v_out_320171.awb") / 1000

					if var_160_14 + var_160_8 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_14 + var_160_8
					end

					if var_160_10.prefab_name ~= "" and arg_157_1.actors_[var_160_10.prefab_name] ~= nil then
						local var_160_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_10.prefab_name].transform, "story_v_out_320171", "320171037", "story_v_out_320171.awb")

						arg_157_1:RecordAudio("320171037", var_160_15)
						arg_157_1:RecordAudio("320171037", var_160_15)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_320171", "320171037", "story_v_out_320171.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_320171", "320171037", "story_v_out_320171.awb")
				end

				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_16 = math.max(var_160_9, arg_157_1.talkMaxDuration)

			if var_160_8 <= arg_157_1.time_ and arg_157_1.time_ < var_160_8 + var_160_16 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_8) / var_160_16

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_8 + var_160_16 and arg_157_1.time_ < var_160_8 + var_160_16 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10101ui_story",
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
	Play320171038 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 320171038
		arg_161_1.duration_ = 8.6

		local var_161_0 = {
			zh = 7.533,
			ja = 8.6
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
				arg_161_0:Play320171039(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = 0.9

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				arg_161_1.leftNameTxt_.text = arg_161_1:FormatText(StoryNameCfg[1023].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_1 = arg_161_1:GetWordFromCfg(320171038)
				local var_164_2 = arg_161_1:FormatText(var_164_1.content)

				arg_161_1.text_.text = var_164_2

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_4 = 36 <= 0 and var_164_0 or var_164_0 * (utf8.len(var_164_2) / 36)

				if (36 <= 0 and var_164_0 or var_164_0 * (utf8.len(var_164_2) / 36)) > 0 and var_164_0 < var_164_4 then
					arg_161_1.talkMaxDuration = var_164_4

					if var_164_4 + 0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_4 + 0
					end
				end

				arg_161_1.text_.text = var_164_2
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320171", "320171038", "story_v_out_320171.awb") ~= 0 then
					local var_164_5 = manager.audio:GetVoiceLength("story_v_out_320171", "320171038", "story_v_out_320171.awb") / 1000

					if var_164_5 + 0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_5 + 0
					end

					if var_164_1.prefab_name ~= "" and arg_161_1.actors_[var_164_1.prefab_name] ~= nil then
						local var_164_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_1.prefab_name].transform, "story_v_out_320171", "320171038", "story_v_out_320171.awb")

						arg_161_1:RecordAudio("320171038", var_164_6)
						arg_161_1:RecordAudio("320171038", var_164_6)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_320171", "320171038", "story_v_out_320171.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_320171", "320171038", "story_v_out_320171.awb")
				end

				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_7 = math.max(var_164_0, arg_161_1.talkMaxDuration)

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_7 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - 0) / var_164_7

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= 0 + var_164_7 and arg_161_1.time_ < 0 + var_164_7 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play320171039 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 320171039
		arg_165_1.duration_ = 6.47

		local var_165_0 = {
			zh = 2.966,
			ja = 6.466
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
				arg_165_0:Play320171040(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			if arg_165_1.actors_["1020ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1020ui_story"))) then
				local var_168_0 = Object.Instantiate(Asset.Load("Char/" .. "1020ui_story"), arg_165_1.stage_.transform)

				var_168_0.name = "1020ui_story"
				var_168_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_165_1.actors_["1020ui_story"] = var_168_0

				local var_168_1 = var_168_0:GetComponentInChildren(typeof(CharacterEffect))

				var_168_1.enabled = true

				local var_168_2 = GameObjectTools.GetOrAddComponent(var_168_0, typeof(DynamicBoneHelper))

				if var_168_2 then
					var_168_2:EnableDynamicBone(false)
				end

				arg_165_1:ShowWeapon(var_168_1.transform, false)

				arg_165_1.var_["1020ui_story" .. "Animator"] = var_168_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_165_1.var_["1020ui_story" .. "Animator"].applyRootMotion = true
				arg_165_1.var_["1020ui_story" .. "LipSync"] = var_168_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_168_3 = arg_165_1.actors_["1020ui_story"].transform

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1.var_.moveOldPos1020ui_story = var_168_3.localPosition
			end

			local var_168_4 = 0.001

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_4 then
				var_168_3.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPos1020ui_story, Vector3.New(-0.7, -0.85, -6.25), (arg_165_1.time_ - 0) / var_168_4)
				var_168_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_168_3.position).x, (manager.ui.mainCamera.transform.position - var_168_3.position).y, (manager.ui.mainCamera.transform.position - var_168_3.position).z)
				var_168_3.localEulerAngles.z = 0
				var_168_3.localEulerAngles.x = 0
				var_168_3.localEulerAngles = var_168_3.localEulerAngles
			end

			if arg_165_1.time_ >= 0 + var_168_4 and arg_165_1.time_ < 0 + var_168_4 + arg_168_0 then
				var_168_3.localPosition = Vector3.New(-0.7, -0.85, -6.25)
				var_168_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_168_3.position).x, (manager.ui.mainCamera.transform.position - var_168_3.position).y, (manager.ui.mainCamera.transform.position - var_168_3.position).z)
				var_168_3.localEulerAngles.z = 0
				var_168_3.localEulerAngles.x = 0
				var_168_3.localEulerAngles = var_168_3.localEulerAngles
			end

			local var_168_5 = arg_165_1.actors_["1020ui_story"]

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 and not isNil(var_168_5) and arg_165_1.var_.characterEffect1020ui_story == nil then
				arg_165_1.var_.characterEffect1020ui_story = var_168_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_6 = 0.200000002980232

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_6 and not isNil(var_168_5) then
				if arg_165_1.var_.characterEffect1020ui_story and not isNil(var_168_5) then
					arg_165_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_165_1.time_ >= 0 + var_168_6 and arg_165_1.time_ < 0 + var_168_6 + arg_168_0 and not isNil(var_168_5) and arg_165_1.var_.characterEffect1020ui_story then
				arg_165_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action1_1")
			end

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_168_8 = arg_165_1.actors_["10101ui_story"].transform

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1.var_.moveOldPos10101ui_story = var_168_8.localPosition
			end

			local var_168_9 = 0.001

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_9 then
				var_168_8.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPos10101ui_story, Vector3.New(0.7, -1.16, -6.01), (arg_165_1.time_ - 0) / var_168_9)
				var_168_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_168_8.position).x, (manager.ui.mainCamera.transform.position - var_168_8.position).y, (manager.ui.mainCamera.transform.position - var_168_8.position).z)
				var_168_8.localEulerAngles.z = 0
				var_168_8.localEulerAngles.x = 0
				var_168_8.localEulerAngles = var_168_8.localEulerAngles
			end

			if arg_165_1.time_ >= 0 + var_168_9 and arg_165_1.time_ < 0 + var_168_9 + arg_168_0 then
				var_168_8.localPosition = Vector3.New(0.7, -1.16, -6.01)
				var_168_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_168_8.position).x, (manager.ui.mainCamera.transform.position - var_168_8.position).y, (manager.ui.mainCamera.transform.position - var_168_8.position).z)
				var_168_8.localEulerAngles.z = 0
				var_168_8.localEulerAngles.x = 0
				var_168_8.localEulerAngles = var_168_8.localEulerAngles
			end

			local var_168_10 = arg_165_1.actors_["10101ui_story"]

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 and not isNil(var_168_10) and arg_165_1.var_.characterEffect10101ui_story == nil then
				arg_165_1.var_.characterEffect10101ui_story = var_168_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_11 = 0.200000002980232

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_11 and not isNil(var_168_10) then
				if arg_165_1.var_.characterEffect10101ui_story and not isNil(var_168_10) then
					arg_165_1.var_.characterEffect10101ui_story.fillFlat = true
					arg_165_1.var_.characterEffect10101ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_165_1.time_ - 0) / var_168_11)
				end
			end

			if arg_165_1.time_ >= 0 + var_168_11 and arg_165_1.time_ < 0 + var_168_11 + arg_168_0 and not isNil(var_168_10) and arg_165_1.var_.characterEffect10101ui_story then
				arg_165_1.var_.characterEffect10101ui_story.fillFlat = true
				arg_165_1.var_.characterEffect10101ui_story.fillRatio = 0.5
			end

			local var_168_12 = 0
			local var_168_13 = 0.325

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_12 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				arg_165_1.leftNameTxt_.text = arg_165_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_14 = arg_165_1:GetWordFromCfg(320171039)
				local var_168_15 = arg_165_1:FormatText(var_168_14.content)

				arg_165_1.text_.text = var_168_15

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_17 = 13 <= 0 and var_168_13 or var_168_13 * (utf8.len(var_168_15) / 13)

				if (13 <= 0 and var_168_13 or var_168_13 * (utf8.len(var_168_15) / 13)) > 0 and var_168_13 < var_168_17 then
					arg_165_1.talkMaxDuration = var_168_17

					if var_168_17 + var_168_12 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_17 + var_168_12
					end
				end

				arg_165_1.text_.text = var_168_15
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320171", "320171039", "story_v_out_320171.awb") ~= 0 then
					local var_168_18 = manager.audio:GetVoiceLength("story_v_out_320171", "320171039", "story_v_out_320171.awb") / 1000

					if var_168_18 + var_168_12 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_18 + var_168_12
					end

					if var_168_14.prefab_name ~= "" and arg_165_1.actors_[var_168_14.prefab_name] ~= nil then
						local var_168_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_14.prefab_name].transform, "story_v_out_320171", "320171039", "story_v_out_320171.awb")

						arg_165_1:RecordAudio("320171039", var_168_19)
						arg_165_1:RecordAudio("320171039", var_168_19)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_320171", "320171039", "story_v_out_320171.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_320171", "320171039", "story_v_out_320171.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_20 = math.max(var_168_13, arg_165_1.talkMaxDuration)

			if var_168_12 <= arg_165_1.time_ and arg_165_1.time_ < var_168_12 + var_168_20 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_12) / var_168_20

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_12 + var_168_20 and arg_165_1.time_ < var_168_12 + var_168_20 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10101ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_165_1:InitPlayNodeList()
	end,
	Play320171040 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 320171040
		arg_169_1.duration_ = 14.07

		local var_169_0 = {
			zh = 14.066,
			ja = 13.1
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
				arg_169_0:Play320171041(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 and not isNil(arg_169_1.actors_["10101ui_story"]) and arg_169_1.var_.characterEffect10101ui_story == nil then
				arg_169_1.var_.characterEffect10101ui_story = arg_169_1.actors_["10101ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_0 = 0.200000002980232

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_0 and not isNil(arg_169_1.actors_["10101ui_story"]) then
				if arg_169_1.var_.characterEffect10101ui_story and not isNil(arg_169_1.actors_["10101ui_story"]) then
					arg_169_1.var_.characterEffect10101ui_story.fillFlat = false
				end
			end

			if arg_169_1.time_ >= 0 + var_172_0 and arg_169_1.time_ < 0 + var_172_0 + arg_172_0 and not isNil(arg_169_1.actors_["10101ui_story"]) and arg_169_1.var_.characterEffect10101ui_story then
				arg_169_1.var_.characterEffect10101ui_story.fillFlat = false
			end

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1:PlayTimeline("10101ui_story", "StoryTimeline/CharAction/story1022/story1022action/1022action3_2")
			end

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1:PlayTimeline("10101ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_172_2 = arg_169_1.actors_["1020ui_story"]

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 and not isNil(var_172_2) and arg_169_1.var_.characterEffect1020ui_story == nil then
				arg_169_1.var_.characterEffect1020ui_story = var_172_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_3 = 0.200000002980232

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_3 and not isNil(var_172_2) then
				if arg_169_1.var_.characterEffect1020ui_story and not isNil(var_172_2) then
					arg_169_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_169_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_169_1.time_ - 0) / var_172_3)
				end
			end

			if arg_169_1.time_ >= 0 + var_172_3 and arg_169_1.time_ < 0 + var_172_3 + arg_172_0 and not isNil(var_172_2) and arg_169_1.var_.characterEffect1020ui_story then
				arg_169_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_169_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_172_4 = 0
			local var_172_5 = 1.625

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_4 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				arg_169_1.leftNameTxt_.text = arg_169_1:FormatText(StoryNameCfg[1023].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_6 = arg_169_1:GetWordFromCfg(320171040)
				local var_172_7 = arg_169_1:FormatText(var_172_6.content)

				arg_169_1.text_.text = var_172_7

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_9 = 65 <= 0 and var_172_5 or var_172_5 * (utf8.len(var_172_7) / 65)

				if (65 <= 0 and var_172_5 or var_172_5 * (utf8.len(var_172_7) / 65)) > 0 and var_172_5 < var_172_9 then
					arg_169_1.talkMaxDuration = var_172_9

					if var_172_9 + var_172_4 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_9 + var_172_4
					end
				end

				arg_169_1.text_.text = var_172_7
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320171", "320171040", "story_v_out_320171.awb") ~= 0 then
					local var_172_10 = manager.audio:GetVoiceLength("story_v_out_320171", "320171040", "story_v_out_320171.awb") / 1000

					if var_172_10 + var_172_4 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_10 + var_172_4
					end

					if var_172_6.prefab_name ~= "" and arg_169_1.actors_[var_172_6.prefab_name] ~= nil then
						local var_172_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_6.prefab_name].transform, "story_v_out_320171", "320171040", "story_v_out_320171.awb")

						arg_169_1:RecordAudio("320171040", var_172_11)
						arg_169_1:RecordAudio("320171040", var_172_11)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_320171", "320171040", "story_v_out_320171.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_320171", "320171040", "story_v_out_320171.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_12 = math.max(var_172_5, arg_169_1.talkMaxDuration)

			if var_172_4 <= arg_169_1.time_ and arg_169_1.time_ < var_172_4 + var_172_12 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_4) / var_172_12

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_4 + var_172_12 and arg_169_1.time_ < var_172_4 + var_172_12 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play320171041 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 320171041
		arg_173_1.duration_ = 7.8

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play320171042(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 and not isNil(arg_173_1.actors_["1020ui_story"]) and arg_173_1.var_.characterEffect1020ui_story == nil then
				arg_173_1.var_.characterEffect1020ui_story = arg_173_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_0 = 0.200000002980232

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_0 and not isNil(arg_173_1.actors_["1020ui_story"]) then
				if arg_173_1.var_.characterEffect1020ui_story and not isNil(arg_173_1.actors_["1020ui_story"]) then
					arg_173_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_173_1.time_ >= 0 + var_176_0 and arg_173_1.time_ < 0 + var_176_0 + arg_176_0 and not isNil(arg_173_1.actors_["1020ui_story"]) and arg_173_1.var_.characterEffect1020ui_story then
				arg_173_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_176_2 = arg_173_1.actors_["10101ui_story"]

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 and not isNil(var_176_2) and arg_173_1.var_.characterEffect10101ui_story == nil then
				arg_173_1.var_.characterEffect10101ui_story = var_176_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_3 = 0.200000002980232

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_3 and not isNil(var_176_2) then
				if arg_173_1.var_.characterEffect10101ui_story and not isNil(var_176_2) then
					arg_173_1.var_.characterEffect10101ui_story.fillFlat = true
					arg_173_1.var_.characterEffect10101ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_173_1.time_ - 0) / var_176_3)
				end
			end

			if arg_173_1.time_ >= 0 + var_176_3 and arg_173_1.time_ < 0 + var_176_3 + arg_176_0 and not isNil(var_176_2) and arg_173_1.var_.characterEffect10101ui_story then
				arg_173_1.var_.characterEffect10101ui_story.fillFlat = true
				arg_173_1.var_.characterEffect10101ui_story.fillRatio = 0.5
			end

			local var_176_4 = 0
			local var_176_5 = 0.925

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_4 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				arg_173_1.leftNameTxt_.text = arg_173_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_6 = arg_173_1:GetWordFromCfg(320171041)
				local var_176_7 = arg_173_1:FormatText(var_176_6.content)

				arg_173_1.text_.text = var_176_7

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_9 = 37 <= 0 and var_176_5 or var_176_5 * (utf8.len(var_176_7) / 37)

				if (37 <= 0 and var_176_5 or var_176_5 * (utf8.len(var_176_7) / 37)) > 0 and var_176_5 < var_176_9 then
					arg_173_1.talkMaxDuration = var_176_9

					if var_176_9 + var_176_4 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_9 + var_176_4
					end
				end

				arg_173_1.text_.text = var_176_7
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320171", "320171041", "story_v_out_320171.awb") ~= 0 then
					local var_176_10 = manager.audio:GetVoiceLength("story_v_out_320171", "320171041", "story_v_out_320171.awb") / 1000

					if var_176_10 + var_176_4 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_10 + var_176_4
					end

					if var_176_6.prefab_name ~= "" and arg_173_1.actors_[var_176_6.prefab_name] ~= nil then
						local var_176_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_6.prefab_name].transform, "story_v_out_320171", "320171041", "story_v_out_320171.awb")

						arg_173_1:RecordAudio("320171041", var_176_11)
						arg_173_1:RecordAudio("320171041", var_176_11)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_320171", "320171041", "story_v_out_320171.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_320171", "320171041", "story_v_out_320171.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_12 = math.max(var_176_5, arg_173_1.talkMaxDuration)

			if var_176_4 <= arg_173_1.time_ and arg_173_1.time_ < var_176_4 + var_176_12 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_4) / var_176_12

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_4 + var_176_12 and arg_173_1.time_ < var_176_4 + var_176_12 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play320171042 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 320171042
		arg_177_1.duration_ = 6.77

		local var_177_0 = {
			zh = 3.566,
			ja = 6.766
		}
		local var_177_1 = manager.audio:GetLocalizationFlag()

		if var_177_0[var_177_1] ~= nil then
			arg_177_1.duration_ = var_177_0[var_177_1]
		end

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play320171043(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 and not isNil(arg_177_1.actors_["10101ui_story"]) and arg_177_1.var_.characterEffect10101ui_story == nil then
				arg_177_1.var_.characterEffect10101ui_story = arg_177_1.actors_["10101ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_0 = 0.200000002980232

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_0 and not isNil(arg_177_1.actors_["10101ui_story"]) then
				if arg_177_1.var_.characterEffect10101ui_story and not isNil(arg_177_1.actors_["10101ui_story"]) then
					arg_177_1.var_.characterEffect10101ui_story.fillFlat = false
				end
			end

			if arg_177_1.time_ >= 0 + var_180_0 and arg_177_1.time_ < 0 + var_180_0 + arg_180_0 and not isNil(arg_177_1.actors_["10101ui_story"]) and arg_177_1.var_.characterEffect10101ui_story then
				arg_177_1.var_.characterEffect10101ui_story.fillFlat = false
			end

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1:PlayTimeline("10101ui_story", "StoryTimeline/CharAction/story1022/story1022action/1022action4_1")
			end

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1:PlayTimeline("10101ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_180_2 = arg_177_1.actors_["1020ui_story"]

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 and not isNil(var_180_2) and arg_177_1.var_.characterEffect1020ui_story == nil then
				arg_177_1.var_.characterEffect1020ui_story = var_180_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_3 = 0.200000002980232

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_3 and not isNil(var_180_2) then
				if arg_177_1.var_.characterEffect1020ui_story and not isNil(var_180_2) then
					arg_177_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_177_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_177_1.time_ - 0) / var_180_3)
				end
			end

			if arg_177_1.time_ >= 0 + var_180_3 and arg_177_1.time_ < 0 + var_180_3 + arg_180_0 and not isNil(var_180_2) and arg_177_1.var_.characterEffect1020ui_story then
				arg_177_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_177_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_180_4 = 0
			local var_180_5 = 0.375

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_4 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				arg_177_1.leftNameTxt_.text = arg_177_1:FormatText(StoryNameCfg[1023].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_6 = arg_177_1:GetWordFromCfg(320171042)
				local var_180_7 = arg_177_1:FormatText(var_180_6.content)

				arg_177_1.text_.text = var_180_7

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_9 = 15 <= 0 and var_180_5 or var_180_5 * (utf8.len(var_180_7) / 15)

				if (15 <= 0 and var_180_5 or var_180_5 * (utf8.len(var_180_7) / 15)) > 0 and var_180_5 < var_180_9 then
					arg_177_1.talkMaxDuration = var_180_9

					if var_180_9 + var_180_4 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_9 + var_180_4
					end
				end

				arg_177_1.text_.text = var_180_7
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320171", "320171042", "story_v_out_320171.awb") ~= 0 then
					local var_180_10 = manager.audio:GetVoiceLength("story_v_out_320171", "320171042", "story_v_out_320171.awb") / 1000

					if var_180_10 + var_180_4 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_10 + var_180_4
					end

					if var_180_6.prefab_name ~= "" and arg_177_1.actors_[var_180_6.prefab_name] ~= nil then
						local var_180_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_6.prefab_name].transform, "story_v_out_320171", "320171042", "story_v_out_320171.awb")

						arg_177_1:RecordAudio("320171042", var_180_11)
						arg_177_1:RecordAudio("320171042", var_180_11)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_320171", "320171042", "story_v_out_320171.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_320171", "320171042", "story_v_out_320171.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_12 = math.max(var_180_5, arg_177_1.talkMaxDuration)

			if var_180_4 <= arg_177_1.time_ and arg_177_1.time_ < var_180_4 + var_180_12 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_4) / var_180_12

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_4 + var_180_12 and arg_177_1.time_ < var_180_4 + var_180_12 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {}

		arg_177_1:InitPlayNodeList()
	end,
	Play320171043 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 320171043
		arg_181_1.duration_ = 8.37

		local var_181_0 = {
			zh = 8.266,
			ja = 8.366
		}
		local var_181_1 = manager.audio:GetLocalizationFlag()

		if var_181_0[var_181_1] ~= nil then
			arg_181_1.duration_ = var_181_0[var_181_1]
		end

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play320171044(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = 1.1

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				arg_181_1.leftNameTxt_.text = arg_181_1:FormatText(StoryNameCfg[1023].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_1 = arg_181_1:GetWordFromCfg(320171043)
				local var_184_2 = arg_181_1:FormatText(var_184_1.content)

				arg_181_1.text_.text = var_184_2

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_4 = 44 <= 0 and var_184_0 or var_184_0 * (utf8.len(var_184_2) / 44)

				if (44 <= 0 and var_184_0 or var_184_0 * (utf8.len(var_184_2) / 44)) > 0 and var_184_0 < var_184_4 then
					arg_181_1.talkMaxDuration = var_184_4

					if var_184_4 + 0 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_4 + 0
					end
				end

				arg_181_1.text_.text = var_184_2
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320171", "320171043", "story_v_out_320171.awb") ~= 0 then
					local var_184_5 = manager.audio:GetVoiceLength("story_v_out_320171", "320171043", "story_v_out_320171.awb") / 1000

					if var_184_5 + 0 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_5 + 0
					end

					if var_184_1.prefab_name ~= "" and arg_181_1.actors_[var_184_1.prefab_name] ~= nil then
						local var_184_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_1.prefab_name].transform, "story_v_out_320171", "320171043", "story_v_out_320171.awb")

						arg_181_1:RecordAudio("320171043", var_184_6)
						arg_181_1:RecordAudio("320171043", var_184_6)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_320171", "320171043", "story_v_out_320171.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_320171", "320171043", "story_v_out_320171.awb")
				end

				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_7 = math.max(var_184_0, arg_181_1.talkMaxDuration)

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_7 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - 0) / var_184_7

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= 0 + var_184_7 and arg_181_1.time_ < 0 + var_184_7 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play320171044 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 320171044
		arg_185_1.duration_ = 16.73

		local var_185_0 = {
			zh = 11.866,
			ja = 16.733
		}
		local var_185_1 = manager.audio:GetLocalizationFlag()

		if var_185_0[var_185_1] ~= nil then
			arg_185_1.duration_ = var_185_0[var_185_1]
		end

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play320171045(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = 1.375

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				arg_185_1.leftNameTxt_.text = arg_185_1:FormatText(StoryNameCfg[1023].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_1 = arg_185_1:GetWordFromCfg(320171044)
				local var_188_2 = arg_185_1:FormatText(var_188_1.content)

				arg_185_1.text_.text = var_188_2

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_4 = 55 <= 0 and var_188_0 or var_188_0 * (utf8.len(var_188_2) / 55)

				if (55 <= 0 and var_188_0 or var_188_0 * (utf8.len(var_188_2) / 55)) > 0 and var_188_0 < var_188_4 then
					arg_185_1.talkMaxDuration = var_188_4

					if var_188_4 + 0 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_4 + 0
					end
				end

				arg_185_1.text_.text = var_188_2
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320171", "320171044", "story_v_out_320171.awb") ~= 0 then
					local var_188_5 = manager.audio:GetVoiceLength("story_v_out_320171", "320171044", "story_v_out_320171.awb") / 1000

					if var_188_5 + 0 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_5 + 0
					end

					if var_188_1.prefab_name ~= "" and arg_185_1.actors_[var_188_1.prefab_name] ~= nil then
						local var_188_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_1.prefab_name].transform, "story_v_out_320171", "320171044", "story_v_out_320171.awb")

						arg_185_1:RecordAudio("320171044", var_188_6)
						arg_185_1:RecordAudio("320171044", var_188_6)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_320171", "320171044", "story_v_out_320171.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_320171", "320171044", "story_v_out_320171.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_7 = math.max(var_188_0, arg_185_1.talkMaxDuration)

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_7 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - 0) / var_188_7

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= 0 + var_188_7 and arg_185_1.time_ < 0 + var_188_7 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play320171045 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 320171045
		arg_189_1.duration_ = 16.07

		local var_189_0 = {
			zh = 14.233,
			ja = 16.066
		}
		local var_189_1 = manager.audio:GetLocalizationFlag()

		if var_189_0[var_189_1] ~= nil then
			arg_189_1.duration_ = var_189_0[var_189_1]
		end

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play320171046(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1:PlayTimeline("10101ui_story", "StoryTimeline/CharAction/story1022/story1022actionlink/1022action446")
			end

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1:PlayTimeline("10101ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_192_0 = 0
			local var_192_1 = 1.725

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_0 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				arg_189_1.leftNameTxt_.text = arg_189_1:FormatText(StoryNameCfg[1023].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_2 = arg_189_1:GetWordFromCfg(320171045)
				local var_192_3 = arg_189_1:FormatText(var_192_2.content)

				arg_189_1.text_.text = var_192_3

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_5 = 69 <= 0 and var_192_1 or var_192_1 * (utf8.len(var_192_3) / 69)

				if (69 <= 0 and var_192_1 or var_192_1 * (utf8.len(var_192_3) / 69)) > 0 and var_192_1 < var_192_5 then
					arg_189_1.talkMaxDuration = var_192_5

					if var_192_5 + var_192_0 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_5 + var_192_0
					end
				end

				arg_189_1.text_.text = var_192_3
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320171", "320171045", "story_v_out_320171.awb") ~= 0 then
					local var_192_6 = manager.audio:GetVoiceLength("story_v_out_320171", "320171045", "story_v_out_320171.awb") / 1000

					if var_192_6 + var_192_0 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_6 + var_192_0
					end

					if var_192_2.prefab_name ~= "" and arg_189_1.actors_[var_192_2.prefab_name] ~= nil then
						local var_192_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_2.prefab_name].transform, "story_v_out_320171", "320171045", "story_v_out_320171.awb")

						arg_189_1:RecordAudio("320171045", var_192_7)
						arg_189_1:RecordAudio("320171045", var_192_7)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_320171", "320171045", "story_v_out_320171.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_320171", "320171045", "story_v_out_320171.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_8 = math.max(var_192_1, arg_189_1.talkMaxDuration)

			if var_192_0 <= arg_189_1.time_ and arg_189_1.time_ < var_192_0 + var_192_8 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_0) / var_192_8

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_0 + var_192_8 and arg_189_1.time_ < var_192_0 + var_192_8 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {}

		arg_189_1:InitPlayNodeList()
	end,
	Play320171046 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 320171046
		arg_193_1.duration_ = 4.73

		local var_193_0 = {
			zh = 2.2,
			ja = 4.733
		}
		local var_193_1 = manager.audio:GetLocalizationFlag()

		if var_193_0[var_193_1] ~= nil then
			arg_193_1.duration_ = var_193_0[var_193_1]
		end

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play320171047(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 and not isNil(arg_193_1.actors_["1020ui_story"]) and arg_193_1.var_.characterEffect1020ui_story == nil then
				arg_193_1.var_.characterEffect1020ui_story = arg_193_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_196_0 = 0.200000002980232

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_0 and not isNil(arg_193_1.actors_["1020ui_story"]) then
				if arg_193_1.var_.characterEffect1020ui_story and not isNil(arg_193_1.actors_["1020ui_story"]) then
					arg_193_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_193_1.time_ >= 0 + var_196_0 and arg_193_1.time_ < 0 + var_196_0 + arg_196_0 and not isNil(arg_193_1.actors_["1020ui_story"]) and arg_193_1.var_.characterEffect1020ui_story then
				arg_193_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action6_1")
			end

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_196_2 = arg_193_1.actors_["10101ui_story"]

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 and not isNil(var_196_2) and arg_193_1.var_.characterEffect10101ui_story == nil then
				arg_193_1.var_.characterEffect10101ui_story = var_196_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_196_3 = 0.200000002980232

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_3 and not isNil(var_196_2) then
				if arg_193_1.var_.characterEffect10101ui_story and not isNil(var_196_2) then
					arg_193_1.var_.characterEffect10101ui_story.fillFlat = true
					arg_193_1.var_.characterEffect10101ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_193_1.time_ - 0) / var_196_3)
				end
			end

			if arg_193_1.time_ >= 0 + var_196_3 and arg_193_1.time_ < 0 + var_196_3 + arg_196_0 and not isNil(var_196_2) and arg_193_1.var_.characterEffect10101ui_story then
				arg_193_1.var_.characterEffect10101ui_story.fillFlat = true
				arg_193_1.var_.characterEffect10101ui_story.fillRatio = 0.5
			end

			local var_196_4 = 0
			local var_196_5 = 0.275

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_4 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				arg_193_1.leftNameTxt_.text = arg_193_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_6 = arg_193_1:GetWordFromCfg(320171046)
				local var_196_7 = arg_193_1:FormatText(var_196_6.content)

				arg_193_1.text_.text = var_196_7

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_9 = 11 <= 0 and var_196_5 or var_196_5 * (utf8.len(var_196_7) / 11)

				if (11 <= 0 and var_196_5 or var_196_5 * (utf8.len(var_196_7) / 11)) > 0 and var_196_5 < var_196_9 then
					arg_193_1.talkMaxDuration = var_196_9

					if var_196_9 + var_196_4 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_9 + var_196_4
					end
				end

				arg_193_1.text_.text = var_196_7
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320171", "320171046", "story_v_out_320171.awb") ~= 0 then
					local var_196_10 = manager.audio:GetVoiceLength("story_v_out_320171", "320171046", "story_v_out_320171.awb") / 1000

					if var_196_10 + var_196_4 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_10 + var_196_4
					end

					if var_196_6.prefab_name ~= "" and arg_193_1.actors_[var_196_6.prefab_name] ~= nil then
						local var_196_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_6.prefab_name].transform, "story_v_out_320171", "320171046", "story_v_out_320171.awb")

						arg_193_1:RecordAudio("320171046", var_196_11)
						arg_193_1:RecordAudio("320171046", var_196_11)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_out_320171", "320171046", "story_v_out_320171.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_out_320171", "320171046", "story_v_out_320171.awb")
				end

				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_12 = math.max(var_196_5, arg_193_1.talkMaxDuration)

			if var_196_4 <= arg_193_1.time_ and arg_193_1.time_ < var_196_4 + var_196_12 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_4) / var_196_12

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_4 + var_196_12 and arg_193_1.time_ < var_196_4 + var_196_12 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	Play320171047 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 320171047
		arg_197_1.duration_ = 6.43

		local var_197_0 = {
			zh = 3.233,
			ja = 6.433
		}
		local var_197_1 = manager.audio:GetLocalizationFlag()

		if var_197_0[var_197_1] ~= nil then
			arg_197_1.duration_ = var_197_0[var_197_1]
		end

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play320171048(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 and not isNil(arg_197_1.actors_["1020ui_story"]) and arg_197_1.var_.characterEffect1020ui_story == nil then
				arg_197_1.var_.characterEffect1020ui_story = arg_197_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_0 = 0.200000002980232

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_0 and not isNil(arg_197_1.actors_["1020ui_story"]) then
				if arg_197_1.var_.characterEffect1020ui_story and not isNil(arg_197_1.actors_["1020ui_story"]) then
					arg_197_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_197_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_197_1.time_ - 0) / var_200_0)
				end
			end

			if arg_197_1.time_ >= 0 + var_200_0 and arg_197_1.time_ < 0 + var_200_0 + arg_200_0 and not isNil(arg_197_1.actors_["1020ui_story"]) and arg_197_1.var_.characterEffect1020ui_story then
				arg_197_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_197_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1:AudioAction("stop", "effect", "se_story_activity_1_5_3", "se_story_activity_1_5_3_rain_loop", "")
			end

			local var_200_2 = arg_197_1.actors_["10101ui_story"]

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 and not isNil(var_200_2) and arg_197_1.var_.characterEffect10101ui_story == nil then
				arg_197_1.var_.characterEffect10101ui_story = var_200_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_3 = 0.200000002980232

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_3 and not isNil(var_200_2) then
				if arg_197_1.var_.characterEffect10101ui_story and not isNil(var_200_2) then
					arg_197_1.var_.characterEffect10101ui_story.fillFlat = false
				end
			end

			if arg_197_1.time_ >= 0 + var_200_3 and arg_197_1.time_ < 0 + var_200_3 + arg_200_0 and not isNil(var_200_2) and arg_197_1.var_.characterEffect10101ui_story then
				arg_197_1.var_.characterEffect10101ui_story.fillFlat = false
			end

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1:PlayTimeline("10101ui_story", "StoryTimeline/CharAction/story1022/story1022action/1022action6_2")
			end

			local var_200_5 = 0
			local var_200_6 = 0.3

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= var_200_5 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				arg_197_1.leftNameTxt_.text = arg_197_1:FormatText(StoryNameCfg[1023].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_7 = arg_197_1:GetWordFromCfg(320171047)
				local var_200_8 = arg_197_1:FormatText(var_200_7.content)

				arg_197_1.text_.text = var_200_8

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_10 = 12 <= 0 and var_200_6 or var_200_6 * (utf8.len(var_200_8) / 12)

				if (12 <= 0 and var_200_6 or var_200_6 * (utf8.len(var_200_8) / 12)) > 0 and var_200_6 < var_200_10 then
					arg_197_1.talkMaxDuration = var_200_10

					if var_200_10 + var_200_5 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_10 + var_200_5
					end
				end

				arg_197_1.text_.text = var_200_8
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320171", "320171047", "story_v_out_320171.awb") ~= 0 then
					local var_200_11 = manager.audio:GetVoiceLength("story_v_out_320171", "320171047", "story_v_out_320171.awb") / 1000

					if var_200_11 + var_200_5 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_11 + var_200_5
					end

					if var_200_7.prefab_name ~= "" and arg_197_1.actors_[var_200_7.prefab_name] ~= nil then
						local var_200_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_7.prefab_name].transform, "story_v_out_320171", "320171047", "story_v_out_320171.awb")

						arg_197_1:RecordAudio("320171047", var_200_12)
						arg_197_1:RecordAudio("320171047", var_200_12)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_320171", "320171047", "story_v_out_320171.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_320171", "320171047", "story_v_out_320171.awb")
				end

				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_13 = math.max(var_200_6, arg_197_1.talkMaxDuration)

			if var_200_5 <= arg_197_1.time_ and arg_197_1.time_ < var_200_5 + var_200_13 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_5) / var_200_13

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_5 + var_200_13 and arg_197_1.time_ < var_200_5 + var_200_13 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {}

		arg_197_1:InitPlayNodeList()
	end,
	Play320171048 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 320171048
		arg_201_1.duration_ = 7.87

		local var_201_0 = {
			zh = 7.866,
			ja = 7.7
		}
		local var_201_1 = manager.audio:GetLocalizationFlag()

		if var_201_0[var_201_1] ~= nil then
			arg_201_1.duration_ = var_201_0[var_201_1]
		end

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play320171049(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			if arg_201_1.bgs_.J07g == nil then
				local var_204_0 = Object.Instantiate(arg_201_1.paintGo_)

				var_204_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "J07g")
				var_204_0.name = "J07g"
				var_204_0.transform.parent = arg_201_1.stage_.transform
				var_204_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_201_1.bgs_.J07g = var_204_0
			end

			if 2 < arg_201_1.time_ and arg_201_1.time_ <= 2 + arg_204_0 then
				local var_204_1 = arg_201_1.bgs_.J07g

				arg_201_1.bgs_.J07g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_204_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_204_2 = var_204_1:GetComponent("SpriteRenderer")

				if var_204_2 and var_204_2.sprite then
					local var_204_3 = 2 * (var_204_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_204_1.transform.localScale = Vector3.New(var_204_3 / var_204_2.sprite.bounds.size.y < var_204_3 * manager.ui.mainCameraCom_.aspect / var_204_2.sprite.bounds.size.x and var_204_3 * manager.ui.mainCameraCom_.aspect / var_204_2.sprite.bounds.size.x or var_204_3 / var_204_2.sprite.bounds.size.y, var_204_3 / var_204_2.sprite.bounds.size.y < var_204_3 * manager.ui.mainCameraCom_.aspect / var_204_2.sprite.bounds.size.x and var_204_3 * manager.ui.mainCameraCom_.aspect / var_204_2.sprite.bounds.size.x or var_204_3 / var_204_2.sprite.bounds.size.y, 0)
				end

				for iter_204_0, iter_204_1 in pairs(arg_201_1.bgs_) do
					if iter_204_0 ~= "J07g" then
						iter_204_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_204_4 = 3.999999999999

			if 3.999999999999 < arg_201_1.time_ and arg_201_1.time_ <= var_204_4 + arg_204_0 then
				arg_201_1.allBtn_.enabled = false
			end

			if arg_201_1.time_ >= var_204_4 + 0.3 and arg_201_1.time_ < var_204_4 + 0.3 + arg_204_0 then
				arg_201_1.allBtn_.enabled = true
			end

			local var_204_5 = 0

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= var_204_5 + arg_204_0 then
				arg_201_1.mask_.enabled = true
				arg_201_1.mask_.raycastTarget = true

				arg_201_1:SetGaussion(false)
			end

			local var_204_6 = 2

			if var_204_5 <= arg_201_1.time_ and arg_201_1.time_ < var_204_5 + var_204_6 then
				local var_204_7 = Color.New(0, 0, 0)

				var_204_7.a = Mathf.Lerp(0, 1, (arg_201_1.time_ - var_204_5) / var_204_6)
				arg_201_1.mask_.color = var_204_7
			end

			if arg_201_1.time_ >= var_204_5 + var_204_6 and arg_201_1.time_ < var_204_5 + var_204_6 + arg_204_0 then
				local var_204_8 = Color.New(0, 0, 0)

				var_204_8.a = 1
				arg_201_1.mask_.color = var_204_8
			end

			local var_204_9 = 2

			if 2 < arg_201_1.time_ and arg_201_1.time_ <= var_204_9 + arg_204_0 then
				arg_201_1.mask_.enabled = true
				arg_201_1.mask_.raycastTarget = true

				arg_201_1:SetGaussion(false)
			end

			local var_204_10 = 2

			if var_204_9 <= arg_201_1.time_ and arg_201_1.time_ < var_204_9 + var_204_10 then
				local var_204_11 = Color.New(0, 0, 0)

				var_204_11.a = Mathf.Lerp(1, 0, (arg_201_1.time_ - var_204_9) / var_204_10)
				arg_201_1.mask_.color = var_204_11
			end

			if arg_201_1.time_ >= var_204_9 + var_204_10 and arg_201_1.time_ < var_204_9 + var_204_10 + arg_204_0 then
				local var_204_12 = Color.New(0, 0, 0)

				arg_201_1.mask_.enabled = false
				var_204_12.a = 0
				arg_201_1.mask_.color = var_204_12
			end

			local var_204_13 = arg_201_1.actors_["1020ui_story"].transform

			if 1.96599999815226 < arg_201_1.time_ and arg_201_1.time_ <= 1.96599999815226 + arg_204_0 then
				arg_201_1.var_.moveOldPos1020ui_story = var_204_13.localPosition
			end

			local var_204_14 = 0.001

			if 1.96599999815226 <= arg_201_1.time_ and arg_201_1.time_ < 1.96599999815226 + var_204_14 then
				var_204_13.localPosition = Vector3.Lerp(arg_201_1.var_.moveOldPos1020ui_story, Vector3.New(0, 100, 0), (arg_201_1.time_ - 1.96599999815226) / var_204_14)
				var_204_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_204_13.position).x, (manager.ui.mainCamera.transform.position - var_204_13.position).y, (manager.ui.mainCamera.transform.position - var_204_13.position).z)
				var_204_13.localEulerAngles.z = 0
				var_204_13.localEulerAngles.x = 0
				var_204_13.localEulerAngles = var_204_13.localEulerAngles
			end

			if arg_201_1.time_ >= 1.96599999815226 + var_204_14 and arg_201_1.time_ < 1.96599999815226 + var_204_14 + arg_204_0 then
				var_204_13.localPosition = Vector3.New(0, 100, 0)
				var_204_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_204_13.position).x, (manager.ui.mainCamera.transform.position - var_204_13.position).y, (manager.ui.mainCamera.transform.position - var_204_13.position).z)
				var_204_13.localEulerAngles.z = 0
				var_204_13.localEulerAngles.x = 0
				var_204_13.localEulerAngles = var_204_13.localEulerAngles
			end

			local var_204_15 = arg_201_1.actors_["1020ui_story"]

			if 1.96599999815226 < arg_201_1.time_ and arg_201_1.time_ <= 1.96599999815226 + arg_204_0 and not isNil(var_204_15) and arg_201_1.var_.characterEffect1020ui_story == nil then
				arg_201_1.var_.characterEffect1020ui_story = var_204_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_204_16 = 0.034000001847744

			if 1.96599999815226 <= arg_201_1.time_ and arg_201_1.time_ < 1.96599999815226 + var_204_16 and not isNil(var_204_15) then
				if arg_201_1.var_.characterEffect1020ui_story and not isNil(var_204_15) then
					arg_201_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_201_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_201_1.time_ - 1.96599999815226) / var_204_16)
				end
			end

			if arg_201_1.time_ >= 1.96599999815226 + var_204_16 and arg_201_1.time_ < 1.96599999815226 + var_204_16 + arg_204_0 and not isNil(var_204_15) and arg_201_1.var_.characterEffect1020ui_story then
				arg_201_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_201_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_204_17 = arg_201_1.actors_["10101ui_story"].transform

			if 1.96599999815226 < arg_201_1.time_ and arg_201_1.time_ <= 1.96599999815226 + arg_204_0 then
				arg_201_1.var_.moveOldPos10101ui_story = var_204_17.localPosition
			end

			local var_204_18 = 0.001

			if 1.96599999815226 <= arg_201_1.time_ and arg_201_1.time_ < 1.96599999815226 + var_204_18 then
				var_204_17.localPosition = Vector3.Lerp(arg_201_1.var_.moveOldPos10101ui_story, Vector3.New(0, 100, 0), (arg_201_1.time_ - 1.96599999815226) / var_204_18)
				var_204_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_204_17.position).x, (manager.ui.mainCamera.transform.position - var_204_17.position).y, (manager.ui.mainCamera.transform.position - var_204_17.position).z)
				var_204_17.localEulerAngles.z = 0
				var_204_17.localEulerAngles.x = 0
				var_204_17.localEulerAngles = var_204_17.localEulerAngles
			end

			if arg_201_1.time_ >= 1.96599999815226 + var_204_18 and arg_201_1.time_ < 1.96599999815226 + var_204_18 + arg_204_0 then
				var_204_17.localPosition = Vector3.New(0, 100, 0)
				var_204_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_204_17.position).x, (manager.ui.mainCamera.transform.position - var_204_17.position).y, (manager.ui.mainCamera.transform.position - var_204_17.position).z)
				var_204_17.localEulerAngles.z = 0
				var_204_17.localEulerAngles.x = 0
				var_204_17.localEulerAngles = var_204_17.localEulerAngles
			end

			local var_204_19 = arg_201_1.actors_["10101ui_story"]

			if 1.96599999815226 < arg_201_1.time_ and arg_201_1.time_ <= 1.96599999815226 + arg_204_0 and not isNil(var_204_19) and arg_201_1.var_.characterEffect10101ui_story == nil then
				arg_201_1.var_.characterEffect10101ui_story = var_204_19:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_204_20 = 0.034000001847744

			if 1.96599999815226 <= arg_201_1.time_ and arg_201_1.time_ < 1.96599999815226 + var_204_20 and not isNil(var_204_19) then
				if arg_201_1.var_.characterEffect10101ui_story and not isNil(var_204_19) then
					arg_201_1.var_.characterEffect10101ui_story.fillFlat = true
					arg_201_1.var_.characterEffect10101ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_201_1.time_ - 1.96599999815226) / var_204_20)
				end
			end

			if arg_201_1.time_ >= 1.96599999815226 + var_204_20 and arg_201_1.time_ < 1.96599999815226 + var_204_20 + arg_204_0 and not isNil(var_204_19) and arg_201_1.var_.characterEffect10101ui_story then
				arg_201_1.var_.characterEffect10101ui_story.fillFlat = true
				arg_201_1.var_.characterEffect10101ui_story.fillRatio = 0.5
			end

			local var_204_21 = "10037ui_story"

			if arg_201_1.actors_["10037ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10037ui_story"))) then
				local var_204_22 = Object.Instantiate(Asset.Load("Char/" .. "10037ui_story"), arg_201_1.stage_.transform)

				var_204_22.name = var_204_21
				var_204_22.transform.localPosition = Vector3.New(0, 100, 0)
				arg_201_1.actors_[var_204_21] = var_204_22

				local var_204_23 = var_204_22:GetComponentInChildren(typeof(CharacterEffect))

				var_204_23.enabled = true

				local var_204_24 = GameObjectTools.GetOrAddComponent(var_204_22, typeof(DynamicBoneHelper))

				if var_204_24 then
					var_204_24:EnableDynamicBone(false)
				end

				arg_201_1:ShowWeapon(var_204_23.transform, false)

				arg_201_1.var_[var_204_21 .. "Animator"] = var_204_23.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_201_1.var_[var_204_21 .. "Animator"].applyRootMotion = true
				arg_201_1.var_[var_204_21 .. "LipSync"] = var_204_23.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_204_25 = arg_201_1.actors_["10037ui_story"].transform

			if 3.8 < arg_201_1.time_ and arg_201_1.time_ <= 3.8 + arg_204_0 then
				arg_201_1.var_.moveOldPos10037ui_story = var_204_25.localPosition
			end

			local var_204_26 = 0.001

			if 3.8 <= arg_201_1.time_ and arg_201_1.time_ < 3.8 + var_204_26 then
				var_204_25.localPosition = Vector3.Lerp(arg_201_1.var_.moveOldPos10037ui_story, Vector3.New(0, -1.13, -6.2), (arg_201_1.time_ - 3.8) / var_204_26)
				var_204_25.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_204_25.position).x, (manager.ui.mainCamera.transform.position - var_204_25.position).y, (manager.ui.mainCamera.transform.position - var_204_25.position).z)
				var_204_25.localEulerAngles.z = 0
				var_204_25.localEulerAngles.x = 0
				var_204_25.localEulerAngles = var_204_25.localEulerAngles
			end

			if arg_201_1.time_ >= 3.8 + var_204_26 and arg_201_1.time_ < 3.8 + var_204_26 + arg_204_0 then
				var_204_25.localPosition = Vector3.New(0, -1.13, -6.2)
				var_204_25.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_204_25.position).x, (manager.ui.mainCamera.transform.position - var_204_25.position).y, (manager.ui.mainCamera.transform.position - var_204_25.position).z)
				var_204_25.localEulerAngles.z = 0
				var_204_25.localEulerAngles.x = 0
				var_204_25.localEulerAngles = var_204_25.localEulerAngles
			end

			local var_204_27 = arg_201_1.actors_["10037ui_story"]

			if 3.8 < arg_201_1.time_ and arg_201_1.time_ <= 3.8 + arg_204_0 and not isNil(var_204_27) and arg_201_1.var_.characterEffect10037ui_story == nil then
				arg_201_1.var_.characterEffect10037ui_story = var_204_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_204_28 = 0.200000002980232

			if 3.8 <= arg_201_1.time_ and arg_201_1.time_ < 3.8 + var_204_28 and not isNil(var_204_27) then
				if arg_201_1.var_.characterEffect10037ui_story and not isNil(var_204_27) then
					arg_201_1.var_.characterEffect10037ui_story.fillFlat = false
				end
			end

			if arg_201_1.time_ >= 3.8 + var_204_28 and arg_201_1.time_ < 3.8 + var_204_28 + arg_204_0 and not isNil(var_204_27) and arg_201_1.var_.characterEffect10037ui_story then
				arg_201_1.var_.characterEffect10037ui_story.fillFlat = false
			end

			if 3.8 < arg_201_1.time_ and arg_201_1.time_ <= 3.8 + arg_204_0 then
				arg_201_1:PlayTimeline("10037ui_story", "StoryTimeline/CharAction/story10037/story10037action/10037action2_1")
			end

			if 3.8 < arg_201_1.time_ and arg_201_1.time_ <= 3.8 + arg_204_0 then
				arg_201_1:PlayTimeline("10037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			if 2 < arg_201_1.time_ and arg_201_1.time_ <= 2 + arg_204_0 then
				if arg_201_1.var_.effectxiayu18 then
					Object.Destroy(arg_201_1.var_.effectxiayu18)

					arg_201_1.var_.effectxiayu18 = nil
				end
			end

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_204_33 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_201_1.bgmTxt_.text ~= var_204_33 and arg_201_1.bgmTxt_.text ~= "" then
						if arg_201_1.bgmTxt2_.text ~= "" then
							arg_201_1.bgmTxt_.text = arg_201_1.bgmTxt2_.text
						end

						arg_201_1.bgmTxt2_.text = var_204_33

						arg_201_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_201_1.bgmTxt_.text = var_204_33
						arg_201_1.bgmTxt2_.text = var_204_33
					end

					if arg_201_1.bgmTimer then
						arg_201_1.bgmTimer:Stop()

						arg_201_1.bgmTimer = nil
					end

					if arg_201_1.settingData.show_music_name == 1 then
						arg_201_1.musicController:SetSelectedState("show")
						arg_201_1.musicAnimator_:Play("open", 0, 0)

						if arg_201_1.settingData.music_time ~= 0 then
							arg_201_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_201_1.settingData.music_time), function()
								if arg_201_1 == nil or isNil(arg_201_1.bgmTxt_) then
									return
								end

								arg_201_1.musicController:SetSelectedState("hide")
								arg_201_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 1.33333333333333 < arg_201_1.time_ and arg_201_1.time_ <= 1.33333333333333 + arg_204_0 then
				arg_201_1:AudioAction("play", "music", "bgm_story_scheme", "bgm_story_scheme", "bgm_story_scheme.awb")

				local var_204_36 = manager.audio:GetAudioName("bgm_story_scheme", "bgm_story_scheme")

				if "" ~= "" then
					if arg_201_1.bgmTxt_.text ~= var_204_36 and arg_201_1.bgmTxt_.text ~= "" then
						if arg_201_1.bgmTxt2_.text ~= "" then
							arg_201_1.bgmTxt_.text = arg_201_1.bgmTxt2_.text
						end

						arg_201_1.bgmTxt2_.text = var_204_36

						arg_201_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_201_1.bgmTxt_.text = var_204_36
						arg_201_1.bgmTxt2_.text = var_204_36
					end

					if arg_201_1.bgmTimer then
						arg_201_1.bgmTimer:Stop()

						arg_201_1.bgmTimer = nil
					end

					if arg_201_1.settingData.show_music_name == 1 then
						arg_201_1.musicController:SetSelectedState("show")
						arg_201_1.musicAnimator_:Play("open", 0, 0)

						if arg_201_1.settingData.music_time ~= 0 then
							arg_201_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_201_1.settingData.music_time), function()
								if arg_201_1 == nil or isNil(arg_201_1.bgmTxt_) then
									return
								end

								arg_201_1.musicController:SetSelectedState("hide")
								arg_201_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_201_1.frameCnt_ <= 1 then
				arg_201_1.dialog_:SetActive(false)
			end

			local var_204_37 = 4
			local var_204_38 = 0.375

			if 4 < arg_201_1.time_ and arg_201_1.time_ <= var_204_37 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0

				arg_201_1.dialog_:SetActive(true)

				arg_201_1.dialogCg_.alpha = 0

				local var_204_39 = LeanTween.value(arg_201_1.dialog_, 0, 1, 0.3)

				var_204_39:setOnUpdate(LuaHelper.FloatAction(function(arg_207_0)
					arg_201_1.dialogCg_.alpha = arg_207_0
				end))
				var_204_39:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_201_1.dialog_)
					var_204_39:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_201_1.duration_ = arg_201_1.duration_ + 0.3

				SetActive(arg_201_1.leftNameGo_, true)

				arg_201_1.leftNameTxt_.text = arg_201_1:FormatText(StoryNameCfg[383].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_40 = arg_201_1:GetWordFromCfg(320171048)
				local var_204_41 = arg_201_1:FormatText(var_204_40.content)

				arg_201_1.text_.text = var_204_41

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_43 = 15 <= 0 and var_204_38 or var_204_38 * (utf8.len(var_204_41) / 15)

				if (15 <= 0 and var_204_38 or var_204_38 * (utf8.len(var_204_41) / 15)) > 0 and var_204_38 < var_204_43 then
					arg_201_1.talkMaxDuration = var_204_43
					var_204_37 = var_204_37 + 0.3

					if var_204_43 + var_204_37 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_43 + var_204_37
					end
				end

				arg_201_1.text_.text = var_204_41
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320171", "320171048", "story_v_out_320171.awb") ~= 0 then
					local var_204_44 = manager.audio:GetVoiceLength("story_v_out_320171", "320171048", "story_v_out_320171.awb") / 1000

					if var_204_44 + var_204_37 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_44 + var_204_37
					end

					if var_204_40.prefab_name ~= "" and arg_201_1.actors_[var_204_40.prefab_name] ~= nil then
						local var_204_45 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_40.prefab_name].transform, "story_v_out_320171", "320171048", "story_v_out_320171.awb")

						arg_201_1:RecordAudio("320171048", var_204_45)
						arg_201_1:RecordAudio("320171048", var_204_45)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_out_320171", "320171048", "story_v_out_320171.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_out_320171", "320171048", "story_v_out_320171.awb")
				end

				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_46 = var_204_37 + 0.3
			local var_204_47 = math.max(var_204_38, arg_201_1.talkMaxDuration)

			if var_204_37 + 0.3 <= arg_201_1.time_ and arg_201_1.time_ < var_204_46 + var_204_47 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_46) / var_204_47

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_46 + var_204_47 and arg_201_1.time_ < var_204_46 + var_204_47 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10101ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_201_1:InitPlayNodeList()
	end,
	Play320171049 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 320171049
		arg_209_1.duration_ = 11.3

		local var_209_0 = {
			zh = 10.266,
			ja = 11.3
		}
		local var_209_1 = manager.audio:GetLocalizationFlag()

		if var_209_0[var_209_1] ~= nil then
			arg_209_1.duration_ = var_209_0[var_209_1]
		end

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play320171050(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 and not isNil(arg_209_1.actors_["10037ui_story"]) and arg_209_1.var_.characterEffect10037ui_story == nil then
				arg_209_1.var_.characterEffect10037ui_story = arg_209_1.actors_["10037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_212_0 = 0.200000002980232

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_0 and not isNil(arg_209_1.actors_["10037ui_story"]) then
				if arg_209_1.var_.characterEffect10037ui_story and not isNil(arg_209_1.actors_["10037ui_story"]) then
					arg_209_1.var_.characterEffect10037ui_story.fillFlat = true
					arg_209_1.var_.characterEffect10037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_209_1.time_ - 0) / var_212_0)
				end
			end

			if arg_209_1.time_ >= 0 + var_212_0 and arg_209_1.time_ < 0 + var_212_0 + arg_212_0 and not isNil(arg_209_1.actors_["10037ui_story"]) and arg_209_1.var_.characterEffect10037ui_story then
				arg_209_1.var_.characterEffect10037ui_story.fillFlat = true
				arg_209_1.var_.characterEffect10037ui_story.fillRatio = 0.5
			end

			local var_212_1 = 0
			local var_212_2 = 0.8

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= var_212_1 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				arg_209_1.leftNameTxt_.text = arg_209_1:FormatText(StoryNameCfg[600].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, true)
				arg_209_1.iconController_:SetSelectedState("hero")

				arg_209_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10062")

				arg_209_1.callingController_:SetSelectedState("normal")

				arg_209_1.keyicon_.color = Color.New(1, 1, 1)
				arg_209_1.icon_.color = Color.New(1, 1, 1)

				local var_212_3 = arg_209_1:GetWordFromCfg(320171049)
				local var_212_4 = arg_209_1:FormatText(var_212_3.content)

				arg_209_1.text_.text = var_212_4

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_6 = 32 <= 0 and var_212_2 or var_212_2 * (utf8.len(var_212_4) / 32)

				if (32 <= 0 and var_212_2 or var_212_2 * (utf8.len(var_212_4) / 32)) > 0 and var_212_2 < var_212_6 then
					arg_209_1.talkMaxDuration = var_212_6

					if var_212_6 + var_212_1 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_6 + var_212_1
					end
				end

				arg_209_1.text_.text = var_212_4
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320171", "320171049", "story_v_out_320171.awb") ~= 0 then
					local var_212_7 = manager.audio:GetVoiceLength("story_v_out_320171", "320171049", "story_v_out_320171.awb") / 1000

					if var_212_7 + var_212_1 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_7 + var_212_1
					end

					if var_212_3.prefab_name ~= "" and arg_209_1.actors_[var_212_3.prefab_name] ~= nil then
						local var_212_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_3.prefab_name].transform, "story_v_out_320171", "320171049", "story_v_out_320171.awb")

						arg_209_1:RecordAudio("320171049", var_212_8)
						arg_209_1:RecordAudio("320171049", var_212_8)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_out_320171", "320171049", "story_v_out_320171.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_out_320171", "320171049", "story_v_out_320171.awb")
				end

				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_9 = math.max(var_212_2, arg_209_1.talkMaxDuration)

			if var_212_1 <= arg_209_1.time_ and arg_209_1.time_ < var_212_1 + var_212_9 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_1) / var_212_9

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_1 + var_212_9 and arg_209_1.time_ < var_212_1 + var_212_9 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {}

		arg_209_1:InitPlayNodeList()
	end,
	Play320171050 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 320171050
		arg_213_1.duration_ = 18.93

		local var_213_0 = {
			zh = 10.5,
			ja = 18.933
		}
		local var_213_1 = manager.audio:GetLocalizationFlag()

		if var_213_0[var_213_1] ~= nil then
			arg_213_1.duration_ = var_213_0[var_213_1]
		end

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play320171051(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = 0.925

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				arg_213_1.leftNameTxt_.text = arg_213_1:FormatText(StoryNameCfg[600].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, true)
				arg_213_1.iconController_:SetSelectedState("hero")

				arg_213_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10062")

				arg_213_1.callingController_:SetSelectedState("normal")

				arg_213_1.keyicon_.color = Color.New(1, 1, 1)
				arg_213_1.icon_.color = Color.New(1, 1, 1)

				local var_216_1 = arg_213_1:GetWordFromCfg(320171050)
				local var_216_2 = arg_213_1:FormatText(var_216_1.content)

				arg_213_1.text_.text = var_216_2

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_4 = 37 <= 0 and var_216_0 or var_216_0 * (utf8.len(var_216_2) / 37)

				if (37 <= 0 and var_216_0 or var_216_0 * (utf8.len(var_216_2) / 37)) > 0 and var_216_0 < var_216_4 then
					arg_213_1.talkMaxDuration = var_216_4

					if var_216_4 + 0 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_4 + 0
					end
				end

				arg_213_1.text_.text = var_216_2
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320171", "320171050", "story_v_out_320171.awb") ~= 0 then
					local var_216_5 = manager.audio:GetVoiceLength("story_v_out_320171", "320171050", "story_v_out_320171.awb") / 1000

					if var_216_5 + 0 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_5 + 0
					end

					if var_216_1.prefab_name ~= "" and arg_213_1.actors_[var_216_1.prefab_name] ~= nil then
						local var_216_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_1.prefab_name].transform, "story_v_out_320171", "320171050", "story_v_out_320171.awb")

						arg_213_1:RecordAudio("320171050", var_216_6)
						arg_213_1:RecordAudio("320171050", var_216_6)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_out_320171", "320171050", "story_v_out_320171.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_out_320171", "320171050", "story_v_out_320171.awb")
				end

				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_7 = math.max(var_216_0, arg_213_1.talkMaxDuration)

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_7 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - 0) / var_216_7

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= 0 + var_216_7 and arg_213_1.time_ < 0 + var_216_7 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {}

		arg_213_1:InitPlayNodeList()
	end,
	Play320171051 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 320171051
		arg_217_1.duration_ = 5

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play320171052(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1.var_.moveOldPos10037ui_story = arg_217_1.actors_["10037ui_story"].transform.localPosition
			end

			local var_220_0 = 0.001

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_0 then
				arg_217_1.actors_["10037ui_story"].transform.localPosition = Vector3.Lerp(arg_217_1.var_.moveOldPos10037ui_story, Vector3.New(0, 100, 0), (arg_217_1.time_ - 0) / var_220_0)
				arg_217_1.actors_["10037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_217_1.actors_["10037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_217_1.actors_["10037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_217_1.actors_["10037ui_story"].transform.position).z)
				arg_217_1.actors_["10037ui_story"].transform.localEulerAngles.z = 0
				arg_217_1.actors_["10037ui_story"].transform.localEulerAngles.x = 0
				arg_217_1.actors_["10037ui_story"].transform.localEulerAngles = arg_217_1.actors_["10037ui_story"].transform.localEulerAngles
			end

			if arg_217_1.time_ >= 0 + var_220_0 and arg_217_1.time_ < 0 + var_220_0 + arg_220_0 then
				arg_217_1.actors_["10037ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_217_1.actors_["10037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_217_1.actors_["10037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_217_1.actors_["10037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_217_1.actors_["10037ui_story"].transform.position).z)
				arg_217_1.actors_["10037ui_story"].transform.localEulerAngles.z = 0
				arg_217_1.actors_["10037ui_story"].transform.localEulerAngles.x = 0
				arg_217_1.actors_["10037ui_story"].transform.localEulerAngles = arg_217_1.actors_["10037ui_story"].transform.localEulerAngles
			end

			local var_220_1 = arg_217_1.actors_["10037ui_story"]

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 and not isNil(var_220_1) and arg_217_1.var_.characterEffect10037ui_story == nil then
				arg_217_1.var_.characterEffect10037ui_story = var_220_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_220_2 = 0.200000002980232

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_2 and not isNil(var_220_1) then
				if arg_217_1.var_.characterEffect10037ui_story and not isNil(var_220_1) then
					arg_217_1.var_.characterEffect10037ui_story.fillFlat = true
					arg_217_1.var_.characterEffect10037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_217_1.time_ - 0) / var_220_2)
				end
			end

			if arg_217_1.time_ >= 0 + var_220_2 and arg_217_1.time_ < 0 + var_220_2 + arg_220_0 and not isNil(var_220_1) and arg_217_1.var_.characterEffect10037ui_story then
				arg_217_1.var_.characterEffect10037ui_story.fillFlat = true
				arg_217_1.var_.characterEffect10037ui_story.fillRatio = 0.5
			end

			local var_220_3 = 0
			local var_220_4 = 1.025

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= var_220_3 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, false)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_5 = arg_217_1:FormatText(arg_217_1:GetWordFromCfg(320171051).content)

				arg_217_1.text_.text = var_220_5

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_7 = 41 <= 0 and var_220_4 or var_220_4 * (utf8.len(var_220_5) / 41)

				if (41 <= 0 and var_220_4 or var_220_4 * (utf8.len(var_220_5) / 41)) > 0 and var_220_4 < var_220_7 then
					arg_217_1.talkMaxDuration = var_220_7

					if var_220_7 + var_220_3 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_7 + var_220_3
					end
				end

				arg_217_1.text_.text = var_220_5
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)
				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_8 = math.max(var_220_4, arg_217_1.talkMaxDuration)

			if var_220_3 <= arg_217_1.time_ and arg_217_1.time_ < var_220_3 + var_220_8 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_3) / var_220_8

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_3 + var_220_8 and arg_217_1.time_ < var_220_3 + var_220_8 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_217_1:InitPlayNodeList()
	end,
	Play320171052 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 320171052
		arg_221_1.duration_ = 14.47

		local var_221_0 = {
			zh = 8.433,
			ja = 14.466
		}
		local var_221_1 = manager.audio:GetLocalizationFlag()

		if var_221_0[var_221_1] ~= nil then
			arg_221_1.duration_ = var_221_0[var_221_1]
		end

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play320171053(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_0 = 0.575

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				arg_221_1.leftNameTxt_.text = arg_221_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, true)
				arg_221_1.iconController_:SetSelectedState("hero")

				arg_221_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_221_1.callingController_:SetSelectedState("normal")

				arg_221_1.keyicon_.color = Color.New(1, 1, 1)
				arg_221_1.icon_.color = Color.New(1, 1, 1)

				local var_224_1 = arg_221_1:GetWordFromCfg(320171052)
				local var_224_2 = arg_221_1:FormatText(var_224_1.content)

				arg_221_1.text_.text = var_224_2

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_4 = 23 <= 0 and var_224_0 or var_224_0 * (utf8.len(var_224_2) / 23)

				if (23 <= 0 and var_224_0 or var_224_0 * (utf8.len(var_224_2) / 23)) > 0 and var_224_0 < var_224_4 then
					arg_221_1.talkMaxDuration = var_224_4

					if var_224_4 + 0 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_4 + 0
					end
				end

				arg_221_1.text_.text = var_224_2
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320171", "320171052", "story_v_out_320171.awb") ~= 0 then
					local var_224_5 = manager.audio:GetVoiceLength("story_v_out_320171", "320171052", "story_v_out_320171.awb") / 1000

					if var_224_5 + 0 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_5 + 0
					end

					if var_224_1.prefab_name ~= "" and arg_221_1.actors_[var_224_1.prefab_name] ~= nil then
						local var_224_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_1.prefab_name].transform, "story_v_out_320171", "320171052", "story_v_out_320171.awb")

						arg_221_1:RecordAudio("320171052", var_224_6)
						arg_221_1:RecordAudio("320171052", var_224_6)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_out_320171", "320171052", "story_v_out_320171.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_out_320171", "320171052", "story_v_out_320171.awb")
				end

				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_7 = math.max(var_224_0, arg_221_1.talkMaxDuration)

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_7 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - 0) / var_224_7

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= 0 + var_224_7 and arg_221_1.time_ < 0 + var_224_7 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {}

		arg_221_1:InitPlayNodeList()
	end,
	Play320171053 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 320171053
		arg_225_1.duration_ = 10.6

		local var_225_0 = {
			zh = 9.366,
			ja = 10.6
		}
		local var_225_1 = manager.audio:GetLocalizationFlag()

		if var_225_0[var_225_1] ~= nil then
			arg_225_1.duration_ = var_225_0[var_225_1]
		end

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play320171054(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = 0.675

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				arg_225_1.leftNameTxt_.text = arg_225_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, true)
				arg_225_1.iconController_:SetSelectedState("hero")

				arg_225_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_225_1.callingController_:SetSelectedState("normal")

				arg_225_1.keyicon_.color = Color.New(1, 1, 1)
				arg_225_1.icon_.color = Color.New(1, 1, 1)

				local var_228_1 = arg_225_1:GetWordFromCfg(320171053)
				local var_228_2 = arg_225_1:FormatText(var_228_1.content)

				arg_225_1.text_.text = var_228_2

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_4 = 27 <= 0 and var_228_0 or var_228_0 * (utf8.len(var_228_2) / 27)

				if (27 <= 0 and var_228_0 or var_228_0 * (utf8.len(var_228_2) / 27)) > 0 and var_228_0 < var_228_4 then
					arg_225_1.talkMaxDuration = var_228_4

					if var_228_4 + 0 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_4 + 0
					end
				end

				arg_225_1.text_.text = var_228_2
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320171", "320171053", "story_v_out_320171.awb") ~= 0 then
					local var_228_5 = manager.audio:GetVoiceLength("story_v_out_320171", "320171053", "story_v_out_320171.awb") / 1000

					if var_228_5 + 0 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_5 + 0
					end

					if var_228_1.prefab_name ~= "" and arg_225_1.actors_[var_228_1.prefab_name] ~= nil then
						local var_228_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_225_1.actors_[var_228_1.prefab_name].transform, "story_v_out_320171", "320171053", "story_v_out_320171.awb")

						arg_225_1:RecordAudio("320171053", var_228_6)
						arg_225_1:RecordAudio("320171053", var_228_6)
					else
						arg_225_1:AudioAction("play", "voice", "story_v_out_320171", "320171053", "story_v_out_320171.awb")
					end

					arg_225_1:RecordHistoryTalkVoice("story_v_out_320171", "320171053", "story_v_out_320171.awb")
				end

				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_7 = math.max(var_228_0, arg_225_1.talkMaxDuration)

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_7 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - 0) / var_228_7

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= 0 + var_228_7 and arg_225_1.time_ < 0 + var_228_7 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {}

		arg_225_1:InitPlayNodeList()
	end,
	Play320171054 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 320171054
		arg_229_1.duration_ = 18.6

		local var_229_0 = {
			zh = 11.3,
			ja = 18.6
		}
		local var_229_1 = manager.audio:GetLocalizationFlag()

		if var_229_0[var_229_1] ~= nil then
			arg_229_1.duration_ = var_229_0[var_229_1]
		end

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play320171055(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = 0.975

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				arg_229_1.leftNameTxt_.text = arg_229_1:FormatText(StoryNameCfg[600].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, true)
				arg_229_1.iconController_:SetSelectedState("hero")

				arg_229_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10062")

				arg_229_1.callingController_:SetSelectedState("normal")

				arg_229_1.keyicon_.color = Color.New(1, 1, 1)
				arg_229_1.icon_.color = Color.New(1, 1, 1)

				local var_232_1 = arg_229_1:GetWordFromCfg(320171054)
				local var_232_2 = arg_229_1:FormatText(var_232_1.content)

				arg_229_1.text_.text = var_232_2

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_4 = 39 <= 0 and var_232_0 or var_232_0 * (utf8.len(var_232_2) / 39)

				if (39 <= 0 and var_232_0 or var_232_0 * (utf8.len(var_232_2) / 39)) > 0 and var_232_0 < var_232_4 then
					arg_229_1.talkMaxDuration = var_232_4

					if var_232_4 + 0 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_4 + 0
					end
				end

				arg_229_1.text_.text = var_232_2
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320171", "320171054", "story_v_out_320171.awb") ~= 0 then
					local var_232_5 = manager.audio:GetVoiceLength("story_v_out_320171", "320171054", "story_v_out_320171.awb") / 1000

					if var_232_5 + 0 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_5 + 0
					end

					if var_232_1.prefab_name ~= "" and arg_229_1.actors_[var_232_1.prefab_name] ~= nil then
						local var_232_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_1.prefab_name].transform, "story_v_out_320171", "320171054", "story_v_out_320171.awb")

						arg_229_1:RecordAudio("320171054", var_232_6)
						arg_229_1:RecordAudio("320171054", var_232_6)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_out_320171", "320171054", "story_v_out_320171.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_out_320171", "320171054", "story_v_out_320171.awb")
				end

				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_7 = math.max(var_232_0, arg_229_1.talkMaxDuration)

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_7 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - 0) / var_232_7

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= 0 + var_232_7 and arg_229_1.time_ < 0 + var_232_7 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {}

		arg_229_1:InitPlayNodeList()
	end,
	Play320171055 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 320171055
		arg_233_1.duration_ = 8.37

		local var_233_0 = {
			zh = 8.366,
			ja = 8.133
		}
		local var_233_1 = manager.audio:GetLocalizationFlag()

		if var_233_0[var_233_1] ~= nil then
			arg_233_1.duration_ = var_233_0[var_233_1]
		end

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play320171056(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			if arg_233_1.actors_["10045ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10045ui_story"))) then
				local var_236_0 = Object.Instantiate(Asset.Load("Char/" .. "10045ui_story"), arg_233_1.stage_.transform)

				var_236_0.name = "10045ui_story"
				var_236_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_233_1.actors_["10045ui_story"] = var_236_0

				local var_236_1 = var_236_0:GetComponentInChildren(typeof(CharacterEffect))

				var_236_1.enabled = true

				local var_236_2 = GameObjectTools.GetOrAddComponent(var_236_0, typeof(DynamicBoneHelper))

				if var_236_2 then
					var_236_2:EnableDynamicBone(false)
				end

				arg_233_1:ShowWeapon(var_236_1.transform, false)

				arg_233_1.var_["10045ui_story" .. "Animator"] = var_236_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_233_1.var_["10045ui_story" .. "Animator"].applyRootMotion = true
				arg_233_1.var_["10045ui_story" .. "LipSync"] = var_236_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_236_3 = arg_233_1.actors_["10045ui_story"].transform

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1.var_.moveOldPos10045ui_story = var_236_3.localPosition
			end

			local var_236_4 = 0.001

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_4 then
				var_236_3.localPosition = Vector3.Lerp(arg_233_1.var_.moveOldPos10045ui_story, Vector3.New(0, -1.18, -6.05), (arg_233_1.time_ - 0) / var_236_4)
				var_236_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_236_3.position).x, (manager.ui.mainCamera.transform.position - var_236_3.position).y, (manager.ui.mainCamera.transform.position - var_236_3.position).z)
				var_236_3.localEulerAngles.z = 0
				var_236_3.localEulerAngles.x = 0
				var_236_3.localEulerAngles = var_236_3.localEulerAngles
			end

			if arg_233_1.time_ >= 0 + var_236_4 and arg_233_1.time_ < 0 + var_236_4 + arg_236_0 then
				var_236_3.localPosition = Vector3.New(0, -1.18, -6.05)
				var_236_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_236_3.position).x, (manager.ui.mainCamera.transform.position - var_236_3.position).y, (manager.ui.mainCamera.transform.position - var_236_3.position).z)
				var_236_3.localEulerAngles.z = 0
				var_236_3.localEulerAngles.x = 0
				var_236_3.localEulerAngles = var_236_3.localEulerAngles
			end

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1:PlayTimeline("10045ui_story", "StoryTimeline/CharAction/story10045/story10045action/10045action4_1")
			end

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1:PlayTimeline("10045ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_236_5 = arg_233_1.actors_["10045ui_story"]

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 and not isNil(var_236_5) and arg_233_1.var_.characterEffect10045ui_story == nil then
				arg_233_1.var_.characterEffect10045ui_story = var_236_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_236_6 = 0.2

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_6 and not isNil(var_236_5) then
				if arg_233_1.var_.characterEffect10045ui_story and not isNil(var_236_5) then
					arg_233_1.var_.characterEffect10045ui_story.fillFlat = false
				end
			end

			if arg_233_1.time_ >= 0 + var_236_6 and arg_233_1.time_ < 0 + var_236_6 + arg_236_0 and not isNil(var_236_5) and arg_233_1.var_.characterEffect10045ui_story then
				arg_233_1.var_.characterEffect10045ui_story.fillFlat = false
			end

			local var_236_8 = 0
			local var_236_9 = 0.475

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= var_236_8 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				arg_233_1.leftNameTxt_.text = arg_233_1:FormatText(StoryNameCfg[45].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_10 = arg_233_1:GetWordFromCfg(320171055)
				local var_236_11 = arg_233_1:FormatText(var_236_10.content)

				arg_233_1.text_.text = var_236_11

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_13 = 19 <= 0 and var_236_9 or var_236_9 * (utf8.len(var_236_11) / 19)

				if (19 <= 0 and var_236_9 or var_236_9 * (utf8.len(var_236_11) / 19)) > 0 and var_236_9 < var_236_13 then
					arg_233_1.talkMaxDuration = var_236_13

					if var_236_13 + var_236_8 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_13 + var_236_8
					end
				end

				arg_233_1.text_.text = var_236_11
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320171", "320171055", "story_v_out_320171.awb") ~= 0 then
					local var_236_14 = manager.audio:GetVoiceLength("story_v_out_320171", "320171055", "story_v_out_320171.awb") / 1000

					if var_236_14 + var_236_8 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_14 + var_236_8
					end

					if var_236_10.prefab_name ~= "" and arg_233_1.actors_[var_236_10.prefab_name] ~= nil then
						local var_236_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_233_1.actors_[var_236_10.prefab_name].transform, "story_v_out_320171", "320171055", "story_v_out_320171.awb")

						arg_233_1:RecordAudio("320171055", var_236_15)
						arg_233_1:RecordAudio("320171055", var_236_15)
					else
						arg_233_1:AudioAction("play", "voice", "story_v_out_320171", "320171055", "story_v_out_320171.awb")
					end

					arg_233_1:RecordHistoryTalkVoice("story_v_out_320171", "320171055", "story_v_out_320171.awb")
				end

				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_16 = math.max(var_236_9, arg_233_1.talkMaxDuration)

			if var_236_8 <= arg_233_1.time_ and arg_233_1.time_ < var_236_8 + var_236_16 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_8) / var_236_16

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_8 + var_236_16 and arg_233_1.time_ < var_236_8 + var_236_16 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10045ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0333333333333333,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_233_1:InitPlayNodeList()
	end,
	Play320171056 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 320171056
		arg_237_1.duration_ = 13.9

		local var_237_0 = {
			zh = 10.333,
			ja = 13.9
		}
		local var_237_1 = manager.audio:GetLocalizationFlag()

		if var_237_0[var_237_1] ~= nil then
			arg_237_1.duration_ = var_237_0[var_237_1]
		end

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play320171057(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 and not isNil(arg_237_1.actors_["10045ui_story"]) and arg_237_1.var_.characterEffect10045ui_story == nil then
				arg_237_1.var_.characterEffect10045ui_story = arg_237_1.actors_["10045ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_240_0 = 0.2

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_0 and not isNil(arg_237_1.actors_["10045ui_story"]) then
				if arg_237_1.var_.characterEffect10045ui_story and not isNil(arg_237_1.actors_["10045ui_story"]) then
					arg_237_1.var_.characterEffect10045ui_story.fillFlat = true
					arg_237_1.var_.characterEffect10045ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_237_1.time_ - 0) / var_240_0)
				end
			end

			if arg_237_1.time_ >= 0 + var_240_0 and arg_237_1.time_ < 0 + var_240_0 + arg_240_0 and not isNil(arg_237_1.actors_["10045ui_story"]) and arg_237_1.var_.characterEffect10045ui_story then
				arg_237_1.var_.characterEffect10045ui_story.fillFlat = true
				arg_237_1.var_.characterEffect10045ui_story.fillRatio = 0.5
			end

			local var_240_1 = 0
			local var_240_2 = 0.85

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= var_240_1 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				arg_237_1.leftNameTxt_.text = arg_237_1:FormatText(StoryNameCfg[600].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, true)
				arg_237_1.iconController_:SetSelectedState("hero")

				arg_237_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10062")

				arg_237_1.callingController_:SetSelectedState("normal")

				arg_237_1.keyicon_.color = Color.New(1, 1, 1)
				arg_237_1.icon_.color = Color.New(1, 1, 1)

				local var_240_3 = arg_237_1:GetWordFromCfg(320171056)
				local var_240_4 = arg_237_1:FormatText(var_240_3.content)

				arg_237_1.text_.text = var_240_4

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_6 = 34 <= 0 and var_240_2 or var_240_2 * (utf8.len(var_240_4) / 34)

				if (34 <= 0 and var_240_2 or var_240_2 * (utf8.len(var_240_4) / 34)) > 0 and var_240_2 < var_240_6 then
					arg_237_1.talkMaxDuration = var_240_6

					if var_240_6 + var_240_1 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_6 + var_240_1
					end
				end

				arg_237_1.text_.text = var_240_4
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320171", "320171056", "story_v_out_320171.awb") ~= 0 then
					local var_240_7 = manager.audio:GetVoiceLength("story_v_out_320171", "320171056", "story_v_out_320171.awb") / 1000

					if var_240_7 + var_240_1 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_7 + var_240_1
					end

					if var_240_3.prefab_name ~= "" and arg_237_1.actors_[var_240_3.prefab_name] ~= nil then
						local var_240_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_237_1.actors_[var_240_3.prefab_name].transform, "story_v_out_320171", "320171056", "story_v_out_320171.awb")

						arg_237_1:RecordAudio("320171056", var_240_8)
						arg_237_1:RecordAudio("320171056", var_240_8)
					else
						arg_237_1:AudioAction("play", "voice", "story_v_out_320171", "320171056", "story_v_out_320171.awb")
					end

					arg_237_1:RecordHistoryTalkVoice("story_v_out_320171", "320171056", "story_v_out_320171.awb")
				end

				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_9 = math.max(var_240_2, arg_237_1.talkMaxDuration)

			if var_240_1 <= arg_237_1.time_ and arg_237_1.time_ < var_240_1 + var_240_9 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_1) / var_240_9

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_1 + var_240_9 and arg_237_1.time_ < var_240_1 + var_240_9 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {}

		arg_237_1:InitPlayNodeList()
	end,
	Play320171057 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 320171057
		arg_241_1.duration_ = 5.3

		local var_241_0 = {
			zh = 5.066,
			ja = 5.3
		}
		local var_241_1 = manager.audio:GetLocalizationFlag()

		if var_241_0[var_241_1] ~= nil then
			arg_241_1.duration_ = var_241_0[var_241_1]
		end

		SetActive(arg_241_1.tipsGo_, false)

		function arg_241_1.onSingleLineFinish_()
			arg_241_1.onSingleLineUpdate_ = nil
			arg_241_1.onSingleLineFinish_ = nil
			arg_241_1.state_ = "waiting"
		end

		function arg_241_1.playNext_(arg_243_0)
			if arg_243_0 == 1 then
				arg_241_0:Play320171058(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 and not isNil(arg_241_1.actors_["10045ui_story"]) and arg_241_1.var_.characterEffect10045ui_story == nil then
				arg_241_1.var_.characterEffect10045ui_story = arg_241_1.actors_["10045ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_244_0 = 0.2

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_0 and not isNil(arg_241_1.actors_["10045ui_story"]) then
				if arg_241_1.var_.characterEffect10045ui_story and not isNil(arg_241_1.actors_["10045ui_story"]) then
					arg_241_1.var_.characterEffect10045ui_story.fillFlat = false
				end
			end

			if arg_241_1.time_ >= 0 + var_244_0 and arg_241_1.time_ < 0 + var_244_0 + arg_244_0 and not isNil(arg_241_1.actors_["10045ui_story"]) and arg_241_1.var_.characterEffect10045ui_story then
				arg_241_1.var_.characterEffect10045ui_story.fillFlat = false
			end

			local var_244_2 = 0
			local var_244_3 = 0.25

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= var_244_2 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				arg_241_1.leftNameTxt_.text = arg_241_1:FormatText(StoryNameCfg[45].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_4 = arg_241_1:GetWordFromCfg(320171057)
				local var_244_5 = arg_241_1:FormatText(var_244_4.content)

				arg_241_1.text_.text = var_244_5

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_7 = 10 <= 0 and var_244_3 or var_244_3 * (utf8.len(var_244_5) / 10)

				if (10 <= 0 and var_244_3 or var_244_3 * (utf8.len(var_244_5) / 10)) > 0 and var_244_3 < var_244_7 then
					arg_241_1.talkMaxDuration = var_244_7

					if var_244_7 + var_244_2 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_7 + var_244_2
					end
				end

				arg_241_1.text_.text = var_244_5
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320171", "320171057", "story_v_out_320171.awb") ~= 0 then
					local var_244_8 = manager.audio:GetVoiceLength("story_v_out_320171", "320171057", "story_v_out_320171.awb") / 1000

					if var_244_8 + var_244_2 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_8 + var_244_2
					end

					if var_244_4.prefab_name ~= "" and arg_241_1.actors_[var_244_4.prefab_name] ~= nil then
						local var_244_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_241_1.actors_[var_244_4.prefab_name].transform, "story_v_out_320171", "320171057", "story_v_out_320171.awb")

						arg_241_1:RecordAudio("320171057", var_244_9)
						arg_241_1:RecordAudio("320171057", var_244_9)
					else
						arg_241_1:AudioAction("play", "voice", "story_v_out_320171", "320171057", "story_v_out_320171.awb")
					end

					arg_241_1:RecordHistoryTalkVoice("story_v_out_320171", "320171057", "story_v_out_320171.awb")
				end

				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_10 = math.max(var_244_3, arg_241_1.talkMaxDuration)

			if var_244_2 <= arg_241_1.time_ and arg_241_1.time_ < var_244_2 + var_244_10 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_2) / var_244_10

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_2 + var_244_10 and arg_241_1.time_ < var_244_2 + var_244_10 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {}

		arg_241_1:InitPlayNodeList()
	end,
	Play320171058 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 320171058
		arg_245_1.duration_ = 19.3

		local var_245_0 = {
			zh = 13.666,
			ja = 19.3
		}
		local var_245_1 = manager.audio:GetLocalizationFlag()

		if var_245_0[var_245_1] ~= nil then
			arg_245_1.duration_ = var_245_0[var_245_1]
		end

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play320171059(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 and not isNil(arg_245_1.actors_["10045ui_story"]) and arg_245_1.var_.characterEffect10045ui_story == nil then
				arg_245_1.var_.characterEffect10045ui_story = arg_245_1.actors_["10045ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_248_0 = 0.2

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_0 and not isNil(arg_245_1.actors_["10045ui_story"]) then
				if arg_245_1.var_.characterEffect10045ui_story and not isNil(arg_245_1.actors_["10045ui_story"]) then
					arg_245_1.var_.characterEffect10045ui_story.fillFlat = true
					arg_245_1.var_.characterEffect10045ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_245_1.time_ - 0) / var_248_0)
				end
			end

			if arg_245_1.time_ >= 0 + var_248_0 and arg_245_1.time_ < 0 + var_248_0 + arg_248_0 and not isNil(arg_245_1.actors_["10045ui_story"]) and arg_245_1.var_.characterEffect10045ui_story then
				arg_245_1.var_.characterEffect10045ui_story.fillFlat = true
				arg_245_1.var_.characterEffect10045ui_story.fillRatio = 0.5
			end

			local var_248_1 = 0
			local var_248_2 = 1.275

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= var_248_1 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, true)

				arg_245_1.leftNameTxt_.text = arg_245_1:FormatText(StoryNameCfg[600].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, true)
				arg_245_1.iconController_:SetSelectedState("hero")

				arg_245_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10062")

				arg_245_1.callingController_:SetSelectedState("normal")

				arg_245_1.keyicon_.color = Color.New(1, 1, 1)
				arg_245_1.icon_.color = Color.New(1, 1, 1)

				local var_248_3 = arg_245_1:GetWordFromCfg(320171058)
				local var_248_4 = arg_245_1:FormatText(var_248_3.content)

				arg_245_1.text_.text = var_248_4

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_6 = 51 <= 0 and var_248_2 or var_248_2 * (utf8.len(var_248_4) / 51)

				if (51 <= 0 and var_248_2 or var_248_2 * (utf8.len(var_248_4) / 51)) > 0 and var_248_2 < var_248_6 then
					arg_245_1.talkMaxDuration = var_248_6

					if var_248_6 + var_248_1 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_6 + var_248_1
					end
				end

				arg_245_1.text_.text = var_248_4
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320171", "320171058", "story_v_out_320171.awb") ~= 0 then
					local var_248_7 = manager.audio:GetVoiceLength("story_v_out_320171", "320171058", "story_v_out_320171.awb") / 1000

					if var_248_7 + var_248_1 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_7 + var_248_1
					end

					if var_248_3.prefab_name ~= "" and arg_245_1.actors_[var_248_3.prefab_name] ~= nil then
						local var_248_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_245_1.actors_[var_248_3.prefab_name].transform, "story_v_out_320171", "320171058", "story_v_out_320171.awb")

						arg_245_1:RecordAudio("320171058", var_248_8)
						arg_245_1:RecordAudio("320171058", var_248_8)
					else
						arg_245_1:AudioAction("play", "voice", "story_v_out_320171", "320171058", "story_v_out_320171.awb")
					end

					arg_245_1:RecordHistoryTalkVoice("story_v_out_320171", "320171058", "story_v_out_320171.awb")
				end

				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_9 = math.max(var_248_2, arg_245_1.talkMaxDuration)

			if var_248_1 <= arg_245_1.time_ and arg_245_1.time_ < var_248_1 + var_248_9 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_1) / var_248_9

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_1 + var_248_9 and arg_245_1.time_ < var_248_1 + var_248_9 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {}

		arg_245_1:InitPlayNodeList()
	end,
	Play320171059 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 320171059
		arg_249_1.duration_ = 10.87

		local var_249_0 = {
			zh = 5.433,
			ja = 10.866
		}
		local var_249_1 = manager.audio:GetLocalizationFlag()

		if var_249_0[var_249_1] ~= nil then
			arg_249_1.duration_ = var_249_0[var_249_1]
		end

		SetActive(arg_249_1.tipsGo_, false)

		function arg_249_1.onSingleLineFinish_()
			arg_249_1.onSingleLineUpdate_ = nil
			arg_249_1.onSingleLineFinish_ = nil
			arg_249_1.state_ = "waiting"
		end

		function arg_249_1.playNext_(arg_251_0)
			if arg_251_0 == 1 then
				arg_249_0:Play320171060(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1.var_.moveOldPos10045ui_story = arg_249_1.actors_["10045ui_story"].transform.localPosition
			end

			local var_252_0 = 0.001

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_0 then
				arg_249_1.actors_["10045ui_story"].transform.localPosition = Vector3.Lerp(arg_249_1.var_.moveOldPos10045ui_story, Vector3.New(0, 100, 0), (arg_249_1.time_ - 0) / var_252_0)
				arg_249_1.actors_["10045ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_249_1.actors_["10045ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_249_1.actors_["10045ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_249_1.actors_["10045ui_story"].transform.position).z)
				arg_249_1.actors_["10045ui_story"].transform.localEulerAngles.z = 0
				arg_249_1.actors_["10045ui_story"].transform.localEulerAngles.x = 0
				arg_249_1.actors_["10045ui_story"].transform.localEulerAngles = arg_249_1.actors_["10045ui_story"].transform.localEulerAngles
			end

			if arg_249_1.time_ >= 0 + var_252_0 and arg_249_1.time_ < 0 + var_252_0 + arg_252_0 then
				arg_249_1.actors_["10045ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_249_1.actors_["10045ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_249_1.actors_["10045ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_249_1.actors_["10045ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_249_1.actors_["10045ui_story"].transform.position).z)
				arg_249_1.actors_["10045ui_story"].transform.localEulerAngles.z = 0
				arg_249_1.actors_["10045ui_story"].transform.localEulerAngles.x = 0
				arg_249_1.actors_["10045ui_story"].transform.localEulerAngles = arg_249_1.actors_["10045ui_story"].transform.localEulerAngles
			end

			local var_252_1 = 0
			local var_252_2 = 0.4

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= var_252_1 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				arg_249_1.leftNameTxt_.text = arg_249_1:FormatText(StoryNameCfg[1049].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, true)
				arg_249_1.iconController_:SetSelectedState("hero")

				arg_249_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10130")

				arg_249_1.callingController_:SetSelectedState("normal")

				arg_249_1.keyicon_.color = Color.New(1, 1, 1)
				arg_249_1.icon_.color = Color.New(1, 1, 1)

				local var_252_3 = arg_249_1:GetWordFromCfg(320171059)
				local var_252_4 = arg_249_1:FormatText(var_252_3.content)

				arg_249_1.text_.text = var_252_4

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_6 = 16 <= 0 and var_252_2 or var_252_2 * (utf8.len(var_252_4) / 16)

				if (16 <= 0 and var_252_2 or var_252_2 * (utf8.len(var_252_4) / 16)) > 0 and var_252_2 < var_252_6 then
					arg_249_1.talkMaxDuration = var_252_6

					if var_252_6 + var_252_1 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_6 + var_252_1
					end
				end

				arg_249_1.text_.text = var_252_4
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320171", "320171059", "story_v_out_320171.awb") ~= 0 then
					local var_252_7 = manager.audio:GetVoiceLength("story_v_out_320171", "320171059", "story_v_out_320171.awb") / 1000

					if var_252_7 + var_252_1 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_7 + var_252_1
					end

					if var_252_3.prefab_name ~= "" and arg_249_1.actors_[var_252_3.prefab_name] ~= nil then
						local var_252_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_249_1.actors_[var_252_3.prefab_name].transform, "story_v_out_320171", "320171059", "story_v_out_320171.awb")

						arg_249_1:RecordAudio("320171059", var_252_8)
						arg_249_1:RecordAudio("320171059", var_252_8)
					else
						arg_249_1:AudioAction("play", "voice", "story_v_out_320171", "320171059", "story_v_out_320171.awb")
					end

					arg_249_1:RecordHistoryTalkVoice("story_v_out_320171", "320171059", "story_v_out_320171.awb")
				end

				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_9 = math.max(var_252_2, arg_249_1.talkMaxDuration)

			if var_252_1 <= arg_249_1.time_ and arg_249_1.time_ < var_252_1 + var_252_9 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_1) / var_252_9

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_1 + var_252_9 and arg_249_1.time_ < var_252_1 + var_252_9 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10045ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0333333333333333,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_249_1:InitPlayNodeList()
	end,
	Play320171060 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 320171060
		arg_253_1.duration_ = 10.1

		local var_253_0 = {
			zh = 9,
			ja = 10.1
		}
		local var_253_1 = manager.audio:GetLocalizationFlag()

		if var_253_0[var_253_1] ~= nil then
			arg_253_1.duration_ = var_253_0[var_253_1]
		end

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play320171061(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			local var_256_0 = 0.625

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				arg_253_1.leftNameTxt_.text = arg_253_1:FormatText(StoryNameCfg[600].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, true)
				arg_253_1.iconController_:SetSelectedState("hero")

				arg_253_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10062")

				arg_253_1.callingController_:SetSelectedState("normal")

				arg_253_1.keyicon_.color = Color.New(1, 1, 1)
				arg_253_1.icon_.color = Color.New(1, 1, 1)

				local var_256_1 = arg_253_1:GetWordFromCfg(320171060)
				local var_256_2 = arg_253_1:FormatText(var_256_1.content)

				arg_253_1.text_.text = var_256_2

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_4 = 25 <= 0 and var_256_0 or var_256_0 * (utf8.len(var_256_2) / 25)

				if (25 <= 0 and var_256_0 or var_256_0 * (utf8.len(var_256_2) / 25)) > 0 and var_256_0 < var_256_4 then
					arg_253_1.talkMaxDuration = var_256_4

					if var_256_4 + 0 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_4 + 0
					end
				end

				arg_253_1.text_.text = var_256_2
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320171", "320171060", "story_v_out_320171.awb") ~= 0 then
					local var_256_5 = manager.audio:GetVoiceLength("story_v_out_320171", "320171060", "story_v_out_320171.awb") / 1000

					if var_256_5 + 0 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_5 + 0
					end

					if var_256_1.prefab_name ~= "" and arg_253_1.actors_[var_256_1.prefab_name] ~= nil then
						local var_256_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_253_1.actors_[var_256_1.prefab_name].transform, "story_v_out_320171", "320171060", "story_v_out_320171.awb")

						arg_253_1:RecordAudio("320171060", var_256_6)
						arg_253_1:RecordAudio("320171060", var_256_6)
					else
						arg_253_1:AudioAction("play", "voice", "story_v_out_320171", "320171060", "story_v_out_320171.awb")
					end

					arg_253_1:RecordHistoryTalkVoice("story_v_out_320171", "320171060", "story_v_out_320171.awb")
				end

				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_7 = math.max(var_256_0, arg_253_1.talkMaxDuration)

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_7 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - 0) / var_256_7

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= 0 + var_256_7 and arg_253_1.time_ < 0 + var_256_7 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {}

		arg_253_1:InitPlayNodeList()
	end,
	Play320171061 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 320171061
		arg_257_1.duration_ = 11

		local var_257_0 = {
			zh = 8.533,
			ja = 11
		}
		local var_257_1 = manager.audio:GetLocalizationFlag()

		if var_257_0[var_257_1] ~= nil then
			arg_257_1.duration_ = var_257_0[var_257_1]
		end

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
		end

		function arg_257_1.playNext_(arg_259_0)
			if arg_259_0 == 1 then
				arg_257_0:Play320171062(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			local var_260_0 = 0.55

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				arg_257_1.leftNameTxt_.text = arg_257_1:FormatText(StoryNameCfg[1049].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, true)
				arg_257_1.iconController_:SetSelectedState("hero")

				arg_257_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10130")

				arg_257_1.callingController_:SetSelectedState("normal")

				arg_257_1.keyicon_.color = Color.New(1, 1, 1)
				arg_257_1.icon_.color = Color.New(1, 1, 1)

				local var_260_1 = arg_257_1:GetWordFromCfg(320171061)
				local var_260_2 = arg_257_1:FormatText(var_260_1.content)

				arg_257_1.text_.text = var_260_2

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_4 = 22 <= 0 and var_260_0 or var_260_0 * (utf8.len(var_260_2) / 22)

				if (22 <= 0 and var_260_0 or var_260_0 * (utf8.len(var_260_2) / 22)) > 0 and var_260_0 < var_260_4 then
					arg_257_1.talkMaxDuration = var_260_4

					if var_260_4 + 0 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_4 + 0
					end
				end

				arg_257_1.text_.text = var_260_2
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320171", "320171061", "story_v_out_320171.awb") ~= 0 then
					local var_260_5 = manager.audio:GetVoiceLength("story_v_out_320171", "320171061", "story_v_out_320171.awb") / 1000

					if var_260_5 + 0 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_5 + 0
					end

					if var_260_1.prefab_name ~= "" and arg_257_1.actors_[var_260_1.prefab_name] ~= nil then
						local var_260_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_257_1.actors_[var_260_1.prefab_name].transform, "story_v_out_320171", "320171061", "story_v_out_320171.awb")

						arg_257_1:RecordAudio("320171061", var_260_6)
						arg_257_1:RecordAudio("320171061", var_260_6)
					else
						arg_257_1:AudioAction("play", "voice", "story_v_out_320171", "320171061", "story_v_out_320171.awb")
					end

					arg_257_1:RecordHistoryTalkVoice("story_v_out_320171", "320171061", "story_v_out_320171.awb")
				end

				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_7 = math.max(var_260_0, arg_257_1.talkMaxDuration)

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_7 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - 0) / var_260_7

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= 0 + var_260_7 and arg_257_1.time_ < 0 + var_260_7 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {}

		arg_257_1:InitPlayNodeList()
	end,
	Play320171062 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 320171062
		arg_261_1.duration_ = 16.43

		local var_261_0 = {
			zh = 8.966,
			ja = 16.433
		}
		local var_261_1 = manager.audio:GetLocalizationFlag()

		if var_261_0[var_261_1] ~= nil then
			arg_261_1.duration_ = var_261_0[var_261_1]
		end

		SetActive(arg_261_1.tipsGo_, false)

		function arg_261_1.onSingleLineFinish_()
			arg_261_1.onSingleLineUpdate_ = nil
			arg_261_1.onSingleLineFinish_ = nil
			arg_261_1.state_ = "waiting"
		end

		function arg_261_1.playNext_(arg_263_0)
			if arg_263_0 == 1 then
				arg_261_0:Play320171063(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			local var_264_0 = 0.725

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				arg_261_1.leftNameTxt_.text = arg_261_1:FormatText(StoryNameCfg[600].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, true)
				arg_261_1.iconController_:SetSelectedState("hero")

				arg_261_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10062")

				arg_261_1.callingController_:SetSelectedState("normal")

				arg_261_1.keyicon_.color = Color.New(1, 1, 1)
				arg_261_1.icon_.color = Color.New(1, 1, 1)

				local var_264_1 = arg_261_1:GetWordFromCfg(320171062)
				local var_264_2 = arg_261_1:FormatText(var_264_1.content)

				arg_261_1.text_.text = var_264_2

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_4 = 29 <= 0 and var_264_0 or var_264_0 * (utf8.len(var_264_2) / 29)

				if (29 <= 0 and var_264_0 or var_264_0 * (utf8.len(var_264_2) / 29)) > 0 and var_264_0 < var_264_4 then
					arg_261_1.talkMaxDuration = var_264_4

					if var_264_4 + 0 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_4 + 0
					end
				end

				arg_261_1.text_.text = var_264_2
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320171", "320171062", "story_v_out_320171.awb") ~= 0 then
					local var_264_5 = manager.audio:GetVoiceLength("story_v_out_320171", "320171062", "story_v_out_320171.awb") / 1000

					if var_264_5 + 0 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_5 + 0
					end

					if var_264_1.prefab_name ~= "" and arg_261_1.actors_[var_264_1.prefab_name] ~= nil then
						local var_264_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_261_1.actors_[var_264_1.prefab_name].transform, "story_v_out_320171", "320171062", "story_v_out_320171.awb")

						arg_261_1:RecordAudio("320171062", var_264_6)
						arg_261_1:RecordAudio("320171062", var_264_6)
					else
						arg_261_1:AudioAction("play", "voice", "story_v_out_320171", "320171062", "story_v_out_320171.awb")
					end

					arg_261_1:RecordHistoryTalkVoice("story_v_out_320171", "320171062", "story_v_out_320171.awb")
				end

				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_7 = math.max(var_264_0, arg_261_1.talkMaxDuration)

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_7 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - 0) / var_264_7

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= 0 + var_264_7 and arg_261_1.time_ < 0 + var_264_7 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {}

		arg_261_1:InitPlayNodeList()
	end,
	Play320171063 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 320171063
		arg_265_1.duration_ = 21.73

		local var_265_0 = {
			zh = 13.3,
			ja = 21.733
		}
		local var_265_1 = manager.audio:GetLocalizationFlag()

		if var_265_0[var_265_1] ~= nil then
			arg_265_1.duration_ = var_265_0[var_265_1]
		end

		SetActive(arg_265_1.tipsGo_, false)

		function arg_265_1.onSingleLineFinish_()
			arg_265_1.onSingleLineUpdate_ = nil
			arg_265_1.onSingleLineFinish_ = nil
			arg_265_1.state_ = "waiting"
		end

		function arg_265_1.playNext_(arg_267_0)
			if arg_267_0 == 1 then
				arg_265_0:Play320171064(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			local var_268_0 = 1.25

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				arg_265_1.leftNameTxt_.text = arg_265_1:FormatText(StoryNameCfg[600].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, true)
				arg_265_1.iconController_:SetSelectedState("hero")

				arg_265_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10062")

				arg_265_1.callingController_:SetSelectedState("normal")

				arg_265_1.keyicon_.color = Color.New(1, 1, 1)
				arg_265_1.icon_.color = Color.New(1, 1, 1)

				local var_268_1 = arg_265_1:GetWordFromCfg(320171063)
				local var_268_2 = arg_265_1:FormatText(var_268_1.content)

				arg_265_1.text_.text = var_268_2

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_4 = 50 <= 0 and var_268_0 or var_268_0 * (utf8.len(var_268_2) / 50)

				if (50 <= 0 and var_268_0 or var_268_0 * (utf8.len(var_268_2) / 50)) > 0 and var_268_0 < var_268_4 then
					arg_265_1.talkMaxDuration = var_268_4

					if var_268_4 + 0 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_4 + 0
					end
				end

				arg_265_1.text_.text = var_268_2
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320171", "320171063", "story_v_out_320171.awb") ~= 0 then
					local var_268_5 = manager.audio:GetVoiceLength("story_v_out_320171", "320171063", "story_v_out_320171.awb") / 1000

					if var_268_5 + 0 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_5 + 0
					end

					if var_268_1.prefab_name ~= "" and arg_265_1.actors_[var_268_1.prefab_name] ~= nil then
						local var_268_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_265_1.actors_[var_268_1.prefab_name].transform, "story_v_out_320171", "320171063", "story_v_out_320171.awb")

						arg_265_1:RecordAudio("320171063", var_268_6)
						arg_265_1:RecordAudio("320171063", var_268_6)
					else
						arg_265_1:AudioAction("play", "voice", "story_v_out_320171", "320171063", "story_v_out_320171.awb")
					end

					arg_265_1:RecordHistoryTalkVoice("story_v_out_320171", "320171063", "story_v_out_320171.awb")
				end

				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_7 = math.max(var_268_0, arg_265_1.talkMaxDuration)

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_7 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - 0) / var_268_7

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= 0 + var_268_7 and arg_265_1.time_ < 0 + var_268_7 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {}

		arg_265_1:InitPlayNodeList()
	end,
	Play320171064 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 320171064
		arg_269_1.duration_ = 8.57

		local var_269_0 = {
			zh = 3.966,
			ja = 8.566
		}
		local var_269_1 = manager.audio:GetLocalizationFlag()

		if var_269_0[var_269_1] ~= nil then
			arg_269_1.duration_ = var_269_0[var_269_1]
		end

		SetActive(arg_269_1.tipsGo_, false)

		function arg_269_1.onSingleLineFinish_()
			arg_269_1.onSingleLineUpdate_ = nil
			arg_269_1.onSingleLineFinish_ = nil
			arg_269_1.state_ = "waiting"
		end

		function arg_269_1.playNext_(arg_271_0)
			if arg_271_0 == 1 then
				arg_269_0:Play320171065(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1.var_.moveOldPos10037ui_story = arg_269_1.actors_["10037ui_story"].transform.localPosition
			end

			local var_272_0 = 0.001

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_0 then
				arg_269_1.actors_["10037ui_story"].transform.localPosition = Vector3.Lerp(arg_269_1.var_.moveOldPos10037ui_story, Vector3.New(0, -1.13, -6.2), (arg_269_1.time_ - 0) / var_272_0)
				arg_269_1.actors_["10037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_269_1.actors_["10037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_269_1.actors_["10037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_269_1.actors_["10037ui_story"].transform.position).z)
				arg_269_1.actors_["10037ui_story"].transform.localEulerAngles.z = 0
				arg_269_1.actors_["10037ui_story"].transform.localEulerAngles.x = 0
				arg_269_1.actors_["10037ui_story"].transform.localEulerAngles = arg_269_1.actors_["10037ui_story"].transform.localEulerAngles
			end

			if arg_269_1.time_ >= 0 + var_272_0 and arg_269_1.time_ < 0 + var_272_0 + arg_272_0 then
				arg_269_1.actors_["10037ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_269_1.actors_["10037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_269_1.actors_["10037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_269_1.actors_["10037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_269_1.actors_["10037ui_story"].transform.position).z)
				arg_269_1.actors_["10037ui_story"].transform.localEulerAngles.z = 0
				arg_269_1.actors_["10037ui_story"].transform.localEulerAngles.x = 0
				arg_269_1.actors_["10037ui_story"].transform.localEulerAngles = arg_269_1.actors_["10037ui_story"].transform.localEulerAngles
			end

			local var_272_1 = arg_269_1.actors_["10037ui_story"]

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 and not isNil(var_272_1) and arg_269_1.var_.characterEffect10037ui_story == nil then
				arg_269_1.var_.characterEffect10037ui_story = var_272_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_272_2 = 0.200000002980232

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_2 and not isNil(var_272_1) then
				if arg_269_1.var_.characterEffect10037ui_story and not isNil(var_272_1) then
					arg_269_1.var_.characterEffect10037ui_story.fillFlat = false
				end
			end

			if arg_269_1.time_ >= 0 + var_272_2 and arg_269_1.time_ < 0 + var_272_2 + arg_272_0 and not isNil(var_272_1) and arg_269_1.var_.characterEffect10037ui_story then
				arg_269_1.var_.characterEffect10037ui_story.fillFlat = false
			end

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1:PlayTimeline("10037ui_story", "StoryTimeline/CharAction/story10037/story10037actionlink/10037action423")
			end

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1:PlayTimeline("10037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_272_4 = 0
			local var_272_5 = 0.25

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= var_272_4 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				arg_269_1.leftNameTxt_.text = arg_269_1:FormatText(StoryNameCfg[383].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_6 = arg_269_1:GetWordFromCfg(320171064)
				local var_272_7 = arg_269_1:FormatText(var_272_6.content)

				arg_269_1.text_.text = var_272_7

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_9 = 10 <= 0 and var_272_5 or var_272_5 * (utf8.len(var_272_7) / 10)

				if (10 <= 0 and var_272_5 or var_272_5 * (utf8.len(var_272_7) / 10)) > 0 and var_272_5 < var_272_9 then
					arg_269_1.talkMaxDuration = var_272_9

					if var_272_9 + var_272_4 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_9 + var_272_4
					end
				end

				arg_269_1.text_.text = var_272_7
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320171", "320171064", "story_v_out_320171.awb") ~= 0 then
					local var_272_10 = manager.audio:GetVoiceLength("story_v_out_320171", "320171064", "story_v_out_320171.awb") / 1000

					if var_272_10 + var_272_4 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_10 + var_272_4
					end

					if var_272_6.prefab_name ~= "" and arg_269_1.actors_[var_272_6.prefab_name] ~= nil then
						local var_272_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_269_1.actors_[var_272_6.prefab_name].transform, "story_v_out_320171", "320171064", "story_v_out_320171.awb")

						arg_269_1:RecordAudio("320171064", var_272_11)
						arg_269_1:RecordAudio("320171064", var_272_11)
					else
						arg_269_1:AudioAction("play", "voice", "story_v_out_320171", "320171064", "story_v_out_320171.awb")
					end

					arg_269_1:RecordHistoryTalkVoice("story_v_out_320171", "320171064", "story_v_out_320171.awb")
				end

				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_12 = math.max(var_272_5, arg_269_1.talkMaxDuration)

			if var_272_4 <= arg_269_1.time_ and arg_269_1.time_ < var_272_4 + var_272_12 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_4) / var_272_12

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_4 + var_272_12 and arg_269_1.time_ < var_272_4 + var_272_12 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_269_1:InitPlayNodeList()
	end,
	Play320171065 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 320171065
		arg_273_1.duration_ = 18.27

		local var_273_0 = {
			zh = 11.633,
			ja = 18.266
		}
		local var_273_1 = manager.audio:GetLocalizationFlag()

		if var_273_0[var_273_1] ~= nil then
			arg_273_1.duration_ = var_273_0[var_273_1]
		end

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play320171066(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 and not isNil(arg_273_1.actors_["10037ui_story"]) and arg_273_1.var_.characterEffect10037ui_story == nil then
				arg_273_1.var_.characterEffect10037ui_story = arg_273_1.actors_["10037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_276_0 = 0.200000002980232

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_0 and not isNil(arg_273_1.actors_["10037ui_story"]) then
				if arg_273_1.var_.characterEffect10037ui_story and not isNil(arg_273_1.actors_["10037ui_story"]) then
					arg_273_1.var_.characterEffect10037ui_story.fillFlat = true
					arg_273_1.var_.characterEffect10037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_273_1.time_ - 0) / var_276_0)
				end
			end

			if arg_273_1.time_ >= 0 + var_276_0 and arg_273_1.time_ < 0 + var_276_0 + arg_276_0 and not isNil(arg_273_1.actors_["10037ui_story"]) and arg_273_1.var_.characterEffect10037ui_story then
				arg_273_1.var_.characterEffect10037ui_story.fillFlat = true
				arg_273_1.var_.characterEffect10037ui_story.fillRatio = 0.5
			end

			local var_276_1 = 0
			local var_276_2 = 1.025

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= var_276_1 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, true)

				arg_273_1.leftNameTxt_.text = arg_273_1:FormatText(StoryNameCfg[600].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, true)
				arg_273_1.iconController_:SetSelectedState("hero")

				arg_273_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10062")

				arg_273_1.callingController_:SetSelectedState("normal")

				arg_273_1.keyicon_.color = Color.New(1, 1, 1)
				arg_273_1.icon_.color = Color.New(1, 1, 1)

				local var_276_3 = arg_273_1:GetWordFromCfg(320171065)
				local var_276_4 = arg_273_1:FormatText(var_276_3.content)

				arg_273_1.text_.text = var_276_4

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_6 = 41 <= 0 and var_276_2 or var_276_2 * (utf8.len(var_276_4) / 41)

				if (41 <= 0 and var_276_2 or var_276_2 * (utf8.len(var_276_4) / 41)) > 0 and var_276_2 < var_276_6 then
					arg_273_1.talkMaxDuration = var_276_6

					if var_276_6 + var_276_1 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_6 + var_276_1
					end
				end

				arg_273_1.text_.text = var_276_4
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320171", "320171065", "story_v_out_320171.awb") ~= 0 then
					local var_276_7 = manager.audio:GetVoiceLength("story_v_out_320171", "320171065", "story_v_out_320171.awb") / 1000

					if var_276_7 + var_276_1 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_7 + var_276_1
					end

					if var_276_3.prefab_name ~= "" and arg_273_1.actors_[var_276_3.prefab_name] ~= nil then
						local var_276_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_273_1.actors_[var_276_3.prefab_name].transform, "story_v_out_320171", "320171065", "story_v_out_320171.awb")

						arg_273_1:RecordAudio("320171065", var_276_8)
						arg_273_1:RecordAudio("320171065", var_276_8)
					else
						arg_273_1:AudioAction("play", "voice", "story_v_out_320171", "320171065", "story_v_out_320171.awb")
					end

					arg_273_1:RecordHistoryTalkVoice("story_v_out_320171", "320171065", "story_v_out_320171.awb")
				end

				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_9 = math.max(var_276_2, arg_273_1.talkMaxDuration)

			if var_276_1 <= arg_273_1.time_ and arg_273_1.time_ < var_276_1 + var_276_9 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_1) / var_276_9

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_1 + var_276_9 and arg_273_1.time_ < var_276_1 + var_276_9 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {}

		arg_273_1:InitPlayNodeList()
	end,
	Play320171066 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 320171066
		arg_277_1.duration_ = 7.1

		local var_277_0 = {
			zh = 5.3,
			ja = 7.1
		}
		local var_277_1 = manager.audio:GetLocalizationFlag()

		if var_277_0[var_277_1] ~= nil then
			arg_277_1.duration_ = var_277_0[var_277_1]
		end

		SetActive(arg_277_1.tipsGo_, false)

		function arg_277_1.onSingleLineFinish_()
			arg_277_1.onSingleLineUpdate_ = nil
			arg_277_1.onSingleLineFinish_ = nil
			arg_277_1.state_ = "waiting"
		end

		function arg_277_1.playNext_(arg_279_0)
			if arg_279_0 == 1 then
				arg_277_0:Play320171067(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			local var_280_0 = 0.25

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				arg_277_1.leftNameTxt_.text = arg_277_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, true)
				arg_277_1.iconController_:SetSelectedState("hero")

				arg_277_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_277_1.callingController_:SetSelectedState("normal")

				arg_277_1.keyicon_.color = Color.New(1, 1, 1)
				arg_277_1.icon_.color = Color.New(1, 1, 1)

				local var_280_1 = arg_277_1:GetWordFromCfg(320171066)
				local var_280_2 = arg_277_1:FormatText(var_280_1.content)

				arg_277_1.text_.text = var_280_2

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_4 = 10 <= 0 and var_280_0 or var_280_0 * (utf8.len(var_280_2) / 10)

				if (10 <= 0 and var_280_0 or var_280_0 * (utf8.len(var_280_2) / 10)) > 0 and var_280_0 < var_280_4 then
					arg_277_1.talkMaxDuration = var_280_4

					if var_280_4 + 0 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_4 + 0
					end
				end

				arg_277_1.text_.text = var_280_2
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320171", "320171066", "story_v_out_320171.awb") ~= 0 then
					local var_280_5 = manager.audio:GetVoiceLength("story_v_out_320171", "320171066", "story_v_out_320171.awb") / 1000

					if var_280_5 + 0 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_5 + 0
					end

					if var_280_1.prefab_name ~= "" and arg_277_1.actors_[var_280_1.prefab_name] ~= nil then
						local var_280_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_277_1.actors_[var_280_1.prefab_name].transform, "story_v_out_320171", "320171066", "story_v_out_320171.awb")

						arg_277_1:RecordAudio("320171066", var_280_6)
						arg_277_1:RecordAudio("320171066", var_280_6)
					else
						arg_277_1:AudioAction("play", "voice", "story_v_out_320171", "320171066", "story_v_out_320171.awb")
					end

					arg_277_1:RecordHistoryTalkVoice("story_v_out_320171", "320171066", "story_v_out_320171.awb")
				end

				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_7 = math.max(var_280_0, arg_277_1.talkMaxDuration)

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_7 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - 0) / var_280_7

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= 0 + var_280_7 and arg_277_1.time_ < 0 + var_280_7 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {}

		arg_277_1:InitPlayNodeList()
	end,
	Play320171067 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 320171067
		arg_281_1.duration_ = 8.63

		local var_281_0 = {
			zh = 8.633,
			ja = 8.4
		}
		local var_281_1 = manager.audio:GetLocalizationFlag()

		if var_281_0[var_281_1] ~= nil then
			arg_281_1.duration_ = var_281_0[var_281_1]
		end

		SetActive(arg_281_1.tipsGo_, false)

		function arg_281_1.onSingleLineFinish_()
			arg_281_1.onSingleLineUpdate_ = nil
			arg_281_1.onSingleLineFinish_ = nil
			arg_281_1.state_ = "waiting"
		end

		function arg_281_1.playNext_(arg_283_0)
			if arg_283_0 == 1 then
				arg_281_0:Play320171068(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			local var_284_0 = 0.475

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				arg_281_1.leftNameTxt_.text = arg_281_1:FormatText(StoryNameCfg[1049].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, true)
				arg_281_1.iconController_:SetSelectedState("hero")

				arg_281_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10130")

				arg_281_1.callingController_:SetSelectedState("normal")

				arg_281_1.keyicon_.color = Color.New(1, 1, 1)
				arg_281_1.icon_.color = Color.New(1, 1, 1)

				local var_284_1 = arg_281_1:GetWordFromCfg(320171067)
				local var_284_2 = arg_281_1:FormatText(var_284_1.content)

				arg_281_1.text_.text = var_284_2

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_4 = 19 <= 0 and var_284_0 or var_284_0 * (utf8.len(var_284_2) / 19)

				if (19 <= 0 and var_284_0 or var_284_0 * (utf8.len(var_284_2) / 19)) > 0 and var_284_0 < var_284_4 then
					arg_281_1.talkMaxDuration = var_284_4

					if var_284_4 + 0 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_4 + 0
					end
				end

				arg_281_1.text_.text = var_284_2
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320171", "320171067", "story_v_out_320171.awb") ~= 0 then
					local var_284_5 = manager.audio:GetVoiceLength("story_v_out_320171", "320171067", "story_v_out_320171.awb") / 1000

					if var_284_5 + 0 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_5 + 0
					end

					if var_284_1.prefab_name ~= "" and arg_281_1.actors_[var_284_1.prefab_name] ~= nil then
						local var_284_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_281_1.actors_[var_284_1.prefab_name].transform, "story_v_out_320171", "320171067", "story_v_out_320171.awb")

						arg_281_1:RecordAudio("320171067", var_284_6)
						arg_281_1:RecordAudio("320171067", var_284_6)
					else
						arg_281_1:AudioAction("play", "voice", "story_v_out_320171", "320171067", "story_v_out_320171.awb")
					end

					arg_281_1:RecordHistoryTalkVoice("story_v_out_320171", "320171067", "story_v_out_320171.awb")
				end

				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_7 = math.max(var_284_0, arg_281_1.talkMaxDuration)

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_7 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - 0) / var_284_7

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= 0 + var_284_7 and arg_281_1.time_ < 0 + var_284_7 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {}

		arg_281_1:InitPlayNodeList()
	end,
	Play320171068 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 320171068
		arg_285_1.duration_ = 5

		SetActive(arg_285_1.tipsGo_, false)

		function arg_285_1.onSingleLineFinish_()
			arg_285_1.onSingleLineUpdate_ = nil
			arg_285_1.onSingleLineFinish_ = nil
			arg_285_1.state_ = "waiting"
		end

		function arg_285_1.playNext_(arg_287_0)
			if arg_287_0 == 1 then
				arg_285_0:Play320171069(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 then
				arg_285_1.var_.moveOldPos10037ui_story = arg_285_1.actors_["10037ui_story"].transform.localPosition
			end

			local var_288_0 = 0.001

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_0 then
				arg_285_1.actors_["10037ui_story"].transform.localPosition = Vector3.Lerp(arg_285_1.var_.moveOldPos10037ui_story, Vector3.New(0, 100, 0), (arg_285_1.time_ - 0) / var_288_0)
				arg_285_1.actors_["10037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_285_1.actors_["10037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_285_1.actors_["10037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_285_1.actors_["10037ui_story"].transform.position).z)
				arg_285_1.actors_["10037ui_story"].transform.localEulerAngles.z = 0
				arg_285_1.actors_["10037ui_story"].transform.localEulerAngles.x = 0
				arg_285_1.actors_["10037ui_story"].transform.localEulerAngles = arg_285_1.actors_["10037ui_story"].transform.localEulerAngles
			end

			if arg_285_1.time_ >= 0 + var_288_0 and arg_285_1.time_ < 0 + var_288_0 + arg_288_0 then
				arg_285_1.actors_["10037ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_285_1.actors_["10037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_285_1.actors_["10037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_285_1.actors_["10037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_285_1.actors_["10037ui_story"].transform.position).z)
				arg_285_1.actors_["10037ui_story"].transform.localEulerAngles.z = 0
				arg_285_1.actors_["10037ui_story"].transform.localEulerAngles.x = 0
				arg_285_1.actors_["10037ui_story"].transform.localEulerAngles = arg_285_1.actors_["10037ui_story"].transform.localEulerAngles
			end

			local var_288_1 = 0
			local var_288_2 = 1.225

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= var_288_1 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, false)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_3 = arg_285_1:FormatText(arg_285_1:GetWordFromCfg(320171068).content)

				arg_285_1.text_.text = var_288_3

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_5 = 49 <= 0 and var_288_2 or var_288_2 * (utf8.len(var_288_3) / 49)

				if (49 <= 0 and var_288_2 or var_288_2 * (utf8.len(var_288_3) / 49)) > 0 and var_288_2 < var_288_5 then
					arg_285_1.talkMaxDuration = var_288_5

					if var_288_5 + var_288_1 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_5 + var_288_1
					end
				end

				arg_285_1.text_.text = var_288_3
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)
				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_6 = math.max(var_288_2, arg_285_1.talkMaxDuration)

			if var_288_1 <= arg_285_1.time_ and arg_285_1.time_ < var_288_1 + var_288_6 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_1) / var_288_6

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_1 + var_288_6 and arg_285_1.time_ < var_288_1 + var_288_6 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_285_1:InitPlayNodeList()
	end,
	Play320171069 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 320171069
		arg_289_1.duration_ = 5

		local var_289_0 = {
			zh = 3.3,
			ja = 5
		}
		local var_289_1 = manager.audio:GetLocalizationFlag()

		if var_289_0[var_289_1] ~= nil then
			arg_289_1.duration_ = var_289_0[var_289_1]
		end

		SetActive(arg_289_1.tipsGo_, false)

		function arg_289_1.onSingleLineFinish_()
			arg_289_1.onSingleLineUpdate_ = nil
			arg_289_1.onSingleLineFinish_ = nil
			arg_289_1.state_ = "waiting"
		end

		function arg_289_1.playNext_(arg_291_0)
			if arg_291_0 == 1 then
				arg_289_0:Play320171070(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 then
				arg_289_1.var_.moveOldPos10037ui_story = arg_289_1.actors_["10037ui_story"].transform.localPosition
			end

			local var_292_0 = 0.001

			if 0 <= arg_289_1.time_ and arg_289_1.time_ < 0 + var_292_0 then
				arg_289_1.actors_["10037ui_story"].transform.localPosition = Vector3.Lerp(arg_289_1.var_.moveOldPos10037ui_story, Vector3.New(0, -1.13, -6.2), (arg_289_1.time_ - 0) / var_292_0)
				arg_289_1.actors_["10037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_289_1.actors_["10037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_289_1.actors_["10037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_289_1.actors_["10037ui_story"].transform.position).z)
				arg_289_1.actors_["10037ui_story"].transform.localEulerAngles.z = 0
				arg_289_1.actors_["10037ui_story"].transform.localEulerAngles.x = 0
				arg_289_1.actors_["10037ui_story"].transform.localEulerAngles = arg_289_1.actors_["10037ui_story"].transform.localEulerAngles
			end

			if arg_289_1.time_ >= 0 + var_292_0 and arg_289_1.time_ < 0 + var_292_0 + arg_292_0 then
				arg_289_1.actors_["10037ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_289_1.actors_["10037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_289_1.actors_["10037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_289_1.actors_["10037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_289_1.actors_["10037ui_story"].transform.position).z)
				arg_289_1.actors_["10037ui_story"].transform.localEulerAngles.z = 0
				arg_289_1.actors_["10037ui_story"].transform.localEulerAngles.x = 0
				arg_289_1.actors_["10037ui_story"].transform.localEulerAngles = arg_289_1.actors_["10037ui_story"].transform.localEulerAngles
			end

			local var_292_1 = arg_289_1.actors_["10037ui_story"]

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 and not isNil(var_292_1) and arg_289_1.var_.characterEffect10037ui_story == nil then
				arg_289_1.var_.characterEffect10037ui_story = var_292_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_292_2 = 0.200000002980232

			if 0 <= arg_289_1.time_ and arg_289_1.time_ < 0 + var_292_2 and not isNil(var_292_1) then
				if arg_289_1.var_.characterEffect10037ui_story and not isNil(var_292_1) then
					arg_289_1.var_.characterEffect10037ui_story.fillFlat = false
				end
			end

			if arg_289_1.time_ >= 0 + var_292_2 and arg_289_1.time_ < 0 + var_292_2 + arg_292_0 and not isNil(var_292_1) and arg_289_1.var_.characterEffect10037ui_story then
				arg_289_1.var_.characterEffect10037ui_story.fillFlat = false
			end

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 then
				arg_289_1:PlayTimeline("10037ui_story", "StoryTimeline/CharAction/story10037/story10037action/10037action3_2")
			end

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 then
				arg_289_1:PlayTimeline("10037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_292_4 = 0
			local var_292_5 = 0.05

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= var_292_4 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, true)

				arg_289_1.leftNameTxt_.text = arg_289_1:FormatText(StoryNameCfg[383].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, false)
				arg_289_1.callingController_:SetSelectedState("normal")

				local var_292_6 = arg_289_1:GetWordFromCfg(320171069)
				local var_292_7 = arg_289_1:FormatText(var_292_6.content)

				arg_289_1.text_.text = var_292_7

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_9 = 2 <= 0 and var_292_5 or var_292_5 * (utf8.len(var_292_7) / 2)

				if (2 <= 0 and var_292_5 or var_292_5 * (utf8.len(var_292_7) / 2)) > 0 and var_292_5 < var_292_9 then
					arg_289_1.talkMaxDuration = var_292_9

					if var_292_9 + var_292_4 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_9 + var_292_4
					end
				end

				arg_289_1.text_.text = var_292_7
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320171", "320171069", "story_v_out_320171.awb") ~= 0 then
					local var_292_10 = manager.audio:GetVoiceLength("story_v_out_320171", "320171069", "story_v_out_320171.awb") / 1000

					if var_292_10 + var_292_4 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_10 + var_292_4
					end

					if var_292_6.prefab_name ~= "" and arg_289_1.actors_[var_292_6.prefab_name] ~= nil then
						local var_292_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_289_1.actors_[var_292_6.prefab_name].transform, "story_v_out_320171", "320171069", "story_v_out_320171.awb")

						arg_289_1:RecordAudio("320171069", var_292_11)
						arg_289_1:RecordAudio("320171069", var_292_11)
					else
						arg_289_1:AudioAction("play", "voice", "story_v_out_320171", "320171069", "story_v_out_320171.awb")
					end

					arg_289_1:RecordHistoryTalkVoice("story_v_out_320171", "320171069", "story_v_out_320171.awb")
				end

				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_12 = math.max(var_292_5, arg_289_1.talkMaxDuration)

			if var_292_4 <= arg_289_1.time_ and arg_289_1.time_ < var_292_4 + var_292_12 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - var_292_4) / var_292_12

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= var_292_4 + var_292_12 and arg_289_1.time_ < var_292_4 + var_292_12 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_289_1:InitPlayNodeList()
	end,
	Play320171070 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 320171070
		arg_293_1.duration_ = 13.2

		local var_293_0 = {
			zh = 10.633,
			ja = 13.2
		}
		local var_293_1 = manager.audio:GetLocalizationFlag()

		if var_293_0[var_293_1] ~= nil then
			arg_293_1.duration_ = var_293_0[var_293_1]
		end

		SetActive(arg_293_1.tipsGo_, false)

		function arg_293_1.onSingleLineFinish_()
			arg_293_1.onSingleLineUpdate_ = nil
			arg_293_1.onSingleLineFinish_ = nil
			arg_293_1.state_ = "waiting"
		end

		function arg_293_1.playNext_(arg_295_0)
			if arg_295_0 == 1 then
				arg_293_0:Play320171071(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 and not isNil(arg_293_1.actors_["10037ui_story"]) and arg_293_1.var_.characterEffect10037ui_story == nil then
				arg_293_1.var_.characterEffect10037ui_story = arg_293_1.actors_["10037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_296_0 = 0.200000002980232

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_0 and not isNil(arg_293_1.actors_["10037ui_story"]) then
				if arg_293_1.var_.characterEffect10037ui_story and not isNil(arg_293_1.actors_["10037ui_story"]) then
					arg_293_1.var_.characterEffect10037ui_story.fillFlat = true
					arg_293_1.var_.characterEffect10037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_293_1.time_ - 0) / var_296_0)
				end
			end

			if arg_293_1.time_ >= 0 + var_296_0 and arg_293_1.time_ < 0 + var_296_0 + arg_296_0 and not isNil(arg_293_1.actors_["10037ui_story"]) and arg_293_1.var_.characterEffect10037ui_story then
				arg_293_1.var_.characterEffect10037ui_story.fillFlat = true
				arg_293_1.var_.characterEffect10037ui_story.fillRatio = 0.5
			end

			local var_296_1 = arg_293_1.actors_["10037ui_story"].transform

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1.var_.moveOldPos10037ui_story = var_296_1.localPosition
			end

			local var_296_2 = 0.001

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_2 then
				var_296_1.localPosition = Vector3.Lerp(arg_293_1.var_.moveOldPos10037ui_story, Vector3.New(0, 100, 0), (arg_293_1.time_ - 0) / var_296_2)
				var_296_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_296_1.position).x, (manager.ui.mainCamera.transform.position - var_296_1.position).y, (manager.ui.mainCamera.transform.position - var_296_1.position).z)
				var_296_1.localEulerAngles.z = 0
				var_296_1.localEulerAngles.x = 0
				var_296_1.localEulerAngles = var_296_1.localEulerAngles
			end

			if arg_293_1.time_ >= 0 + var_296_2 and arg_293_1.time_ < 0 + var_296_2 + arg_296_0 then
				var_296_1.localPosition = Vector3.New(0, 100, 0)
				var_296_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_296_1.position).x, (manager.ui.mainCamera.transform.position - var_296_1.position).y, (manager.ui.mainCamera.transform.position - var_296_1.position).z)
				var_296_1.localEulerAngles.z = 0
				var_296_1.localEulerAngles.x = 0
				var_296_1.localEulerAngles = var_296_1.localEulerAngles
			end

			local var_296_3 = 0
			local var_296_4 = 0.8

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= var_296_3 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, true)

				arg_293_1.leftNameTxt_.text = arg_293_1:FormatText(StoryNameCfg[600].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_293_1.leftNameTxt_.transform)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1.leftNameTxt_.text)
				SetActive(arg_293_1.iconTrs_.gameObject, true)
				arg_293_1.iconController_:SetSelectedState("hero")

				arg_293_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10062")

				arg_293_1.callingController_:SetSelectedState("normal")

				arg_293_1.keyicon_.color = Color.New(1, 1, 1)
				arg_293_1.icon_.color = Color.New(1, 1, 1)

				local var_296_5 = arg_293_1:GetWordFromCfg(320171070)
				local var_296_6 = arg_293_1:FormatText(var_296_5.content)

				arg_293_1.text_.text = var_296_6

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_8 = 32 <= 0 and var_296_4 or var_296_4 * (utf8.len(var_296_6) / 32)

				if (32 <= 0 and var_296_4 or var_296_4 * (utf8.len(var_296_6) / 32)) > 0 and var_296_4 < var_296_8 then
					arg_293_1.talkMaxDuration = var_296_8

					if var_296_8 + var_296_3 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_8 + var_296_3
					end
				end

				arg_293_1.text_.text = var_296_6
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320171", "320171070", "story_v_out_320171.awb") ~= 0 then
					local var_296_9 = manager.audio:GetVoiceLength("story_v_out_320171", "320171070", "story_v_out_320171.awb") / 1000

					if var_296_9 + var_296_3 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_9 + var_296_3
					end

					if var_296_5.prefab_name ~= "" and arg_293_1.actors_[var_296_5.prefab_name] ~= nil then
						local var_296_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_293_1.actors_[var_296_5.prefab_name].transform, "story_v_out_320171", "320171070", "story_v_out_320171.awb")

						arg_293_1:RecordAudio("320171070", var_296_10)
						arg_293_1:RecordAudio("320171070", var_296_10)
					else
						arg_293_1:AudioAction("play", "voice", "story_v_out_320171", "320171070", "story_v_out_320171.awb")
					end

					arg_293_1:RecordHistoryTalkVoice("story_v_out_320171", "320171070", "story_v_out_320171.awb")
				end

				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_11 = math.max(var_296_4, arg_293_1.talkMaxDuration)

			if var_296_3 <= arg_293_1.time_ and arg_293_1.time_ < var_296_3 + var_296_11 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_3) / var_296_11

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_3 + var_296_11 and arg_293_1.time_ < var_296_3 + var_296_11 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_293_1:InitPlayNodeList()
	end,
	Play320171071 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 320171071
		arg_297_1.duration_ = 5

		SetActive(arg_297_1.tipsGo_, false)

		function arg_297_1.onSingleLineFinish_()
			arg_297_1.onSingleLineUpdate_ = nil
			arg_297_1.onSingleLineFinish_ = nil
			arg_297_1.state_ = "waiting"
		end

		function arg_297_1.playNext_(arg_299_0)
			if arg_299_0 == 1 then
				arg_297_0:Play320171072(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			local var_300_0 = 0.525

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, false)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_297_1.iconTrs_.gameObject, false)
				arg_297_1.callingController_:SetSelectedState("normal")

				local var_300_1 = arg_297_1:FormatText(arg_297_1:GetWordFromCfg(320171071).content)

				arg_297_1.text_.text = var_300_1

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_3 = 21 <= 0 and var_300_0 or var_300_0 * (utf8.len(var_300_1) / 21)

				if (21 <= 0 and var_300_0 or var_300_0 * (utf8.len(var_300_1) / 21)) > 0 and var_300_0 < var_300_3 then
					arg_297_1.talkMaxDuration = var_300_3

					if var_300_3 + 0 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_3 + 0
					end
				end

				arg_297_1.text_.text = var_300_1
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)
				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_4 = math.max(var_300_0, arg_297_1.talkMaxDuration)

			if 0 <= arg_297_1.time_ and arg_297_1.time_ < 0 + var_300_4 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - 0) / var_300_4

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= 0 + var_300_4 and arg_297_1.time_ < 0 + var_300_4 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {}

		arg_297_1:InitPlayNodeList()
	end,
	Play320171072 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 320171072
		arg_301_1.duration_ = 7.6

		local var_301_0 = {
			zh = 5.1,
			ja = 7.6
		}
		local var_301_1 = manager.audio:GetLocalizationFlag()

		if var_301_0[var_301_1] ~= nil then
			arg_301_1.duration_ = var_301_0[var_301_1]
		end

		SetActive(arg_301_1.tipsGo_, false)

		function arg_301_1.onSingleLineFinish_()
			arg_301_1.onSingleLineUpdate_ = nil
			arg_301_1.onSingleLineFinish_ = nil
			arg_301_1.state_ = "waiting"
		end

		function arg_301_1.playNext_(arg_303_0)
			if arg_303_0 == 1 then
				arg_301_0:Play320171073(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			local var_304_0 = 0.25

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, true)

				arg_301_1.leftNameTxt_.text = arg_301_1:FormatText(StoryNameCfg[1049].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_301_1.leftNameTxt_.transform)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1.leftNameTxt_.text)
				SetActive(arg_301_1.iconTrs_.gameObject, true)
				arg_301_1.iconController_:SetSelectedState("hero")

				arg_301_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10130")

				arg_301_1.callingController_:SetSelectedState("normal")

				arg_301_1.keyicon_.color = Color.New(1, 1, 1)
				arg_301_1.icon_.color = Color.New(1, 1, 1)

				local var_304_1 = arg_301_1:GetWordFromCfg(320171072)
				local var_304_2 = arg_301_1:FormatText(var_304_1.content)

				arg_301_1.text_.text = var_304_2

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_4 = 10 <= 0 and var_304_0 or var_304_0 * (utf8.len(var_304_2) / 10)

				if (10 <= 0 and var_304_0 or var_304_0 * (utf8.len(var_304_2) / 10)) > 0 and var_304_0 < var_304_4 then
					arg_301_1.talkMaxDuration = var_304_4

					if var_304_4 + 0 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_4 + 0
					end
				end

				arg_301_1.text_.text = var_304_2
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320171", "320171072", "story_v_out_320171.awb") ~= 0 then
					local var_304_5 = manager.audio:GetVoiceLength("story_v_out_320171", "320171072", "story_v_out_320171.awb") / 1000

					if var_304_5 + 0 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_5 + 0
					end

					if var_304_1.prefab_name ~= "" and arg_301_1.actors_[var_304_1.prefab_name] ~= nil then
						local var_304_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_301_1.actors_[var_304_1.prefab_name].transform, "story_v_out_320171", "320171072", "story_v_out_320171.awb")

						arg_301_1:RecordAudio("320171072", var_304_6)
						arg_301_1:RecordAudio("320171072", var_304_6)
					else
						arg_301_1:AudioAction("play", "voice", "story_v_out_320171", "320171072", "story_v_out_320171.awb")
					end

					arg_301_1:RecordHistoryTalkVoice("story_v_out_320171", "320171072", "story_v_out_320171.awb")
				end

				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_7 = math.max(var_304_0, arg_301_1.talkMaxDuration)

			if 0 <= arg_301_1.time_ and arg_301_1.time_ < 0 + var_304_7 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - 0) / var_304_7

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= 0 + var_304_7 and arg_301_1.time_ < 0 + var_304_7 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {}

		arg_301_1:InitPlayNodeList()
	end,
	Play320171073 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 320171073
		arg_305_1.duration_ = 9.27

		local var_305_0 = {
			zh = 6.133,
			ja = 9.266
		}
		local var_305_1 = manager.audio:GetLocalizationFlag()

		if var_305_0[var_305_1] ~= nil then
			arg_305_1.duration_ = var_305_0[var_305_1]
		end

		SetActive(arg_305_1.tipsGo_, false)

		function arg_305_1.onSingleLineFinish_()
			arg_305_1.onSingleLineUpdate_ = nil
			arg_305_1.onSingleLineFinish_ = nil
			arg_305_1.state_ = "waiting"
		end

		function arg_305_1.playNext_(arg_307_0)
			if arg_307_0 == 1 then
				arg_305_0:Play320171074(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			local var_308_0 = 0.475

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, true)

				arg_305_1.leftNameTxt_.text = arg_305_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_305_1.leftNameTxt_.transform)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1.leftNameTxt_.text)
				SetActive(arg_305_1.iconTrs_.gameObject, true)
				arg_305_1.iconController_:SetSelectedState("hero")

				arg_305_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_305_1.callingController_:SetSelectedState("normal")

				arg_305_1.keyicon_.color = Color.New(1, 1, 1)
				arg_305_1.icon_.color = Color.New(1, 1, 1)

				local var_308_1 = arg_305_1:GetWordFromCfg(320171073)
				local var_308_2 = arg_305_1:FormatText(var_308_1.content)

				arg_305_1.text_.text = var_308_2

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_4 = 19 <= 0 and var_308_0 or var_308_0 * (utf8.len(var_308_2) / 19)

				if (19 <= 0 and var_308_0 or var_308_0 * (utf8.len(var_308_2) / 19)) > 0 and var_308_0 < var_308_4 then
					arg_305_1.talkMaxDuration = var_308_4

					if var_308_4 + 0 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_4 + 0
					end
				end

				arg_305_1.text_.text = var_308_2
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320171", "320171073", "story_v_out_320171.awb") ~= 0 then
					local var_308_5 = manager.audio:GetVoiceLength("story_v_out_320171", "320171073", "story_v_out_320171.awb") / 1000

					if var_308_5 + 0 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_5 + 0
					end

					if var_308_1.prefab_name ~= "" and arg_305_1.actors_[var_308_1.prefab_name] ~= nil then
						local var_308_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_305_1.actors_[var_308_1.prefab_name].transform, "story_v_out_320171", "320171073", "story_v_out_320171.awb")

						arg_305_1:RecordAudio("320171073", var_308_6)
						arg_305_1:RecordAudio("320171073", var_308_6)
					else
						arg_305_1:AudioAction("play", "voice", "story_v_out_320171", "320171073", "story_v_out_320171.awb")
					end

					arg_305_1:RecordHistoryTalkVoice("story_v_out_320171", "320171073", "story_v_out_320171.awb")
				end

				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_7 = math.max(var_308_0, arg_305_1.talkMaxDuration)

			if 0 <= arg_305_1.time_ and arg_305_1.time_ < 0 + var_308_7 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - 0) / var_308_7

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= 0 + var_308_7 and arg_305_1.time_ < 0 + var_308_7 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {}

		arg_305_1:InitPlayNodeList()
	end,
	Play320171074 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 320171074
		arg_309_1.duration_ = 9.7

		local var_309_0 = {
			zh = 6.633,
			ja = 9.7
		}
		local var_309_1 = manager.audio:GetLocalizationFlag()

		if var_309_0[var_309_1] ~= nil then
			arg_309_1.duration_ = var_309_0[var_309_1]
		end

		SetActive(arg_309_1.tipsGo_, false)

		function arg_309_1.onSingleLineFinish_()
			arg_309_1.onSingleLineUpdate_ = nil
			arg_309_1.onSingleLineFinish_ = nil
			arg_309_1.state_ = "waiting"
		end

		function arg_309_1.playNext_(arg_311_0)
			if arg_311_0 == 1 then
				arg_309_0:Play320171075(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			local var_312_0 = 0.3

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, true)

				arg_309_1.leftNameTxt_.text = arg_309_1:FormatText(StoryNameCfg[1049].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_309_1.leftNameTxt_.transform)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1.leftNameTxt_.text)
				SetActive(arg_309_1.iconTrs_.gameObject, true)
				arg_309_1.iconController_:SetSelectedState("hero")

				arg_309_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10130")

				arg_309_1.callingController_:SetSelectedState("normal")

				arg_309_1.keyicon_.color = Color.New(1, 1, 1)
				arg_309_1.icon_.color = Color.New(1, 1, 1)

				local var_312_1 = arg_309_1:GetWordFromCfg(320171074)
				local var_312_2 = arg_309_1:FormatText(var_312_1.content)

				arg_309_1.text_.text = var_312_2

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_4 = 12 <= 0 and var_312_0 or var_312_0 * (utf8.len(var_312_2) / 12)

				if (12 <= 0 and var_312_0 or var_312_0 * (utf8.len(var_312_2) / 12)) > 0 and var_312_0 < var_312_4 then
					arg_309_1.talkMaxDuration = var_312_4

					if var_312_4 + 0 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_4 + 0
					end
				end

				arg_309_1.text_.text = var_312_2
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320171", "320171074", "story_v_out_320171.awb") ~= 0 then
					local var_312_5 = manager.audio:GetVoiceLength("story_v_out_320171", "320171074", "story_v_out_320171.awb") / 1000

					if var_312_5 + 0 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_5 + 0
					end

					if var_312_1.prefab_name ~= "" and arg_309_1.actors_[var_312_1.prefab_name] ~= nil then
						local var_312_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_309_1.actors_[var_312_1.prefab_name].transform, "story_v_out_320171", "320171074", "story_v_out_320171.awb")

						arg_309_1:RecordAudio("320171074", var_312_6)
						arg_309_1:RecordAudio("320171074", var_312_6)
					else
						arg_309_1:AudioAction("play", "voice", "story_v_out_320171", "320171074", "story_v_out_320171.awb")
					end

					arg_309_1:RecordHistoryTalkVoice("story_v_out_320171", "320171074", "story_v_out_320171.awb")
				end

				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_7 = math.max(var_312_0, arg_309_1.talkMaxDuration)

			if 0 <= arg_309_1.time_ and arg_309_1.time_ < 0 + var_312_7 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - 0) / var_312_7

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= 0 + var_312_7 and arg_309_1.time_ < 0 + var_312_7 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {}

		arg_309_1:InitPlayNodeList()
	end,
	Play320171075 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 320171075
		arg_313_1.duration_ = 14.4

		local var_313_0 = {
			zh = 7.966,
			ja = 14.4
		}
		local var_313_1 = manager.audio:GetLocalizationFlag()

		if var_313_0[var_313_1] ~= nil then
			arg_313_1.duration_ = var_313_0[var_313_1]
		end

		SetActive(arg_313_1.tipsGo_, false)

		function arg_313_1.onSingleLineFinish_()
			arg_313_1.onSingleLineUpdate_ = nil
			arg_313_1.onSingleLineFinish_ = nil
			arg_313_1.state_ = "waiting"
		end

		function arg_313_1.playNext_(arg_315_0)
			if arg_315_0 == 1 then
				arg_313_0:Play320171076(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			local var_316_0 = 0.625

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, true)

				arg_313_1.leftNameTxt_.text = arg_313_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_313_1.leftNameTxt_.transform)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1.leftNameTxt_.text)
				SetActive(arg_313_1.iconTrs_.gameObject, true)
				arg_313_1.iconController_:SetSelectedState("hero")

				arg_313_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_313_1.callingController_:SetSelectedState("normal")

				arg_313_1.keyicon_.color = Color.New(1, 1, 1)
				arg_313_1.icon_.color = Color.New(1, 1, 1)

				local var_316_1 = arg_313_1:GetWordFromCfg(320171075)
				local var_316_2 = arg_313_1:FormatText(var_316_1.content)

				arg_313_1.text_.text = var_316_2

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_4 = 25 <= 0 and var_316_0 or var_316_0 * (utf8.len(var_316_2) / 25)

				if (25 <= 0 and var_316_0 or var_316_0 * (utf8.len(var_316_2) / 25)) > 0 and var_316_0 < var_316_4 then
					arg_313_1.talkMaxDuration = var_316_4

					if var_316_4 + 0 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_4 + 0
					end
				end

				arg_313_1.text_.text = var_316_2
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320171", "320171075", "story_v_out_320171.awb") ~= 0 then
					local var_316_5 = manager.audio:GetVoiceLength("story_v_out_320171", "320171075", "story_v_out_320171.awb") / 1000

					if var_316_5 + 0 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_5 + 0
					end

					if var_316_1.prefab_name ~= "" and arg_313_1.actors_[var_316_1.prefab_name] ~= nil then
						local var_316_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_313_1.actors_[var_316_1.prefab_name].transform, "story_v_out_320171", "320171075", "story_v_out_320171.awb")

						arg_313_1:RecordAudio("320171075", var_316_6)
						arg_313_1:RecordAudio("320171075", var_316_6)
					else
						arg_313_1:AudioAction("play", "voice", "story_v_out_320171", "320171075", "story_v_out_320171.awb")
					end

					arg_313_1:RecordHistoryTalkVoice("story_v_out_320171", "320171075", "story_v_out_320171.awb")
				end

				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_7 = math.max(var_316_0, arg_313_1.talkMaxDuration)

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_7 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - 0) / var_316_7

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= 0 + var_316_7 and arg_313_1.time_ < 0 + var_316_7 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {}

		arg_313_1:InitPlayNodeList()
	end,
	Play320171076 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 320171076
		arg_317_1.duration_ = 12.9

		local var_317_0 = {
			zh = 8.966,
			ja = 12.9
		}
		local var_317_1 = manager.audio:GetLocalizationFlag()

		if var_317_0[var_317_1] ~= nil then
			arg_317_1.duration_ = var_317_0[var_317_1]
		end

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"
		end

		function arg_317_1.playNext_(arg_319_0)
			if arg_319_0 == 1 then
				arg_317_0:Play320171077(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			local var_320_0 = 0.875

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, true)

				arg_317_1.leftNameTxt_.text = arg_317_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_317_1.leftNameTxt_.transform)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1.leftNameTxt_.text)
				SetActive(arg_317_1.iconTrs_.gameObject, true)
				arg_317_1.iconController_:SetSelectedState("hero")

				arg_317_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_317_1.callingController_:SetSelectedState("normal")

				arg_317_1.keyicon_.color = Color.New(1, 1, 1)
				arg_317_1.icon_.color = Color.New(1, 1, 1)

				local var_320_1 = arg_317_1:GetWordFromCfg(320171076)
				local var_320_2 = arg_317_1:FormatText(var_320_1.content)

				arg_317_1.text_.text = var_320_2

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_4 = 35 <= 0 and var_320_0 or var_320_0 * (utf8.len(var_320_2) / 35)

				if (35 <= 0 and var_320_0 or var_320_0 * (utf8.len(var_320_2) / 35)) > 0 and var_320_0 < var_320_4 then
					arg_317_1.talkMaxDuration = var_320_4

					if var_320_4 + 0 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_4 + 0
					end
				end

				arg_317_1.text_.text = var_320_2
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320171", "320171076", "story_v_out_320171.awb") ~= 0 then
					local var_320_5 = manager.audio:GetVoiceLength("story_v_out_320171", "320171076", "story_v_out_320171.awb") / 1000

					if var_320_5 + 0 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_5 + 0
					end

					if var_320_1.prefab_name ~= "" and arg_317_1.actors_[var_320_1.prefab_name] ~= nil then
						local var_320_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_317_1.actors_[var_320_1.prefab_name].transform, "story_v_out_320171", "320171076", "story_v_out_320171.awb")

						arg_317_1:RecordAudio("320171076", var_320_6)
						arg_317_1:RecordAudio("320171076", var_320_6)
					else
						arg_317_1:AudioAction("play", "voice", "story_v_out_320171", "320171076", "story_v_out_320171.awb")
					end

					arg_317_1:RecordHistoryTalkVoice("story_v_out_320171", "320171076", "story_v_out_320171.awb")
				end

				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_7 = math.max(var_320_0, arg_317_1.talkMaxDuration)

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_7 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - 0) / var_320_7

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= 0 + var_320_7 and arg_317_1.time_ < 0 + var_320_7 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {}

		arg_317_1:InitPlayNodeList()
	end,
	Play320171077 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 320171077
		arg_321_1.duration_ = 6.93

		local var_321_0 = {
			zh = 5.3,
			ja = 6.933
		}
		local var_321_1 = manager.audio:GetLocalizationFlag()

		if var_321_0[var_321_1] ~= nil then
			arg_321_1.duration_ = var_321_0[var_321_1]
		end

		SetActive(arg_321_1.tipsGo_, false)

		function arg_321_1.onSingleLineFinish_()
			arg_321_1.onSingleLineUpdate_ = nil
			arg_321_1.onSingleLineFinish_ = nil
			arg_321_1.state_ = "waiting"
		end

		function arg_321_1.playNext_(arg_323_0)
			if arg_323_0 == 1 then
				arg_321_0:Play320171078(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 then
				arg_321_1.var_.moveOldPos10037ui_story = arg_321_1.actors_["10037ui_story"].transform.localPosition
			end

			local var_324_0 = 0.001

			if 0 <= arg_321_1.time_ and arg_321_1.time_ < 0 + var_324_0 then
				arg_321_1.actors_["10037ui_story"].transform.localPosition = Vector3.Lerp(arg_321_1.var_.moveOldPos10037ui_story, Vector3.New(0, -1.13, -6.2), (arg_321_1.time_ - 0) / var_324_0)
				arg_321_1.actors_["10037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_321_1.actors_["10037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_321_1.actors_["10037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_321_1.actors_["10037ui_story"].transform.position).z)
				arg_321_1.actors_["10037ui_story"].transform.localEulerAngles.z = 0
				arg_321_1.actors_["10037ui_story"].transform.localEulerAngles.x = 0
				arg_321_1.actors_["10037ui_story"].transform.localEulerAngles = arg_321_1.actors_["10037ui_story"].transform.localEulerAngles
			end

			if arg_321_1.time_ >= 0 + var_324_0 and arg_321_1.time_ < 0 + var_324_0 + arg_324_0 then
				arg_321_1.actors_["10037ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_321_1.actors_["10037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_321_1.actors_["10037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_321_1.actors_["10037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_321_1.actors_["10037ui_story"].transform.position).z)
				arg_321_1.actors_["10037ui_story"].transform.localEulerAngles.z = 0
				arg_321_1.actors_["10037ui_story"].transform.localEulerAngles.x = 0
				arg_321_1.actors_["10037ui_story"].transform.localEulerAngles = arg_321_1.actors_["10037ui_story"].transform.localEulerAngles
			end

			local var_324_1 = arg_321_1.actors_["10037ui_story"]

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 and not isNil(var_324_1) and arg_321_1.var_.characterEffect10037ui_story == nil then
				arg_321_1.var_.characterEffect10037ui_story = var_324_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_324_2 = 0.200000002980232

			if 0 <= arg_321_1.time_ and arg_321_1.time_ < 0 + var_324_2 and not isNil(var_324_1) then
				if arg_321_1.var_.characterEffect10037ui_story and not isNil(var_324_1) then
					arg_321_1.var_.characterEffect10037ui_story.fillFlat = false
				end
			end

			if arg_321_1.time_ >= 0 + var_324_2 and arg_321_1.time_ < 0 + var_324_2 + arg_324_0 and not isNil(var_324_1) and arg_321_1.var_.characterEffect10037ui_story then
				arg_321_1.var_.characterEffect10037ui_story.fillFlat = false
			end

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 then
				arg_321_1:PlayTimeline("10037ui_story", "StoryTimeline/CharAction/story10037/story10037action/10037action1_1")
			end

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 then
				arg_321_1:PlayTimeline("10037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_324_4 = 0
			local var_324_5 = 0.25

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= var_324_4 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, true)

				arg_321_1.leftNameTxt_.text = arg_321_1:FormatText(StoryNameCfg[383].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_321_1.leftNameTxt_.transform)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1.leftNameTxt_.text)
				SetActive(arg_321_1.iconTrs_.gameObject, false)
				arg_321_1.callingController_:SetSelectedState("normal")

				local var_324_6 = arg_321_1:GetWordFromCfg(320171077)
				local var_324_7 = arg_321_1:FormatText(var_324_6.content)

				arg_321_1.text_.text = var_324_7

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_9 = 10 <= 0 and var_324_5 or var_324_5 * (utf8.len(var_324_7) / 10)

				if (10 <= 0 and var_324_5 or var_324_5 * (utf8.len(var_324_7) / 10)) > 0 and var_324_5 < var_324_9 then
					arg_321_1.talkMaxDuration = var_324_9

					if var_324_9 + var_324_4 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_9 + var_324_4
					end
				end

				arg_321_1.text_.text = var_324_7
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320171", "320171077", "story_v_out_320171.awb") ~= 0 then
					local var_324_10 = manager.audio:GetVoiceLength("story_v_out_320171", "320171077", "story_v_out_320171.awb") / 1000

					if var_324_10 + var_324_4 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_10 + var_324_4
					end

					if var_324_6.prefab_name ~= "" and arg_321_1.actors_[var_324_6.prefab_name] ~= nil then
						local var_324_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_321_1.actors_[var_324_6.prefab_name].transform, "story_v_out_320171", "320171077", "story_v_out_320171.awb")

						arg_321_1:RecordAudio("320171077", var_324_11)
						arg_321_1:RecordAudio("320171077", var_324_11)
					else
						arg_321_1:AudioAction("play", "voice", "story_v_out_320171", "320171077", "story_v_out_320171.awb")
					end

					arg_321_1:RecordHistoryTalkVoice("story_v_out_320171", "320171077", "story_v_out_320171.awb")
				end

				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_12 = math.max(var_324_5, arg_321_1.talkMaxDuration)

			if var_324_4 <= arg_321_1.time_ and arg_321_1.time_ < var_324_4 + var_324_12 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - var_324_4) / var_324_12

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= var_324_4 + var_324_12 and arg_321_1.time_ < var_324_4 + var_324_12 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_321_1:InitPlayNodeList()
	end,
	Play320171078 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 320171078
		arg_325_1.duration_ = 13.23

		local var_325_0 = {
			zh = 13.233,
			ja = 11.8
		}
		local var_325_1 = manager.audio:GetLocalizationFlag()

		if var_325_0[var_325_1] ~= nil then
			arg_325_1.duration_ = var_325_0[var_325_1]
		end

		SetActive(arg_325_1.tipsGo_, false)

		function arg_325_1.onSingleLineFinish_()
			arg_325_1.onSingleLineUpdate_ = nil
			arg_325_1.onSingleLineFinish_ = nil
			arg_325_1.state_ = "waiting"
		end

		function arg_325_1.playNext_(arg_327_0)
			if arg_327_0 == 1 then
				arg_325_0:Play320171079(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 then
				arg_325_1.var_.moveOldPos10037ui_story = arg_325_1.actors_["10037ui_story"].transform.localPosition
			end

			local var_328_0 = 0.001

			if 0 <= arg_325_1.time_ and arg_325_1.time_ < 0 + var_328_0 then
				arg_325_1.actors_["10037ui_story"].transform.localPosition = Vector3.Lerp(arg_325_1.var_.moveOldPos10037ui_story, Vector3.New(0, 100, 0), (arg_325_1.time_ - 0) / var_328_0)
				arg_325_1.actors_["10037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_325_1.actors_["10037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_325_1.actors_["10037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_325_1.actors_["10037ui_story"].transform.position).z)
				arg_325_1.actors_["10037ui_story"].transform.localEulerAngles.z = 0
				arg_325_1.actors_["10037ui_story"].transform.localEulerAngles.x = 0
				arg_325_1.actors_["10037ui_story"].transform.localEulerAngles = arg_325_1.actors_["10037ui_story"].transform.localEulerAngles
			end

			if arg_325_1.time_ >= 0 + var_328_0 and arg_325_1.time_ < 0 + var_328_0 + arg_328_0 then
				arg_325_1.actors_["10037ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_325_1.actors_["10037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_325_1.actors_["10037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_325_1.actors_["10037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_325_1.actors_["10037ui_story"].transform.position).z)
				arg_325_1.actors_["10037ui_story"].transform.localEulerAngles.z = 0
				arg_325_1.actors_["10037ui_story"].transform.localEulerAngles.x = 0
				arg_325_1.actors_["10037ui_story"].transform.localEulerAngles = arg_325_1.actors_["10037ui_story"].transform.localEulerAngles
			end

			local var_328_1 = arg_325_1.actors_["10037ui_story"]

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 and not isNil(var_328_1) and arg_325_1.var_.characterEffect10037ui_story == nil then
				arg_325_1.var_.characterEffect10037ui_story = var_328_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_328_2 = 0.200000002980232

			if 0 <= arg_325_1.time_ and arg_325_1.time_ < 0 + var_328_2 and not isNil(var_328_1) then
				if arg_325_1.var_.characterEffect10037ui_story and not isNil(var_328_1) then
					arg_325_1.var_.characterEffect10037ui_story.fillFlat = true
					arg_325_1.var_.characterEffect10037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_325_1.time_ - 0) / var_328_2)
				end
			end

			if arg_325_1.time_ >= 0 + var_328_2 and arg_325_1.time_ < 0 + var_328_2 + arg_328_0 and not isNil(var_328_1) and arg_325_1.var_.characterEffect10037ui_story then
				arg_325_1.var_.characterEffect10037ui_story.fillFlat = true
				arg_325_1.var_.characterEffect10037ui_story.fillRatio = 0.5
			end

			local var_328_3 = 0
			local var_328_4 = 1.2

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= var_328_3 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0
				arg_325_1.dialogCg_.alpha = 1

				arg_325_1.dialog_:SetActive(true)
				SetActive(arg_325_1.leftNameGo_, true)

				arg_325_1.leftNameTxt_.text = arg_325_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_325_1.leftNameTxt_.transform)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1.leftNameTxt_.text)
				SetActive(arg_325_1.iconTrs_.gameObject, true)
				arg_325_1.iconController_:SetSelectedState("hero")

				arg_325_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_325_1.callingController_:SetSelectedState("normal")

				arg_325_1.keyicon_.color = Color.New(1, 1, 1)
				arg_325_1.icon_.color = Color.New(1, 1, 1)

				local var_328_5 = arg_325_1:GetWordFromCfg(320171078)
				local var_328_6 = arg_325_1:FormatText(var_328_5.content)

				arg_325_1.text_.text = var_328_6

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_8 = 48 <= 0 and var_328_4 or var_328_4 * (utf8.len(var_328_6) / 48)

				if (48 <= 0 and var_328_4 or var_328_4 * (utf8.len(var_328_6) / 48)) > 0 and var_328_4 < var_328_8 then
					arg_325_1.talkMaxDuration = var_328_8

					if var_328_8 + var_328_3 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_8 + var_328_3
					end
				end

				arg_325_1.text_.text = var_328_6
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320171", "320171078", "story_v_out_320171.awb") ~= 0 then
					local var_328_9 = manager.audio:GetVoiceLength("story_v_out_320171", "320171078", "story_v_out_320171.awb") / 1000

					if var_328_9 + var_328_3 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_9 + var_328_3
					end

					if var_328_5.prefab_name ~= "" and arg_325_1.actors_[var_328_5.prefab_name] ~= nil then
						local var_328_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_325_1.actors_[var_328_5.prefab_name].transform, "story_v_out_320171", "320171078", "story_v_out_320171.awb")

						arg_325_1:RecordAudio("320171078", var_328_10)
						arg_325_1:RecordAudio("320171078", var_328_10)
					else
						arg_325_1:AudioAction("play", "voice", "story_v_out_320171", "320171078", "story_v_out_320171.awb")
					end

					arg_325_1:RecordHistoryTalkVoice("story_v_out_320171", "320171078", "story_v_out_320171.awb")
				end

				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_11 = math.max(var_328_4, arg_325_1.talkMaxDuration)

			if var_328_3 <= arg_325_1.time_ and arg_325_1.time_ < var_328_3 + var_328_11 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - var_328_3) / var_328_11

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= var_328_3 + var_328_11 and arg_325_1.time_ < var_328_3 + var_328_11 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_325_1:InitPlayNodeList()
	end,
	Play320171079 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 320171079
		arg_329_1.duration_ = 16.47

		local var_329_0 = {
			zh = 10.433,
			ja = 16.466
		}
		local var_329_1 = manager.audio:GetLocalizationFlag()

		if var_329_0[var_329_1] ~= nil then
			arg_329_1.duration_ = var_329_0[var_329_1]
		end

		SetActive(arg_329_1.tipsGo_, false)

		function arg_329_1.onSingleLineFinish_()
			arg_329_1.onSingleLineUpdate_ = nil
			arg_329_1.onSingleLineFinish_ = nil
			arg_329_1.state_ = "waiting"
		end

		function arg_329_1.playNext_(arg_331_0)
			if arg_331_0 == 1 then
				arg_329_0:Play320171080(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			local var_332_0 = 0.95

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0
				arg_329_1.dialogCg_.alpha = 1

				arg_329_1.dialog_:SetActive(true)
				SetActive(arg_329_1.leftNameGo_, true)

				arg_329_1.leftNameTxt_.text = arg_329_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_329_1.leftNameTxt_.transform)

				arg_329_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_329_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_329_1:RecordName(arg_329_1.leftNameTxt_.text)
				SetActive(arg_329_1.iconTrs_.gameObject, true)
				arg_329_1.iconController_:SetSelectedState("hero")

				arg_329_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_329_1.callingController_:SetSelectedState("normal")

				arg_329_1.keyicon_.color = Color.New(1, 1, 1)
				arg_329_1.icon_.color = Color.New(1, 1, 1)

				local var_332_1 = arg_329_1:GetWordFromCfg(320171079)
				local var_332_2 = arg_329_1:FormatText(var_332_1.content)

				arg_329_1.text_.text = var_332_2

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_4 = 38 <= 0 and var_332_0 or var_332_0 * (utf8.len(var_332_2) / 38)

				if (38 <= 0 and var_332_0 or var_332_0 * (utf8.len(var_332_2) / 38)) > 0 and var_332_0 < var_332_4 then
					arg_329_1.talkMaxDuration = var_332_4

					if var_332_4 + 0 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_4 + 0
					end
				end

				arg_329_1.text_.text = var_332_2
				arg_329_1.typewritter.percent = 0

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320171", "320171079", "story_v_out_320171.awb") ~= 0 then
					local var_332_5 = manager.audio:GetVoiceLength("story_v_out_320171", "320171079", "story_v_out_320171.awb") / 1000

					if var_332_5 + 0 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_5 + 0
					end

					if var_332_1.prefab_name ~= "" and arg_329_1.actors_[var_332_1.prefab_name] ~= nil then
						local var_332_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_329_1.actors_[var_332_1.prefab_name].transform, "story_v_out_320171", "320171079", "story_v_out_320171.awb")

						arg_329_1:RecordAudio("320171079", var_332_6)
						arg_329_1:RecordAudio("320171079", var_332_6)
					else
						arg_329_1:AudioAction("play", "voice", "story_v_out_320171", "320171079", "story_v_out_320171.awb")
					end

					arg_329_1:RecordHistoryTalkVoice("story_v_out_320171", "320171079", "story_v_out_320171.awb")
				end

				arg_329_1:RecordContent(arg_329_1.text_.text)
			end

			local var_332_7 = math.max(var_332_0, arg_329_1.talkMaxDuration)

			if 0 <= arg_329_1.time_ and arg_329_1.time_ < 0 + var_332_7 then
				arg_329_1.typewritter.percent = (arg_329_1.time_ - 0) / var_332_7

				arg_329_1.typewritter:SetDirty()
			end

			if arg_329_1.time_ >= 0 + var_332_7 and arg_329_1.time_ < 0 + var_332_7 + arg_332_0 then
				arg_329_1.typewritter.percent = 1

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(true)
			end
		end

		arg_329_1.nodeConfigList_ = {}

		arg_329_1:InitPlayNodeList()
	end,
	Play320171080 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 320171080
		arg_333_1.duration_ = 19.1

		local var_333_0 = {
			zh = 14,
			ja = 19.1
		}
		local var_333_1 = manager.audio:GetLocalizationFlag()

		if var_333_0[var_333_1] ~= nil then
			arg_333_1.duration_ = var_333_0[var_333_1]
		end

		SetActive(arg_333_1.tipsGo_, false)

		function arg_333_1.onSingleLineFinish_()
			arg_333_1.onSingleLineUpdate_ = nil
			arg_333_1.onSingleLineFinish_ = nil
			arg_333_1.state_ = "waiting"
		end

		function arg_333_1.playNext_(arg_335_0)
			if arg_335_0 == 1 then
				arg_333_0:Play320171081(arg_333_1)
			end
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			local var_336_0 = 0.925

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 then
				arg_333_1.talkMaxDuration = 0
				arg_333_1.dialogCg_.alpha = 1

				arg_333_1.dialog_:SetActive(true)
				SetActive(arg_333_1.leftNameGo_, true)

				arg_333_1.leftNameTxt_.text = arg_333_1:FormatText(StoryNameCfg[1049].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_333_1.leftNameTxt_.transform)

				arg_333_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_333_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_333_1:RecordName(arg_333_1.leftNameTxt_.text)
				SetActive(arg_333_1.iconTrs_.gameObject, true)
				arg_333_1.iconController_:SetSelectedState("hero")

				arg_333_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10130")

				arg_333_1.callingController_:SetSelectedState("normal")

				arg_333_1.keyicon_.color = Color.New(1, 1, 1)
				arg_333_1.icon_.color = Color.New(1, 1, 1)

				local var_336_1 = arg_333_1:GetWordFromCfg(320171080)
				local var_336_2 = arg_333_1:FormatText(var_336_1.content)

				arg_333_1.text_.text = var_336_2

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_4 = 37 <= 0 and var_336_0 or var_336_0 * (utf8.len(var_336_2) / 37)

				if (37 <= 0 and var_336_0 or var_336_0 * (utf8.len(var_336_2) / 37)) > 0 and var_336_0 < var_336_4 then
					arg_333_1.talkMaxDuration = var_336_4

					if var_336_4 + 0 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_4 + 0
					end
				end

				arg_333_1.text_.text = var_336_2
				arg_333_1.typewritter.percent = 0

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320171", "320171080", "story_v_out_320171.awb") ~= 0 then
					local var_336_5 = manager.audio:GetVoiceLength("story_v_out_320171", "320171080", "story_v_out_320171.awb") / 1000

					if var_336_5 + 0 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_5 + 0
					end

					if var_336_1.prefab_name ~= "" and arg_333_1.actors_[var_336_1.prefab_name] ~= nil then
						local var_336_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_333_1.actors_[var_336_1.prefab_name].transform, "story_v_out_320171", "320171080", "story_v_out_320171.awb")

						arg_333_1:RecordAudio("320171080", var_336_6)
						arg_333_1:RecordAudio("320171080", var_336_6)
					else
						arg_333_1:AudioAction("play", "voice", "story_v_out_320171", "320171080", "story_v_out_320171.awb")
					end

					arg_333_1:RecordHistoryTalkVoice("story_v_out_320171", "320171080", "story_v_out_320171.awb")
				end

				arg_333_1:RecordContent(arg_333_1.text_.text)
			end

			local var_336_7 = math.max(var_336_0, arg_333_1.talkMaxDuration)

			if 0 <= arg_333_1.time_ and arg_333_1.time_ < 0 + var_336_7 then
				arg_333_1.typewritter.percent = (arg_333_1.time_ - 0) / var_336_7

				arg_333_1.typewritter:SetDirty()
			end

			if arg_333_1.time_ >= 0 + var_336_7 and arg_333_1.time_ < 0 + var_336_7 + arg_336_0 then
				arg_333_1.typewritter.percent = 1

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(true)
			end
		end

		arg_333_1.nodeConfigList_ = {}

		arg_333_1:InitPlayNodeList()
	end,
	Play320171081 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 320171081
		arg_337_1.duration_ = 14.83

		local var_337_0 = {
			zh = 10.433,
			ja = 14.833
		}
		local var_337_1 = manager.audio:GetLocalizationFlag()

		if var_337_0[var_337_1] ~= nil then
			arg_337_1.duration_ = var_337_0[var_337_1]
		end

		SetActive(arg_337_1.tipsGo_, false)

		function arg_337_1.onSingleLineFinish_()
			arg_337_1.onSingleLineUpdate_ = nil
			arg_337_1.onSingleLineFinish_ = nil
			arg_337_1.state_ = "waiting"
		end

		function arg_337_1.playNext_(arg_339_0)
			if arg_339_0 == 1 then
				arg_337_0:Play320171082(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			local var_340_0 = 0.6

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 then
				arg_337_1.talkMaxDuration = 0
				arg_337_1.dialogCg_.alpha = 1

				arg_337_1.dialog_:SetActive(true)
				SetActive(arg_337_1.leftNameGo_, true)

				arg_337_1.leftNameTxt_.text = arg_337_1:FormatText(StoryNameCfg[1049].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_337_1.leftNameTxt_.transform)

				arg_337_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_337_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_337_1:RecordName(arg_337_1.leftNameTxt_.text)
				SetActive(arg_337_1.iconTrs_.gameObject, true)
				arg_337_1.iconController_:SetSelectedState("hero")

				arg_337_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10130")

				arg_337_1.callingController_:SetSelectedState("normal")

				arg_337_1.keyicon_.color = Color.New(1, 1, 1)
				arg_337_1.icon_.color = Color.New(1, 1, 1)

				local var_340_1 = arg_337_1:GetWordFromCfg(320171081)
				local var_340_2 = arg_337_1:FormatText(var_340_1.content)

				arg_337_1.text_.text = var_340_2

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_4 = 24 <= 0 and var_340_0 or var_340_0 * (utf8.len(var_340_2) / 24)

				if (24 <= 0 and var_340_0 or var_340_0 * (utf8.len(var_340_2) / 24)) > 0 and var_340_0 < var_340_4 then
					arg_337_1.talkMaxDuration = var_340_4

					if var_340_4 + 0 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_4 + 0
					end
				end

				arg_337_1.text_.text = var_340_2
				arg_337_1.typewritter.percent = 0

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320171", "320171081", "story_v_out_320171.awb") ~= 0 then
					local var_340_5 = manager.audio:GetVoiceLength("story_v_out_320171", "320171081", "story_v_out_320171.awb") / 1000

					if var_340_5 + 0 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_5 + 0
					end

					if var_340_1.prefab_name ~= "" and arg_337_1.actors_[var_340_1.prefab_name] ~= nil then
						local var_340_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_337_1.actors_[var_340_1.prefab_name].transform, "story_v_out_320171", "320171081", "story_v_out_320171.awb")

						arg_337_1:RecordAudio("320171081", var_340_6)
						arg_337_1:RecordAudio("320171081", var_340_6)
					else
						arg_337_1:AudioAction("play", "voice", "story_v_out_320171", "320171081", "story_v_out_320171.awb")
					end

					arg_337_1:RecordHistoryTalkVoice("story_v_out_320171", "320171081", "story_v_out_320171.awb")
				end

				arg_337_1:RecordContent(arg_337_1.text_.text)
			end

			local var_340_7 = math.max(var_340_0, arg_337_1.talkMaxDuration)

			if 0 <= arg_337_1.time_ and arg_337_1.time_ < 0 + var_340_7 then
				arg_337_1.typewritter.percent = (arg_337_1.time_ - 0) / var_340_7

				arg_337_1.typewritter:SetDirty()
			end

			if arg_337_1.time_ >= 0 + var_340_7 and arg_337_1.time_ < 0 + var_340_7 + arg_340_0 then
				arg_337_1.typewritter.percent = 1

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(true)
			end
		end

		arg_337_1.nodeConfigList_ = {}

		arg_337_1:InitPlayNodeList()
	end,
	Play320171082 = function(arg_341_0, arg_341_1)
		arg_341_1.time_ = 0
		arg_341_1.frameCnt_ = 0
		arg_341_1.state_ = "playing"
		arg_341_1.curTalkId_ = 320171082
		arg_341_1.duration_ = 16.73

		local var_341_0 = {
			zh = 11.633,
			ja = 16.733
		}
		local var_341_1 = manager.audio:GetLocalizationFlag()

		if var_341_0[var_341_1] ~= nil then
			arg_341_1.duration_ = var_341_0[var_341_1]
		end

		SetActive(arg_341_1.tipsGo_, false)

		function arg_341_1.onSingleLineFinish_()
			arg_341_1.onSingleLineUpdate_ = nil
			arg_341_1.onSingleLineFinish_ = nil
			arg_341_1.state_ = "waiting"
		end

		function arg_341_1.playNext_(arg_343_0)
			if arg_343_0 == 1 then
				arg_341_0:Play320171083(arg_341_1)
			end
		end

		function arg_341_1.onSingleLineUpdate_(arg_344_0)
			local var_344_0 = 0.95

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 then
				arg_341_1.talkMaxDuration = 0
				arg_341_1.dialogCg_.alpha = 1

				arg_341_1.dialog_:SetActive(true)
				SetActive(arg_341_1.leftNameGo_, true)

				arg_341_1.leftNameTxt_.text = arg_341_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_341_1.leftNameTxt_.transform)

				arg_341_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_341_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_341_1:RecordName(arg_341_1.leftNameTxt_.text)
				SetActive(arg_341_1.iconTrs_.gameObject, true)
				arg_341_1.iconController_:SetSelectedState("hero")

				arg_341_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_341_1.callingController_:SetSelectedState("normal")

				arg_341_1.keyicon_.color = Color.New(1, 1, 1)
				arg_341_1.icon_.color = Color.New(1, 1, 1)

				local var_344_1 = arg_341_1:GetWordFromCfg(320171082)
				local var_344_2 = arg_341_1:FormatText(var_344_1.content)

				arg_341_1.text_.text = var_344_2

				LuaForUtil.ClearLinePrefixSymbol(arg_341_1.text_)

				local var_344_4 = 38 <= 0 and var_344_0 or var_344_0 * (utf8.len(var_344_2) / 38)

				if (38 <= 0 and var_344_0 or var_344_0 * (utf8.len(var_344_2) / 38)) > 0 and var_344_0 < var_344_4 then
					arg_341_1.talkMaxDuration = var_344_4

					if var_344_4 + 0 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_4 + 0
					end
				end

				arg_341_1.text_.text = var_344_2
				arg_341_1.typewritter.percent = 0

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320171", "320171082", "story_v_out_320171.awb") ~= 0 then
					local var_344_5 = manager.audio:GetVoiceLength("story_v_out_320171", "320171082", "story_v_out_320171.awb") / 1000

					if var_344_5 + 0 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_5 + 0
					end

					if var_344_1.prefab_name ~= "" and arg_341_1.actors_[var_344_1.prefab_name] ~= nil then
						local var_344_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_341_1.actors_[var_344_1.prefab_name].transform, "story_v_out_320171", "320171082", "story_v_out_320171.awb")

						arg_341_1:RecordAudio("320171082", var_344_6)
						arg_341_1:RecordAudio("320171082", var_344_6)
					else
						arg_341_1:AudioAction("play", "voice", "story_v_out_320171", "320171082", "story_v_out_320171.awb")
					end

					arg_341_1:RecordHistoryTalkVoice("story_v_out_320171", "320171082", "story_v_out_320171.awb")
				end

				arg_341_1:RecordContent(arg_341_1.text_.text)
			end

			local var_344_7 = math.max(var_344_0, arg_341_1.talkMaxDuration)

			if 0 <= arg_341_1.time_ and arg_341_1.time_ < 0 + var_344_7 then
				arg_341_1.typewritter.percent = (arg_341_1.time_ - 0) / var_344_7

				arg_341_1.typewritter:SetDirty()
			end

			if arg_341_1.time_ >= 0 + var_344_7 and arg_341_1.time_ < 0 + var_344_7 + arg_344_0 then
				arg_341_1.typewritter.percent = 1

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(true)
			end
		end

		arg_341_1.nodeConfigList_ = {}

		arg_341_1:InitPlayNodeList()
	end,
	Play320171083 = function(arg_345_0, arg_345_1)
		arg_345_1.time_ = 0
		arg_345_1.frameCnt_ = 0
		arg_345_1.state_ = "playing"
		arg_345_1.curTalkId_ = 320171083
		arg_345_1.duration_ = 12.6

		local var_345_0 = {
			zh = 7.3,
			ja = 12.6
		}
		local var_345_1 = manager.audio:GetLocalizationFlag()

		if var_345_0[var_345_1] ~= nil then
			arg_345_1.duration_ = var_345_0[var_345_1]
		end

		SetActive(arg_345_1.tipsGo_, false)

		function arg_345_1.onSingleLineFinish_()
			arg_345_1.onSingleLineUpdate_ = nil
			arg_345_1.onSingleLineFinish_ = nil
			arg_345_1.state_ = "waiting"
		end

		function arg_345_1.playNext_(arg_347_0)
			if arg_347_0 == 1 then
				arg_345_0:Play320171084(arg_345_1)
			end
		end

		function arg_345_1.onSingleLineUpdate_(arg_348_0)
			local var_348_0 = 0.525

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 then
				arg_345_1.talkMaxDuration = 0
				arg_345_1.dialogCg_.alpha = 1

				arg_345_1.dialog_:SetActive(true)
				SetActive(arg_345_1.leftNameGo_, true)

				arg_345_1.leftNameTxt_.text = arg_345_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_345_1.leftNameTxt_.transform)

				arg_345_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_345_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_345_1:RecordName(arg_345_1.leftNameTxt_.text)
				SetActive(arg_345_1.iconTrs_.gameObject, true)
				arg_345_1.iconController_:SetSelectedState("hero")

				arg_345_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_345_1.callingController_:SetSelectedState("normal")

				arg_345_1.keyicon_.color = Color.New(1, 1, 1)
				arg_345_1.icon_.color = Color.New(1, 1, 1)

				local var_348_1 = arg_345_1:GetWordFromCfg(320171083)
				local var_348_2 = arg_345_1:FormatText(var_348_1.content)

				arg_345_1.text_.text = var_348_2

				LuaForUtil.ClearLinePrefixSymbol(arg_345_1.text_)

				local var_348_4 = 21 <= 0 and var_348_0 or var_348_0 * (utf8.len(var_348_2) / 21)

				if (21 <= 0 and var_348_0 or var_348_0 * (utf8.len(var_348_2) / 21)) > 0 and var_348_0 < var_348_4 then
					arg_345_1.talkMaxDuration = var_348_4

					if var_348_4 + 0 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_4 + 0
					end
				end

				arg_345_1.text_.text = var_348_2
				arg_345_1.typewritter.percent = 0

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320171", "320171083", "story_v_out_320171.awb") ~= 0 then
					local var_348_5 = manager.audio:GetVoiceLength("story_v_out_320171", "320171083", "story_v_out_320171.awb") / 1000

					if var_348_5 + 0 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_5 + 0
					end

					if var_348_1.prefab_name ~= "" and arg_345_1.actors_[var_348_1.prefab_name] ~= nil then
						local var_348_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_345_1.actors_[var_348_1.prefab_name].transform, "story_v_out_320171", "320171083", "story_v_out_320171.awb")

						arg_345_1:RecordAudio("320171083", var_348_6)
						arg_345_1:RecordAudio("320171083", var_348_6)
					else
						arg_345_1:AudioAction("play", "voice", "story_v_out_320171", "320171083", "story_v_out_320171.awb")
					end

					arg_345_1:RecordHistoryTalkVoice("story_v_out_320171", "320171083", "story_v_out_320171.awb")
				end

				arg_345_1:RecordContent(arg_345_1.text_.text)
			end

			local var_348_7 = math.max(var_348_0, arg_345_1.talkMaxDuration)

			if 0 <= arg_345_1.time_ and arg_345_1.time_ < 0 + var_348_7 then
				arg_345_1.typewritter.percent = (arg_345_1.time_ - 0) / var_348_7

				arg_345_1.typewritter:SetDirty()
			end

			if arg_345_1.time_ >= 0 + var_348_7 and arg_345_1.time_ < 0 + var_348_7 + arg_348_0 then
				arg_345_1.typewritter.percent = 1

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(true)
			end
		end

		arg_345_1.nodeConfigList_ = {}

		arg_345_1:InitPlayNodeList()
	end,
	Play320171084 = function(arg_349_0, arg_349_1)
		arg_349_1.time_ = 0
		arg_349_1.frameCnt_ = 0
		arg_349_1.state_ = "playing"
		arg_349_1.curTalkId_ = 320171084
		arg_349_1.duration_ = 11.5

		local var_349_0 = {
			zh = 11.5,
			ja = 10.6
		}
		local var_349_1 = manager.audio:GetLocalizationFlag()

		if var_349_0[var_349_1] ~= nil then
			arg_349_1.duration_ = var_349_0[var_349_1]
		end

		SetActive(arg_349_1.tipsGo_, false)

		function arg_349_1.onSingleLineFinish_()
			arg_349_1.onSingleLineUpdate_ = nil
			arg_349_1.onSingleLineFinish_ = nil
			arg_349_1.state_ = "waiting"
		end

		function arg_349_1.playNext_(arg_351_0)
			if arg_351_0 == 1 then
				arg_349_0:Play320171085(arg_349_1)
			end
		end

		function arg_349_1.onSingleLineUpdate_(arg_352_0)
			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 then
				arg_349_1.var_.moveOldPos10045ui_story = arg_349_1.actors_["10045ui_story"].transform.localPosition
			end

			local var_352_0 = 0.001

			if 0 <= arg_349_1.time_ and arg_349_1.time_ < 0 + var_352_0 then
				arg_349_1.actors_["10045ui_story"].transform.localPosition = Vector3.Lerp(arg_349_1.var_.moveOldPos10045ui_story, Vector3.New(0, -1.18, -6.05), (arg_349_1.time_ - 0) / var_352_0)
				arg_349_1.actors_["10045ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_349_1.actors_["10045ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_349_1.actors_["10045ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_349_1.actors_["10045ui_story"].transform.position).z)
				arg_349_1.actors_["10045ui_story"].transform.localEulerAngles.z = 0
				arg_349_1.actors_["10045ui_story"].transform.localEulerAngles.x = 0
				arg_349_1.actors_["10045ui_story"].transform.localEulerAngles = arg_349_1.actors_["10045ui_story"].transform.localEulerAngles
			end

			if arg_349_1.time_ >= 0 + var_352_0 and arg_349_1.time_ < 0 + var_352_0 + arg_352_0 then
				arg_349_1.actors_["10045ui_story"].transform.localPosition = Vector3.New(0, -1.18, -6.05)
				arg_349_1.actors_["10045ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_349_1.actors_["10045ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_349_1.actors_["10045ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_349_1.actors_["10045ui_story"].transform.position).z)
				arg_349_1.actors_["10045ui_story"].transform.localEulerAngles.z = 0
				arg_349_1.actors_["10045ui_story"].transform.localEulerAngles.x = 0
				arg_349_1.actors_["10045ui_story"].transform.localEulerAngles = arg_349_1.actors_["10045ui_story"].transform.localEulerAngles
			end

			local var_352_1 = arg_349_1.actors_["10045ui_story"]

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 and not isNil(var_352_1) and arg_349_1.var_.characterEffect10045ui_story == nil then
				arg_349_1.var_.characterEffect10045ui_story = var_352_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_352_2 = 0.200000002980232

			if 0 <= arg_349_1.time_ and arg_349_1.time_ < 0 + var_352_2 and not isNil(var_352_1) then
				if arg_349_1.var_.characterEffect10045ui_story and not isNil(var_352_1) then
					arg_349_1.var_.characterEffect10045ui_story.fillFlat = false
				end
			end

			if arg_349_1.time_ >= 0 + var_352_2 and arg_349_1.time_ < 0 + var_352_2 + arg_352_0 and not isNil(var_352_1) and arg_349_1.var_.characterEffect10045ui_story then
				arg_349_1.var_.characterEffect10045ui_story.fillFlat = false
			end

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 then
				arg_349_1:PlayTimeline("10045ui_story", "StoryTimeline/CharAction/story10045/story10045actionlink/10045action446")
			end

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 then
				arg_349_1:PlayTimeline("10045ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_352_4 = 0
			local var_352_5 = 1

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= var_352_4 + arg_352_0 then
				arg_349_1.talkMaxDuration = 0
				arg_349_1.dialogCg_.alpha = 1

				arg_349_1.dialog_:SetActive(true)
				SetActive(arg_349_1.leftNameGo_, true)

				arg_349_1.leftNameTxt_.text = arg_349_1:FormatText(StoryNameCfg[45].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_349_1.leftNameTxt_.transform)

				arg_349_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_349_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_349_1:RecordName(arg_349_1.leftNameTxt_.text)
				SetActive(arg_349_1.iconTrs_.gameObject, false)
				arg_349_1.callingController_:SetSelectedState("normal")

				local var_352_6 = arg_349_1:GetWordFromCfg(320171084)
				local var_352_7 = arg_349_1:FormatText(var_352_6.content)

				arg_349_1.text_.text = var_352_7

				LuaForUtil.ClearLinePrefixSymbol(arg_349_1.text_)

				local var_352_9 = 40 <= 0 and var_352_5 or var_352_5 * (utf8.len(var_352_7) / 40)

				if (40 <= 0 and var_352_5 or var_352_5 * (utf8.len(var_352_7) / 40)) > 0 and var_352_5 < var_352_9 then
					arg_349_1.talkMaxDuration = var_352_9

					if var_352_9 + var_352_4 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_9 + var_352_4
					end
				end

				arg_349_1.text_.text = var_352_7
				arg_349_1.typewritter.percent = 0

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320171", "320171084", "story_v_out_320171.awb") ~= 0 then
					local var_352_10 = manager.audio:GetVoiceLength("story_v_out_320171", "320171084", "story_v_out_320171.awb") / 1000

					if var_352_10 + var_352_4 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_10 + var_352_4
					end

					if var_352_6.prefab_name ~= "" and arg_349_1.actors_[var_352_6.prefab_name] ~= nil then
						local var_352_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_349_1.actors_[var_352_6.prefab_name].transform, "story_v_out_320171", "320171084", "story_v_out_320171.awb")

						arg_349_1:RecordAudio("320171084", var_352_11)
						arg_349_1:RecordAudio("320171084", var_352_11)
					else
						arg_349_1:AudioAction("play", "voice", "story_v_out_320171", "320171084", "story_v_out_320171.awb")
					end

					arg_349_1:RecordHistoryTalkVoice("story_v_out_320171", "320171084", "story_v_out_320171.awb")
				end

				arg_349_1:RecordContent(arg_349_1.text_.text)
			end

			local var_352_12 = math.max(var_352_5, arg_349_1.talkMaxDuration)

			if var_352_4 <= arg_349_1.time_ and arg_349_1.time_ < var_352_4 + var_352_12 then
				arg_349_1.typewritter.percent = (arg_349_1.time_ - var_352_4) / var_352_12

				arg_349_1.typewritter:SetDirty()
			end

			if arg_349_1.time_ >= var_352_4 + var_352_12 and arg_349_1.time_ < var_352_4 + var_352_12 + arg_352_0 then
				arg_349_1.typewritter.percent = 1

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(true)
			end
		end

		arg_349_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10045ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_349_1:InitPlayNodeList()
	end,
	Play320171085 = function(arg_353_0, arg_353_1)
		arg_353_1.time_ = 0
		arg_353_1.frameCnt_ = 0
		arg_353_1.state_ = "playing"
		arg_353_1.curTalkId_ = 320171085
		arg_353_1.duration_ = 4.9

		local var_353_0 = {
			zh = 3.9,
			ja = 4.9
		}
		local var_353_1 = manager.audio:GetLocalizationFlag()

		if var_353_0[var_353_1] ~= nil then
			arg_353_1.duration_ = var_353_0[var_353_1]
		end

		SetActive(arg_353_1.tipsGo_, false)

		function arg_353_1.onSingleLineFinish_()
			arg_353_1.onSingleLineUpdate_ = nil
			arg_353_1.onSingleLineFinish_ = nil
			arg_353_1.state_ = "waiting"
		end

		function arg_353_1.playNext_(arg_355_0)
			if arg_355_0 == 1 then
				arg_353_0:Play320171086(arg_353_1)
			end
		end

		function arg_353_1.onSingleLineUpdate_(arg_356_0)
			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 then
				arg_353_1.var_.moveOldPos10037ui_story = arg_353_1.actors_["10037ui_story"].transform.localPosition
			end

			local var_356_0 = 0.001

			if 0 <= arg_353_1.time_ and arg_353_1.time_ < 0 + var_356_0 then
				arg_353_1.actors_["10037ui_story"].transform.localPosition = Vector3.Lerp(arg_353_1.var_.moveOldPos10037ui_story, Vector3.New(0, -1.13, -6.2), (arg_353_1.time_ - 0) / var_356_0)
				arg_353_1.actors_["10037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_353_1.actors_["10037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_353_1.actors_["10037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_353_1.actors_["10037ui_story"].transform.position).z)
				arg_353_1.actors_["10037ui_story"].transform.localEulerAngles.z = 0
				arg_353_1.actors_["10037ui_story"].transform.localEulerAngles.x = 0
				arg_353_1.actors_["10037ui_story"].transform.localEulerAngles = arg_353_1.actors_["10037ui_story"].transform.localEulerAngles
			end

			if arg_353_1.time_ >= 0 + var_356_0 and arg_353_1.time_ < 0 + var_356_0 + arg_356_0 then
				arg_353_1.actors_["10037ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_353_1.actors_["10037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_353_1.actors_["10037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_353_1.actors_["10037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_353_1.actors_["10037ui_story"].transform.position).z)
				arg_353_1.actors_["10037ui_story"].transform.localEulerAngles.z = 0
				arg_353_1.actors_["10037ui_story"].transform.localEulerAngles.x = 0
				arg_353_1.actors_["10037ui_story"].transform.localEulerAngles = arg_353_1.actors_["10037ui_story"].transform.localEulerAngles
			end

			local var_356_1 = arg_353_1.actors_["10037ui_story"]

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 and not isNil(var_356_1) and arg_353_1.var_.characterEffect10037ui_story == nil then
				arg_353_1.var_.characterEffect10037ui_story = var_356_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_356_2 = 0.200000002980232

			if 0 <= arg_353_1.time_ and arg_353_1.time_ < 0 + var_356_2 and not isNil(var_356_1) then
				if arg_353_1.var_.characterEffect10037ui_story and not isNil(var_356_1) then
					arg_353_1.var_.characterEffect10037ui_story.fillFlat = false
				end
			end

			if arg_353_1.time_ >= 0 + var_356_2 and arg_353_1.time_ < 0 + var_356_2 + arg_356_0 and not isNil(var_356_1) and arg_353_1.var_.characterEffect10037ui_story then
				arg_353_1.var_.characterEffect10037ui_story.fillFlat = false
			end

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 then
				arg_353_1:PlayTimeline("10037ui_story", "StoryTimeline/CharAction/story10037/story10037action/10037action1_1")
			end

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 then
				arg_353_1:PlayTimeline("10037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_356_4 = arg_353_1.actors_["10045ui_story"].transform

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 then
				arg_353_1.var_.moveOldPos10045ui_story = var_356_4.localPosition
			end

			local var_356_5 = 0.001

			if 0 <= arg_353_1.time_ and arg_353_1.time_ < 0 + var_356_5 then
				var_356_4.localPosition = Vector3.Lerp(arg_353_1.var_.moveOldPos10045ui_story, Vector3.New(0, 100, 0), (arg_353_1.time_ - 0) / var_356_5)
				var_356_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_356_4.position).x, (manager.ui.mainCamera.transform.position - var_356_4.position).y, (manager.ui.mainCamera.transform.position - var_356_4.position).z)
				var_356_4.localEulerAngles.z = 0
				var_356_4.localEulerAngles.x = 0
				var_356_4.localEulerAngles = var_356_4.localEulerAngles
			end

			if arg_353_1.time_ >= 0 + var_356_5 and arg_353_1.time_ < 0 + var_356_5 + arg_356_0 then
				var_356_4.localPosition = Vector3.New(0, 100, 0)
				var_356_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_356_4.position).x, (manager.ui.mainCamera.transform.position - var_356_4.position).y, (manager.ui.mainCamera.transform.position - var_356_4.position).z)
				var_356_4.localEulerAngles.z = 0
				var_356_4.localEulerAngles.x = 0
				var_356_4.localEulerAngles = var_356_4.localEulerAngles
			end

			local var_356_6 = arg_353_1.actors_["10045ui_story"]

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 and not isNil(var_356_6) and arg_353_1.var_.characterEffect10045ui_story == nil then
				arg_353_1.var_.characterEffect10045ui_story = var_356_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_356_7 = 0.200000002980232

			if 0 <= arg_353_1.time_ and arg_353_1.time_ < 0 + var_356_7 and not isNil(var_356_6) then
				if arg_353_1.var_.characterEffect10045ui_story and not isNil(var_356_6) then
					arg_353_1.var_.characterEffect10045ui_story.fillFlat = true
					arg_353_1.var_.characterEffect10045ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_353_1.time_ - 0) / var_356_7)
				end
			end

			if arg_353_1.time_ >= 0 + var_356_7 and arg_353_1.time_ < 0 + var_356_7 + arg_356_0 and not isNil(var_356_6) and arg_353_1.var_.characterEffect10045ui_story then
				arg_353_1.var_.characterEffect10045ui_story.fillFlat = true
				arg_353_1.var_.characterEffect10045ui_story.fillRatio = 0.5
			end

			local var_356_8 = 0
			local var_356_9 = 0.15

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= var_356_8 + arg_356_0 then
				arg_353_1.talkMaxDuration = 0
				arg_353_1.dialogCg_.alpha = 1

				arg_353_1.dialog_:SetActive(true)
				SetActive(arg_353_1.leftNameGo_, true)

				arg_353_1.leftNameTxt_.text = arg_353_1:FormatText(StoryNameCfg[383].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_353_1.leftNameTxt_.transform)

				arg_353_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_353_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_353_1:RecordName(arg_353_1.leftNameTxt_.text)
				SetActive(arg_353_1.iconTrs_.gameObject, false)
				arg_353_1.callingController_:SetSelectedState("normal")

				local var_356_10 = arg_353_1:GetWordFromCfg(320171085)
				local var_356_11 = arg_353_1:FormatText(var_356_10.content)

				arg_353_1.text_.text = var_356_11

				LuaForUtil.ClearLinePrefixSymbol(arg_353_1.text_)

				local var_356_13 = 6 <= 0 and var_356_9 or var_356_9 * (utf8.len(var_356_11) / 6)

				if (6 <= 0 and var_356_9 or var_356_9 * (utf8.len(var_356_11) / 6)) > 0 and var_356_9 < var_356_13 then
					arg_353_1.talkMaxDuration = var_356_13

					if var_356_13 + var_356_8 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_13 + var_356_8
					end
				end

				arg_353_1.text_.text = var_356_11
				arg_353_1.typewritter.percent = 0

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320171", "320171085", "story_v_out_320171.awb") ~= 0 then
					local var_356_14 = manager.audio:GetVoiceLength("story_v_out_320171", "320171085", "story_v_out_320171.awb") / 1000

					if var_356_14 + var_356_8 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_14 + var_356_8
					end

					if var_356_10.prefab_name ~= "" and arg_353_1.actors_[var_356_10.prefab_name] ~= nil then
						local var_356_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_353_1.actors_[var_356_10.prefab_name].transform, "story_v_out_320171", "320171085", "story_v_out_320171.awb")

						arg_353_1:RecordAudio("320171085", var_356_15)
						arg_353_1:RecordAudio("320171085", var_356_15)
					else
						arg_353_1:AudioAction("play", "voice", "story_v_out_320171", "320171085", "story_v_out_320171.awb")
					end

					arg_353_1:RecordHistoryTalkVoice("story_v_out_320171", "320171085", "story_v_out_320171.awb")
				end

				arg_353_1:RecordContent(arg_353_1.text_.text)
			end

			local var_356_16 = math.max(var_356_9, arg_353_1.talkMaxDuration)

			if var_356_8 <= arg_353_1.time_ and arg_353_1.time_ < var_356_8 + var_356_16 then
				arg_353_1.typewritter.percent = (arg_353_1.time_ - var_356_8) / var_356_16

				arg_353_1.typewritter:SetDirty()
			end

			if arg_353_1.time_ >= var_356_8 + var_356_16 and arg_353_1.time_ < var_356_8 + var_356_16 + arg_356_0 then
				arg_353_1.typewritter.percent = 1

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(true)
			end
		end

		arg_353_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10045ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_353_1:InitPlayNodeList()
	end,
	Play320171086 = function(arg_357_0, arg_357_1)
		arg_357_1.time_ = 0
		arg_357_1.frameCnt_ = 0
		arg_357_1.state_ = "playing"
		arg_357_1.curTalkId_ = 320171086
		arg_357_1.duration_ = 10.67

		local var_357_0 = {
			zh = 10.666,
			ja = 7.3
		}
		local var_357_1 = manager.audio:GetLocalizationFlag()

		if var_357_0[var_357_1] ~= nil then
			arg_357_1.duration_ = var_357_0[var_357_1]
		end

		SetActive(arg_357_1.tipsGo_, false)

		function arg_357_1.onSingleLineFinish_()
			arg_357_1.onSingleLineUpdate_ = nil
			arg_357_1.onSingleLineFinish_ = nil
			arg_357_1.state_ = "waiting"
		end

		function arg_357_1.playNext_(arg_359_0)
			if arg_359_0 == 1 then
				arg_357_0:Play320171087(arg_357_1)
			end
		end

		function arg_357_1.onSingleLineUpdate_(arg_360_0)
			local var_360_0 = 0.975

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 then
				arg_357_1.talkMaxDuration = 0
				arg_357_1.dialogCg_.alpha = 1

				arg_357_1.dialog_:SetActive(true)
				SetActive(arg_357_1.leftNameGo_, true)

				arg_357_1.leftNameTxt_.text = arg_357_1:FormatText(StoryNameCfg[383].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_357_1.leftNameTxt_.transform)

				arg_357_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_357_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_357_1:RecordName(arg_357_1.leftNameTxt_.text)
				SetActive(arg_357_1.iconTrs_.gameObject, false)
				arg_357_1.callingController_:SetSelectedState("normal")

				local var_360_1 = arg_357_1:GetWordFromCfg(320171086)
				local var_360_2 = arg_357_1:FormatText(var_360_1.content)

				arg_357_1.text_.text = var_360_2

				LuaForUtil.ClearLinePrefixSymbol(arg_357_1.text_)

				local var_360_4 = 39 <= 0 and var_360_0 or var_360_0 * (utf8.len(var_360_2) / 39)

				if (39 <= 0 and var_360_0 or var_360_0 * (utf8.len(var_360_2) / 39)) > 0 and var_360_0 < var_360_4 then
					arg_357_1.talkMaxDuration = var_360_4

					if var_360_4 + 0 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_4 + 0
					end
				end

				arg_357_1.text_.text = var_360_2
				arg_357_1.typewritter.percent = 0

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320171", "320171086", "story_v_out_320171.awb") ~= 0 then
					local var_360_5 = manager.audio:GetVoiceLength("story_v_out_320171", "320171086", "story_v_out_320171.awb") / 1000

					if var_360_5 + 0 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_5 + 0
					end

					if var_360_1.prefab_name ~= "" and arg_357_1.actors_[var_360_1.prefab_name] ~= nil then
						local var_360_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_357_1.actors_[var_360_1.prefab_name].transform, "story_v_out_320171", "320171086", "story_v_out_320171.awb")

						arg_357_1:RecordAudio("320171086", var_360_6)
						arg_357_1:RecordAudio("320171086", var_360_6)
					else
						arg_357_1:AudioAction("play", "voice", "story_v_out_320171", "320171086", "story_v_out_320171.awb")
					end

					arg_357_1:RecordHistoryTalkVoice("story_v_out_320171", "320171086", "story_v_out_320171.awb")
				end

				arg_357_1:RecordContent(arg_357_1.text_.text)
			end

			local var_360_7 = math.max(var_360_0, arg_357_1.talkMaxDuration)

			if 0 <= arg_357_1.time_ and arg_357_1.time_ < 0 + var_360_7 then
				arg_357_1.typewritter.percent = (arg_357_1.time_ - 0) / var_360_7

				arg_357_1.typewritter:SetDirty()
			end

			if arg_357_1.time_ >= 0 + var_360_7 and arg_357_1.time_ < 0 + var_360_7 + arg_360_0 then
				arg_357_1.typewritter.percent = 1

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(true)
			end
		end

		arg_357_1.nodeConfigList_ = {}

		arg_357_1:InitPlayNodeList()
	end,
	Play320171087 = function(arg_361_0, arg_361_1)
		arg_361_1.time_ = 0
		arg_361_1.frameCnt_ = 0
		arg_361_1.state_ = "playing"
		arg_361_1.curTalkId_ = 320171087
		arg_361_1.duration_ = 14.37

		local var_361_0 = {
			zh = 10.7,
			ja = 14.366
		}
		local var_361_1 = manager.audio:GetLocalizationFlag()

		if var_361_0[var_361_1] ~= nil then
			arg_361_1.duration_ = var_361_0[var_361_1]
		end

		SetActive(arg_361_1.tipsGo_, false)

		function arg_361_1.onSingleLineFinish_()
			arg_361_1.onSingleLineUpdate_ = nil
			arg_361_1.onSingleLineFinish_ = nil
			arg_361_1.state_ = "waiting"
		end

		function arg_361_1.playNext_(arg_363_0)
			if arg_363_0 == 1 then
				arg_361_0:Play320171088(arg_361_1)
			end
		end

		function arg_361_1.onSingleLineUpdate_(arg_364_0)
			if 0 < arg_361_1.time_ and arg_361_1.time_ <= 0 + arg_364_0 and not isNil(arg_361_1.actors_["10037ui_story"]) and arg_361_1.var_.characterEffect10037ui_story == nil then
				arg_361_1.var_.characterEffect10037ui_story = arg_361_1.actors_["10037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_364_0 = 0.200000002980232

			if 0 <= arg_361_1.time_ and arg_361_1.time_ < 0 + var_364_0 and not isNil(arg_361_1.actors_["10037ui_story"]) then
				if arg_361_1.var_.characterEffect10037ui_story and not isNil(arg_361_1.actors_["10037ui_story"]) then
					arg_361_1.var_.characterEffect10037ui_story.fillFlat = true
					arg_361_1.var_.characterEffect10037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_361_1.time_ - 0) / var_364_0)
				end
			end

			if arg_361_1.time_ >= 0 + var_364_0 and arg_361_1.time_ < 0 + var_364_0 + arg_364_0 and not isNil(arg_361_1.actors_["10037ui_story"]) and arg_361_1.var_.characterEffect10037ui_story then
				arg_361_1.var_.characterEffect10037ui_story.fillFlat = true
				arg_361_1.var_.characterEffect10037ui_story.fillRatio = 0.5
			end

			local var_364_1 = 0
			local var_364_2 = 0.775

			if 0 < arg_361_1.time_ and arg_361_1.time_ <= var_364_1 + arg_364_0 then
				arg_361_1.talkMaxDuration = 0
				arg_361_1.dialogCg_.alpha = 1

				arg_361_1.dialog_:SetActive(true)
				SetActive(arg_361_1.leftNameGo_, true)

				arg_361_1.leftNameTxt_.text = arg_361_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_361_1.leftNameTxt_.transform)

				arg_361_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_361_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_361_1:RecordName(arg_361_1.leftNameTxt_.text)
				SetActive(arg_361_1.iconTrs_.gameObject, true)
				arg_361_1.iconController_:SetSelectedState("hero")

				arg_361_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_361_1.callingController_:SetSelectedState("normal")

				arg_361_1.keyicon_.color = Color.New(1, 1, 1)
				arg_361_1.icon_.color = Color.New(1, 1, 1)

				local var_364_3 = arg_361_1:GetWordFromCfg(320171087)
				local var_364_4 = arg_361_1:FormatText(var_364_3.content)

				arg_361_1.text_.text = var_364_4

				LuaForUtil.ClearLinePrefixSymbol(arg_361_1.text_)

				local var_364_6 = 31 <= 0 and var_364_2 or var_364_2 * (utf8.len(var_364_4) / 31)

				if (31 <= 0 and var_364_2 or var_364_2 * (utf8.len(var_364_4) / 31)) > 0 and var_364_2 < var_364_6 then
					arg_361_1.talkMaxDuration = var_364_6

					if var_364_6 + var_364_1 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_6 + var_364_1
					end
				end

				arg_361_1.text_.text = var_364_4
				arg_361_1.typewritter.percent = 0

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320171", "320171087", "story_v_out_320171.awb") ~= 0 then
					local var_364_7 = manager.audio:GetVoiceLength("story_v_out_320171", "320171087", "story_v_out_320171.awb") / 1000

					if var_364_7 + var_364_1 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_7 + var_364_1
					end

					if var_364_3.prefab_name ~= "" and arg_361_1.actors_[var_364_3.prefab_name] ~= nil then
						local var_364_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_361_1.actors_[var_364_3.prefab_name].transform, "story_v_out_320171", "320171087", "story_v_out_320171.awb")

						arg_361_1:RecordAudio("320171087", var_364_8)
						arg_361_1:RecordAudio("320171087", var_364_8)
					else
						arg_361_1:AudioAction("play", "voice", "story_v_out_320171", "320171087", "story_v_out_320171.awb")
					end

					arg_361_1:RecordHistoryTalkVoice("story_v_out_320171", "320171087", "story_v_out_320171.awb")
				end

				arg_361_1:RecordContent(arg_361_1.text_.text)
			end

			local var_364_9 = math.max(var_364_2, arg_361_1.talkMaxDuration)

			if var_364_1 <= arg_361_1.time_ and arg_361_1.time_ < var_364_1 + var_364_9 then
				arg_361_1.typewritter.percent = (arg_361_1.time_ - var_364_1) / var_364_9

				arg_361_1.typewritter:SetDirty()
			end

			if arg_361_1.time_ >= var_364_1 + var_364_9 and arg_361_1.time_ < var_364_1 + var_364_9 + arg_364_0 then
				arg_361_1.typewritter.percent = 1

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(true)
			end
		end

		arg_361_1.nodeConfigList_ = {}

		arg_361_1:InitPlayNodeList()
	end,
	Play320171088 = function(arg_365_0, arg_365_1)
		arg_365_1.time_ = 0
		arg_365_1.frameCnt_ = 0
		arg_365_1.state_ = "playing"
		arg_365_1.curTalkId_ = 320171088
		arg_365_1.duration_ = 19.3

		local var_365_0 = {
			zh = 11.566,
			ja = 19.3
		}
		local var_365_1 = manager.audio:GetLocalizationFlag()

		if var_365_0[var_365_1] ~= nil then
			arg_365_1.duration_ = var_365_0[var_365_1]
		end

		SetActive(arg_365_1.tipsGo_, false)

		function arg_365_1.onSingleLineFinish_()
			arg_365_1.onSingleLineUpdate_ = nil
			arg_365_1.onSingleLineFinish_ = nil
			arg_365_1.state_ = "waiting"
		end

		function arg_365_1.playNext_(arg_367_0)
			if arg_367_0 == 1 then
				arg_365_0:Play320171089(arg_365_1)
			end
		end

		function arg_365_1.onSingleLineUpdate_(arg_368_0)
			local var_368_0 = 0.9

			if 0 < arg_365_1.time_ and arg_365_1.time_ <= 0 + arg_368_0 then
				arg_365_1.talkMaxDuration = 0
				arg_365_1.dialogCg_.alpha = 1

				arg_365_1.dialog_:SetActive(true)
				SetActive(arg_365_1.leftNameGo_, true)

				arg_365_1.leftNameTxt_.text = arg_365_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_365_1.leftNameTxt_.transform)

				arg_365_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_365_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_365_1:RecordName(arg_365_1.leftNameTxt_.text)
				SetActive(arg_365_1.iconTrs_.gameObject, true)
				arg_365_1.iconController_:SetSelectedState("hero")

				arg_365_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_365_1.callingController_:SetSelectedState("normal")

				arg_365_1.keyicon_.color = Color.New(1, 1, 1)
				arg_365_1.icon_.color = Color.New(1, 1, 1)

				local var_368_1 = arg_365_1:GetWordFromCfg(320171088)
				local var_368_2 = arg_365_1:FormatText(var_368_1.content)

				arg_365_1.text_.text = var_368_2

				LuaForUtil.ClearLinePrefixSymbol(arg_365_1.text_)

				local var_368_4 = 36 <= 0 and var_368_0 or var_368_0 * (utf8.len(var_368_2) / 36)

				if (36 <= 0 and var_368_0 or var_368_0 * (utf8.len(var_368_2) / 36)) > 0 and var_368_0 < var_368_4 then
					arg_365_1.talkMaxDuration = var_368_4

					if var_368_4 + 0 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_4 + 0
					end
				end

				arg_365_1.text_.text = var_368_2
				arg_365_1.typewritter.percent = 0

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320171", "320171088", "story_v_out_320171.awb") ~= 0 then
					local var_368_5 = manager.audio:GetVoiceLength("story_v_out_320171", "320171088", "story_v_out_320171.awb") / 1000

					if var_368_5 + 0 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_5 + 0
					end

					if var_368_1.prefab_name ~= "" and arg_365_1.actors_[var_368_1.prefab_name] ~= nil then
						local var_368_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_365_1.actors_[var_368_1.prefab_name].transform, "story_v_out_320171", "320171088", "story_v_out_320171.awb")

						arg_365_1:RecordAudio("320171088", var_368_6)
						arg_365_1:RecordAudio("320171088", var_368_6)
					else
						arg_365_1:AudioAction("play", "voice", "story_v_out_320171", "320171088", "story_v_out_320171.awb")
					end

					arg_365_1:RecordHistoryTalkVoice("story_v_out_320171", "320171088", "story_v_out_320171.awb")
				end

				arg_365_1:RecordContent(arg_365_1.text_.text)
			end

			local var_368_7 = math.max(var_368_0, arg_365_1.talkMaxDuration)

			if 0 <= arg_365_1.time_ and arg_365_1.time_ < 0 + var_368_7 then
				arg_365_1.typewritter.percent = (arg_365_1.time_ - 0) / var_368_7

				arg_365_1.typewritter:SetDirty()
			end

			if arg_365_1.time_ >= 0 + var_368_7 and arg_365_1.time_ < 0 + var_368_7 + arg_368_0 then
				arg_365_1.typewritter.percent = 1

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(true)
			end
		end

		arg_365_1.nodeConfigList_ = {}

		arg_365_1:InitPlayNodeList()
	end,
	Play320171089 = function(arg_369_0, arg_369_1)
		arg_369_1.time_ = 0
		arg_369_1.frameCnt_ = 0
		arg_369_1.state_ = "playing"
		arg_369_1.curTalkId_ = 320171089
		arg_369_1.duration_ = 5.8

		local var_369_0 = {
			zh = 5.8,
			ja = 5.5
		}
		local var_369_1 = manager.audio:GetLocalizationFlag()

		if var_369_0[var_369_1] ~= nil then
			arg_369_1.duration_ = var_369_0[var_369_1]
		end

		SetActive(arg_369_1.tipsGo_, false)

		function arg_369_1.onSingleLineFinish_()
			arg_369_1.onSingleLineUpdate_ = nil
			arg_369_1.onSingleLineFinish_ = nil
			arg_369_1.state_ = "waiting"
		end

		function arg_369_1.playNext_(arg_371_0)
			if arg_371_0 == 1 then
				arg_369_0:Play320171090(arg_369_1)
			end
		end

		function arg_369_1.onSingleLineUpdate_(arg_372_0)
			local var_372_0 = 0.3

			if 0 < arg_369_1.time_ and arg_369_1.time_ <= 0 + arg_372_0 then
				arg_369_1.talkMaxDuration = 0
				arg_369_1.dialogCg_.alpha = 1

				arg_369_1.dialog_:SetActive(true)
				SetActive(arg_369_1.leftNameGo_, true)

				arg_369_1.leftNameTxt_.text = arg_369_1:FormatText(StoryNameCfg[1049].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_369_1.leftNameTxt_.transform)

				arg_369_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_369_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_369_1:RecordName(arg_369_1.leftNameTxt_.text)
				SetActive(arg_369_1.iconTrs_.gameObject, true)
				arg_369_1.iconController_:SetSelectedState("hero")

				arg_369_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10130")

				arg_369_1.callingController_:SetSelectedState("normal")

				arg_369_1.keyicon_.color = Color.New(1, 1, 1)
				arg_369_1.icon_.color = Color.New(1, 1, 1)

				local var_372_1 = arg_369_1:GetWordFromCfg(320171089)
				local var_372_2 = arg_369_1:FormatText(var_372_1.content)

				arg_369_1.text_.text = var_372_2

				LuaForUtil.ClearLinePrefixSymbol(arg_369_1.text_)

				local var_372_4 = 12 <= 0 and var_372_0 or var_372_0 * (utf8.len(var_372_2) / 12)

				if (12 <= 0 and var_372_0 or var_372_0 * (utf8.len(var_372_2) / 12)) > 0 and var_372_0 < var_372_4 then
					arg_369_1.talkMaxDuration = var_372_4

					if var_372_4 + 0 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_4 + 0
					end
				end

				arg_369_1.text_.text = var_372_2
				arg_369_1.typewritter.percent = 0

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320171", "320171089", "story_v_out_320171.awb") ~= 0 then
					local var_372_5 = manager.audio:GetVoiceLength("story_v_out_320171", "320171089", "story_v_out_320171.awb") / 1000

					if var_372_5 + 0 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_5 + 0
					end

					if var_372_1.prefab_name ~= "" and arg_369_1.actors_[var_372_1.prefab_name] ~= nil then
						local var_372_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_369_1.actors_[var_372_1.prefab_name].transform, "story_v_out_320171", "320171089", "story_v_out_320171.awb")

						arg_369_1:RecordAudio("320171089", var_372_6)
						arg_369_1:RecordAudio("320171089", var_372_6)
					else
						arg_369_1:AudioAction("play", "voice", "story_v_out_320171", "320171089", "story_v_out_320171.awb")
					end

					arg_369_1:RecordHistoryTalkVoice("story_v_out_320171", "320171089", "story_v_out_320171.awb")
				end

				arg_369_1:RecordContent(arg_369_1.text_.text)
			end

			local var_372_7 = math.max(var_372_0, arg_369_1.talkMaxDuration)

			if 0 <= arg_369_1.time_ and arg_369_1.time_ < 0 + var_372_7 then
				arg_369_1.typewritter.percent = (arg_369_1.time_ - 0) / var_372_7

				arg_369_1.typewritter:SetDirty()
			end

			if arg_369_1.time_ >= 0 + var_372_7 and arg_369_1.time_ < 0 + var_372_7 + arg_372_0 then
				arg_369_1.typewritter.percent = 1

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(true)
			end
		end

		arg_369_1.nodeConfigList_ = {}

		arg_369_1:InitPlayNodeList()
	end,
	Play320171090 = function(arg_373_0, arg_373_1)
		arg_373_1.time_ = 0
		arg_373_1.frameCnt_ = 0
		arg_373_1.state_ = "playing"
		arg_373_1.curTalkId_ = 320171090
		arg_373_1.duration_ = 5

		SetActive(arg_373_1.tipsGo_, false)

		function arg_373_1.onSingleLineFinish_()
			arg_373_1.onSingleLineUpdate_ = nil
			arg_373_1.onSingleLineFinish_ = nil
			arg_373_1.state_ = "waiting"
		end

		function arg_373_1.playNext_(arg_375_0)
			if arg_375_0 == 1 then
				arg_373_0:Play320171091(arg_373_1)
			end
		end

		function arg_373_1.onSingleLineUpdate_(arg_376_0)
			if 0 < arg_373_1.time_ and arg_373_1.time_ <= 0 + arg_376_0 then
				arg_373_1.var_.moveOldPos10037ui_story = arg_373_1.actors_["10037ui_story"].transform.localPosition
			end

			local var_376_0 = 0.001

			if 0 <= arg_373_1.time_ and arg_373_1.time_ < 0 + var_376_0 then
				arg_373_1.actors_["10037ui_story"].transform.localPosition = Vector3.Lerp(arg_373_1.var_.moveOldPos10037ui_story, Vector3.New(0, 100, 0), (arg_373_1.time_ - 0) / var_376_0)
				arg_373_1.actors_["10037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_373_1.actors_["10037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_373_1.actors_["10037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_373_1.actors_["10037ui_story"].transform.position).z)
				arg_373_1.actors_["10037ui_story"].transform.localEulerAngles.z = 0
				arg_373_1.actors_["10037ui_story"].transform.localEulerAngles.x = 0
				arg_373_1.actors_["10037ui_story"].transform.localEulerAngles = arg_373_1.actors_["10037ui_story"].transform.localEulerAngles
			end

			if arg_373_1.time_ >= 0 + var_376_0 and arg_373_1.time_ < 0 + var_376_0 + arg_376_0 then
				arg_373_1.actors_["10037ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_373_1.actors_["10037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_373_1.actors_["10037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_373_1.actors_["10037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_373_1.actors_["10037ui_story"].transform.position).z)
				arg_373_1.actors_["10037ui_story"].transform.localEulerAngles.z = 0
				arg_373_1.actors_["10037ui_story"].transform.localEulerAngles.x = 0
				arg_373_1.actors_["10037ui_story"].transform.localEulerAngles = arg_373_1.actors_["10037ui_story"].transform.localEulerAngles
			end

			local var_376_1 = arg_373_1.actors_["10037ui_story"]

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= 0 + arg_376_0 and not isNil(var_376_1) and arg_373_1.var_.characterEffect10037ui_story == nil then
				arg_373_1.var_.characterEffect10037ui_story = var_376_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_376_2 = 0.200000002980232

			if 0 <= arg_373_1.time_ and arg_373_1.time_ < 0 + var_376_2 and not isNil(var_376_1) then
				if arg_373_1.var_.characterEffect10037ui_story and not isNil(var_376_1) then
					arg_373_1.var_.characterEffect10037ui_story.fillFlat = true
					arg_373_1.var_.characterEffect10037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_373_1.time_ - 0) / var_376_2)
				end
			end

			if arg_373_1.time_ >= 0 + var_376_2 and arg_373_1.time_ < 0 + var_376_2 + arg_376_0 and not isNil(var_376_1) and arg_373_1.var_.characterEffect10037ui_story then
				arg_373_1.var_.characterEffect10037ui_story.fillFlat = true
				arg_373_1.var_.characterEffect10037ui_story.fillRatio = 0.5
			end

			local var_376_3 = 0
			local var_376_4 = 0.925

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= var_376_3 + arg_376_0 then
				arg_373_1.talkMaxDuration = 0
				arg_373_1.dialogCg_.alpha = 1

				arg_373_1.dialog_:SetActive(true)
				SetActive(arg_373_1.leftNameGo_, false)

				arg_373_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_373_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_373_1:RecordName(arg_373_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_373_1.iconTrs_.gameObject, false)
				arg_373_1.callingController_:SetSelectedState("normal")

				local var_376_5 = arg_373_1:FormatText(arg_373_1:GetWordFromCfg(320171090).content)

				arg_373_1.text_.text = var_376_5

				LuaForUtil.ClearLinePrefixSymbol(arg_373_1.text_)

				local var_376_7 = 37 <= 0 and var_376_4 or var_376_4 * (utf8.len(var_376_5) / 37)

				if (37 <= 0 and var_376_4 or var_376_4 * (utf8.len(var_376_5) / 37)) > 0 and var_376_4 < var_376_7 then
					arg_373_1.talkMaxDuration = var_376_7

					if var_376_7 + var_376_3 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_7 + var_376_3
					end
				end

				arg_373_1.text_.text = var_376_5
				arg_373_1.typewritter.percent = 0

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(false)
				arg_373_1:RecordContent(arg_373_1.text_.text)
			end

			local var_376_8 = math.max(var_376_4, arg_373_1.talkMaxDuration)

			if var_376_3 <= arg_373_1.time_ and arg_373_1.time_ < var_376_3 + var_376_8 then
				arg_373_1.typewritter.percent = (arg_373_1.time_ - var_376_3) / var_376_8

				arg_373_1.typewritter:SetDirty()
			end

			if arg_373_1.time_ >= var_376_3 + var_376_8 and arg_373_1.time_ < var_376_3 + var_376_8 + arg_376_0 then
				arg_373_1.typewritter.percent = 1

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(true)
			end
		end

		arg_373_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_373_1:InitPlayNodeList()
	end,
	Play320171091 = function(arg_377_0, arg_377_1)
		arg_377_1.time_ = 0
		arg_377_1.frameCnt_ = 0
		arg_377_1.state_ = "playing"
		arg_377_1.curTalkId_ = 320171091
		arg_377_1.duration_ = 8.5

		local var_377_0 = {
			zh = 4.933,
			ja = 8.5
		}
		local var_377_1 = manager.audio:GetLocalizationFlag()

		if var_377_0[var_377_1] ~= nil then
			arg_377_1.duration_ = var_377_0[var_377_1]
		end

		SetActive(arg_377_1.tipsGo_, false)

		function arg_377_1.onSingleLineFinish_()
			arg_377_1.onSingleLineUpdate_ = nil
			arg_377_1.onSingleLineFinish_ = nil
			arg_377_1.state_ = "waiting"
			arg_377_1.auto_ = false
		end

		function arg_377_1.playNext_(arg_379_0)
			arg_377_1.onStoryFinished_()
		end

		function arg_377_1.onSingleLineUpdate_(arg_380_0)
			local var_380_0 = 0.15

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= 0 + arg_380_0 then
				arg_377_1.talkMaxDuration = 0
				arg_377_1.dialogCg_.alpha = 1

				arg_377_1.dialog_:SetActive(true)
				SetActive(arg_377_1.leftNameGo_, true)

				arg_377_1.leftNameTxt_.text = arg_377_1:FormatText(StoryNameCfg[1049].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_377_1.leftNameTxt_.transform)

				arg_377_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_377_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_377_1:RecordName(arg_377_1.leftNameTxt_.text)
				SetActive(arg_377_1.iconTrs_.gameObject, true)
				arg_377_1.iconController_:SetSelectedState("hero")

				arg_377_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10130")

				arg_377_1.callingController_:SetSelectedState("normal")

				arg_377_1.keyicon_.color = Color.New(1, 1, 1)
				arg_377_1.icon_.color = Color.New(1, 1, 1)

				local var_380_1 = arg_377_1:GetWordFromCfg(320171091)
				local var_380_2 = arg_377_1:FormatText(var_380_1.content)

				arg_377_1.text_.text = var_380_2

				LuaForUtil.ClearLinePrefixSymbol(arg_377_1.text_)

				local var_380_4 = 6 <= 0 and var_380_0 or var_380_0 * (utf8.len(var_380_2) / 6)

				if (6 <= 0 and var_380_0 or var_380_0 * (utf8.len(var_380_2) / 6)) > 0 and var_380_0 < var_380_4 then
					arg_377_1.talkMaxDuration = var_380_4

					if var_380_4 + 0 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_4 + 0
					end
				end

				arg_377_1.text_.text = var_380_2
				arg_377_1.typewritter.percent = 0

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320171", "320171091", "story_v_out_320171.awb") ~= 0 then
					local var_380_5 = manager.audio:GetVoiceLength("story_v_out_320171", "320171091", "story_v_out_320171.awb") / 1000

					if var_380_5 + 0 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_5 + 0
					end

					if var_380_1.prefab_name ~= "" and arg_377_1.actors_[var_380_1.prefab_name] ~= nil then
						local var_380_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_377_1.actors_[var_380_1.prefab_name].transform, "story_v_out_320171", "320171091", "story_v_out_320171.awb")

						arg_377_1:RecordAudio("320171091", var_380_6)
						arg_377_1:RecordAudio("320171091", var_380_6)
					else
						arg_377_1:AudioAction("play", "voice", "story_v_out_320171", "320171091", "story_v_out_320171.awb")
					end

					arg_377_1:RecordHistoryTalkVoice("story_v_out_320171", "320171091", "story_v_out_320171.awb")
				end

				arg_377_1:RecordContent(arg_377_1.text_.text)
			end

			local var_380_7 = math.max(var_380_0, arg_377_1.talkMaxDuration)

			if 0 <= arg_377_1.time_ and arg_377_1.time_ < 0 + var_380_7 then
				arg_377_1.typewritter.percent = (arg_377_1.time_ - 0) / var_380_7

				arg_377_1.typewritter:SetDirty()
			end

			if arg_377_1.time_ >= 0 + var_380_7 and arg_377_1.time_ < 0 + var_380_7 + arg_380_0 then
				arg_377_1.typewritter.percent = 1

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(true)
			end
		end

		arg_377_1.nodeConfigList_ = {}

		arg_377_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/L01f",
		"TextureConfig/Background/XS0105",
		"TextureConfig/Background/L07i",
		"TextureConfig/Background/J07g"
	},
	voices = {
		"story_v_out_320171.awb"
	}
}
